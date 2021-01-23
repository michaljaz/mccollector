fs = require "fs"
result={}
require("./lib/mclist.coffee")((r)->
    for i of r
        result[i]=true
    require("./lib/topkamc.coffee")((rx)->
        for j of rx
            result[j]=true
        require("./lib/minecraftservers.coffee")((rxx)->
            for k of rxx
                result[k]=true
            fs.writeFileSync "result.json",JSON.stringify(result,null,4)
            console.log result
            return
        )
        return
    )
    return
)