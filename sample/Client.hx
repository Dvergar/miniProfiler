import miniprofiler.Debugger;


class Client
{
	static function main()
	{
		var myDebugger = new Debugger("mydebugger");

		while(true)
		{
			myDebugger.start("test");
			Sys.sleep(Math.random());
			myDebugger.stop("test");

			trace("Hello World " + Std.string(Std.random(100)));

			myDebugger.start("test2");
			Sys.sleep(Math.random() / 2);
			myDebugger.stop("test2");
			
			myDebugger.dumpWeb();
		}
	}
}