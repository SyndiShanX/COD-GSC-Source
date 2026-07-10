CoD.LeaguePlayEndRankUpRuby = InheritFrom(LUI.UIElement)
CoD.LeaguePlayEndRankUpRuby.__defaultWidth = 40
CoD.LeaguePlayEndRankUpRuby.__defaultHeight = 40
CoD.LeaguePlayEndRankUpRuby.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeaguePlayEndRankUpRuby)
	self.id = "LeaguePlayEndRankUpRuby"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RubySlot = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -20, 20)
	RubySlot:setImage(RegisterImage(0x81EAB9F8F5950E7))
	self:addElement(RubySlot)
	self.RubySlot = RubySlot
	local Ruby = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -20, 20)
	Ruby:setAlpha(0.2)
	Ruby:setImage(RegisterImage(0x17ED8E3A9A3FC36))
	self:addElement(Ruby)
	self.Ruby = Ruby
	local RubyAnim = LUI.UIImage.new(0.5, 0.5, -26.5, 26.5, 0.5, 0.5, -28, 25)
	RubyAnim:setImage(RegisterImage(0x88F3083B7A9ADAD))
	RubyAnim:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	RubyAnim:setShaderVector(0, 4, 4, 0, 0)
	RubyAnim:setShaderVector(1, 5, 0, 0, 0)
	self:addElement(RubyAnim)
	self.RubyAnim = RubyAnim
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeaguePlayEndRankUpRuby.__resetProperties = function(f2_arg0)
	f2_arg0.Ruby:completeAnimation()
	f2_arg0.RubyAnim:completeAnimation()
	f2_arg0.Ruby:setAlpha(0.2)
	f2_arg0.RubyAnim:setAlpha(1)
	f2_arg0.RubyAnim:setScale(1, 1)
end
CoD.LeaguePlayEndRankUpRuby.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.Ruby:completeAnimation()
			f3_arg0.Ruby:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Ruby)
			f3_arg0.RubyAnim:completeAnimation()
			f3_arg0.RubyAnim:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.RubyAnim)
		end,
		Filling = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(200)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f5_arg0:beginAnimation(49)
				f5_arg0:setAlpha(0.2)
				f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.Ruby:beginAnimation(150)
			f4_arg0.Ruby:setAlpha(0)
			f4_arg0.Ruby:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
			f4_arg0.Ruby:registerEventHandler("transition_complete_keyframe", f4_local0)
			local f4_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(200)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.RubyAnim:beginAnimation(200)
				f4_arg0.RubyAnim:setAlpha(1)
				f4_arg0.RubyAnim:setScale(1, 1)
				f4_arg0.RubyAnim:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.RubyAnim:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f4_arg0.RubyAnim:completeAnimation()
			f4_arg0.RubyAnim:setAlpha(0)
			f4_arg0.RubyAnim:setScale(4, 4)
			f4_local1(f4_arg0.RubyAnim)
		end,
		Filled = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.Ruby:completeAnimation()
			f9_arg0.Ruby:setAlpha(0.2)
			f9_arg0.clipFinished(f9_arg0.Ruby)
			f9_arg0.RubyAnim:completeAnimation()
			f9_arg0.RubyAnim:setAlpha(1)
			f9_arg0.RubyAnim:setScale(1, 1)
			f9_arg0.clipFinished(f9_arg0.RubyAnim)
		end,
	},
}
