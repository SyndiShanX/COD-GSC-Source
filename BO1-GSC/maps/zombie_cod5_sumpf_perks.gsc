/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cod5_sumpf_perks.gsc
********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;

randomize_vending_machines() {
  if(level.mutators["mutator_noPerks"]) {
    return;
  }
  vending_machines = [];
  vending_machines = getEntArray("zombie_vending", "targetname");
  for(i = 0; i < vending_machines.size; i++) {
    if(vending_machines[i].script_noteworthy == "specialty_additionalprimaryweapon") {
      vending_machines = array_remove(vending_machines, vending_machines[i]);
      break;
    }
  }
  start_locations = [];
  start_locations[0] = getEnt("random_vending_start_location_0", "script_noteworthy");
  start_locations[1] = getEnt("random_vending_start_location_1", "script_noteworthy");
  start_locations[2] = getEnt("random_vending_start_location_2", "script_noteworthy");
  start_locations[3] = getEnt("random_vending_start_location_3", "script_noteworthy");
  level.start_locations = [];
  level.start_locations[level.start_locations.size] = start_locations[0].origin;
  level.start_locations[level.start_locations.size] = start_locations[1].origin;
  level.start_locations[level.start_locations.size] = start_locations[2].origin;
  level.start_locations[level.start_locations.size] = start_locations[3].origin;
  start_locations = array_randomize(start_locations);
  for(i = 0; i < vending_machines.size; i++) {
    origin = start_locations[i].origin;
    angles = start_locations[i].angles;
    machine = vending_machines[i] get_vending_machine(start_locations[i]);
    start_locations[i].origin = origin;
    start_locations[i].angles = angles;
    machine.origin = origin;
    machine.angles = angles;
    machine hide();
    vending_machines[i] trigger_on();
    if(flag("solo_game")) {
      if(vending_machines[i].script_noteworthy == "specialty_quickrevive") {
        vending_machines[i] thread solo_disable_quickrevive();
      }
    }
  }
}

solo_disable_quickrevive() {
  flag_wait("solo_revive");
  self unlink();
  self trigger_off();
}

get_vending_machine(start_location) {
  machine = undefined;
  machine_clip = undefined;
  machine_array = getEntArray(self.target, "targetname");
  for(i = 0; i < machine_array.size; i++) {
    if(isDefined(machine_array[i].script_noteworthy) && machine_array[i].script_noteworthy == "clip") {
      machine_clip = machine_array[i];
    } else {
      machine = machine_array[i];
    }
  }
  if(!isDefined(machine)) {
    return;
  }
  if(isDefined(machine_clip)) {
    machine_clip LinkTo(machine);
  }
  start_location.origin = machine.origin;
  start_location.angles = machine.angles;
  self enablelinkto();
  self linkto(start_location);
  return machine;
}

activate_vending_machine(machine, origin, entity) {
  level notify("master_switch_activated");
  switch (machine) {
    case "zombie_vending_jugg_on":
      level notify("juggernog_sumpf_on");
      level notify("specialty_armorvest_power_on");
      clientnotify("jugg_on");
      entity maps\_zombiemode_perks::perk_fx("jugger_light");
      break;
    case "zombie_vending_doubletap_on":
      level notify("doubletap_sumpf_on");
      level notify("specialty_rof_power_on");
      clientnotify("doubletap_on");
      entity maps\_zombiemode_perks::perk_fx("doubletap_light");
      break;
    case "zombie_vending_revive_on":
      level notify("revive_sumpf_on");
      level notify("specialty_quickrevive_power_on");
      clientnotify("revive_on");
      entity maps\_zombiemode_perks::perk_fx("revive_light");
      break;
    case "zombie_vending_sleight_on":
      level notify("sleight_sumpf_on");
      level notify("specialty_fastreload_power_on");
      clientnotify("fast_reload_on");
      entity maps\_zombiemode_perks::perk_fx("sleight_light");
      break;
  }
  play_vending_vo(machine, origin);
}

play_vending_vo(machine, origin) {
  players = get_players();
  players = get_array_of_closest(origin, players, undefined, undefined, 512);
  player = undefined;
  for(i = 0; i < players.size; i++) {
    if(SightTracePassed(players[i] getEye(), origin, false, undefined)) {
      player = players[i];
    }
  }
  if(!isDefined(player)) {
    return;
  }
  switch (machine) {
    case "zombie_vending_jugg_on":
      player thread maps\_zombiemode_audio::create_and_play_dialog("level", "jugga");
      break;
    case "zombie_vending_doubletap_on":
      player thread maps\_zombiemode_audio::create_and_play_dialog("level", "doubletap");
      break;
    case "zombie_vending_revive_on":
      player thread maps\_zombiemode_audio::create_and_play_dialog("level", "revive");
      break;
    case "zombie_vending_sleight_on":
      player thread maps\_zombiemode_audio::create_and_play_dialog("level", "speed");
      break;
  }
}

vending_randomization_effect(index) {
  if(level.mutators["mutator_noPerks"]) {
    return;
  }
  vending_triggers = getEntArray("zombie_vending", "targetname");
  machines = [];
  for(j = 0; j < vending_triggers.size; j++) {
    machine_array = getEntArray(vending_triggers[j].target, "targetname");
    for(i = 0; i < machine_array.size; i++) {
      if(isDefined(machine_array[i].script_noteworthy) && machine_array[i].script_noteworthy == "clip") {
        continue;
      } else {
        machines[j] = machine_array[i];
      }
    }
  }
  for(j = 0; j < machines.size; j++) {
    if(machines[j].origin == level.start_locations[index]) {
      break;
    }
  }
  if(isDefined(level.first_time_opening_perk_hut)) {
    if(level.first_time_opening_perk_hut) {
      if(machines[j].model != "zombie_vending_jugg_on" || machines[j].model != "zombie_vending_sleight_on") {
        for(i = 0; i < machines.size; i++) {
          if(i != j && (machines[i].model == "zombie_vending_jugg_on" || machines[i].model == "zombie_vending_sleight_on")) {
            break;
          }
        }
        start_locations = [];
        start_locations[0] = getEnt("random_vending_start_location_0", "script_noteworthy");
        start_locations[1] = getEnt("random_vending_start_location_1", "script_noteworthy");
        start_locations[2] = getEnt("random_vending_start_location_2", "script_noteworthy");
        start_locations[3] = getEnt("random_vending_start_location_3", "script_noteworthy");
        target_index = undefined;
        switch_index = undefined;
        for(x = 0; x < start_locations.size; x++) {
          if(start_locations[x].origin == level.start_locations[index]) {
            target_index = x;
          }
          if(start_locations[x].origin == machines[i].origin) {
            switch_index = x;
          }
        }
        temp_origin = machines[j].origin;
        temp_angles = machines[j].angles;
        machines[j].origin = machines[i].origin;
        machines[j].angles = machines[i].angles;
        start_locations[target_index].origin = start_locations[switch_index].origin;
        start_locations[target_index].angles = start_locations[switch_index].angles;
        machines[i].origin = temp_origin;
        machines[i].angles = temp_angles;
        start_locations[switch_index].origin = temp_origin;
        start_locations[switch_index].angles = temp_angles;
        j = i;
      }
      level.first_time_opening_perk_hut = false;
    }
  }
  playsoundatposition("rando_start", machines[j].origin);
  origin = machines[j].origin;
  if(level.vending_model_info.size > 1) {
    playFXOnTag(level._effect["zombie_perk_start"], machines[j], "tag_origin");
    playsoundatposition("rando_perk", machines[j].origin);
  } else {
    playFXOnTag(level._effect["zombie_perk_4th"], machines[j], "tag_origin");
    playsoundatposition("rando_perk", machines[j].origin);
  }
  true_model = machines[j].model;
  machines[j] setModel(true_model);
  machines[j] show();
  floatHeight = 40;
  level thread play_sound_2D("perk_lottery");
  machines[j] moveTo(origin + (0, 0, floatHeight), 5, 3, 0.5);
  tag_fx = spawn("script_model", machines[j].origin + (0, 0, 40));
  tag_fx setModel("tag_origin");
  tag_fx LinkTo(machines[j]);
  modelindex = 0;
  machines[j] Vibrate(machines[j].angles, 2, 1, 4);
  for(i = 0; i < 30; i++) {
    wait(0.15);
    if(level.vending_model_info.size > 1) {
      while(!isDefined(level.vending_model_info[modelindex])) {
        modelindex++;
        if(modelindex == 4) {
          modelindex = 0;
        }
      }
      modelname = level.vending_model_info[modelindex];
      machines[j] setModel(modelname);
      playFXOnTag(level._effect["zombie_perk_flash"], tag_fx, "tag_origin");
      modelindex++;
      if(modelindex == 4) {
        modelindex = 0;
      }
    }
  }
  modelname = true_model;
  machines[j] setModel(modelname);
  machines[j] moveTo(origin, 0.3, 0.3, 0);
  playFXOnTag(level._effect["zombie_perk_end"], machines[j], "tag_origin");
  playsoundatposition("perks_rattle", machines[j].origin);
  maps\zombie_cod5_sumpf_perks::activate_vending_machine(true_model, origin, machines[j]);
  for(i = 0; i < machines.size; i++) {
    if(isDefined(level.vending_model_info[i])) {
      if(level.vending_model_info[i] == true_model) {
        level.vending_model_info[i] = undefined;
        break;
      }
    }
  }
}