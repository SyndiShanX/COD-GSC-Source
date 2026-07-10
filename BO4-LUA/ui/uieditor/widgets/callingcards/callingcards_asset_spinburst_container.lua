CoD.CallingCards_Asset_spinburst_container = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_spinburst_container.__defaultWidth = 826
CoD.CallingCards_Asset_spinburst_container.__defaultHeight = 826
CoD.CallingCards_Asset_spinburst_container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_spinburst_container)
	self.id = "CallingCards_Asset_spinburst_container"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LightSpin = LUI.UIImage.new(0, 0, 0, 826, 0, 0, 0, 826)
	LightSpin:setImage(RegisterImage(0xCDE878DE89C8808))
	LightSpin:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(LightSpin)
	self.LightSpin = LightSpin
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_spinburst_container.__resetProperties = function(f2_arg0)
	f2_arg0.LightSpin:completeAnimation()
	f2_arg0.LightSpin:setZRot(0)
end
CoD.CallingCards_Asset_spinburst_container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(1000)
						f6_arg0:setZRot(376)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(1000)
					f5_arg0:setZRot(270)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.LightSpin:beginAnimation(1000)
				f3_arg0.LightSpin:setZRot(180)
				f3_arg0.LightSpin:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.LightSpin:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.LightSpin:completeAnimation()
			f3_arg0.LightSpin:setZRot(90)
			f3_local0(f3_arg0.LightSpin)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
