/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_trap_2.gsc
***********************************************/

trap_2(param_00) {
  if(isDefined(level.zmb_on_any_trap_activated)) {
    [[level.zmb_on_any_trap_activated]]();
  }

  var_01 = getEnt("zmb_trap_propeller_model", "targetname");
  var_02 = getEnt("propeller_damage", "script_noteworthy");
  var_01 lib_0378::func_8D74("sub_pen_prop_trap_extend");
  wait(0.5);
  var_01 lib_0378::func_8D74("sub_pen_prop_trap_start");
  wait(1);
  wait(0.3);
  var_01 thread spin();
  wait(2);
  var_01 thread do_grit_blood(var_02);
  var_01 thread do_damage(var_02, param_00);
  wait(18.5);
  var_01 lib_0378::func_8D74("sub_pen_prop_trap_extend");
  var_01 lib_0378::func_8D74("sub_pen_prop_trap_stop");
  wait(1.5);
  var_01 notify("stop_damage");
  wait(0.5);
  wait(1);
}

do_grit_blood(param_00) {
  self endon("stop_damage");
  for(;;) {
    param_00 waittill("trigger", var_01);
    play_propeller_blood_splatter(var_01);
    wait(1);
  }
}

play_propeller_blood_splatter(param_00) {
  var_01 = get_closest_propeller_blade(param_00);
  switch (var_01) {
    case "rotor_L":
      playFXOnTag(level._effect["zmb_isl_uboat_blood_grit"], self, "rotor_L");
      level childthread common_scripts\_exploder::func_88E(209);
      break;

    case "rotor_R":
      playFXOnTag(level._effect["zmb_isl_uboat_blood_grit"], self, "rotor_R");
      level childthread common_scripts\_exploder::func_88E(210);
      break;
  }
}

get_closest_propeller_blade(param_00) {
  var_01 = ["rotor_L", "rotor_R"];
  var_02 = [];
  foreach(var_04 in var_01) {
    var_02[var_02.size] = self gettagorigin(var_04);
  }

  var_06 = -1;
  var_07 = undefined;
  for(var_08 = 0; var_08 < var_01.size; var_08++) {
    var_09 = distance(param_00.origin, var_02[var_08]);
    if(var_06 < 0 || var_09 < var_06) {
      var_06 = var_09;
      var_07 = var_01[var_08];
    }
  }

  return var_07;
}

do_damage(param_00, param_01) {
  self endon("stop_damage");
  for(;;) {
    foreach(var_03 in common_scripts\utility::func_F73(level.players, lib_0547::func_408F())) {
      if(var_03 istouching(param_00)) {
        var_03 childthread do_propellar_damage(param_00, param_01);
      }
    }

    wait(0.15);
  }
}

do_propellar_damage(param_00, param_01) {
  var_02 = self;
  param_00.var_9C92 = param_01;
  param_00.var_9CBB = param_01.script_noteworthy;
  if(isPlayer(var_02)) {
    var_02 dodamage(var_02.health + 20, self.origin, param_00, param_00, "MOD_EXPLOSIVE", "trap_zm_mp");
    lib_0378::func_8D74("sub_pen_prop_trap_player_hit", var_02);
  } else {
    var_03 = var_02 maps / mp / mp_zombie_island_trap_1::modify_damage_to_island_zombie_types(5);
    var_02 dodamage(var_03, self.origin, param_00, param_00, "MOD_EXPLOSIVE", "trap_zm_mp");
    var_02 childthread zombie_prop_gib_effects(param_00);
  }

  lib_0378::func_8D74("sub_pen_prop_trap_hit", self.origin);
}

zombie_prop_gib_effects(param_00) {
  self endon("death");
  for(;;) {
    var_01 = lib_0547::func_408F();
    foreach(var_03 in var_01) {
      if(distance2d(var_03.origin, param_00.origin) < 105) {
        playFX(level._effect["zmb_isl_uboat_prop_blood_impact"], var_03.origin + (0, 0, 50), anglesToForward(param_00.angles));
      }
    }

    wait(0.25);
  }
}

spin() {
  var_00 = getEnt("zmb_trap_propeller_model", "targetname");
  var_00 method_8278("s2_zom_ger_u_boat_rotor_spin");
  playFXOnTag(level._effect["zmb_isl_uboat_water_prop_spin_r"], var_00, "rotor_R");
  playFXOnTag(level._effect["zmb_isl_uboat_water_prop_spin_l"], var_00, "rotor_L");
}