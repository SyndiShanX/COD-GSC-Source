require("x64:e3be79df0c2cf28")
CoD.MPSpecialistHUBPreviewMoment = InheritFrom(CoD.Menu)
LUI.createMenu.MPSpecialistHUBPreviewMoment = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("MPSpecialistHUBPreviewMoment", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, true)
	self:setClass(CoD.MPSpecialistHUBPreviewMoment)
	self.soundSet = "default"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local VoDViewerFooterContainer = CoD.VoDViewerFooterContainer.new(f1_local1, f1_arg0, 0, 0, 0, 1920, 0, 0, 0, 1080)
	self:addElement(VoDViewerFooterContainer)
	self.VoDViewerFooterContainer = VoDViewerFooterContainer
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], nil, function(element, menu, controller, model)
		SendClientScriptMenuChangeNotify(controller, menu, false)
		GoBack(self, controller)
		SetMenuProperty(menu, "_hasSentClientScriptNotify", true)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x70A9FDC87CD3D48, nil, nil)
		return true
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "close", function(element)
		if not MenuPropertyIsTrue(f1_local1, "_hasSentClientScriptNotify") then
			SendClientScriptMenuChangeNotify(f1_arg0, f1_local1, false)
		end
	end)
	if CoD.isPC then
		VoDViewerFooterContainer.id = "VoDViewerFooterContainer"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.MPSpecialistHUBPreviewMoment.__resetProperties = function(f5_arg0)
	f5_arg0.VoDViewerFooterContainer:completeAnimation()
	f5_arg0.VoDViewerFooterContainer:setTopBottom(0, 0, 0, 1080)
end
CoD.MPSpecialistHUBPreviewMoment.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.VoDViewerFooterContainer:completeAnimation()
			f6_arg0.VoDViewerFooterContainer:setTopBottom(0, 0, 0, 1300)
			f6_arg0.clipFinished(f6_arg0.VoDViewerFooterContainer)
		end,
		ShowPrompts = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.VoDViewerFooterContainer:beginAnimation(200)
				f7_arg0.VoDViewerFooterContainer:setTopBottom(0, 0, 0, 1080)
				f7_arg0.VoDViewerFooterContainer:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.VoDViewerFooterContainer:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.VoDViewerFooterContainer:completeAnimation()
			f7_arg0.VoDViewerFooterContainer:setTopBottom(0, 0, 0, 1300)
			f7_local0(f7_arg0.VoDViewerFooterContainer)
		end,
	},
	ShowPrompts = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.VoDViewerFooterContainer:beginAnimation(200)
				f10_arg0.VoDViewerFooterContainer:setTopBottom(0, 0, 0, 1300)
				f10_arg0.VoDViewerFooterContainer:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.VoDViewerFooterContainer:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.VoDViewerFooterContainer:completeAnimation()
			f10_arg0.VoDViewerFooterContainer:setTopBottom(0, 0, 0, 1080)
			f10_local0(f10_arg0.VoDViewerFooterContainer)
		end,
	},
}
CoD.MPSpecialistHUBPreviewMoment.__onClose = function(f12_arg0)
	f12_arg0.VoDViewerFooterContainer:close()
end
