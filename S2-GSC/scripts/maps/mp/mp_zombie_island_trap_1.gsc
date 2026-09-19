/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_trap_1.gsc
*******************************************************/

trap_1(var_0) {
  if(isDefined(level.zmb_on_any_trap_activated))
    [[level.zmb_on_any_trap_activated]]();

  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_9C92 = var_0;
    var_3._id_9CBB = var_0._id_0165;

    if(!isDefined(var_3._id_0165)) {
      continue;
    }
    if(_id_0547::_id_5565(var_3._id_0165, "fx_trap"))
      var_3 thread aud_play_spike_sound();

    if(var_3._id_0165 == "spike_damage") {
      var_0 thread trap_trigger_watch(var_3);
      waitframe();
    }
  }
}

aud_play_spike_sound() {
  _id_0378::_id_8D74("artillery_bunker_trap_spikes", self.origin);
}

trap_trigger_watch(var_0) {
  trap_1_damage_fx_watch(var_0);
}

trap_1_damage_fx_watch(var_0) {
  self endon("cooldown");
  self endon("no_power");
  self endon("ready");
  self endon("deactivate");
  var_1 = gettime();

  for(;;) {
    var_0 waittill("trigger", var_2);
    var_3 = (var_2.origin[0], var_2.origin[1], var_0.origin[2]);

    if(isPlayer(var_2)) {
      if(isDefined(var_0._id_8260) && var_0._id_8260 == "no_player_damage") {
        continue;
      }
      if(isDefined(var_2._id_66D3) && var_2._id_66D3 > gettime()) {
        continue;
      }
      if(var_1 + 3000 > gettime()) {
        continue;
      }
      var_2 _meth_8059(4, var_2.origin, undefined, undefined, "MOD_EXPLOSIVE", "trap_zm_mp");
      continue;
    }

    if(isDefined(var_2._id_000A) && var_2._id_000A == level._id_746E) {
      if(isDefined(var_0._id_8260) && var_0._id_8260 == "no_player_damage") {
        continue;
      }
      if(isDefined(var_2._id_66D3) && var_2._id_66D3 > gettime()) {
        continue;
      }
      if(var_1 + 3000 > gettime())
        continue;
    } else {
      playFX(common_scripts\utility::_id_44F5("zmb_isl_med_trap_gib_rnr"), var_2.origin);
      var_4 = var_2 modify_damage_to_island_zombie_types(5);
      var_2 _meth_8059(var_4, var_2.origin, var_0, var_0, "MOD_EXPLOSIVE", "trap_zm_mp");
    }
  }
}

modify_damage_to_island_zombie_types(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(self.maxhealth))
    return 0;

  if(_id_0547::_id_5565(self._id_0A4B, "zombie_fireman") || _id_0547::_id_5565(self._id_0A4B, "zombie_assassin") || _id_0547::_id_5565(self._id_0A4B, "zombie_heavy"))
    return int(self.maxhealth * 0.15 / var_0);
  else
    return self.health + 666;
}