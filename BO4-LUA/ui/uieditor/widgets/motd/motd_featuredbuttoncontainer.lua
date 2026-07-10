require("x64:d36334c33274313")
CoD.MOTD_FeaturedButtonContainer = InheritFrom(LUI.UIElement)
CoD.MOTD_FeaturedButtonContainer.__defaultWidth = 400
CoD.MOTD_FeaturedButtonContainer.__defaultHeight = 48
CoD.MOTD_FeaturedButtonContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Right)
	self:setClass(CoD.MOTD_FeaturedButtonContainer)
	self.id = "MOTD_FeaturedButtonContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local Xbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 268, 400, 0, 0, 0, 48)
	Xbtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Xbtn.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	Xbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xbx_pssquare"], false, function(model)
		Xbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Xbtn, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Xbtn)
	self.Xbtn = Xbtn
	local Bbtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 148, 268, 0, 0, 0, 48)
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
	local Abtn = CoD.FooterButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 16, 148, 0, 0, 0, 48)
	Abtn:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Abtn.buttonPromptImage:setImage(RegisterImage(f8_local0))
		end
	end)
	Abtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xba_pscross"], false, function(model)
		Abtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Abtn, "setState", function(element, controller, f10_arg2, f10_arg3, f10_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Abtn)
	self.Abtn = Abtn
	if CoD.isPC then
		Xbtn.id = "Xbtn"
	end
	if CoD.isPC then
		Bbtn.id = "Bbtn"
	end
	if CoD.isPC then
		Abtn.id = "Abtn"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MOTD_FeaturedButtonContainer.__onClose = function(f11_arg0)
	f11_arg0.Xbtn:close()
	f11_arg0.Bbtn:close()
	f11_arg0.Abtn:close()
end
