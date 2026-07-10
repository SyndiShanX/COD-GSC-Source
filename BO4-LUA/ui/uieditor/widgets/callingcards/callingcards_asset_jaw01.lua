CoD.CallingCards_Asset_jaw01 = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_jaw01.__defaultWidth = 51
CoD.CallingCards_Asset_jaw01.__defaultHeight = 51
CoD.CallingCards_Asset_jaw01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_jaw01)
	self.id = "CallingCards_Asset_jaw01"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local jaw01 = LUI.UIImage.new(0, 0, 0, 51, 0, 0, 0, 51)
	jaw01:setImage(RegisterImage(0xE48D7462D171B3B))
	self:addElement(jaw01)
	self.jaw01 = jaw01
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_jaw01.__resetProperties = function(f2_arg0)
	f2_arg0.jaw01:completeAnimation()
	f2_arg0.jaw01:setTopBottom(0, 0, 0, 51)
end
CoD.CallingCards_Asset_jaw01.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(109)
					f5_arg0:setTopBottom(0, 0, 0, 51)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.jaw01:beginAnimation(100)
				f3_arg0.jaw01:setTopBottom(0, 0, -2, 49)
				f3_arg0.jaw01:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.jaw01:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.jaw01:completeAnimation()
			f3_arg0.jaw01:setTopBottom(0, 0, 0, 51)
			f3_local0(f3_arg0.jaw01)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
