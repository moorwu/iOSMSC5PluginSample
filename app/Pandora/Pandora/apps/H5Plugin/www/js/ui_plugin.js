 (function(w){
    w.uiPlugin = {
    "drawPie":function(param){
        if(param==undefined)
            return w.plus.bridge.execSync( "UIPlugin", "drawPie");
        else
            return w.plus.bridge.execSync( "UIPlugin", "drawPie" , [param]);
        }
    };
  })(window);