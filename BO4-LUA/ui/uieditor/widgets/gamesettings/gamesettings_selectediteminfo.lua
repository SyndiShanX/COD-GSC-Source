require("x64:98f1288a89a9af6")
require("x64:1c841f207283812")
require("x64:97f7aa36a1d5af8")
require("x64:b346bbe9dd15dcc")
require("x64:dc058fc242e053a")
require("x64:a9255c570c68aa8")
CoD.GameSettings_SelectedItemInfo = InheritFrom(LUI.UIElement)
CoD.GameSettings_SelectedItemInfo.__defaultWidth = 1920
CoD.GameSettings_SelectedItemInfo.__defaultHeight = 1080
CoD.GameSettings_SelectedItemInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_SelectedItemInfo)
	self.id = "GameSettings_SelectedItemInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonDetailPanel = CoD.CommonDetailPanel.new(f1_arg0, f1_arg1, 0, 0, 1090, 1824, 0, 0, 574, 1023)
	CommonDetailPanel:setAlpha(0)
	self:addElement(CommonDetailPanel)
	self.CommonDetailPanel = CommonDetailPanel
	local ToolTip = CoD.GameSettings_Description.new(f1_arg0, f1_arg1, 0, 0, 1120, 1794, 0, 0, 243.5, 412.5)
	self:addElement(ToolTip)
	self.ToolTip = ToolTip
	local GameModeInfo = CoD.GameSettings_MatchSettingsInfo.new(f1_arg0, f1_arg1, 0, 0, 1120, 1794, 0, 0, 878.5, 993.5)
	self:addElement(GameModeInfo)
	self.GameModeInfo = GameModeInfo
	local GameModeName = CoD.GameSettings_GameModeName.new(f1_arg0, f1_arg1, 1, 1, -799.5, -125.5, 1, 1, -206, -164)
	self:addElement(GameModeName)
	self.GameModeName = GameModeName
	local OfficialBadge = CoD.CustomGames_OfficialBadge.new(f1_arg0, f1_arg1, 0, 0, 1120, 1320, 0, 0, 843, 873)
	self:addElement(OfficialBadge)
	self.OfficialBadge = OfficialBadge
	local GuideFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1090, 1824, 0.5, 0.5, -327, 483)
	GuideFrame:setAlpha(0.01)
	self:addElement(GuideFrame)
	self.GuideFrame = GuideFrame
	local GuideFrame2 = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1149.5, 1764.5, 0.5, 0.5, -267, 423)
	GuideFrame2:setAlpha(0)
	self:addElement(GuideFrame2)
	self.GuideFrame2 = GuideFrame2
	local GuideFrame3 = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 1120.5, 1794.5, 0.5, 0.5, -297, 453)
	GuideFrame3:setAlpha(0)
	self:addElement(GuideFrame3)
	self.GuideFrame3 = GuideFrame3
	local SpecialistCornerL = LUI.UIImage.new(0.5, 0.5, 847, 871, 0, 0, 137, 161)
	SpecialistCornerL:setAlpha(0.2)
	SpecialistCornerL:setZRot(90)
	SpecialistCornerL:setScale(0.5, 0.5)
	SpecialistCornerL:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerL)
	self.SpecialistCornerL = SpecialistCornerL
	local SpecialistCornerL2 = LUI.UIImage.new(0.5, 0.5, 847, 871, 0, 0, 1006, 1030)
	SpecialistCornerL2:setAlpha(0.2)
	SpecialistCornerL2:setScale(0.5, 0.5)
	SpecialistCornerL2:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerL2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerL2:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerL2)
	self.SpecialistCornerL2 = SpecialistCornerL2
	local SpecialistCornerL3 = LUI.UIImage.new(0.5, 0.5, 123, 147, 0, 0, 1006, 1030)
	SpecialistCornerL3:setAlpha(0.2)
	SpecialistCornerL3:setYRot(180)
	SpecialistCornerL3:setScale(0.5, 0.5)
	SpecialistCornerL3:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerL3:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerL3:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerL3)
	self.SpecialistCornerL3 = SpecialistCornerL3
	local SpecialistCornerR = LUI.UIImage.new(0.5, 0.5, 123, 147, 0, 0, 207, 231)
	SpecialistCornerR:setAlpha(0.2)
	SpecialistCornerR:setZRot(180)
	SpecialistCornerR:setScale(0.5, 0.5)
	SpecialistCornerR:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerR)
	self.SpecialistCornerR = SpecialistCornerR
	local GuideBox = LUI.UIImage.new(0, 0, 1090, 1150, 0, 0, 213, 273)
	GuideBox:setAlpha(0)
	self:addElement(GuideBox)
	self.GuideBox = GuideBox
	local GuideBox4 = LUI.UIImage.new(0, 0, 1090, 1150, 0, 0, 963, 1023)
	GuideBox4:setAlpha(0)
	self:addElement(GuideBox4)
	self.GuideBox4 = GuideBox4
	local GuideBox3 = LUI.UIImage.new(0, 0, 1090, 1120, 0, 0, 993, 1023)
	GuideBox3:setAlpha(0)
	self:addElement(GuideBox3)
	self.GuideBox3 = GuideBox3
	local GuideBox2 = LUI.UIImage.new(0, 0, 1090, 1120, 0, 0, 213, 243)
	GuideBox2:setAlpha(0)
	self:addElement(GuideBox2)
	self.GuideBox2 = GuideBox2
	local gamesettingImageSmall = LUI.UIFixedAspectRatioImage.new(0.77, 0.77, -187, 187, 0.5, 0.5, -54, 70)
	gamesettingImageSmall:subscribeToGlobalModel(f1_arg1, "GametypeSettings", "image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			gamesettingImageSmall:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(gamesettingImageSmall)
	self.gamesettingImageSmall = gamesettingImageSmall
	local gamesettingImageLarge = LUI.UIFixedAspectRatioImage.new(0.77, 0.77, -374, 374, 0.5, 0.5, -116, 132)
	gamesettingImageLarge:subscribeToGlobalModel(f1_arg1, "GametypeSettings", "image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			gamesettingImageLarge:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(gamesettingImageLarge)
	self.gamesettingImageLarge = gamesettingImageLarge
	self:mergeStateConditions({
		{
			stateName = "ShowLargePreview",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("GametypeSettings.showLargePreview")
			end,
		},
		{
			stateName = "ShowSmallPreview",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("GametypeSettings.showSmallPreview")
			end,
		},
	})
	local f1_local19 = self
	local f1_local20 = self.subscribeToModel
	local f1_local21 = Engine[0x8DF2E5447F384B9]()
	f1_local20(f1_local19, f1_local21["GametypeSettings.showLargePreview"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "GametypeSettings.showLargePreview",
		})
	end, false)
	f1_local19 = self
	f1_local20 = self.subscribeToModel
	f1_local21 = Engine[0x8DF2E5447F384B9]()
	f1_local20(f1_local19, f1_local21["GametypeSettings.showSmallPreview"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "GametypeSettings.showSmallPreview",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameSettings_SelectedItemInfo.__resetProperties = function(f8_arg0)
	f8_arg0.gamesettingImageLarge:completeAnimation()
	f8_arg0.gamesettingImageSmall:completeAnimation()
	f8_arg0.gamesettingImageLarge:setAlpha(1)
	f8_arg0.gamesettingImageSmall:setAlpha(1)
end
CoD.GameSettings_SelectedItemInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.gamesettingImageSmall:completeAnimation()
			f9_arg0.gamesettingImageSmall:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.gamesettingImageSmall)
			f9_arg0.gamesettingImageLarge:completeAnimation()
			f9_arg0.gamesettingImageLarge:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.gamesettingImageLarge)
		end,
	},
	ShowLargePreview = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.gamesettingImageSmall:completeAnimation()
			f10_arg0.gamesettingImageSmall:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.gamesettingImageSmall)
			f10_arg0.gamesettingImageLarge:completeAnimation()
			f10_arg0.gamesettingImageLarge:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.gamesettingImageLarge)
		end,
	},
	ShowSmallPreview = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.gamesettingImageSmall:completeAnimation()
			f11_arg0.gamesettingImageSmall:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.gamesettingImageSmall)
			f11_arg0.gamesettingImageLarge:completeAnimation()
			f11_arg0.gamesettingImageLarge:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.gamesettingImageLarge)
		end,
	},
}
CoD.GameSettings_SelectedItemInfo.__onClose = function(f12_arg0)
	f12_arg0.CommonDetailPanel:close()
	f12_arg0.ToolTip:close()
	f12_arg0.GameModeInfo:close()
	f12_arg0.GameModeName:close()
	f12_arg0.OfficialBadge:close()
	f12_arg0.GuideFrame:close()
	f12_arg0.GuideFrame2:close()
	f12_arg0.GuideFrame3:close()
	f12_arg0.gamesettingImageSmall:close()
	f12_arg0.gamesettingImageLarge:close()
end
