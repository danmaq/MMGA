package danmaq.mmga.components
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import mx.events.RSLEvent;
	import mx.preloaders.SparkDownloadProgressBar;
	
	public final class CPreloader extends SparkDownloadProgressBar
	{
		
		override protected function showDisplayForDownloading(elapsedTime:int, event:ProgressEvent):Boolean
		{
			// TODO Auto Generated method stub
			return super.showDisplayForDownloading(elapsedTime, event) || true;
		}
		
		override protected function showDisplayForInit(elapsedTime:int, count:int):Boolean
		{
			// TODO Auto Generated method stub
			return super.showDisplayForInit(elapsedTime, count) || true;
		}
		
	}
}
