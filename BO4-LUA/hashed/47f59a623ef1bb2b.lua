require("x64:b20339e832dc8eb")
CoD.SpecialistHeadquartersButton = InheritFrom(LUI.UIElement)
CoD.SpecialistHeadquartersButton.__defaultWidth = 412
CoD.SpecialistHeadquartersButton.__defaultHeight = 130
CoD.SpecialistHeadquartersButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistHeadquartersButton)
	self.id = "SpecialistHeadquartersButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SpecialistPersonalizationButtonOptionInternal = CoD.SpecialistPersonalizationButtonOptionInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	SpecialistPersonalizationButtonOptionInternal:mergeStateConditions({
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsSelfInState(self, "NoFocus")
			end,
		},
	})
	SpecialistPersonalizationButtonOptionInternal.Header:setText("")
	self:addElement(SpecialistPersonalizationButtonOptionInternal)
	self.SpecialistPersonalizationButtonOptionInternal = SpecialistPersonalizationButtonOptionInternal
	local Header = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -16.5, 16.5)
	Header:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Header:setTTF("ttmussels_regular")
	Header:setLetterSpacing(5)
	Header:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(Header)
	self.Header = Header
	local circle = LUI.UIImage.new(0, 0, 59.5, 119.5, 0.56, 0.56, -38, 22)
	circle:setRGB(0.19, 0.19, 0.19)
	circle:setAlpha(0)
	circle:setZRot(180)
	circle:setScale(1.05, 1.05)
	circle:setMaterial(LUI.UIImage.GetCachedMaterial(0x15B163CA03FCE8B))
	circle:setShaderVector(0, 4.66, 0, 0, 0)
	circle:setShaderVector(1, 80, 80, 0, 0)
	circle:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(circle)
	self.circle = circle
	local CountdownText = LUI.UIText.new(0, 0, 129.5, 184.5, 0.56, 0.56, -20, 4)
	CountdownText:setAlpha(0)
	CountdownText:setTTF("ttmussels_regular")
	CountdownText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CountdownText:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyStatus", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CountdownText:setText(ToUpper(f3_local0))
		end
	end)
	self:addElement(CountdownText)
	self.CountdownText = CountdownText
	local timer = LUI.UIText.new(0, 0, 49.5, 129.5, 0.61, 0.61, -34, 11)
	timer:setAlpha(0)
	timer:setTTF("ttmussels_demibold")
	timer:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	timer:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	timer:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTimeRemaining", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			timer:setText(f4_local0)
		end
	end)
	self:addElement(timer)
	self.timer = timer
	self:mergeStateConditions({
		{
			stateName = "MatchStart",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("lobbyRoot.lobbyTimeRemaining", 0) and AlwaysFalse()
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyTimeRemaining"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyTimeRemaining",
		})
	end, false)
	SpecialistPersonalizationButtonOptionInternal.id = "SpecialistPersonalizationButtonOptionInternal"
	self.__defaultFocus = SpecialistPersonalizationButtonOptionInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistHeadquartersButton.__resetProperties = function(f7_arg0)
	f7_arg0.timer:completeAnimation()
	f7_arg0.CountdownText:completeAnimation()
	f7_arg0.Header:completeAnimation()
	f7_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
	f7_arg0.circle:completeAnimation()
	f7_arg0.timer:setAlpha(0)
	f7_arg0.timer:setScale(1, 1)
	f7_arg0.CountdownText:setAlpha(0)
	f7_arg0.CountdownText:setScale(1, 1)
	f7_arg0.Header:setAlpha(1)
	f7_arg0.Header:setScale(1, 1)
	f7_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1, 1)
	f7_arg0.circle:setAlpha(0)
end
CoD.SpecialistHeadquartersButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f9_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1.05, 1.05)
			f9_arg0.clipFinished(f9_arg0.SpecialistPersonalizationButtonOptionInternal)
			f9_arg0.Header:completeAnimation()
			f9_arg0.Header:setScale(1.05, 1.05)
			f9_arg0.clipFinished(f9_arg0.Header)
			f9_arg0.CountdownText:completeAnimation()
			f9_arg0.CountdownText:setScale(1.05, 1.05)
			f9_arg0.clipFinished(f9_arg0.CountdownText)
			f9_arg0.timer:completeAnimation()
			f9_arg0.timer:setScale(1.05, 1.05)
			f9_arg0.clipFinished(f9_arg0.timer)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			local f10_local0 = function(f11_arg0)
				f10_arg0.SpecialistPersonalizationButtonOptionInternal:beginAnimation(200)
				f10_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1.05, 1.05)
				f10_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f10_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1, 1)
			f10_local0(f10_arg0.SpecialistPersonalizationButtonOptionInternal)
			local f10_local1 = function(f12_arg0)
				f10_arg0.Header:beginAnimation(200)
				f10_arg0.Header:setScale(1.05, 1.05)
				f10_arg0.Header:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Header:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Header:completeAnimation()
			f10_arg0.Header:setScale(1, 1)
			f10_local1(f10_arg0.Header)
			local f10_local2 = function(f13_arg0)
				f10_arg0.CountdownText:beginAnimation(200)
				f10_arg0.CountdownText:setScale(1.05, 1.05)
				f10_arg0.CountdownText:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.CountdownText:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.CountdownText:completeAnimation()
			f10_arg0.CountdownText:setScale(1, 1)
			f10_local2(f10_arg0.CountdownText)
			local f10_local3 = function(f14_arg0)
				f10_arg0.timer:beginAnimation(200)
				f10_arg0.timer:setScale(1.05, 1.05)
				f10_arg0.timer:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.timer:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.timer:completeAnimation()
			f10_arg0.timer:setScale(1, 1)
			f10_local3(f10_arg0.timer)
		end,
		LoseChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(4)
			local f15_local0 = function(f16_arg0)
				f15_arg0.SpecialistPersonalizationButtonOptionInternal:beginAnimation(200)
				f15_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1, 1)
				f15_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.SpecialistPersonalizationButtonOptionInternal:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.SpecialistPersonalizationButtonOptionInternal:completeAnimation()
			f15_arg0.SpecialistPersonalizationButtonOptionInternal:setScale(1.05, 1.05)
			f15_local0(f15_arg0.SpecialistPersonalizationButtonOptionInternal)
			local f15_local1 = function(f17_arg0)
				f15_arg0.Header:beginAnimation(200)
				f15_arg0.Header:setScale(1, 1)
				f15_arg0.Header:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.Header:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.Header:completeAnimation()
			f15_arg0.Header:setScale(1.05, 1.05)
			f15_local1(f15_arg0.Header)
			local f15_local2 = function(f18_arg0)
				f15_arg0.CountdownText:beginAnimation(200)
				f15_arg0.CountdownText:setScale(1, 1)
				f15_arg0.CountdownText:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.CountdownText:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.CountdownText:completeAnimation()
			f15_arg0.CountdownText:setScale(1.05, 1.05)
			f15_local2(f15_arg0.CountdownText)
			local f15_local3 = function(f19_arg0)
				f15_arg0.timer:beginAnimation(200)
				f15_arg0.timer:setScale(1, 1)
				f15_arg0.timer:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.timer:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.timer:completeAnimation()
			f15_arg0.timer:setScale(1.05, 1.05)
			f15_local3(f15_arg0.timer)
		end,
	},
	MatchStart = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(4)
			f20_arg0.Header:completeAnimation()
			f20_arg0.Header:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.Header)
			f20_arg0.circle:completeAnimation()
			f20_arg0.circle:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.circle)
			f20_arg0.CountdownText:completeAnimation()
			f20_arg0.CountdownText:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.CountdownText)
			f20_arg0.timer:completeAnimation()
			f20_arg0.timer:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.timer)
		end,
	},
}
CoD.SpecialistHeadquartersButton.__onClose = function(f21_arg0)
	f21_arg0.SpecialistPersonalizationButtonOptionInternal:close()
	f21_arg0.CountdownText:close()
	f21_arg0.timer:close()
end
