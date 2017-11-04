# Book Library

## Console Application

There is a console application demo.

```bash
./bin/library
```

Be sure the file is executable:

```bash
chmod +x bin/library
```

You can use `help` command to see all available commands.

## Web Application

To show the use of different formaters (in this case `HtmlFormater::Formater` in comparison to `AsciiFormater::Formater`)
there is a plain simple web app written using [Sinatra](http://www.sinatrarb.com/intro.html).

You can demo it if have [Sinatra](http://www.sinatrarb.com/intro.html) installed (can be done with `gem install sinatra`):

```bash
ruby lib/application/web/app.rb
```

**N.B.**

If you are using virtualbox and vagrant make sure you map the port:

```ruby
config.vm.network :forwarded_port, guest: 4567, host: 4567
```

Then run the app like following to be able to acces it on your host machine on `localhost:4567`:

```bash
ruby lib/application/web/app.rb -o 0.0.0.0
```

## Tests

There is a test suit, written with [Test::Unit](http://test-unit.github.io/).

```bash
rake test
```

Be sure the gem is installed:

```bash
gem install 'test-unit'
```