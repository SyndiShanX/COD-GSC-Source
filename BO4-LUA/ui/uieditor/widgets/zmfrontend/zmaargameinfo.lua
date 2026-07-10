CoD.ZMAARGameInfo = InheritFrom(LUI.UIElement)
CoD.ZMAARGameInfo.__defaultWidth = 974
CoD.ZMAARGameInfo.__defaultHeight = 113
CoD.ZMAARGameInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARGameInfo)
	self.id = "ZMAARGameInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GametypeImage = LUI.UIImage.new(0, 0, -1.5, 118.5, 0, 0, -3.5, 116.5)
	GametypeImage:setAlpha(0.9)
	GametypeImage:linkToElementModel(self, "gametypeIcon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GametypeImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(GametypeImage)
	self.GametypeImage = GametypeImage
	local GametypeAndMap = LUI.UIText.new(0, 0, 125, 979, 0, 0, 33.5, 93.5)
	GametypeAndMap:setRGB(0.58, 0.85, 1)
	GametypeAndMap:setAlpha(0.5)
	GametypeAndMap:setTTF("skorzhen")
	GametypeAndMap:setLetterSpacing(3)
	GametypeAndMap:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GametypeAndMap:linkToElementModel(self, "gametypeAndMap", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GametypeAndMap:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(GametypeAndMap)
	self.GametypeAndMap = GametypeAndMap
	local VictoryDefeat = LUI.UIText.new(0, 0, 125, 980, 0, 0, 33.5, 93.5)
	VictoryDefeat:setRGB(0.58, 0.85, 1)
	VictoryDefeat:setAlpha(0)
	VictoryDefeat:setText(Engine[0xF9F1239CFD921FE](0xAB769C72F266516))
	VictoryDefeat:setTTF("skorzhen")
	VictoryDefeat:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	VictoryDefeat:setLetterSpacing(3)
	VictoryDefeat:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(VictoryDefeat)
	self.VictoryDefeat = VictoryDefeat
	self:mergeStateConditions({
		{
			stateName = "Stats",
			condition = function(menu, element, event)
				return IsZombies() and CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.ZM_AAR_SCOREBOARD)
			end,
		},
		{
			stateName = "Summary",
			condition = function(menu, element, event)
				return IsZombies() and CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY)
			end,
		},
		{
			stateName = "Trial",
			condition = function(menu, element, event)
				return IsZombies() and CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_TRIAL)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["AAR.activeTab"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARGameInfo.__resetProperties = function(f9_arg0)
	f9_arg0.VictoryDefeat:completeAnimation()
	f9_arg0.GametypeAndMap:completeAnimation()
	f9_arg0.VictoryDefeat:setRGB(0.58, 0.85, 1)
	f9_arg0.VictoryDefeat:setAlpha(0)
	f9_arg0.VictoryDefeat:setText(Engine[0xF9F1239CFD921FE](0xAB769C72F266516))
	f9_arg0.VictoryDefeat:setLetterSpacing(3)
	f9_arg0.GametypeAndMap:setAlpha(0.5)
end
CoD.ZMAARGameInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.VictoryDefeat:completeAnimation()
			f10_arg0.VictoryDefeat:setRGB(0.4, 0.55, 0.22)
			f10_arg0.VictoryDefeat:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.VictoryDefeat)
		end,
	},
	Stats = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.VictoryDefeat:completeAnimation()
			f11_arg0.VictoryDefeat:setAlpha(0)
			f11_arg0.VictoryDefeat:setText(Engine[0xF9F1239CFD921FE](0x7BB5E9B11633E3))
			f11_arg0.clipFinished(f11_arg0.VictoryDefeat)
		end,
	},
	Summary = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.VictoryDefeat:completeAnimation()
			f12_arg0.VictoryDefeat:setAlpha(0)
			f12_arg0.VictoryDefeat:setText(Engine[0xF9F1239CFD921FE](0x5E9C86634E25EA8))
			f12_arg0.clipFinished(f12_arg0.VictoryDefeat)
		end,
	},
	Trial = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.GametypeAndMap:completeAnimation()
			f13_arg0.GametypeAndMap:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.GametypeAndMap)
			f13_arg0.VictoryDefeat:completeAnimation()
			f13_arg0.VictoryDefeat:setAlpha(0.5)
			f13_arg0.VictoryDefeat:setText(Engine[0xF9F1239CFD921FE](0x82F7D154900B7D8))
			f13_arg0.VictoryDefeat:setLetterSpacing(3)
			f13_arg0.clipFinished(f13_arg0.VictoryDefeat)
		end,
	},
}
CoD.ZMAARGameInfo.__onClose = function(f14_arg0)
	f14_arg0.GametypeImage:close()
	f14_arg0.GametypeAndMap:close()
end
