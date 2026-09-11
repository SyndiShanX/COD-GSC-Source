/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trl_cleararea.gsc
**************************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13d51)) {
    level.ref_13d51 = [];
  }

  level.ref_13d51["clear"] = &init;
}

function init() {
  build_vehicle_drop_off_list();
  setdvarifuninitialized("t_clr_radar_type", "uav");
  setdvarifuninitialized("t_clr_enemies_total", "30");

  if(!isDefined(game["trial"])) {
    game["trial"] = [];
  }

  if(!isDefined(game["trial"]["best_reward"])) {
    game["trial"]["best_reward"] = 0;
  }

  if(!isDefined(game["trial"]["tries_remaining"])) {
    game["trial"]["tries_remaining"] = level.trial["attempts"];
  }

  level.mapname = level.trial["zone"];
  level.enemies = [];
  level.enemiesactivenb = 0;
  level.enemiestotal = 0;
  level.enemieskilled = 0;
  level.totaltimeelapsed = 0;
  level.attempttier = 0;
  level.ref_11b77 = 59999900;
  level.modeonspawnplayer = &ref_124d6;
  level scripts\engine\utility::flag_init("trial_start_zone_entered");
  level scripts\engine\utility::flag_init("trial_countdown");
  level scripts\engine\utility::flag_init("trial_starting");
  level scripts\engine\utility::flag_init("trial_completed");
  level scripts\engine\utility::flag_init("trial_ready_for_endscreen");
  level scripts\engine\utility::flag_init("trial_player_death");
  precachemodel("tag_origin");
  precachemodel("player128x128x8");
  precachemodel("box_wooden_grenade_02_green");
  precachemodel("head_al_qatala_3_ar");
  precachemodel("head_al_qatala_desert_05");
  precachemodel("head_al_qatala_desert_08");
  precachemodel("head_al_qatala_desert_09");
  precachemodel("body_al_qatala_desert_02");
  precachemodel("body_al_qatala_desert_03");
  precachemodel("body_al_qatala_desert_09");
  precachemodel("body_al_qatala_desert_02_b");
  level.enemyheadmodels = [];
  level.enemyheadmodels[0] = "head_al_qatala_3_ar";
  level.enemyheadmodels[1] = "head_al_qatala_desert_05";
  level.enemyheadmodels[2] = "head_al_qatala_desert_08";
  level.enemyheadmodels[3] = "head_al_qatala_desert_09";
  level.enemybodymodels = [];
  level.enemybodymodels[0] = "body_al_qatala_desert_02";
  level.enemybodymodels[1] = "body_al_qatala_desert_03";
  level.enemybodymodels[2] = "body_al_qatala_desert_09";
  level.enemybodymodels[3] = "body_al_qatala_desert_02_b";
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  thread trial_start_init();
  thread player_init();
  thread enemies_init();
  thread enemy_chatter();
  thread hud_init();
  thread dialog_init();
  level.battlechatterenabled = 0;

  while(!isDefined(level.player)) {
    wait 0.05;
  }

  while(!isalive(level.player)) {
    wait 0.05;
  }

  thread ref_1385c();
  level.brjugg_dropondeath = getallnodes();
}

function trial_start_init() {
  level endon("nuked");

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  if(istrue(level.ref_13d41)) {
    level.onweapondroppickedup = getEntArray("explosive_barrel", "targetname");
    level.onweapontaken = getEntArray("explosive_car", "targetname");
    level.brprewaitandspawnclient = getEntArray("ammo_crate", "targetname");
    scripts\engine\utility::array_thread(level.onweapontaken, &lb_mg_wood_surf_dmg_scalar);
    scripts\engine\utility::array_thread(level.onweapondroppickedup, &chopperoccupied);
    scripts\engine\utility::array_thread(level.brprewaitandspawnclient, &brplayerhudoutlineupdatefromnotify);
  }

  var_0 = getEnt("door_left", "targetname");
  var_1 = getEnt("door_right", "targetname");
  var_2 = getEnt("door_col_left", "targetname");
  var_3 = getEnt("door_col_right", "targetname");
  var_4 = undefined;

  if(level.mapname == "mp_spear" || level.mapname == "mp_spear_pm") {
    var_4 = getEnt("door_coll", "targetname");
    var_5 = getEnt("door_left_coll", "targetname");
    var_6 = getEnt("door_right_coll", "targetname");
    var_5 linkTo(var_0);
    var_6 linkTo(var_1);
  } else if(isDefined(var_2) || isDefined(var_3)) {
    if(isDefined(var_2)) {
      var_0.helimakeexfilwait = var_2;
    }

    if(isDefined(var_3)) {
      var_1.helimakeexfilwait = var_3;
    }
  } else {
    var_7 = spawn("script_model", var_0.origin);
    var_7.angles = var_0.angles;
    var_8 = spawn("script_model", var_0.origin);
    var_8.angles = var_0.angles;
    var_9 = spawn("script_model", var_1.origin);
    var_9.angles = var_1.angles;
    var_10 = spawn("script_model", var_1.origin);
    var_10.angles = var_1.angles;
    var_7 setModel("player128x128x8");
    var_8 setModel("player128x128x8");
    var_9 setModel("player128x128x8");
    var_10 setModel("player128x128x8");
    var_7 linkTo(var_0, "cp_disco_gate_01_left", (0, -44, 20), (90, 0, 0));
    var_8 linkTo(var_0, "cp_disco_gate_01_left", (0, -44, 84), (90, 0, 0));
    var_9 linkTo(var_1, "cp_disco_gate_01_right", (0, -44, 20), (-90, 0, 0));
    var_10 linkTo(var_1, "cp_disco_gate_01_right", (0, -44, 84), (-90, 0, 0));
  }

  var_11 = scripts\mp\trials\mp_trials_patches::trial_chevron_init();

  while(!isDefined(level.player)) {
    wait 0.05;
  }

  if(isDefined(level.ref_13d59)) {
    foreach(var_13 in level.ref_13d59) {
      level.player setperk(var_13, 1);
    }
  }

  while(!isalive(level.player)) {
    wait 0.05;
  }

  if(game["trial"]["tries_remaining"] > 2) {
    wait 8;
  }

  wait 2;
  thread scripts\mp\trials\mp_trials_patches::trial_chevron_vfx_action(var_11, "turn_on");
  level scripts\engine\utility::flag_wait("trial_start_zone_entered");
  level.started = 1;
  thread scripts\mp\trials\mp_trials_patches::trial_chevron_vfx_action(var_11, "turn_off");
  _tablethide::ref_13d88();
  _tablethide::ref_13d89(0);
  thread radar_think();
  wait 2;
  level scripts\engine\utility::flag_set("trial_countdown");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  level scripts\engine\utility::flag_set("trial_starting");
  thread player_monitor_death();

  if(isDefined(var_4)) {
    var_4 notsolid();
  }

  var_1 playSound("trial_sfx_door_chainlink_fast");
  var_0 playSound("trial_sfx_door_chainlink_fast");
  var_1 rotateYaw(-150, 0.75);
  var_0 rotateYaw(150, 0.75);

  if(isDefined(var_0.helimakeexfilwait)) {
    var_0.helimakeexfilwait delete();
  }

  if(isDefined(var_1.helimakeexfilwait)) {
    var_1.helimakeexfilwait delete();
    return;
  }
}

function radar_think() {
  var_0 = getDvar("t_clr_radar_type");

  if(var_0 != "none") {
    var_1 = level.player scripts\mp\equipment::getcurrentequipment("primary");
    var_2 = level.player scripts\mp\equipment::getequipmentammo("primary");
    var_3 = level.player scripts\mp\equipment::getcurrentequipment("secondary");
    var_4 = level.player scripts\mp\equipment::getequipmentammo("secondary");

    if(isDefined(var_1)) {
      level.player scripts\mp\equipment::takeequipment("primary");
      var_5 = 1;
    } else {
      var_5 = 0;
    }

    if(isDefined(var_4)) {
      level.player scripts\mp\equipment::takeequipment("secondary");
      var_6 = 1;
    } else {
      var_6 = 0;
    }

    level.player allowmelee(0);
    level.player allowsprint(0);
    level.player allowreload(0);
    level.player cancelreload();

    while(level.player ismeleeing()) {
      waitframe();
    }

    level.uavsettings[var_2].timeout = 9999;
    level.player scripts\cp_mp\killstreaks\uav::tryuseuav(var_2);
    waitframe();
    level.player allowmelee(1);
    level.player allowsprint(1);
    level.player allowreload(1);

    if(isDefined(var_3) && istrue(var_6)) {
      level.player scripts\mp\equipment::giveequipment(var_3, "primary");
    }

    if(isDefined(var_5) && istrue(var_6)) {
      level.player scripts\mp\equipment::giveequipment(var_5, "secondary");
      return;
    }

    return;
  }
}

function player_init() {
  while(!isDefined(level.player)) {
    wait 0.05;
  }

  while(!isalive(level.player)) {
    wait 0.05;
  }

  self.player scripts\mp\utility\perk::giveperk("specialty_fastreload");
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  wait 0.5;
  level.player freezecontrols(0);
  level.player freezelookcontrols(0);
  level.enemyteam = scripts\engine\utility::get_enemy_team(level.player.team);
  level.playerteam = level.player.team;

  if(level.playerteam == "axis") {
    level.enemyteam = "allies";
    level.agent_definition["actor_enemy_mp_trial_clr"]["team"] = level.enemyteam;

    if(isDefined(level.nightmap) && level.nightmap == 1) {
      level.agent_definition["actor_enemy_mp_trial_clr_ar_night"]["team"] = level.enemyteam;
      level.agent_definition["actor_enemy_mp_trial_clr_smg_night"]["team"] = level.enemyteam;
    } else {
      level.agent_definition["actor_enemy_mp_trial_clr_ar"]["team"] = level.enemyteam;
      level.agent_definition["actor_enemy_mp_trial_clr_smg"]["team"] = level.enemyteam;
    }
  }

  thread set_corpse_detect_ranges();
  thread ref_1248d();
  thread ref_1246d();
}

function ref_124d6() {
  level.player.maxhealth = 250;
  level.player.health = 250;
  scripts\engine\utility::delaythread(1, &ref_1248d);
  scripts\engine\utility::delaythread(1, &ref_1246d);
}

function player_monitor_death() {
  while(!isDefined(level.player)) {
    wait 0.05;
  }

  while(!isalive(level.player)) {
    wait 0.05;
  }

  setDvar("scr_death_scene_time", 8);
  setdynamicdvar("scr_trial_playerrespawndelay", 0);
  level.player waittill("death", var_0);
  setDvar("scr_death_scene_time", 1.75);
  level.player setclientomnvar("ui_killcam_killedby_id", level.player getentitynumber());
  level.trial_fail_alt = 1;
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  level scripts\engine\utility::flag_set("trial_player_death");
  level scripts\engine\utility::flag_set("trial_completed");
}

function ref_1248d() {
  if(isDefined(level.ref_12489)) {
    level.player scripts\mp\equipment::giveequipment(level.ref_12489, "primary");
  }

  if(isDefined(level.ref_1248b)) {
    level.player scripts\mp\equipment::giveequipment(level.ref_1248b, "secondary");
  }

  if(istrue(level.ref_1248a)) {
    thread ref_12a8e();
    return;
  }
}

function ref_1246d() {
  var_0 = level.player getweaponslistprimaries();
  jumpiffalse(istrue(level.ref_124c9)) LOC_000000ca;

  foreach(var_2 in var_0) {
    var_3 = level.player getweaponammoclip(var_2) + level.player getweaponammostock(var_2);
    var_4 = level.enemiestotal - weaponclipsize(var_2);
    level.player setweaponammoclip(var_2, weaponclipsize(var_2));
    level.player setweaponammostock(var_2, var_4);
  }

  foreach(var_7 in level.trial_weapons) {
    if(isDefined(var_7.spawned_weapon)) {
      var_8 = weaponclipsize(var_7.spawned_weapon);
      var_4 = level.enemiestotal - var_8;
      var_7.spawned_weapon itemweaponsetammo(var_8, var_4);
    }
  }

  return;
}

function set_corpse_detect_ranges() {
  var_0 = getEntArray("grenade_box", "targetname");
  scripts\engine\utility::array_thread(var_0, &set_combat_action);
}

function set_combat_action() {
  switch (self.script_noteworthy) {
    case "frag":
      var_0 = "equip_frag";
      var_1 = "primary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_FRAG";
      break;
    case "semtex":
      var_0 = "equip_semtex";
      var_1 = "primary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_SEMTEX";
      break;
    case "c4":
      var_0 = "equip_c4";
      var_1 = "primary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_C4";
      break;
    case "claymore":
      var_0 = "equip_claymore";
      var_1 = "primary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_CLAYMORE";
      break;
    case "atmine":
      var_0 = "equip_at_mine";
      var_1 = "primary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_ATMINE";
      break;
    case "tknife":
      var_0 = "equip_throwing_knife";
      var_1 = "primary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_TKNIFE";
      break;
    case "molotov":
      var_0 = "equip_molotov";
      var_1 = "primary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_MOLOTOV";
      break;
    case "thermite":
      var_0 = "equip_thermite";
      var_1 = "primary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_THERMITE";
      break;
    case "flash":
      var_0 = "equip_flash";
      var_1 = "secondary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_FLASH";
      break;
    case "snapshot":
      var_0 = "equip_snapshot_grenade";
      var_1 = "secondary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_SNAPSHOT";
      break;
    case "smoke":
      var_0 = "equip_smoke";
      var_1 = "secondary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_SMOKE";
      break;
    case "stun":
      var_0 = "equip_concussion";
      var_1 = "secondary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_STUN";
      break;
    case "trophy":
      var_0 = "equip_trophy";
      var_1 = "secondary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_TROPHY_SYSTEM";
      break;
    case "decoy":
      var_0 = "equip_decoy";
      var_1 = "secondary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_DECOY";
      break;
    case "stim":
      var_0 = "equip_adrenaline";
      var_1 = "secondary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_STIM";
      break;
    case "scrambler":
      var_0 = "equip_scramblerdrone";
      var_1 = "secondary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_SCRAMBLER";
      break;
    default:
      var_0 = "equip_frag";
      var_1 = "secondary";
      var_2 = &"MP_INGAME_ONLY/PICKUP_FRAG";
      break;
  }

  var_3 = spawn("script_model", self.origin);
  var_3 linkTo(self, "tag_origin", (5, 0, 12), (0, 0, 0));
  var_3 setModel("tag_origin");
  var_3 setHintString(var_2);
  var_3 setCursorHint("hint_button");
  var_3 sethintdisplayrange(200);
  var_3 sethintdisplayfov(65);
  var_3 setuserange(72);
  var_3 setusefov(120);
  var_3 sethintonobstruction("show");
  var_3 setuseholdduration("duration_short");

  while(!scripts\engine\utility::flag("trial_completed")) {
    var_3 makeusable();
    var_3 waittill("trigger");
    level.player scripts\mp\equipment::giveequipment(var_0, var_1);
    var_3 makeunusable();
    wait 2.5;
  }

  var_3 makeunusable();
}

function enemies_init() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_0 = getEnt("starting_trigger", "targetname");
  var_1 = var_0 scripts\engine\utility::get_target_array();
  level.enemyspawners = [];
  var_2 = getDvar("t_clr_enemies_total");

  foreach(var_4 in var_1) {
    if(isDefined(var_4.script_index)) {
      if(int(var_4.script_index) <= int(var_2)) {
        level.enemyspawners = scripts\engine\utility::array_add(level.enemyspawners, var_4);
      }

      continue;
    }

    level.enemyspawners = scripts\engine\utility::array_add(level.enemyspawners, var_4);
  }

  level.enemiestotal += level.enemyspawners.size;

  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  scripts\engine\utility::array_thread(level.enemyspawners, &enemy_individual_spawn);
  thread enemies_spawnif_noactive();
  thread nextcombatareaid();
  thread new_objective();
}

function enemy_model_setup(var_0) {
  var_1 = level.enemyheadmodels[randomint(level.enemyheadmodels.size)];
  var_2 = level.enemybodymodels[randomint(level.enemybodymodels.size)];

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(var_2);
  self attach(var_1, "", 1);
  self.headmodel = var_1;
}

function enemy_individual_spawn() {
  var_0 = self;
  level scripts\engine\utility::flag_wait("trial_countdown");
  var_1 = "enemy_mp_trial_clr_";

  if(isDefined(level.nightmap) && level.nightmap == 1) {
    var_2 = "_night";
  } else {
    var_2 = "";
  }

  switch (var_1.script_noteworthy) {
    case "lmg":
    case "ar":
      var_3 = var_2 + "ar" + var_2;
      break;
    case "smg":
      var_3 = var_2 + "smg" + var_3;
      break;
    default:
      var_3 = "enemy_mp_trial_clr";
      break;
  }

  var_4 = getEntArray("spawning_zone", "targetname");
  thread enemy_spawner_checkdist(var_2);
  var_2 waittill("plz_spawn");
  level.enemiesactivenb++;
  level.enemyspawners = scripts\engine\utility::array_remove(level.enemyspawners, var_2);
  var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_3, var_2.origin, var_2.angles);

  while(!isDefined(var_5)) {
    wait 0.05;
  }

  level.enemies[level.enemies.size] = var_5;
  thread enemy_monitor_death(var_5);
  thread enemy_soldier_think();
  thread enemy_model_setup();

  if(isDefined(var_2.target)) {
    thread enemy_move_and_cover(var_2);
    return;
  }
}

function enemy_spawner_checkdist(var_0) {
  self endon("plz_spawn");
  var_1 = getmaxagents() - 1;
  level scripts\engine\utility::flag_wait("trial_starting");

  if(isDefined(self.radius)) {
    var_2 = self.radius;
  } else {
    var_2 = 1400;
  }

  var_3 = [];
  var_4 = spawn("script_origin", self.origin);

  foreach(var_6 in var_1) {
    if(var_6 istouching(var_4)) {
      var_3 = scripts\engine\utility::array_add(var_3, var_6);
    }
  }

  var_4 delete();

  for(;;) {
    var_8 = 0;

    if(var_3.size > 0) {
      foreach(var_6 in var_3) {
        var_8 = level.player istouching(var_6);
      }
    } else {
      var_8 = 1;
    }

    var_11 = distance2d(level.player.origin, self.origin);
    var_12 = var_11 < 250;
    var_13 = var_11 < var_2;
    var_14 = level.enemiesactivenb < var_2;
    var_15 = level.player gettagorigin("tag_eye");
    var_16 = (self.origin[0], self.origin[1], self.origin[2] + 40);
    var_17 = spawnsighttrace(self, var_15, var_16);

    if(!var_17 && var_8 && var_13 && !var_12 && var_14) {
      self notify("plz_spawn");
      continue;
    }

    wait 0.05;
  }
}

function enemies_spawnif_noactive() {
  level scripts\engine\utility::flag_wait("trial_countdown");
  level endon("stop_timer");
  var_0 = getEntArray("spawning_zone", "targetname");
  var_0 = scripts\engine\utility::array_sort_with_func(var_0, &check_script_noteworthy);

  while(!scripts\engine\utility::flag("trial_completed")) {
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4 = [];
    var_5 = undefined;

    while(level.enemies.size > 0) {
      wait 0.25;
    }

    foreach(var_7 in var_0) {
      if(var_7 istouching(level.player)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_7);
      }
    }

    var_2 = return_enemyspawners_in_zones(var_1);

    if(var_2.size == 0) {
      var_9 = [];
      var_10 = [];

      foreach(var_7 in var_1) {
        var_9 = int(var_7.script_noteworthy) + 1;
        var_9 = int(var_7.script_noteworthy) + -1;
      }

      foreach(var_14 in var_9) {
        foreach(var_7 in var_0) {
          if(int(var_7.script_noteworthy) == var_14) {
            var_10 = scripts\engine\utility::array_add(var_10, var_7);
          }
        }
      }

      var_2 = return_enemyspawners_in_zones(var_10);
    }

    if(var_2.size == 0) {
      var_2 = scripts\engine\utility::getclosest(level.player.origin, level.enemyspawners);
    }

    var_3 = var_2;
    var_4 = scripts\engine\utility::get_array_of_closest(level.player.origin, var_3);

    if(var_4.size > 0) {
      for(var_18 = 0; var_18 < var_4.size; var_18++) {
        var_5 = scripts\engine\utility::random_weight_sorted(var_4);
        var_19 = level.player gettagorigin("tag_eye");
        var_20 = (var_5.origin[0], var_5.origin[1], var_5.origin[2] + 40);
        var_21 = spawnsighttrace(var_5, var_19, var_20);

        if(!var_21) {
          var_5 notify("plz_spawn");
          break;
        }
      }
    } else {
      var_22 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
      var_23 = scripts\engine\utility::getclosest(level.player.origin, var_22);
      var_24 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_trial_clr", var_23.origin, var_23.angles);

      while(!isDefined(var_24)) {
        wait 0.05;
      }

      level.enemies[level.enemies.size] = var_24;
      thread enemy_monitor_death(var_24);
      thread enemy_soldier_think();
      thread node_cansee_child();
    }

    wait 0.05;
  }
}

function nextcombatareaid() {
  level endon("trial_completed");
  level scripts\engine\utility::flag_wait("trial_starting");

  while(!scripts\engine\utility::flag("trial_completed")) {
    var_0 = scripts\mp\mp_agent::getfreeagentcount();

    if(var_0 == level.agentarray.size) {
      wait 0.5;

      if(level.enemieskilled + level.enemyspawners.size + level.enemies.size < level.enemiestotal) {
        var_1 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_trial_clr", (0, 0, 80), (0, 0, 0));

        while(!isDefined(var_1)) {
          wait 0.05;
        }

        level.enemies[level.enemies.size] = var_1;
        thread enemy_monitor_death(var_1);
        thread enemy_soldier_think();
        thread node_cansee_child();
      }
    }

    wait 0.5;
  }
}

function new_objective() {
  for(;;) {
    foreach(var_1 in level.enemies) {
      if(!isalive(var_1)) {
        level.enemies = scripts\engine\utility::array_remove(level.enemies, var_1);
      }
    }

    wait 0.25;
  }
}

function node_cansee_child() {
  while(isalive(self)) {
    self setgoalentity(level.player);
    self agentsetfavoriteenemy(level.player);
    wait 2.5;
  }
}

function return_enemyspawners_in_zones(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    foreach(var_5 in level.enemyspawners) {
      var_6 = spawn("script_origin", var_5.origin);

      if(var_6 istouching(var_3)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_5);
      }

      var_6 delete();
    }
  }

  return var_1;
}

function enemy_move_and_cover(var_0) {
  var_0 endon("death");
  var_0 agentsetfavoriteenemy(level.player);
  var_1 = self;
  var_2 = getnodearray(var_1.target, "targetname");

  if(var_2.size == 0) {
    var_3 = getEntArray(var_1.target, "targetname");

    if(var_3.size > 0) {
      var_4 = var_3[randomint(var_3.size)];
      var_0 setgoalpos(var_4.origin);

      if(isDefined(self.script_speed) && self.script_speed == -1) {
        return;
      }

      if(isDefined(self.speed) && self.speed == -1) {
        return;
      }

      var_5 = scripts\engine\utility::getclosest(var_4.origin, level.brjugg_dropondeath, 500);
      var_2 = var_5;
    } else {
      var_2 = scripts\engine\utility::getclosest(var_0.origin, level.brjugg_dropondeath, 1000);
    }
  }

  var_6 = var_2[randomint(var_2.size)];
  var_7 = 1;
  var_8 = 1;

  while(isalive(var_0)) {
    if(isDefined(var_6)) {
      var_0 setgoalnode(var_6);
      var_0 scripts\engine\utility::ref_143a7("goal", "badpath", "grenade danger", "bullet_whizby");
      var_8 = trialendgame(var_6);
    }

    if(isDefined(var_6)) {
      var_9 = enemy_already_near_node(var_0, var_6);
    } else {
      var_9 = 0;
    }

    var_10 = non_detectable_killstreaks(var_0, var_6);

    if(var_7 && var_10 && !var_9) {
      wait 5;
      var_11 = var_0 iscovervalidagainstenemy(var_6);
      var_10 = non_detectable_killstreaks(var_0, var_6);

      while(var_11 && var_10) {
        wait 1;
        var_11 = var_0 iscovervalidagainstenemy(var_6);
      }
    }

    var_12 = var_0 findbestcoverlist(1);
    var_13 = [];
    var_13 = var_6;
    var_14 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_12, var_13, 1400, 0);

    foreach(var_5 in var_14) {
      var_9 = enemy_already_near_node(var_0, var_5);

      if(var_9 == 0) {
        scripts\engine\utility::array_remove(var_14, var_5);
      }
    }

    if(var_14.size > 0) {
      var_6 = scripts\engine\utility::random(var_14);
      var_7 = trialendgame(var_6);
      continue;
    }

    var_2 = getnodesinradius(var_0.origin, 512, 100, 100);
    var_6 = var_2[randomint(var_2.size)];
    var_7 = trialendgame(var_6);
    var_17 = var_0 getnearestnode();
    var_18 = var_0 findpath(var_17.origin, var_6.origin, 0, 1);

    if(var_18.size == 0 && var_8) {
      var_6 = var_17;
      var_7 = trialendgame(var_6);
    } else if(var_18.size > 14) {
      var_2 = getnodearray(var_1.target, "targetname");
      var_6 = var_2[randomint(var_2.size)];
      var_7 = trialendgame(var_6);
    }
  }
}

function non_detectable_killstreaks(var_0) {
  var_1 = self.goalradius;
  var_2 = distance(var_0.origin, self.origin);
  return var_2 < var_1;
}

function trialendgame() {
  return scripts\engine\utility::string_starts_with(self.type, "cover");
}

function enemy_already_near_node(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\utility::array_remove(level.enemies, self);
  var_3 = sortbydistance(var_2, var_0.origin);

  if(isDefined(var_3[0]) && distance(var_3[0].origin, var_0.origin) < 50) {
    var_1 = 1;
  }

  return var_1;
}

function enemy_soldier_think() {
  level endon("trial_completed");
  self enabletraversals(0);
  self allowedstances("stand", "crouch");
  self.goalradius = 64;
  self.grenadeammo = 0;
  self.baseaccuracy = 0.3;
  self agentsetfavoriteenemy(level.player);
  thread scripts\engine\utility::set_movement_speed(200);
  self.a.disablelongdeath = 1;
  thread enemy_accuracy_think();

  for(var_0 = 0; isalive(self); var_0 = gettime()) {
    wait 0.05;
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    scripts\engine\utility::array_contains(level.players, var_2);
    var_11 = level.player getcurrentweapon();

    if(var_11.basename == "iw8_knife_mp") {
      self kill();
      var_12 = 1;
    } else {
      var_12 = 0;
    }

    level.player thread _tablethide::ref_13d4b(self, var_12, 0, 1);

    if(gettime() - var_0 > 800) {
      self playSound("trial_sfx_enemy_pain");
    }
  }
}

function enemy_accuracy_think() {
  self endon("death");

  while(isalive(self)) {
    var_0 = distance(self.origin, level.player.origin);

    if(var_0 < 250) {
      self.baseaccuracy = 0.8;
    } else if(var_0 < 500) {
      self.baseaccuracy = 0.5;
    } else {
      self.baseaccuracy = 0.3;
    }

    wait 0.25;
  }
}

function enemy_monitor_death(var_0) {
  level endon("trial_completed");

  switch (self.primaryweapon.classname) {
    case "rifle":
      var_1 = "laserrange_bar";
      break;
    case "mg":
      var_1 = "laserrange_bar";
      break;
    case "smg":
      var_1 = "laserirsmg";
      break;
    default:
      var_1 = "";
      break;
  }

  if(isDefined(level.nightmap) && level.nightmap == 1) {
    var_2 = "+" + var_1;
  } else {
    var_2 = "";
  }

  var_3 = createheadicon(self.weapon) + var_2;
  var_4 = self gettagorigin("tag_weapon_right");
  var_5 = self gettagorigin("tag_weapon_right");
  var_6 = spawn("script_origin", var_4);
  var_6.angles = var_5;
  var_6 linkTo(self, "tag_weapon_right");

  if(isalive(self)) {
    self waittill("death", var_7, var_8, var_9, var_10);

    if(isalive(level.player)) {
      var_11 = scripts\engine\utility::array_contains(level.players, var_7);
    } else {
      var_11 = 0;
    }
  } else {
    var_11 = 0;
  }

  var_12 = var_2 == level.enemyteam;

  if(var_12 && var_11) {
    self playSound("trial_sfx_enemy_death");
    level.player thread _tablethide::ref_13d4b(self, 1, 0, 1);
  }

  level notify("enemy_killed");
  level.enemieskilled++;
  level.enemiesactivenb--;
  level.enemies = scripts\engine\utility::array_removedead(level.enemies);

  if(istrue(level.ref_13d3f)) {
    var_11 delete();
    return;
  }

  var_13 = spawn("weapon_" + var_4, var_11.origin);
  var_13.angles = var_11.angles;
  var_14 = int(weaponclipsize(var_13) / 1);
  var_15 = int(weaponclipsize(var_13) / 3);

  if(var_15 == 0) {
    var_15 = 1;
  }

  var_13 itemweaponsetammo(randomintrange(var_15, var_14), 0);
  var_11 delete();
}

function enemy_chatter() {
  while(!isDefined(level.player)) {
    wait 0.05;
  }

  while(!isalive(level.player)) {
    wait 0.05;
  }

  level.player endon("death");
  var_0 = 2;
  var_1 = 5;
  var_2 = 1;
  var_3 = 4;
  var_4 = 1;
  var_5 = 3;
  level scripts\engine\utility::flag_wait("trial_starting");

  for(;;) {
    jumpiffalse(level.enemiesactivenb == 0) LOC_00000069;
    wait 0.05;
  }

  for(;;) {
    var_6 = level.enemieskilled / level.enemiestotal;

    if(var_6 < 0.29) {
      var_7 = "calm";
      var_8 = var_0;
      var_9 = var_1;
    } else if(var_6 < 0.79) {
      var_7 = "aware";
      var_8 = var_2;
      var_9 = var_3;
    } else {
      var_7 = "panic";
      var_8 = var_4;
      var_9 = var_5;
    }

    wait randomfloatrange(var_8, var_9);
    var_10 = scripts\engine\utility::get_array_of_closest(level.player.origin, level.enemies, undefined, 10, 1000);

    if(var_10.size > 0) {
      var_11 = scripts\engine\utility::random_weight_sorted(var_10);
    } else {
      var_11 = scripts\engine\utility::getclosest(level.player.origin, level.enemies, 2500);
    }

    if(isDefined(var_11) && isalive(var_11)) {
      var_12 = level.player gettagorigin("tag_eye");
      var_13 = spawnsighttrace(var_11, var_12, var_11.origin);

      if(var_13) {
        var_14 = "trial_sfx_enemy_radio";
      } else {
        var_14 = "trial_sfx_enemy_chatter";
      }

      var_12 playsoundonmovingent(var_14);
      var_15 = lookupsoundlength(var_14) / 1000;

      if(isDefined(var_15) && var_15 > 0) {
        wait var_15;
      } else {
        wait 4;
      }
    }

    if(scripts\engine\utility::flag("trial_completed")) {
      return;
    }
  }
}

function init_trap_room_debug() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_0 = getEntArray("script_model", "classname");

  foreach(var_2 in var_0) {
    if(var_2.model == "highway_flag0" && isDefined(var_2.script_noteworthy)) {
      switch (var_2.script_noteworthy) {
        case "Exposed":
          var_3 = "Exposed";
          break;
        case "CoverLeft":
          var_3 = "Cover Left";
          break;
        case "CoverRight":
          var_3 = "Cover Right";
          break;
        case "CoverCrouch":
          var_3 = "Cover Crouch";
          break;
        case "CoverStand":
          var_3 = "Cover Stand";
          break;
        case "CoverProne":
          var_3 = "Cover Prone";
          break;
        default:
          var_3 = undefined;
          break;
      }

      if(isDefined(var_3)) {
        var_3 setModel("tag_origin");
        thread ref_134e7(var_3);
      }
    }
  }

  var_3 = undefined;
  var_3 = undefined;
}

function ref_134e7(var_0) {
  level endon("trial_completed");
  var_1 = spawncovernode(self.origin, self.angles, var_0, 16, self.targetname);

  while(!isDefined(var_1)) {
    waitframe();
  }

  if(isDefined(self.radius)) {
    var_1.radius = self.radius;
    return;
  }

  var_1.radius = 24;
}

function hud_init() {
  _tablethide::trial_ui_set_reward_tier(game["trial"]["best_reward"]);
  thread hud_besttime_update();
  thread hud_objectives();
  thread hud_timer();
  thread hud_reward_tiers_tracking();
  thread hud_attempt_over();

  while(!isDefined(level.player)) {
    wait 0.05;
  }

  while(!isalive(level.player)) {
    wait 0.05;
  }

  level.player setclientomnvar("ui_match_in_progress", 1);
}

function hud_objectives() {
  _tablethide::trial_ui_set_objective_icon_index(0);
  _tablethide::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);

  while(!isDefined(level.player)) {
    wait 0.05;
  }

  _tablethide::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  scripts\engine\utility::flag_wait("trial_countdown");

  while(level.enemieskilled < level.enemiestotal) {
    _tablethide::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
    _tablethide::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);
    wait 0.05;
  }

  _tablethide::trial_ui_set_objective_progress(level.enemieskilled, level.enemiestotal);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);
  level notify("stop_timer");
  level scripts\engine\utility::flag_set("trial_completed");
}

function hud_timer() {
  level endon("max_time_limit_reached");
  _tablethide::trial_ui_set_main_time(0);
  _tablethide::trial_ui_set_subtime(0);
  level scripts\engine\utility::flag_wait("trial_starting");
  level.player playSound("trial_sfx_start");
  var_0 = gettime();

  while(!scripts\engine\utility::flag("trial_completed")) {
    var_1 = gettime() - var_0;
    level.totaltimeelapsed = int(var_1);
    _tablethide::trial_ui_set_main_time(level.totaltimeelapsed);
    _tablethide::trial_ui_set_subtime(level.totaltimeelapsed);
    wait 0.05;
  }

  if(!scripts\engine\utility::flag("trial_player_death")) {
    var_1 = gettime() - var_0;
    level.totaltimeelapsed = int(var_1);
    _tablethide::trial_ui_set_main_time(level.totaltimeelapsed);
    _tablethide::trial_ui_set_subtime(level.totaltimeelapsed);

    if(game["trial"]["best_time"] <= 0 || var_1 < game["trial"]["best_time"]) {
      game["trial"]["best_time"] = var_1;
      hud_besttime_update();
      game["trial"]["analytics"]["weapon1"] = level.player.primaryweapons[0].basename;
      game["trial"]["analytics"]["weapon2"] = level.player.primaryweapons[1].basename;
    }
  } else {
    _tablethide::trial_ui_set_main_time(0);
    _tablethide::trial_ui_set_subtime(0);
  }

  level scripts\engine\utility::flag_set("trial_ready_for_endscreen");
}

function hud_reward_tiers_tracking() {
  self endon("stop_timer");
  self waittill("trial_starting");
  var_0 = [];
  var_0[0] = undefined;
  GscBinSkip0(0x2e, 1, level.trial["tier1"]);
}

function hud_fade_to_black() {
  var_0 = 0;

  while(var_0 < 1) {
    level.player setclientomnvar("ui_world_fade", var_0);
    var_0 += 0.05;
    wait 0.05;
  }
}

function hud_attempt_over() {
  level scripts\engine\utility::flag_wait("trial_completed");
  setDvar("scr_death_scene_time", 1.75);
  level.player freezecontrols(1);

  if(!scripts\engine\utility::flag("trial_player_death")) {
    var_0 = game["trial"]["best_reward"];

    if(level.attempttier > var_0) {
      game["trial"]["best_reward"] = level.attempttier;
      _tablethide::trial_ui_set_reward_tier(level.attempttier);
    }

    if(level.attempttier >= 2) {
      var_1 = game["music"]["trials_win_high"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["music"]["trials_win_high"][var_2]);
    } else if(level.attempttier >= 1) {
      var_1 = game["music"]["trials_win_mid"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][var_2]);
    } else {
      var_1 = game["music"]["trials_win_low"].size;
      var_2 = randomint(var_1);
      level.player setplayermusicstate(game["music"]["trials_win_low"][var_2]);
    }

    setomnvar("ui_trial_failed", 0);
  } else if(scripts\engine\utility::flag("trial_player_death")) {
    _tablethide::trial_ui_set_reward_tier_preview(0);
    level.player clearsoundsubmix("deaths_door_mp");
    level.player playSound("trial_sfx_failure");
    var_1 = game["music"]["trials_loss"].size;
    var_2 = randomint(var_1);
    level.player setplayermusicstate(game["music"]["trials_loss"][var_2]);
    setomnvar("ui_trial_failed", 1);
    thread hud_fade_to_black();
    wait 1;
  }

  scripts\engine\utility::array_call(level.enemies, &despawnagent);
  setomnvar("allow_server_pause", 1);
  setomnvarforallclients("post_game_state", 0);
  level scripts\engine\utility::flag_wait("trial_ready_for_endscreen");
  _tablethide::ref_13d89(1);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "enemies_killed", level.enemieskilled, 0);
  _tablethide::trial_ui_open_results_screen();
  level.ref_13d60 = 1;
  _tablethide::trial_ui_waittill_retry();
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  var_3 = game["trial"]["tries_remaining"];

  if(var_3 > 0) {
    level notify("game_cleanup");
    level notify("restarting");
    game["state"] = "playing";
    _tablethide::ref_13d5e();
    return;
  }
}

function hud_besttime_update() {
  var_0 = game["trial"]["best_time"];
  var_1 = game["trial"]["best_reward"];
  _tablethide::trial_ui_set_best_time(var_0);
  _tablethide::trial_ui_set_reward_tier(var_1);
}

function ref_1385c() {
  var_0 = getEnt("starting_trigger", "targetname");
  var_0 waittill("trigger");
  level scripts\engine\utility::flag_set("trial_start_zone_entered");
}

function check_script_noteworthy(var_0, var_1) {
  var_2 = int(var_0.script_noteworthy);
  var_3 = int(var_1.script_noteworthy);
  return var_2 < var_3;
}

function dialog_init() {
  game["dialog"]["trial_intro"] = "kh_clear_intro";
  game["dialog"]["trial_intro_short"] = "kh_clear_intro_short";
  game["dialog"]["trial_end_tier_0"] = "kh_clear_star0_fail";
  game["dialog"]["trial_end_tier_0_alt"] = "kh_clear_star0_death";
  game["dialog"]["trial_end_tier_1"] = "kh_clear_star1";
  game["dialog"]["trial_end_tier_2"] = "kh_clear_star2";
  game["dialog"]["trial_end_tier_3"] = "kh_clear_star3";
  game["dialog"]["trial_retry"] = "kh_clear_retry";
  game["dialog"]["clear_start"] = "kh_clear_start";
  game["dialog"]["clear_search"] = "kh_clear_search";
  game["dialog"]["clear_good_kill"] = "kh_clear_goodkill";
  thread dialog_killstreak_acknowledgement();
  thread dialog_push_forward();
  scripts\engine\utility::flag_wait("trial_starting");
  wait 0.8;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_start");
}

function dialog_push_forward() {
  level endon("trial_completed");
  var_0 = 0;
  var_1 = 0;
  scripts\engine\utility::flag_wait("trial_starting");

  while(!scripts\engine\utility::flag("trial_completed")) {
    wait 1;
    var_2 = level.enemieskilled != var_1;

    if(var_2 == 0 && level.enemies.size > 0) {
      var_3 = sortbydistance(level.enemies, level.player.origin);

      if(distance2d(var_3[0].origin, level.player.origin) > 900) {
        var_0++;
      }
    } else {
      var_0 = 0;
      var_1 = level.enemieskilled;
    }

    if(var_0 > 4) {
      var_0 = 0;
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_search");
      wait 5;
    }
  }
}

function dialog_killstreak_acknowledgement() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 8000;
  level waittill("enemy_killed");
  var_0++;

  for(var_1 = gettime();; var_1 = var_4) {
    level waittill("enemy_killed");
    var_4 = gettime();
    var_5 = var_4 - var_1;

    if(var_5 < 2600) {
      if(var_0 < 3) {
        var_0++;
      }
    } else if(var_5 < 4000) {} else if(var_0 > 0) {
      var_0--;
    }

    if(var_0 > 2 && var_4 > var_2) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_good_kill");
      var_2 = var_4 + var_3;
      var_0 -= 2;
    }
  }
}

function ref_12a8e() {
  for(;;) {
    while(isalive(level.player)) {
      ref_12a91(level.player);
      wait 0.2;
    }

    waitframe();
  }
}

function ref_12a90(var_0, var_1) {
  var_2 = var_0.rechargeequipmentstate;

  if(!isDefined(var_2.progress[var_1])) {
    var_2.progress[var_1] = 0;
  }

  var_2.recharged[var_1] = undefined;
  var_3 = var_0 scripts\mp\equipment::getcurrentequipment(var_1);

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_0 scripts\mp\equipment::getequipmentammo(var_3);
  var_5 = var_0 scripts\mp\equipment::getequipmentmaxammo(var_3);
  var_6 = var_0 scripts\mp\equipment::getequipmentstartammo(var_3);

  if(var_4 < var_5) {
    var_2.progress[var_1] += 0.025;
  } else {
    var_2.progress[var_1] = 0;
  }

  if(var_2.progress[var_1] >= 1) {
    var_0 scripts\mp\equipment::incrementequipmentslotammo(var_1, 1);
    var_2.progress[var_1] = 0;
    var_2.recharged[var_1] = 1;
    return;
  }
}

function ref_12a91(var_0) {
  if(!isDefined(var_0.rechargeequipmentstate)) {
    var_0.rechargeequipmentstate = spawnStruct();
    var_0.rechargeequipmentstate.progress = [];
    var_0.rechargeequipmentstate.recharged = [];
  }

  ref_12a90(var_0, "primary");
  ref_12a90(var_0, "secondary");
  ref_12a92(var_0);
}

function ref_12a92(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = -1;

  if(isDefined(var_0) && isDefined(var_0.rechargeequipmentstate)) {
    var_0 scripts\mp\utility\stats::initpersstat("restockCount");
    var_4 = var_0.rechargeequipmentstate;

    if(isDefined(var_4.progress["primary"])) {
      var_1 = var_4.progress["primary"];
    }

    if(isDefined(var_4.progress["secondary"])) {
      var_2 = var_4.progress["secondary"];
    }

    foreach(var_6 in var_4.recharged) {
      if(var_7 == "primary") {
        var_3 += 1;
        var_0 playlocalsound("ui_restock_lethals");
        var_0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }

      if(var_7 == "secondary") {
        var_3 += 2;
        var_0 playlocalsound("ui_restock_tactical");
        var_0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }
    }
  }

  var_0 setclientomnvar("ui_lethal_recharge_progress", var_1);
  var_0 setclientomnvar("ui_tactical_recharge_progress", var_2);
  var_0 setclientomnvar("ui_recharge_notify", var_3);
}

function build_vehicle_drop_off_list() {
  level.ref_13d32 = &ref_13d31;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["weapon1"] = "DNF";
    game["trial"]["analytics"]["weapon2"] = "DNF";
    return;
  }
}

function ref_13d31() {
  var_0 = level.trial["missionID"];
  var_1 = getomnvar("ui_trial_reward_tier");
  var_2 = getomnvar("ui_trial_best_time");
  var_3 = "" + game["trial"]["analytics"]["weapon1"];
  var_4 = "" + game["trial"]["analytics"]["weapon2"];
  level.player dlog_recordplayerevent("dlog_event_trial_complete_clear", ["id", var_0, "tier", var_1, "time", var_2, "weapon1", var_3, "weapon2", var_4]);
}

function chopperoccupied() {
  var_0 = getentarrayinradius("barrel_col", "targetname", self.origin, 250);
  self disconnectPaths();
  self setCanDamage(1);
  self waittill("damage", var_1, var_2, var_3, var_4, var_5);

  if(var_5 == "MOD_EXPLOSIVE") {
    wait 0.15;
  }

  self radiusdamage(self.origin, 250, 250, 100, level.player, "MOD_EXPLOSIVE");

  if(isDefined(self.script_noteworthy) && !istrue(level.started)) {
    if(self.script_noteworthy == "big_explosion") {
      level notify("nuked");
      level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_nuke_inbound");
      var_6 = 6;
      var_7 = 0.1;
      var_8 = (1645.5, -21164, -2543.5);
      var_9 = vectorNormalize((var_8[0], var_8[1], 0) - (level.player.origin[0], level.player.origin[1], 0));
      var_10 = var_8 + var_9 * 15000;
      var_10 = var_10 + (0, 0, 30000) + var_9 * 5000;
      var_11 = spawnStruct();
      var_11.streakname = "trial_nuke";
      var_11.nukegoalpoint = var_8;
      level.nuke_clockobject = spawn("script_origin", var_10 + (0, 0, 100));
      playsoundatpos(var_10, "iw8_nuke_dist_launch");
      thread nuke_launchmissile(level, undefined, undefined, (1645.5, -21164, -2543.5), var_8);
      wait var_7;
      level thread _calloutmarkerping_handleluinotify_acknowledged::setnuketimescalefactor();
      level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_explosion(undefined, var_11);
      level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_earthquake(undefined, var_11);
      visionsetnaked("nuke_global_flash", 0.05);
      setDvar("r_materialBloomHQScriptMasterEnable", 0);
      wait 0.5;
      level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_fadeflashvision(1, 2);
      wait 3.5;
      playFX(scripts\engine\utility::getfx("nuke_rolling_death"), level.player.origin - (0, 0, 64), anglesToForward(self.angles) * -1, undefined, level.player);
      wait 1;
      _calloutmarkerping_handleluinotify_acknowledged::ref_11ef4();
      wait 2;
      map_restart(1);
    }
  } else {
    playFX(scripts\engine\utility::getfx(ref_129f5()), self.origin);
  }

  foreach(var_13 in var_0) {
    if(isDefined(var_13)) {
      var_13 delete();
    }
  }

  playsoundatpos(self.origin, "dst_propane_expl_atmo");
  level.player earthquakeforplayer(0.15, 0.25, self.origin, 1000);
  playFX(scripts\engine\utility::getfx("barrel_flame_small"), self.origin);
  playFX(scripts\engine\utility::getfx("barrel_fire"), self.origin);
  self hide();
  wait 5;
  self delete();
}

function nuke_launchmissile(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_6 = var_4;
  var_7 = "nuke_mp";

  if(isDefined(var_5)) {
    var_7 = var_5;
  }

  var_8 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var_9 = (var_3 - 0.5 * var_8 * squared(var_4) - var_2) / var_4;
  level.nuke_missile = magicgrenademanual(var_7, var_2, var_9, var_4);
  level.nuke_missile setscriptablepartstate("launch", "on", 0);
}

function ref_129f5() {
  var_0 = randomint(2);

  switch (var_0) {
    case 0:
      return "barrel_explosion1";
    case 1:
      return "barrel_explosion2";
    case 2:
      return "vehicle_explosion";
  }
}

function lb_mg_wood_surf_dmg_scalar() {
  self disconnectPaths();
  var_0 = getnodesinradius(self.origin, 256, 0);

  foreach(var_2 in var_0) {
    var_2 disconnectnode();
  }

  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8);

    if(var_8 == "MOD_EXPLOSIVE" || var_8 == "MOD_GRENADE" || var_8 == "MOD_GRENADE_SPLASH" || var_8 == "MOD_PROJECTILE") {
      break;
    }

    waitframe();
  }

  self radiusdamage(self.origin, 250, 250, 10, level.player);
  playFX(scripts\engine\utility::getfx("vehicle_bomb_explosion"), self.origin);
  playsoundatpos(self.origin, "car_explode");
  level.player earthquakeforplayer(0.45, 0.25, self.origin, 1000);
  playFX(scripts\engine\utility::getfx("vehicle_explosion2"), self.origin);
  playFX(scripts\engine\utility::getfx("vehicle_fire"), self.origin);
  self setModel("veh8_civ_lnd_hindia_static_dst");
  waitframe();
  self hidepart("TAG_DOOR_FRONT_LEFT", "veh8_civ_lnd_hindia_static_dst");
  self hidepart("TAG_DOOR_FRONT_RIGHT", "veh8_civ_lnd_hindia_static_dst");
}

function brplayerhudoutlineupdatefromnotify() {
  self setscriptablepartstate("military_ammo_restock", "USEABLE_OFF");
  var_0 = spawn("script_model", self.origin);
  var_0 linkTo(self, "tag_origin", (0, 35, 44), (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 setCursorHint("hint_button");
  var_0 setHintString(&"MP_INGAME_ONLY/REFILL_AMMO");
  var_0 sethintdisplayrange(200);
  var_0 sethintdisplayfov(120);
  var_0 setuserange(72);
  var_0 setusefov(120);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_short");
  var_0.headicon = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_0.headicon, "cp_crate_icon_ammo");
  setheadiconmaxdistance(var_0.headicon, 800);
  addclienttoheadiconmask(var_0.headicon, 5);
  var_0 makeusable();
  var_0 waittill("trigger");
  var_1 = level.player getweaponslistall();

  foreach(var_3 in var_1) {
    level.player setweaponammostock(var_3, weaponclipsize(var_3) * 2 + level.player getweaponammostock(var_3));
  }

  level.player scripts\mp\damagefeedback::hudicontype("br_ammo");
  level.player playlocalsound("iw8_support_box_use");
  var_0 makeunusable();
  setheadiconteam(var_0.headicon);
}