CoD.SpawnSelectKillcamFrame_BGLayout = InheritFrom(LUI.UIElement)
CoD.SpawnSelectKillcamFrame_BGLayout.__defaultWidth = 1890
CoD.SpawnSelectKillcamFrame_BGLayout.__defaultHeight = 832
CoD.SpawnSelectKillcamFrame_BGLayout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpawnSelectKillcamFrame_BGLayout)
	self.id = "SpawnSelectKillcamFrame_BGLayout"
	self.soundSet = "none"
	local LayoutLines = LUI.UIImage.new(0.5, 0.5, -944, 944, 0, 0, 0, 48)
	LayoutLines:setImage(RegisterImage(0x16D3BA67D51FFAA))
	self:addElement(LayoutLines)
	self.LayoutLines = LayoutLines
	local LayoutStripe = LUI.UIImage.new(0.5, 0.5, -873, 873, 0, 0, 776, 832)
	LayoutStripe:setImage(RegisterImage(0xE4F4A25FB519F6))
	self:addElement(LayoutStripe)
	self.LayoutStripe = LayoutStripe
	local BarRight = LUI.UIImage.new(0, 0, 1700, 1758, 0, 0, 328, 356)
	BarRight:setImage(RegisterImage(0x1A7EE226176D9CB))
	self:addElement(BarRight)
	self.BarRight = BarRight
	local BarLeft = LUI.UIImage.new(0, 0, 128, 186, 0, 0, 328, 356)
	BarLeft:setImage(RegisterImage(0x1A7EE226176D9CB))
	self:addElement(BarLeft)
	self.BarLeft = BarLeft
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
	local TextInformation = LUI.UIImage.new(0, 0, 1693, 1753, 0, 0, 352, 372)
	TextInformation:setImage(RegisterImage(0xCBC2FF0C98D0D4D))
	self:addElement(TextInformation)
	self.TextInformation = TextInformation
	local TextStatus = LUI.UIImage.new(0, 0, 132, 198, 0, 0, 354, 373)
	TextStatus:setImage(RegisterImage(0xB262A80552F2C7))
	self:addElement(TextStatus)
	self.TextStatus = TextStatus
	local BarBottomL = LUI.UIImage.new(0, 0, 138, 226, 0, 0, 741, 752)
	BarBottomL:setImage(RegisterImage(0x85629AEEC475428))
	self:addElement(BarBottomL)
	self.BarBottomL = BarBottomL
	local BarBottomR = LUI.UIImage.new(0, 0, 1665, 1753, 0, 0, 741, 752)
	BarBottomR:setXRot(180)
	BarBottomR:setImage(RegisterImage(0x85629AEEC475428))
	self:addElement(BarBottomR)
	self.BarBottomR = BarBottomR
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
