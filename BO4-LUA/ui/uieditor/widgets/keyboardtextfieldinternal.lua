require("x64:c1c051c71207acb")
require("x64:a5bc9d1de9b04d8")
CoD.KeyboardTextFieldInternal = InheritFrom(LUI.UIElement)
CoD.KeyboardTextFieldInternal.__defaultWidth = 672
CoD.KeyboardTextFieldInternal.__defaultHeight = 384
CoD.KeyboardTextFieldInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KeyboardTextFieldInternal)
	self.id = "KeyboardTextFieldInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local popupBG = LUI.UIImage.new(0, 1, -76, 0, 0, 1, -67, -37)
	popupBG:setRGB(0, 0, 0)
	popupBG:setAlpha(0)
	popupBG:setImage(RegisterImage(0x6440978352789DB))
	self:addElement(popupBG)
	self.popupBG = popupBG
	local bottomFade = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -141, -45)
	bottomFade:setXRot(180)
	bottomFade:setImage(RegisterImage(0xDB6A7927DB7D288))
	self:addElement(bottomFade)
	self.bottomFade = bottomFade
	local middleTile = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 96, 288)
	middleTile:setImage(RegisterImage(0xBCECD4DFF70A017))
	middleTile:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	middleTile:setShaderVector(0, 1, 32, 0, 0)
	middleTile:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(middleTile)
	self.middleTile = middleTile
	local topFade = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 96)
	topFade:setImage(RegisterImage(0xDB6A7927DB7D288))
	self:addElement(topFade)
	self.topFade = topFade
	local bottomPart = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -24, 0)
	bottomPart:setImage(RegisterImage(0xE17B1790A885DBD))
	self:addElement(bottomPart)
	self.bottomPart = bottomPart
	local middleStretch = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 48, -24)
	middleStretch:setImage(RegisterImage(0x1D100BFEEA8C973))
	self:addElement(middleStretch)
	self.middleStretch = middleStretch
	local topPart = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 48)
	topPart:setImage(RegisterImage(0xCDA15E059EDF3D1))
	self:addElement(topPart)
	self.topPart = topPart
	local header = LUI.UIText.new(0, 1, 24, -24, 0, 0, 0, 72)
	header:setText("")
	header:setTTF("default")
	header:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	header:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(header)
	self.header = header
	local inputContainer = CoD.KeyboardTextFieldInputContainer.new(f1_arg0, f1_arg1, 0, 1, 24, -24, 0, 0, 120, 192)
	self:addElement(inputContainer)
	self.inputContainer = inputContainer
	local f1_local10 = nil
	self.confirmButton = LUI.UIElement.createFake()
	local f1_local11 = nil
	self.cancelButton = LUI.UIElement.createFake()
	local f1_local12 = nil
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, true, false, false, false)
	options:setLeftRight(0, 0, 126, 546)
	options:setTopBottom(1, 1, -117.5, -74.5)
	options:setWidgetType(CoD.CommonListButtonGenericShort)
	options:setHorizontalCount(2)
	options:setSpacing(10)
	options:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	options:setDataSource("ClanTagPromptList")
	options:linkToElementModel(options, "disabled", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], "MOUSE1", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x865DD2DB1EFE9F8], 0xD0BB36CD318F55F, nil, "MOUSE1")
			return true
		else
			return false
		end
	end, false)
	self:addElement(options)
	self.options = options
	self:mergeStateConditions({
		{
			stateName = "Campaign",
			condition = function(menu, element, event)
				return IsCampaign()
			end,
		},
	})
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["lobbyRoot.lobbyNav"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	options.id = "options"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local15 = self
	CoD.PCUtility.KeyboardTextFieldFunctionality(self, f1_arg1)
	return self
end
CoD.KeyboardTextFieldInternal.__resetProperties = function(f8_arg0)
	f8_arg0.popupBG:completeAnimation()
	f8_arg0.bottomFade:completeAnimation()
	f8_arg0.middleTile:completeAnimation()
	f8_arg0.topFade:completeAnimation()
	f8_arg0.middleStretch:completeAnimation()
	f8_arg0.topPart:completeAnimation()
	f8_arg0.bottomPart:completeAnimation()
	f8_arg0.popupBG:setAlpha(0)
	f8_arg0.bottomFade:setAlpha(1)
	f8_arg0.middleTile:setAlpha(1)
	f8_arg0.topFade:setAlpha(1)
	f8_arg0.middleStretch:setAlpha(1)
	f8_arg0.topPart:setAlpha(1)
	f8_arg0.bottomPart:setAlpha(1)
end
CoD.KeyboardTextFieldInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Campaign = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(7)
			f10_arg0.popupBG:completeAnimation()
			f10_arg0.popupBG:setAlpha(0.9)
			f10_arg0.clipFinished(f10_arg0.popupBG)
			f10_arg0.bottomFade:completeAnimation()
			f10_arg0.bottomFade:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.bottomFade)
			f10_arg0.middleTile:completeAnimation()
			f10_arg0.middleTile:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.middleTile)
			f10_arg0.topFade:completeAnimation()
			f10_arg0.topFade:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.topFade)
			f10_arg0.bottomPart:completeAnimation()
			f10_arg0.bottomPart:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.bottomPart)
			f10_arg0.middleStretch:completeAnimation()
			f10_arg0.middleStretch:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.middleStretch)
			f10_arg0.topPart:completeAnimation()
			f10_arg0.topPart:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.topPart)
		end,
	},
}
CoD.KeyboardTextFieldInternal.__onClose = function(f11_arg0)
	f11_arg0.inputContainer:close()
	f11_arg0.confirmButton:close()
	f11_arg0.cancelButton:close()
	f11_arg0.options:close()
end
