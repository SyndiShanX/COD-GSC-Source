require("x64:2dd0805105021ee")
require("x64:2c66d084109a1d3")
require("x64:20b2bc5d6da439f")
require("x64:19c1945d2e472b0")
CoD.Prestige_LevelRewardsWidget = InheritFrom(LUI.UIElement)
CoD.Prestige_LevelRewardsWidget.__defaultWidth = 128
CoD.Prestige_LevelRewardsWidget.__defaultHeight = 440
CoD.Prestige_LevelRewardsWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Prestige_LevelRewardsWidget)
	self.id = "Prestige_LevelRewardsWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local sizeElement = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 0, 506)
	sizeElement:setAlpha(0)
	self:addElement(sizeElement)
	self.sizeElement = sizeElement
	local BodyBg = CoD.Prestige_LevelRewardsBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 128, 0, 0, 40.5, 506.5)
	BodyBg:linkToElementModel(self, nil, false, function(model)
		BodyBg:setModel(model, f1_arg1)
	end)
	self:addElement(BodyBg)
	self.BodyBg = BodyBg
	local GridBodyBg = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 199, 506)
	GridBodyBg:setAlpha(0.02)
	GridBodyBg:setImage(RegisterImage(@"uie_ui_hud_vehicle_lightstrike_grid"))
	GridBodyBg:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridBodyBg:setShaderVector(0, 0, 0, 0, 0)
	GridBodyBg:setupNineSliceShader(22, 22)
	self:addElement(GridBodyBg)
	self.GridBodyBg = GridBodyBg
	local BodyBgAdd = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 41, 506)
	BodyBgAdd:setRGB(0.92, 0.92, 0.92)
	BodyBgAdd:setAlpha(0)
	self:addElement(BodyBgAdd)
	self.BodyBgAdd = BodyBgAdd
	local RankBg = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 40.5, 195.5)
	RankBg:setRGB(0.14, 0.14, 0.14)
	RankBg:setAlpha(0.9)
	self:addElement(RankBg)
	self.RankBg = RankBg
	local DotTiledRankBg = CoD.StoreCommonTextBacking.new(f1_arg0, f1_arg1, 0, 0, 0, 128, 0, 0, 40.5, 195.5)
	DotTiledRankBg:setAlpha(0.2)
	self:addElement(DotTiledRankBg)
	self.DotTiledRankBg = DotTiledRankBg
	local HeaderBackground = CoD.Prestige_LevelRewardsHeader.new(f1_arg0, f1_arg1, 0, 0, 0, 128, 0, 0, 0, 37)
	HeaderBackground:setAlpha(0.95)
	HeaderBackground:linkToElementModel(self, nil, false, function(model)
		HeaderBackground:setModel(model, f1_arg1)
	end)
	self:addElement(HeaderBackground)
	self.HeaderBackground = HeaderBackground
	local RewardLevel = LUI.UIText.new(0.5, 0.5, -64, 136, 0, 0, 7, 32)
	RewardLevel:setRGB(0.92, 0.92, 0.92)
	RewardLevel:setTTF("ttmussels_demibold")
	RewardLevel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RewardLevel:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	RewardLevel:linkToElementModel(self, "displayLevel", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			RewardLevel:setText(f4_local0)
		end
	end)
	self:addElement(RewardLevel)
	self.RewardLevel = RewardLevel
	local LevelIcon = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 54, 182)
	LevelIcon:linkToElementModel(self, "iconLarge", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			LevelIcon:setImage(RegisterImage(f5_local0))
		end
	end)
	self:addElement(LevelIcon)
	self.LevelIcon = LevelIcon
	local RewardImage = CoD.Prestige_RewardWidget.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 198.5, 352.5)
	RewardImage:linkToElementModel(self, "reward1", false, function(model)
		RewardImage:setModel(model, f1_arg1)
	end)
	RewardImage:registerEventHandler("gain_focus", function(element, event)
		local f7_local0 = nil
		if element.gainFocus then
			f7_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f7_local0 = element.super:gainFocus(event)
		end
		CoD.PrestigeUtility.UpdateCurrentlySelectedItemInfo(self, f1_arg1, element)
		return f7_local0
	end)
	self:addElement(RewardImage)
	self.RewardImage = RewardImage
	local RewardImage2 = CoD.Prestige_RewardWidget.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 352.5, 506.5)
	RewardImage2:linkToElementModel(self, "reward2", false, function(model)
		RewardImage2:setModel(model, f1_arg1)
	end)
	RewardImage2:registerEventHandler("gain_focus", function(element, event)
		local f9_local0 = nil
		if element.gainFocus then
			f9_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f9_local0 = element.super:gainFocus(event)
		end
		CoD.PrestigeUtility.UpdateCurrentlySelectedItemInfo(self, f1_arg1, element)
		return f9_local0
	end)
	self:addElement(RewardImage2)
	self.RewardImage2 = RewardImage2
	local RewardImage3 = CoD.Prestige_RewardWidget.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 506, 660)
	RewardImage3:linkToElementModel(self, "reward3", false, function(model)
		RewardImage3:setModel(model, f1_arg1)
	end)
	RewardImage3:registerEventHandler("gain_focus", function(element, event)
		local f11_local0 = nil
		if element.gainFocus then
			f11_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f11_local0 = element.super:gainFocus(event)
		end
		CoD.PrestigeUtility.UpdateCurrentlySelectedItemInfo(self, f1_arg1, element)
		return f11_local0
	end)
	self:addElement(RewardImage3)
	self.RewardImage3 = RewardImage3
	local Divider = LUI.UIImage.new(0, 0, 0, 128, 0, 0, 195.5, 198.5)
	Divider:setRGB(0.1, 0.1, 0.1)
	self:addElement(Divider)
	self.Divider = Divider
	local infoBracketBot = LUI.UIImage.new(0, 0, -1, 129, 0, 0, 498.5, 506.5)
	infoBracketBot:setAlpha(0.2)
	infoBracketBot:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local infoBracketTop = LUI.UIImage.new(0, 0, -1, 129, 0, 0, 39.5, 47.5)
	infoBracketTop:setAlpha(0.2)
	infoBracketTop:setZRot(180)
	infoBracketTop:setImage(RegisterImage(@"hash_4C325BED3F226657"))
	infoBracketTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	infoBracketTop:setShaderVector(0, 0, 0, 0, 0)
	infoBracketTop:setupNineSliceShader(16, 4)
	self:addElement(infoBracketTop)
	self.infoBracketTop = infoBracketTop
	self:mergeStateConditions({
		{
			stateName = "WideState",
			condition = function(menu, element, event)
				local f12_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "wideLayout")
				if f12_local0 then
					if not IsMaxPrestigeLevel(f1_arg1) then
						f12_local0 = IsPrestigeLevelAtZero(f1_arg1)
					else
						f12_local0 = false
					end
				end
				return f12_local0
			end,
		},
		{
			stateName = "DefaultStateMasterPrestige",
			condition = function(menu, element, event)
				local f13_local0 = IsMaxPrestigeLevel(f1_arg1)
				if f13_local0 then
					if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "wideLayout") then
						f13_local0 = not IsWarzone()
					else
						f13_local0 = false
					end
				end
				return f13_local0
			end,
		},
		{
			stateName = "WideStateMasterPrestige",
			condition = function(menu, element, event)
				local f14_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "wideLayout")
				if f14_local0 then
					f14_local0 = IsMaxPrestigeLevel(f1_arg1)
					if f14_local0 then
						f14_local0 = not IsWarzone()
					end
				end
				return f14_local0
			end,
		},
		{
			stateName = "DefaultStatePrestige",
			condition = function(menu, element, event)
				local f15_local0
				if not IsMaxPrestigeLevel(f1_arg1) and not IsPrestigeLevelAtZero(f1_arg1) and not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "wideLayout") then
					f15_local0 = not IsWarzone()
				else
					f15_local0 = false
				end
				return f15_local0
			end,
		},
		{
			stateName = "WideStatePrestige",
			condition = function(menu, element, event)
				local f16_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "wideLayout")
				if f16_local0 then
					if not IsMaxPrestigeLevel(f1_arg1) and not IsPrestigeLevelAtZero(f1_arg1) then
						f16_local0 = not IsWarzone()
					else
						f16_local0 = false
					end
				end
				return f16_local0
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
	local f1_local16 = self
	local f1_local17 = self.subscribeToModel
	local f1_local18 = Engine[@"getglobalmodel"]()
	f1_local17(f1_local16, f1_local18["lobbyRoot.lobbyNav"], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	RewardImage.id = "RewardImage"
	RewardImage2.id = "RewardImage2"
	RewardImage3.id = "RewardImage3"
	self.__defaultFocus = RewardImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Prestige_LevelRewardsWidget.__resetProperties = function(f19_arg0)
	f19_arg0.RewardLevel:completeAnimation()
	f19_arg0.GridBodyBg:completeAnimation()
	f19_arg0.DotTiledRankBg:completeAnimation()
	f19_arg0.infoBracketBot:completeAnimation()
	f19_arg0.infoBracketTop:completeAnimation()
	f19_arg0.BodyBgAdd:completeAnimation()
	f19_arg0.sizeElement:completeAnimation()
	f19_arg0.LevelIcon:completeAnimation()
	f19_arg0.RewardImage2:completeAnimation()
	f19_arg0.RewardImage3:completeAnimation()
	f19_arg0.RewardImage:completeAnimation()
	f19_arg0.HeaderBackground:completeAnimation()
	f19_arg0.Divider:completeAnimation()
	f19_arg0.RankBg:completeAnimation()
	f19_arg0.BodyBg:completeAnimation()
	f19_arg0.RewardLevel:setLeftRight(0.5, 0.5, -64, 136)
	f19_arg0.GridBodyBg:setLeftRight(0, 0, 0, 128)
	f19_arg0.GridBodyBg:setTopBottom(0, 0, 199, 506)
	f19_arg0.GridBodyBg:setAlpha(0.02)
	f19_arg0.DotTiledRankBg:setLeftRight(0, 0, 0, 128)
	f19_arg0.DotTiledRankBg:setAlpha(0.2)
	f19_arg0.infoBracketBot:setLeftRight(0, 0, -1, 129)
	f19_arg0.infoBracketBot:setAlpha(0.2)
	f19_arg0.infoBracketTop:setLeftRight(0, 0, -1, 129)
	f19_arg0.infoBracketTop:setAlpha(0.2)
	f19_arg0.BodyBgAdd:setLeftRight(0, 0, 0, 128)
	f19_arg0.BodyBgAdd:setAlpha(0)
	f19_arg0.sizeElement:setLeftRight(0, 0, 0, 128)
	f19_arg0.LevelIcon:setLeftRight(0, 0, 0, 128)
	f19_arg0.LevelIcon:setAlpha(1)
	f19_arg0.RewardImage2:setTopBottom(0, 0, 352.5, 506.5)
	f19_arg0.RewardImage3:setTopBottom(0, 0, 506, 660)
	f19_arg0.RewardImage:setTopBottom(0, 0, 198.5, 352.5)
	f19_arg0.HeaderBackground:setLeftRight(0, 0, 0, 128)
	f19_arg0.Divider:setLeftRight(0, 0, 0, 128)
	f19_arg0.Divider:setAlpha(1)
	f19_arg0.RankBg:setLeftRight(0, 0, 0, 128)
	f19_arg0.RankBg:setAlpha(0.9)
	f19_arg0.BodyBg:setLeftRight(0, 0, 0, 128)
end
CoD.Prestige_LevelRewardsWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.RewardLevel:completeAnimation()
			f20_arg0.RewardLevel:setLeftRight(0.5, 0.5, -64, 64)
			f20_arg0.clipFinished(f20_arg0.RewardLevel)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(6)
			f21_arg0.GridBodyBg:completeAnimation()
			f21_arg0.GridBodyBg:setAlpha(0.04)
			f21_arg0.clipFinished(f21_arg0.GridBodyBg)
			f21_arg0.BodyBgAdd:completeAnimation()
			f21_arg0.BodyBgAdd:setAlpha(0.05)
			f21_arg0.clipFinished(f21_arg0.BodyBgAdd)
			f21_arg0.DotTiledRankBg:completeAnimation()
			f21_arg0.DotTiledRankBg:setAlpha(0.8)
			f21_arg0.clipFinished(f21_arg0.DotTiledRankBg)
			f21_arg0.RewardLevel:completeAnimation()
			f21_arg0.RewardLevel:setLeftRight(0.5, 0.5, -64, 64)
			f21_arg0.clipFinished(f21_arg0.RewardLevel)
			f21_arg0.infoBracketBot:completeAnimation()
			f21_arg0.infoBracketBot:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.infoBracketBot)
			f21_arg0.infoBracketTop:completeAnimation()
			f21_arg0.infoBracketTop:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.infoBracketTop)
		end,
	},
	WideState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(15)
			f22_arg0.sizeElement:completeAnimation()
			f22_arg0.sizeElement:setLeftRight(0, 0, 0, 256)
			f22_arg0.clipFinished(f22_arg0.sizeElement)
			f22_arg0.BodyBg:completeAnimation()
			f22_arg0.BodyBg:setLeftRight(0, 0, 0, 256)
			f22_arg0.clipFinished(f22_arg0.BodyBg)
			f22_arg0.GridBodyBg:completeAnimation()
			f22_arg0.GridBodyBg:setLeftRight(0, 0, 0, 256)
			f22_arg0.clipFinished(f22_arg0.GridBodyBg)
			f22_arg0.BodyBgAdd:completeAnimation()
			f22_arg0.BodyBgAdd:setLeftRight(0, 0, 0, 256)
			f22_arg0.clipFinished(f22_arg0.BodyBgAdd)
			f22_arg0.RankBg:completeAnimation()
			f22_arg0.RankBg:setLeftRight(0, 0, 0, 256)
			f22_arg0.clipFinished(f22_arg0.RankBg)
			f22_arg0.DotTiledRankBg:completeAnimation()
			f22_arg0.DotTiledRankBg:setLeftRight(0, 0, 0, 256)
			f22_arg0.clipFinished(f22_arg0.DotTiledRankBg)
			f22_arg0.HeaderBackground:completeAnimation()
			f22_arg0.HeaderBackground:setLeftRight(0, 0, 0, 256)
			f22_arg0.clipFinished(f22_arg0.HeaderBackground)
			f22_arg0.RewardLevel:completeAnimation()
			f22_arg0.RewardLevel:setLeftRight(0, 0, 0, 256)
			f22_arg0.clipFinished(f22_arg0.RewardLevel)
			f22_arg0.LevelIcon:completeAnimation()
			f22_arg0.LevelIcon:setLeftRight(0, 0, 64, 192)
			f22_arg0.clipFinished(f22_arg0.LevelIcon)
			f22_arg0.RewardImage:completeAnimation()
			f22_arg0.RewardImage:setTopBottom(0, 0, 198.5, 273.5)
			f22_arg0.clipFinished(f22_arg0.RewardImage)
			f22_arg0.RewardImage2:completeAnimation()
			f22_arg0.RewardImage2:setTopBottom(0, 0, 273.5, 348.5)
			f22_arg0.clipFinished(f22_arg0.RewardImage2)
			f22_arg0.RewardImage3:completeAnimation()
			f22_arg0.RewardImage3:setTopBottom(0, 0, 348.5, 423.5)
			f22_arg0.clipFinished(f22_arg0.RewardImage3)
			f22_arg0.Divider:completeAnimation()
			f22_arg0.Divider:setLeftRight(0, 0, 0, 256)
			f22_arg0.clipFinished(f22_arg0.Divider)
			f22_arg0.infoBracketBot:completeAnimation()
			f22_arg0.infoBracketBot:setLeftRight(0, 0, -1.5, 256.5)
			f22_arg0.clipFinished(f22_arg0.infoBracketBot)
			f22_arg0.infoBracketTop:completeAnimation()
			f22_arg0.infoBracketTop:setLeftRight(0, 0, -1.5, 256.5)
			f22_arg0.clipFinished(f22_arg0.infoBracketTop)
		end,
		ChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(15)
			f23_arg0.sizeElement:completeAnimation()
			f23_arg0.sizeElement:setLeftRight(0, 0, 0, 256)
			f23_arg0.clipFinished(f23_arg0.sizeElement)
			f23_arg0.BodyBg:completeAnimation()
			f23_arg0.BodyBg:setLeftRight(0, 0, 0, 256)
			f23_arg0.clipFinished(f23_arg0.BodyBg)
			f23_arg0.GridBodyBg:completeAnimation()
			f23_arg0.GridBodyBg:setLeftRight(0, 0, 0, 256)
			f23_arg0.clipFinished(f23_arg0.GridBodyBg)
			f23_arg0.BodyBgAdd:completeAnimation()
			f23_arg0.BodyBgAdd:setLeftRight(0, 0, 0, 256)
			f23_arg0.BodyBgAdd:setAlpha(0.05)
			f23_arg0.clipFinished(f23_arg0.BodyBgAdd)
			f23_arg0.RankBg:completeAnimation()
			f23_arg0.RankBg:setLeftRight(0, 0, 0, 256)
			f23_arg0.clipFinished(f23_arg0.RankBg)
			f23_arg0.DotTiledRankBg:completeAnimation()
			f23_arg0.DotTiledRankBg:setLeftRight(0, 0, 0, 256)
			f23_arg0.clipFinished(f23_arg0.DotTiledRankBg)
			f23_arg0.HeaderBackground:completeAnimation()
			f23_arg0.HeaderBackground:setLeftRight(0, 0, 0, 256)
			f23_arg0.clipFinished(f23_arg0.HeaderBackground)
			f23_arg0.RewardLevel:completeAnimation()
			f23_arg0.RewardLevel:setLeftRight(0, 0, 0, 256)
			f23_arg0.clipFinished(f23_arg0.RewardLevel)
			f23_arg0.LevelIcon:completeAnimation()
			f23_arg0.LevelIcon:setLeftRight(0, 0, 64, 192)
			f23_arg0.clipFinished(f23_arg0.LevelIcon)
			f23_arg0.RewardImage:completeAnimation()
			f23_arg0.RewardImage:setTopBottom(0, 0, 198.5, 273.5)
			f23_arg0.clipFinished(f23_arg0.RewardImage)
			f23_arg0.RewardImage2:completeAnimation()
			f23_arg0.RewardImage2:setTopBottom(0, 0, 273.5, 348.5)
			f23_arg0.clipFinished(f23_arg0.RewardImage2)
			f23_arg0.RewardImage3:completeAnimation()
			f23_arg0.RewardImage3:setTopBottom(0, 0, 348.5, 423.5)
			f23_arg0.clipFinished(f23_arg0.RewardImage3)
			f23_arg0.Divider:completeAnimation()
			f23_arg0.Divider:setLeftRight(0, 0, 0, 256)
			f23_arg0.clipFinished(f23_arg0.Divider)
			f23_arg0.infoBracketBot:completeAnimation()
			f23_arg0.infoBracketBot:setLeftRight(0, 0, -1.5, 256.5)
			f23_arg0.clipFinished(f23_arg0.infoBracketBot)
			f23_arg0.infoBracketTop:completeAnimation()
			f23_arg0.infoBracketTop:setLeftRight(0, 0, -1.5, 256.5)
			f23_arg0.clipFinished(f23_arg0.infoBracketTop)
		end,
	},
	DefaultStateMasterPrestige = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(9)
			f24_arg0.GridBodyBg:completeAnimation()
			f24_arg0.GridBodyBg:setTopBottom(0, 0, 40, 506)
			f24_arg0.clipFinished(f24_arg0.GridBodyBg)
			f24_arg0.RankBg:completeAnimation()
			f24_arg0.RankBg:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.RankBg)
			f24_arg0.DotTiledRankBg:completeAnimation()
			f24_arg0.DotTiledRankBg:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DotTiledRankBg)
			f24_arg0.RewardLevel:completeAnimation()
			f24_arg0.RewardLevel:setLeftRight(0.5, 0.5, -64, 64)
			f24_arg0.clipFinished(f24_arg0.RewardLevel)
			f24_arg0.LevelIcon:completeAnimation()
			f24_arg0.LevelIcon:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.LevelIcon)
			f24_arg0.RewardImage:completeAnimation()
			f24_arg0.RewardImage:setTopBottom(0, 0, 40.5, 194.5)
			f24_arg0.clipFinished(f24_arg0.RewardImage)
			f24_arg0.RewardImage2:completeAnimation()
			f24_arg0.RewardImage2:setTopBottom(0, 0, 194.5, 348.5)
			f24_arg0.clipFinished(f24_arg0.RewardImage2)
			f24_arg0.RewardImage3:completeAnimation()
			f24_arg0.RewardImage3:setTopBottom(0, 0, 348.5, 502.5)
			f24_arg0.clipFinished(f24_arg0.RewardImage3)
			f24_arg0.Divider:completeAnimation()
			f24_arg0.Divider:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Divider)
		end,
	},
	WideStateMasterPrestige = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(15)
			f25_arg0.sizeElement:completeAnimation()
			f25_arg0.sizeElement:setLeftRight(0, 0, 0, 256)
			f25_arg0.clipFinished(f25_arg0.sizeElement)
			f25_arg0.BodyBg:completeAnimation()
			f25_arg0.BodyBg:setLeftRight(0, 0, 0, 256)
			f25_arg0.clipFinished(f25_arg0.BodyBg)
			f25_arg0.GridBodyBg:completeAnimation()
			f25_arg0.GridBodyBg:setLeftRight(0, 0, 0, 256)
			f25_arg0.GridBodyBg:setTopBottom(0, 0, 41, 506)
			f25_arg0.clipFinished(f25_arg0.GridBodyBg)
			f25_arg0.BodyBgAdd:completeAnimation()
			f25_arg0.BodyBgAdd:setLeftRight(0, 0, 0, 256)
			f25_arg0.clipFinished(f25_arg0.BodyBgAdd)
			f25_arg0.RankBg:completeAnimation()
			f25_arg0.RankBg:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.RankBg)
			f25_arg0.DotTiledRankBg:completeAnimation()
			f25_arg0.DotTiledRankBg:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.DotTiledRankBg)
			f25_arg0.HeaderBackground:completeAnimation()
			f25_arg0.HeaderBackground:setLeftRight(0, 0, 0, 256)
			f25_arg0.clipFinished(f25_arg0.HeaderBackground)
			f25_arg0.RewardLevel:completeAnimation()
			f25_arg0.RewardLevel:setLeftRight(0, 0, 0, 256)
			f25_arg0.clipFinished(f25_arg0.RewardLevel)
			f25_arg0.LevelIcon:completeAnimation()
			f25_arg0.LevelIcon:setLeftRight(0, 0, 64, 192)
			f25_arg0.LevelIcon:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.LevelIcon)
			f25_arg0.RewardImage:completeAnimation()
			f25_arg0.RewardImage:setTopBottom(0, 0, 57, 132)
			f25_arg0.clipFinished(f25_arg0.RewardImage)
			f25_arg0.RewardImage2:completeAnimation()
			f25_arg0.RewardImage2:setTopBottom(0, 0, 132, 207)
			f25_arg0.clipFinished(f25_arg0.RewardImage2)
			f25_arg0.RewardImage3:completeAnimation()
			f25_arg0.RewardImage3:setTopBottom(0, 0, 207, 282)
			f25_arg0.clipFinished(f25_arg0.RewardImage3)
			f25_arg0.Divider:completeAnimation()
			f25_arg0.Divider:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.Divider)
			f25_arg0.infoBracketBot:completeAnimation()
			f25_arg0.infoBracketBot:setLeftRight(0, 0, -1, 258)
			f25_arg0.clipFinished(f25_arg0.infoBracketBot)
			f25_arg0.infoBracketTop:completeAnimation()
			f25_arg0.infoBracketTop:setLeftRight(0, 0, -1, 258)
			f25_arg0.clipFinished(f25_arg0.infoBracketTop)
		end,
	},
	DefaultStatePrestige = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(9)
			f26_arg0.GridBodyBg:completeAnimation()
			f26_arg0.GridBodyBg:setTopBottom(0, 0, 40, 506)
			f26_arg0.clipFinished(f26_arg0.GridBodyBg)
			f26_arg0.RankBg:completeAnimation()
			f26_arg0.RankBg:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.RankBg)
			f26_arg0.DotTiledRankBg:completeAnimation()
			f26_arg0.DotTiledRankBg:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.DotTiledRankBg)
			f26_arg0.RewardLevel:completeAnimation()
			f26_arg0.RewardLevel:setLeftRight(0.5, 0.5, -64, 64)
			f26_arg0.clipFinished(f26_arg0.RewardLevel)
			f26_arg0.LevelIcon:completeAnimation()
			f26_arg0.LevelIcon:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.LevelIcon)
			f26_arg0.RewardImage:completeAnimation()
			f26_arg0.RewardImage:setTopBottom(0, 0, 52.5, 206.5)
			f26_arg0.clipFinished(f26_arg0.RewardImage)
			f26_arg0.RewardImage2:completeAnimation()
			f26_arg0.RewardImage2:setTopBottom(0, 0, 206.5, 360.5)
			f26_arg0.clipFinished(f26_arg0.RewardImage2)
			f26_arg0.RewardImage3:completeAnimation()
			f26_arg0.RewardImage3:setTopBottom(0, 0, 360.5, 514.5)
			f26_arg0.clipFinished(f26_arg0.RewardImage3)
			f26_arg0.Divider:completeAnimation()
			f26_arg0.Divider:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Divider)
		end,
		ChildFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(9)
			f27_arg0.BodyBgAdd:completeAnimation()
			f27_arg0.BodyBgAdd:setAlpha(0.05)
			f27_arg0.clipFinished(f27_arg0.BodyBgAdd)
			f27_arg0.RankBg:completeAnimation()
			f27_arg0.RankBg:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RankBg)
			f27_arg0.DotTiledRankBg:completeAnimation()
			f27_arg0.DotTiledRankBg:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DotTiledRankBg)
			f27_arg0.RewardLevel:completeAnimation()
			f27_arg0.RewardLevel:setLeftRight(0.5, 0.5, -64, 64)
			f27_arg0.clipFinished(f27_arg0.RewardLevel)
			f27_arg0.LevelIcon:completeAnimation()
			f27_arg0.LevelIcon:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.LevelIcon)
			f27_arg0.RewardImage:completeAnimation()
			f27_arg0.RewardImage:setTopBottom(0, 0, 52.5, 206.5)
			f27_arg0.clipFinished(f27_arg0.RewardImage)
			f27_arg0.RewardImage2:completeAnimation()
			f27_arg0.RewardImage2:setTopBottom(0, 0, 206.5, 360.5)
			f27_arg0.clipFinished(f27_arg0.RewardImage2)
			f27_arg0.RewardImage3:completeAnimation()
			f27_arg0.RewardImage3:setTopBottom(0, 0, 360.5, 514.5)
			f27_arg0.clipFinished(f27_arg0.RewardImage3)
			f27_arg0.Divider:completeAnimation()
			f27_arg0.Divider:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Divider)
		end,
	},
	WideStatePrestige = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(15)
			f28_arg0.sizeElement:completeAnimation()
			f28_arg0.sizeElement:setLeftRight(0, 0, 0, 256)
			f28_arg0.clipFinished(f28_arg0.sizeElement)
			f28_arg0.BodyBg:completeAnimation()
			f28_arg0.BodyBg:setLeftRight(0, 0, 0, 256)
			f28_arg0.clipFinished(f28_arg0.BodyBg)
			f28_arg0.GridBodyBg:completeAnimation()
			f28_arg0.GridBodyBg:setLeftRight(0, 0, 0, 256)
			f28_arg0.GridBodyBg:setTopBottom(0, 0, 40, 506)
			f28_arg0.clipFinished(f28_arg0.GridBodyBg)
			f28_arg0.BodyBgAdd:completeAnimation()
			f28_arg0.BodyBgAdd:setLeftRight(0, 0, 0, 256)
			f28_arg0.clipFinished(f28_arg0.BodyBgAdd)
			f28_arg0.RankBg:completeAnimation()
			f28_arg0.RankBg:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.RankBg)
			f28_arg0.DotTiledRankBg:completeAnimation()
			f28_arg0.DotTiledRankBg:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.DotTiledRankBg)
			f28_arg0.HeaderBackground:completeAnimation()
			f28_arg0.HeaderBackground:setLeftRight(0, 0, 0, 256)
			f28_arg0.clipFinished(f28_arg0.HeaderBackground)
			f28_arg0.RewardLevel:completeAnimation()
			f28_arg0.RewardLevel:setLeftRight(0, 0, 0, 256)
			f28_arg0.clipFinished(f28_arg0.RewardLevel)
			f28_arg0.LevelIcon:completeAnimation()
			f28_arg0.LevelIcon:setLeftRight(0, 0, 64, 192)
			f28_arg0.LevelIcon:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.LevelIcon)
			f28_arg0.RewardImage:completeAnimation()
			f28_arg0.RewardImage:setTopBottom(0, 0, 57, 132)
			f28_arg0.clipFinished(f28_arg0.RewardImage)
			f28_arg0.RewardImage2:completeAnimation()
			f28_arg0.RewardImage2:setTopBottom(0, 0, 132, 207)
			f28_arg0.clipFinished(f28_arg0.RewardImage2)
			f28_arg0.RewardImage3:completeAnimation()
			f28_arg0.RewardImage3:setTopBottom(0, 0, 207, 282)
			f28_arg0.clipFinished(f28_arg0.RewardImage3)
			f28_arg0.Divider:completeAnimation()
			f28_arg0.Divider:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.Divider)
			f28_arg0.infoBracketBot:completeAnimation()
			f28_arg0.infoBracketBot:setLeftRight(0, 0, -1, 256)
			f28_arg0.clipFinished(f28_arg0.infoBracketBot)
			f28_arg0.infoBracketTop:completeAnimation()
			f28_arg0.infoBracketTop:setLeftRight(0, 0, -1, 256)
			f28_arg0.clipFinished(f28_arg0.infoBracketTop)
		end,
		ChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(15)
			f29_arg0.sizeElement:completeAnimation()
			f29_arg0.sizeElement:setLeftRight(0, 0, 0, 256)
			f29_arg0.clipFinished(f29_arg0.sizeElement)
			f29_arg0.BodyBg:completeAnimation()
			f29_arg0.BodyBg:setLeftRight(0, 0, 0, 256)
			f29_arg0.clipFinished(f29_arg0.BodyBg)
			f29_arg0.GridBodyBg:completeAnimation()
			f29_arg0.GridBodyBg:setLeftRight(0, 0, 0, 256)
			f29_arg0.GridBodyBg:setTopBottom(0, 0, 40, 505)
			f29_arg0.clipFinished(f29_arg0.GridBodyBg)
			f29_arg0.BodyBgAdd:completeAnimation()
			f29_arg0.BodyBgAdd:setLeftRight(0, 0, 0, 256)
			f29_arg0.BodyBgAdd:setAlpha(0.05)
			f29_arg0.clipFinished(f29_arg0.BodyBgAdd)
			f29_arg0.RankBg:completeAnimation()
			f29_arg0.RankBg:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.RankBg)
			f29_arg0.DotTiledRankBg:completeAnimation()
			f29_arg0.DotTiledRankBg:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.DotTiledRankBg)
			f29_arg0.HeaderBackground:completeAnimation()
			f29_arg0.HeaderBackground:setLeftRight(0, 0, 0, 256)
			f29_arg0.clipFinished(f29_arg0.HeaderBackground)
			f29_arg0.RewardLevel:completeAnimation()
			f29_arg0.RewardLevel:setLeftRight(0, 0, 0, 256)
			f29_arg0.clipFinished(f29_arg0.RewardLevel)
			f29_arg0.LevelIcon:completeAnimation()
			f29_arg0.LevelIcon:setLeftRight(0, 0, 68, 196)
			f29_arg0.LevelIcon:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.LevelIcon)
			f29_arg0.RewardImage:completeAnimation()
			f29_arg0.RewardImage:setTopBottom(0, 0, 57, 132)
			f29_arg0.clipFinished(f29_arg0.RewardImage)
			f29_arg0.RewardImage2:completeAnimation()
			f29_arg0.RewardImage2:setTopBottom(0, 0, 132, 207)
			f29_arg0.clipFinished(f29_arg0.RewardImage2)
			f29_arg0.RewardImage3:completeAnimation()
			f29_arg0.RewardImage3:setTopBottom(0, 0, 207, 282)
			f29_arg0.clipFinished(f29_arg0.RewardImage3)
			f29_arg0.Divider:completeAnimation()
			f29_arg0.Divider:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.Divider)
			f29_arg0.infoBracketBot:completeAnimation()
			f29_arg0.infoBracketBot:setLeftRight(0, 0, -1, 256)
			f29_arg0.clipFinished(f29_arg0.infoBracketBot)
			f29_arg0.infoBracketTop:completeAnimation()
			f29_arg0.infoBracketTop:setLeftRight(0, 0, -1, 256)
			f29_arg0.clipFinished(f29_arg0.infoBracketTop)
		end,
	},
}
CoD.Prestige_LevelRewardsWidget.__onClose = function(f30_arg0)
	f30_arg0.BodyBg:close()
	f30_arg0.DotTiledRankBg:close()
	f30_arg0.HeaderBackground:close()
	f30_arg0.RewardLevel:close()
	f30_arg0.LevelIcon:close()
	f30_arg0.RewardImage:close()
	f30_arg0.RewardImage2:close()
	f30_arg0.RewardImage3:close()
end
