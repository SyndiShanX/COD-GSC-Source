require("ui/uieditor/widgets/arena/arenarankiconandrankvertical")
CoD.CommonRankIconAndRankVertical = InheritFrom(LUI.UIElement)
CoD.CommonRankIconAndRankVertical.__defaultWidth = 91
CoD.CommonRankIconAndRankVertical.__defaultHeight = 63
CoD.CommonRankIconAndRankVertical.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonRankIconAndRankVertical)
	self.id = "CommonRankIconAndRankVertical"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArenaRankIconAndRankVertical = CoD.ArenaRankIconAndRankVertical.new(f1_arg0, f1_arg1, 0, 0, 0, 91, 0, 0, 0.5, 63.5)
	ArenaRankIconAndRankVertical:setAlpha(0)
	ArenaRankIconAndRankVertical:linkToElementModel(self, nil, false, function(model)
		ArenaRankIconAndRankVertical:setModel(model, f1_arg1)
	end)
	self:addElement(ArenaRankIconAndRankVertical)
	self.ArenaRankIconAndRankVertical = ArenaRankIconAndRankVertical
	local rankText = LUI.UIText.new(0, 0, 57, 86, 0.5, 0.5, -10, 10)
	rankText:setTTF("0arame_mono_stencil")
	rankText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	rankText:setShaderVector(0, 1, 0, 0, 0)
	rankText:setShaderVector(1, 0, 0, 0, 0)
	rankText:setShaderVector(2, 0, 0, 0, 0.5)
	rankText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	rankText:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	rankText:linkToElementModel(self, "isParagon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			rankText:setRGB(CoD.DirectorUtility.GetColorForDisplayRankText(f3_local0))
		end
	end)
	rankText:linkToElementModel(self, "displayRank", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			rankText:setText(f4_local0)
		end
	end)
	self:addElement(rankText)
	self.rankText = rankText
	local rankIcon = LUI.UIImage.new(0, 0, 3, 51, 0.5, 0.5, -23.5, 24.5)
	rankIcon:linkToElementModel(self, "rankIcon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			rankIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(rankIcon)
	self.rankIcon = rankIcon
	self:mergeStateConditions({
		{
			stateName = "VisibleArena",
			condition = function(menu, element, event)
				return CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.Arena)
			end,
		},
		{
			stateName = "VisibleWZ",
			condition = function(menu, element, event)
				return CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.Warzone)
			end,
		},
		{
			stateName = "VisibleOther",
			condition = function(menu, element, event)
				return not CoD.RankUtility.IsCurrentRankModeEqualTo(CoD.RankUtility.RankMode.None)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine.GetGlobalModel()
	f1_local5(f1_local4, f1_local6["lobbyRoot.rankMode"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.rankMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonRankIconAndRankVertical.__resetProperties = function(f10_arg0)
	f10_arg0.rankIcon:completeAnimation()
	f10_arg0.rankText:completeAnimation()
	f10_arg0.ArenaRankIconAndRankVertical:completeAnimation()
	f10_arg0.rankIcon:setAlpha(1)
	f10_arg0.rankText:setLeftRight(0, 0, 57, 86)
	f10_arg0.rankText:setTopBottom(0.5, 0.5, -10, 10)
	f10_arg0.rankText:setAlpha(1)
	f10_arg0.ArenaRankIconAndRankVertical:setAlpha(0)
end
CoD.CommonRankIconAndRankVertical.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.rankText:completeAnimation()
			f11_arg0.rankText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.rankText)
			f11_arg0.rankIcon:completeAnimation()
			f11_arg0.rankIcon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.rankIcon)
		end,
	},
	VisibleArena = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.ArenaRankIconAndRankVertical:completeAnimation()
			f12_arg0.ArenaRankIconAndRankVertical:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.ArenaRankIconAndRankVertical)
			f12_arg0.rankText:completeAnimation()
			f12_arg0.rankText:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.rankText)
			f12_arg0.rankIcon:completeAnimation()
			f12_arg0.rankIcon:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.rankIcon)
		end,
	},
	VisibleWZ = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.rankText:completeAnimation()
			f13_arg0.rankText:setLeftRight(0, 0, 54, 97)
			f13_arg0.rankText:setTopBottom(0.5, 0.5, -11, 11)
			f13_arg0.rankText:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.rankText)
			f13_arg0.rankIcon:completeAnimation()
			f13_arg0.rankIcon:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.rankIcon)
		end,
	},
	VisibleOther = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.rankText:completeAnimation()
			f14_arg0.rankText:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.rankText)
			f14_arg0.rankIcon:completeAnimation()
			f14_arg0.rankIcon:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.rankIcon)
		end,
	},
}
CoD.CommonRankIconAndRankVertical.__onClose = function(f15_arg0)
	f15_arg0.ArenaRankIconAndRankVertical:close()
	f15_arg0.rankText:close()
	f15_arg0.rankIcon:close()
end
