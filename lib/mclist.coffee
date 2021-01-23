module.exports=(bigcb)->
    axios=require "axios"
    JSSoup=require("jssoup").default
    getPage=(num,cb)->
        axios.get("https://www.mclist.pl/page/#{num}")
        .then (r)->
            res=[]
            soup=new JSSoup r.data
            result=soup.findAll "div","serwer"
            
            for i in result
                if i.find("img","server-icon") isnt undefined
                    ping=i.find("img","server-icon").attrs.src
                    if ping is "https://www.mclist.pl/img/ping.png"
                        res.push i.find("div","col-md-7").find("h5").text
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
    for i in [1..50]
        ((i)->
            getPage i,(r)->
                numx+=r.length
                loaded++
                for j in r
                    xd[j]=true
                if loaded is 50
                    bigcb xd
                console.log "mclist [#{loaded}/#{50}]"
                return
        )(i)