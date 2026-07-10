require("x64:a8ce113b5f4e290")
require("x64:ae760060dcb1016")
require("x64:9bbe0011ba3f2ca")
CoD.TabbedMultiItemPickup_Header = InheritFrom(LUI.UIElement)
CoD.TabbedMultiItemPickup_Header.__defaultWidth = 300
CoD.TabbedMultiItemPickup_Header.__defaultHeight = 40
CoD.TabbedMultiItemPickup_Header.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, true)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.TabbedMultiItemPickup_Header)
	self.id = "TabbedMultiItemPickup_Header"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.WeaponPickupPrompt_BackingStash.new(f1_arg0, f1_arg1, 0, 1, -5, 5, 1, 1, 6, 46)
	Backing:setRGB(0.24, 0.24, 0.24)
	self:addElement(Backing)
	self.Backing = Backing
	local HoldButtonIcon = CoD.WZWeaponPickupHoldButtonIcons.new(f1_arg0, f1_arg1, 0, 0, 0, 40, 1, 1, 1, 51)
	self:addElement(HoldButtonIcon)
	self.HoldButtonIcon = HoldButtonIcon
	local text = CoD.MultiItemPickupWaypoint_HeaderInfo.new(f1_arg0, f1_arg1, 0, 0, 44, 202, 1, 1, 16, 36)
	text:linkToElementModel(self, nil, false, function(model)
		text:setModel(model, f1_arg1)
	end)
	self:addElement(text)
	self.text = text
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.HUDUtility.Hide3DWeaponHintButton(f1_arg1)
			end,
		},
		{
			stateName = "PromptDisabledWithSwap",
			condition = function(menu, element, event)
				return CoD.HUDUtility.Disable3DWeaponHintButtonWithSwap(f1_arg1)
			end,
		},
		{
			stateName = "PromptDisabled",
			condition = function(menu, element, event)
				return CoD.HUDUtility.Disable3DWeaponHintButton(f1_arg1)
			end,
		},
		{
			stateName = "DualPrompts",
			condition = function(menu, element, event)
				return CoD.HUDUtility.ShowTriangleAttachmentPickupPrompt(f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.weapon3dHintState, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "weapon3dHintState",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.inventory.filledSlots"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "hudItems.inventory.filledSlots",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedMultiItemPickup_Header.__resetProperties = function(f9_arg0)
	f9_arg0.text:completeAnimation()
	f9_arg0.Backing:completeAnimation()
	f9_arg0.HoldButtonIcon:completeAnimation()
	f9_arg0.text:setAlpha(1)
	f9_arg0.Backing:setAlpha(1)
	f9_arg0.HoldButtonIcon:setLeftRight(0, 0, 0, 40)
	f9_arg0.HoldButtonIcon:setAlpha(1)
end
CoD.TabbedMultiItemPickup_Header.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Backing)
			f11_arg0.HoldButtonIcon:completeAnimation()
			f11_arg0.HoldButtonIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.HoldButtonIcon)
			f11_arg0.text:completeAnimation()
			f11_arg0.text:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.text)
		end,
	},
	PromptDisabledWithSwap = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.HoldButtonIcon:completeAnimation()
			f12_arg0.HoldButtonIcon:setLeftRight(0, 0, 40, 40)
			f12_arg0.clipFinished(f12_arg0.HoldButtonIcon)
		end,
	},
	PromptDisabled = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.HoldButtonIcon:completeAnimation()
			f13_arg0.HoldButtonIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.HoldButtonIcon)
		end,
	},
	DualPrompts = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.TabbedMultiItemPickup_Header.__onClose = function(f15_arg0)
	f15_arg0.Backing:close()
	f15_arg0.HoldButtonIcon:close()
	f15_arg0.text:close()
end
