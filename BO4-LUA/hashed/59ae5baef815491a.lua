CoD.ObjectiveLog = InheritFrom(LUI.UIElement)
CoD.ObjectiveLog.__defaultWidth = 350
CoD.ObjectiveLog.__defaultHeight = 500
CoD.ObjectiveLog.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ObjectiveLog)
	self.id = "ObjectiveLog"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 0, 0, 350, 0, 0, 0, 491)
	Background:setRGB(0.17, 0.17, 0.17)
	Background:setAlpha(0.85)
	self:addElement(Background)
	self.Background = Background
	local Background2 = LUI.UIImage.new(0, 0, 0, 350, 0, 0, 0, 79)
	Background2:setRGB(0.17, 0.17, 0.17)
	Background2:setAlpha(0.9)
	self:addElement(Background2)
	self.Background2 = Background2
	local Background3 = LUI.UIImage.new(0, 0, 0, 350, 0, 0, 192, 261)
	Background3:setRGB(0.17, 0.17, 0.17)
	Background3:setAlpha(0.9)
	self:addElement(Background3)
	self.Background3 = Background3
	local Background5 = LUI.UIImage.new(0, 0, 0, 350, 0, 0, 339, 343)
	Background5:setRGB(0.17, 0.17, 0.17)
	Background5:setAlpha(0.9)
	self:addElement(Background5)
	self.Background5 = Background5
	local Background4 = LUI.UIImage.new(0, 0, 0, 350, 0, 0, 415, 419)
	Background4:setRGB(0.17, 0.17, 0.17)
	Background4:setAlpha(0.9)
	self:addElement(Background4)
	self.Background4 = Background4
	local ObjectiveLine3 = LUI.UIText.new(0, 0, 11.5, 338.5, 0, 0, 432, 459)
	ObjectiveLine3:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_90A6F20B1D56111"))
	ObjectiveLine3:setTTF("default")
	ObjectiveLine3:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	ObjectiveLine3:setShaderVector(0, 0.32, 0, 0, 0)
	ObjectiveLine3:setShaderVector(1, 0, 0, 0, 1)
	ObjectiveLine3:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ObjectiveLine3:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ObjectiveLine3)
	self.ObjectiveLine3 = ObjectiveLine3
	local ObjectiveLine2 = LUI.UIText.new(0, 0, 11.5, 338.5, 0, 0, 348, 375)
	ObjectiveLine2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_90A6F20B1D56111"))
	ObjectiveLine2:setTTF("default")
	ObjectiveLine2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	ObjectiveLine2:setShaderVector(0, 0.32, 0, 0, 0)
	ObjectiveLine2:setShaderVector(1, 0, 0, 0, 1)
	ObjectiveLine2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ObjectiveLine2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ObjectiveLine2)
	self.ObjectiveLine2 = ObjectiveLine2
	local ObjectiveLine1 = LUI.UIText.new(0, 0, 11.5, 338.5, 0, 0, 272, 299)
	ObjectiveLine1:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_90A6F20B1D56111"))
	ObjectiveLine1:setTTF("default")
	ObjectiveLine1:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	ObjectiveLine1:setShaderVector(0, 0.32, 0, 0, 0)
	ObjectiveLine1:setShaderVector(1, 0, 0, 0, 1)
	ObjectiveLine1:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ObjectiveLine1:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ObjectiveLine1)
	self.ObjectiveLine1 = ObjectiveLine1
	local ActiveObjective = LUI.UIText.new(0, 0, 9, 341, 0, 0, 88, 124)
	ActiveObjective:setRGB(0.22, 0.74, 0.98)
	ActiveObjective:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_90A6F20B1D56111"))
	ActiveObjective:setTTF("default")
	ActiveObjective:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	ActiveObjective:setShaderVector(0, 0.32, 0, 0, 0)
	ActiveObjective:setShaderVector(1, 0, 0, 0, 1)
	ActiveObjective:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ActiveObjective:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ActiveObjective)
	self.ActiveObjective = ActiveObjective
	local Title = LUI.UIText.new(0, 0, 0, 350, 0, 0, 21.5, 57.5)
	Title:setRGB(0.96, 0.66, 0)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_63AD31A410C002E4"))
	Title:setTTF("default")
	Title:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	Title:setShaderVector(0, 0.32, 0, 0, 0)
	Title:setShaderVector(1, 0, 0, 0, 1)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title)
	self.Title = Title
	local Title2 = LUI.UIText.new(0, 0, 0, 350, 0, 0, 202, 238)
	Title2:setRGB(0.96, 0.66, 0)
	Title2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7602F8411E91A98F"))
	Title2:setTTF("default")
	Title2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	Title2:setShaderVector(0, 0.32, 0, 0, 0)
	Title2:setShaderVector(1, 0, 0, 0, 1)
	Title2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Title2)
	self.Title2 = Title2
	local Underline2 = LUI.UIImage.new(0, 0, 23.5, 326.5, 0, 0, 63, 71)
	Underline2:setRGB(0, 0, 0)
	self:addElement(Underline2)
	self.Underline2 = Underline2
	local Underline4 = LUI.UIImage.new(0, 0, 19.5, 322.5, 0, 0, 246, 254)
	Underline4:setRGB(0, 0, 0)
	self:addElement(Underline4)
	self.Underline4 = Underline4
	local Underline = LUI.UIImage.new(0, 0, 25.5, 324.5, 0, 0, 65, 69)
	Underline:setRGB(0.96, 0.66, 0)
	self:addElement(Underline)
	self.Underline = Underline
	local Underline3 = LUI.UIImage.new(0, 0, 21.5, 320.5, 0, 0, 248, 252)
	Underline3:setRGB(0.96, 0.66, 0)
	self:addElement(Underline3)
	self.Underline3 = Underline3
	local Strikethrough1 = LUI.UIImage.new(0, 0, 14, 341, 0, 0, 285.5, 288.5)
	Strikethrough1:setAlpha(0)
	self:addElement(Strikethrough1)
	self.Strikethrough1 = Strikethrough1
	local Strikethrough3 = LUI.UIImage.new(0, 0, 14, 341, 0, 0, 445.5, 448.5)
	Strikethrough3:setAlpha(0)
	self:addElement(Strikethrough3)
	self.Strikethrough3 = Strikethrough3
	local Strikethrough2 = LUI.UIImage.new(0, 0, 14, 341, 0, 0, 361.5, 364.5)
	Strikethrough2:setAlpha(0)
	self:addElement(Strikethrough2)
	self.Strikethrough2 = Strikethrough2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ObjectiveLog.__resetProperties = function(f2_arg0)
	f2_arg0.ObjectiveLine1:completeAnimation()
	f2_arg0.ObjectiveLine2:completeAnimation()
	f2_arg0.ObjectiveLine3:completeAnimation()
	f2_arg0.ObjectiveLine1:setRGB(1, 1, 1)
	f2_arg0.ObjectiveLine2:setRGB(1, 1, 1)
	f2_arg0.ObjectiveLine3:setRGB(1, 1, 1)
end
CoD.ObjectiveLog.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Line1Complete = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.ObjectiveLine1:completeAnimation()
			f4_arg0.ObjectiveLine1:setRGB(0.21, 0.21, 0.21)
			f4_arg0.clipFinished(f4_arg0.ObjectiveLine1)
			f4_arg0.nextClip = "DefaultClip"
		end,
	},
	Line2Complete = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.ObjectiveLine2:completeAnimation()
			f5_arg0.ObjectiveLine2:setRGB(0.21, 0.21, 0.21)
			f5_arg0.clipFinished(f5_arg0.ObjectiveLine2)
		end,
	},
	Line3Complete = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ObjectiveLine3:completeAnimation()
			f6_arg0.ObjectiveLine3:setRGB(0.21, 0.21, 0.21)
			f6_arg0.clipFinished(f6_arg0.ObjectiveLine3)
		end,
	},
}
