CoD.SpawnSelectKillcamFrame_BGLayoutElements = InheritFrom(LUI.UIElement)
CoD.SpawnSelectKillcamFrame_BGLayoutElements.__defaultWidth = 1890
CoD.SpawnSelectKillcamFrame_BGLayoutElements.__defaultHeight = 832
CoD.SpawnSelectKillcamFrame_BGLayoutElements.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectKillcamFrame_BGLayoutElements)
	self.id = "SpawnSelectKillcamFrame_BGLayoutElements"
	self.soundSet = "none"
	local TextRecording = LUI.UIImage.new(0, 0, 1646, 1812, 0, 0, 88.5, 120.5)
	TextRecording:setImage(RegisterImage(0x695137AD6704F24))
	self:addElement(TextRecording)
	self.TextRecording = TextRecording
	local TextCoordinate = LUI.UIImage.new(0, 0, 1388, 1781, 0, 0, 762, 781)
	TextCoordinate:setImage(RegisterImage(0xE649075FCE3D183))
	self:addElement(TextCoordinate)
	self.TextCoordinate = TextCoordinate
	local TextLabel = LUI.UIImage.new(0, 0, 90, 310, 0, 0, 38.5, 60.5)
	TextLabel:setRGB(0.64, 0.6, 0.55)
	TextLabel:setImage(RegisterImage(0x7139134D720AE9F))
	self:addElement(TextLabel)
	self.TextLabel = TextLabel
	local BarBottomR = LUI.UIImage.new(0, 0, 1665, 1753, 0, 0, 741, 752)
	BarBottomR:setXRot(180)
	BarBottomR:setImage(RegisterImage(0x85629AEEC475428))
	self:addElement(BarBottomR)
	self.BarBottomR = BarBottomR
	local BarBottomL = LUI.UIImage.new(0, 0, 138, 226, 0, 0, 741, 752)
	BarBottomL:setImage(RegisterImage(0x85629AEEC475428))
	self:addElement(BarBottomL)
	self.BarBottomL = BarBottomL
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
