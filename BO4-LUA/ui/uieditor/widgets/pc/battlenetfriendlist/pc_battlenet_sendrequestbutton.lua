CoD.PC_Battlenet_SendRequestButton = InheritFrom(LUI.UIElement)
CoD.PC_Battlenet_SendRequestButton.__defaultWidth = 128
CoD.PC_Battlenet_SendRequestButton.__defaultHeight = 34
CoD.PC_Battlenet_SendRequestButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "EditBoxGlobal.BattlenetAddFriend", "")
	self:setClass(CoD.PC_Battlenet_SendRequestButton)
	self.id = "PC_Battlenet_SendRequestButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SendRequestButtonBG = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 33)
	SendRequestButtonBG:setRGB(0.07, 0.07, 0.07)
	self:addElement(SendRequestButtonBG)
	self.SendRequestButtonBG = SendRequestButtonBG
	local SendRequestButtonBorder = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 34)
	SendRequestButtonBorder:setImage(RegisterImage(0xE10410BF5DABAEA))
	SendRequestButtonBorder:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	SendRequestButtonBorder:setShaderVector(0, 0, 0, 0.03, 0.05)
	SendRequestButtonBorder:setupNineSliceShader(5, 4)
	self:addElement(SendRequestButtonBorder)
	self.SendRequestButtonBorder = SendRequestButtonBorder
	local SendRequestButtonText = LUI.UIText.new(0.5, 0.5, -61.5, 61.5, 0.5, 0.5, -9.5, 11.5)
	SendRequestButtonText:setRGB(0.3, 0.29, 0.29)
	SendRequestButtonText:setText(Engine[@"hash_4F9F1239CFD921FE"](0x49D8DE092444231))
	SendRequestButtonText:setTTF("default")
	SendRequestButtonText:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	SendRequestButtonText:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(SendRequestButtonText)
	self.SendRequestButtonText = SendRequestButtonText
	self:mergeStateConditions({
		{
			stateName = "CouldNotSend",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsControllerModelValueNonEmptyString(f1_arg1, "EditBoxGlobal.BattlenetAddFriend")
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine.GetModelForController(f1_arg1)
	f1_local5(f1_local4, f1_local6["EditBoxGlobal.BattlenetAddFriend"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "EditBoxGlobal.BattlenetAddFriend",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Battlenet_SendRequestButton.__resetProperties = function(f4_arg0)
	f4_arg0.SendRequestButtonText:completeAnimation()
	f4_arg0.SendRequestButtonBorder:completeAnimation()
	f4_arg0.SendRequestButtonBG:completeAnimation()
	f4_arg0.SendRequestButtonText:setRGB(0.3, 0.29, 0.29)
	f4_arg0.SendRequestButtonBorder:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	f4_arg0.SendRequestButtonBorder:setupNineSliceShader(5, 4)
	f4_arg0.SendRequestButtonBG:setRGB(0.07, 0.07, 0.07)
end
CoD.PC_Battlenet_SendRequestButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.SendRequestButtonText:completeAnimation()
			f5_arg0.SendRequestButtonText:setRGB(1, 1, 1)
			f5_arg0.clipFinished(f5_arg0.SendRequestButtonText)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.SendRequestButtonBG:completeAnimation()
			f6_arg0.SendRequestButtonBG:setRGB(0.17, 0.17, 0.17)
			f6_arg0.clipFinished(f6_arg0.SendRequestButtonBG)
			f6_arg0.SendRequestButtonBorder:completeAnimation()
			f6_arg0.SendRequestButtonBorder:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
			f6_arg0.SendRequestButtonBorder:setupNineSliceShader(6, 4)
			f6_arg0.clipFinished(f6_arg0.SendRequestButtonBorder)
			f6_arg0.SendRequestButtonText:completeAnimation()
			f6_arg0.SendRequestButtonText:setRGB(1, 1, 1)
			f6_arg0.clipFinished(f6_arg0.SendRequestButtonText)
		end,
	},
	CouldNotSend = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
