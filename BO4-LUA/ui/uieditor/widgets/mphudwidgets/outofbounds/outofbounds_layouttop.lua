CoD.outofbounds_layoutTop = InheritFrom(LUI.UIElement)
CoD.outofbounds_layoutTop.__defaultWidth = 700
CoD.outofbounds_layoutTop.__defaultHeight = 16
CoD.outofbounds_layoutTop.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.outofbounds_layoutTop)
	self.id = "outofbounds_layoutTop"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LayoutElementTop2 = LUI.UIImage.new(0, 0, 0, 700, 0, 0, 2, 18)
	LayoutElementTop2:setAlpha(0.15)
	LayoutElementTop2:setZoom(-10)
	LayoutElementTop2:setImage(RegisterImage(0x9C016F17656D4BC))
	self:addElement(LayoutElementTop2)
	self.LayoutElementTop2 = LayoutElementTop2
	local LayoutElementTop = LUI.UIImage.new(0, 0, 0, 700, 0, 0, 0, 16)
	LayoutElementTop:setAlpha(0.3)
	LayoutElementTop:setImage(RegisterImage(0x9C016F17656D4BC))
	self:addElement(LayoutElementTop)
	self.LayoutElementTop = LayoutElementTop
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.outofbounds_layoutTop.__resetProperties = function(f2_arg0)
	f2_arg0.LayoutElementTop2:completeAnimation()
	f2_arg0.LayoutElementTop2:setZoom(-10)
	f2_arg0.LayoutElementTop2:setImage(RegisterImage(0x9C016F17656D4BC))
end
CoD.outofbounds_layoutTop.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(300)
					f5_arg0:setZoom(-10)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.LayoutElementTop2:beginAnimation(700, Enum[0xF50FFF429AB1890][0x5D2D9CF90AB1735] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f3_arg0.LayoutElementTop2:setZoom(30)
				f3_arg0.LayoutElementTop2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.LayoutElementTop2:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.LayoutElementTop2:completeAnimation()
			f3_arg0.LayoutElementTop2:setZoom(-10)
			f3_arg0.LayoutElementTop2:setImage(RegisterImage(0x9C016F17656D4BC))
			f3_local0(f3_arg0.LayoutElementTop2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
	IsOutOfBounds = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
