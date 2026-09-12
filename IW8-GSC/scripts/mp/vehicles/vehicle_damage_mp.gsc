/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_damage_mp.gsc
*****************************************************/

function ref_1340d(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.x = 0;
  var_3.y = 0;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.foreground = 1;

  if(isDefined(var_0) && var_0 > 0) {
    var_3.alpha = 0;
  } else {
    var_3.alpha = 1;
  }

  var_3 setshader("black", 640, 480);

  if(isDefined(var_0) && var_0 > 0) {
    self notify("fadeDown_start");
    var_3 fadeovertime(var_0);
    var_3.alpha = 1;
    wait var_0;
    self notify("fadeDown_complete");
  }

  if(isDefined(var_1) && var_1 > 0) {
    wait var_1;
  }

  self notify("fadeUp_start");

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  if(var_2 > 0) {
    var_3 fadeovertime(var_2);
    var_3.alpha = 0;
    wait var_2;
  }

  self notify("fadeUp_complete");

  if(isDefined(var_3)) {
    var_3 destroy();
    return;
  }
}

function vehomn_updateomnvarsperframe() {
  scripts\cp\cp_modular_spawning::stop_all_groups();
  level.ambient_spawning_paused = 1;

  foreach(var_1 in level.agentarray) {
    if(!istrue(var_1.isactive)) {
      continue;
    }

    var_1.nocorpse = 1;
    var_1 dodamage(var_1.health + 1000, var_1.origin, undefined, undefined, "MOD_EXPLOSIVE", "iw8_la_rpapa7_mp_friendly");
  }

  level.ambient_spawning_paused = 0;
}

function regroup_blackscreen(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("disconnect");
  var_0 disableweapons();
  var_0 scripts\cp\utility::freezecontrolswrapper(1);
  var_0 setclientomnvar("ui_hide_hud", 1);
  var_4 = newclienthudelem(var_0);
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader("black", 640, 480);
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = 1;
  var_4.foreground = 1;
  level waittill(var_1);
  thread ref_1333e(var_0);
  level waittill(var_3);
  var_0 setclientomnvar("ui_chyron_on", 0);
  var_0 setclientomnvar("ui_hide_hud", 0);
  var_0 scripts\cp\utility::freezecontrolswrapper(0);
  var_0 enableweapons();
  var_4 fadeovertime(2);
  var_4.alpha = 0.5;
  wait 2;
  var_4 destroy();
}

function ref_13bc2(var_0) {
  if(istrue(var_0)) {
    level.disable_hotjoin_via_ac130 = 1;
    level.dogtag_revive = 1;
    level.disable_munitions = 1;
    level.ref_13666 = 1;
  } else {
    if(!istrue(level.ref_12b73)) {
      level.disable_hotjoin_via_ac130 = 0;
      level.dogtag_revive = 0;
    }

    level.disable_munitions = 0;
    level.ref_13666 = 0;
  }

  level notify("toggle_safehouse_settings", var_0);

  if(var_0) {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
    level.ref_127f6 = &ref_127f6;
  } else {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
    level.ref_127f6 = undefined;
  }

  foreach(var_2 in level.players) {
    ref_13bbe(var_2, var_0);
  }
}

function ref_13bbe(var_0) {
  var_1 = self;

  if(var_0) {
    var_1 setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
    thread ref_142b1();
    var_1 disableweaponswitch();
    var_1 disableoffhandweapons();
    var_1 allowmelee(0);
    var_1 allowsupersprint(0);
    var_1 allowsprint(0);
    var_1 allowads(0);
    var_1 allowcrouch(0);
    var_1 allowprone(0);
    var_1 allowmantle(0);
    var_1 allowjump(0);
    var_1 setclientomnvar("ui_briefing", 1);
    var_1.brjuggernautcratedestroycallback = 0;
    var_1.ignoreme = 1;
    return;
  }

  var_1 notify("normal_demeanor");
  var_1 setdemeanorviewmodel("normal");
  var_1 enableweaponswitch();
  var_1 enableoffhandweapons();
  var_1 allowmelee(1);
  var_1 allowsupersprint(1);
  var_1 allowsprint(1);
  var_1 allowads(1);
  var_1 allowcrouch(1);
  var_1 allowprone(1);
  var_1 allowmantle(1);
  var_1 allowjump(1);
  var_1 setclientomnvar("ui_briefing", 0);
  var_1.brjuggernautcratedestroycallback = 1;
  var_1.ignoreme = 0;
}

function ref_142b1() {
  self endon("normal_demeanor");
  self notify("viewmodel_demeanor");
  self endon("viewmodel_demeanor");

  for(;;) {
    self waittill("loadout_given");
    wait 2;

    if(istrue(self.brjuggernautcratedestroycallback)) {
      self setdemeanorviewmodel("normal");
      continue;
    }

    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
  }
}

function molotov_get_pool_level_data(var_0) {
  level endon("game_ended");
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("tag_origin");
  var_1 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/DWN_TWN_LOADOUT", 25, "duration_short", "hide", 256, 65, 64, 65);
  var_1.headicon = deleteheadicon(var_1);
  setheadiconfriendlyimage(var_1.headicon, "hud_icon_survival_weapon");
  setheadicondrawthroughgeo(var_1.headicon, 0);
  setheadiconsnaptoedges(var_1.headicon, 1024);
  setheadiconmaxdistance(var_1.headicon, 30);
  addclienttoheadiconmask(var_1.headicon, 10);

  for(;;) {
    var_1 waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    thread edit_loadout(var_2);
  }
}

function edit_loadout(var_0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  thread ref_11952(level, self);
  var_0 disableplayeruse(self);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::ref_143a5("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  var_0 enableplayeruse(self);
}

function ref_11952(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  var_0 endon("loadout_menu_closed");
  var_0 waittill("last_stand_start");
  thread ref_124e0(level, var_0);
  var_0 setclientomnvar("cp_open_cac", -2);
  var_0 clearsoundsubmix("cp_store_duck", 1);
}

function ref_124e0(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("revive");
  var_0 waittill("respawn_player");

  if(isDefined(var_1) && isPlayer(var_0)) {
    var_1 enableplayeruse(var_0);
    return;
  }
}

function mission_select_think(var_0) {
  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    scripts\cp\cp_dialogue::stop_current_dialogue();
    thread run_mission(var_0);
    level notify("mission_selected", var_0);
    self.used = 1;
    return;
  }
}

function run_mission(var_0) {
  scripts\engine\utility::delaythread(2, &scripts\cp\cp_objectives::run_objective, var_0, "primary");
}

function ref_12e5a(var_0) {
  foreach(var_2 in level.players) {
    var_3 = 0;

    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      var_3 = 1;
    }

    thread ref_124ce(var_2, var_0, var_4);
  }
}

function ref_124ce(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0[var_1].angles = scripts\engine\utility::ter_op(isDefined(var_0[var_1].angles), var_0[var_1].angles, (0, 0, 0));
  self.respawn_forcespawnorigin = var_0[var_1].origin;
  self.respawn_forcespawnangles = var_0[var_1].angles;

  if(istrue(var_2)) {
    scripts\cp\cp_laststand::instant_revive(self);
  }

  if(isDefined(self.currentturret)) {
    self.currentturret notify("kill_turret", 0, 0);
  }

  if(isDefined(level.choppergunners)) {
    foreach(var_4 in level.choppergunners) {
      var_4 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
    }
  }

  if(isDefined(self.helperdrone)) {
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);
  }

  if(istrue(self isonladder())) {
    self setOrigin(getgroundposition(self.origin + anglesToForward(self.angles) * -50, 16));
    wait 0.1;
  }

  var_6 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_6)) {
    var_7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_6, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var_6, var_7, self, undefined, 1);
  }

  self setOrigin(var_0[var_1].origin);
  self setplayerangles(var_0[var_1].angles);
}

function ref_11f27(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(var_0)) {
        var_1++;
      }
    }
  }

  return var_1;
}

function ref_12e58(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  while(var_2 < 31) {
    var_4 = ref_11f27(var_0);
    var_5 = raid_seq3_objectives_func();

    if(var_4 && var_5.size == 0) {
      level notify("player_entered_safehouse_vol");

      if(var_4 == level.players.size) {
        if(!var_3) {
          thread scripts\cp\utility::objective_update("safehouse_return_timer", 6, undefined, undefined, 1, undefined, 1, 1);
          var_3 = 1;
          var_2 = int(max(var_2, 25));
        }
      } else if(!var_3) {
        thread scripts\cp\utility::objective_update("safehouse_return_timer", 30, 20, 10, 1, undefined, 1, 1);
        var_3 = 1;
      }

      var_2++;
    } else {
      if(var_3) {
        scripts\cp\cp_objectives::lua_objective_complete("safehouse_return_timer");
        thread scripts\cp\utility::objective_update("safehouse_return");
        var_3 = 0;
      }

      var_2 = 0;
    }

    wait 1;
  }

  if(isDefined(var_1) && scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_set(var_1);
    return;
  }
}

function raid_seq3_objectives_func() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(istrue(var_2.ref_12982) || istrue(var_2 isparachuting()) || istrue(var_2 isskydiving()) || istrue(self.isreviving) || istrue(self.beingrevived)) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function ref_12e56(var_0) {
  foreach(var_2 in var_0) {
    var_2 thread scripts\cp\utility::create_fake_loot();
  }
}

function ref_13bc1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getentitylessscriptablearrayinradius("scriptable_" + var_3, var_4, var_1, var_2);

  foreach(var_7 in var_5) {
    if(var_7 scriptableisdoor()) {
      if(var_0) {
        var_8 = 0;
        var_7 vehicle_getinputvalue();

        while(!var_7 scriptabledoorisclosed() && var_8 < 10) {
          wait 0.1;
          var_8++;
        }

        var_7 scriptabledoorfreeze(1);
        continue;
      }

      var_7 scriptabledoorfreeze(0);
    }
  }
}

function ref_14325(var_0, var_1, var_2, var_3) {
  var_4 = getentitylessscriptablearrayinradius("scriptable_" + var_2, var_3, var_0, var_1);

  foreach(var_6 in var_4) {
    if(var_6 scriptableisdoor()) {
      thread ref_14330();
    }
  }
}

function ref_14330() {
  while(self scriptabledoorisclosed()) {
    wait 1;
  }

  level notify("safehouse_door_opened");
}

function ref_12409(var_0) {
  var_1 = [];
  var_2 = [];
  var_1 = "dx_cps_kama_convo_start_10";
  var_1 = "dx_cps_kama_convo_start_20";
  var_1 = "dx_cps_kama_convo_start_30";
  GscBinSkip0(0x2e, var_2.size, "dx_cps_lass_convo_start_10");
}

function ref_12408(var_0, var_1) {
  var_2 = scripts\cp\utility::getplayersinteam("allies");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_3 = var_5;
    }
  }

  var_7 = scripts\engine\utility::random(var_3);

  if(isDefined(var_0)) {
    var_7 = var_0;
  }

  var_8 = level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_7, var_1);

  if(isfloat(var_8)) {
    wait var_8;
  }

  wait 0.4 + randomfloat(0.4);
}

function ref_12e57() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(istrue(level.ref_13666)) {
      thread ref_12e5b();
    }
  }
}

function ref_12e5b() {
  self endon("disconnect");
  var_0 = self;
  var_1 = 0;

  for(;;) {
    if(isDefined(level.initlocs_bunkertest)) {
      foreach(var_3 in level.initlocs_bunkertest) {
        if(!scripts\cp\utility::any_player_nearby(var_3.origin, 64)) {
          if(!isDefined(var_3.angles)) {
            var_3.angles = (0, 0, 0);
          }

          var_0.respawn_forcespawnorigin = var_3.origin;
          var_0.respawn_forcespawnangles = var_3.angles;
          var_0 setOrigin(var_3.origin);
          var_0 setplayerangles(var_3.angles);
          var_0 dontinterpolate();
          ref_13bbe(var_0, 1);
          var_1 = 1;
        }
      }
    }

    if(var_1) {
      return;
    }

    wait 0.05;
  }
}

function ref_127f6() {
  self endon("disconnect");
  level endon("game_ended");

  while(nullweapon(self getcurrentprimaryweapon())) {
    wait 0.05;
  }

  var_0 = self getcurrentprimaryweapon();
  self setspawnweapon(var_0, 1);

  if(istrue(level.ref_13666)) {
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
    ref_13bbe(1);
    self.ref_124c8 = 1;
    return;
  }
}

function ref_1333e(var_0) {
  var_1 = getDvar("ui_mapname");
  var_2 = "cp/" + var_1 + "_objectives.csv";
  var_3 = int(tablelookup(var_2, 1, var_0, 0));
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_chyron_mission_index", var_3);
  self setclientomnvar("ui_chyron_on", 1);
  wait 5;
  level notify("regroup_text_done");
}