import miniprofiler.Profiler;


class Client
{
	static function main()
	{
		// var cnx = haxe.remoting.HttpAsyncConnection.urlConnect("http://localhost:2000/server.n");
		// cnx.setErrorHandler( function(err) { trace('Error: $err'); } );
		// cnx.Server.foo.call([1,2], function(data) {trace('Result: $data');} );
		// var http = new haxe.Http("http://localhost:2000/server.n");
		// http.setPostData("hello2");
		// http.request(true);

		while(true)
		{
			Profiler.start("test");
			Sys.sleep(Math.random());
			Profiler.stop("test");

			Profiler.start("test2");
			Sys.sleep(Math.random() / 2);
			Profiler.stop("test2");
			
			Profiler.dumpWeb();
		}
	}
}