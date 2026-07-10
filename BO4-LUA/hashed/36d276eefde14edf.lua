require("x64:f00a10fc8301da2")
require("x64:1305c54f67eb198")
require("x64:722479b00d6ae68")
require("x64:a7fb2b79f756e3")
require("x64:6ee653ade3452f5")
CoD.AARSquadSummary = InheritFrom(LUI.UIElement)
CoD.AARSquadSummary.__defaultWidth = 1920
CoD.AARSquadSummary.__defaultHeight = 900
CoD.AARSquadSummary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARSquadSummary)
	self.id = "AARSquadSummary"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -1000, 1000, 0.5, 0.5, -540, 540)
	AarMpBacking.Backer:setRGB(0, 0, 0)
	AarMpBacking.Backer:setAlpha(0.5)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.1, 1.1, 0, 0)
	ScorestreakAspectRatioFix:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local AARSquadHeader = CoD.AARSquadHeader.new(f1_arg0, f1_arg1, 0, 0, 331, 1589, 0, 0, 187, 207)
	self:addElement(AARSquadHeader)
	self.AARSquadHeader = AARSquadHeader
	local SquadList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 2, 0, nil, nil, false, false, false, false)
	SquadList:setLeftRight(0.5, 0.5, -629, 629)
	SquadList:setTopBottom(0, 0, 227, 513)
	SquadList:setWidgetType(CoD.AARSquadRow)
	SquadList:setVerticalCount(4)
	SquadList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	SquadList:setDataSource("AARSquadStats")
	self:addElement(SquadList)
	self.SquadList = SquadList
	local BackingHeader = LUI.UIImage.new(0, 0, 320, 1601, 0, 0, 91, 141)
	BackingHeader:setRGB(0, 0, 0)
	BackingHeader:setAlpha(0)
	self:addElement(BackingHeader)
	self.BackingHeader = BackingHeader
	local BackingPlayList = LUI.UIImage.new(0.5, 0.5, -640, 640, 0, 0, 216.5, 524.5)
	BackingPlayList:setRGB(0, 0, 0)
	BackingPlayList:setAlpha(0)
	self:addElement(BackingPlayList)
	self.BackingPlayList = BackingPlayList
	local SquadPlacement = CoD.AARSquadPlacement.new(f1_arg0, f1_arg1, 0, 0, 324, 824, 0, 0, 97, 137)
	self:addElement(SquadPlacement)
	self.SquadPlacement = SquadPlacement
	local TopBracket = LUI.UIImage.new(0.5, 0.5, -641, 641, 0, 0, 215, 224)
	TopBracket:setAlpha(0)
	TopBracket:setZRot(180)
	TopBracket:setImage(RegisterImage(0xC325BED3F226657))
	TopBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	TopBracket:setShaderVector(0, 0, 0, 0, 0)
	TopBracket:setupNineSliceShader(16, 4)
	self:addElement(TopBracket)
	self.TopBracket = TopBracket
	local BottomBracket = LUI.UIImage.new(0.5, 0.5, -641, 641, 0, 0, 517, 526)
	BottomBracket:setAlpha(0)
	BottomBracket:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BottomBracket:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket)
	self.BottomBracket = BottomBracket
	local dotline = LUI.UIImage.new(0, 0, 320, 1600, 0, 0, 141, 145)
	dotline:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	dotline:setAlpha(0)
	dotline:setImage(RegisterImage(0xF9C7F41C631866E))
	dotline:setMaterial(LUI.UIImage.GetCachedMaterial(0x6E9593DF28749F2))
	dotline:setShaderVector(0, 1.8, 1, 0, 0)
	dotline:setShaderVector(1, 0, 1, 0, 1)
	self:addElement(dotline)
	self.dotline = dotline
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SQUAD)
			end,
		},
	})
	local f1_local11 = self
	local f1_local12 = self.subscribeToModel
	local f1_local13 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local12(f1_local11, f1_local13["AAR.activeTab"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	SquadList.id = "SquadList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSquadSummary.__resetProperties = function(f5_arg0)
	f5_arg0.AarMpBacking:completeAnimation()
	f5_arg0.SquadList:completeAnimation()
	f5_arg0.AARSquadHeader:completeAnimation()
	f5_arg0.SquadPlacement:completeAnimation()
	f5_arg0.TopBracket:completeAnimation()
	f5_arg0.BottomBracket:completeAnimation()
	f5_arg0.BackingHeader:completeAnimation()
	f5_arg0.BackingPlayList:completeAnimation()
	f5_arg0.dotline:completeAnimation()
	f5_arg0.AarMpBacking:setAlpha(1)
	f5_arg0.SquadList:setAlpha(1)
	f5_arg0.AARSquadHeader:setAlpha(1)
	f5_arg0.SquadPlacement:setAlpha(1)
	f5_arg0.TopBracket:setAlpha(0)
	f5_arg0.BottomBracket:setAlpha(0)
	f5_arg0.BackingHeader:setAlpha(0)
	f5_arg0.BackingPlayList:setAlpha(0)
	f5_arg0.dotline:setAlpha(0)
end
CoD.AARSquadSummary.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.AarMpBacking:completeAnimation()
			f6_arg0.AarMpBacking:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AarMpBacking)
			f6_arg0.AARSquadHeader:completeAnimation()
			f6_arg0.AARSquadHeader:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AARSquadHeader)
			f6_arg0.SquadList:completeAnimation()
			f6_arg0.SquadList:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.SquadList)
			f6_arg0.SquadPlacement:completeAnimation()
			f6_arg0.SquadPlacement:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.SquadPlacement)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(5)
			f7_arg0.BackingHeader:completeAnimation()
			f7_arg0.BackingHeader:setAlpha(0.15)
			f7_arg0.clipFinished(f7_arg0.BackingHeader)
			f7_arg0.BackingPlayList:completeAnimation()
			f7_arg0.BackingPlayList:setAlpha(0.25)
			f7_arg0.clipFinished(f7_arg0.BackingPlayList)
			f7_arg0.TopBracket:completeAnimation()
			f7_arg0.TopBracket:setAlpha(0.1)
			f7_arg0.clipFinished(f7_arg0.TopBracket)
			f7_arg0.BottomBracket:completeAnimation()
			f7_arg0.BottomBracket:setAlpha(0.1)
			f7_arg0.clipFinished(f7_arg0.BottomBracket)
			f7_arg0.dotline:completeAnimation()
			f7_arg0.dotline:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.dotline)
		end,
	},
}
CoD.AARSquadSummary.__onClose = function(f8_arg0)
	f8_arg0.AarMpBacking:close()
	f8_arg0.ScorestreakAspectRatioFix:close()
	f8_arg0.AARSquadHeader:close()
	f8_arg0.SquadList:close()
	f8_arg0.SquadPlacement:close()
end
