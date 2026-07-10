require("x64:e0c20c5908660cd")
CoD.vhud_layoutPlusGridLarge = InheritFrom(LUI.UIElement)
CoD.vhud_layoutPlusGridLarge.__defaultWidth = 883
CoD.vhud_layoutPlusGridLarge.__defaultHeight = 667
CoD.vhud_layoutPlusGridLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_layoutPlusGridLarge)
	self.id = "vhud_layoutPlusGridLarge"
	self.soundSet = "default"
	local gridPlus01 = CoD.vhud_layoutPlusGrid.new(f1_arg0, f1_arg1, 0, 0, 1, 235, 0, 0, 0, 235)
	self:addElement(gridPlus01)
	self.gridPlus01 = gridPlus01
	local gridPlus02 = CoD.vhud_layoutPlusGrid.new(f1_arg0, f1_arg1, 0, 0, 649, 883, 0, 0, 0, 235)
	self:addElement(gridPlus02)
	self.gridPlus02 = gridPlus02
	local gridPlus03 = CoD.vhud_layoutPlusGrid.new(f1_arg0, f1_arg1, 0, 0, 0, 234, 0, 0, 431.5, 666.5)
	self:addElement(gridPlus03)
	self.gridPlus03 = gridPlus03
	local gridPlus04 = CoD.vhud_layoutPlusGrid.new(f1_arg0, f1_arg1, 0, 0, 649, 883, 0, 0, 431.5, 666.5)
	self:addElement(gridPlus04)
	self.gridPlus04 = gridPlus04
	local gridPlus05 = LUI.UIImage.new(0, 0, 433, 451, 0, 0, 648.5, 666.5)
	gridPlus05:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_layout_grid_plus"))
	gridPlus05:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	gridPlus05:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(gridPlus05)
	self.gridPlus05 = gridPlus05
	local gridPlus06 = LUI.UIImage.new(0, 0, 433, 451, 0, 0, 0, 18)
	gridPlus06:setImage(RegisterImage(@"uie_ui_hud_vehicle_ac130_layout_grid_plus"))
	gridPlus06:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	gridPlus06:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(gridPlus06)
	self.gridPlus06 = gridPlus06
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_layoutPlusGridLarge.__onClose = function(f2_arg0)
	f2_arg0.gridPlus01:close()
	f2_arg0.gridPlus02:close()
	f2_arg0.gridPlus03:close()
	f2_arg0.gridPlus04:close()
end
