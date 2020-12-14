from pythonosc.udp_client import SimpleUDPClient
from pythonosc.osc_server import AsyncIOOSCUDPServer
from pythonosc.dispatcher import Dispatcher
import asyncio

import csv
import numpy as np
from optimizer import optimize_pos
from optimizer import get_init_states_random
from optimizer import get_init_states_center
from scipy import misc
import time

import sys
import os

class OSC:
    def __init__(self):
        #optimization variables
        self.size = [700, 700]
        self.CSV_matrix = np.zeros((2, 3)) #container for all 
        self.result = []
        self.target = []
        self.init_states = None
        self.minDist = None
        self.new_bubble_radius = None
        
        self.DEBUG = 0
        # IP address, if you want to communicate with a device on the same network, you probably need to change stuff here.
        # especially differentiate between the PC and the device IP. However, this allows you to run processing on android
        # but do optimization on desktop and still have wireless communication.

        self.ip = "127.0.0.1"

        # the port we receive data from processing on
        self.receiving_port = 12000

        # the port where processing expects data to be send.
        self.sending_port = 12001

        # OSC works with addresses. Basically we can filter on the incoming address and have different handler based on an address.
        # in a case we dont recoginize the address, we use the default handler.
        self.dispatcher = Dispatcher()
        self.dispatcher.map("/filter", self.optim_dispatcher)
        self.dispatcher.map("/quit", self.quit_handler)
        self.dispatcher.set_default_handler(self.default_handler)

        # the client we use for sending data.
        self.sending_client = SimpleUDPClient(
            self.ip, self.sending_port
        )  # Create client

        # a boolean to see whether we need to quit the server based on incoming messages.
        self.run = True
    def run_optimize(self, new_bubble_radius , new_screen_size = None, optimization_target = None, minimal_dist = None):
        #new bubble size is mandatory to pass in
        self.new_bubble_radius = new_bubble_radius
        #screen size
        if(new_screen_size != None):
            self.size = new_screen_size
        # Optimization target
        if (optimization_target != None):
            self.target = optimization_target
        else: #default is center of screen
            self.target = [int(self.size[0]/2), int(self.size[1]/2)]
        #Minimal Distance of two bubbles
        if(minimal_dist != None):
            self.minDist = minimal_dist
        else: #default
            self.minDist = 20
        #find relative path
        parentDir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        newPath = os.path.join(parentDir, 'HCI_Interface') #...\HCI_Interface 
        #import CSV matrix
        CSV_string_path = newPath + "\\userpositions.csv"
        #file = open(CSV_string_path, "r")
        if(sum(1 for row in open(CSV_string_path)) > 1): #check file not empty
            if(sum(1 for row in open(CSV_string_path)) == 2):
                self.CSV_matrix = np.loadtxt(open(CSV_string_path, "r"), delimiter=",", skiprows=1)
                self.CSV_matrix = np.row_stack((self.CSV_matrix, np.array([0, 0, 0])))
                print(self.CSV_matrix)
            else:
                self.CSV_matrix = np.loadtxt(open(CSV_string_path, "r"), delimiter=",", skiprows=1)
                
                
                

            #np.resize(self.CSV_matrix, (sum(1 for row in open(CSV_string_path)), 3))
            #self.CSV_matrix = np.loadtxt(open(CSV_string_path, "r"), delimiter=",", skiprows=1)
            #print(self.CSV_matrix.shape)
               

        # Find initial states

        self.init_states = get_init_states_center(self.CSV_matrix, self.size)
        #optmize
        t0 = time.process_time()
        self.result = optimize_pos(self.CSV_matrix, self.new_bubble_radius, self.target, self.minDist, self.size, self.init_states ) 
        if (self.DEBUG): 
            print("Optimization time: "+str(time.process_time() - t0))
            print(self.result.x)
            
    def send_message(self, address, message, verbose=True):
        # send a message to processing.
        # adress needs to be a string.
        
        self.sending_client.send_message(address, message)
        if verbose:
            print(f"send {message} to {address}")

    # Handler dispatching when a request from Processing arrives
    def optim_dispatcher(self, address, *args):
        #Process input variables
        _message = args[0]
        _sc_size = [int(args[1][7:]), int(args[2][8:])]
        _bubble_radius = int(args[3][13:])
        #run optimization call
        self.run_optimize(_bubble_radius, _sc_size)
        #send result back to processing
        self.send_message(self.ip, [str(np.round(self.result.x[0])), str(np.round(self.result.x[1]))])
        #print(f"{address}: {args}")

    def quit_handler(self, address, *args):
        print("QUITING")
        self.run = False

    def default_handler(self, address, *args):
        print(f"DEFAULT {address}: {args}")

    # This is the main loop, anything you wanna do, you should do it in here.
    # If you are doing time intensive stuff, you need to start thinking about threading
    # because anything you do in here blocks receiving new messages.
    async def loop(self):

        while self.run:
            # ------ DO YOUR STUFF HERE ------- #
            #self.run_optimize(20)
            
            await asyncio.sleep(
                0.5
            )  # we need some time to process whether we have incoming data.

    # setup a non-blocking receiving server.
    async def init_main(self):
        server = AsyncIOOSCUDPServer(
            (self.ip, self.receiving_port), self.dispatcher, asyncio.get_event_loop()
        )
        (
            transport,
            protocol,
        ) = (
            await server.create_serve_endpoint()
        )  # Create datagram endpoint and start serving
        await self.loop()  # Enter main loop of program
        transport.close()  # Clean up serve endpoint

    # start everything
    def start(self):
        
        
        #run main
        asyncio.run(self.init_main())
    
            
if __name__ == "__main__":
    osc = OSC()
    osc.start()
