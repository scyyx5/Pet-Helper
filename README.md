# Team Project: Pet helper
This project was originally hosted online, but due to the server's expiration, some functionalities may no longer work as expected. If you would like to see the project in action or have any questions, please contact me at anyaxiao0604@outlook.com.

The trained AI model is not included in this repository due to its large size. Please contact me if you would like to see the model.
## Overall

This application is aimed to help pet owners to raise their own pets and to encourage people who want a pet to own a pet, this application has many helpful functions such as a reminder calendar that reminds users to feed their pet, walk their pet and most importantly vaccinate their pet. For the AI part of the app when a new user registers the app, they can upload a picture of their pet and AI will identify if the user’s pet is either a Dog or Cat, and based on that user will have a different set of functions to assist them.

The demo of the project can be found [here](https://www.youtube.com/watch?v=cyL_EADUlVs&t=6s)

## Members:
1. Anya (Yujiao) Xiao
2. Zikun Zhang
3. Sarah  Alabdulqadere
4. Yousef Bazarah
5. Ryoki Kojima
6. Andrei-Robert Cuzenco



## Main Contribution of Anya Xiao
### Management
- Lead the team using Agile method, use Kanban to keep track of the progress of the project.
- Organize Scrum meeting at least third times a week to discuss the progress of the project.
- Assign tasks to team members and make sure the tasks are completed on time.
- Make sure the project is on track and the team is working efficiently.

### Interface:
- **Reminder:** Lead the implementation of push notifications.
- **Register Pet:** Improved the user interface (lead).

### API and Client-Server Communication:
- **Pet Related:** Developed all functionalities for PUT, DELETE pet by owner, and enabled image upload (lead).
- **Calendar Related:** Implemented all functionalities for GET, PUT, POST, DELETE (collaborated with Zikun).
- **User Related:** Developed all functionalities for login v2, register v2, close account, update, and get. Created a new version using the default ‘user’ model (mostly lead).
- **Command Related:** Developed all functionalities for version 1 (lead).
- **Others:** 
    - API authentication and updated all APIs with authentication (pair programming with Zikun).
    - Developed calendar, user, and setting model v2 (lead).
    - Conducted final checks and modifications for all APIs (with Ryoki).

### Testing:
- Led half of the system testing and fixed system testing issues (with Sarah and Ryoki).

### AI:
- Trained the model and wrote all code without backend connection.

### Database:
- Set up pet owner, user table, command, and added database updates according to requirements.

### Documentation:
- Authored API documentation versions 1 to 4 (lead).
- Created web-based API documentation (lead).
- Improved tech stack documentation.
- Compiled team organization and contribution report v2 (lead).

### Video Draft:
- Created mockup draft version one (lead).
- Improved drafts for Kanban, MVP, final product demonstration, and agile process draft v1 (lead).

### Other:
- Developed vertical slice version one (lead).
- Chose and implemented the agile method (lead).


## Instructions for pipeline deploy

### Setting up a new pipeline server
To setup a new server we first need some prerequisites installed.
#### Prerequisites
1. A ubuntu server or debian based server installed
2. The server has to be an x86-64 bit computer.
#### Installation
First install docker by using snap ``sudo snap install docker``. After that install gitlab runner by downloading the package using ``curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"`` and then install using the command ``dpkg -i gitlab-runner_amd64.deb``. Lastly for the pipeline to run, the gitlab runner needs to be registered using: 
``sudo gitlab-runner register -n \
  --url https://git-teaching.cs.bham.ac.uk \
  --registration-token REGISTRATION_TOKEN \
  --executor docker \
  --description "Docker Runner" \
  --docker-image "docker:19.03.12" \
  --docker-privileged \
  --docker-volumes "/certs/client" \
  --tag-list "ai, django, docker, flutter, test"``

After registration the pipeline should run and deploy to the server with the ip specified in the variable SERVER_IP with the key SERVER_PRIVATE_KEY and using a private dockerhub repo specified in the variable DOCKER_ACCESS_TOKEN.

