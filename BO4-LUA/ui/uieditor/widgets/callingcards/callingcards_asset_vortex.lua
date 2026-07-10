CoD.CallingCards_Asset_vortex = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_vortex.__defaultWidth = 512
CoD.CallingCards_Asset_vortex.__defaultHeight = 512
CoD.CallingCards_Asset_vortex.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_vortex)
	self.id = "CallingCards_Asset_vortex"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vortex = LUI.UIImage.new(0, 0, 0, 512, 0, 0, 0, 512)
	vortex:setImage(RegisterImage(@"uie_vortex"))
	vortex:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(vortex)
	self.vortex = vortex
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_vortex.__resetProperties = function(f2_arg0)
	f2_arg0.vortex:completeAnimation()
	f2_arg0.vortex:setZRot(0)
end
CoD.CallingCards_Asset_vortex.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(1000)
							f7_arg0:setZRot(360)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(1000)
						f6_arg0:setZRot(270)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(1000)
					f5_arg0:setZRot(180)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.vortex:beginAnimation(1000)
				f3_arg0.vortex:setZRot(90)
				f3_arg0.vortex:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.vortex:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.vortex:completeAnimation()
			f3_arg0.vortex:setZRot(0)
			f3_local0(f3_arg0.vortex)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
