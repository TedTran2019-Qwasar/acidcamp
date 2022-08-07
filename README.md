# Acidcamp

Acidcamp is a Basecamp clone; a project management and team communication application. I built this project using Rails 7 + TailwindCSS. 

## Setup
```bash
rails server
bin/rails tailwindcss:watch
# OR # bin/dev
```

## Gems/Tools used
- Devise for authentication
- Pundit and Rolify for authorization
- ActiveStorage to upload, preview, display, and download images
- ActionCable + Turbo Streams to utilize websockets for real-time discussion rooms
- Hotwire (Turbo and Stimulus) to increase responsiveness
- TailwindCSS and DaisyUI for styling
- PostgreSQL - Database
