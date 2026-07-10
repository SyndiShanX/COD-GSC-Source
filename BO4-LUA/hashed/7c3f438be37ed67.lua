require("x64:2e06eec4ea38539")
require("x64:d7c2833b4652c17")
require("x64:9bbe0011ba3f2ca")
require("x64:29187ea00d726c3")
CoD.WeaponPickupPrompt = InheritFrom(LUI.UIElement)
CoD.WeaponPickupPrompt.__defaultWidth = 1100
CoD.WeaponPickupPrompt.__defaultHeight = 40
CoD.WeaponPickupPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.WeaponPickupPrompt)
	self.id = "WeaponPickupPrompt"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.WeaponPickupPrompt_Backing.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local SpacerFront = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 316, 326, 0.5, 0.5, -20, 20)
	self:addElement(SpacerFront)
	self.SpacerFront = SpacerFront
	local HoldButtonIcon = CoD.WZWeaponPickupHoldButtonIcons.new(f1_arg0, f1_arg1, 0, 0, 330, 370, 0.5, 0.5, -25, 25)
	self:addElement(HoldButtonIcon)
	self.HoldButtonIcon = HoldButtonIcon
	local WeaponPickupWarzoneAction = CoD.WeaponPickupPromptInfo.new(f1_arg0, f1_arg1, 0, 0, 374, 770, 0.5, 0.5, -20, 20)
	self:addElement(WeaponPickupWarzoneAction)
	self.WeaponPickupWarzoneAction = WeaponPickupWarzoneAction
	local SpacerEnd = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 774, 784, 0.5, 0.5, -20, 20)
	self:addElement(SpacerEnd)
	self.SpacerEnd = SpacerEnd
	self:mergeStateConditions({
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
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.weapon3dHintState, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "weapon3dHintState",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponPickupPrompt.__resetProperties = function(f5_arg0)
	f5_arg0.HoldButtonIcon:completeAnimation()
	f5_arg0.HoldButtonIcon:setLeftRight(0, 0, 330, 370)
	f5_arg0.HoldButtonIcon:setAlpha(1)
end
CoD.WeaponPickupPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	PromptDisabledWithSwap = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.HoldButtonIcon:completeAnimation()
			f7_arg0.HoldButtonIcon:setLeftRight(0, 0, 370, 370)
			f7_arg0.clipFinished(f7_arg0.HoldButtonIcon)
		end,
	},
	PromptDisabled = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.HoldButtonIcon:completeAnimation()
			f8_arg0.HoldButtonIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.HoldButtonIcon)
		end,
	},
}
CoD.WeaponPickupPrompt.__onClose = function(f9_arg0)
	f9_arg0.Backing:close()
	f9_arg0.SpacerFront:close()
	f9_arg0.HoldButtonIcon:close()
	f9_arg0.WeaponPickupWarzoneAction:close()
	f9_arg0.SpacerEnd:close()
end
