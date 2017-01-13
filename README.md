# Phorum
This is a demo project to showcase making a iOS application for the USC computer science club [Scope](http://scopeusc.com). 

##Concept
Phorum is an event based photo sharing application. Seemlessly share photos with friends through creating events. Users can be invited to events 
via an easy event code. All users in the event share a common photo space. 

##Technology 
- Swift is used to program the front end of the application. 
- [Firebase](https://firebase.google.com/) provides the backend storage and database technology.
- [Twitter Digits](https://get.digits.com/) for user authentication.

This project also uses the following Pods:
- [SwiftySpinne](https://github.com/icanzilb/SwiftSpinner)
- [SwiftyGif](https://github.com/kirualex/SwiftyGif)

##Installation
This repository does not contain the proper authentication keys for Firebase or the Twitter Fabric platform to run the project. 
Insert your own authentication keys for Firebase and Twitter Digits to run the project. 

The instructions for updating the project with the proper Digits credentials can be found [here](https://fabric.io/kits/ios/digits/install)

The instructions for setting up Firebase in the app can be found [here](https://firebase.google.com/docs/ios/setup)

In addition to installing the proper credentials ensure the necessary pods are installed by running pod install in the root directory of the project.
