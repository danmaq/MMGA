package danmaq.mmga.data
{

	import danmaq.mmga.assets.CResources;
	import danmaq.nineball.core.component.IDisposable;
	import danmaq.nineball.core.util.object.blockDuplicate;
	import danmaq.nineball.flex.data.CJSONStore;
	
	/**
	 * 静的設定マスタ。
	 *
	 * @author Mc(danmaq)
	 */
	public final class CStaticPreference
	{
		
		//* constants ──────────────────────────────-*
		
		/** クラス インスタンス。 */
		public static const instance:CStaticPreference = new CStaticPreference();
		
		/** JSONストア。 */
		private const json:CJSONStore = new CJSONStore();
		
		//* constructor & destructor ───────────────────────*
		
		/**
		 * コンストラクタ。
		 *
		 * <p>
		 * Singletonクラスのため、このクラスの生成は許可されません。
		 * 静的メンバ<code>instance</code>を使用してください。
		 * </p>
		 *
		 * @see #instance
		 */
		public function CStaticPreference()
		{
			blockDuplicate(this, instance);
			json.decode(new CResources.JSON_PREFERENCE());
		}
		
		//* instance properties ─────────────────────────-*
		
		/**
		 * オンライン通信を行うかどうかを取得します。
		 */
		public function get online():Boolean
		{
			return !isAuthoring() || json.store["online"];
		}
		
		/**
		 * サーバのベースURLを取得します。
		 */
		public function get url():String
		{
			return json.store[isAuthoring() ? "url_authoring" : "url_release"];
		}
	}
}
