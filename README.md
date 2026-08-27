# Awesome WM - Slot

A declarative API to connect signals for the Awesome WM.

```lua
slot {
   target = naughty,
   signal = "request::display",
   slot = function ()
      return function(n)
         naughty.layout.box {
            notification = n,
         }
      end
   end,
}
```

## Documentation

API references for the git-master version is available at <https://aire-one.github.io/awesome-slot/index.html>.

### Generating the online doc

The doc is automatically built using the GitHub Actions workflow
[`.github/workflows/doc.yaml`](.github/workflows/doc.yaml) at every push on the
master branch.

The workflow can be manually triggered to rebuild the doc.

### Building the doc

It is also possible to manually build the documentation locally using ldoc. The
documentation content is part of the source code, and all configurations needed
are provided by the `config.ld` file.

To generate documentation, run :

```sh
make ldoc
```

The documentation site will be generated in the `doc` directory.
