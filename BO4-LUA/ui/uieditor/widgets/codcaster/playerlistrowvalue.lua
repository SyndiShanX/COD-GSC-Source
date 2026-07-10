CoD.PlayerListRowValue = InheritFrom(LUI.UIElement)
CoD.PlayerListRowValue.__defaultWidth = 47
CoD.PlayerListRowValue.__defaultHeight = 15
CoD.PlayerListRowValue.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerListRowValue)
	self.id = "PlayerListRowValue"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Score0100 = LUI.UIText.new(0, 0, 0, 47, 0.5, 0.5, -7.5, 7.5)
	Score0100:setText(0)
	Score0100:setTTF("0arame_mono_stencil")
	Score0100:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(Score0100)
	self.Score0100 = Score0100
	self:mergeStateConditions({
		{
			stateName = "AsianLangauge",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerListRowValue.__resetProperties = function(f3_arg0)
	f3_arg0.Score0100:completeAnimation()
	f3_arg0.Score0100:setTopBottom(0.5, 0.5, -7.5, 7.5)
end
CoD.PlayerListRowValue.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLangauge = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.Score0100:completeAnimation()
			f5_arg0.Score0100:setTopBottom(0.5, 0.5, -2.5, 7.5)
			f5_arg0.clipFinished(f5_arg0.Score0100)
		end,
	},
}
