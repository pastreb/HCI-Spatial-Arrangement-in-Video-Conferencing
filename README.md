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
  - In terms of the layout, less is often more. There should not be too much info on the screen at once to not overwhelm the basic user.
- **Multimedia**:
  - Audio is definitely more important than video.
  - Facial expressions and reactions are an important part of an online conversation. Some users want the facecam to be always visible, whereas size and placement should be up to the individual user.
  - Sharing multiple screens at the same time would be appreciated mostly by business and student users alike.
  - There should be a simple function for data exchange.
  - Bilateral talks between "seatmates" do not really seem to be appreciated over all interviewees. Not being distracted was often viewed as a good thing. A simple text chat would be sufficient.
  - In some interviews, the wish to be able to mute individuals came up.
- **Hierarchy**:
  - Many users are kind of lost when they are put into breakout rooms.
  - Depending on their job in a video call, numerous users would like to have clear permissions.
  - Within bigger groups, a clear hierarchy should be established, where each user is assigned to a different priority.
  - Especially student users would like an improved "raising hand" tool since the host does not always notices an answer.

### Insights <a name="insights"></a>
As a takeaway, our **most important insights** were the following:
- Most interviewees prefer a simple UI
- The arrangement of participants should be up to the user in some way
- Screen Sharing & File Sharing should be easier and support additional features
- There should be a better permission/role system within a call

### Affinity Diagram <a name="affinity_diagram"></a>
Based on these interview outcomes, we created our [Affinity Diagram](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Affinity_Diagram.png) (which can also be found on [Miro](https://miro.com/app/board/o9J_kjg1ZWo=/)). 

<!--- ![Affinity Diagram](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Affinity_Diagram.png "Affinity Diagram")) -->
<img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Affinity_Diagram.png" alt="Affinity Diagram" width="500"/>

We will aim on creating an UI that is as beneficial as possible in meeting one or multiple of these needs.

### Personas <a name="personas"></a>
The Affinity diagram then helped us create our three **Personas**, which represent typical users:
- **Low-level User**: [Karen Smith](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Persona_Karen.pdf)
  - Has never used such technology
  - User Scenario: 
    - Since the pandemic began she can't visit her friends anymore
    - They use Zoom to chat with each other and have a drink, when the children finally leave again for their afternoon classes
    - Thankfully one of her friends' husbands works in IT, so they had him set it up for them
    - If anything doesn't work, the only way she knows how to get it running again is by restarting the computer
    <img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Karen.png" alt="Karen Smith" width="80"/>
- **Casual User**: [Silvano da Silva Jovanotti](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Persona_%20Average%20User.pdf)
  - Is an average tech-user
  - User Scenario:
    - Silvano has had a stressful day (again)
    - Only one more meeting with his co-workers from China and the USA and he is done for the day
    - He's eager to head home to his favourite sofa and watch his team win the football cup tonight
    - Unfortunately, all participants are late again and he is the one to blame
    - To his luck, the meeting is working properly and no other errors occur
    <img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Silvano.png" alt="Silvano da Silva Jovanotti" width="80"/>
- **Power User**: [Raphael Yamamoto](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Persona_Poweruser.pdf)
  - Studied Computer Science
  - User Scenario:
    - Rapha, as his friends call him, uses Discord to talk to the other players on their minecraft server
    - He has been streaming for 3 hours straight and made a decent amount of money through donations
    - Currently, they are working on a big project, and they are trying to coordinate with 24 different people
    - He grabs an energy drink
    - It's a bit confusing with everyone in the same voice channel, even though people are all over the map
    <img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Raphael.png" alt="Raphael Yamamoto" width="120"/>

### Brainstorming Ideas <a name="brainstorming"></a>
In another brainstorming phase, we came up with as many [Ideas](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Brainstorming.pdf) as possible. Here are some examples:
- Level-based permissions
  - Higher level = higher priority within the call
  - Unlock additional features when reaching a higher level
  - Hierarchy
- Popup Avatars with DIY Arrangement
  - Every user that joins pops up on the canvas
  - Each participant can individually move him/her around and resize the avatar/video
  - Similar to desktop icons

### Presentation <a name="presentation"></a>
For the [Presentation](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Ideation_Presentation.pdf), we tried to choose three ideas that most represent all our different approaches in order to get feedback for any path we could take. 
The winners (a little more in detail) were:
- **Level-based Permissions**
  - Give different levels to the participants in the call
  - Different levels give different permissions
  - Example permissions:
    - Mute/unmute people with lower levels 
    - Rearrange the visual order
    - Share files/screen
    - Access different breakout rooms 
  - Lower level participants go through higher level participants to ask questions or get permissions
- **[User-specific Conference Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Popup_Avatar_Mockup.png)**
  - Participants appear as bubbles on a canvas (the shape doesn’t really matter)
  - Users can move and scale those bubbles to make their own arrangement
  - Based on the “rank” of a user, it’s bubble initially appears larger
  - The state of any participant (muted, speaking, … ) changes the corresponding bubble’s appearance
  - Facecam and screen share are displayed in the bubble
    - This might cause it to change its shape
  - Groups could potentially be displayed as clusters connected by a “group bubble”
  <img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Popup_Avatar_Mockup.png" alt="User-specific Conference Arrangement" width="300"/>

- **[Agar.io Styled Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Agar.io_Styled_Arrangement.png)**
  - More of a fun idea
  - Participants appear as bubbles on the screen and can “walk” around, using the arrow keys
  - The voice of people that are closer appears louder
  - It often happens that one gets bored when a video call becomes too long
    - This idea might help in staying focused and prevent people from doing something else
    - It also helps detecting inactive users 
  <img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Agar.io_Styled_Arrangement.png" alt="Agar.io Styled Arrangement" width="300"/>
    
### Lowfi Prototyping <a name="lowfi_prototypes"></a>
While trying to implement some of the feedback we received for the presentation, we created prototypes for the three ideas we presented and an additional one:
- **[Prototype Agar.io Styled Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Prototype_Agario_Pascal.mp4)**
- **[Prototype Level based permission System](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Level-based-system.pdf)**
- **[Prototype User-specific conference arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Prototype_Arrangement_Robin.mp4)**
- **[Prototype Stack based view](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Stack%20Based%20View%20(CW).pdf)**

## Evaluation <a name="evaluation"></a>
(Weeks 5-7)

### Midfi Prototyping <a name="midfi_prototypes"></a>
Based on the feedback we received, we decided to merge the ideas of the level based permission system and the user-specific conference arrangement in some ways. This led to the creation of the following two midfi prototypes:
- [Prototype A](https://xd.adobe.com/view/2b2d7ce0-21a7-4684-ac29-a956077592ca-7e7e/grid)
- [Prototype B](https://xd.adobe.com/view/99615182-12a9-434b-8e44-f15a70c31556-cc32/grid)

### User Study <a name="user_study"></a>
For conducting the user study, we created a [Study Protocol](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Study%20Protocol.pdf) and a [Subjective Rating Form](https://docs.google.com/forms/d/e/1FAIpQLSebr7I3G2s7by578MRwiXRlNRDSrXhL84pf3HPX7f1ZPkRodQ/viewform).

The project was explained to the participant as follows: 
“*We want to adapt the user interface of video call tools such that they become easier to handle while providing more functionality. To do so, we created two prototypes that we would like to assess now. The prototypes are very basic and do not really implement the functionality but for now we just pretend as if they did so. Subsequently, you will receive some simple tasks for each of the prototypes. As soon as you complete a task, the message “Good Job” appears on the screen.*”

<img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/Midfi_Prototypes.png" alt="Midfi Prototypes" width="500"/>

In summary, each [Participant](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Demographics.pdf) was asked to perform the following taks on both prototypes while the [Task Completion Time](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/User%20Performance.pdf) was measured as a dependent variable:
- “*Create a room and let other people join.*”
- “*Change another user's level.*”
- “*Change the position and size of another user.*”
- “*Create a breakout-room, join it and share your screen.*”

Our **main goal** was to determine two things:
- **How easy is it for the participant to make use of the additional functionalities?**
- **Which prototype is less overwhelming?**

In our [Study Report](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Study%20Report.pdf) we first explain the goals and methodology a little more in detail before we analyze the [User Performance](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/User_Performance_evaluation.jasp). To compare the effect of the prototype on task completion time, we performed a [Paired t-test Analysis](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Participants_Study_Plots.pdf).

<img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/t_test_results.png" alt="Paired t-test-Analysis" width="800"/>

To sum up, we concluded that our two prototypes perform quite similarly. The [Subjective Rating](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Subjective_Rating.pdf) and verbal feedback we received from the participants however cleary exposed Prototype A to be more popular.

<img src="https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/img/subjective_rating_diagrams.png" alt="Subjective Rating Diagrams" width="800"/>

## Hifi Prototype <a name="prototype"></a>

**Week 8:**
- We started building our [frontend](https://github.com/eth-ait/hci-project-hci2020-group-08/tree/2020/code/HCI_Interface) using Processing.
- We are not using a library for our UI. We have our own solution for this.
- The user has to have the ability to resize the program window freely. This is important because they need to have the space to move other users around, resize them, ...
- The basics of the UI are already functional, representations of users, breakout rooms, screen sharing, ... is still missing

**Week 9:**
- We extended the functionality of the UI further, especially the "user bubbles" and the breakout-rooms
- We started building an interface in Processing that should allow us to easily communicate with the "backed" that will be coded later.

(Weeks 8-14)

    TODO
Describe your high-fidelity manual prototype.  
Describe your high fideltiy automatic prototype to the problem and the prototype you developed in more detail here.  
Create and upload a video "deliverables" folder of your final prototype (which will be used in the final presentation) and include the link here.  
In the code folder, document the readme file with build / run instructions.
