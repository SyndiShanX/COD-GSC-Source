require("x64:3fe9229739d3d5")
require("x64:e5ec0232d310fb6")
local PostLoadFunc = function(f1_arg0)
	f1_arg0.EmpRebootIndicatorWidget.ProgressBar:subscribeToElementModel(f1_arg0, "startTime", function(f2_arg0)
		local f2_local0 = Engine[@"getmodel"](f1_arg0:getModel(), "endTime")
		local f2_local1 = Engine[@"getmodelvalue"](f2_arg0)
		local f2_local2 = Engine[@"getmodelvalue"](f2_local0) - f2_local1
		f1_arg0.EmpRebootIndicatorWidget.ProgressBar:setShaderVector(0, (Engine[@"currentgametime"]() - Engine[@"snapshotdeltatime"]() - f2_local1) / f2_local2, 0, 0, 0)
		f1_arg0.EmpRebootIndicatorWidget.ProgressBar:beginAnimation("updateProgress", f2_local2)
		f1_arg0.EmpRebootIndicatorWidget.ProgressBar:setShaderVector(0, 1, 0, 0, 0)
	end)
end
CoD.EmpRebootIndicator = InheritFrom(CoD.Menu)
LUI.createMenu.EmpRebootIndicator = function(f3_arg0, f3_arg1)
	local self = CoD.Menu.NewForUIEditor("EmpRebootIndicator", f3_arg0)
	local f3_local1 = self
	self:setClass(CoD.EmpRebootIndicator)
	self.soundSet = "HUD"
	self:setOwner(f3_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f3_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f3_local1:addElementToPendingUpdateStateList(self)
	local EmpRebootIndicatorWidget = CoD.EmpRebootIndicatorWidget.new(f3_local1, f3_arg0, 0, 0, 877, 1042, 0, 0, 892, 934)
	self:addElement(EmpRebootIndicatorWidget)
	self.EmpRebootIndicatorWidget = EmpRebootIndicatorWidget
	local EmpRebootElectromagneticWidget0 = CoD.EmpRebootElectromagneticWidget.new(f3_local1, f3_arg0, 0, 0, 396, 1523, 0, 0, 818, 892)
	self:addElement(EmpRebootElectromagneticWidget0)
	self.EmpRebootElectromagneticWidget0 = EmpRebootElectromagneticWidget0
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				local f4_local0 = Engine[@"isvisibilitybitset"](f3_arg0, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
				if not f4_local0 then
					f4_local0 = Engine[@"isvisibilitybitset"](f3_arg0, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
					if not f4_local0 then
						f4_local0 = Engine[@"isvisibilitybitset"](f3_arg0, Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"])
						if not f4_local0 then
							f4_local0 = Engine[@"isvisibilitybitset"](f3_arg0, Enum[@"uivisibilitybit"][@"bit_migrating_host"])
						end
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "InvisibleForKillcamEntity",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f3_arg0, "hudItems.killCamHideEmpReboot")
			end,
		},
	})
	local f3_local4 = self
	local f3_local5 = self.subscribeToModel
	local f3_local6 = Engine[@"getmodelforcontroller"](f3_arg0)
	f3_local5(f3_local4, f3_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f6_arg0)
		f3_local1:updateElementState(self, {
			name = "model_validation",
			menu = f3_local1,
			controller = f3_arg0,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f3_local4 = self
	f3_local5 = self.subscribeToModel
	f3_local6 = Engine[@"getmodelforcontroller"](f3_arg0)
	f3_local5(f3_local4, f3_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f7_arg0)
		f3_local1:updateElementState(self, {
			name = "model_validation",
			menu = f3_local1,
			controller = f3_arg0,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f3_local4 = self
	f3_local5 = self.subscribeToModel
	f3_local6 = Engine[@"getmodelforcontroller"](f3_arg0)
	f3_local5(f3_local4, f3_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"]], function(f8_arg0)
		f3_local1:updateElementState(self, {
			name = "model_validation",
			menu = f3_local1,
			controller = f3_arg0,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_locational_killstreak"],
		})
	end, false)
	f3_local4 = self
	f3_local5 = self.subscribeToModel
	f3_local6 = Engine[@"getmodelforcontroller"](f3_arg0)
	f3_local5(f3_local4, f3_local6["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_migrating_host"]], function(f9_arg0)
		f3_local1:updateElementState(self, {
			name = "model_validation",
			menu = f3_local1,
			controller = f3_arg0,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_migrating_host"],
		})
	end, false)
	f3_local4 = self
	f3_local5 = self.subscribeToModel
	f3_local6 = Engine[@"getmodelforcontroller"](f3_arg0)
	f3_local5(f3_local4, f3_local6["hudItems.killCamHideEmpReboot"], function(f10_arg0)
		f3_local1:updateElementState(self, {
			name = "model_validation",
			menu = f3_local1,
			controller = f3_arg0,
			modelValue = f10_arg0:get(),
			modelName = "hudItems.killCamHideEmpReboot",
		})
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f11_local0 = nil
		if self.menuLoaded then
			f11_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f11_local0 = self.super:menuLoaded(event)
		end
		PlayClip(self, "Boot", f3_arg0)
		if not f11_local0 then
			f11_local0 = self:dispatchEventToChildren(event)
		end
		return f11_local0
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f3_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg0)
	end
	return self
end
CoD.EmpRebootIndicator.__resetProperties = function(f12_arg0)
	f12_arg0.EmpRebootElectromagneticWidget0:completeAnimation()
	f12_arg0.EmpRebootIndicatorWidget:completeAnimation()
	f12_arg0.EmpRebootElectromagneticWidget0:setAlpha(1)
	f12_arg0.EmpRebootIndicatorWidget:setAlpha(1)
end
CoD.EmpRebootIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.EmpRebootIndicatorWidget:completeAnimation()
			f13_arg0.EmpRebootIndicatorWidget:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.EmpRebootIndicatorWidget)
			f13_arg0.EmpRebootElectromagneticWidget0:completeAnimation()
			f13_arg0.EmpRebootElectromagneticWidget0:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.EmpRebootElectromagneticWidget0)
		end,
		Boot = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			local f14_local0 = function(f15_arg0)
				f14_arg0.EmpRebootIndicatorWidget:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f14_arg0.EmpRebootIndicatorWidget:setAlpha(1)
				f14_arg0.EmpRebootIndicatorWidget:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.EmpRebootIndicatorWidget:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.EmpRebootIndicatorWidget:completeAnimation()
			f14_arg0.EmpRebootIndicatorWidget:setAlpha(0)
			f14_local0(f14_arg0.EmpRebootIndicatorWidget)
			local f14_local1 = function(f16_arg0)
				f14_arg0.EmpRebootElectromagneticWidget0:beginAnimation(400, Enum[@"luitween"][@"luitween_bounce"] | Enum[@"luitween"][@"luitween_ease_in"])
				f14_arg0.EmpRebootElectromagneticWidget0:setAlpha(1)
				f14_arg0.EmpRebootElectromagneticWidget0:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.EmpRebootElectromagneticWidget0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.EmpRebootElectromagneticWidget0:completeAnimation()
			f14_arg0.EmpRebootElectromagneticWidget0:setAlpha(0)
			f14_local1(f14_arg0.EmpRebootElectromagneticWidget0)
		end,
	},
	Invisible = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.EmpRebootIndicatorWidget:completeAnimation()
			f17_arg0.EmpRebootIndicatorWidget:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.EmpRebootIndicatorWidget)
		end,
	},
	InvisibleForKillcamEntity = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.EmpRebootIndicatorWidget:completeAnimation()
			f18_arg0.EmpRebootIndicatorWidget:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.EmpRebootIndicatorWidget)
			f18_arg0.EmpRebootElectromagneticWidget0:completeAnimation()
			f18_arg0.EmpRebootElectromagneticWidget0:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.EmpRebootElectromagneticWidget0)
		end,
	},
}
CoD.EmpRebootIndicator.__onClose = function(f19_arg0)
	f19_arg0.EmpRebootIndicatorWidget:close()
	f19_arg0.EmpRebootElectromagneticWidget0:close()
end
