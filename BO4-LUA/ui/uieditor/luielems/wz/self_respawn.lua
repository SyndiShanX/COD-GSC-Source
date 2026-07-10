CoD.self_respawn = InheritFrom(CoD.Menu)
LUI.createMenu.self_respawn = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("self_respawn", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.self_respawn)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	local TextBox = LUI.UIText.new(0, 0, 817, 1350, 0, 0, 559.5, 596.5)
	TextBox:setText(Engine[0xF9F1239CFD921FE](0xC8AFB2DE9CC25DE))
	TextBox:setTTF("default")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	local BarBackground = LUI.UIImage.new(0, 0, 815, 1065, 0, 0, 595.5, 620.5)
	BarBackground:setRGB(0, 0, 0)
	self:addElement(BarBackground)
	self.BarBackground = BarBackground
	local BarForeground = LUI.UIImage.new(0, 0, 817, 1063, 0, 0, 596.5, 619.5)
	BarForeground:setRGB(0, 1, 0)
	BarForeground:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	BarForeground:setShaderVector(1, 0, 0, 0, 0)
	BarForeground:setShaderVector(2, 1, 0, 0, 0)
	BarForeground:setShaderVector(3, 0, 0, 0, 0)
	BarForeground:setShaderVector(4, 0, 0, 0, 0)
	BarForeground:linkToElementModel(self, "percent", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BarForeground:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(BarForeground)
	self.BarForeground = BarForeground
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.self_respawn.__onClose = function(f3_arg0)
	f3_arg0.BarForeground:close()
end
