require("x64:3096a20718bc809")
require("x64:19c1945d2e472b0")
CoD.BM_ItemInfoPanel = InheritFrom(LUI.UIElement)
CoD.BM_ItemInfoPanel.__defaultWidth = 540
CoD.BM_ItemInfoPanel.__defaultHeight = 150
CoD.BM_ItemInfoPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ItemInfoPanel)
	self.id = "BM_ItemInfoPanel"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Box = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Box:setRGB(0.92, 0.92, 0.92)
	Box:setAlpha(0.01)
	self:addElement(Box)
	self.Box = Box
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 1, 1)
	DotTiledBacking:setAlpha(0.15)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local ButtonBottomLine9Slice = LUI.UIImage.new(0, 1, -6, 6, 0, 0, 143.5, 163.5)
	ButtonBottomLine9Slice:setAlpha(0.25)
	ButtonBottomLine9Slice:setImage(RegisterImage(0xC752149A1FA1AAE))
	ButtonBottomLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ButtonBottomLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonBottomLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonBottomLine9Slice)
	self.ButtonBottomLine9Slice = ButtonBottomLine9Slice
	local displayName = LUI.UIText.new(0, 0, 22, 518, 0, 0, 35, 66)
	displayName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	displayName:setTTF("ttmussels_demibold")
	displayName:setLetterSpacing(4)
	displayName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	displayName:linkToElementModel(self, "displayName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			displayName:setText(f2_local0)
		end
	end)
	self:addElement(displayName)
	self.displayName = displayName
	local SetInfo = LUI.UIText.new(0, 0, 22, 518, 0, 0, 68, 86)
	SetInfo:setRGB(0.92, 0.92, 0.92)
	SetInfo:setTTF("ttmussels_demibold")
	SetInfo:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SetInfo:linkToElementModel(self, "setInfo", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SetInfo:setText(f3_local0)
		end
	end)
	self:addElement(SetInfo)
	self.SetInfo = SetInfo
	local UnlockInfo = LUI.UIText.new(0, 0, 22, 518, 0, 0, 90, 108)
	UnlockInfo:setRGB(0.92, 0.92, 0.92)
	UnlockInfo:setTTF("dinnext_regular")
	UnlockInfo:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	UnlockInfo:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	UnlockInfo:linkToElementModel(self, "unlockInfo", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			UnlockInfo:setText(f4_local0)
		end
	end)
	self:addElement(UnlockInfo)
	self.UnlockInfo = UnlockInfo
	local Description = LUI.UIText.new(0, 0, 22, 518, 0, 0, 90, 108)
	Description:setRGB(0.92, 0.92, 0.92)
	Description:setAlpha(0)
	Description:setTTF("dinnext_regular")
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Description:linkToElementModel(self, "description", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Description:setText(f5_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local alertMessage = LUI.UIText.new(0, 0, 22, 518, 0, 0, 127, 145)
	alertMessage:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	alertMessage:setAlpha(0)
	alertMessage:setTTF("ttmussels_demibold")
	alertMessage:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	alertMessage:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	alertMessage:linkToElementModel(self, "alertMessage", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			alertMessage:setText(f6_local0)
		end
	end)
	self:addElement(alertMessage)
	self.alertMessage = alertMessage
	local ButtonTopLine9Slice = LUI.UIImage.new(0, 1, -6, 6, 0, 0, -6, 14)
	ButtonTopLine9Slice:setAlpha(0.25)
	ButtonTopLine9Slice:setImage(RegisterImage(0xC752149A1FA1AAE))
	ButtonTopLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ButtonTopLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonTopLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonTopLine9Slice)
	self.ButtonTopLine9Slice = ButtonTopLine9Slice
	local ItemInfoRarityHeader = CoD.BM_ItemInfoRarityHeader.new(f1_arg0, f1_arg1, 0, 0, -5, 540, 0, 0, -3, 33)
	ItemInfoRarityHeader:linkToElementModel(self, nil, false, function(model)
		ItemInfoRarityHeader:setModel(model, f1_arg1)
	end)
	self:addElement(ItemInfoRarityHeader)
	self.ItemInfoRarityHeader = ItemInfoRarityHeader
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelNil(element, f1_arg1)
			end,
		},
		{
			stateName = "AlertMessage",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "alertMessage")
			end,
		},
		{
			stateName = "OptionalDescription",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "description")
			end,
		},
		{
			stateName = "CustomEmblemTabSelected",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, nil, false, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model and model:get(),
			modelName = nil,
		})
	end)
	self:linkToElementModel(self, "alertMessage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "alertMessage",
		})
	end)
	self:linkToElementModel(self, "description", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "description",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ItemInfoPanel.__resetProperties = function(f15_arg0)
	f15_arg0.UnlockInfo:completeAnimation()
	f15_arg0.SetInfo:completeAnimation()
	f15_arg0.displayName:completeAnimation()
	f15_arg0.ButtonBottomLine9Slice:completeAnimation()
	f15_arg0.ButtonTopLine9Slice:completeAnimation()
	f15_arg0.DotTiledBacking:completeAnimation()
	f15_arg0.Box:completeAnimation()
	f15_arg0.SceneBlur:completeAnimation()
	f15_arg0.ItemInfoRarityHeader:completeAnimation()
	f15_arg0.alertMessage:completeAnimation()
	f15_arg0.Description:completeAnimation()
	f15_arg0.UnlockInfo:setTopBottom(0, 0, 90, 108)
	f15_arg0.UnlockInfo:setRGB(0.92, 0.92, 0.92)
	f15_arg0.UnlockInfo:setAlpha(1)
	f15_arg0.SetInfo:setTopBottom(0, 0, 68, 86)
	f15_arg0.SetInfo:setRGB(0.92, 0.92, 0.92)
	f15_arg0.SetInfo:setAlpha(1)
	f15_arg0.displayName:setTopBottom(0, 0, 35, 66)
	f15_arg0.displayName:setAlpha(1)
	f15_arg0.ButtonBottomLine9Slice:setAlpha(0.25)
	f15_arg0.ButtonTopLine9Slice:setAlpha(0.25)
	f15_arg0.DotTiledBacking:setAlpha(0.15)
	f15_arg0.Box:setAlpha(0.01)
	f15_arg0.SceneBlur:setAlpha(1)
	f15_arg0.ItemInfoRarityHeader:setAlpha(1)
	f15_arg0.alertMessage:setTopBottom(0, 0, 127, 145)
	f15_arg0.alertMessage:setAlpha(0)
	f15_arg0.Description:setTopBottom(0, 0, 90, 108)
	f15_arg0.Description:setAlpha(0)
end
CoD.BM_ItemInfoPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.displayName:completeAnimation()
			f16_arg0.displayName:setTopBottom(0, 0, 35, 66)
			f16_arg0.clipFinished(f16_arg0.displayName)
			f16_arg0.SetInfo:completeAnimation()
			f16_arg0.SetInfo:setTopBottom(0, 0, 68, 86)
			f16_arg0.SetInfo:setRGB(0.92, 0.92, 0.92)
			f16_arg0.clipFinished(f16_arg0.SetInfo)
			f16_arg0.UnlockInfo:completeAnimation()
			f16_arg0.UnlockInfo:setRGB(0.92, 0.92, 0.92)
			f16_arg0.clipFinished(f16_arg0.UnlockInfo)
		end,
	},
	Hidden = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(9)
			f17_arg0.SceneBlur:completeAnimation()
			f17_arg0.SceneBlur:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.SceneBlur)
			f17_arg0.Box:completeAnimation()
			f17_arg0.Box:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Box)
			f17_arg0.DotTiledBacking:completeAnimation()
			f17_arg0.DotTiledBacking:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.DotTiledBacking)
			f17_arg0.ButtonBottomLine9Slice:completeAnimation()
			f17_arg0.ButtonBottomLine9Slice:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ButtonBottomLine9Slice)
			f17_arg0.displayName:completeAnimation()
			f17_arg0.displayName:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.displayName)
			f17_arg0.SetInfo:completeAnimation()
			f17_arg0.SetInfo:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.SetInfo)
			f17_arg0.UnlockInfo:completeAnimation()
			f17_arg0.UnlockInfo:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.UnlockInfo)
			f17_arg0.ButtonTopLine9Slice:completeAnimation()
			f17_arg0.ButtonTopLine9Slice:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ButtonTopLine9Slice)
			f17_arg0.ItemInfoRarityHeader:completeAnimation()
			f17_arg0.ItemInfoRarityHeader:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ItemInfoRarityHeader)
		end,
	},
	AlertMessage = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.displayName:completeAnimation()
			f18_arg0.displayName:setTopBottom(0, 0, 35, 66)
			f18_arg0.clipFinished(f18_arg0.displayName)
			f18_arg0.SetInfo:completeAnimation()
			f18_arg0.SetInfo:setTopBottom(0, 0, 68, 86)
			f18_arg0.clipFinished(f18_arg0.SetInfo)
			f18_arg0.alertMessage:completeAnimation()
			f18_arg0.alertMessage:setTopBottom(0, 0, 127, 145)
			f18_arg0.alertMessage:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.alertMessage)
		end,
	},
	OptionalDescription = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(4)
			f19_arg0.displayName:completeAnimation()
			f19_arg0.displayName:setTopBottom(0, 0, 35, 66)
			f19_arg0.clipFinished(f19_arg0.displayName)
			f19_arg0.SetInfo:completeAnimation()
			f19_arg0.SetInfo:setTopBottom(0, 0, 68, 86)
			f19_arg0.SetInfo:setRGB(0.92, 0.92, 0.92)
			f19_arg0.SetInfo:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.SetInfo)
			f19_arg0.UnlockInfo:completeAnimation()
			f19_arg0.UnlockInfo:setTopBottom(0, 0, 71, 89)
			f19_arg0.UnlockInfo:setRGB(0.92, 0.92, 0.92)
			f19_arg0.clipFinished(f19_arg0.UnlockInfo)
			f19_arg0.Description:completeAnimation()
			f19_arg0.Description:setTopBottom(0, 0, 107, 125)
			f19_arg0.Description:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.Description)
		end,
	},
	CustomEmblemTabSelected = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(9)
			f20_arg0.SceneBlur:completeAnimation()
			f20_arg0.SceneBlur:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SceneBlur)
			f20_arg0.Box:completeAnimation()
			f20_arg0.Box:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Box)
			f20_arg0.DotTiledBacking:completeAnimation()
			f20_arg0.DotTiledBacking:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.DotTiledBacking)
			f20_arg0.ButtonBottomLine9Slice:completeAnimation()
			f20_arg0.ButtonBottomLine9Slice:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ButtonBottomLine9Slice)
			f20_arg0.displayName:completeAnimation()
			f20_arg0.displayName:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.displayName)
			f20_arg0.SetInfo:completeAnimation()
			f20_arg0.SetInfo:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SetInfo)
			f20_arg0.UnlockInfo:completeAnimation()
			f20_arg0.UnlockInfo:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.UnlockInfo)
			f20_arg0.ButtonTopLine9Slice:completeAnimation()
			f20_arg0.ButtonTopLine9Slice:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ButtonTopLine9Slice)
			f20_arg0.ItemInfoRarityHeader:completeAnimation()
			f20_arg0.ItemInfoRarityHeader:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ItemInfoRarityHeader)
		end,
	},
}
CoD.BM_ItemInfoPanel.__onClose = function(f21_arg0)
	f21_arg0.DotTiledBacking:close()
	f21_arg0.displayName:close()
	f21_arg0.SetInfo:close()
	f21_arg0.UnlockInfo:close()
	f21_arg0.Description:close()
	f21_arg0.alertMessage:close()
	f21_arg0.ItemInfoRarityHeader:close()
end
