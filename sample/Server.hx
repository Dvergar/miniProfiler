import miniprofiler.Profiler;


class Server
{
    static function main() {
        // var ctx = new haxe.remoting.Context();
        // ctx.addObject("Server", new Server());

        // if(haxe.remoting.HttpConnection.handleRequest(ctx))
        // {
        //     return;
        // }

        // handle normal request
        // var idString = neko.Web.getCookies().get("id");
        // if(idString == null)
        // 	neko.Web.setCookie("id", "0");
        // else
        // {
        // 	var id = Std.parseInt(idString);
        // 	neko.Web.setCookie("id", Std.string(++id));
        // }

        // var caca = neko.Web.getCookies().get("caca");
        // if(caca != null) neko.Web.setCookie("caca", caca);

        // // id++;
        // // var ip = neko.Web.getClientIP();
        // // trace(ip);
        // trace(idString);
        // trace(caca);
        // trace("wat");
        var postData = neko.Web.getPostData();

        // BROWSER ACCESS
        if(postData == null)
        {
        	neko.Lib.print("<meta http-equiv='refresh' content='1'>");
        	// var stats:Map<String, Float> = haxe.Json.parse(sys.io.File.getContent("dump.json"));
        	var stats:Map<String, Float> = haxe.Unserializer.run(sys.io.File.getContent("dump.hxdump"));
        	// trace(stats);
        	for(module in stats.keys())
        	{
        		var time = stats.get(module);
        		var nbbar = Std.int(time / 20 ) ;

        		var output = '<div width="100">$module ($time ms)</div> > ';
        		for(i in 0...nbbar) output += "&block;";

        		neko.Lib.print(output + "<br/>");
        	}
        	// neko.Lib.print(json);
        }
        else
        // PROFILER ACCESS
        {
			sys.io.File.saveContent("dump.hxdump", neko.Web.getPostData());
        }
    } 
}