require("x64:a16ecc458cd2b0d")
require("x64:7e1d32103d811af")
CoD.TabletIcePickGadget = InheritFrom(LUI.UIElement)
CoD.TabletIcePickGadget.__defaultWidth = 1920
CoD.TabletIcePickGadget.__defaultHeight = 1080
CoD.TabletIcePickGadget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePickGadget)
	self.id = "TabletIcePickGadget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local IcePickUI3D = CoD.TabletIcePickGadget_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 1336, 0, 0, 0, 740)
	Engine[0xF0AF2C4A29D15D7](f1_arg1, 5, 1336, 740)
	IcePickUI3D:setUI3DWindow(5)
	IcePickUI3D:setScale(0.8, 0.8)
	IcePickUI3D:subscribeToGlobalModel(f1_arg1, "IcePickInfo", nil, function(model)
		IcePickUI3D:setModel(model, f1_arg1)
	end)
	self:addElement(IcePickUI3D)
	self.IcePickUI3D = IcePickUI3D
	local TabletIcePickSecondaryWindow = CoD.TabletIcePickSecondaryWindow.new(f1_arg0, f1_arg1, 0, 0, 1534, 1842, 0, 0, 78.5, 423.5)
	Engine[0xF0AF2C4A29D15D7](f1_arg1, 2, 308, 345)
	TabletIcePickSecondaryWindow:setUI3DWindow(2)
	TabletIcePickSecondaryWindow:setAlpha(0.3)
	TabletIcePickSecondaryWindow:subscribeToGlobalModel(f1_arg1, "IcePickInfo", nil, function(model)
		TabletIcePickSecondaryWindow:setModel(model, f1_arg1)
	end)
	self:addElement(TabletIcePickSecondaryWindow)
	self.TabletIcePickSecondaryWindow = TabletIcePickSecondaryWindow
	IcePickUI3D.id = "IcePickUI3D"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletIcePickGadget.__onClose = function(f4_arg0)
	f4_arg0.IcePickUI3D:close()
	f4_arg0.TabletIcePickSecondaryWindow:close()
end
