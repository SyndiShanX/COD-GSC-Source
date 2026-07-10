CoD.CallingCards_replacer_cars1 = InheritFrom(LUI.UIElement)
CoD.CallingCards_replacer_cars1.__defaultWidth = 960
CoD.CallingCards_replacer_cars1.__defaultHeight = 240
CoD.CallingCards_replacer_cars1.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_replacer_cars1)
	self.id = "CallingCards_replacer_cars1"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local cars1 = LUI.UIImage.new(0, 0, 0, 4416, 0, 0, 0, 296)
	cars1:setImage(RegisterImage(0x1E029BD169645F7))
	self:addElement(cars1)
	self.cars1 = cars1
	local cars2 = LUI.UIImage.new(0, 0, 4416, 8832, 0, 0, 0, 296)
	cars2:setImage(RegisterImage(0x1E029BD169645F7))
	self:addElement(cars2)
	self.cars2 = cars2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_replacer_cars1.__resetProperties = function(f2_arg0)
	f2_arg0.cars1:completeAnimation()
	f2_arg0.cars2:completeAnimation()
	f2_arg0.cars1:setLeftRight(0, 0, 0, 4416)
	f2_arg0.cars2:setLeftRight(0, 0, 4416, 8832)
end
CoD.CallingCards_replacer_cars1.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				f3_arg0.cars1:beginAnimation(3000)
				f3_arg0.cars1:setLeftRight(0, 0, -4416, 0)
				f3_arg0.cars1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cars1:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.cars1:completeAnimation()
			f3_arg0.cars1:setLeftRight(0, 0, 0, 4416)
			f3_local0(f3_arg0.cars1)
			local f3_local1 = function(f5_arg0)
				f3_arg0.cars2:beginAnimation(3000)
				f3_arg0.cars2:setLeftRight(0, 0, 0, 4416)
				f3_arg0.cars2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cars2:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.cars2:completeAnimation()
			f3_arg0.cars2:setLeftRight(0, 0, 4498, 8914)
			f3_local1(f3_arg0.cars2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
