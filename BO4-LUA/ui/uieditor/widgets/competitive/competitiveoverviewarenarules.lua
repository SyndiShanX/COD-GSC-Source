CoD.CompetitiveOverviewArenaRules = InheritFrom(LUI.UIElement)
CoD.CompetitiveOverviewArenaRules.__defaultWidth = 1520
CoD.CompetitiveOverviewArenaRules.__defaultHeight = 21
CoD.CompetitiveOverviewArenaRules.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 14, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CompetitiveOverviewArenaRules)
	self.id = "CompetitiveOverviewArenaRules"
	self.soundSet = "default"
	local ArenaRulesLine1 = LUI.UIText.new(0, 0, 0, 280, 0, 0, 0, 25)
	ArenaRulesLine1:setRGB(ColorSet.T8__DARK__GOLD.r, ColorSet.T8__DARK__GOLD.g, ColorSet.T8__DARK__GOLD.b)
	ArenaRulesLine1:setAlpha(0.8)
	ArenaRulesLine1:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_CD564C38C71C81E"))
	ArenaRulesLine1:setTTF("ttmussels_demibold")
	ArenaRulesLine1:setLetterSpacing(2)
	ArenaRulesLine1:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ArenaRulesLine1:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ArenaRulesLine1)
	self.ArenaRulesLine1 = ArenaRulesLine1
	local Bar01 = LUI.UIImage.new(0, 0, 294, 296, 0, 0, 2, 20)
	Bar01:setRGB(ColorSet.T8__DARK__GOLD.r, ColorSet.T8__DARK__GOLD.g, ColorSet.T8__DARK__GOLD.b)
	Bar01:setAlpha(0.4)
	Bar01:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	Bar01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	Bar01:setShaderVector(0, 0, 0, 0, 0)
	Bar01:setupNineSliceShader(64, 64)
	self:addElement(Bar01)
	self.Bar01 = Bar01
	local ArenaRulesLine4 = LUI.UIText.new(0, 0, 310, 610, 0, 0, 0, 25)
	ArenaRulesLine4:setRGB(ColorSet.T8__DARK__GOLD.r, ColorSet.T8__DARK__GOLD.g, ColorSet.T8__DARK__GOLD.b)
	ArenaRulesLine4:setAlpha(0.8)
	ArenaRulesLine4:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_CD569C38C71D09D"))
	ArenaRulesLine4:setTTF("ttmussels_demibold")
	ArenaRulesLine4:setLetterSpacing(2)
	ArenaRulesLine4:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ArenaRulesLine4:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ArenaRulesLine4)
	self.ArenaRulesLine4 = ArenaRulesLine4
	local Bar02 = LUI.UIImage.new(0, 0, 624, 626, 0, 0, 2, 20)
	Bar02:setRGB(ColorSet.T8__DARK__GOLD.r, ColorSet.T8__DARK__GOLD.g, ColorSet.T8__DARK__GOLD.b)
	Bar02:setAlpha(0.4)
	Bar02:setImage(RegisterImage(@"uie_ui_menu_aar_repeat_white_bg"))
	Bar02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	Bar02:setShaderVector(0, 0, 0, 0, 0)
	Bar02:setupNineSliceShader(64, 64)
	self:addElement(Bar02)
	self.Bar02 = Bar02
	local ArenaRulesLine2 = LUI.UIText.new(0, 0, 640, 1000, 0, 0, 0, 25)
	ArenaRulesLine2:setRGB(ColorSet.T8__DARK__GOLD.r, ColorSet.T8__DARK__GOLD.g, ColorSet.T8__DARK__GOLD.b)
	ArenaRulesLine2:setAlpha(0.8)
	ArenaRulesLine2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_CD563C38C71C66B"))
	ArenaRulesLine2:setTTF("ttmussels_demibold")
	ArenaRulesLine2:setLetterSpacing(2)
	ArenaRulesLine2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ArenaRulesLine2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ArenaRulesLine2)
	self.ArenaRulesLine2 = ArenaRulesLine2
	local f1_local6 = nil
	self.Bar03 = LUI.UIElement.createFake()
	local f1_local7 = nil
	self.ArenaRulesLine3 = LUI.UIElement.createFake()
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
