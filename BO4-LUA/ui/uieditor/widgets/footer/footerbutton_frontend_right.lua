require("x64:561c804ce339d2b")
require("x64:d36334c33274313")
require("x64:29187ea00d726c3")
CoD.FooterButton_Frontend_Right = InheritFrom(LUI.UIElement)
CoD.FooterButton_Frontend_Right.__defaultWidth = 1920
CoD.FooterButton_Frontend_Right.__defaultHeight = 48
CoD.FooterButton_Frontend_Right.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.FooterButton_Frontend_Right)
	self.id = "FooterButton_Frontend_Right"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FooterButtonDoublePrompts = CoD.FooterButtonDoublePrompts.new(f1_arg0, f1_arg1, 0, 0, 781, 1054, 0, 0, 0, 48)
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
	FooterButtonDoublePrompts:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_lb"], false, function(model)
		FooterButtonDoublePrompts:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(FooterButtonDoublePrompts, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(FooterButtonDoublePrompts)
	self.FooterButtonDoublePrompts = FooterButtonDoublePrompts
	local RTbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1054, 1186, 0, 0, 0, 48)
	RTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			RTbtn.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	RTbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_rtrig"], false, function(model)
		RTbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(RTbtn, "setState", function(element, controller, f8_arg2, f8_arg3, f8_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(RTbtn)
	self.RTbtn = RTbtn
	local LeftStick = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1186, 1318, 0, 0, 0, 48)
	LeftStick:subscribeToGlobalModel(f1_arg1, "Controller", "move_left_stick_button_image", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			LeftStick.buttonPromptImage:setImage(RegisterImage(f9_local0))
		end
	end)
	LeftStick:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_lstick_pressed"], false, function(model)
		LeftStick:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(LeftStick, "setState", function(element, controller, f11_arg2, f11_arg3, f11_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(LeftStick)
	self.LeftStick = LeftStick
	local RJoystickbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1318, 1454, 0, 0, 0, 48)
	RJoystickbtn:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			RJoystickbtn.buttonPromptImage:setImage(RegisterImage(f12_local0))
		end
	end)
	RJoystickbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_rstick_pressed"], false, function(model)
		RJoystickbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(RJoystickbtn, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(RJoystickbtn)
	self.RJoystickbtn = RJoystickbtn
	local Xbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1454, 1586, 0, 0, 0, 48)
	Xbtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			Xbtn.buttonPromptImage:setImage(RegisterImage(f15_local0))
		end
	end)
	Xbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xbx_pssquare"], false, function(model)
		Xbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Xbtn, "setState", function(element, controller, f17_arg2, f17_arg3, f17_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Xbtn)
	self.Xbtn = Xbtn
	local Abtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1586, 1718, 0, 0, 0, 48)
	Abtn:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			Abtn.buttonPromptImage:setImage(RegisterImage(f18_local0))
		end
	end)
	Abtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xba_pscross"], false, function(model)
		Abtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Abtn, "setState", function(element, controller, f20_arg2, f20_arg3, f20_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Abtn)
	self.Abtn = Abtn
	local Bbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1718, 1838, 0, 0, 0, 48)
	Bbtn:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			Bbtn.buttonPromptImage:setImage(RegisterImage(f21_local0))
		end
	end)
	Bbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xbb_pscircle"], false, function(model)
		Bbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Bbtn, "setState", function(element, controller, f23_arg2, f23_arg3, f23_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Bbtn)
	self.Bbtn = Bbtn
	local Spacer02 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 1838, 1920, 0, 0, 0, 48)
	self:addElement(Spacer02)
	self.Spacer02 = Spacer02
	if CoD.isPC then
		RTbtn.id = "RTbtn"
	end
	if CoD.isPC then
		LeftStick.id = "LeftStick"
	end
	if CoD.isPC then
		RJoystickbtn.id = "RJoystickbtn"
	end
	if CoD.isPC then
		Xbtn.id = "Xbtn"
	end
	if CoD.isPC then
		Abtn.id = "Abtn"
	end
	if CoD.isPC then
		Bbtn.id = "Bbtn"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_Frontend_Right.__onClose = function(f24_arg0)
	f24_arg0.FooterButtonDoublePrompts:close()
	f24_arg0.RTbtn:close()
	f24_arg0.LeftStick:close()
	f24_arg0.RJoystickbtn:close()
	f24_arg0.Xbtn:close()
	f24_arg0.Abtn:close()
	f24_arg0.Bbtn:close()
	f24_arg0.Spacer02:close()
end
