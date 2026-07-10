require("x64:8e365157595e290")
require("x64:d9acc80d127472d")
CoD.GameSettings_Description = InheritFrom(LUI.UIElement)
CoD.GameSettings_Description.__defaultWidth = 674
CoD.GameSettings_Description.__defaultHeight = 600
CoD.GameSettings_Description.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameSettings_Description)
	self.id = "GameSettings_Description"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 202)
	Background:setRGB(0.5, 0.5, 0.5)
	Background:setAlpha(0)
	self:addElement(Background)
	self.Background = Background
	local TitleBox = CoD.scorestreaks_TitleBox.new(f1_arg0, f1_arg1, 0, 0, -2, 672, 0, 0, -7, 45)
	TitleBox:setRGB(0.92, 0.89, 0.72)
	TitleBox:subscribeToGlobalModel(f1_arg1, "GametypeSettings", "title", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TitleBox.ScorestreaksLabel:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(TitleBox)
	self.TitleBox = TitleBox
	local GameSettingsOptionstextbox = CoD.GameSettings_Optionstextbox.new(f1_arg0, f1_arg1, 0.54, 0.54, -362.5, 311.5, 0, 0, 60, 93)
	GameSettingsOptionstextbox.TextBox:setAlpha(0.15)
	GameSettingsOptionstextbox:subscribeToGlobalModel(f1_arg1, "GametypeSettings", "description", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GameSettingsOptionstextbox.TextBox:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(GameSettingsOptionstextbox)
	self.GameSettingsOptionstextbox = GameSettingsOptionstextbox
	local Dotline = LUI.UIImage.new(0.5, 0.5, -337, 337, 0, 0, 46, 48)
	Dotline:setImage(RegisterImage(0xF9C7F41C631866E))
	Dotline:setMaterial(LUI.UIImage.GetCachedMaterial(0x73D72BCD14C2AAD))
	Dotline:setShaderVector(0, 1.2, 1, 0, 0)
	Dotline:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(Dotline)
	self.Dotline = Dotline
	local Dotline2 = LUI.UIImage.new(0.5, 0.5, -337, 337, 0, 0, 46, 48)
	Dotline2:setImage(RegisterImage(0xF9C7F41C631866E))
	Dotline2:setMaterial(LUI.UIImage.GetCachedMaterial(0xD8EA9FE9B0BCF75))
	Dotline2:setShaderVector(0, 1.2, 1, 0, 0)
	Dotline2:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(Dotline2)
	self.Dotline2 = Dotline2
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(f1_arg1, "GametypeSettings", "title")
			end,
		},
		{
			stateName = "ExtraVeryLongText",
			condition = function(menu, element, event)
				return TextHeightGreaterThan(self, "Description", 275)
			end,
		},
		{
			stateName = "VeryLongText",
			condition = function(menu, element, event)
				return TextHeightGreaterThan(self, "Description", 175)
			end,
		},
		{
			stateName = "LongText",
			condition = function(menu, element, event)
				return TextHeightGreaterThan(self, "Description", 75)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.GametypeSettings.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.title, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "title",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameSettings_Description.__resetProperties = function(f9_arg0)
	f9_arg0.TitleBox:completeAnimation()
	f9_arg0.GameSettingsOptionstextbox:completeAnimation()
	f9_arg0.Background:completeAnimation()
	f9_arg0.TitleBox:setAlpha(1)
	f9_arg0.GameSettingsOptionstextbox:setAlpha(1)
	f9_arg0.Background:setLeftRight(0, 1, 0, 0)
	f9_arg0.Background:setTopBottom(0, 0, 0, 202)
end
CoD.GameSettings_Description.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.TitleBox:completeAnimation()
			f11_arg0.TitleBox:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.TitleBox)
			f11_arg0.GameSettingsOptionstextbox:completeAnimation()
			f11_arg0.GameSettingsOptionstextbox:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.GameSettingsOptionstextbox)
		end,
	},
	ExtraVeryLongText = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Background:completeAnimation()
			f12_arg0.Background:setLeftRight(0, 1, 0, 0)
			f12_arg0.Background:setTopBottom(0, 0, 0, 600)
			f12_arg0.clipFinished(f12_arg0.Background)
		end,
	},
	VeryLongText = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Background:completeAnimation()
			f13_arg0.Background:setLeftRight(0, 1, 0, 0)
			f13_arg0.Background:setTopBottom(0, 0, 0, 450)
			f13_arg0.clipFinished(f13_arg0.Background)
		end,
	},
	LongText = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.Background:completeAnimation()
			f14_arg0.Background:setLeftRight(0, 1, 0, 0)
			f14_arg0.Background:setTopBottom(0, 0, 0, 322)
			f14_arg0.clipFinished(f14_arg0.Background)
		end,
	},
}
CoD.GameSettings_Description.__onClose = function(f15_arg0)
	f15_arg0.TitleBox:close()
	f15_arg0.GameSettingsOptionstextbox:close()
end
