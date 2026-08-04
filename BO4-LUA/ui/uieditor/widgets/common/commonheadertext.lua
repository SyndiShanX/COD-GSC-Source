require("ui/uieditor/widgets/pc/utility/verticallistspacer")
CoD.CommonHeaderText = InheritFrom(LUI.UIElement)
CoD.CommonHeaderText.__defaultWidth = 1034
CoD.CommonHeaderText.__defaultHeight = 30
CoD.CommonHeaderText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.CommonHeaderText)
	self.id = "CommonHeaderText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StageTitle = LUI.UIText.new(0, 0, 0, 769, 0, 0, -1, 31)
	StageTitle:setRGB(0.86, 0.74, 0.25)
	StageTitle:setText(LocalizeToUpperString("mpui/aar_caps"))
	StageTitle:setTTF("ttmussels_regular")
	StageTitle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	StageTitle:setShaderVector(0, 1.11, 0, 0, 0)
	StageTitle:setShaderVector(1, -0.06, 0, 0, 0)
	StageTitle:setShaderVector(2, 0.86, 0.74, 0.25, 0.24)
	StageTitle:setLetterSpacing(8)
	StageTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	StageTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(StageTitle)
	self.StageTitle = StageTitle
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 769, 787, 0, 0, 0, 30)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local subtitle = LUI.UIText.new(0, 0, 787, 1689, 0, 0, 4, 26)
	subtitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	subtitle:setTTF("ttmussels_regular")
	subtitle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	subtitle:setShaderVector(0, 0.56, 0, 0, 0)
	subtitle:setShaderVector(1, 0, 0, 0, 0)
	subtitle:setShaderVector(2, 1, 1, 1, 0.23)
	subtitle:setLetterSpacing(4)
	subtitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	subtitle:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(subtitle)
	self.subtitle = subtitle
	self:mergeStateConditions({
		{
			stateName = "ZombiesPC",
			condition = function(menu, element, event)
				return IsPC() and IsZombies()
			end,
		},
		{
			stateName = "DefaultPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine.GetGlobalModel()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f6_arg0)
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
CoD.CommonHeaderText.__resetProperties = function(f7_arg0)
	f7_arg0.StageTitle:completeAnimation()
	f7_arg0.subtitle:completeAnimation()
	f7_arg0.StageTitle:setLeftRight(0, 0, 0, 769)
	f7_arg0.StageTitle:setTopBottom(0, 0, -1, 31)
	f7_arg0.StageTitle:setRGB(0.86, 0.74, 0.25)
	f7_arg0.StageTitle:setShaderVector(0, 1.11, 0, 0, 0)
	f7_arg0.StageTitle:setShaderVector(1, -0.06, 0, 0, 0)
	f7_arg0.StageTitle:setShaderVector(2, 0.86, 0.74, 0.25, 0.24)
	f7_arg0.subtitle:setLeftRight(0, 0, 787, 1689)
end
CoD.CommonHeaderText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	ZombiesPC = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.StageTitle:completeAnimation()
			f9_arg0.StageTitle:setLeftRight(0.5, 0.5, -1404, -254)
			f9_arg0.StageTitle:setTopBottom(0, 0, 2, 30)
			f9_arg0.StageTitle:setRGB(0.83, 0.11, 0.01)
			f9_arg0.StageTitle:setShaderVector(0, 1.5, 0, 0, 0)
			f9_arg0.StageTitle:setShaderVector(1, 0, 0, 0, 0)
			f9_arg0.StageTitle:setShaderVector(2, 0.83, 0.11, 0.01, 0.15)
			f9_arg0.clipFinished(f9_arg0.StageTitle)
			f9_arg0.subtitle:completeAnimation()
			f9_arg0.subtitle:setLeftRight(0.5, 0.5, -1404, -1204)
			f9_arg0.clipFinished(f9_arg0.subtitle)
		end,
	},
	DefaultPC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.StageTitle:completeAnimation()
			f10_arg0.StageTitle:setLeftRight(0.5, 0.5, -1404, -254)
			f10_arg0.clipFinished(f10_arg0.StageTitle)
			f10_arg0.subtitle:completeAnimation()
			f10_arg0.subtitle:setLeftRight(0.5, 0.5, -1404, -1204)
			f10_arg0.clipFinished(f10_arg0.subtitle)
		end,
	},
	Zombies = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.StageTitle:completeAnimation()
			f11_arg0.StageTitle:setRGB(0.83, 0.11, 0.01)
			f11_arg0.StageTitle:setShaderVector(0, 1.5, 0, 0, 0)
			f11_arg0.StageTitle:setShaderVector(1, 0, 0, 0, 0)
			f11_arg0.StageTitle:setShaderVector(2, 0.83, 0.11, 0.01, 0.15)
			f11_arg0.clipFinished(f11_arg0.StageTitle)
		end,
	},
}
CoD.CommonHeaderText.__onClose = function(f12_arg0)
	f12_arg0.Spacer:close()
	f12_arg0.subtitle:close()
end
