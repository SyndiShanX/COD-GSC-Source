require("x64:be779d5e87238aa")
require("x64:1114dc24c016469")
require("x64:a9d9ad002907d62")
CoD.systemOverlay_Full_PCFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Full_PCFrame.__defaultWidth = 1920
CoD.systemOverlay_Full_PCFrame.__defaultHeight = 480
CoD.systemOverlay_Full_PCFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_Full_PCFrame)
	self.id = "systemOverlay_Full_PCFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local largeImage = LUI.UIImage.new(0, 0, 0, 528, 0, 1, 0, 0)
	largeImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			largeImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(largeImage)
	self.largeImage = largeImage
	local supportInfo = CoD.systemOverlay_supportWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 528, 1, 1, -36, 0)
	supportInfo:linkToElementModel(self, nil, false, function(model)
		supportInfo:setModel(model, f1_arg1)
	end)
	self:addElement(supportInfo)
	self.supportInfo = supportInfo
	local options = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, true, false, false, false)
	options:setLeftRight(0, 0, 634, 1049)
	options:setTopBottom(1, 1, -103, -36)
	options:setAutoScaleContent(true)
	options:setWidgetType(CoD.featureOverlay_Button)
	options:setHorizontalCount(2)
	options:setSpacing(15)
	options:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	options:linkToElementModel(self, "listDatasource", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			options:setDataSource(f4_local0)
		end
	end)
	options:linkToElementModel(options, "disabled", true, function(model, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	options:registerEventHandler("gain_focus", function(element, event)
		local f6_local0 = nil
		if element.gainFocus then
			f6_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f6_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f6_local0
	end)
	f1_arg0:AddButtonCallbackFunction(options, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(options)
	self.options = options
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0, 0, 634, 1826, 0, 0, 72, 102)
	text:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	text:setAlpha(0.7)
	text:linkToElementModel(self, "description", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			text.text:setText(CoD.BaseUtility.LocalizeIfXHash(f9_local0))
		end
	end)
	self:addElement(text)
	self.text = text
	local categoryTypeImage = LUI.UIImage.new(0, 0, 576, 621, 0, 0, 17, 62)
	categoryTypeImage:setRGB(0.66, 0.63, 0.52)
	categoryTypeImage:linkToElementModel(self, "categoryType", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			categoryTypeImage:setImage(RegisterImage(GetCategoryIconForOverlayType(f10_local0)))
		end
	end)
	self:addElement(categoryTypeImage)
	self.categoryTypeImage = categoryTypeImage
	local title = LUI.UIText.new(0, 0, 632, 932, 0, 0, 20, 56)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	title:linkToElementModel(self, "title", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			title:setText(LocalizeToUpperString(CoD.BaseUtility.LocalizeIfXHash(f11_local0)))
		end
	end)
	self:addElement(title)
	self.title = title
	options.id = "options"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_Full_PCFrame.__onClose = function(f12_arg0)
	f12_arg0.largeImage:close()
	f12_arg0.supportInfo:close()
	f12_arg0.options:close()
	f12_arg0.text:close()
	f12_arg0.categoryTypeImage:close()
	f12_arg0.title:close()
end
