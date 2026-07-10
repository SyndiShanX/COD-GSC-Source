CoD.NineBangReticle_Pip = InheritFrom(LUI.UIElement)
CoD.NineBangReticle_Pip.__defaultWidth = 30
CoD.NineBangReticle_Pip.__defaultHeight = 10
CoD.NineBangReticle_Pip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.NineBangReticle_Pip)
	self.id = "NineBangReticle_Pip"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local piphighlight = LUI.UIImage.new(0, 0, -3, 33, 0, 0, -1, 11)
	piphighlight:setImage(RegisterImage(0x897BEC966B785BD))
	piphighlight:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(piphighlight)
	self.piphighlight = piphighlight
	local pipfill = LUI.UIImage.new(0, 0, -3, 33, 0, 0, -1, 11)
	pipfill:setImage(RegisterImage(0x9A69CDFF60EEDC6))
	self:addElement(pipfill)
	self.pipfill = pipfill
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.NineBangReticle_Pip.__resetProperties = function(f2_arg0)
	f2_arg0.pipfill:completeAnimation()
	f2_arg0.piphighlight:completeAnimation()
	f2_arg0.pipfill:setAlpha(1)
	f2_arg0.piphighlight:setAlpha(1)
end
CoD.NineBangReticle_Pip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			f3_arg0.piphighlight:completeAnimation()
			f3_arg0.piphighlight:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.piphighlight)
			f3_arg0.pipfill:completeAnimation()
			f3_arg0.pipfill:setAlpha(0)
			f3_arg0.clipFinished(f3_arg0.pipfill)
		end,
		Active = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				f4_arg0.piphighlight:beginAnimation(200)
				f4_arg0.piphighlight:setAlpha(1)
				f4_arg0.piphighlight:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.piphighlight:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.piphighlight:completeAnimation()
			f4_arg0.piphighlight:setAlpha(0)
			f4_local0(f4_arg0.piphighlight)
			local f4_local1 = function(f6_arg0)
				f4_arg0.pipfill:beginAnimation(200)
				f4_arg0.pipfill:setAlpha(1)
				f4_arg0.pipfill:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.pipfill:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.pipfill:completeAnimation()
			f4_arg0.pipfill:setAlpha(0)
			f4_local1(f4_arg0.pipfill)
		end,
	},
	Active = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
