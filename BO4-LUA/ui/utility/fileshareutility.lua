CoD.FileshareUtility = {}
CoD.FileshareUtility.FileshareGetMatchmakingMode = function(f1_arg0)
	local f1_local0 = tonumber(f1_arg0)
	local f1_local1 = @"hash_FDC5ED3E75BC851"
	if not f1_local0 then
		return ""
	elseif f1_local0 == Enum[@"egamemodes"][@"mode_game_matchmaking_manual"] or f1_local0 == Enum[@"egamemodes"][@"hash_27B5630CD29180CB"] then
		f1_local1 = @"hash_5198D873AF11C58C"
	elseif f1_local0 == Enum[@"egamemodes"][@"mode_game_league"] then
		f1_local1 = @"hash_43C25CDE2502654F"
	elseif f1_local0 == Enum[@"egamemodes"][@"mode_game_freerun"] then
		f1_local1 = @"hash_2D98CBCEDF18A061"
	end
	return Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_mode", f1_local1)
end
CoD.FileshareUtility.FileshareDownloadSummary = function(f2_arg0, f2_arg1)
	if Engine[@"isdemoplaying"]() then
		return
	end
	local f2_local0 = f2_arg0:getModel()
	if f2_local0 then
		local f2_local1 = f2_local0.fileId:get()
		local f2_local2 = f2_local0.fileSummarySize:get()
		local f2_local3 = f2_local0.isPooled:get()
		local f2_local4 = f2_local0.mainMode:get()
		local f2_local5 = Enum[@"filesharelocation"][@"fileshare_location_userstorage"]
		if f2_local3 then
			f2_local5 = Enum[@"filesharelocation"][@"fileshare_location_pooledstorage"]
		end
		if f2_local3 ~= true then
			return
		end
		Engine[@"filesharedownloadsummary"](f2_arg1, f2_local4, f2_local1, f2_local2, f2_local5)
	end
end
CoD.FileshareUtility.FileshareHandleDownloadSummary = function(f3_arg0)
	local f3_local0 = f3_arg0:getModel()
	if f3_local0 then
		local f3_local1 = Engine[@"getglobalmodel"]()
		f3_local1 = f3_local1.fileshareRoot.summaryDownloadTask.fileID:get()
		local f3_local2 = f3_arg0.m_ownerController
		if not f3_local2 then
			f3_local2 = Engine[@"getprimarycontroller"]()
		end
		CoD.FileshareUtility.SetupFileShareSummary(f3_local2, f3_local1, f3_local0)
	end
end
CoD.FileshareUtility.FileshareDownloadScreenshot = function(f4_arg0, f4_arg1)
	if Engine[@"isdemoplaying"]() then
		return
	elseif f4_arg1 == nil then
		f4_arg1 = 1000
	end
	local f4_local0 = CoD.FileshareUtility.GetSelectedItem()
	if f4_local0 then
		local f4_local1 = CoD.SafeGetModelValue(f4_local0, "fileId")
		if not f4_local1 then
			f4_local1 = Engine[@"defaultid64value"]()
		end
		if f4_local1 ~= CoD.FileshareUtility.currentScreenshot then
			CoD.FileshareUtility.FileshareDestroyScreenshot(f4_arg0)
			local f4_local2 = CoD.SafeGetModelValue(f4_local0, "fileSize") or 0
			if f4_local1 ~= Engine[@"defaultid64value"]() then
				Engine[@"downloadscreenshot"](f4_arg0, f4_local1, f4_local2, f4_arg1)
				CoD.FileshareUtility.currentScreenshot = f4_local1
			end
		end
	end
end
CoD.FileshareUtility.FileshareDestroyScreenshot = function(f5_arg0)
	if CoD.FileshareUtility.currentScreenshot then
		Engine[@"destroyscreenshot"](f5_arg0)
		CoD.FileshareUtility.currentScreenshot = nil
	end
end
CoD.FileshareUtility.FilesharePrivateUpload = function(f6_arg0)
	CoD.FileshareUtility.PrivateUpload(f6_arg0)
end
CoD.FileshareUtility.FileshareCategorySelectorCategoryChanged = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	if f7_arg1 ~= nil and f7_arg1 ~= "" then
		if f7_arg1 == "recentgames" then
			f7_arg1 = "film"
		end
		CoD.FileshareUtility.SetCurrentCategory(f7_arg1)
	else
		CoD.FileshareUtility.SetCurrentCategory("paintjob")
	end
	if CoD.FileshareUtility.GetIsGroupsMode(f7_arg0) then
		local f7_local0 = Enum[@"filesharegroupsdatatype"][@"fileshare_groups_data_recent"]
		if f7_arg1 == "favorites" then
			f7_local0 = Enum[@"filesharegroupsdatatype"][@"fileshare_groups_data_favorite"]
		elseif f7_arg1 == "featured" then
			f7_local0 = Enum[@"filesharegroupsdatatype"][@"fileshare_groups_data_featured"]
		end
		Engine[@"filesharefetchgroupcontent"](f7_arg0, f7_arg1, f7_local0)
	elseif CoD.FileshareUtility.GetIsCommunityMode(f7_arg0) then
		Engine[@"filesharefetchcommunitycontent"](f7_arg0, f7_arg1, f7_arg2)
	elseif CoD.FileshareUtility.GetIsUserMode(f7_arg0) then
		local f7_local0 = CoD.FileshareUtility.GetCurrentUser()
		if f7_arg2 == Enum[@"filesharecommunitydatatype"][@"fileshare_community_data_recent_games"] then
			if f7_arg1 == "recentgames" then
				f7_arg1 = "film"
			end
			Engine[@"filesharefetchcommunitycontent"](f7_arg0, f7_arg1, f7_arg2, f7_local0)
		else
			CoD.FileshareUtility.FetchContentForUser(f7_arg0, f7_local0)
		end
	end
	local f7_local0 = CoD.FileshareUtility.GetPreviousCategory()
	if f7_local0 ~= f7_arg1 or f7_arg3 == true then
		CoD.FileshareUtility.SetDirty()
	end
	if f7_local0 == "screenshot" and f7_arg1 ~= "screenshot" and f7_arg1 ~= "clip" then
		ResetThumbnailViewer(f7_arg0)
	end
	CoD.FileshareUtility.ProcessUIIndex(f7_arg0, f7_arg1, 0)
	CoD.FileshareUtility.SetPreviousCategory(f7_arg1)
	if CoD.FileshareUtility.ShouldSetPreviewIconSizeShort(f7_arg1) then
		FileshareSetPreviewIconSizeShort()
	else
		FileshareSetPreviewIconSizeNormal()
	end
	CoD.FileshareUtility.SetShowFileDetails(false)
	CoD.FileshareUtility.SetShowPublishNewDetails(false)
	CoD.FileshareUtility.SetShowCreateButton(false)
end
CoD.FileshareUtility.PublishedPaintjobsTabs = {
	{
		index = 1,
		fileshareCategory = "paintjob",
		fileshareKey = "",
		fileshareVal = "",
		weapon_category = "",
		disabled = false,
		name = @"hash_146513144F1265BA",
		loadout_slot = "",
	},
	{
		index = 2,
		fileshareCategory = "paintjob",
		fileshareKey = "22",
		fileshareVal = "0",
		weapon_category = "weapon_smg",
		disabled = false,
		name = @"hash_5FD890D63546403E",
		loadout_slot = "primary",
	},
	{
		index = 3,
		fileshareCategory = "paintjob",
		fileshareKey = "22",
		fileshareVal = "1",
		weapon_category = "weapon_assault",
		disabled = false,
		name = @"hash_7FE1B0B2003A6CC1",
		loadout_slot = "primary",
	},
	{
		index = 4,
		fileshareCategory = "paintjob",
		fileshareKey = "22",
		fileshareVal = "2",
		weapon_category = "weapon_cqb",
		disabled = false,
		name = @"hash_247A4BC3A33F5EFC",
		loadout_slot = "primary",
	},
	{
		index = 5,
		fileshareCategory = "paintjob",
		fileshareKey = "22",
		fileshareVal = "3",
		weapon_category = "weapon_lmg",
		disabled = false,
		name = @"hash_36E2CCF91E26DD51",
		loadout_slot = "primary",
	},
	{
		index = 6,
		fileshareCategory = "paintjob",
		fileshareKey = "22",
		fileshareVal = "4",
		weapon_category = "weapon_sniper",
		disabled = false,
		name = @"hash_2EF865AD574F5FAD",
		loadout_slot = "primary",
	},
	{
		index = 7,
		fileshareCategory = "paintjob",
		fileshareKey = "22",
		fileshareVal = "99",
		weapon_category = "secondary",
		disabled = false,
		name = @"hash_24CA2AC0102BE042",
		loadout_slot = "secondary",
	},
}
CoD.FileshareUtility.ShowcaseManagerTabs = {
	{
		index = 1,
		fileshareCategory = "paintjob",
		fileshareKey = "",
		fileshareVal = "",
		disabled = false,
		selectIndex = true,
	},
	{
		index = 3,
		fileshareCategory = "emblem",
		fileshareKey = "",
		fileshareVal = "",
		disabled = false,
		selectIndex = false,
	},
	{
		index = 4,
		fileshareCategory = "customgame",
		fileshareKey = "",
		fileshareVal = "",
		disabled = false,
		selectIndex = false,
	},
	{
		index = 5,
		fileshareCategory = "screenshot",
		fileshareKey = "",
		fileshareVal = "",
		disabled = false,
		selectIndex = false,
	},
	{
		index = 6,
		fileshareCategory = "clip",
		fileshareKey = "",
		fileshareVal = "",
		disabled = false,
		selectIndex = false,
	},
}
CoD.FileshareUtility.CommunityTitles = {
	{
		dataType = Enum[@"filesharecommunitydatatype"][@"fileshare_community_data_popular"],
		title = @"hash_161E701B404BB58B",
		kicker = @"hash_161E701B404BB58B",
	},
	{
		dataType = Enum[@"filesharecommunitydatatype"][@"fileshare_community_data_recent"],
		title = @"hash_62E0A4FBEEF7D0A1",
		kicker = @"hash_62E0A4FBEEF7D0A1",
	},
	{
		dataType = Enum[@"filesharecommunitydatatype"][@"fileshare_community_data_trending"],
		title = @"hash_1EA2FD68B9073463",
		kicker = @"hash_1EA2FD68B9073463",
	},
}
CoD.FileshareUtility.ToastTypes = {
	LIKE = {
		kicker = @"hash_7C41679348F59D9",
		description = "%s",
		functionIcon = "uie_t7_icon_menu_options_like",
	},
	DISLIKE = {
		kicker = @"hash_59195D406065398D",
		description = "%s",
		functionIcon = "uie_t7_icon_menu_options_dislike",
	},
	PUBLISH = {
		kicker = @"hash_68883628346E7746",
		description = "%s",
		functionIcon = "t7_icon_menu_simple_publish",
	},
	DELETE = {
		kicker = @"hash_3D76687D78687DD1",
		description = "%s",
		functionIcon = "t7_icon_menu_simple_delete",
	},
	DELETED_PUBLISH = {
		kicker = @"hash_F046CE9CB5B5A78",
		description = "%s",
		functionIcon = "t7_icon_menu_simple_delete",
	},
	DOWNLOAD = {
		kicker = @"hash_278201A7650191FD",
		description = "%s",
		functionIcon = "t7_icon_menu_options_download",
	},
	REPORT = {
		kicker = @"hash_213ED89460FB0587",
		description = "%s",
		functionIcon = "uie_t7_icon_error_overlays",
	},
	READONLY = {
		kicker = @"hash_276DBE6DE9F0F327",
		description = @"hash_3907032CE7B70860",
		functionIcon = "uie_t7_icon_error_overlays",
	},
	ERROR = {
		kicker = @"hash_33BD3ADF4ED79E32",
		description = @"hash_5663D1B33682C5A2",
		functionIcon = "uie_t7_icon_error_overlays",
	},
	UPLOAD = {
		kicker = @"hash_2AF55328EAA3DD2C",
		description = "%s",
		functionIcon = "t7_icon_menu_simple_publish",
	},
}
CoD.FileshareUtility.CategoryLocStrings = {
	screenshot = {
		locString = @"hash_7DEACFDC45E7E713",
		locStringCaps = @"hash_6C0FD93DED9C0B25",
		locStringSingle = @"hash_6A64FC2419CA1E20",
		locStringSingleCaps = @"hash_44B72BBB461E13C0",
	},
	screenshot_private = {
		locString = @"hash_7DEACFDC45E7E713",
		locStringCaps = @"hash_6C0FD93DED9C0B25",
		locStringSingle = @"hash_6A64FC2419CA1E20",
		locStringSingleCaps = @"hash_44B72BBB461E13C0",
	},
	clip = {
		locString = @"hash_FC7658F2128D919",
		locStringCaps = @"hash_1C337418703189E3",
		locStringSingle = @"hash_563FBB3619A08F4A",
		locStringSingleCaps = @"hash_7B50FC5632FD870A",
	},
	clip_private = {
		locString = @"hash_FC7658F2128D919",
		locStringCaps = @"hash_1C337418703189E3",
		locStringSingle = @"hash_563FBB3619A08F4A",
		locStringSingleCaps = @"hash_7B50FC5632FD870A",
	},
	film = {
		locString = @"hash_FC7658F2128D919",
		locStringCaps = @"hash_1C337418703189E3",
		locStringSingle = @"hash_563FBB3619A08F4A",
		locStringSingleCaps = @"hash_7B50FC5632FD870A",
	},
	film_private = {
		locString = @"hash_FC7658F2128D919",
		locStringCaps = @"hash_1C337418703189E3",
		locStringSingle = @"hash_563FBB3619A08F4A",
		locStringSingleCaps = @"hash_7B50FC5632FD870A",
	},
}
CoD.FileshareUtility.FileProperties = {
	"fileId",
	"renderFileId",
	"demoName",
	"fileSize",
	"fileCategory",
	"fileCategoryId",
	"fileSummarySize",
	"fileSlot",
	"fileCopiesMade",
	"isValid",
	"gameType",
	"gameTypeString",
	"gameTypeName",
	"gameTypeImage",
	"map",
	"mapString",
	"mapName",
	"playlistId",
	"mainMode",
	"matchmakingMode",
	"isLiveStream",
	"maxClients",
	"demoVersion",
	"ffotdVersion",
	"fileOriginId",
	"fileCreateTime",
	"fileAuthorXuid",
	"fileAuthorName",
	"fileName",
	"isNameModified",
	"fileDescription",
	"isDescriptionModified",
	"isPooled",
	"duration",
	"isBookmarked",
	"fileLikesCount",
	"fileDislikesCount",
	"fileViewsCount",
	"fileDownloadsCount",
	"isPublishNew",
	"fileImage",
	"showFileImage",
	"showPlusImage",
	"uiModelIndex",
	"weaponName",
	"showGameTypeImage",
	"plusImageSrc",
	"codeIndex",
	"totalItems",
	"showDetailsViewSpinner",
}
CoD.FileshareUtility.Images = {
	paintjob = "uie_t7_mp_icon_header_paintshop",
	variant = "uie_t7_mp_icon_header_gunsmith",
	emblem = "uie_t7_mp_icon_header_emblem",
	film = "uie_t7_mp_icon_header_theater",
	screenshot = "uie_t7_mp_icon_header_screenshot",
	customgame = "uie_t7_mp_icon_header_customgames",
	screenshot_private = "uie_t7_mp_icon_header_screenshot",
	clip = "uie_t7_mp_icon_header_theater",
	clip_private = "uie_t7_mp_icon_header_theater",
}
CoD.FileshareUtility.LargeImages = {
	paintjob = "uie_t7_mp_icon_header_paintshop_large",
	variant = "uie_t7_mp_icon_header_gunsmith_large",
	emblem = "uie_t7_mp_icon_header_emblem_large",
	film = "uie_t7_mp_icon_header_theater_large",
	screenshot = "uie_t7_mp_icon_header_screenshot_large",
	customgame = "uie_t7_mp_icon_header_customgames_large",
	screenshot_private = "uie_t7_mp_icon_header_screenshot_large",
	clip = "uie_t7_mp_icon_header_theater_large",
	clip_private = "uie_t7_mp_icon_header_theater_large",
}
CoD.FileshareUtility.Colors = {
	paintjob = ColorSet.SelectedGreen,
	variant = ColorSet.CoreMartial,
	emblem = ColorSet.PlayerYellow,
	film = ColorSet.RewardWeaponLevel,
	screenshot = ColorSet.CoreChaos,
	customgame = ColorSet.Orange,
	screenshot_private = ColorSet.CoreChaos,
	clip = ColorSet.CodCasterFriendly,
	clip_private = ColorSet.CodCasterFriendly,
}
CoD.FileshareUtility.GetRootModel = function()
	return Engine[@"createmodel"](Engine[@"getglobalmodel"](), "fileshareRoot")
end
CoD.FileshareUtility.GetDeletingModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "deleteTask.state")
end
CoD.FileshareUtility.GetPublishingModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "publishTask.state")
end
CoD.FileshareUtility.GetUploadingModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "uploadTask.state")
end
CoD.FileshareUtility.GetDownloadingModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "downloadTask.state")
end
CoD.FileshareUtility.GetReadyModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "ready")
end
CoD.FileshareUtility.GetShowFileDetailsModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "showFileDetails")
end
CoD.FileshareUtility.GetShowPublishNewDetailsModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "showPublishNewDetails")
end
CoD.FileshareUtility.GetFileshareTypeModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "fileshareType")
end
CoD.FileshareUtility.GetIsFullscreenModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "isFullscreen")
end
CoD.FileshareUtility.GetInShowcaseManagerModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "inShowcaseManager")
end
CoD.FileshareUtility.GetInShowcaseBrowserModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "inShowcaseBrowser")
end
CoD.FileshareUtility.GetShouldShowTabsModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "shouldShowTabs")
end
CoD.FileshareUtility.GetItemsCountModel = function()
	return Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "itemsCount")
end
CoD.FileshareUtility.SetAutoStart = function(f22_arg0)
	local f22_local0 = CoD.FileshareUtility.GetRootModel()
	f22_local0.autoStart:set(f22_arg0)
end
CoD.FileshareUtility.InitModels = function()
	Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCommunityDataType")
	Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "PublishMode")
	Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "autoStart")
	Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "itemsCount")
	CoD.FileshareUtility.GetFileshareTypeModel()
end
CoD.FileshareUtility.IsFileshareReady = function(f24_arg0)
	return Engine[@"getmodelvalue"](CoD.FileshareUtility.GetReadyModel())
end
CoD.FileshareUtility.SetFileshareReady = function(f25_arg0)
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetReadyModel(), f25_arg0)
end
CoD.FileshareUtility.SetDirty = function()
	Engine[@"forcenotifymodelsubscriptions"](Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "fileshareRoot"), "dirty"))
end
CoD.FileshareUtility.GetItemsCount = function()
	return Engine[@"getmodelvalue"](CoD.FileshareUtility.GetItemsCountModel())
end
CoD.FileshareUtility.SetItemsCount = function(f28_arg0, f28_arg1)
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetItemsCountModel(), f28_arg1)
	ForceNotifyGlobalModel(f28_arg0, "fileshareRoot.itemsCount")
end
CoD.FileshareUtility.GetIsCommunityMode = function(f29_arg0)
	local f29_local0 = Engine[@"getmodelvalue"](CoD.FileshareUtility.GetFileshareTypeModel())
	CoD.FileshareUtility.SetShouldShowTabs(f29_local0 == Enum[@"filesharemode"][@"fileshare_mode_user"])
	return f29_local0 == Enum[@"filesharemode"][@"fileshare_mode_community"]
end
CoD.FileshareUtility.SetShouldShowTabs = function(f30_arg0)
	local f30_local0 = CoD.FileshareUtility.GetShouldShowTabsModel()
	if f30_arg0 == true then
		Engine[@"setmodelvalue"](f30_local0, 1)
	else
		Engine[@"setmodelvalue"](f30_local0, 0)
	end
end
CoD.FileshareUtility.GetIsUserMode = function(f31_arg0)
	return Engine[@"getmodelvalue"](CoD.FileshareUtility.GetFileshareTypeModel()) == Enum[@"filesharemode"][@"fileshare_mode_user"]
end
CoD.FileshareUtility.SetFileshareMode = function(f32_arg0, f32_arg1)
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetFileshareTypeModel(), f32_arg1)
end
CoD.FileshareUtility.GetIsGroupsMode = function(f33_arg0)
	return Engine[@"getmodelvalue"](CoD.FileshareUtility.GetFileshareTypeModel()) == Enum[@"filesharemode"][@"fileshare_mode_groups"]
end
CoD.FileshareUtility.GetIsFullscreenMode = function(f34_arg0)
	return Engine[@"getmodelvalue"](CoD.FileshareUtility.GetIsFullscreenModel()) == false
end
CoD.FileshareUtility.SetIsFullscreenMode = function(f35_arg0, f35_arg1)
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetIsFullscreenModel(), f35_arg1 == false)
end
CoD.FileshareUtility.GetInShowcaseManager = function(f36_arg0)
	return Engine[@"getmodelvalue"](CoD.FileshareUtility.GetInShowcaseManagerModel()) == false
end
CoD.FileshareUtility.SetInShowcaseManager = function(f37_arg0, f37_arg1)
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetInShowcaseManagerModel(), f37_arg1 == false)
end
CoD.FileshareUtility.GetInShowcaseBrowser = function(f38_arg0)
	return Engine[@"getmodelvalue"](CoD.FileshareUtility.GetInShowcaseBrowserModel()) == false
end
CoD.FileshareUtility.SetInShowcaseBrowser = function(f39_arg0, f39_arg1)
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetInShowcaseBrowserModel(), f39_arg1 == false)
end
CoD.FileshareUtility.SetCurrentCommunityDataType = function(f40_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCommunityDataType"), f40_arg0)
end
CoD.FileshareUtility.GetCurrentCommunityDataType = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCommunityDataType"))
end
CoD.FileshareUtility.SetCurrentGroupsDataType = function(f42_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentGroupsDataType"), f42_arg0)
end
CoD.FileshareUtility.GetCurrentGroupsDataType = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentGroupsDataType"))
end
CoD.FileshareUtility.SetCurrentCategory = function(f44_arg0)
	local f44_local0 = Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCategory")
	local f44_local1 = Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCategoryName")
	local f44_local2 = Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCategoryNameCaps")
	local f44_local3 = Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCategoryNameSingle")
	local f44_local4 = Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCategoryNameSingleCaps")
	local f44_local5 = CoD.FileshareUtility.CategoryLocStrings[f44_arg0]
	if f44_local5 == nil then
		f44_local0:set("")
		f44_local1:set(0x0)
		f44_local2:set(0x0)
		f44_local3:set(0x0)
		f44_local4:set(0x0)
	else
		f44_local0:set(f44_arg0)
		f44_local1:set(f44_local5.locString)
		f44_local2:set(f44_local5.locStringCaps)
		f44_local3:set(f44_local5.locStringSingle)
		f44_local4:set(f44_local5.locStringSingleCaps)
	end
end
CoD.FileshareUtility.GetCurrentCategory = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCategory"))
end
CoD.FileshareUtility.ShouldSetPreviewIconSizeShort = function(f46_arg0)
	if f46_arg0 == "emblem" or f46_arg0 == "film" or f46_arg0 == "recentgames" or f46_arg0 == "clip" or f46_arg0 == "clip_private" or f46_arg0 == "customgame" or f46_arg0 == "private_screenshot" or f46_arg0 == "screenshot" then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.IsCurrentCategoryEqualToValue = function(f47_arg0)
	return CoD.FileshareUtility.GetCurrentCategory() == f47_arg0
end
CoD.FileshareUtility.SetPreviousCategory = function(f48_arg0)
	local f48_local0 = Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "previousCategory")
	if f48_arg0 == nil or f48_arg0 == "" then
		Engine[@"setmodelvalue"](f48_local0, "")
	else
		Engine[@"setmodelvalue"](f48_local0, f48_arg0)
	end
end
CoD.FileshareUtility.GetPreviousCategory = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "previousCategory"))
end
CoD.FileshareUtility.ClearCurrentFilter = function()
	CoD.FileshareUtility.SetCurrentFilter(Enum[@"fileshareprimarytags_e"][@"fileshare_pritag_invalid"], Engine[@"defaultid64value"]())
end
CoD.FileshareUtility.SetFilterOnFileshareContentList = function(f51_arg0, f51_arg1, f51_arg2)
	if f51_arg0.contentList ~= nil then
		f51_arg0.contentList.filterKey = f51_arg1
		if f51_arg2 ~= nil then
			f51_arg0.contentList.filterVal = Engine[@"numbertouint64"](f51_arg2)
		else
			f51_arg0.contentList.filterVal = f51_arg2
		end
	end
end
CoD.FileshareUtility.SetCurrentFilter = function(f52_arg0, f52_arg1)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentFilterKey"), f52_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentFilterVal"), f52_arg1)
end
CoD.FileshareUtility.GetCurrentFilter = function()
	local f53_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentFilterKey"))
	local f53_local1 = Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentFilterVal"))
	if f53_local0 == nil or f53_local1 == nil then
		return Enum[@"fileshareprimarytags_e"][@"fileshare_pritag_invalid"], Engine[@"defaultid64value"]()
	else
		return f53_local0, f53_local1
	end
end
CoD.FileshareUtility.SetCurrentUser = function(f54_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentXuid"), f54_arg0)
end
CoD.FileshareUtility.GetCurrentUser = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentXuid"))
end
CoD.FileshareUtility.SetShowCreateButton = function(f56_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "showCreateButton"), f56_arg0)
end
CoD.FileshareUtility.GetShowCreateButton = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "showCreateButton"))
end
CoD.FileshareUtility.SelectedItemModel = nil
CoD.FileshareUtility.SetShowFileDetails = function(f58_arg0)
	local f58_local0 = CoD.FileshareUtility.GetShowFileDetailsModel()
	if f58_arg0 == true then
		Engine[@"setmodelvalue"](f58_local0, 1)
	else
		Engine[@"setmodelvalue"](f58_local0, 0)
	end
end
CoD.FileshareUtility.SetShowPublishNewDetails = function(f59_arg0)
	local f59_local0 = CoD.FileshareUtility.GetShowPublishNewDetailsModel()
	if f59_arg0 == true then
		Engine[@"setmodelvalue"](f59_local0, 1)
	else
		Engine[@"setmodelvalue"](f59_local0, 0)
	end
end
CoD.FileshareUtility.GetSelectedItem = function()
	return CoD.FileshareUtility.SelectedItemModel
end
CoD.FileshareUtility.SetSelectedItem = function(f61_arg0)
	CoD.FileshareUtility.SelectedItemModel = f61_arg0
	if CoD.FileshareUtility.GetSelectedItemProperty("isPublishNew") == false then
		CoD.FileshareUtility.SetShowFileDetails(true)
		CoD.FileshareUtility.SetShowPublishNewDetails(false)
	else
		CoD.FileshareUtility.SetShowFileDetails(false)
		CoD.FileshareUtility.SetShowPublishNewDetails(true)
	end
	CoD.FileshareUtility.ResetFileshareSummary(f61_arg0)
	local f61_local0 = 0
	if CoD.FileshareUtility.GetCurrentCategory() == "emblem" then
		f61_local0 = 1
	end
	Engine[@"setmodelvalue"](Engine[@"createmodel"](f61_arg0, "shouldShowEmblem", false), f61_local0)
end
CoD.FileshareUtility.GetSelectedItemProperty = function(f62_arg0)
	if f62_arg0 ~= nil and nil ~= CoD.FileshareUtility.SelectedItemModel then
		local f62_local0 = Engine[@"getmodel"](CoD.FileshareUtility.SelectedItemModel, f62_arg0)
		if f62_local0 ~= nil then
			return Engine[@"getmodelvalue"](f62_local0)
		end
	end
	return nil
end
CoD.FileshareUtility.SetupDefaultNameAndDescription = function(f63_arg0)
	local f63_local0 = Engine[@"getmodel"](f63_arg0, "fileCategory")
	if not f63_local0 then
		return
	end
	local f63_local1 = Engine[@"getmodelvalue"](f63_local0)
	if f63_local1 ~= "film" and f63_local1 ~= "clip" and f63_local1 ~= "clip_private" and f63_local1 ~= "screenshot" and f63_local1 ~= "screenshot_private" then
		return
	end
	local f63_local2 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f63_arg0, "mapName"))
	local f63_local3 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f63_arg0, "gametypeName"))
	local f63_local4 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f63_arg0, "mainMode"))
	local f63_local5 = Engine[@"getmodel"](f63_arg0, "fileName")
	if Engine[@"getmodelvalue"](f63_local5) == "" and f63_local2 then
		local f63_local6
		if f63_local4 == Enum[@"emodes"][@"mode_zombies"] then
			f63_local6 = Engine[@"localize"](CoD.BaseUtility.GetMapValue(f63_local2, "mapName", f63_local2))
		else
			local f63_local7 = Engine[@"getgametypeinfo"](f63_local3)
			f63_local6 = Engine[@"hash_4F9F1239CFD921FE"](f63_local7.nameRef)
		end
		Engine[@"setmodelvalue"](f63_local5, f63_local6)
	end
	local f63_local7 = Engine[@"getmodel"](f63_arg0, "fileDescription")
	if Engine[@"getmodelvalue"](f63_local7) == "" and f63_local3 and f63_local2 then
		if f63_local4 == Enum[@"emodes"][@"mode_warzone"] then
			Engine[@"setmodelvalue"](f63_local7, Engine[@"hash_4F9F1239CFD921FE"](@"menu/warzone"))
		else
			Engine[@"setmodelvalue"](f63_local7, CoD.BaseUtility.GetGameModeOnMapNameString(f63_local3, f63_local2))
		end
	end
end
CoD.FileshareUtility.SelectedItemReady = function()
	if CoD.FileshareUtility.GetSelectedItemProperty("renderFileId") ~= CoD.FileshareUtility.GetSelectedItemProperty("fileId") then
		return false
	else
		return true
	end
end
CoD.FileshareUtility.SummaryProperties = {
	"isValid",
	"fileId",
	"playerScore",
	"oppositionScore",
	"gameResultText",
	"gameResultColor",
	"column1Header",
	"column1Value",
	"column2Header",
	"column2Value",
	"column3Header",
	"column3Value",
	"column4Header",
	"column4Value",
}
CoD.FileshareUtility.InitFileshareSummaryModels = function(f65_arg0)
	local f65_local0 = Engine[@"createmodel"](f65_arg0, "summary")
	for f65_local4, f65_local5 in ipairs(CoD.FileshareUtility.SummaryProperties) do
		Engine[@"createmodel"](f65_local0, f65_local5)
	end
end
CoD.FileshareUtility.GetFileshareSummaryItemModel = function(f66_arg0, f66_arg1)
	local f66_local0 = Engine[@"getmodel"](f66_arg0, "summary")
	if f66_local0 then
		return Engine[@"getmodel"](f66_local0, f66_arg1)
	else
		return nil
	end
end
CoD.FileshareUtility.SetFileshareSummaryItem = function(f67_arg0, f67_arg1, f67_arg2)
	local f67_local0 = CoD.FileshareUtility.GetFileshareSummaryItemModel(f67_arg0, f67_arg1)
	if f67_local0 then
		Engine[@"setmodelvalue"](f67_local0, f67_arg2)
	end
end
CoD.FileshareUtility.ResetFileshareSummary = function(f68_arg0)
	if not Engine[@"getmodel"](f68_arg0, "summary") then
		CoD.FileshareUtility.InitFileshareSummaryModels(f68_arg0)
	end
	CoD.FileshareUtility.SetFileshareSummaryItem(f68_arg0, "isValid", false)
	CoD.FileshareUtility.SetFileshareSummaryItem(f68_arg0, "fileId", Engine[@"defaultid64value"]())
	CoD.FileshareUtility.SetFileshareSummaryItem(f68_arg0, "screenshotFileId", Engine[@"defaultid64value"]())
end
CoD.FileshareUtility.SetupFileShareSummary_MP = function(f69_arg0, f69_arg1, f69_arg2)
	local f69_local0 = f69_arg1.header
	local f69_local1 = f69_arg1.players
	local f69_local2 = f69_arg2.xuid
	local f69_local3 = f69_arg2.controller
	local f69_local4, f69_local5, f69_local6, f69_local7, f69_local8, f69_local9, f69_local10, f69_local11, f69_local12 = nil
	local f69_local13 = 0
	local f69_local14 = 0
	local f69_local15, f69_local16 = nil
	if not f69_local0 then
		return false
	end
	f69_local5 = f69_arg1.is_draw:get()
	f69_local6 = f69_arg1.victor:get()
	f69_local4 = f69_arg1.team_count:get()
	f69_local7 = f69_arg1.game_type:get()
	f69_local11 = 0
	f69_local12 = 0
	local f69_local17 = Engine[@"uint64tostring"](f69_local2)
	for f69_local18 = 1, #f69_local1, 1 do
		local f69_local21 = f69_local1[f69_local18 - 1]
		if f69_local21.client.user_id:get() == f69_local17 then
			f69_local10 = f69_local18 - 1
			f69_local8 = f69_local21.team:get()
			f69_local9 = f69_local21.position:get()
			f69_local13 = f69_local21.score:get()
			f69_local11 = f69_local21.kills:get()
			f69_local12 = f69_local21.deaths:get()
		end
		local f69_local22 = f69_local21.score:get()
		if f69_local14 < f69_local22 then
			f69_local14 = f69_local22
		end
	end
	if f69_local4 > 1 then
		f69_local13 = 0
		f69_local14 = 0
		if f69_local8 == Enum[@"team_t"][@"team_allies"] then
			f69_local13 = f69_arg1.allies_score:get()
			f69_local14 = f69_arg1.axis_score:get()
		elseif f69_local8 == Enum[@"team_t"][@"team_axis"] then
			f69_local13 = f69_arg1.axis_score:get()
			f69_local14 = f69_arg1.allies_score:get()
		end
	end
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "playerScore", f69_local13)
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "oppositionScore", f69_local14)
	local f69_local18 = {
		r = 0.39,
		g = 0.38,
		b = 0.36,
	}
	local f69_local19 = {
		r = 1,
		g = 0.19,
		b = 0.19,
	}
	local f69_local20 = {
		r = 0.42,
		g = 0.9,
		b = 0.46,
	}
	if f69_local4 == 1 then
		if f69_local9 == nil then
			f69_local15 = ""
			f69_local16 = f69_local18
		elseif f69_local5 == 1 then
			f69_local15 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_draw")
			f69_local16 = f69_local18
		elseif f69_local9 < 3 then
			f69_local15 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_victory")
			f69_local16 = f69_local20
		else
			f69_local15 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_defeat")
			f69_local16 = f69_local19
		end
	elseif f69_local5 == 1 then
		f69_local15 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_draw")
		f69_local16 = f69_local18
	elseif f69_local8 == f69_local6 then
		f69_local15 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_victory")
		f69_local16 = f69_local20
	else
		f69_local15 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/fileshare_defeat")
		f69_local16 = f69_local19
	end
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "gameResultText", f69_local15)
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "gameResultColor", CoD.ColorUtility.ConvertColor(f69_local16.r, f69_local16.g, f69_local16.b))
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "column1Header", Engine[@"hash_4F9F1239CFD921FE"](@"hash_16B234CB46B5ACD4"))
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "column1Value", f69_local11)
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "column2Header", Engine[@"hash_4F9F1239CFD921FE"](@"hash_5297A0D6FB981600"))
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "column2Value", f69_local12)
	if not f69_local10 then
		return false
	end
	local f69_local23 = f69_local1[f69_local10]
	local f69_local21 = {
		captures = 0,
		returns = 0,
		destroys = 0,
		plants = 0,
		defuses = 0,
		throws = 0,
		defending = 0,
		objectiveTime = f69_local23.objectiveTime:get(),
		escortTime = f69_local23.escortTime:get(),
	}
	if f69_local10 ~= nil then
		local f69_local22 = f69_arg1.game_events
		for f69_local24 = 1, #f69_local22, 1 do
			local f69_local27 = f69_local22[f69_local24 - 1]
			if f69_local10 == f69_local27.player_index:get() then
				local f69_local28 = f69_local27.event_type
				f69_local21.captures = f69_local21.captures + f69_local28.capture:get()
				f69_local21.returns = f69_local21.returns + f69_local28["return"]:get()
				f69_local21.destroys = f69_local21.destroys + f69_local28.destroy:get()
				f69_local21.plants = f69_local21.plants + f69_local28.plant:get()
				f69_local21.defuses = f69_local21.defuses + f69_local28.defuse:get()
				f69_local21.throws = f69_local21.throws + f69_local28.throw:get()
				f69_local21.defending = f69_local21.defending + f69_local28.defending:get()
			end
		end
	end
	local f69_local22, f69_local24, f69_local25, f69_local26 = nil
	if f69_local7 == @"tdm" or f69_local7 == @"dm" then
		f69_local22 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_644C900F3A44CF0A")
		f69_local24 = CoD.GetKDRatio(f69_local23.kills:get(), f69_local23.deaths:get())
		f69_local25 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_618CA55058E6B3A7")
		f69_local26 = f69_local23.assists:get()
	elseif f69_local7 == @"dom" or f69_local7 == @"hq" then
		f69_local22 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_32FA06E3E230002C")
		f69_local24 = f69_local21.captures
		f69_local25 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_753A6BBADFAAFDE8")
		f69_local26 = f69_local21.returns
	elseif f69_local7 == @"koth" then
		f69_local22 = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"mpui/objtime"))
		f69_local24 = CoD.GetTimeText(f69_local21.objectiveTime * 1000)
		f69_local25 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_753A6BBADFAAFDE8")
		f69_local26 = f69_local21.defending
	elseif f69_local7 == @"ctf" then
		f69_local22 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_32FA06E3E230002C")
		f69_local24 = f69_local21.captures
		f69_local25 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_56F9BD560FE7AE3A")
		f69_local26 = f69_local21.returns
	elseif f69_local7 == @"dem" or f69_local7 == @"sab" or f69_local7 == "sd" then
		f69_local22 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_242C6F36B505E71F")
		f69_local24 = f69_local21.plants
		f69_local25 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_451332C8EA3091FE")
		f69_local26 = f69_local21.defuses
	elseif f69_local7 == @"conf" then
		f69_local22 = Engine[@"hash_4F9F1239CFD921FE"](0x9E88F8E4394E52)
		f69_local24 = f69_local21.captures
		f69_local25 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A891E598EE9F7EA")
		f69_local26 = f69_local21.returns
	elseif f69_local7 == @"ball" then
		f69_local22 = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"mpui/carries"))
		f69_local24 = f69_local21.captures
		f69_local25 = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"mpui/throws"))
		f69_local26 = f69_local21.throws
	elseif f69_local7 == @"gun" then
		f69_local22 = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"mpui/stabs"))
		f69_local24 = f69_local21.captures
		f69_local25 = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"mpui/humiliated"))
		f69_local26 = f69_local21.returns
	elseif f69_local7 == @"escort" then
		f69_local22 = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"mpui/escorts"))
		f69_local24 = CoD.GetTimeText(f69_local21.escortTime * 1000)
		f69_local25 = Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](@"mpui/disables"))
		f69_local26 = f69_local21.returns
	else
		return false
	end
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "column3Header", f69_local22)
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "column3Value", f69_local24)
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "column4Header", f69_local25)
	CoD.FileshareUtility.SetFileshareSummaryItem(f69_arg0, "column4Value", f69_local26)
	return true
end
CoD.FileshareUtility.SetupFileShareSummary = function(f70_arg0, f70_arg1, f70_arg2)
	local f70_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	if f70_arg1 ~= f70_local0 then
		return
	end
	local f70_local1 = Engine[@"getxuid64"](f70_arg0)
	local f70_local2 = CoD.FileshareUtility.GetSelectedItemProperty("mainMode")
	local f70_local3 = Engine[@"getmatchrecordstats"](f70_arg0)
	if f70_local3 == nil then
		return
	end
	local f70_local4 = nil
	if f70_local2 == Enum[@"emodes"][@"mode_multiplayer"] then
		f70_local4 = CoD.FileshareUtility.SetupFileShareSummary_MP(f70_arg2, f70_local3, {
			controller = f70_arg0,
			xuid = f70_local1,
		})
	elseif f70_local2 == Enum[@"emodes"][@"mode_zombies"] then
	else
		return
	end
	if not f70_local4 then
		return
	end
	CoD.FileshareUtility.SetFileshareSummaryItem(f70_arg2, "isValid", true)
	CoD.FileshareUtility.SetFileshareSummaryItem(f70_arg2, "fileId", f70_local0)
	if CoD.FileshareUtility.GetSelectedItemProperty("currentCategory") == "screenshot" then
		CoD.FileshareUtility.SetFileshareSummaryItem(f70_arg2, "screenshotFileId", f70_local0)
	end
end
CoD.FileshareUtility.UpdateCurrentQuota = function(f71_arg0)
	local f71_local0 = Engine[@"filesharegetquota"](f71_arg0, CoD.FileshareUtility.GetCurrentCategory())
	if f71_local0 ~= nil then
		local f71_local1 = CoD.FileshareUtility.GetRootModel()
		f71_local1 = f71_local1:create("currentCategoryQuotaAvailable")
		f71_local1:set(f71_local0.categorySlotsAvailable)
		f71_local1 = CoD.FileshareUtility.GetRootModel()
		f71_local1 = f71_local1:create("currentCategoryQuotaUsed")
		f71_local1:set(f71_local0.categorySlotsUsed)
		f71_local1 = CoD.FileshareUtility.GetRootModel()
		f71_local1 = f71_local1:create("currentCategoryQuota")
		f71_local1:set(f71_local0.categoryQuota)
		f71_local1 = CoD.FileshareUtility.GetRootModel()
		f71_local1 = f71_local1:create("currentCategoryQuotaUsedPercent")
		f71_local1:set(f71_local0.categorySlotsUsed / math.max(f71_local0.categoryQuota, 1))
	end
end
CoD.FileshareUtility.GetCurrentQuota = function(f72_arg0)
	return Engine[@"filesharegetquota"](f72_arg0, CoD.FileshareUtility.GetCurrentCategory())
end
CoD.FileshareUtility.FileshareIsPublishing = function()
	if Engine[@"getmodelvalue"](CoD.FileshareUtility.GetPublishingModel()) == Enum[@"filesharetaskuistate"][@"fileshare_task_ui_working"] then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.FileshareIsPublishingInError = function()
	if Engine[@"getmodelvalue"](CoD.FileshareUtility.GetPublishingModel()) == Enum[@"filesharetaskuistate"][@"fileshare_task_ui_error"] then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.FileshareIsPublishingInSuccess = function()
	if Engine[@"getmodelvalue"](CoD.FileshareUtility.GetPublishingModel()) == Enum[@"filesharetaskuistate"][@"fileshare_task_ui_done"] then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.PublishCallback = nil
CoD.FileshareUtility.SetPublishName = function(f76_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "publishName"), f76_arg0)
end
CoD.FileshareUtility.GetPublishName = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "publishName"))
end
CoD.FileshareUtility.SetPublishDescription = function(f78_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "publishDescription"), f78_arg0)
end
CoD.FileshareUtility.GetPublishDescription = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "publishDescription"))
end
CoD.FileshareUtility.SetPublishTags = function(f80_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "publishTags"), f80_arg0)
end
CoD.FileshareUtility.GetPublishTags = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "publishTags"))
end
CoD.FileshareUtility.ResetPublishingModel = function()
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetPublishingModel(), -1)
end
CoD.FileshareUtility.SetPublishAllowDownload = function(f83_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "publishAllowDownload"), f83_arg0)
end
CoD.FileshareUtility.GetPublishAllowDownload = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "publishAllowDownload"))
end
CoD.FileshareUtility.OpenPublishPrompt = function(f85_arg0, f85_arg1, f85_arg2, f85_arg3, f85_arg4, f85_arg5)
	CoD.FileshareUtility.SetCurrentCategory(f85_arg2)
	CoD.FileshareUtility.PublishCallback = f85_arg5
	CoD.FileshareUtility.SetPublishName(f85_arg3)
	CoD.FileshareUtility.SetPublishDescription(f85_arg4)
	CoD.FileshareUtility.SetPublishAllowDownload(true)
	CoD.FileshareUtility.ResetPublishingModel()
	CoD.FileshareUtility.SetNotificationItemModel(f85_arg3)
	local f85_local0 = Engine[@"getxuid64"](f85_arg1)
	local f85_local1 = CoD.FileshareUtility.IsFileshareReady(f85_arg1)
	if f85_local1 == 0 or f85_local1 == false or CoD.FileshareUtility.GetCurrentUser() ~= f85_local0 then
		CoD.FileshareUtility.FetchContentForUser(f85_arg1, f85_local0)
		CoD.FileshareUtility.SetFileshareReady(false)
	end
	OpenPopup(f85_arg0, "FilesharePublish", f85_arg1)
end
CoD.FileshareUtility.Publish = function(f86_arg0)
	if CoD.FileshareUtility.PublishCallback == nil then
		return
	else
		CoD.FileshareUtility.PublishCallback(f86_arg0)
	end
end
CoD.FileshareUtility.ShouldDisablePrivateUpload = function(f87_arg0)
	if not FileshareIsReady(f87_arg0) or CoD.FileshareUtility.AreSlotsFull(f87_arg0) then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.FileshareIsReadyToUpload = function(f88_arg0)
	if not FileshareIsReady(f88_arg0) or CoD.FileshareUtility.FileshareIsUploading() then
		return false
	else
		return true
	end
end
CoD.FileshareUtility.FileshareIsUploading = function()
	local f89_local0 = CoD.FileshareUtility.GetUploadingModel()
	if f89_local0:get() == Enum[@"filesharetaskuistate"][@"fileshare_task_ui_working"] then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.FileshareIsUploadingInError = function()
	local f90_local0 = CoD.FileshareUtility.GetUploadingModel()
	if f90_local0:get() == Enum[@"filesharetaskuistate"][@"fileshare_task_ui_error"] then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.ResetUploadingModel = function()
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetUploadingModel(), -1)
end
CoD.FileshareUtility.OpenPrivateUploadPopup = function(f92_arg0, f92_arg1, f92_arg2, f92_arg3)
	CoD.FileshareUtility.SetCurrentCategory(f92_arg2)
	CoD.FileshareUtility.UploadCallback = f92_arg3
	CoD.FileshareUtility.SetPublishAllowDownload(false)
	CoD.FileshareUtility.ResetUploadingModel()
	local f92_local0 = Engine[@"getxuid64"](f92_arg1)
	local f92_local1 = CoD.FileshareUtility.IsFileshareReady(f92_arg1)
	if f92_local1 == 0 or f92_local1 == false or CoD.FileshareUtility.GetCurrentUser() ~= f92_local0 then
		CoD.FileshareUtility.FetchContentForUser(f92_arg1, f92_local0)
		CoD.FileshareUtility.SetDirty()
	end
	OpenPopup(f92_arg0, "DemoFileshareUpload", f92_arg1)
end
CoD.FileshareUtility.PrivateUpload = function(f93_arg0)
	if CoD.FileshareUtility.UploadCallback == nil then
		return
	else
		CoD.FileshareUtility.UploadCallback(f93_arg0)
	end
end
CoD.FileshareUtility.OpenDeleteFileshareFile = function(f94_arg0, f94_arg1)
	CoD.FileshareUtility.ClearCurrentFilter()
	CoD.FileshareUtility.InitModels()
	CoD.FileshareUtility.SetFileshareMode(f94_arg1, Enum[@"filesharemode"][@"fileshare_mode_user"])
	CoD.FileshareUtility.SetCurrentUser(Engine[@"getxuid64"](f94_arg1))
	CoD.FileshareUtility.SetDirty()
	CoD.FileshareUtility.FileshareCategorySelectorCategoryChanged(f94_arg1, CoD.FileshareUtility.GetCurrentCategory(), Enum[@"filesharecommunitydatatype"][@"fileshare_community_data_invalid"], false)
	PreserveThumbnails(f94_arg1, true)
	OpenPopup(f94_arg0, "DeleteFileshareFile", f94_arg1)
end
CoD.FileshareUtility.FileshareIsDeleting = function()
	if Engine[@"getmodelvalue"](CoD.FileshareUtility.GetDeletingModel()) == Enum[@"filesharetaskuistate"][@"fileshare_task_ui_working"] then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.FileshareIsDeletingInError = function()
	if Engine[@"getmodelvalue"](CoD.FileshareUtility.GetDeletingModel()) == Enum[@"filesharetaskuistate"][@"fileshare_task_ui_error"] then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.Delete = function(f97_arg0, f97_arg1, f97_arg2, f97_arg3, f97_arg4, f97_arg5)
	if FileshareIsCurrentUserContext(f97_arg2) == false then
		return
	end
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetDeletingModel(), Enum[@"filesharetaskuistate"][@"fileshare_task_ui_idle"])
	if f97_arg5 ~= nil then
		f97_arg4.m_leaveParentOpenAfterDelete = f97_arg5
	end
	if false == CoD.FileshareUtility.SelectedItemReady() and not FileshareIsLocalCategory(f97_arg2) and not CoD.FileshareUtility.GetCurrentCategory() == "customgame" and not CoD.FileshareUtility.GetCurrentCategory() == "screenshot" and not CoD.FileshareUtility.GetCurrentCategory() == "clip" then
		return
	end
	local f97_local0 = CoD.FileshareUtility.GetCurrentCategory()
	OpenPopup(f97_arg4, "FileshareOptions_Delete", f97_arg2)
end
CoD.FileshareUtility.DeleteYes = function(f98_arg0, f98_arg1, f98_arg2, f98_arg3, f98_arg4)
	if FileshareIsCurrentUserContext(f98_arg2) == false then
		return
	else
		CoD.FileshareUtility.SetNotificationItem(CoD.FileshareUtility.GetSelectedItem())
		Engine[@"filesharedelete"](f98_arg2, CoD.FileshareUtility.GetSelectedItemProperty("fileId"))
	end
end
CoD.FileshareUtility.DeleteNo = function(f99_arg0, f99_arg1, f99_arg2, f99_arg3, f99_arg4)
	GoBack(f99_arg4, f99_arg2)
end
CoD.FileshareUtility.DeleteDone = function(f100_arg0, f100_arg1, f100_arg2, f100_arg3, f100_arg4)
	local f100_local0 = GoBack(f100_arg4, f100_arg2)
	if f100_local0.menuName == "FileshareOptions" then
		GoBack(f100_local0, f100_arg2)
	end
	if f100_local0.m_leaveParentOpenAfterDelete ~= nil and f100_local0.m_leaveParentOpenAfterDelete == true then
		return
	else
		CoD.FileshareUtility.UpdateCurrentQuota(f100_arg2)
	end
end
CoD.FileshareUtility.FileshareIsDownloading = function(f101_arg0)
	if Engine[@"getmodelvalue"](CoD.FileshareUtility.GetDownloadingModel()) == Enum[@"filesharetaskuistate"][@"fileshare_task_ui_working"] then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.FileshareIsDownloadingInError = function(f102_arg0)
	if Engine[@"getmodelvalue"](CoD.FileshareUtility.GetDownloadingModel()) == Enum[@"filesharetaskuistate"][@"fileshare_task_ui_error"] then
		return true
	else
		return false
	end
end
CoD.FileshareUtility.DownloadCallback = nil
CoD.FileshareUtility.SetDownloadFileId = function(f103_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "downloadFileId"), f103_arg0)
end
CoD.FileshareUtility.GetDownloadFileId = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "downloadFileId"))
end
CoD.FileshareUtility.SetDownloadFileName = function(f105_arg0)
	Engine[@"setmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "downloadFileName"), f105_arg0)
end
CoD.FileshareUtility.GetDownloadFileName = function()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "downloadFileName"))
end
CoD.FileshareUtility.ResetDownloadingModel = function()
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetDownloadingModel(), -1)
end
CoD.FileshareUtility.OpenDownloadPrompt = function(f108_arg0, f108_arg1, f108_arg2)
	local f108_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	local f108_local1 = CoD.FileshareUtility.GetSelectedItemProperty("fileName")
	local f108_local2 = CoD.FileshareUtility.GetSelectedItemProperty("fileCategory")
	if CoD.FileshareUtility.GetSelectedItemProperty("isPublishNew") then
		return 0
	end
	CoD.FileshareUtility.SetCurrentCategory(f108_local2)
	CoD.FileshareUtility.DownloadCallback = f108_arg2
	CoD.FileshareUtility.SetDownloadFileId(f108_local0)
	CoD.FileshareUtility.SetDownloadFileName(f108_local1)
	CoD.FileshareUtility.ResetDownloadingModel()
	CoD.FileshareUtility.SetNotificationItem(CoD.FileshareUtility.GetSelectedItem())
	local f108_local3 = Engine[@"mediamanagergetquota"](f108_arg1, f108_local2)
	local f108_local4 = f108_local3.categorySlotsAvailable
	local f108_local5 = GoBack(f108_arg0, f108_arg1)
	if f108_local4 > 0 then
		OpenOverlay(f108_local5, "FileshareDownload", f108_arg1)
	else
		OpenOverlay(f108_local5, "MediaManagerSlotsFull", f108_arg1)
	end
end
CoD.FileshareUtility.GetLocalStorageType = function(f109_arg0)
	if f109_arg0 == "paintjob" then
		return Enum[@"storagefiletype"][@"storage_paintjobs"]
	elseif f109_arg0 == "emblem" then
		return Enum[@"storagefiletype"][@"storage_emblems"]
	else
	end
end
CoD.FileshareUtility.DownloadAction = function(f110_arg0, f110_arg1, f110_arg2, f110_arg3, f110_arg4)
	Engine[@"setmodelvalue"](CoD.FileshareUtility.GetDownloadingModel(), Enum[@"filesharetaskuistate"][@"fileshare_task_ui_idle"])
	CoD.FileshareUtility.OpenDownloadPrompt(f110_arg4, f110_arg2, CoD.FileshareUtility.DownloadActionCallback)
end
CoD.FileshareUtility.Download = function(f111_arg0)
	if CoD.FileshareUtility.DownloadCallback == nil then
		return
	else
		CoD.FileshareUtility.DownloadCallback(f111_arg0)
	end
end
CoD.FileshareUtility.DownloadActionCallback = function(f112_arg0)
	Engine[@"filesharedownload"](f112_arg0, CoD.FileshareUtility.GetCurrentCategory(), CoD.FileshareUtility.GetDownloadFileId(), CoD.FileshareUtility.GetDownloadFileName(), CoD.FileshareUtility.GetIsCommunityMode(f112_arg0))
end
CoD.FileshareUtility.CanDownload = function(f113_arg0)
	if Dvar[@"fileshare_enabled"] ~= nil and Dvar[@"fileshare_enabled"]:get() == false then
		return false
	end
	local f113_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileCategory")
	local f113_local1 = CoD.FileshareUtility.GetSelectedItemProperty("fileAuthorXuid")
	local f113_local2 = Engine[@"getxuid64"](f113_arg0)
	if Dvar[@"fileshareallowdownload"] ~= nil and Dvar[@"fileshareallowdownload"]:get() == false then
		return false
	elseif f113_local2 ~= f113_local1 and Dvar[@"fileshareallowdownloadingothersfiles"] ~= nil and Dvar[@"fileshareallowdownloadingothersfiles"]:get() == false then
		return false
	elseif f113_local0 == "paintjob" then
		if Dvar[@"fileshareallowpaintjobdownload"] ~= nil and Dvar[@"fileshareallowpaintjobdownload"]:get() == false then
			return false
		end
	elseif f113_local0 == "emblem" and Dvar[@"fileshareallowemblemdownload"] ~= nil and Dvar[@"fileshareallowemblemdownload"]:get() == false then
		return false
	end
	return true
end
CoD.FileshareUtility.SetupFileshareForTheater = function(f114_arg0)
	CoD.FileshareUtility.SetFileshareMode(f114_arg0, Enum[@"filesharemode"][@"fileshare_mode_user"])
	CoD.FileshareUtility.SetCurrentUser(Engine[@"getxuid64"](f114_arg0))
	CoD.FileshareUtility.SetDirty()
	if CoD.FileshareUtility.GetCurrentCommunityDataType() ~= Enum[@"filesharecommunitydatatype"][@"fileshare_community_data_recent_games"] then
		CoD.FileshareUtility.FileshareCategorySelectorCategoryChanged(f114_arg0, "recentgames", Enum[@"filesharecommunitydatatype"][@"fileshare_community_data_recent_games"], true)
	else
		CoD.FileshareUtility.FileshareCategorySelectorCategoryChanged(f114_arg0, "recentgames", Enum[@"filesharecommunitydatatype"][@"fileshare_community_data_recent_games"], false)
	end
end
CoD.FileshareUtility.FetchContentForUser = function(f115_arg0, f115_arg1)
	Engine[@"filesharefetchforuser"](f115_arg0, f115_arg1)
	CoD.FileshareUtility.SetCurrentUser(f115_arg1)
end
CoD.FileshareUtility.ReportLike = function(f116_arg0, f116_arg1, f116_arg2)
	local f116_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	local f116_local1 = CoD.FileshareUtility.GetSelectedItemProperty("fileCategory")
	local f116_local2 = CoD.FileshareUtility.GetSelectedItemProperty("uiModelIndex")
	CoD.FileshareUtility.SetNotificationItem(CoD.FileshareUtility.GetSelectedItem())
	Engine[@"filesharereportvote"](f116_arg2, f116_local1, f116_local0, f116_local2, true)
end
CoD.FileshareUtility.ReportDislike = function(f117_arg0, f117_arg1, f117_arg2)
	local f117_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	local f117_local1 = CoD.FileshareUtility.GetSelectedItemProperty("fileCategory")
	local f117_local2 = CoD.FileshareUtility.GetSelectedItemProperty("uiModelIndex")
	CoD.FileshareUtility.SetNotificationItem(CoD.FileshareUtility.GetSelectedItem())
	Engine[@"filesharereportvote"](f117_arg2, f117_local1, f117_local0, f117_local2, false)
end
CoD.FileshareUtility.AllowDownload = function(f118_arg0, f118_arg1, f118_arg2, f118_arg3, f118_arg4) end
CoD.FileshareUtility.OpenShowcaseManager = function(f119_arg0, f119_arg1, f119_arg2, f119_arg3, f119_arg4)
	if FileshareIsCurrentUserContext(f119_arg2) == false then
		return
	else
		CoD.FileshareUtility.SetShowCreateButton(FileshareCanBuyMoreSlots(f119_arg2))
		GoBackAndOpenOverlayOnParent(f119_arg4, "Fileshare_ShowcaseManager", f119_arg2)
	end
end
CoD.FileshareUtility.OpenBuySlots = function(f120_arg0, f120_arg1, f120_arg2, f120_arg3, f120_arg4)
	OpenBuyExtraSlotsPackDialog(f120_arg0, f120_arg1, f120_arg2)
end
CoD.FileshareUtility.GetCategoryImage = function(f121_arg0)
	local f121_local0 = CoD.FileshareUtility.Images[f121_arg0]
	if f121_local0 == nil then
		return ""
	else
		return f121_local0
	end
end
CoD.FileshareUtility.GetCategoryLargeImage = function(f122_arg0)
	local f122_local0 = CoD.FileshareUtility.LargeImages[f122_arg0]
	if f122_local0 == nil then
		return ""
	else
		return f122_local0
	end
end
CoD.FileshareUtility.GetCategoryColor = function(f123_arg0)
	local f123_local0 = CoD.FileshareUtility.Colors[f123_arg0]
	return string.format("%d %d %d", f123_local0.r * 255, f123_local0.g * 255, f123_local0.b * 255)
end
CoD.FileshareUtility.GetCurrentCommunityMenuTitle = function()
	local f124_local0 = CoD.FileshareUtility.GetCurrentCommunityDataType()
	for f124_local4, f124_local5 in ipairs(CoD.FileshareUtility.CommunityTitles) do
		if f124_local5.dataType == f124_local0 then
			return f124_local5.title
		end
	end
	return ""
end
CoD.FileshareUtility.GetCurrentCommunityMenuKicker = function()
	local f125_local0 = CoD.FileshareUtility.GetCurrentCommunityDataType()
	for f125_local4, f125_local5 in ipairs(CoD.FileshareUtility.CommunityTitles) do
		if f125_local5.dataType == f125_local0 then
			return f125_local5.kicker
		end
	end
	return ""
end
CoD.FileshareUtility.ProcessUIIndex = function(f126_arg0, f126_arg1, f126_arg2)
	local f126_local0 = CoD.FileshareUtility.GetIsCommunityMode(f126_arg0)
	local f126_local1, f126_local2 = CoD.FileshareUtility.GetCurrentFilter()
	Engine[@"fileshareprocessuiindex"](f126_arg0, f126_arg1, f126_arg2, f126_local0, f126_local1, f126_local2)
end
CoD.FileshareUtility.GetCategoryCurrentPage = function(f127_arg0)
	local f127_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "pagination"), "currentPages"), f127_arg0)
	if f127_local0 == nil then
		return 0
	end
	local f127_local1 = Engine[@"getmodelvalue"](f127_local0)
	if f127_local1 == nil then
		f127_local1 = 0
	end
	return f127_local1
end
CoD.FileshareUtility.SetCategoryCurrentPage = function(f128_arg0, f128_arg1, f128_arg2)
	if f128_arg1 == nil or f128_arg2 == nil then
		return
	else
		local f128_local0 = Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "pagination"), "currentPages"), f128_arg1)
	end
end
CoD.FileshareUtility.LoadTheaterFile = function(f129_arg0, f129_arg1, f129_arg2, f129_arg3, f129_arg4)
	local f129_local0 = f129_arg1:getModel()
	local f129_local1 = {
		controller = f129_arg2,
		map = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "mapName")),
		gametype = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "gameTypeName")),
		isPooled = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "isPooled")),
		fileID = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "fileId")),
		fileSize = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "fileSize")),
		fileName = "film.demo",
	}
	if f129_local1.isPooled == false then
		f129_local1.fileName = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "demoName"))
	end
	f129_local1.authorXUID = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "fileAuthorXuid"))
	f129_local1.authorName = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "fileAuthorName"))
	f129_local1.mainMode = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "mainMode"))
	f129_local1.isLiveStream = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "isLiveStream"))
	f129_local1.duration = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "duration"))
	f129_local1.fileCategory = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "fileCategory"))
	f129_local1.maxClients = Engine[@"getmodelvalue"](Engine[@"getmodel"](f129_local0, "maxClients"))
	f129_local1.demoMode = ""
	Engine[@"setdvar"]("ui_demoname", f129_local1.fileName)
	Engine[@"lobbyupdatedemoinformation"](Enum[@"lobbymodule"][@"lobby_module_host"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_host"]), f129_local1)
	CoD.FileshareUtility.SetAutoStart(true)
end
CoD.FileshareUtility.IsCategoryFilm = function(f130_arg0, f130_arg1)
	local f130_local0 = f130_arg1:getModel()
	if not f130_local0 then
		return false
	else
		local f130_local1 = Engine[@"getmodel"](f130_local0, "fileCategory")
		if f130_local1 then
			local f130_local2 = Engine[@"getmodelvalue"](f130_local1)
			local f130_local3
			if f130_local2 ~= "film" and f130_local2 ~= "recentgames" and f130_local2 ~= "film_private" then
				f130_local3 = false
			else
				f130_local3 = true
			end
			return f130_local3
		else
			return false
		end
	end
end
CoD.FileshareUtility.IsCategoryClip = function(f131_arg0, f131_arg1)
	local f131_local0 = f131_arg1:getModel()
	if not f131_local0 then
		return false
	else
		local f131_local1 = Engine[@"getmodel"](f131_local0, "fileCategory")
		if f131_local1 then
			local f131_local2 = Engine[@"getmodelvalue"](f131_local1)
			local f131_local3
			if f131_local2 ~= "clip" and f131_local2 ~= "clip_private" then
				f131_local3 = false
			else
				f131_local3 = true
			end
			return f131_local3
		else
			return false
		end
	end
end
CoD.FileshareUtility.IsCategoryScreenshot = function(f132_arg0, f132_arg1)
	local f132_local0 = f132_arg1:getModel()
	if not f132_local0 then
		return false
	else
		local f132_local1 = Engine[@"getmodel"](f132_local0, "fileCategory")
		if f132_local1 then
			local f132_local2 = Engine[@"getmodelvalue"](f132_local1)
			local f132_local3
			if f132_local2 ~= "screenshot" and f132_local2 ~= "screenshot_private" then
				f132_local3 = false
			else
				f132_local3 = true
			end
			return f132_local3
		else
			return false
		end
	end
end
CoD.FileshareUtility.IsCategoryCustomGames = function(f133_arg0, f133_arg1)
	local f133_local0 = f133_arg1:getModel()
	if not f133_local0 then
		return false
	else
		local f133_local1 = Engine[@"getmodel"](f133_local0, "fileCategory")
		if f133_local1 then
			local f133_local2 = Engine[@"getmodelvalue"](f133_local1)
			local f133_local3
			if f133_local2 ~= "customgame" and f133_local2 ~= "customgame_private" then
				f133_local3 = false
			else
				f133_local3 = true
			end
			return f133_local3
		else
			return false
		end
	end
end
CoD.FileshareUtility.IsInvalidFile = function(f134_arg0, f134_arg1)
	local f134_local0 = f134_arg1:getModel()
	if not f134_local0 then
		return true
	end
	local f134_local1 = Engine[@"getmodel"](f134_local0, "isValid")
	if f134_local1 and f134_local1:get() == false then
		return true
	elseif not CoD.FileshareUtility.IsCategoryCustomGames(f134_arg0, f134_arg1) then
		local f134_local2 = Engine[@"getmodel"](f134_local0, "map")
		if f134_local2 and f134_local2:get() == 0 then
			return true
		end
		local f134_local3 = Engine[@"getmodel"](f134_local0, "gameType")
		if f134_local3 and f134_local3:get() == 0 then
			return true
		end
	end
	return false
end
CoD.FileshareUtility.IsLowOnSlots = function(f135_arg0)
	local f135_local0 = CoD.FileshareUtility.GetCurrentQuota(f135_arg0)
	if f135_local0 and f135_local0.categoryQuota and f135_local0.categorySlotsUsed then
		return math.floor(f135_local0.categoryQuota * 0.95) <= f135_local0.categorySlotsUsed
	else
		return false
	end
end
CoD.FileshareUtility.AreSlotsFull = function(f136_arg0)
	local f136_local0 = CoD.FileshareUtility.GetCurrentQuota(f136_arg0)
	if f136_local0 and f136_local0.categorySlotsAvailable then
		return f136_local0.categorySlotsAvailable <= 0
	else
		return true
	end
end
CoD.FileshareUtility.NotificationItemModel = nil
CoD.FileshareUtility.SetNotificationItemModel = function(f137_arg0)
	local f137_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "toastItem")
	if f137_local0 then
		Engine[@"setmodelvalue"](Engine[@"createmodel"](f137_local0, "fileName"), f137_arg0)
		CoD.FileshareUtility.SetNotificationItem(f137_local0)
	end
end
CoD.FileshareUtility.SetNotificationItem = function(f138_arg0)
	CoD.FileshareUtility.NotificationItemModel = f138_arg0
end
CoD.FileshareUtility.GetNotificationItem = function()
	return CoD.FileshareUtility.NotificationItemModel
end
CoD.FileshareUtility.ShowToast = function(f140_arg0, f140_arg1)
	local f140_local0 = CoD.FileshareUtility.GetNotificationItem()
	if f140_local0 == nil then
		return
	end
	local f140_local1 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f140_local0, "fileName"))
	local f140_local2 = CoD.FileshareUtility.GetCurrentCategory()
	local f140_local3 = Engine[@"hash_4F9F1239CFD921FE"](f140_arg1.kicker) .. " " .. Engine[@"localize"](Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCategoryNameSingle")))
	local f140_local4 = f140_arg1.description
	if type(f140_local4) == "xhash" then
		f140_local4 = Engine[@"hash_4F9F1239CFD921FE"](f140_local4)
	else
		f140_local4 = string.format(f140_arg1.description, f140_local1)
	end
	CoD.OverlayUtility.ShowToast("Fileshare", f140_local3, f140_local4, CoD.FileshareUtility.GetCategoryImage(f140_local2), f140_arg1.functionIcon)
end
CoD.FileshareUtility.ShowToastForSelectedItem = function(f141_arg0, f141_arg1)
	local f141_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileName")
	local f141_local1 = Engine[@"getmodelvalue"](Engine[@"createmodel"](CoD.FileshareUtility.GetRootModel(), "currentCategoryNameSingle"))
	local f141_local2 = CoD.FileshareUtility.GetCurrentCategory()
	if f141_local2 == nil or f141_local1 == nil then
		return
	else
		CoD.OverlayUtility.ShowToast("Fileshare", Engine[@"localize"](f141_arg1.kicker) .. " " .. Engine[@"localize"](f141_local1), string.format(f141_arg1.description, f141_local0), CoD.FileshareUtility.GetCategoryImage(f141_local2), f141_arg1.functionIcon)
	end
end
CoD.FileshareUtility.ShowSimpleToast = function(f142_arg0, f142_arg1)
	local f142_local0 = Engine[@"localize"](f142_arg1.kicker)
	local f142_local1 = Engine[@"localize"](f142_arg1.description)
	local f142_local2 = f142_arg1.functionIcon
	CoD.OverlayUtility.ShowToast("Fileshare", f142_local0, f142_local1, f142_local2, f142_local2)
end
CoD.FileshareUtility.ReportView = function(f143_arg0, f143_arg1)
	local f143_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileCategoryId")
	local f143_local1 = CoD.FileshareUtility.GetSelectedItemProperty("fileId")
	if f143_local0 and f143_local1 and CoD.FileshareUtility.GetSelectedItemProperty("fileAuthorXuid") ~= Engine[@"getxuid64"](f143_arg0) then
		Engine[@"filesharereportview"](f143_arg0, f143_local0, f143_local1, f143_arg1)
	end
end
