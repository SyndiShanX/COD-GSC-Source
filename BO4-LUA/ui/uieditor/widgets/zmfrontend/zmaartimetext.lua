CoD.ZMAARTimeText = InheritFrom(LUI.UIElement)
CoD.ZMAARTimeText.__defaultWidth = 200
CoD.ZMAARTimeText.__defaultHeight = 33
CoD.ZMAARTimeText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARTimeText)
	self.id = "ZMAARTimeText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MatchTimeText = LUI.UIText.new(1, 1, -200, 0, 0, 0, 0, 33)
	MatchTimeText:setText(LocalizeToUpperString(0xBD36CB2DA85CF8C))
	MatchTimeText:setTTF("skorzhen")
	MatchTimeText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	self:addElement(MatchTimeText)
	self.MatchTimeText = MatchTimeText
	self:mergeStateConditions({
		{
			stateName = "ShowNewBestTimeLeftAligned",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "AAR.trialStats.isNewBestTime") and AlwaysFalse()
			end,
		},
		{
			stateName = "ShowNewBestTime",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "AAR.trialStats.isNewBestTime")
			end,
		},
		{
			stateName = "LeftAligned",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["AAR.trialStats.isNewBestTime"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "AAR.trialStats.isNewBestTime",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARTimeText.__resetProperties = function(f6_arg0)
	f6_arg0.MatchTimeText:completeAnimation()
	f6_arg0.MatchTimeText:setLeftRight(1, 1, -200, 0)
	f6_arg0.MatchTimeText:setAlpha(1)
	f6_arg0.MatchTimeText:setText(LocalizeToUpperString(0xBD36CB2DA85CF8C))
	f6_arg0.MatchTimeText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
end
CoD.ZMAARTimeText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	ShowNewBestTimeLeftAligned = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.MatchTimeText:completeAnimation()
			f8_arg0.MatchTimeText:setLeftRight(0, 0, -33, 200)
			f8_arg0.MatchTimeText:setAlpha(1)
			f8_arg0.MatchTimeText:setText(LocalizeToUpperString(0x6EDD470FE48F6F9))
			f8_arg0.MatchTimeText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
			f8_arg0.MatchTimeText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
			f8_arg0.clipFinished(f8_arg0.MatchTimeText)
		end,
	},
	ShowNewBestTime = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.MatchTimeText:completeAnimation()
			f9_arg0.MatchTimeText:setLeftRight(0, 0, -33, 200)
			f9_arg0.MatchTimeText:setAlpha(1)
			f9_arg0.MatchTimeText:setText(LocalizeToUpperString(0x6EDD470FE48F6F9))
			f9_arg0.MatchTimeText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
			f9_arg0.MatchTimeText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
			f9_arg0.clipFinished(f9_arg0.MatchTimeText)
		end,
	},
	LeftAligned = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.MatchTimeText:completeAnimation()
			f10_arg0.MatchTimeText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
			f10_arg0.clipFinished(f10_arg0.MatchTimeText)
		end,
	},
}
