CoD.AARRewardBacker_ZM = InheritFrom(LUI.UIElement)
CoD.AARRewardBacker_ZM.__defaultWidth = 412
CoD.AARRewardBacker_ZM.__defaultHeight = 772
CoD.AARRewardBacker_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARRewardBacker_ZM)
	self.id = "AARRewardBacker_ZM"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CroppedZmBacking2 = LUI.UIImage.new(0, 0, -1, 412, 0, 0, 15.5, 771.5)
	CroppedZmBacking2:setAlpha(0.5)
	CroppedZmBacking2:setImage(RegisterImage(0xA8FC401C1972BDE))
	CroppedZmBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	CroppedZmBacking2:setShaderVector(0, 0, 0, 0, 0)
	CroppedZmBacking2:setShaderVector(1, 1, 1, 0, 0)
	CroppedZmBacking2:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(CroppedZmBacking2)
	self.CroppedZmBacking2 = CroppedZmBacking2
	local BotPatterLeft = LUI.UIImage.new(0, 0, -1, 167, 0, 0, 605, 773)
	BotPatterLeft:setAlpha(0.5)
	BotPatterLeft:setImage(RegisterImage(0x148112C3722ADE9))
	BotPatterLeft:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	BotPatterLeft:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BotPatterLeft)
	self.BotPatterLeft = BotPatterLeft
	local BotPatterRight = LUI.UIImage.new(0, 0, 414, 246, 0, 0, 605, 773)
	BotPatterRight:setAlpha(0.5)
	BotPatterRight:setImage(RegisterImage(0x148112C3722ADE9))
	BotPatterRight:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	BotPatterRight:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BotPatterRight)
	self.BotPatterRight = BotPatterRight
	local BgTint = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 20, 772)
	BgTint:setRGB(0, 0, 0)
	BgTint:setAlpha(0.5)
	self:addElement(BgTint)
	self.BgTint = BgTint
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 20, 0)
	TiledBacking:setAlpha(0.2)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local CroppedZmBacking = LUI.UIImage.new(0, 0, -1, 412, 0, 0, 15.5, 771.5)
	CroppedZmBacking:setImage(RegisterImage(0xA8FC401C1972BDE))
	CroppedZmBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	CroppedZmBacking:setShaderVector(0, 0, 0, 0, 0)
	CroppedZmBacking:setShaderVector(1, 1, 1, 0, 0)
	CroppedZmBacking:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(CroppedZmBacking)
	self.CroppedZmBacking = CroppedZmBacking
	local BotBar = LUI.UIImage.new(0, 0, -6, 418, 1, 1, -15, 25)
	BotBar:setImage(RegisterImage(0x24F1A68C216ACF6))
	self:addElement(BotBar)
	self.BotBar = BotBar
	local TopBar = LUI.UIImage.new(0, 0, -6, 418, 0, 0, -9, 15)
	TopBar:setImage(RegisterImage(0x45C555C45B1E6E4))
	self:addElement(TopBar)
	self.TopBar = TopBar
	local YellowLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 15.5, 23.5)
	YellowLine:setImage(RegisterImage(0xE6E505307F7B8D7))
	YellowLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	YellowLine:setShaderVector(0, 0, 0, 0, 0)
	YellowLine:setupNineSliceShader(3, 60)
	self:addElement(YellowLine)
	self.YellowLine = YellowLine
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARRewardBacker_ZM.__resetProperties = function(f2_arg0)
	f2_arg0.CroppedZmBacking2:completeAnimation()
	f2_arg0.BotPatterRight:completeAnimation()
	f2_arg0.BotPatterLeft:completeAnimation()
	f2_arg0.CroppedZmBacking2:setAlpha(0.5)
	f2_arg0.BotPatterRight:setShaderVector(0, 1, 0, 0, 0)
	f2_arg0.BotPatterLeft:setShaderVector(0, 1, 0, 0, 0)
end
CoD.AARRewardBacker_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(5000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f5_arg0:setAlpha(0.5)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.CroppedZmBacking2:beginAnimation(5000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.CroppedZmBacking2:setAlpha(1)
				f3_arg0.CroppedZmBacking2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.CroppedZmBacking2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.CroppedZmBacking2:completeAnimation()
			f3_arg0.CroppedZmBacking2:setAlpha(0.5)
			f3_local0(f3_arg0.CroppedZmBacking2)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(5000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f7_arg0:setShaderVector(0, 1, 0, 0, 0)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.BotPatterLeft:beginAnimation(5000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.BotPatterLeft:setShaderVector(0, 0.5, 0, 0, 0)
				f3_arg0.BotPatterLeft:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BotPatterLeft:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.BotPatterLeft:completeAnimation()
			f3_arg0.BotPatterLeft:setShaderVector(0, 1, 0, 0, 0)
			f3_local1(f3_arg0.BotPatterLeft)
			local f3_local2 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(5000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f9_arg0:setShaderVector(0, 1, 0, 0, 0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.BotPatterRight:beginAnimation(5000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.BotPatterRight:setShaderVector(0, 0.5, 0, 0, 0)
				f3_arg0.BotPatterRight:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BotPatterRight:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.BotPatterRight:completeAnimation()
			f3_arg0.BotPatterRight:setShaderVector(0, 1, 0, 0, 0)
			f3_local2(f3_arg0.BotPatterRight)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
