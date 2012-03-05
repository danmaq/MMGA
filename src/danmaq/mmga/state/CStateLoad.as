package danmaq.mmga.state
{
	import danmaq.mmga.assets.CResources;
	import danmaq.mmga.components.CDanceStage;
	import danmaq.mmga.components.CMMGAMain;
	import danmaq.mmga.data.CDanceMaster;
	import danmaq.mmga.data.CStaticPreference;
	import danmaq.nineball.core.component.context.CContextBody;
	import danmaq.nineball.core.component.state.IState;
	import danmaq.nineball.core.util.object.blockDuplicate;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectUtil;
	
	/**
	 * ダンスデータ読み出しの状態。
	 *
	 * @author Mc(danmaq)
	 */
	public final class CStateLoad implements IState
	{
		
		//* constants ──────────────────────────────-*
		
		/** クラス インスタンス。 */
		public static const instance:IState = new CStateLoad();
		
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
		public function CStateLoad()
		{
			blockDuplicate(this, instance);
		}
		
		//* instance methods ───────────────────────────*
		
		/**
		 * 状態が開始された際に呼び出されます。
		 *
		 * @param body 実体へのアクセサ。
		 */
		public function setup(body:CContextBody):void
		{
			var main:CMMGAMain = body.owner as CMMGAMain;
			trace("load start");
			trace(CStaticPreference.instance.url);
			var service:HTTPService = new HTTPService(CStaticPreference.instance.url);
			service.url = "result.json";
			service.headers["Accept"] =
				"application/json, text/plain;q=0.9, */*;q=0.1";
			service.resultFormat = "text";
			service.addEventListener(ResultEvent.RESULT, trace);
			service.addEventListener(FaultEvent.FAULT, trace);
			service.send();
			CDanceMaster.receive(new CResources.JSON_TEST());

			var ds:CDanceStage = new CDanceStage();
			ds.debug = true;
			main.addElement(ds);
		}
		
		/**
		 * 1フレーム分の更新処理を実行します。
		 *
		 * @param body 実体へのアクセサ。
		 */
		public function update(body:CContextBody):void
		{
		}
		
		/**
		 * 別の状態へと移行される際に呼び出されます。
		 *
		 * @param body 実体のアクセサ。
		 */
		public function teardown(body:CContextBody):void
		{
		}
	}
}
