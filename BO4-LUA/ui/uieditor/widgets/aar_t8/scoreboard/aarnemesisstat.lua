CoD.AARNemesisStat = InheritFrom(LUI.UIElement)
CoD.AARNemesisStat.__defaultWidth = 60
CoD.AARNemesisStat.__defaultHeight = 40
CoD.AARNemesisStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARNemesisStat)
	self.id = "AARNemesisStat"
	self.soundSet = "none"
	local Label = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 0, 16)
	Label:setAlpha(0.8)
	Label:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Label:setTTF("ttmussels_regular")
	Label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Label)
	self.Label = Label
	local Stat = LUI.UIText.new(0.5, 0.5, -100, 100, 0, 0, 18, 48)
	Stat:setAlpha(0.8)
	Stat:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Stat:setTTF("ttmussels_demibold")
	Stat:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Stat:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Stat)
	self.Stat = Stat
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
