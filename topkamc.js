const axios = require('axios');
var JSSoup = require('jssoup').default;


function getPage(num,cb){
    
    axios.get(`https://www.topkamc.pl/page-${num}`)
    .then(function (response) {
        var res=[]
        // handle success
        // console.log(response.data);
        var soup=new JSSoup(response.data)
        // console.log(response.data)
        var result=soup.findAll("a","motd-link")
        for(var i=0;i<result.length;i++){
            res.push(result[i].find("strong").text)
            // console.log(result[i].attrs.class)
        }
        cb(res)
        // console.log(result)
    })
}
var xd={}
var loaded=0;
var numx=0
for(var j=1;j<=17;j++){
    getPage(j,(res)=>{
        numx+=res.length
        loaded++;
        for(var k=0;k<res.length;k++){
            xd[res[k]]=true
        }
        if(loaded==17){
            console.log(xd,numx)
        }
    })
}
// getPage(5,(x)=>{
//     console.log(x)
// })
