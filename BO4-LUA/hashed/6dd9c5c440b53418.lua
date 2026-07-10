require("x64:ffbc64370f13dd9")
require("x64:89b04dc853e4449")
require("x64:d2fe0e2acf462d9")
require("x64:bd69df1474261e5")
require("x64:b61cab1fde61ef1")
CoD.SpecialistDossierInternal = InheritFrom(LUI.UIElement)
CoD.SpecialistDossierInternal.__defaultWidth = 1920
CoD.SpecialistDossierInternal.__defaultHeight = 1080
CoD.SpecialistDossierInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistDossierInternal)
	self.id = "SpecialistDossierInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local JobTitle = LUI.UIText.new(0.5, 0.5, -860, -360, 0.5, 0.5, -390, -370)
	JobTitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	JobTitle:setZoom(3)
	JobTitle:setText(LocalizeToUpperString(@"hash_41ADE64D69903E6E"))
	JobTitle:setTTF("ttmussels_regular")
	JobTitle:setLetterSpacing(10)
	JobTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(JobTitle)
	self.JobTitle = JobTitle
	local SpecialistName = LUI.UIText.new(0.5, 0.5, -860, -360, 0.5, 0.5, -370, -280)
	SpecialistName:setRGB(0.92, 0.89, 0.72)
	SpecialistName:setAlpha(0.7)
	SpecialistName:setZoom(3)
	SpecialistName:setTTF("ttmussels_regular")
	SpecialistName:setLetterSpacing(10)
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SpecialistName:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "callsign", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			SpecialistName:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local FilesHeader = LUI.UIText.new(0.5, 0.5, -860, -360, 0.5, 0.5, -80, -56)
	FilesHeader:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FilesHeader:setText(LocalizeToUpperString(@"hash_5A497494F91D625A"))
	FilesHeader:setTTF("ttmussels_regular")
	FilesHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	FilesHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(FilesHeader)
	self.FilesHeader = FilesHeader
	local BackstoryVideoButton = CoD.SpecialistDossierButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -865, -355, 0.5, 0.5, -56, -7)
	BackstoryVideoButton:mergeStateConditions({
		{
			stateName = "PCKorea15Plus",
			condition = function(menu, element, event)
				return IsPC() and CoD.PCKoreaUtility.ShowKorea15Plus()
			end,
		},
		{
			stateName = "MatureContentFiltered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistDossier", "backstoryVideoMatureContent") and not CoD.CTUtility.IsMatureContent(f1_arg1)
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistDossier", "backstoryVideoUnlocked")
			end,
		},
	})
	local BioHeader = BackstoryVideoButton
	local IntroVideoButton = BackstoryVideoButton.subscribeToModel
	local BioButton = DataSources.SpecialistDossier.getModel(f1_arg1)
	IntroVideoButton(BioHeader, BioButton.backstoryVideoMatureContent, function(f6_arg0)
		f1_arg0:updateElementState(BackstoryVideoButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "backstoryVideoMatureContent",
		})
	end, false)
	BioHeader = BackstoryVideoButton
	IntroVideoButton = BackstoryVideoButton.subscribeToModel
	BioButton = Engine[@"getglobalmodel"]()
	IntroVideoButton(BioHeader, BioButton["storageGlobalRoot.user_settings"], function(f7_arg0)
		f1_arg0:updateElementState(BackstoryVideoButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	BioHeader = BackstoryVideoButton
	IntroVideoButton = BackstoryVideoButton.subscribeToModel
	BioButton = DataSources.SpecialistDossier.getModel(f1_arg1)
	IntroVideoButton(BioHeader, BioButton.backstoryVideoUnlocked, function(f8_arg0)
		f1_arg0:updateElementState(BackstoryVideoButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "backstoryVideoUnlocked",
		})
	end, false)
	BackstoryVideoButton.SpecialistPersonalizationButtonOptionInternal.ButtonFrame.FocusGlow:setScale(1, 0.8)
	BackstoryVideoButton.ButtonText:setTTF("ttmussels_regular")
	BackstoryVideoButton:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "backstoryVideoDesc", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			BackstoryVideoButton.ButtonText:setText(f9_local0)
		end
	end)
	BioHeader = BackstoryVideoButton
	IntroVideoButton = BackstoryVideoButton.subscribeToModel
	BioButton = DataSources.SpecialistDossier.getModel(f1_arg1)
	IntroVideoButton(BioHeader, BioButton["backstoryVideo.hiResVideo.movieName"], function(f10_arg0, f10_arg1)
		CoD.Menu.UpdateButtonShownState(f10_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	BackstoryVideoButton:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f11_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BackstoryVideoButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(controller, "SpecialistDossier", "backstoryVideo.hiResVideo.movieName") and not IsElementInState(self.BackstoryVideoButton, "MatureContentFiltered") then
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, self.BackstoryPreview, "hiResVideo")
			SetLoseFocusToElement(self, "BackstoryVideoButton", controller)
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(controller, "SpecialistDossier", "backstoryVideo.hiResVideo.movieName") and not IsElementInState(self.BackstoryVideoButton, "MatureContentFiltered") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_D31D493AE40DA0F", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(BackstoryVideoButton, "childFocusGained", function(element)
		SetState(self, "ShowBackstoryVideo", f1_arg1)
	end)
	self:addElement(BackstoryVideoButton)
	self.BackstoryVideoButton = BackstoryVideoButton
	IntroVideoButton = CoD.SpecialistDossierButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -865, -355, 0.5, 0.5, 10, 53)
	IntroVideoButton:mergeStateConditions({
		{
			stateName = "MatureContentFiltered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistDossier", "introVideoMatureContent") and not CoD.CTUtility.IsMatureContent(f1_arg1)
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistDossier", "introVideoUnlocked")
			end,
		},
	})
	BioButton = IntroVideoButton
	BioHeader = IntroVideoButton.subscribeToModel
	local IntroPreview = DataSources.SpecialistDossier.getModel(f1_arg1)
	BioHeader(BioButton, IntroPreview.introVideoMatureContent, function(f17_arg0)
		f1_arg0:updateElementState(IntroVideoButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "introVideoMatureContent",
		})
	end, false)
	BioButton = IntroVideoButton
	BioHeader = IntroVideoButton.subscribeToModel
	IntroPreview = Engine[@"getglobalmodel"]()
	BioHeader(BioButton, IntroPreview["storageGlobalRoot.user_settings"], function(f18_arg0)
		f1_arg0:updateElementState(IntroVideoButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	BioButton = IntroVideoButton
	BioHeader = IntroVideoButton.subscribeToModel
	IntroPreview = DataSources.SpecialistDossier.getModel(f1_arg1)
	BioHeader(BioButton, IntroPreview.introVideoUnlocked, function(f19_arg0)
		f1_arg0:updateElementState(IntroVideoButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "introVideoUnlocked",
		})
	end, false)
	IntroVideoButton.SpecialistPersonalizationButtonOptionInternal.ButtonFrame.FocusGlow:setScale(1, 0.8)
	IntroVideoButton.ButtonText:setTTF("ttmussels_regular")
	IntroVideoButton:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "introVideoDesc", function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			IntroVideoButton.ButtonText:setText(Engine[@"hash_4F9F1239CFD921FE"](f20_local0))
		end
	end)
	BioButton = IntroVideoButton
	BioHeader = IntroVideoButton.subscribeToModel
	IntroPreview = DataSources.SpecialistDossier.getModel(f1_arg1)
	BioHeader(BioButton, IntroPreview["introVideo.hiResVideo.movieName"], function(f21_arg0, f21_arg1)
		CoD.Menu.UpdateButtonShownState(f21_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	IntroVideoButton:registerEventHandler("gain_focus", function(element, event)
		local f22_local0 = nil
		if element.gainFocus then
			f22_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f22_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f22_local0
	end)
	f1_arg0:AddButtonCallbackFunction(IntroVideoButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(controller, "SpecialistDossier", "introVideo.hiResVideo.movieName") and not IsElementInState(self.IntroVideoButton, "MatureContentFiltered") then
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, self.IntroPreview, "hiResVideo")
			SetLoseFocusToElement(self, "IntroVideoButton", controller)
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(controller, "SpecialistDossier", "introVideo.hiResVideo.movieName") and not IsElementInState(self.IntroVideoButton, "MatureContentFiltered") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_D31D493AE40DA0F", nil, nil)
			return true
		else
			return false
		end
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(IntroVideoButton, "childFocusGained", function(element)
		if IsPC() and CoD.PCKoreaUtility.ShowKorea15Plus() then
			SetState(self, "ShowIntroVideoKR15", f1_arg1)
		else
			SetState(self, "ShowIntroVideo", f1_arg1)
		end
	end)
	self:addElement(IntroVideoButton)
	self.IntroVideoButton = IntroVideoButton
	BioHeader = LUI.UIText.new(0.5, 0.5, -860, -360, 0.5, 0.5, 110, 134)
	BioHeader:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	BioHeader:setText(LocalizeToUpperString(@"hash_2BECB6115D1FE883"))
	BioHeader:setTTF("ttmussels_regular")
	BioHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	BioHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(BioHeader)
	self.BioHeader = BioHeader
	BioButton = CoD.SpecialistDossierButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -865, -355, 0.5, 0.5, 144, 315)
	BioButton.ButtonText:setTTF("ttmussels_regular")
	BioButton:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "bioPreview", function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			BioButton.ButtonText:setText(Engine[@"hash_4F9F1239CFD921FE"](f26_local0))
		end
	end)
	BioButton:registerEventHandler("gain_focus", function(element, event)
		local f27_local0 = nil
		if element.gainFocus then
			f27_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f27_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f27_local0
	end)
	f1_arg0:AddButtonCallbackFunction(BioButton, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		OpenOverlay(self, "SpecialistBio", controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_2BECB6115D1FE883", nil, "ui_confirm")
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(BioButton, "childFocusGained", function(element)
		if IsPC() and CoD.PCKoreaUtility.ShowKorea15Plus() then
			SetState(self, "DefaultStateKR15", f1_arg1)
		else
			SetState(self, "DefaultState", f1_arg1)
		end
	end)
	self:addElement(BioButton)
	self.BioButton = BioButton
	IntroPreview = CoD.DossierVoDPreview.new(f1_arg0, f1_arg1, 0.5, 0.5, 350, 860, 0.5, 0.5, -340, 40)
	IntroPreview:mergeStateConditions({
		{
			stateName = "MatureContentFiltered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistDossier", "introVideoMatureContent") and not CoD.CTUtility.IsMatureContent(f1_arg1)
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistDossier", "introVideoUnlocked")
			end,
		},
	})
	local Designation = IntroPreview
	local BackstoryPreview = IntroPreview.subscribeToModel
	local f1_local11 = DataSources.SpecialistDossier.getModel(f1_arg1)
	BackstoryPreview(Designation, f1_local11.introVideoMatureContent, function(f33_arg0)
		f1_arg0:updateElementState(IntroPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "introVideoMatureContent",
		})
	end, false)
	Designation = IntroPreview
	BackstoryPreview = IntroPreview.subscribeToModel
	f1_local11 = Engine[@"getglobalmodel"]()
	BackstoryPreview(Designation, f1_local11["storageGlobalRoot.user_settings"], function(f34_arg0)
		f1_arg0:updateElementState(IntroPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	Designation = IntroPreview
	BackstoryPreview = IntroPreview.subscribeToModel
	f1_local11 = DataSources.SpecialistDossier.getModel(f1_arg1)
	BackstoryPreview(Designation, f1_local11.introVideoUnlocked, function(f35_arg0)
		f1_arg0:updateElementState(IntroPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "introVideoUnlocked",
		})
	end, false)
	IntroPreview:setAlpha(0)
	IntroPreview:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "introVideo", function(model)
		IntroPreview:setModel(model, f1_arg1)
	end)
	IntroPreview:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "introVideoTitle", function(model)
		local f37_local0 = model:get()
		if f37_local0 ~= nil then
			IntroPreview.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f37_local0))
		end
	end)
	IntroPreview:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "introVideoDesc", function(model)
		local f38_local0 = model:get()
		if f38_local0 ~= nil then
			IntroPreview.Desc:setText(Engine[@"hash_4F9F1239CFD921FE"](f38_local0))
		end
	end)
	self:addElement(IntroPreview)
	self.IntroPreview = IntroPreview
	BackstoryPreview = CoD.DossierVoDPreview.new(f1_arg0, f1_arg1, 0.5, 0.5, 350, 860, 0.5, 0.5, -340, 40)
	BackstoryPreview:mergeStateConditions({
		{
			stateName = "MatureContentFiltered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistDossier", "backstoryVideoMatureContent") and not CoD.CTUtility.IsMatureContent(f1_arg1)
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistDossier", "backstoryVideoUnlocked")
			end,
		},
	})
	f1_local11 = BackstoryPreview
	Designation = BackstoryPreview.subscribeToModel
	local f1_local12 = DataSources.SpecialistDossier.getModel(f1_arg1)
	Designation(f1_local11, f1_local12.backstoryVideoMatureContent, function(f41_arg0)
		f1_arg0:updateElementState(BackstoryPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "backstoryVideoMatureContent",
		})
	end, false)
	f1_local11 = BackstoryPreview
	Designation = BackstoryPreview.subscribeToModel
	f1_local12 = Engine[@"getglobalmodel"]()
	Designation(f1_local11, f1_local12["storageGlobalRoot.user_settings"], function(f42_arg0)
		f1_arg0:updateElementState(BackstoryPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	f1_local11 = BackstoryPreview
	Designation = BackstoryPreview.subscribeToModel
	f1_local12 = DataSources.SpecialistDossier.getModel(f1_arg1)
	Designation(f1_local11, f1_local12.backstoryVideoUnlocked, function(f43_arg0)
		f1_arg0:updateElementState(BackstoryPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "backstoryVideoUnlocked",
		})
	end, false)
	BackstoryPreview:setAlpha(0)
	BackstoryPreview:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "backstoryVideo", function(model)
		BackstoryPreview:setModel(model, f1_arg1)
	end)
	BackstoryPreview:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "backstoryVideoTitle", function(model)
		local f45_local0 = model:get()
		if f45_local0 ~= nil then
			BackstoryPreview.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f45_local0))
		end
	end)
	BackstoryPreview:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "backstoryVideoDesc", function(model)
		local f46_local0 = model:get()
		if f46_local0 ~= nil then
			BackstoryPreview.Desc:setText(Engine[@"hash_4F9F1239CFD921FE"](f46_local0))
		end
	end)
	self:addElement(BackstoryPreview)
	self.BackstoryPreview = BackstoryPreview
	Designation = CoD.SpecialistDossierInternalBioText.new(f1_arg0, f1_arg1, 0.5, 0.5, -865, -355, 0.5, 0.5, -285, -155)
	self:addElement(Designation)
	self.Designation = Designation
	self:mergeStateConditions({
		{
			stateName = "DefaultStateKR15",
			condition = function(menu, element, event)
				return IsPC() and CoD.PCKoreaUtility.ShowKorea15Plus()
			end,
		},
		{
			stateName = "ShowBackstoryVideo",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "ShowIntroVideo",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "ShowIntroVideoKR15",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	BackstoryVideoButton.id = "BackstoryVideoButton"
	IntroVideoButton.id = "IntroVideoButton"
	BioButton.id = "BioButton"
	IntroPreview.id = "IntroPreview"
	BackstoryPreview.id = "BackstoryPreview"
	self.__defaultFocus = BackstoryVideoButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistDossierInternal.__resetProperties = function(f51_arg0)
	f51_arg0.IntroVideoButton:completeAnimation()
	f51_arg0.BackstoryPreview:completeAnimation()
	f51_arg0.IntroPreview:completeAnimation()
	f51_arg0.IntroVideoButton:setTopBottom(0.5, 0.5, 10, 53)
	f51_arg0.BackstoryPreview:setAlpha(0)
	f51_arg0.IntroPreview:setAlpha(0)
end
CoD.SpecialistDossierInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStateKR15 = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(1)
			f53_arg0.IntroVideoButton:completeAnimation()
			f53_arg0.IntroVideoButton:setTopBottom(0.5, 0.5, -50, -7)
			f53_arg0.clipFinished(f53_arg0.IntroVideoButton)
		end,
	},
	ShowBackstoryVideo = {
		DefaultClip = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(1)
			f54_arg0.BackstoryPreview:completeAnimation()
			f54_arg0.BackstoryPreview:setAlpha(1)
			f54_arg0.clipFinished(f54_arg0.BackstoryPreview)
		end,
	},
	ShowIntroVideo = {
		DefaultClip = function(f55_arg0, f55_arg1)
			f55_arg0:__resetProperties()
			f55_arg0:setupElementClipCounter(1)
			f55_arg0.IntroPreview:completeAnimation()
			f55_arg0.IntroPreview:setAlpha(1)
			f55_arg0.clipFinished(f55_arg0.IntroPreview)
		end,
	},
	ShowIntroVideoKR15 = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(2)
			f56_arg0.IntroVideoButton:completeAnimation()
			f56_arg0.IntroVideoButton:setTopBottom(0.5, 0.5, -50, -7)
			f56_arg0.clipFinished(f56_arg0.IntroVideoButton)
			f56_arg0.IntroPreview:completeAnimation()
			f56_arg0.IntroPreview:setAlpha(1)
			f56_arg0.clipFinished(f56_arg0.IntroPreview)
		end,
	},
}
CoD.SpecialistDossierInternal.__onClose = function(f57_arg0)
	f57_arg0.SpecialistName:close()
	f57_arg0.BackstoryVideoButton:close()
	f57_arg0.IntroVideoButton:close()
	f57_arg0.BioButton:close()
	f57_arg0.IntroPreview:close()
	f57_arg0.BackstoryPreview:close()
	f57_arg0.Designation:close()
end
