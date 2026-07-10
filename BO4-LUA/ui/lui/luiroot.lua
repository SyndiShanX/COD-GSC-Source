LUI.UIRoot = {}
local f0_local0 = function(f1_arg0, f1_arg1)
	f1_arg0:setLayoutCached(false)
	f1_arg0:dispatchEventToChildren(f1_arg1)
end
local f0_local1 = function(f2_arg0, f2_arg1)
	Engine[@"gcstop"]()
	if f2_arg1.uiMenuCommand == Enum[@"uimenucommand_t"][@"uimenu_newlobby"] then
		f2_arg1.menu = "Director"
	end
	local f2_local0 = LUI.createMenu[f2_arg1.menu]
	if f2_local0 then
		local f2_local1 = f2_local0(f2_arg1.controller)
		f2_arg0:addElement(f2_local1)
		f2_local1:menuOpened(f2_arg1.controller, f2_local1, true)
	else
		error("LUI Error: Tried to add nonexistent menu " .. f2_arg1.menu)
	end
	Engine[@"gcrestart"]()
	return true
end
LUI.UIRoot.new = function(menu, controller)
	local self = LUI.UIElement.new(0.5, 0.5, 0, 0, 0.5, 0.5, 0, 0)
	self.id = "LUIRoot"
	self:registerEventHandler("addmenu", f0_local1)
	self:registerEventHandler("controller_changed", f0_local0)
	self.name = menu
	self:setRoot()
	LUI.roots[menu] = self
	return self
end
