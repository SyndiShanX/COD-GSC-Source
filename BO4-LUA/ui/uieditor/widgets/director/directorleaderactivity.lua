require("x64:acbf06924421e35")
CoD.DirectorLeaderActivity = InheritFrom(LUI.UIElement)
CoD.DirectorLeaderActivity.__defaultWidth = 467
CoD.DirectorLeaderActivity.__defaultHeight = 30
CoD.DirectorLeaderActivity.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorLeaderActivity)
	self.id = "DirectorLeaderActivity"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local PixelGrid = LUI.UIImage.new(0, 1, 0, 0, 0, 0.99, 0, 0)
	PixelGrid:setAlpha(0.08)
	PixelGrid:setImage(RegisterImage(0x311E811A3183347))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(128, 128)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local LeaderActivityText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -10, 10)
	LeaderActivityText:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	LeaderActivityText:setTTF("ttmussels_regular")
	LeaderActivityText:setLetterSpacing(6)
	LeaderActivityText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	LeaderActivityText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LeaderActivityText:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "leaderActivity", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LeaderActivityText:setText(ConvertToUpperString(f2_local0))
		end
	end)
	self:addElement(LeaderActivityText)
	self.LeaderActivityText = LeaderActivityText
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_arg0, f1_arg1, 0, 0, 0, 467, 0, 0, 0, 30)
	CommonCornerPips:setAlpha(0.2)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorLeaderActivity.__resetProperties = function(f4_arg0)
	f4_arg0.LeaderActivityText:completeAnimation()
	f4_arg0.LeaderActivityText:setAlpha(1)
end
CoD.DirectorLeaderActivity.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.LeaderActivityText:completeAnimation()
			f5_arg0.LeaderActivityText:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.LeaderActivityText)
		end,
	},
	Visible = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorLeaderActivity.__onClose = function(f7_arg0)
	f7_arg0.LeaderActivityText:close()
	f7_arg0.CommonCornerPips:close()
end
