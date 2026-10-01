---
tagline: Project interaction for Emacs
intro: >-
  Projectile knows where your project starts and ends. Jump to any file in it,
  search it, run its tests, and hop over to the next project, all from a
  couple of keystrokes and without leaving whatever you were doing. It's been
  doing that since 2011.
install: M-x package-install RET projectile RET
heroMedia: media/switch-project.gif
heroAlt: Switching to another project and narrowing its files down to the one to open
featuresTitle: What it's like
restIntro: >-
  Projectile is a big toolbox, and the menu (s-p m) lists all of it. A few of
  the things that didn't fit above:

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
    the whole idea. <kbd>s-p m</kbd> shows everything else.
stepsNote: >-
  The [getting started guide](https://docs.projectile.mx/projectile/getting_started.html)
  goes from a fresh install to a setup you'll keep in a few minutes.
outro: Keep hacking!
---

Projectile started in the summer of 2011, simply because I was frustrated that
`find-file-in-project` didn't work on Windows. I've been its primary author
and maintainer ever since, and it's still the project I reach for every single
day.

Fifteen years and three major versions later, it knows nearly a hundred kinds
of project, indexes them without freezing Emacs, and gets along fine with the
built-in `project.el`. It's been shaped by
[more than 400 contributors](https://github.com/bbatsov/projectile/graphs/contributors)
and is funded by the people who use it.
