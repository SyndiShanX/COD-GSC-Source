require("x64:f0300a2ab82b644")
require("x64:f0303a2ab82bb5d")
require("x64:c35bb16c18d983")
CoD[0x95CA2F50E1B4B18] = InheritFrom(LUI.UIElement)
CoD[0x95CA2F50E1B4B18].__defaultWidth = 960
CoD[0x95CA2F50E1B4B18].__defaultHeight = 240
CoD[0x95CA2F50E1B4B18].new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD[0x95CA2F50E1B4B18])
	self.id = "CallingCards_invasion"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	Background:setImage(RegisterImage(0x2F40575FD52645D))
	self:addElement(Background)
	self.Background = Background
	local ufo = CoD.ui_icon_callingcards_invasion_ufo.new(f1_arg0, f1_arg1, 0, 0, 596, 820, 0, 0, 4, 92)
	self:addElement(ufo)
	self.ufo = ufo
	local Mailbox = LUI.UIImage.new(0, 0, 733.5, 805.5, 0, 0, 106, 250)
	Mailbox:setImage(RegisterImage(0x802DDDF9EDFAB76))
	self:addElement(Mailbox)
	self.Mailbox = Mailbox
	local lamb1 = CoD.ui_icon_callingcards_invasion_lamb1.new(f1_arg0, f1_arg1, 0, 0, 810.5, 922.5, 0, 0, -22, 90)
	self:addElement(lamb1)
	self.lamb1 = lamb1
	local lamb2 = CoD.ui_icon_callingcards_invasion_lamb2.new(f1_arg0, f1_arg1, 0, 0, 509.5, 621.5, 0, 0, 15, 127)
	self:addElement(lamb2)
	self.lamb2 = lamb2
	local noisenoanim = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 240)
	noisenoanim:setImage(RegisterImage(0x63977CC49796B44))
	self:addElement(noisenoanim)
	self.noisenoanim = noisenoanim
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD[0x95CA2F50E1B4B18].__resetProperties = function(f2_arg0)
	f2_arg0.ufo:completeAnimation()
	f2_arg0.lamb1:completeAnimation()
	f2_arg0.lamb2:completeAnimation()
	f2_arg0.ufo:setTopBottom(0, 0, 4, 92)
	f2_arg0.lamb1:setTopBottom(0, 0, -22, 90)
	f2_arg0.lamb2:setTopBottom(0, 0, 15, 127)
end
CoD[0x95CA2F50E1B4B18].__clipsPerState = {
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
					f8_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f8_arg0:setTopBottom(0, 0, -50, 62)
					f8_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.lamb1:playClip("DefaultClip")
				f3_arg0.lamb1:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f3_arg0.lamb1:setTopBottom(0, 0, 3, 115)
				f3_arg0.lamb1:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.lamb1:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f3_arg0.lamb1:completeAnimation()
			f3_arg0.lamb1:setTopBottom(0, 0, -50, 62)
			f3_local1(f3_arg0.lamb1)
			local f3_local2 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f11_arg0:setTopBottom(0, 0, 45, 157)
					f11_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
						element:playClip("DefaultClip")
						f3_arg0.clipFinished(element, event)
					end)
				end
				f3_arg0.lamb2:playClip("DefaultClip")
				f3_arg0.lamb2:beginAnimation(1500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
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
CoD[0x95CA2F50E1B4B18].__onClose = function(f13_arg0)
	f13_arg0.ufo:close()
	f13_arg0.lamb1:close()
	f13_arg0.lamb2:close()
end
