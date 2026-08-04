require("ui/uieditor/widgets/callingcards/callingcards_asset_falconfly")
CoD.callingcards_zm_zombie_hunter_08 = InheritFrom(LUI.UIElement)
CoD.callingcards_zm_zombie_hunter_08.__defaultWidth = 960
CoD.callingcards_zm_zombie_hunter_08.__defaultHeight = 240
CoD.callingcards_zm_zombie_hunter_08.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_zm_zombie_hunter_08)
	self.id = "CallingCards_zm_Zombie_Hunter_08"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	bg:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_background"))
	bg:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	bg:setShaderVector(0, 1, 1, 0, 0)
	bg:setShaderVector(1, -0.05, 0, 0, 0)
	self:addElement(bg)
	self.bg = bg
	local lightening2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightening2:setAlpha(0)
	lightening2:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_lightening2"))
	lightening2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(lightening2)
	self.lightening2 = lightening2
	local lightening1 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	lightening1:setAlpha(0)
	lightening1:setImage(RegisterImage("uie_ui_icon_callingcards_zm_zombie_hunter_08_lightening1"))
	lightening1:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(lightening1)
	self.lightening1 = lightening1
	local dust = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	dust:setAlpha(0.6)
	dust:setImage(RegisterImage("uie_ui_icon_callingcards_professional_master_dust"))
	dust:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	dust:setShaderVector(0, 1, 1, 0, 0)
	dust:setShaderVector(1, 0.45, 0, 0, 0)
	self:addElement(dust)
	self.dust = dust
	local topwing = CoD.CallingCards_Asset_falconfly.new(f1_arg0, f1_arg1, 0, 0, 457, 897, 0, 0, -9.5, 232.5)
	self:addElement(topwing)
	self.topwing = topwing
	local dust2 = LUI.UIImage.new(0, 0, -23, 992, 0, 0, 111.5, 351.5)
	dust2:setAlpha(0.25)
	dust2:setScale(1.11, 1.37)
	dust2:setImage(RegisterImage("uie_ui_icon_callingcards_professional_master_dust"))
	dust2:setMaterial(LUI.UIImage.GetCachedMaterial("uie_tile_scroll_normal"))
	dust2:setShaderVector(0, 1, 1, 0, 0)
	dust2:setShaderVector(1, 0.45, 0, 0, 0)
	self:addElement(dust2)
	self.dust2 = dust2
	local cropper = LUI.UIImage.new(0, 0, -32, 992, 0, 0, -392, 632)
	cropper:setAlpha(0)
	cropper:setImage(RegisterImage("uie_stage_crop_prop"))
	self:addElement(cropper)
	self.cropper = cropper
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_zm_zombie_hunter_08.__resetProperties = function(f2_arg0)
	f2_arg0.lightening1:completeAnimation()
	f2_arg0.bg:completeAnimation()
	f2_arg0.topwing:completeAnimation()
	f2_arg0.lightening2:completeAnimation()
	f2_arg0.lightening1:setAlpha(0)
	f2_arg0.bg:setRGB(1, 1, 1)
	f2_arg0.topwing:setTopBottom(0, 0, -9.5, 232.5)
	f2_arg0.lightening2:setAlpha(0)
end
CoD.callingcards_zm_zombie_hunter_08.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(4)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(1280)
							f7_arg0:setRGB(1, 1, 1)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(1010)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(570)
					f5_arg0:setRGB(0.53, 0.36, 0.36)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.bg:beginAnimation(1150)
				f3_arg0.bg:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.bg:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.bg:completeAnimation()
			f3_arg0.bg:setRGB(1, 1, 1)
			f3_local0(f3_arg0.bg)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(9)
						f10_arg0:setAlpha(0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(320)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f8_arg0:beginAnimation(9)
				f8_arg0:setAlpha(1)
				f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.lightening2:beginAnimation(1850)
			f3_arg0.lightening2:setAlpha(0)
			f3_arg0.lightening2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
			f3_arg0.lightening2:registerEventHandler("transition_complete_keyframe", f3_local1)
			local f3_local2 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					local f12_local0 = function(f13_arg0)
						local f13_local0 = function(f14_arg0)
							f14_arg0:beginAnimation(9)
							f14_arg0:setAlpha(0)
							f14_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f13_arg0:beginAnimation(230)
						f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
					end
					f12_arg0:beginAnimation(9)
					f12_arg0:setAlpha(1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
				end
				f3_arg0.lightening1:beginAnimation(1610)
				f3_arg0.lightening1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lightening1:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f3_arg0.lightening1:completeAnimation()
			f3_arg0.lightening1:setAlpha(0)
			f3_local2(f3_arg0.lightening1)
			local f3_local3 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						local f17_local0 = function(f18_arg0)
							f18_arg0:beginAnimation(1010)
							f18_arg0:setTopBottom(0, 0, -14.5, 227.5)
							f18_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
								element:playClip("DefaultClip")
								f3_arg0.clipFinished(element, event)
							end)
						end
						f17_arg0:beginAnimation(990)
						f17_arg0:setTopBottom(0, 0, -4.5, 237.5)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
					end
					f16_arg0:beginAnimation(1010)
					f16_arg0:setTopBottom(0, 0, -14.5, 227.5)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f3_arg0.topwing:playClip("DefaultClip")
				f3_arg0.topwing:beginAnimation(1000)
				f3_arg0.topwing:setTopBottom(0, 0, -4.5, 237.5)
				f3_arg0.topwing:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.topwing:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f3_arg0.topwing:completeAnimation()
			f3_arg0.topwing:setTopBottom(0, 0, -14.5, 227.5)
			f3_local3(f3_arg0.topwing)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_zm_zombie_hunter_08.__onClose = function(f20_arg0)
	f20_arg0.topwing:close()
end
