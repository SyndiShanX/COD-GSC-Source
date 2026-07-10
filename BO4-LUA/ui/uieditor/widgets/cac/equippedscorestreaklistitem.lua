require("x64:76fa323de4745ba")
CoD.EquippedScorestreakListItem = InheritFrom(LUI.UIElement)
CoD.EquippedScorestreakListItem.__defaultWidth = 100
CoD.EquippedScorestreakListItem.__defaultHeight = 150
CoD.EquippedScorestreakListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EquippedScorestreakListItem)
	self.id = "EquippedScorestreakListItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScorestreaksBG = LUI.UIImage.new(0, 0, -8, 108, 0, 0, -9, 159)
	ScorestreaksBG:setImage(RegisterImage(@"hash_262843B22FDD53AB"))
	self:addElement(ScorestreaksBG)
	self.ScorestreaksBG = ScorestreaksBG
	local ScorestreakIcon = LUI.UIImage.new(0, 0, 3, 97, 0, 0, 10, 104)
	ScorestreakIcon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ScorestreakIcon:setImage(CoD.BaseUtility.AlreadyRegistered(f2_local0))
		end
	end)
	self:addElement(ScorestreakIcon)
	self.ScorestreakIcon = ScorestreakIcon
	local ScoreCost = LUI.UIText.new(0, 0, 0, 100, 0, 0, 118, 147)
	ScoreCost:setRGB(0.86, 0.74, 0.25)
	ScoreCost:setTTF("ttmussels_regular")
	ScoreCost:setLetterSpacing(5)
	ScoreCost:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ScoreCost:linkToElementModel(self, "scoreToUnlock", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ScoreCost:setText(f3_local0)
		end
	end)
	self:addElement(ScoreCost)
	self.ScoreCost = ScoreCost
	local ScorestreaksBGAdd = LUI.UIImage.new(0, 0, -8, 108, 0, 0, -9, 159)
	ScorestreaksBGAdd:setAlpha(0)
	ScorestreaksBGAdd:setImage(RegisterImage(@"hash_262843B22FDD53AB"))
	ScorestreaksBGAdd:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	ScorestreaksBGAdd:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(ScorestreaksBGAdd)
	self.ScorestreaksBGAdd = ScorestreaksBGAdd
	local RestrictedIcon = CoD.RestrictedItemWarning.new(f1_arg0, f1_arg1, 0.5, 0.5, -30, 30, 0.5, 0.5, -43, 7)
	RestrictedIcon:linkToElementModel(self, nil, false, function(model)
		RestrictedIcon:setModel(model, f1_arg1)
	end)
	self:addElement(RestrictedIcon)
	self.RestrictedIcon = RestrictedIcon
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "itemIndex", CoD.CACUtility.EmptyItemIndex)
			end,
		},
		{
			stateName = "Focusable",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EquippedScorestreakListItem.__resetProperties = function(f8_arg0)
	f8_arg0.ScorestreakIcon:completeAnimation()
	f8_arg0.ScoreCost:completeAnimation()
	f8_arg0.ScorestreaksBGAdd:completeAnimation()
	f8_arg0.ScorestreakIcon:setAlpha(1)
	f8_arg0.ScoreCost:setAlpha(1)
	f8_arg0.ScorestreaksBGAdd:setAlpha(0)
end
CoD.EquippedScorestreakListItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.ScorestreakIcon:completeAnimation()
			f10_arg0.ScorestreakIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ScorestreakIcon)
			f10_arg0.ScoreCost:completeAnimation()
			f10_arg0.ScoreCost:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ScoreCost)
		end,
	},
	Focusable = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.ScorestreaksBGAdd:completeAnimation()
			f12_arg0.ScorestreaksBGAdd:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.ScorestreaksBGAdd)
		end,
		GainFocus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			local f13_local0 = function(f14_arg0)
				f13_arg0.ScorestreaksBGAdd:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f13_arg0.ScorestreaksBGAdd:setAlpha(1)
				f13_arg0.ScorestreaksBGAdd:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.ScorestreaksBGAdd:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.ScorestreaksBGAdd:completeAnimation()
			f13_arg0.ScorestreaksBGAdd:setAlpha(0)
			f13_local0(f13_arg0.ScorestreaksBGAdd)
		end,
	},
}
CoD.EquippedScorestreakListItem.__onClose = function(f15_arg0)
	f15_arg0.ScorestreakIcon:close()
	f15_arg0.ScoreCost:close()
	f15_arg0.RestrictedIcon:close()
end
