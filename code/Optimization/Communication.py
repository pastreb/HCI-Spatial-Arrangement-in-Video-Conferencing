from pythonosc.udp_client import SimpleUDPClient
from pythonosc.osc_server import AsyncIOOSCUDPServer
from pythonosc.dispatcher import Dispatcher
import asyncio

class OSC:
    def __init__(self):
        # IP address, if you want to communicate with a device on the same network, you probably need to change stuff here.
        # especially differentiate between the PC and the device IP. However, this allows you to run processing on android
        # but do optimization on desktop and still have wireless communication.

        self.ip = "127.0.0.1"

        # the port we receive data from processing on
        self.receiving_port = 12001

        # the port where processing expects data to be send.
        self.sending_port = 12000

        # OSC works with addresses. Basically we can filter on the incoming address and have different handler based on an address.
        # in a case we dont recoginize the address, we use the default handler.
        self.dispatcher = Dispatcher()
        self.dispatcher.map("/filter", self.print_handler)
        self.dispatcher.map("/quit", self.quit_handler)
        self.dispatcher.set_default_handler(self.default_handler)

        # the client we use for sending data.
        self.sending_client = SimpleUDPClient(
            self.ip, self.sending_port
        )  # Create client

        # a boolean to see whether we need to quit the server based on incoming messages.
        self.run = True

    def send_message(self, address, message, verbose=True):
        # send a message to processing.
        # adress needs to be a string.

        self.sending_client.send_message(address, message)
        if verbose:
            print(f"send {message} to {address}")

    # the different handlers. You can easily add your own here, and add them to the dispatcher.
    def print_handler(self, address, *args):
        print(f"{address}: {args}")

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

            
            await asyncio.sleep(
                0.1
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
        asyncio.run(self.init_main())


if __name__ == "__main__":
    osc = OSC()
    osc.start()
