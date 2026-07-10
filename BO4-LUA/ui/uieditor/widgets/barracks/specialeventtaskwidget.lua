require("x64:5be072bd539a5e")
require("x64:a9255c570c68aa8")
CoD.SpecialEventTaskWidget = InheritFrom(LUI.UIElement)
CoD.SpecialEventTaskWidget.__defaultWidth = 453
CoD.SpecialEventTaskWidget.__defaultHeight = 100
CoD.SpecialEventTaskWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialEventTaskWidget)
	self.id = "SpecialEventTaskWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bgKill = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	bgKill:setRGB(0.23, 0.23, 0.23)
	bgKill:setAlpha(0.25)
	self:addElement(bgKill)
	self.bgKill = bgKill
	local IconFrame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 0, 3.5, 85.5, 0, 0, 3, 85)
	IconFrame:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	IconFrame:setAlpha(0)
	self:addElement(IconFrame)
	self.IconFrame = IconFrame
	local CallingIcon = LUI.UIImage.new(0, 0, 5.5, 83.5, 0, 0, 5, 83)
	CallingIcon:linkToElementModel(self, "taskIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CallingIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(CallingIcon)
	self.CallingIcon = CallingIcon
	local TaskName = LUI.UIText.new(0, 0, 107, 444, 0, 0, 5, 25)
	TaskName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	TaskName:setTTF("ttmussels_demibold")
	TaskName:setLetterSpacing(2)
	TaskName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TaskName:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	TaskName:linkToElementModel(self, "taskName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			TaskName:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(TaskName)
	self.TaskName = TaskName
	local TaskDescription = LUI.UIText.new(0, 0, 107, 444, 0, 0, 29, 44)
	TaskDescription:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TaskDescription:setTTF("dinnext_regular")
	TaskDescription:setLetterSpacing(1)
	TaskDescription:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TaskDescription:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TaskDescription:linkToElementModel(self, "taskDescription", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TaskDescription:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(TaskDescription)
	self.TaskDescription = TaskDescription
	local TaskProgressString = LUI.UIText.new(0, 0, 94, 448, 0, 0, 70, 85)
	TaskProgressString:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	TaskProgressString:setTTF("dinnext_regular")
	TaskProgressString:setLetterSpacing(1)
	TaskProgressString:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	TaskProgressString:linkToElementModel(self, "taskProgressString", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TaskProgressString:setText(f5_local0)
		end
	end)
	self:addElement(TaskProgressString)
	self.TaskProgressString = TaskProgressString
	local TaskProgress = LUI.UIImage.new(0, 0, 1, 444, 1, 1, -10, -6)
	TaskProgress:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	TaskProgress:setAlpha(0)
	TaskProgress:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	TaskProgress:setShaderVector(1, 0, 0, 0, 0)
	TaskProgress:setShaderVector(2, 1, 0, 0, 0)
	TaskProgress:setShaderVector(3, 0, 0, 0, 0)
	TaskProgress:setShaderVector(4, 0, 0, 0, 0)
	TaskProgress:linkToElementModel(self, "taskProgress", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			TaskProgress:setShaderVector(0, CoD.GetVectorComponentFromString(f6_local0, 1), CoD.GetVectorComponentFromString(f6_local0, 2), CoD.GetVectorComponentFromString(f6_local0, 3), CoD.GetVectorComponentFromString(f6_local0, 4))
		end
	end)
	self:addElement(TaskProgress)
	self.TaskProgress = TaskProgress
	local LevelMeterBg = LUI.UIImage.new(0, 1.12, -2, -54, 0.5, 0.5, 33.5, 51.5)
	LevelMeterBg:setImage(RegisterImage(0x61E8EB53DFEF82B))
	LevelMeterBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	LevelMeterBg:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(LevelMeterBg)
	self.LevelMeterBg = LevelMeterBg
	local CurrentXPMeter = CoD.CommonWipeMeterWithGlow.new(f1_arg0, f1_arg1, 0, 1.12, 0, -56, 0, 0, 86.5, 98.5)
	CurrentXPMeter.Meter:setRGB(1, 0.73, 0)
	CurrentXPMeter.Meter:setImage(RegisterImage(0x6D2FBF31F53910C))
	CurrentXPMeter.MeterAdd:setAlpha(0.3)
	CurrentXPMeter.MeterAdd:setImage(RegisterImage(0x6D2FBF31F53910C))
	CurrentXPMeter.MeterGlow:setRGB(0.39, 0.18, 0)
	CurrentXPMeter.MeterGlow:setImage(RegisterImage(0xA7D61A3302B55D0))
	CurrentXPMeter.MeterGlow:setShaderVector(0, 0.25, 0, 0, 0)
	CurrentXPMeter:linkToElementModel(self, "taskProgress", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			CurrentXPMeter.Meter:setShaderVector(0, CoD.GetVectorComponentFromString(f7_local0, 1), CoD.GetVectorComponentFromString(f7_local0, 2), CoD.GetVectorComponentFromString(f7_local0, 3), CoD.GetVectorComponentFromString(f7_local0, 4))
		end
	end)
	self:addElement(CurrentXPMeter)
	self.CurrentXPMeter = CurrentXPMeter
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialEventTaskWidget.__resetProperties = function(f9_arg0)
	f9_arg0.TaskName:completeAnimation()
	f9_arg0.TaskDescription:completeAnimation()
	f9_arg0.TaskName:setTopBottom(0, 0, 5, 25)
	f9_arg0.TaskDescription:setTopBottom(0, 0, 29, 44)
end
CoD.SpecialEventTaskWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.TaskName:completeAnimation()
			f11_arg0.TaskName:setTopBottom(0, 0, 12, 30)
			f11_arg0.clipFinished(f11_arg0.TaskName)
			f11_arg0.TaskDescription:completeAnimation()
			f11_arg0.TaskDescription:setTopBottom(0, 0, 39, 51)
			f11_arg0.clipFinished(f11_arg0.TaskDescription)
		end,
	},
}
CoD.SpecialEventTaskWidget.__onClose = function(f12_arg0)
	f12_arg0.IconFrame:close()
	f12_arg0.CallingIcon:close()
	f12_arg0.TaskName:close()
	f12_arg0.TaskDescription:close()
	f12_arg0.TaskProgressString:close()
	f12_arg0.TaskProgress:close()
	f12_arg0.CurrentXPMeter:close()
end
