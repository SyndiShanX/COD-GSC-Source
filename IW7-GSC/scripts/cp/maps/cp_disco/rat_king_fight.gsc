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
  var_0 = scripts\engine\utility::getstructarray("rk_perk_crate", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    if(isDefined(var_2.angles)) {
      var_3.angles = var_2.angles;
    }

    var_3 setModel("cp_disco_crates_rk");
    var_2.model = var_3;
    var_2.fx_struct = scripts\engine\utility::getclosest(var_2.origin, scripts\engine\utility::getstructarray("crate_fx", "script_noteworthy"));
    var_2 thread cratewaitfordamage(var_2);
  }
}

cratewaitfordamage(var_0) {
  level endon("game_ended");
  level endon("rk_fight_completed");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_wait("rk_fight_started");
  if(!isDefined(level.rat_king_bounce_structs)) {
    level.rat_king_bounce_structs = [];
  }

  level.rat_king_bounce_structs[level.rat_king_bounce_structs.size] = var_0;
  var_0.model.health = 99999999;
  var_0.model setCanDamage(1);
  for(;;) {
    var_0.model waittill("damage", var_1, var_2, var_1, var_1, var_1, var_1, var_1, var_1, var_1, var_3);
    if(isDefined(var_2) && (isDefined(level.rat_king) && var_2 == level.rat_king) || isDefined(var_3) && isplayer(var_2) && scripts\cp\maps\cp_disco\kung_fu_mode::iskungfuweapon(var_3)) {
      var_0 thread breakcrateandwait(var_0);
      break;
    } else {
      var_0.model.health = 99999999;
    }
  }
}

breakcrateandwait(var_0) {
  level endon("game_ended");
  var_0.model setscriptablepartstate("crate", "broken");
  var_0.model setCanDamage(0);
  thread throwperkboxes(var_0);
  level waittill("rk_fight_completed");
  var_0.model setscriptablepartstate("crate", "active");
  var_1 = scripts\engine\utility::getstructarray("perk_candy_box", "script_noteworthy");
  foreach(var_3 in var_1) {
    if(isDefined(var_3.model)) {
      var_3.model delete();
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
  }
}

init_rk_candy_interactions() {
  var_0 = scripts\engine\utility::getstructarray("perk_candy_box", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_3.parent_struct = var_2;
    var_2.fx_struct = var_3;
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
  }
}

activateparentinteraction(var_0) {
  var_1 = var_0.parent_struct;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

throwperkboxes(var_0) {
  var_1 = var_0.fx_struct;
  var_2 = scripts\engine\utility::array_randomize_objects(level.available_crate_perks);
  var_3 = scripts\engine\utility::random(var_2);
  level.available_crate_perks = scripts\engine\utility::array_remove(level.available_crate_perks, var_3);
  var_4 = spawn("script_model", var_1.origin);
  if(isDefined(var_1.angles)) {
    var_4.angles = var_1.angles;
  }

  var_4 setModel("tag_origin_rk_perks");
  var_1.model = var_4;
  var_1.parent_struct.perk = var_3;
  activateparentinteraction(var_1);
  switch (var_3) {
    case "perk_machine_fwoosh":
      var_4 setscriptablepartstate("effects", "fwoosh");
      break;

    case "perk_machine_zap":
      var_4 setscriptablepartstate("effects", "zap");
      break;

    case "perk_machine_boom":
      var_4 setscriptablepartstate("effects", "boom");
      break;

    case "perk_machine_deadeye":
      var_4 setscriptablepartstate("effects", "deadeye");
      break;

    case "perk_machine_smack":
      var_4 setscriptablepartstate("effects", "smack");
      break;

    case "perk_machine_revive":
      var_4 setscriptablepartstate("effects", "upNAtoms");
      break;

    case "perk_machine_flash":
      var_4 setscriptablepartstate("effects", "quickies");
      break;

    case "perk_machine_tough":
      var_4 setscriptablepartstate("effects", "tuff");
      break;

    case "perk_machine_run":
      var_4 setscriptablepartstate("effects", "run");
      break;

    case "perk_machine_rat_a_tat":
      var_4 setscriptablepartstate("effects", "bangs");
      break;

    default:
      var_4 setscriptablepartstate("effects", "neutral");
      break;
  }
}

addperkinteraction(var_0, var_1, var_2) {
  var_0.script_noteworthy = "perk_candy_box";
  var_0.perk = var_2;
  var_0.script_parameters = "default";
  var_0.requires_power = 0;
  var_0.powered_on = 1;
  var_0.name = "perk_candy_box";
  var_0.spend_type = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

perkbox_usefunc(var_0, var_1) {
  if(!isDefined(var_0.perk)) {
    return;
  }

  if(isDefined(var_1.zombies_perks) && var_1.zombies_perks.size > 4) {
    return;
  }

  if(var_1 scripts\cp\utility::has_zombie_perk(var_0.perk)) {
    return;
  }

  var_1 scripts\cp\zombies\zombies_perk_machines::give_zombies_perk(var_0.perk, 0);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  var_0.fx_struct.model hidefromplayer(var_1);
  var_1 playlocalsound("part_pickup");
  if(!isDefined(var_0.respawn_flag)) {
    var_0.respawn_flag = 1;
    level.num_crates_broken++;
    var_2 = level.num_crates_broken * 0.05;
    level.available_crate_perks[level.available_crate_perks.size] = var_0.perk;
    var_0 thread restockperkafternextrelic(var_0, var_1, var_2);
  }
}

restockperkafternextrelic(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("rk_fight_completed");
  level scripts\engine\utility::waittill_any_timeout_1(180, "relic_quest_completed");
  var_0.respawn_flag = undefined;
  level.num_crates_broken = 0;
  wait(var_2);
  var_3 = var_0.fx_struct.model;
  var_4 = scripts\engine\utility::array_randomize_objects(level.available_crate_perks);
  var_5 = scripts\engine\utility::random(var_4);
  var_0.perk = var_5;
  level.available_crate_perks = scripts\engine\utility::array_remove(level.available_crate_perks, var_5);
  switch (var_5) {
    case "perk_machine_fwoosh":
      var_3 setscriptablepartstate("effects", "fwoosh");
      break;

    case "perk_machine_zap":
      var_3 setscriptablepartstate("effects", "zap");
      break;

    case "perk_machine_boom":
      var_3 setscriptablepartstate("effects", "boom");
      break;

    case "perk_machine_deadeye":
      var_3 setscriptablepartstate("effects", "deadeye");
      break;

    case "perk_machine_smack":
      var_3 setscriptablepartstate("effects", "smack");
      break;

    case "perk_machine_revive":
      var_3 setscriptablepartstate("effects", "upNAtoms");
      break;

    case "perk_machine_flash":
      var_3 setscriptablepartstate("effects", "quickies");
      break;

    case "perk_machine_tough":
      var_3 setscriptablepartstate("effects", "tuff");
      break;

    case "perk_machine_run":
      var_3 setscriptablepartstate("effects", "run");
      break;

    case "perk_machine_rat_a_tat":
      var_3 setscriptablepartstate("effects", "bangs");
      break;

    default:
      var_3 setscriptablepartstate("effects", "neutral");
      break;
  }

  foreach(var_7 in level.players) {
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_7);
    var_0.fx_struct.model showtoplayer(var_7);
  }
}

perkbox_hintfunc(var_0, var_1) {
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
  var_0 = scripts\engine\utility::getstructarray("rk_player_spawns", "script_noteworthy");
  var_0 = scripts\engine\utility::array_randomize_objects(var_0);
  level thread setuprkfightpas();
  foreach(var_4, var_2 in level.players) {
    if(scripts\engine\utility::istrue(var_2.start_breaking_clock)) {
      var_2.start_breaking_clock = 0;
      var_2 notify("rat_king_fight_started");
    }

    if(scripts\engine\utility::istrue(var_2.inlaststand) || scripts\engine\utility::istrue(var_2.in_afterlife_arcade)) {
      scripts\cp\cp_laststand::clear_last_stand_timer(var_2);
      var_2 notify("revive_success");
      if(isDefined(var_2.reviveent)) {
        var_2.reviveent notify("revive_success");
      }
    }

    var_3 = var_0[var_4];
    var_2 thread setupplayerrkstart(var_2, var_3);
    if(var_2.vo_prefix == "p5_") {
      var_2 thread scripts\cp\cp_vo::try_to_play_vo("ratking_finalbattle", "disco_comment_vo");
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
  var_5 = scripts\engine\utility::getstructarray("rat_king_spawner", "targetname");
  var_6 = scripts\engine\utility::getclosest((-628.8, 1422.4, 178), var_5, 500);
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_ratking_finalspawn", "rave_announcer_vo", "highest", 70, 0, 0, 1);
  scripts\cp\maps\cp_disco\rat_king::spawn_rat_king(var_6.origin, var_6.angles, 1);
  rkintroresumeprogression();
  level thread respawngourds();
  level thread setuplnfinteractions();
  level thread max_ammo_manager();
  runrkfight();
}

disable_water_spawners() {
  if(isDefined(level.rat_king_lair_spawners)) {
    foreach(var_1 in level.rat_king_lair_spawners) {
      var_1 scripts\cp\zombies\zombies_spawning::make_spawner_inactive();
    }
  }
}

enable_water_spawners() {
  if(isDefined(level.rat_king_lair_spawners)) {
    foreach(var_1 in level.rat_king_lair_spawners) {
      var_1 scripts\cp\zombies\zombies_spawning::make_spawner_active();
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

setupplayerrkstart(var_0, var_1) {
  var_0 endon("disconnect");
  if(var_0 scripts\cp\utility::isteleportenabled()) {
    var_0 scripts\cp\utility::allow_player_teleport(0);
  }

  var_0 thread rkintroblackscreen();
  wait(1.25);
  if(!scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_0 setorigin(var_1.origin);
    var_0 setplayerangles(var_1.angles);
  }

  var_0.anchor = spawn("script_model", var_0.origin);
  var_0.anchor setModel("tag_origin");
  var_0.anchor.angles = var_1.angles;
  var_0 playerlinkto(var_0.anchor, "tag_origin", 0, 30, 30, 10, 10, 0);
}

rkintroresumeprogression(var_0) {
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

rkusegourdfunc(var_0) {
  thread scripts\cp\maps\cp_disco\kung_fu_mode::cooldown_struct(undefined, var_0);
}

respawninrkarena(var_0) {
  var_1 = scripts\engine\utility::getstructarray("rkRespawnLoc", "script_noteworthy");
  var_2 = scripts\cp\gametypes\zombie::get_respawn_loc_rated(level.players, var_1);
  return var_2;
}

setuplnfinteractions() {
  var_0 = scripts\engine\utility::getstructarray("lost_and_found", "script_noteworthy");
  var_1 = undefined;
  foreach(var_3 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
    if(isDefined(var_3.name) && var_3.name == "rk_fight") {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
      level.rk_lostnfound show();
      var_1 = var_3;
    }
  }

  foreach(var_6 in level.players) {
    if(!isDefined(var_6.lost_and_found_ent)) {
      continue;
    }

    var_6.lost_and_found_ent.origin = var_1.origin + (0, 0, 45);
  }
}

restorelnfinteractions() {
  var_0 = scripts\engine\utility::getstructarray("lost_and_found", "script_noteworthy");
  var_1 = undefined;
  foreach(var_3 in var_0) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
    if(isDefined(var_3.name) && var_3.name == "rk_fight") {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_3);
      continue;
    }

    var_1 = var_3;
  }

  foreach(var_6 in level.players) {
    if(!isDefined(var_6.lost_and_found_ent)) {
      continue;
    }

    var_6.lost_and_found_ent.origin = var_1.origin + (0, 0, 45);
  }

  level.rk_lostnfound hide();
}

respawngourds() {
  level endon("game_ended");
  level.rat_king endon("death");
  for(;;) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1.kung_fu_progression.active_discipline)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_1.has_gourd)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
        continue;
      }

      var_1.kung_fu_cooldown = undefined;
      var_1 notify("spawn_gourds");
      var_1 scripts\cp\maps\cp_disco\kung_fu_mode::checkgourdstates(undefined, var_1);
      var_1 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_1);
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
  foreach(var_1 in scripts\engine\utility::getstructarray("rk_fx_loc", "targetname")) {
    var_2 = spawn("script_model", var_1.origin);
    var_2.angles = var_1.angles;
    var_2 setModel("temp_dbl_door_barrier");
    if(level.rk_barriers.size == 0) {
      var_2 playLoopSound("rk_tunnel_blocker_left_lp");
    } else {
      var_2 playLoopSound("rk_tunnel_blocker_right_lp");
    }

    level.rk_barriers[level.rk_barriers.size] = var_2;
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
  [[level.rk_fight_stage_func[level.rat_king_stage]]]();
}

runrkstage1() {
  setrkhealth();
  setdefaultrktoggles();
  setdefaultpgtoggles();
  setdefaultattackpriorities();
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["walk"]);
  var_0 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(0);
  scripts\cp\zombies\cp_disco_spawning::setmaxstaticspawns(8, 16, 24);
  if(var_0) {
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
  var_0 = scripts\engine\utility::getstructarray("rk_relic_pos", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = spawnfx(level._effect["relic_active"], var_2.origin);
    if(isDefined(var_2.model)) {
      var_2.model thread startactiveloop(var_2, var_3);
    }
  }
}

startactiveloop(var_0, var_1) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_0 endon("relic_deactivated");
  self endon("death");
  self setscriptablepartstate("rk_models", "active_" + var_0.relic);
  if(isDefined(var_0.fx)) {
    var_0.fx delete();
  }

  var_0.fx = var_1;
  triggerfx(var_1);
  if(var_0.relic == "heart") {
    self playLoopSound("rk_relic_heart_lp");
  }

  if(var_0.relic == "eye") {
    self playLoopSound("rk_relic_eye_lp");
  }

  if(var_0.relic == "brain") {
    self playLoopSound("rk_relic_brain_lp");
  }

  for(;;) {
    var_2 = randomfloatrange(2, 4);
    self moveto(self.origin + (0, 0, 32), var_2);
    wait(var_2);
    self moveto(self.origin + (0, 0, -32), var_2);
    wait(var_2);
  }
}

deactivaterelics() {
  var_0 = scripts\engine\utility::getstructarray("rk_relic_pos", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.model)) {
      var_2 notify("relic_deactivated");
      var_2.model stoploopsound();
      var_2 thread moverelictoog(var_2);
    }
  }
}

moverelictoog(var_0) {
  if(isDefined(var_0.model)) {
    var_1 = spawnfx(level._effect["relic_idle"], var_0.origin);
    if(isDefined(var_0.ogpos)) {
      var_0.model moveto(var_0.ogpos, 0.5);
    }

    wait(0.5);
    if(isDefined(var_0.fx)) {
      var_0.fx delete();
    }

    var_0.fx = triggerfx(var_1);
    var_0.model setscriptablepartstate("rk_models", var_0.relic);
  }
}

runrkstage3() {
  setrkhealth(0.75);
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["run"]);
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(1);
  level.rk_tuning_override = ::stage3tunedata;
  level.rk_solo_tuning_override = ::stage3solotunedata;
  var_0 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  stage3attacksettings();
  if(var_0) {
    stage3solotunedata(level.agenttunedata["ratking"]);
  } else {
    stage3tunedata(level.agenttunedata["ratking"]);
  }

  watchfordamagestagecomplete(0.5, 0.6);
  increaserkstage();
}

stage3tunedata(var_0) {
  var_0.min_summon_interval = 10000;
  var_0.max_summon_interval = 20000;
  var_0.summon_chance = 100;
  var_0.summon_agent_type = "karatemaster";
  var_0.summon_min_spawn_num = 6;
  var_0.summon_max_spawn_num = 8;
  var_0.summon_min_radius = 100;
  var_0.summon_max_radius = 600;
  var_0.summon_spawn_min_dist_between_agents_sq = 2500;
  var_0.max_num_agents_to_allow_summon = 2;
  var_0.min_time_between_summon_rounds = 3000;
  var_0.need_to_block_damage_threshold = 20;
  var_0.max_time_after_last_damage_to_block = 1000;
  var_0.block_chance = 100;
  var_0.min_block_time = 5000;
  var_0.max_block_time = 10000;
  var_0.quit_block_if_no_damage_time = 2000;
  var_0.min_block_interval = 5000;
  var_0.max_block_interval = 10000;
  var_0.staff_stomp_inner_interval = 3000;
  var_0.staff_stomp_interval = 10000;
  var_0.staff_stomp_damage_radius = 175;
  var_0.staff_stomp_max_damage = 200;
  var_0.staff_stomp_min_damage = 30;
  var_0.min_path_dist_for_teleport = 300;
  var_0.no_los_wait_time_before_teleport = 500;
  var_0.min_time_between_teleports = 5000;
  var_0.min_teleport_dist_to_player = 400;
  var_0.max_teleport_dist_to_player = 1000;
  var_0.telefrag_dist_sq = 576;
  var_0.attempt_teleport_if_no_engagement_within_time = 2000;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = -25536;
}

stage3solotunedata(var_0) {
  var_0.min_summon_interval = 8000;
  var_0.max_summon_interval = 15000;
  var_0.summon_chance = 100;
  var_0.summon_agent_type = "karatemaster";
  var_0.summon_min_spawn_num = 6;
  var_0.summon_max_spawn_num = 8;
  var_0.summon_min_radius = 100;
  var_0.summon_max_radius = 600;
  var_0.summon_spawn_min_dist_between_agents_sq = 2500;
  var_0.max_num_agents_to_allow_summon = 1;
  var_0.min_time_between_summon_rounds = 3000;
  var_0.need_to_block_damage_threshold = 20;
  var_0.max_time_after_last_damage_to_block = 2000;
  var_0.block_chance = 100;
  var_0.min_block_time = 5000;
  var_0.max_block_time = 10000;
  var_0.quit_block_if_no_damage_time = 2000;
  var_0.min_block_interval = 10000;
  var_0.max_block_interval = 10001;
  var_0.staff_stomp_inner_radius_sq = 5625;
  var_0.staff_stomp_outer_radius_sq = 22500;
  var_0.staff_stomp_damage_radius = 175;
  var_0.staff_stomp_interval = 10000;
  var_0.staff_stomp_inner_interval = 3000;
  var_0.staff_stomp_max_damage = 200;
  var_0.staff_stomp_min_damage = 30;
  var_0.min_path_dist_for_teleport = 300;
  var_0.no_los_wait_time_before_teleport = 500;
  var_0.min_time_between_teleports = 5000;
  var_0.min_teleport_dist_to_player = 400;
  var_0.max_teleport_dist_to_player = 1000;
  var_0.telefrag_dist_sq = 576;
  var_0.attempt_teleport_if_no_engagement_within_time = 4000;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = -25536;
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

runrkstage4(var_0) {
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

runrkstage5(var_0) {
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

runrkstage6(var_0) {
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

runrkstage7(var_0) {
  setrkhealth(0.25);
  level thread scripts\cp\zombies\cp_disco_spawning::setzombiemovespeed(["slow_walk", "walk", "sprint", "sprint", "sprint"]);
  scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(0);
  scripts\cp\zombies\cp_disco_spawning::setwavenumoverride(30);
  var_1 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_1) {
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
  level waittill("rat_king_killed", var_0);
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    level thread scripts\cp\zombies\direct_boss_fight::success_sequence(6, 3);
    level notify("rk_fight_completed");
    return;
  }

  level.ratking_fight = undefined;
  foreach(var_2 in level.players) {
    var_2 thread scripts\cp\cp_merits::processmerit("mt_dlc2_rat_king");
    if(var_2.vo_prefix == "p5_") {
      var_2 scripts\cp\zombies\achievement::update_achievement("EXTERMINATOR", 1);
    }

    if(!var_2 scripts\cp\utility::isteleportenabled()) {
      var_2 scripts\cp\utility::allow_player_teleport(1);
    }

    var_2.ability_invulnerable = undefined;
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
  drop_soul_key(var_0 + (0, 0, 32));
  clean_up_rk_barriers();
  enable_water_spawners();
  thread cleanuprkfightoverrides();
  level notify("rk_fight_completed");
}

sound_duck_end_bink() {
  foreach(var_1 in level.players) {
    var_1 setsoundsubmix("bink_from_frontend", 1);
  }

  wait(55);
  foreach(var_1 in level.players) {
    var_1 clearsoundsubmix();
  }
}

spawnrkdeathmodel() {
  var_0 = spawn("script_model", level.rk_center_arena_struct.origin);
  var_0.angles = level.rk_center_arena_struct.angles;
}

cleanuprelics() {
  var_0 = scripts\engine\utility::getstructarray("rk_relic_pos", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.model)) {
      var_2.model delete();
    }

    if(isDefined(var_2.fx)) {
      var_2.fx delete();
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
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_2 in var_0) {
    var_2.died_poorly = 1;
    var_2.nocorpse = 1;
    var_2 suicide();
  }
}

drop_soul_key(var_0) {
  var_1 = var_0;
  if(isDefined(level.soul_key_drop_pos)) {
    var_1 = level.soul_key_drop_pos;
  }

  var_1 = check_drop_on_rafters(var_1);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin_soul_key");
  var_2 thread item_keep_rotating(var_2);
  var_2 thread soul_key_pick_up_monitor(var_2);
}

check_drop_on_rafters(var_0) {
  var_1 = (-873, 1821, 231);
  if(var_0[2] > 283) {
    return var_1;
  }

  return var_0;
}

item_keep_rotating(var_0) {
  var_0 endon("death");
  var_1 = var_0.angles;
  for(;;) {
    var_0 rotateto(var_1 + (randomintrange(-40, 40), randomintrange(-40, 90), randomintrange(-40, 90)), 3);
    wait(3);
  }
}

soul_key_pick_up_monitor(var_0) {
  var_0 endon("death");
  var_0 makeusable();
  var_0 sethintstring(&"CP_DISCO_INTERACTIONS_PICKUP_SOUL_KEY");
  for(;;) {
    var_0 waittill("trigger", var_1);
    scripts\cp\zombies\directors_cut::give_dc_player_extra_xp_for_carrying_newb();
    if(isplayer(var_1)) {
      var_1 playlocalsound("part_pickup");
      var_0 setscriptablepartstate("actions", "pickup");
      setplayerdataforplayers();
      break;
    }
  }

  level thread scripts\cp\zombies\directors_cut::try_drop_talisman(var_0.origin, vectortoangles((0, 1, 0)));
  var_0 delete();
}

setplayerdataforplayers() {
  foreach(var_1 in level.players) {
    var_1 setplayerdata("cp", "haveSoulKeys", "any_soul_key", 1);
    var_1 setplayerdata("cp", "haveSoulKeys", "soul_key_3", 1);
    var_1 scripts\cp\zombies\achievement::update_achievement("PEST_CONTROL", 1);
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
    var_0 = spawn("script_model", level.rk_center_arena_struct.origin + (0, 0, 4));
    var_0 setModel("tag_origin_rk_relics");
    if(isDefined(level.rk_center_arena_struct.angles)) {
      var_0.angles = level.rk_center_arena_struct.angles;
    }

    level.rk_center_arena_struct.model = var_0;
  }

  var_1 = scripts\engine\utility::getstructarray("rk_relic_pos", "script_noteworthy");
  var_2 = scripts\engine\utility::array_randomize_objects(["heart", "brain", "eye"]);
  foreach(var_5, var_4 in var_1) {
    var_4.ogpos = var_4.origin + (0, 0, 4);
    var_4.relic = var_2[var_5];
    var_4 thread waitforrkfightstart(var_4);
  }
}

waitforrkfightstart(var_0) {
  level endon("game_ended");
  var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::flag_wait("rk_fight_started");
  if(!isDefined(var_0.model)) {
    var_1 = spawnfx(level._effect["relic_idle"], var_0.origin);
    triggerfx(var_1);
    if(isDefined(var_0.fx)) {
      var_0.fx delete();
    }

    var_0.fx = var_1;
    var_2 = spawn("script_model", var_0.ogpos);
    if(isDefined(var_0.angles)) {
      var_2.angles = var_0.angles;
    } else {
      var_2.angles = (0, 0, 0);
    }

    var_2 setModel("tag_origin_rk_relics");
    var_2 setscriptablepartstate("rk_models", var_0.relic);
    var_0.model = var_2;
  } else {
    var_0.model setscriptablepartstate("rk_models", var_0.relic);
  }

  var_0 thread waitforrkrelicstage(var_0);
}

waitforrkrelicstage(var_0) {
  level endon("game_ended");
  for(;;) {
    scripts\engine\utility::flag_wait("rk_fight_relic_stage");
    disabledamageonratking();
    level.rat_king.shouldbeonplatform = 1;
    var_0 scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    if(var_0 waitforrelicselection(var_0)) {
      break;
    }
  }

  thread runrelicquest(var_0);
}

waitforrelicselection(var_0) {
  level endon("game_ended");
  level waittill("relic_selected", var_1);
  if(var_0 != var_1) {
    var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    return 0;
  }

  level.current_relic = var_0.relic;
  level.rk_center_arena_struct scripts\cp\cp_interaction::add_to_current_interaction_list(level.rk_center_arena_struct);
  return 1;
}

runrelicquest(var_0) {
  level endon("game_ended");
  switch (var_0.relic) {
    case "heart":
      thread runheartrelicquest(var_0);
      break;

    case "brain":
      thread runbrainrelicquest(var_0);
      break;

    case "eye":
      thread runeyerelicquest(var_0);
      break;
  }
}

runheartrelicquest(var_0) {
  level endon("game_ended");
  level waittill(var_0.relic + "_relic_placed_in_center");
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
  var_1 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_1) {
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

hearttunedata(var_0) {
  var_0.min_path_dist_for_teleport = 400;
  var_0.no_los_wait_time_before_teleport = 1000;
  var_0.min_time_between_teleports = 2000;
  var_0.min_teleport_dist_to_player = 300;
  var_0.max_teleport_dist_to_player = 700;
  var_0.telefrag_dist_sq = 576;
  var_0.attempt_teleport_if_no_engagement_within_time = 4000;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
  var_0.staff_shield_attack_min_dist_sq = 90000;
  var_0.staff_shield_attack_max_dist_sq = 6250000;
  var_0.staff_shield_attack_interval_min = 50;
  var_0.staff_shield_attack_interval_max = 1000;
  var_0.min_clear_los_time_before_shield_attack = 1;
}

heartsolotunedata(var_0) {
  var_0.min_path_dist_for_teleport = 400;
  var_0.no_los_wait_time_before_teleport = 1000;
  var_0.min_time_between_teleports = 2000;
  var_0.min_teleport_dist_to_player = 300;
  var_0.max_teleport_dist_to_player = 700;
  var_0.telefrag_dist_sq = 576;
  var_0.attempt_teleport_if_no_engagement_within_time = 4000;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
  var_0.staff_shield_attack_min_dist_sq = 90000;
  var_0.staff_shield_attack_max_dist_sq = 6250000;
  var_0.staff_shield_attack_interval_min = 1000;
  var_0.staff_shield_attack_interval_max = 2000;
  var_0.min_clear_los_time_before_shield_attack = 1;
}

startheartquestfunctionality() {
  var_0 = scripts\engine\utility::getstructarray("sewage_pool_start_loc", "targetname");
  var_1 = scripts\engine\utility::getstructarray("sewage_pool_loc", "script_noteworthy");
  var_2 = getent("slime_pool", "targetname");
  var_2.team = "axis";
  var_2.objective_icon = var_1.size;
  var_2.var_C1 = 0;
  var_3 = getent("arena_water", "targetname");
  var_2.activestructs = var_1;
  var_3 thread watchforplayerstouchingwater(var_3);
  var_2 thread clearsewageonzombiedeath(var_2, var_1);
  playsoundatpos((-1430.11, 1598.7, 204), "rk_sludge_pour_in_01");
  playsoundatpos((-324.67, 1597.21, 204), "rk_sludge_pour_in_02");
  playsoundatpos((-876.252, 2414.08, 204), "rk_sludge_pour_in_03");
  scripts\engine\utility::exploder(110);
  foreach(var_7, var_5 in var_1) {
    var_6 = spawn("script_model", var_5.origin);
    if(isDefined(var_5.angles)) {
      var_6.angles = var_5.angles;
    }

    var_6 setModel("tag_origin_sewage");
    var_5.pool = var_6;
    var_6 thread setsewagescriptable(var_6, var_7, var_5);
  }

  level thread watchforplayerinvolume(var_2, var_1);
  startsewageloop(var_0, var_1, var_2);
  foreach(var_5 in var_1) {
    if(isDefined(var_5.pool)) {
      var_5.pool delete();
    }
  }

  level notify("relic_quest_completed");
}

watchforplayerstouchingwater(var_0) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  for(;;) {
    var_1 = gettime();
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_0)) {
        var_3 thread giveplayersludgeimmunity(var_3, var_1);
      }
    }

    wait(0.25);
  }
}

giveplayersludgeimmunity(var_0, var_1) {
  var_0 setscriptablepartstate("sludge_immunity", "inactive");
  var_0.sludge_immunity = var_1 + 5000;
}

unsetimmunutyaftertime(var_0) {
  var_0 notify("unsetImmunutyAfterTime");
  var_0 endon("unsetImmunutyAfterTime");
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_0 endon("disconnect");
  wait(5);
  var_0 setscriptablepartstate("sludge_immunity", "inactive");
}

clearsewageonzombiedeath(var_0, var_1) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  for(;;) {
    level waittill("zombie_killed", var_2, var_3, var_4, var_5, var_6);
    if(!isplayer(var_5)) {
      continue;
    }

    if(isDefined(var_3) && var_3 == "iw7_fantrap_zm") {
      continue;
    }

    var_7 = scripts\engine\utility::getclosest(var_2, var_1, 128);
    if(!isDefined(var_7)) {
      continue;
    }

    if(!isDefined(var_7.pool)) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_7.var_19)) {
      continue;
    }

    var_8 = var_7.pool;
    if(distance(var_2, var_7.origin) <= 128) {
      playFX(level._effect["rat_swarm_cheap"], var_2, anglesToForward(var_6.angles));
      thread cleanupsewage(var_8, var_0, var_7);
    }
  }
}

watchforplayerinvolume(var_0, var_1) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  for(;;) {
    var_0 waittill("trigger", var_2);
    if(!isplayer(var_2)) {
      continue;
    }

    if(!isalive(var_2) || scripts\engine\utility::istrue(var_2.inlaststand)) {
      continue;
    }

    var_3 = gettime();
    if(isDefined(var_2.sludge_immunity) && var_3 < var_2.sludge_immunity) {
      if(var_2.sludge_immunity - var_3 <= 2000) {
        var_2 setscriptablepartstate("sludge_immunity", "active_grn");
      }

      continue;
    }

    var_4 = scripts\engine\utility::getclosest(var_2.origin, var_1, 96);
    if(!isDefined(var_4) || !scripts\engine\utility::istrue(var_4.var_19)) {
      continue;
    }

    if(isDefined(var_2.nextsewageburntime)) {
      if(var_3 < var_2.nextsewageburntime) {
        continue;
      }
    }

    var_2.nextsewageburntime = var_3 + 1000;
    var_5 = 0.2 * var_2.maxhealth;
    var_2 playlocalsound("rk_sludge_damage_plr");
    var_2 dodamage(20, var_0.origin, var_0, var_0, "MOD_UNKNOWN");
  }
}

setsewagescriptable(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  if(isDefined(var_1)) {
    if(var_1 > 0) {
      wait(0.05 * var_1);
    }
  }

  var_2.var_19 = 1;
  var_0 setscriptablepartstate("blood_pool", "active");
}

cleanupsewage(var_0, var_1, var_2) {
  if(scripts\engine\utility::array_contains(var_1.activestructs, var_0)) {
    var_1.activestructs = scripts\engine\utility::array_remove(var_1.activestructs, var_0);
  }

  var_0 setscriptablepartstate("blood_pool", "neutral");
  var_2.var_19 = undefined;
  wait(0.25);
  var_1.var_C1++;
  level notify("1_pool_clean");
  if(var_1.var_C1 >= var_1.objective_icon) {
    var_1 notify("allPoolsClean");
  }
}

startsewageloop(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_2 endon("allPoolsClean");
  for(;;) {
    level waittill("1_pool_clean");
    if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
      wait(50);
    } else {
      wait(35);
    }

    var_2.activestructs = var_1;
    var_2.var_C1 = 0;
    var_2 playsoundtoteam("ww_magicbox_laughter", "allies");
    playsoundatpos((-1430.11, 1598.7, 204), "rk_sludge_pour_in_01");
    playsoundatpos((-324.67, 1597.21, 204), "rk_sludge_pour_in_02");
    playsoundatpos((-876.252, 2414.08, 204), "rk_sludge_pour_in_03");
    scripts\engine\utility::exploder(110);
    var_2 thread clearsewageonzombiedeath(var_2, var_1);
    foreach(var_6, var_4 in var_1) {
      if(!isDefined(var_4.pool)) {
        var_5 = spawn("script_model", var_4.origin);
        if(isDefined(var_4.angles)) {
          var_5.angles = var_4.angles;
        }

        var_5 setModel("tag_origin_sewage");
        var_4.pool = var_5;
      } else {
        var_5 = var_4.pool;
      }

      var_5 thread setsewagescriptable(var_5, var_6, var_4);
    }
  }
}

runbrainrelicquest(var_0) {
  level endon("game_ended");
  level waittill(var_0.relic + "_relic_placed_in_center");
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
  var_1 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_1) {
    brainrelictunedata(level.agenttunedata["ratking"]);
  } else {
    brainrelictunedata(level.agenttunedata["ratking"]);
  }

  level.rat_king.battackzombies = 1;
  level.rat_king.shouldteleportthreshold = 0;
  runbrainrelicquestinternal(var_0);
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

runbrainrelicquestinternal(var_0) {
  level.brainattractorstruct = var_0;
  var_0.targeting = [];
  level thread runbrainattractor(var_0);
  var_0 waitforbraindestroyed(var_0);
  level notify("relic_quest_completed");
}

getbrainattractorzombies() {
  if(isDefined(level.brainattractorstruct) && isDefined(level.brainattractorstruct.targeting)) {
    return level.brainattractorstruct.targeting;
  }

  return [];
}

waitforbraindestroyed(var_0) {
  level endon("game_ended");
  var_1 = level.rk_center_arena_struct.origin;
  var_2 = 0;
  var_3 = 100;
  while(var_2 < var_3) {
    var_4 = 0;
    foreach(var_6 in var_0.targeting) {
      if(distance(var_6.origin, var_1) <= 100) {
        var_4 = 1;
        var_2++;
        break;
      }
    }

    wait(1);
  }

  foreach(var_6 in var_0.targeting) {
    thread unsetbrainattibures(var_6);
  }
}

unsetbrainattibures(var_0) {
  if(isalive(var_0) && var_0.health >= 1) {
    var_0 setscriptablepartstate("eyes", "yellow_eyes");
  }

  if(isDefined(var_0.brainpos)) {
    var_1 = var_0.brainpos;
    var_1.claimed = undefined;
  }

  var_0.scripted_mode = 0;
  var_0 give_mp_super_weapon(var_0.origin);
  var_0.precacheleaderboards = 0;
  var_0.ignoreme = 0;
  var_0.attackent = undefined;
}

runbrainattractor(var_0) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_1 = level.rk_center_arena_struct.origin;
  for(;;) {
    getvalidalivezombies(var_0, 4, var_1);
    foreach(var_3 in var_0.targeting) {
      var_0 thread sendtargetstobrain(var_0, var_3, var_1);
    }

    wait(5);
  }
}

cleanupattractedzombies(var_0) {
  var_1 = [];
  foreach(var_3 in var_0.targeting) {
    if(isalive(var_3) && var_3.health >= 1) {
      var_1[var_1.size] = var_3;
    }
  }

  var_0.targeting = var_1;
}

getvalidalivezombies(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  cleanupattractedzombies(var_0);
  if(var_0.targeting.size >= var_1) {
    return;
  }

  var_3 = scripts\mp\mp_agent::getactiveagentsoftype("generic_zombie");
  var_4 = scripts\engine\utility::get_array_of_closest(var_2, var_3, undefined, 24, 1000);
  foreach(var_6 in var_4) {
    if(var_0.targeting.size >= var_1) {
      break;
    }

    if(scripts\engine\utility::array_contains(var_0.targeting, var_6)) {
      continue;
    }

    if(var_6.health < 1) {
      continue;
    }

    if(!isalive(var_6)) {
      continue;
    }

    if(abs(var_6.origin[2] - var_2[2]) > 32) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_6.entered_playspace)) {
      var_0.targeting[var_0.targeting.size] = var_6;
    }
  }
}

sendtargetstobrain(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_1 endon("death");
  if(var_1.health >= 1) {
    var_1 setscriptablepartstate("eyes", "turned_eyes", 1);
  }

  var_1 thread cleanupbrainvarsondeath(var_1);
  var_1.scripted_mode = 1;
  var_1.attackent = var_0.model;
  var_3 = getvalidbrainpos(var_1);
  var_1.brainpos = var_3;
  var_1 give_mp_super_weapon(var_3.origin);
  var_1.precacheleaderboards = 1;
  var_1.ignoreme = 1;
}

getvalidbrainpos(var_0) {
  var_1 = scripts\engine\utility::getstructarray("brain_targets", "targetname");
  var_2 = sortbydistance(var_1, var_0.origin);
  foreach(var_4 in var_2) {
    if(scripts\engine\utility::istrue(var_4.claimed)) {
      continue;
    }

    var_4.claimed = 1;
    return var_4;
  }

  return var_2[0];
}

cleanupbrainvarsondeath(var_0) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_0 waittill("death");
  unsetbrainattibures(var_0);
}

runeyerelicquest(var_0) {
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

  level waittill(var_0.relic + "_relic_placed_in_center");
  level.solorkstagetoggles = ::setstage2attackpriorities;
  level.rkstagetoggles = ::setstage2attackpriorities;
  level.rk_tuning_override = ::setupeyerelictunedata;
  level.rk_solo_tuning_override = ::setupsoloeyerelictunedata;
  var_1 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_1) {
    setupsoloeyerelictunedata(level.agenttunedata["ratking"]);
  } else {
    setupeyerelictunedata(level.agenttunedata["ratking"]);
  }

  setstage2attackpriorities();
  var_2 = scripts\engine\utility::getstructarray("rk_eye_damage_structs", "targetname");
  var_2 = scripts\engine\utility::array_randomize_objects(var_2);
  level.all_eye_targets = var_2;
  var_0.objective_icon = getmaxactivetargets();
  var_0.var_C1 = 0;
  level.active_eye_targets = [];
  level.inactive_eye_targets = [];
  var_3 = getmaxactivetargets();
  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];
    if(var_4 < var_3) {
      var_5 thread watchforraceresults(var_5, var_0, 1);
      continue;
    }

    var_5 thread watchforraceresults(var_5, var_0);
  }

  level thread watchforeyestructactive();
  level thread watchplayerforeyerelicuse();
}

watchplayerforeyerelicuse() {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_0 = level.rk_center_arena_struct.origin;
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
  foreach(var_1 in level.active_eye_targets) {
    if(isDefined(var_1.model)) {
      var_1.model setscriptablepartstate("targets", "neutral");
    }
  }

  var_3 = level.rk_center_arena_struct.origin;
  for(;;) {
    playeyeeffects(var_3);
    scripts\engine\utility::flag_set("eye_active");
    foreach(var_1 in level.active_eye_targets) {
      if(isDefined(var_1.model)) {
        var_1.model setscriptablepartstate("targets", "active");
      }
    }

    wait(5);
    scripts\engine\utility::flag_clear("eye_active");
    foreach(var_1 in level.active_eye_targets) {
      if(isDefined(var_1.model)) {
        var_1.model setscriptablepartstate("targets", "neutral");
      }
    }

    wait(5);
  }
}

playeyeeffects(var_0) {
  playsoundatpos(var_0, "rk_eye_pulse_lr");
  playFX(level._effect["rat_eye_rats"], var_0);
  wait(0.1);
}

getmaxactivetargets() {
  var_0 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
  if(var_0) {
    return 12;
  }

  return 20;
}

solobrainrelictunedata(var_0) {
  var_0.min_path_dist_for_teleport = 100;
  var_0.no_los_wait_time_before_teleport = 1;
  var_0.min_time_between_teleports = 1000;
  var_0.min_teleport_dist_to_player = 25;
  var_0.max_teleport_dist_to_player = 5000;
  var_0.attempt_teleport_if_no_engagement_within_time = 50;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 625;
  var_0.staff_stomp_inner_radius_sq = 2500;
  var_0.staff_stomp_outer_radius_sq = 22500;
  var_0.staff_stomp_damage_radius = 175;
  var_0.staff_stomp_interval = 2000;
  var_0.staff_stomp_inner_interval = 3000;
  var_0.staff_stomp_max_damage = 200;
  var_0.staff_stomp_min_damage = 30;
}

brainrelictunedata(var_0) {
  var_0.min_path_dist_for_teleport = 100;
  var_0.no_los_wait_time_before_teleport = 1;
  var_0.min_time_between_teleports = 1000;
  var_0.min_teleport_dist_to_player = 25;
  var_0.max_teleport_dist_to_player = 5000;
  var_0.attempt_teleport_if_no_engagement_within_time = 50;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 625;
  var_0.staff_stomp_inner_radius_sq = 2500;
  var_0.staff_stomp_outer_radius_sq = 22500;
  var_0.staff_stomp_damage_radius = 175;
  var_0.staff_stomp_interval = 2000;
  var_0.staff_stomp_inner_interval = 3000;
  var_0.staff_stomp_max_damage = 200;
  var_0.staff_stomp_min_damage = 30;
}

setupstartingeyerelictunedata(var_0) {
  var_0.min_path_dist_for_teleport = 100;
  var_0.no_los_wait_time_before_teleport = 1;
  var_0.min_time_between_teleports = 2000;
  var_0.min_teleport_dist_to_player = 999999;
  var_0.max_teleport_dist_to_player = 1000000;
  var_0.attempt_teleport_if_no_engagement_within_time = 50;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 625;
  var_0.min_moving_pain_dist = 128;
}

setupsoloeyerelictunedata(var_0) {
  var_0.need_to_block_damage_threshold = 20;
  var_0.max_time_after_last_damage_to_block = 1000;
  var_0.block_chance = 100;
  var_0.min_block_time = 10000;
  var_0.max_block_time = 10001;
  var_0.quit_block_if_no_damage_time = 3000;
  var_0.min_block_interval = 15000;
  var_0.max_block_interval = 20000;
  var_0.staff_shield_attack_min_dist_sq = 90000;
  var_0.staff_shield_attack_max_dist_sq = 25000000;
  var_0.staff_shield_attack_interval_min = 2000;
  var_0.staff_shield_attack_interval_max = 2001;
  var_0.min_clear_los_time_before_shield_attack = 50;
  var_0.min_path_dist_for_teleport = 200;
  var_0.no_los_wait_time_before_teleport = 1;
  var_0.min_time_between_teleports = 2000;
  var_0.min_teleport_dist_to_player = 25;
  var_0.max_teleport_dist_to_player = 5000;
  var_0.attempt_teleport_if_no_engagement_within_time = 100;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 250000;
}

setupeyerelictunedata(var_0) {
  var_0.need_to_block_damage_threshold = 20;
  var_0.max_time_after_last_damage_to_block = 1000;
  var_0.block_chance = 100;
  var_0.min_block_time = 10000;
  var_0.max_block_time = 10001;
  var_0.quit_block_if_no_damage_time = 2000;
  var_0.min_block_interval = 15000;
  var_0.max_block_interval = 20000;
  var_0.staff_shield_attack_min_dist_sq = 90000;
  var_0.staff_shield_attack_max_dist_sq = 25000000;
  var_0.staff_shield_attack_interval_min = 2000;
  var_0.staff_shield_attack_interval_max = 2001;
  var_0.min_clear_los_time_before_shield_attack = 50;
  var_0.min_path_dist_for_teleport = 200;
  var_0.no_los_wait_time_before_teleport = 1;
  var_0.min_time_between_teleports = 10000;
  var_0.min_teleport_dist_to_player = 25;
  var_0.max_teleport_dist_to_player = 5000;
  var_0.attempt_teleport_if_no_engagement_within_time = 2000;
  var_0.teleport_min_dist_to_enemy_to_teleport_sq = 90000;
}

restorerktuning() {
  if(level.players.size == 1) {
    [[level.soloratkingtuning]](level.agenttunedata["ratking"]);
    return;
  }

  [[level.ratkingtuning]](level.agenttunedata["ratking"]);
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

watchforraceresults(var_0, var_1, var_2) {
  if(!isDefined(var_0.model)) {
    var_3 = spawn("script_model", var_0.origin);
    if(isDefined(var_0.angles)) {
      var_3.angles = var_0.angles;
    } else {
      var_3.angles = (0, 0, 0);
    }

    var_3 setModel("eye_quest_targets");
    var_0.model = var_3;
  } else {
    var_3 = var_1.model;
  }

  if(scripts\engine\utility::istrue(var_2)) {
    activateeyestruct(var_0);
    var_3 thread checkraceresults(var_0, var_1, var_2);
    if(scripts\engine\utility::flag("eye_active")) {
      var_3 setscriptablepartstate("targets", "active");
      return;
    }

    return;
  }

  deactivateeyestruct(var_0);
  var_3 thread checkraceresults(var_0, var_1, var_2);
  var_3 setscriptablepartstate("targets", "neutral");
}

deactivateeyestruct(var_0) {
  level.inactive_eye_targets[level.inactive_eye_targets.size] = var_0;
  if(scripts\engine\utility::array_contains(level.active_eye_targets, var_0)) {
    level.active_eye_targets = scripts\engine\utility::array_remove(level.active_eye_targets, var_0);
  }

  level.active_eye_targets = scripts\engine\utility::array_removeundefined(level.active_eye_targets);
  level.inactive_eye_targets = scripts\engine\utility::array_removeundefined(level.inactive_eye_targets);
  level.active_eye_targets = scripts\engine\utility::array_remove_duplicates(level.active_eye_targets);
  level.inactive_eye_targets = scripts\engine\utility::array_remove_duplicates(level.inactive_eye_targets);
}

activateeyestruct(var_0) {
  level.active_eye_targets[level.active_eye_targets.size] = var_0;
  if(scripts\engine\utility::array_contains(level.inactive_eye_targets, var_0)) {
    level.inactive_eye_targets = scripts\engine\utility::array_remove(level.inactive_eye_targets, var_0);
  }

  level.active_eye_targets = scripts\engine\utility::array_removeundefined(level.active_eye_targets);
  level.inactive_eye_targets = scripts\engine\utility::array_removeundefined(level.inactive_eye_targets);
  level.active_eye_targets = scripts\engine\utility::array_remove_duplicates(level.active_eye_targets);
  level.inactive_eye_targets = scripts\engine\utility::array_remove_duplicates(level.inactive_eye_targets);
}

checkraceresults(var_0, var_1, var_2) {
  var_0 notify("checkRaceResults");
  var_0 endon("checkRaceResults");
  level endon("game_ended");
  level endon("relic_quest_completed");
  self.health = 1000000;
  self.maxhealth = 1000000;
  self setCanDamage(1);
  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6);
    if(isplayer(var_4) && scripts\engine\utility::flag("eye_active")) {
      if(!scripts\engine\utility::array_contains(level.active_eye_targets, var_0)) {
        continue;
      }

      if(!isalive(var_4) || scripts\engine\utility::istrue(var_4.inlaststand)) {
        continue;
      }

      deactivateeyestruct(var_0);
      thread settargetscriptablestates(var_0);
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

    if(level.active_eye_targets.size < var_1.objective_icon) {
      self setscriptablepartstate("impact", "active");
      thread setupneweyetarget(var_1, var_0);
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
    foreach(var_1 in level.all_eye_targets) {
      if(isDefined(var_1.model)) {
        var_1.model delete();
        var_1.model = undefined;
      }
    }
  }

  level.all_eye_targets = undefined;
  level.active_eye_targets = undefined;
  level.inactive_eye_targets = undefined;
}

settargetscriptablestates(var_0) {
  level endon("game_ended");
  self endon("death");
  self setscriptablepartstate("targets", "dead");
}

setupneweyetarget(var_0, var_1) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_1 thread watchforraceresults(var_1, var_0, 1);
}

pickuprkrelic(var_0, var_1) {
  scripts\engine\utility::flag_clear("rk_fight_relic_stage");
  level notify("relic_selected", var_0);
  activatecenterstruct();
  var_0 thread setrelicscriptablestates(var_0);
  if(var_0.relic == "heart") {
    var_1 playlocalsound("rk_relic_heart_pickup_plr");
  } else if(var_0.relic == "brain") {
    var_1 playlocalsound("rk_relic_brain_pickup_plr");
  } else {
    var_1 playlocalsound("rk_relic_eye_pickup_plr");
  }

  var_1 thread play_relic_vo(var_0.relic);
}

play_relic_vo(var_0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  wait(1);
  switch (var_0) {
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
  var_0 = level.rk_center_arena_struct.origin;
  var_1 = spawnfx(level._effect["relic_center"], var_0);
  if(isDefined(level.rk_center_arena_struct.fx)) {
    level.rk_center_arena_struct.fx delete();
  }

  level.rk_center_arena_struct.fx = var_1;
  triggerfx(var_1);
}

deactivatecenterstruct() {
  var_0 = level.rk_center_arena_struct.origin;
  if(isDefined(level.rk_center_arena_struct.fx)) {
    level.rk_center_arena_struct.fx delete();
  }
}

setrelicscriptablestates(var_0) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.model setscriptablepartstate("interactions", "pickup");
  var_0.model setscriptablepartstate("rk_models", var_0.relic + "_picked");
  wait(0.5);
  if(isDefined(var_0.fx)) {
    var_0.fx delete();
  }

  if(isDefined(var_0.model)) {
    var_0.model delete();
  }

  deactivaterelics();
}

rkrelic_hint_func(var_0, var_1) {
  return "";
}

rkdebug_hint_func(var_0, var_1) {
  return &"CP_DISCO_INTERACTIONS_ENTER_THIS_AREA";
}

userkdebug(var_0, var_1) {}

open_sesame(var_0) {
  if(scripts\engine\utility::istrue(var_0)) {
    level.open_sesame = undefined;
  } else if(scripts\engine\utility::istrue(level.open_sesame)) {
    level.open_sesame = undefined;
    return;
  } else {
    level.open_sesame = 1;
  }

  foreach(var_2 in level.generators) {
    thread scripts\cp\zombies\zombie_power::generic_generator(var_2);
    wait(0.1);
  }

  if(isDefined(level.fast_travel_spots)) {
    foreach(var_5 in level.fast_travel_spots) {
      var_5.used_once = 1;
    }
  }

  var_7 = getEntArray("door_buy", "targetname");
  foreach(var_9 in var_7) {
    var_9 notify("trigger", "open_sesame");
    wait(0.1);
  }

  var_0B = getEntArray("chi_door", "targetname");
  foreach(var_9 in var_0B) {
    var_9.physics_capsulecast notify("damage", undefined, "open_sesame");
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
  var_0 = ["iw7_ar57_zm", "iw7_m4_zm", "iw7_erad_zm"];
  var_1 = ["iw7_crb_zml", "iw7_lmg03_zm", "iw7_mauler_zm"];
  var_2 = ["snake", "crane", "dragon", "tiger"];
  var_3 = ["perk_machine_revive", "perk_machine_flash", "perk_machine_tough", "perk_machine_run", "perk_machine_rat_a_tat"];
  foreach(var_5 in level.players) {
    var_6 = randomint(var_1.size);
    var_7 = randomint(var_0.size);
    var_8 = randomint(var_2.size);
    var_5 takeweapon(var_5 scripts\cp\utility::getvalidtakeweapon());
    var_9 = scripts\cp\utility::getrawbaseweaponname(var_1[var_6]);
    if(isDefined(var_5.weapon_build_models[var_9])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_5, var_5.weapon_build_models[var_9]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_5, var_1[var_6]);
    }

    var_0A = scripts\cp\utility::getrawbaseweaponname(var_0[var_7]);
    if(isDefined(var_5.weapon_build_models[var_0A])) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_5, var_5.weapon_build_models[var_0A]);
    } else {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_5, var_1[var_6]);
    }

    var_5 thread scripts\cp\powers\coop_powers::givepower("power_rat_king_eye", "secondary", undefined, undefined, undefined, 1, 1);
    var_5 thread scripts\cp\powers\coop_powers::givepower("power_heart", "primary", undefined, undefined, undefined, undefined, 1);
    var_5.total_currency_earned = min(10000, var_5 scripts\cp\cp_persistence::get_player_max_currency());
    var_5 scripts\cp\cp_persistence::set_player_currency(10000);
    var_5.kung_fu_progression.active_discipline = var_2[var_8];
    var_5.kung_fu_progression.disciplines_levels[var_2[var_8]] = 3;
    switch (var_2[var_8]) {
      case "tiger":
        var_0B = 3;
        var_5 setclientomnvar("ui_intel_active_index", var_0B);
        break;

      case "snake":
        var_0B = 6;
        var_5 setclientomnvar("ui_intel_active_index", var_0B);
        break;

      case "crane":
        var_0B = 4;
        var_5 setclientomnvar("ui_intel_active_index", var_0B);
        break;

      case "dragon":
        var_0B = 5;
        var_5 setclientomnvar("ui_intel_active_index", var_0B);
        break;
    }

    level thread scripts\cp\maps\cp_disco\cp_disco_challenges::chi_challenge_activate(var_5);
    var_5 scripts\cp\cp_interaction::refresh_interaction();
    var_5 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_5);
    var_5 thread scripts\cp\maps\cp_disco\kung_fu_mode::set_gourd(var_5);
    var_5 scripts\cp\maps\cp_disco\kung_fu_mode::checkgourdstates(undefined, var_5);
    if(!scripts\engine\utility::istrue(var_5.style_chosen)) {
      var_5.style_chosen = 1;
      var_5 setclientomnvar("zm_ui_show_general", 0);
    }

    foreach(var_0D in var_3) {
      var_5 thread scripts\cp\zombies\zombies_perk_machines::give_zombies_perk_immediate(var_0D, 1);
    }
  }

  if(isDefined(level.pap_max) && level.pap_max < 3) {
    level.pap_max++;
  }

  level[[level.upgrade_weapons_func]]();
  level thread[[level.upgrade_weapons_func]]();
}

userkarenacenter(var_0, var_1) {
  if(!isDefined(level.current_relic)) {
    return;
  }

  var_0 scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  deactivatecenterstruct();
  if(level.current_relic == "heart") {
    var_1 playlocalsound("rk_relic_heart_placement_plr");
  } else if(level.current_relic == "brain") {
    var_1 playlocalsound("rk_relic_brain_placement_plr");
  } else {
    var_1 playlocalsound("rk_relic_eye_placement_plr");
  }

  level notify(level.current_relic + "_relic_placed_in_center");
  scripts\engine\utility::flag_set("relic_active");
  level notify("center_arena_struct_used");
  level.rat_king.outofplayspace = undefined;
  level.rat_king setethereal(0);
  setcenterscriptablestates(var_0);
  var_0 thread watchforstagecomplete(var_0);
}

watchforstagecomplete(var_0) {
  level endon("game_ended");
  level waittill("relic_quest_completed");
  var_0.model setscriptablepartstate("rk_models", "neutral");
  wait(0.25);
  var_0.model.origin = var_0.origin + (0, 0, 4);
}

setcenterscriptablestates(var_0) {
  var_0.model setscriptablepartstate("interactions", "place");
  var_0.model setscriptablepartstate("rk_models", "active_" + level.current_relic);
  var_0.model thread startcenteractiveloop(var_0);
  level.current_relic = undefined;
}

startcenteractiveloop(var_0) {
  level endon("game_ended");
  level endon("relic_quest_completed");
  var_0 endon("relic_deactivated");
  self endon("death");
  for(;;) {
    var_1 = randomfloatrange(2, 4);
    self moveto(self.origin + (0, 0, 32), var_1);
    wait(var_1);
    self moveto(self.origin + (0, 0, -32), var_1);
    wait(var_1);
  }
}

rkarenacenter_hint_func(var_0, var_1) {
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
    foreach(var_1 in level.rk_barriers) {
      var_1 delete();
    }
  }
}

togglerkability(var_0, var_1) {
  level.rat_king_toggles[var_0] = var_1;
}

togglepgability(var_0, var_1) {
  level.pam_grier_toggles[var_0] = var_1;
}

addstaffstompcooldown(var_0) {
  self.nextstaffstomptime = gettime() + var_0;
}

addinnerstaffstompcooldown(var_0) {
  self.nextstaffstompinnertime = gettime() + var_0;
}

addstaffprojcooldown(var_0) {
  self.nextstaffprojectiletime = gettime() + var_0;
}

addblockcooldown(var_0) {
  self.nextblocktime = gettime() + var_0;
}

disabledamageonratking() {
  level.rat_king.disabledamage = 1;
}

enabledamageonratking() {
  level.rat_king.disabledamage = undefined;
}

setrkhealth(var_0) {
  if(isDefined(var_0)) {
    level.rat_king.health = int(level.rat_king.maxhealth * var_0);
    return;
  }

  level.rat_king.health = int(level.rat_king.maxhealth);
}

watchfordamagestagecomplete(var_0, var_1) {
  level endon("game_ended");
  level.rat_king endon("death");
  var_2 = 0;
  for(;;) {
    level waittill("rat_king_damaged");
    if(!var_2 && level.rat_king.health <= int(level.rat_king.maxhealth * var_1)) {
      var_2 = 1;
      scripts\cp\zombies\cp_disco_spawning::pausenormalwavespawning(1);
    }

    if(level.rat_king.health <= int(level.rat_king.maxhealth * var_0)) {
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

  foreach(var_1 in level.players) {
    if(scripts\engine\utility::istrue(var_1.inlaststand)) {
      var_1 notify("revive_success");
      scripts\cp\cp_laststand::clear_last_stand_timer(var_1);
      if(isDefined(var_1.reviveent)) {
        var_1.reviveent notify("revive_success");
      }
    }
  }

  try_drop_max_ammo();
  level thread restorerktuning();
  thread stagecomplete();
}

stagecomplete() {
  foreach(var_1 in level.players) {
    var_1 playsoundtoplayer("quest_stage_completed_gong_lr", var_1);
  }
}

enablerkspawners() {
  var_0 = scripts\engine\utility::getstructarray("static", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.groupname) && var_2.groupname == "rk_spawners") {
      var_2 scripts\cp\zombies\zombies_spawning::make_spawner_active();
    }
  }
}

katanahintfunc(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.has_disco_soul_key)) {
    if(!scripts\engine\utility::flag("rk_fight_ended")) {
      return level.interaction_hintstrings["iw7_katana_zm"];
    }

    return "";
  }

  return "";
}

katanausefunc(var_0, var_1) {
  if(scripts\engine\utility::flag("rk_fight_ended")) {
    if(!var_1 hasanykatana(var_1)) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_1, "iw7_katana_zm");
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      return;
    }

    return;
  }

  if(scripts\engine\utility::istrue(var_1.has_disco_soul_key)) {
    if(!var_1 hasanykatana(var_1)) {
      scripts\cp\zombies\coop_wall_buys::givevalidweapon(var_1, "iw7_katana_zm");
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      return;
    }

    return;
  }
}

hasanykatana(var_0) {
  var_1 = var_0 getweaponslistall();
  foreach(var_3 in var_1) {
    if(issubstr(var_3, "iw7_katana")) {
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