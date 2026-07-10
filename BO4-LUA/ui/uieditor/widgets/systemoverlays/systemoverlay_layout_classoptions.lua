require("x64:90a494d641c0032")
require("x64:38c11a77e96e48c")
require("x64:1114dc24c016469")
CoD.systemOverlay_Layout_ClassOptions = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Layout_ClassOptions.__defaultWidth = 1920
CoD.systemOverlay_Layout_ClassOptions.__defaultHeight = 480
CoD.systemOverlay_Layout_ClassOptions.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("lobbyRoot.Pregame.Update")
	self:setClass(CoD.systemOverlay_Layout_ClassOptions)
	self.id = "systemOverlay_Layout_ClassOptions"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local f1_local1 = nil
	self.categoryTypeImage = LUI.UIElement.createFake()
	local title = LUI.UIText.new(0, 0, 632, 932, 0, 0, 15, 60)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	title:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			title:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(title)
	self.title = title
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0, 0, 633, 1825, 0, 0, 55, 85)
	text:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			text.text:setText(f3_local0)
		end
	end)
	self:addElement(text)
	self.text = text
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, true, false, false, false)
	options:setLeftRight(0, 0, 633, 1018)
	options:setTopBottom(0, 0, 113, 391)
	options:setWidgetType(CoD.List1ButtonChooseClass)
	options:setVerticalCount(6)
	options:setSpacing(4)
	options:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	options:setVerticalCounter(CoD.verticalCounter)
	options:linkToElementModel(self, "listDatasource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			options:setDataSource(f4_local0)
		end
	end)
	options:linkToElementModel(options, "disabled", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessClassOptionAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(options)
	self.options = options
	options.id = "options"
	self.__defaultFocus = options
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_Layout_ClassOptions.__onClose = function(f9_arg0)
	f9_arg0.categoryTypeImage:close()
	f9_arg0.title:close()
	f9_arg0.text:close()
	f9_arg0.options:close()
end
