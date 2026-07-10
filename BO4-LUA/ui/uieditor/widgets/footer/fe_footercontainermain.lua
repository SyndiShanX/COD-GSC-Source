require("x64:be31e57b3dfd64d")
require("x64:abcd0f4f616b618")
CoD.fe_FooterContainerMain = InheritFrom(LUI.UIElement)
CoD.fe_FooterContainerMain.__defaultWidth = 1920
CoD.fe_FooterContainerMain.__defaultHeight = 97
CoD.fe_FooterContainerMain.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.fe_FooterContainerMain)
	self.id = "fe_FooterContainerMain"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local feRightContainer = CoD.fe_RightContainerMain.new(f1_arg0, f1_arg1, 1, 1, -1395, -72, 1, 1, -98, -6)
	feRightContainer:linkToElementModel(self, nil, false, function(model)
		feRightContainer:setModel(model, f1_arg1)
	end)
	self:addElement(feRightContainer)
	self.feRightContainer = feRightContainer
	local PressStartText = CoD.fe_LeftContainerMain.new(f1_arg0, f1_arg1, 0, 0, 118, 811, 1, 1, -47.5, -20.5)
	self:addElement(PressStartText)
	self.PressStartText = PressStartText
	local Logo = LUI.UIImage.new(0, 0, 45, 109, 1, 1, -66, -2)
	Logo:setImage(RegisterImage(@"hash_4AD5B9D46C446ED8"))
	self:addElement(Logo)
	self.Logo = Logo
	self:mergeStateConditions({
		{
			stateName = "PCDefault",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	feRightContainer.id = "feRightContainer"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.fe_FooterContainerMain.__resetProperties = function(f4_arg0)
	f4_arg0.PressStartText:completeAnimation()
	f4_arg0.feRightContainer:completeAnimation()
	f4_arg0.PressStartText:setLeftRight(0, 0, 118, 811)
	f4_arg0.PressStartText:setAlpha(1)
	f4_arg0.feRightContainer:setAlpha(1)
end
CoD.fe_FooterContainerMain.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1000)
					f7_arg0:setAlpha(1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.feRightContainer:beginAnimation(2000)
				f5_arg0.feRightContainer:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.feRightContainer:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.feRightContainer:completeAnimation()
			f5_arg0.feRightContainer:setAlpha(0)
			f5_local0(f5_arg0.feRightContainer)
			local f5_local1 = function(f8_arg0)
				f5_arg0.PressStartText:beginAnimation(2000)
				f5_arg0.PressStartText:setAlpha(1)
				f5_arg0.PressStartText:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.PressStartText:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.PressStartText:completeAnimation()
			f5_arg0.PressStartText:setAlpha(0)
			f5_local1(f5_arg0.PressStartText)
		end,
	},
	PCDefault = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(1000)
					f11_arg0:setAlpha(1)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
				end
				f9_arg0.feRightContainer:beginAnimation(2000)
				f9_arg0.feRightContainer:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.feRightContainer:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.feRightContainer:completeAnimation()
			f9_arg0.feRightContainer:setAlpha(0)
			f9_local0(f9_arg0.feRightContainer)
			local f9_local1 = function(f12_arg0)
				f9_arg0.PressStartText:beginAnimation(2000)
				f9_arg0.PressStartText:setAlpha(1)
				f9_arg0.PressStartText:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.PressStartText:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.PressStartText:completeAnimation()
			f9_arg0.PressStartText:setLeftRight(0, 0, 88, 1920)
			f9_arg0.PressStartText:setAlpha(0.5)
			f9_local1(f9_arg0.PressStartText)
		end,
	},
}
CoD.fe_FooterContainerMain.__onClose = function(f13_arg0)
	f13_arg0.feRightContainer:close()
	f13_arg0.PressStartText:close()
end
