local f0_local0 = function(f1_arg0)
	if f1_arg0.alpha then
		local f1_local0 = f1_arg0.Image
		local f1_local1 = f1_local0
		f1_local0 = f1_local0.beginAnimation
		local f1_local2 = f1_arg0:getModel()
		f1_local0(f1_local1, f1_local2.fadeOverTime:get() * 100)
		f1_arg0.Image:setAlpha(f1_arg0.alpha)
	end
end
local f0_local1 = function(f2_arg0)
	if f2_arg0.red and f2_arg0.green and f2_arg0.blue then
		f2_arg0:setRGB(f2_arg0.red, f2_arg0.green, f2_arg0.blue)
	end
end
local PostLoadFunc = function(self, controller)
	local f3_local0 = self:getModel(controller, "alpha")
	local f3_local1 = self:getModel(controller, "fadeOverTime")
	local f3_local2 = self:getModel(controller, "red")
	local f3_local3 = self:getModel(controller, "green")
	local f3_local4 = self:getModel(controller, "blue")
	self.red = 1
	self.green = 1
	self.blue = 1
	self:setPriority(-1)
	if f3_local0 then
		self:subscribeToModel(f3_local0, function(model)
			local f4_local0 = Engine[0x614D394F6F9A18D](model)
			if f4_local0 then
				self.alpha = f4_local0
				f0_local0(self)
			end
		end)
	end
	if f3_local2 then
		self:subscribeToModel(f3_local2, function(model)
			local f5_local0 = Engine[0x614D394F6F9A18D](model)
			if f5_local0 then
				self.red = f5_local0
				f0_local1(self)
			end
		end)
	end
	if f3_local3 then
		self:subscribeToModel(f3_local3, function(model)
			local f6_local0 = Engine[0x614D394F6F9A18D](model)
			if f6_local0 then
				self.green = f6_local0
				f0_local1(self)
			end
		end)
	end
	if f3_local4 then
		self:subscribeToModel(f3_local4, function(model)
			local f7_local0 = Engine[0x614D394F6F9A18D](model)
			if f7_local0 then
				self.blue = f7_local0
				f0_local1(self)
			end
		end)
	end
end
CoD.LUIelemImage = InheritFrom(CoD.Menu)
LUI.createMenu.LUIelemImage = function(f8_arg0, f8_arg1)
	local self = CoD.Menu.NewForUIEditor("LUIelemImage", f8_arg0)
	local f8_local1 = self
	self:setClass(CoD.LUIelemImage)
	self.soundSet = "default"
	self:setOwner(f8_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f8_arg0)
	self.ignoreCursor = true
	local Image = LUI.UIImage.new(0, 0, 30, 38, 0, 0, 30, 38)
	Image:setAlpha(0)
	Image:linkToElementModel(self, "x", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Image:setLeftPx(Multiple(15, f9_local0))
		end
	end)
	Image:linkToElementModel(self, "y", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			Image:setTopPx(Multiple(15, f10_local0))
		end
	end)
	Image:linkToElementModel(self, "width", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			Image:setWidth(Multiple(4, f11_local0))
		end
	end)
	Image:linkToElementModel(self, "height", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			Image:setHeight(Multiple(4, f12_local0))
		end
	end)
	Image:linkToElementModel(self, "material", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			Image:setImage(RegisterImage(f13_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	self:processEvent({
		name = "menu_loaded",
		controller = f8_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f8_arg0)
	end
	return self
end
CoD.LUIelemImage.__onClose = function(f14_arg0)
	f14_arg0.Image:close()
end
