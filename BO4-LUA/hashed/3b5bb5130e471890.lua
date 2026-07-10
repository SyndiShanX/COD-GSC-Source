require("x64:a8ce113b5f4e290")
require("x64:2e06eec4ea38539")
require("x64:9bbe0011ba3f2ca")
require("x64:29187ea00d726c3")
CoD.MultiItemPickupWaypoint_Header = InheritFrom(LUI.UIElement)
CoD.MultiItemPickupWaypoint_Header.__defaultWidth = 300
CoD.MultiItemPickupWaypoint_Header.__defaultHeight = 40
CoD.MultiItemPickupWaypoint_Header.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.MultiItemPickupWaypoint_Header)
	self.id = "MultiItemPickupWaypoint_Header"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.WeaponPickupPrompt_Backing.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local SpacerBegin = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 197, 207, 0.5, 0.5, -20, 20)
	self:addElement(SpacerBegin)
	self.SpacerBegin = SpacerBegin
	local HoldButtonIcon = CoD.WZWeaponPickupHoldButtonIcons.new(f1_arg0, f1_arg1, 0, 0, 211, 251, 0.5, 0.5, -25, 25)
	self:addElement(HoldButtonIcon)
	self.HoldButtonIcon = HoldButtonIcon
	local text = CoD.MultiItemPickupWaypoint_HeaderInfo.new(f1_arg0, f1_arg1, 0, 0, 35, 193, 0, 0, 10, 30)
	text:linkToElementModel(self, nil, false, function(model)
		text:setModel(model, f1_arg1)
	end)
	self:addElement(text)
	self.text = text
	local SpacerEnd = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 255, 265, 0.5, 0.5, -20, 20)
	self:addElement(SpacerEnd)
	self.SpacerEnd = SpacerEnd
	self:mergeStateConditions({
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
CoD.MultiItemPickupWaypoint_Header.__resetProperties = function(f5_arg0)
	f5_arg0.HoldButtonIcon:completeAnimation()
	f5_arg0.HoldButtonIcon:setAlpha(1)
end
CoD.MultiItemPickupWaypoint_Header.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	PromptDisabled = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.HoldButtonIcon:completeAnimation()
			f7_arg0.HoldButtonIcon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.HoldButtonIcon)
		end,
	},
}
CoD.MultiItemPickupWaypoint_Header.__onClose = function(f8_arg0)
	f8_arg0.Backing:close()
	f8_arg0.SpacerBegin:close()
	f8_arg0.HoldButtonIcon:close()
	f8_arg0.text:close()
	f8_arg0.SpacerEnd:close()
end
