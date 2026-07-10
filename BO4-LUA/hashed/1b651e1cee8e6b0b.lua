require("x64:5415c2f3330b8c9")
require("x64:ac69244ae6dc9a")
CoD.WZ_AARCharacterContainerInternal = InheritFrom(LUI.UIElement)
CoD.WZ_AARCharacterContainerInternal.__defaultWidth = 540
CoD.WZ_AARCharacterContainerInternal.__defaultHeight = 628
CoD.WZ_AARCharacterContainerInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZ_AARCharacterContainerInternal)
	self.id = "WZ_AARCharacterContainerInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local IGRbg = CoD.WZAAR_IGR_background.new(f1_arg0, f1_arg1, 0, 0, 0, 540, 0, 0, 0, 628)
	self:addElement(IGRbg)
	self.IGRbg = IGRbg
	local CharacterUnlocks = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	CharacterUnlocks:setLeftRight(0.5, 0.5, -212.5, 212.5)
	CharacterUnlocks:setTopBottom(0, 0, 77, 562)
	CharacterUnlocks:setWidgetType(CoD.WZAAR_UnlockedCharacter)
	CharacterUnlocks:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	CharacterUnlocks:setDataSource("CharacterUnlock")
	CharacterUnlocks:subscribeToGlobalModel(f1_arg1, "PerController", "gameScore.currentState", function(model)
		local f2_local0 = CharacterUnlocks
		if IsInGame() then
			CoD.GridAndListUtility.UpdateDataSource(f2_local0, false, true, true)
		end
	end)
	self:addElement(CharacterUnlocks)
	self.CharacterUnlocks = CharacterUnlocks
	local Title = LUI.UIText.new(0.5, 0.5, -248, 248, 0, 0, 19, 51)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"aar/rewards"))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Title)
	self.Title = Title
	CharacterUnlocks.id = "CharacterUnlocks"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZ_AARCharacterContainerInternal.__onClose = function(f3_arg0)
	f3_arg0.IGRbg:close()
	f3_arg0.CharacterUnlocks:close()
end
