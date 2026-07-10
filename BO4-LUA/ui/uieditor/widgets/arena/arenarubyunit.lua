CoD.ArenaRubyUnit = InheritFrom(LUI.UIElement)
CoD.ArenaRubyUnit.__defaultWidth = 50
CoD.ArenaRubyUnit.__defaultHeight = 50
CoD.ArenaRubyUnit.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaRubyUnit)
	self.id = "ArenaRubyUnit"
	self.soundSet = "default"
	local RubyFrame = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	RubyFrame:setImage(RegisterImage(@"ui_menu_arena_rubyframe"))
	self:addElement(RubyFrame)
	self.RubyFrame = RubyFrame
	local Ruby = LUI.UIImage.new(0, 0, 0, 50, 0, 0, 0, 50)
	Ruby:setImage(RegisterImage(@"uie_ui_menu_arena_ruby"))
	self:addElement(Ruby)
	self.Ruby = Ruby
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
