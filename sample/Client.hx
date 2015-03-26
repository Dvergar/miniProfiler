import miniprofiler.Profiler;
import haxe.macro.Expr;


class Client
{
	static function main()
	{
		new Profiler("mydebugger");

		while(true)
		{
			Profiler.get("mydebugger").start("test");
			Sys.sleep(Math.random());
			Profiler.get("mydebugger").stop("test");

			Profiler.get("mydebugger").start("test2");
			Sys.sleep(Math.random() / 2);
			Profiler.get("mydebugger").stop("test2");
			
			Profiler.get("mydebugger").dumpWeb();
		}
	}


}