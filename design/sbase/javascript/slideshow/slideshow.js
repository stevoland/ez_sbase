YUI(YUI3_config).use('node', 'dom', 'anim', function(Y){
	var L = Y.Lang;
	
	Y.on('domready', function(){	
	// 
		Y.all('.slideshow').each(function(slideshow){
			var index = 0,
				nextIndex = 1,
				dotIndex = 0,
				slides = [],
				dots = [],
				timer,
				inTrans,
				outTrans
				isPaused = false
				isRunning = false;
				
			slideshow.on("mouseover", function(e){
				clearTimeout(timer);
			})
			
			slideshow.on("mouseout", function(e){
				clearTimeout(timer);
				timer = setTimeout(doAnim, 4000);
			})
			
			slideshow.get('children').each(function(slide){
				if ( !slide.hasClass('slide') )
				{
					return;
				}
				
				slides.push(slide);
			
			});
			
			slideshow.queryAll('.dot').each(function(dot, i){
				dots.push(dot);
				if ( dot.hasClass('current') )
					dotIndex = i;
					
				dot.on("click", function(e, newIndex){
					clearTimeout(timer);
					e.preventDefault();
					if ( isRunning )
					{
						outTrans.detach("end", endListener);
						inTrans.stop();
						outTrans.stop();
						slides[nextIndex].setStyle('opacity', 1);
						slides[index].setStyle('opacity', 0);
						slides[index].removeClass('slide-first');
						slides[nextIndex].addClass('slide-first');
						index = nextIndex;
					}
					
					if ( newIndex == index )
						return;
					
					Y.each(dots, function(dot, i){
						if ( i == newIndex )
							dot.addClass('current');
						else
							dot.removeClass('current');
					})
						
					slides[newIndex].setStyle('opacity', 1);
					slides[newIndex].addClass('slide-first');
					slides[index].removeClass('slide-first');
					slides[index].setStyle('opacity', 0);
					index = newIndex;
				}, this, i)
			})
			
			function endListener(e){
				isRunning = false;
				this.detach("end", endListener);
				slides[index].removeClass('slide-first');
				slides[index].removeClass('slide-transition');
				index = ( index == slides.length -1 ) ? 0 : index+1;
				if ( !!dots[dotIndex] )
					dots[dotIndex].removeClass('current');
				
				dotIndex = ( dotIndex == slides.length -1 ) ? 0 : dotIndex+1;
				
				if ( !!dots[dotIndex] )
					dots[dotIndex].addClass('current');
				
				timer = setTimeout(doAnim, 4000);
			}
			
			function doAnim()
			{
				nextIndex = ( index == slides.length -1 ) ? 0 : index+1;
				outTrans = new Y.Anim({ 
					node: slides[index], 
					to: { 
						opacity: 0
					} ,
					duration:1
				});
				inTrans = new Y.Anim({ 
					node: slides[nextIndex], 
					to: { 
						opacity: 1
					} ,
					duration:1
				});
				
				
				
				outTrans.on('end', endListener);
				slides[nextIndex].setStyle('opacity', 0);
				slides[nextIndex].addClass('slide-first');
				slides[index].setStyle('display', 'block');
				slides[index].addClass('slide-transition');
				outTrans.run();
				inTrans.run();
				isRunning = true;
			}
			
			timer = setTimeout(doAnim, 4000);
			
		
		});
	
	});

	
});