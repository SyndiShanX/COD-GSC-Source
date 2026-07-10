require("x64:acbf06924421e35")
require("x64:a9255c570c68aa8")
CoD.DirectorTeamMemberEmpty = InheritFrom(LUI.UIElement)
CoD.DirectorTeamMemberEmpty.__defaultWidth = 400
CoD.DirectorTeamMemberEmpty.__defaultHeight = 85
CoD.DirectorTeamMemberEmpty.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorTeamMemberEmpty)
	self.id = "DirectorTeamMemberEmpty"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SearchingBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SearchingBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SearchingBacking:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SearchingBacking)
	self.SearchingBacking = SearchingBacking
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 400, 0.09, 0.09, -7, 78)
	NoiseTiledBacking:setAlpha(0.7)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local DarkBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DarkBacking:setRGB(0, 0, 0)
	DarkBacking:setAlpha(0)
	self:addElement(DarkBacking)
	self.DarkBacking = DarkBacking
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 0, 400, 0, 0, 0, 85)
	Frame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Frame:setAlpha(0.15)
	self:addElement(Frame)
	self.Frame = Frame
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonCornerPips:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	CommonCornerPips:setAlpha(0.8)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local EmptyText = LUI.UIText.new(0.03, 0.97, 0, 0, 0.37, 0.63, 0, 0)
	EmptyText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	EmptyText:setAlpha(0.9)
	EmptyText:setText(Engine[0xF9F1239CFD921FE](0x6ADB318F8178FC))
	EmptyText:setTTF("ttmussels_regular")
	EmptyText:setLetterSpacing(10)
	EmptyText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EmptyText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(EmptyText)
	self.EmptyText = EmptyText
	local ButtonAddPlus = nil
	ButtonAddPlus = LUI.UIImage.new(1, 1, -64, -20, 0.5, 0.5, -22, 22)
	ButtonAddPlus:setAlpha(0)
	ButtonAddPlus:setImage(RegisterImage(0x5C627FDA784DE0D))
	self:addElement(ButtonAddPlus)
	self.ButtonAddPlus = ButtonAddPlus
	local ButtonAddPlusHighlighted = nil
	ButtonAddPlusHighlighted = LUI.UIImage.new(1, 1, -64, -20, 0.5, 0.5, -22, 22)
	ButtonAddPlusHighlighted:setAlpha(0)
	ButtonAddPlusHighlighted:setImage(RegisterImage(0x63E82F3B2442EBB))
	ButtonAddPlusHighlighted:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(ButtonAddPlusHighlighted)
	self.ButtonAddPlusHighlighted = ButtonAddPlusHighlighted
	local SelectionOverlay = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SelectionOverlay:setAlpha(0)
	self:addElement(SelectionOverlay)
	self.SelectionOverlay = SelectionOverlay
	self:mergeStateConditions({
		{
			stateName = "FirstEmpty",
			condition = function(menu, element, event)
				local f2_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY)
				if f2_local0 then
					if not CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.selectedXuid", LuaDefine.INVALID_XUID_X64) and not CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "lobbyRoot.selectedXuidTeam", "team") then
						f2_local0 = not IsPC()
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "FirstEmptyPC",
			condition = function(menu, element, event)
				local f3_local0 = CoD.ModelUtility.IsSelfModelValueEnumFlagSet(element, f1_arg1, "clientListFlags", CoD.DirectorUtility.ClientListFlags.FIRST_EMPTY)
				if f3_local0 then
					if not CoD.ModelUtility.IsGlobalModelValueEqualTo("lobbyRoot.selectedXuid", LuaDefine.INVALID_XUID_X64) and not CoD.ModelUtility.IsGlobalModelValueEqualToSelfModelValue(element, "lobbyRoot.selectedXuidTeam", "team") then
						f3_local0 = IsPC()
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
	})
	self:linkToElementModel(self, "clientListFlags", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientListFlags",
		})
	end)
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x8DF2E5447F384B9]()
	f1_local11(f1_local10, f1_local12["lobbyRoot.selectedXuid"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.selectedXuid",
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x8DF2E5447F384B9]()
	f1_local11(f1_local10, f1_local12["lobbyRoot.selectedXuidTeam"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.selectedXuidTeam",
		})
	end, false)
	self:linkToElementModel(self, "team", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorTeamMemberEmpty.__resetProperties = function(f8_arg0)
	f8_arg0.EmptyText:completeAnimation()
	f8_arg0.SearchingBacking:completeAnimation()
	f8_arg0.CommonCornerPips:completeAnimation()
	f8_arg0.NoiseTiledBacking:completeAnimation()
	f8_arg0.Frame:completeAnimation()
	f8_arg0.DarkBacking:completeAnimation()
	f8_arg0.ButtonAddPlus:completeAnimation()
	f8_arg0.ButtonAddPlusHighlighted:completeAnimation()
	f8_arg0.SelectionOverlay:completeAnimation()
	f8_arg0.EmptyText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f8_arg0.EmptyText:setAlpha(0.9)
	f8_arg0.SearchingBacking:setAlpha(1)
	f8_arg0.CommonCornerPips:setAlpha(0.8)
	f8_arg0.NoiseTiledBacking:setAlpha(0.7)
	f8_arg0.Frame:setAlpha(0.15)
	f8_arg0.DarkBacking:setAlpha(0)
	f8_arg0.ButtonAddPlus:setAlpha(0)
	f8_arg0.ButtonAddPlusHighlighted:setAlpha(0)
	f8_arg0.SelectionOverlay:setAlpha(0)
end
CoD.DirectorTeamMemberEmpty.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(6)
			f9_arg0.SearchingBacking:completeAnimation()
			f9_arg0.SearchingBacking:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.SearchingBacking)
			f9_arg0.NoiseTiledBacking:completeAnimation()
			f9_arg0.NoiseTiledBacking:setAlpha(0.4)
			f9_arg0.clipFinished(f9_arg0.NoiseTiledBacking)
			f9_arg0.DarkBacking:completeAnimation()
			f9_arg0.DarkBacking:setAlpha(0.25)
			f9_arg0.clipFinished(f9_arg0.DarkBacking)
			f9_arg0.Frame:completeAnimation()
			f9_arg0.Frame:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Frame)
			f9_arg0.CommonCornerPips:completeAnimation()
			f9_arg0.CommonCornerPips:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.CommonCornerPips)
			f9_arg0.EmptyText:completeAnimation()
			f9_arg0.EmptyText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.EmptyText)
		end,
		FirstEmptyPC = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			local f10_local0 = function(f11_arg0)
				f10_arg0.EmptyText:beginAnimation(150)
				f10_arg0.EmptyText:setRGB(1, 0.99, 0.96)
				f10_arg0.EmptyText:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.EmptyText:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.EmptyText:completeAnimation()
			f10_arg0.EmptyText:setRGB(0.33, 0.3, 0.25)
			f10_arg0.EmptyText:setAlpha(0.5)
			f10_local0(f10_arg0.EmptyText)
			local f10_local1 = function(f12_arg0)
				f10_arg0.ButtonAddPlus:beginAnimation(150)
				f10_arg0.ButtonAddPlus:setAlpha(1)
				f10_arg0.ButtonAddPlus:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ButtonAddPlus:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ButtonAddPlus:completeAnimation()
			f10_arg0.ButtonAddPlus:setAlpha(0)
			f10_local1(f10_arg0.ButtonAddPlus)
			local f10_local2 = function(f13_arg0)
				f10_arg0.ButtonAddPlusHighlighted:beginAnimation(150)
				f10_arg0.ButtonAddPlusHighlighted:setAlpha(0.3)
				f10_arg0.ButtonAddPlusHighlighted:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ButtonAddPlusHighlighted:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ButtonAddPlusHighlighted:completeAnimation()
			f10_arg0.ButtonAddPlusHighlighted:setAlpha(0)
			f10_local2(f10_arg0.ButtonAddPlusHighlighted)
		end,
	},
	FirstEmpty = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.SelectionOverlay:completeAnimation()
			f15_arg0.SelectionOverlay:setAlpha(0.05)
			f15_arg0.clipFinished(f15_arg0.SelectionOverlay)
		end,
		GainFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			local f16_local0 = function(f17_arg0)
				f16_arg0.SelectionOverlay:beginAnimation(200)
				f16_arg0.SelectionOverlay:setAlpha(0.05)
				f16_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.SelectionOverlay:completeAnimation()
			f16_arg0.SelectionOverlay:setAlpha(0)
			f16_local0(f16_arg0.SelectionOverlay)
		end,
		LoseFocus = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			local f18_local0 = function(f19_arg0)
				f18_arg0.SelectionOverlay:beginAnimation(200)
				f18_arg0.SelectionOverlay:setAlpha(0)
				f18_arg0.SelectionOverlay:registerEventHandler("interrupted_keyframe", f18_arg0.clipInterrupted)
				f18_arg0.SelectionOverlay:registerEventHandler("transition_complete_keyframe", f18_arg0.clipFinished)
			end
			f18_arg0.SelectionOverlay:completeAnimation()
			f18_arg0.SelectionOverlay:setAlpha(0.05)
			f18_local0(f18_arg0.SelectionOverlay)
		end,
	},
	FirstEmptyPC = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.EmptyText:completeAnimation()
			f20_arg0.EmptyText:setRGB(1, 0.99, 0.96)
			f20_arg0.EmptyText:setAlpha(0.5)
			f20_arg0.clipFinished(f20_arg0.EmptyText)
			f20_arg0.ButtonAddPlus:completeAnimation()
			f20_arg0.ButtonAddPlus:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.ButtonAddPlus)
			f20_arg0.ButtonAddPlusHighlighted:completeAnimation()
			f20_arg0.ButtonAddPlusHighlighted:setAlpha(0.3)
			f20_arg0.clipFinished(f20_arg0.ButtonAddPlusHighlighted)
		end,
		Focus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.EmptyText:completeAnimation()
			f21_arg0.EmptyText:setRGB(1, 1, 1)
			f21_arg0.EmptyText:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.EmptyText)
			f21_arg0.ButtonAddPlus:completeAnimation()
			f21_arg0.ButtonAddPlus:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.ButtonAddPlus)
			f21_arg0.ButtonAddPlusHighlighted:completeAnimation()
			f21_arg0.ButtonAddPlusHighlighted:setAlpha(0.8)
			f21_arg0.clipFinished(f21_arg0.ButtonAddPlusHighlighted)
		end,
		GainFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				f22_arg0.EmptyText:beginAnimation(200)
				f22_arg0.EmptyText:setRGB(1, 1, 1)
				f22_arg0.EmptyText:setAlpha(1)
				f22_arg0.EmptyText:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.EmptyText:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.EmptyText:completeAnimation()
			f22_arg0.EmptyText:setRGB(1, 0.99, 0.96)
			f22_arg0.EmptyText:setAlpha(0.5)
			f22_local0(f22_arg0.EmptyText)
			local f22_local1 = function(f24_arg0)
				f22_arg0.ButtonAddPlus:beginAnimation(200)
				f22_arg0.ButtonAddPlus:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ButtonAddPlus:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.ButtonAddPlus:completeAnimation()
			f22_arg0.ButtonAddPlus:setAlpha(1)
			f22_local1(f22_arg0.ButtonAddPlus)
			local f22_local2 = function(f25_arg0)
				f22_arg0.ButtonAddPlusHighlighted:beginAnimation(200)
				f22_arg0.ButtonAddPlusHighlighted:setAlpha(0.8)
				f22_arg0.ButtonAddPlusHighlighted:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ButtonAddPlusHighlighted:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.ButtonAddPlusHighlighted:completeAnimation()
			f22_arg0.ButtonAddPlusHighlighted:setAlpha(0.3)
			f22_local2(f22_arg0.ButtonAddPlusHighlighted)
		end,
		LoseFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			local f26_local0 = function(f27_arg0)
				f26_arg0.EmptyText:beginAnimation(200)
				f26_arg0.EmptyText:setRGB(1, 0.99, 0.96)
				f26_arg0.EmptyText:setAlpha(0.5)
				f26_arg0.EmptyText:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.EmptyText:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.EmptyText:completeAnimation()
			f26_arg0.EmptyText:setRGB(1, 1, 1)
			f26_arg0.EmptyText:setAlpha(1)
			f26_local0(f26_arg0.EmptyText)
			local f26_local1 = function(f28_arg0)
				f26_arg0.ButtonAddPlus:beginAnimation(200)
				f26_arg0.ButtonAddPlus:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ButtonAddPlus:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.ButtonAddPlus:completeAnimation()
			f26_arg0.ButtonAddPlus:setAlpha(1)
			f26_local1(f26_arg0.ButtonAddPlus)
			local f26_local2 = function(f29_arg0)
				f26_arg0.ButtonAddPlusHighlighted:beginAnimation(200)
				f26_arg0.ButtonAddPlusHighlighted:setAlpha(0.3)
				f26_arg0.ButtonAddPlusHighlighted:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.ButtonAddPlusHighlighted:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.ButtonAddPlusHighlighted:completeAnimation()
			f26_arg0.ButtonAddPlusHighlighted:setAlpha(0.8)
			f26_local2(f26_arg0.ButtonAddPlusHighlighted)
		end,
	},
}
CoD.DirectorTeamMemberEmpty.__onClose = function(f30_arg0)
	f30_arg0.Frame:close()
	f30_arg0.CommonCornerPips:close()
end
