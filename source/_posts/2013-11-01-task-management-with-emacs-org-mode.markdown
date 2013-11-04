---
layout: post
title: "Task Management with Emacs' Org Mode"
date: 2013-11-01 19:40
comments: true
categories: code, emacs
tags: emacs, organize
published: false
---

I am sure you must have heard of Emacs, and its really insanely famous Org Mode!
For the illiterates, Org Mode is an organizer, outline and planner tool written
for the magnanimous Emacs editor. It has numerous applications, among which the
more widely used ones being:
- Project management
- Task management
- Tracking your habits
- Writing presentations
- and so on and on..

I wanted to jot down my workflow on using Org mode as a personal task manager,
and also, write down what features I, still, need to be accomplished. This post
is meant for the persons already familiar with org-mode, while my [org mode
setup] is a self-explanatory resource for people unfamiliar with org-mode. This
post will always have an `updated_on` tag, which will identify when I have last
updated my workflow here.

Firstly, I use a single file for capturing and refiling my tasks. I use the
`org-capture` tool to capture tasks, quickly. When refiling, I use the
`ido-mode` to quickly find the relevant targets. I use several tags that help me
identify the kind of task, as well as these tags are inherited down the
headings.

### Start
I have a dedicated start-page for my Emacs, which lists certain important things
for me, esp. the location to some important files, and a link to write a blog
post quickly.

### Efforts
Efforts are tracked for the following durations: 10 minutes, 30 minutes, 1 hour,
2 hour, 3 hour and 4 hour long tasks. At times, there are tasks when I am unsure
on how long a task would take, and for such tasks I prefer not setting up any
effort property.

### Logging
I am logging almost everything - whenever I repeat a task (required for tracking
habits), when I am rescheduling a task, or resetting the deadline. Moreover,
I log when I have refiled, started and completed a given task.

### Todo Workflow
Org mode allows us to define several kind of workflows by manipulating the task
type. For example, I use the workflow: `TODO > NEXT > STARTED > DONE` to manage
the lifetime of a typical task. Moreover, as a developer I use: `REPORT > BUG
> KNOWNCAUSE > FIXED` workflow, as well.

I have several special todo types that allow me to give special meaning to
a task, such as: REVIEW (tasks which need to be reviewed for some purpose),
HABIT (tasks which are being tracked as a habit), DUPE (a duplicate task),
WAITING, SOMEDAY, and so on. I, also, have a CANCELLED tag, which identifies
tags that I have cancelled because of some reason, and that reason is logged
when cancelling such a task. The HOLD tag allows me to mark tasks which are on
hold for some reason, and will be completed sometime in future, when the reason
has vanquished.

### Private Content / Encryption
I use `org-crypt` and `epa-file-encrypt` to quickly encrypt a particular
section, or the entire file, respectively.
