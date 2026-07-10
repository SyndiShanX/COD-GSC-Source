require("x64:8f8cac1072cb4f9")
CoD.MapVoteLabelLower = InheritFrom(LUI.UIElement)
CoD.MapVoteLabelLower.__defaultWidth = 225
CoD.MapVoteLabelLower.__defaultHeight = 27
CoD.MapVoteLabelLower.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MapVoteLabelLower)
	self.id = "MapVoteLabelLower"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuIdentitySubtitleBG00 = CoD.StartMenu_Identity_Subtitle_BG.new(f1_arg0, f1_arg1, 0, 1, -10, 12, 0, 1, -3, 3)
	StartMenuIdentitySubtitleBG00:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsFreeRunLobby()
			end,
		},
	})
	local f1_local2 = StartMenuIdentitySubtitleBG00
	local SubTitle = StartMenuIdentitySubtitleBG00.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	SubTitle(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(StartMenuIdentitySubtitleBG00, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	StartMenuIdentitySubtitleBG00:setRGB(0, 0, 0)
	StartMenuIdentitySubtitleBG00:setAlpha(0.55)
	self:addElement(StartMenuIdentitySubtitleBG00)
	self.StartMenuIdentitySubtitleBG00 = StartMenuIdentitySubtitleBG00
	SubTitle = LUI.UIText.new(0, 0, 9, 525, 0, 0, -1, 29)
	SubTitle:setText("")
	SubTitle:setTTF("dinnext_regular")
	SubTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(SubTitle, "setText", function(element, controller)
		ScaleWidgetToLabelLeftJustify(self, element, 2)
	end)
	self:addElement(SubTitle)
	self.SubTitle = SubTitle
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return IsFreeRunLobby()
			end,
		},
	})
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MapVoteLabelLower.__resetProperties = function(f7_arg0)
	f7_arg0.SubTitle:completeAnimation()
	f7_arg0.SubTitle:setAlpha(1)
end
CoD.MapVoteLabelLower.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.SubTitle:completeAnimation()
			f9_arg0.SubTitle:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.SubTitle)
		end,
	},
}
CoD.MapVoteLabelLower.__onClose = function(f10_arg0)
	f10_arg0.StartMenuIdentitySubtitleBG00:close()
end
