# CollimatR

## Overview
This app was created as a small pet project to assist astrophotographers with the alignment of a telescope's secondary mirror with the focuser using a phone and a collimation eyepiece.

_Disclaimer this idea was inspired from this ![post](https://forums.sharpcap.co.uk/viewtopic.php?t=5936) describing the approach in ![SharpCap](https://www.sharpcap.co.uk/). However, this requires the use of SharpCap compatible cameras AND having a CS lens to have the secondary mirror in focus which was not my case..._


## Requirements
- A telescope
- A collimation eyepiece
- A smartphone with a camera
- _(Optional but recommended)_ An eyepiece phone holder


## Workflow
1. Place the telescope tube horizontally (to avoid dropping something on your primary mirror).
2. Add a piece of paper inside the tube on the opposite side of the focuser to increase contrast. A second piece of paper can be used to block the view to the primary mirror simplifying the image.
   
3. Place the collimation eyepiece on the focuser and mount the phone to have the secondary mirror in focus in the focuser as shown below.
<p align="center" width="100%"><img width="50%" src="https://github.com/guiastrennec/CollimatR/assets/7304883/4f6888f1-3542-48f9-9203-cb430ef72055"></p>

4. Take a picture through the collimation eyepiece and start the app (here).
<p align="center" width="100%"><img width="90%" src="https://github.com/guiastrennec/CollimatR/assets/7304883/9beb9151-0b6f-45c2-a35c-0428a458885c"></p>

5. Upload the picture to the app using the `Browse...` button. The image will appear in the app.
<p align="center" width="100%"><img width="90%" src="https://github.com/guiastrennec/CollimatR/assets/7304883/ae557cd7-a253-46cb-b5e9-dbb029c25ff1"></p>

6. The image can be resized using the `Scale` slider _(note: sliders can be fine tuned by clickin on it and using the left/right arrow keys on the keyboard)_
<p align="center" width="100%"><img width="90%" src="https://github.com/guiastrennec/CollimatR/assets/7304883/5842b0a1-88aa-499e-b486-c8801f07250e"></p>

7. The image can be cropped by selecting an area on the image and double clicking within the highlighted area. To reset the cropping simply double click on the image again.
<p align="center" width="100%"><img width="90%" src="https://github.com/guiastrennec/CollimatR/assets/7304883/82b46d0d-1ac4-4520-8341-20d7e47a6508"></p>

Once cropped the boxes showing the selected image portion will be updated in the side bar. These values (in pixels) can be adjusted manually to refine the cropping.
<p align="center" width="100%"><img width="90%" src="https://github.com/guiastrennec/CollimatR/assets/7304883/360de331-a495-4c54-8eef-59e685e13e8d"></p>

8. The image can be rotated to align the X or Y axis of the image with the optical axis of the telescope. A grid can be added to the image by checking the `Show Grid` box. This step will facilitate the evaluation of the orientation of the secondary mirror with respect to the focuser. Note: the rotation needs to be done AFTER the cropping to work properly.
<p align="center" width="100%"><img width="90%" src="https://github.com/guiastrennec/CollimatR/assets/7304883/278d3045-6342-4e53-ba90-d09f91c15bef"></p>

9. Adjust the size (`Focuser reticule size`) and position (`X-origin offset`, `Y-origin offset`) sliders of the focuser reticule _(red circle)_ to match the edges of the focuser on the image. Then adjust the `Secondary reticule size` to match the size of the secondary mirror on the image.
<p align="center" width="100%"><img width="90%" src="https://github.com/guiastrennec/CollimatR/assets/7304883/f64d8afc-d15a-42b4-a776-4fc35a12e0bc"></p>

10. Using the reticulated image we can now see that the secondary mirror is not centered in the focuser. Adjustments can be made to the secondary mirror to improve the aligment with the optical axis. A new image can then be taken and imported into the app using the `Browse...` button. If the camera has not moved between pictures the image transformation (size, crop, rotation) and reticules (offset, size) should be automatically applied to the image.
<p align="center" width="100%"><img width="90%" src="https://github.com/guiastrennec/CollimatR/assets/7304883/7e2b4f58-057c-48fa-b099-449390c69860"></p>

11. For future use the app settings can be bookmarked using the `Bookmark` button.

