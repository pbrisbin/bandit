> [!NOTE]
> All of my GitHub repositories have been **archived** and will be migrated to
> Codeberg as I next work on them. This repository either now lives, or will
> live, at:
>
> https://codeberg.org/pbrisbin/bandit
>
> If you need to report an Issue or raise a PR, and this migration hasn't
> happened yet, send an email to me@pbrisbin.com.

# Bandit

Bandit is a simple tool inspired by the great [albumbler][] by Kyle 
Keen. Bandit uses a reward-maximizing strategy known as [multi-armed 
bandit][mab] to consistently find and play good music from your 
collection.

### How it works

Bandit does one thing when executed: choose and play an album.

*Some of the time*, Bandit will choose an album at random (exploration).

Depending on how long you let that album play before invoking Bandit 
again, that album's "worth" will be adjusted.

*Most of the time*, Bandit will choose the album which has the 
highest worth at this time (exploitation).

Obviously, this means Bandit needs to be used for a while before you see 
any sort of intelligence emerge.

### Getting started

~~~ 
$ git clone https://github.com/pbrisbin/bandit
$ cd bandit
$ bundle install
$ bundle exec bin/bandit  # to just try it out
$ rake install            # to install for reals
~~~

### Configuration

For now, Bandit's behavior/strategy can be configured only by editing 
`lib/bandit/config.rb` directly.

Player-interaction is accomplished by defining a `Player` subclass and 
assigning its instance in `config.rb`. You can see how the default 
`Players::Mpc` is written/used for guidance in writing others.

### Status

Bandit currently *functions*, that is, he chooses albums and makes 
adjustments according to his specs.

That said, I haven't used it long enough to know if the approach 
actually *works*.

[albumbler]: https://github.com/keenerd/albumbler
[mab]:       https://en.wikipedia.org/wiki/Multi-armed_bandit
