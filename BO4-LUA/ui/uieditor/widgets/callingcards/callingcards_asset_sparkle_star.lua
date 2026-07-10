CoD.CallingCards_Asset_sparkle_star = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_sparkle_star.__defaultWidth = 128
CoD.CallingCards_Asset_sparkle_star.__defaultHeight = 128
CoD.CallingCards_Asset_sparkle_star.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_sparkle_star)
	self.id = "CallingCards_Asset_sparkle_star"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 128)
	Image:setImage(RegisterImage(0x7BB021BF254904C))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_sparkle_star.__resetProperties = function(f2_arg0)
	f2_arg0.Image:completeAnimation()
	f2_arg0.Image:setAlpha(1)
	f2_arg0.Image:setZRot(0)
	f2_arg0.Image:setScale(1, 1)
end
CoD.CallingCards_Asset_sparkle_star.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(520)
					f5_arg0:setAlpha(0)
					f5_arg0:setZRot(270)
					f5_arg0:setScale(0.75, 0.75)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.Image:beginAnimation(480)
				f3_arg0.Image:setAlpha(1)
				f3_arg0.Image:setZRot(180)
				f3_arg0.Image:setScale(1, 1)
				f3_arg0.Image:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Image:completeAnimation()
			f3_arg0.Image:setAlpha(0)
			f3_arg0.Image:setZRot(90)
			f3_arg0.Image:setScale(0.75, 0.75)
			f3_local0(f3_arg0.Image)
		end,
	},
}
