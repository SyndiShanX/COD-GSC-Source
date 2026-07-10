require("x64:c92e584d9cb1860")
CoD.WZPersonalizeWeapon_ItemGridButton = InheritFrom(LUI.UIElement)
CoD.WZPersonalizeWeapon_ItemGridButton.__defaultWidth = 292
CoD.WZPersonalizeWeapon_ItemGridButton.__defaultHeight = 146
CoD.WZPersonalizeWeapon_ItemGridButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "weaponSelectItemIndex", 0)
	self:setClass(CoD.WZPersonalizeWeapon_ItemGridButton)
	self.id = "WZPersonalizeWeapon_ItemGridButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WZItem = CoD.WZPersonalizeWeapon_AttachmentSlot.new(f1_arg0, f1_arg1, 0, 0, 0, 292, 0, 0, 0, 146)
	WZItem:mergeStateConditions({
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "LootNotOwned",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsPersonalizationLockedForWeapon(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsItemEquippedInCurrentSlot(menu, element, f1_arg1)
			end,
		},
	})
	WZItem:linkToElementModel(WZItem, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(WZItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	WZItem:linkToElementModel(WZItem, "itemIndex", true, function(model)
		f1_arg0:updateElementState(WZItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	WZItem:linkToElementModel(self, nil, false, function(model)
		WZItem:setModel(model, f1_arg1)
	end)
	WZItem.AttachmentImage.__Image = function(f8_arg0)
		local f8_local0 = f8_arg0:get()
		if f8_local0 ~= nil then
			WZItem.AttachmentImage:setImage(CoD.BaseUtility.AlreadyRegistered(CoD.WZUtility.GetEquippedSignatureWeaponImage(self:getModel(), f1_arg1, f8_local0)))
		end
	end
	WZItem:linkToElementModel(self, "itemIndex", true, WZItem.AttachmentImage.__Image)
	WZItem.AttachmentImage.__Image_FullPath = function()
		local f9_local0 = self:getModel()
		if f9_local0 then
			f9_local0 = self:getModel()
			f9_local0 = f9_local0.itemIndex
		end
		if f9_local0 then
			WZItem.AttachmentImage.__Image(f9_local0)
		end
	end
	WZItem.AttachmentName.__Name = function(f10_arg0)
		local f10_local0 = f10_arg0:get()
		if f10_local0 ~= nil then
			WZItem.AttachmentName:setText(LocalizeToUpperString(CoD.WZUtility.GetEquippedSignatureWeaponName(self:getModel(), f1_arg1, f10_local0)))
		end
	end
	WZItem:linkToElementModel(self, "itemIndex", true, WZItem.AttachmentName.__Name)
	WZItem.AttachmentName.__Name_FullPath = function()
		local f11_local0 = self:getModel()
		if f11_local0 then
			f11_local0 = self:getModel()
			f11_local0 = f11_local0.itemIndex
		end
		if f11_local0 then
			WZItem.AttachmentName.__Name(f11_local0)
		end
	end
	WZItem:linkToElementModel(self, nil, false, function(model)
		WZItem.ItemHintTextBreadcrumb:setModel(model, f1_arg1)
	end)
	WZItem:linkToElementModel(self, nil, false, function(model)
		WZItem.ItemHintTextBreadcrumb.Breadcrumb:setModel(model, f1_arg1)
	end)
	self:addElement(WZItem)
	self.WZItem = WZItem
	local f1_local2 = WZItem
	local f1_local3 = WZItem.subscribeToModel
	local f1_local4 = DataSources.WeaponPersonalization.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.listUpdate, WZItem.AttachmentImage.__Image_FullPath)
	WZItem:linkToElementModel(self, "useVariantSlot", true, WZItem.AttachmentImage.__Image_FullPath)
	WZItem:linkToElementModel(self, "image", true, WZItem.AttachmentImage.__Image_FullPath)
	f1_local2 = WZItem
	f1_local3 = WZItem.subscribeToModel
	f1_local4 = DataSources.WeaponPersonalization.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.listUpdate, WZItem.AttachmentName.__Name_FullPath)
	WZItem:linkToElementModel(self, "useVariantSlot", true, WZItem.AttachmentName.__Name_FullPath)
	WZItem:linkToElementModel(self, "displayName", true, WZItem.AttachmentName.__Name_FullPath)
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.BaseUtility.SetControllerModelToSelfModelValue(f1_arg1, element, "weaponSelectItemIndex", "itemIndex")
	end)
	self:linkToElementModel(self, "itemIndex", true, function(model)
		SetElementProperty(self, "_itemIndex", model:get())
	end)
	WZItem.id = "WZItem"
	self.__defaultFocus = WZItem
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	if IsPC() then
		CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	end
	return self
end
CoD.WZPersonalizeWeapon_ItemGridButton.__resetProperties = function(f18_arg0)
	f18_arg0.WZItem:completeAnimation()
	f18_arg0.WZItem:setScale(1, 1)
end
CoD.WZPersonalizeWeapon_ItemGridButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.WZItem:completeAnimation()
			f20_arg0.WZItem:setScale(1.05, 1.05)
			f20_arg0.clipFinished(f20_arg0.WZItem)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			local f21_local0 = function(f22_arg0)
				f21_arg0.WZItem:beginAnimation(200)
				f21_arg0.WZItem:setScale(1.05, 1.05)
				f21_arg0.WZItem:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.WZItem:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.WZItem:completeAnimation()
			f21_arg0.WZItem:setScale(1, 1)
			f21_local0(f21_arg0.WZItem)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.WZItem:beginAnimation(200)
				f23_arg0.WZItem:setScale(1, 1)
				f23_arg0.WZItem:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.WZItem:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.WZItem:completeAnimation()
			f23_arg0.WZItem:setScale(1.05, 1.05)
			f23_local0(f23_arg0.WZItem)
		end,
	},
	PC = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
	Equipped = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WZPersonalizeWeapon_ItemGridButton.__onClose = function(f27_arg0)
	f27_arg0.WZItem:close()
end
