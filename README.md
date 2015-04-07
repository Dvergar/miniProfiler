# miniProfiler
Simple haxe profiler.

## Usage

```haxe
var profiler = new Debugger("mydebugger");
profiler.start("banana");
// Some code
profiler.stop("banana");
profiler.dump();
```

`profiler.dumpWeb()` if you want to have a browser view at `http://localhost:2000/debugger.n?mydebugger`

_Note: You can also get the profiler `Debugger` instance via `Debugger.get("mydebugger")`_

## TODO

* Real-time states views
* Dump of arbitrary data on disk (e.g. game map)
