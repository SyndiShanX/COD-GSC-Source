CoD.BountyHunterUtility = {}
CoD.BountyHunterUtility.PackageTableName = @"bounty_hunter_package_list"
CoD.BountyHunterUtility.PurchaseCostDefaultMultiplier = 1
CoD.BountyHunterUtility.RefillCostDefaultMultiplier = 1
DataSources.BountyHunterWeaponGroups = ListHelper_SetupDataSource("BountyHunterWeaponGroups", function(f1_arg0, f1_arg1)
	local f1_local0 = {}
	local f1_local1 = f1_arg1.menu._packageType
	if f1_local1 then
		local f1_local2 = f1_arg1.menu._model
		local f1_local3 = Engine[@"currentsessionmode"]()
		local f1_local4 = nil
		if f1_local2[f1_local1] and f1_local2[f1_local1]:get() and f1_local2[f1_local1]:get() > 0 then
			local f1_local5 = CoD.BountyHunterUtility.GetGetPackageByID(f1_local2[f1_local1]:get())
			f1_local4 = f1_local5.itemGroup
		end
		local f1_local5 = function(f2_arg0, f2_arg1)
			for f2_local3, f2_local4 in ipairs(f2_arg0) do
				if f2_local4.itemGroup ~= Enum[@"itemgroup_t"][@"itemgroup_special"] then
					table.insert(f1_local0, {
						models = {
							name = f2_local4.name,
							available = true,
						},
						properties = {
							loadoutType = f2_arg1,
							category = f2_local4.weapon_category,
							itemGroup = f2_local4.itemGroup,
						},
					})
				end
			end
		end
		f1_local5(CoD.CACUtility.GetWeaponGroupsNames(f1_local1), f1_local1)
	end
	return f1_local0
end, true)
DataSources.BountyHunterPackages = ListHelper_SetupDataSource("BountyHunterPackages", function(f3_arg0, f3_arg1)
	local f3_local0 = {}
	local f3_local1 = nil
	if f3_arg1.menu._packageType then
		f3_local1 = CoD.BountyHunterUtility.GetPackagesOfTypeAndGroup(f3_arg1.menu._packageType, f3_arg1.menu._itemGroup)
	else
		f3_local1 = CoD.BountyHunterUtility.GetBountyHunterPackageTable()
	end
	for f3_local11, f3_local12 in ipairs(f3_local1) do
		local f3_local13 = {}
		for f3_local6, f3_local7 in ipairs(f3_local12.items) do
			local f3_local9 = CoD.BountyHunterUtility.BuildWeaponPackageModelsList(f3_arg0, f3_local7)
			if f3_local12.packageType == "mobility" or f3_local12.packageType == "assault" or f3_local12.packageType == "recon" or f3_local12.packageType == "support" then
				local f3_local5 = f3_arg1.menu:getModel()
				f3_local9.trackModel = f3_local5[f3_local12.packageType .. "Track"]
				f3_local9.trackTier = f3_local12.trackTier
			end
			f3_local13["item" .. f3_local6] = f3_local9
		end
		f3_local13.packageType = f3_local12.packageType
		f3_local13.buyCost = f3_local12.purchaseCost
		f3_local13.packageID = f3_local12.packageID
		f3_local10 = f3_arg1.menu:getModel()
		f3_local13.trackModel = f3_local10[f3_local12.packageType .. "Track"]
		f3_local13.trackTier = f3_local12.trackTier
		table.insert(f3_local0, {
			models = f3_local13,
		})
	end
	return f3_local0
end)
DataSources.BountyHunterPrimaryAttachments = ListHelper_SetupDataSource("BountyHunterPrimaryAttachments", function(f4_arg0, f4_arg1)
	return CoD.BountyHunterUtility.SetupAttachmentDataSource(f4_arg0, f4_arg1, "primary")
end)
DataSources.BountyHunterSecondaryAttachments = ListHelper_SetupDataSource("BountyHunterSecondaryAttachments", function(f5_arg0, f5_arg1)
	return CoD.BountyHunterUtility.SetupAttachmentDataSource(f5_arg0, f5_arg1, "secondary")
end)
CoD.BountyHunterUtility.SetupAttachmentDataSource = function(f6_arg0, f6_arg1, f6_arg2)
	if not f6_arg1._setupSubscriptions then
		f6_arg1._setupSubscriptions = true
		f6_arg1:linkToElementModel(f6_arg1.menu, f6_arg2, true, function(model)
			if model:get() ~= 0 then
				f6_arg1:updateDataSource()
			end
		end, true)
	end
	local f6_local0 = {}
	local f6_local1 = f6_arg1.menu:getModel()
	f6_local1 = f6_local1[f6_arg2]:get()
	local f6_local2 = Engine[@"getgametypesetting"](@"hash_1B34B26470F4368")
	if not f6_local2 then
		f6_local2 = CoD.BountyHunterUtility.PurchaseCostDefaultMultiplier
	end
	if f6_local1 > 0 then
		local f6_local3 = CoD.BountyHunterUtility.GetGetPackageByID(f6_local1)
		local f6_local4 = f6_local3.items[1].itemIndex
		if f6_local3.attachmentUpgrades then
			for f6_local16, f6_local17 in ipairs(f6_local3.attachmentUpgrades) do
				local f6_local18 = {}
				local f6_local19 = f6_local17[@"attachmentlist"]
				local f6_local13 = 1
				for f6_local8, f6_local9 in ipairs(LUI.splitString(f6_local19, "+")) do
					local f6_local11 = CoD.BountyHunterUtility.BuildAttachmentItemModelsList(f6_arg0, f6_local9, f6_local4)
					local f6_local12 = f6_arg1.menu:getModel()
					f6_local11.trackModel = f6_local12[f6_local3.packageType .. "AttachmentTrack"]
					f6_local11.trackTier = f6_local16
					f6_local18["item" .. f6_local13] = f6_local11
					f6_local13 = f6_local13 + 1
				end
				for f6_local14 = f6_local13, 3, 1 do
					f6_local18["item" .. f6_local14] = {
						trackTier = -1,
					}
				end
				f6_local18.trackTier = f6_local16
				f6_local18.packageType = f6_local3.packageType .. "_attachment_" .. f6_local18.trackTier
				f6_local18.buyCost = f6_local17[@"purchasecost"] * f6_local2
				f6_local18.packageID = f6_local3.packageID
				f6_local14 = f6_arg1.menu:getModel()
				f6_local18.trackModel = f6_local14[f6_local3.packageType .. "AttachmentTrack"]
				table.insert(f6_local0, {
					models = f6_local18,
				})
			end
		end
	end
	return f6_local0
end
DataSources.BountyHunterLoadout = {
	getModel = function(f8_arg0)
		local f8_local0 = Engine[@"getglobalmodel"]()
		return f8_local0:create("BountyHunterLoadout")
	end,
}
CoD.BountyHunterUtility.UsePurchaseCostMultiplier = function(f9_arg0)
	return f9_arg0 ~= "killstreak"
end
CoD.BountyHunterUtility.GetBountyHunterPackageTable = function()
	if not CoD.BountyHunterUtility.BountyHunterPackages then
		local f10_local0 = Engine[@"hash_7A7E3CD65E63086F"](CoD.BountyHunterUtility.PackageTableName)
		local f10_local1 = Engine[@"currentsessionmode"]()
		local f10_local2 = {}
		local f10_local3 = Engine[@"getgametypesetting"](@"hash_1B34B26470F4368")
		if not f10_local3 then
			f10_local3 = CoD.BountyHunterUtility.PurchaseCostDefaultMultiplier
		end
		local f10_local4 = Engine[@"getgametypesetting"](@"hash_71B2B43696E16252")
		if not f10_local4 then
			f10_local4 = CoD.BountyHunterUtility.RefillCostDefaultMultiplier
		end
		for f10_local16, f10_local17 in ipairs(f10_local0) do
			if f10_local17.packageitems then
				local f10_local8 = nil
				local f10_local9 = {}
				for f10_local13, f10_local14 in pairs(f10_local17.packageitems) do
					local f10_local15 = CoD.CACUtility.GetUnlockableItemInfoByAssetHash(f10_local14[@"item"], f10_local1)
					if f10_local15 then
						if not f10_local8 then
							f10_local8 = f10_local15.itemGroup
						end
						table.insert(f10_local9, f10_local15)
					end
					if LUI.DEV then
						Engine[@"printerror"](Enum[@"consolelabel_e"][@"con_label_lui"], "LUI Error: Bounty Hunter Package contains a bad unlockable item: " .. tostring(f10_local14[@"item"]) .. " (check to make sure its included in this mode.\n")
					end
				end
				if #f10_local9 > 0 then
					f10_local10 = table.insert
					f10_local11 = f10_local2
					f10_local12 = {}
					if not CoD.BountyHunterUtility.UsePurchaseCostMultiplier(f10_local8) then
						f10_local13 = f10_local17[@"purchasecost"]
						if not f10_local13 then
						else
							f10_local12.purchaseCost = f10_local13
							f10_local12.packageType = f10_local17[@"packagetype"]
							f10_local12.itemGroup = f10_local8
							f10_local12.items = f10_local9
							f10_local12.packageID = f10_local16
							f10_local12.refillCost = f10_local17[@"refillcost"] * f10_local4
							f10_local12.refillAmmo = f10_local17[@"refillammo"]
							f10_local12.trackTier = f10_local17[@"tracktier"]
							f10_local12.attachmentUpgrades = f10_local17.attachmentupgrades
							f10_local10(f10_local11, f10_local12)
						end
					end
					f10_local13 = f10_local17[@"purchasecost"] * f10_local3
				end
			end
		end
		table.sort(f10_local2, function(f11_arg0, f11_arg1)
			if f11_arg0.trackTier == f11_arg1.trackTier then
				if f11_arg0.purchaseCost == f11_arg1.purchaseCost then
					return f11_arg0.packageID < f11_arg1.packageID
				else
					return f11_arg0.purchaseCost < f11_arg1.purchaseCost
				end
			else
				return f11_arg0.trackTier < f11_arg1.trackTier
			end
		end)
		CoD.BountyHunterUtility.BountyHunterPackages = f10_local2
	end
	return CoD.BountyHunterUtility.BountyHunterPackages
end
CoD.BountyHunterUtility.BuildWeaponPackageModelsList = function(f12_arg0, f12_arg1)
	local f12_local0 = {
		damage = 0,
		range = 0,
		fireRate = 0,
		accuracy = 0,
	}
	if f12_arg1.attributesTable then
		f12_local0.damage = f12_arg1.attributesTable.damage
		f12_local0.range = f12_arg1.attributesTable.range
		f12_local0.fireRate = f12_arg1.attributesTable.fireRate
		f12_local0.accuracy = f12_arg1.attributesTable.accuracy
	end
	local f12_local1 = CoD.BountyHunterUtility.BuildPackageModelsList(f12_arg0, f12_arg1)
	f12_local1.weaponAttributes = f12_local0
	return f12_local1
end
CoD.BountyHunterUtility.BuildPackageModelsList = function(f13_arg0, f13_arg1)
	local f13_local0 = Engine[@"currentsessionmode"]()
	return {
		itemIndex = f13_arg1.itemIndex,
		displayName = f13_arg1.displayName,
		image = CoD.CACUtility.GetPreviewImage(f13_local0, f13_arg1),
		imageLarge = CoD.CACUtility.GetPreviewImageLarge(f13_local0, f13_arg1),
		description = f13_arg1.description,
	}
end
CoD.BountyHunterUtility.BuildAttachmentItemModelsList = function(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = Engine[@"getattachmentindexbyattachmenttableindex"](f14_arg2, Engine[@"getattachmentindexbyref"](f14_arg1))
	local f14_local1 = Engine[@"currentsessionmode"]()
	return {
		displayName = Engine[@"getattachmentname"](f14_arg2, f14_local0, f14_local1),
		image = Engine[@"getattachmentuniqueimagebyindex"](f14_arg2, f14_local0, f14_local1),
		imageLarge = Engine[@"getattachmentuniqueimagebyindex"](f14_arg2, f14_local0, f14_local1),
		description = Engine[@"getattachmentdesc"](f14_arg2, f14_local0, f14_local1),
	}
end
CoD.BountyHunterUtility.GetGetPackageByID = function(f15_arg0)
	for f15_local3, f15_local4 in ipairs(CoD.BountyHunterUtility.GetBountyHunterPackageTable()) do
		if f15_local4.packageID == f15_arg0 then
			return f15_local4
		end
	end
end
CoD.BountyHunterUtility.GetPackagesOfType = function(f16_arg0)
	local f16_local0 = {}
	for f16_local4, f16_local5 in pairs(CoD.BountyHunterUtility.GetBountyHunterPackageTable()) do
		if f16_local5.packageType == f16_arg0 then
			table.insert(f16_local0, f16_local5)
		end
	end
	return f16_local0
end
CoD.BountyHunterUtility.GetPackagesOfTypeAndGroup = function(f17_arg0, f17_arg1)
	local f17_local0 = {}
	for f17_local5, f17_local6 in pairs(CoD.BountyHunterUtility.GetBountyHunterPackageTable()) do
		local f17_local4
		if f17_arg1 and f17_local6.itemGroup ~= f17_arg1 then
			f17_local4 = false
		else
			f17_local4 = true
		end
		if f17_local6.packageType == f17_arg0 and f17_local4 then
			table.insert(f17_local0, f17_local6)
		end
	end
	return f17_local0
end
CoD.BountyHunterUtility.GetCurrentEquippedPackageID = function(f18_arg0, f18_arg1)
	local f18_local0 = f18_arg1:getModel()
	return f18_local0[f18_arg1._packageType]
end
CoD.BountyHunterUtility.BuildPackageModel = function(f19_arg0, f19_arg1)
	local f19_local0 = Engine[@"currentsessionmode"]()
	if f19_arg0 > 0 then
		local f19_local1 = CoD.BountyHunterUtility.GetGetPackageByID(f19_arg0)
		for f19_local7, f19_local8 in ipairs(f19_local1.items) do
			local f19_local9 = f19_arg1:create("item" .. f19_local7)
			local f19_local5 = f19_local9:create("itemIndex")
			f19_local5:set(f19_local8.itemIndex)
			f19_local5 = f19_local9:create("displayName")
			f19_local5:set(f19_local8.displayName)
			f19_local5 = f19_local9:create("image")
			f19_local5:set(CoD.CACUtility.GetPreviewImage(f19_local0, f19_local8))
			f19_local5 = f19_local9:create("imageLarge")
			f19_local5:set(CoD.CACUtility.GetPreviewImageLarge(f19_local0, f19_local8))
			f19_local5 = f19_local9:create("description")
			f19_local5:set(f19_local8.description)
			if f19_local7 == 1 and f19_local8.attributesTable then
				f19_local5 = f19_local9:create("weaponAttributes")
				local f19_local6 = f19_local5:create("damage")
				f19_local6:set(f19_local8.attributesTable.damage)
				f19_local6 = f19_local5:create("range")
				f19_local6:set(f19_local8.attributesTable.range)
				f19_local6 = f19_local5:create("fireRate")
				f19_local6:set(f19_local8.attributesTable.fireRate)
				f19_local6 = f19_local5:create("accuracy")
				f19_local6:set(f19_local8.attributesTable.accuracy)
			end
		end
		f19_local2 = f19_arg1:create("buyCost")
		f19_local2:set(f19_local1.purchaseCost)
		f19_local2 = f19_arg1:create("packageID")
		f19_local2:set(f19_local1.packageID)
		f19_local2 = f19_arg1:create("refillCost")
		f19_local2:set(f19_local1.refillCost)
		f19_local2 = f19_arg1:create("refillAmmo")
		f19_local2:set(f19_local1.refillAmmo)
	else
		CoD.BountyHunterUtility.InitPackageModel(f19_arg1)
	end
end
CoD.BountyHunterUtility.InitPackageModel = function(f20_arg0)
	local f20_local0 = Engine[@"currentsessionmode"]()
	for f20_local1 = 1, 3, 1 do
		local f20_local4 = f20_arg0:create("item" .. f20_local1)
		f20_local4:create("itemIndex")
		f20_local4:create("displayName")
		local f20_local5 = f20_local4:create("image")
		f20_local5:set(RegisterImage(@"blacktransparent"))
		f20_local5 = f20_local4:create("imageLarge")
		f20_local5:set(RegisterImage(@"blacktransparent"))
		f20_local4:create("description")
		f20_local5 = f20_local4:create("weaponAttributes")
		local f20_local6 = f20_local5:create("damage")
		f20_local6:set(0)
		f20_local6 = f20_local5:create("range")
		f20_local6:set(0)
		f20_local6 = f20_local5:create("fireRate")
		f20_local6:set(0)
		f20_local6 = f20_local5:create("accuracy")
		f20_local6:set(0)
	end
	f20_arg0:create("buyCost")
	local f20_local1 = f20_arg0:create("packageID")
	f20_local1:set(0)
	f20_arg0:create("refillCost")
	f20_arg0:create("refillAmmo")
end
CoD.BountyHunterUtility.OpenBountyHunterOverlay = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
	if not f21_arg1._ignoreBountyButtonPresses then
		return OpenOverlay(f21_arg0, f21_arg3, f21_arg2, {
			_model = f21_arg1:getModel(),
			_packageType = f21_arg4,
		})
	else
	end
end
CoD.BountyHunterUtility.SetupBountyHunterModels = function(f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = Engine[@"getmodelforcontroller"](f22_arg2)
	local f22_local1 = f22_local0.hudItems:create("bountyUndoValid")
	f22_local1:set(false)
	f22_local1 = f22_arg0:getModel()
	if not f22_local1 then
		f22_local1 = f22_local0.luielement.BountyHunterLoadout
	end
	CoD.BountyHunterUtility.InitPackageModel(f22_local1:create("primaryModel"))
	CoD.BountyHunterUtility.InitPackageModel(f22_local1:create("secondaryModel"))
	CoD.BountyHunterUtility.InitPackageModel(f22_local1:create("armorModel"))
	CoD.BountyHunterUtility.InitPackageModel(f22_local1:create("scorestreakModel"))
	CoD.BountyHunterUtility.InitPackageModel(f22_local1:create("equipmentModel"))
	f22_local1:create("mobilityTrack")
	f22_local1:create("assaultTrack")
	f22_local1:create("reconTrack")
	f22_local1:create("supportTrack")
	f22_local1:create("primaryAttachmentTrack")
	f22_local1:create("secondaryAttachmentTrack")
	f22_local1:create("currentPackage")
	f22_arg0:setModel(f22_local1, f22_arg2)
end
CoD.BountyHunterUtility.PerformValidatedBuy = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3)
	if not f23_arg1._ignoreBountyButtonPresses and f23_arg2 then
		local f23_local0 = f23_arg1:getModel()
		f23_local0 = f23_local0.money:get()
		local f23_local1 = nil
		if f23_arg3 ~= "ammo" then
			f23_local1 = f23_arg2.buyCost:get()
		else
			f23_local1 = f23_arg2.refillCost:get()
		end
		if f23_local1 <= f23_local0 then
			Engine[@"sendmenuresponse"](f23_arg0, f23_arg1.menuName, "buy_package_" .. f23_arg3, f23_arg2.packageID:get())
			Engine[@"playsound"]("uin_bh_purchase")
			local f23_local2 = Engine[@"getmodelforcontroller"](f23_arg0)
			f23_local2.hudItems.bountyUndoValid:set(true)
			return true
		end
	end
	return false
end
CoD.BountyHunterUtility.BuyBountyHunterItem = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
	local f24_local0 = f24_arg3:getModel()
	local f24_local1 = f24_arg2:getModel()
	if f24_local1[f24_arg2._packageType]:get() ~= f24_local0.packageID:get() and CoD.BountyHunterUtility.PerformValidatedBuy(f24_arg1, f24_arg2, f24_local0, f24_arg2._packageType) then
		GoBack(f24_arg0, f24_arg1)
		LockInput(f24_arg0, f24_arg1, true)
	end
end
CoD.BountyHunterUtility.BuyBountyTierPackage = function(f25_arg0, f25_arg1, f25_arg2)
	local f25_local0 = f25_arg2:getModel()
	local f25_local1 = f25_local0.trackModel:get()
	if f25_local1.tierPurchased:get() == f25_local0.trackTier:get() - 1 then
		CoD.BountyHunterUtility.PerformValidatedBuy(f25_arg0, f25_arg1, f25_local0, f25_local0.packageType:get())
	end
end
CoD.BountyHunterUtility.BuyBountyPackageAmmo = function(f26_arg0, f26_arg1, f26_arg2)
	local f26_local0 = f26_arg2:getModel()
	if not CoD.BountyHunterUtility.IsAmmoAtMax(f26_arg2, f26_arg0) then
		CoD.BountyHunterUtility.PerformValidatedBuy(f26_arg0, f26_arg1, f26_local0, "ammo")
	end
end
CoD.BountyHunterUtility.SetActiveListItemForWeaponGroup = function(f27_arg0, f27_arg1, f27_arg2)
	if f27_arg0._packageType == "primary" or f27_arg0._packageType == "secondary" then
		local f27_local0 = CoD.BountyHunterUtility.GetCurrentEquippedPackageID(f27_arg1, f27_arg0)
		f27_local0 = f27_local0:get()
		local f27_local1 = Engine[@"currentsessionmode"]()
		if f27_local0 > 0 then
			local f27_local2 = CoD.BountyHunterUtility.GetGetPackageByID(f27_local0)
			local f27_local3 = f27_local2.itemGroup
			if f27_arg2:findItem(nil, {
				category = f27_local3,
			}, true, nil) then
				f27_arg0._itemGroup = f27_local3
			end
		else
			local f27_local3 = CoD.CACUtility.GetWeaponGroupNamesForSlot(f27_arg0._packageType)
			f27_arg0._itemGroup = f27_local3[1].weapon_category
		end
	end
end
CoD.BountyHunterUtility.SetPackageInSlotByPackageId = function(f28_arg0, f28_arg1, f28_arg2)
	local f28_local0 = f28_arg2:get()
	local f28_local1 = f28_arg0:getModel()
	CoD.BountyHunterUtility.BuildPackageModel(f28_local0, f28_local1:create(f28_arg1 .. "Model"))
end
CoD.BountyHunterUtility.IsTooExpensive = function(f29_arg0, f29_arg1)
	local f29_local0 = Engine[@"getmodelforcontroller"](f29_arg1)
	f29_local0 = f29_local0.luielement.BountyHunterLoadout.money:get()
	local f29_local1 = f29_arg0:getModel()
	if f29_local1 then
		f29_local1 = f29_arg0:getModel()
		f29_local1 = f29_local0 < f29_local1.buyCost:get()
	end
	return f29_local1
end
CoD.BountyHunterUtility.IsRefillTooExpensive = function(f30_arg0, f30_arg1)
	local f30_local0 = Engine[@"getmodelforcontroller"](f30_arg1)
	f30_local0 = f30_local0.luielement.BountyHunterLoadout.money:get()
	local f30_local1 = f30_arg0:getModel()
	if f30_local1 then
		f30_local1 = f30_arg0:getModel()
		f30_local1 = f30_local1.refillCost:get()
		if f30_local1 then
			f30_local1 = f30_arg0:getModel()
			f30_local1 = f30_local0 < f30_local1.refillCost:get()
		end
	end
	return f30_local1
end
CoD.BountyHunterUtility.IsAmmoAtMax = function(f31_arg0, f31_arg1)
	local f31_local0 = f31_arg0:getModel()
	if not f31_local0 or not f31_local0.ammoCurrent or not f31_local0.ammoMax then
		return false
	else
		return f31_local0.ammoMax:get() <= f31_local0.ammoCurrent:get()
	end
end
CoD.BountyHunterUtility.IsPackageTierAvailable = function(f32_arg0)
	local f32_local0 = f32_arg0:getModel()
	if f32_local0 then
		local f32_local1 = f32_local0.trackTier:get()
		if f32_local1 == -1 then
			return false
		else
			local f32_local2 = f32_local0.trackModel:get()
			return f32_local2.tierPurchased:get() == f32_local1 - 1
		end
	else
	end
end
CoD.BountyHunterUtility.IsPackageTierSeparatorActive = function(f33_arg0)
	local f33_local0 = f33_arg0:getModel()
	if f33_local0 then
		local f33_local1 = f33_local0.trackTier:get()
		if f33_local1 == -1 then
			return false
		else
			local f33_local2 = f33_local0.trackModel:get()
			return f33_local2.tierPurchased:get() == f33_local1 - 2
		end
	else
	end
end
CoD.BountyHunterUtility.IsTrackPackagePurchased = function(f34_arg0, f34_arg1, f34_arg2)
	local f34_local0 = f34_arg0:getModel()
	if f34_local0 then
		local f34_local1 = f34_local0.trackTier:get()
		if f34_local1 == -1 then
			return false
		else
			local f34_local2 = f34_local0.trackModel:get()
			return f34_local1 <= f34_local2.tierPurchased:get()
		end
	else
		return false
	end
end
CoD.BountyHunterUtility.IsPackageEquippedInLoadoutSlot = function(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = f35_arg0:getModel()
	local f35_local1 = CoD.BountyHunterUtility.GetCurrentEquippedPackageID(f35_arg2, f35_arg1)
	return f35_local0 and f35_local1 and f35_local1:get() == f35_local0.packageID:get()
end
CoD.BountyHunterUtility.SetCurrentPreviewedPackage = function(f36_arg0, f36_arg1)
	local f36_local0 = f36_arg1:getModel()
	local f36_local1 = f36_local0:create("currentPackage")
	f36_local1:set(f36_arg0:getModel())
end
CoD.BountyHunterUtility.SetPreviewedPackageFromCurrentModel = function(f37_arg0, f37_arg1, f37_arg2)
	f37_arg0:setModel(f37_arg1:get(), f37_arg2)
end
CoD.BountyHunterUtility.IsPreviewPackageSingleItem = function(f38_arg0)
	local f38_local0
	if f38_arg0:getModel() then
		f38_local0 = f38_arg0:getModel()
		if f38_local0.item2 then
			f38_local0 = f38_arg0:getModel()
			if f38_local0.item2.displayName then
				f38_local0 = f38_arg0:getModel()
				if f38_local0.item2.displayName:get() then
					f38_local0 = f38_arg0:getModel()
					if f38_local0.item2.trackTier:get() >= 0 then
						f38_local0 = false
					end
				end
			end
		end
	end
	f38_local0 = true
end
CoD.BountyHunterUtility.IsPreviewPackageTripleItem = function(f39_arg0)
	local f39_local0 = f39_arg0:getModel()
	if f39_local0 then
		f39_local0 = f39_arg0:getModel()
		f39_local0 = f39_local0.item3
		if f39_local0 then
			f39_local0 = f39_arg0:getModel()
			f39_local0 = f39_local0.item3.displayName
			if f39_local0 then
				f39_local0 = f39_arg0:getModel()
				f39_local0 = f39_local0.item3.displayName:get()
				if f39_local0 then
					f39_local0 = f39_arg0:getModel()
					f39_local0 = f39_local0.item3.trackTier:get() >= 0
				end
			end
		end
	end
	return f39_local0
end
CoD.BountyHunterUtility.IsPreviewPackageWeaponNotSelected = function(f40_arg0)
	if not f40_arg0:getModel() then
		return false
	end
	local f40_local0 = f40_arg0:getModel()
	f40_local0 = f40_local0.packageID
	if f40_local0 then
		f40_local0 = f40_arg0:getModel()
		if f40_local0.packageID:get() then
			f40_local0 = f40_arg0:getModel()
			if f40_local0.packageID:get() ~= 0 then
				f40_local0 = false
			else
				f40_local0 = true
			end
		end
		f40_local0 = true
	end
	return f40_local0
end
CoD.BountyHunterUtility.GameTypeIsBounty = function(f41_arg0)
	return CoD.HUDUtility.IsGameTypeEqualToString("bounty")
end
CoD.BountyHunterUtility.GameTypeHidesChooseClass = function(f42_arg0)
	local f42_local0 = CoD.HUDUtility.IsGameTypeEqualToString("bounty")
	if not f42_local0 then
		f42_local0 = CoD.HUDUtility.IsGameTypeEqualToString("gun")
		if not f42_local0 then
			f42_local0 = CoD.HUDUtility.IsGameTypeEqualToString("oic")
			if not f42_local0 then
				f42_local0 = CoD.HUDUtility.IsGameTypeEqualToString("sas")
				if not f42_local0 then
					f42_local0 = CoD.HUDUtility.IsGameTypeEqualToString("prop")
				end
			end
		end
	end
	return f42_local0
end
CoD.BountyHunterUtility.TimeRemainingClockFraction = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4, f43_arg5)
	local f43_local0 = 10
	local f43_local1 = Engine[@"getgametypesettings"]()
	return 1, 1 - math.ceil(f43_arg2 / f43_local1.bountyPurchasePhaseDuration:get() * f43_local0) / f43_local0, 0, 0
end
CoD.BountyHunterUtility.GiveBountyHunterMoneyScore = function(f44_arg0, f44_arg1, f44_arg2, f44_arg3)
	if not Engine[@"isvisibilitybitset"](f44_arg2, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not Engine[@"isvisibilitybitset"](f44_arg2, Enum[@"uivisibilitybit"][@"bit_player_dead"]) then
		local f44_local0 = f44_arg3:get()
		if not f44_arg0._previousMoney then
			f44_arg0._previousMoney = f44_local0
		end
		local f44_local1 = f44_local0 - f44_arg0._previousMoney
		f44_arg0._previousMoney = f44_local0
		if f44_local1 > 0 and not f44_arg1._ignoreNextMoneyChange then
			if not f44_arg0._currentElementIndex then
				f44_arg0._currentElementIndex = 1
			end
			if f44_arg0["BountyCashEvent" .. f44_arg0._currentElementIndex] then
				local f44_local2 = "BountyCashEvent"
				if f44_arg0["BountyCashEvent" .. f44_arg0._currentElementIndex].BountyCash then
					f44_local2 = "BountyCashEvent"
					f44_arg0["BountyCashEvent" .. f44_arg0._currentElementIndex].BountyCash:setText(CoD.BaseUtility.AlreadyLocalized("+ $" .. f44_local1))
				end
				f44_arg0["BountyCashEvent" .. f44_arg0._currentElementIndex]:playClip("CashEvent" .. math.random(5))
			end
			f44_arg0._currentElementIndex = (f44_arg0._currentElementIndex + 1) % 5
		end
		f44_arg1._ignoreNextMoneyChange = nil
	end
end
CoD.BountyHunterUtility.ShowBuyMenu = function(f45_arg0, f45_arg1, f45_arg2, f45_arg3)
	f45_arg0._ignoreBountyButtonPresses = false
	f45_arg2._toggledHide = nil
	LockInput(f45_arg0, f45_arg1, true)
	f45_arg2:setAlpha(1)
	f45_arg3:setAlpha(0)
	CoD.Menu.SetAsPriority(f45_arg0, f45_arg1)
	if CoD.isPC then
		f45_arg0.ignoreCursor = false
		CoD.PCUtility.MigrateStickyElementsForward(f45_arg0, f45_arg1)
	end
end
CoD.BountyHunterUtility.HideBuyMenu = function(f46_arg0, f46_arg1, f46_arg2, f46_arg3)
	f46_arg0._ignoreBountyButtonPresses = true
	f46_arg2._toggledHide = true
	LockInput(f46_arg0, f46_arg1, false)
	f46_arg2:setAlpha(0)
	f46_arg3:setAlpha(1)
	CoD.Menu.SetAsNotPriority(f46_arg0, f46_arg1)
	if CoD.isPC then
		f46_arg0.ignoreCursor = true
		CoD.PCUtility.MigrateStickyElementsBackward(f46_arg0, f46_arg1)
	end
end
CoD.BountyHunterUtility.ToggleBuyMenuVisible = function(f47_arg0, f47_arg1, f47_arg2, f47_arg3, f47_arg4)
	if not Engine[@"isvisibilitybitset"](f47_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) then
		if CoD.BountyHunterUtility.IsBuyMenuVisible(f47_arg2) then
			CoD.BountyHunterUtility.HideBuyMenu(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
			if CoD.isPC then
				f47_arg4:setAlpha(0)
			end
		else
			CoD.BountyHunterUtility.ShowBuyMenu(f47_arg0, f47_arg1, f47_arg2, f47_arg3)
			if CoD.isPC then
				f47_arg4:setAlpha(1)
			end
		end
	end
end
CoD.BountyHunterUtility.SetChangeSpecialistDefaultFocus = function(f48_arg0, f48_arg1)
	if CoD.BountyHunterUtility.GameTypeIsBounty(f48_arg1) then
		f48_arg0.__defaultFocus = f48_arg0.QuitButton
	end
end
CoD.BountyHunterUtility.TicketInDownedState = function(f49_arg0, f49_arg1)
	local f49_local0 = f49_arg0:getModel()
	f49_local0 = f49_local0.numPlayersAlive:get()
	local f49_local1 = f49_arg0:getModel()
	if not f49_local1.numPlayersDowned then
		return false
	else
		f49_local1 = f49_arg0:getModel()
		f49_local1 = f49_local1.numPlayersDowned:get()
		return f49_local1 and f49_local0 and f49_local0 - f49_arg1 <= f49_local1
	end
end
CoD.BountyHunterUtility.HasPreviewBeenPurchased = function(f50_arg0, f50_arg1)
	local f50_local0 = f50_arg0:getModel()
	if f50_local0 then
		f50_local0 = f50_arg0:getModel()
		f50_local0 = f50_local0.packageID
		if f50_local0 then
			f50_local0 = f50_arg0:getModel()
			f50_local0 = f50_local0.packageID:get()
		end
	end
	if not f50_local0 or f50_local0 == 0 then
		return false
	end
	local f50_local1 = f50_arg1:getModel()
	if not f50_local1 then
		return false
	end
	local f50_local2 = f50_arg0:getModel()
	if not f50_local2.trackModel and (f50_local0 == f50_local1.primary:get() or f50_local0 == f50_local1.secondary:get() or f50_local0 == f50_local1.armor:get() or f50_local0 == f50_local1.scorestreak:get() or f50_local0 == f50_local1.equipment:get()) then
		return true
	end
	f50_local2 = f50_arg0:getModel()
	if f50_local2.trackTier then
		f50_local2 = f50_arg0:getModel()
		if f50_local2.trackModel then
			f50_local2 = f50_arg0:getModel()
			f50_local2 = f50_local2.trackModel:get()
			if f50_local2.tierPurchased then
				f50_local2 = f50_arg0:getModel()
				f50_local2 = f50_local2.trackTier:get()
				local f50_local3 = f50_arg0:getModel()
				f50_local3 = f50_local3.trackModel:get()
				if f50_local2 <= f50_local3.tierPurchased:get() then
					return true
				end
			end
		end
	end
	return false
end
CoD.BountyHunterUtility.HasBountyStreakOrNotBounty = function(f51_arg0)
	local f51_local0 = CoD.BountyHunterUtility.GameTypeIsBounty(f51_arg0)
	local f51_local1 = Engine[@"getmodelforcontroller"](f51_arg0)
	f51_local1 = f51_local1.killstreaks
	local f51_local2 = f51_local1.killstreak3.rewardAmmo:get()
	if f51_local2 then
		f51_local2 = f51_local1.killstreak3.rewardAmmo:get() > 0
	end
	local f51_local3
	if f51_local0 then
		local f51_local4 = f51_local0
		f51_local3 = f51_local2
	else
		f51_local3 = f51_local4 and true
	end
	return f51_local3
end
CoD.BountyHunterUtility.IsBuyMenuVisible = function(f52_arg0)
	return not f52_arg0._toggledHide
end
