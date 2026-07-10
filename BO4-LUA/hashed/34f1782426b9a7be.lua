CoD.SuveryBackground = InheritFrom(LUI.UIElement)
CoD.SuveryBackground.__defaultWidth = 1440
CoD.SuveryBackground.__defaultHeight = 810
CoD.SuveryBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SuveryBackground)
	self.id = "SuveryBackground"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackgroundImage = LUI.UIImage.new(0.5, 0.5, -720, 720, 0.5, 0.5, -405, 405)
	BackgroundImage:setAlpha(0)
	BackgroundImage:setImage(RegisterImage(@"img_t7_menu_mp_loadscreen_splash"))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local SurveyBackgroundArena = LUI.UIImage.new(0, 0, 0, 1440, 0, 0, 0, 812)
	SurveyBackgroundArena:setAlpha(0)
	SurveyBackgroundArena:setImage(RegisterImage(@"uie_ui_menu_survey_arena"))
	self:addElement(SurveyBackgroundArena)
	self.SurveyBackgroundArena = SurveyBackgroundArena
	local SurveyBackgroundMP = LUI.UIImage.new(0, 0, 0, 1440, 0, 0, 0, 812)
	SurveyBackgroundMP:setAlpha(0)
	SurveyBackgroundMP:setImage(RegisterImage(@"uie_ui_menu_survey_mp"))
	self:addElement(SurveyBackgroundMP)
	self.SurveyBackgroundMP = SurveyBackgroundMP
	local SurveyBackgroundWZ = LUI.UIImage.new(0, 0, 0, 1440, 0, 0, 0, 812)
	SurveyBackgroundWZ:setAlpha(0)
	SurveyBackgroundWZ:setImage(RegisterImage(@"uie_ui_menu_survey_wz"))
	self:addElement(SurveyBackgroundWZ)
	self.SurveyBackgroundWZ = SurveyBackgroundWZ
	local SurveyBackgroundZM = LUI.UIImage.new(0, 0, 0, 1440, 0, 0, 0, 812)
	SurveyBackgroundZM:setAlpha(0)
	SurveyBackgroundZM:setImage(RegisterImage(@"uie_ui_menu_survey_zm"))
	self:addElement(SurveyBackgroundZM)
	self.SurveyBackgroundZM = SurveyBackgroundZM
	self:mergeStateConditions({
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return IsArenaMode()
			end,
		},
		{
			stateName = "MP",
			condition = function(menu, element, event)
				return IsMultiplayer()
			end,
		},
		{
			stateName = "WZ",
			condition = function(menu, element, event)
				return IsWarzone()
			end,
		},
		{
			stateName = "ZM",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SuveryBackground.__resetProperties = function(f7_arg0)
	f7_arg0.SurveyBackgroundArena:completeAnimation()
	f7_arg0.SurveyBackgroundMP:completeAnimation()
	f7_arg0.SurveyBackgroundWZ:completeAnimation()
	f7_arg0.SurveyBackgroundZM:completeAnimation()
	f7_arg0.SurveyBackgroundArena:setAlpha(0)
	f7_arg0.SurveyBackgroundMP:setAlpha(0)
	f7_arg0.SurveyBackgroundWZ:setAlpha(0)
	f7_arg0.SurveyBackgroundZM:setAlpha(0)
end
CoD.SuveryBackground.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Arena = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.SurveyBackgroundArena:completeAnimation()
			f9_arg0.SurveyBackgroundArena:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.SurveyBackgroundArena)
		end,
	},
	MP = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.SurveyBackgroundMP:completeAnimation()
			f10_arg0.SurveyBackgroundMP:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.SurveyBackgroundMP)
		end,
	},
	WZ = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.SurveyBackgroundWZ:completeAnimation()
			f11_arg0.SurveyBackgroundWZ:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.SurveyBackgroundWZ)
		end,
	},
	ZM = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.SurveyBackgroundZM:completeAnimation()
			f12_arg0.SurveyBackgroundZM:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.SurveyBackgroundZM)
		end,
	},
}
