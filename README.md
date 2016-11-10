# KYFloatingActionButton
 That's a FloatingActionButton and you can set its position with autolayout

#Requirements

 - iOS 8.0+
 - Swift 3
 - Xcode 8+

#Demo
 ![](https://github.com/Lawlietop/KYFloatingActionButton/blob/master/Demo/9vfBOFE8QB.gif)
 
#Usage 

- Step 1
 Drag a UIView into storyboard or xib 
 
- Step 2 
 Give it constraint without width and height because it has a fixed width and height 55 ，Recommend adjusting height and width to 55 so that you could more easily set layout
 
- Step 3 
 You can change the UIVvew bagroundcolor to adjust the FloatingActionButtonColor
 
- Step 4 
 
* kinds of animation 
```swift
enum openButtonType {
        case slideUp
        case slideDown
        case popUp
        case popDown
    }
```
* Demo Code

```swift

button.openType = .popUp
        button.plusColor = UIColor.brown      // Change plus color
        button.add(color:UIColor.red)         // add a itemButton
        button.add(color:UIColor.orange)
        button.add(color:UIColor.brown)
        button.add(color: UIColor.green, image: UIImage(named: "Map Filled-50.png")!) { (item) in
            let alert = UIAlertController(title: "Hello", message: "Are you ok?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil) 
            
            // add a itemButton with closure and image
            
```
