require("x64:c7393046816f760")
require("x64:e26b55c0d1094c0")
require("x64:8ee2deebbd020ca")
require("x64:79177e5d8aa2dec")
CoD.GameEndScore_GameStatus = InheritFrom(LUI.UIElement)
CoD.GameEndScore_GameStatus.__defaultWidth = 1920
CoD.GameEndScore_GameStatus.__defaultHeight = 77
CoD.GameEndScore_GameStatus.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_GameStatus)
	self.id = "GameEndScore_GameStatus"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local BackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBlur:setRGB(0, 0, 0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local Backing2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing2:setRGB(0, 0, 0)
	Backing2:setAlpha(0.94)
	self:addElement(Backing2)
	self.Backing2 = Backing2
	local WZGridRepeat = LUI.UIImage.new(0, 1, 0, 0, -0.09, 1.19, -42.5, -14.5)
	WZGridRepeat:setRGB(0, 0, 0)
	WZGridRepeat:setAlpha(0.3)
	WZGridRepeat:setImage(RegisterImage(@"uie_ui_hud_wz_endgame_repeat_grid"))
	WZGridRepeat:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	WZGridRepeat:setShaderVector(0, 0, 0, 0, 0)
	WZGridRepeat:setupNineSliceShader(64, 64)
	self:addElement(WZGridRepeat)
	self.WZGridRepeat = WZGridRepeat
	local TopBarLeft = LUI.UIImage.new(0, 0.5, 0, 0, 0, 0, -1, 15)
	TopBarLeft:setAlpha(0.8)
	TopBarLeft:setImage(RegisterImage(@"uie_ui_hud_wz_endgame_top_halfbar"))
	self:addElement(TopBarLeft)
	self.TopBarLeft = TopBarLeft
	local TopBarRight = LUI.UIImage.new(1, 0.5, 0, 0, 0, 0, -1, 15)
	TopBarRight:setAlpha(0.8)
	TopBarRight:setImage(RegisterImage(@"uie_ui_hud_wz_endgame_top_halfbar"))
	self:addElement(TopBarRight)
	self.TopBarRight = TopBarRight
	local SquareOthers = CoD.AARLevelCommonBoxes.new(f1_arg0, f1_arg1, 0.5, 0.5, -937.5, -889.5, 0, 0, 61.5, 74.5)
	SquareOthers:setAlpha(0.4)
	self:addElement(SquareOthers)
	self.SquareOthers = SquareOthers
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local PlayerKills = CoD.GameEndScore_GameStatusPlayerKills.new(f1_arg0, f1_arg1, 0.5, 0.5, 569, 709, 0, 0, 40, 90)
	PlayerKills:setAlpha(0)
	self:addElement(PlayerKills)
	self.PlayerKills = PlayerKills
	local PlayerLeft = CoD.GameEndScore_GameStatusPlayerLeft.new(f1_arg0, f1_arg1, 0.5, 0.5, 717, 857, 0, 0, 40, 90)
	PlayerLeft:setAlpha(0)
	self:addElement(PlayerLeft)
	self.PlayerLeft = PlayerLeft
	local TeamIcon = LUI.UIImage.new(0.5, 0.5, 405, 444, 0, 0, 8, 42)
	TeamIcon:setAlpha(0)
	TeamIcon:setImage(RegisterImage(@"hash_2A16F29EFD38E823"))
	self:addElement(TeamIcon)
	self.TeamIcon = TeamIcon
	local TeamCount = LUI.UIText.new(0.5, 0.5, 451, 543, 0, 0, 8, 43)
	TeamCount:setAlpha(0)
	TeamCount:setTTF("0arame_mono_stencil")
	TeamCount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	TeamCount:setShaderVector(0, 0.8, 0, 0, 0)
	TeamCount:setShaderVector(1, 0, 0, 0, 0)
	TeamCount:setShaderVector(2, 1, 1, 1, 0.35)
	TeamCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TeamCount:subscribeToGlobalModel(f1_arg1, "HUDItems", "aliveTeammateCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TeamCount:setText(f2_local0)
		end
	end)
	self:addElement(TeamCount)
	self.TeamCount = TeamCount
	local SpectatorIcon = LUI.UIImage.new(0.5, 0.5, 835, 881, 0, 0, 50, 100)
	SpectatorIcon:setAlpha(0)
	SpectatorIcon:setImage(RegisterImage(@"uie_hud_common_core_score_delivered"))
	self:addElement(SpectatorIcon)
	self.SpectatorIcon = SpectatorIcon
	local SpectatorCount = LUI.UIText.new(0.5, 0.5, 868, 960, 0, 0, 57.5, 92.5)
	SpectatorCount:setAlpha(0)
	SpectatorCount:setTTF("0arame_mono_stencil")
	SpectatorCount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	SpectatorCount:setShaderVector(0, 0.8, 0, 0, 0)
	SpectatorCount:setShaderVector(1, 0, 0, 0, 0)
	SpectatorCount:setShaderVector(2, 1, 1, 1, 0.35)
	SpectatorCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SpectatorCount:subscribeToGlobalModel(f1_arg1, "HUDItems", "spectatorsCount", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SpectatorCount:setText(f3_local0)
		end
	end)
	self:addElement(SpectatorCount)
	self.SpectatorCount = SpectatorCount
	local WarzoneGameStatusIndicatorDisplayRight = CoD.WarzoneGameStatusIndicatorDisplay.new(f1_arg0, f1_arg1, 0.5, 0.5, 569, 914, 0, 0, 40, 84)
	WarzoneGameStatusIndicatorDisplayRight.GameStatusIndicatorsRightSolo:setFilter(function(f4_arg0)
		return f4_arg0.type:get() == "gameInformation"
	end)
	WarzoneGameStatusIndicatorDisplayRight.GameStatusIndicatorsRightSolo:setDataSource("WarzoneGameStatusIndicatorListEndGameRight")
	WarzoneGameStatusIndicatorDisplayRight.GameStatusIndicatorsLeftSolo:setFilter(function(f5_arg0)
		return f5_arg0.type:get() == "hudGameStat"
	end)
	WarzoneGameStatusIndicatorDisplayRight.GameStatusIndicatorsLeftSolo:setDataSource("WarzoneGameStatusIndicatorListEndGameRight")
	WarzoneGameStatusIndicatorDisplayRight.GameStatusIndicators:setDataSource("WarzoneGameStatusIndicatorListEndGameRight")
	self:addElement(WarzoneGameStatusIndicatorDisplayRight)
	self.WarzoneGameStatusIndicatorDisplayRight = WarzoneGameStatusIndicatorDisplayRight
	local WarzoneGameStatusIndicatorDisplayRight2 = CoD.WarzoneGameStatusIndicatorDisplay.new(f1_arg0, f1_arg1, 0.5, 0.5, -889.5, -544.5, 0, 0, 40, 84)
	WarzoneGameStatusIndicatorDisplayRight2.GameStatusIndicatorsRightSolo:setFilter(function(f6_arg0)
		return f6_arg0.type:get() == "gameInformation"
	end)
	WarzoneGameStatusIndicatorDisplayRight2.GameStatusIndicatorsRightSolo:setDataSource("WarzoneGameStatusIndicatorListEndGameLeft")
	WarzoneGameStatusIndicatorDisplayRight2.GameStatusIndicatorsLeftSolo:setFilter(function(f7_arg0)
		return f7_arg0.type:get() == "hudGameStat"
	end)
	WarzoneGameStatusIndicatorDisplayRight2.GameStatusIndicatorsLeftSolo:setDataSource("WarzoneGameStatusIndicatorListEndGameLeft")
	WarzoneGameStatusIndicatorDisplayRight2.GameStatusIndicators:setDataSource("WarzoneGameStatusIndicatorListEndGameLeft")
	self:addElement(WarzoneGameStatusIndicatorDisplayRight2)
	self.WarzoneGameStatusIndicatorDisplayRight2 = WarzoneGameStatusIndicatorDisplayRight2
	local TiledShaderImage = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 75, 79)
	TiledShaderImage:setImage(RegisterImage(@"uie_ui_hud_wz_endgame_top_line"))
	TiledShaderImage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledShaderImage:setShaderVector(0, 0, 0, 0, 0)
	TiledShaderImage:setupNineSliceShader(200, 4)
	self:addElement(TiledShaderImage)
	self.TiledShaderImage = TiledShaderImage
	local FrameBoxesLeft = LUI.UIImage.new(0.5, 0.5, 808, 908, 0, 0, 17, 33)
	FrameBoxesLeft:setAlpha(0.8)
	FrameBoxesLeft:setImage(RegisterImage(@"uie_ui_hud_wz_endgame_frame_detail01"))
	self:addElement(FrameBoxesLeft)
	self.FrameBoxesLeft = FrameBoxesLeft
	local FrameBoxesRight = LUI.UIImage.new(0.5, 0.5, -908, -808, 0, 0, 17, 33)
	FrameBoxesRight:setAlpha(0.8)
	FrameBoxesRight:setImage(RegisterImage(@"uie_ui_hud_wz_endgame_frame_detail01"))
	self:addElement(FrameBoxesRight)
	self.FrameBoxesRight = FrameBoxesRight
	WarzoneGameStatusIndicatorDisplayRight.id = "WarzoneGameStatusIndicatorDisplayRight"
	WarzoneGameStatusIndicatorDisplayRight2.id = "WarzoneGameStatusIndicatorDisplayRight2"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_GameStatus.__onClose = function(f8_arg0)
	f8_arg0.SquareOthers:close()
	f8_arg0.PlayerKills:close()
	f8_arg0.PlayerLeft:close()
	f8_arg0.TeamCount:close()
	f8_arg0.SpectatorCount:close()
	f8_arg0.WarzoneGameStatusIndicatorDisplayRight:close()
	f8_arg0.WarzoneGameStatusIndicatorDisplayRight2:close()
end
