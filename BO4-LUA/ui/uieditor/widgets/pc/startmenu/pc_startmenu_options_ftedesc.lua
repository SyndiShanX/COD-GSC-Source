require("x64:379001ae517dfa6")
require("x64:ff71d7766b2ab80")
CoD.PC_StartMenu_Options_FTEDesc = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_FTEDesc.__defaultWidth = 1920
CoD.PC_StartMenu_Options_FTEDesc.__defaultHeight = 438
CoD.PC_StartMenu_Options_FTEDesc.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_FTEDesc)
	self.id = "PC_StartMenu_Options_FTEDesc"
	self.soundSet = "default"
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -438, 0)
	Blur:setRGB(0.08, 0.08, 0.08)
	Blur:setAlpha(0.8)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local BG = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -438, 0)
	BG:setRGB(0.09, 0.09, 0.09)
	BG:setAlpha(0.55)
	self:addElement(BG)
	self.BG = BG
	local ScreenDesc = LUI.UIText.new(0.5, 0.5, -310, 310, 1, 1, -298, -265)
	ScreenDesc:setRGB(0.76, 0.76, 0.76)
	ScreenDesc:setAlpha(0.5)
	ScreenDesc:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	ScreenDesc:setTTF("ttmussels_regular")
	ScreenDesc:setLetterSpacing(3)
	ScreenDesc:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ScreenDesc:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	ScreenDesc:setBackingType(1)
	ScreenDesc:setBackingWidget(CoD.PC_StartMenu_Options_FTEDescBacking, f1_arg0, f1_arg1)
	ScreenDesc:setBackingXPadding(80)
	ScreenDesc:setBackingYPadding(20)
	self:addElement(ScreenDesc)
	self.ScreenDesc = ScreenDesc
	local LineFollowFocus = CoD.SeperationLine.new(f1_arg0, f1_arg1, 0, 0, 294.5, 467.5, 0, 0, 0, 1)
	self:addElement(LineFollowFocus)
	self.LineFollowFocus = LineFollowFocus
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_StartMenu_Options_FTEDesc.__onClose = function(f2_arg0)
	f2_arg0.LineFollowFocus:close()
end
