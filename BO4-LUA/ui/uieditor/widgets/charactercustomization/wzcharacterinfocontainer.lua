require("x64:cb24abd293714b9")
require("x64:2c1273189457a97")
require("x64:c7e896ee4bc3f8")
CoD.WZCharacterInfoContainer = InheritFrom(LUI.UIElement)
CoD.WZCharacterInfoContainer.__defaultWidth = 393
CoD.WZCharacterInfoContainer.__defaultHeight = 160
CoD.WZCharacterInfoContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZCharacterInfoContainer)
	self.id = "WZCharacterInfoContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CharacterSelectionCharacterInfo = CoD.CharacterSelection_CharacterInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 0, 160)
	CharacterSelectionCharacterInfo:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue() and not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WZCharacterInfo", "showInfoState", CoD.WZUtility.CharacterInfoShowState.HIDE)
			end,
		},
	})
	local CharacterSelectionPrestigeInfo = CharacterSelectionCharacterInfo
	local TrialWidget = CharacterSelectionCharacterInfo.subscribeToModel
	local f1_local4 = DataSources.WZCharacterInfo.getModel(f1_arg1)
	TrialWidget(CharacterSelectionPrestigeInfo, f1_local4.showInfoState, function(f3_arg0)
		f1_arg0:updateElementState(CharacterSelectionCharacterInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "showInfoState",
		})
	end, false)
	CharacterSelectionCharacterInfo:linkToElementModel(self, nil, false, function(model)
		CharacterSelectionCharacterInfo:setModel(model, f1_arg1)
	end)
	CharacterSelectionCharacterInfo:linkToElementModel(self, "fullName", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CharacterSelectionCharacterInfo.CharacterFullName:setText(CoD.SocialUtility.CleanGamerTag(CoD.BaseUtility.LocalizeIfXHash(f5_local0)))
		end
	end)
	CharacterSelectionCharacterInfo.availabilityText.__availabilityText_String_Reference = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			CharacterSelectionCharacterInfo.availabilityText:setText(CoD.WZUtility.PrependUpsellIconIfNeed(self:getModel(), f6_local0))
		end
	end
	CharacterSelectionCharacterInfo:linkToElementModel(self, "availabilityText", true, CharacterSelectionCharacterInfo.availabilityText.__availabilityText_String_Reference)
	CharacterSelectionCharacterInfo.availabilityText.__availabilityText_String_Reference_FullPath = function()
		local f7_local0 = self:getModel()
		if f7_local0 then
			f7_local0 = self:getModel()
			f7_local0 = f7_local0.availabilityText
		end
		if f7_local0 then
			CharacterSelectionCharacterInfo.availabilityText.__availabilityText_String_Reference(f7_local0)
		end
	end
	LUI.OverrideFunction_CallOriginalFirst(CharacterSelectionCharacterInfo, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		UpdateElementState(self, "TrialWidget", controller)
	end)
	self:addElement(CharacterSelectionCharacterInfo)
	self.CharacterSelectionCharacterInfo = CharacterSelectionCharacterInfo
	TrialWidget = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 500, 0, 0, 220, 255)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and AlwaysFalse()
			end,
		},
		{
			stateName = "ShownLargeWrap",
			condition = function(menu, element, event)
				local f10_local0 = IsGameTrial()
				if f10_local0 then
					f10_local0 = IsElementInState(self.CharacterSelectionCharacterInfo, "Visible")
					if f10_local0 then
						f10_local0 = not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isDefaultCharacter")
					end
				end
				return f10_local0
			end,
		},
	})
	TrialWidget:linkToElementModel(TrialWidget, "isDefaultCharacter", true, function(model)
		f1_arg0:updateElementState(TrialWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isDefaultCharacter",
		})
	end)
	TrialWidget:linkToElementModel(self, nil, false, function(model)
		TrialWidget:setModel(model, f1_arg1)
	end)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	CharacterSelectionPrestigeInfo = CoD.CharacterSelection_PrestigeInfo.new(f1_arg0, f1_arg1, 0, 0, 0, 74, 0, 0, 144, 218)
	CharacterSelectionPrestigeInfo:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f13_local0
				if not IsPrestigeLevelAtZero(f1_arg1) then
					f13_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isEchelonUnlock")
				else
					f13_local0 = false
				end
				return f13_local0
			end,
		},
	})
	CharacterSelectionPrestigeInfo:linkToElementModel(CharacterSelectionPrestigeInfo, "isEchelonUnlock", true, function(model)
		f1_arg0:updateElementState(CharacterSelectionPrestigeInfo, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isEchelonUnlock",
		})
	end)
	CharacterSelectionPrestigeInfo:linkToElementModel(self, nil, false, function(model)
		CharacterSelectionPrestigeInfo:setModel(model, f1_arg1)
	end)
	self:addElement(CharacterSelectionPrestigeInfo)
	self.CharacterSelectionPrestigeInfo = CharacterSelectionPrestigeInfo
	CharacterSelectionCharacterInfo:linkToElementModel(self, "purchasable", true, CharacterSelectionCharacterInfo.availabilityText.__availabilityText_String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "TrialPurchsable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "purchasable")
			end,
		},
		{
			stateName = "TrialBMLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isBMLocked")
			end,
		},
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "disabled")
			end,
		},
	})
	self:linkToElementModel(self, "purchasable", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "purchasable",
		})
	end)
	self:linkToElementModel(self, "isBMLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isBMLocked",
		})
	end)
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZCharacterInfoContainer.__resetProperties = function(f22_arg0)
	f22_arg0.TrialWidget:completeAnimation()
	f22_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0x62486486346EC3F))
end
CoD.WZCharacterInfoContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(0)
		end,
	},
	TrialPurchsable = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			f24_arg0.TrialWidget:completeAnimation()
			f24_arg0.TrialWidget.InfoText:completeAnimation()
			f24_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0x7C9D41D120A6AD1))
			f24_arg0.clipFinished(f24_arg0.TrialWidget)
		end,
	},
	TrialBMLocked = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.TrialWidget:completeAnimation()
			f25_arg0.TrialWidget.InfoText:completeAnimation()
			f25_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0x8C8E3A75045BE50))
			f25_arg0.clipFinished(f25_arg0.TrialWidget)
		end,
	},
	TrialLocked = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.TrialWidget:completeAnimation()
			f26_arg0.TrialWidget.InfoText:completeAnimation()
			f26_arg0.TrialWidget.InfoText:setText(Engine[0xF9F1239CFD921FE](0xE88946FB6CDD737))
			f26_arg0.clipFinished(f26_arg0.TrialWidget)
		end,
	},
}
CoD.WZCharacterInfoContainer.__onClose = function(f27_arg0)
	f27_arg0.CharacterSelectionCharacterInfo:close()
	f27_arg0.TrialWidget:close()
	f27_arg0.CharacterSelectionPrestigeInfo:close()
end
