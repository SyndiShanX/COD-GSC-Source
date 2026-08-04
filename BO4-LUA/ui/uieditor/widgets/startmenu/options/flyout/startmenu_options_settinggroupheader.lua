CoD.StartMenu_Options_SettingGroupHeader = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SettingGroupHeader.__defaultWidth = 700
CoD.StartMenu_Options_SettingGroupHeader.__defaultHeight = 40
CoD.StartMenu_Options_SettingGroupHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SettingGroupHeader)
	self.id = "StartMenu_Options_SettingGroupHeader"
	self.soundSet = "default"
	local Title = LUI.UIText.new(0.5, 0.5, -340, 340, 1, 1, -18, 0)
	Title:setRGB(0.6, 0.6, 0.6)
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	Title:setAlignment(Enum.LUIAlignment[@"lui_alignment_bottom"])
	Title:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText(ToUpper(f2_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SettingGroupHeader.__onClose = function(f3_arg0)
	f3_arg0.Title:close()
end
