require("x64:2675595fa323085")
require("x64:4fd781f7e506216")
CoD.ContextualMenu = InheritFrom(LUI.UIElement)
CoD.ContextualMenu.__defaultWidth = 233
CoD.ContextualMenu.__defaultHeight = 263
CoD.ContextualMenu.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.ContextualMenu)
	self.id = "ContextualMenu"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusBlocker = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0.95, 0, 0)
	self:addElement(FocusBlocker)
	self.FocusBlocker = FocusBlocker
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 0.94, 0, 0)
	Background:setRGB(0.09, 0.09, 0.09)
	self:addElement(Background)
	self.Background = Background
	local Noise = LUI.UIImage.new(0, 1, 0, 0, 0, 0.94, 0, 0)
	Noise:setAlpha(0.6)
	Noise:setImage(RegisterImage(0x34839E8065B1E53))
	Noise:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	Noise:setShaderVector(0, 0, 0, 0, 0)
	Noise:setupNineSliceShader(64, 64)
	self:addElement(Noise)
	self.Noise = Noise
	local TitleBG = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 40)
	TitleBG:setRGB(0.05, 0.05, 0.05)
	self:addElement(TitleBG)
	self.TitleBG = TitleBG
	local ActionList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	ActionList:setLeftRight(0, 1, 0, 0)
	ActionList:setTopBottom(0, 0, 45, 248)
	ActionList:setAutoScaleContent(true)
	ActionList:setWidgetType(CoD.ContextualMenuAction)
	ActionList:setVerticalCount(7)
	ActionList:setSpacing(0)
	ActionList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ActionList:setDataSource("ContextualMenuActionsList")
	self:addElement(ActionList)
	self.ActionList = ActionList
	local TitleNonLocalized2 = LUI.UIText.new(0, 1, 5, -5, 0.04, 0.04, 23, 41)
	TitleNonLocalized2:setRGB(0.86, 0.74, 0.25)
	TitleNonLocalized2:setAlpha(0)
	TitleNonLocalized2:setTTF("notosans_light")
	TitleNonLocalized2:setLetterSpacing(1)
	TitleNonLocalized2:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TitleNonLocalized2:subscribeToGlobalModel(f1_arg1, "ContextualMenu", "secondLineTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TitleNonLocalized2:setText(f2_local0)
		end
	end)
	self:addElement(TitleNonLocalized2)
	self.TitleNonLocalized2 = TitleNonLocalized2
	local TitleNonLocalized = LUI.UIText.new(0, 1, 5, -5, 0.04, 0.04, 0, 24)
	TitleNonLocalized:setRGB(0.86, 0.74, 0.25)
	TitleNonLocalized:setAlpha(0)
	TitleNonLocalized:setTTF("notosans_light")
	TitleNonLocalized:setLetterSpacing(1)
	TitleNonLocalized:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TitleNonLocalized:subscribeToGlobalModel(f1_arg1, "ContextualMenu", "titleNonLocalized", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TitleNonLocalized:setText(CoD.SocialUtility.CleanGamerTag(f3_local0))
		end
	end)
	self:addElement(TitleNonLocalized)
	self.TitleNonLocalized = TitleNonLocalized
	local Title = LUI.UIText.new(0, 1, 5, -5, 0.04, 0.04, 0, 24)
	Title:setRGB(0.86, 0.74, 0.25)
	Title:setTTF("notosans_light")
	Title:setLetterSpacing(1)
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:subscribeToGlobalModel(f1_arg1, "ContextualMenu", "title", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Title:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local TitleBorder = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 40, 41)
	TitleBorder:setRGB(0.35, 0.35, 0.35)
	self:addElement(TitleBorder)
	self.TitleBorder = TitleBorder
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 0.95, 0, 0)
	Border:setRGB(0.42, 0.42, 0.42)
	Border:setAlpha(0.3)
	Border:setImage(RegisterImage(0xF1E3082B39E99BB))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(4, 4)
	self:addElement(Border)
	self.Border = Border
	self:mergeStateConditions({
		{
			stateName = "TwoLinesTitle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueNonEmptyString(f1_arg1, "ContextualMenu.secondLineTitle")
			end,
		},
		{
			stateName = "NoTitle",
			condition = function(menu, element, event)
				local f6_local0
				if not CoD.ModelUtility.IsModelValueNonEmptyString(f1_arg1, "ContextualMenu.title") then
					f6_local0 = not CoD.ModelUtility.IsModelValueNonEmptyString(f1_arg1, "ContextualMenu.titleNonLocalized")
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "TitleNonLocalized",
			condition = function(menu, element, event)
				local f7_local0
				if not CoD.ModelUtility.IsModelValueNonEmptyString(f1_arg1, "ContextualMenu.title") then
					f7_local0 = CoD.ModelUtility.IsModelValueNonEmptyString(f1_arg1, "ContextualMenu.titleNonLocalized")
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["ContextualMenu.secondLineTitle"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "ContextualMenu.secondLineTitle",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["ContextualMenu.title"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "ContextualMenu.title",
		})
	end, false)
	f1_local11 = self
	f1_local12 = self.subscribeToModel
	f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["ContextualMenu.titleNonLocalized"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "ContextualMenu.titleNonLocalized",
		})
	end, false)
	FocusBlocker.id = "FocusBlocker"
	ActionList.id = "ActionList"
	self.__defaultFocus = ActionList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local12 = self
	DisableKeyboardNavigationByElement(FocusBlocker)
	return self
end
CoD.ContextualMenu.__resetProperties = function(f11_arg0)
	f11_arg0.TitleNonLocalized2:completeAnimation()
	f11_arg0.TitleNonLocalized:completeAnimation()
	f11_arg0.Title:completeAnimation()
	f11_arg0.TitleBorder:completeAnimation()
	f11_arg0.ActionList:completeAnimation()
	f11_arg0.TitleBG:completeAnimation()
	f11_arg0.Border:completeAnimation()
	f11_arg0.Noise:completeAnimation()
	f11_arg0.Background:completeAnimation()
	f11_arg0.FocusBlocker:completeAnimation()
	f11_arg0.TitleNonLocalized2:setTopBottom(0.04, 0.04, 23, 41)
	f11_arg0.TitleNonLocalized2:setRGB(0.86, 0.74, 0.25)
	f11_arg0.TitleNonLocalized2:setAlpha(0)
	f11_arg0.TitleNonLocalized:setAlpha(0)
	f11_arg0.Title:setAlpha(1)
	f11_arg0.TitleBorder:setTopBottom(0, 0, 40, 41)
	f11_arg0.TitleBorder:setAlpha(1)
	f11_arg0.ActionList:setTopBottom(0, 0, 45, 248)
	f11_arg0.TitleBG:setTopBottom(0, 0, 0, 40)
	f11_arg0.TitleBG:setAlpha(1)
	f11_arg0.Border:setTopBottom(0, 0.95, 0, 0)
	f11_arg0.Noise:setTopBottom(0, 0.94, 0, 0)
	f11_arg0.Background:setTopBottom(0, 0.94, 0, 0)
	f11_arg0.FocusBlocker:setTopBottom(0, 0.95, 0, 0)
end
CoD.ContextualMenu.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	TwoLinesTitle = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(10)
			f13_arg0.FocusBlocker:completeAnimation()
			f13_arg0.FocusBlocker:setTopBottom(0, 1, 0, 0)
			f13_arg0.clipFinished(f13_arg0.FocusBlocker)
			f13_arg0.Background:completeAnimation()
			f13_arg0.Background:setTopBottom(0, 1, 0, 0)
			f13_arg0.clipFinished(f13_arg0.Background)
			f13_arg0.Noise:completeAnimation()
			f13_arg0.Noise:setTopBottom(0, 1, 0, 0)
			f13_arg0.clipFinished(f13_arg0.Noise)
			f13_arg0.TitleBG:completeAnimation()
			f13_arg0.TitleBG:setTopBottom(0, 0, 0, 57)
			f13_arg0.clipFinished(f13_arg0.TitleBG)
			f13_arg0.ActionList:completeAnimation()
			f13_arg0.ActionList:setTopBottom(0, 0, 58, 261)
			f13_arg0.clipFinished(f13_arg0.ActionList)
			f13_arg0.TitleNonLocalized2:completeAnimation()
			f13_arg0.TitleNonLocalized2:setTopBottom(0.04, 0.04, 24, 42)
			f13_arg0.TitleNonLocalized2:setRGB(1, 1, 1)
			f13_arg0.TitleNonLocalized2:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.TitleNonLocalized2)
			f13_arg0.TitleNonLocalized:completeAnimation()
			f13_arg0.TitleNonLocalized:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.TitleNonLocalized)
			f13_arg0.Title:completeAnimation()
			f13_arg0.Title:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Title)
			f13_arg0.TitleBorder:completeAnimation()
			f13_arg0.TitleBorder:setTopBottom(0, 0, 57, 58)
			f13_arg0.clipFinished(f13_arg0.TitleBorder)
			f13_arg0.Border:completeAnimation()
			f13_arg0.Border:setTopBottom(0, 1, 0, 0)
			f13_arg0.clipFinished(f13_arg0.Border)
		end,
	},
	NoTitle = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(5)
			f14_arg0.TitleBG:completeAnimation()
			f14_arg0.TitleBG:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.TitleBG)
			f14_arg0.ActionList:completeAnimation()
			f14_arg0.ActionList:setTopBottom(0, 0, 5, 248)
			f14_arg0.clipFinished(f14_arg0.ActionList)
			f14_arg0.TitleNonLocalized2:completeAnimation()
			f14_arg0.TitleNonLocalized2:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.TitleNonLocalized2)
			f14_arg0.Title:completeAnimation()
			f14_arg0.Title:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Title)
			f14_arg0.TitleBorder:completeAnimation()
			f14_arg0.TitleBorder:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.TitleBorder)
		end,
	},
	TitleNonLocalized = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.TitleNonLocalized2:completeAnimation()
			f15_arg0.TitleNonLocalized2:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.TitleNonLocalized2)
			f15_arg0.TitleNonLocalized:completeAnimation()
			f15_arg0.TitleNonLocalized:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.TitleNonLocalized)
			f15_arg0.Title:completeAnimation()
			f15_arg0.Title:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Title)
		end,
	},
}
CoD.ContextualMenu.__onClose = function(f16_arg0)
	f16_arg0.FocusBlocker:close()
	f16_arg0.ActionList:close()
	f16_arg0.TitleNonLocalized2:close()
	f16_arg0.TitleNonLocalized:close()
	f16_arg0.Title:close()
end
