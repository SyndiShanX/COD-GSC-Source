require("x64:19c1945d2e472b0")
CoD.vhud_gunship_ammocounterframe = InheritFrom(LUI.UIElement)
CoD.vhud_gunship_ammocounterframe.__defaultWidth = 148
CoD.vhud_gunship_ammocounterframe.__defaultHeight = 118
CoD.vhud_gunship_ammocounterframe.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_gunship_ammocounterframe)
	self.id = "vhud_gunship_ammocounterframe"
	self.soundSet = "none"
	local BackingFillAnim = LUI.UIImage.new(0.03, 0.03, -1, 140, 0.03, 0.03, 0, 99)
	BackingFillAnim:setRGB(0.13, 0.13, 0.13)
	BackingFillAnim:setAlpha(0.9)
	BackingFillAnim:setZRot(180)
	BackingFillAnim:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	BackingFillAnim:setShaderVector(0, 1, 0, 0, 0)
	BackingFillAnim:setShaderVector(1, 0, 0, 0, 0)
	BackingFillAnim:setShaderVector(2, 1, 0, 0, 0)
	BackingFillAnim:setShaderVector(3, 0.05, 0, 0, 0)
	BackingFillAnim:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(BackingFillAnim)
	self.BackingFillAnim = BackingFillAnim
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 3.5, 144.5, 0, 0, 3.5, 102.5)
	DotTiledBacking:setAlpha(0.5)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local AmmoFrameInuse = LUI.UIImage.new(1, 1, -148, 0, -0.02, -0.02, 2.5, 120.5)
	AmmoFrameInuse:setImage(RegisterImage(0x83F5377573CDA03))
	self:addElement(AmmoFrameInuse)
	self.AmmoFrameInuse = AmmoFrameInuse
	local AmmoFrameInuseGlow = LUI.UIImage.new(0, 0, -4, 152, 0, 0, -4, 122)
	AmmoFrameInuseGlow:setImage(RegisterImage(0x40F5EB1A9F978E5))
	AmmoFrameInuseGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	AmmoFrameInuseGlow:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(AmmoFrameInuseGlow)
	self.AmmoFrameInuseGlow = AmmoFrameInuseGlow
	local AmmoName = LUI.UIText.new(0.5, 0.5, -41.5, 38.5, 1, 1, -12, 6)
	AmmoName:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	AmmoName:setTTF("ttmussels_demibold")
	AmmoName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	AmmoName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(AmmoName)
	self.AmmoName = AmmoName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_gunship_ammocounterframe.__onClose = function(f2_arg0)
	f2_arg0.DotTiledBacking:close()
end
