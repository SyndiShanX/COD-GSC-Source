require("x64:e5f54652701b2df")
require("x64:d6ecdf7755aeddc")
require("x64:75e2a524b093c12")
CoD.directorTraining = InheritFrom(LUI.UIElement)
CoD.directorTraining.__defaultWidth = 1920
CoD.directorTraining.__defaultHeight = 1080
CoD.directorTraining.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.directorTraining)
	self.id = "directorTraining"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local XCamMouseControl = nil
	XCamMouseControl = CoD.XCamMouseControl.new(f1_arg0, f1_arg1, 0.5, 0.5, -375, 375, 0.5, 0.5, -465, 235)
	self:addElement(XCamMouseControl)
	self.XCamMouseControl = XCamMouseControl
	local CommonHeader = CoD.CommonHeader.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0, 0, 0, 67)
	CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/specialist_hub"))
	CommonHeader.subtitle.subtitle:setAlpha(0)
	CommonHeader:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(CommonHeader)
	self.CommonHeader = CommonHeader
	local SpecialistHeadquarters = CoD.SpecialistHeadquarters.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(SpecialistHeadquarters)
	self.SpecialistHeadquarters = SpecialistHeadquarters
	local FullScreenBlack = LUI.UIImage.new(0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	FullScreenBlack:setRGB(0, 0, 0)
	FullScreenBlack:setAlpha(0)
	self:addElement(FullScreenBlack)
	self.FullScreenBlack = FullScreenBlack
	self:mergeStateConditions({
		{
			stateName = "StartFullScreenBlack",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "SpecialistHeadquarters", "StartFullscreenBlack")
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.StartFullscreenBlack, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "StartFullscreenBlack",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if IsSelfInState(self, "StartFullScreenBlack") then
			MenuHidesFreeCursor(f1_arg0, controller)
		elseif not IsSelfInState(self, "StartFullScreenBlack") then
			CoD.CTUtility.UnhideFreeCursor(f1_arg0, controller)
		end
	end)
	if CoD.isPC then
		XCamMouseControl.id = "XCamMouseControl"
	end
	SpecialistHeadquarters.id = "SpecialistHeadquarters"
	self.__defaultFocus = SpecialistHeadquarters
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.CTUtility.SubscribeForDefaultSpecialistSelection(f1_arg0, f1_arg1)
	return self
end
CoD.directorTraining.__resetProperties = function(f6_arg0)
	f6_arg0.FullScreenBlack:completeAnimation()
	f6_arg0.FullScreenBlack:setAlpha(0)
end
CoD.directorTraining.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	StartFullScreenBlack = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.FullScreenBlack:completeAnimation()
			f8_arg0.FullScreenBlack:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.FullScreenBlack)
		end,
	},
}
CoD.directorTraining.__onClose = function(f9_arg0)
	f9_arg0.XCamMouseControl:close()
	f9_arg0.CommonHeader:close()
	f9_arg0.SpecialistHeadquarters:close()
end
