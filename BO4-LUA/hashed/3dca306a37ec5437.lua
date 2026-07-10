require("x64:32217f7a5e6303f")
require("x64:8f041fd60423e1d")
CoD.WZCollapseTimerInternal = InheritFrom(LUI.UIElement)
CoD.WZCollapseTimerInternal.__defaultWidth = 1920
CoD.WZCollapseTimerInternal.__defaultHeight = 1080
CoD.WZCollapseTimerInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZCollapseTimerInternal)
	self.id = "WZCollapseTimerInternal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blur = LUI.UIImage.new(0, 0, -6, 145, 0, 0, 346.5, 384.5)
	blur:setAlpha(0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local bg = LUI.UIImage.new(0, 0, -6, 145, 0, 0, 346.5, 384.5)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0)
	self:addElement(bg)
	self.bg = bg
	local led = LUI.UIImage.new(0, 0, -9, 283, 0, 0, 344.5, 384.5)
	led:setAlpha(0)
	led:setImage(RegisterImage(0xC07F7432F86DA83))
	led:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	led:setShaderVector(0, 0, 0.5, 0, 0)
	led:setShaderVector(1, 0, 0, 0, 0)
	led:setShaderVector(2, 0, 1, 0, 0)
	led:setShaderVector(3, 0, 0, 0, 0)
	led:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(led)
	self.led = led
	local border = LUI.UIImage.new(0, 0, -12, 151, 0, 0, 342, 388)
	border:setRGB(0.07, 0.07, 0.07)
	border:setAlpha(0)
	border:setImage(RegisterImage(0xA3C76B80B69874D))
	border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	border:setShaderVector(0, 0, 0, 0, 0)
	border:setupNineSliceShader(18, 24)
	self:addElement(border)
	self.border = border
	local meterBacking = LUI.UIImage.new(0, 0, 4, 271, 0, 0, 357, 373)
	meterBacking:setRGB(0, 0, 0)
	meterBacking:setAlpha(0)
	meterBacking:setImage(RegisterImage(0x3674F9B5EAEF4ED))
	meterBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	meterBacking:setShaderVector(0, 0.01, 0.02, 0.01, 0.02)
	self:addElement(meterBacking)
	self.meterBacking = meterBacking
	local SplashBig = LUI.UIImage.new(0.5, 0.5, -82, 82, 0, 0, 309, 365)
	SplashBig:setRGB(0, 0, 0)
	SplashBig:setAlpha(0)
	SplashBig:setScale(2, 1.2)
	SplashBig:setImage(RegisterImage(0xEDC08FCAC068A90))
	SplashBig:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	SplashBig:setShaderVector(0, 0, 1, 0, 0)
	SplashBig:setShaderVector(1, 0.25, 0.25, 0, 0)
	SplashBig:setShaderVector(2, 0, 1, 0, 0)
	SplashBig:setShaderVector(3, 0, 0, 0, 0)
	SplashBig:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(SplashBig)
	self.SplashBig = SplashBig
	local Timer = LUI.UIText.new(0.5, 0.5, -35, 235, 0, 0, 313, 361)
	Timer:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Timer:setTTF("0arame_mono_stencil")
	Timer:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Timer:setShaderVector(0, 1, 0, 0, 0)
	Timer:setShaderVector(1, 1, 0, 0, 0)
	Timer:setShaderVector(2, 1, 1, 1, 0.2)
	Timer:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Timer:subscribeToGlobalModel(f1_arg1, "BombTimer", "bomb0.timeRemainingMilliSec", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Timer:setText(SecondsAsTime(StringMultiply(0, StringAdd(0, f2_local0))))
		end
	end)
	self:addElement(Timer)
	self.Timer = Timer
	local TimerDownButNotOut = LUI.UIText.new(0, 0, 55, 325, 0, 0, 351.5, 381.5)
	TimerDownButNotOut:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TimerDownButNotOut:setAlpha(0)
	TimerDownButNotOut:setTTF("0arame_mono_stencil")
	TimerDownButNotOut:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	TimerDownButNotOut:setShaderVector(0, 1, 0, 0, 0)
	TimerDownButNotOut:setShaderVector(1, 1, 0, 0, 0)
	TimerDownButNotOut:setShaderVector(2, 1, 1, 1, 0.2)
	TimerDownButNotOut:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TimerDownButNotOut:setEndTimerUsePartialSeconds(false)
	TimerDownButNotOut:subscribeToGlobalModel(f1_arg1, "WarzoneGlobal", "collapse", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TimerDownButNotOut:setupEndTimer(f3_local0)
		end
	end)
	self:addElement(TimerDownButNotOut)
	self.TimerDownButNotOut = TimerDownButNotOut
	local Icon = LUI.UIImage.new(0.5, 0.5, -83, -43, 0, 0, 317, 357)
	Icon:setImage(RegisterImage(0x7CBAC810FA58FD7))
	self:addElement(Icon)
	self.Icon = Icon
	local notch = LUI.UIImage.new(0, 0, 4, 12, 0, 0, 359, 371)
	notch:setAlpha(0)
	notch:setImage(RegisterImage(0xF28809D529EB156))
	notch:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	notch:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(notch)
	self.notch = notch
	local meterFill = CoD.WarzoneCollapseProgress.new(f1_arg0, f1_arg1, 0, 0, 9, 269, 0, 0, 361, 369)
	self:addElement(meterFill)
	self.meterFill = meterFill
	local highlight2 = LUI.UIImage.new(0.5, 0.5, -153, 153, 0, 0, 200.5, 485.5)
	highlight2:setRGB(0, 0.1, 1)
	highlight2:setScale(0, 0)
	highlight2:setImage(RegisterImage(0x4A1176ABBF1AB4C))
	highlight2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	highlight2:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(highlight2)
	self.highlight2 = highlight2
	local highlight = LUI.UIImage.new(0.5, 0.5, -193, 193, 0, 0, 137, 537)
	highlight:setRGB(0.01, 0.32, 0.66)
	highlight:setAlpha(0)
	highlight:setZRot(360)
	highlight:setScale(1.96, 0.4)
	highlight:setImage(RegisterImage(0x4A1176ABBF1AB4C))
	highlight:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	highlight:setShaderVector(0, 3, 0, 0, 0)
	self:addElement(highlight)
	self.highlight = highlight
	local Message = LUI.UIText.new(0, 0, -2, 206, 0, 0, 352, 379)
	Message:setRGB(0, 0.56, 1)
	Message:setAlpha(0)
	Message:setText(Engine[0xF9F1239CFD921FE](0xD22DE36990C6974))
	Message:setTTF("ttmussels_regular")
	Message:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Message:setShaderVector(0, 1.02, 0, 0, 0)
	Message:setShaderVector(1, -0.23, 0, 0, 0)
	Message:setShaderVector(2, 0, 0, 1, 1)
	Message:setLetterSpacing(2)
	Message:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	Message:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7]))
	self:addElement(Message)
	self.Message = Message
	local EMP = CoD.Warzone_EMP_Status.new(f1_arg0, f1_arg1, 0, 0, -20, 296, 0, 0, 328.5, 416.5)
	self:addElement(EMP)
	self.EMP = EMP
	self:mergeStateConditions({
		{
			stateName = "DownButNotOut",
			condition = function(menu, element, event)
				local f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
				if f4_local0 then
					f4_local0 = IsGametypeSettingsValue("deathCircleRespawn", 1)
					if f4_local0 then
						if not CoD.WZUtility.IsSpectatingEnemy(f1_arg1) and not CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.warzone.reinsertionPassengerCount", 0) then
							f4_local0 = CoD.WZUtility.AnyReinsertionsRemaining(f1_arg1)
						else
							f4_local0 = false
						end
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "LowTimeRemainingWarning",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueLessThan("bombTimer.bomb0.timeRemainingMilliSec", 15000) and CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneGlobal", "collapseTimerState", CoD.WZUtility.CollapseTimerState.WARNING)
			end,
		},
		{
			stateName = "Warning",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneGlobal", "collapseTimerState", CoD.WZUtility.CollapseTimerState.WARNING)
			end,
		},
		{
			stateName = "Collapsing",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "WarzoneGlobal", "collapseTimerState", CoD.WZUtility.CollapseTimerState.COLLAPSING)
			end,
		},
		{
			stateName = "InfiltrationVehicle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1) and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
			end,
		},
	})
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	self:appendEventHandler("deadSpectator.playerIndex", function(f10_arg0, f10_arg1)
		f10_arg1.menu = f10_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f10_arg1)
	end)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local17(f1_local16, f1_local18["hudItems.warzone.reinsertionPassengerCount"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "hudItems.warzone.reinsertionPassengerCount",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local17(f1_local16, f1_local18["hudItems.warzone.collapseCount"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "hudItems.warzone.collapseCount",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local17(f1_local16, f1_local18["hudItems.warzone.reinsertionIndex"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "hudItems.warzone.reinsertionIndex",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["hudItems.playerCanRedeploy"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "hudItems.playerCanRedeploy",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x8DF2E5447F384B9]()
	f1_local17(f1_local16, f1_local18["bombTimer.bomb0.timeRemainingMilliSec"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "bombTimer.bomb0.timeRemainingMilliSec",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = DataSources.WarzoneGlobal.getModel(f1_arg1)
	f1_local17(f1_local16, f1_local18.collapseTimerState, function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "collapseTimerState",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["hudItems.infiltrationVehicle"], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "hudItems.infiltrationVehicle",
		})
	end, false)
	f1_local16 = self
	f1_local17 = self.subscribeToModel
	f1_local18 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local17(f1_local16, f1_local18["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZCollapseTimerInternal.__resetProperties = function(f19_arg0)
	f19_arg0.Timer:completeAnimation()
	f19_arg0.Icon:completeAnimation()
	f19_arg0.meterFill:completeAnimation()
	f19_arg0.blur:completeAnimation()
	f19_arg0.meterBacking:completeAnimation()
	f19_arg0.bg:completeAnimation()
	f19_arg0.border:completeAnimation()
	f19_arg0.notch:completeAnimation()
	f19_arg0.SplashBig:completeAnimation()
	f19_arg0.EMP:completeAnimation()
	f19_arg0.highlight2:completeAnimation()
	f19_arg0.highlight:completeAnimation()
	f19_arg0.led:completeAnimation()
	f19_arg0.TimerDownButNotOut:completeAnimation()
	f19_arg0.Message:completeAnimation()
	f19_arg0.Timer:setLeftRight(0.5, 0.5, -35, 235)
	f19_arg0.Timer:setTopBottom(0, 0, 313, 361)
	f19_arg0.Timer:setAlpha(1)
	f19_arg0.Icon:setLeftRight(0.5, 0.5, -83, -43)
	f19_arg0.Icon:setTopBottom(0, 0, 317, 357)
	f19_arg0.Icon:setAlpha(1)
	f19_arg0.Icon:setScale(1, 1)
	f19_arg0.meterFill:setAlpha(1)
	f19_arg0.blur:setLeftRight(0, 0, -6, 145)
	f19_arg0.blur:setAlpha(0)
	f19_arg0.meterBacking:setLeftRight(0, 0, 4, 271)
	f19_arg0.meterBacking:setAlpha(0)
	f19_arg0.bg:setLeftRight(0, 0, -6, 145)
	f19_arg0.bg:setAlpha(0)
	f19_arg0.border:setLeftRight(0, 0, -12, 151)
	f19_arg0.border:setAlpha(0)
	f19_arg0.notch:setLeftRight(0, 0, 4, 12)
	f19_arg0.notch:setAlpha(0)
	f19_arg0.SplashBig:setLeftRight(0.5, 0.5, -82, 82)
	f19_arg0.SplashBig:setAlpha(0)
	f19_arg0.SplashBig:setScale(2, 1.2)
	f19_arg0.SplashBig:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	f19_arg0.SplashBig:setShaderVector(0, 0, 1, 0, 0)
	f19_arg0.SplashBig:setShaderVector(1, 0.25, 0.25, 0, 0)
	f19_arg0.SplashBig:setShaderVector(2, 0, 1, 0, 0)
	f19_arg0.SplashBig:setShaderVector(3, 0, 0, 0, 0)
	f19_arg0.SplashBig:setShaderVector(4, 0, 0, 0, 0)
	f19_arg0.EMP:setLeftRight(0, 0, -20, 296)
	f19_arg0.EMP:setAlpha(1)
	f19_arg0.highlight2:setAlpha(1)
	f19_arg0.highlight2:setScale(0, 0)
	f19_arg0.highlight:setAlpha(0)
	f19_arg0.highlight:setScale(1.96, 0.4)
	f19_arg0.led:setAlpha(0)
	f19_arg0.led:setShaderVector(0, 0, 0.5, 0, 0)
	f19_arg0.led:setShaderVector(1, 0, 0, 0, 0)
	f19_arg0.led:setShaderVector(2, 0, 1, 0, 0)
	f19_arg0.led:setShaderVector(3, 0, 0, 0, 0)
	f19_arg0.led:setShaderVector(4, 0, 0, 0, 0)
	f19_arg0.TimerDownButNotOut:setLeftRight(0, 0, 55, 325)
	f19_arg0.TimerDownButNotOut:setTopBottom(0, 0, 351.5, 381.5)
	f19_arg0.TimerDownButNotOut:setAlpha(0)
	f19_arg0.Message:setLeftRight(0, 0, -2, 206)
	f19_arg0.Message:setTopBottom(0, 0, 352, 379)
	f19_arg0.Message:setAlpha(0)
end
CoD.WZCollapseTimerInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(10)
			f20_arg0.blur:completeAnimation()
			f20_arg0.blur:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.blur)
			f20_arg0.bg:completeAnimation()
			f20_arg0.bg:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.bg)
			f20_arg0.border:completeAnimation()
			f20_arg0.border:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.border)
			f20_arg0.meterBacking:completeAnimation()
			f20_arg0.meterBacking:setLeftRight(-0.01, -0.01, 25, 324)
			f20_arg0.meterBacking:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.meterBacking)
			f20_arg0.SplashBig:completeAnimation()
			f20_arg0.SplashBig:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.SplashBig)
			f20_arg0.Timer:completeAnimation()
			f20_arg0.Timer:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Timer)
			f20_arg0.Icon:completeAnimation()
			f20_arg0.Icon:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Icon)
			f20_arg0.notch:completeAnimation()
			f20_arg0.notch:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.notch)
			f20_arg0.meterFill:completeAnimation()
			f20_arg0.meterFill:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.meterFill)
			f20_arg0.EMP:completeAnimation()
			f20_arg0.EMP:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.EMP)
		end,
		Warning = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(12)
			local f21_local0 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(309)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.blur:beginAnimation(3470)
				f21_arg0.blur:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.blur:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f21_arg0.blur:completeAnimation()
			f21_arg0.blur:setLeftRight(0, 0, -6, 145)
			f21_arg0.blur:setAlpha(0)
			f21_local0(f21_arg0.blur)
			local f21_local1 = function(f24_arg0)
				f24_arg0:beginAnimation(309)
				f24_arg0:setAlpha(0.8)
				f24_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.bg:beginAnimation(3470)
			f21_arg0.bg:setLeftRight(0, 0, -6, 145)
			f21_arg0.bg:setAlpha(0)
			f21_arg0.bg:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.bg:registerEventHandler("transition_complete_keyframe", f21_local1)
			local f21_local2 = function(f25_arg0)
				f25_arg0:beginAnimation(309)
				f25_arg0:setAlpha(1)
				f25_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.border:beginAnimation(3470)
			f21_arg0.border:setLeftRight(0, 0, -12, 151)
			f21_arg0.border:setAlpha(0)
			f21_arg0.border:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.border:registerEventHandler("transition_complete_keyframe", f21_local2)
			f21_arg0.meterBacking:completeAnimation()
			f21_arg0.meterBacking:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.meterBacking)
			local f21_local3 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						f28_arg0:beginAnimation(119)
						f28_arg0:setAlpha(0)
						f28_arg0:setShaderVector(0, 0.5, 0.5, 0, 0)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
					end
					f27_arg0:beginAnimation(2810)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f26_arg0:beginAnimation(200)
				f26_arg0:setShaderVector(0, 0, 1, 0, 0)
				f26_arg0:setShaderVector(1, 0.25, 0.25, 0, 0)
				f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f21_arg0.SplashBig:beginAnimation(240)
			f21_arg0.SplashBig:setLeftRight(0.5, 0.5, -82, 82)
			f21_arg0.SplashBig:setAlpha(1)
			f21_arg0.SplashBig:setScale(2, 1.2)
			f21_arg0.SplashBig:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f21_arg0.SplashBig:setShaderVector(0, 0.5, 0.5, 0, 0)
			f21_arg0.SplashBig:setShaderVector(1, 0.5, 0.5, 0, 0)
			f21_arg0.SplashBig:setShaderVector(2, 0, 1, 0, 0)
			f21_arg0.SplashBig:setShaderVector(3, 0, 0, 0, 0)
			f21_arg0.SplashBig:setShaderVector(4, 0, 0, 0, 0)
			f21_arg0.SplashBig:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.SplashBig:registerEventHandler("transition_complete_keyframe", f21_local3)
			local f21_local4 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						local f31_local0 = function(f32_arg0)
							local f32_local0 = function(f33_arg0)
								local f33_local0 = function(f34_arg0)
									local f34_local0 = function(f35_arg0)
										local f35_local0 = function(f36_arg0)
											local f36_local0 = function(f37_arg0)
												local f37_local0 = function(f38_arg0)
													local f38_local0 = function(f39_arg0)
														local f39_local0 = function(f40_arg0)
															local f40_local0 = function(f41_arg0)
																local f41_local0 = function(f42_arg0)
																	local f42_local0 = function(f43_arg0)
																		f43_arg0:beginAnimation(59)
																		f43_arg0:setAlpha(1)
																		f43_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
																	end
																	f42_arg0:beginAnimation(59)
																	f42_arg0:setAlpha(0)
																	f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
																end
																f41_arg0:beginAnimation(60)
																f41_arg0:setAlpha(1)
																f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
															end
															f40_arg0:beginAnimation(59)
															f40_arg0:setAlpha(0)
															f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
														end
														f39_arg0:beginAnimation(69)
														f39_arg0:setAlpha(1)
														f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
													end
													f38_arg0:beginAnimation(100)
													f38_arg0:setLeftRight(0, 0, 55, 325)
													f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
												end
												f37_arg0:beginAnimation(29)
												f37_arg0:setAlpha(0)
												f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
											end
											f36_arg0:beginAnimation(39)
											f36_arg0:setAlpha(1)
											f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
										end
										f35_arg0:beginAnimation(49)
										f35_arg0:setAlpha(0)
										f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
									end
									f34_arg0:beginAnimation(2610)
									f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
								end
								f33_arg0:beginAnimation(69)
								f33_arg0:setAlpha(1)
								f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
							end
							f32_arg0:beginAnimation(69)
							f32_arg0:setAlpha(0)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
						end
						f31_arg0:beginAnimation(90)
						f31_arg0:setAlpha(1)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(99)
					f30_arg0:setAlpha(0)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f29_arg0:beginAnimation(70)
				f29_arg0:setAlpha(1)
				f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f21_arg0.Timer:beginAnimation(240)
			f21_arg0.Timer:setLeftRight(0.5, 0.5, -35, 235)
			f21_arg0.Timer:setAlpha(0)
			f21_arg0.Timer:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.Timer:registerEventHandler("transition_complete_keyframe", f21_local4)
			local f21_local5 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					local f45_local0 = function(f46_arg0)
						local f46_local0 = function(f47_arg0)
							local f47_local0 = function(f48_arg0)
								local f48_local0 = function(f49_arg0)
									local f49_local0 = function(f50_arg0)
										local f50_local0 = function(f51_arg0)
											local f51_local0 = function(f52_arg0)
												local f52_local0 = function(f53_arg0)
													local f53_local0 = function(f54_arg0)
														local f54_local0 = function(f55_arg0)
															local f55_local0 = function(f56_arg0)
																local f56_local0 = function(f57_arg0)
																	local f57_local0 = function(f58_arg0)
																		local f58_local0 = function(f59_arg0)
																			f59_arg0:beginAnimation(59)
																			f59_arg0:setAlpha(1)
																			f59_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
																		end
																		f58_arg0:beginAnimation(59)
																		f58_arg0:setAlpha(0)
																		f58_arg0:registerEventHandler("transition_complete_keyframe", f58_local0)
																	end
																	f57_arg0:beginAnimation(60)
																	f57_arg0:setAlpha(1)
																	f57_arg0:registerEventHandler("transition_complete_keyframe", f57_local0)
																end
																f56_arg0:beginAnimation(59)
																f56_arg0:setAlpha(0)
																f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
															end
															f55_arg0:beginAnimation(69)
															f55_arg0:setAlpha(1)
															f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
														end
														f54_arg0:beginAnimation(69)
														f54_arg0:setLeftRight(0, 0, 7, 47)
														f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
													end
													f53_arg0:beginAnimation(30)
													f53_arg0:setLeftRight(0.35, 0.35, -56, -16)
													f53_arg0:setScale(0.7, 0.7)
													f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
												end
												f52_arg0:beginAnimation(29)
												f52_arg0:setAlpha(0)
												f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
											end
											f51_arg0:beginAnimation(39)
											f51_arg0:setAlpha(1)
											f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
										end
										f50_arg0:beginAnimation(49)
										f50_arg0:setAlpha(0)
										f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
									end
									f49_arg0:beginAnimation(2610)
									f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
								end
								f48_arg0:beginAnimation(69)
								f48_arg0:setAlpha(1)
								f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
							end
							f47_arg0:beginAnimation(69)
							f47_arg0:setAlpha(0)
							f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
						end
						f46_arg0:beginAnimation(90)
						f46_arg0:setAlpha(1)
						f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
					end
					f45_arg0:beginAnimation(99)
					f45_arg0:setAlpha(0)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
				end
				f44_arg0:beginAnimation(70)
				f44_arg0:setAlpha(1)
				f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f21_arg0.Icon:beginAnimation(240)
			f21_arg0.Icon:setLeftRight(0.5, 0.5, -83, -43)
			f21_arg0.Icon:setAlpha(0)
			f21_arg0.Icon:setScale(1, 1)
			f21_arg0.Icon:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.Icon:registerEventHandler("transition_complete_keyframe", f21_local5)
			f21_arg0.notch:completeAnimation()
			f21_arg0.notch:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.notch)
			f21_arg0.meterFill:completeAnimation()
			f21_arg0.meterFill:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.meterFill)
			local f21_local6 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					f61_arg0:beginAnimation(170)
					f61_arg0:setScale(0, 0)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
				end
				f21_arg0.highlight2:beginAnimation(160)
				f21_arg0.highlight2:setScale(1.9, 1.6)
				f21_arg0.highlight2:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.highlight2:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f21_arg0.highlight2:completeAnimation()
			f21_arg0.highlight2:setAlpha(1)
			f21_arg0.highlight2:setScale(0, 0)
			f21_local6(f21_arg0.highlight2)
			local f21_local7 = function(f62_arg0)
				local f62_local0 = function(f63_arg0)
					local f63_local0 = function(f64_arg0)
						f64_arg0:beginAnimation(30)
						f64_arg0:setScale(1.96, 0.4)
						f64_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
					end
					f63_arg0:beginAnimation(100)
					f63_arg0:setAlpha(0)
					f63_arg0:setScale(1.85, 0.35)
					f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
				end
				f21_arg0.highlight:beginAnimation(120)
				f21_arg0.highlight:setScale(1.46, 0.19)
				f21_arg0.highlight:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.highlight:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f21_arg0.highlight:completeAnimation()
			f21_arg0.highlight:setAlpha(1)
			f21_arg0.highlight:setScale(1, 0)
			f21_local7(f21_arg0.highlight)
			local f21_local8 = function(f65_arg0)
				f65_arg0:beginAnimation(99)
				f65_arg0:setAlpha(1)
				f65_arg0:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.EMP:beginAnimation(3470)
			f21_arg0.EMP:setLeftRight(0, 0, -12, 151)
			f21_arg0.EMP:setAlpha(0)
			f21_arg0.EMP:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
			f21_arg0.EMP:registerEventHandler("transition_complete_keyframe", f21_local8)
		end,
	},
	DownButNotOut = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(11)
			f66_arg0.blur:completeAnimation()
			f66_arg0.blur:setLeftRight(0, 0, -6, 262)
			f66_arg0.blur:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.blur)
			f66_arg0.bg:completeAnimation()
			f66_arg0.bg:setLeftRight(0, 0, -6, 286)
			f66_arg0.bg:setAlpha(0.8)
			f66_arg0.clipFinished(f66_arg0.bg)
			f66_arg0.led:completeAnimation()
			f66_arg0.led:setAlpha(0.02)
			f66_arg0.led:setShaderVector(0, 0, 1, 0, 0)
			f66_arg0.led:setShaderVector(1, 0, 0, 0, 0)
			f66_arg0.led:setShaderVector(2, 0, 1, 0, 0)
			f66_arg0.led:setShaderVector(3, 0, 0, 0, 0)
			f66_arg0.led:setShaderVector(4, 0, 0, 0, 0)
			f66_arg0.clipFinished(f66_arg0.led)
			f66_arg0.border:completeAnimation()
			f66_arg0.border:setLeftRight(0, 0, -12, 292)
			f66_arg0.border:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.border)
			f66_arg0.meterBacking:completeAnimation()
			f66_arg0.meterBacking:setLeftRight(-0.01, -0.01, 26, 315)
			f66_arg0.meterBacking:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.meterBacking)
			f66_arg0.Timer:completeAnimation()
			f66_arg0.Timer:setLeftRight(0, 0, 55, 325)
			f66_arg0.Timer:setTopBottom(0, 0, 351.5, 381.5)
			f66_arg0.Timer:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.Timer)
			f66_arg0.TimerDownButNotOut:completeAnimation()
			f66_arg0.TimerDownButNotOut:setLeftRight(0, 0, 210, 288)
			f66_arg0.TimerDownButNotOut:setTopBottom(0, 0, 350.5, 380.5)
			f66_arg0.TimerDownButNotOut:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.TimerDownButNotOut)
			f66_arg0.Icon:completeAnimation()
			f66_arg0.Icon:setLeftRight(0, 0, 7, 47)
			f66_arg0.Icon:setTopBottom(0, 0, 345.5, 385.5)
			f66_arg0.Icon:setAlpha(0)
			f66_arg0.Icon:setScale(0.7, 0.7)
			f66_arg0.clipFinished(f66_arg0.Icon)
			f66_arg0.notch:completeAnimation()
			f66_arg0.notch:setLeftRight(0, 0, -2, 6)
			f66_arg0.notch:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.notch)
			f66_arg0.meterFill:completeAnimation()
			f66_arg0.meterFill:setAlpha(0)
			f66_arg0.clipFinished(f66_arg0.meterFill)
			f66_arg0.Message:completeAnimation()
			f66_arg0.Message:setLeftRight(0, 0, -2, 201)
			f66_arg0.Message:setTopBottom(0, 0, 352, 378)
			f66_arg0.Message:setAlpha(1)
			f66_arg0.clipFinished(f66_arg0.Message)
		end,
	},
	LowTimeRemainingWarning = {
		DefaultClip = function(f67_arg0, f67_arg1)
			f67_arg0:__resetProperties()
			f67_arg0:setupElementClipCounter(10)
			f67_arg0.blur:completeAnimation()
			f67_arg0.blur:setLeftRight(0, 0, -6, 145)
			f67_arg0.blur:setAlpha(1)
			f67_arg0.clipFinished(f67_arg0.blur)
			f67_arg0.bg:completeAnimation()
			f67_arg0.bg:setLeftRight(0, 0, -6, 145)
			f67_arg0.bg:setAlpha(0.8)
			f67_arg0.clipFinished(f67_arg0.bg)
			f67_arg0.led:completeAnimation()
			f67_arg0.led:setAlpha(0.02)
			f67_arg0.led:setShaderVector(0, 0, 0.53, 0, 0)
			f67_arg0.led:setShaderVector(1, 0, 0, 0, 0)
			f67_arg0.led:setShaderVector(2, 0, 1, 0, 0)
			f67_arg0.led:setShaderVector(3, 0, 0, 0, 0)
			f67_arg0.led:setShaderVector(4, 0, 0, 0, 0)
			f67_arg0.clipFinished(f67_arg0.led)
			f67_arg0.border:completeAnimation()
			f67_arg0.border:setLeftRight(0, 0, -12, 151)
			f67_arg0.border:setAlpha(1)
			f67_arg0.clipFinished(f67_arg0.border)
			f67_arg0.meterBacking:completeAnimation()
			f67_arg0.meterBacking:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.meterBacking)
			f67_arg0.Timer:completeAnimation()
			f67_arg0.Timer:setLeftRight(0, 0, 55, 325)
			f67_arg0.Timer:setTopBottom(0, 0, 351.5, 381.5)
			f67_arg0.clipFinished(f67_arg0.Timer)
			f67_arg0.Icon:completeAnimation()
			f67_arg0.Icon:setLeftRight(0, 0, 7, 47)
			f67_arg0.Icon:setTopBottom(0, 0, 345.5, 385.5)
			f67_arg0.Icon:setScale(0.7, 0.7)
			f67_arg0.clipFinished(f67_arg0.Icon)
			f67_arg0.notch:completeAnimation()
			f67_arg0.notch:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.notch)
			f67_arg0.meterFill:completeAnimation()
			f67_arg0.meterFill:setAlpha(0)
			f67_arg0.clipFinished(f67_arg0.meterFill)
			f67_arg0.EMP:completeAnimation()
			f67_arg0.EMP:setLeftRight(0, 0, -12, 151)
			f67_arg0.clipFinished(f67_arg0.EMP)
		end,
		Collapsing = function(f68_arg0, f68_arg1)
			f68_arg0:__resetProperties()
			f68_arg0:setupElementClipCounter(10)
			local f68_local0 = function(f69_arg0)
				local f69_local0 = function(f70_arg0)
					f70_arg0:beginAnimation(200)
					f70_arg0:setLeftRight(0, 0, -6, 285)
					f70_arg0:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
				end
				f68_arg0.blur:beginAnimation(200)
				f68_arg0.blur:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.blur:registerEventHandler("transition_complete_keyframe", f69_local0)
			end
			f68_arg0.blur:completeAnimation()
			f68_arg0.blur:setLeftRight(0, 0, -6, 145)
			f68_arg0.blur:setAlpha(1)
			f68_local0(f68_arg0.blur)
			local f68_local1 = function(f71_arg0)
				local f71_local0 = function(f72_arg0)
					f72_arg0:beginAnimation(200)
					f72_arg0:setLeftRight(0, 0, -6, 285)
					f72_arg0:setAlpha(1)
					f72_arg0:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
				end
				f68_arg0.bg:beginAnimation(200)
				f68_arg0.bg:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.bg:registerEventHandler("transition_complete_keyframe", f71_local0)
			end
			f68_arg0.bg:completeAnimation()
			f68_arg0.bg:setLeftRight(0, 0, -6, 145)
			f68_arg0.bg:setAlpha(0.8)
			f68_local1(f68_arg0.bg)
			local f68_local2 = function(f73_arg0)
				local f73_local0 = function(f74_arg0)
					f74_arg0:beginAnimation(200)
					f74_arg0:setShaderVector(0, 0, 1, 0, 0)
					f74_arg0:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
				end
				f68_arg0.led:beginAnimation(200)
				f68_arg0.led:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.led:registerEventHandler("transition_complete_keyframe", f73_local0)
			end
			f68_arg0.led:completeAnimation()
			f68_arg0.led:setAlpha(0.02)
			f68_arg0.led:setShaderVector(0, 0, 0.53, 0, 0)
			f68_arg0.led:setShaderVector(1, 0, 0, 0, 0)
			f68_arg0.led:setShaderVector(2, 0, 1, 0, 0)
			f68_arg0.led:setShaderVector(3, 0, 0, 0, 0)
			f68_arg0.led:setShaderVector(4, 0, 0, 0, 0)
			f68_local2(f68_arg0.led)
			local f68_local3 = function(f75_arg0)
				local f75_local0 = function(f76_arg0)
					f76_arg0:beginAnimation(200)
					f76_arg0:setLeftRight(0, 0, -12, 291)
					f76_arg0:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
				end
				f68_arg0.border:beginAnimation(200)
				f68_arg0.border:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.border:registerEventHandler("transition_complete_keyframe", f75_local0)
			end
			f68_arg0.border:completeAnimation()
			f68_arg0.border:setLeftRight(0, 0, -12, 151)
			f68_arg0.border:setAlpha(1)
			f68_local3(f68_arg0.border)
			local f68_local4 = function(f77_arg0)
				local f77_local0 = function(f78_arg0)
					f78_arg0:beginAnimation(200)
					f78_arg0:setAlpha(1)
					f78_arg0:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
				end
				f68_arg0.meterBacking:beginAnimation(400)
				f68_arg0.meterBacking:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.meterBacking:registerEventHandler("transition_complete_keyframe", f77_local0)
			end
			f68_arg0.meterBacking:completeAnimation()
			f68_arg0.meterBacking:setAlpha(0)
			f68_local4(f68_arg0.meterBacking)
			local f68_local5 = function(f79_arg0)
				f68_arg0.Timer:beginAnimation(200)
				f68_arg0.Timer:setAlpha(0)
				f68_arg0.Timer:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.Timer:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
			end
			f68_arg0.Timer:completeAnimation()
			f68_arg0.Timer:setLeftRight(0, 0, 55, 325)
			f68_arg0.Timer:setTopBottom(0, 0, 351.5, 381.5)
			f68_arg0.Timer:setAlpha(1)
			f68_local5(f68_arg0.Timer)
			local f68_local6 = function(f80_arg0)
				f68_arg0.Icon:beginAnimation(200)
				f68_arg0.Icon:setAlpha(0)
				f68_arg0.Icon:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.Icon:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
			end
			f68_arg0.Icon:completeAnimation()
			f68_arg0.Icon:setLeftRight(0, 0, 7, 47)
			f68_arg0.Icon:setTopBottom(0, 0, 345.5, 385.5)
			f68_arg0.Icon:setAlpha(1)
			f68_arg0.Icon:setScale(0.7, 0.7)
			f68_local6(f68_arg0.Icon)
			local f68_local7 = function(f81_arg0)
				local f81_local0 = function(f82_arg0)
					f82_arg0:beginAnimation(200)
					f82_arg0:setAlpha(1)
					f82_arg0:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
				end
				f68_arg0.notch:beginAnimation(400)
				f68_arg0.notch:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.notch:registerEventHandler("transition_complete_keyframe", f81_local0)
			end
			f68_arg0.notch:completeAnimation()
			f68_arg0.notch:setAlpha(0)
			f68_local7(f68_arg0.notch)
			local f68_local8 = function(f83_arg0)
				local f83_local0 = function(f84_arg0)
					f84_arg0:beginAnimation(200)
					f84_arg0:setAlpha(1)
					f84_arg0:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
				end
				f68_arg0.meterFill:beginAnimation(400)
				f68_arg0.meterFill:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.meterFill:registerEventHandler("transition_complete_keyframe", f83_local0)
			end
			f68_arg0.meterFill:completeAnimation()
			f68_arg0.meterFill:setAlpha(0)
			f68_local8(f68_arg0.meterFill)
			local f68_local9 = function(f85_arg0)
				local f85_local0 = function(f86_arg0)
					f86_arg0:beginAnimation(200)
					f86_arg0:setLeftRight(0, 0, -18, 295)
					f86_arg0:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
				end
				f68_arg0.EMP:beginAnimation(200)
				f68_arg0.EMP:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.EMP:registerEventHandler("transition_complete_keyframe", f85_local0)
			end
			f68_arg0.EMP:completeAnimation()
			f68_arg0.EMP:setLeftRight(0, 0, -12, 145)
			f68_local9(f68_arg0.EMP)
		end,
	},
	Warning = {
		DefaultClip = function(f87_arg0, f87_arg1)
			f87_arg0:__resetProperties()
			f87_arg0:setupElementClipCounter(10)
			f87_arg0.blur:completeAnimation()
			f87_arg0.blur:setLeftRight(0, 0, -6, 145)
			f87_arg0.blur:setAlpha(1)
			f87_arg0.clipFinished(f87_arg0.blur)
			f87_arg0.bg:completeAnimation()
			f87_arg0.bg:setLeftRight(0, 0, -6, 145)
			f87_arg0.bg:setAlpha(0.8)
			f87_arg0.clipFinished(f87_arg0.bg)
			f87_arg0.led:completeAnimation()
			f87_arg0.led:setAlpha(0.02)
			f87_arg0.led:setShaderVector(0, 0, 0.53, 0, 0)
			f87_arg0.led:setShaderVector(1, 0, 0, 0, 0)
			f87_arg0.led:setShaderVector(2, 0, 1, 0, 0)
			f87_arg0.led:setShaderVector(3, 0, 0, 0, 0)
			f87_arg0.led:setShaderVector(4, 0, 0, 0, 0)
			f87_arg0.clipFinished(f87_arg0.led)
			f87_arg0.border:completeAnimation()
			f87_arg0.border:setLeftRight(0, 0, -12, 151)
			f87_arg0.border:setAlpha(1)
			f87_arg0.clipFinished(f87_arg0.border)
			f87_arg0.meterBacking:completeAnimation()
			f87_arg0.meterBacking:setLeftRight(-0.01, -0.01, 26, 315)
			f87_arg0.meterBacking:setAlpha(0)
			f87_arg0.clipFinished(f87_arg0.meterBacking)
			f87_arg0.Timer:completeAnimation()
			f87_arg0.Timer:setLeftRight(0, 0, 55, 325)
			f87_arg0.Timer:setTopBottom(0, 0, 346.5, 381.5)
			f87_arg0.Timer:setAlpha(1)
			f87_arg0.clipFinished(f87_arg0.Timer)
			f87_arg0.Icon:completeAnimation()
			f87_arg0.Icon:setLeftRight(0, 0, 7, 47)
			f87_arg0.Icon:setTopBottom(0, 0, 345.5, 385.5)
			f87_arg0.Icon:setScale(0.7, 0.7)
			f87_arg0.clipFinished(f87_arg0.Icon)
			f87_arg0.notch:completeAnimation()
			f87_arg0.notch:setLeftRight(0, 0, -2, 6)
			f87_arg0.notch:setAlpha(0)
			f87_arg0.clipFinished(f87_arg0.notch)
			f87_arg0.meterFill:completeAnimation()
			f87_arg0.meterFill:setAlpha(0)
			f87_arg0.clipFinished(f87_arg0.meterFill)
			f87_arg0.EMP:completeAnimation()
			f87_arg0.EMP:setLeftRight(0, 0, -9, 151)
			f87_arg0.clipFinished(f87_arg0.EMP)
		end,
	},
	Collapsing = {
		DefaultClip = function(f88_arg0, f88_arg1)
			f88_arg0:__resetProperties()
			f88_arg0:setupElementClipCounter(7)
			f88_arg0.blur:completeAnimation()
			f88_arg0.blur:setLeftRight(0, 0, -6, 285)
			f88_arg0.blur:setAlpha(1)
			f88_arg0.clipFinished(f88_arg0.blur)
			f88_arg0.bg:completeAnimation()
			f88_arg0.bg:setLeftRight(0, 0, -6, 285)
			f88_arg0.bg:setAlpha(0.8)
			f88_arg0.clipFinished(f88_arg0.bg)
			f88_arg0.led:completeAnimation()
			f88_arg0.led:setAlpha(0.02)
			f88_arg0.led:setShaderVector(0, 0, 1, 0, 0)
			f88_arg0.led:setShaderVector(1, 0, 0, 0, 0)
			f88_arg0.led:setShaderVector(2, 0, 1, 0, 0)
			f88_arg0.led:setShaderVector(3, 0, 0, 0, 0)
			f88_arg0.led:setShaderVector(4, 0, 0, 0, 0)
			f88_arg0.clipFinished(f88_arg0.led)
			f88_arg0.border:completeAnimation()
			f88_arg0.border:setLeftRight(0, 0, -12, 291)
			f88_arg0.border:setAlpha(1)
			f88_arg0.clipFinished(f88_arg0.border)
			f88_arg0.Timer:completeAnimation()
			f88_arg0.Timer:setAlpha(0)
			f88_arg0.clipFinished(f88_arg0.Timer)
			f88_arg0.Icon:completeAnimation()
			f88_arg0.Icon:setAlpha(0)
			f88_arg0.clipFinished(f88_arg0.Icon)
			f88_arg0.meterFill:completeAnimation()
			f88_arg0.meterFill:setAlpha(1)
			f88_arg0.clipFinished(f88_arg0.meterFill)
		end,
	},
	InfiltrationVehicle = {
		DefaultClip = function(f89_arg0, f89_arg1)
			f89_arg0:__resetProperties()
			f89_arg0:setupElementClipCounter(7)
			f89_arg0.blur:completeAnimation()
			f89_arg0.blur:setLeftRight(0, 0, -6, 285)
			f89_arg0.blur:setAlpha(1)
			f89_arg0.clipFinished(f89_arg0.blur)
			f89_arg0.bg:completeAnimation()
			f89_arg0.bg:setLeftRight(0, 0, -6, 285)
			f89_arg0.bg:setAlpha(0.8)
			f89_arg0.clipFinished(f89_arg0.bg)
			f89_arg0.led:completeAnimation()
			f89_arg0.led:setAlpha(0.02)
			f89_arg0.led:setShaderVector(0, 0, 1, 0, 0)
			f89_arg0.led:setShaderVector(1, 0, 0, 0, 0)
			f89_arg0.led:setShaderVector(2, 0, 1, 0, 0)
			f89_arg0.led:setShaderVector(3, 0, 0, 0, 0)
			f89_arg0.led:setShaderVector(4, 0, 0, 0, 0)
			f89_arg0.clipFinished(f89_arg0.led)
			f89_arg0.border:completeAnimation()
			f89_arg0.border:setLeftRight(0, 0, -12, 291)
			f89_arg0.border:setAlpha(1)
			f89_arg0.clipFinished(f89_arg0.border)
			f89_arg0.SplashBig:completeAnimation()
			f89_arg0.SplashBig:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.SplashBig)
			f89_arg0.Timer:completeAnimation()
			f89_arg0.Timer:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.Timer)
			f89_arg0.Icon:completeAnimation()
			f89_arg0.Icon:setAlpha(0)
			f89_arg0.clipFinished(f89_arg0.Icon)
		end,
	},
}
CoD.WZCollapseTimerInternal.__onClose = function(f90_arg0)
	f90_arg0.Timer:close()
	f90_arg0.TimerDownButNotOut:close()
	f90_arg0.meterFill:close()
	f90_arg0.EMP:close()
end
