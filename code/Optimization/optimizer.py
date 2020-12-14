import numpy as np
from scipy import misc
from scipy.optimize import minimize
from scipy.optimize import basinhopping
from scipy.optimize import NonlinearConstraint
import matplotlib.pyplot as plt
import triangle as tr

def optimize_pos(A, r_new, target, minDist, screenSize, init_states ): 
    #input A: n*3 Matrix containing all position and sizes of bubbles
    #      r_new:       radius of new bubble
    #      target:      position to which should be optimized
    #      minDist:     minimal distance to each bubble 
    #      screenSize:  Size of the screen
    #      init_states: A sample* 2 matrix 
    #returns vector containing new position and size
    #build state vector
    # | x1 y1 |
    # | x2 y3 |
    # | .. .. |
    # | xn yn | 

    states = A[:, 0:2]
    radien = A[:, 2]
    
    #--- non-lin constraints
    def con(x): #non-linear constaints function
        res_vec = np.zeros(int(states.shape[0]))#build resulting constraints vector   
        for i in range(states.shape[0]):
            diff = np.subtract([x[0], x[1]], [A[i,0] , A[i,1]]) #distance to other bubble
            res_vec[i] = np.linalg.norm(diff) - r_new - radien[i] - minDist
        return res_vec
    nlc = NonlinearConstraint(con, 0, float('inf'))
    #--- bounds on new position
    bnds = ((0, screenSize[0]), (0, screenSize[1]))
    #---- Solve minimization for different initail condition to find best global minimization
    
    res_fun = np.inf
    sol = None
    for i in range(init_states.shape[0]):         
        minim = minimize( funct,
                        [init_states[i, 0], init_states[i, 1]],
                        args = (states, radien, target),
                        method='trust-constr', 
                        bounds = bnds, 
                        constraints=nlc, 
                        tol=1e-2, 
                        options={   'disp': False,                           
                                    'maxiter':100}) 
        if(minim.success and minim.fun < res_fun and minim.constr_violation < 1.0):
            res_fun = minim.fun
            sol = minim
            if(minim.fun <= 2): #if a solution with less then a threshold has been found, then stop searching
                break
        
    return sol
def funct(x, states, radien, target): #function to optimize
    #optimize for a point on screen
    diff = np.subtract([x[0], x[1]], [target[0], target[1]])  
    return np.linalg.norm(diff)
def get_init_states_random(random_samples, screen_size): #legacy
    init_states = np.matrix([   [0, 0], 
                                [screen_size[0], 0], 
                                [0, screen_size[1]], 
                                [screen_size[0], screen_size[1]]])
    for i in range(random_samples):
        column_to_be_added = np.array([np.random.randint(screen_size[0]),np.random.randint(screen_size[1]) ])
        init_states = np.row_stack((init_states, column_to_be_added))        
    
    return init_states
def get_init_states_center(A, screen_size):
    ## Triangulate with each node point and use center of triangle as initial condition
    ## Use screen points as additional init conditions
    ## Super overengineered, but worth it :)
    
    init_states = np.matrix([   [0, 0], 
                                [screen_size[0], 0], 
                                [0, screen_size[1]], 
                                [screen_size[0], screen_size[1]]])

    if(len(A.shape) != 1 and A.shape[1] > 2): #triangulate only if more than 2 bubbles available
        
        points = np.array([0,0])
        points = np.row_stack((points, np.array([screen_size[0], 0])))
        points = np.row_stack((points, np.array([0, screen_size[1]])))
        points = np.row_stack((points, np.array([screen_size[0], screen_size[1]])))

        for i in range(A.shape[0]):
            points = np.row_stack((points, np.array([A[i, 0], A[i, 1]])))
            #error
        dict_A = dict(vertices=points)
        mesh = tr.triangulate(dict_A)

        ## -- compute center of each triangle
        vertices = mesh['vertices'].tolist()
        triangles = mesh['triangles'].tolist()
        
        #Compute center of triangles and add new points as inital states
        for i in range(len(triangles)):
            x_c = (vertices[triangles[i][0]][0] + vertices[triangles[i][1]][0] + vertices[triangles[i][2]][0])/3.0
            y_c = (vertices[triangles[i][0]][1] + vertices[triangles[i][1]][1] + vertices[triangles[i][2]][1])/3.0
            column_to_be_added = np.array([x_c, y_c])
            init_states = np.row_stack((init_states, column_to_be_added))
    

    return init_states
