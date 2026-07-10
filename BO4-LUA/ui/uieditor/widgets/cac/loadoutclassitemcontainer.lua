require("x64:b8f158fc5a82d1b")
require("x64:6cebf5e7d0d5c7d")
require("x64:b7436bffe7fccf1")
CoD.LoadoutClassItemContainer = InheritFrom(LUI.UIElement)
CoD.LoadoutClassItemContainer.__defaultWidth = 346
CoD.LoadoutClassItemContainer.__defaultHeight = 204
CoD.LoadoutClassItemContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadoutClassItemContainer)
	self.id = "LoadoutClassItemContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponVariantTriggers = CoD.WeaponVariantTriggers.new(f1_arg0, f1_arg1, 0.5, 0.5, -173.5, 172.5, 0, 0, 170, 204)
	WeaponVariantTriggers:setAlpha(0)
	WeaponVariantTriggers:linkToElementModel(self, nil, false, function(model)
		WeaponVariantTriggers:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(WeaponVariantTriggers, "childFocusGained", function(element)
		if IsPC() then
			SetProperty(self, "__hasFocusOnVariantWidget", true)
			UpdateAllMenuButtonPrompts(f1_arg0, f1_arg1)
		end
	end)
	self:addElement(WeaponVariantTriggers)
	self.WeaponVariantTriggers = WeaponVariantTriggers
	local LoadoutClassItemContainerInternal = CoD.LoadoutClassItemContainerInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, -34)
	LoadoutClassItemContainerInternal:linkToElementModel(self, nil, false, function(model)
		LoadoutClassItemContainerInternal:setModel(model, f1_arg1)
	end)
	LoadoutClassItemContainerInternal:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f5_arg0, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
	end)
	local f1_local3 = LoadoutClassItemContainerInternal
	local VariantList = LoadoutClassItemContainerInternal.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	VariantList(f1_local3, f1_local5.LastInput, function(f6_arg0, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
	end, false)
	LoadoutClassItemContainerInternal:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		if IsPC() then
			SetProperty(self, "__hasFocusOnVariantWidget", false)
			UpdateAllMenuButtonPrompts(f1_arg0, f1_arg1)
		else
			CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F])
		end
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(LoadoutClassItemContainerInternal, f1_arg1, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], "ui_copylayer", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and IsInDefaultState(self) then
			CoD.GridAndListUtility.NavigateGridItem(self.VariantList, controller, true)
			CoD.CACUtility.SetSignatureWeaponFromCAC(self.VariantList, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and IsInDefaultState(self) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x6CE8023188D673F], 0x53D10BEF28D6E73, Enum[0xBEBDBAEEB3ECCCA][0xB6372335C630AD3], "ui_copylayer")
			return true
		else
			return false
		end
	end, false)
	self:addElement(LoadoutClassItemContainerInternal)
	self.LoadoutClassItemContainerInternal = LoadoutClassItemContainerInternal
	VariantList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, true, false, false, false)
	VariantList:setLeftRight(0, 0, 4, 182)
	VariantList:setTopBottom(0, 0, -25, -9)
	VariantList:setAlpha(0)
	VariantList:setWidgetType(CoD.WeaponVariantPip)
	VariantList:setHorizontalCount(10)
	VariantList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	VariantList:linkToElementModel(self, "variantList", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			VariantList:setDataSource(f10_local0)
		end
	end)
	self:addElement(VariantList)
	self.VariantList = VariantList
	self:mergeStateConditions({
		{
			stateName = "NoVariants",
			condition = function(menu, element, event)
				return not CoD.GridAndListUtility.ListElementHasAtLeastNumElements(self.VariantList, 2)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f12_arg0, f12_arg1)
		f12_arg1.menu = f12_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f12_arg1)
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], "MWHEELUP", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItem(self.VariantList, controller, false)
			CoD.CACUtility.SetSignatureWeaponFromCAC(self.VariantList, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xD2F467A6C6DA1AC], 0x0, nil, "MWHEELUP")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], "MWHEELDOWN", function(element, menu, controller, model)
		if not IsRepeatButtonPress(model) then
			CoD.GridAndListUtility.NavigateGridItem(self.VariantList, controller, true)
			CoD.CACUtility.SetSignatureWeaponFromCAC(self.VariantList, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsRepeatButtonPress(nil) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA], 0x0, nil, "MWHEELDOWN")
			return false
		else
			return false
		end
	end, false)
	WeaponVariantTriggers.id = "WeaponVariantTriggers"
	LoadoutClassItemContainerInternal.id = "LoadoutClassItemContainerInternal"
	VariantList.id = "VariantList"
	self.__defaultFocus = LoadoutClassItemContainerInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = VariantList
	if IsPC() then
		SetElementProperty(f1_local3, "__loopOnSameRow", true)
	end
	return self
end
CoD.LoadoutClassItemContainer.__resetProperties = function(f17_arg0)
	f17_arg0.WeaponVariantTriggers:completeAnimation()
	f17_arg0.WeaponVariantTriggers:setAlpha(0)
end
CoD.LoadoutClassItemContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.WeaponVariantTriggers:completeAnimation()
			f19_arg0.WeaponVariantTriggers:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.WeaponVariantTriggers)
		end,
		GainChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.WeaponVariantTriggers:beginAnimation(200)
				f20_arg0.WeaponVariantTriggers:setAlpha(1)
				f20_arg0.WeaponVariantTriggers:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.WeaponVariantTriggers:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.WeaponVariantTriggers:completeAnimation()
			f20_arg0.WeaponVariantTriggers:setAlpha(0)
			f20_local0(f20_arg0.WeaponVariantTriggers)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.WeaponVariantTriggers:beginAnimation(200)
				f22_arg0.WeaponVariantTriggers:setAlpha(0)
				f22_arg0.WeaponVariantTriggers:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.WeaponVariantTriggers:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.WeaponVariantTriggers:completeAnimation()
			f22_arg0.WeaponVariantTriggers:setAlpha(1)
			f22_local0(f22_arg0.WeaponVariantTriggers)
		end,
	},
	NoVariants = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.LoadoutClassItemContainer.__onClose = function(f25_arg0)
	f25_arg0.WeaponVariantTriggers:close()
	f25_arg0.LoadoutClassItemContainerInternal:close()
	f25_arg0.VariantList:close()
end
