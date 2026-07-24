/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\shared\mp\move_v2.gsc
*********************************************/

waitforsharpturnv2(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self waittill("path_dir_change", var_3);
  var_4 = [var_3, 0];
  scripts\asm\asm::asm_fireevent(var_1, "sharp_turn", var_4);
  thread _id_0F3C::_id_136E7(var_0, var_1, var_2);
}

playmoveloopv2(var_0, var_1, var_2, var_3) {
  thread _id_0F3C::_id_136B4(var_0, var_1, var_3);
  thread waitforsharpturnv2(var_0, var_1, var_3);
  thread _id_0F3C::_id_136CC(var_0, var_1, var_3);
  var_4 = 1.0;

  if(isDefined(self.asm.moveplaybackrate)) {
    var_4 = self.asm.moveplaybackrate;
  } else if(isDefined(self.moveplaybackrate)) {
    var_4 = self.moveplaybackrate;
  }

  scripts\asm\asm_mp::_id_235F(var_0, var_1, var_2, var_4);
}

playsharpturnanimv2(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm_mp::asm_getanim(var_0, var_1);
  self._id_FC61 = undefined;
  self _meth_8281("anim deltas");
  self orientmode("face angle abs", self.angles);
  var_5 = scripts\asm\asm::_id_2341(var_0, var_1);

  if(isDefined(self.moveplaybackrate)) {
    scripts\anim\notetracks_mp::_id_CED2(var_1, var_4, self.moveplaybackrate, var_1, "code_move", var_5);
  } else {
    scripts\anim\notetracks_mp::_id_CED5(var_1, var_4, var_1, "code_move", var_5);
  }

  self orientmode("face motion");
  self _meth_8281("code_move");
}