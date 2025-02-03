---
layout: default
permalink: /
---

The idea of DTF is to provide easy-to-understand design tags to authors, so they can focus on writing and do not have to worry about formatting their content with HTML/CSS.
A theme that uses the DTF provides the actual `.html` and CSS files so the design tags render nicely.

The concept is simple, the DTF Plugin provides `design_element`s that can be used in writing pages.
A `design_element` is usually grouped in a `design_group`. Both can accept paramters, similar to the `{% raw %}{% include %}{% endraw %}` tag. For example,

{% highlight liquid %}{% raw %}
{% design_group title="My Group" %}
{% design_element title="Element 1" %}
{% enddesign_group %}
{% endraw %}{% endhighlight %}

Instead of setting each argument as parameters, they can be given as variable.
For instance, the author might want to display elements from a collection or related posts, a quick and easy way to display this would be:

{% highlight liquid %}{% raw %}
{% design_group title="My Posts" %}
{% for post in site.posts %}
{% design_element post %}
{% endfor %}
{% enddesign_group %}
{% endraw %}{% endhighlight %}

Note that if these tags are embedded in a mardown file, you should not use any indentation because it will cause the markdown parser to parse it as code!

## Pre-defined tags

The DTF comes with several pre-defined tags that can be used, these are inspired by common design elements found on different Jekyll websites.
The logic is almost always the same, but the theme can display them differently.
A limited set of parameters is mandatory, but the theme can use any specified parameter.

| Tag Type | Concept | Mandatory Parameters | Optional Parameters |
|---|---| --- |
| `post_group` | A collection of posts. |  | `title`, `link` |
| `post_element` | A single post | `title`, `author`, `url`, `date` | `description`, `teaser-image`, `image` |
| `project_group` | A collection of projects. | | `title`, `link` |
| `project_element` | A single project | `title` | `author`, `url`, `image`, `description` |
| `feature_group` | A collection of features | | `title`, `link` |
| `feature_element` | A single feature | `title`, | `url`, `description`, `icon-path`, `icon-class` |
| `alert_box` | An alert box, needs to be closed with a liquid `endalert_box` tag | | `variant` |
| `author_element` | An element to display information of the current author. |  See <a href="#authorlogic">Author Logic</a> |
| `picture_element` | A responsive picture | `src`, `alt` | `size-hint`, `height`, `class` |
| ... | | | |

... with more to come.

More elements can be easily included and you can contribute them in a Merge Request.
Just make sure they focus on the key design element that an author of a post or page wants to convey.

## Defining the Base HTML files

Each tag will look under `_includes/dtf/{:type}.html` for usable file. E.g., the `{% raw %}{% post_element %}{% endraw %}` will search for `_includes/dtf/post_element.html`.

If you use the main `design_group` or `design_element` you can define use addiitonal types using the `type` parameter.
E.g., `{% raw %}{% post_element type="box_element" %}{% endraw %}` will use the type parameter to look for `_includes/dtf/box_element.html`.

A minimalistic template for a `design_group` is:

{% highlight html %}{% raw %}
<div class="{{ group.classes }}">
    <h2>{{ group.title }}</h2>

    {{ content }}
</div>
{% endraw %}{% endhighlight %}

A minimalistic template for a `design_element` is:

{% highlight html %}{% raw %}
<div class="{{ element.classes }}">
    <h2>{{ element.title }}</h2>
</div>
{% endraw %}{% endhighlight %}


<h2 id="authorlogic">Author Logic</h2>

Each post should have an author. This theme uses the logic of the [Jekyll SEO Tag](https://github.com/jekyll/jekyll-seo-tag), which means:

1. The author is defined in `page.author`, if empty `site.author` is used.
2. If the author is a YAML object, it is directly used, if it is a string, the corresponding entry in `_data/authors.yml` is loaded.


## Utilities

If you specifc `generate_favicons: true` in the `_config.yml`, the plugin will call imagemagick to generate icons in the output folder:

- /favicon.ico (size 48x48)
- /favicon512x512.png (large, e.g., for the large icon on the home screen)
