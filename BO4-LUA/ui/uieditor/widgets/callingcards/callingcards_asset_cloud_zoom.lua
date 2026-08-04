CoD.CallingCards_Asset_cloud_zoom = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_cloud_zoom.__defaultWidth = 504
CoD.CallingCards_Asset_cloud_zoom.__defaultHeight = 504
CoD.CallingCards_Asset_cloud_zoom.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_cloud_zoom)
	self.id = "CallingCards_Asset_cloud_zoom"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local cloud1 = LUI.UIImage.new(0, 0, 0, 504, 0, 0, 0, 504)
	cloud1:setAlpha(0.37)
	cloud1:setScale(0.51, 0.51)
	cloud1:setImage(RegisterImage("uie_callingcards_survivalist_master_cloud1"))
	self:addElement(cloud1)
	self.cloud1 = cloud1
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_cloud_zoom.__resetProperties = function(f2_arg0)
	f2_arg0.cloud1:completeAnimation()
	f2_arg0.cloud1:setLeftRight(0, 0, 0, 504)
	f2_arg0.cloud1:setTopBottom(0, 0, 0, 504)
	f2_arg0.cloud1:setAlpha(0.37)
	f2_arg0.cloud1:setScale(0.51, 0.51)
end
CoD.CallingCards_Asset_cloud_zoom.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(339)
					f5_arg0:setLeftRight(0, 0, -24, 480)
					f5_arg0:setTopBottom(0, 0, 6.5, 510.5)
					f5_arg0:setAlpha(0)
					f5_arg0:setScale(2, 2)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.cloud1:beginAnimation(430)
				f3_arg0.cloud1:setLeftRight(0, 0, -8.1, 495.9)
				f3_arg0.cloud1:setTopBottom(0, 0, 2.08, 506.08)
				f3_arg0.cloud1:setAlpha(0.5)
				f3_arg0.cloud1:setScale(1.12, 1.12)
				f3_arg0.cloud1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.cloud1:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.cloud1:completeAnimation()
			f3_arg0.cloud1:setLeftRight(0, 0, 12, 516)
			f3_arg0.cloud1:setTopBottom(0, 0, -3.5, 500.5)
			f3_arg0.cloud1:setAlpha(0.2)
			f3_arg0.cloud1:setScale(0, 0)
			f3_local0(f3_arg0.cloud1)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
