CoD.JobFeedUtility = {}
CoD.JobFeedUtility.Lifetime = 5000
CoD.JobFeedUtility.MultiKillActiveTime = 4000
CoD.JobFeedUtility.TypeName = "jobFeed"
CoD.JobFeedUtility.SetupJobFeed = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
	CoD.FeedUtility.FeedTypes[CoD.JobFeedUtility.TypeName] = CoD.JobFeedUtility.FeedTable
	CoD.FeedUtility.SetupFeed(f1_arg0, f1_arg1, CoD.JobFeedUtility.TypeName, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7)
end
CoD.JobFeedUtility.CheckForJobFeedEvent = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	CoD.FeedUtility.CheckForFeedEvent(f2_arg0, f2_arg1, CoD.JobFeedUtility.TypeName, f2_arg2, f2_arg3)
end
CoD.JobFeedUtility.CreateJobFeedItem = function(f3_arg0, f3_arg1, f3_arg2, f3_arg3)
	local f3_local0 = f3_arg0:create("medal" .. f3_arg3)
	f3_local0:create("medalAsset")
	f3_local0:create("multiUseCount")
	f3_local0:create("isActiveMultiKill")
	local f3_local1 = CoD.JobFeedItem.new(f3_arg1, f3_arg2, 0, 0, 0, CoD.JobFeedItem.__defaultWidth, 0, 0, 0, CoD.JobFeedItem.__defaultHeight)
	f3_local1:setModel(f3_local0, f3_arg2)
	f3_local1:registerEventHandler("multikill_inactive", function(element)
		element._parentFeed._activeMultiKillItem = nil
		local f4_local0 = element:getModel()
		f4_local0.isActiveMultiKill:set(false)
		element._expireTimer = LUI.UITimer.new(CoD.JobFeedUtility.Lifetime, "item_expired", true, element)
		element:addElement(element._expireTimer)
		element._preExpiring = true
	end)
	return f3_local1
end
CoD.JobFeedUtility.OnJobFeedItemInserted = function(f5_arg0, f5_arg1)
	f5_arg0._scriptRef = f5_arg1[1]
	f5_arg0._altBase = f5_arg1.altBase
	f5_arg0._endedBy = f5_arg1.endedBy
	local f5_local0 = f5_arg1[2]
	local f5_local1 = f5_arg1.multiUse
	local f5_local2 = f5_arg1.multiKill
	local f5_local3 = f5_arg0:getModel()
	f5_local3.medalAsset:set(Engine[0x2DCF0973239E909](CoD.scoreInfoTable, Enum[0xD4C3CD6D885D4E5][0xB237CBC52108354], Enum[0xD4C3CD6D885D4E5][0x6F5F59B9644339], f5_arg0._scriptRef) or 0x0)
	if not f5_arg0._parentFeed._numActiveCoins then
		f5_arg0._parentFeed:playClip("ActivateFeed")
		f5_arg0._parentFeed._numActiveCoins = 0
	end
	f5_arg0._parentFeed._numActiveCoins = f5_arg0._parentFeed._numActiveCoins + 1
	if f5_local1 then
		f5_local3.multiUseCount:set(1)
	else
		f5_local3.multiUseCount:set(0)
	end
	if f5_local2 then
		f5_arg0._parentFeed._activeMultiKillItem = f5_arg0
		f5_arg0._mkTimer = LUI.UITimer.new(CoD.JobFeedUtility.MultiKillActiveTime, "multikill_inactive", true, f5_arg0)
		f5_arg0:addElement(f5_arg0._mkTimer)
		f5_local3.isActiveMultiKill:set(true)
	else
		f5_local3.isActiveMultiKill:set(false)
	end
	Engine[0xC4146BA76D0F982]("uin_jobfeed_core", f5_local0)
end
CoD.JobFeedUtility.OnJobFeedItemFreed = function(f6_arg0)
	if f6_arg0._parentFeed._numActiveCoins then
		f6_arg0._parentFeed._numActiveCoins = f6_arg0._parentFeed._numActiveCoins - 1
		if f6_arg0._parentFeed._numActiveCoins <= 0 then
			f6_arg0._parentFeed._numActiveCoins = nil
			f6_arg0._parentFeed:playClip("DeactivateFeed")
		end
	end
end
CoD.JobFeedUtility.OnJobFeedItemForceFreed = function(f7_arg0)
	f7_arg0:playClip("Expired")
end
CoD.JobFeedUtility.JobFeedIncrementBaseMedalGroup = function(f8_arg0, f8_arg1)
	if not f8_arg0._baseMedalGroups[f8_arg1] then
		f8_arg0._baseMedalGroups[f8_arg1] = 1
	elseif f8_arg0._baseMedalGroups[f8_arg1] < f8_arg0.feedSize then
		f8_arg0._baseMedalGroups[f8_arg1] = f8_arg0._baseMedalGroups[f8_arg1] + 1
	end
end
CoD.JobFeedUtility.JobFeedDecrementBaseMedalGroup = function(f9_arg0, f9_arg1)
	if f9_arg0._baseMedalGroups[f9_arg1] and f9_arg0._baseMedalGroups[f9_arg1] > 0 then
		f9_arg0._baseMedalGroups[f9_arg1] = f9_arg0._baseMedalGroups[f9_arg1] - 1
	end
end
CoD.JobFeedUtility.DecrementNonUniqueMultiUseActives = function(f10_arg0, f10_arg1)
	if f10_arg0._numMUCoinsToUpdate and f10_arg0._numMUCoinsToUpdate[f10_arg1] then
		f10_arg0._numMUCoinsToUpdate[f10_arg1] = f10_arg0._numMUCoinsToUpdate[f10_arg1] - 1
		if f10_arg0._numMUCoinsToUpdate[f10_arg1] == 0 then
			f10_arg0._numMUCoinsToUpdate[f10_arg1] = nil
		end
	end
end
CoD.JobFeedUtility.GetJobType = function(f11_arg0)
	return Engine[0x5DC2BA4A99CE43E](CoD.scoreInfoTable, f11_arg0, Enum[0xD4C3CD6D885D4E5][0x6DD2AD27B53BEB])
end
CoD.JobFeedUtility.OnJobFeedFeedItemOverflowAtEnd = function(f12_arg0)
	local f12_local0 = f12_arg0.feedItems[f12_arg0.currentIndex]
	local f12_local1 = 0
	if f12_arg0._activeMultiKillItem then
		f12_local1 = 1
		while f12_local0.position ~= f12_local1 do
			f12_arg0.currentIndex = (f12_arg0.currentIndex + 1) % f12_arg0.feedSize
			f12_local0 = f12_arg0.feedItems[f12_arg0.currentIndex]
		end
		CoD.JobFeedUtility.JobFeedDecrementBaseMedalGroup(f12_arg0, f12_local0.widget._scriptRef)
		CoD.FeedUtility.ItemExpired(f12_local0.widget, true)
	end
end
CoD.JobFeedUtility.JobFeedEventReceived = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3)
	local f13_local0 = f13_arg2[1]
	if f13_local0 then
		local f13_local1 = CoD.JobFeedUtility.GetJobType(f13_local0)
		if not f13_arg0.managedFeeds then
			return
		end
		local f13_local2 = f13_arg0.managedFeeds[f13_local1]
		if f13_local2 then
			if not f13_local2.addFeedItem or not f13_local2.feedSize then
				return
			elseif not f13_local2._baseMedalGroups then
				f13_local2._baseMedalGroups = {}
			end
			local f13_local3 = Engine[0x5DC2BA4A99CE43E](CoD.scoreInfoTable, f13_local0, Enum[0xD4C3CD6D885D4E5][0x6F5F59B9644339])
			if f13_arg1 == "challenge_coin_received" then
				local f13_local4 = Engine[0x5DC2BA4A99CE43E](CoD.scoreInfoTable, f13_local0, Enum[0xD4C3CD6D885D4E5][0xC4972E817CC8B90])
				local f13_local5 = Engine[0x5DC2BA4A99CE43E](CoD.scoreInfoTable, f13_local0, Enum[0xD4C3CD6D885D4E5][0xFE69ECFC89EDE2A])
				local f13_local6 = Engine[0x5DC2BA4A99CE43E](CoD.scoreInfoTable, f13_local0, Enum[0xD4C3CD6D885D4E5][0xB237CBC52108354])
				local f13_local7 = Engine[0x5DC2BA4A99CE43E](CoD.scoreInfoTable, f13_local0, Enum[0xD4C3CD6D885D4E5][0x2B88D3D2E541010])
				DebugPrint("Adding medal " .. tostring(f13_local6) .. " to feed " .. tostring(f13_local2))
				local f13_local8 = {
					f13_local3,
					f13_arg3,
					endedBy = f13_local7,
				}
				if f13_local4 == 0xA7CE19BAA54C278 or f13_local4 == 0xF312C483C3CB8A9 then
					CoD.JobFeedUtility.JobFeedIncrementBaseMedalGroup(f13_local2, f13_local3)
					if f13_local4 == 0xF312C483C3CB8A9 then
						f13_local8.altBase = true
					end
					f13_local2:addFeedItem(f13_local8, 0)
				elseif f13_local4 == 0xF9582D72160F199 then
					if f13_local5 ~= 0x0 then
						CoD.JobFeedUtility.CashInJob(f13_local2, f13_local5, {
							medalAssetName = f13_local6,
						})
					else
						f13_local2:addFeedItem(f13_local8, 0)
					end
				elseif f13_local4 == 0x54A663DF6E5DEB5 then
					if f13_local5 ~= 0x0 then
						CoD.JobFeedUtility.CashInJob(f13_local2, f13_local5, {
							medalAssetName = f13_local6,
							comboCashIn = true,
						})
					end
				elseif f13_local4 == 0xC856D95DB14B8C6 then
					if not f13_local2._activeMultiKillItem then
						f13_local8.multiKill = true
						CoD.FeedUtility.AddFeedItemToBeginning(f13_local2, f13_local8, 0)
					else
						CoD.JobFeedUtility.AddMultiEventToQueue(f13_local2._activeMultiKillItem, {
							medalAssetName = f13_local6,
						}, CoD.JobFeedUtility.IncrementMultiKill)
					end
				elseif f13_local4 == 0x5E13205E2BDEAE5 then
					local f13_local9 = CoD.JobFeedUtility.FindFirstItemOfType(f13_local2, f13_local3)
					if f13_local9 then
						CoD.JobFeedUtility.AddMultiEventToQueue(f13_local9, nil, CoD.JobFeedUtility.IncrementMultiUse)
					else
						f13_local8.multiUse = true
						f13_local2:addFeedItem(f13_local8, 0)
					end
				elseif f13_local4 == 0x263112AE7BABF2F then
					CoD.JobFeedUtility.HandleNonUniqueMultiUse(f13_local2, f13_local8, f13_arg2)
				elseif f13_local4 == 0x9FA22DABA3D7494 then
					f13_local2:addFeedItem(f13_local8, CoD.JobFeedUtility.Lifetime)
				end
			elseif f13_arg1 == "end_sustaining_action" then
				CoD.JobFeedUtility.JobFeedEndItemsNaturalExpired(f13_local2, f13_local3)
			end
		end
	end
end
CoD.JobFeedUtility.FindFirstItemOfType = function(f14_arg0, f14_arg1)
	return table.remove(CoD.JobFeedUtility.FindFirstMultipleItemsType(f14_arg0, f14_arg1, 1))
end
CoD.JobFeedUtility.FindFirstMultipleItemsType = function(f15_arg0, f15_arg1, f15_arg2)
	local f15_local0 = {}
	for f15_local1 = 0, f15_arg0.feedSize - 1, 1 do
		local f15_local4 = f15_arg0.feedItems[f15_local1]
		if f15_local4.active == true and not f15_local4.widget._cashedIn and f15_local4.widget._scriptRef == f15_arg1 then
			f15_local0[f15_local4.position + 1] = f15_local4.widget
		end
	end
	local f15_local1 = {}
	local f15_local2 = 0
	for f15_local6, f15_local7 in pairs(f15_local0) do
		if f15_local2 < f15_arg2 then
			table.insert(f15_local1, f15_local7)
			f15_local2 = f15_local2 + 1
		end
	end
	return f15_local1
end
CoD.JobFeedUtility.HandleNonUniqueMultiUse = function(f16_arg0, f16_arg1, f16_arg2)
	local f16_local0 = f16_arg2[2] or 1
	local f16_local1 = f16_arg1[1]
	f16_arg1.multiUse = true
	if not f16_arg0._numMUCoinsToUpdate then
		f16_arg0._numMUCoinsToUpdate = {}
	end
	if not f16_arg0._numMUCoinsToUpdate[f16_local1] then
		f16_arg0._numMUCoinsToUpdate[f16_local1] = f16_local0
		for f16_local2 = 1, f16_local0, 1 do
			local f16_local5 = f16_local2
			f16_arg0:addFeedItem(f16_arg1, 0)
		end
	else
		if f16_arg0._numMUCoinsToUpdate[f16_local1] < f16_local0 then
			for f16_local2 = f16_arg0._numMUCoinsToUpdate[f16_local1], f16_local0 - 1, 1 do
				local f16_local5 = f16_local2
				f16_arg0:addFeedItem(f16_arg1, 0)
			end
			f16_arg0._numMUCoinsToUpdate[f16_local1] = f16_local0
		end
		local f16_local2 = CoD.JobFeedUtility.FindFirstMultipleItemsType(f16_arg0, f16_local1, f16_local0)
		if f16_local2 then
			for f16_local6, f16_local7 in pairs(f16_local2) do
				CoD.JobFeedUtility.AddMultiEventToQueue(f16_local7, nil, CoD.JobFeedUtility.IncrementMultiUse)
			end
		end
	end
end
CoD.JobFeedUtility.CashInJob = function(f17_arg0, f17_arg1, f17_arg2)
	if not f17_arg0.feedSize then
		return
	end
	local f17_local0 = CoD.JobFeedUtility.FindFirstItemOfType(f17_arg0, f17_arg1)
	if f17_local0 then
		f17_local0._cashingInMedalData = f17_arg2
		f17_local0._cashedIn = true
		f17_local0._incrementingMultiUse = nil
	end
end
CoD.JobFeedUtility.UpdateItemToCashedIn = function(f18_arg0)
	local f18_local0 = f18_arg0:getModel()
	f18_local0.medalAsset:set(f18_arg0._cashingInMedalData.medalAssetName)
	f18_local0.multiUseCount:set(0)
	CoD.JobFeedUtility.JobFeedDecrementBaseMedalGroup(f18_arg0._parentFeed, f18_arg0._scriptRef)
	CoD.JobFeedUtility.JobFeedEndItemsCashedIn(f18_arg0._parentFeed, f18_arg0._scriptRef)
end
CoD.JobFeedUtility.UpdateMultiKillItem = function(f19_arg0)
	local f19_local0 = f19_arg0:getModel()
	f19_local0.medalAsset:set(f19_arg0._incrementingMultiKillData.medalAssetName)
end
CoD.JobFeedUtility.AddMultiEventToQueue = function(f20_arg0, f20_arg1, f20_arg2)
	if not f20_arg1 then
		f20_arg1 = {}
	end
	f20_arg1.clipBased = true
	CoD.QueueUtility.AddToTimedFnQueue(f20_arg0, CoD.QueueUtility.TimedFnQueuePriority.EqualPriority, f20_arg2, f20_arg1)
end
CoD.JobFeedUtility.IncrementMultiUse = function(f21_arg0, f21_arg1, f21_arg2)
	f21_arg0._incrementingMultiUse = true
end
CoD.JobFeedUtility.IncrementMultiKill = function(f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = f22_arg0
	f22_local0._incrementingMultiKillData = f22_arg2
	f22_local0._mkTimer:reset()
end
CoD.JobFeedUtility.JobFeedEndItemsCashedIn = function(f23_arg0, f23_arg1)
	local f23_local0 = f23_arg0._baseMedalGroups[f23_arg1]
	if f23_local0 and f23_local0 == 0 then
		CoD.JobFeedUtility.JobFeedEndItemsByField(f23_arg0, "_scriptRef", f23_arg1)
	end
end
CoD.JobFeedUtility.JobFeedEndItemsNaturalExpired = function(f24_arg0, f24_arg1)
	if not f24_arg0.feedSize then
		return
	else
		CoD.JobFeedUtility.JobFeedEndItemsByField(f24_arg0, "_endedBy", f24_arg1)
	end
end
CoD.JobFeedUtility.JobFeedEndItemsByField = function(f25_arg0, f25_arg1, f25_arg2)
	local f25_local0 = 0
	for f25_local4, f25_local5 in pairs(f25_arg0.feedItems) do
		if f25_local5.active and f25_local5.widget[f25_arg1] == f25_arg2 and not f25_local5.widget._preExpiring then
			f25_local0 = f25_local0 + 1
		end
	end
	for f25_local4, f25_local5 in pairs(f25_arg0.feedItems) do
		if f25_local5.active and f25_local5.widget[f25_arg1] == f25_arg2 and not f25_local5.widget._preExpiring then
			f25_local5.widget._expireTimer = LUI.UITimer.new(CoD.JobFeedUtility.Lifetime, "item_expired", true, f25_local5.widget)
			f25_local5.widget:addElement(f25_local5.widget._expireTimer)
			f25_local5.widget._preExpiring = true
			CoD.JobFeedUtility.JobFeedDecrementBaseMedalGroup(f25_arg0, f25_local5.widget._scriptRef)
			CoD.JobFeedUtility.DecrementNonUniqueMultiUseActives(f25_arg0, f25_local5.widget._scriptRef)
		end
	end
end
CoD.JobFeedUtility.JobFeedSizes = {
	hotstreak = 8,
}
CoD.JobFeedUtility.FeedTable = {
	sizes = CoD.JobFeedUtility.JobFeedSizes,
	createFeedItem = CoD.JobFeedUtility.CreateJobFeedItem,
	eventReceived = CoD.JobFeedUtility.JobFeedEventReceived,
	onFeedItemInserted = CoD.JobFeedUtility.OnJobFeedItemInserted,
	onFeedItemFreed = CoD.JobFeedUtility.OnJobFeedItemFreed,
	onFeedItemForceFreed = CoD.JobFeedUtility.OnJobFeedItemForceFreed,
	onFeedOverflowAtEnd = CoD.JobFeedUtility.OnJobFeedFeedItemOverflowAtEnd,
}
CoD.JobFeedUtility.InitNormalItem = function(f26_arg0)
	f26_arg0:registerEventHandler("clip_over", function(element, event)
		if element._flipStarted then
			element._cashedIn = nil
			if element._cashingInMedalData then
				CoD.JobFeedUtility.UpdateItemToCashedIn(element)
				element._cashingInMedalData = nil
				element._cashedIn = true
			elseif element._incrementingMultiKillData then
				CoD.JobFeedUtility.UpdateMultiKillItem(element)
				element._incrementingMultiKillData = nil
			elseif element._incrementingMultiUse then
				local f27_local0 = element:getModel()
				f27_local0 = f27_local0.multiUseCount:get()
				local f27_local1 = element:getModel()
				f27_local1.multiUseCount:set(f27_local0 + 1)
				element._incrementingMultiUse = nil
			end
			if element.timedFnQueue then
				CoD.QueueUtility.PumpTimedFnQueue(element)
				LUI.UIElement.clipOver(element, event)
			end
			element.nextClip = "Coin_EndFlip"
			element._flipStarted = nil
		elseif element._cashingInMedalData or element._incrementingMultiKillData or element._incrementingMultiUse then
			element.nextClip = "Coin_StartFlip"
			element._flipStarted = true
		elseif element._preExpiring then
			element.nextClip = "PreExpireLoop"
		elseif not element._expired then
			if element._shouldSustain == true then
				if element._cashedIn then
					element.nextClip = "CashedSustainedLoop"
				elseif element._altBase then
					element.nextClip = "AltSustainedLoop"
				else
					element.nextClip = "SustainedLoop"
				end
			else
				element.nextClip = "StandardLoop"
			end
		else
			CoD.FeedUtility.ItemFreed(element)
		end
		LUI.UIElement.clipOver(element, event)
	end)
end
CoD.JobFeedUtility.CalcMultiUseWipe = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
	return f28_arg0 / 10, f28_arg1, 0.05, f28_arg3
end
