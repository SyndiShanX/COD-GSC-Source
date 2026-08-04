require("ui/uieditor/widgets/social/joinbuttonprompt")
CoD.Social_JoinBtn = InheritFrom(LUI.UIElement)
CoD.Social_JoinBtn.__defaultWidth = 300
CoD.Social_JoinBtn.__defaultHeight = 36
CoD.Social_JoinBtn.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_JoinBtn)
	self.id = "Social_JoinBtn"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local JoinButtonPrompt = CoD.JoinButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 0, 39, 0.5, 0.5, -19.5, 19.5)
	JoinButtonPrompt:setScale(0.8, 0.8)
	JoinButtonPrompt.KMprompt:setText(CoD.BaseUtility.AlreadyLocalized("J"))
	JoinButtonPrompt:subscribeToGlobalModel(f1_arg1, "Controller", "alt1_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			JoinButtonPrompt.GpadButtonImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(JoinButtonPrompt)
	self.JoinButtonPrompt = JoinButtonPrompt
	local joinLabel = LUI.UIText.new(0, 0, 52, 124, 0.5, 0.5, -7, 11)
	joinLabel:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	joinLabel:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/join_server_caps"))
	joinLabel:setTTF("dinnext_regular")
	joinLabel:setLetterSpacing(2)
	joinLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	joinLabel:setAlignment(Enum.LUIAlignment[@"hash_E821F0ECFF8D1C7"])
	self:addElement(joinLabel)
	self.joinLabel = joinLabel
	self:mergeStateConditions({
		{
			stateName = "IsPC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	if IsPC() then
		CoD.PCUtility.SetHandleMouse(self, true)
	end
	return self
end
CoD.Social_JoinBtn.__resetProperties = function(f4_arg0)
	f4_arg0.JoinButtonPrompt:completeAnimation()
	f4_arg0.joinLabel:completeAnimation()
	f4_arg0.JoinButtonPrompt:setAlpha(1)
	f4_arg0.joinLabel:setAlpha(1)
end
CoD.Social_JoinBtn.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	IsPC = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.JoinButtonPrompt:completeAnimation()
			f6_arg0.JoinButtonPrompt:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.JoinButtonPrompt)
			f6_arg0.joinLabel:completeAnimation()
			f6_arg0.joinLabel:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.joinLabel)
		end,
	},
}
CoD.Social_JoinBtn.__onClose = function(f7_arg0)
	f7_arg0.JoinButtonPrompt:close()
end
