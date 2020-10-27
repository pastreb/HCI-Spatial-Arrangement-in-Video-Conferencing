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
- [Prototype](#prototype)

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
- Simpleness:
  - Many users only use one tool that they know. Generally speaking, it is hard for them to get used to a new tool with new features. They prefer minimal effort.
  - It would be beneficial if the tool would look exactly the same on all possible devices.
  - Features should not be hidden.
  - In terms of the layout, less is often more. There should not be too much info on the screen at once to not overwhelm the basic user.
- Multimedia:
  - Audio is definitely more important than video.
  - Facial expressions and reactions are an important part of an online conversation. Some users want the facecam to be always visible, whereas size and placement should be up to the individual user.
  - Sharing multiple screens at the same time would be appreciated mostly by business and student users alike.
  - There should be a simple function for data exchange.
  - Bilateral talks between "seatmates" do not really seem to be appreciated over all interviewees. Not being distracted was often viewed as a good thing. A simple text chat would be sufficient.
  - In some interviews, the wish to be able to mute individuals came up.
- Hierarchy:
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
Based on these interview outcomes, we created our [Affinity Diagram](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Affinity_Diagram.png) (which can also be found on [Miro](https://miro.com/app/board/o9J_kjg1ZWo=/)). 

![Affinity Diagram](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Affinity_Diagram.png "Affinity Diagram")

We will aim on creating an UI that is as beneficial as possible in meet one or multiple of these needs.

### Personas <a name="personas"></a>
The Affinity diagram then helped us create our three **Personas**, which represent typical users:
- **Low-level User**: [Karen Smith](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Persona_Karen.pdf)
  - Has never used such technology
  - User Scenario: 
    - Since the pandemic began she can't visit her friends anymore
    - They use Zoom to chat with each other and have a drink, when the children finally leave again for their afternoon classes
    - Thankfully one of her friends' husbands works in IT, so they had him set it up for them
    - If anything doesn't work, the only way she knows how to get it running again is by restarting the computer
- **Casual User**: [Silvano da Silva Jovanotti](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Persona_%20Average%20User.pdf)
  - Is an average tech-user
  - User Scenario:
    - Silvano has had a stressful day (again)
    - Only one more meeting with his co-workers from China and the USA and he is done for the day
    - He's eager to head home to his favourite sofa and watch his team win the football cup tonight
    - Unfortunately, all participants are late again and he is the one to blame
    - To his luck, the meeting is working properly and no other errors occur
- **Power User**: [Raphael Yamamoto](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Persona_Poweruser.pdf)
  - Studied Computer Science
  - User Scenario:
    - Rapha, as his friends call him, uses Discord to talk to the other players on their minecraft server
    - He has been streaming for 3 hours straight and made a decent amount of money through donations
    - Currently, they are working on a big project, and they are trying to coordinate with 24 different people
    - He grabs an energy drink
    - It's a bit confusing with everyone in the same voice channel, even though people are all over the map

### Brainstorming Ideas <a name="brainstorming"></a>
In another brainstorming phase, we came up with as many **ideas** as possible. Here are some examples:
- Stack-based view of participants, depending on:
  - Join order
  - Priority
  - Contribution (who said most)
- Level-based permissions
  - Higher level = higher priority within the call
  - Unlock additional features when reaching a higher level
  - Hierarchy
- Support facial recognition
  - Recognize hand gestures
  - React heuristically according to the measures:
    - Raising hand => Mic on
    - Hand over mouth => Muted
    - Waving => Video on
    - Hands over eyes => Video off
    - Hands behind ears => Audio on
    - Hands over ears => Audio off
- Visual representation of the room
  - Choose a “map” in the lobby (before the call really starts)
  - Default map is a classroom
  - Participants sit down at a seatplace
  - Host goes to the speaker’s desk
  - Only person at the speaker’s desk is able to share the screen
- Popup Avatars with DIY Arrangement
  - Every user that joins pops up on the canvas
  - Each participant can individually move him/her around and resize the avatar/video
  - Similar to desktop icons
- Important people (e.g. hosts) automatically become bigger
  - Depending on speaking time
- Faces of avatars change based on activity in the video
  - No real video transmission
  - Similar to Animojis
- Faces arranged as a binary-tree
  - Supports business relations or professor->TA->student relation
  - Every user can mute anybody below in the tree
- Agar.io Styled Arrangement
  - Everybody appears as blob
  - “Walk around” using arrow keys
  - People that are closer appear louder
  - Being able to “eat” others (as in [agario](https://agar.io/))
  - Killstreaks?
- Being rewarded for answering questions
  - Use rewards to gain something
- Queue up participants that want to say something
  - Visible queue on the screen
  - Should prevent questions from not being answered or ignored
  - FIFO queue (fair)

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
- **[User-specific Conference Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Popup_Avatar_Mockup.png)**
  - Participants appear as bubbles on a canvas (the shape doesn’t really matter)
  - Users can move and scale those bubbles to make their own arrangement
  - Based on the “rank” of a user, it’s bubble initially appears larger
  - The state of any participant (muted, speaking, … ) changes the corresponding bubble’s appearance
  - Facecam and screen share are displayed in the bubble
    - This might cause it to change its shape
  - Groups could potentially be displayed as clusters connected by a “group bubble”

![User-specific Conference Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Popup_Avatar_Mockup.png "User-specific Conference Arrangement")
- **[Agar.io Styled Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Agar.io_Styled_Arrangement.png)**
  - More of a fun idea
  - Participants appear as bubbles on the screen and can “walk” around, using the arrow keys
  - The voice of people that are closer appears louder
  - It often happens that one gets bored when a video call becomes too long
    - This idea might help in staying focused and prevent people from doing something else
    - It also helps detecting inactive users 

![Agar.io Styled Arrangement](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Agar.io_Styled_Arrangement.png "Agar.io Styled Arrangement")
    
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
- [Prototype 1](https://xd.adobe.com/view/2b2d7ce0-21a7-4684-ac29-a956077592ca-7e7e/grid)
- [Prototype 2](https://xd.adobe.com/view/99615182-12a9-434b-8e44-f15a70c31556-cc32/grid)

### User Study <a name="user_study"></a>
For conducting the user study, we created a [Study Protocol](https://github.com/eth-ait/hci-project-hci2020-group-08/blob/2020/Deliverables/Study%20Protocol.pdf) and a [Rating Form](https://docs.google.com/forms/d/e/1FAIpQLSebr7I3G2s7by578MRwiXRlNRDSrXhL84pf3HPX7f1ZPkRodQ/viewform).

The project is explained to the participant as follows: 
“*We want to adapt the user interface of video call tools such that they become easier to handle while providing more functionality. To do so, we created two prototypes that we would like to assess now. The prototypes are very basic and do not really implement the functionality but for now we just pretend as if they did so. Subsequently, you will receive some simple tasks for each of the prototypes. As soon as you complete a task, the message “Good Job” appears on the screen.*”

In summary, each participant is asked to perform the following taks on both prototypes:
- Create a room and let other people join.
- Change another user's level.
- Change the position and size of another user.
- Create a breakout-room, join it and share your screen.

## Prototype <a name="prototype"></a>
(Weeks 8-14)

    TODO
Describe your high-fidelity manual prototype.  
Describe your high fideltiy automatic prototype to the problem and the prototype you developed in more detail here.  
Create and upload a video "deliverables" folder of your final prototype (which will be used in the final presentation) and include the link here.  
In the code folder, document the readme file with build / run instructions.
