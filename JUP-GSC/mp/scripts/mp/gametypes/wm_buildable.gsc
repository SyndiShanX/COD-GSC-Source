/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\wm_buildable.gsc
*************************************************/

#using script_29e75e5ebeca383d;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm_buildable;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\weapon;
#namespace wm_buildable;

function function_e2344ec3f70a089c() {
  if(!function_87c403778d48f1b0()) {
    return false;
  }

  level.var_96c8e55e70edd512 = &function_96c8e55e70edd512;
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_Buildable_ToBuild", 1, "neutral", undefined, "ui_icon_minimap_warmode_buildable_empty");
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_Buildable_Built", 1, "neutral", undefined, "ui_icon_minimap_warmode_buildable_teardown");
  return true;
}

function function_87c403778d48f1b0() {
  return function_29227adb79acc568("buildableEnabled", 1);
}

function function_96c8e55e70edd512(animname) {
  if(animname == "EarthenWall" || animname == "Hesco" || animname == "TankTrap" || animname == "Baffle") {
    return "slow";
  }

  return undefined;
}

function function_e20a97a059fba2ea(objname, triggerent, zonename, currentprogress, origin, angles) {
  if(!isDefined(level.buildables)) {
    level.buildables = [];
  }

  buildinfo = level.buildablepool[objname];
  buildable = spawnStruct();
  buildable.name = objname;
  buildable.triggerent = triggerent;
  buildable.triggeroutline = triggerent.outline;
  buildable.zonename = zonename;
  buildable.id = triggerent.script_label;
  useobject = function_ec8de485b310f295(triggerent, buildinfo.hintstring, buildinfo.buildusetime, buildinfo.buildteam, buildinfo.var_5d8933c950c9a154);
  buildable.useobj = useobject;
  useobject.buildable = buildable;
  buildable.gestureweapon = buildinfo.gestureweapon;
  buildable.var_32a2681a13f18cb1 = buildinfo.var_32a2681a13f18cb1;
  buildable.var_fc147a62066d05bd = buildinfo.var_fc147a62066d05bd;
  buildable.var_b3b899b146453c0c = buildinfo.var_b3b899b146453c0c;
  buildable.var_562da06e56403b2f = buildinfo.var_562da06e56403b2f;
  buildable.phases = [0, 1];

  if(isDefined(buildinfo.phases)) {
    buildable.phases = buildinfo.phases;
  }

  buildable.buildphase = 0;
  buildable.models = [];

  if(isDefined(buildinfo.models) && buildinfo.models.size > 0) {
    for(i = 0; i < buildinfo.models.size; i++) {
      model = spawn("script_model", origin);
      model setModel(buildinfo.models[i]);
      model.angles = angles;
      buildable.models[i] = model;
      model notsolid();
      model connectpaths();
    }

    assert(buildable.phases.size - buildable.models.size == 1, objname + "<dev string:x1c>" + "<dev string:x55>" + buildable.phases.size - 1 + "<dev string:x68>" + buildable.models.size);
  }

  buildable.var_5474cdc451625a5c = [];
  buildable.idleanimations = [];
  buildable.var_6c25aa98fdfa6d26 = [];

  if(isDefined(buildinfo.animations) && buildinfo.animations.size > 0) {
    animname = buildinfo.animations[0];
    var_5474cdc451625a5c = buildinfo.animations[1];
    idleanimations = buildinfo.animations[2];
    assert(var_5474cdc451625a5c.size == buildable.models.size, animname + "<dev string:x7b>" + "<dev string:xc2>" + var_5474cdc451625a5c.size + "<dev string:x68>" + buildable.models.size);
    assert(var_5474cdc451625a5c.size == idleanimations.size, animname + "<dev string:xd9>" + "<dev string:xc2>" + var_5474cdc451625a5c.size + "<dev string:x12b>" + idleanimations.size);
    buildable.animname = animname;

    for(i = 0; i < var_5474cdc451625a5c.size; i++) {
      buildable.models[i].animname = animname;
      buildable.models[i] scripts\common\anim::setanimtree();
      buildable.var_5474cdc451625a5c[i] = var_5474cdc451625a5c[i];
      buildable.idleanimations[i] = idleanimations[i];
    }

    var_6c25aa98fdfa6d26 = buildinfo.animations[3];

    if(isDefined(var_6c25aa98fdfa6d26)) {
      assertex(var_6c25aa98fdfa6d26.size == buildable.models.size, animname + "<dev string:x147>" + "<dev string:xc2>" + var_6c25aa98fdfa6d26.size + "<dev string:x68>" + buildable.models.size);

      for(i = 0; i < var_6c25aa98fdfa6d26.size; i++) {
        buildable.var_6c25aa98fdfa6d26[i] = var_6c25aa98fdfa6d26[i];
      }
    }
  }

  buildable updateprogress(undefined, currentprogress, 1);
  buildable thread function_4f45e256b6ed7a46();
  level.buildables[level.buildables.size] = buildable;
  return buildable;
}

function function_4f45e256b6ed7a46() {
  level endon("game_ended");

  if(isDefined(self.zonename)) {
    scripts\mp\flags::gameflagwait(self.zonename + "_objective_start");

    if(isDefined(level.zone) && is_equal(self.zonename, level.zone.name) || getbasegametype() == "escort") {
      if(self.zonename == "zone_2") {
        var_795e67d6e6be2a3c = getEnt("zone2", "script_noteworthy");

        if(isDefined(var_795e67d6e6be2a3c)) {
          assertex(isDefined(var_795e67d6e6be2a3c.script_floor_number), "<dev string:x190>");
          var_72dbc57ca9f76e06 = 0;

          while(!istrue(var_72dbc57ca9f76e06)) {
            waitframe();

            foreach(player in level.players) {
              if(isalive(player) && !istrue(player.var_9b713d24bdb6d97f) && player istouching(var_795e67d6e6be2a3c)) {
                var_72dbc57ca9f76e06 = 1;
                break;
              }
            }
          }
        }
      }

      self.useobj.offset3d = (-20, 30, -30);
      self.useobj scripts\mp\gameobjects::requestid(1, 0);
      self.useobj scripts\mp\gameobjects::setobjectivestatusicons("waypoint_Buildable_ToBuild");
      self.useobj scripts\mp\gameobjects::setvisibleteam("any");
      scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(self.useobj.objidnum, 1);
    } else {
      self.useobj releaseid();
    }
  } else {
    assertmsg("<dev string:x1cb>" + self.name + "<dev string:x1f6>" + self.origin);
    return;
  }

  scripts\mp\flags::gameflagwait(self.zonename + "_objective_end");
  self.useobj releaseid();
}

function function_9ab1fdb68e31a48d(player) {
  return istrue(self.var_72947c50e65b4298);
}

function function_7c1c6aa025f65e28() {
  function_2e45cbf17c0a6f5(self);
  self.useobj.var_4a03a924a61fd704 = 1;
  waitframe();
  removebuildable(self);
}

function function_2e45cbf17c0a6f5(buildable) {
  useobj = buildable.useobj;
  useobj.var_72947c50e65b4298 = 0;
  useobj notify("stop_delay_thread");
}

function removebuildable(buildable) {
  foreach(model in buildable.models) {
    model delete();
  }

  buildable.useobj releaseid();
  level.buildables = array_remove(level.buildables, buildable);
}

function function_fec3326168e40898() {
  for(i = 0; i < self.phases.size; i++) {
    if(self.phases[i] == self.buildphase) {
      return i;
    }
  }

  assert("<dev string:x201>" + self.name + "<dev string:x228>" + self.buildphase);
  return undefined;
}

function function_f07123bb7b8f859c(phasesinfo, currentprogress) {
  buildphase = 0;

  foreach(phase in phasesinfo) {
    if(currentprogress >= phase) {
      buildphase = phase;
    }
  }

  return buildphase;
}

function updateprogress(player, progress, isinit) {
  assert(progress >= 0, "<dev string:x23a>" + self.name);
  buildphase = function_f07123bb7b8f859c(self.phases, progress);

  if(buildphase > self.buildphase) {
    if(istrue(isinit)) {
      model = function_aa4e75eb0323bde0();

      if(isDefined(model)) {
        model solid();
        model disconnectPaths();
      }
    } else {
      model = function_aa4e75eb0323bde0();

      if(isDefined(model)) {
        model solid();
        model disconnectPaths();
      }
    }

    self.buildphase = buildphase;

    if(self.buildphase >= 1 && isDefined(self.var_562da06e56403b2f)) {
      level[[self.var_562da06e56403b2f]](player, self);

      if(istrue(isinit)) {
        self.useobj function_309305a89c073495();
      } else {
        function_ca34b4eff8624dbb(player, "build");
      }
    } else if(isDefined(self.var_b3b899b146453c0c)) {
      level[[self.var_b3b899b146453c0c]](player, self, function_fec3326168e40898());
      function_ca34b4eff8624dbb(player, "build");
    }

    if(buildphase > 0) {
      if(istrue(isinit)) {} else {
        function_730668fddabb6225();
      }
    }

    return;
  }

  if(istrue(self.var_9cfe63aea32bf01e)) {
    if(isDefined(self.var_32a2681a13f18cb1)) {
      level[[self.var_32a2681a13f18cb1]](player, self);
    }

    function_730668fddabb6225();
    return;
  }

  if(istrue(isinit)) {
    function_8cb0764ec504b898();
  }
}

function function_fad72d32ee97db4f() {
  return self.var_5474cdc451625a5c[function_fec3326168e40898()];
}

function function_41164ff94605e5ff() {
  return self.idleanimations[function_fec3326168e40898()];
}

function function_aa4e75eb0323bde0() {
  return self.models[function_fec3326168e40898()];
}

function function_8cb0764ec504b898() {
  for(i = 0; i < self.idleanimations.size; i++) {
    idleanimname = self.idleanimations[i];
    model = self.models[i];

    if(isDefined(idleanimname) && isDefined(model)) {
      thread function_cb796e5e54e477f6(model, idleanimname);
    }
  }
}

function function_cb796e5e54e477f6(model, animname) {
  model scripts\common\anim::anim_single_solo(model, animname);
  model clearanim(level.scr_anim[self.animname][animname], 0);
}

function function_3b27c12823e5dc9() {
  if(isDefined(self.models[1]) && fxexists("wall_explode")) {
    playFXOnTag(getfx("wall_explode"), self.models[1], "tag_origin");
    playsoundatpos(self.models[1].origin, "jup_launchfacility_buildable_wall_destroyed");
  }

  for(i = 0; i < self.idleanimations.size; i++) {
    idleanimname = self.idleanimations[i];
    model = self.models[i];

    if(isDefined(idleanimname) && isDefined(model)) {
      if(i == self.idleanimations.size - 1) {
        model scripts\common\anim::anim_single_solo(model, idleanimname);
        continue;
      }

      model thread scripts\common\anim::anim_single_solo(model, idleanimname);
    }
  }
}

function function_a3395723ec35ab32() {
  if(self.buildphase < 0 || self.buildphase >= 1) {
    return;
  }

  idleanimname = function_41164ff94605e5ff();
  model = function_aa4e75eb0323bde0();

  if(isDefined(idleanimname) && isDefined(model)) {
    model scripts\common\anim::anim_single_solo(model, idleanimname);
    model clearanim(level.scr_anim[self.animname][idleanimname], 0);
  }
}

function function_730668fddabb6225() {
  if(self.buildphase < 0 || self.buildphase >= 1) {
    return;
  }

  var_af23b5811572c735 = function_fad72d32ee97db4f();
  model = function_aa4e75eb0323bde0();

  if(isDefined(var_af23b5811572c735) && isDefined(model)) {
    model thread scripts\common\anim::anim_single_solo(model, var_af23b5811572c735);
  }
}

function function_640f02a78c82e01e() {
  if(!isDefined(self.var_6c25aa98fdfa6d26)) {
    return;
  } else if(self.var_6c25aa98fdfa6d26.size == 0) {
    function_3b27c12823e5dc9();
    return;
  }

  for(i = 0; i < self.var_6c25aa98fdfa6d26.size; i++) {
    var_6c25aa98fdfa6d26 = self.var_6c25aa98fdfa6d26[i];
    model = self.models[i];

    if(isDefined(var_6c25aa98fdfa6d26) && isDefined(model)) {
      model scripts\common\anim::anim_single_solo(model, var_6c25aa98fdfa6d26);
    }
  }
}

function function_ec8de485b310f295(triggerent, hintstring, buildusetime, buildteam, var_5d8933c950c9a154) {
  useobj = scripts\mp\gameobjects::createuseobject(game["defenders"], triggerent, [], (0, 0, 0), 1, 1);

  if(isDefined(buildteam)) {
    if(buildteam == game["defenders"]) {
      useobj scripts\mp\gameobjects::allowuse("friendly");
    } else {
      useobj scripts\mp\gameobjects::allowuse("enemy");
    }
  }

  useobj.trigger makeusable();
  useobj.skiptouching = undefined;
  useobj.interactteam = "any";
  useobj.var_5d8933c950c9a154 = var_5d8933c950c9a154;
  useobj.id = "wm_buildable";
  useobj.waitforweapononuse = 0;
  useobj.checkuseconditioninthink = 1;
  useobj.var_72947c50e65b4298 = 1;
  useobj.trigger setusepriority(-1 - 1 - 1 - 1);
  useobj scripts\mp\gameobjects::setusetime(buildusetime);
  useobj.buildusetime = buildusetime;
  useobj scripts\mp\gameobjects::setusehinttext(hintstring);
  useobj.trigger setuseholdduration("duration_none");
  useobj.hintstring = hintstring;
  useobj.onbeginuse = &function_5163851170a11648;
  useobj.onenduse = &function_2d71060946497558;
  useobj.onuse = &function_79a41152cd2dc1f7;
  useobj.usecondition = &function_9ab1fdb68e31a48d;
  useobj.trigger setuserange(96);
  useobj.trigger setusefov(120);
  useobj.trigger sethintdisplayrange(96);
  useobj.trigger sethintdisplayfov(120);
  return useobj;
}

function function_310f1a814bf9c37c(buildable, triggerent, hintstring, destroyusetime, destroyteam, var_5f7f91ab6d5c8af9) {
  destroyobj = scripts\mp\gameobjects::createuseobject(game["defenders"], triggerent, [], (0, 0, 0), 1, 1);
  destroyobj.buildable = buildable;
  buildable.destroyobj = destroyobj;

  if(isDefined(destroyteam)) {
    if(destroyteam == game["defenders"]) {
      destroyobj scripts\mp\gameobjects::allowuse("friendly");
    } else {
      destroyobj scripts\mp\gameobjects::allowuse("enemy");
    }
  }

  destroyobj.gestureweapon = "jup_war_ges_c4_plant";
  destroyobj.countdowntime = 3;
  destroyobj.var_84de0ddcdac2ea86 = 5 - destroyusetime;
  destroyobj.trigger makeusable();
  destroyobj.skiptouching = undefined;
  destroyobj.interactteam = "any";
  destroyobj.id = "wm_buildable";
  destroyobj.waitforweapononuse = 0;
  destroyobj.trigger setusepriority(-1 - 1 - 1 - 1);
  destroyobj scripts\mp\gameobjects::setusetime(destroyusetime);
  destroyobj scripts\mp\gameobjects::setusehinttext(hintstring);
  destroyobj.trigger setuseholdduration("duration_none");
  destroyobj.onbeginuse = &function_f292eea00564d752;
  destroyobj.onenduse = &function_5d8ecf5ea5db5efa;
  destroyobj.onuse = &function_3164e1c4e7e2f49c;
  destroyobj.var_5f7f91ab6d5c8af9 = var_5f7f91ab6d5c8af9;
  destroyobj.trigger setuserange(96);
  destroyobj.trigger setusefov(120);
  destroyobj.trigger sethintdisplayrange(96);
  destroyobj.trigger sethintdisplayfov(120);
  return destroyobj;
}

function function_f6a64189578e480f(player) {
  return istrue(self.canusedestroy);
}

function function_f292eea00564d752(player) {
  player function_70d8ab10eee1b4d5(0);

  if(isDefined(self.gestureweapon)) {
    player scripts\mp\gametypes\wm_utility::function_31325dbf3212f5ec(self.gestureweapon, 0.5);
  }

  if(getbasegametype() != "escort") {
    scripts\mp\gametypes\wm_utility::function_e3cd4f9e858ab6ee(player, "destroy");
  }

  thread function_a82088bc1fe748a9(player);
}

function function_5d8ecf5ea5db5efa(team, player, result) {
  if(!istrue(result)) {
    if(isDefined(self.gestureweapon)) {
      player scripts\mp\gametypes\wm_utility::function_dac4b69b3dfb574e();
    }

    player function_70d8ab10eee1b4d5(1);

    if(getbasegametype() != "escort") {
      scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(player);
    }
  }

  self notify("watch_destroyed_by_splash");
}

function function_3164e1c4e7e2f49c(player) {
  self.trigger makeunusable();

  if(isDefined(self.gestureweapon)) {
    player thread scripts\mp\gametypes\wm_utility::function_7fbb162293aff03(self.var_84de0ddcdac2ea86);
  }

  player function_70d8ab10eee1b4d5(1);

  if(getbasegametype() != "escort") {
    scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(player);
  }

  bombcountdown(player);
  var_7b1187f4780af448 = self.buildable;
  var_7b1187f4780af448 function_640f02a78c82e01e();

  if(getbasegametype() != "escort") {
    var_7b1187f4780af448 function_ca34b4eff8624dbb(player, "destroy");
  }

  if(isDefined(self.var_5f7f91ab6d5c8af9)) {
    self[[self.var_5f7f91ab6d5c8af9]](player);
  }

  var_7b1187f4780af448 notify("buildableDestroyed");
  scripts\mp\gametypes\wm_buildable::removebuildable(var_7b1187f4780af448);

  if(getbasegametype() != "escort") {
    player scripts\mp\gametypes\wm_buildable::function_2591bed1172e3c08(0);
  }

  releaseid();
  self notify("deleted");
}

function function_62602b0ea1741bd2(model, notifystring) {
  level endon("game_ended");
  self endon("buildableDestroyed");
  model childthread scripts\mp\gametypes\wm_buildable::function_df66656601b04226();
  model waittillmatch("scriptableNotification", notifystring);
  model notify("destroyed");
  self.destroyobj notify("destroyed_by_splash");
  self.destroyobj function_578b25d258f0c8d9(model.var_c1438639b68b2538);
}

function function_df66656601b04226() {
  level endon("game_ended");
  self endon("destroyed");
  self endon("death");
  self setCanDamage(1);
  self.var_c1438639b68b2538 = undefined;

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    self.health = 99999;
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    self.var_c1438639b68b2538 = attacker;

    if(function_75a70b148e9541b7(meansofdeath) && isPlayer(attacker)) {
      if(issharedfuncdefined("damage", "updateDamageFeedback")) {
        var_f56fb412974c87c8 = getsharedfunc("damage", "updateDamageFeedback");
        attacker thread[[var_f56fb412974c87c8]]("hitequip");
      }
    }
  }
}

function function_75a70b148e9541b7(meansofdeath) {
  if(!isDefined(meansofdeath)) {
    return false;
  }

  return meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_IMPACT";
}

function function_a82088bc1fe748a9(player) {
  level endon("game_ended");
  self endon("deleted");
  self notify("watch_destroyed_by_splash");
  self endon("watch_destroyed_by_splash");
  self waittill("destroyed_by_splash");

  if(isDefined(self.canusedestroy)) {
    self.canusedestroy = 0;
  }

  player function_70d8ab10eee1b4d5(1);
  scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(player);
  player scripts\mp\gametypes\wm_utility::function_dac4b69b3dfb574e();
}

function function_578b25d258f0c8d9(attacker) {
  self.trigger makeunusable();
  var_7b1187f4780af448 = self.buildable;

  if(isDefined(var_7b1187f4780af448.c4)) {
    var_7b1187f4780af448.c4 setscriptablepartstate("body", "init");
  } else if(isDefined(var_7b1187f4780af448.c4forward) && isDefined(var_7b1187f4780af448.c4back)) {
    var_7b1187f4780af448.c4forward setscriptablepartstate("body", "init");
    var_7b1187f4780af448.c4back setscriptablepartstate("body", "init");
  }

  var_7b1187f4780af448 function_640f02a78c82e01e();

  if(isDefined(self.var_5f7f91ab6d5c8af9)) {
    self[[self.var_5f7f91ab6d5c8af9]](attacker);
  }

  scripts\mp\gametypes\wm_buildable::removebuildable(var_7b1187f4780af448);

  if(isPlayer(attacker)) {
    attacker scripts\mp\gametypes\wm_buildable::function_2591bed1172e3c08(0);
  }

  releaseid();
  self notify("deleted");
}

function bombcountdown(player) {
  if(!isDefined(self.buildable.c4)) {
    positionvec = player.origin - self.buildable.models[0].origin;
    var_5f6cefedf599151 = vectordot(positionvec, anglesToForward(self.buildable.models[0].angles));

    if(var_5f6cefedf599151 > 0) {
      self.buildable.c4 = self.buildable.c4forward;
      self.buildable.c4back setscriptablepartstate("body", "init");
      scripts\mp\utility\outline::outlinedisable(self.buildable.c4back.outlineid, self.buildable.c4back);
    } else {
      self.buildable.c4 = self.buildable.c4back;
      self.buildable.c4forward setscriptablepartstate("body", "init");
      scripts\mp\utility\outline::outlinedisable(self.buildable.c4forward.outlineid, self.buildable.c4forward);
    }
  }

  var_e1e93ae309da32ae = self.buildable.c4.origin;
  dangericonent = player scripts\mp\utility\weapon::_launchgrenade("safe_c4_danger_icon_mp", var_e1e93ae309da32ae, (0, 0, 0), 100, 1);
  dangericonent setModel("tag_origin");
  dangericonent.weapon_object = makeweapon("safe_c4_danger_icon_mp");
  self.buildable.c4.dangericonent = dangericonent;
  self.buildable.c4 setscriptablepartstate("body", "bomb_planted");
  scripts\mp\utility\outline::outlinedisable(self.buildable.c4.outlineid, self.buildable.c4);
  self.buildable.c4 thread namespace_cc15148f4ce22771::function_f0282e7dbd8851fd(self.countdowntime);
  result = waittill_notify_or_timeout_return("destroyed_by_splash", self.countdowntime);
  self.buildable.c4 setscriptablepartstate("body", "explode");

  if(isDefined(player)) {
    radiusdamage(self.buildable.c4.origin, 256, 200, 105, player, "MOD_EXPLOSIVE", "safe_c4_mp");
  } else {
    radiusdamage(self.buildable.c4.origin, 256, 200, 105, undefined, "MOD_EXPLOSIVE", "safe_c4_mp");
  }

  self.buildable function_1c548268f36ed307();
  self.buildable.c4 delaycall(0.2, &setscriptablepartstate, "body", "init");
  self.buildable.c4 notify("death");
}

function function_1c548268f36ed307() {
  if(isDefined(self.c4)) {
    dangericonent = self.c4.dangericonent;

    if(isDefined(dangericonent)) {
      if(isDefined(dangericonent.headiconid)) {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon(dangericonent.headiconid);
      }

      dangericonent delete();
      self.c4.dangericonent = undefined;
    }
  }
}

function function_5163851170a11648(player) {
  player function_70d8ab10eee1b4d5(0, self.buildable);

  if(self.buildable function_7fdf326deb449f4e()) {
    waitframe();
  }

  thread function_5b1ba5a4f573aaa3(player);
  thread function_a82088bc1fe748a9(player);
  function_52a5fcc80a1f8533(player);
  gestureweapon = self.buildable.gestureweapon;

  if(isDefined(player) && isDefined(gestureweapon)) {
    player scripts\mp\gametypes\wm_utility::function_31325dbf3212f5ec(gestureweapon, 0.5);
  }

  var_5d8933c950c9a154 = "build";

  if(isDefined(self.var_5d8933c950c9a154)) {
    var_5d8933c950c9a154 = self.var_5d8933c950c9a154;
  }

  if(getbasegametype() != "escort") {
    thread scripts\mp\gametypes\wm_utility::function_e3cd4f9e858ab6ee(player, var_5d8933c950c9a154);
  }

  if(isDefined(self.buildable.triggeroutline)) {
    self.buildable.triggeroutline showtoplayer(player);
  }
}

function function_52a5fcc80a1f8533(player) {
  if(!isDefined(self.buildable.models[0])) {
    return;
  }

  self.buildable.models[0] makeusable();
  self.buildable.models[0] disableplayeruse(player);
  self.buildable.models[0] setusepriority(-1 - 1 - 1 - 1);
  self.buildable.models[0] setCursorHint("HINT_NOBUTTON");
  self.buildable.models[0] setHintString(&"MP_JUP_LAUNCHFACILITY/BEINGBUILT");
}

function function_5b1ba5a4f573aaa3(player) {
  self endon("stop_build");
  self endon("deleted");
  buildendtime = gettime() + (1 - self.buildable.buildphase) * self.usetime;
  progress = 1;
  self.buildable.var_9cfe63aea32bf01e = 1;

  while(progress > 0) {
    if(self.buildable function_7fdf326deb449f4e() && player scripts\mp\utility\weapon::grenadeinpullback()) {
      function_2d71060946497558(undefined, player, 0);
    }

    currenttime = gettime();
    var_b5a2aa5dd294274f = buildendtime - currenttime;
    progress = max(0, var_b5a2aa5dd294274f / self.usetime);
    self.curprogress = (1 - progress) * self.usetime;
    self.buildable updateprogress(player, 1 - progress, 0);
    self.buildable.var_9cfe63aea32bf01e = 0;
    waitframe();
  }
}

function function_2d71060946497558(team, player, result) {
  if(!istrue(result)) {
    self notify("stop_build");
    self.trigger makeunusable();

    if(istrue(self.var_4a03a924a61fd704)) {
      player function_70d8ab10eee1b4d5(1, self.buildable);
    }

    var_6a18fbf3e711e6c6 = 0.5;

    if(isDefined(self.buildable.gestureweapon)) {
      player scripts\mp\gametypes\wm_utility::function_dac4b69b3dfb574e();
      var_6a18fbf3e711e6c6 = player.var_3207c3128c689f62;
    }

    if(!istrue(self.var_4a03a924a61fd704)) {
      delaythread(var_6a18fbf3e711e6c6, &restoreusetrigger);
    }

    if(isDefined(self.buildable.var_fc147a62066d05bd)) {
      level[[self.buildable.var_fc147a62066d05bd]](player, self.buildable);
    }

    self.buildable function_a3395723ec35ab32();
  }

  player function_70d8ab10eee1b4d5(1, self.buildable);

  if(isDefined(self.buildable.triggeroutline)) {
    self.buildable.triggeroutline hidefromplayer(player);
  }

  if(isDefined(self.buildable.models[0])) {
    self.buildable.models[0] makeunusable();
  }

  if(getbasegametype() != "escort") {
    scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(player);
  }

  self notify("watch_destroyed_by_splash");
}

function restoreusetrigger() {
  self.trigger makeusable();
  self.trigger setusepriority(-1 - 1 - 1 - 1);
  self.trigger setuseholdduration("duration_none");
  scripts\mp\gameobjects::setusetime(self.buildusetime);
  scripts\mp\gameobjects::setusehinttext(self.hintstring);
}

function function_309305a89c073495() {
  self.trigger makeunusable();
  releaseid();
  self notify("deleted");
}

function function_79a41152cd2dc1f7(player) {
  self.trigger makeunusable();
  releaseid();

  if(isDefined(self.buildable.gestureweapon)) {
    player scripts\mp\gametypes\wm_utility::function_dac4b69b3dfb574e();
  }

  self.buildable updateprogress(player, 1, 0);

  if(isDefined(self.buildable.triggeroutline)) {
    self.buildable.triggeroutline hidefromplayer(player);
  }

  player function_70d8ab10eee1b4d5(1, self.buildable);

  if(getbasegametype() != "escort") {
    scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(player);
    player function_2591bed1172e3c08(1);
  }

  if(is_equal(self.buildable.zonename, level.zone.name)) {
    self.buildable.useobj releaseid();
    self.buildable.useobj scripts\mp\gameobjects::requestid(1, 0);
    self.buildable.useobj scripts\mp\gameobjects::setobjectivestatusicons("waypoint_Buildable_Built");
    self.buildable.useobj scripts\mp\gameobjects::setvisibleteam("any");
    scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(self.buildable.useobj.objidnum, 1);
  }

  self notify("deleted");
}

function function_2591bed1172e3c08(isbuild) {
  assert(isDefined(isbuild));
  var_6a3bdc897ff96d90 = 30000;

  if(isDefined(self.var_4b72d5e8f9b39c0a) && gettime() - self.var_4b72d5e8f9b39c0a < var_6a3bdc897ff96d90) {
    return;
  }

  self.var_4b72d5e8f9b39c0a = gettime();

  if(isbuild) {
    scripts\mp\utility\points::doscoreevent(#"wm_build");
    return;
  }

  scripts\mp\utility\points::doscoreevent(#"wm_destroy");
}

function function_70d8ab10eee1b4d5(isallowed, buildable) {
  if(!isallowed) {
    val::set("building", "allow_jump", 0);
    val::set("building", "melee", 0);
    val::set("building", "mantle", 0);
    val::set("building", "sprint", 0);
    val::set("building", "fire", 0);
    val::set("building", "reload", 0);
    val::set("building", "weapon_pickup", 0);
    val::set("building", "execution_victim", 0);
    val::set("building", "supers", 0);

    if(isDefined(buildable) && buildable function_7fdf326deb449f4e()) {
      val::set("building", "offhand_weapons", 0);
    }

    self function_35501b42058d4de9();
    return;
  }

  val::reset_all("building");
  self function_bb04491d50d9e43e();
}

function function_7fdf326deb449f4e() {
  return isDefined(self.gestureweapon) && self.gestureweapon == "nothing_here";
}

function function_ca34b4eff8624dbb(player, eventname) {
  player dlog_recordplayerevent("dlog_event_wm_player_buildable_data", ["match_guid", function_94c7ae7049488358(), "map_name", level.script, "player_team", player.team, "buildable_id", self.id, "event_name", eventname, "round", "" + game["roundsPlayed"]]);
}

function function_91f9e0306d5d65a0(objname) {
  if(!isDefined(level.buildablepool)) {
    level.buildablepool = [];
  }

  buildinfo = spawnStruct();
  level.buildablepool[objname] = buildinfo;
  return buildinfo;
}

function function_e2f7c2b8cdaefdd7(triggerent, hintstring, destroyusetime, destroyteam, var_5f7f91ab6d5c8af9) {
  destroyobj = scripts\mp\gameobjects::createuseobject(game["defenders"], triggerent, [], (0, 0, 0), 1, 1);

  if(isDefined(destroyteam)) {
    if(destroyteam == game["defenders"]) {
      destroyobj scripts\mp\gameobjects::allowuse("friendly");
    } else {
      destroyobj scripts\mp\gameobjects::allowuse("enemy");
    }
  }

  destroyobj.gestureweapon = "jup_war_ges_c4_plant";
  destroyobj.countdowntime = 3;
  destroyobj.var_84de0ddcdac2ea86 = 5 - destroyusetime;
  destroyobj.trigger makeusable();
  destroyobj.skiptouching = undefined;
  destroyobj.interactteam = "any";
  destroyobj.checkuseconditioninthink = 1;
  destroyobj.canusedestroy = 1;
  destroyobj.id = "wm_buildable";
  destroyobj.waitforweapononuse = 0;
  destroyobj.trigger setusepriority(-1 - 1 - 1 - 1);
  destroyobj scripts\mp\gameobjects::setusetime(destroyusetime);
  destroyobj scripts\mp\gameobjects::setusehinttext(hintstring);
  destroyobj.trigger setuseholdduration("duration_none");
  destroyobj.onbeginuse = &function_f292eea00564d752;
  destroyobj.onenduse = &function_5d8ecf5ea5db5efa;
  destroyobj.onuse = &function_3164e1c4e7e2f49c;
  destroyobj.var_5f7f91ab6d5c8af9 = var_5f7f91ab6d5c8af9;
  destroyobj.usecondition = &function_f6a64189578e480f;
  destroyobj.trigger setuserange(96);
  destroyobj.trigger setusefov(120);
  destroyobj.trigger sethintdisplayrange(96);
  destroyobj.trigger sethintdisplayfov(120);
  return destroyobj;
}

function function_17763afd915cc73c() {
  self notify("stop_get_progress");
  self endon("stop_get_progress");
  level endon("game_ended");
  pathnodes = getvehiclenodearray("tank_trap_pos", "script_noteworthy");
  pathnode = sortbydistance(pathnodes, self.origin)[0];
  scripts\mp\flags::gameflagwait("zone_2" + "_objective_start");
  distsquared = distance2dsquared(self.origin, pathnode.origin);

  if(distsquared > 3000) {
    assertmsg(distsquared + "<dev string:x25e>" + self.origin + "<dev string:x280>");
    self.buildable.useobj.trigger makeunusable();
  }

  self.progress = pathnode.progress;
}

function function_a0f277273d13196a(zoneinfo) {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait(zoneinfo + "_objective_start");
  tank = level.escortvehicles[0];

  while(!isDefined(self.triggerent.progress) || !isDefined(tank.progress) || !isDefined(tank.var_56df20c41f5b3159)) {
    waitframe();
  }

  var_31a72e6f2e39b666 = spawn("script_model", self.triggerent.origin);
  var_31a72e6f2e39b666.angles = self.triggerent.angles;
  var_31a72e6f2e39b666 makeusable();
  var_31a72e6f2e39b666 sethintdisplayrange(256);
  var_31a72e6f2e39b666 sethintdisplayfov(360);
  var_31a72e6f2e39b666 setuserange(256);
  var_31a72e6f2e39b666 setusefov(360);
  var_31a72e6f2e39b666 sethintonobstruction("show");
  var_31a72e6f2e39b666 setCursorHint("HINT_NOBUTTON");
  var_31a72e6f2e39b666 setHintString(&"MP/UNABLE_TO_BUILD_TRAP");

  while(self.buildphase == 0) {
    if(abs(self.triggerent.progress - tank.progress) > tank.var_56df20c41f5b3159 * 400) {
      self.useobj.trigger makeusable();

      foreach(player in level.players) {
        var_31a72e6f2e39b666 disableplayeruse(player);
      }
    } else {
      self.useobj.trigger makeunusable();

      foreach(player in level.players) {
        var_31a72e6f2e39b666 enableplayeruse(player);
      }
    }

    waitframe();
  }

  var_31a72e6f2e39b666 delete();
}

function function_5907a34f5fb0bf04(zoneinfo) {
  level endon("game_ended");
  self endon("deleted");
  scripts\mp\flags::gameflagwait(zoneinfo + "_objective_start");
  ref = self.models[0] getentitynumber();
  tank = level.escortvehicles[0];

  while(!isDefined(self.triggerent.progress) || !isDefined(tank.progress) || !isDefined(tank.var_56df20c41f5b3159)) {
    waitframe();
  }

  while(true) {
    if(!istrue(tank.var_7150b8620d62148[ref]) && istrue(function_4671e4cafead83aa(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 1;

      if(self.triggerent.progress > tank.progress) {
        tank.directionblocked[ref] = "forward";
      } else {
        tank.directionblocked[ref] = "backward";
      }
    }

    msg = waittill_notify_or_timeout_return("trap_destroyed", 0.2);

    if(msg == "trap_destroyed") {
      tank.var_7150b8620d62148[ref] = 0;
      break;
    }

    if(istrue(tank.var_7150b8620d62148[ref]) && !istrue(function_4671e4cafead83aa(tank.var_56df20c41f5b3159, self.triggerent.progress, tank.progress))) {
      tank.var_7150b8620d62148[ref] = 0;
    }
  }
}

function function_4671e4cafead83aa(var_56df20c41f5b3159, trapprogress, tankprogress) {
  return tankprogress - trapprogress > var_56df20c41f5b3159 * 170 * -1 && tankprogress - trapprogress < var_56df20c41f5b3159 * 210;
}