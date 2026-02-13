/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1786.gsc
*************************************************/

init_achievements() {
  _id_06CB::_id_AA4A(::_id_0E6B);
}

_id_8055(var_0) {
  var_0._id_0E67 = [];
  _id_C1DC();
}

_id_C1DC() {
  _id_C1C2("ZM_DEAL_WITH_THE_DEVIL", 3, 0, undefined, undefined, ::set_progress);
  _id_C1C2("ZM_BAKERS_DOZEN", 13, get_achievement_stat("hearts_sacrificed"), undefined, undefined, ::_id_FBB8, ::_id_1D35);
  _id_C1C2("ZM_THIRST_QUENCHER", 5, 0, undefined, undefined, ::set_progress);
  _id_C1C2("ZM_COLD_AS_ICE", 10, get_achievement_stat("frost_blast_melee_kills"));
  _id_C1C2("ZM_SHOCKING_BEHAVIOUR", 10, get_achievement_stat("energy_mine_damaged_kills"));
  _id_C1C2("ZM_ESCAPE_ARTIST", 5, get_achievement_stat("low_health_aether_shroud_uses"));
  _id_C1C2("ZM_HOT_TEMPERED", 10, get_achievement_stat("ring_of_fire_kills"));
  _id_C1C2("ZM_DEATH_DEALER", 2500, get_achievement_stat("pap_3_kills"));
  _id_C1C2("ZM_GRIM_REAPER", 10000, get_achievement_stat("zombie_kills"));
}

_id_C1C2(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_3)) {
    var_3 = ::_id_4573;
  }

  if(!isDefined(var_4)) {
    var_4 = ::_id_4589;
  }

  if(!isDefined(var_5)) {
    var_5 = ::_id_FBB8;
  }

  if(!isDefined(var_6)) {
    var_6 = ::_id_5544;
  }

  var_7 = spawnStruct();
  var_7[[var_3]](var_1, var_2, var_4, var_5, var_6);
  self._id_0E67[var_0] = var_7;
}

_id_4573(var_0, var_1, var_2, var_3, var_4) {
  self._id_BD88 = var_1;
  self._id_01FA = var_0;
  self._id_DAEC = var_2;
  self.update_func = var_3;
  self._id_85DF = var_4;
  self._id_0E64 = 0;
}

_id_4589(var_0, var_1) {
  if(!var_0 _id_1A42()) {
    return 0;
  }

  return 1;
}

_id_FBB8(var_0) {
  self._id_BD88 = self._id_BD88 + var_0;
}

set_progress(var_0) {
  self._id_BD88 = var_0;
}

_id_1D35() {
  return self._id_BD88 >= self._id_01FA;
}

_id_5544() {
  return self._id_BD88 == self._id_01FA;
}

_id_857F() {
  return self._id_0E64;
}

_id_9B0C() {
  self._id_0E64 = 1;
}

_id_8704(var_0) {
  return isDefined(var_0);
}

_id_FB31(var_0, var_1, var_2) {
  var_3 = self._id_0E67[var_0];

  if(!_id_8704(var_3)) {
    return;
  }
  if(var_3 _id_857F()) {
    return;
  }
  if(var_3[[var_3._id_DAEC]](self, var_2)) {
    var_3[[var_3.update_func]](var_1);

    if(var_3[[var_3._id_85DF]]()) {
      self _meth_819A(var_0);
      var_3 _id_9B0C();
    }
  }
}

_id_FB32(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 _id_FB31(var_0, var_1);
  }
}

_id_1A42() {
  if(!isDefined(self._id_E394)) {
    return 1;
  }

  if(!isDefined(level._id_2584)) {
    return 1;
  }

  if(level._id_2584 > self._id_E394) {
    return 0;
  }

  return 1;
}

_id_D12F() {
  level._id_2584 = gettime();
}

_id_0E6B(var_0) {
  var_1 = var_0._id_50FF;

  if(!isPlayer(var_1)) {
    return;
  }
  var_1 update_achievement_stat("ZM_GRIM_REAPER", "zombie_kills", 1);

  if(var_1 _id_0774::_id_684B(var_0._id_04F6) == 3) {
    var_1 update_achievement_stat("ZM_DEATH_DEALER", "pap_3_kills", 1);
  }

  if(isDefined(var_1._id_0DF0) && var_1._id_0DF0.size > 0) {
    var_1 update_achievement_stat("ZM_HOT_TEMPERED", "ring_of_fire_kills", 1);
  }

  if(var_0._id_DE2B == "MOD_MELEE" && scripts\cp\zombies\zm_field_upgrades_frost_blast::is_slow_effect_applied()) {
    var_1 update_achievement_stat("ZM_COLD_AS_ICE", "frost_blast_melee_kills", 1);
  }

  if(istrue(self.damaged_by_energy_mine)) {
    var_1 update_achievement_stat("ZM_SHOCKING_BEHAVIOUR", "energy_mine_damaged_kills", 1);
  }
}

get_achievement_stat(var_0) {
  return scripts\cp\utility::_id_459B(self getplayerdata("cp", "zombieAchievementStats", var_0), 0);
}

set_achievement_stat(var_0, var_1) {
  self setplayerdata("cp", "zombieAchievementStats", var_0, var_1);
}

update_achievement_stat(var_0, var_1, var_2) {
  var_3 = get_achievement_stat(var_1);
  set_achievement_stat(var_1, var_3 + var_2);
  _id_FB31(var_0, var_2);
}