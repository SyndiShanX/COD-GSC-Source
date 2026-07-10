require("x64:a5427b292028320")
CoD.AmmoWidget_ClipContainerPress = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_ClipContainerPress.__defaultWidth = 162
CoD.AmmoWidget_ClipContainerPress.__defaultHeight = 63
CoD.AmmoWidget_ClipContainerPress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_ClipContainerPress)
	self.id = "AmmoWidget_ClipContainerPress"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Clip = LUI.UIText.new(0.5, 0.5, -116, 116, 1, 1, -92, -32)
	Clip:setRGB(0.85, 0.15, 0.15)
	Clip:setAlpha(0)
	Clip:setText(33)
	Clip:setTTF("0arame_mono_stencil")
	Clip:setLetterSpacing(-3.5)
	Clip:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Clip:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Clip)
	self.Clip = Clip
	local Pixel1 = CoD.DamageWidget_Pixel.new(f1_arg0, f1_arg1, 0, 0, 46, 120, 0, 0, 33, 35)
	Pixel1:setRGB(0.85, 0.15, 0.15)
	Pixel1:setAlpha(0)
	Pixel1:setZRot(-35)
	self:addElement(Pixel1)
	self.Pixel1 = Pixel1
	local Pixel0 = CoD.DamageWidget_Pixel.new(f1_arg0, f1_arg1, 0, 0, 46, 120, 0, 0, 33, 35)
	Pixel0:setRGB(0.85, 0.15, 0.15)
	Pixel0:setAlpha(0)
	Pixel0:setZRot(35)
	self:addElement(Pixel0)
	self.Pixel0 = Pixel0
	local Glow = LUI.UIImage.new(0, 0, 47, 123, 0, 0, -19, 57)
	Glow:setRGB(1, 0, 0)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(@"uie_ui_hud_core_no_ammo_glow"))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Glow)
	self.Glow = Glow
	local LED = LUI.UIImage.new(0, 0, 46, 122, 0, 0, -18, 58)
	LED:setRGB(1, 0, 0)
	LED:setAlpha(0)
	LED:setImage(RegisterImage(@"hash_792846624408DDB0"))
	self:addElement(LED)
	self.LED = LED
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_ClipContainerPress.__resetProperties = function(f2_arg0)
	f2_arg0.Clip:completeAnimation()
	f2_arg0.LED:completeAnimation()
	f2_arg0.Glow:completeAnimation()
	f2_arg0.Clip:setLeftRight(0.5, 0.5, -116, 116)
	f2_arg0.Clip:setTopBottom(1, 1, -92, -32)
	f2_arg0.Clip:setAlpha(0)
	f2_arg0.LED:setAlpha(0)
	f2_arg0.LED:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	f2_arg0.Glow:setLeftRight(0, 0, 47, 123)
	f2_arg0.Glow:setTopBottom(0, 0, -19, 57)
	f2_arg0.Glow:setAlpha(0)
	f2_arg0.Glow:setScale(1, 1)
end
CoD.AmmoWidget_ClipContainerPress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Clip:completeAnimation()
			f3_arg0.Clip:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Clip)
		end,
	},
	NoAmmoPress = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					local f6_local0 = function(f7_arg0)
						local f7_local0 = function(f8_arg0)
							local f8_local0 = function(f9_arg0)
								f9_arg0:beginAnimation(9)
								f9_arg0:setLeftRight(0.5, 0.5, -144, 64)
								f9_arg0:setTopBottom(1, 1, -134, -26)
								f9_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
							end
							f8_arg0:beginAnimation(49)
							f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
						end
						f7_arg0:beginAnimation(10)
						f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
					end
					f6_arg0:beginAnimation(30)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
				end
				f4_arg0.Clip:beginAnimation(30)
				f4_arg0.Clip:setLeftRight(0.5, 0.5, -126.5, 46.5)
				f4_arg0.Clip:setTopBottom(1, 1, -122.5, -37.5)
				f4_arg0.Clip:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Clip:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.Clip:completeAnimation()
			f4_arg0.Clip:setLeftRight(0.5, 0.5, -121, 41)
			f4_arg0.Clip:setTopBottom(1, 1, -119, -41)
			f4_arg0.Clip:setAlpha(0)
			f4_local0(f4_arg0.Clip)
			f4_arg0.Glow:completeAnimation()
			f4_arg0.Glow:setLeftRight(0, 0, 34, 110)
			f4_arg0.Glow:setTopBottom(0, 0, -29, 47)
			f4_arg0.Glow:setAlpha(0.3)
			f4_arg0.Glow:setScale(1.1, 1.1)
			f4_arg0.clipFinished(f4_arg0.Glow)
			f4_arg0.LED:completeAnimation()
			f4_arg0.LED:setAlpha(1)
			f4_arg0.LED:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
			f4_arg0.clipFinished(f4_arg0.LED)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.AmmoWidget_ClipContainerPress.__onClose = function(f10_arg0)
	f10_arg0.Pixel1:close()
	f10_arg0.Pixel0:close()
end
