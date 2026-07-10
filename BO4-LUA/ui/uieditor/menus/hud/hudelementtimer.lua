local f0_local0 = function(f1_arg0)
	f1_arg0.Timer:setupEndTimer(f1_arg0.time)
end
local f0_local1 = function(f2_arg0)
	if f2_arg0.x and f2_arg0.y and f2_arg0.height then
		f2_arg0.Timer:setLeftRight(true, false, f2_arg0.x, f2_arg0.x + 100)
		f2_arg0.Timer:setTopBottom(true, false, f2_arg0.y, f2_arg0.y + f2_arg0.height)
	end
end
local f0_local2 = function(f3_arg0)
	if f3_arg0.red and f3_arg0.green and f3_arg0.blue then
		f3_arg0:setRGB(f3_arg0.red, f3_arg0.green, f3_arg0.blue)
	end
end
local PostLoadFunc = function(f4_arg0)
	local f4_local0 = f4_arg0:getModel(Engine[@"getprimarycontroller"](), "x")
	local f4_local1 = f4_arg0:getModel(Engine[@"getprimarycontroller"](), "y")
	local f4_local2 = f4_arg0:getModel(Engine[@"getprimarycontroller"](), "height")
	local f4_local3 = f4_arg0:getModel(Engine[@"getprimarycontroller"](), "time")
	local f4_local4 = f4_arg0:getModel(Engine[@"getprimarycontroller"](), "red")
	local f4_local5 = f4_arg0:getModel(Engine[@"getprimarycontroller"](), "green")
	local f4_local6 = f4_arg0:getModel(Engine[@"getprimarycontroller"](), "blue")
	f4_arg0.red = 1
	f4_arg0.green = 1
	f4_arg0.blue = 1
	if f4_local0 then
		f4_arg0:subscribeToModel(f4_local0, function(model)
			local f5_local0 = Engine[@"getmodelvalue"](model)
			if f5_local0 then
				f4_arg0.x = f5_local0
				f0_local1(f4_arg0)
			end
		end)
	end
	if f4_local1 then
		f4_arg0:subscribeToModel(f4_local1, function(model)
			local f6_local0 = Engine[@"getmodelvalue"](model)
			if f6_local0 then
				f4_arg0.y = f6_local0
				f0_local1(f4_arg0)
			end
		end)
	end
	if f4_local2 then
		f4_arg0:subscribeToModel(f4_local2, function(model)
			local f7_local0 = Engine[@"getmodelvalue"](model)
			if f7_local0 then
				f4_arg0.height = f7_local0
				f0_local1(f4_arg0)
			end
		end)
	end
	if f4_local3 then
		f4_arg0:subscribeToModel(f4_local3, function(model)
			local f8_local0 = Engine[@"getmodelvalue"](model)
			if f8_local0 then
				f4_arg0.time = f8_local0
				f0_local0(f4_arg0)
			end
		end)
	end
	if f4_local4 then
		f4_arg0:subscribeToModel(f4_local4, function(model)
			local f9_local0 = Engine[@"getmodelvalue"](model)
			if f9_local0 then
				f4_arg0.red = f9_local0
				f0_local2(f4_arg0)
			end
		end)
	end
	if f4_local5 then
		f4_arg0:subscribeToModel(f4_local5, function(model)
			local f10_local0 = Engine[@"getmodelvalue"](model)
			if f10_local0 then
				f4_arg0.green = f10_local0
				f0_local2(f4_arg0)
			end
		end)
	end
	if f4_local6 then
		f4_arg0:subscribeToModel(f4_local6, function(model)
			local f11_local0 = Engine[@"getmodelvalue"](model)
			if f11_local0 then
				f4_arg0.blue = f11_local0
				f0_local2(f4_arg0)
			end
		end)
	end
end
CoD.HudElementTimer = InheritFrom(CoD.Menu)
LUI.createMenu.HudElementTimer = function(f12_arg0, f12_arg1)
	local self = CoD.Menu.NewForUIEditor("HudElementTimer", f12_arg0)
	local f12_local1 = self
	SetProperty(self, "disableInputLock", true)
	self:setClass(CoD.HudElementTimer)
	self.soundSet = "default"
	self:setOwner(f12_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f12_arg0)
	self.ignoreCursor = true
	local Timer = LUI.UIText.new(0, 0, 476, 557, 0, 0, 486, 524)
	Timer:setTTF("default")
	Timer:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Timer)
	self.Timer = Timer
	self:processEvent({
		name = "menu_loaded",
		controller = f12_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f12_arg0)
	end
	return self
end
CoD.HudElementTimer.__onClose = function(f13_arg0) end
