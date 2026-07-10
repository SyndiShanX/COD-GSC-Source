require("x64:4e6143dbc749ffd")
require("x64:952fac172835579")
CoD.AARSpecialEventItem = InheritFrom(LUI.UIElement)
CoD.AARSpecialEventItem.__defaultWidth = 380
CoD.AARSpecialEventItem.__defaultHeight = 200
CoD.AARSpecialEventItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARSpecialEventItem)
	self.id = "AARSpecialEventItem"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.64, 0.64, 0.64)
	Backing:setAlpha(0.04)
	self:addElement(Backing)
	self.Backing = Backing
	local MainReward = CoD.SpecialEventLargeRewardWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -83, 83, 0.5, 0.5, -72, 94)
	MainReward:mergeStateConditions({
		{
			stateName = "Unlocked",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	MainReward.FixedAspectRatioImage:setScale(1.6, 1.6)
	MainReward:linkToElementModel(self, "reward1Icon", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MainReward.FixedAspectRatioImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(MainReward)
	self.MainReward = MainReward
	local Description = LUI.UIText.new(0.5, 0.5, -184, 184, 0, 0, 182, 195)
	Description:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	Description:setAlpha(0)
	Description:setText("")
	Description:setTTF("dinnext_regular")
	Description:setLetterSpacing(1)
	Description:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local Title = LUI.UIText.new(0.5, 0.5, -182, 182, 1, 1, -194, -176)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setText("")
	Title:setTTF("dinnext_regular")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Title)
	self.Title = Title
	local Corner = CoD.AARRewardBrackets.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Corner:setAlpha(0.4)
	self:addElement(Corner)
	self.Corner = Corner
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSpecialEventItem.__onClose = function(f4_arg0)
	f4_arg0.MainReward:close()
	f4_arg0.Corner:close()
end
