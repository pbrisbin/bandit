# Bandit

Bandit is a simple tool inspired by the great [albumbler][] by Kyle 
Keen. Bandit uses a reward-maximizing strategy known as [multi-armed 
bandit][mab] to consistently find and play good music from your 
collection.

### How it works

Bandit does one thing when executed, choose and play an album.

30% of the time, Bandit will choose an album at random (exploration). 

Depending on how long you let that album play before invoking Bandit 
again, a worth will be assigned or adjusted for that album.

The other 70% of the time, Bandit will choose the album which has the 
highest worth at this time (exploitation).

Worth is assigned as follows:

Play time   Adjustment 
----------  -----------  
< 2m        -1
2-10m       +1
11-60m      +3
>= 60m      +5

Obviously, this means Bandit needs to be used for a while before you see 
any sort of intelligence.

### Getting started

~~~ 
$ git clone https://github.com/pbrisbin/bandit
$ cd bandit
$ bundle install
$ bundle exec bin/bandit # to try it out
$ rake install # to install for reals
~~~

[albumbler]: https://github.com/keenerd/albumbler
[mab]:       https://en.wikipedia.org/wiki/Multi-armed_bandit
