require("x64:ef49c7577d8971e")
CoD.prototype_defend_timer = InheritFrom(CoD.Menu)
LUI.createMenu.prototype_defend_timer = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("prototype_defend_timer", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.prototype_defend_timer)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local timerWidget = CoD.timerWidget.new(f1_local1, f1_arg0, 0.5, 0.5, -124, 124, 0.5, 0.5, -329, -191)
	timerWidget:subscribeToGlobalModel(f1_arg0, "WarzoneGlobal", "srProtoTimer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			timerWidget.Timer:setupEndTimer(f2_local0)
		end
	end)
	self:addElement(timerWidget)
	self.timerWidget = timerWidget
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f3_arg2, f3_arg3, f3_arg4)
		UpdateElementState(self, "timerWidget", controller)
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local3 = self
	SizeToSafeArea(self, f1_arg0)
	return self
end
CoD.prototype_defend_timer.__onClose = function(f4_arg0)
	f4_arg0.timerWidget:close()
end
