/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_so_rts_rules.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_so_rts_support;
#include maps\_so_rts_squad;
#include maps\_endmission;

preload() {
  assert(isDefined(level.rts));
  assert(isDefined(level.rts_def_table));
  level.rts.rules = [];
  level.rts.rules = rules_populate();
}

lookup_value(ref, idx, column_index) {
  assert(isDefined(idx));
  return tablelookup(level.rts_def_table, 0, idx, column_index);
}

get_rule_ref_by_index(idx) {
  return tablelookup(level.rts_def_table, 0, idx, 1);
}

set_gamemode(mode) {
  level.rts.game_mode = mode;
}

init() {
  if(!isDefined(level.rts.game_mode))
    set_gamemode("attack");

  initrules();
  level.rts.viewangle = level.rts.game_rules.default_camera_pitch;
}

rules_populate() {
  rules = [];

  for(i = 300; i <= 310; i++) {
    ref = get_rule_ref_by_index(i);

    if(!isDefined(ref) || ref == "") {
      continue;
    }
    rule = spawnstruct();
    rule.idx = i;
    rule.ref = ref;
    rule.time = int(lookup_value(ref, i, 2));
    rule.player_helo = int(lookup_value(ref, i, 3));
    rule.player_vtol = int(lookup_value(ref, i, 4));
    rule.enemy_helo = int(lookup_value(ref, i, 5));
    rule.enemy_vtol = int(lookup_value(ref, i, 6));
    rule.delivery_refuel = int(lookup_value(ref, i, 7)) * 1000;
    rule.tact_clamp = int(lookup_value(ref, i, 8));
    heights = strtok(lookup_value(ref, i, 9), " ");
    rule.minplayerz = int(heights[0]);
    rule.maxplayerz = int(heights[1]);
    rule.zoom_avail = int(lookup_value(ref, i, 10));
    rule.camera_mode = lookup_value(ref, i, 11) == "look" ? 0 : 1;
    rule.default_camera_pitch = int(lookup_value(ref, i, 12));
    angles = strtok(lookup_value(ref, i, 13), " ");
    rule.camera_angle_offsets = (float(angles[0]), float(angles[1]), float(angles[2]));
    rule.num_nag_squads = int(lookup_value(ref, i, 14));
    reducers = strtok(lookup_value(ref, i, 15), " ");
    rule.ally_dmg_reducerfps = float(reducers[0]);

    if(rule.ally_dmg_reducerfps <= 0.0)
      rule.ally_dmg_reducerfps = 1.0;

    rule.ally_dmg_reducerrts = float(reducers[1]);

    if(rule.ally_dmg_reducerrts <= 0.0)
      rule.ally_dmg_reducerrts = 1.0;

    rule.player_dmg_reducerfps = float(lookup_value(ref, i, 16));

    if(rule.player_dmg_reducerfps <= 0.0)
      rule.player_dmg_reducerfps = 1.0;

    switch (getdifficulty()) {
      case "easy":
        rule.time = rule.time * 1;
        rule.ally_health_scale = 1.4;
        rule.axis_health_scale = 0.8;
        rule.ally_perfect_aimtime = 20;
        rule.player_switch_invultime = 7;
        rule.ally_dmg_reducerfps = rule.ally_dmg_reducerfps * 0.9;
        rule.ally_dmg_reducerrts = rule.ally_dmg_reducerrts * 0.9;
        rule.player_dmg_reducerfps = rule.player_dmg_reducerfps * 0.9;
        rule.enemy_helo = rule.enemy_helo - 1;

        if(rule.enemy_helo <= 0)
          rule.enemy_helo = 1;

        if(rule.enemy_vtol <= 0)
          rule.enemy_vtol = 2;

        rule.num_nag_squads--;
        break;
      case "medium":
        rule.ally_health_scale = 1.3;
        rule.axis_health_scale = 0.9;
        rule.ally_perfect_aimtime = 15;
        rule.player_switch_invultime = 7;
        rule.ally_dmg_reducerfps = rule.ally_dmg_reducerfps * 1;
        rule.ally_dmg_reducerrts = rule.ally_dmg_reducerrts * 1;
        rule.player_dmg_reducerfps = rule.player_dmg_reducerfps * 1;
        break;
      case "hard":
        rule.ally_health_scale = 1.3;
        rule.axis_health_scale = 1.0;
        rule.time = rule.time * 0.9;
        rule.ally_perfect_aimtime = 10;
        rule.player_switch_invultime = 5;
        rule.ally_dmg_reducerfps = rule.ally_dmg_reducerfps * 1.1;
        rule.ally_dmg_reducerrts = rule.ally_dmg_reducerrts * 1.1;
        rule.player_dmg_reducerfps = rule.player_dmg_reducerfps * 1.1;
        rule.enemy_helo = rule.enemy_helo + 1;
        rule.enemy_vtol = rule.enemy_vtol + 1;
        rule.num_nag_squads = rule.num_nag_squads + 1;
        break;
      case "fu":
        rule.ally_health_scale = 1.15;
        rule.axis_health_scale = 1.0;
        rule.time = rule.time * 0.8;
        rule.ally_perfect_aimtime = 7;
        rule.player_switch_invultime = 5;
        rule.ally_dmg_reducerfps = rule.ally_dmg_reducerfps * 1.2;
        rule.ally_dmg_reducerrts = rule.ally_dmg_reducerrts * 1.2;
        rule.player_dmg_reducerfps = rule.player_dmg_reducerfps * 1.2;
        rule.enemy_helo = rule.enemy_helo + 1;
        rule.enemy_vtol = rule.enemy_vtol + 2;
        rule.num_nag_squads = rule.num_nag_squads + 2;
        break;
    }

    if(rule.ally_dmg_reducerfps > 1.0)
      rule.ally_dmg_reducerfps = 1.0;

    if(rule.ally_dmg_reducerrts > 1.0)
      rule.ally_dmg_reducerrts = 1.0;

    if(rule.player_dmg_reducerfps > 1.0)
      rule.player_dmg_reducerfps = 1.0;

    rules[ref] = rule;
  }

  return rules;
}

initrules() {
  level.rts.game_rules = level.rts.rules[level.rts.game_mode];
  assert(isDefined(level.rts.game_rules));
  level.rts.transport_refuel_delay = 20000;

  if(isDefined(level.rts.game_rules.delivery_refuel))
    level.rts.transport_refuel_delay = level.rts.game_rules.delivery_refuel;
}

rules_setgametimer() {
  level.rts.game_rules.time_return_val = 0;

  if(isDefined(level.rts.game_rules.time) && level.rts.game_rules.time > 0) {
    flag_wait("rts_start_clock");
    level thread maps\_so_rts_support::time_countdown(level.rts.game_rules.time, level.rts.player, "kill_countdown", "rts_time_left", undefined, "SO_RTS_MISSION_TIME_REMAINING_CAPS", 1);
    level.rts.player waittill("expired");
    mission_complete(level.rts.game_rules.time_return_val);
  }
}

mission_complete(success, param) {
  level.rts.player setclientdvar("cg_aggressiveCullRadius", 0);
  level thread maps\_so_rts_squad::squad_hideallsquadmarkers();
  level notify("end_enemy_player");
  level thread battlechatter_off();
  level.rts.player stopshellshock();
  level.rts.player notify("empGrenadeShutOff");

  if(isDefined(level.rts.player.hud_damagefeedback))
    level.rts.player.hud_damagefeedback.alpha = 0;

  level.rts.end_time = gettime();
  level.rts.play_time = level.rts.end_time - level.rts.start_time;

  if(isDefined(level.rts.game_rules.time) && level.rts.game_rules.time > 0)
    level.rts.seconds_remaining = (level.rts.game_rules.time * 60000 - level.rts.play_time) / 1000;

  if(success) {
    if(getdvarint(#"_id_0F241E06") == 0)
      level.player thread maps\_endmission::strikeforce_increment_unit_tokens();
  }

  if(isDefined(level.custom_mission_complete)) {
    level thread[[level.custom_mission_complete]](success, param);
    return;
  }
}