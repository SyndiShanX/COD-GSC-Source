require("ui/uieditor/widgets/freecursor/infopanelsubwidgets/freecursornolabelbuttonprompt")
CoD.freeCursorNoLabelButtonPromptContainer = InheritFrom(LUI.UIElement)
CoD.freeCursorNoLabelButtonPromptContainer.__defaultWidth = 621
CoD.freeCursorNoLabelButtonPromptContainer.__defaultHeight = 36
CoD.freeCursorNoLabelButtonPromptContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.freeCursorNoLabelButtonPromptContainer)
	self.id = "freeCursorNoLabelButtonPromptContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local LeftStick = CoD.freeCursorNoLabelButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 36, 0, 0, 0, 36)
	LeftStick:subscribeToGlobalModel(f1_arg1, "Controller", "move_left_stick_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LeftStick.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	LeftStick:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_lstick_pressed"], false, function(model)
		LeftStick:setModel(model, f1_arg1)
	end)
	self:addElement(LeftStick)
	self.LeftStick = LeftStick
	local RTbtn = CoD.freeCursorNoLabelButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 36, 72, 0, 0, 0, 36)
	RTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RTbtn.buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	RTbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_rtrig"], false, function(model)
		RTbtn:setModel(model, f1_arg1)
	end)
	self:addElement(RTbtn)
	self.RTbtn = RTbtn
	local LTbtn = CoD.freeCursorNoLabelButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 72, 108, 0, 0, 0, 36)
	LTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			LTbtn.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	LTbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_ltrig"], false, function(model)
		LTbtn:setModel(model, f1_arg1)
	end)
	self:addElement(LTbtn)
	self.LTbtn = LTbtn
	local Ybtn = CoD.freeCursorNoLabelButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 108, 144, 0, 0, 0, 36)
	Ybtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Ybtn.buttonPromptImage:setImage(RegisterImage(f8_local0))
		end
	end)
	Ybtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xby_pstriangle"], false, function(model)
		Ybtn:setModel(model, f1_arg1)
	end)
	self:addElement(Ybtn)
	self.Ybtn = Ybtn
	local OptionsBtn = CoD.freeCursorNoLabelButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 144, 180, 0, 0, 0, 36)
	OptionsBtn:subscribeToGlobalModel(f1_arg1, "Controller", "start_button_image", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			OptionsBtn.buttonPromptImage:setImage(RegisterImage(f10_local0))
		end
	end)
	OptionsBtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_start"], false, function(model)
		OptionsBtn:setModel(model, f1_arg1)
	end)
	self:addElement(OptionsBtn)
	self.OptionsBtn = OptionsBtn
	local Xbtn = CoD.freeCursorNoLabelButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 180, 216, 0, 0, 0, 36)
	Xbtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Xbtn.buttonPromptImage:setImage(RegisterImage(f12_local0))
		end
	end)
	Xbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xbx_pssquare"], false, function(model)
		Xbtn:setModel(model, f1_arg1)
	end)
	self:addElement(Xbtn)
	self.Xbtn = Xbtn
	local Bbtn = CoD.freeCursorNoLabelButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 216, 252, 0, 0, 0, 36)
	Bbtn:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			Bbtn.buttonPromptImage:setImage(RegisterImage(f14_local0))
		end
	end)
	Bbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xbb_pscircle"], false, function(model)
		Bbtn:setModel(model, f1_arg1)
	end)
	self:addElement(Bbtn)
	self.Bbtn = Bbtn
	local Abtn = CoD.freeCursorNoLabelButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 252, 288, 0, 0, 0, 36)
	Abtn:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			Abtn.buttonPromptImage:setImage(RegisterImage(f16_local0))
		end
	end)
	Abtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xba_pscross"], false, function(model)
		Abtn:setModel(model, f1_arg1)
	end)
	self:addElement(Abtn)
	self.Abtn = Abtn
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local9 = self
	CoD.FreeCursorUtility.MakeResizingHorizontalLayout(self)
	return self
end
CoD.freeCursorNoLabelButtonPromptContainer.__onClose = function(f18_arg0)
	f18_arg0.LeftStick:close()
	f18_arg0.RTbtn:close()
	f18_arg0.LTbtn:close()
	f18_arg0.Ybtn:close()
	f18_arg0.OptionsBtn:close()
	f18_arg0.Xbtn:close()
	f18_arg0.Bbtn:close()
	f18_arg0.Abtn:close()
end
