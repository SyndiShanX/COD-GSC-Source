require("x64:9dba513915b5a12")
CoD.WarzoneDirectorStagesPulsing = InheritFrom(LUI.UIElement)
CoD.WarzoneDirectorStagesPulsing.__defaultWidth = 526
CoD.WarzoneDirectorStagesPulsing.__defaultHeight = 24
CoD.WarzoneDirectorStagesPulsing.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDirectorStagesPulsing)
	self.id = "WarzoneDirectorStagesPulsing"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Stage6 = CoD.WarzoneDirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 346, 526, 0, 0, 0, 24)
	self:addElement(Stage6)
	self.Stage6 = Stage6
	local Stage5 = CoD.WarzoneDirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 173, 353, 0, 0, 0, 24)
	self:addElement(Stage5)
	self.Stage5 = Stage5
	local Stage4 = CoD.WarzoneDirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 0, 180, 0, 0, 0, 24)
	self:addElement(Stage4)
	self.Stage4 = Stage4
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneDirectorStagesPulsing.__resetProperties = function(f2_arg0)
	f2_arg0.Stage4:completeAnimation()
	f2_arg0.Stage5:completeAnimation()
	f2_arg0.Stage6:completeAnimation()
	f2_arg0.Stage4:setAlpha(1)
	f2_arg0.Stage5:setAlpha(1)
	f2_arg0.Stage6:setAlpha(1)
end
CoD.WarzoneDirectorStagesPulsing.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			f3_arg0.Stage6:completeAnimation()
			f3_arg0.Stage6:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Stage6)
			f3_arg0.Stage5:completeAnimation()
			f3_arg0.Stage5:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Stage5)
			f3_arg0.Stage4:completeAnimation()
			f3_arg0.Stage4:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.Stage4)
		end,
	},
	Visible = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WarzoneDirectorStagesPulsing.__onClose = function(f5_arg0)
	f5_arg0.Stage6:close()
	f5_arg0.Stage5:close()
	f5_arg0.Stage4:close()
end
