require("x64:fd561622867b8bd")
require("x64:9c626a0110d2a99")
CoD.SelectedClassMiniPreview = InheritFrom(LUI.UIElement)
CoD.SelectedClassMiniPreview.__defaultWidth = 1920
CoD.SelectedClassMiniPreview.__defaultHeight = 300
CoD.SelectedClassMiniPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "BonuscardModifiedSlotEnum", CoD.BonuscardUtility.BonuscardModifiedSlotType.NONE)
	self:setClass(CoD.SelectedClassMiniPreview)
	self.id = "SelectedClassMiniPreview"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ClassList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	ClassList:setLeftRight(0.5, 0.5, -429, 429)
	ClassList:setTopBottom(1, 1, -35, 0)
	ClassList:setAlpha(0)
	ClassList:setWidgetType(CoD.CustomClassListButton)
	ClassList:setHorizontalCount(5)
	ClassList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClassList:setDataSource("ChooseClass_InGame")
	self.__on_menuOpened_ClassList = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		CoD.CACUtility.SetActiveListItemToSelectedClass(f2_arg1, f2_arg2, ClassList)
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_ClassList)
	ClassList:subscribeToGlobalModel(f1_arg1, "PerController", "selectedCustomClass", function(model)
		CoD.CACUtility.SetActiveListItemToSelectedClass(f1_arg1, f1_arg0, ClassList)
	end)
	self:addElement(ClassList)
	self.ClassList = ClassList
	local FullBacking = LUI.UIImage.new(0.45, 1.55, -960, -960, 1, 1.96, -288, -288)
	FullBacking:setRGB(0, 0, 0)
	FullBacking:setAlpha(0)
	FullBacking:registerEventHandler("menu_loaded", function(element, event)
		local f4_local0 = nil
		if element.menuLoaded then
			f4_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f4_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f4_local0 then
			f4_local0 = element:dispatchEventToChildren(event)
		end
		return f4_local0
	end)
	self:addElement(FullBacking)
	self.FullBacking = FullBacking
	local panelbacking = LUI.UIImage.new(-0.05, 1.05, 0, 0, 1, 1, -265, -96)
	panelbacking:setRGB(0, 0, 0)
	panelbacking:setAlpha(0.75)
	panelbacking:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(panelbacking)
	self.panelbacking = panelbacking
	local panelbackingTop = LUI.UIImage.new(-0.05, 1.05, 0, 0, 1, 1, -265, -290)
	panelbackingTop:setRGB(0, 0, 0)
	panelbackingTop:setAlpha(0.25)
	panelbackingTop:registerEventHandler("menu_loaded", function(element, event)
		local f6_local0 = nil
		if element.menuLoaded then
			f6_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f6_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f6_local0 then
			f6_local0 = element:dispatchEventToChildren(event)
		end
		return f6_local0
	end)
	self:addElement(panelbackingTop)
	self.panelbackingTop = panelbackingTop
	local SelectedClassLabel = LUI.UIText.new(0.5, 0.5, -512, 28, 1, 1, -287.5, -267.5)
	SelectedClassLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	SelectedClassLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](0xAAFF2AE8CD4664))
	SelectedClassLabel:setTTF("ttmussels_regular")
	SelectedClassLabel:setLetterSpacing(2)
	SelectedClassLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	SelectedClassLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SelectedClassLabel)
	self.SelectedClassLabel = SelectedClassLabel
	local ClassName = LUI.UIText.new(0.5, 0.5, 33.5, 573.5, 1, 1, -287.5, -267.5)
	ClassName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	ClassName:setTTF("notosans_bold")
	ClassName:setLetterSpacing(2)
	ClassName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClassName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClassName)
	self.ClassName = ClassName
	local nameline = LUI.UIImage.new(-0.05, 1.05, 0, 0, 1, 1, -265.5, -264.5)
	nameline:setAlpha(0.15)
	nameline:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(nameline)
	self.nameline = nameline
	local ClassMiniPreview = CoD.ClassMiniPreview.new(f1_arg0, f1_arg1, 0.5, 0.5, -700, 700, 1, 1, -256.5, -176.5)
	self:addElement(ClassMiniPreview)
	self.ClassMiniPreview = ClassMiniPreview
	local lightblurbar = LUI.UIImage.new(-0.05, 1.05, 0, 0, 1, 1, -272.5, -256.5)
	lightblurbar:setImage(RegisterImage(@"uie_ui_menu_draft_barflare"))
	lightblurbar:registerEventHandler("menu_loaded", function(element, event)
		local f8_local0 = nil
		if element.menuLoaded then
			f8_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f8_local0 = element.super:menuLoaded(event)
		end
		if IsPC() then
			SizeToWidthOfScreen(element, f1_arg1)
		end
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	self:addElement(lightblurbar)
	self.lightblurbar = lightblurbar
	ClassName:linkToElementModel(ClassList, "customClassName", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ClassName:setText(ConvertToUpperString(f9_local0))
		end
	end)
	ClassMiniPreview:linkToElementModel(ClassList, nil, false, function(model)
		ClassMiniPreview:setModel(model, f1_arg1)
	end)
	self:mergeStateConditions({
		{
			stateName = "Bounty",
			condition = function(menu, element, event)
				return CoD.BountyHunterUtility.GameTypeHidesChooseClass(f1_arg1)
			end,
		},
		{
			stateName = "Arabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageReversed()
			end,
		},
	})
	ClassList.id = "ClassList"
	ClassMiniPreview.id = "ClassMiniPreview"
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_ClassList)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SelectedClassMiniPreview.__resetProperties = function(f14_arg0)
	f14_arg0.ClassMiniPreview:completeAnimation()
	f14_arg0.SelectedClassLabel:completeAnimation()
	f14_arg0.ClassName:completeAnimation()
	f14_arg0.ClassMiniPreview:setAlpha(1)
	f14_arg0.SelectedClassLabel:setLeftRight(0.5, 0.5, -512, 28)
	f14_arg0.SelectedClassLabel:setAlpha(1)
	f14_arg0.SelectedClassLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
	f14_arg0.ClassName:setLeftRight(0.5, 0.5, 33.5, 573.5)
	f14_arg0.ClassName:setAlpha(1)
	f14_arg0.ClassName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
end
CoD.SelectedClassMiniPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	Bounty = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.SelectedClassLabel:completeAnimation()
			f16_arg0.SelectedClassLabel:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.SelectedClassLabel)
			f16_arg0.ClassName:completeAnimation()
			f16_arg0.ClassName:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ClassName)
			f16_arg0.ClassMiniPreview:completeAnimation()
			f16_arg0.ClassMiniPreview:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.ClassMiniPreview)
		end,
	},
	Arabic = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.SelectedClassLabel:completeAnimation()
			f17_arg0.SelectedClassLabel:setLeftRight(0.5, 0.5, 33.5, 573.5)
			f17_arg0.SelectedClassLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
			f17_arg0.clipFinished(f17_arg0.SelectedClassLabel)
			f17_arg0.ClassName:completeAnimation()
			f17_arg0.ClassName:setLeftRight(0.5, 0.5, -512, 28)
			f17_arg0.ClassName:setAlignment(Enum[@"luialignment"][@"lui_alignment_right"])
			f17_arg0.clipFinished(f17_arg0.ClassName)
		end,
	},
}
CoD.SelectedClassMiniPreview.__onClose = function(f18_arg0)
	f18_arg0.__on_close_removeOverrides()
	f18_arg0.ClassName:close()
	f18_arg0.ClassMiniPreview:close()
	f18_arg0.ClassList:close()
end
