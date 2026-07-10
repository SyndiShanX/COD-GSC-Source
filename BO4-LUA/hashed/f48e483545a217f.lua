require("x64:2dd0805105021ee")
require("x64:6ea1fd6fe7bde1a")
CoD.Prestige_WZRewardsWidget = InheritFrom(LUI.UIElement)
CoD.Prestige_WZRewardsWidget.__defaultWidth = 128
CoD.Prestige_WZRewardsWidget.__defaultHeight = 440
CoD.Prestige_WZRewardsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_WZRewardsWidget)
	self.id = "Prestige_WZRewardsWidget"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local sizeElement = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 444)
	sizeElement:setAlpha(0)
	self:addElement(sizeElement)
	self.sizeElement = sizeElement
	local RankImage = CoD.Prestige_WZReward.new(f1_arg0, f1_arg1, 0, 0, 0, 128, 0, 0, 41.5, 195.5)
	RankImage:linkToElementModel(self, "reward1", false, function(model)
		RankImage:setModel(model, f1_arg1)
	end)
	RankImage:linkToElementModel(self, "iconLarge", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RankImage.RewardImage:setImage(RegisterImage(f3_local0))
		end
	end)
	RankImage:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.PrestigeUtility.UpdateCurrentlySelectedItemInfo(self, f1_arg1, element)
		return f4_local0
	end)
	self:addElement(RankImage)
	self.RankImage = RankImage
	local infoBracketTop = LUI.UIImage.new(0, 0, -1, 129, 0, 0, 39.5, 47.5)
	infoBracketTop:setAlpha(0.2)
	infoBracketTop:setZRot(180)
	infoBracketTop:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketTop:setShaderVector(0, 0, 0, 0, 0)
	infoBracketTop:setupNineSliceShader(16, 4)
	self:addElement(infoBracketTop)
	self.infoBracketTop = infoBracketTop
	local HeaderBackground = CoD.Prestige_LevelRewardsHeader.new(f1_arg0, f1_arg1, 0, 0, 0, 128, 0, 0, 0, 37)
	HeaderBackground:linkToElementModel(self, nil, false, function(model)
		HeaderBackground:setModel(model, f1_arg1)
	end)
	self:addElement(HeaderBackground)
	self.HeaderBackground = HeaderBackground
	local RewardLevel = LUI.UIText.new(0, 0, 0, 200, 0, 0, 7, 32)
	RewardLevel:setRGB(0.92, 0.92, 0.92)
	RewardLevel:setTTF("ttmussels_demibold")
	RewardLevel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RewardLevel:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	RewardLevel:linkToElementModel(self, "displayLevel", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			RewardLevel:setText(CoD.PrestigeUtility.LocalizeIfMaxRank(0x4008CE61FE52DCD, f6_local0))
		end
	end)
	self:addElement(RewardLevel)
	self.RewardLevel = RewardLevel
	local infoBracketBot = LUI.UIImage.new(0, 0, -1, 129, 0, 0, 188.5, 196.5)
	infoBracketBot:setAlpha(0.2)
	infoBracketBot:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	self:mergeStateConditions({
		{
			stateName = "WideState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "wideLayout")
			end,
		},
	})
	self:linkToElementModel(self, "wideLayout", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "wideLayout",
		})
	end)
	RankImage.id = "RankImage"
	self.__defaultFocus = RankImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_WZRewardsWidget.__resetProperties = function(f9_arg0)
	f9_arg0.RewardLevel:completeAnimation()
	f9_arg0.HeaderBackground:completeAnimation()
	f9_arg0.sizeElement:completeAnimation()
	f9_arg0.RankImage:completeAnimation()
	f9_arg0.infoBracketBot:completeAnimation()
	f9_arg0.infoBracketTop:completeAnimation()
	f9_arg0.RewardLevel:setLeftRight(0, 0, 0, 200)
	f9_arg0.HeaderBackground:setLeftRight(0, 0, 0, 128)
	f9_arg0.sizeElement:setLeftRight(0, 0, 0, 128)
	f9_arg0.RankImage:setLeftRight(0, 0, 0, 128)
	f9_arg0.RankImage:setTopBottom(0, 0, 41.5, 195.5)
	f9_arg0.infoBracketBot:setLeftRight(0, 0, -1, 129)
	f9_arg0.infoBracketBot:setTopBottom(0, 0, 188.5, 196.5)
	f9_arg0.infoBracketTop:setLeftRight(0, 0, -1, 129)
end
CoD.Prestige_WZRewardsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.RewardLevel:completeAnimation()
			f10_arg0.RewardLevel:setLeftRight(0, 0, 0, 128)
			f10_arg0.clipFinished(f10_arg0.RewardLevel)
		end,
	},
	WideState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(6)
			f11_arg0.sizeElement:completeAnimation()
			f11_arg0.sizeElement:setLeftRight(0, 0, 0, 256)
			f11_arg0.clipFinished(f11_arg0.sizeElement)
			f11_arg0.RankImage:completeAnimation()
			f11_arg0.RankImage:setLeftRight(0, 0, 0, 256)
			f11_arg0.RankImage:setTopBottom(0, 0, 41.5, 437.5)
			f11_arg0.clipFinished(f11_arg0.RankImage)
			f11_arg0.infoBracketTop:completeAnimation()
			f11_arg0.infoBracketTop:setLeftRight(0, 0, -1, 257)
			f11_arg0.clipFinished(f11_arg0.infoBracketTop)
			f11_arg0.HeaderBackground:completeAnimation()
			f11_arg0.HeaderBackground:setLeftRight(0, 0, 0, 256)
			f11_arg0.clipFinished(f11_arg0.HeaderBackground)
			f11_arg0.RewardLevel:completeAnimation()
			f11_arg0.RewardLevel:setLeftRight(0, 0, 0, 256)
			f11_arg0.clipFinished(f11_arg0.RewardLevel)
			f11_arg0.infoBracketBot:completeAnimation()
			f11_arg0.infoBracketBot:setLeftRight(0, 0, -1, 257)
			f11_arg0.infoBracketBot:setTopBottom(0, 0, 427, 435)
			f11_arg0.clipFinished(f11_arg0.infoBracketBot)
		end,
	},
}
CoD.Prestige_WZRewardsWidget.__onClose = function(f12_arg0)
	f12_arg0.RankImage:close()
	f12_arg0.HeaderBackground:close()
	f12_arg0.RewardLevel:close()
end
