CoD.VehicleTurretDurability = InheritFrom(CoD.Menu)
LUI.createMenu.VehicleTurretDurability = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VehicleTurretDurability", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VehicleTurretDurability)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	local BarBackground = LUI.UIImage.new(0.5, 0.5, 732, 932, 0.5, 0.5, 78, 102)
	BarBackground:setRGB(0, 0, 0)
	self:addElement(BarBackground)
	self.BarBackground = BarBackground
	local BarForeground = LUI.UIImage.new(0.5, 0.5, 732, 932, 0, 0, 618, 642)
	BarForeground:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	BarForeground:setShaderVector(1, 0, 0, 0, 0)
	BarForeground:setShaderVector(2, 1, 0, 0, 0)
	BarForeground:setShaderVector(3, 0, 0, 0, 0)
	BarForeground:setShaderVector(4, 0, 0, 0, 0)
	BarForeground:linkToElementModel(self, "bar_percent", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BarForeground:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(BarForeground)
	self.BarForeground = BarForeground
	local TextBox = LUI.UIText.new(0, 0, 1692, 1892, 0, 0, 594, 618)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6488A32A90AD8204"))
	TextBox:setTTF("default")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TextBox:setBackingType(2)
	TextBox:setBackingColor(0, 0, 0)
	TextBox:setBackingMaterial(LUI.UIImage.GetCachedMaterial(@"hash_381EEB1F96D4BE0A"))
	TextBox:setBackingShaderVector(0, 0, 0, 0, 0)
	self:addElement(TextBox)
	self.TextBox = TextBox
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
CoD.VehicleTurretDurability.__onClose = function(f3_arg0)
	f3_arg0.BarForeground:close()
end
