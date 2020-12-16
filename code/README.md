# Code build and run instructions
* Install Python 3.9
* Type the following things into your command window to install the required libraries:
  * ```pip install python-osc```
  * ```pip install numpy==1.19.3```
    * It is important to install this vesion since since newer ones may result in a RuntimeError: "*The current Numpy installation fails to pass a sanity check due to a bug in the windows runtime*"
  * ```pip install scipy```
  * ```pip install triangle```
    * If this fails, then install https://visualstudio.microsoft.com/de/visual-cpp-build-tools/.
* Run the backend either directly (run Communication.py) or also via command line: ```py Communication.py```
* Run the frontend by opening HCI_Interface.pde
