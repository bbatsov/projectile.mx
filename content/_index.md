---
tagline: Project interaction for Emacs
lead: >-
  Projectile knows where your project starts and ends. Jump to any file,
  search and replace across it, build, test and run it, and hop between
  projects, all with a few keystrokes.
install: M-x package-install RET projectile RET
heroMedia: media/switch-project.gif
heroAlt: Switching to another project and narrowing its files down to the one to open
featuresTitle: Everything, scoped to your project

pillars:
  - title: Fast
    icon: "&#187;"
    blurb: >-
      Indexing runs in the background, uses git and friends when they're
      around, and stays quick over TRAMP. Big repositories don't freeze Emacs.
  - title: Knows your project
    icon: "&#9673;"
    blurb: >-
      Nearly a hundred project types, from Cargo and Gradle to Phoenix and
      Next.js, each with its own build, test and run commands.
  - title: Fits right in
    icon: "&#10003;"
    blurb: >-
      Plain completing-read, so Vertico, Consult and friends just work, and a
      proper project.el backend for everything built on it.

steps:
  - title: Install
    body: >-
      Projectile is on NonGNU ELPA, which Emacs enables out of the box:
      <kbd>M-x package-install RET projectile RET</kbd>
  - title: Pick a prefix
    body: >-
      Turn it on and give its commands a prefix:
      <code>(projectile-mode +1)</code> and
      <code>(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)</code>
  - title: Go
    body: >-
      Open any file in a repository, then <kbd>s-p f</kbd> finds a file,
      <kbd>s-p p</kbd> switches projects and <kbd>s-p m</kbd> shows every
      command in a menu.
---

Projectile has been around since 2011 and happily coexists with `project.el`,
so tools built on either work in your projects.
The [getting started guide](https://docs.projectile.mx/projectile/getting_started.html)
takes you from a fresh install to productive in a few minutes.
