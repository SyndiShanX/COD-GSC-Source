require("x64:ce1e6b6549d478c")
require("x64:57cec604c8a7e98")
require("x64:7d5f0d326cd7f45")
require("x64:f90425d9cc383e6")
CoD.Survey = InheritFrom(CoD.Menu)
LUI.createMenu.Survey = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("Survey", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.Survey)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0.03, 1.03, -64, -64, 0.06, 1.06, -64, -64)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local BackgroundImage = CoD.SuveryBackground.new(f1_local1, f1_arg0, 0, 0, 240, 1680, 0, 0, 135, 945)
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local BackingOverlay = LUI.UIImage.new(0, 0, 240, 1680, 0, 0, 135, 945)
	BackingOverlay:setRGB(0, 0, 0)
	BackingOverlay:setMaterial(LUI.UIImage.GetCachedMaterial(0xDE760AC0E801E57))
	BackingOverlay:setShaderVector(0, 0, 0, 0, 1)
	BackingOverlay:setShaderVector(1, 1, 1, 1, 0.4)
	BackingOverlay:setShaderVector(2, 0.65, 0, 0, 0)
	self:addElement(BackingOverlay)
	self.BackingOverlay = BackingOverlay
	local ResponseFrame = LUI.UIFrame.new(f1_local1, f1_arg0, 0, 0, false)
	ResponseFrame:setLeftRight(0.5, 0.5, -610.5, 204.5)
	ResponseFrame:setTopBottom(0.5, 0.5, -112, 316)
	ResponseFrame:subscribeToGlobalModel(f1_arg0, "SurveyQuestion", "responseWidget", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ResponseFrame:changeFrameWidget(f2_local0)
		end
	end)
	self:addElement(ResponseFrame)
	self.ResponseFrame = ResponseFrame
	local QuestionText = CoD.SurveyTexts.new(f1_local1, f1_arg0, 0.5, 0.5, -610.5, 40.5, 0.5, 0.5, -327, -180)
	QuestionText:subscribeToGlobalModel(f1_arg0, "SurveyQuestion", nil, function(model)
		QuestionText:setModel(model, f1_arg0)
	end)
	self:addElement(QuestionText)
	self.QuestionText = QuestionText
	local AnsweredSubTitle = CoD.SurveyThanks.new(f1_local1, f1_arg0, 0, 0, 349.5, 959.5, 0, 0, 479, 554)
	AnsweredSubTitle:setAlpha(0)
	self:addElement(AnsweredSubTitle)
	self.AnsweredSubTitle = AnsweredSubTitle
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	FooterContainerFrontendRight:subscribeToGlobalModel(f1_arg0, "StartMenuBreadcrumbs", "themenu", function(model)
		FooterContainerFrontendRight.LeftContainerPC.PersistentLeftContainer.FooterButtonPlayerAccount.Spacer3.newIcon:setModel(model, f1_arg0)
	end)
	FooterContainerFrontendRight:subscribeToGlobalModel(f1_arg0, "StartMenuBreadcrumbs", "themenu", function(model)
		FooterContainerFrontendRight.CenterContainer.Options.newIcon:setModel(model, f1_arg0)
	end)
	FooterContainerFrontendRight:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if not IsPC() then
			SizeToSafeArea(element, f1_arg0)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	self:mergeStateConditions({
		{
			stateName = "Answered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg0, "SurveyQuestion", "answered")
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = DataSources.SurveyQuestion.getModel(f1_arg0)
	f1_local10(f1_local9, f1_local11.answered, function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "answered",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = DataSources.SurveyQuestion.getModel(f1_arg0)
	f1_local10(f1_local9, f1_local11.answered, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.SurveyUtility.CloseSurvey(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "SurveyQuestion", "answered") then
			return true
		else
		end
	end, function(element, menu, controller)
		if not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(controller, "SurveyQuestion", "answered") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:subscribeToGlobalModel(f1_arg0, "SurveyQuestion", "surveyQuestionIndex", function(model)
		local f14_local0 = self
		UpdateDataSource(self, self.QuestionText, f1_arg0)
	end)
	ResponseFrame.id = "ResponseFrame"
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = ResponseFrame
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.Survey.__resetProperties = function(f15_arg0)
	f15_arg0.QuestionText:completeAnimation()
	f15_arg0.ResponseFrame:completeAnimation()
	f15_arg0.AnsweredSubTitle:completeAnimation()
	f15_arg0.QuestionText:setAlpha(1)
	f15_arg0.ResponseFrame:setAlpha(1)
	f15_arg0.AnsweredSubTitle:setAlpha(0)
end
CoD.Survey.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	Answered = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.ResponseFrame:completeAnimation()
			f17_arg0.ResponseFrame:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.ResponseFrame)
			f17_arg0.QuestionText:completeAnimation()
			f17_arg0.QuestionText:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.QuestionText)
			f17_arg0.AnsweredSubTitle:completeAnimation()
			f17_arg0.AnsweredSubTitle:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.AnsweredSubTitle)
		end,
	},
}
CoD.Survey.__onClose = function(f18_arg0)
	f18_arg0.BackgroundImage:close()
	f18_arg0.ResponseFrame:close()
	f18_arg0.QuestionText:close()
	f18_arg0.AnsweredSubTitle:close()
	f18_arg0.FooterContainerFrontendRight:close()
end
