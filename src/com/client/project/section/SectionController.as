package com.client.project.section
{
	import com.kish.core.control.AbstractViewController;

	import flash.display.DisplayObjectContainer;

	public class SectionController extends AbstractViewController
	{
		[View]
		public var view:SectionView;
		
		public function SectionController( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
		}
	}
}