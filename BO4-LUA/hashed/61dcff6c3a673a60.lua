CoD.PositionDraft_GametypeAndMap = InheritFrom(LUI.UIElement)
CoD.PositionDraft_GametypeAndMap.__defaultWidth = 700
CoD.PositionDraft_GametypeAndMap.__defaultHeight = 100
CoD.PositionDraft_GametypeAndMap.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_GametypeAndMap)
	self.id = "PositionDraft_GametypeAndMap"
	self.soundSet = "none"
	local Backer = LUI.UIImage.new(0, 0, 45, 578, 0, 0, 27, 80)
	Backer:setRGB(0, 0, 0)
	Backer:setAlpha(0.7)
	Backer:setImage(RegisterImage(0xD16B33E79A589C5))
	Backer:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Backer:setShaderVector(0, 0, 0, 0.05, 0)
	self:addElement(Backer)
	self.Backer = Backer
	local Line = LUI.UIImage.new(0, 0, 49, 533, 0, 0, 27, 28)
	Line:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Line:setAlpha(0.5)
	Line:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Line:setShaderVector(0, 0, 0, 0.2, 0)
	self:addElement(Line)
	self.Line = Line
	local Gametype = LUI.UIText.new(0, 0, 103, 494, 0, 0, 52, 76)
	Gametype:setRGB(ColorSet.T8__BUTTON_UNSELECTED_MAIN.r, ColorSet.T8__BUTTON_UNSELECTED_MAIN.g, ColorSet.T8__BUTTON_UNSELECTED_MAIN.b)
	Gametype:setAlpha(0.8)
	Gametype:setText(LocalizeToUpperString(LocalizedGameType()))
	Gametype:setTTF("ttmussels_demibold")
	Gametype:setLetterSpacing(5)
	Gametype:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Gametype:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Gametype)
	self.Gametype = Gametype
	local MapName = LUI.UIText.new(0, 0, 103, 491, 0, 0, 33, 51)
	MapName:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
	MapName:setText(ToUpper(GetMapName()))
	MapName:setTTF("ttmussels_regular")
	MapName:setLetterSpacing(5)
	MapName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MapName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(MapName)
	self.MapName = MapName
	local GametypeImage = LUI.UIImage.new(0, 0, -30, 119, 0, 0, -22.5, 126.5)
	GametypeImage:setScale(0.66, 0.66)
	GametypeImage:setImage(RegisterImage(GetGametypeImage(0x46FF4D641CEA3B)))
	self:addElement(GametypeImage)
	self.GametypeImage = GametypeImage
	local LED = LUI.UIImage.new(0, 0, 36.5, 588.5, 0, 0, 24, 84)
	LED:setAlpha(0.2)
	LED:setImage(RegisterImage(0x5AA5A58DD99CB9F))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(LED)
	self.LED = LED
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
