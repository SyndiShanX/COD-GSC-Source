CoD.VehicleTurretOverheat = InheritFrom(CoD.Menu)
CoD.VehicleTurretOverheat.__stateMap = {
	"DefaultState",
	"Overheat",
}
LUI.createMenu.VehicleTurretOverheat = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VehicleTurretOverheat", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VehicleTurretOverheat)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BarBackground = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, 78, 102)
	BarBackground:setRGB(0, 0, 0)
	self:addElement(BarBackground)
	self.BarBackground = BarBackground
	local BarForeground = LUI.UIImage.new(0.5, 0.5, -100, 100, 0, 0, 618, 642)
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
	local TextBox = LUI.UIText.new(0, 0, 860, 1060, 0, 0, 594, 618)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5AE55F6BAB9A6C9F"))
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
CoD.VehicleTurretOverheat.__resetProperties = function(f3_arg0)
	f3_arg0.BarForeground:completeAnimation()
	f3_arg0.BarForeground:setRGB(1, 1, 1)
end
CoD.VehicleTurretOverheat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Overheat = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.BarForeground:completeAnimation()
			f5_arg0.BarForeground:setRGB(1, 0, 0)
			f5_arg0.clipFinished(f5_arg0.BarForeground)
		end,
	},
}
CoD.VehicleTurretOverheat.__onClose = function(f6_arg0)
	f6_arg0.BarForeground:close()
end
