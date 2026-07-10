CoD.TabbedScoreboardTab = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardTab.__defaultWidth = 170
CoD.TabbedScoreboardTab.__defaultHeight = 34
CoD.TabbedScoreboardTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardTab)
	self.id = "TabbedScoreboardTab"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TabBacker2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	TabBacker2:setRGB(0.46, 0.46, 0.51)
	TabBacker2:setAlpha(0.1)
	self:addElement(TabBacker2)
	self.TabBacker2 = TabBacker2
	local TopBar = LUI.UIImage.new(-0.02, 1.03, 0, 0, 1, 1, -7, 2)
	TopBar:setAlpha(0.1)
	TopBar:setImage(RegisterImage(0xCE32B5C3D0E9039))
	TopBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(TopBar)
	self.TopBar = TopBar
	local NameNotFocus = LUI.UIText.new(-0, 1, 0, 0, 0.5, 0.5, -11, 10)
	NameNotFocus:setRGB(0.38, 0.38, 0.4)
	NameNotFocus:setAlpha(0)
	NameNotFocus:setTTF("ttmussels_regular")
	NameNotFocus:setLetterSpacing(3)
	NameNotFocus:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NameNotFocus:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	NameNotFocus:linkToElementModel(self, "tabName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NameNotFocus:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(NameNotFocus)
	self.NameNotFocus = NameNotFocus
	local NameFocus = LUI.UIText.new(-0, 1, 0, 0, 0.5, 0.5, -11, 10)
	NameFocus:setRGB(0.38, 0.38, 0.4)
	NameFocus:setTTF("ttmussels_demibold")
	NameFocus:setLetterSpacing(3)
	NameFocus:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NameFocus:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	NameFocus:linkToElementModel(self, "tabName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			NameFocus:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(NameFocus)
	self.NameFocus = NameFocus
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardTab.__resetProperties = function(f4_arg0)
	f4_arg0.NameFocus:completeAnimation()
	f4_arg0.TopBar:completeAnimation()
	f4_arg0.TabBacker2:completeAnimation()
	f4_arg0.NameNotFocus:completeAnimation()
	f4_arg0.NameFocus:setRGB(0.38, 0.38, 0.4)
	f4_arg0.NameFocus:setAlpha(1)
	f4_arg0.TopBar:setAlpha(0.1)
	f4_arg0.TabBacker2:setAlpha(0.1)
	f4_arg0.NameNotFocus:setAlpha(0)
end
CoD.TabbedScoreboardTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(4)
			f5_arg0.TabBacker2:completeAnimation()
			f5_arg0.TabBacker2:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TabBacker2)
			f5_arg0.TopBar:completeAnimation()
			f5_arg0.TopBar:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.TopBar)
			f5_arg0.NameNotFocus:completeAnimation()
			f5_arg0.NameNotFocus:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.NameNotFocus)
			f5_arg0.NameFocus:completeAnimation()
			f5_arg0.NameFocus:setRGB(0.38, 0.38, 0.4)
			f5_arg0.NameFocus:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.NameFocus)
		end,
		Active = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			local f6_local0 = function(f7_arg0)
				f6_arg0.TabBacker2:beginAnimation(300)
				f6_arg0.TabBacker2:setAlpha(0.1)
				f6_arg0.TabBacker2:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.TabBacker2:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.TabBacker2:completeAnimation()
			f6_arg0.TabBacker2:setAlpha(0)
			f6_local0(f6_arg0.TabBacker2)
			local f6_local1 = function(f8_arg0)
				f6_arg0.TopBar:beginAnimation(300)
				f6_arg0.TopBar:setAlpha(0.1)
				f6_arg0.TopBar:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.TopBar:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.TopBar:completeAnimation()
			f6_arg0.TopBar:setAlpha(0)
			f6_local1(f6_arg0.TopBar)
			local f6_local2 = function(f9_arg0)
				f6_arg0.NameFocus:beginAnimation(300)
				f6_arg0.NameFocus:setRGB(0.92, 0.89, 0.72)
				f6_arg0.NameFocus:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.NameFocus:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.NameFocus:completeAnimation()
			f6_arg0.NameFocus:setRGB(0.38, 0.38, 0.4)
			f6_arg0.NameFocus:setAlpha(1)
			f6_local2(f6_arg0.NameFocus)
		end,
		Focus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.NameFocus:completeAnimation()
			f10_arg0.NameFocus:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f10_arg0.clipFinished(f10_arg0.NameFocus)
		end,
	},
}
if not CoD.isPC then
	CoD.TabbedScoreboardTab.__clipsPerState.DefaultState.Focus = nil
end
CoD.TabbedScoreboardTab.__onClose = function(f11_arg0)
	f11_arg0.NameNotFocus:close()
	f11_arg0.NameFocus:close()
end
