require("x64:1e31f6b0fbfa4b")
CoD.ProximityAlarm = InheritFrom(LUI.UIElement)
CoD.ProximityAlarm.__defaultWidth = 375
CoD.ProximityAlarm.__defaultHeight = 58
CoD.ProximityAlarm.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "hudItems.proximityAlarm")
	self:setClass(CoD.ProximityAlarm)
	self.id = "ProximityAlarm"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blur = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -29, 29)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -29, 29)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.3)
	self:addElement(Image)
	self.Image = Image
	local ProximityAlarm = CoD.ProximityAlarm_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -161, 161, 0.5, 0.5, -38, 38)
	ProximityAlarm:setAlpha(0.93)
	ProximityAlarm.text:setText(Engine[0xF9F1239CFD921FE](0x8B965A8BB3FC505))
	self:addElement(ProximityAlarm)
	self.ProximityAlarm = ProximityAlarm
	self:mergeStateConditions({
		{
			stateName = "AlarmDeployed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.proximityAlarm", 1) and not IsMultiplayer()
			end,
		},
		{
			stateName = "AlarmOn",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.proximityAlarm", 2) and not IsMultiplayer()
			end,
		},
		{
			stateName = "AlarmDeployedAlarmOnly",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "AlarmOnAlarmOnly",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.proximityAlarm"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.proximityAlarm",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ProximityAlarm.__resetProperties = function(f8_arg0)
	f8_arg0.ProximityAlarm:completeAnimation()
	f8_arg0.blur:completeAnimation()
	f8_arg0.Image:completeAnimation()
	f8_arg0.ProximityAlarm:setAlpha(0.93)
	f8_arg0.ProximityAlarm.text:setText(Engine[0xF9F1239CFD921FE](0x8B965A8BB3FC505))
	f8_arg0.blur:setAlpha(1)
	f8_arg0.Image:setAlpha(0.3)
end
CoD.ProximityAlarm.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.blur:completeAnimation()
			f9_arg0.blur:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.blur)
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Image)
			f9_arg0.ProximityAlarm:completeAnimation()
			f9_arg0.ProximityAlarm:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ProximityAlarm)
		end,
	},
	AlarmDeployed = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.blur:completeAnimation()
			f10_arg0.blur:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.blur)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image)
			f10_arg0.ProximityAlarm:completeAnimation()
			f10_arg0.ProximityAlarm.text:completeAnimation()
			f10_arg0.ProximityAlarm:setAlpha(0)
			f10_arg0.ProximityAlarm.text:setText(Engine[0xF9F1239CFD921FE](0x6D07C2DB72A2619))
			f10_arg0.clipFinished(f10_arg0.ProximityAlarm)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(9)
					f13_arg0:setAlpha(0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.ProximityAlarm:beginAnimation(990)
				f11_arg0.ProximityAlarm:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ProximityAlarm:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.ProximityAlarm:completeAnimation()
			f11_arg0.ProximityAlarm:setAlpha(1)
			f11_local0(f11_arg0.ProximityAlarm)
		end,
	},
	AlarmOn = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.blur:completeAnimation()
			f14_arg0.blur:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.blur)
			f14_arg0.Image:completeAnimation()
			f14_arg0.Image:setAlpha(0.3)
			f14_arg0.clipFinished(f14_arg0.Image)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(139)
						f17_arg0:setAlpha(1)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(150)
					f16_arg0:setAlpha(0)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f14_arg0.ProximityAlarm:beginAnimation(700)
				f14_arg0.ProximityAlarm:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.ProximityAlarm:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.ProximityAlarm:completeAnimation()
			f14_arg0.ProximityAlarm.text:completeAnimation()
			f14_arg0.ProximityAlarm:setAlpha(1)
			f14_arg0.ProximityAlarm.text:setText(Engine[0xF9F1239CFD921FE](0x31007C3B2B31BDB))
			f14_local0(f14_arg0.ProximityAlarm)
			f14_arg0.nextClip = "DefaultClip"
		end,
	},
	AlarmDeployedAlarmOnly = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.blur:completeAnimation()
			f18_arg0.blur:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.blur)
			f18_arg0.Image:completeAnimation()
			f18_arg0.Image:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.Image)
			f18_arg0.ProximityAlarm:completeAnimation()
			f18_arg0.ProximityAlarm.text:completeAnimation()
			f18_arg0.ProximityAlarm:setAlpha(0)
			f18_arg0.ProximityAlarm.text:setText(Engine[0xF9F1239CFD921FE](0xFCEDC5C8AC323F8))
			f18_arg0.clipFinished(f18_arg0.ProximityAlarm)
		end,
		DefaultState = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(9)
					f21_arg0:setAlpha(0)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.ProximityAlarm:beginAnimation(990)
				f19_arg0.ProximityAlarm:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ProximityAlarm:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.ProximityAlarm:completeAnimation()
			f19_arg0.ProximityAlarm:setAlpha(1)
			f19_local0(f19_arg0.ProximityAlarm)
		end,
	},
	AlarmOnAlarmOnly = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.blur:completeAnimation()
			f22_arg0.blur:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.blur)
			f22_arg0.Image:completeAnimation()
			f22_arg0.Image:setAlpha(0.3)
			f22_arg0.clipFinished(f22_arg0.Image)
			local f22_local0 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					local f24_local0 = function(f25_arg0)
						f25_arg0:beginAnimation(139)
						f25_arg0:setAlpha(1)
						f25_arg0:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
					end
					f24_arg0:beginAnimation(150)
					f24_arg0:setAlpha(0)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
				end
				f22_arg0.ProximityAlarm:beginAnimation(700)
				f22_arg0.ProximityAlarm:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ProximityAlarm:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f22_arg0.ProximityAlarm:completeAnimation()
			f22_arg0.ProximityAlarm.text:completeAnimation()
			f22_arg0.ProximityAlarm:setAlpha(1)
			f22_arg0.ProximityAlarm.text:setText(Engine[0xF9F1239CFD921FE](0x8B965A8BB3FC505))
			f22_local0(f22_arg0.ProximityAlarm)
			f22_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.ProximityAlarm.__onClose = function(f26_arg0)
	f26_arg0.ProximityAlarm:close()
end
