CoD.ScoreboardPlayerWidget = InheritFrom(LUI.UIElement)
CoD.ScoreboardPlayerWidget.__defaultWidth = 86
CoD.ScoreboardPlayerWidget.__defaultHeight = 60
CoD.ScoreboardPlayerWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreboardPlayerWidget)
	self.id = "ScoreboardPlayerWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGBlue = LUI.UIImage.new(0.5, 0.5, -43, 43, 0.5, 0.5, -30, 30)
	BGBlue:setAlpha(0)
	BGBlue:setImage(RegisterImage(@"hash_2ED0AEB8D8F30C1D"))
	BGBlue:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BGBlue:setShaderVector(0, 1, 0, 0, 0)
	BGBlue:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BGBlue:setRGB(f2_local0)
		end
	end)
	self:addElement(BGBlue)
	self.BGBlue = BGBlue
	local BGRed = LUI.UIImage.new(0.5, 0.5, -43, 43, 0.5, 0.5, -30, 30)
	BGRed:setAlpha(0)
	BGRed:setImage(RegisterImage(@"hash_2ED0AEB8D8F30C1D"))
	BGRed:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	BGRed:setShaderVector(0, 1, 0, 0, 0)
	BGRed:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BGRed:setRGB(f3_local0)
		end
	end)
	self:addElement(BGRed)
	self.BGRed = BGRed
	local BGBueSelected = LUI.UIImage.new(0.5, 0.5, -43, 43, 0.5, 0.5, -30, 30)
	BGBueSelected:setAlpha(0)
	BGBueSelected:setImage(RegisterImage(@"hash_773562CFCEF8AD77"))
	BGBueSelected:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BGBueSelected:setRGB(f4_local0)
		end
	end)
	self:addElement(BGBueSelected)
	self.BGBueSelected = BGBueSelected
	local BGBueOverlay = LUI.UIImage.new(0.5, 0.5, -43, 43, 0.5, 0.5, -30, 30)
	BGBueOverlay:setAlpha(0)
	BGBueOverlay:setImage(RegisterImage(@"hash_773562CFCEF8AD77"))
	BGBueOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	BGBueOverlay:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			BGBueOverlay:setRGB(f5_local0)
		end
	end)
	self:addElement(BGBueOverlay)
	self.BGBueOverlay = BGBueOverlay
	local BGRedSelected = LUI.UIImage.new(0.5, 0.5, -43, 43, 0.5, 0.5, -30, 30)
	BGRedSelected:setAlpha(0)
	BGRedSelected:setImage(RegisterImage(@"hash_773562CFCEF8AD77"))
	BGRedSelected:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			BGRedSelected:setRGB(f6_local0)
		end
	end)
	self:addElement(BGRedSelected)
	self.BGRedSelected = BGRedSelected
	local BGRedOverlay = LUI.UIImage.new(0.5, 0.5, -43, 43, 0.5, 0.5, -30, 30)
	BGRedOverlay:setAlpha(0)
	BGRedOverlay:setImage(RegisterImage(@"hash_773562CFCEF8AD77"))
	BGRedOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	BGRedOverlay:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			BGRedOverlay:setRGB(f7_local0)
		end
	end)
	self:addElement(BGRedOverlay)
	self.BGRedOverlay = BGRedOverlay
	local PlayerIcon = LUI.UIImage.new(0, 0, -5, 93, 0, 0, -16.5, 69.5)
	PlayerIcon:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	PlayerIcon:setShaderVector(0, 0.05, 0.93, 0, 0)
	PlayerIcon:setShaderVector(1, 0, 0, 0, 0)
	PlayerIcon:setShaderVector(2, 0.19, 0.89, 0, 0)
	PlayerIcon:setShaderVector(3, 0, 0, 0, 0)
	PlayerIcon:setShaderVector(4, 0, 0, 0, 0)
	PlayerIcon:linkToElementModel(self, "scoreboard.characterIndex", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			PlayerIcon:setImage(RegisterImage(GetPositionDraftIconByIndex(f8_local0)))
		end
	end)
	self:addElement(PlayerIcon)
	self.PlayerIcon = PlayerIcon
	self:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return IsSelfClient(f1_arg1, element) and not IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "Enemy",
			condition = function(menu, element, event)
				local f10_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualToSelfTeam(element, f1_arg1, "team") then
					f10_local0 = not IsCodCaster(f1_arg1)
				else
					f10_local0 = false
				end
				return f10_local0
			end,
		},
		{
			stateName = "CodcasterTeam1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "team", Enum[@"team_t"][@"team_allies"]) and IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "CodcasterTeam2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "team", Enum[@"team_t"][@"team_axis"]) and IsCodCaster(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["factions.isCoDCaster"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	self:linkToElementModel(self, "team", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreboardPlayerWidget.__resetProperties = function(f16_arg0)
	f16_arg0.BGBlue:completeAnimation()
	f16_arg0.BGRed:completeAnimation()
	f16_arg0.BGBlue:setAlpha(0)
	f16_arg0.BGRed:setAlpha(0)
end
CoD.ScoreboardPlayerWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.BGBlue:completeAnimation()
			f17_arg0.BGBlue:setAlpha(0.75)
			f17_arg0.clipFinished(f17_arg0.BGBlue)
		end,
	},
	Self = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.BGBlue:completeAnimation()
			f18_arg0.BGBlue:setAlpha(0.75)
			f18_arg0.clipFinished(f18_arg0.BGBlue)
		end,
	},
	Enemy = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.BGRed:completeAnimation()
			f19_arg0.BGRed:setAlpha(0.75)
			f19_arg0.clipFinished(f19_arg0.BGRed)
		end,
	},
	CodcasterTeam1 = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.BGBlue:completeAnimation()
			f20_arg0.BGBlue:setAlpha(0.75)
			f20_arg0.clipFinished(f20_arg0.BGBlue)
		end,
	},
	CodcasterTeam2 = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.BGRed:completeAnimation()
			f21_arg0.BGRed:setAlpha(0.75)
			f21_arg0.clipFinished(f21_arg0.BGRed)
		end,
	},
}
CoD.ScoreboardPlayerWidget.__onClose = function(f22_arg0)
	f22_arg0.BGBlue:close()
	f22_arg0.BGRed:close()
	f22_arg0.BGBueSelected:close()
	f22_arg0.BGBueOverlay:close()
	f22_arg0.BGRedSelected:close()
	f22_arg0.BGRedOverlay:close()
	f22_arg0.PlayerIcon:close()
end
