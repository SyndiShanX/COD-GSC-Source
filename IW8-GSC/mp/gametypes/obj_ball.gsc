/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\obj_ball.gsc
***********************************************/

ball_default_origins() {
  level.default_goal_origins = [];
  level.flags = getEntArray("_encstr_82170DCC8D2CB37D389C2DB685275E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.flags) {
    switch (var_1.script_label) {
      case "_encstr_B20703DFCF":
        level.default_goal_origins[game["_encstr_991C0AB9ED5B57161FE89B83"]] = var_1.origin;
        break;
      case "_encstr_B40703E96D":
        level.default_ball_origin = var_1.origin;
        break;
      case "_encstr_B6070359BA":
        level.default_goal_origins[game["_encstr_B6A70A23CA6659DC91CAE4DC"]] = var_1.origin;
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
  } else {
    level.ball_mins = level.spawnmins;
    level.ball_maxs = level.spawnmaxs;
  }
}

ball_create_ball_starts() {
  if(!isDefined(level.devball))
    level.devball = 0;

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

  level thread scripts\mp\utility\entity::global_physics_sound_monitor();
}

checkpostshipballspawns(var_0) {
  if(level.mapname == "_encstr_96C70AB7F9A03CC33324F4EA") {
    var_0[0].origin = (-261, 235, 610);
    var_0[1].origin = (-211, 235, 610);
    var_0[2].origin = (-311, 235, 610);
    var_0[3].origin = (-311, 500, 610);
    var_0[4].origin = (-211, 500, 610);
  }
}

getballstarts() {
  var_0 = undefined;

  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
    var_0 = scripts\engine\utility::getStructArray("_encstr_B20910F44DD1E3A1B560A29AA9AF23B76B2D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0) || !var_0.size)
    var_0 = scripts\engine\utility::getStructArray("_encstr_95CB0B73BF207199264BC14375", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(level.satellitecount > 1)
    var_0 = sortballarray(var_0);

  return var_0;
}

getballtriggers() {
  var_0 = undefined;

  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
    var_0 = getEntArray("_encstr_88141143B039FE696517B5AD102942838050CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(var_0) || !var_0.size)
    var_0 = getEntArray("_encstr_B1F80C430BF1029F3898767C3310", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(level.satellitecount > 1)
    var_0 = sortballarray(var_0);

  return var_0;
}

getballorigin(var_0) {
  if(isDefined(var_0))
    var_1 = var_0.origin;
  else if(level.devball)
    var_1 = level.players[0].origin + (0, 0, 30);
  else
    var_1 = level.default_ball_origin;

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

  if(level.mapname == "_encstr_87730AB5E0BE8CACE62BC91D")
    var_3 = var_2.ground_origin;

  if(level.mapname == "_encstr_96C70AB7F9A03CC33324F4EA")
    var_3 = var_2.ground_origin;

  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
    level.ballbases[level.ballbases.size] = createballbase(var_3);

  level.ball_starts[level.ball_starts.size] = var_2;
}

ball_find_ground(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\engine\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\engine\trace::ray_trace(var_1, var_2, var_4, var_3);
  self.ground_origin = var_5["_encstr_BD260953AA97E3F014279D"];
  return var_5["_encstr_A53009A25003666B9818C6"] != 0 && var_5["_encstr_A53009A25003666B9818C6"] != 1;
}

createballbase(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_1 setModel("_encstr_A56913CF75743E17E7397139EFCD689C6F32567259");
  var_1 setasgametypeobjective();
  var_1.baseeffectpos = var_0;
  return var_1;
}

showballbaseeffecttoplayer(var_0) {
  if(isDefined(var_0._baseeffect[0]))
    var_0._baseeffect[0] delete();

  var_1 = undefined;
  var_2 = var_0.team;
  var_3 = var_0 ismlgspectator();

  if(var_3)
    var_2 = var_0 getmlgspectatorteam();
  else if(var_2 == "_encstr_AF8C0A1B6A1D6045925B4F7D")
    var_2 = "_encstr_9A8507BA4040188D08";

  var_4 = spawnfxforclient(level._effect["_encstr_82340FC40B6363F5C4859B95BED91B7BDD"], self.baseeffectpos, var_0);
  var_4 setfxkilldefondelete();
  var_0._baseeffect[0] = var_4;
  triggerfx(var_4);
}

ball_spawn(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(var_1))
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  else
    var_2 = level.ball_starts[level.balls.size];

  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2.origin);
  var_3 setasgametypeobjective();

  if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB" || getdvarint("_encstr_92D2177FFB0A69354B4250B8DA1FE6D86751C9DB5F76D0F103") == 1) {
    var_3 setModel("_encstr_B1B00F6FD637E8171BDA7E635207DD084A");
    var_3 setnonstick(1);
    level.ballweapon = getcompleteweaponname("_encstr_92D5124BEF5B69354B4250B8DAEBE728256FFBF1");
    level.ballpassdist = 1000000;
  } else {
    var_3 setModel("_encstr_B1B00F6FD637E8171BDA7E635207DD084A");
    var_3 setnonstick(1);
    level.ballweapon = getcompleteweaponname("_encstr_A17810A09B234F7B6B65343E7993A0871D53");
    level.ballpassdist = 250000;
  }

  var_4 = 32;
  var_5 = undefined;

  if(isDefined(level.ball_triggers) && level.ball_triggers.size > 0) {
    var_5 = level.ball_triggers[var_0];
    var_5.origin = var_3.origin;
  } else
    var_5 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", var_3.origin - (0, 0, var_4 / 2), 0, var_4, var_4);

  var_5 enablelinkTo();
  var_5 linkTo(var_3);
  var_5.no_moving_platfrom_unlink = 1;
  var_5.linktoenabledflag = 1;
  var_5.baseorigin = var_5.origin;
  var_5.no_moving_platfrom_unlink = 1;
  var_6 = [var_3];
  var_7 = scripts\mp\gameobjects::createcarryobject("_encstr_9A19040BCDBC", var_5, var_6, (0, 0, 32));
  var_7.objectiveonvisuals = 1;
  var_7 scripts\mp\gameobjects::allowcarry("_encstr_9A19040BCDBC");
  var_7 ball_waypoint_neutral();
  var_7.allowweapons = 0;
  var_7.carryweapon = level.ballweapon;
  var_7.keepcarryweapon = 0;
  var_7.visualgroundoffset = (0, 0, 30);
  var_7.canuseobject = ::ball_can_pickup;
  var_7.onpickup = ::ball_on_pickup;
  var_7.setdropped = ::ball_set_dropped;
  var_7.onreset = ::ball_on_reset;
  var_7.carryweaponthink = ::ball_pass_or_shoot;
  var_7.in_goal = 0;
  var_7.lastcarrierscored = 0;
  var_7.pass = 0;
  var_7.requireslos = 1;
  var_7.lastcarrierteam = "_encstr_8BBA05185F8B99";
  var_7.ballindex = level.balls.size;
  var_7.playeroutlineid = undefined;
  var_7.playeroutlined = undefined;
  var_7.passtargetoutlineid = undefined;
  var_7.passtargetent = undefined;
  var_7.visuals[0] fixlinktointerpolationbug(1);

  if(isDefined(level.showenemycarrier)) {
    switch (level.showenemycarrier) {
      case 0:
        var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_ACFC091AE8AB2FCBE15119");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 60.0;
        break;
      case 1:
        var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 0;
        var_7.objpingdelay = 0.05;
        break;
      case 2:
        var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 1.0;
        break;
      case 3:
        var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 1.5;
        break;
      case 4:
        var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 2.0;
        break;
      case 5:
        var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 3.0;
        break;
      case 6:
        var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
        var_7.objidpingfriendly = 0;
        var_7.objidpingenemy = 1;
        var_7.objpingdelay = 4.0;
        break;
    }
  } else {
    var_7 scripts\mp\gameobjects::setvisibleteam("_encstr_9A19040BCDBC");
    var_7.objidpingfriendly = 0;
    var_7.objidpingenemy = 1;
    var_7.objpingdelay = 3.0;
  }

  var_7 ball_assign_start(var_2);
  level.balls[level.balls.size] = var_7;

  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
    level.balls[0] thread starthoveranim();

  if(!istrue(level.devball))
    var_7 thread ball_fx_start(1, 1);

  var_7 thread ball_location_hud();
  var_8 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9"];
  var_9 = physics_createcontents(var_8);
  level.ballphysicscontentoverride = var_9;
  level.balltraceradius = 10;

  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
    level.balltraceradius = 20;
}

ball_can_pickup(var_0) {
  if(isDefined(self.droptime) && self.droptime >= gettime())
    return 0;

  if(isPlayer(var_0)) {
    if(!var_0 scripts\common\utility::is_weapon_allowed())
      return 0;

    if(isDefined(var_0.manuallyjoiningkillstreak) && var_0.manuallyjoiningkillstreak)
      return 0;

    if(istrue(var_0.iscarrying))
      return 0;

    if(!valid_ball_super_pickup(var_0))
      return 0;

    var_1 = var_0 getcurrentweapon();

    if(isDefined(var_1)) {
      if(!valid_ball_pickup_weapon(var_1))
        return 0;
    }

    var_2 = var_0.changingweapon;

    if(isDefined(var_2) && var_0 isswitchingweapon()) {
      if(!valid_ball_pickup_weapon(var_2))
        return 0;
    }

    if(var_0 scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
      var_2 = var_0 scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

      if(!valid_ball_pickup_weapon(var_2))
        return 0;
    }

    if(var_0 scripts\mp\utility\player::isusingremote())
      return 0;

    if(var_0 player_no_pickup_time())
      return 0;
  } else
    return 0;

  return 1;
}

ball_on_pickup(var_0, var_1) {
  var_0 notify("_encstr_BD920E0FA530B1ABDB19CAD2013877B2");
  var_0 thread checkgesturethread();
  var_2 = 0;

  if(level.ballreset) {
    if(givegrabscore(var_0))
      var_0 thread scripts\mp\utility\points::giveunifiedpoints("_encstr_8D9D0A8958C6B17DCE3916C4");

    level.ballpickupscorefrozen = gettime();
    level.ballreset = 0;

    if(isDefined(level.possessionresetcondition) && level.possessionresetcondition == 1 && istrue(level.possessionresettime))
      var_2 = 1;

    var_0 notify("_encstr_8D9D0A8958C6B17DCE3916C4");
  }

  if(isDefined(level.possessionresetcondition) && level.possessionresetcondition == 2 && istrue(level.possessionresettime) && isDefined(self.lastcarrier) && self.lastcarrier != var_0)
    var_2 = 1;

  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7") {
    if(!level.timerstoppedforgamemode)
      level scripts\mp\gamelogic::pausetimer();
  }

  if(istrue(level.possessionresetcondition))
    level updatetimers(var_0.team, 0, 0, var_2);

  level.usestartspawns = 0;
  level.codcasterball = undefined;
  level.codcasterballinitialforcevector = undefined;
  var_3 = self.visuals[0] getlinkedparent();

  if(isDefined(var_3))
    self.visuals[0] unlink();

  if(!istrue(level.devball))
    var_0 scripts\mp\utility\perk::giveperk("_encstr_856116425A77FE69B6C9D4D276358FF0932F5343B3140193");

  var_0.ball_carried = self;
  var_0.objective = 1;
  self.carrier scripts\mp\utility\perk::giveperk("_encstr_ADBE1520D8B843E906A483BA51C3791B2DB02C51D1FB40");
  self.carrier.hasperksprintfire = 1;

  if(!istrue(level.devball))
    var_0 scripts\mp\lightarmor::setlightarmorvalue(var_0, level.carrierarmor);

  if(!istrue(level.devball))
    thread ball_play_local_team_sound(var_0.team, "_encstr_8C20211D7FF71B20D810DBC78931E95279AFA2946E27527C83C027EB1888A53A312168", "_encstr_91411E3D77A69F5A9970D29AD9DD56B37848A8A106C8076783D0C972783B8D5F");

  var_0 scripts\common\utility::allow_usability(0);
  var_0 scripts\mp\equipment::allow_equipment(0, "_encstr_880809D8F6CAD72901EB30");
  self.visuals[0] physicslaunchserver(self.visuals[0].origin, (0, 0, 0));
  self.visuals[0] physicsstopserver();
  self.visuals[0] scripts\mp\movers::notify_moving_platform_invalid();
  self.pass = 0;
  self.visuals[0] stop_fx_idle();
  self.visuals[0] show();
  self.visuals[0] hide(1);
  self.visuals[0] linkTo(var_0, "_encstr_83190BED4757A3B3B20C5E83E0", (0, 0, 0), var_0.angles);
  self.visuals[0] setscriptablepartstate("_encstr_B2AD12ABC9D193139767C1E6D8C525999852CC87", "_encstr_BECC055CF3811A", 0);
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
      if(!istrue(level.devball))
        scripts\mp\utility\dialog::statusdialog("_encstr_B6780E1C2C37CDF5D8B75B8363B2E8CA", var_5);

      var_0.passtime = gettime();
      var_0.passplayer = self.lastcarrier;
    } else {
      if(!istrue(level.devball))
        scripts\mp\utility\dialog::statusdialog("_encstr_ACC211A359872B261B2D8B57032ED10B0B3099", var_5);

      var_0 thread scripts\mp\awards::givemidmatchaward("_encstr_9AF2166BB719B27DAB831B9637D6D7B473A3CAC936590E8E");

      if(isPlayer(var_0))
        var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_B1F114C8EF2B28AB3BE19B100342ED91952370880FCE", var_0.origin);
    }
  } else {
    if(!istrue(level.devball) && self.lastcarrierteam != var_0.team) {
      scripts\mp\utility\dialog::statusdialog("_encstr_9B260FA238815F69B827BE8729782DBBBD", var_5);
      scripts\mp\utility\dialog::statusdialog("_encstr_8EF410059E306533A830A79D117462B74338", var_6);
    }

    if(isPlayer(var_0))
      var_0 thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_A31C07E04BD8ADABE0", var_0.origin);
  }

  if(!istrue(level.devball))
    ball_fx_stop();

  self.lastcarrierscored = 0;
  self.lastcarrier = var_0;
  self.lastcarrierteam = var_0.team;
  self.ownerteam = var_0.team;
  ball_waypoint_held(self.ownerteam);
  var_0 setweaponammoclip(level.ballweapon, 1);

  if(level.codcasterenabled)
    var_0 setgametypevip(1);

  var_0 thread player_update_pass_target(self);

  if(!istrue(level.devball))
    scripts\mp\gamelogic::sethasdonecombat(var_0, 1);

  self notify("_encstr_9B30109FF3214763228FEE13900D3DF0B308");
}

checkgesturethread() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  waitframe();

  if(isDefined(self.gestureweapon) && self isgestureplaying(self.gestureweapon))
    self stopgestureviewmodel(self.gestureweapon, 0.05, 1);
}

detonateball() {}

givegrabscore(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
    var_1 = 15000;
  else
    var_1 = 10000;

  var_2 = var_0 updatebpm();

  if(var_2)
    return 0;

  if(isDefined(self.lastcarrier) && var_0.team == self.lastcarrier.team && gettime() < level.ballpickupscorefrozen + var_1)
    return 0;

  return 1;
}

updatebpm() {
  if(!isDefined(self.bpm)) {
    self.numgrabs = 0;
    self.bpm = 0;
  }

  self.numgrabs++;

  if(scripts\mp\utility\game::getminutespassed() < 1)
    return 0;

  self.bpm = self.numgrabs / scripts\mp\utility\game::getminutespassed();

  if(self.bpm < 4)
    return 0;
  else
    return 1;
}

ball_play_local_team_sound(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\game::getotherteam(var_0)[0];

  foreach(var_5 in level.players) {
    if(var_5.team == var_0) {
      var_5 playlocalsound(var_1);
      continue;
    }

    if(var_5.team == var_3)
      var_5 playlocalsound(var_2);
  }
}

ball_set_dropped(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_4 = 0;
  self.isresetting = 1;
  self.droptime = gettime();
  self notify("_encstr_88C60846397B83835919");
  var_5 = (0, 0, 0);
  var_6 = self.carrier;

  if(isDefined(var_6) && var_6.team != "_encstr_AF8C0A1B6A1D6045925B4F7D") {
    var_7 = var_6.origin;
    var_5 = var_6.angles;
    var_6 notify("_encstr_922C0D1DB9CDB0605BE350BBAB37A5");
  } else if(isDefined(var_1))
    var_7 = var_1;
  else
    var_7 = self.safeorigin;

  var_7 = var_7 + (0, 0, 40);

  if(isDefined(self.projectile))
    self.projectile delete();

  for(var_8 = 0; var_8 < self.visuals.size; var_8++) {
    self.visuals[var_8].origin = var_7;
    self.visuals[var_8].angles = var_5;
    self.visuals[var_8] show();
    var_9 = self.visuals[var_8] getlinkedparent();

    if(isDefined(var_9))
      self.visuals[var_8] unlink();

    self.visuals[var_8] setscriptablepartstate("_encstr_B2AD12ABC9D193139767C1E6D8C525999852CC87", "_encstr_BD1805CB69C063", 0);
  }

  if(istrue(var_3) || istrue(var_2))
    var_4 = 1;

  ball_carrier_cleanup(var_4);

  if(!isDefined(level.scorefrozenuntil))
    level.scorefrozenuntil = 0;

  if(level.scorefrozenuntil > 0)
    self.trigger.origin = self.trigger.origin - (0, 0, 10000);
  else
    self.trigger.origin = var_7;

  ball_dont_interpolate();
  self.curorigin = self.trigger.origin;

  if(!istrue(level.devball))
    thread ball_fx_start(0);

  self.ownerteam = "_encstr_9A19040BCDBC";
  ball_waypoint_neutral();
  scripts\mp\gameobjects::clearcarrier();

  if(isDefined(var_6))
    var_6 player_update_pass_target_hudoutline();

  scripts\mp\gameobjects::updatecompassicons();
  self.isresetting = 0;

  if(!var_0) {
    var_10 = self.lastcarrierteam;
    var_11 = scripts\mp\utility\game::getotherteam(var_10)[0];

    if(!istrue(level.devball) && !isDefined(var_1) && !istrue(var_2)) {
      scripts\mp\utility\dialog::statusdialog("_encstr_8C92102F855A6B7EF443F8F80F0C138FA26F", var_10);
      scripts\mp\utility\dialog::statusdialog("_encstr_AB1C118D35C0B517587123FA1BB0BBAA388D05", var_11);
    }

    var_12 = (0, var_5[1], 0);
    var_13 = anglesToForward(var_12);

    if(isDefined(var_1))
      var_14 = var_13 * 20 + (0, 0, 80);
    else
      var_14 = var_13 * 200 + (0, 0, 80);

    ball_physics_launch(var_14);
  }

  var_15 = spawnStruct();
  var_15.carryobject = self;
  var_15.deathoverridecallback = ::ball_overridemovingplatformdeath;
  self.trigger thread scripts\mp\movers::handle_moving_platforms(var_15);

  if(level.timerstoppedforgamemode)
    level scripts\mp\gamelogic::resumetimer();

  return 1;
}

ball_carrier_cleanup(var_0) {
  if(isDefined(self.carrier)) {
    self.carrier.balldropdelay = undefined;
    self.carrier.nopickuptime = gettime() + 500;
    self.carrier player_clear_pass_target();
    self.carrier notify("_encstr_88821A360BB98D5963F55707198547ACF5C1B0CD377DE885C9B3CA47");
    self.carrier.ball_carried = undefined;

    if(!istrue(level.devball)) {
      self.carrier scripts\mp\utility\perk::removeperk("_encstr_856116425A77FE69B6C9D4D276358FF0932F5343B3140193");
      self.carrier scripts\mp\lightarmor::lightarmor_unset(self.carrier);
    }

    if(self.carrier.hasperksprintfire)
      self.carrier scripts\mp\utility\perk::removeperk("_encstr_ADBE1520D8B843E906A483BA51C3791B2DB02C51D1FB40");

    self.carrier.hasperksprintfire = 0;

    if(level.codcasterenabled)
      self.carrier setgametypevip(0);

    self.carrier scripts\common\utility::allow_usability(1);

    if(istrue(var_0))
      self.carrier scripts\mp\equipment::allow_equipment(1, "_encstr_880809D8F6CAD72901EB30");

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

  if(isDefined(var_1))
    var_0 unlink();

  self.visuals[0] stop_fx_idle();
  var_0 physicslaunchserver(var_0.origin, (0, 0, 0));
  var_0 physicsstopserver();
  ball_dont_interpolate();

  if(isDefined(self.projectile))
    self.projectile delete();

  var_2 = "_encstr_8BBA05185F8B99";
  var_3 = self.lastcarrierteam;

  if(isDefined(var_3))
    var_2 = scripts\mp\utility\game::getotherteam(var_3)[0];

  self.lastcarrierteam = "_encstr_8BBA05185F8B99";
  ball_carrier_cleanup(1);
  self.trigger scripts\mp\movers::stop_handling_moving_platforms();
  ball_waypoint_download();

  if(scripts\mp\utility\game::getgametype() != "_encstr_85EF050CB150E7") {
    scripts\mp\gameobjects::setposition(var_0.baseorigin + (0, 0, 4000), (0, 0, 0));
    var_0 moveTo(var_0.baseorigin, 3, 0, 3);
    var_0 rotatevelocity((0, 720, 0), 3, 0, 3);
  } else {
    if(!level.timerstoppedforgamemode)
      level scripts\mp\gamelogic::pausetimer();

    var_0 hide(1);
    self.visuals[0] setscriptablepartstate("_encstr_B2AD12ABC9D193139767C1E6D8C525999852CC87", "_encstr_BECC055CF3811A", 0);
    thread waitforreset(var_0);
  }

  if(!istrue(level.devball))
    playsoundatpos(var_0.baseorigin, "_encstr_9BC115E5BF6E5762A1388AD2A1951E8BA0B0626556711B");

  if(!self.lastcarrierscored && isDefined(var_3) && isDefined(var_2)) {
    if(!istrue(level.devball) && var_3 != "_encstr_8BBA05185F8B99" && !istrue(level.gameended)) {
      scripts\mp\utility\dialog::statusdialog("_encstr_8BA20C24BBED0B3DB942D51BD77B", var_3);
      scripts\mp\utility\dialog::statusdialog("_encstr_8BA20C24BBED0B3DB942D51BD77B", var_2);
    }

    if(isDefined(self.lastcarrier)) {}
  }

  self.ownerteam = "_encstr_9A19040BCDBC";

  if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB" || level.devball)
    thread ball_download_wait(3);

  if(!istrue(level.devball))
    thread ball_download_fx(var_0, 3);

  thread scripts\common\utility::_id_13E0A(level._id_11B29, "_encstr_AD620BCF8E92F1DBC5B8552DB5", var_0.baseorigin);
}

ball_clear_contents() {
  self.visuals[0] notsolid();
}

ball_pass_or_shoot() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread ball_pass_watch();
  thread ball_shoot_watch();
  thread ball_weapon_change_watch();
  self.carryobject waittill("_encstr_88C60846397B83835919");
}

ball_pass_watch() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");

  for(;;) {
    self waittill("_encstr_99FC0AAE19505CD91FE3D7DF", var_0);

    if(var_0 != level.ballweapon) {
      continue;
    }
    if(!isDefined(self.pass_target)) {
      self iprintlnbold("_encstr_AA010FA967F8DF13FB1AAF9DF6835721F4");
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

    if(isDefined(self.pass_target))
      var_1 = self.pass_target;

    self.carryobject thread ball_pass_projectile(self, var_1, var_2);
  }
}

ball_shoot_watch() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");

  if(scripts\mp\utility\game::getgametype() != "_encstr_85EF050CB150E7") {
    var_0 = getdvarfloat("_encstr_A5DF1B9EFE039F5179A368F9379808078B691DA3935BABBE308FB0E043", 0);
    var_1 = getdvarfloat("_encstr_88451577F31271B607BAF88653FBF8382B77D5D78A3EF8", 825);
  } else {
    var_0 = getdvarfloat("_encstr_A2FC1BDB81D68FEBD8CB6E4FFF60F5877DBE32F30BAE2F69503B747BE1", -3);
    var_1 = getdvarfloat("_encstr_A514156A065D49B449E04BA778E097F2F9B0B7E576A722", 450);
  }

  for(;;) {
    self waittill("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19", var_2);

    if(var_2 != level.ballweapon) {
      continue;
    }
    self setweaponammoclip(var_2, 0);
    break;
  }

  if(isDefined(self.carryobject)) {
    thread scripts\mp\matchdata::loggameevent("_encstr_9B0D05E058E6CD", self.origin);

    if(!istrue(level.devball))
      self playSound("_encstr_A1E514B30F36D85078E0F5AFE7A966F488F82BB6AF4A");

    wait 0.15;

    if(self issprintsliding()) {
      var_0 = -12;

      if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7")
        var_1 = var_1 + 200;
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
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  thread superabilitywatcher();
  var_0 = level.ballweapon;

  for(;;) {
    if(var_0 == self getcurrentweapon()) {
      break;
    }

    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
  }

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);

    if(isDefined(var_1) && scripts\mp\utility\weapon::issuperweapon(var_1.basename)) {
      break;
    }
  }

  var_2 = self getplayerangles();
  var_2 = (clamp(var_2[0], -85, 85), scripts\engine\utility::absangleclamp180(var_2[1] + 20), var_2[2]);
  var_3 = anglesToForward(var_2);
  var_4 = 90;
  self.carryobject thread ball_physics_launch_drop(var_3 * var_4, self, 1);
}

superabilitywatcher() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  self endon("_encstr_A51C117722EE451B8AC90981AE56B2D2682DC0");
  self waittill("_encstr_97E30E6EAB1CCA93D76EE816E4479591");
  var_0 = self.super;

  switch (var_0.staticdata.ref) {
    case "_encstr_BD3A11D01B529B1B270353DF0A1F21437DF2E8":
      ball_drop_on_ability();
      break;
    case "_encstr_95520DE37BEF4F42190D958FD3780F":
      scripts\engine\utility::_id_143A5("_encstr_A70C11FBDB18F112183BD3709A1B62A6D0FF3A", "_encstr_AF260FA86AE39388DB0FEEE50BFFD16F4A");
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
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self.pass_or_throw_active = 1;
  self allowmelee(0);

  while(level.ballweapon == self getcurrentweapon())
    waitframe();

  self allowmelee(1);
  self.pass_or_throw_active = 0;
  scripts\mp\equipment::allow_equipment(1, "_encstr_880809D8F6CAD72901EB30");
}

ball_physics_launch_drop(var_0, var_1, var_2) {
  ball_set_dropped(1, undefined, 0, var_2);
  ball_physics_launch(var_0, var_1);
}

ball_pass_projectile(var_0, var_1, var_2) {
  ball_set_dropped(1);

  if(isDefined(var_1))
    var_2 = var_1.origin;

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
  var_9 = scripts\engine\trace::sphere_trace(var_7, var_8, level.balltraceradius, var_0, level.ballphysicscontentoverride, 0);
  var_10 = 1.0;

  if(var_9["_encstr_A53009A25003666B9818C6"] < 1) {
    if(var_9["_encstr_AA1C0886968EA32FE056"] == "_encstr_88D90F8067B4334BB3F7082D0DCB53FB11" && isDefined(var_9["_encstr_850E077B0BF30318B9"]) && isPlayer(var_9["_encstr_850E077B0BF30318B9"]))
      var_10 = max(0.1, 0.7 * var_9["_encstr_A53009A25003666B9818C6"]);
    else
      var_10 = 0.7 * var_9["_encstr_A53009A25003666B9818C6"];

    scripts\mp\gameobjects::setposition(var_7 + var_5 * var_10, self.visuals[0].angles);
  } else
    scripts\mp\gameobjects::setposition(var_9["_encstr_BD260953AA97E3F014279D"], self.visuals[0].angles);

  if(isDefined(var_1)) {
    self.projectile = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_8FD117D5388D9637AD8985361BAFE8C98536B6D29BCEF56B83"), var_7 + var_6 * var_10, var_8, var_0);
    self.projectile missile_settargetEnt(var_1, var_1 gettargetoffset());
  }

  self.trigger.origin = self.trigger.origin - (0, 0, 10000);
  var_1 thread adjust_for_stance(self.projectile);
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

  if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB")
    thread _encstr_AD5D1EB9D8935AE08E9BE55BE0CBD9586B591D2F1C59DCCB13851B1B5C76B91B::ball_pass_touch_goal();
}

player_update_pass_target(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88821A360BB98D5963F55707198547ACF5C1B0CD377DE885C9B3CA47");
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
        if(!scripts\mp\utility\player::isreallyalive(var_4)) {
          continue;
        }
        if(!var_0 ball_can_pickup(var_4)) {
          continue;
        }
        if(validatepasstarget(var_0, self, var_4))
          var_2[var_2.size] = var_4;
      }

      if(isDefined(var_2) && var_2.size > 0) {
        var_2 = scripts\mp\utility\script::quicksort(var_2, ::compare_player_pass_dot);
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
    waitframe();
  }
}

validatepasstarget(var_0, var_1, var_2) {
  var_3 = 0.85;
  var_4 = var_1 getpasserorigin();
  var_5 = var_1 getpasserdirection();
  var_6 = var_2 gettargetorigin();
  var_7 = distancesquared(var_6, var_4);

  if(var_7 > level.ballpassdist)
    return 0;

  var_8 = vectorNormalize(var_6 - var_4);
  var_9 = vectordot(var_5, var_8);

  if(var_9 > var_3) {
    var_10 = var_5 * 30;
    var_11 = var_4 + var_10;
    var_12 = scripts\engine\trace::sphere_trace(var_11, var_6, level.balltraceradius, var_1, level.ballphysicscontentoverride, 0);

    if(isDefined(var_12["_encstr_850E077B0BF30318B9"]) && isPlayer(var_12["_encstr_850E077B0BF30318B9"]) || var_12["_encstr_A53009A25003666B9818C6"] > 0.8) {
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
      var_0[var_0.size] = var_6;
      continue;
    }

    if(var_6.team == var_2)
      var_1[var_1.size] = var_6;
  }

  foreach(var_6 in var_0)
  var_9 = isDefined(self.pass_target) && self.pass_target == var_6;

  if(isDefined(self.pass_target))
    var_3 = scripts\mp\utility\outline::outlineenableforplayer(self.pass_target, self, "_encstr_9B9D132773AD52F9F829A96FC1E02CCA90F7C797DD", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

  self.carryobject.passtargetoutlineid = var_3;
  self.carryobject.passtargetent = self.pass_target;

  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7" && var_0.size > 0)
    var_4 = scripts\mp\utility\outline::outlineenableforteam(self, self.team, "_encstr_A7DA197F2B857AD1C0013FC418E8DF92D091DFFBC123F19310E935", "_encstr_AC760D7A6AE6A9501F43EF73238A0C");

  self.carryobject.playeroutlineid = var_4;
  self.carryobject.playeroutlined = self;
}

adjust_for_stance(var_0) {
  var_1 = self;
  var_0 endon("_encstr_B8FE09888F7B6BBFAA6DDD");

  while(isDefined(var_1) && isDefined(var_0)) {
    var_0 missile_settargetEnt(var_1, var_1 gettargetoffset());
    waitframe();
  }
}

compare_player_pass_dot(var_0, var_1) {
  return var_0.pass_dot >= var_1.pass_dot;
}

player_joined_update_pass_target_hudoutline() {}

player_set_pass_target(var_0) {
  var_1 = 80;
  var_2 = 0;

  if(isDefined(var_0)) {
    switch (var_0 getstance()) {
      case "_encstr_B13D076BED70539F23":
        var_1 = 60;
        break;
      case "_encstr_922406F1A6FD5E05":
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
    if(var_2)
      self.pass_icon = var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "_encstr_BDA413274F5BF7A8B1456B066E616821D1F383B7AF", var_1, 0, undefined, undefined, 0.05);

    return;
  }

  if(!isDefined(self.pass_target) && !isDefined(var_0)) {
    return;
  }
  player_clear_pass_target();

  if(isDefined(var_0)) {
    self.pass_icon = var_0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "_encstr_BDA413274F5BF7A8B1456B066E616821D1F383B7AF", var_1, 0, undefined, undefined, 0.05);
    self.pass_target = var_0;
    var_4 = [];

    foreach(var_6 in level.players) {
      if(var_6.team == self.team && var_6 != self && var_6 != var_0)
        var_4[var_4.size] = var_6;
    }

    self setballpassallowed(1);
  }

  player_update_pass_target_hudoutline();
}

player_clear_pass_target() {
  if(isDefined(self.pass_icon))
    self.pass_icon destroy();

  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.team == self.team && var_2 != self)
      var_0[var_0.size] = var_2;
  }

  self.pass_target = undefined;
  self setballpassallowed(0);
  player_update_pass_target_hudoutline();
}

player_no_pickup_time() {
  return isDefined(self.nopickuptime) && self.nopickuptime > gettime() || isDefined(self.ball_carried);
}

valid_ball_super_pickup(var_0) {
  if(!isDefined(var_0.super))
    return 1;

  if(!isDefined(var_0.super.isinuse) || !var_0.super.isinuse)
    return 1;

  return 1;
}

valid_ball_pickup_weapon(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0))
      return 0;

    if(var_0 == level.ballweapon)
      return 0;

    var_1 = var_0.basename;
  }

  if(isstring(var_0)) {
    if(var_0 == "_encstr_8BBA05185F8B99")
      return 0;

    if(var_0 == level.ballweapon.basename)
      return 0;

    var_1 = var_0;
  }

  if(scripts\mp\utility\killstreak::isremotekillstreakweapon(var_1))
    return 0;

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0))
    return 0;

  return 1;
}

ball_on_host_migration() {
  self.visuals[0] endon("_encstr_B8FE09888F7B6BBFAA6DDD");
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");

  if(isDefined(self.projectile)) {
    if(!isDefined(self.pass_target) && !isDefined(self.carrier) && !self.in_goal) {
      if(self.visuals[0].origin != self.visuals[0].baseorigin + (0, 0, 4000)) {
        ball_restore_contents();

        if(!isDefined(self.lastpassdir))
          self.lastpassdir = (0, 0, 1);

        ball_physics_launch(self.lastpassdir * 400);
      }
    }
  }
}

ball_track_pass_velocity() {
  self.visuals[0] endon("_encstr_B8FE09888F7B6BBFAA6DDD");
  self.projectile endon("_encstr_82251967C2AA8DF9339B0858A77730CB03AE56ED11B379A101F7D8");
  self.projectile endon("_encstr_AD75063D571AE108");
  self.lastpassdir = undefined;
  var_0 = undefined;

  for(;;) {
    if(isDefined(var_0))
      self.lastpassdir = vectorNormalize(self.projectile.origin - var_0);

    var_0 = self.projectile.origin;
    waitframe();
  }
}

ball_track_pass_lifetime() {
  self.visuals[0] endon("_encstr_B8FE09888F7B6BBFAA6DDD");
  self.projectile endon("_encstr_82251967C2AA8DF9339B0858A77730CB03AE56ED11B379A101F7D8");
  self.projectile endon("_encstr_AD75063D571AE108");
  var_0 = gettime();

  for(var_1 = var_0; var_1 < var_0 + 2000; var_1 = gettime())
    waitframe();

  self.projectile delete();
}

ball_track_target(var_0) {
  self.visuals[0] endon("_encstr_B8FE09888F7B6BBFAA6DDD");
  self.projectile endon("_encstr_82251967C2AA8DF9339B0858A77730CB03AE56ED11B379A101F7D8");
  self.projectile endon("_encstr_AD75063D571AE108");

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

ball_on_projectile_death() {
  self endon("_encstr_88F20627959BCAE8");
  self.projectile waittill("_encstr_AD75063D571AE108");
  waittillframeend;
  self.trigger.origin = self.curorigin;
  var_0 = self.visuals[0];

  if(!isDefined(self.carrier) && !self.in_goal) {
    if(var_0.origin != var_0.baseorigin + (0, 0, 4000)) {
      ball_restore_contents();

      if(!isDefined(self.lastpassdir))
        self.lastpassdir = (0, 0, 1);

      ball_physics_launch(self.lastpassdir * 400);
    }
  }

  ball_restore_contents();
  var_0 notify("_encstr_B8FE09888F7B6BBFAA6DDD");
}

ball_on_projectile_hit_client() {
  self.visuals[0] endon("_encstr_B8FE09888F7B6BBFAA6DDD");
  self.projectile waittill("_encstr_82251967C2AA8DF9339B0858A77730CB03AE56ED11B379A101F7D8", var_0);
  self.trigger.origin = self.visuals[0].origin;
  self.trigger notify("_encstr_8F5C086405E70FBA4B4A", var_0);
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

    if(var_1 issprintsliding())
      var_3 = var_3 + (0, 0, 10);

    var_6 = var_3;
    var_7 = vectorNormalize(var_0) * 80;
    var_8 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0", "_encstr_B2741680E3403FEBF1A319E7C24393FD73AB51792F157763", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A60119487802A71B0FC0568F305BCBE829E016EA88DA307605DCD9"];
    var_9 = physics_createcontents(var_8);
    var_10 = scripts\engine\trace::sphere_trace(var_6, var_6 + var_7, 38, var_1, var_9);

    if(var_10["_encstr_A53009A25003666B9818C6"] < 1) {
      var_11 = 0.7 * var_10["_encstr_A53009A25003666B9818C6"];
      scripts\mp\gameobjects::setposition(var_6 + var_7 * var_11, var_2.angles);
    } else
      scripts\mp\gameobjects::setposition(var_10["_encstr_BD260953AA97E3F014279D"], var_2.angles);
  }

  self.visuals[0] physicslaunchserver(var_2.origin, var_0);
  self.visuals[0] thread scripts\mp\utility\entity::register_physics_collisions();
  self.visuals[0] physics_registerforcollisioncallback();
  scripts\mp\utility\entity::register_physics_collision_func(self.visuals[0], ::ball_impact_sounds);
  self.visuals[0].origin = self.trigger.origin;
  self.trigger linkTo(self.visuals[0]);
  level.codcasterball = self.visuals[0];
  level.codcasterballowner = var_4;
  level.codcasterballinitialforcevector = var_0;
  thread ball_physics_out_of_level();
  thread ball_physics_timeout(var_1);
  thread ball_physics_bad_trigger_watch();

  if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB")
    thread _encstr_AD5D1EB9D8935AE08E9BE55BE0CBD9586B591D2F1C59DCCB13851B1B5C76B91B::ball_physics_touch_goal();

  thread ball_physics_touch_cant_pickup_player(var_1);
}

ball_physics_touch_cant_pickup_player(var_0) {
  var_1 = self.visuals[0];
  var_2 = self.trigger;
  self.visuals[0] endon("_encstr_95E2110ED0CBDCD2D8E6AF3396E6A5DCD05646");
  self endon("_encstr_9B30109FF3214763228FEE13900D3DF0B308");
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_A7380C6ED87B39ACFA95CE2BE6A3");

  for(;;) {
    var_2 waittill("_encstr_8F5C086405E70FBA4B4A", var_3);

    if(!isPlayer(var_3) && !isagent(var_3)) {
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
  } else
    var_4 = length(var_3) / 10;

  var_5 = vectorNormalize(var_3);
  var_5 = (-1, -1, -0.5) * var_5;
  var_1 physicslaunchserver(var_1.origin, (0, 0, 0));
  var_1 physicsstopserver();
  var_1 physicslaunchserver(var_1.origin, var_5 * var_4);
  var_1.physicsactivated = 1;
}

physics_impact_watch() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8A21128393F64D2BB13A4B1BB2F55AD60E85C61D", var_0, var_1, var_2, var_3);
    var_4 = level._effect["_encstr_BA94149816D863EB380D5E37B41BB9AFD26BC10BC68E"];

    if(isDefined(var_3) && isDefined(level._effect["_encstr_A1051513161BC6EB38D0BCB92DB1CDAF5A6B0EB01B3AEB" + var_3]))
      var_4 = level._effect["_encstr_A1051513161BC6EB38D0BCB92DB1CDAF5A6B0EB01B3AEB" + var_3];

    if(!istrue(level.devball))
      playFX(var_4, var_0, var_1);

    wait 0.3;
  }
}

ball_impact_sounds(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_0 physics_getbodyid(0);
  var_10 = physics_getbodylinvel(var_9);
  var_11 = length(var_10);

  if(isDefined(var_0.playing_sound) || var_11 < 70) {
    return;
  }
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.playing_sound = 1;
  var_12 = "_encstr_81CF16D6C1EBD5C18D2DB9DAAF13B08D8DAFC4F6D59B1B2B";
  var_0 playSound(var_12);
  var_13 = lookupsoundlength(var_12);
  wait 0.1;
  var_0.playing_sound = undefined;
}

ball_return_home(var_0, var_1) {
  self.ball_fx_active = 0;

  if(istrue(var_0))
    detonateball();

  if(istrue(level.possessionresetcondition)) {
    if(istrue(level.player_has_respawn_munition))
      level updatetimers("_encstr_A7A408B9CA5D1D4E2C63", 0, 1);
    else
      level updatetimers("_encstr_A7A408B9CA5D1D4E2C63", 1, 1);
  }

  level.codcasterball = undefined;
  level.codcasterballinitialforcevector = undefined;
  level.ballreset = 1;
  self.in_goal = 0;
  var_2 = self.visuals[0];
  var_2 physicslaunchserver(var_2.origin, (0, 0, 0));
  var_2 physicsstopserver();

  if(!istrue(level.devball)) {
    playsoundatpos(var_2.origin, "_encstr_A2441DB6C17DAB38C6D2CDB5AF98C2D81BBEB7AB1DD7DECCF598B75D738C9B");
    playFX(scripts\engine\utility::getfx("_encstr_85810E890B1B8DF5D1958DB238BD9C1D"), var_2.origin);
  }

  if(isDefined(self.carrier))
    self.carrier scripts\engine\utility::delaythread(0.05, ::player_update_pass_target_hudoutline);

  self.visuals[0] setscriptablepartstate("_encstr_B2AD12ABC9D193139767C1E6D8C525999852CC87", "_encstr_BD1805CB69C063", 0);
  thread scripts\mp\gameobjects::returnhome();
}

ball_overridemovingplatformdeath(var_0) {
  var_0.carryobject ball_return_home(0, 1);
}

ball_download_wait(var_0) {
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  scripts\mp\gameobjects::allowcarry("_encstr_8BBA05185F8B99");
  self.isresetting = 1;
  wait(var_0);
  self.isresetting = 0;
  ball_waypoint_neutral();
  scripts\mp\gameobjects::allowcarry("_encstr_9A19040BCDBC");
  self notify("_encstr_8D870B69570DD3793A15F940F3");

  if(!istrue(level.devball)) {
    playFX(level._effect["_encstr_86E11226B0B136BE8C7BEEDC637B2CC8FA2B3732"], self.curorigin);
    thread ball_fx_start(0, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "_encstr_85EF050CB150E7") {
    level updatetimers("_encstr_A7A408B9CA5D1D4E2C63", 1, 1);
    level.balls[0] thread starthoveranim();
  }
}

waitforreset(var_0) {
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\gameobjects::allowcarry("_encstr_8BBA05185F8B99");

  if(level.player_has_respawn_munition != 0)
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level.player_has_respawn_munition);

  if(level.timerstoppedforgamemode)
    level scripts\mp\gamelogic::resumetimer();

  scripts\mp\gameobjects::setposition(var_0.baseorigin, (0, 0, 0));
  self.visuals[0] setscriptablepartstate("_encstr_B2AD12ABC9D193139767C1E6D8C525999852CC87", "_encstr_BD1805CB69C063", 0);
  thread ball_download_wait(0);
  var_0 rotatevelocity((0, 720, 0), 3, 0, 3);
}

starthoveranim() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self notify("_encstr_9AAD0FD0ED6756C90AE6D25BA9E82C933A");
  self endon("_encstr_9AAD0FD0ED6756C90AE6D25BA9E82C933A");
  var_0 = self.visuals[0].origin;
  self.visuals[0] rotateYaw(2000, 60, 0.2, 0.2);

  for(;;) {
    self.visuals[0] moveTo(var_0 + (0, 0, 5), 1, 0.5, 0.5);
    wait 1;
    self.visuals[0] moveTo(var_0 - (0, 0, 5), 1, 0.5, 0.5);
    wait 1;
  }
}

ball_physics_out_of_level() {
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
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

    waitframe();
  }
}

ball_physics_timeout(var_0) {
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self endon("_encstr_A7380C6ED87B39ACFA95CE2BE6A3");

  if(!isDefined(level.idleresettime))
    level.idleresettime = 15;

  var_1 = level.idleresettime;
  var_2 = 10;
  var_3 = 3;

  if(var_1 >= var_2) {
    wait(var_3);
    var_1 = var_1 - var_3;
  }

  wait(var_1);
  self notify("_encstr_9B30109FF3214763228FEE13900D3DF0B308");
  ball_return_home(1, 1);
}

ball_physics_bad_trigger_watch() {
  self.visuals[0] endon("_encstr_95E2110ED0CBDCD2D8E6AF3396E6A5DCD05646");
  self endon("_encstr_9B30109FF3214763228FEE13900D3DF0B308");
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_A7380C6ED87B39ACFA95CE2BE6A3");
  thread ball_physics_bad_trigger_at_rest();

  for(;;) {
    if(self.visuals[0] touchingnozonetrigger())
      thread ball_physics_fake_bounce(1);

    if(!self.visuals[0] scripts\mp\utility\entity::touchingballallowedtrigger()) {
      if(self.visuals[0] scripts\mp\utility\entity::touchingbadtrigger() || self.visuals[0] scripts\mp\utility\entity::touchingoobtrigger()) {
        ball_return_home(0, 1);
        return;
      }
    }

    waitframe();
  }
}

touchingnozonetrigger() {
  if(level.nozonetriggers.size > 0) {
    foreach(var_1 in level.nozonetriggers) {
      if(self istouching(var_1))
        return 1;
    }
  }

  return 0;
}

watchstuckinnozone() {
  self.visuals[0] endon("_encstr_95E2110ED0CBDCD2D8E6AF3396E6A5DCD05646");
  self endon("_encstr_9B30109FF3214763228FEE13900D3DF0B308");
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_A7380C6ED87B39ACFA95CE2BE6A3");
  var_0 = gettime();
  var_1 = var_0 + 500;

  for(;;) {
    if(self.visuals[0] touchingnozonetrigger() && var_1 < var_0) {
      ball_return_home(1, 1);
      return;
    }

    wait 0.05;
    var_0 = gettime();
  }
}

ball_physics_bad_trigger_at_rest() {
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_A7380C6ED87B39ACFA95CE2BE6A3");
  var_0 = self.visuals[0];
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_95E2110ED0CBDCD2D8E6AF3396E6A5DCD05646");

  if(scripts\mp\utility\entity::touchingbadtrigger()) {
    ball_return_home(1, 1);
    return;
  }
}

ball_location_hud() {
  for(;;) {
    var_0 = scripts\engine\utility::_id_143AF("_encstr_AD740E37543ADFAB708788F84BBDA129", "_encstr_88C60846397B83835919", "_encstr_88F20627959BCAE8", "_encstr_8D870B69570DD3793A15F940F3");

    switch (var_0) {
      case "_encstr_AD740E37543ADFAB708788F84BBDA129":
        break;
      case "_encstr_88C60846397B83835919":
        break;
      case "_encstr_88F20627959BCAE8":
        break;
      case "_encstr_8D870B69570DD3793A15F940F3":
        break;
      default:
        break;
    }
  }
}

ball_check_pass_kill_pickup(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 endon("_encstr_88F20627959BCAE8");
  var_1 = spawnStruct();
  var_1 endon("_encstr_A5AB0BEB8019272A4109A7BE13");
  var_1 thread timer_run(1.5);
  var_0 waittill("_encstr_AD740E37543ADFAB708788F84BBDA129");
  var_1 timer_cancel();

  if(!isDefined(var_0.carrier) || var_0.carrier.team == self.team) {
    return;
  }
  var_0.carrier endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 thread timer_run(5);
  var_0.carrier waittill("_encstr_AD75063D571AE108", var_2);
  var_1 timer_cancel();

  if(!isDefined(var_2) || var_2 != self) {
    return;
  }
  var_1 thread timer_run(2);
  var_0 waittill("_encstr_AD740E37543ADFAB708788F84BBDA129");
  var_1 timer_cancel();

  if(isDefined(var_0.carrier) && var_0.carrier == self)
    thread scripts\mp\utility\points::giveunifiedpoints("_encstr_847E0FE6CF5942D78398576F51D8A90A01");
}

timer_run(var_0) {
  self endon("_encstr_869D0D46AE123741849F78987FA5FB");
  wait(var_0);
  self notify("_encstr_A5AB0BEB8019272A4109A7BE13");
}

timer_cancel() {
  self notify("_encstr_869D0D46AE123741849F78987FA5FB");
}

ball_waypoint_neutral() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_AD7016BB589783F6D2DCD1AF73CA5D3A2785C67D890B3636", "_encstr_AD7016BB589783F6D2DCD1AF73CA5D3A2785C67D890B3636");
}

ball_waypoint_held(var_0) {
  if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB")
    var_1 = "_encstr_BE7610A351B00882DBB5B3279BFE0A5FB09B";
  else
    var_1 = "_encstr_ADEA161721610FB88B60E4F15F7733D1957FC8C398A5B027";

  scripts\mp\gameobjects::setobjectivestatusicons(var_1, "_encstr_8BEE1CA38A68EB0AC08B6B170F39A8D98013E36104B874B0D112B07B7AF1");
}

ball_waypoint_download() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_819B0572BF80BB")
    var_0 = "_encstr_8BFC171349DBABB538A5F4D75590BD0310412A9B30399F6E68";
  else
    var_0 = "_encstr_A2141683D94B3B2548D56447C52BEAD775B6BA6AC32A275A";

  scripts\mp\gameobjects::setobjectivestatusicons(var_0, var_0);
}

ball_waypoint_upload() {
  scripts\mp\gameobjects::setobjectivestatusicons("_encstr_ADB215DFD8A0388789C0E846C2B70CC44EEF73087709AF", "_encstr_ADB215DFD8A0388789C0E846C2B70CC44EEF73087709AF");
}

ball_restore_contents() {
  self.visuals[0] solid();
}

ball_dont_interpolate() {
  self.visuals[0] dontinterpolate();
  self.ball_fx_active = 0;
}

ball_assign_start(var_0) {
  foreach(var_2 in self.visuals)
  var_2.baseorigin = var_0.origin;

  self.trigger.baseorigin = var_0.origin;
  self.current_start = var_0;
  var_0.in_use = 1;
}

ball_create_killcam_ent() {
  if(isDefined(self.killcament))
    self.killcament delete();

  self.killcament = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.visuals[0].origin);
  self.killcament linkTo(self.visuals[0]);
  self.killcament notsolid();
  self.killcament setscriptmoverkillcam("_encstr_AB440A3180D0C0109B17550B");
}

initballtimer() {
  level.balltime = level.possessionresettime;
  level.balltimerpaused = 1;
  level.balltimerstopped = 0;

  if(isDefined(level.possessionresetcondition) && level.possessionresetcondition != 0)
    thread createhudelems();
  else {}
}

createhudelems() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  updatetimers("_encstr_A7A408B9CA5D1D4E2C63", 1, 1);
}

updatetimers(var_0, var_1, var_2, var_3) {
  if(!istrue(level.possessionresetcondition)) {
    return;
  }
  var_4 = undefined;
  var_5 = 1000 * level.possessionresettime;

  if(istrue(var_2)) {
    if(istrue(level.player_has_respawn_munition) && !istrue(level.ballreset))
      var_5 = 1000 * level.player_has_respawn_munition;
  }

  if(istrue(var_2) || istrue(var_3)) {
    level.balltime = level.possessionresettime;
    level.ballendtime = int(gettime() + var_5);
  } else
    level.ballendtime = int(gettime() + 1000 * level.balltime);

  setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.ballendtime);

  if(var_5 > 0 && (istrue(var_3) || !var_1 && level.balltimerpaused))
    level.ball thread ballruntimer(var_0, var_4);

  if(var_1)
    level pauseballtimer();
}

ballruntimer(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_88F20627959BCAE8");
  level endon("_encstr_A33A11C962278FEFFF618B88CDEFEB9B88D952");
  level notify("_encstr_B2800D1385D8C649BAB98A2D5BB239");
  level endon("_encstr_B2800D1385D8C649BAB98A2D5BB239");
  level.balltimerpaused = 0;
  balltimerwait(var_0, var_1);

  if(!istrue(level.ballreset)) {
    scripts\mp\gameobjects::allowcarry("_encstr_8BBA05185F8B99");
    ball_set_dropped(1, self.trigger.origin, 1);
    ball_return_home(1, 1);
  }
}

balltimerwait(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A33A11C962278FEFFF618B88CDEFEB9B88D952");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, int(level.balltime * 1000 + gettime()));
  level resumeballtimer(var_1);
  thread watchtimerpause();
  level thread handlehostmigration(var_2);
  waitballlongdurationwithgameendtimeupdate(level.balltime);
}

waitballlongdurationwithgameendtimeupdate(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A33A11C962278FEFFF618B88CDEFEB9B88D952");

  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    waittillballhostmigrationstarts((var_2 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var_2 = var_2 + 1000;
      setgameendtime(int(var_2));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_2 = var_2 + 1000;
    setgameendtime(int(var_2));
    wait 1;
  }

  return gettime() - var_1;
}

waittillballhostmigrationstarts(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A33A11C962278FEFFF618B88CDEFEB9B88D952");

  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  level endon("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  wait(var_0);
}

handlehostmigration(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level waittill("_encstr_AD3F1534DB9BA3BEADD27627B0D1B4BDCDAFC495EC2DCD");
  setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 1);
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(!level.balltimerstopped)
    setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 0);

  if(var_1 > 0)
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.ballendtime + var_1);
  else
    setomnvar("_encstr_A5A3135B23C10B1F636CA0F2722261B80C5C7BC075", level.ballendtime);
}

watchtimerpause() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level notify("_encstr_AD2E0FDDC28E8D0D29569B561D6AEDF6DC");
  level endon("_encstr_AD2E0FDDC28E8D0D29569B561D6AEDF6DC");
  var_0 = 0;

  for(var_1 = undefined; level.balltime > 0 && !level.balltimerpaused; level.balltime = level.balltime - var_6) {
    var_2 = gettime();

    if(!var_0 && level.balltime < 10) {
      foreach(var_4 in level.teamnamelist)
      level scripts\mp\utility\dialog::statusdialog("_encstr_82AC114713203602E0ADD7F7FB1DE96378187D", var_4);

      var_0 = 1;
    }

    if(isDefined(level.balls[0].carrier) && level.balltime < 5) {
      if(!isDefined(var_1) || var_2 > var_1 + 1000)
        var_1 = var_2;
    }

    var_6 = 0.05;
    wait(var_6);
  }

  if(level.balltimerpaused)
    level notify("_encstr_A33A11C962278FEFFF618B88CDEFEB9B88D952");
}

updateballtimerpausedness(var_0) {
  var_1 = level.balltimerpaused || isDefined(level.hostmigrationtimer);

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
    var_1 = 0;

  if(!level.balltimerstopped && var_1) {
    level.balltimerstopped = 1;
    setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 1);
  } else if(level.balltimerstopped && !var_1) {
    level.balltimerstopped = 0;
    setomnvar("_encstr_873A1B7B08D94F3A22DB87D32BD4B2876890F5C7C3811B1388C9D36F29", 0);
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
  if(!istrue(level.devball)) {
    foreach(var_1 in level.balls)
    var_1 ball_fx_start_player(self);
  }
}

ball_fx_start_player(var_0) {
  if(ball_fx_active()) {
    self.visuals[0] setscriptablepartstate("_encstr_A1B3124BBF9D23B83A0E9B2B72704DCE51090D35", "_encstr_820E07FAE8780B3A4C", 0);
    self.visuals[0] setscriptablepartstate("_encstr_99061288792D78781FF891D37738F7290311B26D", "_encstr_820E07FAE8780B3A4C", 0);
  }
}

ball_fx_start(var_0, var_1) {
  self endon("_encstr_88F20627959BCAE8");
  self endon("_encstr_AD740E37543ADFAB708788F84BBDA129");

  if(istrue(var_0))
    wait 0.2;
  else
    waitframe();

  if(!ball_fx_active()) {
    self.visuals[0] setscriptablepartstate("_encstr_A1B3124BBF9D23B83A0E9B2B72704DCE51090D35", "_encstr_820E07FAE8780B3A4C", 0);
    self.visuals[0] setscriptablepartstate("_encstr_99061288792D78781FF891D37738F7290311B26D", "_encstr_820E07FAE8780B3A4C", 0);
    self.ball_fx_active = 1;
  }
}

ball_fx_active() {
  return isDefined(self.ball_fx_active) && self.ball_fx_active;
}

ball_fx_stop() {
  if(ball_fx_active())
    self.visuals[0] stop_fx_idle();

  self.ball_fx_active = 0;
}

stop_fx_idle() {
  self setscriptablepartstate("_encstr_A1B3124BBF9D23B83A0E9B2B72704DCE51090D35", "_encstr_BA19049F4B2D", 0);
  self setscriptablepartstate("_encstr_99061288792D78781FF891D37738F7290311B26D", "_encstr_BA19049F4B2D", 0);
}

ball_download_fx(var_0, var_1) {
  scripts\engine\utility::waittill_notify_or_timeout("_encstr_AD740E37543ADFAB708788F84BBDA129", var_1);
  level.scorefrozenuntil = 0;
  level notify("_encstr_8F3B0B377DE3B9A1D01F4F47F1");
}

moveballtoplayer() {
  level notify("_encstr_AC9109835336B003202E0F");
  level endon("_encstr_AC9109835336B003202E0F");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 5;

  for(;;) {
    self waittill("_encstr_96920AB185B1637D982C1B1B");

    if(!isDefined(level.balls[0].carrier)) {
      level.balls[0].visuals[0] physicslaunchserver(level.balls[0].visuals[0].origin, (0, 0, 0));
      level.balls[0].visuals[0] physicsstopserver();

      while(!isDefined(level.balls[0].carrier)) {
        var_0 = 40;

        switch (self getstance()) {
          case "_encstr_B13D076BED70539F23":
            var_0 = 30;
            break;
          case "_encstr_922406F1A6FD5E05":
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

practicenotify() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 1;

  for(;;) {
    if(var_0)
      self waittill("_encstr_B2030CA0C91D2F44C0B314F8836B");
    else
      self waittill("_encstr_BA350853C128FB939DB9");

    var_0 = 0;

    if(var_0)
      wait 20;
    else
      wait 2;

    thread givepracticemessage();
  }
}

givepracticemessage() {
  self notify("_encstr_AD8C10B8AB586EC42BC7BA51B3670281772D");
  self endon("_encstr_AD8C10B8AB586EC42BC7BA51B3670281772D");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self notifyonplayercommand("_encstr_96920AB185B1637D982C1B1B", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
    self iprintlnbold(&"_encstr_A1FF1F82620A8A233D2935975582894A93A5FA14251486514A862AEB35C4F445CC");
  } else {
    self notifyonplayercommand("_encstr_96920AB185B1637D982C1B1B", "_encstr_A55C0EAAE22E11D0BF66B6214FFB312F");
    self iprintlnbold(&"_encstr_91FF1F477D78C1AD2F1339321768A4B3F0D458CF42D03717C17F71B9675C1C71CF");
  }

  level.balls[0] waittill("_encstr_A7380C6ED87B39ACFA95CE2BE6A3");
  wait 5;
  thread givepracticemessage();
}

sortballarray(var_0) {
  if(!isDefined(var_0) || var_0.size == 0)
    return undefined;

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

  if(!isDefined(var_2) && !isDefined(var_3))
    return 0;

  if(!isDefined(var_2) && isDefined(var_3))
    return 1;

  if(isDefined(var_2) && !isDefined(var_3))
    return 0;

  if(var_2 > var_3)
    return 1;

  return 0;
}

getpasserorigin() {
  var_0 = 0;

  switch (self getstance()) {
    case "_encstr_B13D076BED70539F23":
      var_0 = 5;
      break;
    case "_encstr_922406F1A6FD5E05":
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
    case "_encstr_B13D076BED70539F23":
      var_0 = 15;
      break;
    case "_encstr_922406F1A6FD5E05":
      var_0 = 5;
      break;
  }

  var_1 = self getworldupreferenceangles();
  var_2 = anglestoup(var_1);
  var_3 = self gettagorigin("_encstr_83890D9CA8EF0B79D830939788913A", 1, 1);
  var_4 = var_3 + var_2 * var_0;
  return var_4;
}

gettargetoffset() {
  var_0 = gettargetorigin();
  return (0, 0, var_0[2] - self.origin[2]);
}