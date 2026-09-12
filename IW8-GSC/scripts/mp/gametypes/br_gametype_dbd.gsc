/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_dbd.gsc
****************************************************/

function init() {
  setDvar("scr_br_altprematchloadout", "classtable_brdbd_prematch");
  scripts\mp\gametypes\br_gametypes::ref_12b11("modifyPlayerDamage", &modifyplayerdamage);
  scripts\mp\gametypes\br_gametypes::ref_12b11("regenHealthAdd", &ref_1264b);
  scripts\mp\gametypes\br_gametypes::ref_12b11("postMainInit", &ref_12803);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &ref_12604);

  if(getdvarint("scr_br_dbd_vehicle_littlebird", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("littleBirdSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_truck", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("truckSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_jeep", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("jeepSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_tacrover", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("tacRoverSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_atv", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("atvSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_motorcycle", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("motorcycleSpawns");
  }

  level.ref_11c95 = &ref_11c95;
  level.disable_super_in_turret.iscodecorrect = getdvarint("scr_br_dbd_hsdowndistance", 3550);
  level.disable_super_in_turret.iscontender = getdvarint("scr_br_dbd_healthregenrate", 1);
  level.disable_super_in_turret.iscloseto = getdvarfloat("scr_br_dbd_gasdamagesclar", 2.5);
  level.disable_super_in_turret.iscrossbowbolt = getdvarint("scr_br_dbd_stimregenscalar", 4);
  level.disable_super_in_turret.iscopiedclass = getdvarint("scr_br_dbd_nononeshotsnprdmg", 275);
  level.disable_super_in_turret.currentuniversalhp = getdvarint("scr_br_universal_hp_reference", 300);
  level.disable_super_in_turret.dbdfixedsniperhsdistdmg = getdvarint("scr_br_dbd_fixed_snpr_hs_dist_dmg", 0);
}

function ref_12803() {
  if(getdvarint("scr_dbd_fall_height_modifier_enable", 1) == 0) {
    return;
  }

  setDvar("NKTQRKRMTS", getdvarint("scr_br_dbd_fallheightmin", 1120));
  setDvar("LKMOLLSKKO", getdvarint("scr_br_dbd_fallheightmax", 1121));
  setDvar("OMLLLQKQSR", getdvarint("scr_br_dbd_fallheightmin", 1120));
  setDvar("LTMMLKRKTR", getdvarint("scr_br_dbd_fallheightmax", 1121));
}

function modifyplayerdamage(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0.objweapon);

  if(var_0.objweapon.classname == "sniper" && (var_0.shitloc == "head" || var_0.shitloc == "helmet") && !usefailvehiclemsg(var_1)) {
    var_2 = var_0.attacker;
    var_3 = var_0.victim;
    var_4 = var_3.br_maxarmorhealth + var_3.maxhealth;
    var_5 = distancesquared(var_2.origin, var_3.origin);

    if(level.br_sniper_fixed_hs_damage == 0 && var_0.damage >= level.disable_super_in_turret.currentuniversalhp && var_5 < level.disable_super_in_turret.iscodecorrect * level.disable_super_in_turret.iscodecorrect) {
      return var_4;
    }

    if(level.disable_super_in_turret.dbdfixedsniperhsdistdmg == 1 && var_5 < level.disable_super_in_turret.iscodecorrect * level.disable_super_in_turret.iscodecorrect) {
      if(!istrue(var_3.isjuggernaut)) {
        return var_4;
      } else {
        return (var_3.br_maxarmorhealth + var_3.juggcontext.prevmaxhealth);
      }
    } else {
      return max(level.disable_super_in_turret.iscopiedclass, var_0.damage);
    }
  }

  return var_0.damage;
}

function usefailvehiclemsg(var_0) {
  return var_0 == "iw8_sn_delta" || var_0 == "iw8_sn_golf28" || var_0 == "iw8_sn_mike14" || var_0 == "iw8_sn_sbeta" || var_0 == "iw8_sn_sksierra" || var_0 == "s4_mr_gecho43" || var_0 == "s4_mr_m1golf" || var_0 == "s4_mr_svictor40" || var_0 == "s4_mr_malpha1916";
}

function ref_1264b(var_0) {
  if(istrue(self.adrenalinepoweractive)) {
    return int(level.disable_super_in_turret.iscontender * level.disable_super_in_turret.iscrossbowbolt);
  }

  return int(level.disable_super_in_turret.iscontender);
}

function ref_11c95(var_0) {
  return int(var_0 * level.disable_super_in_turret.iscloseto);
}

function ref_12604() {
  scripts\mp\gametypes\br::searchcircleorigin(0, 1, 0);
}