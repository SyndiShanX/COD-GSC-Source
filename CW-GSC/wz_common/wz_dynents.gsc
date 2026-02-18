/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\wz_dynents.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\dynent_use;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace wz_dynents;

function private autoexec __init__system__() {
  system::register(#"wz_dynents", &preinit, undefined, undefined, undefined);
}

function preinit() {
  callback::on_player_corpse(&function_8cc4432b);
  level thread init_elevator("dynent_elevator_button");
  level thread init_elevator("dynent_elevator_button_2");
  level thread init_elevator("dynent_elevator_button_3");
  level thread init_elevator("dynent_elevator_button_4");
  level thread init_elevator("dynent_elevator_button_5");
  level thread function_ded5d217();
}

function function_ded5d217() {
  var_7b969086 = getdynentarray("wind_turbine");

  foreach(turbine in var_7b969086) {
    if(randomint(100) > 20) {
      setdynentstate(turbine, randomintrange(1, 4));
    }
  }

  foreach(turbine in var_7b969086) {
    if(randomint(100) > 20) {
      setdynentstate(turbine, randomintrange(1, 4));
    }
  }
}

function init_elevator(var_fd98a47c) {
  dynents = getdynentarray(var_fd98a47c);

  if(dynents.size == 0) {
    return;
  }

  assert(dynents.size == 2);

  foreach(dynent in dynents) {
    dynent.onuse = &function_31042f91;
    dynent.ondamaged = &function_724a2fa5;
    dynent.buttons = dynents;
    position = struct::get(dynent.target, "targetname");
    elevator = getent(position.target, "targetname");
    elevator.buttons = dynents;

    if(position.script_noteworthy === "start") {
      setdynentstate(dynent, 1);

      if(!isDefined(elevator.target)) {
        continue;
      }

      button = getent(elevator.target, "targetname");

      if(!isDefined(button)) {
        continue;
      }

      button triggerignoreteam();
      button setvisibletoall();
      button usetriggerrequirelookat();
      button setteamfortrigger(#"none");
      button setcursorhint("HINT_NOICON");
      button sethintstring(#"hash_29965b65bca9cd7b");
      button usetriggerignoreuseholdtime();
      button callback::on_trigger(&function_af088c90);
      button.elevator = elevator;
      elevator.button = button;
      elevator.var_e87f4c9 = button.origin - elevator.origin;
      elevator.var_8273f574 = dynent;
      elevator.currentfloor = dynent;
      continue;
    }

    elevator.var_ec68615b = dynent;
    elevator.var_d98394f7 = dynent;
  }
}

function private function_724a2fa5(eventstruct) {
  dynent = eventstruct.ent;

  if(isDefined(eventstruct)) {
    dynent.health += eventstruct.amount;
  }

  if(isDefined(dynent.var_a548ec11) && gettime() <= dynent.var_a548ec11) {
    return;
  }

  if(distancesquared(eventstruct.ent.origin, eventstruct.position) > sqr(15)) {
    return;
  }

  var_a852a7dd = dynent_use::use_dynent(dynent);
  dynent.var_a548ec11 = gettime() + var_a852a7dd * 1000;
}

function function_8cc4432b(params) {
  waitframe(1);

  if(isDefined(self) && isDefined(self.player) && is_true(self.player.var_1a776c13)) {
    self notsolid();
    self ghost();
  }
}

function function_ad26976() {
  self endon(#"movedone");

  while(true) {
    vehicles = getentitiesinradius(self.origin, 1536, 12);
    vehicle_corpses = getentitiesinradius(self.origin, 1536, 14);

    foreach(vehicle in vehicles) {
      vehicle launchvehicle((0, 0, 0), vehicle.origin, 0);
    }

    foreach(vehicle_corpse in vehicle_corpses) {
      vehicle_corpse delete();
    }

    wait 0.25;
  }
}

function function_211e7277(point, var_8bd17d7d) {
  nearby_players = getplayers(undefined, point.origin, 256);
  move_pos = point.origin;
  var_93a4284 = 0;
  check_count = 0;

  if(nearby_players.size > 0) {
    var_93a4284 = 1;
  }

  while(var_93a4284 && check_count < 20) {
    foreach(player in nearby_players) {
      if(distance(player.origin, point.origin) < 16 && player.sessionstate == "playing") {
        var_93a4284 = 1;
        n_forward = var_8bd17d7d;
        n_forward *= (32, 32, 0);
        move_pos += n_forward;
        break;
      }

      var_93a4284 = 0;
    }

    check_count++;
  }

  self setorigin(move_pos);
}

function is_equipment(entity) {
  if(isDefined(entity.weapon)) {
    weapon = entity.weapon;

    if(weapon.name === # "ability_smart_cover" || weapon.name === # "eq_tripwire" || weapon.name === # "trophy_system" || weapon.name === # "eq_concertina_wire" || weapon.name === # "eq_sensor" || weapon.name === # "cymbal_monkey" || weapon.name === # "homunculus") {
      return true;
    }
  }

  return false;
}

function function_777e012d(t_damage) {
  self endon(#"death");
  level endon(#"start_warzone");

  if(!isDefined(t_damage)) {
    return;
  }

  equipment = getentitiesinradius(t_damage.origin, 1536);

  foreach(device in equipment) {
    if(isDefined(device) && device istouching(t_damage)) {
      if(is_equipment(device)) {
        switch (device.weapon.name) {
          case # "eq_tripwire":
            device[[level.var_2e06b76a]]();
            break;
          case # "trophy_system":
            device[[level.var_4f3822f4]]();
            break;
          case # "cymbal_monkey":
            device[[level.var_7c5c96dc]]();
            break;
          case # "homunculus":
            device[[level.var_cc310d06]]();
            break;
          case # "eq_sensor":
            device[[level.var_9911d36f]]();
            break;
          case # "eq_concertina_wire":
            device[[level.var_94029383]]();
            break;
          case # "gadget_supplypod":
            device notify(#"death");
            break;
          default:
            device kill();
            break;
        }
      }
    }
  }
}

function elevator_kill_player(t_damage) {
  self endon(#"death");
  level endon(#"start_warzone");

  if(!isDefined(t_damage)) {
    return;
  }

  foreach(e_player in getplayers()) {
    if(e_player istouching(t_damage) && isalive(e_player) && isDefined(e_player)) {
      if(level.inprematchperiod) {
        var_96c44bd9 = 1;
        str_targetname = t_damage.targetname;

        if(isstring(str_targetname)) {
          var_96c44bd9 = str_targetname[8];
        }

        point = struct::get("elevator_teleport_" + var_96c44bd9, "targetname");
        var_8bd17d7d = anglesToForward(point.angles);
        var_8bd17d7d = vectornormalize(var_8bd17d7d);

        if(isDefined(point)) {
          e_player function_211e7277(point, var_8bd17d7d);
        }

        continue;
      }

      var_1c8ad6c7 = level flag::get(#"insertion_teleport_completed");

      if(var_1c8ad6c7) {
        e_player.var_1a776c13 = 1;
        e_player suicide();
      }
    }
  }
}

function function_8e73d913() {
  util::wait_network_frame(2);

  if(isDefined(self)) {
    self delete();
  }
}

function function_26ab1b5e(t_damage) {
  self endon(#"death");
  level endon(#"start_warzone");

  if(!isDefined(t_damage)) {
    return;
  }

  vehicles = getentitiesinradius(t_damage.origin, 1536, 12);

  foreach(e_vehicle in vehicles) {
    if(e_vehicle istouching(t_damage) && isalive(e_vehicle)) {
      var_38ae32ff = e_vehicle.origin - t_damage.origin;
      var_8fa58819 = var_38ae32ff[2];
      var_8fa58819 *= var_8fa58819;

      if(var_8fa58819 < 32 || e_vehicle.scriptvehicletype === # "helicopter_light") {
        a_players = e_vehicle getvehoccupants();
        e_vehicle.takedamage = 1;
        e_vehicle.allowdeath = 1;
        e_vehicle dodamage(e_vehicle.health + 10000, e_vehicle.origin, undefined, undefined, "none", "MOD_EXPLOSIVE", 8192);
        waitframe(1);
        e_vehicle thread function_8e73d913();

        foreach(player in a_players) {
          if(isalive(player) && isDefined(player) && !player isremotecontrolling()) {
            if(level.inprematchperiod) {
              var_96c44bd9 = 1;
              str_targetname = t_damage.targetname;

              if(isstring(str_targetname)) {
                var_96c44bd9 = str_targetname[8];
              }

              point = struct::get("elevator_teleport_" + var_96c44bd9, "targetname");
              var_8bd17d7d = anglesToForward(point.angles);
              var_8bd17d7d = vectornormalize(var_8bd17d7d);

              if(isDefined(point)) {
                player function_211e7277(point, var_8bd17d7d);
              }

              continue;
            }

            var_1c8ad6c7 = level flag::get(#"insertion_teleport_completed");

            if(var_1c8ad6c7) {
              player.var_1a776c13 = 1;
              player suicide();
            }
          }
        }
      }
    }
  }
}

function function_76ad6828(position) {
  self endon(#"death");

  if(isDefined(self.script_noteworthy) && isDefined(position)) {
    var_a91da4b7 = self.script_noteworthy + "_player";
    var_bda7a712 = self.script_noteworthy + "_vehicle";
    var_68dc3bdf = getent(var_a91da4b7, "targetname");
    t_damage_vehicle = getent(var_bda7a712, "targetname");

    if(isDefined(var_68dc3bdf) && isDefined(t_damage_vehicle)) {
      var_d011282b = distancesquared(self.origin, position.origin);

      while(var_d011282b > 16) {
        var_d011282b = distancesquared(self.origin, position.origin);

        if(var_d011282b <= 5000) {
          self thread function_777e012d(var_68dc3bdf);
          self thread function_26ab1b5e(t_damage_vehicle);
          self thread elevator_kill_player(var_68dc3bdf);
        }

        waitframe(1);
      }
    }
  }
}

function elevator_move(elevator) {
  position = struct::get(elevator.var_d98394f7.target, "targetname");
  elevator.button triggerenable(0);

  if(isDefined(elevator.script_noteworthy) && position.script_noteworthy === "start") {
    elevator thread function_76ad6828(position);
  }

  elevator.moving = 1;
  elevator.button playSound("evt_elevator_button_bell");
  elevator callback::callback(#"hash_5a18bf6aa6ae81c6", {
    #current_position: struct::get(elevator.currentfloor.target, "targetname")
  });
  wait 0.5;
  elevator thread function_ad26976();
  elevator playSound("evt_elevator_start");
  elevator playLoopSound("evt_elevator_move", 0);
  elevator moveto(position.origin, 10, 0.5, 0.5);
  setdynentstate(elevator.var_d98394f7, 1);
  setdynentstate(elevator.currentfloor, 1);
  var_d98394f7 = elevator.currentfloor;
  elevator.currentfloor = elevator.var_d98394f7;
  elevator.var_d98394f7 = var_d98394f7;
  elevator waittill(#"movedone");
  elevator playSound("evt_elevator_stop");
  elevator stoploopsound(1);
  elevator.moving = 0;
  elevator.button.origin = elevator.origin + elevator.var_e87f4c9;
  elevator callback::callback(#"hash_15c98df2b5cc27ae", {
    #current_position: struct::get(elevator.currentfloor.target, "targetname")
  });

  if(elevator.var_d98394f7 == elevator.var_8273f574) {
    elevator.button sethintstring(#"hash_310ad55f171e194e");
  } else {
    elevator.button sethintstring(#"hash_29965b65bca9cd7b");
  }

  setdynentstate(elevator.var_d98394f7, 0);
  elevator.button triggerenable(1);
}

function function_af088c90(trigger_struct) {
  trigger = self;
  activator = trigger_struct.activator;
  elevator = trigger.elevator;
  activator gestures::function_56e00fbf("gestable_door_interact", undefined, 0);
  elevator_move(elevator);
}

function function_31042f91(activator, laststate, state) {
  if(isDefined(self.target)) {
    position = struct::get(self.target, "targetname");
    elevator = getent(position.target, "targetname");

    if(is_true(elevator.moving)) {
      elevator waittill(#"movedone");
    }

    elevator_move(elevator);
  }
}