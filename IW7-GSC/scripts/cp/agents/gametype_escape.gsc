/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  level.in_room_check_func = scripts\cp\zombies\zombies_spawning::is_in_any_room_volume;
  level.custom_giveloadout = scripts\cp\zombies\zombies_loadout::givedefaultloadout;
  level.move_speed_scale = scripts\cp\zombies\zombies_loadout::updatemovespeedscale;
  level.getnodearrayfunction = ::getnodearray;
  level.callbackplayerdamage = scripts\cp\zombies\zombie_damage::callback_zombieplayerdamage;
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
  level.active_volume_check = scripts\cp\loot::is_in_active_volume;
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
  var_0 = 1;
  var_1 = level.weapon_progression[0];
  for(;;) {
    level waittill("objective_complete", var_2);
    var_3 = level.weapon_progression[var_0];
    thread spawn_next_weapon(var_3, var_2, var_1);
    level.default_weapon = var_3;
    if(var_0 < level.weapon_progression.size) {
      var_0++;
    }

    var_1 = var_3;
  }
}

spawn_next_weapon(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = scripts\engine\utility::getstructarray(var_1.target, "targetname");
  foreach(var_6 in var_4) {
    if(var_6.script_noteworthy == "waypoint_spot") {
      var_3 = var_6;
      break;
    }
  }

  var_8 = bulletTrace(var_3.origin, var_3.origin + (0, 0, -100), 0);
  var_3 = var_8["position"];
  var_9 = spawn("script_model", var_3 + (0, 0, 40));
  var_9 setModel(getweaponmodel(var_0));
  var_9.var_39C = var_0;
  var_9.oldweapon = var_2;
  var_9 thread wait_for_player_pickup();
  var_9 thread rotate_weapon_model();
  var_9.fx = spawnfx(level._effect["weapon_glow"], var_9.origin);
  wait(0.5);
  triggerfx(var_9.fx);
}

rotate_weapon_model() {
  self endon("death");
  for(;;) {
    self rotateyaw(360, 2);
    wait(2);
  }
}

wait_for_player_pickup() {
  var_0 = 0;
  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 hasweapon(self.var_39C)) {
        continue;
      }

      if(distancesquared(var_2.origin, self.origin) > 22500) {
        continue;
      } else {
        var_2 playlocalsound("zmb_powerup_activate");
        scripts\engine\utility::waitframe();
        var_2 thread give_player_next_weapon(var_2, self.var_39C, self.oldweapon);
        playFX(level._effect["weapon_pickup"], var_2.origin + (0, 0, 30));
        var_0++;
        if(level.players.size - var_0 == 0) {
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

give_player_next_weapon(var_0, var_1, var_2) {
  while(var_0 ismeleeing()) {
    wait(0.2);
  }

  var_0 allowmelee(0);
  var_0 takeweapon(var_2);
  var_0 scripts\cp\utility::_giveweapon(var_1, undefined, undefined, 1);
  var_0 switchtoweapon(var_1);
  while(var_0 isswitchingweapon()) {
    wait(0.1);
  }

  var_0 givemaxammo(var_1);
  var_0 allowmelee(1);
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
  var_0 = "cp\escape_weapon_progression.csv";
  var_1 = 0;
  for(;;) {
    var_2 = randomintrange(1, 3);
    var_3 = tablelookupbyrow(var_0, var_1, var_2);
    if(var_3 == "") {
      break;
    }

    level.weapon_progression[var_1] = var_3;
    var_1++;
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
  level scripts\engine\utility::delaythread(0.2, scripts\cp\zombies\zombie_entrances::init_zombie_entrances);
  level.xpscale = getdvarint("scr_aliens_xpscale");
  level.xpscale = min(level.xpscale, 4);
  level.xpscale = max(level.xpscale, 0);
  level.gamemode_perk_callback_init_func = scripts\cp\zombies\zombies_perk_machines::register_zombie_perks;
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
  var_0 = 0;
  var_1 = 1;
  var_2 = 2;
  var_3 = 3;
  var_4 = 3;
  level thread escape_timer();
  var_5 = level.initial_active_volumes[0];
  var_6 = 0;
  for(;;) {
    scripts\engine\utility::flag_clear("score goal reached");
    var_7 = strtok(tablelookup(level.escape_table, var_0, var_6, var_1), " ");
    level.escape_score_goal = int(var_7[level.players.size - 1]);
    var_8 = tablelookup(level.escape_table, var_0, var_6, var_2);
    level.current_score_earned = 0;
    setomnvar("zom_escape_gate_score", level.escape_score_goal);
    if(level.escape_score_goal == 0) {
      break;
    }

    update_players_escape_hud();
    if(!isDefined(level.all_interaction_structs)) {
      wait(var_4);
    }

    var_9 = getent(var_8, "script_noteworthy");
    var_10 = make_waypoint_to_door(var_9);
    scripts\engine\utility::flag_wait("score goal reached");
    var_5 = var_8;
    var_10 destroy();
    open_current_door(var_9);
    level notify("next_area_opened", var_8);
    var_6++;
  }

  enable_escape_exit_interaction();
}

enable_escape_exit_interaction() {
  var_0 = [[level.get_escape_exit_interactions]]();
  var_1 = scripts\engine\utility::random(var_0);
  make_waypoint_on_escape_exit(var_1);
  var_2 = spawn("script_origin", var_1.origin);
  var_2 makeusable();
  var_2 sethintstring(&"CP_ZMB_INTERACTIONS_ESCAPE_THE_PARK");
  var_2 thread wait_for_escape_exit(var_1);
}

wait_for_escape_exit(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    if(isDefined(var_1.successfully_escaped)) {
      continue;
    }

    player_escape(var_0, var_1);
  }
}

escape_game_init() {
  scripts\engine\utility::flag_init("score goal reached");
}

update_players_escape_hud() {
  var_0 = level.current_score_earned / level.escape_score_goal;
  setomnvar("zom_escape_gate_percent", var_0);
  setomnvar("zom_escape_gate_score", level.escape_score_goal);
}

get_door_connecting_areas(var_0, var_1) {
  var_2 = -25536;
  var_3 = [];
  var_4 = [];
  var_5 = [];
  foreach(var_7 in level.all_interaction_structs) {
    if(isDefined(var_7.script_area) && isDefined(var_7.script_noteworthy) && var_7.script_noteworthy != "fast_travel") {
      if(var_7.script_area == var_0) {
        var_3[var_3.size] = var_7;
      }

      if(var_7.script_area == var_1) {
        var_4[var_4.size] = var_7;
      }
    }
  }

  foreach(var_10 in var_3) {
    foreach(var_12 in var_4) {
      if(distancesquared(var_10.origin, var_12.origin) > var_2) {
        continue;
      }

      if(isDefined(var_10.script_noteworthy) && isDefined(var_12.script_noteworthy) && var_10.script_noteworthy == var_12.script_noteworthy) {
        var_5[var_5.size] = var_12;
      }
    }
  }

  return scripts\engine\utility::random(var_5);
}

make_waypoint_to_door(var_0) {
  var_1 = newhudelem();
  var_1 setshader("waypoint_blitz_goal", 8, 8);
  var_1 setwaypoint(1, 1);
  var_2 = scripts\engine\utility::getstructarray(var_0.target, "targetname");
  foreach(var_4 in var_2) {
    if(var_4.script_noteworthy == "waypoint_spot") {
      var_5 = spawn("script_origin", var_4.origin);
      scripts\engine\utility::waitframe();
      var_1 settargetent(var_5);
      return var_1;
    }
  }
}

make_waypoint_on_escape_exit(var_0) {
  var_1 = (0, 0, 45);
  var_2 = newhudelem();
  var_2 setshader("waypoint_blitz_goal", 8, 8);
  var_2 setwaypoint(1, 1);
  var_3 = spawn("script_origin", var_0.origin + var_1);
  var_2 settargetent(var_3);
}

open_current_door(var_0) {
  level notify("objective_complete", var_0);
  if(isDefined(level.current_exit_path)) {
    level.current_exit_path hide();
  }

  var_0 playSound("zmb_clear_barricade");
  var_1 = getEntArray(var_0.target, "targetname");
  playFX(level._effect["debris_buy"], var_0.origin);
  foreach(var_4, var_3 in var_0.panels) {
    var_3 thread move_up_and_delete(var_4);
  }

  level.var_76EC = level.var_76EC + 1;
  foreach(var_6 in level.players) {
    var_6 setclientomnvar("zombie_wave_number", level.var_76EC);
  }

  level.current_exit_path = getent(var_0.script_noteworthy + "_exit_path", "script_noteworthy");
  if(isDefined(level.current_exit_path)) {
    level.current_exit_path show();
    level.current_exit_path notsolid();
  }

  wait(1);
  var_0 connectpaths();
  var_0 delete();
}

move_up_and_delete(var_0) {
  self endon("death");
  wait(var_0 * 0.2);
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
  var_0 = gettime() + level.escape_time * 1000;
  setomnvar("zm_ui_timer", int(var_0));
  while(gettime() < var_0) {
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
    level waittill("connected", var_0);
    if(!isai(var_0)) {
      var_0 scripts\cp\cp_analytics::on_player_connect();
      if(isDefined(var_0.connecttime)) {
        var_0.connect_time = var_0.connecttime;
      } else {
        var_0.connect_time = gettime();
      }

      var_0 thread scripts\cp\cp_outline::outline_monitor_think();
      var_0 thread scripts\cp\cp_globallogic::player_init_health_regen();
      var_0 scripts\cp\cp_gamescore::init_player_score();
      var_0 scripts\cp\cp_persistence::session_stats_init();
      if(!isDefined(var_0.pap)) {
        var_0.pap = [];
      }

      if(!isDefined(var_0.powerupicons)) {
        var_0.powerupicons = [];
      }

      if(!isDefined(var_0.powers)) {
        var_0.powers = [];
      }

      if(!isDefined(var_0.powers_active)) {
        var_0.powers_active = [];
      }

      var_0 scripts\cp\zombies\zombies_consumables::init_player_consumables();
      var_0 thread zombie_player_connect_black_screen();
      var_0.disabledteleportation = 0;
      var_0.disabledinteractions = 0;
      var_0 scripts\cp\utility::allow_player_teleport(0);
      var_0.power_cooldowns = 0;
      var_0.tickets_earned = 0;
      var_0.self_revives_purchased = 0;
      var_0.ignorme_count = 0;
      if(scripts\engine\utility::flag("introscreen_over")) {
        if(isDefined(level.custom_player_hotjoin_func)) {
          var_0 thread[[level.custom_player_hotjoin_func]]();
        } else {
          var_0 thread player_hotjoin();
        }

        if(scripts\cp\cp_challenge::current_challenge_exist() && scripts\cp\utility::coop_mode_has("challenge")) {
          if(isDefined(level.challenge_hotjoin_func)) {
            var_0 thread[[level.challenge_hotjoin_func]]();
          }
        }
      }

      var_0 scripts\cp\zombies\zombie_afterlife_arcade::player_init_afterlife(var_0);
      var_0 scripts\cp\cp_persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
      if(isDefined(level.custom_onplayerconnect_func)) {
        [[level.custom_onplayerconnect_func]](var_0);
      }

      var_0 thread scripts\cp\zombies\escape_multiplier_combos::score_multiplier_init(var_0);
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
  var_0 = get_starting_currency(self);
  thread scripts\cp\cp_persistence::wait_to_set_player_currency(var_0);
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

get_starting_currency(var_0) {
  var_1 = var_0.starting_currency_after_revived_from_spectator;
  if(isDefined(var_1)) {
    var_0.starting_currency_after_revived_from_spectator = undefined;
    return var_1;
  }

  return scripts\cp\cp_persistence::get_starting_currency();
}

set_player_max_currency(var_0) {
  var_0 = int(var_0);
  self.maxcurrency = var_0;
}

replace_grenades_between_waves() {
  level endon("game_ended");
  foreach(var_1 in level.players) {
    replace_grenades_on_player(var_1);
  }
}

replace_grenades_on_player(var_0) {
  var_1 = getarraykeys(var_0.powers);
  foreach(var_3 in var_1) {
    if(var_0.powers[var_3].slot == "secondary") {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
      var_0 thread wait_for_last_stand();
      continue;
    }

    var_0 thread recharge_power(var_3);
  }
}

wait_for_last_stand() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("spawned_player");
  wait(1);
  var_0 = getarraykeys(self.powers);
  if(var_0.size < 1) {
    return;
  }

  foreach(var_2 in var_0) {
    if(self.powers[var_2].slot == "secondary") {
      continue;
    }

    thread recharge_power(var_2);
  }
}

recharge_power(var_0) {
  var_1 = self.powers[var_0].slot;
  if(scripts\engine\utility::istrue(self.powers[var_0].var_19)) {
    while(scripts\engine\utility::istrue(self.powers[var_0].var_19)) {
      wait(0.05);
    }
  }

  if(scripts\engine\utility::istrue(self.powers[var_0].updating)) {
    while(scripts\engine\utility::istrue(self.powers[var_0].updating)) {
      wait(0.05);
    }
  }

  thread scripts\cp\powers\coop_powers::givepower(var_0, var_1, undefined, undefined, undefined, undefined, 1);
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
    foreach(var_1 in level.players) {
      if(scripts\cp\cp_laststand::player_in_laststand(var_1)) {
        scripts\cp\cp_laststand::instant_revive(var_1);
      }
    }

    level thread replace_grenades_between_waves();
  }
}

zombie_prespawnfromspectatorfunc(var_0) {
  var_0.starting_currency_after_revived_from_spectator = var_0 scripts\cp\cp_persistence::get_player_currency();
  scripts\cp\zombies\zombie_lost_and_found::save_items_to_lost_and_found(var_0);
  var_0 scripts\cp\zombies\zombies_perk_machines::remove_perks_from_player();
  revive_from_spectator_weapon_setup(var_0);
  set_spawn_loc(var_0);
  take_away_special_ammo(var_0);
  scripts\cp\zombies\zombie_afterlife_arcade::try_exit_afterlife_arcade(var_0);
}

revive_from_spectator_weapon_setup(var_0) {
  var_0 scripts\cp\utility::clear_weapons_status();
  var_1 = var_0.default_starting_pistol;
  var_2 = weaponclipsize(var_1);
  var_3 = weaponmaxammo(var_1);
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_4[var_4.size] = var_1;
  var_5[var_1] = var_2;
  var_6[var_1] = var_3;
  var_0 scripts\cp\utility::add_to_weapons_status(var_4, var_5, var_6, var_1);
  var_0.pre_laststand_weapon = var_1;
  var_0.pre_laststand_weapon_stock = var_3;
  var_0.pre_laststand_weapon_ammo_clip = var_2;
  var_0.lastweapon = var_1;
}

set_spawn_loc(var_0) {
  var_1 = zombie_get_player_respawn_loc(var_0);
  var_0.forcespawnorigin = var_1.origin;
  var_0.forcespawnangles = var_1.angles;
}

zombie_get_player_respawn_loc(var_0) {
  if(!isDefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0) {
    return [[level.getspawnpoint]]();
  }

  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  foreach(var_6 in level.players) {
    if(var_6 == var_0) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_6)) {
      continue;
    }

    var_1 = var_1 + var_6.origin[0];
    var_2 = var_2 + var_6.origin[1];
    var_3 = var_3 + var_6.origin[2];
    var_4++;
  }

  var_8 = (var_1 / var_4, var_2 / var_4, var_3 / var_4);
  var_9 = sortbydistance(level.active_player_respawn_locs, var_8);
  foreach(var_11 in var_9) {
    if(canspawn(var_11.origin) && !positionwouldtelefrag(var_11.origin)) {
      return var_11;
    }
  }

  return var_9[0];
}

take_away_special_ammo(var_0) {
  var_0.special_ammo_type = undefined;
}

default_zombie_prematch_func() {
  var_0 = 0;
  if(!scripts\engine\utility::istrue(level.introscreen_done)) {
    var_0 = 10;
  }

  if(scripts\engine\utility::istrue(game["gamestarted"])) {
    var_0 = 0;
  }

  if(var_0 > 0) {
    var_1 = level wait_for_first_player_connect();
    level thread show_introscreen_text();
    if(isDefined(level.intro_dialogue_func)) {
      level thread[[level.intro_dialogue_func]]();
    }

    wait(var_0 - 3);
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

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    level.players[var_2] scripts\cp\utility::freezecontrolswrapper(0);
    level.players[var_2] enableweapons();
    if(!isDefined(level.players[var_2].pers["team"])) {
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
  var_0 = undefined;
  if(level.players.size == 0) {
    level waittill("connected", var_0);
  } else {
    var_0 = level.players[0];
  }

  return var_0;
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
  var_0 = 1;
  self.meleestrength = 0;
  var_1 = gettime();
  for(;;) {
    var_2 = gettime();
    if(var_2 - var_1 >= level.playermeleestunregentime) {
      self.meleestrength = 1;
    } else {
      self.meleestrength = 0;
    }

    if(self meleebuttonpressed() && !self getteamsize() && !self usebuttonpressed()) {
      var_1 = gettime();
      if(var_0 == 1) {
        var_0 = 0;
      }
    } else if(!self meleebuttonpressed()) {
      var_0 = 1;
    } else {
      var_0 = 0;
    }

    wait(0.05);
  }
}

hasgl3weapon() {
  var_0 = 0;
  var_1 = self getweaponslist("primary");
  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(isgl3weapon(var_3)) {
        var_0 = 1;
        break;
      }
    }
  }

  return var_0;
}

isgl3weapon(var_0) {
  var_1 = getweaponbasename(var_0);
  if(!isDefined(var_1)) {
    return 0;
  }

  return var_0 == "iw7_glprox_zm";
}

watchglproxy() {
  self endon("death");
  self endon("disconnect");
  self endon("endExpJump");
  level endon("game_ended");
  var_0 = undefined;
  self notifyonplayercommand("fired", "+attack");
  for(;;) {
    scripts\engine\utility::waittill_any("weapon_switch_started", "weapon_change", "weaponchange");
    self notify("stop_regen_on_weapons");
    wait(0.1);
    var_1 = self getweaponslistall();
    foreach(var_3 in var_1) {
      if(isgl3weapon(var_3)) {
        thread regen_ammo_for_weapon(var_3);
        var_0 = 1;
        continue;
      }

      var_0 = 0;
    }
  }
}

regen_ammo_for_weapon(var_0) {
  self endon("stop_regen_on_weapons");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = 3;
  var_2 = 4;
  for(;;) {
    var_3 = self getweaponammoclip(var_0);
    while(var_3 <= var_1) {
      var_3 = self getweaponammoclip(var_0);
      self setweaponammoclip(var_0, var_3 + 1);
      wait(var_2);
    }

    wait(var_2);
  }
}

zombie_laststand_currency_penalth_amount(var_0) {
  var_1 = var_0 scripts\cp\cp_persistence::get_player_currency();
  var_1 = var_1 * 0.05;
  var_1 = int(var_1 / 10) * 10;
  return var_1;
}

zombie_callbackplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  [[level.callbackplayerlaststand]](var_0, var_1, var_2, var_4, var_5, var_7, var_8, var_9);
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
  var_0 = " LB_" + getdvar("ui_mapname");
  if(scripts\cp\utility::isplayingsolo()) {
    var_0 = var_0 + "_SOLO";
  } else {
    var_0 = var_0 + "_COOP";
  }

  precacheleaderboards(var_0);
}

getescapespawnpoint() {
  return scripts\cp\cp_globallogic::getassignedspawnpoint(scripts\engine\utility::getstructarray("escape_player_start", "targetname"));
}

setup_escape_hud(var_0) {
  var_1 = 40;
  var_2 = 200;
  var_3 = 10;
  var_4 = 15;
  var_0.score_progress_bar = scripts\cp\utility::createprimaryprogressbar(0, 0, var_2, var_3);
  var_0.score_progress_bar scripts\cp\utility::setpoint("center", "center", 0, var_1);
  var_0.current_score = scripts\cp\utility::createfontstring("objective", 1);
  var_0.current_score scripts\cp\utility::setpoint("center", "center", var_2 / 2 * -1, var_1 + var_4);
  var_0.score_goal = scripts\cp\utility::createfontstring("objective", 1);
  var_0.score_goal scripts\cp\utility::setpoint("center", "center", var_2 / 2, var_1 + var_4);
  set_current_score_value(var_0, 0);
  set_score_goal_value(var_0, level.escape_score_goal);
}

set_current_score_value(var_0, var_1) {
  var_0.current_score setvalue(var_1);
}

set_score_goal_value(var_0, var_1) {
  var_0.score_goal setvalue(var_1);
}

set_score_progress_bar_scale(var_0, var_1) {
  var_0.score_progress_bar scripts\cp\utility::updatebarscale(var_1);
}

update_current_score(var_0, var_1) {
  if(level.escape_score_goal == 0) {
    var_2 = 0;
  } else {
    var_2 = var_2 / level.escape_score_goal;
  }

  setomnvar("zom_escape_gate_percent", var_2);
}

escape_update_money_performance(var_0, var_1) {
  var_0 thread update_current_money_earned(var_0, var_1);
}

update_current_money_earned(var_0, var_1) {
  wait(0.1);
  level.current_score_earned = int(min(level.current_score_earned + var_1 * level.combo_multiplier, level.escape_score_goal));
  update_current_score(var_0, level.current_score_earned);
  if(level.current_score_earned >= level.escape_score_goal) {
    scripts\engine\utility::flag_set("score goal reached");
  }

  scripts\cp\zombies\zombies_gamescore::update_money_earned_performance(var_0, var_1);
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

player_escape(var_0, var_1) {
  var_2 = "player_after_escape_pos";
  var_1 iprintlnbold("You successfully escaped from the park!");
  var_3 = scripts\engine\utility::getstructarray(var_2, "targetname")[0];
  var_1 setorigin(var_3.origin);
  var_1.successfully_escaped = 1;
  test_win_condition(var_1);
}

test_win_condition(var_0) {
  foreach(var_0 in level.players) {
    if(!scripts\engine\utility::istrue(var_0.successfully_escaped)) {
      return;
    }
  }

  level thread[[level.endgame]]("ally", level.end_game_string_index["all_escape"]);
}