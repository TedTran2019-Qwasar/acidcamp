# Basecamp

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
