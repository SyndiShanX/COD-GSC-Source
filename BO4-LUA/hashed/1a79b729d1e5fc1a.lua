CoD.WarScoreInfo_Capture_ProgressMarker = InheritFrom(LUI.UIElement)
CoD.WarScoreInfo_Capture_ProgressMarker.__defaultWidth = 5
CoD.WarScoreInfo_Capture_ProgressMarker.__defaultHeight = 15
CoD.WarScoreInfo_Capture_ProgressMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarScoreInfo_Capture_ProgressMarker)
	self.id = "WarScoreInfo_Capture_ProgressMarker"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Marker = LUI.UIImage.new(0, 0, 0, 5, 0, 1, 0, 0)
	Marker:setRGB(0.53, 0.53, 0.53)
	self:addElement(Marker)
	self.Marker = Marker
	local LeftArrow = LUI.UIImage.new(0, 0, -17, -2, 0, 0, 0, 15)
	LeftArrow:setRGB(1, 1, 0)
	self:addElement(LeftArrow)
	self.LeftArrow = LeftArrow
	local RightArrow = LUI.UIImage.new(0, 0, 7, 22, 0, 0, 0, 15)
	RightArrow:setRGB(0, 1, 0)
	self:addElement(RightArrow)
	self.RightArrow = RightArrow
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarScoreInfo_Capture_ProgressMarker.__resetProperties = function(f2_arg0)
	f2_arg0.LeftArrow:completeAnimation()
	f2_arg0.RightArrow:completeAnimation()
	f2_arg0.LeftArrow:setAlpha(1)
	f2_arg0.RightArrow:setAlpha(1)
end
CoD.WarScoreInfo_Capture_ProgressMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.LeftArrow:completeAnimation()
			f3_arg0.LeftArrow:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.LeftArrow)
			f3_arg0.RightArrow:completeAnimation()
			f3_arg0.RightArrow:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.RightArrow)
		end,
	},
	LeftArrow = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.RightArrow:completeAnimation()
			f4_arg0.RightArrow:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.RightArrow)
		end,
	},
	RightArrow = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.LeftArrow:completeAnimation()
			f5_arg0.LeftArrow:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.LeftArrow)
		end,
	},
}
