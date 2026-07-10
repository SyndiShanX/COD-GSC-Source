require("x64:acbed692442191c")
CoD.IcePickHacked = InheritFrom(LUI.UIElement)
CoD.IcePickHacked.__defaultWidth = 320
CoD.IcePickHacked.__defaultHeight = 100
CoD.IcePickHacked.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.IcePickHacked)
	self.id = "IcePickHacked"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonCornerPips2 = CoD.CommonCornerPips02.new(f1_arg0, f1_arg1, 0, 0, 0, 320, 0, 0, 37.5, 71.5)
	self:addElement(CommonCornerPips2)
	self.CommonCornerPips2 = CommonCornerPips2
	local Background = LUI.UIImage.new(0, 0, 0, 320, 0, 0, 37.5, 71.5)
	Background:setRGB(0.91, 0.23, 0.23)
	self:addElement(Background)
	self.Background = Background
	local Stripe = LUI.UIImage.new(0, 0, 0, 320, 0, 0, 34.5, 74.5)
	Stripe:setAlpha(0)
	Stripe:setImage(RegisterImage(@"uie_ui_menu_common_stripes01"))
	Stripe:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	Stripe:setShaderVector(0, 4, 1, 0, 0)
	Stripe:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(Stripe)
	self.Stripe = Stripe
	local StatusText = LUI.UIText.new(0.5, 0.5, -155, 155, 0.5, 0.5, -6.5, 18.5)
	StatusText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4EA2BAF60DA12D67"))
	StatusText:setTTF("ttmussels_demibold")
	StatusText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StatusText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(StatusText)
	self.StatusText = StatusText
	local RebootBackground = LUI.UIImage.new(0, 0, 10, 310, 0, 0, 78, 96)
	RebootBackground:setRGB(0.15, 0.15, 0.15)
	self:addElement(RebootBackground)
	self.RebootBackground = RebootBackground
	local RebootFillBg = LUI.UIImage.new(0, 0, 15, 305, 0, 0, 81, 93)
	RebootFillBg:setRGB(0.35, 0.35, 0.35)
	RebootFillBg:setAlpha(0)
	RebootFillBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	RebootFillBg:setShaderVector(0, 0, 1, 0, 0)
	RebootFillBg:setShaderVector(1, 0, 0, 0, 0)
	RebootFillBg:setShaderVector(2, 0, 1, 0, 0)
	RebootFillBg:setShaderVector(3, 0, 0, 0, 0)
	RebootFillBg:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(RebootFillBg)
	self.RebootFillBg = RebootFillBg
	local bar = LUI.UIImage.new(0, 0, 15, 305, 1, 1, -22, -4)
	bar:setRGB(0.92, 0.92, 0.92)
	bar:setAlpha(0)
	bar:setImage(RegisterImage(@"uie_ui_hud_core_capture_bar"))
	bar:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	bar:setShaderVector(0, 1, 0, 0, 0)
	bar:setShaderVector(1, 0, 0, 0, 0)
	bar:setShaderVector(2, 1, 0, 0, 0)
	bar:setShaderVector(3, 0, 0, 0, 0)
	bar:setShaderVector(4, 0, 0, 0, 0)
	bar:subscribeToGlobalModel(f1_arg1, "HUDItems", "captureCrateTotalTime", function(model)
		CoD.HUDUtility.SetXFractionByModel(bar, f1_arg1, model)
	end)
	self:addElement(bar)
	self.bar = bar
	local RebootFill = LUI.UIImage.new(0, 0, 15, 305, 0, 0, 81, 93)
	RebootFill:setRGB(0.92, 0.92, 0.92)
	RebootFill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	RebootFill:setShaderVector(1, 0, 0, 0, 0)
	RebootFill:setShaderVector(2, 0, 1, 0, 0)
	RebootFill:setShaderVector(3, 0, 0, 0, 0)
	RebootFill:setShaderVector(4, 0, 0, 0, 0)
	RebootFill:subscribeToGlobalModel(f1_arg1, "HUDItems", "hackedRebootProgress", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RebootFill:beginAnimation(0.05)
			RebootFill:setShaderVector(0, CoD.BaseUtility.AnimateWidgetOnChangeVector(0.05, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(RebootFill)
	self.RebootFill = RebootFill
	local LED = LUI.UIImage.new(0, 0, 3, 184, 0, 0, 70, 110)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.3)
	LED:setScale(0.94, 0.94)
	LED:setImage(RegisterImage(@"uie_ui_hud_core_player_widget_led_status"))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	LED:setShaderVector(0, 0, 1, 0, 0)
	LED:setShaderVector(1, 0, 0, 0, 0)
	LED:setShaderVector(2, 0.24, 0.6, 0, 0)
	LED:setShaderVector(3, 0, 0, 0, 0)
	LED:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED)
	self.LED = LED
	local LED2 = LUI.UIImage.new(0, 0, 155, 336, 0, 0, 70, 110)
	LED2:setRGB(0, 0, 0)
	LED2:setAlpha(0.3)
	LED2:setScale(0.94, 0.94)
	LED2:setImage(RegisterImage(@"uie_ui_hud_core_player_widget_led_status"))
	LED2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	LED2:setShaderVector(0, 0, 0.84, 0, 0)
	LED2:setShaderVector(1, 0, 0, 0, 0)
	LED2:setShaderVector(2, 0.24, 0.6, 0, 0)
	LED2:setShaderVector(3, 0, 0, 0, 0)
	LED2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED2)
	self.LED2 = LED2
	self:mergeStateConditions({
		{
			stateName = "Rebooting",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hacked", 0)
				if f4_local0 then
					f4_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hackedRebootProgress", 0)
					if f4_local0 then
						if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]) then
							f4_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
						else
							f4_local0 = false
						end
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Hacked",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hacked", 0)
				if f5_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_emp_active"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]) then
						f5_local0 = not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.hacked"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.hackedRebootProgress"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.hackedRebootProgress",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_emp_active"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.IcePickHacked.__resetProperties = function(f11_arg0)
	f11_arg0.RebootFill:completeAnimation()
	f11_arg0.RebootBackground:completeAnimation()
	f11_arg0.StatusText:completeAnimation()
	f11_arg0.Background:completeAnimation()
	f11_arg0.LED:completeAnimation()
	f11_arg0.LED2:completeAnimation()
	f11_arg0.CommonCornerPips2:completeAnimation()
	f11_arg0.RebootFillBg:completeAnimation()
	f11_arg0.bar:completeAnimation()
	f11_arg0.Stripe:completeAnimation()
	f11_arg0.RebootFill:setAlpha(1)
	f11_arg0.RebootBackground:setAlpha(1)
	f11_arg0.StatusText:setAlpha(1)
	f11_arg0.StatusText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4EA2BAF60DA12D67"))
	f11_arg0.Background:setRGB(0.91, 0.23, 0.23)
	f11_arg0.Background:setAlpha(1)
	f11_arg0.LED:setAlpha(0.3)
	f11_arg0.LED2:setAlpha(0.3)
	f11_arg0.CommonCornerPips2:setAlpha(1)
	f11_arg0.RebootFillBg:setAlpha(0)
	f11_arg0.bar:setAlpha(0)
	f11_arg0.Stripe:setAlpha(0)
end
CoD.IcePickHacked.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(7)
			f12_arg0.CommonCornerPips2:completeAnimation()
			f12_arg0.CommonCornerPips2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.CommonCornerPips2)
			f12_arg0.Background:completeAnimation()
			f12_arg0.Background:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Background)
			f12_arg0.StatusText:completeAnimation()
			f12_arg0.StatusText:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.StatusText)
			f12_arg0.RebootBackground:completeAnimation()
			f12_arg0.RebootBackground:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RebootBackground)
			f12_arg0.RebootFill:completeAnimation()
			f12_arg0.RebootFill:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RebootFill)
			f12_arg0.LED:completeAnimation()
			f12_arg0.LED:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.LED)
			f12_arg0.LED2:completeAnimation()
			f12_arg0.LED2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.LED2)
		end,
	},
	Rebooting = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(9)
			local f13_local0 = function(f14_arg0)
				f13_arg0.CommonCornerPips2:beginAnimation(200)
				f13_arg0.CommonCornerPips2:setAlpha(1)
				f13_arg0.CommonCornerPips2:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.CommonCornerPips2:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.CommonCornerPips2:completeAnimation()
			f13_arg0.CommonCornerPips2:setAlpha(0)
			f13_local0(f13_arg0.CommonCornerPips2)
			local f13_local1 = function(f15_arg0)
				f13_arg0.Background:beginAnimation(200)
				f13_arg0.Background:setAlpha(0.5)
				f13_arg0.Background:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.Background:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.Background:completeAnimation()
			f13_arg0.Background:setRGB(0.37, 0.37, 0.37)
			f13_arg0.Background:setAlpha(0)
			f13_local1(f13_arg0.Background)
			local f13_local2 = function(f16_arg0)
				f13_arg0.StatusText:beginAnimation(200)
				f13_arg0.StatusText:setAlpha(1)
				f13_arg0.StatusText:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.StatusText:completeAnimation()
			f13_arg0.StatusText:setAlpha(0)
			f13_arg0.StatusText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_367CE4D1F202B65"))
			f13_local2(f13_arg0.StatusText)
			local f13_local3 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(200)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.RebootBackground:beginAnimation(100)
				f13_arg0.RebootBackground:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.RebootBackground:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f13_arg0.RebootBackground:completeAnimation()
			f13_arg0.RebootBackground:setAlpha(0)
			f13_local3(f13_arg0.RebootBackground)
			local f13_local4 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(200)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.RebootFillBg:beginAnimation(100)
				f13_arg0.RebootFillBg:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.RebootFillBg:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f13_arg0.RebootFillBg:completeAnimation()
			f13_arg0.RebootFillBg:setAlpha(0)
			f13_local4(f13_arg0.RebootFillBg)
			f13_arg0.bar:completeAnimation()
			f13_arg0.bar:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.bar)
			local f13_local5 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(200)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.RebootFill:beginAnimation(100)
				f13_arg0.RebootFill:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.RebootFill:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f13_arg0.RebootFill:completeAnimation()
			f13_arg0.RebootFill:setAlpha(0)
			f13_local5(f13_arg0.RebootFill)
			local f13_local6 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(200)
					f24_arg0:setAlpha(0.3)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.LED:beginAnimation(100)
				f13_arg0.LED:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.LED:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f13_arg0.LED:completeAnimation()
			f13_arg0.LED:setAlpha(0)
			f13_local6(f13_arg0.LED)
			local f13_local7 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(200)
					f26_arg0:setAlpha(0.3)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.LED2:beginAnimation(100)
				f13_arg0.LED2:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.LED2:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f13_arg0.LED2:completeAnimation()
			f13_arg0.LED2:setAlpha(0)
			f13_local7(f13_arg0.LED2)
		end,
	},
	Hacked = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(8)
			local f27_local0 = function(f28_arg0)
				f27_arg0.CommonCornerPips2:beginAnimation(200)
				f27_arg0.CommonCornerPips2:setAlpha(1)
				f27_arg0.CommonCornerPips2:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.CommonCornerPips2:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.CommonCornerPips2:completeAnimation()
			f27_arg0.CommonCornerPips2:setAlpha(0)
			f27_local0(f27_arg0.CommonCornerPips2)
			local f27_local1 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						local f31_local0 = function(f32_arg0)
							local f32_local0 = function(f33_arg0)
								local f33_local0 = function(f34_arg0)
									local f34_local0 = function(f35_arg0)
										local f35_local0 = function(f36_arg0)
											local f36_local0 = function(f37_arg0)
												local f37_local0 = function(f38_arg0)
													local f38_local0 = function(f39_arg0)
														f39_arg0:beginAnimation(400)
														f39_arg0:setAlpha(0.8)
														f39_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
													end
													f38_arg0:beginAnimation(330)
													f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
												end
												f37_arg0:beginAnimation(60)
												f37_arg0:setAlpha(1)
												f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
											end
											f36_arg0:beginAnimation(30)
											f36_arg0:setAlpha(0.15)
											f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
										end
										f35_arg0:beginAnimation(30)
										f35_arg0:setAlpha(0.8)
										f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
									end
									f34_arg0:beginAnimation(30)
									f34_arg0:setAlpha(0.1)
									f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
								end
								f33_arg0:beginAnimation(30)
								f33_arg0:setAlpha(0.9)
								f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
							end
							f32_arg0:beginAnimation(30)
							f32_arg0:setAlpha(0.1)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
						end
						f31_arg0:beginAnimation(29)
						f31_arg0:setAlpha(0.9)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(30)
					f30_arg0:setAlpha(0.05)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f27_arg0.Background:beginAnimation(200)
				f27_arg0.Background:setAlpha(0.95)
				f27_arg0.Background:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.Background:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f27_arg0.Background:completeAnimation()
			f27_arg0.Background:setAlpha(0)
			f27_local1(f27_arg0.Background)
			local f27_local2 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					local f41_local0 = function(f42_arg0)
						local f42_local0 = function(f43_arg0)
							local f43_local0 = function(f44_arg0)
								local f44_local0 = function(f45_arg0)
									local f45_local0 = function(f46_arg0)
										local f46_local0 = function(f47_arg0)
											local f47_local0 = function(f48_arg0)
												local f48_local0 = function(f49_arg0)
													local f49_local0 = function(f50_arg0)
														f50_arg0:beginAnimation(330)
														f50_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
													end
													f49_arg0:beginAnimation(60)
													f49_arg0:setAlpha(0.1)
													f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
												end
												f48_arg0:beginAnimation(30)
												f48_arg0:setAlpha(0)
												f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
											end
											f47_arg0:beginAnimation(30)
											f47_arg0:setAlpha(0.1)
											f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
										end
										f46_arg0:beginAnimation(30)
										f46_arg0:setAlpha(0)
										f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
									end
									f45_arg0:beginAnimation(30)
									f45_arg0:setAlpha(0.1)
									f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
								end
								f44_arg0:beginAnimation(30)
								f44_arg0:setAlpha(0)
								f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
							end
							f43_arg0:beginAnimation(29)
							f43_arg0:setAlpha(0.1)
							f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
						end
						f42_arg0:beginAnimation(30)
						f42_arg0:setAlpha(0)
						f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
					end
					f41_arg0:beginAnimation(100)
					f41_arg0:setAlpha(0.1)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
				end
				f27_arg0.Stripe:beginAnimation(100)
				f27_arg0.Stripe:setAlpha(0.3)
				f27_arg0.Stripe:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.Stripe:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f27_arg0.Stripe:completeAnimation()
			f27_arg0.Stripe:setAlpha(0)
			f27_local2(f27_arg0.Stripe)
			local f27_local3 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					local f52_local0 = function(f53_arg0)
						local f53_local0 = function(f54_arg0)
							local f54_local0 = function(f55_arg0)
								local f55_local0 = function(f56_arg0)
									local f56_local0 = function(f57_arg0)
										local f57_local0 = function(f58_arg0)
											local f58_local0 = function(f59_arg0)
												local f59_local0 = function(f60_arg0)
													f60_arg0:beginAnimation(60)
													f60_arg0:setAlpha(1)
													f60_arg0:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
												end
												f59_arg0:beginAnimation(30)
												f59_arg0:setAlpha(0.5)
												f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
											end
											f58_arg0:beginAnimation(30)
											f58_arg0:setAlpha(1)
											f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
										end
										f57_arg0:beginAnimation(30)
										f57_arg0:setAlpha(0.5)
										f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
									end
									f56_arg0:beginAnimation(30)
									f56_arg0:setAlpha(1)
									f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
								end
								f55_arg0:beginAnimation(30)
								f55_arg0:setAlpha(0.5)
								f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
							end
							f54_arg0:beginAnimation(29)
							f54_arg0:setAlpha(1)
							f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
						end
						f53_arg0:beginAnimation(30)
						f53_arg0:setAlpha(0.5)
						f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
					end
					f52_arg0:beginAnimation(100)
					f52_arg0:setAlpha(1)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
				end
				f27_arg0.StatusText:beginAnimation(100)
				f27_arg0.StatusText:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f27_arg0.StatusText:completeAnimation()
			f27_arg0.StatusText:setAlpha(0)
			f27_local3(f27_arg0.StatusText)
			f27_arg0.RebootBackground:completeAnimation()
			f27_arg0.RebootBackground:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RebootBackground)
			f27_arg0.RebootFill:completeAnimation()
			f27_arg0.RebootFill:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RebootFill)
			f27_arg0.LED:completeAnimation()
			f27_arg0.LED:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.LED)
			f27_arg0.LED2:completeAnimation()
			f27_arg0.LED2:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.LED2)
		end,
	},
}
CoD.IcePickHacked.__onClose = function(f61_arg0)
	f61_arg0.CommonCornerPips2:close()
	f61_arg0.bar:close()
	f61_arg0.RebootFill:close()
end
