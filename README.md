
## gollum-omnigollum-docker

[![Gem Version](https://badge.fury.io/rb/gollum.svg)](http://badge.fury.io/rb/gollum)

Dockerfile which utilizes ruby:alpine for its small size.

Provides basic setup for gollum with authentication via GitHub
- [gollum](https://github.com/gollum/gollum) with [github-markup](https://rubygems.org/gems/github-markup/versions/3.0.4) support
- [omnigollum](https://github.com/arr2036/omnigollum)
- [omniauth-github](https://github.com/omniauth/omniauth-github)
  
#### Setup & Usage
- You *must* mount /home/wiki of the container otherwise changes will be lost
- **Important**: for a first install, make sure to run `git init` in the folder you mounted to initialize an empty git-repository which is required by [gollum](https://github.com/gollum/gollum)
- You need to create a GitHub [OAuth App](https://github.com/settings/developers) to obtain the required credentials
- (make sure your provided emai address is **public** on your GitHub profile)


```bash
$ docker run -it -p 4567:4567
        -e CLIENT_ID=*YOUR GITHUB CLIENT_ID*
        -e CLIENT_SECRET=*YOUR GITHUB CLIENT_SECRET*
        -e AUTH_EMAILS=your@email.com
        -v wiki:/home/wiki 
        alexkainzinger/gollum-omnigollum-docker
```
AUTH_EMAILS can also be a list of email addresses

```bash
$ docker run -it -p 4567:4567
        -e CLIENT_ID=*YOUR GITHUB CLIENT_ID*
        -e CLIENT_SECRET=*YOUR GITHUB CLIENT_SECRET*
        -e AUTH_EMAILS=first@example.com,second@example.com,third@example.com
        -v wiki:/home/wiki 
        alexkainzinger/gollum-omnigollum-docker
```

## To build your own Docker image use
```bash
$ docker build -t gollum-omnigollum-docker .
```