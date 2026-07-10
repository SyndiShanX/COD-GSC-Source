require("x64:68c6f2b45234b48")
require("x64:ebb9f711d489cde")
CoD.seeker_mine_prompt = InheritFrom(CoD.Menu)
LUI.createMenu.seeker_mine_prompt = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("seeker_mine_prompt", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.seeker_mine_prompt)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local progressRing = LUI.UIImage.new(0.5, 0.5, -57, 57, 0, 0, 765.5, 879.5)
	progressRing:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	progressRing:setScale(0.9, 0.9)
	progressRing:setImage(RegisterImage(@"uie_ui_icon_controller_radial_fill_hud_lg"))
	progressRing:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	progressRing:setShaderVector(1, 0.5, 0, 0, 0)
	progressRing:setShaderVector(2, 0.5, 0, 0, 0)
	progressRing:setShaderVector(3, 0, 1, 0, 0)
	progressRing:setShaderVector(4, 0, 0, 0, 0)
	progressRing:linkToElementModel(self, "progress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			progressRing:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(progressRing)
	self.progressRing = progressRing
	local pulse = LUI.UIImage.new(0.5, 0.5, -45, 45, 0, 0, 777.5, 867.5)
	pulse:setAlpha(0.4)
	pulse:setScale(0.9, 0.9)
	pulse:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_elliptical_ring_normal"))
	pulse:setShaderVector(0, 10, 0, 0, 0)
	pulse:setShaderVector(1, 128, 128, 0, 0)
	pulse:setShaderVector(2, 0.24, 0.22, 0, 0)
	self:addElement(pulse)
	self.pulse = pulse
	local f1_local4 = nil
	self.buttonImage = LUI.UIElement.createFake()
	local PCProgressCircleBacking = nil
	PCProgressCircleBacking = CoD.PC_ProgressCircleBacking.new(f1_local1, f1_arg0, 0.5, 0.5, -45, 45, 0, 0, 777.5, 867.5)
	PCProgressCircleBacking:mergeStateConditions({
		{
			stateName = "SeekerMine",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	PCProgressCircleBacking:setScale(0.9, 0.9)
	self:addElement(PCProgressCircleBacking)
	self.PCProgressCircleBacking = PCProgressCircleBacking
	local ThumbsUp = LUI.UIImage.new(0.5, 0.5, -39.5, 40.5, 0, 0, 782.5, 862.5)
	ThumbsUp:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	ThumbsUp:setAlpha(0)
	ThumbsUp:setImage(RegisterImage(@"uie_ui_hud_icon_seekermine_success"))
	ThumbsUp:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	ThumbsUp:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(ThumbsUp)
	self.ThumbsUp = ThumbsUp
	local PCtext = nil
	PCtext = CoD.PC_SeekerMine_Text.new(f1_local1, f1_arg0, 0.5, 0.5, -150, 150, 0.1, 0.1, 761, 791)
	self:addElement(PCtext)
	self.PCtext = PCtext
	self:mergeStateConditions({
		{
			stateName = "Fail",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "promptState", 3) and not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
			end,
		},
		{
			stateName = "Success",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "promptState", 1) and not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
			end,
		},
		{
			stateName = "Started",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg0, "promptState", 0) and not Engine[@"isvisibilitybitset"](f1_arg0, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
			end,
		},
	})
	self:linkToElementModel(self, "promptState", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "promptState",
		})
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.seeker_mine_prompt.__resetProperties = function(f9_arg0)
	f9_arg0.ThumbsUp:completeAnimation()
	f9_arg0.progressRing:completeAnimation()
	f9_arg0.buttonImage:completeAnimation()
	f9_arg0.pulse:completeAnimation()
	f9_arg0.PCProgressCircleBacking:completeAnimation()
	f9_arg0.ThumbsUp:setAlpha(0)
	f9_arg0.ThumbsUp:setScale(1, 1)
	f9_arg0.progressRing:setAlpha(1)
	f9_arg0.progressRing:setScale(0.9, 0.9)
	f9_arg0.progressRing:setShaderVector(1, 0.5, 0, 0, 0)
	f9_arg0.progressRing:setShaderVector(2, 0.5, 0, 0, 0)
	f9_arg0.progressRing:setShaderVector(3, 0, 1, 0, 0)
	f9_arg0.progressRing:setShaderVector(4, 0, 0, 0, 0)
	f9_arg0.buttonImage:setRGB(1, 1, 1)
	f9_arg0.buttonImage:setAlpha(1)
	f9_arg0.buttonImage:setScale(0.9, 0.9)
	f9_arg0.pulse:setRGB(1, 1, 1)
	f9_arg0.pulse:setAlpha(0.4)
	f9_arg0.pulse:setScale(0.9, 0.9)
	f9_arg0.pulse:setShaderVector(0, 10, 0, 0, 0)
	f9_arg0.pulse:setShaderVector(1, 128, 128, 0, 0)
	f9_arg0.pulse:setShaderVector(2, 0.24, 0.22, 0, 0)
	f9_arg0.PCProgressCircleBacking:setRGB(1, 1, 1)
	f9_arg0.PCProgressCircleBacking:setAlpha(1)
	f9_arg0.PCProgressCircleBacking:setScale(0.9, 0.9)
end
CoD.seeker_mine_prompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.progressRing:completeAnimation()
			f10_arg0.progressRing:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.progressRing)
			f10_arg0.pulse:completeAnimation()
			f10_arg0.pulse:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.pulse)
			f10_arg0.buttonImage:completeAnimation()
			f10_arg0.buttonImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.buttonImage)
			f10_arg0.ThumbsUp:completeAnimation()
			f10_arg0.ThumbsUp:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ThumbsUp)
		end,
	},
	Fail = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.progressRing:completeAnimation()
			f11_arg0.progressRing:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.progressRing)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(250)
					f13_arg0:setAlpha(0)
					f13_arg0:setScale(1.4, 1.4)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.pulse:beginAnimation(250)
				f11_arg0.pulse:setAlpha(0.2)
				f11_arg0.pulse:setScale(1.3, 1.3)
				f11_arg0.pulse:setShaderVector(0, 20, 0, 0, 0)
				f11_arg0.pulse:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.pulse:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.pulse:completeAnimation()
			f11_arg0.pulse:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
			f11_arg0.pulse:setAlpha(0.4)
			f11_arg0.pulse:setScale(0.9, 0.9)
			f11_arg0.pulse:setShaderVector(0, 10, 0, 0, 0)
			f11_arg0.pulse:setShaderVector(1, 128, 128, 0, 0)
			f11_arg0.pulse:setShaderVector(2, 0.24, 0.22, 0, 0)
			f11_local0(f11_arg0.pulse)
			f11_arg0.buttonImage:completeAnimation()
			f11_arg0.buttonImage:setRGB(0, 0, 0)
			f11_arg0.buttonImage:setAlpha(0.75)
			f11_arg0.clipFinished(f11_arg0.buttonImage)
			f11_arg0.PCProgressCircleBacking:completeAnimation()
			f11_arg0.PCProgressCircleBacking:setRGB(0, 0, 0)
			f11_arg0.PCProgressCircleBacking:setAlpha(0.75)
			f11_arg0.clipFinished(f11_arg0.PCProgressCircleBacking)
		end,
	},
	Success = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			local f14_local0 = function(f15_arg0)
				f14_arg0.progressRing:beginAnimation(120)
				f14_arg0.progressRing:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.progressRing:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.progressRing:completeAnimation()
			f14_arg0.progressRing:setAlpha(0)
			f14_arg0.progressRing:setScale(0.01, 0.9)
			f14_local0(f14_arg0.progressRing)
			local f14_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(200)
					f17_arg0:setAlpha(0)
					f17_arg0:setScale(1.4, 1.4)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f16_arg0:beginAnimation(199)
				f16_arg0:setAlpha(0.2)
				f16_arg0:setScale(1.3, 1.3)
				f16_arg0:setShaderVector(0, 20, 0, 0, 0)
				f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f14_arg0.pulse:beginAnimation(10)
			f14_arg0.pulse:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f14_arg0.pulse:setAlpha(0.4)
			f14_arg0.pulse:setScale(0.9, 0.9)
			f14_arg0.pulse:setShaderVector(0, 10, 0, 0, 0)
			f14_arg0.pulse:setShaderVector(1, 128, 128, 0, 0)
			f14_arg0.pulse:setShaderVector(2, 0.24, 0.22, 0, 0)
			f14_arg0.pulse:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
			f14_arg0.pulse:registerEventHandler("transition_complete_keyframe", f14_local1)
			f14_arg0.buttonImage:completeAnimation()
			f14_arg0.buttonImage:setScale(0.9, 0.9)
			f14_arg0.clipFinished(f14_arg0.buttonImage)
			local f14_local2 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(80)
					f19_arg0:setScale(1.1, 1.1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.ThumbsUp:beginAnimation(120, Enum[@"luitween"][@"luitween_ease_in"])
				f14_arg0.ThumbsUp:setAlpha(1)
				f14_arg0.ThumbsUp:setScale(0.9, 0.9)
				f14_arg0.ThumbsUp:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ThumbsUp:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f14_arg0.ThumbsUp:completeAnimation()
			f14_arg0.ThumbsUp:setAlpha(0)
			f14_arg0.ThumbsUp:setScale(3, 3)
			f14_local2(f14_arg0.ThumbsUp)
		end,
	},
	Started = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						local f23_local0 = function(f24_arg0)
							f24_arg0:beginAnimation(250)
							f24_arg0:setScale(0.9, 0.9)
							f24_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
						end
						f23_arg0:beginAnimation(250)
						f23_arg0:setScale(1, 1)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
					end
					f22_arg0:beginAnimation(250)
					f22_arg0:setScale(0.9, 0.9)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f20_arg0.progressRing:beginAnimation(250)
				f20_arg0.progressRing:setScale(1, 1)
				f20_arg0.progressRing:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.progressRing:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.progressRing:completeAnimation()
			f20_arg0.progressRing:setScale(0.9, 0.9)
			f20_arg0.progressRing:setShaderVector(1, 0.5, 0, 0, 0)
			f20_arg0.progressRing:setShaderVector(2, 0.5, 0, 0, 0)
			f20_arg0.progressRing:setShaderVector(3, 0, 1, 0, 0)
			f20_arg0.progressRing:setShaderVector(4, 0, 0, 0, 0)
			f20_local0(f20_arg0.progressRing)
			local f20_local1 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					local f26_local0 = function(f27_arg0)
						local f27_local0 = function(f28_arg0)
							local f28_local0 = function(f29_arg0)
								f29_arg0:beginAnimation(249)
								f29_arg0:setAlpha(0)
								f29_arg0:setScale(1.4, 1.4)
								f29_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
							end
							f28_arg0:beginAnimation(240)
							f28_arg0:setAlpha(0.2)
							f28_arg0:setScale(1.3, 1.3)
							f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
						end
						f27_arg0:beginAnimation(9)
						f27_arg0:setAlpha(0.4)
						f27_arg0:setScale(0.9, 0.9)
						f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
					end
					f26_arg0:beginAnimation(250)
					f26_arg0:setAlpha(0)
					f26_arg0:setScale(1.4, 1.4)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
				end
				f25_arg0:beginAnimation(250)
				f25_arg0:setAlpha(0.2)
				f25_arg0:setScale(1.3, 1.3)
				f25_arg0:setShaderVector(0, 20, 0, 0, 0)
				f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f20_arg0.pulse:beginAnimation(40)
			f20_arg0.pulse:setAlpha(0.4)
			f20_arg0.pulse:setScale(0.9, 0.9)
			f20_arg0.pulse:setShaderVector(0, 10, 0, 0, 0)
			f20_arg0.pulse:setShaderVector(1, 128, 128, 0, 0)
			f20_arg0.pulse:setShaderVector(2, 0.24, 0.22, 0, 0)
			f20_arg0.pulse:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
			f20_arg0.pulse:registerEventHandler("transition_complete_keyframe", f20_local1)
			local f20_local2 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					local f31_local0 = function(f32_arg0)
						local f32_local0 = function(f33_arg0)
							f33_arg0:beginAnimation(250)
							f33_arg0:setScale(0.9, 0.9)
							f33_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
						end
						f32_arg0:beginAnimation(250)
						f32_arg0:setScale(1, 1)
						f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
					end
					f31_arg0:beginAnimation(250)
					f31_arg0:setScale(0.9, 0.9)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
				end
				f20_arg0.buttonImage:beginAnimation(250)
				f20_arg0.buttonImage:setScale(1, 1)
				f20_arg0.buttonImage:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.buttonImage:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f20_arg0.buttonImage:completeAnimation()
			f20_arg0.buttonImage:setScale(0.9, 0.9)
			f20_local2(f20_arg0.buttonImage)
			local f20_local3 = function(f34_arg0)
				local f34_local0 = function(f35_arg0)
					local f35_local0 = function(f36_arg0)
						local f36_local0 = function(f37_arg0)
							f37_arg0:beginAnimation(250)
							f37_arg0:setScale(0.9, 0.9)
							f37_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
						end
						f36_arg0:beginAnimation(250)
						f36_arg0:setScale(1, 1)
						f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
					end
					f35_arg0:beginAnimation(250)
					f35_arg0:setScale(0.9, 0.9)
					f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
				end
				f20_arg0.PCProgressCircleBacking:beginAnimation(250)
				f20_arg0.PCProgressCircleBacking:setScale(1, 1)
				f20_arg0.PCProgressCircleBacking:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.PCProgressCircleBacking:registerEventHandler("transition_complete_keyframe", f34_local0)
			end
			f20_arg0.PCProgressCircleBacking:completeAnimation()
			f20_arg0.PCProgressCircleBacking:setScale(0.9, 0.9)
			f20_local3(f20_arg0.PCProgressCircleBacking)
			f20_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.seeker_mine_prompt.__onClose = function(f38_arg0)
	f38_arg0.progressRing:close()
	f38_arg0.buttonImage:close()
	f38_arg0.PCProgressCircleBacking:close()
	f38_arg0.PCtext:close()
end
