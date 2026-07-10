require("x64:622b9213761be14")
CoD.ZMAARTrialTabRoundStat = InheritFrom(LUI.UIElement)
CoD.ZMAARTrialTabRoundStat.__defaultWidth = 390
CoD.ZMAARTrialTabRoundStat.__defaultHeight = 50
CoD.ZMAARTrialTabRoundStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARTrialTabRoundStat)
	self.id = "ZMAARTrialTabRoundStat"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusedBg = LUI.UIImage.new(0, 0, -2, 390, 0, 1, 0, 0)
	FocusedBg:setImage(RegisterImage(0x381E78F61AF206))
	self:addElement(FocusedBg)
	self.FocusedBg = FocusedBg
	local Num = LUI.UIText.new(0, 0, 6, 33, 0, 0, 2, 22)
	Num:setAlpha(0.5)
	Num:setTTF("skorzhen")
	Num:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Num:linkToElementModel(self, "numText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Num:setText(f2_local0)
		end
	end)
	self:addElement(Num)
	self.Num = Num
	local Title = LUI.UIText.new(0, 0, 33, 348, 0, 0, 3, 23)
	Title:setRGB(0.92, 0.92, 0.92)
	Title:setTTF("skorzhen")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Title:linkToElementModel(self, "titleText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Title:setText(f3_local0)
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local TitleUnknown = LUI.UIText.new(0, 0, 67, 390, 0, 0, 3, 23)
	TitleUnknown:setRGB(0.92, 0.92, 0.92)
	TitleUnknown:setText(Engine[0xF9F1239CFD921FE](0x521943FA0D36D36))
	TitleUnknown:setTTF("skorzhen")
	TitleUnknown:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(TitleUnknown)
	self.TitleUnknown = TitleUnknown
	local Line = LUI.UIImage.new(0, 0, 0, 348, 0, 0, 1, 21)
	Line:setImage(RegisterImage(0x9EE19EB5765A644))
	self:addElement(Line)
	self.Line = Line
	local Description = CoD.ZMAARTrialTabRoundStatDescription.new(f1_arg0, f1_arg1, 0, 0, 33, 370, 0, 0, 24, 38)
	Description:setAlpha(0.3)
	Description:linkToElementModel(self, "descText", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Description.Desc:setText(f4_local0)
		end
	end)
	self:addElement(Description)
	self.Description = Description
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARTrialTabRoundStat.__resetProperties = function(f5_arg0)
	f5_arg0.FocusedBg:completeAnimation()
	f5_arg0.Line:completeAnimation()
	f5_arg0.Title:completeAnimation()
	f5_arg0.TitleUnknown:completeAnimation()
	f5_arg0.Description:completeAnimation()
	f5_arg0.FocusedBg:setAlpha(1)
	f5_arg0.Line:setAlpha(1)
	f5_arg0.Title:setAlpha(1)
	f5_arg0.Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	f5_arg0.TitleUnknown:setLeftRight(0, 0, 67, 390)
	f5_arg0.TitleUnknown:setRGB(0.92, 0.92, 0.92)
	f5_arg0.TitleUnknown:setAlpha(1)
	f5_arg0.TitleUnknown:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	f5_arg0.Description:setAlpha(0.3)
end
CoD.ZMAARTrialTabRoundStat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(5)
			f6_arg0.FocusedBg:completeAnimation()
			f6_arg0.FocusedBg:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FocusedBg)
			f6_arg0.Title:completeAnimation()
			f6_arg0.Title:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Title)
			f6_arg0.TitleUnknown:completeAnimation()
			f6_arg0.TitleUnknown:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.TitleUnknown)
			f6_arg0.Line:completeAnimation()
			f6_arg0.Line:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Line)
			f6_arg0.Description:completeAnimation()
			f6_arg0.Description:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Description)
		end,
	},
	Complete = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.FocusedBg:completeAnimation()
			f7_arg0.FocusedBg:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.FocusedBg)
			f7_arg0.TitleUnknown:completeAnimation()
			f7_arg0.TitleUnknown:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TitleUnknown)
		end,
	},
	Focused = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.FocusedBg:completeAnimation()
			f8_arg0.FocusedBg:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.FocusedBg)
			f8_arg0.TitleUnknown:completeAnimation()
			f8_arg0.TitleUnknown:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TitleUnknown)
			f8_arg0.Line:completeAnimation()
			f8_arg0.Line:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.Line)
		end,
	},
	PreviouslyCompleted = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(4)
			f9_arg0.FocusedBg:completeAnimation()
			f9_arg0.FocusedBg:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.FocusedBg)
			f9_arg0.Title:completeAnimation()
			f9_arg0.Title:setAlpha(0.6)
			f9_arg0.clipFinished(f9_arg0.Title)
			f9_arg0.TitleUnknown:completeAnimation()
			f9_arg0.TitleUnknown:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.TitleUnknown)
			f9_arg0.Line:completeAnimation()
			f9_arg0.Line:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Line)
		end,
	},
	Incomplete = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(5)
			f10_arg0.FocusedBg:completeAnimation()
			f10_arg0.FocusedBg:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FocusedBg)
			f10_arg0.Title:completeAnimation()
			f10_arg0.Title:setAlpha(0)
			f10_arg0.Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
			f10_arg0.clipFinished(f10_arg0.Title)
			f10_arg0.TitleUnknown:completeAnimation()
			f10_arg0.TitleUnknown:setLeftRight(0, 0, 24.5, 334.5)
			f10_arg0.TitleUnknown:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
			f10_arg0.TitleUnknown:setAlpha(0.6)
			f10_arg0.TitleUnknown:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
			f10_arg0.clipFinished(f10_arg0.TitleUnknown)
			f10_arg0.Line:completeAnimation()
			f10_arg0.Line:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Line)
			f10_arg0.Description:completeAnimation()
			f10_arg0.Description:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Description)
		end,
	},
}
CoD.ZMAARTrialTabRoundStat.__onClose = function(f11_arg0)
	f11_arg0.Num:close()
	f11_arg0.Title:close()
	f11_arg0.Description:close()
end
