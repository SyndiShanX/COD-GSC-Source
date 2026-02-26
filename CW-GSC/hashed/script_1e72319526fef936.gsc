/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1e72319526fef936.gsc
***********************************************/

#using script_215d7818c548cb51;
#using script_5b2a3c052bf17d0e;
#using script_6b2d896ac43eb90;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_free_fall;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_powerups;
#using scripts\zm_common\zm_utility;
#namespace namespace_7ec6ae9f;

function private autoexec __init__system__() {
  system::register(#"hash_2ff0859bce056c66", &preinit, undefined, undefined, #"content_manager");
}

function private preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_4bf87ef3ad101bb4")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  content_manager::register_script(#"hash_2ff0859bce056c66", &function_ea2db6a9);
  clientfield::register("allplayers", "phase_rift_player_fx", 1, 2, "int");
  clientfield::register("toplayer", "" + # "hash_1b01e37683714902", 1, 1, "int");
  callback::add_callback(#"on_host_migration_end", &function_16ee428c);
}

function function_ea2db6a9(instance) {
  var_d4f4d124 = isDefined(instance.contentgroups[#"hash_1381b446e6ab7a37"]) ? instance.contentgroups[#"hash_1381b446e6ab7a37"] : [];
  instance.var_75bfdd78 = isDefined(instance.contentgroups[#"teleport"]) ? instance.contentgroups[#"teleport"] : [];
  instance.a_triggers = [];
  v_offset = (0, 0, -32);
  level.var_ff7bf48c = [];

  foreach(var_2b357ce9 in var_d4f4d124) {
    mdl_portal = content_manager::spawn_script_model(var_2b357ce9, "tag_origin");
    mdl_portal.fx_id = playFXOnTag(#"hash_7312068ea6037f71", mdl_portal, "tag_origin");
    mdl_portal playLoopSound(#"hash_15ff560465c71665");
    level.var_ff7bf48c[level.var_ff7bf48c.size] = mdl_portal;
    trigger = spawn("trigger_radius", var_2b357ce9.origin + v_offset, 0, 128, 64);
    trigger trigger::add_flags(16);
    trigger.instance = instance;
    trigger.var_2b357ce9 = var_2b357ce9;
    trigger.mdl_portal = mdl_portal;
    trigger callback::on_trigger(&function_1c5803d9);

    if(!isDefined(instance.a_triggers)) {
      instance.a_triggers = [];
    } else if(!isarray(instance.a_triggers)) {
      instance.a_triggers = array(instance.a_triggers);
    }

    instance.a_triggers[instance.a_triggers.size] = trigger;
  }

  instance callback::function_d8abfc3d(#"portal_activated", &function_8ebdf278);
}

function function_16ee428c(params) {
  if(isarray(level.var_ff7bf48c)) {
    foreach(mdl_portal in level.var_ff7bf48c) {
      if(isDefined(mdl_portal) && mdl_portal.instance.content_script_name !== # "hash_18be5193d8310f84") {
        mdl_portal.fx_id = playFXOnTag(#"hash_7312068ea6037f71", mdl_portal, "tag_origin");
      }
    }
  }
}

function function_1c5803d9(eventstruct) {
  var_2b357ce9 = self.var_2b357ce9;
  instance = self.instance;
  mdl_portal = self.mdl_portal;
  var_85e930e6 = [];

  if(!isDefined(var_2b357ce9.s_teleport) && isarray(instance.var_75bfdd78)) {
    var_2b357ce9.s_teleport = array::function_a3b0f814(instance.var_75bfdd78, 0);
  }

  s_teleport = var_2b357ce9.s_teleport;
  player = eventstruct.activator;

  if(isPlayer(player)) {
    if(player isinvehicle()) {
      vehicle = player getvehicleoccupied();
    }
  } else {
    player = undefined;
  }

  if(isDefined(vehicle) || isvehicle(eventstruct.activator)) {
    if(!isDefined(vehicle)) {
      vehicle = eventstruct.activator;
    }

    foreach(passenger in function_a1ef346b()) {
      if(passenger isinvehicle() && passenger getvehicleoccupied() === vehicle) {
        n_seat = vehicle getoccupantseat(passenger);

        if(n_seat === 0 || passenger === player) {
          if(!isDefined(player)) {
            player = passenger;
          }

          continue;
        }

        if(!isDefined(var_85e930e6)) {
          var_85e930e6 = [];
        } else if(!isarray(var_85e930e6)) {
          var_85e930e6 = array(var_85e930e6);
        }

        if(!isinarray(var_85e930e6, passenger)) {
          var_85e930e6[var_85e930e6.size] = passenger;
        }
      }
    }

    if(!is_true(vehicle.var_b591d382)) {
      vehicle.var_b591d382 = 1;
      vehicle makevehicleunusable();
    }

    if(!isDefined(player) && var_85e930e6.size) {
      player = array::pop(var_85e930e6, undefined, 0);
    }
  }

  if(!isPlayer(player) || !isDefined(var_2b357ce9) || !isDefined(s_teleport) || var_2b357ce9 flag::get(#"hash_3492e2db103df124") || player flag::get(#"hash_9f062ac608bb7e4")) {
    return;
  }

  var_2b357ce9 thread flag::set_for_time(0.5, #"hash_3492e2db103df124");

  if(!isDefined(s_teleport.v_launch)) {
    s_teleport.v_launch = (1250, 0, 300);
  }

  self thread function_a41c43bd(var_2b357ce9, mdl_portal, vehicle);
  v_trigger_offset = (0, 0, -32);

  if(isDefined(vehicle)) {
    vehicle hide();
    vehicle val::set(#"hash_2ff0859bce056c66", "takedamage", 0);
    player.var_e1fd941b = vehicle;
  }

  s_teleport thread function_dda69211(player, vehicle, var_2b357ce9);

  foreach(passenger in var_85e930e6) {
    passenger.var_e1fd941b = vehicle;
    s_teleport thread function_dda69211(passenger);
  }
}

function private function_dda69211(player, vehicle, var_2b357ce9) {
  if(isalive(player)) {
    if(player util::isusingremote() || player flag::get(#"hash_9f062ac608bb7e4")) {
      return;
    }

    player flag::set(#"hash_9f062ac608bb7e4");
    player val::set(#"hash_2ff0859bce056c66", "takedamage", 0);
    player val::set(#"hash_2ff0859bce056c66", "allow_crouch", 0);
    player val::set(#"hash_2ff0859bce056c66", "allow_prone", 0);
    player val::set(#"hash_2ff0859bce056c66", "allow_stand", 1);
    player val::set(#"hash_2ff0859bce056c66", "freezecontrols_allowlook", 1);
    player player_free_fall::allow_player_basejumping(0);
    player clientfield::set("phase_rift_player_fx", 1);

    if(isDefined(self.parent)) {
      if(!isDefined(self.parent.var_73577d31)) {
        self.parent.var_73577d31 = [];
      } else if(!isarray(self.parent.var_73577d31)) {
        self.parent.var_73577d31 = array(self.parent.var_73577d31);
      }

      if(!isinarray(self.parent.var_73577d31, player)) {
        self.parent.var_73577d31[self.parent.var_73577d31.size] = player;
      }
    }

    if(isDefined(vehicle)) {
      vehicle clientfield::increment("" + # "vehicle_teleport");
      var_9cfd0ea9 = vehicle getvehoccupants();

      foreach(rider in var_9cfd0ea9) {
        rider unlink();
      }
    }

    util::wait_network_frame();
    player playsoundtoplayer(#"hash_5ccf2f0b27ccbf41", player);

    if(is_true(var_2b357ce9.var_40803981)) {
      player clientfield::set_to_player("" + # "hash_1b01e37683714902", 1);
    }

    player namespace_dbb31ff3::function_7b3dca17(self);

    if(is_true(var_2b357ce9.var_40803981)) {
      player clientfield::set_to_player("" + # "hash_1b01e37683714902", 0);
    }

    if(isalive(player)) {
      player clientfield::set("phase_rift_player_fx", 2);

      if(isDefined(vehicle)) {
        vehicle show();
        vehicle unlink();
        util::wait_network_frame();

        if(isDefined(vehicle)) {
          vehicle dontinterpolate();
          vehicle.origin = self.origin;
          vehicle.angles = self.angles;
        }
      }
    }

    if(isalive(player)) {
      if(isDefined(var_2b357ce9)) {
        var_2b357ce9 notify(#"player_exiting");
      }

      namespace_957938f0::function_59d43f02(self, player, 1);
    }

    if(isDefined(player)) {
      player.var_e1fd941b = undefined;
      player val::reset_all(#"hash_2ff0859bce056c66");
      player flag::clear(#"hash_9f062ac608bb7e4");
      player player_free_fall::allow_player_basejumping(1);
    }

    if(isDefined(vehicle)) {
      vehicle val::reset_all(#"hash_2ff0859bce056c66");
      vehicle makevehicleusable();
      vehicle.var_b591d382 = undefined;
    }

    wait 3;

    if(isDefined(player)) {
      player clientfield::set("phase_rift_player_fx", 0);
    }
  }
}

function function_a41c43bd(var_2b357ce9, mdl_portal, vehicle) {
  if(self flag::get(#"hash_39816ba0141eb30c")) {
    return;
  }

  self flag::set(#"hash_39816ba0141eb30c");
  mdl_portal flag::set(#"hash_5c79c9319298891a");
  var_f49d0155 = isDefined(self.instance.contentgroups[#"hash_1381b446e6ab7a37"]) ? self.instance.contentgroups[#"hash_1381b446e6ab7a37"] : [];

  foreach(var_4db48fec in var_f49d0155) {
    if(!var_4db48fec flag::get(#"hash_5c79c9319298891a")) {
      var_dfe9b4d8 = 1;
      break;
    }
  }

  self thread function_d3d632c3(vehicle);

  if(!var_f49d0155.size) {
    return;
  }

  s_teleport = mdl_portal.s_teleport;
  v_powerup = namespace_77bd50da::function_81cad6d6(s_teleport.v_launch / 35, s_teleport.angles[1]) + s_teleport.origin;
  powerup = util::spawn_model("tag_origin", v_powerup);

  if(isDefined(powerup)) {
    powerup.var_5c6f6051 = 384;
    powerup zm_powerups::powerup_init(powerup, undefined, undefined, undefined, 0, undefined, 0, 1, 0);

    if(!is_true(var_dfe9b4d8)) {
      powerup waittilltimeout(15, #"powerup_grabbed");
      level scoreevents::doscoreeventcallback("scoreEventSR", {
        #scoreevent: "event_complete", #a_players: self.instance.var_73577d31
      });
    }
  }
}

function function_d3d632c3(mdl_portal) {
  self endon(#"death");

  if(getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  if(!isDefined(self.var_3b53f898)) {
    self.var_3b53f898 = 15;
  }

  wait self.var_3b53f898;

  if(isDefined(mdl_portal)) {
    arrayremovevalue(level.var_ff7bf48c, mdl_portal);
  }

  if(isDefined(mdl_portal)) {
    mdl_portal delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_8ebdf278(eventstruct) {
  if(isDefined(self.a_triggers)) {
    foreach(trigger in self.a_triggers) {
      if(isDefined(trigger)) {
        trigger delete();
      }

      if(isDefined(trigger.mdl_portal)) {
        trigger.mdl_portal delete();
      }
    }
  }

  self callback::function_52ac9652(#"portal_activated", &function_8ebdf278);
}