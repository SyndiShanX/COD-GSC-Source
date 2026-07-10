CoD.arenaLeaguePlayRubies = InheritFrom(LUI.UIElement)
CoD.arenaLeaguePlayRubies.__defaultWidth = 140
CoD.arenaLeaguePlayRubies.__defaultHeight = 40
CoD.arenaLeaguePlayRubies.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.arenaLeaguePlayRubies)
	self.id = "arenaLeaguePlayRubies"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local frame1 = LUI.UIImage.new(0, 0, 5, 45, 0, 0, 0, 40)
	frame1:setImage(RegisterImage(@"uie_ui_menu_arena_rubyframe"))
	self:addElement(frame1)
	self.frame1 = frame1
	local gem1 = LUI.UIImage.new(0, 0, 5, 45, 0, 0, 0, 40)
	gem1:setAlpha(0)
	gem1:setImage(RegisterImage(@"uie_ui_menu_arena_ruby"))
	self:addElement(gem1)
	self.gem1 = gem1
	local frame2 = LUI.UIImage.new(0, 0, 50, 90, 0, 0, 0, 40)
	frame2:setImage(RegisterImage(@"uie_ui_menu_arena_rubyframe"))
	self:addElement(frame2)
	self.frame2 = frame2
	local gem2 = LUI.UIImage.new(0, 0, 50, 90, 0, 0, 0, 40)
	gem2:setAlpha(0)
	gem2:setImage(RegisterImage(@"uie_ui_menu_arena_ruby"))
	self:addElement(gem2)
	self.gem2 = gem2
	local frame3 = LUI.UIImage.new(0, 0, 95, 135, 0, 0, 0, 40)
	frame3:setImage(RegisterImage(@"uie_ui_menu_arena_rubyframe"))
	self:addElement(frame3)
	self.frame3 = frame3
	local gem3 = LUI.UIImage.new(0, 0, 95, 135, 0, 0, 0, 40)
	gem3:setAlpha(0)
	gem3:setImage(RegisterImage(@"uie_ui_menu_arena_ruby"))
	self:addElement(gem3)
	self.gem3 = gem3
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.arenaLeaguePlayRubies.__resetProperties = function(f2_arg0)
	f2_arg0.gem1:completeAnimation()
	f2_arg0.gem2:completeAnimation()
	f2_arg0.gem3:completeAnimation()
	f2_arg0.gem1:setAlpha(0)
	f2_arg0.gem2:setAlpha(0)
	f2_arg0.gem3:setAlpha(0)
end
CoD.arenaLeaguePlayRubies.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	OneRuby = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.gem1:completeAnimation()
			f4_arg0.gem1:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.gem1)
		end,
	},
	TwoRubies = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.gem1:completeAnimation()
			f5_arg0.gem1:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.gem1)
			f5_arg0.gem2:completeAnimation()
			f5_arg0.gem2:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.gem2)
		end,
	},
	ThreeRubies = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.gem1:completeAnimation()
			f6_arg0.gem1:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.gem1)
			f6_arg0.gem2:completeAnimation()
			f6_arg0.gem2:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.gem2)
			f6_arg0.gem3:completeAnimation()
			f6_arg0.gem3:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.gem3)
		end,
	},
}
