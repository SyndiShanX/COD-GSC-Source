CoD.death_zone = InheritFrom(CoD.Menu)
LUI.createMenu.death_zone = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("death_zone", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.death_zone)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local shutdownwarningshadow = LUI.UIText.new(0, 0, 405, 1519, 0, 0, 290.5, 370.5)
	shutdownwarningshadow:setRGB(0, 0, 0)
	shutdownwarningshadow:setAlpha(0)
	shutdownwarningshadow:setText(Engine[0xF9F1239CFD921FE](0x110B2D72E1F5652))
	shutdownwarningshadow:setTTF("default")
	shutdownwarningshadow:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	shutdownwarningshadow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(shutdownwarningshadow)
	self.shutdownwarningshadow = shutdownwarningshadow
	local shutdownwarning = LUI.UIText.new(0, 0, 403, 1517, 0, 0, 288.5, 368.5)
	shutdownwarning:setAlpha(0)
	shutdownwarning:setText(Engine[0xF9F1239CFD921FE](0x110B2D72E1F5652))
	shutdownwarning:setTTF("default")
	shutdownwarning:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	shutdownwarning:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(shutdownwarning)
	self.shutdownwarning = shutdownwarning
	local offlineshadow = LUI.UIText.new(0, 0, 653, 1271, 0, 0, 292.5, 372.5)
	offlineshadow:setRGB(0, 0, 0)
	offlineshadow:setAlpha(0.5)
	offlineshadow:setText(Engine[0xF9F1239CFD921FE](0xD40CA530BF6A6E9))
	offlineshadow:setTTF("default")
	offlineshadow:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	offlineshadow:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(offlineshadow)
	self.offlineshadow = offlineshadow
	local offline = LUI.UIText.new(0, 0, 651, 1269, 0, 0, 290.5, 370.5)
	offline:setText(Engine[0xF9F1239CFD921FE](0xD40CA530BF6A6E9))
	offline:setTTF("default")
	offline:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	offline:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(offline)
	self.offline = offline
	self:mergeStateConditions({
		{
			stateName = "WarningState",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(self, f1_arg0, "shutdown_sec", 0)
			end,
		},
	})
	self:linkToElementModel(self, "shutdown_sec", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "shutdown_sec",
		})
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.death_zone.__resetProperties = function(f4_arg0)
	f4_arg0.offlineshadow:completeAnimation()
	f4_arg0.offline:completeAnimation()
	f4_arg0.shutdownwarning:completeAnimation()
	f4_arg0.shutdownwarningshadow:completeAnimation()
	f4_arg0.offlineshadow:setAlpha(0.5)
	f4_arg0.offline:setLeftRight(0, 0, 651, 1269)
	f4_arg0.offline:setTopBottom(0, 0, 290.5, 370.5)
	f4_arg0.offline:setAlpha(1)
	f4_arg0.shutdownwarning:setLeftRight(0, 0, 403, 1517)
	f4_arg0.shutdownwarning:setTopBottom(0, 0, 288.5, 368.5)
	f4_arg0.shutdownwarning:setAlpha(0)
	f4_arg0.shutdownwarningshadow:setAlpha(0)
end
CoD.death_zone.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	WarningState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.shutdownwarningshadow:completeAnimation()
			f6_arg0.shutdownwarningshadow:setAlpha(0.5)
			f6_arg0.clipFinished(f6_arg0.shutdownwarningshadow)
			f6_arg0.shutdownwarning:completeAnimation()
			f6_arg0.shutdownwarning:setLeftRight(0, 0, 403, 1517)
			f6_arg0.shutdownwarning:setTopBottom(0, 0, 288.5, 368.5)
			f6_arg0.shutdownwarning:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.shutdownwarning)
			f6_arg0.offlineshadow:completeAnimation()
			f6_arg0.offlineshadow:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.offlineshadow)
			f6_arg0.offline:completeAnimation()
			f6_arg0.offline:setLeftRight(0, 0, 651, 1269)
			f6_arg0.offline:setTopBottom(0, 0, 290.5, 370.5)
			f6_arg0.offline:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.offline)
		end,
	},
}
CoD.death_zone.__onClose = function(f7_arg0) end
