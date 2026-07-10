CoD.PlayerListRowKillandDeathValue = InheritFrom(LUI.UIElement)
CoD.PlayerListRowKillandDeathValue.__defaultWidth = 95
CoD.PlayerListRowKillandDeathValue.__defaultHeight = 15
CoD.PlayerListRowKillandDeathValue.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerListRowKillandDeathValue)
	self.id = "PlayerListRowKillandDeathValue"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Score01 = LUI.UIText.new(0, 0, 0, 95, 0.5, 0.5, -7.5, 7.5)
	Score01:setTTF("0arame_mono_stencil")
	Score01:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Score01:linkToElementModel(self, "clientNumScoreInfoUpdated", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Score01:setText(GetCodcasterPlayerListKD(f1_arg1, f2_local0))
		end
	end)
	self:addElement(Score01)
	self.Score01 = Score01
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerListRowKillandDeathValue.__resetProperties = function(f4_arg0)
	f4_arg0.Score01:completeAnimation()
	f4_arg0.Score01:setTopBottom(0.5, 0.5, -7.5, 7.5)
end
CoD.PlayerListRowKillandDeathValue.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Score01:completeAnimation()
			f6_arg0.Score01:setTopBottom(0.5, 0.5, -2.5, 7.5)
			f6_arg0.clipFinished(f6_arg0.Score01)
		end,
	},
}
CoD.PlayerListRowKillandDeathValue.__onClose = function(f7_arg0)
	f7_arg0.Score01:close()
end
