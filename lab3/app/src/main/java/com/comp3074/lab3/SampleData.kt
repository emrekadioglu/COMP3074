package com.comp3074.lab3

object SampleData {
    private val conversation = listOf(
        Message("Joe", "Hi!"),
        Message("Jim", "How are you?"),
        Message("Joe", "Test..1..2..3"),
        Message("Joe", "I hate coding!!!")
    )

    val conversationSample: List<Message> = List(3) { conversation }.flatten()
}
