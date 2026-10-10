/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\killstreaks\auto_drone.gsc
*******************************************************/

#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace auto_drone;

function init() {
  if(issharedfuncdefined("auto_drone", "init")) {
    [[getsharedfunc("auto_drone", "init")]]();
  }

  setdevdvarifuninitialized(@ "hash_30dee5c8d013379b", 0);
  setdevdvarifuninitialized(@ "hash_62b493e13a7a2273", 0);

  level function_2e0e05b9e6dfba79();
  level function_1c0ee59726585f9f();
  level function_54dc2efc97e278c6();
  level function_5cda69c520d4b9c3();
  level function_5d215ec521236402();
}

function function_235f27caff15c65(streakinfo) {
  if(issharedfuncdefined("killstreak", "startMapSelectSequence")) {
    self[[getsharedfunc("killstreak", "startMapSelectSequence")]](0, 1, "long_arrow", undefined, streakinfo);
  }

  return true;
}

function function_2e0e05b9e6dfba79() {
  level.var_5f028b2553fb392d = [];
  level.var_d8c0162b0f87cb2c = 0;

  foreach(teamname in level.teamnamelist) {
    level.var_5f2f53346bf55271[teamname] = 0;
  }
}

function function_1c0ee59726585f9f() {}

function function_54dc2efc97e278c6() {}

function function_5cda69c520d4b9c3() {
  game["dialog"]["auto_drone" + "_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["auto_drone" + "_hit_target"] = "killstreak_remote_operator" + "_hit_target";
  game["dialog"]["auto_drone" + "_miss_target"] = "killstreak_remote_operator" + "_miss_target";
}

function function_5d215ec521236402() {}

function function_f5488ebdae28a1d8() {
  streakinfo = createstreakinfo("auto_drone", self);
  return function_987a0ab2646445e1(streakinfo);
}

function function_987a0ab2646445e1(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(level.streakglobals.streakbundles["auto_drone"])) {
    goto LOC_00000075;
  }

  level.var_25479c87b8ab495c = level.streakglobals.streakbundles["auto_drone"];
  team = self.team;
  level.var_d8c0162b0f87cb2c++;
  var_1396f6a995578be4 = 1;

  if(islargemap()) {
    var_1396f6a995578be4 = 2;
  }

  if(level.var_5f028b2553fb392d.size >= var_1396f6a995578be4 || level.var_5f028b2553fb392d.size + level.var_d8c0162b0f87cb2c > var_1396f6a995578be4) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.var_d8c0162b0f87cb2c--;
    return 0;
  }

  if(islargemap() && level.teambased) {
    var_bb1cd2da42608a26 = 1;
    level.var_5f2f53346bf55271[team]++;

    if(getnumactivekillstreakperteam(team, level.var_5f028b2553fb392d) + level.var_5f2f53346bf55271[team] > var_bb1cd2da42608a26) {
      level.var_d8c0162b0f87cb2c--;
      level.var_5f2f53346bf55271[team]--;

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      return 0;
    }
  }

  result = function_a39b5cb878cc28cd(streakinfo);
  level.var_d8c0162b0f87cb2c--;

  if(islargemap() && level.teambased) {
    level.var_5f2f53346bf55271[team]--;
  }

  return result;
}

function function_a39b5cb878cc28cd(streakinfo) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon("ks_remote_map_mp"), 1, &function_235f27caff15c65);

  if(!istrue(deployresult)) {
    return false;
  }

  mappointinfo = undefined;
  self playlocalsound("iw9_ks_tablet_ui_screen_plr");

  if(issharedfuncdefined("killstreak", "getSelectMapPoint")) {
    mappointinfo = self[[getsharedfunc("killstreak", "getSelectMapPoint")]](streakinfo, isDefined(level.var_25479c87b8ab495c.var_4146fe9ed0fa6381) ? level.var_25479c87b8ab495c.var_4146fe9ed0fa6381 : 1, 1);
    self playlocalsound("iw9_ks_tablet_ui_select_final_plr");
  }

  streakinfo.owner notify("killstreak_deploy_finished", streakinfo.streakname);

  if(!isDefined(mappointinfo)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return false;
    }
  }

  if(level.gameended) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  level thread function_589f29fde91a654a(self, streakinfo, mappointinfo);
  var_52a5be2e2f91d710 = undefined;

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    var_52a5be2e2f91d710 = 2;
  }

  thread playkillstreakoperatordialog("auto_drone", "auto_drone" + "_use", 1, var_52a5be2e2f91d710);
  utility::trycall(level.matchdata_logkillstreakevent, "auto_drone", self.origin);

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + "auto_drone", self, self.team);
  }

  return true;
}

function function_589f29fde91a654a(player, streakinfo, mappointinfo) {
  level endon("game_ended");
  player notify("auto_drone_used");
  targetlocations = mappointinfo;

  for(i = 0; i < targetlocations.size; i++) {
    autodrone = function_6fe4e482e9c736b9(player, streakinfo, targetlocations[i], 1);
    autodrone thread function_7056da117386cf8b();
    autodrone thread function_dabe5e1812ac0003();
    autodrone thread function_5072d07167c0ae44();
    autodrone thread function_e01ff9fbb932ee1a();
    autodrone thread function_71fc6fc4f15927a8();
    autodrone thread function_7cd9f49e2a56ea1e();
  }
}

function function_6fe4e482e9c736b9(owner, streakinfo, targetlocationinfo, nonvehicle) {
  level endon("game_ended");
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  dronehalfdistance = 36000;
  droneflyheight = 3000;
  droneflyspeed = isDefined(level.var_25479c87b8ab495c.var_aaba64c33f97c4da) ? level.var_25479c87b8ab495c.var_aaba64c33f97c4da : 200;
  var_9c39dce599026a69 = 1500;
  var_505331ad630bbc6b = 0;

  if(isDefined(heightent)) {
    droneflyheight = heightent.origin[2] + 500;
  }

  var_4579697f9f42001 = targetlocationinfo.location;

  var_7cd8cd4d5be83b1a = getdvarint(@ "hash_62b493e13a7a2273", 0);
  var_4579697f9f42001 += anglesToForward(owner.angles) * var_7cd8cd4d5be83b1a;
  var_5ceb15b939485b52 = getdvarint(@ "hash_698613e6c8c52243", 0);
  droneflyheight += var_5ceb15b939485b52;

  strikedirection = (0, targetlocationinfo.angles, 0);
  flightpath = scripts\cp_mp\killstreaks\airstrike::getflightpath(var_4579697f9f42001, strikedirection, dronehalfdistance, heightent, droneflyheight, droneflyspeed, var_9c39dce599026a69, streakinfo.streakname, var_505331ad630bbc6b);
  pathstart = flightpath["startPoint"];
  pathgoal = flightpath["endPoint"];
  var_7622a5ad898bdbd1 = strikedirection;
  payload_distance = isDefined(level.var_25479c87b8ab495c.var_1f5176ea25f9060) ? level.var_25479c87b8ab495c.var_1f5176ea25f9060 : 500;
  autodrone = spawn("script_model", pathstart);
  autodrone setModel(isDefined(level.var_25479c87b8ab495c.var_13fd3784885951a1) ? level.var_25479c87b8ab495c.var_13fd3784885951a1 : "veh9_mil_air_stealth_bomber_mp");
  autodrone.speed = droneflyspeed;
  autodrone.accel = 100;
  autodrone.angles = var_7622a5ad898bdbd1;
  autodrone.team = owner.team;
  autodrone.owner = owner;
  autodrone.streakinfo = streakinfo;
  autodrone.streakname = streakinfo.streakname;
  autodrone.currentdamagestate = 0;
  autodrone.flyheight = droneflyheight;
  autodrone.pers["team"] = autodrone.team;
  autodrone.flightdir = flightpath["directionAngles"];
  autodrone.var_862801aab153104c = droneflyspeed * 17.6;
  autodrone.flightstartpos = pathstart;
  autodrone.var_ac01c3b7bbcbc871 = pathstart + anglesToForward(autodrone.angles) * int(dronehalfdistance * 0.67);
  autodrone.var_9c6aa2ad962ccae2 = pathgoal - anglesToForward(autodrone.angles) * int(dronehalfdistance * 0.67);
  autodrone.flightendpos = pathgoal;
  autodrone.var_40d811c99bd7ac07 = length(autodrone.var_ac01c3b7bbcbc871 - autodrone.var_9c6aa2ad962ccae2);
  autodrone.flighttime = length(autodrone.flightstartpos - autodrone.flightendpos) / autodrone.var_862801aab153104c;
  autodrone.var_602736e29283719a = length(autodrone.flightstartpos - autodrone.var_ac01c3b7bbcbc871) / autodrone.var_862801aab153104c;
  autodrone.var_49d6b84e9061ea2 = length(autodrone.flightstartpos - autodrone.var_9c6aa2ad962ccae2) / autodrone.var_862801aab153104c;
  autodrone.var_c588c0602c9a3b4d = payload_distance / autodrone.var_862801aab153104c;
  autodrone.var_bebe0d78a71db256 = int(autodrone.var_40d811c99bd7ac07 / payload_distance);

  if(issharedfuncdefined("auto_drone", "attachXRays")) {
    autodrone = [[getsharedfunc("auto_drone", "attachXRays")]](autodrone);
  }

  killcament = spawn("script_model", autodrone.origin);
  killcament linkTo(autodrone, "tag_origin", (-100, 0, -100), (0, 0, 0));
  autodrone.killcament = killcament;
  minimapid = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    minimapid = autodrone[[scripts\engine\utility::getsharedfunc("game", "createObjective")]]("hud_icon_minimap_killstreak_drone_auto", autodrone.team, 1, 1, 1, "icon_large");
  }

  autodrone.minimapid = minimapid;
  autodrone.firequeue = [];
  autodrone.firequeue["target_line_left"] = [];
  autodrone.firequeue["target_line_right"] = [];
  autodrone.fireents = [];
  autodrone.fireents["target_line_left"] = [];
  autodrone.fireents["target_line_right"] = [];

  debugtarget = getdvarint(@ "hash_30dee5c8d013379b", 0);

  if(debugtarget) {
    level thread scripts\cp_mp\utility\debug_utility::drawline(autodrone.flightstartpos, autodrone.flightendpos, autodrone.flighttime, (1, 1, 1));
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(autodrone.flightstartpos, 50, autodrone.flighttime, (1, 0, 0));
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(autodrone.flightendpos, 50, autodrone.flighttime, (0, 1, 0));
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(autodrone.var_ac01c3b7bbcbc871, 100, autodrone.flighttime, (0, 1, 1));
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(autodrone.var_9c6aa2ad962ccae2, 100, autodrone.flighttime, (0, 1, 1));
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(var_4579697f9f42001, 100, autodrone.flighttime, (1, 0, 1));
    forwarddebug = anglesToForward(autodrone.angles);
    forwarddebugpos = pathstart + forwarddebug * 200;
    level thread scripts\cp_mp\utility\debug_utility::drawline(autodrone.flightstartpos, forwarddebugpos, autodrone.flighttime, (1, 0, 0));
  }

  autodrone.var_be765c862617c601 = targetlocationinfo.location;
  autodrone setscriptablepartstate("contrails", "on", 0);
  autodrone setscriptablepartstate("lights", "on", 0);
  level.var_5f028b2553fb392d[level.var_5f028b2553fb392d.size] = autodrone;
  return autodrone;
}

function function_75693ae9c1b5327f(wasdestroyed) {
  self notify("cleaning_up");

  if(isDefined(level.var_f56a88761038798b)) {
    thread[[level.var_f56a88761038798b]](self.streakinfo);
  }

  self.streakinfo.expiredbydeath = istrue(wasdestroyed);

  if(isDefined(self.owner)) {
    if(!istrue(self.recordedgameendstats)) {
      self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
    }
  }

  level callback::callback("killstreak_finish_use", {
    #streakinfo: self.streakinfo
  });

  if(isDefined(self.fireents)) {
    var_e6324000e504af61 = self.fireents["<dev string:x1c>"].size + self.fireents["<dev string:x2d>"].size;
    iprintlnbold("<dev string:x3f>" + var_e6324000e504af61 + "<dev string:x61>");

    foreach(ent in self.fireents["target_line_left"]) {
      if(isDefined(ent)) {
        ent delete();
      }
    }

    foreach(ent in self.fireents["target_line_right"]) {
      if(isDefined(ent)) {
        ent delete();
      }
    }
  }

  if(isDefined(self.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  level.var_5f028b2553fb392d = array_remove(level.var_5f028b2553fb392d, self);
  self delete();
}

function function_7056da117386cf8b() {
  self endon("death");
  level waittill("game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
}

function function_dabe5e1812ac0003() {
  self endon("death");
  self endon("cleaning_up");
  self.owner waittill_any_3("disconnect", "joined_team", "joined_spectators");
  self.reachedgoal = 1;

  if(isDefined(self.flyfxent)) {
    self.flyfxent delete();
  }

  self setscriptablepartstate("release", "neutral", 0);
  self setscriptablepartstate("contrails", "off", 0);
  self setscriptablepartstate("lights", "off", 0);
  self notify("autodrone_flight_finished");
  self notify("autodrone_volley_finished");
}

function function_313eeda8b560e440(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");
  missiletarget endon("death");
  missiletarget endon("crashing");
  level endon("game_ended");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      if(issharedfuncdefined("flares", "reduceReserves")) {
        [[getsharedfunc("flares", "reduceReserves")]](missiletarget);
      }

      if(issharedfuncdefined("flares", "playFx")) {
        missiletarget thread[[getsharedfunc("flares", "playFx")]]("jet_flares", fxtagoverride);
      }

      newtarget = undefined;

      if(issharedfuncdefined("flares", "deploy")) {
        newtarget = missiletarget[[getsharedfunc("flares", "deploy")]]();
      }

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function function_71fc6fc4f15927a8() {
  self endon("death");
  level endon("game_ended");
  droneowner = self.owner;
  droneowner endon("disconnect");
  var_edc8eb6ff8689dde = self.flighttime;
  var_ddfe084a5f844081 = self.var_49d6b84e9061ea2;
  var_9a725e0702370e63 = var_edc8eb6ff8689dde - var_ddfe084a5f844081;
  plane = self;
  var_e4d26f59db05025a = "ks_auto_drone_mp";
  planestartpos = self.flightstartpos;
  var_7789cda8c1e3128e = self.angles;
  var_3a20f9101e50025f = 0.05;
  var_3a020e101e2ddead = self.var_602736e29283719a;
  var_7c39d972e849c204 = var_ddfe084a5f844081;
  var_a9b4b258c1167b50 = var_edc8eb6ff8689dde;
  self.flyfxent = level scripts\cp_mp\killstreaks\airstrike::airstrike_playflyfx(plane, var_e4d26f59db05025a, planestartpos, var_7789cda8c1e3128e, var_3a20f9101e50025f, var_3a020e101e2ddead, var_7c39d972e849c204, var_a9b4b258c1167b50, self.streakinfo);
  self moveTo(self.flightendpos, var_edc8eb6ff8689dde);
  wait var_ddfe084a5f844081;
  self.isleaving = 1;
  wait var_9a725e0702370e63;
  self hide();
  self.reachedgoal = 1;
  self notify("autodrone_flight_finished");
}

function function_7cd9f49e2a56ea1e() {
  self endon("death");
  self endon("autodrone_flight_finished");
  level endon("game_ended");
  scalemax = 0.15;
  scalemid = 0.075;
  scalemin = 0.0075;
  duration = 0.05;
  source = self.origin;
  scalemaxrange = 10000;
  var_a90593f8a59c9972 = 15000;
  scaleminrange = 50000;

  while(true) {
    function_e45e5fd94ec4af36(scalemax, scalemid, scalemin, duration, source, scalemaxrange, var_a90593f8a59c9972, scaleminrange);
    wait 0.05;
  }
}

function function_5072d07167c0ae44() {
  self endon("death");
  level endon("game_ended");
  self.owner endon("disconnect");
  self.autodronekills = 0;
  childthread function_85af195b469d31c5();
  childthread function_7507ce6b3db8bbc6();
  self waittill("autodrone_volley_finished");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

  if(self.autodronekills >= 1) {
    playkillstreakoperatordialog("auto_drone", "auto_drone" + "_hit_target");
    return;
  }

  playkillstreakoperatordialog("auto_drone", "auto_drone" + "_miss_target");
}

function function_85af195b469d31c5() {
  while(true) {
    self.owner waittill("update_rapid_kill_buffered", recentkills, weaponname);

    if(function_57a633080c56f0ab(weaponname)) {
      self.autodronekills++;
    }
  }
}

function function_7507ce6b3db8bbc6() {
  while(true) {
    self.owner waittill("update_rapid_agent_kill_buffered", recentkills, weaponname);

    if(function_57a633080c56f0ab(weaponname)) {
      self.autodronekills++;
    }
  }
}

function function_57a633080c56f0ab(weaponname) {
  return isDefined(weaponname) && weaponname == "auto_drone_proj_mp";
}

function function_e01ff9fbb932ee1a() {
  self endon("death");
  self endon("autodrone_volley_finished");
  level endon("game_ended");

  if(isDefined(level.var_b67b5f9dfe488c2f)) {
    thread[[level.var_b67b5f9dfe488c2f]](self.streakinfo);
  }

  thread function_83c774ec24aea7ba();

  if(!istrue(self.owner.ksempd)) {
    attackdelay = self.var_602736e29283719a;
    wait attackdelay;

    if(!istrue(self.owner.ksempd)) {
      self setscriptablepartstate("release", "active", 0);
      childthread function_fdef1908ab475a22("target_line_left");
      childthread function_fdef1908ab475a22("target_line_right");
      contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0, 0, 0);
      launchside = "none";
      explodeindex = 1;
      launchpos = self.origin;
      launchangles = self.angles;

      for(i = 0; i < self.var_bebe0d78a71db256; i++) {
        for(j = 0; j < 2; j++) {
          if(j == 1) {
            launchside = "target_line_right";
          } else {
            launchside = "target_line_left";
          }

          targetpos = function_3abd38166387d794(launchside, contentoverride, launchpos);

          if(isDefined(targetpos)) {
            thread function_c94461e02cfe0bb9(launchside, targetpos, explodeindex);
            explodeindex++;

            if(explodeindex > 25) {
              explodeindex = 1;
            }
          }
        }

        wait self.var_c588c0602c9a3b4d;
        launchpos += anglesToForward(launchangles) * (isDefined(level.var_25479c87b8ab495c.var_1f5176ea25f9060) ? level.var_25479c87b8ab495c.var_1f5176ea25f9060 : 500);
      }

      self setscriptablepartstate("release", "neutral", 0);
      function_464ed851fbd2e05();
    }
  }

  self notify("autodrone_volley_finished");
}

function function_3abd38166387d794(launchside, contentoverride, launchorigin) {
  if(!isDefined(launchorigin)) {
    launchorigin = self.origin;
  }

  launchangles = self.angles;
  launchcenter = undefined;
  target_offset = isDefined(level.var_25479c87b8ab495c.var_2d679ba09f41c961) ? level.var_25479c87b8ab495c.var_2d679ba09f41c961 : 300;

  switch (launchside) {
    case #"hash_ac43add84a7bdc09":
      launchcenter = launchorigin - anglestoright(launchangles) * target_offset;
      break;
    case #"hash_fedc29c8476c33aa":
      launchcenter = launchorigin + anglestoright(launchangles) * target_offset;
      break;
    default:
      launchcenter = launchorigin;
      break;
  }

  if(isDefined(launchcenter)) {
    launchpos = function_4864b3ee27853e8f(launchcenter, isDefined(level.var_25479c87b8ab495c.var_911596c06bea8357) ? level.var_25479c87b8ab495c.var_911596c06bea8357 : 300);
    bombtracestart = launchpos;
    bombtraceend = launchpos - (0, 0, 50000);
    bombtrace = scripts\engine\trace::ray_trace(bombtracestart, bombtraceend, undefined, contentoverride);
    bombexplodepos = undefined;

    if(bombtrace["hittype"] != "hittype_none") {
      bombexplodepos = bombtrace["position"];
    }

    return bombexplodepos;
  }

  return undefined;
}

function function_4864b3ee27853e8f(launchcenter, launchradius) {
  randdist = randomint(launchradius);
  randangle = randomint(360);
  x = launchcenter[0] + randdist * cos(randangle);
  y = launchcenter[1] + randdist * sin(randangle);
  z = launchcenter[2];
  point = (x, y, z);
  return point;
}

function function_c94461e02cfe0bb9(launchside, targetlocation, explodeindex) {
  function_feb32e136c3564d0(launchside, explodeindex, targetlocation, 1, 3);
}

function function_feb32e136c3564d0(firetype, fireindex, firelocation, fireduration, startdelayoffset) {
  if(!isDefined(startdelayoffset)) {
    startdelayoffset = 0;
  }

  var_effcc3654e4d3279 = spawnStruct();
  var_effcc3654e4d3279.scriptablepart = "explode_" + fireindex;
  var_effcc3654e4d3279.location = firelocation;
  var_effcc3654e4d3279.duration = fireduration;
  var_effcc3654e4d3279.starttime = gettime() + startdelayoffset * 1000;
  self.firequeue[firetype][self.firequeue[firetype].size] = var_effcc3654e4d3279;
}

function function_fdef1908ab475a22(firetype) {
  for(currentindex = 0; true; currentindex++) {
    if(self.firequeue[firetype].size < currentindex + 1) {
      waitframe();
      continue;
    }

    fireinfo = self.firequeue[firetype][currentindex];
    firepart = fireinfo.scriptablepart;
    firelocation = fireinfo.location;
    fireduration = fireinfo.duration;
    firestarttime = fireinfo.starttime;

    while(gettime() < firestarttime) {
      waitframe();
    }

    fireent = function_4d86e5fcc67998a4(firetype);

    if(!isDefined(fireent)) {
      iprintlnbold("<dev string:x6e>" + firetype + "<dev string:xb5>");

      waitframe();
      continue;
    }

    fireent.inuse = 1;
    fireent.origin = firelocation;

    debugtarget = getdvarint(@ "hash_30dee5c8d013379b", 0);

    if(debugtarget) {
      level thread scripts\cp_mp\utility\debug_utility::drawsphere(fireent.origin, 25, self.flighttime, (0, 1, 0));
    }

    waitframe();
    fireent childthread function_afb3d7504a849066(firepart, fireduration);
  }
}

function function_afb3d7504a849066(scriptablepart, fireduration) {
  self setscriptablepartstate(scriptablepart, "active", 0);
  wait fireduration;

  if(isDefined(level.var_ca1a76fbc0ba0bef)) {
    thread[[level.var_ca1a76fbc0ba0bef]](self.streakinfo, self.origin, 0);
  }

  self setscriptablepartstate(scriptablepart, "neutral", 0);
  self.inuse = 0;
}

function function_83c774ec24aea7ba() {
  level endon("game_ended");
  self waittill("autodrone_volley_finished");

  while(true) {
    if(istrue(self.reachedgoal)) {
      break;
    }

    waitframe();
  }

  function_75693ae9c1b5327f();
}

function function_464ed851fbd2e05() {
  level endon("game_ended");
  var_302f633427d41afc = 1;

  while(true) {
    var_302f633427d41afc = 1;

    foreach(var_205e3b3b6fc640ea in self.fireents) {
      foreach(fireent in var_205e3b3b6fc640ea) {
        if(istrue(fireent.inuse)) {
          var_302f633427d41afc = 0;
          break;
        }
      }

      if(!istrue(var_302f633427d41afc)) {
        break;
      }
    }

    if(!istrue(var_302f633427d41afc)) {
      waitframe();
      continue;
    }

    break;
  }
}

function function_4d86e5fcc67998a4(firetype) {
  if(!isDefined(self.owner)) {
    return;
  }

  fireent = undefined;
  firemodel = isDefined(level.var_25479c87b8ab495c.var_4b6066fcdd13f1b9) ? level.var_25479c87b8ab495c.var_4b6066fcdd13f1b9 : "ks_auto_drone_target_mp";

  if(self.fireents[firetype].size == 0) {
    fireent = function_762e969612131da2(firetype, firemodel);
  } else {
    entlist = self.fireents[firetype];

    foreach(ent in entlist) {
      if(!istrue(ent.inuse)) {
        fireent = ent;
        break;
      }
    }

    if(!isDefined(fireent) && entlist.size < 10) {
      fireent = function_762e969612131da2(firetype, firemodel);
    }
  }

  return fireent;
}

function function_762e969612131da2(firetype, firemodel) {
  fireent = spawn("script_model", self.origin);
  fireent.inuse = 0;
  fireent.streakinfo = self.streakinfo;
  fireent.weapon_name = "auto_drone_proj_mp";
  fireent.killcament = self.killcament;
  fireent setModel(firemodel);
  fireent dontinterpolate();
  fireent setentityowner(self.owner);
  self.fireents[firetype][self.fireents[firetype].size] = fireent;
  return fireent;
}