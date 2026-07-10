require("x64:8cd770250906213")
require("x64:63355d9a3377f1d")
CoD.StoreRightPane = InheritFrom(LUI.UIElement)
CoD.StoreRightPane.__defaultWidth = 582
CoD.StoreRightPane.__defaultHeight = 789
CoD.StoreRightPane.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StoreRightPane)
	self.id = "StoreRightPane"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BoxButtonLrgInactive = CoD.cac_ButtonBoxLrgInactive.new(f1_arg0, f1_arg1, 0, 1, -3, 3, 0, 1, -3, 3)
	self:addElement(BoxButtonLrgInactive)
	self.BoxButtonLrgInactive = BoxButtonLrgInactive
	local productDescBg = LUI.UIImage.new(0, 1, 2, -2, 1, 1, -406, 0)
	productDescBg:setRGB(0, 0, 0)
	productDescBg:setAlpha(0.8)
	self:addElement(productDescBg)
	self.productDescBg = productDescBg
	local frameWidget = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	frameWidget:setLeftRight(0, 0, 2, 581)
	frameWidget:setTopBottom(0, 0, 1, 382)
	self:addElement(frameWidget)
	self.frameWidget = frameWidget
	local verticalScrollingTextBox = CoD.verticalScrollingTextBox.new(f1_arg0, f1_arg1, 0, 0, 24, 537, 0, 0, 410, 762)
	verticalScrollingTextBox:linkToElementModel(self, "desc", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			verticalScrollingTextBox.textBox.text:setText(f2_local0)
		end
	end)
	self:addElement(verticalScrollingTextBox)
	self.verticalScrollingTextBox = verticalScrollingTextBox
	local featlineleft = LUI.UIImage.new(0, 0, 293, 299, 0, 0, 82, 685)
	featlineleft:setZRot(-90)
	featlineleft:setImage(RegisterImage(@"uie_t7_menu_frontend_featuredlline"))
	featlineleft:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(featlineleft)
	self.featlineleft = featlineleft
	local ArrowSide0 = LUI.UIImage.new(0.5, 0.5, 260, 268, 0.5, 0.5, 359, 375)
	ArrowSide0:setZRot(-90)
	ArrowSide0:setImage(RegisterImage(@"uie_t7_mp_hud_scorestreak_arrowhorz"))
	self:addElement(ArrowSide0)
	self.ArrowSide0 = ArrowSide0
	local ArrowSide00 = LUI.UIImage.new(0.5, 0.5, 260, 268, 0.5, 0.5, 11, 27)
	ArrowSide00:setZRot(90)
	ArrowSide00:setImage(RegisterImage(@"uie_t7_mp_hud_scorestreak_arrowhorz"))
	self:addElement(ArrowSide00)
	self.ArrowSide00 = ArrowSide00
	self.frameWidget:linkToElementModel(self, nil, false, function(model)
		frameWidget:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return HideProductNameAndDesc()
			end,
		},
	})
	frameWidget.id = "frameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StoreRightPane.__resetProperties = function(f5_arg0)
	f5_arg0.ArrowSide00:completeAnimation()
	f5_arg0.ArrowSide0:completeAnimation()
	f5_arg0.featlineleft:completeAnimation()
	f5_arg0.verticalScrollingTextBox:completeAnimation()
	f5_arg0.productDescBg:completeAnimation()
	f5_arg0.BoxButtonLrgInactive:completeAnimation()
	f5_arg0.ArrowSide00:setAlpha(1)
	f5_arg0.ArrowSide0:setAlpha(1)
	f5_arg0.featlineleft:setAlpha(1)
	f5_arg0.verticalScrollingTextBox:setAlpha(1)
	f5_arg0.productDescBg:setAlpha(0.8)
	f5_arg0.BoxButtonLrgInactive:setAlpha(1)
end
CoD.StoreRightPane.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hide = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(6)
			f7_arg0.BoxButtonLrgInactive:completeAnimation()
			f7_arg0.BoxButtonLrgInactive:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.BoxButtonLrgInactive)
			f7_arg0.productDescBg:completeAnimation()
			f7_arg0.productDescBg:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.productDescBg)
			f7_arg0.verticalScrollingTextBox:completeAnimation()
			f7_arg0.verticalScrollingTextBox:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.verticalScrollingTextBox)
			f7_arg0.featlineleft:completeAnimation()
			f7_arg0.featlineleft:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.featlineleft)
			f7_arg0.ArrowSide0:completeAnimation()
			f7_arg0.ArrowSide0:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ArrowSide0)
			f7_arg0.ArrowSide00:completeAnimation()
			f7_arg0.ArrowSide00:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.ArrowSide00)
		end,
	},
}
CoD.StoreRightPane.__onClose = function(f8_arg0)
	f8_arg0.BoxButtonLrgInactive:close()
	f8_arg0.frameWidget:close()
	f8_arg0.verticalScrollingTextBox:close()
end
