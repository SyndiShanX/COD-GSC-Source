require("x64:eda152e1d10147a")
require("x64:8b53d2ba8e4b74c")
require("x64:10483efa771121d")
require("x64:68bcc307dcc87ad")
require("x64:604be692d92c68c")
CoD.CamoPersonalizationDetails = InheritFrom(CoD.Menu)
LUI.createMenu.CamoPersonalizationDetails = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("CamoPersonalizationDetails", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	self:setClass(CoD.CamoPersonalizationDetails)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BackgroundSlidePanel = CoD.cac_background_slide_panel_short.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 0, 568, 1190)
	self:addElement(BackgroundSlidePanel)
	self.BackgroundSlidePanel = BackgroundSlidePanel
	local ActiveCamoStagesList = LUI.UIList.new(f1_local1, f1_arg0, 8, 0, nil, false, false, false, false)
	ActiveCamoStagesList:setLeftRight(0.5, 0.5, -138, 362)
	ActiveCamoStagesList:setTopBottom(0, 0, 678, 1006)
	ActiveCamoStagesList:setWidgetType(CoD.CommonListButtonLeft)
	ActiveCamoStagesList:setVerticalCount(7)
	ActiveCamoStagesList:setSpacing(8)
	ActiveCamoStagesList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ActiveCamoStagesList:setDataSource("ActiveCamoStagesList")
	ActiveCamoStagesList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f2_local0 = nil
		CoD.WeaponOptionsUtility.PreviewActiveCamoStages(f1_local1, element, f1_arg0)
		return f2_local0
	end)
	self:addElement(ActiveCamoStagesList)
	self.ActiveCamoStagesList = ActiveCamoStagesList
	local CamoDetailsSwatch = CoD.CamoDetailsSwatch.new(f1_local1, f1_arg0, 0, 0, 598, 808, 0, 0, 678, 1009)
	CamoDetailsSwatch:linkToElementModel(self, nil, false, function(model)
		CamoDetailsSwatch:setModel(model, f1_arg0)
	end)
	self:addElement(CamoDetailsSwatch)
	self.CamoDetailsSwatch = CamoDetailsSwatch
	local GenericMenuFrame = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	GenericMenuFrame.CommonHeader.subtitle.StageTitle:setText(Engine[0xF9F1239CFD921FE](CoD.WeaponOptionsUtility.GetCamoStageDetailsHeader(f1_local1, 0x2EEF729B41D6347)))
	GenericMenuFrame:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			GenericMenuFrame.CommonHeader.subtitle.subtitle:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(GenericMenuFrame)
	self.GenericMenuFrame = GenericMenuFrame
	local WeaponOptionInfoInternal = CoD.WeaponOptionInfoInternal.new(f1_local1, f1_arg0, 0, 0, 168, 648, 0, 0, 464, 594)
	WeaponOptionInfoInternal:mergeStateConditions({
		{
			stateName = "HideProgress",
			condition = function(menu, element, event)
				local f5_local0
				if not CoD.WeaponOptionsUtility.IsCamoBuyable(menu, self, f1_arg0) then
					f5_local0 = AlwaysFalse()
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "UnlockedReveal",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
		{
			stateName = "Unlocked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	WeaponOptionInfoInternal:linkToElementModel(WeaponOptionInfoInternal, "weaponOptionCategory", true, function(model)
		f1_local1:updateElementState(WeaponOptionInfoInternal, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "weaponOptionCategory",
		})
	end)
	WeaponOptionInfoInternal:linkToElementModel(WeaponOptionInfoInternal, "itemIndex", true, function(model)
		f1_local1:updateElementState(WeaponOptionInfoInternal, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	local f1_local7 = WeaponOptionInfoInternal
	local VisualStagesHeader = WeaponOptionInfoInternal.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	VisualStagesHeader(f1_local7, f1_local9["WeaponPersonalization.listUpdate"], function(f10_arg0)
		f1_local1:updateElementState(WeaponOptionInfoInternal, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "WeaponPersonalization.listUpdate",
		})
	end, false)
	WeaponOptionInfoInternal:linkToElementModel(WeaponOptionInfoInternal, "unlockProgressAndTarget", true, function(model)
		f1_local1:updateElementState(WeaponOptionInfoInternal, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "unlockProgressAndTarget",
		})
	end)
	f1_local7 = WeaponOptionInfoInternal
	VisualStagesHeader = WeaponOptionInfoInternal.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	VisualStagesHeader(f1_local7, f1_local9.paintCanCount, function(f12_arg0)
		f1_local1:updateElementState(WeaponOptionInfoInternal, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "paintCanCount",
		})
	end, false)
	WeaponOptionInfoInternal:linkToElementModel(self, nil, false, function(model)
		WeaponOptionInfoInternal:setModel(model, f1_arg0)
	end)
	self:addElement(WeaponOptionInfoInternal)
	self.WeaponOptionInfoInternal = WeaponOptionInfoInternal
	VisualStagesHeader = LUI.UIText.new(0, 0, 824, 1324, 0, 0, 590, 616)
	VisualStagesHeader:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	VisualStagesHeader:setText(LocalizeToUpperString(0xEFE5D00336839FB))
	VisualStagesHeader:setTTF("ttmussels_demibold")
	VisualStagesHeader:setLetterSpacing(4)
	VisualStagesHeader:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	VisualStagesHeader:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(VisualStagesHeader)
	self.VisualStagesHeader = VisualStagesHeader
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		CoD.CACUtility.PlayChooseScreenOutro(menu, controller, "Close")
		DelayGoBack(menu, controller, 200)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x78D439E1B360368, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		ClearMenuSavedState(f1_local1)
	end)
	ActiveCamoStagesList.id = "ActiveCamoStagesList"
	GenericMenuFrame:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		GenericMenuFrame.id = "GenericMenuFrame"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = ActiveCamoStagesList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local7 = self
	CoD.CACUtility.PlayChooseScreenIntro(f1_local1, f1_arg0, 200, "Open", true)
	SetElementProperty(ActiveCamoStagesList, "doNotResizeOnUpdateLayout", true)
	f1_local7 = WeaponOptionInfoInternal
	CoD.BaseUtility.SetModelFromPropertyModel(f1_arg0, self, f1_local1)
	return self
end
CoD.CamoPersonalizationDetails.__resetProperties = function(f17_arg0)
	f17_arg0.BackgroundSlidePanel:completeAnimation()
	f17_arg0.ActiveCamoStagesList:completeAnimation()
	f17_arg0.CamoDetailsSwatch:completeAnimation()
	f17_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 568, 1190)
	f17_arg0.BackgroundSlidePanel:setAlpha(1)
	f17_arg0.ActiveCamoStagesList:setTopBottom(0, 0, 678, 1006)
	f17_arg0.ActiveCamoStagesList:setAlpha(1)
	f17_arg0.CamoDetailsSwatch:setTopBottom(0, 0, 678, 1009)
	f17_arg0.CamoDetailsSwatch:setAlpha(1)
end
CoD.CamoPersonalizationDetails.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(3)
			f18_arg0.BackgroundSlidePanel:completeAnimation()
			f18_arg0.BackgroundSlidePanel:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.BackgroundSlidePanel)
			f18_arg0.ActiveCamoStagesList:completeAnimation()
			f18_arg0.ActiveCamoStagesList:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.ActiveCamoStagesList)
			f18_arg0.CamoDetailsSwatch:completeAnimation()
			f18_arg0.CamoDetailsSwatch:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.CamoDetailsSwatch)
		end,
		Open = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f21_arg0:setTopBottom(0, 0, 538, 1160)
					f21_arg0:setAlpha(1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.BackgroundSlidePanel:beginAnimation(100)
				f19_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 815, 1437)
				f19_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.BackgroundSlidePanel:completeAnimation()
			f19_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 1015, 1637)
			f19_arg0.BackgroundSlidePanel:setAlpha(0)
			f19_local0(f19_arg0.BackgroundSlidePanel)
			local f19_local1 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(100)
					f23_arg0:setTopBottom(0, 0, 625, 956)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.ActiveCamoStagesList:beginAnimation(100)
				f19_arg0.ActiveCamoStagesList:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ActiveCamoStagesList:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f19_arg0.ActiveCamoStagesList:completeAnimation()
			f19_arg0.ActiveCamoStagesList:setTopBottom(0, 0, 800, 1131)
			f19_arg0.ActiveCamoStagesList:setAlpha(0)
			f19_local1(f19_arg0.ActiveCamoStagesList)
			local f19_local2 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(100)
					f25_arg0:setTopBottom(0, 0, 625, 956)
					f25_arg0:setAlpha(1)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
				end
				f19_arg0.CamoDetailsSwatch:beginAnimation(100)
				f19_arg0.CamoDetailsSwatch:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.CamoDetailsSwatch:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f19_arg0.CamoDetailsSwatch:completeAnimation()
			f19_arg0.CamoDetailsSwatch:setTopBottom(0, 0, 800, 1131)
			f19_arg0.CamoDetailsSwatch:setAlpha(0)
			f19_local2(f19_arg0.CamoDetailsSwatch)
		end,
		Close = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
					f28_arg0:setTopBottom(0, 0, 815, 1437)
					f28_arg0:setAlpha(0)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.BackgroundSlidePanel:beginAnimation(50)
				f26_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 615, 1237)
				f26_arg0.BackgroundSlidePanel:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.BackgroundSlidePanel:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.BackgroundSlidePanel:completeAnimation()
			f26_arg0.BackgroundSlidePanel:setTopBottom(0, 0, 538, 1160)
			f26_arg0.BackgroundSlidePanel:setAlpha(1)
			f26_local0(f26_arg0.BackgroundSlidePanel)
			local f26_local1 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(100)
					f30_arg0:setTopBottom(0, 0, 800, 1131)
					f30_arg0:setAlpha(0)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.ActiveCamoStagesList:beginAnimation(50)
				f26_arg0.ActiveCamoStagesList:setTopBottom(0, 0, 676, 1007)
				f26_arg0.ActiveCamoStagesList:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ActiveCamoStagesList:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f26_arg0.ActiveCamoStagesList:completeAnimation()
			f26_arg0.ActiveCamoStagesList:setTopBottom(0, 0, 625, 956)
			f26_arg0.ActiveCamoStagesList:setAlpha(1)
			f26_local1(f26_arg0.ActiveCamoStagesList)
			local f26_local2 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(100)
					f32_arg0:setTopBottom(0, 0, 800, 1131)
					f32_arg0:setAlpha(0)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.CamoDetailsSwatch:beginAnimation(50)
				f26_arg0.CamoDetailsSwatch:setTopBottom(0, 0, 676, 1007)
				f26_arg0.CamoDetailsSwatch:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.CamoDetailsSwatch:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f26_arg0.CamoDetailsSwatch:completeAnimation()
			f26_arg0.CamoDetailsSwatch:setTopBottom(0, 0, 625, 956)
			f26_arg0.CamoDetailsSwatch:setAlpha(1)
			f26_local2(f26_arg0.CamoDetailsSwatch)
		end,
	},
}
CoD.CamoPersonalizationDetails.__onClose = function(f33_arg0)
	f33_arg0.BackgroundSlidePanel:close()
	f33_arg0.ActiveCamoStagesList:close()
	f33_arg0.CamoDetailsSwatch:close()
	f33_arg0.GenericMenuFrame:close()
	f33_arg0.WeaponOptionInfoInternal:close()
end
