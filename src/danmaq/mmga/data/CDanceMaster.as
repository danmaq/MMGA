package danmaq.mmga.data
{

	import danmaq.nineball.core.util.object.blockDuplicate;
	import danmaq.nineball.flex.data.CJSONStore;
	
	/**
	 * ダンス情報マスタ。
	 *
	 * @author Mc(danmaq)
	 */
	public final class CDanceMaster
	{
		
		//* constants ──────────────────────────────-*
		
		/** 本番データ用クラス インスタンス。 */
		public static const current:CDanceMaster = new CDanceMaster();
		
		/** 受信データ用クラス インスタンス。 */
		public static const received:CDanceMaster = new CDanceMaster();

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
		public function CDanceMaster()
		{
			blockDuplicate(this, current, received);
		}
		
		//* instance properties ─────────────────────────-*

		
		
		/**
		 * 基本データを取得します。
		 */
		private function get base():Object
		{
			var store:Object = this.json.store;
			return store.hasOwnProperty("b") ? store["b"] : null;
		}
		
		/**
		 * 拡張データを取得します。
		 */
		private function get ext():Object
		{
			var store:Object = this.json.store;
			return store.hasOwnProperty("e") ? store["e"] : null;
		}
		
		//* class methods ────────────────────────────-*
		
		/**
		 * 受信したマスタを本番にマージします。
		 */
		public static function copyToCurrent():void
		{
			current.json.merge(received.json);
		}
		
		/**
		 * 受信したJSONを取り込みます。
		 *
		 * @param json JSON文字列。
		 */
		public static function receive(json:String):void
		{
			received.json.decode(json);
		}
	}
}
