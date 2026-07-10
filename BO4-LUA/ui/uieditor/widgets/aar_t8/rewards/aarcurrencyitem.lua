require("x64:4e6143dbc749ffd")
require("x64:a9255c570c68aa8")
CoD.AARCurrencyItem = InheritFrom(LUI.UIElement)
CoD.AARCurrencyItem.__defaultWidth = 380
CoD.AARCurrencyItem.__defaultHeight = 230
CoD.AARCurrencyItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARCurrencyItem)
	self.id = "AARCurrencyItem"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0.5, 0.5, -148, 148, 0, 0, 0, 150)
	Frame:setAlpha(0)
	self:addElement(Frame)
	self.Frame = Frame
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.64, 0.64, 0.64)
	Backing:setAlpha(0.04)
	self:addElement(Backing)
	self.Backing = Backing
	local Image = LUI.UIFixedAspectRatioImage.new(0, 0, 100, 190, 0.5, 0.5, -45, 45)
	self:addElement(Image)
	self.Image = Image
	local Title = LUI.UIText.new(0.5, 0.5, 11, 148, 0.5, 0.5, -10, 35)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setText("")
	Title:setTTF("skorzhen")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Title)
	self.Title = Title
	local Corner = CoD.AARRewardBrackets.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Corner:setAlpha(0.4)
	self:addElement(Corner)
	self.Corner = Corner
	local LockImage = LUI.UIFixedAspectRatioImage.new(0, 0, 164, 214, 0.5, 0.5, -79.5, -29.5)
	LockImage:setAlpha(0)
	LockImage:setImage(RegisterImage(@"menu_mp_lobby_locked"))
	self:addElement(LockImage)
	self.LockImage = LockImage
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "DoubleNP",
			condition = function(menu, element, event)
				return CoD.ZombieUtility.IsDoubleNP(f1_arg1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local8(f1_local7, f1_local9.cycled, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARCurrencyItem.__resetProperties = function(f5_arg0)
	f5_arg0.LockImage:completeAnimation()
	f5_arg0.Image:completeAnimation()
	f5_arg0.Title:completeAnimation()
	f5_arg0.LockImage:setAlpha(0)
	f5_arg0.Image:setAlpha(1)
	f5_arg0.Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
end
CoD.AARCurrencyItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Locked = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Image:completeAnimation()
			f7_arg0.Image:setAlpha(0.05)
			f7_arg0.clipFinished(f7_arg0.Image)
			f7_arg0.LockImage:completeAnimation()
			f7_arg0.LockImage:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.LockImage)
		end,
	},
	DoubleNP = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.Title:completeAnimation()
			f8_arg0.Title:setRGB(0.52, 0.25, 0.68)
			f8_arg0.clipFinished(f8_arg0.Title)
		end,
	},
}
CoD.AARCurrencyItem.__onClose = function(f9_arg0)
	f9_arg0.Frame:close()
	f9_arg0.Corner:close()
end
