require("x64:cc4bfb2bbbc1344")
require("x64:667d91f6bed178d")
CoD.vhudHellstormFrameLeft = InheritFrom(LUI.UIElement)
CoD.vhudHellstormFrameLeft.__defaultWidth = 391
CoD.vhudHellstormFrameLeft.__defaultHeight = 484
CoD.vhudHellstormFrameLeft.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhudHellstormFrameLeft)
	self.id = "vhudHellstormFrameLeft"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FrameGraphicLeft = LUI.UIImage.new(0, 0, 74, 110, 0, 0, 0, 484)
	FrameGraphicLeft:setAlpha(0.8)
	FrameGraphicLeft:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_graphic_left"))
	FrameGraphicLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FrameGraphicLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FrameGraphicLeft)
	self.FrameGraphicLeft = FrameGraphicLeft
	local FrameHlineLeft = LUI.UIImage.new(0, 0, 209, 391, 0, 0, 238, 246)
	FrameHlineLeft:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_hline"))
	FrameHlineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	FrameHlineLeft:setShaderVector(0, 0, 1, 0, 0)
	FrameHlineLeft:setShaderVector(1, 0, 0, 0, 0)
	FrameHlineLeft:setShaderVector(2, 0, 1, 0, 0)
	FrameHlineLeft:setShaderVector(3, 0, 0, 0, 0)
	FrameHlineLeft:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(FrameHlineLeft)
	self.FrameHlineLeft = FrameHlineLeft
	local FrameHlineLeft2 = LUI.UIImage.new(0, 0, 209, 391, 0, 0, 238, 246)
	FrameHlineLeft2:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_hline"))
	FrameHlineLeft2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	FrameHlineLeft2:setShaderVector(0, 0, 1, 0, 0)
	FrameHlineLeft2:setShaderVector(1, 0, 0, 0, 0)
	FrameHlineLeft2:setShaderVector(2, 0, 1, 0, 0)
	FrameHlineLeft2:setShaderVector(3, 0, 0, 0, 0)
	FrameHlineLeft2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(FrameHlineLeft2)
	self.FrameHlineLeft2 = FrameHlineLeft2
	local FrameBoxesLeft = LUI.UIImage.new(0, 0, 0, 74, 0, 0, 224, 260)
	FrameBoxesLeft:setAlpha(0.7)
	FrameBoxesLeft:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_boxes"))
	self:addElement(FrameBoxesLeft)
	self.FrameBoxesLeft = FrameBoxesLeft
	local FrameEngineLeft = LUI.UIImage.new(0, 0, 161, 201, 0, 0, 235, 281)
	FrameEngineLeft:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_engine"))
	FrameEngineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(FrameEngineLeft)
	self.FrameEngineLeft = FrameEngineLeft
	local FrameBoxesLeftAdd = LUI.UIImage.new(0, 0, 0, 74, 0, 0, 224, 260)
	FrameBoxesLeftAdd:setAlpha(0.7)
	FrameBoxesLeftAdd:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_boxes"))
	FrameBoxesLeftAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FrameBoxesLeftAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(FrameBoxesLeftAdd)
	self.FrameBoxesLeftAdd = FrameBoxesLeftAdd
	local LMeter = CoD.vhudHellstormFrameAltitudeMeter.new(f1_arg0, f1_arg1, 0, 0, 107, 143, 0.5, 0.5, -224, 226)
	LMeter:mergeStateConditions({
		{
			stateName = "Dock",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.remoteMissilePhase2", 0)
			end,
		},
	})
	local MeterBracketL = LMeter
	local DotL = LMeter.subscribeToModel
	local StrokeL = Engine[@"getmodelforcontroller"](f1_arg1)
	DotL(MeterBracketL, StrokeL["hudItems.remoteMissilePhase2"], function(f3_arg0)
		f1_arg0:updateElementState(LMeter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.remoteMissilePhase2",
		})
	end, false)
	LMeter:setZoom(30)
	LMeter.Image:setShaderVector(1, 0, 0.15, 0, 0)
	self:addElement(LMeter)
	self.LMeter = LMeter
	DotL = LUI.UIImage.new(0.5, 0.5, -53.5, -37.5, 0.5, 0.5, -6, 6)
	DotL:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_indicator"))
	DotL:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(DotL)
	self.DotL = DotL
	MeterBracketL = CoD.vhudHellstormFrameAltitude.new(f1_arg0, f1_arg1, 0, 0, 131, 151, 0.5, 0.5, -224, 226)
	self:addElement(MeterBracketL)
	self.MeterBracketL = MeterBracketL
	StrokeL = LUI.UIImage.new(0.5, 0.5, 14.5, 194.5, 0.5, 0.5, -5.5, 22.5)
	StrokeL:setImage(RegisterImage(@"hash_7EFA29833AEF0480"))
	StrokeL:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	StrokeL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(StrokeL)
	self.StrokeL = StrokeL
	self:mergeStateConditions({
		{
			stateName = "Docked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.remoteMissilePhase2", 0)
			end,
		},
		{
			stateName = "LowAltitude",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rocketAmmo", 1) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "altitude", 5000)
			end,
		},
		{
			stateName = "MediumAltitude",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rocketAmmo", 1) and CoD.ModelUtility.IsSelfModelValueLessThanOrEqualTo(element, f1_arg1, "altitude", 9000)
			end,
		},
		{
			stateName = "HighAltitude",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "rocketAmmo", 1)
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local12(f1_local11, f1_local13["hudItems.remoteMissilePhase2"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "hudItems.remoteMissilePhase2",
		})
	end, false)
	self:linkToElementModel(self, "rocketAmmo", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "rocketAmmo",
		})
	end)
	self:linkToElementModel(self, "altitude", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "altitude",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhudHellstormFrameLeft.__resetProperties = function(f11_arg0)
	f11_arg0.StrokeL:completeAnimation()
	f11_arg0.MeterBracketL:completeAnimation()
	f11_arg0.DotL:completeAnimation()
	f11_arg0.LMeter:completeAnimation()
	f11_arg0.FrameBoxesLeftAdd:completeAnimation()
	f11_arg0.FrameEngineLeft:completeAnimation()
	f11_arg0.FrameBoxesLeft:completeAnimation()
	f11_arg0.FrameHlineLeft2:completeAnimation()
	f11_arg0.FrameHlineLeft:completeAnimation()
	f11_arg0.FrameGraphicLeft:completeAnimation()
	f11_arg0.StrokeL:setAlpha(1)
	f11_arg0.StrokeL:setShaderVector(0, 1, 0, 0, 0)
	f11_arg0.MeterBracketL:setAlpha(1)
	f11_arg0.DotL:setAlpha(1)
	f11_arg0.LMeter:setAlpha(1)
	f11_arg0.FrameBoxesLeftAdd:setAlpha(0.7)
	f11_arg0.FrameBoxesLeftAdd:setShaderVector(0, 1.5, 0, 0, 0)
	f11_arg0.FrameEngineLeft:setAlpha(1)
	f11_arg0.FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
	f11_arg0.FrameBoxesLeft:setAlpha(0.7)
	f11_arg0.FrameHlineLeft2:setAlpha(1)
	f11_arg0.FrameHlineLeft2:setShaderVector(0, 0, 1, 0, 0)
	f11_arg0.FrameHlineLeft2:setShaderVector(1, 0, 0, 0, 0)
	f11_arg0.FrameHlineLeft2:setShaderVector(2, 0, 1, 0, 0)
	f11_arg0.FrameHlineLeft2:setShaderVector(3, 0, 0, 0, 0)
	f11_arg0.FrameHlineLeft2:setShaderVector(4, 0, 0, 0, 0)
	f11_arg0.FrameHlineLeft:setAlpha(1)
	f11_arg0.FrameHlineLeft:setShaderVector(0, 0, 1, 0, 0)
	f11_arg0.FrameHlineLeft:setShaderVector(1, 0, 0, 0, 0)
	f11_arg0.FrameHlineLeft:setShaderVector(2, 0, 1, 0, 0)
	f11_arg0.FrameHlineLeft:setShaderVector(3, 0, 0, 0, 0)
	f11_arg0.FrameHlineLeft:setShaderVector(4, 0, 0, 0, 0)
	f11_arg0.FrameGraphicLeft:setAlpha(0.8)
	f11_arg0.FrameGraphicLeft:setShaderVector(0, 1, 0, 0, 0)
end
CoD.vhudHellstormFrameLeft.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Docked = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(10)
			f13_arg0.FrameGraphicLeft:completeAnimation()
			f13_arg0.FrameGraphicLeft:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameGraphicLeft)
			f13_arg0.FrameHlineLeft:completeAnimation()
			f13_arg0.FrameHlineLeft:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameHlineLeft)
			f13_arg0.FrameHlineLeft2:completeAnimation()
			f13_arg0.FrameHlineLeft2:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameHlineLeft2)
			f13_arg0.FrameBoxesLeft:completeAnimation()
			f13_arg0.FrameBoxesLeft:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameBoxesLeft)
			f13_arg0.FrameEngineLeft:completeAnimation()
			f13_arg0.FrameEngineLeft:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameEngineLeft)
			f13_arg0.FrameBoxesLeftAdd:completeAnimation()
			f13_arg0.FrameBoxesLeftAdd:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameBoxesLeftAdd)
			f13_arg0.LMeter:completeAnimation()
			f13_arg0.LMeter:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.LMeter)
			f13_arg0.DotL:completeAnimation()
			f13_arg0.DotL:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DotL)
			f13_arg0.MeterBracketL:completeAnimation()
			f13_arg0.MeterBracketL:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.MeterBracketL)
			f13_arg0.StrokeL:completeAnimation()
			f13_arg0.StrokeL:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.StrokeL)
		end,
	},
	LowAltitude = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(200)
					f16_arg0:setShaderVector(0, 2, 0, 0, 0)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.StrokeL:beginAnimation(1000)
				f14_arg0.StrokeL:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.StrokeL:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.StrokeL:completeAnimation()
			f14_arg0.StrokeL:setShaderVector(0, 1.5, 0, 0, 0)
			f14_local0(f14_arg0.StrokeL)
		end,
	},
	MediumAltitude = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(200)
					f19_arg0:setShaderVector(0, 1.5, 0, 0, 0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.StrokeL:beginAnimation(1000)
				f17_arg0.StrokeL:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.StrokeL:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.StrokeL:completeAnimation()
			f17_arg0.StrokeL:setAlpha(1)
			f17_arg0.StrokeL:setShaderVector(0, 1, 0, 0, 0)
			f17_local0(f17_arg0.StrokeL)
		end,
	},
	HighAltitude = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(6)
			local f20_local0 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						local f23_local0 = function(f24_arg0)
							f24_arg0:beginAnimation(200)
							f24_arg0:setAlpha(0.8)
							f24_arg0:setShaderVector(0, 1, 0, 0, 0)
							f24_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
						end
						f23_arg0:beginAnimation(50)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
					end
					f22_arg0:beginAnimation(149)
					f22_arg0:setAlpha(1)
					f22_arg0:setShaderVector(0, 2, 0, 0, 0)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f20_arg0.FrameGraphicLeft:beginAnimation(800)
				f20_arg0.FrameGraphicLeft:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameGraphicLeft:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.FrameGraphicLeft:completeAnimation()
			f20_arg0.FrameGraphicLeft:setAlpha(0.8)
			f20_arg0.FrameGraphicLeft:setShaderVector(0, 1, 0, 0, 0)
			f20_local0(f20_arg0.FrameGraphicLeft)
			local f20_local1 = function(f25_arg0)
				local f25_local0 = function(f26_arg0)
					f26_arg0:beginAnimation(399)
					f26_arg0:setShaderVector(0, 0, 1, 0, 0)
					f26_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.FrameHlineLeft:beginAnimation(300)
				f20_arg0.FrameHlineLeft:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameHlineLeft:registerEventHandler("transition_complete_keyframe", f25_local0)
			end
			f20_arg0.FrameHlineLeft:completeAnimation()
			f20_arg0.FrameHlineLeft:setAlpha(1)
			f20_arg0.FrameHlineLeft:setShaderVector(0, 0, 0.01, 0, 0)
			f20_arg0.FrameHlineLeft:setShaderVector(1, 0, 0, 0, 0)
			f20_arg0.FrameHlineLeft:setShaderVector(2, 0, 1, 0, 0)
			f20_arg0.FrameHlineLeft:setShaderVector(3, 0, 0, 0, 0)
			f20_arg0.FrameHlineLeft:setShaderVector(4, 0, 0, 0, 0)
			f20_local1(f20_arg0.FrameHlineLeft)
			local f20_local2 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(399)
					f28_arg0:setAlpha(0)
					f28_arg0:setShaderVector(0, 0, 1, 0, 0)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.FrameHlineLeft2:beginAnimation(300)
				f20_arg0.FrameHlineLeft2:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameHlineLeft2:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f20_arg0.FrameHlineLeft2:completeAnimation()
			f20_arg0.FrameHlineLeft2:setAlpha(1)
			f20_arg0.FrameHlineLeft2:setShaderVector(0, 0, 0.01, 0, 0)
			f20_arg0.FrameHlineLeft2:setShaderVector(1, 0, 0, 0, 0)
			f20_arg0.FrameHlineLeft2:setShaderVector(2, 0, 1, 0, 0)
			f20_arg0.FrameHlineLeft2:setShaderVector(3, 0, 0, 0, 0)
			f20_arg0.FrameHlineLeft2:setShaderVector(4, 0, 0, 0, 0)
			f20_local2(f20_arg0.FrameHlineLeft2)
			local f20_local3 = function(f29_arg0)
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
														f39_arg0:beginAnimation(19)
														f39_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
													end
													f38_arg0:beginAnimation(19)
													f38_arg0:setShaderVector(0, 1, 0, 0, 0)
													f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
												end
												f37_arg0:beginAnimation(20)
												f37_arg0:setShaderVector(0, 2.5, 0, 0, 0)
												f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
											end
											f36_arg0:beginAnimation(19)
											f36_arg0:setShaderVector(0, 1, 0, 0, 0)
											f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
										end
										f35_arg0:beginAnimation(19)
										f35_arg0:setShaderVector(0, 2, 0, 0, 0)
										f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
									end
									f34_arg0:beginAnimation(20)
									f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
								end
								f33_arg0:beginAnimation(19)
								f33_arg0:setShaderVector(0, 1, 0, 0, 0)
								f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
							end
							f32_arg0:beginAnimation(19)
							f32_arg0:setShaderVector(0, 2.5, 0, 0, 0)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
						end
						f31_arg0:beginAnimation(19)
						f31_arg0:setShaderVector(0, 1, 0, 0, 0)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(20)
					f30_arg0:setShaderVector(0, 2, 0, 0, 0)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f20_arg0.FrameEngineLeft:beginAnimation(700)
				f20_arg0.FrameEngineLeft:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameEngineLeft:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f20_arg0.FrameEngineLeft:completeAnimation()
			f20_arg0.FrameEngineLeft:setAlpha(1)
			f20_arg0.FrameEngineLeft:setShaderVector(0, 1, 0, 0, 0)
			f20_local3(f20_arg0.FrameEngineLeft)
			local f20_local4 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					local f41_local0 = function(f42_arg0)
						local f42_local0 = function(f43_arg0)
							f43_arg0:beginAnimation(200)
							f43_arg0:setAlpha(0.7)
							f43_arg0:setShaderVector(0, 1.5, 0, 0, 0)
							f43_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
						end
						f42_arg0:beginAnimation(50)
						f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
					end
					f41_arg0:beginAnimation(149)
					f41_arg0:setAlpha(1)
					f41_arg0:setShaderVector(0, 2, 0, 0, 0)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
				end
				f20_arg0.FrameBoxesLeftAdd:beginAnimation(800)
				f20_arg0.FrameBoxesLeftAdd:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameBoxesLeftAdd:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f20_arg0.FrameBoxesLeftAdd:completeAnimation()
			f20_arg0.FrameBoxesLeftAdd:setAlpha(0.7)
			f20_arg0.FrameBoxesLeftAdd:setShaderVector(0, 1.5, 0, 0, 0)
			f20_local4(f20_arg0.FrameBoxesLeftAdd)
			local f20_local5 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					f45_arg0:beginAnimation(100)
					f45_arg0:setAlpha(1)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.StrokeL:beginAnimation(700)
				f20_arg0.StrokeL:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.StrokeL:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f20_arg0.StrokeL:completeAnimation()
			f20_arg0.StrokeL:setAlpha(0)
			f20_arg0.StrokeL:setShaderVector(0, 1, 0, 0, 0)
			f20_local5(f20_arg0.StrokeL)
		end,
	},
}
CoD.vhudHellstormFrameLeft.__onClose = function(f46_arg0)
	f46_arg0.LMeter:close()
	f46_arg0.MeterBracketL:close()
end
