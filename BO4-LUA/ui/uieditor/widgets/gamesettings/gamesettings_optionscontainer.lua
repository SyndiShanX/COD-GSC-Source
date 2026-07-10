require("x64:36926bbd5c82ee8")
CoD.GameSettings_OptionsContainer = InheritFrom(LUI.UIElement)
CoD.GameSettings_OptionsContainer.__defaultWidth = 510
CoD.GameSettings_OptionsContainer.__defaultHeight = 1080
CoD.GameSettings_OptionsContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_OptionsContainer)
	self.id = "GameSettings_OptionsContainer"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local GameSettingsOptions0 = CoD.GameSettings_Options.new(f1_arg0, f1_arg1, 1, 1, -510, -9, 0, 1, 0, 0)
	self:addElement(GameSettingsOptions0)
	self.GameSettingsOptions0 = GameSettingsOptions0
	local Border00 = LUI.UIImage.new(1, 1, -534, -532, 0, 0, 0, 1080)
	Border00:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Border00:setAlpha(0.42)
	self:addElement(Border00)
	self.Border00 = Border00
	GameSettingsOptions0.id = "GameSettingsOptions0"
	self.__defaultFocus = GameSettingsOptions0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameSettings_OptionsContainer.__onClose = function(f2_arg0)
	f2_arg0.GameSettingsOptions0:close()
end
