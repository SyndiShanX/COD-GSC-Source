require("x64:5d8a5130cdd7376")
require("x64:9a6dfba186f55fb")
require("x64:b672d66c458dc7f")
require("x64:67b42701ffd2597")
require("x64:8c63b46dae5a66f")
require("x64:7e0d412e85e8901")
require("x64:17ffbf854dfd48e")
require("x64:6312639d0df5aa2")
require("x64:6e2a57a578a85e4")
require("x64:4d266b5bff40c9a")
require("x64:f509db5d3ee66ac")
require("x64:d0053ebf8d9bc0c")
require("x64:3d2286142c6d3ba")
require("x64:a7a13e373e49761")
require("x64:e1397a34d17616a")
CoD.codcaster_player_portraittop_team1 = InheritFrom(LUI.UIElement)
CoD.codcaster_player_portraittop_team1.__defaultWidth = 132
CoD.codcaster_player_portraittop_team1.__defaultHeight = 156
CoD.codcaster_player_portraittop_team1.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.codcaster_player_portraittop_team1)
	self.id = "codcaster_player_portraittop_team1"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local mediumBG = LUI.UIImage.new(0.5, 0.5, -62, 62, 0, 0, 85, 121)
	mediumBG:setRGB(0.06, 0.06, 0.06)
	mediumBG:setAlpha(0)
	self:addElement(mediumBG)
	self.mediumBG = mediumBG
	local PlayerPortraitHoverBottom = CoD.PlayerPortraitHoverBottom.new(f1_arg0, f1_arg1, 0.5, 0.5, -66, 66, 0, 0, 82, 98)
	PlayerPortraitHoverBottom:linkToElementModel(self, nil, false, function(model)
		PlayerPortraitHoverBottom:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerPortraitHoverBottom)
	self.PlayerPortraitHoverBottom = PlayerPortraitHoverBottom
	local PlayerPortraitHoverTop = CoD.PlayerPortraitHoverTop.new(f1_arg0, f1_arg1, 0.5, 0.5, -66, 66, 0, 0, -11, 5)
	PlayerPortraitHoverTop:linkToElementModel(self, nil, false, function(model)
		PlayerPortraitHoverTop:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerPortraitHoverTop)
	self.PlayerPortraitHoverTop = PlayerPortraitHoverTop
	local PlayerPortraitFocusBottom = CoD.PlayerPortraitFocusBottom.new(f1_arg0, f1_arg1, 0.5, 0.5, -66, 66, 0, 0, 82, 98)
	PlayerPortraitFocusBottom:linkToElementModel(self, nil, false, function(model)
		PlayerPortraitFocusBottom:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerPortraitFocusBottom)
	self.PlayerPortraitFocusBottom = PlayerPortraitFocusBottom
	local PlayerPortraitFocusTop = CoD.PlayerPortraitFocusTop.new(f1_arg0, f1_arg1, 0.5, 0.5, -66, 66, 0, 0, -11, 5)
	PlayerPortraitFocusTop:linkToElementModel(self, nil, false, function(model)
		PlayerPortraitFocusTop:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerPortraitFocusTop)
	self.PlayerPortraitFocusTop = PlayerPortraitFocusTop
	local ObjectiveStatus = CoD.CodCasterPortraitObjectiveStatus.new(f1_arg0, f1_arg1, 0.5, 0.5, -32, 32, 1.05, 1.05, -74, -10)
	ObjectiveStatus:setScale(0.5, 0.5)
	ObjectiveStatus:linkToElementModel(self, nil, false, function(model)
		ObjectiveStatus:setModel(model, f1_arg1)
	end)
	self:addElement(ObjectiveStatus)
	self.ObjectiveStatus = ObjectiveStatus
	local blur = LUI.UIImage.new(0, 0, 4.5, 127.5, 0, 0, 3.5, 55.5)
	blur:setRGB(0, 0, 0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local teamcolorbg = LUI.UIImage.new(0.5, 0.5, -61, 61, 0, 0, 3, 61)
	teamcolorbg:setAlpha(0.9)
	teamcolorbg:setImage(RegisterImage(0x97941765AC1B3BE))
	teamcolorbg:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "alliesFactionColor", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			teamcolorbg:setRGB(f7_local0)
		end
	end)
	self:addElement(teamcolorbg)
	self.teamcolorbg = teamcolorbg
	local mediumBG2 = LUI.UIImage.new(0.5, 0.5, -62, 62, 0.5, 0.5, 42, 75)
	mediumBG2:setRGB(0.06, 0.06, 0.06)
	mediumBG2:setAlpha(0)
	self:addElement(mediumBG2)
	self.mediumBG2 = mediumBG2
	local CodCasterPortraitPlayerListEntrySpecialistHead = CoD.CodCasterPortraitPlayerListEntrySpecialistHead.new(f1_arg0, f1_arg1, 0.34, 0.83, -44.5, -44.5, -0.05, -0.05, 6, 79)
	CodCasterPortraitPlayerListEntrySpecialistHead:setScale(0.8, 0.8)
	CodCasterPortraitPlayerListEntrySpecialistHead:linkToElementModel(self, nil, false, function(model)
		CodCasterPortraitPlayerListEntrySpecialistHead:setModel(model, f1_arg1)
	end)
	CodCasterPortraitPlayerListEntrySpecialistHead:linkToElementModel(self, "characterIndex", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			CodCasterPortraitPlayerListEntrySpecialistHead.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.Healing:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_HEALING, f9_local0)))
		end
	end)
	CodCasterPortraitPlayerListEntrySpecialistHead:linkToElementModel(self, "characterIndex", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			CodCasterPortraitPlayerListEntrySpecialistHead.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.Wounded:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_WOUNDED, f10_local0)))
		end
	end)
	CodCasterPortraitPlayerListEntrySpecialistHead:linkToElementModel(self, "characterIndex", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			CodCasterPortraitPlayerListEntrySpecialistHead.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.Buffed:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_BUFFED, f11_local0)))
		end
	end)
	CodCasterPortraitPlayerListEntrySpecialistHead:linkToElementModel(self, "characterIndex", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			CodCasterPortraitPlayerListEntrySpecialistHead.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.Critical:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_CRITICAL, f12_local0)))
		end
	end)
	CodCasterPortraitPlayerListEntrySpecialistHead:linkToElementModel(self, "characterIndex", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			CodCasterPortraitPlayerListEntrySpecialistHead.CodCasterPortraitPlayerListEntrySpecialistHeadIcon.Normal:setImage(RegisterImage(GetPositionDraftStatePortraitByIndex(CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_NORMAL, f13_local0)))
		end
	end)
	self:addElement(CodCasterPortraitPlayerListEntrySpecialistHead)
	self.CodCasterPortraitPlayerListEntrySpecialistHead = CodCasterPortraitPlayerListEntrySpecialistHead
	local CodCasterPortraitPlayerListEntryExtra = CoD.CodCasterPortraitPlayerListEntryExtra.new(f1_arg0, f1_arg1, 0.03, 1.03, 0, 0, 0.5, 0.5, 42, 75)
	CodCasterPortraitPlayerListEntryExtra:setAlpha(0)
	CodCasterPortraitPlayerListEntryExtra:linkToElementModel(self, nil, false, function(model)
		CodCasterPortraitPlayerListEntryExtra:setModel(model, f1_arg1)
	end)
	CodCasterPortraitPlayerListEntryExtra:linkToElementModel(self, "currentStreak", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			CodCasterPortraitPlayerListEntryExtra.PlayerListEntryStreak:setText(GetScoreboardCurrentStreak(f1_arg1, f15_local0))
		end
	end)
	CodCasterPortraitPlayerListEntryExtra:linkToElementModel(self, "clientNumScoreInfoUpdated", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			CodCasterPortraitPlayerListEntryExtra.PlayerListEntryKD:setText(GetCodcasterPlayerListKD(f1_arg1, f16_local0))
		end
	end)
	self:addElement(CodCasterPortraitPlayerListEntryExtra)
	self.CodCasterPortraitPlayerListEntryExtra = CodCasterPortraitPlayerListEntryExtra
	local BGTOP = LUI.UIImage.new(0, 0, -0.5, 131.5, 0, 0, 1, 93)
	BGTOP:setImage(RegisterImage(0xF0066F1C01EE0A0))
	self:addElement(BGTOP)
	self.BGTOP = BGTOP
	local ledplayer = LUI.UIImage.new(0, 0, 67, 127, 0, 0, 6, 54)
	ledplayer:setAlpha(0)
	ledplayer:setImage(RegisterImage(0x75B3EFBC7542A9D))
	ledplayer:subscribeToGlobalModel(f1_arg1, "FactionsGlobal", "alliesFactionColor", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			ledplayer:setRGB(f17_local0)
		end
	end)
	self:addElement(ledplayer)
	self.ledplayer = ledplayer
	local ScrStkButtons = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	ScrStkButtons:setLeftRight(0.5, 0.5, -60, 60)
	ScrStkButtons:setTopBottom(0.5, 0.5, 12, 36)
	ScrStkButtons:setAlpha(0)
	ScrStkButtons:setWidgetType(CoD.CodCasterSupportButton)
	ScrStkButtons:setHorizontalCount(3)
	ScrStkButtons:setSpacing(0)
	ScrStkButtons:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ScrStkButtons:setDataSource("KillstreakList")
	self:addElement(ScrStkButtons)
	self.ScrStkButtons = ScrStkButtons
	local HealthBar = CoD.HealthBarWidget.new(f1_arg0, f1_arg1, 0.17, 0.93, -6, -6, 0, 0, 73, 83)
	HealthBar:setScale(0.75, 0.75)
	HealthBar:linkToElementModel(self, "health", false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	local cornerImage = LUI.UIImage.new(0, 0, 93, 125, 0, 0, 7.5, 39.5)
	cornerImage:setAlpha(0.5)
	cornerImage:setImage(RegisterImage(0x2D507B944A58E16))
	self:addElement(cornerImage)
	self.cornerImage = cornerImage
	local CodCasterPortraitPlayerListEntryEquipment = CoD.CodCasterPortraitPlayerListEntryEquipment.new(f1_arg0, f1_arg1, 0, 0, 96.5, 122.5, 0, 0, 28.5, 54.5)
	CodCasterPortraitPlayerListEntryEquipment:linkToElementModel(self, nil, false, function(model)
		CodCasterPortraitPlayerListEntryEquipment:setModel(model, f1_arg1)
	end)
	self:addElement(CodCasterPortraitPlayerListEntryEquipment)
	self.CodCasterPortraitPlayerListEntryEquipment = CodCasterPortraitPlayerListEntryEquipment
	local UltimateBackgroundPlayerPortrait = LUI.UIImage.new(0, 0, 29, 139, 0, 0, -28, 82)
	UltimateBackgroundPlayerPortrait:setScale(0.3, 0.3)
	UltimateBackgroundPlayerPortrait:setImage(RegisterImage(0x570235F8AFEF1B))
	self:addElement(UltimateBackgroundPlayerPortrait)
	self.UltimateBackgroundPlayerPortrait = UltimateBackgroundPlayerPortrait
	local UltimateProgressFillPlayerPortrait = CoD.AmmoWidgetMP_Ultimate_Progress_Fill_Player_Portrait.new(f1_arg0, f1_arg1, 0, 0, 29, 139, 0, 0, -28, 82)
	UltimateProgressFillPlayerPortrait:setScale(0.3, 0.3)
	UltimateProgressFillPlayerPortrait:linkToElementModel(self, "playerGadget", false, function(model)
		UltimateProgressFillPlayerPortrait:setModel(model, f1_arg1)
	end)
	self:addElement(UltimateProgressFillPlayerPortrait)
	self.UltimateProgressFillPlayerPortrait = UltimateProgressFillPlayerPortrait
	local PlayerListEntryId = CoD.CodCasterPortraitPlayerListNumber.new(f1_arg0, f1_arg1, 0, 0, 106.5, 124.5, 0, 0, 4, 29)
	PlayerListEntryId:setScale(1.1, 1.1)
	PlayerListEntryId:linkToElementModel(self, nil, false, function(model)
		PlayerListEntryId:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerListEntryId)
	self.PlayerListEntryId = PlayerListEntryId
	local Frame = CoD.codcaster_player_portrait_frames.new(f1_arg0, f1_arg1, 0, 0, 0, 132, 0, 0, 0, 156)
	Frame:linkToElementModel(self, nil, false, function(model)
		Frame:setModel(model, f1_arg1)
	end)
	self:addElement(Frame)
	self.Frame = Frame
	local codcasterplayerPortraitName = CoD.codcaster_playerPortraitName.new(f1_arg0, f1_arg1, 0, 0, 6, 126, 0, 0, 56, 73)
	codcasterplayerPortraitName:linkToElementModel(self, nil, false, function(model)
		codcasterplayerPortraitName:setModel(model, f1_arg1)
	end)
	self:addElement(codcasterplayerPortraitName)
	self.codcasterplayerPortraitName = codcasterplayerPortraitName
	local PlayerDeadOverlay = LUI.UIImage.new(0.5, 0.5, -61, 61, 0, 0, 3, 85)
	PlayerDeadOverlay:setRGB(0.06, 0.06, 0.06)
	PlayerDeadOverlay:setAlpha(0)
	self:addElement(PlayerDeadOverlay)
	self.PlayerDeadOverlay = PlayerDeadOverlay
	local CodCasterPortraitPlayerListEntryDeathMarker = CoD.CodCasterPortraitPlayerListEntryDeathMarker.new(f1_arg0, f1_arg1, 0, 0, 14.5, 57.5, 0, 0, 8.5, 51.5)
	CodCasterPortraitPlayerListEntryDeathMarker:linkToElementModel(self, nil, false, function(model)
		CodCasterPortraitPlayerListEntryDeathMarker:setModel(model, f1_arg1)
	end)
	self:addElement(CodCasterPortraitPlayerListEntryDeathMarker)
	self.CodCasterPortraitPlayerListEntryDeathMarker = CodCasterPortraitPlayerListEntryDeathMarker
	self:mergeStateConditions({
		{
			stateName = "fullheistDead",
			condition = function(menu, element, event)
				local f25_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
				if f25_local0 then
					f25_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
					if f25_local0 then
						f25_local0 = CoD.HUDUtility.IsGameTypeEqualToString("bounty")
						if f25_local0 then
							f25_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
						end
					end
				end
				return f25_local0
			end,
		},
		{
			stateName = "mediumstreakDead",
			condition = function(menu, element, event)
				local f26_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
				if f26_local0 then
					f26_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 0)
					if f26_local0 then
						if not CoD.HUDUtility.IsGameTypeEqualToString("bounty") then
							f26_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
						else
							f26_local0 = false
						end
					end
				end
				return f26_local0
			end,
		},
		{
			stateName = "mediuminfoDead",
			condition = function(menu, element, event)
				local f27_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
				if f27_local0 then
					f27_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 0)
					if f27_local0 then
						f27_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
					end
				end
				return f27_local0
			end,
		},
		{
			stateName = "fullDead",
			condition = function(menu, element, event)
				local f28_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
				if f28_local0 then
					f28_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
					if f28_local0 then
						if not CoD.HUDUtility.IsGameTypeEqualToString("bounty") then
							f28_local0 = CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "health.healthValue", 0)
						else
							f28_local0 = false
						end
					end
				end
				return f28_local0
			end,
		},
		{
			stateName = "full",
			condition = function(menu, element, event)
				local f29_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
				if f29_local0 then
					f29_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
					if f29_local0 then
						f29_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("bounty")
					end
				end
				return f29_local0
			end,
		},
		{
			stateName = "fullheist",
			condition = function(menu, element, event)
				local f30_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1)
				if f30_local0 then
					f30_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
					if f30_local0 then
						f30_local0 = CoD.HUDUtility.IsGameTypeEqualToString("bounty")
					end
				end
				return f30_local0
			end,
		},
		{
			stateName = "mediumstreak",
			condition = function(menu, element, event)
				local f31_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 1)
				if f31_local0 then
					f31_local0 = IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 0)
					if f31_local0 then
						f31_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("bounty")
					end
				end
				return f31_local0
			end,
		},
		{
			stateName = "mediuminfo",
			condition = function(menu, element, event)
				return IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_stats", 1) and IsCodCasterProfileValueEqualTo(f1_arg1, "shoutcaster_ds_portrait_scorestreaks", 0)
			end,
		},
	})
	local f1_local25 = self
	local f1_local26 = self.subscribeToModel
	local f1_local27 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local26(f1_local25, f1_local27.profileSettingsUpdated, function(f33_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	self.__on_menuOpened_self = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
		local f35_local0 = self
		CoD.CodCasterUtility.ForcePortraitUpdate(self, f35_arg1)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:linkToElementModel(self, "clientNum", true, function(model)
		local f36_local0 = self
		UpdateDataSource(self, self.ScrStkButtons, f1_arg1)
	end)
	ScrStkButtons.id = "ScrStkButtons"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local26 = self
	if IsMultiplayer() then
		CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
		CoD.HealthUtility.InitHealthBarLossPulse(self, self.HealthBar, f1_arg1, CoD.HealthBarWidgetPulsePortraitList, f1_arg0)
		CoD.HUDUtility.AddCustomGainFocusWidget(self, self.HealthBar)
	end
	return self
end
CoD.codcaster_player_portraittop_team1.__resetProperties = function(f38_arg0)
	f38_arg0.ObjectiveStatus:completeAnimation()
	f38_arg0.PlayerPortraitHoverTop:completeAnimation()
	f38_arg0.CodCasterPortraitPlayerListEntryExtra:completeAnimation()
	f38_arg0.mediumBG2:completeAnimation()
	f38_arg0.PlayerPortraitFocusBottom:completeAnimation()
	f38_arg0.PlayerPortraitHoverBottom:completeAnimation()
	f38_arg0.PlayerDeadOverlay:completeAnimation()
	f38_arg0.ScrStkButtons:completeAnimation()
	f38_arg0.mediumBG:completeAnimation()
	f38_arg0.PlayerPortraitFocusTop:completeAnimation()
	f38_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -74, -10)
	f38_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -11, 5)
	f38_arg0.CodCasterPortraitPlayerListEntryExtra:setTopBottom(0.5, 0.5, 42, 75)
	f38_arg0.CodCasterPortraitPlayerListEntryExtra:setAlpha(0)
	f38_arg0.mediumBG2:setTopBottom(0.5, 0.5, 42, 75)
	f38_arg0.mediumBG2:setAlpha(0)
	f38_arg0.PlayerPortraitFocusBottom:setTopBottom(0, 0, 82, 98)
	f38_arg0.PlayerPortraitHoverBottom:setTopBottom(0, 0, 82, 98)
	f38_arg0.PlayerDeadOverlay:setTopBottom(0, 0, 3, 85)
	f38_arg0.PlayerDeadOverlay:setAlpha(0)
	f38_arg0.ScrStkButtons:setAlpha(0)
	f38_arg0.mediumBG:setTopBottom(0, 0, 85, 121)
	f38_arg0.mediumBG:setAlpha(0)
	f38_arg0.PlayerPortraitFocusTop:setTopBottom(0, 0, -11, 5)
end
CoD.codcaster_player_portraittop_team1.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(2)
			f39_arg0.PlayerPortraitHoverTop:completeAnimation()
			f39_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -10, 6)
			f39_arg0.clipFinished(f39_arg0.PlayerPortraitHoverTop)
			f39_arg0.ObjectiveStatus:completeAnimation()
			f39_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -76, -12)
			f39_arg0.clipFinished(f39_arg0.ObjectiveStatus)
		end,
	},
	fullheistDead = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(7)
			f40_arg0.PlayerPortraitHoverBottom:completeAnimation()
			f40_arg0.PlayerPortraitHoverBottom:setTopBottom(0, 0, 114, 130)
			f40_arg0.clipFinished(f40_arg0.PlayerPortraitHoverBottom)
			f40_arg0.PlayerPortraitHoverTop:completeAnimation()
			f40_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -10, 6)
			f40_arg0.clipFinished(f40_arg0.PlayerPortraitHoverTop)
			f40_arg0.PlayerPortraitFocusBottom:completeAnimation()
			f40_arg0.PlayerPortraitFocusBottom:setTopBottom(0, 0, 114, 130)
			f40_arg0.clipFinished(f40_arg0.PlayerPortraitFocusBottom)
			f40_arg0.ObjectiveStatus:completeAnimation()
			f40_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -42, 22)
			f40_arg0.clipFinished(f40_arg0.ObjectiveStatus)
			f40_arg0.mediumBG2:completeAnimation()
			f40_arg0.mediumBG2:setTopBottom(0.5, 0.5, 8.5, 41.5)
			f40_arg0.mediumBG2:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.mediumBG2)
			f40_arg0.CodCasterPortraitPlayerListEntryExtra:completeAnimation()
			f40_arg0.CodCasterPortraitPlayerListEntryExtra:setTopBottom(0.5, 0.5, 9.5, 42.5)
			f40_arg0.CodCasterPortraitPlayerListEntryExtra:setAlpha(1)
			f40_arg0.clipFinished(f40_arg0.CodCasterPortraitPlayerListEntryExtra)
			f40_arg0.PlayerDeadOverlay:completeAnimation()
			f40_arg0.PlayerDeadOverlay:setAlpha(0.8)
			f40_arg0.clipFinished(f40_arg0.PlayerDeadOverlay)
		end,
	},
	mediumstreakDead = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(7)
			f41_arg0.mediumBG:completeAnimation()
			f41_arg0.mediumBG:setTopBottom(0, 0, 85, 119)
			f41_arg0.mediumBG:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.mediumBG)
			f41_arg0.PlayerPortraitHoverBottom:completeAnimation()
			f41_arg0.PlayerPortraitHoverBottom:setTopBottom(0, 0, 114, 130)
			f41_arg0.clipFinished(f41_arg0.PlayerPortraitHoverBottom)
			f41_arg0.PlayerPortraitHoverTop:completeAnimation()
			f41_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -10, 6)
			f41_arg0.clipFinished(f41_arg0.PlayerPortraitHoverTop)
			f41_arg0.PlayerPortraitFocusBottom:completeAnimation()
			f41_arg0.PlayerPortraitFocusBottom:setTopBottom(0, 0, 114, 130)
			f41_arg0.clipFinished(f41_arg0.PlayerPortraitFocusBottom)
			f41_arg0.ObjectiveStatus:completeAnimation()
			f41_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -42, 22)
			f41_arg0.clipFinished(f41_arg0.ObjectiveStatus)
			f41_arg0.ScrStkButtons:completeAnimation()
			f41_arg0.ScrStkButtons:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.ScrStkButtons)
			f41_arg0.PlayerDeadOverlay:completeAnimation()
			f41_arg0.PlayerDeadOverlay:setTopBottom(0, 0, 3, 119)
			f41_arg0.PlayerDeadOverlay:setAlpha(0.8)
			f41_arg0.clipFinished(f41_arg0.PlayerDeadOverlay)
		end,
	},
	mediuminfoDead = {
		DefaultClip = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(8)
			f42_arg0.PlayerPortraitHoverBottom:completeAnimation()
			f42_arg0.PlayerPortraitHoverBottom:setTopBottom(0, 0, 114, 130)
			f42_arg0.clipFinished(f42_arg0.PlayerPortraitHoverBottom)
			f42_arg0.PlayerPortraitHoverTop:completeAnimation()
			f42_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -10, 6)
			f42_arg0.clipFinished(f42_arg0.PlayerPortraitHoverTop)
			f42_arg0.PlayerPortraitFocusBottom:completeAnimation()
			f42_arg0.PlayerPortraitFocusBottom:setTopBottom(0, 0, 114, 130)
			f42_arg0.clipFinished(f42_arg0.PlayerPortraitFocusBottom)
			f42_arg0.PlayerPortraitFocusTop:completeAnimation()
			f42_arg0.PlayerPortraitFocusTop:setTopBottom(0, 0, -10, 6)
			f42_arg0.clipFinished(f42_arg0.PlayerPortraitFocusTop)
			f42_arg0.ObjectiveStatus:completeAnimation()
			f42_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -42, 22)
			f42_arg0.clipFinished(f42_arg0.ObjectiveStatus)
			f42_arg0.mediumBG2:completeAnimation()
			f42_arg0.mediumBG2:setTopBottom(0.5, 0.5, 8.5, 41.5)
			f42_arg0.mediumBG2:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.mediumBG2)
			f42_arg0.CodCasterPortraitPlayerListEntryExtra:completeAnimation()
			f42_arg0.CodCasterPortraitPlayerListEntryExtra:setTopBottom(0.5, 0.5, 9.5, 42.5)
			f42_arg0.CodCasterPortraitPlayerListEntryExtra:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.CodCasterPortraitPlayerListEntryExtra)
			f42_arg0.PlayerDeadOverlay:completeAnimation()
			f42_arg0.PlayerDeadOverlay:setAlpha(0.8)
			f42_arg0.clipFinished(f42_arg0.PlayerDeadOverlay)
		end,
	},
	fullDead = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(9)
			f43_arg0.mediumBG:completeAnimation()
			f43_arg0.mediumBG:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.mediumBG)
			f43_arg0.PlayerPortraitHoverBottom:completeAnimation()
			f43_arg0.PlayerPortraitHoverBottom:setTopBottom(0, 0, 147, 163)
			f43_arg0.clipFinished(f43_arg0.PlayerPortraitHoverBottom)
			f43_arg0.PlayerPortraitHoverTop:completeAnimation()
			f43_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -10, 6)
			f43_arg0.clipFinished(f43_arg0.PlayerPortraitHoverTop)
			f43_arg0.PlayerPortraitFocusBottom:completeAnimation()
			f43_arg0.PlayerPortraitFocusBottom:setTopBottom(0, 0, 147, 163)
			f43_arg0.clipFinished(f43_arg0.PlayerPortraitFocusBottom)
			f43_arg0.ObjectiveStatus:completeAnimation()
			f43_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -8, 56)
			f43_arg0.clipFinished(f43_arg0.ObjectiveStatus)
			f43_arg0.mediumBG2:completeAnimation()
			f43_arg0.mediumBG2:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.mediumBG2)
			f43_arg0.CodCasterPortraitPlayerListEntryExtra:completeAnimation()
			f43_arg0.CodCasterPortraitPlayerListEntryExtra:setTopBottom(0.5, 0.5, 42, 75)
			f43_arg0.CodCasterPortraitPlayerListEntryExtra:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.CodCasterPortraitPlayerListEntryExtra)
			f43_arg0.ScrStkButtons:completeAnimation()
			f43_arg0.ScrStkButtons:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.ScrStkButtons)
			f43_arg0.PlayerDeadOverlay:completeAnimation()
			f43_arg0.PlayerDeadOverlay:setTopBottom(0, 0, 3, 117)
			f43_arg0.PlayerDeadOverlay:setAlpha(0.8)
			f43_arg0.clipFinished(f43_arg0.PlayerDeadOverlay)
		end,
	},
	full = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(8)
			f44_arg0.mediumBG:completeAnimation()
			f44_arg0.mediumBG:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.mediumBG)
			f44_arg0.PlayerPortraitHoverBottom:completeAnimation()
			f44_arg0.PlayerPortraitHoverBottom:setTopBottom(0, 0, 147, 163)
			f44_arg0.clipFinished(f44_arg0.PlayerPortraitHoverBottom)
			f44_arg0.PlayerPortraitHoverTop:completeAnimation()
			f44_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -10, 6)
			f44_arg0.clipFinished(f44_arg0.PlayerPortraitHoverTop)
			f44_arg0.PlayerPortraitFocusBottom:completeAnimation()
			f44_arg0.PlayerPortraitFocusBottom:setTopBottom(0, 0, 147, 163)
			f44_arg0.clipFinished(f44_arg0.PlayerPortraitFocusBottom)
			f44_arg0.ObjectiveStatus:completeAnimation()
			f44_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -8, 56)
			f44_arg0.clipFinished(f44_arg0.ObjectiveStatus)
			f44_arg0.mediumBG2:completeAnimation()
			f44_arg0.mediumBG2:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.mediumBG2)
			f44_arg0.CodCasterPortraitPlayerListEntryExtra:completeAnimation()
			f44_arg0.CodCasterPortraitPlayerListEntryExtra:setTopBottom(0.5, 0.5, 42, 75)
			f44_arg0.CodCasterPortraitPlayerListEntryExtra:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.CodCasterPortraitPlayerListEntryExtra)
			f44_arg0.ScrStkButtons:completeAnimation()
			f44_arg0.ScrStkButtons:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.ScrStkButtons)
		end,
	},
	fullheist = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(6)
			f45_arg0.PlayerPortraitHoverBottom:completeAnimation()
			f45_arg0.PlayerPortraitHoverBottom:setTopBottom(0, 0, 114, 130)
			f45_arg0.clipFinished(f45_arg0.PlayerPortraitHoverBottom)
			f45_arg0.PlayerPortraitHoverTop:completeAnimation()
			f45_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -10, 6)
			f45_arg0.clipFinished(f45_arg0.PlayerPortraitHoverTop)
			f45_arg0.PlayerPortraitFocusBottom:completeAnimation()
			f45_arg0.PlayerPortraitFocusBottom:setTopBottom(0, 0, 114, 130)
			f45_arg0.clipFinished(f45_arg0.PlayerPortraitFocusBottom)
			f45_arg0.ObjectiveStatus:completeAnimation()
			f45_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -42, 22)
			f45_arg0.clipFinished(f45_arg0.ObjectiveStatus)
			f45_arg0.mediumBG2:completeAnimation()
			f45_arg0.mediumBG2:setTopBottom(0.5, 0.5, 8.5, 41.5)
			f45_arg0.mediumBG2:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.mediumBG2)
			f45_arg0.CodCasterPortraitPlayerListEntryExtra:completeAnimation()
			f45_arg0.CodCasterPortraitPlayerListEntryExtra:setTopBottom(0.5, 0.5, 9.5, 42.5)
			f45_arg0.CodCasterPortraitPlayerListEntryExtra:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.CodCasterPortraitPlayerListEntryExtra)
		end,
	},
	mediumstreak = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(6)
			f46_arg0.mediumBG:completeAnimation()
			f46_arg0.mediumBG:setTopBottom(0, 0, 85, 119)
			f46_arg0.mediumBG:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.mediumBG)
			f46_arg0.PlayerPortraitHoverBottom:completeAnimation()
			f46_arg0.PlayerPortraitHoverBottom:setTopBottom(0, 0, 114, 130)
			f46_arg0.clipFinished(f46_arg0.PlayerPortraitHoverBottom)
			f46_arg0.PlayerPortraitHoverTop:completeAnimation()
			f46_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -10, 6)
			f46_arg0.clipFinished(f46_arg0.PlayerPortraitHoverTop)
			f46_arg0.PlayerPortraitFocusBottom:completeAnimation()
			f46_arg0.PlayerPortraitFocusBottom:setTopBottom(0, 0, 114, 130)
			f46_arg0.clipFinished(f46_arg0.PlayerPortraitFocusBottom)
			f46_arg0.ObjectiveStatus:completeAnimation()
			f46_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -42, 22)
			f46_arg0.clipFinished(f46_arg0.ObjectiveStatus)
			f46_arg0.ScrStkButtons:completeAnimation()
			f46_arg0.ScrStkButtons:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.ScrStkButtons)
		end,
	},
	mediuminfo = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(7)
			f47_arg0.PlayerPortraitHoverBottom:completeAnimation()
			f47_arg0.PlayerPortraitHoverBottom:setTopBottom(0, 0, 114, 130)
			f47_arg0.clipFinished(f47_arg0.PlayerPortraitHoverBottom)
			f47_arg0.PlayerPortraitHoverTop:completeAnimation()
			f47_arg0.PlayerPortraitHoverTop:setTopBottom(0, 0, -10, 6)
			f47_arg0.clipFinished(f47_arg0.PlayerPortraitHoverTop)
			f47_arg0.PlayerPortraitFocusBottom:completeAnimation()
			f47_arg0.PlayerPortraitFocusBottom:setTopBottom(0, 0, 114, 130)
			f47_arg0.clipFinished(f47_arg0.PlayerPortraitFocusBottom)
			f47_arg0.PlayerPortraitFocusTop:completeAnimation()
			f47_arg0.PlayerPortraitFocusTop:setTopBottom(0, 0, -10, 6)
			f47_arg0.clipFinished(f47_arg0.PlayerPortraitFocusTop)
			f47_arg0.ObjectiveStatus:completeAnimation()
			f47_arg0.ObjectiveStatus:setTopBottom(1.05, 1.05, -42, 22)
			f47_arg0.clipFinished(f47_arg0.ObjectiveStatus)
			f47_arg0.mediumBG2:completeAnimation()
			f47_arg0.mediumBG2:setTopBottom(0.5, 0.5, 8.5, 41.5)
			f47_arg0.mediumBG2:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.mediumBG2)
			f47_arg0.CodCasterPortraitPlayerListEntryExtra:completeAnimation()
			f47_arg0.CodCasterPortraitPlayerListEntryExtra:setTopBottom(0.5, 0.5, 9.5, 42.5)
			f47_arg0.CodCasterPortraitPlayerListEntryExtra:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.CodCasterPortraitPlayerListEntryExtra)
		end,
	},
}
CoD.codcaster_player_portraittop_team1.__onClose = function(f48_arg0)
	f48_arg0.__on_close_removeOverrides()
	f48_arg0.PlayerPortraitHoverBottom:close()
	f48_arg0.PlayerPortraitHoverTop:close()
	f48_arg0.PlayerPortraitFocusBottom:close()
	f48_arg0.PlayerPortraitFocusTop:close()
	f48_arg0.ObjectiveStatus:close()
	f48_arg0.teamcolorbg:close()
	f48_arg0.CodCasterPortraitPlayerListEntrySpecialistHead:close()
	f48_arg0.CodCasterPortraitPlayerListEntryExtra:close()
	f48_arg0.ledplayer:close()
	f48_arg0.ScrStkButtons:close()
	f48_arg0.HealthBar:close()
	f48_arg0.CodCasterPortraitPlayerListEntryEquipment:close()
	f48_arg0.UltimateProgressFillPlayerPortrait:close()
	f48_arg0.PlayerListEntryId:close()
	f48_arg0.Frame:close()
	f48_arg0.codcasterplayerPortraitName:close()
	f48_arg0.CodCasterPortraitPlayerListEntryDeathMarker:close()
end
