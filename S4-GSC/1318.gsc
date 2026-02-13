/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1318.gsc
*************************************************/

_id_1C99() {
  if(!isDefined(anim._id_1CB7)) {
    anim._id_1CB7 = [];
  }

  if(isDefined(anim._id_1CB7["zombie_screamer"])) {
    return;
  }
  anim._id_1CB7["zombie_screamer"] = [];
  anim._id_1CB7["zombie_screamer"][0] = _id_090A::_id_1108B;
  anim._id_1CB7["zombie_screamer"][1] = _id_0909::_id_1107C;
  anim._id_1CB7["zombie_screamer"][2] = _id_0909::_id_11064;
  anim._id_1CB7["zombie_screamer"][3] = _id_090A::_id_B34D;
  anim._id_1CB7["zombie_screamer"][4] = _id_0906::_id_3630;
  anim._id_1CB7["zombie_screamer"][5] = _id_0909::_id_1107E;
  anim._id_1CB7["zombie_screamer"][6] = _id_0909::_id_11065;
  anim._id_1CB7["zombie_screamer"][7] = _id_090A::_id_B32D;
  anim._id_1CB7["zombie_screamer"][8] = _id_08F1::_id_18CB;
  anim._id_1CB7["zombie_screamer"][9] = _id_08F1::_id_18CD;
  anim._id_1CB7["zombie_screamer"][10] = _id_0AEC::_id_B8D4;
  anim._id_1CB7["zombie_screamer"][11] = _id_0AEC::_id_361F;
  anim._id_1CB7["zombie_screamer"][12] = _id_0AEC::_id_D9BA;
  anim._id_1CB7["zombie_screamer"][13] = _id_0909::_id_B910;
  anim._id_1CB7["zombie_screamer"][14] = _id_0909::_id_3638;
  anim._id_1CB7["zombie_screamer"][15] = _id_0909::_id_B90E;
  anim._id_1CB7["zombie_screamer"][16] = ::scripts\asm\zombie_common\stun::choosestunanim;
  anim._id_1CB7["zombie_screamer"][17] = ::scripts\asm\zombie_common\stun::_id_8A6C;
  anim._id_1CB7["zombie_screamer"][18] = ::scripts\asm\zombie_common\push::chooseknockdownanim;
  anim._id_1CB7["zombie_screamer"][19] = ::scripts\asm\zombie_common\push::knockdownterminate;
  anim._id_1CB7["zombie_screamer"][20] = _id_0909::_id_1107A;
  anim._id_1CB7["zombie_screamer"][21] = _id_0AEC::_id_35AB;
  anim._id_1CB7["zombie_screamer"][22] = _id_0909::_id_11079;
  anim._id_1CB7["zombie_screamer"][23] = _id_0AEB::_id_35A5;
  anim._id_1CB7["zombie_screamer"][24] = _id_0909::playstumbleanim;
  anim._id_1CB7["zombie_screamer"][25] = _id_0909::choosestumbleanim;
  anim._id_1CB7["zombie_screamer"][26] = _id_0909::_id_B919;
  anim._id_1CB7["zombie_screamer"][27] = _id_0909::_id_362C;
  anim._id_1CB7["zombie_screamer"][28] = _id_0909::_id_F0A0;
  anim._id_1CB7["zombie_screamer"][29] = _id_0909::_id_B8F5;
  anim._id_1CB7["zombie_screamer"][30] = _id_0909::_id_362A;
  anim._id_1CB7["zombie_screamer"][31] = _id_090A::_id_DB56;
  anim._id_1CB7["zombie_screamer"][32] = _id_08F1::_id_DB7D;
  anim._id_1CB7["zombie_screamer"][33] = _id_0AEC::_id_DB40;
  anim._id_1CB7["zombie_screamer"][34] = _id_0909::_id_A23D;
  anim._id_1CB7["zombie_screamer"][35] = _id_0909::needstowander;
  anim._id_1CB7["zombie_screamer"][36] = _id_0909::_id_DBE9;
  anim._id_1CB7["zombie_screamer"][37] = _id_0909::_id_8B1E;
  anim._id_1CB7["zombie_screamer"][38] = _id_0909::_id_DBF6;
  anim._id_1CB7["zombie_screamer"][39] = ::_id_1F27;
  anim._id_1CB7["zombie_screamer"][40] = ::_id_1F28;
  anim._id_1CB7["zombie_screamer"][41] = ::_id_1F33;
  anim._id_1CB7["zombie_screamer"][42] = ::_id_1F3E;
}

_id_1F27(var_0, var_1, var_2, var_3) {
  return self._id_7598;
}

_id_1F28(var_0, var_1, var_2, var_3) {
  return _id_0909::_id_A410();
}

_id_1F33(var_0, var_1, var_2, var_3) {
  return _id_0909::_id_A40F();
}

_id_1F3E(var_0, var_1, var_2, var_3) {
  return self._id_7596;
}