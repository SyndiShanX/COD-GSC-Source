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

  var0 = getEnt("door_left", "targetname");
  var1 = getEnt("door_right", "targetname");
  var2 = getEnt("door_col_left", "targetname");
  var3 = getEnt("door_col_right", "targetname");
  var4 = undefined;

  if(level.mapname == "mp_spear" || level.mapname == "mp_spear_pm") {
    var4 = getEnt("door_coll", "targetname");
    var5 = getEnt("door_left_coll", "targetname");
    var6 = getEnt("door_right_coll", "targetname");
    var5 linkTo(var0);
    var6 linkTo(var1);
  } else if(isDefined(var2) || isDefined(var3)) {
    if(isDefined(var2)) {
      var0.helimakeexfilwait = var2;
    }

    if(isDefined(var3)) {
      var1.helimakeexfilwait = var3;
    }
  } else {
    var7 = spawn("script_model", var0.origin);
    var7.angles = var0.angles;
    var8 = spawn("script_model", var0.origin);
    var8.angles = var0.angles;
    var9 = spawn("script_model", var1.origin);
    var9.angles = var1.angles;
    var10 = spawn("script_model", var1.origin);
    var10.angles = var1.angles;
    var7 setModel("player128x128x8");
    var8 setModel("player128x128x8");
    var9 setModel("player128x128x8");
    var10 setModel("player128x128x8");
    var7 linkTo(var0, "cp_disco_gate_01_left", (0, -44, 20), (90, 0, 0));
    var8 linkTo(var0, "cp_disco_gate_01_left", (0, -44, 84), (90, 0, 0));
    var9 linkTo(var1, "cp_disco_gate_01_right", (0, -44, 20), (-90, 0, 0));
    var10 linkTo(var1, "cp_disco_gate_01_right", (0, -44, 84), (-90, 0, 0));
  }

  var11 = scripts\mp\trials\mp_trials_patches::trial_chevron_init();

  while(!isDefined(level.player)) {
    wait 0.05;
  }

  if(isDefined(level.ref_13d59)) {
    foreach(var13 in level.ref_13d59) {
      level.player setperk(var13, 1);
    }
  }

  while(!isalive(level.player)) {
    wait 0.05;
  }

  if(game["trial"]["tries_remaining"] > 2) {
    wait 8;
  }

  wait 2;
  thread scripts\mp\trials\mp_trials_patches::trial_chevron_vfx_action(var11, "turn_on");
  level scripts\engine\utility::flag_wait("trial_start_zone_entered");
  level.started = 1;
  thread scripts\mp\trials\mp_trials_patches::trial_chevron_vfx_action(var11, "turn_off");
  _tablethide::ref_13d88();
  _tablethide::ref_13d89(0);
  thread radar_think();
  wait 2;
  level scripts\engine\utility::flag_set("trial_countdown");
  scripts\mp\gamelogic::teamstarttimer(level.player.team, 5);
  level.player setclientomnvar("ui_match_start_countdown", -1);
  level scripts\engine\utility::flag_set("trial_starting");
  thread player_monitor_death();

  if(isDefined(var4)) {
    var4 notsolid();
  }

  var1 playSound("trial_sfx_door_chainlink_fast");
  var0 playSound("trial_sfx_door_chainlink_fast");
  var1 rotateYaw(-150, 0.75);
  var0 rotateYaw(150, 0.75);

  if(isDefined(var0.helimakeexfilwait)) {
    var0.helimakeexfilwait delete();
  }

  if(isDefined(var1.helimakeexfilwait)) {
    var1.helimakeexfilwait delete();
    return;
  }
}

function radar_think() {
  var0 = getDvar("t_clr_radar_type");

  if(var0 != "none") {
    var1 = level.player scripts\mp\equipment::getcurrentequipment("primary");
    var2 = level.player scripts\mp\equipment::getequipmentammo("primary");
    var3 = level.player scripts\mp\equipment::getcurrentequipment("secondary");
    var4 = level.player scripts\mp\equipment::getequipmentammo("secondary");

    if(isDefined(var1)) {
      level.player scripts\mp\equipment::takeequipment("primary");
      var5 = 1;
    } else {
      var5 = 0;
    }

    if(isDefined(var4)) {
      level.player scripts\mp\equipment::takeequipment("secondary");
      var6 = 1;
    } else {
      var6 = 0;
    }

    level.player allowmelee(0);
    level.player allowsprint(0);
    level.player allowreload(0);
    level.player cancelreload();

    while(level.player ismeleeing()) {
      waitframe();
    }

    level.uavsettings[var2].timeout = 9999;
    level.player scripts\cp_mp\killstreaks\uav::tryuseuav(var2);
    waitframe();
    level.player allowmelee(1);
    level.player allowsprint(1);
    level.player allowreload(1);

    if(isDefined(var3) && istrue(var6)) {
      level.player scripts\mp\equipment::giveequipment(var3, "primary");
    }

    if(isDefined(var5) && istrue(var6)) {
      level.player scripts\mp\equipment::giveequipment(var5, "secondary");
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
  level.player waittill("death", var0);
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
  var0 = level.player getweaponslistprimaries();
  jumpiffalse(istrue(level.ref_124c9)) LOC_000000ca;

  foreach(var2 in var0) {
    var3 = level.player getweaponammoclip(var2) + level.player getweaponammostock(var2);
    var4 = level.enemiestotal - weaponclipsize(var2);
    level.player setweaponammoclip(var2, weaponclipsize(var2));
    level.player setweaponammostock(var2, var4);
  }

  foreach(var7 in level.trial_weapons) {
    if(isDefined(var7.spawned_weapon)) {
      var8 = weaponclipsize(var7.spawned_weapon);
      var4 = level.enemiestotal - var8;
      var7.spawned_weapon itemweaponsetammo(var8, var4);
    }
  }

  return;
}

function set_corpse_detect_ranges() {
  var0 = getEntArray("grenade_box", "targetname");
  scripts\engine\utility::array_thread(var0, &set_combat_action);
}

function set_combat_action() {
  switch (self.script_noteworthy) {
    case "frag":
      var0 = "equip_frag";
      var1 = "primary";
      var2 = &"MP_INGAME_ONLY/PICKUP_FRAG";
      break;
    case "semtex":
      var0 = "equip_semtex";
      var1 = "primary";
      var2 = &"MP_INGAME_ONLY/PICKUP_SEMTEX";
      break;
    case "c4":
      var0 = "equip_c4";
      var1 = "primary";
      var2 = &"MP_INGAME_ONLY/PICKUP_C4";
      break;
    case "claymore":
      var0 = "equip_claymore";
      var1 = "primary";
      var2 = &"MP_INGAME_ONLY/PICKUP_CLAYMORE";
      break;
    case "atmine":
      var0 = "equip_at_mine";
      var1 = "primary";
      var2 = &"MP_INGAME_ONLY/PICKUP_ATMINE";
      break;
    case "tknife":
      var0 = "equip_throwing_knife";
      var1 = "primary";
      var2 = &"MP_INGAME_ONLY/PICKUP_TKNIFE";
      break;
    case "molotov":
      var0 = "equip_molotov";
      var1 = "primary";
      var2 = &"MP_INGAME_ONLY/PICKUP_MOLOTOV";
      break;
    case "thermite":
      var0 = "equip_thermite";
      var1 = "primary";
      var2 = &"MP_INGAME_ONLY/PICKUP_THERMITE";
      break;
    case "flash":
      var0 = "equip_flash";
      var1 = "secondary";
      var2 = &"MP_INGAME_ONLY/PICKUP_FLASH";
      break;
    case "snapshot":
      var0 = "equip_snapshot_grenade";
      var1 = "secondary";
      var2 = &"MP_INGAME_ONLY/PICKUP_SNAPSHOT";
      break;
    case "smoke":
      var0 = "equip_smoke";
      var1 = "secondary";
      var2 = &"MP_INGAME_ONLY/PICKUP_SMOKE";
      break;
    case "stun":
      var0 = "equip_concussion";
      var1 = "secondary";
      var2 = &"MP_INGAME_ONLY/PICKUP_STUN";
      break;
    case "trophy":
      var0 = "equip_trophy";
      var1 = "secondary";
      var2 = &"MP_INGAME_ONLY/PICKUP_TROPHY_SYSTEM";
      break;
    case "decoy":
      var0 = "equip_decoy";
      var1 = "secondary";
      var2 = &"MP_INGAME_ONLY/PICKUP_DECOY";
      break;
    case "stim":
      var0 = "equip_adrenaline";
      var1 = "secondary";
      var2 = &"MP_INGAME_ONLY/PICKUP_STIM";
      break;
    case "scrambler":
      var0 = "equip_scramblerdrone";
      var1 = "secondary";
      var2 = &"MP_INGAME_ONLY/PICKUP_SCRAMBLER";
      break;
    default:
      var0 = "equip_frag";
      var1 = "secondary";
      var2 = &"MP_INGAME_ONLY/PICKUP_FRAG";
      break;
  }

  var3 = spawn("script_model", self.origin);
  var3 linkTo(self, "tag_origin", (5, 0, 12), (0, 0, 0));
  var3 setModel("tag_origin");
  var3 setHintString(var2);
  var3 setCursorHint("hint_button");
  var3 sethintdisplayrange(200);
  var3 sethintdisplayfov(65);
  var3 setuserange(72);
  var3 setusefov(120);
  var3 sethintonobstruction("show");
  var3 setuseholdduration("duration_short");

  while(!scripts\engine\utility::flag("trial_completed")) {
    var3 makeusable();
    var3 waittill("trigger");
    level.player scripts\mp\equipment::giveequipment(var0, var1);
    var3 makeunusable();
    wait 2.5;
  }

  var3 makeunusable();
}

function enemies_init() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var0 = getEnt("starting_trigger", "targetname");
  var1 = var0 scripts\engine\utility::get_target_array();
  level.enemyspawners = [];
  var2 = getDvar("t_clr_enemies_total");

  foreach(var4 in var1) {
    if(isDefined(var4.script_index)) {
      if(int(var4.script_index) <= int(var2)) {
        level.enemyspawners = scripts\engine\utility::array_add(level.enemyspawners, var4);
      }

      continue;
    }

    level.enemyspawners = scripts\engine\utility::array_add(level.enemyspawners, var4);
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

function enemy_model_setup(var0) {
  var1 = level.enemyheadmodels[randomint(level.enemyheadmodels.size)];
  var2 = level.enemybodymodels[randomint(level.enemybodymodels.size)];

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(var2);
  self attach(var1, "", 1);
  self.headmodel = var1;
}

function enemy_individual_spawn() {
  var0 = self;
  level scripts\engine\utility::flag_wait("trial_countdown");
  var1 = "enemy_mp_trial_clr_";

  if(isDefined(level.nightmap) && level.nightmap == 1) {
    var2 = "_night";
  } else {
    var2 = "";
  }

  switch (var1.script_noteworthy) {
    case "lmg":
    case "ar":
      var3 = var2 + "ar" + var2;
      break;
    case "smg":
      var3 = var2 + "smg" + var3;
      break;
    default:
      var3 = "enemy_mp_trial_clr";
      break;
  }

  var4 = getEntArray("spawning_zone", "targetname");
  thread enemy_spawner_checkdist(var2);
  var2 waittill("plz_spawn");
  level.enemiesactivenb++;
  level.enemyspawners = scripts\engine\utility::array_remove(level.enemyspawners, var2);
  var5 = scripts\mp\mp_agent::spawnnewagentaitype(var3, var2.origin, var2.angles);

  while(!isDefined(var5)) {
    wait 0.05;
  }

  level.enemies[level.enemies.size] = var5;
  thread enemy_monitor_death(var5);
  thread enemy_soldier_think();
  thread enemy_model_setup();

  if(isDefined(var2.target)) {
    thread enemy_move_and_cover(var2);
    return;
  }
}

function enemy_spawner_checkdist(var0) {
  self endon("plz_spawn");
  var1 = getmaxagents() - 1;
  level scripts\engine\utility::flag_wait("trial_starting");

  if(isDefined(self.radius)) {
    var2 = self.radius;
  } else {
    var2 = 1400;
  }

  var3 = [];
  var4 = spawn("script_origin", self.origin);

  foreach(var6 in var1) {
    if(var6 istouching(var4)) {
      var3 = scripts\engine\utility::array_add(var3, var6);
    }
  }

  var4 delete();

  for(;;) {
    var8 = 0;

    if(var3.size > 0) {
      foreach(var6 in var3) {
        var8 = level.player istouching(var6);
      }
    } else {
      var8 = 1;
    }

    var11 = distance2d(level.player.origin, self.origin);
    var12 = var11 < 250;
    var13 = var11 < var2;
    var14 = level.enemiesactivenb < var2;
    var15 = level.player gettagorigin("tag_eye");
    var16 = (self.origin[0], self.origin[1], self.origin[2] + 40);
    var17 = spawnsighttrace(self, var15, var16);

    if(!var17 && var8 && var13 && !var12 && var14) {
      self notify("plz_spawn");
      continue;
    }

    wait 0.05;
  }
}

function enemies_spawnif_noactive() {
  level scripts\engine\utility::flag_wait("trial_countdown");
  level endon("stop_timer");
  var0 = getEntArray("spawning_zone", "targetname");
  var0 = scripts\engine\utility::array_sort_with_func(var0, &check_script_noteworthy);

  while(!scripts\engine\utility::flag("trial_completed")) {
    var1 = [];
    var2 = [];
    var3 = [];
    var4 = [];
    var5 = undefined;

    while(level.enemies.size > 0) {
      wait 0.25;
    }

    foreach(var7 in var0) {
      if(var7 istouching(level.player)) {
        var1 = scripts\engine\utility::array_add(var1, var7);
      }
    }

    var2 = return_enemyspawners_in_zones(var1);

    if(var2.size == 0) {
      var9 = [];
      var10 = [];

      foreach(var7 in var1) {
        var9 = int(var7.script_noteworthy) + 1;
        var9 = int(var7.script_noteworthy) + -1;
      }

      foreach(var14 in var9) {
        foreach(var7 in var0) {
          if(int(var7.script_noteworthy) == var14) {
            var10 = scripts\engine\utility::array_add(var10, var7);
          }
        }
      }

      var2 = return_enemyspawners_in_zones(var10);
    }

    if(var2.size == 0) {
      var2 = scripts\engine\utility::getclosest(level.player.origin, level.enemyspawners);
    }

    var3 = var2;
    var4 = scripts\engine\utility::get_array_of_closest(level.player.origin, var3);

    if(var4.size > 0) {
      for(var18 = 0; var18 < var4.size; var18++) {
        var5 = scripts\engine\utility::random_weight_sorted(var4);
        var19 = level.player gettagorigin("tag_eye");
        var20 = (var5.origin[0], var5.origin[1], var5.origin[2] + 40);
        var21 = spawnsighttrace(var5, var19, var20);

        if(!var21) {
          var5 notify("plz_spawn");
          break;
        }
      }
    } else {
      var22 = scripts\mp\spawnlogic::getspawnpointarray("mp_dm_spawn_start");
      var23 = scripts\engine\utility::getclosest(level.player.origin, var22);
      var24 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_trial_clr", var23.origin, var23.angles);

      while(!isDefined(var24)) {
        wait 0.05;
      }

      level.enemies[level.enemies.size] = var24;
      thread enemy_monitor_death(var24);
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
    var0 = scripts\mp\mp_agent::getfreeagentcount();

    if(var0 == level.agentarray.size) {
      wait 0.5;

      if(level.enemieskilled + level.enemyspawners.size + level.enemies.size < level.enemiestotal) {
        var1 = scripts\mp\mp_agent::spawnnewagentaitype("enemy_mp_trial_clr", (0, 0, 80), (0, 0, 0));

        while(!isDefined(var1)) {
          wait 0.05;
        }

        level.enemies[level.enemies.size] = var1;
        thread enemy_monitor_death(var1);
        thread enemy_soldier_think();
        thread node_cansee_child();
      }
    }

    wait 0.5;
  }
}

function new_objective() {
  for(;;) {
    foreach(var1 in level.enemies) {
      if(!isalive(var1)) {
        level.enemies = scripts\engine\utility::array_remove(level.enemies, var1);
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

function return_enemyspawners_in_zones(var0) {
  var1 = [];

  foreach(var3 in var0) {
    foreach(var5 in level.enemyspawners) {
      var6 = spawn("script_origin", var5.origin);

      if(var6 istouching(var3)) {
        var1 = scripts\engine\utility::array_add(var1, var5);
      }

      var6 delete();
    }
  }

  return var1;
}

function enemy_move_and_cover(var0) {
  var0 endon("death");
  var0 agentsetfavoriteenemy(level.player);
  var1 = self;
  var2 = getnodearray(var1.target, "targetname");

  if(var2.size == 0) {
    var3 = getEntArray(var1.target, "targetname");

    if(var3.size > 0) {
      var4 = var3[randomint(var3.size)];
      var0 setgoalpos(var4.origin);

      if(isDefined(self.script_speed) && self.script_speed == -1) {
        return;
      }

      if(isDefined(self.speed) && self.speed == -1) {
        return;
      }

      var5 = scripts\engine\utility::getclosest(var4.origin, level.brjugg_dropondeath, 500);
      var2 = var5;
    } else {
      var2 = scripts\engine\utility::getclosest(var0.origin, level.brjugg_dropondeath, 1000);
    }
  }

  var6 = var2[randomint(var2.size)];
  var7 = 1;
  var8 = 1;

  while(isalive(var0)) {
    if(isDefined(var6)) {
      var0 setgoalnode(var6);
      var0 scripts\engine\utility::ref_143a7("goal", "badpath", "grenade danger", "bullet_whizby");
      var8 = trialendgame(var6);
    }

    if(isDefined(var6)) {
      var9 = enemy_already_near_node(var0, var6);
    } else {
      var9 = 0;
    }

    var10 = non_detectable_killstreaks(var0, var6);

    if(var7 && var10 && !var9) {
      wait 5;
      var11 = var0 iscovervalidagainstenemy(var6);
      var10 = non_detectable_killstreaks(var0, var6);

      while(var11 && var10) {
        wait 1;
        var11 = var0 iscovervalidagainstenemy(var6);
      }
    }

    var12 = var0 findbestcoverlist(1);
    var13 = [];
    var13 = var6;
    var14 = scripts\engine\utility::get_array_of_closest(var0.origin, var12, var13, 1400, 0);

    foreach(var5 in var14) {
      var9 = enemy_already_near_node(var0, var5);

      if(var9 == 0) {
        scripts\engine\utility::array_remove(var14, var5);
      }
    }

    if(var14.size > 0) {
      var6 = scripts\engine\utility::random(var14);
      var7 = trialendgame(var6);
      continue;
    }

    var2 = getnodesinradius(var0.origin, 512, 100, 100);
    var6 = var2[randomint(var2.size)];
    var7 = trialendgame(var6);
    var17 = var0 getnearestnode();
    var18 = var0 findpath(var17.origin, var6.origin, 0, 1);

    if(var18.size == 0 && var8) {
      var6 = var17;
      var7 = trialendgame(var6);
    } else if(var18.size > 14) {
      var2 = getnodearray(var1.target, "targetname");
      var6 = var2[randomint(var2.size)];
      var7 = trialendgame(var6);
    }
  }
}

function non_detectable_killstreaks(var0) {
  var1 = self.goalradius;
  var2 = distance(var0.origin, self.origin);
  return var2 < var1;
}

function trialendgame() {
  return scripts\engine\utility::string_starts_with(self.type, "cover");
}

function enemy_already_near_node(var0) {
  var1 = 0;
  var2 = scripts\engine\utility::array_remove(level.enemies, self);
  var3 = sortbydistance(var2, var0.origin);

  if(isDefined(var3[0]) && distance(var3[0].origin, var0.origin) < 50) {
    var1 = 1;
  }

  return var1;
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

  for(var0 = 0; isalive(self); var0 = gettime()) {
    wait 0.05;
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    scripts\engine\utility::array_contains(level.players, var2);
    var11 = level.player getcurrentweapon();

    if(var11.basename == "iw8_knife_mp") {
      self kill();
      var12 = 1;
    } else {
      var12 = 0;
    }

    level.player thread _tablethide::ref_13d4b(self, var12, 0, 1);

    if(gettime() - var0 > 800) {
      self playSound("trial_sfx_enemy_pain");
    }
  }
}

function enemy_accuracy_think() {
  self endon("death");

  while(isalive(self)) {
    var0 = distance(self.origin, level.player.origin);

    if(var0 < 250) {
      self.baseaccuracy = 0.8;
    } else if(var0 < 500) {
      self.baseaccuracy = 0.5;
    } else {
      self.baseaccuracy = 0.3;
    }

    wait 0.25;
  }
}

function enemy_monitor_death(var0) {
  level endon("trial_completed");

  switch (self.primaryweapon.classname) {
    case "rifle":
      var1 = "laserrange_bar";
      break;
    case "mg":
      var1 = "laserrange_bar";
      break;
    case "smg":
      var1 = "laserirsmg";
      break;
    default:
      var1 = "";
      break;
  }

  if(isDefined(level.nightmap) && level.nightmap == 1) {
    var2 = "+" + var1;
  } else {
    var2 = "";
  }

  var3 = createheadicon(self.weapon) + var2;
  var4 = self gettagorigin("tag_weapon_right");
  var5 = self gettagorigin("tag_weapon_right");
  var6 = spawn("script_origin", var4);
  var6.angles = var5;
  var6 linkTo(self, "tag_weapon_right");

  if(isalive(self)) {
    self waittill("death", var7, var8, var9, var10);

    if(isalive(level.player)) {
      var11 = scripts\engine\utility::array_contains(level.players, var7);
    } else {
      var11 = 0;
    }
  } else {
    var11 = 0;
  }

  var12 = var2 == level.enemyteam;

  if(var12 && var11) {
    self playSound("trial_sfx_enemy_death");
    level.player thread _tablethide::ref_13d4b(self, 1, 0, 1);
  }

  level notify("enemy_killed");
  level.enemieskilled++;
  level.enemiesactivenb--;
  level.enemies = scripts\engine\utility::array_removedead(level.enemies);

  if(istrue(level.ref_13d3f)) {
    var11 delete();
    return;
  }

  var13 = spawn("weapon_" + var4, var11.origin);
  var13.angles = var11.angles;
  var14 = int(weaponclipsize(var13) / 1);
  var15 = int(weaponclipsize(var13) / 3);

  if(var15 == 0) {
    var15 = 1;
  }

  var13 itemweaponsetammo(randomintrange(var15, var14), 0);
  var11 delete();
}

function enemy_chatter() {
  while(!isDefined(level.player)) {
    wait 0.05;
  }

  while(!isalive(level.player)) {
    wait 0.05;
  }

  level.player endon("death");
  var0 = 2;
  var1 = 5;
  var2 = 1;
  var3 = 4;
  var4 = 1;
  var5 = 3;
  level scripts\engine\utility::flag_wait("trial_starting");

  for(;;) {
    jumpiffalse(level.enemiesactivenb == 0) LOC_00000069;
    wait 0.05;
  }

  for(;;) {
    var6 = level.enemieskilled / level.enemiestotal;

    if(var6 < 0.29) {
      var7 = "calm";
      var8 = var0;
      var9 = var1;
    } else if(var6 < 0.79) {
      var7 = "aware";
      var8 = var2;
      var9 = var3;
    } else {
      var7 = "panic";
      var8 = var4;
      var9 = var5;
    }

    wait randomfloatrange(var8, var9);
    var10 = scripts\engine\utility::get_array_of_closest(level.player.origin, level.enemies, undefined, 10, 1000);

    if(var10.size > 0) {
      var11 = scripts\engine\utility::random_weight_sorted(var10);
    } else {
      var11 = scripts\engine\utility::getclosest(level.player.origin, level.enemies, 2500);
    }

    if(isDefined(var11) && isalive(var11)) {
      var12 = level.player gettagorigin("tag_eye");
      var13 = spawnsighttrace(var11, var12, var11.origin);

      if(var13) {
        var14 = "trial_sfx_enemy_radio";
      } else {
        var14 = "trial_sfx_enemy_chatter";
      }

      var12 playsoundonmovingent(var14);
      var15 = lookupsoundlength(var14) / 1000;

      if(isDefined(var15) && var15 > 0) {
        wait var15;
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

  var0 = getEntArray("script_model", "classname");

  foreach(var2 in var0) {
    if(var2.model == "highway_flag0" && isDefined(var2.script_noteworthy)) {
      switch (var2.script_noteworthy) {
        case "Exposed":
          var3 = "Exposed";
          break;
        case "CoverLeft":
          var3 = "Cover Left";
          break;
        case "CoverRight":
          var3 = "Cover Right";
          break;
        case "CoverCrouch":
          var3 = "Cover Crouch";
          break;
        case "CoverStand":
          var3 = "Cover Stand";
          break;
        case "CoverProne":
          var3 = "Cover Prone";
          break;
        default:
          var3 = undefined;
          break;
      }

      if(isDefined(var3)) {
        var3 setModel("tag_origin");
        thread ref_134e7(var3);
      }
    }
  }

  var3 = undefined;
  var3 = undefined;
}

function ref_134e7(var0) {
  level endon("trial_completed");
  var1 = spawncovernode(self.origin, self.angles, var0, 16, self.targetname);

  while(!isDefined(var1)) {
    waitframe();
  }

  if(isDefined(self.radius)) {
    var1.radius = self.radius;
    return;
  }

  var1.radius = 24;
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
  var0 = gettime();

  while(!scripts\engine\utility::flag("trial_completed")) {
    var1 = gettime() - var0;
    level.totaltimeelapsed = int(var1);
    _tablethide::trial_ui_set_main_time(level.totaltimeelapsed);
    _tablethide::trial_ui_set_subtime(level.totaltimeelapsed);
    wait 0.05;
  }

  if(!scripts\engine\utility::flag("trial_player_death")) {
    var1 = gettime() - var0;
    level.totaltimeelapsed = int(var1);
    _tablethide::trial_ui_set_main_time(level.totaltimeelapsed);
    _tablethide::trial_ui_set_subtime(level.totaltimeelapsed);

    if(game["trial"]["best_time"] <= 0 || var1 < game["trial"]["best_time"]) {
      game["trial"]["best_time"] = var1;
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
  var0 = [];
  var0[0] = undefined;
  GscBinSkip0(0x2e, 1, level.trial["tier1"]);
}

function hud_fade_to_black() {
  var0 = 0;

  while(var0 < 1) {
    level.player setclientomnvar("ui_world_fade", var0);
    var0 += 0.05;
    wait 0.05;
  }
}

function hud_attempt_over() {
  level scripts\engine\utility::flag_wait("trial_completed");
  setDvar("scr_death_scene_time", 1.75);
  level.player freezecontrols(1);

  if(!scripts\engine\utility::flag("trial_player_death")) {
    var0 = game["trial"]["best_reward"];

    if(level.attempttier > var0) {
      game["trial"]["best_reward"] = level.attempttier;
      _tablethide::trial_ui_set_reward_tier(level.attempttier);
    }

    if(level.attempttier >= 2) {
      var1 = game["music"]["trials_win_high"].size;
      var2 = randomint(var1);
      level.player setplayermusicstate(game["music"]["trials_win_high"][var2]);
    } else if(level.attempttier >= 1) {
      var1 = game["music"]["trials_win_mid"].size;
      var2 = randomint(var1);
      level.player setplayermusicstate(game["music"]["trials_win_mid"][var2]);
    } else {
      var1 = game["music"]["trials_win_low"].size;
      var2 = randomint(var1);
      level.player setplayermusicstate(game["music"]["trials_win_low"][var2]);
    }

    setomnvar("ui_trial_failed", 0);
  } else if(scripts\engine\utility::flag("trial_player_death")) {
    _tablethide::trial_ui_set_reward_tier_preview(0);
    level.player clearsoundsubmix("deaths_door_mp");
    level.player playSound("trial_sfx_failure");
    var1 = game["music"]["trials_loss"].size;
    var2 = randomint(var1);
    level.player setplayermusicstate(game["music"]["trials_loss"][var2]);
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
  var3 = game["trial"]["tries_remaining"];

  if(var3 > 0) {
    level notify("game_cleanup");
    level notify("restarting");
    game["state"] = "playing";
    _tablethide::ref_13d5e();
    return;
  }
}

function hud_besttime_update() {
  var0 = game["trial"]["best_time"];
  var1 = game["trial"]["best_reward"];
  _tablethide::trial_ui_set_best_time(var0);
  _tablethide::trial_ui_set_reward_tier(var1);
}

function ref_1385c() {
  var0 = getEnt("starting_trigger", "targetname");
  var0 waittill("trigger");
  level scripts\engine\utility::flag_set("trial_start_zone_entered");
}

function check_script_noteworthy(var0, var1) {
  var2 = int(var0.script_noteworthy);
  var3 = int(var1.script_noteworthy);
  return var2 < var3;
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
  var0 = 0;
  var1 = 0;
  scripts\engine\utility::flag_wait("trial_starting");

  while(!scripts\engine\utility::flag("trial_completed")) {
    wait 1;
    var2 = level.enemieskilled != var1;

    if(var2 == 0 && level.enemies.size > 0) {
      var3 = sortbydistance(level.enemies, level.player.origin);

      if(distance2d(var3[0].origin, level.player.origin) > 900) {
        var0++;
      }
    } else {
      var0 = 0;
      var1 = level.enemieskilled;
    }

    if(var0 > 4) {
      var0 = 0;
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_search");
      wait 5;
    }
  }
}

function dialog_killstreak_acknowledgement() {
  var0 = 0;
  var1 = 0;
  var2 = 0;
  var3 = 8000;
  level waittill("enemy_killed");
  var0++;

  for(var1 = gettime();; var1 = var4) {
    level waittill("enemy_killed");
    var4 = gettime();
    var5 = var4 - var1;

    if(var5 < 2600) {
      if(var0 < 3) {
        var0++;
      }
    } else if(var5 < 4000) {} else if(var0 > 0) {
      var0--;
    }

    if(var0 > 2 && var4 > var2) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("clear_good_kill");
      var2 = var4 + var3;
      var0 -= 2;
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

function ref_12a90(var0, var1) {
  var2 = var0.rechargeequipmentstate;

  if(!isDefined(var2.progress[var1])) {
    var2.progress[var1] = 0;
  }

  var2.recharged[var1] = undefined;
  var3 = var0 scripts\mp\equipment::getcurrentequipment(var1);

  if(!isDefined(var3)) {
    return;
  }

  var4 = var0 scripts\mp\equipment::getequipmentammo(var3);
  var5 = var0 scripts\mp\equipment::getequipmentmaxammo(var3);
  var6 = var0 scripts\mp\equipment::getequipmentstartammo(var3);

  if(var4 < var5) {
    var2.progress[var1] += 0.025;
  } else {
    var2.progress[var1] = 0;
  }

  if(var2.progress[var1] >= 1) {
    var0 scripts\mp\equipment::incrementequipmentslotammo(var1, 1);
    var2.progress[var1] = 0;
    var2.recharged[var1] = 1;
    return;
  }
}

function ref_12a91(var0) {
  if(!isDefined(var0.rechargeequipmentstate)) {
    var0.rechargeequipmentstate = spawnStruct();
    var0.rechargeequipmentstate.progress = [];
    var0.rechargeequipmentstate.recharged = [];
  }

  ref_12a90(var0, "primary");
  ref_12a90(var0, "secondary");
  ref_12a92(var0);
}

function ref_12a92(var0) {
  var1 = 0;
  var2 = 0;
  var3 = -1;

  if(isDefined(var0) && isDefined(var0.rechargeequipmentstate)) {
    var0 scripts\mp\utility\stats::initpersstat("restockCount");
    var4 = var0.rechargeequipmentstate;

    if(isDefined(var4.progress["primary"])) {
      var1 = var4.progress["primary"];
    }

    if(isDefined(var4.progress["secondary"])) {
      var2 = var4.progress["secondary"];
    }

    foreach(var6 in var4.recharged) {
      if(var7 == "primary") {
        var3 += 1;
        var0 playlocalsound("ui_restock_lethals");
        var0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }

      if(var7 == "secondary") {
        var3 += 2;
        var0 playlocalsound("ui_restock_tactical");
        var0 scripts\mp\utility\stats::incpersstat("restockCount", 1);
      }
    }
  }

  var0 setclientomnvar("ui_lethal_recharge_progress", var1);
  var0 setclientomnvar("ui_tactical_recharge_progress", var2);
  var0 setclientomnvar("ui_recharge_notify", var3);
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
  var0 = level.trial["missionID"];
  var1 = getomnvar("ui_trial_reward_tier");
  var2 = getomnvar("ui_trial_best_time");
  var3 = "" + game["trial"]["analytics"]["weapon1"];
  var4 = "" + game["trial"]["analytics"]["weapon2"];
  level.player dlog_recordplayerevent("dlog_event_trial_complete_clear", ["id", var0, "tier", var1, "time", var2, "weapon1", var3, "weapon2", var4]);
}

function chopperoccupied() {
  var0 = getentarrayinradius("barrel_col", "targetname", self.origin, 250);
  self disconnectPaths();
  self setCanDamage(1);
  self waittill("damage", var1, var2, var3, var4, var5);

  if(var5 == "MOD_EXPLOSIVE") {
    wait 0.15;
  }

  self radiusdamage(self.origin, 250, 250, 100, level.player, "MOD_EXPLOSIVE");

  if(isDefined(self.script_noteworthy) && !istrue(level.started)) {
    if(self.script_noteworthy == "big_explosion") {
      level notify("nuked");
      level.player thread scripts\mp\utility\dialog::leaderdialogonplayer(level.player.team + "_enemy_nuke_inbound");
      var6 = 6;
      var7 = 0.1;
      var8 = (1645.5, -21164, -2543.5);
      var9 = vectorNormalize((var8[0], var8[1], 0) - (level.player.origin[0], level.player.origin[1], 0));
      var10 = var8 + var9 * 15000;
      var10 = var10 + (0, 0, 30000) + var9 * 5000;
      var11 = spawnStruct();
      var11.streakname = "trial_nuke";
      var11.nukegoalpoint = var8;
      level.nuke_clockobject = spawn("script_origin", var10 + (0, 0, 100));
      playsoundatpos(var10, "iw8_nuke_dist_launch");
      thread nuke_launchmissile(level, undefined, undefined, (1645.5, -21164, -2543.5), var8);
      wait var7;
      level thread _calloutmarkerping_handleluinotify_acknowledged::setnuketimescalefactor();
      level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_explosion(undefined, var11);
      level thread _calloutmarkerping_handleluinotify_acknowledged::nuke_earthquake(undefined, var11);
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

  foreach(var13 in var0) {
    if(isDefined(var13)) {
      var13 delete();
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

function nuke_launchmissile(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var6 = var4;
  var7 = "nuke_mp";

  if(isDefined(var5)) {
    var7 = var5;
  }

  var8 = (0, 0, -1 * getdvarint("NPOQPMP", 800));
  var9 = (var3 - 0.5 * var8 * squared(var4) - var2) / var4;
  level.nuke_missile = magicgrenademanual(var7, var2, var9, var4);
  level.nuke_missile setscriptablepartstate("launch", "on", 0);
}

function ref_129f5() {
  var0 = randomint(2);

  switch (var0) {
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
  var0 = getnodesinradius(self.origin, 256, 0);

  foreach(var2 in var0) {
    var2 disconnectnode();
  }

  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var4, var5, var6, var7, var8);

    if(var8 == "MOD_EXPLOSIVE" || var8 == "MOD_GRENADE" || var8 == "MOD_GRENADE_SPLASH" || var8 == "MOD_PROJECTILE") {
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
  var0 = spawn("script_model", self.origin);
  var0 linkTo(self, "tag_origin", (0, 35, 44), (0, 0, 0));
  var0 setModel("tag_origin");
  var0 setCursorHint("hint_button");
  var0 setHintString(&"MP_INGAME_ONLY/REFILL_AMMO");
  var0 sethintdisplayrange(200);
  var0 sethintdisplayfov(120);
  var0 setuserange(72);
  var0 setusefov(120);
  var0 sethintonobstruction("show");
  var0 setuseholdduration("duration_short");
  var0.headicon = deleteheadicon(var0);
  setheadiconfriendlyimage(var0.headicon, "cp_crate_icon_ammo");
  setheadiconmaxdistance(var0.headicon, 800);
  addclienttoheadiconmask(var0.headicon, 5);
  var0 makeusable();
  var0 waittill("trigger");
  var1 = level.player getweaponslistall();

  foreach(var3 in var1) {
    level.player setweaponammostock(var3, weaponclipsize(var3) * 2 + level.player getweaponammostock(var3));
  }

  level.player scripts\mp\damagefeedback::hudicontype("br_ammo");
  level.player playlocalsound("iw8_support_box_use");
  var0 makeunusable();
  setheadiconteam(var0.headicon);
}