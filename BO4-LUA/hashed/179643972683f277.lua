require("x64:1cd7f68136f9cc0")
CoD.zm_red_location_text = InheritFrom(LUI.UIElement)
CoD.zm_red_location_text.__defaultWidth = 360
CoD.zm_red_location_text.__defaultHeight = 19
CoD.zm_red_location_text.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.zm_red_location_text)
	self.id = "zm_red_location_text"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LocationTextDark = LUI.UIText.new(0, 0, 0, 360, 0, 0, 0.5, 20.5)
	LocationTextDark:setRGB(0.31, 0.31, 0.31)
	LocationTextDark:setAlpha(0)
	LocationTextDark:setText("")
	LocationTextDark:setTTF("skorzhen")
	LocationTextDark:setLetterSpacing(1)
	LocationTextDark:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LocationTextDark:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(LocationTextDark)
	self.LocationTextDark = LocationTextDark
	local LocationText = LUI.UIText.new(0, 0, 0, 360, 0, 0, 0.5, 20.5)
	LocationText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LocationText:setText("")
	LocationText:setTTF("skorzhen")
	LocationText:setLetterSpacing(1)
	LocationText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LocationText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(LocationText)
	self.LocationText = LocationText
	local TopOrnament2 = CoD.zm_LaboratoryDescriptionDividerSecondary.new(f1_arg0, f1_arg1, 0.5, 0.5, -178.5, 178.5, 0.5, 0.5, -37, -11)
	self:addElement(TopOrnament2)
	self.TopOrnament2 = TopOrnament2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.zm_red_location_text.__resetProperties = function(f2_arg0)
	f2_arg0.LocationText:completeAnimation()
	f2_arg0.TopOrnament2:completeAnimation()
	f2_arg0.LocationTextDark:completeAnimation()
	f2_arg0.LocationText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f2_arg0.LocationText:setAlpha(1)
	f2_arg0.TopOrnament2:setAlpha(1)
	f2_arg0.LocationTextDark:setAlpha(0)
end
CoD.zm_red_location_text.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	NoText = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.LocationText:completeAnimation()
			f4_arg0.LocationText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.LocationText)
			f4_arg0.TopOrnament2:completeAnimation()
			f4_arg0.TopOrnament2:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.TopOrnament2)
		end,
	},
	InLocation = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.LocationText:completeAnimation()
			f5_arg0.LocationText:setRGB(0, 0.78, 0)
			f5_arg0.clipFinished(f5_arg0.LocationText)
		end,
	},
	NotInLocation = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.LocationTextDark:completeAnimation()
			f6_arg0.LocationTextDark:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.LocationTextDark)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(500, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.LocationText:beginAnimation(500, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f6_arg0.LocationText:setAlpha(0.25)
				f6_arg0.LocationText:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.LocationText:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.LocationText:completeAnimation()
			f6_arg0.LocationText:setRGB(0.91, 0.04, 0.04)
			f6_arg0.LocationText:setAlpha(1)
			f6_local0(f6_arg0.LocationText)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.zm_red_location_text.__onClose = function(f9_arg0)
	f9_arg0.TopOrnament2:close()
end
