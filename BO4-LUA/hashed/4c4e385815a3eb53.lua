require("x64:4bec6a65ea3e5a1")
require("x64:29187ea00d726c3")
CoD.WeaponPickupPromptInfo = InheritFrom(LUI.UIElement)
CoD.WeaponPickupPromptInfo.__defaultWidth = 396
CoD.WeaponPickupPromptInfo.__defaultHeight = 40
CoD.WeaponPickupPromptInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Left)
	DataSourceHelperGetModel(f1_arg1, "WeaponPickupAttachmentList")
	self:setClass(CoD.WeaponPickupPromptInfo)
	self.id = "WeaponPickupPromptInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WeaponPickupWarzoneAction = LUI.UIText.new(0, 0, 0, 77, 0.5, 0.5, -10, 10)
	WeaponPickupWarzoneAction:setRGB(0.79, 0.76, 0.58)
	WeaponPickupWarzoneAction.__Alpha = function()
		WeaponPickupWarzoneAction:setAlpha(CoD.HUDUtility.PickupPromptOpacity(f1_arg1))
	end
	WeaponPickupWarzoneAction.__Alpha()
	WeaponPickupWarzoneAction.__String_Reference = function()
		WeaponPickupWarzoneAction:setText(Engine[@"hash_4F9F1239CFD921FE"](CoD.HUDUtility.Get3DWeaponHintPickupHintTextWithPickUpOptions(f1_arg1)))
	end
	WeaponPickupWarzoneAction.__String_Reference()
	WeaponPickupWarzoneAction:setTTF("dinnext_regular")
	WeaponPickupWarzoneAction:setLetterSpacing(0.5)
	WeaponPickupWarzoneAction:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(WeaponPickupWarzoneAction)
	self.WeaponPickupWarzoneAction = WeaponPickupWarzoneAction
	local SpacerMiddle1 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 81, 83, 0.5, 0.5, -20, 20)
	self:addElement(SpacerMiddle1)
	self.SpacerMiddle1 = SpacerMiddle1
	local DividerLine = LUI.UIImage.new(0, 0, 87, 89, 0.5, 0.5, -17, 17)
	DividerLine:setRGB(0.67, 0.67, 0.67)
	DividerLine:setImage(RegisterImage(@"line_horizontal"))
	self:addElement(DividerLine)
	self.DividerLine = DividerLine
	local SpacerMiddle2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 93, 95, 0.5, 0.5, -20, 20)
	self:addElement(SpacerMiddle2)
	self.SpacerMiddle2 = SpacerMiddle2
	local CursorHintText = LUI.UIText.new(0, 0, 99, 176, 0.5, 0.5, -10, 10)
	CursorHintText:setTTF("ttmussels_demibold")
	CursorHintText:setLetterSpacing(0.5)
	CursorHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CursorHintText:subscribeToGlobalModel(f1_arg1, "HUDItems", "pickupHintText", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CursorHintText:setText(f4_local0)
		end
	end)
	self:addElement(CursorHintText)
	self.CursorHintText = CursorHintText
	local SpacerMiddle3 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 180, 182, 0.5, 0.5, -20, 20)
	self:addElement(SpacerMiddle3)
	self.SpacerMiddle3 = SpacerMiddle3
	local WeaponPickupAttachmentIcon1 = CoD.WeaponPickupAttachmentIcon.new(f1_arg0, f1_arg1, 0, 0, 186, 222, 0, 0, 7.5, 32.5)
	WeaponPickupAttachmentIcon1:subscribeToGlobalModel(f1_arg1, "HUDItems", "pickupAttachmentList.attachment0", function(model)
		WeaponPickupAttachmentIcon1:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponPickupAttachmentIcon1)
	self.WeaponPickupAttachmentIcon1 = WeaponPickupAttachmentIcon1
	local WeaponPickupAttachmentIcon2 = CoD.WeaponPickupAttachmentIcon.new(f1_arg0, f1_arg1, 0, 0, 226, 262, 0, 0, 7.5, 32.5)
	WeaponPickupAttachmentIcon2:subscribeToGlobalModel(f1_arg1, "HUDItems", "pickupAttachmentList.attachment1", function(model)
		WeaponPickupAttachmentIcon2:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponPickupAttachmentIcon2)
	self.WeaponPickupAttachmentIcon2 = WeaponPickupAttachmentIcon2
	local WeaponPickupAttachmentIcon3 = CoD.WeaponPickupAttachmentIcon.new(f1_arg0, f1_arg1, 0, 0, 266, 302, 0, 0, 7.5, 32.5)
	WeaponPickupAttachmentIcon3:subscribeToGlobalModel(f1_arg1, "HUDItems", "pickupAttachmentList.attachment2", function(model)
		WeaponPickupAttachmentIcon3:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponPickupAttachmentIcon3)
	self.WeaponPickupAttachmentIcon3 = WeaponPickupAttachmentIcon3
	local WeaponPickupAttachmentIcon4 = CoD.WeaponPickupAttachmentIcon.new(f1_arg0, f1_arg1, 0, 0, 306, 342, 0, 0, 7.5, 32.5)
	WeaponPickupAttachmentIcon4:subscribeToGlobalModel(f1_arg1, "HUDItems", "pickupAttachmentList.attachment3", function(model)
		WeaponPickupAttachmentIcon4:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponPickupAttachmentIcon4)
	self.WeaponPickupAttachmentIcon4 = WeaponPickupAttachmentIcon4
	local WeaponPickupAttachmentIcon5 = CoD.WeaponPickupAttachmentIcon.new(f1_arg0, f1_arg1, 0, 0, 346, 382, 0, 0, 7.5, 32.5)
	WeaponPickupAttachmentIcon5:subscribeToGlobalModel(f1_arg1, "HUDItems", "pickupAttachmentList.attachment4", function(model)
		WeaponPickupAttachmentIcon5:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponPickupAttachmentIcon5)
	self.WeaponPickupAttachmentIcon5 = WeaponPickupAttachmentIcon5
	local WeaponPickupAttachmentIcon6 = CoD.WeaponPickupAttachmentIcon.new(f1_arg0, f1_arg1, 0, 0, 386, 422, 0, 0, 7.5, 32.5)
	WeaponPickupAttachmentIcon6:subscribeToGlobalModel(f1_arg1, "HUDItems", "pickupAttachmentList.attachment5", function(model)
		WeaponPickupAttachmentIcon6:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponPickupAttachmentIcon6)
	self.WeaponPickupAttachmentIcon6 = WeaponPickupAttachmentIcon6
	local f1_local13 = WeaponPickupWarzoneAction
	local f1_local14 = WeaponPickupWarzoneAction.subscribeToModel
	local f1_local15 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.weapon3dHintState, WeaponPickupWarzoneAction.__Alpha)
	f1_local13 = WeaponPickupWarzoneAction
	f1_local14 = WeaponPickupWarzoneAction.subscribeToModel
	f1_local15 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.heroHoldProgress, WeaponPickupWarzoneAction.__Alpha)
	f1_local13 = WeaponPickupWarzoneAction
	f1_local14 = WeaponPickupWarzoneAction.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local14(f1_local13, f1_local15["hudItems.inventory.filledSlots"], WeaponPickupWarzoneAction.__Alpha)
	f1_local13 = WeaponPickupWarzoneAction
	f1_local14 = WeaponPickupWarzoneAction.subscribeToModel
	f1_local15 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.weapon3dHintState, WeaponPickupWarzoneAction.__String_Reference)
	f1_local13 = WeaponPickupWarzoneAction
	f1_local14 = WeaponPickupWarzoneAction.subscribeToModel
	f1_local15 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.heroHoldProgress, WeaponPickupWarzoneAction.__String_Reference)
	f1_local13 = WeaponPickupWarzoneAction
	f1_local14 = WeaponPickupWarzoneAction.subscribeToModel
	f1_local15 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local14(f1_local13, f1_local15["hudItems.inventory.filledSlots"], WeaponPickupWarzoneAction.__String_Reference)
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.HUDUtility.Disable3DWeaponHintButton(f1_arg1)
			end,
		},
	})
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.weapon3dHintState, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "weapon3dHintState",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local14 = self
	if IsCurrentLanguageReversed() then
		ReverseChildrenOrder(self)
	end
	return self
end
CoD.WeaponPickupPromptInfo.__resetProperties = function(f13_arg0)
	f13_arg0.WeaponPickupWarzoneAction:completeAnimation()
	f13_arg0.WeaponPickupWarzoneAction:setRGB(0.79, 0.76, 0.58)
end
CoD.WeaponPickupPromptInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.WeaponPickupWarzoneAction:completeAnimation()
			f15_arg0.WeaponPickupWarzoneAction:setRGB(0.87, 0.08, 0.08)
			f15_arg0.clipFinished(f15_arg0.WeaponPickupWarzoneAction)
		end,
	},
}
CoD.WeaponPickupPromptInfo.__onClose = function(f16_arg0)
	f16_arg0.WeaponPickupWarzoneAction:close()
	f16_arg0.SpacerMiddle1:close()
	f16_arg0.SpacerMiddle2:close()
	f16_arg0.CursorHintText:close()
	f16_arg0.SpacerMiddle3:close()
	f16_arg0.WeaponPickupAttachmentIcon1:close()
	f16_arg0.WeaponPickupAttachmentIcon2:close()
	f16_arg0.WeaponPickupAttachmentIcon3:close()
	f16_arg0.WeaponPickupAttachmentIcon4:close()
	f16_arg0.WeaponPickupAttachmentIcon5:close()
	f16_arg0.WeaponPickupAttachmentIcon6:close()
end
