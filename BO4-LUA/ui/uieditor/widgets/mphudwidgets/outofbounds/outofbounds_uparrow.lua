CoD.outofbounds_uparrow = InheritFrom(LUI.UIElement)
CoD.outofbounds_uparrow.__defaultWidth = 16
CoD.outofbounds_uparrow.__defaultHeight = 16
CoD.outofbounds_uparrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.outofbounds_uparrow)
	self.id = "outofbounds_uparrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local UpArrowSmall = LUI.UIImage.new(0, 0, 0, 16, 0, 0, 0, 16)
	UpArrowSmall:setImage(RegisterImage(0xDEAE7BFFAED8ACE))
	self:addElement(UpArrowSmall)
	self.UpArrowSmall = UpArrowSmall
	local UpArrowSmallAdd = LUI.UIImage.new(0, 0, 0, 16, 0, 0, 0, 16)
	UpArrowSmallAdd:setImage(RegisterImage(0xDEAE7BFFAED8ACE))
	UpArrowSmallAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	UpArrowSmallAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(UpArrowSmallAdd)
	self.UpArrowSmallAdd = UpArrowSmallAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.outofbounds_uparrow.__resetProperties = function(f2_arg0)
	f2_arg0.UpArrowSmallAdd:completeAnimation()
	f2_arg0.UpArrowSmallAdd:setAlpha(1)
	f2_arg0.UpArrowSmallAdd:setZoom(0)
end
CoD.outofbounds_uparrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(500)
					f5_arg0:setAlpha(0)
					f5_arg0:setZoom(0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.UpArrowSmallAdd:beginAnimation(500)
				f3_arg0.UpArrowSmallAdd:setAlpha(1)
				f3_arg0.UpArrowSmallAdd:setZoom(10)
				f3_arg0.UpArrowSmallAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.UpArrowSmallAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.UpArrowSmallAdd:completeAnimation()
			f3_arg0.UpArrowSmallAdd:setAlpha(0)
			f3_arg0.UpArrowSmallAdd:setZoom(0)
			f3_local0(f3_arg0.UpArrowSmallAdd)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
