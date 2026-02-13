/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2470.gsc
*************************************************/

_id_11F4() {
  if(isDefined(anim._id_A65C)) {
    return;
  }
  anim._id_A65C = 1;
  scripts\anim\shared::_id_8137();
  scripts\anim\shared::_id_812A();
  scripts\anim\shared::_id_821E();
  scripts\anim\shared::_id_82BD();
  scripts\anim\shared::_id_8179();
  scripts\anim\shared::_id_D8A9();
  scripts\anim\shared::_id_80C0();
  _id_D878();
  _id_8130();
  _id_829F();
  scripts\anim\face::_id_820D();
  _id_0786::_id_102EC();
}

_id_D878() {
  anim._id_7184["AI_frag_grenade_mp"] = randomintrange(0, 20000);
  anim._id_7184["AI_flash_grenade_mp"] = randomintrange(0, 20000);
  anim._id_7184["AI_smoke_grenade_mp"] = randomintrange(0, 20000);
  anim._id_7184["AI_concussion_grenade_mp"] = randomintrange(5000, 20000);
  anim._id_7184["AI_splash_grenade_mp"] = randomintrange(5000, 20000);
  anim._id_7184["AI_molotov_mp"] = randomintrange(5000, 20000);
  anim._id_7184["AI_semtex_mp"] = randomintrange(5000, 20000);
  anim._id_7184["AI_gas_mp"] = randomintrange(5000, 20000);
}

_id_8130() {
  if(!isDefined(anim._id_2F52)) {
    anim._id_2F52 = [];
  }

  anim._id_2F52["PlaySoundAtViewHeight"] = ::_id_B2D9;
}

_id_B2D9(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!_func_0205(var_0)) {
    return;
  }
  self _meth_827E(var_0);

  if(isDefined(var_1)) {
    wait(_func_0142(var_0) / 1000);
    self notify(var_1);
  }
}

_id_829F() {
  level._id_E801 = ::_id_82A2;
}

_id_6985() {
  return [];
}

_id_D4E6() {}

_id_82A2() {
  level._id_5D87 = ::_id_6985;
  level._id_5DBB = ::_id_D4E6;
}