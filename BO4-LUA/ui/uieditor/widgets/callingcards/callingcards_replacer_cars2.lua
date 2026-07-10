CoD.CallingCards_replacer_cars2 = InheritFrom(LUI.UIElement)
CoD.CallingCards_replacer_cars2.__defaultWidth = 960
CoD.CallingCards_replacer_cars2.__defaultHeight = 240
CoD.CallingCards_replacer_cars2.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_replacer_cars2)
	self.id = "CallingCards_replacer_cars2"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local cars2 = LUI.UIImage.new(0, 0, 0, 5792, 0, 0, -50, 334)
	cars2:setImage(RegisterImage(@"hash_11E02ABD169647AA"))
	self:addElement(cars2)
	self.cars2 = cars2
	local Image2 = LUI.UIImage.new(0, 0, 5792, 11584, 0, 0, -50, 334)
	Image2:setImage(RegisterImage(@"hash_11E02ABD169647AA"))
	self:addElement(Image2)
	self.Image2 = Image2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_replacer_cars2.__resetProperties = function(f2_arg0)
	f2_arg0.cars2:completeAnimation()
	f2_arg0.Image2:completeAnimation()
	f2_arg0.cars2:setLeftRight(0, 0, 0, 5792)
	f2_arg0.Image2:setLeftRight(0, 0, 5792, 11584)
end
CoD.CallingCards_replacer_cars2.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				f3_arg0.cars2:beginAnimation(6000)
				f3_arg0.cars2:setLeftRight(0, 0, -5792, 0)
				f3_arg0.cars2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cars2:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.cars2:completeAnimation()
			f3_arg0.cars2:setLeftRight(0, 0, 0, 5792)
			f3_local0(f3_arg0.cars2)
			local f3_local1 = function(f5_arg0)
				f3_arg0.Image2:beginAnimation(6000)
				f3_arg0.Image2:setLeftRight(0, 0, 0, 5792)
				f3_arg0.Image2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image2:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Image2:completeAnimation()
			f3_arg0.Image2:setLeftRight(0, 0, 5792, 11584)
			f3_local1(f3_arg0.Image2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
