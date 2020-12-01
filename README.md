# md.rb

Create and manage multiple markdown documents easily.

Some of the key features are:

0. Having a simple syntax and api
1. Generate, read, update and delete multiple markdown
2. Get json from markdown

# Install

```
gem install mdrb
```

```ruby
require 'mdrb'
```

# usage

Create markdown

```ruby
MD.create("first", "# Hello") #first.md
MD.create("first document", "# Hello") #first-document.md
```

Create multiple markdown

```ruby
MD.create_many(["first","second"], ["# first","# second"]) #first.md second.md

MD.create_many(["first document","second document"], ["# first","# second"]) #first-document.md second.md

```

Get json from markdown

```ruby
MD.create("first", "# first")
puts json = MD.to_json("first")
```

Update markdown

```ruby
MD.update(path, content)
MD.update_on(which_line, path, content)
MD.update_many()
```

Delete markdown

```ruby
MD.create_many(["first","second"], ["# first", "# second"])
MD.delete("first")
MD.delete_many(["first", "second"])
```

Read markdown

```ruby
MD.read()
MD.read_many()
```

# Testing

rspec

# license

MIT | ytbryan@hey.com
