CoD.DirectorFindGamePlaylistInfoTimed2xp = InheritFrom(LUI.UIElement)
CoD.DirectorFindGamePlaylistInfoTimed2xp.__defaultWidth = 72
CoD.DirectorFindGamePlaylistInfoTimed2xp.__defaultHeight = 106
CoD.DirectorFindGamePlaylistInfoTimed2xp.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorFindGamePlaylistInfoTimed2xp)
	self.id = "DirectorFindGamePlaylistInfoTimed2xp"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XpSmall = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 72)
	XpSmall:setImage(RegisterImage(@"ui_icon_2xp"))
	self:addElement(XpSmall)
	self.XpSmall = XpSmall
	local PromoBG = LUI.UIImage.new(0, 0, 0, 72, 0, 0, 72, 89)
	PromoBG:setRGB(0, 0, 0)
	self:addElement(PromoBG)
	self.PromoBG = PromoBG
	local PromoLabel = LUI.UIText.new(0, 0, 0, 72, 0, 0, 72, 89)
	PromoLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4911577C5D3F5B1A"))
	PromoLabel:setTTF("default")
	PromoLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PromoLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PromoLabel)
	self.PromoLabel = PromoLabel
	local TimeBG = LUI.UIImage.new(0, 0, 0, 72, 0, 0, 89, 106)
	self:addElement(TimeBG)
	self.TimeBG = TimeBG
	local Time = LUI.UIText.new(0, 0, 0, 72, 0, 0, 89, 106)
	Time:setRGB(0, 0, 0)
	Time:setTTF("default")
	Time:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Time:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Time:subscribeToGlobalModel(f1_arg1, "PromotionalDoubleXP", "dailyDoubleXPTimeLeft", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Time:setText(LocalizeIntoString(@"hash_6ACC0A2311E2A5EA", f2_local0))
		end
	end)
	self:addElement(Time)
	self.Time = Time
	self:mergeStateConditions({
		{
			stateName = "french",
			condition = function(menu, element, event)
				return IsCurrentLanguageFrench()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorFindGamePlaylistInfoTimed2xp.__onClose = function(f4_arg0)
	f4_arg0.Time:close()
end
