require("x64:e7e57c3b11e68a0")
CoD.WZTeamList = InheritFrom(LUI.UIElement)
CoD.WZTeamList.__defaultWidth = 385
CoD.WZTeamList.__defaultHeight = 258
CoD.WZTeamList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamList)
	self.id = "WZTeamList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TeamPlayerList = CoD.WarzoneTeamListContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 385, 0, 0, 0, 258)
	self:addElement(TeamPlayerList)
	self.TeamPlayerList = TeamPlayerList
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.WZUtility.ShouldHideTeamWidget(f1_arg1)
			end,
		},
		{
			stateName = "HiddenPC",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsPcInventoryOpen(f1_arg1)
			end,
		},
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideTeamListUI", "warzoneHideTeamList")
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_hud_visible"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_all_game_hud_hidden"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_demo_camera_mode_moviecam"],
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f9_arg1)
	end)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = DataSources.WarzoneInventory.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.isOpen, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "isOpen",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.PlayerSettingsUpdate, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	TeamPlayerList.id = "TeamPlayerList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZTeamList.__resetProperties = function(f13_arg0)
	f13_arg0.TeamPlayerList:completeAnimation()
	f13_arg0.TeamPlayerList:setAlpha(1)
end
CoD.WZTeamList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.TeamPlayerList:completeAnimation()
			f15_arg0.TeamPlayerList:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TeamPlayerList)
		end,
	},
	HiddenPC = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.TeamPlayerList:completeAnimation()
			f16_arg0.TeamPlayerList:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.TeamPlayerList)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.TeamPlayerList:completeAnimation()
			f17_arg0.TeamPlayerList:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.TeamPlayerList)
		end,
	},
}
CoD.WZTeamList.__onClose = function(f18_arg0)
	f18_arg0.TeamPlayerList:close()
end
