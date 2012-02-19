package danmaq.mmga.components
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.b2BroadPhase;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	
	/**
	 * モデルを躍らせるステージ。
	 * 
	 * @author Mc(danmaq)
	 */
	public final class CDanceStage extends UIComponent
	{

		//* constants ──────────────────────────────-*

		private const PIXELS_TO_METRE:int = 30;  
		private const SWF_HALF_WIDTH:int = 120;  
		private const SWF_HEIGHT:int = 300;  

		/** デバッグ表示用スプライト。 */
		private const debugSprite:Sprite = new Sprite();
		
		//* fields ────────────────────────────────*
		
		/** 物理演算空間。 */
		private var _world:b2World;

		/** 開始時間。 */
		private var _startTime:int;
		
		//* constructor & destructor ───────────────────────*
		
		/**
		 * コンストラクタ。
		 */
		public function CDanceStage()
		{
			// b2World(gravity:b2Vec2/* 重力ベクトル*/, doSleep:Boolean/* 動かないものは計算しない */)  
			_world = new b2World(new b2Vec2(0,10),true);  
			// 物理単位（メートル）とピクセルの対応比率を指定する「物体の定義」  
			var groundBodyDef:b2BodyDef= new b2BodyDef();  
			groundBodyDef.position.Set(SWF_HALF_WIDTH/PIXELS_TO_METRE,  
				SWF_HEIGHT/PIXELS_TO_METRE-20/PIXELS_TO_METRE);  
			// 「世界」に物体を生成する  
			var groundBody:b2Body = _world.CreateBody(groundBodyDef);  
			// 「形状」を生成する  
			var groundBox:b2PolygonShape = new b2PolygonShape();  
			groundBox.SetAsBox(SWF_HALF_WIDTH/PIXELS_TO_METRE,20/PIXELS_TO_METRE);  
			// 「属性」を生成し、「形状」を与える  
			var groundFixtureDef:b2FixtureDef = new b2FixtureDef();  
			groundFixtureDef.shape = groundBox;  
			groundFixtureDef.density = 1;  
			groundFixtureDef.friction = 1;  
			// 物体に属性を付属させる  
			groundBody.CreateFixture(groundFixtureDef);  
			
			// 新しい物体の作成する場合（b2_dynamicBodyを指定している）  
			var bodyDef:b2BodyDef = new b2BodyDef();  
			bodyDef.type = b2Body.b2_dynamicBody;  
			bodyDef.position.Set(SWF_HALF_WIDTH/PIXELS_TO_METRE,-0.5);  
			var body:b2Body = _world.CreateBody(bodyDef);  
			var dynamicBox:b2PolygonShape = new b2PolygonShape();  
			dynamicBox.SetAsBox(1,1);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();  
			fixtureDef.shape = dynamicBox;  
			fixtureDef.density = 1;
			fixtureDef.friction = 0.3;  
			body.CreateFixture(fixtureDef);  
			
			// デバッグTrace用spriteを設定して、debugDrawに書きだしてもらう
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(PIXELS_TO_METRE);  
			debugDraw.SetLineThickness( 1.0);  
			debugDraw.SetAlpha(1);  
			debugDraw.SetFillAlpha(0.4);  
			debugDraw.SetFlags(
				b2DebugDraw.e_aabbBit | b2DebugDraw.e_centerOfMassBit | b2DebugDraw.e_controllerBit |
				b2DebugDraw.e_jointBit | b2DebugDraw.e_pairBit | b2DebugDraw.e_shapeBit);
			_world.SetDebugDraw(debugDraw);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}

		[Inspectable(category="Other", defaultValue="false")]		
		/**
		 * デバッグ表示を行うかどうかを取得します。
		 * 
		 * @return デバッグ表示を行う場合、true。
		 * @default false
		 */
		public function get debug():Boolean
		{
			return contains(debugSprite);
		}
		
		/**
		 * デバッグ表示を行うかどうかを設定します。
		 * 
		 * @param value デバッグ表示を行うかどうか。
		 */
		public function set debug(value:Boolean):void
		{
			if(value != debug)
			{
				(value ? addChild : removeChild)(debugSprite);
			}
		}
		
		//* instance methods ───────────────────────────*
		
		/**
		 * フレームごとに発生するイベントによって呼び出されます。
		 * 
		 * @param evt イベント情報。
		 */
		private function onEnterFrame(evt:Event):void
		{
			_world.Step(1 / stage.frameRate, 6, 2);
			_world.ClearForces();
			_world.DrawDebugData();
		}
		
		/**
		 * ステージに登録された際のイベントによって呼び出されます。
		 * 
		 * @param evt イベント情報。
		 */
		private function onAddedToStage(evt:Event):void
		{
			_startTime = getTimer();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
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
