CoD.CallingCards_Asset_black_hole = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_black_hole.__defaultWidth = 435
CoD.CallingCards_Asset_black_hole.__defaultHeight = 435
CoD.CallingCards_Asset_black_hole.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_black_hole)
	self.id = "CallingCards_Asset_black_hole"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blackhole = LUI.UIImage.new(0, 0, 0, 435, 0, 0, 0, 435)
	blackhole:setZRot(-220)
	blackhole:setImage(RegisterImage(@"uie_ui_icon_callingcard_zombie_hunter_blackhole"))
	blackhole:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(blackhole)
	self.blackhole = blackhole
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_black_hole.__resetProperties = function(f2_arg0)
	f2_arg0.blackhole:completeAnimation()
	f2_arg0.blackhole:setZRot(-220)
end
CoD.CallingCards_Asset_black_hole.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(2010)
							f7_arg0:setZRot(-360)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(2010)
						f6_arg0:setZRot(-270)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(1990)
					f5_arg0:setZRot(-180)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.blackhole:beginAnimation(2000)
				f3_arg0.blackhole:setZRot(-90)
				f3_arg0.blackhole:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.blackhole:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.blackhole:completeAnimation()
			f3_arg0.blackhole:setZRot(0)
			f3_local0(f3_arg0.blackhole)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
