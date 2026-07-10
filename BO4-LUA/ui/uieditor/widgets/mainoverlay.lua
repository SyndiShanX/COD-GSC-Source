require("x64:fa630f1ab8206")
require("x64:f3ca764bd1e6b77")
CoD.MainOverlay = InheritFrom(LUI.UIElement)
CoD.MainOverlay.__defaultWidth = 1920
CoD.MainOverlay.__defaultHeight = 1080
CoD.MainOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	if CoD.DirectorUtility.NeedsWatermark() then
		CoD.BaseUtility.InitGlobalModel("showPreAlphaText", 1)
		CoD.BaseUtility.InitGlobalModel("showBuildInfo", 0)
	else
		CoD.BaseUtility.InitGlobalModel("showPreAlphaText", 0)
		CoD.BaseUtility.InitGlobalModel("showBuildInfo", 0)
	end
	self:setClass(CoD.MainOverlay)
	self.id = "MainOverlay"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BuildInfo = LUI.UIText.new(0.5, 0.5, 608, 955, 0, 0, 29, 50)
	BuildInfo:setAlpha(0.6)
	BuildInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_74D16564DEF246AA"))
	BuildInfo:setTTF("0arame_mono_stencil")
	BuildInfo:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	BuildInfo:setShaderVector(0, 1, 0, 0, 0)
	BuildInfo:setShaderVector(1, 0, 0, 0, 0)
	BuildInfo:setShaderVector(2, 0, 0, 0, 0.5)
	BuildInfo:setLetterSpacing(0.9)
	BuildInfo:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	BuildInfo:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(BuildInfo)
	self.BuildInfo = BuildInfo
	local BuildInfo2 = LUI.UIText.new(0.5, 0.5, 615, 955, 0, 0, 14, 28)
	BuildInfo2:setRGB(0.35, 0.35, 0.35)
	BuildInfo2:setTTF("0arame_mono_stencil")
	BuildInfo2:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	BuildInfo2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	BuildInfo2:linkToElementModel(self, "buildInfo", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BuildInfo2:setText(f2_local0)
		end
	end)
	self:addElement(BuildInfo2)
	self.BuildInfo2 = BuildInfo2
	local BuildInfo3 = LUI.UIText.new(0.5, 0.5, 755, 955, 0, 0, 56, 70)
	BuildInfo3:setRGB(0.47, 0.47, 0.47)
	BuildInfo3:setTTF("0arame_mono_stencil")
	BuildInfo3:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	BuildInfo3:linkToElementModel(self, "hostName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BuildInfo3:setText(f3_local0)
		end
	end)
	self:addElement(BuildInfo3)
	self.BuildInfo3 = BuildInfo3
	local BuildInfo4 = LUI.UIText.new(0.5, 0.5, 755, 955, 0, 0, 75, 89)
	BuildInfo4:setRGB(0.47, 0.47, 0.47)
	BuildInfo4:setTTF("0arame_mono_stencil")
	BuildInfo4:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	BuildInfo4:linkToElementModel(self, "fullBuildNameContext", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BuildInfo4:setText(f4_local0)
		end
	end)
	self:addElement(BuildInfo4)
	self.BuildInfo4 = BuildInfo4
	local PCTelemetryWidget = nil
	PCTelemetryWidget = CoD.PC_PerfStatsContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 40, 0, 0, 3.5, 18.5)
	self:addElement(PCTelemetryWidget)
	self.PCTelemetryWidget = PCTelemetryWidget
	local PCAchievementNotificationContainer = nil
	PCAchievementNotificationContainer = CoD.PC_AchievementNotification_Container.new(f1_arg0, f1_arg1, 0.5, 0.5, 490, 920, 0, 0, 230, 310)
	self:addElement(PCAchievementNotificationContainer)
	self.PCAchievementNotificationContainer = PCAchievementNotificationContainer
	self:mergeStateConditions({
		{
			stateName = "ShowPreAlphaWatermark",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("showPreAlphaText", 1)
			end,
		},
		{
			stateName = "ShowPreAlphaWatermarkAlt",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("showPreAlphaText", 2)
			end,
		},
		{
			stateName = "ShowBuildInfo",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("showBuildInfo", 0)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9.showPreAlphaText, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "showPreAlphaText",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getglobalmodel"]()
	f1_local8(f1_local7, f1_local9.showBuildInfo, function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "showBuildInfo",
		})
	end, false)
	self.__on_menuOpened_self = function(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
		local f10_local0 = self
		if CoD.BaseUtility.IsParameterValueDefined(f10_arg1) and not IsPC() then
			SizeToSafeArea(self, f10_arg1)
		end
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "PC.Achievement.TotalScore", function(model)
		local f11_local0 = self
	end)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	if IsPC() then
		SetModelToGlobalDataSource(f1_arg1, self, "GlobalModel")
	else
		SetModelToGlobalDataSource(f1_arg1, self, "GlobalModel")
	end
	f1_local8 = PCTelemetryWidget
	if IsPC() and IsInGame() then
		SizeToHudArea(f1_local8, f1_arg1)
	end
	return self
end
CoD.MainOverlay.__resetProperties = function(f13_arg0)
	f13_arg0.BuildInfo:completeAnimation()
	f13_arg0.BuildInfo3:completeAnimation()
	f13_arg0.BuildInfo4:completeAnimation()
	f13_arg0.BuildInfo2:completeAnimation()
	f13_arg0.BuildInfo:setTopBottom(0, 0, 29, 50)
	f13_arg0.BuildInfo:setAlpha(0.6)
	f13_arg0.BuildInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_74D16564DEF246AA"))
	f13_arg0.BuildInfo3:setTopBottom(0, 0, 56, 70)
	f13_arg0.BuildInfo4:setTopBottom(0, 0, 75, 89)
	f13_arg0.BuildInfo2:setTopBottom(0, 0, 14, 28)
	f13_arg0.BuildInfo2:setAlpha(1)
end
CoD.MainOverlay.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(4)
			f14_arg0.BuildInfo:completeAnimation()
			f14_arg0.BuildInfo:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BuildInfo)
			f14_arg0.BuildInfo2:completeAnimation()
			f14_arg0.BuildInfo2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.BuildInfo2)
			f14_arg0.BuildInfo3:completeAnimation()
			f14_arg0.BuildInfo3:setTopBottom(0, 0, 38, 52)
			f14_arg0.clipFinished(f14_arg0.BuildInfo3)
			f14_arg0.BuildInfo4:completeAnimation()
			f14_arg0.BuildInfo4:setTopBottom(0, 0, 54, 68)
			f14_arg0.clipFinished(f14_arg0.BuildInfo4)
		end,
	},
	ShowPreAlphaWatermark = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.BuildInfo:completeAnimation()
			f15_arg0.BuildInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_74D16564DEF246AA"))
			f15_arg0.clipFinished(f15_arg0.BuildInfo)
			f15_arg0.BuildInfo3:completeAnimation()
			f15_arg0.BuildInfo3:setTopBottom(0, 0, 77, 91)
			f15_arg0.clipFinished(f15_arg0.BuildInfo3)
			f15_arg0.BuildInfo4:completeAnimation()
			f15_arg0.BuildInfo4:setTopBottom(0, 0, 94, 108)
			f15_arg0.clipFinished(f15_arg0.BuildInfo4)
		end,
	},
	ShowPreAlphaWatermarkAlt = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			f16_arg0.BuildInfo:completeAnimation()
			f16_arg0.BuildInfo:setTopBottom(0, 0, 40, 61)
			f16_arg0.BuildInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_74D16564DEF246AA"))
			f16_arg0.clipFinished(f16_arg0.BuildInfo)
			f16_arg0.BuildInfo2:completeAnimation()
			f16_arg0.BuildInfo2:setTopBottom(0, 0, 4, 18)
			f16_arg0.clipFinished(f16_arg0.BuildInfo2)
			f16_arg0.BuildInfo3:completeAnimation()
			f16_arg0.BuildInfo3:setTopBottom(0, 0, 66, 80)
			f16_arg0.clipFinished(f16_arg0.BuildInfo3)
			f16_arg0.BuildInfo4:completeAnimation()
			f16_arg0.BuildInfo4:setTopBottom(0, 0, 83, 97)
			f16_arg0.clipFinished(f16_arg0.BuildInfo4)
		end,
	},
	ShowBuildInfo = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.BuildInfo:completeAnimation()
			f17_arg0.BuildInfo:setAlpha(0)
			f17_arg0.BuildInfo:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_74D16564DEF246AA"))
			f17_arg0.clipFinished(f17_arg0.BuildInfo)
			f17_arg0.BuildInfo3:completeAnimation()
			f17_arg0.BuildInfo3:setTopBottom(0, 0, 77, 91)
			f17_arg0.clipFinished(f17_arg0.BuildInfo3)
			f17_arg0.BuildInfo4:completeAnimation()
			f17_arg0.BuildInfo4:setTopBottom(0, 0, 94, 108)
			f17_arg0.clipFinished(f17_arg0.BuildInfo4)
		end,
	},
}
CoD.MainOverlay.__onClose = function(f18_arg0)
	f18_arg0.__on_close_removeOverrides()
	f18_arg0.BuildInfo2:close()
	f18_arg0.BuildInfo3:close()
	f18_arg0.BuildInfo4:close()
	f18_arg0.PCTelemetryWidget:close()
	f18_arg0.PCAchievementNotificationContainer:close()
end
