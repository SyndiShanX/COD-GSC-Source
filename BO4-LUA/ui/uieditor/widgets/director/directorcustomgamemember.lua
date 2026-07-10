require("x64:235c8e60fecf1a")
require("x64:174f2b412760fd3")
require("x64:7610254bee05fe0")
require("x64:e12ddba2d13fc72")
require("x64:2675595fa323085")
CoD.DirectorCustomGameMember = InheritFrom(LUI.UIElement)
CoD.DirectorCustomGameMember.__defaultWidth = 425
CoD.DirectorCustomGameMember.__defaultHeight = 40
CoD.DirectorCustomGameMember.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorCustomGameMember)
	self.id = "DirectorCustomGameMember"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local PixelGrid = LUI.UIImage.new(0, 1, 0, 0, -0.31, 1, 12, 0)
	PixelGrid:setAlpha(0.35)
	PixelGrid:setImage(RegisterImage(0x311E811A3183347))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(128, 128)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local EmptyBacking = LUI.UIImage.new(0, 1, 0, 0, 0.1, 1.1, -4, -4)
	EmptyBacking.__Color = function()
		EmptyBacking:setRGB(CoD.TeamUtility.GetTeamFactionColor(0, 0.32, 0.34))
	end
	EmptyBacking.__Color()
	EmptyBacking:setAlpha(0)
	self:addElement(EmptyBacking)
	self.EmptyBacking = EmptyBacking
	local TeamColorBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TeamColorBacking:setAlpha(0.05)
	TeamColorBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	TeamColorBacking.__Color = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			TeamColorBacking:setRGB(CoD.TeamUtility.GetTeamFactionColor(f3_local0))
		end
	end
	TeamColorBacking:linkToElementModel(self, "info", true, function(model, f4_arg1)
		if f4_arg1["__TeamColorBacking.__Color_info->team"] then
			f4_arg1:removeSubscription(f4_arg1["__TeamColorBacking.__Color_info->team"])
			f4_arg1["__TeamColorBacking.__Color_info->team"] = nil
		end
		if model then
			local f4_local0 = model:get()
			local f4_local1 = model:get()
			model = f4_local0 and f4_local1.team
		end
		if model then
			f4_arg1["__TeamColorBacking.__Color_info->team"] = f4_arg1:subscribeToModel(model, TeamColorBacking.__Color)
		end
	end)
	TeamColorBacking.__Color_FullPath = function()
		local f5_local0 = self:getModel()
		if f5_local0 then
			f5_local0 = self:getModel()
			f5_local0 = f5_local0.info
		end
		if f5_local0 then
			f5_local0 = f5_local0:get()
		end
		if f5_local0 then
			f5_local0 = f5_local0.team
		end
		if f5_local0 then
			TeamColorBacking.__Color(f5_local0)
		end
	end
	self:addElement(TeamColorBacking)
	self.TeamColorBacking = TeamColorBacking
	local BaseBacking = LUI.UIImage.new(0, 0, 0, 425, 0, 1, 0, 0)
	BaseBacking:setRGB(0.07, 0.07, 0.07)
	BaseBacking:setAlpha(0.5)
	self:addElement(BaseBacking)
	self.BaseBacking = BaseBacking
	local EmblemBacking = LUI.UIImage.new(0, 0, 0, 40, 0.5, 0.5, -20, 20)
	EmblemBacking:setRGB(0, 0, 0)
	EmblemBacking:setAlpha(0.8)
	self:addElement(EmblemBacking)
	self.EmblemBacking = EmblemBacking
	local rankicon = LUI.UIImage.new(0, 0, 0, 39, 0.5, 0.5, -19.5, 19.5)
	rankicon:setAlpha(0)
	rankicon.__Image = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			rankicon:setImage(RegisterImage(f6_local0))
		end
	end
	rankicon:linkToElementModel(self, "info", true, function(model, f7_arg1)
		if f7_arg1["__rankicon.__Image_info->rankIcon"] then
			f7_arg1:removeSubscription(f7_arg1["__rankicon.__Image_info->rankIcon"])
			f7_arg1["__rankicon.__Image_info->rankIcon"] = nil
		end
		if model then
			local f7_local0 = model:get()
			local f7_local1 = model:get()
			model = f7_local0 and f7_local1.rankIcon
		end
		if model then
			f7_arg1["__rankicon.__Image_info->rankIcon"] = f7_arg1:subscribeToModel(model, rankicon.__Image)
		end
	end)
	self:addElement(rankicon)
	self.rankicon = rankicon
	local emblem = LUI.UIImage.new(0, 0, 0, 40, 0.5, 0.5, -20, 20)
	emblem.__XUID = function(f8_arg0)
		local f8_local0 = f8_arg0:get()
		if f8_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f8_local0)
		end
	end
	emblem:linkToElementModel(self, "info", true, function(model, f9_arg1)
		if f9_arg1["__emblem.__XUID_info->xuid"] then
			f9_arg1:removeSubscription(f9_arg1["__emblem.__XUID_info->xuid"])
			f9_arg1["__emblem.__XUID_info->xuid"] = nil
		end
		if model then
			local f9_local0 = model:get()
			local f9_local1 = model:get()
			model = f9_local0 and f9_local1.xuid
		end
		if model then
			f9_arg1["__emblem.__XUID_info->xuid"] = f9_arg1:subscribeToModel(model, emblem.__XUID)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local LeaderBacking = CoD.DirectorPartyLeader.new(f1_arg0, f1_arg1, 0, 0, 380.5, 430.5, 0.5, 0.5, -25, 25)
	LeaderBacking:linkToElementModel(self, nil, false, function(model)
		LeaderBacking:setModel(model, f1_arg1)
	end)
	self:addElement(LeaderBacking)
	self.LeaderBacking = LeaderBacking
	local membername = CoD.DirectorLobbyClanAndMemberName.new(f1_arg0, f1_arg1, 0, 0, 44, 264, 0.5, 0.5, -10.5, 10.5)
	membername:linkToElementModel(self, "info", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			membername:setModel(f11_local0, f1_arg1)
		end
	end)
	self:addElement(membername)
	self.membername = membername
	local CornerDotBRAnim = LUI.UIImage.new(0, 0, 369, 370, 0, 0, 69, 70)
	CornerDotBRAnim:setAlpha(0)
	self:addElement(CornerDotBRAnim)
	self.CornerDotBRAnim = CornerDotBRAnim
	local CornerLineBRAnim = LUI.UIImage.new(0, 0, 369, 370, 0, 0, 6, 7)
	CornerLineBRAnim:setAlpha(0)
	self:addElement(CornerLineBRAnim)
	self.CornerLineBRAnim = CornerLineBRAnim
	local CornerDotBRAnim2 = LUI.UIImage.new(0, 0, 110, 111, 0, 0, 62.5, 63.5)
	CornerDotBRAnim2:setAlpha(0)
	self:addElement(CornerDotBRAnim2)
	self.CornerDotBRAnim2 = CornerDotBRAnim2
	local CornerLineBRAnim4 = LUI.UIImage.new(0, 0, 110, 111, 0, 0, -0.5, 0.5)
	CornerLineBRAnim4:setAlpha(0)
	self:addElement(CornerLineBRAnim4)
	self.CornerLineBRAnim4 = CornerLineBRAnim4
	local VoipWaves = CoD.OnOffVoip.new(f1_arg0, f1_arg1, 0, 0, -31, 9, 0, 0, 12, 28)
	VoipWaves:setZRot(90)
	VoipWaves:linkToElementModel(self, "info", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			VoipWaves:setModel(f12_local0, f1_arg1)
		end
	end)
	self:addElement(VoipWaves)
	self.VoipWaves = VoipWaves
	local DirectorCustomStartButton = CoD.DirectorButtonAdd.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorCustomStartButton:setAlpha(0)
	DirectorCustomStartButton.CommonButtonOutline.FocusGlow:setScale(1, 0.7)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:linkToElementModel(self, nil, false, function(model)
		emptyFocusable:setModel(model, f1_arg1)
	end)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local FrontendFrame02 = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -2, 2)
	FrontendFrame02:setAlpha(0.2)
	FrontendFrame02:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame02:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame02:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame02:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame02)
	self.FrontendFrame02 = FrontendFrame02
	local SelectedOverlay = nil
	SelectedOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectedOverlay:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	SelectedOverlay:setAlpha(0)
	SelectedOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(SelectedOverlay)
	self.SelectedOverlay = SelectedOverlay
	local f1_local20 = EmptyBacking
	local f1_local21 = EmptyBacking.subscribeToModel
	local f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["MapVote.mapVoteGameModeNext"], EmptyBacking.__Color)
	f1_local20 = TeamColorBacking
	f1_local21 = TeamColorBacking.subscribeToModel
	f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["MapVote.mapVoteGameModeNext"], TeamColorBacking.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "FirstEmpty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY) and not IsLobbyNetworkModeLAN()
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "clientListFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientListFlags",
		})
	end)
	f1_local20 = self
	f1_local21 = self.subscribeToModel
	f1_local22 = Engine[0x8DF2E5447F384B9]()
	f1_local21(f1_local20, f1_local22["lobbyRoot.lobbyNav"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorCustomStartButton.id = "DirectorCustomStartButton"
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	self.__defaultFocus = DirectorCustomStartButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local21 = self
	if IsPC() then
		CoD.PCWidgetUtility.SetupRightClickableContextualPlayerMenu(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorCustomGameMember.__resetProperties = function(f18_arg0)
	f18_arg0.SelectedOverlay:completeAnimation()
	f18_arg0.VoipWaves:completeAnimation()
	f18_arg0.CornerLineBRAnim4:completeAnimation()
	f18_arg0.CornerDotBRAnim2:completeAnimation()
	f18_arg0.membername:completeAnimation()
	f18_arg0.LeaderBacking:completeAnimation()
	f18_arg0.emblem:completeAnimation()
	f18_arg0.rankicon:completeAnimation()
	f18_arg0.EmblemBacking:completeAnimation()
	f18_arg0.TeamColorBacking:completeAnimation()
	f18_arg0.DirectorCustomStartButton:completeAnimation()
	f18_arg0.EmptyBacking:completeAnimation()
	f18_arg0.FrontendFrame02:completeAnimation()
	f18_arg0.SelectedOverlay:setAlpha(0)
	f18_arg0.VoipWaves:setAlpha(1)
	f18_arg0.CornerLineBRAnim4:setAlpha(0)
	f18_arg0.CornerDotBRAnim2:setAlpha(0)
	f18_arg0.membername:setAlpha(1)
	f18_arg0.LeaderBacking:setAlpha(1)
	f18_arg0.emblem:setAlpha(1)
	f18_arg0.rankicon:setAlpha(0)
	f18_arg0.EmblemBacking:setAlpha(0.8)
	f18_arg0.TeamColorBacking:setAlpha(0.05)
	f18_arg0.DirectorCustomStartButton:setAlpha(0)
	f18_arg0.DirectorCustomStartButton:setScale(1, 1)
	f18_arg0.EmptyBacking:setAlpha(0)
	f18_arg0.FrontendFrame02:setAlpha(0.2)
end
CoD.DirectorCustomGameMember.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.SelectedOverlay:completeAnimation()
			f20_arg0.SelectedOverlay:setAlpha(0.05)
			f20_arg0.clipFinished(f20_arg0.SelectedOverlay)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.SelectedOverlay:beginAnimation(200)
				f21_arg0.SelectedOverlay:setAlpha(0.05)
				f21_arg0.SelectedOverlay:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.SelectedOverlay:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.SelectedOverlay:completeAnimation()
			f21_arg0.SelectedOverlay:setAlpha(0)
			f21_local0(f21_arg0.SelectedOverlay)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.SelectedOverlay:beginAnimation(200)
				f23_arg0.SelectedOverlay:setAlpha(0)
				f23_arg0.SelectedOverlay:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.SelectedOverlay:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.SelectedOverlay:completeAnimation()
			f23_arg0.SelectedOverlay:setAlpha(0.05)
			f23_local0(f23_arg0.SelectedOverlay)
		end,
	},
	FirstEmpty = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(12)
			f25_arg0.EmptyBacking:completeAnimation()
			f25_arg0.EmptyBacking:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.EmptyBacking)
			f25_arg0.TeamColorBacking:completeAnimation()
			f25_arg0.TeamColorBacking:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.TeamColorBacking)
			f25_arg0.EmblemBacking:completeAnimation()
			f25_arg0.EmblemBacking:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.EmblemBacking)
			f25_arg0.rankicon:completeAnimation()
			f25_arg0.rankicon:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.rankicon)
			f25_arg0.emblem:completeAnimation()
			f25_arg0.emblem:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.emblem)
			f25_arg0.LeaderBacking:completeAnimation()
			f25_arg0.LeaderBacking:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.LeaderBacking)
			f25_arg0.membername:completeAnimation()
			f25_arg0.membername:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.membername)
			f25_arg0.CornerDotBRAnim2:completeAnimation()
			f25_arg0.CornerDotBRAnim2:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.CornerDotBRAnim2)
			f25_arg0.CornerLineBRAnim4:completeAnimation()
			f25_arg0.CornerLineBRAnim4:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.CornerLineBRAnim4)
			f25_arg0.VoipWaves:completeAnimation()
			f25_arg0.VoipWaves:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.VoipWaves)
			f25_arg0.DirectorCustomStartButton:completeAnimation()
			f25_arg0.DirectorCustomStartButton:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.DirectorCustomStartButton)
			f25_arg0.FrontendFrame02:completeAnimation()
			f25_arg0.FrontendFrame02:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.FrontendFrame02)
		end,
		ChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(12)
			f26_arg0.EmptyBacking:completeAnimation()
			f26_arg0.EmptyBacking:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.EmptyBacking)
			f26_arg0.TeamColorBacking:completeAnimation()
			f26_arg0.TeamColorBacking:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.TeamColorBacking)
			f26_arg0.EmblemBacking:completeAnimation()
			f26_arg0.EmblemBacking:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.EmblemBacking)
			f26_arg0.rankicon:completeAnimation()
			f26_arg0.rankicon:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.rankicon)
			f26_arg0.emblem:completeAnimation()
			f26_arg0.emblem:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.emblem)
			f26_arg0.LeaderBacking:completeAnimation()
			f26_arg0.LeaderBacking:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.LeaderBacking)
			f26_arg0.membername:completeAnimation()
			f26_arg0.membername:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.membername)
			f26_arg0.CornerDotBRAnim2:completeAnimation()
			f26_arg0.CornerDotBRAnim2:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.CornerDotBRAnim2)
			f26_arg0.CornerLineBRAnim4:completeAnimation()
			f26_arg0.CornerLineBRAnim4:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.CornerLineBRAnim4)
			f26_arg0.VoipWaves:completeAnimation()
			f26_arg0.VoipWaves:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.VoipWaves)
			f26_arg0.DirectorCustomStartButton:completeAnimation()
			f26_arg0.DirectorCustomStartButton:setAlpha(1)
			f26_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f26_arg0.clipFinished(f26_arg0.DirectorCustomStartButton)
			f26_arg0.FrontendFrame02:completeAnimation()
			f26_arg0.FrontendFrame02:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.FrontendFrame02)
		end,
		GainChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(12)
			f27_arg0.EmptyBacking:completeAnimation()
			f27_arg0.EmptyBacking:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.EmptyBacking)
			f27_arg0.TeamColorBacking:completeAnimation()
			f27_arg0.TeamColorBacking:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.TeamColorBacking)
			f27_arg0.EmblemBacking:completeAnimation()
			f27_arg0.EmblemBacking:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.EmblemBacking)
			f27_arg0.rankicon:completeAnimation()
			f27_arg0.rankicon:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.rankicon)
			f27_arg0.emblem:completeAnimation()
			f27_arg0.emblem:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.emblem)
			f27_arg0.LeaderBacking:completeAnimation()
			f27_arg0.LeaderBacking:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.LeaderBacking)
			f27_arg0.membername:completeAnimation()
			f27_arg0.membername:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.membername)
			f27_arg0.CornerDotBRAnim2:completeAnimation()
			f27_arg0.CornerDotBRAnim2:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.CornerDotBRAnim2)
			f27_arg0.CornerLineBRAnim4:completeAnimation()
			f27_arg0.CornerLineBRAnim4:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.CornerLineBRAnim4)
			f27_arg0.VoipWaves:completeAnimation()
			f27_arg0.VoipWaves:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.VoipWaves)
			local f27_local0 = function(f28_arg0)
				f27_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f27_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f27_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.DirectorCustomStartButton:completeAnimation()
			f27_arg0.DirectorCustomStartButton:setAlpha(1)
			f27_arg0.DirectorCustomStartButton:setScale(1, 1)
			f27_local0(f27_arg0.DirectorCustomStartButton)
			f27_arg0.FrontendFrame02:completeAnimation()
			f27_arg0.FrontendFrame02:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.FrontendFrame02)
		end,
		LoseChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(12)
			f29_arg0.EmptyBacking:completeAnimation()
			f29_arg0.EmptyBacking:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.EmptyBacking)
			f29_arg0.TeamColorBacking:completeAnimation()
			f29_arg0.TeamColorBacking:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.TeamColorBacking)
			f29_arg0.EmblemBacking:completeAnimation()
			f29_arg0.EmblemBacking:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.EmblemBacking)
			f29_arg0.rankicon:completeAnimation()
			f29_arg0.rankicon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.rankicon)
			f29_arg0.emblem:completeAnimation()
			f29_arg0.emblem:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.emblem)
			f29_arg0.LeaderBacking:completeAnimation()
			f29_arg0.LeaderBacking:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.LeaderBacking)
			f29_arg0.membername:completeAnimation()
			f29_arg0.membername:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.membername)
			f29_arg0.CornerDotBRAnim2:completeAnimation()
			f29_arg0.CornerDotBRAnim2:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.CornerDotBRAnim2)
			f29_arg0.CornerLineBRAnim4:completeAnimation()
			f29_arg0.CornerLineBRAnim4:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.CornerLineBRAnim4)
			f29_arg0.VoipWaves:completeAnimation()
			f29_arg0.VoipWaves:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.VoipWaves)
			local f29_local0 = function(f30_arg0)
				f29_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f29_arg0.DirectorCustomStartButton:setScale(1, 1)
				f29_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.DirectorCustomStartButton:completeAnimation()
			f29_arg0.DirectorCustomStartButton:setAlpha(1)
			f29_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f29_local0(f29_arg0.DirectorCustomStartButton)
			f29_arg0.FrontendFrame02:completeAnimation()
			f29_arg0.FrontendFrame02:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.FrontendFrame02)
		end,
	},
	Empty = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(8)
			f31_arg0.EmptyBacking:completeAnimation()
			f31_arg0.EmptyBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.EmptyBacking)
			f31_arg0.TeamColorBacking:completeAnimation()
			f31_arg0.TeamColorBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.TeamColorBacking)
			f31_arg0.EmblemBacking:completeAnimation()
			f31_arg0.EmblemBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.EmblemBacking)
			f31_arg0.rankicon:completeAnimation()
			f31_arg0.rankicon:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.rankicon)
			f31_arg0.emblem:completeAnimation()
			f31_arg0.emblem:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.emblem)
			f31_arg0.LeaderBacking:completeAnimation()
			f31_arg0.LeaderBacking:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.LeaderBacking)
			f31_arg0.membername:completeAnimation()
			f31_arg0.membername:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.membername)
			f31_arg0.VoipWaves:completeAnimation()
			f31_arg0.VoipWaves:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.VoipWaves)
		end,
	},
}
if not CoD.isPC then
	CoD.DirectorCustomGameMember.__clipsPerState.DefaultState.ChildFocus = nil
	CoD.DirectorCustomGameMember.__clipsPerState.DefaultState.GainChildFocus = nil
	CoD.DirectorCustomGameMember.__clipsPerState.DefaultState.LoseChildFocus = nil
end
CoD.DirectorCustomGameMember.__onClose = function(f32_arg0)
	f32_arg0.EmptyBacking:close()
	f32_arg0.TeamColorBacking:close()
	f32_arg0.rankicon:close()
	f32_arg0.emblem:close()
	f32_arg0.LeaderBacking:close()
	f32_arg0.membername:close()
	f32_arg0.VoipWaves:close()
	f32_arg0.DirectorCustomStartButton:close()
	f32_arg0.emptyFocusable:close()
end
