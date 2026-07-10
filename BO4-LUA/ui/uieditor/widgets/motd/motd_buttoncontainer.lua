require("x64:d36334c33274313")
CoD.MOTD_ButtonContainer = InheritFrom(LUI.UIElement)
CoD.MOTD_ButtonContainer.__defaultWidth = 252
CoD.MOTD_ButtonContainer.__defaultHeight = 48
CoD.MOTD_ButtonContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.MOTD_ButtonContainer)
	self.id = "MOTD_ButtonContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local Abtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 120, 252, 0, 0, 0, 48)
	Abtn:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Abtn.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	Abtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xba_pscross"], false, function(model)
		Abtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Abtn, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Abtn)
	self.Abtn = Abtn
	local Bbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 120, 0, 0, 0, 48)
	Bbtn:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Bbtn.buttonPromptImage:setImage(RegisterImage(f5_local0))
		end
	end)
	Bbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xbb_pscircle"], false, function(model)
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
CoD.MOTD_ButtonContainer.__onClose = function(f8_arg0)
	f8_arg0.Abtn:close()
	f8_arg0.Bbtn:close()
end
