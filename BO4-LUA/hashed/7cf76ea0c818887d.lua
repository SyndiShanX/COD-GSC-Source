require("x64:8a21df2466c537b")
require("x64:e88c04402ee086b")
CoD.FallMeter = InheritFrom(LUI.UIElement)
CoD.FallMeter.__defaultWidth = 32
CoD.FallMeter.__defaultHeight = 500
CoD.FallMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FallMeter)
	self.id = "FallMeter"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0.5, 0.5, -10, 10, -0.01, 1.01, 6, -6)
	SceneBlur:setImage(RegisterImage(0xD7F6A82597E4194))
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local Texture = LUI.UIImage.new(0.5, 0.5, -10, 10, -0.01, 1.01, 6, -6)
	Texture:setImage(RegisterImage(0xDD4649871844D70))
	self:addElement(Texture)
	self.Texture = Texture
	local GroundFill = LUI.UIImage.new(0.5, 0.5, -10, 10, 1, 1, -500, 0)
	GroundFill:setRGB(0.63, 0.33, 0.16)
	GroundFill:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	GroundFill:setShaderVector(0, 0, 1, 0, 0)
	GroundFill:setShaderVector(1, 0, 0, 0, 0)
	GroundFill:setShaderVector(3, 0, 0, 0, 0)
	GroundFill:setShaderVector(4, 0, 0, 0, 0)
	GroundFill.__Y_Start___Y_End = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			GroundFill:setShaderVector(2, CoD.WZUtility.GetGroundUnderPlayerAltitudeRatio(f1_arg1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end
	GroundFill:subscribeToGlobalModel(f1_arg1, "HUDItems", "groundUnderPlayerAltitude", GroundFill.__Y_Start___Y_End)
	GroundFill.__Y_Start___Y_End_FullPath = function()
		local f3_local0 = DataSources.HUDItems.getModel(f1_arg1)
		f3_local0 = f3_local0.groundUnderPlayerAltitude
		if f3_local0 then
			GroundFill.__Y_Start___Y_End(f3_local0)
		end
	end
	self:addElement(GroundFill)
	self.GroundFill = GroundFill
	local ParachuteDeployLine = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -4, 4)
	ParachuteDeployLine:setRGB(1, 0, 0)
	ParachuteDeployLine:setAlpha(0)
	ParachuteDeployLine:setMaterial(LUI.UIImage.GetCachedMaterial(0x9E7CAA1CA4B378C))
	ParachuteDeployLine:setShaderVector(0, 1, 3, 0, 0)
	ParachuteDeployLine.__YOffset_Percent = function(f4_arg0)
		local f4_local0 = f4_arg0:get()
		if f4_local0 ~= nil then
			ParachuteDeployLine:setTopPct(CoD.WZUtility.GetFreeFallAltitudeRatio(f1_arg1, f4_local0))
		end
	end
	ParachuteDeployLine:subscribeToGlobalModel(f1_arg1, "HUDItems", "parachuteOpenAltitude", ParachuteDeployLine.__YOffset_Percent)
	ParachuteDeployLine.__YOffset_Percent_FullPath = function()
		local f5_local0 = DataSources.HUDItems.getModel(f1_arg1)
		f5_local0 = f5_local0.parachuteOpenAltitude
		if f5_local0 then
			ParachuteDeployLine.__YOffset_Percent(f5_local0)
		end
	end
	self:addElement(ParachuteDeployLine)
	self.ParachuteDeployLine = ParachuteDeployLine
	local MeterR = LUI.UIImage.new(1, 1, -21, 5, 0.5, 0.5, -245, 245)
	MeterR:setAlpha(0.3)
	MeterR:setImage(RegisterImage(0x99527D705709FEE))
	MeterR:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	MeterR:setShaderVector(0, 1, 1.5, 0, 0)
	MeterR:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(MeterR)
	self.MeterR = MeterR
	local CornerTR = LUI.UIImage.new(1, 1, -14, -3, 0, 0, -2.5, 8.5)
	CornerTR:setRGB(0, 0, 0)
	CornerTR:setImage(RegisterImage(0x62E760CB652A6EE))
	self:addElement(CornerTR)
	self.CornerTR = CornerTR
	local MidR = LUI.UIImage.new(1, 1, -14, -3, 0.5, 0.5, -240, 240)
	MidR:setRGB(0, 0, 0)
	MidR:setImage(RegisterImage(0x8215DDE7C19CAF3))
	self:addElement(MidR)
	self.MidR = MidR
	local CornerBR = LUI.UIImage.new(1, 1, -14, -3, 1, 1, -7.5, 3.5)
	CornerBR:setRGB(0, 0, 0)
	CornerBR:setXRot(180)
	CornerBR:setImage(RegisterImage(0x62E760CB652A6EE))
	self:addElement(CornerBR)
	self.CornerBR = CornerBR
	local PlayerInfo = CoD.FallMeter_PlayerInfo.new(f1_arg0, f1_arg1, 0, 0, -3, 35, 0, 0, -2, 6)
	PlayerInfo.__YOffset_Percent = function(f6_arg0)
		local f6_local0 = f6_arg0:get()
		if f6_local0 ~= nil then
			PlayerInfo:setTopPct(CoD.WZUtility.GetFreeFallAltitudeRatio(f1_arg1, f6_local0))
		end
	end
	PlayerInfo:subscribeToGlobalModel(f1_arg1, "HUDItems", "altitude", PlayerInfo.__YOffset_Percent)
	PlayerInfo.__YOffset_Percent_FullPath = function()
		local f7_local0 = DataSources.HUDItems.getModel(f1_arg1)
		f7_local0 = f7_local0.altitude
		if f7_local0 then
			PlayerInfo.__YOffset_Percent(f7_local0)
		end
	end
	self:addElement(PlayerInfo)
	self.PlayerInfo = PlayerInfo
	local ParachuteDeployIndicator = CoD.FallMeter_ParachuteDeployIndicator.new(f1_arg0, f1_arg1, 0, 0, -3, 35, 0, 0, -4, 2)
	ParachuteDeployIndicator.__YOffset_Percent = function(f8_arg0)
		local f8_local0 = f8_arg0:get()
		if f8_local0 ~= nil then
			ParachuteDeployIndicator:setTopPct(CoD.WZUtility.GetFreeFallAltitudeRatio(f1_arg1, f8_local0))
		end
	end
	ParachuteDeployIndicator:subscribeToGlobalModel(f1_arg1, "HUDItems", "parachuteOpenAltitude", ParachuteDeployIndicator.__YOffset_Percent)
	ParachuteDeployIndicator.__YOffset_Percent_FullPath = function()
		local f9_local0 = DataSources.HUDItems.getModel(f1_arg1)
		f9_local0 = f9_local0.parachuteOpenAltitude
		if f9_local0 then
			ParachuteDeployIndicator.__YOffset_Percent(f9_local0)
		end
	end
	self:addElement(ParachuteDeployIndicator)
	self.ParachuteDeployIndicator = ParachuteDeployIndicator
	local f1_local11 = GroundFill
	local f1_local12 = GroundFill.subscribeToModel
	local f1_local13 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local12(f1_local11, f1_local13.freeFallStartAltitude, GroundFill.__Y_Start___Y_End_FullPath)
	f1_local11 = ParachuteDeployLine
	f1_local12 = ParachuteDeployLine.subscribeToModel
	f1_local13 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local12(f1_local11, f1_local13.freeFallStartAltitude, ParachuteDeployLine.__YOffset_Percent_FullPath)
	f1_local11 = PlayerInfo
	f1_local12 = PlayerInfo.subscribeToModel
	f1_local13 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local12(f1_local11, f1_local13.freeFallStartAltitude, PlayerInfo.__YOffset_Percent_FullPath)
	f1_local11 = ParachuteDeployIndicator
	f1_local12 = ParachuteDeployIndicator.subscribeToModel
	f1_local13 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local12(f1_local11, f1_local13.freeFallStartAltitude, ParachuteDeployIndicator.__YOffset_Percent_FullPath)
	self:mergeStateConditions({
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideAltimeterUI", "warzoneHideAltimeter")
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "HUDItems", "insertionJumpActive")
			end,
		},
	})
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13.PlayerSettingsUpdate, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local12(f1_local11, f1_local13.insertionJumpActive, function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "insertionJumpActive",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FallMeter.__resetProperties = function(f14_arg0)
	f14_arg0.PlayerInfo:completeAnimation()
	f14_arg0.GroundFill:completeAnimation()
	f14_arg0.ParachuteDeployIndicator:completeAnimation()
	f14_arg0.MeterR:completeAnimation()
	f14_arg0.CornerBR:completeAnimation()
	f14_arg0.MidR:completeAnimation()
	f14_arg0.CornerTR:completeAnimation()
	f14_arg0.SceneBlur:completeAnimation()
	f14_arg0.Texture:completeAnimation()
	f14_arg0.ParachuteDeployLine:completeAnimation()
	f14_arg0.PlayerInfo:setAlpha(1)
	f14_arg0.GroundFill:setAlpha(1)
	f14_arg0.ParachuteDeployIndicator:setAlpha(1)
	f14_arg0.MeterR:setAlpha(0.3)
	f14_arg0.CornerBR:setAlpha(1)
	f14_arg0.MidR:setAlpha(1)
	f14_arg0.CornerTR:setAlpha(1)
	f14_arg0.SceneBlur:setAlpha(1)
	f14_arg0.Texture:setAlpha(1)
	f14_arg0.ParachuteDeployLine:setAlpha(0)
end
CoD.FallMeter.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(10)
			f15_arg0.SceneBlur:completeAnimation()
			f15_arg0.SceneBlur:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.SceneBlur)
			f15_arg0.Texture:completeAnimation()
			f15_arg0.Texture:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Texture)
			f15_arg0.GroundFill:completeAnimation()
			f15_arg0.GroundFill:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.GroundFill)
			f15_arg0.ParachuteDeployLine:completeAnimation()
			f15_arg0.ParachuteDeployLine:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ParachuteDeployLine)
			f15_arg0.MeterR:completeAnimation()
			f15_arg0.MeterR:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.MeterR)
			f15_arg0.CornerTR:completeAnimation()
			f15_arg0.CornerTR:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CornerTR)
			f15_arg0.MidR:completeAnimation()
			f15_arg0.MidR:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.MidR)
			f15_arg0.CornerBR:completeAnimation()
			f15_arg0.CornerBR:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.CornerBR)
			f15_arg0.PlayerInfo:completeAnimation()
			f15_arg0.PlayerInfo:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.PlayerInfo)
			f15_arg0.ParachuteDeployIndicator:completeAnimation()
			f15_arg0.ParachuteDeployIndicator:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.ParachuteDeployIndicator)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(10)
			f16_arg0.SceneBlur:completeAnimation()
			f16_arg0.SceneBlur:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.SceneBlur)
			f16_arg0.Texture:completeAnimation()
			f16_arg0.Texture:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Texture)
			f16_arg0.GroundFill:completeAnimation()
			f16_arg0.GroundFill:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.GroundFill)
			f16_arg0.ParachuteDeployLine:completeAnimation()
			f16_arg0.ParachuteDeployLine:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ParachuteDeployLine)
			f16_arg0.MeterR:completeAnimation()
			f16_arg0.MeterR:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.MeterR)
			f16_arg0.CornerTR:completeAnimation()
			f16_arg0.CornerTR:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CornerTR)
			f16_arg0.MidR:completeAnimation()
			f16_arg0.MidR:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.MidR)
			f16_arg0.CornerBR:completeAnimation()
			f16_arg0.CornerBR:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.CornerBR)
			f16_arg0.PlayerInfo:completeAnimation()
			f16_arg0.PlayerInfo:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.PlayerInfo)
			f16_arg0.ParachuteDeployIndicator:completeAnimation()
			f16_arg0.ParachuteDeployIndicator:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ParachuteDeployIndicator)
		end,
	},
	Visible = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.FallMeter.__onClose = function(f18_arg0)
	f18_arg0.GroundFill:close()
	f18_arg0.ParachuteDeployLine:close()
	f18_arg0.PlayerInfo:close()
	f18_arg0.ParachuteDeployIndicator:close()
end
