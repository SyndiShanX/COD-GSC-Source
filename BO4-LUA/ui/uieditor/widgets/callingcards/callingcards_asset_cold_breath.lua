CoD.CallingCards_Asset_cold_breath = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_cold_breath.__defaultWidth = 128
CoD.CallingCards_Asset_cold_breath.__defaultHeight = 128
CoD.CallingCards_Asset_cold_breath.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_cold_breath)
	self.id = "CallingCards_Asset_cold_breath"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BreathSpot = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 128)
	BreathSpot:setImage(RegisterImage(@"uie_ui_icon_callingcards_wz_vehicular_master_cold_breath_spot"))
	BreathSpot:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(BreathSpot)
	self.BreathSpot = BreathSpot
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_cold_breath.__resetProperties = function(f2_arg0)
	f2_arg0.BreathSpot:completeAnimation()
	f2_arg0.BreathSpot:setAlpha(1)
	f2_arg0.BreathSpot:setZRot(0)
end
CoD.CallingCards_Asset_cold_breath.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(520)
							f7_arg0:setAlpha(0)
							f7_arg0:setZRot(-360)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(490)
						f6_arg0:setAlpha(0.26)
						f6_arg0:setZRot(-270)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(560)
					f5_arg0:setAlpha(0.5)
					f5_arg0:setZRot(-180)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.BreathSpot:beginAnimation(440)
				f3_arg0.BreathSpot:setAlpha(0.78)
				f3_arg0.BreathSpot:setZRot(-90)
				f3_arg0.BreathSpot:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.BreathSpot:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.BreathSpot:completeAnimation()
			f3_arg0.BreathSpot:setAlpha(1)
			f3_arg0.BreathSpot:setZRot(0)
			f3_local0(f3_arg0.BreathSpot)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
