/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_berlin_trap_cage_blitz.gsc
****************************************************************/

trap_cage_blitz(var_0) {
  var_1 = 20;
  var_2 = common_scripts\utility::_id_46B5("struct_trap_cage_blitz", "script_noteworthy");
  var_3 = common_scripts\utility::_id_46B5("cage_spark_fx_trap", "script_noteworthy");
  var_3 thread trap_cage_idle_spark();
  var_4 = _getEnt("cage_damage", "script_noteworthy");
  var_4._id_9C92 = var_0;
  var_4._id_9CBB = "trap_cage_blitz";
  wait 0.3;
  var_2 thread trap_cage_do_damage(var_4);
  var_5 = common_scripts\utility::_id_46B7("cage_shock_fx_trap", "script_noteworthy");
  var_6 = common_scripts\utility::_id_46B7("cage_current_fx_trap", "script_noteworthy");
  _id_0378::_id_8D74("start_trap_cage", 1.0, var_1);

  foreach(var_8 in var_5) {
    var_8 thread trap_cage_arcs();
  }

  foreach(var_8 in var_6) {
    var_8 thread trap_cage_current();
  }

  wait(var_1);

  foreach(var_8 in var_5) {
    var_8 notify("stop_fx");
  }

  foreach(var_8 in var_6) {
    var_8 notify("stop_fx");
  }

  _id_0378::_id_8D74("stop_trap_cage");
  waitframe();
  var_2 notify("stop_damage");
  wait 0.5;
  wait 1;
}

trap_cage_do_damage(var_0) {
  self endon("stop_damage");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      var_1 dodamage(15, self.origin, var_0, var_0, "MOD_EXPLOSIVE", "trap_zm_mp");
      var_1 _id_0378::_id_8D74("trap_cage_damage");
    } else {
      var_1 _id_0546::mark_electrified();
      var_1 dodamage(var_1.health + 666, self.origin, var_0, var_0, "MOD_EXPLOSIVE", "trap_zm_mp");
      var_1 _id_0378::_id_8D74("trap_cage_damage");
      playFX(common_scripts\utility::_id_44F5("tesla_stun_sparks"), self.origin);
    }

    wait 0.5;
  }
}

trap_cage_arcs() {
  self endon("stop_fx");

  for(;;) {
    level thread common_scripts\_exploder::_id_088E(202);
    wait(_randomfloatrange(0.4, 0.7));
  }
}

trap_cage_current() {
  self endon("stop_fx");

  for(;;) {
    playFX(level._effect["cage_trap_current"], self.origin);
    wait(_randomfloatrange(0.2, 0.5));
  }
}

trap_cage_idle_spark() {
  common_scripts\utility::flag_init("flag_trap_on");

  for(;;) {
    while(!common_scripts\utility::_id_3C77("flag_trap_on")) {
      wait(_randomfloatrange(3.0, 5.0));
      playFX(level._effect["tank_trap_sparks"], self.origin);
    }

    wait 1;
  }
}