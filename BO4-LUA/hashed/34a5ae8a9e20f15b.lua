require("x64:a01b36b11510f3")
CoD.MastercraftCamoListSelectionWidget = InheritFrom(LUI.UIElement)
CoD.MastercraftCamoListSelectionWidget.__defaultWidth = 1239
CoD.MastercraftCamoListSelectionWidget.__defaultHeight = 400
CoD.MastercraftCamoListSelectionWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MastercraftCamoListSelectionWidget)
	self.id = "MastercraftCamoListSelectionWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local MastercraftGrid = CoD.ThemeOptionGrid.new(f1_arg0, f1_arg1, 0, 0, 0, 1239, 0, 0, 25, 375)
	self:addElement(MastercraftGrid)
	self.MastercraftGrid = MastercraftGrid
	MastercraftGrid.id = "MastercraftGrid"
	self.__defaultFocus = MastercraftGrid
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MastercraftCamoListSelectionWidget.__resetProperties = function(f2_arg0)
	f2_arg0.MastercraftGrid:completeAnimation()
	f2_arg0.MastercraftGrid:setTopBottom(0, 0, 25, 375)
	f2_arg0.MastercraftGrid:setAlpha(1)
end
CoD.MastercraftCamoListSelectionWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		ActiveCamo = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.MastercraftGrid:beginAnimation(100)
				f4_arg0.MastercraftGrid:setTopBottom(0, 0, 375, 725)
				f4_arg0.MastercraftGrid:setAlpha(0)
				f4_arg0.MastercraftGrid:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.MastercraftGrid:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.MastercraftGrid:completeAnimation()
			f4_arg0.MastercraftGrid:setTopBottom(0, 0, 25, 375)
			f4_arg0.MastercraftGrid:setAlpha(1)
			f4_local0(f4_arg0.MastercraftGrid)
		end,
	},
}
CoD.MastercraftCamoListSelectionWidget.__onClose = function(f6_arg0)
	f6_arg0.MastercraftGrid:close()
end
