CoD.WaypointCenterCP = InheritFrom(LUI.UIElement)
CoD.WaypointCenterCP.__defaultWidth = 96
CoD.WaypointCenterCP.__defaultHeight = 96
CoD.WaypointCenterCP.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointCenterCP)
	self.id = "WaypointCenterCP"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local waypointCenterImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	waypointCenterImage:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			waypointCenterImage:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f2_local0))
		end
	end)
	waypointCenterImage:linkToElementModel(self, "icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			waypointCenterImage:setImage(RegisterImage(BlackTransparentIfNilOrEmpty(f3_local0)))
		end
	end)
	self:addElement(waypointCenterImage)
	self.waypointCenterImage = waypointCenterImage
	local GlowOrangeOver = LUI.UIImage.new(-0.23, 1.23, 0, 0, -0.23, 1.23, 0, 0)
	GlowOrangeOver:setRGB(0.76, 0.97, 1)
	GlowOrangeOver:setAlpha(0)
	GlowOrangeOver:setZRot(-84)
	GlowOrangeOver:setImage(RegisterImage("uie_t7_core_hud_mapwidget_panelglow"))
	GlowOrangeOver:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(GlowOrangeOver)
	self.GlowOrangeOver = GlowOrangeOver
	self:mergeStateConditions({
		{
			stateName = "Pulsing",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowWaypointAsPulsing(f1_arg1, self)
			end,
		},
		{
			stateName = "LowAmmoPulse",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "CurrentWeapon", "totalAmmoLow") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasLowAmmoState")
			end,
		},
	})
	self:linkToElementModel(self, "progress", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "progress",
		})
	end)
	self:linkToElementModel(self, "clientUseMask", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientUseMask",
		})
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.totalAmmoLow, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "totalAmmoLow",
		})
	end, false)
	self:linkToElementModel(self, "hasLowAmmoState", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasLowAmmoState",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointCenterCP.__resetProperties = function(f10_arg0)
	f10_arg0.waypointCenterImage:completeAnimation()
	f10_arg0.GlowOrangeOver:completeAnimation()
	f10_arg0.waypointCenterImage:setLeftRight(0, 1, 0, 0)
	f10_arg0.waypointCenterImage:setTopBottom(0, 1, 0, 0)
	f10_arg0.waypointCenterImage:setAlpha(1)
	f10_arg0.GlowOrangeOver:setRGB(0.76, 0.97, 1)
	f10_arg0.GlowOrangeOver:setAlpha(0)
	f10_arg0.GlowOrangeOver:setScale(1, 1)
end
CoD.WaypointCenterCP.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Pulsing = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(880)
					f14_arg0:setLeftRight(0, 1, 0, 0)
					f14_arg0:setTopBottom(0, 1, 0, 0)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.waypointCenterImage:beginAnimation(120)
				f12_arg0.waypointCenterImage:setLeftRight(0, 1, 16, -16)
				f12_arg0.waypointCenterImage:setTopBottom(0, 1, 16, -16)
				f12_arg0.waypointCenterImage:setAlpha(0.51)
				f12_arg0.waypointCenterImage:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.waypointCenterImage:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.waypointCenterImage:completeAnimation()
			f12_arg0.waypointCenterImage:setLeftRight(0, 1, 0, 0)
			f12_arg0.waypointCenterImage:setTopBottom(0, 1, 0, 0)
			f12_arg0.waypointCenterImage:setAlpha(1)
			f12_local0(f12_arg0.waypointCenterImage)
			local f12_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						f17_arg0:beginAnimation(470)
						f17_arg0:setAlpha(0)
						f17_arg0:setScale(1.9, 1.9)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
					end
					f16_arg0:beginAnimation(409)
					f16_arg0:setAlpha(0.4)
					f16_arg0:setScale(1.42, 1.42)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f12_arg0.GlowOrangeOver:beginAnimation(120)
				f12_arg0.GlowOrangeOver:setAlpha(0.5)
				f12_arg0.GlowOrangeOver:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.GlowOrangeOver:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f12_arg0.GlowOrangeOver:completeAnimation()
			f12_arg0.GlowOrangeOver:setAlpha(0)
			f12_arg0.GlowOrangeOver:setScale(1, 1)
			f12_local1(f12_arg0.GlowOrangeOver)
			f12_arg0.nextClip = "DefaultClip"
		end,
	},
	LowAmmoPulse = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			local f18_local0 = function(f19_arg0)
				local f19_local0 = function(f20_arg0)
					f20_arg0:beginAnimation(880)
					f20_arg0:setLeftRight(0, 1, 0, 0)
					f20_arg0:setTopBottom(0, 1, 0, 0)
					f20_arg0:setAlpha(1)
					f20_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
				end
				f18_arg0.waypointCenterImage:beginAnimation(120)
				f18_arg0.waypointCenterImage:setLeftRight(0, 1, 16, -16)
				f18_arg0.waypointCenterImage:setTopBottom(0, 1, 16, -16)
				f18_arg0.waypointCenterImage:setAlpha(0.51)
				f18_arg0.waypointCenterImage:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.waypointCenterImage:registerEventHandler("transition_complete_keyframe", f19_local0)
			end
			f18_arg0.waypointCenterImage:completeAnimation()
			f18_arg0.waypointCenterImage:setLeftRight(0, 1, 0, 0)
			f18_arg0.waypointCenterImage:setTopBottom(0, 1, 0, 0)
			f18_arg0.waypointCenterImage:setAlpha(1)
			f18_local0(f18_arg0.waypointCenterImage)
			local f18_local1 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						f23_arg0:beginAnimation(470)
						f23_arg0:setAlpha(0)
						f23_arg0:setScale(1, 1)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
					end
					f22_arg0:beginAnimation(409)
					f22_arg0:setAlpha(0.4)
					f22_arg0:setScale(1.9, 1.9)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f18_arg0.GlowOrangeOver:beginAnimation(120)
				f18_arg0.GlowOrangeOver:setAlpha(0.5)
				f18_arg0.GlowOrangeOver:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.GlowOrangeOver:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f18_arg0.GlowOrangeOver:completeAnimation()
			f18_arg0.GlowOrangeOver:setRGB(1, 0.05, 0.08)
			f18_arg0.GlowOrangeOver:setAlpha(0)
			f18_arg0.GlowOrangeOver:setScale(1, 1)
			f18_local1(f18_arg0.GlowOrangeOver)
		end,
	},
}
CoD.WaypointCenterCP.__onClose = function(f24_arg0)
	f24_arg0.waypointCenterImage:close()
end
