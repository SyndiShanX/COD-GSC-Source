require("ui/uieditor/widgets/lobby/common/fe_focusbarcontainer")
require("ui/uieditor/widgets/startmenu/startmenu_frame_nobg")
local f0_local0 = function(f1_arg0, f1_arg1, f1_arg2)
	local f1_local0 = function(f2_arg0, f2_arg1)
		local f2_local0 = CoD.PCUtil.GetElementModelValues(f2_arg0, "onPressFn")
		if f2_local0 then
			f2_local0(f2_arg0, f2_arg1)
		end
	end
	f1_arg0:registerEventHandler("button_action", function(element, event)
		f1_local0(element, f1_arg1)
		return true
	end)
	CoD.Menu.AddButtonCallbackFunction(f1_arg2, f1_arg0, f1_arg1, Enum.LUIButton[@"lui_key_xba_pscross"], "ui_confirm", function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		if not f1_arg0.disabled and not f4_arg1.m_disableNavigation and f4_arg1:AcceptGamePadButtonInputFromModelCallback(f4_arg2) then
			f1_local0(f4_arg0, f4_arg2)
			return true
		else
		end
	end)
end
local PostLoadFunc = function(self, controller, menu)
	if CursorInputEnabledForBuild() then
		f0_local0(self, controller, menu)
	end
end
CoD.StartMenu_Options_Button = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Button.__defaultWidth = 750
CoD.StartMenu_Options_Button.__defaultHeight = 60
CoD.StartMenu_Options_Button.new = function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7, f6_arg8, f6_arg9)
	local self = LUI.UIElement.new(f6_arg2, f6_arg3, f6_arg4, f6_arg5, f6_arg6, f6_arg7, f6_arg8, f6_arg9)
	self:setClass(CoD.StartMenu_Options_Button)
	self.id = "StartMenu_Options_Button"
	self.soundSet = "ChooseDecal"
	f6_arg0:addElementToPendingUpdateStateList(self)
	local fullBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fullBacking:setRGB(0.1, 0.1, 0.1)
	fullBacking:setAlpha(0)
	self:addElement(fullBacking)
	self.fullBacking = fullBacking
	local fullBorder = CoD.StartMenu_frame_noBG.new(f6_arg0, f6_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	fullBorder:setRGB(0.87, 0.37, 0)
	fullBorder:setAlpha(0)
	self:addElement(fullBorder)
	self.fullBorder = fullBorder
	local actionText = LUI.UIText.new(0, 0, 12, 352, 0, 0, 11, 49)
	actionText:setTTF("default")
	actionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	actionText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	actionText:linkToElementModel(self, "label", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			actionText:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:addElement(actionText)
	self.actionText = actionText
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f6_arg0, f6_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	local FocusBarT = CoD.FE_FocusBarContainer.new(f6_arg0, f6_arg1, 0, 1, 0, -4, 0, 0, 0, 6)
	FocusBarT:setAlpha(0)
	FocusBarT:setZoom(1)
	self:addElement(FocusBarT)
	self.FocusBarT = FocusBarT
	local FocusBarB = CoD.FE_FocusBarContainer.new(f6_arg0, f6_arg1, 0, 1, 0, -4, 1, 1, -8, 0)
	FocusBarB:setAlpha(0)
	FocusBarB:setZoom(1)
	self:addElement(FocusBarB)
	self.FocusBarB = FocusBarB
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f6_arg1, f6_arg0)
	end
	return self
end
CoD.StartMenu_Options_Button.__resetProperties = function(f8_arg0)
	f8_arg0.fullBorder:completeAnimation()
	f8_arg0.FocusBarT:completeAnimation()
	f8_arg0.FocusBarB:completeAnimation()
	f8_arg0.fullBorder:setAlpha(0)
	f8_arg0.FocusBarT:setAlpha(0)
	f8_arg0.FocusBarB:setAlpha(0)
end
CoD.StartMenu_Options_Button.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.fullBorder:completeAnimation()
			f10_arg0.fullBorder:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.fullBorder)
			f10_arg0.FocusBarT:completeAnimation()
			f10_arg0.FocusBarT:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.FocusBarT)
			f10_arg0.FocusBarB:completeAnimation()
			f10_arg0.FocusBarB:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.FocusBarB)
		end,
	},
}
CoD.StartMenu_Options_Button.__onClose = function(f11_arg0)
	f11_arg0.fullBorder:close()
	f11_arg0.actionText:close()
	f11_arg0.StartMenuframenoBG00:close()
	f11_arg0.FocusBarT:close()
	f11_arg0.FocusBarB:close()
end
