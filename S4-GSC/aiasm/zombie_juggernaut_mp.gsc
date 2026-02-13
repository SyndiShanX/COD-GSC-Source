/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: aiasm\zombie_juggernaut_mp.gsc
*************************************************/

_id_1C99() {
  if(!isDefined(anim._id_1CB7)) {
    anim._id_1CB7 = [];
  }

  if(isDefined(anim._id_1CB7["zombie_juggernaut"])) {
    return;
  }
  anim._id_1CB7["zombie_juggernaut"] = [];
  anim._id_1CB7["zombie_juggernaut"][0] = ::scripts\asm\zombie_juggernaut\zombie_juggernaut::zombiejuggernaut;
  anim._id_1CB7["zombie_juggernaut"][1] = _id_0909::_id_B919;
  anim._id_1CB7["zombie_juggernaut"][2] = _id_0909::_id_362C;
  anim._id_1CB7["zombie_juggernaut"][3] = _id_0909::_id_F0A0;
  anim._id_1CB7["zombie_juggernaut"][4] = _id_0909::_id_B8F5;
  anim._id_1CB7["zombie_juggernaut"][5] = _id_0909::_id_362A;
  anim._id_1CB7["zombie_juggernaut"][6] = _id_0900::_id_B830;
  anim._id_1CB7["zombie_juggernaut"][7] = _id_0900::_id_35C9;
  anim._id_1CB7["zombie_juggernaut"][8] = _id_0900::_id_F098;
  anim._id_1CB7["zombie_juggernaut"][9] = _id_0906::_id_B383;
  anim._id_1CB7["zombie_juggernaut"][10] = _id_0906::_id_3630;
  anim._id_1CB7["zombie_juggernaut"][11] = _id_0906::_id_3606;
  anim._id_1CB7["zombie_juggernaut"][12] = _id_0909::_id_1107D;
  anim._id_1CB7["zombie_juggernaut"][13] = _id_0909::_id_11065;
  anim._id_1CB7["zombie_juggernaut"][14] = _id_0909::_id_A413;
  anim._id_1CB7["zombie_juggernaut"][15] = _id_0909::_id_A412;
  anim._id_1CB7["zombie_juggernaut"][16] = _id_0909::_id_1107C;
  anim._id_1CB7["zombie_juggernaut"][17] = _id_0909::_id_11064;
  anim._id_1CB7["zombie_juggernaut"][18] = _id_0909::_id_1107A;
  anim._id_1CB7["zombie_juggernaut"][19] = _id_0AEC::_id_35AB;
  anim._id_1CB7["zombie_juggernaut"][20] = _id_0909::_id_11079;
  anim._id_1CB7["zombie_juggernaut"][21] = _id_0AEB::_id_35A5;
  anim._id_1CB7["zombie_juggernaut"][22] = _id_0909::_id_1107F;
  anim._id_1CB7["zombie_juggernaut"][23] = _id_0AEC::_id_361F;
  anim._id_1CB7["zombie_juggernaut"][24] = ::scripts\asm\zombie\move::_id_B89F;
  anim._id_1CB7["zombie_juggernaut"][25] = ::scripts\asm\zombie\move::_id_E9F6;
  anim._id_1CB7["zombie_juggernaut"][26] = ::scripts\asm\zombie\move::_id_B340;
  anim._id_1CB7["zombie_juggernaut"][27] = ::scripts\asm\zombie\move::_id_B33E;
  anim._id_1CB7["zombie_juggernaut"][28] = ::scripts\asm\zombie\move::_id_E9F8;
  anim._id_1CB7["zombie_juggernaut"][29] = ::scripts\asm\zombie\move::_id_B33C;
  anim._id_1CB7["zombie_juggernaut"][30] = ::scripts\asm\zombie\move::_id_35BC;
  anim._id_1CB7["zombie_juggernaut"][31] = ::scripts\asm\zombie\move::_id_B33D;
  anim._id_1CB7["zombie_juggernaut"][32] = ::scripts\asm\zombie\move::_id_B33B;
  anim._id_1CB7["zombie_juggernaut"][33] = ::scripts\asm\zombie\move::_id_35BB;
  anim._id_1CB7["zombie_juggernaut"][34] = ::scripts\asm\zombie\move::_id_5B12;
  anim._id_1CB7["zombie_juggernaut"][35] = _id_0AEC::_id_B8D4;
  anim._id_1CB7["zombie_juggernaut"][36] = _id_0AEC::_id_D9BA;
  anim._id_1CB7["zombie_juggernaut"][37] = _id_0909::_id_A415;
  anim._id_1CB7["zombie_juggernaut"][38] = _id_0909::_id_DBE9;
  anim._id_1CB7["zombie_juggernaut"][39] = _id_0AEC::_id_DB40;
  anim._id_1CB7["zombie_juggernaut"][40] = _id_0909::_id_8B1E;
  anim._id_1CB7["zombie_juggernaut"][41] = _id_0908::_id_109CE;
  anim._id_1CB7["zombie_juggernaut"][42] = _id_0909::_id_A23D;
  anim._id_1CB7["zombie_juggernaut"][43] = ::scripts\asm\zombie\move::scriptshouldstrafestart;
  anim._id_1CB7["zombie_juggernaut"][44] = ::scripts\asm\zombie\move::_id_DBF5;
  anim._id_1CB7["zombie_juggernaut"][45] = _id_0909::needstowander;
  anim._id_1CB7["zombie_juggernaut"][46] = _id_0908::_id_109C9;
  anim._id_1CB7["zombie_juggernaut"][47] = ::scripts\asm\zombie_juggernaut\zombie_juggernaut::wantstoshoot;
  anim._id_1CB7["zombie_juggernaut"][48] = _id_0909::_id_B910;
  anim._id_1CB7["zombie_juggernaut"][49] = _id_0909::_id_3638;
  anim._id_1CB7["zombie_juggernaut"][50] = _id_0909::_id_B90E;
  anim._id_1CB7["zombie_juggernaut"][51] = ::scripts\asm\zombie_common\stun::choosestunanim;
  anim._id_1CB7["zombie_juggernaut"][52] = ::scripts\asm\zombie_common\stun::_id_8A6C;
  anim._id_1CB7["zombie_juggernaut"][53] = _id_0908::_id_B898;
  anim._id_1CB7["zombie_juggernaut"][54] = _id_0908::_id_35D1;
  anim._id_1CB7["zombie_juggernaut"][55] = ::scripts\asm\zombie_juggernaut\zombie_juggernaut::zombiejuggernaut_meleeterminate;
  anim._id_1CB7["zombie_juggernaut"][56] = ::scripts\asm\zombie_juggernaut\zombie_juggernaut::zombiejuggernaut_windupterminate;
  anim._id_1CB7["zombie_juggernaut"][57] = ::scripts\asm\zombie_juggernaut\zombie_juggernaut::zombiejuggernaut_tauntterminate;
  anim._id_1CB7["zombie_juggernaut"][58] = ::_id_1F27;
  anim._id_1CB7["zombie_juggernaut"][59] = ::_id_1F28;
  anim._id_1CB7["zombie_juggernaut"][60] = ::_id_1F33;
  anim._id_1CB7["zombie_juggernaut"][61] = ::_id_1F3E;
  anim._id_1CB7["zombie_juggernaut"][62] = _id_0909::_id_11074;
  anim._id_1CB7["zombie_juggernaut"][63] = _id_0909::_id_A40B;
  anim._id_1CB7["zombie_juggernaut"][64] = _id_0909::_id_11076;
  anim._id_1CB7["zombie_juggernaut"][65] = ::scripts\asm\zombie_juggernaut\zombie_juggernaut::wantstotaunt;
}

_id_1F27(var_0, var_1, var_2, var_3) {
  return _id_0909::_id_A410();
}

_id_1F28(var_0, var_1, var_2, var_3) {
  return self._id_7598;
}

_id_1F33(var_0, var_1, var_2, var_3) {
  return self._id_7596;
}

_id_1F3E(var_0, var_1, var_2, var_3) {
  return _id_0909::_id_A40F();
}