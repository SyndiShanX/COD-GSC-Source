CoD.AARXpMeterCurrentLevel = InheritFrom(LUI.UIElement)
CoD.AARXpMeterCurrentLevel.__defaultWidth = 120
CoD.AARXpMeterCurrentLevel.__defaultHeight = 30
CoD.AARXpMeterCurrentLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARXpMeterCurrentLevel)
	self.id = "AARXpMeterCurrentLevel"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RankLabel = LUI.UIText.new(0, 0, -85, 65, 0, 0, 4, 26)
	RankLabel:setRGB(0.9, 0.89, 0.78)
	RankLabel:setTTF("ttmussels_demibold")
	RankLabel:setLetterSpacing(2)
	RankLabel:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	RankLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	RankLabel:linkToElementModel(self, "rankLabel", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RankLabel:setText(f2_local0)
		end
	end)
	self:addElement(RankLabel)
	self.RankLabel = RankLabel
	local ZMRankLabel = LUI.UIText.new(0, 0, -85, 65, 0, 0, 5, 27)
	ZMRankLabel:setRGB(0.9, 0.89, 0.78)
	ZMRankLabel:setAlpha(0)
	ZMRankLabel:setTTF("skorzhen")
	ZMRankLabel:setLetterSpacing(4)
	ZMRankLabel:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	ZMRankLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ZMRankLabel:linkToElementModel(self, "rankLabel", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ZMRankLabel:setText(f3_local0)
		end
	end)
	self:addElement(ZMRankLabel)
	self.ZMRankLabel = ZMRankLabel
	local RankIcon = LUI.UIImage.new(0, 0, 70, 120, 0, 0, -10, 40)
	RankIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARXpMeterCurrentLevel.__resetProperties = function(f7_arg0)
	f7_arg0.ZMRankLabel:completeAnimation()
	f7_arg0.RankLabel:completeAnimation()
	f7_arg0.ZMRankLabel:setAlpha(0)
	f7_arg0.RankLabel:setAlpha(1)
end
CoD.AARXpMeterCurrentLevel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ZMRankLabel:completeAnimation()
			f8_arg0.ZMRankLabel:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ZMRankLabel)
		end,
	},
	ZM = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.RankLabel:completeAnimation()
			f9_arg0.RankLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.RankLabel)
			f9_arg0.ZMRankLabel:completeAnimation()
			f9_arg0.ZMRankLabel:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.ZMRankLabel)
		end,
	},
}
CoD.AARXpMeterCurrentLevel.__onClose = function(f10_arg0)
	f10_arg0.RankLabel:close()
	f10_arg0.ZMRankLabel:close()
	f10_arg0.RankIcon:close()
end
