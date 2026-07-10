require("x64:94dab3a4d2d79b2")
CoD.BM_EmptyContractSlotColumn = InheritFrom(LUI.UIElement)
CoD.BM_EmptyContractSlotColumn.__defaultWidth = 265
CoD.BM_EmptyContractSlotColumn.__defaultHeight = 227
CoD.BM_EmptyContractSlotColumn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_EmptyContractSlotColumn)
	self.id = "BM_EmptyContractSlotColumn"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.18)
	self:addElement(Image)
	self.Image = Image
	local DotCorner9Slice3 = CoD.Corner9Slice.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
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
CoD.BM_EmptyContractSlotColumn.__onClose = function(f4_arg0)
	f4_arg0.DotCorner9Slice3:close()
end
