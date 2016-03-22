[![Build Status](https://img.shields.io/travis/GabrielMassana/Comic/master.svg?style=flat-square)](https://travis-ci.org/GabrielMassana/Comic)

# Comic

Marvel Comic API

# How and why

### Marvel API endpoint

The main decision was to know which of the six Marvel API endpoint I was going to use. I took in consideration:

- A limit of API calls per day.
- No way to search through the API.
- The necessity of having as quick as possible all the data downloaded into the device.

Checked the quantity of the entries for every endpoint, I decided to use one of the smallest ones: Characters. This endpoint has around 1500 files. Every call to the API sends back a response with 20 characters. That means that with only 75 API calls the app can have all the data downloaded.

### Rabbit hole

The API is built as a rabbit hole. It is possible to start in a character, then call for the comics of this character, then the creators of a comic, and so on. 

I decided to do not allow the rabbit hole navigation inside this app. That means, I'm only parsing the data related to the character and do not saving the rest.

### API bug

After a certain number of API requests, the response from the Marvel API becomes of an empty array without data.

This is probably because the API has some limit of calls protection.

To handle with this problem I stopped the downloading of the character's data after a failure. It is possible to restart the fetching of the data one hour after the failure opening the app again. 

Because of this bug, it is really difficult to download the whole characters database into the phone.

### Unit Test

I added some tests to the project. I know they are a really small part of the tests that can be added to this project, but they are only trying to be a small example of how powerful they are.

In fact, during the inclusion of the tests, I was able to discover some bugs on the parsers of the app.

### Continuous Integration

The project is integrated with [Travis-CI](https://travis-ci.org/GabrielMassana/Comic) as Continuous Integration to automate the build and test of the project.

### Using my own Pods

I used four of [my own pods in Cocoapods](https://cocoapods.org/owners/10374).   
   
- **CoreDataFullStack**. A project to simplify the use of Core Data.
- **CoreOperation**. Small wrapper project to simplify `NSOperation` and `NSOperationQueue`.
- **CoreNetworking**. A small project that simplifies NSURLSession.
- **ButtonBackgroundColor**. Category to handle the background color of a UIButton in normal and highlighted state.
	
### Third party Pods

- **[PureLayout](https://cocoapods.org/pods/PureLayout)**. An easy and powerfull pod that helps a lot using auto-layout.
- **[ConvenientFileManager](https://cocoapods.org/pods/ConvenientFileManager)**. A suite of categories to ease using NSFileManager for common tasks. 

### The app meets all the requirements 

#### Requirements

- Create an iOS application that communicates with the Public Marvel API and meets the following requirements:
  - As a user I want to see a list/collection of items from the Marvel API 
  - As a user I want to search or filter the contents of this list/collection 
  - As a user I want to see the full details of any item from this list/collection
- Use Swift 2 to develop the entire app 
- Store the project in your public Github account
- Focus on showing your programming skills and feel free to use 3rd party libraries

### The app also meets some of the extra requirements

#### Bonus Points

- Performance
- Unit Tests
- Documentation
- Nice little big details
