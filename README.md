# vbox-ctl.sh

## Requirements

+ Virtualbox (https://www.virtualbox.org/wiki/Downloads)

## Usage

List instances.

```
$ vbox-ctl.sh index
```

Setup an instance.

```
$ vbox-ctl.sh setup <name>
```

Show the instance information.

```
$ vbox-ctl.sh show <name>
```

Start the instance.

```
$ vbox-ctl.sh start   <name>
$ vbox-ctl.sh poweron <name>
```

Gracefully shutdown the instance.

```
$ vbox-ctl.sh acpipowerbutton <name>
$ vbox-ctl.sh softpoweroff    <name>
```

Stop the instance.

```
$ vbox-ctl.sh stop     <name>
$ vbox-ctl.sh poweroff <name>
```

Delete the instance.

```
$ vbox-ctl.sh destroy <name>
$ vbox-ctl.sh delete  <name>
$ vbox-ctl.sh remove  <name>
```

Contributing
------------

1. Fork it ( https://github.com/[my-github-username]/vbox-ctl.sh/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

License
-------

[Beerware](http://en.wikipedia.org/wiki/Beerware) license.

If we meet some day, and you think this stuff is worth it, you can buy me a beer in return.
