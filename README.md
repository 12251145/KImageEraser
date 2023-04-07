# KImageEraser

KImageEraser provides an image eraser. You can set the alpha of the drawing part to 0.

<img src="https://user-images.githubusercontent.com/96657571/230561252-4e0cb217-7e00-4662-87e1-b5eeedfecfd5.png" width="200"> <img src="https://user-images.githubusercontent.com/96657571/230561242-e9ba9085-f65f-45ed-9791-11ff1b4636d7.png" width="200">

## Installation

### SPM

- File > Add Packages
- Add `https://github.com/12251145/KImageEraser.git`

## Using KImageEraser

- Create a KImageEraserViewController with the image you want to edit
- Present and edit it

```swift
import KImageEraser

let imageEraser = KImageEraserViewController(image: image)
imageEraser.delegate = self
        
<ViewController>.present(imageEraser, animated: true)
```

- The caller needs to conform KImageEraserViewControllerDelegate

```swift
public protocol KImageEraserViewControllerDelegate: AnyObject {
    func imageEraserViewControllerDoneImageErase(_ viewController: KImageEraserViewController, image: UIImage)
    func imageEraserViewControllerCloseButtonDidTap(_ viewController: KImageEraserViewController)
}
```
