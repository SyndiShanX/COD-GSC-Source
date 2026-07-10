require("x64:ffbc64370f13dd9")
require("x64:b3af0fce9f653ed")
require("x64:17be4a8cc2d6311")
CoD.Archives_Extras = InheritFrom(LUI.UIElement)
CoD.Archives_Extras.__defaultWidth = 1920
CoD.Archives_Extras.__defaultHeight = 780
CoD.Archives_Extras.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Archives_Extras)
	self.id = "Archives_Extras"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local VideoList = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	VideoList:setLeftRight(0.5, 0.5, -760, -250)
	VideoList:setTopBottom(0.5, 0.5, -339.5, 326.5)
	VideoList:setWidgetType(CoD.ArchivesVideoButton)
	VideoList:setVerticalCount(13)
	VideoList:setSpacing(10)
	VideoList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	VideoList:setDataSource("ArchivesExtraList")
	VideoList:linkToElementModel(VideoList, "video.hiResVideo.movieName", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end)
	VideoList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(VideoList, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "video.hiResVideo.movieName") and not IsElementInState(element, "MatureContentFiltered") then
			CoD.VideoStreamingUtility.SetupVoDMovie(controller, element, "video.hiResVideo")
			SetLoseFocusToElement(self, "VideoList", controller)
			DelayOpenOverlay(menu, "VoDViewer", controller, {
				fullscreen = true,
			})
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.ModelUtility.IsSelfModelValueNonEmptyString(element, controller, "video.hiResVideo.movieName") and not IsElementInState(element, "MatureContentFiltered") then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_D31D493AE40DA0F", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(VideoList)
	self.VideoList = VideoList
	local ArchivesVoDPreview = CoD.ArchivesVoDPreview.new(f1_arg0, f1_arg1, 0.5, 0.5, 248, 758, 0.5, 0.5, -339.5, 160.5)
	self:addElement(ArchivesVoDPreview)
	self.ArchivesVoDPreview = ArchivesVoDPreview
	ArchivesVoDPreview:linkToElementModel(VideoList, nil, false, function(model)
		ArchivesVoDPreview:setModel(model, f1_arg1)
	end)
	VideoList.id = "VideoList"
	ArchivesVoDPreview.id = "ArchivesVoDPreview"
	self.__defaultFocus = VideoList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Archives_Extras.__onClose = function(f7_arg0)
	f7_arg0.ArchivesVoDPreview:close()
	f7_arg0.VideoList:close()
end
