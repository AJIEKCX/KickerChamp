package ru.kontur.kickerchamp

class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}!"
    }
}