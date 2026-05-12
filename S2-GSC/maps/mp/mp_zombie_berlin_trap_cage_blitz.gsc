/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_berlin_trap_cage_blitz.gsc
********************************************************/

trap_cage_blitz(param_00) {
  var_01 = 20;
  var_02 = common_scripts\utility::func_46B5("struct_trap_cage_blitz", "script_noteworthy");
  var_03 = common_scripts\utility::func_46B5("cage_spark_fx_trap", "script_noteworthy");
  var_03 thread trap_cage_idle_spark();
  var_04 = getent("cage_damage", "script_noteworthy");
  var_04.var_9C92 = param_00;
  var_04.var_9CBB = "trap_cage_blitz";
  wait(0.3);
  var_02 thread trap_cage_do_damage(var_04);
  var_05 = common_scripts\utility::func_46B7("cage_shock_fx_trap", "script_noteworthy");
  var_06 = common_scripts\utility::func_46B7("cage_current_fx_trap", "script_noteworthy");
  lib_0378::func_8D74("start_trap_cage", 1, var_01);
  foreach(var_08 in var_05) {
    var_08 thread trap_cage_arcs();
  }

  foreach(var_08 in var_06) {
    var_08 thread trap_cage_current();
  }

  wait(var_01);
  foreach(var_08 in var_05) {
    var_08 notify("stop_fx");
  }

  foreach(var_08 in var_06) {
    var_08 notify("stop_fx");
  }

  lib_0378::func_8D74("stop_trap_cage");
  wait 0.05;
  var_02 notify("stop_damage");
  wait(0.5);
  wait(1);
}

trap_cage_do_damage(param_00) {
  self endon("stop_damage");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(isPlayer(var_01)) {
      var_01 dodamage(15, self.var_116, param_00, param_00, "MOD_EXPLOSIVE", "trap_zm_mp");
      var_01 lib_0378::func_8D74("trap_cage_damage");
    } else {
      var_01 maps\mp\zombies\_zombies_traps::mark_electrified();
      var_01 dodamage(var_01.var_BC + 666, self.var_116, param_00, param_00, "MOD_EXPLOSIVE", "trap_zm_mp");
      var_01 lib_0378::func_8D74("trap_cage_damage");
      playFX(common_scripts\utility::func_44F5("tesla_stun_sparks"), self.var_116);
    }

    wait(0.5);
  }
}

trap_cage_arcs() {
  self endon("stop_fx");
  for(;;) {
    level thread common_scripts\_exploder::func_88E(202);
    wait(randomfloatrange(0.4, 0.7));
  }
}

trap_cage_current() {
  self endon("stop_fx");
  for(;;) {
    playFX(level.var_611["cage_trap_current"], self.var_116);
    wait(randomfloatrange(0.2, 0.5));
  }
}

trap_cage_idle_spark() {
  common_scripts\utility::func_3C87("flag_trap_on");
  for(;;) {
    while(!common_scripts\utility::func_3C77("flag_trap_on")) {
      wait(randomfloatrange(3, 5));
      playFX(level.var_611["tank_trap_sparks"], self.var_116);
    }

    wait(1);
  }
}