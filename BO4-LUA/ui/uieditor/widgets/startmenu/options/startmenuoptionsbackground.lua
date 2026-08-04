CoD.StartMenuOptionsBackground = InheritFrom(LUI.UIElement)
CoD.StartMenuOptionsBackground.__defaultWidth = 1920
CoD.StartMenuOptionsBackground.__defaultHeight = 1081
CoD.StartMenuOptionsBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenuOptionsBackground)
	self.id = "StartMenuOptionsBackground"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlur:setRGB(0.08, 0.08, 0.08)
	BGBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	BGBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(BGBlur)
	self.BGBlur = BGBlur
	local BGBlack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGBlack:setAlpha(0.9)
	BGBlack:setImage(RegisterImage("uie_fe_cp_background"))
	self:addElement(BGBlack)
	self.BGBlack = BGBlack
	self:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return IsInGame() and IsWarzone()
			end,
		},
		{
			stateName = "Ingame",
			condition = function(menu, element, event)
				return IsInGame()
			end,
		},
		{
			stateName = "PCFrontend",
			condition = function(menu, element, event)
				return IsPC() and InFrontend()
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine.GetGlobalModel()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenuOptionsBackground.__resetProperties = function(f6_arg0)
	f6_arg0.BGBlack:completeAnimation()
	f6_arg0.BGBlur:completeAnimation()
	f6_arg0.BGBlack:setAlpha(0.9)
	f6_arg0.BGBlur:setTopBottom(0, 1, 0, 0)
	f6_arg0.BGBlur:setShaderVector(0, 0, 0, 0, 0)
end
CoD.StartMenuOptionsBackground.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Warzone = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.BGBlur:completeAnimation()
			f8_arg0.BGBlur:setShaderVector(0, 0, 0.85, 0, 0)
			f8_arg0.clipFinished(f8_arg0.BGBlur)
			f8_arg0.BGBlack:completeAnimation()
			f8_arg0.BGBlack:setAlpha(0.9)
			f8_arg0.clipFinished(f8_arg0.BGBlack)
		end,
	},
	Ingame = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.BGBlur:completeAnimation()
			f9_arg0.BGBlur:setTopBottom(0, 1, 0, 0)
			f9_arg0.clipFinished(f9_arg0.BGBlur)
		end,
	},
	PCFrontend = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.BGBlur:completeAnimation()
			f10_arg0.BGBlur:setTopBottom(0, 1, 0, 0)
			f10_arg0.clipFinished(f10_arg0.BGBlur)
		end,
	},
}
