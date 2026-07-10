require("x64:40c2fb60fba6534")
require("x64:42702cd396663a8")
require("x64:46840c675b6e9ca")
CoD.LobbyPlayerInspectionPlayerLevel = InheritFrom(LUI.UIElement)
CoD.LobbyPlayerInspectionPlayerLevel.__defaultWidth = 352
CoD.LobbyPlayerInspectionPlayerLevel.__defaultHeight = 162
CoD.LobbyPlayerInspectionPlayerLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LobbyPlayerInspectionPlayerLevel)
	self.id = "LobbyPlayerInspectionPlayerLevel"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local TiledBackingRank = LUI.UIImage.new(0, 0, 2, 350, 0, 0, 2, 160)
	TiledBackingRank:setAlpha(0.5)
	TiledBackingRank:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBackingRank:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBackingRank:setShaderVector(0, 0, 0, 0, 0)
	TiledBackingRank:setupNineSliceShader(196, 88)
	self:addElement(TiledBackingRank)
	self.TiledBackingRank = TiledBackingRank
	local RankIconBGTint = LUI.UIImage.new(0, 0, 2, 136, 0, 0, 14, 160)
	RankIconBGTint:setRGB(0.39, 0.39, 0.39)
	RankIconBGTint:setAlpha(0.02)
	RankIconBGTint:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(RankIconBGTint)
	self.RankIconBGTint = RankIconBGTint
	local RankAndLevel = CoD.CommonRankIconAndRankLarge.new(f1_arg0, f1_arg1, 0, 0, 2, 351, 0, 0, 19.5, 154.5)
	RankAndLevel:linkToElementModel(self, "rankInfo", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RankAndLevel:setModel(f2_local0, f1_arg1)
		end
	end)
	RankAndLevel:linkToElementModel(self, nil, false, function(model)
		RankAndLevel.arenaRubiesUnlocked:setModel(model, f1_arg1)
	end)
	self:addElement(RankAndLevel)
	self.RankAndLevel = RankAndLevel
	local CommonStripeBar = CoD.CommonStripeBarStencil.new(f1_arg0, f1_arg1, 0, 0, 2, 350, 0, 0, 0, 16)
	self:addElement(CommonStripeBar)
	self.CommonStripeBar = CommonStripeBar
	local TopBracket = LUI.UIImage.new(0, 1, -2, 2, 1, 1, -26.5, 3.5)
	TopBracket:setZRot(180)
	TopBracket:setImage(RegisterImage(0x46CC392945F433B))
	TopBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	TopBracket:setShaderVector(0, 0, 0, 0, 0)
	TopBracket:setupNineSliceShader(12, 12)
	self:addElement(TopBracket)
	self.TopBracket = TopBracket
	local PlayerInspectionInfoPaneWinStreak = CoD.PlayerInspection_InfoPaneWinStreak.new(f1_arg0, f1_arg1, 0, 0, 2, 350, 0, 0, 165.5, 198.5)
	PlayerInspectionInfoPaneWinStreak:linkToElementModel(self, "rankInfo", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PlayerInspectionInfoPaneWinStreak:setModel(f4_local0, f1_arg1)
		end
	end)
	PlayerInspectionInfoPaneWinStreak:linkToElementModel(self, "xuid", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			PlayerInspectionInfoPaneWinStreak.WinStreak:setText(CoD.ArenaLeaguePlayUtility.GetLeagueLadderPlayerBestFirstPlaceStreakFromXuid(f5_local0))
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
CoD.LobbyPlayerInspectionPlayerLevel.__onClose = function(f6_arg0)
	f6_arg0.RankAndLevel:close()
	f6_arg0.CommonStripeBar:close()
	f6_arg0.PlayerInspectionInfoPaneWinStreak:close()
end
