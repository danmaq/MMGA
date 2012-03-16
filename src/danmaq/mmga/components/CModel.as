package danmaq.mmga.components
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
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
		 * @param x 中心となるX座標。
		 */
		public function CModel(world:b2World, x:Number = 0)
		{
			_world = world;
			// 新しい物体の作成する場合（b2_dynamicBodyを指定している）
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = b2Body.b2_dynamicBody;
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			var head:b2Body = createCircle(bodyDef, fixtureDef, 0, -1.4, 0.15, 1, 0.4, 0.3);
		}
		
		/**
		 * 円形物質を作成します。
		 * 
		 * @param bodyDef 
		 * @param fixtureDef 
		 * @param x X位置(m)。
		 * @param y Y位置(m)。
		 * @param radius 半径。
		 * @param density 密度。
		 * @param friction 摩擦。
		 * @param restitution 弾性。
		 * @return 円形物質。
		 */
		private function createCircle(
			bodyDef:b2BodyDef, fixtureDef:b2FixtureDef, x:Number, y:Number,
			radius:Number, density:Number, friction:Number, restitution:Number):b2Body
		{
			var shape:b2CircleShape = new b2CircleShape(radius);
			fixtureDef.shape = shape;
			fixtureDef.density = density;
			fixtureDef.friction = friction;
			fixtureDef.restitution = restitution;
			bodyDef.position.Set(x, y);
			var body:b2Body = _world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			return body;
		}
	}
}
