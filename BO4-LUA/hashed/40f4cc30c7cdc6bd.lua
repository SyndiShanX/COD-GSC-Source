require("x64:5bf4b6f49c15a4c")
require("x64:3cc932d9389bc48")
CoD.WarzoneInventoryMenuItemAttachmentSmall = InheritFrom(LUI.UIElement)
CoD.WarzoneInventoryMenuItemAttachmentSmall.__defaultWidth = 50
CoD.WarzoneInventoryMenuItemAttachmentSmall.__defaultHeight = 50
CoD.WarzoneInventoryMenuItemAttachmentSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneInventoryMenuItemAttachmentSmall)
	self.id = "WarzoneInventoryMenuItemAttachmentSmall"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WarzoneQuickInventoryMenuItemAttachmentSmallInternal = CoD.WarzoneQuickInventoryMenuItemAttachmentSmall_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 50, 0, 0, -0.5, 49.5)
	WarzoneQuickInventoryMenuItemAttachmentSmallInternal:linkToElementModel(self, nil, false, function(model)
		WarzoneQuickInventoryMenuItemAttachmentSmallInternal:setModel(model, f1_arg1)
	end)
	self:addElement(WarzoneQuickInventoryMenuItemAttachmentSmallInternal)
	self.WarzoneQuickInventoryMenuItemAttachmentSmallInternal = WarzoneQuickInventoryMenuItemAttachmentSmallInternal
	local NotAvailable = LUI.UIImage.new(0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	NotAvailable:setAlpha(0)
	NotAvailable:setImage(RegisterImage(@"uie_ui_hud_wz_hud_core_drop_x"))
	NotAvailable:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(NotAvailable)
	self.NotAvailable = NotAvailable
	local PickupPulse = CoD.WarzoneInventoryPickupPulse.new(f1_arg0, f1_arg1, 0.5, 0.5, -25, 25, 0.5, 0.5, -25, 25)
	self:addElement(PickupPulse)
	self.PickupPulse = PickupPulse
	self:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "disabled", 1)
			end,
		},
		{
			stateName = "NotAvailable",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "notAvailable", 1)
			end,
		},
		{
			stateName = "FocusTarget",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "focusTarget", 1)
			end,
		},
	})
	self:linkToElementModel(self, "disabled", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "disabled",
		})
	end)
	self:linkToElementModel(self, "notAvailable", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "notAvailable",
		})
	end)
	self:linkToElementModel(self, "focusTarget", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "focusTarget",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if CoD.BaseUtility.IsSelfInState(self, "FocusTarget") and IsPC() then
			SetElementState(self, self.PickupPulse, controller, "PickUpPC")
		elseif CoD.BaseUtility.IsSelfInState(self, "FocusTarget") then
			SetElementState(self, self.PickupPulse, controller, "PickUp")
		else
			SetElementState(self, self.PickupPulse, controller, "DefaultState")
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		UpdateSelfState(self, f1_arg1)
	end)
	WarzoneQuickInventoryMenuItemAttachmentSmallInternal.id = "WarzoneQuickInventoryMenuItemAttachmentSmallInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneInventoryMenuItemAttachmentSmall.__resetProperties = function(f11_arg0)
	f11_arg0.PickupPulse:completeAnimation()
	f11_arg0.WarzoneQuickInventoryMenuItemAttachmentSmallInternal:completeAnimation()
	f11_arg0.NotAvailable:completeAnimation()
	f11_arg0.PickupPulse:setAlpha(1)
	f11_arg0.WarzoneQuickInventoryMenuItemAttachmentSmallInternal:setAlpha(1)
	f11_arg0.NotAvailable:setAlpha(0)
end
CoD.WarzoneInventoryMenuItemAttachmentSmall.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.WarzoneQuickInventoryMenuItemAttachmentSmallInternal:completeAnimation()
			f13_arg0.WarzoneQuickInventoryMenuItemAttachmentSmallInternal:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.WarzoneQuickInventoryMenuItemAttachmentSmallInternal)
			f13_arg0.NotAvailable:completeAnimation()
			f13_arg0.NotAvailable:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.NotAvailable)
			f13_arg0.PickupPulse:completeAnimation()
			f13_arg0.PickupPulse:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.PickupPulse)
		end,
	},
	NotAvailable = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.NotAvailable:completeAnimation()
			f14_arg0.NotAvailable:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.NotAvailable)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.NotAvailable:completeAnimation()
			f15_arg0.NotAvailable:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.NotAvailable)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.NotAvailable:completeAnimation()
			f16_arg0.NotAvailable:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.NotAvailable)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.NotAvailable:completeAnimation()
			f17_arg0.NotAvailable:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.NotAvailable)
		end,
	},
	FocusTarget = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WarzoneInventoryMenuItemAttachmentSmall.__onClose = function(f19_arg0)
	f19_arg0.WarzoneQuickInventoryMenuItemAttachmentSmallInternal:close()
	f19_arg0.PickupPulse:close()
end
