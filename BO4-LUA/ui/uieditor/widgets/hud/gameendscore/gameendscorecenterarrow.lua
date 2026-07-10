CoD.GameEndScoreCenterArrow = InheritFrom(LUI.UIElement)
CoD.GameEndScoreCenterArrow.__defaultWidth = 160
CoD.GameEndScoreCenterArrow.__defaultHeight = 73
CoD.GameEndScoreCenterArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScoreCenterArrow)
	self.id = "GameEndScoreCenterArrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EndFui = LUI.UIImage.new(0, 0, 0, 160, 0, 0, 1, 73)
	EndFui:setImage(RegisterImage(0x3A4620C75ACB27C))
	EndFui:setMaterial(LUI.UIImage.GetCachedMaterial(0x2EEB1ECF1F211F5))
	EndFui:setShaderVector(0, 0, 1, 0, 0)
	EndFui:setShaderVector(1, 0, 0, 0, 0)
	EndFui:setShaderVector(2, 0, 1, 0, 0)
	EndFui:setShaderVector(3, 0, 0, 0, 0)
	EndFui:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(EndFui)
	self.EndFui = EndFui
	local EndFuiAdd = LUI.UIImage.new(0, 0, 0, 160, 0, 0, 0, 72)
	EndFuiAdd:setImage(RegisterImage(0x3A4620C75ACB27C))
	EndFuiAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	EndFuiAdd:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(EndFuiAdd)
	self.EndFuiAdd = EndFuiAdd
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreCenterArrow.__resetProperties = function(f3_arg0)
	f3_arg0.EndFuiAdd:completeAnimation()
	f3_arg0.EndFui:completeAnimation()
	f3_arg0.EndFuiAdd:setAlpha(1)
	f3_arg0.EndFuiAdd:setShaderVector(0, 1, 0, 0, 0)
	f3_arg0.EndFui:setAlpha(1)
	f3_arg0.EndFui:setShaderVector(0, 0, 1, 0, 0)
	f3_arg0.EndFui:setShaderVector(1, 0, 0, 0, 0)
	f3_arg0.EndFui:setShaderVector(2, 0, 1, 0, 0)
	f3_arg0.EndFui:setShaderVector(3, 0, 0, 0, 0)
	f3_arg0.EndFui:setShaderVector(4, 0, 0, 0, 0)
end
CoD.GameEndScoreCenterArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f6_arg0:setAlpha(0.5)
					f6_arg0:setShaderVector(0, 1, 1, 0, 0)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.EndFui:beginAnimation(1000, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f4_arg0.EndFui:setAlpha(1)
				f4_arg0.EndFui:setShaderVector(0, 0, 1, 0, 0)
				f4_arg0.EndFui:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.EndFui:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.EndFui:completeAnimation()
			f4_arg0.EndFui:setAlpha(0.5)
			f4_arg0.EndFui:setShaderVector(0, 0, 0, 0, 0)
			f4_arg0.EndFui:setShaderVector(1, 0, 0, 0, 0)
			f4_arg0.EndFui:setShaderVector(2, 0, 1, 0, 0)
			f4_arg0.EndFui:setShaderVector(3, 0, 0, 0, 0)
			f4_arg0.EndFui:setShaderVector(4, 0, 0, 0, 0)
			f4_local0(f4_arg0.EndFui)
			local f4_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(1000)
					f8_arg0:setShaderVector(0, 1, 0, 0, 0)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.EndFuiAdd:beginAnimation(1000)
				f4_arg0.EndFuiAdd:setShaderVector(0, 2, 0, 0, 0)
				f4_arg0.EndFuiAdd:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.EndFuiAdd:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f4_arg0.EndFuiAdd:completeAnimation()
			f4_arg0.EndFuiAdd:setAlpha(1)
			f4_arg0.EndFuiAdd:setShaderVector(0, 1, 0, 0, 0)
			f4_local1(f4_arg0.EndFuiAdd)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
	PC = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
}
