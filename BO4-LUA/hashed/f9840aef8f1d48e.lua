require("x64:907cf54ba0ffc10")
CoD.SupplyChainDetails_InfoPanelTitleAndDesc = InheritFrom(LUI.UIElement)
CoD.SupplyChainDetails_InfoPanelTitleAndDesc.__defaultWidth = 520
CoD.SupplyChainDetails_InfoPanelTitleAndDesc.__defaultHeight = 216
CoD.SupplyChainDetails_InfoPanelTitleAndDesc.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SupplyChainDetails_InfoPanelTitleAndDesc)
	self.id = "SupplyChainDetails_InfoPanelTitleAndDesc"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SubExtraText = LUI.UIText.new(0, 0, 0, 383, 0, 0, 191, 209)
	SubExtraText:setTTF("dinnext_regular")
	SubExtraText:setLetterSpacing(1)
	SubExtraText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SubExtraText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	SubExtraText:linkToElementModel(self, "subExtraText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SubExtraText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(SubExtraText)
	self.SubExtraText = SubExtraText
	local MainExtraText = LUI.UIText.new(0, 0, 0, 383, 0, 0, 165, 185)
	MainExtraText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MainExtraText:setTTF("ttmussels_regular")
	MainExtraText:setLetterSpacing(2)
	MainExtraText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MainExtraText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	MainExtraText:linkToElementModel(self, "mainExtraText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MainExtraText:setText(ToUpper(f3_local0))
		end
	end)
	self:addElement(MainExtraText)
	self.MainExtraText = MainExtraText
	local SetBonusWidget = CoD.SetBonusWidget.new(f1_arg0, f1_arg1, 0, 0, 392, 520, 0, 0, 0, 216)
	SetBonusWidget:linkToElementModel(self, nil, false, function(model)
		SetBonusWidget:setModel(model, f1_arg1)
	end)
	self:addElement(SetBonusWidget)
	self.SetBonusWidget = SetBonusWidget
	local Desc = LUI.UIText.new(0, 0, 0, 383, 0, 0, 70.5, 88.5)
	Desc:setTTF("dinnext_regular")
	Desc:setLetterSpacing(1)
	Desc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Desc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Desc:linkToElementModel(self, "desc", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Desc:setText(f5_local0)
		end
	end)
	self:addElement(Desc)
	self.Desc = Desc
	local Name = LUI.UIText.new(0, 0, 0, 383, 0, 0, 34.5, 64.5)
	Name:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Name:setTTF("ttmussels_demibold")
	Name:setLetterSpacing(4)
	Name:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Name:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	Name:linkToElementModel(self, "name", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Name:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	self:mergeStateConditions({
		{
			stateName = "Bonus",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "setBonusImage")
			end,
		},
	})
	self:linkToElementModel(self, "setBonusImage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "setBonusImage",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SupplyChainDetails_InfoPanelTitleAndDesc.__resetProperties = function(f9_arg0)
	f9_arg0.SetBonusWidget:completeAnimation()
	f9_arg0.Name:completeAnimation()
	f9_arg0.Desc:completeAnimation()
	f9_arg0.MainExtraText:completeAnimation()
	f9_arg0.SubExtraText:completeAnimation()
	f9_arg0.SetBonusWidget:setAlpha(1)
	f9_arg0.Name:setLeftRight(0, 0, 0, 383)
	f9_arg0.Desc:setLeftRight(0, 0, 0, 383)
	f9_arg0.MainExtraText:setLeftRight(0, 0, 0, 383)
	f9_arg0.SubExtraText:setLeftRight(0, 0, 0, 383)
end
CoD.SupplyChainDetails_InfoPanelTitleAndDesc.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			f10_arg0.SubExtraText:completeAnimation()
			f10_arg0.SubExtraText:setLeftRight(0, 0, 0, 500)
			f10_arg0.clipFinished(f10_arg0.SubExtraText)
			f10_arg0.MainExtraText:completeAnimation()
			f10_arg0.MainExtraText:setLeftRight(0, 0, 0, 500)
			f10_arg0.clipFinished(f10_arg0.MainExtraText)
			f10_arg0.SetBonusWidget:completeAnimation()
			f10_arg0.SetBonusWidget:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.SetBonusWidget)
			f10_arg0.Desc:completeAnimation()
			f10_arg0.Desc:setLeftRight(0, 0, 0, 500)
			f10_arg0.clipFinished(f10_arg0.Desc)
			f10_arg0.Name:completeAnimation()
			f10_arg0.Name:setLeftRight(0, 0, 0, 500)
			f10_arg0.clipFinished(f10_arg0.Name)
		end,
	},
	Bonus = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.SupplyChainDetails_InfoPanelTitleAndDesc.__onClose = function(f12_arg0)
	f12_arg0.SubExtraText:close()
	f12_arg0.MainExtraText:close()
	f12_arg0.SetBonusWidget:close()
	f12_arg0.Desc:close()
	f12_arg0.Name:close()
end
