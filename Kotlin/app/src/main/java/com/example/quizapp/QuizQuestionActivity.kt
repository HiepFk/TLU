package com.example.quizapp

import android.annotation.SuppressLint
import android.content.Intent
import android.graphics.Color
import android.graphics.Typeface
import android.os.Bundle
import android.os.CountDownTimer
import android.view.View
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import kotlinx.android.synthetic.main.activity_quiz_question.*
import java.util.*
import kotlin.collections.ArrayList

@Suppress("DEPRECATION")
class QuizQuestionActivity : AppCompatActivity(), View.OnClickListener {

    private var mCurrentPosition: Int = 1
    private var mQuestionList: ArrayList<Question>? = null
    private var mSelectedOptionPosition: Int = 0
    private var mCorrectAnswers: Int = 0
    private var mUserName: String ?= null
    private lateinit var countDownTimer : CountDownTimer
    private var timeLeftInMillis: Long = 20000
    private var mChoiseList: IntArray = IntArray(10)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_quiz_question)

        window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_FULLSCREEN

        mUserName = intent.getStringExtra(Constants.USER_NAME)

        mQuestionList = Constants.getQuestions()
        setQuestion()

        tv_option_one.setOnClickListener(this)
        tv_option_two.setOnClickListener(this)
        tv_option_three.setOnClickListener(this)
        tv_option_four.setOnClickListener(this)
    }

    @SuppressLint("SetTextI18n")
    private fun setQuestion(){

        val question = mQuestionList!![mCurrentPosition-1]

        defaultOptionView()

        progressBar.progress = mCurrentPosition
        tv_progess.text = "$mCurrentPosition" + "/" + progressBar.max

        tv_question.text = question.question
        tv_option_one.text = question.optionOne
        tv_option_two.text = question.optionTwo
        tv_option_three.text = question.optionThree
        tv_option_four.text = question.optionFour
        btn_submit.setOnClickListener(this)

        startCountDown()
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

    override fun onClick(v: View?) {
        when(v?.id){
            R.id.tv_option_one ->{
                selectedOptionView(tv_option_one,1)
                mChoiseList[mCurrentPosition-1] = 1
            }
            R.id.tv_option_two ->{
                selectedOptionView(tv_option_two,2)
                mChoiseList[mCurrentPosition -1] = 2
            }
            R.id.tv_option_three ->{
                selectedOptionView(tv_option_three,3)
                mChoiseList[mCurrentPosition -1] = 3
            }
            R.id.tv_option_four ->{
                selectedOptionView(tv_option_four,4)
                mChoiseList[mCurrentPosition -1] = 4
            }
            R.id.btn_submit->{
                checkanswer()
                mCurrentPosition ++
                when{
                    mCurrentPosition <= mQuestionList!!.size
                    ->{
                        setQuestion()
                    }else->{
                    val intent = Intent(this, ResultActivity::class.java)
                    intent.putExtra(Constants.USER_NAME,mUserName)
                    intent.putExtra(Constants.CORRECT_ANSWER, mCorrectAnswers)
                    intent.putExtra(Constants.TOTAL_QUESTIONS, mQuestionList!!.size)
                    intent.putExtra("data", mChoiseList)
                    startActivity(intent)
                    finish()
                }
                }
                if(timeLeftInMillis <=0) {
                    val intent = Intent(this, ResultActivity::class.java)
                    intent.putExtra(Constants.USER_NAME,mUserName)
                    intent.putExtra(Constants.CORRECT_ANSWER, mCorrectAnswers)
                    intent.putExtra(Constants.TOTAL_QUESTIONS, mQuestionList!!.size)
                    intent.putExtra("data", mChoiseList)
                    startActivity(intent)
                    finish()
                }
            }
        }
    }

    private fun startCountDown() {
        countDownTimer = object : CountDownTimer(timeLeftInMillis, 1000) {
            override fun onTick(millisUntilFinished: Long) {
                timeLeftInMillis = millisUntilFinished
                updateCountDownText()
            }

            override fun onFinish() {
                timeLeftInMillis = 0
                checkanswer()
            }
        }.start()
    }

    private fun selectedOptionView(tv: TextView, selectedOptionNum: Int){
        defaultOptionView()
        mSelectedOptionPosition = selectedOptionNum

        tv.setTextColor(Color.parseColor("#363A43"))

        tv.setTypeface(tv.typeface, Typeface.BOLD)
        tv.background = ContextCompat.getDrawable(
            this@QuizQuestionActivity,
            R.drawable.selected_option_border_bg
        )
    }


    @SuppressLint("SetTextI18n")
    private fun checkanswer(){
        val question = mQuestionList?.get(mCurrentPosition - 1)
        countDownTimer.cancel()

        if(question!!.correctAnswer == mSelectedOptionPosition){
            mCorrectAnswers++
        }

        if (mCurrentPosition == mQuestionList!!.size || timeLeftInMillis <=0) {
            btn_submit.text = "FINISH"
            timer_text.text ="Hết giờ"
        }
    }

    private fun updateCountDownText() {
        val minutes = (timeLeftInMillis / 1000) / 60
        val seconds = (timeLeftInMillis / 1000) % 60
        val timeFormatted =
            java.lang.String.format(Locale.getDefault(), "%02d:%02d", minutes, seconds)
        timer_text.text = timeFormatted
        if (timeLeftInMillis < 10000) {
            timer_text.setTextColor(Color.RED)
        } else {
            timer_text.setTextColor(Color.parseColor("#363A43"))
        }
    }

}




