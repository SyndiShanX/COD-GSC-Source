CoD.ContractUtility = {}
CoD.ContractUtility.ActiveContractSlot = CoDShared.Loot.ContractSlots.SLOT_1
CoD.ContractUtility.IsContractPurchased = function(f1_arg0, f1_arg1)
	return Engine[@"hash_5352DC095BBB2A45"](f1_arg0, f1_arg1) > 0
end
CoD.ContractUtility.IsContractComplete = function(f2_arg0, f2_arg1)
	return Engine[@"hash_5352DC095BBB2A45"](f2_arg0, f2_arg1) > 1
end
CoD.ContractUtility.SetActiveContract = function(f3_arg0, f3_arg1, f3_arg2)
	local f3_local0 = f3_arg0:getModel(f3_arg1, "hashName")
	local f3_local1 = f3_local0 and f3_local0:get()
	if f3_local1 and f3_arg2 then
		CoD.BlackMarketUtility.ActivateContract(f3_arg1, f3_local1, f3_arg2)
	end
end
CoD.ContractUtility.SetContractAndClosePopup = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	CoD.ContractUtility.SetActiveContract(f4_arg4, f4_arg2, f4_arg1.contractSlot)
	DelayCloseAndGoBack(f4_arg4, f4_arg2, 0)
	ForceNotifyGlobalModel(f4_arg2, "ContractsForceUpdate")
end
CoD.ContractUtility.OnContractPurchased = function(f5_arg0, f5_arg1)
	if f5_arg0.__activatePurchasedContract or CoD.ContractUtility.IsActiveContractSlotOpen(f5_arg1) then
		CoD.ContractUtility.SetActiveContract(f5_arg0, f5_arg1, CoD.ContractUtility.ActiveContractSlot)
	end
end
CoD.ContractUtility.GetPurchasableContractIds = function()
	local f6_local0 = {}
	local f6_local1 = {}
	for f6_local5, f6_local6 in ipairs(CoD.BlackMarketUtility.FeaturedSlot3Items) do
		if f6_local6 then
			table.insert(f6_local1, f6_local6)
		end
	end
	table.sort(f6_local1, function(f7_arg0, f7_arg1)
		return Engine[@"isgreaterthan"](f7_arg0.start, f7_arg1.start)
	end)
	for f6_local5, f6_local6 in ipairs(f6_local1) do
		local f6_local7 = f6_local6 and CoD.BlackMarketTableUtility.GetContractId(f6_local6.name)
		if f6_local7 and f6_local7 ~= "0" then
			table.insert(f6_local0, f6_local7)
		end
	end
	return f6_local0
end
CoD.ContractUtility.GetPurchasableContractHashes = function()
	local f8_local0 = {}
	for f8_local4, f8_local5 in ipairs(CoD.BlackMarketUtility.FeaturedSlot3Items) do
		local f8_local6 = Engine[@"converttoxhash"](f8_local5.name)
		local f8_local7 = f8_local6 and CoD.BlackMarketTableUtility.GetContractId(f8_local6)
		if f8_local7 and f8_local7 ~= "0" then
			table.insert(f8_local0, f8_local6)
		end
	end
	return f8_local0
end
CoD.ContractUtility.GetContractAsset = function(f9_arg0)
	local f9_local0 = nil
	if not IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
		f9_local0 = Engine[@"hash_2E00B2F29271C60B"](f9_arg0 .. "_presunset")
	end
	if not f9_local0 then
		f9_local0 = Engine[@"hash_2E00B2F29271C60B"](f9_arg0)
	end
	return f9_local0
end
CoD.ContractUtility.GetContractDisplayNameRef = function(f10_arg0)
	local f10_local0 = CoD.ContractUtility.GetContractAsset(f10_arg0)
	if f10_local0 then
		return f10_local0[@"contracttitle"] or 0x0
	else
		return 0x0
	end
end
CoD.ContractUtility.GetContractListModels = function(f11_arg0, f11_arg1)
	local f11_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f11_arg1)
	if not f11_local0 then
		return {}
	end
	local f11_local1 = false
	if f11_local0.namehash == @"loot_contract_carbon_cobra" then
		f11_local1 = true
	end
	local f11_local2 = CoD.ContractUtility.GetContractAsset(f11_local0.namehash)
	local f11_local3 = CoD.BlackMarketTableUtility.GetContractTierCount(f11_arg1)
	local f11_local4 = CoD.BlackMarketUtility.GetContractProgress(f11_arg0, f11_local0.namehash)
	local f11_local5 = Engine[@"hash_4F9F1239CFD921FE"]
	local f11_local6 = f11_local2[@"contractdescription"]
	if not f11_local6 then
		f11_local6 = 0x0
	end
	f11_local5 = f11_local5(f11_local6)
	f11_local6 = ""
	local f11_local7 = LuaEnum.LOOT_CAMERA_TYPE.NONE
	local f11_local8 = {}
	if f11_local2.contentsdetaileddescincludelist then
		for f11_local12, f11_local13 in ipairs(f11_local2.contentsdetaileddescincludelist) do
			if f11_local13[@"hash_619E25922B4AEDCF"] then
				table.insert(f11_local8, Engine[@"hash_4F9F1239CFD921FE"](f11_local13[@"hash_619E25922B4AEDCF"]))
			end
		end
	end
	local f11_local9 = Engine[@"hash_4F9F1239CFD921FE"]
	local f11_local10 = f11_local2[@"hash_7883881B5C75BF5E"]
	if not f11_local10 then
		f11_local10 = 0x0
	end
	f11_local9 = f11_local9(f11_local10, unpack(f11_local8))
	f11_local10 = 0x0
	local f11_local11 = nil
	local f11_local12 = 0x0
	local f11_local13, f11_local14 = nil
	local f11_local15 = Engine[@"hash_4F9F1239CFD921FE"](f11_local5)
	local f11_local16 = false
	local f11_local17 = 0x0
	if not f11_local2[@"relateditemname"] then
		local f11_local18 = 0x0
	end
	if f11_local0.type == @"outfit" then
		f11_local15 = Engine[@"hash_4F9F1239CFD921FE"](@"menu/title_theme", f11_local5)
		local f11_local19 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local20 = @"hash_6EE92514250F3100"
		local f11_local21 = f11_local3
		local f11_local22 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local23 = @"menu/title_outfit"
		local f11_local24 = f11_local2[@"contracttitle"]
		if not f11_local24 then
			f11_local24 = 0x0
		end
		f11_local6 = f11_local19(f11_local20, f11_local21, f11_local22(f11_local23, f11_local24))
		f11_local19 = CoD.BlackMarketTableUtility.GetFullContractOutfitInfo(f11_arg0, f11_local0.namehash)
		if f11_local19 then
			f11_local10 = f11_local19.prt
			f11_local11 = CoD.BlackMarketUtility.FindCharacterDetailsFromLootId(f11_local19)
		end
		f11_local16 = true
		f11_local7 = LuaEnum.LOOT_CAMERA_TYPE.CHARACTER
	elseif f11_local0.type == @"signature_weapon" then
		local f11_local19 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local20 = @"hash_6EE92514250F3100"
		local f11_local21 = f11_local3
		local f11_local22 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local23 = @"menu/x_weapon"
		local f11_local24 = f11_local2[@"contracttitle"]
		if not f11_local24 then
			f11_local24 = 0x0
		end
		f11_local6 = f11_local19(f11_local20, f11_local21, f11_local22(f11_local23, f11_local24))
		f11_local20 = CoD.BlackMarketUtility.GetSignatureWeaponRef(CoD.BlackMarketTableUtility.GetContractSignatureWeapon(f11_arg0, f11_arg1))
		if f11_local20 then
			f11_local12 = f11_local20.signatureWeaponInfo.ref
			if f11_local20.signatureWeaponInfo.ref and CoD.CACUtility.GetItemGroupDisplayNameFromRef(Engine[@"getitemgroup"](Engine[@"hash_68FF94BB44442412"](f11_local20.signatureWeaponInfo.ref, Enum[@"emodes"][@"mode_multiplayer"]), Enum[@"statindexoffset"][@"hash_6569E84652131CD7"], Enum[@"emodes"][@"mode_multiplayer"])) then
				f11_local24 = Engine[@"hash_4F9F1239CFD921FE"]
				local f11_local25 = f11_local2[@"contractdescription"]
				if not f11_local25 then
					f11_local25 = 0x0
				end
				f11_local15 = f11_local24(f11_local25)
			end
		end
		f11_local7 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f11_local0.type == @"reactive_camo" then
		local f11_local19, f11_local20 = CoD.BlackMarketTableUtility.GetContractReactiveCamoRef(f11_arg0, f11_arg1)
		f11_local17 = f11_local19
		local f11_local21 = ""
		local f11_local22 = Engine[@"tablefindrows"](CoD.attachmentTable, Enum[@"attachmenttablecolumn_e"][@"hash_2419575E672F6FA2"], f11_local17)
		if f11_local22 ~= nil then
			f11_local21 = Engine[@"hash_4C6F8EC444864600"](CoD.attachmentTable, f11_local22[1], Enum[@"attachmenttablecolumn_e"][@"attachmenttable_column_name"])
		end
		local f11_local23 = CoD.BlackMarketUtility.GetWeaponRef(f11_local20)
		if f11_local23 then
			f11_local14 = f11_local23.weaponInfo
			f11_local12 = f11_local14.ref
		end
		local f11_local24 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local25 = @"hash_6EE92514250F3100"
		local f11_local26 = f11_local3
		local f11_local27 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local28 = @"hash_5EB9F7EA3A0EC1C1"
		local f11_local29 = f11_local21 or 0x0
		local f11_local30 = f11_local14.displayNameRef
		if not f11_local30 then
			f11_local30 = 0x0
		end
		f11_local6 = f11_local24(f11_local25, f11_local26, f11_local27(f11_local28, f11_local29, f11_local30))
		f11_local7 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f11_local0.type == @"mastercraft" or f11_local0.type == @"mk2" then
		local f11_local19 = CoD.BlackMarketTableUtility.GetContractMastercraft(f11_arg0, f11_arg1)
		f11_local17 = f11_local19
		local f11_local20 = CoD.BlackMarketUtility.GetMastercraftWeaponRef(f11_local19)
		if f11_local20 then
			f11_local12 = f11_local20.weaponInfo.ref
			f11_local14 = f11_local20.weaponInfo
			if f11_local14.displayNameRef then
				local f11_local18 = f11_local14.displayNameRef
			end
		end
		if f11_local0.type == @"mastercraft" then
			local f11_local31 = Engine[@"hash_4F9F1239CFD921FE"](0x81782ED786B4A3)
		end
		f11_local15 = f11_local31 or Engine[@"hash_4F9F1239CFD921FE"](@"hash_1D4314C41E9C9CFC")
		local f11_local21 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local22 = @"hash_6EE92514250F3100"
		local f11_local23 = f11_local3
		local f11_local24 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local25 = @"hash_5C130AF0934E5C11"
		local f11_local26 = f11_local2[@"contracttitle"]
		if not f11_local26 then
			f11_local26 = 0x0
		end
		local f11_local27 = f11_local14.displayNameRef
		if not f11_local27 then
			f11_local27 = 0x0
		end
		f11_local6 = f11_local21(f11_local22, f11_local23, f11_local24(f11_local25, f11_local26, f11_local27))
		f11_local7 = LuaEnum.LOOT_CAMERA_TYPE.WEAPON
	elseif f11_local0.type == @"character" then
		local f11_local19 = CoD.BlackMarketTableUtility.GetContractCharacter(f11_arg0, f11_arg1)
		local f11_local20 = Enum[@"emodes"][@"mode_warzone"]
		local f11_local21 = CoD.PlayerRoleUtility.GetHeroList(f11_local20)
		local f11_local22 = nil
		for f11_local26, f11_local27 in ipairs(f11_local21) do
			local f11_local28 = Engine[@"getpositionrolebundleinfo"](f11_local20, f11_local27.bodyIndex)
			if f11_local28 and f11_local19 == f11_local28[@"hash_41D6157DBA773DA3"] then
				f11_local22 = Engine[@"hash_682C5756563934AE"](f11_local20, f11_local27.bodyIndex)
				break
			end
		end
		if f11_local22 then
			f11_local23 = Engine[@"hash_284E3CB0C7D8BA11"](f11_local20, f11_local22)
			f11_local24 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f11_local20, f11_local23)
			f11_local25 = f11_local24.displayName
			f11_local26 = {
				mode = f11_local20,
				characterIndex = f11_local23,
				outfitIndex = 0,
				paletteIndex = 0,
			}
			f11_local27 = Engine[@"getherocustomizationtable"](f11_local26.mode, f11_local26.characterIndex)
			local f11_local28 = f11_local27.outfits[f11_local26.outfitIndex + 1]
			f11_local10 = f11_local22
			f11_local11 = f11_local26
		end
		f11_local23 = Engine[@"hash_4F9F1239CFD921FE"]
		f11_local24 = @"hash_55B333AF8D097F6"
		f11_local25 = f11_local3
		f11_local26 = Engine[@"hash_4F9F1239CFD921FE"]
		f11_local27 = f11_local2[@"contracttitle"]
		if not f11_local27 then
			f11_local27 = 0x0
		end
		f11_local6 = f11_local23(f11_local24, f11_local25, f11_local26(f11_local27))
		f11_local7 = LuaEnum.LOOT_CAMERA_TYPE.CHARACTER
	end
	if f11_local1 then
		local f11_local19 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local20 = @"hash_32FF79AC549C9A3B"
		local f11_local21 = Engine[@"hash_4F9F1239CFD921FE"]
		local f11_local22 = f11_local2[@"contractdescription"]
		if not f11_local22 then
			f11_local22 = 0x0
		end
		f11_local6 = f11_local19(f11_local20, f11_local21(f11_local22))
	end
	if f11_local9 == Engine[@"hash_4F9F1239CFD921FE"](0x0) then
		f11_local9 = f11_local6
	end
	local f11_local19 = {
		itemCategory = f11_local0.type,
		lootType = LuaEnum.LOOT_TYPE.CONTRACT,
		isContract = true,
		name = f11_local2[@"contracttitle"],
		desc = f11_local6,
		relatedItemName = f11_local18,
		contentsDesc = f11_local6,
		contentsDetailedDesc = f11_local9,
		mainExtraText = f11_local15,
		subExtraText = f11_local18 or @"hash_0",
		icon = f11_local2[@"contracticon"],
	}
	local f11_local20 = f11_local2[@"hash_6B3DE4579D73CEB6"]
	if not f11_local20 then
		f11_local20 = f11_local2[@"contracticon"]
	end
	f11_local19.inventoryIcon = f11_local20
	f11_local20 = f11_local2[@"hash_5D63FBB2BF3F4957"]
	if not f11_local20 then
		f11_local20 = f11_local2[@"contracticon"]
	end
	f11_local19.detailsImage = f11_local20
	f11_local19.popupImage = 0x0
	f11_local19.primaryImage = 0x0
	f11_local19.previewImage = f11_local2[@"contracticon"]
	f11_local19.category = @"menu/special_order"
	f11_local19.rarity = CoD.BlackMarketUtility.GetLootRarityType(f11_local0.rarity)
	f11_local19.earnedRewardCount = f11_local4
	f11_local19.totalRewardCount = f11_local3
	f11_local19.rewardFractionString = Engine[@"hash_4F9F1239CFD921FE"](@"hash_31DD58AA20274399", f11_local4, f11_local3)
	f11_local19.setBonusImage = 0x0
	f11_local19.hashName = f11_local0.namehash
	f11_local19.contractId = f11_arg1
	f11_local19.skuID = f11_arg1
	f11_local19.purchased = CoD.ContractUtility.IsContractPurchased(f11_arg0, f11_arg1)
	f11_local19.complete = CoD.ContractUtility.IsContractComplete(f11_arg0, f11_arg1)
	f11_local19.character = f11_local10
	f11_local19.outfitIndexes = f11_local11
	f11_local19.gesture_index = -1
	f11_local19.weaponRef = f11_local12
	f11_local19.signatureWeaponInfo = f11_local13
	f11_local19.baseWeaponInfo = f11_local14
	f11_local19.dupe = false
	f11_local19.reroll = false
	f11_local19.seasonal = f11_local1
	f11_local19.allowTogglePreview = false
	f11_local19.allowFrozenMoment = f11_local16
	f11_local20 = f11_local2[@"hash_572BCA0762CE7B9C"]
	if not f11_local20 then
		f11_local20 = ""
	end
	f11_local19.movieName = f11_local20
	f11_local19.isLooping = true
	f11_local19.isStreamed = false
	f11_local19.shopPreview = true
	f11_local19.camoRef = f11_local17
	f11_local19.price = f11_local0.price
	f11_local19.timeStamp = ""
	f11_local19.cameraType = f11_local7
	f11_local19.isContract = true
	return f11_local19
end
CoD.ContractUtility.AppendPurchasableContractSlotModels = function(f12_arg0, f12_arg1, f12_arg2)
	local f12_local0 = Engine[@"createmodel"](Engine[@"getglobalmodel"](), "ItemshopRotation")
	f12_arg1.timerModel = f12_local0["loot_itemshop_slot" .. f12_arg2 .. "_timer"]
end
CoD.ContractUtility.GetSoonestContractTimer = function(f13_arg0)
	local f13_local0 = DataSources.AutoEvents.getModel(f13_arg0)
	local f13_local1 = f13_local0["autoevent_contract" .. 1 .. "_timer_raw"]
	local f13_local2 = f13_local0["autoevent_contract" .. 2 .. "_timer_raw"]
	if not f13_local1 and not f13_local2 then
		return nil
	elseif not f13_local2 or f13_local1:get() < f13_local2:get() then
		return f13_local0["autoevent_contract" .. 1 .. "_timer"]
	else
		return f13_local0["autoevent_contract" .. 2 .. "_timer"]
	end
end
CoD.ContractUtility.IsContractActive = function(f14_arg0, f14_arg1)
	for f14_local3, f14_local4 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f14_arg0)) do
		if f14_local4.id == f14_arg1 then
			return true
		end
	end
	return false
end
CoD.ContractUtility.SortPurchasedContractModels = function(f15_arg0, f15_arg1)
	if f15_arg0.properties.isActive ~= f15_arg1.properties.isActive then
		return f15_arg0.properties.isActive
	elseif f15_arg0.models.complete ~= f15_arg1.models.complete then
		return not f15_arg0.models.complete
	elseif f15_arg0.properties.progress ~= f15_arg1.properties.progress then
		return f15_arg1.properties.progress < f15_arg0.properties.progress
	elseif f15_arg0.models.rarity ~= f15_arg1.models.rarity then
		return f15_arg1.models.rarity < f15_arg0.models.rarity
	else
		return tonumber(f15_arg0.models.contractId) < tonumber(f15_arg1.models.contractId)
	end
end
CoD.ContractUtility.GetPurchasedContractsModels = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
	local f16_local0 = {}
	for f16_local6, f16_local7 in ipairs(Engine[@"hash_543149249AED4499"](f16_arg0)) do
		if not (Engine[@"tablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_TYPE, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, f16_local7.id) == @"event") then
			local f16_local4 = CoD.ContractUtility.GetContractListModels(f16_arg0, f16_local7.id)
			if not (not f16_arg1 or f16_local4.complete) or f16_arg2 and f16_local4.complete then
				local f16_local5
				if not f16_local4.complete then
					f16_local5 = CoD.ContractUtility.IsContractActive(f16_arg0, tonumber(f16_local4.contractId))
				else
					f16_local5 = false
				end
				table.insert(f16_local0, {
					models = f16_local4,
					properties = {
						inPurchasableRow = false,
						contractModels = f16_local4,
						isActive = f16_local5,
						progress = f16_local4.earnedRewardCount / f16_local4.totalRewardCount,
					},
				})
			end
		end
	end
	table.sort(f16_local0, CoD.ContractUtility.SortPurchasedContractModels)
	if f16_arg3 and f16_arg3 > 0 and f16_arg3 < #f16_local0 then
		f16_local1 = {}
		for f16_local2 = 1, f16_arg3, 1 do
			table.insert(f16_local1, f16_local0[f16_local2])
		end
		return f16_local1
	else
		return f16_local0
	end
end
CoD.ContractUtility.GetLootContractIcon = function(f17_arg0, f17_arg1)
	if not CoD.ContractUtility.LootContractIconTable then
		CoD.ContractUtility.LootContractIconTable = {}
		local f17_local0 = CoD.ContractUtility.GetContractAsset(@"loot_contract_categories")
		if f17_local0 and f17_local0.categories then
			for f17_local9, f17_local10 in ipairs(f17_local0.categories) do
				CoD.ContractUtility.LootContractIconTable[f17_local10[@"categoryname"]] = {}
				if f17_local10.icons then
					for f17_local7, f17_local8 in ipairs(f17_local10.icons) do
						CoD.ContractUtility.LootContractIconTable[f17_local10[@"categoryname"]][f17_local7 - 1] = f17_local8[@"categoryicon"]
					end
				end
			end
		end
	end
	return CoD.ContractUtility.LootContractIconTable[f17_arg0] and CoD.ContractUtility.LootContractIconTable[f17_arg0][f17_arg1] or @"blacktransparent"
end
CoD.ContractUtility.PurchasedContractsTabDatasource = function(f18_arg0, f18_arg1, f18_arg2, f18_arg3)
	local f18_local0 = "PurchasedContractsTabs_" .. f18_arg3
	DataSources[f18_local0] = ListHelper_SetupDataSource(f18_local0, function(f19_arg0)
		return CoD.ContractUtility.GetPurchasedContractsModels(f19_arg0, f18_arg1, f18_arg2)
	end, true)
	return f18_local0
end
DataSources.PurchasableContracts = ListHelper_SetupDataSource(
	"PurchasableContracts",
	function(f20_arg0, f20_arg1)
		local f20_local0 = {}
		local f20_local1 = DataSources.AutoEvents.getModel(f20_arg0)
		for f20_local5, f20_local6 in ipairs(CoD.ContractUtility.GetPurchasableContractIds()) do
			local f20_local7 = CoD.ContractUtility.GetContractListModels(f20_arg0, f20_local6)
			CoD.ContractUtility.AppendPurchasableContractSlotModels(f20_arg0, f20_local7, f20_local5)
			table.insert(f20_local0, {
				models = f20_local7,
				properties = {
					inPurchasableRow = true,
					contractModels = f20_local7,
				},
			})
		end
		return f20_local0
	end,
	nil,
	nil,
	function(f21_arg0, f21_arg1, f21_arg2)
		if not f21_arg1.__purchasableContractsSubscriptions then
			f21_arg1.__purchasableContractsSubscriptions = true
			local f21_local0 = f21_arg1
			local f21_local1 = f21_arg1.subscribeToModel
			local f21_local2 = Engine[@"getglobalmodel"]()
			f21_local1(f21_local0, f21_local2:create("ContractsForceUpdate"), function()
				f21_arg1:updateDataSource()
			end, false)
			f21_arg1:subscribeToGlobalModel(f21_arg0, "AutoEvents", "cycled", function()
				f21_arg1:updateDataSource()
			end)
		end
	end
)
DataSources.PurchasedContracts = ListHelper_SetupDataSource(
	"PurchasedContracts",
	function(f24_arg0, f24_arg1)
		return CoD.ContractUtility.GetPurchasedContractsModels(f24_arg0, true, f24_arg1._excludeCompletedContracts ~= true, f24_arg1._maxShowContracts)
	end,
	nil,
	nil,
	function(f25_arg0, f25_arg1, f25_arg2)
		if f25_arg1.updateSubscription then
			f25_arg1:removeSubscription(f25_arg1.updateSubscription)
		end
		local f25_local0 = Engine[@"getglobalmodel"]()
		f25_arg1.updateSubscription = f25_arg1:subscribeToModel(f25_local0:create("ContractsForceUpdate"), function()
			f25_arg1:updateDataSource()
		end, false)
	end
)
DataSources.PurchasedContractsTabs = ListHelper_SetupDataSource("PurchasedContractsTabs", function(f27_arg0, f27_arg1)
	return {
		{
			models = {
				name = @"hash_28DF2A8D2479730B",
				noContractsString = @"hash_711888F1F867EFA9",
				contractsListDatasource = CoD.ContractUtility.PurchasedContractsTabDatasource(f27_arg0, true, false, "Purchased"),
			},
		},
		{
			models = {
				name = @"menu/completed",
				noContractsString = @"hash_5BDBDB0BC28D465A",
				contractsListDatasource = CoD.ContractUtility.PurchasedContractsTabDatasource(f27_arg0, false, true, "Completed"),
			},
		},
	}
end, true)
DataSources.ReplaceContractList = ListHelper_SetupDataSource("ReplaceContractList", function(f28_arg0, f28_arg1)
	local f28_local0 = {}
	for f28_local4, f28_local5 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f28_arg0)) do
		local f28_local6 = CoD.ContractUtility.GetContractAsset(f28_local5.namehash)
		table.insert(f28_local0, {
			models = {
				displayText = f28_local6[@"contracttitle"],
			},
			properties = {
				contractSlot = f28_local5.slot,
				action = CoD.ContractUtility.SetContractAndClosePopup,
			},
		})
	end
	return f28_local0
end, true)
DataSources.PurchaseContractConfirmationButtons = ListHelper_SetupDataSource("PurchaseContractConfirmationButtons", function(f29_arg0)
	local f29_local0 = function(f30_arg0, f30_arg1, f30_arg2, f30_arg3, f30_arg4)
		local f30_local0 = f30_arg3
		f30_arg4.__activatePurchasedContract = f30_local0
		local f30_local1 = Engine[@"getmodelforcontroller"](f30_arg2)
		f30_local1.purchaseContractNoActivate:set(f30_local0 ~= true)
		SetWorkingStateAndPurchaseDWSKU(f30_arg0, f30_arg1, f30_arg2, false)
	end
	if CoD.ContractUtility.IsActiveContractSlotOpen(f29_arg0) then
		return {}
	else
		return {
			{
				models = {
					displayText = @"hash_258EF4E74415F4F3",
				},
				properties = {
					action = f29_local0,
					actionParam = true,
				},
			},
			{
				models = {
					displayText = @"menu/purchase",
				},
				properties = {
					action = f29_local0,
					actionParam = false,
				},
			},
		}
	end
end, true)
DataSources.CaseExchangeContractConfirmationButtons = ListHelper_SetupDataSource("CaseExchangeContractConfirmationButtons", function(f31_arg0)
	local f31_local0 = function(f32_arg0, f32_arg1, f32_arg2, f32_arg3, f32_arg4)
		local f32_local0 = f32_arg3
		f32_arg4.__activatePurchasedContract = f32_local0
		local f32_local1 = Engine[@"getmodelforcontroller"](f32_arg2)
		f32_local1.purchaseContractNoActivate:set(f32_local0 ~= true)
		CoD.BlackMarketUtility.SetWorkingStateAndExchangeLootCases(f32_arg0, f32_arg0, f32_arg2)
	end
	if CoD.ContractUtility.IsActiveContractSlotOpen(f31_arg0) then
		return {}
	else
		return {
			{
				models = {
					displayText = @"hash_7387F37DE74A8D85",
				},
				properties = {
					action = f31_local0,
					actionParam = true,
				},
			},
			{
				models = {
					displayText = @"hash_7C2737E72EC4A26",
				},
				properties = {
					action = f31_local0,
					actionParam = false,
				},
			},
		}
	end
end, true)
CoD.ContractUtility.OpenContractDetails = function(f33_arg0, f33_arg1, f33_arg2)
	return OpenOverlay(f33_arg0, "ContractDetails", f33_arg2, {
		_model = f33_arg1:getModel(),
		_properties = {
			contractModels = f33_arg1.contractModels,
		},
	})
end
CoD.ContractUtility.OpenContractDetailsSunset = function(f34_arg0, f34_arg1, f34_arg2)
	return OpenOverlay(f34_arg0, "ContractDetailsSunset", f34_arg2, {
		_model = f34_arg1:getModel(),
		_properties = {
			contractModels = f34_arg1.contractModels,
			isSunsetPurchaseContractScreen = true,
		},
	})
end
CoD.ContractUtility.OpenSupplyChainContractDetails = function(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = f35_arg1.contractModels
	local f35_local1 = CoD.ContractUtility.GetContractAsset(f35_local0.hashName)
	if f35_local1 then
		f35_local0.movieName = f35_local1[@"hash_572BCA0762CE7B9C"] or ""
	end
	local f35_local2 = Engine[@"getmodelforcontroller"](f35_arg2)
	f35_local2 = f35_local2:create("SupplyChainContractDetailModel")
	LuaUtils.CreateModelsFromTable(f35_local2, f35_local0)
	return OpenOverlay(f35_arg0, "ContractDetails", f35_arg2, {
		_model = f35_local2,
		_properties = {
			contractModels = f35_local0,
		},
	})
end
CoD.ContractUtility.SelectActiveContractAction = function(f36_arg0, f36_arg1)
	if CoD.ContractUtility.IsActiveContractSlotOpen(f36_arg1) then
		CoD.ContractUtility.SetActiveContract(f36_arg0, f36_arg1, CoD.ContractUtility.ActiveContractSlot)
		GoBack(f36_arg0, f36_arg1)
		ForceNotifyGlobalModel(f36_arg1, "ContractsForceUpdate")
	else
		OpenPopup(f36_arg0, "ReplaceActiveContractOverlay", f36_arg1, {
			_model = f36_arg0:getModel(),
		})
	end
end
CoD.ContractUtility.ReplaceActiveContract = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3)
	CoD.ContractUtility.SetActiveContract(f37_arg1, f37_arg2, CoD.ContractUtility.ActiveContractSlot)
	f37_arg0:setState(f37_arg2, "WorkingState")
	if not f37_arg0.streamUpdateTimer then
		local f37_local0 = 0
		f37_arg0.streamUpdateTimer = LUI.UITimer.newElementTimer(500, false, function(f38_arg0)
			local f38_local0 = true
			for f38_local4, f38_local5 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f37_arg2)) do
				if not Engine[@"hash_439AD08FA7D6CF44"](f37_arg2, f38_local5.namehash) then
					f38_local0 = false
					break
				end
			end
			if f38_local0 or f37_arg3 < f37_local0 then
				if CoD.perController[f37_arg2]._isPurchasedContractMenu then
					f37_arg1 = GoBack(f37_arg1, f37_arg2)
				end
				DelayCloseAndGoBack(f37_arg1, f37_arg2, 0)
				ForceNotifyGlobalModel(f37_arg2, "ContractsForceUpdate")
				f37_arg0.streamUpdateTimer:close()
				f37_arg0.streamUpdateTimer = nil
			else
				f37_local0 = f37_local0 + f38_arg0.timeElapsed
			end
		end)
		f37_arg0:addElement(f37_arg0.streamUpdateTimer)
	end
end
CoD.ContractUtility.IsActiveContractSlotOpen = function(f39_arg0)
	for f39_local4, f39_local5 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f39_arg0)) do
		local f39_local3
		if f39_local5.id ~= 0 then
			f39_local3 = CoD.ContractUtility.IsContractComplete(f39_arg0, f39_local5.id)
		else
			f39_local3 = false
		end
		if f39_local5.id ~= 0 and not f39_local3 and f39_local5.slot == CoD.ContractUtility.ActiveContractSlot then
			return false
		end
	end
	return true
end
CoD.ContractUtility.IsElementContractActive = function(f40_arg0, f40_arg1)
	local f40_local0 = f40_arg0:getModel(f40_arg1, "contractId")
	local f40_local1 = f40_local0 and f40_local0:get()
	if f40_local1 and CoD.ContractUtility.IsContractPurchased(f40_arg1, f40_local1) then
		return CoD.ContractUtility.IsContractActive(f40_arg1, tonumber(f40_local1))
	else
		return false
	end
end
CoD.ContractUtility.IsPurchasedContractCountGreaterThan = function(f41_arg0, f41_arg1)
	return f41_arg1 < #Engine[@"hash_543149249AED4499"](f41_arg0)
end
CoD.ContractUtility.ShowPurchasedContractMenuButton = function(f42_arg0, f42_arg1)
	local f42_local0 = 0
	for f42_local4, f42_local5 in ipairs(Engine[@"hash_543149249AED4499"](f42_arg0)) do
		if not (Engine[@"tablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_TYPE, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, f42_local5.id) == @"event") then
			if CoD.ContractUtility.IsContractComplete(f42_arg0, f42_local5.id) then
				return true
			elseif f42_arg1 < f42_local0 + 1 then
				return true
			end
		end
	end
	return false
end
CoD.ContractUtility.GetContractProgessBarWipe = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4, f43_arg5)
	local f43_local0 = f43_arg0
	local f43_local1 = f43_arg0.totalRewardCount
	if f43_local1 then
		f43_local1 = f43_local0 and f43_arg0.totalRewardCount:get()
	end
	if f43_local1 and f43_local1 > 0 then
		return 0, f43_arg2 / f43_local1, 0, 1
	else
		return 0, 0, 0, 0
	end
end
CoD.ContractUtility.GetContractTimerModelValue = function(f44_arg0)
	if type(f44_arg0) == "userdata" then
		return f44_arg0:get() or ""
	else
		return ""
	end
end
CoD.ContractUtility.GetPurchaseContractConfirmDesc = function(f45_arg0, f45_arg1, f45_arg2)
	local f45_local0 = ""
	local f45_local1 = ""
	local f45_local2 = f45_arg0.rarity
	if f45_local2 then
		f45_local2 = f45_arg0.rarity:get()
	end
	if f45_local2 and CoD.BlackMarketUtility.LootRarityStrings[f45_local2] then
		local f45_local3 = Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[f45_local2])
		if f45_arg0.seasonal:get() == true then
			f45_local3 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_366847BAEBB3A887")
		end
		f45_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", f45_local3, Engine[@"hash_4F9F1239CFD921FE"](f45_arg2))
	end
	if CoD.ContractUtility.IsActiveContractSlotOpen(f45_arg1) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_2AA056D0232681A", f45_local0)
	end
	for f45_local7, f45_local8 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f45_arg1)) do
		local f45_local9 = CoD.ContractUtility.GetContractAsset(f45_local8.namehash)
		if f45_local9 then
			f45_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[CoD.BlackMarketUtility.GetLootRarityType(f45_local8.rarity)]), Engine[@"hash_4F9F1239CFD921FE"](f45_local9[@"contracttitle"]))
			break
		end
	end
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C37F781EACE9704", f45_local0, f45_local1)
end
CoD.ContractUtility.GetCaseExchangeContractConfirmDesc = function(f46_arg0, f46_arg1, f46_arg2)
	local f46_local0 = ""
	local f46_local1 = ""
	local f46_local2 = f46_arg0.rarity
	if f46_local2 then
		f46_local2 = f46_arg0.rarity:get()
	end
	if f46_local2 and CoD.BlackMarketUtility.LootRarityStrings[f46_local2] then
		local f46_local3 = Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[f46_local2])
		if f46_arg0.seasonal:get() == true then
			f46_local3 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_366847BAEBB3A887")
		end
		f46_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", f46_local3, Engine[@"hash_4F9F1239CFD921FE"](f46_arg2))
	end
	if CoD.ContractUtility.IsActiveContractSlotOpen(f46_arg1) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4B4BC2FFC33B5594", f46_local0)
	end
	for f46_local7, f46_local8 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f46_arg1)) do
		local f46_local9 = CoD.ContractUtility.GetContractAsset(f46_local8.namehash)
		if f46_local9 then
			f46_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[CoD.BlackMarketUtility.GetLootRarityType(f46_local8.rarity)]), Engine[@"hash_4F9F1239CFD921FE"](f46_local9[@"contracttitle"]))
			break
		end
	end
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_1C37F781EACE9704", f46_local0, f46_local1)
end
CoD.ContractUtility.UsePurchaseAndActivateContractCompleteTitleIfNeeded = function(f47_arg0, f47_arg1)
	if not CoD.ContractUtility.IsActiveContractSlotOpen(f47_arg0) then
		local f47_local0 = Engine[@"getmodelforcontroller"](f47_arg0)
		f47_local0 = f47_local0.purchaseContractNoActivate
		if not (f47_local0 and f47_local0:get()) then
			return @"hash_32B15E3C557617BA"
		end
	end
	return f47_arg1
end
CoD.ContractUtility.UseCaseExchangeAndActivateContractCompleteTitleIfNeeded = function(f48_arg0, f48_arg1)
	if not CoD.ContractUtility.IsActiveContractSlotOpen(f48_arg0) then
		local f48_local0 = Engine[@"getmodelforcontroller"](f48_arg0)
		f48_local0 = f48_local0.purchaseContractNoActivate
		if not (f48_local0 and f48_local0:get()) then
			return @"hash_7870CD676671478"
		end
	end
	return f48_arg1
end
CoD.ContractUtility.GetPurchaseContractCompleteDesc = function(f49_arg0, f49_arg1, f49_arg2)
	local f49_local0 = ""
	local f49_local1 = ""
	local f49_local2 = f49_arg0.rarity
	if f49_local2 then
		f49_local2 = f49_arg0.rarity:get()
	end
	if f49_local2 and CoD.BlackMarketUtility.LootRarityStrings[f49_local2] then
		f49_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[f49_local2]), Engine[@"hash_4F9F1239CFD921FE"](f49_arg2))
	end
	if CoD.ContractUtility.IsActiveContractSlotOpen(f49_arg1) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E76A4CBE4AD2C43", f49_local0)
	end
	local f49_local3 = Engine[@"getmodelforcontroller"](f49_arg1)
	f49_local3 = f49_local3.purchaseContractNoActivate
	if f49_local3 and f49_local3:get() then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_116157242367E325", f49_local0)
	end
	for f49_local7, f49_local8 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f49_arg1)) do
		local f49_local9 = CoD.ContractUtility.GetContractAsset(f49_local8.namehash)
		if f49_local9 then
			f49_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[CoD.BlackMarketUtility.GetLootRarityType(f49_local8.rarity)]), Engine[@"hash_4F9F1239CFD921FE"](f49_local9[@"contracttitle"]))
			break
		end
	end
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_78CD2826E5E9A35D", f49_local0, f49_local1, f49_local1)
end
CoD.ContractUtility.GetCaseExchangeContractCompleteDesc = function(f50_arg0, f50_arg1, f50_arg2)
	local f50_local0 = ""
	local f50_local1 = ""
	local f50_local2 = f50_arg0.rarity
	if f50_local2 then
		f50_local2 = f50_arg0.rarity:get()
	end
	if f50_local2 and CoD.BlackMarketUtility.LootRarityStrings[f50_local2] then
		f50_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[f50_local2]), Engine[@"hash_4F9F1239CFD921FE"](f50_arg2))
	end
	if CoD.ContractUtility.IsActiveContractSlotOpen(f50_arg1) then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5E76A4CBE4AD2C43", f50_local0)
	end
	local f50_local3 = Engine[@"getmodelforcontroller"](f50_arg1)
	f50_local3 = f50_local3.purchaseContractNoActivate
	if f50_local3 and f50_local3:get() then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7D246DD880C2FE4F", f50_local0)
	end
	for f50_local7, f50_local8 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f50_arg1)) do
		local f50_local9 = CoD.ContractUtility.GetContractAsset(f50_local8.namehash)
		if f50_local9 then
			f50_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[CoD.BlackMarketUtility.GetLootRarityType(f50_local8.rarity)]), Engine[@"hash_4F9F1239CFD921FE"](f50_local9[@"contracttitle"]))
			break
		end
	end
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_799D0E4B9983D33F", f50_local0, f50_local1, f50_local1)
end
CoD.ContractUtility.GetActivateContractConfirmDesc = function(f51_arg0, f51_arg1, f51_arg2)
	local f51_local0 = ""
	local f51_local1 = ""
	local f51_local2 = f51_arg0.rarity
	if f51_local2 then
		f51_local2 = f51_arg0.rarity:get()
	end
	if f51_local2 and CoD.BlackMarketUtility.LootRarityStrings[f51_local2] then
		f51_local0 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[f51_local2]), Engine[@"hash_4F9F1239CFD921FE"](f51_arg2))
	end
	for f51_local6, f51_local7 in ipairs(CoD.BlackMarketUtility.GetActiveContracts(f51_arg1)) do
		local f51_local8 = CoD.ContractUtility.GetContractAsset(f51_local7.namehash)
		if f51_local8 then
			f51_local1 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_102F37DE5E04FC8", Engine[@"hash_4F9F1239CFD921FE"](CoD.BlackMarketUtility.LootRarityStrings[CoD.BlackMarketUtility.GetLootRarityType(f51_local7.rarity)]), Engine[@"hash_4F9F1239CFD921FE"](f51_local8[@"contracttitle"]))
			break
		end
	end
	return Engine[@"hash_4F9F1239CFD921FE"](@"hash_4486419650A714D1", f51_local0, f51_local1)
end
CoD.ContractUtility.OpenedContractExpired = function(f52_arg0, f52_arg1, f52_arg2)
	return CoD.BlackMarketUtility.WasItemCycled(f52_arg2, f52_arg1)
end
