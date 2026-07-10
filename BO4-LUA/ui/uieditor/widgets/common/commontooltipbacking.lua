CoD.CommonToolTipBacking = InheritFrom(LUI.UIElement)
CoD.CommonToolTipBacking.__defaultWidth = 150
CoD.CommonToolTipBacking.__defaultHeight = 33
CoD.CommonToolTipBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonToolTipBacking)
	self.id = "CommonToolTipBacking"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Bg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Bg:setRGB(0, 0, 0)
	Bg:setAlpha(0.98)
	self:addElement(Bg)
	self.Bg = Bg
	local TiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TiledBacking:setAlpha(0.7)
	TiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	TiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	TiledBacking:setShaderVector(0, 0, 0, 0, 0)
	TiledBacking:setupNineSliceShader(196, 88)
	self:addElement(TiledBacking)
	self.TiledBacking = TiledBacking
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrameBorder:setAlpha(0.2)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setupNineSliceShader(4, 4)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local Arrow = LUI.UIImage.new(0.5, 0.5, -7, 7, 0, 0, -24, 4)
	Arrow:setZRot(-90)
	Arrow:setImage(RegisterImage(0x91C23A1DFE18E55))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local ArrowAdd = LUI.UIImage.new(0.5, 0.5, -7, 7, 0, 0, -24, 4)
	ArrowAdd:setAlpha(0)
	ArrowAdd:setZRot(-90)
	ArrowAdd:setImage(RegisterImage(0x91C23A1DFE18E55))
	ArrowAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ArrowAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(ArrowAdd)
	self.ArrowAdd = ArrowAdd
	local Botline = LUI.UIImage.new(0, 1, -4, 4, 1, 1, -3, 7)
	Botline:setImage(RegisterImage(0xC752149A1FA1AAE))
	Botline:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	Botline:setShaderVector(0, 0, 0, 0, 0)
	Botline:setupNineSliceShader(60, 10)
	self:addElement(Botline)
	self.Botline = Botline
	local TopLine = LUI.UIImage.new(0, 1, -4, 4, 0, 0, -4, 6)
	TopLine:setImage(RegisterImage(0xC752149A1FA1AAE))
	TopLine:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	TopLine:setShaderVector(0, 0, 0, 0, 0)
	TopLine:setupNineSliceShader(60, 10)
	self:addElement(TopLine)
	self.TopLine = TopLine
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonToolTipBacking.__resetProperties = function(f2_arg0)
	f2_arg0.ArrowAdd:completeAnimation()
	f2_arg0.Arrow:completeAnimation()
	f2_arg0.ArrowAdd:setAlpha(0)
	f2_arg0.Arrow:setTopBottom(0, 0, -24, 4)
	f2_arg0.Arrow:setAlpha(1)
end
CoD.CommonToolTipBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f5_arg0:setTopBottom(0, 0, -24, 4)
					f5_arg0:setAlpha(1)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Arrow:beginAnimation(200)
				f3_arg0.Arrow:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Arrow:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Arrow:completeAnimation()
			f3_arg0.Arrow:setTopBottom(0, 0, -14, 14)
			f3_arg0.Arrow:setAlpha(0)
			f3_local0(f3_arg0.Arrow)
			local f3_local1 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						local f8_local0 = function(f9_arg0)
							f9_arg0:beginAnimation(120)
							f9_arg0:setAlpha(0)
							f9_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f8_arg0:beginAnimation(279)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
					end
					f7_arg0:beginAnimation(120)
					f7_arg0:setAlpha(1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f3_arg0.ArrowAdd:beginAnimation(380)
				f3_arg0.ArrowAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ArrowAdd:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f3_arg0.ArrowAdd:completeAnimation()
			f3_arg0.ArrowAdd:setAlpha(0)
			f3_local1(f3_arg0.ArrowAdd)
		end,
	},
}
