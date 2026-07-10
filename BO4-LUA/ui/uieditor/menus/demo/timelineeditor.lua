require("x64:eda152e1d10147a")
require("x64:5ad87449c5d7553")
require("x64:6398e4f9aeb3650")
require("x64:3dd43113c4e1bd6")
CoD.TimelineEditor = InheritFrom(CoD.Menu)
LUI.createMenu.TimelineEditor = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("TimelineEditor", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.InitGlobalModel("demo.showFilmOptionsSidebar", false)
	self:setClass(CoD.TimelineEditor)
	self.soundSet = "ChooseDecal"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BGBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.9)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BGTint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGTint:setRGB(0, 0, 0)
	BGTint:setAlpha(0.8)
	self:addElement(BGTint)
	self.BGTint = BGTint
	local StartMenuBackground0 = CoD.StartMenu_Background.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	StartMenuBackground0:mergeStateConditions({
		{
			stateName = "InGame",
			condition = function(menu, element, event)
				return IsInGame()
			end,
		},
	})
	StartMenuBackground0:setAlpha(0)
	self:addElement(StartMenuBackground0)
	self.StartMenuBackground0 = StartMenuBackground0
	local BlackBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BlackBG:setAlpha(0)
	BlackBG:setImage(RegisterImage(@"uie_fe_cp_background"))
	self:addElement(BlackBG)
	self.BlackBG = BlackBG
	local SegmentButtonList = LUI.UIList.new(f1_local1, f1_arg0, 28, 0, nil, false, false, false, false)
	SegmentButtonList:setLeftRight(0.5, 0.5, -859.5, 857.5)
	SegmentButtonList:setTopBottom(0, 0, 88, 892)
	SegmentButtonList:setScale(0.99, 0.99)
	SegmentButtonList:setWidgetType(CoD.SegmentButton)
	SegmentButtonList:setHorizontalCount(5)
	SegmentButtonList:setVerticalCount(4)
	SegmentButtonList:setSpacing(28)
	SegmentButtonList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SegmentButtonList:setDataSource("DemoSegments")
	SegmentButtonList:linkToElementModel(SegmentButtonList, "disabled", true, function(model, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	local ClipStartTime = SegmentButtonList
	local GenericMenuFrame0 = SegmentButtonList.subscribeToModel
	local ClipEndTime = Engine[@"getglobalmodel"]()
	GenericMenuFrame0(ClipStartTime, ClipEndTime["demo.showFilmOptionsSidebar"], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	ClipStartTime = SegmentButtonList
	GenericMenuFrame0 = SegmentButtonList.subscribeToModel
	ClipEndTime = Engine[@"getglobalmodel"]()
	GenericMenuFrame0(ClipStartTime, ClipEndTime["demo.segmentCount"], function(f5_arg0, f5_arg1)
		CoD.Menu.UpdateButtonShownState(f5_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
	end, false)
	SegmentButtonList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f6_local0 = nil
		if not IsTimelineEditorInMoveState(f1_arg0) then
			CoD.DemoUtility.TimelineEditorUpdateTimeline(self, element, f1_arg0, "gain_focus", f1_local1)
			TimelineEditorUpdateHighlightedSegmentModel(self, element, f1_arg0, "gain_focus", f1_local1)
		elseif IsTimelineEditorInMoveState(f1_arg0) then
			CoD.DemoUtility.TimelineEditorUpdateTimeline(self, element, f1_arg0, "gain_focus", f1_local1)
			TimelineEditorUpdateHighlightedSegmentModel(self, element, f1_arg0, "gain_focus", f1_local1)
			UpdateAllMenuButtonPrompts(f1_local1, f1_arg0)
		end
		return f6_local0
	end)
	SegmentButtonList:registerEventHandler("list_item_lose_focus", function(element, event)
		local f7_local0 = nil
		if not IsTimelineEditorInMoveState(f1_arg0) then
			CoD.DemoUtility.TimelineEditorUpdateTimeline(self, element, f1_arg0, "lose_focus", f1_local1)
			TimelineEditorUpdateHighlightedSegmentModel(self, element, f1_arg0, "lose_focus", f1_local1)
		elseif IsTimelineEditorInMoveState(f1_arg0) then
			CoD.DemoUtility.TimelineEditorUpdateTimeline(self, element, f1_arg0, "lose_focus", f1_local1)
			TimelineEditorUpdateHighlightedSegmentModel(self, element, f1_arg0, "lose_focus", f1_local1)
		end
		return f7_local0
	end)
	SegmentButtonList:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"])
		return f8_local0
	end)
	f1_local1:AddButtonCallbackFunction(SegmentButtonList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if not IsDisabled(element, controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and not IsTimelineEditorInMoveState(controller) then
			CoD.DemoUtility.TimelineEditorSetupMoveSegment(self, element, controller, menu)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif not IsDisabled(element, controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and IsTimelineEditorInMoveState(controller) then
			CoD.DemoUtility.TimelineEditorPlaceSegment(self, element, controller, true, menu)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsDisabled(element, controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and not IsTimelineEditorInMoveState(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_38851419C3D83BD3", nil, nil)
			return true
		elseif not IsDisabled(element, controller) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and IsTimelineEditorInMoveState(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_7EDE476A5BD7AB24", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(SegmentButtonList, f1_arg0, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], nil, function(element, menu, controller, model)
		if SegmentCountGreaterThan(controller, 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and CanChangeSegmentTransition(element, controller) and IsSegmentTransition(element, controller, Enum[@"democliptransition"][@"demo_clip_transition_none"]) and not IsTimelineEditorInMoveState(controller) then
			TimelineEditorChangeTransition(self, element, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		elseif SegmentCountGreaterThan(controller, 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and CanChangeSegmentTransition(element, controller) and IsSegmentTransition(element, controller, Enum[@"democliptransition"][@"demo_clip_transition_fade"]) and not IsTimelineEditorInMoveState(controller) then
			TimelineEditorChangeTransition(self, element, controller)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if SegmentCountGreaterThan(controller, 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and CanChangeSegmentTransition(element, controller) and IsSegmentTransition(element, controller, Enum[@"democliptransition"][@"demo_clip_transition_none"]) and not IsTimelineEditorInMoveState(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_4E2C45A307C8FAB7", nil, nil)
			return true
		elseif SegmentCountGreaterThan(controller, 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and CanChangeSegmentTransition(element, controller) and IsSegmentTransition(element, controller, Enum[@"democliptransition"][@"demo_clip_transition_fade"]) and not IsTimelineEditorInMoveState(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xby_pstriangle"], @"hash_5793A2303FCB2877", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(SegmentButtonList)
	self.SegmentButtonList = SegmentButtonList
	GenericMenuFrame0 = CoD.GenericMenuFrame.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	GenericMenuFrame0.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"hash_518BBCA8DA8FE171"))
	GenericMenuFrame0:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			GenericMenuFrame0.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f13_local0))
		end
	end)
	self:addElement(GenericMenuFrame0)
	self.GenericMenuFrame0 = GenericMenuFrame0
	ClipStartTime = CoD.TextWithBg.new(f1_local1, f1_arg0, 0, 0, 59.5, 147.5, 1, 1, -155, -125)
	ClipStartTime.Bg:setAlpha(0)
	ClipStartTime.Text:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ClipStartTime.Text:setText("")
	self:addElement(ClipStartTime)
	self.ClipStartTime = ClipStartTime
	ClipEndTime = CoD.TextWithBg.new(f1_local1, f1_arg0, 1, 1, -150.5, -62.5, 1, 1, -155, -125)
	ClipEndTime.Bg:setAlpha(0)
	ClipEndTime.Text:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	ClipEndTime.Text:setText("")
	self:addElement(ClipEndTime)
	self.ClipEndTime = ClipEndTime
	local EmptyTimelineEditorText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -19, 19)
	EmptyTimelineEditorText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_72C31F7CC245990E"))
	EmptyTimelineEditorText:setTTF("default")
	EmptyTimelineEditorText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	EmptyTimelineEditorText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(EmptyTimelineEditorText)
	self.EmptyTimelineEditorText = EmptyTimelineEditorText
	local TimelineContainerController = LUI.UIImage.new(0.5, 0.5, -858.5, 858.5, 0, 0, 976, 988)
	TimelineContainerController:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TimelineContainerController:setAlpha(0)
	self:addElement(TimelineContainerController)
	self.TimelineContainerController = TimelineContainerController
	local TimeLine = LUI.UIImage.new(0.5, 0.5, -861, 861, 0, 0, 900, 1010)
	TimeLine:setAlpha(0.05)
	TimeLine:setImage(RegisterImage(@"uie_ui_theater_timelinemeter"))
	TimeLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_tile_scroll_normal"))
	TimeLine:setShaderVector(0, 2, 1, 0, 0)
	TimeLine:setShaderVector(1, 0, 0, 0, 0)
	self:addElement(TimeLine)
	self.TimeLine = TimeLine
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return not SegmentCountGreaterThan(f1_arg0, 0)
			end,
		},
	})
	local f1_local14 = self
	local f1_local15 = self.subscribeToModel
	local f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["demo.segmentCount"], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "demo.segmentCount",
		})
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["demo.showFilmOptionsSidebar"], function(f16_arg0, f16_arg1)
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f16_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	f1_local14 = self
	f1_local15 = self.subscribeToModel
	f1_local16 = Engine[@"getglobalmodel"]()
	f1_local15(f1_local14, f1_local16["demo.segmentCount"], function(f17_arg0, f17_arg1)
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_start"])
		CoD.Menu.UpdateButtonShownState(f17_arg1, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"])
	end, false)
	self:registerEventHandler("ui_keyboard_input", function(self, event)
		local f18_local0 = nil
		TimelineEditorKeyboardComplete(self, self, f1_arg0, event)
		if not f18_local0 then
			f18_local0 = self:dispatchEventToChildren(event)
		end
		return f18_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		if not IsTimelineEditorInMoveState(controller) then
			GoBack(self, controller)
			ResetThumbnailViewer(controller)
			return true
		elseif IsTimelineEditorInMoveState(controller) then
			CoD.DemoUtility.TimelineEditorPlaceSegment(self, element, controller, false, menu)
			UpdateAllMenuButtonPrompts(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsTimelineEditorInMoveState(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
			return true
		elseif IsTimelineEditorInMoveState(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/cancel", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") then
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_start"], nil, function(element, menu, controller, model)
		if SegmentCountGreaterThan(controller, 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and not IsTimelineEditorInMoveState(controller) then
			SetGlobalModelValueTrue("demo.showFilmOptionsSidebar")
			TimelineEditorFilmOptions(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if SegmentCountGreaterThan(controller, 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and not IsTimelineEditorInMoveState(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_start"], @"menu/options", nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], nil, function(element, menu, controller, model)
		if SegmentCountGreaterThan(controller, 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and not IsTimelineEditorInMoveState(controller) then
			TimelineEditorPreviewClip(self, element, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if SegmentCountGreaterThan(controller, 0) and not CoD.ModelUtility.IsGlobalModelValueTrue("demo.showFilmOptionsSidebar") and not IsTimelineEditorInMoveState(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbx_pssquare"], @"menu/preview_clip", nil, nil)
			return true
		else
			return false
		end
	end, false)
	SegmentButtonList.id = "SegmentButtonList"
	GenericMenuFrame0:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		GenericMenuFrame0.id = "GenericMenuFrame0"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = SegmentButtonList
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	f1_local15 = self
	CoD.DemoUtility.TimelineEditorPostLoad(self, f1_arg0)
	return self
end
CoD.TimelineEditor.__resetProperties = function(f27_arg0)
	f27_arg0.EmptyTimelineEditorText:completeAnimation()
	f27_arg0.ClipEndTime:completeAnimation()
	f27_arg0.ClipStartTime:completeAnimation()
	f27_arg0.SegmentButtonList:completeAnimation()
	f27_arg0.EmptyTimelineEditorText:setAlpha(1)
	f27_arg0.ClipEndTime:setAlpha(1)
	f27_arg0.ClipStartTime:setAlpha(1)
	f27_arg0.SegmentButtonList:setAlpha(1)
end
CoD.TimelineEditor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.EmptyTimelineEditorText:completeAnimation()
			f28_arg0.EmptyTimelineEditorText:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.EmptyTimelineEditorText)
		end,
	},
	Empty = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(3)
			f29_arg0.SegmentButtonList:completeAnimation()
			f29_arg0.SegmentButtonList:setAlpha(0.4)
			f29_arg0.clipFinished(f29_arg0.SegmentButtonList)
			f29_arg0.ClipStartTime:completeAnimation()
			f29_arg0.ClipStartTime:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ClipStartTime)
			f29_arg0.ClipEndTime:completeAnimation()
			f29_arg0.ClipEndTime:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ClipEndTime)
		end,
	},
}
CoD.TimelineEditor.__onClose = function(f30_arg0)
	f30_arg0.StartMenuBackground0:close()
	f30_arg0.SegmentButtonList:close()
	f30_arg0.GenericMenuFrame0:close()
	f30_arg0.ClipStartTime:close()
	f30_arg0.ClipEndTime:close()
end
