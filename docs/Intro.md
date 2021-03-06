## Actions

The cornerstone of any Espresso app.

Namely, actions are the workhorses that creates the routes to be served by app, as well as running our code.

If we need user to see "Hello World!" when he visits "/hello" address in the browser, we simply do like this:

```ruby
def hello
  "Hello World!"
end
```

It is really straightforward to define actions in Espresso cause they are usual Ruby methods.


**[ [contents &uarr;](https://github.com/espresso/espresso#tutorial) ]**


## Controllers


A controller is meant to organize and setup actions.

The basic setup is base URL. It is defaulted to the controller's underscored name and are used by all actions.

Other setups are action-specific and can be set for N or for all actions.<br/>
To define a setup for all actions, simply call appropriate method at controller's class level.<br/>
To setup specific actions, call appropriate methods inside `setup` proc that will accept action names as arguments.<br/>
Action names can also be given as regular expressions.

**Example:** - Creating a controller that will serve "/pages/latest" and "/pages/rss" URLs

```ruby
class Pages < E

  # setup for all actions
  charset 'UTF-8'

  # setup for `rss` action
  setup :rss do
    content_type '.rss'
  end

  def latest
    # ...
  end

  def rss
    # ...
  end
end
```

That's it, controllers are usual Ruby classes with inheritance from Espresso class.

**[ [contents &uarr;](https://github.com/espresso/espresso#tutorial) ]**


## Slices


A slice is meant to organize and setup controllers.

The basic setup is, again, base URL. It is used by all controllers.

Other setups are controller-specific and ban be set for N or all controllers.

A slice is a usual Ruby module containing Espresso controllers.<br/>
It can be mounted under any path that will serve as base URL for all controllers inside.

**Example:** - Create a slice that will serve "/cms/articles", "/cms/news" and "/cms/pages" URLs

```ruby
module Cms

  class Articles < E
    # ...
  end

  class News < E
    # ...
  end

  class Pages < E
    # ...
  end
end

app = Cms.mount '/cms'
app.run
```

To setup controllers, simply pass a block to `mount` method.

Let's say we have N controllers that using Haml engine.<br/>
Then we simply do like this:

```ruby
app = Cms.mount '/cms' do
  engine :Haml
end
app.run
```

When you need to setup only some specific controller,
use the mount block with a single param that will be set to the controller actually being configured.

```ruby
app = Cms.mount '/cms' do |ctrl|
  engine :ERB if ctrl == Cms::Articles
end
```

**[ [contents &uarr;](https://github.com/espresso/espresso#tutorial) ]**

## Applications

Applications are meant to bundle, setup and run controllers and slices.

To create a Espresso application use `EApp` class:

```ruby
class MyController < E
  # ...
end

app = EApp.new
app.mount MyController
app.run
```



## MVC?


Though you can create MVC applications by using Espresso Framework,
it does not actually impose any design patterns.

You are the creator and you are free to choose how to develop your app.


**[ [contents &uarr;](https://github.com/espresso/espresso#tutorial) ]**

## Models?

Espresso by itself does not deal with models, migrations etc.

It is the responsibility of the ORM you choose to use.


**[ [contents &uarr;](https://github.com/espresso/espresso#tutorial) ]**
