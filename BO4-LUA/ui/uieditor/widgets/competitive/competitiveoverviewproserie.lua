require("x64:9f0ef34539db58f")
require("x64:40e70dea3532a08")
CoD.CompetitiveOverviewProSerie = InheritFrom(LUI.UIElement)
CoD.CompetitiveOverviewProSerie.__defaultWidth = 1920
CoD.CompetitiveOverviewProSerie.__defaultHeight = 1080
CoD.CompetitiveOverviewProSerie.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompetitiveOverviewProSerie)
	self.id = "CompetitiveOverviewProSerie"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local ModesMaps = LUI.UIList.new(f1_arg0, f1_arg1, 25, 0, nil, false, false, false, false)
	ModesMaps:setLeftRight(0, 0, 322, 1752)
	ModesMaps:setTopBottom(0, 0, 650, 860)
	ModesMaps:setWidgetType(CoD.ArenaFindGameDetailModes)
	ModesMaps:setHorizontalCount(3)
	ModesMaps:setSpacing(25)
	ModesMaps:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ModesMaps:setDataSource("ArenaPlaylistGameModesMaps")
	self:addElement(ModesMaps)
	self.ModesMaps = ModesMaps
	local playlist = LUI.UIText.new(0, 0, 322, 850, 0, 0, 497, 515)
	playlist:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	playlist:setAlpha(0)
	playlist:setText(LocalizeToUpperString(@"hash_52BBBEFE68E6FD2A"))
	playlist:setTTF("ttmussels_demibold")
	playlist:setLetterSpacing(2)
	playlist:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	playlist:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(playlist)
	self.playlist = playlist
	local modeMaps = LUI.UIText.new(0, 0, 322, 850, 0, 0, 642, 660)
	modeMaps:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	modeMaps:setAlpha(0)
	modeMaps:setText(LocalizeToUpperString(@"hash_77114287D168D9DA"))
	modeMaps:setTTF("ttmussels_demibold")
	modeMaps:setLetterSpacing(2)
	modeMaps:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	modeMaps:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(modeMaps)
	self.modeMaps = modeMaps
	local ArenaRules = CoD.CompetitiveOverviewArenaRules.new(f1_arg0, f1_arg1, 0, 0, 322, 1842, 0, 0, 602, 623)
	self:addElement(ArenaRules)
	self.ArenaRules = ArenaRules
	local EventDescription = LUI.UIText.new(0, 0, 322, 1753, 0, 0, 564, 585)
	EventDescription:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	EventDescription:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5D86B33777B1B45F"))
	EventDescription:setTTF("ttmussels_regular")
	EventDescription:setLetterSpacing(2)
	EventDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EventDescription:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EventDescription)
	self.EventDescription = EventDescription
	local PlaylistDesc = LUI.UIText.new(0, 0, 322, 852, 0, 0, 515, 560)
	PlaylistDesc:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	PlaylistDesc:setTTF("ttmussels_demibold")
	PlaylistDesc:setLetterSpacing(6)
	PlaylistDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlaylistDesc:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	PlaylistDesc.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			PlaylistDesc:setText(ToUpper(CoD.DirectorUtility.PlaylistIDToPlaylistDesc(f2_local0)))
		end
	end
	PlaylistDesc:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "playlistId", PlaylistDesc.__String_Reference)
	PlaylistDesc.__String_Reference_FullPath = function()
		local f3_local0 = DataSources.LobbyRoot.getModel(f1_arg1)
		f3_local0 = f3_local0.playlistId
		if f3_local0 then
			PlaylistDesc.__String_Reference(f3_local0)
		end
	end
	self:addElement(PlaylistDesc)
	self.PlaylistDesc = PlaylistDesc
	local f1_local7 = PlaylistDesc
	local f1_local8 = PlaylistDesc.subscribeToModel
	local f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNetworkMode"], PlaylistDesc.__String_Reference_FullPath)
	f1_local7 = PlaylistDesc
	f1_local8 = PlaylistDesc.subscribeToModel
	f1_local9 = DataSources.LobbyRoot.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9["privateClient.count"], PlaylistDesc.__String_Reference_FullPath)
	ModesMaps.id = "ModesMaps"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CompetitiveOverviewProSerie.__onClose = function(f4_arg0)
	f4_arg0.ModesMaps:close()
	f4_arg0.ArenaRules:close()
	f4_arg0.PlaylistDesc:close()
end
