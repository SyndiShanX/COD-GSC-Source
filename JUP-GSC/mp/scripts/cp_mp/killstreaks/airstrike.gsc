/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\killstreaks\airstrike.gsc
******************************************************/

#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace airstrike;

function init() {
  if(issharedfuncdefined("airstrike", "init")) {
    [[getsharedfunc("airstrike", "init")]]();
  }

  level._effect["airstrike_tracer"] = loadfx("vfx/iw8_mp/killstreak/vfx_a10_tracer_sep.vfx");

  if(issharedfuncdefined("airstrike", "airstrike_params")) {
    [[getsharedfunc("airstrike", "airstrike_params")]]();
  }

  init_airstrike_flyby_anims();
  init_airstrike_vo();
  function_bf6596a9c196414c();
  level.activeairstrikes = [];
  level.airstrikecount = 0;
  level.var_4c913e393222c2e1 = getdvarint(@ "hash_b17a1f9f7d5c5b0d", 0);
  level.var_53a094cf14067b7d = getdvarint(@ "hash_7017001214d170b1", 0);
  level.airstrikedangerradius = getdvarint(@ "hash_39459995df574c02", 1000);
  level.var_605eaac73a2853d3 = getdvarint(@ "hash_77900c1535c539f5", 1);
  level.var_480d0e884a4f8e2a = getdvarint(@ "hash_20f5d09c276da17c", 0);
  level.var_b8200908fd2377d3 = getdvarint(@ "scr_airstrike_notify_time", 0);

  setdevdvarifuninitialized(@ "hash_7daed56d10a79690", 2);
  setdevdvarifuninitialized(@ "hash_f6e58fc941b6935d", 0);
  setdevdvarifuninitialized(@ "hash_920f0586653a26d4", 0);
  setdevdvarifuninitialized(@ "hash_b44b9052042186a2", 0);

  level.airstrikeprops = spawnStruct();
  level.airstrikeprops.mapdraw = getmatchrulesdata("commonOption", "showAirstrikeOnMap");
  level.airstrikeprops.var_3113dc43ef029ff6 = float(getmatchrulesdata("commonOption", "airstrikeZoneVisibleRange"));
}

#using_animtree("script_model");

function init_airstrike_flyby_anims() {
  level.scr_animtree["precision_airstrike"] = #animtree;
  level.scr_anim["precision_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level.scr_animtree["multi_airstrike"] = #animtree;
  level.scr_anim["multi_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level.scr_animtree["fuel_airstrike"] = #animtree;
  level.scr_anim["fuel_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
}

function init_airstrike_vo() {
  game["dialog"]["precision_airstrike_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["precision_airstrike_hit_target"] = "killstreak_remote_operator" + "_hit_target";
  game["dialog"]["precision_airstrike_miss_target"] = "killstreak_remote_operator" + "_miss_target";
  game["dialog"]["fuel_airstrike_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["fuel_airstrike_hit_target"] = "killstreak_remote_operator" + "_hit_target";
  game["dialog"]["fuel_airstrike_miss_target"] = "killstreak_remote_operator" + "_miss_target";
}

function function_bf6596a9c196414c() {
  level.var_2eec46c88075849b = "airstrike_placement";
  val::group_register(level.var_2eec46c88075849b, ["offhand_weapons", "melee", "execution_attack", "weapon_pickup", "supers", "cp_munitions_pickup"]);
}

function gettimeremainingsec(useresult, strikelocation) {
  if(useresult == "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME") {
    shortestleft = undefined;

    foreach(airstrike in level.activeairstrikes) {
      timeleft = int(max(1, airstrike.starttimems + airstrike.timems - gettime()));

      if(!isDefined(shortestleft) || timeleft < shortestleft) {
        shortestleft = timeleft;
      }
    }

    return (int(function_c89ed1840c8d0f0f(shortestleft)) + 1);
  }

  if(useresult == "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA_TIME") {
    shortestleft = undefined;

    foreach(airstrike in level.activeairstrikes) {
      mindistsq = function_35c596ee06dc6da();

      if(distance2dsquared(airstrike.origin, strikelocation) <= mindistsq) {
        timeleft = int(max(1, airstrike.starttimems + airstrike.timems - gettime()));

        if(!isDefined(shortestleft) || timeleft < shortestleft) {
          shortestleft = timeleft;
        }
      }
    }

    return (int(function_c89ed1840c8d0f0f(shortestleft)) + 1);
  }
}

function weapongivenairstrike(streakinfo) {
  airstrikeweapontype = getdvarint(@ "hash_7daed56d10a79690", 2);
  useresult = airstrike_canbeused(self.origin);

  if(useresult != "success") {
    if(istrue(level.var_b8200908fd2377d3)) {
      timesec = gettimeremainingsec(useresult, self.origin);

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        self[[getsharedfunc("hud", "showErrorMessage")]](useresult, timesec);
      }
    } else if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]](useresult);
    }

    return false;
  }

  if(streakinfo.streakname == "multi_airstrike") {
    if(scripts\engine\utility::issharedfuncdefined("airstrike", "startMapSelectSequence")) {
      self[[scripts\engine\utility::getsharedfunc("airstrike", "startMapSelectSequence")]](0, 1, "long_arrow", undefined, streakinfo);
    }
  } else if(streakinfo.streakname == "fuel_airstrike") {
    if(scripts\engine\utility::issharedfuncdefined("airstrike", "startMapSelectSequence")) {
      self[[scripts\engine\utility::getsharedfunc("airstrike", "startMapSelectSequence")]](undefined, undefined, undefined, undefined, streakinfo);
    }
  }

  self setclientomnvar("ui_using_airstrike", 1);
  return true;
}

function weaponswitchendedairstrike(streakinfo, switchresult) {
  airstrikeweapontype = getdvarint(@ "hash_7daed56d10a79690", 2);

  if(istrue(switchresult)) {
    if(streakinfo.streakname == "precision_airstrike" || streakinfo.streakname == "bunker_buster") {
      if(airstrikeweapontype == 1) {
        self laseron();
        return;
      }

      if(airstrikeweapontype == 2) {
        thread airstrike_watchforads(streakinfo);
      }
    }
  }
}

function weaponfiredairstrike(streakinfo, var_a9dd4e8c5e5c7178, firedprojectile) {
  self setclientomnvar("ui_using_airstrike", 0);

  if(!isDefined(streakinfo.targetoverride)) {
    mappoint = airstrike_getownerlookatpos(self);
    useresult = airstrike_canbeused(mappoint);

    if(useresult != "success") {
      if(istrue(level.var_b8200908fd2377d3)) {
        timesec = gettimeremainingsec(useresult, mappoint);

        if(issharedfuncdefined("hud", "showErrorMessage")) {
          self[[getsharedfunc("hud", "showErrorMessage")]](useresult, timesec);
        }
      } else if(issharedfuncdefined("hud", "showErrorMessage")) {
        self[[getsharedfunc("hud", "showErrorMessage")]](useresult);
      }

      return "continue";
    }
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }

    return "continue";
  }

  return "success";
}

function tryuseairstrike(streakname) {
  streakinfo = createstreakinfo(streakname, self);
  return tryuseairstrikefromstruct(streakinfo);
}

function tryuseairstrikefromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }

    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  self.var_34119a46e931a5fe = self getcurrentweapon();
  deployresult = undefined;
  deployweaponobj = level.airstrikesettings[streakinfo.streakname].deployweaponobj;
  airstrikeeventname = "";

  switch (streakinfo.streakname) {
    case #"hash_8c766d6477287bb6":
      bundle = level.streakglobals.streakbundles["precision_airstrike"];
      level.scr_anim["precision_airstrike"]["airstrike_flyby"] = istrue(bundle.var_f2ebd26d00742bcf) ? % mp_jup_alfa10_flyin : % mp_alfa10_flyin;

      if(issharedfuncdefined("game", "getGameType")) {
        gametype = [[getsharedfunc("game", "getGameType")]]();

        if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && isDefined(self.kstargetlocation)) {
          streakinfo.targetoverride = self.kstargetlocation;
          self.kstargetlocation = undefined;
        }
      }

      if(isDefined(streakinfo.targetoverride)) {
        firedresult = weaponfiredairstrike(streakinfo, undefined, undefined);
        deployresult = firedresult == "success";
      } else {
        if(isDefined(level.var_2eec46c88075849b)) {
          streakinfo.var_fb58a31c756db4cc = level.var_2eec46c88075849b;
        }

        deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, deployweaponobj, "weapon_fired", &weapongivenairstrike, &weaponswitchendedairstrike, &weaponfiredairstrike);
      }

      airstrikeeventname = "precisionAirStrikeUsed";
      break;
    case #"hash_4220be38a5f150b8":
    case #"hash_62810d05099e0103":
      bundle = level.streakglobals.streakbundles["fuel_airstrike"];
      level.scr_anim["precision_airstrike"]["airstrike_flyby"] = istrue(bundle.var_ed4beb9ed9429b51) ? % mp_jup_alfa10_flyin : % mp_alfa10_flyin;
      deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, deployweaponobj, 1, &weapongivenairstrike, &weaponswitchendedairstrike);
      airstrikeeventname = "fuelAirStrikeUsed";
      break;
  }

  if(!istrue(deployresult)) {
    self setclientomnvar("ui_using_airstrike", 0);
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  useresult = selectairstrikelocation(streakinfo);

  if(!istrue(useresult)) {
    return false;
  }

  if(issharedfuncdefined("airstrike", "munitionUsed")) {
    self[[getsharedfunc("airstrike", "munitionUsed")]](streakinfo);
  }

  if(issharedfuncdefined("player", "doOnActionScoreEvent")) {
    self[[getsharedfunc("player", "doOnActionScoreEvent")]](2, airstrikeeventname);
  }

  return true;
}

function selectairstrikelocation(streakinfo) {
  mappoint = (0, 0, 0);
  mappointinfo = undefined;
  targetmarker = undefined;
  directionalselection = undefined;
  var_42c1c130fd550100 = spawn("script_origin", self.origin);
  splashref = "used_" + streakinfo.streakname;

  if(streakinfo.streakname == "precision_airstrike") {
    if(isDefined(streakinfo.targetoverride)) {
      mappoint = streakinfo.targetoverride;
    } else {
      mappoint = airstrike_getownerlookatpos(self, 1);
    }
  } else if(streakinfo.streakname == "multi_airstrike") {
    var_e44616b849d8af48 = 3;
    directionalselection = 1;
    val::set("select_airstrike_location", "weapon_switch", 0);
    self setsoundsubmix("mp_killstreak_overlay");
    mappointinfo = undefined;

    if(scripts\engine\utility::issharedfuncdefined("airstrike", "getSelectMapPoint")) {
      mappointinfo = self[[scripts\engine\utility::getsharedfunc("airstrike", "getSelectMapPoint")]](streakinfo, var_e44616b849d8af48, 1);
    }

    val::reset_all("select_airstrike_location");
  } else if(streakinfo.streakname == "fuel_airstrike") {
    var_e44616b849d8af48 = 3;
    val::set("select_airstrike_location", "weapon_switch", 0);
    self setsoundsubmix("mp_killstreak_overlay");
    mappointinfo = undefined;

    if(scripts\engine\utility::issharedfuncdefined("airstrike", "getSelectMapPoint")) {
      mappointinfo = self[[scripts\engine\utility::getsharedfunc("airstrike", "getSelectMapPoint")]](streakinfo, var_e44616b849d8af48);
    }

    val::reset_all("select_airstrike_location");
  }

  if(isDefined(mappointinfo)) {
    foreach(info in mappointinfo) {
      useresult = airstrike_canbeused(info.location);

      if(useresult != "success") {
        if(istrue(level.var_b8200908fd2377d3)) {
          timesec = gettimeremainingsec(useresult, info.location);

          if(issharedfuncdefined("hud", "showErrorMessage")) {
            self[[getsharedfunc("hud", "showErrorMessage")]](useresult, timesec);
          }
        } else if(issharedfuncdefined("hud", "showErrorMessage")) {
          self[[getsharedfunc("hud", "showErrorMessage")]](useresult);
        }

        return false;
      }
    }

    thread finishmapselectairstrikeusage(mappointinfo, directionalselection, mappoint, targetmarker, streakinfo);
    self clearsoundsubmix("mp_killstreak_overlay");
  } else if(!isDefined(mappointinfo) && (streakinfo.streakname == "multi_airstrike" || streakinfo.streakname == "fuel_airstrike")) {
    if(isDefined(var_42c1c130fd550100)) {
      var_42c1c130fd550100 stoploopsound("");
      var_42c1c130fd550100 delete();
    }

    self clearsoundsubmix("mp_killstreak_overlay");
    return false;
  } else if(streakinfo.streakname == "precision_airstrike") {
    if(!scripts\cp_mp\emp_debuff::is_empd()) {
      thread finishstandardairstrikeusage(mappoint, targetmarker, streakinfo);
    }
  }

  if(isDefined(var_42c1c130fd550100)) {
    var_42c1c130fd550100 stoploopsound("");
    var_42c1c130fd550100 delete();
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
  self notify("successful_fire");

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    thread[[getsharedfunc("hud", "teamPlayerCardSplash")]](splashref, self);
  }

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, mappoint);
  }

  if(level.var_605eaac73a2853d3 && !istrue(level.airstrikeprops.mapdraw)) {
    killstreak_dangernotifyplayersinrange(self, self.team, level.airstrikedangerradius, streakinfo.streakname, mappoint);
  }

  var_52a5be2e2f91d710 = undefined;

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    var_52a5be2e2f91d710 = 3;
  }

  thread playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_use", 1, var_52a5be2e2f91d710);
  return true;
}

function function_b340bcac3e4dda9b(strikenumber, mappointinfo) {
  return mappointinfo.size > 1 && strikenumber < mappointinfo.size - 1;
}

function function_ca2efe3da5d8399d(mappointinfo) {
  strikedelays = [];
  totaldelay = 0;

  foreach(strikenumber, pointinfo in mappointinfo) {
    if(function_b340bcac3e4dda9b(strikenumber, mappointinfo)) {
      nextdelay = randomfloatrange(0.8, 1);
      totaldelay += nextdelay;
      strikedelays[strikenumber] = nextdelay;
    }
  }

  return [totaldelay, strikedelays];
}

function finishmapselectairstrikeusage(mappointinfo, directionalselection, mappoint, targetmarker, streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  animname = level.scr_anim[streakinfo.streakname]["airstrike_flyby"];
  strikeanimlength = getanimlength(animname);
  var_7225662d8217d65a = get_notetrack_time(animname, "attack");
  var_b333ee8fea365230 = strikeanimlength - 5;
  [totaldelay, strikedelays] = function_ca2efe3da5d8399d(mappointinfo);
  airstrikeid = airstrike_addactivestrike(self.origin, self, var_b333ee8fea365230 + totaldelay);
  thread airstrike_watchkills(streakinfo, var_7225662d8217d65a * 2, airstrikeid);
  thread watchairstrikeowner(airstrikeid);
  thread airstrike_watchgameend(streakinfo, airstrikeid);

  foreach(strikenumber, pointinfo in mappointinfo) {
    mappoint = pointinfo.location;
    directionyaw = self.angles[1];

    if(istrue(directionalselection)) {
      directionyaw = pointinfo.angles;
    }

    finishairstrikeusage(mappoint, directionyaw, targetmarker, streakinfo, animname, airstrikeid);

    if(function_b340bcac3e4dda9b(strikenumber, mappointinfo)) {
      wait strikedelays[strikenumber];
    }
  }

  level thread function_7893c28cfbf65865(self, airstrikeid, var_b333ee8fea365230);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(strikeanimlength);
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });

  if(issharedfuncdefined("player", "printGameAction")) {
    self[[getsharedfunc("player", "printGameAction")]]("killstreak ended - " + streakinfo.streakname, self);
  }

  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

function finishstandardairstrikeusage(location, targetmarker, streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  animname = level.scr_anim[streakinfo.streakname]["airstrike_flyby"];
  strikeanimlength = getanimlength(animname);
  var_7225662d8217d65a = get_notetrack_time(animname, "attack");
  var_b333ee8fea365230 = strikeanimlength - 5;
  airstrikeid = airstrike_addactivestrike(location, self, var_b333ee8fea365230);
  thread airstrike_watchkills(streakinfo, var_7225662d8217d65a * 2, airstrikeid);
  thread watchairstrikeowner(airstrikeid);
  thread airstrike_watchgameend(streakinfo, airstrikeid);
  directionyaw = undefined;

  if(isDefined(streakinfo.directionyawoverride)) {
    directionyaw = streakinfo.directionyawoverride;
  }

  finishairstrikeusage(location, directionyaw, targetmarker, streakinfo, animname, airstrikeid);
  level thread function_7893c28cfbf65865(self, airstrikeid, var_b333ee8fea365230);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(strikeanimlength);
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });

  if(issharedfuncdefined("player", "printGameAction")) {
    self[[getsharedfunc("player", "printGameAction")]]("killstreak ended - " + streakinfo.streakname, self);
  }

  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

function finishairstrikeusage(location, directionyaw, targetmarker, streakinfo, animname, airstrikeid) {
  self notify("used");
  self notify("airstrike_used");
  doairstrike(location, directionyaw, self, self.pers["team"], targetmarker, streakinfo, animname, airstrikeid);
}

function doairstrike(origin, yaw, owner, team, targetmarker, streakinfo, animname, airstrikeid) {
  assert(isDefined(origin));
  level thread callstrike(owner, origin, yaw, targetmarker, streakinfo, animname, airstrikeid);
}

function watchairstrikeowner(airstrikeid) {
  self endon("airstrike_finished" + "_" + airstrikeid);
  level endon("game_ended");
  waittill_any_2("disconnect", "joined_team");
  airstrike_removeactivestrike(self, airstrikeid);
}

function callstrike(owner, coord, yaw, targetmarker, streakinfo, animname, airstrikeid) {
  var_361663d437db22f5 = 0;
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  planehalfdistance = 24000;
  planeflyspeed = 6500;
  planeflyheight = 2500;
  var_361663d437db22f5 = 1500;

  if(isDefined(heightent)) {
    planeflyheight = heightent.origin[2];
  }

  if(streakinfo.streakname == "fuel_airstrike") {
    bundle = level.streakglobals.streakbundles["fuel_airstrike"];

    if(istrue(bundle.var_c0ea960245be75fe) && isDefined(bundle.var_3190324970713bd) && bundle.var_3190324970713bd.size > 0) {
      foreach(map in bundle.var_3190324970713bd) {
        if(issubstr(level.mapname, map.name)) {
          if(isDefined(map.var_fac0c5d330ec99ab)) {
            planeflyheight += map.var_fac0c5d330ec99ab;
          }

          break;
        }
      }
    }
  }

  if(isDefined(streakinfo.planeflyheightoverride)) {
    planeflyheight = streakinfo.planeflyheightoverride;
  } else {
    localeid = scripts\cp_mp\utility\game_utility::getlocaleid();

    if(isDefined(localeid) && localeid == "locale_6") {
      planeflyheight += 500;
    }

    if(scripts\cp_mp\utility\game_utility::islargemap()) {
      planeflyheight += 2500;
    }

    var_5ceb15b939485b52 = getdvarint(@ "hash_698613e6c8c52243", 0);
    planeflyheight += var_5ceb15b939485b52;
  }

  var_361663d437db22f5 = getexplodedistance(planeflyheight);
  direction = undefined;
  var_505331ad630bbc6b = undefined;

  if(isDefined(yaw)) {
    direction = (0, yaw, 0);
  } else {
    direction = callstrike_findoptimaldirection(owner, coord, planeflyheight, planehalfdistance);
    var_505331ad630bbc6b = 1;
  }

  flightpath = getflightpath(coord, direction, planehalfdistance, heightent, planeflyheight, planeflyspeed, var_361663d437db22f5, streakinfo.streakname, var_505331ad630bbc6b);

  if(streakinfo.streakname == "precision_airstrike") {
    if(!owner scripts\cp_mp\emp_debuff::is_empd()) {
      var_294066ed5981c32 = level.airstrikeprops.mapdraw;
      airstrikecircles = spawnStruct();

      if(var_294066ed5981c32) {
        sizemultiplier = getmatchrulesdata("commonOption", "airstrikeZoneSizeMultiplier");

        if(sizemultiplier <= 1) {
          sizemultiplier = 1;
        }

        flightdir = vectorNormalize(flightpath["endPoint"] - flightpath["startPoint"]);
        airstrikecircles.owner = owner;
        airstrikecircles.damagepos = coord;
        var_40db97c5db5e1e3e = function_ef2529f22838b027(coord, flightdir);
        airstrikecircles.enemycircle = function_40748f253c758d0c(var_40db97c5db5e1e3e, flightdir, 0, sizemultiplier);
        airstrikecircles.friendlycircle = function_40748f253c758d0c(var_40db97c5db5e1e3e, flightdir, 1, sizemultiplier);
        var_710159b7f6d7c1ca = level.airstrikeprops.var_3113dc43ef029ff6 * level.airstrikeprops.var_3113dc43ef029ff6;
        function_f1723305529704a5(owner, airstrikeid, var_40db97c5db5e1e3e, flightdir, streakinfo.streakname);

        var_40db1f3c38a29377 = getdvarint(@ "hash_de3bb82d99946baf", 0);

        if(var_40db1f3c38a29377) {
          airstrikecircles.debugcircle = function_40748f253c758d0c(coord, flightdir, 0, 1);
          airstrikecircles function_44f4ade288270b27(var_40db97c5db5e1e3e, flightdir);
        }

        airstrikecircles thread function_9557f58b574e2c68();
      }

      if(isDefined(level.var_b67b5f9dfe488c2f)) {
        thread[[level.var_b67b5f9dfe488c2f]](streakinfo);
      }

      for(i = 0; i < 2; i++) {
        if(!isDefined(streakinfo.planeflyheightoverride)) {
          planeflyheight += randomintrange(200, 300);
        }

        if(!owner scripts\cp_mp\emp_debuff::is_empd()) {
          level thread doplanestrike(coord, flightpath["startPoint"], flightpath["endPoint"], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid);
        }

        var_f16ca92d39cfbeab = scripts\engine\utility::ter_op(isDefined(streakinfo.var_e27e4095040fe813), streakinfo.var_e27e4095040fe813, 3);
        wait var_f16ca92d39cfbeab;
      }

      thread function_8f8818bc20bd6ffa(streakinfo);

      if(var_294066ed5981c32) {
        wait 4;
        airstrikecircles thread function_a889314c31d34692();
      }
    }

    return;
  }

  if(streakinfo.streakname == "fuel_airstrike") {
    if(!owner scripts\cp_mp\emp_debuff::is_empd()) {
      level thread doplanestrike(coord, flightpath["startPoint"], flightpath["endPoint"], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid);
    }

    return;
  }

  level thread doplanestrike(coord, flightpath["startPoint"], flightpath["endPoint"], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid);
}

function function_8f8818bc20bd6ffa(streakinfo) {
  wait 5;

  if(isDefined(level.var_f56a88761038798b)) {
    thread[[level.var_f56a88761038798b]](streakinfo);
  }
}

function callstrike_findoptimaldirection(owner, coord, planeflyheight, planehalfdistance, loopcount) {
  var_d77253c873d2b420 = anglesToForward(owner getplayerangles());
  contents = scripts\engine\trace::create_default_contents(1);
  trace = scripts\engine\trace::ray_trace(coord - var_d77253c873d2b420 * 30, coord + var_d77253c873d2b420 * 1000, undefined, contents);
  coord = trace["position"] + trace["normal"] * 20;
  targetpos = coord;
  targetheightoffset = planeflyheight;
  ownerforward = anglesToForward(owner.angles);
  ownerright = anglestoright(owner.angles);
  var_3ae184241dc44588 = 0;
  var_f74f18c717b149e2 = [targetpos + ownerforward * 100, targetpos - ownerforward * 100, targetpos + ownerright * 100, targetpos - ownerright * 100, targetpos + (ownerforward + ownerright) * 100, targetpos + (ownerforward - ownerright) * 100, targetpos + (ownerright - ownerforward) * 100, targetpos + (-1 * ownerforward - ownerright) * 100];

  if(coord[2] > planeflyheight) {
    targetheightoffset = coord[2] + planeflyheight - owner.origin[2];
  }

  if(!isDefined(loopcount)) {
    loopcount = 0;
  }

  if(level.var_4c913e393222c2e1) {
    bestdirection = vectorNormalize(var_f74f18c717b149e2[2] - targetpos);
  } else {
    bestdirection = vectorNormalize(var_f74f18c717b149e2[0] - targetpos);
  }

  var_e3b1338d5bd4399f = 0;
  bestfraction = 0;
  airstrikedebugon = getdvarint(@ "hash_b44b9052042186a2", 0);
  tracepassed = 0;

  foreach(dirpos in var_f74f18c717b149e2) {
    var_7a7426e42e674e40 = vectorNormalize(dirpos - targetpos);
    var_c45bbeb56df09b5d = targetpos * (1, 1, 0) + (0, 0, targetheightoffset);
    var_32a961dac02545b0 = var_c45bbeb56df09b5d - var_7a7426e42e674e40 * planehalfdistance;
    var_19189fd85d8a2c19 = var_c45bbeb56df09b5d + var_7a7426e42e674e40 * planehalfdistance;
    traceresult = scripts\engine\trace::ray_trace_passed(var_32a961dac02545b0, var_19189fd85d8a2c19, undefined, contents);

    if(!istrue(traceresult)) {
      continue;
    } else {
      tracepassed = 1;
    }

    if(istrue(airstrikedebugon)) {
      level thread scripts\cp_mp\utility\debug_utility::drawline(var_32a961dac02545b0, var_19189fd85d8a2c19, 30, (1, 1, 0));
    }

    var_48384e792726b96a = var_c45bbeb56df09b5d - var_7a7426e42e674e40 * int(planehalfdistance / 3);
    var_e313995ecad6abbc = [targetpos, targetpos - var_7a7426e42e674e40 * 512, targetpos - var_7a7426e42e674e40 * 256, targetpos + var_7a7426e42e674e40 * 256, targetpos + var_7a7426e42e674e40 * 512];
    successfulhits = 0;

    foreach(endtracepos in var_e313995ecad6abbc) {
      results = scripts\engine\trace::ray_trace(var_48384e792726b96a, endtracepos, undefined, contents);
      traceresult = results["fraction"] == 1;

      if(level.var_53a094cf14067b7d) {
        if(results["fraction"] > bestfraction) {
          bestdirection = var_7a7426e42e674e40;
          bestfraction = results["fraction"];
        }
      }

      if(!istrue(traceresult)) {
        if(istrue(airstrikedebugon)) {
          line(var_48384e792726b96a, results["<dev string:x1c>"], (1, 1, 0), 1, 0, 500);
          line(results["<dev string:x1c>"], endtracepos, (1, 0, 0), 1, 0, 500);
        }

        wait 0.05;
        continue;
      }

      successfulhits++;

      if(istrue(airstrikedebugon)) {
        line(var_48384e792726b96a, endtracepos, (0, 1, 0), 1, 0, 500);
      }

      wait 0.05;
    }

    if(successfulhits > var_e3b1338d5bd4399f) {
      bestdirection = var_7a7426e42e674e40;
      var_e3b1338d5bd4399f = successfulhits;

      if(successfulhits >= 3) {
        break;
      }
    }
  }

  if(!tracepassed && loopcount < 3) {
    bestdirection = callstrike_findoptimaldirection(owner, coord, planeflyheight + 500, planehalfdistance, loopcount + 1);
  }

  return bestdirection;
}

function doplanestrike(targetsite, var_6d29e82378e59e76, var_98255165b50d8173, planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid) {
  if(!isDefined(owner)) {
    return;
  }

  owner endon("disconnect");
  level endon("game_ended");

  if(streakinfo.streakname != "precision_airstrike" && isDefined(level.var_b67b5f9dfe488c2f)) {
    thread[[level.var_b67b5f9dfe488c2f]](streakinfo, targetsite);
  }

  config = level.airstrikesettings[streakinfo.streakname];
  bundle = level.streakglobals.streakbundles[streakinfo.streakname];
  strikeanimlength = getanimlength(animname);
  var_7b00721e9d1ef2a0 = get_notetrack_time(animname, "attack");
  planestartpos = targetsite * (1, 1, 0) + (0, 0, planeflyheight);
  var_7789cda8c1e3128e = vectortoangles(var_98255165b50d8173 - var_6d29e82378e59e76);
  planemodel = config.modelbase;

  if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(owner) && isDefined(config.modelbasealt)) {
    planemodel = config.modelbasealt;
  }

  plane = spawn("script_model", planestartpos);
  plane setModel(planemodel);
  plane.angles = var_7789cda8c1e3128e;
  plane.flightdir = anglesToForward(var_7789cda8c1e3128e);
  plane.flightheight = planeflyheight;
  plane.owner = owner;
  plane.team = owner.team;
  plane.lifeid = streakinfo.lifeid;
  plane.streakinfo = streakinfo;
  plane.airstrikeid = airstrikeid;
  plane setotherent(owner);
  plane scriptmoveroutline();
  plane scriptmoverthermal();
  plane scriptmoverplane();

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    plane[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);
  }

  if(issharedfuncdefined("br", "challengeEvaluator")) {
    paramstruct = spawnStruct();
    paramstruct.plane = plane;
    paramstruct.targetsite = targetsite;
    owner[[getsharedfunc("br", "challengeEvaluator")]]("br_mastery_pointBlank_airstrike", paramstruct);
  }

  planeicon = "hud_icon_minimap_killstreak_airstrike";

  if(streakinfo.streakname == "fuel_airstrike") {
    planeicon = "hud_icon_minimap_killstreak_fuel_airstrike";
  }

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    plane.minimapid = plane[[scripts\engine\utility::getsharedfunc("game", "createObjective")]](planeicon, plane.team, undefined, 1, 1);
  }

  var_fafbda0eba9c0aab = var_7b00721e9d1ef2a0 - 0.75;
  var_3a20f9101e50025f = 0.05;
  var_3a020e101e2ddead = var_fafbda0eba9c0aab;
  var_7c39d972e849c204 = 8.596;

  if(streakinfo.streakname == "fuel_airstrike") {
    var_fafbda0eba9c0aab = var_7b00721e9d1ef2a0 + 1;
  }

  var_e4d26f59db05025a = config.var_c80e3ea2a37a7182;

  if(!isDefined(var_e4d26f59db05025a)) {
    var_e4d26f59db05025a = "ks_airstrike_mp";
  }

  plane thread airstrike_delayplayscriptable(0.05);
  level thread airstrike_playplaneattackfx(plane, var_fafbda0eba9c0aab, streakinfo);
  level airstrike_playflyfx(plane, var_e4d26f59db05025a, var_6d29e82378e59e76, anglesToForward(var_7789cda8c1e3128e), var_3a20f9101e50025f, var_3a020e101e2ddead, var_7c39d972e849c204, strikeanimlength, streakinfo);
  var_87a839ff480ea54e = "ks_airstrike_target_mp";

  if(streakinfo.streakname == "precision_airstrike") {
    var_87a839ff480ea54e = isDefined(bundle.var_57f7b01d253da57b) ? bundle.var_57f7b01d253da57b : "ks_airstrike_target_mp";
  }

  plane.bulletpoint = spawn("script_model", plane.origin);
  plane.bulletpoint setModel(var_87a839ff480ea54e);
  plane.bulletpoint setentityowner(owner);
  plane.bulletpoint.weapon_name = "artillery_mp";
  plane.bulletpoint.streakinfo = streakinfo;
  plane.bulletpoint.angles = plane.angles;
  plane.bulletpoint dontinterpolate();
  plane.animname = streakinfo.streakname;
  plane scripts\common\anim::setanimtree();
  plane.scenenode = spawn("script_model", planestartpos);
  plane.scenenode.angles = plane.angles;
  plane.scenenode setModel("tag_origin");

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    plane thread function_fc41f67ef33c00b0(var_6d29e82378e59e76, var_98255165b50d8173, (1, 1, 1), 20);
    plane thread function_aca0ec4cab6e6319(planeflyheight - targetsite[2], targetsite);
  }

  if(streakinfo.streakname == "precision_airstrike" || streakinfo.streakname == "multi_airstrike") {
    level thread callstrike_precisionbulleteffect(plane, var_fafbda0eba9c0aab, strikeanimlength, targetsite, owner, streakinfo);
  } else if(streakinfo.streakname == "fuel_airstrike") {
    level thread function_c592aab59a13cf01(plane, var_fafbda0eba9c0aab, strikeanimlength, targetsite, owner, streakinfo);
  }

  plane.scenenode scripts\common\anim::anim_single_solo(plane, "airstrike_flyby");

  if(isDefined(plane.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](plane.minimapid);
    }
  }

  plane notify("delete");

  if(isDefined(plane.turrettarget)) {
    plane.turrettarget delete();
  }

  if(isDefined(plane.bulletpoint)) {
    plane.bulletpoint delete();

    if(isDefined(plane.bulletpoint.killcament)) {
      plane.bulletpoint.killcament delete();
    }
  }

  if(isDefined(plane.scenenode)) {
    plane.scenenode delete();
  }

  if(isDefined(plane)) {
    plane delete();
  }

  if(streakinfo.streakname != "precision_airstrike" && isDefined(level.var_f56a88761038798b)) {
    thread[[level.var_f56a88761038798b]](streakinfo);
  }
}

function airstrike_playplaneattackfx(plane, var_fafbda0eba9c0aab, streakinfo) {
  plane endon("death");
  level endon("game_ended");

  if(streakinfo.streakname == "fuel_airstrike") {
    return;
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_fafbda0eba9c0aab);
  playsoundatpos(plane.origin, "ks_a10_fire_dist_crack");
  plane setscriptablepartstate("fire", "on", 0);
  plane waittill("fire_finished");
  plane setscriptablepartstate("fire", "off", 0);
}

function airstrike_playflyfx(plane, var_e4d26f59db05025a, planestartpos, var_7789cda8c1e3128e, var_3a20f9101e50025f, var_3a020e101e2ddead, var_7c39d972e849c204, var_a9b4b258c1167b50, streakinfo) {
  flyoutfx = spawn("script_model", planestartpos);
  flyoutfx setModel(var_e4d26f59db05025a);
  flyoutfx dontinterpolate();
  flyoutfx thread airstrike_playapproachfx(var_3a20f9101e50025f);
  flyoutfx thread airstrike_playflybyfx(var_3a020e101e2ddead);
  flyoutfx thread airstrike_playflyoutfx(var_7c39d972e849c204);
  flyoutfx thread airstrike_handleflyoutfxdeath(var_a9b4b258c1167b50);
  flyoutfx thread airstrike_movewithplane(plane);

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    level thread testsoundplacement(flyoutfx);
  }

  return flyoutfx;
}

function airstrike_playapproachfx(var_777fc9701bbd592b) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_777fc9701bbd592b);
  self setscriptablepartstate("approach", "on", 0);
}

function airstrike_playflybyfx(var_3a020e101e2ddead) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3a020e101e2ddead);
  self setscriptablepartstate("flyby", "on", 0);
}

function airstrike_playflyoutfx(var_7c39d972e849c204) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_7c39d972e849c204);
  self setscriptablepartstate("flyout", "on", 0);
}

function airstrike_handleflyoutfxdeath(var_b5d8ace604fc4b78) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_b5d8ace604fc4b78 + 10);
  self delete();
}

function airstrike_movewithplane(plane) {
  self endon("death");
  level endon("game_ended");

  while(isDefined(plane)) {
    self.origin = plane.origin;
    wait 0.05;
  }
}

function airstrike_watchkills(streakinfo, var_c12c14029cc05aca, airstrikeid) {
  self endon("disconnect");
  self notify("airstrike_watch_kills");
  self endon("airstrike_watch_kills");
  waittillnotify = "airstrike_finished" + "_" + airstrikeid;
  self.airstrikekillcount = 0;
  self.var_3efdaabc0f66846d = 0;
  childthread airstrike_watchkillscount(waittillnotify);
  childthread function_9fc9871a8c03a9de(waittillnotify);
  waittill_any_timeout_no_endon_death_1(var_c12c14029cc05aca, waittillnotify);
  playerskilled = isDefined(self.airstrikekillcount) && self.airstrikekillcount >= 1;
  playersdowned = isDefined(self.var_3efdaabc0f66846d) && self.var_3efdaabc0f66846d >= 1;

  if(playerskilled || playersdowned) {
    playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_hit_target", 1);
  } else {
    playkillstreakoperatordialog(streakinfo.streakname, streakinfo.streakname + "_miss_target", 1);
  }

  self.var_3efdaabc0f66846d = undefined;
}

function airstrike_watchkillscount(endonnotify) {
  self endon(endonnotify);

  while(true) {
    self waittill("update_rapid_kill_buffered", recentkillcount, var_366b0ecc2f28aead);

    if(isDefined(var_366b0ecc2f28aead) && (var_366b0ecc2f28aead == "artillery_mp" || var_366b0ecc2f28aead == "fuelstrike_proj_mp")) {
      self.airstrikekillcount++;
    }
  }
}

function function_9fc9871a8c03a9de(endonnotify) {
  self endon(endonnotify);

  while(true) {
    self waittill("update_rapid_agent_kill_buffered", recentkillcount, var_366b0ecc2f28aead);

    if(isDefined(var_366b0ecc2f28aead) && (var_366b0ecc2f28aead == "artillery_mp" || var_366b0ecc2f28aead == "fuelstrike_proj_mp")) {
      self.airstrikekillcount++;
    }
  }
}

function testsoundplacement(flyoutfx) {
  flyoutfx endon("<dev string:x28>");

  while(true) {
    sphere(flyoutfx.origin, 100, (0, 1, 0), 0, 1);
    wait 0.05;
  }
}

function callstrike_precisionbulleteffect(plane, launchtime, strikelength, damagepos, owner, streakinfo) {
  plane endon("death");
  planedir = plane.flightdir;
  camdamagepos = damagepos + (0, 0, plane.flightheight + 750);
  killcamstartpos = camdamagepos - planedir * 15000;
  killcamendpos = camdamagepos - planedir * 500;
  var_315162f2d4f72593 = camdamagepos;
  var_fe74bc2cc14dfd90 = 0;
  var_b829b1c5b718adf9 = randomintrange(3, 9);
  var_9cb35d6fde2c8bea = randomintrange(var_b829b1c5b718adf9 + 1, 16);
  strafe = [var_fe74bc2cc14dfd90, var_b829b1c5b718adf9, var_9cb35d6fde2c8bea];
  strafecounter = 0;
  killcament = spawn("script_model", killcamstartpos);
  killcament thread airstrike_killcammove(launchtime - 3, killcamendpos, var_315162f2d4f72593);
  plane.bulletpoint.killcament = killcament;
  var_c6cda7219900396f = [damagepos - planedir * 512, damagepos - planedir * 256, damagepos, damagepos + planedir * 256, damagepos + planedir * 512];

  if(level.var_480d0e884a4f8e2a && !istrue(level.airstrikeprops.mapdraw)) {
    foreach(targetpos in var_c6cda7219900396f) {
      killstreak_dangernotifyplayersinrange(owner, owner.team, level.airstrikedangerradius, streakinfo.streakname, targetpos);
    }
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(launchtime);

  if(!isDefined(owner)) {
    return;
  }

  repeat = 5;
  hitpos = (0, 0, 0);
  lasthitpos = hitpos;
  shotcounter = 0;
  var_7a48a62d24267eb = 0;
  var_c6cda7219900396f = [damagepos - planedir * 512, damagepos - planedir * 256, damagepos, damagepos + planedir * 256, damagepos + planedir * 512];
  assert(var_c6cda7219900396f.size == 5);

  foreach(targetpos in var_c6cda7219900396f) {
    if(scripts\engine\utility::issharedfuncdefined("airstrike", "addSpawnDangerZone")) {
      [[scripts\engine\utility::getsharedfunc("airstrike", "addSpawnDangerZone")]](targetpos, 512, 512, owner.team, 5, owner, 1);
    }
  }

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    foreach(pos in var_c6cda7219900396f) {
      sphere(pos, 100, (1, 1, 1), 0, 500);
    }
  }

  traceheightoffset = damagepos[2] + plane.flightheight * 3;

  for(i = 0; i < repeat; i++) {
    if(!isDefined(owner)) {
      break;
    }

    originalmin = -50;
    originalmax = 150;

    while(shotcounter < var_7a48a62d24267eb + 4) {
      var_22468a5a678250bb = callstrike_getrandomshotoffset(originalmin, originalmax, var_c6cda7219900396f[i], plane.angles);
      turrettracestart = plane gettagorigin("tag_turret_fx") * (1, 1, 0) + (0, 0, traceheightoffset) + planedir * 1000;

      var_561d30c3a2ac374 = getdvarint(@ "hash_f6e58fc941b6935d", 0);

      if(isDefined(var_561d30c3a2ac374) && var_561d30c3a2ac374 == 1) {
        turrettracestart = var_22468a5a678250bb + (0, 0, 10000);
      }

      var_6a2843f01a3c04b1 = vectorNormalize(var_22468a5a678250bb - turrettracestart);
      turrettraceend = var_22468a5a678250bb + var_6a2843f01a3c04b1 * 30000;
      tracertrace = scripts\engine\trace::ray_trace(turrettracestart, turrettraceend, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
      var_6d5dcb89f6baa8fe = tracertrace["position"];
      var_6f511097d430526 = tracertrace["normal"];
      var_e734e756bb8f91c9 = var_6d5dcb89f6baa8fe + var_6f511097d430526 * 10;
      var_9b9958e5c64d5b3 = vectorNormalize(var_6d5dcb89f6baa8fe - plane gettagorigin("tag_turret_fx"));
      var_88f727764adfe9a4 = vectorcross(var_9b9958e5c64d5b3, (0, 0, 1));
      var_6721411b32ec4a63 = vectorcross(var_88f727764adfe9a4, var_9b9958e5c64d5b3);
      plane thread callstrike_playmultitracerfx(getfx("airstrike_tracer"), var_e734e756bb8f91c9, var_9b9958e5c64d5b3, var_6721411b32ec4a63);

      if(getdvarint(@ "redeploy_ascenders_enabled", 0)) {
        if(isDefined(tracertrace["hittype"]) && tracertrace["hittype"] == "hittype_world" && tracertrace["position"][2] > 3000) {
          scr_drone = undefined;

          if(issharedfuncdefined("redeploy_drone", "get_closest_redeploy_drone")) {
            scr_drone = [[getsharedfunc("redeploy_drone", "get_closest_redeploy_drone")]](tracertrace["position"]);
          }

          if(isDefined(scr_drone) && distancesquared(tracertrace["position"], scr_drone.origin) < squared(150)) {
            if(issharedfuncdefined("redeploy_drone", "precision_airstrike_death")) {
              scr_drone thread[[getsharedfunc("redeploy_drone", "precision_airstrike_death")]](owner);
            }
          }
        }

        if(isDefined(tracertrace["hittype"]) && tracertrace["hittype"] == "hittype_entity" && isDefined(tracertrace["entity"]) && isDefined(tracertrace["entity"].model) && (tracertrace["entity"].model == "veh9_mil_air_drone_redeploy_relocate" || tracertrace["entity"].model == "veh9_mil_air_drone_redeploy_relocate_hack")) {
          if(issharedfuncdefined("redeploy_drone", "precision_airstrike_death")) {
            tracertrace["entity"] thread[[getsharedfunc("redeploy_drone", "precision_airstrike_death")]](owner);
          }
        }
      }

      plane.bulletpoint thread moveanddamagepoint(shotcounter + 1, var_e734e756bb8f91c9);

      if(strafecounter < strafe.size && shotcounter == strafe[strafecounter]) {
        plane.bulletpoint thread strafes(strafecounter + 1, var_e734e756bb8f91c9);
        strafecounter++;
      }

      lasthitpos = var_6d5dcb89f6baa8fe;
      shotcounter++;
      plane.bulletpoint.streakinfo.shots_fired++;
      originalmin += 20;
      originalmax += 40;
      traceheightoffset -= 200;

      if(traceheightoffset < plane.flightheight) {
        traceheightoffset = plane.flightheight;
      }

      wait 0.05;
    }

    var_7a48a62d24267eb = shotcounter;

    if(i == 0 && isDefined(level.var_ca1a76fbc0ba0bef)) {
      thread[[level.var_ca1a76fbc0ba0bef]](streakinfo, lasthitpos, 0);
    }
  }

  plane notify("fire_finished");
}

function callstrike_getrandomshotoffset(minoffset, maxoffset, originalpos, var_6f680ee249f67b0d) {
  var_6f680ee249f67b0d *= (0, 1, 0);
  planeforward = anglesToForward(var_6f680ee249f67b0d);
  planeright = anglestoright(var_6f680ee249f67b0d);
  randdist = randomintrange(minoffset, maxoffset);
  randangle = randomint(80) - 40;
  shotoffset = planeforward * cos(randangle) * randdist;
  return originalpos + shotoffset + planeright * sin(randangle) * randdist;
}

function callstrike_playmultitracerfx(tracerfx, tracehit, var_9b9958e5c64d5b3, var_6721411b32ec4a63) {
  self endon("death");
  var_4648b75503218e34 = 0;
  var_684fc496fbbee4d5 = 3;

  while(var_4648b75503218e34 < var_684fc496fbbee4d5) {
    randomoffsetx = randomintrange(25, 50);
    randomoffsety = randomintrange(25, 50);
    playFX(tracerfx, tracehit + (randomoffsetx, randomoffsety, 0), var_9b9958e5c64d5b3, var_6721411b32ec4a63);
    var_4648b75503218e34++;
    wait 0.05;
  }
}

function moveanddamagepoint(index, hitpos) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.18);
  self.origin = hitpos;
  self setscriptablepartstate("explode" + index, "active", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("explode" + index, "neutral", 0);
}

function strafes(index, hitpos) {
  self endon("death");
  self.origin = hitpos;
  self setscriptablepartstate("strafe" + index, "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("strafe" + index, "off", 0);
}

function function_c592aab59a13cf01(plane, launchtime, strikelength, damagepos, owner, streakinfo) {
  plane endon("death");
  planedir = plane.flightdir;
  camdamagepos = damagepos + (0, 0, plane.flightheight + 750);
  killcamstartpos = camdamagepos - planedir * 15000;
  killcamendpos = camdamagepos - planedir * 1000;
  var_315162f2d4f72593 = camdamagepos - planedir * 500;
  killcament = spawn("script_model", killcamstartpos);
  killcament thread airstrike_killcammove(launchtime - 3, killcamendpos, var_315162f2d4f72593);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(launchtime);

  if(!isDefined(owner)) {
    return;
  }

  if(streakinfo.streakname == "fuel_airstrike") {
    if(owner scripts\cp_mp\emp_debuff::is_empd()) {
      return;
    }
  }

  bundle = level.streakglobals.streakbundles["fuel_airstrike"];
  plane function_ae53424c3a02628d(bundle, damagepos, owner, owner.team, strikelength);

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    sphere(damagepos, 100, (1, 1, 1), 0, 500);
  }

  bombtracestart = damagepos + (0, 0, 2500);
  bombtraceend = damagepos - (0, 0, 10000);
  bombtrace = scripts\engine\trace::ray_trace(bombtracestart, bombtraceend, undefined, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
  var_604b31efa39e3f47 = bombtrace["position"];
  bombtracenormal = bombtrace["normal"];
  bombhitpos = var_604b31efa39e3f47 + bombtracenormal * 10;

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    line(bombtracestart, bombhitpos, (1, 0, 0), 1, 0, 1000);
    line(bombhitpos, bombhitpos + bombtracenormal * 50, (0, 1, 0), 1, 0, 500);
    sphere(bombhitpos, 50, (1, 0, 0), 0, 500);
  }

  var_c6188da3ad302049 = bombhitpos + (0, 0, 800);
  var_6033a7638fe1342f = spawn("script_model", var_c6188da3ad302049);
  var_6033a7638fe1342f.angles = plane.angles;
  var_6033a7638fe1342f.streakinfo = plane.streakinfo;
  var_6033a7638fe1342f setModel("ks_fuelstrike_mp");
  var_6033a7638fe1342f setentityowner(owner);
  var_6033a7638fe1342f.killcament = killcament;
  var_f9f79f4923d00e6e = spawn("script_model", bombhitpos);
  var_f9f79f4923d00e6e.angles = plane.angles;
  var_f9f79f4923d00e6e.streakinfo = plane.streakinfo;
  var_f9f79f4923d00e6e setModel("ks_fuelstrike_mp");
  var_f9f79f4923d00e6e setentityowner(owner);
  var_f9f79f4923d00e6e.killcament = killcament;
  var_f9f79f4923d00e6e setscriptablepartstate("releaseVFX", "on", 0);
  var_6033a7638fe1342f setscriptablepartstate("releaseSFX", "on", 0);
  wait 1.3;
  var_f9f79f4923d00e6e setscriptablepartstate("explode", "on", 0);
  var_704a32ec251490fb = isDefined(bundle.var_4971349c14362ea4) ? bundle.var_4971349c14362ea4 : 750;
  var_b9d5783a4f34efbc = [var_6033a7638fe1342f, var_f9f79f4923d00e6e];
  var_33f031d062a32623 = physics_createcontents(["physicscontents_itemclip", "physicscontents_glass", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight"]);
  var_3bd841437dfaa8d7 = function_15d7e8b275b8b57b(bombhitpos, var_704a32ec251490fb, owner, var_c6188da3ad302049, var_b9d5783a4f34efbc, var_33f031d062a32623);
  vehicleshit = function_2a75473ddd0fb33f(bombhitpos, var_704a32ec251490fb, owner, var_c6188da3ad302049, var_b9d5783a4f34efbc, var_33f031d062a32623);
  bombweapon = makeweapon("fuelstrike_proj_mp");
  bombexplodedelay = 0.8;
  plane thread function_e5a6aaaa22532637(var_6033a7638fe1342f, var_f9f79f4923d00e6e, bombexplodedelay);

  owner thread function_9018ff93eb75a769(bombexplodedelay, var_f9f79f4923d00e6e);

  var_f6712b60b5c22cde = isDefined(bundle.var_eddf6bb52f8c95cb) ? bundle.var_eddf6bb52f8c95cb : 500;
  vehicledamage = isDefined(bundle.var_c08cc1db399a56bb) ? bundle.var_c08cc1db399a56bb : 1000;

  foreach(enemy in var_3bd841437dfaa8d7) {
    enemy thread function_3c8dfe97ac9ad7c7(owner, bombexplodedelay, var_6033a7638fe1342f, var_f9f79f4923d00e6e, bombweapon);
    enemy thread function_94e9b969d9359f43(var_f6712b60b5c22cde, var_f9f79f4923d00e6e.origin, owner, var_f9f79f4923d00e6e, "MOD_EXPLOSIVE", bombweapon, bombexplodedelay);
  }

  foreach(vehicle in vehicleshit) {
    vehicle thread function_94e9b969d9359f43(vehicledamage, var_f9f79f4923d00e6e.origin, owner, var_f9f79f4923d00e6e, "MOD_EXPLOSIVE", bombweapon, bombexplodedelay);
  }

  level thread delaydeletefxents(var_6033a7638fe1342f, var_f9f79f4923d00e6e);
}

function delaydeletefxents(var_19e3c5251a5f46fa, var_837d24b1c8e8ef79) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  var_19e3c5251a5f46fa setscriptablepartstate("releaseSFX", "off", 0);
  var_837d24b1c8e8ef79 setscriptablepartstate("releaseVFX", "off", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(isDefined(var_19e3c5251a5f46fa)) {
    var_19e3c5251a5f46fa delete();
  }

  if(isDefined(var_837d24b1c8e8ef79)) {
    if(isDefined(var_837d24b1c8e8ef79.killcament)) {
      var_837d24b1c8e8ef79.killcament delete();
    }

    var_837d24b1c8e8ef79 delete();
  }
}

function getflightpath(coord, direction, planehalfdistance, heightent, planeflyheight, planeflyspeed, var_361663d437db22f5, streakname, var_505331ad630bbc6b) {
  directionangles = undefined;

  if(istrue(var_505331ad630bbc6b)) {
    directionangles = direction;
  } else {
    directionangles = anglesToForward(direction);
  }

  startpoint = coord + directionangles * -1 * planehalfdistance;

  if(isDefined(heightent)) {
    startpoint *= (1, 1, 0);
  }

  startpoint += (0, 0, planeflyheight);
  endpoint = coord + directionangles * planehalfdistance;

  if(isDefined(heightent)) {
    endpoint *= (1, 1, 0);
  }

  endpoint += (0, 0, planeflyheight);
  d = length(startpoint - endpoint);
  flytime = d / planeflyspeed;
  d = abs(d / 2 + var_361663d437db22f5);
  bombtime = d / planeflyspeed;
  assert(flytime > bombtime);
  flightpath["startPoint"] = startpoint;
  flightpath["endPoint"] = endpoint;
  flightpath["bombTime"] = bombtime;
  flightpath["flyTime"] = flytime;
  flightpath["directionAngles"] = directionangles;
  return flightpath;
}

function getexplodedistance(height) {
  standardheight = 850;
  standarddistance = 1500;
  distancefrac = standardheight / height;
  newdistance = distancefrac * standarddistance;
  return newdistance;
}

function function_aca0ec4cab6e6319(planeflyheight, targetsite) {
  self endon("<dev string:x28>");
  level endon("<dev string:x31>");

  while(true) {
    if(getdvarint(@ "hash_920f0586653a26d4") == 0) {
      return;
    }

    anglesforward = anglesToForward(level.players[0].angles);
    scalar = (anglesforward[0] * 300, anglesforward[1] * 300, anglesforward[2]);
    print3d(level.players[0].origin + scalar, "<dev string:x44>" + planeflyheight, (1, 0, 0));
    print3d(level.players[0].origin + scalar - (0, 0, 20), "<dev string:x54>" + distance2d(targetsite, self.origin));
    waitframe();
  }
}

function function_fc41f67ef33c00b0(start, end, color, duration) {
  frames = duration * 20;

  for(i = 0; i < frames; i++) {
    line(start, end, color);
    wait 0.05;
  }
}

function airstrike_getownerlookatpos(owner, finalselection) {
  content = ["physicscontents_water", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy"];
  contentoverride = physics_createcontents(content);
  starttrace = owner getvieworigin();
  endtrace = starttrace + anglesToForward(owner getplayerangles()) * 50000;
  ignoreents = owner playerkillstreakgetownerlookatignoreents();
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, ignoreents, contentoverride);
  endpos = trace["position"];

  if(istrue(finalselection)) {
    airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

    if(isDefined(airstrikedebugon) && airstrikedebugon) {
      sphere(endpos, 50, (0, 1, 0), 0, 500);
    }
  }

  if(trace["hittype"] == "hittype_none") {
    endpos = undefined;
  }

  return endpos;
}

function airstrike_watchforads(streakinfo, iconoverride) {
  self endon("death_or_disconnect");
  self endon("deploy_cancelled");
  self endon("deploy_fired");
  markerent = spawn("script_model", self.origin);
  markerent setModel("ks_airstrike_marker_mp");

  if(scripts\engine\utility::issharedfuncdefined("game", "requestObjectiveID")) {
    markerent.objidnum = [[scripts\engine\utility::getsharedfunc("game", "requestObjectiveID")]](99);
  }

  markerent setotherent(self);
  markerent dontinterpolate();
  markerent hide();
  markericon = "icon_waypoint_airstrike";

  if(isDefined(iconoverride)) {
    markericon = iconoverride;
  }

  markerent airstrike_setmarkerobjective(markerent.objidnum, markericon, self, 50);
  markerent thread airstrike_watchownerdisown(self);
  markerent thread airstrike_watchdeployended(self);
  markerent thread airstrike_watchdeployweaponchange(self);
  markerent.updatemarker = 0;
  val::set("ads_watcher", "fire", 0);

  while(true) {
    if(scripts\cp_mp\emp_debuff::is_empd()) {
      if(streakinfo.streakname == "precision_airstrike" || streakinfo.streakname == "bunker_buster") {
        previousweapon = self.var_34119a46e931a5fe;
        _switchtoweapon(previousweapon);
        val::set("ads_watcher", "fire", 0);
        markerent hide();
        markerent setscriptablepartstate("marker_scope", "off", 0);
        self notify("stop_update_marker");
        markerent.updatemarker = 0;
      }

      if(streakinfo.streakname == "fuel_airstrike") {
        previousweapon = self.var_34119a46e931a5fe;
        _switchtoweapon(previousweapon);
        val::set("ads_watcher", "fire", 0);
        markerent hide();
        markerent setscriptablepartstate("marker_scope", "off", 0);
        self notify("stop_update_marker");
        markerent.updatemarker = 0;
      }
    }

    if(scripts\cp_mp\emp_debuff::is_empd() && istrue(markerent.updatemarker)) {
      if(streakinfo.streakname != "precision_airstrike" && streakinfo.streakname != "bunker_buster") {
        val::set("ads_watcher", "fire", 0);
        markerent hide();
        markerent setscriptablepartstate("marker_scope", "off", 0);
        self notify("stop_update_marker");
        markerent.updatemarker = 0;
      }
    }

    playerads = self playerads();

    if(playerads == 1 && !istrue(markerent.updatemarker)) {
      if(!scripts\cp_mp\emp_debuff::is_empd()) {
        val::reset_all("ads_watcher");
        markerent show();
        markerent setscriptablepartstate("marker_scope", "on", 0);
        markerent thread airstrike_updatemarkerpos(self);
        markerent.updatemarker = 1;
      }
    } else if(playerads < 1 && istrue(markerent.updatemarker)) {
      val::set("ads_watcher", "fire", 0);
      markerent hide();
      markerent setscriptablepartstate("marker_scope", "off", 0);
      self notify("stop_update_marker");
      markerent.updatemarker = 0;
    }

    waitframe();
  }
}

function airstrike_setmarkerobjective(objid, icon, owner, offset) {
  objective_icon(objid, icon);
  objective_showtoplayersinmask(objid);
  objective_addclienttomask(objid, owner);
  objective_onentity(objid, self);
  objective_setzoffset(objid, offset);
  objective_setplayintro(objid, 0);
  objective_setplayoutro(objid, 0);
  objective_setbackground(objid, 1);

  if(level.teambased) {
    objective_setownerteam(objid, owner.team);
  } else {
    objective_setownerclient(objid, owner);
  }

  objective_state(objid, "done");
}

function airstrike_updatemarkerpos(owner) {
  self endon("death");
  owner endon("deploy_cancelled");
  owner endon("deploy_fired");
  owner endon("stop_update_marker");
  owner endon("death_or_disconnect");
  dangerclose = 0;
  owner setclientomnvar("ui_spotter_scope_danger", 0);

  while(true) {
    newownerlookatpos = airstrike_getownerlookatpos(owner);
    xpos = -1;
    ypos = -1;
    zpos = -1;

    if(isDefined(newownerlookatpos)) {
      self.origin = newownerlookatpos;
      xpos = int(self.origin[0]);
      ypos = int(self.origin[1]);
      zpos = int(self.origin[2]);
    }

    owner setclientomnvar("ui_gunship_coord3_posx", xpos);
    owner setclientomnvar("ui_gunship_coord3_posy", ypos);
    owner setclientomnvar("ui_gunship_coord3_posz", zpos);

    if(isDefined(newownerlookatpos)) {
      if(!istrue(dangerclose) && distance2dsquared(owner.origin, newownerlookatpos) <= 1638400) {
        owner setclientomnvar("ui_spotter_scope_danger", 1);
        dangerclose = 1;
      } else if(istrue(dangerclose) && distance2dsquared(owner.origin, newownerlookatpos) > 1638400) {
        owner setclientomnvar("ui_spotter_scope_danger", 0);
        dangerclose = 0;
      }
    }

    waitframe();
  }
}

function airstrike_watchownerdisown(owner) {
  self endon("death");
  level endon("game_ended");
  owner waittill("death_or_disconnect");
  airstrike_removemarker();
}

function airstrike_watchdeployended(owner) {
  owner endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  deployresult = owner waittill_any_return_2("cancel_fire", "successful_fire");

  if(isDefined(deployresult) && deployresult == "successful_fire") {
    owner notify("deploy_fired");
    owner playlocalsound("kls_location_select");
    self setscriptablepartstate("marker_scope", "off", 0);
    var_95da95f2e9954514 = anglesToForward(owner getplayerangles());
    starttrace = self.origin - var_95da95f2e9954514 * 500;
    endtrace = self.origin + var_95da95f2e9954514 * 20;
    trace = ray_trace(starttrace, endtrace, self);
    surfacenormal = trace["normal"];
    self.angles = generateaxisanglesfromupvector(surfacenormal, self.angles);
    self setscriptablepartstate("marker_placed", "on", 0);
    objective_state(self.objidnum, "current");
    thread airstrike_removemarker(7);
    return;
  }

  owner setclientomnvar("ui_using_airstrike", 0);
  owner notify("deploy_cancelled");

  if(!owner[[getsharedfunc("player", "isPlayerADS")]]()) {
    owner val::reset_all("ads_watcher");
  }

  airstrike_removemarker();
}

function airstrike_watchdeployweaponchange(owner) {
  owner endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  spotterscope = owner getcurrentweapon();

  while(true) {
    if(owner getcurrentweapon() != spotterscope) {
      break;
    }

    waitframe();
  }

  owner notify("cancel_fire");
}

function airstrike_removemarker(delaytime) {
  if(isDefined(delaytime)) {
    self endon("death");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  }

  if(isDefined(self.objidnum)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](self.objidnum);
    }
  }

  self delete();
}

function airstrike_delayplayscriptable(delaytime) {
  self endon("death");
  level endon("game_ended");
  wait delaytime;
  self setscriptablepartstate("bodyfx", "on", 0);
}

function airstrike_killcammove(delaytime, killcamendpos, var_315162f2d4f72593) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  self moveTo(killcamendpos, 4);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.95);
  self moveTo(var_315162f2d4f72593, 5);
}

function airstrike_watchgameend(streakinfo, airstrikeid) {
  self endon("airstrike_finished" + "_" + airstrikeid);
  self endon("disconnect");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

function airstrike_addactivestrike(origin, owner, timesec) {
  level.airstrikecount++;
  newstrike = spawnStruct();
  newstrike.origin = origin;
  newstrike.owner = owner;

  if(isPlayer(owner)) {
    id = owner getxuid();
  } else {
    id = abs(owner.origin[0]);
  }

  newstrike.id = id + "_" + level.airstrikecount;
  newstrike.starttimems = gettime();
  newstrike.timems = timesec * 1000;
  level.activeairstrikes[newstrike.id] = newstrike;
  return newstrike.id;
}

function airstrike_removeactivestrike(owner, var_4d39391d6ef2bb65) {
  level.activeairstrikes = array_remove_index(level.activeairstrikes, var_4d39391d6ef2bb65, 1);

  if(isDefined(owner)) {
    owner notify("airstrike_finished" + "_" + var_4d39391d6ef2bb65);
  }
}

function function_7893c28cfbf65865(owner, airstrikeid, delaytime) {
  level endon("game_ended");
  wait delaytime;
  airstrike_removeactivestrike(owner, airstrikeid);
}

function function_35c596ee06dc6da() {
  mindistsq = 625000000;

  if(level.mapname == "<dev string:x62>") {
    mindistsq = 1000000;
  }

  return mindistsq;
}

function airstrike_canbeused(strikelocation) {
  useresult = "success";
  mindistsq = function_35c596ee06dc6da();

  if(isDefined(strikelocation)) {
    if(level.activeairstrikes.size > 0) {
      var_28f0d2ad91ee22dc = 1;
      isbrgamemode = scripts\cp_mp\utility\game_utility::isbrstylegametype();

      if(isbrgamemode) {
        var_28f0d2ad91ee22dc = 3;
      }

      if(level.activeairstrikes.size >= var_28f0d2ad91ee22dc) {
        if(istrue(level.var_b8200908fd2377d3)) {
          useresult = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_TIME";
        } else {
          useresult = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED";
        }
      } else {
        foreach(activestrike in level.activeairstrikes) {
          if(distance2dsquared(activestrike.origin, strikelocation) <= mindistsq) {
            if(istrue(level.var_b8200908fd2377d3)) {
              useresult = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA_TIME";
              continue;
            }

            useresult = "KILLSTREAKS/AIR_SPACE_TOO_CROWDED_AREA";
          }
        }
      }
    }
  } else {
    useresult = "KILLSTREAKS/INVALID_POINT";
  }

  return useresult;
}

function callprecisionairstrikeonlocation(location) {
  player = self;
  streakinfo = spawnStruct();
  streakinfo.streakname = "precision_airstrike";
  streakinfo.owner = player;
  streakinfo.score = 0;
  streakinfo.shots_fired = 0;
  streakinfo.hits = 0;
  streakinfo.damage = 0;
  streakinfo.kills = 0;
  yaw = undefined;
  targetmarker = undefined;
  animname = % mp_alfa10_flyin;
  airstrikeid = undefined;
  level thread callstrike(player, location, yaw, targetmarker, streakinfo, animname, airstrikeid);
}

function function_15d7e8b275b8b57b(hitpos, hitradius, airstrikeowner, tracestart, var_b9d5783a4f34efbc, var_33f031d062a32623) {
  targetsinrange = utility::function_2d7fd59d039fa69b(hitpos, hitradius);
  enemiesinrange = [];

  foreach(target in targetsinrange) {
    if(!isDefined(target)) {
      continue;
    }

    targetteam = undefined;

    if(isPlayer(target)) {
      if(!target _isalive()) {
        continue;
      }

      targetteam = target.pers["team"];

      if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
        if(scripts\engine\utility::issharedfuncdefined("game", "brGetOperatorTeam")) {
          targetteam = [[scripts\engine\utility::getsharedfunc("game", "brGetOperatorTeam")]](target);
        }
      }
    } else if(isagent(target)) {
      if(!isalive(target)) {
        continue;
      }

      if(isDefined(target.agent_type) && issubstr(target.agent_type, "civilian")) {
        continue;
      }

      targetteam = scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata(target, "team");
    }

    if(isDefined(airstrikeowner)) {
      if(level.teambased) {
        if(isDefined(airstrikeowner.team) && isDefined(targetteam) && targetteam == airstrikeowner.team && target != airstrikeowner) {
          continue;
        }
      }
    }

    canseetarget = ray_trace_passed(tracestart, target gettagorigin("j_head"), var_b9d5783a4f34efbc, var_33f031d062a32623);

    if(istrue(canseetarget)) {
      enemiesinrange[enemiesinrange.size] = target;
    }
  }

  return enemiesinrange;
}

function function_2a75473ddd0fb33f(hitpos, hitradius, airstrikeowner, tracestart, var_b9d5783a4f34efbc, var_33f031d062a32623) {
  targetsinrange = vehicle_getarrayinradius(hitpos, hitradius, hitradius);
  var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, targetsinrange);
  vehiclesinrange = [];

  foreach(target in targetsinrange) {
    if(!isDefined(target)) {
      continue;
    }

    if(level.teambased && isDefined(target.team) && target.team == airstrikeowner.team) {
      continue;
    }

    canseetarget = ray_trace_passed(tracestart, target.origin, var_b9d5783a4f34efbc, var_33f031d062a32623);

    if(istrue(canseetarget)) {
      vehiclesinrange[vehiclesinrange.size] = target;
    }
  }

  return vehiclesinrange;
}

function function_e5a6aaaa22532637(var_6033a7638fe1342f, var_f9f79f4923d00e6e, bombexplodedelay) {
  self endon("death");
  shakeduration = 0.5;
  var_ff85637831346339 = 0.3;
  var_ff624f78310def85 = 0.15;
  var_ff625578310dfcb7 = 0.08;
  radiusscalemax = 350;
  radiusscalemid = 900;
  radiusscalemin = 3500;
  wait bombexplodedelay;

  if(issharedfuncdefined("shellshock", "artillery_earthQuake")) {
    [[getsharedfunc("shellshock", "artillery_earthQuake")]](var_f9f79f4923d00e6e.origin, shakeduration, var_ff85637831346339, var_ff624f78310def85, var_ff625578310dfcb7, radiusscalemax, radiusscalemid, radiusscalemin);
  }
}

function function_3c8dfe97ac9ad7c7(owner, bombexplodedelay, var_6033a7638fe1342f, var_f9f79f4923d00e6e, bombweapon) {
  self endon("disconnect");
  bundle = level.streakglobals.streakbundles["fuel_airstrike"];

  if(!getdvarint(@ "hash_1cdf26977e1440d6", 0)) {
    if(!istrue(bundle.var_497be9c8f4575962)) {
      scripts\cp_mp\utility\shellshock_utility::_shellshock("bomb_stun_mp", "stun", 5, 0);
    }
  }

  thread function_94e9b969d9359f43(1, var_6033a7638fe1342f.origin, owner, var_6033a7638fe1342f, "MOD_EXPLOSIVE", bombweapon);

  if(isbot(self) || isagent(self)) {
    return;
  }

  self setscriptablepartstate("airBombVfx", "embers", 0);
  wait bombexplodedelay - 0.1;
  self setscriptablepartstate("airBombVfx", "explode", 0);
  thread function_57107489d8ba1a87("airBombVfx");
}

function private function_94e9b969d9359f43(damageamount, damageorigin, attacker, inflictor, meansofdeath, weapon, bombexplodedelay) {
  self endon("death_or_disconnect");

  if(isDefined(bombexplodedelay) && bombexplodedelay > 0) {
    wait bombexplodedelay;
  }

  self dodamage(damageamount, damageorigin, attacker, inflictor, meansofdeath, weapon);
}

function function_57107489d8ba1a87(partname) {
  self endon("disconnect");
  waittill_any_timeout_1(3, "spawned_player");
  self setscriptablepartstate(partname, "off", 0);
}

function function_40748f253c758d0c(var_40db97c5db5e1e3e, flightdir, isfriendly, sizemultiplier) {
  var_b26e5ea712463920 = spawnStruct();
  var_b26e5ea712463920.circle = spawnStruct();
  stretchmultiplier = (256 * 4 + 600) / 300;
  var_e3c7bdfc2ae5dc88 = "Airstrike_Pill_Shape";

  if(isfriendly) {
    var_e3c7bdfc2ae5dc88 = "Airstrike_Pill_Shape_Friendly";
  }

  var_b26e5ea712463920.circle function_6b6b6273f8180522(var_e3c7bdfc2ae5dc88, var_40db97c5db5e1e3e, 300 * sizemultiplier);
  var_b26e5ea712463920.circle.mapcircle addyaw(vectortoyaw(flightdir) * -1);
  var_b26e5ea712463920.circle.mapcircle addpitch(stretchmultiplier);
  return var_b26e5ea712463920;
}

function function_ef2529f22838b027(damagepos, flightdir) {
  var_98ff5ed8e7d91533 = getmatchrulesdata("commonOption", "airstrikeZoneSizeMultiplier");
  var_3da8b019c5c09e2b = getmatchrulesdata("commonOption", "isAirstrikeZoneRandom");

  if(!isDefined(var_98ff5ed8e7d91533) || var_98ff5ed8e7d91533 <= 1) {
    var_98ff5ed8e7d91533 = 1;
    var_3da8b019c5c09e2b = 0;
  }

  var_40db97c5db5e1e3e = damagepos;

  if(var_3da8b019c5c09e2b) {
    var_84ecc2f4134b6cdf = 300;
    var_d6900268a0be9970 = var_84ecc2f4134b6cdf * var_98ff5ed8e7d91533;
    randomxoffset = randomfloatrange((var_d6900268a0be9970 * -1 + 300) * 0.5, (var_d6900268a0be9970 - 300) * 0.5);
    stretchmultiplier = (256 * 4 + 600) / 300;
    var_84ecc1f4134b6aac = 300 * stretchmultiplier;
    dangerzoneheight = var_84ecc1f4134b6aac * var_98ff5ed8e7d91533;
    randomyoffset = randomfloatrange((dangerzoneheight * -1 + var_84ecc1f4134b6aac) * 0.5, (dangerzoneheight - var_84ecc1f4134b6aac) * 0.5);
    var_420b7fe776f6872f = vectorcross(flightdir, (0, 0, 1));
    var_40db97c5db5e1e3e = damagepos + randomxoffset * var_420b7fe776f6872f + randomyoffset * flightdir;
  }

  return var_40db97c5db5e1e3e;
}

function function_f1723305529704a5(owner, airstrikeid, var_d8695b9748c307be, flightdir, streakname) {
  var_fdea64af0ede4e50 = level.activeairstrikes[airstrikeid];

  if(!isDefined(var_fdea64af0ede4e50)) {
    return;
  }

  range = 300;
  sizemultiplier = 1;

  if(getmatchrulesdata("commonOption", "isAirstrikeZoneRandom")) {
    sizemultiplier = getmatchrulesdata("commonOption", "airstrikeZoneSizeMultiplier");
    range = 300 * sizemultiplier;
  }

  range += getmatchrulesdata("commonOption", "airstrikeNotifyCircleAddedRange");
  var_213fdd3689d4b33e = level.teamdata[owner.team]["players"];
  var_213fdd3689d4b33e = arrayremove(var_213fdd3689d4b33e, owner);
  var_b6cd0d44c9bc37e5 = [];
  var_c86bc952d8cc7c15 = function_2de43934d42594e(var_d8695b9748c307be, flightdir, sizemultiplier);

  foreach(circleorigin in var_c86bc952d8cc7c15) {
    var_c0d6a48951eaa35e = function_7fbde10147e5b269(circleorigin, range, var_213fdd3689d4b33e);
    var_b6cd0d44c9bc37e5 = array_combine_unique(var_b6cd0d44c9bc37e5, var_c0d6a48951eaa35e);
  }

  foreach(player in var_b6cd0d44c9bc37e5) {
    function_266521b0b26cc543(owner, player, streakname);
  }

  return var_b6cd0d44c9bc37e5;
}

function function_44f4ade288270b27(var_d8695b9748c307be, flightdir) {
  self.var_bd0aa6c111497ed3 = [];
  range = 300;
  sizemultiplier = 1;

  if(getmatchrulesdata("<dev string:x75>", "<dev string:x85>")) {
    sizemultiplier = getmatchrulesdata("<dev string:x75>", "<dev string:x9e>");
    range = 300 * sizemultiplier;
  }

  range += getmatchrulesdata("<dev string:x75>", "<dev string:xbd>");
  var_c86bc952d8cc7c15 = function_2de43934d42594e(var_d8695b9748c307be, flightdir, sizemultiplier);

  foreach(circleorigin in var_c86bc952d8cc7c15) {
    currentindex = self.var_bd0aa6c111497ed3.size;
    self.var_bd0aa6c111497ed3[currentindex] = spawnStruct();
    self.var_bd0aa6c111497ed3[currentindex] function_6b6b6273f8180522("<dev string:xe0>", circleorigin, range);
  }
}

function function_2de43934d42594e(damagepos, planedir, sizemultiplier) {
  multiplier = 1;

  if(isDefined(sizemultiplier)) {
    multiplier = sizemultiplier;
  }

  return [damagepos - planedir * 256 * multiplier * 2, damagepos - planedir * 256 * multiplier, damagepos, damagepos + planedir * 256 * multiplier, damagepos + planedir * 256 * multiplier * 2];
}

function function_9557f58b574e2c68() {
  self endon("map_circles_deleted");
  level endon("game_ended");
  var_710159b7f6d7c1ca = level.airstrikeprops.var_3113dc43ef029ff6 * level.airstrikeprops.var_3113dc43ef029ff6;

  var_40db1f3c38a29377 = getdvarint(@ "hash_de3bb82d99946baf", 0);

  while(true) {
    foreach(player in level.players) {
      isfriendly = scripts\cp_mp\utility\player_utility::isfriendly(self.owner.team, player) && self.owner != player;

      if(distance2dsquared(player.origin, self.damagepos) <= var_710159b7f6d7c1ca) {
        if(isfriendly) {
          self.friendlycircle.circle function_cfd53c8f6878014f(player);
        } else {
          self.enemycircle.circle function_cfd53c8f6878014f(player);
        }

        if(var_40db1f3c38a29377) {
          self.debugcircle.circle function_cfd53c8f6878014f(player);

          if(isDefined(self.var_bd0aa6c111497ed3)) {
            foreach(circle in self.var_bd0aa6c111497ed3) {
              circle function_cfd53c8f6878014f(player);
            }
          }
        }

        continue;
      }

      self.friendlycircle.circle function_d7d113d56ef0ef5b(player);
      self.enemycircle.circle function_d7d113d56ef0ef5b(player);

      if(var_40db1f3c38a29377) {
        self.debugcircle.circle function_d7d113d56ef0ef5b(player);

        if(isDefined(self.var_bd0aa6c111497ed3)) {
          foreach(circle in self.var_bd0aa6c111497ed3) {
            circle function_d7d113d56ef0ef5b(player);
          }
        }
      }
    }

    waitframe();
  }
}

function function_a889314c31d34692() {
  self notify("map_circles_deleted");

  if(isDefined(self.enemycircle)) {
    self.enemycircle.circle function_af5604ce591768e1();
    self.enemycircle.circle = undefined;
  }

  if(isDefined(self.friendlycircle)) {
    self.friendlycircle.circle function_af5604ce591768e1();
    self.friendlycircle.circle = undefined;
  }

  if(isDefined(self.debugcircle)) {
    self.debugcircle.circle function_af5604ce591768e1();
    self.debugcircle.circle = undefined;
  }

  if(isDefined(self.var_bd0aa6c111497ed3)) {
    for(i = self.var_bd0aa6c111497ed3.size - 1; i >= 0; i--) {
      self.var_bd0aa6c111497ed3[i] function_af5604ce591768e1();
      self.var_bd0aa6c111497ed3[i] = undefined;
    }
  }

}

function function_9018ff93eb75a769(bombexplodedelay, var_f9f79f4923d00e6e) {
  self endon("<dev string:xee>");
  level endon("<dev string:x105>");
  self notify("<dev string:x113>");
  self endon("<dev string:x113>");
  self notifyonplayercommand("<dev string:x131>", "<dev string:x14c>");
  self notifyonplayercommand("<dev string:x131>", "<dev string:x15a>");
  bombweapon = makeweapon("<dev string:x167>");

  while(true) {
    airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

    if(!istrue(airstrikedebugon)) {
      waitframe();
      continue;
    }

    self waittill("<dev string:x131>");
    scripts\cp_mp\utility\shellshock_utility::_shellshock("<dev string:x17d>", "<dev string:x18d>", 2, 0);
    self setscriptablepartstate("<dev string:x195>", "<dev string:x1a3>", 0);
    wait bombexplodedelay - 0.1;
    self setscriptablepartstate("<dev string:x195>", "<dev string:x1ad>", 0);
  }
}

# /