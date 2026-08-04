require("ui/uieditor/widgets/fe_nat")
require("ui/uieditor/widgets/pc/footer/footerbutton_persistentleftcontainer")
require("ui/uieditor/widgets/pc/footer/footerbutton_quitback")
require("ui/uieditor/widgets/pc/utility/verticallistspacer")
CoD.FooterButton_Frontend_PC_Left = InheritFrom(LUI.UIElement)
CoD.FooterButton_Frontend_PC_Left.__defaultWidth = 1000
CoD.FooterButton_Frontend_PC_Left.__defaultHeight = 100
CoD.FooterButton_Frontend_PC_Left.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.FooterButton_Frontend_PC_Left)
	self.id = "FooterButton_Frontend_PC_Left"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local Spacer3 = LUI.UIImage.new(0, 0, 0, 1, 0, 1, 0, 0)
	Spacer3:setRGB(0, 0, 0)
	Spacer3:setAlpha(0)
	self:addElement(Spacer3)
	self.Spacer3 = Spacer3
	local ESCAPEbtn = CoD.FooterButton_QuitBack.new(f1_arg0, f1_arg1, 0, 0, 1, 140, -0, 1, 0, 0)
	ESCAPEbtn:mergeStateConditions({
		{
			stateName = "DisabledGamepad",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_disable_prompts"])
				if f2_local0 then
					if not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1) then
						f2_local0 = IsGamepad(f1_arg1)
						if f2_local0 then
							if not ShouldHideButtonPromptForPC(element, f1_arg1) then
								f2_local0 = AlwaysFalse()
							else
								f2_local0 = false
							end
						else
							return f2_local0
						end
					end
					f2_local0 = false
				end
				return f2_local0
			end,
		},
		{
			stateName = "EnabledGamepad",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "", Enum.LUIButtonPromptStates[@"flag_enable_prompts"])
				if f3_local0 then
					if not ShouldHideButtonPromptForPC(element, f1_arg1) then
						f3_local0 = IsGamepad(f1_arg1)
						if f3_local0 then
							if not CoD.FreeCursorUtility.ShowingContextualPromptForFlags(element, f1_arg1) then
								f3_local0 = AlwaysFalse()
							else
								f3_local0 = false
							end
						else
							return f3_local0
						end
					end
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	ESCAPEbtn:linkToElementModel(ESCAPEbtn, nil, true, function(model)
		f1_arg0:updateElementState(ESCAPEbtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	local Spacer = ESCAPEbtn
	local Bbtn = ESCAPEbtn.subscribeToModel
	local PersistentLeftContainer = DataSources.FreeCursor.getModel(f1_arg1)
	Bbtn(Spacer, PersistentLeftContainer.usingCursorInput, function(f5_arg0)
		f1_arg0:updateElementState(ESCAPEbtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "usingCursorInput",
		})
	end, false)
	Spacer = ESCAPEbtn
	Bbtn = ESCAPEbtn.subscribeToModel
	PersistentLeftContainer = DataSources.FreeCursor.getModel(f1_arg1)
	Bbtn(Spacer, PersistentLeftContainer.hidden, function(f6_arg0)
		f1_arg0:updateElementState(ESCAPEbtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hidden",
		})
	end, false)
	Spacer = ESCAPEbtn
	Bbtn = ESCAPEbtn.subscribeToModel
	PersistentLeftContainer = Engine.GetModelForController(f1_arg1)
	Bbtn(Spacer, PersistentLeftContainer.activeKeys, function(f7_arg0)
		f1_arg0:updateElementState(ESCAPEbtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "activeKeys",
		})
	end, false)
	ESCAPEbtn:linkToElementModel(ESCAPEbtn, "flags", true, function(model)
		f1_arg0:updateElementState(ESCAPEbtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "flags",
		})
	end)
	ESCAPEbtn:appendEventHandler("input_source_changed", function(f9_arg0, f9_arg1)
		f9_arg1.menu = f9_arg1.menu or f1_arg0
		f1_arg0:updateElementState(ESCAPEbtn, f9_arg1)
	end)
	Spacer = ESCAPEbtn
	Bbtn = ESCAPEbtn.subscribeToModel
	PersistentLeftContainer = Engine.GetModelForController(f1_arg1)
	Bbtn(Spacer, PersistentLeftContainer.LastInput, function(f10_arg0)
		f1_arg0:updateElementState(ESCAPEbtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	ESCAPEbtn:linkToElementModel(ESCAPEbtn, "Label", true, function(model)
		f1_arg0:updateElementState(ESCAPEbtn, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "Label",
		})
	end)
	ESCAPEbtn:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			ESCAPEbtn.buttonPromptImage:setImage(RegisterImage(f12_local0))
		end
	end)
	ESCAPEbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"hash_64D2505E19049444"], false, function(model)
		ESCAPEbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(ESCAPEbtn, "setState", function(element, controller, f14_arg2, f14_arg3, f14_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(ESCAPEbtn)
	self.ESCAPEbtn = ESCAPEbtn
	Bbtn = CoD.FooterButton_QuitBack.new(f1_arg0, f1_arg1, 0, 0, 140, 279, 0, 1, 0, 0)
	Bbtn:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			Bbtn.buttonPromptImage:setImage(RegisterImage(f15_local0))
		end
	end)
	Bbtn:linkToElementModel(self, "" .. Enum.LUIButton[@"lui_key_xbb_pscircle"], false, function(model)
		Bbtn:setModel(model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(Bbtn, "setState", function(element, controller, f17_arg2, f17_arg3, f17_arg4)
		if IsInDefaultState(element) then
			HideWidget(element)
		else
			ShowWidget(element)
		end
	end)
	self:addElement(Bbtn)
	self.Bbtn = Bbtn
	Spacer = LUI.UIImage.new(0, 0, 279, 280, 0, 1, 0, 0)
	Spacer:setRGB(0, 0, 0)
	Spacer:setAlpha(0)
	self:addElement(Spacer)
	self.Spacer = Spacer
	PersistentLeftContainer = CoD.FooterButton_PersistentLeftContainer.new(f1_arg0, f1_arg1, 0, 0, 280, 879, 0, 0, 0, 54)
	self:addElement(PersistentLeftContainer)
	self.PersistentLeftContainer = PersistentLeftContainer
	local Spacer2 = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 879, 909, 0, 1, 0, 0)
	self:addElement(Spacer2)
	self.Spacer2 = Spacer2
	local feNAT = CoD.fe_NAT.new(f1_arg0, f1_arg1, 0, 0, 909, 1135, 1, 1, -39, -9)
	feNAT:setAlpha(0)
	self:addElement(feNAT)
	self.feNAT = feNAT
	self:subscribeToGlobalModel(f1_arg1, "GlobalModel", "lobbyRoot.lobbyNav", function(model)
		local f18_local0 = self
		CoD.BreadcrumbUtility.UpdateStartMenuBreadcrumb(f1_arg1)
	end)
	if CoD.isPC then
		ESCAPEbtn.id = "ESCAPEbtn"
	end
	if CoD.isPC then
		Bbtn.id = "Bbtn"
	end
	if CoD.isPC then
		PersistentLeftContainer.id = "PersistentLeftContainer"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FooterButton_Frontend_PC_Left.__onClose = function(f19_arg0)
	f19_arg0.ESCAPEbtn:close()
	f19_arg0.Bbtn:close()
	f19_arg0.PersistentLeftContainer:close()
	f19_arg0.Spacer2:close()
	f19_arg0.feNAT:close()
end
