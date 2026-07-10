CoD.TabletLocationSelector_PointMarker = InheritFrom(LUI.UIElement)
CoD.TabletLocationSelector_PointMarker.__defaultWidth = 50
CoD.TabletLocationSelector_PointMarker.__defaultHeight = 50
CoD.TabletLocationSelector_PointMarker.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabletLocationSelector_PointMarker)
	self.id = "TabletLocationSelector_PointMarker"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IconFrame = LUI.UIImage.new(0.74, 0.74, -44, 20, 0.76, 0.76, -44, 20)
	IconFrame:setAlpha(0)
	IconFrame:setImage(RegisterImage(0x87A7AC36F9F587F))
	self:addElement(IconFrame)
	self.IconFrame = IconFrame
	local Icon = LUI.UIImage.new(0, 0, -7, 57, -0.04, -0.04, -4, 60)
	Icon:setImage(RegisterImage(0x1DD23044C39232D))
	self:addElement(Icon)
	self.Icon = Icon
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletLocationSelector_PointMarker.__resetProperties = function(f2_arg0)
	f2_arg0.IconFrame:completeAnimation()
	f2_arg0.Icon:completeAnimation()
	f2_arg0.IconFrame:setRGB(1, 1, 1)
	f2_arg0.IconFrame:setAlpha(0)
	f2_arg0.IconFrame:setScale(1, 1)
	f2_arg0.Icon:setRGB(1, 1, 1)
end
CoD.TabletLocationSelector_PointMarker.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(710)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(709)
					f5_arg0:setAlpha(0)
					f5_arg0:setScale(1.74, 1.74)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.IconFrame:beginAnimation(470)
				f3_arg0.IconFrame:setScale(1.29, 1.29)
				f3_arg0.IconFrame:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.IconFrame:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.IconFrame:completeAnimation()
			f3_arg0.IconFrame:setRGB(1, 1, 1)
			f3_arg0.IconFrame:setAlpha(1)
			f3_arg0.IconFrame:setScale(1, 1)
			f3_local0(f3_arg0.IconFrame)
			f3_arg0.nextClip = "DefaultClip"
		end,
		Focus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						f10_arg0:beginAnimation(710)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f9_arg0:beginAnimation(709)
					f9_arg0:setAlpha(0)
					f9_arg0:setScale(1.74, 1.74)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f7_arg0.IconFrame:beginAnimation(470)
				f7_arg0.IconFrame:setScale(1.29, 1.29)
				f7_arg0.IconFrame:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.IconFrame:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.IconFrame:completeAnimation()
			f7_arg0.IconFrame:setRGB(1, 0.82, 0)
			f7_arg0.IconFrame:setAlpha(1)
			f7_arg0.IconFrame:setScale(1, 1)
			f7_local0(f7_arg0.IconFrame)
			f7_arg0.Icon:completeAnimation()
			f7_arg0.Icon:setRGB(1, 0.82, 0)
			f7_arg0.clipFinished(f7_arg0.Icon)
			f7_arg0.nextClip = "Focus"
		end,
	},
}
