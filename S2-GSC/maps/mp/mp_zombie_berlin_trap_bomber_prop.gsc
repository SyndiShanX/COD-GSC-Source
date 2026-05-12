/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_berlin_trap_bomber_prop.gsc
*********************************************************/

trap_bomber_prop(param_00) {
  var_01 = getent("zmb_trap_bomber_engine_mdl", "script_noteworthy");
  var_02 = getent("propeller_center_fx_trap", "script_noteworthy");
  var_01 lib_0378::func_8D74("start_trap_prop", 0.5);
  var_03 = getent("propeller_damage", "script_noteworthy");
  var_03.var_9C92 = param_00;
  var_03.var_9CBB = "trap_bomber_prop";
  wait(0.3);
  var_02 thread do_damage_propeller(var_03, var_02);
  var_02 thread do_ground_blood(var_03, var_01);
  var_02 spin_propeller(var_01);
  var_02 notify("stop_damage");
  var_01 lib_0378::func_8D74("stop_trap_prop");
  wait(0.5);
  wait(1);
}

do_damage_propeller(param_00, param_01) {
  self endon("stop_damage");
  for(;;) {
    param_00 waittill("trigger", var_02);
    if(isPlayer(var_02)) {
      var_02 dodamage(10, self.var_116, param_00, param_00, "MOD_EXPLOSIVE", "trap_zm_mp");
    } else {
      var_02 toss_ragdoll(param_01, param_00);
      param_00 lib_0378::func_8D74("trap_prop_damage");
    }

    wait(0.4);
  }
}

do_ground_blood(param_00, param_01) {
  self endon("stop_damage");
  for(;;) {
    param_00 waittill("trigger", var_02);
    if(isPlayer(var_02)) {
      wait 0.05;
      continue;
    }

    level thread common_scripts\_exploder::func_88E(205);
    var_03 = spawnlinkedfx(level.var_611["zmb_ber_prop_trap_grit"], param_01, "Tag_Origin");
    triggerfx(var_03);
    wait(10);
    var_03 delete();
  }
}

toss_ragdoll(param_00, param_01) {
  var_02 = self gettagorigin("J_Head");
  var_03 = vectornormalize(var_02 - param_00.var_116);
  var_04 = ["head", "neck"];
  var_05 = common_scripts\utility::func_7A33(var_04);
  lib_0547::func_5A85(var_05, 500 * var_03, param_01, "trap_zm_mp");
  var_06 = spawnfx(level.var_611["zmb_ber_blood_impact_prop"], var_02, var_03);
  triggerfx(var_06);
  wait(0.2);
  var_06 delete();
}

spin_propeller(param_00) {
  var_01 = spawnlinkedfx(level.var_611["zmb_ber_prop_trap_spin"], param_00, "prop");
  triggerfx(var_01);
  level thread common_scripts\_exploder::func_88E(203);
  param_00 scriptmodelplayanim("s2_zom_propeller_01_start");
  wait(getanimlength(%s2_zom_propeller_01_start));
  param_00 scriptmodelplayanim("s2_zom_propeller_01_loop");
  wait(19);
  param_00 scriptmodelplayanim("s2_zom_propeller_01_end");
  level thread common_scripts\_exploder::func_2A6D(203, undefined, 0);
  var_01 delete();
}