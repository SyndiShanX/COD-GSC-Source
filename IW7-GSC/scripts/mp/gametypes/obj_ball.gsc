/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_ball.gsc
*********************************************/

ball_default_origins() {
  level.default_goal_origins = [];
  level.magicbullet = getEntArray("flag_primary", "targetname");
  foreach(var_1 in level.magicbullet) {
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

ball_init_map_min_max() {
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

ball_create_ball_starts() {
  if(!isDefined(level.devball)) {
    level.devball = 0;
  }

  var_0 = getballstarts();
  level.ball_triggers = getballtriggers();
  checkpostshipballspawns(var_0);
  if(var_0.size > 1 && level.satellitecount > 1) {
    for(var_1 = 0; var_1 < level.satellitecount; var_1++) {
      var_2 = getballorigin(var_0[var_1]);
      ball_add_start(var_2);
    }
  } else {
    var_3 = [];
    var_3[0] = (0, 0, 0);
    var_3[1] = (50, 0, 0);
    var_3[2] = (-50, 0, 0);
    var_3[3] = (0, 50, 0);
    var_3[4] = (0, -50, 0);
    for(var_1 = 0; var_1 < level.satellitecount; var_1++) {
      var_2 = getballorigin(var_0[var_1]);
      ball_add_start(var_2 + var_3[var_1]);
    }
  }

  level thread scripts\mp\utility::global_physics_sound_monitor();
}

checkpostshipballspawns(var_0) {
  if(level.mapname == "mp_divide") {
    var_0[0].origin = (-261, 235, 610);
    var_0[1].origin = (-211, 235, 610);
    var_0[2].origin = (-311, 235, 610);
    var_0[3].origin = (-311, 500, 610);
    var_0[4].origin = (-211, 500, 610);
  }
}

getballstarts() {
  var_0 = undefined;
  if(level.gametype == "tdef") {
    var_0 = scripts\engine\utility::getstructarray("tdef_ball_start", "targetname");
  }

  if(!isDefined(var_0) || !var_0.size) {
    var_0 = scripts\engine\utility::getstructarray("ball_start", "targetname");
  }

  if(level.satellitecount > 1) {
    var_0 = sortballarray(var_0);
  }

  return var_0;
}

getballtriggers() {
  var_0 = undefined;
  if(level.gametype == "tdef") {
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

getballorigin(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0.origin;
  } else if(level.devball) {
    var_1 = level.players[0].origin + (0, 0, 30);
  } else {
    var_1 = level.default_ball_origin;
  }

  return var_1;
}

ball_add_start(var_0) {
  var_1 = 30;
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_3 = var_0;
  var_2 ball_find_ground();
  var_2.origin = var_2.ground_origin + (0, 0, var_1);
  var_2.in_use = 0;
  if(level.mapname == "mp_desert") {
    var_3 = var_2.ground_origin;
  }

  if(level.mapname == "mp_divide") {
    var_3 = var_2.ground_origin;
  }

  if(level.gametype == "tdef") {
    level.ballbases[level.ballbases.size] = createballbase(var_3);
  }

  level.ball_starts[level.ball_starts.size] = var_2;
}

ball_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\common\trace::ray_trace(var_1, var_2, var_4, var_3);
  self.ground_origin = var_5["position"];
  return var_5["fraction"] != 0 && var_5["fraction"] != 1;
}

createballbase(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("ctf_game_flag_unsa_base_wm");
  var_1 setasgametypeobjective();
  var_1.baseeffectpos = var_0;
  return var_1;
}

showballbaseeffecttoplayer(var_0) {
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

ball_spawn(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = level.ball_starts[level.balls.size];
  var_2 = spawn("script_model", var_1.origin);
  var_2 setasgametypeobjective();
  if(level.gametype == "ball" || getdvarint("scr_uplink_create_ball") == 1) {
    var_2 setModel("uplink_ball_drone_wm");
    var_2 setnonstick(1);
    level.ballweapon = "iw7_uplinkball_mp";
    level.ballpassdist = 1000000;
  } else {
    var_2 setModel("tdef_ball_drone_wm");
    var_2 setnonstick(1);
    level.ballweapon = "iw7_tdefball_mp";
    level.ballpassdist = 250000;
  }

  var_3 = 32;
  var_4 = undefined;
  if(isDefined(level.ball_triggers) && level.ball_triggers.size > 0) {
    var_4 = level.ball_triggers[var_0];
    var_4.origin = var_2.origin;
  } else {
    var_4 = spawn("trigger_radius", var_2.origin - (0, 0, var_3 / 2), 0, var_3, var_3);
  }

  var_4 enablelinkto();
  var_4 linkto(var_2);
  var_4.no_moving_platfrom_unlink = 1;
  var_4.linktoenabledflag = 1;
  var_4.baseorigin = var_4.origin;
  var_4.no_moving_platfrom_unlink = 1;
  var_5 = [var_2];
  var_6 = scripts\mp\gameobjects::createcarryobject("any", var_4, var_5, (0, 0, 32));
  var_6.objectiveonvisuals = 1;
  var_6 scripts\mp\gameobjects::allowcarry("any");
  var_6 ball_waypoint_neutral();
  var_6.allowweapons = 0;
  var_6.carryweapon = level.ballweapon;
  var_6.keepcarryweapon = 0;
  var_6.visualgroundoffset = (0, 0, 30);
  var_6.canuseobject = ::ball_can_pickup;
  var_6.onpickup = ::ball_on_pickup;
  var_6.setdropped = ::ball_set_dropped;
  var_6.onreset = ::ball_on_reset;
  var_6.carryweaponthink = ::ball_pass_or_shoot;
  var_6.in_goal = 0;
  var_6.lastcarrierscored = 0;
  var_6.pass = 0;
  var_6.requireslos = 1;
  var_6.lastcarrierteam = "none";
  var_6.ballindex = level.balls.size;
  var_6.playeroutlineid = undefined;
  var_6.playeroutlined = undefined;
  var_6.passtargetoutlineid = undefined;
  var_6.passtargetent = undefined;
  var_6.visuals[0] fixlinktointerpolationbug(1);
  var_6.visuals[0] give_player_tickets(1);
  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var_6 scripts\mp\gameobjects::setvisibleteam("friendly");
        var_6.objidpingenemy = 0;
        var_6.objidpingfriendly = 1;
        var_6.objpingdelay = 60;
        break;

      case 1:
        var_6 scripts\mp\gameobjects::setvisibleteam("any");
        var_6.objidpingenemy = 0;
        var_6.objidpingfriendly = 0;
        var_6.objpingdelay = 0.05;
        break;

      case 2:
        var_6 scripts\mp\gameobjects::setvisibleteam("any");
        var_6.objidpingenemy = 0;
        var_6.objidpingfriendly = 1;
        var_6.objpingdelay = 1;
        break;

      case 3:
        var_6 scripts\mp\gameobjects::setvisibleteam("any");
        var_6.objidpingenemy = 0;
        var_6.objidpingfriendly = 1;
        var_6.objpingdelay = 1.5;
        break;

      case 4:
        var_6 scripts\mp\gameobjects::setvisibleteam("any");
        var_6.objidpingenemy = 0;
        var_6.objidpingfriendly = 1;
        var_6.objpingdelay = 2;
        break;

      case 5:
        var_6 scripts\mp\gameobjects::setvisibleteam("any");
        var_6.objidpingenemy = 0;
        var_6.objidpingfriendly = 1;
        var_6.objpingdelay = 3;
        break;

      case 6:
        var_6 scripts\mp\gameobjects::setvisibleteam("any");
        var_6.objidpingenemy = 0;
        var_6.objidpingfriendly = 1;
        var_6.objpingdelay = 4;
        break;
    }
  } else {
    var_6 scripts\mp\gameobjects::setvisibleteam("any");
    var_6.objidpingenemy = 0;
    var_6.objidpingfriendly = 1;
    var_6.objpingdelay = 3;
  }

  var_6 ball_assign_start(var_1);
  level.balls[level.balls.size] = var_6;
  if(level.gametype == "tdef") {
    level.balls[0] thread starthoveranim();
  }

  if(!scripts\mp\utility::istrue(level.devball)) {
    var_6 thread ball_fx_start(1, 1);
  }

  var_6 thread ball_location_hud();
  var_6.visuals[0] playLoopSound("uplink_ball_hum_lp");
  var_7 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var_8 = physics_createcontents(var_7);
  level.ballphysicscontentoverride = var_8;
  level.balltraceradius = 10;
  if(level.gametype == "tdef") {
    level.balltraceradius = 20;
  }
}

ball_can_pickup(var_0) {
  if(isDefined(self.droptime) && self.droptime >= gettime()) {
    return 0;
  }

  if(isplayer(var_0)) {
    if(!var_0 scripts\engine\utility::isweaponallowed()) {
      return 0;
    }

    if(isDefined(var_0.manuallyjoiningkillstreak) && var_0.manuallyjoiningkillstreak) {
      return 0;
    }

    if(scripts\mp\utility::istrue(var_0.iscarrying)) {
      return 0;
    }

    if(scripts\mp\utility::istrue(var_0.using_remote_turret)) {
      return 0;
    }

    if(!valid_ball_super_pickup(var_0)) {
      return 0;
    }

    var_1 = var_0 getcurrentweapon();
    if(isDefined(var_1)) {
      if(!valid_ball_pickup_weapon(var_1)) {
        return 0;
      }
    }

    var_2 = var_0.changingweapon;
    if(isDefined(var_2) && var_0 isswitchingweapon()) {
      if(!valid_ball_pickup_weapon(var_2)) {
        return 0;
      }
    }

    if(var_0 scripts\mp\utility::isanymonitoredweaponswitchinprogress()) {
      var_2 = var_0 scripts\mp\utility::getcurrentmonitoredweaponswitchweapon();
      if(!valid_ball_pickup_weapon(var_2)) {
        return 0;
      }
    }

    if(var_0 scripts\mp\utility::isusingremote()) {
      return 0;
    }

    if(var_0 player_no_pickup_time()) {
      return 0;
    }
  } else {
    return 0;
  }

  return 1;
}

ball_on_pickup(var_0) {
  var_0 notify("obj_picked_up");
  var_0 thread checkgesturethread();
  var_1 = 0;
  if(level.ballreset) {
    if(givegrabscore(var_0)) {
      var_0 thread scripts\mp\utility::giveunifiedpoints("ball_grab");
    }

    level.ballpickupscorefrozen = gettime();
    level.ballreset = 0;
    if(isDefined(level.possessionresetcondition) && level.possessionresetcondition == 1 && scripts\mp\utility::istrue(level.possessionresettime)) {
      var_1 = 1;
    }

    var_0 notify("ball_grab");
  }

  if(isDefined(level.possessionresetcondition) && level.possessionresetcondition == 2 && scripts\mp\utility::istrue(level.possessionresettime) && isDefined(self.lastcarrier) && self.lastcarrier != var_0) {
    var_1 = 1;
  }

  if(level.gametype == "tdef") {
    var_0 scripts\mp\gametypes\tdef::getsettdefsuit();
    level thread scripts\mp\gametypes\tdef::awardcapturepoints(var_0.team);
    if(!level.timerstoppedforgamemode) {
      level scripts\mp\gamelogic::pausetimer();
    }
  }

  if(scripts\mp\utility::istrue(level.possessionresetcondition)) {
    level updatetimers(var_0.team, 0, 0, var_1);
  }

  level.usestartspawns = 0;
  level.codcasterball = undefined;
  level.codcasterballinitialforcevector = undefined;
  var_2 = self.visuals[0] getlinkedparent();
  if(isDefined(var_2)) {
    self.visuals[0] unlink();
  }

  if(!scripts\mp\utility::istrue(level.devball)) {
    var_0 scripts\mp\utility::giveperk("specialty_ballcarrier");
  }

  var_0.ball_carried = self;
  var_0.objective = 1;
  self.carrier scripts\mp\utility::giveperk("specialty_sprintfire");
  self.carrier.hasperksprintfire = 1;
  if(!scripts\mp\utility::istrue(level.devball)) {
    var_0 scripts\mp\lightarmor::setlightarmorvalue(var_0, level.carrierarmor);
  }

  if(!scripts\mp\utility::istrue(level.devball)) {
    thread ball_play_local_team_sound(var_0.team, "mp_uplink_ball_pickedup_friendly", "mp_uplink_ball_pickedup_enemy");
  }

  var_0 scripts\engine\utility::allow_usability(0);
  foreach(var_5, var_4 in var_0.powers) {
    var_0 scripts\mp\powers::func_D727(var_5);
  }

  self.visuals[0] physicslaunchserver(self.visuals[0].origin, (0, 0, 0));
  self.visuals[0] physicsstopserver();
  self.visuals[0] scripts\mp\movers::notify_moving_platform_invalid();
  self.pass = 0;
  self.visuals[0] stop_fx_idle();
  self.visuals[0] show();
  self.visuals[0] hide(1);
  self.visuals[0] linkto(var_0, "j_wrist_ri", (0, 0, 0), var_0.angles);
  self.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  self.current_start.in_use = 0;
  var_6 = 0;
  if(isDefined(self.projectile)) {
    var_6 = 1;
    self.projectile delete();
  }

  var_7 = var_0.team;
  var_8 = scripts\mp\utility::getotherteam(var_0.team);
  self.visuals[0] setotherent(var_0);
  if(var_6) {
    if(self.lastcarrierteam == var_0.team) {
      if(!scripts\mp\utility::istrue(level.devball)) {
        scripts\mp\utility::statusdialog("pass_complete", var_7);
      }

      var_0.passtime = gettime();
      var_0.passplayer = self.lastcarrier;
    } else {
      if(!scripts\mp\utility::istrue(level.devball)) {
        scripts\mp\utility::statusdialog("pass_intercepted", var_8);
      }

      var_0 thread scripts\mp\awards::givemidmatchaward("mode_uplink_intercept");
      if(isplayer(var_0)) {
        var_0 thread scripts\mp\matchdata::loggameevent("pickup_interception", var_0.origin);
      }
    }
  } else {
    if(!scripts\mp\utility::istrue(level.devball) && self.lastcarrierteam != var_0.team) {
      scripts\mp\utility::statusdialog("ally_own_drone", var_7);
      scripts\mp\utility::statusdialog("enemy_own_drone", var_8);
    }

    if(isplayer(var_0)) {
      var_0 thread scripts\mp\matchdata::loggameevent("pickup", var_0.origin);
    }
  }

  if(!scripts\mp\utility::istrue(level.devball)) {
    ball_fx_stop();
  }

  self.lastcarrierscored = 0;
  self.lastcarrier = var_0;
  self.lastcarrierteam = var_0.team;
  self.ownerteam = var_0.team;
  ball_waypoint_held(self.ownerteam);
  scripts\mp\utility::setmlgannouncement(12, var_0.team, var_0 getentitynumber());
  var_0 setweaponammoclip(level.ballweapon, 1);
  if(getdvarint("com_codcasterEnabled", 0) == 1) {
    var_0 setgametypevip(1);
  }

  var_0 thread player_update_pass_target(self);
  if(!scripts\mp\utility::istrue(level.devball)) {
    scripts\mp\gamelogic::sethasdonecombat(var_0, 1);
  }

  self notify("physics_timeout");
}

checkgesturethread() {
  self endon("death");
  self endon("disconnect");
  self endon("drop_object");
  wait(0.05);
  if(isDefined(self.gestureweapon) && self isgestureplaying(self.gestureweapon)) {
    self stopgestureviewmodel(self.gestureweapon, 0.05, 1);
  }
}

detonateball() {
  var_0 = spawn("script_model", self.curorigin);
  var_0 setModel("tag_origin");
  var_1 = self.lastcarrier scripts\mp\utility::_launchgrenade("blackhole_grenade_mp", self.curorigin, (0, 0, 0));
  var_1 linkto(var_0, "tag_origin");
  var_1.triggerportableradarping = self.lastcarrier;
  var_1 hide(1);
  var_1.triggerportableradarping thread scripts\mp\blackholegrenade::func_2B3E(var_1);
}

givegrabscore(var_0) {
  if(level.gametype == "tdef") {
    var_1 = 15000;
  } else {
    var_1 = 10000;
  }

  var_2 = var_0 updatebpm();
  if(var_2) {
    return 0;
  }

  if(isDefined(self.lastcarrier) && var_0.team == self.lastcarrier.team && gettime() < level.ballpickupscorefrozen + var_1) {
    return 0;
  }

  return 1;
}

updatebpm() {
  if(!isDefined(self.bpm)) {
    self.numgrabs = 0;
    self.bpm = 0;
  }

  self.numgrabs++;
  if(scripts\mp\utility::getminutespassed() < 1) {
    return 0;
  }

  self.bpm = self.numgrabs / scripts\mp\utility::getminutespassed();
  if(self.bpm < 4) {
    return 0;
  }

  return 1;
}

ball_play_local_team_sound(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility::getotherteam(var_0);
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

ball_set_dropped(var_0, var_1, var_2, var_3) {
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

  var_7 = var_7 + (0, 0, 40);
  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  for(var_8 = 0; var_8 < self.visuals.size; var_8++) {
    self.visuals[var_8].origin = var_7;
    self.visuals[var_8].angles = var_5;
    self.visuals[var_8] show();
    var_9 = self.visuals[var_8] getlinkedparent();
    if(isDefined(var_9)) {
      self.visuals[var_8] unlink();
    }

    self.visuals[var_8] setscriptablepartstate("uplink_drone_hide", "show", 0);
  }

  if(scripts\mp\utility::istrue(var_3) || scripts\mp\utility::istrue(var_2)) {
    var_4 = 1;
  }

  ball_carrier_cleanup(var_4);
  if(!isDefined(level.scorefrozenuntil)) {
    level.scorefrozenuntil = 0;
  }

  if(level.scorefrozenuntil > 0) {
    self.trigger.origin = self.trigger.origin - (0, 0, 10000);
  } else {
    self.trigger.origin = var_7;
  }

  ball_dont_interpolate();
  self.curorigin = self.trigger.origin;
  if(!scripts\mp\utility::istrue(level.devball)) {
    thread ball_fx_start(0);
  }

  self.ownerteam = "any";
  ball_waypoint_neutral();
  scripts\mp\gameobjects::clearcarrier();
  if(isDefined(var_6)) {
    var_6 player_update_pass_target_hudoutline();
  }

  scripts\mp\gameobjects::updatecompassicons();
  scripts\mp\gameobjects::updateworldicons();
  self.isresetting = 0;
  if(!var_0) {
    var_0A = self.lastcarrierteam;
    var_0B = scripts\mp\utility::getotherteam(var_0A);
    if(!scripts\mp\utility::istrue(level.devball) && !isDefined(var_1) && !scripts\mp\utility::istrue(var_2)) {
      scripts\mp\utility::statusdialog("ally_drop_drone", var_0A);
      scripts\mp\utility::statusdialog("enemy_drop_drone", var_0B);
    }

    var_0C = (0, var_5[1], 0);
    var_0D = anglesToForward(var_0C);
    if(isDefined(var_1)) {
      var_0E = var_0D * 20 + (0, 0, 80);
    } else {
      var_0E = var_0E * 200 + (0, 0, 80);
    }

    ball_physics_launch(var_0E);
  }

  var_0F = spawnStruct();
  var_0F.carryobject = self;
  var_0F.deathoverridecallback = ::ball_overridemovingplatformdeath;
  self.trigger thread scripts\mp\movers::handle_moving_platforms(var_0F);
  if(level.timerstoppedforgamemode) {
    level scripts\mp\gamelogic::resumetimer();
  }

  return 1;
}

ball_carrier_cleanup(var_0) {
  if(isDefined(self.carrier)) {
    if(level.gametype == "tdef") {
      self.carrier scripts\mp\gametypes\tdef::getsettdefsuit();
    }

    self.carrier.balldropdelay = undefined;
    self.carrier.nopickuptime = gettime() + 500;
    self.carrier player_clear_pass_target();
    self.carrier notify("cancel_update_pass_target");
    self.carrier.ball_carried = undefined;
    if(!scripts\mp\utility::istrue(level.devball)) {
      self.carrier scripts\mp\utility::removeperk("specialty_ballcarrier");
      self.carrier scripts\mp\lightarmor::lightarmor_unset(self.carrier);
    }

    if(self.carrier.hasperksprintfire) {
      self.carrier scripts\mp\utility::removeperk("specialty_sprintfire");
    }

    self.carrier.hasperksprintfire = 0;
    if(getdvarint("com_codcasterEnabled", 0) == 1) {
      self.carrier setgametypevip(0);
    }

    self.carrier scripts\engine\utility::allow_usability(1);
    if(scripts\mp\utility::istrue(var_0)) {
      foreach(var_3, var_2 in self.carrier.powers) {
        self.carrier scripts\mp\powers::func_D72D(var_3);
      }
    }

    self.carrier setballpassallowed(0);
    self.carrier.objective = 0;
    self.visuals[0] setotherent(undefined);
  }
}

ball_on_reset() {
  ball_assign_start(level.ball_starts[self.ballindex]);
  ball_restore_contents();
  var_0 = self.visuals[0];
  var_0 scripts\mp\movers::notify_moving_platform_invalid();
  var_1 = var_0 getlinkedparent();
  if(isDefined(var_1)) {
    var_0 unlink();
  }

  self.visuals[0] stop_fx_idle();
  var_0 physicslaunchserver(var_0.origin, (0, 0, 0));
  var_0 physicsstopserver();
  ball_dont_interpolate();
  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  var_2 = "none";
  var_3 = self.lastcarrierteam;
  if(isDefined(var_3)) {
    var_2 = scripts\mp\utility::getotherteam(var_3);
  }

  self.lastcarrierteam = "none";
  ball_carrier_cleanup(1);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  ball_waypoint_download();
  if(level.gametype != "tdef") {
    scripts\mp\gameobjects::setposition(var_0.baseorigin + (0, 0, 4000), (0, 0, 0));
    var_0 moveto(var_0.baseorigin, 3, 0, 3);
    var_0 rotatevelocity((0, 720, 0), 3, 0, 3);
  } else {
    if(!level.timerstoppedforgamemode) {
      level scripts\mp\gamelogic::pausetimer();
    }

    var_0 hide(1);
    self.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
    thread waitforreset(var_0);
  }

  if(!scripts\mp\utility::istrue(level.devball)) {
    playsoundatpos(var_0.baseorigin, "mp_uplink_ball_reset");
  }

  if(!self.lastcarrierscored && isDefined(var_3) && isDefined(var_2)) {
    if(!scripts\mp\utility::istrue(level.devball) && var_3 != "none") {
      scripts\mp\utility::statusdialog("drone_reset", var_3);
      scripts\mp\utility::statusdialog("drone_reset", var_2);
    }

    if(isDefined(self.lastcarrier)) {}
  }

  self.ownerteam = "any";
  if(level.gametype == "ball" || level.devball) {
    thread ball_download_wait(3);
  }

  if(!scripts\mp\utility::istrue(level.devball)) {
    thread ball_download_fx(var_0, 3);
  }

  thread scripts\mp\matchdata::loggameevent("obj_return", var_0.baseorigin);
}

ball_clear_contents() {
  self.visuals[0].oldcontents = self.visuals[0] setcontents(0);
}

ball_pass_or_shoot() {
  self endon("disconnect");
  thread ball_pass_watch();
  thread ball_shoot_watch();
  thread ball_weapon_change_watch();
  self.carryobject waittill("dropped");
}

ball_pass_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
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
    wait(0.15);
    if(isDefined(self.pass_target)) {
      var_1 = self.pass_target;
    }

    self.carryobject thread ball_pass_projectile(self, var_1, var_2);
  }
}

ball_shoot_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  if(level.gametype != "tdef") {
    var_0 = getdvarfloat("scr_ball_shoot_extra_pitch", 0);
    var_1 = getdvarfloat("scr_ball_shoot_force", 825);
  } else {
    var_0 = getdvarfloat("scr_tdef_shoot_extra_pitch", -3);
    var_1 = getdvarfloat("scr_tdef_shoot_force", 450);
  }

  for(;;) {
    self waittill("weapon_fired", var_2);
    if(var_2 != level.ballweapon) {
      continue;
    }

    self setweaponammoclip(level.ballweapon, 0);
    break;
  }

  if(isDefined(self.carryobject)) {
    thread scripts\mp\matchdata::loggameevent("pass", self.origin);
    if(!scripts\mp\utility::istrue(level.devball)) {
      self playSound("mp_uplink_ball_pass");
    }

    wait(0.15);
    if(self issprintsliding()) {
      var_0 = -12;
      if(level.gametype == "tdef") {
        var_1 = var_1 + 200;
      }
    }

    var_3 = self getplayerangles();
    var_3 = var_3 + (var_0, 0, 0);
    var_3 = (clamp(var_3[0], -85, 85), var_3[1], var_3[2]);
    var_4 = anglesToForward(var_3);
    thread ball_pass_or_throw_active();
    thread ball_check_pass_kill_pickup(self.carryobject);
    self.carryobject ball_create_killcam_ent();
    self.carryobject thread ball_physics_launch_drop(var_4 * var_1, self);
  }
}

ball_weapon_change_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("drop_object");
  thread superabilitywatcher();
  var_0 = level.ballweapon;
  for(;;) {
    if(var_0 == self getcurrentweapon()) {
      break;
    }

    self waittill("weapon_change");
  }

  for(;;) {
    self waittill("weapon_change", var_1);
    var_2 = self.super;
    var_3 = var_2.staticdata.useweapon;
    if(!isDefined(var_3)) {
      continue;
    }

    if(isDefined(var_1) && var_1 == var_3) {
      break;
    }
  }

  var_4 = self getplayerangles();
  var_4 = (clamp(var_4[0], -85, 85), scripts\engine\utility::absangleclamp180(var_4[1] + 20), var_4[2]);
  var_5 = anglesToForward(var_4);
  var_6 = 90;
  self.carryobject thread ball_physics_launch_drop(var_5 * var_6, self, 1);
}

superabilitywatcher() {
  self endon("death");
  self endon("disconnect");
  self endon("drop_object");
  self endon("unsetBallCarrier");
  self waittill("super_started");
  var_0 = self.super;
  switch (var_0.staticdata.ref) {
    case "super_chargemode":
    case "super_phaseshift":
      ball_drop_on_ability();
      break;

    case "super_teleport":
    case "super_rewind":
      scripts\engine\utility::waittill_any_3("teleport_success", "rewind_success");
      ball_drop_on_ability();
      break;
  }
}

ball_drop_on_ability() {
  var_0 = self getplayerangles();
  var_0 = (clamp(var_0[0], -85, 85), scripts\engine\utility::absangleclamp180(var_0[1] + 20), var_0[2]);
  var_1 = anglesToForward(var_0);
  var_2 = 90;
  self.carryobject thread ball_physics_launch_drop(var_1 * var_2, self, 1);
}

ball_pass_or_throw_active() {
  self endon("death");
  self endon("disconnect");
  self.pass_or_throw_active = 1;
  self allowmelee(0);
  while(level.ballweapon == self getcurrentweapon()) {
    scripts\engine\utility::waitframe();
  }

  self allowmelee(1);
  self.pass_or_throw_active = 0;
  foreach(var_2, var_1 in self.powers) {
    scripts\mp\powers::func_D72D(var_2);
  }
}

ball_physics_launch_drop(var_0, var_1, var_2) {
  ball_set_dropped(1, undefined, 0, var_2);
  ball_physics_launch(var_0, var_1);
}

ball_pass_projectile(var_0, var_1, var_2) {
  ball_set_dropped(1);
  if(isDefined(var_1)) {
    var_2 = var_1.origin;
  }

  var_3 = var_0 getpasserorigin();
  var_4 = var_0 getpasserdirection();
  if(!validatepasstarget(self, var_0, var_1)) {
    var_3 = self.lastvalidpassorg;
    var_4 = self.lastvalidpassdir;
  }

  var_5 = var_4 * 30;
  var_6 = var_4 * 60;
  var_7 = var_3 + var_5;
  var_8 = var_1 gettargetorigin();
  var_9 = scripts\common\trace::sphere_trace(var_7, var_8, level.balltraceradius, var_0, level.ballphysicscontentoverride, 0);
  var_0A = 1;
  if(var_9["fraction"] < 1 || !scripts\mp\utility::isreallyalive(var_1)) {
    if(var_9["hittype"] == "hittype_entity" && isDefined(var_9["entity"]) && isplayer(var_9["entity"])) {
      var_0A = max(0.1, 0.7 * var_9["fraction"]);
    } else {
      var_0A = 0.7 * var_9["fraction"];
    }

    scripts\mp\gameobjects::setposition(var_7 + var_5 * var_0A, self.visuals[0].angles);
  } else {
    scripts\mp\gameobjects::setposition(var_9["position"], self.visuals[0].angles);
  }

  if(isDefined(var_1)) {
    self.projectile = scripts\mp\utility::_magicbullet("uplinkball_tracking_mp", var_7 + var_6 * var_0A, var_8, var_0);
    self.projectile missile_settargetent(var_1, var_1 gettargetoffset());
  }

  self.trigger.origin = self.trigger.origin - (0, 0, 10000);
  var_1 thread adjust_for_stance(self.projectile);
  self.visuals[0] linkto(self.projectile);
  ball_dont_interpolate();
  ball_create_killcam_ent();
  ball_clear_contents();
  level.codcasterball = self.visuals[0];
  thread ball_on_projectile_hit_client();
  thread ball_on_projectile_death();
  thread ball_on_host_migration();
  thread ball_track_pass_velocity(var_1);
  thread ball_track_pass_lifetime();
  thread ball_track_target(var_1);
  if(level.gametype == "ball") {
    thread scripts\mp\gametypes\ball::ball_pass_touch_goal();
  }
}

player_update_pass_target(var_0) {
  self endon("disconnect");
  self endon("cancel_update_pass_target");
  player_update_pass_target_hudoutline();
  childthread player_joined_update_pass_target_hudoutline();
  for(;;) {
    var_1 = undefined;
    if(!self isonladder()) {
      var_2 = [];
      foreach(var_4 in level.players) {
        if(!isDefined(var_4.team)) {
          continue;
        }

        if(var_4.team != self.team) {
          continue;
        }

        if(!scripts\mp\utility::isreallyalive(var_4)) {
          continue;
        }

        if(!var_0 ball_can_pickup(var_4)) {
          continue;
        }

        if(validatepasstarget(var_0, self, var_4)) {
          var_2[var_2.size] = var_4;
        }
      }

      if(isDefined(var_2) && var_2.size > 0) {
        var_2 = scripts\mp\utility::quicksort(var_2, ::compare_player_pass_dot);
        var_6 = self getEye();
        foreach(var_4 in var_2) {
          var_8 = var_4 gettargetorigin();
          if(sighttracepassed(var_6, var_8, 0, self, var_4)) {
            var_1 = var_4;
            break;
          }
        }
      }
    }

    player_set_pass_target(var_1);
    scripts\engine\utility::waitframe();
  }
}

validatepasstarget(var_0, var_1, var_2) {
  var_3 = 0.85;
  var_4 = var_1 getpasserorigin();
  var_5 = var_1 getpasserdirection();
  var_6 = var_2 gettargetorigin();
  var_7 = distancesquared(var_6, var_4);
  if(var_7 > level.ballpassdist) {
    return 0;
  }

  var_8 = vectornormalize(var_6 - var_4);
  var_9 = vectordot(var_5, var_8);
  if(var_9 > var_3) {
    var_0A = var_5 * 30;
    var_0B = var_4 + var_0A;
    var_0C = scripts\common\trace::sphere_trace(var_0B, var_6, level.balltraceradius, var_1, level.ballphysicscontentoverride, 0);
    if((isDefined(var_0C["entity"]) && isplayer(var_0C["entity"])) || var_0C["fraction"] > 0.8) {
      var_2.pass_dot = var_9;
      var_0.lastvalidpassorg = var_4;
      var_0.lastvalidpassdir = var_5;
      return 1;
    }
  }

  return 0;
}

player_update_pass_target_hudoutline() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.carryobject)) {
    return;
  }

  if(isDefined(self.carryobject.passtargetoutlineid) && isDefined(self.carryobject.passtargetent)) {
    scripts\mp\utility::outlinedisable(self.carryobject.passtargetoutlineid, self.carryobject.passtargetent);
    self.carryobject.passtargetoutlineid = undefined;
    self.carryobject.passtargetent = undefined;
  }

  if(isDefined(self.carryobject.playeroutlineid) && isDefined(self.carryobject.playeroutlined)) {
    scripts\mp\utility::outlinedisable(self.carryobject.playeroutlineid, self.carryobject.playeroutlined);
    self.carryobject.playeroutlineid = undefined;
    self.carryobject.playeroutlined = undefined;
  }

  if(self.carryobject.isresetting) {
    return;
  }

  var_0 = [];
  var_1 = [];
  var_2 = scripts\mp\utility::getotherteam(self.team);
  var_3 = undefined;
  var_4 = undefined;
  foreach(var_6 in level.players) {
    if(var_6 == self) {
      continue;
    }

    if(var_6.team == self.team) {
      var_0[var_0.size] = var_6;
      continue;
    }

    if(var_6.team == var_2) {
      var_1[var_1.size] = var_6;
    }
  }

  foreach(var_6 in var_0) {
    var_9 = isDefined(self.pass_target) && self.pass_target == var_6;
  }

  if(isDefined(self.pass_target)) {
    var_3 = scripts\mp\utility::outlineenableforplayer(self.pass_target, "cyan", self, 1, 0, "level_script");
  }

  self.carryobject.passtargetoutlineid = var_3;
  self.carryobject.passtargetent = self.pass_target;
  if(level.gametype == "tdef" && var_0.size > 0) {
    var_4 = scripts\mp\utility::outlineenableforteam(self, "cyan", self.team, 0, 1, "level_script");
  }

  self.carryobject.playeroutlineid = var_4;
  self.carryobject.playeroutlined = self;
}

adjust_for_stance(var_0) {
  var_1 = self;
  var_0 endon("pass_end");
  while(isDefined(var_1) && isDefined(var_0)) {
    var_0 missile_settargetent(var_1, var_1 gettargetoffset());
    scripts\engine\utility::waitframe();
  }
}

compare_player_pass_dot(var_0, var_1) {
  return var_0.pass_dot >= var_1.pass_dot;
}

player_joined_update_pass_target_hudoutline() {
  for(;;) {
    level waittill("joined_team", var_0);
    player_update_pass_target_hudoutline();
  }
}

player_set_pass_target(var_0) {
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
      self.pass_icon = var_0 scripts\mp\entityheadicons::setheadicon(self, "waypoint_ball_pass", var_3, 10, 10, 0, 0.05, 0, 1, 0, 0);
    }

    return;
  }

  if(!isDefined(self.pass_target) && !isDefined(var_0)) {
    return;
  }

  player_clear_pass_target();
  if(isDefined(var_0)) {
    self.pass_icon = var_0 scripts\mp\entityheadicons::setheadicon(self, "waypoint_ball_pass", var_3, 10, 10, 0, 0.05, 0, 1, 0, 0);
    self.pass_target = var_0;
    var_4 = [];
    foreach(var_6 in level.players) {
      if(var_6.team == self.team && var_6 != self && var_6 != var_0) {
        var_4[var_4.size] = var_6;
      }
    }

    self setballpassallowed(1);
  }

  player_update_pass_target_hudoutline();
}

player_clear_pass_target() {
  if(isDefined(self.pass_icon)) {
    self.pass_icon destroy();
  }

  var_0 = [];
  foreach(var_2 in level.players) {
    if(var_2.team == self.team && var_2 != self) {
      var_0[var_0.size] = var_2;
    }
  }

  self.pass_target = undefined;
  self setballpassallowed(0);
  player_update_pass_target_hudoutline();
}

player_no_pickup_time() {
  return (isDefined(self.nopickuptime) && self.nopickuptime > gettime()) || isDefined(self.ball_carried);
}

valid_ball_super_pickup(var_0) {
  if(!isDefined(var_0.super)) {
    return 1;
  }

  if(!isDefined(var_0.super.isinuse) || !var_0.super.isinuse) {
    return 1;
  }

  if(var_0.super.staticdata.ref == "super_phaseshift") {
    return 0;
  }

  return 1;
}

valid_ball_pickup_weapon(var_0) {
  if(var_0 == "none") {
    return 0;
  }

  if(var_0 == level.ballweapon) {
    return 0;
  }

  if(var_0 == "ks_remote_map_mp") {
    return 0;
  }

  if(var_0 == "ks_remote_device_mp") {
    return 0;
  }

  if(scripts\mp\utility::iskillstreakweapon(var_0)) {
    return 0;
  }

  return 1;
}

ball_on_host_migration() {
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
    }
  }
}

ball_track_pass_velocity(var_0) {
  self.visuals[0] endon("pass_end");
  self.projectile endon("projectile_impact_player");
  self.projectile endon("death");
  self.lastpassdir = vectornormalize(var_0.origin - self.projectile.origin);
  var_1 = undefined;
  for(;;) {
    if(isDefined(var_1)) {
      self.lastpassdir = vectornormalize(self.projectile.origin - var_1);
    }

    var_1 = self.projectile.origin;
    scripts\engine\utility::waitframe();
  }
}

ball_track_pass_lifetime() {
  self.visuals[0] endon("pass_end");
  self.projectile endon("projectile_impact_player");
  self.projectile endon("death");
  var_0 = gettime();
  for(var_1 = var_0; var_1 < var_0 + 2000; var_1 = gettime()) {
    scripts\engine\utility::waitframe();
  }

  self.projectile delete();
}

ball_track_target(var_0) {
  self.visuals[0] endon("pass_end");
  self.projectile endon("projectile_impact_player");
  self.projectile endon("death");
  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    if(!scripts\mp\utility::isreallyalive(var_0)) {
      break;
    }

    if(isDefined(var_0.super) && scripts\mp\utility::istrue(var_0.super.isinuse)) {
      if(var_0.super.staticdata.ref == "super_phaseshift") {
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }

  self.projectile delete();
}

ball_on_projectile_death() {
  self endon("reset");
  self.projectile waittill("death");
  waittillframeend;
  if(!isDefined(self.carrier)) {
    self.trigger.origin = self.curorigin;
  }

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

ball_on_projectile_hit_client() {
  self.visuals[0] endon("pass_end");
  self.projectile waittill("projectile_impact_player", var_0);
  self.trigger.origin = self.visuals[0].origin;
  self.trigger notify("trigger", var_0);
}

ball_physics_launch(var_0, var_1) {
  var_2 = self.visuals[0];
  var_2.origin_prev = undefined;
  var_3 = var_2.origin;
  var_4 = var_2;
  if(isDefined(var_1)) {
    var_4 = var_1;
    var_3 = var_1 getEye();
    var_5 = anglestoright(var_0);
    var_3 = var_3 + (var_5[0], var_5[1], 0) * 7;
    if(var_1 issprintsliding()) {
      var_3 = var_3 + (0, 0, 10);
    }

    var_6 = var_3;
    var_7 = vectornormalize(var_0) * 80;
    var_8 = ["physicscontents_clipshot", "physicscontents_corpseclipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
    var_9 = physics_createcontents(var_8);
    var_0A = scripts\common\trace::sphere_trace(var_6, var_6 + var_7, 38, var_1, var_9);
    if(var_0A["fraction"] < 1) {
      var_0B = 0.7 * var_0A["fraction"];
      scripts\mp\gameobjects::setposition(var_6 + var_7 * var_0B, var_2.angles);
    } else {
      scripts\mp\gameobjects::setposition(var_0A["position"], var_2.angles);
    }
  }

  self.visuals[0] physicslaunchserver(var_2.origin, var_0);
  self.visuals[0] thread scripts\mp\utility::register_physics_collisions();
  self.visuals[0] physics_registerforcollisioncallback();
  scripts\mp\utility::register_physics_collision_func(self.visuals[0], ::ball_impact_sounds);
  self.visuals[0].origin = self.trigger.origin;
  self.trigger linkto(self.visuals[0]);
  level.codcasterball = self.visuals[0];
  level.codcasterballowner = var_4;
  level.codcasterballinitialforcevector = var_0;
  thread ball_physics_timeout(var_1);
  thread ball_physics_bad_trigger_watch();
  thread ball_physics_out_of_level();
  if(level.gametype == "ball") {
    thread scripts\mp\gametypes\ball::ball_physics_touch_goal();
  }

  thread ball_physics_touch_cant_pickup_player(var_1);
}

ball_physics_touch_cant_pickup_player(var_0) {
  var_1 = self.visuals[0];
  var_2 = self.trigger;
  self.visuals[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  for(;;) {
    var_2 waittill("trigger", var_3);
    if(scripts\mp\utility::func_9F22(var_3)) {
      continue;
    }

    if(!isplayer(var_3) && !isagent(var_3)) {
      continue;
    }

    if(isDefined(var_0) && var_0 == var_3 && var_3 player_no_pickup_time()) {
      continue;
    }

    if(self.droptime >= gettime()) {
      continue;
    }

    if(var_1.origin == var_1.baseorigin + (0, 0, 4000)) {
      continue;
    }

    if(!ball_can_pickup(var_3)) {
      if(var_3 player_no_pickup_time()) {
        continue;
      }

      var_3.nopickuptime = gettime() + 500;
      thread ball_physics_fake_bounce();
    }
  }
}

ball_physics_fake_bounce(var_0) {
  var_1 = self.visuals[0];
  var_2 = var_1 physics_getbodyid(0);
  var_3 = physics_getbodylinvel(var_2);
  if(isDefined(var_0) && var_0) {
    var_4 = length(var_3) * 0.4;
    thread watchstuckinnozone();
  } else {
    var_4 = length(var_4) / 10;
  }

  var_5 = vectornormalize(var_3);
  var_5 = (-1, -1, -0.5) * var_5;
  var_1 physicslaunchserver(var_1.origin, (0, 0, 0));
  var_1 physicsstopserver();
  var_1 physicslaunchserver(var_1.origin, var_5 * var_4);
  var_1.physicsactivated = 1;
}

physics_impact_watch() {
  self endon("death");
  for(;;) {
    self waittill("projectile_impact", var_0, var_1, var_2, var_3);
    var_4 = level._effect["ball_physics_impact"];
    if(isDefined(var_3) && isDefined(level._effect["ball_physics_impact_" + var_3])) {
      var_4 = level._effect["ball_physics_impact_" + var_3];
    }

    if(!scripts\mp\utility::istrue(level.devball)) {
      playFX(var_4, var_0, var_1);
    }

    wait(0.3);
  }
}

ball_impact_sounds(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_0 physics_getbodyid(0);
  var_0A = physics_getbodylinvel(var_9);
  var_0B = length(var_0A);
  if(isDefined(var_0.playing_sound) || var_0B < 70) {
    return;
  }

  var_0 endon("death");
  var_0.playing_sound = 1;
  var_0C = "mp_uplink_ball_bounce";
  var_0 playSound(var_0C);
  var_0D = lookupsoundlength(var_0C);
  wait(0.1);
  var_0.playing_sound = undefined;
}

ball_return_home(var_0, var_1) {
  self.ball_fx_active = 0;
  if(scripts\mp\utility::istrue(level.explodeonexpire) && scripts\mp\utility::istrue(var_0)) {
    detonateball();
  }

  if(scripts\mp\utility::istrue(level.possessionresetcondition)) {
    if(scripts\mp\utility::istrue(level.ballactivationdelay)) {
      level updatetimers("neutral", 0, 1);
    } else {
      level updatetimers("neutral", 1, 1);
    }
  }

  level.codcasterball = undefined;
  level.codcasterballinitialforcevector = undefined;
  level.ballreset = 1;
  self.in_goal = 0;
  var_2 = self.visuals[0];
  var_2 physicslaunchserver(var_2.origin, (0, 0, 0));
  var_2 physicsstopserver();
  if(!scripts\mp\utility::istrue(level.devball)) {
    playsoundatpos(var_2.origin, "mp_uplink_ball_out_of_bounds");
    playFX(scripts\engine\utility::getfx("ball_teleport"), var_2.origin);
  }

  if(var_1) {
    scripts\mp\utility::setmlgannouncement(2, "free");
  }

  if(isDefined(self.carrier)) {
    self.carrier scripts\engine\utility::delaythread(0.05, ::player_update_pass_target_hudoutline);
  }

  self.visuals[0] setscriptablepartstate("uplink_drone_hide", "show", 0);
  thread scripts\mp\gameobjects::returnobjectiveid();
}

ball_overridemovingplatformdeath(var_0) {
  var_0.carryobject ball_return_home(0, 1);
}

ball_download_wait(var_0) {
  self endon("pickup_object");
  scripts\mp\gameobjects::allowcarry("none");
  self.isresetting = 1;
  wait(var_0);
  self.isresetting = 0;
  ball_waypoint_neutral();
  scripts\mp\gameobjects::allowcarry("any");
  self notify("ball_ready");
  if(!scripts\mp\utility::istrue(level.devball)) {
    playFX(level._effect["ball_download_end"], self.curorigin);
    thread ball_fx_start(0, 1);
  }

  if(level.gametype == "tdef") {
    level updatetimers("neutral", 1, 1);
    level.balls[0] thread starthoveranim();
  }
}

waitforreset(var_0) {
  self endon("pickup_object");
  self endon("game_ended");
  scripts\mp\gameobjects::allowcarry("none");
  if(level.ballactivationdelay != 0) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.ballactivationdelay);
  }

  if(level.timerstoppedforgamemode) {
    level scripts\mp\gamelogic::resumetimer();
  }

  scripts\mp\gameobjects::setposition(var_0.baseorigin, (0, 0, 0));
  self.visuals[0] setscriptablepartstate("uplink_drone_hide", "show", 0);
  thread ball_download_wait(0);
  var_0 rotatevelocity((0, 720, 0), 3, 0, 3);
}

starthoveranim() {
  self endon("death");
  self endon("reset");
  self endon("pickup_object");
  self notify("hoverAnimStart");
  self endon("hoverAnimStart");
  var_0 = self.visuals[0].origin;
  self.visuals[0] rotateyaw(2000, 60, 0.2, 0.2);
  for(;;) {
    self.visuals[0] moveto(var_0 + (0, 0, 5), 1, 0.5, 0.5);
    wait(1);
    self.visuals[0] moveto(var_0 - (0, 0, 5), 1, 0.5, 0.5);
    wait(1);
  }
}

ball_physics_out_of_level() {
  self endon("reset");
  self endon("pickup_object");
  var_0 = self.visuals[0];
  var_1[0] = 200;
  var_1[1] = 200;
  var_1[2] = 1000;
  var_2[0] = 200;
  var_2[1] = 200;
  var_2[2] = 200;
  for(;;) {
    for(var_3 = 0; var_3 < 2; var_3++) {
      if(var_0.origin[var_3] > level.ball_maxs[var_3] + var_1[var_3]) {
        ball_return_home(1, 1);
        return;
      }

      if(var_0.origin[var_3] < level.ball_mins[var_3] - var_2[var_3]) {
        ball_return_home(1, 1);
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

ball_physics_timeout(var_0) {
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
    wait(var_3);
    var_1 = var_1 - var_3;
  }

  wait(var_1);
  self notify("physics_timeout");
  ball_return_home(1, 1);
}

ball_physics_bad_trigger_watch() {
  self.visuals[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  thread ball_physics_bad_trigger_at_rest();
  for(;;) {
    if(self.visuals[0] touchingnozonetrigger()) {
      thread ball_physics_fake_bounce(1);
    }

    if(!self.visuals[0] scripts\mp\utility::touchingballallowedtrigger()) {
      if(self.visuals[0] scripts\mp\utility::touchingbadtrigger() || self.visuals[0] scripts\mp\utility::func_11A44()) {
        ball_return_home(0, 1);
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

touchingnozonetrigger() {
  if(level.nozonetriggers.size > 0) {
    foreach(var_1 in level.nozonetriggers) {
      if(self istouching(var_1)) {
        return 1;
      }
    }
  }

  return 0;
}

watchstuckinnozone() {
  self.visuals[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  var_0 = gettime();
  var_1 = var_0 + 500;
  for(;;) {
    if(self.visuals[0] touchingnozonetrigger() && var_1 < var_0) {
      ball_return_home(1, 1);
      return;
    }

    wait(0.05);
    var_0 = gettime();
  }
}

ball_physics_bad_trigger_at_rest() {
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  var_0 = self.visuals[0];
  var_0 endon("death");
  var_0 waittill("physics_finished");
  if(scripts\mp\utility::touchingbadtrigger()) {
    ball_return_home(1, 1);
  }
}

ball_location_hud() {
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return("pickup_object", "dropped", "reset", "ball_ready");
    switch (var_0) {
      case "pickup_object":
        setomnvar("ui_uplink_ball_carrier", self.carrier getentitynumber());
        setomnvar("ui_uplink_timer_text", 1);
        break;

      case "dropped":
        setomnvar("ui_uplink_ball_carrier", -2);
        break;

      case "reset":
        setomnvar("ui_uplink_ball_carrier", -3);
        setomnvar("ui_uplink_timer_text", 2);
        break;

      case "ball_ready":
        setomnvar("ui_uplink_timer_text", 1);
        setomnvar("ui_uplink_ball_carrier", -1);
        break;

      default:
        break;
    }
  }
}

ball_check_pass_kill_pickup(var_0) {
  self endon("death");
  self endon("disconnect");
  var_0 endon("reset");
  var_1 = spawnStruct();
  var_1 endon("timer_done");
  var_1 thread timer_run(1.5);
  var_0 waittill("pickup_object");
  var_1 timer_cancel();
  if(!isDefined(var_0.carrier) || var_0.carrier.team == self.team) {
    return;
  }

  var_0.carrier endon("disconnect");
  var_1 thread timer_run(5);
  var_0.carrier waittill("death", var_2);
  var_1 timer_cancel();
  if(!isDefined(var_2) || var_2 != self) {
    return;
  }

  var_1 thread timer_run(2);
  var_0 waittill("pickup_object");
  var_1 timer_cancel();
  if(isDefined(var_0.carrier) && var_0.carrier == self) {
    thread scripts\mp\utility::giveunifiedpoints("ball_pass_kill");
  }
}

timer_run(var_0) {
  self endon("cancel_timer");
  wait(var_0);
  self notify("timer_done");
}

timer_cancel() {
  self notify("cancel_timer");
}

ball_waypoint_neutral() {
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_neutral_ball");
  scripts\mp\gameobjects::set2dicon("enemy", "waypoint_neutral_ball");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_neutral_ball");
  scripts\mp\gameobjects::set3dicon("enemy", "waypoint_neutral_ball");
}

ball_waypoint_held(var_0) {
  if(level.gametype == "ball") {
    var_1 = "waypoint_escort";
  } else {
    var_1 = "waypoint_defend_round";
  }

  scripts\mp\gameobjects::set2dicon("friendly", var_1);
  scripts\mp\gameobjects::set2dicon("enemy", "waypoint_capture_kill_round");
  scripts\mp\gameobjects::set3dicon("friendly", var_1);
  scripts\mp\gameobjects::set3dicon("enemy", "waypoint_capture_kill_round");
}

ball_waypoint_download() {
  if(level.gametype == "ball") {
    var_0 = "waypoint_ball_download";
  } else {
    var_0 = "waypoint_reset_marker";
  }

  scripts\mp\gameobjects::set2dicon("friendly", var_0);
  scripts\mp\gameobjects::set2dicon("enemy", var_0);
  scripts\mp\gameobjects::set3dicon("friendly", var_0);
  scripts\mp\gameobjects::set3dicon("enemy", var_0);
}

ball_waypoint_upload() {
  scripts\mp\gameobjects::set2dicon("friendly", "waypoint_ball_upload");
  scripts\mp\gameobjects::set2dicon("enemy", "waypoint_ball_upload");
  scripts\mp\gameobjects::set3dicon("friendly", "waypoint_ball_upload");
  scripts\mp\gameobjects::set3dicon("enemy", "waypoint_ball_upload");
}

ball_restore_contents() {
  if(isDefined(self.visuals[0].oldcontents)) {
    self.visuals[0] setcontents(self.visuals[0].oldcontents);
    self.visuals[0].oldcontents = undefined;
  }
}

ball_dont_interpolate() {
  self.visuals[0] dontinterpolate();
  self.ball_fx_active = 0;
}

ball_assign_start(var_0) {
  foreach(var_2 in self.visuals) {
    var_2.baseorigin = var_0.origin;
  }

  self.trigger.baseorigin = var_0.origin;
  self.current_start = var_0;
  var_0.in_use = 1;
}

ball_create_killcam_ent() {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self.killcament = spawn("script_model", self.visuals[0].origin);
  self.killcament linkto(self.visuals[0]);
  self.killcament setcontents(0);
  self.killcament setscriptmoverkillcam("explosive");
}

initballtimer() {
  level.balltime = level.possessionresettime;
  level.balltimerpaused = 1;
  level.balltimerstopped = 0;
  if(isDefined(level.possessionresetcondition) && level.possessionresetcondition != 0) {
    setomnvar("ui_uplink_timer_show", 1);
    setomnvar("ui_uplink_timer_text", 1);
    thread createhudelems();
    return;
  }

  setomnvar("ui_uplink_timer_show", 0);
}

createhudelems() {
  level endon("game_ended");
  scripts\mp\utility::gameflagwait("prematch_done");
  updatetimers("neutral", 1, 1);
}

updatetimers(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility::istrue(level.possessionresetcondition)) {
    return;
  }

  var_4 = undefined;
  var_5 = 1000 * level.possessionresettime;
  if(scripts\mp\utility::istrue(var_2)) {
    if(scripts\mp\utility::istrue(level.ballactivationdelay) && !scripts\mp\utility::istrue(level.ballreset)) {
      var_5 = 1000 * level.ballactivationdelay;
    }
  }

  if(scripts\mp\utility::istrue(var_2) || scripts\mp\utility::istrue(var_3)) {
    level.balltime = level.possessionresettime;
    level.ballendtime = int(gettime() + var_5);
  } else {
    level.ballendtime = int(gettime() + 1000 * level.balltime);
  }

  setomnvar("ui_hardpoint_timer", level.ballendtime);
  if(var_5 > 0 && scripts\mp\utility::istrue(var_3) || !var_1 && level.balltimerpaused) {
    level.ball thread ballruntimer(var_0, var_4);
  }

  if(level.balltime > 1) {
    if(var_1) {
      level pauseballtimer();
    }
  }
}

ballruntimer(var_0, var_1) {
  level endon("game_ended");
  level endon("reset");
  level endon("pause_ball_timer");
  level notify("ballRunTimer");
  level endon("ballRunTimer");
  level.balltimerpaused = 0;
  balltimerwait(var_0, var_1);
  if(isDefined(level.ball) && isDefined(level.ball.carrier)) {
    self.carrier scripts\mp\missions::func_27FA();
  }

  if(!scripts\mp\utility::istrue(level.ballreset)) {
    scripts\mp\gameobjects::allowcarry("none");
    ball_set_dropped(1, self.trigger.origin, 1);
    ball_return_home(1, 1);
  }
}

balltimerwait(var_0, var_1) {
  level endon("game_ended");
  level endon("pause_ball_timer");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, int(level.balltime * 1000 + gettime()));
  level resumeballtimer(var_1);
  thread watchtimerpause();
  level thread handlehostmigration(var_2);
  waitballlongdurationwithgameendtimeupdate(level.balltime);
}

waitballlongdurationwithgameendtimeupdate(var_0) {
  level endon("game_ended");
  level endon("pause_ball_timer");
  if(var_0 == 0) {
    return;
  }

  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;
  while(gettime() < var_2) {
    waittillballhostmigrationstarts(var_2 - gettime() / 1000);
    while(isDefined(level.hostmigrationtimer)) {
      var_2 = var_2 + 1000;
      setgameendtime(int(var_2));
      wait(1);
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_2 = var_2 + 1000;
    setgameendtime(int(var_2));
    wait(1);
  }

  return gettime() - var_1;
}

waittillballhostmigrationstarts(var_0) {
  level endon("game_ended");
  level endon("pause_ball_timer");
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait(var_0);
}

handlehostmigration(var_0) {
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_uplink_timer_stopped", 1);
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();
  if(!level.balltimerstopped) {
    setomnvar("ui_uplink_timer_stopped", 0);
  }

  if(var_1 > 0) {
    setomnvar("ui_hardpoint_timer", level.ballendtime + var_1);
    return;
  }

  setomnvar("ui_hardpoint_timer", level.ballendtime);
}

watchtimerpause() {
  level endon("game_ended");
  level notify("watchResetSoon");
  level endon("watchResetSoon");
  var_0 = 0;
  var_1 = undefined;
  while(level.balltime > 0 && !level.balltimerpaused) {
    var_2 = gettime();
    if(!var_0 && level.balltime < 10) {
      level scripts\mp\utility::statusdialog("drone_reset_soon", "allies");
      level scripts\mp\utility::statusdialog("drone_reset_soon", "axis");
      var_0 = 1;
    }

    if(isDefined(level.balls[0].carrier) && level.balltime < 5) {
      if(!isDefined(var_1) || var_2 > var_1 + 1000) {
        var_1 = var_2;
        level.balls[0].carrier playsoundtoplayer("mp_cranked_countdown", level.balls[0].carrier);
      }
    }

    var_3 = 0.05;
    wait(var_3);
    level.balltime = level.balltime - var_3;
  }

  if(level.balltimerpaused) {
    level notify("pause_ball_timer");
  }
}

updateballtimerpausedness(var_0) {
  var_1 = level.balltimerpaused || isDefined(level.hostmigrationtimer);
  if(!scripts\mp\utility::gameflag("prematch_done")) {
    var_1 = 0;
  }

  if(!level.balltimerstopped && var_1) {
    level.balltimerstopped = 1;
    setomnvar("ui_uplink_timer_stopped", 1);
    return;
  }

  if(level.balltimerstopped && !var_1) {
    level.balltimerstopped = 0;
    setomnvar("ui_uplink_timer_stopped", 0);
  }
}

pauseballtimer() {
  level.balltimerpaused = 1;
  updateballtimerpausedness();
}

resumeballtimer(var_0) {
  level.balltimerpaused = 0;
  updateballtimerpausedness(var_0);
}

ball_player_on_connect() {
  if(!scripts\mp\utility::istrue(level.devball)) {
    foreach(var_1 in level.balls) {
      var_1 ball_fx_start_player(self);
    }
  }
}

ball_fx_start_player(var_0) {
  if(ball_fx_active()) {
    self.visuals[0] setscriptablepartstate("uplink_drone_idle", "normal", 0);
    self.visuals[0] setscriptablepartstate("uplink_drone_tail", "normal", 0);
  }
}

ball_fx_start(var_0, var_1) {
  self endon("reset");
  self endon("pickup_object");
  if(scripts\mp\utility::istrue(var_0)) {
    wait(0.2);
  } else {
    wait(0.05);
  }

  if(!ball_fx_active()) {
    self.visuals[0] setscriptablepartstate("uplink_drone_idle", "normal", 0);
    self.visuals[0] setscriptablepartstate("uplink_drone_tail", "normal", 0);
    self.ball_fx_active = 1;
  }
}

ball_fx_active() {
  return isDefined(self.ball_fx_active) && self.ball_fx_active;
}

ball_fx_stop() {
  if(ball_fx_active()) {
    self.visuals[0] stop_fx_idle();
  }

  self.ball_fx_active = 0;
}

stop_fx_idle() {
  self setscriptablepartstate("uplink_drone_idle", "off", 0);
  self setscriptablepartstate("uplink_drone_tail", "off", 0);
}

ball_download_fx(var_0, var_1) {
  scripts\engine\utility::waittill_notify_or_timeout("pickup_object", var_1);
  level.scorefrozenuntil = 0;
  level notify("goal_ready");
}

moveballtoplayer() {
  level notify("practice");
  level endon("practice");
  level endon("game_ended");
  wait(5);
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

        level.balls[0].visuals[0] moveto(self.origin + (0, 0, var_0), 0.3, 0.15, 0.1);
        wait(0.1);
      }
    }

    wait(1);
  }
}

practicenotify() {
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
      wait(20);
    } else {
      wait(2);
    }

    thread givepracticemessage();
  }
}

givepracticemessage() {
  self notify("practiceMessage");
  self endon("practiceMessage");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self notifyonplayercommand("call_ball", "+actionslot 3");
    self iprintlnbold(&"PLATFORM_UPLINK_PRACTICE_SLOT3");
  } else {
    self notifyonplayercommand("call_ball", "+actionslot 7");
    self iprintlnbold(&"PLATFORM_UPLINK_PRACTICE_SLOT7");
  }

  level.balls[0] waittill("score_event");
  wait(5);
  thread givepracticemessage();
}

sortballarray(var_0) {
  if(!isDefined(var_0) || var_0.size == 0) {
    return undefined;
  }

  var_1 = 1;
  for(var_2 = var_0.size; var_1; var_2--) {
    var_1 = 0;
    for(var_3 = 0; var_3 < var_2 - 1; var_3++) {
      if(compareballindexes(var_0[var_3], var_0[var_3 + 1])) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_3 + 1];
        var_0[var_3 + 1] = var_4;
        var_1 = 1;
      }
    }
  }

  return var_0;
}

compareballindexes(var_0, var_1) {
  var_2 = int(var_0.script_label);
  var_3 = int(var_1.script_label);
  if(!isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(var_2 > var_3) {
    return 1;
  }

  return 0;
}

getpasserorigin() {
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

getpasserdirection() {
  var_0 = self getplayerangles();
  var_1 = anglesToForward(var_0);
  return var_1;
}

gettargetorigin() {
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

gettargetoffset() {
  var_0 = gettargetorigin();
  return (0, 0, var_0[2] - self.origin[2]);
}

hideballsongameended() {
  level waittill("bro_shot_start");
  foreach(var_1 in level.balls) {
    var_1.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
    var_1.visuals[0] setscriptablepartstate("uplink_drone_idle", "off", 0);
    var_1.visuals[0] setscriptablepartstate("uplink_drone_tail", "off", 0);
  }
}