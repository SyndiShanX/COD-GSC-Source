/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4f9a55dee6aebc8f.gsc
*************************************************/

#using script_4948cdf739393d2d;
#using script_4f9a55dee6aebc8f;
#using script_64acb6ce534155b7;
#using script_744cad313ed0a87e;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment\flash_grenade;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\dmz_task_utils;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\trigger;
#using scripts\mp\utility\weapon;
#namespace namespace_1ab3ae0ffed87c04;

function function_7aae8cb0d8b0ac6a(data) {
  level.holdprop = spawnStruct();
  level.holdprop.circleradius = getdvarint(@ "hash_456cced132e54c3d", 138);
  level.holdprop.capturetime = getdvarfloat(@ "hash_70cb1dcb1d1ac8fe", 30);
  level.holdprop.var_1d0e180d1dd60548 = getdvarint(@ "hash_cae441d87fa6374d", 0);
  level.holdprop.var_cbb87a25616a7681 = getdvarint(@ "hash_d1ddb41c6c8a3af0", 4);
  level.holdprop.var_62623980dc128fd7 = getdvarint(@ "hash_ef416ac86fbcd18e", 6);
  level.holdprop.var_b78e47e5cb9e429a = getdvarfloat(@ "hash_9efddff4d4e1dc53", 0.2);
  level.holdprop.var_ee98df80874c48e0 = getdvarint(@ "hash_631c94c8c496ec51", 5);
  level.holdprop.var_281e288ae263a2b9 = getdvarfloat(@ "hash_9d45aadc299781b0", 0.5);
  level.holdprop.var_8bc6bb4728f30ffe = getdvarfloat(@ "hash_cecd445a628e208d", 0);
  level.holdprop.canemp = getdvarint(@ "hash_c81ebcee034129b5", 0);
  data.createfunc = &function_9490ccb2177749a8;

  if(!isDefined(level._effect["bomb_squad_explosion"])) {
    level._effect["bomb_squad_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  }
}

function function_9490ccb2177749a8(activity, owner) {
  task = task_create(activity);
  task.owner = owner;
  owner.task = task;
  task.players = [];
  task.funcs["onInit"] = &function_1c76ce9faf00edd7;
  task.funcs["onPlayerAssigned"] = &function_dd6410a59565d135;
  task.funcs["onPlayerJoined"] = &function_b380232fafd74325;
  task.funcs["onPlayerRemoved"] = &function_7204f8ab0ccdb640;
  task.funcs["onTeamStart"] = &function_b28dc157dbd35764;
  task.funcs["onPlayerExitVolume"] = &function_fc5cebaf6ff3bfd6;
  task.funcs["onPlayerExitTimeout"] = &function_e09f977d133bac40;
  task.funcs["onPlayerReenterVolume"] = &function_e687ce41da9f8ef7;
  task.ref = "br_hold";
  task.refindex = namespace_1eb3c4e0e28fac71::getquesttableindex(task.ref);
  task.spawntrap = 0;
  task.tier = task.owner namespace_bd614c3c2275579a::function_b7a9796c95aa8e8d();

  if(task.tier == "black") {
    task.mission_index = 49;
    task.mission_complete = 50;
    task.mission_fail = 0;
    task.mission_fail_warning = 0;
    task.var_3fa17a5a7af04803 = 65;
  } else {
    task.mission_index = 49;
    task.mission_complete = 50;
    task.mission_fail = 0;
    task.mission_fail_warning = 0;
    task.var_3fa17a5a7af04803 = 65;
  }

  return task;
}

function function_1c76ce9faf00edd7() {
  task = self;
  task.activity.origin = task.owner.origin;
  task.circleradius = level.holdprop.circleradius;
  level.iconneutral = "hold_icon_captureneutral_br";
  level.iconcapture = "hold_icon_capture_br";
  level.var_1ab489e74bd53602 = "hold_icon_capture_enemy_br";
  level.icondefend = "hold_icon_defend_br";
  level.icondefending = "hold_icon_defending_br";
  level.iconcontested = "hold_icon_contested_br";
  level.icontaking = "hold_icon_taking_br";
  level.var_fa0fe1eb08253674 = "hold_icon_taking_enemy_br";
  level.iconlosing = "hold_icon_losing_br";
  level.iconovertime = "hold_icon_ot_br";
}

function function_62d882541a989602() {
  task = self;
  trigger = undefined;

  if(!istrue(task.owner.var_67587a308d2aa143)) {
    trigger = spawn("trigger_radius", task.owner.loadout[0].origin, 0, level.holdprop.circleradius, 62);
  } else {
    trigger = task.owner.var_6dbd65fc3942bf53;
  }

  task.holdpoint = task function_90087f601daf9fa1(trigger, "neutral", 0, 1, 0);
  task.holdpoint.onuse = &function_9498066c4d179fc0;
  task.holdpoint.onbeginuse = &function_423f3fa547719245;
  task.holdpoint.onenduse = &function_581b3c43aba983c5;
  task.holdpoint.id = "domFlag";
  task.holdpoint.ignorestomp = 0;
  task.holdpoint scripts\mp\gameobjects::requestid(0, 1, undefined, 0, 0);
  task.holdpoint.visibilitymanuallycontrolled = 1;
  task.holdpoint.stronghold = task.owner;
  task.holdpoint.task = task;
  task.circlecenter = task.holdpoint.origin;
  objective_removeallfrommask(task.holdpoint.objidnum);
  objective_showtoplayersinmask(task.holdpoint.objidnum);

  if(level.holdprop.canemp) {
    task.holdpoint.trigger scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_271a1d82062c2492);
    task.holdpoint.trigger.var_3545410459b16762 = &function_271a1d82062c2492;
    task.holdpoint.trigger.stronghold = task.owner;
  }

  if(istrue(task.owner.var_67587a308d2aa143)) {
    task.holdpoint.var_ba8ebd863c649d8e = [];
    task.holdpoint.var_ba8ebd863c649d8e[task.holdpoint.var_ba8ebd863c649d8e.size] = task.owner.capturedteam;
  }

  task function_dd16568083975585();
}

function function_90087f601daf9fa1(trigger, team, var_5ddbc1faed2c56e6, skipobjid, showoncompass) {
  task = self;
  function_b8069681edb5d72d();
  trigger function_57257d1ed9ce2f48(&function_a75fac84a75a8110);
  trigger.task = task;
  visuals[0] = spawn("script_model", trigger.origin);
  visuals[0] setModel("tag_origin");
  visuals[0].angles = task.owner.loadout[0].angles;

  if(!isDefined(level.var_fb607d7bf823f6f9)) {
    level.var_fb607d7bf823f6f9 = level.holdprop.capturetime * 0.5;
  }

  reservedobjid = undefined;
  team = "neutral";
  domflag = scripts\mp\gameobjects::createuseobject(team, trigger, visuals, (0, 0, 62), reservedobjid, skipobjid, showoncompass);
  domflag scripts\mp\gameobjects::allowuse("any");
  domflag scripts\mp\gameobjects::cancontestclaim(1);
  domflag scripts\mp\gameobjects::setusetime(level.holdprop.capturetime);
  domflag scripts\mp\gameobjects::pinobjiconontriggertouch();

  if(isDefined(level.capturetype)) {
    domflag scripts\mp\gameobjects::setcapturebehavior(scripts\mp\gametypes\obj_dom::getcapturetype());
  }

  domflag.onuse = &function_9498066c4d179fc0;
  domflag.onbeginuse = &function_423f3fa547719245;
  domflag.onenduse = &function_581b3c43aba983c5;
  domflag.onuncontested = &function_425361a8192f04a3;
  domflag.oncontested = &function_37011fa9cb797322;
  domflag.onuseupdate = &scripts\mp\gametypes\obj_dom::dompoint_onuseupdate;
  domflag.onpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onpinnedstate;
  domflag.onunpinnedstate = &scripts\mp\gametypes\obj_dom::dompoint_onunpinnedstate;
  domflag.nousebar = 1;
  domflag.id = "domFlag";
  domflag.claimgracetime = level.holdprop.capturetime * 1000;
  domflag.firstcapture = 1;
  domflag.var_823c5a7bf6a0e64a = 0;
  domflag.var_fb60f3aec3a62f06 = level.flagmodelhidden;

  if(istrue(domflag.var_823c5a7bf6a0e64a)) {
    domflag.reinforcementmax = domflag.usetime - 1;
    domflag.reinforcementstompscalar = level.reinforcementstompscalar;

    if(isDefined(level.flagdecaytime) && level.flagdecaytime > 0) {
      domflag.decayrate = domflag.usetime * level.framedurationseconds / level.flagdecaytime;
    }
  }

  domflag.baseeffectpos = trigger.origin;

  if(getdvarint(@ "hash_ac14d98c253c4715", 1) == 1) {
    if(!istrue(task.owner.var_67587a308d2aa143)) {
      var_c6b7900c1fa0a1b6 = trigger.origin;
      vfxscriptable = spawn("script_model", var_c6b7900c1fa0a1b6);
      vfxscriptable setModel("stronghold_control_point");
      vfxscriptable.angles = task.owner.loadout[0].angles;
      vfxscriptable setscriptablepartstate("flag", "idle");
      domflag.vfxnamemod = vfxscriptable;
      vfxscriptable.domflag = domflag;
    }
  }

  domflag.noscriptable = 1;
  domflag scripts\mp\gametypes\obj_dom::initializematchrecording();

  if(!istrue(skipobjid)) {
    domflag scripts\mp\gametypes\obj_dom::domflag_setneutral();
  }

  return domflag;
}

function function_a75fac84a75a8110() {
  trigger = self;

  if(isDefined(trigger.task)) {
    trigger.task thread namespace_b8f885001f04bb5::function_addda96ba479db4e(undefined, 1, undefined, istrue(trigger.task.holdpoint.var_554291b6257ea5d0));
  }

  return false;
}

function function_425361a8192f04a3(lastclaimteam) {
  if(istrue(level.flagneutralization) && !self.firstcapture) {
    scripts\mp\gameobjects::setusetime(level.flagcapturetime * 0.5);
  }

  self.contestedtime = undefined;
  self.didstatusnotify = 0;
  ownerteam = scripts\mp\gameobjects::getownerteam();
  flagstate = ter_op(ownerteam == "neutral", "idle", ownerteam);
  thread scripts\mp\gametypes\obj_dom::updateflagstate(flagstate, 0);
  self.task function_68b9ba1de74cb130();

  foreach(player in self.task.players) {
    if(player getclientomnvar("ui_br_stronghold_mission") == self.task.var_3fa17a5a7af04803) {
      player setclientomnvar("ui_br_stronghold_mission", self.task.mission_index);
    }
  }
}

function function_b8069681edb5d72d() {
  _setdomencountericoninfo("hold_icon_captureneutral_br", "neutral", "hud_icon_objective_defend_point_neutral");
  _setdomencountericoninfo("hold_icon_defend_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_defending_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_contested_br", "contest", "hud_icon_objective_defend_point_contest");
  _setdomencountericoninfo("hold_icon_losing_br", "enemy", "hud_icon_objective_defend_point_enemy");
  _setdomencountericoninfo("hold_icon_ot_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_taking_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_taking_enemy_br", "enemy", "hud_icon_objective_defend_point_enemy");
  _setdomencountericoninfo("hold_icon_capture_br", "friendly", "hud_icon_objective_defend_point_friendly");
  _setdomencountericoninfo("hold_icon_capture_enemy_br", "enemy", "hud_icon_objective_defend_point_enemy");
}

function _setdomencountericoninfo(name, colors, icon) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = 1;
  level.waypointshader[name] = icon;
}

function function_37011fa9cb797322(lastclaimteam) {
  scripts\mp\gametypes\obj_dom::dompoint_oncontested();

  foreach(player in self.task.players) {
    if(player getclientomnvar("ui_br_stronghold_mission") != self.task.var_3fa17a5a7af04803) {
      player setclientomnvar("ui_br_stronghold_mission", self.task.var_3fa17a5a7af04803);
    }
  }

  self.task function_68b9ba1de74cb130();
}

function function_423f3fa547719245(player) {
  if(isDefined(self.stronghold.capturedteam) && isDefined(self.claimteam)) {
    if(self.claimteam == self.stronghold.capturedteam) {
      self.task brtask_holdsetvisible(0);
    } else {
      self.task notify("stronghold_enemy_capture_start");
    }
  }

  holdpoint = self;
  player.iscapturing = 1;
  ownerteam = scripts\mp\gameobjects::getownerteam();

  if(ownerteam == "neutral" && isPlayer(player)) {
    player setclientomnvar("ui_objective_pinned_text_param", 1);
  }

  self.didstatusnotify = 1;
  self.task function_68b9ba1de74cb130();
}

function function_9498066c4d179fc0(player) {
  holdpoint = self;
  isvalidplayer = isDefined(player) && isPlayer(player) && isalive(player);

  if(isvalidplayer) {
    if(istrue(level.var_25e8b4afe5e06169)) {
      level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(holdpoint.stronghold.origin, "revive", 1);
      dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

      if(!isDefined(holdpoint.var_ba8ebd863c649d8e)) {
        holdpoint.var_ba8ebd863c649d8e = [];
      }

      if(!istrue(holdpoint.var_3c83e6760ebc0979) && !array_contains(holdpoint.var_ba8ebd863c649d8e, player.team) && !istrue(holdpoint.stronghold.var_67587a308d2aa143)) {
        if(isDefined(holdpoint.stronghold.var_6278cec927f21e0) && holdpoint.stronghold.var_6278cec927f21e0 != player.team && !istrue(level.var_702998e8e05d126f)) {
          if(!isDefined(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5)) {
            player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, getteamarray(player.team, 0), player.team);
            holdpoint.var_ba8ebd863c649d8e = array_add(holdpoint.var_ba8ebd863c649d8e, player.team);
          } else if(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5 < level.var_153bec2ca80c491a) {
            player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, getteamarray(player.team, 0), player.team);
            holdpoint.var_ba8ebd863c649d8e = array_add(holdpoint.var_ba8ebd863c649d8e, player.team);
          }
        } else if(!isDefined(holdpoint.stronghold.capturedteam) && !isDefined(holdpoint.stronghold.var_6278cec927f21e0)) {
          if(!isDefined(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5)) {
            holdpoint.stronghold.var_6278cec927f21e0 = player.team;
            player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, getteamarray(player.team, 0), player.team);
            holdpoint.var_ba8ebd863c649d8e = array_add(holdpoint.var_ba8ebd863c649d8e, player.team);
          } else if(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5 < level.var_153bec2ca80c491a) {
            holdpoint.stronghold.var_6278cec927f21e0 = player.team;
            player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, getteamarray(player.team, 0), player.team);
            holdpoint.var_ba8ebd863c649d8e = array_add(holdpoint.var_ba8ebd863c649d8e, player.team);
          }
        }
      }

      holdpoint.task function_addda96ba479db4e(player.team, 0, 1, istrue(holdpoint.var_554291b6257ea5d0));
      holdpoint.task.owner function_c148f98e91e7df37(dropstruct, player);
      return;
    }

    level thread namespace_1eb3c4e0e28fac71::utilflare_shootflare(holdpoint.stronghold.origin, "revive", 1);
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    holdpoint.task.owner function_c148f98e91e7df37(dropstruct, player);
    function_6f6f83ab76483811(holdpoint.task, player);

    if(!istrue(holdpoint.var_3c83e6760ebc0979)) {
      if(!isDefined(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5)) {
        player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, getteamarray(player.team, 0), player.team);
      } else if(level.var_f1073fbd45b59a06.var_68693acbfbb8f4f5 < level.var_153bec2ca80c491a) {
        player namespace_bd614c3c2275579a::function_9d216f4cd30f141d(dropstruct, getteamarray(player.team, 0), player.team);
      }
    }

    holdpoint.task function_addda96ba479db4e(player.team, undefined, undefined, istrue(holdpoint.var_554291b6257ea5d0));
  }
}

function function_581b3c43aba983c5(team, player, success) {
  if(isPlayer(player)) {
    player.iscapturing = 0;
    player setclientomnvar("ui_objective_pinned_text_param", 0);
    player.ui_dom_securing = undefined;
  }

  self.task brtask_holdsetvisible(0);
  self.task function_68b9ba1de74cb130();
  self.didstatusnotify = 0;

  if(isDefined(team) && team == "none" || player.team != team) {
    return;
  }

  thread scripts\mp\gametypes\obj_dom::updateflagstate(team, 0);
  self.neutralized = 0;
}

function function_750304b9f07eb073(player) {
  task = self;
  teamname = player.team;
  task notify("strongholdNeutralize");
  task endon("strongholdNeutralize");
  task endon("stronghold_recapture");
  task endon("stronghold_enemy_capture_start");
  delaytimes = getdvarint(@ "hash_d95a688350cfedbc", 30);

  if(isDefined(delaytimes)) {
    wait delaytimes;
  }

  var_5f8fc154303502fa = task scripts\mp\gametypes\activity_manager::function_ad20469c1815a7c7(teamname, 1);

  if(var_5f8fc154303502fa.size > 0) {
    return;
  }

  task function_3b3b119a92986947(player, 0, "timeout");
}

function function_3b3b119a92986947(player, fromemp, var_384785a7fc070482) {
  task = self;
  teamname = player.team;

  if(isDefined(task.holdpoint.stronghold)) {
    if(istrue(fromemp) || istrue(level.var_ac1bfebb54363b49) && task.holdpoint.stronghold.capturedteam == teamname) {
      task.owner notify("fortressNeutralized");
    }

    function_d95dbf57b47734d9(task.holdpoint.stronghold, 0);

    if(task.holdpoint.stronghold.proximitytrigger.playercount > 0 && !istrue(fromemp)) {
      function_d95dbf57b47734d9(task.holdpoint.stronghold, 1);
    }

    player namespace_bd614c3c2275579a::function_20ade7ff2a106977(task.holdpoint.stronghold, var_384785a7fc070482, "neutralized");
  }

  if(isDefined(task.owner) && isDefined(task.owner.crate) && isDefined(task.owner.crate.players)) {
    foreach(matchplayer in task.owner.crate.players) {
      task.owner.crate namespace_bd614c3c2275579a::function_648d8f21bd9dc5c4(matchplayer);
    }

    task.owner.crate.players = [];
  }

  task.holdpoint scripts\mp\gametypes\obj_dom::domflag_setneutral();
  task.holdpoint scripts\mp\gameobjects::resetcaptureprogress();
  scripts\mp\objidpoolmanager::objective_set_progress_team(task.holdpoint.objidnum, "none");
  scripts\mp\objidpoolmanager::objective_set_progress(task.holdpoint.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_show_progress(task.holdpoint.objidnum, 0);
  task.holdpoint.stronghold.capturedteam = undefined;
  task function_68b9ba1de74cb130();
}

function function_29c7e65e828011cf(enable) {
  if(enable) {
    scripts\mp\gameobjects::allowuse("any");
    self.trigger scripts\engine\utility::trigger_on();
    return;
  }

  scripts\mp\gameobjects::allowuse("none");
  self.trigger scripts\engine\utility::trigger_off();
}

function brtask_holdsetvisible(enable, preview, var_ddf49b0f7bd17a0c) {
  task = self;
  task.holdpoint notify("brTask_holdSetVisible");

  if(enable) {
    task function_68b9ba1de74cb130();
    return;
  }

  task.holdpoint function_5f306cd80ad9fd17(task.owner, preview, var_ddf49b0f7bd17a0c);
}

function function_5f306cd80ad9fd17(owner, preview, var_ddf49b0f7bd17a0c) {
  holdpoint = self;
  holdpoint endon("brTask_holdSetVisible");

  if(!istrue(var_ddf49b0f7bd17a0c)) {
    objective_setpinned(holdpoint.objidnum, 0);
    wait 1;
  }

  holdpoint.task function_562f681bfeedc7c3();
}

function function_69826af85003ab57(owner) {
  holdpoint = self;

  if(!isDefined(owner.proximitytrigger)) {
    return;
  }

  objective_removeallfrommask(holdpoint.objidnum);

  foreach(ent in owner.proximitytrigger.touchents) {
    if(isPlayer(ent) && isreallyalive(ent)) {
      objective_addclienttomask(holdpoint.objidnum, ent);
    }
  }
}

function function_562f681bfeedc7c3() {
  task = self;
  objective_removeallfrommask(task.holdpoint.objidnum);
  objective_removeallfrommask(task.var_936e3ff613f879a1.objidnum);
}

function function_dd6410a59565d135(teamname, player, var_554291b6257ea5d0) {
  if(!isDefined(var_554291b6257ea5d0)) {
    var_554291b6257ea5d0 = 0;
  }

  task = self;
  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);
  task.owner namespace_bd614c3c2275579a::function_dacf98a6e7acadeb(player, player.team);

  if(!istrue(player.var_3e65a82afb7eb67)) {
    player.var_3e65a82afb7eb67 = 1;
  } else {
    return;
  }

  if(!var_554291b6257ea5d0) {
    task thread scripts\mp\gametypes\activity_manager::function_a33c10c0682918bd(task.owner.missiontrigger, 0);
  }

  if(!isDefined(task.holdpoint)) {
    task function_62d882541a989602();
    task.holdpoint.originalteam = player.team;

    if(istrue(level.holdprop.var_1d0e180d1dd60548)) {
      task thread namespace_bd614c3c2275579a::function_6162d039fd0cdbd4(task.owner, "high", level.holdprop.var_cbb87a25616a7681);
      task thread function_56d0be781029a019();
    }
  }

  if(isDefined(task.holdpoint) && !istrue(task.holdpoint.tempdisabled)) {
    if(istrue(level.var_25e8b4afe5e06169)) {
      if(!isDefined(task.holdpoint.stronghold.capturedteam)) {
        namespace_9823ee6035594d67::function_d95dbf57b47734d9(task.owner, 1);
      }
    } else {
      namespace_9823ee6035594d67::function_d95dbf57b47734d9(task.owner, 1);
    }
  }

  if(var_aa128e29d7c10074) {
    task function_b380232fafd74325(player, var_554291b6257ea5d0);
    return;
  }

  if(!istrue(level.br_circle_disabled)) {
    task thread function_682e6a05a3109ea1(var_554291b6257ea5d0);
  }

  task function_b380232fafd74325(player, var_554291b6257ea5d0);
  player.var_3e65a82afb7eb67 = undefined;
}

function function_56d0be781029a019() {
  level endon("game_ended");
  task = self;
  task endon("task_ended");

  while(isDefined(task.holdpoint) && isDefined(task.holdpoint.usetime) && task.holdpoint.usetime * level.holdprop.var_b78e47e5cb9e429a > task.holdpoint.curprogress) {
    wait 0.5;
  }

  thread namespace_bd614c3c2275579a::function_6162d039fd0cdbd4(task.owner, "high", level.holdprop.var_62623980dc128fd7);

  while(isDefined(task.holdpoint) && isDefined(task.holdpoint.usetime) && task.holdpoint.usetime * level.holdprop.var_281e288ae263a2b9 > task.holdpoint.curprogress) {
    wait 0.5;
  }

  thread namespace_bd614c3c2275579a::function_6162d039fd0cdbd4(task.owner, "high", level.holdprop.var_ee98df80874c48e0);
}

function function_b380232fafd74325(player, var_554291b6257ea5d0) {
  if(!isDefined(var_554291b6257ea5d0)) {
    var_554291b6257ea5d0 = 0;
  }

  task = self;

  if(istrue(task.holdpoint.tempdisabled)) {
    return;
  }

  if(!isDefined(array_find(task.players, player))) {
    size = task.players.size;
    task.players[size] = player;
  }

  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(var_aa128e29d7c10074) {
    return;
  }

  var_d0cb4e7edbd1a617 = player getclientomnvar("ui_br_stronghold_mission");

  if(!isDefined(task.originalteam)) {
    task.originalteam = player.team;
  }

  if(!istrue(task.holdpoint.tempdisabled)) {
    task.holdpoint function_29c7e65e828011cf(1);
  }

  task brtask_holdsetvisible(1);
  player.initialized_gameobject_vars = 1;

  if(!isDefined(player.touchtriggers)) {
    player.touchtriggers = [];
  }

  if(!var_554291b6257ea5d0 && (!isDefined(task.holdpoint.stronghold.capturedteam) || task.holdpoint.stronghold.capturedteam != player.team)) {
    player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line");
    wait 4;
  }

  if(!isDefined(player) || !array_contains(task.players, player)) {
    return;
  }

  if(!var_554291b6257ea5d0 && var_d0cb4e7edbd1a617 == player getclientomnvar("ui_br_stronghold_mission")) {
    player setclientomnvar("ui_br_stronghold_mission", task.mission_index);
  }

  task function_1851e9cfb7687f68(player);

  if(level.holdprop.var_8bc6bb4728f30ffe) {
    task thread function_f2aabfd0e35a668b();
  }
}

function function_7204f8ab0ccdb640(player, var_554291b6257ea5d0) {
  if(!isDefined(var_554291b6257ea5d0)) {
    var_554291b6257ea5d0 = 0;
  }

  task = self;
  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(!var_554291b6257ea5d0) {
    task.players = array_remove(task.players, player);
  }

  if(var_aa128e29d7c10074) {
    return;
  }

  if(!var_554291b6257ea5d0) {
    player setclientomnvar("ui_br_stronghold_mission", task.mission_fail);
  }

  task.holdpoint function_581b3c43aba983c5(player.team, player, 0);
  task notify("left_activity_area");
}

function function_f2aabfd0e35a668b() {
  task = self;
  level endon("<dev string:x1c>");
  task endon("<dev string:x2a>");
  color = (0.5, 1, 1);

  while(true) {
    draw_circle(task.holdpoint.trigger.origin + (0, 0, 5), level.holdprop.circleradius, color, 1, 1, 1);
    waitframe();
  }
}

function function_b28dc157dbd35764(teamname) {
  assert(1, "<dev string:x40>");
}

function function_59a5a14bce811cdd(teamname, omnvarstate, detonated, teamcompleted, var_554291b6257ea5d0) {
  if(!isDefined(var_554291b6257ea5d0)) {
    var_554291b6257ea5d0 = 0;
  }

  task = self;
  var_5f8fc154303502fa = task scripts\mp\gametypes\activity_manager::function_ad20469c1815a7c7(teamname, 1);

  if(!var_554291b6257ea5d0) {
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].activities = array_remove(level.var_1b7407dffe81e6e8.teamsinfo[teamname].activities, task.activity.id);
    task.teams = array_remove(task.teams, teamname);
    level.var_1b7407dffe81e6e8.teamsinfo[teamname].active = 0;
  }

  var_e4ba0357793fd3c7 = !var_554291b6257ea5d0;

  foreach(player in var_5f8fc154303502fa) {
    if(!var_554291b6257ea5d0) {
      task.players = array_remove(task.players, player);
      task.holdpoint function_581b3c43aba983c5(teamname, player, teamcompleted);
    }

    if(scripts\cp_mp\utility\game_utility::isaigameparticipant(player)) {
      continue;
    }

    if(!var_554291b6257ea5d0 || !istrue(detonated)) {
      task function_aeb2d6fe1ee9d0f3(player, detonated, omnvarstate, var_e4ba0357793fd3c7);
    }
  }
}

function function_fc5cebaf6ff3bfd6(player) {
  task = self;
  player.var_e09c6ea56555f1ed = 1;
  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(!var_aa128e29d7c10074) {
    player setclientomnvar("ui_br_stronghold_mission", task.mission_fail_warning);
  }
}

function function_e687ce41da9f8ef7(player) {
  task = self;
  player.var_e09c6ea56555f1ed = undefined;
  var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

  if(!var_aa128e29d7c10074) {
    player setclientomnvar("ui_br_stronghold_mission", task.mission_index);
  }

  if(isDefined(task.holdpoint.stronghold.capturedteam) && player.team == task.holdpoint.stronghold.capturedteam) {
    task notify("stronghold_recapture");
  }
}

function function_e09f977d133bac40(player) {
  task = self;
  task function_7204f8ab0ccdb640(player);
  player.var_e09c6ea56555f1ed = 1;

  if(isDefined(level.var_fc0e8c2ea4f84613)) {
    task[[level.var_fc0e8c2ea4f84613]](player);
  }

  if(istrue(level.var_ac1bfebb54363b49) && isDefined(task.holdpoint.stronghold.capturedteam) && player.team == task.holdpoint.stronghold.capturedteam) {
    task thread function_750304b9f07eb073(player);
  }
}

function private function_aeb2d6fe1ee9d0f3(player, detonated, omnvarstate, var_e4ba0357793fd3c7) {
  task = self;

  if(istrue(var_e4ba0357793fd3c7)) {
    player setclientomnvar("ui_br_stronghold_mission", omnvarstate);
  }

  if(omnvarstate == task.mission_complete) {
    player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_completed");
    return;
  }

  if(istrue(detonated)) {
    player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_failed");
  } else {
    player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_failed");
  }

  if(istrue(var_e4ba0357793fd3c7)) {
    player setclientomnvar("ui_br_stronghold_mission", 0);
  }
}

function private function_addda96ba479db4e(teamname, detonated, loop, var_554291b6257ea5d0) {
  if(!isDefined(var_554291b6257ea5d0)) {
    var_554291b6257ea5d0 = 0;
  }

  task = self;

  if(isDefined(level.var_3afacc0c3b10b7fe) && isDefined(teamname)) {
    task.owner[[level.var_3afacc0c3b10b7fe]](teamname, !istrue(detonated));
  }

  var_e4ba0357793fd3c7 = !var_554291b6257ea5d0;

  if(istrue(loop)) {
    if(isDefined(task.holdpoint.stronghold.capturedteam)) {
      foreach(player in getteamdata(task.holdpoint.stronghold.capturedteam, "players")) {
        player thread scripts\mp\hud_message::showsplash("stronghold_operation_hold_the_line_stolen");
      }
    }

    foreach(team in task.teams) {
      teamcompleted = 0;

      if(isDefined(teamname) && isDefined(team)) {
        teamcompleted = team == teamname;
      }

      omnvarstate = task.mission_fail;

      if(teamcompleted) {
        omnvarstate = task.mission_complete;
      }

      var_5f8fc154303502fa = task scripts\mp\gametypes\activity_manager::function_ad20469c1815a7c7(team, 1);

      foreach(player in var_5f8fc154303502fa) {
        if(isDefined(task.holdpoint.stronghold.capturedteam)) {
          if(player.team == task.holdpoint.stronghold.capturedteam) {
            continue;
          }
        }

        if(scripts\cp_mp\utility\game_utility::isaigameparticipant(player)) {
          continue;
        }

        task function_aeb2d6fe1ee9d0f3(player, detonated, omnvarstate, var_e4ba0357793fd3c7);
      }
    }

    return;
  }

  if(!var_554291b6257ea5d0) {
    task notify("task_ended");
    namespace_9823ee6035594d67::function_be5a531f97b7c07e(task.owner);
  }

  deletetask = 0;

  foreach(team in task.teams) {
    teamcompleted = 0;

    if(isDefined(teamname) && isDefined(team)) {
      teamcompleted = team == teamname;
    }

    omnvarstate = task.mission_fail;

    if(teamcompleted) {
      deletetask = 1;
      omnvarstate = task.mission_complete;
    }

    task function_59a5a14bce811cdd(team, omnvarstate, detonated, teamcompleted, var_554291b6257ea5d0);
  }

  if(!var_554291b6257ea5d0) {
    task.players = [];
    task.teams = [];
    task function_2476daefa3384c5e();
    task function_629ed367d1393020();
    task function_114582ecfebb0acc();
  }

  if(istrue(detonated)) {
    task.owner.crate thread namespace_bd614c3c2275579a::function_faa1ecbc7f0bed85(undefined, 0, 1, 1, 0);
  }

  if(!isDefined(detonated)) {
    detonated = 0;
  }

  if(!var_554291b6257ea5d0) {
    task.starttime = undefined;

    if(isDefined(task.activity) && isDefined(task.activity.tasks) && task.activity.tasks.size >= 1 && (deletetask || detonated)) {
      task.owner.missiontrigger notify("activity_ended");
      level.var_1b7407dffe81e6e8.activities[task.activity.id] = undefined;
      task.activity.tasks = undefined;
      scripts\mp\gametypes\obj_dom::removeobjective(task.holdpoint);
    }

    return;
  }

  if(istrue(detonated)) {
    scripts\mp\gametypes\obj_dom::removeobjective(task.holdpoint);

    if(isDefined(task.holdpoint.vfxnamemod)) {
      task.holdpoint.vfxnamemod setscriptablepartstate("flag", "off");
    }
  }
}

function function_682e6a05a3109ea1(var_554291b6257ea5d0) {
  task = self;
  level endon("game_ended");

  if(!var_554291b6257ea5d0) {
    task endon("task_ended");
    task.owner.missiontrigger endon("deleted");
    task.owner.missiontrigger endon("activity_ended");
  }

  if(istrue(task.owner.gaswatch)) {
    return;
  }

  origin = task.owner.origin + (0, 0, 62);
  task.owner.gaswatch = 1;
  waitframe();
  waittillframeend();

  while(scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(origin) || scripts\mp\gametypes\br_circle_util::function_a465e3c1371d7dab(origin)) {
    wait 0.25;
  }

  if(!var_554291b6257ea5d0) {
    foreach(player in task.players) {
      if(!isDefined(player)) {
        continue;
      }

      var_aa128e29d7c10074 = scripts\cp_mp\utility\game_utility::isaigameparticipant(player);

      if(var_aa128e29d7c10074) {
        continue;
      }

      task thread function_e09f977d133bac40(player);
    }
  }

  task thread function_addda96ba479db4e(undefined, 1, undefined, var_554291b6257ea5d0);
}

function function_c148f98e91e7df37(dropstruct, player) {
  fortress = self;

  if(istrue(fortress.isblacksite)) {
    uavtype = "directional_uav";
  } else {
    uavtype = "uav";
  }

  player namespace_bd614c3c2275579a::function_20ade7ff2a106977(fortress, "captured", "captured");

  if(istrue(level.var_25e8b4afe5e06169) && istrue(fortress.captured)) {
    fortress namespace_bd614c3c2275579a::function_5c26662d5381e975(player, undefined, uavtype, 1);
    return;
  }

  fortress namespace_bd614c3c2275579a::function_5c26662d5381e975(player, undefined, uavtype, 1);

  if(istrue(level.var_10171e70e51c0380)) {
    function_11245b6b51ac26b7(dropstruct, player, fortress.crate);
  }
}

function function_11245b6b51ac26b7(dropstruct, player, crate) {
  var_4dbe8ef27554367a = getdvarint(@ "hash_3174d9a2553a5fa7", 1);
  lootdrops = getscriptcachecontents("bomb_defuse_reward", 0);
  var_df2f68507645906f = ["brloot_super_munitionsbox", "brloot_super_armorbox"];
  teammatecount = undefined;
  teammates = scripts\mp\utility\teams::getsquadmates(player.team, player.sessionsquadid, 0);

  if(isDefined(teammates)) {
    teammatecount = teammates.size;
  }

  if(var_4dbe8ef27554367a >= 0) {
    for(i = 0; i < var_4dbe8ef27554367a; i++) {
      randomindex = randomintrange(0, 25);
      lootdrops = getscriptcachecontents("bomb_defuse_reward", randomindex);
      function_3d712346afff9ef3(dropstruct, player, crate, lootdrops);
    }
  } else if(isDefined(teammatecount)) {
    for(i = 0; i < teammatecount; i++) {
      randomindex = randomintrange(0, 25);
      lootdrops = getscriptcachecontents("bomb_defuse_reward", randomindex);
      lootdrops[lootdrops.size] = var_df2f68507645906f[i % var_df2f68507645906f.size];
      function_3d712346afff9ef3(dropstruct, player, crate, lootdrops);
    }
  } else {
    function_3d712346afff9ef3(dropstruct, player, crate, lootdrops);
  }

  if(getdvarint(@ "hash_81e631c248118cd6", 1) != 1) {
    return;
  }

  dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
  count = level.br_pickups.counts["brloot_gascan_palfa"];
  spawned = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_gascan_palfa", dropinfo, count);
}

function function_3d712346afff9ef3(dropstruct, player, crate, lootdrops) {
  if(isDefined(crate) && getdvarint(@ "hash_13c3754911cca521", 1)) {
    crate.itemsdropped = 0;
    crate scripts\mp\gametypes\br_lootcache::lootspawnitemlist(dropstruct, lootdrops, 1, player);
    return;
  }

  count = undefined;

  foreach(lootdrop in lootdrops) {
    dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, player.origin, player.angles, player);
    count = level.br_pickups.counts[lootdrop];
    spawned = scripts\mp\gametypes\br_pickups::spawnpickup(lootdrop, dropinfo, count);

    if(isDefined(spawned)) {
      spawned setscriptablepartstate(lootdrop, "dropped");
    }
  }
}

function function_dd16568083975585() {
  task = self;
  task.var_936e3ff613f879a1 = spawnStruct();
  task.var_936e3ff613f879a1.curorigin = task.holdpoint.curorigin;
  task.var_936e3ff613f879a1.offset3d = task.holdpoint.offset3d;
  task.var_936e3ff613f879a1 scripts\mp\gameobjects::requestid(0, 1, undefined, 0, 0);
  icon = scripts\mp\gameobjects::getwaypointshader(level.var_1ab489e74bd53602);
  scripts\mp\objidpoolmanager::update_objective_icon(task.var_936e3ff613f879a1.objidnum, icon);
  backgroundtype = scripts\mp\gameobjects::getwaypointbackgroundtype(level.var_1ab489e74bd53602);
  scripts\mp\objidpoolmanager::update_objective_setbackground(task.var_936e3ff613f879a1.objidnum, backgroundtype);
  objective_setshowprogress(task.var_936e3ff613f879a1.objidnum, 1);
  objective_removeallfrommask(task.var_936e3ff613f879a1.objidnum);
  objective_showtoplayersinmask(task.var_936e3ff613f879a1.objidnum);
  task thread function_8676671228ac7f2c(task.holdpoint, task.var_936e3ff613f879a1);
}

function function_114582ecfebb0acc() {
  task = self;

  if(isDefined(task.var_936e3ff613f879a1)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(task.var_936e3ff613f879a1.objidnum);
    task.var_936e3ff613f879a1.objidnum = -1;
  }
}

function function_8676671228ac7f2c(holdpoint, enemyobjective) {
  task = self;
  level endon("game_ended");
  task endon("task_ended");

  while(isDefined(enemyobjective.objidnum) && enemyobjective.objidnum != -1) {
    progress = default_to(holdpoint.curprogress, 0);
    uiprogress = min(holdpoint.curprogress / holdpoint.usetime, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(enemyobjective.objidnum, uiprogress);
    wait 0.2;
  }
}

function function_68b9ba1de74cb130() {
  task = self;
  holdpoint = task.holdpoint;
  var_936e3ff613f879a1 = task.var_936e3ff613f879a1;
  claimteam = holdpoint.claimteam;
  contested = isDefined(holdpoint.contestedtime);
  neutral = !isDefined(claimteam) || claimteam == "none";
  alreadycaptured = isDefined(holdpoint.stronghold.capturedteam) && isDefined(holdpoint.claimteam) && holdpoint.claimteam == holdpoint.stronghold.capturedteam;

  if(contested) {
    holdpoint scripts\mp\gameobjects::setobjectivestatusicons(level.iconcontested);
    scripts\mp\objidpoolmanager::update_objective_icon(holdpoint.stronghold.objectiveiconid, holdpoint.stronghold.var_395a039bdc0591e2);
  } else if(neutral) {
    holdpoint scripts\mp\gameobjects::setobjectivestatusicons(level.iconneutral);
    namespace_9823ee6035594d67::function_d95dbf57b47734d9(holdpoint.stronghold, 1);
  } else {
    holdpoint scripts\mp\gameobjects::setobjectivestatusicons(level.icontaking);
    scripts\mp\objidpoolmanager::function_9b1a086f348520b0(holdpoint.objidnum, claimteam);
    scripts\mp\objidpoolmanager::objective_set_progress_team(holdpoint.objidnum, claimteam);
    scripts\mp\objidpoolmanager::function_9b1a086f348520b0(var_936e3ff613f879a1.objidnum, claimteam);
    scripts\mp\objidpoolmanager::objective_set_progress_team(var_936e3ff613f879a1.objidnum, claimteam);
    namespace_9823ee6035594d67::function_d95dbf57b47734d9(holdpoint.stronghold, 1);
  }

  holdpoint scripts\mp\gameobjects::setvisibleteam("any");
  holdpoint scripts\mp\gameobjects::setownerteam("neutral");

  if(isDefined(holdpoint.objidnum)) {
    objective_removeallfrommask(holdpoint.objidnum);
  }

  if(isDefined(var_936e3ff613f879a1.objidnum)) {
    objective_removeallfrommask(var_936e3ff613f879a1.objidnum);
  }

  foreach(player in task.players) {
    if(!isDefined(player)) {
      continue;
    }

    if(!alreadycaptured) {
      if(contested || neutral || player.team == claimteam) {
        objective_addclienttomask(holdpoint.objidnum, player);
      }
    } else if(!contested && !neutral && player.team != claimteam) {
      objective_addclienttomask(var_936e3ff613f879a1.objidnum, player);
    }

    var_ecb343c4e911d9d0 = undefined;

    if(isDefined(holdpoint.vfxnamemod)) {
      if(neutral) {
        var_ecb343c4e911d9d0 = 0;
        holdpoint.vfxnamemod setscriptablepartstate("flag", "idle");
      } else if(contested) {
        var_ecb343c4e911d9d0 = 3;
        holdpoint.vfxnamemod setscriptablepartstate("flag", "contested");
      } else if(player.team == claimteam) {
        var_ecb343c4e911d9d0 = 1;
        holdpoint.vfxnamemod setscriptablepartstate("flag", "blue_red");
      } else {
        var_ecb343c4e911d9d0 = 2;
        holdpoint.vfxnamemod setscriptablepartstate("flag", "blue_red");
      }
    } else if(neutral) {
      var_ecb343c4e911d9d0 = 0;
    } else if(contested) {
      var_ecb343c4e911d9d0 = 3;
    } else if(player.team == claimteam) {
      var_ecb343c4e911d9d0 = 1;
    } else {
      var_ecb343c4e911d9d0 = 2;
    }

    player setclientomnvar("ui_br_stronghold_mission_status", var_ecb343c4e911d9d0);
  }
}

function function_271a1d82062c2492(data) {
  task = self.task;
  task function_3b3b119a92986947(data.attacker, 1, "EMP_" + data.reason);
  thread brtask_holddisablefortime(data);
}

function brtask_holddisablefortime(data) {
  self notify("brTask_holdDisableForTime");
  self endon("brTask_holdDisableForTime");
  self.task.holdpoint function_29c7e65e828011cf(0);
  self.task.holdpoint.tempdisabled = 1;
  namespace_9823ee6035594d67::function_d95dbf57b47734d9(self.task.owner, 0);
  self.task.players = [];

  if(!isDefined(self.temptrigger)) {
    self.temptrigger = spawn("trigger_radius", self.origin, 0, level.holdprop.circleradius, 62);
    scripts\mp\utility\trigger::makeenterexittrigger(self.temptrigger, &function_2725487ad0b3391b, &playerexitholdpointdisabled);
    self.temptrigger.endtime = int(gettime() + function_a5b14435e3229bed(data.time));
  } else if(isDefined(self.temptrigger.triggerenterents)) {
    self.temptrigger.endtime = int(gettime() + function_a5b14435e3229bed(data.time));

    foreach(player in self.temptrigger.triggerenterents) {
      player scripts\mp\utility\lower_message::setlowermessageomnvar("uav_offline", self.temptrigger.endtime);
    }
  }

  wait data.time;
  self.task.holdpoint function_29c7e65e828011cf(1);
  self.task.holdpoint.tempdisabled = undefined;
  namespace_9823ee6035594d67::function_d95dbf57b47734d9(self.task.owner, 1);
  self.temptrigger delete();
}

function function_2725487ad0b3391b(player, trigger) {
  self endon("playerExitHoldPointDisabled");
  scripts\mp\utility\lower_message::setlowermessageomnvar("uav_offline", trigger.endtime);
  timeleft = function_c89ed1840c8d0f0f(trigger.endtime - gettime());

  while(isDefined(trigger) && timeleft > 0) {
    timeleft = function_c89ed1840c8d0f0f(trigger.endtime - gettime());
    wait timeleft;
  }

  waitframe();
  thread playerexitholdpointdisabled(player, trigger);
}

function playerexitholdpointdisabled(player, trigger) {
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  self notify("playerExitHoldPointDisabled");
}

function function_c94e9cae0cafd8cf(delaytimes) {
  task = self;

  if(isDefined(delaytimes)) {
    wait delaytimes;
  }

  task function_addda96ba479db4e(undefined, 1, undefined, istrue(task.holdpoint.var_554291b6257ea5d0));
  return;
}

# /