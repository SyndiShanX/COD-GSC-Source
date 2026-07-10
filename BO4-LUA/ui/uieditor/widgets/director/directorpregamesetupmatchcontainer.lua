require("x64:5f8cf56752aa71b")
require("x64:e38247e77bdfbff")
require("x64:c4fa18438e51aa4")
require("x64:dd720638a9c4700")
require("x64:fe5982d27a41c8")
CoD.DirectorPreGameSetUpMatchContainer = InheritFrom(LUI.UIElement)
CoD.DirectorPreGameSetUpMatchContainer.__defaultWidth = 372
CoD.DirectorPreGameSetUpMatchContainer.__defaultHeight = 216
CoD.DirectorPreGameSetUpMatchContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPreGameSetUpMatchContainer)
	self.id = "DirectorPreGameSetUpMatchContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MapImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	MapImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	MapImage:setShaderVector(0, 0, 0, 0, 0)
	MapImage:setShaderVector(1, 1, 1, 0, 0)
	MapImage:setShaderVector(2, 0, 0, 0, 0)
	MapImage:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MapImage:setImage(RegisterImage(MapNameToMapImage(f2_local0)))
		end
	end)
	self:addElement(MapImage)
	self.MapImage = MapImage
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local GamemodeIcon = LUI.UIImage.new(0.5, 0.5, -68, 68, 0, 0, 42, 178)
	GamemodeIcon:setAlpha(0)
	GamemodeIcon:setZoom(5)
	GamemodeIcon:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GamemodeIcon:setImage(RegisterImage(CoD.GameTypeUtility.GameTypeToImage(f3_local0)))
		end
	end)
	self:addElement(GamemodeIcon)
	self.GamemodeIcon = GamemodeIcon
	local DirectorMapAndGameTypeInternalTitles = CoD.DirectorMapAndGameTypeInternalTitles.new(f1_arg0, f1_arg1, 0, 0, 2, 386, 1, 1, -58, -6)
	DirectorMapAndGameTypeInternalTitles:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteGameModeNext", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			DirectorMapAndGameTypeInternalTitles.Label:setText(CoD.GameTypeUtility.GameTypeToLocalizeToUpperName(f4_local0))
		end
	end)
	DirectorMapAndGameTypeInternalTitles:subscribeToGlobalModel(f1_arg1, "MapVote", "mapVoteMapNext", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DirectorMapAndGameTypeInternalTitles.SubTitle:setText(MapNameToLocalizedMapName(f5_local0))
		end
	end)
	self:addElement(DirectorMapAndGameTypeInternalTitles)
	self.DirectorMapAndGameTypeInternalTitles = DirectorMapAndGameTypeInternalTitles
	local LockImage = LUI.UIImage.new(1, 1, -50, 0, 0, 0, 0, 50)
	LockImage:setAlpha(0)
	LockImage:setScale(0.6, 0.6)
	LockImage:setImage(RegisterImage(0xE1E7C490B2BA4FB))
	self:addElement(LockImage)
	self.LockImage = LockImage
	local DirectorPartyLeaderOnlyPrompt = CoD.DirectorPartyLeaderOnlyPrompt.new(f1_arg0, f1_arg1, 0, 1, 5, -5, 0.5, 0.5, -12, 12)
	DirectorPartyLeaderOnlyPrompt:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	DirectorPartyLeaderOnlyPrompt:appendEventHandler("on_session_start", function(f7_arg0, f7_arg1)
		f7_arg1.menu = f7_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, f7_arg1)
	end)
	DirectorPartyLeaderOnlyPrompt:appendEventHandler("on_session_end", function(f8_arg0, f8_arg1)
		f8_arg1.menu = f8_arg1.menu or f1_arg0
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, f8_arg1)
	end)
	local PlaylistHeader = DirectorPartyLeaderOnlyPrompt
	local PlaylistHeaderBacking = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	local CommonButtonOutline = Engine[0x8DF2E5447F384B9]()
	PlaylistHeaderBacking(PlaylistHeader, CommonButtonOutline["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	PlaylistHeader = DirectorPartyLeaderOnlyPrompt
	PlaylistHeaderBacking = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	CommonButtonOutline = Engine[0x8DF2E5447F384B9]()
	PlaylistHeaderBacking(PlaylistHeader, CommonButtonOutline["lobbyRoot.gameClient.update"], function(f10_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.gameClient.update",
		})
	end, false)
	PlaylistHeader = DirectorPartyLeaderOnlyPrompt
	PlaylistHeaderBacking = DirectorPartyLeaderOnlyPrompt.subscribeToModel
	CommonButtonOutline = Engine[0x8DF2E5447F384B9]()
	PlaylistHeaderBacking(PlaylistHeader, CommonButtonOutline["lobbyRoot.privateClient.update"], function(f11_arg0)
		f1_arg0:updateElementState(DirectorPartyLeaderOnlyPrompt, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.privateClient.update",
		})
	end, false)
	self:addElement(DirectorPartyLeaderOnlyPrompt)
	self.DirectorPartyLeaderOnlyPrompt = DirectorPartyLeaderOnlyPrompt
	PlaylistHeaderBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 30)
	PlaylistHeaderBacking:setRGB(0, 0, 0)
	PlaylistHeaderBacking:setAlpha(0.8)
	self:addElement(PlaylistHeaderBacking)
	self.PlaylistHeaderBacking = PlaylistHeaderBacking
	PlaylistHeader = CoD.DirectorSelectButtonMode.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 30)
	self:addElement(PlaylistHeader)
	self.PlaylistHeader = PlaylistHeader
	CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutline:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "Disabled")
			end,
		},
	})
	local f1_local10 = CommonButtonOutline
	local CustomGamesOfficialBadgeIcon = CommonButtonOutline.subscribeToModel
	local f1_local12 = Engine[0x8DF2E5447F384B9]()
	CustomGamesOfficialBadgeIcon(f1_local10, f1_local12["lobbyRoot.lobbyNav"], function(f13_arg0)
		f1_arg0:updateElementState(CommonButtonOutline, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	CustomGamesOfficialBadgeIcon = CoD.CustomGames_OfficialBadgeIcon.new(f1_arg0, f1_arg1, 1, 1, -64, 0, 0, 0, 0, 64)
	CustomGamesOfficialBadgeIcon:mergeStateConditions({
		{
			stateName = "IsOfficial",
			condition = function(menu, element, event)
				return IsCustomMPLobby() and CoD.OptionsUtility.AreAllCustomGameOptionsDefault(f1_arg1)
			end,
		},
	})
	f1_local12 = CustomGamesOfficialBadgeIcon
	f1_local10 = CustomGamesOfficialBadgeIcon.subscribeToModel
	local f1_local13 = Engine[0x8DF2E5447F384B9]()
	f1_local10(f1_local12, f1_local13["lobbyRoot.lobbyNav"], function(f15_arg0)
		f1_arg0:updateElementState(CustomGamesOfficialBadgeIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local12 = CustomGamesOfficialBadgeIcon
	f1_local10 = CustomGamesOfficialBadgeIcon.subscribeToModel
	f1_local13 = Engine[0x8DF2E5447F384B9]()
	f1_local10(f1_local12, f1_local13["GametypeSettings.Update"], function(f16_arg0)
		f1_arg0:updateElementState(CustomGamesOfficialBadgeIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "GametypeSettings.Update",
		})
	end, false)
	self:addElement(CustomGamesOfficialBadgeIcon)
	self.CustomGamesOfficialBadgeIcon = CustomGamesOfficialBadgeIcon
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f17_arg2, f17_arg3, f17_arg4)
		UpdateElementState(self, "CommonButtonOutline", controller)
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPreGameSetUpMatchContainer.__resetProperties = function(f18_arg0)
	f18_arg0.GamemodeIcon:completeAnimation()
	f18_arg0.DirectorMapAndGameTypeInternalTitles:completeAnimation()
	f18_arg0.MapImage:completeAnimation()
	f18_arg0.LockImage:completeAnimation()
	f18_arg0.GamemodeIcon:setZoom(5)
	f18_arg0.DirectorMapAndGameTypeInternalTitles:setAlpha(1)
	f18_arg0.DirectorMapAndGameTypeInternalTitles:setZoom(0)
	f18_arg0.MapImage:setAlpha(1)
	f18_arg0.MapImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	f18_arg0.LockImage:setAlpha(0)
end
CoD.DirectorPreGameSetUpMatchContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.GamemodeIcon:completeAnimation()
			f19_arg0.GamemodeIcon:setZoom(5)
			f19_arg0.clipFinished(f19_arg0.GamemodeIcon)
			f19_arg0.DirectorMapAndGameTypeInternalTitles:completeAnimation()
			f19_arg0.DirectorMapAndGameTypeInternalTitles:setAlpha(1)
			f19_arg0.DirectorMapAndGameTypeInternalTitles:setZoom(0)
			f19_arg0.clipFinished(f19_arg0.DirectorMapAndGameTypeInternalTitles)
		end,
		GainChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.GamemodeIcon:completeAnimation()
			f20_arg0.GamemodeIcon:setZoom(5)
			f20_arg0.clipFinished(f20_arg0.GamemodeIcon)
			f20_arg0.DirectorMapAndGameTypeInternalTitles:completeAnimation()
			f20_arg0.DirectorMapAndGameTypeInternalTitles:setAlpha(1)
			f20_arg0.DirectorMapAndGameTypeInternalTitles:setZoom(0)
			f20_arg0.clipFinished(f20_arg0.DirectorMapAndGameTypeInternalTitles)
		end,
		LoseChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.GamemodeIcon:completeAnimation()
			f21_arg0.GamemodeIcon:setZoom(5)
			f21_arg0.clipFinished(f21_arg0.GamemodeIcon)
			f21_arg0.DirectorMapAndGameTypeInternalTitles:completeAnimation()
			f21_arg0.DirectorMapAndGameTypeInternalTitles:setAlpha(1)
			f21_arg0.DirectorMapAndGameTypeInternalTitles:setZoom(0)
			f21_arg0.clipFinished(f21_arg0.DirectorMapAndGameTypeInternalTitles)
		end,
	},
	Disabled = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.MapImage:completeAnimation()
			f22_arg0.MapImage:setAlpha(0.5)
			f22_arg0.clipFinished(f22_arg0.MapImage)
			f22_arg0.DirectorMapAndGameTypeInternalTitles:completeAnimation()
			f22_arg0.DirectorMapAndGameTypeInternalTitles:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.DirectorMapAndGameTypeInternalTitles)
		end,
	},
	Unselectable = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
	Locked = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(3)
			f24_arg0.MapImage:completeAnimation()
			f24_arg0.MapImage:setAlpha(0.5)
			f24_arg0.MapImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
			f24_arg0.clipFinished(f24_arg0.MapImage)
			f24_arg0.DirectorMapAndGameTypeInternalTitles:completeAnimation()
			f24_arg0.DirectorMapAndGameTypeInternalTitles:setAlpha(0.1)
			f24_arg0.clipFinished(f24_arg0.DirectorMapAndGameTypeInternalTitles)
			f24_arg0.LockImage:completeAnimation()
			f24_arg0.LockImage:setAlpha(0.3)
			f24_arg0.clipFinished(f24_arg0.LockImage)
		end,
	},
}
CoD.DirectorPreGameSetUpMatchContainer.__onClose = function(f25_arg0)
	f25_arg0.MapImage:close()
	f25_arg0.GamemodeIcon:close()
	f25_arg0.DirectorMapAndGameTypeInternalTitles:close()
	f25_arg0.DirectorPartyLeaderOnlyPrompt:close()
	f25_arg0.PlaylistHeader:close()
	f25_arg0.CommonButtonOutline:close()
	f25_arg0.CustomGamesOfficialBadgeIcon:close()
end
