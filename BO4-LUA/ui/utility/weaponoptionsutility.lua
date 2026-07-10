CoD.WeaponOptionsUtility = {}
CoD.WeaponOptionsUtility.maxReticles = 5
CoD.WeaponOptionsUtility.maxReticleColors = 5
CoD.WeaponOptionsUtility.reticleColors = {
	"5 112 246",
	"29 246 6",
	"119 56 0",
	"246 6 243",
	"246 5 5",
}
CoD.WeaponOptionsUtility.lootReticlesStartIndex = 25
CoD.WeaponOptionsUtility.lootReticlesData = {
	reflex = {
		{
			reticleIndex = 5,
			weaponOptionSubIndex = 25,
			multiColor = true,
		},
		{
			reticleIndex = 6,
			weaponOptionSubIndex = 30,
			multiColor = true,
		},
		{
			reticleIndex = 7,
			weaponOptionSubIndex = 35,
			multiColor = false,
		},
		{
			reticleIndex = 8,
			weaponOptionSubIndex = 36,
			multiColor = false,
		},
		{
			reticleIndex = 9,
			weaponOptionSubIndex = 39,
			multiColor = true,
		},
		{
			reticleIndex = 10,
			weaponOptionSubIndex = 44,
			multiColor = true,
		},
		{
			reticleIndex = 11,
			weaponOptionSubIndex = 49,
			multiColor = false,
		},
		{
			reticleIndex = 12,
			weaponOptionSubIndex = 50,
			multiColor = false,
		},
		{
			reticleIndex = 14,
			weaponOptionSubIndex = 51,
			multiColor = true,
		},
		{
			reticleIndex = 15,
			weaponOptionSubIndex = 56,
			multiColor = true,
		},
		{
			reticleIndex = 16,
			weaponOptionSubIndex = 61,
			multiColor = true,
		},
		{
			reticleIndex = 17,
			weaponOptionSubIndex = 66,
			multiColor = false,
			entitlement = 0x7152F1598A5C3DE,
			unlockDesc = Engine[0xF9F1239CFD921FE](0xFF981F8BC120368),
		},
		{
			reticleIndex = 18,
			weaponOptionSubIndex = 67,
			multiColor = false,
		},
	},
	acog = {
		{
			reticleIndex = 5,
			weaponOptionSubIndex = 25,
			multiColor = true,
		},
		{
			reticleIndex = 6,
			weaponOptionSubIndex = 30,
			multiColor = true,
		},
		{
			reticleIndex = 7,
			weaponOptionSubIndex = 35,
			multiColor = false,
		},
		{
			reticleIndex = 8,
			weaponOptionSubIndex = 36,
			multiColor = false,
		},
		{
			reticleIndex = 9,
			weaponOptionSubIndex = 37,
			multiColor = false,
			lootItemOverride = 0xA85406CCE12779,
		},
		{
			reticleIndex = 10,
			weaponOptionSubIndex = 38,
			multiColor = true,
		},
		{
			reticleIndex = 11,
			weaponOptionSubIndex = 43,
			multiColor = true,
		},
		{
			reticleIndex = 12,
			weaponOptionSubIndex = 48,
			multiColor = false,
		},
		{
			reticleIndex = 13,
			weaponOptionSubIndex = 49,
			multiColor = false,
		},
	},
	elo = {
		{
			reticleIndex = 5,
			weaponOptionSubIndex = 25,
			multiColor = false,
		},
		{
			reticleIndex = 6,
			weaponOptionSubIndex = 26,
			multiColor = false,
		},
	},
	holo = {
		{
			reticleIndex = 5,
			weaponOptionSubIndex = 25,
			multiColor = false,
		},
		{
			reticleIndex = 6,
			weaponOptionSubIndex = 26,
			multiColor = false,
		},
	},
}
CoD.WeaponOptionsUtility.AlternateCamoLootIDLookup = {
	[0x1DFE074FEBC1A47] = 0x59A388BF07ABE52,
	[0x2942BCBD7F7246F] = 0x5B27C275D00AFF6,
	[0x28DE2E37D153637] = 0xC8771E638D67490,
	[0x325109E26315E0E] = 0xE14EDE6FF41AFB,
	[0x5A80B864AB2ADC1] = 0x42D89F32491DB77,
	[0xC5ADF2858A5FEC3] = 0x49CB9D6A4494AB8,
	[0xDF1F30EBFF59926] = 0x230D8D739579C05,
	[0x4DB1E39878EB37B] = 0x59A388BF07ABE52,
	[0xBD97AD0F3FACEC2] = 0xC8771E638D67490,
	[0xC4A4AD82AFB4F73] = 0x49CB9D6A4494AB8,
	[0x5101C7F1BB3A40E] = 0x42D89F32491DB77,
	[0x91335CF48FD4407] = 0x5B27C275D00AFF6,
	[0x90DB1296EA96393] = 0xE14EDE6FF41AFB,
	[0x1FAD9ED9BDABAAC] = 0x230D8D739579C05,
}
CoD.WeaponOptionsUtility.GoldCamoRef = 0x6C5B9DFD41304A0
CoD.WeaponOptionsUtility.CreateWeaponOptionsTable = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5)
	return {
		camoIndex = f1_arg0,
		reticleIndex = f1_arg1,
		showPaintshop = f1_arg2,
		weaponModelSlot = f1_arg3,
		robStage = f1_arg4,
		charmIndex = f1_arg5,
	}
end
CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable = function(f2_arg0)
	return (f2_arg0.camoIndex or 0) .. "," .. (f2_arg0.reticleIndex or 0) .. "," .. (f2_arg0.showPaintshop or 0) .. "," .. (f2_arg0.weaponModelSlot or 0) .. "," .. (f2_arg0.robStage or 0) .. "," .. (f2_arg0.charmIndex or 0)
end
CoD.WeaponOptionsUtility.GetWeaponOptionsString = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5)
	return CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable(CoD.WeaponOptionsUtility.CreateWeaponOptionsTable(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5))
end
CoD.WeaponOptionsUtility.GetWeaponOptionsTableForCategory = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	local f4_local0 = {}
	local f4_local1 = CoD.BaseUtility.GetMenuSessionMode(f4_arg0)
	local f4_local2 = Engine[0xB98952F69D937F9](f4_arg3, Enum[0x6EB546760F890D2][0x569E84652131CD7], f4_local1)
	local f4_local3 = CoD.WeaponOptionsUtility.GetWeaponSlotModelForMode(f4_arg0)
	local f4_local4 = CoD.CACUtility.IsProgressionWithWarzoneEnabled(f4_local1)
	if f4_local3 then
		f4_arg0._baseWeaponModelSlot = f4_local3:get()
	end
	if CoD.CACUtility.EmptyItemIndex < f4_arg3 then
		for f4_local5 = 0, Engine[0xF24F0CA4F49DC8F](f4_arg2), 1 do
			local f4_local8 = Engine[0xB70A5B816249FFB](f4_local5, f4_arg2)
			local f4_local9 = false
			local f4_local10 = false
			if not f4_local9 then
				local f4_local11 = Engine[0x1B57E4489900717](f4_arg1, f4_local8, "WeaponOptions", f4_arg3, f4_arg4, f4_local4)
				if f4_local11 and f4_local11.allocation:get() >= 0 then
					local f4_local12 = f4_local11.weaponOptionTypeName:get()
					local f4_local13 = f4_local11.weaponOptionCategory:get()
					local f4_local14 = f4_local11.weaponOptionWeaponRefHash:get()
					local f4_local15 = f4_local11.weaponOptionSubIndex:get()
					local f4_local16 = f4_local11.entitlement:get()
					if f4_local12 then
						if not f4_local0[f4_local12] then
							f4_local0[f4_local12] = {}
						end
						table.insert(f4_local0[f4_local12], f4_local11)
						local f4_local17 = f4_local11:create("isChallengeClassified")
						f4_local17:set(f4_local10)
						if f4_local15 == 0 and f4_local5 == 0 and f4_arg5 and f4_arg5 == true then
							for f4_local17 = Enum[0x35EF5EB24C7CAA2][0x6AF0008A50A53FE], Enum[0x35EF5EB24C7CAA2][0xB36D6E5C4AFBC7F] - 1, 1 do
								local f4_local20 = f4_local12 .. "_" .. CoD.WeaponOptionFilterToString(f4_local17)
								if not f4_local0[f4_local20] then
									f4_local0[f4_local20] = {}
								end
								local f4_local21 = f4_local11:create("isBMClassified")
								f4_local21:set(false)
								table.insert(f4_local0[f4_local20], f4_local11)
							end
						end
						f4_local17 = f4_local11.filterMode:get()
						if f4_local17 then
							local f4_local18, f4_local19 = nil
							if CoD.WeaponOptionFilterStringToEnum(f4_local17) == Enum[0x35EF5EB24C7CAA2][0xA52D61710FD53A1] then
								local f4_local20 = Engine[0xC53F8D38DF9042B](f4_local11.ref:get())
								f4_local18 = CoD.WeaponOptionsUtility.AlternateCamoLootIDLookup[f4_local20] or f4_local20
								f4_local19 = CoD.BlackMarketTableUtility.GetLootInfoForCamo(f4_arg1, f4_local18, f4_local2, f4_local16)
								f4_local11:create("lootData")
								local f4_local21 = f4_local11.lootData:create("owned")
								f4_local21:set(f4_local19.owned)
								f4_local21 = f4_local11.lootData:create("hideRarity")
								f4_local21:set(f4_local19.isEntitlement == true)
								f4_local21 = f4_local11.lootData:create("rarity")
								local f4_local22 = f4_local21
								f4_local21 = f4_local21.set
								local f4_local23 = CoD.BlackMarketUtility.LootIdRarities[f4_local19.rarity]
								if not f4_local23 then
									f4_local23 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
								end
								f4_local21(f4_local22, f4_local23)
								f4_local21 = f4_local11.lootData:create("unlockInfo")
								f4_local21:set(f4_local19.unlockInfo or "")
							end
							local f4_local24 = f4_local12 .. "_" .. f4_local17
							if not f4_local0[f4_local24] then
								f4_local0[f4_local24] = {}
							end
							if not f4_local0[f4_local24][f4_local13] then
								f4_local0[f4_local24][f4_local13] = {}
							end
							if f4_local12 == "reticle" then
								local f4_local20 = Engine[0xF04360CE55D41A](f4_arg4)
								if not f4_local0[f4_local24][f4_local20] then
									f4_local0[f4_local24][f4_local20] = {}
								end
								table.insert(f4_local0[f4_local24][f4_local20], f4_local11)
							end
							local f4_local20 = function(f5_arg0)
								local f5_local0 = f5_arg0.description:get()
								if f5_local0 ~= 0x0 then
									if f4_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
										f5_arg0.description:set(f5_local0 .. "_REVEAL_WZ")
									else
										f5_arg0.description:set(f5_local0 .. "_REVEAL")
									end
								end
							end
							if (not f4_local18 or f4_local18 and not CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem(f4_local18) and not CoD.BlackMarketUtility.IsUnavailableBlackMarketItem(f4_arg1, f4_local19)) and not Engine[0x7366ABFE970F201](f4_arg1, Enum[0xCE3E71B7308D03D][0xC5DF1BACB56F7AB], f4_local8) then
								if f4_local13 == "active" then
									table.insert(f4_local0[f4_local24][f4_local13], f4_local11)
									if f4_local11.lootData.owned:get() and not IsBooleanDvarSet("ui_allowReactiveOnAnyWeapon") then
										local f4_local21 = Engine[0xD97229B24C685D5](f4_local14, f4_local1)
										if f4_local14 ~= f4_local2 and Engine[0xF1FD722970FDBA3](f4_arg1, f4_local21, f4_local8, f4_local1) then
											f4_local11.unlockDescription:set(Engine[0xF9F1239CFD921FE](0x75DC52514B8B26C, CoD.CACUtility.GetUnlockableItemInfoField(f4_local21, f4_local1, "displayName", 0x0)))
										elseif f4_local14 ~= f4_local2 and CoD.WeaponOptionsUtility.IsGoldCamoLockedForWeapon(f4_arg1, f4_arg3, f4_local1) then
											f4_local11.unlockDescription:set(Engine[0xF9F1239CFD921FE](0xC95F145619C28F0))
										end
									end
									local f4_local21 = CoD.WeaponOptionsUtility.GetActiveCamoRefForCamoRef(f4_local1, f4_local11.ref:get())
									if f4_local11.description:get() ~= 0x0 and f4_local21 and f4_local21 ~= 0x0 then
										local f4_local23 = Engine[0xE00B2F29271C60B](f4_local21)
										if f4_local23 then
											local f4_local25 = nil
											if f4_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
												f4_local25 = f4_local23[0x5EA19F62CC07B0]
											elseif f4_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
												f4_local25 = f4_local23[0x39B49F62AD0BBC]
											else
												f4_local25 = f4_local23[0x50E7B988C047D19]
											end
											if f4_local25 then
												f4_local11.description:set(f4_local25)
											end
										end
									end
									if f4_local14 ~= 0x0 then
										f4_local13 = "activeTheme"
										if not f4_local0[f4_local24][f4_local13] then
											f4_local0[f4_local24][f4_local13] = {}
										end
										if not f4_local0[f4_local24][f4_local13][f4_local14] then
											f4_local0[f4_local24][f4_local13][f4_local14] = {}
										end
										local f4_local23 = CoD.CACUtility.AdjustCamoIfSignatureCamo(f4_arg1, f4_local15)
										if f4_local23 ~= f4_local15 then
											f4_local11.weaponOptionSubIndex:set(f4_local23)
										end
										if f4_local14 == f4_local2 then
											local f4_local25 = f4_local11:create("isCurrentWeaponReactiveCamo")
											f4_local25:set(true)
										else
											local f4_local25 = f4_local11:create("isCurrentWeaponReactiveCamo")
											f4_local25:set(false)
										end
										table.insert(f4_local0[f4_local24][f4_local13][f4_local14], f4_local11)
									end
								end
								if f4_local13 == "theme" then
									if not f4_local0[f4_local24][f4_local13][f4_local14] then
										f4_local0[f4_local24][f4_local13][f4_local14] = {}
									end
									if f4_local3 and f4_local11.baseWeaponModelSlot then
										local f4_local21 = f4_local3:get()
										local f4_local22 = f4_local11.baseWeaponModelSlot:get()
										if f4_local21 == f4_local11.signatureWeaponModelSlot:get() and f4_local14 == CoD.GetCustomization(f4_arg1, "weaponRefHash") then
											f4_arg0._baseWeaponModelSlot = f4_local22
										end
										f4_local11.description:set(0xDFBA506E7EAFCB9)
										table.insert(f4_local0[f4_local24][f4_local13][f4_local14], f4_local11)
									end
								end
								if f4_local13 == "mstr" then
									f4_local20(f4_local11)
									for f4_local21 = Enum[0x35EF5EB24C7CAA2][0x6AF0008A50A53FE], Enum[0x35EF5EB24C7CAA2][0xB36D6E5C4AFBC7F] - 1, 1 do
										local f4_local26 = f4_local12 .. "_" .. CoD.WeaponOptionFilterToString(f4_local21)
										if not f4_local0[f4_local26][f4_local13] then
											f4_local0[f4_local26][f4_local13] = {}
										end
										table.insert(f4_local0[f4_local26][f4_local13], f4_local11)
									end
								end
								table.insert(f4_local0[f4_local24][f4_local13], f4_local11)
							end
						end
					end
				end
			end
		end
	end
	local f4_local5 = function(f6_arg0, f6_arg1)
		for f6_local3, f6_local4 in pairs(f6_arg0) do
			if LUI.endswith(f6_local3, f6_arg1) then
				return f6_local4
			end
		end
	end
	local f4_local7 = f4_local5(f4_local0, CoD.WeaponOptionFilterToString(Enum[0x35EF5EB24C7CAA2][0xA52D61710FD53A1]))
	if f4_local7 then
		if f4_local7.lootbase then
			table.sort(f4_local7.lootbase, CoD.BlackMarketUtility.SortWeaponOptionCamosRarity)
		end
		if f4_local7.activeTheme and f4_local7.active then
			table.sort(f4_local7.active, CoD.BlackMarketUtility.SortWeaponOptionCamosRarity)
		end
	end
	return f4_local0
end
CoD.WeaponOptionsUtility.PurchaseWarzoneCamo = function(f7_arg0, f7_arg1, f7_arg2, f7_arg3)
	local f7_local0 = Engine[0x8BF970606552F4C](f7_arg0, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC])
	if f7_local0 then
		local f7_local1 = {
			[0xECD2F25FD60F375] = 42,
			[0x21D7E71414C058F] = 42,
			[0x21CA371808F856E] = 28,
			[0xFE185BE04328801] = 28,
			[0xBB321718EF0E454] = 14,
			[0x418D65A32A8D17] = 28,
			[0x3A681C976E8D9F1] = 21,
			[0xA9ACE0557715BCE] = 7,
		}
		local f7_local2 = 6
		local f7_local3 = 8
		local f7_local4 = f7_arg1.camo[f7_arg3]
		local f7_local5 = tonumber(f7_local4.paintCanCost:get())
		local f7_local6 = f7_local0.PlayerStatsList.ITEMS_PAINT_CANS_COLLECTED.StatValue
		local f7_local7 = f7_local6:get()
		if f7_local5 and f7_local5 > 0 and f7_local5 <= f7_local7 then
			local f7_local8 = f7_local4.statName:get()
			local f7_local9 = f7_local4.challengeStatName:get()
			local f7_local10 = f7_local0.item_stats[f7_arg2][f7_local8]
			local f7_local11 = f7_local4.itemGroup:get()
			local f7_local12 = f7_local10.challengeValue:get() + f7_local5
			f7_local10.challengeValue:set(f7_local12)
			f7_local10.statValue:set(f7_local12)
			f7_local10.challengeTier:set(f7_local10.challengeTier:get() + 1)
			if f7_local9 ~= 0x0 then
				local f7_local13 = f7_local0.item_stats[f7_arg2][f7_local9]
				local f7_local14 = f7_local13.challengeValue:get() + 1
				f7_local13.challengeValue:set(f7_local14)
				f7_local13.statValue:set(f7_local14)
				if f7_local14 == f7_local2 then
					f7_local13.challengeTier:set(1)
				end
				if f7_local11 ~= 0x0 then
					local f7_local15 = f7_local0.item_group_stats[f7_local11][f7_local9]
					local f7_local16 = f7_local15.challengeValue:get() + 1
					if f7_local14 == f7_local2 then
						f7_local16 = f7_local16 + 1
					end
					f7_local15.challengeValue:set(f7_local16)
					f7_local15.statValue:set(f7_local16)
					if f7_local1[f7_local11] == f7_local16 then
						f7_local15.challengeTier:set(1)
						local f7_local17 = f7_local0.PlayerStatsList.weapons_mastery
						local f7_local18 = f7_local17.challengeValue:get() + 1
						f7_local17.challengeValue:set(f7_local18)
						f7_local17.statValue:set(f7_local18)
						if f7_local18 == f7_local3 then
							f7_local17.challengeTier:set(1)
						end
					end
				end
			end
			f7_local7 = f7_local7 - f7_local5
			f7_local6:set(f7_local7)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f7_arg0), "paintCanCount"), f7_local7)
			Engine[0x28A466EF7723621](f7_arg0, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC])
		end
	end
end
CoD.WeaponOptionsUtility.GetPaintjobOptionsTable = function(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
	local f8_local0 = CoD.WeaponOptionsUtility.GetWeaponModelForMode(f8_arg1.menu)
	local f8_local1 = Engine[0xA798E4552F5E872](f8_arg3, "paintjob")
	if not f8_arg2.paintjob then
		f8_arg2.paintjob = {}
	end
	local f8_local2 = function(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4, f9_arg5, f9_arg6)
		local f9_local0 = Engine[0xA798E4552F5E872](f9_arg0, f9_arg2)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "image"), f9_arg1)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "itemIndex"), f9_arg2)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "name"), f9_arg3)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "ref"), f9_arg4)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "weaponOptionTypeName"), f9_arg5)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "weaponOptionType"), Enum[0x3CBA8D054211104][0x43A5BEA0FB2891E])
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "weaponOptionSubIndex"), f9_arg2)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "customizationType"), Enum[0x63E5ADF9D95FC86][0x4E4802F1ABF1844])
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "paintjobSlot"), f9_arg6)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "unlockDescription"), "")
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "unlockReward"), "")
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "unlockProgressAndTarget"), "")
		LUI.CreateModelAndInitialize(Engine[0xA798E4552F5E872](f9_local0, "rarityType"), "rarity", "")
		LUI.CreateModelAndInitialize(f9_local0, "unlockSessionMode", Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE])
		table.insert(f8_arg2[f9_arg5], f9_local0)
	end
	if f8_local0 and (Engine[0x3EAC408F958FF05]() ~= Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] or Dvar[0x419D338C0DC384C]:get()) then
		local f8_local3 = f8_local0.itemIndex and f8_local0.itemIndex:get() or CoD.CACUtility.EmptyItemIndex
		if CoD.CACUtility.GetUnlockableItemInfo(f8_local3, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]) ~= nil then
			CoD.perController[f8_arg0].personalizationWeaponIndex = f8_local3
			local f8_local4 = CoD.CraftUtility.Paintjobs.GetCACPaintjobList(f8_arg0, f8_local3)
			f8_local2(f8_local1, 0x5E38D76F9A1A511, 1, Engine[0xF9F1239CFD921FE](0xDFFD9B8A1D5E6D4), "paintjob_create", "paintjob", Enum[0xCA3F54D92F45B45][0x60CAA8D66ED63A5])
			for f8_local5 = 1, #f8_local4, 1 do
				f8_local2(f8_local1, 0x7615068F50B3D66, f8_local5 + 1, f8_local4[f8_local5].paintjobName, "paintjob_" .. f8_local5, "paintjob", f8_local4[f8_local5].paintjobSlot)
			end
		end
	end
	return f8_arg2
end
CoD.WeaponOptionsUtility.GetWeaponOptionsTable = function(f10_arg0, f10_arg1, f10_arg2)
	local f10_local0 = {}
	local f10_local1 = CoD.BaseUtility.GetMenuSessionMode(f10_arg1.menu)
	local f10_local2 = CoD.BaseUtility.GetMenuLoadoutSlot(f10_arg1.menu)
	local f10_local3 = CoD.WeaponOptionsUtility.GetWeaponModelForMode(f10_arg1.menu)
	local f10_local4 = f10_local3.itemIndex and f10_local3.itemIndex:get() or CoD.CACUtility.EmptyItemIndex
	local f10_local5 = 0
	if CoD.CACUtility.EmptyItemIndex < f10_local4 then
		f10_local0 = CoD.WeaponOptionsUtility.GetWeaponOptionsTableForCategory(f10_arg1.menu, f10_arg0, Enum[0x3CBA8D054211104][0x393666961B28A15], f10_local4, f10_local5, true)
	end
	local f10_local6 = Engine[0x4DF5CFBC1771947](f10_arg0)
	f10_local6 = f10_local6.WeaponOptions
	CoD.WeaponOptionsUtility.GetPaintjobOptionsTable(f10_arg0, f10_arg1, f10_local0, f10_local6)
	if AllowWeaponPrestige(f10_local1) and (f10_local2 == "primary" or f10_local2 == "secondary") then
		local f10_local7 = CoD.CACUtility[f10_local2 .. "WeaponPrestigeSlot"]
		local f10_local8 = Engine[0xA798E4552F5E872](f10_local6, f10_local7)
		f10_local0[f10_local7] = {}
		local f10_local9 = function(f11_arg0, f11_arg1, f11_arg2, f11_arg3)
			local f11_local0 = Engine[0xA798E4552F5E872](f10_local8, f11_arg0)
			LUI.CreateModelAndInitialize(f11_local0, "ref", f11_arg2)
			local f11_local1 = "blacktransparent"
			local f11_local2 = 0x1D17195D5833BC4
			if f11_arg3 ~= CoD.CACUtility.EmptyItemIndex then
				f11_local1 = CoD.CACUtility.mpPrestigeAttachments[f11_arg0].image
				f11_local2 = CoD.CACUtility.mpPrestigeAttachments[f11_arg0].name
			end
			local f11_local3 = false
			local f11_local4 = 0
			for f11_local8, f11_local9 in ipairs(CoD.CACUtility.mpPrestigeAttachments) do
				if f11_arg2 == f11_local9.ref then
					f11_local4 = f11_local8
					f11_local3 = CoD.CACUtility.GetWeaponPLevel(f10_arg0, f11_arg1) < f11_local8
					break
				end
			end
			f11_local5 = ""
			if f11_local3 then
				f11_local5 = Engine[0xF9F1239CFD921FE](0xFAE829460B60190, f11_arg0)
			elseif f11_arg2 == CoD.CACUtility.mpPrestigeAttachments[1].ref then
				f11_local5 = Engine[0xF9F1239CFD921FE](0x66658F1A18557C1, Engine[0x6B7AC889104DED3](f11_arg1))
			elseif f11_arg2 == CoD.CACUtility.mpPrestigeAttachments[2].ref then
				f11_local5 = Engine[0xF9F1239CFD921FE](0xC8CDEE70D07873D, Engine[0x6B7AC889104DED3](f11_arg1))
			end
			f11_local6 = f11_local0:create("name")
			f11_local6:set(f11_local2)
			f11_local6 = f11_local0:create("image")
			f11_local6:set(f11_local1)
			f11_local6 = f11_local0:create("itemIndex")
			f11_local6:set(f11_arg3)
			f11_local6 = f11_local0:create("weaponOptionTypeName")
			f11_local6:set(f10_local7)
			f11_local6 = f11_local0:create("weaponOptionType")
			f11_local6:set(Enum[0x3CBA8D054211104][0xFC7C36E20E72CE4])
			f11_local6 = f11_local0:create("weaponOptionCategory")
			f11_local6:set("mpPrestigeAttachments")
			f11_local6 = f11_local0:create("weaponOptionSubIndex")
			f11_local6:set(f11_arg3)
			f11_local6 = f11_local0:create("unlockDescription")
			f11_local6:set(f11_local5)
			f11_local6 = f11_local0:create("unlockReward")
			f11_local6:set("")
			f11_local6 = f11_local0:create("allocation")
			f11_local6:set(Engine[0x73A2B3FF8B441AD](f11_arg3))
			f11_local6 = f11_local0:create("type")
			f11_local6:set(f10_local7)
			f11_local6 = f11_local0:create("unlockSessionMode")
			f11_local6:set(Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
			f11_local6 = f11_local0:create("rarityType.rarity")
			f11_local6:set("")
			table.insert(f10_local0[f10_local7], f11_local0)
		end
		if CoD.CACUtility.EmptyItemIndex < f10_local4 then
			for f10_local13, f10_local14 in ipairs(CoD.CACUtility.mpPrestigeAttachments) do
				local f10_local15 = Engine[0xB99CB645DEAEB92](f10_local4, Engine[0x58B87258E0EBAD0](f10_local14.ref))
				if f10_local15 and CoD.CACUtility.EmptyItemIndex < f10_local15 then
					f10_local9(f10_local13, f10_local4, f10_local14.ref, f10_local15)
				end
			end
		end
	end
	return f10_local0
end
CoD.WeaponOptionsUtility.SetWeaponAccessoryAttachmentItemInternal = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4)
	local f12_local0, f12_local1, f12_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f12_arg0)
	local f12_local3 = f12_local0.classNum:get()
	if CoD.CACUtility.SetClassItem(f12_arg1, f12_local3, f12_local2 .. "." .. CoD.CACUtility[f12_local2 .. "WeaponPrestigeSlot"], f12_arg2, nil, f12_local1) then
		if f12_arg3 then
			CoD.CACUtility.SetClassItem(f12_arg1, f12_local3, f12_local2 .. "." .. CoD.CACUtility.WeaponCharmAttachment.pathName, f12_arg3, nil, f12_local1)
		end
		CoD.CACUtility.GetCustomClassModel(f12_arg1, f12_local3, f12_local0, nil, f12_local1)
		CoD.CACUtility.WeaponPersonalizationUpdated(f12_arg1)
		CoD.CACUtility.EquippedItemsChanged(f12_arg0, f12_arg1)
		if f12_arg4 then
			GoBack(f12_arg0, f12_arg1)
		end
	end
end
CoD.WeaponOptionsUtility.GetCamoWeaponOptionIndexFromCamoOptionsIndex = function(f13_arg0)
	local f13_local0 = f13_arg0
	local f13_local1 = Engine[0x2DCF0973239E909](CoD.CACUtility.CamoOptionsTable, Enum[0x5DD5CC8AEA7314B][0xAA94CABDA68EB21], Enum[0x5DD5CC8AEA7314B][0xB79D07B3744EA1A], "camo", Enum[0x5DD5CC8AEA7314B][0xA6342D60A0D5AAE], f13_arg0)
	if f13_local1 then
		f13_local0 = Engine[0x2DCF0973239E909](CoD.attachmentTable, Enum[0xAAB93F26A00CE2][0xF088C41316871C0], Enum[0xAAB93F26A00CE2][0x419575E672F6FA2], f13_local1)
		if not f13_local0 then
			local f13_local2 = CoD.WeaponOptionsUtility.GetActiveCamoRefForCamoRef(Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5], f13_local1)
			if f13_local2 and f13_local2 ~= 0x0 then
				local f13_local3 = Engine[0xE00B2F29271C60B](f13_local2)
				if f13_local3 and f13_local3.stages and f13_local3.stages[1] and f13_local3.stages[1][0xEB90A3D94D23B68] then
					f13_local0 = Engine[0x2DCF0973239E909](CoD.attachmentTable, Enum[0xAAB93F26A00CE2][0xF088C41316871C0], Enum[0xAAB93F26A00CE2][0x419575E672F6FA2], f13_local3.stages[1][0xEB90A3D94D23B68])
				end
			end
		end
	end
	return f13_local0 or -1
end
CoD.WeaponOptionsUtility.IsCamoWeaponOptionIndexActiveCamo = function(f14_arg0)
	local f14_local0 = Engine[0x2DCF0973239E909](CoD.attachmentTable, Enum[0xAAB93F26A00CE2][0xBE9816FAD8AD2D2], Enum[0xAAB93F26A00CE2][0xFF49072B7FC5645], "camo", Enum[0xAAB93F26A00CE2][0xF088C41316871C0], f14_arg0)
	return f14_local0 and f14_local0 == "active"
end
CoD.WeaponOptionsUtility.IsReticleItemIndexLoot = function(f15_arg0)
	return CoD.WeaponOptionsUtility.lootReticlesStartIndex <= f15_arg0
end
CoD.WeaponOptionsUtility.GetLootReticleBaseItemIndex = function(f16_arg0, f16_arg1)
	local f16_local0 = CoD.WeaponOptionsUtility.lootReticlesData[f16_arg0]
	if f16_local0 then
		for f16_local4, f16_local5 in ipairs(f16_local0) do
			local f16_local6 = f16_local5.weaponOptionSubIndex
			if f16_local5.multiColor then
				if f16_local6 <= f16_arg1 and f16_arg1 < f16_local6 + CoD.WeaponOptionsUtility.maxReticleColors then
					return f16_local6
				end
			end
			if f16_local6 == f16_arg1 then
				return f16_arg1
			end
		end
	end
	return nil
end
CoD.WeaponOptionsUtility.GetReticleLootDataForRefHash = function(f17_arg0, f17_arg1)
	for f17_local8, f17_local9 in pairs(CoD.WeaponOptionsUtility.lootReticlesData) do
		if Engine[0xC53F8D38DF9042B](f17_local8) == f17_arg1 then
			for f17_local6, f17_local7 in pairs(f17_local9) do
				if Engine[0xC53F8D38DF9042B]("reticle_" .. f17_local8 .. "_" .. f17_local7.reticleIndex) == f17_arg0 then
					return f17_local8, f17_local7
				end
			end
		end
	end
	return nil, nil
end
CoD.WeaponOptionsUtility.IsItemLootReticle = function(f18_arg0, f18_arg1, f18_arg2)
	local f18_local0 = f18_arg1:getModel()
	local f18_local1 = f18_local0.attachmentRef:get()
	local f18_local2 = f18_local0.itemIndex:get()
	local f18_local3 = CoD.WeaponOptionsUtility.lootReticlesData[f18_local1]
	if f18_local3 and LuaUtils.FindItemInArrayTable(f18_local3, "weaponOptionSubIndex", f18_local2) ~= nil then
		return true
	else
		return false
	end
end
CoD.WeaponOptionsUtility.GetReticleLootStreamData = function(f19_arg0, f19_arg1)
	local f19_local0, f19_local1 = CoD.WeaponOptionsUtility.GetReticleLootDataForRefHash(f19_arg0, f19_arg1)
	if f19_local0 and f19_local1 then
		return Engine[0xC53F8D38DF9042B]("MPUI/RETICLE_" .. f19_local0 .. "_" .. f19_local1.reticleIndex), Engine[0xC53F8D38DF9042B](f19_local0 .. "_" .. f19_local1.weaponOptionSubIndex), Engine[0x2DCF0973239E909](CoD.attachmentTable, Enum[0xAAB93F26A00CE2][0xF65E25C47700E9F], Enum[0xAAB93F26A00CE2][0x419575E672F6FA2], f19_arg1)
	else
		return nil, nil, nil
	end
end
CoD.WeaponOptionsUtility.GetWeaponModelForMode = function(f20_arg0)
	local f20_local0, f20_local1, f20_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f20_arg0)
	local f20_local3 = nil
	if f20_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f20_local3 = f20_local0 and f20_local0[f20_local2]
	else
		f20_local3 = f20_arg0._model
	end
	return f20_local3
end
CoD.WeaponOptionsUtility.GetWeaponSlotModelForMode = function(f21_arg0)
	local f21_local0, f21_local1, f21_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f21_arg0)
	local f21_local3 = nil
	if f21_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f21_local3 = f21_local0[f21_local2] and f21_local0 and f21_local0[f21_local2].weaponModelSlot
	else
		f21_local3 = f21_arg0._model.weaponModelSlot
	end
	return f21_local3
end
CoD.WeaponOptionsUtility.IsGoldCamoLockedForWeapon = function(f22_arg0, f22_arg1, f22_arg2)
	return Engine[0xF1FD722970FDBA3](f22_arg0, f22_arg1, Engine[0x2DCF0973239E909](CoD.attachmentTable, Enum[0xAAB93F26A00CE2][0xF088C41316871C0], Enum[0xAAB93F26A00CE2][0x419575E672F6FA2], CoD.WeaponOptionsUtility.GoldCamoRef), f22_arg2)
end
CoD.WeaponOptionsUtility.GetRobStageForCamoIndex = function(f23_arg0)
	local f23_local0 = Engine[0x2DCF0973239E909](CoD.CACUtility.CamoOptionsTable, Enum[0x5DD5CC8AEA7314B][0xB0DA2DF6A22B400], Enum[0x5DD5CC8AEA7314B][0xB79D07B3744EA1A], "camo", Enum[0x5DD5CC8AEA7314B][0xA6342D60A0D5AAE], f23_arg0)
	if not f23_local0 then
		return -1
	end
	local f23_local1 = CoD.CACUtility.DefaultStageForActiveCamo[f23_local0]
	if not f23_local1 then
		f23_local1 = CoD.CACUtility.DefaultStageForActiveCamoNotInList
	end
	return f23_local1
end
CoD.WeaponOptionsUtility.GetActiveCAmoColumnForMode = function(f24_arg0)
	local f24_local0 = Enum[0x5DD5CC8AEA7314B][0xB0DA2DF6A22B400]
	if f24_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f24_local0 = Enum[0x5DD5CC8AEA7314B][0x5338AAC90E615E8]
	elseif f24_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f24_local0 = Enum[0x5DD5CC8AEA7314B][0x53D7FAC90EE57BC]
	end
	return f24_local0
end
CoD.WeaponOptionsUtility.GetActiveCamoRefForCamoRef = function(f25_arg0, f25_arg1)
	return Engine[0x2DCF0973239E909](CoD.CACUtility.CamoOptionsTable, CoD.WeaponOptionsUtility.GetActiveCAmoColumnForMode(f25_arg0), Enum[0x5DD5CC8AEA7314B][0xAA94CABDA68EB21], f25_arg1)
end
CoD.WeaponOptionsUtility.GetActiveCamoRefForBaseCamoIndex = function(f26_arg0, f26_arg1)
	return Engine[0x2DCF0973239E909](CoD.CACUtility.CamoOptionsTable, CoD.WeaponOptionsUtility.GetActiveCAmoColumnForMode(f26_arg0), Enum[0x5DD5CC8AEA7314B][0xB79D07B3744EA1A], "camo", Enum[0x5DD5CC8AEA7314B][0xA6342D60A0D5AAE], f26_arg1)
end
CoD.WeaponOptionsUtility.WeaponOptionsTable = nil
DataSources.WeaponOptions = {
	prepare = function(f27_arg0, f27_arg1, f27_arg2)
		if not CoD.WeaponOptionsUtility.WeaponOptionsTable then
			CoD.WeaponOptionsUtility.WeaponOptionsTable = CoD.WeaponOptionsUtility.GetWeaponOptionsTable(f27_arg0, f27_arg1, f27_arg2)
		end
		f27_arg1.weaponOptions = CoD.WeaponOptionsUtility.WeaponOptionsTable
	end,
	getCount = function(f28_arg0)
		local f28_local0 = DataSources.WeaponOptions.currentFilter
		local f28_local1 = f28_arg0._category
		local f28_local2, f28_local3, f28_local4 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f28_arg0.menu)
		local f28_local5 = CoD.CACUtility[f28_local4 .. "WeaponPrestigeSlot"]
		if not f28_local0 and f28_arg0.weaponOptions and f28_arg0.weaponOptions.filterList then
			return #f28_arg0.weaponOptions.filterList
		elseif f28_arg0.weaponOptions then
			local f28_local6 = f28_arg0.menu:getModel()
			if f28_local1 == "theme" then
				local f28_local7 = f28_local6.weaponRef:get()
				if f28_arg0.weaponOptions[f28_local0] and f28_arg0.weaponOptions[f28_local0][f28_local1] and f28_arg0.weaponOptions[f28_local0][f28_local1][f28_local7] then
					return #f28_arg0.weaponOptions[f28_local0][f28_local1][f28_local7]
				end
			elseif f28_local1 == "active" then
				local f28_local7 = f28_local6.weaponItemGroup:get()
				local f28_local8 = "camo_loot"
				if f28_arg0.weaponOptions[f28_local8] and f28_arg0.weaponOptions[f28_local8][f28_local1] then
					return #f28_arg0.weaponOptions[f28_local8][f28_local1]
				end
			elseif f28_local1 == "activeTheme" then
				local f28_local7 = f28_local6.weaponRef:get()
				local f28_local8 = "camo_loot"
				if f28_arg0.weaponOptions[f28_local8] and f28_arg0.weaponOptions[f28_local8][f28_local1] and f28_arg0.weaponOptions[f28_local8][f28_local1][f28_local7] then
					return #f28_arg0.weaponOptions[f28_local8][f28_local1][f28_local7]
				end
			elseif f28_local1 == "paintjob" then
				if f28_arg0.weaponOptions[f28_local1] then
					return #f28_arg0.weaponOptions[f28_local1]
				end
			elseif f28_local1 == f28_local5 then
				if f28_arg0.weaponOptions[f28_local1] then
					return #f28_arg0.weaponOptions[f28_local1]
				end
			elseif f28_arg0.weaponOptions[f28_local0] and f28_arg0.weaponOptions[f28_local0][f28_local1] then
				return #f28_arg0.weaponOptions[f28_local0][f28_local1]
			end
		end
		return 0
	end,
	getItem = function(f29_arg0, f29_arg1, f29_arg2)
		local f29_local0 = DataSources.WeaponOptions.currentFilter
		local f29_local1 = f29_arg1._category
		local f29_local2, f29_local3, f29_local4 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f29_arg1.menu)
		local f29_local5 = CoD.CACUtility[f29_local4 .. "WeaponPrestigeSlot"]
		if not f29_local0 and f29_arg1.weaponOptions.filterList then
			return f29_arg1.weaponOptions.filterList[f29_arg2]
		end
		local f29_local6 = f29_arg1.menu:getModel()
		if f29_local1 == "theme" then
			local f29_local7 = f29_local6.weaponRef:get()
			if f29_arg1.weaponOptions[f29_local0] and f29_arg1.weaponOptions[f29_local0][f29_local1] and f29_arg1.weaponOptions[f29_local0][f29_local1][f29_local7] then
				return f29_arg1.weaponOptions[f29_local0][f29_local1][f29_local7][f29_arg2]
			end
		elseif f29_local1 == "active" then
			local f29_local7 = f29_local6.weaponItemGroup:get()
			local f29_local8 = "camo_loot"
			if f29_arg1.weaponOptions[f29_local8] and f29_arg1.weaponOptions[f29_local8][f29_local1] then
				return f29_arg1.weaponOptions[f29_local8][f29_local1][f29_arg2]
			end
		elseif f29_local1 == "activeTheme" then
			local f29_local7 = f29_local6.weaponRef:get()
			local f29_local8 = "camo_loot"
			if f29_arg1.weaponOptions[f29_local8] and f29_arg1.weaponOptions[f29_local8][f29_local1] and f29_arg1.weaponOptions[f29_local8][f29_local1][f29_local7] then
				return f29_arg1.weaponOptions[f29_local8][f29_local1][f29_local7][f29_arg2]
			end
		elseif f29_local1 == "paintjob" then
			if f29_arg1.weaponOptions[f29_local1] then
				return f29_arg1.weaponOptions[f29_local1][f29_arg2]
			end
		elseif f29_local1 == f29_local5 then
			if f29_arg1.weaponOptions[f29_local1] then
				return f29_arg1.weaponOptions[f29_local1][f29_arg2]
			end
		elseif f29_arg1.weaponOptions[f29_local0] and f29_arg1.weaponOptions[f29_local0][f29_local1] then
			return f29_arg1.weaponOptions[f29_local0][f29_local1][f29_arg2]
		end
	end,
	setCurrentFilterItem = function(f30_arg0)
		DataSources.WeaponOptions.currentFilter = f30_arg0
	end,
	getCurrentFilterItem = function()
		return DataSources.WeaponOptions.currentFilter
	end,
	currentFilter = nil,
	setCurrentFilterItemNoMode = function(f32_arg0)
		DataSources.WeaponOptions.currentFilterNoMode = f32_arg0
	end,
	getCurrentFilterItemNoMode = function()
		return DataSources.WeaponOptions.currentFilterNoMode
	end,
	currentFilterNoMode = nil,
}
DataSources.ReticleCategoryTabs = ListHelper_SetupDataSource("ReticleCategoryTabs", function(f34_arg0, f34_arg1)
	local f34_local0 = {}
	local f34_local1 = false
	if not IsLive() then
		f34_local1 = true
	end
	table.insert(f34_local0, {
		models = {
			tabName = 0x6435D58073CF5BE,
		},
		properties = {
			filter = "reticle",
		},
	})
	if not f34_local1 then
		local f34_local2 = table.insert
		local f34_local3 = f34_local0
		local f34_local4 = {}
		local f34_local5 = {
			tabName = 0x29C903C6DF90D6F,
		}
		local f34_local6 = DataSources.LoadoutBreadcrumbs.getModel(f34_arg0)
		f34_local5.breadcrumb = f34_local6.optics
		f34_local4.models = f34_local5
		f34_local4.properties = {
			filter = "reticle_loot",
		}
		f34_local2(f34_local3, f34_local4)
	end
	return f34_local0
end, true)
DataSources.WeaponReticles = ListHelper_SetupDataSource("WeaponReticles", function(f35_arg0, f35_arg1)
	f35_arg1.reticles = {}
	local f35_local0 = {}
	local f35_local1, f35_local2, f35_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f35_arg1.menu)
	local f35_local4 = CoD.BaseUtility.GetMenuLoadoutListItemSlot(f35_arg1.menu)
	local f35_local5 = CoD.WeaponOptionsUtility.GetWeaponModelForMode(f35_arg1.menu)
	local f35_local6 = CoD.CACUtility.weaponOptionGroupNames[Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B]]
	local f35_local7 = CoD.CACUtility.EmptyItemIndex
	local f35_local8 = 0
	local f35_local9 = nil
	if f35_local2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		if f35_local5.itemIndex then
			local f35_local10 = f35_local5.itemIndex:get()
		end
		f35_local7 = f35_local10 or CoD.CACUtility.EmptyItemIndex
		f35_local8 = CoD.SafeGetModelValue(f35_local1[f35_local4], "attachmentIndex") or 0
		f35_local9 = CoD.SafeGetModelValue(f35_local1[f35_local4], "ref")
	else
		f35_local7 = CoD.SafeGetModelValue(f35_local1, "weaponIndex")
		f35_local8 = CoD.SafeGetModelValue(f35_local1, "attachmentIndex")
		f35_local9 = CoD.SafeGetModelValue(f35_local1, "attachmentRef")
	end
	if f35_local7 and f35_local8 then
		f35_local0 = CoD.WeaponOptionsUtility.GetWeaponOptionsTableForCategory(f35_arg1.menu, f35_arg0, Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B], f35_local7, f35_local8, true)
	end
	if not f35_arg1.menu._reticle then
		if f35_local2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and f35_local1[f35_local3] and f35_local1[f35_local3].reticleIndex then
			f35_arg1.menu._reticle = f35_local1[f35_local3].reticleIndex:get()
		elseif f35_local2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			f35_arg1.menu._reticle = CoD.ZMLoadoutUtility.GetReticleIndexForWeaponIndex(f35_arg0, f35_local7)
		else
			f35_arg1.menu._reticle = 0
		end
	end
	local f35_local11 = false
	if DataSources.WeaponReticles._filter == "reticle_loot" then
		f35_local11 = true
	end
	if f35_local11 and f35_local9 then
		local f35_local12 = CoD.WeaponOptionsUtility.lootReticlesData[f35_local9]
		if f35_local12 then
			local f35_local13 = f35_arg1.menu._reticle - f35_arg1.menu._reticle % CoD.WeaponOptionsUtility.maxReticleColors
			local f35_local14 = CoD.CACUtility.weaponOptionGroupNames[Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B]]
			for f35_local28, f35_local29 in ipairs(f35_local12) do
				local f35_local30 = CoD.WeaponOptionsUtility.maxReticleColors
				local f35_local31 = f35_local29.reticleIndex
				local f35_local32 = f35_local29.weaponOptionSubIndex
				local f35_local18
				if f35_local32 == f35_local13 then
					f35_local18 = f35_arg1.menu._reticle
					if not f35_local18 then
					else
						local f35_local19 = f35_arg1.menu._reticle == f35_local32
						if f35_local29.multiColor then
							if f35_local32 > f35_arg1.menu._reticle or f35_arg1.menu._reticle >= f35_local32 + CoD.WeaponOptionsUtility.maxReticleColors then
								f35_local19 = false
							else
								f35_local19 = true
							end
						end
						local f35_local20 = f35_local29.lootItemOverride
						if not f35_local20 then
							f35_local20 = Engine[0xC53F8D38DF9042B]("reticle_" .. f35_local9 .. "_" .. f35_local31)
						end
						local f35_local21 = CoD.BlackMarketTableUtility.LootInfoLookup(f35_arg0, f35_local20)
						local f35_local22 = f35_local29.entitlement
						if f35_local21.available or f35_local22 and Engine[0xB521CB398C92692](f35_arg0, f35_local22) then
							local f35_local23 = table.insert
							local f35_local24 = f35_arg1.reticles
							local f35_local25 = {}
							local f35_local26 = {
								itemIndex = f35_local32,
								ref = f35_local9 .. "_" .. f35_local31,
								name = Engine[0xF9F1239CFD921FE]("MPUI/RETICLE_" .. f35_local9 .. "_" .. f35_local31),
								image = f35_local9 .. "_" .. f35_local18,
							}
							local f35_local27 = f35_local21.unlockInfo
							if not f35_local27 then
								f35_local27 = f35_local29.unlockDesc
								if not f35_local27 then
									f35_local27 = ""
								end
							end
							f35_local26.unlockDescription = f35_local27
							f35_local26.unlockProgressAndTarget = ""
							f35_local26.unlockReward = ""
							f35_local26.weaponOptionSubIndex = f35_local32
							f35_local26.weaponOptionType = Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B]
							f35_local26.weaponOptionTypeName = f35_local14
							f35_local26.weaponOptionName = f35_local14
							f35_local26.attachmentRef = f35_local9
							f35_local26.imageIndex = f35_local18
							f35_local26.multiColor = f35_local29.multiColor
							f35_local26.entitlement = f35_local22 ~= nil
							f35_local26.weaponItemIndex = f35_local7
							f35_local25.models = f35_local26
							f35_local26 = {
								selectIndex = f35_local19,
							}
							if f35_local21.owned ~= true then
								f35_local27 = not f35_local22
							else
								f35_local27 = false
							end
							f35_local26.isLootLocked = f35_local27
							f35_local25.properties = f35_local26
							f35_local23(f35_local24, f35_local25)
						end
					end
				end
				f35_local18 = f35_local32
			end
		end
		f35_arg1.attachmentRef = f35_local9
	else
		local f35_local12 = f35_arg1.menu._reticle - f35_arg1.menu._reticle % CoD.WeaponOptionsUtility.maxReticleColors
		if f35_local9 then
			local f35_local13 = f35_local0[f35_local6]
			for f35_local14 = 1, CoD.WeaponOptionsUtility.maxReticles, 1 do
				local f35_local28 = (f35_local14 - 1) * CoD.WeaponOptionsUtility.maxReticles
				local f35_local30 = f35_local13[f35_local28 + 1]
				local f35_local31
				if f35_local28 == f35_local12 then
					f35_local31 = f35_arg1.menu._reticle
					if not f35_local31 then
					else
						local f35_local32 = table.insert
						local f35_local18 = f35_arg1.reticles
						local f35_local19 = {}
						local f35_local20 = {
							itemIndex = f35_local28,
							ref = f35_local9 .. "_" .. f35_local14 - 1,
							name = Engine[0xF9F1239CFD921FE]("MPUI/RETICLE_" .. f35_local9 .. "_" .. f35_local14 - 1),
							image = f35_local9 .. "_" .. f35_local31,
						}
						local f35_local21
						if f35_local30 then
							f35_local21 = f35_local30.unlockDescription:get()
							if not f35_local21 then
							else
								f35_local20.unlockDescription = f35_local21
								if f35_local30 then
									f35_local21 = f35_local30.unlockProgressAndTarget:get()
									if not f35_local21 then
									else
										f35_local20.unlockProgressAndTarget = f35_local21
										if f35_local30 then
											f35_local21 = f35_local30.unlockReward:get()
											if not f35_local21 then
											else
												f35_local20.unlockReward = f35_local21
												f35_local20.weaponOptionSubIndex = f35_local28
												f35_local20.weaponOptionType = Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B]
												f35_local20.weaponOptionTypeName = f35_local6
												f35_local20.attachmentRef = f35_local9
												f35_local20.imageIndex = f35_local31
												f35_local20.multiColor = true
												f35_local20.entitlement = false
												f35_local19.models = f35_local20
												f35_local19.properties = {
													selectIndex = f35_local28 == f35_local12,
													isLootLocked = false,
												}
												f35_local32(f35_local18, f35_local19)
											end
										end
										f35_local21 = ""
									end
								end
								f35_local21 = ""
							end
						end
						f35_local21 = ""
					end
				end
				f35_local31 = f35_local28
			end
			f35_arg1.attachmentRef = f35_local9
		end
	end
	return f35_arg1.reticles
end, true)
DataSources.WeaponReticleColor = ListHelper_SetupDataSource("WeaponReticleColor", function(f36_arg0, f36_arg1)
	f36_arg1.colors = {}
	local f36_local0, f36_local1, f36_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f36_arg1.menu)
	local f36_local3 = nil
	if f36_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		local f36_local4 = f36_local0.classNum:get()
		local f36_local5 = CoD.CACUtility.GetBaseWeaponLoadoutSlotName(f36_local2)
		if not f36_arg1.menu._reticle then
			local f36_local6, f36_local7, f36_local8 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f36_arg1.menu)
			if f36_local6[f36_local8] and f36_local6[f36_local8].reticleIndex then
				f36_arg1.menu._reticle = f36_local6[f36_local8].reticleIndex:get()
			else
				f36_arg1.menu._reticle = 0
			end
		end
		f36_local3 = CoD.SafeGetModelValue(f36_local0[CoD.BaseUtility.GetMenuLoadoutListItemSlot(f36_arg1.menu)], "ref")
	elseif f36_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		if not f36_arg1.menu._reticle then
			f36_arg1.menu._reticle = CoD.ZMLoadoutUtility.GetReticleIndexForWeaponIndex(f36_arg0, f36_local0.weaponIndex:get())
		end
		f36_local3 = CoD.SafeGetModelValue(f36_local0, "attachmentRef")
	else
		f36_arg1.menu._reticle = 0
	end
	local f36_local4 = f36_arg1.menu._reticle
	if f36_local4 and f36_local3 then
		if not f36_arg1.menu._selectedReticle then
			f36_arg1.menu._selectedReticle = f36_local4
		end
		local f36_local5 = f36_local4 - f36_local4 % CoD.WeaponOptionsUtility.maxReticleColors
		local f36_local6 = f36_local4 >= CoD.WeaponOptionsUtility.lootReticlesStartIndex
		if f36_local6 ~= DataSources.WeaponReticles._filter == "reticle_loot" then
			return f36_arg1.colors
		elseif f36_local6 then
			local f36_local8 = false
			local f36_local9 = CoD.WeaponOptionsUtility.lootReticlesData[f36_local3]
			if f36_local9 then
				for f36_local14, f36_local15 in ipairs(f36_local9) do
					if f36_local15.multiColor then
						local f36_local13 = f36_local15.weaponOptionSubIndex
						if f36_local13 <= f36_local4 and f36_local4 < f36_local13 + CoD.WeaponOptionsUtility.maxReticleColors then
							f36_local5 = f36_local13
							f36_local8 = true
						end
					end
				end
			end
			if not f36_local8 then
				return f36_arg1.colors
			end
		end
		local f36_local8 = CoD.CACUtility.weaponOptionGroupNames[Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B]]
		for f36_local9 = 0, CoD.WeaponOptionsUtility.maxReticleColors - 1, 1 do
			local f36_local14 = f36_local5 + f36_local9
			table.insert(f36_arg1.colors, {
				models = {
					itemIndex = f36_local14,
					imageIndex = f36_local14,
					ref = f36_local3 .. "_" .. f36_local14,
					image = f36_local3 .. "_" .. f36_local14,
					attachmentRef = f36_local3,
					weaponOptionSubIndex = f36_local14,
					weaponOptionType = Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B],
					weaponOptionTypeName = f36_local8,
				},
				properties = {
					selectIndex = f36_local14 == f36_arg1.menu._selectedReticle,
				},
			})
		end
	end
	return f36_arg1.colors
end, true)
CoD.WeaponOptionsUtility.WeaponsThatHaveWZCamosButArentAvailableInWZ = {
	[0xAB1184700CE0AA6] = true,
}
DataSources.WeaponOptionsGroups = ListHelper_SetupDataSource("WeaponOptionsGroups", function(f37_arg0, f37_arg1)
	local f37_local0 = {}
	local f37_local1, f37_local2, f37_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f37_arg1.menu)
	local f37_local4 = CoD.WeaponOptionsUtility.GetWeaponModelForMode(f37_arg1.menu)
	local f37_local5 = f37_local4.itemIndex and f37_local4.itemIndex:get() or CoD.CACUtility.EmptyItemIndex
	local f37_local6 = false
	if (f37_local2 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] or f37_local2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]) and f37_local4 and f37_local4.refHash then
		local f37_local7 = f37_local4.refHash:get()
		if f37_local7 ~= 0x4C9BAB69F2A2D2A and f37_local7 == 0x328BAA07BF1D03B then
		else
		end
	end
	if not IsLive() then
		f37_local6 = true
	end
	if f37_local2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and not CoD.BaseUtility.IsDvarEnabled("ui_zmEnableMasteryCamos") then
		f37_local6 = true
	end
	local f37_local7 = CoD.CACUtility.GetUnlockableItemInfo(f37_local5, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]) ~= nil
	local f37_local8 = CoD.CACUtility.GetUnlockableItemInfo(f37_local5, Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39]) ~= nil
	local f37_local9 = CoD.CACUtility.GetUnlockableItemInfo(f37_local5, Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]) ~= nil
	if f37_local4 and f37_local4.refHash and CoD.WeaponOptionsUtility.WeaponsThatHaveWZCamosButArentAvailableInWZ[f37_local4.refHash:get()] then
		f37_local8 = false
	end
	if not f37_local6 then
		local f37_local10 = table.insert
		local f37_local11 = f37_local0
		local f37_local12 = {}
		local f37_local13 = {
			name = 0x29C903C6DF90D6F,
		}
		local f37_local14 = DataSources.LoadoutBreadcrumbs.getModel(f37_arg0)
		f37_local13.breadcrumb = f37_local14.camos
		f37_local13.originVisible = false
		f37_local13.origin = 0x0
		f37_local12.models = f37_local13
		f37_local12.properties = {
			filter = "camo_loot",
			mode = Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE],
		}
		f37_local10(f37_local11, f37_local12)
	end
	local f37_local10 = false
	local f37_local11 = false
	if f37_local2 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		if f37_local8 and IsBooleanDvarSet("ui_ShowWZPersonalization") then
			table.insert(f37_local0, {
				models = {
					name = 0xA2DD20750465431,
					available = f37_local8,
					originVisible = f37_local2 ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39],
					origin = 0x3362A88A174F8CA,
				},
				properties = {
					filter = "camo_wz",
					mode = Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39],
					selectIndex = f37_local2 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39],
				},
			})
		end
		f37_local10 = true
	elseif f37_local2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		if (not (not CoD.isPC or CoD.PCKoreaUtility.ShowKorea15Plus()) or not CoD.isPC) and f37_local9 then
			table.insert(f37_local0, {
				models = {
					name = 0xB06081B8B4567F2,
					available = f37_local9,
					originVisible = f37_local2 ~= Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
					origin = 0x3111988A155BFAA,
				},
				properties = {
					filter = "camo_zm",
					mode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
					selectIndex = f37_local2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
				},
			})
		end
		f37_local11 = true
	end
	if f37_local7 then
		table.insert(f37_local0, {
			models = {
				name = 0x55D96CC762EABDD,
				available = f37_local7,
				originVisible = f37_local2 ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
				origin = 0x2EC1C88A136A886,
			},
			properties = {
				filter = "camo_mp",
				mode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
				selectIndex = f37_local2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
			},
		})
	end
	if not f37_local10 and f37_local8 and IsBooleanDvarSet("ui_ShowWZPersonalization") then
		table.insert(f37_local0, {
			models = {
				name = 0xA2DD20750465431,
				available = f37_local8,
				originVisible = f37_local2 ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39],
				origin = 0x3362A88A174F8CA,
			},
			properties = {
				filter = "camo_wz",
				mode = Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39],
				selectIndex = f37_local2 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39],
			},
		})
	end
	if not f37_local11 and (not (not CoD.isPC or CoD.PCKoreaUtility.ShowKorea15Plus()) or not CoD.isPC) and f37_local9 then
		table.insert(f37_local0, {
			models = {
				name = 0xB06081B8B4567F2,
				available = f37_local9,
				originVisible = f37_local2 ~= Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
				origin = 0x3111988A155BFAA,
			},
			properties = {
				filter = "camo_zm",
				mode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
				selectIndex = f37_local2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
			},
		})
	end
	return f37_local0
end, true)
DataSourceHelpers.PerControllerDataSourceSetup("WeaponPersonalization", "WeaponPersonalization", function(f38_arg0, f38_arg1)
	local f38_local0 = f38_arg0:create("weaponItemIndex")
	f38_local0:set(0)
	f38_local0 = f38_arg0:create("weaponRef")
	f38_local0:set(0x0)
	f38_local0 = f38_arg0:create("weaponName")
	f38_local0:set("")
	f38_local0 = f38_arg0:create("weaponItemGroup")
	f38_local0:set("")
	f38_arg0:create("listUpdate")
	f38_arg0:create("reticleListUpdate")
	f38_local0 = f38_arg0:create("equippedAccessoryIndex")
	f38_local0:set(0)
	f38_local0 = f38_arg0:create("equippedDeathFxIndex")
	f38_local0:set(0)
end, true)
CoD.WeaponOptionsUtility.WeaponCannotGetHeadshots = function(f39_arg0, f39_arg1)
	if not f39_arg0 or f39_arg1 <= CoD.CACUtility.EmptyItemIndex then
		return false
	end
	local f39_local0 = CoD.CACUtility.GetUnlockableItemInfo(f39_arg1, f39_arg0)
	local f39_local1
	if f39_local0.itemGroup ~= "weapon_launcher" and f39_local0.itemGroup ~= "weapon_knife" then
		f39_local1 = false
	else
		f39_local1 = true
	end
	return f39_local1
end
CoD.WeaponOptionsUtility.CurrentCustomizationWeaponCannotGetHeadshots = function(f40_arg0, f40_arg1)
	return CoD.WeaponOptionsUtility.WeaponCannotGetHeadshots(f40_arg0 and CoD.BaseUtility.GetMenuSessionMode(f40_arg0), CoD.GetCustomization(f40_arg1, "weapon_index"))
end
DataSources.WeaponOptionsCamoCategories = DataSourceHelpers.ListSetup("WeaponOptionsCamoCategories", function(f41_arg0, f41_arg1)
	local f41_local0 = {}
	local f41_local1 = {
		refHash = 0xEEEBCB6715E676F,
		name = 0x365CE85575CA13B,
	}
	local f41_local2 = DataSources.LoadoutBreadcrumbs.getModel(f41_arg0)
	f41_local1.breadcrumb = f41_local2.basiccamo
	f41_local1.frameWidget = "CoD.CamoListSelectionWidget"
	f41_local1.selectIndex = true
	f41_local2 = {
		refHash = 0x4675E6BE6454E41,
		name = 0x2EEF729B41D6347,
	}
	local f41_local3 = DataSources.LoadoutBreadcrumbs.getModel(f41_arg0)
	f41_local2.breadcrumb = f41_local3.activecamo
	f41_local2.frameWidget = "CoD.ActiveCamoListSelectionWidget"
	f41_local0[1] = f41_local1
	f41_local0[2] = f41_local2
	f41_local3 = CoD.WeaponOptionsUtility.WeaponCannotGetHeadshots(CoD.BaseUtility.GetMenuSessionMode(f41_arg1.menu), CoD.GetCustomization(f41_arg0, "weapon_index"))
	local f41_local4 = {}
	for f41_local8, f41_local9 in ipairs(f41_local0) do
		if f41_local9.refHash ~= 0x4675E6BE6454E41 or not f41_local3 then
			table.insert(f41_local4, {
				models = {
					name = f41_local9.name,
					frameWidget = f41_local9.frameWidget,
					breadcrumb = f41_local9.breadcrumb,
				},
				properties = {
					refHash = f41_local9.refHash,
					selectIndex = f41_local9.selectIndex,
				},
			})
		end
	end
	return f41_local4
end, true)
DataSources.ActiveCamoStagesList = DataSourceHelpers.ListSetup("ActiveCamoStagesList", function(f42_arg0, f42_arg1)
	local f42_local0 = {}
	local f42_local1 = CoD.BaseUtility.GetMenuSessionMode(f42_arg1.menu)
	local f42_local2 = CoD.BaseUtility.GetMenuModel(f42_arg1.menu)
	local f42_local3 = f42_local2.ref:get() or ""
	local f42_local4 = CoD.WeaponOptionsUtility.GetActiveCamoRefForCamoRef(f42_local1, type(f42_local3) and Engine[0xC53F8D38DF9042B](f42_local3) or f42_local3)
	if f42_local4 and f42_local4 ~= 0x0 then
		local f42_local5 = Engine[0xE00B2F29271C60B](f42_local4)
		if f42_local5 and f42_local5.stages then
			local f42_local6 = 0
			local f42_local7 = CoD.CACUtility.BaseUnwrappedStageForActiveCamo
			if f42_arg1.menu._weaponOptionCategory == "theme" then
				f42_local7 = CoD.CACUtility.MastercraftCamoStartStage
			elseif f42_arg1.menu._weaponOptionCategory == "mstr" then
				f42_local7 = CoD.CACUtility.MasteryCamoStartStage
			end
			for f42_local8 = f42_local7, #f42_local5.stages, 1 do
				local f42_local11
				if f42_local8 - 1 >= 0 then
					f42_local11 = f42_local5.stages[f42_local8 - 1]
				else
					f42_local11 = false
				end
				local f42_local12 = f42_local5.stages[f42_local8]
				if not f42_local12[0xFA3391DB68E4425] or f42_local12[0xFA3391DB68E4425] ~= 1 then
					local f42_local13 = Engine[0x2DCF0973239E909](CoD.CACUtility.CamoOptionsTable, Enum[0x5DD5CC8AEA7314B][0xA6342D60A0D5AAE], Enum[0x5DD5CC8AEA7314B][0xAA94CABDA68EB21], f42_local12[0xEB90A3D94D23B68])
					local f42_local14 = Engine[0xF9F1239CFD921FE](0x55472550AF1CAB2)
					if f42_local11 and f42_local7 < f42_local8 then
						if f42_local11[0x581C6C8958C02BB] then
							local f42_local15 = Engine[0xF9F1239CFD921FE](f42_local11[0x581C6C8958C02BB], f42_local6)
						end
						f42_local14 = f42_local15 or ""
					end
					table.insert(f42_local0, {
						models = {
							displayText = f42_local14,
							stageCamoIndex = f42_local13,
							robStage = f42_local8 - 1,
						},
					})
					f42_local6 = f42_local6 + f42_local12[0x181D2404B77545F]
				end
			end
		end
	end
	return f42_local0
end, true)
DataSources.PurchaseCamoList = ListHelper_SetupDataSource("PurchaseCamoList", function(f43_arg0, f43_arg1)
	local f43_local0 = 0
	local f43_local1 = CoD.GetCustomization(f43_arg0, "weaponRefHash")
	local f43_local2 = CoD.CACUtility.EmptyItemIndex
	local f43_local3 = f43_arg1.menu
	if f43_local3 then
		f43_local3 = f43_arg1.menu:getModel()
	end
	if f43_local3 then
		if f43_local3.paintCanCost then
			local f43_local4 = f43_local3.paintCanCost:get()
		end
		f43_local0 = f43_local4 or ""
		if f43_local3.weaponOptionSubIndex then
			local f43_local5 = f43_local3.weaponOptionSubIndex:get()
		end
		f43_local2 = f43_local5 or CoD.CACUtility.EmptyItemIndex
	end
	local f43_local6 = function(f44_arg0, f44_arg1, f44_arg2, f44_arg3, f44_arg4)
		GoBack(f44_arg0, f44_arg2)
	end
	local f43_local7 = function(f45_arg0, f45_arg1, f45_arg2, f45_arg3, f45_arg4)
		local f45_local0 = CoD.WeaponOptionsUtility.PurchaseWarzoneCamo
		local f45_local1 = f45_arg2
		local f45_local2 = Engine[0x4DF5CFBC1771947](f45_arg2)
		f45_local0(f45_local1, f45_local2.WeaponOptions, f43_local1, f43_local2)
		GoBack(f45_arg0, f45_arg2)
		CoD.WeaponOptionsUtility.ResetWeaponOptions(f45_arg4, f45_arg2)
		ForceNotifyControllerModel(f45_arg2, "WeaponPersonalization.listUpdate")
	end
	local f43_local8 = {}
	table.insert(f43_local8, {
		models = {
			displayText = Engine[0xED84C33EC5F01EA](0xD735DA166428851, f43_local0),
		},
		properties = {
			action = f43_local7,
		},
	})
	if not CoD.isPC then
		table.insert(f43_local8, {
			models = {
				displayText = Engine[0xED84C33EC5F01EA](0xC2E92C54C2BE289),
			},
			properties = {
				action = f43_local6,
			},
		})
	end
	return f43_local8
end)
DataSources.WeaponCharmList = ListHelper_SetupDataSource(
	"WeaponCharmList",
	function(f46_arg0, f46_arg1)
		local f46_local0 = {}
		local f46_local1 = nil
		local f46_local2 = CoD.BaseUtility.GetMenuSessionMode(f46_arg1.menu)
		local f46_local3 = CoD.GetCustomization(f46_arg0, "weaponRefHash")
		if not f46_local3 then
			return f46_local0
		end
		local f46_local4 = {
			weaponRef = f46_local3,
		}
		local f46_local5 = Engine[0xA7E3CD65E63086F](0xF2DC7A2FE7EEDC5)
		if f46_local5 then
			for f46_local16, f46_local17 in ipairs(f46_local5) do
				if f46_local16 ~= 1 then
					local f46_local9 = CoD.BlackMarketTableUtility.LootInfoLookup(f46_arg0, f46_local17[0x28887F70BF5EBA], f46_local17[0x562938AF86028A0], f46_local4)
					local f46_local10 = f46_local9.isLoot or f46_local9.isEntitlement
					if f46_local9.owned and f46_local10 then
						local f46_local11 = table.insert
						local f46_local12 = f46_local0
						local f46_local13 = {}
						local f46_local14 = {
							displayName = f46_local17[0x55F116BF695C8F6] and Engine[0xF9F1239CFD921FE](f46_local17[0x55F116BF695C8F6]) or "",
							category = 0xF5E657D5E5ED4E7,
							icon = f46_local17[0xBFF4CC56C2092F0] or 0x7615068F50B3D66,
							itemIndex = f46_local16 - 1,
							frontendModel = f46_local17[0x8A334535BE3AFB1] and Engine[0xC53F8D38DF9042B](f46_local17[0x8A334535BE3AFB1]) or 0x0,
							description = f46_local17[0xCC44970C8397929] and Engine[0xF9F1239CFD921FE](f46_local17[0xCC44970C8397929]) or "",
							isEquippedFn = CoD.WeaponOptionsUtility.IsWeaponCharmEquipped,
							isNewFn = CoD.BreadcrumbUtility.IsWeaponAccessoryNew,
							unlockInfo = f46_local9.unlockInfo or "",
						}
						local f46_local15 = CoD.BlackMarketUtility.LootIdRarities[f46_local9.rarity]
						if not f46_local15 then
							f46_local15 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
						end
						f46_local14.rarity = f46_local15
						f46_local15 = f46_local9.owned
						if not f46_local15 then
							f46_local15 = f46_local9.available or not f46_local10
						end
						f46_local14.available = f46_local15
						f46_local14.owned = f46_local9.owned or not f46_local10
						f46_local15 = f46_local9.isLoot
						if f46_local15 then
							f46_local15 = f46_local9.owned
							if f46_local15 then
								f46_local15 = Engine[0xCB675CA7856DA25]()
							end
						end
						f46_local14.trialLocked = f46_local15
						f46_local15 = f46_local9.isLoot
						if f46_local15 then
							f46_local15 = not f46_local9.owned
						end
						f46_local14.lootLocked = f46_local15
						f46_local15 = f46_local9.hideRarity
						if not f46_local15 then
							f46_local15 = f46_local9.isEntitlement or false
						end
						f46_local14.hideRarity = f46_local15
						f46_local14.lootId = f46_local17[0x28887F70BF5EBA]
						f46_local13.models = f46_local14
						f46_local11(f46_local12, f46_local13)
					end
				end
			end
		end
		local f46_local6 = CoD.GetCustomization(f46_arg0, "weapon_index")
		if not f46_local6 then
			f46_local6 = CoD.CACUtility.EmptyItemIndex
		end
		local f46_local7 = Engine[0x6B7AC889104DED3](f46_local6)
		local f46_local8 = function(f47_arg0, f47_arg1, f47_arg2)
			local f47_local0 = 0x1D17195D5833BC4
			local f47_local1 = 0x7615068F50B3D66
			local f47_local2 = 0
			local f47_local3 = 0x0
			if CoD.CACUtility.mpPrestigeAttachments[f47_arg0] then
				f47_local0 = CoD.CACUtility.mpPrestigeAttachments[f47_arg0].name
				f47_local1 = CoD.CACUtility.mpPrestigeAttachments[f47_arg0].image
				f47_local2 = CoD.CACUtility.mpPrestigeAttachments[f47_arg0].plevel
				f47_local3 = CoD.CACUtility.mpPrestigeAttachments[f47_arg0].unlockDescRef
			end
			local f47_local4 = CoD.CACUtility.GetWeaponPLevel(f46_arg0, f46_local6) < f47_local2
			local f47_local5 = ""
			if f47_local4 then
				f47_local5 = Engine[0xF9F1239CFD921FE](0xFAE829460B60190, f47_local2)
			else
				f47_local5 = Engine[0xF9F1239CFD921FE](f47_local3, f46_local7)
			end
			return {
				models = {
					displayName = Engine[0xF9F1239CFD921FE](f47_local0),
					category = 0x0,
					icon = f47_local1,
					itemIndex = f47_arg2,
					frontendModel = 0x0,
					description = "",
					isEquippedFn = CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped,
					unlockInfo = f47_local5,
					isLocked = f47_local4,
					isPrestigeAttachment = true,
					hideRarity = true,
					lootId = 0x0,
				},
			}
		end
		if (f46_local2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] or f46_local2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]) and f46_local6 > CoD.CACUtility.EmptyItemIndex then
			for f46_local10, f46_local11 in ipairs(CoD.CACUtility.mpPrestigeAttachments) do
				if f46_local11.ref then
					table.insert(f46_local0, f46_local10, f46_local8(f46_local10, f46_local11.ref, Engine[0xB99CB645DEAEB92](f46_local6, f46_local11.itemIndex)))
				end
			end
		end
		return f46_local0
	end,
	true,
	{
		getModel = function(f48_arg0)
			local f48_local0 = Engine[0x4DF5CFBC1771947](f48_arg0)
			f48_local0 = f48_local0:create("WeaponCharmList")
			f48_local0:create("updateSelections")
			return f48_local0
		end,
	}
)
DataSources.WeaponDeathFxList = ListHelper_SetupDataSource(
	"WeaponDeathFxList",
	function(f49_arg0, f49_arg1)
		local f49_local0 = {}
		local f49_local1 = nil
		local f49_local2 = CoD.BaseUtility.GetMenuSessionMode(f49_arg1.menu)
		local f49_local3 = CoD.GetCustomization(f49_arg0, "weaponRefHash")
		if not f49_local3 then
			return f49_local0
		end
		local f49_local4 = {
			weaponRef = f49_local3,
		}
		local f49_local5 = Engine[0xA7E3CD65E63086F](0xA8F031F7C7B2ED8)
		if f49_local5 then
			for f49_local17, f49_local18 in ipairs(f49_local5) do
				if f49_local17 ~= 1 then
					local f49_local9 = CoD.BlackMarketTableUtility.LootInfoLookup(f49_arg0, f49_local18[0x28887F70BF5EBA], f49_local18[0x562938AF86028A0], f49_local4)
					local f49_local10 = f49_local9.isLoot or f49_local9.isEntitlement
					if f49_local9.owned and f49_local10 then
						local f49_local11 = true
						if f49_local18[0x28887F70BF5EBA] == 0x9A9BD2389B3C356 and CoD.BaseUtility.IsDvarEnabled("ui_hideRavenDeathFX") then
							f49_local11 = false
						end
						if f49_local11 then
							local f49_local12 = table.insert
							local f49_local13 = f49_local0
							local f49_local14 = {}
							local f49_local15 = {
								displayName = Engine[0xF9F1239CFD921FE](f49_local18[0x55F116BF695C8F6]),
								category = 0x7B491E0F2A8C286,
							}
							local f49_local16 = f49_local18[0xBFF4CC56C2092F0]
							if not f49_local16 then
								f49_local16 = 0x7615068F50B3D66
							end
							f49_local15.icon = f49_local16
							f49_local15.itemIndex = f49_local17 - 1
							f49_local15.description = Engine[0xF9F1239CFD921FE](0xB48EB67B2AE72B3)
							f49_local15.isEquippedFn = CoD.WeaponOptionsUtility.IsDeathFxEquipped
							f49_local15.isNewFn = CoD.BreadcrumbUtility.IsWeaponDeathFxNew
							f49_local16 = f49_local9.unlockInfo
							if not f49_local16 then
								f49_local16 = ""
							end
							f49_local15.unlockInfo = f49_local16
							f49_local16 = CoD.BlackMarketUtility.LootIdRarities[f49_local9.rarity]
							if not f49_local16 then
								f49_local16 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
							end
							f49_local15.rarity = f49_local16
							f49_local16 = f49_local9.owned
							if not f49_local16 then
								f49_local16 = f49_local9.available
								if not f49_local16 then
									f49_local16 = not f49_local10
								end
							end
							f49_local15.available = f49_local16
							f49_local16 = f49_local9.owned
							if not f49_local16 then
								f49_local16 = not f49_local10
							end
							f49_local15.owned = f49_local16
							f49_local16 = f49_local9.isLoot
							if f49_local16 then
								f49_local16 = f49_local9.owned
								if f49_local16 then
									f49_local16 = Engine[0xCB675CA7856DA25]()
								end
							end
							f49_local15.trialLocked = f49_local16
							f49_local16 = f49_local9.isLoot
							if f49_local16 then
								f49_local16 = not f49_local9.owned
							end
							f49_local15.lootLocked = f49_local16
							f49_local16 = f49_local9.hideRarity
							if not f49_local16 then
								f49_local16 = f49_local9.isEntitlement
								if not f49_local16 then
									f49_local16 = false
								end
							end
							f49_local15.hideRarity = f49_local16
							f49_local15.lootId = f49_local18[0x28887F70BF5EBA]
							f49_local14.models = f49_local15
							f49_local12(f49_local13, f49_local14)
						end
					end
				end
			end
		end
		return f49_local0
	end,
	true,
	{
		getModel = function(f50_arg0)
			local f50_local0 = Engine[0x4DF5CFBC1771947](f50_arg0)
			f50_local0 = f50_local0:create("WeaponDeathFxList")
			f50_local0:create("updateSelections")
			return f50_local0
		end,
	}
)
DataSources.WeaponAccessoriesCategories = ListHelper_SetupDataSource("WeaponAccessoriesCategories", function(f51_arg0, f51_arg1)
	local f51_local0 = {}
	local f51_local1 = CoD.WeaponOptionsUtility.GetWeaponModelForMode(f51_arg1.menu)
	local f51_local2 = f51_local1.refHash:get() == 0xB2CB0CDA291AE11
	local f51_local3 = {
		{
			tabName = 0xFA6E6FE616EF67,
			tabWidget = "CoD.WeaponAccessoriesSelectInternal",
		},
	}
	if not f51_local2 then
		table.insert(f51_local3, {
			tabName = 0xD527320A0F9B5A,
			tabWidget = "CoD.WeaponDeathFxSelectInternal",
		})
	end
	for f51_local7, f51_local8 in ipairs(f51_local3) do
		table.insert(f51_local0, {
			models = {
				tabName = f51_local8.tabName,
				tabWidget = f51_local8.tabWidget,
			},
			properties = {
				selectIndex = false,
			},
		})
	end
	if f51_local0 and #f51_local0 > 0 then
		f51_local0[1].properties.selectIndex = true
	end
	return f51_local0
end, true)
CoD.WeaponOptionsUtility.WeaponOptionCategories = LuaEnum.createEnum("CAMO", "ACTIVE_CAMO", "SIGNATUREWEAPON_CAMO")
CoD.WeaponOptionsUtility.IsCACPersonalizationProgressionEnabled = function(f52_arg0, f52_arg1)
	local f52_local0 = nil
	if f52_arg0 then
		local f52_local1 = f52_arg0:getModel(f52_arg1, "unlockSessionMode")
		if not f52_local1 then
			f52_local1 = f52_arg0:getModel(f52_arg1, "challengeInfo.unlockSessionMode")
		end
		if f52_local1 then
			f52_local0 = f52_local1:get()
		end
		if f52_local0 and f52_local0 >= Enum[0x9C0C2196D8313A0][0x85320C1E5C16613] and f52_local0 < Enum[0x9C0C2196D8313A0][0x96642BDE9B5962E] and (not (f52_local0 ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] or not IsLive()) or f52_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and IsLive()) then
			return true
		end
	end
	return false
end
CoD.WeaponOptionsUtility.GetWeaponOptionItemInfo = function(f53_arg0, f53_arg1, f53_arg2)
	local f53_local0, f53_local1, f53_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f53_arg0)
	local f53_local3 = CoD.WeaponOptionsUtility.GetWeaponModelForMode(f53_arg0)
	local f53_local4 = f53_arg1:getModel()
	if not f53_local4 then
		return true
	else
		local f53_local5 = f53_local4.weaponOptionSubIndex
		local f53_local6 = f53_local4.weaponOptionType
		if f53_local3 and f53_local5 and f53_local6 then
			if not f53_local3 or not f53_local3.itemIndex:get() then
				local f53_local7 = CoD.CACUtility.EmptyItemIndex
			end
			local f53_local8 = f53_local5:get()
			local f53_local9 = f53_local6:get()
			local f53_local10 = CoD.CACUtility.EmptyItemIndex
			if f53_local9 == Enum[0x3CBA8D054211104][0x393666961B28A15] then
				f53_local10 = CoD.WeaponOptionsUtility.GetCamoWeaponOptionIndexFromCamoOptionsIndex(f53_local8)
			else
				f53_local10 = Engine[0xB70A5B816249FFB](f53_local8, f53_local9)
			end
			local f53_local7
			if f53_local9 == Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B] then
				if f53_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
					local f53_local11 = CoD.BaseUtility.GetMenuLoadoutListItemSlot(f53_arg0)
					if f53_local0[f53_local11] then
						f53_local7 = Engine[0x174D9B6F1E719ED](CoD.SafeGetModelValue(f53_local0[f53_local2], "itemIndex"), CoD.SafeGetModelValue(f53_local0[f53_local11], "itemIndex"))
					end
				else
					f53_local7 = Engine[0x174D9B6F1E719ED](CoD.SafeGetModelValue(f53_local0, "weaponIndex"), CoD.SafeGetModelValue(f53_local0, "itemIndex"))
				end
			end
			return f53_local7, f53_local8, f53_local9, f53_local10
		else
		end
	end
end
CoD.WeaponOptionsUtility.IsDarkmatterLockedForDLC = function(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4)
	if Engine[0x2DCF0973239E909](CoD.CACUtility.CamoOptionsTable, Enum[0x5DD5CC8AEA7314B][0xAA94CABDA68EB21], Enum[0x5DD5CC8AEA7314B][0xB79D07B3744EA1A], "camo", Enum[0x5DD5CC8AEA7314B][0xA6342D60A0D5AAE], f54_arg4) == 0x229B17B6185BE37 then
		return CoD.WeaponOptionsUtility.IsGoldCamoLockedForWeapon(f54_arg0, f54_arg1, f54_arg2)
	else
		return false
	end
end
CoD.WeaponOptionsUtility.IsItemLockedHelper = function(f55_arg0, f55_arg1, f55_arg2)
	if not CoD.WeaponOptionsUtility.IsCACPersonalizationProgressionEnabled(f55_arg1, f55_arg2) then
	else
	end
	local f55_local0, f55_local1, f55_local2, f55_local3 = CoD.WeaponOptionsUtility.GetWeaponOptionItemInfo(f55_arg0, f55_arg1, f55_arg2)
	if f55_local0 and f55_local1 and f55_local2 and f55_local3 then
		if f55_local2 == Enum[0x3CBA8D054211104][0x43A5BEA0FB2891E] then
			return false
		elseif f55_local2 == Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B] then
			local f55_local4 = f55_arg1:getModel()
			if f55_local4.entitlement then
				f55_local4 = f55_arg1:getModel()
				if f55_local4.entitlement:get() then
					return false
				end
			end
		end
		if (f55_local2 == Enum[0x3CBA8D054211104][0x393666961B28A15] or f55_local2 == Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B]) and f55_local1 == 0 then
			return false
		elseif f55_local2 == Enum[0x3CBA8D054211104][0xFC7C36E20E72CE4] then
			if f55_local1 == 0 then
				return false
			end
			local f55_local4 = Engine[0x2E29FB421AD554B](f55_local0, f55_local1)
			for f55_local9, f55_local10 in ipairs(CoD.CACUtility.mpPrestigeAttachments) do
				if f55_local4 == f55_local10.ref then
					local f55_local8
					if CoD.CACUtility.GetWeaponPLevel(f55_arg2, f55_local0) < f55_local9 then
						f55_local8 = not Dvar.allItemsUnlocked:get()
					else
						f55_local8 = false
					end
					return f55_local8
				end
			end
			return false
		else
			local f55_local4 = false
			local f55_local5 = CoD.BaseUtility.GetMenuSessionMode(f55_arg0)
			if CoD.SafeGetModelValue(f55_arg1:getModel(), "weaponOptionCategory") == "mstr" or f55_local2 == Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B] then
				f55_local4 = Engine[0xF1FD722970FDBA3](f55_arg2, f55_local0, f55_local3, f55_local5)
			else
				f55_local4 = Engine[0x76CD1A70C74BAA5](f55_arg2, f55_local0, f55_local3)
			end
			if f55_local4 then
				return true
			else
				local f55_local6 = f55_local0 and Engine[0xB98952F69D937F9](f55_local0)
				local f55_local7 = f55_local6 and CoD.BlackMarketTableUtility.LootInfoLookup(f55_arg2, f55_local6)
				if f55_local2 == Enum[0x3CBA8D054211104][0x393666961B28A15] and f55_local7 and f55_local7.isLoot then
					return CoD.WeaponOptionsUtility.IsDarkmatterLockedForDLC(f55_arg2, f55_local0, f55_local5, f55_local2, f55_local3)
				else
					return f55_local4
				end
			end
		end
	else
		return false
	end
end
CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked = function(f56_arg0, f56_arg1, f56_arg2)
	local f56_local0 = f56_arg1:getModel()
	local f56_local1 = CoD.BaseUtility.GetMenuSessionMode(f56_arg0)
	local f56_local2 = CoD.SafeGetModelValue(f56_local0, "weaponOptionCategory")
	if f56_local2 == "active" or f56_local2 == "lootbase" then
		local f56_local3 = CoD.SafeGetModelValue(f56_local0, "ref")
		local f56_local4 = f56_local3 and Engine[0xC53F8D38DF9042B](f56_local3)
		local f56_local5
		if f56_local4 then
			f56_local5 = CoD.WeaponOptionsUtility.AlternateCamoLootIDLookup[f56_local4]
			if not f56_local5 then
			elseif f56_local5 then
				local f56_local6 = CoD.GetCustomization(f56_arg2, "weaponRefHash")
				local f56_local7 = CoD.BlackMarketTableUtility.GetLootInfoForCamo(f56_arg2, f56_local5, f56_local6, CoD.SafeGetModelValue(f56_local0, "entitlement"))
				local f56_local8 = not f56_local7.owned
				if f56_local2 == "lootbase" then
					return f56_local8
				elseif f56_local7.owned then
					local f56_local9 = CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(f56_arg0, f56_arg1, f56_arg2)
					local f56_local10 = CoD.SafeGetModelValue(f56_local0, "weaponOptionWeaponRefHash")
					if f56_local10 and f56_local6 and f56_local10 ~= f56_local6 and not IsBooleanDvarSet("ui_allowReactiveOnAnyWeapon") then
						if f56_local9 then
							f56_local8 = true
						else
							f56_local8 = CoD.WeaponOptionsUtility.IsGoldCamoLockedForWeapon(f56_arg2, CoD.GetCustomization(f56_arg2, "weapon_index"), f56_local1)
						end
					end
				end
				return f56_local8
			end
		end
		f56_local5 = f56_local4
	end
	return CoD.WeaponOptionsUtility.IsItemLockedHelper(f56_arg0, f56_arg1, f56_arg2)
end
CoD.WeaponOptionsUtility.CanEquipWeaponOption = function(f57_arg0, f57_arg1, f57_arg2)
	if not CoD.CACUtility.IsProgressionWithWarzoneEnabledForMenu(f57_arg0) then
		return true
	else
		return not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(f57_arg0, f57_arg1, f57_arg2)
	end
end
CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped = function(f58_arg0, f58_arg1, f58_arg2)
	local f58_local0 = CoD.BaseUtility.GetMenuSessionMode(f58_arg0)
	if CoD.SafeGetModelValue(f58_arg1:getModel(), "weaponOptionCategory") == "active" then
		local f58_local1, f58_local2, f58_local3, f58_local4 = CoD.WeaponOptionsUtility.GetWeaponOptionItemInfo(f58_arg0, f58_arg1, f58_arg2)
		if f58_local1 and f58_local4 then
			return Engine[0xF1FD722970FDBA3](f58_arg2, f58_local1, f58_local4, f58_local0)
		end
	end
	return false
end
CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrappedOrLocked = function(f59_arg0, f59_arg1, f59_arg2)
	local f59_local0 = CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(f59_arg0, f59_arg1, f59_arg2)
	if not f59_local0 then
		f59_local0 = CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(f59_arg0, f59_arg1, f59_arg2)
	end
	return f59_local0
end
CoD.WeaponOptionsUtility.IsItemWeaponOptionLootOwned = function(f60_arg0, f60_arg1, f60_arg2)
	local f60_local0 = CoD.SafeGetModelValue(f60_arg1:getModel(), "lootData.owned")
	if f60_local0 == nil then
		return true
	else
		return f60_local0
	end
end
CoD.WeaponOptionsUtility.IsWeaponOptionEquipped = function(f61_arg0, f61_arg1, f61_arg2, f61_arg3)
	local f61_local0 = CoD.BaseUtility.GetMenuSessionMode(f61_arg0)
	if f61_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return CoD.ZMLoadoutUtility.IsWeaponOptionEquipped(f61_arg0, f61_arg1, f61_arg2, f61_arg3)
	elseif f61_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return CoD.WZUtility.IsWeaponOptionEquipped(f61_arg0, f61_arg1, f61_arg2, f61_arg3)
	end
	local f61_local1 = f61_arg1:getModel()
	local f61_local2, f61_local3, f61_local4 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f61_arg0)
	if f61_local1 and f61_local2[f61_local4] and f61_local2[f61_local4][f61_arg3] then
		local f61_local5 = f61_local2[f61_local4][f61_arg3]:get()
		local f61_local6 = f61_local1.weaponOptionSubIndex:get()
		local f61_local7 = f61_local1.weaponOptionType:get()
		if f61_local7 == Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B] then
			if CoD.WeaponOptionsUtility.IsReticleItemIndexLoot(f61_local6) then
				local f61_local8 = f61_local1.attachmentRef
				if f61_local8 then
					f61_local8 = f61_local1.attachmentRef:get()
				end
				if f61_local8 then
					return f61_local6 == CoD.WeaponOptionsUtility.GetLootReticleBaseItemIndex(f61_local8, f61_local5)
				end
			else
				return f61_local6 == f61_local5 - f61_local5 % CoD.WeaponOptionsUtility.maxReticleColors
			end
		elseif f61_local7 == Enum[0x3CBA8D054211104][0x43A5BEA0FB2891E] and f61_local1.paintjobSlot then
			local f61_local8 = f61_local1.paintjobSlot:get()
			if f61_local8 ~= Enum[0xCA3F54D92F45B45][0x60CAA8D66ED63A5] then
				return f61_local8 == f61_local5
			end
		elseif f61_local6 ~= f61_local5 then
			return false
		elseif f61_local1.weaponOptionCategory:get() == "theme" and not CoD.WeaponOptionsUtility.IsWeaponSignatureThemeEquipped(f61_arg0, f61_arg1, f61_arg2, f61_arg3) then
			return false
		else
			return true
		end
	end
	return false
end
CoD.WeaponOptionsUtility.IsWeaponSignatureThemeEquipped = function(f62_arg0, f62_arg1, f62_arg2, f62_arg3)
	local f62_local0 = f62_arg1:getModel()
	local f62_local1, f62_local2, f62_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f62_arg0)
	if f62_local2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return CoD.ZMLoadoutUtility.IsWeaponOptionEquipped(f62_arg0, f62_arg1, f62_arg2, f62_arg3)
	elseif f62_local2 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return CoD.WZUtility.IsWeaponOptionEquipped(f62_arg0, f62_arg1, f62_arg2, f62_arg3)
	elseif f62_local0 and f62_local1[f62_local3] and f62_local1[f62_local3].weaponModelSlot then
		return f62_local0.signatureWeaponModelSlot:get() == f62_local1[f62_local3].weaponModelSlot:get()
	else
		return false
	end
end
CoD.WeaponOptionsUtility.IsWeaponSignatureThemeUnlocked = function(f63_arg0, f63_arg1, f63_arg2)
	local f63_local0, f63_local1, f63_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f63_arg0)
	local f63_local3 = CoD.WeaponOptionsUtility.GetWeaponModelForMode(f63_arg0)
	local f63_local4 = f63_arg1:getModel()
	if f63_local3 and f63_local4 then
		local f63_local5
		if f63_local3 then
			f63_local5 = f63_local3.itemIndex:get()
			if not f63_local5 then
			else
				local f63_local6 = CoD.CACUtility.GetUnlockableItemInfo(f63_local5, f63_local1)
				local f63_local7 = f63_local6.nameHash
				local f63_local8 = f63_local4.signatureWeaponModelSlot:get()
				if f63_local7 then
					for f63_local17, f63_local18 in pairs(Engine[0x9F0BB7D52A7A978](f63_local7)) do
						if f63_local18[0x3CF8E8F9081468B] == f63_local8 then
							local f63_local12, f63_local13 = CoD.BlackMarketTableUtility[0x5DDB72D0172A035](f63_arg2, f63_local18[0x28887F70BF5EBA])
							if f63_local12 then
								return f63_local13
							end
							local f63_local14 = f63_local4.ref
							if f63_local14 then
								f63_local14 = f63_local4.ref:get()
							end
							if f63_local14 then
								f63_local14 = Engine[0xC53F8D38DF9042B](f63_local14)
							end
							local f63_local15 = CoD.BlackMarketTableUtility.LootInfoLookup(f63_arg2, CoD.WeaponOptionsUtility.AlternateCamoLootIDLookup[f63_local14] or f63_local14)
							if f63_local15 and f63_local15.available and not f63_local15.owned then
								return false
							else
								local f63_local16
								if f63_local18[0x562938AF86028A0] ~= 0x0 then
									f63_local16 = Engine[0xB521CB398C92692](f63_arg2, f63_local18[0x562938AF86028A0])
								else
									f63_local16 = true
								end
							end
							return f63_local16
						end
					end
				end
			end
		end
		f63_local5 = CoD.CACUtility.EmptyItemIndex
	end
	return false
end
CoD.WeaponOptionsUtility.ShouldHideMasteryCamos = function(f64_arg0)
	local f64_local0
	if CoD.BaseUtility.GetMenuSessionMode(f64_arg0) == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and DataSources.WeaponOptions.getCurrentFilterItem() == "camo_zm" then
		f64_local0 = not CoD.BaseUtility.IsDvarEnabled("ui_zmEnableMasteryCamos")
	else
		f64_local0 = false
	end
	return f64_local0
end
CoD.WeaponOptionsUtility.ShouldHidePaintjobCamos = function(f65_arg0, f65_arg1)
	local f65_local0 = CoD.BaseUtility.GetMenuSessionMode(f65_arg0)
	local f65_local1 = DataSources.WeaponOptions.getCurrentFilterItem()
	if IsUserContentRestricted(f65_arg1) then
		return true
	else
		local f65_local2
		if f65_local0 ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] or f65_local1 ~= "camo_wz" then
			f65_local2 = false
		else
			f65_local2 = true
		end
	end
	return f65_local2
end
CoD.WeaponOptionsUtility.ShouldHideBlackMarketCamoFilters = function(f66_arg0)
	local f66_local0 = CoD.BaseUtility.GetMenuSessionMode(f66_arg0)
	return DataSources.WeaponOptions.getCurrentFilterItem() ~= "camo_loot"
end
CoD.WeaponOptionsUtility.ShouldHideWeaponOptionDescAndProgress = function(f67_arg0, f67_arg1, f67_arg2)
	local f67_local0 = CoD.BaseUtility.GetMenuSessionMode(f67_arg0)
	if not IsLive() then
		return true
	elseif not CoD.CACUtility.IsProgressionWithWarzoneEnabled(f67_local0) and not CoD.WeaponOptionsUtility.IsWeaponOptionInfoUnlockedAndRevealed(f67_arg0, f67_arg1, f67_arg2) then
		return true
	end
	return CoD.ModelUtility.IsSelfModelValueEqualTo(f67_arg1, f67_arg2, "weaponOptionCategory", "active") and not CoD.WeaponOptionsUtility.IsItemWeaponOptionLootOwned(f67_arg0, f67_arg1, f67_arg2)
end
CoD.WeaponOptionsUtility.ShouldHideWeaponOptionProgress = function(f68_arg0, f68_arg1, f68_arg2)
	local f68_local0 = f68_arg1:getModel()
	if f68_local0 and f68_local0.weaponOptionCategory then
		local f68_local1 = f68_local0.weaponOptionCategory:get() or ""
		if f68_local1 == "theme" then
			return false
		elseif f68_local1 == "mstr" or f68_local1 == "mpPrestigeAttachments" then
			return true
		elseif f68_local0.unlockProgressAndTarget and f68_local0.unlockProgressAndTarget:get() == "" then
			return true
		end
	end
	return false
end
CoD.WeaponOptionsUtility.IsCamoBuyable = function(f69_arg0, f69_arg1, f69_arg2)
	local f69_local0 = f69_arg1:getModel()
	if f69_local0 and f69_local0.weaponOptionCategory then
		if (f69_local0.weaponOptionCategory:get() or "") == "mstr" then
			return false
		else
			return CoD.WeaponOptionsUtility.IsWarzoneCamoFilter(f69_arg0, f69_arg1, f69_arg2)
		end
	else
		return false
	end
end
CoD.WeaponOptionsUtility.CanPurchasePaintCanCamo = function(f70_arg0, f70_arg1)
	local f70_local0 = f70_arg0:getModel(f70_arg1, "unlockProgressAndTarget")
	if not f70_local0 or f70_local0:get() == "" then
		return false
	else
		local f70_local1 = f70_arg0:getModel(f70_arg1, "paintCanCost")
		local f70_local2 = tonumber(f70_local1 and f70_local1:get())
		if f70_local2 then
			local f70_local3 = Engine[0x4DF5CFBC1771947](f70_arg1)
			f70_local3 = f70_local3.paintCanCount
			local f70_local4 = f70_local3 and f70_local3:get()
			return f70_local4 and f70_local2 <= f70_local4
		else
			return false
		end
	end
end
CoD.WeaponOptionsUtility.IsReticlePreviewing = function(f71_arg0, f71_arg1, f71_arg2)
	local f71_local0 = f71_arg1:getModel()
	local f71_local1 = f71_arg2._selectedReticle
	if f71_local0 and f71_local1 then
		local f71_local2 = f71_local0.itemIndex:get()
		if CoD.WeaponOptionsUtility.IsReticleItemIndexLoot(f71_local2) then
			local f71_local3 = f71_local0.attachmentRef
			if f71_local3 then
				f71_local3 = f71_local0.attachmentRef:get()
			end
			if f71_local3 then
				return CoD.WeaponOptionsUtility.GetLootReticleBaseItemIndex(f71_local3, f71_local2) ~= CoD.WeaponOptionsUtility.GetLootReticleBaseItemIndex(f71_local3, f71_local1)
			end
		else
			return f71_local2 - f71_local2 % CoD.WeaponOptionsUtility.maxReticleColors ~= f71_local1 - f71_local1 % CoD.WeaponOptionsUtility.maxReticleColors
		end
	end
	return true
end
CoD.WeaponOptionsUtility.ShouldShowReticleCycleColorPrompt = function(f72_arg0, f72_arg1, f72_arg2)
	local f72_local0 = f72_arg1:getModel()
	if f72_local0 and not IsMouseOrKeyboard(f72_arg0) then
		local f72_local1 = f72_local0.multiColor
		if f72_local1 then
			f72_local1 = f72_local0.multiColor:get()
		end
		return f72_local1 and not CoD.WeaponOptionsUtility.IsReticlePreviewing(f72_arg0, f72_arg1, f72_arg2)
	else
		return false
	end
end
CoD.WeaponOptionsUtility.IsInCurrentModeFilter = function(f73_arg0, f73_arg1, f73_arg2)
	local f73_local0 = CoD.BaseUtility.GetMenuSessionMode(f73_arg0)
	local f73_local1 = DataSources.WeaponOptions.getCurrentFilterItem()
	if f73_local0 and f73_local1 and (not (f73_local0 ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] or f73_local1 ~= "camo_mp") or not (f73_local0 ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] or f73_local1 ~= "camo_wz") or f73_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and f73_local1 == "camo_zm") then
		return true
	else
		return false
	end
end
CoD.WeaponOptionsUtility.IsBlackMarketCamoFilter = function()
	local f74_local0 = DataSources.WeaponOptions.getCurrentFilterItem()
	return f74_local0 and f74_local0 == "camo_loot"
end
CoD.WeaponOptionsUtility.IsWarzoneCamoFilter = function(f75_arg0, f75_arg1, f75_arg2)
	local f75_local0 = DataSources.WeaponOptions.getCurrentFilterItem()
	return f75_local0 and f75_local0 == "camo_wz"
end
CoD.WeaponOptionsUtility.IsWeaponOptionInfoUnlockedAndRevealed = function(f76_arg0, f76_arg1, f76_arg2)
	local f76_local0 = f76_arg1:getModel()
	if f76_local0 and f76_local0.weaponOptionCategory then
		local f76_local1 = f76_local0.weaponOptionCategory:get() or ""
		if f76_local1 == "theme" or f76_local1 == "active" then
			return not CoD.WeaponOptionsUtility.IsItemWeaponOptionCamoWrapped(f76_arg0, f76_arg1, f76_arg2)
		end
	end
	return false
end
CoD.WeaponOptionsUtility.IsPrestigeAttachmentEquipped = function(f77_arg0, f77_arg1, f77_arg2, f77_arg3)
	if CoD.BaseUtility.GetMenuSessionMode(f77_arg0) == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return CoD.ZMLoadoutUtility.IsArmoryPrestigeElementAttachmentEquipped(f77_arg2, f77_arg3, f77_arg0)
	else
		return CoD.CACUtility.IsAttachmentEquippedInCurrentClass(f77_arg0, CoD.SafeGetModelValue(f77_arg2:getModel(), "itemIndex"))
	end
end
CoD.WeaponOptionsUtility.IsWeaponCharmEquipped = function(f78_arg0, f78_arg1, f78_arg2, f78_arg3)
	local f78_local0 = CoD.BaseUtility.GetMenuSessionMode(f78_arg0)
	local f78_local1 = f78_arg2:getModel()
	if f78_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return CoD.ZMLoadoutUtility.IsArmoryWeaponCharmEquipped(f78_arg0, f78_arg2, f78_arg3)
	elseif f78_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return CoD.WZUtility.IsArmoryWeaponCharmEquipped(f78_arg0, f78_arg2, f78_arg3)
	else
		local f78_local2 = CoD.SafeGetModelValue(f78_local1, "itemIndex")
		local f78_local3 = CoD.BaseUtility.GetMenuModel(f78_arg0)
		local f78_local4 = CoD.BaseUtility.GetMenuLoadoutSlot(f78_arg0)
		if f78_local3 and f78_local3[f78_local4] then
			return f78_local3[f78_local4 .. "." .. CoD.CACUtility.WeaponCharmAttachment.pathName]:get() == f78_local2
		else
			return false
		end
	end
end
CoD.WeaponOptionsUtility.IsCharmEquippedForWeapon = function(f79_arg0, f79_arg1)
	local f79_local0 = CoD.BaseUtility.GetMenuSessionMode(f79_arg0)
	local f79_local1 = CoD.CACUtility.EmptyItemIndex
	local f79_local2 = CoD.BaseUtility.GetMenuModel(f79_arg0)
	local f79_local3 = CoD.BaseUtility.GetMenuLoadoutSlot(f79_arg0)
	if f79_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f79_local1 = CoD.ZMLoadoutUtility.GetArmoryCharmItem(f79_arg0, f79_arg1)
	elseif f79_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return CoD.CACUtility.EmptyItemIndex < CoD.WZUtility.GetArmoryCharmItem(f79_arg0, f79_arg1)
	elseif f79_local2 and f79_local2[f79_local3] then
		f79_local1 = f79_local2[f79_local3 .. ".charmIndex"]:get()
	end
	if CoD.CACUtility.EmptyItemIndex < f79_local1 then
		return true
	elseif f79_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return CoD.CACUtility.EmptyItemIndex < CoD.ZMLoadoutUtility.GetArmoryPrestigeAttachmentIndex(f79_arg0, f79_arg1)
	end
	local f79_local4 = CoD.CACUtility.primaryWeaponPrestigeSlot
	if f79_local3 == "secondary" then
		f79_local4 = CoD.CACUtility.secondaryWeaponPrestigeSlot
	end
	local f79_local5 = f79_local3 .. "." .. f79_local4
	if f79_local2[f79_local5] and f79_local2[f79_local5].itemIndex then
		return CoD.CACUtility.EmptyItemIndex < f79_local2[f79_local5].itemIndex:get()
	end
	return false
end
CoD.WeaponOptionsUtility.IsDeathFxEquipped = function(f80_arg0, f80_arg1, f80_arg2, f80_arg3)
	local f80_local0 = CoD.BaseUtility.GetMenuSessionMode(f80_arg0)
	local f80_local1 = f80_arg2:getModel()
	if f80_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return CoD.ZMLoadoutUtility.IsArmoryWeaponDeathFxEquipped(f80_arg0, f80_arg2, f80_arg3)
	elseif f80_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return CoD.WZUtility.IsArmoryWeaponDeathFxEquipped(f80_arg0, f80_arg2, f80_arg3)
	else
		local f80_local2 = CoD.SafeGetModelValue(f80_local1, "itemIndex")
		local f80_local3 = CoD.BaseUtility.GetMenuModel(f80_arg0)
		local f80_local4 = CoD.BaseUtility.GetMenuLoadoutSlot(f80_arg0)
		if f80_local3 and f80_local3[f80_local4] then
			return f80_local3[f80_local4 .. ".deathFxIndex"]:get() == f80_local2
		else
		end
	end
end
CoD.WeaponOptionsUtility.IsDeathFxEquippedForWeapon = function(f81_arg0, f81_arg1)
	local f81_local0 = CoD.BaseUtility.GetMenuSessionMode(f81_arg0)
	local f81_local1 = CoD.CACUtility.EmptyItemIndex
	if f81_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f81_local1 = CoD.ZMLoadoutUtility.GetArmoryDeathFx(f81_arg0, f81_arg1)
	elseif f81_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f81_local1 = CoD.WZUtility.GetArmoryDeathFx(f81_arg0, f81_arg1)
	else
		local f81_local2 = CoD.BaseUtility.GetMenuModel(f81_arg0)
		local f81_local3 = CoD.BaseUtility.GetMenuLoadoutSlot(f81_arg0)
		if f81_local2 and f81_local2[f81_local3] then
			f81_local1 = f81_local2[f81_local3 .. ".deathFxIndex"]:get()
		end
	end
	return CoD.CACUtility.EmptyItemIndex < f81_local1
end
CoD.WeaponOptionsUtility.ExcludedShippedDeathFxWeapons = {
	[0xB0E53F588197120] = true,
	[0x83455A968205009] = true,
	[0xB2CB0CDA291AE11] = true,
	[0x8A2B56939A972EE] = true,
}
CoD.WeaponOptionsUtility.CanEquipDeathFxForWeapon = function(f82_arg0)
	local f82_local0 = CoD.GetCustomization(f82_arg0, "weaponRefHash")
	local f82_local1, f82_local2 = CoD.BlackMarketTableUtility.SimpleLootLookup(f82_arg0, f82_local0, nil)
	if f82_local1 == CoD.BlackMarketTableUtility.SimpleLootLookupTypes[0xC0D17BAD169557B] or CoD.BlackMarketUtility.IsCurrentLootSeasonAtLeast(5) then
		return not CoD.WeaponOptionsUtility.ExcludedShippedDeathFxWeapons[f82_local0]
	else
		return false
	end
end
CoD.WeaponOptionsUtility.ExcludedShippedCharmWeapons = {
	[0x8A2B56939A972EE] = true,
}
CoD.WeaponOptionsUtility.CanEquipCharmForWeapon = function(f83_arg0)
	local f83_local0 = CoD.GetCustomization(f83_arg0, "weaponRefHash")
	local f83_local1, f83_local2 = CoD.BlackMarketTableUtility.SimpleLootLookup(f83_arg0, f83_local0, nil)
	if f83_local1 == CoD.BlackMarketTableUtility.SimpleLootLookupTypes[0xC0D17BAD169557B] or CoD.BlackMarketUtility.IsCurrentLootSeasonAtLeast(5) then
		return not CoD.WeaponOptionsUtility.ExcludedShippedCharmWeapons[f83_local0]
	else
		return false
	end
end
CoD.WeaponOptionsUtility.SetupWeaponPersonalizationMenuModels = function(f84_arg0, f84_arg1)
	local f84_local0 = f84_arg0:getModel()
	local f84_local1 = CoD.BaseUtility.GetMenuSessionMode(f84_arg0)
	if f84_local0 then
		local f84_local2 = 0
		local f84_local3 = 0x0
		local f84_local4 = ""
		local f84_local5 = ""
		local f84_local6 = 0
		local f84_local7 = 0
		local f84_local8 = CoD.WeaponOptionsUtility.GetWeaponModelForMode(f84_arg0)
		if f84_local8 then
			f84_local2 = f84_local8.itemIndex:get()
			f84_local3 = f84_local8.refHash:get()
			f84_local5 = Engine[0x86DC0510B2E2933](f84_local2)
		end
		if f84_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			f84_local4 = f84_local8.name:get()
		else
			local f84_local9 = Engine[0x9F0BB7D52A7A978](f84_local3)
			local f84_local10 = nil
			if f84_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
				f84_local10 = CoD.ZMLoadoutUtility.GetWeaponModelSlot(f84_local2, f84_arg1)
			elseif f84_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
				f84_local10 = CoD.WZUtility.GetWeaponModelSlot(f84_local2, f84_arg1)
			end
			if f84_local10 ~= CoD.CACUtility.EmptyItemIndex and f84_local9[f84_local10 + 1] then
				f84_local4 = Engine[0xF9F1239CFD921FE](f84_local9[f84_local10 + 1][0x55F116BF695C8F6])
			end
		end
		local f84_local9 = f84_local0:create("weaponItemIndex")
		f84_local9:set(f84_local2)
		f84_local9 = f84_local0:create("weaponRef")
		f84_local9:set(f84_local3)
		f84_local9 = f84_local0:create("weaponName")
		f84_local9:set(f84_local4)
		f84_local9 = f84_local0:create("weaponItemGroup")
		f84_local9:set(f84_local5)
		if f84_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			f84_local6 = CoD.ZMLoadoutUtility.GetArmoryCharmItem(f84_arg0, f84_arg1)
			f84_local7 = CoD.ZMLoadoutUtility.GetArmoryDeathFx(f84_arg0, f84_arg1)
		elseif f84_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			f84_local6 = CoD.WZUtility.GetArmoryCharmItem(f84_arg0, f84_arg1)
			f84_local7 = CoD.WZUtility.GetArmoryDeathFx(f84_arg0, f84_arg1)
		else
			f84_local9 = CoD.BaseUtility.GetMenuModel(f84_arg0)
			local f84_local10 = CoD.BaseUtility.GetMenuLoadoutSlot(f84_arg0)
			if f84_local9 and f84_local9[f84_local10] then
				f84_local6 = f84_local9[f84_local10].charmIndex:get()
				f84_local7 = f84_local9[f84_local10].deathFxIndex:get()
			end
		end
		f84_local0.equippedAccessoryIndex:set(f84_local6)
		f84_local0.equippedDeathFxIndex:set(f84_local7)
	end
end
CoD.WeaponOptionsUtility.GetWeaponAccessoryIconForItemIndex = function(f85_arg0, f85_arg1, f85_arg2)
	local f85_local0 = tonumber(f85_arg2)
	if f85_local0 == CoD.CACUtility.EmptyItemIndex then
		local f85_local1 = CoD.BaseUtility.GetMenuSessionMode(f85_arg0)
		local f85_local2 = CoD.CACUtility.EmptyItemIndex
		local f85_local3 = CoD.GetCustomization(f85_arg1, "weapon_index")
		if f85_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			f85_local2 = CoD.ZMLoadoutUtility.GetArmoryPrestigeAttachmentIndex(f85_arg0, f85_arg1)
		elseif f85_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			local f85_local4 = CoD.BaseUtility.GetMenuModel(f85_arg0)
			local f85_local5 = CoD.BaseUtility.GetMenuLoadoutSlot(f85_arg0)
			if f85_local4 and f85_local4[f85_local5] then
				local f85_local6 = CoD.CACUtility.primaryWeaponPrestigeSlot
				if f85_local5 == "secondary" then
					f85_local6 = CoD.CACUtility.secondaryWeaponPrestigeSlot
				end
				if f85_local4[f85_local5][f85_local6] then
					f85_local2 = f85_local4[f85_local5][f85_local6].itemIndex:get()
				end
			end
		end
		if f85_local2 > CoD.CACUtility.EmptyItemIndex then
			local f85_local4 = Engine[0x2E29FB421AD554B](f85_local3, f85_local2, f85_local1)
			if f85_local4 == CoD.CACUtility.mpPrestigeAttachments[1].ref then
				return CoD.CACUtility.mpPrestigeAttachments[1].image
			elseif f85_local4 == CoD.CACUtility.mpPrestigeAttachments[2].ref then
				return CoD.CACUtility.mpPrestigeAttachments[2].image
			end
		end
		return 0x7615068F50B3D66
	end
	local f85_local1 = Engine[0xA7E3CD65E63086F](0xF2DC7A2FE7EEDC5)
	if f85_local1 then
		for f85_local5, f85_local6 in ipairs(f85_local1) do
			if f85_local5 - 1 == f85_local0 then
				return f85_local6[0xBFF4CC56C2092F0] and Engine[0xC53F8D38DF9042B](f85_local6[0xBFF4CC56C2092F0]) or 0x7615068F50B3D66
			end
		end
	end
	return 0x7615068F50B3D66
end
CoD.WeaponOptionsUtility.GetWeaponDeathFxIconForItemIndex = function(f86_arg0)
	local f86_local0 = tonumber(f86_arg0)
	if f86_local0 > CoD.CACUtility.EmptyItemIndex then
		local f86_local1 = Engine[0xA7E3CD65E63086F](0xA8F031F7C7B2ED8)
		if f86_local1 then
			for f86_local5, f86_local6 in ipairs(f86_local1) do
				if f86_local5 - 1 == f86_local0 then
					return f86_local6[0xBFF4CC56C2092F0] and Engine[0xC53F8D38DF9042B](f86_local6[0xBFF4CC56C2092F0]) or 0x7615068F50B3D66
				end
			end
		end
	end
	return 0x7615068F50B3D66
end
CoD.WeaponOptionsUtility.UpdateWeaponOptionLists = function(f87_arg0, f87_arg1)
	ForceNotifyControllerModel(f87_arg1, "WeaponPersonalization.listUpdate")
end
CoD.WeaponOptionsUtility.SetWeaponOptionsFilterFromTab = function(f88_arg0, f88_arg1)
	local f88_local0 = f88_arg1.filter
	if f88_local0 then
		DataSources.WeaponOptions.setCurrentFilterItem(f88_local0)
		if f88_arg0 and f88_arg0.OptionsContainer and f88_arg0.OptionsContainer.CamoOptions and f88_arg0.OptionsContainer.CamoOptions.CamoFilterList then
			local f88_local1 = f88_arg0.OptionsContainer.CamoOptions.CamoFilterList
			if DataSources.WeaponOptionsCamoCategories.getCount(f88_local1) > 0 then
				if CoD.WeaponOptionsUtility.IsBlackMarketCamoFilter() then
					f88_local1:findItem(nil, {
						refHash = 0x4675E6BE6454E41,
					}, true, nil)
				else
					f88_local1:findItem(nil, {
						refHash = 0xEEEBCB6715E676F,
					}, true, nil)
				end
			end
		end
	end
end
CoD.WeaponOptionsUtility.SetFocusedWeaponOptionModel = function(f89_arg0, f89_arg1, f89_arg2)
	local f89_local0 = f89_arg0:getModel()
	local f89_local1 = f89_arg2.WeaponOptionInfo
	if f89_local0 and f89_local1 then
		f89_local1:setModel(f89_local0, f89_arg1)
	end
end
CoD.WeaponOptionsUtility.ClearWeaponOptionInfoModel = function(f90_arg0, f90_arg1, f90_arg2)
	local f90_local0 = f90_arg0.WeaponOptionInfo
	if f90_local0 then
		f90_local0:setModel(nil, f90_arg1)
	end
end
CoD.WeaponOptionsUtility.SetWeaponOptionClassItemHelper = function(f91_arg0, f91_arg1, f91_arg2, f91_arg3)
	if IsZombies() then
		CoD.ZMLoadoutUtility.SetWeaponOptionForVariant(f91_arg0, f91_arg1, f91_arg2, f91_arg3)
	elseif IsWarzone() then
		CoD.WZUtility.SetWeaponOptionForVariant(f91_arg0, f91_arg1, f91_arg2, f91_arg3)
	else
		CoD.WeaponOptionsUtility.SetWeaponOptionClassItem(f91_arg0, f91_arg1, f91_arg2, f91_arg3)
	end
end
CoD.WeaponOptionsUtility.SetWeaponOptionClassItem = function(f92_arg0, f92_arg1, f92_arg2, f92_arg3)
	local f92_local0, f92_local1, f92_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f92_arg3)
	local f92_local3 = f92_local0.classNum:get()
	local f92_local4 = CoD.CACUtility.GetBaseWeaponLoadoutSlotName(f92_local2)
	local f92_local5 = f92_arg1:getModel(f92_arg2, "weaponOptionTypeName")
	local f92_local6 = f92_arg1:getModel(f92_arg2, "weaponOptionSubIndex")
	local f92_local7 = f92_arg1:getModel(f92_arg2, "weaponOptionType")
	if f92_local5 and f92_local6 and f92_local7 then
		local f92_local8 = f92_local5:get()
		local f92_local9 = f92_local6:get()
		local f92_local10 = f92_local7:get()
		if f92_local10 == Enum[0x3CBA8D054211104][0x43A5BEA0FB2891E] then
			if f92_local2 == "primary" or f92_local2 == "secondary" then
				local f92_local11 = f92_arg1:getModel(f92_arg2, "paintjobSlot")
				CoD.CACUtility.SetClassItem(f92_arg2, f92_local3, f92_local4 .. ".paintjobSlot", f92_local11:get())
			end
		elseif f92_local10 == Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B] then
			CoD.CACUtility.SetClassItem(f92_arg2, f92_local3, f92_local4 .. ".reticleIndex", f92_local9)
		elseif f92_local10 == Enum[0x3CBA8D054211104][0x393666961B28A15] then
			CoD.CACUtility.SetClassItem(f92_arg2, f92_local3, f92_local4 .. ".camoIndex", f92_local9)
		end
		if f92_local2 == "primary" or f92_local2 == "secondary" then
			CoD.CACUtility.GetCustomClassModel(f92_arg2, f92_local3, f92_local0)
			CoD.CACUtility.UpdateClassWeaponModel(f92_arg3, f92_arg1, f92_arg2)
		end
		if f92_arg3._baseWeaponModelSlot then
			CoD.CACUtility.SetClassItem(f92_arg2, f92_local3, CoD.CACUtility.GetBaseWeaponLoadoutSlotName(f92_local2) .. ".weaponModelSlot", f92_arg3._baseWeaponModelSlot)
			f92_local0[f92_local2].weaponModelSlot:set(f92_arg3._baseWeaponModelSlot)
		end
		CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(f92_arg1, f92_arg2)
		local f92_local11 = Engine[0xB98952F69D937F9](CoD.GetCustomization(f92_arg2, "weapon_index"), Enum[0x6EB546760F890D2][0x569E84652131CD7], f92_local1)
		local f92_local12 = CoD.CraftUtility.GetLoadoutSlot(f92_arg2)
		local f92_local13 = "select01"
		local f92_local14 = nil
		if f92_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			f92_local14 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable(CoD.ZMLoadoutUtility.GetWeaponOptionsTableForIndex(f92_arg2, CoD.GetCustomization(f92_arg2, "weapon_index")))
		elseif f92_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			f92_local14 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable(CoD.WZUtility.GetWeaponOptionsTableForIndex(f92_arg2, CoD.GetCustomization(f92_arg2, "weapon_index")))
		else
			f92_local14 = CoD.CACUtility.GetWeaponOptionsFromClass(f92_arg2, f92_local0, f92_local2)
		end
		Engine[0x6ABA4D7F0840A1E](f92_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f92_arg2), {
			base_weapon_slot = f92_local12,
			weapon = f92_local11,
			attachments = "",
			camera = f92_local13,
			options = f92_local14,
		})
	end
end
CoD.WeaponOptionsUtility.SetWeaponOptionsCategory = function(f93_arg0, f93_arg1)
	local f93_local0, f93_local1, f93_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f93_arg0)
	local f93_local3 = CoD.WeaponOptionsUtility.GetWeaponSlotModelForMode(f93_arg0)
	if f93_local3 and f93_local3:get() ~= 0 then
		CoD.ModelUtility.SetControllerModelValueToEnum(f93_arg1, "WeaponPersonalization.category", CoD.WeaponOptionsUtility.WeaponOptionCategories.SIGNATUREWEAPON_CAMO)
	else
		CoD.ModelUtility.SetControllerModelValueToEnum(f93_arg1, "WeaponPersonalization.category", CoD.WeaponOptionsUtility.WeaponOptionCategories.CAMO)
	end
end
CoD.WeaponOptionsUtility.SetSignatureWeaponThemeHelper = function(f94_arg0, f94_arg1, f94_arg2, f94_arg3)
	if IsZombies() then
		CoD.ZMLoadoutUtility.SetSignatureWeaponThemeForVariant(f94_arg0, f94_arg1, f94_arg2, f94_arg3)
	elseif IsWarzone() then
		CoD.WZUtility.SetSignatureWeaponThemeForVariant(f94_arg0, f94_arg1, f94_arg2, f94_arg3)
	else
		CoD.WeaponOptionsUtility.SetSignatureWeaponTheme(f94_arg0, f94_arg1, f94_arg2, f94_arg3)
	end
end
CoD.WeaponOptionsUtility.SetSignatureWeaponTheme = function(f95_arg0, f95_arg1, f95_arg2, f95_arg3)
	local f95_local0, f95_local1, f95_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f95_arg3)
	local f95_local3 = f95_local0.classNum:get()
	local f95_local4 = f95_arg1:getModel(f95_arg2, "signatureWeaponModelSlot")
	local f95_local5 = f95_local0[f95_local2].weaponModelSlot
	local f95_local6 = f95_local0[f95_local2].camoIndex
	local f95_local7 = f95_arg1:getModel(f95_arg2, "weaponOptionSubIndex")
	if f95_local4 and f95_local5 then
		local f95_local8 = f95_local4:get()
		local f95_local9 = CoD.CACUtility.EmptyItemIndex
		if f95_local7 and f95_local7:get() then
			f95_local9 = f95_local7:get()
		end
		local f95_local10 = CoD.CACUtility.GetBaseWeaponLoadoutSlotName(f95_local2)
		CoD.CACUtility.SetClassItem(f95_arg2, f95_local3, f95_local10 .. ".weaponModelSlot", f95_local8)
		f95_local5:set(f95_local8)
		if f95_local6 then
			f95_local6:set(CoD.CACUtility.EmptyItemIndex)
			CoD.CACUtility.SetClassItem(f95_arg2, f95_local3, f95_local10 .. ".camoIndex", f95_local9)
		end
		if f95_local2 == "primary" or f95_local2 == "secondary" then
			CoD.CACUtility.GetCustomClassModel(f95_arg2, f95_local3, f95_local0)
			CoD.CACUtility.UpdateClassWeaponModel(f95_arg3, f95_arg1, f95_arg2)
			CoD.WeaponOptionsUtility.UpdateWeaponOptionLists(f95_arg1, f95_arg2)
		end
	end
end
CoD.WeaponOptionsUtility.PreviewSignatureWeaponTheme = function(f96_arg0, f96_arg1, f96_arg2)
	local f96_local0 = CoD.CraftUtility.GetLoadoutSlot(f96_arg2)
	local f96_local1 = CoD.BaseUtility.GetMenuSessionMode(f96_arg1)
	local f96_local2 = "select01"
	local f96_local3 = Engine[0xB98952F69D937F9](CoD.GetCustomization(f96_arg2, "weapon_index"), Enum[0x6EB546760F890D2][0x569E84652131CD7], f96_local1)
	local f96_local4 = f96_arg0:getModel(f96_arg2, "signatureWeaponModelSlot")
	local f96_local5 = f96_arg0:getModel(f96_arg2, "weaponOptionSubIndex")
	if f96_local4 and f96_local5 then
		local f96_local6 = f96_local4:get()
		local f96_local7 = f96_local5:get()
		local f96_local8 = 0
		if f96_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			f96_local8 = CoD.ZMLoadoutUtility.GetArmoryCharmItemFromWeapon(f96_arg2, CoD.GetCustomization(f96_arg2, "weapon_index"))
		elseif f96_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			f96_local8 = CoD.WZUtility.GetArmoryCharmItemFromWeapon(f96_arg2, CoD.GetCustomization(f96_arg2, "weapon_index"))
		else
			local f96_local9 = CoD.BaseUtility.GetMenuModel(f96_arg1)
			local f96_local10 = f96_local9 and f96_local9[f96_local0].charmIndex
			if f96_local10 then
				local f96_local11 = f96_local10:get()
			end
			f96_local8 = f96_local11 or 0
		end
		local f96_local9 = CoD.WeaponOptionsUtility.GetWeaponOptionsString(f96_local7, 0, 1, f96_local6, 0, f96_local8)
		local f96_local10 = ""
		if f96_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			f96_local10 = CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForWeaponIndex(f96_arg2, CoD.GetCustomization(f96_arg2, "weapon_index"), f96_local1)
		end
		Engine[0x6ABA4D7F0840A1E](f96_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f96_arg2), {
			base_weapon_slot = f96_local0,
			weapon = f96_local3,
			attachments = f96_local10,
			camera = f96_local2,
			options = f96_local9,
		})
	end
end
CoD.WeaponOptionsUtility.ClearWeaponOptionsHelper = function(f97_arg0, f97_arg1, f97_arg2, f97_arg3)
	if IsZombies() then
		CoD.ZMLoadoutUtility.ClearWeaponOptionForVariant(f97_arg0, f97_arg1, f97_arg3, f97_arg2)
	elseif IsWarzone() then
		CoD.WZUtility.ClearWeaponOptionForVariant(f97_arg0, f97_arg1, f97_arg3, f97_arg2)
	else
		CoD.WeaponOptionsUtility.ClearWeaponOptions(f97_arg1, f97_arg2, f97_arg3)
	end
end
CoD.WeaponOptionsUtility.ClearWeaponOptions = function(f98_arg0, f98_arg1, f98_arg2)
	local f98_local0, f98_local1, f98_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f98_arg1)
	local f98_local3 = Engine[0xB98952F69D937F9](CoD.GetCustomization(f98_arg2, "weapon_index"), Enum[0x6EB546760F890D2][0x569E84652131CD7], f98_local1)
	local f98_local4 = CoD.CraftUtility.GetLoadoutSlot(f98_arg2)
	local f98_local5 = f98_local0.classNum:get()
	local f98_local6 = CoD.CACUtility.GetBaseWeaponLoadoutSlotName(f98_local2)
	local f98_local7 = "select01"
	local f98_local8 = f98_local0[f98_local2].camoIndex
	local f98_local9 = f98_local0[f98_local2].reticleIndex
	local f98_local10 = f98_local0[f98_local2].paintjobSlot
	local f98_local11 = f98_local0[f98_local2].weaponModelSlot
	local f98_local12 = f98_local0[f98_local2].charmIndex
	local f98_local13 = f98_local8:get()
	if not f98_local13 then
		f98_local13 = CoD.CACUtility.EmptyItemIndex
	end
	if not f98_local9:get() then
		local f98_local14 = CoD.CACUtility.EmptyItemIndex
	end
	local f98_local15 = f98_local11:get()
	if not f98_local15 then
		f98_local15 = CoD.CACUtility.EmptyItemIndex
	end
	local f98_local16 = "1"
	local f98_local17 = f98_local12:get()
	if not f98_local17 then
		f98_local17 = CoD.CACUtility.EmptyItemIndex
	end
	local f98_local18 = f98_arg0:getModel(f98_arg2, "weaponOptionType")
	local f98_local19
	if f98_local18 then
		f98_local19 = f98_local18:get()
		if not f98_local19 then
		else
			if f98_local11 and f98_arg1._baseWeaponModelSlot and f98_local19 == Enum[0x3CBA8D054211104][0x393666961B28A15] then
				CoD.CACUtility.SetClassItem(f98_arg2, f98_local5, f98_local6 .. ".weaponModelSlot", f98_arg1._baseWeaponModelSlot)
				f98_local0[f98_local2].weaponModelSlot:set(f98_arg1._baseWeaponModelSlot)
			end
			if f98_local8 and f98_local19 == Enum[0x3CBA8D054211104][0x393666961B28A15] then
				f98_local8:set(CoD.CACUtility.EmptyItemIndex)
				CoD.CACUtility.SetClassItem(f98_arg2, f98_local5, f98_local6 .. ".camoIndex", CoD.CACUtility.EmptyItemIndex)
			end
			if f98_local9 and f98_local19 == Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B] then
				local f98_local14 = CoD.CACUtility.EmptyItemIndex
				f98_local9:set(CoD.CACUtility.EmptyItemIndex)
				CoD.CACUtility.SetClassItem(f98_arg2, f98_local5, f98_local6 .. ".reticleIndex", CoD.CACUtility.EmptyItemIndex)
			end
			if f98_local10 and f98_local19 == Enum[0x3CBA8D054211104][0x43A5BEA0FB2891E] then
				f98_local10:set(Enum[0xCA3F54D92F45B45][0x60CAA8D66ED63A5])
				CoD.CACUtility.SetClassItem(f98_arg2, f98_local5, f98_local6 .. ".paintjobSlot", Enum[0xCA3F54D92F45B45][0x60CAA8D66ED63A5])
			end
			if f98_local6 == "primary" or f98_local6 == "secondary" then
				CoD.CACUtility.GetCustomClassModel(f98_arg2, f98_local5, f98_local0)
				CoD.CACUtility.UpdateClassWeaponModel(f98_arg1, f98_arg0, f98_arg2)
			end
			Engine[0x6ABA4D7F0840A1E](f98_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f98_arg2), {
				base_weapon_slot = f98_local4,
				weapon = f98_local3,
				attachments = "",
				camera = f98_local7,
				options = CoD.WeaponOptionsUtility.GetWeaponOptionsString(f98_local13, f98_local14, f98_local16, f98_local15, CoD.WeaponOptionsUtility.GetRobStageForCamoIndex(f98_local13), f98_local17),
			})
		end
	end
	f98_local19 = Enum[0x3CBA8D054211104][0xFC7C36E20E72CE4]
end
CoD.WeaponOptionsUtility.SetBaseWeaponOptions = function(f99_arg0, f99_arg1, f99_arg2)
	local f99_local0, f99_local1, f99_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f99_arg1)
	local f99_local3 = Engine[0xB98952F69D937F9](CoD.GetCustomization(f99_arg2, "weapon_index"), Enum[0x6EB546760F890D2][0x569E84652131CD7], f99_local1)
	local f99_local4 = CoD.CraftUtility.GetLoadoutSlot(f99_arg2)
	local f99_local5 = "select01"
	local f99_local6 = nil
	if f99_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f99_local6 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable(CoD.ZMLoadoutUtility.GetWeaponOptionsTableForIndex(f99_arg2, CoD.GetCustomization(f99_arg2, "weapon_index")))
	elseif f99_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f99_local6 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable(CoD.WZUtility.GetWeaponOptionsTableForIndex(f99_arg2, CoD.GetCustomization(f99_arg2, "weapon_index")))
	else
		f99_local6 = CoD.CACUtility.GetWeaponOptionsFromClass(f99_arg2, f99_local0, f99_local2)
	end
	local f99_local7 = ""
	if f99_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f99_local7 = CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForWeaponIndex(f99_arg2, CoD.GetCustomization(f99_arg2, "weapon_index"), f99_local1)
	end
	Engine[0x6ABA4D7F0840A1E](f99_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f99_arg2), {
		base_weapon_slot = f99_local4,
		weapon = f99_local3,
		attachments = f99_local7,
		camera = f99_local5,
		options = f99_local6,
	})
end
CoD.WeaponOptionsUtility.SetWeaponPrestigeAttachmentItem = function(f100_arg0, f100_arg1, f100_arg2, f100_arg3, f100_arg4)
	local f100_local0 = CoD.BaseUtility.GetMenuSessionMode(f100_arg0)
	local f100_local1 = CoD.SafeGetModelValue(f100_arg2:getModel(), "itemIndex")
	if f100_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return CoD.ZMLoadoutUtility.SetArmoryWeaponAccessoryAttachment(f100_arg0, f100_arg3, f100_local1)
	else
		CoD.WeaponOptionsUtility.SetWeaponAccessoryAttachmentItemInternal(f100_arg0, f100_arg3, CoD.SafeGetModelValue(f100_arg2:getModel(), "itemIndex"), nil, f100_arg4)
		local f100_local2 = DataSources.WeaponCharmList.getModel(f100_arg3)
		f100_local2.updateSelections:forceNotifySubscriptions()
	end
end
CoD.WeaponOptionsUtility.ClearWeaponPrestigeAttachmentItem = function(f101_arg0, f101_arg1, f101_arg2)
	if CoD.BaseUtility.GetMenuSessionMode(f101_arg0) == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		return CoD.ZMLoadoutUtility.SetArmoryWeaponAccessoryAttachment(f101_arg0, f101_arg1, CoD.CACUtility.EmptyItemIndex)
	else
		CoD.WeaponOptionsUtility.SetWeaponAccessoryAttachmentItemInternal(f101_arg0, f101_arg1, CoD.CACUtility.EmptyItemIndex, nil, f101_arg2)
	end
end
CoD.WeaponOptionsUtility.UpdateWeaponPrestigeAttachment = function(f102_arg0, f102_arg1, f102_arg2)
	local f102_local0 = CoD.SafeGetModelValue(f102_arg1:getModel(), "ref")
	local f102_local1, f102_local2, f102_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f102_arg0)
	local f102_local4 = f102_local3 .. f102_local0
	local f102_local5 = CoD.GetCustomization(f102_arg2, "weaponRefHash")
	local f102_local6 = ""
	local f102_local7 = ""
	if f102_local2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f102_local6 = CoD.WeaponOptionsUtility.GetWeaponOptionsStringFromTable(CoD.ZMLoadoutUtility.GetWeaponOptionsTableForIndex(f102_arg2, CoD.GetCustomization(f102_arg2, "weapon_index")))
		f102_local7 = CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForWeaponIndex(f102_arg2, CoD.GetCustomization(f102_arg2, "weapon_index"), f102_local2)
	else
		f102_local6 = CoD.CACUtility.GetWeaponOptionsFromClass(f102_arg2, f102_local1, f102_local3)
	end
	f102_local7 = LUI.appendStringWithDelimiter(f102_local7, f102_local0, "+")
	if f102_local5 and f102_local5 ~= 0x0 then
		Engine[0x6ABA4D7F0840A1E](f102_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f102_arg2), {
			base_weapon_slot = f102_local4,
			weapon = f102_local5,
			attachments = f102_local7,
			camera = "attach",
			options = f102_local6,
		})
	end
end
CoD.WeaponOptionsUtility.UpdateWeaponReticleColor = function(f103_arg0, f103_arg1, f103_arg2)
	local f103_local0, f103_local1, f103_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f103_arg0)
	local f103_local3 = f103_local0.classNum:get()
	local f103_local4 = CoD.CACUtility.GetBaseWeaponLoadoutSlotName(f103_local2)
	local f103_local5 = f103_arg1:getModel()
	if f103_local5 then
		CoD.CACUtility.SetClassItem(f103_arg2, f103_local3, f103_local4 .. ".reticleIndex", f103_local5.itemIndex:get())
	end
end
CoD.WeaponOptionsUtility.UpdateWeaponReticle = function(f104_arg0, f104_arg1, f104_arg2, f104_arg3)
	local f104_local0 = f104_arg1:getModel()
	if f104_local0 then
		local f104_local1 = f104_local0.weaponOptionSubIndex:get()
		f104_arg0._reticle = f104_local1
		if f104_arg3 then
			f104_arg0._selectedReticle = f104_local1
		end
	end
end
CoD.WeaponOptionsUtility.UpdateWeaponReticleImage = function(f105_arg0, f105_arg1, f105_arg2, f105_arg3)
	local f105_local0 = f105_arg1:getModel()
	local f105_local1 = f105_arg2:getModel()
	if f105_local1 and f105_local0 and f105_arg0._reticle then
		f105_local1.image:set(f105_local1.attachmentRef:get() .. "_" .. f105_local0.imageIndex:get())
		f105_arg0._selectedReticle = f105_local0.imageIndex:get()
	end
end
CoD.WeaponOptionsUtility.SetWeaponReticleFilterFromTab = function(f106_arg0, f106_arg1, f106_arg2)
	local f106_local0 = f106_arg2.filter
	if f106_local0 then
		DataSources.WeaponReticles._filter = f106_local0
		ForceNotifyControllerModel(f106_arg1, "WeaponPersonalization.reticleListUpdate")
	end
end
CoD.WeaponOptionsUtility.ResetWeaponOptions = function(f107_arg0, f107_arg1)
	CoD.WeaponOptionsUtility.WeaponOptionsTable = nil
end
CoD.WeaponOptionsUtility.OpenActiveCamoStageDetailsOverlay = function(f108_arg0, f108_arg1, f108_arg2, f108_arg3, f108_arg4)
	local f108_local0 = CoD.BaseUtility.GetMenuModel(f108_arg0)
	local f108_local1 = CoD.BaseUtility.GetMenuSessionMode(f108_arg0)
	local f108_local2 = CoD.BaseUtility.GetMenuLoadoutSlot(f108_arg0)
	local f108_local3 = f108_arg3:getModel()
	local f108_local4 = CoD.SafeGetModelValue(f108_local3, "weaponOptionCategory") or "active"
	if f108_arg4 then
		local f108_local5 = CoD.SafeGetModelValue(f108_local3, "itemIndex")
		if f108_local5 then
			CoD.SetCustomization(f108_arg1, f108_local5, "weapon_index")
		end
		local f108_local6 = CoD.SafeGetModelValue(f108_local3, "weaponNameHash")
		if f108_local6 then
			CoD.SetCustomization(f108_arg1, f108_local6, "weaponRefHash")
		end
	end
	return OpenOverlay(f108_arg0, f108_arg2, f108_arg1, {
		_sessionMode = f108_local1,
		_model = f108_local3,
		_loadoutSlot = f108_local2,
		_baseWeaponModelSlot = f108_arg0._baseWeaponModelSlot,
		_weaponOptionCategory = f108_local4,
		_classModel = f108_local0,
	})
end
CoD.WeaponOptionsUtility.PreviewActiveCamoStages = function(f109_arg0, f109_arg1, f109_arg2)
	local f109_local0, f109_local1, f109_local2 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f109_arg0)
	local f109_local3 = CoD.GetCustomization(f109_arg2, "weapon_index")
	local f109_local4 = CoD.GetCustomization(f109_arg2, "weaponRefHash")
	local f109_local5 = CoD.CraftUtility.GetLoadoutSlot(f109_arg2)
	local f109_local6 = "select01"
	local f109_local7 = ""
	local f109_local8 = ""
	if f109_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f109_local8 = CoD.ZMLoadoutUtility.GetArmoryAttachmentStringForWeaponIndex(f109_arg2, f109_local3, f109_local1)
	end
	local f109_local9 = CoD.SafeGetModelValue(f109_arg1:getModel(), "stageCamoIndex")
	if not f109_local9 then
		f109_local9 = f109_local0.weaponOptionSubIndex:get() or 0
	end
	local f109_local10 = f109_arg0._baseWeaponModelSlot or 0
	if f109_arg0._weaponOptionCategory == "theme" then
		f109_local10 = f109_local0.signatureWeaponModelSlot:get()
	end
	local f109_local11 = CoD.SafeGetModelValue(f109_arg1:getModel(), "robStage") or 0
	local f109_local12 = 0
	if f109_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f109_local12 = CoD.ZMLoadoutUtility.GetArmoryCharmItemFromWeapon(f109_arg2, f109_local3)
	elseif f109_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f109_local12 = CoD.WZUtility.GetArmoryCharmItemFromWeapon(f109_arg2, f109_local3)
	else
		local f109_local13 = f109_arg0._classModel
		local f109_local14 = f109_local13 and f109_local13[f109_local5]
		local f109_local15 = f109_local14 and f109_local14.charmIndex
		if f109_local15 then
			local f109_local16 = f109_local15:get()
		end
		f109_local12 = f109_local16 or 0
	end
	Engine[0x6ABA4D7F0840A1E](f109_arg2, "CustomClass_update" .. CoD.GetLocalClientAdjustedNum(f109_arg2), {
		base_weapon_slot = f109_local5,
		weapon = f109_local4,
		attachments = f109_local8,
		camera = f109_local6,
		options = CoD.WeaponOptionsUtility.GetWeaponOptionsString(f109_local9, 0, 1, f109_local10, f109_local11, f109_local12),
	})
end
CoD.WeaponOptionsUtility.SetReactiveCamoCateogry = function(f110_arg0, f110_arg1)
	f110_arg1._category = "active"
end
CoD.WeaponOptionsUtility.InitPaintCansCountModel = function(f111_arg0)
	local f111_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f111_arg0), "paintCanCount")
	Engine[0x83C9B5DE1D9371](f111_local0, 0)
	local f111_local1 = Engine[0x8BF970606552F4C](f111_arg0, Enum[0xBBD4F9E70101BA8][0xAB0E693244221BC])
	if f111_local1 then
		Engine[0x83C9B5DE1D9371](f111_local0, f111_local1.PlayerStatsList.ITEMS_PAINT_CANS_COLLECTED.StatValue:get())
	end
end
CoD.WeaponOptionsUtility.EquipWeaponAccessory = function(f112_arg0, f112_arg1, f112_arg2, f112_arg3)
	local f112_local0 = f112_arg1:getModel()
	if f112_local0 then
		local f112_local1 = CoD.BaseUtility.GetMenuSessionMode(f112_arg0)
		local f112_local2 = CoD.SafeGetModelValue(f112_local0, "isPrestigeAttachment")
		local f112_local3 = CoD.SafeGetModelValue(f112_local0, "itemIndex")
		local f112_local4 = CoD.SafeGetModelValue(f112_local0, "lootId")
		local f112_local5 = f112_local3
		local f112_local6 = f112_local3
		if f112_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			if not f112_local2 then
				CoD.ZMLoadoutUtility.SetArmoryCharmItem(f112_arg0, f112_arg2, f112_local3)
				local f112_local7 = f112_arg0._model
				if f112_local7 then
					f112_local7 = f112_arg0._model.itemIndex:get()
				end
				f112_local5 = Engine[0xB99CB645DEAEB92](f112_local7, CoD.CACUtility.WeaponCharmAttachment.itemIndex, f112_local1)
			else
				CoD.ZMLoadoutUtility.SetArmoryCharmItem(f112_arg0, f112_arg2, CoD.CACUtility.EmptyItemIndex)
				f112_local6 = CoD.CACUtility.EmptyItemIndex
			end
			CoD.ZMLoadoutUtility.SetArmoryWeaponAccessoryAttachment(f112_arg0, f112_arg2, f112_local5)
		elseif f112_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			CoD.WZUtility.SetArmoryCharmItem(f112_arg0, f112_arg2, f112_local3)
		else
			local f112_local7 = CoD.BaseUtility.GetMenuModel(f112_arg0)
			local f112_local8 = CoD.BaseUtility.GetMenuLoadoutSlot(f112_arg0)
			local f112_local9 = f112_local7.classNum:get()
			local f112_local10 = f112_local8 .. "." .. CoD.CACUtility.WeaponCharmAttachment.pathName
			if not f112_local2 then
				CoD.CACUtility.SetClassItem(f112_arg2, f112_local9, f112_local10, f112_local6, nil, f112_local1)
				f112_local5 = Engine[0xB99CB645DEAEB92](CoD.GetCustomization(f112_arg2, "weapon_index"), CoD.CACUtility.WeaponCharmAttachment.itemIndex, f112_local1)
			else
				CoD.CACUtility.SetClassItem(f112_arg2, f112_local9, f112_local10, CoD.CACUtility.EmptyItemIndex, nil, f112_local1)
				f112_local6 = CoD.CACUtility.EmptyItemIndex
			end
			f112_local7[f112_local10]:set(f112_local6)
			local f112_local11 = f112_local8 .. "." .. CoD.CACUtility[f112_local8 .. "WeaponPrestigeSlot"]
			if AttemptAttachItem(f112_arg0, f112_arg2, f112_local1, f112_local7, f112_local11, f112_local5, nil) then
				f112_local7[f112_local11]:set(f112_local5)
			end
			CoD.CACUtility.WeaponPersonalizationUpdated(f112_arg2)
		end
		Engine[0xE6C09FDF6C8D188](f112_arg2, f112_local1)
		f112_arg1:playSound("equip_item")
		if f112_local4 and f112_local4 ~= 0x0 then
			Engine[0xDE279ECDDDD966](f112_arg2, 0xCD849658F801A88, {
				[0xAB83A8CC61E6325] = f112_local4,
				[0xA4F18CFDFE19A20] = "weapon charm",
			})
		end
		local f112_local7 = DataSources.WeaponPersonalization.getModel(f112_arg2)
		f112_local7.equippedAccessoryIndex:set(f112_local6)
		f112_local7 = DataSources.WeaponPersonalization.getModel(f112_arg2)
		f112_local7.equippedAccessoryIndex:forceNotifySubscriptions()
		f112_local7 = DataSources.WeaponCharmList.getModel(f112_arg2)
		f112_local7.updateSelections:forceNotifySubscriptions()
	end
end
CoD.WeaponOptionsUtility.ClearWeaponAccessory = function(f113_arg0, f113_arg1)
	local f113_local0 = CoD.BaseUtility.GetMenuSessionMode(f113_arg0)
	if f113_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		CoD.ZMLoadoutUtility.SetArmoryCharmItem(f113_arg0, f113_arg1, CoD.CACUtility.EmptyItemIndex)
		CoD.ZMLoadoutUtility.SetArmoryWeaponAccessoryAttachment(f113_arg0, f113_arg1, CoD.CACUtility.EmptyItemIndex)
	elseif f113_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		CoD.WZUtility.SetArmoryCharmItem(f113_arg0, f113_arg1, CoD.CACUtility.EmptyItemIndex)
	else
		local f113_local1 = CoD.BaseUtility.GetMenuModel(f113_arg0)
		local f113_local2 = CoD.BaseUtility.GetMenuLoadoutSlot(f113_arg0)
		local f113_local3 = f113_local1.classNum:get()
		local f113_local4 = f113_local2 .. "." .. CoD.CACUtility.WeaponCharmAttachment.pathName
		CoD.CACUtility.SetClassItem(f113_arg1, f113_local3, f113_local4, CoD.CACUtility.EmptyItemIndex, nil, f113_local0)
		f113_local1[f113_local4]:set(CoD.CACUtility.EmptyItemIndex)
		local f113_local5 = f113_local2 .. "." .. CoD.CACUtility[f113_local2 .. "WeaponPrestigeSlot"]
		if AttemptAttachItem(f113_arg0, f113_arg1, f113_local0, f113_local1, f113_local5, CoD.CACUtility.EmptyItemIndex, nil) then
			f113_local1[f113_local5]:set(CoD.CACUtility.EmptyItemIndex)
		end
		CoD.CACUtility.WeaponPersonalizationUpdated(f113_arg1)
	end
	Engine[0xC4146BA76D0F982]("cac_equipment_remove")
	local f113_local1 = DataSources.WeaponPersonalization.getModel(f113_arg1)
	f113_local1.equippedAccessoryIndex:set(CoD.CACUtility.EmptyItemIndex)
	f113_local1 = DataSources.WeaponPersonalization.getModel(f113_arg1)
	f113_local1.equippedAccessoryIndex:forceNotifySubscriptions()
	f113_local1 = DataSources.WeaponCharmList.getModel(f113_arg1)
	f113_local1.updateSelections:forceNotifySubscriptions()
end
CoD.WeaponOptionsUtility.EquipDeathFx = function(f114_arg0, f114_arg1, f114_arg2, f114_arg3)
	local f114_local0 = f114_arg1:getModel()
	if f114_local0 then
		local f114_local1 = CoD.BaseUtility.GetMenuSessionMode(f114_arg0)
		local f114_local2 = CoD.SafeGetModelValue(f114_local0, "itemIndex")
		local f114_local3 = CoD.SafeGetModelValue(f114_local0, "lootId")
		if f114_local1 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			CoD.ZMLoadoutUtility.SetArmoryDeathFx(f114_arg0, f114_arg2, f114_local2)
		elseif f114_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			CoD.WZUtility.SetArmoryDeathFx(f114_arg0, f114_arg2, f114_local2)
		else
			local f114_local4 = CoD.BaseUtility.GetMenuModel(f114_arg0)
			local f114_local5 = CoD.BaseUtility.GetMenuLoadoutSlot(f114_arg0)
			if f114_local4 and f114_local5 then
				local f114_local6 = f114_local4.classNum:get()
				local f114_local7 = f114_local5 .. ".deathFxIndex"
				CoD.CACUtility.SetClassItem(f114_arg2, f114_local6, f114_local7, f114_local2, nil, f114_local1)
				f114_local4[f114_local7]:set(f114_local2)
			end
			CoD.CACUtility.WeaponPersonalizationUpdated(f114_arg2)
		end
		if f114_local3 and f114_local3 ~= 0x0 then
			Engine[0xDE279ECDDDD966](f114_arg2, 0xCD849658F801A88, {
				[0xAB83A8CC61E6325] = f114_local3,
				[0xA4F18CFDFE19A20] = "deathfx",
			})
		end
		f114_arg1:playSound("equip_item")
		local f114_local4 = DataSources.WeaponPersonalization.getModel(f114_arg2)
		f114_local4.equippedDeathFxIndex:set(f114_local2)
		f114_local4 = DataSources.WeaponDeathFxList.getModel(f114_arg2)
		f114_local4.updateSelections:forceNotifySubscriptions()
	end
end
CoD.WeaponOptionsUtility.ClearDeathFx = function(f115_arg0, f115_arg1)
	local f115_local0 = CoD.BaseUtility.GetMenuSessionMode(f115_arg0)
	if f115_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		CoD.ZMLoadoutUtility.SetArmoryDeathFx(f115_arg0, f115_arg1, CoD.CACUtility.EmptyItemIndex)
	elseif f115_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		CoD.WZUtility.SetArmoryDeathFx(f115_arg0, f115_arg1, CoD.CACUtility.EmptyItemIndex)
	else
		local f115_local1 = CoD.BaseUtility.GetMenuModel(f115_arg0)
		local f115_local2 = CoD.BaseUtility.GetMenuLoadoutSlot(f115_arg0)
		if f115_local1 and f115_local2 then
			local f115_local3 = f115_local1.classNum:get()
			local f115_local4 = f115_local2 .. ".deathFxIndex"
			CoD.CACUtility.SetClassItem(f115_arg1, f115_local3, f115_local4, CoD.CACUtility.EmptyItemIndex, nil, f115_local0)
			f115_local1[f115_local4]:set(CoD.CACUtility.EmptyItemIndex)
		end
		CoD.CACUtility.WeaponPersonalizationUpdated(f115_arg1)
	end
	Engine[0xC4146BA76D0F982]("cac_equipment_remove")
	local f115_local1 = DataSources.WeaponPersonalization.getModel(f115_arg1)
	f115_local1.equippedDeathFxIndex:set(CoD.CACUtility.EmptyItemIndex)
	f115_local1 = DataSources.WeaponDeathFxList.getModel(f115_arg1)
	f115_local1.updateSelections:forceNotifySubscriptions()
end
CoD.WeaponOptionsUtility.DeathFxCharacterUpdate = function(f116_arg0, f116_arg1)
	local f116_local0 = CoD.BaseUtility.GetMenuSessionMode(f116_arg0)
	local f116_local1 = CoD.BaseUtility.GetMenuStorageLoadoutBuffer(f116_arg0)
	local f116_local2 = 1
	if f116_local1 and f116_local1[0x8A76647E94009C3] then
		local f116_local3 = f116_local1[0x8A76647E94009C3][0xDF5E6BB54765F4C]:get()
		if not f116_local3 or f116_local3 == 0 then
			f116_local3 = 1
		end
	end
	SendCustomClientScriptNotifyForAdjustedClient(f116_arg1, "deathfx_update_", {
		event_name = "updateCharacter",
		mode = f116_local0,
		character_index = f116_local2,
	})
end
CoD.WeaponOptionsUtility.PreviewDeathFx = function(f117_arg0, f117_arg1, f117_arg2)
	SendCustomClientScriptNotifyForAdjustedClient(f117_arg2, "deathfx_update_", {
		event_name = "previewDeathFx",
		deathfxIndex = CoD.SafeGetModelValue(f117_arg1:getModel(), "itemIndex"),
	})
end
CoD.WeaponOptionsUtility.StopDeathFxPreview = function(f118_arg0, f118_arg1)
	SendCustomClientScriptNotifyForAdjustedClient(f118_arg1, "deathfx_update_", {
		event_name = "stopDeathFx",
	})
end
CoD.WeaponOptionsUtility.GetWeaponOptionProgress = function(f119_arg0, f119_arg1, f119_arg2, f119_arg3, f119_arg4, f119_arg5)
	local f119_local0 = f119_arg1
	if not CoD.CACUtility.IsProgressionWithWarzoneEnabled(CoD.BaseUtility.GetMenuSessionMode(f119_arg0)) then
		return 0, f119_arg3, f119_arg4, f119_arg5
	end
	local f119_local1 = 0
	if f119_arg2 and f119_arg3 and f119_arg3 > 0 then
		f119_local1 = f119_arg2 / f119_arg3
	end
	return f119_local1, f119_arg3, f119_arg4, f119_arg5
end
CoD.WeaponOptionsUtility.SplitStringToRGB = function(f120_arg0, f120_arg1)
	if f120_arg1 then
		local f120_local0 = CoD.ColorUtility.GetColorFromFormattedColorString(f120_arg1)
		return f120_local0.r, f120_local0.g, f120_local0.b
	else
		return 0, 0, 0
	end
end
CoD.WeaponOptionsUtility.GetWeaponOptionProgressString = function(f121_arg0, f121_arg1, f121_arg2)
	local f121_local0 = ""
	if f121_arg2 and f121_arg2 ~= "" then
		local f121_local1, f121_local2 = string.match(f121_arg2, "(%d+) (%d+)")
		f121_local0 = Engine[0xF9F1239CFD921FE](0x31CF0F51CCA3A27, f121_local1, f121_local2)
	end
	return f121_local0
end
CoD.WeaponOptionsUtility.GetWeaponOptionXPIconAlpha = function(f122_arg0, f122_arg1, f122_arg2, f122_arg3)
	local f122_local0 = 1
	local f122_local1 = f122_arg0:getModel()
	if f122_local1 and f122_local1.weaponOptionCategory then
		if (f122_local1.weaponOptionCategory:get() or "") == "mpPrestigeAttachments" then
			f122_local0 = 0
		end
		local f122_local2 = f122_local1.unlockReward:get()
		if not f122_local2 then
			f122_local2 = ""
		end
		if f122_local2 == "" then
			f122_local0 = 0
		end
	end
	if not CoD.WeaponOptionsUtility.IsItemWeaponOptionLocked(f122_arg1, f122_arg0, f122_arg2) then
		f122_local0 = 0
	end
	return f122_local0
end
CoD.WeaponOptionsUtility.GetWeaponPersonalizationHeader = function(f123_arg0, f123_arg1, f123_arg2)
	local f123_local0 = Engine[0xF9F1239CFD921FE](0x94122F68876E5D9)
	local f123_local1, f123_local2, f123_local3 = CoD.BaseUtility.GetMenuModelModeLoadoutSlot(f123_arg0)
	local f123_local4 = CoD.WeaponOptionsUtility.GetWeaponModelForMode(f123_arg0)
	if f123_local4 then
		local f123_local5 = CoD.CACUtility.GetUnlockableItemInfo(f123_local4.itemIndex and f123_local4.itemIndex:get() or CoD.CACUtility.EmptyItemIndex, f123_local2)
		f123_local0 = Engine[0xF9F1239CFD921FE](f123_arg2, Engine[0xF9F1239CFD921FE](f123_local5.displayName))
	end
	return Engine[0xB03220D3A4F3E38](f123_local0)
end
CoD.WeaponOptionsUtility.GetCamoStageDetailsHeader = function(f124_arg0, f124_arg1)
	local f124_local0 = f124_arg0._weaponOptionCategory
	local f124_local1 = 0x0
	if f124_local0 == "active" then
		f124_local1 = 0x3EBF286D00E090E
	elseif f124_local0 == "theme" then
		f124_local1 = 0x837D45D6FCD2F22
	elseif f124_local0 == "mstr" then
		f124_local1 = 0x69E2D5FAC28B11A
	end
	return LocalizeToUpperString(f124_local1)
end
