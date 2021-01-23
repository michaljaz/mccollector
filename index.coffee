fs = require "fs"
result={}
require("./lib/mclist.coffee")((r)->
    for i of r
        result[i]=true
    require("./lib/topkamc.coffee")((rx)->
        for j of rx
            result[j]=true
        fs.writeFileSync "result.json",JSON.stringify(result,null,4)
        console.log result
        return
    )
    return
)