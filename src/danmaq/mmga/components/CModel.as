package danmaq.mmga.components
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
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
		
		//* constants ──────────────────────────────-*
		
		/** 物体定義。 */
		private const bodyDef:b2BodyDef = new b2BodyDef();
		
		/** 材質定義。 */
		private const fixtureDef:b2FixtureDef = new b2FixtureDef();
		
		/** 関節定義。 */
		private const jointDef:b2RevoluteJointDef = new b2RevoluteJointDef();

		//* fields ────────────────────────────────*
		
		/** 物理演算空間。 */
		private var _world:b2World;

		/** 頭-首の関節。 */
		private var _headToNeck:b2Joint;
		
		/** 首-上半身の関節。 */
		private var _neckToTorso1:b2Joint;
		
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
			bodyDef.type = b2Body.b2_dynamicBody;
			var head:b2Body = createCircle(0, -1.4, 0.16, 1, 0.4, 0.1);
			var neck:b2Body = createRect(0, -1.25, 0.05, 0.05, 1, 0.4, 0.1);
			var torso1:b2Body = createRect(0, -1.1, 0.15, 0.15, 1, 0.4, 0.1);
			/*
			var sholderR:b2Body = createRect(0.2, -1.1, 0.03, 0.03, 1, 0.4, 0.1);
			var sholderL:b2Body = createRect(-0.2, -1.1, 0.03, 0.03, 1, 0.4, 0.1);
			var armR1:b2Body = createRect(0.2, -1.15, 0.03, 0.15, 1, 0.4, 0.1);
			var armL1:b2Body = createRect(-0.2, -1.15, 0.03, 0.15, 1, 0.4, 0.1);
			var armR2:b2Body = createRect(0.22, -0.75, 0.02, 0.15, 1, 0.4, 0.1);
			var armL2:b2Body = createRect(-0.22, -0.75, 0.02, 0.15, 1, 0.4, 0.1);
			var torso2:b2Body = createRect(0, -0.9, 0.08, 0.1, 1, 0.4, 0.1);
			var legR1:b2Body = createRect(0.15, -0.75, 0.05, 0.2, 1, 0.4, 0.1);
			var legL1:b2Body = createRect(-0.15, -0.75, 0.05, 0.2, 1, 0.4, 0.1);
*/
			var legR2:b2Body = createRect(0.15, -0.35, 0.04, 0.2, 1, 0.4, 0.1);
			var legL2:b2Body = createRect(-0.15, -0.35, 0.04, 0.2, 1, 0.4, 0.1);
			var footR:b2Body = createRect(0.2, -0.05, 0.1, 0.05, 1, 0.4, 0.1);
			var footL:b2Body = createRect(-0.2, -0.05, 0.1, 0.05, 1, 0.4, 0.1);
			
			jointDef.enableLimit = true;
			jointDef.enableMotor = false;
			_headToNeck = createJoint(head, neck, new b2Vec2(0, -1.3));
			_neckToTorso1 = createJoint(neck, torso1, new b2Vec2(0, -1.2));
		}

		private function createJoint(bodyA:b2Body, bodyB:b2Body, joint:b2Vec2):b2Joint
		{
			jointDef.Initialize(bodyA, bodyB, new b2Vec2(0, -1.3));
			return _world.CreateJoint(jointDef);
		}
		
		/**
		 * 円形物質を作成します。
		 * 
		 * @param x X位置(m)。
		 * @param y Y位置(m)。
		 * @param radius 半径。
		 * @param density 密度。
		 * @param friction 摩擦。
		 * @param restitution 弾性。
		 * @return 円形物質。
		 */
		private function createCircle(
			x:Number, y:Number, radius:Number,
			density:Number, friction:Number, restitution:Number):b2Body
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
		
		/**
		 * 矩形物質を作成します。
		 * 
		 * @param x X位置(m)。
		 * @param y Y位置(m)。
		 * @param width 幅。
		 * @param height 高さ。
		 * @param density 密度。
		 * @param friction 摩擦。
		 * @param restitution 弾性。
		 * @return 円形物質。
		 */
		private function createRect(
			x:Number, y:Number, width:Number, height:Number,
			density:Number, friction:Number, restitution:Number):b2Body
		{
			var shape:b2PolygonShape = new b2PolygonShape();
			shape.SetAsBox(width, height);
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
