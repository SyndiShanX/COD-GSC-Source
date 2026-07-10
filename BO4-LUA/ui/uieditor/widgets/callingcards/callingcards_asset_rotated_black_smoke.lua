CoD.CallingCards_Asset_rotated_black_smoke = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_rotated_black_smoke.__defaultWidth = 256
CoD.CallingCards_Asset_rotated_black_smoke.__defaultHeight = 256
CoD.CallingCards_Asset_rotated_black_smoke.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_rotated_black_smoke)
	self.id = "CallingCards_Asset_rotated_black_smoke"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local smokeRotate = LUI.UIImage.new(0, 0, 0, 256, 0, 0, 0, 256)
	smokeRotate:setImage(RegisterImage(@"uie_callingcards_heroics_master_black_smokerotate"))
	self:addElement(smokeRotate)
	self.smokeRotate = smokeRotate
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_rotated_black_smoke.__resetProperties = function(f2_arg0)
	f2_arg0.smokeRotate:completeAnimation()
	f2_arg0.smokeRotate:setZRot(0)
end
CoD.CallingCards_Asset_rotated_black_smoke.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(760)
							f7_arg0:setZRot(360)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(830)
						f6_arg0:setZRot(270)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(820)
					f5_arg0:setZRot(180)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.smokeRotate:beginAnimation(590)
				f3_arg0.smokeRotate:setZRot(90)
				f3_arg0.smokeRotate:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.smokeRotate:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.smokeRotate:completeAnimation()
			f3_arg0.smokeRotate:setZRot(0)
			f3_local0(f3_arg0.smokeRotate)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
