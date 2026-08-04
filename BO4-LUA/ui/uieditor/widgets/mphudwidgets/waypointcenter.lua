require("ui/uieditor/widgets/mphudwidgets/waypointicon")
CoD.WaypointCenter = InheritFrom(LUI.UIElement)
CoD.WaypointCenter.__defaultWidth = 76
CoD.WaypointCenter.__defaultHeight = 76
CoD.WaypointCenter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointCenter)
	self.id = "WaypointCenter"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local waypointCenterImage = CoD.WaypointIcon.new(f1_arg0, f1_arg1, 0.5, 0.5, -38, 38, 0.5, 0.5, -38, 38)
	waypointCenterImage:linkToElementModel(self, nil, false, function(model)
		waypointCenterImage:setModel(model, f1_arg1)
	end)
	self:addElement(waypointCenterImage)
	self.waypointCenterImage = waypointCenterImage
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
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
	local f1_local4 = Engine.GetGlobalModel()
	f1_local3(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointCenter.__resetProperties = function(f9_arg0)
	f9_arg0.waypointCenterImage:completeAnimation()
	f9_arg0.waypointCenterImage:setRGB(1, 1, 1)
	f9_arg0.waypointCenterImage:setAlpha(1)
	f9_arg0.waypointCenterImage:setScale(1, 1)
end
CoD.WaypointCenter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.waypointCenterImage:completeAnimation()
			f11_arg0.waypointCenterImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.waypointCenterImage)
		end,
	},
	PulsingCP = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(480)
					f14_arg0:setAlpha(1)
					f14_arg0:setScale(1, 1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
				end
				f12_arg0.waypointCenterImage:beginAnimation(120)
				f12_arg0.waypointCenterImage:setRGB(1, 1, 1)
				f12_arg0.waypointCenterImage:setAlpha(0.51)
				f12_arg0.waypointCenterImage:setScale(1.1, 1.1)
				f12_arg0.waypointCenterImage:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.waypointCenterImage:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f12_arg0.waypointCenterImage:completeAnimation()
			f12_arg0.waypointCenterImage:setRGB(1, 0, 0)
			f12_arg0.waypointCenterImage:setAlpha(1)
			f12_arg0.waypointCenterImage:setScale(1, 1)
			f12_local0(f12_arg0.waypointCenterImage)
			f12_arg0.nextClip = "DefaultClip"
		end,
	},
	Pulsing = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(880)
					f17_arg0:setAlpha(1)
					f17_arg0:setScale(1, 1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.waypointCenterImage:beginAnimation(120)
				f15_arg0.waypointCenterImage:setAlpha(0.51)
				f15_arg0.waypointCenterImage:setScale(1.1, 1.1)
				f15_arg0.waypointCenterImage:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.waypointCenterImage:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.waypointCenterImage:completeAnimation()
			f15_arg0.waypointCenterImage:setAlpha(1)
			f15_arg0.waypointCenterImage:setScale(1, 1)
			f15_local0(f15_arg0.waypointCenterImage)
			f15_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.WaypointCenter.__onClose = function(f18_arg0)
	f18_arg0.waypointCenterImage:close()
end
