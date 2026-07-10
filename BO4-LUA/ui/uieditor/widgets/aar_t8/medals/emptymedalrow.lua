require("x64:94dab3a4d2d79b2")
CoD.EmptyMedalRow = InheritFrom(LUI.UIElement)
CoD.EmptyMedalRow.__defaultWidth = 1118
CoD.EmptyMedalRow.__defaultHeight = 227
CoD.EmptyMedalRow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmptyMedalRow)
	self.id = "EmptyMedalRow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 0, 0, 265, 0, 0, 0, 227)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.18)
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(0, 0, 283, 548, 0, 0, 0, 227)
	Image2:setRGB(0, 0, 0)
	Image2:setAlpha(0.18)
	self:addElement(Image2)
	self.Image2 = Image2
	local Image3 = LUI.UIImage.new(0, 0, 566, 831, 0, 0, 0, 227)
	Image3:setRGB(0, 0, 0)
	Image3:setAlpha(0.18)
	self:addElement(Image3)
	self.Image3 = Image3
	local Image4 = LUI.UIImage.new(0, 0, 849, 1114, 0, 0, 0, 227)
	Image4:setRGB(0, 0, 0)
	Image4:setAlpha(0.18)
	self:addElement(Image4)
	self.Image4 = Image4
	local DotCorner9Slice4 = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 849, 1114, 0, 0, 0, 227)
	DotCorner9Slice4:setAlpha(0.9)
	DotCorner9Slice4:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotCorner9Slice4)
	self.DotCorner9Slice4 = DotCorner9Slice4
	local DotCorner9Slice = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 566, 831, 0, 0, 0, 227)
	DotCorner9Slice:setAlpha(0.9)
	DotCorner9Slice:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotCorner9Slice)
	self.DotCorner9Slice = DotCorner9Slice
	local DotCorner9Slice2 = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 283, 548, 0, 0, 0, 227)
	DotCorner9Slice2:setAlpha(0.9)
	DotCorner9Slice2:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotCorner9Slice2)
	self.DotCorner9Slice2 = DotCorner9Slice2
	local DotCorner9Slice3 = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 0, 0, 265, 0, 0, 0, 227)
	DotCorner9Slice3:setAlpha(0.9)
	DotCorner9Slice3:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotCorner9Slice3)
	self.DotCorner9Slice3 = DotCorner9Slice3
	self:mergeStateConditions({
		{
			stateName = "NoMedals",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.MedalsGrid)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f3_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmptyMedalRow.__onClose = function(f4_arg0)
	f4_arg0.DotCorner9Slice4:close()
	f4_arg0.DotCorner9Slice:close()
	f4_arg0.DotCorner9Slice2:close()
	f4_arg0.DotCorner9Slice3:close()
end
