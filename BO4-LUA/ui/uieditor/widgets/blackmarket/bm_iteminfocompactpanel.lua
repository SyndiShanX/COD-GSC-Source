require("x64:3096a20718bc809")
require("x64:19c1945d2e472b0")
CoD.BM_ItemInfoCompactPanel = InheritFrom(LUI.UIElement)
CoD.BM_ItemInfoCompactPanel.__defaultWidth = 540
CoD.BM_ItemInfoCompactPanel.__defaultHeight = 125
CoD.BM_ItemInfoCompactPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_ItemInfoCompactPanel)
	self.id = "BM_ItemInfoCompactPanel"
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
	local ButtonBottomLine9Slice = LUI.UIImage.new(0, 1, -6, 6, 1, 1, -6.5, 13.5)
	ButtonBottomLine9Slice:setAlpha(0.25)
	ButtonBottomLine9Slice:setImage(RegisterImage(0xC752149A1FA1AAE))
	ButtonBottomLine9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	ButtonBottomLine9Slice:setShaderVector(0, 0, 0, 0, 0)
	ButtonBottomLine9Slice:setupNineSliceShader(120, 10)
	self:addElement(ButtonBottomLine9Slice)
	self.ButtonBottomLine9Slice = ButtonBottomLine9Slice
	local UnlockInfo = LUI.UIText.new(0, 0, 22, 518, 0, 0, 38, 56)
	UnlockInfo:setRGB(0.92, 0.92, 0.92)
	UnlockInfo:setTTF("dinnext_regular")
	UnlockInfo:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	UnlockInfo:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	UnlockInfo:linkToElementModel(self, "unlockInfo", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			UnlockInfo:setText(f2_local0)
		end
	end)
	self:addElement(UnlockInfo)
	self.UnlockInfo = UnlockInfo
	local alertMessage = LUI.UIText.new(0, 0, 22, 518, 0, 0, 99, 117)
	alertMessage:setRGB(ColorSet.T8__RED.r, ColorSet.T8__RED.g, ColorSet.T8__RED.b)
	alertMessage:setAlpha(0)
	alertMessage:setTTF("ttmussels_demibold")
	alertMessage:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	alertMessage:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	alertMessage:linkToElementModel(self, "alertMessage", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			alertMessage:setText(f3_local0)
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
				local f5_local0
				if not CoD.ModelUtility.IsSelfModelNil(element, f1_arg1) then
					f5_local0 = CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "alertMessage")
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelNil(element, f1_arg1)
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_ItemInfoCompactPanel.__resetProperties = function(f9_arg0)
	f9_arg0.UnlockInfo:completeAnimation()
	f9_arg0.ItemInfoRarityHeader:completeAnimation()
	f9_arg0.ButtonTopLine9Slice:completeAnimation()
	f9_arg0.alertMessage:completeAnimation()
	f9_arg0.ButtonBottomLine9Slice:completeAnimation()
	f9_arg0.DotTiledBacking:completeAnimation()
	f9_arg0.Box:completeAnimation()
	f9_arg0.SceneBlur:completeAnimation()
	f9_arg0.UnlockInfo:setRGB(0.92, 0.92, 0.92)
	f9_arg0.UnlockInfo:setAlpha(1)
	f9_arg0.ItemInfoRarityHeader:setAlpha(1)
	f9_arg0.ButtonTopLine9Slice:setAlpha(0.25)
	f9_arg0.alertMessage:setTopBottom(0, 0, 99, 117)
	f9_arg0.alertMessage:setAlpha(0)
	f9_arg0.ButtonBottomLine9Slice:setAlpha(0.25)
	f9_arg0.DotTiledBacking:setAlpha(0.15)
	f9_arg0.Box:setAlpha(0.01)
	f9_arg0.SceneBlur:setAlpha(1)
end
CoD.BM_ItemInfoCompactPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(8)
			f10_arg0.SceneBlur:completeAnimation()
			f10_arg0.SceneBlur:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.SceneBlur)
			f10_arg0.Box:completeAnimation()
			f10_arg0.Box:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Box)
			f10_arg0.DotTiledBacking:completeAnimation()
			f10_arg0.DotTiledBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DotTiledBacking)
			f10_arg0.ButtonBottomLine9Slice:completeAnimation()
			f10_arg0.ButtonBottomLine9Slice:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ButtonBottomLine9Slice)
			f10_arg0.UnlockInfo:completeAnimation()
			f10_arg0.UnlockInfo:setRGB(0.92, 0.92, 0.92)
			f10_arg0.UnlockInfo:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.UnlockInfo)
			f10_arg0.alertMessage:completeAnimation()
			f10_arg0.alertMessage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.alertMessage)
			f10_arg0.ButtonTopLine9Slice:completeAnimation()
			f10_arg0.ButtonTopLine9Slice:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ButtonTopLine9Slice)
			f10_arg0.ItemInfoRarityHeader:completeAnimation()
			f10_arg0.ItemInfoRarityHeader:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ItemInfoRarityHeader)
		end,
	},
	AlertMessage = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.alertMessage:completeAnimation()
			f11_arg0.alertMessage:setTopBottom(0, 0, 127, 145)
			f11_arg0.alertMessage:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.alertMessage)
		end,
	},
	Shown = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.UnlockInfo:completeAnimation()
			f12_arg0.UnlockInfo:setRGB(0.92, 0.92, 0.92)
			f12_arg0.clipFinished(f12_arg0.UnlockInfo)
		end,
	},
}
CoD.BM_ItemInfoCompactPanel.__onClose = function(f13_arg0)
	f13_arg0.DotTiledBacking:close()
	f13_arg0.UnlockInfo:close()
	f13_arg0.alertMessage:close()
	f13_arg0.ItemInfoRarityHeader:close()
end
