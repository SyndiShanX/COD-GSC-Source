require("x64:d36334c33274313")
CoD.CodCasterSettingsSideBarLeftbuttoncontainer = InheritFrom(LUI.UIElement)
CoD.CodCasterSettingsSideBarLeftbuttoncontainer.__defaultWidth = 580
CoD.CodCasterSettingsSideBarLeftbuttoncontainer.__defaultHeight = 48
CoD.CodCasterSettingsSideBarLeftbuttoncontainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CodCasterSettingsSideBarLeftbuttoncontainer)
	self.id = "CodCasterSettingsSideBarLeftbuttoncontainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local LTbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 132, 0, 0, 0, 48)
	LTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LTbtn.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	LTbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_ltrig"], false, function(model)
		LTbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(LTbtn, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(LTbtn)
	self.LTbtn = LTbtn
	local Xbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 142, 274, 0, 0, 0, 48)
	Xbtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Xbtn.buttonPromptImage:setImage(RegisterImage(f5_local0))
		end
	end)
	Xbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xbx_pssquare"], false, function(model)
		Xbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Xbtn, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Xbtn)
	self.Xbtn = Xbtn
	local RTbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 284, 416, 0, 0, 0, 48)
	RTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			RTbtn.buttonPromptImage:setImage(RegisterImage(f8_local0))
		end
	end)
	RTbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_rtrig"], false, function(model)
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
	if CoD.isPC then
		LTbtn.id = "LTbtn"
	end
	if CoD.isPC then
		Xbtn.id = "Xbtn"
	end
	if CoD.isPC then
		RTbtn.id = "RTbtn"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterSettingsSideBarLeftbuttoncontainer.__onClose = function(f11_arg0)
	f11_arg0.LTbtn:close()
	f11_arg0.Xbtn:close()
	f11_arg0.RTbtn:close()
end
