/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\vehicles\vehicle_damage_mp.gsc
*****************************************************/

function ref_1340d(var0, var1, var2) {
  var3 = newclienthudelem(self);
  var3.x = 0;
  var3.y = 0;
  var3.alignx = "left";
  var3.aligny = "top";
  var3.sort = 1;
  var3.horzalign = "fullscreen";
  var3.vertalign = "fullscreen";
  var3.foreground = 1;

  if(isDefined(var0) && var0 > 0) {
    var3.alpha = 0;
  } else {
    var3.alpha = 1;
  }

  var3 setshader("black", 640, 480);

  if(isDefined(var0) && var0 > 0) {
    self notify("fadeDown_start");
    var3 fadeovertime(var0);
    var3.alpha = 1;
    wait var0;
    self notify("fadeDown_complete");
  }

  if(isDefined(var1) && var1 > 0) {
    wait var1;
  }

  self notify("fadeUp_start");

  if(!isDefined(var2)) {
    var2 = 0.5;
  }

  if(var2 > 0) {
    var3 fadeovertime(var2);
    var3.alpha = 0;
    wait var2;
  }

  self notify("fadeUp_complete");

  if(isDefined(var3)) {
    var3 destroy();
    return;
  }
}

function vehomn_updateomnvarsperframe() {
  scripts\cp\cp_modular_spawning::stop_all_groups();
  level.ambient_spawning_paused = 1;

  foreach(var1 in level.agentarray) {
    if(!istrue(var1.isactive)) {
      continue;
    }

    var1.nocorpse = 1;
    var1 dodamage(var1.health + 1000, var1.origin, undefined, undefined, "MOD_EXPLOSIVE", "iw8_la_rpapa7_mp_friendly");
  }

  level.ambient_spawning_paused = 0;
}

function regroup_blackscreen(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  var0 endon("disconnect");
  var0 disableweapons();
  var0 scripts\cp\utility::freezecontrolswrapper(1);
  var0 setclientomnvar("ui_hide_hud", 1);
  var4 = newclienthudelem(var0);
  var4.x = 0;
  var4.y = 0;
  var4 setshader("black", 640, 480);
  var4.alignx = "left";
  var4.aligny = "top";
  var4.sort = 1;
  var4.horzalign = "fullscreen";
  var4.vertalign = "fullscreen";
  var4.alpha = 1;
  var4.foreground = 1;
  level waittill(var1);
  thread ref_1333e(var0);
  level waittill(var3);
  var0 setclientomnvar("ui_chyron_on", 0);
  var0 setclientomnvar("ui_hide_hud", 0);
  var0 scripts\cp\utility::freezecontrolswrapper(0);
  var0 enableweapons();
  var4 fadeovertime(2);
  var4.alpha = 0.5;
  wait 2;
  var4 destroy();
}

function ref_13bc2(var0) {
  if(istrue(var0)) {
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

  level notify("toggle_safehouse_settings", var0);

  if(var0) {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
    level.ref_127f6 = &ref_127f6;
  } else {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
    level.ref_127f6 = undefined;
  }

  foreach(var2 in level.players) {
    ref_13bbe(var2, var0);
  }
}

function ref_13bbe(var0) {
  var1 = self;

  if(var0) {
    var1 setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
    thread ref_142b1();
    var1 disableweaponswitch();
    var1 disableoffhandweapons();
    var1 allowmelee(0);
    var1 allowsupersprint(0);
    var1 allowsprint(0);
    var1 allowads(0);
    var1 allowcrouch(0);
    var1 allowprone(0);
    var1 allowmantle(0);
    var1 allowjump(0);
    var1 setclientomnvar("ui_briefing", 1);
    var1.brjuggernautcratedestroycallback = 0;
    var1.ignoreme = 1;
    return;
  }

  var1 notify("normal_demeanor");
  var1 setdemeanorviewmodel("normal");
  var1 enableweaponswitch();
  var1 enableoffhandweapons();
  var1 allowmelee(1);
  var1 allowsupersprint(1);
  var1 allowsprint(1);
  var1 allowads(1);
  var1 allowcrouch(1);
  var1 allowprone(1);
  var1 allowmantle(1);
  var1 allowjump(1);
  var1 setclientomnvar("ui_briefing", 0);
  var1.brjuggernautcratedestroycallback = 1;
  var1.ignoreme = 0;
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

function molotov_get_pool_level_data(var0) {
  level endon("game_ended");
  var1 = spawn("script_model", var0.origin);
  var1 setModel("tag_origin");
  var1 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/DWN_TWN_LOADOUT", 25, "duration_short", "hide", 256, 65, 64, 65);
  var1.headicon = deleteheadicon(var1);
  setheadiconfriendlyimage(var1.headicon, "hud_icon_survival_weapon");
  setheadicondrawthroughgeo(var1.headicon, 0);
  setheadiconsnaptoedges(var1.headicon, 1024);
  setheadiconmaxdistance(var1.headicon, 30);
  addclienttoheadiconmask(var1.headicon, 10);

  for(;;) {
    var1 waittill("trigger", var2);

    if(!var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
      continue;
    }

    thread edit_loadout(var2);
  }
}

function edit_loadout(var0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  thread ref_11952(level, self);
  var0 disableplayeruse(self);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::ref_143a5("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  var0 enableplayeruse(self);
}

function ref_11952(var0, var1) {
  level endon("game_ended");
  var0 endon("death_or_disconnect");
  var0 endon("loadout_menu_closed");
  var0 waittill("last_stand_start");
  thread ref_124e0(level, var0);
  var0 setclientomnvar("cp_open_cac", -2);
  var0 clearsoundsubmix("cp_store_duck", 1);
}

function ref_124e0(var0, var1) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("revive");
  var0 waittill("respawn_player");

  if(isDefined(var1) && isPlayer(var0)) {
    var1 enableplayeruse(var0);
    return;
  }
}

function mission_select_think(var0) {
  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self makeunusable();
    scripts\cp\cp_dialogue::stop_current_dialogue();
    thread run_mission(var0);
    level notify("mission_selected", var0);
    self.used = 1;
    return;
  }
}

function run_mission(var0) {
  scripts\engine\utility::delaythread(2, &scripts\cp\cp_objectives::run_objective, var0, "primary");
}

function ref_12e5a(var0) {
  foreach(var2 in level.players) {
    var3 = 0;

    if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
      var3 = 1;
    }

    thread ref_124ce(var2, var0, var4);
  }
}

function ref_124ce(var0, var1, var2) {
  self endon("disconnect");
  var0[var1].angles = scripts\engine\utility::ter_op(isDefined(var0[var1].angles), var0[var1].angles, (0, 0, 0));
  self.respawn_forcespawnorigin = var0[var1].origin;
  self.respawn_forcespawnangles = var0[var1].angles;

  if(istrue(var2)) {
    scripts\cp\cp_laststand::instant_revive(self);
  }

  if(isDefined(self.currentturret)) {
    self.currentturret notify("kill_turret", 0, 0);
  }

  if(isDefined(level.choppergunners)) {
    foreach(var4 in level.choppergunners) {
      var4 scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
    }
  }

  if(isDefined(self.helperdrone)) {
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode(0);
  }

  if(istrue(self isonladder())) {
    self setOrigin(getgroundposition(self.origin + anglesToForward(self.angles) * -50, 16));
    wait 0.1;
  }

  var6 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var6)) {
    var7 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var6, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(var6, var7, self, undefined, 1);
  }

  self setOrigin(var0[var1].origin);
  self setplayerangles(var0[var1].angles);
}

function ref_11f27(var0) {
  var1 = 0;

  if(isDefined(var0)) {
    foreach(var3 in level.players) {
      if(var3 istouching(var0)) {
        var1++;
      }
    }
  }

  return var1;
}

function ref_12e58(var0, var1) {
  var2 = 0;
  var3 = 0;

  while(var2 < 31) {
    var4 = ref_11f27(var0);
    var5 = raid_seq3_objectives_func();

    if(var4 && var5.size == 0) {
      level notify("player_entered_safehouse_vol");

      if(var4 == level.players.size) {
        if(!var3) {
          thread scripts\cp\utility::objective_update("safehouse_return_timer", 6, undefined, undefined, 1, undefined, 1, 1);
          var3 = 1;
          var2 = int(max(var2, 25));
        }
      } else if(!var3) {
        thread scripts\cp\utility::objective_update("safehouse_return_timer", 30, 20, 10, 1, undefined, 1, 1);
        var3 = 1;
      }

      var2++;
    } else {
      if(var3) {
        scripts\cp\cp_objectives::lua_objective_complete("safehouse_return_timer");
        thread scripts\cp\utility::objective_update("safehouse_return");
        var3 = 0;
      }

      var2 = 0;
    }

    wait 1;
  }

  if(isDefined(var1) && scripts\engine\utility::flag_exist(var1)) {
    scripts\engine\utility::flag_set(var1);
    return;
  }
}

function raid_seq3_objectives_func() {
  var0 = [];

  foreach(var2 in level.players) {
    if(istrue(var2.ref_12982) || istrue(var2 isparachuting()) || istrue(var2 isskydiving()) || istrue(self.isreviving) || istrue(self.beingrevived)) {
      var0 = var2;
    }
  }

  return var0;
}

function ref_12e56(var0) {
  foreach(var2 in var0) {
    var2 thread scripts\cp\utility::create_fake_loot();
  }
}

function ref_13bc1(var0, var1, var2, var3, var4) {
  var5 = getentitylessscriptablearrayinradius("scriptable_" + var3, var4, var1, var2);

  foreach(var7 in var5) {
    if(var7 scriptableisdoor()) {
      if(var0) {
        var8 = 0;
        var7 vehicle_getinputvalue();

        while(!var7 scriptabledoorisclosed() && var8 < 10) {
          wait 0.1;
          var8++;
        }

        var7 scriptabledoorfreeze(1);
        continue;
      }

      var7 scriptabledoorfreeze(0);
    }
  }
}

function ref_14325(var0, var1, var2, var3) {
  var4 = getentitylessscriptablearrayinradius("scriptable_" + var2, var3, var0, var1);

  foreach(var6 in var4) {
    if(var6 scriptableisdoor()) {
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

function ref_12409(var0) {
  var1 = [];
  var2 = [];
  var1 = "dx_cps_kama_convo_start_10";
  var1 = "dx_cps_kama_convo_start_20";
  var1 = "dx_cps_kama_convo_start_30";
  GscBinSkip0(0x2e, var2.size, "dx_cps_lass_convo_start_10");
}

function ref_12408(var0, var1) {
  var2 = scripts\cp\utility::getplayersinteam("allies");
  var3 = [];

  foreach(var5 in var2) {
    if(var5 scripts\cp_mp\utility\player_utility::_isalive()) {
      var3 = var5;
    }
  }

  var7 = scripts\engine\utility::random(var3);

  if(isDefined(var0)) {
    var7 = var0;
  }

  var8 = level scripts\cp\cp_player_battlechatter::trysaylocalsound(var7, var1);

  if(isfloat(var8)) {
    wait var8;
  }

  wait 0.4 + randomfloat(0.4);
}

function ref_12e57() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var0);

    if(istrue(level.ref_13666)) {
      thread ref_12e5b();
    }
  }
}

function ref_12e5b() {
  self endon("disconnect");
  var0 = self;
  var1 = 0;

  for(;;) {
    if(isDefined(level.initlocs_bunkertest)) {
      foreach(var3 in level.initlocs_bunkertest) {
        if(!scripts\cp\utility::any_player_nearby(var3.origin, 64)) {
          if(!isDefined(var3.angles)) {
            var3.angles = (0, 0, 0);
          }

          var0.respawn_forcespawnorigin = var3.origin;
          var0.respawn_forcespawnangles = var3.angles;
          var0 setOrigin(var3.origin);
          var0 setplayerangles(var3.angles);
          var0 dontinterpolate();
          ref_13bbe(var0, 1);
          var1 = 1;
        }
      }
    }

    if(var1) {
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

  var0 = self getcurrentprimaryweapon();
  self setspawnweapon(var0, 1);

  if(istrue(level.ref_13666)) {
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
    ref_13bbe(1);
    self.ref_124c8 = 1;
    return;
  }
}

function ref_1333e(var0) {
  var1 = getDvar("NSQLTTMRMP");
  var2 = "cp/" + var1 + "_objectives.csv";
  var3 = int(tablelookup(var2, 1, var0, 0));
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_chyron_mission_index", var3);
  self setclientomnvar("ui_chyron_on", 1);
  wait 5;
  level notify("regroup_text_done");
}