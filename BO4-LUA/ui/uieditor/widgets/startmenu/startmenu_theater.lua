require("x64:3507e0532e2631f")
require("x64:48be5c6feaceeb4")
require("x64:f93e6387e9d051")
require("x64:1850ed39b9104e4")
require("x64:b710bc406e458bd")
require("x64:76b6893fa024ec2")
CoD.StartMenu_Theater = InheritFrom(LUI.UIElement)
CoD.StartMenu_Theater.__defaultWidth = 1920
CoD.StartMenu_Theater.__defaultHeight = 1080
CoD.StartMenu_Theater.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelEnumIfNotSet(f1_arg1, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BUTTONS)
	self:setClass(CoD.StartMenu_Theater)
	self.id = "StartMenu_Theater"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = nil
	Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.05, 0.05, 0.05)
	Backing:setAlpha(0.85)
	self:addElement(Backing)
	self.Backing = Backing
	local ButtonList = LUI.UIList.new(f1_arg0, f1_arg1, 6, 0, nil, false, false, false, false)
	ButtonList:setLeftRight(0.5, 0.5, -806, -456)
	ButtonList:setTopBottom(0, 0, 166, 464)
	ButtonList:setWidgetType(CoD.DemoSideBarButton)
	ButtonList:setVerticalCount(4)
	ButtonList:setSpacing(6)
	ButtonList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ButtonList:setDataSource("StartMenuGameOptions")
	ButtonList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BUTTONS)
		return f2_local0
	end)
	ButtonList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ButtonList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
		return false
	end, false)
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	local OptionGroups = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	OptionGroups:setLeftRight(0.5, 0.5, -806, -106)
	OptionGroups:setTopBottom(0, 0, 483, 921)
	OptionGroups:setWidgetType(CoD.StartMenu_Options_SettingSlider_Wrapper)
	OptionGroups:setVerticalCount(8)
	OptionGroups:setSpacing(10)
	OptionGroups:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	OptionGroups:setDataSource("PlayerSettingsTheaterList")
	OptionGroups:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		CoD.ModelUtility.SetControllerModelValueToEnum(f1_arg1, "controllerLayoutState", CoD.OptionsUtility.ControllerPreviewStates.CONTROLLER_BUTTONS)
		return f6_local0
	end)
	OptionGroups:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(OptionGroups, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if HasListAction(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if HasListAction(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(OptionGroups)
	self.OptionGroups = OptionGroups
	local OptionInfo = CoD.StartMenu_Options_SettingInfo.new(f1_arg0, f1_arg1, 0.5, 0.5, 0, 900, 0, 0, 167, 271)
	OptionInfo:setAlpha(0)
	self:addElement(OptionInfo)
	self.OptionInfo = OptionInfo
	local ControllerLayout = CoD.StartMenu_Options_ControllerLayout.new(f1_arg0, f1_arg1, 0.5, 0.5, 0, 750, 0, 0, 315, 815)
	ControllerLayout:setScale(0.9, 0.9)
	self:addElement(ControllerLayout)
	self.ControllerLayout = ControllerLayout
	local PCKoreaContentDescriptorsContainer = nil
	PCKoreaContentDescriptorsContainer = CoD.PC_Korea_ContentDescriptors_Container.new(f1_arg0, f1_arg1, 0.5, 0.5, 737, 926, 0, 0, 110, 446)
	self:addElement(PCKoreaContentDescriptorsContainer)
	self.PCKoreaContentDescriptorsContainer = PCKoreaContentDescriptorsContainer
	local PCTheaterKeyboardShortcutLegend = nil
	PCTheaterKeyboardShortcutLegend = CoD.PC_Theater_Keyboard_Shortcut_Legend.new(f1_arg0, f1_arg1, 0.5, 0.5, -28.5, 811.5, 0, 0, 220, 570)
	PCTheaterKeyboardShortcutLegend:setAlpha(0)
	self:addElement(PCTheaterKeyboardShortcutLegend)
	self.PCTheaterKeyboardShortcutLegend = PCTheaterKeyboardShortcutLegend
	self:mergeStateConditions({
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f11_arg0, f11_arg1)
		f11_arg1.menu = f11_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f11_arg1)
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10.LastInput, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "PlayerSettingsUpdate", function(model)
		local f13_local0 = self
		CoD.DemoUtility.ProcessSettingsChange(f1_arg1)
	end)
	ButtonList.id = "ButtonList"
	OptionGroups.id = "OptionGroups"
	if CoD.isPC then
		PCTheaterKeyboardShortcutLegend.id = "PCTheaterKeyboardShortcutLegend"
	end
	self.__defaultFocus = ButtonList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Theater.__resetProperties = function(f14_arg0)
	f14_arg0.ControllerLayout:completeAnimation()
	f14_arg0.OptionInfo:completeAnimation()
	f14_arg0.PCTheaterKeyboardShortcutLegend:completeAnimation()
	f14_arg0.ControllerLayout:setAlpha(1)
	f14_arg0.OptionInfo:setAlpha(0)
	f14_arg0.PCTheaterKeyboardShortcutLegend:setAlpha(0)
end
CoD.StartMenu_Theater.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			f15_arg0.OptionInfo:completeAnimation()
			f15_arg0.OptionInfo:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.OptionInfo)
			f15_arg0.ControllerLayout:completeAnimation()
			f15_arg0.ControllerLayout:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.ControllerLayout)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.OptionInfo:completeAnimation()
			f16_arg0.OptionInfo:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.OptionInfo)
			f16_arg0.ControllerLayout:completeAnimation()
			f16_arg0.ControllerLayout:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ControllerLayout)
			f16_arg0.PCTheaterKeyboardShortcutLegend:completeAnimation()
			f16_arg0.PCTheaterKeyboardShortcutLegend:setAlpha(1)
			f16_arg0.clipFinished(f16_arg0.PCTheaterKeyboardShortcutLegend)
		end,
	},
}
CoD.StartMenu_Theater.__onClose = function(f17_arg0)
	f17_arg0.ButtonList:close()
	f17_arg0.OptionGroups:close()
	f17_arg0.OptionInfo:close()
	f17_arg0.ControllerLayout:close()
	f17_arg0.PCKoreaContentDescriptorsContainer:close()
	f17_arg0.PCTheaterKeyboardShortcutLegend:close()
end
