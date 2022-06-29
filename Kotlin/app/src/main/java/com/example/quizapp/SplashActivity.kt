package com.example.quizapp

import android.annotation.SuppressLint
import android.content.Intent
import android.graphics.Color
import android.graphics.Typeface
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.TextView
import androidx.core.content.ContextCompat
import kotlinx.android.synthetic.main.activity_splash.progressBar
import kotlinx.android.synthetic.main.activity_splash.tv_option_four
import kotlinx.android.synthetic.main.activity_splash.tv_option_one
import kotlinx.android.synthetic.main.activity_splash.tv_option_three
import kotlinx.android.synthetic.main.activity_splash.tv_option_two
import kotlinx.android.synthetic.main.activity_splash.tv_progess
import kotlinx.android.synthetic.main.activity_splash.tv_question
import kotlinx.android.synthetic.main.activity_splash.btn_finish
import kotlinx.android.synthetic.main.activity_splash.*

@Suppress("DEPRECATION")
class SplashActivity : AppCompatActivity(), View.OnClickListener {

    private var mCurrentPosition: Int = 1
    private var mQuestionList: ArrayList<Question>? = null
    private var mSelectedOptionPosition: Int = 0
    private var mChoiseList: IntArray  = IntArray(10)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_FULLSCREEN

        btn_finish.setOnClickListener(this)
        btn_next.setOnClickListener(this)

        mQuestionList = Constants.getQuestions()
        mChoiseList = intent.getIntArrayExtra("choiseData")!!
        setQuestion()
    }

    @SuppressLint("SetTextI18n")
    private fun setQuestion(){

        val question = mQuestionList!![mCurrentPosition-1]
        mSelectedOptionPosition = mChoiseList[mCurrentPosition-1]
        checkanswer()
        progressBar.progress = mCurrentPosition
        tv_progess.text = "$mCurrentPosition" + "/" + progressBar.max
        tv_question.text = question.question
        tv_option_one.text = question.optionOne
        tv_option_two.text = question.optionTwo
        tv_option_three.text = question.optionThree
        tv_option_four.text = question.optionFour
    }



    override fun onClick(v: View?) {
        when(v?.id){
            R.id.btn_finish ->{
                startActivity(Intent(this, MainActivity::class.java))
                finish()
            }
            R.id.btn_next->{
                defaultOptionView()
                mCurrentPosition ++
                when{
                    mCurrentPosition <= mQuestionList!!.size
                    ->{
                        setQuestion()
                    }else->{
                    startActivity(Intent(this, MainActivity::class.java))
                    finish()
                }
                }
            }
        }
    }

    private fun defaultOptionView(){
        val options = ArrayList<TextView>()
        options.add(0, tv_option_one)
        options.add(1, tv_option_two)
        options.add(2, tv_option_three)
        options.add(3,tv_option_four)

        for(option in options){
            option.setTextColor(Color.parseColor("#7A8089"))
            option.typeface = Typeface.DEFAULT
            option.background = ContextCompat.getDrawable(
                this,
                R.drawable.defult_option_border_bg
            )
        }
    }


    private fun answerView(answer: Int, drawableView: Int){
        when(answer){
            1->{
                tv_option_one.background = ContextCompat.getDrawable(
                    this, drawableView
                )
            }
            2->{
                tv_option_two.background = ContextCompat.getDrawable(
                    this, drawableView
                )
            }
            3->{
                tv_option_three.background = ContextCompat.getDrawable(
                    this, drawableView
                )
            }
            4->{
                tv_option_four.background = ContextCompat.getDrawable(
                    this, drawableView
                )
            }
        }
    }

    private fun checkanswer(){
        val question = mQuestionList?.get(mCurrentPosition - 1)
        if(question!!.correctAnswer != mSelectedOptionPosition){
            answerView(mSelectedOptionPosition , R.drawable.wrong_option_border_bg)
        }
        answerView(question.correctAnswer, R.drawable.correct_option_border_bg)

    }

}