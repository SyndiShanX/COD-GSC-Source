require("x64:b1020a5873ba1d6")
CoD.ScoreInfoCTF = InheritFrom(LUI.UIElement)
CoD.ScoreInfoCTF.__defaultWidth = 222
CoD.ScoreInfoCTF.__defaultHeight = 122
CoD.ScoreInfoCTF.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	DataSourceHelperGetModel(f1_arg1, "CTFLevelInfo")
	self:setClass(CoD.ScoreInfoCTF)
	self.id = "ScoreInfoCTF"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0.5, 0.5, -101.5, 101.5, 0.5, 0.5, -27, 27)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Panel = LUI.UIImage.new(0.5, 0.5, -101.5, 101.5, 0.5, 0.5, -27, 27)
	Panel:setRGB(0.18, 0.17, 0.16)
	Panel:setAlpha(0.94)
	self:addElement(Panel)
	self.Panel = Panel
	local LEDFull = LUI.UIImage.new(0.5, 0.5, -110.5, 111.5, 0.5, 0.5, -79, 43)
	LEDFull:setRGB(0, 0, 0)
	LEDFull:setAlpha(0.2)
	LEDFull:setImage(RegisterImage(@"uie_ui_hud_core_objective_widget_led_screen_03"))
	self:addElement(LEDFull)
	self.LEDFull = LEDFull
	local frame = LUI.UIImage.new(0.5, 0.5, -104.5, 104.5, 0.5, 0.5, -30, 30)
	frame:setYRot(180)
	frame:setImage(RegisterImage(@"uie_ui_hud_core_frame_stretchable"))
	frame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	frame:setShaderVector(0, 0, 0, 0, 0)
	frame:setupNineSliceShader(16, 16)
	self:addElement(frame)
	self.frame = frame
	local Divider = LUI.UIImage.new(0.5, 0.5, -100, 100, 0.5, 0.5, -2.5, 2.5)
	Divider:setRGB(0, 0, 0)
	Divider:setImage(RegisterImage(@"hash_5D16B33E79A589C5"))
	Divider:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_blend"))
	self:addElement(Divider)
	self.Divider = Divider
	local flagStateEnemy = CoD.ScoreInfoCTF_FlagState.new(f1_arg0, f1_arg1, 0, 0, 37, 207, 0.5, 0.5, 2, 24)
	flagStateEnemy:mergeStateConditions({
		{
			stateName = "Home",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("CTFLevelInfo.flagStateAxis", 0)
			end,
		},
		{
			stateName = "Away",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("CTFLevelInfo.flagStateAxis", 1)
			end,
		},
	})
	local friendlyflag = flagStateEnemy
	local flagStateFriendly = flagStateEnemy.subscribeToModel
	local enemyflag = Engine[@"getglobalmodel"]()
	flagStateFriendly(friendlyflag, enemyflag["CTFLevelInfo.flagStateAxis"], function(f4_arg0)
		f1_arg0:updateElementState(flagStateEnemy, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "CTFLevelInfo.flagStateAxis",
		})
	end, false)
	flagStateEnemy:subscribeToGlobalModel(f1_arg1, "CTFLevelInfo", "flagCarrierAxis", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			flagStateEnemy.FlagStateText:setText(GetClientName(f1_arg1, f5_local0))
		end
	end)
	self:addElement(flagStateEnemy)
	self.flagStateEnemy = flagStateEnemy
	flagStateFriendly = CoD.ScoreInfoCTF_FlagState.new(f1_arg0, f1_arg1, 0, 0, 37, 207, 0.5, 0.5, -24, -2)
	flagStateFriendly:mergeStateConditions({
		{
			stateName = "Home",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("CTFLevelInfo.flagStateAllies", 0)
			end,
		},
		{
			stateName = "Away",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("CTFLevelInfo.flagStateAllies", 1)
			end,
		},
	})
	enemyflag = flagStateFriendly
	friendlyflag = flagStateFriendly.subscribeToModel
	local f1_local10 = Engine[@"getglobalmodel"]()
	friendlyflag(enemyflag, f1_local10["CTFLevelInfo.flagStateAllies"], function(f8_arg0)
		f1_arg0:updateElementState(flagStateFriendly, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "CTFLevelInfo.flagStateAllies",
		})
	end, false)
	flagStateFriendly:subscribeToGlobalModel(f1_arg1, "CTFLevelInfo", "flagCarrierAllies", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			flagStateFriendly.FlagStateText:setText(GetClientName(f1_arg1, f9_local0))
		end
	end)
	self:addElement(flagStateFriendly)
	self.flagStateFriendly = flagStateFriendly
	friendlyflag = LUI.UIImage.new(0.5, 0.5, -97, -77, 0.5, 0.5, -23, -3)
	friendlyflag.__Color = function()
		friendlyflag:setRGB(GetColorBlindSafeColorFromBase("FriendlyBlue", f1_arg1, ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b))
	end
	friendlyflag.__Color()
	friendlyflag:setImage(RegisterImage(@"uie_ui_icon_waypoints_ctf_flag"))
	self:addElement(friendlyflag)
	self.friendlyflag = friendlyflag
	enemyflag = LUI.UIImage.new(0.5, 0.5, -97, -77, 0.5, 0.5, 2.5, 22.5)
	enemyflag.__Color = function()
		enemyflag:setRGB(GetColorBlindSafeColorFromBase("EnemyOrange_Base", f1_arg1, ColorSet.EnemyOrange_Base.r, ColorSet.EnemyOrange_Base.g, ColorSet.EnemyOrange_Base.b))
	end
	enemyflag.__Color()
	enemyflag:setImage(RegisterImage(@"uie_ui_icon_waypoints_ctf_flag"))
	self:addElement(enemyflag)
	self.enemyflag = enemyflag
	local f1_local11 = friendlyflag
	f1_local10 = friendlyflag.subscribeToModel
	local f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["profile.colorblindMode"], friendlyflag.__Color)
	f1_local11 = enemyflag
	f1_local10 = enemyflag.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["profile.colorblindMode"], enemyflag.__Color)
	self:mergeStateConditions({
		{
			stateName = "CodCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
		{
			stateName = "Axis",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "factions.actualTeam", Enum[@"team_t"][@"team_axis"])
			end,
		},
	})
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["factions.isCoDCaster"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local11 = self
	f1_local10 = self.subscribeToModel
	f1_local12 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local10(f1_local11, f1_local12["factions.actualTeam"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "factions.actualTeam",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfoCTF.__resetProperties = function(f16_arg0)
	f16_arg0.flagStateEnemy:completeAnimation()
	f16_arg0.flagStateFriendly:completeAnimation()
	f16_arg0.flagStateEnemy:setAlpha(1)
	f16_arg0.flagStateFriendly:setAlpha(1)
end
CoD.ScoreInfoCTF.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	CodCaster = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.flagStateEnemy:completeAnimation()
			f18_arg0.clipFinished(f18_arg0.flagStateEnemy)
			f18_arg0.flagStateFriendly:completeAnimation()
			f18_arg0.clipFinished(f18_arg0.flagStateFriendly)
		end,
	},
	Axis = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.flagStateEnemy:completeAnimation()
			f19_arg0.flagStateEnemy:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.flagStateEnemy)
			f19_arg0.flagStateFriendly:completeAnimation()
			f19_arg0.flagStateFriendly:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.flagStateFriendly)
		end,
	},
}
CoD.ScoreInfoCTF.__onClose = function(f20_arg0)
	f20_arg0.flagStateEnemy:close()
	f20_arg0.flagStateFriendly:close()
	f20_arg0.friendlyflag:close()
	f20_arg0.enemyflag:close()
end
