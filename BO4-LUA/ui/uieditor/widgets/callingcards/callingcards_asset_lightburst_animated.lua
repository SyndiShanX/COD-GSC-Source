CoD.CallingCards_Asset_lightburst_animated = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_lightburst_animated.__defaultWidth = 608
CoD.CallingCards_Asset_lightburst_animated.__defaultHeight = 608
CoD.CallingCards_Asset_lightburst_animated.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_lightburst_animated)
	self.id = "CallingCards_Asset_lightburst_animated"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local sunburst = LUI.UIImage.new(0, 0, 0, 608, 0, 0, 0, 608)
	sunburst:setImage(RegisterImage(0xAF47B452F4E631B))
	sunburst:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	sunburst:setShaderVector(0, 2.74, 0, 0, 0)
	self:addElement(sunburst)
	self.sunburst = sunburst
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_lightburst_animated.__resetProperties = function(f2_arg0)
	f2_arg0.sunburst:completeAnimation()
	f2_arg0.sunburst:setZRot(0)
end
CoD.CallingCards_Asset_lightburst_animated.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(500)
							f7_arg0:setZRot(-360)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(490)
						f6_arg0:setZRot(-270)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(500)
					f5_arg0:setZRot(-180)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.sunburst:beginAnimation(510)
				f3_arg0.sunburst:setZRot(-90)
				f3_arg0.sunburst:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.sunburst:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.sunburst:completeAnimation()
			f3_arg0.sunburst:setZRot(0)
			f3_local0(f3_arg0.sunburst)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
