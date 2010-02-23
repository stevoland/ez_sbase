if ( !this.stevo )
	var stevo = {};

stevo.EzKeyword = function(YAHOO, url, inputId, containerId, maxResults, delimiter) {
	this.oACDS = new YAHOO.widget.DS_XHR( url, ["ResultSet.Result","Keyword"] );
	//console.info(this.oACDS);
	this.oACDS.queryMatchContains = true;
	this.oACDS.queryMatchSubset = true;
	this.oACDS.queryMatchCase = false;
	this.oACDS.responseType = YAHOO.util.DataSource.TYPE_JSON;
	this.oACDS.responseSchema = { 
		resultsList: "ResultSet.Result", 
		fields: ["Keyword"] 
	}; 
	// this.oACDS.scriptQueryAppend = "";

	// Instantiate AutoComplete
	this.oAutoComp = new YAHOO.widget.AutoComplete(inputId, containerId, this.oACDS);
	this.oAutoComp.useShadow = true;
	this.oAutoComp.animHoriz = true;
	// eZKeyword requires separation of words using ','
	this.oAutoComp.delimChar = delimiter || ",";
	this.oAutoComp.minQueryLength = 1;
	this.oAutoComp.maxCacheEntries = 60;
	this.oAutoComp.maxResultsDisplayed = maxResults || 100;  
	this.oAutoComp.formatResult = function(oResultItem, sQuery) {
		return oResultItem[1].Keyword;
	};
		
	this.oAutoComp.doBeforeExpandContainer = function(oTextbox, oContainer, sQuery, aResults) 
	{
		// in here, 'this' represents the YAHOO.widget.AutoComplete object instantiated a few lines above.
		var pos = YAHOO.util.Dom.getXY(oTextbox);
		pos[1] += YAHOO.util.Dom.get(oTextbox).offsetHeight + 2;
		YAHOO.util.Dom.setXY(oContainer,pos);
		return true;
	};

	this.eventHandler = function( sType, aArgs )
	{
		switch( sType )
		{
		   case "itemSelect" :		   
				var ACInstance = aArgs[0];     // your AutoComplete instance
				var elListItem = aArgs[1];     // the <li> element selected in the suggestion container
				var aData = aArgs[2];          // array of the data for the item as returned by the DataSource
				aDataString = aData[0]; 
				
				var alreadyEnteredKeywords = new String( ACInstance._elTextbox.value );
				if ( alreadyEnteredKeywords.length == 0 )
					return true;
				
				alreadyEnteredKeywords = alreadyEnteredKeywords.split( ACInstance.delimChar );				
				
				// When a suggestion is selected, it is automatically added at the end
				// of the input field, followed by a space and the delimiter. Hence the removal of the last item of the array here
				alreadyEnteredKeywords.pop();
				
				var iterationString = null;
				var duplicatePickingUp = 0;				
				for ( var i = 0; i < alreadyEnteredKeywords.length; )
				{
					// sanitize string :
					iterationString = new String( alreadyEnteredKeywords[i] );
						// ltrim :
					iterationString = iterationString.replace( new RegExp("^[\\s]+", "g"), "" );					
						// rtrim :
					iterationString = iterationString.replace( new RegExp("[\\s]+$", "g"), "" );					
									
					if ( iterationString ==  aDataString )
					{
						alreadyEnteredKeywords.splice( i, 1 );
						
						// using an incremental logic here instead of a simple boolean one : the text input is populated 
						// with the newly picked up word before this event is triggered, meaning that encountering once the 
						// picked up term is normal, but twice indicates a duplicate, hence the test a few lines below : 
						//   				if ( duplicatePickingUp == 2 )
						duplicatePickingUp++;
					}
					else
					{
						alreadyEnteredKeywords[i] = iterationString; 
						i++
					}
				}
				
				// finally add the selected keyword, and populate the text input
				alreadyEnteredKeywords.push( aDataString );
				
				var finalInputValue = new String( alreadyEnteredKeywords.join( ACInstance.delimChar + ' ' ) + ACInstance.delimChar + ' ' );
				finalInputValue = finalInputValue.replace( new RegExp("^[\\s]+", "g"), "" );
				finalInputValue = finalInputValue.replace( new RegExp("[\\s]+$", "g"), "" );
				
				ACInstance._elTextbox.value = finalInputValue;

				if ( duplicatePickingUp == 2 )
				{				
					// Animate then the text box background color to notify the editor
					// @ TODO : enhance this ergonomy .. 
					
					var attributes = {
							backgroundColor: { to: '#ef8c00' } 
						};
					var anim = new YAHOO.util.ColorAnim( ACInstance._elTextbox, attributes, 0.4 );
					
					var attributesBack = {
							backgroundColor: { to: '#ffffff' } 
						};
					var animBack = new YAHOO.util.ColorAnim( ACInstance._elTextbox, attributesBack );

					// chain animations to have a back and forth effect										
					anim.onComplete.subscribe( function() { animBack.animate(); } );
					anim.animate();				
				}
				break;
		   default:
				break;	
		}
	};
};