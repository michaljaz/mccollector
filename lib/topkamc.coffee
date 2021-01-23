module.exports=(bigcb)->
    axios=require "axios"
    JSSoup=require("jssoup").default


    getPage=(num,cb)->
        axios.get("https://www.topkamc.pl/page-#{num}")
        .then (r)->
            res=[]
            soup=new JSSoup r.data
            result=soup.findAll "a","motd-link"
            for i in result
                res.push i.find("strong").text.substr(0,i.find("strong").text.length-1)
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
    for j in [1..17]
        getPage j,(r)->
            numx+=r.length
            loaded++
            console.log "topkamc [#{loaded}/17]"
            for k in r
                xd[k]=true
            if loaded is 17
                bigcb xd
            return
