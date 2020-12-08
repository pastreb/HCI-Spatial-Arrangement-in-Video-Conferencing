import pygame
import csv
import numpy as np
from optimizer import optimize_pos
from optimizer import get_init_states_random
from optimizer import get_init_states_center
from pygame.locals import *
from scipy import misc
import matplotlib.pyplot as plt
import time
from Communication import OSC
 
class App:
    def __init__(self):
        self._running = True
        self._display_surf = None
        self.size = [ 1000, 800]
        self.CSV_matrix = np.empty((1, 1)) #container for all 
        self.result = []
        self.target = [int(self.size[0]/2), int(self.size[1]/2)]
        self.init_states = None
        self.random_samples = int(self.size[0]*self.size[1] / 20000)
        self.minDist = 10
        self.new_bubble_radius = 40
        self.myfont = None
        ## --- Communcation Protocol
        self.Com = []
 
    def on_init(self):
        ##init display
        pygame.init()
        pygame.font.init()
        self.myfont = pygame.font.SysFont('AGENCYR.TTF', 20)
        self._display_surf = pygame.display.set_mode(self.size, pygame.HWSURFACE | pygame.DOUBLEBUF)
        ## init communcation
        self.Com = OSC()
        
        ## import CSV file
        np.resize(self.CSV_matrix, (sum(1 for row in open("input.csv")), 4))
        self.CSV_matrix = np.loadtxt(open("input.csv", "r"), delimiter=";", skiprows=1)
        #optimizer for new position of the bubble
        
        #Find appropraite init states
        self.init_states = get_init_states_random(self.random_samples, self.size)
        self.init_states = get_init_states_center(self.CSV_matrix, self.size)
        #solve
        #t0 = time.process_time()
        self.result = optimize_pos(self.CSV_matrix, self.new_bubble_radius, self.target, self.minDist, self.size, self.init_states ) 
        #print("Optimization time: "+str(time.process_time() - t0))
        #print(self.result.x)
        self._running = True
 
    def on_event(self, event):
        if event.type == pygame.QUIT:
            self._running = False
    def on_loop(self):
        pass
            
    def on_render(self):
        ##place all circles
        #rows = len(self.CSV_matrix(:, 1))
        GREEN = pygame.Color(0, 255, 0) 
        RED = pygame.Color(255, 0, 0) 
        BLUE = pygame.Color(0, 0, 255)
        WHITE = pygame.Color(255, 255, 255)
        DARK_GREY = pygame.Color(70, 70, 70)
        #draw init
        pygame.draw.rect(self._display_surf, WHITE, pygame.Rect(0, 0, self.size[0], self.size[1]))
        for index in range(len(self.CSV_matrix[:, 1])):
            elem = self.CSV_matrix[index, :]
            pygame.draw.circle(self._display_surf, RED, (elem[0], elem[1]), elem[2])
        
        #draw optimized position
        pygame.draw.circle(self._display_surf, BLUE , (self.result.x[0], self.result.x[1]), self.new_bubble_radius)
        #draw DEBUG
        pygame.draw.circle(self._display_surf, GREEN, (self.target[0], self.target[1]), 5)
        for i in range(self.init_states.shape[0]):
            pygame.draw.circle(self._display_surf, DARK_GREY, (self.init_states[i, 0], self.init_states[i, 1]), 2)
        #textsurface = self.myfont.render(('('+str(int(self.result.x[0]))+' '+str(int(self.result.x[1]))+')'), False, (255, 255, 255))
        
        pygame.display.update()
        #self._display_surf.blit(textsurface,(self.result.x[0] + 20 ,self.result.x[0] - 100))
    def on_cleanup(self):
        
        pygame.quit()
 
    def on_execute(self):
        if self.on_init() == False:
            self._running = False
 
        while( self._running ):
            for event in pygame.event.get():
                self.on_event(event)
            self.on_loop()
            self.on_render()
        self.on_cleanup()
 
if __name__ == "__main__" :
    theApp = App()
    theApp.on_execute()
