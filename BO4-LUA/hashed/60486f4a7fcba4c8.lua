CoD.ShowPlayButtonHintText = InheritFrom(LUI.UIElement)
CoD.ShowPlayButtonHintText.__defaultWidth = 800
CoD.ShowPlayButtonHintText.__defaultHeight = 30
CoD.ShowPlayButtonHintText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ShowPlayButtonHintText)
	self.id = "ShowPlayButtonHintText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ShowPlayButtonHint = LUI.UIText.new(0, 0, 0, 800, 0, 0, 0, 24)
	ShowPlayButtonHint:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ShowPlayButtonHint:setText(Engine[0xF9F1239CFD921FE](0xDB05264D4789AD1))
	ShowPlayButtonHint:setTTF("ttmussels_regular")
	ShowPlayButtonHint:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ShowPlayButtonHint:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ShowPlayButtonHint)
	self.ShowPlayButtonHint = ShowPlayButtonHint
	self:mergeStateConditions({
		{
			stateName = "ReplayHint",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueEqualToEnum(f1_arg1, "SpecialistHeadquarters", "LaunchState", CoD.CTUtility.SpecialistHeadquartersLaunchStates.STATE_CONTINUE)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = DataSources.SpecialistHeadquarters.getModel(f1_arg1)
	f1_local3(f1_local2, f1_local4.LaunchState, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "LaunchState",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ShowPlayButtonHintText.__resetProperties = function(f4_arg0)
	f4_arg0.ShowPlayButtonHint:completeAnimation()
	f4_arg0.ShowPlayButtonHint:setText(Engine[0xF9F1239CFD921FE](0xDB05264D4789AD1))
end
CoD.ShowPlayButtonHintText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	ReplayHint = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ShowPlayButtonHint:completeAnimation()
			f6_arg0.ShowPlayButtonHint:setText(Engine[0xF9F1239CFD921FE](0xD0C408E05261DE3))
			f6_arg0.clipFinished(f6_arg0.ShowPlayButtonHint)
		end,
	},
}
