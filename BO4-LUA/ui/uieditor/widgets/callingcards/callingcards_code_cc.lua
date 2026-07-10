require("x64:657c628b7f7ea")
CoD[@"hash_2C339FA55EF8B2DD"] = InheritFrom(LUI.UIElement)
CoD[@"hash_2C339FA55EF8B2DD"].__defaultWidth = 960
CoD[@"hash_2C339FA55EF8B2DD"].__defaultHeight = 240
CoD[@"hash_2C339FA55EF8B2DD"].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[@"hash_2C339FA55EF8B2DD"])
	self.id = "CallingCards_CODE_CC"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(@"uie_code_bg"))
	background:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	background:setShaderVector(0, 1, 1, 0, 0)
	background:setShaderVector(1, 1, 0, 0, 0)
	self:addElement(background)
	self.background = background
	local background2 = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background2:setImage(RegisterImage(@"uie_code_bg"))
	background2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll"))
	background2:setShaderVector(0, 1, 1, 0, 0)
	background2:setShaderVector(1, 0.75, 0, 0, 0)
	self:addElement(background2)
	self.background2 = background2
	local truck = CoD.CallingCards_Asset_truck.new(f1_arg0, f1_arg1, 0, 0, 283.5, 1099.5, 0, 0, -53, 267)
	truck:setScale(0.8, 0.8)
	self:addElement(truck)
	self.truck = truck
	local snowdirt = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	snowdirt:setImage(RegisterImage(@"uie_snow_dirt"))
	snowdirt:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	snowdirt:setShaderVector(0, 0, 5, 0, 0)
	snowdirt:setShaderVector(1, 15, 0, 0, 0)
	self:addElement(snowdirt)
	self.snowdirt = snowdirt
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[@"hash_2C339FA55EF8B2DD"].__resetProperties = function(f2_arg0)
	f2_arg0.truck:completeAnimation()
end
CoD[@"hash_2C339FA55EF8B2DD"].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.truck:completeAnimation()
			f3_arg0.truck:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.truck)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[@"hash_2C339FA55EF8B2DD"].__onClose = function(f4_arg0)
	f4_arg0.truck:close()
end
