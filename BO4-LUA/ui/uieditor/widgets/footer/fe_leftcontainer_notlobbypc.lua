require("ui/uieditor/widgets/pc/pc_fullscreenpopup_buttons")
CoD.fe_LeftContainer_NOTLobbyPC = InheritFrom(LUI.UIElement)
CoD.fe_LeftContainer_NOTLobbyPC.__defaultWidth = 792
CoD.fe_LeftContainer_NOTLobbyPC.__defaultHeight = 60
CoD.fe_LeftContainer_NOTLobbyPC.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 15, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.fe_LeftContainer_NOTLobbyPC)
	self.id = "fe_LeftContainer_NOTLobbyPC"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Abtn = CoD.PC_FullscreenPopup_Buttons.new(f1_arg0, f1_arg1, 0, 0, 0, 190, 0, 0, 0, 60)
	Abtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xba_pscross"], false, function(model)
		Abtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Abtn, "setState", function(element, controller, f3_arg2, f3_arg3, f3_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Abtn)
	self.Abtn = Abtn
	local Xbtn = CoD.PC_FullscreenPopup_Buttons.new(f1_arg0, f1_arg1, 0, 0, 195, 385, 0, 0, 0, 60)
	Xbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xbx_pssquare"], false, function(model)
		Xbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Xbtn, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Xbtn)
	self.Xbtn = Xbtn
	local Bbtn = CoD.PC_FullscreenPopup_Buttons.new(f1_arg0, f1_arg1, 0, 0, 390, 580, 0, 0, 0, 60)
	Bbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xbb_pscircle"], false, function(model)
		Bbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Bbtn, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Bbtn)
	self.Bbtn = Bbtn
	local OptionsBtn = CoD.PC_FullscreenPopup_Buttons.new(f1_arg0, f1_arg1, 0, 0, 585, 775, 0, 0, 0, 60)
	OptionsBtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_start"], false, function(model)
		OptionsBtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(OptionsBtn, "setState", function(element, controller, f9_arg2, f9_arg3, f9_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(OptionsBtn)
	self.OptionsBtn = OptionsBtn
	local Ybtn = CoD.PC_FullscreenPopup_Buttons.new(f1_arg0, f1_arg1, 0, 0, 780, 970, 0, 0, 0, 60)
	Ybtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xby_pstriangle"], false, function(model)
		Ybtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Ybtn, "setState", function(element, controller, f11_arg2, f11_arg3, f11_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Ybtn)
	self.Ybtn = Ybtn
	local LTbtn = CoD.PC_FullscreenPopup_Buttons.new(f1_arg0, f1_arg1, 0, 0, 975, 1165, 0, 0, 0, 60)
	LTbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_ltrig"], false, function(model)
		LTbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(LTbtn, "setState", function(element, controller, f13_arg2, f13_arg3, f13_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(LTbtn)
	self.LTbtn = LTbtn
	local RTbtn = CoD.PC_FullscreenPopup_Buttons.new(f1_arg0, f1_arg1, 0, 0, 1170, 1360, 0, 0, 0, 60)
	RTbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_rtrig"], false, function(model)
		RTbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(RTbtn, "setState", function(element, controller, f15_arg2, f15_arg3, f15_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(RTbtn)
	self.RTbtn = RTbtn
	local LeftStick = CoD.PC_FullscreenPopup_Buttons.new(f1_arg0, f1_arg1, 0, 0, 1365, 1555, 0, 0, 0, 60)
	LeftStick:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_lstick_pressed"], false, function(model)
		LeftStick:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(LeftStick, "setState", function(element, controller, f17_arg2, f17_arg3, f17_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(LeftStick)
	self.LeftStick = LeftStick
	Abtn.id = "Abtn"
	Xbtn.id = "Xbtn"
	Bbtn.id = "Bbtn"
	OptionsBtn.id = "OptionsBtn"
	Ybtn.id = "Ybtn"
	LTbtn.id = "LTbtn"
	RTbtn.id = "RTbtn"
	LeftStick.id = "LeftStick"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.fe_LeftContainer_NOTLobbyPC.__onClose = function(f18_arg0)
	f18_arg0.Abtn:close()
	f18_arg0.Xbtn:close()
	f18_arg0.Bbtn:close()
	f18_arg0.OptionsBtn:close()
	f18_arg0.Ybtn:close()
	f18_arg0.LTbtn:close()
	f18_arg0.RTbtn:close()
	f18_arg0.LeftStick:close()
end
