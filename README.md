# redditApp
This application is a demo of the real reddit app. For this I use an api that they provide, it returns the top 10 popst of the day.

### Architecture.
To organize the application I use an architecture pattern (MVVM) without data binding (like a mvp), adding a services layer to keep the components uncluttered and with a single responsibility. I decided to do this, since the application didn't need to implement something more robust, it could fall in over engineering.

### Layers.
Views: 
    in this folder you will find the respective viewcontrollers with its .xib
ViewModels:
    In this folder you will find two viewmodels, each one in charge of the logic of its respective view.
Service: 
    In this folder you will find the class responsible for making the app's requests. (it can be improved...)
