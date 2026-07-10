require("x64:12d199c0b6f6540")
require("x64:2f72126533b6116")
CoD.SpecialistDecalSelector = InheritFrom(LUI.UIElement)
CoD.SpecialistDecalSelector.__defaultWidth = 540
CoD.SpecialistDecalSelector.__defaultHeight = 150
CoD.SpecialistDecalSelector.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistDecalSelector)
	self.id = "SpecialistDecalSelector"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local chooseDecal = LUI.UIText.new(0, 1, 0, 0, 1, 1, -25, 0)
	chooseDecal:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	chooseDecal:setText(LocalizeToUpperString(0xB78039C7686605D))
	chooseDecal:setTTF("default")
	chooseDecal:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	chooseDecal:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(chooseDecal)
	self.chooseDecal = chooseDecal
	local leftLine = LUI.UIImage.new(0, 0.45, 0, 0, 1, 1, -46, -45)
	leftLine:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(leftLine)
	self.leftLine = leftLine
	local rightLine = LUI.UIImage.new(0.55, 1, 0, 0, 1, 1, -46, -45)
	rightLine:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(rightLine)
	self.rightLine = rightLine
	local prompt = CoD.JoinButtonPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -19.5, 19.5, 1, 1, -66, -27)
	prompt:setScale(0.9, 0.9)
	prompt.KMprompt:setText(CoD.BaseUtility.AlreadyLocalized("[{ui_contextual_2}]"))
	prompt:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			prompt.GpadButtonImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(prompt)
	self.prompt = prompt
	local decals = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 5, 0, nil, nil, true, false, false, false)
	decals:setLeftRight(0, 0, 3, 538)
	decals:setTopBottom(1, 1, -246, -71)
	decals:setWidgetType(CoD.SpecialistDecalEntry)
	decals:setHorizontalCount(6)
	decals:setVerticalCount(2)
	decals:setSpacing(5)
	decals:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	decals:linkToElementModel(self, "decalDataSourceName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			decals:setDataSource(f3_local0)
		end
	end)
	decals:registerEventHandler("list_active_changed", function(element, event)
		local f4_local0 = nil
		CoD.BreadcrumbUtility.SetSpecialistOutfitItemAsOld(f1_arg0, element, f1_arg1)
		return f4_local0
	end)
	decals:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(decals, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsPC() then
			SetCurrentElementAsActive(self, element, controller)
			CoD.PlayerRoleUtility.UpdatePersonalizeSpecialistOutfitItem(controller, element)
			CoD.PlayerRoleUtility.EquipOutfitItem(menu, controller, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
			return false
		else
			return false
		end
	end, false)
	self:addElement(decals)
	self.decals = decals
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, f1_arg1, "decalDataSourceName")
			end,
		},
	})
	self:linkToElementModel(self, "decalDataSourceName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "decalDataSourceName",
		})
	end)
	decals.id = "decals"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistDecalSelector.__resetProperties = function(f10_arg0)
	f10_arg0.decals:completeAnimation()
	f10_arg0.prompt:completeAnimation()
	f10_arg0.rightLine:completeAnimation()
	f10_arg0.leftLine:completeAnimation()
	f10_arg0.chooseDecal:completeAnimation()
	f10_arg0.decals:setAlpha(1)
	f10_arg0.prompt:setAlpha(1)
	f10_arg0.rightLine:setAlpha(1)
	f10_arg0.leftLine:setAlpha(1)
	f10_arg0.chooseDecal:setAlpha(1)
end
CoD.SpecialistDecalSelector.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			f12_arg0.chooseDecal:completeAnimation()
			f12_arg0.chooseDecal:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.chooseDecal)
			f12_arg0.leftLine:completeAnimation()
			f12_arg0.leftLine:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.leftLine)
			f12_arg0.rightLine:completeAnimation()
			f12_arg0.rightLine:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.rightLine)
			f12_arg0.prompt:completeAnimation()
			f12_arg0.prompt:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.prompt)
			f12_arg0.decals:completeAnimation()
			f12_arg0.decals:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.decals)
		end,
	},
}
CoD.SpecialistDecalSelector.__onClose = function(f13_arg0)
	f13_arg0.prompt:close()
	f13_arg0.decals:close()
end
