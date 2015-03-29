# miniProfiler
Simple haxe profiler.

## Usage

```haxe
var profiler = new Debugger();
profiler.start("banana");
// Some code
profiler.stop("banana");
profiler.dump();
```
