require("x64:330e1ef77701a18")
CoD.mp_infect_timer = InheritFrom(CoD.Menu)
LUI.createMenu.mp_infect_timer = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("mp_infect_timer", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.mp_infect_timer)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local RadialTimer = CoD.RadialTimer.new(f1_local1, f1_arg0, 0.5, 0.5, -75, 75, 0.5, 0.5, 0, 150)
	RadialTimer:linkToElementModel(self, "infectionTimeRemaining", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RadialTimer.Clock:setShaderVector(0, SetVectorComponent(0, 0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	RadialTimer:linkToElementModel(self, "infectionTimeRemaining", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RadialTimer.TimeText:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(RadialTimer)
	self.RadialTimer = RadialTimer
	local TextBox = LUI.UIText.new(0.5, 0.5, -399, 399, 0.5, 0.5, -21, 21)
	TextBox:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6843AB917826EE72"))
	TextBox:setTTF("default")
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TextBox:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
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
CoD.mp_infect_timer.__onClose = function(f4_arg0)
	f4_arg0.RadialTimer:close()
end
