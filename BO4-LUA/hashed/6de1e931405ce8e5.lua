CoD.HealthBoostNotification = InheritFrom(LUI.UIElement)
CoD.HealthBoostNotification.__defaultWidth = 64
CoD.HealthBoostNotification.__defaultHeight = 26
CoD.HealthBoostNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthBoostNotification)
	self.id = "HealthBoostNotification"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Text = LUI.UIText.new(0, 0, 0, 64, 0, 0, 0, 26)
	Text:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
	Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6A0F614541A9DE14"))
	Text:setTTF("0arame_mono_stencil")
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(Text)
	self.Text = Text
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HealthBoostNotification.__resetProperties = function(f2_arg0)
	f2_arg0.Text:completeAnimation()
	f2_arg0.Text:setTopBottom(0, 0, 0, 26)
	f2_arg0.Text:setAlpha(1)
end
CoD.HealthBoostNotification.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(199)
						f6_arg0:setTopBottom(0, 0, -52, -26)
						f6_arg0:setAlpha(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(500)
					f5_arg0:setTopBottom(0, 0, -41.6, -15.6)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.Text:beginAnimation(300)
				f3_arg0.Text:setTopBottom(0, 0, -15.6, 10.4)
				f3_arg0.Text:setAlpha(1)
				f3_arg0.Text:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Text:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Text:completeAnimation()
			f3_arg0.Text:setTopBottom(0, 0, 0, 26)
			f3_arg0.Text:setAlpha(0)
			f3_local0(f3_arg0.Text)
		end,
	},
}
