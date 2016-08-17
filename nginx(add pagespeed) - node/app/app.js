var express = require('express')
  , http = require('http')
  , app = express();

app.get(['/', '/index.html'], function (req, res){
    res.send('Hello nginx(add pagespeed)  - node');
});

http.createServer(app).listen(process.env.PORT || 9000);