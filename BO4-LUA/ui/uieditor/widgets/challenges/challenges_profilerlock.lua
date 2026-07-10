require("x64:eeba57f916954d1")
require("x64:8361a8d6fe55653")
require("x64:29187ea00d726c3")
CoD.Challenges_ProfilerLock = InheritFrom(LUI.UIElement)
CoD.Challenges_ProfilerLock.__defaultWidth = 235
CoD.Challenges_ProfilerLock.__defaultHeight = 45
CoD.Challenges_ProfilerLock.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, true)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.Challenges_ProfilerLock)
	self.id = "Challenges_ProfilerLock"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PixelGridTiledBacking = CoD.Challenges_ProfilerLockBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local SpacerBegin = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, -3, 5, 0, 1, 0, 0)
	self:addElement(SpacerBegin)
	self.SpacerBegin = SpacerBegin
	local LockedIcon = CoD.cac_lock.new(f1_arg0, f1_arg1, 0, 0, 5, 41, 0, 0, 4.5, 40.5)
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local SpacerMiddle = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 41, 45, 0, 1, 0, 0)
	self:addElement(SpacerMiddle)
	self.SpacerMiddle = SpacerMiddle
	local TierText = LUI.UIText.new(0, 0, 45, 221, 0, 0, 9, 36)
	TierText:setTTF("ttmussels_regular")
	TierText:setLetterSpacing(1)
	TierText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TierText:linkToElementModel(self, "maxTier", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TierText:setText(CoD.ChallengesUtility.MakeChallengeTierString(f2_local0))
		end
	end)
	self:addElement(TierText)
	self.TierText = TierText
	local SpacerEnd = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 221, 238, -0, 1, 0, 0)
	self:addElement(SpacerEnd)
	self.SpacerEnd = SpacerEnd
	self:mergeStateConditions({
		{
			stateName = "LockedOneTier",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "maxTier", 0)
			end,
		},
	})
	self:linkToElementModel(self, "maxTier", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "maxTier",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_ProfilerLock.__resetProperties = function(f5_arg0)
	f5_arg0.TierText:completeAnimation()
	f5_arg0.SpacerMiddle:completeAnimation()
	f5_arg0.SpacerEnd:completeAnimation()
	f5_arg0.TierText:setAlpha(1)
	f5_arg0.SpacerMiddle:setAlpha(1)
	f5_arg0.SpacerEnd:setLeftRight(0, 0, 221, 238)
end
CoD.Challenges_ProfilerLock.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	LockedOneTier = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.SpacerMiddle:completeAnimation()
			f7_arg0.SpacerMiddle:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.SpacerMiddle)
			f7_arg0.TierText:completeAnimation()
			f7_arg0.TierText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TierText)
			f7_arg0.SpacerEnd:completeAnimation()
			f7_arg0.SpacerEnd:setLeftRight(0, 0, 224, 232)
			f7_arg0.clipFinished(f7_arg0.SpacerEnd)
		end,
	},
}
CoD.Challenges_ProfilerLock.__onClose = function(f8_arg0)
	f8_arg0.PixelGridTiledBacking:close()
	f8_arg0.SpacerBegin:close()
	f8_arg0.LockedIcon:close()
	f8_arg0.SpacerMiddle:close()
	f8_arg0.TierText:close()
	f8_arg0.SpacerEnd:close()
end
