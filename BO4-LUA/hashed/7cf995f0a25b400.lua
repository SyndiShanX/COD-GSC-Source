require("x64:549980abecb1c26")
CoD.Prestige_PrestigeHeader = InheritFrom(LUI.UIElement)
CoD.Prestige_PrestigeHeader.__defaultWidth = 218
CoD.Prestige_PrestigeHeader.__defaultHeight = 20
CoD.Prestige_PrestigeHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_PrestigeHeader)
	self.id = "Prestige_PrestigeHeader"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PrestigeMasterTiers = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	PrestigeMasterTiers:setLeftRight(0, 0, 0, 218)
	PrestigeMasterTiers:setTopBottom(0, 0, 0, 20)
	PrestigeMasterTiers:setWidgetType(CoD.Prestige_PrestigeTierIndicator)
	PrestigeMasterTiers:setHorizontalCount(10)
	PrestigeMasterTiers:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PrestigeMasterTiers:setDataSource("PrestigeMasterTiers")
	PrestigeMasterTiers:subscribeToGlobalModel(f1_arg1, "PrestigeMenuInfo", "hasPrestiged", function(model)
		CoD.GridAndListUtility.UpdateDataSource(PrestigeMasterTiers, false, true, true)
	end)
	self:addElement(PrestigeMasterTiers)
	self.PrestigeMasterTiers = PrestigeMasterTiers
	self:mergeStateConditions({
		{
			stateName = "MasterPrestige",
			condition = function(menu, element, event)
				return IsMaxPrestigeLevel(f1_arg1) and IsInParagonCapableGameMode()
			end,
		},
		{
			stateName = "Prestige",
			condition = function(menu, element, event)
				local f4_local0
				if not IsMaxPrestigeLevel(f1_arg1) then
					f4_local0 = not IsPrestigeLevelAtZero(f1_arg1)
				else
					f4_local0 = false
				end
				return f4_local0
			end,
		},
	})
	PrestigeMasterTiers.id = "PrestigeMasterTiers"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_PrestigeHeader.__resetProperties = function(f5_arg0)
	f5_arg0.PrestigeMasterTiers:completeAnimation()
	f5_arg0.PrestigeMasterTiers:setAlpha(1)
end
CoD.Prestige_PrestigeHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.PrestigeMasterTiers:completeAnimation()
			f6_arg0.PrestigeMasterTiers:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.PrestigeMasterTiers)
		end,
	},
	MasterPrestige = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.PrestigeMasterTiers:completeAnimation()
			f7_arg0.PrestigeMasterTiers:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.PrestigeMasterTiers)
		end,
	},
	Prestige = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.PrestigeMasterTiers:completeAnimation()
			f8_arg0.PrestigeMasterTiers:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PrestigeMasterTiers)
		end,
	},
}
CoD.Prestige_PrestigeHeader.__onClose = function(f9_arg0)
	f9_arg0.PrestigeMasterTiers:close()
end
