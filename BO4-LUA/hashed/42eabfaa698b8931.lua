require("x64:a9255c570c68aa8")
CoD.GameEndScore_HeaderBarTip = InheritFrom(LUI.UIElement)
CoD.GameEndScore_HeaderBarTip.__defaultWidth = 130
CoD.GameEndScore_HeaderBarTip.__defaultHeight = 80
CoD.GameEndScore_HeaderBarTip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_HeaderBarTip)
	self.id = "GameEndScore_HeaderBarTip"
	self.soundSet = "none"
	local BackingBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingBlur:setRGB(0, 0, 0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local BaseBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BaseBacking:setRGB(0, 0, 0)
	BaseBacking:setAlpha(0.93)
	self:addElement(BaseBacking)
	self.BaseBacking = BaseBacking
	local Grid = LUI.UIImage.new(0, 0.89, 0, 0, -0, 1, 0, 0)
	Grid:setRGB(0, 0, 0)
	Grid:setAlpha(0.25)
	Grid:setImage(RegisterImage(0x2F926473EDCBFCA))
	Grid:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	Grid:setShaderVector(0, 0, 0, 0, 0)
	Grid:setupNineSliceShader(22, 20)
	self:addElement(Grid)
	self.Grid = Grid
	local BlackStripBot = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -10, 0)
	BlackStripBot:setRGB(0, 0, 0)
	BlackStripBot:setAlpha(0.9)
	self:addElement(BlackStripBot)
	self.BlackStripBot = BlackStripBot
	local BlackStripTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 10)
	BlackStripTop:setRGB(0, 0, 0)
	BlackStripTop:setAlpha(0.9)
	self:addElement(BlackStripTop)
	self.BlackStripTop = BlackStripTop
	local Arrow = LUI.UIImage.new(1, 1, -15, 0, 0.5, 0.5, -30, 30)
	Arrow:setRGB(0, 0, 0)
	Arrow:setAlpha(0.85)
	Arrow:setYRot(180)
	Arrow:setImage(RegisterImage(0x408E29FE6FA534D))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local CrossMarkTop = LUI.UIImage.new(0, 0, 34.5, 53.5, 0, 0, 3, 22)
	CrossMarkTop:setRGB(0, 0, 0)
	CrossMarkTop:setAlpha(0.25)
	CrossMarkTop:setImage(RegisterImage(0xD89B11EC41D18DF))
	self:addElement(CrossMarkTop)
	self.CrossMarkTop = CrossMarkTop
	local CrossMarkBot = LUI.UIImage.new(0, 0, 34.5, 53.5, 0, 0, 59, 78)
	CrossMarkBot:setRGB(0, 0, 0)
	CrossMarkBot:setAlpha(0.25)
	CrossMarkBot:setImage(RegisterImage(0xD89B11EC41D18DF))
	self:addElement(CrossMarkBot)
	self.CrossMarkBot = CrossMarkBot
	local StartMenuOptionsMainFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 2.5, 32.5, 0, 0, 32.5, 47.5)
	StartMenuOptionsMainFrame:setRGB(0, 0, 0)
	StartMenuOptionsMainFrame:setAlpha(0.3)
	self:addElement(StartMenuOptionsMainFrame)
	self.StartMenuOptionsMainFrame = StartMenuOptionsMainFrame
	local StartMenuOptionsMainFrame2 = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.6, 0.6, -22.5, 7.5, 0.5, 0.5, -7.5, 7.5)
	StartMenuOptionsMainFrame2:setRGB(0, 0, 0)
	StartMenuOptionsMainFrame2:setAlpha(0.3)
	self:addElement(StartMenuOptionsMainFrame2)
	self.StartMenuOptionsMainFrame2 = StartMenuOptionsMainFrame2
	local CrossMarkMid = LUI.UIImage.new(0, 0, 34.5, 53.5, 0, 0, 30.5, 49.5)
	CrossMarkMid:setRGB(0, 0, 0)
	CrossMarkMid:setAlpha(0.6)
	CrossMarkMid:setImage(RegisterImage(0xD89B11EC41D18DF))
	self:addElement(CrossMarkMid)
	self.CrossMarkMid = CrossMarkMid
	local FrameTop2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -1, 15)
	FrameTop2:setImage(RegisterImage(0x5FDC97796CA8AC2))
	self:addElement(FrameTop2)
	self.FrameTop2 = FrameTop2
	local FrameBot = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -15, 1)
	FrameBot:setXRot(180)
	FrameBot:setImage(RegisterImage(0x5FDC97796CA8AC2))
	self:addElement(FrameBot)
	self.FrameBot = FrameBot
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScore_HeaderBarTip.__onClose = function(f2_arg0)
	f2_arg0.StartMenuOptionsMainFrame:close()
	f2_arg0.StartMenuOptionsMainFrame2:close()
end
