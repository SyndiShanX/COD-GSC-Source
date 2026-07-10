require("x64:19c1945d2e472b0")
CoD.PositionDraft_StatusBannerFrame = InheritFrom(LUI.UIElement)
CoD.PositionDraft_StatusBannerFrame.__defaultWidth = 1104
CoD.PositionDraft_StatusBannerFrame.__defaultHeight = 168
CoD.PositionDraft_StatusBannerFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PositionDraft_StatusBannerFrame)
	self.id = "PositionDraft_StatusBannerFrame"
	self.soundSet = "default"
	local TextBackingLeftBlur = LUI.UIImage.new(0, 0, 0, 552, 0, 0, 2, 166)
	TextBackingLeftBlur:setAlpha(0.8)
	TextBackingLeftBlur:setImage(RegisterImage(0xD78C39F28AB8E39))
	TextBackingLeftBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	TextBackingLeftBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(TextBackingLeftBlur)
	self.TextBackingLeftBlur = TextBackingLeftBlur
	local TextBackingRightBlur = LUI.UIImage.new(0, 0, 552, 1104, 0, 0, 2, 166)
	TextBackingRightBlur:setAlpha(0.8)
	TextBackingRightBlur:setYRot(180)
	TextBackingRightBlur:setImage(RegisterImage(0xD78C39F28AB8E39))
	TextBackingRightBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	TextBackingRightBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(TextBackingRightBlur)
	self.TextBackingRightBlur = TextBackingRightBlur
	local f1_local3 = nil
	self.TextBackingLeft = LUI.UIElement.createFake()
	local f1_local4 = nil
	self.TextBackingRight = LUI.UIElement.createFake()
	local TextBackingPC = nil
	TextBackingPC = LUI.UIImage.new(0, 0, 0, 1104, 0, 0, 2, 166)
	TextBackingPC:setAlpha(0.4)
	TextBackingPC:setYRot(180)
	TextBackingPC:setImage(RegisterImage(0x43E4122CBBE4A3))
	self:addElement(TextBackingPC)
	self.TextBackingPC = TextBackingPC
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 14, 1091, 0, 0, 10, 159)
	DotTiledBacking:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local FrameInnerBR = LUI.UIImage.new(0, 0, 551, 1103, 0, 0, 84, 168)
	FrameInnerBR:setYRot(180)
	FrameInnerBR:setImage(RegisterImage(0x4356A58A3337B92))
	self:addElement(FrameInnerBR)
	self.FrameInnerBR = FrameInnerBR
	local FrameInnerBL = LUI.UIImage.new(0, 0, 0, 552, 0, 0, 84, 168)
	FrameInnerBL:setImage(RegisterImage(0x4356A58A3337B92))
	self:addElement(FrameInnerBL)
	self.FrameInnerBL = FrameInnerBL
	local FrameInnerTL = LUI.UIImage.new(0, 0, 0, 552, 0, 0, 0, 84)
	FrameInnerTL:setImage(RegisterImage(0x9EE24585DA7AA80))
	self:addElement(FrameInnerTL)
	self.FrameInnerTL = FrameInnerTL
	local FrameInnerTR = LUI.UIImage.new(0, 0, 551, 1103, 0, 0, 0, 84)
	FrameInnerTR:setYRot(180)
	FrameInnerTR:setImage(RegisterImage(0x9EE24585DA7AA80))
	self:addElement(FrameInnerTR)
	self.FrameInnerTR = FrameInnerTR
	local FrameOuterTL = LUI.UIImage.new(0, 0, 0, 552, 0, 0, 0, 84)
	FrameOuterTL:setImage(RegisterImage(0xDCE859A0174616B))
	self:addElement(FrameOuterTL)
	self.FrameOuterTL = FrameOuterTL
	local FrameOuterBL = LUI.UIImage.new(0, 0, 0, 552, 0, 0, 84, 168)
	FrameOuterBL:setImage(RegisterImage(0x8EECB9A47B8233D))
	self:addElement(FrameOuterBL)
	self.FrameOuterBL = FrameOuterBL
	local FrameOuterBR = LUI.UIImage.new(0, 0, 551, 1103, 0, 0, 84, 168)
	FrameOuterBR:setYRot(180)
	FrameOuterBR:setImage(RegisterImage(0x8EECB9A47B8233D))
	self:addElement(FrameOuterBR)
	self.FrameOuterBR = FrameOuterBR
	local FrameOuterTR = LUI.UIImage.new(0, 0, 551, 1103, 0, 0, 0, 84)
	FrameOuterTR:setYRot(180)
	FrameOuterTR:setImage(RegisterImage(0xDCE859A0174616B))
	self:addElement(FrameOuterTR)
	self.FrameOuterTR = FrameOuterTR
	local microtext = LUI.UIImage.new(0, 0, 58.5, 76.5, 0, 0, 5.5, 9.5)
	microtext:setAlpha(0.18)
	microtext:setZRot(180)
	microtext:setImage(RegisterImage(0x16C3274D8031268))
	self:addElement(microtext)
	self.microtext = microtext
	local microtext2 = LUI.UIImage.new(0, 0, 47.5, 65.5, 0, 0, 6, 10)
	microtext2:setAlpha(0.18)
	microtext2:setImage(RegisterImage(0x16C3274D8031268))
	microtext2:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	microtext2:setShaderVector(0, 0, 0.38, 0, 0)
	microtext2:setShaderVector(1, 0, 0, 0, 0)
	microtext2:setShaderVector(2, 0, 1, 0, 0)
	microtext2:setShaderVector(3, 0, 0, 0, 0)
	microtext2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext2)
	self.microtext2 = microtext2
	local microtext3 = LUI.UIImage.new(0, 0, 1045.5, 1063.5, 0, 0, 5, 9)
	microtext3:setAlpha(0.18)
	microtext3:setZRot(180)
	microtext3:setImage(RegisterImage(0x16C3274D8031268))
	self:addElement(microtext3)
	self.microtext3 = microtext3
	local microtext4 = LUI.UIImage.new(0, 0, 1036.5, 1054.5, 0, 0, 5.5, 9.5)
	microtext4:setAlpha(0.18)
	microtext4:setImage(RegisterImage(0x16C3274D8031268))
	microtext4:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	microtext4:setShaderVector(0, 0, 0.38, 0, 0)
	microtext4:setShaderVector(1, 0, 0, 0, 0)
	microtext4:setShaderVector(2, 0, 1, 0, 0)
	microtext4:setShaderVector(3, 0, 0, 0, 0)
	microtext4:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext4)
	self.microtext4 = microtext4
	local microtext5 = LUI.UIImage.new(0, 0, 58.5, 76.5, 0, 0, 159.5, 163.5)
	microtext5:setAlpha(0.18)
	microtext5:setZRot(180)
	microtext5:setImage(RegisterImage(0x16C3274D8031268))
	self:addElement(microtext5)
	self.microtext5 = microtext5
	local microtext6 = LUI.UIImage.new(0, 0, 47.5, 65.5, 0, 0, 160, 164)
	microtext6:setAlpha(0.18)
	microtext6:setImage(RegisterImage(0x16C3274D8031268))
	microtext6:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	microtext6:setShaderVector(0, 0, 0.38, 0, 0)
	microtext6:setShaderVector(1, 0, 0, 0, 0)
	microtext6:setShaderVector(2, 0, 1, 0, 0)
	microtext6:setShaderVector(3, 0, 0, 0, 0)
	microtext6:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext6)
	self.microtext6 = microtext6
	local microtext7 = LUI.UIImage.new(0, 0, 1045.5, 1063.5, 0, 0, 160, 164)
	microtext7:setAlpha(0.18)
	microtext7:setZRot(180)
	microtext7:setImage(RegisterImage(0x16C3274D8031268))
	self:addElement(microtext7)
	self.microtext7 = microtext7
	local microtext8 = LUI.UIImage.new(0, 0, 1036.5, 1054.5, 0, 0, 160, 164)
	microtext8:setAlpha(0.18)
	microtext8:setImage(RegisterImage(0x16C3274D8031268))
	microtext8:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	microtext8:setShaderVector(0, 0, 0.38, 0, 0)
	microtext8:setShaderVector(1, 0, 0, 0, 0)
	microtext8:setShaderVector(2, 0, 1, 0, 0)
	microtext8:setShaderVector(3, 0, 0, 0, 0)
	microtext8:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(microtext8)
	self.microtext8 = microtext8
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PositionDraft_StatusBannerFrame.__onClose = function(f2_arg0)
	f2_arg0.DotTiledBacking:close()
end
