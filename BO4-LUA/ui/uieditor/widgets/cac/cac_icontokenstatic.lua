CoD.cac_IconTokenStatic = InheritFrom(LUI.UIElement)
CoD.cac_IconTokenStatic.__defaultWidth = 48
CoD.cac_IconTokenStatic.__defaultHeight = 48
CoD.cac_IconTokenStatic.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.cac_IconTokenStatic)
	self.id = "cac_IconTokenStatic"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local imgTokenBox = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	imgTokenBox:setAlpha(0)
	imgTokenBox:setImage(RegisterImage(0xACB6BFF8B3FFB88))
	imgTokenBox:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(imgTokenBox)
	self.imgTokenBox = imgTokenBox
	local imgIconTokenMult = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	imgIconTokenMult:setRGB(0, 0, 0)
	imgIconTokenMult:setAlpha(0.43)
	self:addElement(imgIconTokenMult)
	self.imgIconTokenMult = imgIconTokenMult
	local imgIconTokenMultCP = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	imgIconTokenMultCP:setRGB(0, 0, 0)
	imgIconTokenMultCP:setAlpha(0)
	imgIconTokenMultCP:setImage(RegisterImage(0x53E30FEAEAC8F83))
	self:addElement(imgIconTokenMultCP)
	self.imgIconTokenMultCP = imgIconTokenMultCP
	local imgIconToken = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	imgIconToken:setAlpha(0.92)
	imgIconToken:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(imgIconToken)
	self.imgIconToken = imgIconToken
	local imgIconTokenCP = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	imgIconTokenCP:setAlpha(0)
	imgIconTokenCP:setImage(RegisterImage(0x53E30FEAEAC8F83))
	self:addElement(imgIconTokenCP)
	self.imgIconTokenCP = imgIconTokenCP
	local glow = LUI.UIImage.new(0, 1, 0, 20, 0, 1, -3, 17)
	glow:setRGB(1, 0.48, 0)
	glow:setAlpha(RandomAddPercent(-15, 0.26))
	glow:setImage(RegisterImage(0x1078C36A022A4FE))
	glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(glow)
	self.glow = glow
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return not IsCampaign()
			end,
		},
		{
			stateName = "VisibleCP",
			condition = function(menu, element, event)
				return IsCampaign()
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.cac_IconTokenStatic.__resetProperties = function(f5_arg0)
	f5_arg0.glow:completeAnimation()
	f5_arg0.imgIconToken:completeAnimation()
	f5_arg0.imgIconTokenMult:completeAnimation()
	f5_arg0.imgTokenBox:completeAnimation()
	f5_arg0.imgIconTokenCP:completeAnimation()
	f5_arg0.imgIconTokenMultCP:completeAnimation()
	f5_arg0.glow:setAlpha(RandomAddPercent(-15, 0.26))
	f5_arg0.imgIconToken:setAlpha(0.92)
	f5_arg0.imgIconTokenMult:setAlpha(0.43)
	f5_arg0.imgTokenBox:setLeftRight(0, 1, 0, 0)
	f5_arg0.imgTokenBox:setTopBottom(0, 1, 0, 0)
	f5_arg0.imgTokenBox:setAlpha(0)
	f5_arg0.imgIconTokenCP:setAlpha(0)
	f5_arg0.imgIconTokenMultCP:setAlpha(0)
end
CoD.cac_IconTokenStatic.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.imgIconTokenMult:completeAnimation()
			f6_arg0.imgIconTokenMult:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.imgIconTokenMult)
			f6_arg0.imgIconToken:completeAnimation()
			f6_arg0.imgIconToken:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.imgIconToken)
			f6_arg0.glow:completeAnimation()
			f6_arg0.glow:setAlpha(RandomAddPercent(-15, 0))
			f6_arg0.clipFinished(f6_arg0.glow)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.imgTokenBox:completeAnimation()
			f7_arg0.imgTokenBox:setLeftRight(0, 1, -2, 6)
			f7_arg0.imgTokenBox:setTopBottom(0, 1, -6, 6)
			f7_arg0.clipFinished(f7_arg0.imgTokenBox)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(500)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.glow:beginAnimation(500)
				f7_arg0.glow:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.glow:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.glow:completeAnimation()
			f7_arg0.glow:setAlpha(RandomAddPercent(-15, 0.26))
			f7_local0(f7_arg0.glow)
			f7_arg0.nextClip = "DefaultClip"
		end,
	},
	VisibleCP = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(6)
			f10_arg0.imgTokenBox:completeAnimation()
			f10_arg0.imgTokenBox:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.imgTokenBox)
			f10_arg0.imgIconTokenMult:completeAnimation()
			f10_arg0.imgIconTokenMult:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.imgIconTokenMult)
			f10_arg0.imgIconTokenMultCP:completeAnimation()
			f10_arg0.imgIconTokenMultCP:setAlpha(0.43)
			f10_arg0.clipFinished(f10_arg0.imgIconTokenMultCP)
			f10_arg0.imgIconToken:completeAnimation()
			f10_arg0.imgIconToken:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.imgIconToken)
			f10_arg0.imgIconTokenCP:completeAnimation()
			f10_arg0.imgIconTokenCP:setAlpha(0.92)
			f10_arg0.clipFinished(f10_arg0.imgIconTokenCP)
			local f10_local0 = function(f11_arg0)
				local f11_local0 = function(f12_arg0)
					f12_arg0:beginAnimation(500)
					f12_arg0:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
				end
				f10_arg0.glow:beginAnimation(500)
				f10_arg0.glow:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.glow:registerEventHandler("transition_complete_keyframe", f11_local0)
			end
			f10_arg0.glow:completeAnimation()
			f10_arg0.glow:setAlpha(RandomAddPercent(-15, 0.26))
			f10_local0(f10_arg0.glow)
			f10_arg0.nextClip = "DefaultClip"
		end,
	},
}
