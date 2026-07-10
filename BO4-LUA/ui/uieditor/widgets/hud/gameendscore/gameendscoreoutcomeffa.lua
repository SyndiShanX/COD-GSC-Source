require("x64:1690601ad3b4c05")
require("x64:a0a33ed4962c6ec")
CoD.GameEndScoreOutcomeFFA = InheritFrom(LUI.UIElement)
CoD.GameEndScoreOutcomeFFA.__defaultWidth = 960
CoD.GameEndScoreOutcomeFFA.__defaultHeight = 400
CoD.GameEndScoreOutcomeFFA.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 34, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.GameEndScoreOutcomeFFA)
	self.id = "GameEndScoreOutcomeFFA"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local First = CoD.GameEndScoreOutcomeFFABar.new(f1_arg0, f1_arg1, 0, 0, 0, 959, 0, 0, 0, 160)
	First.PlaceBanner:setRGB(ColorSet.T8__GOLD.r, ColorSet.T8__GOLD.g, ColorSet.T8__GOLD.b)
	First.PlaceText:setText(CoD.BaseUtility.AlreadyLocalized(1))
	First:subscribeToGlobalModel(f1_arg1, "FFALeader", nil, function(model)
		First:setModel(model, f1_arg1)
	end)
	self:addElement(First)
	self.First = First
	local Second = CoD.GameEndScoreOutcomeFFABarSmall.new(f1_arg0, f1_arg1, 0.5, 0.5, -413, 413, 0, 0, 194, 314)
	Second.GlowTexture:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	Second.Glow:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	Second.PlaceBanner:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	Second.GlowSphere:setRGB(0.68, 0.77, 0.89)
	Second.GlowRing:setRGB(0.98, 0.92, 0.69)
	Second.PlaceText:setText(CoD.BaseUtility.AlreadyLocalized(2))
	Second.BGDotPatternLarge:setRGB(0.87, 0.87, 0.87)
	Second.BGDotPatternLarge:setAlpha(0.4)
	Second:subscribeToGlobalModel(f1_arg1, "FFASecondBest", nil, function(model)
		Second:setModel(model, f1_arg1)
	end)
	self:addElement(Second)
	self.Second = Second
	local Third = CoD.GameEndScoreOutcomeFFABarSmall.new(f1_arg0, f1_arg1, 0.5, 0.5, -413, 413, 0.5, 0.5, 148, 268)
	Third.GlowTexture:setRGB(0.6, 0.48, 0.26)
	Third.Glow:setRGB(0.6, 0.48, 0.26)
	Third.PlaceBanner:setRGB(0.6, 0.48, 0.26)
	Third.GlowSphere:setRGB(0.93, 0.73, 0.34)
	Third.GlowRing:setRGB(ColorSet.BlackMarketEpicBright.r, ColorSet.BlackMarketEpicBright.g, ColorSet.BlackMarketEpicBright.b)
	Third.PlaceText:setText(CoD.BaseUtility.AlreadyLocalized(3))
	Third.BGDotPatternLarge:setRGB(1, 0.96, 0.87)
	Third.BGDotPatternLarge:setAlpha(0.4)
	Third:subscribeToGlobalModel(f1_arg1, "FFAThirdBest", nil, function(model)
		Third:setModel(model, f1_arg1)
	end)
	self:addElement(Third)
	self.Third = Third
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.GameEndScoreOutcomeFFA.__onClose = function(f5_arg0)
	f5_arg0.First:close()
	f5_arg0.Second:close()
	f5_arg0.Third:close()
end
