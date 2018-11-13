# Web Browser

## Language, Editor and Platform versions used in this project:
* **Language:** Swift 4.2
* **Platform:** iOS 12
* **Editor**: Xcode 10

## Sample Project Details
**Create a simple browser. App will have only 2 Screen as follows**

1. Screen 1 - Web Browser
    * This whole screen will Show the webpage in Webview.
    * At top of the screen their will be a text field & a go button where user can enter search text or url. If it is url then display that webpage and If it is a search string then show google search results page with query as search string.
    * At bottom of the screen There will be 3 buttons. Back, Forward & Bookmark. On pressing bookmark The Page should be Bookmarked.

2. Screen 2 - All Bookmarks

    * From Screen 1 use can navigate to this Page via menu item.

    * This page should show all the bookmarked pages. If a user tap on any bookmark then that link will open in Screen 1. **NOTE:** The Bookmark page should be removed from navigation stack, ie. When tapping on Bookmark Item, Screen 1 should open but when I press back button It should exit from the app & should not open The bookmark page again.

3. How to exit from App

    * When user press Back button on Screen 1 show a toast with message “press again to exit”. On second tap of back button user should be exit from App. ie. user should press back button 2 times from screen 1 to exit from the App.


### Additional features
* Forward button disabled when no page to forward
* Option to remove bookmark
* Progress bar to show loading progress
* Persistence of bookmarks after quitting app

### Screencast
[![Screencast video Web Browser](https://img.youtube.com/vi/3IBDZmc1DwQ/0.jpg)](https://www.youtube.com/watch?v=3IBDZmc1DwQ)

### Screenshot Images

<img src="https://user-images.githubusercontent.com/12752821/48365413-dd964900-e6d0-11e8-9c7b-1d04268dcd72.png" alt="simulator screen shot - iphone xr - 2018-11-12 at 23 09 05" width="400">

<img src="https://user-images.githubusercontent.com/12752821/48365468-061e4300-e6d1-11e8-830d-43c65fbb25ed.png" alt="simulator screen shot - iphone xr - 2018-11-12 at 23 09 05" width="400">

<img src="https://user-images.githubusercontent.com/12752821/48365504-1e8e5d80-e6d1-11e8-888e-dc207f23c97a.png" alt="simulator screen shot - iphone xr - 2018-11-12 at 23 09 38" width="400">

<img src="https://user-images.githubusercontent.com/12752821/48365528-3239c400-e6d1-11e8-916f-8f9cddd80606.png" alt="simulator screen shot - iphone xr - 2018-11-12 at 23 11 37" width="400">

<img src="https://user-images.githubusercontent.com/12752821/48365560-47165780-e6d1-11e8-9045-607c78616ba8.png" alt="simulator screen shot - iphone xr - 2018-11-12 at 23 13 33" width="400">



