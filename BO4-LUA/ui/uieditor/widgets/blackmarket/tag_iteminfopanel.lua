require("x64:3096a20718bc809")
require("x64:19c1945d2e472b0")
CoD.Tag_ItemInfoPanel = InheritFrom(LUI.UIElement)
CoD.Tag_ItemInfoPanel.__defaultWidth = 540
CoD.Tag_ItemInfoPanel.__defaultHeight = 150
CoD.Tag_ItemInfoPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Tag_ItemInfoPanel)
	self.id = "Tag_ItemInfoPanel"
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
	local alertMessage = LUI.UIText.new(0, 0, 22, 518, 0, 0, 127, 145)
	alertMessage:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	alertMessage:setAlpha(0)
	alertMessage:setTTF("ttmussels_demibold")
	alertMessage:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	alertMessage:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	alertMessage:linkToElementModel(self, "alertMessage", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			alertMessage:setText(f5_local0)
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
			stateName = "AlertMessage",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "alertMessage")
			end,
		},
	})
	self:linkToElementModel(self, "alertMessage", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "alertMessage",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Tag_ItemInfoPanel.__resetProperties = function(f9_arg0)
	f9_arg0.UnlockInfo:completeAnimation()
	f9_arg0.SetInfo:completeAnimation()
	f9_arg0.displayName:completeAnimation()
	f9_arg0.alertMessage:completeAnimation()
	f9_arg0.UnlockInfo:setRGB(0.92, 0.92, 0.92)
	f9_arg0.SetInfo:setTopBottom(0, 0, 68, 86)
	f9_arg0.SetInfo:setRGB(0.92, 0.92, 0.92)
	f9_arg0.displayName:setTopBottom(0, 0, 35, 66)
	f9_arg0.alertMessage:setTopBottom(0, 0, 127, 145)
	f9_arg0.alertMessage:setAlpha(0)
end
CoD.Tag_ItemInfoPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.displayName:completeAnimation()
			f10_arg0.displayName:setTopBottom(0, 0, 35, 66)
			f10_arg0.clipFinished(f10_arg0.displayName)
			f10_arg0.SetInfo:completeAnimation()
			f10_arg0.SetInfo:setTopBottom(0, 0, 68, 86)
			f10_arg0.SetInfo:setRGB(0.92, 0.92, 0.92)
			f10_arg0.clipFinished(f10_arg0.SetInfo)
			f10_arg0.UnlockInfo:completeAnimation()
			f10_arg0.UnlockInfo:setRGB(0.92, 0.92, 0.92)
			f10_arg0.clipFinished(f10_arg0.UnlockInfo)
		end,
	},
	AlertMessage = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.displayName:completeAnimation()
			f11_arg0.displayName:setTopBottom(0, 0, 35, 66)
			f11_arg0.clipFinished(f11_arg0.displayName)
			f11_arg0.SetInfo:completeAnimation()
			f11_arg0.SetInfo:setTopBottom(0, 0, 68, 86)
			f11_arg0.clipFinished(f11_arg0.SetInfo)
			f11_arg0.alertMessage:completeAnimation()
			f11_arg0.alertMessage:setTopBottom(0, 0, 127, 145)
			f11_arg0.alertMessage:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.alertMessage)
		end,
	},
}
CoD.Tag_ItemInfoPanel.__onClose = function(f12_arg0)
	f12_arg0.DotTiledBacking:close()
	f12_arg0.displayName:close()
	f12_arg0.SetInfo:close()
	f12_arg0.UnlockInfo:close()
	f12_arg0.alertMessage:close()
	f12_arg0.ItemInfoRarityHeader:close()
end
