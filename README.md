<p align="center">
 <img src="https://user-images.githubusercontent.com/19203626/75708200-4899d380-5cb8-11ea-9d3b-6dc83360c7bf.png" alt="TrianglePattern Logo"/>
</p>

With this gem you can generate placeholder images (e.g. Backgrounds, Profile Pics etc.) for your project. It uses the Delaunay triangulation to generate a mesh of triangles.

| | |
|:-------------------------:|:-------------------------:|
|<img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://user-images.githubusercontent.com/19203626/75802209-a7c11c00-5d7c-11ea-9b89-6ccc3a0c37a4.png">  |  <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://user-images.githubusercontent.com/19203626/75802265-bf98a000-5d7c-11ea-933f-750419ceb4c2.png">|<img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://user-images.githubusercontent.com/19203626/75802434-f8387980-5d7c-11ea-872d-1aa4b679bb71.png"> |
|<img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://user-images.githubusercontent.com/19203626/75802471-09818600-5d7d-11ea-974d-2d19c8fd3979.png">  |  <img width="1604" alt="screen shot 2017-08-07 at 12 18 15 pm" src="https://user-images.githubusercontent.com/19203626/75802747-86146480-5d7d-11ea-96a7-0a616f6bb994.png"> |


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'triangle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install triangle

## Usage

To create a pattern use:
```ruby
pattern = Triangle.generate
```

with specific width and height:
```ruby
pattern = Triangle.generate(width: 900, height: 500)
```

with a specific set of colors:
```ruby
pattern = Triangle.generate(colors: ["#edf8fb", "#b2e2e2", "#66c2a4", "#2ca25f", "#006d2c"])
```

![image](https://user-images.githubusercontent.com/19203626/75806052-43558b00-5d83-11ea-8ae0-5f76d59127ed.png)

get the pattern in svg:
```ruby
puts pattern.to_svg
# => <svg xmlns="http://www.w3.org/2000/svg" ...
```
get the Base64 encoded string:
```
puts pattern.to_base64
# => PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC...
```
## Options

You can pass several options to `Triangle.generate`

### width
Integer, defaults to 900. Width in pixels of the pattern to generate.

### height
Integer, defaults to 500. Height in pixels of the pattern to generate.

### cell_size
Integer, defaults to 75. Size of the mesh used to generate triangles. Larger values will result in coarser patterns, smaller values will result in finer patterns.

### variance
Decimal value between 0 and 1, defaults to 0.75. Amount of randomness used when generating triangles.

### seed
Integer, defaults to 135. Is used to seed the random generator which generates the points for the mesh

### colors

Array, defaults to `["#ffffe5","#f7fcb9","#d9f0a3","#addd8e","#78c679","#41ab5d","#238443","#006837","#004529"]`. Defines the colors uses in the pattern. TrianglePattern interpolates between the given colors to generate a gradient.

## Rake

```ruby
string = 'Mastering markdown'

require 'triangle/triangle_task'

Triangle::TriangleTask.new(
      name: 'generate', 
      description: '', data: {
        'fixtures/BuGn.svg' => { colors: ["#edf8fb", "#b2e2e2", "#66c2a4", "#2ca25f", "#006d2c"], width: 400, height: 400, seed: 80 },
        'fixtures/GnBu.svg' => { colors: ["#edf8fb", "#b3cde3", "#8c96c6", "#8856a7", "#810f7c"], width: 400, height: 400, seed: 90 },
        'fixtures/OrRd.svg' => { colors: ["#fef0d9", "#fdcc8a", "#fc8d59", "#e34a33", "#b30000"], width: 400, height: 400, seed: 100 },
        'fixtures/BrBG.svg' => { colors: ["#a6611a", "#dfc27d", "#f5f5f5", "#80cdc1", "#018571"], width: 400, height: 400, seed: 110 },
      }
    )
  end
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/triangle.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
