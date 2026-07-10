require("x64:dc5d9397e5e00c8")
CoD.InspectionTrophyWidget = InheritFrom(LUI.UIElement)
CoD.InspectionTrophyWidget.__defaultWidth = 250
CoD.InspectionTrophyWidget.__defaultHeight = 282
CoD.InspectionTrophyWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InspectionTrophyWidget)
	self.id = "InspectionTrophyWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = CoD.InspectionTrophyBackground.new(f1_arg0, f1_arg1, 0, 0, 0, 250, 0, 0, 0, 282)
	self:addElement(Background)
	self.Background = Background
	local TrophyTitle = LUI.UIText.new(0.5, 0.5, -115, 115, 0, 0, 3, 30)
	TrophyTitle:setRGB(0.92, 0.92, 0.92)
	TrophyTitle:setTTF("ttmussels_demibold")
	TrophyTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TrophyTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TrophyTitle:linkToElementModel(self, "catorgry", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TrophyTitle:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(TrophyTitle)
	self.TrophyTitle = TrophyTitle
	local TrophySubtitle = LUI.UIText.new(0.5, 0.5, -115, 115, 0, 0, 29, 47)
	TrophySubtitle:setRGB(0.92, 0.92, 0.92)
	TrophySubtitle:setTTF("ttmussels_regular")
	TrophySubtitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	TrophySubtitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	TrophySubtitle:linkToElementModel(self, "description", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TrophySubtitle:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(TrophySubtitle)
	self.TrophySubtitle = TrophySubtitle
	local ValueTitle = LUI.UIText.new(0.5, 0.5, -115, 115, 0, 0, 219.5, 237.5)
	ValueTitle:setTTF("ttmussels_regular")
	ValueTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ValueTitle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	ValueTitle:linkToElementModel(self, "name", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ValueTitle:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(ValueTitle)
	self.ValueTitle = ValueTitle
	local Value = LUI.UIText.new(0, 0, 25, 225, 0, 0, 238.5, 283.5)
	Value:setTTF("ttmussels_demibold")
	Value:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Value:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Value:linkToElementModel(self, "timesEarned", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Value:setText(FormatNumberAsString(0, f5_local0))
		end
	end)
	self:addElement(Value)
	self.Value = Value
	local TrophyImage = LUI.UIImage.new(0.5, 0.5, -75, 75, 0, 0, 63, 213)
	TrophyImage:linkToElementModel(self, "iconSmall", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TrophyImage:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(TrophyImage)
	self.TrophyImage = TrophyImage
	self:mergeStateConditions({
		{
			stateName = "WZState",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
		{
			stateName = "ZMState",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Background.id = "Background"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InspectionTrophyWidget.__resetProperties = function(f10_arg0)
	f10_arg0.TrophyImage:completeAnimation()
	f10_arg0.TrophyImage:setLeftRight(0.5, 0.5, -75, 75)
	f10_arg0.TrophyImage:setTopBottom(0, 0, 63, 213)
end
CoD.InspectionTrophyWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	WZState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.TrophyImage:completeAnimation()
			f12_arg0.TrophyImage:setLeftRight(0.5, 0.5, -75, 75)
			f12_arg0.TrophyImage:setTopBottom(0, 0, 63, 213)
			f12_arg0.clipFinished(f12_arg0.TrophyImage)
		end,
	},
	ZMState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.TrophyImage:completeAnimation()
			f13_arg0.TrophyImage:setLeftRight(0.5, 0.5, -75, 75)
			f13_arg0.TrophyImage:setTopBottom(0, 0, 63, 213)
			f13_arg0.clipFinished(f13_arg0.TrophyImage)
		end,
	},
}
CoD.InspectionTrophyWidget.__onClose = function(f14_arg0)
	f14_arg0.Background:close()
	f14_arg0.TrophyTitle:close()
	f14_arg0.TrophySubtitle:close()
	f14_arg0.ValueTitle:close()
	f14_arg0.Value:close()
	f14_arg0.TrophyImage:close()
end
