require("x64:cc4bfb2bbbc1344")
require("x64:667d91f6bed178d")
CoD.vhudHellstormFrameRight = InheritFrom(LUI.UIElement)
CoD.vhudHellstormFrameRight.__defaultWidth = 391
CoD.vhudHellstormFrameRight.__defaultHeight = 484
CoD.vhudHellstormFrameRight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhudHellstormFrameRight)
	self.id = "vhudHellstormFrameRight"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DotR = LUI.UIImage.new(0.5, 0.5, 53.5, 37.5, 0.5, 0.5, -6, 6)
	DotR:setImage(RegisterImage(@"uie_ui_hud_vehicle_hellstorm_indicator"))
	DotR:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(DotR)
	self.DotR = DotR
	local FrameBoxesLeft = LUI.UIImage.new(0, 0, 390.5, 316.5, 0, 0, 224, 260)
	FrameBoxesLeft:setAlpha(0.7)
	FrameBoxesLeft:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_boxes"))
	self:addElement(FrameBoxesLeft)
	self.FrameBoxesLeft = FrameBoxesLeft
	local FrameBoxesLeftAdd = LUI.UIImage.new(0, 0, 390.5, 316.5, 0, 0, 224, 260)
	FrameBoxesLeftAdd:setAlpha(0.7)
	FrameBoxesLeftAdd:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_boxes"))
	FrameBoxesLeftAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FrameBoxesLeftAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(FrameBoxesLeftAdd)
	self.FrameBoxesLeftAdd = FrameBoxesLeftAdd
	local FrameEngineLeft = LUI.UIImage.new(0, 0, 229, 189, 0, 0, 236, 282)
	FrameEngineLeft:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_engine"))
	FrameEngineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(FrameEngineLeft)
	self.FrameEngineLeft = FrameEngineLeft
	local FrameHlineLeft = LUI.UIImage.new(0, 0, 182, 0, 0, 0, 238, 246)
	FrameHlineLeft:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_hline"))
	FrameHlineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	FrameHlineLeft:setShaderVector(0, 0, 1, 0, 0)
	FrameHlineLeft:setShaderVector(1, 0, 0, 0, 0)
	FrameHlineLeft:setShaderVector(2, 0, 1, 0, 0)
	FrameHlineLeft:setShaderVector(3, 0, 0, 0, 0)
	FrameHlineLeft:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(FrameHlineLeft)
	self.FrameHlineLeft = FrameHlineLeft
	local FrameHlineLeft2 = LUI.UIImage.new(0, 0, 182, 0, 0, 0, 238, 246)
	FrameHlineLeft2:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_hline"))
	FrameHlineLeft2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta"))
	FrameHlineLeft2:setShaderVector(0, 0, 1, 0, 0)
	FrameHlineLeft2:setShaderVector(1, 0, 0, 0, 0)
	FrameHlineLeft2:setShaderVector(2, 0, 1, 0, 0)
	FrameHlineLeft2:setShaderVector(3, 0, 0, 0, 0)
	FrameHlineLeft2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(FrameHlineLeft2)
	self.FrameHlineLeft2 = FrameHlineLeft2
	local FrameGraphicLeft = LUI.UIImage.new(0, 0, 316.5, 280.5, 0, 0, 0, 484)
	FrameGraphicLeft:setAlpha(0.8)
	FrameGraphicLeft:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_frame_graphic_left"))
	FrameGraphicLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	FrameGraphicLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(FrameGraphicLeft)
	self.FrameGraphicLeft = FrameGraphicLeft
	local MeterBracketR = CoD.vhudHellstormFrameAltitude.new(f1_arg0, f1_arg1, 0, 0, 239, 259, 0.5, 0.5, -224, 226)
	MeterBracketR:setYRot(180)
	self:addElement(MeterBracketR)
	self.MeterBracketR = MeterBracketR
	local RMeter = CoD.vhudHellstormFrameAltitudeMeter.new(f1_arg0, f1_arg1, 0, 0, 284, 248, 0.5, 0.5, -224, 226)
	RMeter:mergeStateConditions({
		{
			stateName = "Dock",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.remoteMissilePhase2", 0)
			end,
		},
	})
	local f1_local10 = RMeter
	local StrokeR = RMeter.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	StrokeR(f1_local10, f1_local12["hudItems.remoteMissilePhase2"], function(f3_arg0)
		f1_arg0:updateElementState(RMeter, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hudItems.remoteMissilePhase2",
		})
	end, false)
	RMeter:setZoom(30)
	RMeter.Image:setShaderVector(1, 0, 0.15, 0, 0)
	self:addElement(RMeter)
	self.RMeter = RMeter
	StrokeR = LUI.UIImage.new(0.5, 0.5, -194.5, -14.5, 0.5, 0.5, -5, 23)
	StrokeR:setImage(RegisterImage(@"hash_7EFA29833AEF0480"))
	StrokeR:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	StrokeR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(StrokeR)
	self.StrokeR = StrokeR
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
	f1_local12 = self
	f1_local10 = self.subscribeToModel
	local f1_local13 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local12, f1_local13["hudItems.remoteMissilePhase2"], function(f8_arg0)
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
CoD.vhudHellstormFrameRight.__resetProperties = function(f11_arg0)
	f11_arg0.StrokeR:completeAnimation()
	f11_arg0.RMeter:completeAnimation()
	f11_arg0.MeterBracketR:completeAnimation()
	f11_arg0.FrameGraphicLeft:completeAnimation()
	f11_arg0.FrameHlineLeft:completeAnimation()
	f11_arg0.FrameEngineLeft:completeAnimation()
	f11_arg0.DotR:completeAnimation()
	f11_arg0.FrameBoxesLeft:completeAnimation()
	f11_arg0.FrameBoxesLeftAdd:completeAnimation()
	f11_arg0.FrameHlineLeft2:completeAnimation()
	f11_arg0.StrokeR:setAlpha(1)
	f11_arg0.StrokeR:setShaderVector(0, 1, 0, 0, 0)
	f11_arg0.RMeter:setAlpha(1)
	f11_arg0.MeterBracketR:setLeftRight(0, 0, 239, 259)
	f11_arg0.MeterBracketR:setAlpha(1)
	f11_arg0.FrameGraphicLeft:setAlpha(0.8)
	f11_arg0.FrameGraphicLeft:setShaderVector(0, 1, 0, 0, 0)
	f11_arg0.FrameHlineLeft:setAlpha(1)
	f11_arg0.FrameHlineLeft:setShaderVector(0, 0, 1, 0, 0)
	f11_arg0.FrameHlineLeft:setShaderVector(1, 0, 0, 0, 0)
	f11_arg0.FrameHlineLeft:setShaderVector(2, 0, 1, 0, 0)
	f11_arg0.FrameHlineLeft:setShaderVector(3, 0, 0, 0, 0)
	f11_arg0.FrameHlineLeft:setShaderVector(4, 0, 0, 0, 0)
	f11_arg0.FrameEngineLeft:setAlpha(1)
	f11_arg0.FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
	f11_arg0.DotR:setAlpha(1)
	f11_arg0.FrameBoxesLeft:setAlpha(0.7)
	f11_arg0.FrameBoxesLeftAdd:setAlpha(0.7)
	f11_arg0.FrameBoxesLeftAdd:setShaderVector(0, 1.5, 0, 0, 0)
	f11_arg0.FrameHlineLeft2:setAlpha(1)
	f11_arg0.FrameHlineLeft2:setShaderVector(0, 0, 1, 0, 0)
	f11_arg0.FrameHlineLeft2:setShaderVector(1, 0, 0, 0, 0)
	f11_arg0.FrameHlineLeft2:setShaderVector(2, 0, 1, 0, 0)
	f11_arg0.FrameHlineLeft2:setShaderVector(3, 0, 0, 0, 0)
	f11_arg0.FrameHlineLeft2:setShaderVector(4, 0, 0, 0, 0)
end
CoD.vhudHellstormFrameRight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Docked = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(9)
			f13_arg0.DotR:completeAnimation()
			f13_arg0.DotR:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DotR)
			f13_arg0.FrameBoxesLeft:completeAnimation()
			f13_arg0.FrameBoxesLeft:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameBoxesLeft)
			f13_arg0.FrameBoxesLeftAdd:completeAnimation()
			f13_arg0.FrameBoxesLeftAdd:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameBoxesLeftAdd)
			f13_arg0.FrameEngineLeft:completeAnimation()
			f13_arg0.FrameEngineLeft:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameEngineLeft)
			f13_arg0.FrameHlineLeft:completeAnimation()
			f13_arg0.FrameHlineLeft:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameHlineLeft)
			f13_arg0.FrameGraphicLeft:completeAnimation()
			f13_arg0.FrameGraphicLeft:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FrameGraphicLeft)
			f13_arg0.MeterBracketR:completeAnimation()
			f13_arg0.MeterBracketR:setLeftRight(0, 0, 249, 269)
			f13_arg0.MeterBracketR:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.MeterBracketR)
			f13_arg0.RMeter:completeAnimation()
			f13_arg0.RMeter:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RMeter)
			f13_arg0.StrokeR:completeAnimation()
			f13_arg0.StrokeR:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.StrokeR)
		end,
	},
	LowAltitude = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.FrameBoxesLeftAdd:completeAnimation()
			f14_arg0.FrameBoxesLeftAdd:setAlpha(0.7)
			f14_arg0.clipFinished(f14_arg0.FrameBoxesLeftAdd)
			f14_arg0.FrameEngineLeft:completeAnimation()
			f14_arg0.FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
			f14_arg0.clipFinished(f14_arg0.FrameEngineLeft)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(200)
					f16_arg0:setShaderVector(0, 2, 0, 0, 0)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.StrokeR:beginAnimation(1000)
				f14_arg0.StrokeR:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.StrokeR:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.StrokeR:completeAnimation()
			f14_arg0.StrokeR:setAlpha(1)
			f14_arg0.StrokeR:setShaderVector(0, 1.5, 0, 0, 0)
			f14_local0(f14_arg0.StrokeR)
		end,
	},
	MediumAltitude = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.FrameBoxesLeftAdd:completeAnimation()
			f17_arg0.FrameBoxesLeftAdd:setAlpha(0.7)
			f17_arg0.clipFinished(f17_arg0.FrameBoxesLeftAdd)
			f17_arg0.FrameEngineLeft:completeAnimation()
			f17_arg0.FrameEngineLeft:setShaderVector(0, 2, 0, 0, 0)
			f17_arg0.clipFinished(f17_arg0.FrameEngineLeft)
			local f17_local0 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(200)
					f19_arg0:setShaderVector(0, 1.5, 0, 0, 0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
				end
				f17_arg0.StrokeR:beginAnimation(1000)
				f17_arg0.StrokeR:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.StrokeR:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f17_arg0.StrokeR:completeAnimation()
			f17_arg0.StrokeR:setAlpha(1)
			f17_arg0.StrokeR:setShaderVector(0, 1, 0, 0, 0)
			f17_local0(f17_arg0.StrokeR)
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
							local f24_local0 = function(f25_arg0)
								f25_arg0:beginAnimation(200)
								f25_arg0:setAlpha(0.7)
								f25_arg0:setShaderVector(0, 1.5, 0, 0, 0)
								f25_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
							end
							f24_arg0:beginAnimation(50)
							f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
						end
						f23_arg0:beginAnimation(149)
						f23_arg0:setAlpha(1)
						f23_arg0:setShaderVector(0, 2, 0, 0, 0)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
					end
					f22_arg0:beginAnimation(500)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f20_arg0.FrameBoxesLeftAdd:beginAnimation(300)
				f20_arg0.FrameBoxesLeftAdd:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameBoxesLeftAdd:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f20_arg0.FrameBoxesLeftAdd:completeAnimation()
			f20_arg0.FrameBoxesLeftAdd:setAlpha(0.7)
			f20_arg0.FrameBoxesLeftAdd:setShaderVector(0, 1.5, 0, 0, 0)
			f20_local0(f20_arg0.FrameBoxesLeftAdd)
			local f20_local1 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						local f28_local0 = function(f29_arg0)
							local f29_local0 = function(f30_arg0)
								local f30_local0 = function(f31_arg0)
									local f31_local0 = function(f32_arg0)
										local f32_local0 = function(f33_arg0)
											local f33_local0 = function(f34_arg0)
												local f34_local0 = function(f35_arg0)
													local f35_local0 = function(f36_arg0)
														local f36_local0 = function(f37_arg0)
															local f37_local0 = function(f38_arg0)
																f38_arg0:beginAnimation(19)
																f38_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
															end
															f37_arg0:beginAnimation(19)
															f37_arg0:setShaderVector(0, 1, 0, 0, 0)
															f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
														end
														f36_arg0:beginAnimation(20)
														f36_arg0:setShaderVector(0, 2.5, 0, 0, 0)
														f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
													end
													f35_arg0:beginAnimation(19)
													f35_arg0:setShaderVector(0, 1, 0, 0, 0)
													f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
												end
												f34_arg0:beginAnimation(0)
												f34_arg0:setShaderVector(0, 2, 0, 0, 0)
												f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
											end
											f33_arg0:beginAnimation(19)
											f33_arg0:setShaderVector(0, 2, 0, 0, 0)
											f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
										end
										f32_arg0:beginAnimation(20)
										f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
									end
									f31_arg0:beginAnimation(19)
									f31_arg0:setShaderVector(0, 1, 0, 0, 0)
									f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
								end
								f30_arg0:beginAnimation(19)
								f30_arg0:setShaderVector(0, 2.5, 0, 0, 0)
								f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
							end
							f29_arg0:beginAnimation(19)
							f29_arg0:setShaderVector(0, 1, 0, 0, 0)
							f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
						end
						f28_arg0:beginAnimation(20)
						f28_arg0:setShaderVector(0, 2, 0, 0, 0)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
					end
					f27_arg0:beginAnimation(399)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f20_arg0.FrameEngineLeft:beginAnimation(300)
				f20_arg0.FrameEngineLeft:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameEngineLeft:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f20_arg0.FrameEngineLeft:completeAnimation()
			f20_arg0.FrameEngineLeft:setShaderVector(0, 1, 0, 0, 0)
			f20_local1(f20_arg0.FrameEngineLeft)
			local f20_local2 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(399)
					f40_arg0:setShaderVector(0, 0, 1, 0, 0)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.FrameHlineLeft:beginAnimation(300)
				f20_arg0.FrameHlineLeft:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameHlineLeft:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f20_arg0.FrameHlineLeft:completeAnimation()
			f20_arg0.FrameHlineLeft:setShaderVector(0, 0, 0.01, 0, 0)
			f20_arg0.FrameHlineLeft:setShaderVector(1, 0, 0, 0, 0)
			f20_arg0.FrameHlineLeft:setShaderVector(2, 0, 1, 0, 0)
			f20_arg0.FrameHlineLeft:setShaderVector(3, 0, 0, 0, 0)
			f20_arg0.FrameHlineLeft:setShaderVector(4, 0, 0, 0, 0)
			f20_local2(f20_arg0.FrameHlineLeft)
			local f20_local3 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(399)
					f42_arg0:setShaderVector(0, 0, 1, 0, 0)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
				end
				f20_arg0.FrameHlineLeft2:beginAnimation(300)
				f20_arg0.FrameHlineLeft2:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameHlineLeft2:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f20_arg0.FrameHlineLeft2:completeAnimation()
			f20_arg0.FrameHlineLeft2:setAlpha(1)
			f20_arg0.FrameHlineLeft2:setShaderVector(0, 0, 0.01, 0, 0)
			f20_arg0.FrameHlineLeft2:setShaderVector(1, 0, 0, 0, 0)
			f20_arg0.FrameHlineLeft2:setShaderVector(2, 0, 1, 0, 0)
			f20_arg0.FrameHlineLeft2:setShaderVector(3, 0, 0, 0, 0)
			f20_arg0.FrameHlineLeft2:setShaderVector(4, 0, 0, 0, 0)
			f20_local3(f20_arg0.FrameHlineLeft2)
			local f20_local4 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					local f44_local0 = function(f45_arg0)
						local f45_local0 = function(f46_arg0)
							local f46_local0 = function(f47_arg0)
								f47_arg0:beginAnimation(200)
								f47_arg0:setAlpha(0)
								f47_arg0:setShaderVector(0, 1, 0, 0, 0)
								f47_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
							end
							f46_arg0:beginAnimation(50)
							f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
						end
						f45_arg0:beginAnimation(149)
						f45_arg0:setAlpha(1)
						f45_arg0:setShaderVector(0, 2, 0, 0, 0)
						f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
					end
					f44_arg0:beginAnimation(500)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
				end
				f20_arg0.FrameGraphicLeft:beginAnimation(300)
				f20_arg0.FrameGraphicLeft:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.FrameGraphicLeft:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f20_arg0.FrameGraphicLeft:completeAnimation()
			f20_arg0.FrameGraphicLeft:setAlpha(0.8)
			f20_arg0.FrameGraphicLeft:setShaderVector(0, 1, 0, 0, 0)
			f20_local4(f20_arg0.FrameGraphicLeft)
			local f20_local5 = function(f48_arg0)
				local f48_local0 = function(f49_arg0)
					local f49_local0 = function(f50_arg0)
						f50_arg0:beginAnimation(100)
						f50_arg0:setAlpha(1)
						f50_arg0:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
					end
					f49_arg0:beginAnimation(399)
					f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
				end
				f20_arg0.StrokeR:beginAnimation(300)
				f20_arg0.StrokeR:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.StrokeR:registerEventHandler("transition_complete_keyframe", f48_local0)
			end
			f20_arg0.StrokeR:completeAnimation()
			f20_arg0.StrokeR:setAlpha(0)
			f20_arg0.StrokeR:setShaderVector(0, 1, 0, 0, 0)
			f20_local5(f20_arg0.StrokeR)
		end,
	},
}
CoD.vhudHellstormFrameRight.__onClose = function(f51_arg0)
	f51_arg0.MeterBracketR:close()
	f51_arg0.RMeter:close()
end
