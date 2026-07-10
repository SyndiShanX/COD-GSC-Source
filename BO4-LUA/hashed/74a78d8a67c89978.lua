require("x64:19c1945d2e472b0")
CoD.PC_Korea_Event_Tier_Description = InheritFrom(LUI.UIElement)
CoD.PC_Korea_Event_Tier_Description.__defaultWidth = 701
CoD.PC_Korea_Event_Tier_Description.__defaultHeight = 159
CoD.PC_Korea_Event_Tier_Description.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Korea_Event_Tier_Description)
	self.id = "PC_Korea_Event_Tier_Description"
	self.soundSet = "default"
	local TierDescription = LUI.UIImage.new(0.5, 0.5, -350, 350, 0.5, 0.5, -70, 70)
	TierDescription:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	TierDescription:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(TierDescription)
	self.TierDescription = TierDescription
	local Backer = LUI.UIImage.new(0.5, 0.5, -350, 350, 0.5, 0.5, -70, 70)
	Backer:setRGB(0.17, 0.17, 0.17)
	Backer:setAlpha(0.35)
	self:addElement(Backer)
	self.Backer = Backer
	local StoreCommonTextBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -350, 350, 0.5, 0.5, -70.5, 70.5)
	StoreCommonTextBacking:setAlpha(0.65)
	StoreCommonTextBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(StoreCommonTextBacking)
	self.StoreCommonTextBacking = StoreCommonTextBacking
	local DescriptionLineBorder2 = LUI.UIImage.new(0.5, 0.5, -350, 350, 0.5, 0.5, 66, 86)
	DescriptionLineBorder2:setRGB(0.55, 0.55, 0.55)
	DescriptionLineBorder2:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	DescriptionLineBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	DescriptionLineBorder2:setShaderVector(0, 0, 0, 0, 0)
	DescriptionLineBorder2:setupNineSliceShader(6, 6)
	self:addElement(DescriptionLineBorder2)
	self.DescriptionLineBorder2 = DescriptionLineBorder2
	local DescriptionLineBorder = LUI.UIImage.new(0.5, 0.5, -350, 350, 0.5, 0.5, -75.5, -56.5)
	DescriptionLineBorder:setRGB(0.55, 0.55, 0.55)
	DescriptionLineBorder:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	DescriptionLineBorder:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	DescriptionLineBorder:setShaderVector(0, 0, 0, 0, 0)
	DescriptionLineBorder:setupNineSliceShader(6, 6)
	self:addElement(DescriptionLineBorder)
	self.DescriptionLineBorder = DescriptionLineBorder
	local TierUpgradeDescription = LUI.UIText.new(0.5, 0.5, -208, 328, 0.5, 0.5, -11, 4)
	TierUpgradeDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5B151BA588ADA54"))
	TierUpgradeDescription:setTTF("dinnext_regular")
	TierUpgradeDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TierUpgradeDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(TierUpgradeDescription)
	self.TierUpgradeDescription = TierUpgradeDescription
	local TierTitle = LUI.UIText.new(0.5, 0.5, -211, 325, 0.5, 0.5, -53.5, -26.5)
	TierTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	TierTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_2AE81B643F169AC"))
	TierTitle:setTTF("ttmussels_demibold")
	TierTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TierTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(TierTitle)
	self.TierTitle = TierTitle
	local TierToken = LUI.UIImage.new(0.5, 0.5, -333.5, -233.5, 0.5, 0.5, -50, 50)
	TierToken:setImage(RegisterImage(@"ui_icon_blackmarket_tier_token"))
	self:addElement(TierToken)
	self.TierToken = TierToken
	local CornerPips2 = LUI.UIImage.new(0.5, 0.5, 346.5, 351.5, 0.5, 0.5, -73.5, -68.5)
	CornerPips2:setImage(RegisterImage(@"hash_6CD2D51C614BCB51"))
	self:addElement(CornerPips2)
	self.CornerPips2 = CornerPips2
	local CornerPips4 = LUI.UIImage.new(0.5, 0.5, -351.5, -346.5, 0.5, 0.5, -73.5, -68.5)
	CornerPips4:setImage(RegisterImage(@"hash_6CD2D51C614BCB51"))
	self:addElement(CornerPips4)
	self.CornerPips4 = CornerPips4
	local CornerPips = LUI.UIImage.new(0.5, 0.5, 346.5, 351.5, 0.5, 0.5, 67.5, 72.5)
	CornerPips:setImage(RegisterImage(@"hash_6CD2D51C614BCB51"))
	self:addElement(CornerPips)
	self.CornerPips = CornerPips
	local CornerPips3 = LUI.UIImage.new(0.5, 0.5, -351.5, -346.5, 0.5, 0.5, 67.5, 72.5)
	CornerPips3:setImage(RegisterImage(@"hash_6CD2D51C614BCB51"))
	self:addElement(CornerPips3)
	self.CornerPips3 = CornerPips3
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Korea_Event_Tier_Description.__onClose = function(f2_arg0)
	f2_arg0.StoreCommonTextBacking:close()
end
