CoD.CallingCards_Asset_jaw02 = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_jaw02.__defaultWidth = 69
CoD.CallingCards_Asset_jaw02.__defaultHeight = 69
CoD.CallingCards_Asset_jaw02.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_jaw02)
	self.id = "CallingCards_Asset_jaw02"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local jaw02 = LUI.UIImage.new(0, 0, 0, 69, 0, 0, 0, 69)
	jaw02:setImage(RegisterImage(0xE48D8462D171CEE))
	self:addElement(jaw02)
	self.jaw02 = jaw02
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_jaw02.__resetProperties = function(f2_arg0)
	f2_arg0.jaw02:completeAnimation()
	f2_arg0.jaw02:setTopBottom(0, 0, 0, 69)
end
CoD.CallingCards_Asset_jaw02.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(80)
					f5_arg0:setTopBottom(0, 0, 0, 69)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.jaw02:beginAnimation(90)
				f3_arg0.jaw02:setTopBottom(0, 0, -5, 64)
				f3_arg0.jaw02:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.jaw02:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.jaw02:completeAnimation()
			f3_arg0.jaw02:setTopBottom(0, 0, 0, 69)
			f3_local0(f3_arg0.jaw02)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
