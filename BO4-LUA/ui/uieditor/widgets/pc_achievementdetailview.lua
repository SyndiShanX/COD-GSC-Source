require("x64:a2c4a319ea5353")
require("x64:ff272eb6e6aaf30")
require("x64:caf3cedd5ac4996")
require("x64:8ce4f97c9c109c1")
require("x64:564ca313abeb19a")
CoD.PC_AchievementDetailView = InheritFrom(LUI.UIElement)
CoD.PC_AchievementDetailView.__defaultWidth = 488
CoD.PC_AchievementDetailView.__defaultHeight = 633
CoD.PC_AchievementDetailView.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_AchievementDetailView)
	self.id = "PC_AchievementDetailView"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.05, 0.05, 0.05)
	Backing:setAlpha(0.98)
	self:addElement(Backing)
	self.Backing = Backing
	local PixelGridTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PixelGridTiledBacking:setAlpha(0.05)
	PixelGridTiledBacking:setImage(RegisterImage(0x311E811A3183347))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local GridTiled = LUI.UIImage.new(0, 1, 2, -2, 0, 1, 4, -4)
	GridTiled:setAlpha(0.09)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(0xCA386792563DE8))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local Dots = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Dots:setRGB(0.92, 0.92, 0.92)
	Dots:setImage(RegisterImage(0xFE4B36304988C2C))
	Dots:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Dots:setShaderVector(0, 0, 0, 0, 0)
	Dots:setupNineSliceShader(6, 6)
	self:addElement(Dots)
	self.Dots = Dots
	local ProgressBG = LUI.UIImage.new(0, 1, 17, -17, 1, 1, -56, -20)
	ProgressBG:setRGB(0, 0, 0)
	ProgressBG:setAlpha(0)
	self:addElement(ProgressBG)
	self.ProgressBG = ProgressBG
	local ProgressBar = CoD.PC_AchievementProgressBar.new(f1_arg0, f1_arg1, 0, 1, 19, -147, 1, 1, -54, -22)
	ProgressBar:setAlpha(0)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local ProgressOutline = CoD.FE_TitleNumBrdr.new(f1_arg0, f1_arg1, 0, 1, 17, -17, 1, 1, -56, -20)
	ProgressOutline:setAlpha(0)
	self:addElement(ProgressOutline)
	self.ProgressOutline = ProgressOutline
	local CurrentProgressValue = LUI.UIText.new(1, 1, -136, -86, 1, 1, -49, -25)
	CurrentProgressValue:setRGB(0.58, 0.58, 0.58)
	CurrentProgressValue:setAlpha(0)
	CurrentProgressValue:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	CurrentProgressValue:setTTF("ttmussels_demibold")
	CurrentProgressValue:setLetterSpacing(2)
	CurrentProgressValue:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	CurrentProgressValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(CurrentProgressValue)
	self.CurrentProgressValue = CurrentProgressValue
	local TotalProgressValue = LUI.UIText.new(1, 1, -71, -21, 1, 1, -50, -25)
	TotalProgressValue:setRGB(0.58, 0.58, 0.58)
	TotalProgressValue:setAlpha(0)
	TotalProgressValue:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	TotalProgressValue:setTTF("ttmussels_regular")
	TotalProgressValue:setLetterSpacing(2)
	TotalProgressValue:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TotalProgressValue:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TotalProgressValue)
	self.TotalProgressValue = TotalProgressValue
	local Slash = LUI.UIText.new(1, 1, -83, -73, 1, 1, -51, -26)
	Slash:setRGB(0.58, 0.58, 0.58)
	Slash:setAlpha(0)
	Slash:setText(CoD.BaseUtility.AlreadyLocalized("/"))
	Slash:setTTF("ttmussels_regular")
	Slash:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Slash:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Slash)
	self.Slash = Slash
	local ArrowsRight = CoD.TabletConnectionArrow.new(f1_arg0, f1_arg1, 1, 1, -60, 5, 0, 0, 219.5, 250.5)
	ArrowsRight:setScale(0.6, 0.6)
	self:addElement(ArrowsRight)
	self.ArrowsRight = ArrowsRight
	local ArrowsLeft = CoD.TabletConnectionArrow.new(f1_arg0, f1_arg1, 0, 0, -5, 60, 0, 0, 219.5, 250.5)
	ArrowsLeft:setZRot(180)
	ArrowsLeft:setScale(0.6, 0.6)
	self:addElement(ArrowsLeft)
	self.ArrowsLeft = ArrowsLeft
	local AchievementIcon = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -128, 128, 0, 0, 107, 363)
	AchievementIcon:setRGB(0.32, 0.32, 0.32)
	AchievementIcon:setAlpha(0.8)
	AchievementIcon:setImage(RegisterImage(0x50537D33096A8CA))
	self:addElement(AchievementIcon)
	self.AchievementIcon = AchievementIcon
	local Lock = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -20, 20, 0, 0, 215, 255)
	Lock:setImage(RegisterImage(0xB8AD8D12CEB707D))
	self:addElement(Lock)
	self.Lock = Lock
	local Description = CoD.PC_AchievementDetailedView_Desc.new(f1_arg0, f1_arg1, 0, 1, 17, -17, 0, 0, 400, 574)
	self:addElement(Description)
	self.Description = Description
	local Points = CoD.PC_AchievementDetailedView_Points.new(f1_arg0, f1_arg1, 1, 1, -194, -19, 0, 0, 35, 75)
	self:addElement(Points)
	self.Points = Points
	local HeaderStripeBot = LUI.UIImage.new(0, 1, 6, -6, 1, 1, -18, -5)
	HeaderStripeBot:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderStripeBot:setAlpha(0.5)
	HeaderStripeBot:setImage(RegisterImage(0xC7A051F5EFC70E5))
	HeaderStripeBot:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	HeaderStripeBot:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripeBot:setupNineSliceShader(90, 16)
	self:addElement(HeaderStripeBot)
	self.HeaderStripeBot = HeaderStripeBot
	local HeaderStripeTop = LUI.UIImage.new(0, 1, 6, -6, 0, 0, 5, 18)
	HeaderStripeTop:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HeaderStripeTop:setAlpha(0.5)
	HeaderStripeTop:setImage(RegisterImage(0xC7A051F5EFC70E5))
	HeaderStripeTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	HeaderStripeTop:setShaderVector(0, 0, 0, 0, 0)
	HeaderStripeTop:setupNineSliceShader(90, 16)
	self:addElement(HeaderStripeTop)
	self.HeaderStripeTop = HeaderStripeTop
	LUI.OverrideFunction_CallOriginalFirst(self, "setModel", function(element, controller)
		if CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isCompleted") then
			SetElementState(self, self.ProgressBar, f1_arg1, "Completed")
			SetState(self, "Completed", f1_arg1)
		elseif not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isCompleted") then
			SetElementState(self, self.ProgressBar, f1_arg1, "DefaultState")
			SetState(self, "DefaultState", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_AchievementDetailView.__resetProperties = function(f3_arg0)
	f3_arg0.Points:completeAnimation()
	f3_arg0.AchievementIcon:completeAnimation()
	f3_arg0.Lock:completeAnimation()
	f3_arg0.AchievementIcon:setRGB(0.32, 0.32, 0.32)
	f3_arg0.AchievementIcon:setAlpha(0.8)
	f3_arg0.Lock:setAlpha(1)
end
CoD.PC_AchievementDetailView.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Points:completeAnimation()
			f4_arg0.Points:playClip("DefaultClip")
			f4_arg0.clipFinished(f4_arg0.Points)
		end,
	},
	Completed = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.AchievementIcon:completeAnimation()
			f5_arg0.AchievementIcon:setRGB(1, 1, 1)
			f5_arg0.AchievementIcon:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.AchievementIcon)
			f5_arg0.Lock:completeAnimation()
			f5_arg0.Lock:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Lock)
			f5_arg0.Points:completeAnimation()
			f5_arg0.Points:playClip("Completed")
			f5_arg0.clipFinished(f5_arg0.Points)
		end,
	},
}
CoD.PC_AchievementDetailView.__onClose = function(f6_arg0)
	f6_arg0.ProgressBar:close()
	f6_arg0.ProgressOutline:close()
	f6_arg0.ArrowsRight:close()
	f6_arg0.ArrowsLeft:close()
	f6_arg0.Description:close()
	f6_arg0.Points:close()
end
