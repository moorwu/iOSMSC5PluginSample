(function(w){
	w.plugin1 = {
		"getString":function(){
			return w.plus.bridge.execSync( "Plugin1", "getString" );
		},
        "show":function( tip, okCB ) {
            var okID = w.plus.bridge.callbackId( okCB );
            w.plus.bridge.exec( "Plugin1", "show", [tip,okID] );
        }
	};
 
})(window);