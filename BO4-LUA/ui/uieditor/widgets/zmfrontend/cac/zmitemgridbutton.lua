require("x64:edf74c078d01a26")
CoD.ZMItemGridButton = InheritFrom(LUI.UIElement)
CoD.ZMItemGridButton.__defaultWidth = 292
CoD.ZMItemGridButton.__defaultHeight = 146
CoD.ZMItemGridButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "weaponSelectItemIndex", 0)
	self:setClass(CoD.ZMItemGridButton)
	self.id = "ZMItemGridButton"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZMItem = CoD.ZMAttachmentSlot.new(f1_arg0, f1_arg1, 0, 0, 0, 292, 0, 0, 0, 146)
	ZMItem:mergeStateConditions({
		{
			stateName = "LootNotOwned",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACBlackMarketItemLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsCACItemLocked(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsItemEquippedInCurrentSlot(menu, element, f1_arg1)
			end,
		},
	})
	ZMItem:linkToElementModel(ZMItem, "refHash", true, function(model)
		f1_arg0:updateElementState(ZMItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "refHash",
		})
	end)
	ZMItem:linkToElementModel(ZMItem, "globalItemIndex", true, function(model)
		f1_arg0:updateElementState(ZMItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "globalItemIndex",
		})
	end)
	ZMItem:linkToElementModel(ZMItem, "itemIndex", true, function(model)
		f1_arg0:updateElementState(ZMItem, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	ZMItem:linkToElementModel(self, nil, false, function(model)
		ZMItem:setModel(model, f1_arg1)
	end)
	ZMItem.AttachmentImage.__Image = function(f10_arg0)
		local f10_local0 = f10_arg0:get()
		if f10_local0 ~= nil then
			ZMItem.AttachmentImage:setImage(CoD.BaseUtility.AlreadyRegistered(CoD.ZMLoadoutUtility.GetEquippedSignatureWeaponImage(self:getModel(), f1_arg1, f10_local0)))
		end
	end
	ZMItem:linkToElementModel(self, "itemIndex", true, ZMItem.AttachmentImage.__Image)
	ZMItem.AttachmentImage.__Image_FullPath = function()
		local f11_local0 = self:getModel()
		if f11_local0 then
			f11_local0 = self:getModel()
			f11_local0 = f11_local0.itemIndex
		end
		if f11_local0 then
			ZMItem.AttachmentImage.__Image(f11_local0)
		end
	end
	ZMItem:linkToElementModel(self, nil, false, function(model)
		ZMItem.ItemHintTextBreadcrumb:setModel(model, f1_arg1)
	end)
	ZMItem:linkToElementModel(self, "hintText", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			ZMItem.ItemHintTextBreadcrumb.textCenterAlign:setText(f13_local0)
		end
	end)
	ZMItem:linkToElementModel(self, nil, false, function(model)
		ZMItem.ItemHintTextBreadcrumb.Breadcrumb:setModel(model, f1_arg1)
	end)
	ZMItem.AttachmentName.__Name = function(f15_arg0)
		local f15_local0 = f15_arg0:get()
		if f15_local0 ~= nil then
			ZMItem.AttachmentName:setText(LocalizeToUpperString(CoD.ZMLoadoutUtility.GetEquippedSignatureWeaponName(self:getModel(), f1_arg1, f15_local0)))
		end
	end
	ZMItem:linkToElementModel(self, "itemIndex", true, ZMItem.AttachmentName.__Name)
	ZMItem.AttachmentName.__Name_FullPath = function()
		local f16_local0 = self:getModel()
		if f16_local0 then
			f16_local0 = self:getModel()
			f16_local0 = f16_local0.itemIndex
		end
		if f16_local0 then
			ZMItem.AttachmentName.__Name(f16_local0)
		end
	end
	self:addElement(ZMItem)
	self.ZMItem = ZMItem
	local f1_local2 = ZMItem
	local f1_local3 = ZMItem.subscribeToModel
	local f1_local4 = DataSources.WeaponPersonalization.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.listUpdate, ZMItem.AttachmentImage.__Image_FullPath)
	ZMItem:linkToElementModel(self, "useVariantSlot", true, ZMItem.AttachmentImage.__Image_FullPath)
	ZMItem:linkToElementModel(self, "image", true, ZMItem.AttachmentImage.__Image_FullPath)
	f1_local2 = ZMItem
	f1_local3 = ZMItem.subscribeToModel
	f1_local4 = DataSources.WeaponPersonalization.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.listUpdate, ZMItem.AttachmentName.__Name_FullPath)
	ZMItem:linkToElementModel(self, "useVariantSlot", true, ZMItem.AttachmentName.__Name_FullPath)
	ZMItem:linkToElementModel(self, "displayName", true, ZMItem.AttachmentName.__Name_FullPath)
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
	ZMItem.id = "ZMItem"
	self.__defaultFocus = ZMItem
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
CoD.ZMItemGridButton.__resetProperties = function(f21_arg0)
	f21_arg0.ZMItem:completeAnimation()
	f21_arg0.ZMItem:setScale(1, 1)
end
CoD.ZMItemGridButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.ZMItem:completeAnimation()
			f23_arg0.ZMItem:setScale(1.05, 1.05)
			f23_arg0.clipFinished(f23_arg0.ZMItem)
		end,
		GainChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.ZMItem:beginAnimation(200)
				f24_arg0.ZMItem:setScale(1.05, 1.05)
				f24_arg0.ZMItem:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.ZMItem:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.ZMItem:completeAnimation()
			f24_arg0.ZMItem:setScale(1, 1)
			f24_local0(f24_arg0.ZMItem)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			local f26_local0 = function(f27_arg0)
				f26_arg0.ZMItem:beginAnimation(200)
				f26_arg0.ZMItem:setScale(1, 1)
				f26_arg0.ZMItem:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ZMItem:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.ZMItem:completeAnimation()
			f26_arg0.ZMItem:setScale(1.05, 1.05)
			f26_local0(f26_arg0.ZMItem)
		end,
	},
	PC = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(0)
		end,
	},
	Equipped = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ZMItemGridButton.__onClose = function(f30_arg0)
	f30_arg0.ZMItem:close()
end
