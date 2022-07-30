# my_basecamp_1
Creating a simple clone of BaseCamp

Since I usually roll my own user authentication, I'll use Devise this time around to learn more.
I'd also like to use Hotwire (Turbo and Stimulus) in this project as well if possible. 
I'm used to using a React frontend w/ Rails backend, but I think Hotwire is a tempting choice where the frontend doesn't need to be super dynamic.
I think I'll also use ActiveStorage + AWS to upload and display images. (Might have to disable this feature when turning the project in, unless the user provides their own key)

Looking at the provided gif: 
1. Users page (user model + user/session controller). 
  - Sign Up/Log In links depending what button you're on
2. Projects Page (projects model/controller, shows all projects. Buttons to filter by created by me/shared with me)
  - Links to add project, edit profile, and logout w/ icons (Logged In)
  - Can edit, delete, etc projects if admin (aka given admin privileges OR owner)
3. Edit Page, update name/description/add member with or without admin privileges
  - button to delete, link to project
4. Project Page: create new discussion, task, attachment (has many)
  - link to edit, can look at members, topics, tasks, and attachments
  - After adding, project page can see discussions, tasks, attachments
  - Can send text in discussions and edit/delete them

Messy README to plan out the project. Will edit to make a Github Wiki real fast
