require("x64:e59f88bc0f16b1b")
CoD.StartMenu_ConnectionMeterContainer = InheritFrom(LUI.UIElement)
CoD.StartMenu_ConnectionMeterContainer.__defaultWidth = 950
CoD.StartMenu_ConnectionMeterContainer.__defaultHeight = 170
CoD.StartMenu_ConnectionMeterContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_ConnectionMeterContainer)
	self.id = "StartMenu_ConnectionMeterContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuConnectionMeter0 = CoD.StartMenu_ConnectionMeter.new(f1_arg0, f1_arg1, 0, 0, 0, 745, 0, 0, 45, 293)
	self:addElement(StartMenuConnectionMeter0)
	self.StartMenuConnectionMeter0 = StartMenuConnectionMeter0
	local ConnectionMeterLabel = LUI.UIText.new(0, 0, 0, 445, 0, 0, -23, 15)
	ConnectionMeterLabel:setText(Engine[0xF9F1239CFD921FE](0xAC738A24A38A83))
	ConnectionMeterLabel:setTTF("default")
	ConnectionMeterLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ConnectionMeterLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ConnectionMeterLabel)
	self.ConnectionMeterLabel = ConnectionMeterLabel
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return ConnectionMeter_isEnabled(element, f1_arg1) and not IsLobbyHost()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.PlayerSettingsUpdate, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	self:appendEventHandler("on_session_start", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	self:appendEventHandler("on_session_end", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_ConnectionMeterContainer.__resetProperties = function(f6_arg0)
	f6_arg0.ConnectionMeterLabel:completeAnimation()
	f6_arg0.StartMenuConnectionMeter0:completeAnimation()
	f6_arg0.ConnectionMeterLabel:setAlpha(1)
	f6_arg0.ConnectionMeterLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	f6_arg0.StartMenuConnectionMeter0:setAlpha(1)
end
CoD.StartMenu_ConnectionMeterContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.StartMenuConnectionMeter0:completeAnimation()
			f7_arg0.StartMenuConnectionMeter0:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.StartMenuConnectionMeter0)
			f7_arg0.ConnectionMeterLabel:completeAnimation()
			f7_arg0.ConnectionMeterLabel:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ConnectionMeterLabel)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ConnectionMeterLabel:completeAnimation()
			f8_arg0.clipFinished(f8_arg0.ConnectionMeterLabel)
		end,
	},
}
CoD.StartMenu_ConnectionMeterContainer.__onClose = function(f9_arg0)
	f9_arg0.StartMenuConnectionMeter0:close()
end
