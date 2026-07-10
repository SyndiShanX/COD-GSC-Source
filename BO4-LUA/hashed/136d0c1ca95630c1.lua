require("x64:94dab3a4d2d79b2")
CoD.FallMeter_Speed = InheritFrom(LUI.UIElement)
CoD.FallMeter_Speed.__defaultWidth = 70
CoD.FallMeter_Speed.__defaultHeight = 40
CoD.FallMeter_Speed.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FallMeter_Speed)
	self.id = "FallMeter_Speed"
	self.soundSet = "none"
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Blur:setRGB(0.1, 0.1, 0.1)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local BackingNoise = LUI.UIImage.new(0, 1, 0, 0, 0, 0.99, 0.5, 0.5)
	BackingNoise:setAlpha(0.8)
	BackingNoise:setImage(RegisterImage(0x34839E8065B1E53))
	BackingNoise:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	BackingNoise:setShaderVector(0, 0, 0, 0, 0)
	BackingNoise:setupNineSliceShader(196, 88)
	self:addElement(BackingNoise)
	self.BackingNoise = BackingNoise
	local Corner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Corner9Slice:setAlpha(0.75)
	self:addElement(Corner9Slice)
	self.Corner9Slice = Corner9Slice
	local SpeedTitle = LUI.UIText.new(0.5, 0.5, -35, 35, 0.5, 0.5, 1, 17)
	SpeedTitle:setRGB(0.67, 0.67, 0.67)
	SpeedTitle:setText(Engine[0xF9F1239CFD921FE](0x6FD7C2FB6AF9CF4))
	SpeedTitle:setTTF("ttmussels_demibold")
	SpeedTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SpeedTitle:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(SpeedTitle)
	self.SpeedTitle = SpeedTitle
	local SpeedValue = LUI.UIText.new(0.5, 0.5, -32, 32, 0.5, 0.5, -17, 2)
	SpeedValue:setTTF("0arame_mono_stencil")
	SpeedValue:setLetterSpacing(2)
	SpeedValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	SpeedValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	SpeedValue:subscribeToGlobalModel(f1_arg1, "HUDItems", "speed", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpeedValue:setText(FormatNumberAsString(0, StringMultiply(0.45, f2_local0)))
		end
	end)
	self:addElement(SpeedValue)
	self.SpeedValue = SpeedValue
	local IconParachute = LUI.UIImage.new(0, 0, 2, 39, 0, 0, 1, 38)
	IconParachute:setAlpha(0)
	IconParachute:setImage(RegisterImage(0xA912D9E22E33B69))
	self:addElement(IconParachute)
	self.IconParachute = IconParachute
	local IconWingSuit = LUI.UIImage.new(0, 0, 3, 39, 0, 0, 2, 38)
	IconWingSuit:setAlpha(0)
	IconWingSuit:setImage(RegisterImage(0x9D3717D7C3A9ECC))
	self:addElement(IconWingSuit)
	self.IconWingSuit = IconWingSuit
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FallMeter_Speed.__onClose = function(f3_arg0)
	f3_arg0.Corner9Slice:close()
	f3_arg0.SpeedValue:close()
end
