require("x64:29187ea00d726c3")
require("x64:f1f9f9b9d79987c")
require("x64:1a063cf71f3a1f9")
require("x64:65a583181416924")
CoD.WarzoneInventoryUnlockMissionObjective = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryUnlockMissionObjective.__defaultWidth = 310
CoD.WarzoneInventoryUnlockMissionObjective.__defaultHeight = 120
CoD.WarzoneInventoryUnlockMissionObjective.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, true)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.WarzoneInventoryUnlockMissionObjective)
	self.id = "WarzoneInventoryUnlockMissionObjective"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WarzoneInventoryUnlockMissionBacking = CoD.WarzoneInventoryUnlockMissionBacking.new(f1_arg0, f1_arg1, 0, 1, -4, -4, 0, 1, 0, 0)
	WarzoneInventoryUnlockMissionBacking.BackingTint:setRGB(0.07, 0.07, 0.07)
	self:addElement(WarzoneInventoryUnlockMissionBacking)
	self.WarzoneInventoryUnlockMissionBacking = WarzoneInventoryUnlockMissionBacking
	local description = LUI.UIText.new(0, 0.9, 9, 9, 0, 0, 0, 20)
	description:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	description:setText(Engine[@"hash_4F9F1239CFD921FE"](@"warzone/inventory"))
	description:setTTF("ttmussels_regular")
	description:setLetterSpacing(1)
	description:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_left"]))
	description:setAlignment(Engine[@"hash_67F8853DC3581AA4"](Enum[@"luialignment"][@"lui_alignment_top"]))
	self:addElement(description)
	self.description = description
	local ButtonTopLine9Slice = LUI.UIImage.new(0, 0, 4, 304, 0, 0, 25, 45)
	ButtonTopLine9Slice:setAlpha(0.2)
	ButtonTopLine9Slice:setImage(RegisterImage(@"uie_ui_menu_cac_secondary_button_top_line"))
	ButtonTopLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	ButtonTopLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice)
	self.ButtonTopLine9Slice = ButtonTopLine9Slice
	local characterMissionLabel = LUI.UIText.new(0, 0.9, 9, -1, 0, 0, 50, 70)
	characterMissionLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	characterMissionLabel:setText(LocalizeToUpperString(@"wz/character_mission"))
	characterMissionLabel:setTTF("ttmussels_demibold")
	characterMissionLabel:setLetterSpacing(4)
	characterMissionLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	characterMissionLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(characterMissionLabel)
	self.characterMissionLabel = characterMissionLabel
	local alreadyCompleted = LUI.UIText.new(0, 0.94, 9, 9, 0, 0, 75, 95)
	alreadyCompleted:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	alreadyCompleted:setAlpha(0)
	alreadyCompleted:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1BA819F632BB248A"))
	alreadyCompleted:setTTF("ttmussels_regular")
	alreadyCompleted:setLetterSpacing(1)
	alreadyCompleted:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	alreadyCompleted:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(alreadyCompleted)
	self.alreadyCompleted = alreadyCompleted
	local objective1 = LUI.UIText.new(0.03, 0.93, 32, 0, 0, 0, 100, 120)
	objective1:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	objective1:setTTF("ttmussels_regular")
	objective1:setLetterSpacing(1)
	objective1:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	objective1:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	objective1:setBackingType(1)
	objective1:setBackingWidget(CoD.WarzoneInventoryUnlockMissionObjectiveBG, f1_arg0, f1_arg1)
	objective1:setBackingXPadding(24)
	objective1:linkToElementModel(self, "objective1.description", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			objective1:setText(CoD.WZUtility.GetWZInventoryUnlockDescription(f1_arg1, self:getModel(), 1, f2_local0))
		end
	end)
	objective1:linkToElementModel(self, "objective1", false, function(model)
		objective1:setBackingModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(objective1, "setText", function(element, controller)
		if IsTextEmpty(element) then
			HideWidget(element)
		elseif not IsTextEmpty(element) and not IsElementInState(self, "AlreadyCompleted") then
			ShowWidget(element)
		end
	end)
	self:addElement(objective1)
	self.objective1 = objective1
	local objective2 = LUI.UIText.new(0.03, 0.93, 32, 0, 0, 0, 125, 145)
	objective2:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	objective2:setTTF("ttmussels_regular")
	objective2:setLetterSpacing(1)
	objective2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	objective2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	objective2:setBackingType(1)
	objective2:setBackingWidget(CoD.WarzoneInventoryUnlockMissionObjectiveBG, f1_arg0, f1_arg1)
	objective2:setBackingXPadding(24)
	objective2:linkToElementModel(self, "objective2.description", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			objective2:setText(CoD.WZUtility.GetWZInventoryUnlockDescription(f1_arg1, self:getModel(), 2, f5_local0))
		end
	end)
	objective2:linkToElementModel(self, "objective2", false, function(model)
		objective2:setBackingModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(objective2, "setText", function(element, controller)
		if IsTextEmpty(element) then
			HideWidget(element)
		elseif not IsTextEmpty(element) and not IsElementInState(self, "AlreadyCompleted") then
			ShowWidget(element)
		end
	end)
	self:addElement(objective2)
	self.objective2 = objective2
	local objective3 = LUI.UIText.new(0.03, 0.93, 32, 0, 0, 0, 150, 170)
	objective3:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	objective3:setTTF("ttmussels_regular")
	objective3:setLetterSpacing(1)
	objective3:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	objective3:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	objective3:setBackingType(1)
	objective3:setBackingWidget(CoD.WarzoneInventoryUnlockMissionObjectiveBG, f1_arg0, f1_arg1)
	objective3:setBackingXPadding(24)
	objective3:linkToElementModel(self, "objective3.description", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			objective3:setText(CoD.WZUtility.GetWZInventoryUnlockDescription(f1_arg1, self:getModel(), 3, f8_local0))
		end
	end)
	objective3:linkToElementModel(self, "objective3", false, function(model)
		objective3:setBackingModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(objective3, "setText", function(element, controller)
		if IsTextEmpty(element) then
			HideWidget(element)
		elseif not IsTextEmpty(element) and not IsElementInState(self, "AlreadyCompleted") then
			ShowWidget(element)
		end
	end)
	self:addElement(objective3)
	self.objective3 = objective3
	local objective4 = LUI.UIText.new(0.03, 0.93, 32, 0, 0, 0, 175, 195)
	objective4:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	objective4:setTTF("ttmussels_regular")
	objective4:setLetterSpacing(1)
	objective4:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	objective4:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	objective4:setBackingType(1)
	objective4:setBackingWidget(CoD.WarzoneInventoryUnlockMissionObjectiveBG, f1_arg0, f1_arg1)
	objective4:setBackingXPadding(24)
	objective4:linkToElementModel(self, "objective4.description", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			objective4:setText(CoD.WZUtility.GetWZInventoryUnlockDescription(f1_arg1, self:getModel(), 4, f11_local0))
		end
	end)
	objective4:linkToElementModel(self, "objective4", false, function(model)
		objective4:setBackingModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(objective4, "setText", function(element, controller)
		if IsTextEmpty(element) then
			HideWidget(element)
		elseif not IsTextEmpty(element) and not IsElementInState(self, "AlreadyCompleted") then
			ShowWidget(element)
		end
	end)
	self:addElement(objective4)
	self.objective4 = objective4
	local objective5 = LUI.UIText.new(0.03, 0.93, 32, 0, 0, 0, 200, 220)
	objective5:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	objective5:setTTF("ttmussels_regular")
	objective5:setLetterSpacing(1)
	objective5:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	objective5:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	objective5:setBackingType(1)
	objective5:setBackingWidget(CoD.WarzoneInventoryUnlockMissionObjectiveBG, f1_arg0, f1_arg1)
	objective5:setBackingXPadding(24)
	objective5:linkToElementModel(self, "objective5.description", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			objective5:setText(CoD.WZUtility.GetWZInventoryUnlockDescription(f1_arg1, self:getModel(), 5, f14_local0))
		end
	end)
	objective5:linkToElementModel(self, "objective5", false, function(model)
		objective5:setBackingModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(objective5, "setText", function(element, controller)
		if IsTextEmpty(element) then
			HideWidget(element)
		elseif not IsTextEmpty(element) and not IsElementInState(self, "AlreadyCompleted") then
			ShowWidget(element)
		end
	end)
	self:addElement(objective5)
	self.objective5 = objective5
	local VerticalListSpacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, -224.5, 525.5, 0, 0, 225, 228)
	self:addElement(VerticalListSpacer2)
	self.VerticalListSpacer2 = VerticalListSpacer2
	local rewardLabel = LUI.UIText.new(0, 0.9, 9, -1, 0, 0, 233, 253)
	rewardLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	rewardLabel:setText(LocalizeToUpperString(@"wz/reward"))
	rewardLabel:setTTF("ttmussels_demibold")
	rewardLabel:setLetterSpacing(4)
	rewardLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	rewardLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(rewardLabel)
	self.rewardLabel = rewardLabel
	local WarzoneInventoryUnlockMissionReward = CoD.WarzoneInventoryUnlockMissionReward.new(f1_arg0, f1_arg1, 0, 0.97, 0, 0, 0, 0, 258, 310)
	WarzoneInventoryUnlockMissionReward:linkToElementModel(self, nil, false, function(model)
		WarzoneInventoryUnlockMissionReward:setModel(model, f1_arg1)
	end)
	self:addElement(WarzoneInventoryUnlockMissionReward)
	self.WarzoneInventoryUnlockMissionReward = WarzoneInventoryUnlockMissionReward
	self:mergeStateConditions({
		{
			stateName = "AlreadyCompleted",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "completed", 2)
			end,
		},
		{
			stateName = "AsianLanguages",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	self:linkToElementModel(self, "completed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setText", function(element, controller) end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryUnlockMissionObjective.__resetProperties = function(f22_arg0)
	f22_arg0.objective1:completeAnimation()
	f22_arg0.objective2:completeAnimation()
	f22_arg0.objective3:completeAnimation()
	f22_arg0.objective4:completeAnimation()
	f22_arg0.objective5:completeAnimation()
	f22_arg0.alreadyCompleted:completeAnimation()
	f22_arg0.description:completeAnimation()
	f22_arg0.objective1:setTopBottom(0, 0, 100, 120)
	f22_arg0.objective1:setAlpha(1)
	f22_arg0.objective1:setLetterSpacing(1)
	f22_arg0.objective2:setTopBottom(0, 0, 125, 145)
	f22_arg0.objective2:setAlpha(1)
	f22_arg0.objective2:setLetterSpacing(1)
	f22_arg0.objective3:setTopBottom(0, 0, 150, 170)
	f22_arg0.objective3:setAlpha(1)
	f22_arg0.objective3:setLetterSpacing(1)
	f22_arg0.objective4:setTopBottom(0, 0, 175, 195)
	f22_arg0.objective4:setAlpha(1)
	f22_arg0.objective4:setLetterSpacing(1)
	f22_arg0.objective5:setTopBottom(0, 0, 200, 220)
	f22_arg0.objective5:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	f22_arg0.objective5:setAlpha(1)
	f22_arg0.objective5:setLetterSpacing(1)
	f22_arg0.alreadyCompleted:setAlpha(0)
	f22_arg0.description:setTopBottom(0, 0, 0, 20)
	f22_arg0.description:setLetterSpacing(1)
end
CoD.WarzoneInventoryUnlockMissionObjective.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
	AlreadyCompleted = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(6)
			f24_arg0.alreadyCompleted:completeAnimation()
			f24_arg0.alreadyCompleted:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.alreadyCompleted)
			f24_arg0.objective1:completeAnimation()
			f24_arg0.objective1:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.objective1)
			f24_arg0.objective2:completeAnimation()
			f24_arg0.objective2:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.objective2)
			f24_arg0.objective3:completeAnimation()
			f24_arg0.objective3:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.objective3)
			f24_arg0.objective4:completeAnimation()
			f24_arg0.objective4:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.objective4)
			f24_arg0.objective5:completeAnimation()
			f24_arg0.objective5:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.objective5)
		end,
	},
	AsianLanguages = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(6)
			f25_arg0.description:completeAnimation()
			f25_arg0.description:setTopBottom(0, 0, 0, 12)
			f25_arg0.description:setLetterSpacing(2)
			f25_arg0.clipFinished(f25_arg0.description)
			f25_arg0.objective1:completeAnimation()
			f25_arg0.objective1:setTopBottom(0, 0, 100, 112)
			f25_arg0.objective1:setLetterSpacing(2)
			f25_arg0.clipFinished(f25_arg0.objective1)
			f25_arg0.objective2:completeAnimation()
			f25_arg0.objective2:setTopBottom(0, 0, 125, 137)
			f25_arg0.objective2:setLetterSpacing(2)
			f25_arg0.clipFinished(f25_arg0.objective2)
			f25_arg0.objective3:completeAnimation()
			f25_arg0.objective3:setTopBottom(0, 0, 150, 162)
			f25_arg0.objective3:setLetterSpacing(2)
			f25_arg0.clipFinished(f25_arg0.objective3)
			f25_arg0.objective4:completeAnimation()
			f25_arg0.objective4:setTopBottom(0, 0, 175, 187)
			f25_arg0.objective4:setLetterSpacing(2)
			f25_arg0.clipFinished(f25_arg0.objective4)
			f25_arg0.objective5:completeAnimation()
			f25_arg0.objective5:setTopBottom(0, 0, 200, 212)
			f25_arg0.objective5:setRGB(0.66, 0.63, 0.52)
			f25_arg0.objective5:setLetterSpacing(2)
			f25_arg0.clipFinished(f25_arg0.objective5)
		end,
	},
}
CoD.WarzoneInventoryUnlockMissionObjective.__onClose = function(f26_arg0)
	f26_arg0.WarzoneInventoryUnlockMissionBacking:close()
	f26_arg0.objective1:close()
	f26_arg0.objective2:close()
	f26_arg0.objective3:close()
	f26_arg0.objective4:close()
	f26_arg0.objective5:close()
	f26_arg0.VerticalListSpacer2:close()
	f26_arg0.WarzoneInventoryUnlockMissionReward:close()
end
