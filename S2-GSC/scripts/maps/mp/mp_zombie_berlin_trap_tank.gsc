/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_berlin_trap_tank.gsc
**********************************************************/

trap_tank(var_0) {
  var_1 = 20;
  var_2 = common_scripts\utility::_id_46B7("puddle_shock_fx_trap", "script_noteworthy");
  var_3 = common_scripts\utility::_id_46B7("puddle_current_fx_trap", "script_noteworthy");

  foreach(var_5 in var_2)
  var_5 thread trap_puddle_arcs();

  foreach(var_5 in var_3)
  var_5 thread trap_puddle_current();

  _id_0378::_id_8D74("start_trap_tank", 1.0, var_1);
  var_9 = _getent("puddle_damage", "script_noteworthy");
  var_9._id_9C92 = var_0;
  var_9._id_9CBB = "trap_tank";
  wait 0.3;
  var_9 thread do_damage(var_9);
  wait(var_1);

  foreach(var_5 in var_2)
  var_5 notify("stop_fx");

  foreach(var_5 in var_3)
  var_5 notify("stop_fx");

  _id_0378::_id_8D74("stop_trap_tank");
  var_9 notify("stop_damage");
  wait 0.5;
  wait 1;
}

do_damage(var_0) {
  self endon("stop_damage");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1))
      var_1 dodamage(15, self.origin, var_0, var_0, "MOD_EXPLOSIVE", "trap_zm_mp");
    else {
      var_1 _id_0546::mark_electrified();
      var_1 dodamage(var_1.health + 666, self.origin, var_0, var_0, "MOD_EXPLOSIVE", "trap_zm_mp");
      var_1 _id_0378::_id_8D74("trap_tank_damage");
    }

    wait 0.5;
  }
}

spin() {}

trap_puddle_arcs() {
  self endon("stop_fx");

  for(;;)
    wait(_randomfloatrange(0.4, 0.7));
}

trap_puddle_current() {
  self endon("stop_fx");

  for(;;) {
    playFX(level._effect["cage_trap_current"], self.origin);
    wait(_randomfloatrange(0.2, 0.5));
  }
}