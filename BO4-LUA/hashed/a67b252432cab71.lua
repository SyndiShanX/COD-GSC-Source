CoD.HVOCardTitle = InheritFrom(LUI.UIElement)
CoD.HVOCardTitle.__defaultWidth = 481
CoD.HVOCardTitle.__defaultHeight = 46
CoD.HVOCardTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HVOCardTitle)
	self.id = "HVOCardTitle"
	self.soundSet = "default"
	local PlayerName = LUI.UIText.new(0, 0, 137, 481, 0, 0, 6, 46)
	PlayerName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	PlayerName:setTTF("ttmussels_regular")
	PlayerName:setLetterSpacing(4)
	PlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PlayerName.__String_Reference = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			PlayerName:setText(f2_local0)
		end
	end
	PlayerName:linkToElementModel(self, "perClient", true, function(model, f3_arg1)
		if f3_arg1["__PlayerName.__String_Reference_perClient->playerName"] then
			f3_arg1:removeSubscription(f3_arg1["__PlayerName.__String_Reference_perClient->playerName"])
			f3_arg1["__PlayerName.__String_Reference_perClient->playerName"] = nil
		end
		if model then
			local f3_local0 = model:get()
			local f3_local1 = model:get()
			model = f3_local0 and f3_local1.playerName
		end
		if model then
			f3_arg1["__PlayerName.__String_Reference_perClient->playerName"] = f3_arg1:subscribeToModel(model, PlayerName.__String_Reference)
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local RankIcon = LUI.UIImage.new(0, 0, 82, 128, 0, 0, 0, 46)
	RankIcon.__Image = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f4_local0))
		end
	end
	RankIcon:linkToElementModel(self, "perClient", true, function(model, f5_arg1)
		if f5_arg1["__RankIcon.__Image_perClient->rankIcon"] then
			f5_arg1:removeSubscription(f5_arg1["__RankIcon.__Image_perClient->rankIcon"])
			f5_arg1["__RankIcon.__Image_perClient->rankIcon"] = nil
		end
		if model then
			local f5_local0 = model:get()
			local f5_local1 = model:get()
			model = f5_local0 and f5_local1.rankIcon
		end
		if model then
			f5_arg1["__RankIcon.__Image_perClient->rankIcon"] = f5_arg1:subscribeToModel(model, RankIcon.__Image)
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local RankLevel = LUI.UIText.new(0, 0, 0, 72, 0, 0, 6, 46)
	RankLevel:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	RankLevel:setTTF("ttmussels_regular")
	RankLevel:setLetterSpacing(4)
	RankLevel:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	RankLevel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	RankLevel.__String_Reference = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			RankLevel:setText(f6_local0)
		end
	end
	RankLevel:linkToElementModel(self, "perClient", true, function(model, f7_arg1)
		if f7_arg1["__RankLevel.__String_Reference_perClient->rank"] then
			f7_arg1:removeSubscription(f7_arg1["__RankLevel.__String_Reference_perClient->rank"])
			f7_arg1["__RankLevel.__String_Reference_perClient->rank"] = nil
		end
		if model then
			local f7_local0 = model:get()
			local f7_local1 = model:get()
			model = f7_local0 and f7_local1.rank
		end
		if model then
			f7_arg1["__RankLevel.__String_Reference_perClient->rank"] = f7_arg1:subscribeToModel(model, RankLevel.__String_Reference)
		end
	end)
	self:addElement(RankLevel)
	self.RankLevel = RankLevel
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HVOCardTitle.__onClose = function(f8_arg0)
	f8_arg0.PlayerName:close()
	f8_arg0.RankIcon:close()
	f8_arg0.RankLevel:close()
end
