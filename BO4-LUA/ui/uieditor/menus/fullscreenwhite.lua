local PostLoadFunc = function(f1_arg0)
	local f1_local0 = f1_arg0:getModel(Engine.GetPrimaryController(), "fadeOverTime")
	if f1_local0 then
		f1_arg0:subscribeToModel(f1_local0, function(model)
			local modelValue = Engine.GetModelValue(model)
			local f2_local1 = f1_arg0:getModel(Engine.GetPrimaryController(), "startAlpha")
			local f2_local2 = f1_arg0:getModel(Engine.GetPrimaryController(), "endAlpha")
			local f2_local3 = 0
			local f2_local4 = 0
			if f2_local1 then
				f2_local3 = Engine.GetModelValue(f2_local1)
			end
			if f2_local2 then
				f2_local4 = Engine.GetModelValue(f2_local2)
			end
			if modelValue then
				if f2_local4 == 0 then
					CoD.Menu.RemoveFromCurrMenuNameList(f1_arg0.menuName)
				else
					CoD.Menu.AddToCurrMenuNameList(f1_arg0.menuName)
				end
				if f2_local3 >= 0 then
					f1_arg0.Fullscreen:setAlpha(f2_local3)
				end
				f1_arg0.Fullscreen:beginAnimation("fadeOverTime", modelValue)
				f1_arg0.Fullscreen:setAlpha(f2_local4)
			end
		end)
	end
end
CoD.FullScreenWhite = InheritFrom(CoD.Menu)
LUI.createMenu.FullScreenWhite = function(f3_arg0, f3_arg1)
	local self = CoD.Menu.NewForUIEditor("FullScreenWhite", f3_arg0)
	local f3_local1 = self
	self:setClass(CoD.FullScreenWhite)
	self.soundSet = "none"
	self:setOwner(f3_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f3_arg0)
	self.ignoreCursor = true
	local Fullscreen = LUI.UIImage.new(0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(Fullscreen)
	self.Fullscreen = Fullscreen
	self:processEvent({
		name = "menu_loaded",
		controller = f3_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f3_arg0)
	end
	return self
end
CoD.FullScreenWhite.__onClose = function(f4_arg0) end
