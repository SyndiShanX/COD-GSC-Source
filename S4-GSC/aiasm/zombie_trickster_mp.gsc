/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: aiasm\zombie_trickster_mp.gsc
*************************************************/

_id_1C99() {
  if(!isDefined(anim._id_1CB7)) {
    anim._id_1CB7 = [];
  }

  if(isDefined(anim._id_1CB7["zombie_trickster"])) {
    return;
  }
  anim._id_1CB7["zombie_trickster"] = [];
  anim._id_1CB7["zombie_trickster"][0] = ::scripts\asm\zombie_trickster\asm_trickster::zombietrickster_init;
  anim._id_1CB7["zombie_trickster"][1] = _id_08F1::_id_982D;
  anim._id_1CB7["zombie_trickster"][2] = _id_0909::_id_1107A;
  anim._id_1CB7["zombie_trickster"][3] = _id_0AEC::_id_35AB;
  anim._id_1CB7["zombie_trickster"][4] = _id_0909::_id_1107C;
  anim._id_1CB7["zombie_trickster"][5] = _id_0909::_id_11064;
  anim._id_1CB7["zombie_trickster"][6] = _id_0AEC::_id_B8D4;
  anim._id_1CB7["zombie_trickster"][7] = _id_0AEC::_id_361F;
  anim._id_1CB7["zombie_trickster"][8] = _id_0AEC::_id_D9BA;
  anim._id_1CB7["zombie_trickster"][9] = _id_0909::_id_11079;
  anim._id_1CB7["zombie_trickster"][10] = _id_0AEB::_id_35A5;
  anim._id_1CB7["zombie_trickster"][11] = ::scripts\asm\zombie\move::_id_B89F;
  anim._id_1CB7["zombie_trickster"][12] = ::scripts\asm\zombie\move::_id_E9F6;
  anim._id_1CB7["zombie_trickster"][13] = ::scripts\asm\zombie\move::_id_B33B;
  anim._id_1CB7["zombie_trickster"][14] = ::scripts\asm\zombie\move::_id_35BB;
  anim._id_1CB7["zombie_trickster"][15] = ::scripts\asm\zombie\move::_id_5B12;
  anim._id_1CB7["zombie_trickster"][16] = _id_0AEC::_id_DB40;
  anim._id_1CB7["zombie_trickster"][17] = _id_0909::_id_A23D;
  anim._id_1CB7["zombie_trickster"][18] = _id_0909::_id_A415;
  anim._id_1CB7["zombie_trickster"][19] = _id_0909::_id_8B1E;
  anim._id_1CB7["zombie_trickster"][20] = _id_0909::_id_DBE9;
  anim._id_1CB7["zombie_trickster"][21] = _id_0909::_id_A413;
  anim._id_1CB7["zombie_trickster"][22] = _id_0909::needstowander;
  anim._id_1CB7["zombie_trickster"][23] = ::scripts\asm\zombie\move::scriptshouldstrafestart;
  anim._id_1CB7["zombie_trickster"][24] = _id_0909::needstosupersprint;
  anim._id_1CB7["zombie_trickster"][25] = _id_0906::_id_B383;
  anim._id_1CB7["zombie_trickster"][26] = _id_0906::_id_3630;
  anim._id_1CB7["zombie_trickster"][27] = _id_0909::_id_B910;
  anim._id_1CB7["zombie_trickster"][28] = _id_0909::_id_3638;
  anim._id_1CB7["zombie_trickster"][29] = _id_0909::_id_B90E;
  anim._id_1CB7["zombie_trickster"][30] = _id_0909::_id_1107D;
  anim._id_1CB7["zombie_trickster"][31] = ::scripts\asm\zombie_trickster\asm_trickster::choosebreakmaskanim;
  anim._id_1CB7["zombie_trickster"][32] = ::scripts\asm\zombie_trickster\asm_trickster::breakmaskterminate;
  anim._id_1CB7["zombie_trickster"][33] = _id_0909::_id_B919;
  anim._id_1CB7["zombie_trickster"][34] = _id_0909::_id_362C;
  anim._id_1CB7["zombie_trickster"][35] = _id_0909::_id_F0A0;
  anim._id_1CB7["zombie_trickster"][36] = _id_0909::_id_B8F5;
  anim._id_1CB7["zombie_trickster"][37] = _id_0909::_id_362A;
  anim._id_1CB7["zombie_trickster"][38] = _id_08F1::_id_18CB;
  anim._id_1CB7["zombie_trickster"][39] = _id_08F1::_id_18CD;
  anim._id_1CB7["zombie_trickster"][40] = ::scripts\asm\zombie_trickster\asm_trickster::zombietrickster_shouldattack;
  anim._id_1CB7["zombie_trickster"][41] = ::_id_1F27;
  anim._id_1CB7["zombie_trickster"][42] = ::_id_1F28;
  anim._id_1CB7["zombie_trickster"][43] = ::_id_1F33;
  anim._id_1CB7["zombie_trickster"][44] = ::_id_1F3E;
  anim._id_1CB7["zombie_trickster"][45] = _id_0909::_id_DB88;
  anim._id_1CB7["zombie_trickster"][46] = _id_08F1::_id_DB7D;
  anim._id_1CB7["zombie_trickster"][47] = ::scripts\asm\zombie_trickster\asm_trickster::zombietrickster_shouldfastattack;
}

_id_1F27(var_0, var_1, var_2, var_3) {
  return self._id_7596;
}

_id_1F28(var_0, var_1, var_2, var_3) {
  return _id_0909::_id_A410();
}

_id_1F33(var_0, var_1, var_2, var_3) {
  return _id_0909::_id_A40F();
}

_id_1F3E(var_0, var_1, var_2, var_3) {
  return self._id_7598;
}