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

_Note: You can also get the profiler `Debugger` instance via `Debugger.get("mydebugger")`_
