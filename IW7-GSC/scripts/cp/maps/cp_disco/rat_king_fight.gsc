/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\rat_king_fight.gsc
*******************************************************/

rkfightinit() {
  scripts\engine\utility::flag_init("rk_fight_ended");
  scripts\engine\utility::flag_init("rk_fight_started");
  scripts\engine\utility::flag_init("eye_active");
  scripts\engine\utility::flag_init("relic_active");
  scripts\engine\utility::flag_init("enableRKArenaPas");
  scripts\engine\utility::flag_init("rk_fight_relic_stage");
  level.rk_fight_stage_func = [];
  level.rk_fight_stage_func[level.rk_fight_stage_func.size] = ::runrkstage1;
  level.rk_fight_stage_func[level.rk_fight_stage_func.size] = ::runrkstage2;
  level.rk_fight_stage_func[level.rk_fight_stage_func.size] = ::runrkstage3;
  level.rk_fight_stage_func[level.rk_fight_stage_func.size] = ::runrkstage4;
  level.rk_fight_stage_func[level.rk_fight_stage_func.size] = ::runrkstage5;
  level.rk_fight_stage_func[level.rk_fight_stage_func.size] = ::runrkstage6;
  level.rk_fight_stage_func[level.rk_fight_stage_func.size] = ::runrkstage7;
  level.solorkstagetoggles = ::setdefaultrktoggles;
  level.rkstagetoggles = ::setdefaultrktoggles;
  setdefaultrktoggles();
  setdefaultpgtoggles();
  setdefaultattackpriorities();
  level.rat_king_stage = 0;
  level.max_rat_king_stage = 6;
  scripts\engine\utility::flag_init("max_ammo_active");
  level thread setuprkcrates();
  precachempanim("IW7_cp_king_death");
  level.rk_lostnfound = getent("rk_lostnfound", "targetname");
  level.rk_lostnfound hide();
  level.available_crate_perks = scripts\engine\utility::array_randomize_objects(["perk_machine_revive", "perk_machine_flash", "perk_machine_tough", "perk_machine_run", "perk_machine_rat_a_tat"]);
  level.num_crates_broken = 0;
  level.rkfight_karate_zombie_model_list = ["karatemaster_male_3_white_rat_head", "karatemaster_male_3_black_rat_head", "karatemaster_male_3_brown_rat_head"];
}

setuprkcrates() {
  var_00 = scripts\engine\utility::getstructarray("rk_perk_crate", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", var_02.origin);
    if(isDefined(var_02.angles)) {
      var_03.angles = var_02.angles;
    }

    var_03 setModel("cp_disco_crates_rk");
    var_02.model = var_03;
    var_02.fx_struct = scripts\engine\utility::getclosest(var_02.origin, scripts\engine\utility::getstructarray("crate_fx", "script_noteworthy"));
    var_02 thread cratewaitfordamage(var_02);
  }
}

cratewaitfordamage(param_00) {
  level endon("game_ended");
  level endon("rk_fight_completed");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_wait("rk_fight_started");
  if(!isDefined(level.rat_king_bounce_structs)) {
    level.rat_king_bounce_structs = [];
  }

  level.rat_king_bounce_structs[level.rat_king_bounce_structs.size] = param_00;
  param_00.model.health = 99999999;
  param_00.model setCanDamage(1);
  for(;;) {
    param_00.model waittill("damage", var_01, var_02, var_01, var_01, var_01, var_01, var_01, var_01, var_01, var_03);
    if(isDefined(var_02) && (isDefined(level.rat_king) && var_02 == level.rat_king) || isDefined(var_03) && isplayer(var_02) && scripts\cp\maps\cp_disco\kung_fu_mode::iskungfuweapon(var_03)) {
      param_00 thread breakcrateandwait(param_00);
      break;
    } else {
      param_00.model.health = 99999999;
    }
  }
}

breakcrateandwait(param_00) {
  level endon("game_ended");
  param_00.model setscriptablepartstate("crate", "broken");
  param_00.model setCanDamage(0);
  thread throwperkboxes(param_00);
  level waittill("rk_fight_completed");
  param_00.model setscriptablepartstate("crate", "active");
  var_01 = scripts\engine\utility::getstructarray("perk_candy_box", "script_noteworthy");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.model)) {
      var_03.model delete();
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
  }
}

init_rk_candy_interactions() {
  var_00 = scripts\engine\utility::getstructarray("perk_candy_box", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = scripts\engine\utility::getstruct(var_02.target, "targetname");
    var_03.parent_struct = var_02;
    var_02.fx_struct = var_03;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_02);
  }
}

activateparentinteraction(param_00) {
  var_01 = param_00.parent_struct;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
}

throwperkboxes(param_00) {
  var_01 = param_00.fx_struct;
  var_02 = scripts\engine\utility::array_randomize_objects(level.available_crate_perks);
  var_03 = scripts\engine\utility::random(var_02);
  level.available_crate_perks = scripts\engine\utility::array_remove(level.available_crate_perks, var_03);
  var_04 = spawn("script_model", var_01.origin);
  if(isDefined(var_01.angles)) {
    var_04.angles = var_01.angles;
  }

  var_04 setModel("tag_origin_rk_perks");
  var_01.model = var_04;
  var_01.parent_struct.perk = var_03;
  activateparentinteraction(var_01);
  switch (var_03) {
    case "perk_machine_fwoosh":
      var_04 setscriptablepartstate("effects", "fwoosh");
      break;

    case "perk_machine_zap":
      var_04 setscriptablepartstate("effects", "zap");
      break;

    case "perk_machine_boom":
      var_04 setscriptablepartstate("effects", "boom");
      break;

    case "perk_machine_deadeye":
      var_04 setscriptablepartstate("effects", "deadeye");
      break;

    case "perk_machine_smack":
      var_04 setscriptablepartstate("effects", "smack");
      break;

    case "perk_machine_revive":
      var_04 setscriptablepartstate("effects", "upNAtoms");
      break;

    case "perk_machine_flash":
      var_04 setscriptablepartstate("effects", "quickies");
      break;

    case "perk_machine_tough":
      var_04 setscriptablepartstate("effects", "tuff");
      break;

    case "perk_machine_run":
      var_04 setscriptablepartstate("effects", "run");
      break;

    case "perk_machine_rat_a_tat":
      var_04 setscriptablepartstate("effects", "bangs");
      break;

    default:
      var_04 setscriptablepartstate("effects", "neutral");
      break;
  }
}

addperkinteraction(param_00, param_01, param_02) {
  param_00.script_noteworthy = "perk_candy_box";
  param_00.perk = param_02;
  param_00.script_parameters = "default";
  param_00.requires_power = 0;
  param_00.powered_on = 1;
  param_00.name = "perk_candy_box";
  param_00.spend_type = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

perkbox_usefunc(param_00, param_01) {
  if(!isDefined(param_00.perk)) {
    return;
  }

  if(isDefined(param_01.zombies_perks) && param_01.zombies_perks.size > 4) {
    return;
  }

  if(param_01 scripts\cp\utility::has_zombie_perk(param_00.perk)) {
    return;
  }

  param_01 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(param_00.perk, 0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(param_00, param_01);
  param_00.fx_struct.model hidefromplayer(param_01);
  param_01 playlocalsound("part_pickup");
  if(!isDefined(param_00.respawn_flag)) {
    param_00.respawn_flag = 1;
    level.num_crates_broken++;
    var_02 = level.num_crates_broken * 0.05;
    level.available_crate_perks[level.available_crate_perks.size] = param_00.perk;
    param_00 thread restockperkafternextrelic(param_00, param_01, var_02);
  }
}

restockperkafternextrelic(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("rk_fight_completed");
  level scripts\engine\utility::waittill_any_timeout_1(180, "relic_quest_completed");
  param_00.respawn_flag = undefined;
  level.num_crates_broken = 0;
  wait(param_02);
  var_03 = param_00.fx_struct.model;
  var_04 = scripts\engine\utility::array_randomize_objects(level.available_crate_perks);
  var_05 = scripts\engine\utility::random(var_04);
  param_00.perk = var_05;
  level.available_crate_perks = scripts\engine\utility::array_remove(level.available_crate_perks, var_05);
  switch (var_05) {
    case "perk_machine_fwoosh":
      var_03 setscriptablepartstate("effects", "fwoosh");
      break;

    case "perk_machine_zap":
      var_03 setscriptablepartstate("effects", "zap");
      break;

    case "perk_machine_boom":
      var_03 setscriptablepartstate("effects", "boom");
      break;

    case "perk_machine_deadeye":
      var_03 setscriptablepartstate("effects", "deadeye");
      break;

    case "perk_machine_smack":
      var_03 setscriptablepartstate("effects", "smack");
      break;

    case "perk_machine_revive":
      var_03 setscriptablepartstate("effects", "upNAtoms");
      break;

    case "perk_machine_flash":
      var_03 setscriptablepartstate("effects", "quickies");
      break;

    case "perk_machine_tough":
      var_03 setscriptablepartstate("effects", "tuff");
      break;

    case "perk_machine_run":
      var_03 setscriptablepartstate("effects", "run");
      break;

    case "perk_machine_rat_a_tat":
      var_03 setscriptablepartstate("effects", "bangs");
      break;

    default:
      var_03 setscriptablepartstate("effects", "neutral");
      break;
  }

  foreach(var_07 in level.players) {
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(param_00, var_07);
    param_00.fx_struct.model showtoplayer(var_07);
  }
}

perkbox_hintfunc(param_00, param_01) {
  return "";
}

setdefaultpgtoggles() {
  level.pam_grier_toggles = [];
  level.pam_grier_toggles["chillin"] = 1;
  level.pam_grier_toggles["revive_player"] = 1;
  level.pam_grier_toggles["teleport_attack"] = 1;
  level.pam_grier_toggles["melee_attack"] = 1;
  level.pam_grier_toggles["return_home"] = 1;
  level.pam_grier_toggles["wait"] = 1;
}

restorerkstagetoggles() {
  if(level.players.size == 1) {
    if(isDefined(level.solorkstagetoggles)) {
      [
        [level.solorkstagetoggles]
      ]();
      return;
    }

    return;
  }

  if(isDefined(level.rkstagetoggles)) {
    [[level.rkstagetoggles]]();
  }
}

setdefaultrktoggles() {
  level.rat_king_toggles = [];
  level.rat_king_toggles["staff_stomp"] = 0;
  level.rat_king_toggles["melee_attack"] = 0;
  level.rat_king_toggles["summon"] = 0;
  level.rat_king_toggles["block"] = 0;
  level.rat_king_toggles["staff_projectile"] = 0;
  level.rat_king_toggles["shield_attack"] = 0;
  level.rat_king_toggles["shield_attack_spot"] = 0;
  level.rat_king_toggles["teleport"] = 0;
  level.rat_king_toggles["attack_zombies"] = 0;
}

setdefaultattackpriorities() {
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
}

start_rk_fight() {
  level.loot_time_out = 99999;
  level notify("force_spawn_wave_done");
  scripts\engine\utility::flag_set("rk_fight_started");
  scripts\engine\utility::flag_clear("pillage_enabled");
  scripts\engine\utility::flag_clear("zombie_drop_powerups");
  scripts\cp\zombies\cp_disco_spawning::storewavespawningcounters();
  stop_spawn_wave();
  clearexistingenemies();
  level.respawn_enemy_list = [];
  level.respawn_data = undefined;
  level.ratking_fight = 1;
  level.old_karate_zombie_model_list = level.karate_zombie_model_list;
  level.karate_zombie_model_list = level.rkfight_karate_zombie_model_list;
  var_00 = scripts\engine\utility::getstructarray("rk_player_spawns", "script_noteworthy");
  var_00 = scripts\engine\utility::array_randomize_objects(var_00);
  level thread setuprkfightpas();
  foreach(var_04, var_02 in level.players) {
    if(scripts\engine\utility::istrue(var_02.start_breaking_clock)) {
      var_02.start_breaking_clock = 0;
      var_02 notify("rat_king_fight_started");
    }

    if(scripts\engine\utility::istrue(var_02.inlaststand) || scripts\engine\utility::istrue(var_02.in_afterlife_arcade)) {
      scripts\cp\cp_laststand::clear_last_stand_timer(var_02);
      var_02 notify("revive_success");
      if(isDefined(var_02.reviveent)) {
        var_02.reviveent notify("revive_success");
      }
    }

    var_03 = var_00[var_04];
    var_02 thread setupplayerrkstart(var_02, var_03);
    if(var_02.vo_prefix == "p5_") {
      var_02 thread scripts\cp\cp_vo::try_to_play_vo("ratking_finalbattle", "disco_comment_vo");
    }
  }

  level.getspawnpoint = ::respawninrkarena;
  level.force_respawn_location = ::respawninrkarena;
  level.use_gourd_func = ::rkusegourdfunc;
  setuprkarenabarriers();
  scripts\cp\zombies\cp_disco_spawning::waitforvalidwavepause();
  level scripts\cp\zombies\cp_disco_spawning::disablespawnvolumes(level.rk_center_arena_struct.origin);
  disable_water_spawners();
  enablerkspawners();
  if(isDefined(level.pam_grier)) {
    level.pam_grier suicide();
  }

  level thread spawnpamgrier();
  level waittill("rk_intro_done");
  var_05 = scripts\engine\utility::getstructarray("rat_king_spawner", "targetname");
  var_06 = scripts\engine\utility::getclosest((-628.8, 1422.4, 178), var_05, 500);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_finalspawn", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  scripts\cp\maps\cp_disco\rat_king::spawn_rat_king(var_06.origin, var_06.angles, 1);
  rkintroresumeprogression();
  level thread respawngourds();
  level thread setuplnfinteractions();
  level thread max_ammo_manager();
  runrkfight();
}

disable_water_spawners() {
  if(isDefined(level.rat_king_lair_spawners)) {
    foreach(var_01 in level.rat_king_lair_spawners) {
      var_01 scripts\cp\zombies\zombies_spawning::make_spawner_inactive();
    }
  }
}

enable_water_spawners() {
  if(isDefined(level.rat_king_lair_spawners)) {
    foreach(var_01 in level.rat_king_lair_spawners) {
      var_01 scripts\cp\zombies\zombies_spawning::make_spawner_active();
    }
  }
}

spawnpamgrier() {
  level endon("game_ended");
  for(;;) {
    level.pam_grier = scripts\mp\mp_agent::spawnnewagent("pamgrier", "allies", (-458, 2144, 400), (0, 207, 0));
    if(isDefined(level.pam_grier)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

setuprkfightpas() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("enableRKArenaPas");
  level scripts\cp\maps\cp_disco\cp_disco::enableratkingpas();
}

setupplayerrkstart(param_00, param_01) {
  param_00 endon("disconnect");
  if(param_00 scripts\cp\utility::isteleportenabled()) {
    param_00 scripts\cp\utility::allow_player_teleport(0);
  }

  param_00 thread rkintroblackscreen();
  wait(1.25);
  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    param_00 setorigin(param_01.origin);
    param_00 setplayerangles(param_01.angles);
  }

  param_00.anchor = spawn("script_model", param_00.origin);
  param_00.anchor setModel("tag_origin");
  param_00.anchor.angles = param_01.angles;
  param_00 playerlinkto(param_00.anchor, "tag_origin", 0, 30, 30, 10, 10, 0);
}

rkintroresumeprogression(param_00) {
  level.pause_nag_vo = 0;
  resume_spawn_wave();
}

rkintroblackscreen() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\cp\utility::freezecontrolswrapper(1);
  self getradiuspathsighttestnodes();
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    wait(4);
    level notify("rk_intro_done");
    wait(5);
  } else {
    self setclientomnvar("ui_hide_hud", 1);
    self.rk_intro_overlay = newclienthudelem(self);
    self.rk_intro_overlay.x = 0;
    self.rk_intro_overlay.y = 0;
    self.rk_intro_overlay setshader("black", 640, 480);
    self.rk_intro_overlay.alignx = "left";
    self.rk_intro_overlay.aligny = "top";
    self.rk_intro_overlay.sort = 1;
    self.rk_intro_overlay.horzalign = "fullscreen";
    self.rk_intro_overlay.vertalign = "fullscreen";
    self.rk_intro_overlay.foreground = 1;
    self.rk_intro_overlay.alpha = 0;
    self.rk_intro_overlay fadeovertime(1);
    self.rk_intro_overlay.alpha = 1;
    wait(2);
    self.rk_intro_overlay fadeovertime(2);
    self.rk_intro_overlay.alpha = 0;
    wait(2);
    self.rk_intro_overlay destroy();
    level notify("rk_intro_done");
    wait(5);
    self setclientomnvar("ui_hide_hud", 0);
  }

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  self enableweapons();
  self unlink();
  scripts\engine\utility::flag_set("enableRKArenaPas");
  scripts\cp\utility::freezecontrolswrapper(0);
}

outroblackscreen() {
  level endon("game_ended");
  self endon("disconnect");
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    return;
  }

  self.bs_anchor = spawn("script_model", self.origin);
  self.bs_anchor setModel("tag_origin");
  self playerlinkto(self.bs_anchor);
  scripts\cp\utility::freezecontrolswrapper(1);
  self setclientomnvar("ui_hide_hud", 1);
  self.ability_invulnerable = 1;
  self getradiuspathsighttestnodes();
  self.rk_outro_overlay = newclienthudelem(self);
  self.rk_outro_overlay.x = 0;
  self.rk_outro_overlay.y = 0;
  self.rk_outro_overlay setshader("black", 640, 480);
  self.rk_outro_overlay.alignx = "left";
  self.rk_outro_overlay.aligny = "top";
  self.rk_outro_overlay.sort = 1;
  self.rk_outro_overlay.horzalign = "fullscreen";
  self.rk_outro_overlay.vertalign = "fullscreen";
  self.rk_outro_overlay.foreground = 1;
  self.rk_outro_overlay.alpha = 0;
  self.rk_outro_overlay fadeovertime(2);
  self.rk_outro_overlay.alpha = 1;
  level waittill("rk_fight_completed");
  self.rk_outro_overlay fadeovertime(2);
  self.rk_outro_overlay.alpha = 0;
  wait(2);
  self.rk_outro_overlay destroy();
  self setclientomnvar("ui_hide_hud", 0);
  self enableweapons();
  self.bs_anchor delete();
  self unlink();
  scripts\engine\utility::flag_set("enableRKArenaPas");
  scripts\cp\utility::freezecontrolswrapper(0);
}

rkusegourdfunc(param_00) {
  thread scripts\cp\maps\cp_disco\kung_fu_mode::cooldown_struct(undefined, param_00);
}

respawninrkarena(param_00) {
  var_01 = scripts\engine\utility::getstructarray("rkRespawnLoc", "script_noteworthy");
  var_02 = scripts\cp\gametypes\zombie::get_respawn_loc_rated(level.players, var_01);
  return var_02;
}

setuplnfinteractions() {
  var_00 = scripts\engine\utility::getstructarray("lost_and_found", "script_noteworthy");
  var_01 = undefined;
  foreach(var_03 in var_00) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
    if(isDefined(var_03.name) && var_03.name == "rk_fight") {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_03);
      level.rk_lostnfound show();
      var_01 = var_03;
    }
  }

  foreach(var_06 in level.players) {
    if(!isDefined(var_06.lost_and_found_ent)) {
      continue;
    }

    var_06.lost_and_found_ent.origin = var_01.origin + (0, 0, 45);
  }
}

restorelnfinteractions() {
  var_00 = scripts\engine\utility::getstructarray("lost_and_found", "script_noteworthy");
  var_01 = undefined;
  foreach(var_03 in var_00) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_03);
    if(isDefined(var_03.name) && var_03.name == "rk_fight") {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_03);
      continue;
    }

    var_01 = var_03;
  }

  foreach(var_06 in level.players) {
    if(!isDefined(var_06.lost_and_found_ent)) {
      continue;
    }

    var_06.lost_and_found_ent.origin = var_01.origin + (0, 0, 45);
  }

  level.rk_lostnfound hide();
}

respawngourds() {
  level endon("game_ended");
  level.rat_king endon("death");
  for(;;) {
    foreach(var_01 in level.players) {
      if(!isDefined(var_01.kung_fu_progression.active_discipline)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_01.has_gourd)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_01.kung_fu_mode)) {
        continue;
      }

      var_01.kung_fu_cooldown = undefined;
      var_01 notify("spawn_gourds");
      var_01 scripts\cp\maps\cp_disco\kung_fu_mode::checkgourdstates(undefined, var_01);
      var_01 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_01);
    }

    level scripts\engine\utility::waittill_any_timeout_1(120, "relic_quest_completed");
  }
}

try_drop_max_ammo() {
  if(!scripts\engine\utility::flag("max_ammo_active")) {
    scripts\engine\utility::flag_set("max_ammo_active");
    level thread[[level.drop_max_ammo_func]]((-892, 1814, 238), undefined, "ammo_max");
  }
}

max_ammo_manager() {
  level thread max_ammo_pick_up_listener();
}

max_ammo_pick_up_listener() {
  level endon("game_ended");
  level endon("rk_fight_completed");
  for(;;) {
    level waittill("pick_up_max_ammo");
    scripts\engine\utility::flag_clear("max_ammo_active");
  }
}

setuprkarenabarriers() {
  level.rk_barriers = [];
  foreach(var_01 in scripts\engine\utility::getstructarray("rk_fx_loc", "targetname")) {
    var_02 = spawn("script_model", var_01.origin);
    var_02.angles = var_01.angles;
    var_02 setModel("temp_dbl_door_barrier");
    if(level.rk_barriers.size == 0) {
      var_02 playLoopSound("rk_tunnel_blocker_left_lp");
    } else {
      var_02 playLoopSound("rk_tunnel_blocker_right_lp");
    }

    level.rk_barriers[level.rk_barriers.size] = var_02;
  }
}

runrkfight() {
  level endon("game_ended");
  level endon("rk_fight_completed");
  for(;;) {
    if(isDefined(level.rk_fight_stage_func[level.rat_king_stage])) {
      runcurrentrkfightstage();
    }
  }
}

increaserkstage() {
  if(level.rat_king_stage < level.max_rat_king_stage) {
    level.rat_king_stage++;
  }
}

runcurrentrkfightstage() {
  [
    [level.rk_fight_stage_func[level.rat_king_stage]]
  ]();
}

runrkstage1() {
  setrkhealth();
  setdefaultrktoggles();
  setdefaultpgtoggles();
  setdefaultattackpriorities();
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["walk"]);
  var_00 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(0);
  scripts\cp\zombies\cp_disco_spawning::setmaxstaticspawns(8, 16, 24);
  if(var_00) {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.75);
  } else {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.3);
  }

  stage1attacksettings();
  watchfordamagestagecomplete(0.75, 0.85);
  increaserkstage();
}

stage1attacksettings() {
  togglerkability("melee_attack", 1);
  togglerkability("staff_stomp", 1);
  togglerkability("summon", 0);
  togglerkability("block", 0);
  togglerkability("staff_projectile", 0);
  togglerkability("shield_attack", 0);
  togglerkability("shield_attack_spot", 0);
  togglerkability("teleport", 1);
  togglepgability("chillin", 1);
  togglepgability("revive_player", 1);
  togglepgability("teleport_attack", 1);
  togglepgability("melee_attack", 1);
  togglepgability("return_home", 1);
  togglepgability("wait", 1);
}

runrkstage2() {
  setrkhealth(0.75);
  level thread waitforrkoutofplayspace();
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["sprint"]);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(0);
  stage2attacksettings();
  activaterelics();
  watchforrelicstagecomplete();
  deactivaterelics();
  increaserkstage();
}

stage2attacksettings() {
  forcerkteleport();
  togglepgability("chillin", 1);
  togglepgability("revive_player", 0);
  togglepgability("teleport_attack", 0);
  togglepgability("melee_attack", 0);
  togglepgability("return_home", 1);
  togglepgability("wait", 1);
}

activaterelics() {
  scripts\engine\utility::flag_set("rk_fight_relic_stage");
  var_00 = scripts\engine\utility::getstructarray("rk_relic_pos", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = spawnfx(level._effect["relic_active"], var_02.origin);
    if(isDefined(var_02.model)) {
      var_02.model thread startactiveloop(var_02, var_03);
    }
  }
}

startactiveloop(param_00, param_01) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  param_00 endon("relic_deactivated");
  self endon("death");
  self setscriptablepartstate("rk_models", "active_" + param_00.relic);
  if(isDefined(param_00.fx)) {
    param_00.fx delete();
  }

  param_00.fx = param_01;
  triggerfx(param_01);
  if(param_00.relic == "heart") {
    self playLoopSound("rk_relic_heart_lp");
  }

  if(param_00.relic == "eye") {
    self playLoopSound("rk_relic_eye_lp");
  }

  if(param_00.relic == "brain") {
    self playLoopSound("rk_relic_brain_lp");
  }

  for(;;) {
    var_02 = randomfloatrange(2, 4);
    self moveto(self.origin + (0, 0, 32), var_02);
    wait(var_02);
    self moveto(self.origin + (0, 0, -32), var_02);
    wait(var_02);
  }
}

deactivaterelics() {
  var_00 = scripts\engine\utility::getstructarray("rk_relic_pos", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.model)) {
      var_02 notify("relic_deactivated");
      var_02.model stoploopsound();
      var_02 thread moverelictoog(var_02);
    }
  }
}

moverelictoog(param_00) {
  if(isDefined(param_00.model)) {
    var_01 = spawnfx(level._effect["relic_idle"], param_00.origin);
    if(isDefined(param_00.ogpos)) {
      param_00.model moveto(param_00.ogpos, 0.5);
    }

    wait(0.5);
    if(isDefined(param_00.fx)) {
      param_00.fx delete();
    }

    param_00.fx = triggerfx(var_01);
    param_00.model setscriptablepartstate("rk_models", param_00.relic);
  }
}

runrkstage3() {
  setrkhealth(0.75);
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["run"]);
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(1);
  level.rk_tuning_override = ::stage3tunedata;
  level.rk_solo_tuning_override = ::stage3solotunedata;
  var_00 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  stage3attacksettings();
  if(var_00) {
    stage3solotunedata(level.agenttunedata["ratking"]);
  } else {
    stage3tunedata(level.agenttunedata["ratking"]);
  }

  watchfordamagestagecomplete(0.5, 0.6);
  increaserkstage();
}

stage3tunedata(param_00) {
  param_00.min_summon_interval = 10000;
  param_00.max_summon_interval = 20000;
  param_00.summon_chance = 100;
  param_00.summon_agent_type = "karatemaster";
  param_00.summon_min_spawn_num = 6;
  param_00.summon_max_spawn_num = 8;
  param_00.summon_min_radius = 100;
  param_00.summon_max_radius = 600;
  param_00.summon_spawn_min_dist_between_agents_sq = 2500;
  param_00.max_num_agents_to_allow_summon = 2;
  param_00.min_time_between_summon_rounds = 3000;
  param_00.need_to_block_damage_threshold = 20;
  param_00.max_time_after_last_damage_to_block = 1000;
  param_00.block_chance = 100;
  param_00.min_block_time = 5000;
  param_00.max_block_time = 10000;
  param_00.quit_block_if_no_damage_time = 2000;
  param_00.min_block_interval = 5000;
  param_00.max_block_interval = 10000;
  param_00.staff_stomp_inner_interval = 3000;
  param_00.staff_stomp_interval = 10000;
  param_00.staff_stomp_damage_radius = 175;
  param_00.staff_stomp_max_damage = 200;
  param_00.staff_stomp_min_damage = 30;
  param_00.min_path_dist_for_teleport = 300;
  param_00.no_los_wait_time_before_teleport = 500;
  param_00.min_time_between_teleports = 5000;
  param_00.min_teleport_dist_to_player = 400;
  param_00.max_teleport_dist_to_player = 1000;
  param_00.telefrag_dist_sq = 576;
  param_00.attempt_teleport_if_no_engagement_within_time = 2000;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = -25536;
}

stage3solotunedata(param_00) {
  param_00.min_summon_interval = 8000;
  param_00.max_summon_interval = 15000;
  param_00.summon_chance = 100;
  param_00.summon_agent_type = "karatemaster";
  param_00.summon_min_spawn_num = 6;
  param_00.summon_max_spawn_num = 8;
  param_00.summon_min_radius = 100;
  param_00.summon_max_radius = 600;
  param_00.summon_spawn_min_dist_between_agents_sq = 2500;
  param_00.max_num_agents_to_allow_summon = 1;
  param_00.min_time_between_summon_rounds = 3000;
  param_00.need_to_block_damage_threshold = 20;
  param_00.max_time_after_last_damage_to_block = 2000;
  param_00.block_chance = 100;
  param_00.min_block_time = 5000;
  param_00.max_block_time = 10000;
  param_00.quit_block_if_no_damage_time = 2000;
  param_00.min_block_interval = 10000;
  param_00.max_block_interval = 10001;
  param_00.staff_stomp_inner_radius_sq = 5625;
  param_00.staff_stomp_outer_radius_sq = 22500;
  param_00.staff_stomp_damage_radius = 175;
  param_00.staff_stomp_interval = 10000;
  param_00.staff_stomp_inner_interval = 3000;
  param_00.staff_stomp_max_damage = 200;
  param_00.staff_stomp_min_damage = 30;
  param_00.min_path_dist_for_teleport = 300;
  param_00.no_los_wait_time_before_teleport = 500;
  param_00.min_time_between_teleports = 5000;
  param_00.min_teleport_dist_to_player = 400;
  param_00.max_teleport_dist_to_player = 1000;
  param_00.telefrag_dist_sq = 576;
  param_00.attempt_teleport_if_no_engagement_within_time = 4000;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = -25536;
}

stage3attacksettings() {
  togglerkability("melee_attack", 1);
  togglerkability("staff_stomp", 1);
  togglerkability("summon", 1);
  togglerkability("block", 1);
  togglerkability("teleport", 1);
  togglerkability("shield_attack", 0);
  togglerkability("shield_attack_spot", 0);
  togglerkability("staff_projectile", 0);
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
}

runrkstage4(param_00) {
  setrkhealth(0.5);
  level thread waitforrkoutofplayspace();
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["sprint"]);
  forcerkteleport();
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(0);
  togglepgability("chillin", 1);
  togglepgability("revive_player", 0);
  togglepgability("teleport_attack", 0);
  togglepgability("melee_attack", 0);
  togglepgability("return_home", 1);
  togglepgability("wait", 1);
  scripts\engine\utility::flag_set("rk_fight_relic_stage");
  activaterelics();
  watchforrelicstagecomplete();
  deactivaterelics();
  increaserkstage();
}

setstage4attackpriorities() {
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
}

runrkstage5(param_00) {
  setrkhealth(0.5);
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["sprint"]);
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(0);
  togglerkability("melee_attack", 1);
  togglerkability("staff_stomp", 1);
  togglerkability("summon", 0);
  togglerkability("block", 1);
  togglerkability("staff_projectile", 1);
  togglerkability("shield_attack", 1);
  togglerkability("shield_attack_spot", 0);
  togglerkability("teleport", 1);
  setstage5attackpriorities();
  watchfordamagestagecomplete(0.25, 0.35);
  increaserkstage();
}

setstage5attackpriorities() {
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
}

runrkstage6(param_00) {
  setrkhealth(0.25);
  level thread waitforrkoutofplayspace();
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["sprint"]);
  forcerkteleport();
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(0);
  togglepgability("chillin", 1);
  togglepgability("revive_player", 0);
  togglepgability("teleport_attack", 0);
  togglepgability("melee_attack", 0);
  togglepgability("return_home", 1);
  togglepgability("wait", 1);
  scripts\engine\utility::flag_set("rk_fight_relic_stage");
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.75);
  } else {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.3);
  }

  activaterelics();
  watchforrelicstagecomplete();
  deactivaterelics();
  increaserkstage();
}

runrkstage7(param_00) {
  setrkhealth(0.25);
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["slow_walk", "walk", "sprint", "sprint", "sprint"]);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(0);
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  var_01 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_01) {
    level.solorkstagetoggles = ::stage7attacktoggles;
  } else {
    level.rkstagetoggles = ::stage7attacktoggles;
  }

  stage7attacktoggles();
  setstage7attackpriorities();
  watchforstage7complete();
}

stage7attacktoggles() {
  togglerkability("melee_attack", 1);
  togglerkability("staff_stomp", 1);
  togglerkability("summon", 1);
  togglerkability("block", 1);
  togglerkability("staff_projectile", 1);
  togglerkability("shield_attack", 1);
  togglerkability("shield_attack_spot", 1);
  togglerkability("teleport", 1);
}

setstage7attackpriorities() {
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
}

watchforstage7complete() {
  level endon("game_ended");
  level waittill("rat_king_killed", var_00);
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    level thread scripts\cp\zombies\direct_boss_fight::success_sequence(6, 3);
    level notify("rk_fight_completed");
    return;
  }

  level.ratking_fight = undefined;
  foreach(var_02 in level.players) {
    var_02 thread scripts\cp\cp_merits::processmerit("mt_dlc2_rat_king");
    if(var_02.vo_prefix == "p5_") {
      var_02 scripts\cp\zombies\achievement::update_achievement("EXTERMINATOR", 1);
    }

    if(!var_02 scripts\cp\utility::isteleportenabled()) {
      var_02 scripts\cp\utility::allow_player_teleport(1);
    }

    var_02.ability_invulnerable = undefined;
  }

  level.force_respawn_location = undefined;
  level.use_gourd_func = undefined;
  scripts\engine\utility::flag_clear("rk_fight_started");
  scripts\engine\utility::flag_set("zombie_drop_powerups");
  scripts\engine\utility::flag_set("pillage_enabled");
  scripts\engine\utility::flag_set("rk_fight_ended");
  stop_spawn_wave();
  level thread delay_resume_wave_progression();
  clearexistingenemies();
  if(isDefined(level.pam_grier)) {
    level.pam_grier.nocorpse = 1;
    level.pam_grier hide();
    level.pam_grier suicide();
  }

  cleanuprelics();
  thread sound_duck_end_bink();
  scripts\cp\utility::play_bink_video("zombies_cp_disco_outro", 55);
  drop_soul_key(var_00 + (0, 0, 32));
  clean_up_rk_barriers();
  enable_water_spawners();
  thread cleanuprkfightoverrides();
  level notify("rk_fight_completed");
}

sound_duck_end_bink() {
  foreach(var_01 in level.players) {
    var_01 setsoundsubmix("bink_from_frontend", 1);
  }

  wait(55);
  foreach(var_01 in level.players) {
    var_01 clearsoundsubmix();
  }
}

spawnrkdeathmodel() {
  var_00 = spawn("script_model", level.rk_center_arena_struct.origin);
  var_00.angles = level.rk_center_arena_struct.angles;
}

cleanuprelics() {
  var_00 = scripts\engine\utility::getstructarray("rk_relic_pos", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.model)) {
      var_02.model delete();
    }

    if(isDefined(var_02.fx)) {
      var_02.fx delete();
    }
  }
}

cleanuprkfightoverrides() {
  scripts\cp\zombies\cp_disco_spawning::unsetwavenumoverride();
  scripts\cp\zombies\cp_disco_spawning::unsetspawndelayoverride();
  scripts\cp\zombies\cp_disco_spawning::unsetzombiemovespeed();
  unsetpgsettings();
  restorelnfinteractions();
  level.loot_time_out = undefined;
  level.dont_resume_wave_after_solo_afterlife = undefined;
  level.karate_zombie_model_list = level.old_karate_zombie_model_list;
  level.getspawnpoint = ::scripts\cp\cp_globallogic::defaultgetspawnpoint;
}

unsetpgsettings() {
  togglepgability("chillin", 1);
  togglepgability("revive_player", 0);
  togglepgability("teleport_attack", 0);
  togglepgability("melee_attack", 0);
  togglepgability("return_home", 1);
  togglepgability("wait", 1);
}

clearexistingenemies() {
  var_00 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_02 in var_00) {
    var_02.died_poorly = 1;
    var_02.nocorpse = 1;
    var_02 suicide();
  }
}

drop_soul_key(param_00) {
  var_01 = param_00;
  if(isDefined(level.soul_key_drop_pos)) {
    var_01 = level.soul_key_drop_pos;
  }

  var_01 = check_drop_on_rafters(var_01);
  var_02 = spawn("script_model", var_01);
  var_02 setModel("tag_origin_soul_key");
  var_02 thread item_keep_rotating(var_02);
  var_02 thread soul_key_pick_up_monitor(var_02);
}

check_drop_on_rafters(param_00) {
  var_01 = (-873, 1821, 231);
  if(param_00[2] > 283) {
    return var_01;
  }

  return param_00;
}

item_keep_rotating(param_00) {
  param_00 endon("death");
  var_01 = param_00.angles;
  for(;;) {
    param_00 rotateto(var_01 + (randomintrange(-40, 40), randomintrange(-40, 90), randomintrange(-40, 90)), 3);
    wait(3);
  }
}

soul_key_pick_up_monitor(param_00) {
  param_00 endon("death");
  param_00 makeusable();
  param_00 sethintstring(&"CP_DISCO_INTERACTIONS_PICKUP_SOUL_KEY");
  for(;;) {
    param_00 waittill("trigger", var_01);
    scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
    if(isplayer(var_01)) {
      var_01 playlocalsound("part_pickup");
      param_00 setscriptablepartstate("actions", "pickup");
      setplayerdataforplayers();
      break;
    }
  }

  level thread scripts\cp\zombies\directors_cut::try_drop_talisman(param_00.origin, vectortoangles((0, 1, 0)));
  param_00 delete();
}

setplayerdataforplayers() {
  foreach(var_01 in level.players) {
    var_01 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
    var_01 setplayerdata("cp", "haveSoulKeys", "soul_key_3", 1);
    var_01 scripts\cp\zombies\achievement::update_achievement("PEST_CONTROL", 1);
  }
}

stop_spawn_wave() {
  level.current_enemy_deaths = 0;
  scripts\engine\utility::flag_set("pause_wave_progression");
  level.zombies_paused = 1;
  level.dont_resume_wave_after_solo_afterlife = 1;
}

delay_resume_wave_progression() {
  level endon("game_ended");
  wait(60);
  level.pause_nag_vo = 0;
  scripts\cp\zombies\cp_disco_spawning::restorespawnvolumes();
  scripts\cp\zombies\cp_disco_spawning::restorewavespawningcounters();
  scripts\cp\zombies\cp_disco_spawning::unpausenormalwavespawning();
  level thread playratkingfightcompletevos();
}

resume_spawn_wave() {
  level.dont_resume_wave_after_solo_afterlife = undefined;
  level.zombies_paused = 0;
  scripts\engine\utility::flag_clear("pause_wave_progression");
}

init_rkrelic() {
  level.rk_center_arena_struct = scripts\engine\utility::getstruct("rk_arena_center", "script_noteworthy");
  level.rk_center_arena_struct scripts\cp\cp_interaction::remove_from_current_interaction_list(level.rk_center_arena_struct);
  level.rk_center_arena_struct.custom_search_dist = 128;
  if(!isDefined(level.rk_center_arena_struct.model)) {
    var_00 = spawn("script_model", level.rk_center_arena_struct.origin + (0, 0, 4));
    var_00 setModel("tag_origin_rk_relics");
    if(isDefined(level.rk_center_arena_struct.angles)) {
      var_00.angles = level.rk_center_arena_struct.angles;
    }

    level.rk_center_arena_struct.model = var_00;
  }

  var_01 = scripts\engine\utility::getstructarray("rk_relic_pos", "script_noteworthy");
  var_02 = scripts\engine\utility::array_randomize_objects(["heart", "brain", "eye"]);
  foreach(var_05, var_04 in var_01) {
    var_04.ogpos = var_04.origin + (0, 0, 4);
    var_04.relic = var_02[var_05];
    var_04 thread waitforrkfightstart(var_04);
  }
}

waitforrkfightstart(param_00) {
  level endon("game_ended");
  param_00 scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  scripts\engine\utility::flag_wait("rk_fight_started");
  if(!isDefined(param_00.model)) {
    var_01 = spawnfx(level._effect["relic_idle"], param_00.origin);
    triggerfx(var_01);
    if(isDefined(param_00.fx)) {
      param_00.fx delete();
    }

    param_00.fx = var_01;
    var_02 = spawn("script_model", param_00.ogpos);
    if(isDefined(param_00.angles)) {
      var_02.angles = param_00.angles;
    } else {
      var_02.angles = (0, 0, 0);
    }

    var_02 setModel("tag_origin_rk_relics");
    var_02 setscriptablepartstate("rk_models", param_00.relic);
    param_00.model = var_02;
  } else {
    param_00.model setscriptablepartstate("rk_models", param_00.relic);
  }

  param_00 thread waitforrkrelicstage(param_00);
}

waitforrkrelicstage(param_00) {
  level endon("game_ended");
  for(;;) {
    scripts\engine\utility::flag_wait("rk_fight_relic_stage");
    disabledamageonratking();
    level.rat_king.shouldbeonplatform = 1;
    param_00 scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    if(param_00 waitforrelicselection(param_00)) {
      break;
    }
  }

  thread runrelicquest(param_00);
}

waitforrelicselection(param_00) {
  level endon("game_ended");
  level waittill("relic_selected", var_01);
  if(param_00 != var_01) {
    param_00 scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    return 0;
  }

  level.current_relic = param_00.relic;
  level.rk_center_arena_struct scripts\cp\cp_interaction::add_to_current_interaction_list(level.rk_center_arena_struct);
  return 1;
}

runrelicquest(param_00) {
  level endon("game_ended");
  switch (param_00.relic) {
    case "heart":
      thread runheartrelicquest(param_00);
      break;

    case "brain":
      thread runbrainrelicquest(param_00);
      break;

    case "eye":
      thread runeyerelicquest(param_00);
      break;
  }
}

runheartrelicquest(param_00) {
  level endon("game_ended");
  level waittill(param_00.relic + "_relic_placed_in_center");
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning();
  togglerkability("melee_attack", 1);
  togglerkability("staff_stomp", 1);
  togglerkability("summon", 0);
  togglerkability("block", 0);
  togglerkability("staff_projectile", 0);
  togglerkability("shield_attack", 1);
  togglerkability("shield_attack_spot", 1);
  togglerkability("teleport", 0);
  setstage4attackpriorities();
  scripts\cp\zombies\cp_disco_spawning::setmaxstaticspawns(10, 16, 24);
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.3);
  } else {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.15);
  }

  level.rk_tuning_override = ::hearttunedata;
  level.rk_solo_tuning_override = ::heartsolotunedata;
  var_01 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_01) {
    heartsolotunedata(level.agenttunedata["ratking"]);
  } else {
    hearttunedata(level.agenttunedata["ratking"]);
  }

  level.rat_king.shouldteleportthreshold = 0;
  startheartquestfunctionality();
  level.rat_king.shouldteleportthreshold = undefined;
  level restorerktuning();
  level notify("relic_quest_completed");
  togglepgability("chillin", 1);
  togglepgability("revive_player", 1);
  togglepgability("teleport_attack", 1);
  togglepgability("melee_attack", 1);
  togglepgability("return_home", 1);
  togglepgability("wait", 1);
}

hearttunedata(param_00) {
  param_00.min_path_dist_for_teleport = 400;
  param_00.no_los_wait_time_before_teleport = 1000;
  param_00.min_time_between_teleports = 2000;
  param_00.min_teleport_dist_to_player = 300;
  param_00.max_teleport_dist_to_player = 700;
  param_00.telefrag_dist_sq = 576;
  param_00.attempt_teleport_if_no_engagement_within_time = 4000;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
  param_00.staff_shield_attack_min_dist_sq = 90000;
  param_00.staff_shield_attack_max_dist_sq = 6250000;
  param_00.staff_shield_attack_interval_min = 50;
  param_00.staff_shield_attack_interval_max = 1000;
  param_00.min_clear_los_time_before_shield_attack = 1;
}

heartsolotunedata(param_00) {
  param_00.min_path_dist_for_teleport = 400;
  param_00.no_los_wait_time_before_teleport = 1000;
  param_00.min_time_between_teleports = 2000;
  param_00.min_teleport_dist_to_player = 300;
  param_00.max_teleport_dist_to_player = 700;
  param_00.telefrag_dist_sq = 576;
  param_00.attempt_teleport_if_no_engagement_within_time = 4000;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
  param_00.staff_shield_attack_min_dist_sq = 90000;
  param_00.staff_shield_attack_max_dist_sq = 6250000;
  param_00.staff_shield_attack_interval_min = 1000;
  param_00.staff_shield_attack_interval_max = 2000;
  param_00.min_clear_los_time_before_shield_attack = 1;
}

startheartquestfunctionality() {
  var_00 = scripts\engine\utility::getstructarray("sewage_pool_start_loc", "targetname");
  var_01 = scripts\engine\utility::getstructarray("sewage_pool_loc", "script_noteworthy");
  var_02 = getent("slime_pool", "targetname");
  var_02.team = "axis";
  var_02.objective_icon = var_01.size;
  var_02.var_C1 = 0;
  var_03 = getent("arena_water", "targetname");
  var_02.activestructs = var_01;
  var_03 thread watchforplayerstouchingwater(var_03);
  var_02 thread clearsewageonzombiedeath(var_02, var_01);
  playsoundatpos((-1430.11, 1598.7, 204), "rk_sludge_pour_in_01");
  playsoundatpos((-324.67, 1597.21, 204), "rk_sludge_pour_in_02");
  playsoundatpos((-876.252, 2414.08, 204), "rk_sludge_pour_in_03");
  scripts\engine\utility::exploder(110);
  foreach(var_07, var_05 in var_01) {
    var_06 = spawn("script_model", var_05.origin);
    if(isDefined(var_05.angles)) {
      var_06.angles = var_05.angles;
    }

    var_06 setModel("tag_origin_sewage");
    var_05.pool = var_06;
    var_06 thread setsewagescriptable(var_06, var_07, var_05);
  }

  level thread watchforplayerinvolume(var_02, var_01);
  startsewageloop(var_00, var_01, var_02);
  foreach(var_05 in var_01) {
    if(isDefined(var_05.pool)) {
      var_05.pool delete();
    }
  }

  level notify("relic_quest_completed");
}

watchforplayerstouchingwater(param_00) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  for(;;) {
    var_01 = gettime();
    foreach(var_03 in level.players) {
      if(var_03 istouching(param_00)) {
        var_03 thread giveplayersludgeimmunity(var_03, var_01);
      }
    }

    wait(0.25);
  }
}

giveplayersludgeimmunity(param_00, param_01) {
  param_00 setscriptablepartstate("sludge_immunity", "inactive");
  param_00.sludge_immunity = param_01 + 5000;
}

unsetimmunutyaftertime(param_00) {
  param_00 notify("unsetImmunutyAfterTime");
  param_00 endon("unsetImmunutyAfterTime");
  level endon("game_ended");
  level endon("relic_quest_completed");
  param_00 endon("disconnect");
  wait(5);
  param_00 setscriptablepartstate("sludge_immunity", "inactive");
}

clearsewageonzombiedeath(param_00, param_01) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  for(;;) {
    level waittill("zombie_killed", var_02, var_03, var_04, var_05, var_06);
    if(!isplayer(var_05)) {
      continue;
    }

    if(isDefined(var_03) && var_03 == "iw7_fantrap_zm") {
      continue;
    }

    var_07 = scripts\engine\utility::getclosest(var_02, param_01, 128);
    if(!isDefined(var_07)) {
      continue;
    }

    if(!isDefined(var_07.pool)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_07.var_19)) {
      continue;
    }

    var_08 = var_07.pool;
    if(distance(var_02, var_07.origin) <= 128) {
      playFX(level._effect["rat_swarm_cheap"], var_02, anglesToForward(var_06.angles));
      thread cleanupsewage(var_08, param_00, var_07);
    }
  }
}

watchforplayerinvolume(param_00, param_01) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  for(;;) {
    param_00 waittill("trigger", var_02);
    if(!isplayer(var_02)) {
      continue;
    }

    if(!isalive(var_02) || scripts\engine\utility::istrue(var_02.inlaststand)) {
      continue;
    }

    var_03 = gettime();
    if(isDefined(var_02.sludge_immunity) && var_03 < var_02.sludge_immunity) {
      if(var_02.sludge_immunity - var_03 <= 2000) {
        var_02 setscriptablepartstate("sludge_immunity", "active_grn");
      }

      continue;
    }

    var_04 = scripts\engine\utility::getclosest(var_02.origin, param_01, 96);
    if(!isDefined(var_04) || !scripts\engine\utility::istrue(var_04.var_19)) {
      continue;
    }

    if(isDefined(var_02.nextsewageburntime)) {
      if(var_03 < var_02.nextsewageburntime) {
        continue;
      }
    }

    var_02.nextsewageburntime = var_03 + 1000;
    var_05 = 0.2 * var_02.maxhealth;
    var_02 playlocalsound("rk_sludge_damage_plr");
    var_02 dodamage(20, param_00.origin, param_00, param_00, "MOD_UNKNOWN");
  }
}

setsewagescriptable(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  if(isDefined(param_01)) {
    if(param_01 > 0) {
      wait(0.05 * param_01);
    }
  }

  param_02.var_19 = 1;
  param_00 setscriptablepartstate("blood_pool", "active");
}

cleanupsewage(param_00, param_01, param_02) {
  if(scripts\engine\utility::array_contains(param_01.activestructs, param_00)) {
    param_01.activestructs = scripts\engine\utility::array_remove(param_01.activestructs, param_00);
  }

  param_00 setscriptablepartstate("blood_pool", "neutral");
  param_02.var_19 = undefined;
  wait(0.25);
  param_01.var_C1++;
  level notify("1_pool_clean");
  if(param_01.var_C1 >= param_01.objective_icon) {
    param_01 notify("allPoolsClean");
  }
}

startsewageloop(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  param_02 endon("allPoolsClean");
  for(;;) {
    level waittill("1_pool_clean");
    if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
      wait(50);
    } else {
      wait(35);
    }

    param_02.activestructs = param_01;
    param_02.var_C1 = 0;
    param_02 playsoundtoteam("ww_magicbox_laughter", "allies");
    playsoundatpos((-1430.11, 1598.7, 204), "rk_sludge_pour_in_01");
    playsoundatpos((-324.67, 1597.21, 204), "rk_sludge_pour_in_02");
    playsoundatpos((-876.252, 2414.08, 204), "rk_sludge_pour_in_03");
    scripts\engine\utility::exploder(110);
    param_02 thread clearsewageonzombiedeath(param_02, param_01);
    foreach(var_06, var_04 in param_01) {
      if(!isDefined(var_04.pool)) {
        var_05 = spawn("script_model", var_04.origin);
        if(isDefined(var_04.angles)) {
          var_05.angles = var_04.angles;
        }

        var_05 setModel("tag_origin_sewage");
        var_04.pool = var_05;
      } else {
        var_05 = var_04.pool;
      }

      var_05 thread setsewagescriptable(var_05, var_06, var_04);
    }
  }
}

runbrainrelicquest(param_00) {
  level endon("game_ended");
  level waittill(param_00.relic + "_relic_placed_in_center");
  level.rat_king.shouldbeonplatform = undefined;
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning();
  scripts\cp\zombies\cp_disco_spawning::setmaxstaticspawns(16, 24, 24);
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.15);
  } else {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.05);
  }

  level.rk_tuning_override = ::brainrelictunedata;
  level.rk_solo_tuning_override = ::solobrainrelictunedata;
  level.solorkstagetoggles = ::brainattacksettings;
  level.rkstagetoggles = ::brainattacksettings;
  brainattacksettings();
  var_01 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_01) {
    brainrelictunedata(level.agenttunedata["ratking"]);
  } else {
    brainrelictunedata(level.agenttunedata["ratking"]);
  }

  level.rat_king.battackzombies = 1;
  level.rat_king.shouldteleportthreshold = 0;
  runbrainrelicquestinternal(param_00);
  togglerkability("attack_zombies", 0);
  level restorerktuning();
  level.rat_king.shouldteleportthreshold = undefined;
  level.rat_king.battackzombies = undefined;
  togglepgability("chillin", 1);
  togglepgability("revive_player", 1);
  togglepgability("teleport_attack", 1);
  togglepgability("melee_attack", 1);
  togglepgability("return_home", 1);
  togglepgability("wait", 1);
}

brainattacksettings() {
  togglerkability("melee_attack", 1);
  togglerkability("staff_stomp", 1);
  togglerkability("summon", 0);
  togglerkability("block", 0);
  togglerkability("staff_projectile", 0);
  togglerkability("shield_attack", 0);
  togglerkability("shield_attack_spot", 0);
  togglerkability("teleport", 1);
  togglerkability("attack_zombies", 1);
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
}

runbrainrelicquestinternal(param_00) {
  level.brainattractorstruct = param_00;
  param_00.targeting = [];
  level thread runbrainattractor(param_00);
  param_00 waitforbraindestroyed(param_00);
  level notify("relic_quest_completed");
}

getbrainattractorzombies() {
  if(isDefined(level.brainattractorstruct) && isDefined(level.brainattractorstruct.targeting)) {
    return level.brainattractorstruct.targeting;
  }

  return [];
}

waitforbraindestroyed(param_00) {
  level endon("game_ended");
  var_01 = level.rk_center_arena_struct.origin;
  var_02 = 0;
  var_03 = 100;
  while(var_02 < var_03) {
    var_04 = 0;
    foreach(var_06 in param_00.targeting) {
      if(distance(var_06.origin, var_01) <= 100) {
        var_04 = 1;
        var_02++;
        break;
      }
    }

    wait(1);
  }

  foreach(var_06 in param_00.targeting) {
    thread unsetbrainattibures(var_06);
  }
}

unsetbrainattibures(param_00) {
  if(isalive(param_00) && param_00.health >= 1) {
    param_00 setscriptablepartstate("eyes", "yellow_eyes");
  }

  if(isDefined(param_00.brainpos)) {
    var_01 = param_00.brainpos;
    var_01.claimed = undefined;
  }

  param_00.scripted_mode = 0;
  param_00 give_mp_super_weapon(param_00.origin);
  param_00.precacheleaderboards = 0;
  param_00.ignoreme = 0;
  param_00.attackent = undefined;
}

runbrainattractor(param_00) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_01 = level.rk_center_arena_struct.origin;
  for(;;) {
    getvalidalivezombies(param_00, 4, var_01);
    foreach(var_03 in param_00.targeting) {
      param_00 thread sendtargetstobrain(param_00, var_03, var_01);
    }

    wait(5);
  }
}

cleanupattractedzombies(param_00) {
  var_01 = [];
  foreach(var_03 in param_00.targeting) {
    if(isalive(var_03) && var_03.health >= 1) {
      var_01[var_01.size] = var_03;
    }
  }

  param_00.targeting = var_01;
}

getvalidalivezombies(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  cleanupattractedzombies(param_00);
  if(param_00.targeting.size >= param_01) {
    return;
  }

  var_03 = scripts\mp\mp_agent::getactiveagentsoftype("generic_zombie");
  var_04 = scripts\engine\utility::get_array_of_closest(param_02, var_03, undefined, 24, 1000);
  foreach(var_06 in var_04) {
    if(param_00.targeting.size >= param_01) {
      break;
    }

    if(scripts\engine\utility::array_contains(param_00.targeting, var_06)) {
      continue;
    }

    if(var_06.health < 1) {
      continue;
    }

    if(!isalive(var_06)) {
      continue;
    }

    if(abs(var_06.origin[2] - param_02[2]) > 32) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_06.entered_playspace)) {
      param_00.targeting[param_00.targeting.size] = var_06;
    }
  }
}

sendtargetstobrain(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  param_01 endon("death");
  if(param_01.health >= 1) {
    param_01 setscriptablepartstate("eyes", "turned_eyes", 1);
  }

  param_01 thread cleanupbrainvarsondeath(param_01);
  param_01.scripted_mode = 1;
  param_01.attackent = param_00.model;
  var_03 = getvalidbrainpos(param_01);
  param_01.brainpos = var_03;
  param_01 give_mp_super_weapon(var_03.origin);
  param_01.precacheleaderboards = 1;
  param_01.ignoreme = 1;
}

getvalidbrainpos(param_00) {
  var_01 = scripts\engine\utility::getstructarray("brain_targets", "targetname");
  var_02 = sortbydistance(var_01, param_00.origin);
  foreach(var_04 in var_02) {
    if(scripts\engine\utility::istrue(var_04.claimed)) {
      continue;
    }

    var_04.claimed = 1;
    return var_04;
  }

  return var_02[0];
}

cleanupbrainvarsondeath(param_00) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  param_00 waittill("death");
  unsetbrainattibures(param_00);
}

runeyerelicquest(param_00) {
  level endon("game_ended");
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(0);
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["sprint", "walk"]);
  scripts\cp\zombies\cp_disco_spawning::setmaxstaticspawns(16, 24, 24);
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.3);
  } else {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.15);
  }

  level waittill(param_00.relic + "_relic_placed_in_center");
  level.solorkstagetoggles = ::setstage2attackpriorities;
  level.rkstagetoggles = ::setstage2attackpriorities;
  level.rk_tuning_override = ::setupeyerelictunedata;
  level.rk_solo_tuning_override = ::setupsoloeyerelictunedata;
  var_01 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_01) {
    setupsoloeyerelictunedata(level.agenttunedata["ratking"]);
  } else {
    setupeyerelictunedata(level.agenttunedata["ratking"]);
  }

  setstage2attackpriorities();
  var_02 = scripts\engine\utility::getstructarray("rk_eye_damage_structs", "targetname");
  var_02 = scripts\engine\utility::array_randomize_objects(var_02);
  level.all_eye_targets = var_02;
  param_00.objective_icon = getmaxactivetargets();
  param_00.var_C1 = 0;
  level.active_eye_targets = [];
  level.inactive_eye_targets = [];
  var_03 = getmaxactivetargets();
  for(var_04 = 0; var_04 < var_02.size; var_04++) {
    var_05 = var_02[var_04];
    if(var_04 < var_03) {
      var_05 thread watchforraceresults(var_05, param_00, 1);
      continue;
    }

    var_05 thread watchforraceresults(var_05, param_00);
  }

  level thread watchforeyestructactive();
  level thread watchplayerforeyerelicuse();
}

watchplayerforeyerelicuse() {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_00 = level.rk_center_arena_struct.origin;
  for(;;) {
    level waittill("rat_king_eye_activated");
    level thread watchforeyestructactive();
  }
}

watchforeyestructactive() {
  level notify("watchForEyeStructActive");
  level endon("watchForEyeStructActive");
  level endon("game_ended");
  level endon("relic_quest_completed");
  foreach(var_01 in level.active_eye_targets) {
    if(isDefined(var_01.model)) {
      var_01.model setscriptablepartstate("targets", "neutral");
    }
  }

  var_03 = level.rk_center_arena_struct.origin;
  for(;;) {
    playeyeeffects(var_03);
    scripts\engine\utility::flag_set("eye_active");
    foreach(var_01 in level.active_eye_targets) {
      if(isDefined(var_01.model)) {
        var_01.model setscriptablepartstate("targets", "active");
      }
    }

    wait(5);
    scripts\engine\utility::flag_clear("eye_active");
    foreach(var_01 in level.active_eye_targets) {
      if(isDefined(var_01.model)) {
        var_01.model setscriptablepartstate("targets", "neutral");
      }
    }

    wait(5);
  }
}

playeyeeffects(param_00) {
  playsoundatpos(param_00, "rk_eye_pulse_lr");
  playFX(level._effect["rat_eye_rats"], param_00);
  wait(0.1);
}

getmaxactivetargets() {
  var_00 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_00) {
    return 12;
  }

  return 20;
}

solobrainrelictunedata(param_00) {
  param_00.min_path_dist_for_teleport = 100;
  param_00.no_los_wait_time_before_teleport = 1;
  param_00.min_time_between_teleports = 1000;
  param_00.min_teleport_dist_to_player = 25;
  param_00.max_teleport_dist_to_player = 5000;
  param_00.attempt_teleport_if_no_engagement_within_time = 50;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 625;
  param_00.staff_stomp_inner_radius_sq = 2500;
  param_00.staff_stomp_outer_radius_sq = 22500;
  param_00.staff_stomp_damage_radius = 175;
  param_00.staff_stomp_interval = 2000;
  param_00.staff_stomp_inner_interval = 3000;
  param_00.staff_stomp_max_damage = 200;
  param_00.staff_stomp_min_damage = 30;
}

brainrelictunedata(param_00) {
  param_00.min_path_dist_for_teleport = 100;
  param_00.no_los_wait_time_before_teleport = 1;
  param_00.min_time_between_teleports = 1000;
  param_00.min_teleport_dist_to_player = 25;
  param_00.max_teleport_dist_to_player = 5000;
  param_00.attempt_teleport_if_no_engagement_within_time = 50;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 625;
  param_00.staff_stomp_inner_radius_sq = 2500;
  param_00.staff_stomp_outer_radius_sq = 22500;
  param_00.staff_stomp_damage_radius = 175;
  param_00.staff_stomp_interval = 2000;
  param_00.staff_stomp_inner_interval = 3000;
  param_00.staff_stomp_max_damage = 200;
  param_00.staff_stomp_min_damage = 30;
}

setupstartingeyerelictunedata(param_00) {
  param_00.min_path_dist_for_teleport = 100;
  param_00.no_los_wait_time_before_teleport = 1;
  param_00.min_time_between_teleports = 2000;
  param_00.min_teleport_dist_to_player = 999999;
  param_00.max_teleport_dist_to_player = 1000000;
  param_00.attempt_teleport_if_no_engagement_within_time = 50;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 625;
  param_00.min_moving_pain_dist = 128;
}

setupsoloeyerelictunedata(param_00) {
  param_00.need_to_block_damage_threshold = 20;
  param_00.max_time_after_last_damage_to_block = 1000;
  param_00.block_chance = 100;
  param_00.min_block_time = 10000;
  param_00.max_block_time = 10001;
  param_00.quit_block_if_no_damage_time = 3000;
  param_00.min_block_interval = 15000;
  param_00.max_block_interval = 20000;
  param_00.staff_shield_attack_min_dist_sq = 90000;
  param_00.staff_shield_attack_max_dist_sq = 25000000;
  param_00.staff_shield_attack_interval_min = 2000;
  param_00.staff_shield_attack_interval_max = 2001;
  param_00.min_clear_los_time_before_shield_attack = 50;
  param_00.min_path_dist_for_teleport = 200;
  param_00.no_los_wait_time_before_teleport = 1;
  param_00.min_time_between_teleports = 2000;
  param_00.min_teleport_dist_to_player = 25;
  param_00.max_teleport_dist_to_player = 5000;
  param_00.attempt_teleport_if_no_engagement_within_time = 100;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
}

setupeyerelictunedata(param_00) {
  param_00.need_to_block_damage_threshold = 20;
  param_00.max_time_after_last_damage_to_block = 1000;
  param_00.block_chance = 100;
  param_00.min_block_time = 10000;
  param_00.max_block_time = 10001;
  param_00.quit_block_if_no_damage_time = 2000;
  param_00.min_block_interval = 15000;
  param_00.max_block_interval = 20000;
  param_00.staff_shield_attack_min_dist_sq = 90000;
  param_00.staff_shield_attack_max_dist_sq = 25000000;
  param_00.staff_shield_attack_interval_min = 2000;
  param_00.staff_shield_attack_interval_max = 2001;
  param_00.min_clear_los_time_before_shield_attack = 50;
  param_00.min_path_dist_for_teleport = 200;
  param_00.no_los_wait_time_before_teleport = 1;
  param_00.min_time_between_teleports = 10000;
  param_00.min_teleport_dist_to_player = 25;
  param_00.max_teleport_dist_to_player = 5000;
  param_00.attempt_teleport_if_no_engagement_within_time = 2000;
  param_00.teleport_min_dist_to_enemy_to_teleport_sq = 90000;
}

restorerktuning() {
  if(level.players.size == 1) {
    [[level.soloratkingtuning]](level.agenttunedata["ratking"]);
    return;
  }

  [
    [level.ratkingtuning]
  ](level.agenttunedata["ratking"]);
}

setstage2attackpriorities() {
  togglerkability("melee_attack", 0);
  togglerkability("staff_stomp", 0);
  togglerkability("summon", 0);
  togglerkability("block", 1);
  togglerkability("staff_projectile", 0);
  togglerkability("shield_attack", 1);
  togglerkability("shield_attack_spot", 1);
  togglerkability("teleport", 1);
  level.rat_king_attack_priorities = [];
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
  level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
}

watchforraceresults(param_00, param_01, param_02) {
  if(!isDefined(param_00.model)) {
    var_03 = spawn("script_model", param_00.origin);
    if(isDefined(param_00.angles)) {
      var_03.angles = param_00.angles;
    } else {
      var_03.angles = (0, 0, 0);
    }

    var_03 setModel("eye_quest_targets");
    param_00.model = var_03;
  } else {
    var_03 = param_01.model;
  }

  if(scripts\engine\utility::istrue(param_02)) {
    activateeyestruct(param_00);
    var_03 thread checkraceresults(param_00, param_01, param_02);
    if(scripts\engine\utility::flag("eye_active")) {
      var_03 setscriptablepartstate("targets", "active");
      return;
    }

    return;
  }

  deactivateeyestruct(param_00);
  var_03 thread checkraceresults(param_00, param_01, param_02);
  var_03 setscriptablepartstate("targets", "neutral");
}

deactivateeyestruct(param_00) {
  level.inactive_eye_targets[level.inactive_eye_targets.size] = param_00;
  if(scripts\engine\utility::array_contains(level.active_eye_targets, param_00)) {
    level.active_eye_targets = scripts\engine\utility::array_remove(level.active_eye_targets, param_00);
  }

  level.active_eye_targets = scripts\engine\utility::array_removeundefined(level.active_eye_targets);
  level.inactive_eye_targets = scripts\engine\utility::array_removeundefined(level.inactive_eye_targets);
  level.active_eye_targets = scripts\engine\utility::array_remove_duplicates(level.active_eye_targets);
  level.inactive_eye_targets = scripts\engine\utility::array_remove_duplicates(level.inactive_eye_targets);
}

activateeyestruct(param_00) {
  level.active_eye_targets[level.active_eye_targets.size] = param_00;
  if(scripts\engine\utility::array_contains(level.inactive_eye_targets, param_00)) {
    level.inactive_eye_targets = scripts\engine\utility::array_remove(level.inactive_eye_targets, param_00);
  }

  level.active_eye_targets = scripts\engine\utility::array_removeundefined(level.active_eye_targets);
  level.inactive_eye_targets = scripts\engine\utility::array_removeundefined(level.inactive_eye_targets);
  level.active_eye_targets = scripts\engine\utility::array_remove_duplicates(level.active_eye_targets);
  level.inactive_eye_targets = scripts\engine\utility::array_remove_duplicates(level.inactive_eye_targets);
}

checkraceresults(param_00, param_01, param_02) {
  param_00 notify("checkRaceResults");
  param_00 endon("checkRaceResults");
  level endon("game_ended");
  level endon("relic_quest_completed");
  self.health = 1000000;
  self.maxhealth = 1000000;
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_03, var_04, var_05, var_06);
    if(isplayer(var_04) && scripts\engine\utility::flag("eye_active")) {
      if(!scripts\engine\utility::array_contains(level.active_eye_targets, param_00)) {
        continue;
      }

      if(!isalive(var_04) || scripts\engine\utility::istrue(var_04.inlaststand)) {
        continue;
      }

      deactivateeyestruct(param_00);
      thread settargetscriptablestates(param_00);
      if(level.active_eye_targets.size <= 0) {
        togglepgability("chillin", 1);
        togglepgability("revive_player", 1);
        togglepgability("teleport_attack", 1);
        togglepgability("melee_attack", 1);
        togglepgability("return_home", 1);
        togglepgability("wait", 1);
        scripts\cp\zombies\cp_disco_spawning::unsetzombiemovespeed();
        level restorerktuning();
        level.rat_king.shouldbeonplatform = undefined;
        cleanupeyestructs();
        level notify("relic_quest_completed");
        scripts\engine\utility::flag_clear("eye_active");
      }

      continue;
    }

    if(level.active_eye_targets.size < param_01.objective_icon) {
      self setscriptablepartstate("impact", "active");
      thread setupneweyetarget(param_01, param_00);
    }
  }
}

canspawneyetarget() {
  if(!isDefined(level.active_eye_targets)) {
    return 0;
  }

  if(level.active_eye_targets.size < getmaxactivetargets()) {
    return 1;
  }

  return 0;
}

cleanupeyestructs() {
  if(isDefined(level.all_eye_targets)) {
    foreach(var_01 in level.all_eye_targets) {
      if(isDefined(var_01.model)) {
        var_01.model delete();
        var_01.model = undefined;
      }
    }
  }

  level.all_eye_targets = undefined;
  level.active_eye_targets = undefined;
  level.inactive_eye_targets = undefined;
}

settargetscriptablestates(param_00) {
  level endon("game_ended");
  self endon("death");
  self setscriptablepartstate("targets", "dead");
}

setupneweyetarget(param_00, param_01) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  param_01 thread watchforraceresults(param_01, param_00, 1);
}

pickuprkrelic(param_00, param_01) {
  scripts\engine\utility::flag_clear("rk_fight_relic_stage");
  level notify("relic_selected", param_00);
  activatecenterstruct();
  param_00 thread setrelicscriptablestates(param_00);
  if(param_00.relic == "heart") {
    param_01 playlocalsound("rk_relic_heart_pickup_plr");
  } else if(param_00.relic == "brain") {
    param_01 playlocalsound("rk_relic_brain_pickup_plr");
  } else {
    param_01 playlocalsound("rk_relic_eye_pickup_plr");
  }

  param_01 thread play_relic_vo(param_00.relic);
}

play_relic_vo(param_00) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  wait(1);
  switch (param_00) {
    case "heart":
      thread scripts\cp\cp_vo::try_to_play_vo("pam_quest_ratking_heart_return", "pam_dialogue_vo", "highest", 100, 1);
      break;

    case "brain":
      thread scripts\cp\cp_vo::try_to_play_vo("pam_quest_ratking_brain_return", "pam_dialogue_vo", "highest", 100, 1);
      break;

    case "eye":
      thread scripts\cp\cp_vo::try_to_play_vo("pam_quest_ratking_eye_return", "pam_dialogue_vo", "highest", 100, 1);
      break;
  }
}

activatecenterstruct() {
  var_00 = level.rk_center_arena_struct.origin;
  var_01 = spawnfx(level._effect["relic_center"], var_00);
  if(isDefined(level.rk_center_arena_struct.fx)) {
    level.rk_center_arena_struct.fx delete();
  }

  level.rk_center_arena_struct.fx = var_01;
  triggerfx(var_01);
}

deactivatecenterstruct() {
  var_00 = level.rk_center_arena_struct.origin;
  if(isDefined(level.rk_center_arena_struct.fx)) {
    level.rk_center_arena_struct.fx delete();
  }
}

setrelicscriptablestates(param_00) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  param_00.model setscriptablepartstate("interactions", "pickup");
  param_00.model setscriptablepartstate("rk_models", param_00.relic + "_picked");
  wait(0.5);
  if(isDefined(param_00.fx)) {
    param_00.fx delete();
  }

  if(isDefined(param_00.model)) {
    param_00.model delete();
  }

  deactivaterelics();
}

rkrelic_hint_func(param_00, param_01) {
  return "";
}

rkdebug_hint_func(param_00, param_01) {
  return &"CP_DISCO_INTERACTIONS_ENTER_THIS_AREA";
}

userkdebug(param_00, param_01) {}

open_sesame(param_00) {
  if(scripts\engine\utility::istrue(param_00)) {
    level.open_sesame = undefined;
  } else if(scripts\engine\utility::istrue(level.open_sesame)) {
    level.open_sesame = undefined;
    return;
  } else {
    level.open_sesame = 1;
  }

  foreach(var_02 in level.generators) {
    thread scripts\cp\zombies\zombie_power::generic_generator(var_02);
    wait(0.1);
  }

  if(isDefined(level.fast_travel_spots)) {
    foreach(var_05 in level.fast_travel_spots) {
      var_05.used_once = 1;
    }
  }

  var_07 = getEntArray("door_buy", "targetname");
  foreach(var_09 in var_07) {
    var_09 notify("trigger", "open_sesame");
    wait(0.1);
  }

  var_0B = getEntArray("chi_door", "targetname");
  foreach(var_09 in var_0B) {
    var_09.physics_capsulecast notify("damage", undefined, "open_sesame");
    wait(0.1);
  }

  level.moon_donations = 3;
  level.kepler_donations = 3;
  level.triton_donations = 3;
  if(isDefined(level.team_killdoors)) {
    foreach(var_0F in level.team_killdoors) {
      var_0F scripts\cp\zombies\zombie_doors::open_team_killdoor(level.players[0]);
    }
  }

  var_11 = scripts\engine\utility::getstructarray("interaction", "targetname");
  foreach(var_13 in var_11) {
    var_14 = scripts\engine\utility::getstructarray(var_13.script_noteworthy, "script_noteworthy");
    foreach(var_16 in var_14) {
      if(isDefined(var_16.target) && isDefined(var_13.target)) {
        if(var_16.target == var_13.target && var_16 != var_13) {
          if(scripts\engine\utility::array_contains(var_11, var_16)) {
            var_11 = scripts\engine\utility::array_remove(var_11, var_16);
          }
        }
      }
    }

    if(scripts\cp\cp_interaction::interaction_is_door_buy(var_13)) {
      if(!isDefined(var_13.script_noteworthy)) {
        continue;
      }

      if(var_13.script_noteworthy == "team_door_switch") {
        scripts\cp\zombies\interaction_openareas::use_team_door_switch(var_13, level.players[0]);
      }
    }
  }
}

setupplayerloadouts() {
  var_00 = ["iw7_ar57_zm", "iw7_m4_zm", "iw7_erad_zm"];
  var_01 = ["iw7_crb_zml", "iw7_lmg03_zm", "iw7_mauler_zm"];
  var_02 = ["snake", "crane", "dragon", "tiger"];
  var_03 = ["perk_machine_revive", "perk_machine_flash", "perk_machine_tough", "perk_machine_run", "perk_machine_rat_a_tat"];
  foreach(var_05 in level.players) {
    var_06 = randomint(var_01.size);
    var_07 = randomint(var_00.size);
    var_08 = randomint(var_02.size);
    var_05 takeweapon(var_05 scripts\cp\utility::getvalidtakeweapon());
    var_09 = scripts\cp\utility::getrawbaseweaponname(var_01[var_06]);
    if(isDefined(var_05.weapon_build_models[var_09])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_05, var_05.weapon_build_models[var_09]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_05, var_01[var_06]);
    }

    var_0A = scripts\cp\utility::getrawbaseweaponname(var_00[var_07]);
    if(isDefined(var_05.weapon_build_models[var_0A])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_05, var_05.weapon_build_models[var_0A]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_05, var_01[var_06]);
    }

    var_05 thread scripts\cp\powers\coop_powers::givepower("power_rat_king_eye", "secondary", undefined, undefined, undefined, 1, 1);
    var_05 thread scripts\cp\powers\coop_powers::givepower("power_heart", "primary", undefined, undefined, undefined, undefined, 1);
    var_05.total_currency_earned = min(10000, var_05 scripts\cp\cp_persistence::get_player_max_currency());
    var_05 scripts\cp\cp_persistence::set_player_currency(10000);
    var_05.kung_fu_progression.active_discipline = var_02[var_08];
    var_05.kung_fu_progression.disciplines_levels[var_02[var_08]] = 3;
    switch (var_02[var_08]) {
      case "tiger":
        var_0B = 3;
        var_05 setclientomnvar("ui_intel_active_index", var_0B);
        break;

      case "snake":
        var_0B = 6;
        var_05 setclientomnvar("ui_intel_active_index", var_0B);
        break;

      case "crane":
        var_0B = 4;
        var_05 setclientomnvar("ui_intel_active_index", var_0B);
        break;

      case "dragon":
        var_0B = 5;
        var_05 setclientomnvar("ui_intel_active_index", var_0B);
        break;
    }

    level thread scripts\cp\maps\cp_disco\cp_disco_challenges::chi_challenge_activate(var_05);
    var_05 scripts\cp\cp_interaction::refresh_interaction();
    var_05 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_05);
    var_05 thread scripts\cp\maps\cp_disco\kung_fu_mode::set_gourd(var_05);
    var_05 scripts\cp\maps\cp_disco\kung_fu_mode::checkgourdstates(undefined, var_05);
    if(!scripts\engine\utility::istrue(var_05.style_chosen)) {
      var_05.style_chosen = 1;
      var_05 setclientomnvar("zm_ui_show_general", 0);
    }

    foreach(var_0D in var_03) {
      var_05 thread scripts\cp\zombies\zombies_perk_machines::give_zombies_perk_immediate(var_0D, 1);
    }
  }

  if(isDefined(level.pap_max) && level.pap_max < 3) {
    level.pap_max++;
  }

  level[[level.upgrade_weapons_func]]();
  level thread[[level.upgrade_weapons_func]]();
}

userkarenacenter(param_00, param_01) {
  if(!isDefined(level.current_relic)) {
    return;
  }

  param_00 scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  deactivatecenterstruct();
  if(level.current_relic == "heart") {
    param_01 playlocalsound("rk_relic_heart_placement_plr");
  } else if(level.current_relic == "brain") {
    param_01 playlocalsound("rk_relic_brain_placement_plr");
  } else {
    param_01 playlocalsound("rk_relic_eye_placement_plr");
  }

  level notify(level.current_relic + "_relic_placed_in_center");
  scripts\engine\utility::flag_set("relic_active");
  level notify("center_arena_struct_used");
  level.rat_king.outofplayspace = undefined;
  level.rat_king setethereal(0);
  setcenterscriptablestates(param_00);
  param_00 thread watchforstagecomplete(param_00);
}

watchforstagecomplete(param_00) {
  level endon("game_ended");
  level waittill("relic_quest_completed");
  param_00.model setscriptablepartstate("rk_models", "neutral");
  wait(0.25);
  param_00.model.origin = param_00.origin + (0, 0, 4);
}

setcenterscriptablestates(param_00) {
  param_00.model setscriptablepartstate("interactions", "place");
  param_00.model setscriptablepartstate("rk_models", "active_" + level.current_relic);
  param_00.model thread startcenteractiveloop(param_00);
  level.current_relic = undefined;
}

startcenteractiveloop(param_00) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  param_00 endon("relic_deactivated");
  self endon("death");
  for(;;) {
    var_01 = randomfloatrange(2, 4);
    self moveto(self.origin + (0, 0, 32), var_01);
    wait(var_01);
    self moveto(self.origin + (0, 0, -32), var_01);
    wait(var_01);
  }
}

rkarenacenter_hint_func(param_00, param_01) {
  return "";
}

waitforrkoutofplayspace() {
  level endon("game_ended");
  level endon("center_arena_struct_used");
  level.rat_king endon("death");
  level.rat_king waittill("teleport_to_platform");
  level.rat_king setethereal(1);
  level.rat_king.outofplayspace = 1;
}

forcerkteleport() {
  level.rat_king.force_teleport = 1;
}

clean_up_rk_barriers() {
  if(isDefined(level.rk_barriers) && level.rk_barriers.size > 0) {
    foreach(var_01 in level.rk_barriers) {
      var_01 delete();
    }
  }
}

togglerkability(param_00, param_01) {
  level.rat_king_toggles[param_00] = param_01;
}

togglepgability(param_00, param_01) {
  level.pam_grier_toggles[param_00] = param_01;
}

addstaffstompcooldown(param_00) {
  self.nextstaffstomptime = gettime() + param_00;
}

addinnerstaffstompcooldown(param_00) {
  self.nextstaffstompinnertime = gettime() + param_00;
}

addstaffprojcooldown(param_00) {
  self.nextstaffprojectiletime = gettime() + param_00;
}

addblockcooldown(param_00) {
  self.nextblocktime = gettime() + param_00;
}

disabledamageonratking() {
  level.rat_king.disabledamage = 1;
}

enabledamageonratking() {
  level.rat_king.disabledamage = undefined;
}

setrkhealth(param_00) {
  if(isDefined(param_00)) {
    level.rat_king.health = int(level.rat_king.maxhealth * param_00);
    return;
  }

  level.rat_king.health = int(level.rat_king.maxhealth);
}

watchfordamagestagecomplete(param_00, param_01) {
  level endon("game_ended");
  level.rat_king endon("death");
  var_02 = 0;
  for(;;) {
    level waittill("rat_king_damaged");
    if(!var_02 && level.rat_king.health <= int(level.rat_king.maxhealth * param_01)) {
      var_02 = 1;
      scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(1);
    }

    if(level.rat_king.health <= int(level.rat_king.maxhealth * param_00)) {
      level.rk_tuning_override = undefined;
      level.rk_solo_tuning_override = undefined;
      thread stagecomplete();
      level thread restorerktuning();
      break;
    }
  }
}

watchforrelicstagecomplete() {
  level endon("game_ended");
  level.rat_king endon("death");
  level waittill("relic_quest_completed");
  scripts\engine\utility::flag_clear("relic_active");
  enabledamageonratking();
  level.rat_king.shouldbeonplatform = undefined;
  level.rk_tuning_override = undefined;
  level.rk_solo_tuning_override = undefined;
  level.solorkstagetoggles = ::setdefaultrktoggles;
  level.rkstagetoggles = ::setdefaultrktoggles;
  if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.75);
  } else {
    scripts\cp\zombies\cp_disco_spawning::setspawndelayoverride(0.3);
  }

  foreach(var_01 in level.players) {
    if(scripts\engine\utility::istrue(var_01.inlaststand)) {
      var_01 notify("revive_success");
      scripts\cp\cp_laststand::clear_last_stand_timer(var_01);
      if(isDefined(var_01.reviveent)) {
        var_01.reviveent notify("revive_success");
      }
    }
  }

  try_drop_max_ammo();
  level thread restorerktuning();
  thread stagecomplete();
}

stagecomplete() {
  foreach(var_01 in level.players) {
    var_01 playsoundtoplayer("quest_stage_completed_gong_lr", var_01);
  }
}

enablerkspawners() {
  var_00 = scripts\engine\utility::getstructarray("static", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.groupname) && var_02.groupname == "rk_spawners") {
      var_02 scripts\cp\zombies\zombies_spawning::make_spawner_active();
    }
  }
}

katanahintfunc(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01.has_disco_soul_key)) {
    if(!scripts\engine\utility::flag("rk_fight_ended")) {
      return level.interaction_hintstrings["iw7_katana_zm"];
    }

    return "";
  }

  return "";
}

katanausefunc(param_00, param_01) {
  if(scripts\engine\utility::flag("rk_fight_ended")) {
    if(!param_01 hasanykatana(param_01)) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(param_01, "iw7_katana_zm");
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      return;
    }

    return;
  }

  if(scripts\engine\utility::istrue(param_01.has_disco_soul_key)) {
    if(!param_01 hasanykatana(param_01)) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(param_01, "iw7_katana_zm");
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      return;
    }

    return;
  }
}

hasanykatana(param_00) {
  var_01 = param_00 getweaponslistall();
  foreach(var_03 in var_01) {
    if(issubstr(var_03, "iw7_katana")) {
      return 1;
    }
  }

  return 0;
}

playratkingfightcompletevos() {
  level endon("game_ended");
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_finaldeath", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  wait(scripts\cp\cp_vo::get_sound_length("ww_ratking_finaldeath") + 5);
  level thread scripts\cp\cp_vo::try_to_play_vo("soul_key_1", "rave_dialogue_vo", "highest", 70, 0, 0, 1);
  wait(20);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_easteregg_complete", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  wait(scripts\cp\cp_vo::get_sound_length("ww_easteregg_complete") + 5);
}