require("x64:46728994d8c06c0")
require("x64:a2b686853ff98c0")
require("x64:47a4af3567f1fa")
CoD.Barracks_GauntletStats_ZM = InheritFrom(LUI.UIElement)
CoD.Barracks_GauntletStats_ZM.__defaultWidth = 477
CoD.Barracks_GauntletStats_ZM.__defaultHeight = 677
CoD.Barracks_GauntletStats_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Barracks_GauntletStats_ZM)
	self.id = "Barracks_GauntletStats_ZM"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel2 = CoD.CommonDetailPanel02.new(f1_arg0, f1_arg1, 0, 0, 0, 477, 0, 1, 0, 0)
	CommonDetailPanel2.BackingBlur:setAlpha(0)
	CommonDetailPanel2.BackingTint:setAlpha(0.5)
	self:addElement(CommonDetailPanel2)
	self.CommonDetailPanel2 = CommonDetailPanel2
	local bgBronze = LUI.UIImage.new(0.5, 0.5, -18, 228, 0, 0, 472, 682)
	bgBronze:setRGB(0.23, 0.23, 0.23)
	bgBronze:setAlpha(0.25)
	self:addElement(bgBronze)
	self.bgBronze = bgBronze
	local dotline02 = LUI.UIImage.new(0.5, 0.5, -230, 230, 0, 0, 467, 471)
	dotline02:setAlpha(0.2)
	dotline02:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline02:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline02:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline02)
	self.dotline02 = dotline02
	local bgSilver = LUI.UIImage.new(0.5, 0.5, -18, 228, 0, 0, 255, 465)
	bgSilver:setRGB(0.23, 0.23, 0.23)
	bgSilver:setAlpha(0.25)
	self:addElement(bgSilver)
	self.bgSilver = bgSilver
	local dotline01 = LUI.UIImage.new(0.5, 0.5, -230, 230, 0, 0, 249, 253)
	dotline01:setAlpha(0.2)
	dotline01:setImage(RegisterImage(@"uie_ui_menu_social_emblem_dotline"))
	dotline01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	dotline01:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline01)
	self.dotline01 = dotline01
	local bgGold = LUI.UIImage.new(0.5, 0.5, -18, 228, 0, 0, 38, 248)
	bgGold:setRGB(0.23, 0.23, 0.23)
	bgGold:setAlpha(0.25)
	self:addElement(bgGold)
	self.bgGold = bgGold
	local TrialsBronzeMedal = CoD.ZMTrialMedal.new(f1_arg0, f1_arg1, 0.5, 0.5, -214, -39, 0, 0, 487.5, 662.5)
	TrialsBronzeMedal:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "bronzeMedals", 0)
			end,
		},
	})
	TrialsBronzeMedal:linkToElementModel(TrialsBronzeMedal, "bronzeMedals", true, function(model)
		f1_arg0:updateElementState(TrialsBronzeMedal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "bronzeMedals",
		})
	end)
	TrialsBronzeMedal.Medal:setImage(RegisterImage(@"uie_trial_bronze_medal"))
	TrialsBronzeMedal:linkToElementModel(self, nil, false, function(model)
		TrialsBronzeMedal:setModel(model, f1_arg1)
	end)
	self:addElement(TrialsBronzeMedal)
	self.TrialsBronzeMedal = TrialsBronzeMedal
	local TrialsSilverMedal = CoD.ZMTrialMedal.new(f1_arg0, f1_arg1, 0.5, 0.5, -214, -39, 0, 0, 282.5, 457.5)
	TrialsSilverMedal:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "silverMedals", 0)
			end,
		},
	})
	TrialsSilverMedal:linkToElementModel(TrialsSilverMedal, "silverMedals", true, function(model)
		f1_arg0:updateElementState(TrialsSilverMedal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "silverMedals",
		})
	end)
	TrialsSilverMedal.Medal:setImage(RegisterImage(@"uie_trial_silver_medal"))
	TrialsSilverMedal:linkToElementModel(self, nil, false, function(model)
		TrialsSilverMedal:setModel(model, f1_arg1)
	end)
	self:addElement(TrialsSilverMedal)
	self.TrialsSilverMedal = TrialsSilverMedal
	local TrialsGoldMedal = CoD.ZMTrialMedal.new(f1_arg0, f1_arg1, 0.5, 0.5, -214, -39, 0, 0, 56.5, 231.5)
	TrialsGoldMedal:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "goldMedals", 0)
			end,
		},
	})
	TrialsGoldMedal:linkToElementModel(TrialsGoldMedal, "goldMedals", true, function(model)
		f1_arg0:updateElementState(TrialsGoldMedal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "goldMedals",
		})
	end)
	TrialsGoldMedal.Medal:setImage(RegisterImage(@"uie_trial_gold_medal"))
	TrialsGoldMedal:linkToElementModel(self, nil, false, function(model)
		TrialsGoldMedal:setModel(model, f1_arg1)
	end)
	self:addElement(TrialsGoldMedal)
	self.TrialsGoldMedal = TrialsGoldMedal
	local Header = LUI.UIText.new(0, 1, 0, 0, 0, 0, 10.5, 40.5)
	Header:setRGB(0.92, 0.92, 0.92)
	Header:setText(LocalizeToUpperString(@"hash_5CF423A9E98ACB09"))
	Header:setTTF("ttmussels_regular")
	Header:setLetterSpacing(4)
	Header:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(Header)
	self.Header = Header
	local GautlentGoldStats = CoD.PlayerStatsGauntlet.new(f1_arg0, f1_arg1, 0, 0, 243.5, 443.5, 0, 0, 93, 195)
	GautlentGoldStats.StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GautlentGoldStats.StatHeaderText:setText(ConvertToUpperString(LocalizeIntoString(@"menu/x_rounds", 30)))
	GautlentGoldStats.StatHeaderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GautlentGoldStats:linkToElementModel(self, "goldMedals", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			GautlentGoldStats.StatValue:setText(CoD.BaseUtility.AlreadyLocalized(f11_local0))
		end
	end)
	self:addElement(GautlentGoldStats)
	self.GautlentGoldStats = GautlentGoldStats
	local GautlentSilverStats = CoD.PlayerStatsGauntlet.new(f1_arg0, f1_arg1, 0, 0, 243.5, 443.5, 0, 0, 309, 411)
	GautlentSilverStats.StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GautlentSilverStats.StatHeaderText:setText(ConvertToUpperString(LocalizeIntoString(@"menu/x_rounds", 20)))
	GautlentSilverStats.StatHeaderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GautlentSilverStats:linkToElementModel(self, "silverMedals", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			GautlentSilverStats.StatValue:setText(CoD.BaseUtility.AlreadyLocalized(f12_local0))
		end
	end)
	self:addElement(GautlentSilverStats)
	self.GautlentSilverStats = GautlentSilverStats
	local GautlentSilverStats2 = CoD.PlayerStatsGauntlet.new(f1_arg0, f1_arg1, 0, 0, 243.5, 443.5, 0, 0, 524, 626)
	GautlentSilverStats2.StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GautlentSilverStats2.StatHeaderText:setText(ConvertToUpperString(LocalizeIntoString(@"menu/x_rounds", 10)))
	GautlentSilverStats2.StatHeaderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	GautlentSilverStats2:linkToElementModel(self, "bronzeMedals", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			GautlentSilverStats2.StatValue:setText(CoD.BaseUtility.AlreadyLocalized(f13_local0))
		end
	end)
	self:addElement(GautlentSilverStats2)
	self.GautlentSilverStats2 = GautlentSilverStats2
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local14 = self
	DataSourceHelperRecreate(f1_arg1, "ZMBarracksTrialStats")
	return self
end
CoD.Barracks_GauntletStats_ZM.__onClose = function(f15_arg0)
	f15_arg0.CommonDetailPanel2:close()
	f15_arg0.TrialsBronzeMedal:close()
	f15_arg0.TrialsSilverMedal:close()
	f15_arg0.TrialsGoldMedal:close()
	f15_arg0.GautlentGoldStats:close()
	f15_arg0.GautlentSilverStats:close()
	f15_arg0.GautlentSilverStats2:close()
end
