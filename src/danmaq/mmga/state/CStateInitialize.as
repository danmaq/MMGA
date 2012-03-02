package danmaq.mmga.state
{
	import danmaq.mmga.components.MMGA;
	import danmaq.nineball.core.component.context.CContextBody;
	import danmaq.nineball.core.component.state.IState;
	import danmaq.nineball.core.util.object.blockDuplicate;
	
	/**
	 * 初期化の状態。
	 *
	 * @author Mc(danmaq)
	 */
	public final class CStateInitialize implements IState
	{
		
		//* constants ──────────────────────────────-*
		
		/** クラス インスタンス。 */
		public static const instance:IState = new CStateInitialize();
		
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
		public function CStateInitialize()
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
			trace("initialize start");
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
