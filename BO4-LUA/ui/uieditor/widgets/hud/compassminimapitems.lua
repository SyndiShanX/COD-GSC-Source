CoD.CompassMinimapItems = InheritFrom(LUI.UIElement)
CoD.CompassMinimapItems.__defaultWidth = 192
CoD.CompassMinimapItems.__defaultHeight = 192
CoD.CompassMinimapItems.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CompassMinimapItems)
	self.id = "CompassMinimapItems"
	self.soundSet = "default"
	local CompassMinimapItems = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	CompassMinimapItems:setupCompassItems(Enum[@"compasstype"][@"compass_type_partial"])
	self:addElement(CompassMinimapItems)
	self.CompassMinimapItems = CompassMinimapItems
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
