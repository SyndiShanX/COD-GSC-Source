CoD.LUIelemBar_ct = InheritFrom(CoD.Menu)
LUI.createMenu.LUIelemBar_ct = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("LUIelemBar_ct", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.LUIelemBar_ct)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	local BarBackground = LUI.UIImage.new(0, 0, 30, 46, 0, 0, 30, 38)
	BarBackground:setRGB(0, 0, 0)
	BarBackground:setAlpha(0.65)
	BarBackground:setScale(1, 0.6)
	BarBackground:linkToElementModel(self, "x", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BarBackground:setLeftPx(Multiple(15, f2_local0))
		end
	end)
	BarBackground:linkToElementModel(self, "y", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BarBackground:setTopPx(Multiple(15, f3_local0))
		end
	end)
	BarBackground:linkToElementModel(self, "width", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BarBackground:setWidth(Multiple(8, f4_local0))
		end
	end)
	BarBackground:linkToElementModel(self, "height", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			BarBackground:setHeight(Multiple(4, f5_local0))
		end
	end)
	self:addElement(BarBackground)
	self.BarBackground = BarBackground
	local BarForeground = LUI.UIImage.new(0, 0, 31, 45, 0, 0, 31, 37)
	BarForeground:setAlpha(0.75)
	BarForeground:setScale(1, 1.8)
	BarForeground:setImage(RegisterImage("uie_ui_hud_core_capture_bar"))
	BarForeground:setMaterial(LUI.UIImage.GetCachedMaterial("uie_wipe_normal"))
	BarForeground:setShaderVector(1, 0, 0, 0, 0)
	BarForeground:setShaderVector(2, 1, 0, 0, 0)
	BarForeground:setShaderVector(3, 0, 0, 0, 0)
	BarForeground:setShaderVector(4, 0, 0, 0, 0)
	BarForeground:linkToElementModel(self, "x", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			BarForeground:setLeftPx(Add(1, Multiple(15, f6_local0)))
		end
	end)
	BarForeground:linkToElementModel(self, "y", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			BarForeground:setTopPx(Add(1, Multiple(15, f7_local0)))
		end
	end)
	BarForeground:linkToElementModel(self, "width", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			BarForeground:setWidth(Add(-2, Multiple(8, f8_local0)))
		end
	end)
	BarForeground:linkToElementModel(self, "height", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			BarForeground:setHeight(Add(-2, Multiple(4, f9_local0)))
		end
	end)
	BarForeground:linkToElementModel(self, "bar_percent", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			BarForeground:setShaderVector(0, CoD.GetVectorComponentFromString(f10_local0, 1), CoD.GetVectorComponentFromString(f10_local0, 2), CoD.GetVectorComponentFromString(f10_local0, 3), CoD.GetVectorComponentFromString(f10_local0, 4))
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
CoD.LUIelemBar_ct.__onClose = function(f11_arg0)
	f11_arg0.BarBackground:close()
	f11_arg0.BarForeground:close()
end
