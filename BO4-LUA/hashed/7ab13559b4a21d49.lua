require("x64:48557ed02af231c")
require("x64:6947112378e931b")
CoD.WZObituaryCalloutExpandedContainer = InheritFrom(LUI.UIElement)
CoD.WZObituaryCalloutExpandedContainer.__defaultWidth = 800
CoD.WZObituaryCalloutExpandedContainer.__defaultHeight = 80
CoD.WZObituaryCalloutExpandedContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.WZObituaryCalloutExpandedContainer)
	self.id = "WZObituaryCalloutExpandedContainer"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WarzoneKillerIdentity = CoD.WarzoneKillerIdentity.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0.5, 0.5, -40, 40)
	WarzoneKillerIdentity.KillerLabel:setText(LocalizeToUpperString(0x161ED05A4E04839))
	WarzoneKillerIdentity:linkToElementModel(self, nil, false, function(model)
		WarzoneKillerIdentity:setModel(model, f1_arg1)
	end)
	WarzoneKillerIdentity:linkToElementModel(self, "xuid", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			WarzoneKillerIdentity.AttackerEmblem:setupPlayerEmblemByXUID(f3_local0)
		end
	end)
	WarzoneKillerIdentity:linkToElementModel(self, nil, false, function(model)
		WarzoneKillerIdentity.CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	WarzoneKillerIdentity:linkToElementModel(self, "clientNum", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			WarzoneKillerIdentity.PlayerName:setText(GetClientName(f1_arg1, f5_local0))
		end
	end)
	WarzoneKillerIdentity:linkToElementModel(self, "clientNum", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			WarzoneKillerIdentity.ClanName:setText(CoD.SocialUtility.CleanGamerTag(GetClientClantag(f1_arg1, f6_local0)))
		end
	end)
	WarzoneKillerIdentity:linkToElementModel(self, "rank", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			WarzoneKillerIdentity.Rank:setText(CoD.PrestigeUtility.LocalizeIfMaxRank(0x4008CE61FE52DCD, SetValueIfEmptyString("1", f7_local0)))
		end
	end)
	WarzoneKillerIdentity:linkToElementModel(self, "rankIcon", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			WarzoneKillerIdentity.RankIcon:setImage(RegisterImage(f8_local0))
		end
	end)
	self:addElement(WarzoneKillerIdentity)
	self.WarzoneKillerIdentity = WarzoneKillerIdentity
	local ContribText = CoD.WZObituaryCalloutContainerDamageDealt.new(f1_arg0, f1_arg1, 0.5, 0.5, -110.5, 110.5, 0.5, 0.5, 46, 72)
	ContribText.ContribDamage:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	ContribText:linkToElementModel(self, nil, false, function(model)
		ContribText:setModel(model, f1_arg1)
	end)
	self:addElement(ContribText)
	self.ContribText = ContribText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f10_local0
				if not CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "style", 0) then
					f10_local0 = not CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "style", 4)
				else
					f10_local0 = false
				end
				return f10_local0
			end,
		},
	})
	self:linkToElementModel(self, "style", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "style",
		})
	end)
	WarzoneKillerIdentity.id = "WarzoneKillerIdentity"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZObituaryCalloutExpandedContainer.__resetProperties = function(f12_arg0)
	f12_arg0.WarzoneKillerIdentity:completeAnimation()
	f12_arg0.ContribText:completeAnimation()
	f12_arg0.WarzoneKillerIdentity:setAlpha(1)
	f12_arg0.ContribText:setAlpha(1)
end
CoD.WZObituaryCalloutExpandedContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.WarzoneKillerIdentity:completeAnimation()
			f14_arg0.WarzoneKillerIdentity:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.WarzoneKillerIdentity)
			f14_arg0.ContribText:completeAnimation()
			f14_arg0.ContribText:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.ContribText)
		end,
	},
}
CoD.WZObituaryCalloutExpandedContainer.__onClose = function(f15_arg0)
	f15_arg0.WarzoneKillerIdentity:close()
	f15_arg0.ContribText:close()
end
