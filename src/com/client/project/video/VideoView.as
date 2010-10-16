package com.client.project.video
{
	import com.client.project.animation.FadeIn;
	import com.client.project.animation.FadeOut;
	import com.client.project.video.controls.VideoControls;
	import com.kish.core.view.AbstractView;
	import com.kish.display.Alignment;
	import com.kish.garbage.Garbage;
	import com.kish.video.KVideoPlayer;

	import flash.display.DisplayObjectContainer;
	import flash.system.System;

	public class VideoView extends AbstractView
	{		
		[Reveal]
		public var fadeIn:FadeIn;
		
		[Conceal]
		public var fadeOut:FadeOut;
		
		private var _vid:KVideoPlayer;
		private var _controls:VideoControls;
		
		public function VideoView( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
		}
		
		override public function initialize():void
		{			
			_vid = new KVideoPlayer( this, { visible:false, displayWidth:stage.stageWidth, displayHeight:stage.stageHeight, url:controller.data['videoURL'], autoStart:false } );
			_controls = new VideoControls( this, { visible:false, y:stage.stageHeight, videoPlayer:_vid } );
			alignment = Alignment.TOP_LEFT;
			
			place();

			super.initialize();
		}
		
		override public function show():void
		{
			this.alpha = 0;
			_vid.visible = true;
			_controls.visible = true;
			super.show();
		}
		
		override protected function onRevealed():void
		{
			_vid.start();	
			super.onRevealed();
		}
		
		override protected function place():void
		{
			_vid.resize( stage.stageWidth, stage.stageHeight );
			_controls.y = stage.stageHeight;
			super.place();
		}
				
		override public function hide():void
		{
			_vid.pause();
			_vid.killStream();
			super.hide();
		}
		
		override public function dispose():void
		{
			_vid.dispose();
			_controls.dispose();
			
			Garbage.dispose( _vid );
			Garbage.dispose( _controls );

			_vid = null;
			_controls = null;
			
			System.gc();
			super.dispose();
		}
	}
}