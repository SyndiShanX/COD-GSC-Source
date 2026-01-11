/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel1.gsc
*****************************************************/

#include maps\_utility;
#include maps\_anim;
#include common_scripts\utility;
#include maps\_music;
#include maps\_busing;
#using_animtree("generic_human");

main() {
  setsaveddvar("compassMaxRange", 800);
  watersimenable(true);
  thread maps\_dpad_asset::rocket_barrage_init();
  level.enable_weapons = 0;
  level.displaceredshirts = true;
  level.guys_at_berm = 0;
  thread onPlayerConnect();
  thread catch_first_player();
  maps\pel1_fx::main();
  precachemodel("peleliu_aerial_rocket");
  precachemodel("tag_origin");
  precacheitem("type100_smg_nosound");
  precachemodel("viewmodel_usa_player");
  precachemodel("static_peleliu_lvtcrew");
  precachemodel("char_usa_raider_helm2");
  precacheShader("white");
  precacheShader("black");
  precacheshader("hud_icon_air_raid");
  precachemodel("foliage_pacific_snapped_palms01");
  precachemodel("foliage_pacific_snapped_palms04");
  precachemodel("foliage_pacific_snapped_palms04a");
  precachemodel("foliage_pacific_snapped_palms04b");
  precachemodel("foliage_pacific_snapped_palms04c");
  precachemodel("foliage_pacific_trees_palm_anim2");
  precachemodel("vehicle_jap_type97_seta_chassis");
  precachemodel("vehicle_jap_type97_seta_turret");
  precachemodel("vehicle_jap_type97_setb_chassis");
  precachemodel("vehicle_jap_type97_setb_turret");
  precachemodel("vehicle_jap_type97_setc_chassis");
  precachemodel("vehicle_jap_type97_setc_turret");
  precacherumble("tank_rumble");
  precachemodel("radio_jap_bro");
  precachemodel("weapon_jap_katana_long");
  PrecacheShellshock("lvt_exp");
  flag_init("heroes_setup");
  flag_clear("heroes_setup");
  maps\_buffalo::main("vehicle_usa_tracked_lvt4", "buffalo");
  maps\_buffalo::main("vehicle_usa_tracked_lvta2", "buffalo_players");
  maps\_amtank::main("vehicle_usa_tracked_lvta4_amtank", "amtank");
  maps\_aircraft::main("vehicle_usa_aircraft_f4ucorsair_dist", "corsair", 0, 1);
  maps\_aircraft::main("vehicle_usa_aircraft_pel1_f4ucorsair", "corsair");
  maps\_type97::main("vehicle_jap_tracked_type97shinhoto", "type97", undefined, 2);
  maps\_truck::main("vehicle_jap_wheeled_type94", "model94");
  maps\_model3::main("artillery_jap_model3_dist", "model3_pel1");
  character\char_usa_marine_r_rifle::precache();
  character\char_jap_makpel_rifle::precache();
  level.drone_spawnFunction["axis"] = character\char_jap_makpel_rifle::main;
  level.drone_spawnFunction["allies"] = character\char_usa_marine_r_rifle::main;
  maps\_drones::init();
  maps\_bayonet::init();
  maps\_mganim::main();
  add_start("beach", ::start_beach, &"STARTS_PEL1_BEACH");
  add_start("off_lvt", ::start_off_lvt, &"STARTS_PEL1_OFF_LVT");
  add_start("1st_fight", ::start_first_fight, &"STARTS_FIGHT1");
  add_start("2nd_fight_l", ::start_second_fight_left, &"STARTS_FIGHT2");
  add_start("3rd_fight", ::start_third_fight, &"STARTS_FIGHT3");
  add_start("mortars", ::start_mortars, &"STARTS_MORTARS");
  add_start("ending", ::start_ending, &"STARTS_ENDING");
  default_start(::event1_setup);
  maps\_load::main();
  maps\_loadout::set_player_interactive_hands("viewmodel_usa_player");
  maps\_banzai::init();
  maps\_mortarteam::main();
  level.mortar = loadfx("explosions/default_explosion");
  maps\_tree_snipers::main();
  maps\pel1_amb::main();
  maps\pel1_anim::main();
  maps\pel1_status::main();
  level.maxfriendlies = 8;
  level.mortar = level._effect["dirt_mortar"];
  level.rocket_barrage_firing_positions[0] = "rocketbarrage_points1";
  level.rocket_barrage_firing_positions[1] = "rocketbarrage_points2";
  level.mortarcrews = 3;
  level.playerMortar = 1;
  flag_inits();
  spawn_function_init();
  createthreatbiasgroup("players");
  createthreatbiasgroup("heroes");
  createthreatbiasgroup("japanese_turret_gunners");
  setignoremegroup("players", "japanese_turret_gunners");
  setignoremegroup("heroes", "japanese_turret_gunners");
  setignoremegroup("japanese_turret_gunners", "heroes");
  level.heroes = [];
  level.polo = getent("anderson", "script_noteworthy");
  level.heroes[0] = level.polo;
  level.sarge = getent("sarge", "script_noteworthy");
  level.heroes[1] = level.sarge;
  level.sullivan = getent("sullivan", "script_noteworthy");
  level.heroes[2] = level.sullivan;
  level.polo setthreatbiasgroup("heroes");
  level.sarge setthreatbiasgroup("heroes");
  level.sullivan setthreatbiasgroup("heroes");
  level.rocket_barrage_targets = [];
  level.rocket_barrage_targets[0] = getent("big_bunker_damage_area", "targetname");
  level.rocket_barrage_targets[1] = getent("small_bunker_damage_area", "targetname");
  level.rocket_barrage_targets[2] = getent("crush_ambient_mg", "targetname");
  for(i = 0; i < level.heroes.size; i++) {}
  array_thread(level.heroes, ::magic_bullet_shield);
  flag_set("heroes_setup");
  thread threat_group_setter();
  thread setup_brushmodels();
  thread lvt_deleter();
  thread water_watcher();
  mortar_inits();
  no_zone_mover = getent("no_zone_mover", "script_noteworthy");
  no_zone_mover.origin = no_zone_mover.origin - (0, 0, 10000);
  level.stop_ambients = false;
  level.sarge pushPlayer(true);
  if(NumRemoteClients()) {
    things_to_damage = getEntArray("script_model", "classname");
    things = 0;
    before = 0;
    after = 0;
    for(i = 0; i < things_to_damage.size; i++) {
      if(isDefined(things_to_damage[i]) && (things_to_damage[i].model == "foliage_cod5_tree_maple_02_large" || things_to_damage[i].model == "foliage_pacific_palms01" || things_to_damage[i].model == "foliage_pacific_palms02" ||
          things_to_damage[i].model == "foliage_pacific_forest_shrubs03" || things_to_damage[i].model == "foliage_pacific_forest_shrubs01")) {
        before++;
        if(things > 0) {
          things_to_damage[i] delete();
        } else {
          after++;
        }
        things++;
        if(things > 4) {
          things = 0;
        }
      }
    }
    println("*** Thinning out trees for coop play : Before " + before + " after " + after);
  }
}

flag_inits() {
  flag_init("ambients_on");
  flag_set("ambients_on");
  flag_init("jog_enabled");
  flag_clear("jog_enabled");
  flag_init("flameguy_spawned");
  flag_clear("flameguy_spawned");
  flag_init("sullivan_over_berm");
  flag_clear("sullivan_over_berm");
  flag_init("sarge_over_berm");
  flag_clear("sarge_over_berm");
  flag_init("polo_over_berm");
  flag_clear("polo_over_berm");
  flag_init("flank_path_taken");
  flag_clear("flank_path_taken");
  flag_init("stronghold_cleared");
  flag_clear("stronghold_cleared");
  flag_init("mortars_cleared");
  flag_clear("mortars_cleared");
  flag_init("end_tanks_dead");
  flag_clear("end_tanks_dead");
  flag_init("flame_the_ambient");
  flag_clear("flame_the_ambient");
  flag_init("past_flame_mg");
  flag_clear("past_flame_mg");
  flag_init("over_berm_3_flag");
  flag_clear("over_berm_3_flag");
}

water_watcher() {
  while(1) {
    watersim = false;
    wait 1;
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i].origin[1] < -8700) {
        watersim = true;
      }
    }
    watersimenable(watersim);
  }
}

lvt_deleter() {
  lvt_remover = getent("lvt_remover", "targetname");
  while(1) {
    lvt_remover waittill("trigger", who);
    if(who.model == "vehicle_usa_tracked_lvt4") {
      who delete();
    }
  }
}

catch_first_player() {
  level waittill("first_player_ready", player);
  level.otherPlayersSpectate = true;
  level.otherPlayersSpectateClient = player;
  level waittill("players off lvt");
  level.otherPlayersSpectate = false;
  level.otherPlayersSpectateClient = undefined;
  players = get_players();
  maps\_callbackglobal::Player_BreadCrumb_Reset(players[0].origin);
  for(i = 0; i < players.size; i++) {
    if(i != 0) {}
  }
}

setup_brushmodels() {
  getent("barrier2", "targetname") hide();
}

event1_setup() {
  battlechatter_off();
  start_teleport_players("coop_begins", true);
  flag_wait("heroes_setup");
  getent("spawn_player_vehicle", "targetname") useby(get_players()[0]);
  getent("spawn_arty", "targetname") useby(get_players()[0]);
  wait(0.1);
  level thread event1_put_players_on_lvt();
  level thread event1_put_ai_on_lvt();
  level thread set_objective(0);
  SetSavedDvar("compass", "0");
  level thread event1_floating_bodies();
  level thread event1_mortars();
  level thread event1_setup_lvts_with_drones();
  level thread event1_beach_tanks_setup();
  level thread event1_squibline();
  level thread event1_model3_fire();
  level thread event1_ambient_lci_trigger();
  level thread event1_cleanup_lvts();
  level thread event1_lst_door_open();
  level thread event1_ambient_aaa_fx();
  level thread event1_pillar_cover_guys();
  level thread event1_guys_on_coral();
  level thread event1_amtank_fire_watcher();
  level thread event1_rocket_hints();
  level thread event1_plane_bomb_dropper();
  level thread event1_small_bunker_rocket_damage_think();
  level thread event1_crawling_guys();
  level thread event1_plop_water();
  level thread event1_remove_spawners_for_coop();
  getvehiclenode("event1_planecrashnode", "script_noteworthy") thread event1_ambient_plane_crash();
  getvehiclenode("auto4755", "targetname") thread event1_crazy_plane_crash();
  getent("auto5686", "target") delete();
  level waittill("lst doors opened");
  getent("start_player_vehicle", "targetname") useby(get_players()[0]);
  level.players_lvt waittill("unload");
  level thread event1_stuck_on_coral();
  level thread event1_drag1_setup();
  level waittill("get out of lvt");
  getent("radio_squad_spawner", "targetname") useby(get_players()[0]);
  level thread event1_get_players_off_of_lvt();
  level thread event1_get_ai_off_of_lvt();
  level thread event2_setup();
  level thread event2_main_rocket_attack();
}

event1_remove_spawners_for_coop() {
  players = get_players();
  if(NumRemoteClients() > 0) {
    spawners = getEntArray("remove_on_coop", "script_noteworthy");
    for(i = 0; i < spawners.size; i++) {
      spawners[i] delete();
    }
  }
}

event1_plop_water() {
  wait 8;
  WaterPlop((1956, -19853, -430), 2, 4);
  WaterPlop((2408, -20128, -426), 2, 4);
  WaterPlop((2904, -19718, -480), 2, 4);
  WaterPlop((3516, -20682, -480), 2, 4);
  WaterPlop((1955, -21043, -430), 2, 4);
  physicsExplosionSphere((1956, -19853, -430), 400, 400 * 0.25, 0.75);
  physicsExplosionSphere((2408, -20128, -426), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((2904, -19718, -480), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((3516, -20682, -480), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((1955, -21043, -430), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((2906, -18676, -430), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((2906, -18676, -430), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((1485, -18804, -430), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((2280, -18360, -430), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((800, -18360, -430), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((-800, -18360, -430), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((3000, -18360, -430), 400, 400 * 0.25, 0.75);
  PhysicsExplosionSphere((4000, -18360, -430), 400, 400 * 0.25, 0.75);
}

event1_plane_bomb_dropper() {
  level.players_lvt waittill("start_vehiclepath");
  wait 0.05;
  planes = getEntArray("intro_plane1", "targetname");
  planes = array_combine(planes, getEntArray("intro_plane2", "targetname"));
  for(i = 0; i < planes.size; i++) {
    planes[i] thread event1_plane_bomb_dropper_think();
  }
}

event1_plane_bomb_dropper_think() {
  while(self.origin[1] < -16000) {
    wait 0.05;
  }
  wait randomfloatrange(0.05, 0.1);
  self thread maps\_planeweapons::drop_bombs(2, 0.1, 1.5, 128);
}

event1_amtank1_think() {
  node = getvehiclenode("blowup_amtank1", "script_noteworthy");
  node waittill("trigger", who);
  who setspeed(0, 3, 3);
  level waittill("players off lvt");
  wait 3;
  thread lookat_notify("amtank_lookat");
  level waittill_either("saw_amtank_blowup", "used rocket once");
  radiusdamage(who.origin + (0, 0, 0), 200, who.health + 1000, who.health + 500);
}

event1_amtank2_think() {
  node = getvehiclenode("amtank2_stop", "script_noteworthy");
  node waittill("trigger", who);
  who setspeed(0, 3, 3);
  level waittill("rockets done");
  who resumespeed(5);
}

event1_amtank3_think() {
  node = getvehiclenode("amtank3_stop", "script_noteworthy");
  node waittill("trigger", who);
  who setspeed(0, 3, 3);
  level waittill("rockets done");
  who resumespeed(5);
}

lookat_notify(trig_name) {
  trigger_wait(trig_name, "targetname");
  wait 0.5;
  level notify("saw_amtank_blowup");
}

event1_rocket_hints_thread() {
  self endon("player pulledout rockets");
  while(1) {
    self thread rocket_strike_user_notify();
    wait 20;
  }
}

event1_rocket_hints() {
  level endon("used rocket once");
  level endon("player pulledout rockets");
  level thread event1_rocket_hints_finish();
  level thread event1_post_rockets_moveup_ai();
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] thread event1_kill_player_on_too_far_up();
    players[i] thread event1_warn_player_on_too_far_up();
  }
  trigger_wait("use_rocket_hint", "targetname");
  level thread event1_check_for_weapons();
  level thread event1_sullivan_instruct_rockets();
  maps\_utility::autosave_by_name("Pel1 Coral");
  starts = getstructarray("post_lvt_player_breadcrumbs", "targetname");
  set_breadcrumbs(starts);
  level.rocket_barrage_allowed = true;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] thread event1_rocket_hints_thread();
  }
}

event1_check_for_weapons() {
  level endon("player pulledout rockets");
  wait 1;
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i] getcurrentweapon() == "rocket_barrage") {
        if(isDefined(players[i].hintElem)) {
          players[i].hintElem thread fade_then_kill_hud();
        }
        if(isDefined(players[i].hintElem2)) {
          players[i].hintElem2 thread fade_then_kill_hud();
        }
        for(j = 0; j < players.size; j++) {
          players[j] notify("player pulledout rockets");
        }
      }
    }
    wait 0.1;
  }
}

fade_then_kill_hud() {
  if(isDefined(self)) {
    self fadeovertime(0.2);
    self.alpha = 0;
  }
  wait 3;
  if(isDefined(self)) {
    self destroy();
  }
}

event1_sullivan_instruct_rockets() {
  level endon("used rocket once");
  wait 6;
  level.sullivan.animname = "sullivan";
  string = "barrge_use_intro";
  num = 1;
  num_strings = 6;
  did_once = false;
  while(1) {
    level.sullivan anim_single_solo(level.sullivan, string + num);
    num++;
    if(num == 3 && !did_once) {
      did_once = true;
    }
    if(num != 2) {
      wait randomfloatrange(4.25, 5.5);
    }
    if(num > num_strings) {
      num = 1;
    }
  }
}

event1_sullivan_goodjob() {}

event1_post_rockets_moveup_ai() {
  level waittill("do aftermath");
  wait 5;
  level.sarge playSound(level.scr_sound["sarge"]["moveup_beach1"], "sounddone");
  level.sarge waittill("sounddone");
  thread event1_post_aftermath_mortars();
  thread event1_post_rocket_dialogue();
  trig = getent("event1_offlvt_moveup", "targetname");
  level notify("rockets done");
  ai = grab_friendlies();
  thread wait_to_do_water_depth(ai);
  array_thread(ai, ::event1_water_depth_out_think);
  if(isDefined(trig)) {
    thread enable_ai_color_allies();
    trig notify("trigger");
  }
}

wait_to_do_water_depth(ai) {
  wait 3;
  valid_ai = [];
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i]) && isalive(ai[i])) {
      valid_ai = array_add(valid_ai, ai[i]);
    }
  }
  array_thread(valid_ai, ::event1_water_depth_think);
}

event1_water_depth_out_think() {
  self endon("death");
  while(self.origin[1] < -10917 && isalive(self) && isDefined(self)) {
    wait 0.5;
  }
  if(isalive(self) && isDefined(self)) {
    self notify("out of water");
    self.isinwater = 0;
    if(isDefined(self.a.old_combatrunanim)) {
      self.a.combatrunanim = self.a.old_combatrunanim;
    }
    if(isDefined(self.a.old_combatrunanim)) {
      self.run_combatanim = self.old_run_combatanim;
    }
    self.disableArrivals = false;
    self.run_noncombatanim = undefined;
    self.walk_combatanim = undefined;
    self.walk_noncombatanim = undefined;
    self thread wetness_on_ai(0, 1, 30);
  }
}

event1_post_rocket_dialogue() {
  level endon("stop color dialog");
  wait 2;
  level.sarge playSound(level.scr_sound["sarge"]["moveup_beach2"], "sounddone");
  level.sarge waittill("sounddone");
  level.polo playSound(level.scr_sound["polo"]["moveup_beach3"], "sounddone");
  level.polo waittill("sounddone");
  wait 2.5;
  level.sullivan playSound(level.scr_sound["sullivan"]["moveup_beach4"], "sounddone");
  level.sullivan waittill("sounddone");
  level.sullivan playSound(level.scr_sound["sullivan"]["moveup_beach5"], "sounddone");
  level.sullivan waittill("sounddone");
  guys = grab_starting_guys();
  guy1 = undefined;
  guy2 = undefined;
  for(i = 0; i < guys.size; i++) {
    if(guys[i] != level.sarge && guys[i] != level.polo && guys[i] != level.sullivan && guys[i] != level.radioguy) {
      guy1 = guys[i];
    }
  }
  for(i = 0; i < guys.size; i++) {
    if(guys[i] != guy1 && guys[i] != level.sarge && guys[i] != level.polo && guys[i] != level.sullivan && guys[i] != level.radioguy) {
      guys[i] = guy2;
    }
  }
  level.sullivan playSound(level.scr_sound["redshirt"]["moveup_beach_redshirt1"], "sounddone");
  level.sullivan waittill("sounddone");
  level.sullivan playSound(level.scr_sound["redshirt"]["moveup_beach_redshirt2"], "sounddone");
  level.sullivan waittill("sounddone");
  level.sullivan playSound(level.scr_sound["redshirt"]["moveup_beach_redshirt2a"], "sounddone");
  level.sullivan waittill("sounddone");
  level.sullivan playSound(level.scr_sound["redshirt"]["moveup_beach_redshirt6"], "sounddone");
  level.sullivan waittill("sounddone");
  level.sullivan playSound(level.scr_sound["redshirt"]["moveup_beach_redshirt7"], "sounddone");
  level.sullivan waittill("sounddone");
  level.sullivan playSound(level.scr_sound["redshirt"]["moveup_beach_redshirt8"], "sounddone");
  level.sullivan waittill("sounddone");
}

event1_rocket_hints_finish() {
  level waittill("rockets available anytime");
  iprintlnbold(&"PEL1_ROCKETS_ALWAYS_AVAIL");
}

event1_kill_player_on_too_far_up() {
  self thread event1_kill_player_on_too_far_up_during_strike();
  self thread event1_kill_player_on_too_far_up_during_strike_ender();
  level endon("do aftermath");
  self endon("death");
  self endon("disconnect");
  while(1) {
    if(self.origin[1] > -12800) {
      wait randomfloatrange(0.1, 0.4);
      self dodamage(30, (2158, -10313, -380));
      if(self.health <= 10) {
        self enableHealthShield(false);
        self dodamage(self.health + 10, (2158, -10313, -380));
        playFX(level._effect["water_mortar"], self.origin);
        self playSound("mortar_impact_water");
        self enableHealthShield(true);
      }
    }
    wait 0.1;
  }
}

event1_kill_player_on_too_far_up_during_strike_ender() {
  self endon("death");
  self endon("disconnect");
  level waittill("do aftermath");
  wait 10;
  level notify("stop death wall");
  self allowstand(true);
}

event1_kill_player_on_too_far_up_during_strike() {
  self endon("death");
  self endon("disconnect");
  level endon("stop death wall");
  level waittill("do aftermath");
  while(1) {
    if(self.origin[1] > -11502) {
      self shellshock("default", 5);
      self allowstand(false);
    }
    wait 0.1;
  }
}

event1_warn_player_on_too_far_up() {
  level endon("used rocket once");
  self endon("death");
  self endon("disconnect");
  level.polo.animname = "polo";
  string = "warn_get_back_here";
  num = 1;
  num_strings = 3;
  while(1) {
    if(self.origin[1] > -13100) {
      level.polo anim_single_solo(level.polo, string + num);
      num++;
      wait randomfloatrange(2.0, 3.25);
      if(num > num_strings) {
        num = 1;
      }
    }
    wait 0.1;
  }
}

event1_amtank_fire_watcher() {
  level waittill("players off lvt");
  vehicles = getEntArray("script_vehicle", "classname");
  amtanks = [];
  for(i = 0; i < vehicles.size; i++) {
    if(vehicles[i].model == "vehicle_usa_tracked_lvta4_amtank") {
      amtanks = array_add(amtanks, vehicles[i]);
    }
  }
  for(i = 0; i < amtanks.size; i++) {
    amtanks[i] thread maps\_amtank::fire_loop_toggle(1);
  }
  level waittill("do aftermath");
  for(i = 0; i < amtanks.size; i++) {
    amtanks[i] thread maps\_amtank::fire_loop_toggle(0);
  }
}

event1_guys_on_coral() {
  getent("radio_squad_spawner", "targetname") waittill("trigger");
  wait 0.1;
  ai = get_ai_group_ai("coral_radio_guys");
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_forcecolor) && ai[i].script_forcecolor == "y") {
      level.radioguy = ai[i];
      level.radioguy.animname = "radioguy";
      level.radioguy thread magic_bullet_shield();
      level.radioguy set_battlechatter(false);
    }
  }
  ai = array_remove(ai, level.radioguy);
  for(i = 0; i < ai.size; i++) {
    ai[i].animname = "coralguy" + (i + 1);
  }
  playpoint = getstruct("event1_guys_on_coral", "targetname");
  ai = array_add(ai, level.radioguy);
  level thread anim_loop(ai, "coral_loop", undefined, "stop_coral_loop", playpoint);
  getent("event1_jeep_blowup_trig", "targetname") waittill("trigger");
  level notify("stop_coral_loop");
  for(i = 0; i < ai.size; i++) {
    ai[i] stopanimscripted();
  }
  for(i = 0; i < ai.size; i++) {
    ai[i] thread event1_water_depth_think();
    if(ai[i] != level.radioguy) {
      ai[i].goalradius = 64;
      ai[i] setgoalpos(getnode(ai[i].target, "targetname").origin);
      ai[i] thread event1_coral_timed_death();
    }
  }
}

event1_coral_timed_death() {
  self endon("death");
  wait randomfloatrange(3, 12);
  self dodamage(self.health + 10, (0, 0, 52));
}

event1_ambient_plane_crash() {
  self waittill("trigger", who);
  playFXOnTag(level._effect["plane_crashing"], who, "tag_prop");
  finalnode = getvehiclenode("auto5013", "targetname");
  finalnode waittill("trigger");
  playFX(level._effect["bunker_explode_large"], finalnode.origin);
}

event1_crazy_plane_crash() {
  self waittill("trigger", who);
  who thread event1_crazy_plane_prop_fx();
  getvehiclenode("auto6154", "targetname") waittill("trigger");
  who playSound("intro_plane_crash");
  finalnode = getvehiclenode("auto4756", "targetname");
  finalnode waittill("trigger");
  playFX(level._effect["water_mortar"], who.origin);
  playsoundatposition("plane_impact_water", who.origin);
  who notify("death");
}

event1_crazy_plane_prop_fx() {
  while(isalive(self)) {
    playFXOnTag(level._effect["plane_crashing"], self, "tag_prop");
    wait 5;
  }
}

event1_ambient_aaa_fx() {
  getent("start_models3s", "targetname") waittill("trigger");
  level clientNotify("ab");
  level notify("aaa_begin");
}

event1_cleanup_lvts() {
  level waittill("remove floaters");
  real_lvts = getEntArray("script_vehicle", "classname");
  for(i = 0; i < real_lvts.size; i++) {
    if(real_lvts[i].model == "vehicle_usa_tracked_lvt4") {
      real_lvts[i] notify("death");
    }
  }
  beachdrones = getEntArray("beach_drones_cover", "script_noteworthy");
  for(i = 0; i < beachdrones.size; i++) {
    beachdrones[i] notify("death");
    beachdrones[i] thread maps\_drones::drone_delete();
  }
}

event1_pillar_cover_guys() {
  thread event1_pillar_guys_sound();
  pillar1 = getstruct("beachpillar1", "targetname");
  guys1 = [];
  guys1[0] = spawn_fake_guy_lvt(pillar1.origin, pillar1.angles, 1, "pillar_guy1", "pillar_guy1", 0, 1);
  guys1[1] = spawn_fake_guy_lvt(pillar1.origin, pillar1.angles, 1, "pillar_guy2", "pillar_guy2", 0, 1);
  guys1[2] = spawn_fake_guy_lvt(pillar1.origin, pillar1.angles, 1, "pillar_guy3", "pillar_guy3", 0, 1);
  pillar2 = getstruct("beachpillar2", "targetname");
  guys2 = [];
  guys2[0] = spawn_fake_guy_lvt(pillar2.origin, pillar2.angles, 1, "pillar_guy4", "pillar_guy4", 0, 1);
  guys2[1] = spawn_fake_guy_lvt(pillar2.origin, pillar2.angles, 1, "pillar_guy5", "pillar_guy5", 0, 1);
  guys2[2] = spawn_fake_guy_lvt(pillar2.origin, pillar2.angles, 1, "pillar_guy6", "pillar_guy6", 0, 1);
  allguys = array_combine(guys1, guys2);
  for(i = 0; i < allguys.size; i++) {
    allguys[i] event1_give_guys_names();
  }
  level thread event2_waittill_obstacle_explode(guys2, pillar2);
  pillar1 thread anim_loop(guys1, "coverloop", undefined, "stop_pillar_cover", pillar1);
  pillar2 thread anim_loop(guys2, "coverloop", undefined, "stop_pillar_cover", pillar2);
  level waittill("remove floaters");
  for(i = 0; i < guys1.size; i++) {
    pillar1 notify("stop_pillar_cover");
    guys1[i] delete();
  }
  for(i = 0; i < guys2.size; i++) {
    pillar2 notify("stop_pillar_cover");
    guys2[i] delete();
  }
}

event2_waittill_obstacle_explode(guys2, pillar2) {
  level endon("remove floaters");
  barrier = getent("barrier2", "targetname");
  trig = getent("obstacle_explode", "targetname");
  player_saw_this = false;
  while(!player_saw_this) {
    trig waittill("trigger", who);
    if(distance(who.origin, barrier.origin) < 1000) {
      player_saw_this = true;
    }
    wait 0.05;
  }
  wait 1.5;
  getent("barrier1", "targetname") delete();
  barrier show();
  playFX(level._effect["dirt_mortar"], barrier.origin);
  barrier playSound("mortar_dirt");
  pillar2 notify("stop_pillar_cover");
  for(i = 0; i < guys2.size; i++) {
    guys2[i] startragdoll();
  }
}

event1_give_guys_names() {
  self makeFakeAI();
  self.team = "allies";
  self.health = 1000000;
  self maps\_drones::drone_setName();
}

event1_pillar_guys_sound() {
  trig = getent("ev1_pillar_guys_sound_trig", "targetname");
  trig waittill("trigger");
  soundpoint = getstruct("beachpillar2", "targetname");
  playsoundatposition("Pel01_G1A_TRM1_004A", soundpoint.origin);
  wait 2;
  playsoundatposition("Pel01_G1A_TRM2_005A", soundpoint.origin);
}

event1_ambient_lci_trigger() {
  trig = getent("ambient_lci_trigger", "targetname");
  trig waittill("trigger");
  num_rockets = 36;
  num_rockets_per_ship = 12;
  start_points = [];
  orgs = getstructarray("rocketbarrage_points2", "targetname");
  q = 0;
  for(i = 0; i < num_rockets; i++) {
    q = i % num_rockets_per_ship;
    start_points[i] = orgs[q].origin;
  }
  level thread event1_lci_rocket_fire((8000, -10000, -535.5), start_points);
  level notify("ship_fire_right");
  level clientnotify("sfr");
  wait 10;
  start_points = [];
  orgs = getstructarray("rocketbarrage_points2", "targetname");
  q = 0;
  for(i = 0; i < num_rockets; i++) {
    q = i % num_rockets_per_ship;
    start_points[i] = orgs[q].origin;
  }
  level thread event1_lci_rocket_fire((8000, -10000, -535.5), start_points);
  level notify("ship_fire_right");
  level clientnotify("sfr");
  wait 25;
  start_points = [];
  orgs = getstructarray("rocketbarrage_points1", "targetname");
  q = 0;
  for(i = 0; i < num_rockets; i++) {
    q = i % num_rockets_per_ship;
    start_points[i] = orgs[q].origin;
  }
  level thread event1_lci_rocket_fire((-2000, -10000, -535.5), start_points);
  level notify("ship_fire_left");
  level clientnotify("sfl");
}

event1_water_depth_think() {
  self endon("death");
  self endon("out of water");
  if(!isDefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self.old_run_combatanim = self.run_combatanim;
  self.a.old_combatrunanim = self.a.combatrunanim;
  self.isinwater = false;
  while(isDefined(self) && isalive(self)) {
    depth = self depthinwater();
    run_cycles = 3;
    num = randomint(run_cycles);
    anim_string = undefined;
    the_anim = undefined;
    if(isDefined(depth) && depth >= 22) {
      if(self.isinwater == 1) {
        wait 0.5;
        continue;
      }
      if(num == 0) {
        the_anim = % ai_run_deep_water_a;
        anim_string = "run_deep_a";
      } else if(num == 1) {
        the_anim = % ai_run_deep_water_b;
        anim_string = "run_deep_b";
      } else if(num == 2) {
        the_anim = % ai_run_shallow_water_d;
        anim_string = "run_shallow_d";
      }
      self.isinwater = 1;
    } else {
      self.isinwater = 0;
      self.a.combatrunanim = self.a.old_combatrunanim;
      self.run_combatanim = self.old_run_combatanim;
      self.disableArrivals = false;
      self.run_noncombatanim = undefined;
      self.walk_combatanim = undefined;
      self.walk_noncombatanim = undefined;
    }
    if(isDefined(self) && isDefined(self.isinwater) && self.isinwater) {
      self.animname = "in_water";
      self set_run_anim(anim_string);
      self.run_combatanim = the_anim;
      self.disableArrivals = true;
    }
    wait 0.5;
  }
}

mortar_inits() {
  maps\_mortar::set_mortar_delays("beach_mortar_water", 3.5, 5, 3.5, 5);
  maps\_mortar::set_mortar_chance("beach_mortar_water", 0.5);
  maps\_mortar::set_mortar_range("beach_mortar_water", 300, 2500);
  maps\_mortar::set_mortar_damage("beach_mortar_water", 0, 0, 0);
  maps\_mortar::set_mortar_quake("beach_mortar_water", 0.30, 2.5, 1000);
}

event1_mortars() {
  level waittill("aaa_begin");
  level thread maps\_mortar::mortar_loop("beach_mortar_water");
  level waittill("do aftermath");
  level notify("stop_all_mortar_loops");
}

event1_post_aftermath_mortars() {
  level thread maps\_mortar::mortar_loop("beach_mortar_water");
  level waittill("stop_water_mortars");
  level notify("stop_all_mortar_loops");
}

event1_squibline() {
  starts = getstructarray("squibline", "targetname");
  starts2 = getstructarray("squiblinev2", "targetname");
  array_thread(starts2, ::event1_squibline_think_v2);
}

event1_squibline_think() {
  level endon("do aftermath");
  while(1) {
    start = self;
    wait(randomintrange(5, 10));
    while(isDefined(start.target)) {
      playFX(level._effect["one_squib"], start.origin - (20 + randomint(40), 20 + randomint(40), 0));
      thread play_sound_in_space("bulletspray_large_sand", start.origin);
      wait(0.05);
      if(isDefined(start.target)) {
        start = getstruct(start.target, "targetname");
      }
    }
  }
}

event1_squibline_think_v2() {
  level endon("do aftermath");
  start = self;
  end = getstruct(self.target, "targetname");
  while(1) {
    wait(randomintrange(8, 15));
    org = spawn("script_origin", start.origin);
    org moveto(end.origin, 0.7);
    org thread event1_squibline_think_impacts();
    org waittill("movedone");
    org delete();
  }
}

event1_squibline_think_burst() {
  start = self;
  end = getstruct(self.target, "targetname");
  org = spawn("script_origin", start.origin);
  org moveto(end.origin, 0.7);
  org thread event1_squibline_think_impacts();
  org waittill("movedone");
  org delete();
}

event1_squibline_think_impacts() {
  self endon("movedone");
  while(1) {
    magicbullet("type100_smg_nosound", self.origin, self.origin + (100, 50, 0) - (randomint(200), randomint(100), 200));
    wait(0.05);
  }
}

event1_squibline_think_impacts_for_anim(rand) {
  self endon("movedone");
  while(1) {
    if(!isDefined(rand)) {
      rand = 150;
    } else {
      rand = randomintrange(140, 200);
    }
    magicbullet("type100_smg_nosound", self.origin, self.origin - (0, 500, rand));
    wait(0.1);
  }
}

event1_drag1_setup() {
  level waittill("get out of lvt");
  dragger_spawner = getent("dragger_guy1", "targetname");
  dragger = dragger_spawner spawn_ai();
  dragger thread magic_bullet_shield();
  if(spawn_failed(dragger)) {
    assertex(0, "spawn failed from dragger guy");
    return;
  }
  dragger thread event1_water_depth_think();
  wounded = spawn_fake_guy_lvt((0, 0, 0), (0, 0, 0), 1, "wounded", "wounded_drone", 0, 0);
  dragger.animname = "dragger";
  dragset = [];
  dragset[0] = dragger;
  dragset[1] = wounded;
  startpoint = getstruct("drag_start_point", "targetname");
  dragger.animname = "dragger";
  dragger thread fail_on_ff();
  wounded thread fail_on_ff();
  thread anim_loop(dragset, "drag_loop", undefined, "stop_drag_loop", startpoint);
  level waittill("remove floaters");
  level notify("stop_drag_loop");
  dragger thread stop_magic_bullet_shield();
  dragger delete();
  wounded delete();
}

fail_on_ff() {
  self endon("death");
  self setCanDamage(1);
  name = undefined;
  if(!isai(self)) {
    self makefakeai();
    self.health = 100000;
    self.team = "allies";
    self.voice = "american";
    self maps\_names::get_name_for_nationality("american");
    self setlookattext(self.name, &"WEAPON_RIFLEMAN");
  }
  players = get_players();
  if(players.size > 1) {
    return;
  }
  while(isDefined(self)) {
    self waittill("damage", amount, who);
    if(isplayer(who)) {
      thread maps\_friendlyfire::missionfail();
    }
  }
}

event1_put_players_on_lvt() {
  players = get_players();
  level.players_lvt = getent("player_lvt", "targetname");
  level.players_lvt playSound("lvt_start");
  level.players_lvt.front_sounds = getent("player_lvt_front_soundpoint", "targetname");
  level.players_lvt.rear_sounds = getent("player_lvt_rear_soundpoint", "targetname");
  level.players_lvt.front_sounds linkto(level.players_lvt);
  level.players_lvt.rear_sounds linkto(level.players_lvt);
  for(i = 0; i < players.size; i++) {
    org = undefined;
    ang = undefined;
    tag = undefined;
    players[i] thread attach_weapon_during_lvt_ride();
    if(i == 0) {
      tag = "tag_passenger8";
      players[i] playeranimscriptevent("lvt_ride_player3");
    } else if(i == 1) {
      tag = "tag_passenger4";
      players[i] playeranimscriptevent("lvt_ride_player2");
    } else if(i == 2) {
      tag = "tag_passenger5";
      players[i] playeranimscriptevent("lvt_ride_player3");
    } else {
      tag = "tag_passenger9";
      players[i] playeranimscriptevent("lvt_ride_player4");
    }
    players[i] PlayRumbleLoopOnEntity("tank_rumble");
    org = level.players_lvt gettagOrigin(tag);
    ang = level.players_lvt gettagangles(tag);
    players[i] setorigin(org);
    players[i] setplayerangles(ang);
    players[i].lvt_linkspot = spawn("script_origin", org);
    players[i].lvt_linkspot_ref = spawn("script_origin", org);
    if(i == 0) {
      players[i].lvt_linkspot linkto(level.players_lvt, tag, (0, 0, 0), (0, 0, 0));
      players[i].lvt_linkspot_ref linkto(level.players_lvt, tag, (0, 0, 0), (0, 270, 0));
    } else if(i == 1) {
      players[i].lvt_linkspot linkto(level.players_lvt, tag, (8, 13, 4), (0, 0, 0));
      players[i].lvt_linkspot_ref linkto(level.players_lvt, tag, (8, 13, 4), (0, 270, 0));
    } else if(i == 2) {
      players[i].lvt_linkspot linkto(level.players_lvt, tag, (8, 12, 0), (0, 0, 0));
      players[i].lvt_linkspot_ref linkto(level.players_lvt, tag, (8, 12, 0), (0, 270, 0));
    } else {
      players[i].lvt_linkspot linkto(level.players_lvt, tag, (21, -10, 0), (0, 0, 0));
      players[i].lvt_linkspot_ref linkto(level.players_lvt, tag, (21, -10, 0), (0, 270, 0));
    }
    players[i] playerlinktodelta(players[i].lvt_linkspot, undefined, 1.0);
    players[i] PlayerSetGroundReferenceEnt(players[i].lvt_linkspot_ref);
    players[i] allowcrouch(false);
    players[i] allowprone(false);
    players[i] takeweapon("fraggrenade");
  }
}

attach_weapon_during_lvt_ride() {
  wait 4;
  self attach("weapon_usa_m1garand_rifle", "tag_weapon_right");
}

event1_stuck_on_coral() {
  earthquake(0.35, 1.5, level.players_lvt.origin, 2050);
  level.players_lvt playSound("lvt_crash");
  thread rumble_all_players("damage_heavy");
  level.players_lvt.front_sounds thread fake_sound_fade();
  level.players_lvt.rear_sounds thread fake_sound_fade();
  wait 11.5;
  level notify("get out of lvt");
  thread event1_switch_weapons_on();
}

fake_sound_fade() {
  self unlink();
  self moveto(self.origin - (0, 0, 1000), 1);
  self waittill("movedone");
  self delete();
}

event1_switch_weapons_on() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] SwitchToWeapon("m1garand_bayonet");
  }
}

event1_get_players_off_of_lvt() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] PlayerSetGroundReferenceEnt(undefined);
    players[i] StopRumble("tank_rumble");
    level.enable_weapons = 1;
    org = undefined;
    if(i == 0) {
      org = (1922, -13126, -425);
    } else if(i == 1) {
      org = (2242, -13102, -425);
    } else if(i == 2) {
      org = (1906, -13262, -425);
    } else if(i == 3) {
      org = (2146, -13302, -425);
    }
    ang = (0, 90, 0);
  }
  level notify("players off lvt");
  thread event1_explode_and_fade_to_white();
}

delete_wait() {
  wait 1;
  self delete();
}

event1_explode_and_fade_to_white() {
  clientnotify("pol");
  println("players_off_lvt NOTIFY SENT");
  fadetowhite = [];
  playFXOnTag(level._effect["special_lvt_explode"], level.players_lvt, "tag_origin");
  playsoundatposition("lvt_explo", (0, 0, 0));
  level.players_lvt setModel("vehicle_usa_tracked_lvta2_d");
  thread maps\pel1::rumble_all_players("damage_heavy");
  thread slow_mo_the_tip();
  players = get_players();
  players[0] thread maps\pel1_anim::lvt_tipover();
  for(i = 0; i < players.size; i++) {
    players[i] shellshock("lvt_exp", 10);
  }
  level waittill("fade_from_white");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] freezecontrols(true);
    players[i] shellshock("default", 3);
  }
  wait 3;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] freezecontrols(false);
  }
}

slow_mo_the_tip() {
  wait 1;
  settimescale(1);
}

event1_crawling_guys() {
  if(is_german_build()) {
    return;
  }
  struct1 = getstruct("crawl_guy1", "targetname");
  struct2 = getstruct("crawl_guy2", "targetname");
  struct3 = getstruct("crawl_guy3", "targetname");
  guy1 = spawn_fake_guy_lvt(struct1.origin, struct1.angles, 0, "crawl1", "crawl", 0);
  guy2 = spawn_fake_guy_lvt(struct2.origin, struct2.angles, 0, "crawl2", "crawl", 0);
  guy3 = spawn_fake_guy_lvt(struct3.origin, struct3.angles, 0, "crawl3", "crawl", 0);
  guy1 thread crawl_think();
  guy2 thread crawl_think();
  guy3 thread crawl_think();
  guy1.a.gib_ref = "left_leg";
  guy2.a.gib_ref = "no_legs";
  guy3.a.gib_ref = "right_leg";
  guy1 thread animscripts\death::do_gib();
  guy2 thread animscripts\death::do_gib();
  guy3 thread animscripts\death::do_gib();
}

crawl_think() {
  self makeFakeAI();
  self solid();
  self.interval = 128;
  self setCanDamage(true);
  self.team = "axis";
  self.health = 1;
  self endon("shot_death");
  self thread anim_loop_solo(self, "crawl_idle", undefined, "stop_idling");
  self thread crawl_death_watcher();
  trigger_wait("ev1_near_berm", "script_noteworthy");
  wait randomfloatrange(0.1, 2.0);
  self notify("stop_idling");
  self anim_single_solo(self, "crawl_crawl");
  self anim_single_solo(self, "crawl_die");
  self notify("stop_shot_death");
  self startragdoll();
  self stopsounds();
  wait 45;
  if(isDefined(self)) {
    self delete();
  }
}

play_pain_sound() {
  self endon("stop_shot_death");
  self endon("shot_death");
  if(!is_mature()) {
    return;
  }
  wait randomfloatrange(0.3, 1.3);
  soundtoplay = [];
  soundtoplay[0] = "JA_0_pain_large";
  soundtoplay[1] = "JA_1_pain_large";
  soundtoplay[2] = "JA_3_pain_large";
  while(isDefined(self)) {
    rand = randomint(soundtoplay.size);
    self playSound(soundtoplay[rand], "sounddone");
    self waittill("sounddone");
    wait randomfloatrange(2.0, 5.0);
  }
}

crawl_death_watcher() {
  self endon("stop_shot_death");
  self waittill("damage", amount, who);
  if(isplayer(who)) {
    arcademode_assignpoints("arcademode_score_generic100", who);
  }
  self notify("shot_death");
  self anim_single_solo(self, "crawl_shot");
  self startragdoll();
  self stopsounds();
  wait 45;
  if(isDefined(self)) {
    self delete();
  }
}

event1_underwater_squib(rand) {
  level endon("do aftermath");
  level endon("done underwater");
  start = getstruct("squibline_scripted1", "targetname");
  end = getstruct(start.target, "targetname");
  while(1) {
    org = spawn("script_origin", start.origin);
    org moveto(end.origin, 1.5);
    org thread event1_squibline_think_impacts_for_anim(rand);
    org waittill("movedone");
    org delete();
    wait 3;
  }
}

event1_underwater_squib_kill_ai() {
  self endon("death");
  level endon("do aftermath");
  start = self.origin + (0, 600, 64);
  end = self.origin - (0, 200, 0) + (0, 0, 64);
  org = spawn("script_origin", start);
  org moveto(end, 1.5);
  org thread event1_squibline_think_impacts();
  org waittill("movedone");
  org delete();
  wait 3;
}

event1_put_ai_on_lvt() {
  guys = grab_starting_guys();
  tag = undefined;
  tag = "tag_passenger2";
  level.gibsworth = getent("gibsworth", "script_noteworthy");
  level.gibsworth linkto(level.players_lvt, tag);
  level.gibsworth animscripted("lvt_ridein", level.players_lvt gettagorigin(tag), level.players_lvt gettagangles(tag), % crew_lvt4_peleliu1_character2);
  level.gibsworth thread event2_headshot();
  level.gibsworth thread lvt_dialog();
  tag = "tag_passenger3";
  level.sullivan linkto(level.players_lvt, tag);
  level.sullivan animscripted("lvt_ridein", level.players_lvt gettagorigin(tag), level.players_lvt gettagangles(tag), % crew_lvt4_peleliu1_character3);
  tag = "tag_passenger7";
  level.polo linkto(level.players_lvt, tag);
  level.polo animscripted("lvt_ridein", level.players_lvt gettagorigin(tag), level.players_lvt gettagangles(tag), % crew_lvt4_peleliu1_character7);
  tag = "tag_passenger6";
  level.sarge linkto(level.players_lvt, tag);
  level.sarge animscripted("lvt_ridein", level.players_lvt gettagorigin(tag), level.players_lvt gettagangles(tag), % crew_lvt4_peleliu1_character6);
  guys = array_remove(guys, level.sarge);
  guys = array_remove(guys, level.polo);
  guys = array_remove(guys, level.sullivan);
  guys = array_remove(guys, level.gibsworth);
  coop_displacements = getEntArray("lvt_coop_redshirt_displacement", "targetname");
  for(i = 0; i < coop_displacements.size; i++) {
    coop_displacements[i] linkto(level.players_lvt);
  }
  players = get_players();
  for(i = 0; i < guys.size; i++) {
    if(i == 0) {
      if(level.displaceredshirts && players.size >= 3) {
        tag = "tag_passenger5";
        guys[i] linkto(coop_displacements[1]);
        guys[i] animscripted("lvt_ridein", coop_displacements[1].origin, coop_displacements[1].angles, % crouch_aim_straight);
      } else {
        tag = "tag_passenger5";
        guys[i] linkto(level.players_lvt, tag);
        guys[i] animscripted("lvt_ridein", level.players_lvt gettagorigin(tag), level.players_lvt gettagangles(tag), % crew_lvt4_peleliu1_character5);
      }
    } else if(i == 1) {
      if(level.displaceredshirts && players.size == 4) {
        tag = "tag_passenger9";
        guys[i] linkto(coop_displacements[2]);
        guys[i] animscripted("lvt_ridein", coop_displacements[2].origin, coop_displacements[2].angles, % crouch_aim_straight);
      } else {
        tag = "tag_passenger9";
        guys[i] linkto(level.players_lvt, tag);
        guys[i] animscripted("lvt_ridein", level.players_lvt gettagorigin(tag), level.players_lvt gettagangles(tag), % crew_lvt4_peleliu1_character9);
      }
    } else if(i == 2) {
      if(level.displaceredshirts && players.size >= 2) {
        tag = "tag_passenger4";
        guys[i] linkto(coop_displacements[0]);
        guys[i] animscripted("lvt_ridein", coop_displacements[0].origin, coop_displacements[0].angles, % crouch_aim_straight);
      } else {
        tag = "tag_passenger4";
        guys[i] linkto(level.players_lvt, tag);
        guys[i] animscripted("lvt_ridein", level.players_lvt gettagorigin(tag), level.players_lvt gettagangles(tag), % crew_lvt4_peleliu1_character4);
      }
    }
  }
  lvt_driver = spawn_fake_guy_lvt((0, 0, 0), (0, 0, 0), 1, "lvt_driver", "floater", 0, 0, 1);
  lvt_driver linkto(level.players_lvt, "tag_driver");
  lvt_driver thread driver_death();
  lvt_pass = spawn_fake_guy_lvt((0, 0, 0), (0, 0, 0), 1, "lvt_passenger", "floater", 0, 0, 1);
  lvt_pass linkto(level.players_lvt, "tag_passenger");
  lvt_driver thread anim_loop_solo(lvt_driver, "drive_idle", "tag_driver", "stopdriveidle", level.players_lvt);
  lvt_pass thread anim_loop_solo(lvt_pass, "drive_idle", "tag_passenger", "stopdriveidle", level.players_lvt);
  level thread sully_has_a_tommy();
  level.displaceredshirts = false;
  level.players_lvt thread maps\pel1_anim::lvt_play_ride_in();
  level waittill("players off lvt");
  lvt_driver notify("stopdriveidle");
  lvt_pass notify("stopdriveidle");
  lvt_driver delete();
  lvt_pass delete();
}

driver_death() {
  self waittillmatch("looping anim", "shot");
  if(is_mature()) {
    playFXOnTag(level._effect["head_shot"], self, "j_head");
  }
}

sully_has_a_tommy() {
  level.sullivan animscripts\shared::placeWeaponOn(level.sullivan.weapon, "none");
  level.sullivan attach("weapon_usa_thompson_smg", "tag_weapon_right");
  level.sullivan.weapon = "thompson";
  level waittill("players off lvt");
  level.sullivan.weapon = "shotgun";
  level.sullivan detach("weapon_usa_thompson_smg", "tag_weapon_right");
  level.sullivan animscripts\shared::placeWeaponOn(level.sullivan.weapon, "right");
}

lvt_dialog() {
  setmusicstate("INTRO");
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro1"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sarge playSound(level.scr_sound["intro"]["intro2"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sarge playSound(level.scr_sound["intro"]["intro3"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro4"]);
  self waittillmatch("lvt_ridein", "dialog");
  self waittillmatch("lvt_ridein", "dialog");
  level.sarge playSound(level.scr_sound["intro"]["intro6"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sarge playSound(level.scr_sound["intro"]["intro7"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro8"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro9"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sarge playSound(level.scr_sound["intro"]["intro10"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro11"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sarge playSound(level.scr_sound["intro"]["intro12"]);
  self waittillmatch("lvt_ridein", "dialog");
  self playSound(level.scr_sound["intro"]["intro13"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.polo playSound(level.scr_sound["intro"]["intro14"]);
  self waittillmatch("lvt_ridein", "dialog");
  self playSound(level.scr_sound["intro"]["intro15"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sarge playSound(level.scr_sound["intro"]["intro16"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro17"]);
  self waittillmatch("lvt_ridein", "dialog");
  self playSound(level.scr_sound["intro"]["intro18"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro19"]);
  self waittillmatch("lvt_ridein", "dialog");
  self playSound(level.scr_sound["intro"]["intro20"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro21"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.polo playSound(level.scr_sound["intro"]["intro22"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.polo playSound(level.scr_sound["intro"]["intro23"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro24"]);
  self waittillmatch("lvt_ridein", "dialog");
  self playSound(level.scr_sound["intro"]["intro25"]);
  self waittillmatch("lvt_ridein", "dialog");
  level.sullivan playSound(level.scr_sound["intro"]["intro26"]);
}

event1_put_ai_on_lvt_short() {
  guys = grab_starting_guys();
  tag = undefined;
  tag = "tag_passenger3";
  level.sarge linkto(level.players_lvt, tag);
  tag = "tag_passenger7";
  level.polo linkto(level.players_lvt, tag);
  tag = "tag_passenger4";
  level.sullivan linkto(level.players_lvt, tag);
  tag = "tag_passenger2";
  level.gibsworth = getent("gibsworth", "script_noteworthy");
  level.gibsworth linkto(level.players_lvt, tag);
  level.gibsworth thread event2_headshot();
  guys = array_remove(guys, level.sarge);
  guys = array_remove(guys, level.polo);
  guys = array_remove(guys, level.sullivan);
  guys = array_remove(guys, level.gibsworth);
  coop_displacements = getEntArray("lvt_coop_redshirt_displacement", "targetname");
  for(i = 0; i < coop_displacements.size; i++) {
    coop_displacements[i] linkto(level.players_lvt);
  }
  players = get_players();
  for(i = 0; i < guys.size; i++) {
    if(i == 2) {
      if(level.displaceredshirts && players.size >= 3) {
        tag = "tag_passenger5";
        guys[i] linkto(coop_displacements[1]);
      } else {
        tag = "tag_passenger5";
        guys[i] linkto(level.players_lvt, tag);
      }
    } else if(i == 3) {
      if(level.displaceredshirts && players.size == 4) {
        tag = "tag_passenger6";
        guys[i] linkto(coop_displacements[2]);
      } else {
        tag = "tag_passenger6";
        guys[i] linkto(level.players_lvt, tag);
      }
    } else if(i == 4) {
      if(level.displaceredshirts && players.size >= 2) {
        tag = "tag_passenger9";
        guys[i] linkto(coop_displacements[0]);
      } else {
        tag = "tag_passenger9";
        guys[i] linkto(level.players_lvt, tag);
      }
    }
  }
  level.displaceredshirts = false;
}

event2_headshot() {
  self endon("death");
  self waittillmatch("lvt_ridein", "head_shot");
  if(is_mature()) {
    playFXOnTag(level._effect["head_shot"], self, "j_head");
  }
  self playSound("headshot_imp");
  playsoundatposition("headshot_rico", self.origin - (0, 150, 30) + (100, 0, 0));
  self swap_gibhead_guy();
  setmusicstate("BEACH");
  self waittillmatch("lvt_ridein", "end");
  self.deathanim = level.scr_anim["ridein2"]["death"];
  self.allowdeath = true;
  self dodamage(self.health + 10, (0, 0, 0));
}

swap_gibhead_guy() {
  self.a.nodeath = true;
  tag = "j_helmet";
  model = "char_usa_raider_helm2";
  org = self gettagorigin(tag);
  ang = self gettagangles(tag);
  if(!is_mature()) {
    return;
  }
  CreateDynEntAndLaunch(model, org, ang, org, (1200, -600, 140));
  self codescripts\character::new();
  self character\char_usa_marine_r_nb_hshot_after::main();
}

delete_hat() {
  wait 10;
  self delete();
}

event1_get_ai_off_of_lvt() {
  guys = grab_starting_guys();
  for(i = 0; i < guys.size; i++) {
    guys[i] unlink();
  }
  nodes = getnodearray("coral_nodes", "targetname");
  for(i = 0; i < guys.size; i++) {
    guys[i] disable_ai_color();
    guys[i].moveorg = spawn("script_origin", guys[i].origin);
    guys[i] linkto(guys[i].moveorg);
    guys[i].moveorg moveto(nodes[i].origin, 0.1);
    guys[i] setgoalnode(nodes[i]);
  }
  wait 0.2;
  for(i = 0; i < guys.size; i++) {
    guys[i] unlink();
  }
  level.gibsworth notify("death");
  level.gibsworth delete();
}

event1_sarge_over_berm() {
  ref_point = getstruct("over_reference", "targetname");
  level.sarge thread event2_over_berm_anim_think(ref_point, 98);
}

event1_model3_fire(start_point) {
  getent("start_models3s", "targetname") waittill("trigger");
  gun1 = getent("model3_gun1", "targetname");
  gun2 = getent("model3_gun3", "targetname");
  if(!isDefined(start_point)) {
    gun1 thread event1_model3_things_get_owned();
    gun1 thread event1_model3_fire_think(gun1, 0);
    gun2 thread event1_model3_fire_think(gun2, 1);
    wait 2;
  }
  gun2 thread event1_model3_fire_at_random_targets();
}

event1_model3_fire_think(gun, random_fire) {
  self endon("death");
  gun setturrettargetent(get_players()[0]);
  while(1) {
    if(!flag("ambients_on")) {
      wait 1;
      continue;
    }
    gun fireweapon();
    gun notify("200mm gun fired");
    wait 1;
    gun notify("200mm gun hit");
    if(!random_fire) {
      wait 4;
    } else {
      wait randomfloatrange(3.75, 6.0);
    }
  }
}

lvt_guys_exploding_out() {
  tags = [];
  tags[0] = "tag_passenger2";
  tags[1] = "tag_passenger3";
  tags[2] = "tag_passenger4";
  tags[3] = "tag_passenger5";
  tags[4] = "tag_passenger6";
  tags[5] = "tag_passenger7";
  tags[6] = "tag_passenger8";
  tags[7] = "tag_passenger9";
  anims[0] = % death_explosion_left11;
  anims[1] = % death_explosion_run_L_v1;
  anims[2] = % death_explosion_run_L_v2;
  anims[3] = % death_explosion_up10;
  anims[4] = % death_explosion_right13;
  anims[5] = % death_explosion_run_B_v2;
  anims[6] = % death_explosion_run_B_v1;
  anims[7] = % death_explosion_back13;
  rand1 = 0;
  rand2 = 0;
  rand3 = 0;
  rand1 = randomint(tags.size);
  while(rand1 == rand2 || rand1 == rand3 || rand2 == rand3) {
    rand2 = randomint(tags.size);
    rand3 = randomint(tags.size);
  }
  guy1 = spawn_fake_guy_lvt(self gettagorigin(tags[rand1]), self gettagangles(tags[rand1]), 1, "drone_exploders", undefined, 0);
  guy2 = spawn_fake_guy_lvt(self gettagorigin(tags[rand2]), self gettagangles(tags[rand2]), 1, "drone_exploders", undefined, 0);
  guy3 = spawn_fake_guy_lvt(self gettagorigin(tags[rand3]), self gettagangles(tags[rand3]), 1, "drone_exploders", undefined, 0);
  guy1 animscripted("lvt_explo_out", self gettagorigin(tags[rand1]), self gettagangles(tags[rand1]), anims[rand1]);
  guy2 animscripted("lvt_explo_out", self gettagorigin(tags[rand2]), self gettagangles(tags[rand2]), anims[rand2]);
  guy3 animscripted("lvt_explo_out", self gettagorigin(tags[rand3]), self gettagangles(tags[rand3]), anims[rand3]);
  guy1 thread rag_when_done();
  guy2 thread rag_when_done();
  guy3 thread rag_when_done();
}

rag_when_done() {
  self waittillmatch("lvt_explo_out", "end");
  if(isDefined(self)) {
    self delete();
  }
}

#using_animtree("vehicles");

event1_model3_things_get_owned() {
  artypiece_quakepower = 0.35;
  artypiece_quaketime = 3.0;
  artypiece_quakeradius = 10000;
  self waittill("200mm gun hit");
  obj = spawnStruct();
  obj.origin = level.players_lvt.origin;
  obj.origin = obj.origin + (-400, 1000, 0);
  obj thread maps\_mortar::explosion_boom("water_mortar", artypiece_quakepower, artypiece_quaketime, artypiece_quakeradius, 1);
  thread rumble_all_players("damage_light");
  dead_lvt = getent("wave3_lvts1", "targetname");
  self setturrettargetent(dead_lvt);
  self waittill("200mm gun hit");
  earthquake(artypiece_quakepower, artypiece_quaketime, dead_lvt.origin, artypiece_quakeradius);
  dead_lvt thread lvt_fake_death(1, 1);
  dead_lvt notify("stop float loop");
  thread rumble_all_players("damage_heavy");
  dead_lvt = getent("wave1_lvts2", "targetname");
  self setturrettargetent(dead_lvt);
  self waittill("200mm gun hit");
  earthquake(artypiece_quakepower, artypiece_quaketime, dead_lvt.origin, artypiece_quakeradius);
  dead_lvt thread lvt_fake_death(1, 1);
  dead_lvt notify("stop float loop");
  thread rumble_all_players("damage_heavy");
  self setturrettargetent(level.players_lvt);
  self waittill("200mm gun hit");
  obj = spawnStruct();
  obj.origin = level.players_lvt.origin;
  obj.origin = obj.origin + (-200, 400, 0);
  obj thread maps\_mortar::explosion_boom("water_mortar", artypiece_quakepower, artypiece_quaketime, artypiece_quakeradius, 1);
  thread do_water_drops_on_camera_for_time(4);
  thread do_water_sheeting_on_camera();
  thread rumble_all_players("damage_light");
  self setturrettargetent(level.players_lvt);
  self waittill("200mm gun hit");
  obj = spawnStruct();
  obj.origin = level.players_lvt.origin;
  obj.origin = obj.origin + (0, 300, 0);
  obj thread maps\_mortar::explosion_boom("water_mortar", artypiece_quakepower, artypiece_quaketime, artypiece_quakeradius, 1);
  thread do_water_drops_on_camera_for_time(5);
  thread do_water_sheeting_on_camera();
  thread rumble_all_players("damage_light");
  dead_lvt = getent("wave3_lvts4", "targetname");
  self setturrettargetent(dead_lvt);
  self waittill("200mm gun hit");
  earthquake(artypiece_quakepower, artypiece_quaketime, dead_lvt.origin, artypiece_quakeradius);
  dead_lvt thread lvt_fake_death(1, 1);
  dead_lvt notify("stop float loop");
  thread rumble_all_players("damage_heavy");
  self setturrettargetent(level.players_lvt);
  self waittill("200mm gun hit");
  obj = spawnStruct();
  obj.origin = level.players_lvt.origin;
  obj.origin = obj.origin + (0, 300, 0);
  obj thread maps\_mortar::explosion_boom("water_mortar", artypiece_quakepower, artypiece_quaketime, artypiece_quakeradius, 1);
  thread do_water_drops_on_camera_for_time(5);
  thread do_water_sheeting_on_camera();
  thread rumble_all_players("damage_light");
  dead_lvt = getent("wave2_lvts3", "targetname");
  self setturrettargetent(dead_lvt);
  self waittill("200mm gun hit");
  radiusdamage(dead_lvt.origin + (0, 0, 0), 200, dead_lvt.health + 1000, dead_lvt.health + 500);
  earthquake(artypiece_quakepower, artypiece_quaketime, dead_lvt.origin, artypiece_quakeradius);
  dead_lvt = getent("wave1_lvts5", "targetname");
  dead_lvt notify("stop float loop");
  dead_lvt thread lvt_fake_death(0, 1);
  thread rumble_all_players("damage_heavy");
  dead_lvt = getent("wave2_lvts6", "targetname");
  radiusdamage(dead_lvt.origin + (0, 0, 0), 200, dead_lvt.health + 1000, dead_lvt.health + 500);
  earthquake(artypiece_quakepower, artypiece_quaketime, dead_lvt.origin, artypiece_quakeradius);
  dead_lvt notify("stop float loop");
  self waittill("200mm gun hit");
  dead_lvt = getent("wave1_lvts3", "targetname");
  radiusdamage(dead_lvt.origin + (0, 0, 0), 200, dead_lvt.health + 1000, dead_lvt.health + 500);
  earthquake(artypiece_quakepower, artypiece_quaketime, dead_lvt.origin, artypiece_quakeradius);
  dead_lvt thread lvt_fake_death(0, 1);
  dead_lvt notify("stop float loop");
  thread rumble_all_players("damage_heavy");
  dead_lvt = getent("wave3_lvts2", "targetname");
  radiusdamage(dead_lvt.origin + (0, 0, 0), 200, dead_lvt.health + 1000, dead_lvt.health + 500);
  earthquake(artypiece_quakepower, artypiece_quaketime, dead_lvt.origin, artypiece_quakeradius);
  dead_lvt notify("stop float loop");
  self thread event1_model3_fire_at_random_targets();
}

#using_animtree("generic_human");

event1_model3_fire_at_random_targets() {
  self endon("death");
  artypiece_quakepower = 0.25;
  artypiece_quaketime = 2.25;
  artypiece_quakeradius = 3000;
  structs = getstructarray("water_mortar", "targetname");
  while(isDefined(self)) {
    target_struct = structs[randomint(structs.size)];
    self setturrettargetvec(target_struct.origin);
    self waittill("200mm gun hit");
    target_struct thread maps\_mortar::explosion_boom("water_mortar", artypiece_quakepower, artypiece_quaketime, artypiece_quakeradius, 1);
    thread rumble_all_players("damage_light", "damage_heavy", target_struct.origin, 400, 800);
  }
}

event1_floating_bodies() {
  body_points = getstructarray("floating_bodies", "targetname");
  bodyA = [];
  for(i = 0; i < body_points.size; i++) {
    rand = randomint(4);
    pitchangle = 150;
    if(rand == 0) {
      pitchangle = 0;
    }
    bodyA[i] = spawn_fake_guy_lvt(body_points[i].origin + (0, 0, -15), body_points[i].angles, 1, "blah", "floater", 0);
    bodyA[i].targetname = "floating_body";
    if(rand == 0 || rand == 1) {} else {}
    wait 0.3;
    bodyA[i] startragdoll();
  }
  level waittill("remove floaters");
  level notify("stoploop_floaters");
  for(i = 0; i < bodyA.size; i++) {
    bodyA[i] delete();
  }
}

event1_beach_tanks_setup() {
  stop_points = getvehiclenodearray("beach_tank_stop", "script_noteworthy");
  for(i = 0; i < stop_points.size; i++) {
    stop_points[i] thread event1_beach_tanks_think();
  }
  left_tank_node = getvehiclenode("beach_tank_left_end", "script_noteworthy");
  left_tank_node thread event1_beach_left_end_think();
  right_tank_node = getvehiclenode("beach_tank_right_end", "script_noteworthy");
  right_tank_node thread event1_beach_right_end_think();
}

event1_beach_tanks_think() {
  self waittill("trigger", who);
  who setspeed(0, 15);
  level waittill("start first mortar run");
  who resumespeed(10);
}

event1_beach_left_end_think() {
  self waittill("trigger", who);
  who setspeed(0, 25);
  wait(4);
  radiusdamage(who.origin + (0, 0, 64), 600, who.health + 1000, who.health + 500);
}

event1_beach_right_end_think() {
  self waittill("trigger", who);
  radiusdamage(who.origin + (0, 0, 64), 600, who.health + 1000, who.health + 500);
}

event1_lvt_blowup(node_noteworthy, waittime) {
  node = getvehiclenode(node_noteworthy, "script_noteworthy");
  node waittill("trigger", who);
  wait(waittime);
  radiusdamage(who.origin + (0, 0, 64), 100, who.health + 1000, who.health + 500);
}

event1_lvt_jeep_driver_dies() {
  org = self.attached_jeep gettagorigin("tag_driver");
  ang = self.attached_jeep gettagangles("tag_driver");
  guy = spawn_fake_guy_lvt(org, ang, 1, "drone_jeep_rider", "drone_jeep_rider");
  guy linkto(self.attached_jeep, "tag_driver");
  guy animscripted("single anim", org, ang, % ch_driver_peleliu1_jeep_destroyed);
  self.attached_jeep.attached_guy = guy;
}

event2_setup() {
  thread event2_meet_with_sarge();
  thread event2_trap_door_watcher();
  thread event2_pistol_jap();
  thread event2_fire_walkers();
  thread event2_grenade_death_guy();
  thread event2_redshirt_reinforce_begin();
  thread event2_dazed_guys();
  thread event2_treeguy_dialogue();
  thread event2_grass_guy_dialogue();
  thread event3_setup();
  thread event2_weapon_pickups();
  thread event2_left_amtank_setup();
  thread event2_delete_vehicles_on_warp();
}

event2_weapon_pickups() {
  thread weapon_cleanup();
  trig1 = getent("crater1", "targetname");
  trig2 = getent("crater2", "targetname");
  trig3 = getent("crater3", "targetname");
  trig1 waittill("trigger");
  trig2 waittill("trigger");
  trig3 waittill("trigger", who);
  wait 10;
  if(isDefined(who) && who istouching(trig3)) {
    setbusstate("EASTER");
    starts1 = getEntArray("gun01", "targetname");
    starts2 = getEntArray("gun02", "targetname");
    starts3 = getEntArray("gun03", "targetname");
    starts4 = getEntArray("gun04", "targetname");
    starts1[0] moveto(starts1[0].origin + (0, 0, 500), 10, 6, 3);
    starts2[0] moveto(starts2[0].origin + (0, 0, 500), 10, 6, 3);
    starts3[0] moveto(starts3[0].origin + (0, 0, 500), 10, 6, 3);
    starts4[0] moveto(starts4[0].origin + (0, 0, 500), 10, 6, 3);
    starts1[1] moveto(starts1[1].origin + (0, 0, 500), 10, 6, 3);
    starts2[1] moveto(starts2[1].origin + (0, 0, 500), 10, 6, 3);
    starts3[1] moveto(starts3[1].origin + (0, 0, 500), 10, 6, 3);
    starts4[1] moveto(starts4[1].origin + (0, 0, 500), 10, 6, 3);
    if(SoundExists("Pel1_IGD_900A_JAS2_ST")) {
      playsoundatposition("Pel1_IGD_900A_JAS2_ST", starts1[0].origin + (0, 0, 500));
    }
    earthquake(0.3, 16, starts1[0].origin + (0, 0, 500), 2000);
    playsoundatposition("earthquake", (0, 0, 0));
    thread rumble_all_players("damage_light", "damage_heavy", starts1[0].origin + (0, 0, 500), 400, 800);
    starts = getEntArray("r_gun_trigs", "targetname");
    for(i = 0; i < starts.size; i++) {
      starts[i] thread do_give();
    }
    level notify("rg_weapons_avail");
    level thread timer_for_bus(12);
  }
}

timer_for_bus(time) {
  wait(time);
  setbusstate("return_default_slow");
}

do_give(weapon) {
  wait 10;
  self.origin = self.origin + (0, 0, 500);
  while(1) {
    self waittill("trigger", who);
    primaryWeapons = who GetWeaponsListPrimaries();
    current_weapon = undefined;
    if(primaryWeapons.size >= 2) {
      current_weapon = who getCurrentWeapon();
      if(isDefined(current_weapon)) {
        who TakeWeapon(current_weapon);
      }
    }
    if(isDefined(primaryWeapons) && !isDefined(current_weapon)) {
      for(i = 0; i < primaryWeapons.size; i++) {
        who TakeWeapon(primaryWeapons[i]);
      }
    }
    who GiveWeapon("ray_gun", 0);
    who GiveMaxAmmo("ray_gun");
    who SwitchToWeapon("ray_gun");
  }
}

weapon_cleanup() {
  level endon("rg_weapons_avail");
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      primaryWeapons = players[i] GetWeaponsListPrimaries();
      if(isDefined(primaryWeapons)) {
        for(x = 0; x < primaryWeapons.size; x++) {
          if(primaryWeapons[x] == "ray_gun") {
            players[i] TakeWeapon(primaryWeapons[x]);
          }
        }
      }
    }
    wait 0.2;
  }
}

event2_delete_vehicles_on_warp() {
  trigger_wait("first_fight_warp", "script_noteworthy");
  vehicles = getEntArray("script_vehicle", "classname");
  for(i = 0; i < vehicles.size; i++) {
    vehicles[i] notify("death");
    vehicles[i] delete();
  }
}

event2_left_amtank_setup() {
  node = getvehiclenode("left_side_amtank_stop1", "script_noteworthy");
  node waittill("trigger", who);
  who setspeed(0, 10);
  wait 15;
  waittill_aigroupcount("trench_jumpdown_guys", 0);
  who resumespeed(10);
}

event2_treeguy_dialogue() {
  trigger_wait("tree_sniper_start", "script_noteworthy");
  level notify("grass_guys_dialog");
  wait 1.5;
  level.sarge anim_single_solo(level.sarge, "tree_area1");
  level.sarge anim_single_solo(level.sarge, "tree_area2");
  wait 1;
  level.polo anim_single_solo(level.polo, "tree_area3");
  wait 1;
  level.sarge anim_single_solo(level.sarge, "tree_area4");
}

event2_grass_guy_dialogue() {
  flag_wait("grass_attack1");
  level.sarge anim_single_solo(level.sarge, "tree_area6");
  level.sarge anim_single_solo(level.sarge, "tree_area7");
  wait 1.5;
  level.sarge anim_single_solo(level.sarge, "tree_area8");
  wait 1.5;
  level.polo anim_single_solo(level.polo, "tree_area9");
  flag_wait("grass_attack2");
  wait 1;
  level.sullivan anim_single_solo(level.sullivan, "tree_area10");
  waittill_aigroupcount("ev1_grassguys1", 0);
  waittill_aigroupcount("ev1_grassguys2", 0);
  wait 1;
  trig = getent("post_grass_moveup1", "targetname");
  if(isDefined(trig)) {
    trig notify("trigger");
  }
  wait 2;
  level.sullivan anim_single_solo(level.sullivan, "tree_area12");
  wait 1;
  level.sarge anim_single_solo(level.sarge, "tree_area13");
  wait 0.5;
  level.sarge anim_single_solo(level.sarge, "tree_area14");
}

event2_dazed_guys() {
  level waittill("start first mortar run");
  if(is_german_build()) {
    trig = getent("spawn_dazed", "targetname");
    trig delete();
  } else {
    getent("spawn_dazed", "targetname") useby(get_players()[0]);
  }
  level notify("remove floaters");
}

event2_dazed_die_over_time() {
  self endon("death");
  self endon("damage");
  wait(randomfloatrange(7, 11));
  self.deathanim = self.possibledeathanim;
  self dodamage(self.health + 1, self.origin + (0, 0, randomintrange(16, 64)));
}

event2_over_the_berm_anims() {
  wait(0.1);
  ref_point = getstruct("over_reference", "targetname");
  guys = grab_starting_guys();
  guys = array_remove(guys, level.sarge);
  for(i = 0; i < guys.size; i++) {
    guys[i] thread event2_over_berm_anim_think(ref_point, i);
  }
}

event2_over_berm_anim_think(ref_point, point_num) {
  self disable_ai_color();
  self endon("death");
  while(self.origin[1] < -11256) {
    wait 0.1;
  }
  self.animname = "berm" + (point_num + 1);
  if(self == level.sarge) {
    self.animname = "sarge";
  }
  self anim_reach_solo(self, "over", undefined, ref_point);
  self allowedstances("crouch");
  wait 0.5;
  flag_wait("over_berm_flag");
  if(self == level.sullivan) {
    level notify("stop color dialog");
    thread sullivan_over_sounds();
  }
  if(self == level.sarge) {
    wait_for_berm3 = false;
    ai = getaiarray("allieS");
    for(i = 0; i < ai.size; i++) {
      if(ai[i].animname == "berm3") {
        wait_for_berm3 = true;
        if(self != level.polo && self != level.sarge && self != level.sullivan && self != level.radioguy) {
          ai[i] thread magic_bullet_shield();
        }
      }
    }
    if(wait_for_berm3) {
      flag_wait("over_berm_3_flag");
    }
  }
  self anim_single_solo(self, "over", undefined, ref_point);
  if(self.animname == "berm3") {
    flag_set("over_berm_3_flag");
    if(self != level.polo && self != level.sarge && self != level.sullivan && self != level.radioguy) {
      self thread stop_magic_bullet_shield();
    }
  }
  trig = getent("event2_foxhole_colorgroup", "targetname");
  if(isDefined(trig)) {
    trig notify("trigger");
  }
  if(self == level.polo) {
    self.animname = "polo";
    flag_set("polo_over_berm");
  }
  if(self == level.sullivan) {
    self.animname = "sullivan";
    flag_set("sullivan_over_berm");
  }
  if(self == level.sarge) {
    flag_set("sarge_over_berm");
  }
  self allowedstances("crouch", "stand", "prone");
  self enable_ai_color();
}

sullivan_over_sounds() {
  wait 1.0;
  level.sullivan playSound(level.scr_sound["sullivan"]["moveup_beach6"]);
  flag_wait("polo_over_berm");
  level.polo playSound(level.scr_sound["polo"]["over_berm1"]);
  wait 1.5;
  flag_wait("sarge_over_berm");
  level.sarge playSound(level.scr_sound["sarge"]["over_berm2"]);
}

event2_redshirt_reinforce_begin() {
  trig = getent("initial_spawn", "script_noteworthy");
  trig waittill("trigger");
  reds = get_force_color_guys("allies", "r");
  greens = get_force_color_guys("allies", "g");
}

event2_grenade_death_guy() {
  if(is_german_build()) {
    return;
  }
  level endon("stop_suicide");
  thread event2_grenade_guys_ender();
  getent("event2_grenade_death_guy_trig", "targetname") waittill("trigger");
  org = getstruct("event2_grenade_death_guy_spot", "targetname");
  spawner = getent(org.targetname, "target");
  guy = spawn_fake_guy_lvt(org.origin, org.angles, 0, "grenade_jap", "grenade_jap", 0);
  guy.a.gib_ref = "right_arm";
  guy thread do_gib_after_time(4);
  guy thread anim_single_solo(guy, "suicide", undefined, org);
}

event2_grenade_guys_ender() {
  trigger_wait("dont_do_suicide", "targetname");
  level notify("stop_suicide");
}

do_gib_after_time(time_wait) {
  wait(time_wait);
  self thread animscripts\death::do_gib();
}

event2_fire_walkers() {
  getent("event2_fire_wallkers_trig", "targetname") waittill("trigger");
  level.flameguy thread event2_flame_ambient();
  ambient_turret = getent("ambient_side_mg", "targetname");
  level thread event2_ambient_mg_crush();
  ambient_turret.manual_targets = getEntArray(ambient_turret.target, "targetname");
  ambient_turret.manual_targets[0] thread move_mg_target(ambient_turret);
  ambient_turret SetMode("auto_nonai");
  ambient_turret thread maps\_mgturret::burst_fire_unmanned();
  unmanned = true;
  level thread event2_ambient_battle_watcher();
  level.flameguy enable_ai_color();
  thread event2_first_fight_dialogue();
  thread event2_flame_walk_out_fx();
  wait 10;
  level.flameguy enable_ai_color();
}

event2_ambient_battle_watcher() {
  flag_wait("ambient_moveup");
  mg = getent("ambient_side_mg", "targetname");
  thread clean_up_ambient_stuff();
}

move_mg_target(ambient_turret) {
  ambient_turret endon("death");
  while(1) {
    self moveto((2632, -7357, -241.666), 2);
    wait randomfloatrange(1, 3);
    self moveto((2952, -7320, -216.542), 2);
  }
}

event2_flame_walk_out_death() {
  self endon("death");
  self waittill("single anim");
  self dodamage(self.health + 10, (0, 0, 0));
}

event2_flame_walk_out_fx() {
  fx1 = getstruct("event2_walkflame_point1", "targetname");
  fx2 = getstruct("event2_walkflame_point2", "targetname");
  playFX(level._effect["bunker_fire_out"], fx1.origin + (0, 0, 32), anglesToForward(fx1.angles));
  wait(0.25);
  playFX(level._effect["bunker_fire_out"], fx2.origin + (0, 0, 32), anglesToForward(fx2.angles));
  wait 0.25;
  playFX(level._effect["bunker_fire_out"], fx2.origin + (0, 0, 32), anglesToForward(fx2.angles));
  wait(0.25);
  playFX(level._effect["bunker_fire_out"], fx1.origin + (0, 0, 32), anglesToForward(fx1.angles));
  wait 0.5;
  playFX(level._effect["bunker_fire_out"], fx1.origin + (0, 0, 32), anglesToForward(fx1.angles));
  wait(0.5);
  playFX(level._effect["bunker_fire_out"], fx2.origin + (0, 0, 32), anglesToForward(fx2.angles));
  wait 0.75;
  playFX(level._effect["bunker_fire_out"], fx2.origin + (0, 0, 32), anglesToForward(fx2.angles));
  wait(0.25);
  playFX(level._effect["bunker_fire_out"], fx1.origin + (0, 0, 32), anglesToForward(fx1.angles));
  wait 0.5;
  playFX(level._effect["bunker_fire_out"], fx1.origin + (0, 0, 32), anglesToForward(fx1.angles));
  wait(0.5);
  playFX(level._effect["bunker_fire_out"], fx2.origin + (0, 0, 32), anglesToForward(fx2.angles));
  level notify("bunker_busted");
  setmusicstate("FIRST_FIGHT");
}

event2_first_fight_dialogue() {
  level endon("grass_guys_dialog");
  flag_wait("past_flame_mg");
  level.sarge.animname = "sarge";
  level.sullivan.animname = "sullivan";
  level.polo.animname = "polo";
  players = get_players();
  if(distance(players[0].origin, level.sarge.origin) < 1500) {
    battlechatter_on();
    wait 2;
    banzai = get_living_ai("first_banzai_guy", "script_noteworthy");
    friendlies = getaiarray("allies");
    if(isDefined(banzai) && isalive(banzai)) {
      canseeai = false;
      for(i = 0; i < friendlies.size; i++) {
        if(friendlies[i] cansee(banzai)) {
          level.sarge anim_single_solo(level.sarge, "first_fight2");
          break;
        }
      }
    }
    wait 3;
    level.sarge anim_single_solo(level.sarge, "first_fight3");
    wait 2;
    level.sarge anim_single_solo(level.sarge, "first_fight4");
    wait 3;
    level.sarge anim_single_solo(level.sarge, "first_fight5");
    level.sullivan anim_single_solo(level.sullivan, "first_fight6");
    wait 3;
    level.sullivan anim_single_solo(level.sullivan, "first_fight7");
    wait 3;
  }
  flag_wait("over_wall_attackers");
  BadPlacesEnable(1);
  wait 2;
  level.sarge anim_single_solo(level.sarge, "first_fight11");
  wait 4;
  level.sarge anim_single_solo(level.sarge, "first_fight12");
  wait 12;
  level.sarge anim_single_solo(level.sarge, "first_fight9");
  wait 10;
  level.sullivan anim_single_solo(level.sullivan, "first_fight10");
}

event2_pistol_jap() {
  if(is_german_build()) {
    return;
  }
  org = getstruct("event2_pistol_jap", "targetname");
  guy = spawn_fake_guy_lvt(org.origin, org.angles, 0, "pistol_jap", "pistol_jap", 0);
  guy makeFakeAI();
  guy setCanDamage(true);
  guy.team = "axis";
  guy.health = 5;
  guy UseAnimTree(#animtree);
  guy attach("weapon_jap_nambu_pistol", "tag_weapon_right");
  thread addNotetrack_customFunction("pistol_jap", "fire", ::event2_jap_pistol_fire, "fire");
  guy thread anim_loop_solo(guy, "grab_loop", undefined, "stop_grabbing", org);
  guy thread event2_pistol_jap_think(org);
  guy thread event2_jap_pistol_death(org);
}

event2_pistol_jap_think(org) {
  self endon("death");
  self endon("damage");
  trig = getent("event2_pistol_jap_start_fire", "targetname");
  trig waittill("trigger");
  self notify("stop_grabbing");
  self anim_single_solo(self, "fire", undefined, org);
  self notify("death");
}

event2_jap_pistol_fire(guy) {
  playFXOnTag(level._effect["pistol_flash"], guy, "tag_flash");
  magicbullet("nambu", self.origin - (0, 0, 59), self.origin - (0, 0, 60));
  dam_trig = getent("event2_pistol_jap_fire_dam", "targetname");
  players = get_players();
  player = players[randomint(players.size)];
  if(player istouching(dam_trig)) {
    player dodamage(10, guy.origin);
  }
}

event2_jap_pistol_death(org) {
  self thread event2_jap_pistol_death_assign_points();
  self waittill_any("damage", "death");
  self anim_single_solo(self, "death", undefined, org);
  self startragdoll();
}

event2_jap_pistol_death_assign_points() {
  self endon("death");
  self waittill("damage", amount, who);
  if(isplayer(who)) {
    arcademode_assignpoints("arcademode_score_generic100", who);
  }
}

event3_setup() {
  level.sarge.animname = "sarge";
  level.sullivan.animname = "sullivan";
  level.polo.animname = "polo";
  thread event3_dialogue();
  thread event3_into_bunker_dialogue();
  thread event3_into_bunker_dialogue2();
  thread event3_upstairs_dialogue();
  thread event3_last_bunker_rocket_damage_think();
  thread event3_flank_right_flag_set();
  thread event3_tanks();
  thread event3_suppressed_amtank();
  thread event3_setup_tunnel_radio();
  thread event3_clean_up_enemies();
  thread event3_mortar_checker();
}

event3_clean_up_enemies() {
  trigger_wait("obj_entrance_gained", "targetname");
  no_zone_mover = getent("no_zone_mover", "script_noteworthy");
  no_zone_mover.origin = no_zone_mover.origin + (0, 0, 10000);
  ai = getaiarray("axis");
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i]) && isalive(ai[i]) && ai[i].origin[1] < -4090) {
      ai[i] thread bloody_death();
      wait randomfloatrange(0.75, 3.0);
    }
  }
}

event3_setup_tunnel_radio() {
  broken_radio = "radio_jap_bro";
  radio = getent("tunnel_radio", "targetname");
  radio playLoopSound("pel1_radio");
  broken = false;
  radio setCanDamage(true);
  radio waittill("damage", amount, who);
  arcademode_assignpoints("arcademode_score_generic500", who);
  playFX(level._effect["broken_radio_spark"], radio.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(1, 10)));
  radio stoploopsound();
  radio playSound("radio_destroyed");
  radio setModel(broken_radio);
  for(i = 0; i < 12; i++) {
    wait(randomfloatrange(1, 3));
    playFX(level._effect["broken_radio_spark"], radio.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(1, 10)));
    radio playSound("radio_destroyed");
  }
}

event3_last_bunker_rocket_damage_think() {
  area = getent("big_bunker_damage_area", "targetname");
  spawner1 = getent("rocketman_delete1", "script_noteworthy");
  spawner2 = getent("rocketman_delete2", "script_noteworthy");
  area.remove_spawner = false;
  while(1) {
    area waittill("damage", damage, other, direction, origin, damage_type);
    if(damage_type == "MOD_CRUSH") {
      level notify("bunker_crushed");
      area thread event3_rocket_remove_spawner(spawner1, spawner2);
      axis = getaiarray("axis");
      for(i = 0; i < axis.size; i++) {
        if(axis[i] istouching(area)) {
          axis[i] dodamage(axis[i].health + 10, (0, 0, 0));
        }
      }
    }
  }
}

event1_small_bunker_rocket_damage_think() {
  area = getent("small_bunker_damage_area", "targetname");
  while(1) {
    area waittill("damage", damage, other, direction, origin, damage_type);
    if(damage_type == "MOD_CRUSH") {
      axis = getaiarray("axis");
      for(i = 0; i < axis.size; i++) {
        if(axis[i] istouching(area)) {
          axis[i] dodamage(axis[i].health + 10, (0, 0, 0));
          playsoundatposition("rocket_target_explo", (1944, -6304, -144));
          return;
        }
      }
    }
  }
}

event2_ambient_mg_crush() {
  area = getent("crush_ambient_mg", "targetname");
  while(1) {
    area waittill("damage", damage, other, direction, origin, damage_type);
    if(damage_type == "MOD_CRUSH") {
      mg = getent("ambient_side_mg", "targetname");
      if(isDefined(mg)) {
        if(mg istouching(area)) {
          thread clean_up_ambient_stuff();
          return;
        }
      }
    }
  }
}

clean_up_ambient_stuff() {
  mg = getent("ambient_side_mg", "targetname");
  if(isDefined(mg)) {
    mg notify("death");
    mg delete();
  }
  level.flameguy clearentitytarget();
  level.flameguy notify("stop_flaming");
  trig = getent("auto6310", "target");
  if(isDefined(trig)) {
    trig delete();
  }
  trig = getent("auto6309", "target");
  if(isDefined(trig)) {
    trig delete();
  }
  wait 5;
  trig = getent("ambient_moveup_orange", "script_noteworthy");
  if(isDefined(trig)) {
    trig notify("trigger");
  }
  trig = getent("auto6348", "target");
  if(isDefined(trig)) {
    trig notify("trigger");
  }
  thread remove_flame_guy();
}

remove_flame_guy() {
  if(isDefined(level.flameguy)) {
    level.flameguy waittill("goal");
    if(isDefined(level.flameguy)) {
      level.flameguy notify("_disable_reinforcement");
      level.flameguy stop_magic_bullet_shield();
      level.flameguy delete();
    }
  }
}

event3_rocket_remove_spawner(spawner1, spawner2) {
  if(self.remove_spawner) {
    return;
  }
  self.remove_spawner = true;
  if(isDefined(spawner1)) {
    playsoundatposition("rocket_target_explo", spawner1.origin);
    spawner1 delete();
    wait 10;
    self.remove_spawner = false;
    return;
  } else if(isDefined(spawner2)) {
    playsoundatposition("rocket_target_explo", spawner2.origin);
    spawner2 delete();
    wait 10;
    self.remove_spawner = false;
    return;
  }
}

event3_dialogue() {
  trigger_wait("post_grass_moveup2", "targetname");
  level.sarge set_force_color("g");
  level endon("going into tunnels");
  level.sarge anim_single_solo(level.sarge, "third_fight1");
  wait 1;
  level.sullivan anim_single_solo(level.sullivan, "third_fight2");
  waittill_aigroupcount("tunnel_banzaiers", 0);
  wait 1;
  level.sullivan anim_single_solo(level.sullivan, "last_fight3");
  wait 2;
  level thread event3_player_stays_in_the_open_leftside();
  trigger_wait("event3_flank_tunnel1", "targetname");
  level.sarge anim_single_solo(level.sarge, "third_fight4");
  trigger_wait("event3_flank_tunnel2", "targetname");
  level.sarge anim_single_solo(level.sarge, "third_fight5");
  trigger_wait("event3_flank_tunnel3", "targetname");
  level.sarge anim_single_solo(level.sarge, "third_fight6");
  trigger_wait("event3_flank_tunnel4", "targetname");
  level.sarge anim_single_solo(level.sarge, "third_fight7");
  wait 3;
  level.sarge anim_single_solo(level.sarge, "third_fight8");
}

event3_into_bunker_dialogue() {
  level endon("stop_into_bunker_dialogue");
  trig = getent("event3_into_final_bunker", "targetname");
  trigorg = trig.origin;
  trigger_wait("event3_into_final_bunker", "targetname");
  level.sarge set_force_color("r");
  guys_near_player_and_trig = false;
  while(!guys_near_player_and_trig) {
    if(distance(trigorg, level.sullivan.origin) < 500) {
      nearest_player = get_closest_player(trigorg);
      if(distance(nearest_player.origin, level.sullivan.origin) < 500) {
        guys_near_player_and_trig = true;
      }
    }
    wait 0.1;
  }
  level.sullivan anim_single_solo(level.sullivan, "final_bunker1");
  level.sarge anim_single_solo(level.sarge, "final_bunker2");
  level.sullivan anim_single_solo(level.sullivan, "final_bunker3");
}

event3_into_bunker_dialogue2() {
  level endon("stop_inside_bunker_dialogue");
  trigger_wait("event3_into_final_bunker2", "targetname");
  wait 2;
  level notify("stop_into_bunker_dialogue");
  level.sarge anim_single_solo(level.sarge, "final_bunker4");
  wait 1.25;
  level.sarge anim_single_solo(level.sarge, "final_bunker5");
}

event3_upstairs_dialogue() {
  trigger_wait("event2_after_trap_door_fc", "targetname");
  level notify("stop_inside_bunker_dialogue");
  wait 3;
  level.sarge.animname = "sarge";
  level.sullivan.animname = "sullivan";
  level.sarge anim_single_solo(level.sarge, "final_bunker6");
  level.sarge anim_single_solo(level.sarge, "final_bunker7");
  level.sullivan anim_single_solo(level.sullivan, "final_bunker8");
  level.sarge thread tell_player_to_use_rockets();
  waittill_aigroupcount("mortar_squads", 4);
  level.sarge anim_single_solo(level.sarge, "final_bunker9");
  flag_wait("end_tanks_dead");
  waittill_aigroupcount("mortar_squads", 0);
  level notify("end_cleared");
  level.sullivan anim_single_solo(level.sullivan, "final_bunker10");
  level notify("mortar guys dead");
  thread event3_drones_moveup();
  setmusicstate("END_LEVEL");
  level.sarge anim_single_solo(level.sarge, "final_bunker11");
  level.sullivan anim_single_solo(level.sullivan, "final_bunker12");
}

tell_player_to_use_rockets() {
  level endon("end tank died");
  wait 3;
  level.sarge anim_single_solo(level.sarge, "use_rockets_end4");
  level.sarge anim_single_solo(level.sarge, "use_rockets_end2");
  while(1) {
    wait 12;
    level.sarge anim_single_solo(level.sarge, "use_rockets_end3");
    level.sarge anim_single_solo(level.sarge, "use_rockets_end1");
    wait 12;
    level.sarge anim_single_solo(level.sarge, "use_rockets_end4");
    level.sarge anim_single_solo(level.sarge, "use_rockets_end2");
  }
}

event3_drones_moveup() {
  flag_wait("end_tanks_dead");
  drones = getEntArray("run_n_gun_drones", "script_noteworthy");
  for(i = 0; i < drones.size; i++) {
    drones[i] notify("Stop shooting");
    if(i % 4 == 0) {
      wait 0.5;
    }
  }
}

event1_lci_rocket_fire(dest_point, start_points, do_aftermath, is_player_controlled, which_player) {
  thread play_sound_in_space("rocket_launch", start_points[0]);
  if(isDefined(do_aftermath)) {
    level thread event1_lci_aftermath_effect();
  }
  for(i = 0; i < start_points.size; i++) {
    rocket = spawn("script_model", start_points[i]);
    rocket setModel("peleliu_aerial_rocket");
    yaw_vec = vectortoangles(dest_point - rocket.origin);
    rocket.angles = (315, yaw_vec[1], 0);
    wait(0.01);
    playFX(level._effect["rocket_launch"], rocket.origin, anglesToForward(rocket.angles + (20, 0, 0)));
    playFXOnTag(level._effect["rocket_trail"], rocket, "tag_origin");
    rocket playLoopSound("rocket_run");
    if(isDefined(do_aftermath) && do_aftermath) {
      rocket thread event1_lci_rocket_fly_think((dest_point[0] - 1000 + randomint(2000), dest_point[1] - 1000 + randomint(2000), dest_point[2] + randomint(40)));
    } else {
      rocket thread event1_lci_simple_rocket_fly_think((dest_point[0] - 1000 + randomint(2000), dest_point[1] - 1000 + randomint(2000), dest_point[2] + randomint(40)));
    }
    wait(randomfloatrange(0.1, 0.2));
  }
}

event1_lci_aftermath_effect() {
  level waittill("do aftermath");
  playFX(level._effect["rocket_aftermath"], (2071, -8481, -314.8));
  playsoundatposition("rocket_target_explo", (2036, -10207, -295.9));
}

event1_lci_rocket_fly_think(destination_pos) {
  setmusicstate("PLAYER_ROCKETS");
  thread throw_object_with_gravity(self, destination_pos);
  while(1) {
    if(self.origin[2] < -450) {
      if(self.origin[1] < -9552) {
        playFX(level._effect["lci_rocket_impact"], self.origin);
        playsoundatposition("rocket_impact", self.origin);
        thread play_sound_in_space("rocket_dirt", self.origin);
      } else {
        rand = randomint(5);
        if(rand == 0) {
          playFX(level._effect["lci_rocket_impact"], self.origin);
          playsoundatposition("rocket_impact", self.origin);
        }
        playsoundatposition("mortar_dirt", self.origin);
      }
      self stoploopsound(1);
      earthquake(0.5, 3, self.origin, 6050);
      thread main_rocket_rumble();
      level notify("start removing trees");
      break;
    }
    wait(0.05);
  }
  level notify("do aftermath");
  clientnotify("bfe");
  flag_clear("ambients_on");
  self notify("remove thrown object");
  wait(2);
  self delete();
}

main_rocket_rumble() {
  thread rumble_all_players("damage_heavy");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    level.players_lvt PlayRumbleLoopOnEntity("tank_rumble");
  }
  wait 7;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] StopRumble("tank_rumble");
  }
}

event1_lci_simple_rocket_fly_think(destination_pos) {
  thread throw_object_with_gravity(self, destination_pos);
  while(1) {
    if(self.origin[2] < -450) {
      playFX(level._effect["lci_rocket_impact"], self.origin);
      self stoploopsound(1);
      playsoundatposition("rocket_impact", self.origin);
      earthquake(0.5, 3, self.origin, 2050);
      break;
    }
    wait(0.05);
  }
  self notify("remove thrown object");
  wait(2);
  self delete();
}

event1_rocket_impact_think() {
  things_to_damage = getEntArray("script_model", "classname");
  level waittill("start removing trees");
  playsoundatposition("fake_rockets_L", (2036, -10207, -295.9));
  playsoundatposition("fake_rockets_R", (1036, -10207, -295.9));
  for(i = 0; i < things_to_damage.size; i++) {
    if(isDefined(things_to_damage[i]) && (things_to_damage[i].model == "foliage_cod5_tree_maple_02_large" || things_to_damage[i].model == "foliage_pacific_palms01" || things_to_damage[i].model == "foliage_pacific_palms02" ||
        things_to_damage[i].model == "foliage_pacific_forest_shrubs03" || things_to_damage[i].model == "foliage_pacific_forest_shrubs01")) {
      if(things_to_damage[i].model == "foliage_cod5_tree_maple_02_large" || things_to_damage[i].model == "foliage_pacific_palms01" || things_to_damage[i].model == "foliage_pacific_palms02") {
        stumps = [];
        stumps[0] = "foliage_pacific_snapped_palms01";
        stumps[1] = "foliage_pacific_snapped_palms04";
        stumps[2] = "foliage_pacific_snapped_palms04a";
        stumps[3] = "foliage_pacific_snapped_palms04b";
        stumps[4] = "foliage_pacific_snapped_palms04c";
        if(things_to_damage[i].origin[0] > 1450 && things_to_damage[i].origin[0] < 2500) {
          if(things_to_damage[i].origin[1] > -10300 && things_to_damage[i].origin[1] < -8400) {
            things_to_damage[i] thread event2_tree_rotate_and_delete();
          }
        } else {
          rand = randomint(5);
          if(rand == 0) {
            playFX(level._effect["palms01"], things_to_damage[i].origin, anglesToForward(things_to_damage[i].angles + (270, 0, 0)));
          } else if(rand == 1) {
            playFX(level._effect["palms04"], things_to_damage[i].origin, anglesToForward(things_to_damage[i].angles + (270, 0, 0)));
          } else if(rand == 2) {
            playFX(level._effect["palms04a"], things_to_damage[i].origin, anglesToForward(things_to_damage[i].angles + (270, 0, 0)));
          } else if(rand == 3) {
            playFX(level._effect["palms04b"], things_to_damage[i].origin, anglesToForward(things_to_damage[i].angles + (270, 0, 0)));
          } else if(rand == 4) {
            playFX(level._effect["palms04c"], things_to_damage[i].origin, anglesToForward(things_to_damage[i].angles + (270, 0, 0)));
          }
          playsoundatposition("tree_fall", things_to_damage[i].origin);
          things_to_damage[i] thread event2_tree_rotate_and_delete();
        }
      } else if(things_to_damage[i].model == "foliage_pacific_forest_shrubs03" || things_to_damage[i].model == "foliage_pacific_forest_shrubs01") {
        things_to_damage[i] thread event2_tree_rotate_and_delete();
      }
    }
  }
}

event2_tree_rotate_and_delete() {
  wait randomfloatrange(1, 4);
  self rotateto((180, 270, 0), 1.5, 0.6, 0.1);
  wait 1.8;
  self delete();
}

event2_meet_with_sarge() {
  thread set_objective(1);
  thread event2_open_fire();
  thread event2_over_the_berm_anims();
  trigger_wait("ev1_near_berm", "script_noteworthy");
  flag_set("jog_enabled");
  event1_jog_the_ai();
  thread event1_sarge_over_berm();
  level.sullivanplaySound(level.scr_sound["sullivan"]["moveup_beach6a"]);
  level notify("start first mortar run");
  drones = getEntArray("drone", "targetname");
  for(i = 0; i < drones.size; i++) {
    drones[i] notify("drone out of cover");
  }
  getent("event2_foxhole_colorgroup", "targetname") useby(get_players()[0]);
  ai = getaiarray("allies");
  for(i = 0; i < ai.size; i++) {
    ai[i] set_ignoreall(true);
  }
  flag_init("flame_the_bunker");
  flag_clear("flame_the_bunker");
  trigger_wait("ev2_player_neaby_foxhole", "targetname");
  level thread event2_flame_the_bunker();
  level waittill("bunker_getting_flamed");
  wait(4);
  wait 2;
  level notify("flame guy is flaming bunker");
  wait 2;
  smolderpoint = getstruct("event1_bunker_smolder", "targetname");
  playFX(level._effect["bunker_fire_smolder"], smolderpoint.origin, anglesToForward(smolderpoint.angles));
  flag_set("flame_the_bunker");
  level notify("moving up after flame");
  wait(1);
  level.sarge enable_ai_color();
  thread event2_use_and_remove_first_line_color_trigs();
  ai = getaiarray("allies");
  for(i = 0; i < ai.size; i++) {
    ai[i] set_ignoreall(false);
  }
}

event1_jog_the_ai() {
  ai = getaiarray("allies");
  for(i = 0; i < ai.size; i++) {
    ai[i] thread jog_internal();
  }
}

event2_main_rocket_attack() {
  level waittill("do big barrage");
  level.radioguy thread anim_single_solo(level.radioguy, "rb_confirm_main");
  wait 5;
  num_rockets = 36;
  num_rockets_per_ship = 12;
  pa_fire = getent("pa_fire_right", "targetname");
  playsoundatposition("pa_fire", pa_fire.origin);
  wait(0.4);
  pa_fire_b = getent("pa_fire_left", "targetname");
  pa_fire_b playSound("pa_fire");
  start_points = [];
  orgs = getstructarray("rocketbarrage_points2", "targetname");
  q = 0;
  for(i = 0; i < num_rockets; i++) {
    q = i % num_rockets_per_ship;
    start_points[i] = orgs[q].origin;
  }
  level thread event1_rocket_impact_think();
  level thread event1_lci_rocket_fire((2041, -8080, -535.5), start_points, 1);
  start_points = [];
  orgs = getstructarray("rocketbarrage_points1", "targetname");
  q = 0;
  for(i = 0; i < num_rockets; i++) {
    q = i % num_rockets_per_ship;
    start_points[i] = orgs[q].origin;
  }
  level thread event1_lci_rocket_fire((2041, -8080, -535.5), start_points, 1);
}

event2_reply_to_sarge() {
  level.sarge anim_single_solo(level.sarge, "sarge_in_hole");
}

event2_flame_the_bunker() {
  level.flameguy = pel1_ai_spawner("flame_guy_spawner");
  flag_set("flameguy_spawned");
  level.flameguy disable_ai_color();
  level.flameguy.goalradius = 32;
  level.flameguy setgoalnode(getnode("event2_flameguy_flamenode", "targetname"));
  level.flameguy.animname = "jonesy";
  level.flameguy thread magic_bullet_shield();
  level.flameguy.cansee_override = 1;
  og_shootTime_min = level.flameguy.a.flamethrowerShootTime_min;
  og_shootTime_max = level.flameguy.a.flamethrowerShootTime_max;
  level.flameguy.a.flamethrowerShootTime_min = 10000;
  level.flameguy.a.flamethrowerShootTime_max = 15000;
  og_DelayTime_min = level.flameguy.a.flamethrowerShootDelay_min;
  og_DelayTime_max = level.flameguy.a.flamethrowerShootDelay_max;
  level.flameguy.a.flamethrowerShootDelay_min = 0;
  level.flameguy.a.flamethrowerShootDelay_max = 1;
  org = spawn("script_origin", (2171, -7800, -294));
  targets = [];
  targets[0] = (2000, -8000, -180);
  targets[1] = (2180, -8000, -220);
  level.flameguy waittill("goal");
  level.flameguy SetEntityTarget(org);
  wait(1);
  level notify("bunker_getting_flamed");
  while(!flag("flame_the_bunker")) {
    for(i = 0; i < targets.size; i++) {
      time = 1.5;
      org MoveTo(targets[i], time);
      org waittill("movedone");
    }
  }
  level.flameguy ClearEntityTarget();
  org Delete();
  level.flameguy.a.flamethrowerShootTime_min = og_shootTime_min;
  level.flameguy.a.flamethrowerShootTime_max = og_shootTime_max;
  level.flameguy.a.flamethrowerShootDelay_min = og_DelayTime_min;
  level.flameguy.a.flamethrowerShootDelay_max = og_DelayTime_max;
  level.flameguy.cansee_override = undefined;
}

event2_flame_ambient() {
  self endon("stop_flaming");
  level.flameguy.cansee_override = 1;
  og_shootTime_min = level.flameguy.a.flamethrowerShootTime_min;
  og_shootTime_max = level.flameguy.a.flamethrowerShootTime_max;
  level.flameguy.a.flamethrowerShootTime_min = 10000;
  level.flameguy.a.flamethrowerShootTime_max = 15000;
  og_DelayTime_min = level.flameguy.a.flamethrowerShootDelay_min;
  og_DelayTime_max = level.flameguy.a.flamethrowerShootDelay_max;
  level.flameguy.a.flamethrowerShootDelay_min = 0;
  level.flameguy.a.flamethrowerShootDelay_max = 1;
  org = getent("flame_ai_ambient_target", "targetname");
  level.flameguy thread flame_on_off(org);
  level.flameguy waittill("goal");
  level.flameguy SetEntityTarget(org);
  wait(1);
  level notify("ambient_getting_flamed");
  targets[0] = (2728, -7176, -104);
  targets[0] = (2864, -7176, -104);
  while(!flag("flame_the_ambient")) {
    for(i = 0; i < targets.size; i++) {
      time = 1.5;
      org MoveTo(targets[i], time);
      org waittill("movedone");
    }
  }
  level.flameguy ClearEntityTarget();
  org Delete();
  level.flameguy.a.flamethrowerShootTime_min = og_shootTime_min;
  level.flameguy.a.flamethrowerShootTime_max = og_shootTime_max;
  level.flameguy.a.flamethrowerShootDelay_min = og_DelayTime_min;
  level.flameguy.a.flamethrowerShootDelay_max = og_DelayTime_max;
  level.flameguy.cansee_override = undefined;
}

flame_on_off(org) {
  self endon("stop_flaming");
  while(isalive(self)) {
    self SetEntityTarget(org);
    wait randomfloatrange(3, 5);
    self ClearEntityTarget();
    wait randomfloatrange(3, 8);
  }
}

event2_open_fire() {
  level endon("stop flame out");
  getent("ev2_machinegun_openfire", "targetname") waittill("trigger");
  BadPlacesEnable(0);
  thread event2_mg_dialogue();
  flag_set("ambients_on");
  getent("event2_jap_mg_guy_trig", "targetname") notify("trigger");
  level notify("mgs_open_fire");
  clientnotify("mof");
  flag_clear("jog_enabled");
  level thread mg_open_flap();
  friendlies_crouch_only(false);
  dazed = get_ai_group_ai("dazed");
  for(i = 0; i < dazed.size; i++) {
    if(isalive(dazed[i])) {
      dazed[i] dodamage(dazed[i].health + 10, (0, 0, 32));
    }
  }
  level waittill("flame guy is flaming bunker");
  thread event2_flame_out_fx();
  getent("flamebunker_window_right", "targetname") delete();
  earthquake(0.25, 1.5, (2000, -8000, 0), 2000);
  thread rumble_all_players("damage_light", "damage_heavy", (2003.5, -8071.3, -348), 400, 800);
  flame_mg_guy = get_living_ai("flame_mg_guy", "script_noteworthy");
  thread event2_bunker_flamedeath("event2_japflamedeath1", "flamebunker1", "event2_japflamedeath_point1", flame_mg_guy);
}

event2_mg_dialogue() {
  flag_wait("sarge_over_berm");
  level.sarge.animname = "sarge";
  level.sarge anim_single_solo(level.sarge, "over_berm4");
  flag_wait("sullivan_over_berm");
  level.sullivan.animname = "sullivan";
  level.sullivan anim_single_solo(level.sullivan, "over_berm3");
  setmusicstate("MG_ENCOUNTER");
  flag_wait("flameguy_spawned");
  level.sarge anim_single_solo(level.sarge, "over_berm5");
  flag_wait("polo_over_berm");
  wait 2;
  level.polo.animname = "polo";
  level.polo anim_single_solo(level.polo, "over_berm7");
  wait 1;
  level.sullivan anim_single_solo(level.sullivan, "over_berm8");
  level.sullivan anim_single_solo(level.sullivan, "over_berm9");
  level waittill("moving up after flame");
  setmusicstate("FIRST_FIGHT");
  level.sullivan anim_single_solo(level.sullivan, "over_berm10");
  level.sarge anim_single_solo(level.sarge, "first_fight1");
  flag_set("past_flame_mg");
}

rocket_strike_user_notify_monitor() {
  self waittill("player pulledout rockets");
  if(isDefined(self.hintElem)) {
    self.hintElem destroy();
    self.hitElem = undefined;
  }
}

rocket_strike_user_notify() {
  self endon("player pulledout rockets");
  self thread rocket_strike_user_notify_monitor();
  self.hintElem = maps\_hud_util::createFontString("objective", 1.2, self);
  self.hintElem maps\_hud_util::setPoint("TOP", undefined, 0, 110);
  self.hintElem.sort = 0.5;
  self.hintElem.alpha = 0;
  self.hintElem fadeovertime(0.5);
  self.hintElem.alpha = 1;
  self.hintElem setText(&"PEL1_ROCKET_HOWTO");
  self thread fade_hint_over_time();
  self thread do_rocket_hud_elem();
}

fade_hint_over_time() {
  self endon("player pulledout rockets");
  wait 6.4;
  self.hintElem fadeovertime(1);
  self.hintElem.alpha = 0;
  wait 2;
  self.hintElem destroy();
  self.hintElem = undefined;
}

do_rocket_hud_elem_monitor() {
  self waittill("player pulledout rockets");
  if(isDefined(self.hintElem2)) {
    self.hintElem2 destroy();
    self.hintElem2 = undefined;
  }
}

do_rocket_hud_elem() {
  self endon("player pulledout rockets");
  self thread do_rocket_hud_elem_monitor();
  self.hintElem2 = newclienthudelem(self);
  self.hintElem2.x = 290;
  self.hintElem2.y = 200;
  self.hintElem2.alpha = 0;
  self.hintElem2.foreground = true;
  self.hintElem2 SetShader("hud_icon_air_raid", 64, 64);
  self.hintElem2 FadeOverTime(0.2);
  self.hintElem2.alpha = 1;
  wait 5;
  self.hintElem2 MoveOverTime(1.5);
  self.hintElem2.y = 450;
  self.hintElem2.x = self.hintElem2.x + 70;
  self.hintElem2 ScaleOverTime(1.5, 8, 8);
  wait 1.2;
  self.hintElem2 FadeOverTime(0.2);
  self.hintElem2.alpha = 0;
  wait 0.2;
  self.hintElem2 destroy();
  self.hintElem2 = undefined;
}

mg_open_flap() {
  flap = getent("the_flap", "targetname");
  cover = getEntArray("flap_cover", "targetname");
  for(i = 0; i < cover.size; i++) {
    cover[i] linkto(flap);
  }
  flap rotateroll(-90, 1);
}

event2_stop_mg_fire_early() {
  level endon("stop_caring_about_mg");
  trigger_wait("stop_mg_fire_early", "targetname");
  self notify("death");
  level notify("stop flame out");
  self delete();
}

event2_flame_out_fx() {
  fx1 = getstruct("event2_japflamedeath_point1", "targetname");
  playFX(level._effect["bunker_fire_out"], fx1.origin + (0, 0, 32), anglesToForward(fx1.angles));
  wait(0.25);
  playsoundatposition("rocket_falloff_dist", fx1.origin);
  wait 0.5;
  level notify("stop_caring_about_mg");
  playFX(level._effect["bunker_fire_out"], fx1.origin + (0, 0, 32), anglesToForward(fx1.angles));
  playsoundatposition("rocket_explode_dirt", fx1.origin);
  wait(0.75);
  wait 1.25;
  playFX(level._effect["bunker_fire_out"], fx1.origin + (0, 0, 32), anglesToForward(fx1.angles));
  playsoundatposition("bunker_explo", fx1.origin);
  wait(0.5);
}

event2_bunker_flamedeath(t_name, animname, animpoint, flame_mg_guy) {
  point = getstruct(animpoint, "targetname");
  if(isDefined(flame_mg_guy) && isalive(flame_mg_guy) && flame_mg_guy.health > 1) {
    guy = flame_mg_guy;
  } else {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(distance(players[i].origin, point.origin) < 150) {
        return;
      }
    }
    guy = getent(t_name, "targetname") stalingradspawn();
  }
  guy playSound("body_burn");
  guy.animname = animname;
  guy.ignoreme = true;
  guy thread event2_bunker_flamedeath_hack_wait();
  guy anim_single_solo(guy, "flamedeath", undefined, point);
  guy playSound("body_burn");
  if(isalive(guy)) {
    if(guy.origin[0] > 2000) {
      guy.deathanim = level.scr_anim["flamebunker1"]["dead"];
    } else {
      guy.deathanim = level.scr_anim["flamebunker2"]["dead"];
    }
    guy dodamage(guy.health + 50, (0, 0, 0));
  }
}

event2_bunker_flamedeath_hack_wait() {
  wait 0.1;
  self thread animscripts\death::flame_death_fx();
}

event2_trap_door_watcher() {
  level waittill("mortar guys dead");
  flag_wait("end_tanks_dead");
  wait 1.5;
  animguys = [];
  animguys[0] = level.sarge;
  animguys[1] = level.polo;
  animguys[2] = level.sullivan;
  level.sarge disable_ai_color();
  level.polo disable_ai_color();
  level.sullivan disable_ai_color();
  level.sarge.animname = "sarge";
  level.polo.animname = "polo";
  level.sullivan.animname = "sullivan";
  refpoint = getnode("outro_door_node", "targetname");
  left_door = getent("bunker_door_left", "targetname");
  right_door = getent("bunker_door_right", "targetname");
  level thread maps\pel1_amb::play_end_music();
  level.sullivan.goalradius = 32;
  level.polo.goalradius = 32;
  level.sarge.goalradius = 32;
  level anim_reach(animguys, "outro_start", undefined, undefined, refpoint);
  set_yaws_of_outro_guys(refpoint);
  trig = getent("event2_blow_door", "targetname");
  breakme = false;
  while(!breakme) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(trig istouching(players[i])) {
        breakme = true;
      }
    }
    wait 0.05;
  }
  objective_state(6, "done");
  axis_spawner = getent("outro_axis_spawn", "targetname");
  ally_spawner = getent("outro_ally_spawn", "targetname");
  axis_guy = axis_spawner stalingradspawn();
  axis_guy.dropweapon = false;
  axis_guy.ignoreme = true;
  axis_guy.ignoreall = true;
  ally_guy = ally_spawner stalingradspawn();
  axis_guy.animname = "officer";
  ally_guy.animname = "jackson";
  animguys[3] = axis_guy;
  level thread event3_final_door_openings();
  axis_guy thread event3_door_open_notify_axis();
  axis_guy thread event3_katana_watcher();
  level.sarge thread end_level_watcher();
  thread event3_outro_dialogue(axis_guy);
  level.sullivan thread event3_sully_drop();
  level.sarge thread event3_roebuck_fire_and_drop();
  animguys[1] thread anim_single_solo(animguys[1], "outro_start", undefined, refpoint);
  animguys[1] waittillmatch("single anim", "start_anims");
  animguys[0] thread anim_single_solo(animguys[0], "outro_start", undefined, refpoint);
  animguys[2] thread anim_single_solo(animguys[2], "outro_start", undefined, refpoint);
  animguys[3] anim_single_solo(animguys[3], "outro_start", undefined, refpoint);
}

event3_sully_drop() {
  self waittillmatch("single anim", "detach_gun");
  self animscripts\shared::placeWeaponOn(self.weapon, "none");
  org = self gettagorigin("tag_weapon_right");
  ang = self gettagangles("tag_weapon_right");
  gun = spawn("script_model", org);
  gun.angles = ang;
  gun setModel("weapon_usa_trenchgun_rifle");
}

event3_roebuck_fire_and_drop() {
  self waittillmatch("single anim", "fire_gun");
  playFXOnTag(level._effect["thompson_muzzle"], self, "tag_flash");
  self playSound("outro_gunshot");
  self waittillmatch("single anim", "detach_gun");
  self animscripts\shared::placeWeaponOn(self.weapon, "none");
  org = self gettagorigin("tag_weapon_right");
  ang = self gettagangles("tag_weapon_right");
  gun = spawn("script_model", org);
  gun.angles = ang;
  gun setModel("weapon_usa_thompson_smg");
}

set_yaws_of_outro_guys(ref_point) {
  sullnode = getnode("final_sullivannode", "targetname");
  sargenode = getnode("final_sargenode", "targetname");
  polonode = getnode("final_polonode", "targetname");
  level.sullivan.goalradius = 32;
  level.polo.goalradius = 32;
  level.sarge.goalradius = 32;
  org1 = getstartOrigin(ref_point.origin, ref_point.angles, level.scr_anim["sullivan"]["outro_start"]);
  org2 = getstartOrigin(ref_point.origin, ref_point.angles, level.scr_anim["sarge"]["outro_start"]);
  org3 = getstartOrigin(ref_point.origin, ref_point.angles, level.scr_anim["polo"]["outro_start"]);
  level.sullivan setgoalpos(org1, sullnode.angles);
  level.sarge setgoalpos(org2, sargenode.angles);
  level.polo setgoalpos(org3, polonode.angles);
  level.at_outro_goals = 0;
  level.sullivan thread inc_goal_setter(sullnode);
  level.sarge thread inc_goal_setter(sargenode);
  level.polo thread inc_goal_setter(polonode);
  while(level.at_outro_goals != 3) {
    wait 0.05;
  }
}

inc_goal_setter(node) {
  self waittill("goal");
  self waittill("orientdone");
  wait 0.75;
  level.at_outro_goals++;
}

end_level_watcher() {
  self waittillmatch("single anim", "start_fade_to_black");
  nextmission();
}

event3_katana_watcher() {
  self endon("scripted death");
  self.ignoreall = true;
  self.ignoreme = true;
  self animscripts\shared::placeWeaponOn(self.weapon, "none");
  self attach("weapon_jap_katana_long", "tag_weapon_left");
  thread event3_katana_drop_regular();
  self waittill("death");
  self drop_the_sword();
}

event3_katana_drop_regular() {
  self endon("death");
  self waittillmatch("single anim", "drop_sword");
  self notify("scripted death");
  self drop_the_sword();
}

drop_the_sword() {
  self detach("weapon_jap_katana_long", "tag_weapon_left");
  angles = self gettagangles("tag_weapon_left");
  origin = self gettagorigin("tag_weapon_left");
  CreateDynEntAndLaunch("weapon_jap_katana_long", origin, angles, origin, (1, 1, 1));
}

event3_outro_dialogue(axis_guy) {
  battlechatter_off();
  level.polo waittillmatch("single anim", "dialog");
  level.sarge playSound(level.scr_sound["outro"]["outro1"]);
  level.polo waittillmatch("single anim", "dialog");
  level.sullivan playSound(level.scr_sound["outro"]["outro2"]);
  level.polo waittillmatch("single anim", "dialog");
  playsoundatposition(level.scr_sound["outro"]["outro3"], level.sullivan.origin);
  level.polo waittillmatch("single anim", "dialog");
  level.polo playSound(level.scr_sound["outro"]["outro4"]);
  level.polo waittillmatch("single anim", "dialog");
  level.sullivan playSound(level.scr_sound["outro"]["outro5"]);
  level.polo waittillmatch("single anim", "dialog");
  playsoundatposition(level.scr_sound["outro"]["outro6"], axis_guy.origin);
  level.polo waittillmatch("single anim", "dialog");
  axis_guy playSound(level.scr_sound["outro"]["outro7"]);
  level.polo waittillmatch("single anim", "dialog");
  playsoundatposition(level.scr_sound["outro"]["outro8"], axis_guy.origin);
  level.polo waittillmatch("single anim", "dialog");
  level.sullivan playSound(level.scr_sound["outro"]["outro9"]);
  level.polo waittillmatch("single anim", "dialog");
  level.sarge playSound(level.scr_sound["outro"]["outro10"]);
  level.polo waittillmatch("single anim", "dialog");
  playsoundatposition(level.scr_sound["outro"]["outro11"], level.sarge.origin);
}

event3_final_door_openings() {
  rightdoor = getent("bunker_door_right", "targetname");
  leftdoor = getent("bunker_door_left", "targetname");
  level waittill("open_door_axis");
  setmusicstate("SULLIVAN_DIED");
  rightdoor notsolid();
  rightdoor rotateyaw(120, 0.5);
  rightdoor waittill("rotatedone");
  rightdoor rotateyaw(-20, 5);
}

event3_door_open_notify_axis() {
  self waittillmatch("single anim", "hit_door");
  level notify("open_door_axis");
  level.sullivan waittillmatch("single anim", "stabbed");
  playFXOnTag(level._effect["sullivan_death_fx"], level.sullivan, "tag_inhand");
  thread rumble_all_players("damage_light", "damage_heavy", level.sullivan.origin, 300, 600);
  level.sarge.name = "Sgt. Roebuck";
  self.allowdeath = true;
}

getClosestEnt(org, array) {
  if(array.size < 1) {
    return;
  }
  dist = 99999999;
  ent = undefined;
  for(i = 0; i < array.size; i++) {
    newdist = distance(array[i] getorigin(), org);
    if(newdist >= dist) {
      continue;
    }
    dist = newdist;
    ent = array[i];
  }
  return ent;
}

event2_napalm_flameouts() {
  fx1 = getstruct("napalm_flameout1", "targetname");
  playFX(level._effect["bunker_fire_out"], fx1.origin, anglesToForward(fx1.angles));
  wait 0.25;
  wait 1;
  playFX(level._effect["bunker_fire_out"], fx1.origin, anglesToForward(fx1.angles));
}

event2_use_and_remove_first_line_color_trigs() {
  red0 = getent("event2_post_flamebunker", "targetname");
  red0 useby(get_players()[0]);
}

event3_player_stays_in_the_open_leftside() {
  level endon("bunker_crushed");
  level thread event3_branching_dialogue_kill_on_player_moveup();
  level.polo.animname = "polo";
  level.sarge.animname = "sarge";
  level.sullivan.animname = "sullivan";
  flank_string = "last_battle_flank_around";
  headon_string = "last_battle_use_rockets";
  flank_num = 1;
  headon_num = 1;
  num_flank_strings = 3;
  num_headon_strings = 3;
  host = get_players()[0];
  wait 5;
  while(!flag("flank_path_taken")) {
    mgguys = get_ai_group_count("end_mgs");
    if(mgguys < 3) {
      break;
    }
    if(host.origin[0] > 2704) {
      if(flank_num == 1 || flank_num == 2) {
        level.polo anim_single_solo(level.polo, flank_string + flank_num);
      } else {
        level.sarge anim_single_solo(level.sarge, flank_string + flank_num);
      }
      flank_num++;
      wait randomfloatrange(2.0, 3.25);
      if(flank_num > num_flank_strings) {
        flank_num = 1;
        wait 15;
      }
    } else {
      level.polo anim_single_solo(level.polo, headon_string + headon_num);
      headon_num++;
      wait randomfloatrange(2.0, 3.25);
      if(headon_num > num_headon_strings) {
        headon_num = 1;
        wait 15;
      }
    }
    wait 1;
  }
}

event3_flank_right_flag_set() {
  trigger_wait("right_flank_spawner_trig", "targetname");
  flag_set("flank_path_taken");
}

event3_branching_dialogue_kill_on_player_moveup() {
  level endon("bunker_crushed");
  host = get_players()[0];
  while(1) {
    if(host.origin[1] > -4984) {
      level notify("bunker_crushed");
    }
    wait 0.5;
  }
}

event3_suppressed_amtank() {
  node = getvehiclenode("stop_suppressed", "script_noteworthy");
  node waittill("trigger", who);
  who setspeed(0, 1000);
  who thread amtank_firing_loop();
  level waittill("mortar guys dead");
  flag_wait("end_tanks_dead");
  wait 1;
  who resumespeed(5);
}

amtank_firing_loop() {
  level endon("mortar guys dead");
  structs = getstructarray("suppressed_amtank_firepoints", "targetname");
  while(isalive(self)) {
    struct = structs[randomint(structs.size)];
    self setturrettargetvec(struct.origin);
    wait randomfloatrange(5, 8);
    self fireweapon();
  }
}

event3_tanks() {
  level waittill("spawnvehiclegroup23");
  wait 0.05;
  Objective_Add(5, "current");
  Objective_String(5, &"PEL1_OBJECTIVE2F");
  setsaveddvar("compassMaxRange", 100);
  thread event3_tank_checker();
  level.rocket_barrage_max_x = 7500;
  level.rocket_barrage_min_y = -6300;
  level.barrage_charge_time = 15;
  tanks = getEntArray("event3_tanks", "targetname");
  truck = getent("event3_truck", "targetname");
  truck.unload_group = "all";
  for(i = 0; i < tanks.size; i++) {
    tanks[i] thread end_tank_firing_positions();
    tanks[i] thread end_tank_death_watcher(i);
  }
  while(1) {
    tanks_dead = false;
    for(i = 0; i < tanks.size; i++) {
      if(isalive(tanks[i])) {
        tanks_dead = true;
      }
    }
    if(!tanks_dead) {
      break;
    }
    wait 0.1;
  }
  thread event3_remove_end_spawners();
  flag_set("end_tanks_dead");
  objective_state(5, "done");
}

event3_remove_end_spawners() {
  spawners = getEntArray("very_end_spawners", "script_noteworthy");
  for(i = 0; i < spawners.size; i++) {
    if(!spawners[i] isSpawner()) {
      continue;
    }
    spawners[i] delete();
  }
}

end_tank_death_watcher(num) {
  Objective_AdditionalPosition(5, num, self);
  self waittill("death");
  Objective_AdditionalPosition(5, num, (0, 0, 0));
  level notify("end tank died");
}

end_tank_firing_positions() {
  self endon("death");
  structs = getstructarray("end_tank_firing_positions", "targetname");
  while(isalive(self)) {
    struct = structs[randomint(structs.size)];
    self setturrettargetvec(struct.origin);
    wait randomfloatrange(5, 8);
    self fireweapon();
  }
}

grab_starting_guys() {
  return getEntArray("starting_allies", "targetname");
}

grab_start_points(startpoint, ai_or_player) {
  starts = undefined;
  if(ai_or_player == "ai") {
    if(startpoint == "beach") {
      starts = getstructarray("start_beach_ai", "targetname");
    } else if(startpoint == "1st_fight") {
      starts = getstructarray("start_1st_fight_ai", "targetname");
    } else if(startpoint == "2nd_fight_l") {
      starts = getstructarray("start_2nd_fight_l_ai", "targetname");
    } else if(startpoint == "3rd_fight") {
      starts = getstructarray("start_3rd_fight_ai", "targetname");
    } else if(startpoint == "mortars") {
      starts = getstructarray("start_mortar_ai", "targetname");
    }
  } else if(ai_or_player == "players") {
    if(startpoint == "beach") {
      starts = getstructarray("beach_start_points", "targetname");
    } else if(startpoint == "1st_fight") {
      starts = getstructarray("1st_fight_start_points", "targetname");
    } else if(startpoint == "2nd_fight_l") {
      starts = getstructarray("2nd_fight_l_start_points", "targetname");
    } else if(startpoint == "3rd_fight") {
      starts = getstructarray("3rd_fight_start_points", "targetname");
    } else if(startpoint == "mortars") {
      starts = getstructarray("mortar_start_points", "targetname");
    }
  }
  return starts;
}

warp_starting_guys(startpoint) {
  guys = grab_starting_guys();
  starts = grab_start_points(startpoint, "ai");
  if(!isDefined(starts) || !isDefined(guys)) {
    return;
  }
  for(i = 0; i < guys.size; i++) {
    guys[i] teleport(starts[i].origin, starts[i].angles);
  }
}

warp_players(startpoint) {
  starts = grab_start_points(startpoint, "players");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] setOrigin(starts[i].origin);
    players[i] setPlayerAngles(starts[i].angles);
  }
}

set_friendlies_on_chain() {
  for(i = 0; i < self.size; i++) {
    self[i] setgoalentity(get_players()[0]);
  }
}

disable_ai_color_allies() {
  ai = getaiarray("allies");
  for(i = 0; i < ai.size; i++) {
    ai[i] disable_ai_color();
  }
}

enable_ai_color_allies() {
  ai = getaiarray("allies");
  for(i = 0; i < ai.size; i++) {
    ai[i] enable_ai_color();
  }
}

hide_players() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] setorigin((3182, -3877, -164));
  }
  level waittill("ai teleported");
}

set_objective(num, ent) {
  startplace = getdvar("start");
  if(num == 0) {
    objective_add(0, "active", &"PEL1_OBJECTIVE1", (3152, -7624, -256));
    objective_current(0);
  } else if(num == 0.1) {
    objective_string(0, &"PEL1_OBJECTIVE1A");
    objective_position(0, (2036, -10207, -295.9));
    objective_current(0);
  } else if(num == 0.3) {
    level.sarge notify("stop objective on entity");
    objective_string(0, &"PEL1_OBJECTIVE2");
    objective_position(0, (2066, -8670, -324.4));
    objective_current(0);
  } else if(num == 1) {
    level waittill("rockets done");
    trig = getent("bread_crumber_begin", "targetname");
    objective_state(0, "done");
    wait_network_frame();
    objective_add(1, "active", &"PEL1_OBJECTIVE2A", (trig.origin));
    objective_current(1);
    while(1) {
      trig waittill("trigger");
      if(!isDefined(trig.target)) {
        break;
      }
      trig = getent(trig.target, "targetname");
      objective_position(1, (trig.origin));
    }
    wait_network_frame();
    thread set_objective(2);
  } else if(num == 2) {
    objective_state(1, "done");
    wait_network_frame();
    objective_add(2, "current", &"PEL1_OBJECTIVE2B", (2897, -3763, -214));
    getent("obj_entrance_gained", "targetname") waittill("trigger");
    objective_state(2, "done");
    wait_network_frame();
    objective_add(3, "current", &"PEL1_OBJECTIVE2C", (2838.3, -3879.7, -47.9));
    wait_network_frame();
    thread event3_stronghold_checker();
    flag_wait("mortars_cleared");
    flag_wait("stronghold_cleared");
    flag_wait("end_tanks_dead");
    objective_add(6, "active", &"PEL1_OBJECTIVE2D", (2832, -3416, -40));
    objective_current(6);
    setsaveddvar("compassMaxRange", 800);
  }
  wait_network_frame();
}

event3_tank_checker() {
  level waittill("end tank died");
  objective_string(5, &"PEL1_OBJECTIVE2G");
  level waittill("end tank died");
  objective_string(5, &"PEL1_OBJECTIVE2H");
}

event3_stronghold_checker() {
  waittill_aigroupcount("end_mgs", 0);
  flag_set("stronghold_cleared");
  objective_state(3, "done");
}

event3_mortar_checker() {
  trigger_wait("mortar_crew_spawn1", "script_noteworthy");
  objective_add(4, "current", &"PEL1_OBJECTIVE2E", (4022, -3950, -165.1));
  waittill_aigroupcount("mortar_squads", 0);
  flag_set("mortars_cleared");
  objective_state(4, "done");
}

grab_friendlies() {
  return getaiarray("allies");
}

cleanup_enemies() {
  ai = getaiarray("axis");
  for(i = 0; i < ai.size; i++) {
    if(isalive(ai[i])) {
      ai[i] dodamage(ai[i].health + 5, (0, 0, 0));
    }
  }
}

objective_on_entity(obj_num, ent) {
  ent endon("stop objective on entity");
  while(1) {
    objective_position(obj_num, ent.origin);
    wait(0.1);
  }
}

threat_group_setter() {
  while(1) {
    players = get_players();
    for(i = 0; i < players.size; i++) {
      players[i] setthreatbiasgroup("players");
    }
    wait(2);
  }
}

start_beach() {
  VisionSetNaked("pel1", 3);
  thread hide_players();
  wait 0.5;
  warp_starting_guys("beach");
  starts = getstructarray("beach_start_points", "targetname");
  level notify("ai teleported");
  thread warp_players("beach");
  getent("event1_offlvt_moveup", "targetname") useby(get_players()[0]);
  thread event2_setup();
  thread event1_squibline();
  thread event1_floating_bodies();
  thread enable_player_weapons();
  thread delete_trees_and_bushes();
  thread event1_small_bunker_rocket_damage_think();
  thread event1_crawling_guys();
  getent("auto5686", "target") delete();
  level thread event1_pillar_cover_guys();
  level thread event1_small_bunker_rocket_damage_think();
  getent("radio_squad_spawner", "targetname") useby(get_players()[0]);
  wait 0.1;
  ai = get_ai_group_ai("coral_radio_guys");
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_forcecolor) && ai[i].script_forcecolor == "y") {
      level.radioguy = ai[i];
      level.radioguy.animname = "radioguy";
      level.radioguy thread magic_bullet_shield();
      level.radioguy enable_ai_color();
      level.radioguy set_battlechatter(false);
    } else {
      ai[i] delete();
    }
  }
  level.rocket_barrage_allowed = true;
  level.rocket_barrage_first_barrage = false;
}

start_off_lvt() {
  VisionSetNaked("pel1", 3);
  getent("spawn_arty", "targetname") useby(get_players()[0]);
  thread hide_players();
  level.rocket_barrage_allowed = true;
  wait 0.5;
  thread event2_setup();
  thread event2_main_rocket_attack();
  thread event1_squibline();
  thread event1_floating_bodies();
  thread event1_rocket_hints();
  thread event1_mortars();
  thread event1_crawling_guys();
  thread event1_model3_fire(1);
  getent("start_models3s", "targetname") notify("trigger");
  thread enable_player_weapons();
  level thread event1_pillar_cover_guys();
  getent("radio_squad_spawner", "targetname") useby(get_players()[0]);
  wait 0.1;
  ai = get_ai_group_ai("coral_radio_guys");
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_forcecolor) && ai[i].script_forcecolor == "y") {
      level.radioguy = ai[i];
      level.radioguy.animname = "radioguy";
      level.radioguy thread magic_bullet_shield();
      level.radioguy enable_ai_color();
      level.radioguy set_battlechatter(false);
    } else {
      ai[i] delete();
    }
  }
  level.rocket_barrage_first_barrage = true;
  lvtnode = getvehiclenode("auto4778", "targetname");
  level.players_lvt = spawnvehicle("vehicle_usa_tracked_lvt4", "player_lvt", "buffalo", lvtnode.origin, lvtnode.angles + (0, 90, 0));
  thread hide_players();
  event1_put_ai_on_lvt_short();
  thread event1_small_bunker_rocket_damage_think();
  wait 5;
  level clientnotify("ab");
  level clientnotify("sfl");
  level clientnotify("sfr");
  level notify("aaa_begin");
  println("*** Server : Sent notify to start fakefire");
  thread event1_get_ai_off_of_lvt();
  thread event1_explode_and_fade_to_white();
}

start_first_fight() {
  VisionSetNaked("pel1", 3);
  thread hide_players();
  level.rocket_barrage_allowed = true;
  wait 0.5;
  warp_starting_guys("1st_fight");
  starts = getstructarray("1st_fight_start_points", "targetname");
  level notify("ai teleported");
  thread warp_players("1st_fight");
  thread event2_trap_door_watcher();
  thread start_event2_colorsetup();
  thread enable_player_weapons();
  thread event2_grenade_death_guy();
  thread event2_fire_walkers();
  thread event2_treeguy_dialogue();
  thread event2_grass_guy_dialogue();
  thread delete_trees_and_bushes();
  thread event3_setup();
  thread event2_left_amtank_setup();
  getent("auto5686", "target") delete();
  level.otherPlayersSpectate = false;
  level.otherPlayersSpectateClient = undefined;
  getent("radio_squad_spawner", "targetname") useby(get_players()[0]);
  wait 0.1;
  ai = get_ai_group_ai("coral_radio_guys");
  for(i = 0; i < ai.size; i++) {
    if(isDefined(ai[i].script_forcecolor) && ai[i].script_forcecolor == "y") {
      level.radioguy = ai[i];
      level.radioguy.animname = "radioguy";
      level.radioguy thread magic_bullet_shield();
      level.radioguy enable_ai_color();
      level.radioguy set_battlechatter(false);
    } else {
      ai[i] delete();
    }
  }
  level.rocket_barrage_first_barrage = false;
  flag_set("past_flame_mg");
}

start_second_fight_left() {
  VisionSetNaked("pel1", 3);
  thread hide_players();
  level.rocket_barrage_allowed = true;
  wait 0.5;
  warp_starting_guys("2nd_fight_l");
  starts = getstructarray("2nd_fight_l_start_points", "targetname");
  level notify("ai teleported");
  thread warp_players("2nd_fight_l");
  thread event2_trap_door_watcher();
  wait(1);
  for(i = 0; i < level.heroes.size; i++) {
    level.heroes[i] enable_ai_color();
  }
  thread start_event2_colorsetup();
  thread enable_player_weapons();
  thread event3_setup();
  thread delete_trees_and_bushes();
  thread event2_grenade_death_guy();
  level.rocket_barrage_first_barrage = false;
}

start_third_fight() {
  VisionSetNaked("pel1", 3);
  thread hide_players();
  level.rocket_barrage_allowed = true;
  wait 0.5;
  warp_starting_guys("3rd_fight");
  starts = getstructarray("3rd_fight_start_points", "targetname");
  level notify("ai teleported");
  thread warp_players("3rd_fight");
  thread event2_trap_door_watcher();
  wait(1);
  for(i = 0; i < level.heroes.size; i++) {
    level.heroes[i] enable_ai_color();
  }
  thread enable_player_weapons();
  thread delete_trees_and_bushes();
  thread event3_setup();
  thread event2_grenade_death_guy();
  level.rocket_barrage_first_barrage = false;
}

start_mortars() {
  VisionSetNaked("pel1", 3);
  thread hide_players();
  level.rocket_barrage_allowed = true;
  wait 0.1;
  warp_starting_guys("mortars");
  starts = getstructarray("mortars_start_points", "targetname");
  wait 0.1;
  level notify("ai teleported");
  thread warp_players("mortars");
  thread event2_trap_door_watcher();
  thread event2_grenade_death_guy();
  thread set_objective(2);
  wait(1);
  for(i = 0; i < level.heroes.size; i++) {
    level.heroes[i] enable_ai_color();
  }
  thread start_event2_colorsetup();
  thread enable_player_weapons();
  thread event3_suppressed_amtank();
  thread event3_tanks();
  thread event3_mortar_checker();
  thread event3_upstairs_dialogue();
  level.rocket_barrage_first_barrage = false;
}

start_ending() {
  VisionSetNaked("pel1", 3);
  thread hide_players();
  level.rocket_barrage_allowed = true;
  wait 0.1;
  warp_starting_guys("mortars");
  starts = getstructarray("mortars_start_points", "targetname");
  wait 0.1;
  level notify("ai teleported");
  thread warp_players("mortars");
  thread event2_trap_door_watcher();
  thread enable_player_weapons();
  wait 3;
  level notify("mortar guys dead");
  flag_set("end_tanks_dead");
}

start_event2_colorsetup() {
  wait(1);
  for(i = 0; i < level.heroes.size; i++) {
    level.heroes[i] enable_ai_color();
  }
  thread event2_use_and_remove_first_line_color_trigs();
}

enable_player_weapons() {
  level.enable_weapons = 1;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] enableweapons();
  }
}

invincible_turret_setup(maxrange, fireondrones) {
  self endon("death");
  self setmode("auto_nonai");
  self setTurretTeam("axis");
  self thread maps\_mgturret::burst_fire_unmanned();
  self maketurretunusable();
  level thread maps\_mgturret::mg42_setdifficulty(self, getdifficulty());
  if(isDefined(fireondrones)) {
    self.script_fireondrones = fireondrones;
    self thread maps\_mgturret::mg42_target_drones(undefined, "axis");
  }
  self setshadowhint("never");
  if(isDefined(maxrange)) {
    self.maxrange = maxrange;
  }
}

always_fire(fireondrones) {
  self endon("death");
  squibs = [];
  if(!isDefined(fireondrones) || fireondrones == 0) {
    squibs = getstructarray("squibline_flame_bunker", "targetname");
  }
  while(1) {
    level endon("battle_on");
    burstsize = randomintrange(8, 20);
    if(isDefined(squibs) && squibs.size > 0) {
      squib = squibs[randomint(squibs.size)];
      squib thread event1_squibline_think_burst();
    }
    for(i = 0; i < burstsize; i++) {
      self shootturret();
      self.isfiring = true;
      wait(0.1);
    }
    if(isDefined(self.deathzoneactive) && self.deathzoneactive) {
      continue;
    } else {
      self.isfiring = false;
      wait(randomfloatrange(0.5, 2));
    }
  }
}

delete_on_trigger() {
  self waittill("trigger");
  if(isDefined(self)) {
    self delete();
  }
}

event1_setup_lvts_with_drones() {
  lvt = getent("wave1_lvts1", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread populate_lvt_with_heads_and_shoulders();
  lvt thread lvt_float_loop();
  lvt = getent("wave1_lvts2", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread populate_lvt_with_heads_and_shoulders();
  lvt thread lvt_float_loop();
  lvt = getent("wave1_lvts3", "targetname");
  lvt thread lvt_stop_and_unload(1);
  lvt thread populate_lvt_with_heads_and_shoulders();
  lvt thread lvt_float_loop();
  lvt = getent("wave1_lvts4", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread lvt_float_loop();
  lvt = getent("wave1_lvts5", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread populate_lvt_with_heads_and_shoulders();
  lvt thread lvt_float_loop();
  lvt = getent("wave1_lvts6", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread lvt_float_loop();
  lvt = getent("wave2_lvts1", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread lvt_float_loop();
  lvt = getent("wave2_lvts2", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread lvt_float_loop();
  lvt = getent("wave2_lvts3", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread populate_lvt_with_heads_and_shoulders();
  lvt thread lvt_float_loop();
  lvt = getent("wave2_lvts5", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread lvt_float_loop();
  lvt = getent("wave2_lvts6", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread populate_lvt_with_heads_and_shoulders();
  lvt thread lvt_float_loop();
  lvt = getent("wave3_lvts1", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread populate_lvt_with_heads_and_shoulders();
  lvt thread lvt_float_loop();
  lvt = getent("wave3_lvts2", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread populate_lvt_with_heads_and_shoulders();
  lvt thread lvt_float_loop();
  lvt = getent("wave3_lvts3", "targetname");
  lvt thread event1_lvt_jeep_rollout();
  lvt thread lvt_float_loop();
  lvt = getent("wave3_lvts4", "targetname");
  lvt thread lvt_stop_and_unload();
  lvt thread populate_lvt_with_heads_and_shoulders();
  lvt thread lvt_float_loop();
  lvt = getent("wave1_amtank1", "targetname");
  lvt thread event1_amtank1_think();
  lvt = getent("wave1_amtank2", "targetname");
  lvt thread event1_amtank2_think();
  lvt = getent("wave1_amtank3", "targetname");
  lvt thread event1_amtank3_think();
}

remove_fake_shoulders() {
  self waittill_either("fake_death", "death");
  self.fake_shoulders delete();
}

populate_lvt_with_drones(num_guys) {
  for(i = 0; i < num_guys; i++) {
    animpos = maps\_vehicle_aianim::anim_pos(self, i);
    self.drone_riders[i] = spawn_fake_guy_lvt(self gettagorigin(animpos.sittag), self gettagangles(animpos.sittag), 1, "drone_riders", undefined, 1);
    self.drone_riders[i] linkto(self, animpos.sittag);
    self.drone_riders[i].position = i;
    self.drone_riders[i].target = self.targetname + "_drone_unload" + (i + 1);
    self.drone_riders[i] maps\_drones::build_struct_targeted_origins();
    self thread drone_on_lvt_think(self.drone_riders[i]);
  }
  self thread drone_lvt_death_think();
}

drone_lvt_death_think() {
  self waittill_either("fake_death", "death");
  for(i = 0; i < self.drone_riders.size; I++) {
    self.drone_riders[i] notify("death");
    self.drone_riders[i] thread maps\_drones::drone_delete();
  }
}

drone_on_lvt_think(guy) {
  self endon("drone_unload");
  self endon("death");
  animpos = maps\_vehicle_aianim::anim_pos(self, guy.position);
  while(1) {
    guy animscripted("lvt_ride_idle", self gettagorigin(animpos.sittag), self gettagangles(animpos.sittag) + (0, 180, 0), animpos.idle);
    guy waittillmatch("lvt_ride_idle", "end");
  }
}

unload_lvt_think() {
  self endon("death");
  self waittill("drone_unload");
  for(i = 0; i < self.drone_riders.size; i++) {
    animpos = maps\_vehicle_aianim::anim_pos(self, self.drone_riders[i].position);
    self.drone_riders[i] stopanimscripted();
    self.drone_riders[i] unlink();
    self.drone_riders[i] animscripted("lvt_ride_exit", self gettagorigin(animpos.sittag), self gettagangles(animpos.sittag), animpos.getout);
    self.drone_riders[i] thread drone_unload_think();
  }
}

drone_unload_think() {
  self endon("death");
  self endon("drone_death");
  self waittillmatch("lvt_ride_exit", "end");
  if((isDefined(self.fakeDeath)) && (self.fakeDeath == true) && isDefined(self)) {
    self thread maps\_drones::drone_fakeDeath();
  }
  if(isDefined(self)) {
    self thread maps\_drones::drone_runChain(self);
  }
}

spawn_fake_guy_lvt(startpoint, startangles, us, animname, name, is_lvt_drone, assign_weapon, no_pack) {
  guy = spawn("script_model", startpoint);
  guy.angles = startangles;
  if(isDefined(no_pack) && no_pack) {
    guy character\char_usa_marine_r_nb_rifle::main();
  } else if(us) {
    guy character\char_usa_marine_r_rifle::main();
  } else {
    guy character\char_jap_makpel_rifle::main();
  }
  guy UseAnimTree(#animtree);
  guy.a = spawnStruct();
  guy.animname = animname;
  if(!isDefined(name)) {
    guy.targetname = "drone";
  } else {
    guy.targetname = name;
  }
  if(isDefined(assign_weapon) && assign_weapon == 1) {
    guy maps\_drones::drone_assign_weapon("allies");
  }
  if(isDefined(is_lvt_drone) && is_lvt_drone == 1) {
    guy maps\_drones::drone_assign_weapon("allies");
    guy.targetname = "drone";
    guy makeFakeAI();
    guy.team = "allies";
    guy.fakeDeath = true;
    guy.health = 1000000;
    guy.fakeDeath = true;
    guy.drone_run_cycle = level.drone_run_cycle["run_fast"];
    guy thread maps\_drones::drone_setName();
    guy thread maps\_drones::drones_clear_variables();
    structarray_add(level.drones[guy.team], guy);
    level notify("new_drone");
  }
  return guy;
}

throw_object_with_gravity(object, target_pos) {
  start_pos = object.origin;
  gravity = GetDvarInt("g_gravity") * -1;
  dist = Distance(start_pos, target_pos);
  time = dist / 2000;
  delta = target_pos - start_pos;
  drop = 0.5 * gravity * (time * time);
  velocity = ((delta[0] / time), (delta[1] / time), (delta[2] - drop) / time);
  object MoveGravity(velocity, time);
  object rotatepitch(100, time);
  object waittill("movedone");
  object.origin = target_pos;
  wait 2;
  if(isDefined(object)) {
    object delete();
  }
}

#using_animtree("vehicles");

lvt_stop_and_unload(no_ramp_drop) {
  self endon("death");
  self waittill("unload");
  self setspeed(0, 10);
  self notify("stop float loop");
  self clearanim( % v_lvt4_float_loop, 0);
  wait 2;
  if(!isDefined(no_ramp_drop)) {
    self setflaggedanim("drop_gate", % v_lvt4_open_ramp, 1, 0);
    self notify("drone_unload");
  }
  wait 8;
  self clearanim( % v_lvt4_open_ramp, 0);
  self setflaggedanim("open_gate", % v_lvt4_ramp_close, 1, 0);
}

event1_stuck_lvt_anim() {
  self setflaggedanim("lvt_stuck", % v_lvt4_stuck, 1, 0);
}

event1_lvt_jeep_rollout() {
  self.attached_jeep = getent("explodey_jeep", "targetname");
  self.attached_jeep.angles = self.angles + (0, 0, 0);
  self.attached_jeep.origin = self.origin;
  self.attached_jeep UseAnimTree(#animtree);
  self.attached_jeep linkto(self, "tag_origin", (-65, 0, 38), (0, 180, 0));
  colide = getent("jeep_colision", "targetname");
  colide.origin = self.attached_jeep.origin;
  colide.angles = self.attached_jeep.angles + (0, 90, 0);
  colide linkto(self.attached_jeep, "tag_origin");
  getvehiclenode("jeep_rollout", "script_noteworthy") waittill("trigger", who);
  who setspeed(0, 25);
  who clearanim( % v_lvt4_float_loop, 0);
  getent("event1_jeep_blowup_trig", "targetname") waittill("trigger");
  self.attached_jeep animscripted("jeep_unload", self.attached_jeep.origin, self.attached_jeep.angles, % v_willys_peleliu1_jeep_destroyed);
  self.attached_jeep unlink();
  self thread event1_lvt_jeep_driver_dies();
  wait 1.7;
  self notify("stop float loop");
  self clearanim( % v_lvt4_float_loop, 0);
  self setflaggedanim("lvt_stuck", % v_lvt4_peleliu1_jeep_destroyed, 1, 0);
  wait 0.4;
  playFXOnTag(level._effect["jeep_explode"], self.attached_jeep, "tag_origin");
  self.attached_jeep playSound("vehicle_explo");
  self thread lvt_fake_death(0);
  self clearanim( % v_lvt4_peleliu1_jeep_destroyed, 0);
  self setflaggedanim("fast_open_ramp", % v_lvt4_ramp_open, 1, 0);
  level waittill("remove floaters");
  self delete();
  colide delete();
  self.attached_jeep delete();
  self.attached_jeep.attached_guy delete();
}

event1_lst_door_open() {
  wait 11;
  lst = getent("player_lst", "targetname");
  lst UseAnimTree(#animtree);
  lst animscripted("lst_door_open", lst.origin, lst.angles, % v_lst_open_doors);
  lst thread lst_door_sound_on_done();
  level notify("lst door opening");
  lst thread lst_door_fx();
  wait 5;
  level notify("lst doors opened");
}

lst_door_sound_on_done() {
  self waittillmatch("lst_door_open", "end");
  door = getent("lst_door_open_sound", "targetname");
  door playSound("door_stop");
}

lst_door_fx() {
  wait 5;
  doorfxpoint = getstruct("lst_door_fx", "targetname");
  playFX(level._effect["door_splash"], doorfxpoint.origin, anglesToForward(doorfxpoint.angles));
  level notify("lst door splash");
  trigger_wait("lvt_splash_trig", "targetname");
  playFXOnTag(level._effect["exit_splash"], level.players_lvt, "tag_wake");
  level notify("lvt_splash");
  thread rumble_all_players("damage_heavy");
  thread do_water_drops_on_camera_for_time(5);
  thread do_water_sheeting_on_camera();
  thread get_all_allies_wet_in_lvt();
  level.players_lvt.front_sounds playLoopSound("lvt_wake");
  level.players_lvt.rear_sounds playLoopSound("lvt_engines");
}

get_all_allies_wet_in_lvt() {
  ai = getaiarray("allieS");
  for(i = 0; i < ai.size; i++) {
    ai[i] thread wetness_on_ai(1, 1);
  }
}

onPlayerConnect() {
  for(;;) {
    level waittill("connecting", player);
    player thread onPlayerDisconnect();
    player thread onPlayerSpawned();
    player thread onPlayerKilled();
    println("Player connected to game.");
  }
}

onPlayerDisconnect() {
  self waittill("disconnect");
  println("Player disconnected from the game.");
}

onPlayerSpawned() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    println("Player spawned in to game at " + self.origin);
    self thread maps\_dpad_asset::rocket_barrage_player_init();
    self setdepthoffield(10, 35, 1000, 7000, 6, 1.5);
    if(!level.enable_weapons) {
      self disableweapons();
    }
  }
}

onPlayerKilled() {
  self endon("disconnect");
  for(;;) {
    self waittill("killed_player");
    println("Player killed at " + self.origin);
  }
}

lvt_fake_death(do_sink, do_exploding_guys) {
  self setspeed(0, 5);
  self notify("fake_death");
  playFXOnTag(level._effect["lvt_explode"], self, "tag_origin");
  self playSound("explo_metal_rand");
  self setModel("vehicle_usa_tracked_lvt4_dest");
  if(isDefined(do_exploding_guys)) {
    self thread lvt_guys_exploding_out();
  }
  if(isDefined(do_sink) && do_sink) {
    self notify("stop float loop");
    self clearanim( % v_lvt4_float_loop, 0);
    self setflaggedanim("sinking", % v_lvt4_sinking);
    self waittill("sinking");
    self notify("nodeath_thread");
    self notify("death");
    self delete();
  }
}

friendlies_crouch_only(on_off) {
  ai = grab_friendlies();
  if(on_off) {
    for(i = 0; i < ai.size; i++) {
      if(isalive(ai[i])) {
        ai[i] allowedstances("crouch");
      }
    }
  } else {
    for(i = 0; i < ai.size; i++) {
      if(isalive(ai[i])) {
        ai[i] allowedstances("crouch", "stand", "prone");
      }
    }
  }
}

spawn_function_init() {
  level.animtimefudge = 0.05;
  grassguys1 = getEntArray("grass_guys1", "script_noteworthy");
  array_thread(grassguys1, ::add_spawn_function, ::event1_grass_guys1_init);
  grassguys2 = getEntArray("grass_guys2", "script_noteworthy");
  array_thread(grassguys2, ::add_spawn_function, ::event1_grass_guys2_init);
  bayo_jap1 = getEntArray("bayo_jap1", "script_noteworthy");
  array_thread(bayo_jap1, ::add_spawn_function, ::event2_bayo_jap_init);
  bayo_jap2 = getEntArray("bayo_jap2", "script_noteworthy");
  array_thread(bayo_jap2, ::add_spawn_function, ::event2_bayo_jap_init);
  bayo_usguy = getEntArray("bayo_us1", "script_noteworthy");
  array_thread(bayo_usguy, ::add_spawn_function, ::event2_bayo_us_init);
  retreaters = getEntArray("flame_bunker_retreaters", "script_noteworthy");
  array_thread(retreaters, ::add_spawn_function, ::event2_retreaters);
  dazed_guys = getEntArray("auto5022", "targetname");
  array_thread(dazed_guys, ::add_spawn_function, ::event1_dazed_guys);
  trench_banzai = getEntArray("trench_banzai_spawner1", "script_noteworthy");
  array_thread(trench_banzai, ::add_spawn_function, ::trench_banzai_guys);
  dazed1 = getEntArray("dazed1", "script_noteworthy");
  array_thread(dazed1, ::add_spawn_function, ::dazed_guy_setup);
  dazed2 = getEntArray("dazed2", "script_noteworthy");
  array_thread(dazed2, ::add_spawn_function, ::dazed_guy_setup);
  dazed3 = getEntArray("dazed3", "script_noteworthy");
  array_thread(dazed3, ::add_spawn_function, ::dazed_guy_setup);
  dazed4 = getEntArray("dazed4", "script_noteworthy");
  array_thread(dazed4, ::add_spawn_function, ::dazed_guy_setup);
  loggers = getEntArray("ev1_log_guys", "script_noteworthy");
  array_thread(loggers, ::add_spawn_function, ::log_guy_setup);
  stumpy = getEntArray("ev1_log_guys_stump", "script_noteworthy");
  array_thread(stumpy, ::add_spawn_function, ::stump_guy_setup);
  seekers = getEntArray("ev1_seeker_after_goal", "script_noteworthy");
  array_thread(seekers, ::add_spawn_function, ::seeker_after_goal);
  climb = getEntArray("climb", "script_noteworthy");
  array_thread(climb, ::add_spawn_function, ::tree_climber);
  fallbacks = getEntArray("falling_back_guys", "script_noteworthy");
  array_thread(fallbacks, ::add_spawn_function, ::falling_back_guys);
}

falling_back_guys() {
  self endon("death");
  self thread event1_water_depth_think();
  wait randomfloatrange(4, 10);
  self thread event1_underwater_squib_kill_ai();
  wait randomfloatrange(0.75, 1.5);
  self dodamage(self.health + 1, (0, 0, 0));
}

tree_climber() {
  self endon("death");
  self.ignoreme = true;
  self thread treeguy_deathwatch();
  wait 15;
  self.ignoreme = false;
}

treeguy_deathwatch() {
  self waittill("death");
  wait 1;
  level.sarge anim_single_solo(level.sarge, "tree_area5");
}

log_guy_setup() {
  self endon("death");
  self waittill("goal");
  wait randomintrange(10, 25);
  volumes = getEntArray("info_volume", "classname");
  for(i = 0; i < volumes.size; i++) {
    volume = volumes[i];
    if(isDefined(volume.script_goalvolume) && volume.script_goalvolume == 1) {
      self.goalradius = 1000;
      self setgoalpos((1629, -6898, -239));
      self setgoalvolume(volume);
    }
  }
}

stump_guy_setup() {
  self endon("death");
  self waittill("goal");
  wait randomintrange(10, 25);
  volumes = getEntArray("info_volume", "classname");
  for(i = 0; i < volumes.size; i++) {
    volume = volumes[i];
    if(isDefined(volume.script_goalvolume) && volume.script_goalvolume == 1) {
      self.goalradius = 1000;
      self setgoalpos((1629, -6898, -239));
      self setgoalvolume(volume);
    }
  }
  wait randomintrange(6, 12);
  self.goalradius = 64;
  self setgoalnode(getnode("daves_stump", "script_noteworthy"));
  wait randomintrange(8, 15);
  self.goalradius = 230;
  self setgoalentity(get_closest_player(self.origin));
}

seeker_after_goal() {
  self endon("death");
  self waittill("goal");
  wait randomintrange(12, 20);
  self.goalradius = 256;
  self setgoalentity(get_closest_player(self.origin));
  wait randomintrange(8, 16);
  self.goalradius = 128;
}

dazed_guy_setup() {
  the_anim = undefined;
  if(self.script_noteworthy == "dazed1") {
    the_anim = level.scr_anim["dazedjap1"]["dazed"];
    self.animname = "dazedjap1";
    self.possibledeathanim = level.scr_anim["dazedjap1"]["dazed_death"];
  } else if(self.script_noteworthy == "dazed2") {
    the_anim = level.scr_anim["dazedjap2"]["dazed"];
    self.animname = "dazedjap2";
    self.possibledeathanim = level.scr_anim["dazedjap2"]["dazed_death"];
  } else if(self.script_noteworthy == "dazed3") {
    the_anim = level.scr_anim["dazedjap3"]["dazed"];
    self.animname = "dazedjap3";
    self.possibledeathanim = level.scr_anim["dazedjap3"]["dazed_death"];
  } else if(self.script_noteworthy == "dazed4") {
    the_anim = level.scr_anim["dazedjap4"]["dazed"];
    self.animname = "dazedjap4";
    self.possibledeathanim = level.scr_anim["dazedjap4"]["dazed_death"];
  }
  self set_run_anim("dazed");
  self.run_combatanim = the_anim;
  self.disableArrivals = true;
  self.disableExits = true;
  self set_ignoreall(1);
  self.health = 1;
  self.threatbias = 100000;
  self thread event2_dazed_die_over_time();
}

event2_retreaters() {
  self.goalradius = 64;
  self.ignoreall = true;
  self waittill("goal");
  self.goalradius = 1024;
  self.ignoreall = false;
}

event2_bayo_jap_init() {
  self.allowdeath = true;
  self.ignoreall = true;
  self.animPlayBackRate = 1.2;
  self.animname = self.script_noteworthy;
}

event2_bayo_us_init() {
  self.ignoreall = true;
  self.animPlayBackRate = 1.2;
  self.animname = self.script_noteworthy;
}

event1_grass_guys1_init() {
  self endon("death");
  self grass_guys_init();
  flag_wait("grass_attack1");
  wait randomfloatrange(0.1, 0.5);
  self grass_guys_awake();
  setmusicstate("BANZAI");
  self thread grass_camo_ignore_delay(randomfloatrange(2.0, 4.0));
  prone_anim = choose_prone_to_run_anim_variant();
  level.animtimefudge = 0.05;
  self.animplaybackrate = 1.4;
  self play_anim_end_early(prone_anim, level.animtimefudge);
  self.animplaybackrate = 1.0;
  self thread maps\_banzai::banzai_force();
}

event1_grass_guys2_init() {
  self endon("death");
  self grass_guys_init();
  flag_wait("grass_attack2");
  wait randomfloatrange(0.1, 0.5);
  self grass_guys_awake();
  self thread grass_camo_ignore_delay(randomfloatrange(2.0, 4.0));
  prone_anim = choose_prone_to_run_anim_variant();
  level.animtimefudge = 0.05;
  self play_anim_end_early(prone_anim, level.animtimefudge);
  self thread maps\_banzai::banzai_force();
}

trench_banzai_guys() {
  self.banzai_no_wait = 1;
  self thread maps\_banzai::banzai_force();
}

event1_dazed_guys() {
  wait 2;
  self.deathanim = self.possibledeathanim;
  self thread die_if_ally_or_player_near();
}

grass_guys_init() {
  self allowedstances("prone");
  self disableaimassist();
  self.a.pose = "prone";
  self.allowdeath = 1;
  self.pacifist = 1;
  self.pacifistwait = 0.05;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.ignoresuppression = 1;
  self.grenadeawareness = 0;
  self.disableArrivals = true;
  self.disableExits = true;
  self.drawoncompass = false;
  self.activatecrosshair = false;
  self.banzai_no_wait = 1;
  self.banzai_is_waiting = 1;
  self.animname = "grass_guy";
  self thread give_grass_guy_achivement();
}

give_grass_guy_achivement() {
  self endon("grassguy_awake");
  while(isDefined(self)) {
    self waittill("damage", amount, attacker);
    if(isplayer(attacker) && isDefined(self)) {
      if(amount >= self.health) {
        attacker giveachievement_wrapper("ANY_ACHIEVEMENT_GRASSJAP");
        println("gave grass guy achivement");
      }
    }
  }
}

grass_guys_awake() {
  self.activatecrosshair = true;
  self enableaimassist();
  self.drawoncompass = true;
  self allowedstances("stand");
  self.a.pose = "stand";
  self.pacifist = 0;
  self.ignoreall = 0;
  self.grenadeawareness = 0.2;
  self.disableArrivals = false;
  self.disableExits = false;
  self notify("grassguy_awake");
  self.banzai_is_waiting = 0;
  self thread maps\_banzai::start_banzai_announce();
}

grass_camo_ignore_delay(wait_time) {
  self endon("death");
  wait(wait_time);
  self.ignoreme = 0;
}

choose_prone_to_run_anim_variant() {
  prone_anim = undefined;
  if(RandomInt(2)) {
    prone_anim = level.scr_anim["grass_guy"]["prone_anim_fast"];
  } else {
    prone_anim = level.scr_anim["grass_guy"]["prone_anim_fast_b"];
  }
  return prone_anim;
}

set_random_gib() {
  refs = [];
  refs[refs.size] = "right_arm";
  refs[refs.size] = "left_arm";
  refs[refs.size] = "right_leg";
  refs[refs.size] = "left_leg";
  refs[refs.size] = "no_legs";
  refs[refs.size] = "guts";
  self.a.gib_ref = get_random(refs);
}

get_random(array) {
  return array[RandomInt(array.size)];
}

die_if_ally_or_player_near() {
  self endon("death");
  self endon("damage");
  while(1) {
    guys = getaiarray("allies");
    players = get_players();
    guys = array_combine(guys, players);
    for(i = 0; i < guys.size; i++) {
      if(distance(guys[i].origin, self.origin) < 150) {
        self dodamage(self.health + 1, self.origin + (0, 0, randomintrange(16, 64)));
      }
    }
    wait 0.3;
  }
}

pel1_ai_spawner(spawner_targetname) {
  spawn = getent(spawner_targetname, "targetname") spawn_ai();
  if(spawn_failed(spawn)) {
    assertex(0, "spawn failed from " + spawner_targetname);
    return;
  }
  return spawn;
}

delete_trees_and_bushes() {
  deleteme = getEntArray("run1_bushes", "targetname");
  deleteme2 = getEntArray("run1_trees", "targetname");
  deleteme = array_combine(deleteme, deleteme2);
  for(i = 0; i < deleteme.size; i++) {
    deleteme[i] delete();
  }
}

lvt_float_loop() {
  wait randomfloatrange(0.1, 5.0);
  self endon("stop float loop");
  while(1) {
    self setflaggedanimrestart("float_loop", level.scr_anim["lvts"]["float_loop"], 1);
    self waittillmatch("float_loop", "end");
  }
}

jog_internal() {
  self endon("death");
  jogs_left = [];
  jogs_left[jogs_left.size] = "jog1";
  jogs_left[jogs_left.size] = "jog2";
  jogs_left[jogs_left.size] = "jog4";
  jogs_right = [];
  jogs_right[jogs_right.size] = "jog1";
  jogs_right[jogs_right.size] = "jog2";
  jogs_right[jogs_right.size] = "jog3";
  jogs_forward = [];
  jogs_forward[jogs_forward.size] = "jog1";
  jogs_forward[jogs_forward.size] = "jog2";
  self.run_dont_jog = false;
  jogging = false;
  while(flag("jog_enabled")) {
    jogging = true;
    if(!self.run_dont_jog && self.origin[1] > -10350) {
      if(self.origin[0] < 1930) {
        jog = jogs_left[RandomInt(jogs_left.size)];
      } else if(self.origin[0] > 2110) {
        jog = jogs_right[RandomInt(jogs_right.size)];
      } else {
        jog = jogs_forward[RandomInt(jogs_forward.size)];
      }
      self.moveplaybackrate = 0.8;
      self set_generic_run_anim(jog);
      delay = GetAnimLength(level.scr_anim["generic"][jog]);
      wait(delay - 0.2);
    } else {
      jogging = false;
    }
    wait(0.5);
  }
  wait randomfloatrange(0.1, 1.5);
  self.moveplaybackrate = 1.0;
  self clear_run_anim();
  level notify("stop_jog");
}

start_teleport_players(start_name, coop) {
  players = get_players();
  if(isDefined(coop) && coop) {
    starts = get_sorted_starts(start_name);
  } else {
    starts = getstructarray(start_name, "targetname");
  }
  assertex(starts.size >= players.size, "Need more start positions for players!");
  for(i = 0; i < players.size; i++) {
    players[i] setOrigin(starts[i].origin);
    if(isDefined(starts[i].angles)) {
      players[i] setPlayerAngles(starts[i].angles);
    } else {
      players[i] setPlayerAngles((0, 0, 0));
    }
  }
  set_breadcrumbs(starts);
}

get_sorted_starts(start_name) {
  player_starts = [];
  player_starts = getstructarray(start_name, "targetname");
  for(i = 0; i < player_starts.size; i++) {
    for(j = i; j < player_starts.size; j++) {
      if(player_starts[j].script_int < player_starts[i].script_int) {
        temp = player_starts[i];
        player_starts[i] = player_starts[j];
        player_starts[j] = temp;
      }
    }
  }
  return player_starts;
}

do_water_drops_on_camera_for_time(wait_time) {
  players_water_drops_on();
  wait wait_time;
  players_water_drops_off();
}

players_water_drops_on() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] setwaterdrops(100);
  }
}

players_water_drops_off() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] setwaterdrops(0);
  }
}

do_water_sheeting_on_camera() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] setwatersheeting(2, 3);
  }
}

ok_to_set_wetness() {
  if(!isDefined(level._num_wetness)) {
    level thread wetness_monitor();
  }
  if(NumRemoteClients()) {
    if(level._num_wetness > 1) {
      return false;
    }
  }
  return true;
}

wetness_monitor() {
  level._num_wetness = 0;
  while(1) {
    wait_network_frame();
    level._num_wetness = 0;
  }
}

wetness_on_ai(wetness, top_down, fade_time) {
  self endon("death");
  if(!isDefined(self.wetness)) {
    while(!ok_to_set_wetness()) {
      wait_network_frame();
    }
    self setwetness(wetness, top_down);
    self.wetness = wetness;
    level._num_wetness++;
  } else {
    frames = fade_time / 0.05;
    if(!frames) {
      return;
    }
    wet_diff = wetness - self.wetness;
    wet_per_frame = wet_diff / frames;
    for(i = 0; i < frames; i++) {
      while(!ok_to_set_wetness()) {
        wait_network_frame();
      }
      self.wetness += wet_per_frame;
      self setwetness(self.wetness, top_down);
      level._num_wetness++;
      wait 0.05;
    }
  }
}

bloody_death(delay) {
  self endon("death");
  if(!IsAi(self) || !IsAlive(self)) {
    return;
  }
  if(isDefined(self.bloody_death) && self.bloody_death) {
    return;
  }
  self.bloody_death = true;
  if(isDefined(delay)) {
    wait(RandomFloat(delay));
  }
  tags = [];
  tags[0] = "j_hip_le";
  tags[1] = "j_hip_ri";
  tags[2] = "j_head";
  tags[3] = "j_spine4";
  tags[4] = "j_elbow_le";
  tags[5] = "j_elbow_ri";
  tags[6] = "j_clavicle_le";
  tags[7] = "j_clavicle_ri";
  for(i = 0; i < 2; i++) {
    random = RandomIntRange(0, tags.size);
    self thread bloody_death_fx(tags[random], undefined);
    wait(RandomFloat(0.1));
  }
  dmg = self.health + 10;
  self DoDamage(dmg, self.origin);
}

bloody_death_fx(tag, fxName) {
  if(!isDefined(fxName)) {
    fxName = level._effect["flesh_hit"];
  }
  playFXOnTag(fxName, self, tag);
}

rumble_all_players(high_rumble_string, low_rumble_string, rumble_org, high_rumble_range, low_rumble_range) {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(isDefined(high_rumble_range) && isDefined(low_rumble_range) && isDefined(rumble_org)) {
      if(distance(players[i].origin, rumble_org) < high_rumble_range) {
        players[i] playrumbleonentity(high_rumble_string);
      } else if(distance(players[i].origin, rumble_org) < low_rumble_range) {
        players[i] playrumbleonentity(low_rumble_string);
      }
    } else {
      players[i] playrumbleonentity(high_rumble_string);
    }
  }
}

populate_lvt_with_heads_and_shoulders() {
  self.fake_shoulders = spawn("script_model", self.origin);
  self.fake_shoulders setModel("static_peleliu_lvtcrew");
  self.fake_shoulders.angles = self.angles;
  self.fake_shoulders linkto(self, "tag_origin", (-80, 0, 81));
  self thread remove_fake_shoulders();
}