module.exports=(bigcb)->
    axios=require "axios"
    fs=require "fs"
    JSSoup=require("jssoup").default
    getPage=(num,cb)->
        axios.get("https://minecraftservers.org/index/#{num}")
        .then (r)->
            res=[]
            soup=new JSSoup r.data
            result=soup.findAll "tr"
            for i in result
                if i.find("div","server-ip") isnt undefined
                    if i.find("div","server-ip").find("p") isnt undefined and i.find("span","online") isnt undefined
                        ip=i.find("div","server-ip").find("p").text
                        online=i.find("span","online").text
                        if online is "online"
                            res.push ip
            cb res
            return
        .catch (e)->
            console.log "Rerunning..."
            getPage num,cb
            return
        return
    xd={}
    loaded=0
    numx=0
    for i in [2..1670]
        ((i)->
            getPage i,(r)->
                numx+=r.length
                loaded++
                for j in r
                    xd[j]=true
                if loaded is 1669
                    bigcb xd
                console.log "minecraftservers [#{loaded}/#{1669}]"
                return
        )(i)