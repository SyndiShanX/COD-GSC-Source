require("x64:35152a333fa2552")
require("x64:6a82231f482914f")
CoD.AmmoWidget_SpecialistEscalation = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_SpecialistEscalation.__defaultWidth = 278
CoD.AmmoWidget_SpecialistEscalation.__defaultHeight = 112
CoD.AmmoWidget_SpecialistEscalation.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_SpecialistEscalation)
	self.id = "AmmoWidget_SpecialistEscalation"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CharacterPortraitBacking = CoD.AmmoWidget_CharacterPortraitBacking.new(f1_arg0, f1_arg1, 0, 0, 22, 322, 0, 0, 21, 90)
	CharacterPortraitBacking:setAlpha(0)
	CharacterPortraitBacking:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CharacterPortraitBacking:setModel(f2_local0, f1_arg1)
		end
	end)
	self:addElement(CharacterPortraitBacking)
	self.CharacterPortraitBacking = CharacterPortraitBacking
	local CharacterPortrait = CoD.AmmoWidget_CharacterPortrait.new(f1_arg0, f1_arg1, 0, 0, -26.5, 49.5, 0, 0, -9.5, 45.5)
	CharacterPortrait:setAlpha(0)
	CharacterPortrait:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CharacterPortrait:setModel(f3_local0, f1_arg1)
		end
	end)
	self:addElement(CharacterPortrait)
	self.CharacterPortrait = CharacterPortrait
	local CharacterPortrait3 = CoD.AmmoWidget_CharacterPortrait.new(f1_arg0, f1_arg1, 0, 0, 0, 76, 0, 0, 23, 78)
	CharacterPortrait3:setAlpha(0.02)
	CharacterPortrait3:setScale(1.14, 1.14)
	CharacterPortrait3:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CharacterPortrait3:setModel(f4_local0, f1_arg1)
		end
	end)
	self:addElement(CharacterPortrait3)
	self.CharacterPortrait3 = CharacterPortrait3
	local CharacterPortrait2 = CoD.AmmoWidget_CharacterPortrait.new(f1_arg0, f1_arg1, 0, 0, 3, 79, 0, 0, 24, 79)
	CharacterPortrait2:setScale(1.14, 1.14)
	CharacterPortrait2:subscribeToGlobalModel(f1_arg1, "PerController", "predictedClientModel", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CharacterPortrait2:setModel(f5_local0, f1_arg1)
		end
	end)
	self:addElement(CharacterPortrait2)
	self.CharacterPortrait2 = CharacterPortrait2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_SpecialistEscalation.__resetProperties = function(f6_arg0)
	f6_arg0.CharacterPortraitBacking:completeAnimation()
	f6_arg0.CharacterPortraitBacking:setAlpha(0)
end
CoD.AmmoWidget_SpecialistEscalation.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.CharacterPortraitBacking:completeAnimation()
			f7_arg0.CharacterPortraitBacking:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.CharacterPortraitBacking)
		end,
	},
}
CoD.AmmoWidget_SpecialistEscalation.__onClose = function(f8_arg0)
	f8_arg0.CharacterPortraitBacking:close()
	f8_arg0.CharacterPortrait:close()
	f8_arg0.CharacterPortrait3:close()
	f8_arg0.CharacterPortrait2:close()
end
