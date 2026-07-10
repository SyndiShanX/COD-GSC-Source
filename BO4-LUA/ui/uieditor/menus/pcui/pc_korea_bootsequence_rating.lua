require("x64:9213f1ab565236b")
require("x64:9ba52b1be9e1c54")
CoD.PC_Korea_Bootsequence_Rating = InheritFrom(CoD.Menu)
LUI.createMenu.PC_Korea_Bootsequence_Rating = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_Korea_Bootsequence_Rating", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.PC_Korea_Bootsequence_Rating)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local BackBGScreen = nil
	BackBGScreen = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackBGScreen:setRGB(0, 0, 0)
	self:addElement(BackBGScreen)
	self.BackBGScreen = BackBGScreen
	local KoreaAdditionnalText18 = nil
	KoreaAdditionnalText18 = LUI.UIText.new(0.5, 0.5, -654.5, 654.5, 0.5, 0.5, -151, -22)
	KoreaAdditionnalText18:setText(Engine[0xF9F1239CFD921FE](0x40029439C03BA7C))
	KoreaAdditionnalText18:setTTF("notosans_regular")
	KoreaAdditionnalText18:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KoreaAdditionnalText18:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(KoreaAdditionnalText18)
	self.KoreaAdditionnalText18 = KoreaAdditionnalText18
	local KoreaAdditionnalText15 = nil
	KoreaAdditionnalText15 = LUI.UIText.new(0.5, 0.5, -783, 783, 0.5, 0.5, -177, -87)
	KoreaAdditionnalText15:setText(Engine[0xF9F1239CFD921FE](0x4002E439C03C2FB))
	KoreaAdditionnalText15:setTTF("notosans_regular")
	KoreaAdditionnalText15:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KoreaAdditionnalText15:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(KoreaAdditionnalText15)
	self.KoreaAdditionnalText15 = KoreaAdditionnalText15
	local PCKoreaBoot15ContentDescriptorsIcons = nil
	PCKoreaBoot15ContentDescriptorsIcons = CoD.PC_Korea_Boot_15ContentDescriptors_Icons.new(f1_local1, f1_arg0, 0.5, 0.5, -329.5, 329.5, 0, 0, 175, 340)
	self:addElement(PCKoreaBoot15ContentDescriptorsIcons)
	self.PCKoreaBoot15ContentDescriptorsIcons = PCKoreaBoot15ContentDescriptorsIcons
	local KoreaRatingDescriptorIcons18 = nil
	KoreaRatingDescriptorIcons18 = CoD.PC_Korea_Boot_18ContentDescriptors_Icons.new(f1_local1, f1_arg0, 0.5, 0.5, -160, 160, 0, 0, 200, 382)
	self:addElement(KoreaRatingDescriptorIcons18)
	self.KoreaRatingDescriptorIcons18 = KoreaRatingDescriptorIcons18
	self:mergeStateConditions({
		{
			stateName = "Rating15",
			condition = function(menu, element, event)
				return CoD.PCKoreaUtility.ShowKorea15Plus()
			end,
		},
	})
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local7 = self
	CoD.PCKoreaUtility.WaitOutKoreanBootWarning(self, f1_arg0, "4000")
	return self
end
CoD.PC_Korea_Bootsequence_Rating.__resetProperties = function(f3_arg0)
	f3_arg0.KoreaAdditionnalText15:completeAnimation()
	f3_arg0.PCKoreaBoot15ContentDescriptorsIcons:completeAnimation()
	f3_arg0.KoreaRatingDescriptorIcons18:completeAnimation()
	f3_arg0.KoreaAdditionnalText18:completeAnimation()
	f3_arg0.KoreaAdditionnalText15:setAlpha(1)
	f3_arg0.PCKoreaBoot15ContentDescriptorsIcons:setAlpha(1)
	f3_arg0.KoreaRatingDescriptorIcons18:setAlpha(1)
	f3_arg0.KoreaAdditionnalText18:setAlpha(1)
end
CoD.PC_Korea_Bootsequence_Rating.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			f4_arg0.KoreaAdditionnalText18:completeAnimation()
			f4_arg0.KoreaAdditionnalText18:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.KoreaAdditionnalText18)
			f4_arg0.KoreaAdditionnalText15:completeAnimation()
			f4_arg0.KoreaAdditionnalText15:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.KoreaAdditionnalText15)
			f4_arg0.PCKoreaBoot15ContentDescriptorsIcons:completeAnimation()
			f4_arg0.PCKoreaBoot15ContentDescriptorsIcons:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.PCKoreaBoot15ContentDescriptorsIcons)
			f4_arg0.KoreaRatingDescriptorIcons18:completeAnimation()
			f4_arg0.KoreaRatingDescriptorIcons18:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.KoreaRatingDescriptorIcons18)
		end,
	},
	Rating15 = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.KoreaAdditionnalText18:completeAnimation()
			f5_arg0.KoreaAdditionnalText18:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.KoreaAdditionnalText18)
			f5_arg0.KoreaRatingDescriptorIcons18:completeAnimation()
			f5_arg0.KoreaRatingDescriptorIcons18:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.KoreaRatingDescriptorIcons18)
		end,
	},
}
CoD.PC_Korea_Bootsequence_Rating.__onClose = function(f6_arg0)
	f6_arg0.PCKoreaBoot15ContentDescriptorsIcons:close()
	f6_arg0.KoreaRatingDescriptorIcons18:close()
end
