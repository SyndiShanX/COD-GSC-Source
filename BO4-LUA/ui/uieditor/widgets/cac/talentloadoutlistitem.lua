require("x64:6a866391524bb19")
require("x64:96839bd6f46147f")
require("x64:ad25b4bd09d0d91")
CoD.TalentLoadoutListItem = InheritFrom(LUI.UIElement)
CoD.TalentLoadoutListItem.__defaultWidth = 110
CoD.TalentLoadoutListItem.__defaultHeight = 80
CoD.TalentLoadoutListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TalentLoadoutListItem)
	self.id = "TalentLoadoutListItem"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WildcardHighlightTop = CoD.CACWildcardSelectionAnimContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, -52, 0)
	WildcardHighlightTop:setAlpha(0)
	WildcardHighlightTop:setZRot(180)
	self:addElement(WildcardHighlightTop)
	self.WildcardHighlightTop = WildcardHighlightTop
	local WildcardHighlightBottom = CoD.CACWildcardSelectionAnimContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, 0, 52)
	WildcardHighlightBottom:setAlpha(0)
	self:addElement(WildcardHighlightBottom)
	self.WildcardHighlightBottom = WildcardHighlightBottom
	local TalentSlot = CoD.AttachmentSlot.new(f1_arg0, f1_arg1, 0, 0, 0, 110, 0, 0, 0, 80)
	TalentSlot:mergeStateConditions({
		{
			stateName = "WildcardNotAvailable",
			condition = function(menu, element, event)
				return not CoD.BonuscardUtility.CanContextualEquipForSlot(menu, element)
			end,
		},
		{
			stateName = "WildcardNeeded",
			condition = function(menu, element, event)
				return not CoD.BonuscardUtility.IsRequiredGreedWildcardEquipped(menu, element)
			end,
		},
		{
			stateName = "Add",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "loadoutListItem->itemIndex", CoDShared.EmptyItemIndex)
			end,
		},
		{
			stateName = "DefaultStateHiddenName",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local f1_local4 = TalentSlot
	local ButtonFrameSelected = TalentSlot.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ButtonFrameSelected(f1_local4, f1_local6["CustomClassList.equippedItemsChanged"], function(f6_arg0)
		f1_arg0:updateElementState(TalentSlot, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "CustomClassList.equippedItemsChanged",
		})
	end, false)
	TalentSlot:linkToElementModel(TalentSlot, "loadoutListItem", true, function(model)
		if TalentSlot["__stateValidation_loadoutListItem->itemIndex"] then
			TalentSlot:removeSubscription(TalentSlot["__stateValidation_loadoutListItem->itemIndex"])
			TalentSlot["__stateValidation_loadoutListItem->itemIndex"] = nil
		end
		if model then
			local f7_local0 = model:get()
			local f7_local1 = model:get()
			model = f7_local0 and f7_local1.itemIndex
		end
		if model then
			TalentSlot["__stateValidation_loadoutListItem->itemIndex"] = TalentSlot:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(TalentSlot, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "loadoutListItem->itemIndex",
				})
			end)
		end
	end)
	TalentSlot:linkToElementModel(self, nil, false, function(model)
		TalentSlot:setModel(model, f1_arg1)
	end)
	TalentSlot.AttachmentImage.__Item_Image = function(f10_arg0)
		local f10_local0 = f10_arg0:get()
		if f10_local0 ~= nil then
			TalentSlot.AttachmentImage:setImage(RegisterImage(f10_local0))
		end
	end
	TalentSlot:linkToElementModel(self, "loadoutListItem", true, function(model, f11_arg1)
		if f11_arg1["__TalentSlot.AttachmentImage.__Item_Image_loadoutListItem->image"] then
			f11_arg1:removeSubscription(f11_arg1["__TalentSlot.AttachmentImage.__Item_Image_loadoutListItem->image"])
			f11_arg1["__TalentSlot.AttachmentImage.__Item_Image_loadoutListItem->image"] = nil
		end
		if model then
			local f11_local0 = model:get()
			local f11_local1 = model:get()
			model = f11_local0 and f11_local1.image
		end
		if model then
			f11_arg1["__TalentSlot.AttachmentImage.__Item_Image_loadoutListItem->image"] = f11_arg1:subscribeToModel(model, TalentSlot.AttachmentImage.__Item_Image)
		end
	end)
	TalentSlot.AttachmentName.TextBox.__Item_Name = function(f12_arg0)
		local f12_local0 = f12_arg0:get()
		if f12_local0 ~= nil then
			TalentSlot.AttachmentName.TextBox:setText(Engine[0xF9F1239CFD921FE](f12_local0))
		end
	end
	TalentSlot:linkToElementModel(self, "loadoutListItem", true, function(model, f13_arg1)
		if f13_arg1["__TalentSlot.AttachmentName.TextBox.__Item_Name_loadoutListItem->name"] then
			f13_arg1:removeSubscription(f13_arg1["__TalentSlot.AttachmentName.TextBox.__Item_Name_loadoutListItem->name"])
			f13_arg1["__TalentSlot.AttachmentName.TextBox.__Item_Name_loadoutListItem->name"] = nil
		end
		if model then
			local f13_local0 = model:get()
			local f13_local1 = model:get()
			model = f13_local0 and f13_local1.name
		end
		if model then
			f13_arg1["__TalentSlot.AttachmentName.TextBox.__Item_Name_loadoutListItem->name"] = f13_arg1:subscribeToModel(model, TalentSlot.AttachmentName.TextBox.__Item_Name)
		end
	end)
	self:addElement(TalentSlot)
	self.TalentSlot = TalentSlot
	ButtonFrameSelected = CoD.CACWildcardSelectionAnimation.new(f1_arg0, f1_arg1, 0.5, 0.5, -55, 55, 0.5, 0.5, -40, 40)
	ButtonFrameSelected:setAlpha(0)
	self:addElement(ButtonFrameSelected)
	self.ButtonFrameSelected = ButtonFrameSelected
	LUI.OverrideFunction_CallOriginalFirst(self, "childFocusGained", function(element)
		CoD.CACUtility.UpdateClassWeaponModel(f1_arg0, element, f1_arg1)
	end)
	TalentSlot.id = "TalentSlot"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TalentLoadoutListItem.__resetProperties = function(f15_arg0)
	f15_arg0.TalentSlot:completeAnimation()
	f15_arg0.ButtonFrameSelected:completeAnimation()
	f15_arg0.WildcardHighlightBottom:completeAnimation()
	f15_arg0.WildcardHighlightTop:completeAnimation()
	f15_arg0.TalentSlot:setScale(1, 1)
	f15_arg0.ButtonFrameSelected:setAlpha(0)
	f15_arg0.WildcardHighlightBottom:setAlpha(0)
	f15_arg0.WildcardHighlightTop:setAlpha(0)
end
CoD.TalentLoadoutListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.TalentSlot:completeAnimation()
			f17_arg0.TalentSlot:setScale(1.05, 1.05)
			f17_arg0.clipFinished(f17_arg0.TalentSlot)
		end,
		GainChildFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.TalentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f18_arg0.TalentSlot:setScale(1.05, 1.05)
				f18_arg0.TalentSlot:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.TalentSlot:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.TalentSlot:completeAnimation()
			f18_arg0.TalentSlot:setScale(1, 1)
			f18_local0(f18_arg0.TalentSlot)
		end,
		LoseChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			local f20_local0 = function(f21_arg0)
				f20_arg0.TalentSlot:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f20_arg0.TalentSlot:setScale(1, 1)
				f20_arg0.TalentSlot:registerEventHandler("interrupted_keyframe", f20_arg0.clipInterrupted)
				f20_arg0.TalentSlot:registerEventHandler("transition_complete_keyframe", f20_arg0.clipFinished)
			end
			f20_arg0.TalentSlot:completeAnimation()
			f20_arg0.TalentSlot:setScale(1.05, 1.05)
			f20_local0(f20_arg0.TalentSlot)
		end,
	},
	WildcardHighlight = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.WildcardHighlightTop:completeAnimation()
			f22_arg0.WildcardHighlightTop:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.WildcardHighlightTop)
			f22_arg0.WildcardHighlightBottom:completeAnimation()
			f22_arg0.WildcardHighlightBottom:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.WildcardHighlightBottom)
			f22_arg0.ButtonFrameSelected:completeAnimation()
			f22_arg0.ButtonFrameSelected:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.ButtonFrameSelected)
		end,
	},
}
CoD.TalentLoadoutListItem.__onClose = function(f23_arg0)
	f23_arg0.WildcardHighlightTop:close()
	f23_arg0.WildcardHighlightBottom:close()
	f23_arg0.TalentSlot:close()
	f23_arg0.ButtonFrameSelected:close()
end
