CoD.AARXpMeterNextLevel = InheritFrom(LUI.UIElement)
CoD.AARXpMeterNextLevel.__defaultWidth = 70
CoD.AARXpMeterNextLevel.__defaultHeight = 30
CoD.AARXpMeterNextLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARXpMeterNextLevel)
	self.id = "AARXpMeterNextLevel"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RankIcon = LUI.UIImage.new(0, 0, 0, 50, 0, 0, -10, 40)
	RankIcon:linkToElementModel(self, "nextRankIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local RankLabel = LUI.UIText.new(0, 0, 56, 162, 0, 0, 4, 26)
	RankLabel:setTTF("ttmussels_demibold")
	RankLabel:setLetterSpacing(2)
	RankLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	RankLabel:linkToElementModel(self, "nextRankLabel", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RankLabel:setText(f3_local0)
		end
	end)
	self:addElement(RankLabel)
	self.RankLabel = RankLabel
	local ZMRankLabel = LUI.UIText.new(0, 0, 56, 162, 0, 0, 5, 27)
	ZMRankLabel:setAlpha(0)
	ZMRankLabel:setTTF("skorzhen")
	ZMRankLabel:setLetterSpacing(4)
	ZMRankLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ZMRankLabel:linkToElementModel(self, "nextRankLabel", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ZMRankLabel:setText(f4_local0)
		end
	end)
	self:addElement(ZMRankLabel)
	self.ZMRankLabel = ZMRankLabel
	self:mergeStateConditions({
		{
			stateName = "ZM",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	self:linkToElementModel(self, "nextRankIcon", true, function(model)
		local f7_local0 = self
		PlayClip(self, "Intro", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARXpMeterNextLevel.__resetProperties = function(f8_arg0)
	f8_arg0.RankIcon:completeAnimation()
	f8_arg0.RankLabel:completeAnimation()
	f8_arg0.ZMRankLabel:completeAnimation()
	f8_arg0.RankIcon:setAlpha(1)
	f8_arg0.RankIcon:setScale(1, 1)
	f8_arg0.RankLabel:setAlpha(1)
	f8_arg0.ZMRankLabel:setAlpha(0)
end
CoD.AARXpMeterNextLevel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.RankIcon:beginAnimation(150)
				f10_arg0.RankIcon:setAlpha(1)
				f10_arg0.RankIcon:setScale(1, 1)
				f10_arg0.RankIcon:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.RankIcon:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.RankIcon:completeAnimation()
			f10_arg0.RankIcon:setAlpha(0)
			f10_arg0.RankIcon:setScale(2, 2)
			f10_local0(f10_arg0.RankIcon)
		end,
	},
	ZM = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.RankLabel:completeAnimation()
			f12_arg0.RankLabel:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.RankLabel)
			f12_arg0.ZMRankLabel:completeAnimation()
			f12_arg0.ZMRankLabel:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.ZMRankLabel)
		end,
		Intro = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			local f13_local0 = function(f14_arg0)
				f13_arg0.RankIcon:beginAnimation(150)
				f13_arg0.RankIcon:setAlpha(1)
				f13_arg0.RankIcon:setScale(1, 1)
				f13_arg0.RankIcon:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.RankIcon:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.RankIcon:completeAnimation()
			f13_arg0.RankIcon:setAlpha(0)
			f13_arg0.RankIcon:setScale(2, 2)
			f13_local0(f13_arg0.RankIcon)
			f13_arg0.RankLabel:completeAnimation()
			f13_arg0.RankLabel:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.RankLabel)
			f13_arg0.ZMRankLabel:completeAnimation()
			f13_arg0.ZMRankLabel:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.ZMRankLabel)
		end,
	},
}
CoD.AARXpMeterNextLevel.__onClose = function(f15_arg0)
	f15_arg0.RankIcon:close()
	f15_arg0.RankLabel:close()
	f15_arg0.ZMRankLabel:close()
end
