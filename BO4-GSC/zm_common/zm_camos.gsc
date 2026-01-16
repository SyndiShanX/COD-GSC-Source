/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_camos.gsc
***********************************************/

#include scripts\core_common\activecamo_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_weapons;

#namespace zm_camos;

autoexec __init__system__() {
  system::register(#"zm_camos", &__init__, undefined, undefined);
}

__init__() {
  callback::on_connect(&on_connect);
  level.var_f06de157 = &function_264bcab7;
  level.var_3993dc8e = &function_4092decc;
  level.var_b219667f = 1;
}

on_connect() {
  self thread function_5ae5fabe();
}

function_79be4786(weapon) {
  weapon = function_264bcab7(weapon);
  weaponoptions = self getbuildkitweaponoptions(weapon);
  var_3ded6a21 = getcamoindex(weaponoptions);
  var_a99ac61d = getactivecamo(var_3ded6a21);

  if(!isDefined(var_a99ac61d) || var_a99ac61d == #"") {
    return;
  }

  return var_3ded6a21;
}

function_7c982eb6(weapon) {
  weapon = function_264bcab7(weapon);
  s_active_camo = function_e5ed6edb(weapon);

  if(isDefined(s_active_camo)) {
    weaponstate = s_active_camo.var_dd54a13b[weapon];

    if(isDefined(weaponstate) && isDefined(weaponstate.stagenum)) {
      return weaponstate.stagenum;
    }
  }
}

function_6f75f3d3(weapon, current_weaponoptions) {
  var_515e20e6 = zm_weapons::is_weapon_upgraded(weapon);
  weapon = function_264bcab7(weapon);

  if(self function_d0ae71bb(weapon)) {
    return getcamoindex(current_weaponoptions);
  }

  if(var_515e20e6 && isDefined(self.var_3f021416) && isDefined(self.var_3f021416[weapon])) {
    return self.var_3f021416[weapon];
  }

  if(isDefined(current_weaponoptions)) {
    return getcamoindex(current_weaponoptions);
  }
}

function_4f727cf5(weapon, weaponoptions, var_b07a5171 = 0) {
  weapon = function_264bcab7(weapon);

  if(!isDefined(weaponoptions)) {
    weaponoptions = self getbuildkitweaponoptions(weapon);
  }

  if(isDefined(weaponoptions) && self function_d0ae71bb(weapon)) {
    return getcamoindex(weaponoptions);
  }

  if(!isDefined(level.pack_a_punch_camo_index)) {
    if(isDefined(weaponoptions)) {
      return getcamoindex(weaponoptions);
    }

    return;
  }

  if(isDefined(level.pack_a_punch_camo_index_number_variants)) {
    if(!isDefined(self.var_3f021416)) {
      self.var_3f021416 = [];
    } else if(!isarray(self.var_3f021416)) {
      self.var_3f021416 = array(self.var_3f021416);
    }

    var_e5c037f4 = self.var_3f021416[weapon];

    if(var_b07a5171 && isDefined(var_e5c037f4) && var_e5c037f4 >= level.pack_a_punch_camo_index) {
      var_c44040bf = var_e5c037f4 + 1;

      if(var_c44040bf >= level.pack_a_punch_camo_index + level.pack_a_punch_camo_index_number_variants) {
        var_c44040bf = level.pack_a_punch_camo_index;
      }
    } else {
      n_offset = randomintrange(0, level.pack_a_punch_camo_index_number_variants);
      var_c44040bf = level.pack_a_punch_camo_index + n_offset;
    }

    self.var_3f021416[weapon] = var_c44040bf;
    return var_c44040bf;
  }

  return level.pack_a_punch_camo_index;
}

function_a24c564f(var_c34665fc, weapon) {
  weapon = function_264bcab7(weapon);
  self notify(var_c34665fc, {
    #weapon: weapon
  });
}

function_264bcab7(weapon) {
  if(isDefined(weapon) && weapon != level.weaponnone) {
    weapon = zm_weapons::function_93cd8e76(weapon, 1);
  }

  return weapon;
}

private function_e5ed6edb(weapon) {
  weaponoptions = self getbuildkitweaponoptions(weapon);

  if(!isDefined(self.pers) || !isDefined(self.pers[#"activecamo"])) {
    return;
  }

  var_3ded6a21 = getcamoindex(weaponoptions);
  var_a99ac61d = getactivecamo(var_3ded6a21);

  if(!isDefined(var_a99ac61d) || !isDefined(self.pers[#"activecamo"][var_a99ac61d])) {
    return;
  }

  return self.pers[#"activecamo"][var_a99ac61d];
}

private function_d0ae71bb(weapon) {
  if(isDefined(self function_79be4786(weapon))) {
    return true;
  }

  weaponoptions = self getbuildkitweaponoptions(weapon);

  if(getweaponmodelslot(weaponoptions) != 0) {
    return true;
  }

  return false;
}

function_7b29c2d2(weapon) {
  if(!isDefined(self.var_88ebd633)) {
    self.var_88ebd633 = {};
  }

  var_fcad15af = function_264bcab7(weapon);

  if(!isDefined(self.var_88ebd633.var_92177fec) || self.var_88ebd633.var_92177fec != var_fcad15af) {
    self.var_88ebd633.var_92177fec = var_fcad15af;
    self.var_88ebd633.var_d9449a3 = 0;
  }

  self.var_88ebd633.var_d9449a3++;

  if(self.var_88ebd633.var_d9449a3 >= 5) {
    self thread activecamo::function_896ac347(weapon, #"rapid_kills", 1);
    self.var_88ebd633.var_d9449a3 = 0;
    self notify(#"hash_7e9b17b054c01cb3");
    return;
  }

  if(self.var_88ebd633.var_d9449a3 == 1) {
    self thread function_160898c();
  }
}

private function_160898c() {
  self notify(#"hash_7e9b17b054c01cb3");
  self endon(#"death", #"hash_7e9b17b054c01cb3");
  wait 5;
  self.var_88ebd633.var_d9449a3 = 0;
}

function_432cf6d(weapon) {
  if(!isDefined(self.var_88ebd633)) {
    self.var_88ebd633 = {};
  }

  var_fcad15af = function_264bcab7(weapon);

  if(!isDefined(self.var_88ebd633.var_d45de2ae) || self.var_88ebd633.var_d45de2ae != var_fcad15af) {
    self.var_88ebd633.var_d45de2ae = var_fcad15af;
    self.var_88ebd633.var_bcacb3a3 = 0;
  }

  self.var_88ebd633.var_bcacb3a3++;

  if(self.var_88ebd633.var_bcacb3a3 >= 5) {
    self thread activecamo::function_896ac347(weapon, #"rapid_headshots", 1);
    self.var_88ebd633.var_bcacb3a3 = 0;
    self notify(#"hash_3dbf3a8521ba1621");
    return;
  }

  if(self.var_88ebd633.var_bcacb3a3 == 1) {
    self thread function_d01affa9();
  }
}

private function_d01affa9() {
  self notify(#"hash_3dbf3a8521ba1621");
  self endon(#"death", #"hash_3dbf3a8521ba1621");
  wait 7;
  self.var_88ebd633.var_bcacb3a3 = 0;
}

function_4092decc(weapon) {
  if(zm_weapons::is_weapon_upgraded(weapon)) {
    self activecamo::function_896ac347(weapon, #"pap_weapon_packed", 1);

    if(zm_pap_util::function_7352d8cc(weapon)) {
      self activecamo::function_896ac347(weapon, #"pap_weapon_double_packed", 1);
    }

    return;
  }

  self function_a24c564f(#"reset_pack", weapon);
}

private function_5ae5fabe() {
  if(self stats::get_stat_global(#"weapons_mastery_assault") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_assault", #"challenges", #"statvalue") >= 42) {
    self stats::function_dad108fa(#"weapons_mastery_assault", 1);
  }

  if(self stats::get_stat_global(#"hash_517bf5c8991ad97a") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_cqb", #"challenges", #"statvalue") >= 21) {
    self stats::function_dad108fa(#"hash_517bf5c8991ad97a", 1);
  }

  if(self stats::get_stat_global(#"weapons_mastery_lmg") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_lmg", #"challenges", #"statvalue") >= 28) {
    self stats::function_dad108fa(#"weapons_mastery_lmg", 1);
  }

  if(self stats::get_stat_global(#"secondary_mastery_pistol") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_pistol", #"challenges", #"statvalue") >= 28) {
    self stats::function_dad108fa(#"secondary_mastery_pistol", 1);
  }

  if(self stats::get_stat_global(#"weapons_mastery_smg") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_smg", #"challenges", #"statvalue") >= 49) {
    self stats::function_dad108fa(#"weapons_mastery_smg", 1);
  }

  if(self stats::get_stat_global(#"weapons_mastery_sniper") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_sniper", #"challenges", #"statvalue") >= 28) {
    self stats::function_dad108fa(#"weapons_mastery_sniper", 1);
  }

  if(self stats::get_stat_global(#"weapons_mastery_tactical") == 0 && self stats::get_stat(#"item_group_stats", #"weapon_tactical", #"challenges", #"statvalue") >= 28) {
    self stats::function_dad108fa(#"weapons_mastery_tactical", 1);
  }

  if(self stats::get_stat_global(#"secondary_mastery") == 4) {
    self stats::function_dad108fa(#"weapons_mastery", 1);
  }
}