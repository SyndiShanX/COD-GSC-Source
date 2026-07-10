require("x64:efa8a4b4cd2668b")
function AlwaysFalse()
	return false
end
function AlwaysTrue()
	return true
end
function IsVisibilityBitSet(f3_arg0, f3_arg1)
	if Engine[@"isvisibilitybitset"](f3_arg0, f3_arg1) then
		return true
	else
		return false
	end
end
function CanReportPlayerEndGameWarzone(f4_arg0, f4_arg1)
	local f4_local0 = Engine[@"getmodelforcontroller"](f4_arg1)
	f4_local0 = f4_local0.Attacker
	if f4_local0 then
		local f4_local1 = f4_local0.xuid
		if f4_local1 then
			f4_local1 = f4_local0.xuid:get()
		end
		local f4_local2 = Engine[@"defaultid64value"]()
		local f4_local3 = f4_local1
		local f4_local4
		if f4_local1 ~= f4_local2 then
			f4_local4 = not Engine[@"isvisibilitybitset"](f4_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"])
		else
			f4_local4 = false
		end
		return f4_local4
	else
		return false
	end
end
function IsMediaManager()
	local f5_local0 = Engine[@"getmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "MediaManager", false), "isMediaManager")
	if f5_local0 then
		return Engine[@"getmodelvalue"](f5_local0) == 1
	else
		return false
	end
end
function CanShowMediaManager()
	return false
end
function FileshareIsSteamAgreed()
	return CoD.SteamWorkshopUtility.GetPublishSteamAgreement()
end
function FilesharePublishToSteamDisabled(f8_arg0)
	local f8_local0
	if FileshareIsSteamAgreed() then
		f8_local0 = not FileshareIsReady(f8_arg0)
	else
		f8_local0 = true
	end
	return f8_local0
end
function FileshareShouldAllowDownload()
	return CoD.FileshareUtility.GetPublishAllowDownload()
end
function FileshareIsReady(f10_arg0)
	local f10_local0 = CoD.FileshareUtility.IsFileshareReady(f10_arg0)
	if f10_local0 == 0 then
		return false
	else
		return f10_local0 == 1
	end
end
function FileshareHasContent(f11_arg0, f11_arg1)
	local f11_local0 = FileshareIsReady(f11_arg1)
	if f11_local0 and f11_local0 == true then
		if CoD.FileshareUtility.GetItemsCount() == 0 then
			return false
		else
			return true
		end
	else
		return false
	end
end
function FileshareIsCommunityMode(f12_arg0, f12_arg1)
	return CoD.FileshareUtility.GetIsCommunityMode(f12_arg1)
end
function FilesshareCanShowVoteOptions(f13_arg0)
	if CoD.FileshareUtility.GetSelectedItemProperty("fileAuthorXuid") == Engine[@"getxuid64"](f13_arg0) then
		return false
	else
		return true
	end
end
function FileshareCanDownloadItem(f14_arg0)
	if CoD.FileshareUtility.CanDownload(f14_arg0) == false then
		return false
	else
		return CoD.FileshareUtility.SelectedItemReady()
	end
end
function FileshareCanPublish(f15_arg0)
	if not isFileshareFeatureEnabled() or IsUserContentRestricted(f15_arg0) then
		return false
	else
		return true
	end
end
function FileshareCanDeleteItem(f16_arg0)
	if CoD.FileshareUtility.GetIsCommunityMode(f16_arg0) then
		return false
	elseif FileshareIsCurrentUserContext(f16_arg0) then
		return true
	else
		return false
	end
end
function FileshareIsLocalCategory(f17_arg0)
	local f17_local0 = CoD.FileshareUtility.GetCurrentCategory()
	local f17_local1
	if f17_local0 ~= "screenshot_private" and f17_local0 ~= "clip_private" then
		f17_local1 = false
	else
		f17_local1 = true
	end
	return f17_local1
end
function FileshareCanShowShowcaseManager(f18_arg0)
	if CoD.FileshareUtility.GetIsFullscreenMode(f18_arg0) == true then
		return false
	elseif CoD.FileshareUtility.GetIsCommunityMode(f18_arg0) then
		return false
	elseif FileshareHasContent(nil, f18_arg0) == false then
		return false
	elseif FileshareIsLocalCategory(f18_arg0) then
		return false
	elseif FileshareIsCurrentUserContext(f18_arg0) then
		return true
	else
		return false
	end
end
function FileshareCanShowOptionsMenu(f19_arg0)
	if Engine[@"isdemoplaying"]() then
		return
	else
		local f19_local0 = CoD.FileshareUtility.GetCurrentCategory()
		if f19_local0 == "recentgames" or f19_local0 == "film" then
			return false
		elseif FileshareHasContent(nil, f19_arg0) == false then
			return false
		elseif FileshareIsReady(f19_arg0) == false then
			return false
		else
			return DoesHaveFileshareOptions(f19_arg0)
		end
	end
end
function HasAdminPrivilege(f20_arg0, f20_arg1)
	local f20_local0 = f20_arg1
	if CoD.perController[f20_arg0].selectedGroup then
		local f20_local1 = Engine[@"getmodelvalue"](Engine[@"getmodel"](CoD.perController[f20_arg0].selectedGroup, "groupId"))
		local f20_local2 = IsGroupOwner(f20_arg0)
		if not f20_local2 then
			f20_local2 = Engine[@"groupadminhasprivilege"](f20_arg0, f20_local1, f20_local0)
		end
		return f20_local2
	else
		return false
	end
end
function FileshareCanDownloadItem(f21_arg0)
	if CoD.FileshareUtility.CanDownload(f21_arg0) == false then
		return false
	else
		local f21_local0 = CoD.FileshareUtility.GetSelectedItemProperty("fileCategory")
		if f21_local0 == "clip" or f21_local0 == "screenshot" then
			return false
		else
			return CoD.FileshareUtility.SelectedItemReady()
		end
	end
end
function FileshareCanOpenDetailsView(f22_arg0, f22_arg1)
	if FileshareHasContent(nil, f22_arg1) == false then
		return false
	else
		return CoD.FileshareUtility.SelectedItemReady()
	end
end
function isFileshareFeatureEnabled()
	if Dvar[@"fileshare_enabled"] ~= nil and Dvar[@"fileshare_enabled"]:get() == true then
		return true
	else
		return false
	end
end
function FileshareIsCurrentUserContext(f24_arg0)
	if Engine[@"getxuid64"](f24_arg0) == CoD.FileshareUtility.GetCurrentUser() then
		return true
	else
		return false
	end
end
function IsRecentGameBookmarked(f25_arg0)
	local f25_local0 = CoD.AARUtility.GetCurrentStats(f25_arg0)
	local f25_local1 = f25_local0 and f25_local0.AfterActionReportStats
	local f25_local2 = f25_local1
	local f25_local3 = f25_local1.demoFileID
	if f25_local3 then
		f25_local3 = f25_local2 and f25_local1.demoFileID:get()
	end
	if f25_local3 ~= nil and f25_local3 ~= Engine[@"defaultid64value"]() then
		return Engine[@"isrecentgamebookmarked"](f25_arg0, f25_local3)
	else
		return true
	end
end
function FileshareCanShowPlayerDetails(f26_arg0)
	if CoD.FileshareUtility.GetIsCommunityMode(f26_arg0) then
		return true
	else
		return false
	end
end
function FileshareShowcaseSlotsAvailable(f27_arg0)
	return not CoD.FileshareUtility.AreSlotsFull(f27_arg0)
end
function MediaManagerSlotsAvailable(f28_arg0, f28_arg1)
	local f28_local0 = Engine[@"mediamanagergetquota"](f28_arg0, f28_arg1)
	if f28_local0 and f28_local0.categorySlotsAvailable then
		return f28_local0.categorySlotsAvailable > 0
	else
		return false
	end
end
function FileshareIsCategory(f29_arg0, f29_arg1)
	return CoD.FileshareUtility.GetCurrentCategory() == f29_arg1
end
function FileshareCanBuyMoreSlots(f30_arg0)
	if DoesPlayerHaveExtraSlotsItem(f30_arg0) then
		return false
	else
		return AreCodPointsEnabled(f30_arg0)
	end
end
function IsInFileshare(f31_arg0)
	if CoD.perController[f31_arg0].inFileshare then
		return CoD.perController[f31_arg0].inFileshare == true
	else
		return false
	end
end
function IsInCustomGames()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "CustomGamesRoot"), "inCustomGames")) == 1
end
function ShouldOpenMessageDialog(f33_arg0, f33_arg1)
	if f33_arg0:getParent() == nil then
		return
	end
	local f33_local0 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "messageDialog")
	if f33_local0 ~= nil then
		if IsInGame() then
			local f33_local1 = Engine[@"getmodel"](f33_local0, "controller")
			if f33_local1 ~= nil and Engine[@"getmodelvalue"](f33_local1) ~= f33_arg1 then
				return false
			end
		end
		local f33_local1 = Engine[@"getmodel"](f33_local0, "messagePending")
		if f33_local1 ~= nil and Engine[@"getmodelvalue"](f33_local1) > 0 then
			return true
		end
	end
	return false
end
function IsLuaCodeVersionAtLeast(f34_arg0)
	return f34_arg0 <= Engine[@"getluacodeversion"]()
end
function IsInDefaultState(f35_arg0)
	return f35_arg0.currentState == "DefaultState"
end
function IsElementInState(f36_arg0, f36_arg1)
	return f36_arg0.currentState == f36_arg1
end
function IsListElementChildInState(f37_arg0, f37_arg1, f37_arg2)
	if f37_arg0 and f37_arg0[f37_arg1] then
		return f37_arg0[f37_arg1].currentState == f37_arg2
	else
		return false
	end
end
function IsElementInAnyState(f38_arg0, ...)
	for f38_local3, f38_local4 in ipairs({
		n = select("#", ...),
		...,
	}) do
		if f38_local4 == f38_arg0.currentState then
			return true
		end
	end
	return false
end
function IsChildElementInState(f39_arg0, f39_arg1, f39_arg2)
	return f39_arg0[f39_arg1].currentState == f39_arg2
end
function IsMenuInState(f40_arg0, f40_arg1)
	return f40_arg0.currentState == f40_arg1
end
function IsMenuModelValueEqualTo(f41_arg0, f41_arg1, f41_arg2)
	local f41_local0 = f41_arg0:getModel()
	if f41_arg1 ~= "" and f41_local0 then
		f41_local0 = Engine[@"getmodel"](f41_local0, f41_arg1)
	end
	local f41_local1 = f41_local0 and Engine[@"getmodelvalue"](f41_local0)
	local f41_local2
	if f41_local1 == nil or f41_local1 ~= f41_arg2 then
		f41_local2 = false
	else
		f41_local2 = true
	end
	return f41_local2
end
function IsSelfInState(f42_arg0, f42_arg1)
	return f42_arg0.currentState == f42_arg1
end
function IsTransitionClipPlaying(f43_arg0)
	return f43_arg0.currentClipIsTransitionClip == true
end
function ShouldSwapCircleAndCross()
	return Engine[@"shouldswapcontrollercircleandcross"]()
end
function IsWidthZero(f45_arg0)
	return f45_arg0 == 0
end
function InFrontend()
	return CoD.isFrontend
end
function IsFirstListElement(f47_arg0)
	return f47_arg0:isFirstItem()
end
function IsLastListElement(f48_arg0)
	return f48_arg0:isLastItem()
end
function ListElementHasElements(f49_arg0)
	return CoD.GridAndListUtility.ListElementHasAtLeastNumElements(f49_arg0, 1)
end
function HasListAction(f50_arg0, f50_arg1)
	return f50_arg0:getModel(f50_arg1, "action") or f50_arg0.action
end
function IsElementModelConditionFn(f51_arg0, f51_arg1, f51_arg2, f51_arg3, f51_arg4)
	if f51_arg2 then
		local f51_local0 = f51_arg2:getModel(f51_arg3, f51_arg4)
		if f51_local0 then
			local f51_local1 = f51_local0:get()
			if f51_local1 then
				return f51_local1(f51_arg0, f51_arg1, f51_arg2, f51_arg3)
			end
		end
	end
	return false
end
function IsAnyCurrentMouseFocus(f52_arg0)
	return CoD.GetMouseFocus(f52_arg0) ~= nil
end
function IsElementInFocus(f53_arg0)
	return f53_arg0:isInFocus()
end
function ParentHasChildFocus(f54_arg0)
	local f54_local0 = f54_arg0.parent
	local f54_local1
	if f54_local0 ~= nil then
		f54_local1 = f54_local0.__hasChildFocus
	else
		f54_local1 = false
	end
	return f54_local1
end
function IsWidgetInFocus(f55_arg0, f55_arg1, f55_arg2)
	if f55_arg0[f55_arg1] then
		if f55_arg2.idStack then
			local f55_local0 = f55_arg0[f55_arg1].id
			for f55_local4, f55_local5 in ipairs(f55_arg2.idStack) do
				if f55_local5 == f55_local0 then
					return true
				end
			end
			return false
		elseif f55_arg2.id then
			return f55_arg0[f55_arg1]:hasChildWithID(f55_arg2.id)
		else
			return f55_arg0[f55_arg1]:doesElementOrChildHaveFocus()
		end
	else
		return false
	end
end
function IsFirstTimeSetup(f56_arg0, f56_arg1)
	if Dvar[@"livestats_skipfirsttime"]:get() then
		return false
	elseif not (not Engine[@"ismultiplayergame"]() or not IsLAN()) or Engine[@"isingame"]() then
		return false
	elseif f56_arg1 ~= Enum[@"emodes"][@"mode_campaign"] then
		return false
	else
		return not Engine[@"isfirsttimecomplete"](f56_arg0, f56_arg1)
	end
end
function IsCampaignStoryFirstTimeSetup(f57_arg0)
	return IsFirstTimeSetup(f57_arg0, Enum[@"emodes"][@"mode_campaign"]) and CoD.DirectorUtility.IsLobbyMenu(f57_arg0, LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY)
end
function IsMainFirstTimeSetup(f58_arg0)
	return CoDShared.IsMainFirstTimeSetup(f58_arg0)
end
function IsBooleanDvarSet(f59_arg0)
	return CoDShared.IsIntDvarNonZero(f59_arg0)
end
function IsIntDvarNonZero(f60_arg0)
	return CoDShared.IsIntDvarNonZero(f60_arg0)
end
function IsDvarValueEqualTo(f61_arg0, f61_arg1)
	if Dvar[f61_arg0] then
		return Dvar[f61_arg0]:get() == f61_arg1
	else
	end
end
function IsInGame()
	return CoDShared.IsInGame()
end
function GameEnded(f63_arg0)
	return IsVisibilityBitSet(f63_arg0, Enum[@"uivisibilitybit"][@"bit_game_ended"])
end
function IsCurrentMenu(f64_arg0, f64_arg1)
	if f64_arg0.menuName == f64_arg1 then
		return true
	else
		return false
	end
end
function IsElementReceivingMenuOpenEventForTheFirstTime(f65_arg0)
	if f65_arg0.__menuOpened == nil then
		f65_arg0.__menuOpened = true
		return true
	else
		return false
	end
end
function IsEventPropertyEqualTo(f66_arg0, f66_arg1, f66_arg2)
	return f66_arg0 and f66_arg0[f66_arg1] == f66_arg2
end
function PropertyIsTrue(f67_arg0, f67_arg1)
	if f67_arg0 == nil then
		return false
	else
		return f67_arg0[f67_arg1] == true
	end
end
function MenuPropertyIsTrue(f68_arg0, f68_arg1)
	return f68_arg0 and f68_arg0[f68_arg1] == true
end
function IsMenuPropertyValue(f69_arg0, f69_arg1, f69_arg2)
	return f69_arg0 and f69_arg0[f69_arg1] == f69_arg2
end
function ArenaModeEquals(f70_arg0, f70_arg1)
	local f70_local0 = f70_arg0:getModel()
	if f70_local0.eventType == nil then
		return false
	else
		f70_local0 = f70_arg0:getModel()
		return f70_local0.eventType:get() == f70_arg1
	end
end
function IsSelfPropertyValue(f71_arg0, f71_arg1, f71_arg2)
	return f71_arg0 and f71_arg0[f71_arg1] == f71_arg2
end
function IsElementPropertyValue(f72_arg0, f72_arg1, f72_arg2)
	if f72_arg0 == nil then
		return false
	else
		return f72_arg0[f72_arg1] == f72_arg2
	end
end
function HasProperty(f73_arg0, f73_arg1)
	if f73_arg0 == nil then
		return false
	else
		return f73_arg0[f73_arg1] ~= nil
	end
end
function ParentObjectivePropertyIsTrue(f74_arg0, f74_arg1)
	return f74_local0.objective and f74_local1 and f74_local0.objective[f74_arg1] == true
end
function IsPerControllerTablePropertyValue(f75_arg0, f75_arg1, f75_arg2)
	return CoD.perController[f75_arg0][f75_arg1] == f75_arg2
end
function IsActiveLocalClientsCountEqualTo(f76_arg0)
	return Engine[@"getactivelocalclientscount"]() == f76_arg0
end
function IsTextWrapping(f77_arg0, f77_arg1)
	if f77_arg1 == nil then
		return false
	else
		local f77_local0, f77_local1, f77_local2, f77_local3 = f77_arg1:getLocalLeftRight()
		local f77_local4 = f77_local3 - f77_local2
		local f77_local5, f77_local6 = f77_arg1:getTextWidthAndHeight()
		return f77_local4 < f77_local5
	end
end
function IsTextEmpty(f78_arg0)
	return f78_arg0:getText() == ""
end
function IsCampaign()
	local f79_local0 = LobbyData.GetCurrentMenuTarget()
	return f79_local0[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_cp"]
end
function IsMultiplayer()
	local f80_local0 = LobbyData.GetCurrentMenuTarget()
	return f80_local0[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_mp"]
end
function IsZombies()
	local f81_local0 = LobbyData.GetCurrentMenuTarget()
	return f81_local0[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_zm"]
end
function IsWarzone()
	local f82_local0 = LobbyData.GetCurrentMenuTarget()
	return f82_local0[@"mainmode"] == Enum[@"lobbymainmode"][@"lobby_mainmode_wz"]
end
function IsWarzoneOrCurrentMilestone()
	local f83_local0 = LobbyData.GetCurrentMenuTarget()
	local f83_local1
	if f83_local0[@"mainmode"] ~= Enum[@"lobbymainmode"][@"lobby_mainmode_wz"] then
		f83_local1 = CoD.DirectorUtility.DisableForCurrentMilestone(nil)
	else
		f83_local1 = true
	end
	return f83_local1
end
function IsAttackingTeam(f84_arg0)
	local f84_local0 = Engine[@"getglobalmodel"]()
	f84_local0 = f84_local0.hudItems
	if f84_local0 ~= nil then
		local f84_local1 = f84_local0.war
		if f84_local1 ~= nil then
			local f84_local2 = f84_local1.attackingTeam
			if f84_local2 ~= nil then
				return CoD.TeamUtility.GetTeam(f84_arg0) == f84_local2:get()
			end
		end
	end
	return false
end
function IsAttackDefendGametype()
	local f85_local0 = Engine[@"getgametypeinfo"](Engine[@"hash_36F8027A8BC75673"]())
	return f85_local0[@"hash_6E5603BDA6A73B59"] == 1
end
function IsNeutralGametype(f86_arg0)
	if Engine[@"getgametypesetting"](@"neutralzone") == 1 then
		return true
	else
		return false
	end
end
function IsObjectiveBasedGametype()
	local f87_local0 = Engine[@"hash_36F8027A8BC75673"]()
	local f87_local1
	if f87_local0 == "tdm" or f87_local0 == "dm" or f87_local0 == "frontline" then
		f87_local1 = false
	else
		f87_local1 = true
	end
	return f87_local1
end
function IsGroupsEnabled(f88_arg0)
	if CoD.DirectorUtility.DisableForCurrentMilestone(f88_arg0) then
		return false
	else
		local f88_local0 = Dvar[@"groups_enabled"]:get()
		if f88_local0 ~= nil and f88_local0 == true then
			return true
		else
			return false
		end
	end
end
function SelectingGroupEmblem(f89_arg0)
	return CoD.perController[f89_arg0].selectingGroupEmblem
end
function SelectingGroupEmblemForGroupCreation(f90_arg0)
	return CoD.perController[f90_arg0].selectingGroupEmblemForGroupCreation
end
function DoesHaveAdminRightsForGroup(f91_arg0, f91_arg1)
	local f91_local0 = IsGroupOwner(f91_arg0, f91_arg1)
	if not f91_local0 then
		f91_local0 = IsGroupAdmin(f91_arg0, f91_arg1)
	end
	return f91_local0
end
function IsGroupMember(f92_arg0, f92_arg1)
	local f92_local0 = Enum[@"groupmemberstatus"][@"hash_A04B5BF30F4F831"]
	if CoD.perController[f92_arg1].selectedGroup then
		f92_local0 = Engine[@"getselectedgroupmemberstatus"](Engine[@"getxuid64"](f92_arg1))
	end
	local f92_local1
	if f92_local0 ~= Enum[@"groupmemberstatus"][@"group_member_status_member"] and f92_local0 ~= Enum[@"groupmemberstatus"][@"group_member_status_admin"] and f92_local0 ~= Enum[@"groupmemberstatus"][@"group_member_status_owner"] then
		f92_local1 = false
	else
		f92_local1 = true
	end
	return f92_local1
end
function IsGroupAdmin(f93_arg0, f93_arg1)
	local f93_local0 = Enum[@"groupmemberstatus"][@"hash_A04B5BF30F4F831"]
	if CoD.perController[f93_arg1].selectedGroup then
		f93_local0 = Engine[@"getselectedgroupmemberstatus"](Engine[@"getxuid64"](f93_arg1))
	end
	return f93_local0 == Enum[@"groupmemberstatus"][@"group_member_status_admin"]
end
function IsGroupOwner(f94_arg0, f94_arg1)
	local f94_local0 = Enum[@"groupmemberstatus"][@"hash_A04B5BF30F4F831"]
	if CoD.perController[f94_arg1].selectedGroup then
		f94_local0 = Engine[@"getselectedgroupmemberstatus"](Engine[@"getxuid64"](f94_arg1))
	end
	return f94_local0 == Enum[@"groupmemberstatus"][@"group_member_status_owner"]
end
function HasSelectedGroup(f95_arg0, f95_arg1)
	local f95_local0 = nil
	if f95_arg0 ~= nil then
		if CoD.perController[f95_arg1].selectedGroup then
			f95_local0 = Engine[@"getmodel"](CoD.perController[f95_arg1].selectedGroup, "groupId")
		end
		if f95_local0 ~= nil then
			local f95_local1 = Engine[@"getmodelvalue"](f95_local0)
			if f95_local1 ~= nil and f95_local1 ~= 0 then
				return true
			end
		end
	end
	return false
end
function IsMemberOfAnyGroup(f96_arg0)
	local f96_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f96_arg0), "groups"), "groupCount_self"))
	local f96_local1
	if f96_local0 == nil or f96_local0 <= 0 then
		f96_local1 = false
	else
		f96_local1 = true
	end
	return f96_local1
end
function IsPlayerAGuest(f97_arg0)
	return Engine[@"isuserguest"](f97_arg0)
end
function IsPlayerAllowedToPlayOnline(f98_arg0)
	if LuaUtils.RequirePaidSubscriptionForOnlinePlay() and Engine[@"isplusauthorized"](f98_arg0) == false then
		return false
	else
		return true
	end
end
function IsOutOfBounds(f99_arg0)
	local f99_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f99_arg0), "hudItems.outOfBoundsEndTime"))
	local f99_local1 = Engine[@"currentgametime"]()
	if f99_local1 == nil then
		return false
	elseif f99_local0 == nil then
		return false
	elseif CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f99_arg0), "displayTop3Players") == 1 then
		return false
	else
		return f99_local1 < f99_local0
	end
end
function IsCACCustomClassCountDefault(f100_arg0)
	return CoD.CACUtility.GetCustomClassCount(f100_arg0) == CoD.CACUtility.defaultCustomClassCount
end
function ShowCACExtraClassBreadcrumb(f101_arg0)
	if IsClassSetsAvailableForCurrentGameMode() and not DoesPlayerHaveExtraSlotsItem(f101_arg0) then
		local f101_local0 = Engine[@"storagegetbuffer"](f101_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		if f101_local0 then
			return f101_local0.extraBools[0]:get() == 0
		end
	end
	return false
end
function IsCACItemBubbleGum(f102_arg0, f102_arg1, f102_arg2)
	local f102_local0 = f102_arg1:getModel()
	if f102_local0 then
		local f102_local1 = Engine[@"getmodel"](f102_local0, "itemIndex")
		if f102_local1 then
			local f102_local2 = Engine[@"getitemgroup"](Engine[@"getmodelvalue"](f102_local1), Enum[@"statindexoffset"][@"hash_648CD0338EE0B3AE"], CoD.PrestigeUtility.GetPermanentUnlockMode())
			if f102_local2 == "bubblegum" or f102_local2 == "bubblegum_consumable" then
				return true
			end
		end
	end
	return false
end
function IsBubbleGumType(f103_arg0, f103_arg1, f103_arg2)
	local f103_local0 = f103_arg0 and CoD.SafeGetModelValue(f103_arg0:getModel(), "itemIndex")
	if f103_local0 then
		return f103_local1[@"hash_62DC0FF35042F577"] and f103_local2 and f103_arg2 == f103_local1[@"hash_62DC0FF35042F577"]
	else
		return false
	end
end
function IsProgressionEnabledT7(f104_arg0)
	if not (not IsMultiplayer() or not IsLive() or Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"mode_game_matchmaking_manual"]) or Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"hash_27B5630CD29180CB"])) or not (not CoD.PrestigeUtility.isInPermanentUnlockMenu or not IsLive() or Engine[@"isingame"]()) or not (not IsCampaign() or CoD.perController[f104_arg0].everythingUnlocked) or IsZombies() and IsLive() and not Engine[@"isingame"]() then
		return true
	else
		return false
	end
end
function IsClassAllocationInState(f105_arg0, f105_arg1)
	return CoD.CACUtility.GetMaxAllocation() == f105_arg1
end
function IsBubbleGumPackClassSelectedBubbleGumPack(f106_arg0, f106_arg1)
	local f106_local0 = f106_arg1:getModel()
	local f106_local1 = f106_arg0:getModel()
	if f106_local0 and f106_local1 and f106_local0 == f106_local1 then
		return true
	else
		return false
	end
end
function IsCurrentClassSelectedClass(f107_arg0, f107_arg1)
	local f107_local0 = f107_arg1:getModel()
	local f107_local1 = f107_arg0:getModel()
	if f107_local0 and f107_local1 and f107_local0 == f107_local1 then
		return true
	else
		return false
	end
end
function IsCACWeaponAttributeIncrease(f108_arg0, f108_arg1, f108_arg2)
	local f108_local0 = f108_arg0:getModel()
	if f108_local0 and f108_local0[f108_arg2] then
		return WeaponAttributeCompare(f108_local0[f108_arg2]:get())
	else
		return false
	end
end
function IsCACWeaponAttributeAddedValuePositive(f109_arg0, f109_arg1, f109_arg2, f109_arg3)
	local f109_local0, f109_local1 = nil
	if f109_arg0 then
		f109_local0 = CoD.BaseUtility.GetMenuLoadoutSlot(f109_arg0)
		f109_local1 = CoD.BaseUtility.GetMenuAttachmentFilter(f109_arg0)
	end
	if not (f109_local1 ~= nil or Engine[@"currentsessionmode"]() ~= Enum[@"emodes"][@"mode_multiplayer"] or f109_local0 ~= "primary" and f109_local0 ~= "secondary") or Engine[@"currentsessionmode"]() == Enum[@"emodes"][@"mode_zombies"] and f109_local0 == "zmStartWeapon" then
		return ""
	end
	local f109_local2 = f109_arg1:getModel()
	if f109_local2 and f109_local2[f109_arg3] then
		local f109_local3 = LUI.splitString(f109_local2[f109_arg3]:get(), ",")
		if f109_local3[2] and tonumber(f109_local3[2]) >= 0 then
			return true
		end
	end
	return false
end
function AllowWeaponPrestige(f110_arg0)
	local f110_local0
	if f110_arg0 ~= Enum[@"emodes"][@"mode_warzone"] then
		f110_local0 = CoD.CACUtility.IsProgressionEnabled(f110_arg0)
		if not f110_local0 then
		else
			return f110_local0
		end
	end
	f110_local0 = Dvar[@"hash_61178C1854E9BFEC"]:get()
end
function IsClassSetsAvailableForCurrentGameMode()
	return AreCodPointsEnabled(0) and Engine[@"isclasssetsavailableforcurrentgamemode"]()
end
function AreCodPointsEnabled(f112_arg0)
	local f112_local0 = IsLive()
	if f112_local0 then
		f112_local0 = CoD.BlackMarketUtility.AreCoDPointsEnabled()
		if f112_local0 then
			f112_local0 = IsCommerceEnabledOnPC()
		end
	end
	return f112_local0
end
function HideSupplyChainPurchaseButton(f113_arg0, f113_arg1)
	local f113_local0 = CoD.SafeGetModelValue(f113_arg1:getModel(), "unlocked")
	local f113_local1
	if IsMouseOrKeyboard(f113_arg0) and IsLive() and CoD.BlackMarketUtility.AreCoDPointsEnabled() then
		f113_local1 = not IsCommerceEnabledOnPC()
	else
		f113_local1 = f113_local0 or true
	end
	return f113_local1
end
function IsCommerceEnabledOnPC()
	local f114_local0
	if CoD.isPC then
		f114_local0 = IsBooleanDvarSet(@"hash_2947261341337D60")
	else
		f114_local0 = true
	end
	return f114_local0
end
function CanPurchaseItem(f115_arg0, f115_arg1)
	local f115_local0 = tonumber(CoD.SafeGetModelValue(f115_arg1:getModel(), "price"))
	if f115_local0 then
		return f115_local0 <= Engine[@"hash_2F40679B550DCCA2"](f115_arg0, CoD.Currencies.COD_POINTS)
	else
		return false
	end
end
function HideKoreaEventButton(f116_arg0)
	local f116_local0
	if not IsKoreaProgressionSpecialEventActive(f116_arg0) then
		f116_local0 = not IsKoreaBonusXPSpecialEventActive(f116_arg0)
	else
		f116_local0 = false
	end
	return f116_local0
end
function IsKoreaProgressionSpecialEventActive(f117_arg0)
	local f117_local0 = CoD.isPC
	if f117_local0 then
		f117_local0 = Dvar[@"hash_4574F0B1608D9EA8"]
		if f117_local0 then
			f117_local0 = Dvar[@"hash_4574F0B1608D9EA8"]:exists()
			if f117_local0 then
				f117_local0 = Dvar[@"hash_4574F0B1608D9EA8"]:get()
				if f117_local0 then
					f117_local0 = CoD.PCKoreaUtility.IsInKorea()
					if f117_local0 then
						f117_local0 = Engine[@"hash_2343E1D78ABC6BF1"]()
					end
				end
			end
		end
	end
	return f117_local0
end
function IsKoreaBonusXPSpecialEventActive(f118_arg0)
	return false
end
function IsPC()
	return CoD.isPC
end
function IsOrbis()
	return CoD.isPS4
end
function IsDurango()
	return CoD.isDurango
end
function AmICarryingEnemyFlag(f122_arg0)
	local f122_local0 = Engine[@"getplayernameforclientnum"](f122_arg0, Engine[@"getpredictedclientnum"](f122_arg0))
	if f122_local0 == "" then
		return false
	elseif CoD.IsShoutcaster(f122_arg0) then
		if f122_local0 == Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f122_arg0), "CTF.enemyFlagCarrier")) then
			return true
		else
			return f122_local0 == Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f122_arg0), "CTF.friendlyFlagCarrier"))
		end
	end
	local f122_local1 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f122_arg0), "CTF.enemyFlagCarrier")
	local f122_local2
	if f122_local1 == nil or f122_local0 ~= Engine[@"getmodelvalue"](f122_local1) then
		f122_local2 = false
	else
		f122_local2 = true
	end
	return f122_local2
end
function AmICarryingBomb(f123_arg0)
	if CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f123_arg0), "Demolition.defending") == false then
		return true
	elseif CoD.SafeGetModelValue(Engine[@"getmodelforcontroller"](f123_arg0), "SearchAndDestroy.defending") == false and Engine[@"getgametypesetting"](@"multibomb") == 1 and not Engine[@"isvisibilitybitset"](f123_arg0, Enum[@"uivisibilitybit"][@"bit_bomb_timer_a"]) and not Engine[@"isvisibilitybitset"](f123_arg0, Enum[@"uivisibilitybit"][@"bit_bomb_timer_b"]) then
		return true
	else
		return CoD.ModelUtility.IsModelValueEqualTo(f123_arg0, "hudItems.SDBombClient", Engine[@"getpredictedclientnum"](f123_arg0))
	end
end
function HasNetworkConnection()
	return Engine[@"checknetconnection"]() == true
end
function IsPlayerSignedInToLive(f125_arg0)
	return Engine[@"issignedintolive"](f125_arg0) == true
end
function IsPlayerConnectedToCodServers(f126_arg0)
	return Engine[@"isdemonwarefetchingdone"](f126_arg0) == true
end
function LobbyConnectedToDedicatedHost()
	return Engine[@"lobbyconnectedtodedicatedhost"]()
end
function IsDoubleXP(f128_arg0)
	if not IsPublicOrLeagueGame() then
		return false
	else
		local f128_local0 = LobbyData.GetCurrentMenuTarget()
		if f128_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
			return false
		elseif CoD.HUDUtility.IsGameTypeEqualToString("ztutorial") and not InFrontend() then
			return false
		elseif CoD.BaseUtility.IsDvarEnabled("ui_fakeDoubleXP") then
			return true
		else
			local f128_local1 = Engine[@"getxpscale"](f128_arg0)
			return f128_local1 and f128_local1 >= 2
		end
	end
end
function IsDoubleWeaponXP(f129_arg0)
	if not IsPublicOrLeagueGame() then
		local f129_local0 = LobbyData.GetCurrentMenuTarget()
		if not f129_local0 or f129_local0[@"kicker"] ~= @"hash_69818A6A90DAF973" then
			return false
		end
	end
	local f129_local0 = LobbyData.GetCurrentMenuTarget()
	if f129_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
		return false
	elseif CoD.HUDUtility.IsGameTypeEqualToString("ztutorial") and not InFrontend() then
		return false
	elseif CoD.BaseUtility.IsDvarEnabled("ui_fakeDoubleGunXP") then
		return true
	end
	local f129_local1 = Engine[@"getgunxpscale"](f129_arg0)
	return f129_local1 and f129_local1 >= 2
end
function IsTierBoostActive(f130_arg0)
	if not IsPublicOnlineGame() or IsZombies() then
		return false
	else
		local f130_local0 = LobbyData.GetCurrentMenuTarget()
		if f130_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
			return false
		elseif CoD.BaseUtility.IsDvarEnabled("ui_fakeTierBoost") then
			return true
		else
			local f130_local1 = CoD.StartMenuUtility.GetSessionModeFromLobby()
			if Engine[@"hash_5F4F47F17B3BDCB3"](f130_arg0, Engine[@"hash_2ACFE452C407B25B"](f130_local1), f130_local1, Engine[@"getplaylistid"]()) then
				return true
			else
				local f130_local2 = Dvar[@"scr_credit_scale"]:get()
				if not f130_local2 then
					return false
				else
					return tonumber(f130_local2) >= 2
				end
			end
		end
	end
end
function IsDoubleLootXP(f131_arg0)
	if not IsPublicOrLeagueGame() then
		return false
	else
		local f131_local0 = Dvar[@"lootxp_multiplier"]:get()
		if not f131_local0 then
			return false
		else
			return tonumber(f131_local0) >= 2
		end
	end
end
function IsLobbyLocked()
	return LuaUtils.LobbyIsLocked()
end
function IsSelfClient(f133_arg0, f133_arg1)
	return CoD.SafeGetModelValue(f133_arg1:getModel(), "clientNum") == CoD.AARUtility.GetInGameClientNum(f133_arg0)
end
function IsOnlineGame()
	return CoD.isOnlineGame()
end
function IsPublicOnlineGame()
	return CoD.isPublicOnlineGame()
end
function IsCPMapVoteHidden(f136_arg0)
	if not IsCampaign() then
		return false
	else
		local f136_local0 = LobbyData.GetLobbyNav()
		if f136_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY) or f136_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_PUBLIC) or f136_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) or f136_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_CP) then
			return false
		else
			return not Engine[@"iscpinprogress"]()
		end
	end
end
function IsMainModeInvalid()
	if Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyMainMode")) == Enum[@"lobbymainmode"][@"lobby_mainmode_invalid"] then
		return true
	else
		return false
	end
end
function IsLive()
	if Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNetworkMode")) == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"] then
		return true
	else
		return false
	end
end
function IsLAN()
	if Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNetworkMode")) == Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"] then
		return true
	else
		return false
	end
end
function IsLocal()
	if Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNetworkMode")) == Enum[@"lobbynetworkmode"][@"lobby_networkmode_local"] then
		return true
	else
		return false
	end
end
function IsCustomLobby()
	local f141_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav"))
	local f141_local1
	if f141_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM) and f141_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) and f141_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) and f141_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM) and f141_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_WZ_CUSTOM) then
		f141_local1 = false
	else
		f141_local1 = true
	end
	return f141_local1
end
function IsCustomMPLobby()
	local f142_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav"))
	local f142_local1
	if f142_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) and f142_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) then
		f142_local1 = false
	else
		f142_local1 = true
	end
	return f142_local1
end
function IsPublicWZLobby()
	return IsLobbyMode(Enum[@"lobbymode"][@"lobby_mode_public"]) and IsWarzone()
end
function IsMPTrainingLobby()
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav")) == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING)
end
function IsLobbyMode(f145_arg0)
	local f145_local0 = LobbyData.GetCurrentMenuTarget()
	return f145_local0[@"lobbymode"] == f145_arg0
end
function IsLobbyTypeActive(f146_arg0)
	return Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], f146_arg0)
end
function IsGameLobbyActive()
	return Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
end
function IsLobbyNetworkModeLAN()
	return Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_lan"]
end
function IsLobbyNetworkModeLive()
	return Engine[@"getlobbynetworkmode"]() == Enum[@"lobbynetworkmode"][@"lobby_networkmode_live"]
end
function IsLobbyHost()
	if Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]) then
		return Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"])
	elseif Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"]) then
		return Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"])
	else
		return false
	end
end
function IsLobbyHostOfLobbyType(f151_arg0)
	return Engine[@"islobbyhost"](f151_arg0)
end
function IsLobbyHostOfCurrentMenu()
	local f152_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav"))
	if not f152_local0 then
		return false
	else
		local f152_local1 = LobbyData.GetLobbyMenuByID(f152_local0)
		if not f152_local1 then
			return false
		elseif f152_local1[@"lobbytype"] == Enum[@"lobbytype"][@"lobby_type_invalid"] then
			return false
		elseif LobbyConnectedToDedicatedHost() then
			return false
		else
			return Engine[@"islobbyhost"](f152_local1[@"lobbytype"])
		end
	end
end
function IsLobbyPrivateHost()
	return Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"])
end
function IsPrivateLobbyFull()
	local f154_local0 = Engine[@"createmodel"](Engine[@"getmodel"](Engine[@"getglobalmodel"](), "lobbyRoot"), "privateClient")
	return (Engine[@"getmodelvalue"](Engine[@"createmodel"](f154_local0, "max")) or 0) <= (Engine[@"getmodelvalue"](Engine[@"createmodel"](f154_local0, "count")) or 0)
end
function ShouldShowPlaylistName()
	local f155_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav"))
	local f155_local1
	if f155_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_PUBLIC) and f155_local0 ~= LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC) then
		f155_local1 = false
	else
		f155_local1 = true
	end
	return f155_local1
end
function LobbyHasMatchStartButton()
	local f156_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav"))
	local f156_local1 = {}
	local f156_local2 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_STORY)
	local f156_local3 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_CP_CUSTOM)
	local f156_local4 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM)
	local f156_local5 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM)
	local f156_local6 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_ZM_CUSTOM)
	local f156_local7 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_CP)
	local f156_local8 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_MP)
	local f156_local9 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_ZM)
	local f156_local10 = LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_MP_ARENA)
	return LuaUtils.FindItemInArray(f156_local2, f156_local0)
end
function IsPartyLeader(f157_arg0)
	local f157_local0 = nil
	if Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]) then
		f157_local0 = Engine[@"getmodel"](DataSources.LobbyRoot.getModel(f157_arg0), "gameClient.isHost")
	else
		f157_local0 = Engine[@"getmodel"](DataSources.LobbyRoot.getModel(f157_arg0), "privateClient.isHost")
	end
	local f157_local1 = nil
	if f157_local0 ~= nil then
		f157_local1 = Engine[@"getmodelvalue"](f157_local0)
	else
		f157_local1 = 1
	end
	return f157_local1 and f157_local1 ~= 0
end
function IsAddControllerTextItem(f158_arg0)
	return f158_arg0.isAddControllerTextItem
end
function IsPlayerCountItem(f159_arg0)
	return f159_arg0.isPlayerCountItem
end
function PregameActive()
	return Engine[@"getlobbypregamestate"]() ~= Enum[@"lobbypregamestate"][@"lobby_pregame_state_idle"]
end
function ItemRestrictionVoteActive()
	return Engine[@"getlobbypregamestate"]() == Enum[@"lobbypregamestate"][@"lobby_pregame_state_item_vote"]
end
function ItemIsBanned(f162_arg0, f162_arg1, f162_arg2)
	if CoD.CACUtility.GetItemInfoFromElement(f162_arg2, f162_arg1) then
	else
	end
	return false
end
function IsPlayerDead(f163_arg0, f163_arg1)
	local f163_local0 = f163_arg0:getModel(f163_arg1, "clientNum")
	if f163_local0 then
		return Engine[@"isplayerdead"](f163_arg1, Engine[@"getmodelvalue"](f163_local0))
	else
		return false
	end
end
function IsControllerPlayerDead(f164_arg0)
	return Engine[@"isplayerdead"](f164_arg0, Engine[@"getclientnum"](f164_arg0))
end
function IsPlayerInLastStand(f165_arg0, f165_arg1)
	local f165_local0 = f165_arg0:getModel(f165_arg1, "clientNum")
	if f165_local0 then
		return Engine[@"isplayerinlaststand"](f165_arg1, Engine[@"getmodelvalue"](f165_local0))
	else
		return false
	end
end
function IsControllerPlayerInLastStand(f166_arg0)
	return Engine[@"isplayerinlaststand"](f166_arg0, Engine[@"getclientnum"](f166_arg0))
end
function ClientIsLeader(f167_arg0, f167_arg1)
	local f167_local0 = f167_arg0:getModel()
	if f167_local0 == nil then
		return false
	else
		local f167_local1 = f167_local0:create("clientNum")
		f167_local1 = f167_local1:get()
		if Engine[@"getmodelforclient"](f167_local1) == nil then
			return false
		else
			local f167_local2 = CoD.LobbyUtility.GetClient(f167_local1)
			if f167_local2 ~= nil then
				return f167_local2.isMemberLeader == 1
			else
				return false
			end
		end
	end
end
function SelfCharacterIndexIsValid(f168_arg0, f168_arg1, f168_arg2)
	local f168_local0 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f168_arg2))
	f168_local0 = f168_local0:create("characterIndex")
	f168_local0 = f168_local0:get()
	if f168_local0 == nil or f168_local0 < 0 then
		return false
	end
	for f168_local4, f168_local5 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Engine[@"currentsessionmode"]())) do
		if f168_local5.bodyIndex == f168_local0 then
			return true
		end
	end
	return false
end
function CharacterIndexIsValid(f169_arg0, f169_arg1, f169_arg2)
	local f169_local0 = f169_arg1:getModel()
	if f169_local0 == nil then
		return false
	end
	local f169_local1 = f169_local0:create("clientNum")
	f169_local1 = f169_local1:get()
	local f169_local2 = f169_local1 and Engine[@"getmodelforclient"](f169_local1)
	if f169_local2 == nil then
		return false
	end
	local f169_local3 = f169_local2:create("characterIndex")
	f169_local3 = f169_local3:get()
	if f169_local3 == nil or f169_local3 < 0 then
		return false
	end
	for f169_local7, f169_local8 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Engine[@"currentsessionmode"]())) do
		if f169_local8.bodyIndex == f169_local3 then
			return true
		end
	end
end
function SelectedCharacterHasStoryMoment(f170_arg0, f170_arg1, f170_arg2)
	if f170_arg1:getModel() == nil then
		return false
	else
		local f170_local0 = Engine[@"getmodelforcontroller"](f170_arg2)
		f170_local0 = f170_local0:create("PositionDraft.focusedCharacterIndex")
		f170_local0 = f170_local0:get()
		if f170_local0 == nil or f170_local0 <= 0 then
			return false
		else
			local f170_local1 = CoD.TeamUtility.GetTeam(f170_arg2)
			local f170_local2 = Engine[@"getgdtcampaignmapinfo"](Engine[@"lobbygetmap"]())
			if f170_local2 then
				local f170_local3 = f170_local2[@"hash_6901B557917C99B" .. f170_local1 .. "_" .. f170_local0]
				return f170_local3 and f170_local3 == 1
			else
				return false
			end
		end
	end
end
function CharacterHasStoryMoment(f171_arg0, f171_arg1, f171_arg2)
	local f171_local0 = f171_arg1:getModel()
	if f171_local0 == nil then
		return false
	else
		local f171_local1 = f171_local0:create("characterIndex")
		f171_local1 = f171_local1:get()
		if f171_local1 == nil or f171_local1 < 0 then
			return false
		else
			local f171_local2 = CoD.TeamUtility.GetTeam(f171_arg2)
			local f171_local3 = Engine[@"getgdtcampaignmapinfo"](Engine[@"lobbygetmap"]())
			if f171_local3 then
				local f171_local4 = f171_local3[@"hash_6901B557917C99B" .. f171_local2 .. "_" .. f171_local1]
				return f171_local4 and f171_local4 == 1
			else
				return false
			end
		end
	end
end
function PlayerReadiedUp(f172_arg0)
	local f172_local0 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f172_arg0))
	if f172_local0 == nil then
		return false
	else
		local f172_local1 = f172_local0:create("ready")
		f172_local1 = f172_local1:get()
		if f172_local1 == nil then
			return false
		else
			return f172_local1 ~= 0
		end
	end
end
function TeamIsReady(f173_arg0)
	local f173_local0 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f173_arg0))
	f173_local0 = f173_local0:create("team")
	f173_local0 = f173_local0:get()
	local f173_local1 = Engine[@"getmodelforcontroller"](f173_arg0)
	f173_local1 = f173_local1:create("Clients.clientCount")
	f173_local1 = f173_local1:get()
	for f173_local2 = 0, f173_local1 - 1, 1 do
		local f173_local5 = Engine[@"getmodelforclient"](f173_local2)
		local f173_local6 = f173_local5:create("team")
		f173_local6 = f173_local6:get()
		if f173_local0 == f173_local6 and CoD.TeamUtility.IsValidPlayerTeam(f173_local6) then
			local f173_local7 = f173_local5:create("ready")
			if f173_local7:get() ~= 1 then
				return false
			end
		end
	end
	return true
end
function EnemyTeamIsReady(f174_arg0)
	local f174_local0 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f174_arg0))
	f174_local0 = f174_local0:create("team")
	f174_local0 = f174_local0:get()
	local f174_local1 = Engine[@"getmodelforcontroller"](f174_arg0)
	f174_local1 = f174_local1:create("Clients.clientCount")
	f174_local1 = f174_local1:get()
	for f174_local2 = 0, f174_local1 - 1, 1 do
		local f174_local5 = Engine[@"getmodelforclient"](f174_local2)
		local f174_local6 = f174_local5:create("team")
		f174_local6 = f174_local6:get()
		if f174_local0 ~= f174_local6 and CoD.TeamUtility.IsValidPlayerTeam(f174_local6) then
			local f174_local7 = f174_local5:create("ready")
			if f174_local7:get() ~= 1 then
				return false
			end
		end
	end
	return true
end
function IsSplitscreenAndInGame(f175_arg0)
	return Engine[@"issplitscreen"]()
end
function HasPerksInAnySlot(f176_arg0)
	local f176_local0 = Engine[@"getmodelforcontroller"](f176_arg0)
	local f176_local1 = Engine[@"getmodelvalue"](Engine[@"createmodel"](f176_local0, "perks.perk0_count"))
	if f176_local1 ~= nil and f176_local1 > 0 then
		return true
	else
		f176_local1 = Engine[@"getmodelvalue"](Engine[@"createmodel"](f176_local0, "perks.perk1_count"))
		if f176_local1 ~= nil and f176_local1 > 0 then
			return true
		else
			f176_local1 = Engine[@"getmodelvalue"](Engine[@"createmodel"](f176_local0, "perks.perk2_count"))
			if f176_local1 ~= nil and f176_local1 > 0 then
				return true
			else
				return false
			end
		end
	end
end
function HasPerksInSlot0(f177_arg0)
	local f177_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f177_arg0), "perks.perk0_count"))
	local f177_local1
	if f177_local0 == nil or f177_local0 <= 0 then
		f177_local1 = false
	else
		f177_local1 = true
	end
	return f177_local1
end
function HasOnePerkInSlot0(f178_arg0)
	local f178_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f178_arg0), "perks.perk0_count"))
	local f178_local1
	if f178_local0 == nil or f178_local0 ~= 1 then
		f178_local1 = false
	else
		f178_local1 = true
	end
	return f178_local1
end
function HasTwoPerksInSlot0(f179_arg0)
	local f179_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f179_arg0), "perks.perk0_count"))
	local f179_local1
	if f179_local0 == nil or f179_local0 ~= 2 then
		f179_local1 = false
	else
		f179_local1 = true
	end
	return f179_local1
end
function HasPerksInSlot1(f180_arg0)
	local f180_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f180_arg0), "perks.perk1_count"))
	local f180_local1
	if f180_local0 == nil or f180_local0 <= 0 then
		f180_local1 = false
	else
		f180_local1 = true
	end
	return f180_local1
end
function HasOnePerkInSlot1(f181_arg0)
	local f181_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f181_arg0), "perks.perk1_count"))
	local f181_local1
	if f181_local0 == nil or f181_local0 ~= 1 then
		f181_local1 = false
	else
		f181_local1 = true
	end
	return f181_local1
end
function HasTwoPerksInSlot1(f182_arg0)
	local f182_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f182_arg0), "perks.perk1_count"))
	local f182_local1
	if f182_local0 == nil or f182_local0 ~= 2 then
		f182_local1 = false
	else
		f182_local1 = true
	end
	return f182_local1
end
function HasPerksInSlot2(f183_arg0)
	local f183_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f183_arg0), "perks.perk2_count"))
	local f183_local1
	if f183_local0 == nil or f183_local0 <= 0 then
		f183_local1 = false
	else
		f183_local1 = true
	end
	return f183_local1
end
function HasOnePerkInSlot2(f184_arg0)
	local f184_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f184_arg0), "perks.perk2_count"))
	local f184_local1
	if f184_local0 == nil or f184_local0 ~= 1 then
		f184_local1 = false
	else
		f184_local1 = true
	end
	return f184_local1
end
function HasTwoPerksInSlot2(f185_arg0)
	local f185_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f185_arg0), "perks.perk2_count"))
	local f185_local1
	if f185_local0 == nil or f185_local0 ~= 2 then
		f185_local1 = false
	else
		f185_local1 = true
	end
	return f185_local1
end
function IsGameTypeWarzone()
	local f186_local0 = Dvar[@"g_gametype"]:get()
	local f186_local1
	if f186_local0 == nil or f186_local0 ~= "warzone_solo" and f186_local0 ~= "warzone_duo" and f186_local0 ~= "warzone_quad" and f186_local0 ~= "warzone_dbno" then
		f186_local1 = false
	else
		f186_local1 = true
	end
	return f186_local1
end
function IsGameTypeCombatTraining()
	local f187_local0 = Dvar[@"g_gametype"]:get()
	local f187_local1
	if f187_local0 == nil or f187_local0 ~= "ct_ruin" and f187_local0 ~= "ct_recon" and f187_local0 ~= "ct_nomad" and f187_local0 ~= "ct_firebreak" and f187_local0 ~= "ct_crash" and f187_local0 ~= "ct_seraph" and f187_local0 ~= "ct_battery" and f187_local0 ~= "ct_prophet" and f187_local0 ~= "ct_torque" and f187_local0 ~= "ct_ajax" then
		f187_local1 = false
	else
		f187_local1 = true
	end
	return f187_local1
end
function IsGametypeNewStyle()
	return LuaUtils.FindItemInArray({
		"war",
		"control",
		"infil",
		"payload",
	}, Engine[@"hash_36F8027A8BC75673"]())
end
function IsTeamBasedGame(f189_arg0)
	if IsInGame() then
		return CoDShared.IsGametypeTeamBased()
	else
		return CoDShared.IsGametypeTeamBased(Engine[@"hash_36F8027A8BC75673"]())
	end
end
function IsTeamBasedGameMode(f190_arg0)
	local f190_local0 = Engine[@"getglobalmodel"]()
	return CoD.GameTypeUtility.GetGameTypeValue(f190_local0["MapVote.mapVoteGameModeNext"].get(f190_local0["MapVote.mapVoteGameModeNext"]), "isTeamBased", false)
end
function IsMaxTeamPlayersEqualTo(f191_arg0)
	return CoDShared.GetGametypeMaxTeamPlayers() == f191_arg0
end
function IsPublicOrLeagueGame(f192_arg0)
	local f192_local0 = Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"mode_game_matchmaking_playlist"])
	if not f192_local0 then
		f192_local0 = Engine[@"gamemodeismode"](Enum[@"egamemodes"][@"mode_game_league"])
	end
	return f192_local0
end
function IsBombBasedGameMode()
	local f193_local0 = Dvar[@"g_gametype"]:get()
	local f193_local1
	if f193_local0 == nil or f193_local0 ~= "sd" and f193_local0 ~= "sr" and f193_local0 ~= "dem" then
		f193_local1 = false
	else
		f193_local1 = true
	end
	return f193_local1
end
function IsGametypeSettingsValue(f194_arg0, f194_arg1)
	return Engine[@"getgametypesetting"](f194_arg0) == f194_arg1
end
function PositionDraftMaxUniqueRolesEquals(f195_arg0)
	local f195_local0 = Engine[@"getgametypesettings"]()
	for f195_local4, f195_local5 in pairs(CoD.PlayerRoleUtility.GetHeroList(Engine[@"currentsessionmode"]())) do
		if f195_local0.maxUniqueRolesPerTeam[f195_local5.bodyIndex]:get() ~= f195_arg0 then
			return false
		end
	end
	return true
end
function CustomClassesEnabled()
	local f196_local0 = LobbyData.GetCurrentMenuTarget()
	if f196_local0[@"id"] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
		return false
	else
		return Engine[@"getgametypesetting"](@"disablecac") == 0
	end
end
function IsGametypeTeambased()
	return CoDShared.IsGametypeTeamBased()
end
function HideHudScoreForCurrentGametype()
	return CoDShared.IsGametypeHidingHudScore()
end
function IsTeamStageWin(f199_arg0)
	local f199_local0 = CoD.TeamUtility.GetTeamID(f199_arg0)
	local f199_local1 = Engine[@"getglobalmodel"]()
	return f199_local0 == f199_local1.StageResults.winningTeam:get()
end
function ShouldBootUpHUD(f200_arg0, f200_arg1)
	if IsInPrematchPeriod(f200_arg0) then
		return false
	elseif not Engine[@"isvisibilitybitset"](0, Enum[@"uivisibilitybit"][@"bit_hud_visible"]) then
		return false
	else
		return not f200_arg1.hasBooted
	end
end
function IsLowAspectRatio(f201_arg0)
	local f201_local0, f201_local1, f201_local2 = Engine[@"hash_6913E41040C17FD"](f201_arg0)
	return f201_local2 < 1.78 - 0
end
function DamageFeedbackInStage(f202_arg0, f202_arg1)
	local f202_local0 = CoD.SafeGetModelValue(f202_arg0:getModel(), "damageFeedbackState")
	if f202_local0 then
		return f202_local0 & Enum[@"damagefeedbackstate"][@"damage_feedback_state_mask"] == f202_arg1
	else
		return false
	end
end
function DamageFeedbackFlagSet(f203_arg0, f203_arg1)
	local f203_local0 = CoD.SafeGetModelValue(f203_arg0:getModel(), "damageFeedbackState")
	if f203_local0 then
		return CoD.BitUtility.IsBitSet(f203_local0 >> Enum[@"damagefeedbackstate"][@"damage_feedback_state_next_unused_bit"], f203_arg1)
	else
		return false
	end
end
function IsWeaponClipGreaterThanOrEqualTo(f204_arg0, f204_arg1)
	local f204_local0 = Engine[@"getmodelforcontroller"](f204_arg0)
	local f204_local1 = DataSources.CurrentWeapon.getModel(f204_arg0)
	f204_local1 = f204_local1.clipMaxAmmo
	if f204_local1 == nil then
		return false
	else
		local f204_local2 = Engine[@"getmodelvalue"](f204_local1)
		if f204_local2 == nil then
			return false
		else
			return f204_arg1 <= f204_local2
		end
	end
end
function WeaponUsesAmmo(f205_arg0)
	return CoD.WeaponUtility.CurrentWeaponUsesAmmo(f205_arg0)
end
function IsSegmentedReloadWeapon(f206_arg0)
	return CoD.WeaponUtility.CurrentWeaponIsSegmentedReload(f206_arg0)
end
function WeaponHasAmmo(f207_arg0)
	local f207_local0 = Engine[@"getmodelforcontroller"](f207_arg0)
	local f207_local1 = DataSources.CurrentWeapon.getModel(f207_arg0)
	return f207_local1.weaponHasAmmo:get()
end
function IsInPrematchPeriod(f208_arg0)
	return CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f208_arg0, "isInPrematchPeriod", 1)
end
function IsLowAmmoClip(f209_arg0)
	return f209_local1.ammoLow and f209_local1.ammoLow:get()
end
function IsLowAmmoDWClip(f210_arg0)
	return f210_local1.ammoDWLow and f210_local1.ammoDWLow:get()
end
function IsSignatureWeaponInUse(f211_arg0)
	local f211_local0 = DataSources.CurrentWeapon.getModel(f211_arg0)
	f211_local0 = f211_local0.equippedWeaponReference:get()
	local f211_local1
	if f211_local0 ~= nil then
		f211_local1 = Engine[@"weaponissignatureweapon"](f211_local0)
	else
		f211_local1 = false
	end
	return f211_local1
end
function IsSpecificGadgetInUse(f212_arg0, f212_arg1, f212_arg2)
	local f212_local0 = f212_arg1:getModel()
	local f212_local1
	if CoD.SafeGetModelValue(f212_local0, "state") ~= Enum[@"weapongadgetstates"][@"player_ability_state_inuse"] or CoD.SafeGetModelValue(f212_local0, "id") ~= f212_arg2 then
		f212_local1 = false
	else
		f212_local1 = true
	end
	return f212_local1
end
function IsCurrentWeaponReference(f213_arg0, f213_arg1)
	local f213_local0 = f213_arg1 .. "_" .. string.lower(CoD.gameMode)
	local f213_local1 = Engine[@"getmodel"](DataSources.CurrentWeapon.getModel(f213_arg0), "equippedWeaponReference")
	local f213_local2 = f213_local1 and Engine[@"getmodelvalue"](f213_local1)
	local f213_local3
	if f213_local2 == nil or f213_local2 ~= f213_local0 then
		f213_local3 = false
	else
		f213_local3 = true
	end
	return f213_local3
end
function IsCurrentViewmodelWeaponName(f214_arg0, f214_arg1)
	local f214_local0 = f214_arg1 .. "_" .. string.lower(CoD.gameMode)
	local f214_local1 = Engine[@"getmodel"](DataSources.CurrentWeapon.getModel(f214_arg0), "viewmodelWeaponName")
	local f214_local2 = f214_local1 and Engine[@"getmodelvalue"](f214_local1)
	local f214_local3
	if f214_local2 == nil or f214_local2 ~= f214_local0 then
		f214_local3 = false
	else
		f214_local3 = true
	end
	return f214_local3
end
function IsSecondaryOffhandGadgetPowerBased(f215_arg0)
	return Engine[@"ispowerbasedgadget"](f215_arg0, Enum[@"playerrolebuttonoverridetypes"][@"prbo_smoke"])
end
function IsUsingSprintDecay()
	return Engine[@"usingsprintdecay"]() and IsMultiplayer()
end
function PulseNoLethal(f217_arg0)
	local f217_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f217_arg0), "hudItems.pulseNoLethal"))
	if f217_local0 == nil or f217_local0 <= 0 then
		return false
	else
		return true
	end
end
function PulseNoTactical(f218_arg0)
	local f218_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f218_arg0), "hudItems.pulseNoTactical"))
	if f218_local0 == nil or f218_local0 <= 0 then
		return false
	else
		return true
	end
end
function PulseNoAmmo(f219_arg0)
	local f219_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f219_arg0), "hudItems.pulseNoAmmo"))
	local f219_local1
	if f219_local0 == nil or f219_local0 <= 0 then
		f219_local1 = false
	else
		f219_local1 = true
	end
	return f219_local1
end
function IsArmorOverlayActive(f220_arg0)
	local f220_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f220_arg0), "hudItems.armorOverlay"))
	local f220_local1 = f220_local0
	local f220_local2
	if f220_local0 == "" or f220_local0 == "blacktransparent" then
		f220_local2 = false
	else
		f220_local2 = f220_local1 and true
	end
	return f220_local2
end
function IsAtLeastHalfGameScore(f221_arg0, f221_arg1)
	local f221_local0 = Engine[@"getmodelforcontroller"](f221_arg0)
	local f221_local1 = f221_local0 and Engine[@"getmodel"](f221_local0, "gameScore.scoreLimit")
	if f221_local1 then
		f221_local1 = Engine[@"getmodelvalue"](f221_local1)
	end
	local f221_local2 = f221_local0 and Engine[@"getmodel"](f221_local0, f221_arg1)
	local f221_local3 = f221_local2 and Engine[@"getmodelvalue"](f221_local2)
	local f221_local4
	if f221_local1 == nil or f221_local3 == nil or f221_local1 > f221_local3 * 2 then
		f221_local4 = false
	else
		f221_local4 = true
	end
	return f221_local4
end
function IsCursorHintActive(f222_arg0)
	local f222_local0 = Engine[@"getmodelforcontroller"](f222_arg0)
	if not f222_local0.hudItems.showCursorHint:get() then
		return false
	elseif f222_local0.hudItems.inventory.open:get() then
		return false
	else
		return true
	end
end
function IsGameTypeDOA()
	return CoDShared.IsGameTypeDOA()
end
function HideScoreMeterDueToGameType()
	local f224_local0 = Dvar[@"g_gametype"]:get()
	local f224_local1
	if f224_local0 == nil or f224_local0 ~= "ctf" and f224_local0 ~= "dem" and f224_local0 ~= "sd" then
		f224_local1 = false
	else
		f224_local1 = true
	end
	return f224_local1
end
function IsMapName(f225_arg0)
	return Engine[@"getcurrentmap"]() == f225_arg0
end
function IsSimulateCT()
	return LUI.DEV and Engine[@"getdvarbool"]("ui_simulateCT")
end
function IsZombieRoundOnesDigitEqualTo(f227_arg0, f227_arg1, f227_arg2)
	local f227_local0 = f227_arg0:getModel()
	if f227_local0 then
		f227_local0 = Engine[@"getmodel"](f227_local0, "roundsPlayed")
	end
	local f227_local1 = f227_local0 and Engine[@"getmodelvalue"](f227_local0)
	if f227_local1 == nil then
		return false
	else
		return (f227_local1 - 1) % 10 == f227_arg2
	end
end
function IsZombieRoundTensDigitEqualTo(f228_arg0, f228_arg1, f228_arg2)
	local f228_local0 = f228_arg0:getModel()
	if f228_local0 then
		f228_local0 = Engine[@"getmodel"](f228_local0, "roundsPlayed")
	end
	local f228_local1 = f228_local0 and Engine[@"getmodelvalue"](f228_local0)
	if f228_local1 == nil then
		return false
	else
		f228_local1 = f228_local1 - 1
		return (f228_local1 % 100 - f228_local1 % 10) / 10 == f228_arg2
	end
end
function IsZombieRoundHundredsDigitEqualTo(f229_arg0, f229_arg1, f229_arg2)
	local f229_local0 = f229_arg0:getModel()
	if f229_local0 then
		f229_local0 = Engine[@"getmodel"](f229_local0, "roundsPlayed")
	end
	local f229_local1 = f229_local0 and Engine[@"getmodelvalue"](f229_local0)
	if f229_local1 == nil then
		return false
	else
		f229_local1 = f229_local1 - 1
		return (f229_local1 % 1000 - f229_local1 % 100) / 100 == f229_arg2
	end
end
function IsParentListInFocus(f230_arg0)
	if f230_arg0.gridInfoTable then
		local f230_local0 = f230_arg0.gridInfoTable.parentGrid
		if f230_local0 and f230_local0.hasListFocus then
			return true
		end
	end
	return false
end
function IsDisabled(f231_arg0, f231_arg1)
	local f231_local0 = f231_arg0:getModel(f231_arg1, "disabledFunction")
	if f231_local0 then
		local f231_local1 = Engine[@"getmodelvalue"](f231_local0)
		if f231_local1 then
			f231_arg0.disabled = f231_local1()
			return f231_local1()
		end
	end
	local f231_local1 = f231_arg0:getModel(f231_arg1, "disabled")
	if f231_local1 then
		f231_arg0.disabled = Engine[@"getmodelvalue"](f231_local1)
	end
	return f231_arg0.disabled
end
function IsEnabledByGametypeSetting(f232_arg0, f232_arg1)
	if f232_arg0.enabledWithGametypeSetting ~= nil then
		return Engine[@"getgametypesetting"](f232_arg0.enabledWithGametypeSetting) == 1
	else
		return true
	end
end
function ConnectionMeter_isEnabled(f233_arg0, f233_arg1)
	if not IsBooleanDvarSet("ui_enableConnectionMetricGraphs") then
		return false
	elseif Engine[@"profileint"](f233_arg1, "showConnectionMeter") ~= 1 then
		return false
	else
		return true
	end
end
function IsSelected(f234_arg0, f234_arg1)
	local f234_local0 = f234_arg0:getModel(f234_arg1, "selected")
	if f234_local0 then
		f234_arg0.selected = Engine[@"getmodelvalue"](f234_local0)
	end
	return f234_arg0.selected
end
function IsFirstItem(f235_arg0)
	return f235_arg0.isFirstItem and f235_arg0:isFirstItem()
end
function IsLastItem(f236_arg0)
	return f236_arg0.isLastItem and f236_arg0:isLastItem()
end
function ShouldDisplayButton(f237_arg0, f237_arg1)
	local f237_local0 = f237_arg0:getModel(f237_arg1, "tabIcon")
	if f237_local0 then
		return Engine[@"getmodelvalue"](f237_local0) ~= ""
	else
		return false
	end
end
function IsHeroLocked(f238_arg0, f238_arg1)
	if CoD.SafeGetModelValue(f238_arg0:getModel(), "disabled") then
		return true
	else
		return false
	end
end
function HasHintText(f239_arg0)
	local f239_local0 = f239_arg0:getModel()
	if f239_local0 and f239_local0.hintText and f239_local0.hintText:get() and f239_local0.hintText:get() ~= "" then
		return true
	else
		return false
	end
end
function Gunsmith_IsEnabled(f240_arg0, f240_arg1)
	if IsPlayerAGuest(f240_arg1) then
		return false
	else
		return false
	end
end
function Gunsmith_IsCurrentVariantChanged(f241_arg0)
	return false
end
function IsGridOn(f242_arg0, f242_arg1)
	return Engine[@"getprofilevarint"](f242_arg0, f242_arg1) ~= 0
end
function Paintjobs_IsOccupied(f243_arg0, f243_arg1)
	local f243_local0 = f243_arg0:getModel()
	if f243_local0 and f243_local0.paintjobSlot and CoD.CraftUtility.Paintjobs.IsPaintjobIndexOccupied(f243_local0.paintjobSlot:get()) then
		return true
	else
		return false
	end
end
function Paintjobs_DisableGroupsFeature()
	return Dvar[@"ui_emblemdisablegroups"].exists() and Dvar[@"ui_emblemdisablegroups"]:get()
end
function IsGroupSlotAvailable(f245_arg0)
	local f245_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f245_arg0), "Emblem.EmblemProperties.groupsUsed")
	local f245_local1 = false
	if f245_local0 then
		f245_local1 = Engine[@"getmodelvalue"](f245_local0) < Enum[@"customizationtypegroupcount"][@"customization_type_max_groups"] - 1
	end
	return f245_local1
end
function IsEmptyLayerAvailable(f246_arg0)
	local f246_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f246_arg0), "Emblem.EmblemProperties.layersUsed")
	local f246_local1 = false
	local f246_local2 = CoD.perController[f246_arg0].totalLayers
	if f246_local0 then
		f246_local1 = Engine[@"getmodelvalue"](f246_local0) < f246_local2
	end
	return f246_local1
end
function BrowseModeLinkedLayer(f247_arg0, f247_arg1, f247_arg2, f247_arg3)
	local f247_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f247_arg1, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_browse"])
	if f247_local0 then
		f247_local0 = CoD.CraftUtility.Emblems_IsLayerLinked(f247_arg2, f247_arg1)
		if f247_local0 then
			f247_local0 = CoD.ModelUtility.IsModelValueGreaterThanOrEqualTo(f247_arg1, "Emblem.EmblemProperties.linkedLayerCount", 2)
			if f247_local0 then
				if not CoD.CraftUtility.Emblem_IsLayerGrouped(f247_arg2, f247_arg1) then
					f247_local0 = IsGroupSlotAvailable(f247_arg1)
					if f247_local0 then
						f247_local0 = not Paintjobs_DisableGroupsFeature()
					end
				else
					f247_local0 = false
				end
			end
		end
	end
	return f247_local0
end
function BrowseModeGroupedLayer(f248_arg0, f248_arg1, f248_arg2, f248_arg3)
	local f248_local0 = CoD.ModelUtility.IsModelValueEqualToEnum(f248_arg1, "Emblem.EmblemProperties.editorMode", Enum[@"customizationeditormode"][@"customization_editor_mode_browse"])
	if f248_local0 then
		f248_local0 = CoD.CraftUtility.Emblem_IsLayerGrouped(f248_arg2, f248_arg1)
		if f248_local0 then
			f248_local0 = not Paintjobs_DisableGroupsFeature()
		end
	end
	return f248_local0
end
function BrowseModeOneLayerLinked(f249_arg0, f249_arg1, f249_arg2)
	local f249_local0 = CoD.CraftUtility.IsBrowseMode(f249_arg1)
	if f249_local0 then
		if not CoD.CraftUtility.IsLayerEmpty(f249_arg0, f249_arg2, f249_arg1) then
			f249_local0 = CoD.CraftUtility.Emblems_IsLayerLinked(f249_arg2, f249_arg1)
			if f249_local0 then
				f249_local0 = not Paintjobs_DisableGroupsFeature()
			end
		else
			f249_local0 = false
		end
	end
	return f249_local0
end
function BrowseMode(f250_arg0, f250_arg1, f250_arg2)
	local f250_local0 = CoD.CraftUtility.IsBrowseMode(f250_arg1)
	if f250_local0 then
		if not CoD.CraftUtility.IsLayerEmpty(f250_arg0, f250_arg2, f250_arg1) then
			f250_local0 = not Paintjobs_DisableGroupsFeature()
		else
			f250_local0 = false
		end
	end
	return f250_local0
end
function GroupsDisabledMode(f251_arg0, f251_arg1, f251_arg2)
	local f251_local0 = Paintjobs_DisableGroupsFeature()
	if f251_local0 then
		f251_local0 = CoD.CraftUtility.IsBrowseMode(f251_arg1)
		if f251_local0 then
			f251_local0 = not CoD.CraftUtility.IsLayerEmpty(f251_arg0, f251_arg2, f251_arg1)
		end
	end
	return f251_local0
end
function IsUserContentRestricted(f252_arg0)
	return Engine[@"isusercontentrestricted"](f252_arg0)
end
function CraftItemIsReadOnly(f253_arg0, f253_arg1)
	local f253_local0 = f253_arg0:getModel(f253_arg1, "readOnly")
	if f253_local0 and f253_local0:get() == 1 then
		return true
	else
		return false
	end
end
function TextHeightGreaterThan(f254_arg0, f254_arg1, f254_arg2)
	if f254_arg0[f254_arg1] == nil then
		return false
	else
		local f254_local0, f254_local1 = f254_arg0[f254_arg1]:getTextWidthAndHeight()
		return f254_arg2 < f254_local1
	end
end
function CallingCards_IsGetPublicProfileComplete(f255_arg0, f255_arg1)
	local f255_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f255_arg1), "CallingCardsIdentity.GetPublicProfileComplete")
	local f255_local1 = false
	if f255_local0 then
		f255_local1 = Engine[@"getmodelvalue"](f255_local0)
	end
	return f255_local1
end
function CraftSlotsFullByStorageType(f256_arg0, f256_arg1)
	if IsLive() and CoD.CraftUtility.GetTotalAllowedSlotsByFileType(f256_arg0, f256_arg1) <= CoD.CraftUtility.GetUsedSlotsByFileType(f256_arg0, f256_arg1) then
		return true
	else
		return false
	end
end
function IsPreBuiltEmblemTab(f257_arg0)
	if CoD.perController[f257_arg0].selectedEmblemTabStorageType == Enum[@"storagefiletype"][@"storage_default_emblems"] or CoD.perController[f257_arg0].selectedEmblemTabStorageType == Enum[@"storagefiletype"][@"storage_emblems_loot"] or CoD.perController[f257_arg0].selectedEmblemTabStorageType == Enum[@"storagefiletype"][@"hash_36A0A3D1062F156F"] then
		return true
	else
		return false
	end
end
function IsEmblemEditor(f258_arg0)
	return CoD.GetCustomization(f258_arg0, "type") == Enum[@"customizationtype"][@"customization_type_emblem"]
end
function IsPaintshop(f259_arg0)
	local f259_local0 = CoD.GetCustomization(f259_arg0, "type")
	local f259_local1
	if f259_local0 ~= Enum[@"customizationtype"][@"customization_type_paintshop_view_left"] and f259_local0 ~= Enum[@"customizationtype"][@"customization_type_paintshop_view_top"] and f259_local0 ~= Enum[@"customizationtype"][@"customization_type_paintshop_view_right"] then
		f259_local1 = false
	else
		f259_local1 = true
	end
	return f259_local1
end
function IsMaxPrestigeLevel(f260_arg0)
	return CoD.PrestigeUtility.GetPrestigeCap(CoD.PrestigeUtility.GetPrestigeGameMode()) <= CoD.PrestigeUtility.GetCurrentPLevel(f260_arg0)
end
function IsMaxPrestigeLevelForMode(f261_arg0, f261_arg1)
	return CoD.PrestigeUtility.GetPrestigeCap(f261_arg1) <= CoD.PrestigeUtility.GetCurrentPLevel(f261_arg0, f261_arg1)
end
function IsPrestigeLevelAtZero(f262_arg0)
	return CoD.PrestigeUtility.GetCurrentPLevel(f262_arg0) == 0
end
function IsAtXPCap(f263_arg0)
	local f263_local0 = Engine[@"getplayerstats"](f263_arg0, CoD.STATS_LOCATION_NORMAL, CoD.PrestigeUtility.GetPrestigeGameMode())
	return Engine[@"getxpcap"](CoD.PrestigeUtility.GetPrestigeGameMode()) <= f263_local0.PlayerStatsList.RANKXP.StatValue:get()
end
function IsPrestigeRewardSpent(f264_arg0, f264_arg1)
	return Engine[@"isprestigetokenspentbytype"](f264_arg0, f264_arg1, CoD.PrestigeUtility.GetPrestigeGameMode())
end
function IsInPermanentUnlockMenu(f265_arg0)
	return CoD.PrestigeUtility.isInPermanentUnlockMenu
end
function IsGameModeParagonCapable(f266_arg0)
	return LuaUtils.IsGameModeParagonCapable(f266_arg0)
end
function IsInParagonCapableGameMode()
	return IsGameModeParagonCapable(Engine[@"currentsessionmode"]())
end
function IsUnlockTokenButtonAvailable(f268_arg0)
	local f268_local0 = Engine[@"getmodelforcontroller"](f268_arg0)
	f268_local0 = f268_local0.permanentUnlockTokensCount:get()
	local f268_local1
	if f268_local0 == nil or f268_local0 <= 0 then
		f268_local1 = false
	else
		f268_local1 = true
	end
	return f268_local1
end
function IsPrestigeMasterFromRankModel(f269_arg0, f269_arg1, f269_arg2)
	local f269_local0 = f269_arg0:getModel()
	if f269_arg2 ~= "" and f269_local0 then
		f269_local0 = Engine[@"getmodel"](f269_local0, f269_arg2)
	end
	local f269_local1 = tonumber(f269_local0 and Engine[@"getmodelvalue"](f269_local0))
	local f269_local2
	if f269_local1 == nil or f269_local1 <= CoD.RankUtility.GetRankCap() + 1 then
		f269_local2 = false
	else
		f269_local2 = true
	end
	return f269_local2
end
function CompetitiveSettingsEnabled(f270_arg0)
	local f270_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "lobbyRoot.lobbyNav"))
	if f270_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_CUSTOM) or f270_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_ARENA_CUSTOM) or f270_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_MP) or f270_local0 == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_LAN_MP_ARENA) then
		if (Engine[@"getgametypesetting"](@"pregameitemvoteenabled") == 1) or Engine[@"getgametypesetting"](@"pregamedraftenabled") == 1 then
			return true
		end
	end
	return false
end
function CharacterDraftEnabled()
	return Engine[@"getgametypesetting"](@"pregamedraftenabled") == 1
end
function PregameItemVoteEnabled()
	return Engine[@"getgametypesetting"](@"pregameitemvoteenabled") == 1
end
function IsArenaMode()
	return LuaUtils.IsArenaMode()
end
function IsDpadButton(f274_arg0)
	local f274_local0 = f274_arg0 and Engine[@"getmodelvalue"](f274_arg0)
	local f274_local1
	if f274_local0 ~= nil then
		f274_local1 = CoD.BitUtility.IsBitwiseAndNonZero(f274_local0, Enum[@"luibuttonflags"][@"flag_dpad"])
	else
		f274_local1 = true
	end
	return f274_local1
end
function IsRepeatButtonPress(f275_arg0)
	local f275_local0 = f275_arg0 and Engine[@"getmodelvalue"](f275_arg0)
	local f275_local1
	if f275_local0 ~= nil then
		f275_local1 = CoD.BitUtility.IsBitwiseAndNonZero(f275_local0, Enum[@"luibuttonflags"][@"flag_isrepeat"])
	else
		f275_local1 = false
	end
	return f275_local1
end
function IsSelfModelRankValueGreaterThan(f276_arg0, f276_arg1, f276_arg2)
	local f276_local0 = f276_arg0:getModel()
	if f276_local0 then
		f276_local0 = Engine[@"getmodel"](f276_local0, "rank")
	end
	local f276_local1 = f276_local0 and Engine[@"getmodelvalue"](f276_local0)
	local f276_local2
	if tonumber(f276_local1) == nil or f276_arg2 >= tonumber(f276_local1) then
		f276_local2 = false
	else
		f276_local2 = true
	end
	return f276_local2
end
function ShowCPInstructionText(f277_arg0)
	local f277_local0 = Engine[@"getmodelforcontroller"](f277_arg0)
	return Engine[@"getistring"](f277_local0.hudItems.cpInstructionText:get(), "CS_LOCALIZED_STRINGS") ~= 0x0
end
function ShowCPNotificationText(f278_arg0)
	local f278_local0 = Engine[@"getmodelforcontroller"](f278_arg0)
	return f278_local0.hudItems.showCPNotificationText:get() ~= 0
end
function CanUseSharedLoadouts(f279_arg0)
	if not CoD.isCampaign or IsIntDvarNonZero("mp_prototype") then
		return false
	end
	local f279_local0 = Dvar[@"lobby_enableloadoutdatastreamingingame"]:get()
	local f279_local1 = 1
	local f279_local2 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f279_arg0), "ChooseClassCPClientMenu")
	if f279_local2 then
		f279_local1 = Engine[@"getmodelvalue"](Engine[@"getmodel"](f279_local2, "numActiveClients"))
	end
	local f279_local3
	if f279_local0 ~= true or f279_local1 <= 1 then
		f279_local3 = false
	else
		f279_local3 = true
	end
	return f279_local3
end
function IsInTheaterMode()
	if IsLobbyPrivateHost() and IsLobbyMode(Enum[@"lobbymode"][@"lobby_mode_theater"]) then
		return true
	else
		return false
	end
end
function HasFilmAndFilmDownloaded()
	return IsFilmSelected() and CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.theaterDownloadPercent", 99)
end
function LobbyModeTheater()
	return IsLobbyMode(Enum[@"lobbymode"][@"lobby_mode_theater"])
end
function IsFilmSelected()
	local f283_local0 = Engine[@"lobbygetdemoinformation"](Enum[@"lobbymodule"][@"lobby_module_client"], Engine[@"lobbygetcontrollinglobbysession"](Enum[@"lobbymodule"][@"lobby_module_client"]))
	if f283_local0 and f283_local0.fileID ~= Engine[@"defaultid64value"]() then
		return true
	else
		return false
	end
end
function IsUploadClipButtonDisabled()
	if Engine[@"isdemoclipplaying"]() or Engine[@"isdemocliprecording"]() or Engine[@"getdemosegmentcount"]() <= 0 or Engine[@"isrepositioningcameramarker"]() then
		return true
	else
		return false
	end
end
function IsCustomizeHighlightReelButtonDisabled()
	if Engine[@"isdemocliprecording"]() or Engine[@"isrepositioningcameramarker"]() or not Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_game"]) or not Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"]) then
		return true
	else
		return false
	end
end
function IsJumpToStartButtonDisabled()
	if Engine[@"isdemocliprecording"]() or Engine[@"isrepositioningcameramarker"]() or not Engine[@"islobbyhost"](Enum[@"lobbytype"][@"lobby_type_private"]) or not Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"]) then
		return true
	else
		return false
	end
end
function IsDemoPlaying()
	return Engine[@"isdemoplaying"]()
end
function IsDemoClipPlaying()
	return Engine[@"isdemoclipplaying"]()
end
function IsDemoClipPreviewRunning()
	return Engine[@"isdemoclippreviewrunning"]()
end
function IsDemoCreatingHighlightReel()
	local f290_local0 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "demo.isCreatingHighlightReel")
	if f290_local0 then
		return Engine[@"getmodelvalue"](f290_local0) == true
	else
		return false
	end
end
function IsDemoCapturingScreenshot()
	local f291_local0 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "demo.isCapturingScreenshot")
	if f291_local0 then
		return Engine[@"getmodelvalue"](f291_local0) == true
	else
		return false
	end
end
function IsDemoRestrictedBasicMode()
	return CoD.DemoUtility.IsRestrictedBasicMode()
end
function IsDemoContextBasicMode()
	return GetDemoContextMode() == Enum[@"democontextmode"][@"demo_context_mode_basic"]
end
function IsDemoContextPlaybackMode()
	return GetDemoContextMode() == Enum[@"democontextmode"][@"demo_context_mode_playback"]
end
function IsDemoContextDirectorMode()
	return GetDemoContextMode() == Enum[@"democontextmode"][@"demo_context_mode_director"]
end
function IsDemoContextObjectLinkMode()
	return GetDemoContextMode() == Enum[@"democontextmode"][@"demo_context_mode_object_link"]
end
function IsDemoContextLighterMode()
	return GetDemoContextMode() == Enum[@"democontextmode"][@"demo_context_mode_lighter"]
end
function IsDemoContextHighlightReelMode()
	return GetDemoContextMode() == Enum[@"democontextmode"][@"demo_context_mode_highlight_reel"]
end
function IsDemoContextBasicOrHighlightReelMode()
	local f299_local0 = IsDemoContextBasicMode()
	if not f299_local0 then
		f299_local0 = IsDemoContextHighlightReelMode()
	end
	return f299_local0
end
function ShouldAddDollyCameraMarker(f300_arg0)
	if not IsDemoContextDirectorMode() then
		return false
	elseif Engine[@"profilebool"](f300_arg0, @"demo_autodollyrecord") then
		return false
	elseif CoD.ModelUtility.IsGlobalModelValueGreaterThan("demo.highlightedDollyCamMarker", -1) then
		return false
	else
		return true
	end
end
function ShouldEditDollyCameraMarker(f301_arg0)
	if not IsDemoContextDirectorMode() then
		return false
	elseif CoD.ModelUtility.IsGlobalModelValueTrue("demo.isRecordingDollyCameraPath") then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueGreaterThan("demo.highlightedDollyCamMarker", -1) then
		return false
	elseif CoD.ModelUtility.IsGlobalModelValueTrue("demo.editingDollyCameraMarker") then
		return false
	else
		return true
	end
end
function IsEditingDollyCameraMarker(f302_arg0)
	if not IsDemoContextDirectorMode() then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueGreaterThan("demo.highlightedDollyCamMarker", -1) then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueTrue("demo.editingDollyCameraMarker") then
		return false
	else
		return true
	end
end
function IsRepositioningDollyCameraMarker(f303_arg0)
	if not IsDemoContextDirectorMode() then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueTrue("demo.editingDollyCameraMarker") then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueTrue("demo.isRepositioningDollyCamMarker") then
		return false
	else
		return true
	end
end
function IsFreeCameraLockedOnEntity(f304_arg0)
	if not CoD.ModelUtility.IsGlobalModelValueTrue("demo.isFreeCameraLockedOnEntity") then
		return false
	else
		return true
	end
end
function CanFreeCameraLockOnEntity(f305_arg0)
	if not CoD.ModelUtility.IsGlobalModelValueTrue("demo.isFreeCameraEntityLockOnAllowed") then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueGreaterThan("demo.highlightedFreeCameraLockOnEntity", 0) then
		return false
	elseif CoD.ModelUtility.IsGlobalModelValueTrue("demo.isFreeCameraLockedOnEntityActive") then
		return false
	else
		return true
	end
end
function ShouldAddLightmanMarker(f306_arg0)
	if not IsDemoContextLighterMode() then
		return false
	elseif CoD.ModelUtility.IsGlobalModelValueGreaterThan("demo.highlightedLightmanMarker", -1) then
		return false
	else
		return true
	end
end
function ShouldEditLightmanMarker(f307_arg0)
	if not IsDemoContextLighterMode() then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueGreaterThan("demo.highlightedLightmanMarker", -1) then
		return false
	elseif CoD.ModelUtility.IsGlobalModelValueTrue("demo.editingLightmanMarker") then
		return false
	else
		return true
	end
end
function IsEditingLightmanMarker(f308_arg0)
	if not IsDemoContextLighterMode() then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueGreaterThan("demo.highlightedLightmanMarker", -1) then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueTrue("demo.editingLightmanMarker") then
		return false
	else
		return true
	end
end
function IsRepositioningLightmanMarker(f309_arg0)
	if not IsDemoContextLighterMode() then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueTrue("demo.editingLightmanMarker") then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueTrue("demo.isRepositioningLightmanMarker") then
		return false
	else
		return true
	end
end
function IsInLightmanColorPicker(f310_arg0)
	if not IsDemoContextLighterMode() then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueTrue("demo.editingLightmanMarker") then
		return false
	elseif not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showLightmanColorPicker") then
		return false
	else
		return true
	end
end
function IsSegmentInSelectedState(f311_arg0, f311_arg1)
	local f311_local0 = CoD.DemoUtility.Timeline_GetSelectedSegmentModel()
	if f311_local0 and f311_local0 == f311_arg0:getModel() then
		local f311_local1 = Engine[@"getmodel"](f311_local0, "selected")
		if f311_local1 then
			return Engine[@"getmodelvalue"](f311_local1)
		end
	end
	return false
end
function IsTimelineEditorInMoveState(f312_arg0)
	return CoD.DemoUtility.Timeline_GetSelectedSegmentModel() ~= nil
end
function SegmentCountGreaterThan(f313_arg0, f313_arg1)
	return f313_arg1 < Engine[@"getdemosegmentcount"]()
end
function CanChangeSegmentTransition(f314_arg0, f314_arg1)
	local f314_local0 = Engine[@"getdemosegmentcount"]()
	local f314_local1 = Engine[@"getmodel"](f314_arg0:getModel(), "segmentNumber")
	if f314_local1 then
		return Engine[@"getmodelvalue"](f314_local1) < f314_local0
	else
		return false
	end
end
function IsSegmentTransition(f315_arg0, f315_arg1, f315_arg2)
	local f315_local0 = Engine[@"getmodel"](f315_arg0:getModel(), "segmentNumber")
	if f315_local0 then
		return tonumber(Engine[@"getdemosegmentinformation"](Engine[@"getmodelvalue"](f315_local0) - 1, "transitionValue")) == f315_arg2
	else
		return false
	end
end
function HideVehicleReticle(f316_arg0, f316_arg1, f316_arg2)
	local f316_local0 = DataSources.VehicleInfo.getModel(f316_arg1)
	return f316_local0.vehicleType:get() == "spawner_enemy_54i_vehicle_raps_suicide_player"
end
function VehicleHasEnemyLock(f317_arg0, f317_arg1)
	local f317_local0 = CoD.ModelUtility.IsSelfEnumModelValueTrue(f317_arg0, f317_arg1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_up"])
	if not f317_local0 then
		f317_local0 = CoD.ModelUtility.IsSelfEnumModelValueTrue(f317_arg0, f317_arg1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_down"])
		if not f317_local0 then
			f317_local0 = CoD.ModelUtility.IsSelfEnumModelValueTrue(f317_arg0, f317_arg1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_left"])
			if not f317_local0 then
				f317_local0 = CoD.ModelUtility.IsSelfEnumModelValueTrue(f317_arg0, f317_arg1, Enum[@"missilelockedondirection"][@"missile_locked_on_direction_right"])
			end
		end
	end
	return f317_local0
end
function IsVehicleOfType(f318_arg0)
	return false
end
function IsSelfPlayerName(f319_arg0, f319_arg1)
	local f319_local0 = f319_arg0:getModel(f319_arg1, "isSelfPlayerName")
	local f319_local1 = false
	if f319_local0 then
		f319_local1 = Engine[@"getmodelvalue"](f319_local0)
	end
	return f319_local1
end
function ShouldDisplayFactionIconAtPrematchCountdown()
	return CoDShared.IsGametypeTeamBased()
end
function IsGamepad(f321_arg0)
	return CoD.useController and Engine[@"lastinput_gamepad"]()
end
function IsGamepadOrKeyboardNavigation(f322_arg0)
	local f322_local0 = IsUsingKeyboardNavigation(f322_arg0)
	if not f322_local0 then
		f322_local0 = CoD.useController
		if f322_local0 then
			f322_local0 = Engine[@"lastinput_gamepad"]()
		end
	end
	return f322_local0
end
function IsMouse(f323_arg0)
	return CoD.useMouse and Engine[@"lastinput_mouse"]()
end
function IsKeyboard(f324_arg0)
	return CoD.useKeyboard and Engine[@"hash_267ACA658A43FBD"]()
end
function IsMouseOrKeyboard(f325_arg0)
	local f325_local0
	if CoD.useMouse then
		f325_local0 = Engine[@"lastinput_mouse"]()
		if not f325_local0 then
			f325_local0 = CoD.useKeyboard
			if f325_local0 then
				f325_local0 = Engine[@"hash_267ACA658A43FBD"]()
			end
		end
	else
		f325_local0 = CoD.useKeyboard
		if f325_local0 then
			f325_local0 = Engine[@"hash_267ACA658A43FBD"]()
		end
	end
	return f325_local0
end
function IsUsingKeyboardNavigation(f326_arg0)
	local f326_local0 = CoD.useMouse
	if f326_local0 then
		f326_local0 = CoD.useKeyboard
		if f326_local0 then
			f326_local0 = Engine[@"hash_6E5A6D75074FFFC7"](f326_arg0)
		end
	end
	return f326_local0
end
function IsDurangoGamepad(f327_arg0)
	local f327_local0 = IsDurango()
	if not f327_local0 then
		f327_local0 = IsPC()
		if f327_local0 then
			f327_local0 = IsGamepad(f327_arg0)
			if f327_local0 then
				f327_local0 = Engine[@"gamepadtype"](f327_arg0) == Enum[@"gamepadtype_e"][@"gamepad_type_durango"]
			end
		end
	end
	return f327_local0
end
function IsOrbisGamepad(f328_arg0)
	local f328_local0
	if not IsOrbis() or Engine[@"lastinput_vita"](f328_arg0) then
		f328_local0 = IsPC()
		if f328_local0 then
			f328_local0 = IsGamepad(f328_arg0)
			if f328_local0 then
				if Engine[@"gamepadtype"](f328_arg0) ~= Enum[@"gamepadtype_e"][@"gamepad_type_orbis"] then
					f328_local0 = false
				else
					f328_local0 = true
				end
			end
		end
	else
		f328_local0 = true
	end
	return f328_local0
end
function IsVitaGamepad(f329_arg0)
	return IsOrbis() and Engine[@"lastinput_vita"](f329_arg0)
end
function DurangoGamepadInPorts(f330_arg0)
	return IsPC() and Engine[@"gamepadtype"](f330_arg0) == Enum[@"gamepadtype_e"][@"gamepad_type_durango"]
end
function OrbisGamepadInPorts(f331_arg0)
	return IsPC() and Engine[@"gamepadtype"](f331_arg0) == Enum[@"gamepadtype_e"][@"gamepad_type_orbis"]
end
function NoGamepadInPorts(f332_arg0)
	return IsPC() and Engine[@"gamepadtype"](f332_arg0) == Enum[@"gamepadtype_e"][@"gamepad_type_count"]
end
function WasCampaignSoloGame(f333_arg0)
	return Engine[@"getscoreboardteamclientcount"](Enum[@"team_t"][@"team_allies"]) == 1
end
function HasFriends(f334_arg0)
	return Engine[@"getfriendscount"](f334_arg0, Enum[@"presencefilter"][@"presence_filter_all"]) > 0
end
function HasRecentPlayers(f335_arg0)
	return CoD.SocialUtility.GetRecentPlayersCount(f335_arg0) > 0
end
function IsSocialPlayersListEmpty(f336_arg0)
	local f336_local0 = Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"createmodel"](Engine[@"getglobalmodel"](), "socialRoot"), "tab"))
	if f336_local0 ~= nil then
		if f336_local0 == "friends" then
			return not HasFriends(f336_arg0)
		elseif f336_local0 == "recent" then
			return not HasRecentPlayers(f336_arg0)
		end
	end
	return true
end
function IsInTitle(f337_arg0, f337_arg1)
	local f337_local0 = f337_arg0:getModel(f337_arg1, "presence")
	if f337_local0 ~= nil then
		local f337_local1 = Engine[@"getmodelvalue"](f337_local0)
		if f337_local1 == Enum[@"presenceactivity"][@"hash_51CF21FD793411B9"] then
			return false
		elseif f337_local1 == Enum[@"presenceactivity"][@"hash_7A2184EBB293AF2D"] then
			return false
		else
			return true
		end
	end
	local f337_local1 = f337_arg0:getModel(f337_arg1, "activity")
	if f337_local1 then
		local f337_local2 = Engine[@"getmodelvalue"](f337_local1)
		if f337_local2 == Enum[@"presenceactivity"][@"presence_activity_online_not_in_title"] then
			return false
		elseif f337_local2 == Enum[@"presenceactivity"][@"presence_activity_offline"] then
			return false
		end
	end
	return true
end
function IsJoinable(f338_arg0, f338_arg1)
	if LuaUtils.LobbyIsLocked() then
		return false
	elseif Dvar.twitchcon:exists() then
		return true
	end
	local f338_local0 = f338_arg0:getModel(f338_arg1, "joinable")
	if f338_local0 then
		local f338_local1 = Engine[@"getmodelvalue"](f338_local0)
		if f338_local1 == Enum[@"lobbyjoinable"][@"lobby_joinable_yes"] then
			return true
		elseif f338_local1 == Enum[@"lobbyjoinable"][@"lobby_joinable_yes_friends_only"] then
			local f338_local2 = f338_arg0:getModel(f338_arg1, "friend")
			if f338_local2 and Engine[@"getmodelvalue"](f338_local2) then
				return true
			end
		end
	end
	return false
end
function HideWinnersLabelsAndInfo(f339_arg0)
	local f339_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f339_arg0), "gameScore.draw")
	local f339_local1 = Engine[@"getgametypesetting"](@"teamcount") < 2
	if f339_local0 then
		f339_local0 = Engine[@"getmodelvalue"](f339_local0)
	end
	if f339_local0 or f339_local1 then
		return true
	else
	end
end
function IsScoreboardPingAsBars(f340_arg0, f340_arg1)
	if Dvar[@"hash_7DDC61194A7E2C0C"]:get() == false then
		return Dvar[@"cg_scoresping_interval"]:get() > 1
	else
		return Dvar[@"hash_7DDC61194A7E2C0C"]:get() > 1
	end
end
function ScoreboardVisible(f341_arg0)
	local f341_local0 = Engine[@"isvisibilitybitset"](f341_arg0, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"])
	if not f341_local0 then
		f341_local0 = CoD.ModelUtility.IsModelValueEqualTo(f341_arg0, "forceScoreboard", 1)
	end
	return f341_local0
end
function IsScoreboardPlayerMuted(f342_arg0, f342_arg1)
	return Engine[@"isplayermutedbyclientnum"](f342_arg0, Enum[@"lobbytype"][@"lobby_type_game"], CoD.SafeGetModelValue(f342_arg1:getModel(), "clientNum"))
end
function IsScoreboardPlayerCodCaster(f343_arg0, f343_arg1)
	local f343_local0 = CoD.SafeGetModelValue(f343_arg1:getModel(), "clientNum")
	if f343_local0 ~= nil and f343_local0 >= 0 then
		return Engine[@"getteamid"](f343_arg0, f343_local0) == Enum[@"team_t"][@"team_spectator"]
	else
		return false
	end
end
function ScoreboardMuteButtonPromptHidden(f344_arg0, f344_arg1)
	if InFrontend() then
		return true
	elseif CoD.IsShoutcaster(f344_arg1) then
		return true
	else
		local f344_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f344_arg1), "scoreboardInfo.muteButtonPromptVisible")
		if f344_local0 and not Engine[@"getmodelvalue"](f344_local0) then
			return true
		else
			return false
		end
	end
end
function ScoreboardCanShowGamerCard(f345_arg0, f345_arg1)
	if not CoD.isDurango then
		return false
	else
		local f345_local0 = CoD.SafeGetModelValue(f345_arg0:getModel(), "clientNum")
		if f345_local0 == nil or f345_local0 < 0 then
			return false
		else
			return Engine[@"getmatchscoreboardclientxuid"](f345_local0) ~= nil
		end
	end
end
function IsScoreboardPlayerSelf(f346_arg0, f346_arg1)
	local f346_local0 = f346_arg0:getModel(f346_arg1, "clientNum")
	if f346_local0 then
		if CoD.IsShoutcaster(f346_arg1) then
			return Engine[@"getpredictedclientnum"](f346_arg1) == Engine[@"getmodelvalue"](f346_local0)
		end
		local f346_local1 = f346_arg1
		local f346_local2 = f346_arg1
		if IsInGame() and Engine[@"isvisibilitybitset"](f346_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"]) then
			f346_local1 = 0
			f346_local2 = Engine[@"getmaxcontrollercount"]() - 1
		end
		for f346_local3 = f346_local1, f346_local2, 1 do
			if Engine[@"iscontrollerbeingused"](f346_local3) then
				if CoD.isPC then
					local f346_local6 = Engine[@"getclientnum"](f346_local3)
					if f346_local6 and f346_local6 >= 0 and f346_local6 == Engine[@"getmodelvalue"](f346_local0) then
						return true
					end
				end
				if string.gsub(GetScoreboardPlayerName(f346_local3, Engine[@"getmodelvalue"](f346_local0)), "%[.+%]", "") == Engine[@"getselfgamertag"](f346_local3) then
					return true
				end
			end
		end
	end
	return false
end
function IsFreeRunMap(f347_arg0)
	return false
end
function IsFreeRunLobby()
	return false
end
function ShouldShowPartyPrivacy(f349_arg0)
	local f349_local0 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
	local f349_local1 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f349_local2 = Enum[@"lobbytype"][@"lobby_type_private"]
	if f349_local1 and f349_local0[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_custom"] then
		f349_local2 = Enum[@"lobbytype"][@"lobby_type_game"]
	end
	if not Engine[@"islobbyhost"](f349_local2) then
		return false
	elseif f349_local0[@"maxclients"] <= 1 then
		return false
	else
		return true
	end
end
function ShouldShowLeaveParty(f350_arg0)
	local f350_local0 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
	local f350_local1 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f350_local2 = Enum[@"lobbytype"][@"lobby_type_private"]
	if f350_local1 and f350_local0[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_custom"] then
		f350_local2 = Enum[@"lobbytype"][@"lobby_type_game"]
	end
	local f350_local3 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_client"], f350_local2)
	if #f350_local3.sessionClients == 1 then
		return false
	end
	local f350_local4 = 0
	for f350_local8, f350_local9 in ipairs(f350_local3.sessionClients) do
		if f350_local9.isLocal == true then
			f350_local4 = f350_local4 + 1
		end
	end
	if f350_local4 == #f350_local3.sessionClients then
		return false
	elseif LuaUtils.LobbyIsLocked() then
		return false
	end
	return true
end
function ShouldShowPromotePlayer(f351_arg0)
	return false
end
function ShouldShowBootPlayer(f352_arg0)
	local f352_local0 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
	local f352_local1 = Engine[@"islobbyactive"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"])
	local f352_local2 = Enum[@"lobbytype"][@"lobby_type_private"]
	if f352_local1 and f352_local0[@"lobbymode"] == Enum[@"lobbymode"][@"lobby_mode_custom"] then
		f352_local2 = Enum[@"lobbytype"][@"lobby_type_game"]
	end
	if not Engine[@"islobbyhost"](f352_local2) then
		return false
	end
	local f352_local3 = Engine[@"lobbygetsessionclients"](Enum[@"lobbymodule"][@"lobby_module_host"], f352_local2)
	if #f352_local3.sessionClients == 1 then
		return false
	end
	local f352_local4 = 0
	for f352_local8, f352_local9 in ipairs(f352_local3.sessionClients) do
		if f352_local9.isLocal == true then
			f352_local4 = f352_local4 + 1
		end
	end
	if f352_local4 == #f352_local3.sessionClients then
		return false
	elseif LuaUtils.LobbyIsLocked() then
		return false
	end
	return true
end
function IsBleedOutVisible(f353_arg0, f353_arg1)
	if Engine[@"isvisibilitybitset"](f353_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) then
		return false
	end
	local f353_local0 = f353_arg0:getModel(f353_arg1, "stateFlags")
	if f353_local0 then
		local f353_local1 = Engine[@"getmodelvalue"](f353_local0)
		if f353_local1 ~= nil then
			return CoD.BitUtility.IsAnyBitSet(f353_local1, {
				Enum[@"bleedoutstateflags"][@"bleedout_state_flag_bleeding_out"],
				Enum[@"bleedoutstateflags"][@"bleedout_state_flag_being_revived"],
			})
		end
	end
	return false
end
function DropDownListIsInUse(f354_arg0)
	return f354_arg0.inUse
end
function CheckBoxOptionChecked(f355_arg0, f355_arg1)
	return false
end
function ShouldHideButtonPromptForPC(f356_arg0, f356_arg1)
	if CoD.isPC then
		local f356_local0 = CoD.PCUtil.GetElementModelValues(f356_arg0, {
			"Button",
			"Label",
			"flags",
		})
		local f356_local1 = f356_local0
		local f356_local2 = f356_local0.flags
		if f356_local2 then
			f356_local2 = f356_local1 and f356_local0.flags
		end
		if not next(f356_local0) then
			return true
		elseif f356_local0 and f356_local0.Label and f356_local0.Label == 0x0 then
			return true
		elseif f356_local0 and f356_local0.Label and f356_local0.Label == @"menu/select" and f356_local0.Button == Enum[@"luibutton"][@"lui_key_xba_pscross"] then
			return true
		elseif f356_local2 and CoD.BitUtility.IsBitwiseAndNonZero(f356_local2, Enum[@"luibuttonpromptflags"][@"bpf_contextual"]) and not CoD.FreeCursorUtility.CanShowContextualButtonPromptPC(f356_arg0, f356_arg1) then
			return true
		end
	end
	return false
end
function ShouldShowMtxCommsMOTDPopup(f357_arg0)
	return CoD.MOTDUtility.MOTD_ShouldShowMOTD(f357_arg0)
end
function IsMenuAARKoreaEvent(f358_arg0)
	return f358_arg0.menuName == "PC_Korea_Event_AAR_Menu"
end
function IsOwedVials(f359_arg0)
	local f359_local0 = Engine[@"storagegetbuffer"](f359_arg0, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	if not f359_local0 then
		return false
	elseif Dvar[@"tu5_enablevialsowed"]:exists() then
		local f359_local1
		if f359_local0.vialsOwed:get() > 0 then
			f359_local1 = Dvar[@"tu5_enablevialsowed"]:get()
		else
			f359_local1 = false
		end
		return f359_local1
	else
		return f359_local0.vialsOwed:get() > 0
	end
end
function HasStoreItems(f360_arg0)
	if CoD.perController[f360_arg0].selectedStoreCategory then
		return #Engine[@"getstoreproductsbycategory"](f360_arg0, CoD.perController[f360_arg0].selectedStoreCategory) > 0
	else
		return false
	end
end
function HideProductNameAndDesc()
	return false
end
function IsLootReady(f362_arg0)
	return Engine[@"islootready"](f362_arg0)
end
function DisableSteamStore()
	return not CoD.isPC
end
function BattlenetStoreDisabled(f364_arg0)
	if CoD.isPC then
		local f364_local0
		if CoD.PCUtility.IsBGSEnabled() and Dvar[@"hash_124327E5B2870E07"]:get() then
			f364_local0 = not IsPlayerSignedInToLive(f364_arg0)
		else
			f364_local0 = true
		end
		return f364_local0
	else
		return true
	end
end
function ShouldOpenGraphicsAndSoundOptions()
	if IsDurango() then
		return true
	elseif CoD.DirectorUtility.IsOfflineOnlyDemo() then
		return false
	else
		local f365_local0
		if Dvar[@"ui_execdemo"]:get() then
			f365_local0 = Dvar[@"ui_execdemo"]:get()
			if f365_local0 then
				f365_local0 = Dvar[@"ui_execdemo_beta"]:get()
			end
		else
			f365_local0 = true
		end
	end
	return f365_local0
end
function IsBlackhatHacking(f366_arg0)
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f366_arg0), "hudItems.blackhat.status")) == CoD.BlackhatStatus.Hacking
end
function IsBlackhatBreaching(f367_arg0)
	return Engine[@"getmodelvalue"](Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f367_arg0), "hudItems.blackhat.status")) == CoD.BlackhatStatus.Breaching
end
function IsAlertOverlay(f368_arg0, f368_arg1)
	local f368_local0 = f368_arg0:getModel(f368_arg1, "categoryType")
	if f368_local0 then
		local f368_local1 = Engine[@"getmodelvalue"](f368_local0)
		local f368_local2
		if f368_local1 ~= CoD.OverlayUtility.OverlayTypes.Alert and f368_local1 ~= CoD.OverlayUtility.OverlayTypes.Error then
			f368_local2 = false
		else
			f368_local2 = true
		end
		return f368_local2
	else
		return false
	end
end
function HasOverlayBackAction(f369_arg0)
	return f369_arg0[CoD.OverlayUtility.GoBackPropertyName] ~= nil
end
function HasOverlayContinueAction(f370_arg0)
	return f370_arg0[CoD.OverlayUtility.ContinuePropertyName] ~= nil
end
function IsCodCasterQuickSettingEnabled(f371_arg0, f371_arg1, f371_arg2)
	if not f371_arg1.profileVar then
		return false
	else
		return CoD.ShoutcasterProfileVarBool(f371_arg2, f371_arg1.profileVar)
	end
end
function IsCodCaster(f372_arg0)
	if CoD.IsShoutcaster(f372_arg0) then
		return true
	else
		return false
	end
end
function IsCodCasterProfileValueEqualTo(f373_arg0, f373_arg1, f373_arg2)
	local f373_local0 = CoD.ShoutcasterProfileVarValue(f373_arg0, f373_arg1)
	if f373_arg1 == "shoutcaster_ds_minimap" and Dvar[@"hash_26836B43838B155"]:exists() and Dvar[@"hash_26836B43838B155"]:get() ~= 0 then
		return 1
	else
		local f373_local1
		if f373_local0 == nil or f373_local0 ~= f373_arg2 then
			f373_local1 = false
		else
			f373_local1 = true
		end
	end
	return f373_local1
end
function ShouldHideCodCasterHud(f374_arg0)
	if not CoD.ModelUtility.IsGlobalModelValueGreaterThan("scoreboard.team1.count", 0) and not CoD.ModelUtility.IsGlobalModelValueGreaterThan("scoreboard.team2.count", 0) then
		return true
	else
		return false
	end
end
function ShouldPresentMOTDBanner(f375_arg0, f375_arg1)
	local f375_local0 = false
	local f375_local1 = Engine[@"getmarketingmessage"](f375_arg0, "registration")
	if f375_local1 ~= nil then
		local f375_local2 = f375_local1.action
		if f375_local2 == "registration" or f375_local2 == "opt-in" or f375_local2 == "store" or f375_local2 == "blackmarket" or f375_local2 == "drmonty" or f375_local2 == "expand" then
			return true
		end
		f375_local0 = true
	end
	if ShouldShowMtxCommsMOTDPopup(f375_arg0) then
		local f375_local2 = Engine[@"hash_15451F941503DA5A"](f375_arg0, CoD.MOTDUtility.MOTD_GetMOTDChannel())
		if f375_local2 == nil or not f375_local2.hasBanner then
			return false
		elseif f375_local0 == true then
			local f375_local3 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "MtxCommsRegistration")
			Engine[@"setmodelvalue"](Engine[@"getmodel"](f375_local3, "content_short"), f375_local2.bannerTitle)
			Engine[@"setmodelvalue"](Engine[@"getmodel"](f375_local3, "action"), f375_local2.bannerAction)
			Engine[@"setmodelvalue"](Engine[@"getmodel"](f375_local3, "image"), f375_local2.bannerImage)
			Engine[@"setmodelvalue"](Engine[@"getmodel"](f375_local3, "action_title"), f375_local2.bannerActionString)
			Engine[@"setmodelvalue"](Engine[@"getmodel"](f375_local3, "locationID"), 1)
		end
		return true
	end
	return false
end
function FuseBoxVisible(f376_arg0, f376_arg1)
	if CoD.ZombieUtility[f376_arg1] then
		local f376_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f376_arg0), "zmInventory." .. CoD.ZombieUtility.ZOD_CRAFTABLE_POLICE_BOX .. "_" .. CoD.ZombieUtility[f376_arg1])
		return f376_local0 and Engine[@"getmodelvalue"](f376_local0) == 1
	else
	end
end
function IDGunBlueprintPieceVisible(f377_arg0, f377_arg1)
	if CoD.ZombieUtility[f377_arg1] then
		local f377_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f377_arg0), "zmInventory." .. CoD.ZombieUtility.ZOD_CRAFTABLE_IDGUN .. "_" .. CoD.ZombieUtility[f377_arg1])
		return f377_local0 and Engine[@"getmodelvalue"](f377_local0) == 1
	else
	end
end
function SummonningKeyVisible(f378_arg0)
	local f378_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f378_arg0), "zmInventory." .. CoD.ZombieUtility.CLIENTFIELD_ZOD_CRAFTABLE_PIECE_QUEST_KEY)
	return f378_local0 and Engine[@"getmodelvalue"](f378_local0) == 1
end
function SummoningKeyBeingUsed(f379_arg0)
	local f379_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f379_arg0), "zmInventory." .. CoD.ZombieUtility.USED_QUEST_KEY)
	local f379_local1 = Engine[@"getmodelvalue"](f379_local0)
	local f379_local2 = f379_local0
	local f379_local3
	if f379_local1 <= CoD.ZombieUtility.PLAYER_USED_QUEST_KEY_NONE or f379_local1 >= CoD.ZombieUtility.PLAYER_USED_QUEST_KEY_STATES then
		f379_local3 = false
	else
		f379_local3 = f379_local2 and true
	end
	return f379_local3
end
function SummoningKeyBeingUsedByOtherPlayer(f380_arg0)
	local f380_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f380_arg0), "zmInventory." .. CoD.ZombieUtility.USED_QUEST_KEY)
	local f380_local1 = Engine[@"getmodelvalue"](f380_local0)
	local f380_local2 = Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f380_arg0), "zmInventory.player_character_identity"))
	local f380_local3 = f380_local0
	local f380_local4
	if f380_local1 <= CoD.ZombieUtility.PLAYER_USED_QUEST_KEY_NONE or f380_local1 >= CoD.ZombieUtility.PLAYER_USED_QUEST_KEY_STATES or f380_local1 == f380_local2 then
		f380_local4 = false
	else
		f380_local4 = f380_local3 and true
	end
	return f380_local4
end
function SummoningKeyMissing(f381_arg0)
	return (CheckMemento(f381_arg0, CoD.ZombieUtility.ZOD_NAME_FEMME) or CheckMemento(f381_arg0, CoD.ZombieUtility.ZOD_NAME_DETECTIVE) or CheckMemento(f381_arg0, CoD.ZombieUtility.ZOD_NAME_BOXER) or CheckMemento(f381_arg0, CoD.ZombieUtility.ZOD_NAME_MAGICIAN)) and not SummonningKeyVisible(f381_arg0)
end
function IsRitualItemInState(f382_arg0, f382_arg1, f382_arg2)
	if CoD.ZombieUtility[f382_arg1] and CoD.ZombieUtility[f382_arg2] then
		local f382_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f382_arg0), "zmInventory." .. CoD.ZombieUtility.CLIENTFIELD_QUEST_STATE_BASE .. CoD.ZombieUtility[f382_arg1])
		return f382_local0 and Engine[@"getmodelvalue"](f382_local0) == CoD.ZombieUtility[f382_arg2]
	else
	end
end
function IsRitualItemHeldBy(f383_arg0, f383_arg1, f383_arg2)
	if CoD.ZombieUtility[f383_arg1] and CoD.ZombieUtility[f383_arg2] then
		local f383_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f383_arg0), "zmInventory." .. CoD.ZombieUtility.CLIENTFIELD_HOLDER_OF_BASE .. CoD.ZombieUtility[f383_arg1])
		return f383_local0 and Engine[@"getmodelvalue"](f383_local0) == CoD.ZombieUtility[f383_arg2]
	else
	end
end
function IsRitualItemMissing(f384_arg0, f384_arg1)
	if CoD.ZombieUtility[f384_arg1] then
		local f384_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f384_arg0), "zmInventory." .. CoD.ZombieUtility.CLIENTFIELD_CHECK_BASE .. CoD.ZombieUtility[f384_arg1] .. CoD.ZombieUtility.MEMENTO_SUFFIX)
		return f384_local0 and Engine[@"getmodelvalue"](f384_local0) == 1 and IsRitualItemInState(f384_arg0, f384_arg1, "CLIENTFIELD_ZOD_UI_QUEST_STATE_NEED_MEMENTO")
	else
	end
end
function IsRitualItemBeingUsed(f385_arg0, f385_arg1)
	if CoD.ZombieUtility["PLAYER_USED_QUEST_KEY_" .. f385_arg1] then
		local f385_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f385_arg0), "zmInventory." .. CoD.ZombieUtility.USED_QUEST_KEY_LOCATION)
		return f385_local0 and Engine[@"getmodelvalue"](f385_local0) == CoD.ZombieUtility["PLAYER_USED_QUEST_KEY_" .. f385_arg1]
	else
	end
end
function IsRitualItemWithAnotherPlayer(f386_arg0, f386_arg1)
	if CoD.ZombieUtility[f386_arg1] then
		local f386_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f386_arg0), "zmInventory." .. CoD.ZombieUtility.CLIENTFIELD_CHECK_BASE .. CoD.ZombieUtility[f386_arg1] .. CoD.ZombieUtility.MEMENTO_SUFFIX)
		return f386_local0 and Engine[@"getmodelvalue"](f386_local0) == 1 and not IsRitualItemHeldBy(f386_arg0, f386_arg1, CoD.ZombieUtility.GetCharacterEnumString(Engine[@"getmodelvalue"](Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f386_arg0), "zmInventory.player_character_identity"))))
	else
	end
end
function SprayerMissing(f387_arg0)
	local f387_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f387_arg0), "zmInventory." .. CoD.ZombieUtility.POD_SPRAYER_HINT_RANGE)
	local f387_local1 = f387_local0
	local f387_local2
	if Engine[@"getmodelvalue"](f387_local0) == 1 then
		f387_local2 = not SprayerFound(f387_arg0)
	else
		f387_local2 = false
	end
	return f387_local2
end
function SprayerFound(f388_arg0)
	local f388_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f388_arg0), "zmInventory." .. CoD.ZombieUtility.POD_SPRAYER_HELD)
	return f388_local0 and Engine[@"getmodelvalue"](f388_local0) == 1
end
function SprayerInUse(f389_arg0)
	local f389_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f389_arg0), "zmInventory." .. CoD.ZombieUtility.PLAYER_USING_SPRAYER)
	return f389_local0 and Engine[@"getmodelvalue"](f389_local0) == 1
end
function ShowQuestItemsWidget(f390_arg0)
	local f390_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f390_arg0), "zmInventory." .. CoD.ZombieUtility.WIDGET_QUEST_ITEMS)
	return f390_local0 and Engine[@"getmodelvalue"](f390_local0) == 1
end
function ShowIDGunPartsWidget(f391_arg0)
	local f391_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f391_arg0), "zmInventory." .. CoD.ZombieUtility.WIDGET_IDGUN_PARTS)
	return f391_local0 and Engine[@"getmodelvalue"](f391_local0) == 1
end
function ShowRocketShieldPartsWidget(f392_arg0)
	local f392_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f392_arg0), "zmInventory." .. CoD.ZombieUtility.WIDGET_ROCKETSHIELD_PARTS)
	return f392_local0 and Engine[@"getmodelvalue"](f392_local0) == 1
end
function ShowFuseBoxWidget(f393_arg0)
	local f393_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f393_arg0), "zmInventory." .. CoD.ZombieUtility.WIDGET_FUSES)
	return f393_local0 and Engine[@"getmodelvalue"](f393_local0) == 1
end
function ShowEggWidget(f394_arg0)
	local f394_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f394_arg0), "zmInventory." .. CoD.ZombieUtility.WIDGET_EGG)
	return f394_local0 and Engine[@"getmodelvalue"](f394_local0) == 1
end
function ShowSprayerWidget(f395_arg0)
	local f395_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f395_arg0), "zmInventory." .. CoD.ZombieUtility.WIDGET_SPRAYER)
	return f395_local0 and Engine[@"getmodelvalue"](f395_local0) == 1
end
function QuestEggInState(f396_arg0, f396_arg1)
	if CoD.ZombieUtility[f396_arg1] then
		local f396_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f396_arg0), "zmInventory." .. CoD.ZombieUtility.PLAYER_SWORD_QUEST_EGG_STATE)
		return f396_local0 and Engine[@"getmodelvalue"](f396_local0) == CoD.ZombieUtility[f396_arg1]
	else
	end
end
function QuestEggQuest1Complete(f397_arg0)
	local f397_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f397_arg0), "zmInventory." .. CoD.ZombieUtility.PLAYER_SWORD_QUEST_COMPLETED_LEVEL_1)
	return f397_local0 and Engine[@"getmodelvalue"](f397_local0) == 1
end
function ChatClientShow(f398_arg0)
	local f398_local0 = CoD.isPC
	if f398_local0 then
		f398_local0 = CoD.PCWidgetUtility
		if f398_local0 then
			f398_local0 = CoD.PCWidgetUtility.CanShowChat()
		end
	end
	return f398_local0
end
function ChatClientEnabled(f399_arg0)
	return ChatClientShow(f399_arg0) and Engine[@"hash_1C7BB554E5E89AAA"]()
end
function ChatClientIsAvailable(f400_arg0, f400_arg1, f400_arg2)
	return ChatClientEnabled(f400_arg2) and Engine[@"hash_4361B99D128C320C"]()
end
function ChatClientCurrentChatIsActive(f401_arg0)
	local f401_local0 = CoD.ChatClientUtility.GetCurrentChattingModel(f401_arg0)
	return f401_local0:get()
end
function ChatClientIsChatting(f402_arg0)
	return ChatClientEnabled(f402_arg0) and Engine[@"hash_37044CD4EF30776F"](f402_arg0)
end
function ChatClientIsChattingButEmpty(f403_arg0)
	return ChatClientEnabled(f403_arg0) and Engine[@"hash_39DC8AA985088170"](f403_arg0)
end
function ChatClientAnyChannelsAvailable(f404_arg0)
	return Engine[@"hash_4919956FE53BCA3C"]() ~= 0
end
function ChatClientFiltersAvailable(f405_arg0, f405_arg1, f405_arg2)
	return ChatClientIsAvailable(f405_arg0, f405_arg1, f405_arg2) and ChatClientOnlineChannelsAvailable(f405_arg2)
end
function ChatClientOnlineChannelsAvailable(f406_arg0)
	return Engine[@"hash_4919956FE53BCA3C"]() > 2
end
function ChatClientInputEnabled(f407_arg0)
	local f407_local0 = ChatClientEnabled(f407_arg0)
	if f407_local0 then
		f407_local0 = ChatClientIsAvailable(nil, nil, f407_arg0)
		if f407_local0 then
			f407_local0 = ChatClientAnyChannelsAvailable(f407_arg0)
		end
	end
	return f407_local0
end
function ChatClientInGameChatIsActive(f408_arg0)
	local f408_local0 = ChatClientEnabled(f408_arg0)
	if f408_local0 then
		f408_local0 = CoD.ChatClientUtility.GetInGameChattingModel(f408_arg0)
		f408_local0 = f408_local0:get() == true
	end
	return f408_local0
end
function ChatClientStaticAllowed(f409_arg0)
	local f409_local0 = CoD.ChatClientUtility.GetStaticChatAllowedModel(f409_arg0)
	return f409_local0:get()
end
function IsArabicSku()
	if Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][@"hash_28BDB4147F05F2A2"]) and Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][@"language_arabic"]) then
		return true
	else
		return false
	end
end
function IsChineseSku()
	if Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][@"language_traditionalchinese"]) and Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][@"language_simplifiedchinese"]) then
		return true
	else
		return false
	end
end
function IsJapaneseSku()
	if CoD.isPC and Engine[@"hash_7543F4AF0F31BA06"]() then
		return true
	elseif Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][@"hash_39A4194D08679C69"]) and Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][@"language_japanese"]) then
		return true
	else
		return false
	end
end
function IsRussianSku()
	if Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][@"hash_237F47E9EC48B533"]) and Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][@"language_russian"]) then
		return true
	else
		return false
	end
end
function IsPolishSku()
	if Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][0x4A6F14865F072B]) and Engine[@"islanguagesupportedinsku"](Enum[@"language_t"][@"language_polish"]) then
		return true
	else
		return false
	end
end
function IsCurrentLanguageEnglish()
	local f415_local0 = Dvar[@"loc_language"]:get()
	if f415_local0 == Enum[@"language_t"][@"language_english"] or f415_local0 == Enum[@"language_t"][@"hash_28BDB4147F05F2A2"] then
		return true
	else
		return false
	end
end
function IsCurrentTextLanguageEnglish()
	return CoDShared.IsCurrentTextLanguageEnglish()
end
function IsCurrentLanguageArabic()
	if Dvar[@"loc_language"]:get() == Enum[@"language_t"][@"language_arabic"] then
		return true
	else
		return false
	end
end
function IsCurrentLanguageKorean()
	if Dvar[@"loc_language"]:get() == Enum[@"language_t"][@"language_korean"] then
		return true
	else
		return false
	end
end
function IsCurrentLanguageTraditionalChinese()
	if Dvar[@"loc_language"]:get() == Enum[@"language_t"][@"language_traditionalchinese"] then
		return true
	else
		return false
	end
end
function IsCurrentLanguageFrench()
	if Dvar[@"loc_language"]:get() == Enum[@"language_t"][@"language_french"] then
		return true
	else
		return false
	end
end
function IsCurrentLanguageReversed()
	return Engine[@"iscurrentlanguagereversed"]()
end
function HighestMapReachedGreaterThan(f422_arg0, f422_arg1)
	local f422_local0 = CoD.GetPlayerStats(f422_arg0)
	local f422_local1 = f422_local0
	local f422_local2 = f422_local0.highestMapReached
	if f422_local2 then
		f422_local2 = f422_local1 and f422_local0.highestMapReached:get()
	end
	local f422_local3
	if f422_local2 == nil or f422_arg1 >= f422_local2 then
		f422_local3 = false
	else
		f422_local3 = true
	end
	return f422_local3
end
function IsGameInstalled()
	return CoDShared.IsGameInstalled()
end
function IsGameTrial()
	return Engine[@"hash_5CB675CA7856DA25"]()
end
function IsGameModeInstalled(f425_arg0, f425_arg1)
	if f425_arg1 == Enum[@"emodes"][@"mode_warzone"] then
		return true
	elseif Engine[@"hash_5CB675CA7856DA25"]() then
		return false
	else
		return not Engine[@"hash_77D47312EBA41751"]()
	end
end
function IsCurrentLanguageKoreanOrTraditionalChinese()
	local f426_local0 = IsCurrentLanguageKorean()
	if not f426_local0 then
		f426_local0 = IsCurrentLanguageTraditionalChinese()
	end
	return f426_local0
end
function ShouldShowLobbyAddControllerMessage(f427_arg0, f427_arg1)
	local f427_local0 = 1
	local f427_local1 = 0
	local f427_local2 = Engine[@"getglobalmodel"]()
	local f427_local3 = Engine[@"getmodel"](f427_local2, "lobbyRoot.numConnectedControllers")
	local f427_local4 = false
	if not f427_local3 then
		f427_local3 = Engine[@"createmodel"](f427_local2, "lobbyRoot.numConnectedControllers")
		Engine[@"setmodelvalue"](f427_local3, 0)
		f427_local4 = true
	end
	if f427_local4 then
		for f427_local5 = 0, Engine[@"getmaxcontrollercount"]() - 1, 1 do
			local f427_local8 = Engine[@"getxuid64"](f427_local5)
			local f427_local9 = Engine[@"createmodel"](Engine[@"getmodelforcontroller"](f427_local5), "isSignedIn")
			if f427_local8 and f427_local8 ~= 0 then
				Engine[@"setmodelvalue"](f427_local9, f427_local0)
				Engine[@"setmodelvalue"](f427_local3, Engine[@"getmodelvalue"](f427_local3) + 1)
			else
				Engine[@"setmodelvalue"](f427_local9, f427_local1)
			end
		end
	else
		local f427_local6 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f427_arg1.controller or f427_arg0), "isSignedIn")
		local f427_local7 = Engine[@"getmodelvalue"](f427_local3)
		local f427_local10 = Engine[@"getmodelvalue"](f427_local6)
		if f427_arg1.name == "controller_inserted" and f427_local10 == f427_local1 then
			Engine[@"setmodelvalue"](f427_local3, f427_local7 + 1)
			Engine[@"setmodelvalue"](f427_local6, f427_local0)
		elseif f427_arg1.name == "controller_removed" and f427_local10 == f427_local0 then
			Engine[@"setmodelvalue"](f427_local3, f427_local7 - 1)
			Engine[@"setmodelvalue"](f427_local6, f427_local1)
		end
	end
	local f427_local5 = Engine[@"getmodelvalue"](f427_local3)
	local f427_local10
	if f427_local5 ~= Engine[@"getusedcontrollercount"]() or f427_local5 >= Dvar[@"lobby_maxlocalplayers"]:get() then
		f427_local10 = false
	else
		f427_local10 = true
	end
	return f427_local10
end
function ShouldShowSplitscreenControllerText(f428_arg0, f428_arg1)
	if Engine[@"hash_5CB675CA7856DA25"]() and not LuaUtils.TrialAllowSplitscreen() then
		return false
	else
		local f428_local0 = Engine[@"getusedcontrollercount"]() < Dvar[@"lobby_maxlocalplayers"]:get()
		local f428_local1 = LobbyData.GetLobbyMenuByID(Engine[@"getlobbyuiscreen"]())
		return f428_local0 and Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_host"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]) < f428_local1[@"maxclients"]
	end
end
function ZMDoubleXPWidgetVisible(f429_arg0)
	local f429_local0 = IsZombies()
	if f429_local0 then
		if not IsLAN() then
			f429_local0 = not CoD.ModelUtility.IsModelValueEqualTo(f429_arg0, "doubleXPTimeRemaining", 0)
		else
			f429_local0 = false
		end
	end
	if IsInGame() then
		return f429_local0
	else
		local f429_local1
		if Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_game"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_all"]) <= 1 and Engine[@"getlobbyclientcount"](Enum[@"lobbymodule"][@"lobby_module_client"], Enum[@"lobbytype"][@"lobby_type_private"], Enum[@"lobbyclientfiltertype"][@"lobby_client_filter_type_local"]) <= 1 then
			f429_local1 = false
		else
			f429_local1 = true
		end
	end
	return f429_local0 and not f429_local1
end
function EnableCombatRecordCompare(f430_arg0)
	return true
end
function IsMultiplayerCombatRecordMode()
	return CoD.GetCombatRecordMode() == Enum[@"emodes"][@"mode_multiplayer"]
end
function IsZombiesCombatRecordMode()
	return CoD.GetCombatRecordMode() == Enum[@"emodes"][@"mode_zombies"]
end
function IsComparingStats(f433_arg0)
	local f433_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f433_arg0), "CombatRecordComparing")
	if not f433_local0 or not Engine[@"getmodelvalue"](f433_local0) then
		return false
	else
		local f433_local1 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "OtherPlayerStats.InProgress")
		if not f433_local1 or Engine[@"getmodelvalue"](f433_local1) then
			return false
		else
			local f433_local2 = Engine[@"getmodel"](Engine[@"getglobalmodel"](), "OtherPlayerStats.Success")
			if not f433_local2 or not Engine[@"getmodelvalue"](f433_local2) then
				return false
			else
				return true
			end
		end
	end
end
function IsCombatRecordForRemotePlayer()
	return CoD.CombatRecordOtherPlayerStats
end
function IsStorageValueAtLeast(f435_arg0, f435_arg1, f435_arg2, f435_arg3)
	local f435_local0 = CoD.SafeGetModelValue(DataSources.StorageGlobal.getModel(f435_arg0), f435_arg1)
	if f435_local0 then
		local f435_local1 = StorageLookup(f435_arg0, f435_arg2, f435_local0)
		return f435_local1 and f435_arg3 <= tonumber(f435_local1)
	else
		return false
	end
end
function ElementHasText(f436_arg0, f436_arg1)
	if f436_arg0[f436_arg1] and f436_arg0[f436_arg1].getText then
		local f436_local0 = f436_arg0[f436_arg1]:getText()
		local f436_local1 = f436_local0
		local f436_local2
		if f436_local0 == "" or f436_local0 == Engine[@"hash_4F9F1239CFD921FE"](0x0) then
			f436_local2 = false
		else
			f436_local2 = f436_local1 and true
		end
		return f436_local2
	else
	end
end
function DoesPlayerHaveExtraSlotsItem(f437_arg0)
	if Dvar[@"hash_CF99BC22D677A8D"]:exists() and Dvar[@"hash_CF99BC22D677A8D"]:get() then
		return Engine[@"hash_5352DC095BBB2A45"](f437_arg0, tostring(Dvar[@"hash_CF99BC22D677A8D"]:get())) > 0
	else
		return false
	end
end
function CursorInputEnabledForBuild(f438_arg0)
	return Engine[@"isusingcursor"]()
end
function IsFreeCursorActive(f439_arg0)
	local f439_local0 = Engine[@"isusingcursor"]()
	if f439_local0 then
		f439_local0 = Dvar[@"ui_usingfreecursor"]:get()
		if f439_local0 then
			f439_local0 = DataSources.FreeCursor.getModel(f439_arg0)
			f439_local0 = f439_local0.usingCursorInput:get()
		end
	end
	return f439_local0
end
function IsFreeCursorActiveAndVisible(f440_arg0)
	if Engine[@"isinputlocked"](f440_arg0) == false then
		return false
	end
	local f440_local0 = IsFreeCursorActive(f440_arg0)
	if f440_local0 then
		f440_local0 = DataSources.FreeCursor.getModel(f440_arg0)
		f440_local0 = f440_local0.hidden:get() == 0
	end
	return f440_local0
end
function AnyContextualButtonPrompts(f441_arg0, f441_arg1)
	local f441_local0 = f441_arg0:getModel()
	if f441_local0 then
		f441_local0 = f441_arg0:getModel()
		f441_local0 = f441_local0.buttonPrompts
		if f441_local0 then
			f441_local0 = f441_arg0:getModel()
			f441_local0 = f441_local0.buttonPrompts:get()
		end
	end
	if f441_local0 then
		for f441_local1 = 0, Enum[@"luibutton"][@"lui_button_count"] - 1, 1 do
			local f441_local4 = f441_local0[f441_local1]
			if f441_local4 and f441_local4:get() ~= Enum[@"luibuttonpromptstates"][@"flag_hide_prompts"] then
				local f441_local5 = f441_local4.flags
				local f441_local6 = f441_local4.Label
				local f441_local7 = IsMouseOrKeyboard(f441_arg1)
				if f441_local7 then
					f441_local7 = f441_local1 == Enum[@"luibutton"][@"lui_key_xba_pscross"]
				end
				if not f441_local7 and f441_local5 and f441_local6 and f441_local6:get() ~= "" and f441_local5:get() & Enum[@"luibuttonpromptflags"][@"bpf_contextual"] ~= 0 then
					return true
				end
			end
		end
	end
	return false
end
function AmICarryingBriefcase(f442_arg0)
	return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f442_arg0, "CPGamePlayBundleData", "briefcaseClient", Engine[@"getpredictedclientnum"](f442_arg0))
end
function IsSignedIntoUno(f443_arg0)
	return Engine[@"hash_24A9D1DAC0556BB1"](f443_arg0)
end
function IsDesiredFrameWidget(f444_arg0, f444_arg1, f444_arg2)
	if f444_arg1 and f444_arg1.framedWidget and f444_arg1.framedWidget.idForMenuList == f444_arg2 then
		return true
	else
		return false
	end
end
function ShouldDisplayContextualMenuInActiveCamoList(f445_arg0, f445_arg1)
	local f445_local0 = CoD.GetMouseFocus(f445_arg0)
	local f445_local1
	if f445_arg1 then
		f445_local1 = string.match(f445_arg1.id, "ActiveThemeSlot")
		if not f445_local1 then
			local f445_local2 = f445_arg1
			if f445_arg1.id ~= "horizontalCounter" then
				local f445_local3 = f445_local0
				if f445_local0.id == "leftArrowBtn" or f445_local0.id == "rightArrowBtn" then
					f445_local1 = false
				else
					f445_local1 = f445_local3 and f445_local2 and true
				end
			end
			f445_local1 = false
		end
	else
		local f445_local2 = f445_arg1
		if f445_arg1.id ~= "horizontalCounter" then
			local f445_local3 = f445_local0
			if f445_local0.id == "leftArrowBtn" or f445_local0.id == "rightArrowBtn" then
				f445_local1 = false
			else
				f445_local1 = f445_local3 and f445_local2 and true
			end
		end
		f445_local1 = false
	end
	return f445_local1
end
