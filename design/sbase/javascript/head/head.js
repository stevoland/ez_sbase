(function(ns){
	var toggleStateScope = function(state, isOn, prefix)
	{
		if ( !prefix )
			prefix = '';
		var html = document.documentElement,
			body = document.body,
			onClass = prefix + state,
			offClass = prefix + 'no-' + state,
			classToAdd = isOn ? onClass : offClass,
			classToRemove = isOn ? offClass : onClass;
		
		if ( !!body )
		{
			if ( body.className != "" )
				body.className += " ";
			body.className += classToAdd;
		}
		else
		{
			if ( html.className != "" )
				html.className += " ";
			html.className += classToAdd;
		}
		
		if ( !!body && body.className != '' )
		{
			body.className = body.className.replace(
				new RegExp("\\b" + classToRemove + "\\b"), "");
		}
		
		if ( html.className != '' )
		html.className = html.className.replace(
			new RegExp("\\b" + classToRemove + "\\b"), "");
	};
	
	//toggleStateScope('ua-js', true);
	
	var uaTest = {
	init: function(settings){
		//default test - all tests
		var testCases = [{testName: null, pass: null, scripting: null}]; //sample interface for testCases
		var useCookies = true; //set to false to never get or set cookies with this script
		var log = false; //set to false to disable developer console logging
		if(settings){
			if(settings.constructor == Array){ //settings arg can be a full array replacement
				testCases = settings;
			}
			else if(settings.constructor == Function) { //or just a function
				testCases[0].scripting = settings;
			}
		}	
		var capabilities = this.tests; //test results Object
		//run tests as soon as body element is available
		var checkBody = setInterval(bodyReady, 1);
		function bodyReady(){
			if(document.body){
				clearInterval(checkBody); //body is ready, stop asking
				//loop through the tests
				var cookieResults={},
					newCookieResults = {},
					cookieVal = '';
				if( useCookies && document.cookie.indexOf('uatests=')>-1 ){
					var cookiechunk = document.cookie.split('uatests=');
						
					cookieVal = (cookiechunk.length == 1) ? cookiechunk[0].split(';')[0] : cookiechunk[1].split(';')[0];
					var pairs = cookieVal.split('&'),
						split;
					for ( var i=0, len=pairs.length; i<len; i++ )
					{
						if ( pairs[i] != '' )
						{
							split = pairs[i].split(':');
							cookieResults[split[0]] = split[1];
						}
					}
					
					
				}
				for(var i=0; i<testCases.length; i++)
				{
					var thisTest = testCases[i]; //current set of tests
					if(!thisTest.testName) {
						thisTest.testName = 'ua-enhanced';
					}
					var testResult = 'pass'; //innocent until proven...
					/*if(document.cookie.indexOf(thisTest.testName+'=')>-1 && useCookies){
						var cookiechunk = document.cookie.split(thisTest.testName+'=');
						(cookiechunk.length == 1) ? testResult = cookiechunk[0].split(';')[0] : testResult = cookiechunk[1].split(';')[0];
					}
					else {//test hasn't run before or cookies are disabled, run it*/
					if ( !thisTest.pass )
					{//if all tests are requested
						var x = 0;
						for( var value in capabilities )
						{
							if ( cookieResults[value] != null )
							{
								if ( cookieResults[value] != '1' )
								{
									testResult = 'fail';
								}
							}
							else if( !capabilities[value]() )
							{
								testResult = 'fail';
								if ( useCookies )
									newCookieResults[value] = '0';
								//toggleStateScope(value, false, 'ua-');
							}
							else if ( useCookies )
							{
								newCookieResults[value] = '1';
							}
								
							if (log){ 
								console.log(value +' = '+ capabilities[value]() ); 
							}
						}
					}
					else if ( thisTest.pass && thisTest.pass.constructor == Array )
					{ //if only specific tests are requested
						for(var j=0; j<thisTest.pass.length; j++)
						{
							if( cookieResults[thisTest.pass[j]] != null )
							{
								if ( cookieResults[thisTest.pass[j]] != '1' )
									testResult = 'fail';
							}
							else if(!capabilities[thisTest.pass[j]]())
							{
								testResult = 'fail';
								if ( useCookies )
									newCookieResults[thisTest.pass[j]] = '0';
								
							} //one is all it takes
							else if ( useCookies )
							{
									newCookieResults[thisTest.pass[j]] = '1';
							}
							if(log){ console.log(thisTest.pass[j] +' = '+ capabilities[thisTest.pass[j]]()); }
						}
					}
						//set cookie for future page loads
						//if(useCookies){document.cookie = thisTest.testName +'='+ testResult +';';}
						
					//}
					//enhance the page based on test results
					if(testResult == 'pass'){
						//add body class
						toggleStateScope(thisTest.testName, true, 'ua-');
						//function to enable alternate stylesheets with title attr's equal to this test's title
						var allLinks = document.getElementsByTagName('link');
						for(var k=0; k<allLinks.length; k++){
							//disable any links with a title attr of "not_" preceding this test's title
							if (allLinks[k].title == 'ua-no-'+thisTest.testName){
								allLinks[k].disabled = true;
								allLinks[k].rel = 'alternate stylesheet';
							}
							//enable any links with a title attr of test's title
							if (allLinks[k].title == 'ua-'+thisTest.testName){
								allLinks[k].disabled = true; //opera likes to have it toggled
								allLinks[k].disabled = false;
								allLinks[k].rel = 'stylesheet';
							}
						}
						//newCookieResults[thisTest.testName] = '1';
						//if there's a scripting method, init
						if(thisTest.scripting){thisTest.scripting();} 
					}
					else
					{
						toggleStateScope(thisTest.testName, false, 'ua-');
						//newCookieResults[thisTest.testName] = '0';
					}
				}// /test loop
				if ( useCookies )
				{
					var newString = '';
					for ( var i in newCookieResults )
					{
						if ( cookieResults[i] == null )
						{
							newString += i + ':' + newCookieResults[i] + '&';
						}
					}
					if ( newString != '' )
					{
						cookieVal = 'uatests=' + newString + cookieVal + ';';
						document.cookie = cookieVal;
					}
				}
				
			}// /if doc.body
		}// /bodyReady func
		//test is done, return capabilities object
		return capabilities;
	},	
	tests: {}, //tests object to be populated by test functions
	add: function(testName, testScripting){
		this.tests[testName] = testScripting;
		return this;
	}
};




//configurable tests 
uaTest.tests = {
	js: function(){
		return true;
	},
	getbyid: function(){
		return document.getElementById ? true : false;
	},
	createel: function(){
		return document.createElement ? true : false;
	},
	boxmodel: function(){
		var newDiv = document.createElement('div');
		document.body.appendChild(newDiv);
		newDiv.style.width = '20px';
		newDiv.style.padding = '10px';
		var divWidth = newDiv.offsetWidth;
		document.body.removeChild(newDiv);
		return divWidth == 40;
	},
	position: function(){
		var newDiv = document.createElement('div');
		document.body.appendChild(newDiv);
		newDiv.style.position = 'absolute';
		newDiv.style.left = '10px';
		var divLeft = newDiv.offsetLeft;
		document.body.removeChild(newDiv);
		return divLeft == 10;
	},
	float: function(){
		var newDiv = document.createElement('div');
		document.body.appendChild(newDiv);
		newDiv.innerHTML = '<div style="width: 5px; float: left;"></div><div style="width: 5px; float: left;"></div>';
		var divTopA = newDiv.childNodes[0].offsetTop;
		var divTopB = newDiv.childNodes[1].offsetTop;
		document.body.removeChild(newDiv);
		return divTopA == divTopB;
	},
	clear: function(){
		var newDiv = document.createElement('div');
		document.body.appendChild(newDiv);
		newDiv.style.visibility = 'hidden';
		newDiv.innerHTML = '<ul><li style="width: 5px; float: left;">test</li><li style="width: 5px; float: left;clear: left;">test</li></ul>';
		var liTopA = newDiv.getElementsByTagName('li')[0].offsetTop;
		var liTopB = newDiv.getElementsByTagName('li')[1].offsetTop;
		document.body.removeChild(newDiv);
		return liTopA != liTopB;
	},
	overflow: function(){
		var newDiv = document.createElement('div');
		document.body.appendChild(newDiv);
		newDiv.innerHTML = '<div style="height: 10px; overflow: hidden;"></div>';
		var divHeight = newDiv.offsetHeight;
		document.body.removeChild(newDiv);
		return divHeight == 10;
	},
	/*//unitless lineheight test - fails firefox 1, but also in iPhone. Pulled for irrellevance to this layout
	lineheight: function(){ 
		var newDiv = document.createElement('div');
		document.body.appendChild(newDiv);
		newDiv.innerHTML = '<div style="line-height: 2; font-size: 10px;">Te<br />st</div>';
		var divHeight = newDiv.offsetHeight;
		document.body.removeChild(newDiv);
		return divHeight == 40;
	},*/
	ajax: function(){
		//factory test borrowed from quirksmode.org
		var XMLHttpFactories = [
			function () {return new XMLHttpRequest()},
			function () {return new ActiveXObject("Msxml2.XMLHTTP")},
			function () {return new ActiveXObject("Msxml3.XMLHTTP")},
			function () {return new ActiveXObject("Microsoft.XMLHTTP")}
		];
		var xmlhttp = false;
		for (var k=0;k<XMLHttpFactories.length;k++) {
			try {xmlhttp = XMLHttpFactories[k]();}
			catch (e) {continue;}
			break;
		}
		return xmlhttp ? true : false;
	},
	resize: function(){
		return (window.onresize == false) ? false : true
	},
	print: function(){
		return window.print ? true : false
	},
	images: function(){
		var de = document.documentElement;
		var img = new Image();
		
		// Handling for Gecko browsers
		if (img.style.MozBinding != null)
		{
			img.style.backgroundImage = "url(" + document.location.protocol + "//0)";
			var bg = window.getComputedStyle(img, '').backgroundImage;
			
			// When images are off, Firefox 2 and lower reports "none"
			// Firefox 3 and higher reports "url(invalid-url:)"
			// Also, always show images for local files in Firefox
			if (bg != "none" && bg != "url(invalid-url:)" || document.URL.substr(0, 2) == "fi")
			{
				return true;
			}
		}
		else
		{
			// Handling for Safari (including iPhone)
			img.style.cssText = "-webkit-opacity:0";
			if (img.style.webkitOpacity == 0)
			{
				img.onload = function()
				{
					// Only enable the state scope if the width
					// of the image is greater than 0.
					return img.width > 0;
				}
				// Source the image to a 43-byte 1x1 pixel GIF image encoded as a data URI.
				img.src = 
					"data:image/gif;base64," +
					"R0lGODlhAQABAIAAAP///wAAACH5BAE" +
					"AAAAALAAAAAABAAEAAAICRAEAOw==";
			}
			// Handling for everything else
			else
			{
				img.onerror = function(e)
				{
					return true;
				}
				img.src = "about:blank";
			}
			return false;
		}
	}
};

uaTest.init([
	{testName: 'js', pass: ['js']},
	{testName: 'ajax', pass: ['ajax']}
	
]);
	
	
})(this);