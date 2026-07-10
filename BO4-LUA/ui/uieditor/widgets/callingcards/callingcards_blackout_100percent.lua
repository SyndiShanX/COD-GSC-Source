require("x64:4f2c3b37047aab0")
require("x64:759d7e2ada50e5e")
CoD[@"hash_56D6AA0867968387"] = InheritFrom(LUI.UIElement)
CoD[@"hash_56D6AA0867968387"].__defaultWidth = 960
CoD[@"hash_56D6AA0867968387"].__defaultHeight = 240
CoD[@"hash_56D6AA0867968387"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_56D6AA0867968387"])
	self.id = "CallingCards_Blackout_100percent"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage(@"uie_ui_icon_callingcards_backout_100percent_bg"))
	bg:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	bg:setShaderVector(0, 1, 1, 0, 0)
	bg:setShaderVector(1, 0.01, 0, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local gear = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	gear:setImage(RegisterImage(@"uie_ui_icon_callingcards_backout_100percent_front_gear"))
	self:addElement(gear)
	self.gear = gear
	local guy = LUI.UIImage.new(0, 0, 548.5, 860.5, 0, 0, 0, 240)
	guy:setImage(RegisterImage(@"uie_ui_icon_callingcards_backout_100percent_armyguy"))
	self:addElement(guy)
	self.guy = guy
	local arm = CoD.CallingCards_Asset_armyguy_arm.new(f1_arg0, f1_arg1, 0, 0, 481.5, 753.5, 0, 0, 61, 157)
	self:addElement(arm)
	self.arm = arm
	local cigar = LUI.UIImage.new(0, 0, 745.5, 753.5, 0, 0, 29, 37)
	cigar:setImage(RegisterImage(@"uie_ui_icon_callingcards_backout_100percent_cigar"))
	cigar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	cigar:setShaderVector(0, 0, 4, 0, 0)
	cigar:setShaderVector(1, 4, 0, 0, 0)
	self:addElement(cigar)
	self.cigar = cigar
	local cigarSmokeImage = LUI.UIImage.new(0, 0, 741.5, 765.5, 0, 0, -59, 37)
	cigarSmokeImage:setImage(RegisterImage(@"uie_ui_icon_callingcards_backout_100percent_cigar_smoke"))
	cigarSmokeImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	cigarSmokeImage:setShaderVector(0, 1, 1, 0, 0)
	cigarSmokeImage:setShaderVector(1, 0, 0.05, 0, 0)
	self:addElement(cigarSmokeImage)
	self.cigarSmokeImage = cigarSmokeImage
	local helicopterShadow = CoD.CallingCards_Asset_helicopter.new(f1_arg0, f1_arg1, 0, 0, 84.5, 440.5, 0, 0, 97, 209)
	helicopterShadow:setRGB(0, 0, 0)
	helicopterShadow:setAlpha(0.15)
	helicopterShadow:setScale(0.5, 0.5)
	self:addElement(helicopterShadow)
	self.helicopterShadow = helicopterShadow
	local helicopter = CoD.CallingCards_Asset_helicopter.new(f1_arg0, f1_arg1, 0, 0, 125.5, 481.5, 0, 0, -37, 153)
	self:addElement(helicopter)
	self.helicopter = helicopter
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage(@"uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_56D6AA0867968387"].__resetProperties = function(f2_arg0)
	f2_arg0.arm:completeAnimation()
	f2_arg0.helicopter:completeAnimation()
	f2_arg0.helicopterShadow:completeAnimation()
	f2_arg0.arm:setScale(1, 1)
	f2_arg0.helicopter:setTopBottom(0, 0, -37, 153)
	f2_arg0.helicopterShadow:setLeftRight(0, 0, 84.5, 440.5)
	f2_arg0.helicopterShadow:setTopBottom(0, 0, 97, 209)
	f2_arg0.helicopterShadow:setRGB(0, 0, 0)
	f2_arg0.helicopterShadow:setAlpha(0.15)
	f2_arg0.helicopterShadow:setScale(0.5, 0.5)
end
CoD[@"hash_56D6AA0867968387"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1010)
					f5_arg0:setScale(1, 1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.arm:beginAnimation(990)
				f3_arg0.arm:setScale(1.05, 1.03)
				f3_arg0.arm:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.arm:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.arm:completeAnimation()
			f3_arg0.arm:setScale(1, 1)
			f3_local0(f3_arg0.arm)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1010)
					f7_arg0:setTopBottom(0, 0, 97, 209)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.helicopterShadow:beginAnimation(990)
				f3_arg0.helicopterShadow:setTopBottom(0, 0, 107, 219)
				f3_arg0.helicopterShadow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.helicopterShadow:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.helicopterShadow:completeAnimation()
			f3_arg0.helicopterShadow:setLeftRight(0, 0, 84.5, 440.5)
			f3_arg0.helicopterShadow:setTopBottom(0, 0, 97, 209)
			f3_arg0.helicopterShadow:setRGB(0, 0, 0)
			f3_arg0.helicopterShadow:setAlpha(0.15)
			f3_arg0.helicopterShadow:setScale(0.5, 0.5)
			f3_local1(f3_arg0.helicopterShadow)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(1010)
					f9_arg0:setTopBottom(0, 0, -37, 153)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.helicopter:beginAnimation(990)
				f3_arg0.helicopter:setTopBottom(0, 0, -28, 162)
				f3_arg0.helicopter:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.helicopter:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.helicopter:completeAnimation()
			f3_arg0.helicopter:setTopBottom(0, 0, -37, 153)
			f3_local2(f3_arg0.helicopter)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_56D6AA0867968387"].__onClose = function(f10_arg0)
	f10_arg0.arm:close()
	f10_arg0.helicopterShadow:close()
	f10_arg0.helicopter:close()
end
