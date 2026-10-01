---
tagline: Project interaction for Emacs
intro: >-
  In a nutshell - Projectile knows where your project starts and ends. You
  can jump to any file in it, search it, run its tests and switch to another
  project with just a couple of keystrokes. It's been doing this since 2011.
install: M-x package-install RET projectile RET
heroMedia: media/switch-project.gif
heroAlt: Switching to another project and narrowing its files down to the one to open
featuresTitle: What it's like
restIntro: >-
  Projectile packs a lot of features, and its menu (s-p m) lists all of them.
  Here are a few more that didn't fit above:

steps:
  - >-
    Install it. Projectile is on NonGNU ELPA, which Emacs knows about out of
    the box, so <kbd>M-x package-install RET projectile RET</kbd> is all it
    takes.
  - >-
    Turn it on and give it a prefix key. Projectile doesn't take one for
    itself, so pick whatever you like:
    <code>(projectile-mode +1)</code> and
    <code>(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)</code>.
  - >-
    Open any file in a git repository (or any directory with a
    <code>.projectile</code> file in it) and press <kbd>s-p f</kbd>. That's
    pretty much it - <kbd>s-p m</kbd> will show you everything else.
stepsNote: >-
  The [getting started guide](https://docs.projectile.mx/projectile/getting_started.html)
  will take you from a fresh install to a setup you're happy with in a few
  minutes.
outro: Keep hacking!
---

Projectile started in the summer of 2011, simply because I was frustrated that
`find-file-in-project` didn't work on Windows. I've been its primary author
and maintainer ever since, and it remains one of my favorite projects (and the
one I use the most).

Fifteen years and three major versions later, it knows nearly a hundred kinds
of project, indexes them without freezing Emacs, and gets along fine with the
built-in `project.el`.
[More than 400 people](https://github.com/bbatsov/projectile/graphs/contributors)
have contributed to it over the years, and its development is funded by its
users.
