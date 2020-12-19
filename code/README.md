# Code build and run instructions

# For Python
* Install Python 3.9
* Type the following things into your command window to install the required libraries:
  * ```pip install python-osc```
  * ```pip install numpy==1.19.3```
    * It is important to install this version since newer ones may result in a RuntimeError: "*The current Numpy installation fails to pass a sanity check due to a bug in the windows runtime*"
  * ```pip install scipy```
  * ```pip install triangle```
    * If this fails, then install https://visualstudio.microsoft.com/de/visual-cpp-build-tools/.
* Run the backend either directly (run Communication.py) or also via command line: ```py Communication.py```

# For Processing
* Download and install Processing 3.5.4
* Install the video library by Processing
* Install oscP5 by Andreas Schlegel
* Run the frontend by opening HCI_Interface.pde
NOTE: 
The standard Processing-IDE has a builtin library manager. To open it, select "Sketch->Import Library->Add Library"

# Program Usage
* Create a new room by clicking the "CREATE ROOM" button.
* Add a new user by clicking the "CREATE USER" button. This starts the optimizer and might therefore take some time.
* Create a breakout room by clicking the "CREATE BREAKOUT ROOM" button.
 * Drag a user onto the breakout room to enter the breakout room.
 * Drag a user out of the breakout room to leave the breakout room.
* When clicking on a user, 4 buttons appear.
 * Clicking on the same user will make the buttons disappear again.
 * Holding the "MOVE" button and dragging the mouse drags the user bubble around.
 * Holding the "RESIZE" button and dragging the mouse resizes the user bubble.
 * Holding the "LEVEL" button and dragging the mouse up/down changes the level of the user.
 * The "MUTE" button doesn't do anything atm.
* The cogwheel on the bottom left opens the settings menu. 
