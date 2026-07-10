require("x64:d6ac245bd2dba72")
require("x64:25c81f9ccc2c1cc")
require("x64:6260b1d3b17bb8a")
CoD.WZAAR_ContainerList = InheritFrom(LUI.UIElement)
CoD.WZAAR_ContainerList.__defaultWidth = 1052
CoD.WZAAR_ContainerList.__defaultHeight = 600
CoD.WZAAR_ContainerList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 80, false)
	self:setAlignment(LUI.Alignment.Center)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.warzone.wzAAr.characterEarned", false)
	CoD.BaseUtility.InitControllerModelIfNotSet(f1_arg1, "hudItems.warzone.wzAAr.challengeProgEarned", false)
	self:setClass(CoD.WZAAR_ContainerList)
	self.id = "WZAAR_ContainerList"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Merit = CoD.WZAAR_MeritContainer.new(f1_arg0, f1_arg1, 0, 0, -364, 176, 0, 0, 0, 622)
	Merit:subscribeToGlobalModel(f1_arg1, "AARMeritReport", nil, function(model)
		Merit:setModel(model, f1_arg1)
	end)
	self:addElement(Merit)
	self.Merit = Merit
	local CharacterRewards = CoD.WZAAR_CharacterContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -270, 270, 0, 0, 0, 622)
	self:addElement(CharacterRewards)
	self.CharacterRewards = CharacterRewards
	local Challenges = CoD.WZAAR_ChallengeContainer.new(f1_arg0, f1_arg1, 0, 0, 876, 1416, 0, 0, 0, 622)
	self:addElement(Challenges)
	self.Challenges = Challenges
	CharacterRewards.id = "CharacterRewards"
	Challenges.id = "Challenges"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZAAR_ContainerList.__onClose = function(f3_arg0)
	f3_arg0.Merit:close()
	f3_arg0.CharacterRewards:close()
	f3_arg0.Challenges:close()
end
