# DOHamburgerButton
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/DOHamburgerButton.svg?style=flat)](http://cocoadocs.org/pods/DOHamburgerButton)
[![Platform](https://img.shields.io/cocoapods/p/DOFavoriteButton.svg?style=flat)](http://cocoapods.org/pods/DOFavoriteButton)
[![License](https://img.shields.io/cocoapods/l/DOFavoriteButton.svg?style=flat)](https://github.com/okmr-d/DOFavoriteButton/blob/master/LICENSE)

Animated Hamburger Button written in Swift

![Demo](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOHamburgerButton/demo.gif)

## Requirements
* iOS 7.0+
* Swift 2.0

## Installation
#### Carthage
Add the following line to your `Cartfile`:
```
github "okmr-d/DOHamburgerButton"
```

#### CocoaPods
Add the following line to your `Podfile`:
```
pod 'DOHamburgerButton'
```

#### Manual
Just drag DOHamburgerButton.swift to your project.

## How to use
#### By coding
1.create a button
```swift
let button = DOHamburgerButton(frame: CGRectMake(0, 0, 44, 44))
button.color = UIColor.whiteColor() // you can set button color
self.view.addSubview(button)
```

2.Add tapped function
```swift
button.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
```
```swift
func tapped(sender: DOHamburgerButton) {
    if sender.selected {
        sender.deselect()
    } else {
        sender.select()
    }
}
```

#### By using Storyboard or XIB
1.Add Button object and set Custom Class `DOHamburgerButton`
![via Storyboard](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOHamburgerButton/storyboard.png)

(and you can set button color)
![change Color](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOHamburgerButton/changeColor.png)

2.Add tapped function
```swift
@IBAction func tapped(sender: DOHamburgerButton) {
    if sender.selected {
        sender.deselect()
    } else {
        sender.select()
    }
}
```

3.Connect Outlet  
![connect outlet](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOHamburgerButton/connect.png)

## DEMO
There is a demo project added to this repository, so you can see how it works.

## License
This software is released under the MIT License.
