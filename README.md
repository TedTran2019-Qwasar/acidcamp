# Acidcamp

Acidcamp is a Basecamp clone; a project management and team communication application. I built this project using Rails 7 + TailwindCSS. 

## Setup
```bash
bundle install
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
- Kaminari for pagination
- TailwindCSS and DaisyUI for styling
- PostgreSQL - Database
- RSpec w/ Shoulda-matchers - Testing

## Conclusions
I'd rather use React + Redux for my frontend instead of Hotwire. This was fun, but I wouldn't do it again. I'll be probably using this repository to test new Rails 7 features as they're released or to test out gems. Since this won't be deployed, I won't style the application beyond playing around with TailwindCSS + DaisyUI. 
