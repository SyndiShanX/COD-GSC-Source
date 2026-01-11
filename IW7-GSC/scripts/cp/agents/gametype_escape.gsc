/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\agents\gametype_escape.gsc
*************************************************/

main() {
  scripts\cp\cp_globallogic::init();
  level thread onplayerconnect();
  init_callback_func();
  init_zombie_flags();
  init_zombie_fx();
  scripts\cp\cp_music_and_dialog::init();
  level.alien_combat_resources_table = "cp\alien\dpad_tree.csv";
  level.nodefiltertracestime = 0;
  level.nodefiltertracesthisframe = 0;
  level.wave_num = 0;
  level.laststand_currency_penalty_amount_func = ::zombie_laststand_currency_penalth_amount;
  level.disable_zombie_exo_abilities = 1;
  level.in_room_check_func = ::scripts\cp\zombies\zombies_spawning::is_in_any_room_volume;
  level.custom_giveloadout = ::scripts\cp\zombies\zombies_loadout::givedefaultloadout;
  level.move_speed_scale = ::scripts\cp\zombies\zombies_loadout::updatemovespeedscale;
  level.getnodearrayfunction = ::getnodearray;
  level.callbackplayerdamage = ::scripts\cp\zombies\zombie_damage::callback_zombieplayerdamage;
  level.prespawnfromspectaorfunc = ::zombie_prespawnfromspectatorfunc;
  level.update_money_performance = ::escape_update_money_performance;
  level.prematchfunc = ::default_zombie_prematch_func;
  level.no_power_cooldowns = 1;
  level.callbackplayerkilled = ::zombie_callbackplayerkilled;
  level.escape_timer_func = ::escape_timer;
  level.power_table = "cp\zombies\zombie_powertable.csv";
  level.statstable = "mp\statstable.csv";
  level.game_mode_statstable = "cp\zombies\mode_string_tables\zombies_statstable.csv";
  level.game_mode_attachment_map = "cp\zombies\zombie_attachmentmap.csv";
  level.active_volume_check = ::scripts\cp\loot::is_in_active_volume;
  scripts\cp\cp_weapon::weaponsinit();
  scripts\cp\utility::healthregeninit(0);
  if(!isDefined(level.powers)) {
    level.powers = [];
  }

  level.overcook_func = [];
  level.hardcoremode = getdvarint("scr_aliens_hardcore");
  level.ricochetdamage = getdvarint("scr_aliens_ricochet");
  level.casualmode = getdvarint("scr_aliens_casual");
  level.zombiedlclevel = 1;
  level.cycle_reward_scalar = 1;
  level.last_loot_drop = 0;
  level.last_powers_dropped = [];
  level.cash_scalar = 1;
  level.insta_kill = 0;
  scripts\cp\cp_outline::outline_init();
  level.pap_max = 5;
  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 0.2;
  level.maxlogclients = 10;
  level.escape_objective_notify = "objective_complete";
  parse_weapon_table();
  scripts\cp\zombies\zombie_afterlife_arcade::init_afterlife_arcade();
  scripts\cp\zombies\zombies_gamescore::init_zombie_scoring();
  scripts\cp\gametypes\zombie::precachelb();
  scripts\mp\mp_agent::init_agent("mp\default_agent_definition.csv");
  scripts\cp\agents\gametype_zombie::main();
  level scripts\cp\cp_hud_message::init();
  level.getspawnpoint = ::getescapespawnpoint;
  level thread scripts\cp\zombies\zombies_pillage::init_pillage_drops();
  dev_damage_show_damage_numbers();
  level thread escape_weapon_progression();
  level.power_up_table = "cp\zombies\escape_loot.csv";
  level.power_up_drop_override = 1;
  level.starting_currency = int(0);
  level.power_up_drop_score = level.starting_currency;
  level.powerup_drop_increment = 1000;
  level.powerup_drop_max_per_round = 2500;
  level.powerup_drop_count = 0;
  level.score_to_drop = level.powerup_drop_increment;
  level.var_76EC = 0;
  level thread scripts\cp\cp_interaction::coop_interaction_pregame();
  level thread scripts\cp\utility::global_physics_sound_monitor();
  level thread wave_num_loop();
  level thread scripts\cp\zombies\zombies_clientmatchdata::init();
}

escape_weapon_progression() {
  var_00 = 1;
  var_01 = level.weapon_progression[0];
  for(;;) {
    level waittill("objective_complete", var_02);
    var_03 = level.weapon_progression[var_00];
    thread spawn_next_weapon(var_03, var_02, var_01);
    level.default_weapon = var_03;
    if(var_00 < level.weapon_progression.size) {
      var_00++;
    }

    var_01 = var_03;
  }
}

spawn_next_weapon(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = scripts\engine\utility::getstructarray(param_01.target, "targetname");
  foreach(var_06 in var_04) {
    if(var_06.script_noteworthy == "waypoint_spot") {
      var_03 = var_06;
      break;
    }
  }

  var_08 = bulletTrace(var_03.origin, var_03.origin + (0, 0, -100), 0);
  var_03 = var_08["position"];
  var_09 = spawn("script_model", var_03 + (0, 0, 40));
  var_09 setModel(getweaponmodel(param_00));
  var_09.var_39C = param_00;
  var_09.oldweapon = param_02;
  var_09 thread wait_for_player_pickup();
  var_09 thread rotate_weapon_model();
  var_09.fx = spawnfx(level._effect["weapon_glow"], var_09.origin);
  wait(0.5);
  triggerfx(var_09.fx);
}

rotate_weapon_model() {
  self endon("death");
  for(;;) {
    self rotateyaw(360, 2);
    wait(2);
  }
}

wait_for_player_pickup() {
  var_00 = 0;
  for(;;) {
    foreach(var_02 in level.players) {
      if(var_02 hasweapon(self.var_39C)) {
        continue;
      }

      if(distancesquared(var_02.origin, self.origin) > 22500) {
        continue;
      } else {
        var_02 playlocalsound("zmb_powerup_activate");
        scripts\engine\utility::waitframe();
        var_02 thread give_player_next_weapon(var_02, self.var_39C, self.oldweapon);
        playFX(level._effect["weapon_pickup"], var_02.origin + (0, 0, 30));
        var_00++;
        if(level.players.size - var_00 == 0) {
          self.fx delete();
          self delete();
          return;
        }
      }

      wait(0.05);
    }

    wait(0.25);
  }
}

give_player_next_weapon(param_00, param_01, param_02) {
  while(param_00 ismeleeing()) {
    wait(0.2);
  }

  param_00 allowmelee(0);
  param_00 takeweapon(param_02);
  param_00 scripts\cp\utility::_giveweapon(param_01, undefined, undefined, 1);
  param_00 switchtoweapon(param_01);
  while(param_00 isswitchingweapon()) {
    wait(0.1);
  }

  param_00 givemaxammo(param_01);
  param_00 allowmelee(1);
}

waitforplayers() {
  while(!isDefined(level.players)) {
    wait(0.1);
  }
}

init_zombie_flags() {
  scripts\engine\utility::flag_init("insta_kill");
  scripts\engine\utility::flag_init("introscreen_over");
}

init_zombie_fx() {
  level._effect["alien_hive_explode"] = loadfx("vfx\core\expl\alien_hive_explosion");
  level._effect["goon_spawn_bolt"] = loadfx("vfx\iw7\_requests\coop\vfx_clown_spawn.vfx");
  level._effect["bloody_death"] = loadfx("vfx\core\base\vfx_tentacle_death_burst");
  level._effect["stun_attack"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_geotrail_tesla_01.vfx");
  level._effect["stun_shock"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_shock_flash.vfx");
  level._effect["weapon_glow"] = loadfx("vfx\iw7\_requests\coop\zmb_part_glow_green");
  level._effect["weapon_pickup"] = loadfx("vfx\iw7\core\zombie\powerups\vfx_zom_powerup_pickup.vfx");
}

parse_weapon_table() {
  level.weapon_progression = [];
  var_00 = "cp\escape_weapon_progression.csv";
  var_01 = 0;
  for(;;) {
    var_02 = randomintrange(1, 3);
    var_03 = tablelookupbyrow(var_00, var_01, var_02);
    if(var_03 == "") {
      break;
    }

    level.weapon_progression[var_01] = var_03;
    var_01++;
  }

  level.default_weapon = level.weapon_progression[0];
}

init_callback_func() {
  level.onstartgametype = ::zombie_onstartgametype;
  level.onspawnplayer = ::zombie_onspawnplayer;
  level.onprecachegametype = ::zombie_onprecachegametype;
}

zombie_onstartgametype() {
  scripts\cp\cp_persistence::register_eog_to_lb_playerdata_mapping();
  scripts\cp\cp_analytics::start_game_type("mp\zombieMatchdata.ddl", "mp\zombieclientmatchdata.ddl", "cp\zombies\zombie_analytics.csv");
  scripts\cp\cp_laststand::set_revive_time(3000, 5000);
  scripts\cp\cp_persistence::rank_init();
  level.damagelistsize = 20;
  scripts\cp\utility::alien_health_per_player_init();
  if(scripts\cp\utility::coop_mode_has("loot")) {
    scripts\cp\loot::init_loot();
  }

  if(scripts\cp\utility::coop_mode_has("pillage")) {
    thread scripts\cp\zombies\zombies_pillage::pillage_init();
  }

  level thread handle_nondeterministic_entities();
  level thread revive_players_between_waves_monitor();
  level scripts\engine\utility::delaythread(0.2, ::scripts\cp\zombies\zombie_entrances::init_zombie_entrances);
  level.xpscale = getdvarint("scr_aliens_xpscale");
  level.xpscale = min(level.xpscale, 4);
  level.xpscale = max(level.xpscale, 0);
  level.gamemode_perk_callback_init_func = ::scripts\cp\zombies\zombies_perk_machines::register_zombie_perks;
  scripts\cp\perks\perkmachines::init_zombie_perks_callback();
  scripts\cp\perks\perkmachines::init_perks_from_table();
  thread scripts\cp\zombies\zombies_consumables::init_consumables();
  scripts\cp\zombies\zombies_weapons::init();
  level thread scripts\cp\cp_interaction::init();
  scripts\cp\zombies\zombies_spawning::enemy_spawner_init();
  level thread scripts\cp\zombies\zombies_spawning::enemy_spawning_run();
  level thread escape_game_logic();
}

escape_game_logic() {
  escape_game_init();
  var_00 = 0;
  var_01 = 1;
  var_02 = 2;
  var_03 = 3;
  var_04 = 3;
  level thread escape_timer();
  var_05 = level.initial_active_volumes[0];
  var_06 = 0;
  for(;;) {
    scripts\engine\utility::flag_clear("score goal reached");
    var_07 = strtok(tablelookup(level.escape_table, var_00, var_06, var_01), " ");
    level.escape_score_goal = int(var_07[level.players.size - 1]);
    var_08 = tablelookup(level.escape_table, var_00, var_06, var_02);
    level.current_score_earned = 0;
    setomnvar("zom_escape_gate_score", level.escape_score_goal);
    if(level.escape_score_goal == 0) {
      break;
    }

    update_players_escape_hud();
    if(!isDefined(level.all_interaction_structs)) {
      wait(var_04);
    }

    var_09 = getent(var_08, "script_noteworthy");
    var_0A = make_waypoint_to_door(var_09);
    scripts\engine\utility::flag_wait("score goal reached");
    var_05 = var_08;
    var_0A destroy();
    open_current_door(var_09);
    level notify("next_area_opened", var_08);
    var_06++;
  }

  enable_escape_exit_interaction();
}

enable_escape_exit_interaction() {
  var_00 = [[level.get_escape_exit_interactions]]();
  var_01 = scripts\engine\utility::random(var_00);
  make_waypoint_on_escape_exit(var_01);
  var_02 = spawn("script_origin", var_01.origin);
  var_02 makeusable();
  var_02 sethintstring(&"CP_ZMB_INTERACTIONS_ESCAPE_THE_PARK");
  var_02 thread wait_for_escape_exit(var_01);
}

wait_for_escape_exit(param_00) {
  for(;;) {
    self waittill("trigger", var_01);
    if(isDefined(var_01.successfully_escaped)) {
      continue;
    }

    player_escape(param_00, var_01);
  }
}

escape_game_init() {
  scripts\engine\utility::flag_init("score goal reached");
}

update_players_escape_hud() {
  var_00 = level.current_score_earned / level.escape_score_goal;
  setomnvar("zom_escape_gate_percent", var_00);
  setomnvar("zom_escape_gate_score", level.escape_score_goal);
}

get_door_connecting_areas(param_00, param_01) {
  var_02 = -25536;
  var_03 = [];
  var_04 = [];
  var_05 = [];
  foreach(var_07 in level.all_interaction_structs) {
    if(isDefined(var_07.script_area) && isDefined(var_07.script_noteworthy) && var_07.script_noteworthy != "fast_travel") {
      if(var_07.script_area == param_00) {
        var_03[var_03.size] = var_07;
      }

      if(var_07.script_area == param_01) {
        var_04[var_04.size] = var_07;
      }
    }
  }

  foreach(var_0A in var_03) {
    foreach(var_0C in var_04) {
      if(distancesquared(var_0A.origin, var_0C.origin) > var_02) {
        continue;
      }

      if(isDefined(var_0A.script_noteworthy) && isDefined(var_0C.script_noteworthy) && var_0A.script_noteworthy == var_0C.script_noteworthy) {
        var_05[var_05.size] = var_0C;
      }
    }
  }

  return scripts\engine\utility::random(var_05);
}

make_waypoint_to_door(param_00) {
  var_01 = newhudelem();
  var_01 setshader("waypoint_blitz_goal", 8, 8);
  var_01 setwaypoint(1, 1);
  var_02 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  foreach(var_04 in var_02) {
    if(var_04.script_noteworthy == "waypoint_spot") {
      var_05 = spawn("script_origin", var_04.origin);
      scripts\engine\utility::waitframe();
      var_01 settargetent(var_05);
      return var_01;
    }
  }
}

make_waypoint_on_escape_exit(param_00) {
  var_01 = (0, 0, 45);
  var_02 = newhudelem();
  var_02 setshader("waypoint_blitz_goal", 8, 8);
  var_02 setwaypoint(1, 1);
  var_03 = spawn("script_origin", param_00.origin + var_01);
  var_02 settargetent(var_03);
}

open_current_door(param_00) {
  level notify("objective_complete", param_00);
  if(isDefined(level.current_exit_path)) {
    level.current_exit_path hide();
  }

  param_00 playSound("zmb_clear_barricade");
  var_01 = getEntArray(param_00.target, "targetname");
  playFX(level._effect["debris_buy"], param_00.origin);
  foreach(var_04, var_03 in param_00.panels) {
    var_03 thread move_up_and_delete(var_04);
  }

  level.var_76EC = level.var_76EC + 1;
  foreach(var_06 in level.players) {
    var_06 setclientomnvar("zombie_wave_number", level.var_76EC);
  }

  level.current_exit_path = getent(param_00.script_noteworthy + "_exit_path", "script_noteworthy");
  if(isDefined(level.current_exit_path)) {
    level.current_exit_path show();
    level.current_exit_path notsolid();
  }

  wait(1);
  param_00 connectpaths();
  param_00 delete();
}

move_up_and_delete(param_00) {
  self endon("death");
  wait(param_00 * 0.2);
  self movez(10, 0.5);
  self rotateto(self.angles + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(-10, 10)), 0.5);
  wait(0.5);
  self movez(1000, 3, 2, 1);
  wait(2);
  if(isDefined(self)) {
    self delete();
  }
}

escape_timer() {
  level endon("game_ended");
  level endon("update_escape_timer");
  if(!scripts\engine\utility::istrue(level.intro_shown)) {
    scripts\engine\utility::flag_wait("introscreen_over");
    iprintlnbold("Escape the park!");
    level.intro_shown = 1;
  }

  if(!isDefined(level.escape_timer_time)) {
    level.escape_timer_time = level.escape_time;
  }

  if(level.escape_timer_time != level.escape_time) {
    iprintlnbold("LEFTOVER TIME ADDED: " + level.escape_timer_time);
    level.escape_time = level.escape_time + level.escape_timer_time;
    level.escape_timer_time = int(level.escape_time);
  }

  level.escape_timer_time = int(level.escape_timer_time);
  var_00 = gettime() + level.escape_time * 1000;
  setomnvar("zm_ui_timer", int(var_00));
  while(gettime() < var_00) {
    wait(1);
    level.escape_timer_time--;
  }

  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

zombie_onprecachegametype() {}

zombie_onspawnplayer() {
  onspawnplayer();
  thread scripts\cp\zombies\zombies_vo::zombie_behind_vo();
}

handle_nondeterministic_entities() {
  wait(5);
  level notify("spawn_nondeterministic_entities");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    if(!isai(var_00)) {
      var_00 scripts\cp\cp_analytics::on_player_connect();
      if(isDefined(var_00.connecttime)) {
        var_00.connect_time = var_00.connecttime;
      } else {
        var_00.connect_time = gettime();
      }

      var_00 thread scripts\cp\cp_outline::outline_monitor_think();
      var_00 thread scripts\cp\cp_globallogic::player_init_health_regen();
      var_00 scripts\cp\cp_gamescore::init_player_score();
      var_00 scripts\cp\cp_persistence::session_stats_init();
      if(!isDefined(var_00.pap)) {
        var_00.pap = [];
      }

      if(!isDefined(var_00.powerupicons)) {
        var_00.powerupicons = [];
      }

      if(!isDefined(var_00.powers)) {
        var_00.powers = [];
      }

      if(!isDefined(var_00.powers_active)) {
        var_00.powers_active = [];
      }

      var_00 scripts\cp\zombies\zombies_consumables::init_player_consumables();
      var_00 thread zombie_player_connect_black_screen();
      var_00.disabledteleportation = 0;
      var_00.disabledinteractions = 0;
      var_00 scripts\cp\utility::allow_player_teleport(0);
      var_00.power_cooldowns = 0;
      var_00.tickets_earned = 0;
      var_00.self_revives_purchased = 0;
      var_00.ignorme_count = 0;
      if(scripts\engine\utility::flag("introscreen_over")) {
        if(isDefined(level.custom_player_hotjoin_func)) {
          var_00 thread[[level.custom_player_hotjoin_func]]();
        } else {
          var_00 thread player_hotjoin();
        }

        if(scripts\cp\cp_challenge::current_challenge_exist() && scripts\cp\utility::coop_mode_has("challenge")) {
          if(isDefined(level.challenge_hotjoin_func)) {
            var_00 thread[[level.challenge_hotjoin_func]]();
          }
        }
      }

      var_00 scripts\cp\zombies\zombie_afterlife_arcade::player_init_afterlife(var_00);
      var_00 scripts\cp\cp_persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
      if(isDefined(level.custom_onplayerconnect_func)) {
        [[level.custom_onplayerconnect_func]](var_00);
      }

      var_00 thread scripts\cp\zombies\escape_multiplier_combos::score_multiplier_init(var_00);
    }
  }
}

player_hotjoin() {
  self endon("disconnect");
  self notify("intro_done");
  self notify("stop_intro");
  self waittill("spawned");
  self.pers["hotjoined"] = 1;
  if(isDefined(self.introscreen_overlay)) {
    self.introscreen_overlay fadeovertime(1);
    wait(1);
    if(isDefined(self.introscreen_overlay)) {
      self.introscreen_overlay destroy();
    }
  }

  self setclientomnvar("ui_hide_hud", 0);
  self.reboarding_points = 0;
}

onspawnplayer() {
  self.pers["gamemodeLoadout"] = level.alien_loadout;
  self setclientomnvar("ui_refresh_hud", 1);
  self.drillspeedmodifier = 1;
  self.fireshield = 0;
  self.isreviving = 0;
  self.isrepairing = 0;
  self.iscarrying = 0;
  self.isboosted = undefined;
  self.ishealthboosted = undefined;
  self.burning = undefined;
  self.shocked = undefined;
  self.player_action_disabled = undefined;
  self.no_team_outlines = 0;
  self.no_outline = 0;
  self.disabledteleportation = 0;
  self.disabledinteractions = 0;
  self.can_teleport = 1;
  self.ignorme_count = 0;
  self.ignoreme = 0;
  self setclientomnvar("zm_ui_player_in_laststand", 0);
  thread scripts\cp\perks\perkfunctions::watchcombatspeedscaler();
  if(isDefined(level.custom_onspawnplayer_func)) {
    self[[level.custom_onspawnplayer_func]]();
  }

  scripts\cp\cp_globallogic::player_init_invulnerability();
  scripts\cp\cp_globallogic::player_init_damageshield();
  var_00 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var_00);
  set_player_max_currency(999999);
  thread melee_strength_timer();
  thread watchglproxy();
  thread scripts\cp\utility::playerhealthregen();
  thread scripts\cp\cp_hud_util::zom_player_health_overlay_watcher();
  thread scripts\cp\zombies\zombies_weapons::weapon_watch_hint();
  thread scripts\cp\powers\coop_powers::power_watch_hint();
  thread scripts\cp\zombies\zombies_weapons::axe_damage_cone();
  thread scripts\cp\zombies\zombies_weapons::reload_watcher();
}

get_starting_currency(param_00) {
  var_01 = param_00.starting_currency_after_revived_from_spectator;
  if(isDefined(var_01)) {
    param_00.starting_currency_after_revived_from_spectator = undefined;
    return var_01;
  }

  return scripts\cp\cp_persistence::get_starting_currency();
}

set_player_max_currency(param_00) {
  param_00 = int(param_00);
  self.maxcurrency = param_00;
}

replace_grenades_between_waves() {
  level endon("game_ended");
  foreach(var_01 in level.players) {
    replace_grenades_on_player(var_01);
  }
}

replace_grenades_on_player(param_00) {
  var_01 = getarraykeys(param_00.powers);
  foreach(var_03 in var_01) {
    if(param_00.powers[var_03].slot == "secondary") {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(param_00)) {
      param_00 thread wait_for_last_stand();
      continue;
    }

    param_00 thread recharge_power(var_03);
  }
}

wait_for_last_stand() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("spawned_player");
  wait(1);
  var_00 = getarraykeys(self.powers);
  if(var_00.size < 1) {
    return;
  }

  foreach(var_02 in var_00) {
    if(self.powers[var_02].slot == "secondary") {
      continue;
    }

    thread recharge_power(var_02);
  }
}

recharge_power(param_00) {
  var_01 = self.powers[param_00].slot;
  if(scripts\engine\utility::istrue(self.powers[param_00].var_19)) {
    while(scripts\engine\utility::istrue(self.powers[param_00].var_19)) {
      wait(0.05);
    }
  }

  if(scripts\engine\utility::istrue(self.powers[param_00].updating)) {
    while(scripts\engine\utility::istrue(self.powers[param_00].updating)) {
      wait(0.05);
    }
  }

  thread scripts\cp\powers\coop_powers::givepower(param_00, var_01, undefined, undefined, undefined, undefined, 1);
  if(scripts\engine\utility::istrue(level.secondary_power)) {
    scripts\cp\powers\coop_powers::power_modifycooldownrate(10, "secondary");
  }

  if(scripts\engine\utility::istrue(level.infinite_grenades)) {
    scripts\cp\powers\coop_powers::power_modifycooldownrate(100);
  }
}

revive_players_between_waves_monitor() {
  level endon("game_ended");
  for(;;) {
    level waittill("spawn_wave_done");
    foreach(var_01 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_01)) {
        scripts\cp\cp_laststand::instant_revive(var_01);
      }
    }

    level thread replace_grenades_between_waves();
  }
}

zombie_prespawnfromspectatorfunc(param_00) {
  param_00.starting_currency_after_revived_from_spectator = param_00 scripts\cp\cp_persistence::get_player_currency();
  scripts\cp\zombies\zombie_lost_and_found::save_items_to_lost_and_found(param_00);
  param_00 scripts\cp\zombies\zombies_perk_machines::remove_perks_from_player();
  revive_from_spectator_weapon_setup(param_00);
  set_spawn_loc(param_00);
  take_away_special_ammo(param_00);
  scripts\cp\zombies\zombie_afterlife_arcade::try_exit_afterlife_arcade(param_00);
}

revive_from_spectator_weapon_setup(param_00) {
  param_00 scripts\cp\utility::clear_weapons_status();
  var_01 = param_00.default_starting_pistol;
  var_02 = weaponclipsize(var_01);
  var_03 = weaponmaxammo(var_01);
  var_04 = [];
  var_05 = [];
  var_06 = [];
  var_04[var_04.size] = var_01;
  var_05[var_01] = var_02;
  var_06[var_01] = var_03;
  param_00 scripts\cp\utility::add_to_weapons_status(var_04, var_05, var_06, var_01);
  param_00.pre_laststand_weapon = var_01;
  param_00.pre_laststand_weapon_stock = var_03;
  param_00.pre_laststand_weapon_ammo_clip = var_02;
  param_00.lastweapon = var_01;
}

set_spawn_loc(param_00) {
  var_01 = zombie_get_player_respawn_loc(param_00);
  param_00.forcespawnorigin = var_01.origin;
  param_00.forcespawnangles = var_01.angles;
}

zombie_get_player_respawn_loc(param_00) {
  if(!isDefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0) {
    return [[level.getspawnpoint]]();
  }

  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  foreach(var_06 in level.players) {
    if(var_06 == param_00) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_06)) {
      continue;
    }

    var_01 = var_01 + var_06.origin[0];
    var_02 = var_02 + var_06.origin[1];
    var_03 = var_03 + var_06.origin[2];
    var_04++;
  }

  var_08 = (var_01 / var_04, var_02 / var_04, var_03 / var_04);
  var_09 = sortbydistance(level.active_player_respawn_locs, var_08);
  foreach(var_0B in var_09) {
    if(canspawn(var_0B.origin) && !positionwouldtelefrag(var_0B.origin)) {
      return var_0B;
    }
  }

  return var_09[0];
}

take_away_special_ammo(param_00) {
  param_00.special_ammo_type = undefined;
}

default_zombie_prematch_func() {
  var_00 = 0;
  if(!scripts\engine\utility::istrue(level.introscreen_done)) {
    var_00 = 10;
  }

  if(scripts\engine\utility::istrue(game["gamestarted"])) {
    var_00 = 0;
  }

  if(var_00 > 0) {
    var_01 = level wait_for_first_player_connect();
    level thread show_introscreen_text();
    if(isDefined(level.intro_dialogue_func)) {
      level thread[[level.intro_dialogue_func]]();
    }

    wait(var_00 - 3);
    if(isDefined(level.postintroscreenfunc)) {
      [
        [level.postintroscreenfunc]
      ]();
    }

    scripts\engine\utility::flag_set("introscreen_over");
    level.introscreen_done = 1;
  } else {
    wait(1);
    level.introscreen_done = 1;
    scripts\engine\utility::flag_set("introscreen_over");
  }

  if(scripts\engine\utility::istrue(level.preloadcinematicforall)) {
    return;
  }

  for(var_02 = 0; var_02 < level.players.size; var_02++) {
    level.players[var_02] scripts\cp\utility::freezecontrolswrapper(0);
    level.players[var_02] enableweapons();
    if(!isDefined(level.players[var_02].pers["team"])) {
      continue;
    }
  }
}

show_introscreen_text() {
  if(isDefined(level.introscreen_text_func)) {
    [[level.introscreen_text_func]]();
  }
}

wait_for_first_player_connect() {
  var_00 = undefined;
  if(level.players.size == 0) {
    level waittill("connected", var_00);
  } else {
    var_00 = level.players[0];
  }

  return var_00;
}

zombie_player_connect_black_screen() {
  self setclientomnvar("ui_hide_hud", 1);
  self endon("disconnect");
  self endon("stop_intro");
  self.introscreen_overlay = newclienthudelem(self);
  self.introscreen_overlay.x = 0;
  self.introscreen_overlay.y = 0;
  self.introscreen_overlay setshader("black", 640, 480);
  self.introscreen_overlay.alignx = "left";
  self.introscreen_overlay.aligny = "top";
  self.introscreen_overlay.sort = 1;
  self.introscreen_overlay.horzalign = "fullscreen";
  self.introscreen_overlay.vertalign = "fullscreen";
  self.introscreen_overlay.alpha = 1;
  self.introscreen_overlay.foreground = 1;
  if(!scripts\engine\utility::flag("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  self.introscreen_overlay fadeovertime(3);
  self.introscreen_overlay.alpha = 0;
  wait(3.5);
  self.introscreen_overlay destroy();
  self setclientomnvar("ui_hide_hud", 0);
  thread play_intro_gesture();
}

play_intro_gesture() {
  wait(0.5);
  wait(0.5);
}

melee_strength_timer() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("shock_melee_upgrade activated");
  self.meleestrength = 1;
  var_00 = 1;
  self.meleestrength = 0;
  var_01 = gettime();
  for(;;) {
    var_02 = gettime();
    if(var_02 - var_01 >= level.playermeleestunregentime) {
      self.meleestrength = 1;
    } else {
      self.meleestrength = 0;
    }

    if(self meleebuttonpressed() && !self getteamsize() && !self usebuttonpressed()) {
      var_01 = gettime();
      if(var_00 == 1) {
        var_00 = 0;
      }
    } else if(!self meleebuttonpressed()) {
      var_00 = 1;
    } else {
      var_00 = 0;
    }

    wait(0.05);
  }
}

hasgl3weapon() {
  var_00 = 0;
  var_01 = self getweaponslist("primary");
  if(var_01.size > 0) {
    foreach(var_03 in var_01) {
      if(isgl3weapon(var_03)) {
        var_00 = 1;
        break;
      }
    }
  }

  return var_00;
}

isgl3weapon(param_00) {
  var_01 = getweaponbasename(param_00);
  if(!isDefined(var_01)) {
    return 0;
  }

  return param_00 == "iw7_glprox_zm";
}

watchglproxy() {
  self endon("death");
  self endon("disconnect");
  self endon("endExpJump");
  level endon("game_ended");
  var_00 = undefined;
  self notifyonplayercommand("fired", "+attack");
  for(;;) {
    scripts\engine\utility::waittill_any_3("weapon_switch_started", "weapon_change", "weaponchange");
    self notify("stop_regen_on_weapons");
    wait(0.1);
    var_01 = self getweaponslistall();
    foreach(var_03 in var_01) {
      if(isgl3weapon(var_03)) {
        thread regen_ammo_for_weapon(var_03);
        var_00 = 1;
        continue;
      }

      var_00 = 0;
    }
  }
}

regen_ammo_for_weapon(param_00) {
  self endon("stop_regen_on_weapons");
  self endon("disconnect");
  level endon("game_ended");
  var_01 = 3;
  var_02 = 4;
  for(;;) {
    var_03 = self getweaponammoclip(param_00);
    while(var_03 <= var_01) {
      var_03 = self getweaponammoclip(param_00);
      self setweaponammoclip(param_00, var_03 + 1);
      wait(var_02);
    }

    wait(var_02);
  }
}

zombie_laststand_currency_penalth_amount(param_00) {
  var_01 = param_00 scripts\cp\cp_persistence::get_player_currency();
  var_01 = var_01 * 0.05;
  var_01 = int(var_01 / 10) * 10;
  return var_01;
}

zombie_callbackplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  [[level.callbackplayerlaststand]](param_00, param_01, param_02, param_04, param_05, param_07, param_08, param_09);
  scripts\cp\zombies\zombies_clientmatchdata::logplayerdeath();
}

dev_damage_show_damage_numbers() {
  if(getdvarint("zm_damage_numbers", 0) == 1) {
    setomnvar("zm_dev_damage", 1);
    return;
  }

  setomnvar("zm_dev_damage", 0);
}

precachelb() {
  var_00 = " LB_" + getdvar("ui_mapname");
  if(scripts\cp\utility::isplayingsolo()) {
    var_00 = var_00 + "_SOLO";
  } else {
    var_00 = var_00 + "_COOP";
  }

  precacheleaderboards(var_00);
}

getescapespawnpoint() {
  return scripts\cp\cp_globallogic::getassignedspawnpoint(scripts\engine\utility::getstructarray("escape_player_start", "targetname"));
}

setup_escape_hud(param_00) {
  var_01 = 40;
  var_02 = 200;
  var_03 = 10;
  var_04 = 15;
  param_00.score_progress_bar = scripts\cp\utility::createprimaryprogressbar(0, 0, var_02, var_03);
  param_00.score_progress_bar scripts\cp\utility::setpoint("center", "center", 0, var_01);
  param_00.current_score = scripts\cp\utility::createfontstring("objective", 1);
  param_00.current_score scripts\cp\utility::setpoint("center", "center", var_02 / 2 * -1, var_01 + var_04);
  param_00.score_goal = scripts\cp\utility::createfontstring("objective", 1);
  param_00.score_goal scripts\cp\utility::setpoint("center", "center", var_02 / 2, var_01 + var_04);
  set_current_score_value(param_00, 0);
  set_score_goal_value(param_00, level.escape_score_goal);
}

set_current_score_value(param_00, param_01) {
  param_00.current_score setvalue(param_01);
}

set_score_goal_value(param_00, param_01) {
  param_00.score_goal setvalue(param_01);
}

set_score_progress_bar_scale(param_00, param_01) {
  param_00.score_progress_bar scripts\cp\utility::updatebarscale(param_01);
}

update_current_score(param_00, param_01) {
  if(level.escape_score_goal == 0) {
    var_02 = 0;
  } else {
    var_02 = var_02 / level.escape_score_goal;
  }

  setomnvar("zom_escape_gate_percent", var_02);
}

escape_update_money_performance(param_00, param_01) {
  param_00 thread update_current_money_earned(param_00, param_01);
}

update_current_money_earned(param_00, param_01) {
  wait(0.1);
  level.current_score_earned = int(min(level.current_score_earned + param_01 * level.combo_multiplier, level.escape_score_goal));
  update_current_score(param_00, level.current_score_earned);
  if(level.current_score_earned >= level.escape_score_goal) {
    scripts\engine\utility::flag_set("score goal reached");
  }

  scripts\cp\zombies\zombies_gamescore::update_money_earned_performance(param_00, param_01);
}

wave_num_loop() {
  level endon("game_ended");
  level.wave_num = 1;
  scripts\engine\utility::flag_wait("introscreen_over");
}

wave_num_timer_loop() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("introscreen_over");
  for(;;) {
    wait(30);
    level notify("escape_start_next_wave");
  }
}

player_escape(param_00, param_01) {
  var_02 = "player_after_escape_pos";
  param_01 iprintlnbold("You successfully escaped from the park!");
  var_03 = scripts\engine\utility::getstructarray(var_02, "targetname")[0];
  param_01 setorigin(var_03.origin);
  param_01.successfully_escaped = 1;
  test_win_condition(param_01);
}

test_win_condition(param_00) {
  foreach(param_00 in level.players) {
    if(!scripts\engine\utility::istrue(param_00.successfully_escaped)) {
      return;
    }
  }

  level thread[[level.endgame]]("ally", level.end_game_string_index["all_escape"]);
}