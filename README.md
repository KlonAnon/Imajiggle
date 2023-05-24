# Imajiggle

## About
This is a flutter app programmed and tested to run on android 12 or higher (there's no guarantee for this app running on other platforms). The idea behind the app is to generate random images for boosting creativity.
It was created as a university project and my first flutter project. 

**Help is welcome!**  
If you want to contribute to this project, feel welcome to do so. I'd be glad to learn from any feedback or suggestions.
Please do so by opening an issue or a pull/merge request.
(I will accept pull/merge requests as soon as this project is graded)

## Development progress
Due to time constraints I unfortunately wasn't able to implement some important/nice features or to improve the apps performance even more by implementing some common principles.

### Features and Principles implemented
Features:
- The app generates random images that can be licked
- Licked images can be viewed in the gallery (liked images are stored on the devices storage)
- Licked images can be deleted
- By clicking an image it expands to a fullscreen view

Principles: 
- The images generated are in the jpeg format to reduce the image size (occupying less space on device, maintaining fast loading times)
- The app uses Material 3 Design for a good looking UI and a good user experience
- The UI is designed to minimize the number of tabs or interactions for common tasks
- Dialogs are used to notify the user about important information (No-Internet-Dialog) or to confirm critical requests (Delete-Confirmation-Dialog)
- Error messages are used to increase the user experience
- Images can't be liked while loading, a new Image cant be generated while loading
- Liked images are only saved as soon as "next" is clicked, the app is paused / inactive or the home screen is removed from the widget tree, thus reducing unnecessary memory accesses
- adaptive Layout (generated image adapts to fit the screen size, number of images per row in the gallery adapts to the screen size, navigation adapts to the screen size --> small scree = Bottom navigation bar, large screen = Navigation Rail)
- The saved images are fetched only once from memory and then cached inside a list, instead of fetching them over and over again
- generated and liked images are saved and directly added to the cache (list)
- The Gallery uses a GridView.builder to call the builder only for those children (images) that are actually visible, thus increasing the performance
- Checking for internet connection before making an api call to lorem picsum to avoid unexpected behavior and informing the user if necessary

### Features to be implemented
- History Screen: While there is already a history screen, it doesnt really do anything yet. The idea would be to display e.g. the last 10 generated images in a list by caching them
- Deleting multiple images: Making it possible to delete multiple images at once by selecting them in the gallery (for this most likely one would have to add some kind of Selection Mode/Selection State to the GalleryModel)
- Share liked images (while there is already a button for this, the logic is not implemented yet)
- Zoom in on pictures: Make it possible for the user to zoom in on pictures that have been generated or are stored in the gallery
- Adding Swiping mechanism to the gallery: When in the fullscreen mode of a picture in the gallery, make it possible to switch to the next picture by swiping right or left
- Adding Swiping mechanism to the generator screen: When in the fullscreen mode of the generated picture, make it possible to generate a new picture by swiping left
- Alternative liking: Make the Image likeable by double clicking it (this should be possible when in the fullscreen mode or the normal mode)
- Ask the user if he wants to keep his liked images when uninstalling the app

- Optional:
    - Instead of saving the images in the apps documents directory, save them in a folder inside the photos folder of the phone --> for this one would have to add the required permissions inside the AndroidManifest.xml
    - Adapt the apps color scheme to the color of the generated image

### Principles that could make this app more performant / efficient
- Lazy Loading: Right now all the images in the gallery are fetched and stored inside a list at once, the first time the user visits the gallery screen --> It would be more efficient to expand the list with only those images that are actually visible at the moment by dynamically loading images
- Image Thumbnails: Generate and display thumbnail versions of the liked images in the gallery view. Thumbnails are smaller, lower-resolution versions of images, which load faster and consume less memory. When a user selects a specific image, the full-resolution version gets loaded. The tradeoff would be that the app consumes more space on the devices storage
- Asynchronous Image Loading: Right now the images arent really fetched asynchronously from the device (although I tried implementing it), this would keep the app responsive and avoid potential blocking of the main thread
- Reduce network calls: One way to reduce the number of network calls when loading a random image would be to get not only one image as response with a network request, but several which then can be cached. (unfortunately lorem picsum doesn't have this option, but one could put a separate server in between that sends several requests and combines the responses into one) 

### Potential unhandeld problems
- The case of the device not having enough space for storing an image isn't handeld, this could be problematic especially at a large amount of stored images
- The list for caching images fetched from the devices storage has no limit of elements. This could potentially cause problems when handling a large amount of images and could cause excessive memory consumption (a solution to this problem would be implementing a recycling algorithm to release unused images from the list)

## Working on this project
If you wish to work on this project please follow these steps for setup and development. 
You can suggest changing or adding something to these guidelines.

### Setup: Start working on this project
- Make sure you have the latest version of flutter and dart installed (usually dart comes with the flutter installation)
- Also it's probably best to work with Visual Studio Code and the flutter and dart plugin.
- run `flutter pub get` to fetch and download the projects dependencies

### Some development guidelines
The file structure inside the lib folder is held fairly easy to understand:
- utils: Contains utility functions and helper classes used throughout the project
- widgets: Holds reusable UI components that can be used in different screens
- screens: Contains the main user interface screens of the application
- models: Defines the data models used in the application to represent entities and structures.
- navigation: Manages the navigation flow and routing between different screens

This app uses simple state management with ChangeNotifier and the Provider package. For an introduction to this approach visit [Flutter: Simple app state management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple). Also make sure you follow the defined linter rules inside the analysis_options.yaml.

Also please notice that there is an import order:
1. Dart Core Libraries
2. External Package Libraries
3. Project-specific imports:
    - models first
    - widgets second
    - utils third

### Building and testing the App
You can test the app by simply running it in debug mode (either with an emulator installed or a real phone pluged into your development device).  
If you want to build the app follow the steps provided on the flutter website: [Build and release an Android app](https://docs.flutter.dev/deployment/android#building-the-app-for-release). Or if you wish to quickly install the apk on a device run `flutter build apk --split-per-abi` and `flutter install` in the working directory while your phone pluged into the device you want to install the apk to.
