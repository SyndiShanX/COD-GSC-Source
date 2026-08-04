CoD.ZMLaboratoryUtility = {}
require("ui/utility/overlayutility")
CoD.ZMLaboratoryUtility.LabAnimState = {
	NOT_PLAYING = 0,
	NOT_PLAYING_TO_PLAYING = 1,
	PLAYING = 2,
	PLAYING_TO_MIX_AGAIN = 3,
	MIX_AGAIN = 4,
	MIX_AGAIN_TO_PLAYING = 5,
	MIX_AGAIN_TO_NOT_PLAYING = 6,
}
CoD.ZMLaboratoryUtility.RarityColorSets = {
	[0] = ColorSet.BlackMarketCommon,
	[1] = ColorSet.BlackMarketRare,
	[2] = ColorSet.BlackMarketLegendary,
	[3] = ColorSet.BlackMarketEpic,
	[4] = ColorSet.RewardCamo,
}
CoD.ZMLaboratoryUtility.RarityStrings = {
	[0] = @"hash_1E73A287484FA8DE",
	[1] = @"hash_1D14011B788D0CF7",
	[2] = @"hash_499BE3404C6F5504",
	[3] = @"hash_7CC5E57AF2A3CF36",
	[4] = @"hash_36928619D00F39CF",
}
CoD.ZMLaboratoryUtility.MaxSpecialOffers = 3
CoD.ZMLaboratoryUtility.DefaultConcoctions = {
	{
		assetName = "zm_lab_carbon_combo",
	},
	{
		assetName = "zm_lab_argon_array",
	},
	{
		assetName = "zm_lab_palladium_package",
	},
}
CoD.ZMLaboratoryUtility.MaxResults = 4
CoD.ZMLaboratoryUtility.ResultModels = {
	{
		modelName = "result",
		default = 0x0,
	},
	{
		modelName = "quantity",
		default = 0,
	},
}
CoD.ZMLaboratoryUtility.ResetResults = function(f1_arg0)
	for f1_local0 = 1, CoD.ZMLaboratoryUtility.MaxResults, 1 do
		local f1_local3 = f1_arg0:create(f1_local0 .. "")
		for f1_local7, f1_local8 in ipairs(CoD.ZMLaboratoryUtility.ResultModels) do
			local f1_local9 = f1_local3:create(f1_local8.modelName)
			f1_local9:set(f1_local8.default)
		end
	end
	local f1_local0 = f1_arg0:create("ready")
	f1_local0:set(false)
end
CoD.ZMLaboratoryUtility.GetResults = function(f2_arg0)
	local f2_local0 = {}
	for f2_local1 = 1, CoD.ZMLaboratoryUtility.MaxResults, 1 do
		local f2_local4 = f2_arg0:create(f2_local1 .. "")
		local f2_local5 = {}
		for f2_local9, f2_local10 in ipairs(CoD.ZMLaboratoryUtility.ResultModels) do
			local f2_local11 = f2_local10.modelName
			local f2_local12 = f2_local4:create(f2_local10.modelName)
			f2_local5[f2_local11] = f2_local12:get() or f2_local10.default
		end
		f2_local0[f2_local1] = f2_local5
	end
	return f2_local0
end
CoD.ZMLaboratoryUtility.GetLabModel = function(f3_arg0)
	local f3_local0 = Engine.GetModelForController(f3_arg0)
	return f3_local0:create("Laboratory")
end
CoD.ZMLaboratoryUtility.DoLootQueryAndSendClientScriptNotify = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	local f4_local0 = function()
		Engine.SendClientScriptNotify(f4_arg2, "np_item_play_anim")
		CoD.ZMLaboratoryUtility.AttemptLootQuery(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
	end
	if CoD.isPC then
		CoD.PCUtility.DisplayPrePurchasePopup(f4_local0, f4_arg4, f4_arg2, {
			labElement = f4_arg1,
		})
	else
		f4_local0()
	end
end
CoD.ZMLaboratoryUtility.IsInAnimState = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3)
	local f6_local0 = CoD.ZMLaboratoryUtility.GetLabModel(f6_arg0)
	f6_local0 = f6_local0.animState:get()
	local f6_local1
	if (not f6_arg1 or f6_local0 ~= f6_arg1) and (not f6_arg2 or f6_local0 ~= f6_arg2) then
		local f6_local2 = f6_arg3
		if f6_local0 ~= f6_arg3 then
			f6_local1 = false
		end
	end
	f6_local1 = f6_local2 and true
end
CoD.ZMLaboratoryUtility.GetLaboratoryBannerOffer = function()
	return Dvar[@"hash_1522D365E2D9088E"]:exists() and Engine[@"converttoxhash"](Dvar[@"hash_1522D365E2D9088E"]:get())
end
CoD.ZMLaboratoryUtility.GetLaboratorySpecialOffer = function(f8_arg0)
	local f8_local0 = Engine[@"getdvarstring"]("laboratory_special_offer_" .. f8_arg0)
	return f8_local0 and Engine[@"converttoxhash"](f8_local0)
end
CoD.ZMLaboratoryUtility.IsOfferAvailable = function(f9_arg0)
	if not f9_arg0 or f9_arg0 == "" or f9_arg0 == 0x0 then
		return false
	end
	for f9_local0 = 1, CoD.ZMLaboratoryUtility.MaxSpecialOffers, 1 do
		if Engine[@"converttoxhash"](Engine[@"getdvarstring"]("laboratory_special_offer_" .. f9_local0)) == f9_arg0 then
			return true
		end
	end
	return false
end
CoD.ZMLaboratoryUtility.IsInAnimState1 = function(f10_arg0, f10_arg1)
	return CoD.ZMLaboratoryUtility.IsInAnimState(f10_arg0, f10_arg1)
end
CoD.ZMLaboratoryUtility.IsInAnimState2 = function(f11_arg0, f11_arg1, f11_arg2)
	return CoD.ZMLaboratoryUtility.IsInAnimState(f11_arg0, f11_arg1, f11_arg2)
end
CoD.ZMLaboratoryUtility.IsInAnimState3 = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
	return CoD.ZMLaboratoryUtility.IsInAnimState(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
end
CoD.ZMLaboratoryUtility.CanPurchase = function(f13_arg0, f13_arg1)
	local f13_local0 = CoD.SafeGetModelValue(f13_arg1:getModel(), "plasmaPrice")
	if (not Dvar[@"hash_3659A867DE4952AA"]:exists() or tonumber(Dvar[@"hash_3659A867DE4952AA"]:get()) == 0) and f13_local0 and f13_local0 > 0 then
		return f13_local0 <= Engine[@"hash_2F40679B550DCCA2"](f13_arg0, CoD.Currencies.ZM_NEBULIUM_PLASMA)
	else
		return true
	end
end
CoD.ZMLaboratoryUtility.CanPurchaseMore = function(f14_arg0, f14_arg1)
	local f14_local0 = f14_arg1:getModel()
	local f14_local1 = f14_local0.maxQuantity
	if f14_local1 then
		f14_local1 = f14_local0.maxQuantity:get()
	end
	local f14_local2 = f14_local0.skuID
	if f14_local2 then
		f14_local2 = f14_local0.skuID:get()
	end
	if f14_local1 and f14_local1 > 0 and f14_local2 then
		if f14_local1 <= Engine[@"hash_5352DC095BBB2A45"](f14_arg0, tostring(f14_local2)) then
			return false
		else
			return true
		end
	else
		return true
	end
end
CoD.ZMLaboratoryUtility.HasOfferExpired = function(f15_arg0)
	local f15_local0 = f15_arg0 and f15_arg0:getModel()
	local f15_local1 = f15_local0 and f15_local0.offerAssetName
	local f15_local2 = f15_local1 and f15_local1:get()
	if not f15_local2 or f15_local2 == "" then
		return true
	else
		return not CoD.ZMLaboratoryUtility.IsOfferAvailable(f15_local2)
	end
end
CoD.ZMLaboratoryUtility.ClientScriptNotifyFocusChanged = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
	if f16_arg1.focusChangedNotifyParams then
		Engine.SendClientScriptNotify(f16_arg2, "np_item_focus_changed", f16_arg1.focusChangedNotifyParams)
	end
end
CoD.ZMLaboratoryUtility.AttemptLootQuery = function(f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4)
	local f17_local0 = CoD.ZMLaboratoryUtility.GetLabModel(f17_arg2)
	f17_local0.disableInput:set(1)
	if f17_arg1:getModel() then
		f17_local0 = f17_arg1:getModel()
		if f17_local0.dropType ~= nil then
			f17_local0 = f17_arg1:getModel()
			if f17_local0.dropType:get() == 0 then
				return
			elseif f17_arg4._animStateDisableInputSubscription then
				f17_arg4:removeSubscription(f17_arg4._animStateDisableInputSubscription)
				f17_arg4._animStateDisableInputSubscription = nil
			end
			if not f17_arg4._animStateDisableInputSubscription then
				local f17_local1 = f17_arg4
				f17_local0 = f17_arg4.subscribeToModel
				local f17_local2 = CoD.ZMLaboratoryUtility.GetLabModel(f17_arg2)
				f17_arg4._animStateDisableInputSubscription = f17_local0(f17_local1, f17_local2.animState, function(f18_arg0)
					if f18_arg0:get() == CoD.ZMLaboratoryUtility.LabAnimState.PLAYING then
						CoD.ZMLaboratoryUtility.DoLootQuery(f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4)
						if f17_arg4._animStateDisableInputSubscription then
							f17_arg4:removeSubscription(f17_arg4._animStateDisableInputSubscription)
							f17_arg4._animStateDisableInputSubscription = nil
						end
					end
				end, false)
			end
			if CoD.isPC then
				CoD.PCUtility.LockUIShortcutInput(f17_arg4, f17_arg2)
			end
			f17_arg4:addElement(LUI.UITimer.newElementTimer(100, true, function(f19_arg0)
				local f19_local0 = CoD.ZMLaboratoryUtility.GetLabModel(f19_arg0)
				f19_local0.disableInput:set(0)
			end, f17_arg2))
		end
	end
	return
end
CoD.ZMLaboratoryUtility.DoLootQuery = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3, f20_arg4)
	local f20_local0 = CoD.ZMLaboratoryUtility.GetLabModel(f20_arg2)
	f20_local0 = f20_local0.results
	local f20_local1 = Dvar[@"hash_3659A867DE4952AA"]:exists()
	if f20_local1 then
		f20_local1 = tonumber(Dvar[@"hash_3659A867DE4952AA"]:get()) > 0
	end
	CoD.ZMLaboratoryUtility.ResetResults(f20_local0)
	local f20_local2 = f20_arg1:getModel()
	f20_local2 = f20_local2.dropType:get()
	if (not f20_local1 or f20_local1 == false) and Engine[@"getdvarint"]("ui_zm_laboratory_simulate_timeout") ~= 1 then
		local f20_local3 = Dvar[@"hash_4A8CF37DD4FD801B"]:get()
		local f20_local4 = "{}"
		if f20_local3 and f20_local3 ~= nil then
			f20_local4 = string.format('{"zm_drop_versions":[%s] }', f20_local3)
		end
		local f20_local5 = {
			controller = f20_arg2,
			dropType = f20_local2,
			payload = f20_local4,
		}
		Engine[@"lobbyevent"]("OpenZombieLootDrop", f20_local5)
	end
	local f20_local3 = 30
	local f20_local4 = 0
	local f20_local6 = function()
		local f21_local0 = CoD.ZMLaboratoryUtility.GetLabModel(f20_arg2)
		if f21_local0.animState:get() == CoD.ZMLaboratoryUtility.LabAnimState.PLAYING and (f20_local0.ready:get() == true or f20_local1 == true) then
			f20_arg4.LaboratoryBottleLabelList.BottleLabels.showResults = true
			f20_arg4.LaboratoryBottleLabelList.BottleLabels:updateDataSource()
			Engine.SendClientScriptNotify(f20_arg2, "lab_set_rewards")
		elseif f20_local4 < f20_local3 then
			f20_arg4:addElement(LUI.UITimer.newElementTimer(250, true, f20_local5))
			f20_local4 = f20_local4 + 1
		else
		end
	end
	f20_local6()
end
CoD.ZMLaboratoryUtility.AddExperimentalConcoctions = function(f22_arg0)
	if not IsBooleanDvarSet("laboratory_exp_enabled") then
		return nil
	end
	local f22_local0 = {}
	local f22_local1 = {
		"conc1",
		"conc2",
		"conc3",
	}
	local f22_local2 = {
		zm_lab_carbon_combo = true,
		zm_lab_argon_array = true,
		zm_lab_palladium_package = true,
		zm_lab_beryllium_bundle = true,
		zm_lab_selenium_selection = true,
		zm_lab_rhodium_roundup = true,
		zm_lab_titanium_treble = true,
		zm_lab_tungsten_tripler = true,
	}
	for f22_local7, f22_local8 in ipairs(f22_local1) do
		local f22_local6 = CoD.StoreUtility.GetExperimentModifier(f22_arg0, f22_local8)
		if f22_local6 == nil or f22_local6 == "" or f22_local6 == 0 then
			return nil
		end
		f22_local6 = Engine[@"converttoxhash"](f22_local6)
		if not f22_local2[f22_local6] then
			return nil
		end
		table.insert(f22_local0, {
			assetName = f22_local6,
		})
	end
	return f22_local0
end
CoD.ZMLaboratoryUtility.SetupLaboratoryMenu = function(f23_arg0, f23_arg1)
	local f23_local0 = CoD.ZMLaboratoryUtility.GetLabModel(f23_arg0)
	local f23_local1 = f23_local0:create("animState")
	f23_local1:set(0)
	f23_local1 = f23_local0:create("firstBottleFilled")
	f23_local1:set(0)
	f23_local1 = f23_local0:create("shrinkLabelList")
	f23_local1:set(0)
	f23_local1 = f23_local0:create("disableInput")
	f23_local1:set(0)
	f23_local1 = f23_local0:create("skipReady")
	f23_local1:set(false)
	f23_local0:create("unhideFreeCursor")
	f23_local0:create("timedOut")
	CoD.ZMLaboratoryUtility.ResetResults(f23_local0:create("results"))
	f23_arg1:appendEventHandler("clip_over", function()
		if not (f23_arg1.currentState ~= "DefaultState" or (f23_arg1.__lastClipPlayedState ~= "AnimStateMixAgainToNotPlaying" or f23_arg1.__lastClipPlayedName ~= "DefaultClip") and (f23_arg1.__lastClipPlayedState ~= "AnimStatePlaying" or f23_arg1.__lastClipPlayedName ~= "DefaultClip")) or f23_arg1.currentState == "AnimStateMixAgain" and f23_arg1.__lastClipPlayedState == "AnimStateMixAgain" and f23_arg1.__lastClipPlayedName == "DefaultClip" then
			Engine.ForceNotifyModelSubscriptions(f23_local0.unhideFreeCursor)
		end
	end)
	Engine.SendClientScriptNotify(f23_arg0, "init_controller_model", {
		controller = f23_arg0,
	})
end
CoD.ZMLaboratoryUtility.CleanUpLaboratoryMenu = function(f25_arg0)
	local f25_local0 = CoD.ZMLaboratoryUtility.GetLabModel(f25_arg0)
	if f25_local0 then
		Engine.UnsubscribeAndFreeModel(f25_local0)
	end
	local f25_local1 = Engine.GetModelForController(f25_arg0)
	f25_local1 = f25_local1.ZMLaboratoryPlasmaItemList
	if f25_local1 then
		Engine.UnsubscribeAndFreeModel(f25_local1)
	end
end
CoD.ZMLaboratoryUtility.SetListElementModelsWithDelay = function(f26_arg0, f26_arg1, f26_arg2, f26_arg3, f26_arg4, f26_arg5)
	local f26_local0 = f26_arg1:getItemAtPosition(1, 1)
	if f26_local0 then
		local f26_local1 = f26_local0:getModel()
		f26_local1[f26_arg2]:set(f26_arg3)
	end
	if f26_arg5 then
		local f26_local2 = f26_arg5
	end
	local f26_local1 = f26_local2 or f26_arg1:getTotalCount()
	for f26_local3 = 2, f26_local1, 1 do
		local f26_local6 = f26_local3
		f26_arg1:addElement(LUI.UITimer.newElementTimer(f26_arg4 * (f26_local6 - 1), true, function()
			local f27_local0 = f26_arg1:getItemAtPosition(1, f26_local6)
			if f27_local0 then
				local f27_local1 = f27_local0:getModel()
				f27_local1[f26_arg2]:set(f26_arg3)
			end
		end))
	end
end
CoD.ZMLaboratoryUtility.MixAgain = function(f28_arg0, f28_arg1, f28_arg2)
	local f28_local0 = function()
		Engine.SendClientScriptNotify(f28_arg2, "mix_again", {
			controller = f28_arg2,
			param1 = "1",
		})
		CoD.ZMLaboratoryUtility.AttemptLootQuery(f28_arg0, f28_arg0, f28_arg2, "", f28_arg1)
	end
	if CoD.isPC then
		CoD.PCUtility.DisplayPrePurchasePopup(f28_local0, f28_arg1, f28_arg2, {
			labElement = f28_arg1.lastSelectedOfferButton,
		})
	else
		f28_local0()
	end
end
CoD.ZMLaboratoryUtility.CacheOfferButtonModel = function(f30_arg0, f30_arg1, f30_arg2)
	local f30_local0 = CoD.ZMLaboratoryUtility.GetPurchasePlasmaModel(f30_arg0)
	f30_local0.lastSelectedOfferButtonModel:set(f30_arg1:getModel())
	f30_arg2.lastSelectedOfferButton = f30_arg1
	SetElementModelToFocusedElementModel(f30_arg0, f30_arg2, f30_arg1, "MixAgain")
end
CoD.ZMLaboratoryUtility.RestoreFocusToCachedOfferButton = function(f31_arg0, f31_arg1)
	if f31_arg1.lastSelectedOfferButton then
		CoD.FreeCursorUtility.GiveFocusToElementsDefaultFocus(f31_arg1, f31_arg1.lastSelectedOfferButton, f31_arg0)
	end
end
CoD.ZMLaboratoryUtility.CloseTimedOutPopup = function(f32_arg0, f32_arg1, f32_arg2, f32_arg3, f32_arg4)
	Engine.SendClientScriptNotify(f32_arg2, "timed_out_popup_closed", {
		controller = f32_arg2,
	})
	GoBack(f32_arg4, f32_arg2)
end
CoD.ZMLaboratoryUtility.SetupEventCountdown = function(f33_arg0, f33_arg1)
	if f33_arg0:getModel() then
		local f33_local0 = f33_arg0:getModel()
		if not f33_local0.eventTimerModel then
			return
		elseif f33_arg1.labTimerSubscription then
			f33_arg1:removeSubscription(f33_arg1.labTimerSubscription)
		end
		f33_local0 = Engine.GetGlobalModel()
		local f33_local1 = f33_local0
		f33_local0 = f33_local0.create
		local f33_local2 = f33_arg0:getModel()
		f33_arg1.labTimerSubscription = f33_arg1:subscribeToModel(f33_local0(f33_local1, f33_local2.eventTimerModel:get()), function(model)
			if model then
				f33_arg1:setText(LocalizeIntoString(@"hash_67E9AAD95DB4B21E", model:get()))
			end
		end, true)
	end
	return
end
CoD.ZMLaboratoryUtility.UpdateNPPurchaseDesc = function(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = CoD.SafeGetModelValue(f35_arg0, "plasmaPrice")
	if f35_local0 then
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_19A39FF477A7A0F", f35_local0 - Engine[@"hash_2F40679B550DCCA2"](f35_arg1, CoD.Currencies.ZM_NEBULIUM_PLASMA))
	else
		return Engine[@"hash_4F9F1239CFD921FE"](f35_arg2)
	end
end
CoD.ZMLaboratoryUtility.GetColorSetForIndex = function(f36_arg0)
	local f36_local0 = CoD.ZMLaboratoryUtility.RarityColorSets[f36_arg0]
	if not f36_local0 then
		f36_local0 = ColorSet.T8__RED
	end
	return f36_local0.r, f36_local0.g, f36_local0.b
end
CoD.ZMLaboratoryUtility.GetRarityStringForIndex = function(f37_arg0)
	if CoD.ZMLaboratoryUtility.RarityStrings[f37_arg0] then
		return CoD.ZMLaboratoryUtility.RarityStrings[f37_arg0]
	else
		return @"hash_1E73A287484FA8DE"
	end
end
CoD.ZMLaboratoryUtility.GetLaboratoryBannerImage = function(f38_arg0)
	local f38_local0 = CoD.ZMLaboratoryUtility.GetLaboratoryBannerOffer()
	local f38_local1 = f38_local0 and Engine[@"hash_2E00B2F29271C60B"](f38_local0)
	local f38_local2
	if f38_local1 then
		f38_local2 = f38_local1[@"bannerimage"]
		if not f38_local2 then
		else
			return f38_local2
		end
	end
	f38_local2 = 0x0
end
CoD.ZMLaboratoryUtility.GetLaboratoryBannerTitle = function(f39_arg0)
	local f39_local0 = CoD.ZMLaboratoryUtility.GetLaboratoryBannerOffer()
	local f39_local1 = f39_local0 and Engine[@"hash_2E00B2F29271C60B"](f39_local0)
	local f39_local2
	if f39_local1 then
		f39_local2 = f39_local1[@"bannertitle"]
		if not f39_local2 then
		else
			return f39_local2
		end
	end
	f39_local2 = 0x0
end
DataSources.ZMLaboratoryResultsItemList = ListHelper_SetupDataSource("Laboratory.bottles", function(f40_arg0, f40_arg1)
	local f40_local0 = {}
	if not f40_arg1.showResults then
		return f40_local0
	end
	local f40_local1 = {}
	if Dvar[@"hash_3659A867DE4952AA"]:exists() and tonumber(Dvar[@"hash_3659A867DE4952AA"]:get()) > 0 then
		local f40_local2 = {
			"zm_bgb_cache_back",
			"zm_bgb_ctrl_z",
			"zm_bgb_extra_credit",
			"zm_bgb_free_fire",
			"zm_bgb_immolation_liquidation",
			"zm_bgb_kill_joy",
			"zm_bgb_licensed_contractor",
			"zm_bgb_shields_up",
			"zm_bgb_undead_man_walking",
			"zm_bgb_wall_power",
			"zm_bgb_whos_keeping_score",
		}
		local f40_local3 = {
			"talisman_box_guarantee_box_only",
			"talisman_box_guarantee_lmg",
			"talisman_coagulant",
			"talisman_extra_claymore",
			"talisman_extra_frag",
			"talisman_extra_miniturret",
			"talisman_extra_molotov",
			"talisman_extra_semtex",
			"talisman_impatient",
			"talisman_perk_mod_single",
			"talisman_perk_permanent_1",
			"talisman_perk_permanent_2",
			"talisman_perk_permanent_3",
			"talisman_perk_permanent_4",
			"talisman_perk_reducecost_1",
			"talisman_perk_reducecost_2",
			"talisman_perk_reducecost_3",
			"talisman_perk_reducecost_4",
			"talisman_perk_start_1",
			"talisman_perk_start_2",
			"talisman_perk_start_3",
			"talisman_perk_start_4",
			"talisman_shield_durability_legendary",
			"talisman_shield_durability_rare",
			"talisman_shield_price",
			"talisman_special_startlv2",
			"talisman_special_startlv3",
			"talisman_special_xp_rate",
			"talisman_start_weapon_ar",
			"talisman_start_weapon_lmg",
			"talisman_start_weapon_smg",
			"talisman_weapon_reducepapcost",
		}
		f40_local1 = {
			{
				result = f40_local2[math.floor(math.random(1, #f40_local2))],
				quantity = math.random(1, CoD.ZMLaboratoryUtility.MaxResults),
			},
			{
				result = f40_local2[math.floor(math.random(1, #f40_local2))],
				quantity = math.random(1, CoD.ZMLaboratoryUtility.MaxResults),
			},
			{
				result = f40_local2[math.floor(math.random(1, #f40_local2))],
				quantity = math.random(1, CoD.ZMLaboratoryUtility.MaxResults),
			},
		}
		if not Dvar[@"hash_749CD374D19822CB"]:exists() or tonumber(Dvar[@"hash_749CD374D19822CB"]:get()) > math.random() then
			table.insert(f40_local1, {
				result = f40_local3[math.floor(math.random(1, #f40_local3))],
				quantity = math.random(1, CoD.ZMLaboratoryUtility.MaxResults),
			})
		end
	else
		local f40_local2 = CoD.ZMLaboratoryUtility.GetLabModel(f40_arg0)
		f40_local1 = CoD.ZMLaboratoryUtility.GetResults(f40_local2.results)
	end
	local f40_local2 = function(f41_arg0)
		return {
			models = {
				indexModel = 0,
				id = "",
				modelRef = 0x0,
				rarity = -1,
				visible = 0,
				quantity = 0,
			},
			properties = {},
		}
	end
	for f40_local3 = 1, 4, 1 do
		table.insert(f40_local0, f40_local2(f40_local3))
	end
	for f40_local3 = 1, #f40_local1, 1 do
		if f40_local1[f40_local3].result ~= 0x0 then
			local f40_local6 = Engine[@"hash_68FF94BB44442412"](f40_local1[f40_local3].result, Enum.eModes.mode_zombies)
			if f40_local6 ~= CoD.CACUtility.EmptyItemIndex then
				local f40_local7 = CoD.CACUtility.GetUnlockableItemInfo(f40_local6, Enum.eModes.mode_zombies)
				local f40_local8 = 0x0
				if f40_local7.itemGroup == "bubblegum_consumable" or f40_local7.itemGroup == "talisman" then
					f40_local8 = f40_local7[@"previewmodelname"]
				end
				f40_local0[f40_local3].models.indexModel = f40_local6
				f40_local0[f40_local3].models.id = f40_local7.name
				f40_local0[f40_local3].models.modelRef = f40_local8
				f40_local0[f40_local3].models.rarity = f40_local7.itemGroup and f40_local7[@"bgbrarity"] - Enum[@"bgbrarity"][@"hash_DB789CFA0F046FA"] or f40_local7[@"talismanrarity"]
				f40_local0[f40_local3].models.quantity = f40_local1[f40_local3].quantity
			end
		end
	end
	return f40_local0
end, true)
DataSources.ZMLaboratoryNPItemList = {
	prepare = function(f42_arg0, f42_arg1, f42_arg2)
		local f42_local0 = function(f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4, f43_arg5, f43_arg6, f43_arg7, f43_arg8, f43_arg9)
			local f43_local0 = f43_arg1[@"popupname"] or 0x0
			if f43_arg1[@"hash_42E0C54A32852FA5"] and f43_arg1[@"hash_42E0C54A32852FA5"] == 1 and f43_local0 ~= 0x0 then
				f43_local0 = Engine[@"hash_4F9F1239CFD921FE"](f43_local0, f43_arg1[@"hash_24C3F8DE7B651E1E"] or 0)
			end
			local f43_local1 = {}
			local f43_local2 = {
				skuID = f43_arg1[@"skuid"] or 0,
				dropType = f43_arg1[@"droptype"] or 0,
				icon = f43_arg1.tileicon or "blacktransparent",
				name = f43_local0,
				labelName = f43_arg1[@"descriptiontitle"] or "null/empty",
				displayName = f43_arg1[@"numplasma"] or 0,
				description = f43_arg1[@"descriptiontext"] or "null/empty",
				plasmaPrice = f43_arg1[@"plasmaprice"] or 0,
				price = f43_arg1.codpointprice or 0,
			}
			local f43_local3
			if f43_arg3 ~= nil then
				f43_local3 = f43_arg3
			else
				f43_local3 = false
			end
			f43_local2.specialOffer = f43_local3
			f43_local2.maxQuantity = f43_arg1.maxquantity
			f43_local2.offerAssetName = f43_arg2
			f43_local2.eventTimerModel = f43_arg9
			f43_local1.models = f43_local2
			f43_local2 = {
				action = f43_arg4,
			}
			if f43_arg5 then
				local f43_local4 = f43_arg5
			end
			f43_local2.actionParam = f43_local4 or {}
			if f43_arg6 then
				local f43_local5 = f43_arg6
			end
			f43_local2.widgetOverride = f43_local5 or CoD.LaboratoryListItem
			f43_local2.rowSpan = f43_arg7
			f43_local2.columnSpan = f43_arg8
			f43_local1.properties = f43_local2
			if not f43_local1.properties.actionParam.price then
				f43_local1.properties.actionParam.price = f43_local1.models.price
			end
			if f43_arg1.centrifugecolor and f43_arg1[@"globstate"] then
				f43_local1.properties.focusChangedNotifyParams = {
					centrifuge_color = f43_arg1.centrifugecolor,
					glob_state = f43_arg1[@"globstate"],
				}
			end
			table.insert(f43_arg0, f43_local1)
		end
		local f42_local1 = function(f44_arg0, f44_arg1)
			f42_local0(f44_arg0, Engine[@"hash_2E00B2F29271C60B"](f44_arg1), f44_arg1, false, CoD.ZMLaboratoryUtility.DoLootQueryAndSendClientScriptNotify)
		end
		local f42_local2 = {}
		local f42_local3 = CoD.ZMLaboratoryUtility.AddExperimentalConcoctions(f42_arg0)
		if not f42_local3 then
			f42_local3 = CoD.ZMLaboratoryUtility.DefaultConcoctions
		end
		for f42_local4 = 1, #f42_local3, 1 do
			f42_local1(f42_local2, f42_local3[f42_local4].assetName)
		end
		if Dvar[@"hash_77880D40C777EDD4"]:exists() and Dvar[@"hash_77880D40C777EDD4"]:get() == "1" and IsBooleanDvarSet("laboratory_show_special_offers") then
			for f42_local4 = 1, CoD.ZMLaboratoryUtility.MaxSpecialOffers, 1 do
				local f42_local7 = CoD.ZMLaboratoryUtility.GetLaboratorySpecialOffer(f42_local4)
				local f42_local8 = f42_local7 and Engine[@"hash_2E00B2F29271C60B"](f42_local7)
				if f42_local8 then
					if f42_local8[@"hash_6221E7D2CD7EF58C"] and f42_local8[@"hash_6221E7D2CD7EF58C"] ~= 0 then
						f42_local0(f42_local2, f42_local8, f42_local7, true, CoD.ZMLaboratoryUtility.DoLootQueryAndSendClientScriptNotify)
					else
						f42_local0(f42_local2, f42_local8, f42_local7, true, CoD.ZMLaboratoryUtility.PurchasePlasmaOrCoDPoints, {
							openedDirectly = true,
							amount = f42_local8[@"numplasma"] or 0,
							image = f42_local8.tileicon or "blacktransparent",
						}, CoD.LaboratoryListItemNebuliumPlasmaDiscount, 1, 3, "AutoEvents.autoevent_laboratory_special_offer_" .. f42_local4 .. "_timer")
					end
				end
			end
		end
		f42_arg1.buttons = {}
		local f42_local4 = CoD.ZMLaboratoryUtility.GetLabModel(f42_arg0)
		f42_local4 = f42_local4:create("ZMLaboratoryNPItemList")
		for f42_local7, f42_local8 in ipairs(f42_local2) do
			local f42_local11 = Engine.CreateModel(f42_local4, f42_local7)
			if f42_local8.models then
				LuaUtils.CreateModelsFromTable(f42_local11, f42_local8.models)
				if not f42_arg1.eventCycledSubscription then
					local f42_local10 = Engine.GetGlobalModel()
					f42_local10 = f42_local10:create("AutoEvents.cycled")
					if f42_local10 then
						f42_arg1.eventCycledSubscription = f42_arg1:subscribeToModel(f42_local10, function(model)
							f42_arg1:updateDataSource(false, false)
						end, false)
					end
				end
			end
			if not f42_arg2 or f42_arg2(f42_local11) then
				table.insert(f42_arg1.buttons, {
					model = f42_local11,
					properties = f42_local8.properties,
				})
			end
		end
		f42_arg1.model = f42_local4
	end,
	getCount = function(f46_arg0)
		return f46_arg0.buttons and #f46_arg0.buttons or 0
	end,
	getItem = function(f47_arg0, f47_arg1, f47_arg2)
		return f47_arg1.buttons[f47_arg2].model
	end,
	getCustomPropertiesForItem = function(f48_arg0, f48_arg1)
		return f48_arg0.buttons[f48_arg1].properties
	end,
	getWidgetTypeForItem = function(f49_arg0, f49_arg1, f49_arg2)
		return f49_arg0.buttons[f49_arg2].properties.widgetOverride
	end,
	cleanup = function(f50_arg0, f50_arg1)
		Engine.UnsubscribeAndFreeModel(f50_arg0.model)
	end,
}
CoD.ZMLaboratoryUtility.GetPurchasePlasmaModel = function(f51_arg0)
	local f51_local0 = CoD.ZMLaboratoryUtility.GetLabModel(f51_arg0)
	if not f51_local0.PurchasePlasmaInfo then
		local f51_local1 = f51_local0:create("PurchasePlasmaInfo")
		f51_local1:create("price")
		f51_local1:create("lastSelectedOfferButtonModel")
	end
	return f51_local0.PurchasePlasmaInfo
end
CoD.ZMLaboratoryUtility.OpenCoDPointsPopoutConfirmation = function(f52_arg0, f52_arg1, f52_arg2, f52_arg3, f52_arg4)
	local f52_local0 = f52_arg4:openPopup("PurchaseCodPoints", f52_arg2, CoD.ZMLaboratoryUtility.GetPurchasePlasmaModel(f52_arg2))
	f52_local0.dontCloseOnStoreOpen = true
	local f52_local1 = nil
	if CoD.isPC then
		local f52_local2 = Engine.GetModelForController(f52_arg2)
		f52_local1 = f52_local2:create("battlenetCheckoutStatus")
	else
		local f52_local2 = Engine.GetModelForController(f52_arg2)
		f52_local2 = f52_local2:create("LootStreamProgress")
		f52_local1 = f52_local2:create("codPoints")
	end
	f52_local0:subscribeToModel(f52_local1, function(model)
		local f53_local0 = nil
		if CoD.isPC then
			if model:get() ~= 1 then
				return
			end
			local f53_local1 = Engine.GetModelForController(f52_arg2)
			f53_local1 = f53_local1:create("LootStreamProgress")
			f53_local0 = f53_local1:create("codPoints")
		else
			f53_local0 = model
		end
		if f53_local0:get() ~= nil and f52_arg3.model.price and f52_arg3.model.price:get() <= Engine[@"hash_2F40679B550DCCA2"](f52_arg2, CoD.Currencies.COD_POINTS) then
			local f53_local1 = CoD.ZMLaboratoryUtility.GetPurchasePlasmaModel(f52_arg2)
			local f53_local2 = f53_local1.lastSelectedOfferButtonModel:get()
			local f53_local3 = f52_arg3.model.offerAssetName
			if f53_local3 then
				f53_local3 = f52_arg3.model.offerAssetName:get()
			end
			if f53_local2 then
				f52_arg4 = GoBack(f52_local0, f52_arg2)
				if not f52_arg3.openedDirectly then
					OpenPopup(f52_arg4, "PurchasePlasma", f52_arg2, f53_local2)
				elseif not f53_local3 or f53_local3 == "" or f53_local3 == 0x0 or CoD.ZMLaboratoryUtility.IsOfferAvailable(f53_local3) then
					OpenPopup(f52_arg4, "LaboratoryPlasmaConfirmation", f52_arg2, {
						_model = f52_arg3.model,
						_properties = f52_arg3,
					})
				end
			end
		end
	end, false)
end
CoD.ZMLaboratoryUtility.PurchasePlasmaOrCoDPoints = function(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4)
	if CanPurchaseItem(f54_arg2, f54_arg1) then
		CoD.ZMLaboratoryUtility.PurchasePlasmaAction(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4)
	else
		if not f54_arg3 then
			f54_arg3 = {}
		end
		if not f54_arg3.model then
			f54_arg3.model = f54_arg1:getModel()
		end
		local f54_local0 = f54_arg1:getModel()
		if f54_local0 and f54_local0.price then
			local f54_local1 = CoD.ZMLaboratoryUtility.GetPurchasePlasmaModel(f54_arg2)
			f54_local1.price:set(f54_local0.price:get())
		end
		local f54_local1 = f54_arg4
		if not f54_arg3.openedDirectly then
			f54_local1 = GoBack(f54_arg4, f54_arg2)
		end
		CoD.ZMLaboratoryUtility.OpenCoDPointsPopoutConfirmation(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_local1)
	end
end
CoD.ZMLaboratoryUtility.PurchasePlasmaAction = function(f55_arg0, f55_arg1, f55_arg2, f55_arg3, f55_arg4)
	local f55_local0 = f55_arg4
	local f55_local1 = f55_arg1:getModel()
	if not f55_arg3.openedDirectly then
		f55_local0 = GoBack(f55_arg4, f55_arg2)
	end
	OpenPopup(f55_local0, "LaboratoryPlasmaConfirmation", f55_arg2, {
		_model = f55_local1,
		_properties = f55_arg3,
	})
end
DataSources.ZMLaboratoryPlasmaItemList = ListHelper_SetupDataSource("ZMLaboratoryPlasmaItemList", function(f56_arg0, f56_arg1)
	local f56_local0 = function(f57_arg0, f57_arg1, f57_arg2, f57_arg3, f57_arg4, f57_arg5, f57_arg6, f57_arg7, f57_arg8)
		table.insert(f57_arg0, {
			models = {
				skuID = f57_arg1,
				name = Engine[@"hash_4F9F1239CFD921FE"](@"hash_4A7502A86996BD46", f57_arg4),
				amount = f57_arg4,
				icon = f57_arg3,
				price = f57_arg5,
				isFeatured = f57_arg6,
			},
			properties = {
				action = f57_arg7,
				actionParam = {},
			},
		})
	end
	local f56_local1 = {}
	f56_local0(f56_local1, 500052, "zmui/bgb_aftertaste", "ui_icon_laboratory_nebulium_offer_large", 300, 2000, true, CoD.ZMLaboratoryUtility.PurchasePlasmaOrCoDPoints)
	f56_local0(f56_local1, 500051, "zmui/bgb_always_done_swiftly", "ui_icon_laboratory_nebulium_offer_medium", 75, 500, false, CoD.ZMLaboratoryUtility.PurchasePlasmaOrCoDPoints)
	f56_local0(f56_local1, 500050, "zmui/bgb_aftertaste", "ui_icon_laboratory_nebulium_offer_small", 30, 200, false, CoD.ZMLaboratoryUtility.PurchasePlasmaOrCoDPoints)
	return f56_local1
end)
DataSources.PlasmaConfirmationButtonList = ListHelper_SetupDataSource("PlasmaConfirmationButtonList", function(f58_arg0, f58_arg1)
	local f58_local0 = {}
	table.insert(f58_local0, {
		models = {
			displayText = @"menu/purchase",
			displayImage = "blacktransparent",
		},
		properties = {
			action = SetWorkingStateAndPurchaseDWSKU,
			actionParam = {
				controller = f58_arg0,
			},
		},
	})
	table.insert(f58_local0, {
		models = {
			displayText = @"menu/cancel",
			displayImage = "blacktransparent",
		},
		properties = {
			action = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3, f59_arg4)
				GoBack(f59_arg0, f59_arg2)
			end,
		},
	})
	return f58_local0
end, true)
local f0_local0 = CoD.OverlayUtility.AddSystemOverlay
local f0_local1 = "NotEnoughNPPopup"
local f0_local2 = {
	menuName = "SystemOverlay_Compact",
	title = @"hash_1DFE20BB2A710F9C",
	description = function(f60_arg0, f60_arg1)
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_19A39FF477A7A0F", f60_arg1.npRequired - Engine[@"hash_2F40679B550DCCA2"](f60_arg0, CoD.Currencies.ZM_NEBULIUM_PLASMA))
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.Error,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	listDatasource = function()
		DataSources.NotEnoughNPPopupButtonList = DataSourceHelpers.ListSetup("NotEnoughNPPopupButtonList", function(f62_arg0)
			local f62_local0 = {}
			local f62_local1 = {}
			local f62_local2 = {}
			local f62_local3 = Engine[@"hash_4F9F1239CFD921FE"]
			local f62_local4
			if not CoD.isPC then
				f62_local4 = @"menu/cancel"
				if not f62_local4 then
				else
					f62_local2.displayText = f62_local3(f62_local4)
					f62_local1.models = f62_local2
					f62_local1.properties = {
						action = function(f63_arg0, f63_arg1, f63_arg2, f63_arg3, f63_arg4)
							GoBack(f63_arg4, f63_arg2)
						end,
					}
					f62_local0[1] = f62_local1
					return f62_local0
				end
			end
			f62_local4 = @"menu/close"
		end, true, nil)
		return "NotEnoughNPPopupButtonList"
	end,
}
local f0_local3 = CoD.OverlayUtility.aCrossPromptFn
if not CoD.isPC then
else
end
f0_local2[f0_local3] = function(f64_arg0)
	return function(f65_arg0, f65_arg1)
		GoBack(f65_arg0, f65_arg1)
	end
end
f0_local3 = CoD.OverlayUtility.aCrossPromptText
if not CoD.isPC then
else
end
f0_local2[f0_local3] = @"menu/close"
f0_local0(f0_local1, f0_local2)
CoD.OverlayUtility.AddSystemOverlay("LaboratoryTimedOutPopup", {
	menuName = "SystemOverlay_Compact",
	title = @"hash_1F541582676977C",
	description = @"hash_1DAB84E40ACA5331",
	categoryType = CoD.OverlayUtility.OverlayTypes.Error,
	[CoD.OverlayUtility.GoBackPropertyName] = function()
		return function(f67_arg0, f67_arg1)
			CoD.ZMLaboratoryUtility.CloseTimedOutPopup(nil, nil, f67_arg1, nil, f67_arg0)
			GoBack(f67_arg0, f67_arg1)
		end
	end,
	listDatasource = function()
		DataSources.LaboratoryTimedOutPopupList = DataSourceHelpers.ListSetup("LaboratoryTimedOutPopupList", function(f69_arg0)
			return {
				{
					models = {
						displayText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/cancel"),
					},
					properties = {
						action = function(f70_arg0, f70_arg1, f70_arg2, f70_arg3, f70_arg4)
							CoD.ZMLaboratoryUtility.CloseTimedOutPopup(f70_arg0, f70_arg1, f70_arg2, f70_arg3, f70_arg4)
							GoBack(f70_arg4, f70_arg2)
						end,
					},
				},
			}
		end, true, nil)
		return "LaboratoryTimedOutPopupList"
	end,
})
