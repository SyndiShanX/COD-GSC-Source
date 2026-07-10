CoD.debug_center_screen = InheritFrom(CoD.Menu)
LUI.createMenu.debug_center_screen = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("debug_center_screen", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.debug_center_screen)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	local vertical = LUI.UIImage.new(0.5, 0.5, -1, 1, 0, 1, 0, 0)
	self:addElement(vertical)
	self.vertical = vertical
	local horizontal = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -1, 1)
	self:addElement(horizontal)
	self.horizontal = horizontal
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg0)
	end
	local f1_local4 = self
	if IsPC() then
		SizeToWidthOfScreen(f1_local4, f1_arg0)
	end
	return self
end
CoD.debug_center_screen.__onClose = function(f2_arg0) end
