# Module Documentation

## Module Control.Asap.Browser

#### `Asap`

``` purescript
data Asap :: !
```


#### `schedule`

``` purescript
schedule :: forall e. Eff (asap :: Asap | e) Unit -> Eff (asap :: Asap | e) Unit
```

Takes an effect of type `Eff e Unit` and executes it as soon as possible,
but after the current event has completed, and after previously
scheduled jobs.


## Module Control.Asap.Node

#### `Asap`

``` purescript
data Asap :: !
```


#### `schedule`

``` purescript
schedule :: forall e. Eff (asap :: Asap | e) Unit -> Eff (asap :: Asap | e) Unit
```

Takes an effect of type `Eff e Unit` and executes it as soon as possible,
but after the current event has completed, and after previously
scheduled jobs.
