require("x64:7859c4946b9af3c")
require("x64:c048e011d7fa11c")
require("x64:330e1ef77701a18")
require("x64:e6df4068375d284")
require("x64:d4ed3fd8d1fcc4a")
require("x64:6db94b193106b49")
require("x64:6f28821b90063e7")
require("x64:89b288329dba477")
require("x64:92514cbf7a1331a")
require("x64:4a5838ec95b746d")
require("x64:498a68f2b1b5eae")
require("x64:79b12174795a64d")
require("x64:e199464e0d9b0fb")
require("x64:56b51f8588bf717")
require("x64:20ff2c6b0d39bc")
require("x64:eb940eea99212c2")
require("x64:782f4987ae21b5a")
require("x64:132e03577fedd0f")
require("x64:d6ecdf7755aeddc")
require("x64:2675595fa323085")
require("x64:e41af73729601d6")
require("x64:848cd399f32775f")
local f0_local0 = function(f1_arg0, f1_arg1)
	if not CoD.IsPC and IsSplitscreenAndInGame(f1_arg1) then
		f1_arg0.SelectedClassMiniPreview:setLeftRight(0, 1, 0, 0)
	end
end
CoD.PositionDraft = InheritFrom(CoD.Menu)
LUI.createMenu.PositionDraft = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("PositionDraft", f2_arg0)
	local f2_local1 = self
	SetProperty(self, "disablePopupOpenCloseAnim", true)
	SetPerControllerTableProperty(f2_arg0, "showHealthBars", false)
	SetProperty(self, "preserveLuiButton", {
		[Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1]] = true,
	})
	CoD.BaseUtility.InitControllerModel(f2_arg0, "isInPrematchPeriod", 0)
	CoD.BaseUtility.CreateControllerModel(f2_arg0, "gametypeObjectiveHint")
	CoD.BaseUtility.InitGlobalModel("PositionDraft.Clients.client.0.freeCursorTitle", "")
	CoD.BaseUtility.InitControllerModel(f2_arg0, "PositionDraft.focusedCharacterIndex", 0)
	CoD.BaseUtility.InitControllerModel(f2_arg0, "PositionDraft.focusedCharacterWeapon", "")
	CoD.BaseUtility.InitControllerModel(f2_arg0, "PositionDraft.focusedCharacterHasRestriction", false)
	CoD.BaseUtility.InitControllerModel(f2_arg0, "PositionDraft.focusedCharacterIsRestricted", false)
	CoD.BaseUtility.CreateControllerModel(f2_arg0, "PositionDraft.introPlayed")
	CoD.PlayerRoleUtility.SetPositionDraftSelectedCharacterIndex(f2_arg0)
	CoD.BaseUtility.InitControllerModel(f2_arg0, "PositionDraft.characterSelected", false)
	self:setClass(CoD.PositionDraft)
	self.soundSet = "default"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.anyChildUsesUpdateState = true
	f2_local1:addElementToPendingUpdateStateList(self)
	local f2_local2 = nil
	self.blurbackgroundSelectedClass = LUI.UIElement.createFake()
	local blurbackgroundSelectedClassPC = nil
	blurbackgroundSelectedClassPC = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -155, 95)
	blurbackgroundSelectedClassPC:setRGB(0, 0, 0)
	blurbackgroundSelectedClassPC:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blurbackgroundSelectedClassPC:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blurbackgroundSelectedClassPC)
	self.blurbackgroundSelectedClassPC = blurbackgroundSelectedClassPC
	local BLACKTint = LUI.UIImage.new(-0.1, 1.1, 0, 0, -0.14, 1.16, 0, 0)
	BLACKTint:setRGB(0, 0, 0)
	BLACKTint:setAlpha(0)
	self:addElement(BLACKTint)
	self.BLACKTint = BLACKTint
	local PositionDraftOverheadNameContainer = CoD.DynamicContainerWidget.new(f2_local1, f2_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(PositionDraftOverheadNameContainer)
	self.PositionDraftOverheadNameContainer = PositionDraftOverheadNameContainer
	local StatusTextBackground = CoD.PositionDraft_StatusBanner.new(f2_local1, f2_arg0, 0.5, 0.5, -968, 952, 0.5, 0.5, 94, 294)
	self:addElement(StatusTextBackground)
	self.StatusTextBackground = StatusTextBackground
	local StatusText = LUI.UIText.new(0.5, 0.5, -958.5, 958.5, 0.5, 0.5, 172, 220)
	StatusText:setText(LocalizeToUpperString(0x2D67DCCB863C991))
	StatusText:setTTF("ttmussels_regular")
	StatusText:setLetterSpacing(14.7)
	StatusText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	StatusText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(StatusText)
	self.StatusText = StatusText
	local CountdownTimerTintPanel = CoD.PositionDraft_CountdownTimerFUI.new(f2_local1, f2_arg0, 0.5, 0.5, -399, 401, 0.5, 0.5, 160, 480)
	CountdownTimerTintPanel:setAlpha(0)
	self:addElement(CountdownTimerTintPanel)
	self.CountdownTimerTintPanel = CountdownTimerTintPanel
	local CountdownTimer = LUI.UIText.new(0.5, 0.5, -119, 121, 0.5, 0.5, 260, 378)
	CountdownTimer:setAlpha(0)
	CountdownTimer:setScale(0.9, 0.9)
	CountdownTimer:setTTF("0arame_mono_stencil")
	CountdownTimer:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	CountdownTimer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CountdownTimer:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CountdownTimer:subscribeToGlobalModel(f2_arg0, "PositionDraft", "timeRemaining", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CountdownTimer:setText(f3_local0)
		end
	end)
	self:addElement(CountdownTimer)
	self.CountdownTimer = CountdownTimer
	local TransitionFade = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TransitionFade:setRGB(0, 0, 0)
	TransitionFade:setAlpha(0)
	self:addElement(TransitionFade)
	self.TransitionFade = TransitionFade
	local AutoDrafted = CoD.PositionDraft_AutoDrafted.new(f2_local1, f2_arg0, 0.5, 0.5, -205, 65, 0, 0, 174, 200)
	self:addElement(AutoDrafted)
	self.AutoDrafted = AutoDrafted
	local PositionDraftReadyButton = CoD.PositionDraft_ReadyButton.new(f2_local1, f2_arg0, 0.5, 0.5, -184, 184, 0.75, 0.75, -37.5, 37.5)
	PositionDraftReadyButton:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f2_arg0, "PositionDraft", "timeRemaining", 0)
			end,
		},
	})
	local PositionDraftEnemyStatus = PositionDraftReadyButton
	local CasterControls = PositionDraftReadyButton.subscribeToModel
	local f2_local15 = DataSources.PositionDraft.getModel(f2_arg0)
	CasterControls(PositionDraftEnemyStatus, f2_local15.timeRemaining, function(f5_arg0)
		f2_local1:updateElementState(PositionDraftReadyButton, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f5_arg0:get(),
			modelName = "timeRemaining",
		})
	end, false)
	PositionDraftReadyButton:subscribeToGlobalModel(f2_arg0, "PerController", "ButtonBits." .. Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], function(model)
		PositionDraftReadyButton:setModel(model, f2_arg0)
	end)
	self:addElement(PositionDraftReadyButton)
	self.PositionDraftReadyButton = PositionDraftReadyButton
	CasterControls = CoD.PositionDraft_CasterControls.new(f2_local1, f2_arg0, 0.5, 0.5, -180.5, 180.5, 0.66, 0.66, -79, -41)
	self:addElement(CasterControls)
	self.CasterControls = CasterControls
	PositionDraftEnemyStatus = CoD.PositionDraft_EnemyStatus.new(f2_local1, f2_arg0, 0.5, 0.5, -860, -460, 0.5, 0.5, 268, 358)
	self:addElement(PositionDraftEnemyStatus)
	self.PositionDraftEnemyStatus = PositionDraftEnemyStatus
	f2_local15 = nil
	f2_local15 = LUI.UIElement.createFake()
	self.SelectedClassMiniPreview = f2_local15
	local SelectedClassMiniPreviewPC = nil
	SelectedClassMiniPreviewPC = CoD.SelectedClassMiniPreview.new(f2_local1, f2_arg0, 0.5, 0.5, -960, 960, 1, 1, -190.5, 109.5)
	SelectedClassMiniPreviewPC.panelbacking:setAlpha(0.85)
	SelectedClassMiniPreviewPC.panelbackingTop:setAlpha(0.75)
	self:addElement(SelectedClassMiniPreviewPC)
	self.SelectedClassMiniPreviewPC = SelectedClassMiniPreviewPC
	local FooterContainerFrontendRight = CoD.FooterContainer_Ingame_Right.new(f2_local1, f2_arg0, 0, 1, 0, 0, 1, 1, -65, 0)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local f2_local18 = nil
	self.PositionDraftGametypeAndMap = LUI.UIElement.createFake()
	local PositionDraftSearchingForPlayers = CoD.PositionDraft_SearchingForPlayers.new(f2_local1, f2_arg0, 0.5, 0.5, 496, 1218, 1, 1, -106, -69)
	self:addElement(PositionDraftSearchingForPlayers)
	self.PositionDraftSearchingForPlayers = PositionDraftSearchingForPlayers
	local f2_local20 = nil
	self.RadialTimer = LUI.UIElement.createFake()
	local PositionDraftGametypeAndMapPC = nil
	PositionDraftGametypeAndMapPC = CoD.PositionDraft_GametypeAndMap.new(f2_local1, f2_arg0, 0.5, 0.5, 307, 1007, 0, 0, 70, 170)
	self:addElement(PositionDraftGametypeAndMapPC)
	self.PositionDraftGametypeAndMapPC = PositionDraftGametypeAndMapPC
	local RadialTimerPC = nil
	RadialTimerPC = CoD.RadialTimer.new(f2_local1, f2_arg0, 0.5, 0.5, 782, 932, 0, 0, 48, 198)
	RadialTimerPC:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueGreaterThan("PositionDraft.timeRemaining", 0)
			end,
		},
	})
	local FocusedCharacterInfo = RadialTimerPC
	local PositionDraftAttackDefend = RadialTimerPC.subscribeToModel
	local ChangeClassButton = Engine[0x8DF2E5447F384B9]()
	PositionDraftAttackDefend(FocusedCharacterInfo, ChangeClassButton["PositionDraft.timeRemaining"], function(f8_arg0)
		f2_local1:updateElementState(RadialTimerPC, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f8_arg0:get(),
			modelName = "PositionDraft.timeRemaining",
		})
	end, false)
	RadialTimerPC:subscribeToGlobalModel(f2_arg0, "PositionDraft", "timeRemaining", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			RadialTimerPC.Clock:setShaderVector(0, CoD.PlayerRoleUtility.DraftTimeRemainingClockFraction(0, 0, SetVectorComponent(0, 0, CoD.GetVectorComponentFromString(f9_local0, 1), CoD.GetVectorComponentFromString(f9_local0, 2), CoD.GetVectorComponentFromString(f9_local0, 3), CoD.GetVectorComponentFromString(f9_local0, 4))))
		end
	end)
	RadialTimerPC:subscribeToGlobalModel(f2_arg0, "PositionDraft", "timeRemaining", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			RadialTimerPC.TimeText:setText(f10_local0)
		end
	end)
	self:addElement(RadialTimerPC)
	self.RadialTimerPC = RadialTimerPC
	PositionDraftAttackDefend = CoD.PositionDraft_AttackDefend.new(f2_local1, f2_arg0, 0.5, 0.5, 573, 803, 0, 0, 45, 85)
	PositionDraftAttackDefend:setAlpha(0)
	self:addElement(PositionDraftAttackDefend)
	self.PositionDraftAttackDefend = PositionDraftAttackDefend
	FocusedCharacterInfo = CoD.PositionDraft_FocusedCharacterInfo.new(f2_local1, f2_arg0, 0.5, 0.5, -875, 326, 1, 1, -350, -140)
	FocusedCharacterInfo:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f11_local0 = CoD.ModelUtility.IsModelValueGreaterThan(f2_arg0, "PositionDraft.focusedCharacterIndex", 0)
				if f11_local0 then
					if not CoD.BountyHunterUtility.GameTypeHidesChooseClass(f2_arg0) and not CoD.HUDUtility.IsGameTypeBareBones() then
						f11_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("infect")
					else
						f11_local0 = false
					end
				end
				return f11_local0
			end,
		},
	})
	local Characters = FocusedCharacterInfo
	ChangeClassButton = FocusedCharacterInfo.subscribeToModel
	local PCVoiceChatWidget = Engine[0x4DF5CFBC1771947](f2_arg0)
	ChangeClassButton(Characters, PCVoiceChatWidget["PositionDraft.focusedCharacterIndex"], function(f12_arg0)
		f2_local1:updateElementState(FocusedCharacterInfo, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f12_arg0:get(),
			modelName = "PositionDraft.focusedCharacterIndex",
		})
	end, false)
	FocusedCharacterInfo:setAlpha(0)
	self:addElement(FocusedCharacterInfo)
	self.FocusedCharacterInfo = FocusedCharacterInfo
	ChangeClassButton = CoD.DirectorGenericButton.new(f2_local1, f2_arg0, 0.5, 0.5, 490, 740, 0.5, 0.5, 278.5, 370.5)
	ChangeClassButton:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not CoD.BountyHunterUtility.GameTypeHidesChooseClass(f2_arg0)
			end,
		},
	})
	ChangeClassButton:setAlpha(0)
	ChangeClassButton:setScale(0.8, 0.8)
	ChangeClassButton.DirectorSelectButtonMiniInternal.MiddleText:setText(LocalizeToUpperString(0x83E3BA6F8C2DB04))
	ChangeClassButton.DirectorSelectButtonMiniInternal.MiddleTextFocus:setText(LocalizeToUpperString(0x83E3BA6F8C2DB04))
	PCVoiceChatWidget = ChangeClassButton
	Characters = ChangeClassButton.subscribeToModel
	local CommonHeader = Engine[0x4DF5CFBC1771947](f2_arg0)
	Characters(PCVoiceChatWidget, CommonHeader["PositionDraft.stage"], function(f14_arg0, f14_arg1)
		CoD.Menu.UpdateButtonShownState(f14_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	PCVoiceChatWidget = ChangeClassButton
	Characters = ChangeClassButton.subscribeToModel
	CommonHeader = Engine[0x4DF5CFBC1771947](f2_arg0)
	Characters(PCVoiceChatWidget, CommonHeader["factions.isCoDCaster"], function(f15_arg0, f15_arg1)
		CoD.Menu.UpdateButtonShownState(f15_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	ChangeClassButton:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f16_local0
	end)
	f2_local1:AddButtonCallbackFunction(ChangeClassButton, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueLessThan(controller, "PositionDraft.stage", 6) and not CoD.BountyHunterUtility.GameTypeHidesChooseClass(controller) and not IsCodCaster(controller) then
			CoD.StartMenuUtility.ShowClassSelectSlideout(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueLessThan(controller, "PositionDraft.stage", 6) and not CoD.BountyHunterUtility.GameTypeHidesChooseClass(controller) and not IsCodCaster(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(ChangeClassButton)
	self.ChangeClassButton = ChangeClassButton
	Characters = CoD.PositionDraft_CharacterList.new(f2_local1, f2_arg0, 0.5, 0.5, 422, 811, 0.5, 0.5, -388.5, 250.5)
	self:addElement(Characters)
	self.Characters = Characters
	PCVoiceChatWidget = nil
	PCVoiceChatWidget = CoD.PCVoiceChatWidget.new(f2_local1, f2_arg0, 0.5, 0.5, -885, -455, 0, 0, 71, 171)
	self:addElement(PCVoiceChatWidget)
	self.PCVoiceChatWidget = PCVoiceChatWidget
	CommonHeader = nil
	CommonHeader = CoD.CommonHeader.new(f2_local1, f2_arg0, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(0x2D67DCCB863C991))
	CommonHeader:subscribeToGlobalModel(f2_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f19_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local TopBar = nil
	TopBar = CoD.header_container_frontend.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 0, 0, 42)
	self:addElement(TopBar)
	self.TopBar = TopBar
	local VoipContainerNoCompass = CoD.Voip_Container.new(f2_local1, f2_arg0, 0, 0, 27, 437, 0, 0, 22, 130)
	VoipContainerNoCompass:mergeStateConditions({
		{
			stateName = "HudStart",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "ShowForCodCaster",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	VoipContainerNoCompass:setAlpha(0)
	self:addElement(VoipContainerNoCompass)
	self.VoipContainerNoCompass = VoipContainerNoCompass
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f2_local1, f2_arg0, 0, 0, 98, 600, 0, 0, 400, 551)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	FocusedCharacterInfo:linkToElementModel(Characters.Characters, nil, false, function(model)
		FocusedCharacterInfo:setModel(model, f2_arg0)
	end)
	self:mergeStateConditions({
		{
			stateName = "DraftCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f2_arg0) and CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 3)
			end,
		},
		{
			stateName = "AllClientReadyCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f2_arg0) and CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 4)
			end,
		},
		{
			stateName = "MatchStartingCodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f2_arg0) and CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 6)
			end,
		},
		{
			stateName = "DraftPC",
			condition = function(menu, element, event)
				local f26_local0 = CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 3)
				if f26_local0 then
					f26_local0 = IsPC()
					if f26_local0 then
						f26_local0 = not CoD.ModelUtility.IsControllerModelValueTrue(f2_arg0, "PositionDraft.characterSelected")
					end
				end
				return f26_local0
			end,
		},
		{
			stateName = "MatchStartingPC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 6) and IsPC()
			end,
		},
		{
			stateName = "WaitingForPlayers",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 2) and CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.introPlayed", 1)
			end,
		},
		{
			stateName = "Draft",
			condition = function(menu, element, event)
				local f29_local0 = CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 3)
				if f29_local0 then
					if not IsPC() then
						f29_local0 = not CoD.ModelUtility.IsControllerModelValueTrue(f2_arg0, "PositionDraft.characterSelected")
					else
						f29_local0 = false
					end
				end
				return f29_local0
			end,
		},
		{
			stateName = "CharacterSelectedPC",
			condition = function(menu, element, event)
				local f30_local0
				if not IsMenuInState(menu, "EditLoadout") then
					f30_local0 = CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 3)
					if f30_local0 then
						f30_local0 = IsPC()
						if f30_local0 then
							f30_local0 = CoD.ModelUtility.IsControllerModelValueTrue(f2_arg0, "PositionDraft.characterSelected")
						end
					end
				else
					f30_local0 = false
				end
				return f30_local0
			end,
		},
		{
			stateName = "CharacterSelected",
			condition = function(menu, element, event)
				local f31_local0
				if not IsMenuInState(menu, "EditLoadout") then
					f31_local0 = CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 3)
					if f31_local0 then
						if not IsPC() then
							f31_local0 = CoD.ModelUtility.IsControllerModelValueTrue(f2_arg0, "PositionDraft.characterSelected")
						else
							f31_local0 = false
						end
					end
				else
					f31_local0 = false
				end
				return f31_local0
			end,
		},
		{
			stateName = "EditLoadout",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 3) and CoD.ModelUtility.IsControllerModelValueTrue(f2_arg0, "PositionDraft.characterSelected")
			end,
		},
		{
			stateName = "AllClientsReady",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 4)
			end,
		},
		{
			stateName = "MatchStarting",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f2_arg0, "PositionDraft.stage", 6) and not IsPC()
			end,
		},
	})
	local f2_local32 = self
	local f2_local33 = self.subscribeToModel
	local f2_local34 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local33(f2_local32, f2_local34["factions.isCoDCaster"], function(f35_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f35_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f2_local32 = self
	f2_local33 = self.subscribeToModel
	f2_local34 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local33(f2_local32, f2_local34["PositionDraft.stage"], function(f36_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f36_arg0:get(),
			modelName = "PositionDraft.stage",
		})
	end, false)
	f2_local32 = self
	f2_local33 = self.subscribeToModel
	f2_local34 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local33(f2_local32, f2_local34["PositionDraft.characterSelected"], function(f37_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f37_arg0:get(),
			modelName = "PositionDraft.characterSelected",
		})
	end, false)
	f2_local32 = self
	f2_local33 = self.subscribeToModel
	f2_local34 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local33(f2_local32, f2_local34["PositionDraft.introPlayed"], function(f38_arg0)
		f2_local1:updateElementState(self, {
			name = "model_validation",
			menu = f2_local1,
			controller = f2_arg0,
			modelValue = f38_arg0:get(),
			modelName = "PositionDraft.introPlayed",
		})
	end, false)
	self:appendEventHandler("record_curr_focused_elem_id", function(f39_arg0, f39_arg1)
		f39_arg1.menu = f39_arg1.menu or f2_local1
		CoD.Menu.UpdateButtonShownState(f39_arg0, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	f2_local32 = self
	f2_local33 = self.subscribeToModel
	f2_local34 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local33(f2_local32, f2_local34["PositionDraft.characterSelected"], function(f40_arg0, f40_arg1)
		CoD.Menu.UpdateButtonShownState(f40_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f2_local32 = self
	f2_local33 = self.subscribeToModel
	f2_local34 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local33(f2_local32, f2_local34["PositionDraft.stage"], function(f41_arg0, f41_arg1)
		CoD.Menu.UpdateButtonShownState(f41_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		CoD.Menu.UpdateButtonShownState(f41_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f41_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC])
		CoD.Menu.UpdateButtonShownState(f41_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
	end, false)
	f2_local32 = self
	f2_local33 = self.subscribeToModel
	f2_local34 = Engine[0x8DF2E5447F384B9]()
	f2_local33(f2_local32, f2_local34["lobbyRoot.lobbyNav"], function(f42_arg0, f42_arg1)
		CoD.Menu.UpdateButtonShownState(f42_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f42_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A])
	end, false)
	self:appendEventHandler("input_source_changed", function(f43_arg0, f43_arg1)
		f43_arg1.menu = f43_arg1.menu or f2_local1
		CoD.Menu.UpdateButtonShownState(f43_arg0, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f43_arg0, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A])
	end)
	f2_local32 = self
	f2_local33 = self.subscribeToModel
	f2_local34 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local33(f2_local32, f2_local34.LastInput, function(f44_arg0, f44_arg1)
		CoD.Menu.UpdateButtonShownState(f44_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA])
		CoD.Menu.UpdateButtonShownState(f44_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A])
	end, false)
	f2_local32 = self
	f2_local33 = self.subscribeToModel
	f2_local34 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local33(f2_local32, f2_local34["factions.isCoDCaster"], function(f45_arg0, f45_arg1)
		CoD.Menu.UpdateButtonShownState(f45_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x49A252B20B48936])
		CoD.Menu.UpdateButtonShownState(f45_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x493152B20AE4F58])
	end, false)
	f2_local32 = self
	f2_local33 = self.subscribeToModel
	f2_local34 = Engine[0x4DF5CFBC1771947](f2_arg0)
	f2_local33(f2_local32, f2_local34.isInPrematchPeriod, function(f46_arg0, f46_arg1)
		CoD.Menu.UpdateButtonShownState(f46_arg1, f2_local1, f2_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1])
	end, false)
	self:registerEventHandler("menu_loaded", function(self, event)
		local f47_local0 = nil
		if self.menuLoaded then
			f47_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f47_local0 = self.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(self, f2_arg0)
		end
		if not f47_local0 then
			f47_local0 = self:dispatchEventToChildren(event)
		end
		return f47_local0
	end)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		if not PlayerReadiedUp(controller) and IsElementInAnyState(menu, "CharacterSelectedPC", "CharacterSelected") then
			ChangeCharacter(self, element, controller, -1)
			SetControllerModelValue(controller, "PositionDraft.characterSelected", false)
			ClearRecordedFocus(menu, controller)
			PlaySoundSetSound(self, "partyease_slide_right")
			return true
		elseif IsMenuInState(menu, "EditLoadout") then
			SetLoseFocusToElement(self, "StartMenuEditLoadout", controller)
			SetState(self, "CharacterSelected", controller)
			SaveLoadout(self, controller)
			SendClientScriptNotify(controller, "PositionDraft_Loadout", "0")
			PlaySoundSetSound(self, "menu_go_back")
			return true
		else
		end
	end, function(element, menu, controller)
		if not PlayerReadiedUp(controller) and IsElementInAnyState(menu, "CharacterSelectedPC", "CharacterSelected") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ESCAPE")
			return true
		elseif IsMenuInState(menu, "EditLoadout") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x503EA7AC6A9A9DB, nil, "ESCAPE")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		if CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "PositionDraftReadyButton") and CoD.BaseUtility.IsWidgetVisible(self.PositionDraftReadyButton) and CoD.ModelUtility.IsControllerModelValueTrue(controller, "PositionDraft.characterSelected") then
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BaseUtility.DoesElementOrChildHaveFocus(self, "PositionDraftReadyButton") and CoD.BaseUtility.IsWidgetVisible(self.PositionDraftReadyButton) and CoD.ModelUtility.IsControllerModelValueTrue(controller, "PositionDraft.characterSelected") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 750 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x22361E23588705A], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsModelValueEqualTo(controller, "PositionDraft.stage", 6) and not IsPC() then
			CoD.HUDUtility.OpenStartMenu(self, controller)
			return true
		elseif not CoD.ModelUtility.IsModelValueEqualTo(controller, "PositionDraft.stage", 6) and IsCustomLobby() and IsGamepad(controller) and IsPC() then
			CoD.HUDUtility.OpenStartMenu(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsModelValueEqualTo(controller, "PositionDraft.stage", 6) and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x0, nil, nil)
			return false
		elseif not CoD.ModelUtility.IsModelValueEqualTo(controller, "PositionDraft.stage", 6) and IsCustomLobby() and IsGamepad(controller) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0xE3B1996EF83F7ED, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "ui_contextual_2", function(element, menu, controller, model)
		if not CoD.ModelUtility.IsModelValueEqualTo(controller, "PositionDraft.stage", 6) and IsCustomLobby() and IsMouseOrKeyboard(controller) then
			CoD.HUDUtility.OpenStartMenu(self, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsModelValueEqualTo(controller, "PositionDraft.stage", 6) and IsCustomLobby() and IsMouseOrKeyboard(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0xE3B1996EF83F7ED, nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x49A252B20B48936], "MOUSE2", function(element, menu, controller, model)
		if IsCodCaster(controller) and not IsRepeatButtonPress(model) then
			AdjustShoutcasterTeam(self, element, controller, 1)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsCodCaster(controller) and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x49A252B20B48936], 0xF0DF87756796D4E, nil, "MOUSE2")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x493152B20AE4F58], "MOUSE1", function(element, menu, controller, model)
		if IsCodCaster(controller) and not IsRepeatButtonPress(model) then
			AdjustShoutcasterTeam(self, element, controller, -1)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsCodCaster(controller) and not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x493152B20AE4F58], 0xAF729B503010BCA, nil, "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "F1", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) and CoD.ModelUtility.IsModelValueLessThan(controller, "PositionDraft.stage", 6) and AlwaysFalse() then
			CoD.StartMenuUtility.ShowClassSelectSlideout(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) and CoD.ModelUtility.IsModelValueLessThan(controller, "PositionDraft.stage", 6) and AlwaysFalse() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, "F1")
			return false
		else
			return false
		end
	end, false)
	f2_local1:AddButtonCallbackFunction(self, f2_arg0, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], "TAB", function(element, menu, controller, model)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "isInPrematchPeriod", 1) and CoD.ModelUtility.IsModelValueLessThanOrEqualTo(controller, "PositionDraft.stage", 3) and IsGametypeTeambased() then
			OpenOverlay(self, "PositionDraft_Teams", controller, nil)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsModelValueEqualTo(controller, "isInPrematchPeriod", 1) and CoD.ModelUtility.IsModelValueLessThanOrEqualTo(controller, "PositionDraft.stage", 3) and IsGametypeTeambased() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], 0x7B9BD9B1628B977, nil, "TAB")
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		SetPerControllerTableProperty(f2_arg0, "showHealthBars", true)
	end)
	self.__on_menuOpened_self = function(f65_arg0, f65_arg1, f65_arg2, f65_arg3)
		local f65_local0 = self
		CoD.PlayerRoleUtility.UpdatePositionDraftModels(f65_arg1)
	end
	f2_local1:addMenuOpenedCallback(self.__on_menuOpened_self)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f66_arg2, f66_arg3, f66_arg4)
		if IsMenuInState(f2_local1, "Draft") then
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f2_local1, self.Characters, controller)
			CheckDefaultPCFocus(self.Characters, f2_local1, controller)
			UpdateButtonPromptState(f2_local1, element, controller, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
			UpdateButtonPromptState(f2_local1, element, controller, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
			ClearButtonsFlags(f2_local1, "MOUSE1", true)
		elseif IsMenuInState(f2_local1, "CharacterSelected") then
			CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f2_local1, self.ChangeClassButton, controller)
			CheckDefaultPCFocus(self.ChangeClassButton, f2_local1, controller)
			UpdateButtonPromptState(f2_local1, element, controller, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
			UpdateButtonPromptState(f2_local1, element, controller, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
			UpdateButtonPromptState(f2_local1, element, controller, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
		else
			UpdateButtonPromptState(f2_local1, element, controller, Enum[0x3DD78803F918E9D][0xE6DB407A2AF8B09])
			UpdateButtonPromptState(f2_local1, element, controller, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A])
			UpdateButtonPromptState(f2_local1, element, controller, Enum[0x3DD78803F918E9D][0x4D2505E19049444])
			CoD.FreeCursorUtility.RetriggerCursorPosition(f2_local1, controller)
		end
	end)
	PositionDraftReadyButton.id = "PositionDraftReadyButton"
	f2_local15.id = "SelectedClassMiniPreview"
	if CoD.isPC then
		SelectedClassMiniPreviewPC.id = "SelectedClassMiniPreviewPC"
	end
	FooterContainerFrontendRight:setModel(self.buttonModel, f2_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	ChangeClassButton.id = "ChangeClassButton"
	Characters.id = "Characters"
	if CoD.isPC then
		PCVoiceChatWidget.id = "PCVoiceChatWidget"
	end
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	self.__defaultFocus = ChangeClassButton
	if CoD.isPC and (IsKeyboard(f2_arg0) or self.ignoreCursor) then
		self:restoreState(f2_arg0)
	end
	self.__on_close_removeOverrides = function()
		f2_local1:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if f0_local0 then
		f0_local0(self, f2_arg0)
	end
	f2_local33 = self
	CoD.PlayerRoleUtility.PositionDraftPostLoad(self, f2_arg0)
	CoD.HUDUtility.InitOverheadNamesDraft(self, f2_arg0, "PositionDraftOverheadNameContainer")
	CoD.StartMenuUtility.AddClassSelectSlideout(f2_local1, f2_arg0)
	f2_local33 = BLACKTint
	if IsPC() then
		SizeToWidthOfScreen(f2_local33, f2_arg0)
	elseif IsSplitscreenAndInGame(f2_arg0) then
		SizeToWidthOfScreen(f2_local33, f2_arg0)
	end
	f2_local33 = TransitionFade
	if IsPC() then
		SizeToWidthOfScreen(f2_local33, f2_arg0)
	elseif IsSplitscreenAndInGame(f2_arg0) then
		SizeToWidthOfScreen(f2_local33, f2_arg0)
	end
	f2_local33 = PCVoiceChatWidget
	if IsPC() then
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.down, f2_local33, self.Characters)
	end
	f2_local33 = emptyFocusable
	if IsPC() then
		CoD.PCUtility.SetAsRedirectItem(f2_local33)
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.up, f2_local33, self.Characters)
	end
	return self
end
CoD.PositionDraft.__resetProperties = function(f68_arg0)
	f68_arg0.StatusText:completeAnimation()
	f68_arg0.BLACKTint:completeAnimation()
	f68_arg0.AutoDrafted:completeAnimation()
	f68_arg0.PositionDraftReadyButton:completeAnimation()
	f68_arg0.CasterControls:completeAnimation()
	f68_arg0.TransitionFade:completeAnimation()
	f68_arg0.PositionDraftEnemyStatus:completeAnimation()
	f68_arg0.CountdownTimer:completeAnimation()
	f68_arg0.Characters:completeAnimation()
	f68_arg0.StatusTextBackground:completeAnimation()
	f68_arg0.FocusedCharacterInfo:completeAnimation()
	f68_arg0.ChangeClassButton:completeAnimation()
	f68_arg0.PositionDraftSearchingForPlayers:completeAnimation()
	f68_arg0.PositionDraftGametypeAndMap:completeAnimation()
	f68_arg0.PCVoiceChatWidget:completeAnimation()
	f68_arg0.SelectedClassMiniPreviewPC:completeAnimation()
	f68_arg0.SelectedClassMiniPreview:completeAnimation()
	f68_arg0.blurbackgroundSelectedClassPC:completeAnimation()
	f68_arg0.blurbackgroundSelectedClass:completeAnimation()
	f68_arg0.PositionDraftAttackDefend:completeAnimation()
	f68_arg0.RadialTimer:completeAnimation()
	f68_arg0.CountdownTimerTintPanel:completeAnimation()
	f68_arg0.PositionDraftOverheadNameContainer:completeAnimation()
	f68_arg0.VoipContainerNoCompass:completeAnimation()
	f68_arg0.StatusText:setTopBottom(0.5, 0.5, 172, 220)
	f68_arg0.StatusText:setRGB(1, 1, 1)
	f68_arg0.StatusText:setAlpha(1)
	f68_arg0.StatusText:setText(LocalizeToUpperString(0x2D67DCCB863C991))
	f68_arg0.StatusText:setLetterSpacing(14.7)
	f68_arg0.BLACKTint:setAlpha(0)
	f68_arg0.AutoDrafted:setAlpha(1)
	f68_arg0.PositionDraftReadyButton:setLeftRight(0.5, 0.5, -184, 184)
	f68_arg0.PositionDraftReadyButton:setTopBottom(0.75, 0.75, -37.5, 37.5)
	f68_arg0.PositionDraftReadyButton:setAlpha(1)
	f68_arg0.CasterControls:setTopBottom(0.66, 0.66, -79, -41)
	f68_arg0.CasterControls:setAlpha(1)
	f68_arg0.TransitionFade:setAlpha(0)
	f68_arg0.PositionDraftEnemyStatus:setLeftRight(0.5, 0.5, -860, -460)
	f68_arg0.PositionDraftEnemyStatus:setTopBottom(0.5, 0.5, 268, 358)
	f68_arg0.PositionDraftEnemyStatus:setAlpha(1)
	f68_arg0.CountdownTimer:setLeftRight(0.5, 0.5, -119, 121)
	f68_arg0.CountdownTimer:setTopBottom(0.5, 0.5, 260, 378)
	f68_arg0.CountdownTimer:setAlpha(0)
	f68_arg0.Characters:setAlpha(1)
	f68_arg0.StatusTextBackground:setLeftRight(0.5, 0.5, -968, 952)
	f68_arg0.StatusTextBackground:setTopBottom(0.5, 0.5, 94, 294)
	f68_arg0.StatusTextBackground:setRGB(1, 1, 1)
	f68_arg0.StatusTextBackground:setAlpha(1)
	f68_arg0.FocusedCharacterInfo:setTopBottom(1, 1, -350, -140)
	f68_arg0.FocusedCharacterInfo:setAlpha(0)
	f68_arg0.ChangeClassButton:setLeftRight(0.5, 0.5, 490, 740)
	f68_arg0.ChangeClassButton:setTopBottom(0.5, 0.5, 278.5, 370.5)
	f68_arg0.ChangeClassButton:setAlpha(0)
	f68_arg0.PositionDraftSearchingForPlayers:setLeftRight(0.5, 0.5, 496, 1218)
	f68_arg0.PositionDraftGametypeAndMap:setAlpha(1)
	f68_arg0.PCVoiceChatWidget:setAlpha(1)
	f68_arg0.SelectedClassMiniPreviewPC:setTopBottom(1, 1, -190.5, 109.5)
	f68_arg0.SelectedClassMiniPreviewPC:setAlpha(1)
	f68_arg0.SelectedClassMiniPreview:setAlpha(1)
	f68_arg0.blurbackgroundSelectedClassPC:setAlpha(1)
	f68_arg0.blurbackgroundSelectedClass:setAlpha(1)
	f68_arg0.PositionDraftAttackDefend:setAlpha(0)
	f68_arg0.RadialTimer:setAlpha(1)
	f68_arg0.CountdownTimerTintPanel:setLeftRight(0.5, 0.5, -399, 401)
	f68_arg0.CountdownTimerTintPanel:setTopBottom(0.5, 0.5, 160, 480)
	f68_arg0.CountdownTimerTintPanel:setAlpha(0)
	f68_arg0.PositionDraftOverheadNameContainer:setAlpha(1)
	f68_arg0.VoipContainerNoCompass:setAlpha(0)
end
CoD.PositionDraft.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f69_arg0, f69_arg1)
			f69_arg0:__resetProperties()
			f69_arg0:setupElementClipCounter(13)
			f69_arg0.BLACKTint:completeAnimation()
			f69_arg0.BLACKTint:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.BLACKTint)
			f69_arg0.StatusTextBackground:completeAnimation()
			f69_arg0.StatusTextBackground:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.StatusTextBackground)
			f69_arg0.StatusText:completeAnimation()
			f69_arg0.StatusText:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.StatusText)
			f69_arg0.CountdownTimer:completeAnimation()
			f69_arg0.CountdownTimer:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.CountdownTimer)
			f69_arg0.TransitionFade:completeAnimation()
			f69_arg0.TransitionFade:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.TransitionFade)
			f69_arg0.AutoDrafted:completeAnimation()
			f69_arg0.AutoDrafted:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.AutoDrafted)
			f69_arg0.PositionDraftReadyButton:completeAnimation()
			f69_arg0.PositionDraftReadyButton:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.PositionDraftReadyButton)
			f69_arg0.CasterControls:completeAnimation()
			f69_arg0.CasterControls:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.CasterControls)
			f69_arg0.PositionDraftEnemyStatus:completeAnimation()
			f69_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.PositionDraftEnemyStatus)
			f69_arg0.PositionDraftSearchingForPlayers:completeAnimation()
			f69_arg0.PositionDraftSearchingForPlayers:setLeftRight(0.5, 0.5, 442, 1164)
			f69_arg0.clipFinished(f69_arg0.PositionDraftSearchingForPlayers)
			f69_arg0.FocusedCharacterInfo:completeAnimation()
			f69_arg0.FocusedCharacterInfo:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.FocusedCharacterInfo)
			f69_arg0.ChangeClassButton:completeAnimation()
			f69_arg0.ChangeClassButton:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.ChangeClassButton)
			f69_arg0.Characters:completeAnimation()
			f69_arg0.Characters:setAlpha(0)
			f69_arg0.clipFinished(f69_arg0.Characters)
		end,
	},
	DraftCodCaster = {
		DefaultClip = function(f70_arg0, f70_arg1)
			f70_arg0:__resetProperties()
			f70_arg0:setupElementClipCounter(11)
			f70_arg0.blurbackgroundSelectedClass:completeAnimation()
			f70_arg0.blurbackgroundSelectedClass:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.blurbackgroundSelectedClass)
			f70_arg0.blurbackgroundSelectedClassPC:completeAnimation()
			f70_arg0.blurbackgroundSelectedClassPC:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.blurbackgroundSelectedClassPC)
			f70_arg0.BLACKTint:completeAnimation()
			f70_arg0.BLACKTint:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.BLACKTint)
			f70_arg0.StatusTextBackground:completeAnimation()
			f70_arg0.StatusTextBackground:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.StatusTextBackground)
			f70_arg0.StatusText:completeAnimation()
			f70_arg0.StatusText:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.StatusText)
			f70_arg0.PositionDraftReadyButton:completeAnimation()
			f70_arg0.PositionDraftReadyButton:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.PositionDraftReadyButton)
			f70_arg0.PositionDraftEnemyStatus:completeAnimation()
			f70_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.PositionDraftEnemyStatus)
			f70_arg0.SelectedClassMiniPreview:completeAnimation()
			f70_arg0.SelectedClassMiniPreview:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.SelectedClassMiniPreview)
			f70_arg0.SelectedClassMiniPreviewPC:completeAnimation()
			f70_arg0.SelectedClassMiniPreviewPC:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.SelectedClassMiniPreviewPC)
			f70_arg0.PositionDraftGametypeAndMap:completeAnimation()
			f70_arg0.PositionDraftGametypeAndMap:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.PositionDraftGametypeAndMap)
			f70_arg0.FocusedCharacterInfo:completeAnimation()
			f70_arg0.FocusedCharacterInfo:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.FocusedCharacterInfo)
			f70_arg0.ChangeClassButton:completeAnimation()
			f70_arg0.ChangeClassButton:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.ChangeClassButton)
			f70_arg0.Characters:completeAnimation()
			f70_arg0.Characters:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.Characters)
			f70_arg0.PCVoiceChatWidget:completeAnimation()
			f70_arg0.PCVoiceChatWidget:setAlpha(0)
			f70_arg0.clipFinished(f70_arg0.PCVoiceChatWidget)
		end,
	},
	AllClientReadyCodCaster = {
		DefaultClip = function(f71_arg0, f71_arg1)
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter(9)
			f71_arg0.blurbackgroundSelectedClass:completeAnimation()
			f71_arg0.blurbackgroundSelectedClass:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.blurbackgroundSelectedClass)
			f71_arg0.blurbackgroundSelectedClassPC:completeAnimation()
			f71_arg0.blurbackgroundSelectedClassPC:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.blurbackgroundSelectedClassPC)
			f71_arg0.BLACKTint:completeAnimation()
			f71_arg0.BLACKTint:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.BLACKTint)
			f71_arg0.PositionDraftReadyButton:completeAnimation()
			f71_arg0.PositionDraftReadyButton:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.PositionDraftReadyButton)
			f71_arg0.PositionDraftEnemyStatus:completeAnimation()
			f71_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.PositionDraftEnemyStatus)
			f71_arg0.SelectedClassMiniPreview:completeAnimation()
			f71_arg0.SelectedClassMiniPreview:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.SelectedClassMiniPreview)
			f71_arg0.SelectedClassMiniPreviewPC:completeAnimation()
			f71_arg0.SelectedClassMiniPreviewPC:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.SelectedClassMiniPreviewPC)
			f71_arg0.FocusedCharacterInfo:completeAnimation()
			f71_arg0.FocusedCharacterInfo:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.FocusedCharacterInfo)
			f71_arg0.ChangeClassButton:completeAnimation()
			f71_arg0.ChangeClassButton:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.ChangeClassButton)
			f71_arg0.Characters:completeAnimation()
			f71_arg0.Characters:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.Characters)
			f71_arg0.PCVoiceChatWidget:completeAnimation()
			f71_arg0.PCVoiceChatWidget:setAlpha(0)
			f71_arg0.clipFinished(f71_arg0.PCVoiceChatWidget)
		end,
	},
	MatchStartingCodCaster = {
		DefaultClip = function(f72_arg0, f72_arg1)
			f72_arg0:__resetProperties()
			f72_arg0:setupElementClipCounter(13)
			f72_arg0.blurbackgroundSelectedClass:completeAnimation()
			f72_arg0.blurbackgroundSelectedClass:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.blurbackgroundSelectedClass)
			f72_arg0.blurbackgroundSelectedClassPC:completeAnimation()
			f72_arg0.blurbackgroundSelectedClassPC:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.blurbackgroundSelectedClassPC)
			local f72_local0 = function(f73_arg0)
				local f73_local0 = function(f74_arg0)
					f74_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f74_arg0:setAlpha(1)
					f74_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.StatusTextBackground:beginAnimation(300)
				f72_arg0.StatusTextBackground:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.StatusTextBackground:registerEventHandler("transition_complete_keyframe", f73_local0)
			end
			f72_arg0.StatusTextBackground:completeAnimation()
			f72_arg0.StatusTextBackground:setAlpha(0)
			f72_local0(f72_arg0.StatusTextBackground)
			local f72_local1 = function(f75_arg0)
				local f75_local0 = function(f76_arg0)
					f76_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f76_arg0:setAlpha(1)
					f76_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.StatusText:beginAnimation(500)
				f72_arg0.StatusText:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f75_local0)
			end
			f72_arg0.StatusText:completeAnimation()
			f72_arg0.StatusText:setRGB(0.4, 0.55, 0.22)
			f72_arg0.StatusText:setAlpha(0)
			f72_arg0.StatusText:setText(LocalizeToUpperString(0x8E58CC95DB34427))
			f72_local1(f72_arg0.StatusText)
			local f72_local2 = function(f77_arg0)
				local f77_local0 = function(f78_arg0)
					f78_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f78_arg0:setAlpha(0.7)
					f78_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.CountdownTimerTintPanel:beginAnimation(300)
				f72_arg0.CountdownTimerTintPanel:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.CountdownTimerTintPanel:registerEventHandler("transition_complete_keyframe", f77_local0)
			end
			f72_arg0.CountdownTimerTintPanel:completeAnimation()
			f72_arg0.CountdownTimerTintPanel:setAlpha(0)
			f72_local2(f72_arg0.CountdownTimerTintPanel)
			local f72_local3 = function(f79_arg0)
				local f79_local0 = function(f80_arg0)
					f80_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f80_arg0:setAlpha(0.9)
					f80_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.CountdownTimer:beginAnimation(500)
				f72_arg0.CountdownTimer:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.CountdownTimer:registerEventHandler("transition_complete_keyframe", f79_local0)
			end
			f72_arg0.CountdownTimer:completeAnimation()
			f72_arg0.CountdownTimer:setAlpha(0)
			f72_local3(f72_arg0.CountdownTimer)
			local f72_local4 = function(f81_arg0)
				local f81_local0 = function(f82_arg0)
					f82_arg0:beginAnimation(700)
					f82_arg0:setAlpha(1)
					f82_arg0:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
				end
				f72_arg0.AutoDrafted:beginAnimation(300)
				f72_arg0.AutoDrafted:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.AutoDrafted:registerEventHandler("transition_complete_keyframe", f81_local0)
			end
			f72_arg0.AutoDrafted:completeAnimation()
			f72_arg0.AutoDrafted:setAlpha(0)
			f72_local4(f72_arg0.AutoDrafted)
			f72_arg0.PositionDraftReadyButton:completeAnimation()
			f72_arg0.PositionDraftReadyButton:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.PositionDraftReadyButton)
			f72_arg0.PositionDraftEnemyStatus:completeAnimation()
			f72_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.PositionDraftEnemyStatus)
			f72_arg0.SelectedClassMiniPreview:completeAnimation()
			f72_arg0.SelectedClassMiniPreview:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.SelectedClassMiniPreview)
			local f72_local5 = function(f83_arg0)
				f72_arg0.SelectedClassMiniPreviewPC:beginAnimation(1010)
				f72_arg0.SelectedClassMiniPreviewPC:registerEventHandler("interrupted_keyframe", f72_arg0.clipInterrupted)
				f72_arg0.SelectedClassMiniPreviewPC:registerEventHandler("transition_complete_keyframe", f72_arg0.clipFinished)
			end
			f72_arg0.SelectedClassMiniPreviewPC:completeAnimation()
			f72_arg0.SelectedClassMiniPreviewPC:setTopBottom(1, 1, -183.5, 116.5)
			f72_arg0.SelectedClassMiniPreviewPC:setAlpha(0)
			f72_local5(f72_arg0.SelectedClassMiniPreviewPC)
			f72_arg0.RadialTimer:completeAnimation()
			f72_arg0.RadialTimer:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.RadialTimer)
			f72_arg0.PositionDraftAttackDefend:completeAnimation()
			f72_arg0.PositionDraftAttackDefend:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.PositionDraftAttackDefend)
			f72_arg0.ChangeClassButton:completeAnimation()
			f72_arg0.ChangeClassButton:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.ChangeClassButton)
			f72_arg0.Characters:completeAnimation()
			f72_arg0.Characters:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.Characters)
			f72_arg0.PCVoiceChatWidget:completeAnimation()
			f72_arg0.PCVoiceChatWidget:setAlpha(0)
			f72_arg0.clipFinished(f72_arg0.PCVoiceChatWidget)
		end,
		OneSecondRemaining = function(f84_arg0, f84_arg1)
			f84_arg0:__resetProperties()
			f84_arg0:setupElementClipCounter(12)
			f84_arg0.blurbackgroundSelectedClass:completeAnimation()
			f84_arg0.blurbackgroundSelectedClass:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.blurbackgroundSelectedClass)
			f84_arg0.blurbackgroundSelectedClassPC:completeAnimation()
			f84_arg0.blurbackgroundSelectedClassPC:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.blurbackgroundSelectedClassPC)
			f84_arg0.StatusTextBackground:completeAnimation()
			f84_arg0.clipFinished(f84_arg0.StatusTextBackground)
			f84_arg0.StatusText:completeAnimation()
			f84_arg0.StatusText:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f84_arg0.StatusText:setAlpha(1)
			f84_arg0.StatusText:setText(LocalizeToUpperString(0x8E58CC95DB34427))
			f84_arg0.clipFinished(f84_arg0.StatusText)
			f84_arg0.CountdownTimerTintPanel:completeAnimation()
			f84_arg0.CountdownTimerTintPanel:setAlpha(1)
			f84_arg0.clipFinished(f84_arg0.CountdownTimerTintPanel)
			f84_arg0.CountdownTimer:completeAnimation()
			f84_arg0.CountdownTimer:setAlpha(0.9)
			f84_arg0.clipFinished(f84_arg0.CountdownTimer)
			local f84_local0 = function(f85_arg0)
				local f85_local0 = function(f86_arg0)
					f86_arg0:beginAnimation(160)
					f86_arg0:setAlpha(1)
					f86_arg0:registerEventHandler("transition_complete_keyframe", f84_arg0.clipFinished)
				end
				f84_arg0.TransitionFade:beginAnimation(840)
				f84_arg0.TransitionFade:registerEventHandler("interrupted_keyframe", f84_arg0.clipInterrupted)
				f84_arg0.TransitionFade:registerEventHandler("transition_complete_keyframe", f85_local0)
			end
			f84_arg0.TransitionFade:completeAnimation()
			f84_arg0.TransitionFade:setAlpha(0)
			f84_local0(f84_arg0.TransitionFade)
			f84_arg0.PositionDraftReadyButton:completeAnimation()
			f84_arg0.PositionDraftReadyButton:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.PositionDraftReadyButton)
			f84_arg0.PositionDraftEnemyStatus:completeAnimation()
			f84_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.PositionDraftEnemyStatus)
			f84_arg0.SelectedClassMiniPreview:completeAnimation()
			f84_arg0.SelectedClassMiniPreview:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.SelectedClassMiniPreview)
			f84_arg0.SelectedClassMiniPreviewPC:completeAnimation()
			f84_arg0.SelectedClassMiniPreviewPC:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.SelectedClassMiniPreviewPC)
			f84_arg0.PositionDraftGametypeAndMap:completeAnimation()
			f84_arg0.PositionDraftGametypeAndMap:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.PositionDraftGametypeAndMap)
			f84_arg0.RadialTimer:completeAnimation()
			f84_arg0.RadialTimer:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.RadialTimer)
			f84_arg0.PositionDraftAttackDefend:completeAnimation()
			f84_arg0.PositionDraftAttackDefend:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.PositionDraftAttackDefend)
			f84_arg0.Characters:completeAnimation()
			f84_arg0.Characters:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.Characters)
			f84_arg0.PCVoiceChatWidget:completeAnimation()
			f84_arg0.PCVoiceChatWidget:setAlpha(0)
			f84_arg0.clipFinished(f84_arg0.PCVoiceChatWidget)
		end,
	},
	DraftPC = {
		DefaultClip = function(f87_arg0, f87_arg1)
			f87_arg0:__resetProperties()
			f87_arg0:setupElementClipCounter(10)
			f87_arg0.BLACKTint:completeAnimation()
			f87_arg0.BLACKTint:setAlpha(0)
			f87_arg0.clipFinished(f87_arg0.BLACKTint)
			f87_arg0.StatusTextBackground:completeAnimation()
			f87_arg0.StatusTextBackground:setAlpha(0)
			f87_arg0.clipFinished(f87_arg0.StatusTextBackground)
			f87_arg0.StatusText:completeAnimation()
			f87_arg0.StatusText:setAlpha(0)
			f87_arg0.clipFinished(f87_arg0.StatusText)
			f87_arg0.AutoDrafted:completeAnimation()
			f87_arg0.AutoDrafted:setAlpha(0)
			f87_arg0.clipFinished(f87_arg0.AutoDrafted)
			f87_arg0.PositionDraftReadyButton:completeAnimation()
			f87_arg0.PositionDraftReadyButton:setAlpha(0)
			f87_arg0.clipFinished(f87_arg0.PositionDraftReadyButton)
			f87_arg0.CasterControls:completeAnimation()
			f87_arg0.CasterControls:setAlpha(0)
			f87_arg0.clipFinished(f87_arg0.CasterControls)
			f87_arg0.PositionDraftEnemyStatus:completeAnimation()
			f87_arg0.PositionDraftEnemyStatus:setLeftRight(0.5, 0.5, -649, -249)
			f87_arg0.PositionDraftEnemyStatus:setTopBottom(0.5, 0.5, 255, 345)
			f87_arg0.PositionDraftEnemyStatus:setAlpha(1)
			f87_arg0.clipFinished(f87_arg0.PositionDraftEnemyStatus)
			f87_arg0.RadialTimer:completeAnimation()
			f87_arg0.RadialTimer:setAlpha(1)
			f87_arg0.clipFinished(f87_arg0.RadialTimer)
			f87_arg0.FocusedCharacterInfo:completeAnimation()
			f87_arg0.FocusedCharacterInfo:setTopBottom(1, 1, -508.5, -298.5)
			f87_arg0.FocusedCharacterInfo:setAlpha(1)
			f87_arg0.clipFinished(f87_arg0.FocusedCharacterInfo)
			f87_arg0.ChangeClassButton:completeAnimation()
			f87_arg0.ChangeClassButton:setLeftRight(0.5, 0.5, -901, -651)
			f87_arg0.ChangeClassButton:setTopBottom(1, 1, -288, -196)
			f87_arg0.ChangeClassButton:setAlpha(1)
			f87_arg0.clipFinished(f87_arg0.ChangeClassButton)
			f87_arg0.Characters:completeAnimation()
			f87_arg0.Characters:setAlpha(1)
			f87_arg0.clipFinished(f87_arg0.Characters)
		end,
		Intro_SelectSpecialist = function(f88_arg0, f88_arg1)
			f88_arg0:__resetProperties()
			f88_arg0:setupElementClipCounter(6)
			local f88_local0 = function(f89_arg0)
				local f89_local0 = function(f90_arg0)
					local f90_local0 = function(f91_arg0)
						f91_arg0:beginAnimation(660)
						f91_arg0:setAlpha(0)
						f91_arg0:registerEventHandler("transition_complete_keyframe", f88_arg0.clipFinished)
					end
					f90_arg0:beginAnimation(1290)
					f90_arg0:registerEventHandler("transition_complete_keyframe", f90_local0)
				end
				f88_arg0.BLACKTint:beginAnimation(690)
				f88_arg0.BLACKTint:setAlpha(0.5)
				f88_arg0.BLACKTint:registerEventHandler("interrupted_keyframe", f88_arg0.clipInterrupted)
				f88_arg0.BLACKTint:registerEventHandler("transition_complete_keyframe", f89_local0)
			end
			f88_arg0.BLACKTint:completeAnimation()
			f88_arg0.BLACKTint:setAlpha(0)
			f88_local0(f88_arg0.BLACKTint)
			local f88_local1 = function(f92_arg0)
				local f92_local0 = function(f93_arg0)
					local f93_local0 = function(f94_arg0)
						local f94_local0 = function(f95_arg0)
							f95_arg0:beginAnimation(430)
							f95_arg0:setAlpha(0)
							f95_arg0:registerEventHandler("transition_complete_keyframe", f88_arg0.clipFinished)
						end
						f94_arg0:beginAnimation(1290)
						f94_arg0:registerEventHandler("transition_complete_keyframe", f94_local0)
					end
					f93_arg0:beginAnimation(410)
					f93_arg0:setAlpha(1)
					f93_arg0:registerEventHandler("transition_complete_keyframe", f93_local0)
				end
				f88_arg0.StatusTextBackground:beginAnimation(280)
				f88_arg0.StatusTextBackground:registerEventHandler("interrupted_keyframe", f88_arg0.clipInterrupted)
				f88_arg0.StatusTextBackground:registerEventHandler("transition_complete_keyframe", f92_local0)
			end
			f88_arg0.StatusTextBackground:completeAnimation()
			f88_arg0.StatusTextBackground:setAlpha(0)
			f88_local1(f88_arg0.StatusTextBackground)
			local f88_local2 = function(f96_arg0)
				local f96_local0 = function(f97_arg0)
					local f97_local0 = function(f98_arg0)
						local f98_local0 = function(f99_arg0)
							f99_arg0:beginAnimation(430)
							f99_arg0:setAlpha(0)
							f99_arg0:registerEventHandler("transition_complete_keyframe", f88_arg0.clipFinished)
						end
						f98_arg0:beginAnimation(1290)
						f98_arg0:registerEventHandler("transition_complete_keyframe", f98_local0)
					end
					f97_arg0:beginAnimation(410)
					f97_arg0:setAlpha(1)
					f97_arg0:registerEventHandler("transition_complete_keyframe", f97_local0)
				end
				f88_arg0.StatusText:beginAnimation(280)
				f88_arg0.StatusText:registerEventHandler("interrupted_keyframe", f88_arg0.clipInterrupted)
				f88_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f96_local0)
			end
			f88_arg0.StatusText:completeAnimation()
			f88_arg0.StatusText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
			f88_arg0.StatusText:setAlpha(0)
			f88_local2(f88_arg0.StatusText)
			f88_arg0.PositionDraftReadyButton:completeAnimation()
			f88_arg0.PositionDraftReadyButton:setAlpha(0)
			f88_arg0.clipFinished(f88_arg0.PositionDraftReadyButton)
			f88_arg0.PositionDraftEnemyStatus:completeAnimation()
			f88_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f88_arg0.clipFinished(f88_arg0.PositionDraftEnemyStatus)
			f88_arg0.Characters:completeAnimation()
			f88_arg0.Characters:setAlpha(0)
			f88_arg0.clipFinished(f88_arg0.Characters)
		end,
	},
	MatchStartingPC = {
		DefaultClip = function(f100_arg0, f100_arg1)
			f100_arg0:__resetProperties()
			f100_arg0:setupElementClipCounter(11)
			local f100_local0 = function(f101_arg0)
				local f101_local0 = function(f102_arg0)
					f102_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f102_arg0:setAlpha(1)
					f102_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.StatusTextBackground:beginAnimation(300)
				f100_arg0.StatusTextBackground:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.StatusTextBackground:registerEventHandler("transition_complete_keyframe", f101_local0)
			end
			f100_arg0.StatusTextBackground:completeAnimation()
			f100_arg0.StatusTextBackground:setLeftRight(0.5, 0.5, -960, 960)
			f100_arg0.StatusTextBackground:setTopBottom(0.5, 0.5, 18, 218)
			f100_arg0.StatusTextBackground:setAlpha(0)
			f100_local0(f100_arg0.StatusTextBackground)
			local f100_local1 = function(f103_arg0)
				local f103_local0 = function(f104_arg0)
					f104_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f104_arg0:setAlpha(1)
					f104_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.StatusText:beginAnimation(500)
				f100_arg0.StatusText:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f103_local0)
			end
			f100_arg0.StatusText:completeAnimation()
			f100_arg0.StatusText:setTopBottom(0.5, 0.5, 93, 141)
			f100_arg0.StatusText:setRGB(0.4, 0.55, 0.22)
			f100_arg0.StatusText:setAlpha(0)
			f100_arg0.StatusText:setText(LocalizeToUpperString(0x8E58CC95DB34427))
			f100_local1(f100_arg0.StatusText)
			local f100_local2 = function(f105_arg0)
				local f105_local0 = function(f106_arg0)
					f106_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f106_arg0:setAlpha(0.7)
					f106_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.CountdownTimerTintPanel:beginAnimation(300)
				f100_arg0.CountdownTimerTintPanel:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.CountdownTimerTintPanel:registerEventHandler("transition_complete_keyframe", f105_local0)
			end
			f100_arg0.CountdownTimerTintPanel:completeAnimation()
			f100_arg0.CountdownTimerTintPanel:setLeftRight(0.5, 0.5, -400, 400)
			f100_arg0.CountdownTimerTintPanel:setTopBottom(0.5, 0.5, 97, 417)
			f100_arg0.CountdownTimerTintPanel:setAlpha(0)
			f100_local2(f100_arg0.CountdownTimerTintPanel)
			local f100_local3 = function(f107_arg0)
				local f107_local0 = function(f108_arg0)
					f108_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f108_arg0:setAlpha(0.9)
					f108_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.CountdownTimer:beginAnimation(500)
				f100_arg0.CountdownTimer:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.CountdownTimer:registerEventHandler("transition_complete_keyframe", f107_local0)
			end
			f100_arg0.CountdownTimer:completeAnimation()
			f100_arg0.CountdownTimer:setLeftRight(0.5, 0.5, -120, 120)
			f100_arg0.CountdownTimer:setTopBottom(0.5, 0.5, 190.5, 319.5)
			f100_arg0.CountdownTimer:setAlpha(0)
			f100_local3(f100_arg0.CountdownTimer)
			local f100_local4 = function(f109_arg0)
				local f109_local0 = function(f110_arg0)
					f110_arg0:beginAnimation(700)
					f110_arg0:setAlpha(1)
					f110_arg0:registerEventHandler("transition_complete_keyframe", f100_arg0.clipFinished)
				end
				f100_arg0.AutoDrafted:beginAnimation(300)
				f100_arg0.AutoDrafted:registerEventHandler("interrupted_keyframe", f100_arg0.clipInterrupted)
				f100_arg0.AutoDrafted:registerEventHandler("transition_complete_keyframe", f109_local0)
			end
			f100_arg0.AutoDrafted:completeAnimation()
			f100_arg0.AutoDrafted:setAlpha(0)
			f100_local4(f100_arg0.AutoDrafted)
			f100_arg0.PositionDraftReadyButton:completeAnimation()
			f100_arg0.PositionDraftReadyButton:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.PositionDraftReadyButton)
			f100_arg0.CasterControls:completeAnimation()
			f100_arg0.CasterControls:setTopBottom(0.66, 0.66, -170, -132)
			f100_arg0.clipFinished(f100_arg0.CasterControls)
			f100_arg0.PositionDraftEnemyStatus:completeAnimation()
			f100_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.PositionDraftEnemyStatus)
			f100_arg0.PositionDraftGametypeAndMap:completeAnimation()
			f100_arg0.PositionDraftGametypeAndMap:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.PositionDraftGametypeAndMap)
			f100_arg0.RadialTimer:completeAnimation()
			f100_arg0.RadialTimer:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.RadialTimer)
			f100_arg0.PositionDraftAttackDefend:completeAnimation()
			f100_arg0.PositionDraftAttackDefend:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.PositionDraftAttackDefend)
			f100_arg0.ChangeClassButton:completeAnimation()
			f100_arg0.ChangeClassButton:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.ChangeClassButton)
			f100_arg0.Characters:completeAnimation()
			f100_arg0.Characters:setAlpha(0)
			f100_arg0.clipFinished(f100_arg0.Characters)
		end,
		OneSecondRemaining = function(f111_arg0, f111_arg1)
			f111_arg0:__resetProperties()
			f111_arg0:setupElementClipCounter(10)
			f111_arg0.StatusTextBackground:completeAnimation()
			f111_arg0.StatusTextBackground:setLeftRight(0.5, 0.5, -960, 960)
			f111_arg0.StatusTextBackground:setTopBottom(0.5, 0.5, 18, 218)
			f111_arg0.clipFinished(f111_arg0.StatusTextBackground)
			f111_arg0.StatusText:completeAnimation()
			f111_arg0.StatusText:setTopBottom(0.5, 0.5, 93, 141)
			f111_arg0.StatusText:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f111_arg0.StatusText:setAlpha(1)
			f111_arg0.StatusText:setText(LocalizeToUpperString(0x8E58CC95DB34427))
			f111_arg0.clipFinished(f111_arg0.StatusText)
			f111_arg0.CountdownTimerTintPanel:completeAnimation()
			f111_arg0.CountdownTimerTintPanel:setLeftRight(0.5, 0.5, -400, 400)
			f111_arg0.CountdownTimerTintPanel:setTopBottom(0.5, 0.5, 97, 417)
			f111_arg0.CountdownTimerTintPanel:setAlpha(1)
			f111_arg0.clipFinished(f111_arg0.CountdownTimerTintPanel)
			f111_arg0.CountdownTimer:completeAnimation()
			f111_arg0.CountdownTimer:setLeftRight(0.5, 0.5, -120, 120)
			f111_arg0.CountdownTimer:setTopBottom(0.5, 0.5, 190.5, 319.5)
			f111_arg0.CountdownTimer:setAlpha(0.9)
			f111_arg0.clipFinished(f111_arg0.CountdownTimer)
			local f111_local0 = function(f112_arg0)
				local f112_local0 = function(f113_arg0)
					f113_arg0:beginAnimation(160)
					f113_arg0:setAlpha(1)
					f113_arg0:registerEventHandler("transition_complete_keyframe", f111_arg0.clipFinished)
				end
				f111_arg0.TransitionFade:beginAnimation(840)
				f111_arg0.TransitionFade:registerEventHandler("interrupted_keyframe", f111_arg0.clipInterrupted)
				f111_arg0.TransitionFade:registerEventHandler("transition_complete_keyframe", f112_local0)
			end
			f111_arg0.TransitionFade:completeAnimation()
			f111_arg0.TransitionFade:setAlpha(0)
			f111_local0(f111_arg0.TransitionFade)
			f111_arg0.PositionDraftReadyButton:completeAnimation()
			f111_arg0.PositionDraftReadyButton:setAlpha(0)
			f111_arg0.clipFinished(f111_arg0.PositionDraftReadyButton)
			f111_arg0.CasterControls:completeAnimation()
			f111_arg0.CasterControls:setTopBottom(0.66, 0.66, -170, -132)
			f111_arg0.clipFinished(f111_arg0.CasterControls)
			f111_arg0.PositionDraftEnemyStatus:completeAnimation()
			f111_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f111_arg0.clipFinished(f111_arg0.PositionDraftEnemyStatus)
			f111_arg0.PositionDraftGametypeAndMap:completeAnimation()
			f111_arg0.PositionDraftGametypeAndMap:setAlpha(0)
			f111_arg0.clipFinished(f111_arg0.PositionDraftGametypeAndMap)
			f111_arg0.RadialTimer:completeAnimation()
			f111_arg0.RadialTimer:setAlpha(0)
			f111_arg0.clipFinished(f111_arg0.RadialTimer)
			f111_arg0.PositionDraftAttackDefend:completeAnimation()
			f111_arg0.PositionDraftAttackDefend:setAlpha(0)
			f111_arg0.clipFinished(f111_arg0.PositionDraftAttackDefend)
			f111_arg0.Characters:completeAnimation()
			f111_arg0.Characters:setAlpha(0)
			f111_arg0.clipFinished(f111_arg0.Characters)
		end,
	},
	WaitingForPlayers = {
		DefaultClip = function(f114_arg0, f114_arg1)
			f114_arg0:__resetProperties()
			f114_arg0:setupElementClipCounter(8)
			local f114_local0 = function(f115_arg0)
				f115_arg0:beginAnimation(1000)
				f115_arg0:setAlpha(1)
				f115_arg0:registerEventHandler("transition_complete_keyframe", f114_arg0.clipFinished)
			end
			f114_arg0.StatusTextBackground:beginAnimation(2020)
			f114_arg0.StatusTextBackground:setAlpha(0)
			f114_arg0.StatusTextBackground:registerEventHandler("interrupted_keyframe", f114_arg0.clipInterrupted)
			f114_arg0.StatusTextBackground:registerEventHandler("transition_complete_keyframe", f114_local0)
			local f114_local1 = function(f116_arg0)
				local f116_local0 = function(f117_arg0)
					f117_arg0:beginAnimation(1000)
					f117_arg0:setAlpha(0.8)
					f117_arg0:registerEventHandler("transition_complete_keyframe", f114_arg0.clipFinished)
				end
				f116_arg0:beginAnimation(2010)
				f116_arg0:registerEventHandler("transition_complete_keyframe", f116_local0)
			end
			f114_arg0.StatusText:beginAnimation(9)
			f114_arg0.StatusText:setAlpha(0)
			f114_arg0.StatusText:setText(LocalizeToUpperString(0x704768AE118E4C9))
			f114_arg0.StatusText:registerEventHandler("interrupted_keyframe", f114_arg0.clipInterrupted)
			f114_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f114_local1)
			f114_arg0.AutoDrafted:completeAnimation()
			f114_arg0.AutoDrafted:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.AutoDrafted)
			f114_arg0.PositionDraftReadyButton:completeAnimation()
			f114_arg0.PositionDraftReadyButton:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.PositionDraftReadyButton)
			f114_arg0.PositionDraftEnemyStatus:completeAnimation()
			f114_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.PositionDraftEnemyStatus)
			f114_arg0.PositionDraftGametypeAndMap:completeAnimation()
			f114_arg0.PositionDraftGametypeAndMap:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.PositionDraftGametypeAndMap)
			f114_arg0.FocusedCharacterInfo:completeAnimation()
			f114_arg0.FocusedCharacterInfo:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.FocusedCharacterInfo)
			f114_arg0.ChangeClassButton:completeAnimation()
			f114_arg0.ChangeClassButton:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.ChangeClassButton)
			f114_arg0.Characters:completeAnimation()
			f114_arg0.Characters:setAlpha(0)
			f114_arg0.clipFinished(f114_arg0.Characters)
		end,
	},
	Draft = {
		DefaultClip = function(f118_arg0, f118_arg1)
			f118_arg0:__resetProperties()
			f118_arg0:setupElementClipCounter(12)
			f118_arg0.BLACKTint:completeAnimation()
			f118_arg0.BLACKTint:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.BLACKTint)
			f118_arg0.PositionDraftOverheadNameContainer:completeAnimation()
			f118_arg0.PositionDraftOverheadNameContainer:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.PositionDraftOverheadNameContainer)
			f118_arg0.StatusTextBackground:completeAnimation()
			f118_arg0.StatusTextBackground:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.StatusTextBackground)
			f118_arg0.StatusText:completeAnimation()
			f118_arg0.StatusText:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.StatusText)
			f118_arg0.AutoDrafted:completeAnimation()
			f118_arg0.AutoDrafted:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.AutoDrafted)
			f118_arg0.PositionDraftReadyButton:completeAnimation()
			f118_arg0.PositionDraftReadyButton:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.PositionDraftReadyButton)
			f118_arg0.CasterControls:completeAnimation()
			f118_arg0.CasterControls:setAlpha(0)
			f118_arg0.clipFinished(f118_arg0.CasterControls)
			f118_arg0.PositionDraftEnemyStatus:completeAnimation()
			f118_arg0.PositionDraftEnemyStatus:setAlpha(1)
			f118_arg0.clipFinished(f118_arg0.PositionDraftEnemyStatus)
			f118_arg0.RadialTimer:completeAnimation()
			f118_arg0.RadialTimer:setAlpha(1)
			f118_arg0.clipFinished(f118_arg0.RadialTimer)
			f118_arg0.FocusedCharacterInfo:completeAnimation()
			f118_arg0.FocusedCharacterInfo:setAlpha(1)
			f118_arg0.clipFinished(f118_arg0.FocusedCharacterInfo)
			f118_arg0.ChangeClassButton:completeAnimation()
			f118_arg0.ChangeClassButton:setAlpha(1)
			f118_arg0.clipFinished(f118_arg0.ChangeClassButton)
			f118_arg0.Characters:completeAnimation()
			f118_arg0.Characters:setAlpha(1)
			f118_arg0.clipFinished(f118_arg0.Characters)
			f118_arg0.VoipContainerNoCompass:completeAnimation()
			f118_arg0.VoipContainerNoCompass:setAlpha(1)
			f118_arg0.clipFinished(f118_arg0.VoipContainerNoCompass)
		end,
		Intro_SelectSpecialist = function(f119_arg0, f119_arg1)
			f119_arg0:__resetProperties()
			f119_arg0:setupElementClipCounter(6)
			local f119_local0 = function(f120_arg0)
				local f120_local0 = function(f121_arg0)
					local f121_local0 = function(f122_arg0)
						f122_arg0:beginAnimation(660)
						f122_arg0:setAlpha(0)
						f122_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
					end
					f121_arg0:beginAnimation(1290)
					f121_arg0:registerEventHandler("transition_complete_keyframe", f121_local0)
				end
				f119_arg0.BLACKTint:beginAnimation(690)
				f119_arg0.BLACKTint:setAlpha(0.5)
				f119_arg0.BLACKTint:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.BLACKTint:registerEventHandler("transition_complete_keyframe", f120_local0)
			end
			f119_arg0.BLACKTint:completeAnimation()
			f119_arg0.BLACKTint:setAlpha(0)
			f119_local0(f119_arg0.BLACKTint)
			local f119_local1 = function(f123_arg0)
				local f123_local0 = function(f124_arg0)
					local f124_local0 = function(f125_arg0)
						local f125_local0 = function(f126_arg0)
							f126_arg0:beginAnimation(430)
							f126_arg0:setAlpha(0)
							f126_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
						end
						f125_arg0:beginAnimation(1290)
						f125_arg0:registerEventHandler("transition_complete_keyframe", f125_local0)
					end
					f124_arg0:beginAnimation(410)
					f124_arg0:setAlpha(1)
					f124_arg0:registerEventHandler("transition_complete_keyframe", f124_local0)
				end
				f119_arg0.StatusTextBackground:beginAnimation(280)
				f119_arg0.StatusTextBackground:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.StatusTextBackground:registerEventHandler("transition_complete_keyframe", f123_local0)
			end
			f119_arg0.StatusTextBackground:completeAnimation()
			f119_arg0.StatusTextBackground:setAlpha(0)
			f119_local1(f119_arg0.StatusTextBackground)
			local f119_local2 = function(f127_arg0)
				local f127_local0 = function(f128_arg0)
					local f128_local0 = function(f129_arg0)
						local f129_local0 = function(f130_arg0)
							f130_arg0:beginAnimation(430)
							f130_arg0:setAlpha(0)
							f130_arg0:registerEventHandler("transition_complete_keyframe", f119_arg0.clipFinished)
						end
						f129_arg0:beginAnimation(1290)
						f129_arg0:registerEventHandler("transition_complete_keyframe", f129_local0)
					end
					f128_arg0:beginAnimation(410)
					f128_arg0:setAlpha(1)
					f128_arg0:registerEventHandler("transition_complete_keyframe", f128_local0)
				end
				f119_arg0.StatusText:beginAnimation(280)
				f119_arg0.StatusText:registerEventHandler("interrupted_keyframe", f119_arg0.clipInterrupted)
				f119_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f127_local0)
			end
			f119_arg0.StatusText:completeAnimation()
			f119_arg0.StatusText:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
			f119_arg0.StatusText:setAlpha(0)
			f119_local2(f119_arg0.StatusText)
			f119_arg0.PositionDraftReadyButton:completeAnimation()
			f119_arg0.PositionDraftReadyButton:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.PositionDraftReadyButton)
			f119_arg0.PositionDraftEnemyStatus:completeAnimation()
			f119_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.PositionDraftEnemyStatus)
			f119_arg0.Characters:completeAnimation()
			f119_arg0.Characters:setAlpha(0)
			f119_arg0.clipFinished(f119_arg0.Characters)
		end,
	},
	CharacterSelectedPC = {
		DefaultClip = function(f131_arg0, f131_arg1)
			f131_arg0:__resetProperties()
			f131_arg0:setupElementClipCounter(10)
			f131_arg0.blurbackgroundSelectedClass:completeAnimation()
			f131_arg0.blurbackgroundSelectedClass:setAlpha(1)
			f131_arg0.clipFinished(f131_arg0.blurbackgroundSelectedClass)
			f131_arg0.BLACKTint:completeAnimation()
			f131_arg0.BLACKTint:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.BLACKTint)
			f131_arg0.StatusTextBackground:completeAnimation()
			f131_arg0.StatusTextBackground:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.StatusTextBackground)
			f131_arg0.StatusText:completeAnimation()
			f131_arg0.StatusText:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.StatusText)
			f131_arg0.AutoDrafted:completeAnimation()
			f131_arg0.AutoDrafted:setAlpha(1)
			f131_arg0.clipFinished(f131_arg0.AutoDrafted)
			f131_arg0.PositionDraftReadyButton:completeAnimation()
			f131_arg0.PositionDraftReadyButton:setLeftRight(0.5, 0.5, -180.5, 187.5)
			f131_arg0.PositionDraftReadyButton:setTopBottom(0.75, 0.75, -236.5, -161.5)
			f131_arg0.PositionDraftReadyButton:setAlpha(1)
			f131_arg0.clipFinished(f131_arg0.PositionDraftReadyButton)
			f131_arg0.PositionDraftEnemyStatus:completeAnimation()
			f131_arg0.PositionDraftEnemyStatus:setLeftRight(0.5, 0.5, -649, -249)
			f131_arg0.PositionDraftEnemyStatus:setTopBottom(0.5, 0.5, 255, 345)
			f131_arg0.PositionDraftEnemyStatus:setAlpha(1)
			f131_arg0.clipFinished(f131_arg0.PositionDraftEnemyStatus)
			f131_arg0.SelectedClassMiniPreview:completeAnimation()
			f131_arg0.SelectedClassMiniPreview:setAlpha(1)
			f131_arg0.clipFinished(f131_arg0.SelectedClassMiniPreview)
			f131_arg0.PositionDraftGametypeAndMap:completeAnimation()
			f131_arg0.PositionDraftGametypeAndMap:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.PositionDraftGametypeAndMap)
			f131_arg0.RadialTimer:completeAnimation()
			f131_arg0.RadialTimer:setAlpha(1)
			f131_arg0.clipFinished(f131_arg0.RadialTimer)
			f131_arg0.PositionDraftAttackDefend:completeAnimation()
			f131_arg0.PositionDraftAttackDefend:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.PositionDraftAttackDefend)
			f131_arg0.FocusedCharacterInfo:completeAnimation()
			f131_arg0.FocusedCharacterInfo:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.FocusedCharacterInfo)
			f131_arg0.ChangeClassButton:completeAnimation()
			f131_arg0.ChangeClassButton:setLeftRight(0.5, 0.5, -901, -651)
			f131_arg0.ChangeClassButton:setTopBottom(1, 1, -288, -196)
			f131_arg0.ChangeClassButton:setAlpha(1)
			f131_arg0.clipFinished(f131_arg0.ChangeClassButton)
			f131_arg0.Characters:completeAnimation()
			f131_arg0.Characters:setAlpha(0)
			f131_arg0.clipFinished(f131_arg0.Characters)
		end,
	},
	CharacterSelected = {
		DefaultClip = function(f132_arg0, f132_arg1)
			f132_arg0:__resetProperties()
			f132_arg0:setupElementClipCounter(10)
			f132_arg0.blurbackgroundSelectedClass:completeAnimation()
			f132_arg0.blurbackgroundSelectedClass:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.blurbackgroundSelectedClass)
			f132_arg0.BLACKTint:completeAnimation()
			f132_arg0.BLACKTint:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.BLACKTint)
			f132_arg0.StatusTextBackground:completeAnimation()
			f132_arg0.StatusTextBackground:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.StatusTextBackground)
			f132_arg0.StatusText:completeAnimation()
			f132_arg0.StatusText:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.StatusText)
			f132_arg0.AutoDrafted:completeAnimation()
			f132_arg0.AutoDrafted:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.AutoDrafted)
			f132_arg0.PositionDraftReadyButton:completeAnimation()
			f132_arg0.PositionDraftReadyButton:setLeftRight(0.5, 0.5, -180.5, 187.5)
			f132_arg0.PositionDraftReadyButton:setTopBottom(0.75, 0.75, -236.5, -161.5)
			f132_arg0.PositionDraftReadyButton:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.PositionDraftReadyButton)
			f132_arg0.PositionDraftEnemyStatus:completeAnimation()
			f132_arg0.PositionDraftEnemyStatus:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.PositionDraftEnemyStatus)
			f132_arg0.SelectedClassMiniPreview:completeAnimation()
			f132_arg0.SelectedClassMiniPreview:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.SelectedClassMiniPreview)
			f132_arg0.RadialTimer:completeAnimation()
			f132_arg0.RadialTimer:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.RadialTimer)
			f132_arg0.PositionDraftAttackDefend:completeAnimation()
			f132_arg0.PositionDraftAttackDefend:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.PositionDraftAttackDefend)
			f132_arg0.FocusedCharacterInfo:completeAnimation()
			f132_arg0.FocusedCharacterInfo:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.FocusedCharacterInfo)
			f132_arg0.ChangeClassButton:completeAnimation()
			f132_arg0.ChangeClassButton:setAlpha(1)
			f132_arg0.clipFinished(f132_arg0.ChangeClassButton)
			f132_arg0.Characters:completeAnimation()
			f132_arg0.Characters:setAlpha(0)
			f132_arg0.clipFinished(f132_arg0.Characters)
		end,
	},
	EditLoadout = {
		DefaultClip = function(f133_arg0, f133_arg1)
			f133_arg0:__resetProperties()
			f133_arg0:setupElementClipCounter(8)
			f133_arg0.BLACKTint:completeAnimation()
			f133_arg0.BLACKTint:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.BLACKTint)
			f133_arg0.StatusTextBackground:completeAnimation()
			f133_arg0.StatusTextBackground:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.StatusTextBackground)
			f133_arg0.StatusText:completeAnimation()
			f133_arg0.StatusText:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.StatusText)
			f133_arg0.PositionDraftReadyButton:completeAnimation()
			f133_arg0.PositionDraftReadyButton:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.PositionDraftReadyButton)
			f133_arg0.PositionDraftEnemyStatus:completeAnimation()
			f133_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.PositionDraftEnemyStatus)
			f133_arg0.PositionDraftGametypeAndMap:completeAnimation()
			f133_arg0.PositionDraftGametypeAndMap:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.PositionDraftGametypeAndMap)
			f133_arg0.PositionDraftAttackDefend:completeAnimation()
			f133_arg0.PositionDraftAttackDefend:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.PositionDraftAttackDefend)
			f133_arg0.ChangeClassButton:completeAnimation()
			f133_arg0.ChangeClassButton:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.ChangeClassButton)
			f133_arg0.Characters:completeAnimation()
			f133_arg0.Characters:setAlpha(0)
			f133_arg0.clipFinished(f133_arg0.Characters)
		end,
	},
	AllClientsReady = {
		DefaultClip = function(f134_arg0, f134_arg1)
			f134_arg0:__resetProperties()
			f134_arg0:setupElementClipCounter(9)
			local f134_local0 = function(f135_arg0)
				f134_arg0.StatusTextBackground:beginAnimation(1000)
				f134_arg0.StatusTextBackground:registerEventHandler("interrupted_keyframe", f134_arg0.clipInterrupted)
				f134_arg0.StatusTextBackground:registerEventHandler("transition_complete_keyframe", f134_arg0.clipFinished)
			end
			f134_arg0.StatusTextBackground:completeAnimation()
			f134_arg0.StatusTextBackground:setRGB(1, 1, 1)
			f134_arg0.StatusTextBackground:setAlpha(1)
			f134_local0(f134_arg0.StatusTextBackground)
			local f134_local1 = function(f136_arg0)
				f134_arg0.StatusText:beginAnimation(1000)
				f134_arg0.StatusText:registerEventHandler("interrupted_keyframe", f134_arg0.clipInterrupted)
				f134_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f134_arg0.clipFinished)
			end
			f134_arg0.StatusText:completeAnimation()
			f134_arg0.StatusText:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f134_arg0.StatusText:setAlpha(0.8)
			f134_arg0.StatusText:setText(LocalizeToUpperString(0x41793C9651E000F))
			f134_arg0.StatusText:setLetterSpacing(14.7)
			f134_local1(f134_arg0.StatusText)
			local f134_local2 = function(f137_arg0)
				f134_arg0.AutoDrafted:beginAnimation(1000)
				f134_arg0.AutoDrafted:setAlpha(1)
				f134_arg0.AutoDrafted:registerEventHandler("interrupted_keyframe", f134_arg0.clipInterrupted)
				f134_arg0.AutoDrafted:registerEventHandler("transition_complete_keyframe", f134_arg0.clipFinished)
			end
			f134_arg0.AutoDrafted:completeAnimation()
			f134_arg0.AutoDrafted:setAlpha(0)
			f134_local2(f134_arg0.AutoDrafted)
			f134_arg0.PositionDraftReadyButton:completeAnimation()
			f134_arg0.PositionDraftReadyButton:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.PositionDraftReadyButton)
			f134_arg0.PositionDraftEnemyStatus:completeAnimation()
			f134_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.PositionDraftEnemyStatus)
			f134_arg0.RadialTimer:completeAnimation()
			f134_arg0.RadialTimer:setAlpha(1)
			f134_arg0.clipFinished(f134_arg0.RadialTimer)
			local f134_local3 = function(f138_arg0)
				f134_arg0.PositionDraftAttackDefend:beginAnimation(1000)
				f134_arg0.PositionDraftAttackDefend:registerEventHandler("interrupted_keyframe", f134_arg0.clipInterrupted)
				f134_arg0.PositionDraftAttackDefend:registerEventHandler("transition_complete_keyframe", f134_arg0.clipFinished)
			end
			f134_arg0.PositionDraftAttackDefend:completeAnimation()
			f134_arg0.PositionDraftAttackDefend:setAlpha(0)
			f134_local3(f134_arg0.PositionDraftAttackDefend)
			f134_arg0.FocusedCharacterInfo:completeAnimation()
			f134_arg0.FocusedCharacterInfo:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.FocusedCharacterInfo)
			f134_arg0.ChangeClassButton:completeAnimation()
			f134_arg0.ChangeClassButton:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.ChangeClassButton)
			f134_arg0.Characters:completeAnimation()
			f134_arg0.Characters:setAlpha(0)
			f134_arg0.clipFinished(f134_arg0.Characters)
		end,
		MatchStarting = function(f139_arg0, f139_arg1)
			f139_arg0:__resetProperties()
			f139_arg0:setupElementClipCounter(6)
			local f139_local0 = function(f140_arg0)
				f139_arg0.StatusTextBackground:beginAnimation(970)
				f139_arg0.StatusTextBackground:setAlpha(0)
				f139_arg0.StatusTextBackground:registerEventHandler("interrupted_keyframe", f139_arg0.clipInterrupted)
				f139_arg0.StatusTextBackground:registerEventHandler("transition_complete_keyframe", f139_arg0.clipFinished)
			end
			f139_arg0.StatusTextBackground:completeAnimation()
			f139_arg0.StatusTextBackground:setAlpha(1)
			f139_local0(f139_arg0.StatusTextBackground)
			local f139_local1 = function(f141_arg0)
				f139_arg0.StatusText:beginAnimation(970)
				f139_arg0.StatusText:setAlpha(0)
				f139_arg0.StatusText:registerEventHandler("interrupted_keyframe", f139_arg0.clipInterrupted)
				f139_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f139_arg0.clipFinished)
			end
			f139_arg0.StatusText:completeAnimation()
			f139_arg0.StatusText:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f139_arg0.StatusText:setAlpha(0.8)
			f139_arg0.StatusText:setText(LocalizeToUpperString(0x41793C9651E000F))
			f139_local1(f139_arg0.StatusText)
			f139_arg0.PositionDraftReadyButton:completeAnimation()
			f139_arg0.PositionDraftReadyButton:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.PositionDraftReadyButton)
			f139_arg0.PositionDraftEnemyStatus:completeAnimation()
			f139_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.PositionDraftEnemyStatus)
			f139_arg0.RadialTimer:completeAnimation()
			f139_arg0.RadialTimer:setAlpha(1)
			f139_arg0.clipFinished(f139_arg0.RadialTimer)
			f139_arg0.PositionDraftAttackDefend:completeAnimation()
			f139_arg0.PositionDraftAttackDefend:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.PositionDraftAttackDefend)
			f139_arg0.Characters:completeAnimation()
			f139_arg0.Characters:setAlpha(0)
			f139_arg0.clipFinished(f139_arg0.Characters)
		end,
	},
	MatchStarting = {
		DefaultClip = function(f142_arg0, f142_arg1)
			f142_arg0:__resetProperties()
			f142_arg0:setupElementClipCounter(10)
			local f142_local0 = function(f143_arg0)
				local f143_local0 = function(f144_arg0)
					f144_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f144_arg0:setAlpha(1)
					f144_arg0:registerEventHandler("transition_complete_keyframe", f142_arg0.clipFinished)
				end
				f142_arg0.StatusTextBackground:beginAnimation(300)
				f142_arg0.StatusTextBackground:registerEventHandler("interrupted_keyframe", f142_arg0.clipInterrupted)
				f142_arg0.StatusTextBackground:registerEventHandler("transition_complete_keyframe", f143_local0)
			end
			f142_arg0.StatusTextBackground:completeAnimation()
			f142_arg0.StatusTextBackground:setAlpha(0)
			f142_local0(f142_arg0.StatusTextBackground)
			local f142_local1 = function(f145_arg0)
				local f145_local0 = function(f146_arg0)
					f146_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f146_arg0:setAlpha(1)
					f146_arg0:registerEventHandler("transition_complete_keyframe", f142_arg0.clipFinished)
				end
				f142_arg0.StatusText:beginAnimation(500)
				f142_arg0.StatusText:registerEventHandler("interrupted_keyframe", f142_arg0.clipInterrupted)
				f142_arg0.StatusText:registerEventHandler("transition_complete_keyframe", f145_local0)
			end
			f142_arg0.StatusText:completeAnimation()
			f142_arg0.StatusText:setRGB(0.4, 0.55, 0.22)
			f142_arg0.StatusText:setAlpha(0)
			f142_arg0.StatusText:setText(LocalizeToUpperString(0x8E58CC95DB34427))
			f142_local1(f142_arg0.StatusText)
			local f142_local2 = function(f147_arg0)
				local f147_local0 = function(f148_arg0)
					f148_arg0:beginAnimation(199, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f148_arg0:setAlpha(0.7)
					f148_arg0:registerEventHandler("transition_complete_keyframe", f142_arg0.clipFinished)
				end
				f142_arg0.CountdownTimerTintPanel:beginAnimation(300)
				f142_arg0.CountdownTimerTintPanel:registerEventHandler("interrupted_keyframe", f142_arg0.clipInterrupted)
				f142_arg0.CountdownTimerTintPanel:registerEventHandler("transition_complete_keyframe", f147_local0)
			end
			f142_arg0.CountdownTimerTintPanel:completeAnimation()
			f142_arg0.CountdownTimerTintPanel:setAlpha(0)
			f142_local2(f142_arg0.CountdownTimerTintPanel)
			local f142_local3 = function(f149_arg0)
				local f149_local0 = function(f150_arg0)
					f150_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f150_arg0:setAlpha(0.9)
					f150_arg0:registerEventHandler("transition_complete_keyframe", f142_arg0.clipFinished)
				end
				f142_arg0.CountdownTimer:beginAnimation(500)
				f142_arg0.CountdownTimer:registerEventHandler("interrupted_keyframe", f142_arg0.clipInterrupted)
				f142_arg0.CountdownTimer:registerEventHandler("transition_complete_keyframe", f149_local0)
			end
			f142_arg0.CountdownTimer:completeAnimation()
			f142_arg0.CountdownTimer:setAlpha(0)
			f142_local3(f142_arg0.CountdownTimer)
			local f142_local4 = function(f151_arg0)
				local f151_local0 = function(f152_arg0)
					f152_arg0:beginAnimation(700)
					f152_arg0:setAlpha(1)
					f152_arg0:registerEventHandler("transition_complete_keyframe", f142_arg0.clipFinished)
				end
				f142_arg0.AutoDrafted:beginAnimation(300)
				f142_arg0.AutoDrafted:registerEventHandler("interrupted_keyframe", f142_arg0.clipInterrupted)
				f142_arg0.AutoDrafted:registerEventHandler("transition_complete_keyframe", f151_local0)
			end
			f142_arg0.AutoDrafted:completeAnimation()
			f142_arg0.AutoDrafted:setAlpha(0)
			f142_local4(f142_arg0.AutoDrafted)
			f142_arg0.PositionDraftReadyButton:completeAnimation()
			f142_arg0.PositionDraftReadyButton:setAlpha(0)
			f142_arg0.clipFinished(f142_arg0.PositionDraftReadyButton)
			f142_arg0.PositionDraftEnemyStatus:completeAnimation()
			f142_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f142_arg0.clipFinished(f142_arg0.PositionDraftEnemyStatus)
			f142_arg0.RadialTimer:completeAnimation()
			f142_arg0.RadialTimer:setAlpha(0)
			f142_arg0.clipFinished(f142_arg0.RadialTimer)
			f142_arg0.PositionDraftAttackDefend:completeAnimation()
			f142_arg0.PositionDraftAttackDefend:setAlpha(0)
			f142_arg0.clipFinished(f142_arg0.PositionDraftAttackDefend)
			f142_arg0.ChangeClassButton:completeAnimation()
			f142_arg0.ChangeClassButton:setAlpha(0)
			f142_arg0.clipFinished(f142_arg0.ChangeClassButton)
			f142_arg0.Characters:completeAnimation()
			f142_arg0.Characters:setAlpha(0)
			f142_arg0.clipFinished(f142_arg0.Characters)
		end,
		OneSecondRemaining = function(f153_arg0, f153_arg1)
			f153_arg0:__resetProperties()
			f153_arg0:setupElementClipCounter(9)
			f153_arg0.StatusTextBackground:completeAnimation()
			f153_arg0.clipFinished(f153_arg0.StatusTextBackground)
			f153_arg0.StatusText:completeAnimation()
			f153_arg0.StatusText:setRGB(ColorSet.T8__GREEN.r, ColorSet.T8__GREEN.g, ColorSet.T8__GREEN.b)
			f153_arg0.StatusText:setAlpha(1)
			f153_arg0.StatusText:setText(LocalizeToUpperString(0x8E58CC95DB34427))
			f153_arg0.clipFinished(f153_arg0.StatusText)
			f153_arg0.CountdownTimerTintPanel:completeAnimation()
			f153_arg0.CountdownTimerTintPanel:setAlpha(1)
			f153_arg0.clipFinished(f153_arg0.CountdownTimerTintPanel)
			f153_arg0.CountdownTimer:completeAnimation()
			f153_arg0.CountdownTimer:setAlpha(0.9)
			f153_arg0.clipFinished(f153_arg0.CountdownTimer)
			local f153_local0 = function(f154_arg0)
				local f154_local0 = function(f155_arg0)
					f155_arg0:beginAnimation(160)
					f155_arg0:setAlpha(1)
					f155_arg0:registerEventHandler("transition_complete_keyframe", f153_arg0.clipFinished)
				end
				f153_arg0.TransitionFade:beginAnimation(840)
				f153_arg0.TransitionFade:registerEventHandler("interrupted_keyframe", f153_arg0.clipInterrupted)
				f153_arg0.TransitionFade:registerEventHandler("transition_complete_keyframe", f154_local0)
			end
			f153_arg0.TransitionFade:completeAnimation()
			f153_arg0.TransitionFade:setAlpha(0)
			f153_local0(f153_arg0.TransitionFade)
			f153_arg0.PositionDraftReadyButton:completeAnimation()
			f153_arg0.PositionDraftReadyButton:setAlpha(0)
			f153_arg0.clipFinished(f153_arg0.PositionDraftReadyButton)
			f153_arg0.PositionDraftEnemyStatus:completeAnimation()
			f153_arg0.PositionDraftEnemyStatus:setAlpha(0)
			f153_arg0.clipFinished(f153_arg0.PositionDraftEnemyStatus)
			f153_arg0.RadialTimer:completeAnimation()
			f153_arg0.RadialTimer:setAlpha(0)
			f153_arg0.clipFinished(f153_arg0.RadialTimer)
			f153_arg0.PositionDraftAttackDefend:completeAnimation()
			f153_arg0.PositionDraftAttackDefend:setAlpha(0)
			f153_arg0.clipFinished(f153_arg0.PositionDraftAttackDefend)
			f153_arg0.Characters:completeAnimation()
			f153_arg0.Characters:setAlpha(0)
			f153_arg0.clipFinished(f153_arg0.Characters)
		end,
	},
}
CoD.PositionDraft.__onClose = function(f156_arg0)
	f156_arg0.__on_close_removeOverrides()
	f156_arg0.FocusedCharacterInfo:close()
	f156_arg0.BLACKTint:close()
	f156_arg0.PositionDraftOverheadNameContainer:close()
	f156_arg0.StatusTextBackground:close()
	f156_arg0.CountdownTimerTintPanel:close()
	f156_arg0.CountdownTimer:close()
	f156_arg0.TransitionFade:close()
	f156_arg0.AutoDrafted:close()
	f156_arg0.PositionDraftReadyButton:close()
	f156_arg0.CasterControls:close()
	f156_arg0.PositionDraftEnemyStatus:close()
	f156_arg0.SelectedClassMiniPreview:close()
	f156_arg0.SelectedClassMiniPreviewPC:close()
	f156_arg0.FooterContainerFrontendRight:close()
	f156_arg0.PositionDraftGametypeAndMap:close()
	f156_arg0.PositionDraftSearchingForPlayers:close()
	f156_arg0.RadialTimer:close()
	f156_arg0.PositionDraftGametypeAndMapPC:close()
	f156_arg0.RadialTimerPC:close()
	f156_arg0.PositionDraftAttackDefend:close()
	f156_arg0.ChangeClassButton:close()
	f156_arg0.Characters:close()
	f156_arg0.PCVoiceChatWidget:close()
	f156_arg0.CommonHeader:close()
	f156_arg0.TopBar:close()
	f156_arg0.VoipContainerNoCompass:close()
	f156_arg0.emptyFocusable:close()
end
