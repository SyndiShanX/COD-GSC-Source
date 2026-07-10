require("x64:40c2fb60fba6534")
require("x64:46840c675b6e9ca")
require("x64:1cff9ab810ca0ce")
CoD.InspectionPlayerLevel = InheritFrom(LUI.UIElement)
CoD.InspectionPlayerLevel.__defaultWidth = 352
CoD.InspectionPlayerLevel.__defaultHeight = 162
CoD.InspectionPlayerLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionPlayerLevel)
	self.id = "InspectionPlayerLevel"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local TiledBackingRank = LUI.UIImage.new(0, 0, 2, 350, 0, 0, 2, 160)
	TiledBackingRank:setAlpha(0.5)
	TiledBackingRank:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBackingRank:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBackingRank:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingRank:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingRank)
	self.TiledBackingRank = TiledBackingRank
	local RankIconBGTint = LUI.UIImage.new(0, 0, 2, 136, 0, 0, 14, 160)
	RankIconBGTint:setRGB(0.39, 0.39, 0.39)
	RankIconBGTint:setAlpha(0.02)
	RankIconBGTint:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(RankIconBGTint)
	self.RankIconBGTint = RankIconBGTint
	local RankAndLevel = CoD.Social_RankIconAndRankLargeContainer.new(f1_arg0, f1_arg1, 0, 0, 2, 351, 0, 0, 19.5, 154.5)
	RankAndLevel:linkToElementModel(self, nil, false, function(model)
		RankAndLevel:setModel(model, f1_arg1)
	end)
	self:addElement(RankAndLevel)
	self.RankAndLevel = RankAndLevel
	local CommonStripeBar = CoD.CommonStripeBarStencil.new(f1_arg0, f1_arg1, 0, 0, 2, 350, 0, 0, 0, 16)
	self:addElement(CommonStripeBar)
	self.CommonStripeBar = CommonStripeBar
	local TopBracket = LUI.UIImage.new(0, 1, -2, 2, 1, 1, -26.5, 3.5)
	TopBracket:setZRot(180)
	TopBracket:setImage(RegisterImage(@"uie_ui_menu_common_button_bracket"))
	TopBracket:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	TopBracket:setShaderVector(0, 0, 0, 0, 0)
	TopBracket:setupNineSliceShader(12, 12)
	self:addElement(TopBracket)
	self.TopBracket = TopBracket
	local PlayerInspectionInfoPaneWinStreak = CoD.PlayerInspection_InfoPaneWinStreak.new(f1_arg0, f1_arg1, 0, 0, 0, 348, 0, 0, 162, 195)
	PlayerInspectionInfoPaneWinStreak:linkToElementModel(self, "rankInfo", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlayerInspectionInfoPaneWinStreak:setModel(f3_local0, f1_arg1)
		end
	end)
	PlayerInspectionInfoPaneWinStreak:linkToElementModel(self, "arenaWinStreak", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PlayerInspectionInfoPaneWinStreak.WinStreak:setText(f4_local0)
		end
	end)
	self:addElement(PlayerInspectionInfoPaneWinStreak)
	self.PlayerInspectionInfoPaneWinStreak = PlayerInspectionInfoPaneWinStreak
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionPlayerLevel.__onClose = function(f5_arg0)
	f5_arg0.RankAndLevel:close()
	f5_arg0.CommonStripeBar:close()
	f5_arg0.PlayerInspectionInfoPaneWinStreak:close()
end
