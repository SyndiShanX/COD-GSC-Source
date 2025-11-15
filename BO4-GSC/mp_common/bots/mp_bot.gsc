/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\bots\mp_bot.gsc
***********************************************/

#include scripts\core_common\ai\region_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_role;
#include scripts\core_common\rank_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\emp_shared;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\mp_common\ai\planner_mp_control_commander;
#include scripts\mp_common\ai\planner_mp_control_squad;
#include scripts\mp_common\ai\planner_mp_dom_commander;
#include scripts\mp_common\ai\planner_mp_dom_squad;
#include scripts\mp_common\ai\planner_mp_koth_commander;
#include scripts\mp_common\ai\planner_mp_koth_squad;
#include scripts\mp_common\ai\planner_mp_sd_commander;
#include scripts\mp_common\ai\planner_mp_sd_squad;
#include scripts\mp_common\ai\planner_mp_tdm_commander;
#include scripts\mp_common\ai\planner_mp_tdm_squad;
#include scripts\mp_common\bots\mp_bot_action;
#include scripts\mp_common\bots\mp_bot_position;
#include scripts\mp_common\draft;

#namespace bot;

autoexec __init__system__() {
  system::register(#"bot_mp", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&init);
  level.onbotconnect = &on_bot_connect;
  level.onbotspawned = &on_bot_spawned;
  level.onbotkilled = &on_bot_killed;
  level.var_73ec5517 = [];
  level.var_73ec5517[#"primaryweapon"] = array("ar_accurate_t8", "ar_fastfire_t8", "ar_damage_t8", "ar_stealth_t8", "ar_modular_t8", "smg_standard_t8", "smg_handling_t8", "smg_fastfire_t8", "smg_capacity_t8", "smg_accurate_t8", "tr_powersemi_t8", "tr_longburst_t8", "tr_midburst_t8", "lmg_heavy_t8", "lmg_spray_t8", "lmg_standard_t8", "sniper_fastrechamber_t8", "sniper_powerbolt_t8", "sniper_powersemi_t8", "sniper_quickscope_t8");
  level.var_73ec5517[#"secondaryweapon"] = array("pistol_burst_t8", "pistol_revolver_t8", "pistol_standard_t8", "shotgun_pump_t8", "shotgun_semiauto_t8", "launcher_standard_t8");
  level.var_73ec5517[#"perk1"] = array("talent_scavenger", "talent_engineer", "talent_flakjacket", "talent_resistance");
  level.var_73ec5517[#"perk2"] = array("talent_lightweight", "talent_skulker", "talent_coldblooded", "talent_gungho", "talent_dexterity");
  level.var_73ec5517[#"perk3"] = array("talent_ghost", "talent_teamlink", "talent_deadsilence", "talent_tracker");
  level.var_73ec5517[#"gear"] = array("gear_equipmentcharge", "gear_medicalinjectiongun", "gear_scorestreakcharge", "gear_armor", "gear_awareness");
  level.var_73ec5517[#"equipment"] = array("trophy_system", "hatchet", "frag_grenade", "eq_molotov", "eq_slow_grenade");
  level.var_73ec5517[#"scorestreak"] = array("ac130", "ai_tank_marker", "counteruav", "drone_squadron", "helicopter_comlink", "planemortar", "recon_car", "remote_missile", "straferun", "supplydrop_marker", "swat_team", "uav", "ultimate_turret");

  if(!isDefined(level.var_df0a0911)) {
    if(util::function_8570168d()) {
      level.var_df0a0911 = "bot_tacstate_mp_default";
      return;
    }

    switch (getdvarint(#"bot_difficulty", 1)) {
      case 0:
        level.var_df0a0911 = "bot_tacstate_mp_easy";
        break;
      case 1:
      default:
        level.var_df0a0911 = "bot_tacstate_mp_normal";
        break;
      case 2:
        level.var_df0a0911 = "bot_tacstate_mp_hard";
        break;
      case 3:
        level.var_df0a0911 = "bot_tacstate_mp_veteran";
        break;
    }
  }
}

init() {
  level endon(#"game_ended");
  level thread init_strategic_command();
  botsoak = getdvarint(#"sv_botsoak", 0);

  if(!isdedicated()) {
    if(level.rankedmatch) {
      return;
    }
  }

  if(!botsoak) {
    level flag::wait_till("all_players_connected");
  }

  level thread populate_bots();
  level thread region_utility::function_755c26d1();
}

init_strategic_command() {
  if(level.var_fa5cacde) {
    return;
  }

  if(!isDefined(level.gametype) || !isDefined(level.teams)) {
    return;
  }

  switch (level.gametype) {
    case #"control":
    case #"control_hc":
    case #"control_cwl":
      foreach(team in level.teams) {
        plannermpcontrolcommander::createcommander(team);
      }

      break;
    case #"dom_cwl":
    case #"dom_hc":
    case #"dom":
      foreach(team in level.teams) {
        plannermpdomcommander::createcommander(team);
      }

      break;
    case #"koth":
    case #"koth_cwl":
    case #"koth_hc":
      foreach(team in level.teams) {
        plannermpkothcommander::createcommander(team);
      }

      break;
    case #"sd":
    case #"sd_cwl":
    case #"sd_hc":
      foreach(team in level.teams) {
        plannermpsdcommander::createcommander(team);
      }

      break;
    default:
      foreach(team in level.teams) {
        plannermptdmcommander::createcommander(team);
      }

      break;
  }
}

on_bot_connect() {
  self endon(#"disconnect");
  level endon(#"game_ended");

  if(!isDefined(level.givecustomloadout)) {
    self function_1b0af429();
  }

  var_31e3b231 = 0;

  if(isDefined(self.var_29b433bd)) {
    var_31e3b231 = !player_role::is_valid(self.var_29b433bd);
  } else {
    var_31e3b231 = !player_role::is_valid(self player_role::get());
  }

  if(draft::is_enabled() && isDefined(level.var_5be52892) && !level.var_5be52892 && game.state !== "playing") {
    var_31e3b231 = 0;
  }

  if(var_31e3b231) {
    self player_role::clear();
    draft::assign_remaining_players(self);
  }

  self set_rank();
}

function_1b0af429() {
  self function_a6720fe8(0);
  var_dc111f5 = 0;
  var_1bb1502d = [];
  var_1bb1502d[#"primaryweapon"] = array::random(level.var_73ec5517[#"primaryweapon"]);

  function_165d8cc2("<dev string:x38>", var_1bb1502d[#"primaryweapon"]);

    self botclassadditem(0, var_1bb1502d[#"primaryweapon"]);
  var_dc111f5++;
  attachments = getrandomcompatibleattachmentsforweapon(getweapon(var_1bb1502d[#"primaryweapon"]), 3);

  for(i = 0; i < attachments.size; i++) {
    if(attachments[i] == "uber" && attachments.size == 3) {
      for(j = 0; j < attachments.size; j++) {
        if(attachments[j] != "uber") {
          attachments[j] = attachments[attachments.size - 1];
          attachments[attachments.size - 1] = undefined;
          break;
        }
      }
    }
  }

  for(i = 0; i < attachments.size; i++) {
    if(isDefined(attachments[i])) {
      name = "primaryAttachment" + i + 1;
      var_1bb1502d[name] = attachments[i];
      self botclassaddattachment(0, var_1bb1502d[#"primaryweapon"], var_1bb1502d[name], name);
      var_dc111f5++;

      if(var_1bb1502d[name] == "uber") {
        var_dc111f5++;
      }
    }
  }

  var_1bb1502d[#"perk1"] = array::random(level.var_73ec5517[#"perk1"]);
  self botclassadditem(0, var_1bb1502d[#"perk1"]);
  var_dc111f5++;
  var_1bb1502d[#"perk2"] = array::random(level.var_73ec5517[#"perk2"]);
  self botclassadditem(0, var_1bb1502d[#"perk2"]);
  var_dc111f5++;
  var_1bb1502d[#"perk3"] = array::random(level.var_73ec5517[#"perk3"]);
  self botclassadditem(0, var_1bb1502d[#"perk3"]);
  var_dc111f5++;
  var_1bb1502d[#"gear"] = array::random(level.var_73ec5517[#"gear"]);
  self botclassadditem(0, var_1bb1502d[#"gear"]);
  var_dc111f5++;
  var_10edbe6e = randomfloat(1) < 0.25;

  if(var_10edbe6e && !getdvarint(#"hash_a0eb031e81f4f2f", 0)) {
    var_1bb1502d[#"equipment"] = array::random(level.var_73ec5517[#"equipment"]);
    self botclassadditem(0, var_1bb1502d[#"equipment"]);
    var_dc111f5++;
  } else {
    var_1bb1502d[#"equipment"] = "default_specialist_equipment";
    self botclassadditem(0, var_1bb1502d[#"equipment"]);
  }

  var_1bb1502d[#"secondaryweapon"] = array::random(level.var_73ec5517[#"secondaryweapon"]);

  function_165d8cc2("<dev string:x48>", var_1bb1502d[#"secondaryweapon"]);

    self botclassadditem(0, var_1bb1502d[#"secondaryweapon"]);
  var_dc111f5++;
  var_4540e733 = 10 - var_dc111f5;

  if(var_4540e733 > 0) {
    attachments = getrandomcompatibleattachmentsforweapon(getweapon(var_1bb1502d[#"secondaryweapon"]), var_4540e733);

    for(i = 0; i < attachments.size; i++) {
      attachtag = "secondaryAttachment" + i + 1;
      var_1bb1502d[attachtag] = attachments[i];
      self botclassaddattachment(0, var_1bb1502d[#"secondaryweapon"], var_1bb1502d[attachtag], attachtag);
      var_dc111f5++;
    }
  }

  var_2caaa943 = array::randomize(level.var_73ec5517[#"scorestreak"]);
  var_1bb1502d[#"scorestreak1"] = var_2caaa943[0];
  self botclassadditem(0, var_1bb1502d[#"scorestreak1"]);
  var_1bb1502d[#"scorestreak2"] = var_2caaa943[1];
  self botclassadditem(0, var_1bb1502d[#"scorestreak2"]);
  var_1bb1502d[#"scorestreak3"] = var_2caaa943[2];
  self botclassadditem(0, var_1bb1502d[#"scorestreak3"]);
}

function_165d8cc2(var_2faf31e0, loadoutitem) {
  if(var_2faf31e0 == "<dev string:x38>" || var_2faf31e0 == "<dev string:x48>") {
    bot_action::function_36052a7f(loadoutitem);
  }
}

  function on_bot_spawned() {
    if(isDefined(level.var_b8d30546) && level.var_b8d30546) {
      self ai::set_behavior_attribute("allowprimaryoffhand", 0);
      self ai::set_behavior_attribute("allowspecialoffhand", 0);
    }
  }

on_bot_killed() {
  self endon(#"disconnect");
  level endon(#"game_ended");
  self endon(#"spawned");
  self waittill(#"death_delay_finished");
  wait 0.1;

  if(level.playerforcerespawn) {
    return;
  }

  self thread respawn();
}

respawn() {
  self endon(#"spawned", #"disconnect");
  level endon(#"game_ended");

  while(true) {
    self bottapbutton(3);
    wait 0.1;
  }
}

use_killstreak() {
  if(!level.loadoutkillstreaksenabled || self emp::enemyempactive()) {
    return;
  }

  weapons = self getweaponslist();
  inventoryweapon = self getinventoryweapon();

  foreach(weapon in weapons) {
    killstreak = killstreaks::get_killstreak_for_weapon(weapon);

    if(!isDefined(killstreak)) {
      continue;
    }

    if(weapon != inventoryweapon && !self getweaponammoclip(weapon)) {
      continue;
    }

    if(self killstreakrules::iskillstreakallowed(killstreak, self.team)) {
      useweapon = weapon;
      break;
    }
  }

  if(!isDefined(useweapon)) {
    return;
  }

  killstreak_ref = killstreaks::get_menu_name(killstreak);

  switch (killstreak_ref) {
    case #"killstreak_helicopter_player_gunner":
    case #"killstreak_uav":
    case #"killstreak_satellite":
    case #"killstreak_sentinel":
    case #"killstreak_counteruav":
    case #"killstreak_raps":
      self switchtoweapon(useweapon);
      break;
  }
}

set_rank() {
  players = getplayers();
  ranks = [];
  bot_ranks = [];
  human_ranks = [];

  for(i = 0; i < players.size; i++) {
    if(players[i] == self) {
      continue;
    }

    if(isDefined(players[i].pers[#"rank"])) {
      if(isbot(players[i])) {
        bot_ranks[bot_ranks.size] = players[i].pers[#"rank"];
        continue;
      }

      human_ranks[human_ranks.size] = players[i].pers[#"rank"];
    }
  }

  if(!human_ranks.size) {
    human_ranks[human_ranks.size] = 10;
  }

  human_avg = math::array_average(human_ranks);

  while(bot_ranks.size + human_ranks.size < 5) {
    r = human_avg + randomintrange(-5, 5);
    rank = math::clamp(r, 0, level.maxrank);
    human_ranks[human_ranks.size] = rank;
  }

  ranks = arraycombine(human_ranks, bot_ranks, 1, 0);
  avg = math::array_average(ranks);
  s = math::array_std_deviation(ranks, avg);
  rank = int(math::random_normal_distribution(avg, s, 0, level.maxrank));

  while(!isDefined(self.pers[#"rank"])) {
    wait 0.1;
  }

  self.pers[#"rank"] = rank;
  self.pers[#"rankxp"] = rank::getrankinfominxp(rank);
  self setrank(rank);
}