require("ui/uieditor/widgets/pc/footer/footerbutton_persistentrightcontainer")
require("ui/uieditor/widgets/pc/footer/footerbuttonpromptpc")
CoD.FooterButton_Frontend_PC_Right = InheritFrom(LUI.UIElement)
CoD.FooterButton_Frontend_PC_Right.__defaultWidth = 1920
CoD.FooterButton_Frontend_PC_Right.__defaultHeight = 100
CoD.FooterButton_Frontend_PC_Right.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.FooterButton_Frontend_PC_Right)
	self.id = "FooterButton_Frontend_PC_Right"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local Ybtn = CoD.FooterButtonPromptPC.new(f1_arg0, f1_arg1, 0, 0, 755, 875, 0, 1, 0, 0)
	Ybtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Ybtn.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	Ybtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xby_pstriangle"], false, function(model)
		Ybtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Ybtn, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Ybtn)
	self.Ybtn = Ybtn
	local Padbtn = CoD.FooterButtonPromptPC.new(f1_arg0, f1_arg1, 0, 0, 875, 1116, 0, 1, 0, 0)
	Padbtn:subscribeToGlobalModel(f1_arg1, "Controller", "back_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Padbtn.buttonPromptImage:setImage(RegisterImage(f5_local0))
		end
	end)
	Padbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_back"], false, function(model)
		Padbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Padbtn, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Padbtn)
	self.Padbtn = Padbtn
	local RTbtn = CoD.FooterButtonPromptPC.new(f1_arg0, f1_arg1, 0, 0, 1116, 1250, 0, 1, 0, 0)
	RTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			RTbtn.buttonPromptImage:setImage(RegisterImage(f8_local0))
		end
	end)
	RTbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_rtrig"], false, function(model)
		RTbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(RTbtn, "setState", function(element, controller, f10_arg2, f10_arg3, f10_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(RTbtn)
	self.RTbtn = RTbtn
	local LeftStick = CoD.FooterButtonPromptPC.new(f1_arg0, f1_arg1, 0, 0, 1250, 1384, 0, 1, 0, 0)
	LeftStick:subscribeToGlobalModel(f1_arg1, "Controller", "move_left_stick_button_image", function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			LeftStick.buttonPromptImage:setImage(RegisterImage(f11_local0))
		end
	end)
	LeftStick:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_lstick_pressed"], false, function(model)
		LeftStick:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(LeftStick, "setState", function(element, controller, f13_arg2, f13_arg3, f13_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(LeftStick)
	self.LeftStick = LeftStick
	local OptionsBtn = CoD.FooterButtonPromptPC.new(f1_arg0, f1_arg1, 0, 0, 1384, 1518, 0, 1, 0, 0)
	OptionsBtn:subscribeToGlobalModel(f1_arg1, "Controller", "start_button_image", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			OptionsBtn.buttonPromptImage:setImage(RegisterImage(f14_local0))
		end
	end)
	OptionsBtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_start"], false, function(model)
		OptionsBtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(OptionsBtn, "setState", function(element, controller, f16_arg2, f16_arg3, f16_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(OptionsBtn)
	self.OptionsBtn = OptionsBtn
	local Xbtn = CoD.FooterButtonPromptPC.new(f1_arg0, f1_arg1, 0, 0, 1518, 1652, -0, 1, 0, 0)
	Xbtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			Xbtn.buttonPromptImage:setImage(RegisterImage(f17_local0))
		end
	end)
	Xbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xbx_pssquare"], false, function(model)
		Xbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Xbtn, "setState", function(element, controller, f19_arg2, f19_arg3, f19_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Xbtn)
	self.Xbtn = Xbtn
	local RJoystickbtn = CoD.FooterButtonPromptPC.new(f1_arg0, f1_arg1, 0, 0, 1652, 1786, 0, 1, 0, 0)
	RJoystickbtn:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			RJoystickbtn.buttonPromptImage:setImage(RegisterImage(f20_local0))
		end
	end)
	RJoystickbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_rstick_pressed"], false, function(model)
		RJoystickbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(RJoystickbtn, "setState", function(element, controller, f22_arg2, f22_arg3, f22_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(RJoystickbtn)
	self.RJoystickbtn = RJoystickbtn
	local LTbtn = CoD.FooterButtonPromptPC.new(f1_arg0, f1_arg1, 0, 0, 1786, 1920, 0, 1, 0, 0)
	LTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			LTbtn.buttonPromptImage:setImage(RegisterImage(f23_local0))
		end
	end)
	LTbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_ltrig"], false, function(model)
		LTbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(LTbtn, "setState", function(element, controller, f25_arg2, f25_arg3, f25_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(LTbtn)
	self.LTbtn = LTbtn
	local PersistentRightContainer = CoD.FooterButton_PersistentRightContainer.new(f1_arg0, f1_arg1, 0, 0, 635, 1183, 0, 0, 0, 54)
	self:addElement(PersistentRightContainer)
	self.PersistentRightContainer = PersistentRightContainer
	if CoD.isPC then
		Ybtn.id = "Ybtn"
	end
	if CoD.isPC then
		Padbtn.id = "Padbtn"
	end
	if CoD.isPC then
		RTbtn.id = "RTbtn"
	end
	if CoD.isPC then
		LeftStick.id = "LeftStick"
	end
	if CoD.isPC then
		OptionsBtn.id = "OptionsBtn"
	end
	if CoD.isPC then
		Xbtn.id = "Xbtn"
	end
	if CoD.isPC then
		RJoystickbtn.id = "RJoystickbtn"
	end
	if CoD.isPC then
		LTbtn.id = "LTbtn"
	end
	if CoD.isPC then
		PersistentRightContainer.id = "PersistentRightContainer"
	end
	self.__defaultFocus = Padbtn
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_Frontend_PC_Right.__onClose = function(f26_arg0)
	f26_arg0.Ybtn:close()
	f26_arg0.Padbtn:close()
	f26_arg0.RTbtn:close()
	f26_arg0.LeftStick:close()
	f26_arg0.OptionsBtn:close()
	f26_arg0.Xbtn:close()
	f26_arg0.RJoystickbtn:close()
	f26_arg0.LTbtn:close()
	f26_arg0.PersistentRightContainer:close()
end
