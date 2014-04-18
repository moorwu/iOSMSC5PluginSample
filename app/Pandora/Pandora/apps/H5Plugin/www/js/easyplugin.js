(function(w){
	w.plugin1 = {
		"getString":function(){
			return w.plus.bridge.execSync( "Plugin1", "getString" );
		}
	};
})(window);