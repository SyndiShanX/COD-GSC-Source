/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_trap_1.gsc
***********************************************/

trap_1(param_00) {
  if(isDefined(level.zmb_on_any_trap_activated)) {
    [[level.zmb_on_any_trap_activated]]();
  }

  var_01 = common_scripts\utility::func_44BE(param_00.target, "targetname");
  foreach(var_03 in var_01) {
    var_03.var_9C92 = param_00;
    var_03.var_9CBB = param_00.script_noteworthy;
    if(!isDefined(var_03.script_noteworthy)) {
      continue;
    }

    if(lib_0547::func_5565(var_03.script_noteworthy, "fx_trap")) {
      var_03 thread aud_play_spike_sound();
    }

    if(var_03.script_noteworthy == "spike_damage") {
      param_00 thread trap_trigger_watch(var_03);
      wait 0.05;
    }
  }
}

aud_play_spike_sound() {
  lib_0378::func_8D74("artillery_bunker_trap_spikes", self.origin);
}

trap_trigger_watch(param_00) {
  trap_1_damage_fx_watch(param_00);
}

trap_1_damage_fx_watch(param_00) {
  self endon("cooldown");
  self endon("no_power");
  self endon("ready");
  self endon("deactivate");
  var_01 = gettime();
  for(;;) {
    param_00 waittill("trigger", var_02);
    var_03 = (var_02.origin[0], var_02.origin[1], param_00.origin[2]);
    if(isPlayer(var_02)) {
      if(isDefined(param_00.var_8260) && param_00.var_8260 == "no_player_damage") {
        continue;
      }

      if(isDefined(var_02.var_66D3) && var_02.var_66D3 > gettime()) {
        continue;
      }

      if(var_01 + 3000 > gettime()) {
        continue;
      }

      var_02 dodamage(4, var_02.origin, undefined, undefined, "MOD_EXPLOSIVE", "trap_zm_mp");
      continue;
    }

    if(isDefined(var_02.agentteam) && var_02.agentteam == level.var_746E) {
      if(isDefined(param_00.var_8260) && param_00.var_8260 == "no_player_damage") {
        continue;
      }

      if(isDefined(var_02.var_66D3) && var_02.var_66D3 > gettime()) {
        continue;
      }

      if(var_01 + 3000 > gettime()) {
        continue;
      }

      continue;
    }

    playFX(common_scripts\utility::func_44F5("zmb_isl_med_trap_gib_rnr"), var_02.origin);
    var_04 = var_02 modify_damage_to_island_zombie_types(5);
    var_02 dodamage(var_04, var_02.origin, param_00, param_00, "MOD_EXPLOSIVE", "trap_zm_mp");
  }
}

modify_damage_to_island_zombie_types(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 1;
  }

  if(!isDefined(self.maxhealth)) {
    return 0;
  }

  if(lib_0547::func_5565(self.var_A4B, "zombie_fireman") || lib_0547::func_5565(self.var_A4B, "zombie_assassin") || lib_0547::func_5565(self.var_A4B, "zombie_heavy")) {
    return int(self.maxhealth * 0.15 / param_00);
  }

  return self.health + 666;
}