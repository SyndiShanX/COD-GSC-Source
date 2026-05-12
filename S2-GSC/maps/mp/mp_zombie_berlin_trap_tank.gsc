/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_berlin_trap_tank.gsc
**************************************************/

trap_tank(param_00) {
  var_01 = 20;
  var_02 = common_scripts\utility::func_46B7("puddle_shock_fx_trap", "script_noteworthy");
  var_03 = common_scripts\utility::func_46B7("puddle_current_fx_trap", "script_noteworthy");
  foreach(var_05 in var_02) {
    var_05 thread trap_puddle_arcs();
  }

  foreach(var_05 in var_03) {
    var_05 thread trap_puddle_current();
  }

  lib_0378::func_8D74("start_trap_tank", 1, var_01);
  var_09 = getent("puddle_damage", "script_noteworthy");
  var_09.var_9C92 = param_00;
  var_09.var_9CBB = "trap_tank";
  wait(0.3);
  var_09 thread do_damage(var_09);
  wait(var_01);
  foreach(var_05 in var_02) {
    var_05 notify("stop_fx");
  }

  foreach(var_05 in var_03) {
    var_05 notify("stop_fx");
  }

  lib_0378::func_8D74("stop_trap_tank");
  var_09 notify("stop_damage");
  wait(0.5);
  wait(1);
}

do_damage(param_00) {
  self endon("stop_damage");
  for(;;) {
    param_00 waittill("trigger", var_01);
    if(isPlayer(var_01)) {
      var_01 dodamage(15, self.var_116, param_00, param_00, "MOD_EXPLOSIVE", "trap_zm_mp");
    } else {
      var_01 maps\mp\zombies\_zombies_traps::mark_electrified();
      var_01 dodamage(var_01.var_BC + 666, self.var_116, param_00, param_00, "MOD_EXPLOSIVE", "trap_zm_mp");
      var_01 lib_0378::func_8D74("trap_tank_damage");
    }

    wait(0.5);
  }
}

spin() {}

trap_puddle_arcs() {
  self endon("stop_fx");
  wait(randomfloatrange(0.4, 0.7));
}

trap_puddle_current() {
  self endon("stop_fx");
  for(;;) {
    playFX(level.var_611["cage_trap_current"], self.var_116);
    wait(randomfloatrange(0.2, 0.5));
  }
}