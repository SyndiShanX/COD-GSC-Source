require("x64:9bfecaffe48d881")
CoD.StartMenu_Quit = InheritFrom(LUI.UIElement)
CoD.StartMenu_Quit.__defaultWidth = 1920
CoD.StartMenu_Quit.__defaultHeight = 1080
CoD.StartMenu_Quit.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Quit)
	self.id = "StartMenu_Quit"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StrokeL = LUI.UIImage.new(0, 0, -450, 250, 0.5, 0.5, 0, 1)
	StrokeL:setAlpha(0.02)
	self:addElement(StrokeL)
	self.StrokeL = StrokeL
	local StrokeR = LUI.UIImage.new(0, 0, 1480, 2180, 0.5, 0.5, 0, 1)
	StrokeR:setAlpha(0.02)
	self:addElement(StrokeR)
	self.StrokeR = StrokeR
	local QuitButton = CoD.StartMenu_QuitButton.new(f1_arg0, f1_arg1, 1, 1, -283, -33, 1, 1, -186, -94)
	QuitButton:appendEventHandler("input_source_changed", function(f2_arg0, f2_arg1)
		f2_arg1.menu = f2_arg1.menu or f1_arg0
		CoD.Menu.UpdateButtonShownState(f2_arg0, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local f1_local4 = QuitButton
	local f1_local5 = QuitButton.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	QuitButton:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(QuitButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "MOUSE1", function(element, menu, controller, model)
		if IsMouseOrKeyboard(controller) and IsPC() and not CoD.BaseUtility.IsButtonHoldFinished(model) then
			QuitPCGame_MP(self, controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsMouseOrKeyboard(controller) and IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], "MOUSE1")
			return false
		else
			return false
		end
	end, false)
	f1_arg0:AddButtonCallbackFunction(QuitButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if IsGamepad(controller) and CoD.BaseUtility.IsButtonHoldFinished(model) then
			CoD.StartMenuUtility.QuitGameWZ(self, element, controller, "", menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if IsGamepad(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", Enum[@"luibuttonpromptflags"][@"hash_771B04FAC5BE0E35"] | 1500 << Enum[@"luibuttonpromptflags"][@"hash_176ADD225D738C93"], nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(QuitButton)
	self.QuitButton = QuitButton
	self:mergeStateConditions({
		{
			stateName = "codcaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and IsMultiplayer()
			end,
		},
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
	})
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["factions.isCoDCaster"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	QuitButton:appendEventHandler("menu_loaded", function()
		QuitButton:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	QuitButton.id = "QuitButton"
	self.__defaultFocus = QuitButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Quit.__resetProperties = function(f14_arg0)
	f14_arg0.QuitButton:completeAnimation()
	f14_arg0.QuitButton:setAlpha(1)
end
CoD.StartMenu_Quit.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.QuitButton:completeAnimation()
			f15_arg0.QuitButton:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.QuitButton)
		end,
	},
	codcaster = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.QuitButton:completeAnimation()
			f16_arg0.QuitButton:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.QuitButton)
		end,
	},
	Warzone = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.QuitButton:completeAnimation()
			f17_arg0.QuitButton:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.QuitButton)
		end,
	},
}
CoD.StartMenu_Quit.__onClose = function(f18_arg0)
	f18_arg0.QuitButton:close()
end
