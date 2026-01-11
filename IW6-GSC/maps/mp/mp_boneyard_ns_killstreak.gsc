/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_boneyard_ns_killstreak.gsc
*************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

boneyard_killstreak_setup() {
  level.ks_vertical = spawnStruct();
  level.ks_vertical.sfx = GetEnt("ks_vertical_org", "targetname");
  level.ks_vertical.dam = GetEnt("ks_vertical_damage_vol", "targetname");
  level.ks_vertical.destructibles = [(481, -74, -100)];
  level.ks_vertical.uses = 0;
  level.ks_vertical.max_uses = 1;
  level.ks_vertical.player = undefined;
  level.ks_vertical.team = undefined;

  level.ks_vertical.inflictor = GetEnt("vert_fire_ent", "targetname");

  level.ks_vertical.ui_icon = [];
  level.ks_vertical.ui_icon[0] = "compass_icon_vf_idle";
  level.ks_vertical.ui_icon[1] = "compass_icon_vf_active";
  level.ks_vertical.ui_state = 0;
  level.ks_vertical.ui_elem = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(level.ks_vertical.ui_elem, "active", (381.5, 120, 254), level.ks_vertical.ui_icon[0]);
  Objective_PlayerMask_HideFromAll(level.ks_vertical.ui_elem);

  level.alarm1_a = spawn("script_origin", (1936, 231, 221));
  level.alarm1_b = spawn("script_origin", (520, -224, 199));
  level.alarm1_c = spawn("script_origin", (346, 150, 246));
  level.alarm1_cp1 = spawn("script_origin", (346, 150, 246));
  level.alarm1_cp2 = spawn("script_origin", (346, 150, 246));
  level.alarm1_d = spawn("script_origin", (-1028, 534, 368));
  level.fire_node1 = spawn("script_origin", (1063, 112, -177));
  level.fire_node1end = spawn("script_origin", (1063, 112, -177));
  level.fire_node2 = spawn("script_origin", (1320, -439, -133));
  level.fire_node2end = spawn("script_origin", (1320, -439, -133));
  level.fire_node3 = spawn("script_origin", (-283, 97, 16));
  level.fire_node3end = spawn("script_origin", (-283, 97, 16));

  flag_init("boneyard_killstreak_captured");
  flag_init("boneyard_killstreak_can_kill");
  flag_init("boneyard_killstreak_active");
  flag_init("ks_vertical_alarm_on");
  flag_init("ks_vertical_firing");
  flag_init("boneyard_killstreak_endgame");
  flag_clear("boneyard_killstreak_endgame");

  thread ks_manage_spawns();
}

BONEYARD_KILLSTREAK_WEIGHT = 200;
BONEYARD_KILLSTREAK_MULTIPLE_WEIGHT = 100;

boneyardCustomCrateFunc() {
  level.allow_level_killstreak = allowLevelKillstreaks();
  if(!level.allow_level_killstreak) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "f1_engine_fire", BONEYARD_KILLSTREAK_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"MP_BONEYARD_NS_F1_ENGINE_FIRE_PICKUP");

  if(isDefined(game["player_holding_level_killstreak"]) && IsAlive(game["player_holding_level_killstreak"])) {
    level.ks_vertical.player = game["player_holding_level_killstreak"];
    level.ks_vertical.team = game["player_holding_level_killstreak"].pers["team"];
    flag_set("boneyard_killstreak_captured");
    thread boneyard_killstreak_ui_watcher(level.ks_vertical, 0.1);
  } else {
    level thread boneyard_killstreak_watch_for_crate();
  }
}

boneyard_killstreak_watch_for_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);
    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "f1_engine_fire") {
      boneyard_killstreak_disable();
      captured = wait_for_capture(dropCrate);
      if(!isDefined(captured)) {
        boneyard_killstreak_enable(BONEYARD_KILLSTREAK_WEIGHT);
      } else {
        level.ks_vertical.player = captured;
        level.ks_vertical.team = captured.pers["team"];
        game["player_holding_level_killstreak"] = captured;
        flag_set("boneyard_killstreak_captured");
        thread boneyard_killstreak_ui_watcher(level.ks_vertical, 0.1);
      }
    }
  }
}

wait_for_capture(dropCrate) {
  result = watch_for_air_drop_death(dropCrate);
  return result;
}

watch_for_air_drop_death(dropCrate) {
  dropCrate endon("death");

  dropCrate waittill("captured", player);
  return player;
}

boneyard_killstreak_bot_use() {
  if(isDefined(level.ks_vertical.player) && level.ks_vertical.player IsTouching(level.ks_vertical.dam)) {
    return false;
  }

  return flag("boneyard_killstreak_can_kill");
}

boneyard_killstreak_enable(WEIGHT) {
  if(isDefined(game["player_holding_level_killstreak"]) && IsAlive(game["player_holding_level_killstreak"])) {
    return false;
  }

  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "f1_engine_fire", WEIGHT);
}

boneyard_killstreak_disable() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "f1_engine_fire", 0);
}

boneyard_killstreak_endgame() {
  level waittill("game_cleanup");
  maps\mp\gametypes\_gamelogic::waittillFinalKillcamDone();

  flag_set("boneyard_killstreak_endgame");
  thread ks_vertical_warning_lights();

  thread sound_fire_loop_logic();
  thread ks_vertical_firing_fx();

  wait(10);
  flag_clear("boneyard_killstreak_endgame");
}

sound_fire_loop_logic() {
  level.fire_node1 playLoopSound("scn_fire_event_02_fire1_lp");
  level.fire_node2 playLoopSound("scn_fire_event_02_fire2_lp");
  level.fire_node3 playLoopSound("scn_fire_event_02_fire1_lp");
  wait 10.23;
  level.fire_node1end playSound("scn_fire_event_02_fire1");
  level.fire_node2end playSound("scn_fire_event_02_fire2");
  level.fire_node3end playSound("scn_fire_event_02_fire1");
  level.fire_node1 stoploopsound();
  level.fire_node2 stoploopsound();
  level.fire_node3 stoploopsound();
}

boneyard_killstreak_activate() {
  level endon("game_ended");

  while(1) {
    level waittill("boneyard_killstreak_activate", player);

    thread boneyard_killstreak_disable();
    game["player_holding_level_killstreak"] = undefined;

    flag_set("boneyard_killstreak_active");
    level.ks_vertical.player = player;
    level.ks_vertical.team = player.pers["team"];

    wait(0.5);
    flag_set("ks_vertical_alarm_on");
    thread ks_vertical_warning_alarm();
    thread ks_vertical_warning_lights();
    thread ks_vertical_firing_fx();

    wait 2;
    flag_clear("ks_vertical_alarm_on");

    ks_vertical_fire();

    flag_clear("boneyard_killstreak_active");

    if(level.ks_vertical.uses == 0) {
      flag_clear("boneyard_killstreak_captured");
      Objective_PlayerMask_HideFromAll(level.ks_vertical.ui_elem);
      level.ks_vertical.player = undefined;
      level.ks_vertical.team = undefined;

      thread boneyard_killstreak_enable(BONEYARD_KILLSTREAK_MULTIPLE_WEIGHT);
    }
  }
}

boneyard_killstreak_ui_watcher(rocket, loop_time) {
  level endon("boneyard_killstreak_captured");

  flag_clear("boneyard_killstreak_can_kill");
  thread boneyard_killstreak_ui_on(rocket);

  while(1) {
    victims = rocket.dam GetIsTouchingEntities(level.characters);

    my_state = 0;
    if(level.teambased) {
      foreach(victim in victims) {
        if(isReallyAlive(victim) && victim.pers["team"] != rocket.team) {
          my_state = 1;
          break;
        }
      }
    } else {
      foreach(victim in victims) {
        if(isReallyAlive(victim) && (victim != rocket.player || (isDefined(victim.owner) && victim.owner != rocket.player))) {
          my_state = 1;
          break;
        }
      }
    }

    if(rocket.ui_state != my_state) {
      rocket.ui_state = my_state;
      Objective_Icon(rocket.ui_elem, rocket.ui_icon[my_state]);

      if(my_state > 0) {
        flag_set("boneyard_killstreak_can_kill");
      } else {
        flag_clear("boneyard_killstreak_can_kill");
      }
    }

    wait(loop_time);
  }
}

boneyard_killstreak_ui_on(rocket) {
  pid = rocket.player GetEntityNumber();

  Objective_PlayerMask_ShowTo(rocket.ui_elem, pid);
  wait(0.2);
  Objective_PlayerMask_HideFromAll(level.ks_vertical.ui_elem);
  wait(0.3);
  Objective_PlayerMask_ShowTo(rocket.ui_elem, pid);
  wait(0.2);
  Objective_PlayerMask_HideFromAll(level.ks_vertical.ui_elem);
  wait(0.3);
  Objective_PlayerMask_ShowTo(rocket.ui_elem, pid);
}

ks_vertical_fire() {
  level endon("game_ended");

  flag_set("ks_vertical_firing");
  BadPlace_Brush("bad_vert_fire", 10, level.ks_vertical.dam, "allies", "axis");

  for(i = 0; i < 20; i++) {
    wait 0.5;
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    attacker = level.ks_vertical.player;
    if(!isDefined(level.ks_vertical.player) || !IsPlayer(level.ks_vertical.player)) {
      attacker = undefined;
    }

    thread damage_characters(level.ks_vertical, attacker, 90);
    thread damage_targets(level.ks_vertical, attacker, level.remote_uav, 150);
    thread damage_targets(level.ks_vertical, attacker, level.placedIMS, 150);
    thread damage_targets(level.ks_vertical, attacker, level.uplinks, 150);
    thread damage_targets(level.ks_vertical, attacker, level.turrets, 150);
    thread damage_targets(level.ks_vertical, attacker, level.ballDrones, 150);
    thread damage_targets(level.ks_vertical, attacker, level.mines, 150);
    thread damage_targets(level.ks_vertical, attacker, level.deployable_box["deployable_vest"], 150);
    thread damage_targets(level.ks_vertical, attacker, level.deployable_box["deployable_ammo"], 150);

    foreach(org in level.ks_vertical.destructibles) {
      RadiusDamage(org, 1, 45, 45, attacker);
    }
  }

  if(!isDefined(level.exploder_queue) || !isDefined(level.exploder_queue[108]) || (GetTime() - level.exploder_queue[108].time) > 25000) {
    maps\mp\mp_boneyard_ns::mp_exploder(108);
    thread sound_fire_loops();
  }

  flag_clear("ks_vertical_firing");
}

sound_fire_loops() {
  fire_small_1 = spawn("script_origin", (574, 228, -110));
  fire_small_2 = spawn("script_origin", (533, -7, -118));
  fire_small_3 = spawn("script_origin", (264, 221, -101));
  fire_small_4 = spawn("script_origin", (299, 1, -109));
  fire_small_out_1 = spawn("script_origin", (574, 228, -110));
  fire_small_out_2 = spawn("script_origin", (533, -7, -118));
  fire_small_out_3 = spawn("script_origin", (264, 221, -101));
  fire_small_out_4 = spawn("script_origin", (299, 1, -109));
  fire_small_1 playLoopSound("fire_small_01");
  fire_small_2 playLoopSound("fire_small_01");
  fire_small_3 playLoopSound("fire_small_01");
  fire_small_4 playLoopSound("fire_small_01");
  wait 24.8;
  fire_small_out_1 playSound("fire_small_out");
  fire_small_out_2 playSound("fire_small_out");
  fire_small_out_3 playSound("fire_small_out");
  fire_small_out_4 playSound("fire_small_out");
  wait 0.2;
  fire_small_1 stoploopsound();
  fire_small_2 stoploopsound();
  fire_small_3 stoploopsound();
  fire_small_4 stoploopsound();
  wait 0.1;
  fire_small_1 delete();
  fire_small_2 delete();
  fire_small_3 delete();
  fire_small_4 delete();
}

damage_characters(rocket, attacker, damage) {
  victims = rocket.dam GetIsTouchingEntities(level.characters);

  foreach(victim in victims) {
    if(can_kill_character(rocket, victim)) {
      if(IsPlayer(victim)) {
        if(isDefined(rocket.player) && victim == rocket.player)
      }
      victim maps\mp\gametypes\_damage::finishPlayerDamageWrapper(rocket.inflictor, attacker, damage, 0, "MOD_EXPLOSIVE", "none", victim.origin, (0, 0, 1), "none", 0, 0);
      else {
        victim DoDamage(damage, rocket.inflictor.origin, attacker, rocket.inflictor, "MOD_EXPLOSIVE");
      } else if(isDefined(victim.owner) && victim.owner == rocket.player) {
        victim maps\mp\agents\_agents::on_agent_player_damaged(undefined, undefined, damage, 0, "MOD_EXPLOSIVE", "none", victim.origin, (0, 0, 1), "none", 0);
      } else {
        victim maps\mp\agents\_agents::on_agent_player_damaged(rocket.inflictor, attacker, damage, 0, "MOD_EXPLOSIVE", "none", victim.origin, (0, 0, 1), "none", 0);
      }
    } else if(isDefined(victim) && isReallyAlive(victim)) {
      if(IsPlayer(victim)) {
        victim maps\mp\gametypes\_damage::Callback_PlayerDamage(undefined, undefined, 1, 0, "MOD_EXPLOSIVE", "none", victim.origin, (0, 0, 1), "none", 0);
      } else {
        victim maps\mp\agents\_agents::on_agent_player_damaged(undefined, undefined, 1, 0, "MOD_EXPLOSIVE", "none", victim.origin, (0, 0, 1), "none", 0);
      }
    }

    wait(0.05);
  }

}

can_kill_character(rocket, victim) {
  if(!isDefined(victim) || !isReallyAlive(victim)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(rocket.player) && victim == rocket.player) {
      return true;
    } else if(isDefined(rocket.player) && isDefined(victim.owner) && victim.owner == rocket.player) {
      return true;
    } else if(isDefined(rocket.team) && victim.team == rocket.team) {
      return false;
    }
  }

  return true;
}

damage_targets(rocket, attacker, array_targets, damage) {
  meansOfDeath = "MOD_EXPLOSIVE";
  weapon = "none";
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  modelName = "";
  tagName = "";
  partName = "";
  iDFlags = undefined;

  targets = rocket.dam GetIsTouchingEntities(array_targets);

  foreach(target in targets) {
    if(!isDefined(target)) {
      continue;
    }
    if(isDefined(target.owner) && target.owner == attacker) {
      target notify("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);
    } else if(level.teamBased && isDefined(rocket.team) && isDefined(target.team) && target.team == rocket.team) {
      continue;
    }
    target notify("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weapon);
    wait(0.05);
  }
}

ks_vertical_warning_alarm() {
  level.ks_vertical.sfx playSound("emt_boneyard_ns_close_alarm_01");

  thread sound_vertical_fire_logic();
}

sound_vertical_fire_logic() {
  level.alarm1_c playSound("scn_fire_event_02");
  wait 1.76;
  level.alarm1_cp1 playSound("scn_fire_event_02b");
  thread sound_fire_loop_logic();
  wait 10;
  level.alarm1_cp2 playSound("scn_fire_event_02c");
}

ks_vertical_warning_lights() {
  level endon("game_ended");

  while(flag("boneyard_killstreak_active") || flag("boneyard_killstreak_endgame")) {
    if(level.teamBased && isDefined(level.ks_vertical.team)) {
      foreach(player in level.players) {
        if(player.pers["team"] == level.ks_vertical.team) {
          ActivateClientExploder(19, player);
        } else {
          ActivateClientExploder(18, player);
        }
      }
    } else {
      maps\mp\mp_boneyard_ns::mp_exploder(18);
    }

    wait(0.5);
  }
}

ks_vertical_firing_fx() {
  maps\mp\mp_boneyard_ns::mp_exploder(91);

  wait 2;

  maps\mp\mp_boneyard_ns::mp_exploder(90);

  for(i = 0; i < 5; i++) {
    maps\mp\mp_boneyard_ns::mp_exploder(92);
    wait 2;
  }

  maps\mp\mp_boneyard_ns::mp_exploder(93);
}

ks_manage_spawns() {
  while(1) {
    flag_wait("boneyard_killstreak_captured");
    level.dynamicSpawns = ::filter_spawn_points;
    flag_waitopen("boneyard_killstreak_captured");
    level.dynamicSpawns = undefined;
  }
}

filter_spawn_points(spawnPoints) {
  valid_spawns = [];
  foreach(spawnPoint in spawnPoints) {
    if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy == "ks_danger_spawn") {
      continue;
    }
    valid_spawns[valid_spawns.size] = spawnPoint;
  }

  return valid_spawns;
}