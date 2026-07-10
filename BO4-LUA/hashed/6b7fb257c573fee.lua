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
	BackingFillAnim:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
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
	AmmoFrameInuse:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_weapon_frame_inuse"))
	self:addElement(AmmoFrameInuse)
	self.AmmoFrameInuse = AmmoFrameInuse
	local AmmoFrameInuseGlow = LUI.UIImage.new(0, 0, -4, 152, 0, 0, -4, 122)
	AmmoFrameInuseGlow:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_weapon_frame_inuse_glow"))
	AmmoFrameInuseGlow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	AmmoFrameInuseGlow:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(AmmoFrameInuseGlow)
	self.AmmoFrameInuseGlow = AmmoFrameInuseGlow
	local AmmoName = LUI.UIText.new(0.5, 0.5, -41.5, 38.5, 1, 1, -12, 6)
	AmmoName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	AmmoName:setTTF("ttmussels_demibold")
	AmmoName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	AmmoName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
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
