package danmaq.mmga.components
{
	import Box2D.Dynamics.b2World;
	
	import mx.core.UIComponent;
	
	/**
	 * モデル クラス。
	 * 
	 * @author Mc(danmaq)
	 */
	public final class CModel extends UIComponent
	{

		//* fields ────────────────────────────────*
		
		/**
		 * 物理演算空間。
		 * 
		 * @see Box2D.Dynamics.b2World
		 */
		private var _world:b2World;

		//* constructor & destructor ───────────────────────*
		
		/**
		 * コンストラクタ。
		 * 
		 * @param world 物理演算空間。
		 */
		public function CModel(world:b2World)
		{
			
//			// 新しい物体の作成する場合（b2_dynamicBodyを指定している）
//			var bodyDef:b2BodyDef = new b2BodyDef();
//			bodyDef.type = b2Body.b2_dynamicBody;
//			var body:b2Body = world.CreateBody(bodyDef);
//			var dynamicBox:b2CircleShape = new b2CircleShape(0.2);
//			var fixtureDef:b2FixtureDef = new b2FixtureDef();
//			fixtureDef.shape = dynamicBox;
//			fixtureDef.density = 1;
//			fixtureDef.friction = 0.3;
//			body.CreateFixture(fixtureDef);
			
		}
	}
}
