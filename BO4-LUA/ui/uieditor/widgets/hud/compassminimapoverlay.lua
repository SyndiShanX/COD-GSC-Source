CoD.CompassMinimapOverlay = InheritFrom(LUI.UIElement)
CoD.CompassMinimapOverlay.__defaultWidth = 192
CoD.CompassMinimapOverlay.__defaultHeight = 192
CoD.CompassMinimapOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassMinimapOverlay)
	self.id = "CompassMinimapOverlay"
	self.soundSet = "default"
	local CompassMinimapOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CompassMinimapOverlay:setupCompassOverlay(Enum[@"compasstype"][@"compass_type_partial"])
	self:addElement(CompassMinimapOverlay)
	self.CompassMinimapOverlay = CompassMinimapOverlay
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
