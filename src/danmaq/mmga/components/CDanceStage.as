package danmaq.mmga.components
{

	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import spark.components.Group;
	
	/**
	 * モデルを躍らせるステージ。
	 * 
	 * @mxml
	 * 
	 *  <p>The <code>&lt;components:CDanceStage&gt;</code> tag inherits all of the tag 
	 *  attributes of its superclass and adds the following tag attributes:</p>
	 *
	 *  <pre>
	 *  &lt;components:CDanceStage
	 *    <strong>Properties</strong>
	 *    debug="false"
	 *  /&gt;
	 *  </pre>
	 * 
	 * @author Mc(danmaq)
	 */
	public final class CDanceStage extends Group
	{

		//* constants ──────────────────────────────-*

		/** ピクセル：メートル比。 */
		public static const PIXELS_TO_METRE:int = 140;  

		/** ステージの幅。 */
		private const SWF_HALF_WIDTH:int = 120;  

		/** ステージの高さ。 */
		private const SWF_HEIGHT:int = 300;  
		
		/**
		 * 物理演算空間。
		 * 
		 * @see Box2D.Dynamics.b2World
		 */
		public const world:b2World = new b2World(new b2Vec2(0, 10), true);

		/** デバッグ表示用スプライト。 */
		private const debugSprite:UIComponent = new UIComponent();
		
		/** モデル。 */
		private var _model:CModel;
		
		//* constructor & destructor ───────────────────────*
		
		/**
		 * コンストラクタ。
		 */
		public function CDanceStage()
		{
			width = 240;
			height = 300;
			initializeGround();

			initializeDebugView();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			_model = new CModel(world);
		}

		//* instance properties ─────────────────────────-*
		
		[Inspectable(category="Other", defaultValue="false")]

		/**
		 * デバッグ表示を行うかどうかを取得します。
		 * 
		 * @see Box2D.Dynamics.b2DebugDraw
		 */
		public function get debug():Boolean
		{
			return contains(debugSprite);
		}
		
		/**
		 * @private
		 */
		public function set debug(value:Boolean):void
		{
			if(value != debug)
			{
				(value ? addElement : removeElement)(debugSprite);
			}
		}
		
		//* instance methods ───────────────────────────*
		
		/**
		 * デバッグ用表示の初期化をします。
		 */
		private function initializeDebugView():void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(PIXELS_TO_METRE);
			debugDraw.SetLineThickness(1.0);
			debugDraw.SetAlpha(1);
			debugDraw.SetFillAlpha(0.4);
			debugDraw.SetFlags(
				b2DebugDraw.e_aabbBit | b2DebugDraw.e_centerOfMassBit | b2DebugDraw.e_controllerBit |
				b2DebugDraw.e_jointBit | b2DebugDraw.e_pairBit | b2DebugDraw.e_shapeBit);
			world.SetDebugDraw(debugDraw);
			debugSprite.x = SWF_HALF_WIDTH;
			debugSprite.y = 300;
		}
		
		/**
		 * 地面の初期化をします。
		 */
		private function initializeGround():void
		{
			// 物理単位（メートル）とピクセルの対応比率を指定する「物体の定義」
			var groundBodyDef:b2BodyDef= new b2BodyDef();
			groundBodyDef.position.Set(0, 0);
			// 「世界」に物体を生成する
			var groundBody:b2Body = world.CreateBody(groundBodyDef);
			// 「形状」を生成する
			var groundBox:b2PolygonShape = new b2PolygonShape();
			groundBox.SetAsBox(SWF_HALF_WIDTH * 10 / PIXELS_TO_METRE, 5 / PIXELS_TO_METRE);
			// 「属性」を生成し、「形状」を与える
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();
			groundFixtureDef.shape = groundBox;
			groundFixtureDef.density = 0;
			groundFixtureDef.friction = 5;
			// 物体に属性を付属させる
			groundBody.CreateFixture(groundFixtureDef);
		}
		
		/**
		 * フレームごとに発生するイベントによって呼び出されます。
		 * 
		 * @param evt イベント情報。
		 */
		private function onEnterFrame(evt:Event):void
		{
			world.Step(1 / stage.frameRate, 6, 2);
			world.ClearForces();
			world.DrawDebugData();
		}
		
		/**
		 * ステージに登録された際のイベントによって呼び出されます。
		 * 
		 * @param evt イベント情報。
		 */
		private function onAddedToStage(evt:Event):void
		{
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}
		
		/**
		 * ステージから削除された際のイベントによって呼び出されます。
		 * 
		 * @param evt イベント情報。
		 */
		private function onRemovedFromStage(evt:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}
