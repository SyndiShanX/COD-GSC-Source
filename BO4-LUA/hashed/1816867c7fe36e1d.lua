require("x64:732ef5e833e059e")
CoD.VHUD_Dart = InheritFrom(CoD.Menu)
LUI.createMenu.VHUD_Dart = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("VHUD_Dart", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.VHUD_Dart)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local vhuddartinternal = CoD.vhud_dart_internal.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	vhuddartinternal:subscribeToGlobalModel(f1_arg0, "PerController", "vehicle", function(model)
		vhuddartinternal:setModel(model, f1_arg0)
	end)
	self:addElement(vhuddartinternal)
	self.vhuddartinternal = vhuddartinternal
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
CoD.VHUD_Dart.__onClose = function(f3_arg0)
	f3_arg0.vhuddartinternal:close()
end
