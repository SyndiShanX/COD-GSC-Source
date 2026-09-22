/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_dig_02_trap.gsc
*****************************************************/

dig_trap_init() {
  level._id_9CFB = 1;
  level._id_62B5 = 1;
  level._effect["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_small");
  level._effect["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink_small");
  level._effect["trap_glint"] = loadfx("vfx/map/train/tra_sniper_glint");
  level._id_9CD1["ready_to_active"] = undefined;
  level._id_9CD1["active_to_cooldown"] = undefined;
  level._id_9CD1["cooldown_to_active"] = undefined;
  thread _id_0546::_id_9CC6("trap_altar_spikes", "active", ::trap_altar_spikes);
  level thread trap_altar_spikes_glasses_listen();
}

trap_altar_spikes_toggle(var_0) {
  var_1 = common_scripts\utility::_id_46B5("trap_altar_spikes", "script_noteworthy");
  var_2 = getEntArray(var_1.target, "targetname");

  if(common_scripts\utility::_id_562E(var_0)) {
    var_1 _id_0546::_id_9CA3();

    foreach(var_4 in var_2) {
      if(_id_0547::_id_5565(var_4._id_0165, "activate")) {
        var_4 common_scripts\utility::_id_9D9F();
      }
    }
  } else {
    var_1 _id_0546::_id_9CBD();

    foreach(var_4 in var_2) {
      if(_id_0547::_id_5565(var_4._id_0165, "activate")) {
        var_4 common_scripts\utility::_id_9DA3();
      }
    }
  }
}

trap_altar_spikes_glasses_listen() {
  level.dig_trap_kill_count = 0;
  var_0 = 100;

  for(;;) {
    wait 1;

    if(level.dig_trap_kill_count > var_0) {
      break;
    }
  }

  var_1 = _getEnt("sunglasses_at_night", "script_noteworthy");
  var_2 = common_scripts\utility::_id_46B5("glasses_dest", "script_noteworthy");
  var_3 = common_scripts\utility::_id_46B5("glasses_glint_fx_loc", "script_noteworthy");

  if(isDefined(var_1) && isDefined(var_2)) {
    var_1 moveTo(var_2.origin, 10, 0.25, 3);
  }

  wait 10;

  if(isDefined(var_3)) {
    playFX(common_scripts\utility::_id_44F5("trap_glint"), var_3.origin, anglesToForward(var_3.angles), anglestoup(var_3.angles));
  }
}

trap_altar_spikes(var_0) {
  level.trap_altar_spikes = var_0 common_scripts\utility::_id_8FFC();
  level.trap_altar_spikes._id_9CBB = "trap_altar_spikes";
  level.trap_altar_spikes._id_9C92 = var_0;
  var_0 thread trap_altar_spikes_handle_damage();
}

trap_altar_spikes_handle_damage() {
  self._id_565F = 1;
  var_0 = common_scripts\utility::_id_46B5("med_trap_fx_point", "targetname");
  var_1 = _spawnfx(level._effect["dlc_zmb_dig_02_spike_trap_on"], var_0.origin, anglesToForward(var_0.angles));
  _triggerfx(var_1);
  thread trap_altar_spikes_damage_zombies(var_0);
  thread trap_altar_spikes_damage_players(var_0);
  _id_0378::_id_8D74("aud_trap_spikes", var_0.origin);
  common_scripts\utility::_id_A70A("cooldown", "no_power", "ready", "deactivate");
  var_1 delete();
  self._id_565F = 0;
}

trap_altar_spikes_damage_zombies(var_0) {
  while(self._id_565F) {
    var_1 = _id_0547::_id_408F();

    foreach(var_3 in var_1) {
      if(_id_0547::_id_5565(var_3._id_0A4B, "zombie_guardian")) {
        continue;
      }
      var_4 = _distance2d(var_3.origin, var_0.origin);

      if(var_4 > 140 && var_4 < 242 && var_3.origin[2] < self.origin[2]) {
        playFX(level._effect["zmb_med_trap_gib"], var_3.origin + (0, 0, 50), anglesToForward(var_3.angles));
        waitframe();
        var_5 = gettime();

        if(isalive(var_3) && var_3._id_0BA4 != "traverse") {
          if(!isDefined(var_3.wasspikedlast) || isDefined(var_3.wasspikedlast) && var_5 > var_3.wasspikedlast + 1000) {
            if(var_3 _id_0547::_id_580A()) {
              var_3 dodamage(var_3.health * 0.1, self.origin, level.trap_altar_spikes, level.trap_altar_spikes, "MOD_EXPLOSIVE", "trap_zm_mp");
            } else {
              var_3 dodamage(var_3.health + 666, self.origin, level.trap_altar_spikes, level.trap_altar_spikes, "MOD_EXPLOSIVE", "trap_zm_mp");
              level.dig_trap_kill_count++;

              if(!isDefined(var_3.hitbytrap)) {
                foreach(var_7 in level.players) {
                  var_7 maps\mp\gametypes\zombies::_id_47C7("kill_trap");
                  var_3.hitbytrap = 1;
                }
              }
            }

            if(isalive(var_3)) {
              var_3.wasspikedlast = gettime();
            }
          }

          waitframe();
        }
      }
    }

    wait 0.15;
  }
}

trap_altar_spikes_damage_players(var_0) {
  while(self._id_565F) {
    var_1 = level.players;

    foreach(var_3 in var_1) {
      if(!isalive(var_3)) {
        continue;
      }
      if(_id_0547::_id_577E(var_3)) {
        continue;
      }
      var_4 = _distance2d(var_3.origin, var_0.origin);

      if(var_4 > 140 && var_4 < 242 && var_3.origin[2] < self.origin[2]) {
        waitframe();
        var_5 = gettime();

        if(!isDefined(var_3.wasspikedlast)) {
          var_3.wasspikedlast = gettime();
        }

        if(isalive(var_3) && var_5 > var_3.wasspikedlast + 500 && !_id_0547::_id_577E(var_3)) {
          var_3 dodamage(5, self.origin, undefined, undefined, "MOD_CRUSH");

          if(var_3.health - 5 <= 0) {
            level.dig_trap_kill_count++;
          }

          var_3.wasspikedlast = gettime();
          waitframe();
        }
      }
    }

    wait 0.15;
  }
}