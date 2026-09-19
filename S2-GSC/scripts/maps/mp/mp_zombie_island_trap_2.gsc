/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_trap_2.gsc
*******************************************************/

trap_2(var_0) {
  if(isDefined(level.zmb_on_any_trap_activated))
    [[level.zmb_on_any_trap_activated]]();

  var_1 = _getent("zmb_trap_propeller_model", "targetname");
  var_2 = _getent("propeller_damage", "script_noteworthy");
  var_1 _id_0378::_id_8D74("sub_pen_prop_trap_extend");
  wait 0.5;
  var_1 _id_0378::_id_8D74("sub_pen_prop_trap_start");
  wait 1.0;
  wait 0.3;
  var_1 thread spin();
  wait 2;
  var_1 thread do_grit_blood(var_2);
  var_1 thread do_damage(var_2, var_0);
  wait 18.5;
  var_1 _id_0378::_id_8D74("sub_pen_prop_trap_extend");
  var_1 _id_0378::_id_8D74("sub_pen_prop_trap_stop");
  wait 1.5;
  var_1 notify("stop_damage");
  wait 0.5;
  wait 1;
}

do_grit_blood(var_0) {
  self endon("stop_damage");

  for(;;) {
    var_0 waittill("trigger", var_1);
    play_propeller_blood_splatter(var_1);
    wait 1;
  }
}

play_propeller_blood_splatter(var_0) {
  var_1 = get_closest_propeller_blade(var_0);

  switch (var_1) {
    case "rotor_L":
      _playfxontag(level._effect["zmb_isl_uboat_blood_grit"], self, "rotor_L");
      level childthread common_scripts\_exploder::_id_088E(209);
      break;
    case "rotor_R":
      _playfxontag(level._effect["zmb_isl_uboat_blood_grit"], self, "rotor_R");
      level childthread common_scripts\_exploder::_id_088E(210);
      break;
  }
}

get_closest_propeller_blade(var_0) {
  var_1 = ["rotor_L", "rotor_R"];
  var_2 = [];

  foreach(var_4 in var_1)
  var_2[var_2.size] = self gettagorigin(var_4);

  var_6 = -1;
  var_7 = undefined;

  for(var_8 = 0; var_8 < var_1.size; var_8++) {
    var_9 = distance(var_0.origin, var_2[var_8]);

    if(var_6 < 0 || var_9 < var_6) {
      var_6 = var_9;
      var_7 = var_1[var_8];
    }
  }

  return var_7;
}

do_damage(var_0, var_1) {
  self endon("stop_damage");

  for(;;) {
    foreach(var_3 in common_scripts\utility::_id_0F73(level.players, _id_0547::_id_408F())) {
      if(var_3 istouching(var_0))
        var_3 childthread do_propellar_damage(var_0, var_1);
    }

    wait 0.15;
  }
}

do_propellar_damage(var_0, var_1) {
  var_2 = self;
  var_0._id_9C92 = var_1;
  var_0._id_9CBB = var_1._id_0165;

  if(isPlayer(var_2)) {
    var_2 dodamage(var_2.health + 20, self.origin, var_0, var_0, "MOD_EXPLOSIVE", "trap_zm_mp");
    _id_0378::_id_8D74("sub_pen_prop_trap_player_hit", var_2);
  } else {
    var_3 = var_2 maps\mp\mp_zombie_island_trap_1::modify_damage_to_island_zombie_types(5);
    var_2 dodamage(var_3, self.origin, var_0, var_0, "MOD_EXPLOSIVE", "trap_zm_mp");
    var_2 childthread zombie_prop_gib_effects(var_0);
  }

  _id_0378::_id_8D74("sub_pen_prop_trap_hit", self.origin);
}

zombie_prop_gib_effects(var_0) {
  self endon("death");

  for(;;) {
    var_1 = _id_0547::_id_408F();

    foreach(var_3 in var_1) {
      if(_distance2d(var_3.origin, var_0.origin) < 105)
        playFX(level._effect["zmb_isl_uboat_prop_blood_impact"], var_3.origin + (0, 0, 50), anglesToForward(var_0.angles));
    }

    wait 0.25;
  }
}

spin() {
  var_0 = _getent("zmb_trap_propeller_model", "targetname");
  var_0 scriptmodelplayanimdeltamotion("s2_zom_ger_u_boat_rotor_spin");
  _playfxontag(level._effect["zmb_isl_uboat_water_prop_spin_r"], var_0, "rotor_R");
  _playfxontag(level._effect["zmb_isl_uboat_water_prop_spin_l"], var_0, "rotor_L");
}