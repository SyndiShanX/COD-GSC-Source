CoD.arenaLeaguePlayRuby = InheritFrom(LUI.UIElement)
CoD.arenaLeaguePlayRuby.__defaultWidth = 40
CoD.arenaLeaguePlayRuby.__defaultHeight = 40
CoD.arenaLeaguePlayRuby.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.arenaLeaguePlayRuby)
	self.id = "arenaLeaguePlayRuby"
	self.soundSet = "none"
	local Ruby = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -20, 20)
	Ruby:setAlpha(0.2)
	Ruby:setImage(RegisterImage(@"uie_ui_menu_arena_ruby"))
	self:addElement(Ruby)
	self.Ruby = Ruby
	local RubyAnim = LUI.UIImage.new(0.5, 0.5, -26.5, 26.5, 0.5, 0.5, -28, 25)
	RubyAnim:setImage(RegisterImage(@"uie_ui_menu_arena_ruby_flipbook"))
	RubyAnim:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	RubyAnim:setShaderVector(0, 4, 4, 0, 0)
	RubyAnim:setShaderVector(1, 5, 0, 0, 0)
	self:addElement(RubyAnim)
	self.RubyAnim = RubyAnim
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
