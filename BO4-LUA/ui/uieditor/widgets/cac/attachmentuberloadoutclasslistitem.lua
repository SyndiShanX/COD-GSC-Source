require("x64:6a866391524bb19")
require("x64:ad25b4bd09d0d91")
require("x64:12a692cf6c196d1")
CoD.AttachmentUberLoadoutClassListItem = InheritFrom(LUI.UIElement)
CoD.AttachmentUberLoadoutClassListItem.__defaultWidth = 110
CoD.AttachmentUberLoadoutClassListItem.__defaultHeight = 80
CoD.AttachmentUberLoadoutClassListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AttachmentUberLoadoutClassListItem)
	self.id = "AttachmentUberLoadoutClassListItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WildcardHighlightTop = CoD.CACWildcardSelectionAnimContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 225, 0, 0, -52, 0)
	WildcardHighlightTop:setAlpha(0)
	WildcardHighlightTop:setZRot(180)
	self:addElement(WildcardHighlightTop)
	self.WildcardHighlightTop = WildcardHighlightTop
	local AttachmentSlot = CoD.CommonItemSlotWide.new(f1_arg0, f1_arg1, 0, 0, 0, 230, 0.5, 0.5, -40, 40)
	AttachmentSlot:mergeStateConditions({
		{
			stateName = "NotValid",
			condition = function(menu, element, event)
				return not CoD.CACUtility.IsAttachmentSlotValid(menu, f1_arg1, element)
			end,
		},
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "WildcardNeeded",
			condition = function(menu, element, event)
				local f6_local0
				if not IsZombies() then
					f6_local0 = not CoD.BonuscardUtility.IsPrereqBonuscardEquippedForSlot(menu, element)
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "Add",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "loadoutListItem->itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
		{
			stateName = "DefaultStateNoName",
			condition = function(menu, element, event)
				return IsCurrentMenu(menu, "MPCustomizeClassMenu")
			end,
		},
	})
	AttachmentSlot:linkToElementModel(AttachmentSlot, "isAttachmentSlotAvailable", true, function(model)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isAttachmentSlotAvailable",
		})
	end)
	local ButtonFrameSelected = AttachmentSlot
	local WildcardHighlightBottom = AttachmentSlot.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	WildcardHighlightBottom(ButtonFrameSelected, f1_local5["lobbyRoot.lobbyNav"], function(f10_arg0)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ButtonFrameSelected = AttachmentSlot
	WildcardHighlightBottom = AttachmentSlot.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	WildcardHighlightBottom(ButtonFrameSelected, f1_local5["CustomClassList.equippedItemsChanged"], function(f11_arg0)
		f1_arg0:updateElementState(AttachmentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	AttachmentSlot:linkToElementModel(AttachmentSlot, "loadoutListItem", true, function(model)
		if AttachmentSlot["__stateValidation_loadoutListItem->itemIndex"] then
			AttachmentSlot:removeSubscription(AttachmentSlot["__stateValidation_loadoutListItem->itemIndex"])
			AttachmentSlot["__stateValidation_loadoutListItem->itemIndex"] = nil
		end
		if model then
			local f12_local0 = model:get()
			local f12_local1 = model:get()
			model = f12_local0 and f12_local1.itemIndex
		end
		if model then
			AttachmentSlot["__stateValidation_loadoutListItem->itemIndex"] = AttachmentSlot:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(AttachmentSlot, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "loadoutListItem->itemIndex",
				})
			end)
		end
	end)
	AttachmentSlot:linkToElementModel(self, nil, false, function(model)
		AttachmentSlot:setModel(model, f1_arg1)
	end)
	AttachmentSlot.ItemImage.__Item_Image = function(f15_arg0)
		local f15_local0 = f15_arg0:get()
		if f15_local0 ~= nil then
			AttachmentSlot.ItemImage:setImage(RegisterImage(f15_local0))
		end
	end
	AttachmentSlot:linkToElementModel(self, "loadoutListItem", true, function(model, f16_arg1)
		if f16_arg1["__AttachmentSlot.ItemImage.__Item_Image_loadoutListItem->image"] then
			f16_arg1:removeSubscription(f16_arg1["__AttachmentSlot.ItemImage.__Item_Image_loadoutListItem->image"])
			f16_arg1["__AttachmentSlot.ItemImage.__Item_Image_loadoutListItem->image"] = nil
		end
		if model then
			local f16_local0 = model:get()
			local f16_local1 = model:get()
			model = f16_local0 and f16_local1.image
		end
		if model then
			f16_arg1["__AttachmentSlot.ItemImage.__Item_Image_loadoutListItem->image"] = f16_arg1:subscribeToModel(model, AttachmentSlot.ItemImage.__Item_Image)
		end
	end)
	AttachmentSlot.ItemName.TextBox.__Item_Name = function(f17_arg0)
		local f17_local0 = f17_arg0:get()
		if f17_local0 ~= nil then
			AttachmentSlot.ItemName.TextBox:setText(Engine[0xF9F1239CFD921FE](f17_local0))
		end
	end
	AttachmentSlot:linkToElementModel(self, "loadoutListItem", true, function(model, f18_arg1)
		if f18_arg1["__AttachmentSlot.ItemName.TextBox.__Item_Name_loadoutListItem->name"] then
			f18_arg1:removeSubscription(f18_arg1["__AttachmentSlot.ItemName.TextBox.__Item_Name_loadoutListItem->name"])
			f18_arg1["__AttachmentSlot.ItemName.TextBox.__Item_Name_loadoutListItem->name"] = nil
		end
		if model then
			local f18_local0 = model:get()
			local f18_local1 = model:get()
			model = f18_local0 and f18_local1.name
		end
		if model then
			f18_arg1["__AttachmentSlot.ItemName.TextBox.__Item_Name_loadoutListItem->name"] = f18_arg1:subscribeToModel(model, AttachmentSlot.ItemName.TextBox.__Item_Name)
		end
	end)
	self:addElement(AttachmentSlot)
	self.AttachmentSlot = AttachmentSlot
	WildcardHighlightBottom = CoD.CACWildcardSelectionAnimContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 225, 1, 1, 0, 52)
	WildcardHighlightBottom:setAlpha(0)
	self:addElement(WildcardHighlightBottom)
	self.WildcardHighlightBottom = WildcardHighlightBottom
	ButtonFrameSelected = CoD.CACWildcardSelectionAnimation.new(f1_arg0, f1_arg1, 0, 0, 0, 225, 0, 0, 0, 80)
	ButtonFrameSelected:setAlpha(0)
	self:addElement(ButtonFrameSelected)
	self.ButtonFrameSelected = ButtonFrameSelected
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.CACUtility.UpdateClassWeaponModel(f1_arg0, element, f1_arg1)
	end)
	AttachmentSlot.id = "AttachmentSlot"
	self.__defaultFocus = AttachmentSlot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AttachmentUberLoadoutClassListItem.__resetProperties = function(f20_arg0)
	f20_arg0.AttachmentSlot:completeAnimation()
	f20_arg0.WildcardHighlightTop:completeAnimation()
	f20_arg0.WildcardHighlightBottom:completeAnimation()
	f20_arg0.ButtonFrameSelected:completeAnimation()
	f20_arg0.AttachmentSlot:setScale(1, 1)
	f20_arg0.WildcardHighlightTop:setAlpha(0)
	f20_arg0.WildcardHighlightBottom:setAlpha(0)
	f20_arg0.ButtonFrameSelected:setAlpha(0)
end
CoD.AttachmentUberLoadoutClassListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.AttachmentSlot:completeAnimation()
			f22_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f22_arg0.clipFinished(f22_arg0.AttachmentSlot)
		end,
		GainChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			local f23_local0 = function(f24_arg0)
				f23_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f23_arg0.AttachmentSlot:setScale(1.05, 1.05)
				f23_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.AttachmentSlot:completeAnimation()
			f23_arg0.AttachmentSlot:setScale(1, 1)
			f23_local0(f23_arg0.AttachmentSlot)
		end,
		LoseChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			local f25_local0 = function(f26_arg0)
				f25_arg0.AttachmentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f25_arg0.AttachmentSlot:setScale(1, 1)
				f25_arg0.AttachmentSlot:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.AttachmentSlot:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.AttachmentSlot:completeAnimation()
			f25_arg0.AttachmentSlot:setScale(1.05, 1.05)
			f25_local0(f25_arg0.AttachmentSlot)
		end,
	},
	WildcardHighlight = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.WildcardHighlightTop:completeAnimation()
			f27_arg0.WildcardHighlightTop:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.WildcardHighlightTop)
			f27_arg0.WildcardHighlightBottom:completeAnimation()
			f27_arg0.WildcardHighlightBottom:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.WildcardHighlightBottom)
			f27_arg0.ButtonFrameSelected:completeAnimation()
			f27_arg0.ButtonFrameSelected:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.ButtonFrameSelected)
		end,
	},
}
CoD.AttachmentUberLoadoutClassListItem.__onClose = function(f28_arg0)
	f28_arg0.WildcardHighlightTop:close()
	f28_arg0.AttachmentSlot:close()
	f28_arg0.WildcardHighlightBottom:close()
	f28_arg0.ButtonFrameSelected:close()
end
