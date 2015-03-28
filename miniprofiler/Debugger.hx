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


class Debugger
{
	public static var debuggers:Map<String, Debugger> = new Map();
	public static var modules:Map<String, Module> = new Map();
	static var lastDump:Float = 0;
	static var ids = 0;
	static var haxeTrace:Dynamic->haxe.PosInfos->Void;

	var name:String;
	public static var traces:Array<String> = new Array();

	public function new(?debuggerName:String)
	{
		checkServer();
		name = debuggerName;
		if(name == null) name = "dummy" + ids++;
		debuggers.set(name, this);

		haxeTrace = haxe.Log.trace;
		haxe.Log.trace = myTrace;
	}


    private static function myTrace(v:Dynamic, ?inf:haxe.PosInfos)
    {
    	haxeTrace(v, inf);
        traces.push(inf.fileName + ":" + inf.lineNumber + ": " + Std.string(v));
    }

	macro static function checkServer() {
		trace("Checking server status...");
		var serverRunning = false;
		try
		{
			haxe.Http.requestUrl("http://localhost:2000/debugger.n");
			trace("Server is already running");
		}
		catch(e:Dynamic)
		{
			trace("Server isn't running");
			trace("Starting server:");
			var nekoFilePath = haxe.io.Path.directory(haxe.macro.Context.resolvePath('miniprofiler/Debugger.hx'));
			new sys.io.Process("nekotools", ["server", "-p", "2000", "-h", "localhost", "-d", nekoFilePath]);
			trace("Open http://localhost:2000/debugger.n in your browser");
		}
		return macro "dummy";
	}

	public static function get(debuggerName:String)
	{
		return debuggers.get(debuggerName);
	}

	public function start(name:String)
	{
		var module = modules.get(name);
		if(module == null) module = new Module(name);

		module.startTime = haxe.Timer.stamp();
		modules.set(name, module);
	}

	public function stop(name:String)
	{
		var module = modules.get(name);
		if(module == null) return;
		module.duration += haxe.Timer.stamp() - module.startTime;
		module.iterations++;
	}

	public function dump(?dumpRate:Float=0)
	{
		if(haxe.Timer.stamp() - lastDump < dumpRate) return;

		for(module in modules)
		{
			var time = (module.duration / module.iterations) * 1000;
			time = Std.int(time * 100) / 100;

			var stringLeft = '###### Module \'${module.name}\'';
			var spaces = 25 - stringLeft.length;
			for(i in 0...spaces) stringLeft += ' ';

			trace(stringLeft + ' : $time ms');
		}

		lastDump = haxe.Timer.stamp();
	}


	public function dumpWeb(?dumpRate:Float=0)
	{
		if(haxe.Timer.stamp() - lastDump < dumpRate) return;

		var stats = new Array<{name:String, value:Float, iterations:Int}>();
		// var dump = {name:String, datas:Array<Stat>};

		for(module in modules)
		{
			var time = (module.duration / module.iterations) * 1000;
			time = Std.int(time * 100 / 100);
			stats.push({name: module.name, value: time, iterations:module.iterations});
		}

		lastDump = haxe.Timer.stamp();

		// SEND
		var http = new haxe.Http("http://localhost:2000/debugger.n?name=" + name);
		http.setPostData(haxe.Json.stringify({datas:stats, traces:traces}));
		http.request(true);

		traces = [];
	}
}