async function callApi(path){
    const outputEl=document.getElementById('output'); outputEl.textContent='';
    const res=await fetch(path,{method:'POST'}); const reader=res.body.getReader(); const decoder=new TextDecoder();
    while(true){const {done,value}=await reader.read(); if(done) break; outputEl.textContent+=decoder.decode(value); outputEl.scrollTop=outputEl.scrollHeight;}
}
