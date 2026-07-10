require("x64:6f04ea11bdb2fba")
require("x64:666d2365354a2ea")
require("x64:eacfc4f19b485e9")
CoD.PositionDraft_Teams = InheritFrom(CoD.Menu)
LUI.createMenu.PositionDraft_Teams = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PositionDraft_Teams", f1_arg0)
	local f1_local1 = self
	SetProperty(self, "disablePopupOpenCloseAnim", true)
	self:setClass(CoD.PositionDraft_Teams)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0, 0, 0)
	BG:setAlpha(0.75)
	self:addElement(BG)
	self.BG = BG
	local BGCenter = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -430, 430)
	BGCenter:setRGB(0, 0, 0)
	BGCenter:setAlpha(0.6)
	self:addElement(BGCenter)
	self.BGCenter = BGCenter
	local TiledBacking = LUI.UIImage.new(-0.01, 1.01, 0, 0, 0.5, 0.5, -430, 430)
	TiledBacking:setRGB(0, 0, 0)
	TiledBacking:setAlpha(0.5)
	TiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local CircleBaseLarge = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -100, 100)
	CircleBaseLarge:setRGB(0, 0, 0)
	CircleBaseLarge:setAlpha(0.1)
	CircleBaseLarge:setImage(RegisterImage(@"uie_ui_hud_common_draft_timer_backer"))
	self:addElement(CircleBaseLarge)
	self.CircleBaseLarge = CircleBaseLarge
	local CircleBaseSmall = LUI.UIImage.new(0.5, 0.5, -70, 70, 0.5, 0.5, -70, 70)
	CircleBaseSmall:setRGB(0, 0, 0)
	CircleBaseSmall:setAlpha(0.6)
	CircleBaseSmall:setScale(1.1, 1.1)
	CircleBaseSmall:setImage(RegisterImage(@"uie_ui_hud_common_draft_timer_backer"))
	self:addElement(CircleBaseSmall)
	self.CircleBaseSmall = CircleBaseSmall
	local Ring = LUI.UIImage.new(0.5, 0.5, -70, 70, 0.5, 0.5, -70, 70)
	Ring:setAlpha(0.5)
	Ring:setImage(RegisterImage(@"uie_ui_hud_common_draft_timer_fui"))
	Ring:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(Ring)
	self.Ring = Ring
	local StrokeL = LUI.UIImage.new(0.5, 0.5, -491, -136, 0.5, 0.5, -1, 1)
	StrokeL:setAlpha(0.06)
	StrokeL:setYRot(180)
	self:addElement(StrokeL)
	self.StrokeL = StrokeL
	local StrokeR = LUI.UIImage.new(0.5, 0.5, 136, 491, 0.5, 0.5, -1, 1)
	StrokeR:setAlpha(0.06)
	StrokeR:setYRot(180)
	self:addElement(StrokeR)
	self.StrokeR = StrokeR
	local VS2 = LUI.UIText.new(0.5, 0.5, -585, 585, 0.5, 0.5, -21.5, 23.5)
	VS2:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	VS2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_34F347C78B3F5793"))
	VS2:setTTF("ttmussels_regular")
	VS2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	VS2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(VS2)
	self.VS2 = VS2
	local EnemyLineL = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, 56, 432)
	EnemyLineL:setAlpha(0)
	EnemyLineL:setYRot(180)
	EnemyLineL:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	EnemyLineL:setShaderVector(0, 0, 1, 0, 0)
	EnemyLineL:setShaderVector(1, 0, 0, 0, 0)
	EnemyLineL:setShaderVector(2, 0, 1, 0, 0)
	EnemyLineL:setShaderVector(3, 1, 0, 0, 0)
	EnemyLineL:setShaderVector(4, 0, 0, 0, 0)
	EnemyLineL:subscribeToGlobalModel(f1_arg0, "Factions", "axisFactionColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			EnemyLineL:setRGB(f2_local0)
		end
	end)
	self:addElement(EnemyLineL)
	self.EnemyLineL = EnemyLineL
	local EnemyLineL2 = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, 430, 436)
	EnemyLineL2:setYRot(180)
	EnemyLineL2:subscribeToGlobalModel(f1_arg0, "Factions", "axisFactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EnemyLineL2:setRGB(f3_local0)
		end
	end)
	self:addElement(EnemyLineL2)
	self.EnemyLineL2 = EnemyLineL2
	local FriendlyLineL = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -432, -56)
	FriendlyLineL:setAlpha(0)
	FriendlyLineL:setYRot(180)
	FriendlyLineL:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	FriendlyLineL:setShaderVector(0, 0, 1, 0, 0)
	FriendlyLineL:setShaderVector(1, 0, 0, 0, 0)
	FriendlyLineL:setShaderVector(2, 0, 1, 0, 0)
	FriendlyLineL:setShaderVector(3, 0, 1, 0, 0)
	FriendlyLineL:setShaderVector(4, 0, 0, 0, 0)
	FriendlyLineL:subscribeToGlobalModel(f1_arg0, "Factions", "alliesFactionColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			FriendlyLineL:setRGB(f4_local0)
		end
	end)
	self:addElement(FriendlyLineL)
	self.FriendlyLineL = FriendlyLineL
	local FriendlyLineL2 = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -436, -430)
	FriendlyLineL2:setAlpha(0.3)
	FriendlyLineL2:setYRot(180)
	FriendlyLineL2:subscribeToGlobalModel(f1_arg0, "Factions", "alliesFactionColor", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			FriendlyLineL2:setRGB(f5_local0)
		end
	end)
	self:addElement(FriendlyLineL2)
	self.FriendlyLineL2 = FriendlyLineL2
	local EnemyTeam = LUI.UIList.new(f1_local1, f1_arg0, 15, 0, nil, false, false, false, false)
	EnemyTeam:mergeStateConditions({
		{
			stateName = "Friendly_CharacterSelected_Rank",
			condition = function(menu, element, event)
				local f6_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg0, "characterIndex") then
					f6_local0 = IsPublicOnlineGame()
					if f6_local0 then
						f6_local0 = AlwaysFalse()
					end
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "Friendly_CharacterSelected",
			condition = function(menu, element, event)
				local f7_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg0, "characterIndex") then
					f7_local0 = AlwaysFalse()
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
		{
			stateName = "Friendly_ValidClient",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg0, "clientNum", 0) and AlwaysFalse()
			end,
		},
		{
			stateName = "Friendly_Searching",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Enemy_CharacterSelected",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Enemy_Searching",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	EnemyTeam:linkToElementModel(EnemyTeam, "characterIndex", true, function(model)
		f1_local1:updateElementState(EnemyTeam, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	EnemyTeam:linkToElementModel(EnemyTeam, "clientNum", true, function(model)
		f1_local1:updateElementState(EnemyTeam, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	EnemyTeam:setLeftRight(0.5, 0.5, -604.5, 604.5)
	EnemyTeam:setTopBottom(0.5, 0.5, 134, 350)
	EnemyTeam:setScale(1.2, 1.2)
	EnemyTeam:setWidgetType(CoD.PositionDraft_ViewTeams_Client)
	EnemyTeam:setHorizontalCount(6)
	EnemyTeam:setSpacing(15)
	EnemyTeam:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	EnemyTeam:setDataSource("Clients")
	self:addElement(EnemyTeam)
	self.EnemyTeam = EnemyTeam
	local EnemyTeamCodCaster = LUI.UIList.new(f1_local1, f1_arg0, 15, 0, nil, false, false, false, false)
	EnemyTeamCodCaster:mergeStateConditions({
		{
			stateName = "Friendly_CharacterSelected_Rank",
			condition = function(menu, element, event)
				local f14_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg0, "characterIndex") then
					f14_local0 = IsPublicOnlineGame()
					if f14_local0 then
						f14_local0 = AlwaysFalse()
					end
				else
					f14_local0 = false
				end
				return f14_local0
			end,
		},
		{
			stateName = "Friendly_CharacterSelected",
			condition = function(menu, element, event)
				local f15_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg0, "characterIndex") then
					f15_local0 = AlwaysFalse()
				else
					f15_local0 = false
				end
				return f15_local0
			end,
		},
		{
			stateName = "Friendly_ValidClient",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg0, "clientNum", 0) and AlwaysFalse()
			end,
		},
		{
			stateName = "Friendly_Searching",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Enemy_CharacterSelected",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "Enemy_Searching",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	EnemyTeamCodCaster:linkToElementModel(EnemyTeamCodCaster, "characterIndex", true, function(model)
		f1_local1:updateElementState(EnemyTeamCodCaster, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	EnemyTeamCodCaster:linkToElementModel(EnemyTeamCodCaster, "clientNum", true, function(model)
		f1_local1:updateElementState(EnemyTeamCodCaster, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	EnemyTeamCodCaster:setLeftRight(0.5, 0.5, -604.5, 604.5)
	EnemyTeamCodCaster:setTopBottom(0.5, 0.5, 134, 350)
	EnemyTeamCodCaster:setAlpha(0)
	EnemyTeamCodCaster:setScale(1.2, 1.2)
	EnemyTeamCodCaster:setWidgetType(CoD.PositionDraft_ViewTeams_CodCaster_Client)
	EnemyTeamCodCaster:setHorizontalCount(6)
	EnemyTeamCodCaster:setSpacing(15)
	EnemyTeamCodCaster:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(EnemyTeamCodCaster)
	self.EnemyTeamCodCaster = EnemyTeamCodCaster
	local FriendlyTeam = LUI.UIList.new(f1_local1, f1_arg0, 15, 0, nil, false, false, false, false)
	FriendlyTeam:mergeStateConditions({
		{
			stateName = "Friendly_Searching",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "Enemy_CharacterSelected",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Enemy_CharacterSelected_Hidden",
			condition = function(menu, element, event)
				local f24_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg0, "characterIndex") then
					f24_local0 = IsGametypeSettingsValue("draftHideEnemyTeam", 1)
					if f24_local0 then
						f24_local0 = AlwaysFalse()
					end
				else
					f24_local0 = false
				end
				return f24_local0
			end,
		},
		{
			stateName = "Enemy_ValidClient",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg0, "clientNum", 0) and AlwaysFalse()
			end,
		},
		{
			stateName = "Enemy_Searching",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	FriendlyTeam:linkToElementModel(FriendlyTeam, "characterIndex", true, function(model)
		f1_local1:updateElementState(FriendlyTeam, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	FriendlyTeam:linkToElementModel(FriendlyTeam, "clientNum", true, function(model)
		f1_local1:updateElementState(FriendlyTeam, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	FriendlyTeam:setLeftRight(0.5, 0.5, -604.5, 604.5)
	FriendlyTeam:setTopBottom(0.5, 0.5, -350, -134)
	FriendlyTeam:setScale(1.2, 1.2)
	FriendlyTeam:setWidgetType(CoD.PositionDraft_ViewTeams_Client)
	FriendlyTeam:setHorizontalCount(6)
	FriendlyTeam:setSpacing(15)
	FriendlyTeam:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	FriendlyTeam:setDataSource("Clients")
	self:addElement(FriendlyTeam)
	self.FriendlyTeam = FriendlyTeam
	local FriendlyTeamCodCaster = LUI.UIList.new(f1_local1, f1_arg0, 15, 0, nil, false, false, false, false)
	FriendlyTeamCodCaster:mergeStateConditions({
		{
			stateName = "Friendly_Searching",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "Enemy_CharacterSelected",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Enemy_ValidClient",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg0, "clientNum", 0) and AlwaysFalse()
			end,
		},
		{
			stateName = "Enemy_Searching",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	FriendlyTeamCodCaster:linkToElementModel(FriendlyTeamCodCaster, "characterIndex", true, function(model)
		f1_local1:updateElementState(FriendlyTeamCodCaster, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "characterIndex",
		})
	end)
	FriendlyTeamCodCaster:linkToElementModel(FriendlyTeamCodCaster, "clientNum", true, function(model)
		f1_local1:updateElementState(FriendlyTeamCodCaster, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	FriendlyTeamCodCaster:setLeftRight(0.5, 0.5, -604.5, 604.5)
	FriendlyTeamCodCaster:setTopBottom(0.5, 0.5, -350, -134)
	FriendlyTeamCodCaster:setAlpha(0)
	FriendlyTeamCodCaster:setScale(1.2, 1.2)
	FriendlyTeamCodCaster:setWidgetType(CoD.PositionDraft_ViewTeams_CodCaster_Client)
	FriendlyTeamCodCaster:setHorizontalCount(6)
	FriendlyTeamCodCaster:setSpacing(15)
	FriendlyTeamCodCaster:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(FriendlyTeamCodCaster)
	self.FriendlyTeamCodCaster = FriendlyTeamCodCaster
	local FrameL = CoD.GameEndScoreGraphicFrame.new(f1_local1, f1_arg0, 0.5, 0.5, -154, -78, 0.5, 0.5, -15.5, 15.5)
	self:addElement(FrameL)
	self.FrameL = FrameL
	local FrameR = CoD.GameEndScoreGraphicFrame.new(f1_local1, f1_arg0, 0.5, 0.5, 81, 151, 0.5, 0.5, -15.5, 15.5)
	FrameR:setYRot(180)
	self:addElement(FrameR)
	self.FrameR = FrameR
	local TeamStripBase = LUI.UIImage.new(-0, 1, 0, 0, 0.5, 0.5, -449, -415)
	TeamStripBase:setAlpha(0.15)
	TeamStripBase:setImage(RegisterImage(@"hash_530CAAA0A9615B70"))
	TeamStripBase:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	TeamStripBase:setShaderVector(0, 1.3, 1, 0, 0)
	TeamStripBase:setShaderVector(1, 0, 0, 0, 0)
	TeamStripBase:subscribeToGlobalModel(f1_arg0, "Factions", "alliesFactionColor", function(model)
		local f35_local0 = model:get()
		if f35_local0 ~= nil then
			TeamStripBase:setRGB(f35_local0)
		end
	end)
	self:addElement(TeamStripBase)
	self.TeamStripBase = TeamStripBase
	local f1_local22 = nil
	self.TeamStripGlow = LUI.UIElement.createFake()
	local TeamStripGlowPC = nil
	TeamStripGlowPC = LUI.UIImage.new(-0, 1, 0, 0, 0.5, 0.5, -449, -415)
	TeamStripGlowPC:setAlpha(0)
	TeamStripGlowPC:setXRot(180)
	TeamStripGlowPC:setImage(RegisterImage(@"hash_52485F8201F6B57A"))
	TeamStripGlowPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	TeamStripGlowPC:setShaderVector(0, 7, 1, 0, 0)
	TeamStripGlowPC:setShaderVector(1, 0, 1, 0, 1)
	TeamStripGlowPC:subscribeToGlobalModel(f1_arg0, "Factions", "alliesFactionColor", function(model)
		local f36_local0 = model:get()
		if f36_local0 ~= nil then
			TeamStripGlowPC:setRGB(f36_local0)
		end
	end)
	self:addElement(TeamStripGlowPC)
	self.TeamStripGlowPC = TeamStripGlowPC
	local EnemyStripBase = LUI.UIImage.new(-0, 1, 0, 0, 0.5, 0.5, 416, 450)
	EnemyStripBase:setAlpha(0.15)
	EnemyStripBase:setImage(RegisterImage(@"hash_530CAAA0A9615B70"))
	EnemyStripBase:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	EnemyStripBase:setShaderVector(0, 1.3, 1, 0, 0)
	EnemyStripBase:setShaderVector(1, 0, 0, 0, 0)
	EnemyStripBase:subscribeToGlobalModel(f1_arg0, "Factions", "axisFactionColor", function(model)
		local f37_local0 = model:get()
		if f37_local0 ~= nil then
			EnemyStripBase:setRGB(f37_local0)
		end
	end)
	self:addElement(EnemyStripBase)
	self.EnemyStripBase = EnemyStripBase
	local f1_local25 = nil
	self.EnemyStripGlow = LUI.UIElement.createFake()
	local EnemyStripGlowPC = nil
	EnemyStripGlowPC = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, 416, 450)
	EnemyStripGlowPC:setAlpha(0)
	EnemyStripGlowPC:setImage(RegisterImage(@"hash_52485F8201F6B57A"))
	EnemyStripGlowPC:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_17EA4827662D4CD4"))
	EnemyStripGlowPC:setShaderVector(0, 7, 1, 0, 0)
	EnemyStripGlowPC:setShaderVector(1, 0, 1, 0, 1)
	EnemyStripGlowPC:subscribeToGlobalModel(f1_arg0, "Factions", "axisFactionColor", function(model)
		local f38_local0 = model:get()
		if f38_local0 ~= nil then
			EnemyStripGlowPC:setRGB(f38_local0)
		end
	end)
	self:addElement(EnemyStripGlowPC)
	self.EnemyStripGlowPC = EnemyStripGlowPC
	self:mergeStateConditions({
		{
			stateName = "CodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg0)
			end,
		},
	})
	local f1_local27 = self
	local f1_local28 = self.subscribeToModel
	local f1_local29 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local28(f1_local27, f1_local29["factions.isCoDCaster"], function(f40_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f40_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"hash_972E7D1EB1EF77F", nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_back"], "TAB", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_back"], @"hash_0", nil, "TAB")
		return false
	end, false)
	EnemyTeam.id = "EnemyTeam"
	EnemyTeamCodCaster.id = "EnemyTeamCodCaster"
	FriendlyTeam.id = "FriendlyTeam"
	FriendlyTeamCodCaster.id = "FriendlyTeamCodCaster"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	f1_local28 = self
	if IsCodCaster(f1_arg0) then
		SetListDataSource(self.FriendlyTeamCodCaster, "Clients")
		SetListDataSource(self.EnemyTeamCodCaster, "Clients")
		CoD.ScoreboardUtility.SetupTeamLists(self, f1_arg0, self.FriendlyTeam, self.EnemyTeam, self.FriendlyTeamCodCaster, self.EnemyTeamCodCaster)
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	else
		SetListDataSource(self.FriendlyTeam, "Clients")
		SetListDataSource(self.EnemyTeam, "Clients")
		CoD.ScoreboardUtility.SetupTeamLists(self, f1_arg0, self.FriendlyTeam, self.EnemyTeam, self.FriendlyTeamCodCaster, self.EnemyTeamCodCaster)
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_Teams.__resetProperties = function(f45_arg0)
	f45_arg0.FriendlyTeamCodCaster:completeAnimation()
	f45_arg0.FriendlyTeam:completeAnimation()
	f45_arg0.EnemyTeamCodCaster:completeAnimation()
	f45_arg0.EnemyTeam:completeAnimation()
	f45_arg0.FriendlyTeamCodCaster:setAlpha(0)
	f45_arg0.FriendlyTeam:setAlpha(1)
	f45_arg0.EnemyTeamCodCaster:setAlpha(0)
	f45_arg0.EnemyTeam:setAlpha(1)
end
CoD.PositionDraft_Teams.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(0)
		end,
	},
	CodCaster = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(4)
			f47_arg0.EnemyTeam:completeAnimation()
			f47_arg0.EnemyTeam:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.EnemyTeam)
			f47_arg0.EnemyTeamCodCaster:completeAnimation()
			f47_arg0.EnemyTeamCodCaster:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.EnemyTeamCodCaster)
			f47_arg0.FriendlyTeam:completeAnimation()
			f47_arg0.FriendlyTeam:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.FriendlyTeam)
			f47_arg0.FriendlyTeamCodCaster:completeAnimation()
			f47_arg0.FriendlyTeamCodCaster:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.FriendlyTeamCodCaster)
		end,
	},
}
CoD.PositionDraft_Teams.__onClose = function(f48_arg0)
	f48_arg0.EnemyLineL:close()
	f48_arg0.EnemyLineL2:close()
	f48_arg0.FriendlyLineL:close()
	f48_arg0.FriendlyLineL2:close()
	f48_arg0.EnemyTeam:close()
	f48_arg0.EnemyTeamCodCaster:close()
	f48_arg0.FriendlyTeam:close()
	f48_arg0.FriendlyTeamCodCaster:close()
	f48_arg0.FrameL:close()
	f48_arg0.FrameR:close()
	f48_arg0.TeamStripBase:close()
	f48_arg0.TeamStripGlow:close()
	f48_arg0.TeamStripGlowPC:close()
	f48_arg0.EnemyStripBase:close()
	f48_arg0.EnemyStripGlow:close()
	f48_arg0.EnemyStripGlowPC:close()
end
