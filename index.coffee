result={}
require("./lib/mclist.coffee")((r)->
    for i of r
        result[i]=true
    require("./lib/topkamc.coffee")((rx)->
        for j of rx
            result[j]=true
        console.log result
        return
    )
    return
)