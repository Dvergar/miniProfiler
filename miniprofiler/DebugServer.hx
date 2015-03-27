
class DebugServer
{
    static function main()
    {
        var postData = neko.Web.getPostData();
        var getData = neko.Web.getParamsString();
        var getDatas = neko.Web.getParams();
        // trace(neko.Web.getParams());
        // trace("postdata " + getData);

        // AJAX JSON ACCESS
        if(getDatas.exists("json"))
        {
            var name = getDatas.get("json");
            neko.Lib.print(sys.io.File.getContent('dump_$name.json'));
        }
        // PROFILER ACCESS
        else if(getDatas.exists("name"))
        {
            // trace("Profiler access");
            var name = getDatas.get("name");
            sys.io.File.saveContent('dump_$name.json', neko.Web.getPostData());
        }
        // BROWSER ACCESS
        else if(getData != null)
        {
            // trace("Browser access");
            var template = new haxe.Template(sys.io.File.getContent("debug_view.html"));
            var output = template.execute({ debugname : getData});
            neko.Lib.print(output);
        }
    } 
}