require("x64:19c1945d2e472b0")
require("x64:b537a85bd588813")
CoD.WZReinsertionPassengerCount = InheritFrom(LUI.UIElement)
CoD.WZReinsertionPassengerCount.__defaultWidth = 1920
CoD.WZReinsertionPassengerCount.__defaultHeight = 112
CoD.WZReinsertionPassengerCount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZReinsertionPassengerCount)
	self.id = "WZReinsertionPassengerCount"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingBlur = LUI.UIImage.new(1, 1, -1800, -1673, 0, 0, 20.5, 89.5)
	BackingBlur:setAlpha(0)
	BackingBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	BackingBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BackingBlur)
	self.BackingBlur = BackingBlur
	local NoiseTiledBacking = LUI.UIImage.new(1, 1, -1800, -1673, 0, 0, 21, 90)
	NoiseTiledBacking:setAlpha(0)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local DotTiledBacking = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 1, 1, -1797, -1676, 0, 0, 24, 64)
	DotTiledBacking:setAlpha(0)
	DotTiledBacking.TiledShaderImage:setupNineSliceShader(30, 30)
	self:addElement(DotTiledBacking)
	self.DotTiledBacking = DotTiledBacking
	local CountBacking = LUI.UIImage.new(1, 1, -1797, -1676, 0, 0, 67, 87)
	CountBacking:setRGB(0, 0, 0)
	CountBacking:setAlpha(0)
	self:addElement(CountBacking)
	self.CountBacking = CountBacking
	local Image = LUI.UIImage.new(1, 1, -1788, -1735, 0, 0, 17.5, 70.5)
	Image:setAlpha(0)
	Image:setZRot(-90)
	Image:setImage(RegisterImage(0xB024F5E0D917C61))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	Image:setShaderVector(0, 4, 4, 0, 0)
	Image:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(Image)
	self.Image = Image
	local ImagePandemic = LUI.UIImage.new(1, 1, -1788, -1753, 0, 0, 27.5, 62.5)
	ImagePandemic:setAlpha(0)
	ImagePandemic:setImage(RegisterImage(0x7EAC82FFC1BA9E1))
	self:addElement(ImagePandemic)
	self.ImagePandemic = ImagePandemic
	local ImagePortalRespawn = LUI.UIImage.new(1, 1, -1790, -1737, 0, 0, 17.5, 70.5)
	ImagePortalRespawn:setAlpha(0)
	ImagePortalRespawn:setScale(0.74, 0.74)
	ImagePortalRespawn:setImage(RegisterImage(0xB04A867F79BDC44))
	ImagePortalRespawn:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD526D3FD71F281))
	ImagePortalRespawn:setShaderVector(0, 4, 4, 0, 0)
	ImagePortalRespawn:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(ImagePortalRespawn)
	self.ImagePortalRespawn = ImagePortalRespawn
	local TextBox = LUI.UIText.new(1, 1, -1806, -1667, 0, 0, 66.5, 87.5)
	TextBox:setAlpha(0)
	TextBox:setTTF("0arame_mono_stencil")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TextBox:subscribeToGlobalModel(f1_arg1, "WarzoneGlobal", "reinsertionPassengerCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	local RemainingInsertions = LUI.UIText.new(1, 1, -1737, -1676, 0, 0, 33.5, 54.5)
	RemainingInsertions:setAlpha(0)
	RemainingInsertions:setTTF("0arame_mono_stencil")
	RemainingInsertions:setLetterSpacing(-4.1)
	RemainingInsertions:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RemainingInsertions:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	RemainingInsertions.__String_Reference = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			RemainingInsertions:setText(CoD.WZUtility.GetCollapseIndexAndCountString(f3_local0))
		end
	end
	RemainingInsertions:subscribeToGlobalModel(f1_arg1, "WarzoneGlobal", "reinsertionIndex", RemainingInsertions.__String_Reference)
	RemainingInsertions.__String_Reference_FullPath = function()
		local f4_local0 = DataSources.WarzoneGlobal.getModel(f1_arg1)
		f4_local0 = f4_local0.reinsertionIndex
		if f4_local0 then
			RemainingInsertions.__String_Reference(f4_local0)
		end
	end
	self:addElement(RemainingInsertions)
	self.RemainingInsertions = RemainingInsertions
	local border = LUI.UIImage.new(1, 1, -1804, -1669, 0, 0, 18, 93)
	border:setRGB(0.07, 0.07, 0.07)
	border:setAlpha(0)
	border:setImage(RegisterImage(0xA3C76B80B69874D))
	border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	border:setShaderVector(0, 0, 0, 0, 0)
	border:setupNineSliceShader(12, 16)
	self:addElement(border)
	self.border = border
	local WarzoneRedeployment = CoD.WarzoneRedeployment.new(f1_arg0, f1_arg1, 0, 0, 71, 431, 0, 0, -13, 67)
	WarzoneRedeployment:setAlpha(0)
	self:addElement(WarzoneRedeployment)
	self.WarzoneRedeployment = WarzoneRedeployment
	local TimerDownButNotOut = LUI.UIText.new(0.5, 0.5, -753.5, -739.5, 0, 0, 35.5, 52.5)
	TimerDownButNotOut:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TimerDownButNotOut:setAlpha(0)
	TimerDownButNotOut:setTTF("0arame_mono_stencil")
	TimerDownButNotOut:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	TimerDownButNotOut:setShaderVector(0, 1, 0, 0, 0)
	TimerDownButNotOut:setShaderVector(1, 1, 0, 0, 0)
	TimerDownButNotOut:setShaderVector(2, 1, 1, 1, 0.2)
	TimerDownButNotOut:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TimerDownButNotOut:setEndTimerUsePartialSeconds(false)
	TimerDownButNotOut:subscribeToGlobalModel(f1_arg1, "WarzoneGlobal", "collapse", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TimerDownButNotOut:setupEndTimer(f5_local0)
		end
	end)
	self:addElement(TimerDownButNotOut)
	self.TimerDownButNotOut = TimerDownButNotOut
	local TimerDownButNotOutWave = LUI.UIText.new(0.5, 0.5, -753.5, -739.5, 0, 0, 35.5, 52.5)
	TimerDownButNotOutWave:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TimerDownButNotOutWave:setAlpha(0)
	TimerDownButNotOutWave:setTTF("0arame_mono_stencil")
	TimerDownButNotOutWave:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	TimerDownButNotOutWave:setShaderVector(0, 1, 0, 0, 0)
	TimerDownButNotOutWave:setShaderVector(1, 1, 0, 0, 0)
	TimerDownButNotOutWave:setShaderVector(2, 1, 1, 1, 0.2)
	TimerDownButNotOutWave:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TimerDownButNotOutWave:setEndTimerUsePartialSeconds(false)
	TimerDownButNotOutWave:subscribeToGlobalModel(f1_arg1, "WarzoneGlobal", "waveRespawnTimer", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TimerDownButNotOutWave:setupEndTimer(f6_local0)
		end
	end)
	self:addElement(TimerDownButNotOutWave)
	self.TimerDownButNotOutWave = TimerDownButNotOutWave
	local f1_local14 = RemainingInsertions
	local f1_local15 = RemainingInsertions.subscribeToModel
	local f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["hudItems.warzone.collapseCount"], RemainingInsertions.__String_Reference_FullPath)
	self:mergeStateConditions({
		{
			stateName = "VisiblePandemic",
			condition = function(menu, element, event)
				local f7_local0
				if
					Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
				then
					f7_local0 = CoD.WZUtility.AnyReinsertionsRemaining(f1_arg1)
					if f7_local0 then
						f7_local0 = CoD.HUDUtility.IsGameTypeEqualToString("warzone_pandemic_quad")
						if f7_local0 then
							f7_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showReinsertionPassengerCount", 1)
						end
					end
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
		{
			stateName = "VisibleWave",
			condition = function(menu, element, event)
				local f8_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showReinsertionPassengerCount", 1)
				if f8_local0 then
					if
						Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					then
						f8_local0 = IsGametypeSettingsValue("wzEnableWaveRespawn", 1)
						if f8_local0 then
							f8_local0 = CoD.WZUtility.AnyReinsertionsRemaining(f1_arg1)
						end
					else
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "VisibleHotPursuit",
			condition = function(menu, element, event)
				local f9_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showReinsertionPassengerCount", 1)
				if f9_local0 then
					if
						Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					then
						f9_local0 = CoD.WZUtility.AnyReinsertionsRemaining(f1_arg1)
						if f9_local0 then
							f9_local0 = CoD.HUDUtility.IsGameTypeEqualToString("warzone_deposit")
						end
					else
						f9_local0 = false
					end
				end
				return f9_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f10_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showReinsertionPassengerCount", 1)
				if f10_local0 then
					if
						Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
						and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
					then
						f10_local0 = CoD.WZUtility.AnyReinsertionsRemaining(f1_arg1)
					else
						f10_local0 = false
					end
				end
				return f10_local0
			end,
		},
		{
			stateName = "RedeployUnavailable",
			condition = function(menu, element, event)
				local f11_local0
				if not CoD.WZUtility.AnyReinsertionsRemaining(f1_arg1) then
					f11_local0 = CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.showReinsertionPassengerCount", 1)
					if f11_local0 then
						if
							Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
							and Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5])
							and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
						then
							f11_local0 = not CoD.ModelUtility.IsGlobalModelValueEqualTo("hudItems.warzone.collapseCount", 0)
						else
							f11_local0 = false
						end
					end
				else
					f11_local0 = false
				end
				return f11_local0
			end,
		},
	})
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x845D93DFB1D76DA],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1C630DB86D235A5],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["hudItems.warzone.collapseCount"], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "hudItems.warzone.collapseCount",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x8DF2E5447F384B9]()
	f1_local15(f1_local14, f1_local16["hudItems.warzone.reinsertionIndex"], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "hudItems.warzone.reinsertionIndex",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["hudItems.playerCanRedeploy"], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "hudItems.playerCanRedeploy",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local15(f1_local14, f1_local16["hudItems.showReinsertionPassengerCount"], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "hudItems.showReinsertionPassengerCount",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZReinsertionPassengerCount.__resetProperties = function(f30_arg0)
	f30_arg0.WarzoneRedeployment:completeAnimation()
	f30_arg0.border:completeAnimation()
	f30_arg0.CountBacking:completeAnimation()
	f30_arg0.DotTiledBacking:completeAnimation()
	f30_arg0.NoiseTiledBacking:completeAnimation()
	f30_arg0.BackingBlur:completeAnimation()
	f30_arg0.TimerDownButNotOut:completeAnimation()
	f30_arg0.TimerDownButNotOutWave:completeAnimation()
	f30_arg0.TextBox:completeAnimation()
	f30_arg0.Image:completeAnimation()
	f30_arg0.ImagePandemic:completeAnimation()
	f30_arg0.ImagePortalRespawn:completeAnimation()
	f30_arg0.RemainingInsertions:completeAnimation()
	f30_arg0.WarzoneRedeployment:setAlpha(0)
	f30_arg0.border:setAlpha(0)
	f30_arg0.CountBacking:setAlpha(0)
	f30_arg0.DotTiledBacking:setAlpha(0)
	f30_arg0.NoiseTiledBacking:setAlpha(0)
	f30_arg0.BackingBlur:setAlpha(0)
	f30_arg0.TimerDownButNotOut:setAlpha(0)
	f30_arg0.TimerDownButNotOutWave:setAlpha(0)
	f30_arg0.TextBox:setAlpha(0)
	f30_arg0.Image:setAlpha(0)
	f30_arg0.ImagePandemic:setAlpha(0)
	f30_arg0.ImagePortalRespawn:setAlpha(0)
	f30_arg0.RemainingInsertions:setAlpha(0)
end
CoD.WZReinsertionPassengerCount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			f31_arg0.WarzoneRedeployment:completeAnimation()
			f31_arg0.WarzoneRedeployment:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.WarzoneRedeployment)
		end,
	},
	VisiblePandemic = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(11)
			local f32_local0 = function(f33_arg0)
				f32_arg0.BackingBlur:beginAnimation(300)
				f32_arg0.BackingBlur:setAlpha(1)
				f32_arg0.BackingBlur:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.BackingBlur:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.BackingBlur:completeAnimation()
			f32_arg0.BackingBlur:setAlpha(0)
			f32_local0(f32_arg0.BackingBlur)
			local f32_local1 = function(f34_arg0)
				f32_arg0.NoiseTiledBacking:beginAnimation(300)
				f32_arg0.NoiseTiledBacking:setAlpha(0.5)
				f32_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.NoiseTiledBacking:completeAnimation()
			f32_arg0.NoiseTiledBacking:setAlpha(0)
			f32_local1(f32_arg0.NoiseTiledBacking)
			local f32_local2 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(300)
					f36_arg0:setAlpha(1)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.DotTiledBacking:beginAnimation(300)
				f32_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f32_arg0.DotTiledBacking:completeAnimation()
			f32_arg0.DotTiledBacking:setAlpha(0)
			f32_local2(f32_arg0.DotTiledBacking)
			local f32_local3 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(299)
					f38_arg0:setAlpha(0.5)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.CountBacking:beginAnimation(600)
				f32_arg0.CountBacking:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.CountBacking:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f32_arg0.CountBacking:completeAnimation()
			f32_arg0.CountBacking:setAlpha(0)
			f32_local3(f32_arg0.CountBacking)
			f32_arg0.Image:completeAnimation()
			f32_arg0.Image:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Image)
			local f32_local4 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(300)
					f40_arg0:setAlpha(1)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.ImagePandemic:beginAnimation(900)
				f32_arg0.ImagePandemic:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.ImagePandemic:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f32_arg0.ImagePandemic:completeAnimation()
			f32_arg0.ImagePandemic:setAlpha(0)
			f32_local4(f32_arg0.ImagePandemic)
			local f32_local5 = function(f41_arg0)
				local f41_local0 = function(f42_arg0)
					f42_arg0:beginAnimation(299)
					f42_arg0:setAlpha(1)
					f42_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.TextBox:beginAnimation(1200)
				f32_arg0.TextBox:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f41_local0)
			end
			f32_arg0.TextBox:completeAnimation()
			f32_arg0.TextBox:setAlpha(0)
			f32_local5(f32_arg0.TextBox)
			local f32_local6 = function(f43_arg0)
				f32_arg0.border:beginAnimation(300)
				f32_arg0.border:setAlpha(1)
				f32_arg0.border:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.border:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
			end
			f32_arg0.border:completeAnimation()
			f32_arg0.border:setAlpha(0)
			f32_local6(f32_arg0.border)
			f32_arg0.WarzoneRedeployment:completeAnimation()
			f32_arg0.WarzoneRedeployment:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.WarzoneRedeployment)
			f32_arg0.TimerDownButNotOut:completeAnimation()
			f32_arg0.TimerDownButNotOut:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.TimerDownButNotOut)
			local f32_local7 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					f45_arg0:beginAnimation(299)
					f45_arg0:setAlpha(1)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.TimerDownButNotOutWave:beginAnimation(1200)
				f32_arg0.TimerDownButNotOutWave:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.TimerDownButNotOutWave:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f32_arg0.TimerDownButNotOutWave:completeAnimation()
			f32_arg0.TimerDownButNotOutWave:setAlpha(0)
			f32_local7(f32_arg0.TimerDownButNotOutWave)
		end,
	},
	VisibleWave = {
		DefaultClip = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(11)
			local f46_local0 = function(f47_arg0)
				f46_arg0.BackingBlur:beginAnimation(300)
				f46_arg0.BackingBlur:setAlpha(1)
				f46_arg0.BackingBlur:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.BackingBlur:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.BackingBlur:completeAnimation()
			f46_arg0.BackingBlur:setAlpha(0)
			f46_local0(f46_arg0.BackingBlur)
			local f46_local1 = function(f48_arg0)
				f46_arg0.NoiseTiledBacking:beginAnimation(300)
				f46_arg0.NoiseTiledBacking:setAlpha(0.5)
				f46_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.NoiseTiledBacking:completeAnimation()
			f46_arg0.NoiseTiledBacking:setAlpha(0)
			f46_local1(f46_arg0.NoiseTiledBacking)
			local f46_local2 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(300)
					f50_arg0:setAlpha(1)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
				end
				f46_arg0.DotTiledBacking:beginAnimation(300)
				f46_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f46_arg0.DotTiledBacking:completeAnimation()
			f46_arg0.DotTiledBacking:setAlpha(0)
			f46_local2(f46_arg0.DotTiledBacking)
			local f46_local3 = function(f51_arg0)
				local f51_local0 = function(f52_arg0)
					f52_arg0:beginAnimation(299)
					f52_arg0:setAlpha(0.5)
					f52_arg0:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
				end
				f46_arg0.CountBacking:beginAnimation(600)
				f46_arg0.CountBacking:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.CountBacking:registerEventHandler("transition_complete_keyframe", f51_local0)
			end
			f46_arg0.CountBacking:completeAnimation()
			f46_arg0.CountBacking:setAlpha(0)
			f46_local3(f46_arg0.CountBacking)
			f46_arg0.Image:completeAnimation()
			f46_arg0.Image:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.Image)
			local f46_local4 = function(f53_arg0)
				local f53_local0 = function(f54_arg0)
					f54_arg0:beginAnimation(300)
					f54_arg0:setAlpha(1)
					f54_arg0:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
				end
				f46_arg0.ImagePortalRespawn:beginAnimation(900)
				f46_arg0.ImagePortalRespawn:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.ImagePortalRespawn:registerEventHandler("transition_complete_keyframe", f53_local0)
			end
			f46_arg0.ImagePortalRespawn:completeAnimation()
			f46_arg0.ImagePortalRespawn:setAlpha(0)
			f46_local4(f46_arg0.ImagePortalRespawn)
			local f46_local5 = function(f55_arg0)
				local f55_local0 = function(f56_arg0)
					f56_arg0:beginAnimation(299)
					f56_arg0:setAlpha(1)
					f56_arg0:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
				end
				f46_arg0.TextBox:beginAnimation(1200)
				f46_arg0.TextBox:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f55_local0)
			end
			f46_arg0.TextBox:completeAnimation()
			f46_arg0.TextBox:setAlpha(0)
			f46_local5(f46_arg0.TextBox)
			local f46_local6 = function(f57_arg0)
				f46_arg0.border:beginAnimation(300)
				f46_arg0.border:setAlpha(1)
				f46_arg0.border:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.border:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
			end
			f46_arg0.border:completeAnimation()
			f46_arg0.border:setAlpha(0)
			f46_local6(f46_arg0.border)
			f46_arg0.WarzoneRedeployment:completeAnimation()
			f46_arg0.WarzoneRedeployment:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.WarzoneRedeployment)
			f46_arg0.TimerDownButNotOut:completeAnimation()
			f46_arg0.TimerDownButNotOut:setAlpha(0)
			f46_arg0.clipFinished(f46_arg0.TimerDownButNotOut)
			local f46_local7 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					f59_arg0:beginAnimation(299)
					f59_arg0:setAlpha(1)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f46_arg0.clipFinished)
				end
				f46_arg0.TimerDownButNotOutWave:beginAnimation(1200)
				f46_arg0.TimerDownButNotOutWave:registerEventHandler("interrupted_keyframe", f46_arg0.clipInterrupted)
				f46_arg0.TimerDownButNotOutWave:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f46_arg0.TimerDownButNotOutWave:completeAnimation()
			f46_arg0.TimerDownButNotOutWave:setAlpha(0)
			f46_local7(f46_arg0.TimerDownButNotOutWave)
		end,
	},
	VisibleHotPursuit = {
		DefaultClip = function(f60_arg0, f60_arg1)
			f60_arg0:__resetProperties()
			f60_arg0:setupElementClipCounter(9)
			local f60_local0 = function(f61_arg0)
				f60_arg0.BackingBlur:beginAnimation(300)
				f60_arg0.BackingBlur:setAlpha(1)
				f60_arg0.BackingBlur:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.BackingBlur:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
			end
			f60_arg0.BackingBlur:completeAnimation()
			f60_arg0.BackingBlur:setAlpha(0)
			f60_local0(f60_arg0.BackingBlur)
			local f60_local1 = function(f62_arg0)
				f60_arg0.NoiseTiledBacking:beginAnimation(300)
				f60_arg0.NoiseTiledBacking:setAlpha(0.5)
				f60_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
			end
			f60_arg0.NoiseTiledBacking:completeAnimation()
			f60_arg0.NoiseTiledBacking:setAlpha(0)
			f60_local1(f60_arg0.NoiseTiledBacking)
			local f60_local2 = function(f63_arg0)
				local f63_local0 = function(f64_arg0)
					f64_arg0:beginAnimation(300)
					f64_arg0:setAlpha(1)
					f64_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.DotTiledBacking:beginAnimation(300)
				f60_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f63_local0)
			end
			f60_arg0.DotTiledBacking:completeAnimation()
			f60_arg0.DotTiledBacking:setAlpha(0)
			f60_local2(f60_arg0.DotTiledBacking)
			local f60_local3 = function(f65_arg0)
				local f65_local0 = function(f66_arg0)
					f66_arg0:beginAnimation(299)
					f66_arg0:setAlpha(0.5)
					f66_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.CountBacking:beginAnimation(600)
				f60_arg0.CountBacking:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.CountBacking:registerEventHandler("transition_complete_keyframe", f65_local0)
			end
			f60_arg0.CountBacking:completeAnimation()
			f60_arg0.CountBacking:setAlpha(0)
			f60_local3(f60_arg0.CountBacking)
			local f60_local4 = function(f67_arg0)
				local f67_local0 = function(f68_arg0)
					f68_arg0:beginAnimation(300)
					f68_arg0:setAlpha(1)
					f68_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.Image:beginAnimation(900)
				f60_arg0.Image:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.Image:registerEventHandler("transition_complete_keyframe", f67_local0)
			end
			f60_arg0.Image:completeAnimation()
			f60_arg0.Image:setAlpha(0)
			f60_local4(f60_arg0.Image)
			local f60_local5 = function(f69_arg0)
				local f69_local0 = function(f70_arg0)
					f70_arg0:beginAnimation(299)
					f70_arg0:setAlpha(1)
					f70_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.TextBox:beginAnimation(1200)
				f60_arg0.TextBox:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f69_local0)
			end
			f60_arg0.TextBox:completeAnimation()
			f60_arg0.TextBox:setAlpha(0)
			f60_local5(f60_arg0.TextBox)
			local f60_local6 = function(f71_arg0)
				f60_arg0.border:beginAnimation(300)
				f60_arg0.border:setAlpha(1)
				f60_arg0.border:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.border:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
			end
			f60_arg0.border:completeAnimation()
			f60_arg0.border:setAlpha(0)
			f60_local6(f60_arg0.border)
			f60_arg0.WarzoneRedeployment:completeAnimation()
			f60_arg0.WarzoneRedeployment:setAlpha(0)
			f60_arg0.clipFinished(f60_arg0.WarzoneRedeployment)
			local f60_local7 = function(f72_arg0)
				local f72_local0 = function(f73_arg0)
					f73_arg0:beginAnimation(299)
					f73_arg0:setAlpha(1)
					f73_arg0:registerEventHandler("transition_complete_keyframe", f60_arg0.clipFinished)
				end
				f60_arg0.TimerDownButNotOut:beginAnimation(1200)
				f60_arg0.TimerDownButNotOut:registerEventHandler("interrupted_keyframe", f60_arg0.clipInterrupted)
				f60_arg0.TimerDownButNotOut:registerEventHandler("transition_complete_keyframe", f72_local0)
			end
			f60_arg0.TimerDownButNotOut:completeAnimation()
			f60_arg0.TimerDownButNotOut:setAlpha(0)
			f60_local7(f60_arg0.TimerDownButNotOut)
		end,
	},
	Visible = {
		DefaultClip = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(9)
			local f74_local0 = function(f75_arg0)
				f74_arg0.BackingBlur:beginAnimation(300)
				f74_arg0.BackingBlur:setAlpha(1)
				f74_arg0.BackingBlur:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.BackingBlur:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
			end
			f74_arg0.BackingBlur:completeAnimation()
			f74_arg0.BackingBlur:setAlpha(0)
			f74_local0(f74_arg0.BackingBlur)
			local f74_local1 = function(f76_arg0)
				f74_arg0.NoiseTiledBacking:beginAnimation(300)
				f74_arg0.NoiseTiledBacking:setAlpha(0.5)
				f74_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
			end
			f74_arg0.NoiseTiledBacking:completeAnimation()
			f74_arg0.NoiseTiledBacking:setAlpha(0)
			f74_local1(f74_arg0.NoiseTiledBacking)
			local f74_local2 = function(f77_arg0)
				local f77_local0 = function(f78_arg0)
					f78_arg0:beginAnimation(300)
					f78_arg0:setAlpha(1)
					f78_arg0:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
				end
				f74_arg0.DotTiledBacking:beginAnimation(300)
				f74_arg0.DotTiledBacking:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.DotTiledBacking:registerEventHandler("transition_complete_keyframe", f77_local0)
			end
			f74_arg0.DotTiledBacking:completeAnimation()
			f74_arg0.DotTiledBacking:setAlpha(0)
			f74_local2(f74_arg0.DotTiledBacking)
			local f74_local3 = function(f79_arg0)
				local f79_local0 = function(f80_arg0)
					f80_arg0:beginAnimation(299)
					f80_arg0:setAlpha(0.5)
					f80_arg0:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
				end
				f74_arg0.CountBacking:beginAnimation(600)
				f74_arg0.CountBacking:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.CountBacking:registerEventHandler("transition_complete_keyframe", f79_local0)
			end
			f74_arg0.CountBacking:completeAnimation()
			f74_arg0.CountBacking:setAlpha(0)
			f74_local3(f74_arg0.CountBacking)
			local f74_local4 = function(f81_arg0)
				local f81_local0 = function(f82_arg0)
					f82_arg0:beginAnimation(300)
					f82_arg0:setAlpha(1)
					f82_arg0:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
				end
				f74_arg0.Image:beginAnimation(900)
				f74_arg0.Image:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.Image:registerEventHandler("transition_complete_keyframe", f81_local0)
			end
			f74_arg0.Image:completeAnimation()
			f74_arg0.Image:setAlpha(0)
			f74_local4(f74_arg0.Image)
			local f74_local5 = function(f83_arg0)
				local f83_local0 = function(f84_arg0)
					f84_arg0:beginAnimation(299)
					f84_arg0:setAlpha(1)
					f84_arg0:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
				end
				f74_arg0.TextBox:beginAnimation(1200)
				f74_arg0.TextBox:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f83_local0)
			end
			f74_arg0.TextBox:completeAnimation()
			f74_arg0.TextBox:setAlpha(0)
			f74_local5(f74_arg0.TextBox)
			local f74_local6 = function(f85_arg0)
				local f85_local0 = function(f86_arg0)
					f86_arg0:beginAnimation(299)
					f86_arg0:setAlpha(1)
					f86_arg0:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
				end
				f74_arg0.RemainingInsertions:beginAnimation(1200)
				f74_arg0.RemainingInsertions:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.RemainingInsertions:registerEventHandler("transition_complete_keyframe", f85_local0)
			end
			f74_arg0.RemainingInsertions:completeAnimation()
			f74_arg0.RemainingInsertions:setAlpha(0)
			f74_local6(f74_arg0.RemainingInsertions)
			local f74_local7 = function(f87_arg0)
				f74_arg0.border:beginAnimation(300)
				f74_arg0.border:setAlpha(1)
				f74_arg0.border:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.border:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
			end
			f74_arg0.border:completeAnimation()
			f74_arg0.border:setAlpha(0)
			f74_local7(f74_arg0.border)
			f74_arg0.WarzoneRedeployment:completeAnimation()
			f74_arg0.WarzoneRedeployment:setAlpha(0)
			f74_arg0.clipFinished(f74_arg0.WarzoneRedeployment)
		end,
	},
	RedeployUnavailable = {
		DefaultClip = function(f88_arg0, f88_arg1)
			f88_arg0:__resetProperties()
			f88_arg0:setupElementClipCounter(1)
			local f88_local0 = function(f89_arg0)
				f88_arg0.WarzoneRedeployment:beginAnimation(320)
				f88_arg0.WarzoneRedeployment:setAlpha(1)
				f88_arg0.WarzoneRedeployment:registerEventHandler("interrupted_keyframe", f88_arg0.clipInterrupted)
				f88_arg0.WarzoneRedeployment:registerEventHandler("transition_complete_keyframe", f88_arg0.clipFinished)
			end
			f88_arg0.WarzoneRedeployment:completeAnimation()
			f88_arg0.WarzoneRedeployment:setAlpha(0)
			f88_local0(f88_arg0.WarzoneRedeployment)
		end,
	},
}
CoD.WZReinsertionPassengerCount.__onClose = function(f90_arg0)
	f90_arg0.DotTiledBacking:close()
	f90_arg0.TextBox:close()
	f90_arg0.RemainingInsertions:close()
	f90_arg0.WarzoneRedeployment:close()
	f90_arg0.TimerDownButNotOut:close()
	f90_arg0.TimerDownButNotOutWave:close()
end
