package danmaq.mmga.assets
{
	import danmaq.nineball.core.util.object.blockStatic;
	
	/**
	 * リソース定義クラスです。
	 * 
	 * @author Mc(danmaq)
	 */
	public final class CResources
	{
		
		//* fields ────────────────────────────────*
		
		/**	テスト用のレスポンスJSON。 */
		[Embed(source="../embed/json/result.json", mimeType="application/octet-stream")]
		public static var JSON_TEST:Class;
		
		/**	設定用JSON。 */
		[Embed(source="../embed/json/preference.json", mimeType="application/octet-stream")]
		public static var JSON_PREFERENCE:Class;
		
		//* constructor & destructor ───────────────────────*
		
		/**
		 * コンストラクタ。
		 *
		 * <p>
		 * このクラスは静的クラスです。このクラスのインスタンスを生成することはできません。
		 * </p>
		 */
		public function CResources()
		{
			blockStatic();
		}
	}
}
