/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_ball.gsc
***********************************************/

function ball_default_origins() {
  level.default_goal_origins = [];
  level.flags = getEntArray("flag_primary", "targetname");

  foreach(var_1 in level.flags) {
    switch (var_1.script_label) {
      case "_a":
        level.default_goal_origins[game["attackers"]] = var_1.origin;
        break;
      case "_b":
        level.default_ball_origin = var_1.origin;
        break;
      case "_c":
        level.default_goal_origins[game["defenders"]] = var_1.origin;
        break;
    }
  }
}

function ball_init_map_min_max() {
  level.ball_mins = (1000, 1000, 1000);
  level.ball_maxs = (-1000, -1000, -1000);
  var_0 = getallnodes();

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      level.ball_mins = scripts\mp\spawnlogic::expandmins(level.ball_mins, var_2.origin);
      level.ball_maxs = scripts\mp\spawnlogic::expandmaxs(level.ball_maxs, var_2.origin);
    }

    return;
  }

  level.ball_mins = level.spawnmins;
  level.ball_maxs = level.spawnmaxs;
}

function ball_create_ball_starts() {
  if(!isDefined(level.devball)) {
    level.devball = 0;
  }

  var_0 = getballstarts();
  level.ball_triggers = getballtriggers();
  checkpostshipballspawns(var_0);
  jumpiffalse(var_0.size > 1 && level.satellitecount > 1) LOC_00000064;

  for(var_1 = 0; var_1 < level.satellitecount; var_1++) {
    var_2 = getballorigin(var_0[var_1]);
    ball_add_start(var_2);
  }

  goto LOC_000000ea;
}

function checkpostshipballspawns(var_0) {
  if(level.mapname == "mp_divide") {
    var_0[0].origin = (-261, 235, 610);
    var_0[1].origin = (-211, 235, 610);
    var_0[2].origin = (-311, 235, 610);
    var_0[3].origin = (-311, 500, 610);
    var_0[4].origin = (-211, 500, 610);
    return;
  }
}

function getballstarts() {
  var_0 = undefined;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var_0 = scripts\engine\utility::getStructArray("tdef_ball_start", "targetname");
  }

  if(!isDefined(var_0) || !var_0.size) {
    var_0 = scripts\engine\utility::getStructArray("ball_start", "targetname");
  }

  if(level.satellitecount > 1) {
    var_0 = sortballarray(var_0);
  }

  return var_0;
}

function getballtriggers() {
  var_0 = undefined;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var_0 = getEntArray("tdef_ball_pickup", "targetname");
  }

  if(!isDefined(var_0) || !var_0.size) {
    var_0 = getEntArray("ball_pickup", "targetname");
  }

  if(level.satellitecount > 1) {
    var_0 = sortballarray(var_0);
  }

  return var_0;
}

function getballorigin(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0.origin;
  } else if(level.devball) {
    var_1 = level.players[0].origin + (0, 0, 30);
  } else {
    var_1 = level.default_ball_origin;
  }

  return var_1;
}

function ball_add_start(var_0) {
  var_1 = 30;
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_3 = var_0;
  ball_find_ground(var_2);
  var_2.origin = var_2.ground_origin + (0, 0, var_1);
  var_2.in_use = 0;

  if(level.mapname == "mp_desert") {
    var_3 = var_2.ground_origin;
  }

  if(level.mapname == "mp_divide") {
    var_3 = var_2.ground_origin;
  }

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    level.ballbases[level.ballbases.size] = createballbase(var_3);
  }

  level.ball_starts[level.ball_starts.size] = var_2;
}

function ball_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\engine\trace::ray_trace(var_1, var_2, var_4, var_3);
  self.ground_origin = var_5["position"];
  return var_5["fraction"] != 0 && var_5["fraction"] != 1;
}

function createballbase(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("ctf_game_flag_base");
  var_1 setasgametypeobjective();
  var_1.baseeffectpos = var_0;
  return var_1;
}

function showballbaseeffecttoplayer(var_0) {
  if(isDefined(var_0._baseeffect[0])) {
    var_0._baseeffect[0] delete();
  }

  var_1 = undefined;
  var_2 = var_0.team;
  var_3 = var_0 ismlgspectator();

  if(var_3) {
    var_2 = var_0 getmlgspectatorteam();
  } else if(var_2 == "spectator") {
    var_2 = "allies";
  }

  var_4 = spawnfxforclient(level._effect["ball_base_glow"], self.baseeffectpos, var_0);
  var_4 setfxkilldefondelete();
  var_0._baseeffect[0] = var_4;
  triggerfx(var_4);
}

function ball_spawn(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(var_1)) {
    var_2 = spawn("script_model", var_1);
  } else {
    var_2 = level.ball_starts[level.balls.size];
  }

  var_3 = spawn("script_model", var_2.origin);
  var_3 setasgametypeobjective();

  if(scripts\mp\utility\game::getgametype() == "ball" || getdvarint("scr_uplink_create_ball") == 1) {
    var_3 setModel("offhand_wm_emp");
    var_3 setnonstick(1);
    level.ballweapon = getcompleteweaponname("iw7_uplinkball_mp");
    level.ballpassdist = 1000000;
  } else {
    var_3 setModel("offhand_wm_emp");
    var_3 setnonstick(1);
    level.ballweapon = getcompleteweaponname("iw7_tdefball_mp");
    level.ballpassdist = 250000;
  }

  var_4 = 32;
  var_5 = undefined;

  if(isDefined(level.ball_triggers) && level.ball_triggers.size > 0) {
    var_5 = level.ball_triggers[var_1];
    var_5.origin = var_3.origin;
  } else {
    var_5 = spawn("trigger_radius", var_3.origin - (0, 0, var_4 / 2), 0, var_4, var_4);
  }

  var_5 enablelinkTo();
  var_5 linkTo(var_3);
  var_5.no_moving_platfrom_unlink = 1;
  var_5.linktoenabledflag = 1;
  var_5.baseorigin = var_5.origin;
  var_5.no_moving_platfrom_unlink = 1;
  var_6 = [var_3];
  var_7 = scripts\mp\gameobjects::createcarryobject("any", var_5, var_6, (0, 0, 32));
  var_7.objectiveonvisuals = 1;
  var_7 scripts\mp\gameobjects::allowcarry("any");
  ball_waypoint_neutral(var_7);
  var_7.allowweapons = 0;
  var_7.carryweapon = level.ballweapon;
  var_7.keepcarryweapon = 0;
  var_7.visualgroundoffset = (0, 0, 30);
  var_7.canuseobject = &ball_can_pickup;
  var_7.onpickup = &ball_on_pickup;
  var_7.setdropped = &ball_set_dropped;
  var_7.onreset = &ball_on_reset;
  var_7.carryweaponthink = &ball_pass_or_shoot;
  var_7.in_goal = 0;
  var_7.lastcarrierscored = 0;
  var_7.pass = 0;
  var_7.requireslos = 1;
  var_7.lastcarrierteam = "none";
  var_7.ballindex = level.balls.size;
  var_7.playeroutlineid = undefined;
  var_7.playeroutlined = undefined;
  var_7.passtargetoutlineid = undefined;
  var_7.passtargetent = undefined;
  var_7.visuals[0] fixlinktointerpolationbug(1);

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var_7 scripts\mp\gameobjects::setvisibleteam("friendly");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 60;
        break;
      case 1:
        var_7 scripts\mp\gameobjects::setvisibleteam("any");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 0;
        var_7.objpingdelay = 0.05;
        break;
      case 2:
        var_7 scripts\mp\gameobjects::setvisibleteam("any");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 1;
        break;
      case 3:
        var_7 scripts\mp\gameobjects::setvisibleteam("any");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 1.5;
        break;
      case 4:
        var_7 scripts\mp\gameobjects::setvisibleteam("any");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 2;
        break;
      case 5:
        var_7 scripts\mp\gameobjects::setvisibleteam("any");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 3;
        break;
      case 6:
        var_7 scripts\mp\gameobjects::setvisibleteam("any");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 4;
        break;
    }
  } else {
    var_7 scripts\mp\gameobjects::setvisibleteam("any");
    var_7.objidpingfriendly = 0;
    var_7.objidpingenemy = 1;
    var_7.objpingdelay = 3;
  }

  ball_assign_start(var_7, var_2);
  level.balls[level.balls.size] = var_7;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    thread starthoveranim();
  }

  if(!istrue(level.devball)) {
    thread ball_fx_start(var_7, 1);
  }

  thread ball_location_hud();
  var_8 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var_9 = physics_createcontents(var_8);
  level.ballphysicscontentoverride = var_9;
  level.balltraceradius = 10;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    level.balltraceradius = 20;
    return;
  }
}

function ball_can_pickup(var_0) {
  if(isDefined(self.droptime) && self.droptime >= gettime()) {
    return false;
  }

  if(isPlayer(var_0)) {
    if(!var_0 scripts\common\utility::is_weapon_allowed()) {
      return false;
    }

    if(isDefined(var_0.manuallyjoiningkillstreak) && var_0.manuallyjoiningkillstreak) {
      return false;
    }

    if(istrue(var_0.iscarrying)) {
      return false;
    }

    if(!valid_ball_super_pickup(var_0)) {
      return false;
    }

    var_1 = var_0 getcurrentweapon();

    if(isDefined(var_1)) {
      if(!valid_ball_pickup_weapon(var_1)) {
        return false;
      }
    }

    var_2 = var_0.changingweapon;

    if(isDefined(var_2) && var_0 isswitchingweapon()) {
      if(!valid_ball_pickup_weapon(var_2)) {
        return false;
      }
    }

    if(var_0 scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
      var_2 = var_0 scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

      if(!valid_ball_pickup_weapon(var_2)) {
        return false;
      }
    }

    if(var_0 scripts\mp\utility\player::isusingremote()) {
      return false;
    }

    if(player_no_pickup_time(var_0)) {
      return false;
    }
  } else {
    return false;
  }

  return true;
}

function ball_on_pickup(var_0, var_1) {
  var_0 notify("obj_picked_up");
  thread checkgesturethread();
  var_2 = 0;

  if(level.ballreset) {
    if(givegrabscore(var_0)) {
      var_0 thread scripts\mp\utility\points::giveunifiedpoints("ball_grab");
    }

    level.ballpickupscorefrozen = gettime();
    level.ballreset = 0;

    if(isDefined(level.possessionresetcondition) && level.possessionresetcondition == 1 && istrue(level.possessionresettime)) {
      var_2 = 1;
    }

    var_0 notify("ball_grab");
  }

  if(isDefined(level.possessionresetcondition) && level.possessionresetcondition == 2 && istrue(level.possessionresettime) && isDefined(self.lastcarrier) && self.lastcarrier != var_0) {
    var_2 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    if(!level.timerstoppedforgamemode) {
      level scripts\mp\gamelogic::pausetimer();
    }
  }

  if(istrue(level.possessionresetcondition)) {
    updatetimers(level, var_0.team, 0, 0, var_2);
  }

  level.usestartspawns = 0;
  level.codcasterball = undefined;
  level.codcasterballinitialforcevector = undefined;
  var_3 = self.visuals[0] getlinkedparent();

  if(isDefined(var_3)) {
    self.visuals[0] unlink();
  }

  if(!istrue(level.devball)) {
    var_0 scripts\mp\utility\perk::giveperk("specialty_ballcarrier");
  }

  var_0.ball_carried = self;
  var_0.objective = 1;
  self.carrier scripts\mp\utility\perk::giveperk("specialty_sprintfire");
  self.carrier.hasperksprintfire = 1;

  if(!istrue(level.devball)) {
    var_0 scripts\mp\lightarmor::setlightarmorvalue(var_0, level.carrierarmor);
  }

  if(!istrue(level.devball)) {
    thread ball_play_local_team_sound(var_0.team, "mp_uplink_ball_pickedup_friendly", "mp_uplink_ball_pickedup_enemy");
  }

  var_0 scripts\common\utility::allow_usability(0);
  var_0 scripts\mp\equipment::allow_equipment(0, "obj_ball");
  self.visuals[0] physicslaunchserver(self.visuals[0].origin, (0, 0, 0));
  self.visuals[0] physicsstopserver();
  self.visuals[0] scripts\mp\movers::notify_moving_platform_invalid();
  self.pass = 0;
  stop_fx_idle(self.visuals[0]);
  self.visuals[0] show();
  self.visuals[0] hide(1);
  self.visuals[0] linkTo(var_0, "j_wrist_ri", (0, 0, 0), var_0.angles);
  self.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  self.current_start.in_use = 0;
  var_4 = 0;

  if(isDefined(self.projectile)) {
    var_4 = 1;
    self.projectile delete();
  }

  var_5 = var_0.team;
  var_6 = scripts\mp\utility\game::getotherteam(var_0.team)[0];
  self.visuals[0] setotherent(var_0);

  if(var_4) {
    if(self.lastcarrierteam == var_0.team) {
      if(!istrue(level.devball)) {
        scripts\mp\utility\dialog::statusdialog("pass_complete", var_5);
      }

      var_0.passtime = gettime();
      var_0.passplayer = self.lastcarrier;
    } else {
      if(!istrue(level.devball)) {
        scripts\mp\utility\dialog::statusdialog("pass_intercepted", var_5);
      }

      var_0 thread scripts\mp\awards::givemidmatchaward("mode_uplink_intercept");

      if(isPlayer(var_0)) {
        var_0 thread scripts\common\utility::ref_13E0A(level.ref_11B29, "pickup_interception", var_0.origin);
      }
    }
  } else {
    if(!istrue(level.devball) && self.lastcarrierteam != var_0.team) {
      scripts\mp\utility\dialog::statusdialog("ally_own_drone", var_5);
      scripts\mp\utility\dialog::statusdialog("enemy_own_drone", var_6);
    }

    if(isPlayer(var_0)) {
      var_0 thread scripts\common\utility::ref_13E0A(level.ref_11B29, "pickup", var_0.origin);
    }
  }

  if(!istrue(level.devball)) {
    ball_fx_stop();
  }

  self.lastcarrierscored = 0;
  self.lastcarrier = var_0;
  self.lastcarrierteam = var_0.team;
  self.ownerteam = var_0.team;
  ball_waypoint_held(self.ownerteam);
  var_0 setweaponammoclip(level.ballweapon, 1);

  if(level.codcasterenabled) {
    var_0 setgametypevip(1);
  }

  thread player_update_pass_target(var_0);

  if(!istrue(level.devball)) {
    scripts\mp\gamelogic::sethasdonecombat(var_0, 1);
  }

  self notify("physics_timeout");
}

function checkgesturethread() {
  self endon("death_or_disconnect");
  self endon("drop_object");
  waitframe();

  if(isDefined(self.gestureweapon) && self isgestureplaying(self.gestureweapon)) {
    self stopgestureviewmodel(self.gestureweapon, 0.05, 1);
    return;
  }
}

function detonateball() {}

function givegrabscore(var_0) {
  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var_1 = 15000;
  } else {
    var_1 = 10000;
  }

  var_2 = updatebpm(var_1);

  if(var_2) {
    return false;
  }

  if(isDefined(self.lastcarrier) && var_1.team == self.lastcarrier.team && gettime() < level.ballpickupscorefrozen + var_1) {
    return false;
  }

  return true;
}

function updatebpm() {
  if(!isDefined(self.bpm)) {
    self.numgrabs = 0;
    self.bpm = 0;
  }

  self.numgrabs++;

  if(scripts\mp\utility\game::getminutespassed() < 1) {
    return 0;
  }

  self.bpm = self.numgrabs / scripts\mp\utility\game::getminutespassed();

  if(self.bpm < 4) {
    return 0;
  }

  return 1;
}

function ball_play_local_team_sound(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\game::getotherteam(var_0)[0];

  foreach(var_5 in level.players) {
    if(var_5.team == var_0) {
      var_5 playlocalsound(var_1);
      continue;
    }

    if(var_5.team == var_3) {
      var_5 playlocalsound(var_2);
    }
  }
}

function ball_set_dropped(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_4 = 0;
  self.isresetting = 1;
  self.droptime = gettime();
  self notify("dropped");
  var_5 = (0, 0, 0);
  var_6 = self.carrier;

  if(isDefined(var_6) && var_6.team != "spectator") {
    var_7 = var_6.origin;
    var_5 = var_6.angles;
    var_6 notify("ball_dropped");
  } else if(isDefined(var_2)) {
    var_7 = var_2;
  } else {
    var_7 = self.safeorigin;
  }

  var_7 += (0, 0, 40);

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  for(var_8 = 0; var_8 < self.visuals.size; var_8++) {
    self.visuals[var_8].origin = var_7;
    self.visuals[var_8].angles = var_7;
    self.visuals[var_8] show();
    var_9 = self.visuals[var_8] getlinkedparent();

    if(isDefined(var_9)) {
      self.visuals[var_8] unlink();
    }

    self.visuals[var_8] setscriptablepartstate("uplink_drone_hide", "show", 0);
  }

  if(istrue(var_5) || istrue(var_4)) {
    var_6 = 1;
  }

  ball_carrier_cleanup(var_6);

  if(!isDefined(level.scorefrozenuntil)) {
    level.scorefrozenuntil = 0;
  }

  if(level.scorefrozenuntil > 0) {
    self.trigger.origin -= (0, 0, 10000);
  } else {
    self.trigger.origin = var_7;
  }

  ball_dont_interpolate();
  self.curorigin = self.trigger.origin;

  if(!istrue(level.devball)) {
    thread ball_fx_start(0);
  }

  self.ownerteam = "any";
  ball_waypoint_neutral();
  scripts\mp\gameobjects::clearcarrier();

  if(isDefined(var_7)) {
    player_update_pass_target_hudoutline(var_7);
  }

  scripts\mp\gameobjects::updatecompassicons();
  self.isresetting = 0;

  if(!var_2) {
    var_10 = self.lastcarrierteam;
    var_11 = scripts\mp\utility\game::getotherteam(var_10)[0];

    if(!istrue(level.devball) && !isDefined(var_3) && !istrue(var_4)) {
      scripts\mp\utility\dialog::statusdialog("ally_drop_drone", var_10);
      scripts\mp\utility\dialog::statusdialog("enemy_drop_drone", var_11);
    }

    var_12 = (0, var_7[1], 0);
    var_13 = anglesToForward(var_12);

    if(isDefined(var_3)) {
      var_14 = var_13 * 20 + (0, 0, 80);
    } else {
      var_14 = var_14 * 200 + (0, 0, 80);
    }

    ball_physics_launch(var_14);
  }

  var_15 = spawnStruct();
  var_15.carryobject = self;
  var_15.deathoverridecallback = &ball_overridemovingplatformdeath;
  self.trigger thread scripts\mp\movers::handle_moving_platforms(var_15);

  if(level.timerstoppedforgamemode) {
    level scripts\mp\gamelogic::resumetimer();
  }

  return true;
}

function ball_carrier_cleanup(var_0) {
  if(isDefined(self.carrier)) {
    self.carrier.balldropdelay = undefined;
    self.carrier.nopickuptime = gettime() + 500;
    player_clear_pass_target(self.carrier);
    self.carrier notify("cancel_update_pass_target");
    self.carrier.ball_carried = undefined;

    if(!istrue(level.devball)) {
      self.carrier scripts\mp\utility\perk::removeperk("specialty_ballcarrier");
      self.carrier scripts\mp\lightarmor::lightarmor_unset(self.carrier);
    }

    if(self.carrier.hasperksprintfire) {
      self.carrier scripts\mp\utility\perk::removeperk("specialty_sprintfire");
    }

    self.carrier.hasperksprintfire = 0;

    if(level.codcasterenabled) {
      self.carrier setgametypevip(0);
    }

    self.carrier scripts\common\utility::allow_usability(1);

    if(istrue(var_0)) {
      self.carrier scripts\mp\equipment::allow_equipment(1, "obj_ball");
    }

    self.carrier setballpassallowed(0);
    self.carrier.objective = 0;
    self.visuals[0] setotherent(undefined);
    return;
  }
}

function ball_on_reset() {
  ball_assign_start(level.ball_starts[self.ballindex]);
  ball_restore_contents();
  var_0 = self.visuals[0];
  var_0 scripts\mp\movers::notify_moving_platform_invalid();
  var_1 = var_0 getlinkedparent();

  if(isDefined(var_1)) {
    var_0 unlink();
  }

  stop_fx_idle(self.visuals[0]);
  var_0 physicslaunchserver(var_0.origin, (0, 0, 0));
  var_0 physicsstopserver();
  ball_dont_interpolate();

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  var_2 = "none";
  var_3 = self.lastcarrierteam;

  if(isDefined(var_3)) {
    var_2 = scripts\mp\utility\game::getotherteam(var_3)[0];
  }

  self.lastcarrierteam = "none";
  ball_carrier_cleanup(1);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  ball_waypoint_download();

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    scripts\mp\gameobjects::setposition(var_0.baseorigin + (0, 0, 4000), (0, 0, 0));
    var_0 moveTo(var_0.baseorigin, 3, 0, 3);
    var_0 rotatevelocity((0, 720, 0), 3, 0, 3);
  } else {
    if(!level.timerstoppedforgamemode) {
      level scripts\mp\gamelogic::pausetimer();
    }

    var_0 hide(1);
    self.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
    thread waitforreset(var_0);
  }

  if(!istrue(level.devball)) {
    playsoundatpos(var_0.baseorigin, "mp_uplink_ball_reset");
  }

  if(!self.lastcarrierscored && isDefined(var_3) && isDefined(var_2)) {
    if(!istrue(level.devball) && var_3 != "none" && !istrue(level.gameended)) {
      scripts\mp\utility\dialog::statusdialog("drone_reset", var_3);
      scripts\mp\utility\dialog::statusdialog("drone_reset", var_2);
    }

    if(isDefined(self.lastcarrier)) {}
  }

  self.ownerteam = "any";

  if(scripts\mp\utility\game::getgametype() == "ball" || level.devball) {
    thread ball_download_wait(3);
  }

  if(!istrue(level.devball)) {
    thread ball_download_fx(var_0, 3);
  }

  thread scripts\common\utility::ref_13E0A(level.ref_11B29, "obj_return", var_0.baseorigin);
}

function ball_clear_contents() {
  self.visuals[0] notsolid();
}

function ball_pass_or_shoot() {
  self endon("disconnect");
  thread ball_pass_watch();
  thread ball_shoot_watch();
  thread ball_weapon_change_watch();
  self.carryobject waittill("dropped");
}

function ball_pass_watch() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    self waittill("ball_pass", var_0);

    if(var_0 != level.ballweapon) {
      continue;
    }

    if(!isDefined(self.pass_target)) {
      self iprintlnbold("No Pass Target");
      continue;
    }

    self.carryobject.pass = 1;
    break;
  }

  if(isDefined(self.carryobject)) {
    thread ball_pass_or_throw_active();
    var_1 = self.pass_target;
    var_2 = self.pass_target.origin;
    wait 0.15;

    if(isDefined(self.pass_target)) {
      var_1 = self.pass_target;
    }

    thread ball_pass_projectile(self.carryobject, self, var_1);
    return;
  }
}

function ball_shoot_watch() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    var_0 = getdvarfloat("scr_ball_shoot_extra_pitch", 0);
    var_1 = getdvarfloat("scr_ball_shoot_force", 825);
    goto LOC_00000059;
  }

  var_0 = getdvarfloat("scr_tdef_shoot_extra_pitch", -3);
  var_1 = getdvarfloat("scr_tdef_shoot_force", 450);

  for(;;) {
    self waittill("weapon_fired", var_2);

    if(var_2 != level.ballweapon) {
      continue;
    }

    self setweaponammoclip(var_2, 0);
    break;
  }

  if(isDefined(self.carryobject)) {
    thread scripts\mp\matchdata::loggameevent("pass", self.origin);

    if(!istrue(level.devball)) {
      self playSound("mp_uplink_ball_pass");
    }

    wait 0.15;

    if(self issprintsliding()) {
      var_0 = -12;

      if(scripts\mp\utility\game::getgametype() == "tdef") {
        var_1 += 200;
      }
    }

    var_3 = self getplayerangles();
    var_3 += (var_0, 0, 0);
    var_3 = (clamp(var_3[0], -85, 85), var_3[1], var_3[2]);
    var_4 = anglesToForward(var_3);
    thread ball_pass_or_throw_active();
    thread ball_check_pass_kill_pickup(self.carryobject);
    ball_create_killcam_ent(self.carryobject);
    thread ball_physics_launch_drop(self.carryobject, var_4 * var_1);
    return;
  }
}

function ball_weapon_change_watch() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  thread superabilitywatcher();
  var_0 = level.ballweapon;

  for(;;) {
    if(var_0 == self getcurrentweapon()) {
      goto LOC_0000003c;
    }

    self waittill("weapon_change");
  }

  for(;;) {
    self waittill("weapon_change", var_1);

    if(isDefined(var_1) && scripts\mp\utility\weapon::issuperweapon(var_1.basename)) {
      break;
    }
  }

  var_2 = self getplayerangles();
  var_2 = (clamp(var_2[0], -85, 85), scripts\engine\utility::absangleclamp180(var_2[1] + 20), var_2[2]);
  var_3 = anglesToForward(var_2);
  var_4 = 90;
  thread ball_physics_launch_drop(self.carryobject, var_3 * var_4, self);
}

function superabilitywatcher() {
  self endon("death_or_disconnect");
  self endon("drop_object");
  self endon("unsetBallCarrier");
  self waittill("super_started");
  var_0 = self.super;

  switch (var_0.staticdata.ref) {
    case "super_chargemode":
      ball_drop_on_ability();
      break;
    case "super_rewind":
      scripts\engine\utility::ref_143A5("teleport_success", "rewind_success");
      ball_drop_on_ability();
      break;
  }
}

function ball_drop_on_ability() {
  var_0 = self getplayerangles();
  var_0 = (clamp(var_0[0], -85, 85), scripts\engine\utility::absangleclamp180(var_0[1] + 20), var_0[2]);
  var_1 = anglesToForward(var_0);
  var_2 = 90;
  thread ball_physics_launch_drop(self.carryobject, var_1 * var_2, self);
}

function ball_pass_or_throw_active() {
  self endon("death_or_disconnect");
  self.pass_or_throw_active = 1;
  self allowmelee(0);

  while(level.ballweapon == self getcurrentweapon()) {
    waitframe();
  }

  self allowmelee(1);
  self.pass_or_throw_active = 0;
  scripts\mp\equipment::allow_equipment(1, "obj_ball");
}

function ball_physics_launch_drop(var_0, var_1, var_2) {
  ball_set_dropped(1, undefined, 0, var_2);
  ball_physics_launch(var_0, var_1);
}

function ball_pass_projectile(var_0, var_1, var_2) {
  ball_set_dropped(1);

  if(isDefined(var_1)) {
    var_2 = var_1.origin;
  }

  var_3 = getpasserorigin(var_0);
  var_4 = getpasserdirection(var_0);

  if(!validatepasstarget(self, var_0, var_1)) {
    var_3 = self.lastvalidpassorg;
    var_4 = self.lastvalidpassdir;
  }

  var_5 = var_4 * 30;
  var_6 = var_4 * 60;
  var_7 = var_3 + var_5;
  var_8 = gettargetorigin(var_1);
  var_9 = scripts\engine\trace::sphere_trace(var_7, var_8, level.balltraceradius, var_0, level.ballphysicscontentoverride, 0);
  var_10 = 1;

  if(var_9["fraction"] < 1) {
    if(var_9["hittype"] == "hittype_entity" && isDefined(var_9["entity"]) && isPlayer(var_9["entity"])) {
      var_10 = max(0.1, 0.7 * var_9["fraction"]);
    } else {
      var_10 = 0.7 * var_9["fraction"];
    }

    scripts\mp\gameobjects::setposition(var_7 + var_5 * var_10, self.visuals[0].angles);
  } else {
    scripts\mp\gameobjects::setposition(var_9["position"], self.visuals[0].angles);
  }

  if(isDefined(var_1)) {
    self.projectile = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("uplinkball_tracking_mp"), var_7 + var_6 * var_10, var_8, var_0);
    self.projectile missile_settargetEnt(var_1, gettargetoffset(var_1));
  }

  self.trigger.origin -= (0, 0, 10000);
  thread adjust_for_stance(var_1);
  self.visuals[0] linkTo(self.projectile);
  ball_dont_interpolate();
  ball_create_killcam_ent();
  ball_clear_contents();
  level.codcasterball = self.visuals[0];
  thread ball_on_projectile_hit_client();
  thread ball_on_projectile_death();
  thread ball_on_host_migration();
  thread ball_track_pass_velocity();
  thread ball_track_pass_lifetime();
  thread ball_track_target(var_1);

  if(scripts\mp\utility\game::getgametype() == "ball") {
    thread scripts\mp\gametypes\ball::ball_pass_touch_goal();
    return;
  }
}

function player_update_pass_target(var_0) {
  self endon("disconnect");
  self endon("cancel_update_pass_target");
  player_update_pass_target_hudoutline();
  GscBinSkip4(0x35);
}

function validatepasstarget(var_0, var_1, var_2) {
  var_3 = 0.85;
  var_4 = getpasserorigin(var_1);
  var_5 = getpasserdirection(var_1);
  var_6 = gettargetorigin(var_2);
  var_7 = distancesquared(var_6, var_4);

  if(var_7 > level.ballpassdist) {
    return false;
  }

  var_8 = vectorNormalize(var_6 - var_4);
  var_9 = vectordot(var_5, var_8);

  if(var_9 > var_3) {
    var_10 = var_5 * 30;
    var_11 = var_4 + var_10;
    var_12 = scripts\engine\trace::sphere_trace(var_11, var_6, level.balltraceradius, var_1, level.ballphysicscontentoverride, 0);

    if(isDefined(var_12["entity"]) && isPlayer(var_12["entity"]) || var_12["fraction"] > 0.8) {
      var_2.pass_dot = var_9;
      var_0.lastvalidpassorg = var_4;
      var_0.lastvalidpassdir = var_5;
      return true;
    }
  }

  return false;
}

function player_update_pass_target_hudoutline() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.carryobject)) {
    return;
  }

  if(isDefined(self.carryobject.passtargetoutlineid) && isDefined(self.carryobject.passtargetent)) {
    scripts\mp\utility\outline::outlinedisable(self.carryobject.passtargetoutlineid, self.carryobject.passtargetent);
    self.carryobject.passtargetoutlineid = undefined;
    self.carryobject.passtargetent = undefined;
  }

  if(isDefined(self.carryobject.playeroutlineid) && isDefined(self.carryobject.playeroutlined)) {
    scripts\mp\utility\outline::outlinedisable(self.carryobject.playeroutlineid, self.carryobject.playeroutlined);
    self.carryobject.playeroutlineid = undefined;
    self.carryobject.playeroutlined = undefined;
  }

  if(self.carryobject.isresetting) {
    return;
  }

  var_0 = [];
  var_1 = [];
  var_2 = scripts\mp\utility\game::getotherteam(self.team)[0];
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level.players) {
    if(var_6 == self) {
      continue;
    }

    if(var_6.team == self.team) {
      var_0 = var_6;
      continue;
    }

    if(var_6.team == var_2) {
      var_1 = var_6;
    }
  }

  foreach(var_6 in var_0) {
    var_9 = isDefined(self.pass_target) && self.pass_target == var_6;
  }

  if(isDefined(self.pass_target)) {
    var_3 = scripts\mp\utility\outline::outlineenableforplayer(self.pass_target, self, "outline_depth_cyan", "level_script");
  }

  self.carryobject.passtargetoutlineid = var_3;
  self.carryobject.passtargetent = self.pass_target;

  if(scripts\mp\utility\game::getgametype() == "tdef" && var_0.size > 0) {
    var_4 = scripts\mp\utility\outline::outlineenableforteam(self, self.team, "outlinefill_nodepth_cyan", "level_script");
  }

  self.carryobject.playeroutlineid = var_4;
  self.carryobject.playeroutlined = self;
}

function adjust_for_stance(var_0) {
  var_1 = self;
  var_0 endon("pass_end");

  while(isDefined(var_1) && isDefined(var_0)) {
    var_0 missile_settargetEnt(var_1, gettargetoffset(var_1));
    waitframe();
  }
}

function compare_player_pass_dot(var_0, var_1) {
  return var_0.pass_dot >= var_1.pass_dot;
}

function player_joined_update_pass_target_hudoutline() {}

function player_set_pass_target(var_0) {
  var_1 = 80;
  var_2 = 0;

  if(isDefined(var_0)) {
    switch (var_0 getstance()) {
      case "crouch":
        var_1 = 60;
        break;
      case "prone":
        var_1 = 35;
        break;
    }

    if(!isDefined(self.pass_icon_offset) || self.pass_icon_offset != var_1) {
      var_2 = 1;
      self.pass_icon_offset = var_1;
    }
  }

  var_3 = (0, 0, var_1);

  if(isDefined(self.pass_target) && isDefined(var_0) && self.pass_target == var_0) {
    if(var_2) {
      self.pass_icon = var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "waypoint_ball_pass", var_1, 0, undefined, undefined, 0.05);
    }

    return;
  }

  if(!isDefined(self.pass_target) && !isDefined(var_0)) {
    return;
  }

  player_clear_pass_target();

  if(isDefined(var_0)) {
    self.pass_icon = var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "waypoint_ball_pass", var_1, 0, undefined, undefined, 0.05);
    self.pass_target = var_0;
    var_4 = [];

    foreach(var_6 in level.players) {
      if(var_6.team == self.team && var_6 != self && var_6 != var_0) {
        var_4 = var_6;
      }
    }

    self setballpassallowed(1);
  }

  player_update_pass_target_hudoutline();
}

function player_clear_pass_target() {
  if(isDefined(self.pass_icon)) {
    self.pass_icon destroy();
  }

  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.team == self.team && var_2 != self) {
      var_0 = var_2;
    }
  }

  self.pass_target = undefined;
  self setballpassallowed(0);
  player_update_pass_target_hudoutline();
}

function player_no_pickup_time() {
  return isDefined(self.nopickuptime) && self.nopickuptime > gettime() || isDefined(self.ball_carried);
}

function valid_ball_super_pickup(var_0) {
  if(!isDefined(var_0.super)) {
    return true;
  }

  if(!isDefined(var_0.super.isinuse) || !var_0.super.isinuse) {
    return true;
  }

  return true;
}

function valid_ball_pickup_weapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0)) {
      return false;
    }

    if(var_0 == level.ballweapon) {
      return false;
    }

    var_1 = var_0.basename;
  }

  if(isstring(var_0)) {
    if(var_0 == "none") {
      return false;
    }

    if(var_0 == level.ballweapon.basename) {
      return false;
    }

    var_1 = var_0;
  }

  if(scripts\mp\utility\killstreak::isremotekillstreakweapon(var_1)) {
    return false;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0)) {
    return false;
  }

  return true;
}

function ball_on_host_migration() {
  self.visuals[0] endon("pass_end");
  level waittill("host_migration_begin");

  if(isDefined(self.projectile)) {
    if(!isDefined(self.pass_target) && !isDefined(self.carrier) && !self.in_goal) {
      if(self.visuals[0].origin != self.visuals[0].baseorigin + (0, 0, 4000)) {
        ball_restore_contents();

        if(!isDefined(self.lastpassdir)) {
          self.lastpassdir = (0, 0, 1);
        }

        ball_physics_launch(self.lastpassdir * 400);
        return;
      }

      return;
    }

    return;
  }
}

function ball_track_pass_velocity() {
  self.visuals[0] endon("pass_end");
  self.projectile endon("projectile_impact_player");
  self.projectile endon("death");
  self.lastpassdir = undefined;
  var_0 = undefined;

  for(;;) {
    if(isDefined(var_0)) {
      self.lastpassdir = vectorNormalize(self.projectile.origin - var_0);
    }

    var_0 = self.projectile.origin;
    waitframe();
  }
}

function ball_track_pass_lifetime() {
  self.visuals[0] endon("pass_end");
  self.projectile endon("projectile_impact_player");
  self.projectile endon("death");
  var_0 = gettime();

  for(var_1 = var_0; var_1 < var_0 + 2000; var_1 = gettime()) {
    waitframe();
  }

  self.projectile delete();
}

function ball_track_target(var_0) {
  self.visuals[0] endon("pass_end");
  self.projectile endon("projectile_impact_player");
  self.projectile endon("death");

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      break;
    }

    waitframe();
  }

  self.projectile delete();
}

function ball_on_projectile_death() {
  self endon("reset");
  self.projectile waittill("death");
  waittillframeend();
  self.trigger.origin = self.curorigin;
  var_0 = self.visuals[0];

  if(!isDefined(self.carrier) && !self.in_goal) {
    if(var_0.origin != var_0.baseorigin + (0, 0, 4000)) {
      ball_restore_contents();

      if(!isDefined(self.lastpassdir)) {
        self.lastpassdir = (0, 0, 1);
      }

      ball_physics_launch(self.lastpassdir * 400);
    }
  }

  ball_restore_contents();
  var_0 notify("pass_end");
}

function ball_on_projectile_hit_client() {
  self.visuals[0] endon("pass_end");
  self.projectile waittill("projectile_impact_player", var_0);
  self.trigger.origin = self.visuals[0].origin;
  self.trigger notify("trigger", var_0);
}

function ball_physics_launch(var_0, var_1) {
  var_2 = self.visuals[0];
  var_2.origin_prev = undefined;
  var_3 = var_2.origin;
  var_4 = var_2;

  if(isDefined(var_1)) {
    var_4 = var_1;
    var_3 = var_1 getEye();
    var_5 = anglestoright(var_0);
    var_3 += (var_5[0], var_5[1], 0) * 7;

    if(var_1 issprintsliding()) {
      var_3 += (0, 0, 10);
    }

    var_6 = var_3;
    var_7 = vectorNormalize(var_0) * 80;
    var_8 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
    var_9 = physics_createcontents(var_8);
    var_10 = scripts\engine\trace::sphere_trace(var_6, var_6 + var_7, 38, var_1, var_9);

    if(var_10["fraction"] < 1) {
      var_11 = 0.7 * var_10["fraction"];
      scripts\mp\gameobjects::setposition(var_6 + var_7 * var_11, var_2.angles);
    } else {
      scripts\mp\gameobjects::setposition(var_10["position"], var_2.angles);
    }
  }

  self.visuals[0] physicslaunchserver(var_2.origin, var_0);
  self.visuals[0] thread scripts\mp\utility\entity::register_physics_collisions();
  self.visuals[0] physics_registerforcollisioncallback();
  scripts\mp\utility\entity::register_physics_collision_func(self.visuals[0], &ball_impact_sounds);
  self.visuals[0].origin = self.trigger.origin;
  self.trigger linkTo(self.visuals[0]);
  level.codcasterball = self.visuals[0];
  level.codcasterballowner = var_4;
  level.codcasterballinitialforcevector = var_0;
  thread ball_physics_out_of_level();
  thread ball_physics_timeout(var_1);
  thread ball_physics_bad_trigger_watch();

  if(scripts\mp\utility\game::getgametype() == "ball") {
    thread scripts\mp\gametypes\ball::ball_physics_touch_goal();
  }

  thread ball_physics_touch_cant_pickup_player(var_1);
}

function ball_physics_touch_cant_pickup_player(var_0) {
  var_1 = self.visuals[0];
  var_2 = self.trigger;
  self.visuals[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(!isPlayer(var_3) && !isagent(var_3)) {
      continue;
    }

    if(isDefined(var_0) && var_0 == var_3 && player_no_pickup_time(var_3)) {
      continue;
    }

    if(self.droptime >= gettime()) {
      continue;
    }

    if(var_1.origin == var_1.baseorigin + (0, 0, 4000)) {
      continue;
    }

    if(!ball_can_pickup(var_3)) {
      if(player_no_pickup_time(var_3)) {
        continue;
      }

      var_3.nopickuptime = gettime() + 500;
      thread ball_physics_fake_bounce();
    }
  }
}

function ball_physics_fake_bounce(var_0) {
  var_1 = self.visuals[0];
  var_2 = var_1 physics_getbodyid(0);
  var_3 = physics_getbodylinvel(var_2);

  if(isDefined(var_0) && var_0) {
    var_4 = length(var_3) * 0.4;
    thread watchstuckinnozone();
  } else {
    var_4 = length(var_4) / 10;
  }

  var_5 = vectorNormalize(var_4);
  var_5 = (-1, -1, -0.5) * var_5;
  var_2 physicslaunchserver(var_2.origin, (0, 0, 0));
  var_2 physicsstopserver();
  var_2 physicslaunchserver(var_2.origin, var_5 * var_4);
  var_2.physicsactivated = 1;
}

function physics_impact_watch() {
  self endon("death");

  for(;;) {
    self waittill("projectile_impact", var_0, var_1, var_2, var_3);
    var_4 = level._effect["ball_physics_impact"];

    if(isDefined(var_3) && isDefined(level._effect["ball_physics_impact_" + var_3])) {
      var_4 = level._effect["ball_physics_impact_" + var_3];
    }

    if(!istrue(level.devball)) {
      playFX(var_4, var_0, var_1);
    }

    wait 0.3;
  }
}

function ball_impact_sounds(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_0 physics_getbodyid(0);
  var_10 = physics_getbodylinvel(var_9);
  var_11 = length(var_10);

  if(isDefined(var_0.playing_sound) || var_11 < 70) {
    return;
  }

  var_0 endon("death");
  var_0.playing_sound = 1;
  var_12 = "mp_uplink_ball_bounce";
  var_0 playSound(var_12);
  var_13 = lookupsoundlength(var_12);
  wait 0.1;
  var_0.playing_sound = undefined;
}

function ball_return_home(var_0, var_1) {
  self.ball_fx_active = 0;

  if(istrue(var_0)) {
    detonateball();
  }

  if(istrue(level.possessionresetcondition)) {
    if(istrue(level.player_has_respawn_munition)) {
      updatetimers(level, "neutral", 0, 1);
    } else {
      updatetimers(level, "neutral", 1, 1);
    }
  }

  level.codcasterball = undefined;
  level.codcasterballinitialforcevector = undefined;
  level.ballreset = 1;
  self.in_goal = 0;
  var_2 = self.visuals[0];
  var_2 physicslaunchserver(var_2.origin, (0, 0, 0));
  var_2 physicsstopserver();

  if(!istrue(level.devball)) {
    playsoundatpos(var_2.origin, "mp_uplink_ball_out_of_bounds");
    playFX(scripts\engine\utility::getfx("ball_teleport"), var_2.origin);
  }

  if(isDefined(self.carrier)) {
    self.carrier scripts\engine\utility::delaythread(0.05, &player_update_pass_target_hudoutline);
  }

  self.visuals[0] setscriptablepartstate("uplink_drone_hide", "show", 0);
  thread scripts\mp\gameobjects::returnhome();
}

function ball_overridemovingplatformdeath(var_0) {
  ball_return_home(var_0.carryobject, 0, 1);
}

function ball_download_wait(var_0) {
  self endon("pickup_object");
  scripts\mp\gameobjects::allowcarry("none");
  self.isresetting = 1;
  wait var_0;
  self.isresetting = 0;
  ball_waypoint_neutral();
  scripts\mp\gameobjects::allowcarry("any");
  self notify("ball_ready");

  if(!istrue(level.devball)) {
    playFX(level._effect["ball_download_end"], self.curorigin);
    thread ball_fx_start(0, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    updatetimers(level, "neutral", 1, 1);
    thread starthoveranim();
    return;
  }
}

function waitforreset(var_0) {
  self endon("pickup_object");
  self endon("game_ended");
  scripts\mp\gameobjects::allowcarry("none");

  if(level.player_has_respawn_munition != 0) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.player_has_respawn_munition);
  }

  if(level.timerstoppedforgamemode) {
    level scripts\mp\gamelogic::resumetimer();
  }

  scripts\mp\gameobjects::setposition(var_0.baseorigin, (0, 0, 0));
  self.visuals[0] setscriptablepartstate("uplink_drone_hide", "show", 0);
  thread ball_download_wait(0);
  var_0 rotatevelocity((0, 720, 0), 3, 0, 3);
}

function starthoveranim() {
  self endon("death");
  self endon("reset");
  self endon("pickup_object");
  self notify("hoverAnimStart");
  self endon("hoverAnimStart");
  var_0 = self.visuals[0].origin;
  self.visuals[0] rotateYaw(2000, 60, 0.2, 0.2);

  for(;;) {
    self.visuals[0] moveTo(var_0 + (0, 0, 5), 1, 0.5, 0.5);
    wait 1;
    self.visuals[0] moveTo(var_0 - (0, 0, 5), 1, 0.5, 0.5);
    wait 1;
  }
}

function ball_physics_out_of_level() {
  self endon("reset");
  self endon("pickup_object");
  var_0 = self.visuals[0];
  GscBinSkip1(0x45, 0, 200);
}

function ball_physics_timeout(var_0) {
  self endon("reset");
  self endon("pickup_object");
  self endon("score_event");

  if(!isDefined(level.idleresettime)) {
    level.idleresettime = 15;
  }

  var_1 = level.idleresettime;
  var_2 = 10;
  var_3 = 3;

  if(var_1 >= var_2) {
    wait var_3;
    var_1 -= var_3;
  }

  wait var_1;
  self notify("physics_timeout");
  ball_return_home(1, 1);
}

function ball_physics_bad_trigger_watch() {
  self.visuals[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  thread ball_physics_bad_trigger_at_rest();

  for(;;) {
    if(touchingnozonetrigger(self.visuals[0])) {
      thread ball_physics_fake_bounce(1);
    }

    if(!self.visuals[0] scripts\mp\utility\entity::touchingballallowedtrigger()) {
      if(self.visuals[0] scripts\mp\utility\entity::touchingbadtrigger() || self.visuals[0] scripts\mp\utility\entity::touchingoobtrigger()) {
        ball_return_home(0, 1);
        return;
      }
    }

    waitframe();
  }
}

function touchingnozonetrigger() {
  if(level.nozonetriggers.size > 0) {
    foreach(var_1 in level.nozonetriggers) {
      if(self istouching(var_1)) {
        return true;
      }
    }
  }

  return false;
}

function watchstuckinnozone() {
  self.visuals[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  var_0 = gettime();
  var_1 = var_0 + 500;

  for(;;) {
    if(touchingnozonetrigger(self.visuals[0]) && var_1 < var_0) {
      ball_return_home(1, 1);
      return;
    }

    wait 0.05;
    var_0 = gettime();
  }
}

function ball_physics_bad_trigger_at_rest() {
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  var_0 = self.visuals[0];
  var_0 endon("death");
  var_0 waittill("physics_finished");

  if(scripts\mp\utility\entity::touchingbadtrigger()) {
    ball_return_home(1, 1);
    return;
  }
}

function ball_location_hud() {
  for(;;) {
    var_0 = scripts\engine\utility::ref_143AF("pickup_object", "dropped", "reset", "ball_ready");

    switch (var_0) {
      case "pickup_object":
        break;
      case "dropped":
        break;
      case "reset":
        break;
      case "ball_ready":
        break;
      default:
        break;
    }
  }
}

function ball_check_pass_kill_pickup(var_0) {
  self endon("death_or_disconnect");
  var_0 endon("reset");
  var_1 = spawnStruct();
  var_1 endon("timer_done");
  thread timer_run(var_1);
  var_0 waittill("pickup_object");
  timer_cancel(var_1);

  if(!isDefined(var_0.carrier) || var_0.carrier.team == self.team) {
    return;
  }

  var_0.carrier endon("disconnect");
  thread timer_run(var_1);
  var_0.carrier waittill("death", var_2);
  timer_cancel(var_1);

  if(!isDefined(var_2) || var_2 != self) {
    return;
  }

  thread timer_run(var_1);
  var_0 waittill("pickup_object");
  timer_cancel(var_1);

  if(isDefined(var_0.carrier) && var_0.carrier == self) {
    thread scripts\mp\utility\points::giveunifiedpoints("ball_pass_kill");
    return;
  }
}

function timer_run(var_0) {
  self endon("cancel_timer");
  wait var_0;
  self notify("timer_done");
}

function timer_cancel() {
  self notify("cancel_timer");
}

function ball_waypoint_neutral() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_neutral_ball", "waypoint_neutral_ball");
}

function ball_waypoint_held(var_0) {
  if(scripts\mp\utility\game::getgametype() == "ball") {
    var_1 = "waypoint_escort";
  } else {
    var_1 = "waypoint_defend_round";
  }

  scripts\mp\gameobjects::setobjectivestatusicons(var_1, "waypoint_capture_kill_round");
}

function ball_waypoint_download() {
  if(scripts\mp\utility\game::getgametype() == "ball") {
    var_0 = "waypoint_ball_download";
  } else {
    var_0 = "waypoint_reset_marker";
  }

  scripts\mp\gameobjects::setobjectivestatusicons(var_0, var_0);
}

function ball_waypoint_upload() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_ball_upload", "waypoint_ball_upload");
}

function ball_restore_contents() {
  self.visuals[0] solid();
}

function ball_dont_interpolate() {
  self.visuals[0] dontinterpolate();
  self.ball_fx_active = 0;
}

function ball_assign_start(var_0) {
  foreach(var_2 in self.visuals) {
    var_2.baseorigin = var_0.origin;
  }

  self.trigger.baseorigin = var_0.origin;
  self.current_start = var_0;
  var_0.in_use = 1;
}

function ball_create_killcam_ent() {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self.killcament = spawn("script_model", self.visuals[0].origin);
  self.killcament linkTo(self.visuals[0]);
  self.killcament notsolid();
  self.killcament setscriptmoverkillcam("explosive");
}

function initballtimer() {
  level.balltime = level.possessionresettime;
  level.balltimerpaused = 1;
  level.balltimerstopped = 0;

  if(isDefined(level.possessionresetcondition) && level.possessionresetcondition != 0) {
    thread createhudelems();
    return;
  }
}

function createhudelems() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  updatetimers("neutral", 1, 1);
}

function updatetimers(var_0, var_1, var_2, var_3) {
  if(!istrue(level.possessionresetcondition)) {
    return;
  }

  var_4 = undefined;
  var_5 = 1000 * level.possessionresettime;

  if(istrue(var_2)) {
    if(istrue(level.player_has_respawn_munition) && !istrue(level.ballreset)) {
      var_5 = 1000 * level.player_has_respawn_munition;
    }
  }

  if(istrue(var_2) || istrue(var_3)) {
    level.balltime = level.possessionresettime;
    level.ballendtime = int(gettime() + var_5);
  } else {
    level.ballendtime = int(gettime() + 1000 * level.balltime);
  }

  setomnvar("ui_hardpoint_timer", level.ballendtime);

  if(var_5 > 0 && (istrue(var_3) || !var_1 && level.balltimerpaused)) {
    thread ballruntimer(level.ball, var_0);
  }

  if(var_1) {
    pauseballtimer(level);
    return;
  }
}

function ballruntimer(var_0, var_1) {
  level endon("game_ended");
  level endon("reset");
  level endon("pause_ball_timer");
  level notify("ballRunTimer");
  level endon("ballRunTimer");
  level.balltimerpaused = 0;
  balltimerwait(var_0, var_1);

  if(!istrue(level.ballreset)) {
    scripts\mp\gameobjects::allowcarry("none");
    ball_set_dropped(1, self.trigger.origin, 1);
    ball_return_home(1, 1);
    return;
  }
}

function balltimerwait(var_0, var_1) {
  level endon("game_ended");
  level endon("pause_ball_timer");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, int(level.balltime * 1000 + gettime()));
  resumeballtimer(level, var_1);
  thread watchtimerpause();
  thread handlehostmigration(level);
  waitballlongdurationwithgameendtimeupdate(level.balltime);
}

function waitballlongdurationwithgameendtimeupdate(var_0) {
  level endon("game_ended");
  level endon("pause_ball_timer");

  if(var_0 == 0) {
    return;
  }

  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    waittillballhostmigrationstarts((var_2 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var_2 += 1000;
      setgameendtime(int(var_2));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_2 += 1000;
    setgameendtime(int(var_2));
    wait 1;
  }

  return gettime() - var_1;
}

function waittillballhostmigrationstarts(var_0) {
  level endon("game_ended");
  level endon("pause_ball_timer");

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait var_0;
}

function handlehostmigration(var_0) {
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_objective_timer_stopped", 1);
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(!level.balltimerstopped) {
    setomnvar("ui_objective_timer_stopped", 0);
  }

  if(var_1 > 0) {
    setomnvar("ui_hardpoint_timer", level.ballendtime + var_1);
    return;
  }

  setomnvar("ui_hardpoint_timer", level.ballendtime);
}

function watchtimerpause() {
  level endon("game_ended");
  level notify("watchResetSoon");
  level endon("watchResetSoon");
  var_0 = 0;
  var_1 = undefined;

  while(level.balltime > 0 && !level.balltimerpaused) {
    var_2 = gettime();

    if(!var_0 && level.balltime < 10) {
      foreach(var_4 in level.teamnamelist) {
        level scripts\mp\utility\dialog::statusdialog("drone_reset_soon", var_4);
      }

      var_0 = 1;
    }

    if(isDefined(level.balls[0].carrier) && level.balltime < 5) {
      if(!isDefined(var_1) || var_2 > var_1 + 1000) {
        var_1 = var_2;
      }
    }

    var_6 = 0.05;
    wait var_6;
    level.balltime -= var_6;
  }

  if(level.balltimerpaused) {
    level notify("pause_ball_timer");
    return;
  }
}

function updateballtimerpausedness(var_0) {
  var_1 = level.balltimerpaused || isDefined(level.hostmigrationtimer);

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    var_1 = 0;
  }

  if(!level.balltimerstopped && var_1) {
    level.balltimerstopped = 1;
    setomnvar("ui_objective_timer_stopped", 1);
    return;
  }

  if(level.balltimerstopped && !var_1) {
    level.balltimerstopped = 0;
    setomnvar("ui_objective_timer_stopped", 0);
    return;
  }
}

function pauseballtimer() {
  level.balltimerpaused = 1;
  updateballtimerpausedness();
}

function resumeballtimer(var_0) {
  level.balltimerpaused = 0;
  updateballtimerpausedness(var_0);
}

function ball_player_on_connect() {
  if(!istrue(level.devball)) {
    foreach(var_1 in level.balls) {
      ball_fx_start_player(var_1, self);
    }

    return;
  }
}

function ball_fx_start_player(var_0) {
  if(ball_fx_active()) {
    self.visuals[0] setscriptablepartstate("uplink_drone_idle", "normal", 0);
    self.visuals[0] setscriptablepartstate("uplink_drone_tail", "normal", 0);
    return;
  }
}

function ball_fx_start(var_0, var_1) {
  self endon("reset");
  self endon("pickup_object");

  if(istrue(var_0)) {
    wait 0.2;
  } else {
    waitframe();
  }

  if(!ball_fx_active()) {
    self.visuals[0] setscriptablepartstate("uplink_drone_idle", "normal", 0);
    self.visuals[0] setscriptablepartstate("uplink_drone_tail", "normal", 0);
    self.ball_fx_active = 1;
    return;
  }
}

function ball_fx_active() {
  return isDefined(self.ball_fx_active) && self.ball_fx_active;
}

function ball_fx_stop() {
  if(ball_fx_active()) {
    stop_fx_idle(self.visuals[0]);
  }

  self.ball_fx_active = 0;
}

function stop_fx_idle() {
  self setscriptablepartstate("uplink_drone_idle", "off", 0);
  self setscriptablepartstate("uplink_drone_tail", "off", 0);
}

function ball_download_fx(var_0, var_1) {
  scripts\engine\utility::waittill_notify_or_timeout("pickup_object", var_1);
  level.scorefrozenuntil = 0;
  level notify("goal_ready");
}

function moveballtoplayer() {
  level notify("practice");
  level endon("practice");
  level endon("game_ended");
  wait 5;

  for(;;) {
    self waittill("call_ball");

    if(!isDefined(level.balls[0].carrier)) {
      level.balls[0].visuals[0] physicslaunchserver(level.balls[0].visuals[0].origin, (0, 0, 0));
      level.balls[0].visuals[0] physicsstopserver();

      while(!isDefined(level.balls[0].carrier)) {
        var_0 = 40;

        switch (self getstance()) {
          case "crouch":
            var_0 = 30;
            break;
          case "prone":
            var_0 = 15;
            break;
        }

        level.balls[0].visuals[0] moveTo(self.origin + (0, 0, var_0), 0.3, 0.15, 0.1);
        wait 0.1;
      }
    }

    wait 1;
  }
}

function practicenotify() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 1;

  for(;;) {
    if(var_0) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    var_0 = 0;

    if(var_0) {
      wait 20;
    } else {
      wait 2;
    }

    thread givepracticemessage();
  }
}

function givepracticemessage() {
  self notify("practiceMessage");
  self endon("practiceMessage");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self notifyonplayercommand("call_ball", "+actionslot 3");
    self iprintlnbold(&"PLATFORM/UPLINK_PRACTICE_SLOT3");
  } else {
    self notifyonplayercommand("call_ball", "+actionslot 7");
    self iprintlnbold(&"PLATFORM/UPLINK_PRACTICE_SLOT7");
  }

  level.balls[0] waittill("score_event");
  wait 5;
  thread givepracticemessage();
}

function sortballarray(var_0) {
  if(!isDefined(var_0) || var_0.size == 0) {
    return undefined;
  }

  var_1 = 1;

  for(var_2 = var_0.size; var_1; var_2--) {
    var_1 = 0;

    for(var_3 = 0; var_3 < var_2 - 1; var_3++) {
      if(compareballindexes(var_0[var_3], var_0[var_3 + 1])) {
        var_4 = var_0[var_3];
        var_0 = var_0[var_3 + 1];
        var_0 = var_4;
        var_1 = 1;
      }
    }
  }

  return var_0;
}

function compareballindexes(var_0, var_1) {
  var_2 = int(var_0.script_label);
  var_3 = int(var_1.script_label);

  if(!isDefined(var_2) && !isDefined(var_3)) {
    return false;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return true;
  }

  if(isDefined(var_2) && !isDefined(var_3)) {
    return false;
  }

  if(var_2 > var_3) {
    return true;
  }

  return false;
}

function getpasserorigin() {
  var_0 = 0;

  switch (self getstance()) {
    case "crouch":
      var_0 = 5;
      break;
    case "prone":
      var_0 = 10;
      break;
  }

  var_1 = self getworldupreferenceangles();
  var_2 = anglestoup(var_1);
  var_3 = self getEye() + var_2 * var_0;
  return var_3;
}

function getpasserdirection() {
  var_0 = self getplayerangles();
  var_1 = anglesToForward(var_0);
  return var_1;
}

function gettargetorigin() {
  var_0 = 10;

  switch (self getstance()) {
    case "crouch":
      var_0 = 15;
      break;
    case "prone":
      var_0 = 5;
      break;
  }

  var_1 = self getworldupreferenceangles();
  var_2 = anglestoup(var_1);
  var_3 = self gettagorigin("j_spinelower", 1, 1);
  var_4 = var_3 + var_2 * var_0;
  return var_4;
}

function gettargetoffset() {
  var_0 = gettargetorigin();
  return (0, 0, var_0[2] - self.origin[2]);
}