/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel1b.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_music;
#using_animtree("generic_human");

do_precaching() {
  precacheShellShock("teargas");
  precacheModel("weapon_ger_panzershreck_rocket");
  precachemodel("weapon_usa_explosive");
  precachemodel("aircraft_bomb");
  precachemodel("char_usa_marine_radiohandset");
  precacheRumble("artillery_rumble");
  precacheRumble("explosion_generic");
  precacheRumble("damage_heavy");
  precacheRumble("tank_rumble");
  precacheModel("projectile_us_smoke_grenade");
}

main() {
  flag_init("art_1_destroyed");
  flag_init("art_2_destroyed");
  flag_init("tank3_reached");
  flag_init("guy_trapped");
  flag_init("guy_trapped2");
  flag_init("flametank_destroy_trig");
  flag_init("event1_objectives_done");
  flag_init("flametank_in_second_area");
  flag_init("roebuck_reached_outro");
  flag_init("polonsky_reached_outro");
  flag_init("radio_guy_reached_outro");
  flag_init("start_dialogue");
  maps\pel1b_fx::main();
  do_precaching();
  maps\_sherman::main("vehicle_usa_tracked_shermanm4a3_camo");
  maps\_artillery::main("artillery_jap_47mm", "at47");
  maps\_sherman::main("vehicle_usa_tracked_shermanm4a3_camo", "sherman_flame");
  maps\_aircraft::main("vehicle_usa_aircraft_f4ucorsair", "corsair");
  maps\_triple25::main("artillery_jap_triple25mm", "triple25");
  maps\_p51::main("vehicle_p51_mustang");
  maps\_model3::main("artillery_jap_model3");
  maps\_destructible_type94truck::init();
  character\char_jap_makpel_rifle::precache();
  character\char_usa_marine_r_rifle::precache();
  level.drone_spawnFunction["axis"] = character\char_jap_makpel_rifle::main;
  level.drone_spawnFunction["allies"] = character\char_usa_marine_r_rifle::main;
  maps\_drones::init();
  default_start(::event1_dogAttack);
  add_start("ArtilleryKill", ::event1_dogAttack, &"STARTS_PEL1B_EVENT1");
  add_start("ArtilleryKilla", ::event1a_skipto_setup, &"STARTS_PEL1B_EVENT1A");
  add_start("FlameDeath", ::event1b_skipto_setup, &"STARTS_PEL1B_EVENT1b");
  add_start("outro", ::outro_skipto_setup, &"STARTS_PEL1B_OUTRO");
  level.startskip = "event1";
  maps\_load::main();
  maps\_banzai::init();
  maps\_tree_snipers::main();
  maps\_mganim::main();
  maps\pel1b_anim::main();
  level.maxfriendlies = 6;
  if(NumRemoteClients() > 1) {
    SetAiLimit(24);
  }
  createthreatbiasgroup("players");
  createthreatbiasgroup("heroes");
  level.heroes = [];
  level.sarge = getent("sarge", "script_noteworthy");
  level.heroes[0] = level.sarge;
  level.walker = getent("walker", "script_noteworthy");
  level.heroes[1] = level.walker;
  level.sarge setthreatbiasgroup("heroes");
  level.walker setthreatbiasgroup("heroes");
  level.allies = [];
  level.allies = getEntArray("starting_allies", "targetname");
  players_ignoreall(level.allies, 1);
  array_thread(level.heroes, ::magic_bullet_shield);
  level thread setup_spawn_functions();
  level thread maps\pel1b_amb::main();
  createthreatbiasgroup("friendlies_right_side");
  createthreatbiasgroup("japs_on_right_art");
  createthreatbiasgroup("japs_on_hut");
  setignoremegroup("friendlies_right_side", "japs_on_right_art");
  setignoremegroup("japs_on_right_art", "friendlies_right_side");
}

event1_dogAttack() {
  flag_wait("all_players_connected");
  wait(0.1);
  freezecontrols_all(false);
  players = get_players();
  for(i = 0; i < players.size; i++) {
    players[i] AllowCrouch(false);
    players[i] AllowProne(false);
    players[i] AllowStand(true);
  }
  wait(0.5);
  freezecontrols_all(true);
  level thread in_game_dialogue_setup();
  level thread event1_battlechatter();
  level thread event1_set_start_position();
  level thread event1_hide_hud();
  level thread event1_show_hud();
  level.event1 = true;
  level.tank2 = getent("tank2", "targetname");
  level.tank3 = getent("tank3", "targetname");
  level.flametank = getent("flametank", "targetname");
  level.flametank thread keep_flametank_alive();
  level.tank3 thread keep_tank_alive();
  level thread event1_startothertanks();
  level thread event1_tank3_targets_link();
  level thread event1_player_ride_think();
  level thread event1_ai_ride_think();
  level thread event1_setup_aa_gun();
  level thread event1_Objectivewaiter();
  level thread event1_objective_blocker();
  level thread event1_artillaryattack();
  level thread event1_right_artsetup();
  level thread event1_followtanks();
  level thread event1_cleanup();
  level thread event1b_friendlies_cleaup1_co_op();
  level thread event1_objective_thread_right_art();
  level thread event1_objective_thread_left_art();
  level thread event1_objective_thread_follow_squad();
  level thread event1_held_guy();
  level thread event1_ambient_planes_setup();
  level thread snare_trap_thread();
}

event1_hide_hud() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    player SetClientDvar("hud_showStance", "0");
    player SetClientDvar("compass", "0");
    player SetClientDvar("ammoCounterHide", "1");
    player setclientdvar("miniscoreboardhide", "1");
  }
}

event1_show_hud() {
  level waittill("tank2_attacked");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    player SetClientDvar("hud_showStance", "1");
    player SetClientDvar("compass", "1");
    player SetClientDvar("ammoCounterHide", "0");
    player setclientdvar("miniscoreboardhide", "0");
  }
}

event1_tank3_targets_link() {
  level.tank3_targets = getEntArray("tank2_firepoints", "targetname");
  for(i = 0; i < level.tank3_targets.size - 1; i++) {
    level.tank3_targets[i] linkto(level.tank3);
  }
  targetpos = getent("tank2_firepoints_final", "targetname");
  targetpos linkto(level.tank3);
}

event1_battlechatter() {
  setmusicstate("INTRO");
  thread battlechatter_off("allies");
  thread battlechatter_off("axis");
  level waittill("tank2_attacked");
  setmusicstate("FIRST_FIGHT");
  thread battlechatter_on("allies");
  thread battlechatter_on("axis");
}

event1_set_start_position() {
  players = get_sorted_players();
  player_starts = get_sorted_starts();
  for(i = 0; i < players.size; i++) {
    players[i] SetOrigin(player_starts[i].origin);
    players[i] SetPlayerAngles(player_starts[i].angles);
  }
}

event1_objectivewaiter() {
  self waittill("tank2_attacked");
  art_on_left = getent("event1_art_left", "targetname");
  thread set_objectives(1);
}

event1_startothertanks() {
  tank2_trig = getent("tank2start", "targetname");
  tank2_trig notify("trigger");
  tank3_trig = getent("tank3start", "targetname");
  tank3_trig notify("trigger");
  wait(2);
  tank1_trig = getent("tank1start", "targetname");
  tank1_trig notify("trigger");
  thread event1_flame_tank_waiter();
  player_unblocker = getvehiclenode("auto3683", "targetname");
  player_unblocker waittill("trigger");
  event1_unlockplayer();
  event1_guys_with_player_follow_tanks();
}

event1_player_ride_think() {
  tags = getEntArray("player_dismount_points", "targetname");
  for(i = 0; i < tags.size; i++) {
    if(issubstr(tags[i].script_noteworthy, "flametank")) {
      tags[i] linkto(level.flametank);
    } else if(issubstr(tags[i].script_noteworthy, "tank2")) {
      tags[i] linkto(level.tank3);
    }
  }
  players = get_sorted_players();
  passenger_pos = 8;
  for(i = 0; i < 2; i++) {
    if(isDefined(players[i])) {
      link_tag = "tag_passenger" + passenger_pos;
      fall_tag = getent("flametank_" + link_tag, "script_noteworthy");
      org = level.flametank gettagOrigin(link_tag);
      angles = level.flametank gettagangles(link_tag);
      players[i].lvt_linkspot_ref = spawn("script_origin", org);
      if(passenger_pos == 8) {
        players[i].lvt_linkspot_ref linkto(level.flametank, link_tag, (0, 0, 0), (0, 80, 0));
      } else {
        players[i].lvt_linkspot_ref linkto(level.flametank, link_tag, (0, 0, 0), (0, 280, 0));
      }
      players[i] DisableWeapons();
      players[i] PlayerLinkToDelta(players[i].lvt_linkspot_ref, undefined, 1);
      players[i] setorigin(org);
      players[i] setplayerangles(angles);
      players[i] thread player_combatidleanimloop(link_tag);
      players[i] thread player_combatdismountanimloop(link_tag);
      players[i] thread event1_player_tank_dismount(players[i], fall_tag);
      passenger_pos++;
    }
  }
  passenger_pos = 8;
  for(i = 2; i < 4; i++) {
    if(isDefined(players[i])) {
      link_tag = "tag_passenger" + passenger_pos;
      fall_tag = getent("tank2_" + link_tag, "script_noteworthy");
      org = level.tank3 gettagOrigin(link_tag);
      angles = level.tank3 gettagangles(link_tag);
      players[i].lvt_linkspot_ref = spawn("script_origin", org);
      if(passenger_pos == 8) {
        players[i].lvt_linkspot_ref linkto(level.tank3, link_tag, (0, 0, 0), (0, 80, 0));
      } else {
        players[i].lvt_linkspot_ref linkto(level.tank3, link_tag, (0, 0, 0), (0, 280, 0));
      }
      players[i] DisableWeapons();
      players[i] PlayerLinkToDelta(level.tank3, link_tag, 1);
      players[i] setorigin(org);
      players[i] setplayerangles(angles);
      players[i] thread player_combatidleanimloop(link_tag);
      players[i] thread player_combatdismountanimloop(link_tag);
      players[i] thread event1_player_tank_dismount(players[i], fall_tag);
      passenger_pos++;
    }
  }
}

player_combatidleanimloop(link_tag) {
  self endon("dismounted");
  if(issubstr(link_tag, "8")) {
    self playeranimscriptevent("sherman_ride_player_combat_idle_8");
  } else {
    self playeranimscriptevent("sherman_ride_player_combat_idle_9");
  }
}

player_combatdismountanimloop(link_tag) {
  self waittill("attacked");
  self hide();
  wait(16);
  self show();
}

event1_player_tank_dismount(player, fall_tag) {
  level waittill("tank2_attacked");
  hud = newClientHudElem(player);
  hud.alignX = "center";
  hud.x = 450;
  hud.y = 300;
  hud.alignX = "right";
  hud.alignY = "bottom";
  hud.fontScale = 1.5;
  hud.alpha = 1.0;
  hud.sort = 20;
  hud.font = "default";
  if(level.console) {
    hud SetText(&"PEL1B_PLAYER_DISMOUNT");
  } else {
    hud SetText(&"SCRIPT_PLATFORM_PEL1B_PLAYER_DISMOUNT");
  }
  player thread event1_tank_explosion_effect();
  player.dismount_timer_over = false;
  player thread dismount_timer();
  player notify("attacked");
  while((!player useButtonPressed()) && (player.dismount_timer_over != true)) {
    wait(0.05);
  }
  player notify("dismounted");
  hud settext("");
  player unlink();
  fall_tag unlink();
  player SetOrigin(fall_tag.origin + (0, 0, 0));
  angles = (fall_tag.angles[0], fall_tag.angles[1], 0.0);
  fall_tag.angles = angles;
  player SetPlayerAngles(fall_tag.angles);
  player AllowProne(true);
  player AllowCrouch(true);
  player AllowStand(true);
  wait(RandomFloatRange(3.0, 5.0));
  player enableWeapons();
  hud destroy();
}

dismount_timer() {
  timer = gettime() + (2 * 1000);
  while(getTime() < timer) {
    wait(0.05);
  }
  self.dismount_timer_over = true;
}

event1_tank_explosion_effect() {
  Earthquake(RandomFloatRange(0.5, 1.5), 1, self.origin, 1000);
  self shellshock("tankblast", randomfloatrange(9, 12));
  self PlayRumbleOnEntity("artillery_rumble");
  self thread set_all_players_double_vision(2, 1);
  self thread set_all_players_blur(2, 1);
  wait(5);
  self thread set_all_players_double_vision(0, 1);
  self thread set_all_players_blur(0, 1);
}

event1_artillaryattack() {
  thread event1_tank2_attacked();
  thread event1_tank3_attacked();
}

event1_right_artsetup() {
  art_on_right = maps\_vehicle::waittill_vehiclespawn("event1_art_right");
  wait(2);
  art_on_right = getent("event1_art_right", "targetname");
  random_target = randomintrange(0, level.tank3_targets.size - 1);
  art_on_right setTurretTargetEnt(level.tank3_targets[random_target]);
  art_on_right threadevent1_right_art_stop_fire();
  art_on_right thread event1_arty_fire();
}

event1_setup_aa_gun() {
  aa_gun = maps\_vehicle::waittill_vehiclespawn("aa_gun_bunker");
  aa_gun thread event1_aa_gun_fire();
  aa_gun thread event1_aa_gunner_alert();
}

event1_aa_gun_fire() {
  self endon("crew dead");
  targetent = getEntArray("event1_aa_gun_target", "targetname");
  while(!flag("tank2_move_1")) {
    self notify("change target");
    self thread maps\_triple25::triple25_shoot(targetent[randomintrange(0, targetent.size - 1)]);
    wait(randomintrange(0, 5));
  }
}

event1_aa_gunner_alert() {
  wait(2);
  trig = getent("test", "script_noteworthy");
  thread maps\_triple25::dismount_think(trig, self.triple25_gunner[0], self);
  thread maps\_triple25::dismount_think(trig, self.triple25_gunner[1], self);
  self waittill_either("crew dismount", "crew dead");
  if(self.health) {
    self clearturrettarget();
    self makevehicleusable();
  }
}

event1_followtanks() {
  guys = [];
  guys[0] = getent("guys_following_tank2_1", "script_noteworthy");
  guys[1] = getent("guys_following_tank2_2", "script_noteworthy");
  guys[2] = getent("guys_following_tank3_1", "script_noteworthy");
  guys[3] = getent("guys_following_tank3_2", "script_noteworthy");
  event1_followtankInternal(level.tank2, 2, guys[0]);
  event1_followtankInternal(level.tank2, 1, guys[1]);
  event1_followtankInternal(level.tank3, 2, guys[2]);
  event1_followtankInternal(level.tank3, 1, guys[3]);
}

event1_unlockplayer() {
  blocker = [];
  blocker = getEntArray("player_blocker", "targetname");
  for(i = 0; i < blocker.size; i++) {
    blocker[i] delete();
  }
}

event1_guys_with_player_follow_tanks() {}

event1_tank2_attacked() {
  riding_guys = getEntArray("passenger_" + level.tank2.targetname, "targetname");
  thread event1_artillary_fire();
  tank2_first_attack = getvehiclenode("auto3590", "targetname");
  tank2_first_attack waittill("trigger");
  shreck_start_pos = getstruct("shreck_start", "targetname");
  shreck_end_pos = getstruct("shreck_end", "targetname");
  thread fire_shrecks(shreck_start_pos, shreck_end_pos, 1);
  shreck_start_pos = getstruct("shreck_start2", "targetname");
  shreck_end_pos = getstruct("shreck_end2", "targetname");
  thread fire_shrecks(shreck_start_pos, shreck_end_pos, 1);
  level notify("incoming");
  wait(1);
  level notify("tank2_attacked");
  thread event1_riders_take_cover_and_die();
  thread event1_ai_takes_cover_behind_rocks();
  players_ignoreall(level.allies, 0);
  thread event1_kill_if_riders_are_alive(level.tank2);
  tank2_second_attack = getvehiclenode("auto3578", "targetname");
  tank2_second_attack waittill("trigger");
  fire_shrecks_with_damage(level.tank2, level.tank2.health + 200);
  level.tank2 disconnectpaths();
  wait(1);
  friendlies_move = getent("second_color_trig", "targetname");
  friendlies_move notify("trigger");
  japs_first_wave();
}

japs_first_wave() {
  trig_jap_first_wave = getent("first_jap_attack_trig", "script_noteworthy");
  trig_jap_first_wave notify("trigger");
  wait_network_frame();
  grass_trig = getent("grass_guy_trig", "targetname");
  grass_trig notify("trigger");
}

event1_kill_if_riders_are_alive(tank) {
  riding_guys = getEntArray("passenger_" + tank.targetname, "targetname");
  thread event1_tank3_riders_explosion_death(riding_guys);
  if(riding_guys.size > 0) {
    for(i = 0; i < riding_guys.size; i++) {
      if(isDefined(riding_guys[i]) && isalive(riding_guys[i])) {
        thread event1_rider_dismount_anim(tank, riding_guys[i], "unloaded" + i);
      }
    }
  }
  waittill_multiple("unloaded0", "unloaded1", "unloaded2");
  level notify("unload_done");
}

event1_tank3_riders_explosion_death(riding_guys) {
  level waittill("unload_done");
  for(i = 0; i < riding_guys.size; i++) {
    if(isDefined(riding_guys[i]) && isalive(riding_guys[i])) {
      riding_guys[i].deathanim = level.explosion_anim["explosion_death"][i];
      riding_guys[i] dodamage(riding_guys[i].health + 100, riding_guys[i].origin);
    }
  }
}

event1_bomber_crash() {
  crash_plane = maps\_vehicle::waittill_vehiclespawn("event1b_crashing_plane1");
  hitnoode = getvehiclenode("auto5004", "targetname");
  hitnoode waittill("trigger");
  looper = playFXOnTag(level._effect["bomber_wing_hit"], crash_plane, "tag_origin");
  hitnoode = getvehiclenode("auto4225", "targetname");
  hitnoode waittill("trigger");
  players = get_sorted_players();
  for(i = 0; i < players.size; i++) {
    earthquake(0.4, 4, players[i].origin, 850);
  }
  destroyed_model = getent("destroyed_corsair", "targetname");
  destroyed_model.origin = hitnoode.origin;
}

event1_tank3_attacked() {
  self waittill("tank2_attacked");
  thread event1_right_side_friendly_setup();
  thread event1_hutexplosion();
  thread event1_explosion_near_right_side_friendlies();
  thread fire_shrecks_without_damage(level.tank3, false);
  level.tank3 joltbody(level.tank3.origin + (0, 0, 20), 0.5);
  thread play_rumble_effect();
  self thread tank_loopfire(level.tank3, 5);
  tank3_attack = getvehiclenode("auto4133", "targetname");
  tank3_attack waittill("trigger");
  level.tank3 setspeed(0, 6, 8);
  level.tank3 disconnectpaths();
  thread event1_tank3_moveup_start();
  thread right_art_target_strat();
}

right_art_target_strat() {
  flag_wait("tank2_move_1");
  art_on_right = getent("event1_art_right", "targetname");
  while(!flag("tank3_reached")) {
    random_target = randomintrange(0, level.tank3_targets.size - 1);
    art_on_right setTurretTargetEnt(level.tank3_targets[random_target]);
    wait(randomintrange(3, 5));
  }
  art_on_right setTurretTargetEnt(getent("tank2_firepoints_final", "targetname"));
  wait(1);
  if(isalive(level.tank3)) {
    fire_shrecks_with_damage(level.tank3, level.tank3.health + 200);
  }
}

event1_tank3_moveup_start() {
  flag_wait("tank2_move_1");
  level.tank3 thread tank_loopfire_forever();
  level.tank3setspeed(5, 6, 8);
  stop_at_node = getvehiclenode("auto4137", "targetname");
  stop_at_node waittill("trigger");
  targetent = getent("tank3_targets_1", "targetname");
  level.tank3 setTurretTargetEnt(targetent);
  if(!flag("tank2_move_2")) {
    level.tank3 setspeed(0, 6, 8);
    flag_wait("tank2_move_2");
  }
  level.tank3setspeed(4, 6, 8);
  stop_at_node = getvehiclenode("auto4139", "targetname");
  stop_at_node waittill("trigger");
  targetent = getent("tank3_targets_2", "targetname");
  level.tank3 setTurretTargetEnt(targetent);
  if(!flag("tank2_move_3")) {
    level.tank3 setspeed(0, 6, 8);
    flag_wait("tank2_move_3");
  }
  level.tank3setspeed(4, 6, 8);
  stop_at_node = getvehiclenode("auto4144", "targetname");
  stop_at_node waittill("trigger");
  targetent = getent("tank3_targets_3", "targetname");
  level.tank3 setTurretTargetEnt(targetent);
  wait(0.5);
  targetent = getent("tank3_targets_4", "targetname");
  level.tank3 setTurretTargetEnt(targetent);
  flag_set("tank3_reached");
}

tank_loopfire_forever() {
  self endon("death");
  while(!flag("tank3_reached")) {
    if(self.health > 0) {
      self fireweapon();
      wait(randomintrange(5, 8));
    }
  }
}

event1_flametank_moveup_strat() {
  flag_wait("tank2_move_1");
  level.flametank.script_nomg = undefined;
  level.flametanksetspeed(5, 6, 8);
  stop_at_node = getvehiclenode("auto3694", "targetname");
  stop_at_node waittill("trigger");
  if(!flag("tank2_move_2")) {
    level.flametank setspeed(0, 6, 8);
    flag_wait("tank2_move_2");
  }
  level.flametanksetspeed(4, 6, 8);
  stop_at_node = getvehiclenode("auto3695", "targetname");
  stop_at_node waittill("trigger");
  if(!flag("tank2_move_3")) {
    level.flametank setspeed(0, 6, 8);
    flag_wait("tank2_move_3");
  }
  level.flametanksetspeed(4, 6, 8);
  stop_at_node = getvehiclenode("auto3711", "targetname");
  stop_at_node waittill("trigger");
  if(!flag("flametank_move")) {
    level.flametank setspeed(0, 6, 8);
    flag_wait("flametank_move");
  }
  level.flametanksetspeed(4, 6, 8);
  stop_at_node = getvehiclenode("event2_tank_start", "targetname");
  stop_at_node waittill("trigger");
  level.flametank setspeed(0, 6, 8);
  flag_set("flametank_in_second_area");
}

event1_right_side_friendly_setup() {
  flag_wait("tank2_move_2");
  if(!NumRemoteClients() || (NumRemoteClients() == 1)) {
    friendly_trig = getent("second_area_friendlies_trig", "script_noteworthy");
    friendly_trig notify("trigger");
  }
}

event1_hutexplosion() {
  thread event1_hut_waiter_setup();
  hut_explode = getent("tank3_targets_2", "targetname");
  level waittill_any("hut_explode1", "hut_explode2");
  wait(2);
  playFX(level._effect["hut_explosion"], hut_explode.origin);
  playsoundatposition("hut_explo", hut_explode.origin);
  earthquake(0.3, 1.5, hut_explode.origin, 1000);
  event1_hutexplosion_remains();
  things = getEntArray("hut_explosion_debris", "targetname");
  for(i = 0; i < things.size; i++) {
    things[i] delete();
  }
}

event1_hutexplosion_remains() {
  fire_points = getstructarray("hut_fire_effect", "targetname");
  for(i = 0; i < fire_points.size; i++) {
    size = randomintrange(0, 1);
    if(size == 0) {
      playFX(level._effect["fire_foliage_small"], fire_points[i].origin);
    } else {
      playFX(level._effect["fire_foliage_xsmall"], fire_points[i].origin);
    }
  }
}

event1_hut_waiter_setup() {
  thread event1_hut_waiter_setup2();
  lookat_hut = getent("hut_explosion_lookat_trig", "targetname");
  lookat_hut waittill("trigger");
  level notify("hut_explode1");
}

event1_hut_waiter_setup2() {
  lookat_hut = getent("eleventh_color_trig", "targetname");
  lookat_hut waittill("trigger");
  level notify("hut_explode2");
}

event1_explosion_near_right_side_friendlies() {
  level waittill("tank3_attacked");
  friendlyattacked = getstructarray("right_friendly_attacked", "targetname");
  for(i = 0; i < friendlyattacked.size; i++) {
    playFX(level._effect["rocket_explode"], friendlyattacked[i].origin);
  }
}

event1_friendlies_on_right_side_think() {
  iprintlnbold("right side friendlies spawned");
}

event1_japs_on_hut_strat() {
  self setthreatbiasgroup("japs_on_hut");
}

event1_ai_takes_cover_behind_rocks() {
  rightnodes = [];
  leftnodes = [];
  rcount = 0;
  lcount = 0;
  rightnodes = getnodearray("guys_go_right", "targetname");
  leftnodes = getnodearray("guys_go_left", "targetname");
  for(i = 0; i < level.allies.size; i++) {
    if(isDefined(level.allies[i]) && isalive(level.allies[i])) {
      if(level.allies[i].script_string == "guys_go_right") {
        level.allies[i] notify("unload");
        level.allies[i] setgoalnode(rightnodes[rcount]);
        rcount++;
        level.allies[i] thread event1_ai_kill_redshirts();
      } else if(level.allies[i].script_string == "guys_go_left") {
        level.allies[i] notify("unload");
        level.allies[i] setgoalnode(leftnodes[lcount]);
        lcount++;
        if(level.allies[i].script_noteworthy == "guys_following_tank3_1") {
          level.allies[i] thread magic_bullet_shield();
        }
        if(level.allies[i].script_noteworthy == "guys_following_tank2_1") {
          level.allies[i] thread magic_bullet_shield();
          level.allies[i] snare_trap_handle_triggerer();
        }
      }
    }
  }
}

event1_ai_kill_redshirts() {
  self waittill("goal");
  self thread bloody_death();
}

event1_riders_take_cover_and_die() {
  tank3 = getent("tank3", "targetname");
  riding_guys = getEntArray("passenger_tank3", "targetname");
  riding_guys[0] thread magic_bullet_shield();
  riding_guys[1] threadmagic_bullet_shield();
  riding_guys[0].script_vehicleride = 300;
  riding_guys[1].script_vehicleride = 300;
  thread event1_rider_dismount_anim(tank3, riding_guys[0]);
  thread event1_rider_dismount_anim(tank3, riding_guys[1]);
  riding_guys[0] thread set_force_color("g");
  riding_guys[1] thread set_force_color("g");
  roebuck = getent("walker", "script_noteworthy");
  polonsky = getent("sarge", "script_noteworthy");
  thread event1_rider_dismount_anim(level.flametank, roebuck);
  thread event1_rider_dismount_anim(level.flametank, polonsky);
}

event1_ai_ride_think() {
  tank2_riders = getEntArray("passenger_tank2", "targetname");
  tank2_riders[0] thread event1_rider_idle_anim(level.tank2, tank2_riders[0]);
  tank2_riders[1] thread event1_rider_idle_anim(level.tank2, tank2_riders[1]);
  tank2_riders[2] thread event1_rider_idle_anim(level.tank2, tank2_riders[2]);
  tank3_riders = getEntArray("passenger_tank3", "targetname");
  tank3_riders[0] thread event1_rider_idle_anim(level.tank3, tank3_riders[0]);
  tank3_riders[1] thread event1_rider_idle_anim(level.tank3, tank3_riders[1]);
  flametank_riders[0] = getent("walker", "script_noteworthy");
  flametank_riders[1] = getent("sarge", "script_noteworthy");
  flametank_riders[0] thread event1_rider_idle_anim_roebuck_roebuck(level.flametank, flametank_riders[0]);
  flametank_riders[1] thread event1_rider_idle_anim(level.flametank, flametank_riders[1]);
}

event1_rider_idle_anim(tank, rider) {
  self endon("dismounting");
  while(1) {
    rider.animname = "rider" + rider.script_startingposition;
    tag = "tag_passenger" + rider.script_startingposition;
    rider linkto(tank, tag);
    tank anim_single_solo(rider, "idle", tag, undefined, tank);
  }
}

event1_rider_idle_anim_roebuck_roebuck(tank, rider) {
  self endon("dismounting");
  while(1) {
    rider.animname = "roebuck";
    tag = "tag_passenger" + rider.script_startingposition;
    rider linkto(tank, tag);
    tank anim_single_solo(rider, "idle", tag, undefined, tank);
  }
}

event1_rider_dismount_anim(tank, rider, notify_string) {
  rider notify("dismounting");
  rider.animname = "rider" + rider.script_startingposition;
  tag = "tag_passenger" + rider.script_startingposition;
  tank anim_single_solo(rider, "dismounta", tag, undefined, tank);
  rider unlink();
  rider.animname = "rider" + rider.script_startingposition;
  rider anim_single_solo(rider, "dismountb", "tag_origin", undefined, rider);
  if(isDefined(notify_string)) {
    level notify(notify_string);
  }
}

event1_followtankInternal(tank, pos, guy) {
  if(isDefined(tank.script_vehiclewalk)) {
    if(isDefined(guy) && isalive(guy)) {
      guy.disableArrivals = true;
      tank thread maps\_vehicle_aianim::WalkWithVehicle(guy, pos);
    }
  }
}

event1_artillary_fire() {
  tank2_first_attack = getvehiclenode("auto3590", "targetname");
  tank2_first_attack waittill("trigger");
  wait(0.1);
  event1_artillery_trig = getent("event1_artillery_left_trig", "targetname");
  event1_artillery_trig notify("trigger");
  level waittill("spawnvehiclegroup" + 0);
  wait(0.05);
  art_on_left = getent("event1_art_left", "targetname");
  art_on_left thread event1_arty_fire();
  self waittill("tank2_attacked");
  art_on_left setTurretTargetEnt(level.tank3);
  art_on_left threadevent1_left_art_stop_fire();
  art_on_left event1_artillery_random_target();
}

event1_artillery_random_target() {
  reverse_stop = getvehiclenode("auto4108", "targetname");
  reverse_stop waittill("trigger");
  targets = getEntArray("at_gun_targets", "targetname");
  while(!flag("left_tank_stop_fire")) {
    self setturrettargetent(targets[randomintrange(0, targets.size - 1)]);
    wait(randomintrange(0, 3));
  }
}

event1_arty_fire() {
  self endon("death");
  wait(0.05);
  self maps\_artillery::arty_fire_without_move();
  wait(0.2);
  self maps\_artillery::arty_fire();
}

event1_left_art_stop_fire() {
  for(i = 0; i < self.arty_crew.size; i++) {
    self.arty_crew[i] thread magic_bullet_shield();
  }
  stop_fire_trig = getent("fourth_color_trig", "targetname");
  stop_fire_trig waittill("trigger");
  self notify("shut down arty");
  level notify("close to arty 1");
  for(i = 0; i < self.arty_crew.size; i++) {
    if(isDefined(self.arty_crew[i]) && isalive(self.arty_crew[i])) {
      if(isDefined(self.arty_crew[i].magic_bullet_shield)) {
        self.arty_crew[i] thread stop_magic_bullet_shield();
      }
      self.arty_crew[i] animscripts\shared::placeWeaponOn(self.arty_crew[i].primaryweapon, "right");
      self.arty_crew[i].goalradius = 2000;
    }
  }
}

event1_right_art_stop_fire() {
  stop_fire_trig = getent("arty_stop_fire_right", "targetname");
  stop_fire_trig waittill("trigger");
  self notify("shut down arty");
  level notify("close to arty 2");
  for(i = 0; i < self.arty_crew.size; i++) {
    if(isDefined(self.arty_crew[i]) && isalive(self.arty_crew[i])) {
      self.arty_crew[i] animscripts\shared::placeWeaponOn(self.arty_crew[i].primaryweapon, "right");
      self.arty_crew[i].goalradius = 2000;
    }
  }
}

keep_flametank_alive() {
  self endon("death");
  while(!flag("flametank_destroy_trig")) {
    self.health = 9999999;
    wait(0.05);
  }
  self.health = 500;
}

keep_tank_alive() {
  self endon("death");
  while(!flag("tank3_reached")) {
    self.health = 9999999;
    wait(0.05);
  }
  self.health = 500;
}

event1_flame_tank_waiter() {
  self endon("flametank_dead");
  forward = anglesToForward(level.flametank.angles);
  level.fake_target = getent("flametank_reset_target", "targetname");
  level.fake_target.origin = forward + (-300, 0, 0);
  level.fake_target linkto(level.flametank);
  level.flametank setTurretTargetEnt(level.fake_target);
  self waittill("tank2_attacked");
  level.flametank setspeed(0, 6, 20);
  level.flametank joltbody(level.flametank.origin + (0, 0, 20), 0.5);
  level.flametank playSound("tank_gear_grind");
  wait(2);
  fire_shrecks_without_damage(level.flametank, false);
  level.flametank disconnectpaths();
  level.flametank setspeed(4, 5, 8);
  reverse_stop = getvehiclenode("auto4082", "targetname");
  reverse_stop waittill("trigger");
  level.flametank setspeed(0, 8, 8);
  event1_flametank_moveup_strat();
}

event1_set_up_grass_guy() {
  self endon("death");
  self allowedstances("prone");
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
  self.animname = "bunkers";
  self.surprisedplayer = false;
  self thread track_grass_guy_achievement();
  if(issubstr(self.script_string, "4")) {
    self thread grass_guy_shoots_trapped_guy();
  }
  grass_trig = getent(self.script_string + "_trig", "targetname");
  grass_trig waittill("trigger", triggerer);
  if((issubstr(self.script_string, "4") || issubstr(self.script_string, "21")) && isplayer(triggerer)) {
    if(isDefined(self.magic_bullet_shield)) {
      self thread stop_magic_bullet_shield();
    }
  }
  self.surprisedplayer = true;
  self allowedstances("stand");
  self.a.pose = "stand";
  self.activatecrosshair = true;
  self.drawoncompass = true;
  prone_anim = undefined;
  if(RandomInt(2)) {
    prone_anim = level.scr_anim["bunkers"]["prone_anim_fast"];
  } else {
    prone_anim = level.scr_anim["bunkers"]["prone_anim_fast_b"];
  }
  if(issubstr(self.script_string, "20") || issubstr(self.script_string, "21") || issubstr(self.script_string, "23")) {
    playFX(level._effect["grass_guy_water"], self.origin + (0, -20, 20));
    self setwetness(1.0, true);
  }
  level.animtimefudge = 0.05;
  self maps\_anim::play_anim_end_early(prone_anim, level.animtimefudge);
  self.pacifist = 0;
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.ignoresuppression = 0;
  self.grenadeawareness = 0.2;
  self.disableArrivals = false;
  self.disableExits = false;
}

track_grass_guy_achievement() {
  while(1) {
    self waittill("damage", damage_amount, attacker, direction_vec, point, type);
    if(self.health <= 0 && !self.surprisedplayer) {
      if(isDefined(attacker) && isplayer(attacker)) {
        attacker maps\_utility::giveachievement_wrapper("ANY_ACHIEVEMENT_GRASSJAP");
      }
    }
  }
}

event1_cleanup() {
  thread event1b_cleanup();
  thread event1_cleanup2();
  if(!NumRemoteClients()) {
    thread event1b_friendlies_cleaup1();
  }
  thread event1b_friendlies_hut_cleaup1();
  trig = getent("fifth_color_trig", "targetname");
  trig waittill("trigger");
  japs1 = get_ai_group_ai("event1_japs_flow_1");
  japs2 = get_ai_group_ai("event1_japs_flow_2");
  for(i = 0; i < japs1.size; i++) {
    if(isDefined(japs1[i])) {
      japs1[i] thread bloody_death();
    }
  }
  for(i = 0; i < japs2.size; i++) {
    if(isDefined(japs2[i])) {
      japs2[i] thread bloody_death();
    }
  }
  grass_guys = get_ai_group_ai("event1_grass_guys");
  for(i = 0; i < grass_guys.size; i++) {
    if(isDefined(grass_guys[i])) {
      grass_guys[i] thread bloody_death();
    }
  }
}

event1_cleanup2() {
  trig = getent("seventh_color_trig", "targetname");
  trig waittill("trigger");
  japs3 = get_ai_group_ai("event1_japs_flow_3");
  for(i = 0; i < japs3.size; i++) {
    if(isDefined(japs3[i])) {
      japs3[i] thread bloody_death();
    }
  }
}

event1b_cleanup() {
  trig = getent("last_cleanup", "script_noteworthy");
  trig waittill("trigger");
  japs1 = get_ai_group_ai("event1_japs_flow_4");
  for(i = 0; i < japs1.size; i++) {
    if(isDefined(japs1[i])) {
      japs1[i] thread bloody_death();
    }
  }
}

event1b_friendlies_cleaup1() {
  trig = getent("eleventh_color_trig", "targetname");
  trig waittill("trigger");
  riding_guys = getEntArray("passenger_tank3", "targetname");
  guy = getent("guys_following_tank3_1", "script_noteworthy");
  squad = [];
  squad[0] = riding_guys[0];
  squad[1] = riding_guys[1];
  squad[2] = guy;
  for(i = 0; i < squad.size - 1; i++) {
    if(isDefined(squad[i].magic_bullet_shield)) {
      squad[i] thread stop_magic_bullet_shield();
    }
  }
  for(i = 0; i < squad.size; i++) {
    wait(randomintrange(2, 5));
    squad[i] thread bloody_death();
  }
}

event1b_friendlies_cleaup1_co_op() {
  level waittill("tank2_attacked");
  if(!NumRemoteClients()) {
    return;
  }
  wait(randomintrange(5, 15));
  riding_guys = getEntArray("passenger_tank3", "targetname");
  guy = getent("guys_following_tank3_1", "script_noteworthy");
  squad = [];
  squad[0] = riding_guys[0];
  squad[1] = riding_guys[1];
  squad[2] = guy;
  for(i = 0; i < squad.size - 1; i++) {
    if(isDefined(squad[i].magic_bullet_shield)) {
      squad[i] thread stop_magic_bullet_shield();
    }
  }
  for(i = 0; i < squad.size; i++) {
    wait(randomintrange(5, 10));
    squad[i] thread bloody_death();
  }
}

event1b_friendlies_hut_cleaup1() {
  trig = getent("event1_objective_clear_trig2", "targetname");
  trig waittill("trigger");
  squad = getEntArray("right_side_friendlies", "script_noteworthy");
  for(i = 0; i < squad.size; i++) {
    wait(randomintrange(0, 7));
    if(isDefined(squad[i]) && isalive(squad[i])) {
      squad[i] thread bloody_death();
    }
  }
}

event1_ambient_planes_setup() {
  trig = getent("planes_point1", "targetname");
  trig waittill("trigger");
  thread planes_flying_strat("event1_ambient_planes1");
  trig = getent("planes_point2", "targetname");
  trig waittill("trigger");
  thread planes_flying_strat("event1_ambient_planes2");
}

planes_flying_strat(start_struct_name) {
  start_struct = getstructarray(start_struct_name, "targetname");
  end_struct = getstructarray(start_struct_name, "targetname");
  thread planes_move(start_struct, end_struct);
}

sound_planes(wait_time) {
  self playSound("squadron_by");
}

planes_move(start_struct, end_struct) {
  for(i = 0; i < start_struct.size; i++) {
    plane = spawn("script_model", start_struct[i].origin);
    plane.angles = start_struct[i].angles;
    plane setModel("vehicle_usa_aircraft_f4ucorsair");
    end_struct = getstruct("end_" + start_struct[i].script_int, "script_noteworthy");
    destination = end_struct.origin;
    plane thread flyto(destination, randomintrange(90, 120));
    if(i == 3) {
      plane thread sound_planes();
    }
  }
}

flyto(dest, mph) {
  dist = distance(self.origin, dest);
  distinmiles = dist / 63360;
  milespersec = mph / 3600;
  time = distinmiles / milespersec;
  self moveto(dest, time);
}

event1a_skipto_setup() {
  level thread maps\_debug::set_event_printname("Artillery Kill A", false);
  level.event1a = true;
  level.startskip = "1a";
  players_ignoreall(level.allies, 0);
  wait_for_first_player();
  players = get_players();
  for(i = 0; i < players.size; i++) {
    starts = getStructArray("event1a_start", "targetname");
    start = starts[randomint(starts.size)];
    players[i] setOrigin(start.origin);
    players[i] setplayerangles(start.angles);
  }
  level thread event1_right_artsetup();
  level.heroes[0] forceteleport((48036.4, 2199.24, 187.443), (0, 100.95, 0));
  level.heroes[1] forceteleport((47635.6, 2450.34, 198.352), (0, 356.25, 0));
  for(i = 0; i < level.allies.size; i++) {
    if(isalive(level.allies[i]) && level.allies[i].script_noteworthy != "sarge" && level.allies[i].script_noteworthy != "walker") {
      level.allies[i] thread bloody_death();
    }
  }
}

magic_bullet_to_keep_guys_alive(the_squad) {
  for(i = 0; i < the_squad.size; i++) {
    the_squad[i] thread magic_bullet_shield();
  }
}
stop_magic_bullet(the_squad) {
  for(i = 0; i < the_squad.size; i++) {
    if(isDefined(the_squad[i]) && isalive(the_squad[i]) && isDefined(the_squad[i].magic_bullet_shield)) {
      the_squad[i] stop_magic_bullet_shield();
    }
  }
}

set_objectives(objectiveId) {
  if(objectiveId == 0) {
    objective_add(0, "current");
    objective_string(0, &"PEL1B_OBJECTIVE_MOVE_UP");
  }
  if(objectiveId == 1) {
    level.obj_arty = 2;
    level.max_obj_arty = 2;
    objective_add(1, "current");
    objective_additionalposition(1, 1, (48004.2, 2406, 174.6));
    objective_additionalposition(1, 2, (47438.2, 5726.9, 60.5));
    objective_string(1, &"PEL1B_OBJECTIVE_ARTILLERY", level.obj_arty);
  }
  if(objectiveId == 2) {
    flag_set("event1_objectives_done");
    objective_state(1, "done");
    objective_add(2, "current");
    objective_additionalposition(2, 1, (46093, 6259, 0));
    objective_string(2, &"PEL1B_OBJECTIVE_FOLLOW_SQUAD");
    objective_state(2, "done");
    thread battlechatter_off("allies");
    thread battlechatter_off("axis");
    level thread maps\pel1b_event2::event2_main_function();
  }
}

event1_objective_blocker() {
  blocker = getent("event1_objective_clip", "targetname");
  blocker_trig = getent("event1_objective_clip_trig", "targetname");
  players = get_players();
  while(!flag("event1_objectives_done")) {
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(isDefined(player)) {
        if(isalive(player) && !flag("event1_objectives_done")) {
          if(player IsTouching(blocker_trig)) {
            if(!isDefined(player.Warning_hud_created)) {
              player.Warning_hud = newClientHudElem(player);
              player.Warning_hud.alignX = "center";
              player.Warning_hud.x = 450;
              player.Warning_hud.y = 300;
              player.Warning_hud.alignX = "right";
              player.Warning_hud.alignY = "bottom";
              player.Warning_hud.fontScale = 1.5;
              player.Warning_hud.alpha = 1.0;
              player.Warning_hud.sort = 20;
              player.Warning_hud.font = "default";
              player.Warning_hud FadeOverTime(1);
              player.Warning_hud_created = 1;
            }
            player.Warning_hud SetText(&"PEL1B_OBJECTIVE_WARNING");
          } else if(isDefined(player.Warning_hud_created)) {
            player.Warning_hud SetText("");
          }
        }
      }
    }
    wait(0.1);
  }
  blocker = getent("event1_objective_clip", "targetname");
  blocker delete();
  blocker_trig delete();
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(isDefined(player)) {
      if(isalive(player) && isDefined(player.Warning_hud_created)) {
        player.Warning_hud destroy();
      }
    }
  }
}

fire_shrecks(spwn, targt, time) {
  shreck = spawn("script_model", spwn.origin);
  shreck.angles = targt.angles;
  shreck setModel("weapon_ger_panzershreck_rocket");
  wait 0.1;
  shreck moveTo(targt.origin, time);
  playFXOnTag(level._effect["rocket_trail"], shreck, "tag_origin");
  shreck playLoopSound("rpg_rocket");
  wait time;
  playFX(level._effect["rocket_explode"], shreck.origin);
  earthquake(0.3, 1.5, shreck.origin, 512);
  shreck stoploopsound();
  shreck hide();
  wait(10);
  shreck delete();
}

shrecksmoke(time) {
  fxcounter = 0;
  while(time > 0) {
    time = time - 0.1;
    playFX(level._effect["rocket_trail"], self.origin);
    wait 0.1;
  }
}

fire_shrecks_with_damage(tank, damage) {
  radiusdamage(tank.origin + (0, 0, 200), 300, damage, 35);
  earthquake(0.3, 1.5, tank.origin, 512);
}

fire_shrecks_without_damage(tank, switchmodel) {
  shreck = spawn("script_model", tank.origin);
  shreck.angles = tank.angles;
  if(switchmodel) {
    shreck setModel("weapon_ger_panzershreck_rocket");
  }
  playFX(level._effect["rocket_explode"], shreck.origin);
  shreck playSound("explo_metal_rand");
}

tank_loopfire(tank, times) {
  self endon("death");
  for(i = 0; i < times; i++) {
    if(tank.health > 0) {
      tank fireweapon();
      wait(randomintrange(2, 5));
    }
  }
}

player_shellshock() {
  tank2 = getent("tank2", "targetname");
  tank3 = getent("tank3", "targetname");
  players = get_players();
  for(i = 0; i < players.size; i++) {
    distance1 = Distance(tank2.origin, players[i].origin);
    distance2 = Distance(tank3.origin, players[i].origin);
    if(distance1 < 200.0 || distance2 < 200.0) {
      players[i] freezecontrols(true);
      players[i] shellshock("teargas", 10);
      wait 1;
      players[i] freezecontrols(false);
    }
  }
}

players_ignoreall(squad, ignoreflag) {
  for(i = 0; i < squad.size; i++) {
    if(isalive(squad[i])) {
      squad[i].ignoreall = ignoreflag;
    }
  }
}

reset_turret_target() {
  level.flametank setTurretTargetEnt(level.fake_target);
}

bloody_death() {
  self endon("death");
  if(!isalive(self)) {
    return;
  }
  self.bloody_death = true;
  wait(randomfloatrange(1, 3));
  tags = [];
  tags[0] = "j_hip_le";
  tags[1] = "j_hip_ri";
  tags[2] = "j_head";
  tags[3] = "j_spine4";
  tags[4] = "j_elbow_le";
  tags[5] = "j_elbow_ri";
  tags[6] = "j_clavicle_le";
  tags[7] = "j_clavicle_ri";
  for(i = 0; i < 2 + randomint(3); i++) {
    random = randomintrange(0, tags.size);
    if(is_mature()) {
      playFXOnTag(level.fleshhit, self, tags[random]);
    }
    wait(randomfloat(0.2));
  }
  self dodamage(self.health + 50, self.origin);
}

satchel_setup(charge_trig, target_ent, flag_art) {
  wait(2);
  charge = getent(charge_trig.target, "targetname");
  charge.origin = self LocalToWorldCoords((-34, -15, 20));
  charge.angles = self.angles;
  ASSERTEX(isDefined(charge), "Charge trigger should be pointing to a sachel charge");
  ASSERTEX(isDefined(charge.script_noteworthy), "Charge should have a swap model specified as script_noteworthy");
  charge_trig waittill("trigger");
  iprintlnbold("Charge planted");
  charge setModel(charge.script_noteworthy);
  wait(5);
  charge delete();
  charge_trig delete();
  fire_shrecks_with_damage(target_ent, target_ent.health + 200);
  flag_set(flag_art);
}

setup_spawn_functions() {
  grass_guy = getEntArray("grass_guy", "script_noteworthy");
  array_thread(grass_guy, ::add_spawn_function, ::event1_set_up_grass_guy);
  suicide_guy3 = getEntArray("suicide_guy3", "script_noteworthy");
  array_thread(suicide_guy3, ::add_spawn_function, ::setup_suicide_guy);
  suicide_guy1 = getEntArray("suicide_guy1", "script_noteworthy");
  array_thread(suicide_guy1, ::add_spawn_function, ::setup_suicide_guy);
  japs_on_hut = getEntArray("event1_japs_on_hut", "script_noteworthy");
  array_thread(japs_on_hut, ::add_spawn_function, ::event1_japs_on_hut_strat);
  trap_guy = getEntArray("event1_right_side_trap_guy", "targetname");
  array_thread(trap_guy, ::add_spawn_function, ::setup_right_side_trap_guy);
}

event1_objective_thread_left_art() {
  trig = getent("arty_stop_fire_left", "targetname");
  trig waittill("trigger");
  trench_1 = getent("event1_objective_clear_trig1", "targetname");
  while(1) {
    cleared = true;
    axis_guys = GetAiArray("axis");
    for(i = 0; i < axis_guys.size; i++) {
      if(axis_guys[i] istouching(trench_1)) {
        cleared = false;
      }
    }
    if(cleared) {
      break;
    }
    wait(1);
  }
  level.obj_arty--;
  Objective_String(1, &"PEL1B_OBJECTIVE_ARTILLERY", level.obj_arty);
  Objective_AdditionalPosition(1, 1, (0, 0, 0));
  level notify("event1_objective_left_art_done");
  autosave_by_name("after_left_artillery");
  wait(2);
}

event1_objective_thread_right_art() {
  trig = getent("eleventh_color_trig", "targetname");
  trig waittill("trigger");
  trench_2 = getent("event1_objective_clear_trig2", "targetname");
  while(1) {
    cleared = true;
    axis_guys = GetAiArray("axis");
    for(i = 0; i < axis_guys.size; i++) {
      if(axis_guys[i] istouching(trench_2)) {
        cleared = false;
      }
    }
    if(cleared) {
      break;
    }
    wait(1);
  }
  level.obj_arty--;
  Objective_String(1, &"PEL1B_OBJECTIVE_ARTILLERY", level.obj_arty);
  Objective_AdditionalPosition(1, 2, (0, 0, 0));
  level notify("event1_objective_right_art_done");
  autosave_by_name("after_right_artillery");
}

event1_objective_thread_follow_squad() {
  level waittill_multiple("event1_objective_left_art_done", "event1_objective_right_art_done");
  level thread set_objectives(2);
  color_trig = getent("event2_color_trig_change", "targetname");
  color_trig notify("trigger");
}

remove_gun(guy) {
  if(!isDefined(guy)) {
    self gun_remove();
  } else {
    guy gun_remove();
  }
}

recall_gun(guy) {
  guy gun_recall();
}

guy_make_killable() {
  self.allowdeath = true;
}

event1_held_guy() {
  if(true) {
    return;
  }
  if(!is_mature()) {
    return;
  }
  level thread swap_flag();
  level endon("stop_held_guy_vignette");
  flag_wait("event1_held_guy");
  spawners = getEntArray("event1_held_down_spawners", "targetname");
  for(i = 0; i < spawners.size; i++) {
    spawners[i].animname = spawners[i].script_string;
    spawners[i] add_spawn_function(::guy_make_killable);
    if(spawners[i].animname == "ally_held_down") {
      spawners[i] add_spawn_function(::kill_ally);
      spawners[i] add_spawn_function(::remove_gun);
      spawners[i] add_spawn_function(::ally_screaming);
    }
  }
  node = GetNode("event1_held_down", "targetname");
  spawn_and_play(spawners, "vignette", node);
}

swap_flag() {
  new_flag = getent("new_flag", "targetname");
  new_flag hide();
}

play_rumble_effect() {
  players = get_players();
  for(p = 0; p < players.size; p++) {
    players[p] PlayRumbleOnEntity("artillery_rumble");
  }
  wait(2);
  for(p = 0; p < players.size; p++) {
    players[p] PlayRumbleOnEntity("artillery_rumble");
  }
}

kill_ally(notify_str) {
  if(!isDefined(notify_str)) {
    notify_str = "single anim";
  }
  self waittill(notify_str);
  self.skipDeathAnim = true;
  self setCanDamage(true);
  self dodamage(self.health + 200, self.origin);
}

spawn_and_play(spawners, anime, node, anim_reach, death_anim) {
  guys = spawn_guys(spawners);
  if(isDefined(anim_reach) && anim_reach) {
    level anim_reach(guys, anime, undefined, node);
  }
  level notify("execution_is_ready");
  level thread anim_single(guys, anime, undefined, node);
}

spawn_guys(spawners, target_name, ok_to_spawn) {
  guys = [];
  for(i = 0; i < spawners.size; i++) {
    guy = spawn_guy(spawners[i], target_name, ok_to_spawn);
    if(isDefined(guy)) {
      guys[guys.size] = guy;
    }
  }
  if(!isDefined(ok_to_spawn) || !ok_to_spawn) {
    return guys;
  }
}

spawn_guy(spawner, target_name, ok_to_spawn) {
  if(isDefined(ok_to_spawn) && ok_to_spawn) {
    while(!OkTospawn()) {
      wait(0.1);
    }
  }
  if(isDefined(spawner.script_forcespawn) && spawner.script_forcespawn) {
    guy = spawner Stalingradspawn();
  } else {
    guy = spawner Dospawn();
  }
  if(!spawn_failed(guy)) {
    if(isDefined(target_name)) {
      guy.targetname = target_name;
    }
    return guy;
  }
  return undefined;
}

event1b_skipto_setup() {
  level thread maps\_debug::set_event_printname("Flame Death", false);
  level.event1b = true;
  level.startskip = "1b";
  wait_for_first_player();
  players = get_players();
  for(i = 0; i < players.size; i++) {
    starts = getStructArray("event1b_start", "targetname");
    start = starts[randomint(starts.size)];
    players[i] setOrigin(start.origin);
    players[i] setplayerangles(start.angles);
  }
  for(i = 0; i < level.allies.size; i++) {
    if(isalive(level.allies[i]) && level.allies[i].script_noteworthy != "sarge" && level.allies[i].script_noteworthy != "walker") {
      level.allies[i] thread bloody_death();
    }
  }
  tank1_trig = getent("tank1start", "targetname");
  tank1_trig notify("trigger");
  wait(0.05);
  level.flametank = getent("flametank", "targetname");
  level.flametank setspeed(30, 5, 8);
  node = getvehiclenode("event2_tank_start", "targetname");
  node waittill("trigger");
  level.flametank setspeed(0, 6, 35);
  hero_start_structs = getstructarray("ev2_temp_teleport_heroes", "targetname");
  level.heroes[0] forceteleport(hero_start_structs[0].origin, hero_start_structs[0].angles);
  level.heroes[1] forceteleport(hero_start_structs[1].origin, hero_start_structs[1].angles);
  level.heroes[0].ignoreall = 0;
  level.heroes[1].ignoreall = 0;
  flag_set("flametank_in_second_area");
  level thread maps\pel1b_event2::event2_main_function();
}

outro_skipto_setup() {
  spawner = getent("ev2_radio_guy", "script_noteworthy");
  level.radio_guy = spawner stalingradspawn();
  player = get_players()[0];
  wait(1);
  level.radio_guy thread magic_bullet_shield();
  hero_start_structs = getstructarray("ev2_outro_teleport_heroes", "targetname");
  level.heroes[0] forceteleport(hero_start_structs[0].origin, hero_start_structs[0].angles);
  level.heroes[1] forceteleport(hero_start_structs[1].origin, hero_start_structs[1].angles);
  level.radio_guy forceteleport(hero_start_structs[2].origin, hero_start_structs[2].angles);
  player = get_players()[0];
  starts = getStructArray("ev2_outro_player", "targetname");
  player setOrigin(starts[0].origin);
  player setplayerangles(starts[0].angles);
  vehicle_trig = getent("ev2_spawn_art", "targetname");
  vehicle_trig notify("trigger");
  trig = getent("ev2_outro_player_trig_skipto", "targetname");
  trig waittill("trigger");
  guys = [];
  guys[0] = level.walker;
  guys[1] = level.sarge;
  guys[2] = level.radio_guy;
  guys[0].animname = "walker";
  guys[1].animname = "sarge";
  guys[2].animname = "radio_guy";
  guys[0] disable_ai_color();
  guys[1] disable_ai_color();
  guys[2] disable_ai_color();
  guys[0].ignoreall = true;
  guys[1].ignoreall = true;
  guys[2].ignoreall = true;
  anim_struct = getstruct("outro_anim", "targetname");
  goal_node_roebuck = getnode("roebuck_outro", "targetname");
  goal_node_polonsky = getnode("polonsky_outro", "targetname");
  goal_node_radio = getnode("radio_outro", "targetname");
  guys[0] thread pacing_vignette_in_place_think(anim_struct, "roebuck_reached_outro", "outro_in", "outro_loop");
  guys[1] thread pacing_vignette_in_place_think(anim_struct, "polonsky_reached_outro", "outro_in", "outro_loop");
  guys[2] thread pacing_vignette_in_place_think(anim_struct, "radio_guy_reached_outro", "outro_in", "outro_loop");
  flag_wait_all("roebuck_reached_outro", "polonsky_reached_outro", "radio_guy_reached_outro");
  players = get_players();
  player_close = false;
  while(!player_close) {
    for(i = 0; i < players.size; i++) {
      if(distancesquared(players[i].origin, guys[0].origin) < 400 * 400) {
        player_close = true;
      }
    }
    wait(0.05);
  }
  guys[2] notify("radio_anim_starting");
  anim_single(guys, "outro", undefined, undefined, anim_struct);
  wait(0.5);
  iprintln("roebuck --------> " + guys[0].angles);
  iprintln("Polonsky --------> " + guys[1].angles);
}

pacing_vignette_in_place_think(goal_node, flag_name, anim_in, anim_looping) {
  startorg = getstartOrigin(goal_node.origin, goal_node.angles, level.scr_anim[self.animname][anim_in]);
  startang = getstartAngles(goal_node.origin, goal_node.angles, level.scr_anim[self.animname][anim_in]);
  self.goalradius = 32;
  self SetGoalPos(startorg, startang);
  self disable_ai_color();
  self waittill("goal");
  self waittill_notify_or_timeout("orientdone", 1);
  wait(0.75);
  anim_single_solo(self, anim_in, undefined, undefined, goal_node);
  thread anim_loop_solo(self, anim_looping, undefined, undefined, goal_node);
  if(self.animname == "radio_guy") {
    self thread maps\pel1b_event2::outro_animate_radio_model(goal_node);
  }
  flag_set(flag_name);
}

#using_animtree("generic_human");

event1b_setup() {}
event1b_tank1_movesup() {
  self setspeed(7, 6, 8);
  self.killingsuicideattackers = false;
  if(level.startskip != "1b") {
    firenode = getvehiclenode("auto3691", "targetname");
    firenode waittill("trigger");
    self fireweapon();
    stopfirenode = getvehiclenode("auto3712", "targetname");
    stopfirenode waittill("trigger");
    self stopfireweapon();
    firenode = getvehiclenode("auto3697", "targetname");
    firenode waittill("trigger");
    self fireweapon();
    firepoint1 = getent("suicide_point3", "targetname");
    self setTurretTargetEnt(firepoint1);
    self setspeed(0, 6, 8);
    self waittill("suicide_guy3_dead");
    self setspeed(5, 6, 8);
    self stopfireweapon();
    self clearturrettarget();
  }
  wait_for_players_here = getvehiclenode("auto3707", "targetname");
  wait_for_players_here waittill("trigger");
  self setspeed(0, 6, 8);
  player_near_tank = getent("tank_player_mover_trig", "targetname");
  player_near_tank waittill("trigger");
  self setspeed(5, 6, 8);
  firenode = [];
  firenode[0] = getvehiclenode("auto3713", "targetname");
  firenode[1] = getvehiclenode("auto3716", "targetname");
  firenode[2] = getvehiclenode("auto3731", "targetname");
  firenode[3] = getvehiclenode("auto3720", "targetname");
  firenode[4] = getvehiclenode("auto3723", "targetname");
  firenode[0] waittill("trigger");
  self fireweapon();
  points = getEntArray("left1", "script_noteworthy");
  self thread event1b_randomfirepoint(points, "left1");
  firenode[1] waittill("trigger");
  self notify("left1");
  points = getEntArray("right1", "script_noteworthy");
  self thread event1b_randomfirepoint(points, "right1");
  firenode[2] waittill("trigger");
  self notify("right1");
  points1 = getEntArray("left2", "script_noteworthy");
  self thread event1b_randomfirepoint(points1, "left2");
  firenode[3] waittill("trigger");
  self notify("left2");
  points2 = getEntArray("right2", "script_noteworthy");
  self thread event1b_randomfirepoint(points2, "right2");
  firenode[4] waittill("trigger");
  self notify("right2");
  points3 = getEntArray("left3", "script_noteworthy");
  self thread event1b_randomfirepoint(points3, "left3");
  tank1attacknode = getvehiclenode("auto3724", "targetname");
  tank1attacknode waittill("trigger");
  fire_shrecks_with_damage(self, self.health + 200);
}

event1b_randomfirepoint(points, endonwhat) {
  self endon(endonwhat);
  self endon("death");
  self clearturrettarget();
  while(1) {
    ASSERT(points.size > 1, " There should be atleast one point to point to.");
    which = randomintrange(0, points.size - 1);
    if(isDefined(points[which])) {
      if(self.health > 0 && self.killingsuicideattackers == false) {
        self setTurretTargetEnt(points[which]);
      } else {}
    }
    wait(1);
  }
}

event1b_fire_japs_up_hill() {
  japs = getEntArray("event1b_japs", "targetname");
  for(i = 0; i < 10; i++) {
    if(isDefined(japs)) {
      which = randomintrange(0, japs.size - 1);
      self setTurretTargetEnt(japs[which]);
    }
    wait(1);
  }
}

setup_suicide_guy() {
  self.ignoreall = 1;
  self.pacifist = 1;
  self.disableArrivals = true;
  self.animname = "animsingle1";
  self.a.combatrunanim = % ai_bonzai_sprint_a;
  self.goalradius = 32;
  goalnode = getent(self.script_string, "targetname");
  self setgoalentity(goalnode);
  level.flametank.killingsuicideattackers = true;
  wait(1);
  level.flametank setTurretTargetEnt(self);
  self waittill("death");
  level.flametank notify(self.script_noteworthy + "_dead");
  level.flametank.killingsuicideattackers = false;
  level.flametank clearturrettarget();
}

setup_sniper_guy() {
  level.flametank.killingsuicideattackers = true;
  wait(1);
  level.flametank setTurretTargetEnt(self);
  self waittill("death");
  level.flametank notify("sniper_dead");
  level.flametank.killingsuicideattackers = false;
  level.flametank clearturrettarget();
}

event1b_tree_sniper() {
  tree = getent("test_tree", "script_noteworthy");
  tree thread flame_notify();
  model_tag_origin = spawn("script_model", tree.origin);
  model_tag_origin setModel("tag_origin");
  model_tag_origin linkto(tree, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["sniper_leaf_loop"], model_tag_origin, "TAG_ORIGIN");
  node = getvehiclenode("auto3730", "targetname");
  node waittill("trigger");
  model_tag_origin unlink();
  model_tag_origin delete();
  wait(0.05);
  orig = getent("test_orig", "targetname");
  playFX(level._effect["sniper_leaf_canned"], tree.origin);
}

flame_notify() {
  node = getvehiclenode("auto3730", "targetname");
  node waittill("trigger");
  wait(0.05);
  guy = get_ai_group_ai("tree_guy")[0];
  while(1) {
    self waittill("broken", broken_notify, attacker);
    if(broken_notify == "hideout_fronds_dmg0") {
      guy animscripts\death::flame_death_fx();
      guy setCanDamage(true);
      guy notify("fake tree death", attacker);
      break;
    }
  }
}

get_sorted_players() {
  players = get_players();
  for(i = 0; i < players.size; i++) {
    for(j = i; j < players.size; j++) {
      if(players[j] GetEntityNumber() > players[i] GetEntityNumber()) {
        temp = players[i];
        players[i] = players[j];
        players[j] = temp;
      }
    }
  }
  return players;
}

get_sorted_starts(start_name) {
  starts = getstructarray("player_starts", "targetname");
  player_starts = [];
  for(i = 0; i < starts.size; i++) {
    if(isDefined(starts[i].script_int)) {
      player_starts[player_starts.size] = starts[i];
    }
  }
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

say_dialogue(theLine) {
  if(isDefined(self) && isalive(self)) {
    self.og_animname = self.animname;
    self.animname = "generic";
    self anim_single_solo(self, theLine);
    self.animname = self.og_animname;
  }
}

in_game_dialogue_setup() {
  wait(1.6);
  roebuck = level.walker;
  polonsky = level.sarge;
  polonsky thread tank_hit_incoming();
  level thread tank2_is_attacked(polonsky, roebuck);
  roebuck say_dialogue("intro1");
  roebuck say_dialogue("intro2");
  roebuck say_dialogue("intro3");
  wait(0.5);
  polonsky say_dialogue("intro4");
  roebuck say_dialogue("intro5");
  wait(1);
  roebuck say_dialogue("intro6");
  wait(0.5);
  roebuck say_dialogue("intro7");
  roebuck say_dialogue("intro8");
  roebuck say_dialogue("intro9");
  roebuck say_dialogue("intro10");
  roebuck say_dialogue("intro11");
  roebuck say_dialogue("intro12");
  thread riverbed_dialogue(roebuck);
  thread triple25_instruct(roebuck);
  thread first_objective_done(roebuck);
  thread close_to_art(roebuck);
  thread event2_start(roebuck);
}

tank2_is_attacked(polonsky, roebuck) {
  level waittill("tank2_attacked");
  wait(0.5);
  roebuck say_dialogue("intro14");
  wait(1);
  roebuck say_dialogue("intro15");
  wait(1);
  polonsky say_dialogue("event1");
  polonsky say_dialogue("event2");
  wait(3);
  polonsky say_dialogue("event3");
  wait(0.5);
  roebuck say_dialogue("event4");
}

tank_hit_incoming() {
  level waittill("incoming");
  wait(0.3);
  self say_dialogue("intro13");
}

riverbed_dialogue(roebuck) {
  trig = getent("river_trig_1", "script_noteworthy");
  trig waittill("trigger");
  roebuck say_dialogue("event5");
  roebuck say_dialogue("event6");
}

triple25_instruct(roebuck) {
  trig = getent("sixth_color_trig", "targetname");
  trig waittill("trigger");
  roebuck say_dialogue("event7");
  wait(1);
  roebuck say_dialogue("event8");
  wait(0.2);
  roebuck say_dialogue("event9");
}

first_objective_done(roebuck) {
  trig = getent("seventh_color_trig", "targetname");
  trig waittill("trigger");
  wait(2);
  roebuck say_dialogue("event10");
  wait(2);
  roebuck say_dialogue("event11");
  roebuck say_dialogue("event12");
}

close_to_art(roebuck) {
  trig = getent("nineth_color_trig", "targetname");
  trig waittill("trigger");
  wait(2);
  roebuck say_dialogue("event13");
}

ally_screaming() {
  wait(0.5);
  self say_dialogue("event14");
  self say_dialogue("event15");
  self say_dialogue("event16");
}

event2_start(roebuck) {}

log_trap_thread() {
  log = getent("log", "targetname");
  log_trigger = getent("log_trap", "targetname");
  log physicsLaunch(log.origin, (0, 0, 0));
  log_trigger waittill("trigger", triggerer);
  triggerer.a.gib_ref = "right_arm";
  ropeid = getrope("break_log_rope");
  breakrope(ropeid, 0);
  wait 1.6;
}

snare_trap_thread() {
  wait(1);
  trigger = getent("trap_barrel_trig", "targetname");
  start = trigger.origin + (0, 0, -20);
  end = start + (-15, 10, 500);
  offset = (0, -30, 0);
  ropeid = createrope(start + offset, end + offset, 550);
  firepoint = getstruct("trap_rope_struct", "targetname");
  firepoint.origin = trigger.origin + (0, 0, 320);
  trigger waittill("trigger", triggerer);
  wait(0.2);
  if(!isplayer(triggerer) && (triggerer.team != "axis") && (triggerer.script_noteworthy == "guys_following_tank2_1")) {
    flag_set("guy_trapped");
    if(isDefined(triggerer.magic_bullet_shield)) {
      triggerer thread stop_magic_bullet_shield();
    }
    triggerer.NoFriendlyfire = true;
    playsoundatposition("trap_vx", triggerer.origin);
    triggerer thread bloody_death();
    triggerer thread blood_drop_effect();
    deleterope(ropeid);
    createrope(end, (0, 0, 0), 320, triggerer, "j_ankle_ri");
    wait(0.05);
    triggerer startragdoll();
    wait(0.1);
    triggerer animscripts\death::helmetPop();
  }
}

snare_trap_handle_triggerer() {
  self.goalradius = 20;
  self setgoalnode(getnode("trap_node1", "targetname"));
  if(!flag("trap_guy_area1")) {
    flag_wait("trap_guy_area1");
  }
  self setgoalnode(getnode("trap_node", "targetname"));
}

set_ignore_all() {
  self waittill("goal");
  self.ignoreme = true;
  self.ignorall = true;
}

grass_guy_shoots_trapped_guy() {
  self endon("death");
  flag_wait("guy_trapped");
  self.ignoreme = true;
  self.exposedSetIgnore = true;
  firepoint = getstruct("trap_rope_struct", "targetname");
  fireent = spawn("script_origin", firepoint.origin + (0, 0, -100));
  fireent.health = 1000000;
  self SetEntityTarget(fireent);
  if(isDefined(self.magic_bullet_shield)) {
    self thread stop_magic_bullet_shield();
  }
  wait(randomintrange(4, 7));
  self.ignoreme = false;
  if(isDefined(self) && isalive(self)) {
    self ClearEntityTarget();
  }
}

setup_right_side_trap_guy() {
  self thread print_trap_guy_overhead();
  self thread magic_bullet_shield();
  self thread right_side_grass_guy_trap_think();
  self setgoalnode(getnode("right_trap_node_1", "targetname"));
  self thread set_ignore_all();
  trig = getent("check_point_with_trap", "targetname");
  trig waittill("trigger");
  self setgoalnode(getnode("right_trap_node_2", "targetname"));
}

right_side_grass_guy_trap_think() {
  trigger = getent("grass_guy21_trig", "targetname");
  start = trigger.origin + (0, 0, -20);
  end = start + (-15, 10, 800);
  offset = (0, -30, 0);
  ropeid = createrope(start + offset, end + offset, 500);
  firepoint = getstruct("trap_rope_struct2", "targetname");
  firepoint.origin = trigger.origin + (0, 0, 500);
  trigger waittill("trigger", triggerer);
  wait(0.2);
  if(!isplayer(triggerer) && (triggerer.team != "axis") && (triggerer.script_noteworthy == "right_side_trap_guy")) {
    flag_set("guy_trapped2");
    if(isDefined(self.magic_bullet_shield)) {
      triggerer thread stop_magic_bullet_shield();
    }
    triggerer.NoFriendlyfire = true;
    playsoundatposition("trap_vx", triggerer.origin);
    triggerer thread blood_drop_effect();
    triggerer thread bloody_death();
    deleterope(ropeid);
    createrope(end, (0, 0, 0), 550, triggerer, "j_ankle_le");
    wait(0.05);
    triggerer startragdoll();
    wait(0.1);
    triggerer animscripts\death::helmetPop();
  } else if(!isplayer(triggerer) && (triggerer.script_noteworthy != "right_side_trap_guy")) {}
}

grass_guy_shoots_trapped_guy2() {
  self endon("death");
  flag_wait("guy_trapped2");
  self.exposedSetIgnore = true;
  firepoint = getstruct("trap_rope_struct2", "targetname");
  fireent = spawn("script_origin", firepoint.origin + (0, 0, -100));
  fireent.health = 1000000;
  self SetEntityTarget(fireent);
  if(isDefined(self.magic_bullet_shield)) {
    self thread stop_magic_bullet_shield();
  }
  wait(randomintrange(5, 8));
  if(isDefined(self) && isalive(self)) {
    self ClearEntityTarget();
  }
}

blood_drop_effect() {
  self endon("death");
  if(!is_mature()) {
    return;
  }
  for(i = 0; i < 5; i++) {
    tags = "j_head";
    playFXOnTag(level._effect["blood_drop"], self, tags);
    wait(randomfloat(1, 2));
  }
}

print_trap_guy_overhead() {
  self endon("death");
  for(;;) {
    print3d(self.origin + (0, 0, 80), "I am going to get trapped");
    wait(0.5);
  }
}

pel1b_custom_introscreen(string1, string2, string3, string4, string5) {
  flag_wait("all_players_connected");
  level.introblack = NewHudElem();
  level.introblack.x = 0;
  level.introblack.y = 0;
  level.introblack.horzAlign = "fullscreen";
  level.introblack.vertAlign = "fullscreen";
  level.introblack.foreground = false;
  level.introblack.sort = 50;
  level.introblack SetShader("black", 640, 480);
  level._introscreen = false;
  wait(4);
  level.introblack FadeOverTime(3);
  level.introblack.alpha = 0;
  wait(0.05);
  level.introstring = [];
  if(isDefined(string1)) {
    maps\_introscreen::introscreen_create_line(string1);
  }
  wait(2);
  if(isDefined(string2)) {
    maps\_introscreen::introscreen_create_line(string2);
  }
  if(isDefined(string3)) {
    maps\_introscreen::introscreen_create_line(string3);
  }
  wait(1);
  if(isDefined(string4)) {
    maps\_introscreen::introscreen_create_line(string4);
  }
  wait(1);
  if(isDefined(string5)) {
    maps\_introscreen::introscreen_create_line(string5);
  }
  level notify("finished final intro screen fadein");
  wait(1);
  maps\_introscreen::introscreen_fadeOutText();
  flag_set("introscreen_complete");
}