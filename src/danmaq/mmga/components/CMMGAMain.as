package danmaq.mmga.components
{
	import danmaq.mmga.assets.CResources;
	import danmaq.nineball.core.util.object.blockDuplicate;
	
	import mx.core.UIComponent;
	
	/**
	 * アプリケーションのメイン ロジック クラス。
	 * 
	 * <p>
	 * ドキュメント クラスにのみ設置可能な、シングルトン オブジェクトです。
	 * </p>
	 * 
	 * @author Mc(danmaq)
	 */
	public final class CMMGAMain extends UIComponent
	{
		
		//* constants ──────────────────────────────-*
		
		/** クラス インスタンス。 */
		private static var _instance:CMMGAMain; 

		//* constructor & destructor ───────────────────────*
		
		/**
		 * コンストラクタ。
		 */
		public function CMMGAMain()
		{
			blockDuplicate(this, _instance);
			_instance = this;
			var ds:CDanceStage = new CDanceStage();
			ds.debug = true;
			addChild(ds);
		}

		//* class properties ───────────────────────────*
		
		/**
		 * クラス インスタンスを取得します。
		 */
		public static function get instance():CMMGAMain
		{
			return _instance;
		}
		
	}
}
