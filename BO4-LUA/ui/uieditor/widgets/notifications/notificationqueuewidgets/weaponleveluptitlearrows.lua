CoD.WeaponLevelUpTitleArrows = InheritFrom(LUI.UIElement)
CoD.WeaponLevelUpTitleArrows.__defaultWidth = 21
CoD.WeaponLevelUpTitleArrows.__defaultHeight = 9
CoD.WeaponLevelUpTitleArrows.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelUpTitleArrows)
	self.id = "WeaponLevelUpTitleArrows"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TriangleLarge = LUI.UIImage.new(0, 0, 0, 9, 0, 0, 0, 9)
	TriangleLarge:setRGB(0.12, 0.12, 0.12)
	TriangleLarge:setAlpha(0.5)
	TriangleLarge:setImage(RegisterImage(@"uie_ui_hud_notifications_triangle"))
	self:addElement(TriangleLarge)
	self.TriangleLarge = TriangleLarge
	local TriangleMedium = LUI.UIImage.new(0, 0, 9.5, 16.5, 0, 0, 1, 8)
	TriangleMedium:setRGB(0.12, 0.12, 0.12)
	TriangleMedium:setAlpha(0.5)
	TriangleMedium:setImage(RegisterImage(@"uie_ui_hud_notifications_triangle"))
	self:addElement(TriangleMedium)
	self.TriangleMedium = TriangleMedium
	local TriangleSmall = LUI.UIImage.new(0, 0, 17, 21, 0, 0, 2.5, 6.5)
	TriangleSmall:setRGB(0.12, 0.12, 0.12)
	TriangleSmall:setAlpha(0.5)
	TriangleSmall:setImage(RegisterImage(@"uie_ui_hud_notifications_triangle"))
	self:addElement(TriangleSmall)
	self.TriangleSmall = TriangleSmall
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponLevelUpTitleArrows.__resetProperties = function(f2_arg0)
	f2_arg0.TriangleLarge:completeAnimation()
	f2_arg0.TriangleMedium:completeAnimation()
	f2_arg0.TriangleSmall:completeAnimation()
	f2_arg0.TriangleLarge:setAlpha(0.5)
	f2_arg0.TriangleMedium:setAlpha(0.5)
	f2_arg0.TriangleSmall:setAlpha(0.5)
end
CoD.WeaponLevelUpTitleArrows.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				f3_arg0.TriangleLarge:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f3_arg0.TriangleLarge:setAlpha(0.05)
				f3_arg0.TriangleLarge:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.TriangleLarge:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.TriangleLarge:completeAnimation()
			f3_arg0.TriangleLarge:setAlpha(0.5)
			f3_local0(f3_arg0.TriangleLarge)
			local f3_local1 = function(f5_arg0)
				f5_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f5_arg0:setAlpha(0.05)
				f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.TriangleMedium:beginAnimation(200)
			f3_arg0.TriangleMedium:setAlpha(0.5)
			f3_arg0.TriangleMedium:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.TriangleMedium:registerEventHandler("transition_complete_keyframe", f3_local1)
			local f3_local2 = function(f6_arg0)
				f6_arg0:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_out"])
				f6_arg0:setAlpha(0.05)
				f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.TriangleSmall:beginAnimation(400)
			f3_arg0.TriangleSmall:setAlpha(0.5)
			f3_arg0.TriangleSmall:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.TriangleSmall:registerEventHandler("transition_complete_keyframe", f3_local2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
