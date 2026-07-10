CoD.SpecialistDossierInternalBioText = InheritFrom(LUI.UIElement)
CoD.SpecialistDossierInternalBioText.__defaultWidth = 510
CoD.SpecialistDossierInternalBioText.__defaultHeight = 130
CoD.SpecialistDossierInternalBioText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SpecialistDossierInternalBioText)
	self.id = "SpecialistDossierInternalBioText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local InfoBacking = LUI.UIImage.new(0, 0, 0, 510, 0, 0, 0, 130)
	InfoBacking:setRGB(0, 0, 0)
	InfoBacking:setAlpha(0.25)
	self:addElement(InfoBacking)
	self.InfoBacking = InfoBacking
	local Header1 = LUI.UIText.new(0, 0, 5, 205, 0, 0, 5, 29)
	Header1:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header1:setText(LocalizeToUpperString(0xDF851E1720F9418))
	Header1:setTTF("ttmussels_regular")
	Header1:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Header1)
	self.Header1 = Header1
	local Header2 = LUI.UIText.new(0, 0, 5, 205, 0, 0, 35, 59)
	Header2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header2:setText(LocalizeToUpperString(0x32D390E3FF28B53))
	Header2:setTTF("ttmussels_regular")
	Header2:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Header2)
	self.Header2 = Header2
	local Header3 = LUI.UIText.new(0, 0, 5, 205, 0, 0, 65, 89)
	Header3:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header3:setText(LocalizeToUpperString(0x6260D937C768747))
	Header3:setTTF("ttmussels_regular")
	Header3:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Header3)
	self.Header3 = Header3
	local Header4 = LUI.UIText.new(0, 0, 5, 205, 0, 0, 95, 119)
	Header4:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Header4:setText(LocalizeToUpperString(0x64518911D9EFCCA))
	Header4:setTTF("ttmussels_regular")
	Header4:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Header4)
	self.Header4 = Header4
	local Name = LUI.UIText.new(0, 0, 205, 505, 0, 0, 5, 29)
	Name:setRGB(0.92, 0.89, 0.72)
	Name:setTTF("ttmussels_regular")
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "name", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Name:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local DOB = LUI.UIText.new(0, 0, 205, 505, 0, 0, 35, 59)
	DOB:setRGB(0.92, 0.89, 0.72)
	DOB:setTTF("ttmussels_regular")
	DOB:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DOB:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "DOB", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			DOB:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(DOB)
	self.DOB = DOB
	local Nationality = LUI.UIText.new(0, 0, 205, 505, 0, 0, 65, 89)
	Nationality:setRGB(0.92, 0.89, 0.72)
	Nationality:setTTF("ttmussels_regular")
	Nationality:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Nationality:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "nationality", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Nationality:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(Nationality)
	self.Nationality = Nationality
	local Designation = LUI.UIText.new(0, 0, 205, 505, 0, 0, 95, 119)
	Designation:setRGB(0.92, 0.89, 0.72)
	Designation:setTTF("ttmussels_regular")
	Designation:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Designation:subscribeToGlobalModel(f1_arg1, "SpecialistDossier", "designation", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Designation:setText(Engine[0xF9F1239CFD921FE](f5_local0))
		end
	end)
	self:addElement(Designation)
	self.Designation = Designation
	self:mergeStateConditions({
		{
			stateName = "Arabic",
			condition = function(menu, element, event)
				return IsCurrentLanguageArabic()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SpecialistDossierInternalBioText.__resetProperties = function(f7_arg0)
	f7_arg0.Header1:completeAnimation()
	f7_arg0.Name:completeAnimation()
	f7_arg0.Header2:completeAnimation()
	f7_arg0.DOB:completeAnimation()
	f7_arg0.Header3:completeAnimation()
	f7_arg0.Nationality:completeAnimation()
	f7_arg0.Header4:completeAnimation()
	f7_arg0.Designation:completeAnimation()
	f7_arg0.InfoBacking:completeAnimation()
	f7_arg0.Header1:setLeftRight(0, 0, 5, 205)
	f7_arg0.Name:setLeftRight(0, 0, 205, 505)
	f7_arg0.Header2:setLeftRight(0, 0, 5, 205)
	f7_arg0.DOB:setLeftRight(0, 0, 205, 505)
	f7_arg0.Header3:setLeftRight(0, 0, 5, 205)
	f7_arg0.Nationality:setLeftRight(0, 0, 205, 505)
	f7_arg0.Header4:setLeftRight(0, 0, 5, 205)
	f7_arg0.Designation:setLeftRight(0, 0, 205, 505)
	f7_arg0.InfoBacking:setLeftRight(0, 0, 0, 510)
end
CoD.SpecialistDossierInternalBioText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Arabic = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(9)
			f9_arg0.InfoBacking:completeAnimation()
			f9_arg0.InfoBacking:setLeftRight(0.5, 0.5, -255, 255)
			f9_arg0.clipFinished(f9_arg0.InfoBacking)
			f9_arg0.Header1:completeAnimation()
			f9_arg0.Header1:setLeftRight(0.5, 0.5, -50, 150)
			f9_arg0.clipFinished(f9_arg0.Header1)
			f9_arg0.Header2:completeAnimation()
			f9_arg0.Header2:setLeftRight(0.5, 0.5, -50, 150)
			f9_arg0.clipFinished(f9_arg0.Header2)
			f9_arg0.Header3:completeAnimation()
			f9_arg0.Header3:setLeftRight(0.5, 0.5, -50, 150)
			f9_arg0.clipFinished(f9_arg0.Header3)
			f9_arg0.Header4:completeAnimation()
			f9_arg0.Header4:setLeftRight(0.5, 0.5, -50, 150)
			f9_arg0.clipFinished(f9_arg0.Header4)
			f9_arg0.Name:completeAnimation()
			f9_arg0.Name:setLeftRight(0.5, 0.5, -250, 50)
			f9_arg0.clipFinished(f9_arg0.Name)
			f9_arg0.DOB:completeAnimation()
			f9_arg0.DOB:setLeftRight(0.5, 0.5, -250, 50)
			f9_arg0.clipFinished(f9_arg0.DOB)
			f9_arg0.Nationality:completeAnimation()
			f9_arg0.Nationality:setLeftRight(0.5, 0.5, -250, 50)
			f9_arg0.clipFinished(f9_arg0.Nationality)
			f9_arg0.Designation:completeAnimation()
			f9_arg0.Designation:setLeftRight(0.5, 0.5, -250, 50)
			f9_arg0.clipFinished(f9_arg0.Designation)
		end,
	},
}
CoD.SpecialistDossierInternalBioText.__onClose = function(f10_arg0)
	f10_arg0.Name:close()
	f10_arg0.DOB:close()
	f10_arg0.Nationality:close()
	f10_arg0.Designation:close()
end
