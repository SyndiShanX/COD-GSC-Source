/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\so_sabotage_cliffhanger_code.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_specialops;
#include maps\_stealth_utility;
#include maps\_vehicle;
#include maps\_blizzard;

flag_init("challenge_start");
flag_init("sabotage_success");
flag_init("explosives_planted");
flag_init("stop_stealth_music");
flag_init("someone_became_alert");

flag_init("explosives_ready");

flag_init("destroyed_fallen_tree_cliffhanger01");
flag_init("script_attack_override");

flag_init("truck_guys_alerted");

flag_init("jeep_blown_up");
flag_init("jeep_stopped");
flag_init("first_two_guys_in_sight");

flag_init("done_with_stealth_camp");

flag_init("player_outside_compound");
}

set_flags() {
  flag_set("first_two_guys_in_sight");
}

spawn_funcs() {
  add_global_spawn_function("axis", ::enemy_nerf);

  array_thread(getEntArray("start_crate_patroller", "script_noteworthy"), ::add_spawn_function, ::tent_1_patrollers);
  array_thread(getEntArray("start_crate_patroller", "script_noteworthy"), ::add_spawn_function, ::tent_1_crate_patroller);
  array_thread(getEntArray("start_quonset_patroller", "script_noteworthy"), ::add_spawn_function, ::tent_1_patrollers);
  array_thread(getEntArray("right_side_start_guy", "script_noteworthy"), ::add_spawn_function, ::right_side_start_patroller);

  array_thread(getEntArray("2story_leaner", "script_noteworthy"), ::add_spawn_function, ::camp_leaner);
  array_thread(getEntArray("2story_sitter", "script_noteworthy"), ::add_spawn_function, ::twostory_sitter);
  array_thread(getEntArray("container_leaner", "script_noteworthy"), ::add_spawn_function, ::camp_leaner);

  array_thread(getEntArray("blue_building_smoker", "script_noteworthy"), ::add_spawn_function, maps\cliffhanger_code::reduce_footstep_detect_dist);
  array_thread(getEntArray("blue_building_loader", "script_noteworthy"), ::add_spawn_function, maps\cliffhanger_code::reduce_footstep_detect_dist);
  array_thread(getEntArray("blue_building_smoker", "script_noteworthy"), ::add_spawn_function, maps\cliffhanger_code::increase_fov_when_player_is_near);
  array_thread(getEntArray("blue_building_loader", "script_noteworthy"), ::add_spawn_function, maps\cliffhanger_code::increase_fov_when_player_is_near);

  wind_blown_flags = getEntArray("wind_blown_flag", "targetname");
  array_thread(wind_blown_flags, ::wind_blown_flag_think);
}

cliffhanger_dialogue() {
  level.scr_radio["cliff_pri_likeaghost"] = "cliff_pri_likeaghost";

  level.scr_radio["cliff_pri_keepeyeonheart"] = "cliff_pri_keepeyeonheart";

  level.scr_radio["cliff_pri_truckcomingback"] = "cliff_pri_truckcomingback";

  level.scr_radio["cliff_pri_truckiscoming"] = "cliff_pri_truckiscoming";

  level.scr_radio["cliff_pri_headsup"] = "cliff_pri_headsup";

  level.scr_radio["cliff_pri_lookingaround"] = "cliff_pri_lookingaround";

  level.scr_radio["cliff_pri_takecover"] = "cliff_pri_takecover";

  level.scr_radio["cliff_pri_beenspotted"] = "cliff_pri_beenspotted";

  level.scr_radio["cliff_pri_foundyou"] = "cliff_pri_foundyou";

  level.scr_radio["cliff_pri_multipledirections"] = "cliff_pri_multipledirections";

  level.scr_radio["cliff_pri_dontalertthem"] = "cliff_pri_dontalertthem";

  level.scr_radio["cliff_pri_sloppy"] = "cliff_pri_sloppy";

  level.scr_radio["cliff_pri_silencers"] = "cliff_pri_silencers";

  level.scr_radio["cliff_pri_attractattn"] = "cliff_pri_attractattn";

  level.stealth_broken_time = gettime();

  thread dialog_stealth_failure();
  thread dialog_stealth_spotted();
  array_thread(level.players, ::dialog_unsilenced_weapons);

  wait 4;

  radio_dialogue("cliff_pri_likeaghost");

  wait .35;

  radio_dialogue("cliff_pri_keepeyeonheart");
}
node = getstruct(self.target, "targetname");
node stealth_ai_idle_and_react(self, "lean_balcony", "lean_react");
}

twostory_sitter() {
  node = getstruct(self.target, "targetname");
  node stealth_ai_idle_and_react(self, "sit_idle", "sit_react");
}

right_side_start_patroller() {
  self endon("death");
  self SetGoalPos(self.origin);
  self.goalradius = 64;
  self ent_flag_wait("_stealth_normal");
  self maps\_patrol::patrol();
}

tent_1_patrollers() {
  self endon("death");
  self SetGoalPos(self.origin);
  self.goalradius = 64;
  flag_wait("near_camp_entrance");
  self ent_flag_wait("_stealth_normal");
  self maps\_patrol::patrol();
}

tent_1_crate_patroller() {
  self endon("death");
  nearDoorStruct = getstruct("struct_crate_patroller_enterhut2", "targetname");
  while(1) {
    nearDoorStruct waittill("trigger", other);

    if(other == self) {
      break;
    }
  }

  self.patrol_walk_anim = undefined;
  self.patrol_walk_twitch = undefined;
  self.patrol_scriptedanim = undefined;
  self.patrol_stop = undefined;
  self.patrol_start = undefined;
  self.patrol_stop = undefined;
  self.patrol_end_idle = undefined;
  self maps\_patrol::set_patrol_run_anim_array();
}

enemy_nerf() {
  self.baseaccuracy = level.new_enemy_accuracy;
  self.grenadeammo = 0;
}

increase_fov_when_player_is_near() {
  self endon("death");
  self endon("enemy");

  while(1) {
    if(player_is_near()) {
      self.fovcosine = 0.01;
      return;
    }
    wait 0.5;
  }
}

player_is_near() {
  foreach(player in level.players) {
    if(DistanceSquared(self.origin, player.origin) < squared(self.footstepDetectDistSprint))
      return true;
  }

  return false;
}

reduce_footstep_detect_dist() {
  self.footstepDetectDistWalk = 90;
  self.footstepDetectDist = 90;
  self.footstepDetectDistSprint = 90;
}
stealth_set_default_stealth_function("cliffhanger", ::stealth_cliffhanger_clifftop);

ai_event = [];
ai_event["ai_eventDistNewEnemy"] = [];
ai_event["ai_eventDistNewEnemy"]["spotted"] = 320;
ai_event["ai_eventDistNewEnemy"]["hidden"] = 192;

ai_event["ai_eventDistExplosion"] = [];
ai_event["ai_eventDistExplosion"]["spotted"] = level.explosion_dist_sense;
ai_event["ai_eventDistExplosion"]["hidden"] = level.explosion_dist_sense;

ai_event["ai_eventDistDeath"] = [];
ai_event["ai_eventDistDeath"]["spotted"] = 320;
ai_event["ai_eventDistDeath"]["hidden"] = 192;

ai_event["ai_eventDistPain"] = [];
ai_event["ai_eventDistPain"]["spotted"] = 192;
ai_event["ai_eventDistPain"]["hidden"] = 96;

ai_event["ai_eventDistBullet"] = [];
ai_event["ai_eventDistBullet"]["spotted"] = 96;
ai_event["ai_eventDistBullet"]["hidden"] = 96;

ai_event["ai_eventDistFootstep"] = [];
ai_event["ai_eventDistFootstep"]["spotted"] = 120;
ai_event["ai_eventDistFootstep"]["hidden"] = 120;

ai_event["ai_eventDistFootstepWalk"] = [];
ai_event["ai_eventDistFootstepWalk"]["spotted"] = 60;
ai_event["ai_eventDistFootstepWalk"]["hidden"] = 60;

ai_event["ai_eventDistFootstepSprint"] = [];
ai_event["ai_eventDistFootstepSprint"]["spotted"] = 700;
ai_event["ai_eventDistFootstepSprint"]["hidden"] = 500;

stealth_ai_event_dist_custom(ai_event);

rangesHidden = [];
rangesHidden["prone"] = 200;
rangesHidden["crouch"] = 350;
rangesHidden["stand"] = 600;

rangesSpotted = [];
rangesSpotted["prone"] = 600;
rangesSpotted["crouch"] = 800;
rangesSpotted["stand"] = 1000;

stealth_detect_ranges_set(rangesHidden, rangesSpotted);

alert_duration = [];
alert_duration[0] = 1;
alert_duration[1] = 1;
alert_duration[2] = 1;
alert_duration[3] = 0.75;
stealth_alert_level_duration(alert_duration[level.gameskill]);

stealth_ai_event_dist_custom(ai_event);

array = [];
array["sight_dist"] = 400;
array["detect_dist"] = 200;
stealth_corpse_ranges_custom(array);

thread so_stealth_music_control();

foreach(player in level.players) {
  player stealth_plugin_basic();
  player thread playerSnowFootsteps();
}
}

stealth_cliffhanger_clifftop() {
  self stealth_plugin_basic();

  if(isPlayer(self)) {
    return;
  }
  threat_array["warning1"] = maps\_stealth_threat_enemy::enemy_alert_level_warning2;
  switch (self.team) {
    case "axis":
      self ent_flag_init("player_found");
      self ent_flag_init("not_first_attack");

      self stealth_plugin_threat();
      self stealth_pre_spotted_function_custom(::clifftop_prespotted_func);
      self stealth_threat_behavior_custom(threat_array);
      self stealth_enable_seek_player_on_spotted();
      self stealth_plugin_corpse();
      self stealth_plugin_event_all();
      self.baseaccuracy = 1;
      self.fovcosine = .76;
      self.fovcosinebusy = .1;

      self maps\cliffhanger_stealth::init_cliffhanger_cold_patrol_anims();
      break;
    case "allies":
  }
}

clifftop_prespotted_func() {
  self.battlechatter = false;

  time_wait = undefined;
  switch (level.gameskill) {
    case 0:
    case 1:
      time_wait = 2.0;
      break;
    case 2:
      time_wait = 1.0;
      break;
    case 3:
      time_wait = 0.5;
      break;
  }

  wait time_wait;

  self.battlechatter = true;
}

dialog_stealth_spotted() {
  level endon("special_op_terminated");

  failure = [];
  failure[failure.size] = "cliff_pri_takecover";
  failure[failure.size] = "cliff_pri_beenspotted";
  failure[failure.size] = "cliff_pri_foundyou";
  failure = array_randomize(failure);
  line = 0;

  while(1) {
    flag_wait("_stealth_spotted");

    wait 1;
    if(flag("_stealth_spotted"))
      dialog_stealth_throttle(failure[line]);

    level.stealth_broken_time = gettime();

    line++;
    if(line >= failure.size)
      line = 0;

    flag_waitopen("_stealth_spotted");
  }
}

dialog_stealth_failure() {
  level endon("special_op_terminated");

  failure = [];
  failure[failure.size] = "cliff_pri_dontalertthem";
  failure[failure.size] = "cliff_pri_sloppy";
  failure[failure.size] = "cliff_pri_silencers";
  line = RandomInt(failure.size);

  while(1) {
    flag_wait("_stealth_spotted");
    wait 1;

    flag_waitopen("_stealth_spotted");
    wait 1;

    if(!flag("_stealth_spotted"))
      dialog_stealth_throttle(failure[line]);
    line++;
    if(line >= failure.size)
      line = 0;
  }
}

dialog_stealth_throttle(dialog_alias) {
  if(level.stealth_broken_time + 5000 < gettime())
    radio_dialogue(dialog_alias);
}

dialog_unsilenced_weapons() {
  self endon("death");
  level endon("nonsilenced_weapon_pickup");

  while(true) {
    self waittill("weapon_change");

    current_weapon = self getcurrentprimaryweapon();
    if(!isDefined(current_weapon)) {
      continue;
    }
    if(current_weapon == "none") {
      continue;
    }
    if(issubstr(current_weapon, "silence")) {
      continue;
    }

    thread radio_dialogue("cliff_pri_attractattn");
    break;
  }

  level notify("nonsilenced_weapon_pickup");
}
level endon("special_op_terminated");
level endon("stop_stealth_music");
while(1) {
  thread stealth_music_hidden_loop();
  flag_wait("_stealth_spotted");
  music_stop(.2);
  wait .5;
  thread stealth_music_busted_loop();
  flag_waitopen("_stealth_spotted");
  music_stop(3);
  wait 3.25;
}
}

stealth_music_hidden_loop() {
  music_loop("so_sabotage_cliffhanger_stealth_music", 2);
}
stealth_music_busted_loop() {
  music_loop("so_sabotage_cliffhanger_busted_music", 2);
}
array_thread(getEntArray("truck_guys", "script_noteworthy"), ::add_spawn_function, maps\cliffhanger_stealth::base_truck_guys_think);

flag_wait("start_truck_patrol");
level.truck_patrol = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("truck_patrol");
level.truck_patrol thread play_loop_sound_on_entity("cliffhanger_truck_music");
level.truck_patrol thread base_truck_think();
level.truck_patrol thread truck_headlights();
level.truck_patrol waittill("death");
flag_set("jeep_blown_up");
level.truck_patrol notify("stop sound" + "cliffhanger_truck_music");
}

base_truck_think() {
  self endon("death");

  self thread dialog_truck_coming();
  self thread dialog_jeep_stopped();

  self thread unload_and_attack_if_stealth_broken_and_close();

  flag_wait("truck_guys_alerted");
  guys = get_living_ai_array("truck_guys", "script_noteworthy");

  if(guys.size == 0) {
    self Vehicle_SetSpeed(0, 15);
    return;
  }

  screamer = random(guys);
  screamer maps\_stealth_shared_utilities::enemy_announce_wtf();

  self waittill("safe_to_unload");
  self Vehicle_SetSpeed(0, 15);
  wait 1;
  self maps\_vehicle::vehicle_unload();

  flag_set("jeep_stopped");
}

unload_and_attack_if_stealth_broken_and_close() {
  self endon("truck_guys_alerted");

  while(1) {
    flag_wait("_stealth_spotted");
    foreach(player in level.players)
    thread waittill_player_in_range(player);
    self waittill("player_in_range");
    if(!flag("_stealth_spotted"))
      continue;
    else
      break;
  }
  flag_set("truck_guys_alerted");
}

waittill_player_in_range(player) {
  self endon("player_in_range");

  player waittill_entity_in_range(self, 800);

  self notify("player_in_range");
}

truck_headlights() {
  playFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_RIGHT_FRONT");
  playFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_LEFT_FRONT");

  playFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_LEFT_TAIL");
  playFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_RIGHT_TAIL");

  self waittill("death");

  if(isDefined(self))
    delete_truck_headlights();
}

delete_truck_headlights() {
  stopFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_RIGHT_FRONT");
  stopFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_LEFT_FRONT");
  stopFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_LEFT_TAIL");
  stopFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_RIGHT_TAIL");
}

dialog_truck_coming() {
  level endon("special_op_terminated");
  level endon("jeep_stopped");
  level endon("jeep_blown_up");

  first_time = true;
  while(1) {
    self waittill_player_in_truck_range();
    truck_coming = within_fov(self.origin, self.angles, self.close_player.origin, Cos(45));
    if(truck_coming) {
      if(!first_time && cointoss()) {
        radio_dialogue("cliff_pri_truckcomingback");
      } else {
        radio_dialogue("cliff_pri_truckiscoming");
      }
      first_time = false;
      wait 10;
    }
    wait 1;
  }
}

waittill_player_in_truck_range() {
  self.close_player = undefined;
  foreach(player in level.players)
  player thread watch_for_truck(self);

  level waittill("player_in_truck_range");
}

watch_for_truck(truck) {
  level endon("player_in_truck_range");

  truck waittill_entity_in_range(self, 1200);
  truck.close_player = self;
  level notify("player_in_truck_range");
}

dialog_jeep_stopped() {
  level endon("special_op_terminated");
  self waittill("unloading");

  if(flag("_stealth_spotted")) {
    return;
  }

  radio_dialogue("cliff_pri_headsup");

  if(flag("_stealth_spotted")) {
    return;
  }

  radio_dialogue("cliff_pri_lookingaround");
}
level.plant_targets = [];

plant_targets = getEntArray("explosive_obj_model", "script_noteworthy");
foreach(obj_model in plant_targets) {
  obj_model hide();
  planted_model = getent(obj_model.target, "targetname");
  planted_model hide();
}

truncated_plant_targets = [];
for(i = 0; i < plant_targets.size; i++) {
  truncated_plant_targets[i] = plant_targets[i];
  truncated_plant_targets[i] show();
}

array_thread(truncated_plant_targets, ::setup_explosive);
waittillframeend;

flag_set("explosives_ready");
array_thread(level.plant_targets, ::explosive_think);
waittillframeend;

Objective_Add(1, "current", level.challenge_objective);
for(i = 0; i < level.plant_targets.size; i++)
  Objective_AdditionalPosition(1, level.plant_targets[i].id, level.plant_targets[i].origin);
}

setup_explosive() {
  ID = level.plant_targets.size;
  planted_model = getent(self.target, "targetname");
  planted_model hide();

  struct = spawnStruct();
  struct.obj_model = self;
  struct.objective_id = int(strTok(self.targetname, "_")[1]);
  struct.planted_model = planted_model;
  struct.origin = self.origin;
  struct.plant_flag = "explosive_" + ID;
  struct.id = ID;
  struct.planted = false;

  struct.planted_model.health = 100;

  struct.planted_model ent_flag_init(struct.plant_flag);
  level.plant_targets[level.plant_targets.size] = struct;
}

explosive_think(exp_struct) {
  self thread threeD_objective_hint();

  self.obj_model MakeUsable();
  self.obj_model SetCursorHint("HINT_ACTIVATE");
  self.obj_model SetHintString(level.strings["hint_c4_plant"]);

  self.obj_model waittill("trigger");

  self.obj_model MakeUnusable();
  self.obj_model hide();
  self.planted_model show();

  self.planted_model thread maps\_c4::playC4Effects();
  self.planted_model thread play_sound_on_entity("detpack_plant");

  self.planted = true;
  self.planted_model ent_flag_set(self.plant_flag);
  Objective_AdditionalPosition(1, self.id, (0, 0, 0));
  level notify("an_explosive_planted");
}

explosives_planted_monitor() {
  trigger_off("player_outside_compound", "script_noteworthy");

  flag_wait("explosives_ready");

  while(1) {
    all_planted = true;
    foreach(plant_target in level.plant_targets)
    if(plant_target.planted == false)
      all_planted = false;

    if(all_planted) {
      break;
    }

    level waittill("an_explosive_planted");
  }

  Objective_State(1, "done");

  outside_obj = getstruct("obj_outside_compound", "script_noteworthy");
  Objective_Add(2, "current", level.challenge_objective_escape, outside_obj.origin);
  playFX(getfx("extraction_smoke"), outside_obj.origin);

  trigger_on("player_outside_compound", "script_noteworthy");
}
animname = "flag_square";
if(isDefined(self.script_noteworthy))
  animname = self.script_noteworthy;
waving_flag = spawn_anim_model(animname);
waving_flag.origin = self.origin;
waving_flag.angles = self.angles;
self Delete();

angles = VectorToAngles(waving_flag.angles);
forward = anglesToForward(angles);
waving_flag thread flag_waves();
}

flag_waves() {
  animation = self getanim("flag_waves");
  self SetAnim(animation, 1, 0, 1);
  for(;;) {
    if(!isDefined(self))
      return;
    flap_rate = RandomFloatRange(0.8, 1.2);
    self SetAnim(animation, 1, 0, flap_rate);
    wait(RandomFloatRange(0.3, 0.7));
  }
}
if(!is_coop()) {
  return;
}
foreach(player in level.players) {}

wait 0.5;

foreach(player in level.players) {}
}

blizzard_control() {
  maps\_blizzard::blizzard_level_transition_hard(8);
  thread maps\_utility::set_ambient("snow_base");
}

threeD_objective_hint() {
  self.planted_model ent_flag_wait(self.plant_flag);
}
special_case = !(isDefined(self.script_noteworthy) && self.script_noteworthy == "high_threat_spawner");
test = 0;
if(!special_case)
  test = 0;

original_case = self type_spawners();
return special_case && original_case;
}

type_vehicle_special() {
  if(isDefined(self.code_classname) && self.code_classname == "script_vehicle_collmap")
    return false;

  special_case = !(isDefined(self.script_noteworthy) && self.script_noteworthy == "tarmac_snowmobile");
  special_case2 = !(isDefined(self.targetname) && self.targetname == "truck_patrol");

  original_case = self type_vehicle();

  test = 0;
  if(original_case)
    test = 0;

  return special_case && special_case2 && original_case;
}