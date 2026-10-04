package com.comp3074.lab2counter

import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {

    private var count = 0
    private var step = DEFAULT_STEP

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val outputLabel = findViewById<TextView>(R.id.textViewOutput)
        val stepLabel = findViewById<TextView>(R.id.textViewStep)
        val addButton = findViewById<Button>(R.id.buttonAdd)
        val subtractButton = findViewById<Button>(R.id.buttonSubtract)
        val resetButton = findViewById<Button>(R.id.buttonReset)
        val stepButton = findViewById<Button>(R.id.buttonStep)

        fun refreshUi() {
            outputLabel.text = count.toString()
            stepLabel.text = getString(R.string.step_value, step)
        }

        addButton.setOnClickListener {
            count += step
            refreshUi()
        }

        subtractButton.setOnClickListener {
            count -= step
            refreshUi()
        }

        resetButton.setOnClickListener {
            count = 0
            step = DEFAULT_STEP
            refreshUi()
        }

        stepButton.setOnClickListener {
            step = DOUBLE_STEP
            refreshUi()
        }

        refreshUi()
    }

    companion object {
        private const val DEFAULT_STEP = 1
        private const val DOUBLE_STEP = 2
    }
}
