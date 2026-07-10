require("x64:ba65cee910aef8b")
require("x64:3fb470eb47879e8")
require("x64:933b90d7e9c5e70")
CoD.ArchivesVoDPreview = InheritFrom(LUI.UIElement)
CoD.ArchivesVoDPreview.__defaultWidth = 510
CoD.ArchivesVoDPreview.__defaultHeight = 500
CoD.ArchivesVoDPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArchivesVoDPreview)
	self.id = "ArchivesVoDPreview"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VoDPreview = CoD.VoDPreviewWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 510, 0, 0, 0, 293)
	VoDPreview:mergeStateConditions({
		{
			stateName = "NoMovie",
			condition = function(menu, element, event)
				return CoD.PlayerRoleUtility.DisableVideoPlayer(element, f1_arg1)
			end,
		},
		{
			stateName = "NoFocus",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	VoDPreview:linkToElementModel(VoDPreview, "lowResVideo.movieName", true, function(model)
		f1_arg0:updateElementState(VoDPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lowResVideo.movieName",
		})
	end)
	VoDPreview:linkToElementModel(self, "video", false, function(model)
		VoDPreview:setModel(model, f1_arg1)
	end)
	self:addElement(VoDPreview)
	self.VoDPreview = VoDPreview
	local Play = CoD.VodButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 200, 1, 1, -33, 0)
	Play:setAlpha(0)
	Play.Play:setText(LocalizeToUpperString(@"hash_D31D493AE40DA0F"))
	Play:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Play.buttonPromptImage:setImage(RegisterImage(f6_local0))
		end
	end)
	self:addElement(Play)
	self.Play = Play
	local Fullscreen = CoD.VodButtonPrompt.new(f1_arg0, f1_arg1, 1, 1, -200, 0, 1, 1, -33, 0)
	Fullscreen:setAlpha(0)
	Fullscreen.Play:setText(LocalizeToUpperString(@"hash_323594B6BDE14144"))
	Fullscreen:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Fullscreen.buttonPromptImage:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(Fullscreen)
	self.Fullscreen = Fullscreen
	local ArchivesVoDDescription = CoD.ArchivesVoDDescription.new(f1_arg0, f1_arg1, 0, 0, 3, 505, 0, 0, 305, 365)
	ArchivesVoDDescription:linkToElementModel(self, "title", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ArchivesVoDDescription.Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f8_local0))
		end
	end)
	ArchivesVoDDescription:linkToElementModel(self, "desc", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ArchivesVoDDescription.Desc:setText(Engine[@"hash_4F9F1239CFD921FE"](f9_local0))
		end
	end)
	self:addElement(ArchivesVoDDescription)
	self.ArchivesVoDDescription = ArchivesVoDDescription
	self:mergeStateConditions({
		{
			stateName = "MatureContentFiltered",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "matureContent") and not CoD.CTUtility.IsMatureContent(f1_arg1)
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "unlocked")
			end,
		},
		{
			stateName = "KeyboardMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "matureContent", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "matureContent",
		})
	end)
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	f1_local6(f1_local5, f1_local7["storageGlobalRoot.user_settings"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "storageGlobalRoot.user_settings",
		})
	end, false)
	self:linkToElementModel(self, "unlocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "unlocked",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f16_arg1)
	end)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local6(f1_local5, f1_local7.LastInput, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	VoDPreview.id = "VoDPreview"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArchivesVoDPreview.__resetProperties = function(f18_arg0)
	f18_arg0.Play:completeAnimation()
	f18_arg0.Fullscreen:completeAnimation()
	f18_arg0.VoDPreview:completeAnimation()
	f18_arg0.ArchivesVoDDescription:completeAnimation()
	f18_arg0.Play:setAlpha(0)
	f18_arg0.Fullscreen:setAlpha(0)
	f18_arg0.VoDPreview:setAlpha(1)
	f18_arg0.ArchivesVoDDescription:setAlpha(1)
end
CoD.ArchivesVoDPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	MatureContentFiltered = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			f20_arg0.VoDPreview:completeAnimation()
			f20_arg0.VoDPreview:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.VoDPreview)
			f20_arg0.Play:completeAnimation()
			f20_arg0.Play:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Play)
			f20_arg0.Fullscreen:completeAnimation()
			f20_arg0.Fullscreen:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Fullscreen)
			f20_arg0.ArchivesVoDDescription:completeAnimation()
			f20_arg0.ArchivesVoDDescription:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.ArchivesVoDDescription)
		end,
	},
	Classified = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.Play:completeAnimation()
			f21_arg0.Play:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Play)
			f21_arg0.Fullscreen:completeAnimation()
			f21_arg0.Fullscreen:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Fullscreen)
		end,
	},
	KeyboardMouse = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.Play:completeAnimation()
			f22_arg0.Play:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Play)
		end,
	},
}
CoD.ArchivesVoDPreview.__onClose = function(f23_arg0)
	f23_arg0.VoDPreview:close()
	f23_arg0.Play:close()
	f23_arg0.Fullscreen:close()
	f23_arg0.ArchivesVoDDescription:close()
end
