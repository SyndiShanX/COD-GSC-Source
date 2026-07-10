require("x64:72d343f937cb957")
require("x64:62080ad3aaa22da")
require("x64:1f150bc74d5590f")
require("x64:c3fa19037d61cad")
require("x64:38c11a77e96e48c")
CoD.StartMenu_Personalization_ZM = InheritFrom(LUI.UIElement)
CoD.StartMenu_Personalization_ZM.__defaultWidth = 1920
CoD.StartMenu_Personalization_ZM.__defaultHeight = 780
CoD.StartMenu_Personalization_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Personalization_ZM)
	self.id = "StartMenu_Personalization_ZM"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CommonBgLayoutLinkLine = CoD.CommonBgLayoutLinkLine.new(f1_arg0, f1_arg1, 0.5, 0.5, 234, 943, 0.5, 0.5, -335.5, -306.5)
	CommonBgLayoutLinkLine:setAlpha(0.5)
	CommonBgLayoutLinkLine:setZRot(180)
	self:addElement(CommonBgLayoutLinkLine)
	self.CommonBgLayoutLinkLine = CommonBgLayoutLinkLine
	local CommonBgLayoutLinkLine2 = CoD.CommonBgLayoutLinkLine.new(f1_arg0, f1_arg1, 0.5, 0.5, -30.5, 678.5, 0.5, 0.5, -88.5, -59.5)
	CommonBgLayoutLinkLine2:setAlpha(0.9)
	CommonBgLayoutLinkLine2:setZRot(-90)
	self:addElement(CommonBgLayoutLinkLine2)
	self.CommonBgLayoutLinkLine2 = CommonBgLayoutLinkLine2
	local CommonInformationFrame = CoD.CommonInformationFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, 324, 811, 0.5, 0.5, -228, 275)
	CommonInformationFrame.SceneBlur:setAlpha(0)
	self:addElement(CommonInformationFrame)
	self.CommonInformationFrame = CommonInformationFrame
	local specialists = LUI.UIList.new(f1_arg0, f1_arg1, 12, 0, nil, false, false, false, false)
	specialists:setLeftRight(0.5, 0.5, -589, 55)
	specialists:setTopBottom(0.5, 0.5, -271.5, 271.5)
	specialists:setWidgetType(CoD.HubSpecialist_character)
	specialists:setHorizontalCount(4)
	specialists:setVerticalCount(3)
	specialists:setSpacing(12)
	specialists:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	specialists:setFilter(function(f2_arg0)
		return f2_arg0.hasCustomization:get() == true
	end)
	specialists:setDataSource("PositionLoadoutList")
	specialists:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(specialists, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		PlaySoundAlias("uin_toggle_generic")
		CoD.ZMStoryUtility.UpdateSelectedCharacterStory(element, controller)
		OpenOverlay(self, "PersonalizeCharacter", controller, {
			model = element:getModel(),
			properties = {
				_sessionMode = menu._sessionMode,
				_storageLoadoutBuffer = menu._storageLoadoutBuffer,
			},
		})
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	self:addElement(specialists)
	self.specialists = specialists
	local SpecialistCornerTR = LUI.UIImage.new(0.5, 0.5, 75, 99, 0.5, 0.5, -288, -264)
	SpecialistCornerTR:setAlpha(0.25)
	SpecialistCornerTR:setZRot(-90)
	SpecialistCornerTR:setScale(0.5, 0.5)
	SpecialistCornerTR:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerTR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerTR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTR)
	self.SpecialistCornerTR = SpecialistCornerTR
	local SpecialistCornerTL = LUI.UIImage.new(0.5, 0.5, -634, -610, 0.5, 0.5, -288, -264)
	SpecialistCornerTL:setAlpha(0.2)
	SpecialistCornerTL:setScale(0.5, 0.5)
	SpecialistCornerTL:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerTL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerTL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerTL)
	self.SpecialistCornerTL = SpecialistCornerTL
	local SpecialistCornerBR = LUI.UIImage.new(0.5, 0.5, 75, 99, 0.5, 0.5, 288.5, 312.5)
	SpecialistCornerBR:setAlpha(0.2)
	SpecialistCornerBR:setZRot(180)
	SpecialistCornerBR:setScale(0.5, 0.5)
	SpecialistCornerBR:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerBR:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerBR:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerBR)
	self.SpecialistCornerBR = SpecialistCornerBR
	local SpecialistCornerBL = LUI.UIImage.new(0.5, 0.5, -634, -610, 0.5, 0.5, 288.5, 312.5)
	SpecialistCornerBL:setAlpha(0.2)
	SpecialistCornerBL:setZRot(90)
	SpecialistCornerBL:setScale(0.5, 0.5)
	SpecialistCornerBL:setImage(RegisterImage(0x8DC834094E7A02C))
	SpecialistCornerBL:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	SpecialistCornerBL:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(SpecialistCornerBL)
	self.SpecialistCornerBL = SpecialistCornerBL
	local verticalCounter = CoD.verticalCounter.new(f1_arg0, f1_arg1, 0.5, 0.5, -417, -117, 0.5, 0.5, 299.5, 336.5)
	self:addElement(verticalCounter)
	self.verticalCounter = verticalCounter
	CommonInformationFrame:linkToElementModel(specialists, "jobTitle", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			CommonInformationFrame.altHeader:setText(Engine[0xF9F1239CFD921FE](f6_local0))
		end
	end)
	CommonInformationFrame:linkToElementModel(specialists, "name", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CommonInformationFrame.header:setText(LocalizeToUpperString(f7_local0))
		end
	end)
	CommonInformationFrame:linkToElementModel(specialists, "detailedDesc", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			CommonInformationFrame.description:setText(Engine[0xF9F1239CFD921FE](f8_local0))
		end
	end)
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = DataSources.CharacterBreadcrumbs.getModel(f1_arg1)
	f1_local11(f1_local10, f1_local12.breadcrumbCount, function(f9_arg0, f9_arg1)
		CoD.Menu.UpdateButtonShownState(f9_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD])
	end, false)
	f1_arg0:AddButtonCallbackFunction(self, f1_arg1, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], "ui_contextual_2", function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and not IsPC() then
			CoD.BreadcrumbUtility.ClearAllPersonalizationBreadcrumbs(menu, controller)
			UpdateElementState(self, "specialists", controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(controller, "CharacterBreadcrumbs", "breadcrumbCount", 0) and not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x29E5695FF1401AD], 0x5619D8212EDA599, nil, "ui_contextual_2")
			return true
		else
			return false
		end
	end, false)
	specialists.id = "specialists"
	verticalCounter.id = "verticalCounter"
	self.__defaultFocus = specialists
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local11 = self
	SetAsListVerticalCounter(self, verticalCounter, "specialists")
	return self
end
CoD.StartMenu_Personalization_ZM.__resetProperties = function(f12_arg0)
	f12_arg0.SpecialistCornerBL:completeAnimation()
	f12_arg0.SpecialistCornerBR:completeAnimation()
	f12_arg0.SpecialistCornerTL:completeAnimation()
	f12_arg0.SpecialistCornerTR:completeAnimation()
	f12_arg0.specialists:completeAnimation()
	f12_arg0.CommonInformationFrame:completeAnimation()
	f12_arg0.verticalCounter:completeAnimation()
	f12_arg0.SpecialistCornerBL:setAlpha(0.2)
	f12_arg0.SpecialistCornerBR:setAlpha(0.2)
	f12_arg0.SpecialistCornerTL:setAlpha(0.2)
	f12_arg0.SpecialistCornerTR:setAlpha(0.25)
	f12_arg0.specialists:setAlpha(1)
	f12_arg0.CommonInformationFrame:setAlpha(1)
	f12_arg0.verticalCounter:setAlpha(1)
end
CoD.StartMenu_Personalization_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(7)
			local f13_local0 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(160)
					f15_arg0:setAlpha(1)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.CommonInformationFrame:beginAnimation(340)
				f13_arg0.CommonInformationFrame:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.CommonInformationFrame:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f13_arg0.CommonInformationFrame:completeAnimation()
			f13_arg0.CommonInformationFrame:setAlpha(0)
			f13_local0(f13_arg0.CommonInformationFrame)
			local f13_local1 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(150)
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.specialists:beginAnimation(100)
				f13_arg0.specialists:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.specialists:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f13_arg0.specialists:completeAnimation()
			f13_arg0.specialists:setAlpha(0)
			f13_local1(f13_arg0.specialists)
			local f13_local2 = function(f18_arg0)
				f13_arg0.SpecialistCornerTR:beginAnimation(150)
				f13_arg0.SpecialistCornerTR:setAlpha(0.25)
				f13_arg0.SpecialistCornerTR:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SpecialistCornerTR:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SpecialistCornerTR:completeAnimation()
			f13_arg0.SpecialistCornerTR:setAlpha(0)
			f13_local2(f13_arg0.SpecialistCornerTR)
			local f13_local3 = function(f19_arg0)
				f13_arg0.SpecialistCornerTL:beginAnimation(150)
				f13_arg0.SpecialistCornerTL:setAlpha(0.2)
				f13_arg0.SpecialistCornerTL:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SpecialistCornerTL:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SpecialistCornerTL:completeAnimation()
			f13_arg0.SpecialistCornerTL:setAlpha(0)
			f13_local3(f13_arg0.SpecialistCornerTL)
			local f13_local4 = function(f20_arg0)
				f13_arg0.SpecialistCornerBR:beginAnimation(150)
				f13_arg0.SpecialistCornerBR:setAlpha(0.2)
				f13_arg0.SpecialistCornerBR:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SpecialistCornerBR:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SpecialistCornerBR:completeAnimation()
			f13_arg0.SpecialistCornerBR:setAlpha(0)
			f13_local4(f13_arg0.SpecialistCornerBR)
			local f13_local5 = function(f21_arg0)
				f13_arg0.SpecialistCornerBL:beginAnimation(150)
				f13_arg0.SpecialistCornerBL:setAlpha(0.2)
				f13_arg0.SpecialistCornerBL:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.SpecialistCornerBL:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
			end
			f13_arg0.SpecialistCornerBL:completeAnimation()
			f13_arg0.SpecialistCornerBL:setAlpha(0)
			f13_local5(f13_arg0.SpecialistCornerBL)
			local f13_local6 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(150)
					f23_arg0:setAlpha(1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f13_arg0.clipFinished)
				end
				f13_arg0.verticalCounter:beginAnimation(250)
				f13_arg0.verticalCounter:registerEventHandler("interrupted_keyframe", f13_arg0.clipInterrupted)
				f13_arg0.verticalCounter:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f13_arg0.verticalCounter:completeAnimation()
			f13_arg0.verticalCounter:setAlpha(0)
			f13_local6(f13_arg0.verticalCounter)
		end,
	},
}
CoD.StartMenu_Personalization_ZM.__onClose = function(f24_arg0)
	f24_arg0.CommonInformationFrame:close()
	f24_arg0.CommonBgLayoutLinkLine:close()
	f24_arg0.CommonBgLayoutLinkLine2:close()
	f24_arg0.specialists:close()
	f24_arg0.verticalCounter:close()
end
