function GetMemberStatusFromElement(f1_arg0, f1_arg1)
	return Engine[0x614D394F6F9A18D](f1_arg0:getModel(f1_arg1, "memberStatus"))
end
function GetMemberStatusFromModel(f2_arg0)
	return Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f2_arg0, "memberStatus"))
end
function GetUpgradableItemRef(f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = Engine[0x40E824FE270E174](f3_arg1:getModel(), "itemIndex")
	if f3_local0 and Engine[0x614D394F6F9A18D](f3_local0) ~= 0 then
		local f3_local1 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f3_arg1:getModel(), "ref"))
		local f3_local2 = Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f3_arg1:getModel(), "weaponSlot"))
	end
end
function IsCACItemLockedHelper(f4_arg0, f4_arg1, f4_arg2)
	local f4_local0 = CoD.perController[f4_arg2].classModel
	local f4_local1 = CoD.perController[f4_arg2].weaponCategory
	local f4_local2 = nil
	local f4_local3 = f4_arg1.itemIndex
	local f4_local4 = CoD.PrestigeUtility.GetPermanentUnlockMode()
	if not f4_local3 then
		f4_local2 = f4_arg1:getModel(f4_arg2, "itemIndex")
		if f4_local2 then
			f4_local3 = Engine[0x614D394F6F9A18D](f4_local2)
		end
	end
	if f4_local3 then
		if not f4_local1 then
			f4_local1 = Engine[0xB8891E0F105C51F](f4_local3, f4_local4)
		end
		if f4_local0 and f4_local1 and (LUI.startswith(f4_local1, "primaryattachment") or LUI.startswith(f4_local1, "secondaryattachment")) then
			local f4_local5 = "primary"
			if LUI.startswith(f4_local1, "secondaryattachment") then
				f4_local5 = "secondary"
			end
			local f4_local6 = Engine[0x40E824FE270E174](f4_local0, f4_local5 .. ".itemIndex")
			if f4_local6 then
				return Engine[0x758EBFCB1826DAD](f4_arg2, Engine[0x614D394F6F9A18D](f4_local6), f4_local3, f4_local4)
			end
		end
		return Engine[0x191C1637A229078](f4_arg2, f4_local3, f4_local4)
	else
		return false
	end
end
function GetWeaponSlotModel(f5_arg0, f5_arg1)
	local f5_local0 = CoD.SafeGetModelValue(f5_arg0:getModel(), "weaponSlot")
	if not f5_local0 then
		return f5_arg0.weaponSlot
	else
		return f5_local0
	end
end
function WeaponAttributeCompare(f6_arg0)
	local f6_local0 = {}
	for f6_local4 in string.gmatch(f6_arg0, "[^,]+") do
		table.insert(f6_local0, tonumber(f6_local4))
	end
	if #f6_local0 == 2 then
		return f6_local0[1] < f6_local0[2]
	else
		return false
	end
end
function GetNumberOfAttachmentsForSlot(f7_arg0, f7_arg1)
	if not f7_arg1 then
		return 0
	end
	local f7_local0 = CoD.perController[f7_arg1].classModel
	if f7_local0 then
		local f7_local1 = Engine[0x40E824FE270E174](f7_local0, f7_arg0)
		if f7_local1 then
			local f7_local2 = Engine[0x40E824FE270E174](f7_local1, "itemIndex")
			if f7_local2 then
				local f7_local3 = Engine[0x614D394F6F9A18D](f7_local2)
				if f7_local3 ~= 0 then
					return Engine[0xF8ECCDE64F061E1](f7_local3) - 1
				end
			end
		end
	end
	return 0
end
function SearchForTakeTwoGadgetMod(f8_arg0, f8_arg1)
	if f8_arg0 then
		for f8_local4, f8_local5 in ipairs(f8_arg1) do
			local f8_local6 = Engine[0x40E824FE270E174](f8_arg0, f8_local5)
			if f8_local6 then
				local f8_local3 = Engine[0x40E824FE270E174](f8_local6, "itemIndex")
				if f8_local3 and Engine[0x614D394F6F9A18D](f8_local3) == 1 then
					return true
				end
			end
		end
	end
	return false
end
function IsFilmReadyForPlayback()
	local f9_local0 = Engine[0x23AF33F30C69410](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]))
	if f9_local0 and f9_local0.readyForPlayback then
		return true
	else
		return false
	end
end
function GetDemoContextMode()
	local f10_local0 = Engine[0x40E824FE270E174](Engine[0x8DF2E5447F384B9](), "demo.contextMode")
	if f10_local0 then
		return Engine[0x614D394F6F9A18D](f10_local0)
	else
		return Enum[0xAAAF4C9531ECF5E][0x4FDF8441F0D7CD4]
	end
end
function CheckMemento(f11_arg0, f11_arg1)
	local f11_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f11_arg0), "zmInventory." .. CoD.ZombieUtility.CLIENTFIELD_CHECK_BASE .. f11_arg1 .. CoD.ZombieUtility.MEMENTO_SUFFIX)
	return f11_local0 and Engine[0x614D394F6F9A18D](f11_local0) == 1
end
function ShowPurchasableMap(f12_arg0, f12_arg1)
	if not CoD.BaseUtility.IsKnownDLC(Engine[0x943893A16399DCF](f12_arg1)) then
		return false
	elseif not IsGameModeInstalled(f12_arg0, Engine[0x3EAC408F958FF05]()) then
		return false
	else
		return Engine[0xA63E42B2FB6EC02]() == Enum[0xC84D3E505F1444][0xE99F41098B71960]
	end
end
function IsObjectiveVisibleForMyTeam(f13_arg0, f13_arg1)
	local f13_local0 = Engine[0x17BB326A8B42F2E](f13_arg0, f13_arg1, Engine[0x2C6B07FD023877B](f13_arg0, Engine[0x869E84B826141D2](f13_arg0)))
	if not f13_local0 then
		f13_local0 = CoD.IsShoutcaster(f13_arg0)
	end
	return f13_local0
end
function DoesHaveFileshareOptions(f14_arg0)
	if CoD.FileshareUtility.GetIsGroupsMode(f14_arg0) then
		if HasAdminPrivilege(f14_arg0, Enum.GroupAdminPrivilege.GROUP_ADMIN_PRIVILEGE_FAVORITE_SHOWCASE_CONTENT) then
			return true
		elseif HasAdminPrivilege(f14_arg0, Enum.GroupAdminPrivilege.GROUP_ADMIN_PRIVILEGE_EDIT_FEATURED_CONTENT) then
			return true
		end
	end
	local f14_local0 = FileshareIsLocalCategory(f14_arg0)
	local f14_local1 = CoD.FileshareUtility.GetSelectedItemProperty("fileAuthorXuid") == Engine[0x93B19E01B1FD1C7](f14_arg0)
	if f14_local0 and CoD.FileshareUtility.GetCurrentCategory() == "clip_private" then
		return true
	elseif not f14_local0 then
		if FilesshareCanShowVoteOptions(f14_arg0) then
			return true
		elseif FileshareCanDownloadItem(f14_arg0) then
			return true
		elseif not f14_local1 then
			return true
		elseif FileshareCanShowShowcaseManager(f14_arg0) then
			return true
		end
	end
	if FileshareCanDeleteItem(f14_arg0) then
		return true
	end
	return false
end
