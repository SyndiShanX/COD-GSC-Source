require("x64:e272191e46af824")
require("x64:4dd810316f738ee")
CoD.BM_Bribe_Widget = InheritFrom(LUI.UIElement)
CoD.BM_Bribe_Widget.__defaultWidth = 270
CoD.BM_Bribe_Widget.__defaultHeight = 144
CoD.BM_Bribe_Widget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_Bribe_Widget)
	self.id = "BM_Bribe_Widget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ButtonImage = LUI.UIFixedAspectRatioImage.new(0, 0, 0, 270, 0, 0, 0, 144)
	ButtonImage:setStretchedDimension(6)
	self:addElement(ButtonImage)
	self.ButtonImage = ButtonImage
	local TitleBackground = LUI.UIImage.new(0, 0, 0, 198, 0, 0, -0.5, 27.5)
	TitleBackground:setRGB(ColorSet.BadgeText.r, ColorSet.BadgeText.g, ColorSet.BadgeText.b)
	self:addElement(TitleBackground)
	self.TitleBackground = TitleBackground
	local BribeName = LUI.UIText.new(0, 0, 3.5, 197.5, 0, 0, 0, 28)
	BribeName:setTTF("default")
	BribeName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	BribeName:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	BribeName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BribeName:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(BribeName)
	self.BribeName = BribeName
	local ItemHintText = CoD.CommonToolTip.new(f1_arg0, f1_arg1, 0.5, 0.5, -115, 115, 1, 1, 0, 45)
	ItemHintText:mergeStateConditions({
		{
			stateName = "Mouse",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "CenterAlign",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	ItemHintText:setAlpha(0)
	ItemHintText:linkToElementModel(self, "desc", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ItemHintText.textCenterAlign:setText(Engine[0xF9F1239CFD921FE](f6_local0))
		end
	end)
	self:addElement(ItemHintText)
	self.ItemHintText = ItemHintText
	local FocusBorder = LUI.UIImage.new(-0.01, 1.01, -4.5, 3.5, -0, 1, -4, 4)
	FocusBorder:setRGB(1, 0.75, 0.47)
	FocusBorder:setAlpha(0)
	FocusBorder:setScale(1, 1.01)
	FocusBorder:setImage(RegisterImage(0xCB07CCC28498CB2))
	FocusBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FocusBorder:setShaderVector(0, 0, 0, 0, 0)
	FocusBorder:setupNineSliceShader(18, 18)
	self:addElement(FocusBorder)
	self.FocusBorder = FocusBorder
	local ContractCost = CoD.ContractItemCost.new(f1_arg0, f1_arg1, 0.5, 0.5, -92.5, 92.5, 1, 1, -31.5, -10.5)
	ContractCost.Free:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ContractCost.ContractCost:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ContractCost:linkToElementModel(self, nil, false, function(model)
		ContractCost:setModel(model, f1_arg1)
	end)
	self:addElement(ContractCost)
	self.ContractCost = ContractCost
	self.ButtonImage:linkToElementModel(self, "buttonImage", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ButtonImage:setImage(RegisterImage(f8_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_Bribe_Widget.__resetProperties = function(f9_arg0)
	f9_arg0.ItemHintText:completeAnimation()
	f9_arg0.FocusBorder:completeAnimation()
	f9_arg0.ItemHintText:setAlpha(0)
	f9_arg0.FocusBorder:setAlpha(0)
end
CoD.BM_Bribe_Widget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.ItemHintText:completeAnimation()
			f11_arg0.ItemHintText:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.ItemHintText)
			f11_arg0.FocusBorder:completeAnimation()
			f11_arg0.FocusBorder:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.FocusBorder)
		end,
	},
}
CoD.BM_Bribe_Widget.__onClose = function(f12_arg0)
	f12_arg0.ButtonImage:close()
	f12_arg0.BribeName:close()
	f12_arg0.ItemHintText:close()
	f12_arg0.ContractCost:close()
end
