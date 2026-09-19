/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_berlin_trap_bomber_prop.gsc
*****************************************************************/

trap_bomber_prop(var_0) {
  var_1 = _getent("zmb_trap_bomber_engine_mdl", "script_noteworthy");
  var_2 = _getent("propeller_center_fx_trap", "script_noteworthy");
  var_1 _id_0378::_id_8D74("start_trap_prop", 0.5);
  var_3 = _getent("propeller_damage", "script_noteworthy");
  var_3._id_9C92 = var_0;
  var_3._id_9CBB = "trap_bomber_prop";
  wait 0.3;
  var_2 thread do_damage_propeller(var_3, var_2);
  var_2 thread do_ground_blood(var_3, var_1);
  var_2 spin_propeller(var_1);
  var_2 notify("stop_damage");
  var_1 _id_0378::_id_8D74("stop_trap_prop");
  wait 0.5;
  wait 1;
}

do_damage_propeller(var_0, var_1) {
  self endon("stop_damage");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2))
      var_2 dodamage(10, self.origin, var_0, var_0, "MOD_EXPLOSIVE", "trap_zm_mp");
    else {
      var_2 toss_ragdoll(var_1, var_0);
      var_0 _id_0378::_id_8D74("trap_prop_damage");
    }

    wait 0.4;
  }
}

do_ground_blood(var_0, var_1) {
  self endon("stop_damage");

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      waitframe();
      continue;
    }

    level thread common_scripts\_exploder::_id_088E(205);
    var_3 = _spawnlinkedfx(level._effect["zmb_ber_prop_trap_grit"], var_1, "Tag_Origin");
    _triggerfx(var_3);
    wait 10;
    var_3 delete();
  }
}

toss_ragdoll(var_0, var_1) {
  var_2 = self gettagorigin("J_Head");
  var_3 = vectorNormalize(var_2 - var_0.origin);
  var_4 = ["head", "neck"];
  var_5 = common_scripts\utility::random(var_4);
  _id_0547::_id_5A85(var_5, 500 * var_3, var_1, "trap_zm_mp");
  var_6 = _spawnfx(level._effect["zmb_ber_blood_impact_prop"], var_2, var_3);
  _triggerfx(var_6);
  wait 0.2;
  var_6 delete();
}

#using_animtree("animated_props_zombies_DLC2");

spin_propeller(var_0) {
  var_1 = _spawnlinkedfx(level._effect["zmb_ber_prop_trap_spin"], var_0, "prop");
  _triggerfx(var_1);
  level thread common_scripts\_exploder::_id_088E(203);
  var_0 scriptmodelplayanim("s2_zom_propeller_01_start");
  wait(_getanimlength(%s2_zom_propeller_01_start));
  var_0 scriptmodelplayanim("s2_zom_propeller_01_loop");
  wait 19;
  var_0 scriptmodelplayanim("s2_zom_propeller_01_end");
  level thread common_scripts\_exploder::_id_2A6D(203, undefined, 0);
  var_1 delete();
}