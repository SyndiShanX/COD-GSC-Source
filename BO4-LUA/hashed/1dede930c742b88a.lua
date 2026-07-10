require("x64:5cc77ac7f6d6b19")
require("x64:e190f4b268426c1")
CoD.WZAAR_Containers = InheritFrom(LUI.UIElement)
CoD.WZAAR_Containers.__defaultWidth = 1920
CoD.WZAAR_Containers.__defaultHeight = 1080
CoD.WZAAR_Containers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZAAR_Containers)
	self.id = "WZAAR_Containers"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Containers = CoD.WZAAR_ContainerList.new(f1_arg0, f1_arg1, 0.5, 0.5, -486, 566, 0.5, 0.5, -300, 300)
	self:addElement(Containers)
	self.Containers = Containers
	local PaintCans = CoD.WZAAR_PaintCans.new(f1_arg0, f1_arg1, 0.5, 0.5, -148, 148, 1, 1, -203.5, -109.5)
	self:addElement(PaintCans)
	self.PaintCans = PaintCans
	Containers.id = "Containers"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAAR_Containers.__onClose = function(f2_arg0)
	f2_arg0.Containers:close()
	f2_arg0.PaintCans:close()
end
