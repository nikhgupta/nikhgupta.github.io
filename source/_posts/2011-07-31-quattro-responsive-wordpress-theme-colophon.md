---
layout: post
title: ! 'Quattro and its Colophon'
description: "A responsive WordPress theme"
tags: [css3, html5, design, wordpress]
category: code
published: true
kind: article
comments: true
created_at: 2011-07-31 12:46:31 +05:30
---

So, Yeah! I know. I switched to [Jekyll](http://jekyllrb.com/)  for a very
short phase, owing to the attraction it has to developers and 'blog-hackers'.
But, then, I soon started missing some of the advanced  functionality
provided by WordPress, such as custom fields, granular designs, post formats,
custom posts, etc.

So, I finally switched back to WordPress. The old Jekyll site can still be
seen on: [Github Pages](http://nikhgupta.github.com), which will, from now on,
only host documentations about my [Github public
repositories](https://github.com/nikhgupta/repositories).

<!-- more -->

When I switched to WordPress, I found myself converting the previous template
again for WordPress, which was not what I really wanted to do, since it was
boooooring! And, hence, I decided to create a new WordPress theme which will
have some of the advanced functionality, I wanted, along with a unique design.

I named the theme **Quattro**, owing to the heavy usage of the font:
**Quattrocento** for primary styling, by this theme. Moreover, I wanted this
theme to be HTML5 and CSS3 ready. So, I, carefully, selected the [Starkers
HTML5 theme](http://nathanstaines.com/archive/starkers-html5)  framework by
[Nathan Staines](Nathan Staines)  as the base framework for this theme.

<!--
### Screenshots
[gallery columns="4"]
-->


### Responsive Web Design

This theme utilizes the concept of
[media-queries](http://www.w3.org/TR/css3-mediaqueries/) and [responsive web
design](http://www.alistapart.com/articles/responsive-web-design/)  to target
devices with specific max-width. Try resizing your browser window and the
theme will try to adjust according to your browser width. Nice, right?

Well, there is more to it. The real benefit of this design layout is seen when
you will try to visit this site using a mobile browser, for example. The
design adjusts itself to fit the narrow width of the mobile browser, as
opposed to displaying a design which was, initially, designed for a 1200+ px
wide screen. :)


### Post Formats

This theme makes extensive use of [WordPress post
formats](http://codex.wordpress.org/Post_Formats) to render different post
formats in different styles. For example, a post with a post format of Gallery
is displayed to be, specifically, displayed as a photo gallery. The following
post formats are defined for this theme (and the description tells how these
formats are implemented in this theme):

- **Aside**: Styled without a title. Similar to a Facebook note update.
- **Gallery**: A gallery of images.
- **Image**: A single image. This image is not linked to its attachment page.
- **Quote**: A quotation. Stylized in Orange text. Quote author is displayed
  for this quote.
- **Status**: A short status update, similar to a Twitter status update.
  Update date is displayed for this status, e.g. [this status
  update](http://nikhgupta.com/status-updates/a-responsive-design/).

Moreover, this theme makes use of two more post formats (well, they are not
actually post formats, but a similar functionality is achieved by using
[Custom Fields](http://codex.wordpress.org/Custom_Fields)  and [J-Flickr
plugin for WordPress](http://wordpress.org/extend/plugins/j-flickr/)):

- **Flickr Gallery**: similar to Gallery post format. Except that, the images
  for this gallery are directly fetched from a Flickr photoset, or photo
  collection.    This gallery is
  [lightbox](http://www.lokeshdhakar.com/projects/lightbox2/)  aware. Also,
  a single gallery can contain more than one photosets or photo collections.
- **Flickr Images**: similar to Images post format. Except that, the image is
  directly fetched from Flickr. These posts can contain more than one images.
  Ideally, a Flickr Gallery is for photosets, and Flickr Images is for photos.

### Home Page (Content Slider)

If you noticed the [homepage](/), it is made up of a content slider, which
uses [bxSlider](http://bxslider.com) to create the sliding content effect
using [jQuery](http://jquery.com). This content slider is enabled as a [Page
Template](http://codex.wordpress.org/Pages#Page_Templates) and hence, allows
me to re-use it for more pages.

### ToDo List

- Add support for Tasks (ToDo Lists)  [Custom Post Type](http://bxslider.com/)
- Add various shortcodes for easy styling and for download buttons, etc.
- Add post format: **Chat**
- <del datetime="2011-07-31T06:37:58+00:00">Display related posts on 404 pages</del>
- Also, post to Facebook and Twitter when a status update is made.
