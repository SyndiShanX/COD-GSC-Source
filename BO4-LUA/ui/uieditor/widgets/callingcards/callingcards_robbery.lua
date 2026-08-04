require("ui/uieditor/widgets/callingcards/loot3/ui_icon_callingcards_robber_laser")
CoD.callingcards_robbery = InheritFrom(LUI.UIElement)
CoD.callingcards_robbery.__defaultWidth = 960
CoD.callingcards_robbery.__defaultHeight = 240
CoD.callingcards_robbery.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_robbery)
	self.id = "CallingCards_Robbery"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	background:setImage(RegisterImage("uie_ui_menu_callingcards_robbery_bg"))
	self:addElement(background)
	self.background = background
	local Robber = LUI.UIImage.new(0, 0, 219, 947, 0, 0, -32, 232)
	Robber:setImage(RegisterImage("uie_ui_menu_callingcards_robbery_hero"))
	self:addElement(Robber)
	self.Robber = Robber
	local Diamond = LUI.UIImage.new(0, 0, 219, 563, 0, 0, 39, 263)
	Diamond:setImage(RegisterImage("uie_ui_menu_callingcards_robbery_jewel"))
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
CoD.callingcards_robbery.__resetProperties = function(f2_arg0)
	f2_arg0.uiiconcallingcardsrobberlaser:completeAnimation()
	f2_arg0.Robber:completeAnimation()
	f2_arg0.Robber:setTopBottom(0, 0, -32, 232)
	f2_arg0.Robber:setZRot(0)
end
CoD.callingcards_robbery.__clipsPerState = {
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
					f5_arg0:beginAnimation(500, Enum[@"luitween"][@"luitween_back"] | Enum[@"luitween"][@"luitween_ease_both"])
					f5_arg0:setTopBottom(0, 0, -82, 182)
					f5_arg0:setZRot(-3)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.Robber:beginAnimation(1400, Enum[@"luitween"][@"luitween_ease_out"])
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
CoD.callingcards_robbery.__onClose = function(f7_arg0)
	f7_arg0.uiiconcallingcardsrobberlaser:close()
end
