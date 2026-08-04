require("ui/uieditor/widgets/footerbuttonprompt")
CoD.fe_LeftContainer_NOTLobby = InheritFrom(LUI.UIElement)
CoD.fe_LeftContainer_NOTLobby.__defaultWidth = 792
CoD.fe_LeftContainer_NOTLobby.__defaultHeight = 48
CoD.fe_LeftContainer_NOTLobby.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.fe_LeftContainer_NOTLobby)
	self.id = "fe_LeftContainer_NOTLobby"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Abtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 132, 1, 1, -48, 0)
	Abtn:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Abtn.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	Abtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xba_pscross"], false, function(model)
		Abtn:setModel(model, f1_arg1)
	end)
	self:addElement(Abtn)
	self.Abtn = Abtn
	local Xbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 132, 264, 1, 1, -48, 0)
	Xbtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Xbtn.buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	Xbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xbx_pssquare"], false, function(model)
		Xbtn:setModel(model, f1_arg1)
	end)
	self:addElement(Xbtn)
	self.Xbtn = Xbtn
	local Bbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 264, 384, 1, 1, -48, 0)
	Bbtn:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Bbtn.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	Bbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xbb_pscircle"], false, function(model)
		Bbtn:setModel(model, f1_arg1)
	end)
	self:addElement(Bbtn)
	self.Bbtn = Bbtn
	local OptionsBtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 384, 516, 1, 1, -48, 0)
	OptionsBtn:subscribeToGlobalModel(f1_arg1, "Controller", "start_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			OptionsBtn.buttonPromptImage:setImage(RegisterImage(f8_local0))
		end
	end)
	OptionsBtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_start"], false, function(model)
		OptionsBtn:setModel(model, f1_arg1)
	end)
	self:addElement(OptionsBtn)
	self.OptionsBtn = OptionsBtn
	local Ybtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 516, 648, 1, 1, -48, 0)
	Ybtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Ybtn.buttonPromptImage:setImage(RegisterImage(f10_local0))
		end
	end)
	Ybtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xby_pstriangle"], false, function(model)
		Ybtn:setModel(model, f1_arg1)
	end)
	self:addElement(Ybtn)
	self.Ybtn = Ybtn
	local LTbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 648, 780, 1, 1, -48, 0)
	LTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			LTbtn.buttonPromptImage:setImage(RegisterImage(f12_local0))
		end
	end)
	LTbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_ltrig"], false, function(model)
		LTbtn:setModel(model, f1_arg1)
	end)
	self:addElement(LTbtn)
	self.LTbtn = LTbtn
	local RTbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 780, 912, 1, 1, -48, 0)
	RTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			RTbtn.buttonPromptImage:setImage(RegisterImage(f14_local0))
		end
	end)
	RTbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_rtrig"], false, function(model)
		RTbtn:setModel(model, f1_arg1)
	end)
	self:addElement(RTbtn)
	self.RTbtn = RTbtn
	local LeftStick = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 912, 1044, 1, 1, -48, 0)
	LeftStick:subscribeToGlobalModel(f1_arg1, "Controller", "move_left_stick_button_image", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			LeftStick.buttonPromptImage:setImage(RegisterImage(f16_local0))
		end
	end)
	LeftStick:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_lstick_pressed"], false, function(model)
		LeftStick:setModel(model, f1_arg1)
	end)
	self:addElement(LeftStick)
	self.LeftStick = LeftStick
	self:mergeStateConditions({
		{
			stateName = "MouseKeyboard",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f19_arg0, f19_arg1)
		f19_arg1.menu = f19_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f19_arg1)
	end)
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine.GetModelForController(f1_arg1)
	f1_local10(f1_local9, f1_local11.LastInput, function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if CoD.isPC then
		Abtn.id = "Abtn"
	end
	if CoD.isPC then
		Xbtn.id = "Xbtn"
	end
	if CoD.isPC then
		Bbtn.id = "Bbtn"
	end
	if CoD.isPC then
		OptionsBtn.id = "OptionsBtn"
	end
	if CoD.isPC then
		Ybtn.id = "Ybtn"
	end
	if CoD.isPC then
		LTbtn.id = "LTbtn"
	end
	if CoD.isPC then
		RTbtn.id = "RTbtn"
	end
	if CoD.isPC then
		LeftStick.id = "LeftStick"
	end
	self.__defaultFocus = Bbtn
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.fe_LeftContainer_NOTLobby.__resetProperties = function(f21_arg0)
	f21_arg0.Bbtn:completeAnimation()
	f21_arg0.Abtn:completeAnimation()
	f21_arg0.Bbtn:setAlpha(1)
	f21_arg0.Abtn:setAlpha(1)
end
CoD.fe_LeftContainer_NOTLobby.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(0)
		end,
	},
	MouseKeyboard = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.Abtn:completeAnimation()
			f23_arg0.Abtn:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Abtn)
			f23_arg0.Bbtn:completeAnimation()
			f23_arg0.Bbtn:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Bbtn)
		end,
	},
}
CoD.fe_LeftContainer_NOTLobby.__onClose = function(f24_arg0)
	f24_arg0.Abtn:close()
	f24_arg0.Xbtn:close()
	f24_arg0.Bbtn:close()
	f24_arg0.OptionsBtn:close()
	f24_arg0.Ybtn:close()
	f24_arg0.LTbtn:close()
	f24_arg0.RTbtn:close()
	f24_arg0.LeftStick:close()
end
