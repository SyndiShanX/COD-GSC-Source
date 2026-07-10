CoD.WeaponAttachmentsUtility = {}
CoD.WeaponAttachmentsUtility.Spacer = 10
CoD.WeaponAttachmentsUtility.ContainerPadding = 25
CoD.WeaponAttachmentsUtility.UberAttachmentPadding = 20
CoD.WeaponAttachmentsUtility.WeaponAttachmentListTable = {
	primary = {
		weaponRefHash = 0x0,
		attachmentList = {},
		isArenaMode = false,
	},
	secondary = {
		weaponRefHash = 0x0,
		attachmentList = {},
		isArenaMode = false,
	},
}
CoD.WeaponAttachmentsUtility.WeaponAttachmentGroupNames = {
	{
		attachmentGroup = Enum[0x7420BCDBDE17A84][0x6AC43DB9B6634DA],
		name = 0x13BE4995FD8DBF8,
	},
	{
		attachmentGroup = Enum[0x7420BCDBDE17A84][0x2FDACB5DC7958DD],
		name = 0x49BD5D27E45D8A4,
	},
	{
		attachmentGroup = Enum[0x7420BCDBDE17A84][0x2701CB609E58337],
		name = 0x7DBA1D8EA36A999,
	},
	{
		attachmentGroup = Enum[0x7420BCDBDE17A84][0x6EE211053211305],
		name = 0xCD6625B5DAFD45F,
	},
	{
		attachmentGroup = Enum[0x7420BCDBDE17A84][0x4877F405CA40935],
		name = 0x49BD5D27E45D8A4,
	},
}
CoD.WeaponAttachmentsUtility.AttachmentTierType = LuaEnum.createEnum("NONE", "BASE", "UPGRADE")
CoD.WeaponAttachmentsUtility.GetBaseAttachmentRef = function(f1_arg0, f1_arg1)
	if f1_arg1 and f1_arg0.attachmentUpgrades then
		for f1_local3, f1_local4 in ipairs(f1_arg0.attachmentUpgrades) do
			if f1_local4[0xBF43C7495E3788C] == f1_arg1 then
				return f1_local4[0x7EB5A64A49DE165]
			end
		end
	end
end
CoD.WeaponAttachmentsUtility.GetUpgradedAttachmentRef = function(f2_arg0, f2_arg1)
	if f2_arg1 and f2_arg0.attachmentUpgrades then
		for f2_local3, f2_local4 in ipairs(f2_arg0.attachmentUpgrades) do
			if f2_local4[0x7EB5A64A49DE165] == f2_arg1 then
				return f2_local4[0xBF43C7495E3788C]
			end
		end
	end
end
CoD.WeaponAttachmentsUtility.IsAttachmentUpgrade = function(f3_arg0, f3_arg1)
	return CoD.WeaponAttachmentsUtility.GetBaseAttachmentRef(f3_arg0, f3_arg1) ~= nil
end
CoD.WeaponAttachmentsUtility.DoesAttachmentHaveUpgrade = function(f4_arg0, f4_arg1)
	return CoD.WeaponAttachmentsUtility.GetUpgradedAttachmentRef(f4_arg0, f4_arg1) ~= nil
end
CoD.WeaponAttachmentsUtility.GetBaseAttachmentIndex = function(f5_arg0, f5_arg1, f5_arg2)
	return Engine[0xB99CB645DEAEB92](f5_arg0, Engine[0x58B87258E0EBAD0](f5_arg1), f5_arg2)
end
CoD.WeaponAttachmentsUtility.GetAttachmentIndexForWeaponAttachmentRef = function(f6_arg0, f6_arg1, f6_arg2)
	return Engine[0xB99CB645DEAEB92](f6_arg0, Engine[0x58B87258E0EBAD0](f6_arg1), f6_arg2)
end
CoD.WeaponAttachmentsUtility.GetDisplayNameForAttachmentGroup = function(f7_arg0)
	for f7_local3, f7_local4 in ipairs(CoD.WeaponAttachmentsUtility.WeaponAttachmentGroupNames) do
		if f7_local4.attachmentGroup == f7_arg0 then
			return f7_local4.name
		end
	end
	return 0x49BD5D27E45D8A4
end
CoD.WeaponAttachmentsUtility.GetAttachmentTierType = function(f8_arg0, f8_arg1)
	local f8_local0 = CoD.WeaponAttachmentsUtility.AttachmentTierType.NONE
	if CoD.WeaponAttachmentsUtility.DoesAttachmentHaveUpgrade(f8_arg0, f8_arg1) then
		f8_local0 = CoD.WeaponAttachmentsUtility.AttachmentTierType.BASE
	elseif CoD.WeaponAttachmentsUtility.IsAttachmentUpgrade(f8_arg0, f8_arg1) then
		f8_local0 = CoD.WeaponAttachmentsUtility.AttachmentTierType.UPGRADE
	end
	return f8_local0
end
CoD.WeaponAttachmentsUtility.GetAttachmentCautionText = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, f9_arg5)
	local f9_local0 = f9_arg1.classNum:get()
	local f9_local1 = 0x0
	local f9_local2 = CoD.CACUtility.GetMutuallyExclusiveAttachments(f9_arg0, f9_local0, f9_arg2, f9_arg4, f9_arg5)
	if #f9_local2 > 0 then
		local f9_local3 = Engine[0x174D9B6F1E719ED](f9_arg3, f9_local2[1].attachmentIndex, f9_arg5)
		if not Engine[0x689E378B0101DCE](f9_arg3, f9_arg4) or not Engine[0x689E378B0101DCE](f9_arg3, f9_local2[1].attachmentIndex) then
			if Engine[0x37522AE910C327](f9_local3, f9_arg5) == Enum[0x7420BCDBDE17A84][0x6EE211053211305] then
				f9_local1 = 0x91F59C33FE184A9
			else
				f9_local1 = 0x73A7619DEA60089
			end
		end
	end
	return f9_local1
end
CoD.WeaponAttachmentsUtility.SetWeaponInfo = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = CoD.BaseUtility.GetMenuLoadoutSlot(f10_arg2)
	local f10_local1 = CoD.BaseUtility.GetMenuModel(f10_arg2)
	if f10_arg0.WeaponLevel and f10_local1[f10_local0] then
		f10_arg0.WeaponLevel:setModel(f10_local1[f10_local0], f10_arg1)
	end
end
CoD.WeaponAttachmentsUtility.UpdateHorizontalCount = function(f11_arg0, f11_arg1, f11_arg2)
	local f11_local0, f11_local1, f11_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f11_arg0)
	local f11_local3 = CoD.CACUtility.EmptyItemIndex
	local f11_local4 = CoD.BaseUtility.GetMenuAttachmentFilter(f11_arg0)
	local f11_local5 = 0
	if f11_arg0._inArmory then
		f11_local1 = CoD.BaseUtility.GetMenuSessionMode(f11_arg0)
		f11_local3 = f11_arg0._weaponItemIndex
		if f11_arg1._isOptic == true then
			f11_local4 = "optic"
		else
			f11_local4 = false
		end
		if CoD.CACUtility.EmptyItemIndex < Engine[0xEF453A0A31D191A](f11_local3, f11_local1) then
			local f11_local6 = 1
		end
		f11_local5 = f11_local6 or 0
	else
		local f11_local7, f11_local8, f11_local9 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f11_arg0)
		f11_local1 = f11_local8
		f11_local3 = f11_local7[f11_local9].itemIndex:get()
	end
	if f11_local1 and CoD.CACUtility.EmptyItemIndex < f11_local3 then
		local f11_local7 = Engine[0x2964239F2151F6F](f11_local3, f11_local1)
		if f11_local4 == "optic" then
			f11_arg1:setHorizontalCount(f11_local7[0xA9C48738BFE4409] or 0)
		else
			f11_arg1:setHorizontalCount(f11_local7[0x6E3B76844E6637] + f11_local5 or 0)
		end
	end
end
CoD.WeaponAttachmentsUtility.GetClipCountAndSizeForWeapon = function(f12_arg0, f12_arg1)
	if f12_arg0 then
		local f12_local0 = ""
		for f12_local4, f12_local5 in ipairs(f12_arg1) do
			if f12_local5 then
				f12_local0 = LUI.appendStringWithDelimiter(f12_local0, f12_local5, "+")
			end
		end
		return Engine[0x9268F8D899F10DF](f12_arg0, f12_local0)
	else
		return 0, 0
	end
end
CoD.WeaponAttachmentsUtility.UpdateEquippedWeaponAttachmentAttributes = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	local f13_local0 = Enum[0x4894073C9168D02][0x5B7E5FC5552F23A]
	local f13_local1 = Enum[0x4894073C9168D02][0x115E22D013F28C1]
	local f13_local2 = Enum[0x4894073C9168D02][0x51BABA455D2DC80]
	local f13_local3 = Enum[0x4894073C9168D02][0x1A6E182D6FE3472]
	local f13_local4 = Enum[0x4894073C9168D02][0x5083C82F930E500]
	local f13_local5 = Enum[0x4894073C9168D02][0x295ABB48F2C6284]
	local f13_local6 = f13_arg0[f13_arg1 .. ".itemIndex"]:get()
	local f13_local7 = Engine[0xB98952F69D937F9](f13_local6, Enum[0x6EB546760F890D2][0x569E84652131CD7], f13_arg3)
	local f13_local8 = {
		damage = 0,
		range = 0,
		fireRate = 0,
		accuracy = 0,
		magCount = 0,
		magSize = 0,
	}
	local f13_local9 = CoD.CACUtility.GetAttachmentListForSlot(f13_arg1)
	local f13_local10 = {}
	for f13_local21, f13_local22 in ipairs(f13_local9) do
		local f13_local23 = f13_arg0[f13_local22].itemIndex:get()
		if f13_local22 ~= f13_arg2 and f13_local23 > CoD.CACUtility.EmptyItemIndex then
			local f13_local14 = Engine[0x2E29FB421AD554B](f13_local6, f13_local23, f13_arg3)
			table.insert(f13_local10, f13_local14)
			local f13_local15 = Engine[0x2DCF0973239E909](CoD.weaponAttributes, f13_local2, f13_local0, f13_local14, f13_local1, f13_local7)
			local f13_local16 = Engine[0x2DCF0973239E909](CoD.weaponAttributes, f13_local3, f13_local0, f13_local14, f13_local1, f13_local7)
			local f13_local17 = Engine[0x2DCF0973239E909](CoD.weaponAttributes, f13_local4, f13_local0, f13_local14, f13_local1, f13_local7)
			local f13_local18 = Engine[0x2DCF0973239E909](CoD.weaponAttributes, f13_local5, f13_local0, f13_local14, f13_local1, f13_local7)
			local f13_local19 = f13_local8.damage
			local f13_local20
			if not f13_local15 then
				f13_local20 = 0
				if not f13_local20 then
				else
					f13_local8.damage = f13_local19 + f13_local20
					f13_local19 = f13_local8.range
					if not f13_local16 then
						f13_local20 = 0
						if not f13_local20 then
						else
							f13_local8.range = f13_local19 + f13_local20
							f13_local19 = f13_local8.fireRate
							if not f13_local17 then
								f13_local20 = 0
								if not f13_local20 then
								else
									f13_local8.fireRate = f13_local19 + f13_local20
									f13_local19 = f13_local8.accuracy
									if not f13_local18 then
										f13_local20 = 0
										if not f13_local20 then
										else
											f13_local8.accuracy = f13_local19 + f13_local20
										end
									end
									f13_local20 = f13_local18
								end
							end
							f13_local20 = f13_local17
						end
					end
					f13_local20 = f13_local16
				end
			end
			f13_local20 = f13_local15
		end
	end
	f13_local8.magCount, f13_local8.magSize = CoD.WeaponAttachmentsUtility.GetClipCountAndSizeForWeapon(f13_local7, f13_local10)
	return f13_local10, f13_local8
end
CoD.WeaponAttachmentsUtility.GetWeaponAttachmentAttributes = function(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4)
	local f14_local0 = Enum[0x4894073C9168D02][0x5B7E5FC5552F23A]
	local f14_local1 = Enum[0x4894073C9168D02][0x115E22D013F28C1]
	local f14_local2 = Engine[0xB98952F69D937F9](f14_arg0, Enum[0x6EB546760F890D2][0x569E84652131CD7], f14_arg2)
	local f14_local3 = CoD.CACUtility.GetUnlockableItemInfo(f14_arg0, f14_arg2)
	local f14_local4 = f14_local3.attributesTable
	if f14_local3.attributesTableZM and f14_arg2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f14_local4 = f14_local3.attributesTableZM
	end
	local f14_local5 = function(f15_arg0, f15_arg1)
		local f15_local0 = f14_local4 and f14_local4[f15_arg0] or 0
		local f15_local1 = Engine[0x2DCF0973239E909](CoD.weaponAttributes, f15_arg1, f14_local0, f14_arg1, f14_local1, f14_local2) or 0
		local f15_local2 = false
		for f15_local6, f15_local7 in ipairs(f14_arg3) do
			if f15_local7 == f14_arg1 then
				f15_local2 = true
				break
			end
		end
		f15_local3 = f15_local0 + f14_arg4[f15_arg0]
		if not f15_local2 then
			f15_local3 = f15_local3 + f15_local1
		end
		return f15_local0 .. "," .. f15_local3
	end
	local f14_local6 = {
		damage = f14_local5("damage", Enum[0x4894073C9168D02][0x51BABA455D2DC80]),
		range = f14_local5("range", Enum[0x4894073C9168D02][0x1A6E182D6FE3472]),
		fireRate = f14_local5("fireRate", Enum[0x4894073C9168D02][0x5083C82F930E500]),
		accuracy = f14_local5("accuracy", Enum[0x4894073C9168D02][0x295ABB48F2C6284]),
		magCount = 0,
		magSize = 0,
		uberName = 0x0,
		uberImage = 0x0,
	}
	local f14_local7 = LUI.ShallowCopy(f14_arg3)
	for f14_local11, f14_local12 in ipairs(f14_arg3) do
		if f14_local12 == f14_arg1 then
			table.remove(f14_local7, f14_local11)
			break
		end
	end
	if f14_arg2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		if #f14_local7 < CoD.ZMLoadoutUtility.MaxArmoryAttachments then
			table.insert(f14_local7, f14_arg1)
		end
	else
		table.insert(f14_local7, f14_arg1)
	end
	if f14_arg1 == "extclip2" then
		f14_local8 = false
		for f14_local12, f14_local13 in ipairs(f14_arg3) do
			if f14_local13 == "extclip" then
				f14_local8 = true
				break
			end
		end
		if not f14_local8 and f14_arg1 ~= "extclip" then
			table.insert(f14_local7, "extclip")
		end
	end
	if f14_local4 then
		f14_local8, f14_local9 = CoD.WeaponAttachmentsUtility.GetClipCountAndSizeForWeapon(f14_local2, f14_local7)
		f14_local10 = f14_local8 - f14_local4.magCount
		f14_local11 = f14_local9 - f14_local4.magSize
		f14_local12 = ""
		local f14_local13 = ""
		f14_local12 = "," .. f14_local10 .. ""
		f14_local13 = "," .. f14_local11 .. ""
		f14_local6.magCount = f14_local4.magCount .. f14_local12
		f14_local6.magSize = f14_local4.magSize .. f14_local13
		f14_local6.uberName = f14_local4.uberName
		f14_local6.uberImage = f14_local4.uberImage
	end
	return f14_local6
end
CoD.WeaponAttachmentsUtility.GetUberAttachmentWidget = function(f16_arg0, f16_arg1)
	local f16_local0 = CoD.UberAttachmentSlot
	if f16_arg0 and f16_arg0.menu then
		local f16_local1 = CoD.BaseUtility.GetMenuAttachmentFilter(f16_arg0.menu)
		if f16_local1 and f16_local1 == "attachment" then
			f16_local0 = CoD.UberOperatorModContainer
		end
	end
	return f16_local0
end
CoD.WeaponAttachmentsUtility.ReorderAttachmentsToRemoveRestricted = function(f17_arg0)
	local f17_local0 = 1
	local f17_local1 = 1
	local f17_local2 = table.getn(f17_arg0)
	while f17_local0 < f17_local2 and f17_local1 <= f17_local2 do
		while f17_local0 < f17_local2 and not f17_arg0[f17_local0].models.isRestricted do
			f17_local0 = f17_local0 + 1
		end
		if f17_local1 <= f17_local0 then
			f17_local1 = f17_local0 + 1
			while f17_local1 <= f17_local2 and (f17_arg0[f17_local1].models.isRestricted or f17_arg0[f17_local1].models.tierType ~= CoD.WeaponAttachmentsUtility.AttachmentTierType.NONE) do
				f17_local1 = f17_local1 + 1
			end
			if f17_local0 < f17_local2 and f17_local1 <= f17_local2 then
				local f17_local3 = f17_arg0[f17_local1]
				f17_arg0[f17_local1] = f17_arg0[f17_local0]
				f17_arg0[f17_local0] = f17_local3
				f17_local0 = f17_local0 + 1
			end
		end
	end
	while f17_local0 < f17_local2 and not f17_arg0[f17_local0].models.isRestricted do
		f17_local0 = f17_local0 + 1
	end
	if f17_local1 <= f17_local0 then
		f17_local1 = f17_local0 + 1
		while f17_local1 <= f17_local2 and (f17_arg0[f17_local1].models.isRestricted or f17_arg0[f17_local1].models.tierType ~= CoD.WeaponAttachmentsUtility.AttachmentTierType.NONE) do
			f17_local1 = f17_local1 + 1
		end
		if f17_local0 < f17_local2 and f17_local1 <= f17_local2 then
			local f17_local3 = f17_arg0[f17_local1]
			f17_arg0[f17_local1] = f17_arg0[f17_local0]
			f17_arg0[f17_local0] = f17_local3
			f17_local0 = f17_local0 + 1
		end
	end
end
CoD.WeaponAttachmentsUtility.GetWeaponAttachmentList = function(f18_arg0, f18_arg1, f18_arg2)
	local f18_local0 = {}
	local f18_local1, f18_local2, f18_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f18_arg1.menu)
	local f18_local4 = CoD.BaseUtility.GetMenuLoadoutListItemSlot(f18_arg1.menu)
	local f18_local5 = f18_local1[f18_local3].itemIndex:get()
	local f18_local6 = Engine[0x2964239F2151F6F](f18_local5, f18_local2)
	local f18_local7 = Engine[0xF8ECCDE64F061E1](f18_local5, f18_local2)
	local f18_local8 = f18_local1[f18_local3].numGunfightersEquipped:get()
	local f18_local9, f18_local10 = CoD.WeaponAttachmentsUtility.UpdateEquippedWeaponAttachmentAttributes(f18_local1, f18_local3, f18_local4, f18_local2)
	for f18_local11 = 1, f18_local7 - 1, 1 do
		local f18_local14 = Engine[0x174D9B6F1E719ED](f18_local5, f18_local11, f18_local2)
		if CoD.CACUtility.EmptyItemIndex < f18_local14 then
			local f18_local15 = Engine[0x2E29FB421AD554B](f18_local5, f18_local11, f18_local2)
			local f18_local16 = Engine[0xD0520F158FE13E9](f18_local5, f18_local11, f18_local2)
			local f18_local17 = Engine[0xA48813350B43601](f18_local5, f18_local11, f18_local2)
			local f18_local18 = Engine[0x8FD38AB8CA1FA21](f18_local5, f18_local11, f18_local2)
			local f18_local19 = Engine[0x55B3AC1DC0E0003](f18_local5, f18_local11, f18_local2)
			local f18_local20 = Engine[0x1F444BD03EB910E](f18_local5, f18_local14, f18_local2)
			local f18_local21 = Engine[0x37522AE910C327](f18_local14, f18_local2)
			local f18_local22 = CoD.WeaponAttachmentsUtility.GetWeaponAttachmentAttributes(f18_local5, f18_local15, f18_local2, f18_local9, f18_local10)
			local f18_local23 = CoD.CACUtility.EmptyItemIndex
			local f18_local24 = CoD.WeaponAttachmentsUtility.GetBaseAttachmentRef(f18_local6, f18_local15)
			if f18_local24 then
				f18_local23 = CoD.WeaponAttachmentsUtility.GetAttachmentIndexForWeaponAttachmentRef(f18_local5, f18_local24, f18_local2)
			end
			local f18_local25 = CoD.CACUtility.EmptyItemIndex
			local f18_local26 = CoD.WeaponAttachmentsUtility.GetUpgradedAttachmentRef(f18_local6, f18_local15)
			if f18_local26 then
				f18_local25 = CoD.WeaponAttachmentsUtility.GetAttachmentIndexForWeaponAttachmentRef(f18_local5, f18_local26, f18_local2)
			end
			local f18_local27 = CoD.WeaponAttachmentsUtility.IsAttachmentUpgrade(f18_local6, f18_local15)
			local f18_local28 = f18_local21 == Enum[0x7420BCDBDE17A84][0x6EE211053211305]
			local f18_local29 = Engine[0x93ABA160B5D7323](f18_local5, Engine[0x58B87258E0EBAD0](f18_local15), false)
			local f18_local30 = nil
			if f18_local29 then
				f18_local30 = CoD.FillerWidget140_90
			elseif f18_local27 then
				f18_local30 = CoD.AttachmentUpgradeSlotContainer
			elseif f18_local28 then
				if f18_local2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
					f18_local30 = CoD.WeaponAttachmentsUtility.GetUberAttachmentWidget
				else
					f18_local30 = CoD.UberAttachmentSlot
				end
			end
			table.insert(f18_local0, {
				models = {
					attachmentRef = f18_local15,
					displayName = f18_local16,
					displayNameShort = f18_local17,
					image = f18_local18,
					itemIndex = f18_local11,
					weaponIndex = f18_local5,
					attachmentIndex = f18_local14,
					attachmentGroup = f18_local21,
					weaponSlot = f18_local3,
					isUpgradedAttachment = f18_local27,
					baseAttachmentItemIndex = f18_local23,
					tierType = CoD.WeaponAttachmentsUtility.GetAttachmentTierType(f18_local6, f18_local15),
					isUberAttachment = f18_local28,
					upgradedAttachmentIndex = f18_local25,
					weaponAttributes = f18_local22,
					description = Engine[0xF9F1239CFD921FE](f18_local19),
					cautionText = CoD.WeaponAttachmentsUtility.GetAttachmentCautionText(f18_arg0, f18_local1, f18_local4, f18_local5, f18_local11, f18_local2),
					stateLeft = true,
					attachmentInFocus = false,
					isRestricted = f18_local29,
				},
				properties = {
					baseAttachmentItemIndex = f18_local23,
					equipSound = f18_local20 and f18_local20.equipSound,
					unequipSound = f18_local20 and f18_local20.unequipSound,
					customWidgetOverride = f18_local30,
				},
			})
		end
	end
	if LuaUtils.IsArenaMode() then
		CoD.WeaponAttachmentsUtility.ReorderAttachmentsToRemoveRestricted(f18_local0)
	end
	return f18_local0
end
DataSources.WeaponAttachments = ListHelper_SetupDataSource(
	"WeaponAttachments",
	function(f19_arg0, f19_arg1, f19_arg2)
		local f19_local0, f19_local1, f19_local2, f19_local3, f19_local4, f19_local5 = nil
		local f19_local6 = LuaUtils.IsArenaMode()
		if f19_arg1.menu then
			f19_local0, f19_local1, f19_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f19_arg1.menu)
			f19_local3 = CoD.BaseUtility.GetMenuLoadoutListItemSlot(f19_arg1.menu)
			f19_local5 = f19_local0[f19_local2].refHash:get()
			local f19_local7 = CoD.BaseUtility.GetMenuLoadoutListItemSlot(f19_arg1.menu)
			if f19_local7 then
				f19_local4 = f19_local0[f19_local7].attachmentIndex:get()
			end
		end
		local f19_local8 = function()
			if CoD.WeaponAttachmentsUtility.WeaponAttachmentListTable[f19_local2] then
				if CoD.WeaponAttachmentsUtility.WeaponAttachmentListTable[f19_local2].isArenaMode == f19_local6 and CoD.WeaponAttachmentsUtility.WeaponAttachmentListTable[f19_local2].weaponRefHash == f19_local5 then
					return CoD.WeaponAttachmentsUtility.WeaponAttachmentListTable[f19_local2].attachmentList
				else
					CoD.WeaponAttachmentsUtility.WeaponAttachmentListTable[f19_local2].isArenaMode = f19_local6
					CoD.WeaponAttachmentsUtility.WeaponAttachmentListTable[f19_local2].weaponRefHash = f19_local5
					CoD.WeaponAttachmentsUtility.WeaponAttachmentListTable[f19_local2].attachmentList = CoD.WeaponAttachmentsUtility.GetWeaponAttachmentList(f19_arg0, f19_arg1, f19_arg2)
					return CoD.WeaponAttachmentsUtility.WeaponAttachmentListTable[f19_local2].attachmentList
				end
			else
				DebugPrint("\n WeaponAttachmentUtility: Did not get a valid loadoutSlot, classModel, or weaponRefHash")
				return CoD.WeaponAttachmentsUtility.GetWeaponAttachmentList(f19_arg0, f19_arg1, f19_arg2)
			end
		end
		f19_local8 = f19_local8()
		local f19_local9, f19_local10 = nil
		if f19_local0 then
			f19_local9, f19_local10 = CoD.WeaponAttachmentsUtility.UpdateEquippedWeaponAttachmentAttributes(f19_local0, f19_local2, f19_local3, f19_local1)
		end
		for f19_local18, f19_local19 in ipairs(f19_local8) do
			f19_local19.properties.selectIndex = f19_local19.models.attachmentIndex == f19_local4
			if f19_local19.models and f19_local19.models.weaponIndex and f19_local19.models.attachmentRef then
				local f19_local14 = f19_local19.models.weaponIndex
				local f19_local15 = f19_local19.models.itemIndex
				local f19_local16 = f19_local19.models.attachmentRef
				local f19_local17 = Engine[0x93ABA160B5D7323](f19_local14, Engine[0x58B87258E0EBAD0](f19_local16), false)
				f19_local19.models.weaponAttributes = CoD.WeaponAttachmentsUtility.GetWeaponAttachmentAttributes(f19_local14, f19_local16, f19_local1, f19_local9, f19_local10)
				f19_local19.models.cautionText = CoD.WeaponAttachmentsUtility.GetAttachmentCautionText(f19_arg0, f19_local0, f19_local3, f19_local14, f19_local15, f19_local1)
				f19_local19.models.isRestricted = f19_local17
			end
		end
		return f19_local8
	end,
	false,
	{
		getModelForAttachmentIndex = function(f21_arg0, f21_arg1)
			local f21_local0 = Engine[0x4DF5CFBC1771947](f21_arg0)
			f21_local0 = f21_local0.WeaponAttachments
			if f21_local0 and f21_local0[f21_arg1] then
				return f21_local0[f21_arg1]
			else
			end
		end,
	}
)
CoD.WeaponAttachmentsUtility.UpdateAttachmentFilter = function(f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = CoD.BaseUtility.GetMenuAttachmentFilter(f22_arg0)
	local f22_local1 = function(f23_arg0)
		if f22_local0 == "optic" then
			return f23_arg0 == Enum[0x7420BCDBDE17A84][0x6AC43DB9B6634DA]
		elseif f22_local0 == "uber" then
			return f23_arg0 == Enum[0x7420BCDBDE17A84][0x6EE211053211305]
		else
			local f23_local0
			if f23_arg0 == Enum[0x7420BCDBDE17A84][0x6AC43DB9B6634DA] or f23_arg0 == Enum[0x7420BCDBDE17A84][0x6EE211053211305] then
				f23_local0 = false
			else
				f23_local0 = true
			end
		end
		return f23_local0
	end
	f22_arg1:setFilter(function(f24_arg0)
		local f24_local0 = f24_arg0.attachmentGroup
		if f24_local0 then
			return f22_local1(f24_local0:get())
		else
		end
	end)
end
CoD.WeaponAttachmentsUtility.LayoutAttachmentOptionsDiamondGridSetupKeyboardnavigation = function(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
	local f25_local0 = function(f26_arg0, f26_arg1)
		local f26_local0 = f26_arg1:getFirstChild()
		local f26_local1 = true
		while f26_local1 and f26_local0 ~= nil do
			f26_local1 = false
			for f26_local5, f26_local6 in ipairs(f26_arg0._attachmentUpgradeWidgets) do
				if f26_local6 == f26_local0 then
					f26_local1 = true
				end
			end
			if f26_local1 then
				f26_local0 = f26_local0:getNextSibling()
			end
		end
		return f26_local0
	end
	local f25_local1 = f25_local0(f25_arg0, f25_arg0._attachmentWidgets[f25_arg1])
	if not f25_local1.CustomNavigation then
		f25_local1.CustomNavigation = {}
	end
	if f25_arg2 ~= nil then
		if f25_local1.CustomNavigation == nil then
			f25_local1.CustomNavigation = {}
		end
		if f25_arg3 == 1 or f25_arg3 == 8 then
			f25_local1.CustomNavigation.up = f25_arg2
		elseif f25_arg3 == 2 or f25_arg3 == 3 then
			f25_local1.CustomNavigation.right = f25_arg2
		elseif f25_arg3 == 4 or f25_arg3 == 5 then
			f25_local1.CustomNavigation.down = f25_arg2
		elseif f25_arg3 == 6 or f25_arg3 == 7 then
			f25_local1.CustomNavigation.left = f25_arg2
		end
	end
	if f25_arg1 == 1 then
		return
	elseif (f25_arg1 - 1) % 3 == 0 then
		local f25_local2 = f25_local0(f25_arg0, f25_arg0._attachmentWidgets[f25_arg1 - 1])
		if f25_local2.CustomNavigation == nil then
			f25_local2.CustomNavigation = {}
		end
		if f25_local1.CustomNavigation == nil then
			f25_local1.CustomNavigation = {}
		end
		if not f25_local2.CustomNavigation.down then
			f25_local2.CustomNavigation.down = f25_local1
		else
			if f25_local2.CustomNavigation.down.CustomNavigation == nil then
				f25_local2.CustomNavigation.down.CustomNavigation = {}
			end
			f25_local2.CustomNavigation.down.CustomNavigation.down = f25_local1
		end
		if not f25_local1.CustomNavigation.up then
			f25_local1.CustomNavigation.up = f25_local2
		else
			if f25_local1.CustomNavigation.up.CustomNavigation == nil then
				f25_local1.CustomNavigation.up.CustomNavigation = {}
			end
			f25_local1.CustomNavigation.up.CustomNavigation.up = f25_local2
		end
		if f25_arg1 >= 7 then
			local f25_local3 = f25_local0(f25_arg0, f25_arg0._attachmentWidgets[f25_arg1 - 3])
			if f25_local3.CustomNavigation == nil then
				f25_local3.CustomNavigation = {}
			end
			if not f25_local3.CustomNavigation.right then
				f25_local3.CustomNavigation.right = f25_local1
			else
				if f25_local3.CustomNavigation.right.CustomNavigation == nil then
					f25_local3.CustomNavigation.right.CustomNavigation = {}
				end
				f25_local3.CustomNavigation.right.CustomNavigation.right = f25_local1
			end
			f25_local1.CustomNavigation.left = f25_local3
		end
	elseif (f25_arg1 + 1) % 3 == 0 then
		local f25_local4 = f25_arg1 - 3
		if f25_arg1 == 2 then
			f25_local4 = 1
		end
		local f25_local2 = f25_local0(f25_arg0, f25_arg0._attachmentWidgets[f25_local4])
		if f25_local2.CustomNavigation == nil then
			f25_local2.CustomNavigation = {}
		end
		if f25_local1.CustomNavigation == nil then
			f25_local1.CustomNavigation = {}
		end
		if not f25_local2.CustomNavigation.right then
			f25_local2.CustomNavigation.right = f25_local1
		else
			if f25_local2.CustomNavigation.right.CustomNavigation == nil then
				f25_local2.CustomNavigation.right.CustomNavigation = {}
			end
			f25_local2.CustomNavigation.right.CustomNavigation.right = f25_local1
		end
		if not f25_local1.CustomNavigation.left then
			f25_local1.CustomNavigation.left = f25_local2
		else
			if f25_local1.CustomNavigation.left.CustomNavigation == nil then
				f25_local1.CustomNavigation.left.CustomNavigation = {}
			end
			f25_local1.CustomNavigation.left.CustomNavigation.left = f25_local2
		end
	elseif f25_arg1 % 3 == 0 and f25_arg1 >= 6 then
		local f25_local4 = f25_local0(f25_arg0, f25_arg0._attachmentWidgets[f25_arg1 - 3])
		if f25_local4.CustomNavigation == nil then
			f25_local4.CustomNavigation = {}
		end
		if not f25_local4.CustomNavigation.right then
			f25_local4.CustomNavigation.right = f25_local1
		else
			if f25_local4.CustomNavigation.right.CustomNavigation == nil then
				f25_local4.CustomNavigation.right.CustomNavigation = {}
			end
			f25_local4.CustomNavigation.right.CustomNavigation.right = f25_local1
		end
		f25_local1.CustomNavigation.left = f25_local4
	end
end
CoD.WeaponAttachmentsUtility.UpdateAttachmentContainerLayout = function(f27_arg0, f27_arg1, f27_arg2)
	local f27_local0 = f27_arg0.UberAttachmentContainer
	if f27_local0 and f27_local0.UberList and f27_local0.UberList.itemCount <= 0 then
		f27_local0:setAlpha(0)
	end
end
CoD.WeaponAttachmentsUtility.CenterAttachmentLayout = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
	RecalculateScaleToElementWidth(f28_arg3, f28_arg3)
	local f28_local0, f28_local1, f28_local2, f28_local3 = f28_arg3:getLocalLeftRight()
	local f28_local4 = (f28_local3 - f28_local2) / 2
	f28_arg3:setLeftRight(0.5, 0.5, -f28_local4, f28_local4)
end
CoD.WeaponAttachmentsUtility.GetAttachmentSlotForItemIndex = function(f29_arg0, f29_arg1, f29_arg2, f29_arg3, f29_arg4)
	local f29_local0 = Engine[0xED9C4D9D6233895](f29_arg0, f29_arg2, f29_arg4)
	if f29_local0 then
		for f29_local4, f29_local5 in ipairs(f29_arg3) do
			local f29_local6 = LUI.getTableFromPath(CoD.CACUtility.GetDDLPathForModelPath(f29_local0, f29_local5), f29_local0)
			if f29_local6:get() == f29_arg1 then
				return f29_local5
			end
		end
	end
	return nil
end
CoD.WeaponAttachmentsUtility.ValidateUpgradeAttachmentLoadoutHelper = function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
	local f30_local0 = f30_arg1[f30_arg2].itemIndex:get()
	if f30_local0 <= CoD.CACUtility.EmptyItemIndex then
		return
	end
	local f30_local1 = Engine[0x2964239F2151F6F](f30_local0, f30_arg3)
	local f30_local2 = CoD.CACUtility.GetAttachmentListForSlot(f30_arg2)
	local f30_local3 = f30_arg1.classNum:get()
	for f30_local8, f30_local9 in ipairs(f30_local2) do
		local f30_local10 = f30_arg1[f30_local9]
		local f30_local11 = f30_local10.ref:get()
		if CoD.WeaponAttachmentsUtility.IsAttachmentUpgrade(f30_local1, f30_local11) and not CoD.WeaponAttachmentsUtility.GetAttachmentSlotForItemIndex(f30_arg0, CoD.WeaponAttachmentsUtility.GetAttachmentIndexForWeaponAttachmentRef(f30_local0, CoD.WeaponAttachmentsUtility.GetBaseAttachmentRef(f30_local1, f30_local11), f30_arg3), f30_local3, f30_local2, f30_arg3) then
			local f30_local7 = f30_local10.itemIndex:get()
			CoD.CACUtility.GetCustomClassModel(f30_arg0, f30_local3, f30_arg1, nil, f30_arg3)
			if CoD.CACUtility.RemoveAttachmentFromClassHelper(f30_arg0, f30_arg1, f30_local7, f30_local2, f30_arg3) then
				CoD.WeaponAttachmentsUtility.ValidateUpgradeAttachmentLoadoutHelper(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
			end
		end
	end
end
CoD.WeaponAttachmentsUtility.ValidateUpgradeAttachmentLoadout = function(f31_arg0, f31_arg1, f31_arg2)
	local f31_local0, f31_local1, f31_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f31_arg0)
	if f31_arg2 and f31_arg2 ~= "" then
		f31_local2 = f31_arg2
	end
	if not f31_local2 then
		return
	else
		CoD.WeaponAttachmentsUtility.ValidateUpgradeAttachmentLoadoutHelper(f31_arg1, f31_local0, f31_local2, f31_local1)
	end
end
CoD.WeaponAttachmentsUtility.SetupAttachmentDescriptionFlyouts = function(f32_arg0, f32_arg1, f32_arg2, f32_arg3)
	if not f32_arg0._flyouts then
		f32_arg0._flyouts = {}
		local f32_local0 = CoDShared.EmptyItemIndex
		local f32_local1 = nil
		if f32_arg3._weaponItemIndex then
			f32_local0 = f32_arg3._weaponItemIndex
			f32_local1 = "ArmoryWeaponAttachments"
		else
			local f32_local2, f32_local3, f32_local4 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f32_arg3)
			f32_local0 = f32_local2[f32_local4].itemIndex:get()
			f32_local1 = "WeaponAttachments"
		end
		local f32_local2 = Engine[0x4DF5CFBC1771947](f32_arg2)
		f32_local2 = f32_local2[f32_local1]
		local f32_local3 = 1
		local f32_local4 = f32_local2[f32_local3]
		while f32_local4 do
			if f32_local4.weaponIndex:get() == f32_local0 then
				local f32_local5 = CoD.AttachmentDescriptionContainer.new(f32_arg3, f32_arg2, 0, 0, 0, CoD.AttachmentDescriptionContainer.__defaultWidth, 0, 0, 0, CoD.AttachmentDescriptionContainer.__defaultHeight)
				f32_local5:setModel(f32_local4, f32_arg2)
				f32_arg0:addElement(f32_local5)
				f32_arg3:sendInitializationEvents(f32_arg2, f32_local5)
				table.insert(f32_arg0._flyouts, f32_local5)
				UpdateState(f32_local5, {
					controller = f32_arg2,
				})
				local f32_local6 = Engine[0x4DF5CFBC1771947](f32_arg2)
				local f32_local7 = f32_local6:create("WeaponAttachmentFlyout.entNum")
				local f32_local8 = function(f33_arg0, f33_arg1)
					local f33_local0 = f33_arg1:get()
					if f33_local0 then
						f32_local5:setupWeaponAttachmentFlyout(f33_local0)
						if f32_local5.Connector then
							f32_local5.Connector:setupWeaponAttachmentFlyoutConnector()
						end
					end
				end
				f32_local5:subscribeToModel(f32_local7, function(model, f34_arg1)
					f32_local8(f32_local5, model)
				end, false)
				f32_local8(f32_local5, f32_local7)
			end
			f32_local3 = f32_local3 + 1
			f32_local4 = f32_local2[f32_local3]
		end
	end
end
CoD.WeaponAttachmentsUtility.CleanAttachmentDescriptionFlyouts = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
	if f35_arg0._flyouts then
		for f35_local3, f35_local4 in ipairs(f35_arg0._flyouts) do
			f35_local4:close()
		end
		f35_arg0._flyouts = nil
	end
end
CoD.WeaponAttachmentsUtility.ResetActiveListItemForList = function(f36_arg0, f36_arg1)
	if f36_arg0 then
		f36_arg0.activeWidget = nil
		f36_arg0:setModel(nil, f36_arg1)
	end
end
CoD.WeaponAttachmentsUtility.SetupUberHintText = function(f37_arg0, f37_arg1, f37_arg2)
	local f37_local0, f37_local1, f37_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f37_arg0)
	local f37_local3 = CoD.BaseUtility.GetMenuLoadoutListItemSlot(f37_arg0)
	local f37_local4 = CoD.WeaponAttachmentsUtility.CanEquipUberAttachmentInSlot(f37_arg0)
	if f37_local0 then
		local f37_local5 = CoD.BonuscardUtility.IsOperatorModBonuscardEquipped(f37_local0, f37_local2, f37_local1)
		local f37_local6 = 0x0
		if not f37_local5 then
			f37_local6 = 0x7A1F89C3CFA8A86
			if f37_local2 == "secondary" then
				f37_local6 = 0x15D4FED971424A
			end
		elseif not f37_local4 then
			f37_local6 = 0xB6269F85047C8B4
		end
		f37_arg1:setText(Engine[0xF9F1239CFD921FE](f37_local6))
	end
end
CoD.WeaponAttachmentsUtility.CanEquipUberAttachmentInSlot = function(f38_arg0)
	local f38_local0, f38_local1, f38_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f38_arg0)
	local f38_local3 = CoD.BaseUtility.GetMenuLoadoutListItemSlot(f38_arg0)
	if f38_local0 and CoD.BonuscardUtility.IsOperatorModBonuscardEquipped(f38_local0, f38_local2, f38_local1) then
		local f38_local4 = LUI.splitString(f38_local3, ".")
		local f38_local5 = f38_local4[3]
		if f38_local5 then
			f38_local5 = tonumber(f38_local4[3])
		end
		if f38_local5 == CoD.CACUtility.UberIndexSlot then
			return true
		end
	end
	return false
end
CoD.WeaponAttachmentsUtility.IsAttachmentOptic = function(f39_arg0, f39_arg1)
	local f39_local0 = CoD.SafeGetModelValue(f39_arg1:getModel(), "loadoutListItem")
	if f39_local0 == nil then
		return false
	else
		local f39_local1 = CoD.SafeGetModelValue(f39_local0, "itemIndex")
		local f39_local2 = CoD.SafeGetModelValue(f39_local0, "weaponIndex")
		if f39_local1 == nil or f39_local2 == nil then
			return false
		else
			return Engine[0x689E378B0101DCE](f39_local2, f39_local1)
		end
	end
end
CoD.WeaponAttachmentsUtility.IsBaseAttachmentEquipped = function(f40_arg0, f40_arg1, f40_arg2)
	local f40_local0, f40_local1, f40_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f40_arg0)
	return f40_local0 and CoD.CACUtility.GetAttachmentEquipSlot(f40_arg1.baseAttachmentItemIndex, f40_local0, f40_local2) ~= nil
end
CoD.WeaponAttachmentsUtility.ShouldShowAttachmentFlyout = function(f41_arg0, f41_arg1, f41_arg2)
	if CoD.ModelUtility.IsSelfModelValueTrue(f41_arg1, f41_arg2, "attachmentInFocus") then
		return true
	end
	local f41_local0 = "WeaponAttachments"
	if f41_arg0._inArmory then
		f41_local0 = "ArmoryWeaponAttachments"
	elseif CoD.CACUtility.IsElementAttachmentEquippedInCurrentClass(f41_arg0, f41_arg1, f41_arg2) then
		return true
	end
	local f41_local1 = f41_arg1:getModel()
	if f41_local1.isUpgradedAttachment:get() then
		local f41_local2 = DataSources[f41_local0].getModelForAttachmentIndex(f41_arg2, f41_local1.baseAttachmentItemIndex:get())
		if f41_local2 and f41_local1 ~= f41_local2 then
			f41_local2.attachmentInFocus:forceNotifySubscriptions()
		end
	end
	return false
end
CoD.WeaponAttachmentsUtility.ShouldHideBaseAttachmentFlyout = function(f42_arg0, f42_arg1, f42_arg2)
	local f42_local0, f42_local1, f42_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f42_arg0)
	local f42_local3 = f42_arg1:getModel()
	if f42_local0 and f42_local3 then
		if f42_local3.isUpgradedAttachment:get() then
			local f42_local4 = DataSources.WeaponAttachments.getModelForAttachmentIndex(f42_arg2, f42_local3.baseAttachmentItemIndex:get())
			if f42_local4 and f42_local3 ~= f42_local4 then
				f42_local4.attachmentInFocus:forceNotifySubscriptions()
			end
		elseif f42_local3.upgradedAttachmentIndex then
			local f42_local5 = f42_local3.upgradedAttachmentIndex:get()
			if CoD.CACUtility.EmptyItemIndex < f42_local5 then
				if CoD.CACUtility.GetAttachmentEquipSlot(f42_local5, f42_local0, f42_local2) ~= nil then
					return true
				else
					return CoD.SafeGetModelValue(DataSources.WeaponAttachments.getModelForAttachmentIndex(f42_arg2, f42_local5), "attachmentInFocus")
				end
			end
		end
	end
	return false
end
CoD.WeaponAttachmentsUtility.DoesWeaponHaveUberAttachment = function(f43_arg0, f43_arg1)
	local f43_local0, f43_local1, f43_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f43_arg0)
	if f43_local0 and f43_local0[f43_local2] then
		return CoD.CACUtility.EmptyItemIndex < Engine[0xEF453A0A31D191A](f43_local0[f43_local2].itemIndex:get(), f43_local1)
	else
		return false
	end
end
CoD.WeaponAttachmentsUtility.ShouldShowWeaponUberInfo = function(f44_arg0)
	return CoD.BaseUtility.GetMenuAttachmentFilter(f44_arg0) == "attachment"
end
CoD.WeaponAttachmentsUtility.UpdateAttachmentHeader = function(f45_arg0, f45_arg1)
	local f45_local0 = CoD.BaseUtility.GetMenuAttachmentFilter(f45_arg0)
	if f45_local0 == "optic" then
		f45_arg1 = 0xBB87386985BA15F
	elseif f45_local0 == "uber" then
		f45_arg1 = 0x912DE50663D611C
	end
	return f45_arg1
end
