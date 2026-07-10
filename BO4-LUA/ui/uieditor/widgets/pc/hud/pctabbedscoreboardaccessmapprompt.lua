require("x64:213d6270090adf7")
CoD.PCTabbedScoreboardAccessMapPrompt = InheritFrom(LUI.UIElement)
CoD.PCTabbedScoreboardAccessMapPrompt.__defaultWidth = 1720
CoD.PCTabbedScoreboardAccessMapPrompt.__defaultHeight = 40
CoD.PCTabbedScoreboardAccessMapPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCTabbedScoreboardAccessMapPrompt)
	self.id = "PCTabbedScoreboardAccessMapPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBacking = CoD.TextBacking.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	TextBacking.Blur:setAlpha(0.65)
	TextBacking.Backing:setRGB(0.13, 0.13, 0.13)
	self:addElement(TextBacking)
	self.TextBacking = TextBacking
	local AccessScoreboardPrompt = LUI.UIText.new(0.5, 0.5, -860, 860, 0.5, 0.5, -20, 20)
	AccessScoreboardPrompt:setRGB(0.76, 0.76, 0.76)
	AccessScoreboardPrompt:setScale(0.55, 0.55)
	AccessScoreboardPrompt:setText(Engine[0xF9F1239CFD921FE](0x9294677CBFFED66))
	AccessScoreboardPrompt:setTTF("dinnext_regular")
	AccessScoreboardPrompt:setLetterSpacing(3)
	AccessScoreboardPrompt:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	AccessScoreboardPrompt:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(AccessScoreboardPrompt)
	self.AccessScoreboardPrompt = AccessScoreboardPrompt
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Scores",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_SCORES)
			end,
		},
		{
			stateName = "Map",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "scoreboardInfo.activeTab", CoD.HUDUtility.GameStatusMode.MODE_SHOW_MAP)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["scoreboardInfo.activeTab"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "scoreboardInfo.activeTab",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCTabbedScoreboardAccessMapPrompt.__resetProperties = function(f8_arg0)
	f8_arg0.TextBacking:completeAnimation()
	f8_arg0.AccessScoreboardPrompt:completeAnimation()
	f8_arg0.TextBacking:setTopBottom(0, 1, 0, 0)
	f8_arg0.TextBacking:setAlpha(1)
	f8_arg0.AccessScoreboardPrompt:setTopBottom(0.5, 0.5, -20, 20)
	f8_arg0.AccessScoreboardPrompt:setAlpha(1)
end
CoD.PCTabbedScoreboardAccessMapPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.TextBacking:completeAnimation()
			f9_arg0.TextBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TextBacking)
			f9_arg0.AccessScoreboardPrompt:completeAnimation()
			f9_arg0.AccessScoreboardPrompt:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.AccessScoreboardPrompt)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.TextBacking:completeAnimation()
			f10_arg0.TextBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.TextBacking)
			f10_arg0.AccessScoreboardPrompt:completeAnimation()
			f10_arg0.AccessScoreboardPrompt:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.AccessScoreboardPrompt)
		end,
	},
	Scores = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.TextBacking:completeAnimation()
			f11_arg0.TextBacking:setTopBottom(0, 1, 0, 0)
			f11_arg0.clipFinished(f11_arg0.TextBacking)
			f11_arg0.AccessScoreboardPrompt:completeAnimation()
			f11_arg0.AccessScoreboardPrompt:setTopBottom(0.5, 0.5, -20, 20)
			f11_arg0.clipFinished(f11_arg0.AccessScoreboardPrompt)
		end,
	},
	Map = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.TextBacking:completeAnimation()
			f12_arg0.TextBacking:setTopBottom(0, 1, 75, 75)
			f12_arg0.clipFinished(f12_arg0.TextBacking)
			f12_arg0.AccessScoreboardPrompt:completeAnimation()
			f12_arg0.AccessScoreboardPrompt:setTopBottom(0.5, 0.5, 55, 95)
			f12_arg0.clipFinished(f12_arg0.AccessScoreboardPrompt)
		end,
	},
}
CoD.PCTabbedScoreboardAccessMapPrompt.__onClose = function(f13_arg0)
	f13_arg0.TextBacking:close()
end
