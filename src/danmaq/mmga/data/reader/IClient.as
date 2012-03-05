package danmaq.mmga.data.reader
{
	/**
	 * クライアントのインターフェイス。
	 *
	 * @author Mc(danmaq)
	 */
	public interface IClient
	{
		function call(url:String, params:Object):void;
	}
}
