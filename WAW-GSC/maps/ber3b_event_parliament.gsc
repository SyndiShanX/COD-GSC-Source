/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber3b_event_parliament.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\ber3b;
#include maps\ber3b_anim;
#include maps\ber3_util;
#include maps\_music;
#using_animtree("generic_human");

event_parliament_start() {
  objectives_skip(1);
  warp_players_underworld();
  warp_friendlies("struct_parliament_start_friends", "targetname");
  warp_players("struct_parliament_start", "targetname");
  set_color_chain("trig_script_color_allies_b7");
  level thread event_parliament_setup();
}

event_parliament_doors_start() {
  objectives_skip(1);
  warp_players_underworld();
  warp_friendlies("struct_parliament_doors_start_friends", "targetname");
  warp_players("struct_parliament_doors_start", "targetname");
  set_color_chain("trig_script_color_allies_b27");
  level thread event_parliament_setup();
}

event_parliament_setup(skipto) {
  if(!isDefined(skipto)) {
    skipto = false;
  }
  if(level.clientscripts) {
    maps\_utility::setClientSysState("levelNotify", "intro_fakefire_end");
  } else {
    level notify("intro_fakefire_end");
  }
  thread parliament_aa_tracers();
  thread event_parliament_action(skipto);
  thread balcony_playerhints();
  thread first_balcony_action();
  thread bazooka_team_init();
  thread falling_eagle_director();
  thread falling_eagle();
  thread cleanup_forcecolor_redshirts("c", "trig_parliament_exit", "targetname");
}

parliament_aa_tracers() {
  emitters = GetEntArray("org_parliament_aa_emitter", "targetname");
  ASSERTEX(array_validate(emitters), "Couldn't find parliament AA tracer emitters.");
  array_thread(emitters, maps\ber3b_fx::ambient_aaa_fx, "parliament_doors_open");
  level waittill("parliament_doors_open");
  level thread delete_group(emitters, 1);
}

event_parliament_action(skipto) {
  if(!isDefined(skipto)) {
    skipto = false;
  }
  trigger_wait("trig_parliament_playerNearDoor", "targetname");
  level thread parliament_doors_open();
  level waittill("parliament_doors_open");
  set_color_chain("trig_script_color_allies_b17");
  trigger_wait("trig_parliament_exit", "targetname");
  maps\ber3b_event_roof::event_roof_setup();
}

balcony_playerhints() {
  flag_init("player_start_balcony_path_hint");
  flag_init("player_found_balcony_stairs");
  flag_init("player_reached_balcony");
  thread player_start_path_hint();
  thread player_heading_upstairs();
  thread player_reached_balcony();
  setmusicstate("PARLIAMENT_ROOM");
  level thread maps\ber3b_amb::play_crowd_sound();
  trigger_wait("trig_parliament_entrance", "targetname");
  sargeWaveNode = getnode_safe("node_sarge_parliament_hint", "targetname");
  level.sarge thread sarge_balcony_playerhint_anim();
  level.sarge SetGoalPos(sargeWaveNode.origin, sargeWaveNode.angles);
  flag_wait("player_start_balcony_path_hint");
  set_objective(2);
  thread balcony_breadcrumbs(2);
  level.sarge playsound_generic_facial("Ber3B_IGD_033A_REZN");
  level.sarge playsound_generic_facial("Ber3B_IGD_034A_REZN");
  level.sarge thread playsound_generic_facial("Ber3B_IGD_035A_REZN");
  if(!flag("player_reached_balcony")) {
    lines[0] = "Ber3B_IGD_104A_REZN";
    lines[1] = "Ber3B_IGD_035A_REZN";
    lines[2] = "Ber3B_IGD_025A_REZN";
    thread bug_player(lines, 15, 25, "player_reached_balcony");
  }
}

player_start_path_hint() {
  trig = getent_safe("trig_parliament_path_hint", "targetname");
  trig waittill("trigger");
  flag_set("player_start_balcony_path_hint");
  wait(1);
  trig Delete();
}

player_heading_upstairs() {
  trig = getent("trig_player_heading_upstairs", "targetname");
  trig waittill("trigger");
  flag_set("player_found_balcony_stairs");
  wait(1);
  trig Delete();
}

player_reached_balcony() {
  trigger_wait("trig_parliament_rightbalcony_entrance", "targetname");
  flag_set("player_reached_balcony");
}

balcony_breadcrumbs(obj) {
  Objective_Position(obj, (1536, 17592, 934));
  Objective_Ring(obj);
  trigger_wait("trig_player_heading_upstairs", "targetname");
  Objective_Position(obj, (1792, 17830, 1194));
  Objective_Ring(obj);
  trigger_wait("trig_parliament_rightbalcony_entrance", "targetname");
  Objective_Position(obj, (2249, 18604, 1170));
  Objective_Ring(obj);
}

sarge_balcony_playerhint_anim() {
  self clear_force_color();
  self.og_goalradius = level.sarge.goalradius;
  self.goalradius = 32;
  self.ignoreall = true;
  self waittill("goal");
  self waittill_notify_or_timeout("orientdone", 3);
  if(!flag("player_found_balcony_stairs")) {
    loopEnder = "stop_balconywave";
    self.animname = "sarge";
    self thread anim_loop_solo(self, "balconywave", undefined, loopEnder);
    flag_wait("player_found_balcony_stairs");
    self notify(loopEnder);
  }
  self.goalradius = level.sarge.og_goalradius;
  self.ignoreall = false;
  self set_force_color("b");
}

first_balcony_action() {
  flag_init("sarge_balcony_moveup_dialogue_done");
  flag_init("sarge_balcony_molotov_throwers_dialogue_done");
  thread downstairs_door_opener();
  trigger_wait("trig_parliament_rightbalcony_entrance", "targetname");
  requiredKills = 12;
  timeout = 300;
  thread balcony_playerkills(requiredKills, timeout);
  thread balcony_threatbiases();
  flag_wait("first_balcony_russians_moveup");
  thread sarge_balcony_moveup_dialogue();
  set_color_chain("trig_script_color_allies_c1");
  getent_safe("trig_script_fallback_400", "targetname") notify("trigger");
  getent_safe("trig_script_killspawner_19", "targetname") notify("trigger");
  getent_safe("trig_script_killspawner_20", "targetname") notify("trigger");
  thread balcony_podium_enemies_dialogue();
  wait(0.5);
  balcony_spawn_molotov_throwers();
  balcony_spawn_flamethrowers();
  wait(3);
  thread sarge_balcony_molotov_throwers_dialogue();
  Objective_AdditionalCurrent(10);
  thread spawn_podium_filler_enemies();
  wait(2);
  thread balcony_failsafe_spawn_podium_enemies(6);
  balcony_enemies = get_ai_group_ai("parliament_balcony_enemies");
  if(array_validate(balcony_enemies)) {
    timeout = 120;
    waittill_group_dies(balcony_enemies, timeout, 0, false);
  }
  level.sarge playsound_generic_facial("RU_rez_order_attack_infantry_07");
  trig1 = getent_safe("trig_parliament_defensive_line_entrance", "targetname");
  trig2 = getent_safe("trig_parliament_back_entrance", "targetname");
  thread waittill_player_downstairs(trig1, trig2);
  set_objective(3);
  objective_position(3, (2830, 18996, 1078));
  level notify("balcony_doors_getready");
  flag_init("balcony_doors_opened");
  setmusicstate("DOWN_THE_STAIRS");
  animSpot = getstruct_safe("struct_parliament_first_balcony_dooropen_spot", "targetname");
  waitNode = getnode_safe("node_balcony_dooropener_wait", "targetname");
  opener = get_closest_from_group(animSpot.origin, level.friends);
  ASSERTEX(is_active_ai(opener), "Couldn't find an AI close to the balcony door.");
  openerHadBulletShield = false;
  if(isDefined(opener.magic_bullet_shield) && opener.magic_bullet_shield) {
    openerHadBulletShield = true;
  } else {
    opener thread magic_bullet_shield_safe();
  }
  opener.ignoreme = true;
  opener.ignoreall = true;
  opener.og_goalradius = opener.goalradius;
  opener.goalradius = 24;
  opener clear_force_color();
  opener SetGoalNode(waitNode);
  trig = GetEnt("trig_script_color_allies_b10", "targetname");
  if(isDefined(trig)) {
    trig thread scr_delete();
  }
  set_color_chain("trig_script_color_allies_b14");
  thread balcony_doors_wait(animSpot);
  thread downstairs_doors_wait();
  flag_wait("first_balcony_doors_startopen");
  thread autosave_by_name("ber2_pment_balcony_cleared");
  opener set_animname_custom("first_balcony_dooropener");
  animSpot anim_reach_solo(opener, "shoulder");
  thread balcony_doors_open(opener);
  animSpot anim_single_solo(opener, "shoulder");
  flag_wait("balcony_doors_opened");
  if(!openerHadBulletShield) {
    opener thread stop_magic_bullet_shield_safe();
  }
  opener SetGoalPos((2123, 19023, 874));
  opener thread delayThread(10, ::set_force_color, "b");
  opener thread delayThread(5, ::scr_ignoreme, 0);
  opener thread delayThread(5, ::scr_ignoreall, 0);
  opener thread delayThread(5, ::scr_reset_goalradius);
  if(!flag("parliament_backdoor_used")) {
    set_color_chain("trig_script_color_allies_b11");
  }
  ogMarker = GetStruct("struct_objective9_marker", "targetname");
  Objective_Position(3, trig1.origin);
  lines[0] = "RU_0_order_move_forward_05";
  lines[1] = "RU_rez_order_move_follow_00";
  lines[2] = "RU_1_order_attack_infantry_05";
  thread bug_player(lines, 15, 25, "stop_bugging_player");
  flag_wait("player_downstairs");
  level notify("stop_bugging_player");
  Objective_Position(3, ogMarker.origin);
  wait(0.1);
  trig1 Delete();
  trig2 Delete();
}

sarge_balcony_moveup_dialogue() {
  level.sarge playsound_generic_facial("RU_1_order_action_boost_07");
  level.sarge playsound_generic_facial("RU_0_order_attack_infantry_04");
  flag_set("sarge_balcony_moveup_dialogue_done");
}

sarge_balcony_molotov_throwers_dialogue() {
  flag_wait("sarge_balcony_moveup_dialogue_done");
  level.sarge playsound_generic_facial("RU_1_threat_infantry_multiple_03");
  level.sarge playsound_generic_facial("RU_rez_landmark_near_balcony_01");
  level.sarge playsound_generic_facial("RU_rez_threat_infantry_exposed_08");
  flag_set("sarge_balcony_molotov_throwers_dialogue_done");
}

balcony_podium_enemies_dialogue() {
  trigger_wait("trig_spawn_podium_enemies", "script_noteworthy");
  flag_wait_all("sarge_balcony_moveup_dialogue_done", "sarge_balcony_molotov_throwers_dialogue_done");
  level.sarge playsound_generic_facial("RU_rez_threat_infantry_multiple_02");
  level.sarge playsound_generic_facial("RU_0_order_action_suppress_04");
}

waittill_player_downstairs(trig1, trig2) {
  level endon("player_downstairs");
  thread waittill_player_downstairs_2(trig2);
  trig1 waittill("trigger");
  flag_set("player_downstairs");
}

waittill_player_downstairs_2(trig2) {
  level endon("player_downstairs");
  trig2 waittill("trigger");
  level thread balcony_player_using_parliament_backentrance();
  wait(0.1);
  flag_set("player_downstairs");
}

balcony_player_using_parliament_backentrance() {
  flag_set("parliament_backdoor_used");
  trig = GetEnt("trig_script_color_allies_b10", "targetname");
  if(isDefined(trig)) {
    trig thread scr_delete();
  }
  trig = GetEnt("trig_script_color_allies_b12", "targetname");
  if(isDefined(trig)) {
    trig thread scr_delete();
  }
  set_color_chain("trig_script_color_allies_b13");
  getent_safe("trig_friendly_respawn_first_balcony_exit", "script_noteworthy") notify("trigger");
  getent_safe("trig_spawn_podium_enemies", "script_noteworthy") notify("trigger");
  getent_safe("trig_parliament_defensive_line_entrance", "targetname") notify("trigger");
  parliament_mg_adjust();
}

parliament_mg_adjust() {
  mg = getent("auto788", "targetname");
  mg.yawconvergencetime = 2.25;
  mg.convergencetime = 2.25;
  mg.suppressionTime = 2.0;
}

balcony_doors_wait(animSpot) {
  level endon("first_balcony_doors_startopen");
  waittill_player_within_range(animSpot.origin, 245);
  flag_set("first_balcony_doors_startopen");
}

downstairs_doors_wait() {
  level endon("first_balcony_doors_startopen");
  trig = getent_safe("trig_parliament_downstairs_door_proxcheck", "targetname");
  trig waittill("trigger");
  trig Delete();
  flag_set("first_balcony_doors_startopen");
}

downstairs_door_opener() {
  animSpot = getstruct_safe("struct_parliament_downstairs_dooropen_spot", "targetname");
  waitNode1 = getnode_safe("node_parliament_doors_downstairs_wait1", "targetname");
  while (!array_validate(get_allies_by_color("c"))) {
    wait(0.1);
  }
  opener = undefined;
  redshirts = get_allies_by_color("c");
  for (i = 0; i < redshirts.size; i++) {
    if(is_active_ai(redshirts[i])) {
      opener = redshirts[i];
      break;
    }
  }
  ASSERTEX(is_active_ai(opener), "Couldn't find a guy to open the door downstairs!");
  opener thread magic_bullet_shield_safe();
  opener.grenadeawareness = 0;
  opener.ignoreme = true;
  opener.og_goalradius = opener.goalradius;
  opener.goalradius = 24;
  opener.name = "Pvt. Lofski";
  opener clear_force_color();
  opener SetGoalNode(waitNode1);
  level waittill("balcony_doors_getready");
  opener set_animname_custom("downstairs_dooropener");
  animSpot anim_reach_solo(opener, "shoulder");
  flag_wait("first_balcony_doors_startopen");
  flag_init("downstairs_doors_opened");
  thread downstairs_doors_open(opener);
  animSpot anim_single_solo(opener, "shoulder");
  flag_wait("downstairs_doors_opened");
  opener thread stop_magic_bullet_shield_safe();
  opener.grenadeawareness = 1;
  opener.ignoreme = false;
  opener.ignoreall = false;
  opener.goalradius = opener.og_goalradius;
  opener SetGoalPos((1344, 18624, 880));
  wait(5);
  opener bloody_death(true, 3);
}

downstairs_doors_open(opener) {
  doorLeft = getent_safe("parl_1st_floor_door_left", "targetname");
  doorRight = getent_safe("parl_1st_floor_door_right", "targetname");
  rotateTime = 0.24;
  accelTime = rotateTime * 0.1;
  decelTime = rotateTime * 0.5;
  opener waittillmatch("single anim", "bash");
  doorLeft ConnectPaths();
  doorRight ConnectPaths();
  doorLeft RotateYaw(85, rotateTime, accelTime, decelTime);
  doorRight RotateYaw(-85, rotateTime, accelTime, decelTime);
  wait(rotateTime);
  flag_set("downstairs_doors_opened");
}

bug_player(lines, minBugInterval, maxBugInterval, ender) {
  level endon(ender);
  theLine = undefined;
  lastLine = undefined;
  maxTries = 10;
  while (1) {
    wait(RandomFloatRange(minBugInterval, maxBugInterval));
    foundOne = false;
    tries = 0;
    while (!foundOne) {
      theLine = get_random(lines);
      if(!isDefined(lastLine)) {
        break;
      } else {
        if(tries < maxTries) {
          if(theLine != lastLine) {
            break;
          }
        } else {
          theLine = get_random(lines);
          break;
        }
      }
      tries++;
    }
    level.sarge playsound_generic_facial(theLine);
    lastLine = theLine;
  }
}

balcony_playerkills(requiredKills, timeout) {
  level.balcony_playerkills = 0;
  endTime = GetTime() + (timeout * 1000);
  while ((level.balcony_playerkills < requiredKills) && (GetTime() < endTime)) {
    wait(0.1);
  }
  flag_set("first_balcony_russians_moveup");
}

balcony_threatbiases() {
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] SetThreatBiasGroup("players");
  }
  SetIgnoreMeGroup("players", "parliament_floor_enemies");
  SetIgnoreMeGroup("friends", "parliament_floor_enemies");
}

balcony_spawn_molotov_throwers() {
  getent_safe("trig_spawn_balcony_enemies", "targetname") notify("trigger");
  thread kill_balcony_enemies();
}

kill_balcony_enemies() {
  trigger_wait("trig_parliament_defensive_line_entrance", "targetname");
  wait(5);
  ais = get_ai_group_ai("parliament_balcony_enemies");
  for (i = 0; i < ais.size; i++) {
    if(is_active_ai(ais[i])) {
      ais[i] DoDamage(ais[i].health + 1, ais[i].origin);
      wait(RandomFloatRange(3, 7));
    }
  }
}

parliament_molotovguy_spawnfunc() {
  self endon("death");
  self.ignoreme = true;
  self.grenadeawareness = 0;
  self.ignoresuppression = 1;
  node = getnode_safe(self.target, "targetname");
  self SetGoalNode(node);
  self waittill("goal");
  self.allowdeath = true;
  wait(RandomFloatRange(0, 2));
  self.animname = "parliament_molotov_thrower";
  anime = "molotov_throw_custom";
  while (1) {
    forward = AnglesToForward(node.angles);
    targetDist = RandomIntRange(300, 700);
    target_pos = self.origin + vectorScale(forward, targetDist);
    self maps\_grenade_toss::force_grenade_toss(target_pos, "molotov", undefined, anime);
    wait(RandomFloatRange(3, 6));
  }
}

balcony_spawn_flamethrowers() {
  getent_safe("trig_spawn_flamers", "targetname") notify("trigger");
  thread balcony_kill_flamers();
}

balcony_kill_flamers() {
  trigger_wait("trig_script_color_allies_b27", "targetname");
  flamers = get_ai_group_ai("ai_parliament_flamer");
  array_thread(flamers, ::kill_flamer, 2, 4);
}

kill_flamer(waitMin, waitMax) {
  self endon("death");
  wait(RandomFloatRange(waitMin, waitMax));
  players = get_players();
  if(is_active_ai(self)) {
    self DoDamage(self.health + 1, self.origin, players[0]);
  }
}

flamer_setup() {
  self endon("death");
  self.ignoreme = true;
  self.health = 10000;
  level thread flamer_blow(self);
}

flamer_blow(flamer) {
  total_dmg = 0;
  while (1) {
    flamer waittill("damage", amount, attacker, dir, point, mod);
    if(IsPlayer(attacker)) {
      if(flamer animscripts\utility::damageLocationIsAny("torso_upper", "torso_lower", "head", "neck", "right_arm_upper", "right_arm_lower", "left_arm_upper", "left_arm_lower")) {
        break;
      } else {
        total_dmg += amount;
        if(total_dmg > 150) {
          if(mod == "MOD_GRENADE_SPLASH" || mod == "MOD_EXPLOSIVE" || mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH") {
            break;
          }
          flamer DoDamage(flamer.health * 10, flamer.origin);
          return;
        }
      }
    }
  }
  level thread flamer_blow_catch_splash_kills(flamer, attacker, 0.25);
  Earthquake(0.2, 0.2, flamer.origin, 1500);
  PlayFX(level._effect["flameguy_explode"], flamer.origin + (0, 0, 50));
  flamer.health = 50;
  attacker MagicGrenadeType("stick_grenade", flamer.origin + (-20, -25, 20), flamer.origin, 0.01);
  attacker MagicGrenadeType("stick_grenade", flamer.origin + (-25, -30, 10), flamer.origin, 0.01);
  spot = flamer.origin;
  allies = GetAIArray("allies");
  wait(0.1);
  if(isDefined(flamer) && isDefined(flamer.health) && flamer.health > 0) {
    flamer DoDamage(flamer.health * 10, flamer.origin);
    flamer StartTanning();
  }
  wait(0.1);
  attacker MagicGrenadeType("molotov", spot + (0, 0, 5), spot + (0, 0, -1), 0.01);
  arcademode_assignpoints("arcademode_score_kill", attacker);
}

flamer_blow_catch_splash_kills(flamer, attacker, splashKillTimeWindow) {
  if(!isDefined(level.flamerSplashKillsForChallenge)) {
    level.flamerSplashKillsForChallenge = 2;
  }
  grenadeDist = 256;
  if(!isDefined(attacker.flamerSplashKills)) {
    attacker.flamerSplashKills = [];
  }
  flamerIndex = attacker.flamerSplashKills.size;
  attacker.flamerSplashKills[flamerIndex] = 0;
  closeGuys = [];
  ais = GetAIArray("axis");
  for (i = 0; i < ais.size; i++) {
    if((Distance(ais[i].origin, flamer.origin) <= grenadeDist) && (ais[i] != flamer)) {
      closeGuys[closeGuys.size] = ais[i];
    }
  }
  if(closeGuys.size >= level.flamerSplashKillsForChallenge) {
    array_thread(closeGuys, ::flamer_blow_splash_kill_watcher, attacker, flamerIndex, splashKillTimeWindow);
  }
}

flamer_blow_splash_kill_watcher(attacker, flamerIndex, splashKillTimeWindow) {
  endTime = GetTime() + (splashKillTimeWindow * 1000);
  while (IsAlive(self) && endTime > GetTime()) {
    wait(0.05);
  }
  if(!IsAlive(self)) {
    if(isDefined(self.attacker) && self.attacker == attacker) {
      if(isDefined(self.damagemod) && (self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH" || self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_BURNED")) {
        attacker.flamerSplashKills[flamerIndex]++;
        if(attacker.flamerSplashKills[flamerIndex] >= level.flamerSplashKillsForChallenge) {
          if(!isDefined(attacker.gaveFlamerPoints)) {
            attacker.gaveFlamerPoints = true;
            attacker maps\_challenges_coop::processChallenge("ch_backdraft_1");
          }
        }
      }
    }
  }
}

spawn_podium_filler_enemies() {
  getent_safe("trig_spawn_podium_filler_enemies", "script_noteworthy") notify("trigger");
  trigger_wait("trig_spawn_podium_enemies", "script_noteworthy");
  getent_safe("trig_killspawner_21", "targetname") notify("trigger");
}

balcony_failsafe_spawn_podium_enemies(axisLowerLimit) {
  trig = getent_safe("trig_spawn_podium_enemies", "script_noteworthy");
  trig endon("trigger");
  while (1) {
    axis = GetAIArray("axis");
    if(!isDefined(axis)) {
      break;
    }
    if(axis.size < axisLowerLimit) {
      break;
    }
    wait(1);
  }
  trig notify("trigger");
}

balcony_doors_open(opener) {
  doorLeft = getent_safe("sb_model_balcony_door_left", "targetname");
  doorRight = getent_safe("sb_model_balcony_door_right", "targetname");
  rotateTime = 0.24;
  accelTime = rotateTime * 0.1;
  decelTime = rotateTime * 0.5;
  opener waittillmatch("single anim", "door_hit");
  doorLeft ConnectPaths();
  doorRight ConnectPaths();
  doorLeft RotateYaw(110, rotateTime, accelTime, decelTime);
  doorRight RotateYaw(-110, rotateTime, accelTime, decelTime);
  wait(rotateTime);
  flag_set("balcony_doors_opened");
}

parliament_enemy_spawnfunc() {
  if(isDefined(self.script_string) && self.script_string == "balcony_guy") {
    self thread parliament_molotovguy_spawnfunc();
  }
  if(IsSubStr(self.classname, "panzerschrek") || IsSubStr(self.classname, "flamethrower")) {
    self AllowedStances("stand");
  }
  self waittill("death");
  if(isDefined(self.attacker) && IsPlayer(self.attacker)) {
    if(!isDefined(level.balcony_playerkills)) {
      level.balcony_playerkills = 0;
    }
    level.balcony_playerkills++;
  }
}

bazooka_team_init() {
  trig = getent_safe("trig_parliament_bazookateam", "targetname");
  trig waittill("trigger");
  thread bazooka_team(trig);
}

bazooka_team(trig) {
  spawner_primary = getent_safe(trig.target, "targetname");
  spawner_secondary = getent_safe(spawner_primary.target, "targetname");
  node_primary = getnode_safe(spawner_primary.target, "targetname");
  node_secondary = getnode_safe(spawner_secondary.target, "targetname");
  trig Delete();
  guy_primary = spawn_guy(spawner_primary);
  guy_secondary = spawn_guy(spawner_secondary);
  guys[0] = guy_primary;
  guys[1] = guy_secondary;
  guys bazookateam_setup_ais();
  guys bazookateam_runto_nodes(node_primary, node_secondary);
  guy_primary.animname = "fireteam_bazooka_primary";
  guy_secondary.animname = "fireteam_bazooka_secondary";
  guy_primary SetCanDamage(false);
  aimSpots = GetEntArray(node_primary.target, "targetname");
  explosionRadius = 215;
  flag_set("bazookateam_keep_firing");
  guy_primary.shoot_notify = "bazooka_shot";
  for (i = 0; i < aimSpots.size; i++) {
    guys bazookateam_reload();
    guy_primary thread bazookateam_fire_dialogue();
    wait(1);
    aimSpot = aimSpots[RandomInt(aimSpots.size)];
    guy_primary AllowedStances("stand");
    wait(0.8);
    guy_primary.ignoreall = false;
    guy_primary SetEntityTarget(aimSpot);
    guy_primary waittill("bazooka_shot");
    level notify("bazookateam_fire");
    wait(0.05);
    guy_primary ClearEntityTarget();
    guy_primary AllowedStances("crouch");
    if(flag("bazookateam_keep_firing")) {
      wait(RandomFloatRange(3, 6));
    } else {
      wait(2);
      guy_primary gun_switchto(guy_primary.secondaryweapon, "right");
      break;
    }
  }
  guy_primary.shoot_notify = undefined;
  wait(3);
  guys bazookateam_reset_ais();
  array_thread(guys, ::bloody_death, true, 2);
}

bazookateam_fire_dialogue() {
  dialogueString = undefined;
  if(RandomInt(100) < 50) {
    dialogueString = "bazooka_firing_1";
  } else {
    dialogueString = "bazooka_firing_2";
  }
  self say_dialogue("fireteam_bazooka_primary", "bazooka_firing_2");
}

bazookateam_reload() {
  anime = "bazooka_reload";
  level thread bazooka_reload_rocket_attach(self);
  level thread anim_single(self, anime);
  level waittill(anime);
}

bazooka_reload_rocket_attach(guys) {
  animname = "fireteam_bazooka_primary";
  rocketModel = "weapon_ger_panzershreck_rocket";
  attachTag = "tag_inhand";
  attachNote = "attach clip left";
  detachNote = "detach clip left";
  guy = undefined;
  for (i = 0; i < guys.size; i++) {
    if(guys[i].animname == animname) {
      guy = guys[i];
      break;
    }
  }
  ASSERTEX(isDefined(guy), "Couldn't find the bazooka guy with animname " + animname);
  guy endon("death");
  guy waittillmatch("single anim", attachNote);
  guy Attach(rocketModel, attachTag);
  guy thread bazooka_rocket_deathdetach(rocketModel, attachTag);
  guy waittillmatch("single anim", detachNote);
  guy Detach(rocketModel, attachTag);
  guy notify("rocket_detached");
}

bazooka_rocket_deathdetach(rocketModel, attachTag) {
  self endon("rocket_detached");
  self waittill("death");
  self Detach(rocketModel, attachTag);
}

bazookateam_setup_ais() {
  self[0].bazookateam_role = "primary";
  self[1].bazookateam_role = "secondary";
  for (i = 0; i < self.size; i++) {
    guy = self[i];
    guy.og_goalradius = guy.goalradius;
    guy.goalradius = 12;
    guy.ignoreme = true;
    guy.ignoreall = true;
    guy.og_grenadeawareness = guy.grenadeawareness;
    guy.grenadeawareness = 0;
    guy PushPlayer(true);
    guy thread magic_bullet_shield();
  }
}

bazookateam_reset_ais() {
  for (i = 0; i < self.size; i++) {
    guy = self[i];
    if(!is_active_ai(guy)) {
      continue;
    }
    guy.goalradius = guy.og_goalradius;
    guy.ignoreme = false;
    guy.ignoreall = false;
    guy.grenadeawareness = guy.og_grenadeawareness;
    guy PushPlayer(false);
    guy notify("stop magic bullet shield");
    guy SetCanDamage(true);
    guy AllowedStances("stand", "crouch", "prone");
  }
}

bazookateam_runto_nodes(nodePrimary, nodeSecondary) {
  self[0] SetGoalNode(nodePrimary);
  self[1] SetGoalNode(nodeSecondary);
  array_thread(self, ::bazooka_guy_reached_node);
  numReached = 0;
  while (numReached < self.size) {
    level waittill("bazooka_guy_reached_node");
    numReached++;
  }
}

bazooka_guy_reached_node() {
  self endon("death");
  self waittill("goal");
  level notify("bazooka_guy_reached_node");
  self AllowedStances("crouch");
}

falling_eagle_director() {
  trigger_wait("trig_parliament_rightbalcony_entrance", "targetname");
  wait(1);
  level notify("eagle_slip");
  flag_clear("bazookateam_keep_firing");
}

falling_eagle() {
  eagle = getent_safe("smodel_parliament_eagle", "targetname");
  pieces["lamp_base_jnt"] = getent_safe("smodel_parliament_spotlight", "targetname");
  pieces["bookcase01_jnt"] = getent_safe("smodel_parliament_bookshelf_1", "targetname");
  pieces["bookcase02_jnt"] = getent_safe("smodel_parliament_bookshelf_2", "targetname");
  pieces["bookcase03_jnt"] = getent_safe("smodel_parliament_bookshelf_3", "targetname");
  pieces["bookcase04_jnt"] = getent_safe("smodel_parliament_bookshelf_4", "targetname");
  pieces["bookcase05_jnt"] = getent_safe("smodel_parliament_bookshelf_5", "targetname");
  pieces["bookcase06_jnt"] = getent_safe("smodel_parliament_bookshelf_6", "targetname");
  pieces["bookcase07_jnt"] = getent_safe("smodel_parliament_bookshelf_7", "targetname");
  pieces["bookcase08_jnt"] = getent_safe("smodel_parliament_bookshelf_8", "targetname");
  pieces["bookcase09_jnt"] = getent_safe("smodel_parliament_bookshelf_9", "targetname");
  pieces["bookcase10_jnt"] = getent_safe("smodel_parliament_bookshelf_10", "targetname");
  keys = GetArrayKeys(pieces);
  for (i = 0; i < pieces.size; i++) {
    pieces[keys[i]] LinkTo(eagle, keys[i]);
  }
  rocketStart = (1144, 17688, 984);
  rocketTime = 1.5;
  thread eagle_reaction_dialogue();
  level waittill("eagle_slip");
  MagicBullet("panzerschrek", rocketStart, eagle.origin);
  wait(rocketTime);
  PlayFX(level._effect["eagle_support_break"], eagle.origin);
  eagle thread parliament_eagle_anim("parliament_eagle", "slip", "eagle_slip_anim");
  eagle_fall_wait();
  killtrig = GetEnt("trig_killspawner_22", "targetname");
  if(isDefined(killtrig)) {
    killtrig notify("trigger");
  }
  level notify("arty_strike");
  thread arty_strike_on_players(.35, 2, 500);
  if(!level.player_shot_eagle) {
    MagicBullet("panzerschrek", rocketStart, eagle.origin);
    wait(rocketTime);
  }
  fxSpot = getstruct_safe("struct_parliament_eaglefall_fxspot", "targetname");
  PlayFX(level._effect["eagle_fall_impact"], fxSpot.origin);
  PlayFX(level._effect["eagle_support_break"], eagle.origin);
  eagle thread parliament_eagle_anim("parliament_eagle", "fall", "eagle_fall_anim");
  wait(0.6);
  podiumtrig = getent_safe("trig_parliament_podium_area", "targetname");
  RadiusDamage(podiumtrig.origin, podiumtrig.radius, 5000, 5000);
  thread kill_axis_in_trigger(podiumtrig, 0);
  thread parliament_podiumdoor_clean_rogue_ai();
  wait(5);
  podiumtrig Delete();
}

eagle_reaction_dialogue() {
  level waittill("eagle_slip");
  wait(2);
  sarge_giveorder("eagle_loosening");
  trigger_wait("trig_parliament_defensive_line_entrance", "targetname");
  guy1 = get_randomfriend_notsarge();
  guy1 say_dialogue("eagle_redshirt2", "aim_for_eagle", true);
  level thread eagle_bringdown_dialogue();
  flag_wait("eagle_fall");
  level.sarge playsound_generic_facial("Ber3B_IGD_049A_REZN");
}

eagle_bringdown_dialogue() {
  level endon("eagle_fall");
  level.sarge playsound_generic_facial("Ber1_IGD_022A_REZN");
  level.sarge playsound_generic_facial("RU_rez_landmark_near_eagle_00");
  level.sarge playsound_generic_facial("See1_IGD_049A_REZN");
  level.sarge playsound_generic_facial("See1_IGD_300A_REZN");
}

eagle_fall_wait() {
  level.player_shot_eagle = false;
  trigger_wait("trig_parliament_defensive_line_entrance", "targetname");
  thread eagle_fall_proxtrigger();
  thread eagle_fall_dmgtrigger();
  level waittill("eagle_fall");
}

eagle_fall_proxtrigger() {
  level endon("eagle_fall");
  trigger_wait("trig_parliament_approaching_podium", "targetname");
  flag_set("eagle_fall");
}

eagle_fall_dmgtrigger() {
  level endon("eagle_fall");
  dmgtrig = getent_safe("trig_damage_parliament_eagle", "targetname");
  dmgtrig waittill("trigger");
  level.player_shot_eagle = true;
  flag_set("eagle_fall");
  dmgtrig Delete();
}

parliament_podiumdoor_clean_rogue_ai() {
  axis = GetAIArray("axis");
  for (i = 0; i < axis.size; i++) {
    guy = axis[i];
    if(guy.origin[1] > 20360) {
      guy bloody_death(true, 0);
    }
  }
}

parliament_doors_open() {
  setmusicstate("PARLIAMENT_CLEARED");
  doorLeft = GetEnt("sbmodel_pment_door_left", "targetname");
  doorRight = GetEnt("sbmodel_pment_door_right", "targetname");
  doorNodeLeft = getnode_safe("node_parliament_door_left", "targetname");
  doorNodeRight = getnode_safe("node_parliament_door_right", "targetname");
  trigger_wait("trig_parliament_playerNearDoor", "targetname");
  thread battlechatter_off("allies");
  thread battlechatter_off("axis");
  animSpot = getent_safe("org_parliamentdoors_animref", "targetname");
  thread parliament_doorrunners();
  pushers[0] = get_closest_from_group(animSpot.origin, level.friends, level.sarge, "parliament_russian_backup_1");
  pushers[0] parliament_doorpusher_setup();
  pushers[0].animname = "parliament_doorpusher_1";
  pushers[1] = get_closest_from_group(animSpot.origin, level.friends, level.sarge, "parliament_russian_backup_2");
  pushers[1] parliament_doorpusher_setup();
  pushers[1].animname = "parliament_doorpusher_2";
  pushers[2] = level.sarge;
  pushers[2] parliament_doorpusher_setup();
  pushers[2].animname = "parliament_doorpusher_3";
  thread parliament_doors_open_sarge_dialogue();
  spawners = GetEntArray("spawner_parliament_doorholder", "targetname");
  ASSERTEX(isDefined(spawners) && spawners.size == 3, "Couldn't find enough parliament door holder enemy spawners.");
  germans = [];
  for (i = 0; i < spawners.size; i++) {
    enemy = spawn_guy(spawners[i]);
    enemy parliament_doorpusher_setup();
    enemy.nodeathragdoll = true;
    enemy.animname = "parliament_doorholder_" + (i + 1);
    enemy.deathanim = level.scr_anim[enemy.animname]["doorbreach"];
    enemy thread magic_bullet_shield_safe();
    enemy SetGoalPos(enemy.origin);
    germans[i] = enemy;
  }
  ASSERTEX(isDefined(germans) && germans.size == 3, "Couldn't find enough parliament door holder enemies - one or more spawns must have failed.");
  level.door_reachers = 0;
  pushers[0] thread parliament_doors_reach_wait(doorNodeLeft);
  pushers[1] thread parliament_doors_reach_wait(doorNodeRight);
  pushers[2] thread parliament_doors_reach_wait();
  animSpot thread anim_reach_solo(pushers[2], "doorpush");
  while (level.door_reachers < pushers.size) {
    wait(0.05);
  }
  doorLeft thread reichstag_dooranim("parliament_door_left", "doorpush", "parliamentdoor_anim", false);
  doorRight thread reichstag_dooranim("parliament_door_right", "doorpush", "parliamentdoor_anim", false);
  animSpot anim_single(pushers, "doorpush");
  level notify("parliament_doors_opening");
  doorLeft thread reichstag_dooranim("parliament_door_left", "doorbreach", "parliamentdoor_anim", true);
  doorRight thread reichstag_dooranim("parliament_door_right", "doorbreach", "parliamentdoor_anim", true);
  level notify("door_music_stinger");
  array_thread(germans, ::parliament_doors_kill_doorholder, animSpot);
  animSpot anim_single(pushers, "doorbreach");
  pushers[0] AllowedStances("stand", "crouch", "prone");
  pushers[1] AllowedStances("stand", "crouch", "prone");
  for (i = 0; i < pushers.size; i++) {
    pushers[i] parliament_doorpusher_reset();
  }
  level.sarge thread playsound_generic_facial("Ber3B_IGD_042A_REZN");
  thread battlechatter_on("allies");
  thread battlechatter_on("axis");
  level notify("parliament_doors_open");
  setmusicstate("THROUGH_THE_DOOR");
}

parliament_doors_open_sarge_dialogue() {
  level.sarge playsound_generic_facial("Ber3B_IGD_036A_REZN");
  level.sarge playsound_generic_facial("Ber3B_IGD_039A_REZN");
}

parliament_doors_reach_wait(reachNode) {
  if(isDefined(reachNode)) {
    self.goalradius = 24;
    self SetGoalNode(reachNode);
    self waittill("goal");
  } else {
    self waittill("anim_reach_complete");
  }
  level.door_reachers++;
}

parliament_doorpusher_setup() {
  if(level.friends array_contains_element(self)) {
    self.removed_from_friends = true;
    level.friends = array_remove(level.friends, self);
  }
  self clear_force_color();
  self.og_animname = self.animname;
  self.og_goalradius = self.goalradius;
  self.ignoreall = true;
  self.ignoreme = true;
  self.pacifist = true;
  self PushPlayer(true);
  if(self != level.sarge && self.health < 9999) {
    self thread magic_bullet_shield();
  }
}

parliament_doorpusher_reset() {
  if(isDefined(self.removed_from_friends) && self.removed_from_friends) {
    level.friends = array_add(level.friends, self);
  }
  self set_force_color("b");
  if(isDefined(self.og_animname)) {
    self.animname = self.og_animname;
  }
  self.ignoreall = false;
  self.ignoreme = false;
  self.pacifist = false;
  self PushPlayer(false);
}

parliament_doors_kill_doorholder(animSpot) {
  self thread stop_magic_bullet_shield_safe();
  self maps\_anim::set_start_pos("doorbreach", animSpot.origin, animSpot.angles, undefined);
  self animscripts\shared::DropAllAIWeapons();
  self DoDamage(self.health + 5, (0, 0, 0));
}

parliament_doorrunners() {
  runners = get_spawners_and_spawn_group("spawner_parliament_doorrunner", "targetname");
  array_thread(runners, ::door_runner_think);
}

door_runner_think() {
  self endon("death");
  self.goalradius = 24;
  self.ignoreall = true;
  self.ignoreme = true;
  self.pacifist = true;
  self thread magic_bullet_shield_safe();
  self SetGoalPos(self.origin);
  org = Spawn("script_origin", self.origin);
  self LinkTo(org);
  level waittill("parliament_doors_opening");
  wait(8.75);
  self Unlink();
  org Delete();
  self SetGoalNode(getnode_safe(self.target, "targetname"));
  self thread stop_magic_bullet_shield_safe();
  self thread ignore_til_goal();
}