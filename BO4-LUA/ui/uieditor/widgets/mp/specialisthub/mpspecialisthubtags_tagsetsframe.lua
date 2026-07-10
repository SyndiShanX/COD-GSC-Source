require("x64:2d64ca9d3c705ce")
require("x64:87dfa54b5d08484")
require("x64:a2cc8976ed23254")
require("x64:38c11a77e96e48c")
require("x64:c7e896ee4bc3f8")
CoD.MPSpecialistHUBTags_TagSetsFrame = InheritFrom(LUI.UIElement)
CoD.MPSpecialistHUBTags_TagSetsFrame.__defaultWidth = 1920
CoD.MPSpecialistHUBTags_TagSetsFrame.__defaultHeight = 1080
CoD.MPSpecialistHUBTags_TagSetsFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MPSpecialistHUBTags_TagSetsFrame)
	self.id = "MPSpecialistHUBTags_TagSetsFrame"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FramingCornerBrackets = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0, 0, 133, 1162, 0, 0, 146, 878)
	FramingCornerBrackets:setAlpha(0.1)
	self:addElement(FramingCornerBrackets)
	self.FramingCornerBrackets = FramingCornerBrackets
	local emblemListBg2 = LUI.UIImage.new(0, 0, 17.5, 1278.5, 0, 0, 81, 926)
	emblemListBg2:setScale(0.77, 0.77)
	emblemListBg2:setImage(RegisterImage(0xCE384B31419E220))
	emblemListBg2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	emblemListBg2:setShaderVector(0, 0, 0, 0, 0)
	emblemListBg2:setupNineSliceShader(212, 212)
	self:addElement(emblemListBg2)
	self.emblemListBg2 = emblemListBg2
	local tags = LUI.UIList.new(f1_arg0, f1_arg1, 11, 0, nil, true, false, false, false)
	tags:setLeftRight(0, 0, 164, 1131)
	tags:setTopBottom(0, 0, 179, 820)
	tags:setWidgetType(CoD.HubTagButton)
	tags:setHorizontalCount(6)
	tags:setVerticalCount(4)
	tags:setSpacing(11)
	tags:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	tags:setDataSource("SpecialistTagSetsList")
	tags:linkToElementModel(tags, "owned", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	tags:linkToElementModel(tags, "trialLocked", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	tags:registerEventHandler("list_item_lose_focus", function(element, event)
		local f4_local0 = nil
		CoD.BreadcrumbUtility.SetSprayGestureAsOld(f1_arg0, element, f1_arg1)
		return f4_local0
	end)
	tags:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(tags, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			PlaySoundAlias("uin_main_edit")
			CoD.PlayerRoleUtility.BindGestureTagToSlot(menu, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "owned") and not CoD.ModelUtility.IsSelfModelValueTrue(element, controller, "trialLocked") then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(tags)
	self.tags = tags
	local verticalCounter = CoD.verticalCounter.new(f1_arg0, f1_arg1, 0, 0, 164, 1131, 0, 0, 820, 857)
	self:addElement(verticalCounter)
	self.verticalCounter = verticalCounter
	local DotLineBottom = LUI.UIImage.new(0.5, 0.5, -799.5, 174.5, 0, 0, 859, 863)
	DotLineBottom:setAlpha(0.4)
	DotLineBottom:setImage(RegisterImage(0xF9C7F41C631866E))
	DotLineBottom:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	DotLineBottom:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineBottom)
	self.DotLineBottom = DotLineBottom
	local DotLineTop = LUI.UIImage.new(0.5, 0.5, -799.5, 174.5, 0, 0, 161, 165)
	DotLineTop:setAlpha(0.4)
	DotLineTop:setImage(RegisterImage(0xF9C7F41C631866E))
	DotLineTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	DotLineTop:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(DotLineTop)
	self.DotLineTop = DotLineTop
	local HUBTagPreview = CoD.HUBTagPreview.new(f1_arg0, f1_arg1, 0, 0, 1216, 1763, 0, 0, 179, 869)
	self:addElement(HUBTagPreview)
	self.HUBTagPreview = HUBTagPreview
	local TrialWidget = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0, 0, 1216.5, 1763.5, 0, 0, 878, 913)
	TrialWidget:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "trialLocked")
			end,
		},
	})
	TrialWidget:linkToElementModel(TrialWidget, "trialLocked", true, function(model)
		f1_arg0:updateElementState(TrialWidget, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	local TrialWidgetLocked = CoD.TrialInfoBannerWidget.new(f1_arg0, f1_arg1, 0, 0, 1216.5, 1763.5, 0, 0, 878, 913)
	TrialWidgetLocked:mergeStateConditions({
		{
			stateName = "Shown",
			condition = function(menu, element, event)
				return IsGameTrial() and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "lootLocked")
			end,
		},
	})
	TrialWidgetLocked:linkToElementModel(TrialWidgetLocked, "lootLocked", true, function(model)
		f1_arg0:updateElementState(TrialWidgetLocked, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lootLocked",
		})
	end)
	TrialWidgetLocked.InfoText:setText(Engine[0xF9F1239CFD921FE](0x8C8E3A75045BE50))
	self:addElement(TrialWidgetLocked)
	self.TrialWidgetLocked = TrialWidgetLocked
	HUBTagPreview:linkToElementModel(tags, nil, false, function(model)
		HUBTagPreview:setModel(model, f1_arg1)
	end)
	TrialWidget:linkToElementModel(tags, nil, false, function(model)
		TrialWidget:setModel(model, f1_arg1)
	end)
	TrialWidgetLocked:linkToElementModel(tags, nil, false, function(model)
		TrialWidgetLocked:setModel(model, f1_arg1)
	end)
	tags.id = "tags"
	verticalCounter.id = "verticalCounter"
	self.__defaultFocus = tags
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local10 = self
	SetAsListVerticalCounter(self, verticalCounter, "tags")
	return self
end
CoD.MPSpecialistHUBTags_TagSetsFrame.__resetProperties = function(f15_arg0)
	f15_arg0.tags:completeAnimation()
	f15_arg0.tags:setAlpha(1)
end
CoD.MPSpecialistHUBTags_TagSetsFrame.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
		Intro = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f18_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f18_arg0:setAlpha(1)
				f18_arg0:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.tags:beginAnimation(50)
			f17_arg0.tags:setAlpha(0)
			f17_arg0.tags:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
			f17_arg0.tags:registerEventHandler("transition_complete_keyframe", f17_local0)
		end,
	},
}
CoD.MPSpecialistHUBTags_TagSetsFrame.__onClose = function(f19_arg0)
	f19_arg0.HUBTagPreview:close()
	f19_arg0.TrialWidget:close()
	f19_arg0.TrialWidgetLocked:close()
	f19_arg0.FramingCornerBrackets:close()
	f19_arg0.tags:close()
	f19_arg0.verticalCounter:close()
end
