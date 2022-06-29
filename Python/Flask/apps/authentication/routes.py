# -*- encoding: utf-8 -*-
"""
Copyright (c) 2019 - present AppSeed.us
"""

from flask import render_template, redirect, request, url_for , Flask, request, jsonify
from flask_login import (
    current_user,
    login_user,
    logout_user,
)
# 
import os
from werkzeug.utils import secure_filename
from flask_cors import CORS
from apps.authentication.yolo import *
from datetime import datetime
from random import randint
# 

from numpy import empty

from apps import db, login_manager
from apps.authentication import blueprint
from apps.authentication.forms import LoginForm, CreateAccountForm
from apps.authentication.models import Users

from apps.authentication.util import verify_pass

import pandas as pd


@blueprint.route('/')
def route_default():
    return redirect(url_for('authentication_blueprint.login'))


# Login & Registration

@blueprint.route('/login', methods=['GET', 'POST'])
def login():
    login_form = LoginForm(request.form)
    if 'login' in request.form:

        # read form data
        username = request.form['username']
        password = request.form['password']

        # Locate user
        user = Users.query.filter_by(username=username).first()

        # Check the password
        if user and verify_pass(password, user.password):

            login_user(user)
            return redirect(url_for('authentication_blueprint.route_default'))

        # Something (user or pass) is not ok
        return render_template('accounts/login.html',
                               msg='Wrong user or password',
                               form=login_form)

    if not current_user.is_authenticated:
        return render_template('accounts/login.html',
                               form=login_form)
    return redirect(url_for('home_blueprint.index'))


@blueprint.route('/register', methods=['GET', 'POST'])
def register():
    create_account_form = CreateAccountForm(request.form)
    if 'register' in request.form:

        username = request.form['username']
        email = request.form['email']
        role = request.form['role']
        photo = request.form['photo']

        # Check usename exists
        user = Users.query.filter_by(username=username).first()
        if user:
            return render_template('accounts/register.html',
                                   msg='Username already registered',
                                   success=False,
                                   form=create_account_form)

        # Check email exists
        user = Users.query.filter_by(email=email).first()
        if user:
            return render_template('accounts/register.html',
                                   msg='Email already registered',
                                   success=False,
                                   form=create_account_form)

        # else we can create the user
        user = Users(**request.form)
        db.session.add(user)
        db.session.commit()

        return render_template('accounts/register.html',
                               msg='User created please <a href="/login">login</a>',
                               success=True,
                               form=create_account_form)

    else:
        return render_template('accounts/register.html', form=create_account_form)


@blueprint.route('/logout')
def logout():
    logout_user()
    return redirect(url_for('authentication_blueprint.login'))


@blueprint.route("/userprofile")
def userprofile():
    return render_template("accounts/userProfile.html", user=current_user)


dfDsLop = pd.read_csv(r"apps\authentication\advanced_python.csv", sep=';')


@blueprint.route("/listusers")
def listUsers():
    return render_template("accounts/listUsers.html", users=dfDsLop.iterrows(), length=len(dfDsLop.index), segment="listusers")


@blueprint.route("/queryusers")
def queryUsers():
    return render_template("accounts/queryUsers.html", segment="queryusers")


@blueprint.route("/resultqueryusers", methods=['POST', 'GET'])
def resultqueryusers():
    studentCode = dfDsLop[dfDsLop['student code'].str.upper(
    ).str.contains(request.form.get("Search").upper())]
    studentClass = dfDsLop[dfDsLop['CN'].str.upper().str.contains(
        request.form.get("Search").upper())]
    studentName = dfDsLop[dfDsLop['Last name'].str.upper().str.contains(
        request.form.get("Search").upper())]
    
    if(len(studentCode) !=0):
        result = studentCode
    if(len(studentClass) !=0):
        result = studentClass
    if(len(studentName) !=0):
        result = studentName
    return render_template("accounts/listUsers.html", users=result.iterrows(), length=len(result.index), segment="queryusers")



dfWinemag = pd.read_csv(
    r"apps\authentication\winemag-data-130k-v2.csv", index_col=0)


a=10
k= dfWinemag
@blueprint.route("/showwinemags", methods=['POST', 'GET'])
def show():
    global a ,k
    
    # Lọc theo giá or điểm
    if (request.form.get("Check")) :
        type = request.form.get("values")
        val1 = float(request.form.get("value1"))
        val2 = float(request.form.get("value2"))
        print(type, val1, val2)
        k= dfWinemag[dfWinemag[type].between(val1,val2)].reset_index()
        #d = df[(df['price']>=99 ) & (df['price']<=101)]
        # k = dfWinemag[dfWinemag['price'].between(10,20)].reset_index()
    
    # Lọc theo tên
    if (request.form.get('All')):
        k =dfWinemag
    if(request.form.get("Search")) :
        k = dfWinemag[dfWinemag['country'].str.upper().str.contains(request.form.get("Search").upper()).fillna(False)].reset_index()
    
    # Phân Trang
    if request.form.get("pagination1") == "First":
        a= 10
    elif request.form.get("pagination2") == "Previous":
        a= a-10
        if(a<10) :
            a=10  
    elif request.form.get("pagination3") == "Next":
        a= a+10
        if(a > len(k)) :
            a = len(k) // 10 * 10
    elif request.form.get("pagination4") == "End":    
        a= len(k) // 10 * 10
        page = a //10
        c= a%10
        return render_template("accounts/listWinemags.html", winemags=k.loc[range(a-10,a+c)].iterrows(), length=len(k.index), segment='showwinemags',page=page)
    
    page = a // 10
    
    return render_template("accounts/listWinemags.html", winemags=k.loc[range(a-10,a)].iterrows(), length=len(k.index), segment='showwinemags',page=page)




@blueprint.route("/chartwinemags", methods=['POST', 'GET'])
def bar():
    table =dfWinemag.groupby(['country'])['points'].mean().reset_index()
    a = request.args.get("values")
    b = request.args.get("groupby")
    c=100
    values = table.points
    if( a=='Point') : 
        if(b=='Max' ) :
            table = dfWinemag.groupby(['country'])['points'].max().reset_index()
        elif (b=='Min' ) :
            table = dfWinemag.groupby(['country'])['points'].min().reset_index()
        elif (b=='Count') :
            table = dfWinemag.groupby(['country'])['points'].count().reset_index()
            c=55000
        elif (b=='Sum') :
            table = dfWinemag.groupby(['country'])['points'].sum().reset_index()
            c=4830000
        elif (b=='Mean') :
            table = dfWinemag.groupby(['country'])['points'].mean().reset_index()
        values = table.points
            
    if( a=='Price') : 
        if(b=='Max') :
            table = dfWinemag.groupby(['country'])['price'].max().reset_index()
            c=3300
        elif (b=='Min' ) :
            table = dfWinemag.groupby(['country'])['price'].min().reset_index()
        elif (b=='Count') :
            c=55000
            table = dfWinemag.groupby(['country'])['price'].count().reset_index()
        elif (b=='Sum') :
            table = dfWinemag.groupby(['country'])['price'].sum().reset_index()
        elif (b=='Mean') :
            table = dfWinemag.groupby(['country'])['price'].mean().reset_index()
        values = table.price
        
    if not a and not b:
        a="point"
        b='mean'
        
    labels = table.country
    
    return render_template('accounts/chartWinemags.html', title= 'Biểu đồ ' +b+' '+ a + " các quốc gia", max=c, labels=labels, values=values,  set=zip(values, labels), segment="chartwinemags")

    
 
# ///////// 
app1 = Flask(__name__)
CORS(app1)
app1.config["uploads_dir"] = "apps\\static\\assets\\uploads"
app1.config["output_dir"] = "apps\\static\\assets\\output"
app1.config["display"] = "./../static/assets/output/"

@blueprint.route('/upload')
def index():
   
    return render_template("accounts/checkObject.html", segment="checkObject")
@blueprint.route('/preview', methods=['POST'])
def upload_image():
    try:
        os.mkdir(app1.config["uploads_dir"])
        os.mkdir(app1.config["output_dir"])
    except:
        pass
    if (request.form.get('Submit') == "Submit") :
        file = request.files['file']
        if not file:
            return {'error': 'Missing file'}, 400
    
        now = datetime.now()
        filename = now.strftime("%Y%m%d_%H%M%S") + "_" + str(randint(000, 999))
        file.save(os.path.join(app1.config["uploads_dir"], secure_filename(filename + '.jpg')))
        objects_count, objects_confidence = process(app1.config["uploads_dir"], app1.config["output_dir"], filename)
    
        response = {
            'objects_count': objects_count, 
            'objects_confidence': objects_confidence, 
            'filename': filename + '.jpg'
        }
       
        k = filename + '.jpg'
        url = os.path.join(app1.config["display"], k)
       
        print(url)
        return render_template("accounts/checkObject.html", segment="checkObject", url=url)

    return render_template("accounts/checkObject.html", segment="checkObject", url=url)
 
    
    
# Errors
@login_manager.unauthorized_handler
def unauthorized_handler():
    return render_template('home/page-403.html'), 403

@blueprint.errorhandler(403)
def access_forbidden(error):
    return render_template('home/page-403.html'), 403

@blueprint.errorhandler(404)
def not_found_error(error):
    return render_template('home/page-404.html'), 404

@blueprint.errorhandler(500)
def internal_error(error):
    return render_template('home/page-500.html'), 500





