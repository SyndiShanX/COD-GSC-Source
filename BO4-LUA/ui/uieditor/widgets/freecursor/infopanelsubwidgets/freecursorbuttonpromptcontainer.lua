require("x64:9d75c4b8d40224b")
require("x64:3fdb971f479eb0c")
CoD.freeCursorButtonPromptContainer = InheritFrom(LUI.UIElement)
CoD.freeCursorButtonPromptContainer.__defaultWidth = 792
CoD.freeCursorButtonPromptContainer.__defaultHeight = 36
CoD.freeCursorButtonPromptContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	if IsPC() then
		UseFirstElementAsBacking(self, true)
	end
	self:setClass(CoD.freeCursorButtonPromptContainer)
	self.id = "freeCursorButtonPromptContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = nil
	BG = CoD.PC_TooltipsPromptsBackground.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(BG)
	self.BG = BG
	local Xbtn = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 132, 0.5, 0.5, -18, 18)
	Xbtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Xbtn.button.buttonPromptImage:setImage(RegisterImage(f2_local0))
		end
	end)
	Xbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xbx_pssquare"], false, function(model)
		Xbtn:setModel(model, f1_arg1)
	end)
	self:addElement(Xbtn)
	self.Xbtn = Xbtn
	local Abtn = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 132, 264, 0.5, 0.5, -18, 18)
	Abtn:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Abtn.button.buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	Abtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xba_pscross"], false, function(model)
		Abtn:setModel(model, f1_arg1)
	end)
	self:addElement(Abtn)
	self.Abtn = Abtn
	local Bbtn = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 264, 384, 0.5, 0.5, -18, 18)
	Bbtn:subscribeToGlobalModel(f1_arg1, "Controller", "secondary_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Bbtn.button.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	Bbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xbb_pscircle"], false, function(model)
		Bbtn:setModel(model, f1_arg1)
	end)
	self:addElement(Bbtn)
	self.Bbtn = Bbtn
	local OptionsBtn = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 384, 516, 0.5, 0.5, -18, 18)
	OptionsBtn:subscribeToGlobalModel(f1_arg1, "Controller", "start_button_image", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			OptionsBtn.button.buttonPromptImage:setImage(RegisterImage(f8_local0))
		end
	end)
	OptionsBtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_start"], false, function(model)
		OptionsBtn:setModel(model, f1_arg1)
	end)
	self:addElement(OptionsBtn)
	self.OptionsBtn = OptionsBtn
	local Ybtn = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 516, 648, 0.5, 0.5, -18, 18)
	Ybtn:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Ybtn.button.buttonPromptImage:setImage(RegisterImage(f10_local0))
		end
	end)
	Ybtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xby_pstriangle"], false, function(model)
		Ybtn:setModel(model, f1_arg1)
	end)
	self:addElement(Ybtn)
	self.Ybtn = Ybtn
	local LTbtn = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 648, 780, 0.5, 0.5, -18, 18)
	LTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "left_trigger_button_image", function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			LTbtn.button.buttonPromptImage:setImage(RegisterImage(f12_local0))
		end
	end)
	LTbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_ltrig"], false, function(model)
		LTbtn:setModel(model, f1_arg1)
	end)
	self:addElement(LTbtn)
	self.LTbtn = LTbtn
	local RTbtn = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 780, 912, 0.5, 0.5, -18, 18)
	RTbtn:subscribeToGlobalModel(f1_arg1, "Controller", "right_trigger_button_image", function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			RTbtn.button.buttonPromptImage:setImage(RegisterImage(f14_local0))
		end
	end)
	RTbtn:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_rtrig"], false, function(model)
		RTbtn:setModel(model, f1_arg1)
	end)
	self:addElement(RTbtn)
	self.RTbtn = RTbtn
	local LeftStick = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 912, 1044, 0.5, 0.5, -18, 18)
	LeftStick:subscribeToGlobalModel(f1_arg1, "Controller", "move_left_stick_button_image", function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			LeftStick.button.buttonPromptImage:setImage(RegisterImage(f16_local0))
		end
	end)
	LeftStick:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_lstick_pressed"], false, function(model)
		LeftStick:setModel(model, f1_arg1)
	end)
	self:addElement(LeftStick)
	self.LeftStick = LeftStick
	local PCKey2 = nil
	PCKey2 = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1044, 1176, 0.5, 0.5, -18, 18)
	PCKey2:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_pckey_2"], false, function(model)
		PCKey2:setModel(model, f1_arg1)
	end)
	self:addElement(PCKey2)
	self.PCKey2 = PCKey2
	local PCKeyBack = nil
	PCKeyBack = CoD.freeCursorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 1176, 1308, 0.5, 0.5, -18, 18)
	PCKeyBack:linkToElementModel(self, "" .. Enum[@"luibutton"][@"hash_64D2505E19049444"], false, function(model)
		PCKeyBack:setModel(model, f1_arg1)
	end)
	self:addElement(PCKeyBack)
	self.PCKeyBack = PCKeyBack
	self:mergeStateConditions({
		{
			stateName = "WarzonePC",
			condition = function(menu, element, event)
				local f20_local0 = IsWarzone()
				if f20_local0 then
					f20_local0 = IsPC()
					if f20_local0 then
						f20_local0 = IsInGame()
						if f20_local0 then
							f20_local0 = CoD.ModelUtility.IsModelValueNonEmptyString(f1_arg1, "FreeCursor.contextualInfo.detailedDescription")
						end
					end
				end
				return f20_local0
			end,
		},
		{
			stateName = "HideBackgroundPC",
			condition = function(menu, element, event)
				return IsPC() and IsGamepad(f1_arg1)
			end,
		},
	})
	local f1_local12 = self
	local f1_local13 = self.subscribeToModel
	local f1_local14 = Engine[@"getglobalmodel"]()
	f1_local13(f1_local12, f1_local14["lobbyRoot.lobbyNav"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14["FreeCursor.contextualInfo.detailedDescription"], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "FreeCursor.contextualInfo.detailedDescription",
		})
	end, false)
	self:appendEventHandler("input_source_changed", function(f24_arg0, f24_arg1)
		f24_arg1.menu = f24_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f24_arg1)
	end)
	f1_local12 = self
	f1_local13 = self.subscribeToModel
	f1_local14 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local13(f1_local12, f1_local14.LastInput, function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	Xbtn.id = "Xbtn"
	Abtn.id = "Abtn"
	Bbtn.id = "Bbtn"
	OptionsBtn.id = "OptionsBtn"
	Ybtn.id = "Ybtn"
	LTbtn.id = "LTbtn"
	RTbtn.id = "RTbtn"
	LeftStick.id = "LeftStick"
	if CoD.isPC then
		PCKey2.id = "PCKey2"
	end
	if CoD.isPC then
		PCKeyBack.id = "PCKeyBack"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local13 = self
	CoD.FreeCursorUtility.UseVisibleChildrenWidth(self)
	CoD.FreeCursorUtility.UseMaxVisibleChildHeight(self)
	return self
end
CoD.freeCursorButtonPromptContainer.__resetProperties = function(f26_arg0)
	f26_arg0.BG:completeAnimation()
	f26_arg0.BG:setAlpha(1)
end
CoD.freeCursorButtonPromptContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
	},
	WarzonePC = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.BG:completeAnimation()
			f28_arg0.BG:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.BG)
		end,
	},
	HideBackgroundPC = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.BG:completeAnimation()
			f29_arg0.BG:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.BG)
		end,
	},
}
CoD.freeCursorButtonPromptContainer.__onClose = function(f30_arg0)
	f30_arg0.BG:close()
	f30_arg0.Xbtn:close()
	f30_arg0.Abtn:close()
	f30_arg0.Bbtn:close()
	f30_arg0.OptionsBtn:close()
	f30_arg0.Ybtn:close()
	f30_arg0.LTbtn:close()
	f30_arg0.RTbtn:close()
	f30_arg0.LeftStick:close()
	f30_arg0.PCKey2:close()
	f30_arg0.PCKeyBack:close()
end
