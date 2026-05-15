/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\estate.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_anim;
#include maps\_slowmo_breach;
#include maps\estate_code;

main() {
  default_start(::startIntro);
  add_start("intro", ::startIntro, "Intro", ::estate_ambush);
  add_start("ambush", ::startAmbush, "Ambush", ::estate_ambush);
  add_start("forest_fight", ::startForestFight, "Forest Fight", ::estate_ambush);
  add_start("house_approach", ::startHouseApproach, "House Approach", ::estate_ambush);
  add_start("house_breach", ::startHouseBreach, "House Breach");
  add_start("house_briefing", ::startHouseBriefing, "House Briefing");
  add_start("house_defense", ::startHouseDefense, "House Defense");
  add_start("escape", ::startEscape, "Escape to LZ");
  add_start("ending", ::startEnding, "Ending Sequence");
  add_start("ending_body_throw", ::startEndingBodyTossOnly);
  add_start("alt_ending", ::startAltEnding, "Alternate Ending");

  add_start("ending_noslowmo", ::startEndingMeh);
  add_start("diskdrive", ::startDiskdrive);
  add_start("helicopter_tweak", ::startHeliTweak);
  add_start("helicopter_tweak_2", ::startHeliTweak2);
  add_start("ending_pavelow_heli_tweak", ::startHeliTweakPavelowEnd);
  add_start("ending_shadow_heli_tweak", ::startHeliTweakShadowBirdsEnd);
  add_start("fakeRPG_tweak", ::startFakeRPGTweak);

  flags();

  maps\estate_precache::main();

  global_inits();
}

start_common_estate() {
  thread objectives();

  thread estate_music();

  thread house_autosaves();

  thread bouncing_betty_gameplay_init();
  thread birchfield_exfil();
  thread friendly_death_cointoss();
  thread bb_autosave();

  thread maps\_mortar::bog_style_mortar();

  thread birchfield_knockout();
  thread ending_moments();
  thread ending_pavelow_fakearrival();
  thread end_of_level();

  if(!flag("skip_forestfight")) {
    thread forest_ambush_mortars();
    thread forest_ambush_rpg_guys();
    thread forest_enemy_deathmonitor_init();
    thread forest_ghillie_reveal();
    thread first_smoke_screen();
    thread forest_attackers();
    thread forest_smoke_fight();
    thread forest_smoke_screens();
    thread forest_escape_autosave();
  }

  if(flag("skip_forestfight")) {
    flag_set("start_ambush_music");
  }

  if(!flag("skip_houseapproach")) {
    thread house_approach_jeepassault();
    thread house_approach_autosave();
    thread house_approach_futilejeep();
    thread house_arrival_autosave();
    thread house_friendly_rush();
    thread house_approach_dialogue();
    thread house_perimeter_jeepguards();
  }

  if(!flag("skip_breachandclear")) {
    thread house_enemy_cleanup_tracker();
    thread house_arrival_aisettings();
    thread house_clearing_save_mainfloor();
    thread house_clearing_save_basement();

    thread house_backwards_door_handling();

    thread house_battlechatter_check();

    thread house_mainfloor_cleared();
    thread house_topfloor_cleared();
    thread house_basement_cleared();

    thread house_topfloor_breached();
    thread house_basement_breached_armory();
    thread house_basement_breached_guestroom();

    thread house_mainfloor_cleared_dialogue();
    thread house_topfloor_cleared_dialogue();
    thread house_basement_cleared_dialogue();

    thread house_check_upstairs_mainfloor_dialogue();
    thread house_check_upstairs_basement_dialogue();
    thread house_check_basement_dialogue();
    thread house_clearing_banter();

    thread house_ghost_sweep();
    thread house_ghost_lastbreach_reset();

    thread house_extras_breach_mainfloor();
    thread house_extras_breach_kitchen();
    thread house_extras_breach_basement();
    thread house_exterior_breach_awareness();

    thread house_extras_tally("breach0_diningroom", "breaching_number_0");
    thread house_extras_tally("breach0_foyerhall", "breaching_number_0");
    thread house_extras_tally("breach0_bathroomrush", "breaching_number_0");

    thread house_extras_cancel_floorpop_monitor("breach0_diningroom", "breach0_diningroom_cancel", "foyer_breached_first");
    thread house_extras_cancel_floorpop_monitor("breach0_foyerhall", "breach0_foyerhall_cancel", "foyer_breached_first");

    thread house_extras_spawncontrol("breach0_diningroom_spawntrig", "breach0_diningroom_cancel", "breaching_number_0", "breach0_diningroom");

    thread house_extras_spawncontrol("breach0_foyerhall_spawntrig", "breach0_foyerhall_cancel", "breaching_number_0", "breach0_foyerhall");

    thread house_extras_spawncontrol("breach0_bathroomrush_spawntrig", undefined, "breaching_number_0", "breach0_bathroomrush");
    thread house_extras_bathroom_screamingguy_setup();

    thread house_extras_tally("breach1_foyertodining", "breaching_number_1");
    thread house_extras_tally("breach1_officerush", "breaching_number_1");

    thread house_extras_cancel_floorpop_monitor("breach1_foyertodining", "breach1_foyertodining_cancel", "kitchen_breached_first");
    thread house_extras_cancel_floorpop_monitor("breach1_officerush", "breach1_officerush_cancel", "kitchen_breached_first");

    thread house_extras_spawncontrol("breach1_foyertodining_spawntrig", "breach1_foyertodining_cancel", "breaching_number_1", "breach1_foyertodining");

    thread house_extras_spawncontrol("breach1_officerush_spawntrig", undefined, "breaching_number_1", "breach1_officerush");

    thread house_extras_tally("breach2_stairdown", "breaching_number_2");

    thread house_extras_cancel_floorpop_monitor("breach2_stairdown", "breach2_stairdown_cancel", "basement_breached_first");

    thread house_extras_spawncontrol("breach2_stairdown_spawntrig", "breach2_stairdown_cancel", "breaching_number_2", "breach2_stairdown");
  }

  if(flag("skip_breachandclear")) {
    thread delete_breach(0);
    thread delete_breach(1);
    thread delete_breach(2);
    thread delete_breach(3);
    thread delete_breach(4);
    thread delete_breach(5);
    thread house_guestroom_door_remove();
    thread house_backwards_door_handling();
  }

  if(!flag("skip_housebriefing")) {
    thread dsm_display_control();
    thread house_briefing_dialogue();
    thread download_progress();
    thread download_fake_timer();
    thread dsm_setup();
    thread defense_intro();
    thread dsm_destruction_damage_detect();
    thread dsm_health_regen();
    thread dsm_health_regen_calc();
  }

  if(flag("skip_housebriefing") && !flag("skip_defense")) {
    thread dsm_display_control();
    thread download_progress();
    thread download_fake_timer();
    thread dsm_setup();
    thread defense_intro();
    thread dsm_destruction_damage_detect();
    thread dsm_health_regen();
    thread dsm_health_regen_calc();
  }
}

startIntro() {
  thread start_common_estate();

  ghost_init();

  thread ghost_intro_nav();
  thread intro();
  thread intro_dialogue();

  thread friendly_troop_spawn();
  thread friendly_scout_spawn();
  thread friendly_sniper_spawn();
}

startAmbush() {
  flag_set("skip_intro");

  flag_set("print_first_objective");

  thread start_common_estate();

  friendly_sniper_spawn();

  player_ambush_start = getent("player_ambush_start", "targetname");
  level.player teleport_ent(player_ambush_start);

  ghost_init();
  node = getnode("ghost_ambush_start", "targetname");
  level.ghost forceTeleport(node.origin, node.angles);

  redshirts = getEntArray("starterguy", "script_noteworthy");
  nodes = getnodearray("friendly_ambush_start", "targetname");

  friendly_starts_avail = redshirts.size <= nodes.size;

  assertEX(friendly_starts_avail, "Not enough start nodes exist for redshirts, add more nodes for them to start at.");

  foreach(index, redshirt in redshirts) {
    redshirt.origin = nodes[index].origin;
    redshirt.angles = nodes[index].angles;
  }

  friendly_troop_spawn();
  friendly_scout_spawn();

  activate_trigger_with_targetname("ambush_start_redshirts");
  activate_trigger_with_targetname("ambush_start_ghost");
}

startForestFight() {
  flag_set("skip_intro");
  flag_set("skip_ambush");
  flag_set("bouncing_betty_done");
  flag_set("print_first_objective");

  flag_set("deploy_rpg_ambush");
  flag_set("deploy_mortar_attack");
  flag_set("ambush_complete");

  thread start_common_estate();

  player_forestfight_start = getent("player_forestfight_start", "targetname");
  level.player teleport_ent(player_forestfight_start);

  ghost_init();
  node = getnode("ghost_ambush_start", "targetname");
  level.ghost forceTeleport(node.origin, node.angles);

  redshirts = getEntArray("starterguy", "script_noteworthy");
  nodes = getnodearray("friendly_forestfight_start", "targetname");
  deathNodes = getnodearray("forestfight_friendlykill", "script_noteworthy");

  friendly_starts_avail = redshirts.size <= nodes.size;

  assertEX(friendly_starts_avail, "Not enough start nodes exist for redshirts, add more nodes for them to start at.");

  foreach(index, redshirt in redshirts) {
    redshirt.origin = nodes[index].origin;
    redshirt.angles = nodes[index].angles;
  }

  friendly_troop_spawn();
  friendly_scout_spawn();

  activate_trigger_with_targetname("forestfight_start_redshirts");
  activate_trigger_with_targetname("ambush_start_ghost");

  wait 0.05;

  foreach(deathNode in deathNodes) {
    radiusdamage(deathNode.origin, deathNode.radius, 1000, 180);
  }

  wait 3;

  flag_set("smoke_screen_activated");

  wait 3;

  flag_set("spawn_first_ghillies");
}

startHouseApproach() {
  flag_set("skip_intro");
  flag_set("skip_ambush");
  flag_set("skip_forestfight");
  flag_set("bouncing_betty_done");
  flag_set("print_first_objective");
  flag_set("forestfight_littlebird_1");
  flag_set("player_is_out_of_ambush_zone");

  thread start_common_estate();

  player_houseapproach_start = getent("player_houseapproach_start", "targetname");
  level.player teleport_ent(player_houseapproach_start);

  ghost_init();
  node = getnode("ghost_houseapproach_start", "targetname");
  level.ghost forceTeleport(node.origin, node.angles);

  redshirtStartSpawnTeleport("houseapproach");
}

startHouseBreach() {
  flag_set("skip_intro");
  flag_set("skip_ambush");
  flag_set("skip_forestfight");
  flag_set("skip_houseapproach");
  flag_set("bouncing_betty_done");

  flag_set("print_first_objective");
  flag_set("futilejeeps_destroyed");
  flag_set("deploy_house_defense_jeeps");

  flag_set("forestfight_littlebird_1");
  flag_set("player_is_out_of_ambush_zone");

  thread start_common_estate();

  player_houseapproach_start = getent("breach_tweak_start", "targetname");
  level.player teleport_ent(player_houseapproach_start);

  ghost_init();
  node = getnode("ghost_breachstart_node", "targetname");
  level.ghost forceTeleport(node.origin, node.angles);

  redshirtStartSpawnTeleport("breachhouse");

  houseAttackTrig = getent("house_approach_friendlytrigger", "targetname");
  houseAttackTrig notify("trigger");
}

startHouseBriefing() {
  flag_set("skip_intro");
  flag_set("skip_ambush");
  flag_set("skip_forestfight");
  flag_set("skip_houseapproach");
  flag_set("skip_breachandclear");

  flag_set("bouncing_betty_done");

  flag_set("print_first_objective");
  flag_set("futilejeeps_destroyed");

  flag_set("house_exterior_has_been_breached");
  flag_set("house_interior_breaches_done");

  flag_set("forestfight_littlebird_1");
  flag_set("player_is_out_of_ambush_zone");

  level notify("breaching_number_3");

  thread start_common_estate();

  level.playerZone = "zone_house";

  player_houseapproach_start = getent("briefing_tweak_start", "targetname");
  level.player teleport_ent(player_houseapproach_start);

  ghost_init();

  node = getnode("ghost_breachstart_node", "targetname");
  level.ghost forceTeleport(node.origin, node.angles);

  redshirtStartSpawnTeleport("housebriefing");

  houseAttackTrig = getent("house_approach_friendlytrigger", "targetname");
  houseAttackTrig notify("trigger");

  flag_set("all_enemies_killed_up_to_house_capture");
}

startHouseDefense() {
  flag_set("skip_intro");
  flag_set("skip_ambush");
  flag_set("skip_forestfight");
  flag_set("skip_houseapproach");
  flag_set("skip_breachandclear");
  flag_set("skip_housebriefing");

  flag_set("bouncing_betty_done");

  flag_set("print_first_objective");
  flag_set("futilejeeps_destroyed");

  flag_set("house_exterior_has_been_breached");
  flag_set("house_interior_breaches_done");

  flag_set("forestfight_littlebird_1");
  flag_set("player_is_out_of_ambush_zone");

  flag_set("dsm_ready_to_use");
  flag_set("house_briefing_is_over");
  flag_set("download_started");

  flag_set("skip_house_defense_dialogue");

  level.playerZone = "zone_house";

  level notify("breaching_number_3");

  thread start_common_estate();

  player_houseapproach_start = getent("briefing_tweak_start", "targetname");
  level.player teleport_ent(player_houseapproach_start);

  ghost_init();

  node = getnode("ghost_earlydefense_start", "targetname");
  level.ghost forceTeleport(node.origin, node.angles);

  redshirtStartSpawnTeleport("housebriefing");

  houseAttackTrig = getent("house_approach_friendlytrigger", "targetname");
  houseAttackTrig notify("trigger");

  flag_set("scarecrow_to_earlydefense_start");
  flag_set("ozone_to_earlydefense_start");

  flag_set("all_enemies_killed_up_to_house_capture");

  wait 1;

  node = getnode("ghost_earlydefense_start", "targetname");
  level.ghost setgoalnode(node);

  thread house_briefing_scarecrow();
  thread house_briefing_ozone();
}

startEscape() {
  fence = getent("final_area_fence", "targetname");
  fence delete();

  dsm_real = getent("dsm", "targetname");
  dsm_obj = getent("dsm_obj", "targetname");

  dsm_real hide();
  dsm_obj hide();

  flag_set("skip_intro");
  flag_set("skip_ambush");
  flag_set("skip_forestfight");
  flag_set("skip_houseapproach");
  flag_set("skip_breachandclear");
  flag_set("skip_housebriefing");
  flag_set("skip_defense");

  flag_set("bouncing_betty_done");

  flag_set("print_first_objective");
  flag_set("futilejeeps_destroyed");

  flag_set("house_exterior_has_been_breached");
  flag_set("house_interior_breaches_done");

  flag_set("forestfight_littlebird_1");
  flag_set("player_is_out_of_ambush_zone");

  flag_set("house_briefing_is_over");
  flag_set("download_started");

  flag_set("skip_house_defense_dialogue");

  flag_set("download_complete");

  flag_set("dsm_recovered");

  level.playerZone = "zone_house";

  level notify("breaching_number_3");

  thread start_common_estate();

  player_houseapproach_start = getent("briefing_tweak_start", "targetname");
  level.player teleport_ent(player_houseapproach_start);

  ghost_init();

  node = getnode("ghost_earlydefense_start", "targetname");
  level.ghost forceTeleport(node.origin, node.angles);

  redshirtStartSpawnTeleport("housebriefing");

  houseAttackTrig = getent("house_approach_friendlytrigger", "targetname");
  houseAttackTrig notify("trigger");

  flag_set("scarecrow_to_earlydefense_start");
  flag_set("ozone_to_earlydefense_start");

  flag_set("all_enemies_killed_up_to_house_capture");

  wait 1;

  level.scarecrow stop_magic_bullet_shield();
  level.ozone stop_magic_bullet_shield();
}

startAltEnding() {
  fence = getent("final_area_fence", "targetname");
  fence delete();

  flag_set("test_whole_ending");
  flag_set("test_ending");
  flag_set("play_ending_sequence");

  flag_set("point_of_no_return");
  thread end_of_level();
  thread ghost_init();
  thread ending_pavelow_fakearrival();

  level.player EnableDeathShield(true);
  level.cover_warnings_disabled = 1;

  wait 5;
  flag_set("finish_line");
  flag_set("test_alt_ending");
  ending_moments();
}

startEnding() {
  fence = getent("final_area_fence", "targetname");
  fence delete();

  flag_set("test_whole_ending");
  flag_set("test_ending");
  flag_set("play_ending_sequence");

  flag_set("point_of_no_return");
  thread end_of_level();
  thread ghost_init();
  thread ending_pavelow_fakearrival();

  level.player EnableDeathShield(true);
  level.cover_warnings_disabled = 1;

  wait 5;
  flag_set("finish_line");
  thread estate_music();
  ending_moments();
}

startEndingBodyTossOnly() {
  flag_set("play_ending_sequence");
  flag_set("test_ending_body_toss");

  level.player EnableDeathShield(true);
  level.cover_warnings_disabled = 1;

  ending_moments();
}

startEndingMeh() {
  fence = getent("final_area_fence", "targetname");
  fence delete();

  flag_set("test_whole_ending");
  flag_set("test_ending");
  flag_set("play_ending_sequence");
  flag_set("test_with_pavelow_already_in_place");
  flag_set("no_slow_mo");

  level.player EnableDeathShield(true);
  level.cover_warnings_disabled = 1;

  thread ghost_init();
  ending_moments();
}

startDiskdrive() {
  flag_set("download_started");
  flag_set("download_test");
  thread download_progress();
  thread download_fake_timer();
}

startHeliTweak() {
  flag_set("skip_intro");

  heliName = "md500_rush_3";

  heli_tweak(heliName);
}

startHeliTweak2() {
  flag_set("skip_intro");

  heliName = "boathouse_mi17";
  thread heli_tweak(heliName);

  heliName = "boathouse_md500";
  thread heli_tweak(heliName);
}

startHeliTweakPavelowEnd() {
  flag_set("skip_intro");
  flag_set("point_of_no_return");

  node = getstruct("ending_chopper_node", "targetname");
  level.player teleport_player(node);

  thread ending_pavelow_fakearrival();
}

startHeliTweakShadowBirdsEnd() {
  flag_set("skip_intro");
  flag_set("enter_the_littlebirds");

  node = getstruct("ending_chopper_node", "targetname");
  level.player teleport_player(node);

  thread ending_shadowops_heli_sequence();
}

startFakeRPGTweak() {
  wait 5;

  ambush_fake_rpg_barrage();
}

/

intro() {
  wait 2;
  maps\_introscreen::estate_intro2();

  flag_set("slam_zoom_done");

  level.player setStance("crouch");

  wait 1.8;

  flag_set("start_ghost_intro_nav");

  wait 5;

  flag_set("print_first_objective");
}

intro_dialogue() {
  flag_wait("slam_zoom_done");
}

objectives() {
  flag_wait("print_first_objective");

  objective_location_makarov = getent("objective_location_makarov", "targetname");
  objective_add(1, "current", &"ESTATE_OBJ_ASSASSINATE", objective_location_makarov.origin);

  flag_wait("deploy_house_defense_jeeps");

  objective_add(2, "current", &"ESTATE_OBJ_BREACH");
  objective_current(2);

  exteriorBreaches = getEntArray("breach_objective_exterior", "targetname");

  assign_script_breachgroup_to_ents(exteriorBreaches);

  breach_indices = get_breach_indices_from_ents(exteriorBreaches);

  objective_breach(2, breach_indices[0], breach_indices[1], breach_indices[2], breach_indices[3]);

  thread objective_exterior_breach_check("0");
  thread objective_exterior_breach_check("1");
  thread objective_exterior_breach_check("2");

  flag_wait("house_exterior_has_been_breached");

  objective_clearAdditionalPositions(2);
  wait(1);

  interiorBreaches = getEntArray("breach_objective_interior", "targetname");
  assign_script_breachgroup_to_ents(interiorBreaches);

  level.interiorBreachesCompleted = 0;
  level.interiorBreachesRequired = interiorBreaches.size;

  foreach(breach in interiorBreaches) {
    breach thread objective_interior_breach_update(breach.script_slowmo_breach);
  }

  breach_indices = get_breach_indices_from_ents(interiorBreaches);

  maps\_slowmo_breach::objective_breach(2, breach_indices[0], breach_indices[1], breach_indices[2], breach_indices[3]);

  thread objective_interior_breach_check("3");
  thread objective_interior_breach_check("4");
  thread objective_interior_breach_check("5");

  thread objective_breach_save();

  flag_wait("house_interior_breaches_done");

  flag_wait("all_enemies_killed_up_to_house_capture");

  flag_wait("ghost_gives_regroup_order");

  objective_state(2, "done");

  objective_delete(1);

  node = getstruct("ghost_talknode", "targetname");
  objective_add(1, "current", &"ESTATE_OBJ_REGROUP", node.origin);

  flag_wait("house_briefing_is_over");

  objective_state(1, "done");

  dsm_real = getent("dsm", "targetname");
  objective_add(3, "current", &"ESTATE_OBJ_INTEL", dsm_real.origin);

  flag_wait("download_started");

  objective_state(3, "done");

  objective_add(4, "current", &"ESTATE_OBJ_DOWNLOAD", dsm_real.origin);

  Objective_SetPointerTextOverride(4, &"ESTATE_OBJ_POINTER_PROTECT");

  flag_wait("download_complete");

  objective_state(4, "done");

  objective_add(5, "current", &"ESTATE_OBJ_RETRIEVE", dsm_real.origin);

  Objective_SetPointerTextOverride(5, &"ESTATE_OBJ_POINTER_RETRIEVE");

  flag_wait("dsm_recovered");

  marker = getstruct("ending_chopper_node", "targetname");

  objective_state(5, "done");

  objective_add(6, "current", &"ESTATE_OBJ_LZ", marker.origin);

  flag_wait("made_it_to_lz");

  objective_state(6, "done");
}

objective_exterior_breach_check(breachnum) {
  level waittill("breaching_number_" + breachnum);

  flag_set("house_exterior_has_been_breached");
}

objective_interior_breach_check(breachnum) {
  level waittill("breaching_number_" + breachnum);

  level.interiorBreachesCompleted++;

  if(level.interiorBreachesCompleted >= level.interiorBreachesRequired) {
    flag_set("house_interior_breaches_done");
  }
}

objective_breach_save() {
  level waittill("slomo_breach_over");

  wait 3;

  autosave_by_name("breach_completed");
}

objective_interior_breach_update(breachnum) {
  level waittill("breaching_number_" + breachnum);

  self delete();

  interiorBreaches = getEntArray("breach_objective_interior", "targetname");
  assign_script_breachgroup_to_ents(interiorBreaches);

  objective_clearAdditionalPositions(2);

  breach_indices = get_breach_indices_from_ents(interiorBreaches);

  maps\_slowmo_breach::objective_breach(2, breach_indices[0], breach_indices[1], breach_indices[2], breach_indices[3]);
}

estate_ambush() {
  if(flag("ambush_complete")) {
    thread bouncing_betty_throwplayer(level.player.origin);
  }

  if(!flag("ambush_complete")) {
    flag_wait("bouncing_betty_activated");

    battlechatter_off("allies");
    battlechatter_off("axis");

    thread bouncing_betty_slow_mo();

    thread autosave_by_name("bouncing_betty_sequence");

    flag_wait("bouncing_betty_done");

    flag_set("smoke_screen_activated");

    flag_wait("slow_motion_ambush_done");

    wait 1;
  }

  battlechatter_on("allies");
  battlechatter_on("axis");
}

forest_ambush_mortars() {
  flag_wait("deploy_mortar_attack");

  wait 1;

  thread maps\_mortar::bog_style_mortar_on("1");

  wait 2;

  thread forest_friendly_initial_advance();

  level.scarecrow dialogue_queue("est_scr_presighted");

  wait 3;

  level.ghost dialogue_queue("est_gst_counterattack");

  wait 3;

  level.fixednodesaferadius_default = 256;

  if(!flag("player_is_out_of_ambush_zone")) {
    level.ghost dialogue_queue("est_gst_loseeminsmoke");
  }

  wait 5;

  thread forest_mortar_playerkill();
}

forest_friendly_initial_advance() {
  trig = getent("forest_friendly_colortrig", "targetname");
  trig notify("trigger");

  friendlies = getaiarray("allies");
  foreach(friendly in friendlies) {
    friendly thread disable_cqbwalk();
  }
}

forest_escape_autosave() {
  flag_wait("player_is_out_of_ambush_zone");

  autosave_by_name("into_the_forest");
}

forest_mortar_playerkill() {
  wait 3;

  if(isDefined(level.curAutoSave) && level.curAutoSave >= 3) {
    wait 5;
  }

  if(!flag("player_is_out_of_ambush_zone")) {
    flag_clear("can_save");

    thread mortar_in_face_killplayer();
  }
}

forest_ambush_rpg_guys() {
  array_spawn_function_targetname("forest_defender_rpg_ambush", ::forest_ambush_rpg_guys_init);

  flag_wait("deploy_rpg_ambush");

  trig = getent("forest_defender_rpg_ambush_activator", "targetname");
  trig notify("trigger");
}

forest_ambush_rpg_guys_init() {
  self endon("death");

  flag_wait_any("approaching_house", "stop_smokescreens");

  wait randomfloatrange(2, 4.25);

  ent = getent("futilejeep_javelin_sourcepoint1", "targetname");

  ent thread play_sound_on_entity("weap_cheytac_fire_special");

  self kill();
}

forest_attackers() {
  flag_wait("bouncing_betty_done");

  if(!flag("ambush_complete")) {
    wait 10;
  }

  trig = getent("forest_spawn_activator", "targetname");
  trig notify("trigger");
}

forest_enemy_deathmonitor_init() {
  array_spawn_function_targetname("forest_defender", ::forest_enemy_deathmonitor);
  array_spawn_function_targetname("forest_defender", ::forest_enemy_groundlevel_magicsnipe_cleanup);
}

forest_ghillie_reveal() {
  flag_wait("spawn_first_ghillies");

  thread ghillie_spawn("early_sniper");
}

first_smoke_screen() {
  level endon("smokepot1");

  flag_wait("smoke_screen_activated");

  smoke_pots = getEntArray("smokepot1", "targetname");

  smoke_pots = array_randomize(smoke_pots);

  while(1) {
    foreach(smoke_pot in smoke_pots) {
      wait 5;
      smoke_pot thread smokepot();
      level.activeSmokePots++;
      thread forest_smokepot_timer();
    }

    wait 15;
  }
}

forest_smoke_fight() {
  flag_wait("smokepot1");

  thread prowler_spawn();
}

forest_smoke_screens() {
  flag_wait("smoke_screen_activated");

  thread forest_smokepot1();
  thread forest_smokepot2();
  thread forest_smokepot3();
}

heli_tweak(heliName) {
  player_heli_tweak_observe = getent("heli_tweak", "targetname");
  level.player teleport_ent(player_heli_tweak_observe);

  heli = spawn_vehicle_from_targetname_and_drive(heliName);
}

house_approach_autosave() {
  flag_wait("approaching_house");

  thread autosave_by_name("approaching_house");
}

house_arrival_autosave() {
  flag_wait("autosave_housearrival");

  thread autosave_by_name("arrival_house");
}

house_arrival_aisettings() {
  level waittill_any("breaching_number_0", "breaching_number_1", "breaching_number_2");

  battlechatter_off("allies");
  battlechatter_off("axis");

  level.ghost.baseAccuracy = 1000000;
  level.ozone.baseAccuracy = 1000000;
  level.scarecrow.baseAccuracy = 1000000;
}

house_approach_jeepassault() {
  flag_wait("deploy_house_defense_jeeps");

  jeep1 = spawn_vehicle_from_targetname_and_drive("house_defense_jeep1_frontyard");
  jeep2 = spawn_vehicle_from_targetname_and_drive("house_defense_jeep2_frontyard");
}

house_approach_dialogue() {
  flag_wait("house_approach_dialogue");

  level.ghost dialogue_queue("est_gst_clearperimieter");

  battlechatter_off("allies");

  flag_wait("house_perimeter_softened");

  level.ghost dialogue_queue("est_gst_breachnclear");

  SoundSetTimeScaleFactor("Announcer", 0);

  level.fixednodesaferadius_default = 64;

  level.ghost.fixednodesaferadius = 64;
  level.scarecrow.fixednodesaferadius = 64;
  level.ozone.fixednodesaferadius = 64;
}

house_approach_futilejeep() {
  flag_wait("deploy_futile_jeep");

  battlechatter_off("allies");
  battlechatter_off("axis");

  thread radio_dialogue("est_snp1_trucksleaving");

  wait 1;

  doomedJeep1 = spawn_vehicle_from_targetname_and_drive("futile_escape_jeep1");
  doomedJeep1 godon();

  doomedJeep2 = spawn_vehicle_from_targetname_and_drive("futile_escape_jeep2");
  doomedJeep2 godon();

  wait 3;

  level.ghost thread dialogue_queue("est_gst_trucksgetaway");

  wait 1.5;

  wait 2.0;

  thread radio_dialogue("est_snp1_firingjavelin");

  wait 2;

  doomedJeep1 thread house_approach_futilejeep_javelin("futilejeep_javelin_sourcepoint1");

  level.ghost thread dialogue_queue("est_gst_dangerclose");

  wait 1;

  level.ghost thread dialogue_queue("est_gst_bulletproofed");

  wait 2;

  doomedJeep1 godoff();

  wait 1;

  thread radio_dialogue("est_snp1_twoaway");

  doomedJeep2 thread house_approach_futilejeep_javelin("futilejeep_javelin_sourcepoint2");

  wait 3;

  doomedJeep2 godoff();

  wait 2.75;

  thread radio_dialogue("est_snp1_neutralized");

  wait 2;

  flag_set("futilejeeps_destroyed");
}

house_approach_futilejeep_javelin(launchEntName) {
  fakeJavLauncher = getent(launchEntName, "targetname");

  newMissile = MagicBullet("javelin", fakeJavLauncher.origin, self.origin);
  newMissile thread javelin_earthquake(self);
  newMissile Missile_SetTargetEnt(self);
  newMissile Missile_SetFlightmodeTop();
}

javelin_earthquake(targetObj) {
  dummy = spawn("script_origin", self.origin);
  dummy linkto(self);
  self waittill("death");
  earthquake(1.2, 1.5, dummy.origin, 1600);
  radiusdamage(targetObj.origin, 128, 25000, 25000);
  wait(0.05);
  dummy delete();
}

house_friendly_rush() {
  flag_wait("futilejeeps_destroyed");

  thread radio_dialogue("est_snp1_decoys");

  wait 6;

  if(!flag("house_perimeter_softened")) {
    level.fixednodesaferadius_default = 1040;
  }

  houseAttackTrig = getent("house_approach_friendlytrigger", "targetname");
  houseAttackTrig notify("trigger");

  wait 1;

  flag_set("deploy_house_defense_jeeps");

  wait 2.15;

  level.ghost dialogue_queue("est_gst_advancingonhouse");

  battlechatter_on("allies");
  battlechatter_on("axis");
}

house_enemy_cleanup_tracker() {
  flag_wait("house_interior_breaches_done");

  wait 2.5;

  enemies = [];
  enemies = getaiarray("axis");

  level.enemyPop = enemies.size;

  volume = getent("enemy_presence_volume", "targetname");

  if(level.enemyPop) {
    foreach(enemy in enemies) {
      enemy thread house_enemy_deathmonitor();

      if(enemy isTouching(volume)) {
        enemy.goalradius = 128;
        enemy thread house_enemy_cleanup_nav();
      } else {
        enemy kill();
      }
    }
  } else {
    flag_set("all_enemies_killed_up_to_house_capture");
  }
}

house_enemy_cleanup_nav() {
  self endon("death");
  wait randomfloatrange(7, 10);
  self setgoalentity(level.player);
}

house_enemy_deathmonitor() {
  self waittill("death");

  level.enemyPop--;

  if(!level.enemyPop) {
    flag_set("all_enemies_killed_up_to_house_capture");
  }
}

house_clearing_save_mainfloor() {
  flag_wait("save_the_game_indoors");
}

house_clearing_save_basement() {
  flag_wait("save_the_game_downstairs");
}

house_backwards_door_handling() {
  fakedoor = getent("fake_backwards_door", "targetname");
  fakedoor_clip = getent("fake_backwards_door_clip", "targetname");

  if(!flag("skip_breachandclear")) {
    level waittill_any("breaching_number_0", "breaching_number_1", "breaching_number_2");
  }

  wait 2;

  fakedoor delete();
  fakedoor_clip delete();
}

house_briefing_scarecrow() {
  level.scarecrow endon("death");

  level.scarecrow.voice = "taskforce";
  level.scarecrow.countryID = "TF";

  level.scarecrow disable_ai_color();
  level.scarecrow disable_cqbwalk();
  level.scarecrow.goalradius = 16;

  if(!flag("skip_house_defense_dialogue")) {
    animStartPoint = getstruct("scarecrow_photonode", "targetname");
    animStartPoint anim_generic_reach(level.scarecrow, "estate_house_photoshoot");
    animStartPoint thread anim_generic_run(level.scarecrow, "estate_house_photoshoot");

    level.scarecrow waittillmatch("single anim", "camera");

    camera = spawn("script_model", (0, 0, 0));
    camera setModel("electronics_camera_pointandshoot_animated");
    camera linkto(level.scarecrow, "tag_inhand", (0, 0, 0), (0, 0, 0));

    delaythread(10, ::flag_set, "photographs_done");

    level.scarecrow waittillmatch("single anim", "camera");

    camera delete();
  }

  node = getnode("scarecrow_earlydefense_start", "targetname");
  level.scarecrow setgoalnode(node);

  level.scarecrow waittill("goal");

  flag_wait("scarecrow_to_earlydefense_start");

  radio_dialogue("est_scr_inposition");

  level.scarecrow stop_magic_bullet_shield();

  switch (level.gameskill) {
    case 0:
      level.scarecrow.health = 800;
      break;
    case 1:
      level.scarecrow.health = 600;
      break;
    case 2:
      level.scarecrow.health = 300;
      break;
    case 3:
      level.scarecrow.health = 300;
      break;
  }

  level.scarecrow thread tough_friendly_biometrics("scarecrow");
  level.scarecrow thread tough_friendly_kill();

  flag_wait("dsm_compromised");

  level.scarecrow.health = 1;
}

house_briefing_ozone() {
  level.ozone endon("death");

  level.ozone.voice = "taskforce";
  level.ozone.countryID = "TF";

  level.ozone disable_ai_color();
  level.ozone disable_cqbwalk();
  level.ozone.goalradius = 16;

  node = getnode("ozone_housebriefing_start", "targetname");
  level.ozone setgoalnode(node);

  level.ozone waittill("goal");

  flag_wait("ozone_to_earlydefense_start");

  node = getnode("ozone_earlydefense_start", "targetname");
  level.ozone setgoalnode(node);

  level.ozone waittill("goal");

  flag_wait("defense_battle_begins");

  radio_dialogue("est_ozn_readyengage");

  level.ozone stop_magic_bullet_shield();

  switch (level.gameskill) {
    case 0:
      level.ozone.health = 800;
      break;
    case 1:
      level.ozone.health = 600;
      break;
    case 2:
      level.ozone.health = 300;
      break;
    case 3:
      level.ozone.health = 300;
      break;
  }

  level.ozone thread tough_friendly_biometrics("ozone");
  level.ozone thread tough_friendly_kill();

  flag_wait("dsm_compromised");

  level.ozone.health = 1;
}

house_briefing_ghosttalk() {
  animStartPoint = getstruct("ghost_talknode", "targetname");
  animStartPoint anim_generic_reach(level.ghost, "estate_ghost_radio");
  animStartPoint thread anim_generic_run(level.ghost, "estate_ghost_radio");
}

house_briefing_dialogue() {
  flag_wait("all_enemies_killed_up_to_house_capture");

  battlechatter_off("allies");
  battlechatter_off("axis");

  wait 5;

  thread autosave_by_name("house_briefing_sequence");

  level.ghost.voice = "taskforce";
  level.ghost.countryID = "TF";

  thread house_briefing_scarecrow();
  thread house_briefing_ozone();

  level.ghost disable_ai_color();
  thread house_briefing_ghosttalk();

  level.ghost waittillmatch("single anim", "dialogue");

  flag_set("ghost_gives_regroup_order");

  thread radio_dialogue("est_gst_regroup");

  level.ghost waittillmatch("single anim", "dialogue");

  level.ghost thread dialogue_queue("est_gst_photos");

  level.ghost waittillmatch("single anim", "dialogue");

  thread radio_dialogue("est_scr_rogerthat");

  level.ghost waittillmatch("single anim", "dialogue");

  level.ghost thread dialogue_queue("est_gst_nosign");

  level.ghost waittillmatch("single anim", "dialogue");

  thread radio_dialogue("est_pri_atleast50");

  level.ghost waittillmatch("single anim", "dialogue");

  level.ghost thread dialogue_queue("est_gst_goldmine");

  level.ghost waittillmatch("single anim", "dialogue");

  thread radio_dialogue("est_shp_everything");

  level.ghost waittillmatch("single anim", "dialogue");

  level.ghost thread dialogue_queue("est_gst_alreadyonit");

  level.ghost waittillmatch("single anim", "dialogue");

  thread radio_dialogue("est_shp_eta5mins");

  level.ghost waittillmatch("single anim", "dialogue");

  level.ghost thread dialogue_queue("est_gst_starttransfer");

  flag_set("house_briefing_is_over");
  flag_set("dsm_ready_to_use");

  level.ghost waittillmatch("single anim", "dialogue");

  level.ghost dialogue_queue("est_gst_rearsecurity");

  flag_set("ozone_to_earlydefense_start");

  node = getnode("ghost_cover_front", "targetname");
  level.ghost setgoalnode(node);
  level.ghost clear_run_anim();

  radio_dialogue("est_ozn_onmyway");

  wait 2;

  radio_dialogue("est_pri_searching");

  radio_dialogue("est_pri_gettingcloser");

  radio_dialogue("est_pri_goingsilent");

  flag_set("house_briefing_dialogue_done");

  thread defense_download_nag();

  wait 10;

  node = getnode("ghost_earlydefense_start", "targetname");
  level.ghost setgoalnode(node);
}

defense_intro() {
  flag_wait("download_started");

  if(!flag("skip_house_defense_dialogue")) {
    wait 3;

    flag_wait("house_briefing_dialogue_done");

    radio_dialogue("est_ozn_stockup");

    flag_wait("photographs_done");

    radio_dialogue("est_gst_withintel");

    radio_dialogue("est_gst_weaponscache");

    flag_set("scarecrow_to_earlydefense_start");
  }

  flag_set("defense_battle_begins");

  autosave_by_name("defense_started");

  wait 1;

  level.ghost.baseAccuracy = 1;
  level.ozone.baseAccuracy = 1;
  level.scarecrow.baseAccuracy = 1;

  level.ghost.threatbias = -1000;

  level.ghost.voice = "taskforce";
  level.ghost.countryID = "TF";

  level.scarecrow.voice = "taskforce";
  level.scarecrow.countryID = "TF";

  level.ozone.voice = "taskforce";
  level.ozone.countryID = "TF";

  battlechatter_on("allies");
  battlechatter_on("axis");
}

defense_download_nag() {
  level endon("download_started");

  while(!flag("download_started")) {
    wait 10;

    radio_dialogue("est_gst_filesoff");

    wait 8;

    radio_dialogue("est_gst_startdownload");

    wait 30;
  }
}

ending_blur_cycler() {
  level endon("stop_blur_cycler");

  while(1) {
    level.player endingBlurView(3.6, 2);
    level.player endingBlurView(1, 0.8);
    level.player endingBlurView(2, 1);
    level.player endingBlurView(1, 0.7);
    level.player endingBlurView(3, 1.1);
  }
}

endingBlurView(blur, timer) {
  level endon("stop_blur_cycler");

  self notify("blurview_stop");
  self endon("blurview_stop");
  self SetBlurForPlayer(blur, timer);
  wait(0.05);
  self SetBlurForPlayer(0, timer);
}

ending_passing_out(overlay) {
  level.player setBlurForPlayer(12, 3);

  overlay grayOut(0.4, 8);
  overlay restoreVision(0.4, 2);

  overlay grayOut(0.5, 9);
  overlay restoreVision(0.5, 1.8);

  overlay grayOut(0.4, 12);
  overlay restoreVision(0.4, 2.2);

  overlay grayOut(0.5, 12);
  overlay restoreVision(0.5, 2.2);

  thread radio_dialogue("est_gst_hanginthere");
}

ending_eq_reset() {
  wait 3;

  if(level.eq_track[level.eq_main_track] == "") {
    maps\_ambient::deactivate_index(level.eq_main_track);
  } else {
    thread maps\_ambient::use_eq_settings(level.eq_track[level.eq_main_track], level.eq_main_track);
  }

  if(level.reverb_track == "") {
    maps\_ambient::deactivate_reverb();
  } else {
    thread maps\_ambient::use_reverb_settings(level.reverb_track);
  }
}

ending_attackers() {
  ending_attackers = getEntArray("ending_attacker", "targetname");
  array_thread(ending_attackers, ::ending_attackers_spawn);

  wait 1;

  leftovers = getaiarray("axis");
  foreach(guy in leftovers) {
    guy.grenadeammo = 0;
    guy.baseaccuracy = 0.2;
    guy add_damage_function(::ending_attackers_deathmonitor);
  }
}

ending_attackers_deathmonitor(damage, attacker, direction_vec, point, type, modelName, tagName) {
  if(!isalive(self)) {
    if(attacker == level.player) {
      level.ending_attacker_deaths++;

      if(level.gameskill == 0) {
        level.player.attackeraccuracy = 0;
        flag_set("drag_sequence_killcount_achieved");
      }

      if(level.gameskill == 1) {
        level.player.attackeraccuracy = 0;
        flag_set("drag_sequence_killcount_achieved");
      }

      if(level.gameskill == 2) {
        if(level.ending_attacker_deaths > 1) {
          level.player.attackeraccuracy = 0;
          flag_set("drag_sequence_killcount_achieved");
        }
      }

      if(level.gameskill == 3) {
        if(level.ending_attacker_deaths > 1) {
          level.player.attackeraccuracy = 0;
          flag_set("drag_sequence_killcount_achieved");
        }
      }
    }
  }
}

ending_attackers_spawn() {
  guy = self stalingradspawn();
  if(isDefined(guy)) {
    guy endon("death");

    wait 1;
    guy.grenadeammo = 0;
    guy.baseaccuracy = 0.2;
  }
}

ending_drag_damagecheck() {
  level.player.attackeraccuracy = 0;

  wait 5;

  level.player.attackeraccuracy = 0.15;

  wait 3;

  level.player.attackeraccuracy = 0.2;
}

ending_drag_slackerfail() {
  level endon("ending_normal_death");
  level endon("drag_sequence_killcount_achieved");

  flag_wait("drag_sequence_slacker_check");

  if(!flag("drag_sequence_killcount_achieved")) {
    level notify("ending_slacker_death");

    level.player DoDamage(25 / level.player.damagemultiplier, level.player.origin);
    wait 1.5;

    level.player DoDamage(35 / level.player.damagemultiplier, level.player.origin);
    wait 0.5;

    level.player DoDamage(25 / level.player.damagemultiplier, level.player.origin);
    wait 2.5;

    level.player DoDamage(30 / level.player.damagemultiplier, level.player.origin);
    wait 0.15;
    level.player DoDamage(30 / level.player.damagemultiplier, level.player.origin);
    wait 0.25;
    level.player DoDamage(15 / level.player.damagemultiplier, level.player.origin);
    wait 0.2;
    level.player DoDamage(15 / level.player.damagemultiplier, level.player.origin);

    wait 3;

    level.player DoDamage(45 / level.player.damagemultiplier, level.player.origin);
    wait 0.15;
    level.player DoDamage(75 / level.player.damagemultiplier, level.player.origin);
    wait 0.15;
    level.player DoDamage(85 / level.player.damagemultiplier, level.player.origin);

    thread ending_drag_failure();
  }
}

ending_drag_failure() {
  level.player takeallweapons();

  level.player.ignoreme = true;
  level.player shellshock("estate_bouncingbetty", 9);

  setDvar("ui_deadquote", &"ESTATE_FAKE_DEATH_QUOTE");
  missionfailedwrapper();
}

ending_player_breathing() {
  level endon("stop_player_breathing");

  while(1) {
    level.player play_sound_on_entity("breathing_hurt");
    wait(0.1 + RandomFloat(0.8));
  }
}

ending_moments() {
  flag_wait("play_ending_sequence");

  thread ending_shadow_fader();

  overlay = undefined;

  if(flag("test_ending")) {
    thread maps\_mortar::bog_style_mortar_on("2");
  }

  if(!flag("test_ending_body_toss")) {
    thread ending_thunderone_heli_sequence();
    thread ending_shadowops_heli_sequence();

    thread battlechatter_off("allies");
    thread battlechatter_off("axis");
  }

  overlay = newHudElem();
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignX = "left";
  overlay.alignY = "top";
  overlay.horzAlign = "fullscreen";
  overlay.vertAlign = "fullscreen";
  overlay.alpha = 0;
  overlay.sort = 1;

  overlay blackOut(0.05, 6);

  if(!flag("test_ending_body_toss")) {
    level.player FreezeControls(true);

    level.player AllowProne(false);
    level.player AllowCrouch(false);
    level.player AllowStand(true);

    thread maps\_ambient::use_eq_settings("deathsdoor", level.eq_main_track);
    thread maps\_ambient::use_reverb_settings("deathsdoor");
    thread ending_blur_cycler();

    level.player shellshock("estate_bouncingbetty", 11);

    flag_set("begin_ending_music");

    SetSavedDvar("hud_showStance", "0");
    level.player setstance("stand");

    node = getstruct("ghost_dragnode", "targetname");

    playerview = spawn_anim_model("playerview");
    playerview.angles = (0, 0, 0);
    playerview hide();

    level.player disableweapons();

    level.player takeallweapons();

    if(!flag("test_ending_body_toss")) {
      level.ghost.attackeraccuracy = 0;
    }

    level.player.attackeraccuracy = 0;
    level.player.ignorerandombulletdamage = 1;

    node anim_first_frame_solo(level.ghost, "estate_ending_drag");
    node anim_first_frame_solo(playerview, "estate_ending_drag");
    level.player PlayerLinkToDelta(playerview, "tag_player", 1, 30, 30, 30, 3);

    node anim_first_frame_solo(level.ghost, "estate_ending_drag");

    tag_origin = spawn_tag_origin();
    tag_origin linkto(playerview, "tag_player", (0, 0, 0), (0, 0, 0));
    level.player playersetgroundreferenceent(tag_origin);

    wait 1;

    thread ending_attackers();

    level.player giveweapon("ak47_woodland_grenadier");

    wait 2;

    thread ending_player_breathing();
    level.player FreezeControls(false);
    level.player LerpViewAngleClamp(0, 0, 0, 3, 3, 5, 2);

    overlay thread restoreVision(3, 0);

    autosave_by_name("drag_started");

    thread ending_redsmoke_sequence();

    thread ending_mortarhit_ghost_sequence();

    node thread anim_single_solo(playerview, "estate_ending_drag");
    node anim_single_solo(level.ghost, "estate_ending_drag");

    level.player LerpViewAngleClamp(1, 1, 1, 30, 30, 30, 5);
    level.player enableweapons();

    level.player switchToWeapon("ak47_woodland_grenadier");

    level.player thread ending_drag_damagecheck();

    if(!flag("test_ending_body_toss") && !flag("test_ending")) {
      level.ghost stop_magic_bullet_shield();
    }

    if(!flag("test_ending_body_toss")) {
      level.ghost delete();
    }

    playerview waittillmatch("single anim", "mortarhit");
    thread ending_mortarhit("ending_mortarhit_1");

    playerview waittillmatch("single anim", "mortarhit");
    thread ending_mortarhit("ending_mortarhit_2");

    level notify("stop_blur_cycler");

    delaythread(2, ::ending_passing_out, overlay);

    playerview waittillmatch("single anim", "mortarhit");
    thread ending_mortarhit("ending_mortarhit_3");
    level.player thread maps\_gameskill::grenade_dirt_on_screen("left");

    playerview waittillmatch("single anim", "mortarhit");
    thread ending_mortarhit("ending_mortarhit_4");
    playerview waittillmatch("single anim", "helicopterbuzz");

    playerview waittillmatch("single anim", "gettingfuzzy");

    flag_set("enter_the_littlebirds");

    thread maps\_mortar::bog_style_mortar_off("2");

    overlay blackOut(3, 12);

    level.player delaycall(3, ::takeallweapons);

    level.player FreezeControls(true);

    SetSavedDvar("ui_hidemap", 1);
    SetSavedDvar("compass", "0");
    SetSavedDvar("ammoCounterHide", "1");

    enemies = getaiarray("axis");
    foreach(enemy in enemies) {
      enemy kill();
    }

    wait 1;
  }

  array_thread(getEntArray("ending_actors", "targetname"), ::add_spawn_function, ::ending_actors_think);
  activate_trigger("ending_actors", "target");
  wait 0.1;

  gasolineGuy = undefined;
  deadGhost = undefined;

  node = getstruct("ending_chopper_node", "targetname");
  guys = [];
  foreach(member in level.ending_actors) {
    if(member.script_noteworthy == "gasolineGuy") {
      gasolineGuy = member;
      gasolineGuy hide();
    } else
    if(!flag("test_alt_ending") && member.script_noteworthy == "alt_ending_dead_guy") {
      continue;
    } else
    if(flag("test_alt_ending") && member.script_noteworthy == "alt_ending_dead_guy") {
      member.script_noteworthy = "ghost_ending_dead";
      member.animname = "ghost_ending_dead";
      deadGhost = member;
      deadGhost hide();
    } else
    if(flag("test_alt_ending") && member.script_noteworthy == "ghost_ending_dead") {
      continue;
    } else
    if(!flag("test_alt_ending") && member.script_noteworthy == "ghost_ending_dead") {
      deadGhost = member;
      deadGhost hide();
    } else
    if(!flag("test_alt_ending") && member.script_noteworthy == "alt_ending_guy") {
      continue;
    } else
    if(flag("test_alt_ending") && member.script_noteworthy == "alt_ending_guy") {
      member.script_noteworthy = "ghost_ending";
      member.animname = "ghost_ending";
      guys[guys.size] = member;
    } else
    if(flag("test_alt_ending") && member.script_noteworthy == "ghost_ending") {
      continue;
    } else {
      guys[guys.size] = member;
    }
  }

  if(flag("test_with_pavelow_already_in_place") || flag("test_ending_body_toss")) {
    pavelow = spawn_vehicle_from_targetname("final_pavelow_liftoff_1");
    pavelow.animname = "pavelow";
    level.pavelow = pavelow;
  } else {
    level.pavelow delete();

    pavelow = spawn_vehicle_from_targetname("animated_pavelow");
    pavelow.animname = "pavelow";

    level.pavelow = pavelow;
  }

  level.player takeallweapons();
  playerview = spawn_anim_model("playerview");
  node anim_first_frame_solo(playerview, "estate_ending_part1");
  level.player PlayerLinkToDelta(playerview, "tag_player", 1, 10, 10, 10, 2);

  playerBody = spawn_anim_model("body_ending");
  node anim_first_frame_solo(playerBody, "estate_ending_part1");

  node anim_first_frame_solo(pavelow, "estate_ending_part1");

  tag_origin = spawn_tag_origin();
  tag_origin linkto(playerview, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player playersetgroundreferenceent(tag_origin);

  ghost = level.ending_actors["ghost_ending"];

  shepherd = level.ending_actors["shepherd_ending"];
  shepherd gun_remove();

  if(!flag("test_ending_body_toss")) {
    wait 2;

    overlay delayThread(0.5, ::restoreVision, 3, 0);

    level.player delayCall(0.5, ::FreezeControls, false);

    level.player LerpViewAngleClamp(1, 1, 1, 3, 3, 3, 3);

    level.player setBlurForPlayer(0, 16);

    flag_set("made_it_to_lz");

    node thread anim_single(guys, "estate_ending_part1");
    node thread anim_single_solo(playerview, "estate_ending_part1");
    node thread anim_single_solo(pavelow, "estate_ending_part1");
    node thread anim_single_solo(playerBody, "estate_ending_part1");

    thread ending_eq_reset();

    ghost thread dialogue_queue("est_gst_comeongetup");

    ghost thread dialogue_queue("est_gst_getupgetup");

    level.player LerpViewAngleClamp(7, 1, 1, 30, 30, 30, 15);

    level.endingTimeRef = gettime();

    thread ending_shadow_fader_mover(0.12, 20, 14);

    level.ending_actors["guy1_ending"] hide();
    level.ending_actors["guy2_ending"] hide();

    thread temp_shepherd_dialogue(shepherd, ghost);

    shepherd waittill_notetrack_or_damage("pistol_pullout");
    pistol = spawn("script_model", (0, 0, 0));
    pistol setModel("weapon_colt_anaconda");
    pistol linkto(shepherd, "tag_weapon_right", (0, 0, 0), (0, 0, 0));

    level.player LerpViewAngleClamp(1, 1, 1, 20, 20, 10, 2);

    level.ending_actors["guy1_ending"] show();
    level.ending_actors["guy2_ending"] show();

    shepherd waittill_notetrack_or_damage("shepherd_fire2");
    pistol playSound("weap_deserteagle_fire_plr");
    playFXOnTag(getfx("anaconda_muzzle_flash"), pistol, "tag_flash");

    level.player PlayRumbleOnEntity("shepherd_pistol");

    level.player delaycall(1.3, ::PlayRumbleOnEntity, "shot_collapse");

    level.player SetNormalHealth(1);
    gunpos = shepherd getEye();
    level.player DoDamage(99 / level.player.damagemultiplier, gunpos);

    level.player delayThread(0.3, ::ending_player_fullhealth);

    level notify("stop_player_breathing");

    SetSavedDvar("g_friendlyNameDist", 0);

    if(flag("no_slow_mo")) {
      delaythread(1.5, ::ending_slowmo, 3);
    }

    shepherd waittill_notetrack_or_damage("shepherd_fire1");
    pistol playSound("weap_cheytac_fire_plr");
    playFXOnTag(getfx("anaconda_muzzle_flash"), pistol, "tag_flash");

    shepherd waittill_notetrack_or_damage("pistol_putaway");
    pistol delete();

    level.player delaycall(0.8, ::PlayRumbleOnEntity, "dsm_rummage");

    shepherd waittill_notetrack_or_damage("dsm_pullout");
    dsm = spawn("script_model", (0, 0, 0));
    dsm setModel("mil_wireless_dsm_small");
    dsm linkto(shepherd, "tag_inhand", (0, 0, 0), (0, 0, 0));

    shepherd waittill_notetrack_or_damage("dsm_putaway");
    dsm delete();

    overlay thread blackOut(7, 6);

    wait 8;
  }

  throwingGuy = level.ending_actors["guy1_ending"];
  throwingHelperGuy = level.ending_actors["guy2_ending"];

  node = getstruct("ending_chopper_node2", "targetname");

  guys = [];
  guys[guys.size] = throwingGuy;
  guys[guys.size] = throwingHelperGuy;

  array_thread(level.ending_actors, ::gun_remove);

  node anim_first_frame_solo(playerview, "estate_ending_part2");
  level.player PlayerLinkToDelta(playerview, "tag_player", 1, 10, 10, 5, 5);

  node anim_first_frame_solo(playerBody, "estate_ending_part2");

  overlay thread restoreVision(3, 0);

  level.player LerpViewAngleClamp(1, 1, 1, 20, 20, 10, 0);

  thread ending_gasoline_sequence(gasolineGuy, shepherd, overlay);

  node thread anim_single_solo(playerview, "estate_ending_part2");
  node thread anim_single_solo(playerBody, "estate_ending_part2");
  node thread anim_single(guys, "estate_ending_part2");

  wait 1;

  flag_set("begin_overlapped_gasoline_sequence");

  wait 1.8;

  level.player PlayRumbleOnEntity("bodytoss_impact");

  wait 1.3;

  playerBody hide();

  level.ending_actors["ghost_ending"] hide();
  deadGhost show();

  guys[guys.size] = deadGhost;

  node anim_first_frame(guys, "estate_ending_part2_2ndbody");
  node thread anim_single(guys, "estate_ending_part2_2ndbody");

  throwingGuy waittill_notetrack_or_damage("ghost_throw_release");

  if(!flag("no_slow_mo")) {
    thread ending_slowmo(10.5);
  }

  thread ending_shadow_fader_mover(0.05, 2, 1, 0.1);

  wait 2.2;

  overlay thread blackOut(0.8, 3);

  thread ending_shadow_fader_mover(0.12, 2, 1, 0.1);

  wait 0.8;

  throwingGuy hide();
  throwingHelperGuy hide();

  gasolineGuy show();
  shepherd show();
  gasolineGuy attach("accessories_gas_canister_highrez", "tag_inhand");

  overlay thread restoreVision(5, 0);
  setBlur(3, 3);
  wait 3;
  setBlur(0, 3);
}

ending_player_fullhealth() {
  self SetNormalHealth(1);
}

ending_pavelow_fakearrival() {
  level endon("finish_line");

  flag_wait("point_of_no_return");

  level.pavelow = spawn_vehicle_from_targetname("final_pavelow_liftoff_1");
  level.pavelow.animname = "pavelow";

  level.pavelow vehicle_setspeed(15);

  node1 = getstruct(level.pavelow.target, "targetname");
  level.pavelow setvehgoalpos(node1.origin, 0);

  level.pavelow waittill_any("goal", "near_goal");

  node2 = getstruct(node1.target, "targetname");
  level.pavelow setvehgoalpos(node2.origin, 0);

  level.pavelow waittill_any("goal", "near_goal");

  node3 = getstruct(node2.target, "targetname");
  level.pavelow setvehgoalpos(node3.origin, 1);

  level.pavelow waittill_any("goal", "near_goal");

  if(!flag("finish_line")) {
    thread mortar_in_face_killplayer();
  }
}

ending_thunderone_heli_sequence() {
  flag_wait("thunderone_heli");

  heli = spawn_vehicle_from_targetname("ending_treecutter_heli_1");

  heli vehicle_setspeed(12);

  node1 = getstruct(heli.target, "targetname");
  heli setvehgoalpos(node1.origin, 0);

  heli setTargetYaw(195);

  heli waittill("goal");

  heli vehicle_setspeed(8);

  wait 0.6;

  heli setTargetYaw(210);

  node2 = getstruct(node1.target, "targetname");
  heli setvehgoalpos(node2.origin, 1);

  heli waittill_any("goal", "near_goal");

  wait 1;

  node3 = getstruct(node2.target, "targetname");
  heli setvehgoalpos(node3.origin, 0);

  wait 0.5;

  heli setTargetYaw(190);

  heli waittill_any("goal", "near_goal");

  wait 2;

  node4 = getstruct(node3.target, "targetname");
  heli setvehgoalpos(node4.origin);

  heli vehicle_setspeed(50);

  heli clearTargetYaw();
}

ending_shadow_fader() {
  level.shadowfader = spawn("script_origin", (0.25, 0, 0));

  while(1) {
    SetSavedDvar("sm_sunSampleSizeNear", level.shadowfader.origin[0]);
    wait 0.05;
  }
}

ending_shadow_fader_mover(setting, fadeTime, accelTime, decelTime) {
  if(!isDefined(setting)) {
    setting = 0.25;
  }

  assertEX(setting <= 0.25, "Specified value for sm_sunSampleSizeNear is out of range.");
  assertEX(setting >= 0.015625, "Specified value for sm_sunSampleSizeNear is out of range.");

  if(!isDefined(fadeTime)) {
    fadeTime = 1;
  }

  if(!isDefined(accelTime)) {
    accelTime = 1;
  }

  if(!isDefined(decelTime)) {
    decelTime = 1;
  }

  level.shadowfader MoveTo((setting, 0, 0), fadeTime, accelTime, decelTime);
}

ending_shadowops_heli_sequence() {
  flag_wait("enter_the_littlebirds");

  heli1 = delayThread(1, ::spawn_vehicle_from_targetname_and_drive, "ending_shadowops_heli_1");
  heli2 = delayThread(3, ::spawn_vehicle_from_targetname_and_drive, "ending_shadowops_heli_2");
  heli3 = delayThread(4, ::spawn_vehicle_from_targetname_and_drive, "ending_shadowops_heli_3");
  heli4 = delayThread(2, ::spawn_vehicle_from_targetname_and_drive, "ending_shadowops_heli_4");

  trig = getent("ending_shouter_trig", "targetname");
  trig waittill("trigger");

  speakers = getEntArray("ending_shouter", "targetname");
  array_randomize(speakers);

  foreach(index, ent in speakers) {
    if(index > 2) {
      break;
    }

    if(index == 0) {
      ent play_sound_on_entity("est_tf2_coverthem");
    }

    if(index == 1) {
      ent play_sound_on_entity("est_tf2_spreadout");
    }

    if(index == 2) {
      ent play_sound_on_entity("est_tf1_gogogo");
    }

    if(index == 3) {
      ent play_sound_on_entity("est_tf3_straferidgeline");
    }

    if(index == 4) {
      ent play_sound_on_entity("est_tf4_rogerthat");
    }

    if(index == 5) {
      ent play_sound_on_entity("est_tf1_goldeagle");
    }
  }
}

temp_shepherd_dialogue(shepherd, ghost) {
  wait 6.5;

  thread radio_dialogue("est_hp2_watchforsnipers");

  wait 10.5;

  ghost dialogue_queue("est_gst_wegotit");
  wait 0.85;

  wait 1.5;

  wait 12;

  radio_dialogue("est_hp2_sanitized");

  radio_dialogue("est_hp1_holdingpattern");
}

ending_redsmoke_sequence() {
  smokepot = getstruct("redsmoke", "targetname");
  playFX(getfx("redsmoke"), smokepot.origin);

  radio_dialogue("est_gst_gotyouroach");

  radio_dialogue("est_gst_redsmoke");

  radio_dialogue("est_fp1_visual");

  flag_set("drag_sequence_slacker_check");

  radio_dialogue("est_gst_clearedhot");

  radio_dialogue("est_fp1_clearedhot");

  flag_set("thunderone_heli");

  radio_dialogue("est_hp1_gunsgunsguns");

  wait 9;

  radio_dialogue("est_hp1_rocketattck");

  radio_dialogue("est_hp2_hitemhard");

  radio_dialogue("est_hp1_imonit");

  radio_dialogue("est_hp1_linedup");
}

ending_mortarhit_ghost_sequence() {
  thread ending_mortarhit("ending_mortarhit_a");

  wait 1;
  thread ending_mortarhit("ending_mortarhit_b");

  wait 0.75;
  thread ending_mortarhit("ending_mortarhit_c");
  level.player thread maps\_gameskill::grenade_dirt_on_screen("right");

  wait 0.6;
  thread ending_mortarhit("ending_mortarhit_d");

  wait 1;
  thread ending_mortarhit("ending_mortarhit_e");

  wait 0.5;
  thread ending_mortarhit("ending_mortarhit_f");

  wait 0.25;
  thread ending_mortarhit("ending_mortarhit_g");

  wait 0.6;
  thread ending_mortarhit("ending_mortarhit_h");
  level.player thread maps\_gameskill::grenade_dirt_on_screen("left");
  wait 0.45;
  thread ending_mortarhit("ending_mortarhit_i");
}

ending_mortarhit(mortarname) {
  hit = getstruct(mortarname, "targetname");
  hit play_sound_in_space(level.scr_sound["mortar"]["incomming"]);

  earthquake(0.5, 1.4, level.player.origin, 2000);
  playRumbleOnPosition("artillery_rumble", hit.origin);
  hit thread play_sound_in_space(level.scr_sound["mortar"]["dirt"]);
  playFX(level._effect["mortar"]["dirt"], hit.origin);
}

temp_music_ending_delay() {
  if(!flag("no_slow_mo")) {
    musicStop(6);
    wait 7;
    musicPlay("estate_betrayal");
  } else {
    musicStop(1);
    wait 1.5;
    musicPlay("estate_betrayal");
  }
}

ending_gasoline_sequence(gasolineGuy, shepherd, overlay) {
  flag_wait("begin_overlapped_gasoline_sequence");

  thread ending_gasoline_price_radio();

  node = getstruct("ending_chopper_node2", "targetname");

  guys = [];
  guys[guys.size] = gasolineGuy;
  guys[guys.size] = shepherd;

  shepherd thread ending_smoking_fx();

  node = getstruct("ending_chopper_node2", "targetname");
  node thread anim_single(guys, "estate_ending_part3");

  gasolineGuy waittill_notetrack_or_damage("pour_on_player");
  level.player SetWaterSheeting(1, 7);

  gasolineGuy waittill_notetrack_or_damage("pour_on_player");
  level.player SetWaterSheeting(1, 4.0);

  flag_wait("cigar_flicked");

  wait 0.15;

  flag_set("cigar_flareup");

  flyOverHeli = spawn_vehicles_from_targetname("final_pavelow_liftoff_2");
  flyOverHeliNode = getent("final_pavelow_flyover", "targetname");
  flyOverHeli[0] thread set_heli_goal(flyOverHeliNode);

  wait 0.1;

  if(!flag("no_slow_mo")) {
    thread ending_slowmo(140, 0.1);
  }

  wait 0.6;

  playFX(getfx("gasoline_fire_on_player_ignite"), level.player.origin + (-66, 56, 64));
  playFX(getfx("gasoline_fire_on_player"), level.player.origin + (-6, 56, 54));
  playFX(getfx("gasoline_fire_on_player"), level.player.origin + (-116, 56, 64));

  wait 0.1;

  setblur(2, 3);

  wait 1.2;

  heliNode = getent("final_heli_goal_1", "targetname");

  level.pavelow thread set_heli_goal(heliNode);

  wait 0.5;

  wait 1;

  heliNode = getent("final_pavelow_liftoff_exit", "targetname");
  level.pavelow thread set_heli_goal(heliNode);

  overlay thread blackOut(2, 6);

  wait 2;

  flag_set("end_the_mission");
}

ending_gasoline_price_radio() {
  wait 2;

  level.player LerpViewAngleClamp(1, 1, 1, 3, 3, 3, 3);

  wait 5;

  radio_dialogue("est_pri_underattack");
}

ending_smoking_fx() {
  self waittill_notetrack_or_damage("cigar_box_pullout");
  cigarBox = spawn("script_model", (0, 0, 0));
  cigarBox setModel("prop_cigarette_pack");
  cigarBox linkto(self, "j_thumb_le_3", (0, 0, 0), (0, 0, 0));

  wait 0.25;

  cigar = spawn("script_model", (0, 0, 0));
  cigar setModel("prop_price_cigar");
  cigar linkto(self, "tag_inhand", (0, 0, 0), (0, 0, 0));

  self waittill_notetrack_or_damage("lighter_pullout");
  cigarBox delete();

  self waittill_notetrack_or_damage("lighter_on");
  playFXOnTag(getfx("cigar_glow_puff"), cigar, "tag_cigarglow");
  wait 1;
  playFXOnTag(getfx("cigar_smoke_puff"), self, "tag_eye");

  self waittill_notetrack_or_damage("shepherd_exhale");
  playFXOnTag(getfx("cigar_exhale_estate"), self, "tag_eye");

  self waittill_notetrack_or_damage("shepherd_exhale");
  playFXOnTag(getfx("cigar_glow_puff"), cigar, "tag_cigarglow");
  wait 1;
  playFXOnTag(getfx("cigar_smoke_puff"), self, "tag_eye");

  self waittill_notetrack_or_damage("shepherd_exhale");
  playFXOnTag(getfx("cigar_exhale_estate"), self, "tag_eye");

  self waittill_notetrack_or_damage("shepher_flick");
  flag_set("cigar_flicked");

  flag_wait("cigar_flareup");
  playFXOnTag(getfx("cigar_glow"), cigar, "tag_cigarglow");
}

ending_slowmo(duration, speed) {
  slomoLerpTime_in = 0.1;
  slomoLerpTime_out = 1;
  slomobreachplayerspeed = 0.1;
  slomoSpeed = 0.31;

  if(isDefined(speed)) {
    slowmoSpeed = speed;
  }

  slomoDuration = duration;

  slowmo_start();
  slowmo_setspeed_slow(slomoSpeed);
  slowmo_setlerptime_in(slomoLerpTime_in);
  slowmo_lerp_in();

  level.player SetMoveSpeedScale(slomobreachplayerspeed);

  wait slomoDuration * slomoSpeed;

  slowmo_setlerptime_out(slomoLerpTime_out);
  slowmo_lerp_out();
  slowmo_end();
  level.player SetMoveSpeedScale(1.0);
}

ending_actors_think() {
  if(!isDefined(level.ending_actors)) {
    level.ending_actors = [];
  }

  self.animname = self.script_noteworthy;
  self.team = "allies";

  level.ending_actors[self.script_noteworthy] = self;

  self thread magic_bullet_shield();
}

end_of_level() {
  flag_wait("end_the_mission");

  wait 2.6;

  nextmission();
}