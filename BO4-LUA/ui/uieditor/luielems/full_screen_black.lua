local f0_local0 = function(f1_arg0)
	if f1_arg0.red and f1_arg0.green and f1_arg0.blue then
		f1_arg0.Fullscreen:setRGB(f1_arg0.red, f1_arg0.green, f1_arg0.blue)
	end
end
local PostLoadFunc = function(f2_arg0)
	local f2_local0 = f2_arg0:getModel(Engine[0xA5B9C0111291A8B](), "red")
	local f2_local1 = f2_arg0:getModel(Engine[0xA5B9C0111291A8B](), "green")
	local f2_local2 = f2_arg0:getModel(Engine[0xA5B9C0111291A8B](), "blue")
	if f2_local0 then
		f2_arg0:subscribeToModel(f2_local0, function(model)
			local f3_local0 = Engine[0x614D394F6F9A18D](model)
			if f3_local0 then
				f2_arg0.red = f3_local0
				f0_local0(f2_arg0)
			end
		end)
	end
	if f2_local1 then
		f2_arg0:subscribeToModel(f2_local1, function(model)
			local f4_local0 = Engine[0x614D394F6F9A18D](model)
			if f4_local0 then
				f2_arg0.green = f4_local0
				f0_local0(f2_arg0)
			end
		end)
	end
	if f2_local2 then
		f2_arg0:subscribeToModel(f2_local2, function(model)
			local f5_local0 = Engine[0x614D394F6F9A18D](model)
			if f5_local0 then
				f2_arg0.blue = f5_local0
				f0_local0(f2_arg0)
			end
		end)
	end
	local f2_local3 = f2_arg0:getModel()
	local f2_local4 = function()
		local f6_local0 = f2_local3.fadeOverTime:get()
		local f6_local1 = f2_local3.startAlpha
		local f6_local2 = f2_local3.endAlpha
		local f6_local3
		if f6_local1 then
			f6_local3 = f6_local1:get()
			if not f6_local3 then
			else
				local f6_local4
				if f6_local2 then
					f6_local4 = f6_local2:get()
					if not f6_local4 then
					else
						if f6_local0 then
							if f6_local4 == 0 then
								if f6_local3 == 0 or f6_local0 == 0 then
									CoD.Menu.RemoveFromCurrMenuNameList(f2_arg0.menuName)
								else
									f2_arg0.Fullscreen:registerEventHandler("clip_over", function(element, event)
										element.Fullscreen:registerEventHandler("clip_over", CoD.NullFunction)
										CoD.Menu.RemoveFromCurrMenuNameList(element.menuName)
									end)
								end
							else
								CoD.Menu.AddToCurrMenuNameList(f2_arg0.menuName)
							end
							if f6_local3 >= 0 then
								f2_arg0.Fullscreen:setAlpha(f6_local3)
							end
							f2_arg0.Fullscreen:beginAnimation("fadeOverTime", f6_local0)
							f2_arg0.Fullscreen:setAlpha(f6_local4)
						end
					end
				end
				f6_local4 = 0
			end
		end
		f6_local3 = 0
	end
	for f2_local8, f2_local9 in ipairs({
		f2_local3.startAlpha,
		f2_local3.endAlpha,
		f2_local3.fadeOverTime,
	}) do
		f2_arg0:subscribeToModel(f2_local9, f2_local4)
	end
end
CoD.full_screen_black = InheritFrom(CoD.Menu)
LUI.createMenu.full_screen_black = function(f8_arg0, f8_arg1)
	local self = CoD.Menu.NewForUIEditor("full_screen_black", f8_arg0)
	local f8_local1 = self
	SetProperty(self, "disableInputLock", true)
	self:setClass(CoD.full_screen_black)
	self.soundSet = "none"
	self:setOwner(f8_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f8_arg0)
	self.ignoreCursor = true
	local Fullscreen = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Fullscreen)
	self.Fullscreen = Fullscreen
	self.Fullscreen:linkToElementModel(self, "color", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			Fullscreen:setRGB(f9_local0)
		end
	end)
	self:linkToElementModel(self, "drawHUD", true, function(model)
		local f10_local0 = self
		if CoD.ModelUtility.IsParamModelEqualTo(model, 1) then
			SetProperty(self, "_priority", -1)
		end
	end)
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
CoD.full_screen_black.__onClose = function(f11_arg0)
	f11_arg0.Fullscreen:close()
end
