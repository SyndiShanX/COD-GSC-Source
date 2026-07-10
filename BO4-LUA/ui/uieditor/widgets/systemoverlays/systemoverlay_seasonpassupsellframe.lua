require("x64:c2f840fd2528321")
require("x64:1114dc24c016469")
CoD.systemOverlay_SeasonPassUpsellFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_SeasonPassUpsellFrame.__defaultWidth = 1920
CoD.systemOverlay_SeasonPassUpsellFrame.__defaultHeight = 480
CoD.systemOverlay_SeasonPassUpsellFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_SeasonPassUpsellFrame)
	self.id = "systemOverlay_SeasonPassUpsellFrame"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local Image = LUI.UIImage.new(0, 0, 59, 453, 0, 0, 38.5, 407.5)
	Image:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local title = LUI.UIText.new(0, 0, 632, 932, 0, 0, 20, 56)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	title:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			title:setText(LocalizeToUpperString(CoD.BaseUtility.LocalizeIfXHash(f3_local0)))
		end
	end)
	self:addElement(title)
	self.title = title
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0, 0, 633, 1825, 0, 0, 73, 103)
	text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	text:setAlpha(0.7)
	text:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			text.text:setText(CoD.BaseUtility.LocalizeIfXHash(f4_local0))
		end
	end)
	self:addElement(text)
	self.text = text
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, true, false, false, false)
	options:setLeftRight(0, 0, 632, 1032)
	options:setTopBottom(0, 0, 279.5, 407.5)
	options:setWidgetType(CoD.EmblemOptionsButton)
	options:setVerticalCount(2)
	options:setSpacing(8)
	options:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	options:linkToElementModel(self, "listDatasource", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			options:setDataSource(f5_local0)
		end
	end)
	options:linkToElementModel(options, "disabled", true, function(model, f6_arg1)
		CoD.Menu.UpdateButtonShownState(f6_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f7_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
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
CoD.systemOverlay_SeasonPassUpsellFrame.__onClose = function(f10_arg0)
	f10_arg0.Image:close()
	f10_arg0.title:close()
	f10_arg0.text:close()
	f10_arg0.options:close()
end
