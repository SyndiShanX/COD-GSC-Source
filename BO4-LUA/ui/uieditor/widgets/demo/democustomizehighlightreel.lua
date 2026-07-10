require("x64:e78f25fc8658278")
require("x64:f826b9e108697fc")
require("x64:1114dc24c016469")
CoD.DemoCustomizeHighlightReel = InheritFrom(LUI.UIElement)
CoD.DemoCustomizeHighlightReel.__defaultWidth = 1920
CoD.DemoCustomizeHighlightReel.__defaultHeight = 630
CoD.DemoCustomizeHighlightReel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.DemoUtility.RebuildHighlightReelTimeline(f1_arg1)
	self:setClass(CoD.DemoCustomizeHighlightReel)
	self.id = "DemoCustomizeHighlightReel"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local categoryTypeImage = LUI.UIImage.new(0, 0, 571, 616, 0, 0, 41, 86)
	categoryTypeImage:linkToElementModel(self, "categoryType", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			categoryTypeImage:setImage(RegisterImage(GetCategoryIconForOverlayType(f2_local0)))
		end
	end)
	self:addElement(categoryTypeImage)
	self.categoryTypeImage = categoryTypeImage
	local title = LUI.UIText.new(0, 0, 622, 922, 0, 0, 39, 84)
	title:setTTF("ttmussels_demibold")
	title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	title:linkToElementModel(self, "title", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			title:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(title)
	self.title = title
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0, 0, 626, 1818, 0, 0, 84, 114)
	text:linkToElementModel(self, "description", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			text.text:setText(f4_local0)
		end
	end)
	self:addElement(text)
	self.text = text
	local numAvailableHighlights = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0, 0, 626, 1818, 0, 0, 155, 185)
	numAvailableHighlights.text:setText(Engine[0xF9F1239CFD921FE](0x59812214DCF8E53))
	numAvailableHighlights:subscribeToGlobalModel(f1_arg1, "Demo", "numHighlightReelMoments", function(model)
		CoD.DemoUtility.UpdateNumHighlightReelMomentsElementColor(numAvailableHighlights, f1_arg1)
	end)
	self:addElement(numAvailableHighlights)
	self.numAvailableHighlights = numAvailableHighlights
	local ButtonList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	ButtonList:setLeftRight(0, 0, 600, 1410)
	ButtonList:setTopBottom(1, 1, -428, -112)
	ButtonList:setWidgetType(CoD.demo_options_slider)
	ButtonList:setVerticalCount(6)
	ButtonList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ButtonList:setDataSource("DemoHighlightReelSettingsButtonList")
	self:addElement(ButtonList)
	self.ButtonList = ButtonList
	local btnStartHighlightReel = LUI.UIList.new(f1_arg0, f1_arg1, 4, 0, nil, false, false, false, false)
	btnStartHighlightReel:setLeftRight(0, 0, 309, 1431)
	btnStartHighlightReel:setTopBottom(1, 1, -94, -46)
	btnStartHighlightReel:setWidgetType(CoD.CACGenericButton)
	btnStartHighlightReel:setSpacing(4)
	btnStartHighlightReel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	btnStartHighlightReel:linkToElementModel(self, "listDatasource", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			btnStartHighlightReel:setDataSource(f6_local0)
		end
	end)
	btnStartHighlightReel:linkToElementModel(btnStartHighlightReel, "disabled", true, function(model, f7_arg1)
		CoD.Menu.UpdateButtonShownState(f7_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	btnStartHighlightReel:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(btnStartHighlightReel, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not IsDisabled(element, controller) then
			ProcessListAction(self, element, controller, menu)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(btnStartHighlightReel)
	self.btnStartHighlightReel = btnStartHighlightReel
	ButtonList.id = "ButtonList"
	btnStartHighlightReel.id = "btnStartHighlightReel"
	self.__defaultFocus = ButtonList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DemoCustomizeHighlightReel.__onClose = function(f11_arg0)
	f11_arg0.categoryTypeImage:close()
	f11_arg0.title:close()
	f11_arg0.text:close()
	f11_arg0.numAvailableHighlights:close()
	f11_arg0.ButtonList:close()
	f11_arg0.btnStartHighlightReel:close()
end
