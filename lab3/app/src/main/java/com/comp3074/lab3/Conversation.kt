package com.comp3074.lab3

import androidx.compose.foundation.background
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.comp3074.lab3.ui.theme.Lab3Theme

@Composable
fun Conversation(messages: List<Message>, modifier: Modifier = Modifier) {
    LazyColumn(
        modifier = modifier.background(MaterialTheme.colorScheme.background)
    ) {
        items(messages) { message ->
            MessageCard(message)
        }
    }
}

@Preview(showBackground = true, showSystemUi = true)
@Composable
fun PreviewConversation() {
    Lab3Theme {
        Conversation(SampleData.conversationSample)
    }
}
