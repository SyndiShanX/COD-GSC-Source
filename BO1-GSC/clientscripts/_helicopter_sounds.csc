/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_helicopter_sounds.csc
************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_audio;

init() {
  level._entityShutDownCBFunc = clientscripts\_helicopter_sounds::heli_linkto_sound_ents_delete;
  level.heliSoundValues = [];
  init_heli_sound_values("huey", "cockpit", 65, 0.6, 0.8, 65, 1, 1.1);
  init_heli_sound_values("huey", "cockpit2", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "int_eng", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "int_eng2", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "int_eng3", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "ext_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("hind", "cockpit", 95, 0.6, 0.8, 95, 1, 1.1);
  init_heli_sound_values("hind", "cockpit2", 95, 0.5, 0.8, 95, 1, 1.2);
  init_heli_sound_values("hind", "int_eng", 65, 0.5, 0.8, 65, 1, 1.1);
  init_heli_sound_values("hind", "int_eng2", 65, 0.4, 0.9, 65, 1, 1.1);
  init_heli_sound_values("hind", "eng_dmg", 40, 0.3, 0.5, 65, 1, 1.1);
  init_heli_sound_values("hind", "ext_rotor", 70, 0.5, 1, 70, 0.95, 1.1);
  init_heli_sound_values("hip", "turbine", 15, 0.85, 1, 20, 1, 1.0);
  init_heli_sound_values("hip", "top_rotor", 15, 0.85, 1, 20, 0.95, 1);
  init_heli_sound_values("hip", "tail_rotor", 15, 0.85, 1, 20, 0.95, 1.1);
  init_heli_sound_values("hind_enemy", "turbine", 45, 0.6, 0.8, 65, 1, 1.0);
  init_heli_sound_values("hind_enemy", "top_rotor", 15, 0.5, 1, 25, 0.95, 1.0);
  init_heli_sound_values("hind_enemy", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.0);
  init_heli_sound_values("huey_toda", "turbine", 25, 0.75, 0.8, 65, 1, 1);
  init_heli_sound_values("huey_toda", "top_rotor", 15, 0.85, 1, 25, 0.95, 1);
  init_heli_sound_values("huey_toda", "tail_rotor", 25, 0.95, 1, 35, 0.95, 1);
  init_heli_sound_values("heli_chinook", "turbine", 15, 0.80, 1, 35, 0.95, 1.05);
  init_heli_sound_values("heli_chinook", "top_rotor", 15, 0.80, 1, 35, 0.95, 1.05);
  init_heli_sound_values("huey_player", "turbine", 65, 0.6, 0.8, 65, 1, 1.1);
  init_heli_sound_values("huey_player", "top_rotor", 45, 0.5, 1, 45, 0.95, 1.1);
  init_heli_sound_values("huey_player", "tail_rotor", 45, 0.5, 1, 45, 0.95, 1.0);
  init_heli_sound_values("huey_player", "wind_rt", 45, 0.5, 1, 45, 0.95, 1.0);
  init_heli_sound_values("huey_player", "wind_lft", 45, 0.5, 1, 45, 0.95, 1.0);
}

init_heli_sound_values(heli_type, part_type, max_speed_vol, min_vol, max_vol, max_speed_pitch, min_pitch, max_pitch) {
  if(!isDefined(level.heliSoundValues[heli_type])) {
    level.heliSoundValues[heli_type] = [];
  }
  if(!isDefined(level.heliSoundValues[heli_type][part_type])) {
    level.heliSoundValues[heli_type][part_type] = spawnStruct();
  }
  level.heliSoundValues[heli_type][part_type].speedVolumeMax = max_speed_vol;
  level.heliSoundValues[heli_type][part_type].speedPitchMax = max_speed_pitch;
  level.heliSoundValues[heli_type][part_type].volumeMin = min_vol;
  level.heliSoundValues[heli_type][part_type].volumeMax = max_vol;
  level.heliSoundValues[heli_type][part_type].pitchMin = min_pitch;
  level.heliSoundValues[heli_type][part_type].pitchMax = max_pitch;
  if(getdvarint(#"debug_heli") > 0) {
    println("Init Heli Sounds heli_type: " + heli_type);
    println("Init Heli Sounds part_type: " + part_type);
    println("Init Heli Sounds max_speed_vol: " + max_speed_vol);
    println("Init Heli Sounds min_vol: " + min_vol);
    println("Init Heli Sounds max_vol: " + max_vol);
    println("Init Heli Sounds max_speed_pitch: " + max_speed_pitch);
    println("Init Heli Sounds min_pitch: " + min_pitch);
    println("Init Heli Sounds max_pitch: " + max_pitch);
  }
}

init_heli_sounds_huey_toda() {
  self setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_hind_turbine");
  self setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_hind_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", "veh_hind_tail");
  self setup_heli_sounds("lfe", "engine", "snd_rotor", "veh_hind_rotor_lfe");
}

init_heli_sounds_huey() {
  self setup_heli_sounds("cockpit", "engine", "snd_cockpit", "veh_huey_whine_int_idle");
  self setup_heli_sounds("cockpit2", "engine", "snd_rotor", "veh_huey_hf_int_idle");
  self setup_heli_sounds("int_eng", "engine", "snd_rotor", "veh_huey_lf_int_idle");
  self setup_heli_sounds("int_eng2", "engine", "snd_tail_rotor", "veh_huey_dist_idle");
  self setup_heli_sounds("int_eng3", "engine", "snd_wind_right", "veh_huey_ringing_dist");
  self setup_heli_sounds("ext_rotor", "engine", "snd_wind_left", "veh_huey_rotor_idle");
}

init_heli_sounds_hind() {
  self setup_heli_sounds("cockpit", "engine", "snd_cockpit", "veh_hind_whine_int_idle");
  self setup_heli_sounds("cockpit2", "engine", "snd_cockpit", "veh_hind_hf_int_idle");
  self setup_heli_sounds("int_eng", "engine", "snd_int_rotor", "veh_hind_lf_int_idle");
  self setup_heli_sounds("int_eng2", "engine", "snd_int_rotor", "veh_hind_dist_idle1");
  self setup_heli_sounds("ext_rotor", "engine", "snd_rotor", "veh_hind_rotor_idle");
  self setup_heli_sounds("eng_dmg", "engine", "snd_int_rotor", "veh_hind_sputter");
  self setup_heli_sounds("eng_dmg_alarm", "engine", "snd_cockpit", "veh_hind_alarm_damage_high_loop");
}

init_heli_sounds_hip() {
  self setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_hip_turbine");
  self setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_hip_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "snd_rotor", "veh_hip_tail");
  self setup_heli_sounds("lfe", "engine", "snd_rotor", "veh_hip_rotor_lfe");
}

init_heli_sounds_chinook() {
  self setup_heli_sounds("turbine", "engine", "tag_origin", "veh_chinook_turbine");
  self setup_heli_sounds("top_rotor", "engine", "main_rotor_jnt", "veh_chinook_rotor");
  self setup_heli_sounds("top_rotor", "engine", "tail_rotor_jnt", "veh_chinook_rotor");
  self setup_heli_sounds("lfe", "engine", "tag_origin", "veh_chinook_rotor_lfe");
}

init_heli_sounds_hind_enemy() {
  self setup_heli_sounds("lfe", "engine", "snd_cockpit", "veh_hind_epow_rotor_lfe");
  self setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_hind_epow_turbine");
  self setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_hind_epow_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", "veh_hind_epow_tail");
}

init_heli_sounds_hind_vorkuta() {
  self setup_heli_sounds("lfe", "engine", "snd_cockpit", "veh_hind_rotor_lfe");
  self setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_hind_turbine");
  self setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_hind_rotor");
  self setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", "veh_hind_tail");
}

init_heli_sounds_huey_player() {
  setup_heli_sounds("lfe", "engine", "snd_cockpit", "veh_huey_rotor_lfe");
  setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_huey_turbine");
  setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_huey_rotor");
  setup_heli_sounds("tail_rotor", "engine", "snd_tail_rotor", "veh_huey_tail");
  setup_heli_sounds("wind_rt", "engine", "snd_wind_right", "veh_huey_door_wind");
  setup_heli_sounds("wind_lft", "engine", "snd_wind_left", "veh_huey_door_wind");
  setup_heli_sounds("radio", "engine", "snd_cockpit", "veh_huey_radio");
}

init_heli_sounds_zombietron() {
  self setup_heli_sounds("turbine", "engine", "snd_rotor", "veh_hind_turbine_zt");
  self setup_heli_sounds("top_rotor", "engine", "snd_rotor", "veh_hind_rotor_zt");
}

setup_heli_sounds(bone_location, type, tag, run, dmg1, dmg2, dmg3) {
  self.heli[bone_location] = spawnStruct();
  self.heli[bone_location].sound_type = type;
  self.heli[bone_location].run = spawn(0, self.origin, "script_origin");
  self.heli[bone_location].run linkto(self, tag);
  self.heli[bone_location].run.alias = run;
  self.sound_ents[self.sound_ents.size] = self.heli[bone_location].run;
  self thread delete_loop_sound_save_restore(self.heli[bone_location].run);
  if(isDefined(dmg1)) {
    self.heli[bone_location].dmg1 = spawn(0, self.origin, "script_origin");
    self.heli[bone_location].dmg1 linkto(self, tag);
    self.heli[bone_location].dmg1.alias = dmg1;
    self.sound_ents[self.sound_ents.size] = self.heli[bone_location].dmg1;
    self thread delete_loop_sound_save_restore(self.heli[bone_location].dmg1);
  }
  if(isDefined(dmg2)) {
    self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
    self.heli[bone_location].idle linkto(self, tag);
    self.heli[bone_location].idle.alias = dmg2;
    self.sound_ents[self.sound_ents.size] = self.heli[bone_location].dmg2;
    self thread delete_loop_sound_save_restore(self.heli[bone_location].dmg2);
  }
  if(isDefined(dmg3)) {
    self.heli[bone_location].idle = spawn(0, self.origin, "script_origin");
    self.heli[bone_location].idle linkto(self, tag);
    self.heli[bone_location].idle.alias = dmg3;
    self.sound_ents[self.sound_ents.size] = self.heli[bone_location].dmg3;
    self thread delete_loop_sound_save_restore(self.heli[bone_location].dmg3);
  }
}

init_terrain_sounds() {
  self.surface_type = [];
  self.surface_type["default"] = "dirt";
  self.surface_type["metal"] = "dirt";
  self.surface_type["concrete"] = "dirt";
  self.surface_type["wood"] = "dirt";
  self.surface_type["dirt"] = "dirt";
  self.surface_type["gravel"] = "dirt";
  self.surface_type["grass"] = "dirt";
  self.surface_type["mud"] = "dirt";
  self.surface_type["snow"] = "dirt";
  self.surface_type["asphalt"] = "dirt";
  self.surface_type["brick"] = "dirt";
  self.surface_type["glass"] = "dirt";
  self.surface_type["plaster"] = "dirt";
  self.surface_type["sand"] = "dirt";
  self.surface_type["rock"] = "dirt";
  self.surface_type["water"] = "water";
  self.surface_type["foliage"] = "dirt";
  self setup_terrain_sounds("dirt", "veh_chopper_prop_wash_dirt");
  self setup_terrain_sounds("water", "veh_chopper_prop_wash_water");
}

setup_terrain_sounds(surface_type, alias) {
  self.terrain_ent_array[surface_type] = spawn(0, self.origin, "script_origin");
  self.terrain_ent_array[surface_type].alias = alias;
  self thread terrain_loop_sound_delete(self.terrain_ent_array[surface_type]);
}

start_helicopter_sounds(localClientNum) {
  if(isDefined(self.vehicletype)) {
    self.heli = [];
    self.terrain = [];
    self.sound_ents = [];
    self.cur_speed = 0;
    self.idle_run_trans_speed = 5;
    play_terrain_sounds = true;
    switch (self.vehicletype) {
      case "zombie_cobra":
        self init_heli_sounds_huey();
        self play_huey_sounds();
        printLn("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");
        break;
      case "heli_huey_small":
      case "heli_huey_gunship":
        self init_heli_sounds_huey();
        self play_huey_sounds();
        printLn("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");
        break;
      case "heli_hind_player":
        self init_heli_sounds_hind();
        self play_hind_sounds();
        printLn("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");
        break;
      case "heli_hind":
      case "heli_hind_doublesize":
      case "heli_hind_doublesize_uwb":
      case "heli_hind_river":
        self init_heli_sounds_hind_enemy();
        self play_hind_enemy_sounds();
        printLn("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");
        break;
      case "heli_hip":
      case "rebirth_heli_hip_sidegun_spotlight":
      case "heli_hip_sidegun_spotlight":
      case "heli_hip_noseturret":
      case "heli_cobra":
      case "heli_cobra_khesanh":
      case "heli_hip_sidegun_uwb":
        self init_heli_sounds_hip();
        self play_hip_sounds();
        printLn("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");
        break;
      case "heli_huey_assault":
      case "heli_huey":
      case "heli_huey_usmc_heavyhog":
      case "heli_huey_usmc":
      case "heli_huey_usmc_khesanh":
      case "heli_huey_side_minigun":
      case "heli_huey_player":
      case "heli_huey_player_uwb":
      case "heli_huey_heavyhog_river":
      case "heli_huey_assault_river":
      case "heli_huey_gunship_river":
      case "heli_huey_usmc_khesanh_std":
      case "heli_huey_medivac_khesanh":
      case "heli_huey_usmc_heavyhog_khesanh":
      case "heli_huey_medivac_river":
      case "heli_huey_side_minigun_uwb":
      case "heli_huey_vista":
        self init_heli_sounds_huey_toda();
        self play_huey_toda_sounds();
        printLn("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");
        break;
      case "heli_chinook":
      case "heli_seaknight":
        self init_heli_sounds_chinook();
        self play_chinook_sounds();
        printLn("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");
        break;
      case "heli_huey_heavyhog_creek":
      case "heli_huey_heavyhog":
      case "heli_hip_sidegun":
      case "heli_hip_spotlight":
        self init_heli_sounds_hind_vorkuta();
        self play_hind_sounds_vorkuta();
        printLn("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");
        break;
      case "heli_mini_zt":
        self init_heli_sounds_zombietron();
        self play_hind_sounds_zombietron();
        printLn("helicopter type: " + self.vehicletype + " found; playing helicopter sounds");
        break;
      default:
        play_terrain_sounds = false;
        printLn("^5helicopter type: " + self.vehicletype + " NOT FOUND; playing NO helicopter sounds");
        break;
    }
    if(play_terrain_sounds) {
      self init_terrain_sounds();
      self thread terrain_trace();
    }
  } else {
    printLn("^6helicopter type: " + self.vehicletype + " not defined");
  }
}

delete_loop_sound_save_restore(real_ent) {
  self endon("heli_entityshutdown");
  level waittill("save_restore");
  PrintLn("heli_script: got save restoring");
  if(isDefined(real_ent)) {
    PrintLn("heli_script: killing helicopter sound ent");
    real_ent stopLoopSound(0);
    real_ent Delete();
  }
}

terrain_loop_sound_delete(real_ent) {
  self thread delete_loop_sound_save_restore(real_ent);
  level endon("save_restore");
  self waittill("entityshutdown");
  self notify("heli_entityshutdown");
  PrintLn("heli_script: deleting terrain ents");
  if(isDefined(real_ent)) {
    real_ent stopLoopSound(4);
    real_ent Delete();
  }
}

heli_linkto_sound_ents_delete(localClientNum, entity) {
  entity notify("heli_entityshutdown");
  array_thread(entity.sound_ents, ::heli_delete_sound_loops);
}

heli_delete_sound_loops() {
  PrintLn("heli_script: deleting linkto ents");
  if(isDefined(self)) {
    self stopLoopSound(4);
    self Delete();
  }
}

play_hind_sounds() {
  self thread heli_idle_run_transition("hind", "cockpit");
  self thread heli_idle_run_transition("hind", "cockpit2");
  self thread heli_idle_run_transition("hind", "int_eng");
  self thread heli_idle_run_transition("hind", "int_eng2");
  self thread heli_idle_run_transition("hind", "ext_rotor");
}

play_hind_enemy_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("hind_enemy", "turbine");
  self thread heli_idle_run_transition("hind_enemy", "top_rotor");
  self thread heli_idle_run_transition("hind_enemy", "tail_rotor");
}

play_huey_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("huey", "cockpit");
  self thread heli_idle_run_transition("huey", "cockpit2");
  self thread heli_idle_run_transition("huey", "int_eng");
  self thread heli_idle_run_transition("huey", "int_eng2");
  self thread heli_idle_run_transition("huey", "int_eng3");
  self thread heli_idle_run_transition("huey", "ext_rotor");
}

play_hip_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("hip", "turbine");
  self thread heli_idle_run_transition("hip", "top_rotor");
  self thread heli_idle_run_transition("hip", "tail_rotor");
}

play_huey_toda_sounds() {
  self thread heli_sound_play(self.heli["lfe"]);
  self thread heli_idle_run_transition("huey_toda", "turbine");
  self thread heli_idle_run_transition("huey_toda", "top_rotor");
  self thread heli_idle_run_transition("huey_toda", "tail_rotor");
}

play_chinook_sounds() {
  self thread heli_idle_run_transition("heli_chinook", "top_rotor");
  self thread heli_idle_run_transition("heli_chinook", "turbine");
  self thread heli_sound_play(self.heli["lfe"]);
}

play_hind_sounds_vorkuta() {
  self thread heli_idle_run_transition("hip", "turbine");
  self thread heli_idle_run_transition("hip", "top_rotor");
  self thread heli_idle_run_transition("hip", "tail_rotor");
}

play_hind_sounds_zombietron() {
  self thread heli_idle_run_transition("hip", "turbine");
  self thread heli_idle_run_transition("hip", "top_rotor");
}

play_heli_sounds_huey_player() {
  self heli_sound_play(self.heli["lfe"]);
  self heli_sound_play(self.heli["radio"]);
  self thread heli_idle_run_transition("huey_player", "turbine");
  self thread heli_idle_run_transition("huey_player", "top_rotor");
  self thread heli_idle_run_transition("huey_player", "tail_rotor");
  self thread heli_idle_run_transition("huey_player", "wind_rt");
  self thread heli_idle_run_transition("huey_player", "wind_lft");
}

heli_sound_play(heli_bone) {
  self endon("entityshutdown");
  level endon("save_restore");
  while(1) {
    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      heli_bone.run stopLoopSound(0.5);
      self waittill("play_heli_sounds");
    }
    heli_bone.run playLoopSound(heli_bone.run.alias, 2);
    self waittill("stop_heli_sounds");
  }
}

heli_idle_run_transition(heli_type, heli_part) {
  self endon("entityshutdown");
  level endon("save_restore");
  MPH_TO_INCHES_PER_SEC = 17.6;
  heli_bone = self.heli[heli_part];
  run_id = undefined;
  heli_damage = "none";
  if(!isDefined(level.heliSoundValues[heli_type])) {
    printLn("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "'.");
    return;
  }
  if(!isDefined(level.heliSoundValues[heli_type][heli_part])) {
    printLn("^5a speed vol/pitch parameter was not defined for heli_type '" + heli_type + "' and heli_part '" + heli_part + "'.");
    return;
  }
  while(isDefined(self)) {
    wait(0.5);
    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      heli_bone.run stopLoopSound(0.5);
      run_id = undefined;
      self waittill("play_heli_sounds");
      continue;
    }
    if(!isDefined(run_id)) {
      run_id = heli_bone.run playLoopSound(heli_bone.run.alias, 0.5);
    }
    max_speed_vol = level.heliSoundValues[heli_type][heli_part].speedVolumeMax;
    min_vol = level.heliSoundValues[heli_type][heli_part].volumeMin;
    max_vol = level.heliSoundValues[heli_type][heli_part].volumeMax;
    max_speed_pitch = level.heliSoundValues[heli_type][heli_part].speedPitchMax;
    min_pitch = level.heliSoundValues[heli_type][heli_part].pitchMin;
    max_pitch = level.heliSoundValues[heli_type][heli_part].pitchMax;
    self.cur_speed = self getspeed() / MPH_TO_INCHES_PER_SEC;
    run_volume = scale_speed(self.idle_run_trans_speed, max_speed_vol, min_vol, max_vol, self.cur_speed);
    run_pitch = scale_speed(self.idle_run_trans_speed, max_speed_pitch, min_pitch, max_pitch, self.cur_speed);
    if(isDefined(run_volume) && isDefined(run_pitch)) {
      setSoundVolume(run_id, run_volume);
      setSoundPitch(run_id, run_pitch);
      setSoundPitchRate(run_id, 0.25);
      if(isDefined(self.isdamaged) && (heli_damage == "none")) {
        return;
      }
      if(getdvarint(#"debug_heli") > 0) {
        printLn("^5a self.cur_speed = " + self.cur_speed);
        printLn("^5a run_pitch . " + run_pitch);
        printLn("^5a self.cur_speed = " + self.cur_speed);
        printLn("^5a run_volume. " + run_volume);
      }
    }
  }
}

terrain_trace() {
  self endon("entityshutdown");
  level endon("save_restore");
  trace = undefined;
  trace_ent = self;
  pre_terrain = undefined;
  next_terrain = undefined;
  pre_trace_real_ent = undefined;
  trace_real_ent = undefined;
  pre_origin = (100000, 100000, 100000);
  while(isDefined(self)) {
    wait(1 + RandomFloatRange(0.0, 0.2));
    if(isDefined(self.should_not_play_sounds) && self.should_not_play_sounds) {
      if(isDefined(pre_trace_real_ent)) {
        pre_trace_real_ent stopLoopSound();
      }
      if(isDefined(trace_real_ent)) {
        trace_real_ent stopLoopSound();
      }
      self waittill("play_heli_sounds");
      continue;
    }
    if(DistanceSquared(pre_origin, trace_ent.origin) < 144) {
      continue;
    }
    pre_origin = trace_ent.origin;
    trace = tracepoint(trace_ent.origin, trace_ent.origin - (0, 0, 100000));
    trace_surface_type = trace["surfacetype"];
    if(!isDefined(trace)) {
      continue;
    }
    pre_terrain = next_terrain;
    next_terrain = trace_surface_type;
    if(!isDefined(pre_terrain) || !isDefined(next_terrain)) {
      continue;
    }
    if(!isDefined(self.surface_type[next_terrain]) || !isDefined(self.surface_type[pre_terrain])) {
      continue;
    }
    surf_type = self.surface_type[next_terrain];
    trace_real_ent = self.terrain_ent_array[surf_type];
    pre_surf_type = self.surface_type[pre_terrain];
    pre_trace_real_ent = self.terrain_ent_array[pre_surf_type];
    if(!isDefined(trace["position"])) {
      if(isDefined(pre_trace_real_ent)) {
        pre_trace_real_ent stopLoopSound(0.5);
      }
      continue;
    }
    trace_real_ent.origin = trace["position"];
    pre_trace_real_ent.origin = trace["position"];
    if(isDefined(surf_type)) {
      if((surf_type == pre_surf_type) && (pre_trace_real_ent IsPlayingLoopSound())) {
        continue;
      }
      pre_trace_real_ent stopLoopSound(0.5);
      trace_real_ent playLoopSound(trace_real_ent.alias, 0.5);
    }
  }
}

update_helicopter_sounds() {
  if(isDefined(self.engine_damage_low) && self.engine_damage_low) {
    switch (self.vehicletype) {
      case "heli_hind_player":
        if(!isDefined(self.low_dmg)) {
          self thread heli_idle_run_transition("hind", "eng_dmg");
        }
        self.low_dmg = true;
        playSound(0, "veh_hind_alarm_damage_high", (0, 0, 0));
        level.heliSoundValues["hind"]["cockpit"].volumeMax = 1;
        level.heliSoundValues["hind"]["ext_rotor"].pitchMax = 1.3;
        printLn("^5a activating heli sound damage stage 1");
        break;
      default:
        printLn("^5helicopter type: " + self.vehicletype + " vehicletype; has no helicopter damage sounds");
        break;
    }
  }
  if(isDefined(self.engine_damage_high) && self.engine_damage_high && isDefined(self.engine_damage_low) && !self.engine_damage_low) {
    switch (self.vehicletype) {
      case "heli_hind_player":
        level.heliSoundValues["hind"]["eng_dmg"].volumeMax = 1;
        level.heliSoundValues["hind"]["ext_rotor"].pitchMax = 1.5;
        wait(0.1);
        level.heliSoundValues["hind"]["eng_dmg"].volumeMin = 1;
        printLn("^5a activating heli sound damage stage 2");
        break;
      default:
        printLn("^5helicopter type: " + self.vehicletype + " vehicletype; has no helicopter damage sounds");
        break;
    }
  }
  if(isDefined(self.engine_damage_high) && self.engine_damage_high && isDefined(self.engine_damage_low) && self.engine_damage_low) {
    switch (self.vehicletype) {
      case "heli_hind_player":
        playSound(0, "veh_hind_alarm_damage_high", (0, 0, 0));
        level.heliSoundValues["hind"]["eng_dmg"].volumeMax = 1;
        level.heliSoundValues["hind"]["ext_rotor"].pitchMax = 1.5;
        wait(0.1);
        level.heliSoundValues["hind"]["eng_dmg"].volumeMin = 1;
        printLn("^5a activating heli sound damage stage 3");
        break;
      default:
        printLn("^5helicopter type: " + self.vehicletype + " vehicletype; has no helicopter damage sounds");
        break;
    }
  }
  if(isDefined(self.engine_damage_low) && !self.engine_damage_low && isDefined(self.engine_damage_high) && !self.engine_damage_high) {
    printLn("^5helicopter type: " + self.vehicletype + " vehicletype; Atempting to reset Defaults");
    switch (self.vehicletype) {
      case "heli_hind_player":
        init_heli_sound_values("hind", "cockpit", 95, 0.6, 0.8, 95, 1, 1.1);
        init_heli_sound_values("hind", "cockpit2", 95, 0.5, 0.8, 95, 1, 1.2);
        init_heli_sound_values("hind", "int_eng", 65, 0.5, 0.8, 65, 1, 1.1);
        init_heli_sound_values("hind", "int_eng2", 65, 0.4, 0.9, 65, 1, 1.3);
        init_heli_sound_values("hind", "eng_dmg", 40, 0.2, 0.4, 65, 1, 1.1);
        init_heli_sound_values("hind", "ext_rotor", 70, 0.5, 1, 70, 0.95, 1.1);
        printLn("^5a Setting Defaults ");
        break;
      default:
        printLn("^5helicopter type: " + self.vehicletype + " vehicletype; has no helicopter damage sounds");
        break;
    }
  }
}