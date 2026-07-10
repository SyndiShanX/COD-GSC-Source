require("x64:d90671b853a008e")
CoD.ZMTalismanUtility = {}
CoD.ZMTalismanUtility.TalismanTypes = LuaEnum.createEnum("NONE", "PERK1", "PERK2", "PERK3", "PERK4", "HERO_WEAPON", "EQUIPMENT", "START_WEAPON")
CoD.ZMTalismanUtility.TalismanSlotIcons = {
	[CoD.ZMTalismanUtility.TalismanTypes.NONE] = 0x7615068F50B3D66,
	[CoD.ZMTalismanUtility.TalismanTypes.PERK1] = 0x621DB435A480979,
	[CoD.ZMTalismanUtility.TalismanTypes.PERK2] = 0x621DB435A480979,
	[CoD.ZMTalismanUtility.TalismanTypes.PERK3] = 0x621DB435A480979,
	[CoD.ZMTalismanUtility.TalismanTypes.PERK4] = 0x621DB435A480979,
	[CoD.ZMTalismanUtility.TalismanTypes.HERO_WEAPON] = 0x621DB435A480979,
	[CoD.ZMTalismanUtility.TalismanTypes.EQUIPMENT] = 0x621DB435A480979,
	[CoD.ZMTalismanUtility.TalismanTypes.START_WEAPON] = 0x621DB435A480979,
}
CoD.ZMTalismanUtility.N_ENUM_MBOX_OFF = 0
CoD.ZMTalismanUtility.N_SETTING_PACK_OFF = 0
CoD.ZMTalismanUtility.N_SETTING_LAST_STAND_DURATION_OFF = 0
CoD.ZMTalismanUtility.TalismanToEnumGameSettingsHash = {
	[0x96A42B9715FCF4E] = {
		{
			hash = 0xE0EC3FE56F08B47,
			restrictedValue = CoD.ZMTalismanUtility.N_ENUM_MBOX_OFF,
		},
	},
	[0xCAFC6BD7BFA105A] = {
		{
			hash = 0xE0EC3FE56F08B47,
			restrictedValue = CoD.ZMTalismanUtility.N_ENUM_MBOX_OFF,
		},
	},
	[0xD2C0474517A8626] = {
		{
			hash = 0x9D48A0D4490B0A2,
			restrictedValue = CoD.ZMTalismanUtility.N_SETTING_PACK_OFF,
		},
	},
	[0xECEF105EDFCE221] = {
		{
			hash = 0x517C36D49B4EE0,
			restrictedValue = CoD.ZMTalismanUtility.N_SETTING_LAST_STAND_DURATION_OFF,
		},
	},
}
CoD.ZMTalismanUtility.TalismanToBooleanGameSettingsHash = {
	[0x96A42B9715FCF4E] = {
		0x53FCFBEE32E3655,
	},
	[0xCAFC6BD7BFA105A] = {
		0xB59BB7608355512,
		0xF6740B518DBEB8F,
	},
	[0xECEF105EDFCE221] = {
		0x8A8F3CFEF7B86D1,
	},
	[0xA2042B3984A50AC] = {
		0x17917E00DE6B437,
		0x5A1298089D361F1,
	},
	[0xC39AFAA7B8D508C] = {
		0x6A78AC345A3E2BB,
		0x5A1298089D361F1,
	},
	[0xBD593B03DBE4709] = {
		0x52EBA9759A4A52A,
		0x5A1298089D361F1,
	},
	[0x16F409871DE1C2A] = {
		0x6943D48D878715F,
		0x5A1298089D361F1,
	},
	[0x33AD55AC2B835D0] = {
		0x7C61B02FB56F7F,
		0x5A1298089D361F1,
	},
	[0xE64B28EDF21732A] = {
		0x1987D25A3717A,
	},
	[0x567F18899A438F1] = {
		0x3BF3E5A51CB8FAD,
		0xD18F84F48BD5D1F,
	},
	[0x7AFAE5369A40BC2] = {
		0xF51E04634DAFE36,
		0xD18F84F48BD5D1F,
	},
	[0x7AFAD5369A40A0F] = {
		0xF51DF4634DAFC83,
		0xD18F84F48BD5D1F,
	},
	[0x7AFAC5369A4085C] = {
		0xF51DE4634DAFAD0,
		0xD18F84F48BD5D1F,
	},
	[0x7AFAB5369A406A9] = {
		0xF51E54634DB06B5,
		0xD18F84F48BD5D1F,
	},
	[0x89C4CE1578064B7] = {
		0x6DB42B55542EC33,
		0xD18F84F48BD5D1F,
	},
	[0x89C4DE15780666A] = {
		0x6DB43B55542EDE6,
		0xD18F84F48BD5D1F,
	},
	[0x89C4EE15780681D] = {
		0x6DB44B55542EF99,
		0xD18F84F48BD5D1F,
	},
	[0x89C47E157805C38] = {
		0x6DB45B55542F14C,
		0xD18F84F48BD5D1F,
	},
	[0xBA5A74038BFFAB4] = {
		0xFE0BA92C67980E8,
		0xD18F84F48BD5D1F,
	},
	[0xBA5AA4038BFFFCD] = {
		0xFE0BD92C6798601,
		0xD18F84F48BD5D1F,
	},
	[0xBA5A94038BFFE1A] = {
		0xFE0BC92C679844E,
		0xD18F84F48BD5D1F,
	},
	[0xBA5A44038BFF59B] = {
		0xFE0BF92C6798967,
		0xD18F84F48BD5D1F,
	},
	[0x4709F2CDFEC5C52] = {
		0xF973A92562BC3B6,
		0x5A1D440F78A3B2,
	},
	[0xDA3AF324B74C125] = {
		0x6D19199D37D4549,
		0x5A1D440F78A3B2,
	},
	[0xC519F7F8371ECF8] = {
		0x2C6D1CA5EAB82AB,
		0x5A1D440F78A3B2,
	},
	[0x50670241DFB72AF] = {
		0xEFEF475C9DE052E,
		0xB066C34278E6394,
	},
	[0x5066F241DFB70FC] = {
		0xEFEF575C9DE06E1,
		0xB066C34278E6394,
	},
	[0xEEBDA916971B02] = {
		0xE1F30CC8F6F3150,
		0xB066C34278E6394,
	},
	[0x24D9B998E4BC4F8] = {
		0x9A9D40272333762,
		0xD5C8E6F0E20201A,
	},
	[0x76221EC95A6B4D1] = {
		0x11DB227D86CC407,
		0xF6740B518DBEB8F,
	},
	[0xA0802EC72B26A24] = {
		0xA6E4728651AFF36,
		0xF6665B5581F6B6E,
	},
	[0xD2C0474517A8626] = {
		0x4C81F5AEDDAE88F,
	},
	[0x734F461CBE4850D] = {
		0xF55E280D866341D,
		0xB066C34278E6394,
	},
	[0x53DCE90F31AA76] = {
		0x2EE429BB9CE771C,
	},
}
DataSources.TalismanCategories = ListHelper_SetupDataSource("TalismanCategories", function(f1_arg0, f1_arg1)
	local f1_local0 = CoD.CACUtility.GetItemEquippedInSlot(CoD.BaseUtility.GetMenuLoadoutSlot(f1_arg1.menu), nil, CoD.BaseUtility.GetMenuModel(f1_arg1.menu))
	local f1_local1 = nil
	if f1_local0 ~= CoD.CACUtility.EmptyItemIndex then
		f1_local1 = Engine[0x87395843D470BE2](f1_local0, Enum[0x6EB546760F890D2][0x5544C104CD15F10], Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
	end
	local f1_local2 = function(f2_arg0)
		return f1_local1 and f1_local1[0xEAC0467BA97BCA9] == f2_arg0
	end
	local f1_local3 = {}
	table.insert(f1_local3, {
		models = {
			tabName = 0xE73A287484FA8DE,
			tabHasRestrictions = CoD.CACUtility.AnyTalismanRestrictedForRarity(Enum[0xEAC0467BA97BCA9][0xCAF546022922B9B]),
		},
		properties = {
			rarity = Enum[0xEAC0467BA97BCA9][0xCAF546022922B9B],
			selectIndex = f1_local2(Enum[0xEAC0467BA97BCA9][0xCAF546022922B9B]),
		},
	})
	table.insert(f1_local3, {
		models = {
			tabName = 0xD14011B788D0CF7,
			tabHasRestrictions = CoD.CACUtility.AnyTalismanRestrictedForRarity(Enum[0xEAC0467BA97BCA9][0xA113367DDA0F492]),
		},
		properties = {
			rarity = Enum[0xEAC0467BA97BCA9][0xA113367DDA0F492],
			selectIndex = f1_local2(Enum[0xEAC0467BA97BCA9][0xA113367DDA0F492]),
		},
	})
	table.insert(f1_local3, {
		models = {
			tabName = 0x99BE3404C6F5504,
			tabHasRestrictions = CoD.CACUtility.AnyTalismanRestrictedForRarity(Enum[0xEAC0467BA97BCA9][0x96900358670FFE7]),
		},
		properties = {
			rarity = Enum[0xEAC0467BA97BCA9][0x96900358670FFE7],
			selectIndex = f1_local2(Enum[0xEAC0467BA97BCA9][0x96900358670FFE7]),
		},
	})
	table.insert(f1_local3, {
		models = {
			tabName = 0xCC5E57AF2A3CF36,
			tabHasRestrictions = CoD.CACUtility.AnyTalismanRestrictedForRarity(Enum[0xEAC0467BA97BCA9][0x9F2E1F9312FF03]),
		},
		properties = {
			rarity = Enum[0xEAC0467BA97BCA9][0x9F2E1F9312FF03],
			selectIndex = f1_local2(Enum[0xEAC0467BA97BCA9][0x9F2E1F9312FF03]),
		},
	})
	return f1_local3
end, true)
CoD.ZMTalismanUtility.IsEquippedTalismanOfType = function(f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = f3_arg0:getModel(f3_arg1, "itemIndex")
	local f3_local1 = f3_local0 and f3_local0:get()
	if f3_local1 and f3_local1 > CoD.CACUtility.EmptyItemIndex then
		local f3_local2 = Engine[0x87395843D470BE2](f3_local1, Enum[0x6EB546760F890D2][0x5544C104CD15F10], Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
		return f3_local2 and f3_local2[0xE73D6BF951E301E] == f3_arg2
	else
		return false
	end
end
CoD.ZMTalismanUtility.GetTalismanSlotIcon = function(f4_arg0, f4_arg1)
	return CoD.ZMTalismanUtility.TalismanSlotIcons[f4_arg0] or "blacktransparent"
end
CoD.ZMTalismanUtility.UpdateTalismanModel = function(f5_arg0, f5_arg1, f5_arg2)
	local f5_local0 = f5_arg1:getModel()
	if f5_local0 then
		local f5_local1 = f5_local0.itemIndex:get()
		local f5_local2 = f5_local0.globalItemIndex:get()
		local f5_local3 = Engine[0x86DC0510B2E2933](f5_local1, Enum[0x6EB546760F890D2][0x5544C104CD15F10], Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
		local f5_local4 = true
		local f5_local5 = "select01"
		local f5_local6 = 0x0
		local f5_local7 = 1
		local f5_local8 = CoD.CACUtility.GetUnlockableItemInfo(f5_local2, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
		if f5_local8 then
			f5_local6 = f5_local8[0xB6404450C6BAEEF] or 0x0
			f5_local7 = f5_local8[0xB49D7582CD08B0E] or 1
		end
		Engine[0x6ABA4D7F0840A1E](f5_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f5_arg2), {
			base_weapon_slot = f5_local3,
			weapon = f5_local6,
			attachments = "",
			camera = f5_local5,
			is_item_unlocked = f5_local4,
			xmodel_scale = f5_local7,
		})
	end
end
CoD.ZMTalismanUtility.UnequipTalisman = function(f6_arg0, f6_arg1, f6_arg2)
	local f6_local0, f6_local1, f6_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f6_arg0)
	if f6_local0 and f6_local2 then
		local f6_local3 = f6_arg1.unequipSound
		if RemoveItemFromClassSlot(f6_local0, f6_local2, f6_arg2, false, f6_local1) then
			CoD.CACUtility.GetCustomClassModel(f6_arg2, f6_local0.classNum:get(), f6_local0, nil, f6_local1)
			CoD.CACUtility.UpdateClassWeaponModel(f6_arg0, f6_arg1, f6_arg2)
			CoD.FreeCursorUtility.UpdateSetupContext(f6_arg1, f6_arg2)
			if f6_local3 and f6_local3 ~= 0x0 then
				Engine[0x98954175CA6A32C](f6_local3)
			end
		end
	end
end
CoD.ZMTalismanUtility.UpdateEquippedSlot = function(f7_arg0)
	ForceNotifyModel(f7_arg0, "TalismanSelect.Update")
end
CoD.ZMTalismanUtility.IsTalismanEqipped = function(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0, f8_local1, f8_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f8_arg0)
	local f8_local3 = CoD.SafeGetModelValue(f8_arg1:getModel(), "itemIndex")
	if f8_local0 and f8_local2 and f8_local3 and CoD.CACUtility.EmptyItemIndex < f8_local3 and f8_local0[f8_local2].itemIndex:get() == f8_local3 then
		return true
	else
	end
end
