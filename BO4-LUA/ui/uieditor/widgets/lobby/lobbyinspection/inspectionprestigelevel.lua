CoD.InspectionPrestigeLevel = InheritFrom(LUI.UIElement)
CoD.InspectionPrestigeLevel.__defaultWidth = 400
CoD.InspectionPrestigeLevel.__defaultHeight = 21
CoD.InspectionPrestigeLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionPrestigeLevel)
	self.id = "InspectionPrestigeLevel"
	self.soundSet = "default"
	local PrestigeText = LUI.UIText.new(0, 0, 0, 200, 0, 0, 0, 21)
	PrestigeText:setRGB(0.13, 0.78, 1)
	PrestigeText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	PrestigeText:setTTF("dinnext_regular")
	PrestigeText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	PrestigeText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PrestigeText)
	self.PrestigeText = PrestigeText
	local PrestigeLevelNum = LUI.UIText.new(0, 0, 200, 400, 0, 0, 0, 21)
	PrestigeLevelNum:setRGB(0.13, 0.78, 1)
	PrestigeLevelNum:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	PrestigeLevelNum:setTTF("dinnext_regular")
	PrestigeLevelNum:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PrestigeLevelNum:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PrestigeLevelNum)
	self.PrestigeLevelNum = PrestigeLevelNum
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
