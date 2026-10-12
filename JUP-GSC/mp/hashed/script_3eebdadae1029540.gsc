/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3eebdadae1029540.gsc
*************************************************/

#using script_100adcc1cc11d2fa;
#using script_2117aae6deaad1a6;
#using script_2cd303a32758e76c;
#using script_2d400da2610fe542;
#using script_39d11000e476a42a;
#using script_3b78d23dad7ec5be;
#using script_3f9c618c4c35ed2;
#using script_3fe26dc5c76ef6fd;
#using script_42fadda36015f142;
#using script_443d99fe707f1d9f;
#using scripts\cp_mp\zombie_challenges;
#using script_482376d10f69832c;
#using script_4c543f01345a2c04;
#using script_4e6e58ab5d96c2b0;
#using script_4fa7e9e11630166c;
#using script_5080d40cd904ba73;
#using script_65df7ec65510bf2;
#using script_6bffae1b97f70547;
#using script_6df6604a74a7a9c7;
#using script_7d3e27aa82b5d70b;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\asm\shared\mp\utility;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\laststand;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\pack_a_punch;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\ob;
#using scripts\mp\maps\mp_jup_tower\mp_jup_tower_ob;
#using scripts\mp\mp_agent;
#using scripts\mp\mp_dialogue;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\ob\points;
#namespace namespace_133f5bf9f2ee1760;

function function_3ff7ad80fdba8cc8() {
  setdevdvarifuninitialized(@ "hash_9485e6f24017d3da", -1);

  spawners = getStructArray("s5_player_spawns", "script_noteworthy");

  if(!isDefined(spawners) || !isarray(spawners)) {
    flag_set("flag_s5_story_custom_spawn_function_overriden");
    level.var_49839a7ef42e68d8 = getspawnarray("mp_ob_spawn_story_start");
    return;
  }

  if(!isDefined(level.var_49839a7ef42e68d8)) {
    level.var_49839a7ef42e68d8 = [];
  }

  foreach(spawner in spawners) {
    spawner.index = spawner.script_index;
    spawner.script_noteworthy = "0";
    level.var_49839a7ef42e68d8 = array_add(level.var_49839a7ef42e68d8, spawner);
  }

  flag_set("flag_s5_story_custom_spawns_setup");

  while(!istrue(level.assists_disabled)) {
    wait 0.2;
  }

  level.getspawnpoint = &function_62e505c355a9828f;
  flag_set("flag_s5_story_custom_spawn_function_overriden");
}

function function_b8f0069de10ceb99() {
  level thread function_3ff7ad80fdba8cc8();
  level thread function_4a07014c82ce2592();
  level thread namespace_bc50cc28d0217818::function_b21b3b439cfd8877();
  callback::add("ob_content_process_create_script", &function_50b1ee2f342b9b3c);
  level thread function_a89155c599d1f5da();
  level thread infil_music();
  level.var_2e2204c429664d9b = 1;
  flag_wait("ob_systems_init_complete");
  add_start("intro", &start_intro, &intro_flow);
  add_start("cleanse", &start_cleanse, &cleanse_flow);
  add_start("ascendtower", &function_b24aeb40c70859af, &function_3351f98f7b2faa5d);
  add_start("abovetower", &function_ad72ca80efa4dfea, &function_c9242c5d06946aec);
  add_start("boss", &start_boss, &boss_flow);
  add_start("bossarena", &start_boss, &boss_flow);

  function_d96f980db28d4994();
  thread function_ff761f5b1946a46a();

  thread handle_starts();
  setup_mission();
  flag_wait("ob_infil_completed");
  thread setup_objectives();
  setup_players();
  level.navbounds = getnavbounds();
}

function function_c12e755deec4e839(params) {
  if(isDefined(params.item) && is_equal(params.item.type, "brloot_offhand_thermalphone") && !isDefined(self.var_98121f76d794d8bb)) {
    self playlocalsound("evt_zm_ob_rr_s5_5_thermal_phone_pickup");
    self.var_98121f76d794d8bb = 1;
  }
}

function private function_62e505c355a9828f() {
  self endon("disconnect");
  flag_wait("flag_s5_story_custom_spawns_setup");
  spawnpoint = undefined;

  if(ob::function_a275bf1666c6a7eb() && getdvarint(@ "hash_ea2511831ad6764e", 1)) {
    spawnpoint = ob::function_6d3ebe9af4963f4b(self);

    if(!isDefined(spawnpoint)) {
      spawnpoint = function_87f120499e3097a2(self);
    }

    if(!isDefined(spawnpoint) && level.var_46901be2468e1d90) {
      spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = spawnlogic::getspawnpoint(self, "allies", undefined, "start_attackers");
    }
  } else if(spawnlogic::shoulduseteamstartspawn()) {
    spawnpoint = function_87f120499e3097a2(self);

    if(!isDefined(spawnpoint) && level.var_46901be2468e1d90) {
      spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = spawnlogic::getspawnpoint(self, "allies", undefined, "start_attackers");
    }
  } else {
    spawnpoint = ob::function_781ce82d9ee85375(self);

    if(!isDefined(spawnpoint) && level.var_46901be2468e1d90) {
      spawnlogic::activatespawnset("normal", 1);
      spawnpoint = spawnlogic::getspawnpoint(self, "allies", undefined, "normal");
    }
  }

  assertex(isDefined(spawnpoint), "<dev string:x1c>" + self.sessionsquadid + "<dev string:x43>" + self.sessionuimemberindex);
  return spawnpoint;
}

function private function_87f120499e3097a2(player) {
  if(isDefined(player.var_87a91b2a8231f4f8)) {
    return player.var_87a91b2a8231f4f8;
  }

  spawnpoint = undefined;

  if(player.sessionsquadid < level.var_7a8e039103b51e0f.size) {
    squadspawnpoints = level.var_7a8e039103b51e0f[player.sessionsquadid];
    index_to_use = player.sessionuimemberindex;

    if(getdvarint(@ "hash_9485e6f24017d3da", -1) > -1) {
      index_to_use = getdvarint(@ "hash_9485e6f24017d3da");
    }

    foreach(point in squadspawnpoints) {
      if(isDefined(point.script_index) && int(point.script_index) == index_to_use) {
        spawnpoint = point;
        break;
      }
    }

    if(!isDefined(spawnpoint)) {
      spawnpoint = squadspawnpoints[player.sessionuimemberindex];
    }
  }

  if(!isDefined(spawnpoint) && level.var_7a8e039103b51e0f.size) {
    squadspawnpoints = level.var_7a8e039103b51e0f[0];
    spawnpoint = squadspawnpoints[player.sessionuimemberindex];

    if(!isDefined(spawnpoint)) {
      spawnpoint = squadspawnpoints[0];
    }

    if(isDefined(spawnpoint)) {
      println("<dev string:x4f>" + player.sessionsquadid + "<dev string:x93>" + player.sessionuimemberindex + "<dev string:xa7>");
      logstring("==OB SPAWN Not enough spawn points in array found for Squad ID: " + player.sessionsquadid + ", Member Index: " + player.sessionuimemberindex + " so using index 0 in spawn array as a fallback");
    }
  }

  player.var_87a91b2a8231f4f8 = spawnpoint;
  return spawnpoint;
}

function function_8403e3846f61e864() {
  flag_wait("scriptables_ready");
  beams = getscriptablearray("contractbeam", "targetname");

  foreach(beam in beams) {
    beam delete();
  }
}

function function_2ca6cab07be039d0() {
  setdvarifuninitialized(@ "hash_3cd8f7500c4cffcb", 1);
  setdvarifuninitialized(@ "hash_67144a280e505eb0", 1);
  setdvarifuninitialized(@ "scr_redeploy_drone_count", 1);
  struct_loc = getStruct("redeploy_loc", "targetname");
  var_d9d4a6cb965a1c8e = getentitylessscriptablearray("scriptable_ob_redeploy_drone", "classname", struct_loc.origin, 500);

  if(isDefined(var_d9d4a6cb965a1c8e) && var_d9d4a6cb965a1c8e.size > 0) {
    level waittill("ob_drones_setup");
    level.var_fc4bb27a820f54dd.var_5715be6ca445d02e = array_remove(level.var_fc4bb27a820f54dd.var_5715be6ca445d02e, var_d9d4a6cb965a1c8e[0]);
    wait 5;
    level.var_fc4bb27a820f54dd.var_5715be6ca445d02e = array_add(level.var_fc4bb27a820f54dd.var_5715be6ca445d02e, var_d9d4a6cb965a1c8e[0]);
  }
}

function function_a89155c599d1f5da() {
  level._effect["oop_launch_glow"] = loadfx("vfx/s4/gamemode/vfx_alps_spotlight_glow_blue.vfx");
  level._effect["oop_destroyed"] = loadfx("vfx/jup/ob/gameplay/riftrun/s3_5/vfx_aether_crystal_impact.vfx");
  level._effect["oop_pedestal_ready"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_send.vfx");
  level._effect["zombie_eye_glow"] = loadfx("vfx/jup/ob/gameplay/zm_ai/vfx_zai_base_eye_rot.vfx");
  level._effect["pap_weapon_legend"] = loadfx("vfx/jup/modes/vfx_pap_pickup_orng.vfx");
  level._effect["item_glow_electric"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_elec_trail.vfx");
  level._effect["item_portal"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_geotrail_portal.vfx");
  level._effect["intro_gate_in"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_teleportation_spawn_in.vfx");
  level._effect["intro_gate_out"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_teleportation_out.vfx");
  level._effect["cleanse_site_lightning"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_ob_circle_aether_lightning_strike_impact_ch.vfx");
  level._effect["rift_teleport"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_send.vfx");
}

function set_completed_flags() {
  flag_wait("start_is_set");
  start = level.start_point;

  if(!isDefined(start) || start == "") {
    return;
  }

  flag_set("rift_run_infil_gate_collapse_triggered");
  flag_set("flag_lightning_fx_start_obj_oop_a");
  flag_set("flag_lightning_fx_start_obj_oop_c");

  if(start == "cleanse") {
    return;
  }

  flag_set("oops_destroyed_complete");
  flag_set("flag_scatter_oops_obj_oop_a");
  flag_set("flag_scatter_oops_obj_oop_c");
  flag_set("flag_batch_cleansed_obj_oop_a");
  level utility::delaythread(5, &utility::flag_set, "flag_batch_cleansed_5_obj_oop_a");
  level utility::delaythread(10, &utility::flag_set, "flag_batch_cleansed_10_obj_oop_a");
  flag_set("flag_batch_cleansed_obj_oop_c");
  level utility::delaythread(5, &utility::flag_set, "flag_batch_cleansed_5_obj_oop_c");
  level utility::delaythread(10, &utility::flag_set, "flag_batch_cleansed_10_obj_oop_c");
  flag_set("oop_scattered_or_skipped_obj_oop_a");
  flag_set("oop_scattered_or_skipped_obj_oop_c");
  flag_set("cleanse_beat_objectives_complete");

  if(start == "ascendtower") {
    return;
  }

  flag_set("flag_debug_speed_up_train_start");
  flag_set("reached_tower_bottom");
  flag_set("reached_tower_top");
  flag_set("flag_rooftop_encounter_complete");
  flag_set("flag_used_tear_leave_roof");

  if(start == "abovetower") {
    return;
  }

  flag_set("reached_boss_arena");

  if(start == "boss") {
    return;
  }
}

function start_intro() {
  flag_wait("buddy_ais_spawned");
  thread function_d74a3c4dc3bad944();
}

function start_cleanse() {
  thread setup_storm();
}

function function_b24aeb40c70859af() {
  function_2e656805e9a5c512();
  level.var_6c74c58b7bf75f9e["obj_oop_a"] = gettime();
  level.var_6c74c58b7bf75f9e["obj_oop_c"] = gettime();
  delaythread(10, &function_ce8df710ea488f1a, "oop_a");
  delaythread(10, &function_ce8df710ea488f1a, "oop_c");
}

function function_ad72ca80efa4dfea() {
  function_2e656805e9a5c512();
  level.var_6c74c58b7bf75f9e["obj_oop_a"] = gettime();
  level.var_6c74c58b7bf75f9e["obj_oop_c"] = gettime();
}

function function_faeeb3f32d444d8f(b_val) {
  if(self == level.var_2ada333c838a2316) {
    buddy = "ava_buddy";
  } else if(self == level.var_1da22412ed7ad03b) {
    buddy = "ravenov_buddy";
  }

  val::set(buddy, "ignoreall", b_val);

  if(buddy != "ava_buddy") {
    val::set(buddy, "ignoreme", b_val);
  }
}

function function_eeb84ad3f809b136(tele_dest, s_guard) {
  level.var_1da22412ed7ad03b namespace_60bff5112336ce6::function_d6e4c5c74c55fe0(tele_dest.origin - (0, 64, 0), tele_dest.angles);
  level.var_1da22412ed7ad03b thread namespace_60bff5112336ce6::function_a4f2de37b22bd9f9(s_guard.origin, 0, 128, 64);
}

function function_1829ed66414ea45f() {
  level flag_init("boss_intro_jansen_ready");
  tele_dest = getStruct("beat_04_jansen_cleanserelic_animnode", "targetname");
  s_guard = getStruct("beat_04_ravenov_guard_pos_01", "targetname");
  level.var_2ada333c838a2316 namespace_60bff5112336ce6::function_9f44d0edaa30d584();
  waitframe();
  namespace_60bff5112336ce6::ava_spawn(tele_dest);
  flag_wait("flag_ava_follower_spawned");
  thread function_eeb84ad3f809b136(tele_dest, s_guard);

  if(getDvar(@ "start") == "<dev string:xd9>" || getDvar(@ "start") == "<dev string:xe1>") {
    level.var_1da22412ed7ad03b function_faeeb3f32d444d8f(0);
    level.var_2ada333c838a2316 function_faeeb3f32d444d8f(1);
  }

  level flag_set("jansen_ready_boss");
}

function function_b9f2df0813f1123e(struct_spawnloc, var_9ec97bdad14a0a5b, pap_level, rarity_level) {
  dropstruct = function_59a2e61d79065dca(1);
  dropinfo = function_49b86047c8a8b228(dropstruct, struct_spawnloc.origin, struct_spawnloc.angles, undefined, 1, 1);
  itembundle = getscriptbundle("itemspawnentry:" + var_9ec97bdad14a0a5b);
  ammo_mod = random(["brainrot", "cryofreeze", "deadwire", "napalmburst", "shatterblast"]);
  item = namespace_b4f2af6fa775d9b::function_c069cffb4cbd1707(itembundle, struct_spawnloc.origin, struct_spawnloc.angles, ammo_mod, pap_level, 1, 1, dropinfo.payload);

  if(isDefined(item)) {
    level thread function_e6a66d208abfb4ff(item);
  }
}

function function_e6a66d208abfb4ff(item) {
  level endon("game_ended");
  item_mover = spawn("script_model", item.origin);
  item_mover setModel("tag_origin");
  item_mover.angles = item.angles;
  start_pos = item.origin;
  bounce_offset = (0, 0, 12);
  offset = item.origin + bounce_offset;
  item utility::scriptable_setparententity(item_mover);
  str_fx = getfx("pap_weapon_legend");
  playFXOnTag(str_fx, item_mover, "tag_origin");
  playsoundatpos(item.origin + (0, 0, 5), "jup_hordepoint_pap_weapon_appear");
  item_mover playLoopSound("jup_hordepoint_pap_weapon_lp");
  item.item_mover = item_mover;

  foreach(player in level.players) {
    if(!istrue(player.var_e9b9e87f68d9fad7)) {
      player callback::add("player_item_pickup", &function_7f69945073f11731);
      player.var_e9b9e87f68d9fad7 = 1;
    }
  }

  while(isDefined(item)) {
    while(!item_mover players_within_distance(1200)) {
      wait 2;
    }

    item_mover moveTo(offset, 1.5, 0.75, 0.75);
    item_mover waittill("movedone");
    wait 0.1;

    if(isDefined(item)) {
      item_mover moveTo(start_pos, 1.5, 0.75, 0.75);
      item_mover waittill("movedone");
      wait 0.1;
    }
  }

  waitframe();
  item_mover delete();
}

function function_7f69945073f11731(sparams) {
  if(isDefined(sparams.item) && isDefined(sparams.item.item_mover)) {
    self playlocalsound("jup_hordepoint_pap_weapon_pickup");
    sparams.item.item_mover stoploopsound();
  }
}

function function_f044f82fb0ca9f11() {
  level endon("game_ended");
  actors = level.var_2ada333c838a2316;
  animnode = getStruct("beat_04_jansen_cleanserelic_animnode", "targetname");
  level.var_9a64442c36e2ad19 = 0;
  level flag_wait("jansen_ready_boss");
  animnode thread scene::play(actors, "shot_010", "jup_ob_s5_story_cleanserelic_scenebundle");
  flag_wait("entity_island_reach");
  level thread scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Boss_Arena_Arrive_2", level.players);
  wait 2.75;
  animnode scene::play(actors, "shot_020", "jup_ob_s5_story_cleanserelic_scenebundle");
  animnode thread scene::play(actors, "shot_030", "jup_ob_s5_story_cleanserelic_scenebundle");
  wait 1;
  flag_set("jansen_interrupt_ready");
  flag_wait("entity_intro_vo");
  level thread scripts\cp_mp\overlord::playconversation("STY_S5_5_STM_Boss_Arena_Arrive_3", level.players, undefined, undefined, undefined, undefined, undefined, &function_45d4ac9031616d5a);
  flag_wait("entity_phase_01_complete");
  animnode scene::play(actors, "shot_040", "jup_ob_s5_story_cleanserelic_scenebundle");
  animnode thread scene::play(actors, "shot_050", "jup_ob_s5_story_cleanserelic_scenebundle");
  flag_wait("entity_spawned");
  wait 3;
  animnode scene::play(actors, "shot_060", "jup_ob_s5_story_cleanserelic_scenebundle");
  level.var_2ada333c838a2316 namespace_60bff5112336ce6::function_9f44d0edaa30d584();
  level.var_2ada333c838a2316 = undefined;
  wait 1;
  flag_set("entity_jansen_phase_01_despawned");
  waitframe();
}

function function_e34bfcaf76b74f02() {
  level endon("game_ended");
  level endon("entity_defeated");

  while(!flag("entity_defeated")) {
    if(isDefined(level.entity_boss) && isalive(level.entity_boss)) {
      level.entity_boss ent_flag_wait("entity_ready_for_lightbomb");
      function_498ab8a41e7ef67d();
    }

    wait 2;
  }
}

function function_498ab8a41e7ef67d() {
  level flag_init("boss_phase_02_jansen_ready");
  namespace_60bff5112336ce6::ava_spawn();
  thread function_51ebbd96b698f404();
  function_ba1032e495c9c1ca();
  waitframe();
  var_3eaa15f9a7737fc3 = level.var_ad5d9c2f5d7df9b9.origin;
  level flag_set("boss_phase_02_jansen_ready");
  function_9306d91e52ec93e1("QUEST_0_RIFT_S5_07_BOSS_LIGHTBOMB");
  objective_playermask_showtoall(level.objids[level.var_ad5d9c2f5d7df9b9.script_noteworthy]);
  update_objective_setzoffset(level.objids[level.var_ad5d9c2f5d7df9b9.script_noteworthy], 72);
  function_f044f52fb0ca9878(level.var_ad5d9c2f5d7df9b9, level.entitypos);
}

function function_f044f52fb0ca9878(animnode, entitypos) {
  level endon("game_ended");
  actors = level.var_2ada333c838a2316;

  if(level.var_31cfa03a7e864f49 == 0) {
    level thread function_ef89cf4181d076e7("STY_S5_5_STM_Ava_Lightwell_Protect", level.players);
  }

  animnode scene::play(actors, "shot_010", "jup_ob_s5_story_chargealtar_scenebundle");
  animnode thread scene::play(actors, "shot_020", "jup_ob_s5_story_chargealtar_scenebundle");
  level.var_ad5d9c2f5d7df9b9 function_4ce64c508cf1094b();
  flag_wait("entity_phase_02_lightbomb_charged");
  animnode scene::play(actors, "shot_030", "jup_ob_s5_story_chargealtar_scenebundle");
  flag_set("entity_phase_02_start_throw");
  animnode scene::play(actors, "shot_040", "jup_ob_s5_story_chargealtar_scenebundle");
  animnode thread scene::play(actors, "shot_050", "jup_ob_s5_story_chargealtar_scenebundle");
  level.entity_boss ent_flag_wait_either("death_begin_phase_02", "lightning_strike_ultimate_vo");

  if(!flag("entity_death_begin_phase_02")) {
    if(level.entity_boss ent_flag("lightning_strike_ultimate_vo")) {
      chargetime = level.entity_boss.var_730fcb57528054fb.phase[level.entity_boss.entitydata.phaseindex].chargetime * 0.001;
      var_4b53168cb7eefb6d = chargetime - 8;
      wait min(var_4b53168cb7eefb6d, chargetime);

      if(!flag("entity_death_begin_phase_02") && level.var_31cfa03a7e864f49 == 1) {
        level thread function_ef89cf4181d076e7("STY_S5_5_STM_Entity_Invulnerable_Again", level.players);
      }
    }
  }

  animnode scene::play(actors, "shot_060", "jup_ob_s5_story_chargealtar_scenebundle");
  level.var_2ada333c838a2316 namespace_60bff5112336ce6::function_9f44d0edaa30d584();

  if(!flag("entity_death_begin_phase_02")) {
    level.var_ad5d9c2f5d7df9b9 = spawnStruct();
    function_9306d91e52ec93e1("QUEST_0_RIFT_S5_07_BOSS");
    return;
  }

  if(flag("entity_death_begin_phase_02")) {
    flag_set("lightbomb_final_teleport");
  }
}

function function_4e4ce2ea52fb06e7() {
  level endon("game_ended");
  var_7fd8278ccb5636ae = getStructArray("beat_04_boss_relic", "script_noteworthy");

  foreach(relic in var_7fd8278ccb5636ae) {
    var_a533e3f43ad64d78 = relic.targetname;
    var_8ccef068343ca006 = relic.origin;
    var_31be707903a6d09d = utility::spawn_model(relic.script_parameters, var_8ccef068343ca006);
    var_31be707903a6d09d forcenetfieldhighlod(1);
    level.var_f6532644781c4da0[var_a533e3f43ad64d78] = var_31be707903a6d09d;
    thread function_a138e57020c7bcc5(var_31be707903a6d09d, var_8ccef068343ca006);
  }
}

function function_a138e57020c7bcc5(var_31be707903a6d09d, var_8ccef068343ca006) {
  level endon("game_ended");
  var_31be707903a6d09d playLoopSound("evt_ob_story_relic_lp");
  var_8ecb5bcd6e64e487 = 0;
  var_19ca4fdc928e98a7 = 1;
  wait randomfloatrange(0.5, 1);

  while(!flag("entity_phase_01_complete")) {
    var_31be707903a6d09d.origin = var_8ccef068343ca006 + (0, 0, 10 + 1.5 * cos(var_8ecb5bcd6e64e487 * 10));
    var_31be707903a6d09d.angles += (0, 2, 0);
    var_8ecb5bcd6e64e487 += 1;
    waitframe();
  }

  var_2d074b637695f588 = randomfloatrange(0.5, 1);
  wait var_2d074b637695f588;
  var_31be707903a6d09d playSound("evt_ob_rr_obelisk_item_takeoff");
  var_31be707903a6d09d moveTo(var_8ccef068343ca006 + (0, 0, 1600), 4, 2);
  wait 4;
  playsoundatpos(var_31be707903a6d09d.origin, "evt_ob_rr_obelisk_item_end");
  playFX(getfx("item_portal"), var_31be707903a6d09d.origin);
  var_31be707903a6d09d delete();
}

function beam_attack_vo() {
  level endon("game_ended");
  level endon("entity_death_begin_phase_01");

  while(level.var_a9b75f5aecce409c < 2 && isalive(level.entity_boss)) {
    if(flag("entity_phase_01_vo_ready")) {
      level.entity_boss ent_flag_wait("beam_attack_vo");
      level thread function_ef89cf4181d076e7("STY_S5_5_STM_Beam_Attack_Warn", level.players);
      level.var_a9b75f5aecce409c++;
      level.entity_boss ent_flag_clear("beam_attack_vo");
      wait 45;
      continue;
    }

    wait 1;
  }
}

function function_2d8f210cbd59d6db() {
  level endon("game_ended");
  level endon("entity_defeated");

  while(level.boss_phase == 1 && isalive(level.entity_boss)) {
    level.entity_boss ent_flag_wait("lightning_strike_ultimate_vo");
    level function_ef89cf4181d076e7("STY_S5_5_STM_Lightning_Telegraph", level.players);
    level.entity_boss ent_flag_clear("lightning_strike_ultimate_vo");
  }
}

function function_eb35451f3ea8833(phase) {
  level endon("game_ended");
  level endon("entity_defeated");

  while(level.boss_phase == phase && isalive(level.entity_boss)) {
    if(flag("entity_phase_01_vo_ready")) {
      level.entity_boss waittill("spawn_orbs");
      level function_ef89cf4181d076e7("STY_S5_5_STM_Orb_Warn", level.players);
      wait 60;
      continue;
    }

    wait 1;
  }
}

function spawn_boss(phase) {
  if(phase == 0) {
    spawnloc = level.var_e859e3e2283ccd72["obj_destroy_entity"];
    level thread function_5ce151ffc970bfa9();
  } else if(phase == 1) {
    spawnloc = getStruct("beat_04_entityloc_phase_02_04", "targetname");

    if(!isDefined(spawnloc)) {
      spawnloc = level.var_e859e3e2283ccd72["obj_destroy_entity"];
    }

    level thread function_5ce14effc970b910();
    function_9306d91e52ec93e1("QUEST_0_RIFT_S5_07_BOSS");
  }

  agent = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_entity", spawnloc.origin, spawnloc.angles, "team_two_hundred");

  if(isDefined(agent)) {
    level.entity_boss = agent;
    agent.entitydata.spawnlocation = 3;
    agent.var_2c94b75746ceabe2 = 1;
    function_e40f7d0537ba1619(agent);

    if(phase == 0) {
      flag_wait("entity_phase_01_spawned");
    }

    agent ent_flag_set("entity_activate");

    if(phase == 0) {
      agent scripts\common\callbacks::add("on_zombie_ai_damaged", &function_791fb49e203dbca2);
      return;
    }

    if(phase == 1) {
      agent function_e1c9888a10e1798f(1);
    }
  }
}

function function_45d4ac9031616d5a(alias, speaker) {
  if(!flag("entity_phase_01_spawned")) {
    flag_set("entity_phase_01_spawned");
    return;
  }

  wait 10;
  flag_set("entity_phase_01_vo_ready");
}

function function_791fb49e203dbca2(sparams) {
  var_a693085376ce3d1d = istrue(self.var_4919d15787f01154) && isDefined(sparams.var_b5c36875d3a4559c) && sparams.var_b5c36875d3a4559c > 0 || !istrue(self.var_4919d15787f01154) && sparams.idamage > 0;

  if(isDefined(sparams.eattacker)) {
    if(istrue(isPlayer(sparams.eattacker)) && flag("entity_phase_01_vo_ready") && var_a693085376ce3d1d) {
      wait 0.75;
      level thread function_ef89cf4181d076e7("STY_S5_5_STM_Entity_Weak_Point_Hit", level.players);
      scripts\common\callbacks::remove("on_zombie_ai_damaged", &function_791fb49e203dbca2);
    }
  }
}

function start_boss() {
  function_2e656805e9a5c512();
}

function function_820ae10ff17d59f0() {
  reward_struct = getStruct("obj_fake_rift_reward", "script_noteworthy");
  level.fake_reward_rift = spawnscriptable("jup_zm_rift_fake_reward_rift", reward_struct.origin, reward_struct.angles);
  level.fake_reward_rift setscriptablepartstate("body", "rewardcache_active");
  level.fake_reward_rift setscriptablepartstate("interact", "on");
  playrumbleonposition("artillery_rumble", level.fake_reward_rift.origin);
  objective_playermask_showtoall(level.objids["obj_fake_rift_reward"]);
  update_objective_setzoffset(level.objids["obj_fake_rift_reward"], 72);
  function_9306d91e52ec93e1("QUEST_0_RIFT_S5_08_LOOT_RIFT");
  level thread function_ee2a20015e37d3ec("STY_S5_5_STM_Entity_Death_Fakeout", level.players);
  scripts\cp_mp\interaction::function_32645103f7520635(level.fake_reward_rift, &function_e354f5ef1f82840, undefined);
  level.fake_reward_rift scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_75d4c0944710e819);
}

function function_e354f5ef1f82840(player) {
  flag_set("entity_fakeout_complete");
  objective_playermask_hidefromall(level.objids["obj_fake_rift_reward"]);
  level.fake_reward_rift setscriptablepartstate("body", "rewardcache_despawn");
  level.fake_reward_rift setscriptablepartstate("interact", "off");
}

function function_75d4c0944710e819(interact, player) {
  return {
    #string: &"JUP_OB_OBJECTIVES/OBJECTIVE_REWARD_CACHE_TITLE", #type: "HINT_BUTTON"};
}

function intro_flow() {
  function_f18f39783c8cedc4(0, 0, 0);
  function_9b8829ab4092a7d7("ob_zombie_ambient_s5_rooftop_story", 0);
  thread setup_storm();
  thread function_e74a6f43e6d48596();
  thread function_959d91cabe1365f8();
  thread vo_intro();
  thread function_ca3de3ca95fac1ba();
  thread function_7c66c58b1aef4adc();
  thread function_6c4555d557613730();
  thread function_9f7b5e3179589a90();
  flag_wait("flag_intro_complete");
}

function cleanse_flow() {
  function_f18f39783c8cedc4(1, 0, 0);
  function_9b8829ab4092a7d7("ob_zombie_ambient_s5_rooftop_story", 1);

  if(isDefined(level.var_2ada333c838a2316)) {
    level.var_2ada333c838a2316.grenadeammo = 0;
  }

  if(isDefined(level.var_1da22412ed7ad03b)) {
    level.var_1da22412ed7ad03b.grenadeammo = 0;
  }

  thread function_6bdec09ad114d92a();
  thread function_e109cb0f8f51949a();
  thread function_a99e3c7a93bd576c();
  thread function_b524c5f462a0b862();
  thread function_63ce936da75542c3();
  level.cratedropdata.heliheight = 4000;

  if(isDefined(level.var_ba4f4b9b7988606f)) {
    level.var_ba4f4b9b7988606f.origin = (0, 0, 4000);
  }

  flag_wait("oops_destroyed_complete");
}

function function_3351f98f7b2faa5d() {
  function_f18f39783c8cedc4(0, 0, 0);
  thread function_7980db680510d81d();
  thread function_707ec5fb66349d20();
  thread function_7a059c64e4b08632();
  thread function_e86cf97594766ef8();
  thread function_f0db8f2b4f6d94e0();
  thread function_832d6ea58ccc05df();
  level.cratedropdata.heliheight = 8000;

  if(isDefined(level.var_ba4f4b9b7988606f)) {
    level.var_ba4f4b9b7988606f.origin = (0, 0, 8000);
  }

  flag_wait("flag_used_tear_leave_roof");
}

function function_c9242c5d06946aec() {
  function_f18f39783c8cedc4(1, 0, 0);
  thread function_bb07764679e15739();
  thread function_45d64dc00d240bc7();
  thread function_bd16e498b5cf2201();
  thread function_f4e60acce5eadb1();
  thread function_e827910e4184af29();
  thread function_f4e5dacce5ea718();
  thread function_e829bc74f676e38f();
  thread function_3dc0d275245edd26();
  thread function_f4e5eacce5ea94b();
  thread function_f4e63acce5eb44a();
  thread function_c77d44a1143ba279();
  level.cratedropdata.heliheight = 11000;

  if(isDefined(level.var_ba4f4b9b7988606f)) {
    level.var_ba4f4b9b7988606f.origin = (0, 0, 11000);
  }

  flag_wait("reached_boss_arena");
}

function boss_flow() {
  if(isDefined(level.var_2ada333c838a2316)) {
    level.var_2ada333c838a2316.grenadeammo = 0;
  }

  if(isDefined(level.var_1da22412ed7ad03b)) {
    level.var_1da22412ed7ad03b.grenadeammo = 0;
  }

  level.cratedropdata.heliheight = 16000;

  if(isDefined(level.var_ba4f4b9b7988606f)) {
    level.var_ba4f4b9b7988606f.origin = (0, 0, 16000);
  }

  thread function_2b882a36b2d42660();
  flag_wait("entity_fakeout_complete");
  thread function_e48d7cf3781178a4();
  function_a30893b2683cb868();
  flag_wait("entity_jansen_phase_01_despawned");
  thread function_e34bfcaf76b74f02();
  flag_wait("entity_defeated_add_time");
  function_106ef81c3ecbf2fb();
  flag_wait("entity_defeated");
  thread function_6097089379e7d090();
  level waittill("exfil_complete");
}

function function_38456cb15e4ba032() {
  level.boss_phase = 0;
  spawn_boss(0);
  flag_wait("entity_spawned");
  thread function_eb35451f3ea8833(0);
  thread beam_attack_vo();
}

function function_a30893b2683cb868() {
  wait 1.25;
  level scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Entity_Returns_Line_1", level.players);
  wait 3;
  level.boss_phase = 1;
  spawn_boss(1);
  flag_wait("flag_entity_phase_02_spawn_vo");
  level thread scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Entity_Returns_Line_2", level.players);
  flag_clear("entity_death_begin_phase_01");
  level.entity_boss ent_flag_wait("entity_spawnanim_finished");
  thread function_f81d9514815ccfcc();
  thread function_2d8f210cbd59d6db();
  wait 2;
  level function_ee2a20015e37d3ec("STY_S5_5_STM_Entity_Invulnerable", level.players);
}

function function_457bba9ab5773cbc() {
  var_7617b20c5192e34 = getnoentvolumearray("bad_teleport_volume", "targetname");
  function_e85bdef1c036b3a2(var_7617b20c5192e34);
}

function function_50b1ee2f342b9b3c(params) {
  ava = namespace_bc50cc28d0217818::ava_spawn();
  level thread function_4e062b2610bf4f37();
  thread function_457bba9ab5773cbc();

  if(isDefined(ava)) {
    if(!getdvarint(@ "hash_619206e8128d046e", 0)) {
      ava val::set("ava_buddy", "ignoreall", 1);
      ava setgoalpos(ava.origin, 4);
      ava val::set("ava_buddy", "ignoreall", 0);
      ava thread namespace_bc50cc28d0217818::function_101b97bce06bef4();
    }

    return;
  }

  assertmsg("<dev string:xee>");
}

function function_95a1beed8771a7a3(var_e98a2e24f991b6f6) {
  if(!isDefined(var_e98a2e24f991b6f6)) {
    var_e98a2e24f991b6f6 = 0;
  }

  level endon("game_ended");
  var_1d6aa90a9f946bbe = istrue(var_e98a2e24f991b6f6) ? "ob_infil_rift_gate_alternate" : "ob_infil_rift_gate";
  s_gate = utility::getStruct(var_1d6aa90a9f946bbe, "targetname");

  if(!isDefined(s_gate)) {
    return;
  }

  scriptable = spawnscriptable("ob_jup_scriptable_rift_gate_collapse", s_gate.origin, s_gate.angles);
  level flag_wait("rift_run_infil_gate_collapse_triggered");
  size = (250, 50, 250);
  v_look = s_gate.origin + (0, 0, 64);

  while(isDefined(scriptable)) {
    if(level.players.size == 0) {
      b_collapse = 1;
    }

    if(istrue(b_collapse) || flag("rift_run_infil_gate_collapse_triggered")) {
      scriptable setscriptablepartstate("body", "collapse_nb");
      wait 10;

      if(isDefined(scriptable)) {
        scriptable freescriptable();
      }

      break;
    }
  }
}

function function_959d91cabe1365f8() {
  level endon("game_ended");
  scripts\mp\flags::function_1240434f4201ac9d("infil_started");
  thread flag_set_delayed("flag_lightning_fx_start_obj_oop_a", 12);
  thread flag_set_delayed("flag_lightning_fx_start_obj_oop_c", 20);
  wait 1.9;

  foreach(player in level.players) {
    thread function_291e115e54510420(player);
  }
}

function function_291e115e54510420(player) {
  camera_angles = anglesToForward(player getplayerangles());
  camera_position = player.origin + (0, 0, player getplayerviewheight());
  fx_position = camera_position + camera_angles * 34;
  fx_location = spawn("script_model", fx_position);
  fx_location setModel("tag_origin");
  playfxontagforclients(getfx("intro_gate_in"), fx_location, "tag_origin", player);
  wait 0.5;
  playfxontagforclients(getfx("intro_gate_out"), fx_location, "tag_origin", player);
  wait 2;
  stopfxontagforclients(getfx("intro_gate_in"), fx_location, "tag_origin", player);
  stopfxontagforclients(getfx("intro_gate_out"), fx_location, "tag_origin", player);
  fx_location delete();
}

function function_d74a3c4dc3bad944() {
  self endon("game_ended");
  flag_set("vo_intro_anim_started");
  var_7708d7c71f2b87ca = getStruct("intro_rav_anim_struct", "targetname");
  var_4920afa797ef0a65 = getStruct("intro_ava_anim_struct", "targetname");
  flag_wait("ai_buddys_init");
  level.var_2ada333c838a2316 lookatentity(level.player);
  level.var_1da22412ed7ad03b lookatentity(level.player);
  level.var_2ada333c838a2316 thread scripts\asm\shared\mp\utility::animscripted_single_relative("jup_ob_s5_story_jansen_intro_loop", var_4920afa797ef0a65);
  level.var_1da22412ed7ad03b thread scripts\asm\shared\mp\utility::animscripted_single_relative("jup_ob_s5_story_ravenov_intro_loop", var_7708d7c71f2b87ca);
  function_512528d80d6c1009();
  level utility::delaythread(1.5, &utility::flag_set, "rift_run_infil_gate_collapse_triggered");
  flag_set("vo_intro_vo_begin");
  thread function_cacd8b74338a04ad();

  foreach(player in level.players) {
    level thread function_c267673b90073e6e(player);
  }

  thread function_b0292733bc54c039(var_7708d7c71f2b87ca);
  level.var_2ada333c838a2316 lookatentity(level.player);
  level.var_2ada333c838a2316 scripts\asm\shared\mp\utility::animscripted_single_relative("jup_ob_s5_story_jansen_intro", var_4920afa797ef0a65);
  level.var_2ada333c838a2316 scripts\asm\shared\mp\utility::animscripted_clear();
  level.var_2ada333c838a2316 scripts\asm\shared\mp\utility::animscripted_single("jup_ob_s5_story_jansen_intro_idle");
  level.var_2ada333c838a2316 scripts\asm\shared\mp\utility::animscripted_clear();
  var_68f32b620d3c3a58 = spawnStruct();
  var_68f32b620d3c3a58.origin = level.var_2ada333c838a2316.origin;
  level.var_2ada333c838a2316 setgoalpos(var_68f32b620d3c3a58.origin);
  flag_set("flag_intro_complete");
  flag_set("ava_intro_complete");
}

function function_c267673b90073e6e(player) {
  player endon("disconnect");
  level endon("game_ended");
  wait 4;
  player notify("ws_raise");
}

function function_b0292733bc54c039(animstruct) {
  level.var_1da22412ed7ad03b lookatentity(level.player);
  level.var_1da22412ed7ad03b scripts\asm\shared\mp\utility::animscripted_single_relative("jup_ob_s5_story_ravenov_intro", animstruct);
  level.var_1da22412ed7ad03b scripts\asm\shared\mp\utility::animscripted_clear();
  level.var_1da22412ed7ad03b animscripted_single("jup_ob_s5_story_ravenov_intro_idle");
  level.var_1da22412ed7ad03b scripts\asm\shared\mp\utility::animscripted_clear();
  var_209efe1fe68280d9 = spawnStruct();
  var_209efe1fe68280d9.origin = level.var_1da22412ed7ad03b.origin;
  level.var_1da22412ed7ad03b setgoalpos(var_209efe1fe68280d9.origin);
  flag_set("rav_intro_complete");
}

function function_d2fe4756004d62ca() {
  wait 1;
  flag_set("rift_run_infil_gate_collapse_triggered");
}

function function_4e062b2610bf4f37() {
  spawnloc = getStruct("ally_spawn_ravenov", "targetname");
  ravenov = ravenov_spawn(spawnloc);
  flag_set("buddy_ais_spawned");

  if(isDefined(ravenov)) {
    if(!getdvarint(@ "hash_619206e8128d046e", 0)) {
      ravenov setgoalpos(ravenov.origin, 4);
      ravenov val::set("ravenov_buddy", "ignoreall", 1);
      ravenov val::set("ravenov_buddy", "ignoreall", 0);
      ravenov thread namespace_bc50cc28d0217818::function_101b97bce06bef4();
      flag_set("ai_buddys_init");
    }

    return;
  }

  assertmsg("<dev string:x10a>");
}

function private function_512528d80d6c1009() {
  scripts\mp\flags::function_1240434f4201ac9d("infil_started");
  wait 2;
}

function vo_intro() {
  level endon("game_ended");
  flag_wait("vo_intro_anim_started");
  flag_wait("vo_intro_vo_begin");
  level function_ef89cf4181d076e7("STY_S5_5_STM_Players_Enter_Rift_line_1", level.players, 2.3);
  level function_ef89cf4181d076e7("STY_S5_5_STM_Players_Enter_Rift_line_2", level.players, 0.5, undefined, 0);
  level function_ef89cf4181d076e7("STY_S5_5_STM_Players_Enter_Rift_line_3", level.players, 6.2);
  level function_ef89cf4181d076e7("STY_S5_5_STM_Players_Enter_Rift_line_4", level.players, 1.5);
}

function function_ca3de3ca95fac1ba() {
  level endon("game_ended");
  level endon("reached_tower_top");
  level endon("flag_used_tear_leave_roof");
  function_d1fdfd8f4cf74e50("flag_intro_near_edge_vo", getEnt("intro_near_edge_trigger", "targetname"));
  level thread function_ef89cf4181d076e7("STY_S5_5_STM_Approach_Island_Edge", level.players, 1);
}

function function_7c66c58b1aef4adc() {
  level endon("game_ended");
  level endon("reached_tower_top");
  level endon("flag_used_tear_leave_roof");
  fog_trigger = getEnt("fog_trigger", "targetname");

  foreach(player in level.players) {
    thread fog_watcher(player, fog_trigger);
  }

  flag_wait("vo_play_fog_nag");

  if(!flag("fog_nag_given")) {
    level thread function_ef89cf4181d076e7("STY_S5_5_STM_Fog_Nag", level.players);
    level flag_set("fog_nag_given");
    level.var_83f2f830e127f562 = gettime();
  }
}

function fog_watcher(player, fog_trigger) {
  level endon("game_ended");
  level endon("reached_tower_top");
  level endon("flag_used_tear_leave_roof");
  level endon("fog_nag_given");
  player endon("death_or_disconnect");

  while(true) {
    if(!player istouching(fog_trigger)) {
      wait 0.5;
      time = gettime();
    }

    while(player istouching(fog_trigger)) {
      if(time_has_passed(time, 15)) {
        flag_set("vo_play_fog_nag");
      }

      wait 1;
    }
  }
}

function function_6c4555d557613730() {
  level endon("game_ended");
  level endon("reached_tower_top");
  level endon("flag_used_tear_leave_roof");
  level endon("vo_first_jump_used");
  flag_wait("ava_intro_complete");
  level.var_eacd935256b82182 = gettime();

  foreach(player in level.players) {
    thread function_813f0d6fd12b3a4f(player);
  }
}

function function_813f0d6fd12b3a4f(player) {
  level endon("vo_first_jump_used");
  player waittill("fling_end");

  if(!isDefined(level.var_83f2f830e127f562) || time_has_passed(level.var_83f2f830e127f562, 5)) {
    level thread function_ef89cf4181d076e7("STY_S5_5_STM_Jump_Pad_First_Use_Reaction", level.players);
    level flag_set("vo_first_jump_used");
    level.var_eacd935256b82182 = gettime();
  }
}

function function_9f7b5e3179589a90() {
  level endon("game_ended");
  level endon("reached_tower_top");
  level endon("flag_used_tear_leave_roof");
  level endon("crystal_shattered");
  flag_wait("ava_intro_complete");

  while(!flag("locked_vo_given")) {
    if(!isDefined(level.players) || level.players.size == 0) {
      waitframe();
      continue;
    }

    foreach(player in level.players) {
      wait 1;

      if(function_2ceb15ae798065e5(player) && !flag("locked_vo_given") && time_has_passed(level.var_eacd935256b82182, 6)) {
        level thread function_ef89cf4181d076e7("STY_S5_5_STM_Approach_Inactive_Jump_Pad", level.players);
        level flag_set("locked_vo_given");
        return;
      }
    }
  }
}

function function_2ceb15ae798065e5(player) {
  pads = getentitylessscriptablearray(undefined, undefined, player.origin, 256);

  if(!isDefined(pads)) {
    return false;
  }

  if(pads.size == 0) {
    return false;
  }

  foreach(pad in pads) {
    if(!isDefined(pad.model)) {
      continue;
    }

    if(pad.model == "red::jup_gate_crystal_jump_pad_crystal_01_gameplay") {
      return true;
    }
  }

  return false;
}

function infil_music() {
  level waittill_any_2("match_start_real_countdown", "match_start_timer_skip");

  foreach(player in level.players) {
    player clearsoundsubmix("jup_ob_prematch", 2);
    player setsoundsubmix("jup_ob_global_s5_5_story");
  }
}

function function_73416667122e2bda() {
  flag_wait("vo_intro_vo_begin");
  function_c7311cb3f768f21e("allies_Infil");
  infil_loc = getStruct("infil_start_objective_loc", "script_noteworthy");
  function_606642b946a01237("allies_Infil_Tower", infil_loc.origin, 1000, 1);
  wait 120;
  function_c7311cb3f768f21e("allies_Infil_Tower");
}

function function_48d1a64fa08725b4() {
  level endon("game_ended");

  while(true) {
    foreach(player in level.players) {
      if(isDefined(player.origin) && player.origin[2] <= 400) {
        if(!isDefined(player.obscured) || !player.obscured) {
          player.obscured = 1;
          function_3b992a66c2e901bb(player, 1);
        }

        continue;
      }

      if(!isDefined(player.obscured) || player.obscured) {
        player.obscured = 0;
        function_3b992a66c2e901bb(player, 0);
      }
    }

    wait 0.5;
  }
}

function function_a3a8b481a6ec1565(sparams) {
  self.obscured = 0;

  if(!isDefined(level.var_48d1a64fa08725b4)) {
    level.var_48d1a64fa08725b4 = 1;
    level thread function_48d1a64fa08725b4();
  }

  switch (getdvarint(@ "hash_33d88f137491488", 0)) {
    case 1:
      self.origin = getStruct("<dev string:x12a>", "<dev string:x136>").origin;
      break;
    case 2:
      self.origin = getStruct("<dev string:x144>", "<dev string:x136>").origin;
      break;
    case 3:
      self.origin = getStruct("<dev string:x150>", "<dev string:x136>").origin;
      break;
    case 4:
      self.origin = getStruct("<dev string:x15c>", "<dev string:x136>").origin;
      break;
    case 5:
      self.origin = getStruct("<dev string:x168>", "<dev string:x136>").origin;
      break;
    default:
      break;
  }
}

function setup_mission() {
  level.var_e859e3e2283ccd72 = [];
  level.objids = [];
  level.oops = [];
  level.var_9f6a3aeb68ae417e = 0;
  level.var_68c30a93b827e48c = 0;
  level.scattered_oops = 0;
  level.var_cb5f8f4fc42b719d = "";
  level.var_fe48d87019665c36 = 0;
  level.var_6d298bb3b2c8bf0 = 0;
  level.oop_floaters = [];
  level.var_74cb06793a691f19 = [35, 70];
  level.var_b51ec0a3bc26a040 = [0, 0.4, 0.7];
  level.var_b446741821221b5d = 0;
  level.var_8690751fda8758ed = 0;
  level.var_bf1779f835f11a69 = [8, 6, 4];
  level.var_9bbb03c4c61a5cf0 = 0;
  level.var_417eea901ee32c59 = [];
  level.var_6c74c58b7bf75f9e = [];
  level.var_2aa32d5544c97c39 = [];
  level.var_f6532644781c4da0 = [];
  level.var_a4cba23c9788f32b = [];
  level.var_ad5d9c2f5d7df9b9 = spawnStruct();
  level.var_ad5d9c2f5d7df9b9.var_9bbca044327b6388 = 0;
  level.var_644d2d519cd520be = "";
  level.var_f2d34ed1ef9932b2 = 0;
  level.var_62e6cd77567f71b9 = 0;
  level.var_7fa7689c48de2dd5 = [8, 6, 4];
  level.var_31cfa03a7e864f49 = 0;
  level.var_98c031b802e80cdd = [20, 25, 30, 45];
  level.var_b028bd46a017b632 = [];
  level.var_b028bc46a017b3ff = [];
  level.var_b028bb46a017b1cc = [];
  level.var_b028ba46a017af99 = [];
  level.var_5c38487e2a325442 = [];
  level.var_a9b75f5aecce409c = 0;
  level.var_43e739e43e7c3815 = 0;
  level.var_59828bdd2434d254 = 0;
  level.var_32b95ae5e4ffca96 = [];
  level.var_4ecd3f4c7036dc6d = 0;
  level.var_722d041c7ef50faf = [(-20, -20, 0), (20, 20, 0), (-20, 20, 0), (20, -20, 0)];
  level.boss_phase = 0;

  if(!getdvarint(@ "hash_1c2c174b18e6d9b8", 0)) {
    thread namespace_7380e30e250d5b2f::function_4dd5d69d550c0999();
  }

  namespace_22b8ba12655bf3f2::function_d589c49c4b9b50a0(&scripts\mp\gametypes\ob::function_91d032246bb24684);
  callback::add("ob_dark_aether_exit_used", &function_9272bde289071a5e);
  callback::add("teleport_movie_complete", &play_outro_movie);
  thread init_beams();
  thread function_8c01b83c3500a2ea();
  thread function_2ca6cab07be039d0();
  thread function_37a680e171e980b();
  thread function_51faf1846c3be2c7();
  thread function_c19eaf71246ab93();
  thread function_38f2265a5a421aca();
  thread function_14a4228b442db1ba();
  thread function_a13f7cecf0912d15();
  thread function_38b1cb666f0178c4();
  thread function_1efaeeb81ad43025();
  thread function_73416667122e2bda();
  thread function_72459059f7f64d6d();
  level.var_668566d171e33358 = &function_21617328314fe31b;
  level.var_5a712c9d76830012 = &function_d49faba6568aa84c;
  thread namespace_f6368c72597c6d90::function_2a56c656879dbf63();
  thread function_9f909024d825be2c();
  thread function_550e38b033de778e();
  thread function_7f47a9126611e1cf();
}

function function_72459059f7f64d6d() {
  scripts\mp\flags::function_1240434f4201ac9d("infil_started");
  loot_structs = getStructArray("tower_loot_cache", "targetname");

  foreach(struct in loot_structs) {
    cache = common_cache::cache_spawncache(#"hash_d8e996c37357f449", struct.origin, struct.angles);
  }

  var_4a97a8f9aedaebce = getStructArray("tower_loot_cache_large", "targetname");

  foreach(struct in var_4a97a8f9aedaebce) {
    cache = common_cache::cache_spawncache(#"hash_9f528a48605451", struct.origin, struct.angles);
  }
}

function function_273ac67c0333119(objname) {
  if(issubstr(objname, "obj_find_remaining_")) {
    return (0, 0, 70);
  } else if(issubstr(objname, "oop")) {
    return (0, 0, 40);
  }

  switch (objname) {
    case #"hash_428bf0c5f45233e6":
      return (0, 0, 70);
    case #"hash_5cc7030e209ac40a":
      return (0, 0, 70);
    default:
      return (0, 0, 0);
  }
}

function function_e29ff3b3ca6efaef(objname) {
  if(issubstr(objname, "obj_find_remaining_")) {
    return "jup_ui_map_icon_obj_scavenger";
  } else if(issubstr(objname, "oop")) {
    return "jup_ui_map_icon_generic_marker";
  }

  switch (objname) {
    case #"hash_428bf0c5f45233e6":
    case #"hash_5cc7030e209ac40a":
    case #"hash_83bf4a32e133f368":
    case #"hash_94ef03638e6e5f98":
    case #"hash_e58b0d87af99a102":
      return "jup_ui_map_icon_generic_marker";
    case #"hash_e1d95d29ae6a02be":
      return "jup_ui_icon_rift_reward";
    default:
      return undefined;
  }
}

function setup_objectives() {
  structs = getStructArray("objectiveloc", "targetname");
  level.var_b0c7a2042f2d7b4e = 0;

  foreach(objective in structs) {
    objname = objective.script_noteworthy;
    level.objids[objname] = requestobjectiveid();
    level.var_e859e3e2283ccd72[objname] = objective;
    objective_add_objective(level.objids[objname], "current", objective.origin + function_273ac67c0333119(objname), function_e29ff3b3ca6efaef(objname));
    update_objective_setbackground(level.objids[objname], 1);
    objective_playermask_hidefromall(level.objids[objname]);

    if(string_starts_with(objname, "obj_oop")) {
      level thread setup_oop(objective);
      level.objids["obj_cleanse_" + objname] = requestobjectiveid();
      level.var_e859e3e2283ccd72["obj_cleanse_" + objname] = objective;
      objective_add_objective(level.objids["obj_cleanse_" + objname], "current", objective.origin + function_273ac67c0333119(objname), function_e29ff3b3ca6efaef(objname));
      update_objective_setbackground(level.objids["obj_cleanse_" + objname], 1);
      objective_playermask_hidefromall(level.objids["obj_cleanse_" + objname]);
      level.objids["obj_relocate_" + objname] = requestobjectiveid();
      level.var_e859e3e2283ccd72["obj_relocate_" + objname] = objective;
      objective_add_objective(level.objids["obj_relocate_" + objname], "current", objective.origin + function_273ac67c0333119(objname), function_e29ff3b3ca6efaef(objname));
      update_objective_setbackground(level.objids["obj_relocate_" + objname], 1);
      objective_playermask_hidefromall(level.objids["obj_relocate_" + objname]);
      level.objids["obj_find_remaining_" + objname] = requestobjectiveid();
      level.var_e859e3e2283ccd72["obj_find_remaining_" + objname] = objective;
      objective_add_objective(level.objids["obj_find_remaining_" + objname], "current", objective.origin + function_273ac67c0333119("obj_find_remaining_" + objname), function_e29ff3b3ca6efaef("obj_find_remaining_" + objname), "icon_small");
      update_objective_setbackground(level.objids["obj_find_remaining_" + objname], 6);
      objective_playermask_hidefromall(level.objids["obj_find_remaining_" + objname]);
    }

    if(string_starts_with(objname, "obj_lightbomb")) {
      var_11d1110a1c76035a = objective.script_noteworthy;
      level.objids[var_11d1110a1c76035a] = requestobjectiveid();
      level.var_a4cba23c9788f32b[var_11d1110a1c76035a] = objective;
      objective_add_objective(level.objids[var_11d1110a1c76035a], "current", objective.origin + (0, 0, 128), "jup_ui_map_icon_generic_marker");
      update_objective_setbackground(level.objids[var_11d1110a1c76035a], 1);
      objective_playermask_hidefromall(level.objids[var_11d1110a1c76035a]);
    }
  }

  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("quest_s5_start", level.players);
  wait 3;
  flag_set("flag_objectives_init");
}

function function_f3ef44fe7848cf3() {
  flag_wait("flag_scatter_oop_animation_ended");

  if(flag("flag_objectives_hidden")) {
    flag_waitopen("flag_objectives_hidden");
  }

  iter = 1;

  foreach(relic in level.var_417eea901ee32c59) {
    objname = "scattered_relic_" + iter;
    relic.obj_name = objname;
    level.objids[objname] = requestobjectiveid();
    objective_add_objective(level.objids[objname], "invisible", relic.origin, "jup_ui_map_icon_generic_marker");
    update_objective_setbackground(level.objids[objname], 1);
    objective_playermask_hidefromall(level.objids[objname]);
    update_objective_onentity(level.objids[objname], relic);
    update_objective_setzoffset(level.objids[objname], 25);
    iter++;
  }

  flag_set("flag_scatter_obj_initialized");
}

function setup_players() {
  if(level.players.size == 1) {
    level.players[0] scripts\cp_mp\laststand::function_188085b8b8d431f2(1);
  }

  foreach(player in level.players) {
    player namespace_838b439602b3acc7::function_f10f600ac4ee4c09("s5_mi_invest_rift", 3);
    player callback::add("player_item_pickup", &function_c12e755deec4e839);
  }
}

function function_63ce936da75542c3() {
  flag_wait("flag_objectives_init");
  level endon("game_ended");
  assertex(isDefined(level.var_e859e3e2283ccd72["<dev string:x174>"]) && isDefined(level.var_e859e3e2283ccd72["<dev string:x181>"]), "<dev string:x18e>");
  oop_a = level.var_e859e3e2283ccd72["obj_oop_a"];
  oop_c = level.var_e859e3e2283ccd72["obj_oop_c"];
  oop_a function_6b6b6273f8180522("Quest_Ob", oop_a.origin, 1500);
  oop_c function_6b6b6273f8180522("Quest_Ob", oop_c.origin, 1500);
  oop_c_vo_trigger = getStruct("oop_c_vo_trigger", "targetname");
  function_9306d91e52ec93e1("QUEST_0_RIFT_S5_01_SEARCH");
  thread function_a5b76e0f5024cc9a(oop_a, "near_relic_a", 2000, undefined, undefined, undefined, 0);
  thread function_a5b76e0f5024cc9a(oop_c_vo_trigger, "near_relic_c", 2000, undefined, undefined, undefined, 0);
  thread function_fc3a4f6c8474f3ac("obj_oop_a", "near_relic_a");
  thread function_fc3a4f6c8474f3ac("obj_oop_c", "near_relic_c");
  flag_wait_any_timeout(180, "near_relic_a", "near_relic_c", "flag_players_passed_objectives");
  level thread function_ee2a20015e37d3ec("STY_S5_5_STM_Approach_First_ObjectivE", level.players);
  wait 16;
  function_b8b15f7f0820954e(level.players);
  wait 1;

  foreach(player in level.players) {
    player thread function_aa8e03381a47905d();
  }

  if(!function_2a8ab2ce4768f4f3("obj_oop_a") || !function_2a8ab2ce4768f4f3("obj_oop_c")) {
    function_8f1daf09cb8c2419();
    level thread function_6bccae74f2546031();
  }

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      var_c689d39a3e7177c2 = distance2dsquared(player.origin, oop_a.origin);
      var_e0536ff4d9587c20 = distance2dsquared(player.origin, oop_c.origin);
      close_oop = var_c689d39a3e7177c2 == min(var_c689d39a3e7177c2, var_e0536ff4d9587c20) ? oop_a : oop_c;

      if(!is_equal(level.var_cb5f8f4fc42b719d, "")) {
        close_oop = level.var_e859e3e2283ccd72[level.var_cb5f8f4fc42b719d];
      }

      far_oop = close_oop == oop_a ? oop_c : oop_a;
      dist = min(var_c689d39a3e7177c2, var_e0536ff4d9587c20);

      if(function_56f3613bed398552()) {
        player function_10cdae62c9c62881();
        continue;
      }

      if(flag("flag_post_cleanse_vo_running")) {
        function_64d50ad671315921(player, "QUEST_0_RIFT_S5_05_OOP_CLEANSE_COMPLETE");
        player function_10cdae62c9c62881();
        close_oop function_d7d113d56ef0ef5b(player);
        player setclientomnvar("ui_br_objective_param", 0);
        continue;
      }

      if(dist <= squared(1500) && !close_oop.completed || !is_equal(level.var_cb5f8f4fc42b719d, "")) {
        switch (close_oop.var_deff4278a4e37a2.currstate) {
          case #"hash_140cc056ec40cc03":
            function_64d50ad671315921(player, "QUEST_0_RIFT_S5_02_FIND_RELICS");

            if(!flag("flag_approaching_second_oop") && flag("flag_first_oop_completed") && flag("near_relic_a") && flag("near_relic_c")) {
              level thread function_ef89cf4181d076e7("STY_S5_5_STM_Approach_Second_Objective", level.players);
              flag_set("flag_approaching_second_oop");
            }
          case #"hash_537e98569f3f5e7a":
            function_64d50ad671315921(player, "QUEST_0_RIFT_S5_05_FIND_REMAINING");
            close_oop function_cfd53c8f6878014f(player);
            player function_6e1514647836e112(close_oop.script_noteworthy);
            break;
          case #"hash_b1eabc8c58833530":
            function_64d50ad671315921(player, close_oop.var_deff4278a4e37a2.currstate);
            close_oop function_cfd53c8f6878014f(player);
            player function_10cdae62c9c62881();
            player thread function_32c7e0f3d1954f81();
            player setclientomnvar("ui_br_objective_progress_bar", -1);
            break;
          case #"hash_59e12004cff92b29":
            function_64d50ad671315921(player, close_oop.var_deff4278a4e37a2.currstate);
            player function_6e1514647836e112(close_oop.script_noteworthy);
            close_oop function_d7d113d56ef0ef5b(player);
            player setclientomnvar("ui_br_objective_progress_bar", -1);
            break;
          case #"hash_f5c8923720721285":
            function_64d50ad671315921(player, close_oop.var_deff4278a4e37a2.currstate);
            objective_position(level.objids[close_oop.script_noteworthy], level.var_2ada333c838a2316.origin);
            player function_6e1514647836e112(close_oop.script_noteworthy);
            close_oop function_d7d113d56ef0ef5b(player);
            var_9d53008256884bd2 = player getclientomnvar("ui_br_objective_progress_bar");

            if(is_equal(var_9d53008256884bd2, -1)) {
              if(level.var_fe48d87019665c36 == 0) {
                var_b4c7ef79e1e2b487 = 0;
              } else {
                var_b4c7ef79e1e2b487 = min(level.var_fe48d87019665c36 / level.var_d96080b08bb3766a, 1);
              }

              player setclientomnvar("ui_br_objective_progress_bar", int(var_b4c7ef79e1e2b487 * 100));
            }

            if(!flag("flag_relics_cleanse_start_second_oop") && (flag("flag_batch_cleansed_obj_oop_a") || flag("flag_batch_cleansed_obj_oop_c"))) {
              flag_clear("flag_relics_cleanse_start_first_oop");
              flag_set("flag_relics_cleanse_start_second_oop");
            }

            if(!flag("flag_relics_cleanse_start_first_oop")) {
              if(!flag("flag_relics_cleanse_start_second_oop")) {
                level thread function_c407f7030f3cc526();
              } else {
                level thread function_ef89cf4181d076e7("STY_S5_5_STM_Relic_Cleanse_Start", level.players);
              }

              flag_set("flag_relics_cleanse_start_first_oop");
            }

            if(flag("flag_oop_descattered") && !flag("flag_relics_regathered")) {
              level thread function_f35000473187ae3f();
              flag_set("flag_relics_regathered");
            }

            break;
          case #"hash_7038dec66d8275be":
          case #"hash_86e66d14ef11e0ac":
            function_64d50ad671315921(player, close_oop.var_deff4278a4e37a2.currstate);
            player function_10cdae62c9c62881();
            close_oop function_d7d113d56ef0ef5b(player);
            player setclientomnvar("ui_br_objective_param", 0);
            break;
        }

        player ent_flag_clear("flag_oop_out_of_range");

        if(level.scattered_oops > 0) {
          if(close_oop.var_3f8b356cc80da45b < level.scattered_oops) {
            player setclientomnvar("ui_br_objective_param", close_oop.var_3f8b356cc80da45b);
          }
        } else {
          player setclientomnvar("ui_br_objective_param", close_oop.var_a1dca8fa3b66d7aa);
        }

        continue;
      }

      if(level.oops[close_oop.script_noteworthy].completed || level.oops[far_oop.script_noteworthy].completed) {
        if(level.var_b0c7a2042f2d7b4e == level.oops.size) {
          player function_10cdae62c9c62881();
          flag_set("oops_destroyed_complete");
          player ent_flag_clear("flag_oop_out_of_range");

          if(!flag("flag_all_oop_completed_vo_played")) {
            level utility::delaythread(2, &function_ee2a20015e37d3ec, "STY_S5_5_STM_Second_Cleanse_Done", level.players);
            flag_set("flag_all_oop_completed_vo_played");
          }
        } else {
          function_64d50ad671315921(player, "QUEST_0_RIFT_S5_05_A_FIND_REMAINING");

          if(!close_oop.completed) {
            player function_6e1514647836e112(close_oop.script_noteworthy);
          } else {
            player function_6e1514647836e112(far_oop.script_noteworthy);
          }

          if(!flag("flag_first_oop_completed")) {
            player ent_flag_clear("flag_oop_out_of_range");
            level thread function_d383bfed46444d1a();
            close_oop.var_deff4278a4e37a2.currstate = "QUEST_0_RIFT_S5_05_OOP_CLEANSE_COMPLETE";
            flag_set("flag_first_oop_completed");
          }
        }
      } else {
        function_64d50ad671315921(player, "QUEST_0_RIFT_S5_02_A_FIND_RELICS");
        player function_6e1514647836e112([close_oop.script_noteworthy, far_oop.script_noteworthy]);
        player ent_flag_clear("flag_oop_out_of_range");
      }

      var_bb0f3f26695bd6be = 1;

      if(flag("flag_first_oop_completed")) {
        var_bb0f3f26695bd6be = flag("flag_approaching_second_oop");
      }

      if(!flag("oops_destroyed_complete") && close_oop.var_deff4278a4e37a2.currstate != "QUEST_0_RIFT_S5_05_OOP_CLEANSE_COMPLETE" && var_bb0f3f26695bd6be) {
        player ent_flag_set("flag_oop_out_of_range");
      }

      close_oop function_d7d113d56ef0ef5b(player);
      far_oop function_d7d113d56ef0ef5b(player);
      player setclientomnvar("ui_br_objective_param", 0);
      player setclientomnvar("ui_br_objective_progress_bar", -1);
    }

    wait 0.1;

    if(flag("oops_destroyed_complete") && !flag("flag_post_cleanse_vo_running")) {
      flag_set("cleanse_beat_objectives_complete");
      return;
    }
  }
}

function function_6bccae74f2546031() {
  level endon("near_relic_a");
  level endon("near_relic_c");

  while(true) {
    wait 60;

    foreach(player in level.players) {
      player function_10cdae62c9c62881();
    }

    wait 0.5;

    foreach(player in level.players) {
      player function_6e1514647836e112(["obj_oop_a", "obj_oop_c"]);
    }
  }
}

function function_d6b4c32a9428ab8a(obj_name) {
  pedestal_base = level.var_e859e3e2283ccd72[obj_name].var_deff4278a4e37a2;
  results = 0;

  if(pedestal_base.currstate == "QUEST_0_RIFT_S5_02_FIND_RELICS") {
    results = 1;
  }

  return results;
}

function function_6e1514647836e112(site_names) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isarray(site_names)) {
    site_names = [site_names];
  }

  show_a = array_contains(site_names, "obj_oop_a") && function_2a8ab2ce4768f4f3("obj_oop_a");
  show_c = array_contains(site_names, "obj_oop_c") && function_2a8ab2ce4768f4f3("obj_oop_c");

  if(istrue(show_a) && function_d6b4c32a9428ab8a("obj_oop_a")) {
    objective_playermask_addshowplayer(level.objids["obj_find_remaining_" + "obj_oop_a"], self);
    objective_playermask_hidefrom(level.objids["obj_oop_a"], self);
  } else if(istrue(show_a)) {
    objective_playermask_hidefrom(level.objids["obj_find_remaining_" + "obj_oop_a"], self);
    objective_playermask_addshowplayer(level.objids["obj_oop_a"], self);
  } else {
    objective_playermask_hidefrom(level.objids["obj_find_remaining_" + "obj_oop_a"], self);
    objective_playermask_hidefrom(level.objids["obj_oop_a"], self);
  }

  if(istrue(show_c) && function_d6b4c32a9428ab8a("obj_oop_c")) {
    objective_playermask_addshowplayer(level.objids["obj_find_remaining_" + "obj_oop_c"], self);
    objective_playermask_hidefrom(level.objids["obj_oop_c"], self);
    return;
  }

  if(istrue(show_c)) {
    objective_playermask_hidefrom(level.objids["obj_find_remaining_" + "obj_oop_c"], self);
    objective_playermask_addshowplayer(level.objids["obj_oop_c"], self);
    return;
  }

  objective_playermask_hidefrom(level.objids["obj_find_remaining_" + "obj_oop_c"], self);
  objective_playermask_hidefrom(level.objids["obj_oop_c"], self);
}

function function_10cdae62c9c62881() {
  level endon("game_ended");
  self endon("disconnect");
  objective_playermask_hidefrom(level.objids["obj_find_remaining_" + "obj_oop_a"], self);
  objective_playermask_hidefrom(level.objids["obj_oop_a"], self);
  objective_playermask_hidefrom(level.objids["obj_find_remaining_" + "obj_oop_c"], self);
  objective_playermask_hidefrom(level.objids["obj_oop_c"], self);
}

function function_32c7e0f3d1954f81() {
  level endon("game_ended");
  self endon("disconnect");

  if(!flag("flag_scatter_obj_initialized")) {
    return;
  }

  if(!flag("flag_scatter_obj_lull_over")) {
    return;
  }

  if(ent_flag("showing_scattered_oops")) {
    return;
  }

  ent_flag_set("showing_scattered_oops");

  foreach(relic in level.var_417eea901ee32c59) {
    if(!relic ent_flag("oop_descattered_begin")) {
      objective_playermask_addshowplayer(level.objids[relic.obj_name], self);
    }
  }

  while(true) {
    foreach(relic in level.var_417eea901ee32c59) {
      if(relic ent_flag("oop_descattered_begin")) {
        objective_playermask_hidefrom(level.objids[relic.obj_name], self);
      }
    }

    wait 0.1;

    if(!is_equal(self.shown_obj, "QUEST_0_RIFT_S5_04_RELOCATE")) {
      break;
    }
  }

  foreach(relic in level.var_417eea901ee32c59) {
    objective_playermask_hidefrom(level.objids[relic.obj_name], self);
  }
}

function function_56f3613bed398552() {
  return flag("flag_objectives_hidden");
}

function function_14d6cbc28972404c() {
  function_b8b15f7f0820954e(level.players);
  flag_set("flag_objectives_hidden");
}

function function_8c2bc6fb9a4afe0f() {
  flag_clear("flag_objectives_hidden");
}

function private function_64d50ad671315921(player, obj) {
  var_5ce85f49892885d8 = tablelookuprownum("ob/ob_missions.csv", 1, obj);
  var_f1a21b880815d306 = var_5ce85f49892885d8 != -1;

  if(var_f1a21b880815d306) {
    contractindexstring = tablelookupbyrow("ob/ob_missions.csv", var_5ce85f49892885d8, 0);
    contractindex = int(contractindexstring);

    if(player getclientomnvar("ui_br_objective_index") != contractindex) {
      player setclientomnvar("ui_br_objective_index", contractindex);
    }

    player setclientomnvar("ui_ob_active_contract_region_difficulty", 0);
    player.shown_obj = obj;
  }
}

function function_aa8e03381a47905d() {
  level endon("game_ended");
  self endon("disconnect");
  flag_wait_any("near_relic_a", "near_relic_c");

  while(true) {
    if(ent_flag("flag_oop_out_of_range") && isalive(self)) {
      wait 30;

      if(ent_flag("flag_oop_out_of_range") && isalive(self)) {
        players = [];
        players[0] = self;
        level thread function_ef89cf4181d076e7("STY_S5_5_STM_Cleanse_Range_Nag", players);
        ent_flag_clear("flag_oop_out_of_range");
        wait 600;
      }
    }

    wait 0.1;
  }
}

function function_fc3a4f6c8474f3ac(obj_name, found_flag) {
  level.var_e859e3e2283ccd72[obj_name] endon("site_marked_found");
  flag_wait(found_flag);
  function_c81dd1f4978cba01(obj_name);
}

function function_2a8ab2ce4768f4f3(obj_name) {
  return istrue(level.var_e859e3e2283ccd72[obj_name].found);
}

function function_c81dd1f4978cba01(obj_name) {
  level.var_e859e3e2283ccd72[obj_name].found = 1;
  level.var_e859e3e2283ccd72[obj_name] notify("site_marked_found");
}

function function_8f1daf09cb8c2419() {
  oop_a = level.var_e859e3e2283ccd72["obj_oop_a"];
  oop_c = level.var_e859e3e2283ccd72["obj_oop_c"];
  var_7ed37644a461efaf = sortbydistance(level.players, oop_a.origin)[0];
  var_6a2f1cc0f90dc6ba = distance(oop_a.origin, var_7ed37644a461efaf.origin);
  var_8b39463d87100769 = sortbydistance(level.players, oop_c.origin)[0];
  var_91ae5a18f6982e24 = distance(oop_c.origin, var_8b39463d87100769.origin);

  if(var_6a2f1cc0f90dc6ba < var_91ae5a18f6982e24) {
    function_c81dd1f4978cba01("obj_oop_a");
    return;
  }

  function_c81dd1f4978cba01("obj_oop_c");
}

function function_7980db680510d81d() {
  level endon("game_ended");
  flag_wait("flag_objectives_init");
  function_b8b15f7f0820954e(level.players);
  wait 25;
  thread storm_remove();
  flag_wait("cleanse_beat_objectives_complete");
  function_9306d91e52ec93e1("QUEST_0_RIFT_S5_06_FIND_ENTITY");
  objective_playermask_showtoall(level.objids["obj_find_entity"]);
  thread function_22b8a9f1c62cffc7();
  level.var_e859e3e2283ccd72["obj_find_entity"] function_6b6b6273f8180522("Quest_Ob", level.var_e859e3e2283ccd72["obj_find_entity"].origin, 600);
  level.var_e859e3e2283ccd72["obj_find_entity"] function_4eaf685bc40a3b9();

  foreach(player in level.players) {
    player thread function_ee088efc255f09c3();
  }

  thread function_a5b76e0f5024cc9a(level.var_e859e3e2283ccd72["obj_find_entity"], "reached_tower_bottom", level.var_e859e3e2283ccd72["obj_find_entity"].radius, undefined, undefined, undefined, 0);
  thread function_a5b76e0f5024cc9a(level.var_e859e3e2283ccd72["obj_tower_top"], "reached_tower_top", level.var_e859e3e2283ccd72["obj_tower_top"].radius, undefined, undefined, undefined, 0);
  level flag_wait_any("reached_tower_bottom", "reached_tower_top");
  waitframe();
  level flag_wait("flag_used_tear_leave_roof");
}

function function_ee088efc255f09c3() {
  self endon("disconnect");
  level endon("game_ended");
  a_loc = level.var_e859e3e2283ccd72["obj_find_entity"].origin + (0, 0, 70);
  a_obj = level.objids["obj_find_entity"];
  a_widget = "QUEST_0_RIFT_S5_06_FIND_ENTITY";
  b_loc = level.var_e859e3e2283ccd72["obj_tower_top"].origin;
  b_obj = level.objids["obj_tower_top"];
  c_loc = level.var_e859e3e2283ccd72["obj_boss_arena"].origin;
  c_obj = level.objids["obj_boss_arena"];
  c_widget = "QUEST_0_RIFT_S5_06_FIND_CONTINUE";
  function_64d50ad671315921(self, a_widget);

  while(true) {
    if(utility::flag("reached_boss_arena")) {
      break;
    }

    player_z = self.origin[2];

    if(player_z > b_loc[2] + 50) {
      objective_playermask_hidefrom(a_obj, self);
      objective_playermask_hidefrom(b_obj, self);
      objective_playermask_addshowplayer(c_obj, self);
      function_64d50ad671315921(self, c_widget);
      level flag_set("flag_used_tear_leave_roof");
    } else if(player_z < b_loc[2] + 50 && player_z > a_loc[2] - 50 || function_613880b4c7c574bd()) {
      objective_playermask_hidefrom(a_obj, self);
      objective_playermask_addshowplayer(b_obj, self);
      objective_playermask_hidefrom(c_obj, self);
      function_64d50ad671315921(self, a_widget);
    } else if(function_ab3737db48896914()) {
      level.var_e859e3e2283ccd72["obj_find_entity"] function_cfd53c8f6878014f(self);
      objective_playermask_hidefrom(a_obj, self);
      objective_playermask_hidefrom(b_obj, self);
      objective_playermask_hidefrom(c_obj, self);
      function_5de3526e58f4d79e();
      level.var_e859e3e2283ccd72["obj_find_entity"] function_d7d113d56ef0ef5b(self);
    } else {
      objective_playermask_addshowplayer(a_obj, self);
      objective_playermask_hidefrom(b_obj, self);
      objective_playermask_hidefrom(c_obj, self);
      function_64d50ad671315921(self, a_widget);
    }

    wait 0.1;
  }
}

function function_613880b4c7c574bd() {
  groundent = self getgroundentity();

  if(isDefined(groundent) && isDefined(groundent.script_noteworthy) && issubstr(groundent.script_noteworthy, "train_car_")) {
    self.var_4a60e6d2d8725ae8 = gettime();
    return true;
  } else if(isDefined(self.var_4a60e6d2d8725ae8) && !time_has_passed(self.var_4a60e6d2d8725ae8, 5)) {
    return true;
  }

  return false;
}

function function_5de3526e58f4d79e() {
  level endon("game_ended");
  self endon("disconnect");

  if(flag("reached_boss_arena")) {
    return;
  }

  level endon("reached_boss_arena");

  while(function_ab3737db48896914() && !function_613880b4c7c574bd()) {
    wait 0.1;
  }
}

function function_ab3737db48896914() {
  level endon("game_ended");
  self endon("disconnect");
  var_a9317014c4b07b94 = getStruct("obj_find_entity", "script_noteworthy");
  var_8adc1b5f7d55dca9 = distance(var_a9317014c4b07b94.origin, self.origin) < 300;
  return var_8adc1b5f7d55dca9;
}

function function_bb07764679e15739() {
  level endon("game_ended");
  flag_wait("flag_objectives_init");
  thread function_cd512110645424da();
  level flag_wait("reached_boss_arena");
}

function function_8c01b83c3500a2ea() {
  flag_wait("scriptables_ready");
  level.fog = getentitylessscriptablearray("scriptable_fog", "targetname")[0];

  if(isDefined(level.fog)) {
    level.fog setscriptablepartstate("part_raise_height", "state_scripted_default");
  }
}

function function_6e2c1e252f16c83() {
  if(isDefined(level.fog)) {
    level.fog setscriptablepartstate("part_raise_height", "state_scripted_raise");
  }
}

function function_9e2928ce280af4ea() {
  level.var_76514dbab939b739 = getEnt("boss_arena_clip", "targetname");

  if(isDefined(level.var_76514dbab939b739)) {
    level.var_76514dbab939b739 delete();
  }
}

function function_b61453c189eca793() {
  for(pingindex = 0; pingindex < 10; pingindex++) {
    foreach(player in level.players) {
      if(player calloutmarkerping_getactive(pingindex)) {
        player calloutmarkerping_hide(pingindex);
      }
    }
  }
}

function function_2b882a36b2d42660() {
  function_fe9f67aed00a33a();
  flag_wait("flag_objectives_init");
  thread function_6e2c1e252f16c83();
  thread function_9e2928ce280af4ea();
  thread function_b61453c189eca793();
  flag_set("lgt_boss_arena_arrive");
  function_ee2610f7b788365();
  objective_playermask_hidefromall(level.objids["obj_find_entity"]);
  objective_playermask_hidefromall(level.objids["obj_tower_top"]);
  objective_playermask_hidefromall(level.objids["obj_boss_arena"]);

  iprintlnbold("<dev string:x1c9>");

  function_b8b15f7f0820954e(level.players);
  level utility::delaythread(4, &function_9306d91e52ec93e1, "QUEST_0_RIFT_S5_07_BOSS");
  level utility::delaythread(4, &objective_playermask_showtoall, level.objids["obj_entity_reach"]);
  function_f18f39783c8cedc4(0, 0, 0);
  function_b78d24ef50998b70(0);
  function_1ed5091b83546ef1();
  thread function_e48d7ff378117f3d();
  thread function_4e4ce2ea52fb06e7();
  thread function_818349e75a7a365c();
  level thread scripts\cp_mp\overlord::playconversation("STY_S5_5_STM_Boss_Arena_Arrive_1", level.players);
  function_47c10ac7b6912dde();
  function_1829ed66414ea45f();

  if(getdvarint(@ "hash_2b40f1de479f089b", 0) == 1) {
    thread function_6097089379e7d090();
    level waittill("<dev string:x1d7>");
    return;
  }

  thread function_f044f82fb0ca9f11();
  thread function_a5b76e0f5024cc9a(level.var_e859e3e2283ccd72["obj_entity_reach"], "entity_island_reach", level.var_e859e3e2283ccd72["obj_entity_reach"].radius, undefined, undefined, undefined, 0);

  if(getDvar(@ "start") == "<dev string:xd9>") {
    wait 5;
  }

  flag_wait("entity_island_reach");
  objective_playermask_hidefromall(level.objids["obj_entity_reach"]);
  flag_wait("jansen_interrupt_ready");
  function_38456cb15e4ba032();
  flag_wait("entity_phase_01_complete");
  function_ee2610f7b788365();
}

function function_6097089379e7d090() {
  flag_wait("flag_objectives_init");

  iprintlnbold("<dev string:x1e9>");

  function_9306d91e52ec93e1("QUEST_0_RIFT_S5_08_LEAVE_RIFT");
  objective_playermask_showtoall(level.objids["obj_leave"]);
  thread function_d6a9fd29b3865dff();
  flag_wait("exfil_ready");
  thread function_533099706980bfb3();
  level waittill("gate_spawned");
  level function_ef89cf4181d076e7("STY_S5_5_STM_Exit_Portal", level.players);
  function_e4b41f1afb7f3992();
  function_5314ee75857e6c63(level.riftgate);
  level waittill("exfil_complete");

  iprintlnbold("<dev string:x205>");
}

function function_5ff7fbccdadc8978(var_f9d9c1ae54fc1b9a) {
  structs = getStructArray("oopobjectiveloc", "targetname");
  var_ac1120c88cd2c458 = 0;

  foreach(struct in structs) {
    dist = distance2d(struct.origin, var_f9d9c1ae54fc1b9a.origin);

    if(dist > var_ac1120c88cd2c458) {
      var_ac1120c88cd2c458 = dist;
    }
  }

  return var_ac1120c88cd2c458;
}

function function_37a680e171e980b(skip_setup) {
  level endon("game_ended");
  level flag::flag_wait("ob_infil_completed");
  level.extratime = 300;

  if(getdvarint(@ "hash_376091fb6ebcd20b", 0)) {
    return;
  }

  skip_setup = default_to(skip_setup, 0);

  if(!skip_setup) {
    level.var_b164efcf13fc79b8 = getStruct("ob_circle_start", "targetname");

    if(isDefined(level.var_b164efcf13fc79b8)) {
      level.ring_radius = 5000;
      v_average = namespace_88d9f8b28d831818::function_19cc82eefa6754b5();

      if(distance2d(v_average, level.var_b164efcf13fc79b8.origin) > level.ring_radius) {
        v_average = (v_average[0], v_average[1], level.var_b164efcf13fc79b8.origin[2]);
        v_average = vectorNormalize(v_average - level.var_b164efcf13fc79b8.origin) * level.ring_radius + level.var_b164efcf13fc79b8.origin;
      }

      level.ob_circle = spawnbrcircle(v_average[0], v_average[1], 10000);

      if(isDefined(level.ob_circle)) {
        level.ob_circle show();
        level.start_time = gettime();
        level.circle_duration = 2100;
        setomnvar("ui_hardpoint_timer", level.start_time + int(level.circle_duration * 1000));
        setomnvar("ui_br_circle_state", 5);
        level.var_eb1e1026f86571fd = 9;
        level.ob_circle thread namespace_88d9f8b28d831818::circledamagetick();
        level.var_afe0e659397387a7 = 33.3333 * 1;
        level.new_radius = 10000;
        level.alerted = 0;
        level.alert_time = 600;
        level.furthest_objective = function_5ff7fbccdadc8978(level.var_b164efcf13fc79b8) + 100;
        level.var_1ee97ececec31cf3 = 300;
      }
    }
  }

  var_b297501b86111233 = 0;

  if(isDefined(level.players) && isarray(level.players) && level.players.size > 0) {
    foreach(player in level.players) {
      if(isDefined(player)) {
        var_b297501b86111233 = 1;
        break;
      }
    }
  }

  if(!istrue(var_b297501b86111233)) {
    logstring("OB S5 RIFT MISSION - No players left, skipping Dark Aether Circle loop");
    return;
  }

  if(!(isDefined(level.var_1ee97ececec31cf3) && isDefined(level.alert_time) && isDefined(level.start_time) && isDefined(level.circle_duration) && isDefined(level.ob_circle))) {
    logstring("OB S5 RIFT MISSION - Incomplete Circle Setup, skipping Dark Aether Circle loop");
    return;
  }

  while(true) {
    if(level.alerted == 0 && 1000 * (level.circle_duration - level.alert_time) < gettime() - level.start_time) {
      setomnvar("ui_br_circle_state", 9);
      level.alerted = 1;
    }

    if(1000 * (level.circle_duration - level.var_1ee97ececec31cf3) < gettime() - level.start_time) {
      level.new_radius -= level.var_afe0e659397387a7;
    }

    if(level.new_radius < 0) {
      v_average = namespace_88d9f8b28d831818::function_19cc82eefa6754b5();
      circle_move(v_average, 0);
      setomnvar("ui_br_circle_state", 4);
      thread namespace_88d9f8b28d831818::function_b6c284a8a98ae76f();
      return;
    }

    v_average = namespace_88d9f8b28d831818::function_19cc82eefa6754b5();

    if(level.ring_radius + level.new_radius < level.furthest_objective) {
      level.ring_radius += level.var_afe0e659397387a7;
    }

    if(distance2d(v_average, level.var_b164efcf13fc79b8.origin) > level.ring_radius) {
      v_average = (v_average[0], v_average[1], level.var_b164efcf13fc79b8.origin[2]);
      v_average = vectorNormalize(v_average - level.var_b164efcf13fc79b8.origin) * level.ring_radius + level.var_b164efcf13fc79b8.origin;
    }

    if(flag("boss_circle_no_move")) {
      circle_move(level.var_b164efcf13fc79b8.origin, level.new_radius);
    } else {
      circle_move(v_average, level.new_radius);
    }

    wait 1;
  }
}

function function_22b8a9f1c62cffc7() {
  level.var_b164efcf13fc79b8 = getStruct("ob_circle_ascend", "targetname");
  level.furthest_objective = 3250;
  level.ring_radius = 2000;
}

function function_cd512110645424da() {
  level.var_b164efcf13fc79b8 = getStruct("ob_circle_above", "targetname");
  level.furthest_objective = 6500;
  level.ring_radius = 2000;
}

function function_818349e75a7a365c() {
  flag_set("boss_circle_no_move");
  var_fdd945d04f056ba6 = 0;

  if(level.new_radius <= 0) {
    level notify("tower_boss_time_added");
    var_fdd945d04f056ba6 = 1;
  }

  level.var_b164efcf13fc79b8 = getStruct("ob_circle_boss", "targetname");
  level.furthest_objective = 5500;
  level.ring_radius = 2000;
  level.new_radius = 10000;
  level.alerted = 0;
  level.alert_time = 60;
  level.var_1ee97ececec31cf3 = 60;
  level.var_afe0e659397387a7 = 8000 / level.var_1ee97ececec31cf3 * 1;
  circle_move(level.var_b164efcf13fc79b8.origin, level.new_radius, 0.05);

  if(1000 * (level.circle_duration - 900) < gettime() - level.start_time) {
    level.extratime += 600;
    setomnvar("ui_br_circle_state", 4);
    wait 1;
    level.circle_duration = 900;
    level.start_time = gettime();
    setomnvar("ui_hardpoint_timer", level.start_time + int(level.circle_duration * 1000));
    setomnvar("ui_br_circle_state", 5);

    if(var_fdd945d04f056ba6) {
      thread function_37a680e171e980b(1);
    }
  }

  flag_wait("entity_island_reach");
  var_836c63dfa3760ff = 2000 / 30;

  while(level.new_radius > 8000) {
    level.new_radius -= var_836c63dfa3760ff;
    wait 1;
  }
}

function function_106ef81c3ecbf2fb() {
  flag_clear("boss_circle_no_move");
  var_fdd945d04f056ba6 = 0;

  if(level.new_radius <= 0) {
    level notify("tower_boss_time_added");
    var_fdd945d04f056ba6 = 1;
  }

  level.new_radius = 8000;
  level.alerted = 0;

  if(1000 * (level.circle_duration - 180) < gettime() - level.start_time) {
    level.extratime += 180;
    setomnvar("ui_br_circle_state", 4);
    wait 1;
    level.circle_duration = 180;
    level.start_time = gettime();
    setomnvar("ui_hardpoint_timer", level.start_time + int(level.circle_duration * 1000));
    setomnvar("ui_br_circle_state", 5);

    if(var_fdd945d04f056ba6) {
      thread function_37a680e171e980b(1);
    }
  }
}

function setup_storm() {
  storm_struct = getStruct("aether_storm_spawnpoint", "targetname");
  level.cyclone = utility::spawn_model("jup_zm_s5_story_cyclone", storm_struct.origin, storm_struct.angles);
  level.var_9e3cf8372e530e4e = [];
  var_11dbcc899a92b3fa = getStructArray("boss_island_fx_ref", "targetname");

  foreach(var_996d9f751aa5c66d in var_11dbcc899a92b3fa) {
    var_ca2f6a2bbff7f609 = utility::spawn_model("jup_zm_s5_boss_island", var_996d9f751aa5c66d.origin, var_996d9f751aa5c66d.angles);
    var_ca2f6a2bbff7f609 forcenetfieldhighlod(1);
    level.var_9e3cf8372e530e4e = array_add(level.var_9e3cf8372e530e4e, var_ca2f6a2bbff7f609);
  }
}

function storm_remove() {
  function_2e656805e9a5c512();

  if(!isDefined(level.cyclone)) {
    return;
  }

  level.cyclone setscriptablepartstate("vortex", "off");
  level.cyclone hide();
  playsoundatpos(level.cyclone.origin, "evt_ob_aether_storm_dissipate");
  thread function_9bb1f79d8b9b3500();

  foreach(var_ca2f6a2bbff7f609 in level.var_9e3cf8372e530e4e) {
    var_ca2f6a2bbff7f609 setscriptablepartstate("clouds", "off");
    var_ca2f6a2bbff7f609 hide();
  }
}

function function_e74a6f43e6d48596() {
  scripts\mp\flags::function_1240434f4201ac9d("infil_started");

  if(getdvarint(@ "hash_8eb9bc764adc7c0a", 0)) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player.var_c5668dcaf32afbc3)) {
      player thread function_a74711813e464b3f();
    }
  }
}

function function_a74711813e464b3f() {
  self endon("death");
  self.var_c5668dcaf32afbc3 endon("death");

  if(istrue(self.var_c5668dcaf32afbc3.var_66c8cd2e51badc67)) {
    return;
  }

  backward = anglesToForward(self.angles) * -1;
  backward = vectorNormalize(backward);
  backward *= (128, 128, 128);
  pos = self.origin + backward;

  if(!ispointonnavmesh(pos)) {
    pos = getgroundposition(self.origin + backward, 1);

    if(!ispointonnavmesh(pos)) {
      pos = getclosestpointonnavmesh(pos);
    }
  }

  self.var_c5668dcaf32afbc3.reviving = 1;
  self.var_c5668dcaf32afbc3 forceteleport(pos);
  self.var_c5668dcaf32afbc3 clearpath();
  self.var_c5668dcaf32afbc3 namespace_dd16d65e824b8e9::function_a55b3d6929d24cf7(pos, 2);
  flag_wait("flag_intro_complete");
  wait 4;
  self.var_c5668dcaf32afbc3.reviving = 0;
}

function circle_move(v_center, var_1cee67764fdc54de, f_movetime) {
  if(!isDefined(f_movetime)) {
    f_movetime = 1;
  }

  level.ob_circle brcirclemoveTo(v_center[0], v_center[1], var_1cee67764fdc54de, f_movetime);
}

function function_6bdec09ad114d92a() {
  var_2c3b6592c121f498 = getEnt("train_island_checkpoint_trigger", "targetname");
  thread function_d1fdfd8f4cf74e50("flag_train_island_reached", var_2c3b6592c121f498);
}

function function_e109cb0f8f51949a() {
  players_missed_first_objective_trigger = getEnt("players_missed_first_objective_trigger", "targetname");
  thread function_d1fdfd8f4cf74e50("flag_players_passed_objectives", players_missed_first_objective_trigger);
}

function function_a99e3c7a93bd576c() {
  var_7804722d0e5d23f3 = 8;
  var_1c10c8d305b636de = 0;

  while(true) {
    flag_wait("flag_increment_train_tower_transition_oop_c");
    flag_clear("flag_increment_train_tower_transition_oop_c");
    var_1c10c8d305b636de++;

    if(var_7804722d0e5d23f3 == var_1c10c8d305b636de) {
      flag_set("flag_enable_auto_spacing_obj_oop_c");
      wait 120;
      flag_clear("flag_enable_auto_spacing_obj_oop_c");
      return;
    }
  }
}

function function_b524c5f462a0b862() {
  var_7804722d0e5d23f3 = 6;
  var_1c10c8d305b636de = 0;

  while(true) {
    flag_wait("flag_increment_train_tower_transition_oop_a");
    flag_clear("flag_increment_train_tower_transition_oop_a");
    var_1c10c8d305b636de++;

    if(var_7804722d0e5d23f3 == var_1c10c8d305b636de) {
      flag_set("flag_enable_auto_spacing_obj_oop_a");
      wait 120;
      flag_clear("flag_enable_auto_spacing_obj_oop_a");
      return;
    }
  }
}

function init_beams() {
  scripts\mp\flags::function_1240434f4201ac9d("infil_started");
  flag_wait("scriptables_ready");
  structs = getStructArray("objectiveloc", "targetname");

  foreach(struct in structs) {
    objname = struct.script_noteworthy;

    if(string_starts_with(objname, "obj_oop")) {
      beam = getscriptablearrayinradius("beamloc", "targetname", struct.origin, 512);

      if(isarray(beam)) {
        beam = utility::getclosest(struct.origin, beam);

        if(isDefined(beam)) {
          struct.beam = beam;
          struct.beam setscriptablepartstate("beam", "on");
          start_flag = "flag_lightning_fx_start_" + objname;
          endon_flag = "flag_batch_cleansed_" + objname;
          struct thread function_95a3610eb86f914b(start_flag, endon_flag);
        }
      }
    }
  }
}

function function_95a3610eb86f914b(start_flag, endon_flag) {
  level endon(endon_flag);
  flag_wait(start_flag);

  while(true) {
    if(level.var_cb5f8f4fc42b719d != "") {
      wait randomfloatrange(5, 10);
      continue;
    }

    closest_player = sortbydistance(level.players, self.origin)[0];

    if(isDefined(closest_player) && distancesquared(closest_player.origin, self.origin) < 9000000) {
      wait randomfloatrange(5, 10);
      continue;
    }

    x_offset = randomfloatrange(-75, 75);
    y_offset = randomfloatrange(-75, 75);
    var_a892e11baa083749 = randomfloatrange(-600, 600);
    var_634ea594f70ee15c = randomfloatrange(-600, 600);
    strike_point = self.origin + (x_offset, y_offset, 0);
    sky_point = strike_point + (var_a892e11baa083749, var_634ea594f70ee15c, 0) + (0, 0, 8000);
    var_d9e80a671452617f = function_3b3825d7947867dd(getfx("entity_lightning_vfx"), strike_point, self.angles, sky_point);
    playFX(level._effect["cleanse_site_lightning"], strike_point);
    var_d9e80a671452617f thread function_61a2751fecc1608a();
    wait randomfloatrange(10, 20);
  }
}

function setup_oop(struct) {
  struct.var_deff4278a4e37a2 = spawnscriptable("jup_zm_rift_pedestal_base_s5", struct.origin);
  struct.var_deff4278a4e37a2 setscriptablepartstate("body", "spawned");
  struct.var_deff4278a4e37a2 setscriptablepartstate("interact", "off");
  struct.var_deff4278a4e37a2.var_5ebdaf34a0a7331e = 0;
  struct.var_deff4278a4e37a2.objname = struct.script_noteworthy;
  struct.var_deff4278a4e37a2.sequence = struct.script_parameters;
  struct.var_deff4278a4e37a2.health = 2000;
  struct.var_deff4278a4e37a2.top = spawnscriptable("jup_zm_rift_pedestal_top_s5", struct.origin + (0, 0, 40));
  struct.var_deff4278a4e37a2.top setscriptablepartstate("body", "spawned");
  struct.var_deff4278a4e37a2.currstate = "QUEST_0_RIFT_S5_02_FIND_RELICS";
  struct.var_deff4278a4e37a2.parent_struct = struct;

  if(flag("oops_destroyed_complete")) {
    return;
  }

  struct.scatter_locs = [];
  struct.oop_models = [];
  struct.var_c6e423772c5ecc33 = [];
  struct.completed = 0;
  struct.found = 0;
  var_5dfa779a6f5416bd = 0;
  connected_structs = getStructArray(struct.target, "targetname");

  foreach(connected_struct in connected_structs) {
    switch (connected_struct.script_noteworthy) {
      case #"hash_de4f0ca37bc977e":
        struct.scatter_locs = array_add(struct.scatter_locs, connected_struct);
        break;
      case #"hash_608545329e338013":
        oop_model = spawn("script_model", connected_struct.origin);
        oop_model setModel(connected_struct.script_parameters);
        oop_model.angles = connected_struct.angles;
        oop_model forcenetfieldhighlod(1);
        oop_model.active_mover = 1;
        oop_model.part_state = "idle";
        oop_model.interact = scripts\cp_mp\interaction::register_interact(oop_model, 120, &oop_interact, &"JUP_OB_S5/COLLECT_RELIC");
        oop_model.interact sethintonobstruction("show");
        oop_model.struct_ref = struct;
        oop_model.cleanse_org = struct.origin + level.var_722d041c7ef50faf[var_5dfa779a6f5416bd] + (0, 0, 30);
        oop_model thread function_3c5e389a45bddd00();
        oop_model thread function_a4be5a797570cb47();
        struct.oop_models = array_add(struct.oop_models, oop_model);
        var_5dfa779a6f5416bd++;
        break;
      case #"hash_352a6ff89b866126":
        struct.var_c6e423772c5ecc33 = array_add(struct.var_c6e423772c5ecc33, connected_struct);
        break;
    }
  }

  level.oops[struct.var_deff4278a4e37a2.objname] = struct;
  struct.var_a1dca8fa3b66d7aa = 0;
  struct.var_3f8b356cc80da45b = 0;
  struct.var_aa8b72cd7cbbfe02 = 4;

  while(struct.var_a1dca8fa3b66d7aa < struct.var_aa8b72cd7cbbfe02 && !getdvarint(@ "hash_619206e8128d046e", 0)) {
    waittill_any_ents_array(struct.oop_models, "oop_in_place");
  }

  struct.var_deff4278a4e37a2.var_5148099323c9c905 = spawn("script_model", struct.origin);
  struct.var_deff4278a4e37a2.var_5148099323c9c905 setModel("tag_origin");
  playFXOnTag(level._effect["oop_pedestal_ready"], struct.var_deff4278a4e37a2.var_5148099323c9c905, "tag_origin");

  if(!flag("flag_cleanse_in_process")) {
    level utility::delaythread(2, &function_ef89cf4181d076e7, "STY_S5_5_STM_Relics_Gathered", level.players);
  }

  wait 6;
  struct.var_deff4278a4e37a2.currstate = "QUEST_0_RIFT_S5_03_A_CLEANSE";

  if(level.var_68c30a93b827e48c == 0 && level.var_cb5f8f4fc42b719d == "") {
    level thread function_e6ee0c8da1c6b5e7();
  } else if(level.var_68c30a93b827e48c == 1 && level.var_cb5f8f4fc42b719d == "") {
    level thread function_2aaf6e8bb900c3bb();
  }

  level.var_68c30a93b827e48c++;
  wait 2;
  struct.var_deff4278a4e37a2 setscriptablepartstate("interact", "on");

  if(getdvarint(@ "hash_619206e8128d046e", 0) && level.var_cb5f8f4fc42b719d == "") {
    struct.var_deff4278a4e37a2 thread function_d99aa904ce3eeecc(level.players[0]);
  } else {
    scripts\cp_mp\interaction::function_32645103f7520635(struct.var_deff4278a4e37a2, &function_d99aa904ce3eeecc, undefined, &oop_gesture);
    struct.var_deff4278a4e37a2 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_cd61583f510b15b8);
  }

  struct.var_deff4278a4e37a2 waittill("scatter_oops_" + struct.var_deff4278a4e37a2.objname, var_d441523303ce81a0);
  flag_set("flag_scatter_oops_" + struct.var_deff4278a4e37a2.objname);
  wait 2;

  for(i = 0; i < var_d441523303ce81a0; i++) {
    wait 1;
    scatter_org = struct.scatter_locs[i].origin;
    struct.oop_models[i] thread function_bf12850b46ba7ef3(struct.scatter_locs[i]);
    level.var_417eea901ee32c59 = array_add(level.var_417eea901ee32c59, struct.oop_models[i]);
  }

  struct.var_deff4278a4e37a2.currstate = "QUEST_0_RIFT_S5_04_RELOCATE";

  foreach(player in level.players) {
    player setclientomnvar("ui_br_objective_param", 0);
  }

  level thread function_66091e8421a30de1();
  flag_set("flag_scatter_oop_animation_ended");
  struct.var_deff4278a4e37a2 setscriptablepartstate("body", "spawned");
  struct.var_deff4278a4e37a2.top setscriptablepartstate("body", "spawned");

  if(level.scattered_oops > 0) {
    while(struct.var_3f8b356cc80da45b < level.scattered_oops) {
      waittill_any_ents_array(struct.oop_models, "oop_descattered");
      wait 0.5;
    }

    flag_set("flag_descattered_" + struct.var_deff4278a4e37a2.objname);
    flag_set("flag_oop_descattered");
    struct.var_deff4278a4e37a2.currstate = "QUEST_0_RIFT_S5_03_CLEANSE";
    var_cf10217b39ce3ebf = utility::getclosest(level.var_2ada333c838a2316.origin, struct.var_c6e423772c5ecc33);
    level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_df24f38b60071783(var_cf10217b39ce3ebf, undefined, "ava_stop_cleanse", "oop_batch_cleansed");
    var_76f7747444179fe1 = undefined;

    if(isDefined(var_cf10217b39ce3ebf.target)) {
      var_76f7747444179fe1 = getStruct(var_cf10217b39ce3ebf.target, "targetname");
    } else {
      var_b9d4adb1bff3ee16 = getStructArray("oop_cleanse_guard_pos", "script_noteworthy");

      if(var_b9d4adb1bff3ee16.size > 0) {
        var_e73e3f2f5f2f97be = utility::getclosest(var_cf10217b39ce3ebf.origin, var_b9d4adb1bff3ee16, 2000);

        if(isDefined(var_e73e3f2f5f2f97be)) {
          var_76f7747444179fe1 = var_e73e3f2f5f2f97be;
        }
      }

      if(!isDefined(var_76f7747444179fe1)) {
        var_76f7747444179fe1 = scripts\common\utility::function_cbd68bd4ed708086(var_cf10217b39ce3ebf.origin, 256);
      }
    }

    level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9(var_76f7747444179fe1, undefined, undefined, undefined, 1);
    level.var_2ada333c838a2316 waittill("cleanse_start_ready");
    struct.var_deff4278a4e37a2.top setscriptablepartstate("fx", "active");
    struct.var_deff4278a4e37a2 setscriptablepartstate("body", "active");
    level.var_124a97246dee96a setscriptablepartstate("body", "active");
    level.oops[level.var_cb5f8f4fc42b719d].var_deff4278a4e37a2.var_5ebdaf34a0a7331e = 1;
  }
}

function function_e6ee0c8da1c6b5e7() {
  function_14d6cbc28972404c();
  wait 1;
  function_8c2bc6fb9a4afe0f();
}

function function_2aaf6e8bb900c3bb() {
  function_14d6cbc28972404c();
  wait 1;
  function_8c2bc6fb9a4afe0f();
}

function function_66091e8421a30de1() {
  flag_wait("oop_scatter_lightning_sequence_started");
  function_14d6cbc28972404c();
  wait 1;
  function_8c2bc6fb9a4afe0f();
  flag_set("flag_scatter_obj_lull_over");
}

function private screen_flash(wait_time, fade_in_time, fade_color) {
  self notify("play_nuke_screen_flash");
  self endon("death_or_disconnect");
  self endon("play_nuke_screen_flash");
  wait_time = default_to(wait_time, 1);
  fade_in_time = default_to(fade_in_time, 0.6);
  fade_color = default_to(fade_color, "white");

  if(!isDefined(self.white_screen_overlay)) {
    self.white_screen_overlay = newclienthudelem(self);
    self.white_screen_overlay.x = 0;
    self.white_screen_overlay.y = 0;
    self.white_screen_overlay setshader(fade_color, 640, 480);
    self.white_screen_overlay.alignx = "left";
    self.white_screen_overlay.aligny = "top";
    self.white_screen_overlay.sort = 1;
    self.white_screen_overlay.horzalign = "fullscreen";
    self.white_screen_overlay.vertalign = "fullscreen";
    self.white_screen_overlay.alpha = 0;
    self.white_screen_overlay.foreground = 1;
    self.white_screen_overlay.archived = 0;
    self.white_screen_overlay.scramblerdisabled = 1;
  }

  var_52bee65a8171b558 = fade_in_time;
  n_target_alpha = 1;
  self.white_screen_overlay fadeovertime(var_52bee65a8171b558);
  self.white_screen_overlay.alpha = n_target_alpha;
  wait wait_time;
  var_52bee65a8171b558 = 0.5;
  self.white_screen_overlay fadeovertime(var_52bee65a8171b558);
  self.white_screen_overlay.alpha = 0;
  wait var_52bee65a8171b558;

  if(isDefined(self.white_screen_overlay)) {
    self.white_screen_overlay destroy();
  }
}

function function_bf12850b46ba7ef3(scatter_struct) {
  self notify("stop_idle_float");
  playFXOnTag(level._effect["oop_launch_glow"], self, "tag_origin");
  self playSound("evt_ob_rr_crystal_break_rune_unlink");
  self playLoopSound("evt_ob_story_object_power_lp");
  self setscriptablepartstate("body", "idle");
  oop_launch(scatter_struct.origin, 3.5);
  self.is_scattered = 1;
  stopFXOnTag(level._effect["oop_launch_glow"], self, "tag_origin");
  thread function_fb8ce3a759fe8568();
  thread function_a4be5a797570cb47();
  next_struct = scatter_struct;
  self endon("oop_descattered_begin");

  while(true) {
    next_struct = getStruct(next_struct.target, "targetname");
    var_8d3193b359f36594 = distance(next_struct.origin, self.origin);
    travel_time = var_8d3193b359f36594 / 60;
    self moveTo(next_struct.origin, travel_time);
    wait travel_time;
  }
}

function function_fb8ce3a759fe8568() {
  flag_wait("flag_scatter_obj_initialized");
  flag_wait("flag_scatter_obj_lull_over");
  self.interact makeusable();
  self.interact sethintonobstruction("show");
  self.interact setHintString(&"JUP_OB_S5/COLLECT_RELIC");
}

function function_3c5e389a45bddd00() {
  self endon("death");
  self endon("pause_floater");
  self endon("stop_idle_float");
  level endon("game_ended");
  self.var_fafa04e766ba2e01 = self.origin;
  var_765448b4e204915a = getdvarint(@ "hash_7a2c55bde0ef6737", 3000);

  while(true) {
    if(!players_within_distance(var_765448b4e204915a)) {
      if(self.active_mover) {
        self.active_mover = 0;

        if(getdvarint(@ "hash_e561a0f77e21a9dd", 0)) {
          self forcenetfieldhighlod(0);
          self.part_state = self getscriptablepartstate("body");
          self setscriptablepartstate("body", "off");
        }
      }

      if(getdvarint(@ "hash_3a5d91a174d0fb7f", 0)) {
        level thread scripts\cp_mp\utility\debug_utility::drawsphere(self.origin, 50, 1, (1, 0, 0));
      }

      wait 1;
      continue;
    } else if(!self.active_mover) {
      self.active_mover = 1;

      if(getdvarint(@ "hash_e561a0f77e21a9dd", 0)) {
        self forcenetfieldhighlod(1);
        self setscriptablepartstate("body", self.part_state);
      }
    }

    n_move = randomfloatrange(10, 15);
    n_time = randomfloatrange(1, 1.5);
    n_lerptime = n_time * 0.333;
    self movez(n_move, n_time, n_lerptime, n_lerptime);
    wait n_time + 0.2;
    n_time = randomfloatrange(1, 1.5);
    n_lerptime = n_time * 0.333;
    self movez(n_move * -1, n_time, n_lerptime, n_lerptime);
    wait n_time + 0.2;
  }
}

function function_a4be5a797570cb47() {
  self endon("death");
  self endon("pause_floater");
  self endon("stop_idle_float");
  level endon("game_ended");

  while(true) {
    if(!self.active_mover) {
      wait 1;
      continue;
    }

    n_rotate = randomfloatrange(10, 25);
    n_time = randomfloatrange(1, 1.5);

    if(utility::cointoss()) {
      n_rotate *= -1;
    }

    self rotateby((n_rotate, n_rotate, n_rotate), n_time);
    wait n_time + 0.2;
    n_time = randomfloatrange(1, 1.5);
    self rotateby((n_rotate, n_rotate, n_rotate) * -1, n_time);
    wait n_time + 0.2;
  }
}

function private oop_launch(v_target, time) {
  v_start = self.origin;
  gravity = getdvarint(@ "bg_gravity", 800) * -0.5;
  gravity_vec = (0, 0, gravity);
  delta = v_target - v_start;
  var_a78ffefa785281da = trajectorycalculateinitialvelocity(v_start, v_target + delta, gravity_vec, time);
  start_time = gettime();
  gravity_vec = (0, 0, -2 * gravity);
  dist_sq = 10000;

  while(distancesquared(self.origin, v_target) > dist_sq) {
    t = (gettime() - start_time) * 0.001;
    self.origin = v_start + var_a78ffefa785281da * t - 0.5 * gravity_vec * t * t;
    waitframe();
  }

  self moveTo(v_target, 0.25);
  wait 0.5;
}

function oop_interact(player) {
  if(istrue(self.is_scattered)) {
    ent_flag_set("oop_descattered_begin");
  }

  self stoploopsound();
  playsoundatpos(self.origin, "evt_ob_story_relic_pickup");
  self makeunusable();
  self notify("stop_idle_float");
  self playLoopSound("evt_ob_story_relic_cleanse_travel_lp");
  playFXOnTag(level._effect["oop_launch_glow"], self, "tag_origin");
  oop_launch(self.cleanse_org, 2.5);
  self stoploopsound();
  stopFXOnTag(level._effect["oop_launch_glow"], self, "tag_origin");
  playFX(level._effect["oop_destroyed"], self.origin);
  playsoundatpos(self.origin, "evt_ob_story_relic_cleanse_link");
  self setscriptablepartstate("body", "lockedin");
  thread function_162c721acc0208e7();

  if(istrue(self.is_scattered)) {
    level.oops[level.var_cb5f8f4fc42b719d].var_3f8b356cc80da45b++;
    self notify("oop_descattered", level.var_cb5f8f4fc42b719d);
    return;
  }

  obj_name = self.struct_ref.script_noteworthy;
  level.oops[obj_name].var_a1dca8fa3b66d7aa++;
  self notify("oop_in_place");
}

function function_162c721acc0208e7() {
  var_f387b09bb3a84bb0 = 0;

  for(pingindex = 0; pingindex < 10; pingindex++) {
    foreach(player in level.players) {
      pingent = player calloutmarkerping_getEnt(pingindex);

      if(!isDefined(pingent) || !isDefined(pingent.model)) {
        continue;
      }

      if(player calloutmarkerping_getactive(pingindex) && pingent.model == self.model) {
        player calloutmarkerping_hide(pingindex);
        var_f387b09bb3a84bb0 = 1;
        break;
      }
    }

    if(var_f387b09bb3a84bb0) {
      break;
    }
  }
}

function function_cd61583f510b15b8(interact, player) {
  if(level.var_cb5f8f4fc42b719d != "" && is_equal(level.var_cb5f8f4fc42b719d, interact.objname)) {
    return {
      #string: &"", #type: "HINT_NOBUTTON"};
  }

  if(level.var_cb5f8f4fc42b719d != "" || flag("flag_post_cleanse_vo_running")) {
    return {
      #string: &"JUP_OB_S5/CLEANSE_ALREADY_IN_PROGRESS", #type: "HINT_NOBUTTON"};
  }

  return {
    #string: &"JUP_OB_S5/ACTIVATE_CLEANSE", #type: "HINT_BUTTON"};
}

function function_d99aa904ce3eeecc(player) {
  if(level.var_cb5f8f4fc42b719d != "" || flag("flag_post_cleanse_vo_running")) {
    return;
  }

  flag_set("flag_cleanse_in_process");

  if(getdvarint(@ "hash_619206e8128d046e", 0)) {
    level.var_cb5f8f4fc42b719d = self.objname;
    teleportpos = getclosestpointonnavmesh(anglesToForward(self.angles) * 200 + self.origin);
    level.players[0] setOrigin(teleportpos);
    level.players[0] setplayerangles(vectortoangles(vectorNormalize(self.origin - teleportpos)));
    wait 5;
  }

  function_14d6cbc28972404c();
  level.var_cb5f8f4fc42b719d = self.objname;
  thread function_44d53aa01344375e();
  thread function_124a5ccdd665fbe5();
  level thread function_bf8e74e327ba6f46(self.objname, self.origin);
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_action_loop");
  self setscriptablepartstate("interact", "off");

  if(isDefined(self.parent_struct.beam)) {
    self.parent_struct.beam setscriptablepartstate("beam", "off");
  }

  level notify("oop_cleanse_started", self.objname);
  self.var_5ebdaf34a0a7331e = 1;
  self.currstate = "QUEST_0_RIFT_S5_03_CLEANSE";
  earthquake(0.5, 0.8, self.origin, 1500);

  foreach(player in level.players) {
    player thread screen_flash(0.1, 0.3);
  }

  stopFXOnTag(level._effect["oop_pedestal_ready"], self.var_5148099323c9c905, "tag_origin");
  level.var_124a97246dee96a = spawnscriptable("jup_zm_rift_pedestal_orb_scriptable", self.origin + (0, 0, 50), self.angles);
  var_cf10217b39ce3ebf = utility::getclosest(level.var_2ada333c838a2316.origin, level.oops[self.objname].var_c6e423772c5ecc33);
  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_df24f38b60071783(var_cf10217b39ce3ebf, undefined, "ava_stop_cleanse");
  var_76f7747444179fe1 = undefined;

  if(isDefined(var_cf10217b39ce3ebf.target)) {
    var_76f7747444179fe1 = getStruct(var_cf10217b39ce3ebf.target, "targetname");
  } else {
    var_b9d4adb1bff3ee16 = getStructArray("oop_cleanse_guard_pos", "script_noteworthy");

    if(var_b9d4adb1bff3ee16.size > 0) {
      var_e73e3f2f5f2f97be = utility::getclosest(var_cf10217b39ce3ebf.origin, var_b9d4adb1bff3ee16, 2000);

      if(isDefined(var_e73e3f2f5f2f97be)) {
        var_76f7747444179fe1 = var_e73e3f2f5f2f97be;
      }
    }

    if(!isDefined(var_76f7747444179fe1)) {
      var_76f7747444179fe1 = scripts\common\utility::function_cbd68bd4ed708086(var_cf10217b39ce3ebf.origin, 256);
    }
  }

  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9(var_76f7747444179fe1, undefined, undefined, undefined, 1);
  level.var_2ada333c838a2316 waittill("cleanse_start_ready");
  self.top setscriptablepartstate("fx", "active");
  self setscriptablepartstate("body", "active");
  level.var_d96080b08bb3766a = level.var_74cb06793a691f19[level.var_b446741821221b5d] * (1 + 0.6 * (min(level.players.size, 3) - 1));

  if(getdvarint(@ "hash_7ab73409d133576a", 0)) {
    level.var_d96080b08bb3766a = getdvarint(@ "hash_7ab73409d133576a", 0);
  }

  level callback::add("on_ai_killed", &function_8a8357692e12f30e);
  level callback::add("player_laststand", &function_4dc9c1ddcacd045f);
  thread function_658b421b37fd7662();
  should_scatter = level.var_9f6a3aeb68ae417e > 0;
  thread function_45c0dcd4ea930e08(should_scatter);
  function_8c2bc6fb9a4afe0f();

  if(level.var_9f6a3aeb68ae417e == 0) {
    level.var_1da22412ed7ad03b.grenadeammo = 1;
    level.var_2ada333c838a2316.grenadeammo = 1;
  }
}

function function_658b421b37fd7662() {
  while(level.var_cb5f8f4fc42b719d != "") {
    var_f911aed45eb961a3 = getaiarrayinradius(self.origin, 1500);

    foreach(zombie in var_f911aed45eb961a3) {
      if(!isDefined(zombie.var_f89106513931332c)) {
        zombie.var_f89106513931332c = 0;
      }

      var_52d83275cdaec498 = function_ab8fa997c41c9ed8(self, zombie);

      if(var_52d83275cdaec498 == 1 && zombie.var_f89106513931332c == 0 && isalive(zombie) && self.var_5ebdaf34a0a7331e == 1) {
        zombie function_3ab9164ef76940fd("obelisk_vfx", "electric");
        zombie.var_f89106513931332c = 1;
        continue;
      }

      if(var_52d83275cdaec498 == 0 && zombie.var_f89106513931332c == 1 || self.var_5ebdaf34a0a7331e == 0) {
        zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
        zombie.var_f89106513931332c = 0;
      }
    }

    wait 0.2;
  }
}

function function_ab8fa997c41c9ed8(pedestal, zombie) {
  var_52d83275cdaec498 = distance2dsquared(zombie.origin, pedestal.origin) < squared(900);

  if(!istrue(var_52d83275cdaec498)) {
    return false;
  }

  var_7935799a7ca9401a = is_equal(pedestal.objname, "obj_oop_a") ? 200 : 1400;
  return zombie.origin[2] > var_7935799a7ca9401a;
}

function function_8a8357692e12f30e(params) {
  self function_9322f3cb1cd4111a();
  function_3ab9164ef76940fd("obelisk_vfx", "off");
  var_cb5f8f4fc42b719d = level.oops[level.var_cb5f8f4fc42b719d].var_deff4278a4e37a2;

  if(isDefined(params.eattacker) && !isPlayer(params.eattacker)) {
    nearest_player = getclosest(self.origin, level.players, 2000);

    if(!isDefined(nearest_player)) {
      return;
    }
  }

  if(function_ab8fa997c41c9ed8(var_cb5f8f4fc42b719d, self) && level.scattered_oops - level.oops[level.var_cb5f8f4fc42b719d].var_3f8b356cc80da45b == 0) {
    playFX(getfx("zombie_death"), self.origin);

    if(level.var_fe48d87019665c36 < level.var_d96080b08bb3766a) {
      zombiecount = undefined;

      if(self.aicategory == "special") {
        zombiecount = 3;
      } else if(self.aicategory == "normal") {
        zombiecount = 1;
      }

      zombiecount = getdvarint(@ "hash_a49725c449ea0e2b", 1) * zombiecount;
      function_2b6783f1c69393ff(self.origin + (0, 0, 40), level.var_124a97246dee96a.origin + (0, 0, 130), 0.25, zombiecount);
    }
  }
}

function function_4dc9c1ddcacd045f(params) {
  if(level.var_cb5f8f4fc42b719d != "" && level.var_6d298bb3b2c8bf0 == 0) {
    if(distance2dsquared(self.origin, level.oops[level.var_cb5f8f4fc42b719d].origin) < 2250000) {
      if(level.var_8690751fda8758ed < level.var_bf1779f835f11a69.size) {
        level.var_6d298bb3b2c8bf0 = level.var_bf1779f835f11a69[level.var_8690751fda8758ed];
        level.var_8690751fda8758ed++;
        wait level.var_6d298bb3b2c8bf0;
        level.var_6d298bb3b2c8bf0 = 0;
      }
    }
  }
}

function function_2b6783f1c69393ff(spawn_origin, goal_position, move_delay, zombiecount) {
  move_delay = utility::default_to(move_delay, 0);
  trail = utility::spawn_model("tag_origin", spawn_origin);
  trail.goal_position = goal_position;
  playFXOnTag(getfx("zombie_soul"), trail, "tag_origin");
  trail thread function_57961c5b765c270(move_delay, zombiecount);
}

function function_57961c5b765c270(move_delay, zombiecount) {
  self endon("death");
  self playSound("evt_ob_rr_obelisk_soul_spawn");
  self playLoopSound("evt_ob_rr_obelisk_soul_lp");

  if(move_delay > 0) {
    wait move_delay;
  }

  self moveTo(self.goal_position, 0.8, 0.2);
  self waittill("movedone");
  playFX(getfx("zombie_soul_impact"), self.goal_position);
  killfxontag(getfx("zombie_soul"), self, "tag_origin");
  playsoundatpos(self.origin, "evt_ob_rr_obelisk_soul_impact");
  function_2d90a2631e02d9ba(zombiecount);
  self delete();
}

function function_2d90a2631e02d9ba(zombiecount) {
  if(flag("flag_objectives_hidden")) {
    return;
  }

  if(flag("oop_scatter_lightning_sequence_started") && !flag("flag_oop_descattered")) {
    return;
  }

  function_6998c79af159d42f(zombiecount);
  var_b4c7ef79e1e2b487 = min(level.var_fe48d87019665c36 / level.var_d96080b08bb3766a, 1);

  if(level.var_cb5f8f4fc42b719d != "" && level.oops[level.var_cb5f8f4fc42b719d].var_deff4278a4e37a2.currstate == "QUEST_0_RIFT_S5_03_CLEANSE") {
    foreach(player in level.players) {
      player setclientomnvar("ui_br_objective_progress_bar", int(var_b4c7ef79e1e2b487 * 100));
    }
  }

  if(var_b4c7ef79e1e2b487 >= 0.75 && !flag("flag_batch_cleansed_near_done_" + level.var_cb5f8f4fc42b719d)) {
    level thread function_ef89cf4181d076e7("STY_S5_5_STM_Cleansing_Near_Done", level.players);
    flag_set("flag_batch_cleansed_near_done_" + level.var_cb5f8f4fc42b719d);
  }

  if(var_b4c7ef79e1e2b487 >= 1) {
    level.oops[level.var_cb5f8f4fc42b719d] thread function_f4be077d820e4b3e(level.oops[level.var_cb5f8f4fc42b719d].origin);
    return;
  }

  if(var_b4c7ef79e1e2b487 * 4 >= level.var_9bbb03c4c61a5cf0 + 1) {
    level.var_9bbb03c4c61a5cf0++;
  }
}

function function_6998c79af159d42f(zombiecount) {
  if(level.var_c5a523b131f71672 > 1) {
    return;
  }

  level.var_fe48d87019665c36 += zombiecount;
  level.var_c5a523b131f71672 += zombiecount;
}

function function_124a5ccdd665fbe5() {
  level endon("oop_batch_cleansed");

  while(true) {
    level.var_c5a523b131f71672 = 0;
    wait 1.2;
  }
}

function oop_gesture(player) {
  wait 1.15;

  if(player useButtonPressed()) {
    player forceplaygestureviewmodel("jup_ges_open_portal");
  }
}

function function_44d53aa01344375e() {
  var_8487d67ef9b8e18a = self.origin + (0, 0, 300);
  var_2a03d25c8e2a9d61 = ai_spawn_director::spawn_request("ai_encounter:s5_rift_sm_cleanse_special_0" + level.var_9f6a3aeb68ae417e + 1, var_8487d67ef9b8e18a, 800, 1, 0);
  function_7a2920be35f4386(var_2a03d25c8e2a9d61, &function_ec2606f0505711b6, self);
  function_e4a67fe4ddca7ed5(var_2a03d25c8e2a9d61, &function_86c4d32f8fee3112, self);
  function_fc38783a3da0bc71(var_2a03d25c8e2a9d61, 1);
  var_a93f9b55a638b306 = spawn_request("ai_flood_fill_encounter:s5_rift_sm_cleanse_0" + level.var_9f6a3aeb68ae417e + 1, var_8487d67ef9b8e18a, 800, 1, 1, 0);
  function_bc5315dc37ae4cf(var_a93f9b55a638b306, &function_bd17be25cfad86e9, level.var_9f6a3aeb68ae417e);
  function_73147cdf5c28d10c(var_a93f9b55a638b306, &function_1a22e40c13b90fa5, self);
  function_e4a67fe4ddca7ed5(var_a93f9b55a638b306, &function_57f2664603e2929d, self);
}

function function_ec2606f0505711b6(requestid, userdata, wavenumber) {
  if(getdvarint(@ "hash_7ab73409d133576a", 0)) {
    return 0;
  }

  if(is_equal(wavenumber, 0)) {
    return 1;
  }

  if(!isDefined(level.var_fe48d87019665c36) || !isDefined(level.var_d96080b08bb3766a)) {
    return 0;
  }

  var_b4c7ef79e1e2b487 = min(level.var_fe48d87019665c36 / level.var_d96080b08bb3766a, 1);
  var_9813c17ce7110cb2 = var_b4c7ef79e1e2b487 > level.var_b51ec0a3bc26a040[wavenumber];
  return var_9813c17ce7110cb2;
}

function function_45c0dcd4ea930e08(should_scatter) {
  level endon("oop_batch_cleansed");
  has_scattered = 0;
  has_skipped = 0;

  while(level.var_fe48d87019665c36 / level.var_d96080b08bb3766a < 1) {
    var_4c40aff70ad39a9a = min(level.var_fe48d87019665c36 / level.var_d96080b08bb3766a, 1) >= 0.6;

    if(istrue(should_scatter) && !istrue(has_scattered) && var_4c40aff70ad39a9a) {
      var_19a5b06f72c32aa3 = 3;
      self.var_5ebdaf34a0a7331e = 0;
      self notify("scatter_oops_" + self.objname, var_19a5b06f72c32aa3);
      level notify("scatter_oops_" + self.objname, var_19a5b06f72c32aa3);
      level notify("ava_stop_cleanse");
      level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9(self.origin);
      level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9(self.origin);
      function_3a1439ed85c062e8();
      wait 0.3;
      level.var_f65c4ae0507e9e5c = gettime();
      level thread function_ee2a20015e37d3ec("STY_S5_5_STM_Relics_Scattered", level.players);
      flag_set("flag_relics_scattered");
      level.scattered_oops = var_19a5b06f72c32aa3;
      level.var_124a97246dee96a setscriptablepartstate("body", "done");
      self.top setscriptablepartstate("fx", "off");
      self setscriptablepartstate("body", "spawned");
      function_f3ef44fe7848cf3();
      has_scattered = 1;
    }

    if(var_4c40aff70ad39a9a && !has_skipped) {
      flag_set("oop_scattered_or_skipped_" + self.objname);

      if(!istrue(should_scatter)) {
        flag_set("oop_skipped_" + self.objname);
      }

      has_skipped = 1;
    }

    wait 0.25;
  }
}

function function_3a1439ed85c062e8() {
  flag_set("oop_scatter_lightning_sequence_started");
  thread function_45ce0277f25c2af5();
  function_652cf44231048899();
  earthquake(0.5, 0.4, self.origin, 1500);
  wait 0.4;
  function_652cf44231048899();
  earthquake(0.5, 0.4, self.origin, 1500);
  wait 0.4;
  function_652cf44231048899();
  earthquake(0.5, 0.4, self.origin, 1500);
  wait 1.2;
  function_652cf44231048899();
  earthquake(0.7, 1, self.origin, 1500);

  foreach(player in level.players) {
    player thread screen_flash(0.2, 0.7);
  }

  thread function_9bb1f79d8b9b3500();
}

function function_652cf44231048899(offset) {
  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  upvector = anglestoup(self.angles);
  var_85d4a0106b97123b = self.origin + offset + upvector * 2000;
  var_d5e3b953bf9f7314 = self.origin + offset;
  var_d9e80a671452617f = function_3b3825d7947867dd(getfx("entity_lightning_vfx"), var_85d4a0106b97123b, self.angles, var_d5e3b953bf9f7314);
  playFX(getfx("entity_lightning_impact_vfx"), var_d5e3b953bf9f7314);
  var_d9e80a671452617f thread function_61a2751fecc1608a();
  var_f58ff3d10850cca2 = getaiarrayinradius(self.origin, 800, "team_two_hundred");

  foreach(zombie in var_f58ff3d10850cca2) {
    if(isalive(zombie) && !zombie namespace_db1ce2c035564e2c::function_e67a89537ae7d4b7()) {
      zombie namespace_db1ce2c035564e2c::knockdown_ai(self.origin);
    }
  }
}

function private function_61a2751fecc1608a() {
  level endon("game_ended");
  wait 1;
  self delete();
}

function function_ae165af362de18a2() {
  level endon("game_ended");

  while(true) {
    self waittill("trigger", entity);

    if(isDefined(entity.vehicletype)) {
      vehicleoccupants = entity.occupants;
      var_95dfb4ea629973 = 0;

      foreach(occupant in vehicleoccupants) {
        if(isPlayer(occupant)) {
          var_95dfb4ea629973 = 1;
          break;
        }
      }

      if(var_95dfb4ea629973) {
        break;
      }
    }

    if(!isPlayer(entity)) {
      continue;
    }

    break;
  }
}

function function_d1fdfd8f4cf74e50(flag_to_set, var_4cb1038d4bba19ae) {
  while(true) {
    var_4cb1038d4bba19ae waittill("trigger", triggerer);

    if(isPlayer(triggerer)) {
      break;
    }
  }

  flag_set(flag_to_set);
}

function function_51faf1846c3be2c7() {
  skip_oop = getdvarint(@ "hash_70137a31061014a5", 0);

  if(!skip_oop) {
    level flag_wait("oops_destroyed_complete");
  }

  lower_trigger = getEnt("ascent_lower_trigger", "targetname");
  upper_trigger = getEnt("ascent_upper_trigger", "targetname");
  checkpoint_trigger = getEnt("ascent_checkpoint_trigger", "targetname");
  var_7bcbd7c650a1a319 = getEnt("ascent_near_tower_trigger", "targetname");
  on_train_trigger = getEnt("ascent_on_train_trigger", "targetname");
  var_343314612a865d1 = getEnt("ascent_rooftop_trigger", "targetname");
  approach_tower = getEnt("ascent_approach_tower_trigger", "targetname");
  thread function_d1fdfd8f4cf74e50("flag_ascent_spawn_lower", lower_trigger);
  thread function_d1fdfd8f4cf74e50("flag_ascent_spawn_upper", upper_trigger);
  thread function_d1fdfd8f4cf74e50("flag_ascend_checkpoint", checkpoint_trigger);
  thread function_d1fdfd8f4cf74e50("flag_ascend_near_tower", var_7bcbd7c650a1a319);
  thread function_d1fdfd8f4cf74e50("flag_ascent_on_train", on_train_trigger);
  thread function_d1fdfd8f4cf74e50("flag_ascent_rooftop", var_343314612a865d1);
  thread function_d1fdfd8f4cf74e50("flag_ascent_approach_tower", approach_tower);
  thread function_d1fdfd8f4cf74e50("flag_ascend_on_train_upper", upper_trigger);
  thread function_6af2d22b0cf0cc5();
  thread function_c74210608b43eac();
  thread function_d59d6aeec3e7bf91();
  thread function_2176718022be80f0();
}

function function_2176718022be80f0() {
  var_ca9f28fca7220f7 = getStruct("ascend_tower_bot_ava_teleport_point", "targetname");
  var_61a919250094b7a = getStruct("ascend_tower_bot_rav_teleport_point", "targetname");
  var_f06cf9c2b70f788e = getStruct("ascend_tower_mid_ava_teleport_point", "targetname");
  var_725c3e5ea9f32b57 = getStruct("ascend_tower_mid_rav_teleport_point", "targetname");
  var_700efcc1011b7d91 = getStruct("ascend_tower_top_ava_teleport_point", "targetname");
  var_175b0269494b776c = getStruct("ascend_tower_top_rav_teleport_point", "targetname");
  flag_wait_any_array(["flag_ascend_near_tower", "reached_tower_bottom", "flag_ascend_checkpoint", "reached_tower_top"]);
  level utility::delaythread(30, &flag_set, "flag_ascent_hint");

  if(!isDefined(level.var_2ada333c838a2316) && !isDefined(level.var_1da22412ed7ad03b)) {
    return;
  }

  level.var_2ada333c838a2316 namespace_60bff5112336ce6::function_c75b149451e69c1();
  level.var_1da22412ed7ad03b namespace_60bff5112336ce6::function_c75b149451e69c1();
  level.var_2ada333c838a2316 namespace_bc50cc28d0217818::function_d6e4c5c74c55fe0(var_ca9f28fca7220f7.origin, (0, 191, 0));
  level.var_1da22412ed7ad03b namespace_bc50cc28d0217818::function_d6e4c5c74c55fe0(var_61a919250094b7a.origin, (0, 146, 0));
  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9();
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9();
  flag_wait_any_array(["flag_ascend_checkpoint", "flag_ascent_on_train", "reached_tower_top", "flag_ascent_hint"]);
  wait 1;

  if(!isDefined(level.var_2ada333c838a2316) && !isDefined(level.var_1da22412ed7ad03b)) {
    return;
  }

  level.var_2ada333c838a2316 namespace_60bff5112336ce6::function_c75b149451e69c1();
  level.var_1da22412ed7ad03b namespace_60bff5112336ce6::function_c75b149451e69c1();
  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_d6e4c5c74c55fe0(var_f06cf9c2b70f788e.origin, (0, 144.8, 0));
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_d6e4c5c74c55fe0(var_725c3e5ea9f32b57.origin, (0, 146, 0));

  while(istrue(level.var_2ada333c838a2316.teleporting) || istrue(level.var_1da22412ed7ad03b.teleporting)) {
    waitframe();
  }

  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9();
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9();
  flag_wait_either("flag_ascend_on_train_upper", "reached_tower_top");
  level.var_2ada333c838a2316 namespace_60bff5112336ce6::function_c75b149451e69c1();
  level.var_1da22412ed7ad03b namespace_60bff5112336ce6::function_c75b149451e69c1();
  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_d6e4c5c74c55fe0(var_700efcc1011b7d91.origin, (0, 160.8, 0));
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_d6e4c5c74c55fe0(var_175b0269494b776c.origin, (0, 160.8, 0));

  while(istrue(level.var_2ada333c838a2316.teleporting) || istrue(level.var_1da22412ed7ad03b.teleporting)) {
    waitframe();
  }

  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9();
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9();
  flag_wait("reached_tower_top");
  wait 2;
  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_101b97bce06bef4();
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_101b97bce06bef4();
  level thread function_cfa1dee287ea62b8();
}

function function_cfa1dee287ea62b8() {
  level endon("game_ended");
  var_6ad77098599a1ed = spawnStruct();
  var_6ad77098599a1ed.origin = (16368, 20956, 4104);
  var_ed589e9e3dc11c53 = spawnStruct();
  var_ed589e9e3dc11c53.origin = (14524, 20876, 6024);
  var_17405c26e2f37ac4 = spawnStruct();
  var_17405c26e2f37ac4.origin = (14608, 21192, 6024);
  thread function_a5b76e0f5024cc9a(var_6ad77098599a1ed, "reached_final_tower_jump_pad", 400, undefined, undefined, undefined, 0);
  flag_wait("flag_rooftop_encounter_complete");
  flag_wait("reached_final_tower_jump_pad");

  if(flag("flag_used_tear_leave_roof")) {
    return;
  }

  level thread scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Train_Aether_Tear_Callout", level.players, 2);
  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_d6e4c5c74c55fe0(var_17405c26e2f37ac4.origin, (0, 0, 0));
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_d6e4c5c74c55fe0(var_ed589e9e3dc11c53.origin, (0, 0, 0));

  while(istrue(level.var_2ada333c838a2316.teleporting) || istrue(level.var_1da22412ed7ad03b.teleporting)) {
    waitframe();
  }

  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9();
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_a4f2de37b22bd9f9();
  flag_wait_or_timeout("flag_used_tear_leave_roof", 60);
  wait 2;
  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_101b97bce06bef4();
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_101b97bce06bef4();
}

function function_c74210608b43eac() {
  flag_wait("flag_ascent_spawn_lower");
  spawnloc_1 = getStruct("ascent_lower_mangler", "targetname");
  spawnloc_2 = getStruct("ascent_lower_mangler_2", "targetname");
  spawnloc_1.angles = (0, 120, 0);
  var_ba1786164a780499 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_mangler", spawnloc_1.origin, spawnloc_1.angles, "team_two_hundred");
  var_ba1786164a780499 setgoalpos(getStruct("mangler_goal_1", "targetname").origin);
  var_ba1786164a780499 thread function_3fa0e6c37c2c9240();
  var_7532f7b2544dd9c0 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_mangler", spawnloc_2.origin, spawnloc_2.angles, "team_two_hundred");
  var_7532f7b2544dd9c0 setgoalpos(getStruct("mangler_goal_2", "targetname").origin);
  var_7532f7b2544dd9c0 thread function_3fa0e6c37c2c9240();
}

function function_d59d6aeec3e7bf91() {
  flag_wait("flag_ascent_spawn_upper");
  spawnloc = getStruct("ascent_upper_mangler", "targetname");
  spawnloc.angles = (0, 80, 0);
  var_ba1786164a780499 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_mangler", spawnloc.origin, spawnloc.angles, "team_two_hundred");
  var_ba1786164a780499 setgoalpos(getStruct("mangler_goal_3", "targetname").origin);
  var_ba1786164a780499 thread function_3fa0e6c37c2c9240();
}

function function_3fa0e6c37c2c9240() {
  self endon("death");

  if(!isDefined(level.ascent_manglers)) {
    level.ascent_manglers = [];
  }

  level.ascent_manglers = array_add(level.ascent_manglers, self);
  fav_player = get_closest_player(self.origin);

  if(isDefined(fav_player)) {
    level.var_e4a4a66012e23ec = fav_player;
    self aieventlistenerevent("attack", fav_player, fav_player.origin);
  }

  self function_65cdab0fc78aba8f(self.origin, 3400);
  self.torpedo_cooldown = 0.05;
  self setthreatbiasgroup("ascent_manglers");

  if(getdvarint(@ "hash_7c3ace17231d9b30", 0) == 0) {
    while(!isDefined(level.mangler_target)) {
      wait 0.25;
    }

    self.favoriteenemy = level.mangler_target;
  }

  var_b2baa37ffccfe1e1 = gettime();

  while(!time_has_passed(var_b2baa37ffccfe1e1, 40) && !flag("flag_used_tear_leave_roof") && !istrue(self.var_84a9c43b4709d6c9)) {
    self.zombieaisettings.var_e58a65b7a8f5973c.torpedomaxrange = 2400;
    wait 1;
  }

  if(getdvarint(@ "hash_e51e4ee8ca17449f", 0)) {
    iprintlnbold("<dev string:x211>");
  }

  self.favoriteenemy = undefined;
  self.torpedo_cooldown = 3;
  self setthreatbiasgroup("team_two_hundred");
}

function function_6af2d22b0cf0cc5() {
  level endon("game_ended");
  createthreatbiasgroup("ascent_manglers");
  createthreatbiasgroup("mangler_target");
  setthreatbias("ascent_manglers", "mangler_target", 10000);
  setignoremegroup("mangler_target", "team_two_hundred");
  setignoremegroup("allies", "ascent_manglers");

  if(getdvarint(@ "hash_7c3ace17231d9b30", 0)) {
    return;
  }

  flag_wait_either("flag_ascent_spawn_upper", "flag_ascent_spawn_lower");
  level.mangler_target = spawn("script_origin", (0, 0, 0));
  level.mangler_target makeentitysentient("allies");
  level.mangler_target setthreatbiasgroup("mangler_target");
  level.mangler_target makeentitynomeleetarget();
  level.mangler_target thread function_6a35f311c19fb998();
}

function function_6a35f311c19fb998() {
  level endon("game_ended");

  while(!isDefined(level.ascent_manglers)) {
    wait 0.25;
  }

  while(true) {
    if(flag("flag_used_tear_leave_roof")) {
      break;
    }

    level.ascent_manglers = function_fdc9d5557c53078e(level.ascent_manglers);

    if(level.ascent_manglers.size == 0 || !isDefined(level.var_e4a4a66012e23ec)) {
      wait 0.25;
      continue;
    }

    target_player = level.var_e4a4a66012e23ec;
    groundent = target_player getgroundentity();

    if(!isDefined(groundent) || !isDefined(groundent.script_noteworthy) || !issubstr(groundent.script_noteworthy, "train_car_")) {
      self.origin = target_player.origin + (0, 0, 40);
      wait 0.25;
      continue;
    }

    if(function_de6311a5a0178ef9(groundent.script_noteworthy)) {
      var_c6049c06cf7935dc = -1 * anglesToForward(groundent.angles);
    } else {
      var_c6049c06cf7935dc = anglesToForward(groundent.angles);
    }

    self.origin = target_player.origin + var_c6049c06cf7935dc * 200;

    if(getdvarint(@ "hash_e51e4ee8ca17449f", 0)) {
      print3d(self.origin, "<dev string:x240>", undefined, 1, 2, 5, 1);
    }

    wait 0.25;
  }

  self delete();
}

function function_de6311a5a0178ef9(train_name) {
  switch (train_name) {
    case #"hash_c75817664ca2af50":
    case #"hash_c75820664ca2bd7b":
    case #"hash_c75821664ca2bf0e":
    case #"hash_c75822664ca2c0a1":
    case #"hash_c75823664ca2c234":
    case #"hash_c75824664ca2c3c7":
    case #"hash_c75825664ca2c55a":
    case #"hash_c75826664ca2c6ed":
      return true;
  }

  return false;
}

function function_7a909542ec2137e8(var_fb1f0791e48de42f) {
  while(!isDefined(level.var_d96080b08bb3766a)) {
    wait 0.25;
  }

  squadsize = level.players.size;
  var_b4a0bb985e832edf = min(level.var_fe48d87019665c36 / 100, 1);
  var_415fd8a0dbe8422f = 0.5 / min(squadsize, 3) + 0.1 * max(2 - var_fb1f0791e48de42f, 0) - 0.5;
  var_ebae3ffd14f48d6e = 3.5 / min(squadsize, 3) + 0.2 * max(2 - var_fb1f0791e48de42f, 0) - 0.5;
  waveinterval = var_415fd8a0dbe8422f + (var_ebae3ffd14f48d6e - var_415fd8a0dbe8422f) * (1 - var_b4a0bb985e832edf);
  wait waveinterval + level.var_6d298bb3b2c8bf0;
}

function function_bd17be25cfad86e9(requestid, var_fb1f0791e48de42f) {
  function_7a909542ec2137e8(var_fb1f0791e48de42f);
  function_4d14ffe3de9d260();
  function_304cca78b50db95e(requestid);

  if(level.var_cb5f8f4fc42b719d != "") {
    return 1;
  }

  return 0;
}

function function_304cca78b50db95e(requestid) {
  var_c41c68016bae873b = 8 + level.players.size * 5;

  while(true) {
    requestdata = function_9a39e23c3c52c2af(requestid);

    if(isDefined(requestdata.ai) && requestdata.ai.size < var_c41c68016bae873b) {
      return;
    }

    wait 1;
  }
}

function function_4d14ffe3de9d260() {
  if(flag("flag_scatter_oops_obj_oop_a") || flag("flag_scatter_oops_obj_oop_c")) {
    if(flag("flag_oop_descattered")) {
      return;
    }

    wait 3.5;
  }
}

function function_1a22e40c13b90fa5(requestid, userdata) {
  if(level.var_cb5f8f4fc42b719d != "") {
    return 0;
  }

  return 1;
}

function function_86c4d32f8fee3112(requestid, obelisk, zombie, ai_data) {
  zombie function_65cdab0fc78aba8f(obelisk.origin, 2000);
  closest_player = getclosest(zombie.origin, level.players);

  if(isDefined(closest_player) && isalive(closest_player)) {
    zombie aieventlistenerevent("combat", closest_player, closest_player.origin);
  }
}

function function_57f2664603e2929d(requestid, obelisk, zombie, ai_data) {
  zombie function_65cdab0fc78aba8f(obelisk.origin, 2000);
  closest_player = getclosest(zombie.origin, level.players);

  if(isDefined(closest_player) && isalive(closest_player)) {
    zombie aieventlistenerevent("combat", closest_player, closest_player.origin);
  }
}

function function_eb61335ebfe75646(label, offset) {
  self endon("death");

  if(!isDefined(offset)) {
    offset = (0, 0, 60);
  }

  while(true) {
    print3d(self.origin + offset, label, undefined, undefined, 1, 5);

    wait 0.25;
  }
}

function function_f4be077d820e4b3e(var_c65927633c43b8e3) {
  flag_clear("flag_cleanse_in_process");
  level.oops[level.var_cb5f8f4fc42b719d].completed = 1;
  level.var_b0c7a2042f2d7b4e++;
  self.currstate = "QUEST_0_RIFT_S5_05_OOP_CLEANSE_COMPLETE";
  level.scattered_oops = 0;
  level.oops[level.var_cb5f8f4fc42b719d].var_deff4278a4e37a2.top setscriptablepartstate("body", "destroyed");
  level.oops[level.var_cb5f8f4fc42b719d].var_deff4278a4e37a2 setscriptablepartstate("body", "spawned");
  level.var_124a97246dee96a setscriptablepartstate("body", "done");
  level callback::remove("on_ai_killed", &function_8a8357692e12f30e);
  level callback::remove("player_laststand", &function_4dc9c1ddcacd045f);
  earthquake(0.7, 1.5, self.origin, 1500);

  foreach(player in level.players) {
    player thread screen_flash(0.1, 0.5);
  }

  level.var_124a97246dee96a setscriptablepartstate("body", "done");
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_win");
  explosionzombies = getaiarrayinradius(var_c65927633c43b8e3, 3000, "team_two_hundred");

  foreach(zombie in explosionzombies) {
    if(isalive(zombie)) {
      zombie function_3ab9164ef76940fd("obelisk_vfx", "off");
      zombie kill();
      corpse = zombie getcorpseentity();

      if(isDefined(corpse)) {
        var_a33d2a2c3ffecb81 = corpse.origin - var_c65927633c43b8e3 + (0, 0, 60);
        var_83fd98f3ac829176 = max(500 - distance2d(corpse.origin, var_c65927633c43b8e3), 0) / 4;
        corpse startragdollfromimpact("torso_upper", var_a33d2a2c3ffecb81 * var_83fd98f3ac829176);
      }
    }
  }

  foreach(player in level.players) {
    player setclientomnvar("ui_br_objective_param", level.var_9f6a3aeb68ae417e);
    player scripts\ob\points::function_b5b4f530f1c579aa(2000);
  }

  foreach(var_4386bf1b36f9a5e2 in level.oops[level.var_cb5f8f4fc42b719d].oop_models) {
    playFX(level._effect["oop_destroyed"], var_4386bf1b36f9a5e2.origin);
    playsoundatpos(self.origin, "evt_ob_story_relic_cleanse_success");
    var_4386bf1b36f9a5e2 delete();
  }

  function_ce8df710ea488f1a(level.var_cb5f8f4fc42b719d);
  level.var_6c74c58b7bf75f9e[level.var_cb5f8f4fc42b719d] = gettime();
  level thread function_4fa48b2d857c3f34(level.var_cb5f8f4fc42b719d, self.origin);
  level notify("ava_stop_cleanse");
  var_580a0e2b94a5a8c6 = is_equal(level.var_cb5f8f4fc42b719d, "obj_oop_a") ? "obj_oop_c" : "obj_oop_a";
  function_c81dd1f4978cba01(var_580a0e2b94a5a8c6);
  level.var_2ada333c838a2316 thread namespace_bc50cc28d0217818::function_101b97bce06bef4();
  level.var_1da22412ed7ad03b thread namespace_bc50cc28d0217818::function_101b97bce06bef4();
  level.var_cb5f8f4fc42b719d = "";
  level.var_fe48d87019665c36 = 0;
  level.var_9f6a3aeb68ae417e++;
  level notify("oop_batch_cleansed");

  if(!flag("flag_first_oop_completed")) {
    flag_wait("flag_first_oop_completed");
    flag_set("flag_post_cleanse_vo_running");
    wait 34;
    function_14d6cbc28972404c();
    wait 2.5;
    flag_clear("flag_post_cleanse_vo_running");
    function_8c2bc6fb9a4afe0f();
    return;
  }

  flag_wait("oops_destroyed_complete");
  flag_set("flag_post_cleanse_vo_running");
  wait 28;
  function_14d6cbc28972404c();
  wait 2;
  flag_clear("flag_post_cleanse_vo_running");
  function_8c2bc6fb9a4afe0f();
}

function function_4fa48b2d857c3f34(site_name, pos) {
  function_606642b946a01237("oop_completed_" + site_name, pos, 1500, 1);
  wait 30;
  function_c7311cb3f768f21e("oop_completed_" + site_name);
}

function function_bf8e74e327ba6f46(site_name, pos) {
  function_606642b946a01237("oop_in_progress_" + site_name, pos, 1500, 0);
  flag_wait("flag_batch_cleansed_" + site_name);
  function_c7311cb3f768f21e("oop_in_progress_" + site_name);
}

function function_ce8df710ea488f1a(pedestal) {
  flag_set("flag_batch_cleansed_" + pedestal);
  level utility::delaythread(5, &utility::flag_set, "flag_batch_cleansed_5_" + pedestal);
  level utility::delaythread(10, &utility::flag_set, "flag_batch_cleansed_10_" + pedestal);
}

function function_9272bde289071a5e(params) {
  if(isPlayer(self)) {
    namespace_838b439602b3acc7::function_f10f600ac4ee4c09("s5_mi_escape_rift", 3);
    namespace_838b439602b3acc7::function_f10f600ac4ee4c09("s5_rift_mission_complete", 3);
    function_b8b15f7f0820954e([self]);
  }
}

function play_outro_movie(params) {
  var_7848ff3f98ef4a73 = 0;
  var_8c6c2faac72ea626 = 10;
  videoname = "jup_ob_s5_outro";
  videoduration = 106;
  var_1bab87417f147c8f = 0;
  self setplayermusicstate("");
  self setsoundsubmix("jup_ob_endgame");
  self setsoundsubmix("jup_ob_s5_rift_mission_outro_cinematic");
  self clearsoundsubmix("jup_ob_global_s5_5_story");
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0);
  thread scripts\common\utility::letterbox_enable(1);
  level.battlechatterdisabled = 1;
  self setclientomnvar("ui_br_bink_overlay_state", var_8c6c2faac72ea626);
  utility::hidehudenable();
  waitframe();
  self playcinematicforplayer(videoname, 1, var_1bab87417f147c8f);
  wait videoduration;
  self stopcinematicforplayer();
  self setclientomnvar("ui_br_bink_overlay_state", var_7848ff3f98ef4a73);
  self clearsoundsubmix("jup_ob_s5_rift_mission_outro_cinematic");
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
  level thread namespace_134d54e39331ee45::function_bf01aba31e9023d1(0, [self]);
}

function function_a5b76e0f5024cc9a(s_spot, str_notify, n_radius, b_endonnotify, str_endon, var_767372a33fdf060f, var_eb0972d6df2380ff) {
  level endon("game_ended");

  if(istrue(b_endonnotify)) {
    if(isDefined(str_endon)) {
      level endon(str_endon);
    } else {
      level endon(str_notify);
    }
  }

  var_eb0972d6df2380ff = isDefined(var_eb0972d6df2380ff) ? var_eb0972d6df2380ff : 0;

  if(!istrue(var_eb0972d6df2380ff)) {
    level flag_init(str_notify);
  }

  if(!isDefined(n_radius)) {
    n_dist = squared(int(s_spot.radius * 0.7));
  } else {
    n_dist = squared(n_radius);
  }

  while(true) {
    if(isDefined(level.players)) {
      foreach(player in level.players) {
        if(distancesquared(s_spot.origin, player.origin) < n_dist) {
          if(istrue(var_eb0972d6df2380ff)) {
            s_spot notify(str_notify);
          } else {
            level flag_set(str_notify);
            level notify(str_notify);
          }

          if(istrue(var_767372a33fdf060f)) {
            objective_playermask_hidefromall(level.objids[s_spot.script_noteworthy]);
          }

          return;
        }
      }
    }

    wait 0.1;
  }
}

function function_1b44e23d17799600(value) {
  foreach(player in level.players) {
    player setclientomnvar("ui_br_objective_param", value);
  }
}

function function_9306d91e52ec93e1(currentmission) {
  namespace_262d6474998a2356::function_641bc1548cff8210(currentmission, level.players);

  foreach(player in level.players) {
    player setclientomnvar("ui_ob_active_contract_region_difficulty", 0);
  }
}

function function_e2960cff868956e4(requestid, var_fb1f0791e48de42f) {
  function_7a909542ec2137e8(var_fb1f0791e48de42f);

  if(utility::flag("flag_rooftop_encounter_complete")) {
    return 0;
  }

  return 1;
}

function function_da1d63d92aa8ad62(requestid, userdata) {
  if(utility::flag("flag_used_tear_leave_roof")) {
    return 1;
  }

  return 0;
}

function function_1f53baa6caeaa3e0(requestid, instance, agent, ai_data) {
  agent function_65cdab0fc78aba8f(agent.origin, getdvarint(@ "hash_436fc10ebca82d41", 2048));
}

function function_707ec5fb66349d20() {
  level endon("game_ended");
  trigger_rooftop = getEnt("trigger_rootop", "targetname");

  while(isDefined(trigger_rooftop)) {
    trigger_rooftop waittill("trigger", player);

    if(isPlayer(player)) {
      thread function_9a0674508b5dd324();
      thread encounter_rooftop();
      return;
    }
  }
}

function function_9a0674508b5dd324() {
  if(isDefined(level.var_fc4bb27a820f54dd.var_5715be6ca445d02e[0])) {
    level.var_fc4bb27a820f54dd.var_5715be6ca445d02e[0] redeploy_drone_relocate();
  }
}

function encounter_rooftop() {
  var_8c0312cc8f37b5be = getStruct("rooftop_enc_loc", "targetname");
  level thread function_ca5acc6a996bf6b8();
  var_85fb26e17019fd3b = ai_spawn_director::spawn_request("ai_encounter:s5_rift_sm_tower_top_01", var_8c0312cc8f37b5be.origin, 800, 1, 0);
  function_e4a67fe4ddca7ed5(var_85fb26e17019fd3b, &function_1f53baa6caeaa3e0, self);
  function_fc38783a3da0bc71(var_85fb26e17019fd3b, 1);
  level utility::delaythread(60, &utility::flag_set, "flag_rooftop_encounter_complete");
  var_532064b1a0b460cf = spawn_request("ai_flood_fill_encounter:s5_rift_sm_tower_top_01", var_8c0312cc8f37b5be.origin, 800, 1, 1, 0);
  function_bc5315dc37ae4cf(var_532064b1a0b460cf, &function_e2960cff868956e4, level.var_9f6a3aeb68ae417e);
  function_73147cdf5c28d10c(var_532064b1a0b460cf, &function_da1d63d92aa8ad62, self);
  function_e4a67fe4ddca7ed5(var_532064b1a0b460cf, &function_1f53baa6caeaa3e0, self);
}

function function_ca5acc6a996bf6b8() {
  flag_wait_or_timeout("flag_ascent_rooftop", 10);
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_action_loop");
  flag_wait_any("flag_rooftop_encounter_complete", "flag_used_tear_leave_roof");

  if(flag("flag_rooftop_encounter_complete")) {
    wait 5;
  }

  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_win");
}

function function_45d64dc00d240bc7() {
  level endon("game_ended");
  above_tower_trigger = getEnt("above_tower_trigger", "targetname");
  thread function_d1fdfd8f4cf74e50("flag_above_tower_tear", above_tower_trigger);
}

function function_c77d44a1143ba279() {
  level endon("game_ended");
  trigger_boat_01 = getEnt("trigger_boat_01", "targetname");

  while(isDefined(trigger_boat_01)) {
    trigger_boat_01 waittill("trigger", player);

    if(isPlayer(player)) {
      thread scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Reach_Boat", level.players, 1);
      thread spawn_encounter("floating_boat_ent_01", "ai_encounter:s5_rift_sm_above_tower_boat_01", 600);
      thread spawn_encounter("floating_boat_ent", "ai_encounter:s5_rift_sm_above_tower_boat", 600);
      beat03_boat_dest = getStruct("beat03_boat_dest", "targetname");
      thread function_86ebb4a3b1ed6ba0(beat03_boat_dest);
      return;
    }
  }
}

function spawn_encounter(targetname, var_2eb33feb1aba5335, radius) {
  ent = getStruct(targetname, "targetname");
  encounterid = ai_spawn_director::spawn_request(var_2eb33feb1aba5335, ent.origin, radius, 1, 0);
  function_fc38783a3da0bc71(encounterid, 1);
}

function function_bd16e498b5cf2201() {
  level endon("game_ended");
  var_9ac8c7b7ddc3290f = getEnt("above_tower_trigger", "targetname");

  while(isDefined(var_9ac8c7b7ddc3290f)) {
    var_9ac8c7b7ddc3290f waittill("trigger", player);

    if(isPlayer(player)) {
      thread spawn_encounter("above_tower_ent", "ai_encounter:s5_rift_sm_above_tower_01", 600);
      return;
    }
  }
}

function function_f4e60acce5eadb1() {
  level endon("game_ended");
  var_27b0d7e04e0a1673 = getEnt("above_tower_trigger_1", "targetname");

  while(isDefined(var_27b0d7e04e0a1673)) {
    var_27b0d7e04e0a1673 waittill("trigger", player);

    if(isPlayer(player)) {
      thread spawn_encounter("above_tower_1_ent", "ai_encounter:s5_rift_sm_above_tower_01", 800);
      thread spawn_encounter("above_tower_1_5_ent", "ai_encounter:s5_rift_sm_above_tower_01", 600);
      combat_platform_1 = getStruct("combat_platform_1", "targetname");
      thread function_86ebb4a3b1ed6ba0(combat_platform_1);
      thread function_d1fdfd8f4cf74e50("flag_above_tower_tear_1_5", var_27b0d7e04e0a1673);
      beat03_essence_01 = getStruct("beat03_essence_01", "targetname");
      beat03_essence_02 = getStruct("beat03_essence_02", "targetname");
      thread function_f050791ced405c63(beat03_essence_01.origin, beat03_essence_01.angles, "ob_jup_item_essence_large_aethertear");
      thread function_f050791ced405c63(beat03_essence_02.origin, beat03_essence_02.angles, "ob_jup_item_essence_large_aethertear");
      return;
    }
  }
}

function function_4a07014c82ce2592() {
  flag_wait("ob_systems_init_complete");
  wait 0.5;
  thread function_e960de459a268eae("beat03_essence_03", (25, 0, -17));
  thread function_e960de459a268eae("beat03_essence_04", (25, 0, -17));
}

function function_e960de459a268eae(var_150a8b490598f190, offset) {
  var_72c0ab7eb6f49cbf = getStruct(var_150a8b490598f190, "targetname");
  var_93e36c64077a33b1 = function_f050791ced405c63(var_72c0ab7eb6f49cbf.origin, var_72c0ab7eb6f49cbf.angles, "ob_jup_item_essence_large_aethertear");
  var_df8e0d75a72c89c6 = gettime();

  if(isDefined(var_93e36c64077a33b1)) {
    while(!isDefined(var_93e36c64077a33b1.linkedparent)) {
      if(time_has_passed(var_df8e0d75a72c89c6, 5)) {
        return;
      }

      waitframe();
    }

    linkedparent = var_93e36c64077a33b1.linkedparent;
    var_93e36c64077a33b1 scriptable_clearparententity();
    waitframe();
    var_93e36c64077a33b1 scriptable_setparententity(linkedparent, offset);
  }
}

function function_e827910e4184af29() {
  level endon("game_ended");
  var_4565484f55b5fe3e = getEnt("above_tower_trigger_bus", "targetname");

  while(isDefined(var_4565484f55b5fe3e)) {
    var_4565484f55b5fe3e waittill("trigger", player);

    if(isPlayer(player)) {
      beat03_crashtruck_dest = getStruct("beat03_crashtruck_dest", "targetname");
      thread function_86ebb4a3b1ed6ba0(beat03_crashtruck_dest);
      thread function_d1fdfd8f4cf74e50("flag_above_tower_tear_3", var_4565484f55b5fe3e);
      return;
    }
  }
}

function function_f4e5dacce5ea718() {
  level endon("game_ended");
  var_c3def5181cbf46f8 = getEnt("above_tower_trigger_bus_encounter", "targetname");

  while(isDefined(var_c3def5181cbf46f8)) {
    var_c3def5181cbf46f8 waittill("trigger", player);

    if(isPlayer(player)) {
      thread spawn_encounter("above_tower_2_ent", "ai_encounter:s5_rift_sm_above_tower_01", 600);
      thread spawn_encounter("above_tower_2_5_ent", "ai_encounter:s5_rift_sm_above_tower_01", 600);
      return;
    }
  }
}

function function_e829bc74f676e38f() {
  level endon("game_ended");
  var_52fdde4b9f126207 = getEnt("above_tower_trigger_vo", "targetname");
  thread function_d1fdfd8f4cf74e50("flag_above_tower_tear_2", var_52fdde4b9f126207);

  while(isDefined(var_52fdde4b9f126207)) {
    var_52fdde4b9f126207 waittill("trigger", player);

    if(isPlayer(player)) {
      level function_ef89cf4181d076e7("STY_S5_5_STM_Mid_Climb_Narrative_Beat_Line_1", level.players);
      level function_ef89cf4181d076e7("STY_S5_5_STM_Mid_Climb_Narrative_Beat_Line_2", level.players);
      level function_ef89cf4181d076e7("STY_S5_5_STM_Mid_Climb_Narrative_Beat_Line_3", level.players);
      level function_ef89cf4181d076e7("STY_S5_5_STM_Mid_Climb_Narrative_Beat_Line_4", level.players, undefined, undefined, 0);
      level function_ef89cf4181d076e7("STY_S5_5_STM_Mid_Climb_Narrative_Beat_Line_5", level.players, 7);
      beat03_busstop_dest = getStruct("beat03_busstop_dest", "targetname");
      thread function_86ebb4a3b1ed6ba0(beat03_busstop_dest);
      return;
    }
  }
}

function function_f4e5eacce5ea94b() {
  level endon("game_ended");
  var_5f384f635dc43163 = getEnt("above_tower_trigger_trains", "targetname");

  while(isDefined(var_5f384f635dc43163)) {
    var_5f384f635dc43163 waittill("trigger", player);

    if(isPlayer(player)) {
      thread spawn_encounter("above_tower_3_ent", "ai_encounter:s5_rift_sm_above_tower_01", 600);
      thread spawn_encounter("above_tower_4_ent", "ai_encounter:s5_rift_sm_above_tower_01", 600);
      beat03_train_dest = getStruct("beat03_train_dest", "targetname");
      thread function_86ebb4a3b1ed6ba0(beat03_train_dest);
      return;
    }
  }
}

function function_f4e63acce5eb44a() {
  level endon("game_ended");
  above_tower_trigger_last_jump = getEnt("above_tower_trigger_last_jump", "targetname");

  while(isDefined(above_tower_trigger_last_jump)) {
    above_tower_trigger_last_jump waittill("trigger", player);

    if(isPlayer(player)) {
      var_feb2e56495dcad32 = getStruct("beat03_train_dest_2", "targetname");
      thread function_86ebb4a3b1ed6ba0(var_feb2e56495dcad32);
      return;
    }
  }
}

function function_3dc0d275245edd26() {
  level endon("game_ended");
  trigger_boat_vo_2 = getEnt("trigger_boat_vo_2", "targetname");

  while(isDefined(trigger_boat_vo_2)) {
    trigger_boat_vo_2 waittill("trigger", player);

    if(isPlayer(player)) {
      thread scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Reach_Boat_End", level.players);
      return;
    }
  }
}

function function_86ebb4a3b1ed6ba0(new_dest) {
  foreach(tear in level.var_86f0e49ba2870e8) {
    if(!isDefined(tear.script_label)) {
      continue;
    }

    if(is_equal(tear.script_label, "updated_tear")) {
      tear thread namespace_90dd012499e066d0::function_a420b9a5eebf5dea(new_dest);
    }
  }
}

function function_e40f7d0537ba1619(agent) {
  if(getdvarint(@ "hash_b5024b31d9ec2722", 0)) {
    iprintlnbold("<dev string:x24a>");
  }

  agent scripts\common\callbacks::add("on_zombie_ai_killed", &function_4d7d39a9cbb5a518);
  thread function_2850fff68d1d6a1(agent);
  agent callback::add("entity_boss_lightbomb_completed", &function_1038d45b2714cc18);
  agent callback::add("entity_boss_throw_lightbomb", &function_4686f2fe02c73a0f);
  agent function_a1005e06a26908ab();
  agent thread[[level.var_f057eaa585cd99c5]]();
  agent function_e06c1d2f2d469475();
  agent function_62875d682dbc5c41();
  agent function_b7d9a5de8b7cbdcd();
  flag_set("entity_spawned");
}

function function_1b0c9b733beed84e(agent) {
  level endon("game_ended");
  agent function_59467b7569ee98ab();
  function_9b8829ab4092a7d7("ob_rift_story_s5_boss", 0);

  if(isDefined(level.boss_phase) && level.boss_phase == 0) {
    level.boss_phase = 99;
    flag_set("entity_death_begin_phase_01");
    flag_clear("entity_spawned");
    level thread function_8c311ae5db764f09();
  }

  if(level.boss_phase == 1) {
    flag_set("entity_death_begin_phase_02");
    agent ent_flag_set("death_begin_phase_02");
    function_1ef7a5d5735e50c();
    function_629b56ecce32d438();
    function_9b8829ab4092a7d7("ob_rift_story_s5_boss_elites", 0);
    level thread function_f87d2361a137fa8a();
    function_b8b15f7f0820954e(level.players);
    objective_playermask_hidefromall(level.objids["obj_destroy_entity"]);
  }

  wait 3;
  level scripts\engine\utility::callsharedfunc("zombie_entity", "KillAllZombies", agent);

  if(level.boss_phase == 1) {
    flag_set("phase_02_zombies_killed");
  }

  if(isDefined(level.boss_phase) && level.boss_phase == 99) {
    flag_set("entity_phase_01_complete");

    while(flag("killing_all_ai")) {
      wait 1;
    }

    level scripts\engine\utility::callsharedfunc("zombie_entity", "KillAllZombies", agent);
    function_820ae10ff17d59f0();
    return;
  }

  function_3b61dc2fc60b81d7();
}

function function_2b055ea4632476d7() {
  level endon("game_ended");
  flag_set("entity_defeated_add_time");
  wait 3;
  thread function_c65d67cfdb263e10(1);
  rewardstruct = getStruct("beat_04_reward_rift", "targetname");

  if(!isDefined(rewardstruct)) {
    rewardstruct = getStruct("obj_fake_rift_reward", "script_noteworthy");
  }

  if(isDefined(rewardstruct)) {
    reward_placement = namespace_71ca15b739deab72::function_3ae7f99339b96499(rewardstruct.origin);
    a_players = level.players[0] scripts\cp_mp\utility\squad_utility::getsquadmembers();
    var_3c99a2a84c4b850f = spawnStruct();
    reward_groups = [];

    foreach(player in a_players) {
      reward_groups[reward_groups.size] = [player];
    }

    namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(reward_groups, reward_placement, &function_39a5c73dfdb025dc, undefined, var_3c99a2a84c4b850f);
    playrumbleonposition("artillery_rumble", level.fake_reward_rift.origin);
    var_3c99a2a84c4b850f waittill("managed_reward_cache_spawn_done", var_e10194ca6271ac0a);
    function_9306d91e52ec93e1("QUEST_0_RIFT_S5_08_LOOT_RIFT");
    var_e10194ca6271ac0a waittill("managed_reward_cache_despawned");
  } else {
    println("<dev string:x266>");
  }

  flag_set("entity_defeated");
  level.entity_boss scripts\common\callbacks::remove("on_zombie_ai_killed", &function_4d7d39a9cbb5a518);
}

function function_2850fff68d1d6a1(agent) {
  level endon("game_ended");
  agent endon("death");
  agent waittill("fake_death");
  thread function_1b0c9b733beed84e(agent);
}

function function_4d7d39a9cbb5a518(data) {
  if(isDefined(level.boss_phase) && level.boss_phase == 99) {
    return;
  }

  thread function_2b055ea4632476d7();
}

function function_1038d45b2714cc18(params) {
  foreach(player in level.players) {
    player setclientomnvar("ui_br_objective_param", level.var_31cfa03a7e864f49);
    player scripts\ob\points::function_b5b4f530f1c579aa(2000);
  }

  function_b8b15f7f0820954e(level.players);
}

function function_4686f2fe02c73a0f(params) {
  function_9306d91e52ec93e1("QUEST_0_RIFT_S5_07_BOSS_VULNERABLE");
  objective_playermask_hidefromall(level.objids[level.var_ad5d9c2f5d7df9b9.script_noteworthy]);

  if(level.var_31cfa03a7e864f49 == 1) {
    wait 1.5;
    level thread function_ef89cf4181d076e7("STY_S5_5_STM_Entity_Vulnerable_Again", level.players);
  }
}

function function_24aa2c5257ab8f56(params) {
  flag_set("phase_02_teleport_done");
}

function function_c65d67cfdb263e10(numseconds) {
  level endon("game_ended");
  level function_ee2a20015e37d3ec("STY_S5_5_STM_Entity_Defeated", level.players);
  flag_set("entity_defeated_vo_done");
  wait numseconds;
  flag_set("entity_defeated");
}

function function_39a5c73dfdb025dc(var_f7f66a8bcca0ac73) {
  cache = spawnStruct();
  items = function_bc2f4857c90f5344("ob_jup_item_reward_peeks_s5", 1);
  common_cache::function_fd95ef820bb2b980(items, cache);
  return cache.contents;
}

function private function_b7d9a5de8b7cbdcd() {
  for(var_771164f849f397a0 = 0; var_771164f849f397a0 < 8; var_771164f849f397a0++) {
    var_49231a100a994ca9 = undefined;

    switch (var_771164f849f397a0) {
      case 0:
        var_49231a100a994ca9 = "beat_04_lightning_main";
        break;
      case 1:
        var_49231a100a994ca9 = "beat_04_lightning_sml_01";
        break;
      case 2:
        var_49231a100a994ca9 = "beat_04_lightning_sml_02";
        break;
      case 3:
        var_49231a100a994ca9 = "beat_04_lightning_sml_03";
        break;
      case 4:
        var_49231a100a994ca9 = "beat_04_lightning_sml_04";
        break;
      case 5:
        var_49231a100a994ca9 = "beat_04_lightning_med_01";
        break;
      case 6:
        var_49231a100a994ca9 = "beat_04_lightning_med_02";
        break;
      case 7:
        var_49231a100a994ca9 = "beat_04_lightning_med_03";
        break;
    }

    scripts\engine\utility::callsharedfunc("zombie_entity", "AddIslandLocationsFromStructString", var_49231a100a994ca9);
  }
}

function private function_e06c1d2f2d469475() {
  for(var_65c64854f86704de = 1; var_65c64854f86704de <= 4; var_65c64854f86704de++) {
    scripts\engine\utility::callsharedfunc("zombie_entity", "AddTeleportLocationsFromStructString", 0, "beat_04_entityloc_phase_01_0" + var_65c64854f86704de);
  }

  spawnloc = level.var_e859e3e2283ccd72["obj_destroy_entity"];

  if(isDefined(spawnloc)) {
    scripts\engine\utility::callsharedfunc("zombie_entity", "AddTeleportLocationsFromStruct", 0, spawnloc);
  }

  for(var_65c64854f86704de = 1; var_65c64854f86704de <= 4; var_65c64854f86704de++) {
    scripts\engine\utility::callsharedfunc("zombie_entity", "AddTeleportLocationsFromStructString", 1, "beat_04_entityloc_phase_02_0" + var_65c64854f86704de);
  }
}

function private function_62875d682dbc5c41() {
  scripts\engine\utility::callsharedfunc("zombie_entity", "SetupOrbSpawns", "beat_04_entity_orb_0", 4);
}

function function_d6a9fd29b3865dff() {
  level endon("game_ended");
  var_876b5d6d49fdafde = getStruct("beat_04_ravenov_exfil_wait", "targetname");
  var_cc8d70526ccf32a7 = getStruct("beat_04_jansen_exfil_tele", "targetname");
  namespace_60bff5112336ce6::ava_spawn();
  flag_wait("flag_ava_follower_spawned");
  thread function_80a2e9e17acc0cde();
  actors = level.var_2ada333c838a2316;
  animnode = getStruct("beat_04_jansen_exfil_animnode", "targetname");
  waitframe();

  if(getdvarint(@ "hash_2b40f1de479f089b", 0) == 1) {
    thread function_a5b76e0f5024cc9a(animnode, "<dev string:x2b1>", 512, undefined, undefined, undefined, 0);
    level waittill("<dev string:x2b1>");
  }

  waitframe();
  waittillframeend();
  level.var_1da22412ed7ad03b thread namespace_60bff5112336ce6::function_a4f2de37b22bd9f9(var_876b5d6d49fdafde.origin, 1);
  animnode scene::play(actors, "shot_030", "jup_ob_s5_story_exfil_gate_scenebundle");
  animnode scene::play(actors, "shot_010", "jup_ob_s5_story_exfil_gate_scenebundle");
  animnode thread scene::play(actors, "shot_020", "jup_ob_s5_story_exfil_gate_scenebundle");
  wait 1.5;
  flag_set("exfil_ready");
  level waittill("geme_ended");
}

function function_533099706980bfb3() {
  s_exit = level.var_e859e3e2283ccd72["obj_leave"];

  if(!isDefined(s_exit)) {
    return;
  }

  var_d0809b7599d6c0c3 = spawnscriptable("s2_ob_jup_scriptable_rift_gate_vortex", s_exit.origin, s_exit.angles);
  earthquake(0.3, 10, s_exit.origin, 30000);
  thread function_2ca0ca4159d9fce2();
  var_d0809b7599d6c0c3 setscriptablepartstate("vortex", "on");
  wait 3;
  var_d0809b7599d6c0c3 setscriptablepartstate("vortex", "off");
  var_e759223f74ab2a4e = spawnscriptable("s2_ob_jup_scriptable_rift_portal_formation", s_exit.origin, s_exit.angles);
  var_e759223f74ab2a4e setscriptablepartstate("formation_vfx", "active");
  thread function_257aadb427cb61e5(s_exit);
  wait 8.5;
  gate_model = scripts\cp_mp\content_manager::spawn_script_model(s_exit, "jup_zm_rift_portal_small", 1, 1);
  level.riftgate = gate_model;

  if(isDefined(gate_model)) {
    gate_model.targetname = "dark_aether_exit";
    level.riftgate setscriptablepartstate("aether_exit_body", "rift_mission_exit");
  }

  thread function_5f684837e5288b1e(s_exit.origin, 2000);
  wait 2;
  var_e759223f74ab2a4e setscriptablepartstate("formation_vfx", "off");
  level notify("gate_spawned");
  function_5314ee75857e6c63(level.riftgate);
}

function function_e4b41f1afb7f3992() {
  level endon("game_ended");
  wait 0.5;
  var_d42ab97775d5c9ff = getStruct("beat_04_ravenov_end", "targetname");
  level.var_1da22412ed7ad03b setgoalpos(var_d42ab97775d5c9ff.origin, 25);
  level.var_1da22412ed7ad03b waittill("goal");
  playFXOnTag(getfx("rift_teleport"), level.var_1da22412ed7ad03b, "tag_origin");
  wait 1;
  stopFXOnTag(getfx("rift_teleport"), level.var_1da22412ed7ad03b, "tag_origin");
  level.var_1da22412ed7ad03b function_9f44d0edaa30d584();
  level.var_1da22412ed7ad03b = undefined;
}

function private function_5f684837e5288b1e(location, radius) {
  level endon("game_ended");
  waitframe();
  explosionzombies = getaiarrayinradius(location, radius, "team_two_hundred");
  playFX(level._effect["zombie_explosion"], location);

  foreach(zombie in explosionzombies) {
    if(isalive(zombie)) {
      zombie.marked_for_death = 1;
      zombie.nuked = 1;
      zombie.full_gib = 1;
      zombie.var_745cd904c1ec804c = 1;
      zombie kill();
    }
  }
}

function function_5314ee75857e6c63(gate_model) {
  level.riftgate setscriptablepartstate("aether_exit_body", "rift_mission_exit");
  gate_model.gate_interact = scripts\cp_mp\interaction::register_interact(gate_model.origin + (0, 0, 48), 150, &function_5927fdb24018f9c7);
  gate_model.gate_interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_5aa40913d9085c11);
  gate_model.gate_interact sethintonobstruction("hide");
}

function function_5aa40913d9085c11(interact, player) {
  return {
    #string: &"JUP_OB_S1/RIFT_EXIT", #type: "HINT_BUTTON"};
}

function function_5927fdb24018f9c7(player) {
  foreach(spectator in level.players) {
    spectatingplayer = spectator getspectatingplayer();

    if(isDefined(spectatingplayer)) {
      if(spectatingplayer == player) {
        if(!istrue(spectator.var_f52eb40ba99ffa4c)) {
          thread function_b67447cfa15eb9e6(spectator);
        }
      }
    }
  }

  if(istrue(player.var_f52eb40ba99ffa4c)) {
    return;
  }

  thread function_b67447cfa15eb9e6(player);
  player clearsoundsubmix("jup_ob_global_s5_5_story");
}

function function_b67447cfa15eb9e6(player) {
  namespace_b000de497fab9bf4::function_b67447cfa15eb9e6(player);
}

function function_2d3c8e54c205caed() {
  self endon("death");
  level endon("game_ended");
  level notify("ava_finished_exfil_path");
  wait 3;
  self notify("release");
  s_goal = getStruct("ai_exfil_point", "targetname");
  self setgoalpos(s_goal.origin, 25);
  self waittill("goal");
  playFXOnTag(getfx("rift_teleport"), self, "tag_origin");
  wait 1;
  stopFXOnTag(getfx("rift_teleport"), self, "tag_origin");
  level notify("jansen_exited");
  function_5314ee75857e6c63(level.riftgate);
  function_9306d91e52ec93e1("MISSION_OBJ_ESCAPE_RIFT");
  function_e3e2805312bb39c0();
}

function function_e3e2805312bb39c0() {
  self.nocorpse = 1;
  self.var_7e4b076a06c6df27 = 1;
  self.dropweapon = 0;
  self.damageshield = 0;
  self.var_d8a098b0872bb2cb = 0;

  if(istrue(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  scripts\cp_mp\agents\agent_utils::function_7056963336f2bbec(1);
}

function function_66440c7162256b6() {
  self endon("death");
  level endon("game_ended");
  level.var_1da22412ed7ad03b setgoalpos(level.var_1da22412ed7ad03b.origin, 25);
  level waittill("jansen_exited");
  wait 2;
  var_d42ab97775d5c9ff = getStruct("ai_exfil_point", "targetname");
  level.var_1da22412ed7ad03b setgoalpos(var_d42ab97775d5c9ff.origin, 25);
  self.var_1da22412ed7ad03b waittill("goal");
  playFXOnTag(getfx("rift_teleport"), self.var_1da22412ed7ad03b, "tag_origin");
  wait 1;
  stopFXOnTag(getfx("rift_teleport"), self.var_1da22412ed7ad03b, "tag_origin");
  self.var_1da22412ed7ad03b function_e3e2805312bb39c0();
}

function function_9f909024d825be2c() {
  flag_wait("common_items_init");
  var_29a3db0499a2874 = array_randomize(getStructArray("ob_locked_space_loot", "targetname"));

  foreach(loot_spawn in var_29a3db0499a2874) {
    scripts\cp_mp\loot\common_item::function_cd45408bd44fab07("ob_jup_items_rift_run_locked_spaces_loot", 1, loot_spawn.origin, loot_spawn.angles + (0, 90, 0), 1, 1);
  }
}

function function_550e38b033de778e() {
  flag_wait("common_items_init");
  var_4bd4a641e714664d = getStructArray("ob_locked_space_key", "targetname");

  foreach(key_spawn in var_4bd4a641e714664d) {
    itembundle = getscriptbundle("itemspawnentry:" + key_spawn.script_noteworthy);

    if(isDefined(itembundle)) {
      scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, key_spawn.origin, key_spawn.angles, 1, 1);
    }
  }
}

function function_7f47a9126611e1cf() {
  level flag_wait("ob_infil_completed");
  level flag_wait("drop_powerups");
  var_f6e2fa7c17f84498 = getStructArray("ob_locked_space_powerup", "targetname");
  offset = (0, 0, scripts\common\powerups::function_edeba0070ca0709e("drop_height_offset"));

  foreach(powerup_spawn in var_f6e2fa7c17f84498) {
    if(isDefined(powerup_spawn.script_noteworthy)) {
      level thread scripts\common\powerups::function_d4be622286a198(powerup_spawn.script_noteworthy, powerup_spawn.origin + offset, powerup_spawn.angles);
      waitframe();
    }
  }
}

function function_7a059c64e4b08632() {
  level endon("game_ended");
  level endon("reached_tower_top");
  level endon("flag_used_tear_leave_roof");
  level endon("flag_ascent_rooftop");
  flag_wait("flag_ascent_approach_tower");
  level thread scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Arrive_At_Tower", level.players);
}

function function_832d6ea58ccc05df() {
  level endon("game_ended");
  level endon("reached_tower_top");
  level endon("flag_used_tear_leave_roof");
  level endon("flag_ascend_checkpoint");
  level endon("flag_ascent_on_train");
  flag_wait("flag_ascent_hint");
  level thread scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Board_Tower_Train", level.players);
}

function function_e86cf97594766ef8() {
  level endon("game_ended");
  level endon("reached_tower_top");
  level endon("flag_used_tear_leave_roof");
  flag_wait("flag_ascent_on_train");
  wait 1;
  level thread scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Board_Tower_Train_Hint", level.players);
}

function function_f0db8f2b4f6d94e0() {
  level endon("game_ended");
  level endon("reached_tower_top");
  level endon("flag_used_tear_leave_roof");
  flag_wait("flag_ascent_spawn_lower");
  wait 4;
  level thread scripts\cp_mp\overlord::playevent("STY_S5_5_STM_Train_Ambush_Callout", level.players);
}

function function_f35000473187ae3f() {
  var_530318eca5b22024 = 19000;
  var_cc96321f03f121db = level.var_f65c4ae0507e9e5c + var_530318eca5b22024;

  if(!time_has_passed(var_cc96321f03f121db, 10)) {
    return;
  }

  level thread function_ef89cf4181d076e7("STY_S5_5_STM_Relics_Regathered", level.players);
}

function function_d383bfed46444d1a() {
  wait 2;
  level function_ef89cf4181d076e7("STY_S5_5_STM_First_Cleanse_Done_Line_1", level.players);
  level function_ef89cf4181d076e7("STY_S5_5_STM_First_Cleanse_Done_Line_2", level.players, undefined, undefined, 0);
  level function_ef89cf4181d076e7("STY_S5_5_STM_First_Cleanse_Done_Line_3", level.players, 10);
  level function_ef89cf4181d076e7("STY_S5_5_STM_First_Cleanse_Done_Line_4", level.players);
}

function function_c407f7030f3cc526() {
  level function_ef89cf4181d076e7("STY_S5_5_STM_Relic_Cleanse_Start", level.players, undefined, undefined, 0);
  level function_ef89cf4181d076e7("STY_S5_5_STM_Relic_Cleanse_Start_Response", level.players, 10);
}

function function_38f2265a5a421aca() {
  while(!isDefined(level.players) || !isDefined(level.players[0])) {
    waitframe();
  }

  wait 10;
  scripts\engine\scriptable::function_9a0a13a69553c5a5("thermal_map_interact", &function_ed66fb4422b71f2);
  randomized_numbers = array_randomize([1, 2, 3, 4, 5, 6]);
  level.rooftop_order = [randomized_numbers[0], randomized_numbers[1], randomized_numbers[2]];
  var_55a82ed8dbdde282 = getStruct("map_puzzle_topdown", "targetname");
  level.map_puzzle_topdown = spawn("script_model", var_55a82ed8dbdde282.origin);
  level.map_puzzle_topdown.angles = var_55a82ed8dbdde282.angles;
  level.map_puzzle_topdown setModel("sign_thermal_phone_big_06");
  level.map_puzzle_topdown hide();
  var_5968317d6f8d1410 = getStructArray("map_puzzle_loc", "targetname");
  level.var_6fa0bf56ee52f6c1 = [];

  foreach(loc in var_5968317d6f8d1410) {
    if(array_contains(level.rooftop_order, int(loc.script_noteworthy))) {
      cross = spawn("script_model", loc.origin);
      cross.angles = loc.angles;
      cross setModel("sign_thermal_phone_cross_01");
      cross.cross_id = loc.script_noteworthy;
      cross hide();
      level.var_6fa0bf56ee52f6c1 = array_add(level.var_6fa0bf56ee52f6c1, cross);
    }
  }

  var_2b77dd61064ee619 = getStructArray("map_puzzle_building_whiteboard", "targetname");
  hint_order = 2;

  foreach(rooftop_id in level.rooftop_order) {
    var_67831b93cf122f0 = function_fa3ababf8d33eb18(rooftop_id);
    var_e5a653b969c91ae = spawn("script_model", var_67831b93cf122f0.origin);
    var_e5a653b969c91ae.angles = var_67831b93cf122f0.angles;
    var_e5a653b969c91ae setModel("sign_thermal_phone_small_0" + hint_order);
    hint_order++;
  }

  foreach(rooftop_id in level.rooftop_order) {
    function_7f2cb2b88892fdef(rooftop_id);
  }

  var_580cdac12a8776d8 = level.rooftop_order[2];
  var_1874ed069761fd5 = function_65863cfa265fa38(var_580cdac12a8776d8);
  var_6cddaab9e8163e8a = getStructArray("map_puzzle_reward_loc", "targetname");
  map_puzzle_reward_loc = getclosest(var_1874ed069761fd5.origin, var_6cddaab9e8163e8a);
  itembundle = getscriptbundle("itemspawnentry:ob_jup_item_key_rift_run_tower_thermal_hunt");

  if(isDefined(itembundle)) {
    scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, map_puzzle_reward_loc.origin, map_puzzle_reward_loc.angles, 1, 1);
  }

  function_1ebadbfc6c99b7b3();
}

function function_1ebadbfc6c99b7b3() {
  struct_spawnloc = getStruct("bonus_weap_2", "targetname");
  level thread function_b9f2df0813f1123e(struct_spawnloc, "ob_jup_item_weapon_ar_acharlie_v5502_orange", 3, 4);
  reward_structs = getStructArray("thermal_map_item_reward", "targetname");

  foreach(reward in reward_structs) {
    itembundle = getscriptbundle("itemspawnentry:" + reward.script_noteworthy);

    if(isDefined(itembundle)) {
      scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, reward.origin, reward.angles, 1, 1);
    }
  }
}

function function_ed66fb4422b71f2(instance, part, state, player, bautouse, usestring) {
  assert(part == "<dev string:x2c4>");

  if(!function_1287364f511668d4(player)) {
    return;
  }

  instance notify("thermal_map_location_interact_used", player);
}

function function_7f2cb2b88892fdef(rooftop_id) {
  puzzle_loc = function_65863cfa265fa38(rooftop_id);
  level.thermal_interact = spawnscriptable("thermal_map_location_interact", puzzle_loc.origin + (0, 0, 0));
  level.thermal_interact setscriptablepartstate("thermal_map_interact", "enabled");

  foreach(player in level.players) {
    level.thermal_interact disablescriptableplayeruse(player);
  }

  level.thermal_interact waittill("thermal_map_location_interact_used", interact_player);

  if(is_equal(rooftop_id, level.rooftop_order[2])) {
    foreach(player in level.players) {
      player playsoundtoplayer("evt_ob_mrpeeks_stinger_activation", player, player);
      player thread screen_flash(0.8, 0.8);
    }

    wait 0.3;
    earthquake(0.6, 1.6, puzzle_loc.origin, 1500);
    thread function_5f684837e5288b1e(puzzle_loc.origin, 1500);
  } else {
    playsoundatpos(puzzle_loc.origin, "evt_zm_ob_rr_s3_5_object_pickup");
    earthquake(0.5, 0.8, puzzle_loc.origin, 1500);
    interact_player thread screen_flash(0.5, 0.5);
  }

  playFX(level._effect["oop_destroyed"], puzzle_loc.origin);

  foreach(player in level.players) {
    level.thermal_interact disablescriptableplayeruse(player);
  }

  level.thermal_interact freescriptable();
  level.thermal_interact = undefined;

  foreach(cross in level.var_6fa0bf56ee52f6c1) {
    if(is_equal(int(cross.cross_id), rooftop_id)) {
      level.var_6fa0bf56ee52f6c1 = array_remove(level.var_6fa0bf56ee52f6c1, cross);
      cross delete();
      break;
    }
  }
}

function function_65863cfa265fa38(rooftop_id) {
  var_5968317d6f8d1410 = getStructArray("map_puzzle_loc", "targetname");

  for(i = 0; i < var_5968317d6f8d1410.size; i++) {
    if(var_5968317d6f8d1410[i].script_noteworthy == "" + rooftop_id) {
      return var_5968317d6f8d1410[i];
    }
  }
}

function function_fa3ababf8d33eb18(rooftop_id) {
  var_5968317d6f8d1410 = getStructArray("map_puzzle_building_whiteboard", "targetname");

  for(i = 0; i < var_5968317d6f8d1410.size; i++) {
    if(var_5968317d6f8d1410[i].script_noteworthy == "" + rooftop_id) {
      return var_5968317d6f8d1410[i];
    }
  }
}

function function_c19eaf71246ab93() {
  while(!isDefined(level.players) || !isDefined(level.players[0])) {
    waitframe();
  }

  wait 10;
  statue_struct = getStruct("statue_look_pos", "targetname");
  winner = undefined;
  statue_base_trigger = getEnt("statue_base_trigger", "targetname");

  while(isDefined(statue_base_trigger)) {
    statue_base_trigger waittill("trigger", player);

    if(isPlayer(player) && function_e7c30095a6cdc3ef(player, statue_struct.origin, 60, undefined) && isalive(player)) {
      playFX(level._effect["zombie_explosion"], statue_struct.origin, undefined, undefined, player);
      function_4bfb71ecf68607b(1, statue_struct, player);
      results = function_ec20c7668ab0d90(player, statue_struct.origin, [statue_struct.var_97a387949d61becd, statue_struct.var_97a384949d61b834]);
      function_4bfb71ecf68607b(0, statue_struct, player);
      playFX(level._effect["powerup_grabbed"], statue_struct.origin, undefined, undefined, player);

      if(istrue(results)) {
        winner = player;
        break;
      }

      playsoundatpos(player.origin, "evt_ob_rr_bunny_flyaway");
      player thread screen_flash(0.2, 0.6, "black");
      earthquake(0.5, 0.3, player.origin, 1500);
      wait 1;
    }
  }

  winner thread screen_flash(0.8, 0.8);
  wait 0.3;
  thread function_5f684837e5288b1e(winner.origin, 1500);
  earthquake(0.6, 1.6, winner.origin, 1500);
  winner playsoundtoplayer("evt_ob_mrpeeks_stinger_activation", winner, winner);
  function_20bad519238b27c8();
}

function function_20bad519238b27c8() {
  weapon_spawnloc = getStruct("bonus_weap_1", "targetname");
  level thread function_b9f2df0813f1123e(weapon_spawnloc, "ob_jup_item_weapon_dm_slima8_v5503_orange", 3, 4);
  reward_structs = getStructArray("floating_statue_item_reward", "targetname");

  foreach(reward in reward_structs) {
    itembundle = getscriptbundle("itemspawnentry:" + reward.script_noteworthy);

    if(isDefined(itembundle)) {
      scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, reward.origin, reward.angles, 1, 1);
    }
  }
}

function function_4bfb71ecf68607b(toggle, statue_struct, player) {
  if(istrue(toggle)) {
    var_ca13ae3b86414de6 = getStructArray(statue_struct.target, "targetname");
    statue_struct.var_97a387949d61becd = spawn("script_model", var_ca13ae3b86414de6[0].origin);
    statue_struct.var_97a387949d61becd.angles = var_ca13ae3b86414de6[0].angles;
    statue_struct.var_97a387949d61becd setModel("jup_zm_powerup_vfx");
    statue_struct.var_97a387949d61becd hide();
    statue_struct.var_97a387949d61becd showtoplayer(player);
    statue_struct.var_97a384949d61b834 = spawn("script_model", var_ca13ae3b86414de6[1].origin);
    statue_struct.var_97a384949d61b834.angles = var_ca13ae3b86414de6[1].angles;
    statue_struct.var_97a384949d61b834 setModel("jup_zm_powerup_vfx");
    statue_struct.var_97a384949d61b834 hide();
    statue_struct.var_97a384949d61b834 showtoplayer(player);
    var_7b6480a1fe8c888 = statue_struct get_linked_struct();
    level thread function_26c20ff868905e02(var_7b6480a1fe8c888.origin, player);
    return;
  }

  statue_struct.var_97a387949d61becd delete();
  statue_struct.var_97a384949d61b834 delete();
  level notify("kill_floating_statue_repeat_fx");
}

function function_26c20ff868905e02(fx_org, player) {
  level endon("kill_floating_statue_repeat_fx");
  player endon("disconnect");

  while(true) {
    dist = distance(player.origin, fx_org);
    timer = 1 + dist * 0.000111111;
    wait timer;
    playFX(level._effect["zombie_explosion"], fx_org, undefined, undefined, player, 1);
  }
}

function function_ec20c7668ab0d90(player, var_30eb4ba276fd2504, ignore_list) {
  level endon("game_ended");
  player endon("disconnect");
  var_2e3e0430467044aa = player spawn_script_origin();
  var_2e3e0430467044aa linkTo(player);
  var_2e3e0430467044aa playLoopSound("evt_ob_rr_bunny_attract_lp");

  while(true) {
    wait 0.05;

    if(function_235b0933a614354f(player)) {
      var_2e3e0430467044aa stoploopsound();
      var_2e3e0430467044aa delete();
      return 1;
    }

    if(!function_e7c30095a6cdc3ef(player, var_30eb4ba276fd2504, 60, undefined, ignore_list) || !isalive(player)) {
      var_2e3e0430467044aa stoploopsound();
      var_2e3e0430467044aa delete();
      return 0;
    }
  }
}

function function_235b0933a614354f(player) {
  destinations = getStructArray("statue_end_goal", "targetname");

  foreach(dest in destinations) {
    if(distance(player.origin, dest.origin) < 256) {
      return true;
    }
  }

  return false;
}

function get_closest_player(location) {
  if(!isDefined(level.players)) {
    return undefined;
  }

  if(!isDefined(level.players[0])) {
    return undefined;
  }

  active_players = [];

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(player.sessionstate) && isalive(player) && player.sessionstate == "playing") {
      active_players = array_add(active_players, player);
    }
  }

  return sortbydistance(active_players, location)[0];
}

function function_e7c30095a6cdc3ef(player, position, fov, should_trace, ignore_list) {
  if(!isDefined(player)) {
    return false;
  }

  if(!isDefined(fov)) {
    fov = getdvarint(@ "cg_fov");
  }

  if(!isDefined(should_trace)) {
    should_trace = 1;
  }

  in_fov = within_fov(player getEye(), player getplayerangles(), position, cos(fov));

  if(!in_fov) {
    return false;
  }

  if(!should_trace) {
    return true;
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  castresult = physics_raycast(player getEye(), position, contents, ignore_list, 0, "physicsquery_closest", 0);

  if(isDefined(castresult) && castresult.size > 0) {
    return false;
  }

  return true;
}

function function_1efaeeb81ad43025() {
  flag_wait("ob_infil_completed");
  door_structs = getStructArray("opened_door", "targetname");

  foreach(door_struct in door_structs) {
    door = getentitylessscriptablearray(undefined, undefined, door_struct.origin, 48)[0];

    if(isDefined(door)) {
      door scriptabledooropen("away", door_struct.origin);
      continue;
    }

    iprintln(door_struct.origin);
  }
}

function function_a13f7cecf0912d15() {
  flag_wait("ob_infil_completed");
  var_df719fd5528b2760 = getStructArray("thermal_phone_spawn", "targetname");

  foreach(thermal_phone_spawn in var_df719fd5528b2760) {
    var_dd3591156a98047f = function_f050791ced405c63(thermal_phone_spawn.origin, thermal_phone_spawn.angles, "ob_jup_item_thermal_phone");
    thread function_84dafd792ddf581(var_dd3591156a98047f);
  }
}

function function_84dafd792ddf581(var_dd3591156a98047f) {
  level endon("game_ended");
  var_a224fe64f173cfce = spawnscriptable("jup_zm_s5_fx_thermal_phone", var_dd3591156a98047f.origin, var_dd3591156a98047f.angles);

  while(isDefined(var_dd3591156a98047f)) {
    wait 0.1;
  }

  var_a224fe64f173cfce freescriptable();
}

function function_f050791ced405c63(spawnpos, spawnangles, item) {
  bundle_str = "itemspawnentry:" + item;
  itembundle = getscriptbundle(bundle_str);

  if(!isDefined(itembundle)) {
    return;
  }

  return scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, spawnpos, spawnangles, 1, 1);
}

function function_14a4228b442db1ba() {
  var_631ae7a1513f705e = getEnt("thermal_air_walk_completion_trigger", "targetname");
  thread function_d1fdfd8f4cf74e50("flag_thermal_air_walk", var_631ae7a1513f705e);
  flag_wait("flag_thermal_air_walk");
  struct_spawnloc = getStruct("bonus_weap_3", "targetname");
  level thread function_b9f2df0813f1123e(struct_spawnloc, "ob_jup_item_weapon_ar_golf36_v5501_orange", 3, 4);
  reward_structs = getStructArray("thermal_air_walk_item_reward", "targetname");

  foreach(reward in reward_structs) {
    itembundle = getscriptbundle("itemspawnentry:" + reward.script_noteworthy);

    if(isDefined(itembundle)) {
      scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, reward.origin, reward.angles, 1, 1);
    }
  }
}

function function_38b1cb666f0178c4() {
  while(!isDefined(level.players) || !isDefined(level.players[0])) {
    waitframe();
  }

  if(!getdvarint(@ "hash_72529ae3246bfd33", 1)) {
    return;
  }

  level.var_647737f2de33ddb2 = [];
  var_bf40240e76bafb50 = getStructArray("thermal_arrow", "script_noteworthy");

  foreach(var_e6be399ce64ae703 in var_bf40240e76bafb50) {
    arrow = spawn("script_model", var_e6be399ce64ae703.origin);
    arrow.angles = var_e6be399ce64ae703.angles;
    arrow setModel("sign_thermal_phone_arrow_02");
    arrow hide();
    level.var_647737f2de33ddb2[level.var_647737f2de33ddb2.size] = arrow;
  }
}

function function_21617328314fe31b(player) {
  player.var_8a8030d2932bf98f = 1;

  if(isDefined(level.map_puzzle_topdown)) {
    level.map_puzzle_topdown showtoplayer(player);
  }

  foreach(cross in level.var_6fa0bf56ee52f6c1) {
    cross showtoplayer(player);
  }

  foreach(arrow in level.var_647737f2de33ddb2) {
    arrow showtoplayer(player);
  }

  if(isDefined(level.thermal_interact)) {
    level.thermal_interact enablescriptableplayeruse(player);
  }
}

function function_d49faba6568aa84c(player) {
  player.var_8a8030d2932bf98f = undefined;

  if(isDefined(level.map_puzzle_topdown)) {
    level.map_puzzle_topdown hidefromplayer(player);
  }

  foreach(cross in level.var_6fa0bf56ee52f6c1) {
    cross hidefromplayer(player);
  }

  foreach(arrow in level.var_647737f2de33ddb2) {
    arrow hidefromplayer(player);
  }

  if(isDefined(level.thermal_interact)) {
    level.thermal_interact disablescriptableplayeruse(player);
  }
}

function function_1287364f511668d4(player) {
  if(!isDefined(player) || !isalive(player)) {
    return false;
  }

  return istrue(player.var_8a8030d2932bf98f);
}

function function_de4e46cfbeda8a88() {
  startpoints = getStructArray(level.start_point + "<dev string:x2dc>", "<dev string:x136>");

  foreach(startpoint in startpoints) {
    startpoint.index = 0;
  }

  return startpoints[0];
}

function function_f4b09c13be2773d6(start_str) {
  if(!isDefined(start_str)) {
    return 0;
  }

  if(is_equal(start_str, "<dev string:x2e6>") || is_equal(start_str, "<dev string:x2ea>")) {
    return 0;
  }

  foreach(key, value in level.start_arrays) {
    if(is_equal(key, start_str)) {
      return 1;
    }
  }

  return 0;
}

function private function_e085c11cc5e27261() {
  sorted_array = [];

  if(level.start_functions.size <= 1) {
    return;
  }

  for(i = 0; i < level.start_functions.size; i++) {
    if(!isstartstr(level.start_functions[i]["name"], "no_game")) {
      sorted_array[sorted_array.size] = level.start_functions[i];
    }
  }

  for(i = 0; i < level.start_functions.size; i++) {
    if(isstartstr(level.start_functions[i]["name"], "no_game")) {
      sorted_array[sorted_array.size] = level.start_functions[i];
    }
  }

  level.start_functions = sorted_array;
}

function get_start_dvars() {
  dvars = [];

  for(i = 0; i < level.start_functions.size; i++) {
    dvars[dvars.size] = level.start_functions[i]["name"];
  }

  return dvars;
}

function function_d96f980db28d4994() {
  debug_start = tolower(getDvar(@ "start"));

  if(function_f4b09c13be2773d6(debug_start)) {
    level.start_point = debug_start;
    flag_wait("<dev string:x2f3>");
    level.getspawnpoint = &function_de4e46cfbeda8a88;
    thread set_completed_flags();
  }
}

function function_ff761f5b1946a46a() {
  level endon("<dev string:x324>");
  setdvarifuninitialized(@ "hash_27de34551d363b00", "<dev string:x2e6>");
  old_start = tolower(getDvar(@ "start"));

  if(!isDefined(old_start)) {
    old_start = "<dev string:x2e6>";
  }

  current_start = tolower(getDvar(@ "hash_27de34551d363b00"));
  dvars = get_start_dvars();

  while(true) {
    current_start = tolower(getDvar(@ "hash_27de34551d363b00"));

    if(isDefined(current_start) && current_start != "<dev string:x2e6>" && current_start != old_start) {
      for(i = 0; i < dvars.size; i++) {
        if(issubstr(dvars[i], current_start)) {
          start_index = i;
          level.start_point = dvars[i];
          thread set_completed_flags();
          old_start = current_start;
          break;
        }
      }
    }

    wait 1;
  }
}

function handle_starts() {
  level endon("game_ended");
  level.start_struct = spawnStruct();
  setdvarifuninitialized(@ "start", "");

  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  } else {
    function_e085c11cc5e27261();
  }

  start = tolower(getDvar(@ "start"));
  dvars = get_start_dvars();

  if(isDefined(level.start_point)) {
    start = level.start_point;
  }

  start_index = 0;

  for(i = 0; i < dvars.size; i++) {
    if(start == dvars[i]) {
      start_index = i;
      level.start_point = dvars[i];
      break;
    }
  }

  if(isDefined(level.default_start_override) && !isDefined(level.start_point)) {
    foreach(index, dvar in dvars) {
      if(level.default_start_override == dvar) {
        start_index = index;
        level.start_point = dvar;
        break;
      }
    }
  }

  if(!isDefined(level.start_point)) {
    if(isDefined(level.default_start)) {
      level.start_point = "default";
    } else if(level_has_start_points()) {
      level.start_point = level.start_functions[0]["name"];
    } else {
      level.start_point = "default";
    }
  }

  waittillframeend();
  flag_set("start_is_set");

  while(!isDefined(level.players) || !isDefined(level.players[0])) {
    waitframe();
  }

  start_array = level.start_arrays[level.start_point];

  if(level.start_point == "default") {
    if(isDefined(level.default_start)) {
      level thread[[level.default_start]]();
    }
  } else {
    start_array = level.start_arrays[level.start_point];

    thread indicate_start(level.start_point);

    if(isDefined(start_array["start_func"])) {
      thread[[start_array["start_func"]]]();
    }
  }

  waittillframeend();
  previously_run_logic_functions = [];

  for(i = start_index; i < level.start_functions.size; i++) {
    start_array = level.start_functions[i];

    if(!isDefined(start_array["logic_func"])) {
      continue;
    }

    if(already_ran_function(start_array["logic_func"], previously_run_logic_functions)) {
      continue;
    }

    level.start_struct[[start_array["logic_func"]]]();

    if(getdvarint(@ "hash_47b7445b595408f7", 0) > 0) {
      return;
    }

    previously_run_logic_functions[previously_run_logic_functions.size] = start_array["logic_func"];
  }
}

function already_ran_function(func, previously_run_logic_functions) {
  foreach(logic_function in previously_run_logic_functions) {
    if(logic_function == func) {
      return true;
    }
  }

  return false;
}

function indicate_start(start) {
  wait 6;

  foreach(player in level.players) {
    thread function_b4a6f74ffa88e0b2(player, start);
  }
}

function function_b4a6f74ffa88e0b2(player, text) {
  hudelem = newclienthudelem(player);
  hudelem.alignx = "left";
  hudelem.aligny = "middle";
  hudelem.x = 10;
  hudelem.y = 400;

  hudelem setdevtext(text);

  hudelem.alpha = 0;
  hudelem.fontscale = 3;
  wait 1;
  hudelem fadeovertime(1);
  hudelem.alpha = 1;
  wait 5;
  hudelem fadeovertime(1);
  hudelem.alpha = 0;
  wait 1;
  hudelem destroy();
}

function level_has_start_points() {
  return level.start_functions.size > 1;
}

function add_start(startname, setup_func, main_func) {
  if(!isDefined(level.start_functions)) {
    level.start_functions = [];
  }

  msg = tolower(startname);
  array = add_start_construct(msg, setup_func, main_func);
  level.start_functions[level.start_functions.size] = array;
  level.start_arrays[msg] = array;
}

function add_start_construct(msg, func, optional_func) {
  array = [];
  array["name"] = msg;
  array["start_func"] = func;
  array["logic_func"] = optional_func;
  return array;
}

function function_61d33f3dc5126cb8(lockent) {
  cleanse_fx = playFXOnTag(getfx("ava_cleanse_loop"), lockent, "tag_origin");
}

function function_c4df55a6727232d5(lockent) {
  stopFXOnTag(getfx("ava_cleanse_loop"), lockent, "tag_origin");
  lockent delete();
}

function private function_e48d7ff378117f3d() {
  level endon("game_ended");
  level waittill("jansen_phase_01_cleanse_start");
  lockent = spawn("script_model", level.var_2ada333c838a2316 gettagorigin("j_spine4"));
  lockent setModel("tag_origin");
  lockent linkTo(level.var_2ada333c838a2316, "j_spine4");
  level.var_2ada333c838a2316 thread function_61d33f3dc5126cb8(lockent);
  playsoundatpos(level.var_2ada333c838a2316.origin + (0, 0, 32), "evt_ob_story_jansen_teleport_out");
  level waittill("entity_spawn_vo_start");
  flag_set("entity_intro_vo");
  level waittill("entity_spawn_phase_01_zombies_ready");
  function_f14e2b18d9628796();
  level waittill("jansen_phase_01_cleanse_end");
  level.var_2ada333c838a2316 thread function_c4df55a6727232d5(lockent);
  level waittill("jansen_phase_01_tele_out");
  playFX(getfx("ava_teleport_out"), level.var_2ada333c838a2316.origin + (0, 0, 32));
  playsoundatpos(level.var_2ada333c838a2316.origin + (0, 0, 32), "evt_ob_story_jansen_teleport_out");
}

function private function_e48d7cf3781178a4() {
  level endon("game_ended");
  level endon("entity_defeated");
  level waittill("entity_phase_02_spawn_vo");
  flag_set("flag_entity_phase_02_spawn_vo");
}

function private function_51ebbd96b698f404() {
  level endon("game_ended");
  level waittill("jansen_phase_02_tele_in");
  dest = level.var_2ada333c838a2316.origin;
  playFX(getfx("ava_teleport_in"), dest);
  playsoundatpos(dest, "evt_ob_story_jansen_teleport_in");
  level waittill("lightbomb_charge_begin");
  lockent = spawn("script_model", level.var_2ada333c838a2316 gettagorigin("j_spine4"));
  lockent setModel("tag_origin");
  lockent linkTo(level.var_2ada333c838a2316, "j_spine4", (5, 0, -5), (0, 0, 0));
  level.var_2ada333c838a2316 thread function_61d33f3dc5126cb8(lockent);
  level waittill("lightbomb_charge_end");
  level.var_2ada333c838a2316 thread function_c4df55a6727232d5(lockent);
  level waittill("jansen_phase_02_throw_lightbomb");
  flag_set("throw_lightbomb");
  level waittill("jansen_phase_02_tele_out");
  dest = level.var_2ada333c838a2316.origin;
  playFX(getfx("ava_teleport_out"), level.var_2ada333c838a2316.origin + (0, 0, 32));
  playsoundatpos(dest + (0, 0, 32), "evt_ob_story_jansen_teleport_out");
}

function private function_80a2e9e17acc0cde() {
  level endon("game_ended");
  level waittill("jansen_exfil_tele_in");
  dest = level.var_2ada333c838a2316.origin;
  playFX(getfx("ava_teleport_in"), dest);
  level waittill("jansen_exfil_cleanse_start");
  lockent = spawn("script_model", level.var_2ada333c838a2316 gettagorigin("j_spine4"));
  lockent setModel("tag_origin");
  lockent linkTo(level.var_2ada333c838a2316, "j_spine4");
  level.var_2ada333c838a2316 thread function_61d33f3dc5126cb8(lockent);
  playsoundatpos(level.var_2ada333c838a2316.origin + (0, 0, 32), "evt_ob_story_jansen_teleport_out");
}

function function_45ce0277f25c2af5() {
  foreach(player in level.players) {
    player setsoundsubmix("jup_ob_s5_5_story_cleanse_site_lightning_impacts");
  }
}

function function_9bb1f79d8b9b3500() {
  foreach(player in level.players) {
    player clearsoundsubmix("jup_ob_s5_5_story_cleanse_site_lightning_impacts");
  }
}

function function_cfa24481485ba33c() {
  foreach(player in level.players) {
    player playlocalsound("evt_ob_entity_arena_arrive_stinger");
  }
}

function function_cacd8b74338a04ad() {
  foreach(player in level.players) {
    player playlocalsound("evt_ob_story_tower_intro");
  }
}

function function_2ca0ca4159d9fce2() {
  foreach(player in level.players) {
    player playlocalsound("evt_ob_pre_extract_thunder");
  }
}

function function_257aadb427cb61e5(s_exit) {
  wait 7.5;
  playsoundatpos(s_exit.origin, "evt_rr_gate_reshape_alt");
  wait 0.74;
  playsoundatpos(s_exit.origin, "evt_rr_gate_reshape_alt");
}

function function_5ce151ffc970bfa9() {
  wait 1;
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_action_loop");
}

function function_5ce14effc970b910() {
  wait 3;
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_rr_bossbattle");
}

function function_8c311ae5db764f09() {
  wait 3.35;
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_win");
}

function function_f87d2361a137fa8a() {
  wait 1;
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_rr_bossbattle_complete");
}

function function_ee2a20015e37d3ec(conversationname, players, var_7b76e64b846c00d, var_8b6798cc35c82e07, location, group) {
  level scripts\cp_mp\overlord::playconversation(conversationname, players, var_7b76e64b846c00d, var_8b6798cc35c82e07, location, group, &function_6c81f78b4030fb5a, &function_899ee4de578e34a3);
}

function function_ef89cf4181d076e7(eventref, players, delay, includedeadplayers, var_fe8102d7751b9184) {
  if(!isDefined(var_fe8102d7751b9184)) {
    var_fe8102d7751b9184 = 1;
  }

  level scripts\cp_mp\overlord::playevent(eventref, players, delay, includedeadplayers, var_fe8102d7751b9184, &function_6c81f78b4030fb5a, &function_899ee4de578e34a3);
}

function function_6c81f78b4030fb5a(alias, speakerasset, timeout) {
  if(isDefined(speakerasset) && isstring(speakerasset)) {
    if(is_equal(speakerasset, "jup_ob_speaker_jansen") && isDefined(level.var_2ada333c838a2316) && istrue(level.var_2ada333c838a2316.var_9c7b54b172c87654)) {
      level.var_2ada333c838a2316 thread function_791a90f8f4811a4d(alias, timeout);
      return;
    }

    if(is_equal(speakerasset, "jup_ob_speaker_ravenov") && isDefined(level.var_1da22412ed7ad03b) && istrue(level.var_1da22412ed7ad03b.var_8f825bd739498693)) {
      level.var_1da22412ed7ad03b thread function_791a90f8f4811a4d(alias, timeout);
    }
  }
}

function function_899ee4de578e34a3(alias, speakerasset) {
  if(isDefined(speakerasset) && isstring(speakerasset)) {
    if(is_equal(speakerasset, "jup_ob_speaker_jansen") && isDefined(level.var_2ada333c838a2316) && istrue(level.var_2ada333c838a2316.var_9c7b54b172c87654)) {
      level.var_2ada333c838a2316 notify("stop_lip_flap");
      return;
    }

    if(is_equal(speakerasset, "jup_ob_speaker_ravenov") && isDefined(level.var_1da22412ed7ad03b) && istrue(level.var_1da22412ed7ad03b.var_8f825bd739498693)) {
      level.var_1da22412ed7ad03b notify("stop_lip_flap");
    }
  }
}

function function_791a90f8f4811a4d(alias, timeout) {
  self notify("start_lip_flap");
  self endon("start_lip_flap");
  self endon("death");
  archetype = scripts\asm\shared\utility::function_2285421dfc79c4d5();

  if(!istrue(self.var_b44de6b60db89e70)) {
    self.var_b44de6b60db89e70 = 1;
    intensity = scripts\mp\mp_dialogue::get_intensity(alias);
    scripts\asm\shared\utility::setfacialstate("filler");

    if(isDefined(archetype) && archetype != "" && isai(self)) {
      self setfacialindex("talk_" + intensity);
    }
  }

  if(isDefined(timeout)) {
    waittill_notify_or_timeout("stop_lip_flap", timeout);
  } else {
    self waittill("stop_lip_flap");
  }

  archetype = scripts\asm\shared\utility::function_2285421dfc79c4d5();

  if(isDefined(archetype) && archetype != "" && isai(self)) {
    self setfacialindex("none");
  }

  scripts\asm\shared\utility::clearfacialstate("filler");
  self.var_b44de6b60db89e70 = 0;
}