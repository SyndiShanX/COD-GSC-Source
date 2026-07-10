require("x64:561c804ce339d2b")
require("x64:d36334c33274313")
CoD.fe_RightContainerWithoutRightBoxes = InheritFrom(LUI.UIElement)
CoD.fe_RightContainerWithoutRightBoxes.__defaultWidth = 1305
CoD.fe_RightContainerWithoutRightBoxes.__defaultHeight = 48
CoD.fe_RightContainerWithoutRightBoxes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.fe_RightContainerWithoutRightBoxes)
	self.id = "fe_RightContainerWithoutRightBoxes"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image00 = LUI.UIImage.new(0, 0, 1301, 1305, 0, 0, -54, 138)
	Image00:setAlpha(0)
	self:addElement(Image00)
	self.Image00 = Image00
	local Image0 = LUI.UIImage.new(0, 0, 1276, 1300, 0, 0, -54, 138)
	Image0:setAlpha(0)
	self:addElement(Image0)
	self.Image0 = Image0
	local FooterButtonDoublePrompts = CoD.FooterButtonDoublePrompts.new(f1_arg0, f1_arg1, 1, 1, -301, -28, 1, 1, -48, 0)
	FooterButtonDoublePrompts:subscribeToGlobalModel(f1_arg1, "Controller", "left_shoulder_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FooterButtonDoublePrompts.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	FooterButtonDoublePrompts:subscribeToGlobalModel(f1_arg1, "Controller", "right_shoulder_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			FooterButtonDoublePrompts.buttonPromptImage1:setImage(RegisterImage(f3_local0))
		end
	end)
	FooterButtonDoublePrompts:linkToElementModel(self, "" .. Enum[0x3DD78803F918E9D][0x493152B20AE4F58], false, function(model)
		FooterButtonDoublePrompts:setModel(model, f1_arg1)
	end)
	self:addElement(FooterButtonDoublePrompts)
	self.FooterButtonDoublePrompts = FooterButtonDoublePrompts
	local Padbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 1, 1, -542, -301, 1, 1, -48, 0)
	Padbtn:subscribeToGlobalModel(f1_arg1, "Controller", "back_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Padbtn.buttonPromptImage:setImage(RegisterImage(f5_local0))
		end
	end)
	Padbtn:linkToElementModel(self, "" .. Enum[0x3DD78803F918E9D][0x93AB4C84F113EE1], false, function(model)
		Padbtn:setModel(model, f1_arg1)
	end)
	self:addElement(Padbtn)
	self.Padbtn = Padbtn
	local RJoystickbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 1, 1, -678, -542, 1, 1, -48, 0)
	RJoystickbtn:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			RJoystickbtn.buttonPromptImage:setImage(RegisterImage(f7_local0))
		end
	end)
	RJoystickbtn:linkToElementModel(self, "" .. Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], false, function(model)
		RJoystickbtn:setModel(model, f1_arg1)
	end)
	self:addElement(RJoystickbtn)
	self.RJoystickbtn = RJoystickbtn
	if CoD.isPC then
		Padbtn.id = "Padbtn"
	end
	if CoD.isPC then
		RJoystickbtn.id = "RJoystickbtn"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.fe_RightContainerWithoutRightBoxes.__resetProperties = function(f9_arg0)
	f9_arg0.RJoystickbtn:completeAnimation()
	f9_arg0.RJoystickbtn:setLeftRight(1, 1, -678, -542)
	f9_arg0.RJoystickbtn:setTopBottom(1, 1, -48, 0)
end
CoD.fe_RightContainerWithoutRightBoxes.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.RJoystickbtn:completeAnimation()
			f10_arg0.RJoystickbtn:setLeftRight(1, 1, -676, -542)
			f10_arg0.RJoystickbtn:setTopBottom(1, 1, -48, 0)
			f10_arg0.clipFinished(f10_arg0.RJoystickbtn)
		end,
	},
}
CoD.fe_RightContainerWithoutRightBoxes.__onClose = function(f11_arg0)
	f11_arg0.FooterButtonDoublePrompts:close()
	f11_arg0.Padbtn:close()
	f11_arg0.RJoystickbtn:close()
end
