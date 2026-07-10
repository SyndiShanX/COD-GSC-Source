require("x64:6c0a92e345d6635")
require("x64:93a575a7ca17e04")
require("x64:94e166fa0d10785")
require("x64:9f7790271138ea3")
require("x64:321511f84c87d83")
CoD.OverheadName_ZM = InheritFrom(LUI.UIElement)
CoD.OverheadName_ZM.__defaultWidth = 200
CoD.OverheadName_ZM.__defaultHeight = 75
CoD.OverheadName_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OverheadName_ZM)
	self.id = "OverheadName_ZM"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerNameAndClanTagBG = CoD.OverheadName_PlayerNameAndClanTag.new(f1_arg0, f1_arg1, 0, 0, 32.5, 167.5, 0, 0, 26.5, 63.5)
	PlayerNameAndClanTagBG:setRGB(0, 0, 0)
	PlayerNameAndClanTagBG:linkToElementModel(self, nil, false, function(model)
		PlayerNameAndClanTagBG:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerNameAndClanTagBG)
	self.PlayerNameAndClanTagBG = PlayerNameAndClanTagBG
	local PlayerNameAndClanTag = CoD.OverheadName_PlayerNameAndClanTag.new(f1_arg0, f1_arg1, 0, 0, 32.5, 167.5, 0, 0, 26.5, 63.5)
	PlayerNameAndClanTag.__Color = function(f3_arg0)
		local f3_local0 = f3_arg0:get()
		if f3_local0 ~= nil then
			PlayerNameAndClanTag:setRGB(CoD.HUDUtility.GetPlayerNameColorByClientNum(f1_arg1, f3_local0))
		end
	end
	PlayerNameAndClanTag:linkToElementModel(self, "clientNum", true, PlayerNameAndClanTag.__Color)
	PlayerNameAndClanTag.__Color_FullPath = function()
		local f4_local0 = self:getModel()
		if f4_local0 then
			f4_local0 = self:getModel()
			f4_local0 = f4_local0.clientNum
		end
		if f4_local0 then
			PlayerNameAndClanTag.__Color(f4_local0)
		end
	end
	PlayerNameAndClanTag:linkToElementModel(self, nil, false, function(model)
		PlayerNameAndClanTag:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerNameAndClanTag)
	self.PlayerNameAndClanTag = PlayerNameAndClanTag
	local HealthBar = CoD.HealthBar.new(f1_arg0, f1_arg1, 0, 0, 36.5, 164.5, 0, 0, 12.5, 29.5)
	HealthBar:linkToElementModel(self, "health", false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	HealthBar.HealthFill.__Health_Bar_Color = function(f7_arg0)
		local f7_local0 = f7_arg0:get()
		if f7_local0 ~= nil then
			HealthBar.HealthFill:setRGB(CoD.HUDUtility.GetPlayerHealthBarColorByClientNum(f1_arg1, f7_local0))
		end
	end
	HealthBar:linkToElementModel(self, "clientNum", true, HealthBar.HealthFill.__Health_Bar_Color)
	HealthBar.HealthFill.__Health_Bar_Color_FullPath = function()
		local f8_local0 = self:getModel()
		if f8_local0 then
			f8_local0 = self:getModel()
			f8_local0 = f8_local0.clientNum
		end
		if f8_local0 then
			HealthBar.HealthFill.__Health_Bar_Color(f8_local0)
		end
	end
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	local VOIPImage = LUI.UIImage.new(0, 0, -2.5, 32.5, 0, 0, 24.5, 59.5)
	VOIPImage:linkToElementModel(self, "clientNum", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			VOIPImage:setupVoipImage(f9_local0)
		end
	end)
	self:addElement(VOIPImage)
	self.VOIPImage = VOIPImage
	local ArmorBar = CoD.ArmorBar.new(f1_arg0, f1_arg1, 0, 0, 36.5, 164.5, 0, 0, 9.5, 13.5)
	ArmorBar:linkToElementModel(self, nil, false, function(model)
		ArmorBar:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorBar)
	self.ArmorBar = ArmorBar
	local ArmorOverheadName = CoD.ArmorPortraitZM.new(f1_arg0, f1_arg1, 0, 0, 167.5, 197.5, 0, 0, -2.5, 27.5)
	ArmorOverheadName:linkToElementModel(self, nil, false, function(model)
		ArmorOverheadName:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorOverheadName)
	self.ArmorOverheadName = ArmorOverheadName
	local Rank = CoD.TabbedScoreboardRank.new(f1_arg0, f1_arg1, 0, 0, 5, 25, 0.5, 0.5, -30, 30)
	Rank:linkToElementModel(self, nil, false, function(model)
		Rank:setModel(model, f1_arg1)
	end)
	self:addElement(Rank)
	self.Rank = Rank
	local f1_local8 = PlayerNameAndClanTag
	local f1_local9 = PlayerNameAndClanTag.subscribeToModel
	local f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["profile.colorblindMode"], PlayerNameAndClanTag.__Color_FullPath)
	PlayerNameAndClanTag:linkToElementModel(self, "team", true, PlayerNameAndClanTag.__Color_FullPath)
	f1_local8 = HealthBar
	f1_local9 = HealthBar.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["profile.colorblindMode"], HealthBar.HealthFill.__Health_Bar_Color_FullPath)
	HealthBar:linkToElementModel(self, "team", true, HealthBar.HealthFill.__Health_Bar_Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "clientInvisible")
			end,
		},
		{
			stateName = "VisibleShowRank",
			condition = function(menu, element, event)
				local f14_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dead") and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]) then
					f14_local0 = IsPublicOnlineGame()
				else
					f14_local0 = false
				end
				return f14_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f15_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "dead") and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]) then
					f15_local0 = not IsPublicOnlineGame()
				else
					f15_local0 = false
				end
				return f15_local0
			end,
		},
	})
	self:linkToElementModel(self, "clientInvisible", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientInvisible",
		})
	end)
	self:linkToElementModel(self, "dead", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "dead",
		})
	end)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local9(f1_local8, f1_local10["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local9 = self
	CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
	CoD.ZombieUtility.TrialsNoHudPostLoad(self, f1_arg1, f1_arg0)
	SetElementProperty(f1_local9, "isOverheadName", true)
	return self
end
CoD.OverheadName_ZM.__resetProperties = function(f19_arg0)
	f19_arg0.HealthBar:completeAnimation()
	f19_arg0.PlayerNameAndClanTag:completeAnimation()
	f19_arg0.PlayerNameAndClanTagBG:completeAnimation()
	f19_arg0.VOIPImage:completeAnimation()
	f19_arg0.Rank:completeAnimation()
	f19_arg0.ArmorBar:completeAnimation()
	f19_arg0.ArmorOverheadName:completeAnimation()
	f19_arg0.HealthBar:setAlpha(1)
	f19_arg0.PlayerNameAndClanTag:setAlpha(1)
	f19_arg0.PlayerNameAndClanTagBG:setAlpha(1)
	f19_arg0.VOIPImage:setLeftRight(0, 0, -2.5, 32.5)
	f19_arg0.VOIPImage:setAlpha(1)
	f19_arg0.Rank:setAlpha(1)
	f19_arg0.ArmorBar:setAlpha(1)
	f19_arg0.ArmorOverheadName:setAlpha(1)
end
CoD.OverheadName_ZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.PlayerNameAndClanTagBG:completeAnimation()
			f20_arg0.PlayerNameAndClanTagBG:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.PlayerNameAndClanTagBG)
			f20_arg0.PlayerNameAndClanTag:completeAnimation()
			f20_arg0.PlayerNameAndClanTag:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.PlayerNameAndClanTag)
			f20_arg0.HealthBar:completeAnimation()
			f20_arg0.HealthBar:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.HealthBar)
		end,
	},
	Hidden = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(7)
			f21_arg0.PlayerNameAndClanTagBG:completeAnimation()
			f21_arg0.PlayerNameAndClanTagBG:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PlayerNameAndClanTagBG)
			f21_arg0.PlayerNameAndClanTag:completeAnimation()
			f21_arg0.PlayerNameAndClanTag:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.PlayerNameAndClanTag)
			f21_arg0.HealthBar:completeAnimation()
			f21_arg0.HealthBar:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.HealthBar)
			f21_arg0.VOIPImage:completeAnimation()
			f21_arg0.VOIPImage:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.VOIPImage)
			f21_arg0.ArmorBar:completeAnimation()
			f21_arg0.ArmorBar:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ArmorBar)
			f21_arg0.ArmorOverheadName:completeAnimation()
			f21_arg0.ArmorOverheadName:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.ArmorOverheadName)
			f21_arg0.Rank:completeAnimation()
			f21_arg0.Rank:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.Rank)
		end,
	},
	VisibleShowRank = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(4)
			f22_arg0.PlayerNameAndClanTagBG:completeAnimation()
			f22_arg0.PlayerNameAndClanTagBG:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.PlayerNameAndClanTagBG)
			f22_arg0.PlayerNameAndClanTag:completeAnimation()
			f22_arg0.PlayerNameAndClanTag:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.PlayerNameAndClanTag)
			f22_arg0.HealthBar:completeAnimation()
			f22_arg0.HealthBar:setAlpha(1)
			f22_arg0.clipFinished(f22_arg0.HealthBar)
			f22_arg0.VOIPImage:completeAnimation()
			f22_arg0.VOIPImage:setLeftRight(0, 0, -30, 5)
			f22_arg0.clipFinished(f22_arg0.VOIPImage)
		end,
	},
	Visible = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(4)
			f23_arg0.PlayerNameAndClanTagBG:completeAnimation()
			f23_arg0.PlayerNameAndClanTagBG:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.PlayerNameAndClanTagBG)
			f23_arg0.PlayerNameAndClanTag:completeAnimation()
			f23_arg0.PlayerNameAndClanTag:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.PlayerNameAndClanTag)
			f23_arg0.HealthBar:completeAnimation()
			f23_arg0.HealthBar:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.HealthBar)
			f23_arg0.Rank:completeAnimation()
			f23_arg0.Rank:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.Rank)
		end,
	},
}
CoD.OverheadName_ZM.__onClose = function(f24_arg0)
	f24_arg0.PlayerNameAndClanTagBG:close()
	f24_arg0.PlayerNameAndClanTag:close()
	f24_arg0.HealthBar:close()
	f24_arg0.VOIPImage:close()
	f24_arg0.ArmorBar:close()
	f24_arg0.ArmorOverheadName:close()
	f24_arg0.Rank:close()
end
