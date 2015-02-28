package miniprofiler;


class Module
{
	public var duration:Float = 0;
	public var iterations:Int = 0;
	public var startTime:Float;
	public var name:String;

	public function new(name:String)
	{
		this.name = name;
	}
}


class Profiler
{
	public static var modules:Map<String, Module> = new Map();
	static var lastDump:Float = 0;

	public static function start(name:String)
	{
		var module = modules.get(name);
		if(module == null) module = new Module(name);

		module.startTime = haxe.Timer.stamp();
		modules.set(name, module);
	}

	public static function stop(name:String)
	{
		var module = modules.get(name);
		if(module == null) return;
		module.duration += haxe.Timer.stamp() - module.startTime;
		module.iterations++;
	}

	public static function dump(?dumpRate:Float=0)
	{
		if(haxe.Timer.stamp() - lastDump < dumpRate) return;

		for(module in modules)
		{
			var time = (module.duration / module.iterations) * 1000;
			time = Std.int(time * 100) / 100;
			trace('>>Module ${module.name} : $time ms');
		}

		lastDump = haxe.Timer.stamp();
	}

}