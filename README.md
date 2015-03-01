# purescript-asap

PureScript bindings for the
[`asap`](https://github.com/kriskowal/asap) task scheduler, with the
`asap` code included in the package, to avoid issues with module
loaders or the absence thereof.

This module currently bundles version 2.0.1 of `asap`.

## Usage

```purescript
module Main where

import Control.Asap.Browser
import Debug.Trace

main = do
  schedule $ trace "Hello sailor!"
  trace "Hello world!"
```

The above example would print `Hello world!` first, then print `Hello
sailor!` immediately afterwards.

Note that there are two versions of the `Control.Asap` module:
`Control.Asap.Node`, which expects a Node.js environment, and
`Control.Asap.Browser`, which expects a browser environment. It is
left to the user to pick the correct one.

## Documentation

* [Module documentation](docs/Module.md)

## License

`asap` is copyright 2009-2014 by its contributors and is published
under the MIT license. `purescript-asap` shares this license and
copyright notice. Please refer to the
[`asap` web page](https://github.com/kriskowal/asap) for the exact
notice.
