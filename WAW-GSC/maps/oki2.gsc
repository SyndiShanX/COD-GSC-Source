/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oki2.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\oki2_callbacks;
#include maps\_anim;
#include maps\oki2_util;
#include maps\_music;

main() {
  oki2_init();
  flag_init("opening_screen_dialogue_complete");
  maps\oki2_fx::main();
  maps\_destructible_type94truck::init();
  maps\_load::main();
  maps\oki2_anim::main();
  maps\oki2_amb::main();
  maps\_mgturret::init_mg_animent();
  maps\_banzai::init();
  maps\_tree_snipers::main();
  maps\createcam\oki2_cam::main();
  level thread maps\oki2_amb::main();
  level thread maps\oki2_fx::cliffside_ambient_fire();
  level.onPlayerWeaponSwap = maps\_coop_weaponswap::flamethrower_swap;
  cleanup_trigger_disable("e1_cleanup_volume");
  cleanup_trigger_disable("e2_cleanup_volume");
  cleanup_trigger_disable("e3_right_cleanup_volume");
  cleanup_trigger_disable("e3_left_cleanup_volume");
  cleanup_trigger_disable("e3_rear_cleanup_volume");
  createThreatBiasGroup("squad");
  createThreatBiasGroup("players");
  level thread swap_in_flamethrower();
  if(NumRemoteClients()) {
    if(NumRemoteClients() > 1) {
      level.max_drones["allies"] = 5;
    } else {
      level.max_drones["allies"] = 10;
    }
  }
  level waittill("introscreen_complete");
  give_players_satchel_charge_and_threatbiasgroup();
  level thread oki2_objectives();
}

swap_in_flamethrower() {
  wait_for_first_player();
  players = get_players();
  players[0] TakeWeapon("thompson_wet");
  players[0] GiveWeapon("m2_flamethrower_wet");
  players[0] SwitchToWeapon("m2_flamethrower_wet");
}

give_players_satchel_charge_and_threatbiasgroup() {
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] GiveWeapon("satchel_charge_new");
    players[i] SetActionSlot(3, "weapon", "satchel_charge_new");
    players[i] setweaponammoclip("satchel_charge_new", 3);
    players[i] thread e2_track_satchel_for_player();
    players[i] setThreatBiasGroup("players");
    players[i] setclientDvar("miniscoreboardhide", "0");
    players[i] setclientDvar("compass", "1");
    players[i] SetClientDvar("hud_showStance", "1");
    players[i] SetClientDvar("ammoCounterHide", "0");
  }
}

oki2_init() {
  add_start("event3_bash", ::e3_startpoint_bash, & "STARTS_OKI2_FINALBUNKER_BASH");
  add_start("event3", ::e3_startpoint, & "STARTS_OKI2_FINALBUNKER");
  add_start("event2", ::e2_startpoint, & "STARTS_OKI2_CANYON");
  add_start("outro", ::outro_startpoint, & "STARTS_OKI2_OUTRO");
  default_start(::e1_startpoint);
  level.tanks = 0;
  maps\_sherman::main("vehicle_usa_tracked_shermanm4a3_green_w");
  maps\_aircraft::main("vehicle_usa_aircraft_f4ucorsair", "corsair");
  maps\_model3::main("artillery_jap_model3");
  maps\_jeep::main("vehicle_usa_wheeled_jeep", "jeep");
  maps\_coop_weaponswap::init();
  level thread onFirstPlayerConnect();
  level thread onPlayerConnect();
  level thread onPlayerDisconnect();
  level thread onPlayerSpawned();
  level thread onPlayerKilled();
  level.gun1 = getent("gun_1", "targetname");
  level.gun2 = getent("gun_2", "targetname");
  level.gun4 = getent("gun_4", "targetname");
  level.gun1_org = level.gun1.origin;
  level.gun2_org = level.gun2.origin;
  level.gun4_org = level.gun4.origin;
  level.gun1_destroyed = false;
  level.gun2_destroyed = false;
  level.gun4_destroyed = false;
  level.all_guns_destroyed = false;
  level.event_1_finished = false;
  level.e1_smokethrown = false;
  level.cliff_intact = getent("cliff_intact", "targetname");
  level.cliff_destroyed = getent("destroyed_cliff", "targetname");
  level.cliff_rocks = getentarray("delete_these_rocks", "targetname");
  precachestring(&"OKI2_SATCHEL_HINT1");
  precachestring(&"OKI2_SATCHEL_HINT2");
  precachemodel("peleliu_aerial_rocket");
  precachemodel("radio_jap_bro");
  precacheitem("satchel_charge_new");
  level.drone_weaponlist_allies[0] = "m1garand_wet";
  level.drone_weaponlist_allies[1] = "thompson_wet";
  init_drones();
  level.earthquake["bunker"]["magnitude"] = 0.185;
  level.earthquake["bunker"]["duration"] = 3;
  level.earthquake["bunker"]["radius"] = 2048;
  setdvar("arcademode_score_oki2_bunker", 500);
  setdvar("arcademode_score_oki2_radio", 150);
}

oki2_objectives() {
  objective_add(0, "current", & "OKI2_OBJ_1", (4612, 3740, -256));
  objective_current(0);
  level waittill("OBJ_1_UPDATEPOS");
  objective_position(0, (620, 700, -192));
  level waittill("OBJ_1_COMPLETE");
  objective_state(0, "done");
  objective_add(1, "current", & "OKI2_OBJ_2_3", level.gun1_org);
  objective_additionalposition(1, 1, level.gun2_org);
  objective_additionalposition(1, 2, level.gun4_org);
  objective_current(1);
  level waittill("OBJ_2_COMPLETE");
  objective_string_nomessage(1, & "OKI2_OBJ_2");
  objective_state(1, "done");
  objective_add(2, "current", & "OKI2_OBJ_3", getent("move_to_hill", "targetname").origin);
  objective_current(2);
  level waittill("OBJ_3_COMPLETE");
  objective_state(2, "done");
  objective_add(3, "current", & "OKI2_OBJ_4", (-4866, -4595, 393));
  objective_current(3);
  level waittill("OBJ_4_UPDATEPOS");
  objective_position(3, (-6170, -6168, 332.1));
  level waittill("OBJ_4_COMPLETE");
  objective_state(3, "done");
  objective_add(4, "current", & "OKI2_OBJ_5", (-4866, -4595, 393));
  objective_current(4);
  level waittill("OBJ_5_COMPLETE");
  objective_state(4, "done");
}

setup_friends() {
  animscripts\face::initLevelFace();
  spwns = getentarray("friends", "targetname");
  for (i = 0; i < spwns.size; i++) {
    spwns[i] stalingradspawn();
    wait_network_frame();
  }
  friends = get_ai_group_ai("dasquad");
  for (i = 0; i < friends.size; i++) {
    if(isDefined(friends[i].script_noteworthy) && friends[i].script_noteworthy == "sarge") {
      level.sarge = friends[i];
      level.sarge.animname = "sarge";
      friends[i] thread magic_bullet_Shield();
      level.sarge animscripts\face::initCharacterFace();
    }
    if(isDefined(friends[i].script_noteworthy) && friends[i].script_noteworthy == "hero1") {
      level.polonsky = friends[i];
      level.polonsky.animname = "polonsky";
      friends[i] thread magic_bullet_Shield();
      level.polonsky animscripts\face::initCharacterFace();
    }
    friends[i] setwetness(1.0, true);
    friends[i].pacifist = false;
    friends[i].maxSightDistSqrd = (1800 * 1800);
    friends[i] setThreatBiasGroup("squad");
  }
  battlechatter_on("allies");
}

init_friendly_reinforcements() {
  triggers = getentarray("friendly_respawn_trigger", "targetname");
  if(!isDefined(triggers)) {
    return;
  }
  for (i = 0; i < triggers.size; i++) {
    if(isDefined(triggers[i].target)) {
      spawner = getent(triggers[i].target, "targetname");
      if(isDefined(spawner)) {
        spawner add_spawn_function(::wet_spawnfunc);
      }
    }
  }
}

wet_spawnfunc() {
  self setwetness(1.0, true);
  self setThreatBiasGroup("squad");
}

init_drones() {
  character\char_usa_marinewet_r_rifle::precache();
  level.drone_spawnFunction["allies"] = character\char_usa_marinewet_r_rifle::main;
  maps\_drones::init();
}

init_spiderholes() {
  ents = getentarray("spiderhole_lid", "script_noteworthy");
  array_thread(ents, ::monitor_spiderhole_lid);
}

monitor_spiderhole_lid() {
  self waittill("emerge");
  self playsound("spider_hole_open");
}

e1_fake_gun_fire() {
  level endon("stop_cliffgun");
  trig = getent("spawn_model3", "targetname");
  trig waittill("trigger");
  level notify("e1_approaching_first_rocks");
  gun = getent("falling_gun_hideme", "targetname");
  while (!isDefined(gun)) {
    wait(1);
  }
  while (!isDefined(gun.nofire)) {
    {
      playfxontag(level._effect["gunflash"], gun, "tag_flash");
      gun playsound("model3_fire");
      wait(randomintrange(4, 7));
    }
  }
}

e1_startpoint() {
  level thread init_spiderholes();
  wait_for_first_player();
  if(getdvar("extra_guys") == "0") {
    atrig = getent("auto2807", "target");
    atrig trigger_off();
  }
  disable_friendly_color();
  VisionSetNaked("Okinawa2", 1);
  setup_friends();
  set_friendly_stances("crouch", undefined, undefined);
  move_players("player_start");
  level thread e1_opening_screen_dialogue();
  level waittill("introscreen_complete");
  level thread e1_cave_defenders();
  level thread e1_spider_redshirt();
  level thread e1_spider_surprise();
  level thread e1_spider_reinforcements();
  level thread e1_gun_fall();
  level thread fire_rocket_series("rocketbarrage_points", (1400, 2562, -569), 30, false);
  level thread e1_second_rocket_barrage();
  flag_wait("opening_screen_dialogue_complete");
  set_friendly_stances("crouch", "prone", "stand");
  trig = getent("init_ai", "targetname");
  trig notify("trigger");
  trigs = getentarray("done_allies", "targetname");
  for (i = 0; i < trigs.size; i++) {
    trigs[i] notify("stop_drone_loop");
    trigs[i] trigger_off();
  }
  battlechatter_off("allies");
  level thread enable_friendly_color_gradual(1.1);
  level thread e1_fake_gun_fire();
  level thread watersheet_on_trigger("e1_cave_waterfall");
  wait(2);
  players_satchel_hint();
  event1_end = getent("end_event_1", "script_noteworthy");
  event1_end waittill("trigger");
  e2_start();
}

e1_opening_screen_dialogue() {
  setmusicstate("INTRO");
  battlechatter_off("allies");
  level.sarge dialogue("moveout", level.polonsky);
  level.polonsky dialogue("skinny", level.sarge);
  level.sarge dialogue("gordon", level.polonsky);
  wait(0.5);
  level.polonsky dialogue("supplies", level.sarge);
  level.sarge dialogue("coming", level.polonsky);
  level.polonsky dialogue("when", level.sarge);
  wait(0.5);
  level.sarge dialogue("uphill", level.polonsky);
  flag_set("opening_screen_dialogue_complete");
  level waittill("e1_approaching_first_rocks");
  level.sarge dialogue("fortifiedmg");
  level.sarge dialogue("spreadout");
}

e1_spider_redshirt() {
  level endon("e1_spiderholes_triggered");
  trig = getent("e1_spider_redshirt", "targetname");
  trig waittill("trigger");
  wait(3);
  friends = get_ai_group_ai("dasquad");
  redshirt = undefined;
  for (i = 0; i < friends.size; i++) {
    if(isDefined(friends[i].script_noteworthy) && friends[i].script_noteworthy == "designated_redshirt") {
      redshirt = friends[i];
      break;
    }
  }
  redshirt setGoalNode(getNode("e1_spider_redshirt_destination", "targetname"));
  trig2 = getent("e1_spider_redshirt_inposition", "targetname");
  while (true) {
    trig2 waittill("trigger", who);
    if(who == redshirt) {
      break;
    }
  }
  spiderholetrig = getent("spider_surprise", "script_noteworthy");
  spiderholetrig notify("trigger");
  redshirt.health = 5;
  wait(2);
  redshirt setGoalNode(getNode("e1_spider_redshirt_retreat", "targetname"));
  redshirt thread random_death();
}

e1_spider_surprise() {
  trigs = getentarray("spider_surprise", "script_noteworthy");
  array_thread(trigs, ::e1_spiderholes_triggered);
  level waittill("e1_spiderholes_triggered");
  battlechatter_on("axis");
  setmusicstate("OH_SHIT");
  level.sarge dialogue("spiderholes");
  level.sarge dialogue("returnfire");
  level.sarge dialogue("burngrass");
  level notify("OBJ_1_UPDATEPOS");
  battlechatter_on("allies");
}

e1_spiderholes_triggered() {
  self waittill("trigger");
  wait(0.75);
  level notify("e1_spiderholes_triggered");
  wait(15);
  trig = getent("spiderhole_support", "script_noteworthy");
  trig notify("trigger");
}

e1_spiderhole_guys_assign_color() {
  guys = getEntArray("e1_spiderhole_guys", "script_noteworthy");
  okiPrint("e1_spiderhole_guys_assign_color: Found " + guys.size);
  for (i = 0; i < guys.size; i++) {
    if(isAlive(guys[i])) {
      guys[i] set_force_color("o");
      okiPrint("e1_spiderhole_guys_assign_color:Setting color!");
    }
  }
}

e1_spider_reinforcements() {
  trig = getent("e1_spider_reinforcements_trigger", "targetname");
  trig waittill("trigger");
  level thread manage_spawners_nogoal("e1_spider_reinforcements", 3, 5, "e1_spider_reinforcements_stop", 0.25, undefined);
}

e1_second_rocket_barrage() {
  trig = getent("e1_second_rocket_barrage", "targetname");
  trig waittill("trigger");
  fire_rocket_series("rocketbarrage_points", (3729, 2, -561), 24, false);
}

e1_mg_start() {
  trig = getent("e1_mg_start", "targetname");
  trig waittill("trigger");
  mg = getent("e1_bunker_mg", "targetname");
  mg setturretignoregoals(true);
  level thread maintain_mg_guy("stop_cave_defenders2", "e1_mg_gunner_spawn", "e1_mg_gunner");
  level thread e1_mg_guy_banzai();
  level thread e1_sarge_mg_dialogue();
}

e1_mg_guy_banzai() {
  trig = getent("e1_mg_gunner_banzai", "targetname");
  trig waittill("trigger");
  guy = getent("e1_mg_gunner", "targetname");
  mg = getent("e1_bunker_mg", "targetname");
  if(isDefined(guy) && isDefined(mg)) {
    mg setturretignoregoals(false);
    guy.script_mg42 = undefined;
    guy.ready_to_charge = true;
    wait(0.2);
    guy maps\_banzai::banzai_force();
  }
}

e1_smokegrenade_stopthread() {
  trig = getent("e1_smokegrenade_stop", "targetname");
  trig waittill("trigger");
  level notify("e1_smokegrenade_stop");
}

e1_sarge_mg_dialogue() {
  level endon("OBJ_1_COMPLETE");
  level endon("e1_smokegrenade_stop");
  level thread e1_smokegrenade_stopthread();
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] thread e1_track_smokegrenade_for_player();
  }
  wait(1);
  level.polonsky dialogue("mgcovered");
  wait(0.5);
  level.sarge dialogue("popsmoke");
  for (i = 0; level.e1_smokethrown == false; i++) {
    if(i > 10) {
      i = 0;
    }
    if(i == 5) {
      level.sarge dialogue("smokereminder");
    }
    if(i == 10) {
      level.polonsky dialogue("smokereminder");
    }
    wait(2);
  }
  wait(3);
  level.sarge dialogue("cantseeus");
  level.sarge dialogue("clearbunker");
}

e1_track_smokegrenade_for_player() {
  level endon("OBJ_1_COMPLETE");
  while (true) {
    self waittill("grenade_fire", grenade, weapname);
    if(weapname == "m8_white_smoke") {
      self thread e1_watch_for_smoke_intersection(grenade);
    }
  }
}

e1_watch_for_smoke_intersection(grenade) {
  trigger = getent("stop_cave_defenders", "targetname");
  touched_trig = false;
  while (isDefined(grenade)) {
    if(grenade istouching(trigger)) {
      touched_trig = true;
    }
    wait(0.25);
  }
  if(touched_trig == true) {
    level.e1_smokethrown = true;
    level thread random_banzai(trigger, 3);
  }
}

random_banzai(volume, num) {
  wait(5);
  guys = getaiarray("axis");
  banzai_guys = [];
  num_banzai_guys = 0;
  if(isDefined(guys) && guys.size && num > 0) {
    for (i = 0; i < guys.size; i++) {
      if(guys[i] istouching(volume)) {
        banzai_guys[num_banzai_guys] = guys[i];
        num_banzai_guys++;
        if(num_banzai_guys >= num) {
          break;
        }
      }
    }
    for (i = 0; i < banzai_guys.size; i++) {
      wait(0.5);
      if(isDefined(banzai_guys[i]) && isalive(banzai_guys[i])) {
        banzai_guys[i] maps\_banzai::banzai_force();
      }
    }
  }
}

e1_cave_defenders() {
  trig = getent("cave_defenders", "script_noteworthy");
  trig waittill("trigger");
  level notify("e1_spider_reinforcements_stop");
  e1_spiderhole_guys_assign_color();
  level thread manage_spawners_nogoal("cave_defenders", 4, 8, "stop_cave_defenders", 0.25, undefined);
  level thread manage_spawners_nogoal("e1_flank_defenders", 2, 3, "stop_e1_flank_defenders", 1, undefined);
  level thread e1_monitor_cave_defenders();
  level thread e1_stop_cave_defenders();
  level thread e1_more_cave_defenders();
  level thread e1_mg_start();
}

e1_more_cave_defenders() {
  trig = getent("more_cave_defenders", "script_noteworthy");
  trig waittill("trigger");
  level thread manage_spawners_nogoal("cave_defenders2", 3, 5, "stop_cave_defenders2", 4, undefined);
  level thread e1_monitor_cave_defenders2();
  level thread e1_stop_cave_defenders2();
}

e1_monitor_cave_defenders() {
  level endon("stop_monitoring");
  wave = 0;
  while (wave < 4) {
    level waittill("cave_defenders min threshold reached");
    wave++;
  }
  level notify("stop_cave_defenders");
}

e1_monitor_cave_defenders2() {
  level endon("stop_monitoring");
  wave = 0;
  while (wave < 4) {
    level waittill("cave_defenders2 min threshold reached");
    wave++;
  }
  level notify("stop_cave_defenders2");
}

e1_stop_cave_defenders() {
  trig = getent("stop_cave_defenders", "targetname");
  trig waittill("trigger");
  level notify("stop_cave_defenders");
  level notify("stop_e1_flank_defenders");
}

e1_stop_cave_defenders2() {
  trig = getent("stop_cave_defenders2", "targetname");
  trig waittill("trigger");
  setmusicstate("UNDERSCORE");
  level notify("stop_cave_defenders2");
  level notify("stop_cave_mg");
  level.sarge dialogue("throughcaves");
}

e2_startpoint() {
  wait_for_first_player();
  setup_friends();
  disable_friendly_color();
  move_players("skipto_e2_players");
  move_ai("skipto_e2_friendlies");
  enable_friendly_color();
  triga = getent("start_e2", "script_noteworthy");
  triga notify("trigger");
  battlechatter_on("axis");
  level notify("OBJ_1_UPDATEPOS");
  wait_network_frame();
  level notify("OBJ_1_COMPLETE");
  e2_start();
}

e2_start() {
  level.event_1_finished = true;
  e2_hidesatchels();
  level notify("stop_upper");
  friends = get_ai_group_ai("dasquad");
  for (i = 0; i < friends.size; i++) {
    friends[i].maxSightDistSqrd = (1100 * 1100);
  }
  getent("move_to_hill", "targetname") trigger_off();
  level thread e2_grotto_fight();
  level thread maps\oki2_gunbunkers::monitor_gun(1);
  level thread maps\oki2_gunbunkers::monitor_gun(2);
  level thread maps\oki2_gunbunkers::monitor_gun(4);
  level thread maps\oki2_gunbunkers::bunker_wait_for_flame(1, "bunker_inner_fire", "bunker1_flamers", maps\oki2_gunbunkers::cave_flamers, 201);
  level thread maps\oki2_gunbunkers::bunker_wait_for_flame(2, "bunker_inner_fire", "bunker2_flamers", maps\oki2_gunbunkers::cave_flamers, 202);
  level thread maps\oki2_gunbunkers::bunker_wait_for_flame(4, "bunker_inner_fire", "bunker4_flamers", maps\oki2_gunbunkers::cave_flamers, 203);
  level thread maps\oki2_gunbunkers::bunker_dialogue();
  level thread e2_first_rocket_barrage();
  level thread e2_second_rocket_barrage();
  level thread e2_linefight_a_start();
  level thread cleanup_trigger_enable("e1_cleanup_volume");
  level thread e2_refresh_satchel_ammo("e2_satchelbox_a", "OBJ_5_COMPLETE");
  level thread e2_refresh_satchel_ammo("e2_satchelbox_b", "OBJ_5_COMPLETE");
  level thread e2_refresh_satchel_ammo("e2_satchelbox_c", "OBJ_5_COMPLETE");
  level thread watersheet_on_trigger("e2_grotto_waterfall");
  level thread e2_collectible_corpse();
  e2_end_setdoorangle();
  while (!level.all_guns_destroyed) {
    wait(1);
  }
  level notify("OBJ_2_COMPLETE");
  thread e2_end_playergate();
  setmusicstate("UNDERSCORE");
}

#using_animtree("generic_human");

e2_collectible_corpse() {
  orig = getstruct("orig_collectible_loop", "targetname");
  corpse = spawn("script_model", orig.origin);
  corpse.angles = orig.angles;
  corpse character\char_jap_makpelwet_rifle::main();
  corpse detach(corpse.gearModel);
  corpse UseAnimTree(#animtree);
  corpse.animname = "collectible";
  corpse.targetname = "collectible_corpse";
  level thread anim_loop_solo(corpse, "collectible_loop", undefined, "stop_collectible_loop", orig);
}

e2_grotto_fight() {
  trig = getent("e2_grottofight_start", "targetname");
  trig waittill("trigger");
  spawns = getentarray("e2_grotto_spawns", "targetname");
  guys = [];
  numguys = 0;
  for (i = 0; i < spawns.size; i++) {
    guys[numguys] = spawns[i] stalingradspawn();
    if(isDefined(guys[numguys])) {
      numguys++;
    }
  }
  livingguys = guys.size;
  lastguy = undefined;
  while (livingguys > 1) {
    livingguys = 0;
    for (i = 0; i < guys.size; i++) {
      if(isDefined(guys[i]) && isAlive(guys[i])) {
        livingguys++;
        lastguy = guys[i];
      }
    }
    wait(0.2);
  }
  lastguy setGoalNode(getNode("e2_grotto_runawaynode", "targetname"));
  lastguy endon("death");
  lastguy.ignoreall = true;
  lastguy.goalradius = 64;
  lastguy waittill("goal");
  lastguy.ignoreall = false;
}

e2_hidesatchels() {
  ents = getentarray("e2_satchel_glow", "targetname");
  for (i = 0; i < ents.size; i++) {
    ents[i] hide();
  }
}

e2_showsatchels() {
  ents = getentarray("e2_satchel_glow", "targetname");
  for (i = 0; i < ents.size; i++) {
    ents[i] show();
  }
}

e2_refresh_satchel_ammo(triggername, end) {
  level endon(end);
  while (true) {
    trig = getent(triggername, "targetname");
    trig waittill("trigger", who);
    if(isDefined(who) && isPlayer(who) && who.active_satchels < 3) {
      if(who GetWeaponAmmoStock("satchel_charge_new") < 3) {
        who givestartammo("satchel_charge_new");
        PlaySoundAtPosition("ammo_pickup_plr", trig.origin);
      }
    }
    wait(2);
  }
}

e2_track_satchel_for_player() {
  self.active_satchels = 0;
  while (true) {
    self waittill("grenade_fire", satchel, weapname);
    if(weapname == "satchel_charge_new") {
      if(level.all_guns_destroyed == false && level.event_1_finished == true) {
        self thread e2_watch_for_bunker_intersection(satchel, self);
      } else {
        self thread watch_satchel_simple(satchel, self);
      }
      self.active_satchels++;
    }
  }
}

watch_satchel_simple(satchel, player) {
  while (isDefined(satchel)) {
    wait(0.25);
  }
  player.active_satchels--;
}

e2_watch_for_bunker_intersection(satchel, player) {
  triggers[0] = getent("bunker1_dmg_trig", "targetname");
  triggers[1] = getent("bunker2_dmg_trig", "targetname");
  triggers[2] = getent("bunker4_dmg_trig", "targetname");
  touched_trig = -1;
  while (isDefined(satchel)) {
    for (i = 0; i < triggers.size; i++) {
      if(satchel istouching(triggers[i])) {
        touched_trig = i;
      }
    }
    wait(0.25);
  }
  player.active_satchels--;
  if(touched_trig != -1 && isDefined(triggers[touched_trig])) {
    triggers[touched_trig] notify("satchel_exploded");
    if(touched_trig == 0 && !level.gun1_destroyed)
      arcademode_assignpoints("arcademode_score_oki2_bunker", player);
    if(touched_trig == 1 && !level.gun2_destroyed)
      arcademode_assignpoints("arcademode_score_oki2_bunker", player);
    if(touched_trig == 2 && !level.gun4_destroyed)
      arcademode_assignpoints("arcademode_score_oki2_bunker", player);
  }
}

e2_first_rocket_barrage() {
  trig = getent("e2_first_rocket_barrage", "targetname");
  trig waittill("trigger");
  fire_rocket_series("canyon_rocketbarrage_points_a", (-860, -654, 36.1), 12, true);
}

e2_second_rocket_barrage() {
  trig = getent("e2_second_rocket_barrage", "targetname");
  trig waittill("trigger");
  fire_rocket_series("canyon_rocketbarrage_points_b", (-5737, -313, 8), 30, true);
}

e2_linefight_a_start() {
  trig = getent("e2_linefight_a_start", "targetname");
  trig waittill("trigger");
  level thread maps\_squad_manager::manage_spawners("e2_linefight_a", 2, 4, "e2_linefight_a_stop", 1, undefined);
  level thread e2_linefight_a_stop();
}

e2_linefight_a_stop() {
  trig = getent("e2_linefight_a_stop", "targetname");
  trig waittill("trigger");
  level notify("e2_linefight_a_stop");
  level thread e2_bridge_banzai_setup();
  level thread e2_bridge_commentary_setup();
  level thread e2_check_for_bridge_skip();
}

e2_check_for_bridge_skip() {
  trig = getent("e2_player_skipping_bridge", "targetname");
  trig waittill("trigger");
  trig = getent("e2_bridge_banzai_trigger", "targetname");
  trig trigger_off();
  trig = getent("e2_bridge_commentary", "targetname");
  trig trigger_off();
  level notify("e2_player_skipped_bridge");
}

e2_bridge_banzai_setup() {
  level endon("e2_player_skipped_bridge");
  trig = getent("e2_bridge_banzai_trigger", "targetname");
  trig waittill("trigger");
  spawner = getent("e2_bridge_banzai", "targetname");
  spawner add_spawn_function(::e2_bridge_banzai_spawnfunc);
  guy = spawner stalingradspawn();
  wait(0.1);
  guy allowedstances("crouch", "prone", "stand");
}

e2_bridge_banzai_spawnfunc() {
  self allowedstances("crouch");
  self.a.pose = "crouch";
}

e2_bridge_commentary_setup() {
  level endon("e2_player_skipped_bridge");
  trig = getent("e2_bridge_commentary", "targetname");
  trig waittill("trigger");
  level.sarge dialogue("otherside");
}

e2_end_playergate() {
  level notify("bunker_noneleft");
  level.sarge dialogue("lastone");
  checktrig = getEnt("e2_bunker3_checkifclear", "targetname");
  deathCountdown = 15;
  while (true) {
    numEnemies = 0;
    guys = getaiarray("axis");
    if(isDefined(guys) && guys.size) {
      for (i = 0; i < guys.size; i++) {
        if(isAlive(guys[i]) && guys[i] istouching(checktrig)) {
          numEnemies++;
          if(deathCountdown == 0) {
            guys[i] thread random_death();
          }
        }
      }
    }
    if(numEnemies < 3) {
      deathCountdown--;
    }
    if(numEnemies == 0) {
      break;
    }
    wait(0.66);
  }
  level thread e2_end_sargedialogue();
  level.sarge disable_ai_color();
  level.sarge setgoalnode(getnode("e2_finish_sargenode_wait", "targetname"));
  trig = getent("move_to_hill", "targetname");
  trig trigger_on();
  trig waittill("trigger");
  level.sarge setgoalnode(getnode("e2_finish_sargenode_kickready", "targetname"));
  level.sarge waittill("goal");
  thread e3_start_trigger();
  e2_end_sarge_bash_door();
  level notify("OBJ_3_COMPLETE");
}

e2_end_setdoorangle() {
  gate = getent("e2_finish_gate", "targetname");
  gate.angles = (0, -24, 0);
}

e2_end_sargedialogue() {
  battlechatter_off("allies");
  wait(2);
  level.sarge dialogue("meetme");
}

e2_end_sarge_bash_door() {
  level.sarge.ignoreall = true;
  gate = getent("e2_finish_gate", "targetname");
  anim_node = getnode("e2_finish_kickspot", "targetname");
  anim_node anim_reach_solo(level.sarge, "door_bash");
  level thread e2_end_bash_door_dialogue();
  anim_node anim_single_solo(level.sarge, "door_bash");
  level.sarge setgoalnode(getnode("e2_finish_sargepostbash", "targetname"));
  level.sarge.ignoreall = false;
}

e2_end_bash_door_dialogue() {
  level.polonsky dialogue("whatnow");
  level.sarge dialogue("keepmovingpolonsky");
  wait(0.5);
  level.sarge dialogue("keepmoving");
  battlechatter_on("allies");
}

#using_animtree("oki2_falling_gun");

e2_end_cachedooranim() {
  level.scr_model["e2_door"] = "tag_origin_animate";
  level.scr_anim["e2_door"]["flyopen"] = % o_okinawa2_bunkerdoor_smash;
  level.scr_animtree["e2_door"] = #animtree;
}

move_e3_start_gate(GARBAGE) {
  e2_end_cachedooranim();
  gate = getent("e2_finish_gate", "targetname");
  gateclip = getent("e2_finish_gate_clip", "targetname");
  scrorigin = getent("e2_finish_animorigin", "targetname");
  anim_model = spawn_anim_model("e2_door");
  anim_model.animname = "e2_door";
  anim_model.origin = scrorigin.origin;
  anim_model.angles = scrorigin.angles;
  scrorigin maps\_anim::anim_first_frame_solo(anim_model, "flyopen");
  gate linkto(anim_model, "origin_animate_jnt", (0, 0, 0), (0, -24, 0));
  scrorigin thread anim_single_solo(anim_model, "flyopen");
  gateclip delete();
}

e3_start_trigger() {
  trig = getEnt("e3_start_trigger", "targetname");
  trig waittill("trigger");
  e3_start();
}

e3_startpoint() {
  wait_for_first_player();
  level.event_1_finished = true;
  level notify("stop_upper");
  level notify("stop_1");
  level notify("stop_2");
  level notify("stop_4");
  setup_friends();
  move_ai("e3_ai_start");
  move_players("e3_player_start");
  enable_friendly_color();
  level notify("OBJ_1_UPDATEPOS");
  wait_network_frame();
  level notify("OBJ_1_COMPLETE");
  wait_network_frame();
  level notify("OBJ_2_COMPLETE");
  wait_network_frame();
  level notify("OBJ_3_COMPLETE");
  level thread e3_start_trigger();
  level thread move_e3_start_gate(undefined);
  startcovertrig = getent("e3_start_coverpoints", "targetname");
  startcovertrig notify("trigger");
  players = get_players();
}

e3_startpoint_bash() {
  wait_for_first_player();
  level.event_1_finished = true;
  level notify("stop_upper");
  level notify("stop_1");
  level notify("stop_2");
  level notify("stop_4");
  setup_friends();
  move_ai("e3_ai_start");
  move_players("e3_player_start");
  enable_friendly_color();
  level notify("OBJ_1_UPDATEPOS");
  wait_network_frame();
  level notify("OBJ_1_COMPLETE");
  wait_network_frame();
  level notify("OBJ_2_COMPLETE");
  startcovertrig = getent("e3_start_coverpoints", "targetname");
  startcovertrig notify("trigger");
  e2_end_setdoorangle();
  level thread e2_end_playergate();
}

e3_start() {
  thread e3_tankstart();
  thread e3_playerneartank();
  level thread e3_bunker_defenders();
  level thread e3_player_enters_tunnel();
  level thread e3_rightrear_linefight_start();
  level thread e3_leftrear_linefight_start();
  startup_e3_freeflow_triggers();
}

e3_turrets_ignoregoals_true() {
  t1 = getent("auto448", "targetname");
  t2 = getent("auto709", "targetname");
  t1 setturretignoregoals(true);
  t2 setturretignoregoals(true);
}

e3_turrets_ignoregoals_false() {
  t1 = getent("auto448", "targetname");
  t2 = getent("auto709", "targetname");
  t1 setturretignoregoals(false);
  t2 setturretignoregoals(false);
}

e3_playerneartank() {
  trig_playerneartank = getent("trigger_playerneartank", "targetname");
  enable_friendly_color();
  trig_playerneartank waittill("trigger");
  level notify("tank_move");
  spawn_array_once("e3_hill_friendlies", "targetname");
  level thread cleanup_trigger_enable("e2_cleanup_volume");
}

e3_tankstart() {
  trig_spawn = getent("tank_spawn", "targetname");
  trig_spawn notify("trigger");
  level waittill("tank_move");
  trig_move = getent("tank_move", "targetname");
  trig_move notify("trigger");
  tank1 = getent("e3_tank1", "targetname");
  tank2 = getent("e3_tank2", "targetname");
  level thread e3_tankfollowers(tank1);
  wait(1);
  tank1 thread e3_tank_explode();
  tank2 thread e3_tank_explode();
  level thread e3_tank_dialogue();
  level thread e3_extra_mortar();
}

e3_tankfollowers(tank) {
  spawns = getentarray("e3_tankfollower_spawn", "targetname");
  guys = [];
  dest_node = getNode("e3_tankfollower_goal", "targetname");
  for (i = 0; i < spawns.size; i++) {
    guys[i] = spawns[i] StalingradSpawn();
    wait_network_frame();
    guys[i].ignoreall = true;
    guys[i].health = 1;
    guys[i] thread maps\_utility::set_generic_run_anim("combat_jog", true);
    guys[i] setGoalPos(dest_node.origin);
    guys[i].goalradius = 128;
    wait(0.35);
  }
  tank waittill("reached_end_node");
  for (i = 0; i < guys.size; i++) {
    if(isAlive(guys[i])) {
      guys[i] doDamage(100, tank.origin);
    }
  }
}

e3_tank_explode() {
  self waittill("reached_end_node");
  playfx(level.mortar, self.origin);
  radiusdamage(self.origin, 512, 60, 15);
  level notify("e3_tank_destroyed");
  self notify("death");
}

e3_drone_slowspeed() {
  self.droneRunRate = 125;
}

e3_extra_mortar() {
  level waittill("e3_tank_destroyed");
  locs = getStructArray("e3_extra_mortar", "targetname");
  for (i = 0; i < locs.size; i++) {
    wait(RandomIntRange(1, 4));
    playfx(level.mortar, locs[i].origin);
    radiusdamage(locs[i].origin, 512, 40, 10);
  }
  wait(RandomIntRange(1, 4));
  jeepmortar = getstruct("e3_jeep_mortar", "targetname");
  jeep1 = getent("e3_parked_jeep1", "targetname");
  jeep2 = getent("e3_parked_jeep2", "targetname");
  playfx(level.mortar, jeepmortar.origin);
  radiusdamage(jeepmortar.origin, 512, 40, 10);
  wait(0.1);
  jeep1 notify("death");
  wait(0.4);
  jeep2 notify("death");
}

e3_tank_dialogue() {
  level.sarge dialogue("tanksmoving");
  level waittill("e3_tank_destroyed");
  setmusicstate("MORTARS");
  level.polonsky dialogue("mortarfire");
  level.sarge dialogue("takecover");
  wait(6);
  level.polonsky dialogue("fortress");
  level.polonsky dialogue("seepaths");
  level notify("OBJ_4_UPDATEPOS");
}

startup_e3_freeflow_triggers() {
  thread trigger_noteworthy_if_player0("e3_righthand_trigger_a", "player_entered_tunnel");
  thread trigger_noteworthy_if_player0("e3_righthand_trigger_b", "player_entered_tunnel");
  thread trigger_noteworthy_if_player0("e3_righthand_trigger_c", "player_entered_tunnel");
  thread trigger_noteworthy_if_player0("e3_righthand_trigger_d", "player_entered_tunnel");
  thread trigger_noteworthy_if_player0("e3_righthand_trigger_e", "player_entered_tunnel");
  thread trigger_noteworthy_if_player0("e3_lefthand_trigger_a", "player_entered_tunnel");
  thread trigger_noteworthy_if_player0("e3_lefthand_trigger_b", "player_entered_tunnel");
  thread trigger_noteworthy_if_player0("e3_lefthand_trigger_c", "player_entered_tunnel");
  thread trigger_noteworthy_if_player0("e3_lefthand_trigger_d", "player_entered_tunnel");
}

e3_bunker_defenders() {
  trig = getent("start_bunker_defenders", "script_noteworthy");
  trig waittill("trigger");
  level thread e3_righthand_defenders();
  level thread e3_lefthand_defenders();
  createThreatBiasGroup("e3_gunners");
  level thread maintain_mg_guy("player_entered_tunnel", "e3_bunker_gunner_spawn1", "e3_bunker_gunner1", "e3_gunners");
  level thread maintain_mg_guy("player_entered_tunnel", "e3_bunker_gunner_spawn2", "e3_bunker_gunner2", "e3_gunners");
  level thread maintain_mg_guy("player_entered_tunnel", "e3_bunker_gunner_spawn3", "e3_bunker_gunner3", "e3_gunners");
  setThreatBias("e3_gunners", "players", 25);
}

e3_righthand_defenders() {
  thread manage_spawners_nogoal("bunker_right_defenders", 3, 5, "stop_right_defenders", 1, ::guy_to_goal_blind);
  thread e3_monitor_defenders("bunker_right_defenders", 6, "stop_right_defenders");
  thread e3_stop_lower_defenders("stop_lower_defenders_right");
}

e3_lefthand_defenders() {
  trig = getent("e3_start_lefthand_defenders", "targetname");
  trig waittill("trigger");
  thread manage_spawners_nogoal("bunker_left_defenders", 3, 7, "stop_left_defenders", 1, undefined);
  thread e3_monitor_defenders("bunker_left_defenders", 6, "stop_left_defenders");
  thread e3_stop_lower_defenders("stop_lower_defenders_left");
  thread e3_left_treesnipers();
}

e3_monitor_defenders(guys, maxWaves, strEndon) {
  level endon(strEndon);
  waves = 0;
  while (waves < maxWaves) {
    level waittill(guys + " min threshold reached");
    waves++;
  }
  level notify(strEndon);
}

e3_stop_lower_defenders(triggername) {
  trig = getent(triggername, "targetname");
  trig waittill("trigger");
  level notify("stop_left_defenders");
  level notify("stop_right_defenders");
}

e3_init_defenders() {
  self.goalradius = 64;
  self.maxsightdistsqrd = (2048 * 2048);
}

e3_player_enters_tunnel() {
  trig = getent("e3_player_enters_tunnel", "targetname");
  trig waittill("trigger");
  level notify("player_entered_tunnel");
  level notify("OBJ_4_COMPLETE");
  setmusicstate("INTO_BUNKERS");
  level thread e3_player_reaches_bunker();
  level thread e3_tunnels_spawn();
  level thread e3_tunnels_radio();
  battlechatter_off("allies");
  level.polonsky dialogue("tunnelahead");
  level.sarge dialogue("goodworkpeople");
  level.sarge dialogue("convoyenroute");
  battlechatter_on("allies");
}

e3_tunnels_radio() {
  trig = getent("e3_tunnels_radio_trigger", "targetname");
  trig waittill("trigger");
  level endon("player_reaches_bunker");
  radio = getent("e3_tunnel_radio", "targetname");
  radio endon("radio_damaged");
  radio setcandamage(true);
  radio thread e3_tunnels_radio_takedamage();
  radio playsound("oki2_radio_transmission", "sound_finished");
  radio waittill("sound_finished");
  radio playloopsound("oki2_radio_deadair_loop");
}

e3_tunnels_radio_takedamage() {
  self waittill("damage", who);
  self notify("radio_damaged");
  self stopsounds();
  wait_network_frame();
  self playsound("radio_destroyed");
  self setmodel("radio_jap_bro");
  if(isPlayer(who)) {
    arcademode_assignpoints("arcademode_score_oki2_radio", who);
  }
}

e3_tunnels_spawn() {
  thread notify_when_trigger_hit("e3_tunnel_firstwave", "start_tunnels_axis_a");
  level waittill("start_tunnels_axis_a");
  guys = spawn_array_once("e3_tunnels_axis_a", "targetname");
  thread e3_trigger_when_guys_dead(guys, "e3_tunnels_allies_a", "player_reaches_bunker", "e3_tunnels_allies_a_disable");
  thread notify_when_trigger_hit("e3_trigger_tunnels_secondroom", "player_in_secondroom");
  level waittill("player_in_secondroom");
  level thread cleanup_trigger_enable("e3_right_cleanup_volume");
  level thread cleanup_trigger_enable("e3_left_cleanup_volume");
  guys = spawn_array_once("e3_tunnels_axis_b", "targetname");
  thread e3_trigger_when_guys_dead(guys, "e3_tunnels_allies_b", "player_reaches_bunker", "e3_tunnels_allies_b_disable");
  thread notify_when_trigger_hit("e3_trigger_tunnels_firstladder", "player_climbs_first_ladder");
  level waittill("player_climbs_first_ladder");
  level thread cleanup_trigger_enable("e3_rear_cleanup_volume");
  thread manage_spawners_nogoal("e3_tunnels_axis_c", 2, 4, "e3_tunnels_allies_c_stop", .1, undefined);
  thread notify_when_trigger_hit("e3_tunnels_allies_c", "e3_tunnels_allies_c_stop");
}

e3_trigger_when_guys_dead(guys, targetname, endmsg, disablename) {
  if(isDefined(endmsg)) {
    level endon(endmsg);
  }
  guysalive = true;
  while (guysalive) {
    guysalive = false;
    for (i = 0; i < guys.size; i++) {
      if(isDefined(guys[i]) && isAlive(guys[i])) {
        guysalive = true;
      }
    }
    wait(0.25);
  }
  trig = getent(targetname, "targetname");
  if(isDefined(trig)) {
    trig notify("trigger");
  }
  if(isDefined(disablename)) {
    dtrig = getent(disablename, "targetname");
    dtrig trigger_off();
  }
}

e3_player_reaches_bunker() {
  trig = getent("e3_player_reaches_bunker", "targetname");
  trig waittill("trigger");
  level notify("player_reaches_bunker");
  level thread e3_bunkertop_spawn();
  setmusicstate("UP_THE_LADDER");
  level.sarge dialogue("upladder");
  level.sarge dialogue("areasecured");
}

e3_bunkertop_spawn() {
  trig = getent("e3_start_bunkertop_axis_a", "targetname");
  trig waittill("trigger");
  e3_bunkertop_relocategunners();
  thread manage_spawners_nogoal("e3_bunkertop_axis_a", 4, 7, "stop_bunkertop_axis_a", .1, undefined);
  thread notify_when_trigger_hit("e3_stop_bunkertop_axis_a", "stop_bunkertop_axis_a");
  e3_turrets_ignoregoals_false();
  trig = getent("e3_start_bunkertop_axis_b", "targetname");
  trig waittill("trigger");
  thread manage_spawners_nogoal("e3_bunkertop_axis_b", 5, 8, "stop_bunkertop_axis_b", .1, undefined);
  thread notify_when_trigger_hit("e3_stop_bunkertop_axis_b", "stop_bunkertop_axis_b");
  thread e3_sarge_mortar_reminder();
  wait(2);
  e3_monitor_bunker_status();
}

e3_bunkertop_relocategunners() {
  guy1 = getent("e3_bunker_gunner1", "targetname");
  if(isDefined(guy1)) {
    guy1 setGoalNode(getNode("e3_bunkertop_gunner1node", "targetname"));
  }
  guy2 = getent("e3_bunker_gunner2", "targetname");
  if(isDefined(guy2)) {
    guy2 setGoalNode(getNode("e3_bunkertop_gunner2node", "targetname"));
  }
  guy3 = getent("e3_bunker_gunner3", "targetname");
  if(isDefined(guy3)) {
    guy3 setGoalNode(getNode("e3_bunkertop_gunner3node", "targetname"));
  }
}

e3_sarge_mortar_reminder() {
  level endon("OBJ_5_COMPLETE");
  wait(30);
  level.sarge dialogue("mortarpositions");
}

e3_monitor_bunker_status() {
  vol = getent("e3_bunker_interior", "targetname");
  guys_inside = 0;
  while (1) {
    wait(1);
    guys_inside = 0;
    countdown_to_kill = 12;
    guys = getaiarray("axis");
    if(isDefined(guys) && guys.size) {
      for (i = 0; i < guys.size; i++) {
        if(isAlive(guys[i]) && guys[i] istouching(vol)) {
          guys_inside++;
        }
        if(countdown_to_kill == 0) {
          guys[i] thread random_death();
        }
      }
    }
    if(guys_inside == 0) {
      break;
    }
    if(guys_inside < 3) {
      countdown_to_kill--;
    }
  }
  e3_complete();
}

e3_complete() {
  level notify("OBJ_5_COMPLETE");
  battlechatter_off("allies");
  wait(1);
  level.sarge AllowedStances("stand");
  level.sarge dialogue("outstandingmarines");
  level.sarge dialogue("outfuckingstanding");
  level.sarge dialogue("tendwounded");
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] thread hud_fade_to_black(3);
    players[i] thread magic_bullet_shield();
  }
  wait(3);
  outro_start();
  nextmission();
}

e3_rightrear_linefight_start() {
  level endon("player_entered_tunnel");
  trig = getent("e3_rightrear_linefight_start", "targetname");
  trig waittill("trigger");
  thread manage_spawners_nogoal("e3_rightrear_linefight", 4, 6, "player_entered_tunnel", .1, undefined);
  thread e3_rightrear_spiderholes_start("e3_rightrear_spiderholes_trigger_ai");
  thread e3_rightrear_spiderholes_start("e3_rightrear_spiderholes_trigger_player");
}

e3_rightrear_spiderholes_start(triggername) {
  level endon("player_entered_tunnel");
  level endon("e3_rightrear_spiderholes_triggered");
  trig = getent(triggername, "targetname");
  trig waittill("trigger");
  spawntrig = getent("e3_rightrear_spiderholes_spawntrigger", "targetname");
  spawntrig notify("trigger");
}

e3_leftrear_linefight_start() {
  level endon("player_entered_tunnel");
  trig = getent("e3_leftrear_linefight_start", "targetname");
  trig waittill("trigger");
  thread manage_spawners_nogoal("e3_leftrear_linefight", 3, 4, "player_entered_tunnel", .1, undefined);
}

e3_left_treesnipers() {
  level endon("player_entered_tunnel");
  tree = getent("dunes_flame_tree", "script_noteworthy");
  model_tag_origin = spawn("script_model", tree.origin);
  model_tag_origin setmodel("tag_origin");
  model_tag_origin linkto(tree, "tag_origin", (0, 0, 0), (0, 0, 0));
  playfxontag(level._effect["sniper_leaf_loop"], model_tag_origin, "TAG_ORIGIN");
  trig = getent("e3_left_treesnipers_trigger", "targetname");
  trig waittill("trigger");
  simple_spawn("e3_left_treesnipers", ::e3_treesniper_spawn);
  model_tag_origin unlink();
  model_tag_origin delete();
  playfx(level._effect["sniper_leaf_canned"], tree.origin);
  pol_distance = distancesquared(level.polonsky.origin, trig.origin);
  sar_distance = distancesquared(level.sarge.origin, trig.origin);
  pass_distance = 750 * 750;
  if(pol_distance < pass_distance) {
    level.polonsky dialogue("snipersintrees");
    if(sar_distance < pass_distance) {
      level.sarge dialogue("iseeem");
    }
  }
  if(sar_distance < pass_distance) {
    level.sarge dialogue("bringemdown");
  }
  tree waittill("destroyed");
  sniper = getEnt("e3_left_treesnipers_alive", "targetname");
  if(isDefined(sniper) && isAlive(sniper)) {
    sniper thread random_death(1);
  }
}

e3_treesniper_spawn() {
  self endon("death");
  anim_node = getnode(self.target, "targetname");
  anim_point = getent(anim_node.target, "targetname");
  self.ignoreme = true;
  self.animname = "tree_guy";
  if(self.script_noteworthy == "climb") {
    self maps\_tree_snipers::do_climb(anim_point);
  }
  self.ignoreme = false;
  if(isDefined(self)) {
    self allowedstances("crouch");
  }
  self.allowdeath = true;
  self thread maps\_tree_snipers::tree_death(self, anim_point);
  self.health = 1;
}

#using_animtree("player");

outro_cacheplayer() {
  level.scr_model["player_hands"] = "viewmodel_usa_marinewet_rolledup_player";
  level.scr_animtree["player_hands"] = #animtree;
  level.scr_anim["player_hands"]["outro"] = % int_oki2_outro_player;
}

#using_animtree("generic_human");

outro_cachenpcs() {
  level.scr_anim["sarge"]["outro"] = % ch_okinawa2_outro_roebuck;
  level.scr_anim["polonsky"]["outro"] = % ch_okinawa2_outro_polonski;
  level.scr_anim["guy1"]["outro"] = % ch_okinawa2_outro_guy1;
  level.scr_anim["guy2"]["outro"] = % ch_okinawa2_outro_guy2;
  level.scr_anim["co"]["outro"] = % ch_okinawa2_outro_co;
}

#using_animtree("vehicles");

outro_cachevehicles() {
  level.scr_anim["truck"]["outro"] = % v_oki2_outro_gmc_truck;
  level.scr_animtree["truck"] = #animtree;
}

#using_animtree("vehicles");

outro_set_truck_animtree() {
  self useAnimTree(#animtree);
}

outro_kill_treesniper() {
  ent = getEnt("e3_left_treesnipers_alive", "targetname");
  if(isDefined(ent)) {
    ent Delete();
  }
}

outro_start() {
  setmusicstate("LEVEL_END");
  outro_kill_treesniper();
  level.nextmission_cleanup = ::fade_cleanup;
  level thread cleanup_trigger_enable("e3_rear_cleanup_volume");
  node = getent("outro_alignment", "targetname");
  disable_friendly_color();
  battlechatter_off("allies");
  move_players("outro_players_start");
  move_ai_single(level.sarge, "outro_alignment_struct");
  move_ai_single(level.polonsky, "outro_alignment_struct");
  outro_cacheplayer();
  outro_cachenpcs();
  outro_cachevehicles();
  outro_dialogue();
  players = get_players();
  for (i = 0; i < players.size; i++) {
    player = players[i];
    player SetClientDvar("hud_showStance", "0");
    player SetClientDvar("compass", "0");
    player SetClientDvar("ammoCounterHide", "1");
    player setClientDvar("miniscoreboardhide", "1");
  }
  share_screen(get_host(), true, true);
  players = get_players();
  p1 = players[0];
  for (i = 0; i < players.size; i++) {
    players[i] FreezeControls(true);
    players[i] DisableWeapons();
    players[i] DisableOffhandWeapons();
    players[i] TakeAllWeapons();
    players[i] StopUsingTurret();
    players[i] AllowJump(false);
    players[i] AllowCrouch(false);
    players[i] AllowProne(false);
    players[i] SetStance("stand");
    players[i] thread outro_delete_grenade();
    players[i] thread outro_prevent_bleedout();
    players[i] hide();
    players[i] thread play_outro_on_player(node);
  }
  guy1_spawn = getent("outro_guy1", "targetname");
  guy2_spawn = getent("outro_guy2", "targetname");
  co_spawn = getent("outro_co", "targetname");
  truck = getent("outro_truck", "targetname");
  guy1 = guy1_spawn stalingradspawn();
  guy2 = guy2_spawn stalingradspawn();
  co = co_spawn stalingradspawn();
  truck makefakeai();
  guy1.animname = "guy1";
  guy2.animname = "guy2";
  co.animname = "co";
  truck.animname = "truck";
  truck outro_set_truck_animtree();
  level.sarge Detach(level.sarge.hatmodel);
  guy1 gun_remove();
  node thread anim_single_solo(level.sarge, "outro");
  node thread anim_single_solo(level.polonsky, "outro");
  node thread anim_single_solo(guy1, "outro");
  node thread anim_single_solo(guy2, "outro");
  node thread anim_single_solo(co, "outro");
  node thread anim_single_solo(truck, "outro");
  wait(8);
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] thread hud_fade_in(2);
  }
  wait(29);
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] thread hud_fade_to_black(2);
  }
  share_screen(get_host(), false);
  players = get_players();
  for (i = 0; i < players.size; i++) {
    player = players[i];
    player SetClientDvar("hud_showStance", "1");
    player SetClientDvar("compass", "1");
    player SetClientDvar("ammoCounterHide", "0");
    player setClientDvar("miniscoreboardhide", "0");
  }
}

play_outro_on_player(node) {
  self.player_hands = spawn_anim_model("player_hands");
  self.player_hands hide();
  self.player_hands.animname = "player_hands";
  self.player_hands.origin = node.origin;
  self.player_hands.angles = node.angles;
  node maps\_anim::anim_first_frame_solo(self.player_hands, "outro");
  self lerp_player_view_to_tag(self.player_hands, "tag_player", 0.1, 1, 60, 25, 25, 10);
  self linkto(self.player_hands, "tag_player");
  node thread anim_single_solo(self.player_hands, "outro");
  self FreezeControls(false);
}

outro_delete_grenade() {
  self waittill("grenade_fire", what);
  what Delete();
}

outro_prevent_bleedout() {
  self endon("death");
  self endon("disconnect");
  while (1) {
    if(self maps\_laststand::player_is_in_laststand()) {
      self RevivePlayer();
      self.bleedout_time = 100000;
    }
    wait_network_frame();
  }
}

outro_dialogue() {
  addnotetrack_dialogue("polonsky", "dialog", "outro", "Oki2_OUT_007A_POLO");
  addnotetrack_dialogue("polonsky", "dialog", "outro", "Oki2_OUT_009A_POLO");
  addnotetrack_dialogue("polonsky", "dialog", "outro", "Oki2_OUT_011A_POLO");
  addnotetrack_dialogue("polonsky", "dialog", "outro", "Oki2_OUT_012A_POLO");
  addnotetrack_dialogue("polonsky", "dialog", "outro", "Oki2_OUT_013A_POLO");
  addnotetrack_dialogue("polonsky", "dialog", "outro", "Oki2_OUT_017A_POLO");
  addnotetrack_dialogue("sarge", "dialog", "outro", "Oki2_OUT_001A_ROEB");
  addnotetrack_dialogue("sarge", "dialog", "outro", "Oki2_OUT_002A_ROEB");
  addnotetrack_dialogue("sarge", "dialog", "outro", "Oki2_OUT_003A_ROEB");
  addnotetrack_dialogue("sarge", "dialog", "outro", "Oki2_OUT_005A_ROEB");
  addnotetrack_dialogue("sarge", "dialog", "outro", "Oki2_OUT_006A_ROEB");
  addnotetrack_dialogue("co", "dialog", "outro", "Oki2_OUT_004A_MAJG");
  addnotetrack_dialogue("co", "dialog", "outro", "Oki2_OUT_008A_MAJG");
  addnotetrack_dialogue("co", "dialog", "outro", "Oki2_OUT_010A_MAJG");
  addnotetrack_dialogue("co", "dialog", "outro", "Oki2_OUT_014A_MAJG");
  addnotetrack_dialogue("co", "dialog", "outro", "Oki2_OUT_016A_MAJG");
}

outro_startpoint() {
  wait_for_first_player();
  setup_friends();
  move_players("outro_players_start");
  move_ai_single(level.sarge, "outro_sarge_start");
  move_ai_single(level.polonsky, "outro_polonsky_start");
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] thread hud_fade_to_black(1);
  }
  level waittill("introscreen_complete");
  outro_start();
  nextmission();
}

e1_gun_fall() {
  level.cliff_destroyed hide();
  level.cliff_gun = getent("falling_gun", "targetname");
  level.cliff_gun hide();
  exp1_origin = getstruct("e1_cliffgun_bomb_a", "targetname").origin;
  exp2_origin = level.cliff_gun.origin;
  exp3_origin = getstruct("e1_cliffgun_bomb_b", "targetname").origin;
  trig = getent("more_cave_defenders", "script_noteworthy");
  trig waittill("trigger");
  bomber_trig = getent("cliff_bomber", "targetname");
  bomber_trig notify("trigger");
  wait(1);
  bomber = getent("e1_bomber_a", "targetname");
  bomber playsound("planeby_3");
  plane = getent("e1_bomber_b", "targetname");
  plane playsound("planeby_3");
  bomber waittill("e1_bombers_above_target");
  gun = getent("falling_gun_hideme", "targetname");
  gun notify("crew dismounted");
  gun.nofire = true;
  level notify("stop_cliffgun");
  gun thread e1_arty_crew_setup_death();
  playfx(level._effect["default_explosion"], exp1_origin);
  playsoundatposition("mortar_dirt", exp1_origin);
  radiusdamage(exp1_origin, 512, 1000, 250);
  exp1_palm = getent("e1_cliffgun_bomb01_palm", "targetname");
  exp1_palm thread tree_rotate();
  wait(0.4);
  playfx(level._effect["default_explosion"], exp2_origin);
  playsoundatposition("mortar_dirt", exp2_origin);
  radiusdamage(exp2_origin, 512, 1000, 250);
  level.cliff_destroyed show();
  level.cliff_intact hide();
  gun hide();
  level.cliff_gun show();
  for (i = 0; i < level.cliff_rocks.size; i++) {
    level.cliff_rocks[i] delete();
  }
  wait(0.4);
  playfx(level._effect["default_explosion"], exp3_origin);
  playsoundatposition("mortar_dirt", exp3_origin);
  radiusdamage(exp3_origin, 512, 1000, 250);
  exp3_palm = getent("e1_cliffgun_bomb03_palm", "targetname");
  exp3_palm thread tree_rotate();
  playfx(level._effect["falling_rocks"], (2010, 625, -156.5));
  level.cliff_gun moveto((2095.45, 603.123, -353), 2.5);
  level.cliff_gun rotateto((47.0138, 302.803, -85.4194), 2.4);
  wait(1);
  level.cliff_gun playsound("gun_slide");
  level.cliff_gun waittill("movedone");
  playfx(level._effect["gunsmoke"], level.cliff_gun.origin + (0, 0, 25));
}

#using_animtree("generic_human");

e1_arty_crew_setup_death() {
  if(isDefined(self.arty_crew) && (self.arty_crew.size > 0) && isAlive(self.arty_crew)) {
    for (i = 0; i < self.arty_crew.size; i++) {
      self.arty_crew[i].deathanim = % death_explosion_forward13;
      throw_guy(self.arty_crew[i], self.arty_crew[i].origin + (500, 0, -250));
    }
  }
  self notify("dismount crew");
  self.nofire = true;
  wait_network_frame();
  radiusdamage(self.origin, 256, 1000, 1000);
}

tree_rotate() {
  self rotateto((180, 270, 0), 1.0, 0.2, 0.3);
  wait(2.0);
}

fire_rocket_series(launch_points_targetname, destination_vector, total_rockets, silent_launch) {
  num_rockets = total_rockets;
  start_points = [];
  orgs = getstructarray(launch_points_targetname, "targetname");
  q = 0;
  for (i = 0; i < num_rockets; i++) {
    q = i % orgs.size;
    start_points[i] = orgs[q].origin;
  }
  level thread rocket_salvo(destination_vector, start_points, silent_launch);
}

rocket_salvo(dest_point, start_points, silent_launch) {
  use_launch_effects = true;
  if(isDefined(silent_launch) && silent_launch == true) {
    use_launch_effects = false;
  }
  for (i = 0; i < start_points.size; i++) {
    rocket = spawn("script_model", start_points[i]);
    rocket setmodel("peleliu_aerial_rocket");
    yaw_vec = vectortoangles(dest_point - rocket.origin);
    rocket.angles = (yaw_vec[0], yaw_vec[1], 0);
    rocket.targetname = "oki_salvo_rocket";
    wait(0.01);
    if(use_launch_effects) {
      playfx(level._effect["rocket_launch"], rocket.origin, anglestoforward(rocket.angles + (20, 0, 0)));
    }
    playfxontag(level._effect["rocket_trail"], rocket, "tag_origin");
    level thread rocket_sound(rocket);
    rocket thread rocket_think((dest_point[0] - 1500 + randomint(3000), dest_point[1] - 1500 + randomint(3000), dest_point[2] + randomint(40)));
    wait(randomfloatrange(0.15, 0.3));
  }
  wait(15);
  rockets = getentarray("oki_salvo_rocket", "targetname");
  if(isDefined(rockets)) {
    for (i = 0; i < rockets.size; i++) {
      rockets[i] notify("force delete");
      rockets[i] delete();
    }
  }
}

throw_object_with_gravity(object, target_pos) {
  object endon("remove thrown object");
  start_pos = object.origin;
  gravity = GetDvarInt("g_gravity") * -1;
  dist = Distance(start_pos, target_pos);
  time = dist / 2000;
  delta = target_pos - start_pos;
  drop = 0.5 * gravity * (time * time);
  velocity = ((delta[0] / time), (delta[1] / time), (delta[2] - drop) / time);
  object MoveGravity(velocity, time);
}

rocket_sound(rocket) {
  counter = RandomIntRange(1, 2);
  if(counter == 1) {
    rocket playloopsound("rocket_run");
  }
}

rocket_think(destination_pos) {
  self endon("force delete");
  thread throw_object_with_gravity(self, destination_pos);
  while (1) {
    if(self.origin[2] < destination_pos[2]) {
      playfx(level._effect["lci_rocket_impact"], self.origin);
      thread play_sound_in_space("rocket_dirt", self.origin);
      earthquake(0.5, 3, self.origin, 2050);
      break;
    }
    wait(0.05);
  }
  self notify("remove thrown object");
  wait(0.1);
  self delete();
}

throw_guy(guy, targetpos) {
  throw_object_with_gravity(guy, targetpos);
  guy StartRagdoll();
}