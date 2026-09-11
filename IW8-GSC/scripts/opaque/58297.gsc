/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58297.gsc
***********************************************/

function keypad_check_levelinput() {
  if(!isDefined(level.ref_13d51)) {
    level.ref_13d51 = [];
  }

  level.ref_13d51["lava"] = &init;
}

function init() {
  build_vehicle_drop_off_list();
  precachemodel("tag_origin");
  precachemodel("head_russian_army_gasmask_1_alt");
  precachemodel("body_spetsnaz_cqc");
  precachemodel("offhand_wm_at_mine");
  level.ref_14538 = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_chev_inactive_grey.vfx");
  level.ref_14534 = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_chev_active_yellow.vfx");
  level.ref_14535 = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_chev_completed_blue.vfx");
  level.ref_14536 = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_flagbase.vfx");
  level.plunder_initrepositories = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_gas_jet_start.vfx");
  level.plunder_registerrepositoryinstance = loadfx("vfx/iw8_mp/trials/fl_petrograd/vfx_trials_gas_cloud_linger_lg.vfx");
  level.plunder_removeanchoredwidgetfromrepositoryinstance = loadfx("vfx/iw8/level/captive/vfx_cpt_gas_cloud_linger.vfx");
  level.ref_11c15 = loadfx("vfx/core/equipment/vfx_at_mine_light_en.vfx");
  level.ref_11c14 = loadfx("vfx/iw8_mp/equipment/vfx_at_mine_launch.vfx");
  level.ref_11c12 = loadfx("vfx/iw8_mp/equipment/c4/vfx_gen_c4_exp_dud.vfx");
  level.ref_11c13 = loadfx("vfx/iw8_mp/equipment/mine/vfx_at_mine_exp.vfx");

  if(!isDefined(game["trial"])) {
    game["trial"] = [];
  }

  if(!isDefined(game["trial"]["tries_remaining"])) {
    game["trial"]["tries_remaining"] = level.trial["attempts"];
  }

  if(!isDefined(game["trial"]["best_reward"])) {
    game["trial"]["best_reward"] = 0;
  }

  level.set_force_aitype_suicidebomber = [];
  level.ref_1453f = 0;
  level.ref_13b67 = 0;
  level.timeelapsed = 0;
  level.totaltime = 0;
  level.ref_11f8e = 0;
  level.ref_11b77 = 59999900;
  level.battlechatterenabled = 0;
  level scripts\engine\utility::flag_init("trial_prestart");
  level scripts\engine\utility::flag_init("trial_in_progress");
  level scripts\engine\utility::flag_init("trial_completed");
  level scripts\engine\utility::flag_init("trial_ready_for_endscreen");
  level scripts\engine\utility::flag_init("trial_player_death");

  if(!isDefined(level.node_is_valid)) {
    level.node_is_valid = getEntArray("enemy_spawner", "targetname");
  }

  if(level.node_is_valid.size != 0) {
    scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  }

  level.enemyheadmodels = [];
  level.enemyheadmodels[0] = "head_russian_army_gasmask_1_alt";
  level.enemybodymodels = [];
  level.enemybodymodels[0] = "body_spetsnaz_cqc";
  waitframe();

  if(isDefined(level.ref_13d57)) {
    while(level.ref_13d57 == 0) {
      waitframe();
    }
  }

  thread trial_start_init();
  thread player_init();
  thread hud_init();
  thread dialog_init();
  thread enemies_init();
  var0 = getEnt("clip8x8x256", "targetname");
  var1 = getnodearray("traverse", "targetname");
  var2 = [];

  foreach(var4 in var1) {
    var2 = getnode(var4.target, "targetname");
  }

  var6 = scripts\engine\utility::array_combine(var1, var2);

  if(isDefined(var0)) {
    foreach(var8 in var6) {
      if(isDefined(var8.origin)) {
        var9 = spawn("script_model", var8.origin);
        var9 clonebrushmodeltoscriptmodel(var0);
        var9 disconnectPaths();
        var8 disconnectnode();
        var9 notsolid();
      }
    }
  }

  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isalive(level.player)) {
    waitframe();
  }

  level.nosuspensemusic = 1;
}

function trial_start_init() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isalive(level.player)) {
    waitframe();
  }

  ref_1453c();

  if(game["trial"]["tries_remaining"] == 3) {
    wait 3.5;
  }

  _tablethide::ref_13d88();
  _tablethide::ref_13d89(0);
  wait 7.5;
  level scripts\engine\utility::flag_set("trial_prestart");
  thread player_set_weapon();

  switch (level.trial["variant"]) {
    case "free":
      level.dogtags = scripts\engine\utility::getStructArray("trial_waypoint_free", "targetname");
      thread ref_1453d();
      break;
    default:
      thread ref_1453e();
      break;
  }

  thread player_monitor_death();
  thread set_ending_pack();
  var0 = getEnt("trial_truck_door_left", "targetname");
  var1 = getEnt("trial_truck_door_right", "targetname");
  var2 = getEnt("trial_truck_door_coll_l", "targetname");
  var3 = getEnt("trial_truck_door_coll_r", "targetname");
  var0 playsoundonmovingent("trial_sfx_door_truck_left");
  var1 playsoundonmovingent("trial_sfx_door_truck_right");
  var2 linkTo(var0);
  var3 linkTo(var1);

  if(!isDefined(level.ref_13d83)) {
    level.ref_13d83 = 150;
  }

  var1 rotateYaw(level.ref_13d83, 2);
  var0 rotateYaw(level.ref_13d83 * -1, 2);
}

function ref_1453c() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var0 = level.trial["variant"];

  if(!isDefined(level.ref_14540)) {
    level.ref_14540 = scripts\engine\utility::getStructArray("trial_waypoint_" + var0, "targetname");
  }

  level.ref_1453b = [];

  foreach(var2 in level.ref_14540) {
    var3 = spawn("script_model", var2.origin);
    var3.angles = var2.angles;
    var3.targetname = "floorislava_waypoint";

    if(isDefined(var2.script_index)) {
      var3.script_index = var2.script_index;
    } else if(isDefined(var2.script_noteworthy)) {
      var3.script_index = var2.script_noteworthy;
    }

    var3 setModel("tag_origin");

    if(isDefined(var2.script_noteworthy)) {
      var3.script_noteworthy = var2.script_noteworthy;
    }

    level.ref_1453b[int(var3.script_index)] = var3;
  }
}

function ref_1453d() {
  level scripts\engine\utility::flag_wait("trial_prestart");
  var0 = 0;

  foreach(var2 in level.dogtags) {
    thread ref_13533(var2, var2, level.player);
    thread ref_135a8();
    var0++;
  }

  while(level.ref_1453f < level.ref_1453b.size) {
    wait 0.05;
  }

  level scripts\engine\utility::flag_set("trial_completed");
}

function ref_1453e() {
  level scripts\engine\utility::flag_wait("trial_prestart");
  var0 = ref_13563();
  var1 = undefined;
  waitframe();

  for(var2 = 0; var2 < level.ref_1453b.size; var2++) {
    waitframe();

    if(var2 + 1 == level.ref_1453b.size) {
      var3 = spawn("script_model", level.ref_1453b[var2].origin);
      var3.angles = (level.ref_1453b[var2].angles[0] - 90, level.ref_1453b[var2].angles[1], level.ref_1453b[var2].angles[2]);
      var3 setModel("tag_origin");
      waitframe();
      playFXOnTag(level.ref_14536, var3, "TAG_ORIGIN");
    }

    if(isDefined(level.ref_1453b[var2 + 1])) {
      playFXOnTag(level.ref_14538, level.ref_1453b[var2 + 1], "TAG_ORIGIN");
    }

    waitframe();
    killfxontag(level.ref_14538, level.ref_1453b[var2], "TAG_ORIGIN");
    playFXOnTag(level.ref_14534, level.ref_1453b[var2], "TAG_ORIGIN");
    thread ref_135a8();
    waitframe();
    var0 moveTo((level.ref_1453b[var2].origin[0], level.ref_1453b[var2].origin[1], level.ref_1453b[var2].origin[2] + 30), 1, 0.1, 0.3);
    ref_14539(level.ref_1453b[var2]);

    if(var2 == 0) {
      killfxontag(level.ref_14536, level.ref_1453b[0], "TAG_ORIGIN");
    }
  }

  level scripts\engine\utility::flag_set("trial_completed");
  setheadiconimage(level.ref_14537);
}

function ref_14539() {
  for(;;) {
    var0 = distance(self.origin, level.player.origin);
    var1 = abs(self.origin[2] - level.player.origin[2]);

    if(var0 < 80 && var1 < 24) {
      break;
    }

    wait 0.05;
  }

  if(!scripts\engine\utility::flag("trial_in_progress")) {
    level scripts\engine\utility::flag_set("trial_in_progress");
  }

  level.ref_1453f++;
  killfxontag(level.ref_14534, self, "TAG_ORIGIN");
  playFXOnTag(level.ref_14535, self, "TAG_ORIGIN");

  if(level.ref_1453f < level.ref_1453b.size) {
    level.player playSound("trial_sfx_success");
  }

  self notify("reached");
  thread spawn_soldiers_in_convoy_truck();
  var2 = isDefined(self.script_noteworthy) && self.script_noteworthy == "spawn_enemy";
  var3 = isDefined(self.script_index);

  if(var2 || var3) {
    foreach(var5 in level.node_is_valid) {
      if(int(var5.script_index) == int(self.script_index)) {
        var5 notify("trigger");
      }
    }
  }

  level.player setclientomnvar("ui_edge_glow_trials", 255);
  level.player scripts\engine\utility::delaycall(0.5, &setclientomnvar, "ui_edge_glow_trials", 0);
}

function ref_13533(var0, var1, var2) {
  var3 = 14;
  var4 = (0, 0, 0);
  var5 = var0.angles;

  if(var0 scripts\mp\gameobjects::touchingarbitraryuptrigger()) {
    var5 = var0 getworldupreferenceangles();
    var4 = anglestoup(var5);

    if(var4[2] < 0) {
      var3 = -14;
    }
  }

  GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)));
}

function ref_135a8() {
  var0 = undefined;

  switch (level.trial["variant"]) {
    case "free":
      var0 = "icon_minimap_dogtag";
      break;
    default:
      var0 = "icon_waypoint_marker";
      break;
  }

  var1 = level.ref_11f8e;
  level.ref_11f8e++;
  objective_state(var1, "active");
  objective_position(var1, self.origin);
  objective_setplayintro(var1, 0);
  objective_icon(var1, var0);
  objective_setbackground(var1, 1);
  objective_setfadedisabled(var1, 0);
  objective_setshowoncompass(var1, 1);
  objective_setminimapiconsize(var1, "icon_regular");
  objective_setshowdistance(var1, 0);
  objective_ping(var1);
  self waittill("reached");
  objective_delete(var1);
}

function ref_13563() {
  var0 = spawn("script_model", (0, 0, 0));
  var0 setModel("tag_origin");
  level.ref_14537 = deleteheadicon(var0);
  setheadiconfriendlyimage(level.ref_14537, "icon_waypoint_marker");
  setheadiconzoffset(level.ref_14537, 1);
  setheadiconsnaptoedges(level.ref_14537, 0);
  setheadicondrawthroughgeo(level.ref_14537, 1);
  return var0;
}

function set_ending_pack() {
  level scripts\engine\utility::flag_wait("trial_prestart");
  level.player endon("death");
  var0 = spawn("script_model", level.player.origin);
  var0 setModel("tag_origin");
  var0 setentityowner(level.player);
  var0 setotherent(level.player);
  level.set_force_aitype_suicidebomber = getEntArray("trigger_on_ground", "script_noteworthy");

  while(!scripts\engine\utility::flag("trial_completed")) {
    var1 = 0;
    var2 = updatematchstatushintonhasflag();

    if(var2 == 1) {
      if(!scripts\engine\utility::flag("trial_in_progress")) {
        level scripts\engine\utility::flag_set("trial_in_progress");
      }

      var3 = gettime();
      level.player playSound("trial_sfx_buzzer_bad_1");
      thread set_force_aitype_riotshield();
      var4 = 0;

      while(var2 == 1) {
        if(var4 == 0) {
          level.player dodamage(22, level.player.origin, level.player, var0, "MOD_FIRE");
          level.player playRumbleOnEntity("damage_light");
        }

        wait 0.05;
        var2 = updatematchstatushintonhasflag();
        var4++;

        if(var4 >= 15) {
          var4 = 0;
          level.player notify("gas_warning_vo");
        }
      }

      level.player thread scripts\mp\equipment\gas_grenade::gas_removeblur();
      var5 = gettime();
      var1 = var5 - var3;
      level.ref_13b67 += var1;
    }

    waitframe();
  }
}

function set_force_aitype_riotshield() {
  level.player playsoundtoplayer("gas_player_cough", level.player, level.player);
  level.player scripts\common\utility::allow_jump(0);
  level.player thread scripts\mp\equipment\gas_grenade::gas_applyblur();
  level.player thread scripts\mp\equipment\gas_grenade::gas_applycough();
  wait 1.25;
  level.player scripts\common\utility::allow_jump(1);
  level.player thread scripts\mp\equipment\gas_grenade::gas_removecough(0);
}

function updatematchstatushintonhasflag() {
  var0 = 0;

  foreach(var2 in level.set_force_aitype_suicidebomber) {
    if(level.player istouching(var2)) {
      var0 = 1;
    }
  }

  if(var0 && level.player isonground()) {
    var4 = 1;
  } else {
    var4 = 0;
  }

  return var4;
}

function player_set_weapon() {
  var0 = scripts\engine\utility::getStructArray("trial_vfx_gas_emit", "script_noteworthy");
  var1 = scripts\engine\utility::getStructArray("trial_vfx_gas_linger", "script_noteworthy");
  var2 = scripts\engine\utility::getStructArray("trial_vfx_gas_linger_lg", "script_noteworthy");
  var3 = getEntArray("trial_vfx_gas_emit", "script_noteworthy");
  var4 = getEntArray("trial_vfx_gas_linger", "script_noteworthy");
  var5 = getEntArray("trial_vfx_gas_linger_lg", "script_noteworthy");
  var6 = scripts\engine\utility::array_combine(var0, var3);
  var7 = scripts\engine\utility::array_combine(var1, var4);
  var8 = scripts\engine\utility::array_combine(var2, var5);

  foreach(var10 in var7) {
    var11 = spawn("script_model", (var10.origin[0], var10.origin[1], var10.origin[2] + 8));
    var11 setModel("tag_origin");
    wait 0.05;
    thread plundercountdownupdatetime(level.plunder_removeanchoredwidgetfromrepositoryinstance, var11, "TAG_ORIGIN");
  }

  foreach(var10 in var8) {
    var11 = spawn("script_model", var10.origin);
    var11.angles = var10.angles;
    var11 setModel("tag_origin");
    wait 0.05;
    thread plundercountdownupdatetime(level.plunder_registerrepositoryinstance, var11, "TAG_ORIGIN");
  }

  foreach(var10 in var6) {
    var11 = spawn("script_model", var10.origin);
    var11.angles = var10.angles;
    var11 setModel("tag_origin");
    wait 0.05;
    scripts\engine\utility::play_loopsound_in_space("trial_sfx_gas_hiss", var11.origin);
    thread plundercountdownupdatetime(level.plunder_initrepositories, var11, "TAG_ORIGIN");
  }
}

function plundercountdownupdatetime(var0, var1, var2) {
  level endon("trial_completed");

  for(;;) {
    while(distance2d(var1.origin, level.player.origin) > 800) {
      wait 0.25;
    }

    playFXOnTag(var0, var1, var2);

    while(distance2d(var1.origin, level.player.origin) < 1000) {
      wait 0.25;
    }

    stopFXOnTag(var0, var1, var2);
  }
}

function player_init() {
  if(istrue(level.ref_13d93)) {
    var0 = undefined;
  } else {
    switch (level.trial["variant"]) {
      case "knife":
        var0 = "iw8_knife";
        break;
      case "shield":
        var0 = "iw8_me_riotshield";
        break;
      case "pistol":
        var0 = "iw8_pi_decho";
        break;
      case "free":
        var0 = "iw8_knife";
        break;
      default:
        var0 = undefined;
        break;
    }

    level.trial_loadout["axis"]["loadoutPrimary"] = var0;
  }

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player freezecontrols(1);
  level.player freezelookcontrols(1);

  while(!isalive(level.player)) {
    waitframe();
  }

  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  thread hud_fade_to_black(4.1, 1);
  waitframe();
  level.player freezecontrols(1);

  if(istrue(level.ref_125ca)) {
    level.player scripts\mp\equipment::giveequipment("equip_throwing_knife", "primary");
    level.player scripts\mp\equipment::incrementequipmentslotammo("primary", 1);
  }

  if(istrue(level.ref_125cb)) {
    level.player scripts\mp\equipment::giveequipment("equip_rock", "primary");
    level.player scripts\mp\equipment::incrementequipmentslotammo("primary", 1);
  }

  level.player.maxhealth = 250;
  level.player.health = 250;
  waitframe();

  if(isDefined(level.ref_126a5)) {
    var1 = spawn("script_model", level.ref_126a5.origin);
    var1 setModel("tag_origin");
    var1.angles = level.ref_126a5.angles;
    wait 0.5;
    level.player playerlinkTo(var1, "tag_origin", 1, 0, 0, 0, 0);

    if(game["trial"]["tries_remaining"] >= 3) {
      wait 8;
    } else {
      wait 0.5;
    }

    level.player unlink();
  }

  level.player freezecontrols(1);
  level scripts\engine\utility::flag_wait("trial_prestart");
  wait 0.25;
  level.player freezecontrols(0);
  level.player freezelookcontrols(0);
  level.player.ignoreriotshieldxp = 1;
  level scripts\engine\utility::flag_wait("trial_completed");

  while(!level.player isonground()) {
    wait 0.05;
  }

  level.player freezelookcontrols(1);
  level.player freezecontrols(1);
}

function player_monitor_death() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isalive(level.player)) {
    waitframe();
  }

  setDvar("scr_death_scene_time", 6.2);
  setdynamicdvar("scr_trial_playerrespawndelay", 0);
  level.player waittill("death");
  setDvar("scr_death_scene_time", 1.75);
  level.player setclientomnvar("ui_killcam_killedby_id", level.player getentitynumber());
  level.trial_fail_alt = 1;
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  level scripts\engine\utility::flag_set("trial_player_death");
  level scripts\engine\utility::flag_set("trial_completed");
  level.player waittill("spawned_player");
  thread hud_fade_to_black(4, 1);

  if(isDefined(level.ref_126a5)) {
    var0 = spawn("script_model", level.ref_126a5.origin);
    var0 setModel("tag_origin");
    var0.angles = level.ref_126a5.angles;
    wait 0.5;
    level.player playerlinkTo(var0, "tag_origin", 1, 0, 0, 0, 0);

    if(game["trial"]["tries_remaining"] >= 3) {
      wait 8;
    } else {
      wait 0.5;
    }

    level.player unlink();
    level.player takeallweapons(0, 1);
    level.player giveweapon("iw8_fists_mp");
    return;
  }
}

function enemies_init() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  foreach(var1 in level.node_is_valid) {
    var1 setModel("tag_origin");
  }

  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isalive(level.player)) {
    waitframe();
  }

  if(level.player.team == "axis") {
    level.enemyteam = "allies";
  } else {
    level.enemyteam = "axis";
  }

  level.agent_definition["actor_enemy_mp_trial_fil"]["team"] = level.enemyteam;

  if(!scripts\engine\utility::flag_exist("scriptables_ready")) {
    scripts\engine\utility::flag_init("scriptables_ready");
  }

  foreach(var4 in level.node_is_valid) {
    if(isDefined(var4.script_noteworthy) && var4.script_noteworthy != "spawn_enemy") {
      var4.script_index = int(var4.script_noteworthy);
    }
  }

  thread no_aerial_munitions();
  scripts\engine\utility::array_thread(level.node_is_valid, &enemy_individual_spawn);
}

function enemy_individual_spawn() {
  self waittill("trigger");
  var0 = scripts\mp\mp_agent::spawnnewagentaitype("actor_enemy_mp_trial_fil", self.origin, self.angles);

  while(!isDefined(var0)) {
    wait 0.05;
  }

  var0.grenadeammo = 0;
  var0.a.disablelongdeath = 1;
  var0 agentsetfavoriteenemy(level.player);
  thread nextbombplanttime();
  thread enemy_monitor_death();
  thread no_enemy_weapon_drops();
  thread no_jugg_early_exit();
  var1 = level.enemyheadmodels[randomint(level.enemyheadmodels.size)];
  var2 = level.enemybodymodels[randomint(level.enemybodymodels.size)];

  if(isDefined(var0.headmodel)) {
    var0 detach(var0.headmodel);
  }

  var0 setModel(var2);
  var0 attach(var1, "", 1);
  var0.headmodel = var1;
  var0 waittill("shooting");
  level notify("enemy_shooting");
}

function nextbombplanttime() {
  while(isalive(self)) {
    wait 0.05;
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9);
    scripts\engine\utility::array_contains(level.players, var1);
    self kill();
    level.player thread _tablethide::ref_13d4b(self, 1, 0, 1);
  }
}

function enemy_monitor_death() {
  level endon("trial_completed");

  if(isalive(self)) {
    self waittill("death", var0, var1, var2);

    if(isalive(level.player)) {
      var3 = scripts\engine\utility::array_contains(level.players, var0);
    } else {
      var3 = 0;
    }
  } else {
    var3 = 0;
  }

  if(var3) {
    level.player thread _tablethide::ref_13d4b(self, 1, 0, 1);
  }

  level.player notify("enemy_killed");
}

function no_enemy_weapon_drops() {
  self endon("death");
  level endon("trial_completed");

  while(isalive(self)) {
    self.dontevershoot = 0;
    self.bulletsinclip = 20;
    self.accuracy = 0.2;

    while(self.bulletsinclip > 12) {
      wait 0.05;
    }

    self.accuracy = 0.5;

    while(self.bulletsinclip > 3) {
      wait 0.05;
    }

    self.dontevershoot = 1;
    wait 0.5;

    if(isDefined(self)) {
      self playsoundonmovingent("trial_sfx_enemyreloading_us");
    }

    wait 3.5;
  }
}

function no_jugg_early_exit() {
  self endon("death");

  while(!scripts\engine\utility::flag("trial_completed")) {
    wait 0.5;
  }

  self.dontevershoot = 1;
  wait 5;

  if(isalive(self)) {
    self despawnagent();
    return;
  }
}

function no_aerial_munitions() {
  scripts\engine\utility::flag_wait("trial_prestart");
  var0 = getEntArray("enemy_mine", "targetname");

  foreach(var2 in var0) {
    var2 setModel("offhand_wm_at_mine");
    var2 setCanDamage(1);
    thread ninetypercent_music();
    thread nexttrackindex();
  }

  scripts\engine\utility::flag_wait("trial_in_progress");

  foreach(var2 in var0) {
    if(isDefined(var2)) {
      playFXOnTag(level.ref_11c15, var2, "j_bomb");
    }
  }
}

function ninetypercent_music() {
  self endon("mine_neutralized");

  for(;;) {
    var0 = distance2d(self.origin, level.player.origin);
    var1 = abs(self.origin[2] - level.player.origin[2]);

    if(var0 < 140 && var1 < 50) {
      break;
    }

    waitframe();
  }

  var2 = self.origin + (0, 0, 55);
  var3 = 1;
  var4 = magicgrenademanual("at_mine_ap_mp", var2, (0, 0, 0), var3);
  killfxontag(level.ref_11c15, self, "j_bomb");
  playFXOnTag(level.ref_11c14, self, "tag_origin");
  self moveTo(var2, var3 / 2, 0, var3 / 3);
  self rotateby((0, 1080, 0), var3);
  self playsoundonmovingent("mine_betty_click");
  wait var3;

  if(level.player getstance() != "prone") {
    var5 = 140 * level.player.maxhealth / 100;
    var6 = 70 * level.player.maxhealth / 100;
    var7 = 175;
    radiusdamage(var2, var7, var5, var6, self, "MOD_GRENADE_SPLASH");
  }

  playFX(level.ref_11c13, var2);
  level.player playRumbleOnEntity("damage_heavy");
  self notify("mine_explosion");
  self setModel("tag_origin");
  wait 1;
  self delete();
}

function nexttrackindex() {
  self endon("mine_explosion");
  self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
  level.player scripts\mp\damagefeedback::updatedamagefeedback("standard");
  killfxontag(level.ref_11c15, self, "j_bomb");
  playFX(level.ref_11c12, self.origin);
  self playsoundonmovingent("mp_equip_destroyed");
  self notify("mine_neutralized");
  waitframe();
  self delete();
}

function hud_init() {
  level.score = [];
  _tablethide::trial_ui_set_reward_tier(game["trial"]["best_reward"]);
  thread hud_besttime_update();
  thread hud_objectives();
  thread hud_timer();
  thread hud_reward_tiers_tracking();
  thread hud_attempt_over();

  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isalive(level.player)) {
    waitframe();
  }

  level.player setclientomnvar("ui_match_in_progress", 1);
}

function hud_objectives() {
  while(!isDefined(level.ref_1453b)) {
    waitframe();
  }

  _tablethide::trial_ui_set_objective_icon_index(0);
  _tablethide::trial_ui_set_objective_progress(level.ref_1453f, level.ref_1453b.size);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "floor_time", 0, 0);

  while(!isDefined(level.player)) {
    wait 0.05;
  }

  _tablethide::trial_ui_set_objective_progress(level.ref_1453f, level.ref_1453b.size);
  scripts\engine\utility::flag_wait("trial_prestart");

  while(level.ref_1453f < level.ref_1453b.size) {
    spawn_soldiers_in_convoy_truck();
    wait 0.05;
  }

  spawn_soldiers_in_convoy_truck();
  level notify("stop_timer");
  level scripts\engine\utility::flag_set("trial_completed");
  level notify("course_ended");
}

function spawn_soldiers_in_convoy_truck() {
  _tablethide::trial_ui_set_objective_progress(level.ref_1453f, level.ref_1453b.size);
  var0 = scripts\mp\utility\script::limitdecimalplaces(level.ref_13b67 / 1000, 1);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "floor_time", level.ref_13b67, var0);
}

function spawn_spawners_multi() {
  _tablethide::trial_ui_set_main_time(level.totaltime);
  _tablethide::trial_ui_set_subtime(level.timeelapsed);
}

function hud_timer() {
  spawn_spawners_multi();
  level scripts\engine\utility::flag_wait("trial_in_progress");
  level.player playSound("trial_sfx_start");
  var0 = gettime();

  while(!scripts\engine\utility::flag("trial_completed")) {
    var1 = gettime() - var0;
    level.timeelapsed = int(var1);
    spawn_spawners_multi();
    wait 0.05;
  }

  if(!scripts\engine\utility::flag("trial_player_death")) {
    level.timeelapsed = scripts\engine\math::round_float(level.timeelapsed / 1000, 1, 0) * 1000;
    level.ref_13b67 = scripts\engine\math::round_float(level.ref_13b67 / 1000, 1, 0) * 1000;
    level.totaltime = level.timeelapsed + level.ref_13b67;
    spawn_spawners_multi();

    if(game["trial"]["best_time"] <= 0 || level.totaltime < game["trial"]["best_time"]) {
      game["trial"]["best_time"] = level.totaltime;
      hud_besttime_update();
      game["trial"]["analytics"]["best_floortime"] = level.ref_13b67;
    }
  } else {
    _tablethide::trial_ui_set_main_time(0);
    _tablethide::trial_ui_set_subtime(0);
    level.totaltime = -1;
  }

  if(istrue(level.ref_13d6c)) {
    level.score["total"] = level.totaltime;

    if(level.score["total"] < level.trial["tier1"]) {
      wait 4;
    }
  }

  level scripts\engine\utility::flag_set("trial_ready_for_endscreen");
}

function hud_reward_tiers_tracking() {
  self endon("stop_timer");
  _tablethide::trial_ui_set_reward_tier_preview(3);
  self waittill("trial_in_progress");
  var0 = [];
  var0[0] = undefined;
  GscBinSkip0(0x2e, 1, level.trial["tier1"]);
}

function hud_fade_to_black(var0, var1) {
  var2 = newhudelem();
  var2.x = 0;
  var2.y = 0;
  var2 setshader("black", 640, 480);
  var2.alignx = "left";
  var2.aligny = "top";
  var2.sort = 1;
  var2.horzalign = "fullscreen";
  var2.vertalign = "fullscreen";
  var2.foreground = 0;

  if(istrue(var1)) {
    var2.alpha = 1;
    var2 fadeovertime(var0);
    var2.alpha = 0;
    return;
  }

  var2.alpha = 0;
  var2 fadeovertime(var0);
  var2.alpha = 1;
}

function hud_attempt_over() {
  level scripts\engine\utility::flag_wait("trial_completed");
  setDvar("scr_death_scene_time", 1.75);

  while(!level.player isonground()) {
    wait 0.05;
  }

  level.player freezecontrols(1);

  while(level.totaltime == 0) {
    waitframe();
  }

  var0 = _tablethide::recentc4vehiclekillcount();

  if(!scripts\engine\utility::flag("trial_player_death")) {
    var1 = game["trial"]["best_reward"];

    if(var0 > var1) {
      game["trial"]["best_reward"] = var0;
      _tablethide::trial_ui_set_reward_tier(var0);
      var2 = game["music"]["trials_win_high"].size;
      var3 = randomint(var2);
      level.player clearsoundsubmix("deaths_door_mp");
      level.player setplayermusicstate(game["music"]["trials_win_high"][var3]);
    }

    setomnvar("ui_trial_failed", 0);
  } else if(scripts\engine\utility::flag("trial_player_death")) {
    _tablethide::trial_ui_set_reward_tier_preview(0);
    level.player playSound("trial_sfx_failure");
    setomnvar("ui_trial_failed", 1);
    var2 = game["music"]["trials_loss"].size;
    var3 = randomint(var2);
    level.player clearsoundsubmix("deaths_door_mp");
    level.player setplayermusicstate(game["music"]["trials_loss"][var3]);
    var4 = 1.25;
    thread hud_fade_to_black(var4);
    wait var4;
  }

  setomnvar("allow_server_pause", 1);
  setomnvarforallclients("post_game_state", 0);
  level scripts\engine\utility::flag_wait("trial_ready_for_endscreen");
  var5 = scripts\mp\utility\script::limitdecimalplaces(level.ref_13b67 / 1000, 1);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "floor_time", level.ref_13b67, var5);
  _tablethide::trial_ui_set_stat_and_bonus_time(1, "floor_time", level.ref_13b67, level.ref_13b67);
  thread _tablethide::trial_ui_open_results_screen();
  level.player freezecontrols(1);
  level.ref_13d60 = 1;
  _tablethide::trial_ui_waittill_retry();
  level.player freezecontrols(1);
  level.player freezelookcontrols(1);
  var6 = game["trial"]["tries_remaining"];

  if(var6 > 0) {
    setDvar("t_clr_isretry", "true");
    level notify("game_cleanup");
    level notify("restarting");
    level notify("trial_retry");
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

function dialog_init() {
  game["dialog"]["trial_intro"] = "mp_petrograd_intro";
  game["dialog"]["trial_intro_short"] = "mp_petrograd_intro_short";
  game["dialog"]["trial_end_tier_0"] = "mp_petrograd_end_0star";
  game["dialog"]["trial_end_tier_0_alt"] = "mp_petrograd_obj_fail";
  game["dialog"]["trial_end_tier_1"] = "mp_petrograd_end_1star";
  game["dialog"]["trial_end_tier_2"] = "mp_petrograd_end_2star";
  game["dialog"]["trial_end_tier_3"] = "mp_petrograd_end_3star";
  game["dialog"]["trial_retry"] = "mp_petrograd_vo_retry";
  game["dialog"]["fil_start"] = "mp_petrograd_obj_nag_start";
  game["dialog"]["fil_hurry_up"] = "mp_petrograd_obj_nag_hurry";
  game["dialog"]["fil_shield_raise"] = "mp_petrograd_obj_shield";
  game["dialog"]["fil_shield_stow"] = "mp_petrograd_vo_clue";
  game["dialog"]["fil_wait_enemy_reload"] = "mp_petrograd_vo_clue2";
  game["dialog"]["fil_climb_back_up"] = "mp_petrograd_obj_nag_ingas";
  scripts\engine\utility::flag_wait("trial_in_progress");
  wait 0.8;
  level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_start");
  thread lgsplittransients();
  thread lgvadaptive();
  thread lgvmergesufix();
  thread lgwperifvfx_explosions();
  thread lgnoshadow();
}

function lgsplittransients() {
  level endon("trial_completed");
  var0 = 0;
  var1 = 0;

  if(level.trial["variant"] == "free") {
    var2 = 14;
  } else {
    var2 = 8;
  }

  for(;;) {
    if(level.ref_1453f == var2) {
      var1++;
    } else {
      var1 = 0;
    }

    if(var1 > var2) {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_hurry_up");
      var1 = 0;
    }

    var2 = level.ref_1453f;
    wait 1;
  }
}

function lgvadaptive() {
  level endon("trial_completed");

  for(;;) {
    level waittill("enemy_shooting");
    wait 0.5;
    var0 = level.player getcurrentweapon();

    if(var0.basename != "iw8_me_riotshield_mp") {
      level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_shield_raise");
    }
  }
}

function lgvmergesufix() {
  level endon("trial_completed");

  if(istrue(level.ref_125ca)) {
    return;
  }

  for(;;) {
    level.player waittill("enemy_killed");
    light_switch();
  }
}

function light_switch() {
  level endon("enemy_shooting");
  wait 1.5;
  var0 = level.player getcurrentweapon();

  if(var0.basename == "iw8_me_riotshield_mp") {
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_shield_stow");
    return;
  }
}

function lgwperifvfx_explosions() {
  level endon("trial_completed");
  var0 = undefined;
  var1 = level.player getweaponslistall();

  foreach(var3 in var1) {
    if(var3.basename == "iw8_me_riotshield_mp") {
      var0 = var3;
    }
  }

  if(isDefined(var0)) {
    while(!scripts\engine\utility::flag("trial_completed")) {
      level.player waittill("shield_blocked");
      wait 0.3;
      var5 = level.player getcurrentweapon();

      if(var5.basename == "iw8_me_riotshield_mp") {
        level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_wait_enemy_reload");
        wait 41;
      }
    }

    return;
  }
}

function lgnoshadow() {
  level endon("trial_completed");

  while(!scripts\engine\utility::flag("trial_completed")) {
    level.player waittill("gas_warning_vo");
    level.player scripts\mp\utility\dialog::leaderdialogonplayer("fil_climb_back_up");
    wait 4;
  }
}

function build_vehicle_drop_off_list() {
  level.ref_13d32 = &ref_13d36;

  if(!isDefined(game["trial"]["analytics"])) {
    game["trial"]["analytics"] = [];
    game["trial"]["analytics"]["best_floortime"] = 0;
    return;
  }
}

function ref_13d36() {
  var0 = level.trial["missionID"];
  var1 = getomnvar("ui_trial_reward_tier");
  var2 = getomnvar("ui_trial_best_time");
  var3 = int(game["trial"]["analytics"]["best_floortime"]);
  level.player dlog_recordplayerevent("dlog_event_trial_complete_lava", ["id", var0, "tier", var1, "time", var2, "floortime", var3]);
}