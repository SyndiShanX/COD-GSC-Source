CoD.WarzoneDeathCamLabelLarge = InheritFrom(LUI.UIElement)
CoD.WarzoneDeathCamLabelLarge.__defaultWidth = 960
CoD.WarzoneDeathCamLabelLarge.__defaultHeight = 200
CoD.WarzoneDeathCamLabelLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDeathCamLabelLarge)
	self.id = "WarzoneDeathCamLabelLarge"
	self.soundSet = "none"
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.41, 0.06, 0.07)
	self:addElement(Background)
	self.Background = Background
	local DeathCamLabel = LUI.UIText.new(0.5, 0.5, -450, 450, 0, 0, 0, 200)
	DeathCamLabel:setText(LocalizeToUpperString(0xA8BAC035CE51600))
	DeathCamLabel:setTTF("ttmussels_demibold")
	DeathCamLabel:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	DeathCamLabel:setLetterSpacing(20)
	DeathCamLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	DeathCamLabel:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(DeathCamLabel)
	self.DeathCamLabel = DeathCamLabel
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
