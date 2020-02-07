## About the architecture

**Middleman** is a static site generator using all the shortcuts and tools in modern web development. Check out [middlemanapp.com](http://middlemanapp.com/) for detailed tutorials, including a [getting started guide](http://middlemanapp.com/basics/getting-started/).

**Netlify CMS** is a CMS for static site generators. Give non-technical users a simple way to edit and add content to any site built with a static site generator.

### Make it work on your machine

Be sure to check out the [middleman installation guide](https://middlemanapp.com/basics/install/)
```
$ git clone ck-arquitetura??
$ cd ck-arquitetura
$ docker build -t ck-arquitetura .
$ docker run -it -p 4567:4567 -v /path/to/ck-arquitetura:/usr/src/app ck-arquitetura bash
$ bundle exec middleman
```
