CoD.ReadyEvents_Scorestreaks_Iconcontainer = InheritFrom(LUI.UIElement)
CoD.ReadyEvents_Scorestreaks_Iconcontainer.__defaultWidth = 62
CoD.ReadyEvents_Scorestreaks_Iconcontainer.__defaultHeight = 50
CoD.ReadyEvents_Scorestreaks_Iconcontainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReadyEvents_Scorestreaks_Iconcontainer)
	self.id = "ReadyEvents_Scorestreaks_Iconcontainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = LUI.UIImage.new(0, 0, 6, 56, 0, 0, 0, 50)
	self:addElement(Icon)
	self.Icon = Icon
	local pipLeft = LUI.UIImage.new(0, 0, 0, 6, 0, 0, 0, 50)
	pipLeft:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	pipLeft:setImage(RegisterImage(0xE2FF966B89C00A4))
	self:addElement(pipLeft)
	self.pipLeft = pipLeft
	local pipLeftAdd = LUI.UIImage.new(0, 0, 0, 6, 0, 0, 0, 50)
	pipLeftAdd:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	pipLeftAdd:setImage(RegisterImage(0xE2FF966B89C00A4))
	pipLeftAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	pipLeftAdd:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(pipLeftAdd)
	self.pipLeftAdd = pipLeftAdd
	local pipRight = LUI.UIImage.new(0, 0, 56, 62, 0, 0, 0, 50)
	pipRight:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	pipRight:setImage(RegisterImage(0xE2FF966B89C00A4))
	self:addElement(pipRight)
	self.pipRight = pipRight
	local pipRightAdd = LUI.UIImage.new(0, 0, 56, 62, 0, 0, 0, 50)
	pipRightAdd:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	pipRightAdd:setImage(RegisterImage(0xE2FF966B89C00A4))
	pipRightAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	pipRightAdd:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(pipRightAdd)
	self.pipRightAdd = pipRightAdd
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReadyEvents_Scorestreaks_Iconcontainer.__resetProperties = function(f2_arg0)
	f2_arg0.pipLeftAdd:completeAnimation()
	f2_arg0.pipRightAdd:completeAnimation()
	f2_arg0.pipLeftAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f2_arg0.pipLeftAdd:setShaderVector(0, 2, 0, 0, 0)
	f2_arg0.pipRightAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	f2_arg0.pipRightAdd:setShaderVector(0, 2, 0, 0, 0)
end
CoD.ReadyEvents_Scorestreaks_Iconcontainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(2)
			local f3_local0 = function(f4_arg0)
				local f4_local0 = function(f5_arg0)
					local f5_local0 = function(f6_arg0)
						local f6_local0 = function(f7_arg0)
							f7_arg0:beginAnimation(250)
							f7_arg0:setShaderVector(0, 1, 0, 0, 0)
							f7_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f6_arg0:beginAnimation(250)
						f6_arg0:setShaderVector(0, 3.5, 0, 0, 0)
						f6_arg0:registerEventHandler("transition_complete_keyframe", f6_local0)
					end
					f5_arg0:beginAnimation(250)
					f5_arg0:setShaderVector(0, 1, 0, 0, 0)
					f5_arg0:registerEventHandler("transition_complete_keyframe", f5_local0)
				end
				f3_arg0.pipLeftAdd:beginAnimation(250)
				f3_arg0.pipLeftAdd:setShaderVector(0, 3.5, 0, 0, 0)
				f3_arg0.pipLeftAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.pipLeftAdd:registerEventHandler("transition_complete_keyframe", f4_local0)
			end
			f3_arg0.pipLeftAdd:completeAnimation()
			f3_arg0.pipLeftAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f3_arg0.pipLeftAdd:setShaderVector(0, 1, 0, 0, 0)
			f3_local0(f3_arg0.pipLeftAdd)
			local f3_local1 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					local f9_local0 = function(f10_arg0)
						local f10_local0 = function(f11_arg0)
							f11_arg0:beginAnimation(250)
							f11_arg0:setShaderVector(0, 1, 0, 0, 0)
							f11_arg0:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
						end
						f10_arg0:beginAnimation(250)
						f10_arg0:setShaderVector(0, 3.5, 0, 0, 0)
						f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
					end
					f9_arg0:beginAnimation(250)
					f9_arg0:setShaderVector(0, 1, 0, 0, 0)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f9_local0)
				end
				f3_arg0.pipRightAdd:beginAnimation(250)
				f3_arg0.pipRightAdd:setShaderVector(0, 3.5, 0, 0, 0)
				f3_arg0.pipRightAdd:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.pipRightAdd:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f3_arg0.pipRightAdd:completeAnimation()
			f3_arg0.pipRightAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
			f3_arg0.pipRightAdd:setShaderVector(0, 1, 0, 0, 0)
			f3_local1(f3_arg0.pipRightAdd)
			f3_arg0.nextClip = "DefaultClip"
		end,
	},
}
