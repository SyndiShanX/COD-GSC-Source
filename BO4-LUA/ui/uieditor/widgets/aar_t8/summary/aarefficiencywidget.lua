require("x64:3c71a587b3212e8")
CoD.AAREfficiencyWidget = InheritFrom(LUI.UIElement)
CoD.AAREfficiencyWidget.__defaultWidth = 270
CoD.AAREfficiencyWidget.__defaultHeight = 132
CoD.AAREfficiencyWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AAREfficiencyWidget)
	self.id = "AAREfficiencyWidget"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PerformBg = CoD.AARPerformanceBg.new(f1_arg0, f1_arg1, 0, 0, 0, 270, 0, 0, 0, 132)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local EfficiencyLabel = LUI.UIText.new(0, 0, 16.5, 270.5, 0, 0, 12, 33)
	EfficiencyLabel:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	EfficiencyLabel:setAlpha(0.2)
	EfficiencyLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/efficiency"))
	EfficiencyLabel:setTTF("dinnext_regular")
	EfficiencyLabel:setLetterSpacing(2)
	EfficiencyLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EfficiencyLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EfficiencyLabel)
	self.EfficiencyLabel = EfficiencyLabel
	local RevivesLabel = LUI.UIText.new(0, 0, 56, 270, 0, 0, 43, 64)
	RevivesLabel:setRGB(0.9, 0.89, 0.78)
	RevivesLabel:setAlpha(0.25)
	RevivesLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/revives"))
	RevivesLabel:setTTF("dinnext_regular")
	RevivesLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RevivesLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(RevivesLabel)
	self.RevivesLabel = RevivesLabel
	local Revives = LUI.UIText.new(0, 0, 2.5, 46.5, 0, 0, 43, 64)
	Revives:setRGB(0.9, 0.89, 0.78)
	Revives:setAlpha(0.25)
	Revives:setTTF("dinnext_regular")
	Revives:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	Revives:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Revives:linkToElementModel(self, "revives", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Revives:setText(f2_local0)
		end
	end)
	self:addElement(Revives)
	self.Revives = Revives
	local CleanUpLabel = LUI.UIText.new(0, 0, 56, 270, 0, 0, 67, 88)
	CleanUpLabel:setRGB(0.9, 0.89, 0.78)
	CleanUpLabel:setAlpha(0.25)
	CleanUpLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_345C50B4E30324A4"))
	CleanUpLabel:setTTF("dinnext_regular")
	CleanUpLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CleanUpLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(CleanUpLabel)
	self.CleanUpLabel = CleanUpLabel
	local CleanUp = LUI.UIText.new(0, 0, 0.5, 46.5, 0, 0, 67, 88)
	CleanUp:setRGB(0.9, 0.89, 0.78)
	CleanUp:setAlpha(0.25)
	CleanUp:setTTF("dinnext_regular")
	CleanUp:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	CleanUp:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	CleanUp:linkToElementModel(self, "cleanUps", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CleanUp:setText(f3_local0)
		end
	end)
	self:addElement(CleanUp)
	self.CleanUp = CleanUp
	local UnfinishedDropsLabel = LUI.UIText.new(0, 0, 56, 270, 0, 0, 91, 112)
	UnfinishedDropsLabel:setRGB(0.9, 0.89, 0.78)
	UnfinishedDropsLabel:setAlpha(0.25)
	UnfinishedDropsLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/downs"))
	UnfinishedDropsLabel:setTTF("dinnext_regular")
	UnfinishedDropsLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	UnfinishedDropsLabel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(UnfinishedDropsLabel)
	self.UnfinishedDropsLabel = UnfinishedDropsLabel
	local UnfinishedDrops = LUI.UIText.new(0, 0, 0.5, 46.5, 0, 0, 91, 112)
	UnfinishedDrops:setRGB(0.9, 0.89, 0.78)
	UnfinishedDrops:setAlpha(0.25)
	UnfinishedDrops:setTTF("dinnext_regular")
	UnfinishedDrops:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	UnfinishedDrops:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	UnfinishedDrops:linkToElementModel(self, "downs", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			UnfinishedDrops:setText(f4_local0)
		end
	end)
	self:addElement(UnfinishedDrops)
	self.UnfinishedDrops = UnfinishedDrops
	self:mergeStateConditions({
		{
			stateName = "Solo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "gametype", @"warzone_solo")
			end,
		},
	})
	self:linkToElementModel(self, "gametype", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "gametype",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AAREfficiencyWidget.__resetProperties = function(f7_arg0)
	f7_arg0.UnfinishedDrops:completeAnimation()
	f7_arg0.UnfinishedDropsLabel:completeAnimation()
	f7_arg0.CleanUp:completeAnimation()
	f7_arg0.CleanUpLabel:completeAnimation()
	f7_arg0.Revives:completeAnimation()
	f7_arg0.RevivesLabel:completeAnimation()
	f7_arg0.EfficiencyLabel:completeAnimation()
	f7_arg0.PerformBg:completeAnimation()
	f7_arg0.UnfinishedDrops:setAlpha(0.25)
	f7_arg0.UnfinishedDropsLabel:setAlpha(0.25)
	f7_arg0.CleanUp:setAlpha(0.25)
	f7_arg0.CleanUpLabel:setAlpha(0.25)
	f7_arg0.Revives:setAlpha(0.25)
	f7_arg0.RevivesLabel:setAlpha(0.25)
	f7_arg0.EfficiencyLabel:setAlpha(0.2)
	f7_arg0.PerformBg:setAlpha(1)
end
CoD.AAREfficiencyWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Solo = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(8)
			f9_arg0.PerformBg:completeAnimation()
			f9_arg0.PerformBg:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PerformBg)
			f9_arg0.EfficiencyLabel:completeAnimation()
			f9_arg0.EfficiencyLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.EfficiencyLabel)
			f9_arg0.RevivesLabel:completeAnimation()
			f9_arg0.RevivesLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.RevivesLabel)
			f9_arg0.Revives:completeAnimation()
			f9_arg0.Revives:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Revives)
			f9_arg0.CleanUpLabel:completeAnimation()
			f9_arg0.CleanUpLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CleanUpLabel)
			f9_arg0.CleanUp:completeAnimation()
			f9_arg0.CleanUp:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CleanUp)
			f9_arg0.UnfinishedDropsLabel:completeAnimation()
			f9_arg0.UnfinishedDropsLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.UnfinishedDropsLabel)
			f9_arg0.UnfinishedDrops:completeAnimation()
			f9_arg0.UnfinishedDrops:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.UnfinishedDrops)
		end,
	},
}
CoD.AAREfficiencyWidget.__onClose = function(f10_arg0)
	f10_arg0.PerformBg:close()
	f10_arg0.Revives:close()
	f10_arg0.CleanUp:close()
	f10_arg0.UnfinishedDrops:close()
end
