require("x64:2675595fa323085")
require("x64:548e7d7d9187db5")
CoD.IGRPerksDirectorButton = InheritFrom(LUI.UIElement)
CoD.IGRPerksDirectorButton.__defaultWidth = 720
CoD.IGRPerksDirectorButton.__defaultHeight = 64
CoD.IGRPerksDirectorButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.IGRPerksDirectorButton)
	self.id = "IGRPerksDirectorButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0.25, 1.25, -175, -175, 0.5, 1.5, -32, -32)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local IGRPerksList = CoD.Footer_IGRPerksList.new(f1_arg0, f1_arg1, 0.5, 0.5, -358, 362, 0.5, 0.5, -29, 231)
	self:addElement(IGRPerksList)
	self.IGRPerksList = IGRPerksList
	local Glow = LUI.UIImage.new(0.5, 0.5, -360, -280, 0.5, 0.5, -39, 41)
	Glow:setAlpha(0.3)
	Glow:setImage(RegisterImage(0xC8FFEE47F8B6B31))
	self:addElement(Glow)
	self.Glow = Glow
	local Icon = LUI.UIImage.new(0.5, 0.5, -347.5, -293.5, 0.5, 0.5, -27, 27)
	Icon:setImage(RegisterImage(0xBCE82CFF781C72F))
	Icon:setMaterial(LUI.UIImage.GetCachedMaterial(0x98A2728B4675FB5))
	Icon:setShaderVector(0, -0.03, 0, 0, 0)
	Icon:setShaderVector(1, -46.8, 0, 0, 0)
	self:addElement(Icon)
	self.Icon = Icon
	local Title = LUI.UIText.new(0.5, 0.5, -287, -15, 0.5, 0.5, -18, 0)
	Title:setText(Engine[0xF9F1239CFD921FE](0x4C5A165B66FA0C3))
	Title:setTTF("ttmussels_demibold")
	Title:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	Title:setShaderVector(0, 1, 0, 0, 0)
	Title:setShaderVector(1, 1, 0, 0, 0)
	Title:setShaderVector(2, 1, 0.78, 0, 0.3)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Title)
	self.Title = Title
	local ActiveText = LUI.UIText.new(0.5, 0.5, -286.5, -14.5, 0.5, 0.5, 7, 20)
	ActiveText:setText(Engine[0xF9F1239CFD921FE](0x444C98BBF9AFAD5))
	ActiveText:setTTF("ttmussels_regular")
	ActiveText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ActiveText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ActiveText)
	self.ActiveText = ActiveText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.PCKoreaUtility.IsInIGR()
			end,
		},
		{
			stateName = "NewPerks",
			condition = function(menu, element, event)
				return CoD.PCKoreaUtility.HasNewIGRPerks()
			end,
		},
	})
	emptyFocusable.id = "emptyFocusable"
	IGRPerksList.id = "IGRPerksList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local7 = self
	CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	return self
end
CoD.IGRPerksDirectorButton.__resetProperties = function(f4_arg0)
	f4_arg0.Glow:completeAnimation()
	f4_arg0.Icon:completeAnimation()
	f4_arg0.IGRPerksList:completeAnimation()
	f4_arg0.Title:completeAnimation()
	f4_arg0.ActiveText:completeAnimation()
	f4_arg0.emptyFocusable:completeAnimation()
	f4_arg0.Glow:setAlpha(0.3)
	f4_arg0.Icon:setAlpha(1)
	f4_arg0.Icon:setShaderVector(0, -0.03, 0, 0, 0)
	f4_arg0.Icon:setShaderVector(1, -46.8, 0, 0, 0)
	f4_arg0.IGRPerksList:setAlpha(1)
	f4_arg0.Title:setAlpha(1)
	f4_arg0.ActiveText:setAlpha(1)
	f4_arg0.emptyFocusable:setAlpha(1)
end
CoD.IGRPerksDirectorButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(1500)
					f7_arg0:setAlpha(0.25)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.Glow:beginAnimation(1990)
				f5_arg0.Glow:setAlpha(0.35)
				f5_arg0.Glow:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Glow:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.Glow:completeAnimation()
			f5_arg0.Glow:setAlpha(0.25)
			f5_local0(f5_arg0.Glow)
			local f5_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(490)
					f9_arg0:setShaderVector(0, 1.03, 0, 0, 0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f8_arg0:beginAnimation(1010)
				f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f5_arg0.Icon:beginAnimation(1990)
			f5_arg0.Icon:setShaderVector(0, -0.34, 0, 0, 0)
			f5_arg0.Icon:setShaderVector(1, -46.8, 0, 0, 0)
			f5_arg0.Icon:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
			f5_arg0.Icon:registerEventHandler("transition_complete_keyframe", f5_local1)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(6)
			f10_arg0.emptyFocusable:completeAnimation()
			f10_arg0.emptyFocusable:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.emptyFocusable)
			f10_arg0.IGRPerksList:completeAnimation()
			f10_arg0.IGRPerksList:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.IGRPerksList)
			f10_arg0.Glow:completeAnimation()
			f10_arg0.Glow:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Glow)
			f10_arg0.Icon:completeAnimation()
			f10_arg0.Icon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Icon)
			f10_arg0.Title:completeAnimation()
			f10_arg0.Title:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Title)
			f10_arg0.ActiveText:completeAnimation()
			f10_arg0.ActiveText:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.ActiveText)
		end,
	},
	NewPerks = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			local f11_local0 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(1540)
					f13_arg0:setAlpha(0.3)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.Glow:beginAnimation(1620)
				f11_arg0.Glow:setAlpha(0.75)
				f11_arg0.Glow:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Glow:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f11_arg0.Glow:completeAnimation()
			f11_arg0.Glow:setAlpha(0.3)
			f11_local0(f11_arg0.Glow)
			f11_arg0.nextClip = "DefaultClip"
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.IGRPerksList:completeAnimation()
			f14_arg0.IGRPerksList:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.IGRPerksList)
		end,
	},
}
CoD.IGRPerksDirectorButton.__onClose = function(f15_arg0)
	f15_arg0.emptyFocusable:close()
	f15_arg0.IGRPerksList:close()
end
