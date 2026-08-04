require("ui/uieditor/widgets/callingcards/loot3/ui_icon_callingcards_invasion_lamb1")
require("ui/uieditor/widgets/callingcards/loot3/ui_icon_callingcards_invasion_lamb2")
require("ui/uieditor/widgets/callingcards/loot3/ui_icon_callingcards_invasion_ufo")
CoD.callingcards_invasion = InheritFrom(LUI.UIElement)
CoD.callingcards_invasion.__defaultWidth = 960
CoD.callingcards_invasion.__defaultHeight = 240
CoD.callingcards_invasion.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.callingcards_invasion)
	self.id = "CallingCards_invasion"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	Background:setImage(RegisterImage("uie_ui_menu_callingcards_invasion_bg"))
	self:addElement(Background)
	self.Background = Background
	local ufo = CoD.ui_icon_callingcards_invasion_ufo.new(f1_arg0, f1_arg1, 0, 0, 596, 820, 0, 0, 4, 92)
	self:addElement(ufo)
	self.ufo = ufo
	local Mailbox = LUI.UIImage.new(0, 0, 733.5, 805.5, 0, 0, 106, 250)
	Mailbox:setImage(RegisterImage("uie_ui_menu_callingcards_invasion_mailbox"))
	self:addElement(Mailbox)
	self.Mailbox = Mailbox
	local lamb1 = CoD.ui_icon_callingcards_invasion_lamb1.new(f1_arg0, f1_arg1, 0, 0, 810.5, 922.5, 0, 0, -22, 90)
	self:addElement(lamb1)
	self.lamb1 = lamb1
	local lamb2 = CoD.ui_icon_callingcards_invasion_lamb2.new(f1_arg0, f1_arg1, 0, 0, 509.5, 621.5, 0, 0, 15, 127)
	self:addElement(lamb2)
	self.lamb2 = lamb2
	local noisenoanim = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	noisenoanim:setImage(RegisterImage("uie_ui_menu_callingcards_invasion_noise"))
	self:addElement(noisenoanim)
	self.noisenoanim = noisenoanim
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.callingcards_invasion.__resetProperties = function(f2_arg0)
	f2_arg0.ufo:completeAnimation()
	f2_arg0.lamb1:completeAnimation()
	f2_arg0.lamb2:completeAnimation()
	f2_arg0.ufo:setTopBottom(0, 0, 4, 92)
	f2_arg0.lamb1:setTopBottom(0, 0, -22, 90)
	f2_arg0.lamb2:setTopBottom(0, 0, 15, 127)
end
CoD.callingcards_invasion.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(3)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					f5_arg0:beginAnimation(1500)
					f5_arg0:setTopBottom(0, 0, 4, 92)
					f5_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.ufo:playClip("DefaultClip")
				f3_arg0.ufo:beginAnimation(1500)
				f3_arg0.ufo:setTopBottom(0, 0, 30, 118)
				f3_arg0.ufo:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.ufo:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.ufo:completeAnimation()
			f3_arg0.ufo:setTopBottom(0, 0, 4, 92)
			f3_local0(f3_arg0.ufo)
			local f3_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_out"])
					f8_arg0:setTopBottom(0, 0, -50, 62)
					f8_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.lamb1:playClip("DefaultClip")
				f3_arg0.lamb1:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.lamb1:setTopBottom(0, 0, 3, 115)
				f3_arg0.lamb1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lamb1:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.lamb1:completeAnimation()
			f3_arg0.lamb1:setTopBottom(0, 0, -50, 62)
			f3_local1(f3_arg0.lamb1)
			local f3_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_both"])
					f11_arg0:setTopBottom(0, 0, 45, 157)
					f11_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.lamb2:playClip("DefaultClip")
				f3_arg0.lamb2:beginAnimation(1500, Enum[@"luitween"][@"luitween_ease_in"])
				f3_arg0.lamb2:setTopBottom(0, 0, 15, 127)
				f3_arg0.lamb2:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lamb2:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f3_arg0.lamb2:completeAnimation()
			f3_arg0.lamb2:setTopBottom(0, 0, 45, 157)
			f3_local2(f3_arg0.lamb2)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.callingcards_invasion.__onClose = function(f13_arg0)
	f13_arg0.ufo:close()
	f13_arg0.lamb1:close()
	f13_arg0.lamb2:close()
end
