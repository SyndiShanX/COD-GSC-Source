CoD.WeaponBribeSelectionTimer = InheritFrom(LUI.UIElement)
CoD.WeaponBribeSelectionTimer.__defaultWidth = 1111
CoD.WeaponBribeSelectionTimer.__defaultHeight = 33
CoD.WeaponBribeSelectionTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponBribeSelectionTimer)
	self.id = "WeaponBribeSelectionTimer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TimerText = LUI.UIText.new(0.5, 0.5, -555.5, 555.5, 0.5, 0.5, -16.5, 16.5)
	TimerText:setRGB(ColorSet.StoreAvailabilityTimer.r, ColorSet.StoreAvailabilityTimer.g, ColorSet.StoreAvailabilityTimer.b)
	TimerText:setTTF("ttmussels_regular")
	TimerText:setLetterSpacing(2)
	TimerText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TimerText:subscribeToGlobalModel(f1_arg1, "BribeMenuTimer", "bribe_menu_timer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TimerText:setText(ToUpper(LocalizeIntoString(0xAC0D5F97E5CC643, f2_local0)))
		end
	end)
	self:addElement(TimerText)
	self.TimerText = TimerText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("loot_weaponBribeMultiPurchaseActive")
			end,
		},
	})
	self:subscribeToGlobalModel(f1_arg1, "BribeMenuTimer", "cycled", function(model)
		local f4_local0 = self
		if CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "BribeMenuTimer", "cycled") then
			UpdateSelfElementState(f1_arg0, f4_local0, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponBribeSelectionTimer.__resetProperties = function(f5_arg0)
	f5_arg0.TimerText:completeAnimation()
	f5_arg0.TimerText:setAlpha(1)
end
CoD.WeaponBribeSelectionTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.TimerText:completeAnimation()
			f7_arg0.TimerText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TimerText)
		end,
	},
}
CoD.WeaponBribeSelectionTimer.__onClose = function(f8_arg0)
	f8_arg0.TimerText:close()
end
