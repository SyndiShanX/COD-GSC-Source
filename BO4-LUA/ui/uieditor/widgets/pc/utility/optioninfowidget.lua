require("x64:c7f53f7ca89a4d2")
CoD.OptionInfoWidget = InheritFrom(LUI.UIElement)
CoD.OptionInfoWidget.__defaultWidth = 600
CoD.OptionInfoWidget.__defaultHeight = 450
CoD.OptionInfoWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OptionInfoWidget)
	self.id = "OptionInfoWidget"
	self.soundSet = "CAC_EditLoadout"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local description = LUI.UIText.new(0, 1, 16, 0, 0, 0, 67, 105)
	description:setRGB(0.74, 0.74, 0.74)
	description:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	description:setTTF("default")
	description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LUI.OverrideFunction_CallOriginalFirst(description, "setText", function(element, controller)
		SetStateFromText(self, element, "DefaultState", "Hidden", f1_arg1)
	end)
	self:addElement(description)
	self.description = description
	local title = CoD.TitleTextWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0.5, 51.5)
	self:addElement(title)
	self.title = title
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OptionInfoWidget.__resetProperties = function(f3_arg0)
	f3_arg0.title:completeAnimation()
	f3_arg0.description:completeAnimation()
	f3_arg0.title:setAlpha(1)
	f3_arg0.description:setAlpha(1)
end
CoD.OptionInfoWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.description:completeAnimation()
			f5_arg0.description:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.description)
			f5_arg0.title:completeAnimation()
			f5_arg0.title:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.title)
		end,
	},
}
CoD.OptionInfoWidget.__onClose = function(f6_arg0)
	f6_arg0.title:close()
end
