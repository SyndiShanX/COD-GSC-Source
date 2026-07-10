local f0_local0 = function(f1_arg0)
	if f1_arg0.x and f1_arg0.y and f1_arg0.width and f1_arg0.height then
		f1_arg0.Text:setLeftRight(true, false, f1_arg0.x, f1_arg0.x + f1_arg0.width)
		f1_arg0.Text:setTopBottom(true, false, f1_arg0.y, f1_arg0.y + f1_arg0.height)
	end
end
local f0_local1 = function(f2_arg0)
	if f2_arg0.alpha then
		f2_arg0.Text:setAlpha(f2_arg0.alpha)
	end
end
local f0_local2 = function(f3_arg0)
	if f3_arg0.text then
		f3_arg0.Text:setText(f3_arg0.text)
	end
end
local f0_local3 = function(f4_arg0)
	if f4_arg0.alignment then
		f4_arg0.Text:setAlignment(f4_arg0.alignment)
	end
end
local f0_local4 = function(f5_arg0)
	if f5_arg0.red and f5_arg0.green and f5_arg0.blue then
		f5_arg0:setRGB(f5_arg0.red, f5_arg0.green, f5_arg0.blue)
	end
end
local PostLoadFunc = function(f6_arg0)
	f6_arg0.width = 100
	f6_arg0.height = 25
	local f6_local0 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "x")
	local f6_local1 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "y")
	local f6_local2 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "width")
	local f6_local3 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "height")
	local f6_local4 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "alpha")
	local f6_local5 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "text")
	local f6_local6 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "alignment")
	local f6_local7 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "fadeOverTime")
	local f6_local8 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "red")
	local f6_local9 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "green")
	local f6_local10 = f6_arg0:getModel(Engine[0xA5B9C0111291A8B](), "blue")
	f6_arg0.red = 1
	f6_arg0.green = 1
	f6_arg0.blue = 1
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
				f6_arg0.text = f12_local0
				f0_local2(f6_arg0)
			end
		end)
	end
	if f6_local6 then
		f6_arg0:subscribeToModel(f6_local6, function(model)
			local f13_local0 = Engine[0x614D394F6F9A18D](model)
			if f13_local0 then
				f6_arg0.alignment = f13_local0
				f0_local3(f6_arg0)
			end
		end)
	end
	if f6_local7 then
		f6_arg0:subscribeToModel(f6_local7, function(model)
			local f14_local0 = Engine[0x614D394F6F9A18D](model)
			if f14_local0 and tonumber(f14_local0) then
				f6_arg0.Text:setAlpha(0)
				f6_arg0.Text:beginAnimation("fadeOverTime", f14_local0)
				f6_arg0.Text:setAlpha(1)
			end
		end)
	end
	if f6_local8 then
		f6_arg0:subscribeToModel(f6_local8, function(model)
			local f15_local0 = Engine[0x614D394F6F9A18D](model)
			if f15_local0 then
				f6_arg0.red = f15_local0
				f0_local4(f6_arg0)
			end
		end)
	end
	if f6_local9 then
		f6_arg0:subscribeToModel(f6_local9, function(model)
			local f16_local0 = Engine[0x614D394F6F9A18D](model)
			if f16_local0 then
				f6_arg0.green = f16_local0
				f0_local4(f6_arg0)
			end
		end)
	end
	if f6_local10 then
		f6_arg0:subscribeToModel(f6_local10, function(model)
			local f17_local0 = Engine[0x614D394F6F9A18D](model)
			if f17_local0 then
				f6_arg0.blue = f17_local0
				f0_local4(f6_arg0)
			end
		end)
	end
end
CoD.HudElementText = InheritFrom(CoD.Menu)
LUI.createMenu.HudElementText = function(f18_arg0, f18_arg1)
	local self = CoD.Menu.NewForUIEditor("HudElementText", f18_arg0)
	local f18_local1 = self
	SetProperty(self, "disableInputLock", true)
	self:setClass(CoD.HudElementText)
	self.soundSet = "default"
	self:setOwner(f18_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f18_arg0)
	self.ignoreCursor = true
	local Text = LUI.UIText.new(0, 0, 441, 1191, 0, 0, 144, 181)
	Text:setText("")
	Text:setTTF("default")
	Text:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Text)
	self.Text = Text
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
CoD.HudElementText.__onClose = function(f19_arg0) end
