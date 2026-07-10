require("x64:3fb470eb47879e8")
require("x64:933b90d7e9c5e70")
CoD.DossierVoDPreview = InheritFrom(LUI.UIElement)
CoD.DossierVoDPreview.__defaultWidth = 510
CoD.DossierVoDPreview.__defaultHeight = 380
CoD.DossierVoDPreview.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DossierVoDPreview)
	self.id = "DossierVoDPreview"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local IntroPreview = CoD.VoDPreviewWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 510, 0, 0, 0, 293)
	IntroPreview:mergeStateConditions({
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
	IntroPreview:linkToElementModel(IntroPreview, "lowResVideo.movieName", true, function(model)
		f1_arg0:updateElementState(IntroPreview, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "lowResVideo.movieName",
		})
	end)
	IntroPreview:linkToElementModel(self, nil, false, function(model)
		IntroPreview:setModel(model, f1_arg1)
	end)
	self:addElement(IntroPreview)
	self.IntroPreview = IntroPreview
	local Title = LUI.UIText.new(0, 0, 0, 510, 0, 0, 303, 339)
	Title:setRGB(0.92, 0.89, 0.72)
	Title:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Title)
	self.Title = Title
	local Play = CoD.VodButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 200, 1, 1, -33, 0)
	Play:setAlpha(0)
	Play.Play:setText(LocalizeToUpperString(0xD31D493AE40DA0F))
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
	Fullscreen.Play:setText(LocalizeToUpperString(0x23594B6BDE14144))
	Fullscreen:subscribeToGlobalModel(f1_arg1, "Controller", "alt2_button_image", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Fullscreen.buttonPromptImage:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(Fullscreen)
	self.Fullscreen = Fullscreen
	local Desc = LUI.UIText.new(0, 0, 0, 510, 0, 0, 347, 377)
	Desc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Desc:setAlpha(0)
	Desc:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Desc:setTTF("ttmussels_regular")
	Desc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Desc:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Desc)
	self.Desc = Desc
	self:mergeStateConditions({
		{
			stateName = "MatureContentFiltered",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	IntroPreview.id = "IntroPreview"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DossierVoDPreview.__resetProperties = function(f11_arg0)
	f11_arg0.Play:completeAnimation()
	f11_arg0.Fullscreen:completeAnimation()
	f11_arg0.Desc:completeAnimation()
	f11_arg0.Title:completeAnimation()
	f11_arg0.IntroPreview:completeAnimation()
	f11_arg0.Play:setAlpha(0)
	f11_arg0.Fullscreen:setAlpha(0)
	f11_arg0.Desc:setAlpha(0)
	f11_arg0.Title:setAlpha(1)
	f11_arg0.IntroPreview:setAlpha(1)
end
CoD.DossierVoDPreview.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	MatureContentFiltered = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(5)
			f13_arg0.IntroPreview:completeAnimation()
			f13_arg0.IntroPreview:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.IntroPreview)
			f13_arg0.Title:completeAnimation()
			f13_arg0.Title:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Title)
			f13_arg0.Play:completeAnimation()
			f13_arg0.Play:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Play)
			f13_arg0.Fullscreen:completeAnimation()
			f13_arg0.Fullscreen:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Fullscreen)
			f13_arg0.Desc:completeAnimation()
			f13_arg0.Desc:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Desc)
		end,
	},
	Classified = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.Play:completeAnimation()
			f14_arg0.Play:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Play)
			f14_arg0.Fullscreen:completeAnimation()
			f14_arg0.Fullscreen:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Fullscreen)
			f14_arg0.Desc:completeAnimation()
			f14_arg0.Desc:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.Desc)
		end,
	},
	PC = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.Play:completeAnimation()
			f15_arg0.Play:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Play)
		end,
	},
}
CoD.DossierVoDPreview.__onClose = function(f16_arg0)
	f16_arg0.IntroPreview:close()
	f16_arg0.Play:close()
	f16_arg0.Fullscreen:close()
end
