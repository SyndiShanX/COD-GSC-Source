require("x64:29187ea00d726c3")
CoD.BOPassRewardsandDisclaimers = InheritFrom(LUI.UIElement)
CoD.BOPassRewardsandDisclaimers.__defaultWidth = 600
CoD.BOPassRewardsandDisclaimers.__defaultHeight = 100
CoD.BOPassRewardsandDisclaimers.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.BOPassRewardsandDisclaimers)
	self.id = "BOPassRewardsandDisclaimers"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Description = LUI.UIText.new(0.5, 0.5, -300, 827, 0, 0, 0, 27)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setText(Engine[@"hash_4F9F1239CFD921FE"](0x96A0418898A8E))
	Description:setTTF("ttmussels_regular")
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Description)
	self.Description = Description
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, -222.5, 527.5, 0, 0, 45, 55)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local f1_local3 = nil
	self.ConsoleDisclaimer2 = LUI.UIElement.createFake()
	local PCDisclaimer = nil
	PCDisclaimer = LUI.UIText.new(0.5, 0.5, -300, 855, 0, 0, 27, 45)
	PCDisclaimer:setRGB(ColorSet.EnemyFlagBg.r, ColorSet.EnemyFlagBg.g, ColorSet.EnemyFlagBg.b)
	PCDisclaimer:setText(LocalizeHash(@"hash_426FCD76A799CA42"))
	PCDisclaimer:setTTF("dinnext_regular")
	PCDisclaimer:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PCDisclaimer:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PCDisclaimer)
	self.PCDisclaimer = PCDisclaimer
	self:mergeStateConditions({
		{
			stateName = "PS4",
			condition = function(menu, element, event)
				return IsOrbis()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BOPassRewardsandDisclaimers.__resetProperties = function(f3_arg0)
	f3_arg0.ConsoleDisclaimer2:completeAnimation()
	f3_arg0.ConsoleDisclaimer2:setAlpha(1)
end
CoD.BOPassRewardsandDisclaimers.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	PS4 = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
			f5_arg0.ConsoleDisclaimer2:completeAnimation()
			f5_arg0.ConsoleDisclaimer2:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ConsoleDisclaimer2)
		end,
	},
}
CoD.BOPassRewardsandDisclaimers.__onClose = function(f6_arg0)
	f6_arg0.VerticalListSpacer:close()
end
