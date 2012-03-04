package danmaq.mmga.data
{

	/**
	 * デバッグ ビルドかどうかを取得します。
	 *
	 * @return デバッグ ビルドである場合、<code>true</code>。
	 */
	public function isAuthoring():Boolean
	{
		var result:Boolean = false;
		CONFIG::FLASH_AUTHORING
		{
			result = true;
		}
		return result;
	}
}
