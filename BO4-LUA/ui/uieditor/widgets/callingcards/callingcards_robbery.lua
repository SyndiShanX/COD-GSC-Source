require("x64:730a2fde3110a47")
CoD[0xC92A2CB5341FC62] = InheritFrom(LUI.UIElement)
CoD[0xC92A2CB5341FC62].__defaultWidth = 960
CoD[0xC92A2CB5341FC62].__defaultHeight = 240
CoD[0xC92A2CB5341FC62].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0xC92A2CB5341FC62])
	self.id = "CallingCards_Robbery"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage(0xFF789BBFBF58271))
	self:addElement(background)
	self.background = background
	local Robber = LUI.UIImage.new(0, 0, 219, 947, 0, 0, -32, 232)
	Robber:setImage(RegisterImage(0xE8B98C48D9B8956))
	self:addElement(Robber)
	self.Robber = Robber
	local Diamond = LUI.UIImage.new(0, 0, 219, 563, 0, 0, 39, 263)
	Diamond:setImage(RegisterImage(0xAFD1450994B7345))
	self:addElement(Diamond)
	self.Diamond = Diamond
	local uiiconcallingcardsrobberlaser = CoD.ui_icon_callingcards_robber_laser.new(f1_arg0, f1_arg1, 0, 0, 0, 960, 0, 0, 0, 240)
	self:addElement(uiiconcallingcardsrobberlaser)
	self.uiiconcallingcardsrobberlaser = uiiconcallingcardsrobberlaser
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0xC92A2CB5341FC62].__resetProperties = function(f2_arg0)
	f2_arg0.uiiconcallingcardsrobberlaser:completeAnimation()
	f2_arg0.Robber:completeAnimation()
	f2_arg0.Robber:setTopBottom(0, 0, -32, 232)
	f2_arg0.Robber:setZRot(0)
end
CoD[0xC92A2CB5341FC62].__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						f6_arg0:beginAnimation(1100)
						f6_arg0:setTopBottom(0, 0, -32, 232)
						f6_arg0:setZRot(0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
					end
					f5_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0xE99F3A6467FC0CA] | Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f5_arg0:setTopBottom(0, 0, -82, 182)
					f5_arg0:setZRot(-3)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.Robber:beginAnimation(1400, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f3_arg0.Robber:setTopBottom(0, 0, -106, 158)
				f3_arg0.Robber:setZRot(-3)
				f3_arg0.Robber:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.Robber:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.Robber:completeAnimation()
			f3_arg0.Robber:setTopBottom(0, 0, -32, 232)
			f3_arg0.Robber:setZRot(0)
			f3_local0(f3_arg0.Robber)
			f3_arg0.uiiconcallingcardsrobberlaser:completeAnimation()
			f3_arg0.uiiconcallingcardsrobberlaser:playClip("DefaultClip")
			f3_arg0.clipFinished(f3_arg0.uiiconcallingcardsrobberlaser)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD[0xC92A2CB5341FC62].__onClose = function(f7_arg0)
	f7_arg0.uiiconcallingcardsrobberlaser:close()
end
