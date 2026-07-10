require("x64:3fb470eb47879e8")
CoD.ArchivesIntelPreview = InheritFrom(LUI.UIElement)
CoD.ArchivesIntelPreview.__defaultWidth = 510
CoD.ArchivesIntelPreview.__defaultHeight = 500
CoD.ArchivesIntelPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArchivesIntelPreview)
	self.id = "ArchivesIntelPreview"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ClassifiedImage = LUI.UIImage.new(0, 0, 0, 510, 0, 0, 0, 293)
	ClassifiedImage:setAlpha(0)
	ClassifiedImage:setImage(RegisterImage(@"ui_menu_specialist_hud_poster_frame_locked"))
	self:addElement(ClassifiedImage)
	self.ClassifiedImage = ClassifiedImage
	local Title = LUI.UIText.new(0, 0, 0, 510, 0, 0, 138, 174)
	Title:setRGB(0.92, 0.89, 0.72)
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Title:linkToElementModel(self, "title", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Title:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Desc2 = LUI.UIText.new(0, 0, 0, 510, 0, 0, 182, 206)
	Desc2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Desc2:setTTF("ttmussels_regular")
	Desc2:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Desc2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Desc2:linkToElementModel(self, "desc", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Desc2:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Desc2)
	self.Desc2 = Desc2
	local Play = CoD.VodButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 200, 1, 1, -198, -165)
	Play:setAlpha(0)
	Play.Play:setText(LocalizeToUpperString(@"hash_3ADE9B10576A7DE2"))
	Play:subscribeToGlobalModel(f1_arg1, "Controller", "primary_button_image", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Play.buttonPromptImage:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(Play)
	self.Play = Play
	local CardIcon = LUI.UIImage.new(0.5, 0.5, -255, 255, 0, 0, 0, 128)
	CardIcon:linkToElementModel(self, "icon", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CardIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(CardIcon)
	self.CardIcon = CardIcon
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
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["storageGlobalRoot.user_settings"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArchivesIntelPreview.__resetProperties = function(f11_arg0)
	f11_arg0.Play:completeAnimation()
	f11_arg0.ClassifiedImage:completeAnimation()
	f11_arg0.CardIcon:completeAnimation()
	f11_arg0.Title:completeAnimation()
	f11_arg0.Desc2:completeAnimation()
	f11_arg0.Play:setAlpha(0)
	f11_arg0.ClassifiedImage:setAlpha(0)
	f11_arg0.CardIcon:setAlpha(1)
	f11_arg0.Title:setTopBottom(0, 0, 138, 174)
	f11_arg0.Desc2:setTopBottom(0, 0, 182, 206)
end
CoD.ArchivesIntelPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	MatureContentFiltered = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.ClassifiedImage:completeAnimation()
			f13_arg0.ClassifiedImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.ClassifiedImage)
			f13_arg0.Play:completeAnimation()
			f13_arg0.Play:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Play)
			f13_arg0.CardIcon:completeAnimation()
			f13_arg0.CardIcon:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.CardIcon)
		end,
	},
	Classified = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.ClassifiedImage:completeAnimation()
			f14_arg0.ClassifiedImage:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.ClassifiedImage)
			f14_arg0.Title:completeAnimation()
			f14_arg0.Title:setTopBottom(0, 0, 303, 339)
			f14_arg0.clipFinished(f14_arg0.Title)
			f14_arg0.Desc2:completeAnimation()
			f14_arg0.Desc2:setTopBottom(0, 0, 347, 371)
			f14_arg0.clipFinished(f14_arg0.Desc2)
			f14_arg0.Play:completeAnimation()
			f14_arg0.Play:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Play)
			f14_arg0.CardIcon:completeAnimation()
			f14_arg0.CardIcon:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.CardIcon)
		end,
	},
}
CoD.ArchivesIntelPreview.__onClose = function(f15_arg0)
	f15_arg0.Title:close()
	f15_arg0.Desc2:close()
	f15_arg0.Play:close()
	f15_arg0.CardIcon:close()
end
