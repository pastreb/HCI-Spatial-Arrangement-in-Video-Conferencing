<p align="left" width="100%">
  <img height="56" src="img/logo-ait.png"> &nbsp; &nbsp;
  <img height="56" src="img/eth-sip-3l.png">     
</p>

# Spatial Arrangement in Video Conferencing, Group 8
#### Robin Schmidiger, Pascal Strebel, Lukas Stefan Heinz Hasler, Cedric Weibel

As opposed to physical meetings or gatherings, participants do not have a spatial location relative to each other in video calls, i.e., there is only one “sound source” for 
all speakers. This does not necessarily scale well. Especially in larger gatherings, people cannot naturally form groups by walking up to each other and start talking without disturbing the whole meeting. 
How can this be mimicked in online meetings instead of artificial concepts like break-out rooms, but without making it too complex or “playful”?

## Table of Contents
- [Project Description and User Needs](#description)
- [Ideation](#ideation)
  - [Needs](#needs)
  - [Insights](#insights)
  - [Affinity Diagram](#affinity_diagram)
  - [Personas](#personas)
  - [Brainstorming Ideas](#brainstorming)
  - [Presentation](#presentation)
  - [Lowfi Prototypes](#lowfi_prototypes)
- [Evaluation](#evaluation)
  - [Midfi Prototypes](#midfi_prototypes)
  - [User Study](#user_study)
- [Hifi Prototype](#prototype)
  - [Hifi Manual Prototype](#manual)
  - [Hifi Automatic Prototype](#automatic)
  - [Summary](#final)

## Project Description and User Needs <a name="description"></a>
(Week 2-3)

After a first brainstorming phase, we came up with [Several Questions](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Interview_Needfinding_Questions.pdf) as guidelines for our interviews. 

In our eyes, the key questions are:
- If you had to do some group work online with 12 people, how would you do that?
- What wouldn't you want to do in an online call? Why?
- What features are missing in Zoom/Discord/Teams in contrast to meeting in real life?
- How do you usually decide who gets to talk?

Each of us conducted two to three such interviews (protocols can be found here: [Protocols Cedric](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Interviewprotokolle_Cedric.pdf), [Protocols Lukas](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Interviewprotokolle_Lukas.pdf), [Protocols Pascal](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Interviewprotokolle_Pascal.pdf), [Protocols Robin](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Interviewprotokolle_Robin.pdf)).      

## Ideation <a name="ideation"></a>
(Weeks 2-4)

### Needs <a name="needs"></a>
The interviews resulted in a [Final List of Needs](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Needfinding%20Final.pdf) both for every interviewee and also across all interviewees.

These can be summed up:
- **Simpleness**:
  - Many users only use one tool that they know. Generally speaking, it is hard for them to get used to a new tool with new features. They prefer minimal effort.
  - It would be beneficial if the tool would look exactly the same on all possible devices.
  - Features should not be hidden.
  - In terms of layout, less is often more. There should not be too much info on the screen at once to not overwhelm the basic user.
- **Multimedia**:
  - Audio is definitely more important than video.
  - Facial expressions and reactions are an important part of an online conversation. Some users want the facecam to be always visible, whereas size and placement should be up to the individual user.
  - Sharing multiple screens at the same time would be appreciated mostly by business and student users alike.
  - There should be a simple function for data exchange.
  - Bilateral talks between "seatmates" do not really seem to be appreciated by most interviewees. Not being distracted was often viewed as a good thing. A simple text chat would be sufficient.
  - In some interviews, the wish for the ability to mute individuals came up.
- **Hierarchy**:
  - Many users are kind of lost when they are put into breakout rooms.
  - Depending on their job in a video call, numerous users would like to have clear permissions.
  - Within bigger groups, a clear hierarchy should be established, where each user is assigned to a different priority.
  - Especially student users would like an improved "raising hand" tool since the host does not always notices a request to speak.

### Insights <a name="insights"></a>
As a takeaway, our **most important insights** were the following:
- Most interviewees prefer a simple UI.
- The arrangement of participants should be up to the user in some way.
- Screen sharing & file sharing should be easier and support additional features.
- There should be a better permission/role system within a call.

### Affinity Diagram <a name="affinity_diagram"></a>
Based on these interview outcomes, we created our [Affinity Diagram](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Affinity_Diagram.png) (which can also be found on [Miro](https://miro.com/app/board/o9J_kjg1ZWo=/)). 

<img src="img/Affinity_Diagram.png" alt="Affinity Diagram" width="500"/>

We will aim on creating an UI that is as beneficial as possible in meeting one or multiple of these needs.

### Personas <a name="personas"></a>
The Affinity diagram then helped us create our three **Personas**, which represent typical users:
- **Low-level User**: [Karen Smith](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Persona_Karen.pdf)
  - Has never used such technology.
  - User Scenario: 
    - Since the pandemic began she can't visit her friends anymore.
    - They use Zoom to chat with each other and have a drink, when the children finally leave for their afternoon classes.
    - Thankfully, one of her friends has a husband that works in IT, so they had him set up Zoom for them.
    - If anything does not work, the only way she knows how to get it running again is by restarting the computer.
    <img src="img/Karen.png" alt="Karen Smith" width="80"/>
- **Casual User**: [Silvano da Silva Jovanotti](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Persona_%20Average%20User.pdf)
  - Is an average tech-user.
  - User Scenario:
    - Silvano has had a stressful day (again).
    - Only one more meeting with his co-workers from China and the USA and he is done for today.
    - He's eager to head home to his favourite sofa and watch his team win the football cup tonight.
    - Unfortunately, all participants are late again and he is the one to blame.
    - To his luck, the meeting is working properly and no other errors occur.
    <img src="img/Silvano.png" alt="Silvano da Silva Jovanotti" width="80"/>
- **Power User**: [Raphael Yamamoto](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Persona_Poweruser.pdf)
  - Studied Computer Science.
  - User Scenario:
    - Rapha, as his friends call him, uses Discord to talk to the other players on their Minecraft server.
    - He has been streaming for 3 hours straight and made a decent amount of money through donations.
    - Currently, they are working on a big project, and they are trying to coordinate with 24 different people.
    - He grabs an energy drink.
    - It's a bit confusing with everyone in the same voice channel, even though people are distributed all over the map ingame.
    <img src="img/Raphael.png" alt="Raphael Yamamoto" width="120"/>

### Brainstorming Ideas <a name="brainstorming"></a>
In another brainstorming phase, we came up with as many [Ideas](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Brainstorming.pdf) as possible. Here are some examples:
- Level-based permissions:
  - Higher level = higher priority within the call.
  - Unlock additional features when reaching a higher level.
  - Hierarchy.
- Popup Avatars with DIY Arrangement:
  - Every user that joins pops up on the canvas.
  - Each participant can individually move him/her around and resize the avatar/video.
  - Similar to desktop icons.

### Presentation <a name="presentation"></a>
For the [Presentation](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Ideation_Presentation.pdf), we tried to choose the three ideas that most represent all our different approaches in order to get feedback for any path we could take. 
The winners (a little more in detail) were:
- **Level-based Permissions**
  - Give different levels to the participants in the call.
  - Different levels give different permissions.
  - Example permissions:
    - Mute/unmute people with lower levels.
    - Rearrange the visual order.
    - Share files/screen.
    - Access different breakout rooms.
  - Lower level participants go through higher level participants to ask questions or get permissions.
- **[User-specific Conference Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Popup_Avatar_Mockup.png)**
  - Participants appear as bubbles on a canvas (the shape does not really matter).
  - Users can move and scale those bubbles to make their own arrangement.
  - Based on the “rank” of a user, his bubble initially appears larger.
  - The state of any participant (muted, speaking, … ) changes the corresponding bubble’s appearance.
  - Facecam and screen share are displayed in the bubble.
    - This might cause it to change its shape.
  - Groups could potentially be displayed as clusters connected by a “group bubble”.
  <img src="img/Popup_Avatar_Mockup.png" alt="User-specific Conference Arrangement" width="300"/>

- **[Agar.io Styled Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Agar.io_Styled_Arrangement.png)**
  - More of a fun idea.
  - Participants appear as bubbles on the screen and can “walk” around, using the arrow keys.
  - The voice of people that are closer appears louder.
  - It often happens that one gets bored when a video call becomes too long.
    - This idea might help in staying focused and prevent people from doing something else.
    - It also helps detecting inactive users.
  <img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Agar.io_Styled_Arrangement.png" alt="Agar.io Styled Arrangement" width="300"/>
    
### Lowfi Prototyping <a name="lowfi_prototypes"></a>
While trying to implement some of the feedback we received for the presentation, we created prototypes for the three ideas we presented and an additional one:
- **[Prototype Agar.io Styled Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Prototype_Agario_Pascal.mp4)**
- **[Prototype Level Based Permission System](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Level-based-system.pdf)**
- **[Prototype User-Specific Conference Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Prototype_Arrangement_Robin.mp4)**
- **[Prototype Stack Based View](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Stack%20Based%20View%20(CW).pdf)**

## Evaluation <a name="evaluation"></a>
(Weeks 5-7)

### Midfi Prototyping <a name="midfi_prototypes"></a>
Based on the feedback we received, we decided to merge the ideas of the Level Based Permission System and the User-Specific Conference Arrangement in some ways. This led to the creation of the following two midfi prototypes:
- [Prototype A](https://xd.adobe.com/view/2b2d7ce0-21a7-4684-ac29-a956077592ca-7e7e/grid)
- [Prototype B](https://xd.adobe.com/view/99615182-12a9-434b-8e44-f15a70c31556-cc32/grid)

### User Study <a name="user_study"></a>
For conducting the user study, we created a [Study Protocol](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Study%20Protocol.pdf) and a [Subjective Rating Form](https://docs.google.com/forms/d/e/1FAIpQLSebr7I3G2s7by578MRwiXRlNRDSrXhL84pf3HPX7f1ZPkRodQ/viewform).

The project was explained to the participant as follows: 
“*We want to adapt the user interface of video call tools such that they become easier to handle while providing more functionality. To do so, we created two prototypes, that we would like to assess now. The prototypes are very basic and do not really implement the functionality but for now we just pretend as if they did so. Subsequently, you will receive some simple tasks for each of the prototypes. As soon as you complete a task, the message “Good Job” appears on the screen.*”

<img src="img/Midfi_Prototypes.png" alt="Midfi Prototypes" width="500"/>

In summary, each [Participant](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Demographics.pdf) was asked to perform the following taks on both prototypes while the [Task Completion Time](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/User%20Performance.pdf) was measured as a dependent variable:
- “*Create a room and let other people join.*”
- “*Change another user's level.*”
- “*Change the position and size of another user.*”
- “*Create a breakout-room, join it and share your screen.*”

Our **main goal** was to determine two things:
- **How easy is it for the participant to make use of the additional functionalities?**
- **Which prototype is less overwhelming?**

In our [Study Report](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Study%20Report.pdf) we first explain the goals and methodology a little more in detail before we analyze the [User Performance](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/User_Performance_evaluation.jasp). To compare the effect of the prototype on task completion time, we performed a [Paired t-test Analysis](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Participants_Study_Plots.pdf).

<img src="img/t_test_results.png" alt="Paired t-test-Analysis" width="600"/>

To sum up, we concluded our two prototypes to perform quite similarly. The [Subjective Rating](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Subjective_Rating.pdf) and verbal feedback we received from the participants however cleary exposed Prototype A to be more popular.

<img src="img/subjective_rating_diagrams.png" alt="Subjective Rating Diagrams" width="600"/>

## Hifi Prototype <a name="prototype"></a>
(Weeks 8-14)

Following the evaluation of our user study, we decided to keep going with combining our basic approaches of the [Level Based Permission System](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Level-based-system.pdf) and the [User-Specific Conference Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Popup_Avatar_Mockup.png), as both these ideas met with approval among the participants. Furthermore, the design should be mostly inspired by [Prototype A](https://xd.adobe.com/view/2b2d7ce0-21a7-4684-ac29-a956077592ca-7e7e/grid).

### Hifi Manual Prototype <a name="manual"></a>
(Week 7-10)

We were finally set up to start building the [Frontend](https://github.com/eth-ait/hci-project-hci2020-group-08/tree/2020/code/HCI_Interface) of our hifi prototype using Processing. The focus on size/position/appearance of bubbles (that represent each participant) and the desire of giving the user the ability to change these on his own (one of our main goals) could not be technically met by any standard library for UI, which is why we decided to create our own solution.

To achieve this goal, the user requires the ability to resize the program window freely. This is important because of the space he needs to move other users around and resize them. Our own library supports not only that but also further functionalities such as breakout rooms, screen sharing and a level based permission system, which is our second main goal. Finally, we also need to keep in mind that our interface should be able to communicate with the backend that will be coded later.

After adding some mockup profile pictures as well as screenshare- and facecam videos, our **Hifi Prototype** was ready to be presented once more:

<img src="img/hifi_prototype.png" alt="Hifi Prototype Interface" width="800"/>

### Hifi Automatic Prototype <a name="automatic"></a>
(Week 11-13)

Another brainstorming phase led to the following two main ideas (among others) on how to automatically optimize our hifi prototype:
- **Cluttering Prevention**
  - Our interface gives the user the ability to freely place and (re-)size every bubble.
  - How should the layout look like when a call is entered for the first time (and there are already n participant present)?
  - Where should the bubble of a newly entering participant be locally placed? Do other bubbles react to that by (minimally) adapting their position and size?
  - A standard layout could be statically precomputed (for 1 <= n <= x users) and optimized based on: 
    - Ideal distances formulated as a linear program.
    - Data collected in the past (i.e. the user-specific layout in previous calls).
    - Heuristics (“*if the user just joined a room, his mouse probably is on the left side of the screen and important bubbles should be there*”).
- **Button Layout**
  - There are several buttons (MUTE, LEVEL, RESIZE, MOVE) that appear upon clicking a bubble.
  - These buttons can be distributed around the bubble in many ways.
  - Optimal positions could be dynamically computed (possibly using random search) and optimized based on: 
    - Minimum distances.
    - Measurements of user input such as the time that passes between clicking a bubble and the button.
    - Heuristics (e.g. “*if the bubble is on the top right corner, the buttons should appear on the side that faces to the middle of the screen.*”)

We decided to keep going with optimizing **Cluttering Prevention**, since we considered it the most meaningful optimization that is unique to our application. Furthermore, we settled on optimizing the position on screen (but not the size) of a new user joining a room. <br />

**Optimization**
A newly entered user triggers a call from the frontend (Processing) to the backend (Python). Processing then sends the screen size and the associated radius to the optimizer program running on Python. Furthermore, a list of all preexisting circles is saved as a CSV file, which is imported by the optimizer as well. <br> 
After the optimization process, Python calls Processing back and hands in the newly found location of the joined user. <br />

The optimization state are the x and y position of the new bubble. The objective is to minimize the cost by altering the state. The cost function is stated as the euclidian norm of the difference between the state and the target position. Thus the absolute distance between both position vectors. <br>
The optimization is subject to two non-linear constraints. The first one enforces no overlapping of the new circle with all other exitsing circles. It states that the distance between the position of the new and preexisting circle is larger than both radii together and a fixed threshold.<br>
The second constraint ensures that the new circle is within the screen bounds. <br> 
<img src="img/optimization_maths.png" alt="Maths behind Optimization" width="600"/>

A crictical part of the algorithm is to find the global minimum, in other words the best location for the circle with as low computation time as possible. <br>
The convergence of the solver is strongly dependent on the inital condition (left image). The program needs to be run for multiple inital condition in order to find the global minimum, thus the smalest cost respective the shortest distance to the target. <br>
First Monte Carlo Sampling has been used to get a list of positions as inital conditions. This approach uses randomly generated samples inside the screen bounds. Many samples ensure the finding of the global minimum. However, this is computational very inefficent and scales exponentialy with the screen size and number of preexisting circles. <br>
A more sophisticated approach uses the center of triangles produced by a mesh as initial conditions. First the algorithm determines a triangulated mesh with nodes being the center of each preexisting circles (right image). Next, the center of each triangle is being calculated and used as intial condition. This approach ensures an optimal location of each inital condition in minimal time. 
<img src="img/optimization_explanation.png" width="800"/>

The resulting algorithm is robust and converges in minimal time to an optimal solution. It can handle big differences in sizes and positions of each circle. More results can be seen in our [final presentation](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Final_Presentation.pdf). The computation time is less than 500 ms for around 20 users. However, it does scale linear and not exponential with increasing number of participants. 

<img src="img/optimizations_results.png" width="800"/>

Since the optimizaion script operates entirely independent, it could be performed entierly remote on another workstation. <br />
***Python dependencies installation***
* Download Python from the [official website](https://www.python.org/)
* Install package manager [Pip](https://pypi.org/project/pip/)
* Install [Numpy](https://numpy.org/install/) with Pip
* Install [Scypi](https://www.scipy.org/install.html) with Pip
* Install [Triangles](https://pypi.org/project/triangle/) with Pip
* Install [OSC](https://pypi.org/project/python-osc/) with Pip
### Summary <a name="final"></a>
Our program delivers an easy and intuitive way of creating and joining call sessions with many participants. The visual representation helps in assigning rights to each user and the overlall clearness. Participant with adequate priotity level can create and assigns particpant to breakout rooms.
Last but not least, we created a video that describes our Hifi Prototype. It can be found in the [Deliverables](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Hifi_Prototype_Video.mp4) (worse quality) as well as on [Youtube](https://www.youtube.com/watch?v=Pxt3dmttFs0&feature=youtu.be).
