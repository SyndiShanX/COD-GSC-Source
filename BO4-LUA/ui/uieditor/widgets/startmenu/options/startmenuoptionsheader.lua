require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
CoD.StartMenuOptionsHeader = InheritFrom(LUI.UIElement)
CoD.StartMenuOptionsHeader.__defaultWidth = 1920
CoD.StartMenuOptionsHeader.__defaultHeight = 80
CoD.StartMenuOptionsHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenuOptionsHeader)
	self.id = "StartMenuOptionsHeader"
	self.soundSet = "ChooseDecal"
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.63, 0.57, 0.2)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local Gradient = LUI.UIImage.new(0, 0, 0, 1930, 0, 0, 0, 80)
	Gradient:setRGB(0.63, 0.57, 0.2)
	Gradient:setAlpha(0)
	Gradient:setImage(RegisterImage(0x61F4A521D2954B6))
	self:addElement(Gradient)
	self.Gradient = Gradient
	local Underline = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -4, 0)
	Underline:setRGB(0.15, 0.15, 0.15)
	self:addElement(Underline)
	self.Underline = Underline
	local UnderlineTexture = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -2, 0)
	UnderlineTexture:setRGB(0.15, 0.15, 0.15)
	UnderlineTexture:setImage(RegisterImage(0x1FC25912CF54567))
	UnderlineTexture:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	self:addElement(UnderlineTexture)
	self.UnderlineTexture = UnderlineTexture
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 80)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local Divider = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 41)
	Divider:setAlpha(0)
	self:addElement(Divider)
	self.Divider = Divider
	local Verticle = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 550, 0, 0, 0, 80)
	Verticle:setAlpha(0)
	self:addElement(Verticle)
	self.Verticle = Verticle
	local StartMenuOptionsMainCorners = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0.01, 0.36, 0, 0, 0, 0, 0, 80)
	StartMenuOptionsMainCorners:setAlpha(0)
	self:addElement(StartMenuOptionsMainCorners)
	self.StartMenuOptionsMainCorners = StartMenuOptionsMainCorners
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0.55, 0.55, 0, 544, 0, 0, 0, 80)
	Corner:setAlpha(0)
	self:addElement(Corner)
	self.Corner = Corner
	local HeaderText = LUI.UIText.new(0.5, 0.5, -880, -380, 0, 0, 25, 75)
	HeaderText:setRGB(0.63, 0.57, 0.2)
	HeaderText:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	HeaderText:setTTF("ttmussels_regular")
	HeaderText:setLetterSpacing(10)
	HeaderText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(HeaderText)
	self.HeaderText = HeaderText
	local Image = LUI.UIImage.new(0.5, 0.5, -958, -890, 0, 0, 29, 71)
	Image:setRGB(0.63, 0.57, 0.2)
	Image:setAlpha(0.6)
	Image:setImage(RegisterImage(0xC2359ED7F4961BF))
	self:addElement(Image)
	self.Image = Image
	self:registerEventHandler("menu_loaded", function(self, event)
		local f2_local0 = nil
		if self.menuLoaded then
			f2_local0 = self:menuLoaded(event)
		elseif self.super.menuLoaded then
			f2_local0 = self.super:menuLoaded(event)
		end
		ShowHeaderIconOnly(f1_arg0)
		DataSourceHelperRecreate(f1_arg1, "ButtonLayoutLabels")
		if not f2_local0 then
			f2_local0 = self:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		UpdateGamerprofile(self, element, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], nil, function(element, menu, controller, model)
		CoD.OptionsUtility.ResetPlayerSettingsGroupListToDefault(controller, self.OptionGroups)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0xC083113BC81F23F], 0x5D33EEAEB171341, Enum[0xBEBDBAEEB3ECCCA][0x2919C98A7A845F0] | 750 << Enum[0xBEBDBAEEB3ECCCA][0x76ADD225D738C93], nil)
		return true
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "PlayerSettingsUpdate", function(model)
		local f7_local0 = self
		if CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "PlayerSettingsUpdate", "button_layout") then
			DataSourceHelperRecreate(f1_arg1, "ButtonLayoutLabels")
		elseif CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "PlayerSettingsUpdate", "trigger_config") then
			DataSourceHelperRecreate(f1_arg1, "ButtonLayoutLabels")
		elseif CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "PlayerSettingsUpdate", "stick_layout") then
			DataSourceHelperRecreate(f1_arg1, "StickLayoutLabels")
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenuOptionsHeader.__onClose = function(f8_arg0)
	f8_arg0.Frame:close()
	f8_arg0.Divider:close()
	f8_arg0.Verticle:close()
	f8_arg0.StartMenuOptionsMainCorners:close()
	f8_arg0.Corner:close()
end
