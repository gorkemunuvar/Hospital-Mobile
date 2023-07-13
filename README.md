# Hospital Mobile App

This project was intented to deliver as a freelance project but has been canceled by the client. Now, source code is here.

## About

It is a mobile application which users can perform any common action relevant to hospital appointments.

### Main Features

 - See the hospital news.
 - Search polyclinics.
 - Search doctors.
 - Take/cancel/see appointments.
 - Multi language support.
 - See hospital locations.

## Tech

During the development, there was and Oracle Database storing all needed data. That's why app communicates with a rest api written in Flask.

App <--> Rest Api <--> Oracle DB

You can reach the REST API [here](https://github.com/gorkemunuvar/Hostpital-Rest-Api/tree/main). 

Mainly MVC pattern is followed and GetX package is used for state management(not proud of it).
