require("x64:9f606d91eab9f64")
require("x64:f2d1a483313445c")
require("x64:3e426332d66c91e")
require("x64:dab8c3a6f5b136c")
require("x64:e38247e77bdfbff")
require("x64:c4fa18438e51aa4")
require("x64:dd720638a9c4700")
require("x64:f78acfcbc465bba")
require("x64:fe5982d27a41c8")
require("x64:d37cfee68621f73")
CoD.ArenaMapAndGameTypeInternal = InheritFrom(LUI.UIElement)
CoD.ArenaMapAndGameTypeInternal.__defaultWidth = 384
CoD.ArenaMapAndGameTypeInternal.__defaultHeight = 186
CoD.ArenaMapAndGameTypeInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaMapAndGameTypeInternal)
	self.id = "ArenaMapAndGameTypeInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local FocusGlow = LUI.UIImage.new(0, 1, -80, 80, -0, 1, -50, 50)
	FocusGlow:setAlpha(0)
	FocusGlow:setImage(RegisterImage(0xB8F10D49D85E9C4))
	FocusGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FocusGlow:setShaderVector(0, 0, 0, 0.24, 0.24)
	FocusGlow:setShaderVector(1, 1.2, 0, 0, 0)
	FocusGlow:setupNineSliceShader(160, 100)
	self:addElement(FocusGlow)
	self.FocusGlow = FocusGlow
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local ArenaEventTimer = CoD.ArenaEventTimer.new(f1_arg0, f1_arg1, 0, 0, 7, 267, 0, 0, -18, -4)
	ArenaEventTimer:mergeStateConditions({
		{
			stateName = "NextEvent",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local MapImage = ArenaEventTimer
	local FocusBrackets = ArenaEventTimer.subscribeToModel
	local NoiseTiledBacking2 = Engine[0x8DF2E5447F384B9]()
	FocusBrackets(MapImage, NoiseTiledBacking2["lobbyPlaylist.name"], function(f3_arg0)
		f1_arg0:updateElementState(ArenaEventTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	MapImage = ArenaEventTimer
	FocusBrackets = ArenaEventTimer.subscribeToModel
	NoiseTiledBacking2 = Engine[0x8DF2E5447F384B9]()
	FocusBrackets(MapImage, NoiseTiledBacking2["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(ArenaEventTimer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ArenaEventTimer:subscribeToGlobalModel(f1_arg1, "Arena", "arenaEventTimer", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ArenaEventTimer.EventEndsIn:setText(f5_local0)
		end
	end)
	self:addElement(ArenaEventTimer)
	self.ArenaEventTimer = ArenaEventTimer
	FocusBrackets = CoD.CommonFocusBrackets.new(f1_arg0, f1_arg1, 0, 1, -20, 20, 0, 1, -20, 20)
	FocusBrackets:setAlpha(0)
	self:addElement(FocusBrackets)
	self.FocusBrackets = FocusBrackets
	MapImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapImage:setImage(RegisterImage(0xAA9981A158D630C))
	MapImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	MapImage:setShaderVector(0, 0.5, 0.2, 0, 0)
	MapImage:setShaderVector(1, 1, 1, 0, 0)
	MapImage:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(MapImage)
	self.MapImage = MapImage
	NoiseTiledBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking2:setAlpha(0.9)
	NoiseTiledBacking2:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking2:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking2)
	self.NoiseTiledBacking2 = NoiseTiledBacking2
	local DotTiledBacking = CoD.CommonPixelBacking.new(f1_arg0, f1_arg1, 0, 1, 4, -4, 0, 1, 4, -4)
	DotTiledBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	DotTiledBacking.NoiseBacking:setAlpha(1)
	DotTiledBacking.TiledShaderImage:setRGB(0.22, 0.22, 0.22)
	DotTiledBacking.TiledShaderImage:setAlpha(0.15)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(36, 36)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.05)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local GamemodeIcon = LUI.UIImage.new(1, 1, -137, -1, 0.5, 0.5, -68, 68)
	self:addElement(GamemodeIcon)
	self.GamemodeIcon = GamemodeIcon
	local DirectorMapAndGameTypeInternalTitles = CoD.DirectorMapAndGameTypeInternalTitles.new(f1_arg0, f1_arg1, 0, 0, -1, 383, 1, 1, -56, -4)
	DirectorMapAndGameTypeInternalTitles:setAlpha(0)
	DirectorMapAndGameTypeInternalTitles.Label:setText(Engine[0xF9F1239CFD921FE](0xD68F0B827BDBA25))
	DirectorMapAndGameTypeInternalTitles.SubTitle:setText(Engine[0xF9F1239CFD921FE](0xED2FACC41C9E672))
	self:addElement(DirectorMapAndGameTypeInternalTitles)
	self.DirectorMapAndGameTypeInternalTitles = DirectorMapAndGameTypeInternalTitles
	local PlaylistHeaderBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 30)
	PlaylistHeaderBacking:setRGB(0, 0, 0)
	PlaylistHeaderBacking:setAlpha(0)
	self:addElement(PlaylistHeaderBacking)
	self.PlaylistHeaderBacking = PlaylistHeaderBacking
	local PlaylistHeader = CoD.DirectorSelectButtonMode.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 30)
	PlaylistHeader:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	PlaylistHeader:appendEventHandler("on_session_start", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PlaylistHeader, f7_arg1)
	end)
	PlaylistHeader:appendEventHandler("on_session_end", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PlaylistHeader, f8_arg1)
	end)
	local FrameBorder = PlaylistHeader
	local PlaylistHeaderNonHost = PlaylistHeader.subscribeToModel
	local Lines = Engine[0x8DF2E5447F384B9]()
	PlaylistHeaderNonHost(FrameBorder, Lines["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(PlaylistHeader, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	FrameBorder = PlaylistHeader
	PlaylistHeaderNonHost = PlaylistHeader.subscribeToModel
	Lines = Engine[0x8DF2E5447F384B9]()
	PlaylistHeaderNonHost(FrameBorder, Lines["lobbyRoot.gameClient.update"], function(f10_arg0)
		f1_arg0:updateElementState(PlaylistHeader, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	FrameBorder = PlaylistHeader
	PlaylistHeaderNonHost = PlaylistHeader.subscribeToModel
	Lines = Engine[0x8DF2E5447F384B9]()
	PlaylistHeaderNonHost(FrameBorder, Lines["lobbyRoot.privateClient.update"], function(f11_arg0)
		f1_arg0:updateElementState(PlaylistHeader, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	PlaylistHeader:setAlpha(0)
	self:addElement(PlaylistHeader)
	self.PlaylistHeader = PlaylistHeader
	PlaylistHeaderNonHost = CoD.DirectorSelectButtonMode.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 30)
	PlaylistHeaderNonHost:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsLobbyHostOfCurrentMenu()
			end,
		},
	})
	PlaylistHeaderNonHost:appendEventHandler("on_session_start", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PlaylistHeaderNonHost, f13_arg1)
	end)
	PlaylistHeaderNonHost:appendEventHandler("on_session_end", function(f14_arg0, f14_arg1)
		f14_arg1.menu = f14_arg1.menu or f1_arg0
		f1_arg0:updateElementState(PlaylistHeaderNonHost, f14_arg1)
	end)
	Lines = PlaylistHeaderNonHost
	FrameBorder = PlaylistHeaderNonHost.subscribeToModel
	local FocusBorder = Engine[0x8DF2E5447F384B9]()
	FrameBorder(Lines, FocusBorder["lobbyRoot.lobbyNav"], function(f15_arg0)
		f1_arg0:updateElementState(PlaylistHeaderNonHost, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Lines = PlaylistHeaderNonHost
	FrameBorder = PlaylistHeaderNonHost.subscribeToModel
	FocusBorder = Engine[0x8DF2E5447F384B9]()
	FrameBorder(Lines, FocusBorder["lobbyRoot.gameClient.update"], function(f16_arg0)
		f1_arg0:updateElementState(PlaylistHeaderNonHost, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	Lines = PlaylistHeaderNonHost
	FrameBorder = PlaylistHeaderNonHost.subscribeToModel
	FocusBorder = Engine[0x8DF2E5447F384B9]()
	FrameBorder(Lines, FocusBorder["lobbyRoot.privateClient.update"], function(f17_arg0)
		f1_arg0:updateElementState(PlaylistHeaderNonHost, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	PlaylistHeaderNonHost:setAlpha(0)
	self:addElement(PlaylistHeaderNonHost)
	self.PlaylistHeaderNonHost = PlaylistHeaderNonHost
	FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.05)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	Lines = CoD.DirectorSelectButtonLines.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, -1)
	Lines:setRGB(0.64, 0.71, 0.78)
	self:addElement(Lines)
	self.Lines = Lines
	FocusBorder = LUI.UIImage.new(0, 1, -4, 4, 0, 1, -4, 4)
	FocusBorder:setRGB(0.96, 0.94, 0.78)
	FocusBorder:setAlpha(0)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(10, 10)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local DirectorPartyLeaderOnlyPrompt = CoD.DirectorPartyLeaderOnlyPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -100, 100, 1, 1, -26, -2)
	DirectorPartyLeaderOnlyPrompt:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f19_local0
				if not IsPartyLeader(f1_arg1) then
					f19_local0 = not IsArenaMode()
				else
					f19_local0 = false
				end
				return f19_local0
			end,
		},
	})
	local CustomGamesOfficialBadgeIcon = DirectorPartyLeaderOnlyPrompt
	local DoubleXPIconsLeftAligned = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	local ButtonText = Engine[0x8DF2E5447F384B9]()
	DoubleXPIconsLeftAligned(CustomGamesOfficialBadgeIcon, ButtonText["lobbyRoot.lobbyNav"], function(f20_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	CustomGamesOfficialBadgeIcon = DirectorPartyLeaderOnlyPrompt
	DoubleXPIconsLeftAligned = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	ButtonText = Engine[0x8DF2E5447F384B9]()
	DoubleXPIconsLeftAligned(CustomGamesOfficialBadgeIcon, ButtonText["lobbyRoot.privateClient.isHost"], function(f21_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "lobbyRoot.privateClient.isHost",
		})
	end, false)
	CustomGamesOfficialBadgeIcon = DirectorPartyLeaderOnlyPrompt
	DoubleXPIconsLeftAligned = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	ButtonText = Engine[0x8DF2E5447F384B9]()
	DoubleXPIconsLeftAligned(CustomGamesOfficialBadgeIcon, ButtonText["lobbyRoot.gameClient.isHost"], function(f22_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "lobbyRoot.gameClient.isHost",
		})
	end, false)
	self:addElement(DirectorPartyLeaderOnlyPrompt)
	self.DirectorPartyLeaderOnlyPrompt = DirectorPartyLeaderOnlyPrompt
	DoubleXPIconsLeftAligned = CoD.DoubleXPIconsLeftAlignedFrontendSmall.new(f1_arg0, f1_arg1, 0, 0, -1, 215, 0, 0, 6, 54)
	self:addElement(DoubleXPIconsLeftAligned)
	self.DoubleXPIconsLeftAligned = DoubleXPIconsLeftAligned
	CustomGamesOfficialBadgeIcon = CoD.CustomGames_OfficialBadgeIcon.new(f1_arg0, f1_arg1, 1, 1, -64, 0, 0, 0, 0, 64)
	CustomGamesOfficialBadgeIcon:mergeStateConditions({
		{
			stateName = "IsOfficial",
			condition = function(menu, element, event)
				return IsCustomMPLobby() and CoD.OptionsUtility.AreAllCustomGameOptionsDefault(f1_arg1)
			end,
		},
	})
	local f1_local22 = CustomGamesOfficialBadgeIcon
	ButtonText = CustomGamesOfficialBadgeIcon.subscribeToModel
	local f1_local23 = Engine[0x8DF2E5447F384B9]()
	ButtonText(f1_local22, f1_local23["lobbyRoot.lobbyNav"], function(f24_arg0)
		f1_arg0:updateElementState(CustomGamesOfficialBadgeIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local22 = CustomGamesOfficialBadgeIcon
	ButtonText = CustomGamesOfficialBadgeIcon.subscribeToModel
	f1_local23 = Engine[0x8DF2E5447F384B9]()
	ButtonText(f1_local22, f1_local23["GametypeSettings.Update"], function(f25_arg0)
		f1_arg0:updateElementState(CustomGamesOfficialBadgeIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "GametypeSettings.Update",
		})
	end, false)
	CustomGamesOfficialBadgeIcon:setAlpha(0)
	self:addElement(CustomGamesOfficialBadgeIcon)
	self.CustomGamesOfficialBadgeIcon = CustomGamesOfficialBadgeIcon
	ButtonText = CoD.ArenaLobbyButtonText.new(f1_arg0, f1_arg1, 0.5, 0.5, -162.5, 162.5, 0.5, 0.5, -18.5, 18.5)
	self:addElement(ButtonText)
	self.ButtonText = ButtonText
	self:mergeStateConditions({
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaMapAndGameTypeInternal.__resetProperties = function(f28_arg0)
	f28_arg0.DirectorMapAndGameTypeInternalTitles:completeAnimation()
	f28_arg0.FocusBrackets:completeAnimation()
	f28_arg0.FocusBorder:completeAnimation()
	f28_arg0.FocusGlow:completeAnimation()
	f28_arg0.MapImage:completeAnimation()
	f28_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
	f28_arg0.DirectorMapAndGameTypeInternalTitles:setZoom(0)
	f28_arg0.FocusBrackets:setLeftRight(0, 1, -20, 20)
	f28_arg0.FocusBrackets:setTopBottom(0, 1, -20, 20)
	f28_arg0.FocusBrackets:setAlpha(0)
	f28_arg0.FocusBorder:setRGB(0.96, 0.94, 0.78)
	f28_arg0.FocusBorder:setAlpha(0)
	f28_arg0.FocusGlow:setAlpha(0)
	f28_arg0.MapImage:setAlpha(1)
	f28_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(1)
end
CoD.ArenaMapAndGameTypeInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.DirectorMapAndGameTypeInternalTitles:completeAnimation()
			f29_arg0.DirectorMapAndGameTypeInternalTitles:setZoom(0)
			f29_arg0.clipFinished(f29_arg0.DirectorMapAndGameTypeInternalTitles)
		end,
		Focus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(3)
			f30_arg0.FocusGlow:completeAnimation()
			f30_arg0.FocusGlow:setAlpha(0.6)
			f30_arg0.clipFinished(f30_arg0.FocusGlow)
			f30_arg0.FocusBrackets:completeAnimation()
			f30_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f30_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f30_arg0.FocusBrackets:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.FocusBrackets)
			f30_arg0.FocusBorder:completeAnimation()
			f30_arg0.FocusBorder:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.FocusBorder)
		end,
		GainFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(3)
			local f31_local0 = function(f32_arg0)
				f31_arg0.FocusGlow:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f31_arg0.FocusGlow:setAlpha(0.6)
				f31_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.FocusGlow:completeAnimation()
			f31_arg0.FocusGlow:setAlpha(0)
			f31_local0(f31_arg0.FocusGlow)
			local f31_local1 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(50, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f34_arg0:setLeftRight(0, 1, -10, 10)
					f34_arg0:setTopBottom(0, 1, -10, 10)
					f34_arg0:setAlpha(1)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.FocusBrackets:beginAnimation(100)
				f31_arg0.FocusBrackets:setLeftRight(0, 1, -8, 8)
				f31_arg0.FocusBrackets:setTopBottom(0, 1, -8, 8)
				f31_arg0.FocusBrackets:setAlpha(0.75)
				f31_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f31_arg0.FocusBrackets:completeAnimation()
			f31_arg0.FocusBrackets:setLeftRight(0, 1, -40, 40)
			f31_arg0.FocusBrackets:setTopBottom(0, 1, -40, 40)
			f31_arg0.FocusBrackets:setAlpha(0)
			f31_local1(f31_arg0.FocusBrackets)
			local f31_local2 = function(f35_arg0)
				f31_arg0.FocusBorder:beginAnimation(200, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f31_arg0.FocusBorder:setAlpha(1)
				f31_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.FocusBorder:completeAnimation()
			f31_arg0.FocusBorder:setAlpha(0)
			f31_local2(f31_arg0.FocusBorder)
		end,
		LoseFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(3)
			local f36_local0 = function(f37_arg0)
				f36_arg0.FocusGlow:beginAnimation(200)
				f36_arg0.FocusGlow:setAlpha(0)
				f36_arg0.FocusGlow:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.FocusGlow:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.FocusGlow:completeAnimation()
			f36_arg0.FocusGlow:setAlpha(0.6)
			f36_local0(f36_arg0.FocusGlow)
			local f36_local1 = function(f38_arg0)
				f36_arg0.FocusBrackets:beginAnimation(60, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f36_arg0.FocusBrackets:setAlpha(0)
				f36_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.FocusBrackets:completeAnimation()
			f36_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f36_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f36_arg0.FocusBrackets:setAlpha(1)
			f36_local1(f36_arg0.FocusBrackets)
			local f36_local2 = function(f39_arg0)
				f36_arg0.FocusBorder:beginAnimation(200)
				f36_arg0.FocusBorder:setAlpha(0)
				f36_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.FocusBorder:completeAnimation()
			f36_arg0.FocusBorder:setAlpha(1)
			f36_local2(f36_arg0.FocusBorder)
		end,
	},
	Unselectable = {
		DefaultClip = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(2)
			f41_arg0.MapImage:completeAnimation()
			f41_arg0.MapImage:setAlpha(0.5)
			f41_arg0.clipFinished(f41_arg0.MapImage)
			f41_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f41_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		Focus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(4)
			f42_arg0.FocusBrackets:completeAnimation()
			f42_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f42_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f42_arg0.FocusBrackets:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.FocusBrackets)
			f42_arg0.MapImage:completeAnimation()
			f42_arg0.MapImage:setAlpha(0.5)
			f42_arg0.clipFinished(f42_arg0.MapImage)
			f42_arg0.FocusBorder:completeAnimation()
			f42_arg0.FocusBorder:setAlpha(0.25)
			f42_arg0.clipFinished(f42_arg0.FocusBorder)
			f42_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f42_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		GainFocus = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(4)
			local f43_local0 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					f45_arg0:beginAnimation(50, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f45_arg0:setLeftRight(0, 1, -10, 10)
					f45_arg0:setTopBottom(0, 1, -10, 10)
					f45_arg0:setAlpha(1)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
				end
				f43_arg0.FocusBrackets:beginAnimation(100)
				f43_arg0.FocusBrackets:setLeftRight(0, 1, -8, 8)
				f43_arg0.FocusBrackets:setTopBottom(0, 1, -8, 8)
				f43_arg0.FocusBrackets:setAlpha(0.75)
				f43_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f43_arg0.FocusBrackets:completeAnimation()
			f43_arg0.FocusBrackets:setLeftRight(0, 1, -40, 40)
			f43_arg0.FocusBrackets:setTopBottom(0, 1, -40, 40)
			f43_arg0.FocusBrackets:setAlpha(0)
			f43_local0(f43_arg0.FocusBrackets)
			f43_arg0.MapImage:completeAnimation()
			f43_arg0.MapImage:setAlpha(0.5)
			f43_arg0.clipFinished(f43_arg0.MapImage)
			local f43_local1 = function(f46_arg0)
				f43_arg0.FocusBorder:beginAnimation(200)
				f43_arg0.FocusBorder:setAlpha(0.25)
				f43_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.FocusBorder:completeAnimation()
			f43_arg0.FocusBorder:setRGB(0.96, 0.94, 0.78)
			f43_arg0.FocusBorder:setAlpha(0)
			f43_local1(f43_arg0.FocusBorder)
			local f43_local2 = function(f47_arg0)
				f43_arg0.DirectorPartyLeaderOnlyPrompt:beginAnimation(200)
				f43_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(1)
				f43_arg0.DirectorPartyLeaderOnlyPrompt:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.DirectorPartyLeaderOnlyPrompt:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f43_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
			f43_local2(f43_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
		LoseFocus = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(4)
			local f48_local0 = function(f49_arg0)
				f48_arg0.FocusBrackets:beginAnimation(60)
				f48_arg0.FocusBrackets:setAlpha(0)
				f48_arg0.FocusBrackets:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.FocusBrackets:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.FocusBrackets:completeAnimation()
			f48_arg0.FocusBrackets:setLeftRight(0, 1, -10, 10)
			f48_arg0.FocusBrackets:setTopBottom(0, 1, -10, 10)
			f48_arg0.FocusBrackets:setAlpha(1)
			f48_local0(f48_arg0.FocusBrackets)
			f48_arg0.MapImage:completeAnimation()
			f48_arg0.MapImage:setAlpha(0.5)
			f48_arg0.clipFinished(f48_arg0.MapImage)
			local f48_local1 = function(f50_arg0)
				f48_arg0.FocusBorder:beginAnimation(200)
				f48_arg0.FocusBorder:setAlpha(0)
				f48_arg0.FocusBorder:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.FocusBorder:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.FocusBorder:completeAnimation()
			f48_arg0.FocusBorder:setRGB(0.96, 0.94, 0.78)
			f48_arg0.FocusBorder:setAlpha(0.25)
			f48_local1(f48_arg0.FocusBorder)
			local f48_local2 = function(f51_arg0)
				f48_arg0.DirectorPartyLeaderOnlyPrompt:beginAnimation(200)
				f48_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(0)
				f48_arg0.DirectorPartyLeaderOnlyPrompt:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.DirectorPartyLeaderOnlyPrompt:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.DirectorPartyLeaderOnlyPrompt:completeAnimation()
			f48_arg0.DirectorPartyLeaderOnlyPrompt:setAlpha(1)
			f48_local2(f48_arg0.DirectorPartyLeaderOnlyPrompt)
		end,
	},
}
CoD.ArenaMapAndGameTypeInternal.__onClose = function(f52_arg0)
	f52_arg0.ArenaEventTimer:close()
	f52_arg0.FocusBrackets:close()
	f52_arg0.DotTiledBacking:close()
	f52_arg0.DirectorMapAndGameTypeInternalTitles:close()
	f52_arg0.PlaylistHeader:close()
	f52_arg0.PlaylistHeaderNonHost:close()
	f52_arg0.Lines:close()
	f52_arg0.DirectorPartyLeaderOnlyPrompt:close()
	f52_arg0.DoubleXPIconsLeftAligned:close()
	f52_arg0.CustomGamesOfficialBadgeIcon:close()
	f52_arg0.ButtonText:close()
end
