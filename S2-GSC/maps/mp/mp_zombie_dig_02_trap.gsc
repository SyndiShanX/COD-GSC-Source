/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_dig_02_trap.gsc
*********************************************/

dig_trap_init() {
  level.var_9CFB = 1;
  level.var_62B5 = 1;
  level.var_611["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_small");
  level.var_611["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink_small");
  level.var_611["trap_glint"] = loadfx("vfx/map/train/tra_sniper_glint");
  level.var_9CD1["ready_to_active"] = undefined;
  level.var_9CD1["active_to_cooldown"] = undefined;
  level.var_9CD1["cooldown_to_active"] = undefined;
  thread maps\mp\zombies\_zombies_traps::func_9CC6("trap_altar_spikes", "active", ::trap_altar_spikes);
  level thread trap_altar_spikes_glasses_listen();
}

trap_altar_spikes_toggle(param_00) {
  var_01 = common_scripts\utility::func_46B5("trap_altar_spikes", "script_noteworthy");
  var_02 = getEntArray(var_01.var_1A2, "targetname");
  if(common_scripts\utility::func_562E(param_00)) {
    var_01 maps\mp\zombies\_zombies_traps::func_9CA3();
    foreach(var_04 in var_02) {
      if(lib_0547::func_5565(var_04.var_165, "activate")) {
        var_04 common_scripts\utility::func_9D9F();
      }
    }

    return;
  }

  var_02 maps\mp\zombies\_zombies_traps::func_9CBD();
  foreach(var_04 in var_04) {
    if(lib_0547::func_5565(var_04.var_165, "activate")) {
      var_04 common_scripts\utility::func_9DA3();
    }
  }
}

trap_altar_spikes_glasses_listen() {
  level.dig_trap_kill_count = 0;
  var_00 = 100;
  for(;;) {
    wait(1);
    if(level.dig_trap_kill_count > var_00) {
      break;
    }
  }

  var_01 = getent("sunglasses_at_night", "script_noteworthy");
  var_02 = common_scripts\utility::func_46B5("glasses_dest", "script_noteworthy");
  var_03 = common_scripts\utility::func_46B5("glasses_glint_fx_loc", "script_noteworthy");
  if(isDefined(var_01) && isDefined(var_02)) {
    var_01 moveto(var_02.var_116, 10, 0.25, 3);
  }

  wait(10);
  if(isDefined(var_03)) {
    playFX(common_scripts\utility::func_44F5("trap_glint"), var_03.var_116, anglesToForward(var_03.var_1D), anglestoup(var_03.var_1D));
  }
}

trap_altar_spikes(param_00) {
  level.trap_altar_spikes = param_00 common_scripts\utility::func_8FFC();
  level.trap_altar_spikes.var_9CBB = "trap_altar_spikes";
  level.trap_altar_spikes.var_9C92 = param_00;
  param_00 thread trap_altar_spikes_handle_damage();
}

trap_altar_spikes_handle_damage() {
  self.var_565F = 1;
  var_00 = common_scripts\utility::func_46B5("med_trap_fx_point", "targetname");
  var_01 = spawnfx(level.var_611["dlc_zmb_dig_02_spike_trap_on"], var_00.var_116, anglesToForward(var_00.var_1D));
  triggerfx(var_01);
  thread trap_altar_spikes_damage_zombies(var_00);
  thread trap_altar_spikes_damage_players(var_00);
  lib_0378::func_8D74("aud_trap_spikes", var_00.var_116);
  common_scripts\utility::knock_off_battery("cooldown", "no_power", "ready", "deactivate");
  var_01 delete();
  self.var_565F = 0;
}

trap_altar_spikes_damage_zombies(param_00) {
  while(self.var_565F) {
    var_01 = lib_0547::func_408F();
    foreach(var_03 in var_01) {
      if(lib_0547::func_5565(var_03.var_A4B, "zombie_guardian")) {
        continue;
      }

      var_04 = distance2d(var_03.var_116, param_00.var_116);
      if(var_04 > 140 && var_04 < 242 && var_03.var_116[2] < self.var_116[2]) {
        playFX(level.var_611["zmb_med_trap_gib"], var_03.var_116 + (0, 0, 50), anglesToForward(var_03.var_1D));
        wait 0.05;
        var_05 = gettime();
        if(isalive(var_03) && var_03.var_BA4 != "traverse") {
          if(!isDefined(var_03.wasspikedlast) || isDefined(var_03.wasspikedlast) && var_05 > var_03.wasspikedlast + 1000) {
            if(var_03 lib_0547::func_580A()) {
              var_03 dodamage(var_03.var_BC * 0.1, self.var_116, level.trap_altar_spikes, level.trap_altar_spikes, "MOD_EXPLOSIVE", "trap_zm_mp");
            } else {
              var_03 dodamage(var_03.var_BC + 666, self.var_116, level.trap_altar_spikes, level.trap_altar_spikes, "MOD_EXPLOSIVE", "trap_zm_mp");
              level.dig_trap_kill_count++;
              if(!isDefined(var_03.hitbytrap)) {
                foreach(var_07 in level.var_744A) {
                  var_07 maps\mp\gametypes\zombies::func_47C7("kill_trap");
                  var_03.hitbytrap = 1;
                }
              }
            }

            if(isalive(var_03)) {
              var_03.wasspikedlast = gettime();
            }
          }

          wait 0.05;
        }
      }
    }

    wait(0.15);
  }
}

trap_altar_spikes_damage_players(param_00) {
  while(self.var_565F) {
    var_01 = level.var_744A;
    foreach(var_03 in var_01) {
      if(!isalive(var_03)) {
        continue;
      }

      if(lib_0547::func_577E(var_03)) {
        continue;
      }

      var_04 = distance2d(var_03.var_116, param_00.var_116);
      if(var_04 > 140 && var_04 < 242 && var_03.var_116[2] < self.var_116[2]) {
        wait 0.05;
        var_05 = gettime();
        if(!isDefined(var_03.wasspikedlast)) {
          var_03.wasspikedlast = gettime();
        }

        if(isalive(var_03) && var_05 > var_03.wasspikedlast + 500 && !lib_0547::func_577E(var_03)) {
          var_03 dodamage(5, self.var_116, undefined, undefined, "MOD_CRUSH");
          if(var_03.var_BC - 5 <= 0) {
            level.dig_trap_kill_count++;
          }

          var_03.wasspikedlast = gettime();
          wait 0.05;
        }
      }
    }

    wait(0.15);
  }
}