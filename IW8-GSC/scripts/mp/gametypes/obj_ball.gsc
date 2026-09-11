/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_ball.gsc
***********************************************/

function ball_default_origins() {
  level.default_goal_origins = [];
  level.flags = getEntArray("flag_primary", "targetname");

  foreach(var1 in level.flags) {
    switch (var1.script_label) {
      case "_a":
        level.default_goal_origins[game["attackers"]] = var1.origin;
        break;
      case "_b":
        level.default_ball_origin = var1.origin;
        break;
      case "_c":
        level.default_goal_origins[game["defenders"]] = var1.origin;
        break;
    }
  }
}

function ball_init_map_min_max() {
  level.ball_mins = (1000, 1000, 1000);
  level.ball_maxs = (-1000, -1000, -1000);
  var0 = getallnodes();

  if(var0.size > 0) {
    foreach(var2 in var0) {
      level.ball_mins = scripts\mp\spawnlogic::expandmins(level.ball_mins, var2.origin);
      level.ball_maxs = scripts\mp\spawnlogic::expandmaxs(level.ball_maxs, var2.origin);
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

  var0 = getballstarts();
  level.ball_triggers = getballtriggers();
  checkpostshipballspawns(var0);
  jumpiffalse(var0.size > 1 && level.satellitecount > 1) LOC_00000064;

  for(var1 = 0; var1 < level.satellitecount; var1++) {
    var2 = getballorigin(var0[var1]);
    ball_add_start(var2);
  }

  goto LOC_000000ea;
}

function checkpostshipballspawns(var0) {
  if(level.mapname == "mp_divide") {
    var0[0].origin = (-261, 235, 610);
    var0[1].origin = (-211, 235, 610);
    var0[2].origin = (-311, 235, 610);
    var0[3].origin = (-311, 500, 610);
    var0[4].origin = (-211, 500, 610);
    return;
  }
}

function getballstarts() {
  var0 = undefined;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var0 = scripts\engine\utility::getStructArray("tdef_ball_start", "targetname");
  }

  if(!isDefined(var0) || !var0.size) {
    var0 = scripts\engine\utility::getStructArray("ball_start", "targetname");
  }

  if(level.satellitecount > 1) {
    var0 = sortballarray(var0);
  }

  return var0;
}

function getballtriggers() {
  var0 = undefined;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var0 = getEntArray("tdef_ball_pickup", "targetname");
  }

  if(!isDefined(var0) || !var0.size) {
    var0 = getEntArray("ball_pickup", "targetname");
  }

  if(level.satellitecount > 1) {
    var0 = sortballarray(var0);
  }

  return var0;
}

function getballorigin(var0) {
  if(isDefined(var0)) {
    var1 = var0.origin;
  } else if(level.devball) {
    var1 = level.players[0].origin + (0, 0, 30);
  } else {
    var1 = level.default_ball_origin;
  }

  return var1;
}

function ball_add_start(var0) {
  var1 = 30;
  var2 = spawnStruct();
  var2.origin = var0;
  var3 = var0;
  ball_find_ground(var2);
  var2.origin = var2.ground_origin + (0, 0, var1);
  var2.in_use = 0;

  if(level.mapname == "mp_desert") {
    var3 = var2.ground_origin;
  }

  if(level.mapname == "mp_divide") {
    var3 = var2.ground_origin;
  }

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    level.ballbases[level.ballbases.size] = createballbase(var3);
  }

  level.ball_starts[level.ball_starts.size] = var2;
}

function ball_find_ground(var0) {
  var1 = self.origin + (0, 0, 32);
  var2 = self.origin + (0, 0, -1000);
  var3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var4 = [];
  var5 = scripts\engine\trace::ray_trace(var1, var2, var4, var3);
  self.ground_origin = var5["position"];
  return var5["fraction"] != 0 && var5["fraction"] != 1;
}

function createballbase(var0) {
  var1 = spawn("script_model", var0);
  var1 setModel("ctf_game_flag_base");
  var1 setasgametypeobjective();
  var1.baseeffectpos = var0;
  return var1;
}

function showballbaseeffecttoplayer(var0) {
  if(isDefined(var0._baseeffect[0])) {
    var0._baseeffect[0] delete();
  }

  var1 = undefined;
  var2 = var0.team;
  var3 = var0 ismlgspectator();

  if(var3) {
    var2 = var0 getmlgspectatorteam();
  } else if(var2 == "spectator") {
    var2 = "allies";
  }

  var4 = spawnfxforclient(level._effect["ball_base_glow"], self.baseeffectpos, var0);
  var4 setfxkilldefondelete();
  var0._baseeffect[0] = var4;
  triggerfx(var4);
}

function ball_spawn(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(isDefined(var1)) {
    var2 = spawn("script_model", var1);
  } else {
    var2 = level.ball_starts[level.balls.size];
  }

  var3 = spawn("script_model", var2.origin);
  var3 setasgametypeobjective();

  if(scripts\mp\utility\game::getgametype() == "ball" || getdvarint("scr_uplink_create_ball") == 1) {
    var3 setModel("offhand_wm_emp");
    var3 setnonstick(1);
    level.ballweapon = getcompleteweaponname("iw7_uplinkball_mp");
    level.ballpassdist = 1000000;
  } else {
    var3 setModel("offhand_wm_emp");
    var3 setnonstick(1);
    level.ballweapon = getcompleteweaponname("iw7_tdefball_mp");
    level.ballpassdist = 250000;
  }

  var4 = 32;
  var5 = undefined;

  if(isDefined(level.ball_triggers) && level.ball_triggers.size > 0) {
    var5 = level.ball_triggers[var1];
    var5.origin = var3.origin;
  } else {
    var5 = spawn("trigger_radius", var3.origin - (0, 0, var4 / 2), 0, var4, var4);
  }

  var5 enablelinkTo();
  var5 linkTo(var3);
  var5.no_moving_platfrom_unlink = 1;
  var5.linktoenabledflag = 1;
  var5.baseorigin = var5.origin;
  var5.no_moving_platfrom_unlink = 1;
  var6 = [var3];
  var7 = scripts\mp\gameobjects::createcarryobject("any", var5, var6, (0, 0, 32));
  var7.objectiveonvisuals = 1;
  var7 scripts\mp\gameobjects::allowcarry("any");
  ball_waypoint_neutral(var7);
  var7.allowweapons = 0;
  var7.carryweapon = level.ballweapon;
  var7.keepcarryweapon = 0;
  var7.visualgroundoffset = (0, 0, 30);
  var7.canuseobject = &ball_can_pickup;
  var7.onpickup = &ball_on_pickup;
  var7.setdropped = &ball_set_dropped;
  var7.onreset = &ball_on_reset;
  var7.carryweaponthink = &ball_pass_or_shoot;
  var7.in_goal = 0;
  var7.lastcarrierscored = 0;
  var7.pass = 0;
  var7.requireslos = 1;
  var7.lastcarrierteam = "none";
  var7.ballindex = level.balls.size;
  var7.playeroutlineid = undefined;
  var7.playeroutlined = undefined;
  var7.passtargetoutlineid = undefined;
  var7.passtargetent = undefined;
  var7.visuals[0] fixlinktointerpolationbug(1);

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var7 scripts\mp\gameobjects::setvisibleteam("friendly");
        var7.objidpingfriendly = 0;
        var7.objidpingenemy = 1;
        var7.objpingdelay = 60;
        break;
      case 1:
        var7 scripts\mp\gameobjects::setvisibleteam("any");
        var7.objidpingfriendly = 0;
        var7.objidpingenemy = 0;
        var7.objpingdelay = 0.05;
        break;
      case 2:
        var7 scripts\mp\gameobjects::setvisibleteam("any");
        var7.objidpingfriendly = 0;
        var7.objidpingenemy = 1;
        var7.objpingdelay = 1;
        break;
      case 3:
        var7 scripts\mp\gameobjects::setvisibleteam("any");
        var7.objidpingfriendly = 0;
        var7.objidpingenemy = 1;
        var7.objpingdelay = 1.5;
        break;
      case 4:
        var7 scripts\mp\gameobjects::setvisibleteam("any");
        var7.objidpingfriendly = 0;
        var7.objidpingenemy = 1;
        var7.objpingdelay = 2;
        break;
      case 5:
        var7 scripts\mp\gameobjects::setvisibleteam("any");
        var7.objidpingfriendly = 0;
        var7.objidpingenemy = 1;
        var7.objpingdelay = 3;
        break;
      case 6:
        var7 scripts\mp\gameobjects::setvisibleteam("any");
        var7.objidpingfriendly = 0;
        var7.objidpingenemy = 1;
        var7.objpingdelay = 4;
        break;
    }
  } else {
    var7 scripts\mp\gameobjects::setvisibleteam("any");
    var7.objidpingfriendly = 0;
    var7.objidpingenemy = 1;
    var7.objpingdelay = 3;
  }

  ball_assign_start(var7, var2);
  level.balls[level.balls.size] = var7;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    thread starthoveranim();
  }

  if(!istrue(level.devball)) {
    thread ball_fx_start(var7, 1);
  }

  thread ball_location_hud();
  var8 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
  var9 = physics_createcontents(var8);
  level.ballphysicscontentoverride = var9;
  level.balltraceradius = 10;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    level.balltraceradius = 20;
    return;
  }
}

function ball_can_pickup(var0) {
  if(isDefined(self.droptime) && self.droptime >= gettime()) {
    return false;
  }

  if(isPlayer(var0)) {
    if(!var0 scripts\common\utility::is_weapon_allowed()) {
      return false;
    }

    if(isDefined(var0.manuallyjoiningkillstreak) && var0.manuallyjoiningkillstreak) {
      return false;
    }

    if(istrue(var0.iscarrying)) {
      return false;
    }

    if(!valid_ball_super_pickup(var0)) {
      return false;
    }

    var1 = var0 getcurrentweapon();

    if(isDefined(var1)) {
      if(!valid_ball_pickup_weapon(var1)) {
        return false;
      }
    }

    var2 = var0.changingweapon;

    if(isDefined(var2) && var0 isswitchingweapon()) {
      if(!valid_ball_pickup_weapon(var2)) {
        return false;
      }
    }

    if(var0 scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
      var2 = var0 scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

      if(!valid_ball_pickup_weapon(var2)) {
        return false;
      }
    }

    if(var0 scripts\mp\utility\player::isusingremote()) {
      return false;
    }

    if(player_no_pickup_time(var0)) {
      return false;
    }
  } else {
    return false;
  }

  return true;
}

function ball_on_pickup(var0, var1) {
  var0 notify("obj_picked_up");
  thread checkgesturethread();
  var2 = 0;

  if(level.ballreset) {
    if(givegrabscore(var0)) {
      var0 thread scripts\mp\utility\points::giveunifiedpoints("ball_grab");
    }

    level.ballpickupscorefrozen = gettime();
    level.ballreset = 0;

    if(isDefined(level.possessionresetcondition) && level.possessionresetcondition == 1 && istrue(level.possessionresettime)) {
      var2 = 1;
    }

    var0 notify("ball_grab");
  }

  if(isDefined(level.possessionresetcondition) && level.possessionresetcondition == 2 && istrue(level.possessionresettime) && isDefined(self.lastcarrier) && self.lastcarrier != var0) {
    var2 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    if(!level.timerstoppedforgamemode) {
      level scripts\mp\gamelogic::pausetimer();
    }
  }

  if(istrue(level.possessionresetcondition)) {
    updatetimers(level, var0.team, 0, 0, var2);
  }

  level.usestartspawns = 0;
  level.codcasterball = undefined;
  level.codcasterballinitialforcevector = undefined;
  var3 = self.visuals[0] getlinkedparent();

  if(isDefined(var3)) {
    self.visuals[0] unlink();
  }

  if(!istrue(level.devball)) {
    var0 scripts\mp\utility\perk::giveperk("specialty_ballcarrier");
  }

  var0.ball_carried = self;
  var0.objective = 1;
  self.carrier scripts\mp\utility\perk::giveperk("specialty_sprintfire");
  self.carrier.hasperksprintfire = 1;

  if(!istrue(level.devball)) {
    var0 scripts\mp\lightarmor::setlightarmorvalue(var0, level.carrierarmor);
  }

  if(!istrue(level.devball)) {
    thread ball_play_local_team_sound(var0.team, "mp_uplink_ball_pickedup_friendly", "mp_uplink_ball_pickedup_enemy");
  }

  var0 scripts\common\utility::allow_usability(0);
  var0 scripts\mp\equipment::allow_equipment(0, "obj_ball");
  self.visuals[0] physicslaunchserver(self.visuals[0].origin, (0, 0, 0));
  self.visuals[0] physicsstopserver();
  self.visuals[0] scripts\mp\movers::notify_moving_platform_invalid();
  self.pass = 0;
  stop_fx_idle(self.visuals[0]);
  self.visuals[0] show();
  self.visuals[0] hide(1);
  self.visuals[0] linkTo(var0, "j_wrist_ri", (0, 0, 0), var0.angles);
  self.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  self.current_start.in_use = 0;
  var4 = 0;

  if(isDefined(self.projectile)) {
    var4 = 1;
    self.projectile delete();
  }

  var5 = var0.team;
  var6 = scripts\mp\utility\game::getotherteam(var0.team)[0];
  self.visuals[0] setotherent(var0);

  if(var4) {
    if(self.lastcarrierteam == var0.team) {
      if(!istrue(level.devball)) {
        scripts\mp\utility\dialog::statusdialog("pass_complete", var5);
      }

      var0.passtime = gettime();
      var0.passplayer = self.lastcarrier;
    } else {
      if(!istrue(level.devball)) {
        scripts\mp\utility\dialog::statusdialog("pass_intercepted", var5);
      }

      var0 thread scripts\mp\awards::givemidmatchaward("mode_uplink_intercept");

      if(isPlayer(var0)) {
        var0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup_interception", var0.origin);
      }
    }
  } else {
    if(!istrue(level.devball) && self.lastcarrierteam != var0.team) {
      scripts\mp\utility\dialog::statusdialog("ally_own_drone", var5);
      scripts\mp\utility\dialog::statusdialog("enemy_own_drone", var6);
    }

    if(isPlayer(var0)) {
      var0 thread scripts\common\utility::ref_13e0a(level.ref_11b29, "pickup", var0.origin);
    }
  }

  if(!istrue(level.devball)) {
    ball_fx_stop();
  }

  self.lastcarrierscored = 0;
  self.lastcarrier = var0;
  self.lastcarrierteam = var0.team;
  self.ownerteam = var0.team;
  ball_waypoint_held(self.ownerteam);
  var0 setweaponammoclip(level.ballweapon, 1);

  if(level.codcasterenabled) {
    var0 setgametypevip(1);
  }

  thread player_update_pass_target(var0);

  if(!istrue(level.devball)) {
    scripts\mp\gamelogic::sethasdonecombat(var0, 1);
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

function givegrabscore(var0) {
  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var1 = 15000;
  } else {
    var1 = 10000;
  }

  var2 = updatebpm(var1);

  if(var2) {
    return false;
  }

  if(isDefined(self.lastcarrier) && var1.team == self.lastcarrier.team && gettime() < level.ballpickupscorefrozen + var1) {
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

function ball_play_local_team_sound(var0, var1, var2) {
  var3 = scripts\mp\utility\game::getotherteam(var0)[0];

  foreach(var5 in level.players) {
    if(var5.team == var0) {
      var5 playlocalsound(var1);
      continue;
    }

    if(var5.team == var3) {
      var5 playlocalsound(var2);
    }
  }
}

function ball_set_dropped(var0, var1, var2, var3) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  var4 = 0;
  self.isresetting = 1;
  self.droptime = gettime();
  self notify("dropped");
  var5 = (0, 0, 0);
  var6 = self.carrier;

  if(isDefined(var6) && var6.team != "spectator") {
    var7 = var6.origin;
    var5 = var6.angles;
    var6 notify("ball_dropped");
  } else if(isDefined(var2)) {
    var7 = var2;
  } else {
    var7 = self.safeorigin;
  }

  var7 += (0, 0, 40);

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  for(var8 = 0; var8 < self.visuals.size; var8++) {
    self.visuals[var8].origin = var7;
    self.visuals[var8].angles = var7;
    self.visuals[var8] show();
    var9 = self.visuals[var8] getlinkedparent();

    if(isDefined(var9)) {
      self.visuals[var8] unlink();
    }

    self.visuals[var8] setscriptablepartstate("uplink_drone_hide", "show", 0);
  }

  if(istrue(var5) || istrue(var4)) {
    var6 = 1;
  }

  ball_carrier_cleanup(var6);

  if(!isDefined(level.scorefrozenuntil)) {
    level.scorefrozenuntil = 0;
  }

  if(level.scorefrozenuntil > 0) {
    self.trigger.origin -= (0, 0, 10000);
  } else {
    self.trigger.origin = var7;
  }

  ball_dont_interpolate();
  self.curorigin = self.trigger.origin;

  if(!istrue(level.devball)) {
    thread ball_fx_start(0);
  }

  self.ownerteam = "any";
  ball_waypoint_neutral();
  scripts\mp\gameobjects::clearcarrier();

  if(isDefined(var7)) {
    player_update_pass_target_hudoutline(var7);
  }

  scripts\mp\gameobjects::updatecompassicons();
  self.isresetting = 0;

  if(!var2) {
    var10 = self.lastcarrierteam;
    var11 = scripts\mp\utility\game::getotherteam(var10)[0];

    if(!istrue(level.devball) && !isDefined(var3) && !istrue(var4)) {
      scripts\mp\utility\dialog::statusdialog("ally_drop_drone", var10);
      scripts\mp\utility\dialog::statusdialog("enemy_drop_drone", var11);
    }

    var12 = (0, var7[1], 0);
    var13 = anglesToForward(var12);

    if(isDefined(var3)) {
      var14 = var13 * 20 + (0, 0, 80);
    } else {
      var14 = var14 * 200 + (0, 0, 80);
    }

    ball_physics_launch(var14);
  }

  var15 = spawnStruct();
  var15.carryobject = self;
  var15.deathoverridecallback = &ball_overridemovingplatformdeath;
  self.trigger thread scripts\mp\movers::handle_moving_platforms(var15);

  if(level.timerstoppedforgamemode) {
    level scripts\mp\gamelogic::resumetimer();
  }

  return true;
}

function ball_carrier_cleanup(var0) {
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

    if(istrue(var0)) {
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
  var0 = self.visuals[0];
  var0 scripts\mp\movers::notify_moving_platform_invalid();
  var1 = var0 getlinkedparent();

  if(isDefined(var1)) {
    var0 unlink();
  }

  stop_fx_idle(self.visuals[0]);
  var0 physicslaunchserver(var0.origin, (0, 0, 0));
  var0 physicsstopserver();
  ball_dont_interpolate();

  if(isDefined(self.projectile)) {
    self.projectile delete();
  }

  var2 = "none";
  var3 = self.lastcarrierteam;

  if(isDefined(var3)) {
    var2 = scripts\mp\utility\game::getotherteam(var3)[0];
  }

  self.lastcarrierteam = "none";
  ball_carrier_cleanup(1);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  ball_waypoint_download();

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    scripts\mp\gameobjects::setposition(var0.baseorigin + (0, 0, 4000), (0, 0, 0));
    var0 moveTo(var0.baseorigin, 3, 0, 3);
    var0 rotatevelocity((0, 720, 0), 3, 0, 3);
  } else {
    if(!level.timerstoppedforgamemode) {
      level scripts\mp\gamelogic::pausetimer();
    }

    var0 hide(1);
    self.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
    thread waitforreset(var0);
  }

  if(!istrue(level.devball)) {
    playsoundatpos(var0.baseorigin, "mp_uplink_ball_reset");
  }

  if(!self.lastcarrierscored && isDefined(var3) && isDefined(var2)) {
    if(!istrue(level.devball) && var3 != "none" && !istrue(level.gameended)) {
      scripts\mp\utility\dialog::statusdialog("drone_reset", var3);
      scripts\mp\utility\dialog::statusdialog("drone_reset", var2);
    }

    if(isDefined(self.lastcarrier)) {}
  }

  self.ownerteam = "any";

  if(scripts\mp\utility\game::getgametype() == "ball" || level.devball) {
    thread ball_download_wait(3);
  }

  if(!istrue(level.devball)) {
    thread ball_download_fx(var0, 3);
  }

  thread scripts\common\utility::ref_13e0a(level.ref_11b29, "obj_return", var0.baseorigin);
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
    self waittill("ball_pass", var0);

    if(var0 != level.ballweapon) {
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
    var1 = self.pass_target;
    var2 = self.pass_target.origin;
    wait 0.15;

    if(isDefined(self.pass_target)) {
      var1 = self.pass_target;
    }

    thread ball_pass_projectile(self.carryobject, self, var1);
    return;
  }
}

function ball_shoot_watch() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    var0 = getdvarfloat("scr_ball_shoot_extra_pitch", 0);
    var1 = getdvarfloat("scr_ball_shoot_force", 825);
    goto LOC_00000059;
  }

  var0 = getdvarfloat("scr_tdef_shoot_extra_pitch", -3);
  var1 = getdvarfloat("scr_tdef_shoot_force", 450);

  for(;;) {
    self waittill("weapon_fired", var2);

    if(var2 != level.ballweapon) {
      continue;
    }

    self setweaponammoclip(var2, 0);
    break;
  }

  if(isDefined(self.carryobject)) {
    thread scripts\mp\matchdata::loggameevent("pass", self.origin);

    if(!istrue(level.devball)) {
      self playSound("mp_uplink_ball_pass");
    }

    wait 0.15;

    if(self issprintsliding()) {
      var0 = -12;

      if(scripts\mp\utility\game::getgametype() == "tdef") {
        var1 += 200;
      }
    }

    var3 = self getplayerangles();
    var3 += (var0, 0, 0);
    var3 = (clamp(var3[0], -85, 85), var3[1], var3[2]);
    var4 = anglesToForward(var3);
    thread ball_pass_or_throw_active();
    thread ball_check_pass_kill_pickup(self.carryobject);
    ball_create_killcam_ent(self.carryobject);
    thread ball_physics_launch_drop(self.carryobject, var4 * var1);
    return;
  }
}

function ball_weapon_change_watch() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  thread superabilitywatcher();
  var0 = level.ballweapon;

  for(;;) {
    if(var0 == self getcurrentweapon()) {
      goto LOC_0000003c;
    }

    self waittill("weapon_change");
  }

  for(;;) {
    self waittill("weapon_change", var1);

    if(isDefined(var1) && scripts\mp\utility\weapon::issuperweapon(var1.basename)) {
      break;
    }
  }

  var2 = self getplayerangles();
  var2 = (clamp(var2[0], -85, 85), scripts\engine\utility::absangleclamp180(var2[1] + 20), var2[2]);
  var3 = anglesToForward(var2);
  var4 = 90;
  thread ball_physics_launch_drop(self.carryobject, var3 * var4, self);
}

function superabilitywatcher() {
  self endon("death_or_disconnect");
  self endon("drop_object");
  self endon("unsetBallCarrier");
  self waittill("super_started");
  var0 = self.super;

  switch (var0.staticdata.ref) {
    case "super_chargemode":
      ball_drop_on_ability();
      break;
    case "super_rewind":
      scripts\engine\utility::ref_143a5("teleport_success", "rewind_success");
      ball_drop_on_ability();
      break;
  }
}

function ball_drop_on_ability() {
  var0 = self getplayerangles();
  var0 = (clamp(var0[0], -85, 85), scripts\engine\utility::absangleclamp180(var0[1] + 20), var0[2]);
  var1 = anglesToForward(var0);
  var2 = 90;
  thread ball_physics_launch_drop(self.carryobject, var1 * var2, self);
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

function ball_physics_launch_drop(var0, var1, var2) {
  ball_set_dropped(1, undefined, 0, var2);
  ball_physics_launch(var0, var1);
}

function ball_pass_projectile(var0, var1, var2) {
  ball_set_dropped(1);

  if(isDefined(var1)) {
    var2 = var1.origin;
  }

  var3 = getpasserorigin(var0);
  var4 = getpasserdirection(var0);

  if(!validatepasstarget(self, var0, var1)) {
    var3 = self.lastvalidpassorg;
    var4 = self.lastvalidpassdir;
  }

  var5 = var4 * 30;
  var6 = var4 * 60;
  var7 = var3 + var5;
  var8 = gettargetorigin(var1);
  var9 = scripts\engine\trace::sphere_trace(var7, var8, level.balltraceradius, var0, level.ballphysicscontentoverride, 0);
  var10 = 1;

  if(var9["fraction"] < 1) {
    if(var9["hittype"] == "hittype_entity" && isDefined(var9["entity"]) && isPlayer(var9["entity"])) {
      var10 = max(0.1, 0.7 * var9["fraction"]);
    } else {
      var10 = 0.7 * var9["fraction"];
    }

    scripts\mp\gameobjects::setposition(var7 + var5 * var10, self.visuals[0].angles);
  } else {
    scripts\mp\gameobjects::setposition(var9["position"], self.visuals[0].angles);
  }

  if(isDefined(var1)) {
    self.projectile = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("uplinkball_tracking_mp"), var7 + var6 * var10, var8, var0);
    self.projectile missile_settargetEnt(var1, gettargetoffset(var1));
  }

  self.trigger.origin -= (0, 0, 10000);
  thread adjust_for_stance(var1);
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
  thread ball_track_target(var1);

  if(scripts\mp\utility\game::getgametype() == "ball") {
    thread scripts\mp\gametypes\ball::ball_pass_touch_goal();
    return;
  }
}

function player_update_pass_target(var0) {
  self endon("disconnect");
  self endon("cancel_update_pass_target");
  player_update_pass_target_hudoutline();
  GscBinSkip4(0x35);
}

function validatepasstarget(var0, var1, var2) {
  var3 = 0.85;
  var4 = getpasserorigin(var1);
  var5 = getpasserdirection(var1);
  var6 = gettargetorigin(var2);
  var7 = distancesquared(var6, var4);

  if(var7 > level.ballpassdist) {
    return false;
  }

  var8 = vectorNormalize(var6 - var4);
  var9 = vectordot(var5, var8);

  if(var9 > var3) {
    var10 = var5 * 30;
    var11 = var4 + var10;
    var12 = scripts\engine\trace::sphere_trace(var11, var6, level.balltraceradius, var1, level.ballphysicscontentoverride, 0);

    if(isDefined(var12["entity"]) && isPlayer(var12["entity"]) || var12["fraction"] > 0.8) {
      var2.pass_dot = var9;
      var0.lastvalidpassorg = var4;
      var0.lastvalidpassdir = var5;
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

  var0 = [];
  var1 = [];
  var2 = scripts\mp\utility\game::getotherteam(self.team)[0];
  var3 = undefined;
  var4 = undefined;

  foreach(var6 in level.players) {
    if(var6 == self) {
      continue;
    }

    if(var6.team == self.team) {
      var0 = var6;
      continue;
    }

    if(var6.team == var2) {
      var1 = var6;
    }
  }

  foreach(var6 in var0) {
    var9 = isDefined(self.pass_target) && self.pass_target == var6;
  }

  if(isDefined(self.pass_target)) {
    var3 = scripts\mp\utility\outline::outlineenableforplayer(self.pass_target, self, "outline_depth_cyan", "level_script");
  }

  self.carryobject.passtargetoutlineid = var3;
  self.carryobject.passtargetent = self.pass_target;

  if(scripts\mp\utility\game::getgametype() == "tdef" && var0.size > 0) {
    var4 = scripts\mp\utility\outline::outlineenableforteam(self, self.team, "outlinefill_nodepth_cyan", "level_script");
  }

  self.carryobject.playeroutlineid = var4;
  self.carryobject.playeroutlined = self;
}

function adjust_for_stance(var0) {
  var1 = self;
  var0 endon("pass_end");

  while(isDefined(var1) && isDefined(var0)) {
    var0 missile_settargetEnt(var1, gettargetoffset(var1));
    waitframe();
  }
}

function compare_player_pass_dot(var0, var1) {
  return var0.pass_dot >= var1.pass_dot;
}

function player_joined_update_pass_target_hudoutline() {}

function player_set_pass_target(var0) {
  var1 = 80;
  var2 = 0;

  if(isDefined(var0)) {
    switch (var0 getstance()) {
      case "crouch":
        var1 = 60;
        break;
      case "prone":
        var1 = 35;
        break;
    }

    if(!isDefined(self.pass_icon_offset) || self.pass_icon_offset != var1) {
      var2 = 1;
      self.pass_icon_offset = var1;
    }
  }

  var3 = (0, 0, var1);

  if(isDefined(self.pass_target) && isDefined(var0) && self.pass_target == var0) {
    if(var2) {
      self.pass_icon = var0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "waypoint_ball_pass", var1, 0, undefined, undefined, 0.05);
    }

    return;
  }

  if(!isDefined(self.pass_target) && !isDefined(var0)) {
    return;
  }

  player_clear_pass_target();

  if(isDefined(var0)) {
    self.pass_icon = var0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "waypoint_ball_pass", var1, 0, undefined, undefined, 0.05);
    self.pass_target = var0;
    var4 = [];

    foreach(var6 in level.players) {
      if(var6.team == self.team && var6 != self && var6 != var0) {
        var4 = var6;
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

  var0 = [];

  foreach(var2 in level.players) {
    if(var2.team == self.team && var2 != self) {
      var0 = var2;
    }
  }

  self.pass_target = undefined;
  self setballpassallowed(0);
  player_update_pass_target_hudoutline();
}

function player_no_pickup_time() {
  return isDefined(self.nopickuptime) && self.nopickuptime > gettime() || isDefined(self.ball_carried);
}

function valid_ball_super_pickup(var0) {
  if(!isDefined(var0.super)) {
    return true;
  }

  if(!isDefined(var0.super.isinuse) || !var0.super.isinuse) {
    return true;
  }

  return true;
}

function valid_ball_pickup_weapon(var0) {
  var1 = undefined;

  if(issameweapon(var0)) {
    if(nullweapon(var0)) {
      return false;
    }

    if(var0 == level.ballweapon) {
      return false;
    }

    var1 = var0.basename;
  }

  if(isstring(var0)) {
    if(var0 == "none") {
      return false;
    }

    if(var0 == level.ballweapon.basename) {
      return false;
    }

    var1 = var0;
  }

  if(scripts\mp\utility\killstreak::isremotekillstreakweapon(var1)) {
    return false;
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var0)) {
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
  var0 = undefined;

  for(;;) {
    if(isDefined(var0)) {
      self.lastpassdir = vectorNormalize(self.projectile.origin - var0);
    }

    var0 = self.projectile.origin;
    waitframe();
  }
}

function ball_track_pass_lifetime() {
  self.visuals[0] endon("pass_end");
  self.projectile endon("projectile_impact_player");
  self.projectile endon("death");
  var0 = gettime();

  for(var1 = var0; var1 < var0 + 2000; var1 = gettime()) {
    waitframe();
  }

  self.projectile delete();
}

function ball_track_target(var0) {
  self.visuals[0] endon("pass_end");
  self.projectile endon("projectile_impact_player");
  self.projectile endon("death");

  for(;;) {
    if(!isDefined(var0)) {
      break;
    }

    if(!scripts\mp\utility\player::isreallyalive(var0)) {
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
  var0 = self.visuals[0];

  if(!isDefined(self.carrier) && !self.in_goal) {
    if(var0.origin != var0.baseorigin + (0, 0, 4000)) {
      ball_restore_contents();

      if(!isDefined(self.lastpassdir)) {
        self.lastpassdir = (0, 0, 1);
      }

      ball_physics_launch(self.lastpassdir * 400);
    }
  }

  ball_restore_contents();
  var0 notify("pass_end");
}

function ball_on_projectile_hit_client() {
  self.visuals[0] endon("pass_end");
  self.projectile waittill("projectile_impact_player", var0);
  self.trigger.origin = self.visuals[0].origin;
  self.trigger notify("trigger", var0);
}

function ball_physics_launch(var0, var1) {
  var2 = self.visuals[0];
  var2.origin_prev = undefined;
  var3 = var2.origin;
  var4 = var2;

  if(isDefined(var1)) {
    var4 = var1;
    var3 = var1 getEye();
    var5 = anglestoright(var0);
    var3 += (var5[0], var5[1], 0) * 7;

    if(var1 issprintsliding()) {
      var3 += (0, 0, 10);
    }

    var6 = var3;
    var7 = vectorNormalize(var0) * 80;
    var8 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_vehicle", "physicscontents_player", "physicscontents_actor", "physicscontents_glass", "physicscontents_itemclip"];
    var9 = physics_createcontents(var8);
    var10 = scripts\engine\trace::sphere_trace(var6, var6 + var7, 38, var1, var9);

    if(var10["fraction"] < 1) {
      var11 = 0.7 * var10["fraction"];
      scripts\mp\gameobjects::setposition(var6 + var7 * var11, var2.angles);
    } else {
      scripts\mp\gameobjects::setposition(var10["position"], var2.angles);
    }
  }

  self.visuals[0] physicslaunchserver(var2.origin, var0);
  self.visuals[0] thread scripts\mp\utility\entity::register_physics_collisions();
  self.visuals[0] physics_registerforcollisioncallback();
  scripts\mp\utility\entity::register_physics_collision_func(self.visuals[0], &ball_impact_sounds);
  self.visuals[0].origin = self.trigger.origin;
  self.trigger linkTo(self.visuals[0]);
  level.codcasterball = self.visuals[0];
  level.codcasterballowner = var4;
  level.codcasterballinitialforcevector = var0;
  thread ball_physics_out_of_level();
  thread ball_physics_timeout(var1);
  thread ball_physics_bad_trigger_watch();

  if(scripts\mp\utility\game::getgametype() == "ball") {
    thread scripts\mp\gametypes\ball::ball_physics_touch_goal();
  }

  thread ball_physics_touch_cant_pickup_player(var1);
}

function ball_physics_touch_cant_pickup_player(var0) {
  var1 = self.visuals[0];
  var2 = self.trigger;
  self.visuals[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");

  for(;;) {
    var2 waittill("trigger", var3);

    if(!isPlayer(var3) && !isagent(var3)) {
      continue;
    }

    if(isDefined(var0) && var0 == var3 && player_no_pickup_time(var3)) {
      continue;
    }

    if(self.droptime >= gettime()) {
      continue;
    }

    if(var1.origin == var1.baseorigin + (0, 0, 4000)) {
      continue;
    }

    if(!ball_can_pickup(var3)) {
      if(player_no_pickup_time(var3)) {
        continue;
      }

      var3.nopickuptime = gettime() + 500;
      thread ball_physics_fake_bounce();
    }
  }
}

function ball_physics_fake_bounce(var0) {
  var1 = self.visuals[0];
  var2 = var1 physics_getbodyid(0);
  var3 = physics_getbodylinvel(var2);

  if(isDefined(var0) && var0) {
    var4 = length(var3) * 0.4;
    thread watchstuckinnozone();
  } else {
    var4 = length(var4) / 10;
  }

  var5 = vectorNormalize(var4);
  var5 = (-1, -1, -0.5) * var5;
  var2 physicslaunchserver(var2.origin, (0, 0, 0));
  var2 physicsstopserver();
  var2 physicslaunchserver(var2.origin, var5 * var4);
  var2.physicsactivated = 1;
}

function physics_impact_watch() {
  self endon("death");

  for(;;) {
    self waittill("projectile_impact", var0, var1, var2, var3);
    var4 = level._effect["ball_physics_impact"];

    if(isDefined(var3) && isDefined(level._effect["ball_physics_impact_" + var3])) {
      var4 = level._effect["ball_physics_impact_" + var3];
    }

    if(!istrue(level.devball)) {
      playFX(var4, var0, var1);
    }

    wait 0.3;
  }
}

function ball_impact_sounds(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = var0 physics_getbodyid(0);
  var10 = physics_getbodylinvel(var9);
  var11 = length(var10);

  if(isDefined(var0.playing_sound) || var11 < 70) {
    return;
  }

  var0 endon("death");
  var0.playing_sound = 1;
  var12 = "mp_uplink_ball_bounce";
  var0 playSound(var12);
  var13 = lookupsoundlength(var12);
  wait 0.1;
  var0.playing_sound = undefined;
}

function ball_return_home(var0, var1) {
  self.ball_fx_active = 0;

  if(istrue(var0)) {
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
  var2 = self.visuals[0];
  var2 physicslaunchserver(var2.origin, (0, 0, 0));
  var2 physicsstopserver();

  if(!istrue(level.devball)) {
    playsoundatpos(var2.origin, "mp_uplink_ball_out_of_bounds");
    playFX(scripts\engine\utility::getfx("ball_teleport"), var2.origin);
  }

  if(isDefined(self.carrier)) {
    self.carrier scripts\engine\utility::delaythread(0.05, &player_update_pass_target_hudoutline);
  }

  self.visuals[0] setscriptablepartstate("uplink_drone_hide", "show", 0);
  thread scripts\mp\gameobjects::returnhome();
}

function ball_overridemovingplatformdeath(var0) {
  ball_return_home(var0.carryobject, 0, 1);
}

function ball_download_wait(var0) {
  self endon("pickup_object");
  scripts\mp\gameobjects::allowcarry("none");
  self.isresetting = 1;
  wait var0;
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

function waitforreset(var0) {
  self endon("pickup_object");
  self endon("game_ended");
  scripts\mp\gameobjects::allowcarry("none");

  if(level.player_has_respawn_munition != 0) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.player_has_respawn_munition);
  }

  if(level.timerstoppedforgamemode) {
    level scripts\mp\gamelogic::resumetimer();
  }

  scripts\mp\gameobjects::setposition(var0.baseorigin, (0, 0, 0));
  self.visuals[0] setscriptablepartstate("uplink_drone_hide", "show", 0);
  thread ball_download_wait(0);
  var0 rotatevelocity((0, 720, 0), 3, 0, 3);
}

function starthoveranim() {
  self endon("death");
  self endon("reset");
  self endon("pickup_object");
  self notify("hoverAnimStart");
  self endon("hoverAnimStart");
  var0 = self.visuals[0].origin;
  self.visuals[0] rotateYaw(2000, 60, 0.2, 0.2);

  for(;;) {
    self.visuals[0] moveTo(var0 + (0, 0, 5), 1, 0.5, 0.5);
    wait 1;
    self.visuals[0] moveTo(var0 - (0, 0, 5), 1, 0.5, 0.5);
    wait 1;
  }
}

function ball_physics_out_of_level() {
  self endon("reset");
  self endon("pickup_object");
  var0 = self.visuals[0];
  GscBinSkip1(0x45, 0, 200);
}

function ball_physics_timeout(var0) {
  self endon("reset");
  self endon("pickup_object");
  self endon("score_event");

  if(!isDefined(level.idleresettime)) {
    level.idleresettime = 15;
  }

  var1 = level.idleresettime;
  var2 = 10;
  var3 = 3;

  if(var1 >= var2) {
    wait var3;
    var1 -= var3;
  }

  wait var1;
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
    foreach(var1 in level.nozonetriggers) {
      if(self istouching(var1)) {
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
  var0 = gettime();
  var1 = var0 + 500;

  for(;;) {
    if(touchingnozonetrigger(self.visuals[0]) && var1 < var0) {
      ball_return_home(1, 1);
      return;
    }

    wait 0.05;
    var0 = gettime();
  }
}

function ball_physics_bad_trigger_at_rest() {
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  var0 = self.visuals[0];
  var0 endon("death");
  var0 waittill("physics_finished");

  if(scripts\mp\utility\entity::touchingbadtrigger()) {
    ball_return_home(1, 1);
    return;
  }
}

function ball_location_hud() {
  for(;;) {
    var0 = scripts\engine\utility::ref_143af("pickup_object", "dropped", "reset", "ball_ready");

    switch (var0) {
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

function ball_check_pass_kill_pickup(var0) {
  self endon("death_or_disconnect");
  var0 endon("reset");
  var1 = spawnStruct();
  var1 endon("timer_done");
  thread timer_run(var1);
  var0 waittill("pickup_object");
  timer_cancel(var1);

  if(!isDefined(var0.carrier) || var0.carrier.team == self.team) {
    return;
  }

  var0.carrier endon("disconnect");
  thread timer_run(var1);
  var0.carrier waittill("death", var2);
  timer_cancel(var1);

  if(!isDefined(var2) || var2 != self) {
    return;
  }

  thread timer_run(var1);
  var0 waittill("pickup_object");
  timer_cancel(var1);

  if(isDefined(var0.carrier) && var0.carrier == self) {
    thread scripts\mp\utility\points::giveunifiedpoints("ball_pass_kill");
    return;
  }
}

function timer_run(var0) {
  self endon("cancel_timer");
  wait var0;
  self notify("timer_done");
}

function timer_cancel() {
  self notify("cancel_timer");
}

function ball_waypoint_neutral() {
  scripts\mp\gameobjects::setobjectivestatusicons("waypoint_neutral_ball", "waypoint_neutral_ball");
}

function ball_waypoint_held(var0) {
  if(scripts\mp\utility\game::getgametype() == "ball") {
    var1 = "waypoint_escort";
  } else {
    var1 = "waypoint_defend_round";
  }

  scripts\mp\gameobjects::setobjectivestatusicons(var1, "waypoint_capture_kill_round");
}

function ball_waypoint_download() {
  if(scripts\mp\utility\game::getgametype() == "ball") {
    var0 = "waypoint_ball_download";
  } else {
    var0 = "waypoint_reset_marker";
  }

  scripts\mp\gameobjects::setobjectivestatusicons(var0, var0);
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

function ball_assign_start(var0) {
  foreach(var2 in self.visuals) {
    var2.baseorigin = var0.origin;
  }

  self.trigger.baseorigin = var0.origin;
  self.current_start = var0;
  var0.in_use = 1;
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

function updatetimers(var0, var1, var2, var3) {
  if(!istrue(level.possessionresetcondition)) {
    return;
  }

  var4 = undefined;
  var5 = 1000 * level.possessionresettime;

  if(istrue(var2)) {
    if(istrue(level.player_has_respawn_munition) && !istrue(level.ballreset)) {
      var5 = 1000 * level.player_has_respawn_munition;
    }
  }

  if(istrue(var2) || istrue(var3)) {
    level.balltime = level.possessionresettime;
    level.ballendtime = int(gettime() + var5);
  } else {
    level.ballendtime = int(gettime() + 1000 * level.balltime);
  }

  setomnvar("ui_hardpoint_timer", level.ballendtime);

  if(var5 > 0 && (istrue(var3) || !var1 && level.balltimerpaused)) {
    thread ballruntimer(level.ball, var0);
  }

  if(var1) {
    pauseballtimer(level);
    return;
  }
}

function ballruntimer(var0, var1) {
  level endon("game_ended");
  level endon("reset");
  level endon("pause_ball_timer");
  level notify("ballRunTimer");
  level endon("ballRunTimer");
  level.balltimerpaused = 0;
  balltimerwait(var0, var1);

  if(!istrue(level.ballreset)) {
    scripts\mp\gameobjects::allowcarry("none");
    ball_set_dropped(1, self.trigger.origin, 1);
    ball_return_home(1, 1);
    return;
  }
}

function balltimerwait(var0, var1) {
  level endon("game_ended");
  level endon("pause_ball_timer");
  var2 = scripts\engine\utility::ter_op(isDefined(var1), var1, int(level.balltime * 1000 + gettime()));
  resumeballtimer(level, var1);
  thread watchtimerpause();
  thread handlehostmigration(level);
  waitballlongdurationwithgameendtimeupdate(level.balltime);
}

function waitballlongdurationwithgameendtimeupdate(var0) {
  level endon("game_ended");
  level endon("pause_ball_timer");

  if(var0 == 0) {
    return;
  }

  var1 = gettime();
  var2 = gettime() + var0 * 1000;

  while(gettime() < var2) {
    waittillballhostmigrationstarts((var2 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var2 += 1000;
      setgameendtime(int(var2));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var2 += 1000;
    setgameendtime(int(var2));
    wait 1;
  }

  return gettime() - var1;
}

function waittillballhostmigrationstarts(var0) {
  level endon("game_ended");
  level endon("pause_ball_timer");

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait var0;
}

function handlehostmigration(var0) {
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_objective_timer_stopped", 1);
  var1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(!level.balltimerstopped) {
    setomnvar("ui_objective_timer_stopped", 0);
  }

  if(var1 > 0) {
    setomnvar("ui_hardpoint_timer", level.ballendtime + var1);
    return;
  }

  setomnvar("ui_hardpoint_timer", level.ballendtime);
}

function watchtimerpause() {
  level endon("game_ended");
  level notify("watchResetSoon");
  level endon("watchResetSoon");
  var0 = 0;
  var1 = undefined;

  while(level.balltime > 0 && !level.balltimerpaused) {
    var2 = gettime();

    if(!var0 && level.balltime < 10) {
      foreach(var4 in level.teamnamelist) {
        level scripts\mp\utility\dialog::statusdialog("drone_reset_soon", var4);
      }

      var0 = 1;
    }

    if(isDefined(level.balls[0].carrier) && level.balltime < 5) {
      if(!isDefined(var1) || var2 > var1 + 1000) {
        var1 = var2;
      }
    }

    var6 = 0.05;
    wait var6;
    level.balltime -= var6;
  }

  if(level.balltimerpaused) {
    level notify("pause_ball_timer");
    return;
  }
}

function updateballtimerpausedness(var0) {
  var1 = level.balltimerpaused || isDefined(level.hostmigrationtimer);

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    var1 = 0;
  }

  if(!level.balltimerstopped && var1) {
    level.balltimerstopped = 1;
    setomnvar("ui_objective_timer_stopped", 1);
    return;
  }

  if(level.balltimerstopped && !var1) {
    level.balltimerstopped = 0;
    setomnvar("ui_objective_timer_stopped", 0);
    return;
  }
}

function pauseballtimer() {
  level.balltimerpaused = 1;
  updateballtimerpausedness();
}

function resumeballtimer(var0) {
  level.balltimerpaused = 0;
  updateballtimerpausedness(var0);
}

function ball_player_on_connect() {
  if(!istrue(level.devball)) {
    foreach(var1 in level.balls) {
      ball_fx_start_player(var1, self);
    }

    return;
  }
}

function ball_fx_start_player(var0) {
  if(ball_fx_active()) {
    self.visuals[0] setscriptablepartstate("uplink_drone_idle", "normal", 0);
    self.visuals[0] setscriptablepartstate("uplink_drone_tail", "normal", 0);
    return;
  }
}

function ball_fx_start(var0, var1) {
  self endon("reset");
  self endon("pickup_object");

  if(istrue(var0)) {
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

function ball_download_fx(var0, var1) {
  scripts\engine\utility::waittill_notify_or_timeout("pickup_object", var1);
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
        var0 = 40;

        switch (self getstance()) {
          case "crouch":
            var0 = 30;
            break;
          case "prone":
            var0 = 15;
            break;
        }

        level.balls[0].visuals[0] moveTo(self.origin + (0, 0, var0), 0.3, 0.15, 0.1);
        wait 0.1;
      }
    }

    wait 1;
  }
}

function practicenotify() {
  level endon("game_ended");
  self endon("disconnect");
  var0 = 1;

  for(;;) {
    if(var0) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    var0 = 0;

    if(var0) {
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

function sortballarray(var0) {
  if(!isDefined(var0) || var0.size == 0) {
    return undefined;
  }

  var1 = 1;

  for(var2 = var0.size; var1; var2--) {
    var1 = 0;

    for(var3 = 0; var3 < var2 - 1; var3++) {
      if(compareballindexes(var0[var3], var0[var3 + 1])) {
        var4 = var0[var3];
        var0 = var0[var3 + 1];
        var0 = var4;
        var1 = 1;
      }
    }
  }

  return var0;
}

function compareballindexes(var0, var1) {
  var2 = int(var0.script_label);
  var3 = int(var1.script_label);

  if(!isDefined(var2) && !isDefined(var3)) {
    return false;
  }

  if(!isDefined(var2) && isDefined(var3)) {
    return true;
  }

  if(isDefined(var2) && !isDefined(var3)) {
    return false;
  }

  if(var2 > var3) {
    return true;
  }

  return false;
}

function getpasserorigin() {
  var0 = 0;

  switch (self getstance()) {
    case "crouch":
      var0 = 5;
      break;
    case "prone":
      var0 = 10;
      break;
  }

  var1 = self getworldupreferenceangles();
  var2 = anglestoup(var1);
  var3 = self getEye() + var2 * var0;
  return var3;
}

function getpasserdirection() {
  var0 = self getplayerangles();
  var1 = anglesToForward(var0);
  return var1;
}

function gettargetorigin() {
  var0 = 10;

  switch (self getstance()) {
    case "crouch":
      var0 = 15;
      break;
    case "prone":
      var0 = 5;
      break;
  }

  var1 = self getworldupreferenceangles();
  var2 = anglestoup(var1);
  var3 = self gettagorigin("j_spinelower", 1, 1);
  var4 = var3 + var2 * var0;
  return var4;
}

function gettargetoffset() {
  var0 = gettargetorigin();
  return (0, 0, var0[2] - self.origin[2]);
}