CoD.Tak5ReticleBracketRuler = InheritFrom(LUI.UIElement)
CoD.Tak5ReticleBracketRuler.__defaultWidth = 362
CoD.Tak5ReticleBracketRuler.__defaultHeight = 18
CoD.Tak5ReticleBracketRuler.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Tak5ReticleBracketRuler)
	self.id = "Tak5ReticleBracketRuler"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ReticleBotRuler = LUI.UIImage.new(0, 0, 0, 362, 0, 0, 0, 18)
	ReticleBotRuler:setImage(RegisterImage(0xEFFFC10064131AD))
	self:addElement(ReticleBotRuler)
	self.ReticleBotRuler = ReticleBotRuler
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Tak5ReticleBracketRuler.__resetProperties = function(f2_arg0)
	f2_arg0.ReticleBotRuler:completeAnimation()
	f2_arg0.ReticleBotRuler:setTopBottom(0, 0, 0, 18)
end
CoD.Tak5ReticleBracketRuler.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(100)
					f5_arg0:setTopBottom(0, 0, 0, 18)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
				end
				f3_arg0.ReticleBotRuler:beginAnimation(200)
				f3_arg0.ReticleBotRuler:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ReticleBotRuler:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ReticleBotRuler:completeAnimation()
			f3_arg0.ReticleBotRuler:setTopBottom(0, 0, 18, 18)
			f3_local0(f3_arg0.ReticleBotRuler)
		end,
	},
}
