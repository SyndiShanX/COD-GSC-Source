CoD.ScoreInfoCTF_FlagState = InheritFrom(LUI.UIElement)
CoD.ScoreInfoCTF_FlagState.__defaultWidth = 170
CoD.ScoreInfoCTF_FlagState.__defaultHeight = 18
CoD.ScoreInfoCTF_FlagState.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfoCTF_FlagState)
	self.id = "ScoreInfoCTF_FlagState"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local awayText = LUI.UIText.new(0, 0, 0, 170, 0.5, 0.5, -9, 9)
	awayText:setAlpha(0)
	awayText:setText(Engine[0xF9F1239CFD921FE](0xC95E6E315A859AB))
	awayText:setTTF("ttmussels_regular")
	awayText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	awayText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(awayText)
	self.awayText = awayText
	local homeText = LUI.UIText.new(0, 0, 0, 170, 0.5, 0.5, -9, 9)
	homeText:setAlpha(0)
	homeText:setText(Engine[0xF9F1239CFD921FE](0xF60F2FAE650F9E))
	homeText:setTTF("ttmussels_regular")
	homeText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	homeText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(homeText)
	self.homeText = homeText
	local FlagStateText = LUI.UIText.new(0, 0, 0, 170, 0.5, 0.5, -9, 9)
	FlagStateText:setText("")
	FlagStateText:setTTF("default")
	FlagStateText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	FlagStateText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(FlagStateText)
	self.FlagStateText = FlagStateText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfoCTF_FlagState.__resetProperties = function(f2_arg0)
	f2_arg0.homeText:completeAnimation()
	f2_arg0.FlagStateText:completeAnimation()
	f2_arg0.awayText:completeAnimation()
	f2_arg0.homeText:setAlpha(0)
	f2_arg0.FlagStateText:setAlpha(1)
	f2_arg0.awayText:setAlpha(0)
end
CoD.ScoreInfoCTF_FlagState.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Home = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.homeText:completeAnimation()
			f4_arg0.homeText:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.homeText)
			f4_arg0.FlagStateText:completeAnimation()
			f4_arg0.FlagStateText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.FlagStateText)
		end,
	},
	Away = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.awayText:completeAnimation()
			f5_arg0.awayText:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.awayText)
			f5_arg0.homeText:completeAnimation()
			f5_arg0.homeText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.homeText)
			f5_arg0.FlagStateText:completeAnimation()
			f5_arg0.FlagStateText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.FlagStateText)
		end,
	},
}
