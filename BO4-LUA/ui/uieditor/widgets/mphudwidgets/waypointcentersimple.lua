require("x64:1de8827d6e28e46")
CoD.WaypointCenterSimple = InheritFrom(LUI.UIElement)
CoD.WaypointCenterSimple.__defaultWidth = 76
CoD.WaypointCenterSimple.__defaultHeight = 76
CoD.WaypointCenterSimple.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointCenterSimple)
	self.id = "WaypointCenterSimple"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local waypointCenterImage = CoD.WaypointIconSimple.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	waypointCenterImage:linkToElementModel(self, nil, false, function(model)
		waypointCenterImage:setModel(model, f1_arg1)
	end)
	self:addElement(waypointCenterImage)
	self.waypointCenterImage = waypointCenterImage
	self:mergeStateConditions({
		{
			stateName = "PulsingCP",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowWaypointAsPulsing(f1_arg1, self) and IsCampaign()
			end,
		},
		{
			stateName = "Pulsing",
			condition = function(menu, element, event)
				return CoD.WaypointUtility.ShouldShowWaypointAsPulsing(f1_arg1, self)
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
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x8DF2E5447F384B9]()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f7_arg0)
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
CoD.WaypointCenterSimple.__resetProperties = function(f8_arg0)
	f8_arg0.waypointCenterImage:completeAnimation()
	f8_arg0.waypointCenterImage:setRGB(1, 1, 1)
	f8_arg0.waypointCenterImage:setAlpha(1)
	f8_arg0.waypointCenterImage:setScale(1, 1)
end
CoD.WaypointCenterSimple.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	PulsingCP = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(480)
					f12_arg0:setAlpha(1)
					f12_arg0:setScale(1, 1)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.waypointCenterImage:beginAnimation(120)
				f10_arg0.waypointCenterImage:setRGB(1, 1, 1)
				f10_arg0.waypointCenterImage:setAlpha(0.51)
				f10_arg0.waypointCenterImage:setScale(1.1, 1.1)
				f10_arg0.waypointCenterImage:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.waypointCenterImage:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.waypointCenterImage:completeAnimation()
			f10_arg0.waypointCenterImage:setRGB(1, 0, 0)
			f10_arg0.waypointCenterImage:setAlpha(1)
			f10_arg0.waypointCenterImage:setScale(1, 1)
			f10_local0(f10_arg0.waypointCenterImage)
			f10_arg0.nextClip = "DefaultClip"
		end,
	},
	Pulsing = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(880)
					f15_arg0:setAlpha(1)
					f15_arg0:setScale(1, 1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.waypointCenterImage:beginAnimation(120)
				f13_arg0.waypointCenterImage:setAlpha(0.51)
				f13_arg0.waypointCenterImage:setScale(1.1, 1.1)
				f13_arg0.waypointCenterImage:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.waypointCenterImage:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.waypointCenterImage:completeAnimation()
			f13_arg0.waypointCenterImage:setAlpha(1)
			f13_arg0.waypointCenterImage:setScale(1, 1)
			f13_local0(f13_arg0.waypointCenterImage)
			f13_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.WaypointCenterSimple.__onClose = function(f16_arg0)
	f16_arg0.waypointCenterImage:close()
end
