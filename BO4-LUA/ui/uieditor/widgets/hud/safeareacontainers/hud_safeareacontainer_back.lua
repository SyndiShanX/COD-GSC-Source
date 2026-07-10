require("x64:475e9b10b9c6af3")
require("x64:89dde8f0e81d59d")
require("x64:8c3717b96f3fbd8")
CoD.Hud_SafeAreaContainer_Back = InheritFrom(LUI.UIElement)
CoD.Hud_SafeAreaContainer_Back.__defaultWidth = 1920
CoD.Hud_SafeAreaContainer_Back.__defaultHeight = 1080
CoD.Hud_SafeAreaContainer_Back.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_SafeAreaContainer_Back)
	self.id = "Hud_SafeAreaContainer_Back"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Notifications = CoD.Notification.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Notifications)
	self.Notifications = Notifications
	local ObjectiveInfoWidgetContainer = CoD.ObjectiveInfoWidgetContainer.new(f1_arg0, f1_arg1, 0, 0, 51, 481, 0, 0, 420, 1500)
	self:addElement(ObjectiveInfoWidgetContainer)
	self.ObjectiveInfoWidgetContainer = ObjectiveInfoWidgetContainer
	local CursorHint = CoD.CursorHint.new(f1_arg0, f1_arg1, 0.5, 0.5, -375, 375, 1, 1, -326, -185)
	self:addElement(CursorHint)
	self.CursorHint = CursorHint
	self:mergeStateConditions({
		{
			stateName = "HideNotificationsSpawnSelect",
			condition = function(menu, element, event)
				return CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
			end,
		},
		{
			stateName = "HideNotifications",
			condition = function(menu, element, event)
				local f3_local0
				if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) then
					f3_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
					if f3_local0 then
					else
						return f3_local0
					end
				end
				f3_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
			end,
		},
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.showSpawnSelect"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_SafeAreaContainer_Back.__resetProperties = function(f12_arg0)
	f12_arg0.Notifications:completeAnimation()
	f12_arg0.Notifications:setTopBottom(0, 1, 0, 0)
	f12_arg0.Notifications:setAlpha(1)
end
CoD.Hud_SafeAreaContainer_Back.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	HideNotificationsSpawnSelect = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Notifications:completeAnimation()
			f14_arg0.Notifications:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Notifications)
		end,
	},
	HideNotifications = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.Notifications:completeAnimation()
			f15_arg0.Notifications:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Notifications)
		end,
	},
	Warzone = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.Notifications:completeAnimation()
			f16_arg0.Notifications:setTopBottom(0.09, 1, 0, 0)
			f16_arg0.clipFinished(f16_arg0.Notifications)
		end,
	},
}
CoD.Hud_SafeAreaContainer_Back.__onClose = function(f17_arg0)
	f17_arg0.Notifications:close()
	f17_arg0.ObjectiveInfoWidgetContainer:close()
	f17_arg0.CursorHint:close()
end
