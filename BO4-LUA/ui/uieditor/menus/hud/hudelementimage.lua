local f0_local0 = function(f1_arg0)
	if f1_arg0.x and f1_arg0.y and f1_arg0.width and f1_arg0.height then
		f1_arg0.Image:setLeftRight(true, false, f1_arg0.x, f1_arg0.x + f1_arg0.width)
		f1_arg0.Image:setTopBottom(true, false, f1_arg0.y, f1_arg0.y + f1_arg0.height)
	end
end
local f0_local1 = function(f2_arg0)
	if f2_arg0.alpha then
		f2_arg0.Image:setAlpha(f2_arg0.alpha)
	end
end
local f0_local2 = function(f3_arg0)
	if f3_arg0.imageMaterialName then
		f3_arg0.Image:setImage(RegisterMaterial(f3_arg0.imageMaterialName))
	end
end
local f0_local3 = function(f4_arg0)
	if f4_arg0.red and f4_arg0.green and f4_arg0.blue then
		f4_arg0:setRGB(f4_arg0.red, f4_arg0.green, f4_arg0.blue)
	end
end
local f0_local4 = function(f5_arg0)
	if f5_arg0.zRot then
		f5_arg0.Image:setZRot(f5_arg0.zRot)
	end
end
local PostLoadFunc = function(f6_arg0)
	local f6_local0 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "x")
	local f6_local1 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "y")
	local f6_local2 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "width")
	local f6_local3 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "height")
	local f6_local4 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "alpha")
	local f6_local5 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "material")
	local f6_local6 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "fadeOverTime")
	local f6_local7 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "red")
	local f6_local8 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "green")
	local f6_local9 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "blue")
	local f6_local10 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "zRot")
	f6_arg0.red = 1
	f6_arg0.green = 1
	f6_arg0.blue = 1
	f6_arg0:setPriority(-1)
	if f6_local0 then
		f6_arg0:subscribeToModel(f6_local0, function(model)
			local f7_local0 = Engine[0x614D394F6F9A18D](model)
			if f7_local0 then
				f6_arg0.x = f7_local0
				f0_local0(f6_arg0)
			end
		end)
	end
	if f6_local1 then
		f6_arg0:subscribeToModel(f6_local1, function(model)
			local f8_local0 = Engine[0x614D394F6F9A18D](model)
			if f8_local0 then
				f6_arg0.y = f8_local0
				f0_local0(f6_arg0)
			end
		end)
	end
	if f6_local2 then
		f6_arg0:subscribeToModel(f6_local2, function(model)
			local f9_local0 = Engine[0x614D394F6F9A18D](model)
			if f9_local0 then
				f6_arg0.width = f9_local0
				f0_local0(f6_arg0)
			end
		end)
	end
	if f6_local3 then
		f6_arg0:subscribeToModel(f6_local3, function(model)
			local f10_local0 = Engine[0x614D394F6F9A18D](model)
			if f10_local0 then
				f6_arg0.height = f10_local0
				f0_local0(f6_arg0)
			end
		end)
	end
	if f6_local4 then
		f6_arg0:subscribeToModel(f6_local4, function(model)
			local f11_local0 = Engine[0x614D394F6F9A18D](model)
			if f11_local0 then
				f6_arg0.alpha = f11_local0
				f0_local1(f6_arg0)
			end
		end)
	end
	if f6_local5 then
		f6_arg0:subscribeToModel(f6_local5, function(model)
			local f12_local0 = Engine[0x614D394F6F9A18D](model)
			if f12_local0 then
				f6_arg0.imageMaterialName = f12_local0
				f0_local2(f6_arg0)
			end
		end)
	end
	if f6_local6 then
		f6_arg0:subscribeToModel(f6_local6, function(model)
			local f13_local0 = Engine[0x614D394F6F9A18D](model)
			if f13_local0 and tonumber(f13_local0) then
				f6_arg0.Image:setAlpha(0)
				f6_arg0.Image:beginAnimation("fadeOverTime", f13_local0)
				f6_arg0.Image:setAlpha(1)
			end
		end)
	end
	if f6_local7 then
		f6_arg0:subscribeToModel(f6_local7, function(model)
			local f14_local0 = Engine[0x614D394F6F9A18D](model)
			if f14_local0 then
				f6_arg0.red = f14_local0
				f0_local3(f6_arg0)
			end
		end)
	end
	if f6_local8 then
		f6_arg0:subscribeToModel(f6_local8, function(model)
			local f15_local0 = Engine[0x614D394F6F9A18D](model)
			if f15_local0 then
				f6_arg0.green = f15_local0
				f0_local3(f6_arg0)
			end
		end)
	end
	if f6_local9 then
		f6_arg0:subscribeToModel(f6_local9, function(model)
			local f16_local0 = Engine[0x614D394F6F9A18D](model)
			if f16_local0 then
				f6_arg0.blue = f16_local0
				f0_local3(f6_arg0)
			end
		end)
	end
	if f6_local10 then
		f6_arg0:subscribeToModel(f6_local10, function(model)
			local f17_local0 = Engine[0x614D394F6F9A18D](model)
			if f17_local0 then
				f6_arg0.zRot = f17_local0
				f0_local4(f6_arg0)
			end
		end)
	end
end
CoD.HudElementImage = InheritFrom(CoD.Menu)
LUI.createMenu.HudElementImage = function(f18_arg0, f18_arg1)
	local self = CoD.Menu.NewForUIEditor("HudElementImage", f18_arg0)
	local f18_local1 = self
	SetProperty(self, "disableInputLock", true)
	self:setClass(CoD.HudElementImage)
	self.soundSet = "default"
	self:setOwner(f18_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f18_arg0)
	self.ignoreCursor = true
	local Image = LUI.UIImage.new(0, 0, 864, 1056, 0, 0, 81, 273)
	Image:setAlpha(0)
	self:addElement(Image)
	self.Image = Image
	self:processEvent({
		name = "menu_loaded",
		controller = f18_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f18_arg0)
	end
	return self
end
CoD.HudElementImage.__onClose = function(f19_arg0) end
