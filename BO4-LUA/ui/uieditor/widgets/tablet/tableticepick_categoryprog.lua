CoD.TabletIcePick_CategoryProg = InheritFrom(LUI.UIElement)
CoD.TabletIcePick_CategoryProg.__defaultWidth = 28
CoD.TabletIcePick_CategoryProg.__defaultHeight = 36
CoD.TabletIcePick_CategoryProg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletIcePick_CategoryProg)
	self.id = "TabletIcePick_CategoryProg"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ProgressBg = LUI.UIImage.new(0, 0, 2, 26, 0, 0, 6, 30)
	ProgressBg:setImage(RegisterImage(@"hash_53B6AB72F71A2482"))
	ProgressBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ProgressBg)
	self.ProgressBg = ProgressBg
	local ProgressBar = LUI.UIImage.new(0, 0, 3, 25, 0, 0, 0, 36)
	ProgressBar:setImage(RegisterImage(@"hash_59754459E15A67C6"))
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletIcePick_CategoryProg.__resetProperties = function(f2_arg0)
	f2_arg0.ProgressBar:completeAnimation()
	f2_arg0.ProgressBar:setAlpha(1)
	f2_arg0.ProgressBar:setZRot(0)
end
CoD.TabletIcePick_CategoryProg.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(199)
							f7_arg0:setAlpha(1)
							f7_arg0:setZRot(720)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(190)
						f6_arg0:setAlpha(0.4)
						f6_arg0:setZRot(540)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(210)
					f5_arg0:setAlpha(1)
					f5_arg0:setZRot(369)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.ProgressBar:beginAnimation(200)
				f3_arg0.ProgressBar:setAlpha(0.4)
				f3_arg0.ProgressBar:setZRot(180)
				f3_arg0.ProgressBar:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ProgressBar:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ProgressBar:completeAnimation()
			f3_arg0.ProgressBar:setAlpha(1)
			f3_arg0.ProgressBar:setZRot(0)
			f3_local0(f3_arg0.ProgressBar)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
