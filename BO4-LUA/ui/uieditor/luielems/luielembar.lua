local f0_local0 = function(f1_arg0)
	if f1_arg0.red and f1_arg0.green and f1_arg0.blue then
		f1_arg0.BarForeground:setRGB(f1_arg0.red, f1_arg0.green, f1_arg0.blue)
	end
end
local PostLoadFunc = function(self, controller)
	local f2_local0 = self:getModel(controller, "alpha")
	local f2_local1 = self:getModel(controller, "fadeOverTime")
	local f2_local2 = self:getModel(controller, "red")
	local f2_local3 = self:getModel(controller, "green")
	local f2_local4 = self:getModel(controller, "blue")
	self.red = 1
	self.green = 1
	self.blue = 1
	if f2_local0 then
		self:subscribeToModel(f2_local0, function(model)
			local f3_local0 = Engine[@"getmodelvalue"](model)
			if f3_local0 then
				self.alpha = f3_local0
				local f3_local1 = self:getModel()
				f3_local1 = f3_local1.fadeOverTime:get() * 100
				self.BarBackground:beginAnimation(f3_local1)
				self.BarForeground:beginAnimation(f3_local1)
				self.BarBackground:setAlpha(self.alpha)
				self.BarForeground:setAlpha(self.alpha)
				self:setAlpha(self.alpha)
			end
		end)
	end
	if f2_local2 then
		self:subscribeToModel(f2_local2, function(model)
			local f4_local0 = Engine[@"getmodelvalue"](model)
			if f4_local0 then
				self.red = f4_local0
				f0_local0(self)
			end
		end)
	end
	if f2_local3 then
		self:subscribeToModel(f2_local3, function(model)
			local f5_local0 = Engine[@"getmodelvalue"](model)
			if f5_local0 then
				self.green = f5_local0
				f0_local0(self)
			end
		end)
	end
	if f2_local4 then
		self:subscribeToModel(f2_local4, function(model)
			local f6_local0 = Engine[@"getmodelvalue"](model)
			if f6_local0 then
				self.blue = f6_local0
				f0_local0(self)
			end
		end)
	end
end
CoD.LUIelemBar = InheritFrom(CoD.Menu)
LUI.createMenu.LUIelemBar = function(f7_arg0, f7_arg1)
	local self = CoD.Menu.NewForUIEditor("LUIelemBar", f7_arg0)
	local f7_local1 = self
	self:setClass(CoD.LUIelemBar)
	self.soundSet = "default"
	self:setOwner(f7_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f7_arg0)
	self.ignoreCursor = true
	local BarBackground = LUI.UIImage.new(0, 0, 30, 46, 0, 0, 30, 38)
	BarBackground:setRGB(0, 0, 0)
	BarBackground:linkToElementModel(self, "x", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			BarBackground:setLeftPx(Multiple(15, f8_local0))
		end
	end)
	BarBackground:linkToElementModel(self, "y", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			BarBackground:setTopPx(Multiple(15, f9_local0))
		end
	end)
	BarBackground:linkToElementModel(self, "width", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			BarBackground:setWidth(Multiple(8, f10_local0))
		end
	end)
	BarBackground:linkToElementModel(self, "height", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			BarBackground:setHeight(Multiple(4, f11_local0))
		end
	end)
	self:addElement(BarBackground)
	self.BarBackground = BarBackground
	local BarForeground = LUI.UIImage.new(0, 0, 31, 45, 0, 0, 31, 37)
	BarForeground:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_normal"))
	BarForeground:setShaderVector(1, 0, 0, 0, 0)
	BarForeground:setShaderVector(2, 1, 0, 0, 0)
	BarForeground:setShaderVector(3, 0, 0, 0, 0)
	BarForeground:setShaderVector(4, 0, 0, 0, 0)
	BarForeground:linkToElementModel(self, "x", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			BarForeground:setLeftPx(Add(1, Multiple(15, f12_local0)))
		end
	end)
	BarForeground:linkToElementModel(self, "y", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			BarForeground:setTopPx(Add(1, Multiple(15, f13_local0)))
		end
	end)
	BarForeground:linkToElementModel(self, "width", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			BarForeground:setWidth(Add(-2, Multiple(8, f14_local0)))
		end
	end)
	BarForeground:linkToElementModel(self, "height", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			BarForeground:setHeight(Add(-2, Multiple(4, f15_local0)))
		end
	end)
	BarForeground:linkToElementModel(self, "bar_percent", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			BarForeground:setShaderVector(0, CoD.GetVectorComponentFromString(f16_local0, 1), CoD.GetVectorComponentFromString(f16_local0, 2), CoD.GetVectorComponentFromString(f16_local0, 3), CoD.GetVectorComponentFromString(f16_local0, 4))
		end
	end)
	self:addElement(BarForeground)
	self.BarForeground = BarForeground
	self:processEvent({
		name = "menu_loaded",
		controller = f7_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f7_arg0)
	end
	return self
end
CoD.LUIelemBar.__onClose = function(f17_arg0)
	f17_arg0.BarBackground:close()
	f17_arg0.BarForeground:close()
end
