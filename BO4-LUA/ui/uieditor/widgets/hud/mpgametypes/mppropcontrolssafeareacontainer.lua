require("x64:b333544afc2504a")
CoD.MPPropControlsSafeAreaContainer = InheritFrom(LUI.UIElement)
CoD.MPPropControlsSafeAreaContainer.__defaultWidth = 1920
CoD.MPPropControlsSafeAreaContainer.__defaultHeight = 1080
CoD.MPPropControlsSafeAreaContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(true)
	self:setClass(CoD.MPPropControlsSafeAreaContainer)
	self.id = "MPPropControlsSafeAreaContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MPPropControlsInternal = CoD.MPPropControlsInternal.new(f1_arg0, f1_arg1, 1, 1, -107, 23, 1, 1, -492, 37)
	MPPropControlsInternal:setScale(0.75, 0.75)
	self:addElement(MPPropControlsInternal)
	self.MPPropControlsInternal = MPPropControlsInternal
	self:mergeStateConditions({
		{
			stateName = "hidden",
			condition = function(menu, element, event)
				local f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
				if not f2_local0 then
					f2_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_play_of_the_match"])
				end
				return f2_local0
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_play_of_the_match"],
		})
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f5_local0 = nil
		if self.menuLoaded then
			f5_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f5_local0 = self.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToHudArea(self, f1_arg1)
		end
		if not f5_local0 then
			f5_local0 = self:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	if not IsPC() then
		SizeToSafeArea(f1_local3, f1_arg1)
	end
	return self
end
CoD.MPPropControlsSafeAreaContainer.__resetProperties = function(f6_arg0)
	f6_arg0.MPPropControlsInternal:completeAnimation()
	f6_arg0.MPPropControlsInternal:setAlpha(1)
end
CoD.MPPropControlsSafeAreaContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.MPPropControlsInternal:completeAnimation()
			f8_arg0.MPPropControlsInternal:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.MPPropControlsInternal)
		end,
	},
}
CoD.MPPropControlsSafeAreaContainer.__onClose = function(f9_arg0)
	f9_arg0.MPPropControlsInternal:close()
end
