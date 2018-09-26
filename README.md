## Instagram automator based on Selenium.
# How to use?
1. Setup & start script: 
```
bundle
irb -r ./base_app.rb
```
## Chrome browser required!

# Image-liker: 
2. Sign in:
```
p = PageLiker.new
p.prepare
```
2. Run script
```
p.execute
```

# AutoFollower: 
2. Sign in:
```
p = FollowersManager.new
p.prepare
```
2. Run script
```
p.execute
```
