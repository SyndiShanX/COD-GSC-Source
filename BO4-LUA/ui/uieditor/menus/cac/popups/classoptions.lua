require("x64:9852222774adafe")
CoD.ClassOptions = InheritFrom(CoD.Menu)
LUI.createMenu.ClassOptions = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ClassOptions", f1_arg0)
	local f1_local1 = self
	CoD.FrontendCACUtility.ClassOptionsPreLoad(self, f1_arg0)
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.ClassOptions)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local BlackfadeBlur = LUI.UIImage.new(0, 1.13, -5, 5, 0, 1, -5, 5)
	BlackfadeBlur:setRGB(0, 0, 0)
	BlackfadeBlur:setAlpha(0.6)
	self:addElement(BlackfadeBlur)
	self.BlackfadeBlur = BlackfadeBlur
	local ClassOptionsWidget = CoD.ClassOptionsWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	ClassOptionsWidget.ClassNamelLabel:setText(LocalizeToUpperString(0xDD163B6B797AB91))
	ClassOptionsWidget:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(ClassOptionsWidget)
	self.ClassOptionsWidget = ClassOptionsWidget
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f3_local0 = nil
		CallCustomElementFunction_Self(self, "handleKeyboardComplete", self, f1_arg0, event)
		if not f3_local0 then
			f3_local0 = self:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ui_contextual_1", function(element, menu, controller, model)
		GoBack(self, controller)
		ClearMenuSavedState(menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, "ui_contextual_1")
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg0, "RenameClassText") then
			CoD.CACUtility.RenameCustomClass(self, f1_local1, f1_arg0)
		end
	end)
	ClassOptionsWidget.id = "ClassOptionsWidget"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = ClassOptionsWidget
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.ClassOptions.__onClose = function(f7_arg0)
	f7_arg0.ClassOptionsWidget:close()
end
