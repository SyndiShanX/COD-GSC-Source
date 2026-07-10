require("x64:53e8db3768fb02a")
require("x64:b370b3af9224bd0")
Lobby.BlackMarket = {}
Lobby.BlackMarket.StreamLootDropRule = 1
Lobby.BlackMarket.MaxDupeCount = 2
Lobby.BlackMarket.CrateLootDropRulesStart = 8
Lobby.BlackMarket.CrateLootDropRulesEnd = 12
Lobby.BlackMarket.GeneratedCrateLootDropRulesStart = 50
Lobby.BlackMarket.GetPageLimit = function()
	return tonumber(Dvar[@"hash_6F46B8777D431AC7"]:get())
end
Lobby.BlackMarket.GetMaxBatchSize = function()
	return tonumber(Dvar[@"hash_73370E245CE753C7"]:get())
end
Lobby.BlackMarket.GetPageOffset = function()
	return Lobby.BlackMarket.GetPageLimit() / 2
end
Lobby.BlackMarket.TestLootStreamState = function()
	Lobby.BlackMarket.GetPlayerLootStreamState({
		controller = 0,
		payload = '{"active_streams":[0]}',
	})
end
Lobby.BlackMarket.GetTierSkipModel = function(f5_arg0)
	local f5_local0 = Engine[@"getmodelforcontroller"](f5_arg0)
	f5_local0 = f5_local0:create("LootStreamProgress", true)
	if f5_local0 then
		return f5_local0:create("tierSkipsRedeemed", true)
	else
		return nil
	end
end
Lobby.BlackMarket.IncrementTierSkip = function(f6_arg0, f6_arg1)
	local f6_local0 = Lobby.BlackMarket.GetTierSkipModel(f6_arg0)
	if f6_local0 then
		local f6_local1 = f6_local0:get()
		if f6_local1 == nil then
			f6_local1 = 0
		end
		f6_local0:set(f6_local1 + f6_arg1)
	end
end
Lobby.BlackMarket.ClearTierSkips = function(f7_arg0)
	local f7_local0 = Lobby.BlackMarket.GetTierSkipModel(f7_arg0)
	if f7_local0 then
		f7_local0:set(0)
	end
end
Lobby.BlackMarket.GetPlayerLootStreamState = function(f8_arg0)
	local f8_local0 = f8_arg0.controller
	local f8_local1 = f8_arg0.payload
	local f8_local2 = CoDShared.Loot.GetSeasonInfo(CoDShared.Loot.GetCurrentSeason())
	local f8_local3 = tostring(f8_local2.id)
	local f8_local4 = CoDShared.Loot.GetNextSeason() or 0x0
	if f8_local4 ~= 0x0 then
		local f8_local5 = CoDShared.Loot.GetSeasonInfo(f8_local4)
		if f8_local5 ~= nil and f8_local5.id ~= nil then
			f8_local3 = f8_local3 .. ", " .. tostring(f8_local5.id)
		end
	end
	local f8_local5 = Engine[@"hash_543149249AED4499"](f8_local0)
	if #f8_local5 > 0 then
		for f8_local6 = 1, #f8_local5, 1 do
			if f8_local5[f8_local6].valid == true then
				f8_local3 = f8_local3 .. ", " .. tostring(f8_local5[f8_local6].id)
			end
		end
	end
	local f8_local6 = CoDShared.Loot.GetActiveContractIds(f8_local0)
	for f8_local7 = 1, #f8_local6, 1 do
		local f8_local10 = f8_local6[f8_local7]
		local f8_local11 = false
		for f8_local12 = 1, #f8_local5, 1 do
			if f8_local5[f8_local12].valid == true and f8_local5[f8_local12].id == f8_local10 then
				f8_local11 = true
			end
		end
		if not f8_local11 then
			f8_local3 = f8_local3 .. ", " .. tostring(f8_local10)
		end
	end
	local f8_local7 = CoDShared.Loot.GetCurrentEventContract()
	if f8_local7 ~= nil and f8_local7 ~= 0x0 then
		local f8_local8 = CoDShared.Loot.GetContractInfo(f8_local0, f8_local7)
		if f8_local8 ~= nil then
			f8_local3 = f8_local3 .. ", " .. tostring(f8_local8.id)
		end
	end
	if not f8_local1 then
		f8_local1 = string.format('{"active_streams":[%s]}', f8_local3)
	end
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Payload: " .. f8_local1 .. "\n")
	return Engine[@"hash_5C23839C02E77BFE"](f8_local0, f8_local1)
end
Lobby.BlackMarket.UpdatePageRequestModelStatus = function(f9_arg0, f9_arg1)
	local f9_local0 = Engine[@"getmodelforcontroller"](f9_arg0)
	f9_local0 = f9_local0:create("LootStreamProgress", true)
	if f9_local0 then
		local f9_local1 = f9_local0:create("pagedRequestStatus", true)
		f9_local1:set(f9_arg1)
	end
end
Lobby.BlackMarket.GetPlayerPagedSeasonStream = function(f10_arg0)
	local f10_local0 = f10_arg0.controller
	local f10_local1 = math.max(f10_arg0.offset - Lobby.BlackMarket.GetPageOffset(), 0)
	local f10_local2 = f10_arg0.streamHash
	local f10_local3 = string.format('{"drop_versions":[%s],"active_streams":[%s], "offset":%d, "limit":%d }', CoDShared.Loot.GetSeasonDropVersions(f10_local2), CoDShared.Loot.GetStreamId(f10_local2), f10_local1, Lobby.BlackMarket.GetPageLimit())
	Engine[@"hash_4CD2496D7B62D5E7"](f10_local0, f10_local2)
	Engine[@"hash_44ADBDF5D94DB79F"](f10_local0, f10_local2, f10_local1)
	Engine[@"hash_723E6820FC91D386"](f10_local0, f10_local2, false)
	Lobby.BlackMarket.UpdatePageRequestModelStatus(f10_local0, "Requested")
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Payload: " .. f10_local3 .. "\n")
	return Engine[@"hash_5C23839C02E77BFE"](f10_local0, f10_local3)
end
Lobby.BlackMarket.HandlePlayerLootStreamStateReponse = function(f11_arg0)
	local f11_local0 = f11_arg0.controller
	local f11_local1 = f11_arg0.jsonResponse
	local f11_local2 = Engine[@"hash_1A4245AC303B4CD5"]()
	if f11_local2 == nil then
		return
	elseif f11_local2:beginParse("LootResponse", f11_local1 .. " ") == false then
		return
	else
		local f11_local3 = f11_local2:getRoot()
		if f11_local3 == nil then
			f11_local2:endParse()
			return
		else
			Lobby.BlackMarket.HandleStreamLootStateResponse(f11_local0, f11_local3)
			f11_local2:endParse()
		end
	end
end
Lobby.BlackMarket.HandleStreamLootStateResponse = function(f12_arg0, f12_arg1)
	local f12_local0 = f12_arg1:getFieldByKey("stream_progress")
	if f12_local0 ~= nil then
		local f12_local1 = f12_local0:getAllKeys()
		for f12_local2 = 1, #f12_local1, 1 do
			local f12_local5 = f12_local1[f12_local2]
			local f12_local6 = f12_local0:getInt(f12_local5)
			local f12_local7 = CoDShared.Loot.GetStreamName(f12_local5)
			if f12_local7 ~= nil and f12_local7 ~= "" then
				Engine[@"hash_723E6820FC91D386"](f12_arg0, f12_local7, true)
				Engine[@"hash_51A871A943AE30CF"](f12_arg0, f12_local7, f12_local6)
			end
		end
	end
	local f12_local1 = f12_arg1:getFieldByKey("stream_descriptions")
	if f12_local1 ~= nil then
		Lobby.BlackMarket.ParseStreamDescriptions(f12_arg0, f12_local1)
	end
	local f12_local2 = f12_arg1:getFieldByKey("dupe_counter")
	if f12_local2 ~= nil then
		Engine[@"hash_1CE04AC847F16D0C"](f12_arg0, f12_local2:getInt())
	end
	Lobby.BlackMarket.UpdatePageRequestModelStatus(f12_arg0, "Valid")
	Engine[@"hash_35DE9A824C285D86"](f12_arg0)
end
Lobby.BlackMarket.HandleStreamLootStateFailure = function(f13_arg0)
	Lobby.BlackMarket.UpdatePageRequestModelStatus(f13_arg0.controller, "Failed")
end
Lobby.BlackMarket.ParseStreamDescriptions = function(f14_arg0, f14_arg1)
	local f14_local0 = f14_arg1:getAllKeys()
	for f14_local1 = 1, #f14_local0, 1 do
		local f14_local4 = f14_local0[f14_local1]
		local f14_local5 = CoDShared.Loot.GetStreamName(f14_local4)
		local f14_local6 = f14_arg1:getFieldByKey(f14_local4)
		local f14_local7 = f14_local6:getAllKeys()
		for f14_local8 = 1, #f14_local7, 1 do
			local f14_local11 = f14_local7[f14_local8]
			local f14_local12 = f14_local6:getFieldByKey(f14_local11)
			local f14_local13 = f14_local12:getAllKeys()
			local f14_local14 = false
			local f14_local15 = false
			local f14_local16 = {}
			for f14_local17 = 1, #f14_local13, 1 do
				local f14_local20 = f14_local13[f14_local17]
				local f14_local21 = f14_local12:getInt(f14_local20)
				if f14_local21 > 0 then
					f14_local16[f14_local17] = {}
					f14_local16[f14_local17].itemId = f14_local20
					f14_local16[f14_local17].quantity = f14_local21
					f14_local15 = true
				else
					f14_local16[f14_local17] = {}
					f14_local16[f14_local17].itemId = f14_local20
					f14_local16[f14_local17].quantity = f14_local21
					f14_local14 = true
				end
			end
			for f14_local17 = 1, #f14_local16, 1 do
				local f14_local20 = f14_local16[f14_local17]
				if f14_local20.quantity > 0 then
					if f14_local14 then
						Engine[@"hash_6C899780FD0E9731"](f14_arg0, f14_local5, f14_local11, f14_local20.itemId, LuaEnum.LOOT_FLAGS.REROLL)
					else
						Engine[@"hash_6C899780FD0E9731"](f14_arg0, f14_local5, f14_local11, f14_local20.itemId, LuaEnum.LOOT_FLAGS.VALID)
					end
				end
				if f14_local15 then
					local f14_local21 = Engine[@"getmodelforcontroller"](f14_arg0)
					f14_local21 = f14_local21:create("LootStreamProgress", true)
					if f14_local21 then
						local f14_local22 = f14_local21:create("recentRerolledItem", true)
						f14_local22:set(f14_local20.itemId)
					end
				end
				Engine[@"hash_6C899780FD0E9731"](f14_arg0, f14_local5, f14_local11, f14_local20.itemId, LuaEnum.LOOT_FLAGS.DUPE)
			end
		end
	end
end
Lobby.BlackMarket.TestLootDrop = function()
	Lobby.BlackMarket.OpenLootDrop({
		controller = 0,
		dropType = 1,
		payload = string.format(Lobby.BlackMarket.SeasonSupplyChainDrop, 1),
	})
end
Lobby.BlackMarket.OpenSupplyChainLootDrop = function(f16_arg0)
	local f16_local0 = f16_arg0.controller
	local f16_local1 = f16_arg0.tiersAvailable
	local f16_local2 = Lobby.BlackMarket.GetMaxBatchSize()
	if f16_local2 < f16_local1 then
		f16_local1 = f16_local2
	end
	local f16_local3 = nil
	local f16_local4 = Engine[@"hash_5352DC095BBB2A45"](f16_local0, "500100")
	if f16_local4 and f16_local4 > 0 then
		local f16_local5 = Engine[@"getmodelforcontroller"](f16_local0)
		f16_local5 = f16_local5:create("LootStreamProgress", true)
		if f16_local5 then
			local f16_local6 = f16_local5:create("lastPurchaseSeason", true)
			if f16_local6 then
				f16_local3 = f16_local6:get()
			end
		end
	end
	local f16_local5 = CoDShared.Loot.GetCurrentSeason()
	if f16_local3 ~= nil and f16_local3 ~= 0x0 and f16_local3 ~= f16_local5 then
		Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_loot"], "Overriding season.\n")
		f16_local5 = f16_local3
	end
	local f16_local6 = CoDShared.Loot.GetSeasonInfo(f16_local5)
	local f16_local7 = tostring(f16_local6.id)
	local f16_local8 = CoDShared.Loot.GetActiveContractIds(f16_local0)
	for f16_local9 = 1, #f16_local8, 1 do
		local f16_local12 = f16_local9
		local f16_local13 = f16_local8[1]
		if f16_local13 > 0 then
			local f16_local14 = CoDShared.Loot.GetStreamName(f16_local13)
			if f16_local14 ~= nil and f16_local14 ~= 0x0 and CoDShared.Loot.GetContractInfo(f16_local0, f16_local14) ~= nil then
				f16_local7 = f16_local7 .. ", " .. tostring(f16_local13)
			end
		end
	end
	local f16_local9 = CoDShared.Loot.GetCurrentEventContract()
	if f16_local9 ~= nil and f16_local9 ~= 0x0 then
		local f16_local10 = CoDShared.Loot.GetContractInfo(f16_local0, f16_local9)
		if f16_local10 ~= nil then
			f16_local7 = f16_local7 .. ", " .. tostring(f16_local10.id)
		end
	end
	f16_local10 = string.format('{"drop_versions":[%s], "active_streams":[%s], "batch_size": %i }', CoDShared.Loot.GetSeasonDropVersions(f16_local5), f16_local7, f16_local1)
	Engine[@"printinfo"](Enum[@"consolelabel_e"][@"con_label_loot"], "Payload: " .. f16_local10 .. "\n")
	Lobby.BlackMarket.UpdatePageRequestModelStatus(f16_local0, "Requested")
	Lobby.BlackMarket.OpenLootDrop({
		controller = f16_local0,
		dropType = 1,
		payload = f16_local10,
	})
end
Lobby.BlackMarket.OpenZombieLootDrop = function(f17_arg0)
	local f17_local0 = f17_arg0.controller
	local f17_local1 = f17_arg0.dropType
	local f17_local2 = f17_arg0.payload
	if f17_local1 then
		return Engine[@"hash_7526ABB3C49108D2"](f17_local0, f17_local1, f17_local2)
	else
	end
end
Lobby.BlackMarket.OpenLootDrop = function(f18_arg0)
	local f18_local0 = f18_arg0.controller
	local f18_local1 = f18_arg0.dropType
	local f18_local2 = f18_arg0.payload or "{}"
	if f18_local1 then
		return Engine[@"hash_26C232D7031CE1CF"](f18_local0, f18_local1, f18_local2)
	else
	end
end
Lobby.BlackMarket.HandleLootDropReponse = function(f19_arg0)
	Lobby.BlackMarket.UpdatePageRequestModelStatus(f19_arg0.controller, "Valid")
	local f19_local0 = f19_arg0.controller
	local f19_local1 = f19_arg0.jsonResponse
	local f19_local2 = Engine[@"hash_1A4245AC303B4CD5"]()
	if f19_local2 == nil then
		return
	elseif f19_local2:beginParse("LootResponse", f19_local1 .. " ") == false then
		return
	end
	local f19_local3 = f19_local2:getRoot()
	if f19_local3 == nil then
		f19_local2:endParse()
		return
	end
	local f19_local4 = f19_local3:getFieldByKey("Tracking_Info_Batch")
	if f19_local4 ~= nil then
		local f19_local5 = f19_local4:getFieldByKey("loot_rule_id_triggered")
		if f19_local5 ~= nil then
			local f19_local6 = f19_local5:getInt()
			if f19_local6 == Lobby.BlackMarket.StreamLootDropRule then
				Lobby.BlackMarket.HandleStreamLootDropResponse(f19_local0, f19_local3)
			elseif not (f19_local6 <= Lobby.BlackMarket.CrateLootDropRulesStart or f19_local6 > Lobby.BlackMarket.CrateLootDropRulesEnd) or f19_local6 >= Lobby.BlackMarket.GeneratedCrateLootDropRulesStart then
				Lobby.BlackMarket.HandleCrateDropResponse(f19_local0, f19_local3)
			elseif Lobby.BlackMarket.ZombiesHandleLootDropResponse then
				Lobby.BlackMarket.ZombiesHandleLootDropResponse(f19_local0, f19_local3)
			end
		end
	end
	f19_local2:endParse()
end
Lobby.BlackMarket.HandleStreamLootDropResponse = function(f20_arg0, f20_arg1)
	local f20_local0 = f20_arg1:getFieldByKey("Inventory_Updates")
	if f20_local0 ~= nil then
		Lobby.BlackMarket.ParseInventoryUpdates(f20_arg0, f20_local0)
	end
	local f20_local1 = f20_arg1:getFieldByKey("Balance_Updates")
	if f20_local1 ~= nil then
		Lobby.BlackMarket.ParseBalanceUpdates(f20_arg0, f20_local1)
	end
	local f20_local2 = f20_arg1:getFieldByKey("Tracking_Info_Batch")
	if f20_local2 ~= nil then
		Lobby.BlackMarket.ParseStreamTrackingInfo(f20_arg0, f20_local2)
	end
	Engine[@"hash_35DE9A824C285D86"](f20_arg0)
end
Lobby.BlackMarket.HandleCrateDropResponse = function(f21_arg0, f21_arg1)
	local f21_local0 = f21_arg1:getFieldByKey("Inventory_Updates")
	if f21_local0 ~= nil then
		Lobby.BlackMarket.ParseInventoryUpdates(f21_arg0, f21_local0)
	end
	local f21_local1 = f21_arg1:getFieldByKey("Balance_Updates")
	if f21_local1 ~= nil then
		Lobby.BlackMarket.ParseBalanceUpdates(f21_arg0, f21_local1)
	end
	local f21_local2 = f21_arg1:getFieldByKey("Tracking_Info_Batch")
	if f21_local2 ~= nil then
		Lobby.BlackMarket.ParseCrateTrackingInfo(f21_arg0, f21_local2)
	end
	Engine[@"hash_35DE9A824C285D86"](f21_arg0)
end
Lobby.BlackMarket.ParseInventoryUpdates = function(f22_arg0, f22_arg1)
	local f22_local0 = f22_arg1:getAllKeys()
	for f22_local1 = 1, #f22_local0, 1 do
		local f22_local4 = f22_local0[f22_local1]
		local f22_local5 = f22_arg1:getInt(f22_local4)
		if f22_local5 > 0 then
			CoDLootShared.UpdateLootOwnedForItem(f22_arg0, f22_local4)
			Engine[@"hash_18C8B4F26575DBEE"](f22_arg0, f22_local4, f22_local5)
		end
		if f22_local5 < 0 then
			f22_local5 = -1 * f22_local5
			local f22_local6 = Engine[@"hash_5352DC095BBB2A45"](f22_arg0, f22_local4)
			if f22_local6 > 0 then
				if f22_local6 < f22_local5 then
					f22_local5 = f22_local6
				end
				if f22_local4 == "500103" then
					Lobby.BlackMarket.IncrementTierSkip(f22_arg0, f22_local5)
				end
				Engine[@"removeitemfrominventory"](f22_arg0, f22_local4, f22_local5)
			end
			Engine[@"printwarning"](Enum[@"consolelabel_e"][@"con_label_loot"], "Tier quantity modified during loot operation.\n")
		end
	end
end
Lobby.BlackMarket.ParseBalanceUpdates = function(f23_arg0, f23_arg1)
	local f23_local0 = f23_arg1:getAllKeys()
	if not f23_local0 then
		return
	end
	local f23_local1 = function(f24_arg0, f24_arg1, f24_arg2)
		Engine[@"hash_961B1DCBEECD208"](f24_arg0, f24_arg1, Engine[@"hash_4E2D8DD79754640C"](f24_arg0, f24_arg1) + f24_arg2)
	end
	for f23_local5, f23_local6 in pairs(f23_local0) do
		local f23_local7 = f23_arg1:getFieldByKey(f23_local6)
		if f23_local7 then
			f23_local1(f23_arg0, f23_local6, f23_local7:getInt())
		end
	end
end
Lobby.BlackMarket.IsRNGStream = function(f25_arg0)
	local f25_local0 = {
		["1000"] = true,
		["1001"] = true,
	}
	return f25_local0[f25_arg0] ~= nil
end
Lobby.BlackMarket.AppendRNGResultModel = function(f26_arg0, f26_arg1, f26_arg2, f26_arg3, f26_arg4, f26_arg5)
	local f26_local0 = Engine[@"getmodelforcontroller"](f26_arg0)
	f26_local0 = f26_local0:create("LootRNGResult")
	local f26_local1 = f26_local0:create("itemsEarned")
	f26_local1 = f26_local1:get() + 1
	local f26_local2 = f26_local0:create("itemsEarned")
	f26_local2:set(f26_local1)
	f26_local2 = f26_local0:create("item" .. f26_local1)
	local f26_local3 = f26_local2:create("itemId")
	f26_local3:set(f26_arg2)
	f26_local3 = f26_local2:create("itemQuantity")
	f26_local3:set(f26_arg3)
	f26_local3 = f26_local2:create("rollType")
	f26_local3:set(f26_arg4)
	f26_local3 = f26_local2:create("isRerollReplaced")
	f26_local3:set(f26_arg5)
	f26_local3 = Engine[@"converttoxhash"](f26_arg1)
	for f26_local8, f26_local9 in ipairs(CoDShared.Loot.Cases) do
		if f26_local3 == f26_local9 then
			local f26_local7 = f26_local0:create("streamId")
			f26_local7:set("1000")
			return
		end
	end
	for f26_local8, f26_local9 in ipairs(CoDShared.Loot.Crates) do
		if f26_local3 == f26_local9 then
			local f26_local7 = f26_local0:create("streamId")
			f26_local7:set("1001")
			return
		end
	end
	f26_local4 = f26_local0:create("streamId")
	f26_local4:set(f26_arg1)
end
Lobby.BlackMarket.FinalizeRNGResultModel = function(f27_arg0)
	local f27_local0 = Engine[@"getmodelforcontroller"](f27_arg0)
	f27_local0 = f27_local0:create("LootRNGResult")
	local f27_local1 = f27_local0:create("ready")
	f27_local1:set(true)
end
Lobby.BlackMarket.ParseRNGDropDetail = function(f28_arg0, f28_arg1)
	local f28_local0 = f28_arg1:getFieldByKey("dupe_counter")
	if f28_local0 ~= nil then
		Engine[@"hash_1CE04AC847F16D0C"](f28_arg0, f28_local0:getInt())
	end
	local f28_local1 = f28_arg1:getString("stream_id")
	local f28_local2 = f28_arg1:getString("roll_type")
	local f28_local3 = f28_arg1:getFieldByKey("item_count")
	local f28_local4 = f28_local3:getAllKeys()
	Engine[@"hash_35DE9A824C285D86"](f28_arg0)
	CoDShared.Loot.UpdateAllRNGUnlockedModel(f28_arg0)
	local f28_local5 = 0
	for f28_local6 = 1, #f28_local4, 1 do
		local f28_local9 = {}
		local f28_local10 = f28_local4[f28_local6]
		local f28_local11 = f28_local3:getInt(f28_local10)
		local f28_local12 = false
		local f28_local13 = nil
		if f28_local11 > 0 then
			if f28_local2 == "rng_no_dupe" then
				f28_local13 = LuaEnum.LOOT_FLAGS.REROLL
				Engine[@"hash_1CE04AC847F16D0C"](f28_arg0, 0)
			else
				f28_local13 = LuaEnum.LOOT_FLAGS.VALID
			end
		elseif string.find(f28_local2, "rng_dupe") then
			f28_local13 = LuaEnum.LOOT_FLAGS.DUPE
			local f28_local14 = false
			local f28_local15 = Engine[@"getmodelforcontroller"](f28_arg0)
			f28_local15 = f28_local15:create("LootStreamProgress", true)
			local f28_local16 = f28_local15:get("allRngUnlocked")
			if f28_local16 then
				f28_local14 = f28_local16:get()
			end
			if f28_local0:getInt() >= Lobby.BlackMarket.MaxDupeCount and not f28_local14 then
				f28_local12 = true
			else
				Engine[@"hash_1CE04AC847F16D0C"](f28_arg0, f28_local0:getInt() + 1)
			end
		end
		Lobby.BlackMarket.AppendRNGResultModel(f28_arg0, f28_local1, f28_local10, f28_local11, f28_local13, f28_local12)
		Engine[@"hash_35DE9A824C285D86"](f28_arg0)
		CoDShared.Loot.UpdateAllRNGUnlockedModel(f28_arg0)
	end
end
Lobby.BlackMarket.ParseStreamDropDetail = function(f29_arg0, f29_arg1)
	local f29_local0 = 0
	local f29_local1 = f29_arg1:getFieldByKey("drop_type")
	local f29_local2 = f29_arg1:getInt("stream_index")
	local f29_local3 = f29_arg1:getFieldByKey("dupe_counter")
	if f29_local3 ~= nil then
		Engine[@"hash_1CE04AC847F16D0C"](f29_arg0, f29_local3:getInt())
	end
	local f29_local4 = CoDShared.Loot.GetStreamName(f29_arg1:getString("stream_id"))
	local f29_local5 = f29_arg1:getString("roll_type")
	local f29_local6 = f29_arg1:getFieldByKey("item_count")
	local f29_local7 = f29_local6:getAllKeys()
	for f29_local8 = 1, #f29_local7, 1 do
		local f29_local11 = f29_local7[f29_local8]
		if 0 < f29_local6:getInt(f29_local11) then
			if f29_local11 ~= CoDShared.Loot.CaseMarkerId then
				f29_local0 = f29_local0 + 1
				if f29_local5 == "rng_no_dupe" then
					Engine[@"hash_6C899780FD0E9731"](f29_arg0, f29_local4, f29_local2, f29_local11, LuaEnum.LOOT_FLAGS.REROLL)
					Engine[@"hash_1CE04AC847F16D0C"](f29_arg0, 0)
				else
					Engine[@"hash_6C899780FD0E9731"](f29_arg0, f29_local4, f29_local2, f29_local11, LuaEnum.LOOT_FLAGS.VALID)
				end
			end
		end
		if string.find(f29_local5, "rng_dupe") then
			if f29_local3:getInt() == Lobby.BlackMarket.MaxDupeCount then
				local f29_local12 = Engine[@"getmodelforcontroller"](f29_arg0)
				f29_local12 = f29_local12:create("LootStreamProgress", true)
				if f29_local12 then
					local f29_local13 = f29_local12:create("recentRerolledItem", true)
					f29_local13:set(f29_local11)
					f29_local13 = f29_local12:create("playRerollAnim", true)
					f29_local13:set(true)
				end
			end
			f29_local0 = f29_local0 + 1
			Engine[@"hash_6C899780FD0E9731"](f29_arg0, f29_local4, f29_local2, f29_local11, LuaEnum.LOOT_FLAGS.DUPE)
			Engine[@"hash_1CE04AC847F16D0C"](f29_arg0, f29_local3:getInt() + 1)
		end
	end
	local f29_local8 = Engine[@"hash_6159D7050715A2C3"](f29_arg0, f29_local4)
	if f29_local8 == nil or f29_local8 < f29_local2 then
		Engine[@"hash_51A871A943AE30CF"](f29_arg0, f29_local4, f29_local2)
	end
	local f29_local9 = Engine[@"getmodelforcontroller"](f29_arg0)
	f29_local9 = f29_local9:create("LootStreamProgress", true)
	if f29_local9 then
		local f29_local10 = f29_local9.itemsEarned
		if f29_local10 then
			local f29_local14 = f29_local10:get()
			if f29_local14 then
				f29_local0 = f29_local0 + f29_local14
			end
		end
		local f29_local14 = f29_local9:create("itemsEarned", true)
		f29_local14:set(f29_local0)
	end
end
Lobby.BlackMarket.ParseDropDetail = function(f30_arg0, f30_arg1)
	local f30_local0 = f30_arg1:getAllKeys()
	for f30_local1 = 1, #f30_local0, 1 do
		if f30_local0[f30_local1] == "stream_index" then
			if Lobby.BlackMarket.IsRNGStream(f30_arg1:getString("stream_id")) then
				Lobby.BlackMarket.ParseRNGDropDetail(f30_arg0, f30_arg1)
			else
				Lobby.BlackMarket.ParseStreamDropDetail(f30_arg0, f30_arg1)
			end
			return
		end
	end
end
Lobby.BlackMarket.ParseStreamTrackingInfo = function(f31_arg0, f31_arg1)
	local f31_local0 = false
	local f31_local1 = f31_arg1:getFieldByKey("batched_tracking_info")
	if f31_local1 ~= nil then
		local f31_local2 = f31_local1:getFieldSize()
		for f31_local3 = 1, f31_local2, 1 do
			local f31_local6 = f31_local1:getFieldByIndex(f31_local3 - 1)
			local f31_local7 = f31_local6:getFieldByKey("drop_info")
			local f31_local8 = f31_local7:getFieldSize()
			for f31_local9 = 1, f31_local8, 1 do
				local f31_local12 = f31_local7:getFieldByIndex(f31_local9 - 1)
				local f31_local13 = f31_local12:getAllKeys()
				for f31_local14 = 1, #f31_local13, 1 do
					if f31_local13[f31_local14] == "stream_id" and Lobby.BlackMarket.IsRNGStream(f31_local12:getString("stream_id")) and not f31_local0 then
						f31_local0 = true
						CoDShared.Loot.ClearRNGModels(f31_arg0)
					end
				end
				Lobby.BlackMarket.ParseDropDetail(f31_arg0, f31_local12)
			end
		end
	end
	if f31_local0 then
		Lobby.BlackMarket.FinalizeRNGResultModel(f31_arg0)
	end
end
Lobby.BlackMarket.ParseCrateDropDetail = function(f32_arg0, f32_arg1)
	if f32_arg1:getString("roll_type") ~= "deterministic" then
		Lobby.BlackMarket.ParseRNGDropDetail(f32_arg0, f32_arg1)
		return
	else
	end
end
Lobby.BlackMarket.ParseCrateTrackingInfo = function(f33_arg0, f33_arg1)
	CoDShared.Loot.ClearRNGModels(f33_arg0)
	local f33_local0 = Engine[@"getmodelforcontroller"](f33_arg0)
	f33_local0 = f33_local0:create("LootRNGResult")
	local f33_local1 = f33_arg1:getFieldByKey("batched_tracking_info")
	if f33_local1 ~= nil then
		local f33_local2 = f33_local1:getFieldSize()
		for f33_local3 = 1, f33_local2, 1 do
			local f33_local6 = f33_local1:getFieldByIndex(f33_local3 - 1)
			local f33_local7 = f33_local6:getFieldByKey("drop_info")
			local f33_local8 = f33_local7:getFieldSize()
			for f33_local9 = 1, f33_local8, 1 do
				Lobby.BlackMarket.ParseCrateDropDetail(f33_arg0, f33_local7:getFieldByIndex(f33_local9 - 1))
			end
			local f33_local9 = f33_local6:getFieldByKey("error_codes")
			local f33_local10 = f33_local9:getFieldSize()
			local f33_local11 = true
			for f33_local12 = 1, f33_local10, 1 do
				local f33_local15 = f33_local9:getStringByIndex(f33_local12 - 1)
				local f33_local16 = f33_local0:create("error_code")
				f33_local16:set(f33_local15)
				if f33_local15 == "105" then
					f33_local16 = f33_local0:create("allBribeItemsOwned")
					f33_local16:set(true)
				end
				if f33_local15 == "103" or f33_local15 == "104" or f33_local15 == "201" then
					f33_local11 = false
				end
			end
			if f33_local11 then
				f33_local12 = f33_local0:create("successfulExchange")
				f33_local12:set(true)
			else
				local f33_local12 = f33_local0:create("successfulExchange")
				f33_local12:set(false)
			end
		end
	end
	Lobby.BlackMarket.FinalizeRNGResultModel(f33_arg0)
end
Lobby.BlackMarket.lootTableName = "gamedata/loot/zmlootitems.csv"
Lobby.BlackMarket.ZombiesHandleLootDropResponse = function(f34_arg0, f34_arg1)
	local f34_local0 = f34_arg1:getFieldByKey("Tracking_Info_Batch")
	if f34_local0 == nil then
		docHandle:endParse()
		return
	end
	local f34_local1 = f34_local0:getFieldByKey("batched_tracking_info")
	if f34_local1 == nil then
		docHandle:endParse()
		return
	end
	local f34_local2 = f34_local1:getFieldByIndex(0)
	if not f34_local2 then
		docHandle:endParse()
		return
	end
	f34_local2 = f34_local2:getFieldByKey("drop_info")
	if not f34_local2 then
		docHandle:endParse()
		return
	end
	local f34_local3 = f34_local2:getFieldSize()
	if not f34_local3 then
		docHandle:endParse()
		return
	end
	local f34_local4 = {}
	local f34_local5 = {
		result = @"hash_0",
		quantity = 0,
	}
	for f34_local6 = 1, f34_local3, 1 do
		local f34_local9 = f34_local2:getFieldByIndex(f34_local6 - 1)
		if f34_local9 then
			local f34_local10 = f34_local9:getFieldByKey("item_count")
			if not f34_local10 then
				docHandle:endParse()
				return
			end
			local f34_local11 = f34_local10:getAllKeys()
			if not f34_local11 then
				docHandle:endParse()
				return
			end
			local f34_local12 = f34_local11[1]
			local f34_local13 = Engine[@"tablelookup"](Lobby.BlackMarket.lootTableName, 1, 0, f34_local12)
			local f34_local14 = Engine[@"tablelookup"](Lobby.BlackMarket.lootTableName, 2, 0, f34_local12)
			local f34_local15 = f34_local10:getFieldByKey(f34_local11[1])
			f34_local15 = f34_local15:getInt()
			if f34_local14 == @"talisman" then
				f34_local5.result = f34_local13
				f34_local5.quantity = f34_local15
			else
				table.insert(f34_local4, {
					result = f34_local13,
					quantity = f34_local15,
				})
			end
			Engine[@"hash_18C8B4F26575DBEE"](f34_arg0, tonumber(f34_local12), f34_local15)
		end
	end
	while #f34_local4 < 3 do
		table.insert(f34_local4, {
			result = @"hash_0",
			quantity = 0,
		})
	end
	while #f34_local4 > 3 do
		table.remove(f34_local4)
	end
	table.insert(f34_local4, f34_local5)
	local f34_local6 = Lobby.BlackMarket.GetLabModel(f34_arg0)
	f34_local6 = f34_local6.results
	if f34_local6 then
		for f34_local7 = 1, #f34_local4, 1 do
			local f34_local10 = f34_local6[f34_local7]
			f34_local10.result:set(f34_local4[f34_local7].result)
			f34_local10.quantity:set(f34_local4[f34_local7].quantity)
		end
	end
	local f34_local7 = f34_arg1:getFieldByKey("Balance_Updates")
	if f34_local7 == nil then
		docHandle:endParse()
		return
	end
	local f34_local8 = f34_local7:getAllKeys()
	if not f34_local8 then
		docHandle:endParse()
		return
	end
	local f34_local16 = function(f35_arg0, f35_arg1, f35_arg2)
		Engine[@"hash_961B1DCBEECD208"](f35_arg0, f35_arg1, Engine[@"hash_4E2D8DD79754640C"](f35_arg0, f35_arg1) + f35_arg2)
	end
	for f34_local12, f34_local13 in pairs(f34_local8) do
		local f34_local14 = f34_local7:getFieldByKey(f34_local13)
		if not f34_local14 then
			docHandle:endParse()
			return
		end
		f34_local16(f34_arg0, f34_local13, f34_local14:getInt())
	end
	if f34_local6 then
		f34_local6.ready:set(true)
	end
end
Lobby.BlackMarket.GetLabModel = function(f36_arg0)
	local f36_local0 = Engine[@"getmodelforcontroller"](f36_arg0)
	return f36_local0:create("Laboratory")
end
