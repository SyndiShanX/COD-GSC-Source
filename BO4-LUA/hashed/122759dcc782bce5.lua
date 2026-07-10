CoD.IcePickHackFeedBg = InheritFrom(LUI.UIElement)
CoD.IcePickHackFeedBg.__defaultWidth = 308
CoD.IcePickHackFeedBg.__defaultHeight = 344
CoD.IcePickHackFeedBg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.IcePickHackFeedBg)
	self.id = "IcePickHackFeedBg"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BG = LUI.UIImage.new(0, 0, 0, 308, 0, 0, 0, 344)
	BG:setRGB(0.02, 0.08, 0.12)
	self:addElement(BG)
	self.BG = BG
	local BgGrad = LUI.UIImage.new(0, 0, 0, 308, 0, 0, 0, 344)
	BgGrad:setAlpha(0.3)
	BgGrad:setImage(RegisterImage(0xF92F0E135E1791D))
	self:addElement(BgGrad)
	self.BgGrad = BgGrad
	local PixelGridTiledBacking = LUI.UIImage.new(0, 0, 0, 308, 0, 0, 0, 344)
	PixelGridTiledBacking:setAlpha(0.1)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(256, 256)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local CenterFractal02 = LUI.UIImage.new(0, 0, -324, 308, 0, 0, -163, 140)
	CenterFractal02:setAlpha(0.2)
	CenterFractal02:setImage(RegisterImage(0x86F55135B83852))
	CenterFractal02:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	CenterFractal02:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(CenterFractal02)
	self.CenterFractal02 = CenterFractal02
	local GridLine = LUI.UIImage.new(0, 0, -24, 308, 0, 0, 0, 344)
	GridLine:setAlpha(0.5)
	GridLine:setImage(RegisterImage(0xF7700E135C91995))
	GridLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	GridLine:setShaderVector(0, 0, 0, 0, 0)
	GridLine:setupNineSliceShader(144, 144)
	self:addElement(GridLine)
	self.GridLine = GridLine
	local GridLineAdd = LUI.UIImage.new(0, 0, -24, 308, 0, 0, 0, 344)
	GridLineAdd:setAlpha(0.5)
	GridLineAdd:setImage(RegisterImage(0xF7700E135C91995))
	GridLineAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	GridLineAdd:setShaderVector(0, 0, 0, 0, 0)
	GridLineAdd:setupNineSliceShader(144, 144)
	self:addElement(GridLineAdd)
	self.GridLineAdd = GridLineAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.IcePickHackFeedBg.__resetProperties = function(f2_arg0)
	f2_arg0.GridLineAdd:completeAnimation()
	f2_arg0.GridLine:completeAnimation()
	f2_arg0.GridLineAdd:setAlpha(0.5)
	f2_arg0.GridLine:setAlpha(0.5)
end
CoD.IcePickHackFeedBg.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.GridLine:completeAnimation()
			f3_arg0.GridLine:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.GridLine)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(500)
						f6_arg0:setAlpha(0.5)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f5_arg0:setAlpha(0.7)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.GridLineAdd:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.GridLineAdd:setAlpha(1)
				f3_arg0.GridLineAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.GridLineAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.GridLineAdd:completeAnimation()
			f3_arg0.GridLineAdd:setAlpha(0.7)
			f3_local0(f3_arg0.GridLineAdd)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
