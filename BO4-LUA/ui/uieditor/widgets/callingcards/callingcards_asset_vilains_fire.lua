CoD.CallingCards_Asset_vilains_fire = InheritFrom(LUI.UIElement)
CoD.CallingCards_Asset_vilains_fire.__defaultWidth = 960
CoD.CallingCards_Asset_vilains_fire.__defaultHeight = 168
CoD.CallingCards_Asset_vilains_fire.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CallingCards_Asset_vilains_fire)
	self.id = "CallingCards_Asset_vilains_fire"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local flames = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 168)
	flames:setImage(RegisterImage(0x1EE8A4C7B400DEF))
	self:addElement(flames)
	self.flames = flames
	local Image = LUI.UIImage.new(0, 0, 960, 1920, 0, 0, 0, 168)
	Image:setImage(RegisterImage(0x1EE8A4C7B400DEF))
	self:addElement(Image)
	self.Image = Image
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CallingCards_Asset_vilains_fire.__resetProperties = function(f2_arg0)
	f2_arg0.flames:completeAnimation()
	f2_arg0.Image:completeAnimation()
	f2_arg0.flames:setLeftRight(0, 0, 0, 960)
	f2_arg0.Image:setLeftRight(0, 0, 960, 1920)
end
CoD.CallingCards_Asset_vilains_fire.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				f3_arg0.flames:beginAnimation(3000)
				f3_arg0.flames:setLeftRight(0, 0, -960, 0)
				f3_arg0.flames:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.flames:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.flames:completeAnimation()
			f3_arg0.flames:setLeftRight(0, 0, 0, 960)
			f3_local0(f3_arg0.flames)
			local f3_local1 = function(f5_arg0)
				f3_arg0.Image:beginAnimation(3000)
				f3_arg0.Image:setLeftRight(0, 0, 0, 960)
				f3_arg0.Image:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Image:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.Image:completeAnimation()
			f3_arg0.Image:setLeftRight(0, 0, 960, 1920)
			f3_local1(f3_arg0.Image)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
