require("x64:7ec6bc10fa8e6b3")
require("x64:1114dc24c016469")
require("x64:ba72b08fda6493")
require("x64:c829ac7d797ba4c")
CoD.systemOverlay_DivisionPlacement = InheritFrom(LUI.UIElement)
CoD.systemOverlay_DivisionPlacement.__defaultWidth = 1920
CoD.systemOverlay_DivisionPlacement.__defaultHeight = 286
CoD.systemOverlay_DivisionPlacement.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_DivisionPlacement)
	self.id = "systemOverlay_DivisionPlacement"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local background = LUI.UIImage.new(0, 0, 0, 1920, 0, 0, -397, 683)
	background:setRGB(0, 0, 0)
	background:setAlpha(0.5)
	self:addElement(background)
	self.background = background
	local f1_local2 = nil
	self.largeImage = LUI.UIElement.createFake()
	local title = LUI.UIText.new(0, 0, 632, 932, 0, 0, 15, 60)
	title:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	title:setTTF("ttmussels_demibold")
	title:setLetterSpacing(6)
	title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	title:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			title:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(title)
	self.title = title
	local text = CoD.systemOverlay_Layout_ForegroundMultilineText.new(f1_arg0, f1_arg1, 0, 0, 633, 1825, 0, 0, 74, 104)
	text:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			text.text:setText(f3_local0)
		end
	end)
	self:addElement(text)
	self.text = text
	local ArenaEventTimerLarge = CoD.ArenaEventTimerLarge.new(f1_arg0, f1_arg1, 0, 0, 633, 893, 0, 0, 157, 182)
	ArenaEventTimerLarge.EventStartsIn:setText("")
	ArenaEventTimerLarge:subscribeToGlobalModel(f1_arg1, "Arena", "arenaEventTimer", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ArenaEventTimerLarge.EventEndsIn:setText(f4_local0)
		end
	end)
	self:addElement(ArenaEventTimerLarge)
	self.ArenaEventTimerLarge = ArenaEventTimerLarge
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_arg0, f1_arg1, 0.5, 0.5, -327, -141, 0.5, 0.5, 62, 122)
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x78D439E1B360368))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.AARUtility.CloseArenaLeaguePlayPlacementOverlay(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, "ui_confirm")
		return true
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local BTNQuit = nil
	BTNQuit = CoD.PC_SmallCloseButton.new(f1_arg0, f1_arg1, 0.5, 0.5, 913, 947, 0.5, 0.5, -131, -97)
	BTNQuit:setScale(0.8, 0.8)
	BTNQuit:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BTNQuit, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(BTNQuit)
	self.BTNQuit = BTNQuit
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
	if CoD.isPC then
		BTNQuit.id = "BTNQuit"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_DivisionPlacement.__onClose = function(f11_arg0)
	f11_arg0.title:close()
	f11_arg0.text:close()
	f11_arg0.ArenaEventTimerLarge:close()
	f11_arg0.featureOverlayButtonMouseOnly:close()
	f11_arg0.BTNQuit:close()
end
