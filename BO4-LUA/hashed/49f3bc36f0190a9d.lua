require("x64:f6482b855bfca9f")
require("x64:52213f4cb2c008")
CoD.WeaponPersonalizeSlot = InheritFrom(LUI.UIElement)
CoD.WeaponPersonalizeSlot.__defaultWidth = 152
CoD.WeaponPersonalizeSlot.__defaultHeight = 152
CoD.WeaponPersonalizeSlot.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponPersonalizeSlot)
	self.id = "WeaponPersonalizeSlot"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponPersonalizationItem = CoD.WeaponPersonalizeSlotInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	WeaponPersonalizationItem:linkToElementModel(self, nil, false, function(model)
		WeaponPersonalizationItem:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponPersonalizationItem)
	self.WeaponPersonalizationItem = WeaponPersonalizationItem
	local ButtonName = LUI.UIText.new(0, 1, 0, 0, 0, 0, -21, -5)
	ButtonName:setRGB(0.63, 0.62, 0.61)
	ButtonName:setText(Engine[0xF9F1239CFD921FE](0xFA6E6FE616EF67))
	ButtonName:setTTF("ttmussels_regular")
	ButtonName:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	ButtonName:setLetterSpacing(3)
	ButtonName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(ButtonName)
	self.ButtonName = ButtonName
	local newIcon = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 1, 1, 5, 23, 0, 0, -1, 17)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsLive() and CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
			end,
		},
	})
	local f1_local4 = newIcon
	local f1_local5 = newIcon.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNetworkMode"], function(f4_arg0)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local4 = newIcon
	f1_local5 = newIcon.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	newIcon:linkToElementModel(newIcon, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	self:addElement(newIcon)
	self.newIcon = newIcon
	WeaponPersonalizationItem.id = "WeaponPersonalizationItem"
	self.__defaultFocus = WeaponPersonalizationItem
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponPersonalizeSlot.__resetProperties = function(f7_arg0)
	f7_arg0.WeaponPersonalizationItem:completeAnimation()
	f7_arg0.ButtonName:completeAnimation()
	f7_arg0.newIcon:completeAnimation()
	f7_arg0.WeaponPersonalizationItem:setAlpha(1)
	f7_arg0.ButtonName:setAlpha(1)
	f7_arg0.newIcon:setAlpha(1)
end
CoD.WeaponPersonalizeSlot.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.WeaponPersonalizationItem:completeAnimation()
			f9_arg0.WeaponPersonalizationItem:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.WeaponPersonalizationItem)
			f9_arg0.ButtonName:completeAnimation()
			f9_arg0.ButtonName:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ButtonName)
			f9_arg0.newIcon:completeAnimation()
			f9_arg0.newIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.newIcon)
		end,
	},
}
CoD.WeaponPersonalizeSlot.__onClose = function(f10_arg0)
	f10_arg0.WeaponPersonalizationItem:close()
	f10_arg0.newIcon:close()
end
