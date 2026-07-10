CoD.TalentSelectUtility = {}
CoD.TalentSelectUtility.GetSlotLevelFromSlotName = function(f1_arg0)
	return tonumber(string.sub(f1_arg0, string.len("talent") + 1))
end
CoD.TalentSelectUtility.UpdateOptionsList = function(f2_arg0)
	local f2_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f2_arg0), "TalentSelect.UpdateOptions")
	if f2_local0 ~= nil then
		f2_local0:forceNotifySubscriptions()
	end
end
CoD.TalentSelectUtility.EquipTalentSlot = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5)
	if AttemptAttachItem(f3_arg0, f3_arg1, f3_arg5, f3_arg4, f3_arg2, f3_arg3) then
		f3_arg0:playSound("equip_item")
	end
end
CoD.TalentSelectUtility.UnequipTalentSlot = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	local f4_local0 = LuaUtils.FindItemInArray(CoD.CACUtility.TalentSlotNameList, f4_arg3)
	local f4_local1 = CoD.TalentSelectUtility.GetMaxAllowedSkills()
	local f4_local2 = f4_local0 + 1
	while f4_local0 <= f4_local1 do
		CoD.CACUtility.SetClassItem(f4_arg1, f4_arg2, CoD.CACUtility.TalentSlotNameList[f4_local0], CoD.CACUtility.EmptyItemIndex, nil, f4_arg5)
		local f4_local3 = nil
		if f4_local2 <= f4_local1 then
			CoD.TalentSelectUtility.EquipTalentSlot(f4_arg0, f4_arg1, CoD.CACUtility.TalentSlotNameList[f4_local0], CoD.CACUtility.GetClassItem(f4_arg1, f4_arg2, CoD.CACUtility.TalentSlotNameList[f4_local2], f4_arg5), f4_arg4, f4_arg5)
			f4_local2 = f4_local2 + 1
		end
		f4_local0 = f4_local0 + 1
	end
end
CoD.TalentSelectUtility.GetTalentEquipSlot = function(f5_arg0, f5_arg1)
	return CoD.CACUtility.GetEquipSlotForItemIndex(f5_arg0, f5_arg1, CoD.CACUtility.TalentSlotNameList, CoD.TalentSelectUtility.GetMaxAllowedSkills())
end
CoD.TalentSelectUtility.GetTalentFilterForEquippedSlot = function(f6_arg0, f6_arg1, f6_arg2)
	if f6_arg0 then
		local f6_local0 = f6_arg0[f6_arg1]
		if f6_local0 then
			return Engine[0xB8891E0F105C51F](f6_local0.itemIndex:get(), Enum[0x6EB546760F890D2][0x8EA6ADA81FD4511], f6_arg2)
		end
	end
end
CoD.TalentSelectUtility.EquipTalent = function(f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = CoD.BaseUtility.GetMenuModel(f7_arg1)
	local f7_local1 = CoD.BaseUtility.GetMenuSessionMode(f7_arg1)
	local f7_local2 = CoD.BaseUtility.GetMenuLoadoutListItemSlot(f7_arg1)
	local f7_local3 = f7_arg0:getModel()
	if f7_local3 and AttemptAttachItem(f7_arg1, f7_arg2, f7_local1, f7_local0, f7_local2, f7_local3.itemIndex:get()) then
		f7_arg0:playSound("equip_item")
		GoBack(f7_arg1, f7_arg2)
	end
end
CoD.TalentSelectUtility.EquippedTalentRemove = function(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = CoD.BaseUtility.GetMenuModel(f8_arg1)
	CoD.TalentSelectUtility.UnequipTalentSlot(f8_arg1, f8_arg2, f8_local0.classNum:get(), f8_arg0.itemSlot, f8_local0, CoD.BaseUtility.GetMenuSessionMode(f8_arg1))
	CoD.TalentSelectUtility.UpdateOptionsList(f8_arg2)
end
CoD.TalentSelectUtility.RemoveAllEquippedTalents = function(f9_arg0, f9_arg1)
	local f9_local0 = CoD.BaseUtility.GetMenuModel(f9_arg0)
	local f9_local1 = f9_local0.classNum:get()
	local f9_local2 = CoD.BaseUtility.GetMenuSessionMode(f9_arg0)
	for f9_local6, f9_local7 in ipairs(CoD.CACUtility.TalentSlotNameList) do
		CoD.TalentSelectUtility.UnequipTalentSlot(f9_arg0, f9_arg1, f9_local1, f9_local7, f9_local0, f9_local2)
	end
	CoD.TalentSelectUtility.UpdateOptionsList(f9_arg1)
end
CoD.TalentSelectUtility.UnequipTalentItem = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = CoD.BaseUtility.GetMenuSessionMode(f10_arg1)
	local f10_local1 = CoD.BaseUtility.GetMenuModel(f10_arg1)
	local f10_local2 = f10_local1.classNum:get()
	local f10_local3 = f10_arg0:getModel()
	if f10_local3 and f10_local3.talentSlot then
		local f10_local4 = f10_local3.talentSlot:get()
		if f10_local4.weaponSlot then
			CoD.CACUtility.SetClassItem(f10_arg2, f10_local2, f10_local4.weaponSlot:get(), CoD.CACUtility.EmptyItemIndex, nil, f10_local0)
			CoD.CACUtility.GetCustomClassModel(f10_arg2, f10_local2, f10_local1, nil, f10_local0)
		end
	end
end
CoD.TalentSelectUtility.SetTalentPreviewModels = function(f11_arg0, f11_arg1)
	local f11_local0 = f11_arg0:getModel()
	local f11_local1 = f11_local0.image and f11_local0.image:get() or ""
	local f11_local2 = f11_local0.itemIndex and f11_local0.itemIndex:get() or 0
	local f11_local3 = DataSources.TalentSelect.getModel(f11_arg1)
	f11_local3.previewImage:set(f11_local1)
	f11_local3.previewItemIndex:set(f11_local2)
end
CoD.TalentSelectUtility.IsTalentSlotEquipped = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = f12_arg1:getModel()
	if f12_local0 then
		return f12_local0.itemIndex:get() ~= CoD.CACUtility.EmptyItemIndex
	else
		return false
	end
end
CoD.TalentSelectUtility.IsTalentEquippedInCurrentClass = function(f13_arg0, f13_arg1, f13_arg2)
	local f13_local0 = f13_arg1:getModel()
	return CoD.TalentSelectUtility.GetTalentEquipSlot(f13_local0.itemIndex:get(), CoD.BaseUtility.GetMenuModel(f13_arg0)) ~= nil
end
CoD.TalentSelectUtility.IsAnyTalentSlotEmptyInCurrentClass = function(f14_arg0, f14_arg1)
	return CoD.TalentSelectUtility.GetTalentEquipSlot(CoD.CACUtility.EmptyItemIndex, CoD.BaseUtility.GetMenuModel(f14_arg0)) ~= nil
end
CoD.TalentSelectUtility.IsTalentEquippedInCurrentSlot = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = CoD.SafeGetModelValue(f15_arg1:getModel(), "itemIndex")
	return f15_local0 and CoD.CACUtility.EmptyItemIndex < f15_local0
end
CoD.TalentSelectUtility.GetMaxAllowedSkills = function()
	local f16_local0 = Engine[0xDBC2AD5002B261B](0x635A26C94B56725) or 0
	if f16_local0 > 0 and f16_local0 < #CoD.CACUtility.TalentSlotNameList then
		return f16_local0
	else
		return #CoD.CACUtility.TalentSlotNameList
	end
end
DataSources.TalentSelect = {
	getModel = function(f17_arg0)
		local f17_local0 = Engine[0x4DF5CFBC1771947](f17_arg0)
		f17_local0 = f17_local0:create("TalentSelect")
		f17_local0:create("previewImage")
		f17_local0:create("previewItemIndex")
		f17_local0:create("activeTalentSlotModel")
		return f17_local0
	end,
}
