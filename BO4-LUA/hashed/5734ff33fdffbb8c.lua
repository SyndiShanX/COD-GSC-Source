require("x64:5f2f57aae2b9415")
local PostLoadFunc = function(self, controller)
	self.m_inputDisabled = true
end
CoD.VHUD_MS = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_MS = function(f2_arg0, f2_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_MS", f2_arg0)
	local f2_local1 = self
	self:setClass(CoD.VHUD_MS)
	self.soundSet = "default"
	self:setOwner(f2_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f2_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local vhudmsInternal0 = CoD.vhud_ms_Internal.new(f2_local1, f2_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudmsInternal0:linkToElementModel(self, nil, false, function(model)
		vhudmsInternal0:setModel(model, f2_arg0)
	end)
	self:addElement(vhudmsInternal0)
	self.vhudmsInternal0 = vhudmsInternal0
	self:processEvent({
		name = "menu_loaded",
		controller = f2_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f2_arg0)
	end
	return self
end
CoD.VHUD_MS.__onClose = function(f4_arg0)
	f4_arg0.vhudmsInternal0:close()
end
