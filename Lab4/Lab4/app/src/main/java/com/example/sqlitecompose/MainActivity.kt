package com.example.sqlitecompose

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import androidx.lifecycle.viewmodel.compose.viewModel
import com.example.sqlitecompose.data.AppDatabase
import com.example.sqlitecompose.ui.CustomerApp
import com.example.sqlitecompose.ui.CustomerViewModel
import com.example.sqlitecompose.ui.CustomerViewModelFactory

class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val database = AppDatabase.getDatabase(applicationContext)

        setContent {
            MaterialTheme {
                val viewModel: CustomerViewModel = viewModel(
                    factory = CustomerViewModelFactory(database.customerDao())
                )

                CustomerApp(viewModel)
            }
        }
    }
}
