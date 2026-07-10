CoD.StartMenu_StenciledConnectionMeter = InheritFrom(LUI.UIElement)
CoD.StartMenu_StenciledConnectionMeter.__defaultWidth = 175
CoD.StartMenu_StenciledConnectionMeter.__defaultHeight = 111
CoD.StartMenu_StenciledConnectionMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_StenciledConnectionMeter)
	self.id = "StartMenu_StenciledConnectionMeter"
	self.soundSet = "default"
	local PingBarGraph = LUI.UIImage.new(0.5, 0.5, -132.5, 152.5, 0, 0, -0.5, 110.5)
	PingBarGraph:setupRenderGraph()
	PingBarGraph:setGraphMode(1)
	self:addElement(PingBarGraph)
	self.PingBarGraph = PingBarGraph
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SetUseStencil(self)
	return self
end
