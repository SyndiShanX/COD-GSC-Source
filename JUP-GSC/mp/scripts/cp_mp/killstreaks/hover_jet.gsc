/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\hover_jet.gsc
***************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\turret_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace hover_jet;

function init() {
  if(issharedfuncdefined("hover_jet", "init")) {
    [[getsharedfunc("hover_jet", "init")]]();
  }

  bundle = level.streakglobals.streakbundles["<dev string:x1c>"];

  if(isDefined(bundle)) {
    setdevdvarifuninitialized(@ "hash_66bec5bd52437caf", ter_op(isDefined(bundle), bundle.lifetime, 45));
  } else {
    setdevdvarifuninitialized(@ "hash_66bec5bd52437caf", 45);
  }

  setdevdvarifuninitialized(@ "hash_48714771f0d0b941", 0);
  setdevdvarifuninitialized(@ "hash_de4ffc2e910521a1", 0);
  setdevdvarifuninitialized(@ "hash_125a1951df8627f5", 0);
  setdevdvarifuninitialized(@ "hash_92fce2b3a811a13f", 0);
  setdevdvarifuninitialized(@ "hash_8ef299ce102da922", 3);

  function_3775988f960ec3e6();
  init_hover_jet_anims();
  init_hover_jet_vo();
}

function function_3775988f960ec3e6() {
  level.hoverjets = [];
  level.incomingallhoverjets = 0;

  foreach(teamname in level.teamnamelist) {
    level.incominghoverjets[teamname] = 0;
  }
}

#using_animtree("mp_vehicles_always_loaded");

function init_hover_jet_anims() {
  level.scr_anim["hover_jet"]["airstrike_flyby_loop"] = % mp_halfa_flyin;
  level.scr_anim["hover_jet"]["airstrike_flyby_bank"] = % iw9_mp_halfa_strike_01;
  level.scr_anim["hover_jet"]["airstrike_flyby_straight"] = % iw9_mp_halfa_strike_02;
  level.scr_anim["hover_jet"]["exit"] = % mp_halfa_exit;
}

function init_hover_jet_vo() {
  game["dialog"]["hover_jet" + "_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["hover_jet" + "_leave"] = "killstreak_remote_operator" + "_leave";
  game["dialog"]["hover_jet" + "_crash"] = "killstreak_remote_operator" + "_crash";
  game["dialog"]["hover_jet" + "_confirm"] = "killstreak_remote_operator" + "_confirm_general";
}

function weapongivenhoverjet(streakinfo) {
  if(issharedfuncdefined("killstreak", "startMapSelectSequence")) {
    self[[getsharedfunc("killstreak", "startMapSelectSequence")]](undefined, undefined, undefined, undefined, streakinfo);
  }

  return true;
}

function tryusehoverjet() {
  streakinfo = createstreakinfo("hover_jet", self);
  return tryusehoverjetfromstruct(streakinfo);
}

function tryusehoverjetfromstruct(streakinfo) {
  team = self.team;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    return false;
  }

  if(isDefined(level.activekillstreaks)) {
    foreach(streak in level.activekillstreaks) {
      if(streak.owner != self) {
        continue;
      }

      switch (streak.streakname) {
        case #"hash_a1031216158c7882":
          if(issharedfuncdefined("hud", "showErrorMessage")) {
            [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
          }

          return false;
      }
    }
  }

  level.incomingallhoverjets++;
  var_f2efed389ae42a3c = 1;

  if(islargemap()) {
    var_f2efed389ae42a3c = 2;
  }

  if(level.hoverjets.size >= var_f2efed389ae42a3c || level.hoverjets.size + level.incomingallhoverjets > var_f2efed389ae42a3c) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.incomingallhoverjets--;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(islargemap() && level.teambased) {
    var_f8dbaa792bfd1c9f = 1;
    level.incominghoverjets[team]++;

    if(getnumactivekillstreakperteam(team, level.hoverjets) + level.incominghoverjets[team] > var_f8dbaa792bfd1c9f) {
      level.incomingallhoverjets--;
      level.incominghoverjets[team]--;

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_VTOL_JET");
      }

      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  result = _tryusehoverjetfromstructinternal(streakinfo);
  level.incomingallhoverjets--;

  if(islargemap() && level.teambased) {
    level.incominghoverjets[team]--;
  }

  if(!istrue(result)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  return true;
}

function _tryusehoverjetfromstructinternal(streakinfo) {
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

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, makeweapon("ks_remote_map_mp"), 1, &weapongivenhoverjet);

  if(!istrue(deployresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  self playlocalsound("iw9_ks_tablet_ui_screen_plr");
  mappointinfo = undefined;

  if(issharedfuncdefined("killstreak", "getSelectMapPoint")) {
    mappointinfo = self[[getsharedfunc("killstreak", "getSelectMapPoint")]](streakinfo, 1);
    self playlocalsound("iw9_ks_tablet_ui_select_final_plr");
  }

  streakinfo.owner notify("killstreak_deploy_finished", streakinfo.streakname);

  if(!isDefined(mappointinfo)) {
    return false;
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
  thread starthoverjetairstrikepass(self, streakinfo, mappointinfo);
  var_52a5be2e2f91d710 = undefined;

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    var_52a5be2e2f91d710 = 2.5;
  }

  thread playkillstreakoperatordialog("hover_jet", "hover_jet" + "_use", 1, var_52a5be2e2f91d710);
  utility::trycall(level.matchdata_logkillstreakevent, "hover_jet", self.origin);

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + "hover_jet", self);
  }

  return true;
}

function starthoverjetairstrikepass(owner, streakinfo, mappointinfo) {
  if(isDefined(level.var_b67b5f9dfe488c2f)) {
    thread[[level.var_b67b5f9dfe488c2f]](streakinfo);
  }

  level endon("game_ended");
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  planehalfdistance = 24000;
  planeflyspeed = 6500;
  planeflyheight = 3250;
  planehoverheight = 1000;
  heightoffset = (0, 0, 0);
  planebombexplodedistance = 1500;
  direction = owner.angles;
  var_505331ad630bbc6b = 1;

  if(isDefined(heightent)) {
    planeflyheight = heightent.origin[2] + 750;
  }

  localeid = scripts\cp_mp\utility\game_utility::getlocaleid();

  if(isDefined(localeid) && localeid == "locale_6") {
    planeflyheight += 500;
  }

  var_5ceb15b939485b52 = getdvarint(@ "hash_698613e6c8c52243", 0);
  planeflyheight += var_5ceb15b939485b52;

  maplocation = mappointinfo[0].location;
  direction = scripts\cp_mp\killstreaks\airstrike::callstrike_findoptimaldirection(owner, maplocation, planeflyheight, planehalfdistance);
  flightpath = scripts\cp_mp\killstreaks\airstrike::getflightpath(maplocation, direction, planehalfdistance, heightent, planeflyheight, planeflyspeed, planebombexplodedistance, streakinfo.streakname, var_505331ad630bbc6b);
  pathstart = flightpath["startPoint"];
  pathgoal = flightpath["endPoint"];
  bundle = level.streakglobals.streakbundles["hover_jet"];

  if(!isDefined(bundle)) {
    bundle = spawnStruct();
    bundle.lifetime = 60;
    bundle.maxhealth = 2500;
    bundle.maxflares = 1;
  }

  jetmodel = "veh9_mil_air_halfa_mp";
  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  jet = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, pathstart, direction, "veh_hover_jet_mp_phys", jetmodel);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    jet[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_b5a9a3ea21b6ea62);
  }

  if(!isDefined(jet)) {
    return;
  }

  jetlifetime = bundle.lifetime;

  modifiedlifetime = getdvarint(@ "hash_66bec5bd52437caf", bundle.lifetime);
  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    modifiedlifetime = 9999;
  }

  jetlifetime = modifiedlifetime;

  jet.speed = 250;
  jet.accel = 175;
  jet.health = bundle.maxhealth;
  jet.maxhealth = bundle.maxhealth;
  jet.currenthealth = bundle.maxhealth;
  jet.angles = vectortoangles(direction);
  jet.lifetime = jetlifetime;
  jet.team = owner.team;
  jet.owner = owner;
  jet.streakinfo = streakinfo;
  jet.streakname = streakinfo.streakname;
  jet.flaresreservecount = bundle.maxflares;
  jet.returngoal = maplocation;
  jet.flyheight = planeflyheight;
  jet.hoverheight = planehoverheight;
  jet.missiles = 6;
  jet.pers["team"] = jet.team;
  jet.bestgroundtarget = undefined;
  jet.bestairtarget = undefined;
  jet.flightdir = flightpath["directionAngles"];
  jet setmaxpitchroll(0, 90);
  jet vehicle_setspeed(jet.speed, jet.accel);
  jet sethoverparams(50, 100, 50);
  jet setturningability(0.05);
  jet setyawspeed(45, 25, 25, 0.5);
  jet setotherent(jet.owner);
  jet setCanDamage(1);
  jet setneargoalnotifydist(700);
  jet setvehicleteam(jet.team);
  jet function_247ad6a91f6a4ffe(1);
  level thread function_ee93617532d8a679(jet, owner, &hoverjet_explode);
  jet setscriptablepartstate("blinking_lights", "on", 0);
  jet setscriptablepartstate("thrusters", "active", 0);
  jet setscriptablepartstate("contrails", "on", 0);
  jet.turret = spawnturret("misc_turret", jet gettagorigin("tag_turret"), "hover_jet_turret_ballistics_mp");
  jet.turret setModel("veh9_mil_air_halfa_turret");
  jet.turret.owner = jet.owner;
  jet.turret.team = jet.team;
  jet.turret.angles = jet.angles;
  jet.turret.streakinfo = streakinfo;
  jet.turret linkTo(jet, "tag_turret", (0, 0, 5), (0, 0, 0));
  jet.turret setturretteam(jet.team);
  jet.turret setturretmodechangewait(0);
  jet.turret setmode("manual_target");
  jet.turret setsentryowner(jet.owner);
  jet.turret setdefaultdroppitch(45);
  jet.turret maketurretinoperable();
  jet.turret setleftarc(360);
  jet.turret setrightarc(360);
  jet.turret setbottomarc(90);
  jet.turret settoparc(90);
  jet.turret setconvergencetime(0.5, "pitch");
  jet.turret setconvergencetime(0.5, "yaw");
  jet.turret setconvergenceheightpercent(0.65);
  jet.killcament = spawn("script_model", jet.turret gettagorigin("bi_center"));
  jet.killcament linkTo(jet, "tag_origin", (-500, 0, 500), (0, 0, 0));
  jet.turret.killcament = jet.killcament;
  jet.turret.groundtargetent = spawn("script_model", jet.origin);
  jet.turret.groundtargetent setModel("tag_origin");
  jet.turret.groundtargetent dontinterpolate();
  level.hoverjets[level.hoverjets.size] = jet;
  level notify("vtol_jet_arrived");

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    jet[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);
  }

  jet.animname = streakinfo.streakname;
  jet.scenenode = spawn("script_model", jet.returngoal * (1, 1, 0) + (0, 0, planeflyheight));
  jet.scenenode.angles = jet.angles;
  jet.scenenode setModel("tag_origin");
  jet function_fbda9177c810ff24(maplocation);

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    jet thread scripts\cp_mp\killstreaks\airstrike::function_fc41f67ef33c00b0(pathstart, pathgoal, (1, 1, 1), 20);
    jet thread scripts\cp_mp\killstreaks\airstrike::function_aca0ec4cab6e6319(planeflyheight, pathgoal);
    sphere(jet.scenenode.origin, 100, (1, 0, 1), 0, 500);
  }

  if(iscp()) {
    jet.turret makeentitysentient("allies");

    if(!threatbiasgroupexists("Killstreak_VTOL_MG")) {
      createthreatbiasgroup("Killstreak_VTOL_MG");
    }

    jet.turret setthreatbiasgroup("Killstreak_VTOL_MG");
    setthreatbiasagainstall("Killstreak_VTOL_MG", 3000);
  }

  jet hoverjet_playflyfx();
  var_c51de0af53e40876 = function_9f6c5e46080e47dc();
  var_9bc4a52a93594ddd = getanimlength(level.scr_anim[jet.animname][var_c51de0af53e40876]);
  var_2e44aa5689f2db63 = get_notetrack_time(level.scr_anim[jet.animname][var_c51de0af53e40876], "contrail_off");
  jet.scenenode thread scripts\common\anim::anim_single_solo(jet, var_c51de0af53e40876);
  jet thread hoverjet_delaysetscriptable(var_2e44aa5689f2db63, "contrails", "off");
  jet thread hoverjet_watchgameend();

  if(issharedfuncdefined("hover_jet", "registerSentient")) {
    jet[[getsharedfunc("hover_jet", "registerSentient")]]("Killstreak_Air", self);
  }

  jet function_58258fda8ee98d76(streakinfo.streakname);

  if(issharedfuncdefined("flares", "handleIncomingStinger")) {
    jet thread[[getsharedfunc("flares", "handleIncomingStinger")]](&hoverjet_handlemissiledetection);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_9bc4a52a93594ddd);

  level notify("<dev string:x29>");

  if(!isDefined(jet)) {
    return;
  }

  if(isDefined(jet.scenenode)) {
    jet.scenenode delete();
  }

  jet starthoverjetdefend(streakinfo);
}

function hoverjet_delaysetscriptable(delaytime, part, state) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);
  self setscriptablepartstate(part, state, 0);
}

function hoverjet_playflyfx() {
  thread delaythread(0.05, &hoverjet_playapproachfx);
  thread delaythread(6, &hoverjet_playflybyfx);
  thread delaythread(14, &hoverjet_playreturnfx);
}

function hoverjet_playapproachfx() {
  if(getgametype() == "wm") {
    self playsoundonmovingent("ks_wm_hoverjet_approach");
    return;
  }

  self playsoundonmovingent("ks_hoverjet_approach");
}

function hoverjet_playflybyfx() {
  if(getgametype() == "wm" && level.mapname == "mp_jup_skydiving") {
    self playsoundonmovingent("ks_wm_hoverjet_flyby");
    return;
  }

  self playsoundonmovingent("ks_hoverjet_flyby");
}

function hoverjet_playreturnfx() {
  if(getgametype() == "wm" && level.mapname == "mp_jup_skydiving") {
    self playsoundonmovingent("ks_wm_hoverjet_return");
    return;
  }

  self playsoundonmovingent("ks_hoverjet_return");
}

function function_fbda9177c810ff24(targetlocation) {
  var_caeb7635e74ead06 = getdvarint(@ "hash_8ef299ce102da922", 3);
  thread function_41780f288d860974(targetlocation, var_caeb7635e74ead06);
  thread function_f42c29a91cabc8c2(targetlocation, var_caeb7635e74ead06);
}

function function_41780f288d860974(targetlocation, var_caeb7635e74ead06) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");

  if(var_caeb7635e74ead06 != 0) {
    return;
  }

  var_c51de0af53e40876 = function_9f6c5e46080e47dc();
  var_7b00721e9d1ef2a0 = get_notetrack_time(level.scr_anim["hover_jet"][var_c51de0af53e40876], "attack");
  var_26689f6158b948aa = var_7b00721e9d1ef2a0 - 4;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_26689f6158b948aa);
  content = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid"];
  contentoverride = physics_createcontents(content);
  var_ebeaa9648906468 = self.angles * (0, 1, 0);
  jetforward = anglesToForward(var_ebeaa9648906468);
  jetright = anglestoright(var_ebeaa9648906468);
  targetlocations = [targetlocation - jetforward * 2250 + jetright * 750, targetlocation - jetforward * 1500 - jetright * 750, targetlocation - jetforward * 750 + jetright * 250, targetlocation - jetright * 250, targetlocation + jetforward * 750 + jetright * 750, targetlocation + jetforward * 1500 - jetright * 750, targetlocation + jetforward * 2250 + jetright * 250, targetlocation + jetforward * 3000 - jetright * 250];
  var_c0c290150bfe81b7 = ["tag_right_aphid_missile", "tag_left_aphid_missile", "tag_right_archer_missile", "tag_left_archer_missile"];
  var_43cf5d2a3c531d4b = 0;
  missiletargets = [];

  foreach(index, location in targetlocations) {
    starttrace = location + (0, 0, 10000);
    endtrace = location - (0, 0, 10000);
    targettrace = ray_trace(starttrace, endtrace, level.characters, contentoverride);
    enemies = utility::playersinsphere(targettrace["position"], 1000);
    missiletarget = hoverjet_findmissiletarget(enemies, missiletargets);
    missilelocation = self gettagorigin(var_c0c290150bfe81b7[var_43cf5d2a3c531d4b]) + anglesToForward(self gettagangles(var_c0c290150bfe81b7[var_43cf5d2a3c531d4b])) * 300;
    missile = _magicbullet(makeweapon("hover_jet_proj_mp"), missilelocation, targettrace["position"], self.owner);
    missile.killcament = spawn("script_model", missile.origin);
    missile.killcament linkTo(missile, "tag_origin", (-100, 0, 500), (0, 0, 0));
    missile.killcament thread hoverjet_missilekillcammove(targettrace["position"], missile.angles);
    missile.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    thread hoverjet_firemissilescriptable(var_43cf5d2a3c531d4b + 1);

    if(isDefined(missiletarget)) {
      location = missiletarget.origin;
      missiletargets[missiletargets.size] = missiletarget;
      thread hoverjet_delaymissiletracking(missile, 0.05, missiletarget);
    }

    airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

    if(isDefined(airstrikedebugon) && airstrikedebugon) {
      self.owner iprintlnbold("<dev string:x3c>" + index + 1);

      if(isDefined(missiletarget)) {
        sphere(location, 500, (0, 1, 0), 0, 1000);
      } else {
        sphere(location, 500, (1, 0, 0), 0, 1000);
      }
    }

    wait 0.5;
    var_43cf5d2a3c531d4b++;

    if(var_43cf5d2a3c531d4b > var_c0c290150bfe81b7.size - 1) {
      var_43cf5d2a3c531d4b = 0;
    }
  }

  missiletargets = undefined;
}

function function_f42c29a91cabc8c2(targetlocation, var_caeb7635e74ead06) {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");

  if(var_caeb7635e74ead06 != 1 && var_caeb7635e74ead06 != 2 && var_caeb7635e74ead06 != 3) {
    return;
  }

  bombnotetrack = "attack";

  if(var_caeb7635e74ead06 == 1) {
    bombnotetrack = "attack_bomb";
  }

  var_c51de0af53e40876 = function_9f6c5e46080e47dc();
  var_56d62165cf89d99c = get_notetrack_time(level.scr_anim["hover_jet"][var_c51de0af53e40876], bombnotetrack);
  var_d7c48eccae06e020 = targetlocation + self.flightdir * 500;

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(istrue(airstrikedebugon)) {
    thread scripts\cp_mp\utility\debug_utility::drawsphere(targetlocation, 20, 20, (1, 1, 0));
  }

  wait var_56d62165cf89d99c;
  sideoffset = 100;
  bundle = level.streakglobals.streakbundles["hover_jet"];

  if(!isDefined(bundle)) {
    bundle = spawnStruct();
    bundle.maxbombs = 6;
  }

  for(i = 0; i < bundle.maxbombs; i++) {
    function_2b7c965fb8b07829(var_d7c48eccae06e020, sideoffset);
    sideoffset *= -1;
    wait 0.095;
  }

  thread function_3f69aefa7b90fb4a();
}

function function_2b7c965fb8b07829(targetlocation, sideoffset) {
  if(!isDefined(sideoffset)) {
    sideoffset = 0;
  }

  bombweaponname = "hover_jet_bomb_mp";
  bomblifetime = 10;
  bomborigin = self.origin - anglestoright(self.angles) * sideoffset;
  var_8c9add3c0a2a7dc1 = bomborigin - anglestoup(self.angles) * randomintrange(100, 300);
  var_67c9be17f01e1d77 = vectorNormalize(targetlocation - self.origin);
  bombtarget = var_8c9add3c0a2a7dc1 + var_67c9be17f01e1d77 * distance(var_8c9add3c0a2a7dc1, targetlocation);
  bombvelocity = bombtarget - var_8c9add3c0a2a7dc1;

  if(scripts\engine\utility::issharedfuncdefined("weapons", "_launchGrenade")) {
    bomb = self[[scripts\engine\utility::getsharedfunc("weapons", "_launchGrenade")]](bombweaponname, var_8c9add3c0a2a7dc1, bombvelocity, bomblifetime);
    bomb.streakinfo = self.streakinfo;
    bomb.killcament = self.killcament;
    bomb thread function_d6c447fe14ce9a65();
  }

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(istrue(airstrikedebugon)) {
    thread scripts\cp_mp\utility\debug_utility::drawsphere(var_8c9add3c0a2a7dc1, 20, 10, (0, 1, 0));
    thread scripts\cp_mp\utility\debug_utility::drawline(var_8c9add3c0a2a7dc1, bombtarget, 10, (1, 1, 1));
    thread scripts\cp_mp\utility\debug_utility::drawsphere(bombtarget, 20, 10, (1, 0, 0));
  }
}

function function_d6c447fe14ce9a65() {
  level endon("game_ended");
  self waittill("explode", position);

  if(issharedfuncdefined("shellshock", "artillery_earthQuake")) {
    [[getsharedfunc("shellshock", "artillery_earthQuake")]](position);
  }
}

function hoverjet_missilekillcammove(impactlocation, missileangles) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self unlink();
  self moveTo(impactlocation - anglesToForward(missileangles) * 750, 6);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(7);
  self delete();
}

function hoverjet_firemissilescriptable(missileindex) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + missileindex, "on", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
  self setscriptablepartstate("fire_missile_" + missileindex, "off", 0);
}

function hoverjet_findmissiletarget(targets, existingtargetarray) {
  visibletarget = undefined;

  foreach(target in targets) {
    if(level.teambased && target.team == self.team) {
      continue;
    }

    if(target == self.owner) {
      continue;
    }

    if(array_contains(existingtargetarray, target)) {
      continue;
    }

    if(issharedfuncdefined("perk", "hasPerk")) {
      if(target[[getsharedfunc("perk", "hasPerk")]]("specialty_blindeye")) {
        continue;
      }
    }

    visibletarget = target;
    break;
  }

  return visibletarget;
}

function hoverjet_delaymissiletracking(missile, delaytime, missiletargetent) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(delaytime);

  if(isDefined(missile)) {
    missile missile_settargetEnt(missiletargetent, (0, 0, 10));
  }
}

function hoverjet_delayresetscriptable(explosionindex) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("explode" + explosionindex, "active", 0);
  wait 1;
  self setscriptablepartstate("explode" + explosionindex, "neutral", 0);
}

function starthoverjetdefend(streakinfo) {
  thread hoverjet_defendlocation(self.returngoal);

  thread function_9480f8b8d48d0f59(self.owner);
}

function hoverjet_defendlocation(defloc) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  if(self vehicle_isphysveh()) {
    self stopanimScripted();
    self vehphys_setdefaultmotion();
  }

  thread hoverjet_watchlifetime(self.lifetime);
  thread hoverjet_watchowner();
  thread hoverjet_startcombatlogic();
  wait 0.05;
  thread hoverjet_movetolocation(defloc);
}

function hoverjet_handlemissiledetection(player, missileteam, missiletarget, fxtagoverride) {
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

function hoverjet_watchlifetime(lifetime) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(lifetime);

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    self.owner iprintlnbold("<dev string:x65>");
  }

  playkillstreakoperatordialog("hover_jet", "hover_jet" + "_leave", 1);
  thread hoverjet_leave();
}

function hoverjet_watchgameend() {
  self endon("death");
  level waittill("game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  thread hoverjet_leave();
}

function hoverjet_watchowner() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  thread hoverjet_leaveonownernotify("disconnect");
  thread hoverjet_leaveonownernotify("joined_team");
}

function hoverjet_leaveonownernotify(notifymsg) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(notifymsg);
  thread hoverjet_leave();
}

function hoverjet_startcombatlogic() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(45, 10);
  thread hoverjet_watchforreposition();
  thread hoverjet_engagegroundtargets();

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    self.owner setclientomnvar("ui_using_hover_jet", 1);
  }

  self setscriptablepartstate("thrusters", "idle", 0);
}

function hoverjet_movetolocation(location) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  ignorelist = [self, self.turret];

  while(true) {
    currentpos = self.origin;
    initialgoalpos = location * (1, 1, 0) + (0, 0, self.origin[2]);
    obstructiontrace = sphere_trace(currentpos, initialgoalpos, 256, ignorelist);
    obstructed = 0;
    goalx = location[0];
    goaly = location[1];

    if(isDefined(obstructiontrace)) {
      if(obstructiontrace["hittype"] != "hittype_none") {
        goalx = obstructiontrace["position"][0];
        goaly = obstructiontrace["position"][1];
        obstructed = 1;
      }
    }

    goalz = hoverjet_getcorrectheight(goalx, goaly, 20);
    newpos = (goalx, goaly, goalz);
    self setvehgoalpos(newpos, 1);

    airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

    if(istrue(airstrikedebugon)) {
      thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, newpos, 20, (1, 1, 1));
      thread scripts\cp_mp\utility\debug_utility::drawsphere(newpos, 20, 20, (1, 0, 0));
    }

    self waittill("near_goal");

    if(!istrue(obstructed)) {
      self.currentguardlocation = newpos;
      self notify("hoverJet_moveToNewlocation", newpos);
      break;
    }
  }

  self clearlookatent();
}

function hoverjet_getcorrectheight(x, y, rand) {
  offgroundheight = self.hoverheight;

  var_8b2cb9f843e54ad0 = getdvarint(@ "hash_92fce2b3a811a13f", 0);
  offgroundheight += var_8b2cb9f843e54ad0;

  groundheight = hoverjet_tracegroundpoint(x, y);
  trueheight = groundheight + offgroundheight;
  trueheight += randomint(rand);
  return trueheight;
}

function hoverjet_tracegroundpoint(x, y) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  z = -99999;
  currz = self.origin[2];
  minz = level.averagealliesz;
  contentoverride = create_contents(0, 1, 1, 1, 1, 0, 0, 0, 0);
  trc = sphere_trace((x, y, currz), (x, y, z), 512, self, contentoverride, 1);

  if(trc["position"][2] < minz) {
    hightrace = minz;
  } else {
    hightrace = trc["position"][2];
  }

  return hightrace;
}

function hoverjet_engagegroundtargets() {
  self notify("engageGround");
  self endon("engageGround");
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  thread function_7cad88468df8256e();

  while(true) {
    besttargetdata = undefined;

    if(!isDefined(self.bestgroundtarget)) {
      var_8b9f24ff1c0d7822 = undefined;
      var_1833609413f67de7 = undefined;
      ignoreplayerteam = undefined;

      if(utility::iscp()) {
        var_8b9f24ff1c0d7822 = "allies";
        var_1833609413f67de7 = 1;
        ignoreplayerteam = 1;
      }

      besttargetdata = function_770a14e56b03b067(self.turret, 3000, 1, 0, 0, undefined, @ "hash_48714771f0d0b941", var_8b9f24ff1c0d7822, var_1833609413f67de7, ignoreplayerteam);

      if(!isDefined(besttargetdata)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
        continue;
      }

      self.bestgroundtarget = function_70b8756e9fc03c44(besttargetdata);
      self notify("acquiringTarget", self.bestgroundtarget);
    }

    self.turret settargetentity(self.turret.groundtargetent);

    if(!isDefined(self.bestairtarget)) {
      self setlookatent(self.bestgroundtarget);
    }

    var_f14a9b1e9835aeaf = function_effebb9076efbdb(besttargetdata);
    thread hoverjet_watchtargetstatus(self.bestgroundtarget);
    thread hoverjet_watchtargetlos(self.bestgroundtarget, undefined, var_f14a9b1e9835aeaf);
    thread hoverjet_watchtargettimeout(self.bestgroundtarget);
    hoverjet_fireongroundtarget(isDefined(var_f14a9b1e9835aeaf));
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

function function_7cad88468df8256e() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self.turret waittill("missile_fire", projectile);
    projectile.streakinfo = self.streakinfo;
    projectile.killcament = self.killcament;
  }
}

function hoverjet_fireongroundtarget(targetvehicle) {
  firetime = weaponfiretime("hover_jet_turret_ballistics_mp");
  var_db0ea2c2c400255 = 0;
  var_dbc5aeb90480b355 = 0;
  attackradius = 100;

  while(isDefined(self) && isDefined(self.bestgroundtarget) && !isDefined(self.iscrashing) && !isDefined(self.isleaving)) {
    if(self.turret hoverjet_turretlookingattarget()) {
      airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

      if(isDefined(airstrikedebugon) && airstrikedebugon) {
        sphere(self.bestgroundtarget.origin, 20, (1, 0, 0), 0, 100);
      }

      var_de95d26a97999b92 = undefined;

      if(isDefined(targetvehicle)) {
        var_de95d26a97999b92 = self.bestgroundtarget.origin;
      } else {
        var_de95d26a97999b92 = self.bestgroundtarget gettagorigin("j_mainroot");
      }

      scripts\cp_mp\killstreaks\chopper_support::choppersupport_setattackpoint(self.turret, self.bestgroundtarget, var_de95d26a97999b92, attackradius);

      if(var_dbc5aeb90480b355 == 0) {
        wait 0.1;
      }

      if(var_dbc5aeb90480b355 == 15) {
        attackradius = 50;
      } else if(var_dbc5aeb90480b355 == 30) {
        attackradius = undefined;
      }

      if(!istrue(self.var_d7b89e030dda87bf)) {
        self.turret shootturret("tag_flash");
        var_dbc5aeb90480b355++;
        self.turret.streakinfo.shots_fired++;
      }
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(firetime);
  }
}

function hoverjet_turretlookingattarget() {
  maxviewangle = 0.996;
  turretforward = anglesToForward(self gettagangles("tag_flash"));
  targetdisplace = vectorNormalize(self.groundtargetent.origin - self.origin);
  var_ff53e400dd536b82 = vectordot(turretforward, targetdisplace);

  if(isDefined(self gettargetentity(1)) && var_ff53e400dd536b82 >= maxviewangle) {
    return true;
  }

  return false;
}

function hoverjet_engageairtargets() {
  self notify("engageAir");
  self endon("engageAir");
  self endon("death");
  self endon("leaving");
  level endon("game_ended");

  while(true) {
    if(!isDefined(self.bestairtarget)) {
      var_18603c41332bf068 = [];
      var_18603c41332bf068 = array_combine(level.helis, level.littlebirds, level.supportdrones);
      self.bestairtarget = hoverjet_getbestairtarget(var_18603c41332bf068);
      self notify("hoverJet_acquiringAirTarget", self.bestairtarget);

      if(!isDefined(self.bestairtarget)) {
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
        continue;
      }
    }

    thread hoverjet_watchtargetstatus(self.bestairtarget);
    hoverjet_fireonairtarget();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);
  }
}

function hoverjet_fireonairtarget() {
  missileside = "right";
  var_b144b7d889960d44 = makeweapon("hover_jet_proj_mp");
  playedvo = undefined;
  self setlookatent(self.bestairtarget);

  while(isDefined(self) && isDefined(self.bestairtarget)) {
    targettimeout = 5;

    if(!istrue(playedvo)) {
      playedvo = 1;
    }

    while(targettimeout > 0 && isDefined(self.bestairtarget) && !hoverjet_airtargetiswithinview(self.bestairtarget)) {
      targettimeout -= level.framedurationseconds;
      waitframe();
    }

    if(isDefined(self.bestairtarget)) {
      hoverjet_moveawayfromtarget(self.bestairtarget);
    } else {
      break;
    }

    airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

    if(isDefined(airstrikedebugon) && airstrikedebugon) {
      line(self gettagorigin("<dev string:x7a>"), self.bestairtarget.origin, (1, 0, 1), 1, 0, 1);
    }

    if(isDefined(self.bestairtarget)) {
      var_3f5937ab90734769 = self gettagorigin("tag_" + missileside + "_archer_missile") + anglesToForward(self.angles) * 100;
      var_77e91c731500dfe8 = var_3f5937ab90734769 + anglesToForward(self.angles) * 100;
      missile = _magicbullet(var_b144b7d889960d44, var_3f5937ab90734769, var_77e91c731500dfe8, self.owner);
      missileoffset = hoverjet_setmissileoffset(self.bestairtarget);
      missile missile_settargetEnt(self.bestairtarget, missileoffset);
      missile.streakinfo = self.streakinfo;

      if(missileside == "right") {
        missileside = "left";
      } else {
        missileside = "right";
      }
    } else {
      break;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  }

  if(istrue(self.movedoffguardlocation)) {
    thread hoverjet_movetolocation(self.currentguardlocation);
    self.movedoffguardlocation = undefined;
  }
}

function hoverjet_setmissileoffset(target) {
  offset = (0, 0, 0);

  if(isDefined(target.streakinfo)) {
    switch (target.streakinfo.streakname) {
      case #"hash_349713b5ad494dda":
      case #"hash_691f39dddd9116b8":
        offset = (0, 0, -50);
        break;
      case #"hash_f64c697bfb4c6b54":
        offset = (0, 0, -30);
        break;
      case #"hash_bf2f9adbd2b41d5":
        offset = (0, 0, 20);
        break;
      case #"hash_27002778019fb447":
        offset = (0, 0, 10);
        break;
    }
  }

  return offset;
}

function hoverjet_airtargetiswithinview(airtarget) {
  maxviewangle = 0.866;
  jetforward = anglesToForward(self.angles);
  targetdisplace = vectorNormalize(airtarget.origin - self.origin);
  var_ff53e400dd536b82 = vectordot(jetforward, targetdisplace);
  return ter_op(var_ff53e400dd536b82 >= maxviewangle, 1, 0);
}

function hoverjet_airtargetistooclose(airtarget) {
  return ter_op(distance2dsquared(airtarget.origin, self.origin) < 1000000, 1, 0);
}

function hoverjet_moveawayfromtarget(airtarget) {
  while(isDefined(airtarget) && hoverjet_airtargetistooclose(airtarget)) {
    newpos = undefined;
    jetforward = anglesToForward(self.angles);
    jetright = anglestoright(self.angles);
    firstpos = self.origin - jetforward * 1000;
    secondpos = self.origin + 707 * (jetright - jetforward);
    thirdpos = self.origin + 707 * (-1 * jetforward - jetright);
    var_e2f36ecdae896a0a = [firstpos, secondpos, thirdpos];
    var_b9d5783a4f34efbc = [self, airtarget];

    foreach(position in var_e2f36ecdae896a0a) {
      if(sphere_trace_passed(self.origin, position, 256, var_b9d5783a4f34efbc)) {
        newpos = position * (1, 1, 0) + (0, 0, airtarget.origin[2]);
      }
    }

    if(isDefined(newpos)) {
      self.movedoffguardlocation = 1;
      self setvehgoalpos(newpos, 1);
    }

    waitframe();
  }
}

function function_e05ade915e49f05f() {
  function_b6018909193826e4();
  self.var_ad9affc67934f84d = scripts\mp\objidpoolmanager::requestobjectiveid();
  icon_pos = self.origin + (0, 0, 0);
  objective_add_objective(self.var_ad9affc67934f84d, "current", icon_pos, "hud_icon_killstreak_hover_jet", "icon_regular");
  objective_playermask_hidefromall(self.var_ad9affc67934f84d);
  objective_set_play_intro(self.var_ad9affc67934f84d, 0);
  objective_playermask_addshowplayer(self.var_ad9affc67934f84d, self);
  function_9766d0b79eada249(self.var_ad9affc67934f84d, 1);
  objective_setbackground(self.var_ad9affc67934f84d, 1);
  objective_settint(self.var_ad9affc67934f84d, 224, 224, 224, 1);
}

function function_b6018909193826e4() {
  if(isDefined(self.var_ad9affc67934f84d)) {
    objective_delete(self.var_ad9affc67934f84d);
  }
}

function hoverjet_watchforreposition() {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("game_ended");
  self setneargoalnotifydist(100);
  function_e68434bdb941ed1e(self.streakinfo.streakname, self.owner, &"KILLSTREAKS_HINTS/HOVER_JET_GUARD", 1);

  self.useobj thread function_380d84b0fdfca800(self.owner, self);

  updaterate = level.framedurationseconds;
  activatetime = 0.25;
  self.useobj setuseholdduration(250);

  while(isDefined(self.useobj)) {
    timeused = 0;
    self.useobj waittill("trigger", player);

    if(player isusingremote()) {
      continue;
    }

    playkillstreakoperatordialog("hover_jet", "hover_jet" + "_confirm", 1);
    self setscriptablepartstate("thrusters", "active", 0);

    airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

    if(isDefined(airstrikedebugon) && airstrikedebugon) {
      player iprintlnbold("<dev string:x88>");
    }

    self.useobj thread function_d6e5bb5b2c900f89(1);

    if(isDefined(player)) {
      thread hoverjet_movetolocation(player.origin);
      thread hoverjet_watchfornearmovementgoal();
      player function_e05ade915e49f05f();
    }
  }
}

function hoverjet_watchfornearmovementgoal() {
  self endon("death");
  self endon("leaving");
  self waittill("near_goal");
  self setscriptablepartstate("thrusters", "idle", 0);
}

function hoverjet_randomizemovement() {
  self notify("random_movement");
  self endon("random_movement");
  self endon("stopRand");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
}

function function_58258fda8ee98d76(streakname) {
  killstreakvehicle = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  var_8dfc256103cce53e = &function_a7c9961508e4b099;
  var_191284e2e2837328 = &function_8987ef697fe06da3;
  premoddamagecallback = &function_3b2ccb79d72d0155;
  postmoddamagecallback = &function_acd17bdc96a89f80;
  deathcallback = &hoverjet_handledeathdamage;
  killstreak_setupvehicledamagefunctionality(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  function_cfc5e3633ef950fd(1, self.maxhealth * 0.75, &function_be82a8c78a16752b);
  function_cfc5e3633ef950fd(2, self.maxhealth * 0.5, &function_239dc7891d929c9c);
  function_cfc5e3633ef950fd(3, self.maxhealth * 0.25, &function_ba3a1232dbda15da);
}

function function_a7c9961508e4b099(streakname) {
  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 12);
  }
}

function function_8987ef697fe06da3(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 24;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 50;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 9;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 13;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }
}

function function_3b2ccb79d72d0155(data) {
  damage = data.damage;
  attacker = data.attacker;
  return true;
}

function function_acd17bdc96a89f80(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  self.currenthealth -= damage;
  killstreak_updatedamagestate(self.currenthealth);
  return true;
}

function function_be82a8c78a16752b() {
  self setscriptablepartstate("body_damage_light", "on");
}

function function_239dc7891d929c9c() {
  self setscriptablepartstate("body_damage_medium", "on");
}

function function_ba3a1232dbda15da() {
  self setscriptablepartstate("body_damage_heavy", "on");
}

function hoverjet_handledeathdamage(data) {
  self.killedbyweapon = data.objweapon;
  thread hoverjet_handledestroyed(data.attacker, data.objweapon);
  return true;
}

function hoverjet_handledestroyed(attacker, killedbyweapon) {
  level endon("game_ended");
  self endon("hover_jet_gone");
  var_1d4408c68f2118a = isDefined(attacker) && isPlayer(attacker) && istrue(attacker.isjuggernaut);
  shouldcrash = 1;

  if(issharedfuncdefined("killstreak", "isKillstreakWeapon")) {
    if([[getsharedfunc("killstreak", "isKillstreakWeapon")]](killedbyweapon) && !var_1d4408c68f2118a) {
      shouldcrash = 0;
    }
  }

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    self.owner setclientomnvar("ui_using_hover_jet", 0);
  }

  if(istrue(shouldcrash)) {
    hoverjet_crash(75);
  }

  thread hoverjet_explode();
}

function hoverjet_crash(speed) {
  self endon("explode");
  self.iscrashing = 1;
  self.killcament unlink();
  self.killcament.origin = self.origin + (0, 0, 100);
  self vehicle_turnengineoff();
  self clearlookatent();
  self notify("crashing");

  if(getgametype() == "wm" && level.mapname == "mp_jup_skydiving") {
    self playsoundonmovingent("ks_wm_hoverjet_crash");
  } else {
    self playsoundonmovingent("ks_hoverjet_crash");
  }

  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  var_6847739e80fb4e81 = hoverjet_findcrashposition(2500);

  if(!isDefined(var_6847739e80fb4e81)) {
    return;
  }

  playkillstreakoperatordialog("hover_jet", "hover_jet" + "_crash", 1);
  self setvehgoalpos(var_6847739e80fb4e81, 0);
  thread function_a12df0241d8eea2(var_6847739e80fb4e81);
  thread hoverjet_spinout(speed);
  self.owner function_b6018909193826e4();
  waittill_any_timeout_2(5, "collision", "near_goal");
}

function function_a12df0241d8eea2(var_6847739e80fb4e81) {
  self endon("death");
  var_9f9c84729373f7db = length(self.origin - var_6847739e80fb4e81);
  var_501dfe1465156b4c = var_9f9c84729373f7db * 0.5;
  var_153bdb19c511cb34 = var_501dfe1465156b4c * var_501dfe1465156b4c;

  while(true) {
    if(distancesquared(self.origin, var_6847739e80fb4e81) <= var_153bdb19c511cb34) {
      break;
    }

    waitframe();
  }

  self setscriptablepartstate("explode_cockpit", "on", 0);
}

function hoverjet_spinout(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.5);
    wait 0.5;
  }
}

function hoverjet_findcrashposition(crashdist) {
  crashstart = self.origin;
  crashoffset = 1000;
  crashpos = undefined;
  jetforward = anglesToForward(self.angles);
  jetright = anglestoright(self.angles);
  crashend = crashstart + jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward + jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetright - jetforward) - (0, 0, crashoffset);
  crashtrace = ray_trace(crashstart, crashend, self);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (-1 * jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  return crashpos;
}

function hoverjet_explode() {
  if(istrue(self.isexploding)) {
    return;
  }

  self notify("explode");
  self.isexploding = 1;
  function_5a9772411551e56e("hover_jet");
  self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "hover_jet_turret_ballistics_mp");
  self setscriptablepartstate("explode", "on", 0);
  wait 0.35;
  thread hoverjet_cleanup(1);
}

function hoverjet_leave() {
  self endon("death");

  if(isDefined(level.var_f56a88761038798b)) {
    thread[[level.var_f56a88761038798b]](self.streakinfo);
  }

  self.isleaving = 1;
  self notify("leaving");

  if(scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    self.owner setclientomnvar("ui_using_hover_jet", 0);
  }

  hoverjet_breakofftarget(undefined, 1);
  var_df6c75d1a1e4ff18 = 3;
  flightheightoffset = (0, 0, 1000);
  var_bb0e78a73b33d580 = self.origin + flightheightoffset;
  leavestart = undefined;
  leavegoal = undefined;
  var_ec0c66c48e6f8304 = undefined;

  while(var_df6c75d1a1e4ff18 > 0) {
    flightpath = function_999fe3838d6b6f8c(var_bb0e78a73b33d580, self.angles, 350, 24000);

    if(isDefined(flightpath.end)) {
      leavestart = flightpath.start;
      leavegoal = flightpath.end;
      var_ec0c66c48e6f8304 = flightpath.angles;
      break;
    }

    var_bb0e78a73b33d580 += (0, 0, 1000);
    var_df6c75d1a1e4ff18--;
    wait 0.05;
  }

  if(!isDefined(leavegoal)) {
    thread hoverjet_explode();
    return;
  }

  turnspeed = 150;
  ascendspeed = 35;
  self setyawspeed(turnspeed, 50, 25, 0);
  self settargetyaw(var_ec0c66c48e6f8304[1]);
  self vehicle_setspeed(ascendspeed, 25);
  pathgoal = leavestart;
  self setvehgoalpos(pathgoal, 1);
  self vehicleplayanim(level.scr_anim["hover_jet"]["exit"]);

  if(getgametype() == "wm" && level.mapname == "mp_jup_skydiving") {
    self playsoundonmovingent("ks_wm_hoverjet_leave");
  } else {
    self playsoundonmovingent("ks_hoverjet_leave");
  }

  self setscriptablepartstate("thrusters", "active", 0);
  waittill_any_timeout_1(3, "goal");
  failsafetime = 0;

  while(failsafetime < 2) {
    currentyaw = (0, self.angles[1], 0);
    yawdiff = var_ec0c66c48e6f8304 - currentyaw;

    if(abs(yawdiff[1]) < 5) {
      break;
    }

    failsafetime += level.framedurationseconds;
    waitframe();
  }

  self vehicle_turnengineoff();
  self setscriptablepartstate("contrails", "on", 0);
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(leavegoal, 1);
  self setneargoalnotifydist(1000);
  self.owner function_b6018909193826e4();
  waittill_any_timeout_1(10, "near_goal");
  self notify("hover_jet_gone");
  thread hoverjet_cleanup(0);
}

function hoverjet_cleanup(wasdestroyed) {
  if(istrue(self.var_bf178f6894d17b96)) {
    return;
  }

  self.var_bf178f6894d17b96 = 1;

  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self.turret.groundtargetent)) {
    self.turret.groundtargetent delete();
  }

  if(isDefined(self.scenenode)) {
    self.scenenode delete();
  }

  self setscriptablepartstate("blinking_lights", "off", 0);
  self setscriptablepartstate("thrusters", "off", 0);
  self.streakinfo.expiredbydeath = istrue(wasdestroyed);

  if(!istrue(self.recordedgameendstats)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  level.hoverjets = array_remove(level.hoverjets, self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function hoverjet_watchtargetstatus(target) {
  targetentnum = target getentitynumber();
  self endon("hoverJet_breakOffTarget " + targetentnum);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");

  if(isPlayer(target)) {
    thread hoverjet_watchgroundtargetdeathdisconnect(target);
  } else {
    thread hoverjet_watchairtargetdeath(target);
  }

  thread hoverjet_watchforbreakaction(target, "hoverJet_targetLost " + targetentnum);
  thread hoverjet_watchforbreakaction(target, "hoverJet_targetNotInView " + targetentnum);
  thread hoverjet_watchforbreakaction(target, "hoverJet_moveToNewlocation");
  thread hoverjet_watchforbreakaction(target, "hoverJet_targetTimeout");
}

function hoverjet_watchgroundtargetdeathdisconnect(groundtarget) {
  targetentnum = groundtarget getentitynumber();
  self endon("hoverJet_breakOffTarget " + targetentnum);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  groundtarget waittill("death_or_disconnect");
  self notify("hoverJet_targetLost " + targetentnum);
}

function hoverjet_watchairtargetdeath(airtarget) {
  targetentnum = airtarget getentitynumber();
  self endon("hoverJet_breakOffTarget " + targetentnum);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  airtarget waittill("death");
  self notify("hoverJet_targetLost " + targetentnum);
}

function hoverjet_watchforbreakaction(target, action) {
  targetentnum = target getentitynumber();
  self endon("hoverJet_breakOffTarget " + targetentnum);
  self endon("hoverJet_breakOffAllTargets");
  self endon("death");
  self endon("leaving");
  self waittill(action);
  hoverjet_breakofftarget(targetentnum);
}

function hoverjet_watchtargetlos(target, tolerance, vehicletarget) {
  targetentnum = target getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + targetentnum);
  self endon("hoverJet_breakOffAllTargets");
  self.bestgroundtarget endon("death_or_disconnect");
  losttime = undefined;

  if(!isDefined(tolerance)) {
    tolerance = 500;
  }

  contentsoverride = create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  ignorelist = [self.turret];

  if(isDefined(vehicletarget)) {
    ignorelist[ignorelist.size] = vehicletarget;
    linkedmodels = vehicletarget getlinkedchildren();

    if(isDefined(linkedmodels) && linkedmodels.size > 0) {
      ignorelist = array_combine(ignorelist, linkedmodels);
    }
  }

  while(true) {
    canseetarget = ray_trace_passed(self.turret gettagorigin("tag_barrel"), target gettagorigin("j_head"), ignorelist, contentsoverride);

    if(!istrue(canseetarget)) {
      if(!isDefined(losttime)) {
        losttime = gettime();
      }

      if(gettime() - losttime > tolerance) {
        self notify("hoverJet_targetNotInView " + targetentnum);
        return;
      }
    } else {
      var_4dbe11d3bda81e4a = getdvarint(@ "hash_48714771f0d0b941", 0);

      if(var_4dbe11d3bda81e4a) {
        line(self.turret gettagorigin("<dev string:xaa>"), target.origin, (1, 0, 0), 1, 0, 5);
      }

      losttime = undefined;
    }

    wait 0.25;
  }
}

function hoverjet_watchtargettimeout(target) {
  targetentnum = target getentitynumber();
  self endon("death");
  self endon("leaving");
  self endon("hoverJet_breakOffTarget " + targetentnum);
  self endon("hoverJet_breakOffAllTargets");
  self.bestgroundtarget endon("death_or_disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self notify("hoverJet_targetTimeout");
}

function hoverjet_breakofftarget(targetentnum, breakoffalltargets) {
  breakmessage = undefined;

  if(!isDefined(targetentnum) || istrue(breakoffalltargets)) {
    self.bestgroundtarget = undefined;
    self.bestairtarget = undefined;
    self clearlookatent();
    self.turret cleartargetentity();
    self.turret.groundtargetent unlink();
    breakmessage = "Breaking off all targets";

    airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

    if(isDefined(airstrikedebugon) && airstrikedebugon) {
      self.owner iprintlnbold(breakmessage);
    }

    self notify("hoverJet_breakOffAllTargets");
    return;
  } else {
    if(isDefined(self.bestgroundtarget) && targetentnum == self.bestgroundtarget getentitynumber()) {
      if(isDefined(self.bestgroundtarget.name)) {
        breakmessage = "Breaking off ground target: " + self.bestgroundtarget.name;
      }

      self.bestgroundtarget = undefined;
      self.turret cleartargetentity();
      self.turret.groundtargetent unlink();
    } else if(isDefined(self.bestairtarget) && targetentnum == self.bestairtarget getentitynumber()) {
      if(isDefined(self.bestairtarget.model)) {
        breakmessage = "Breaking off air target: " + self.bestairtarget.model;
      }

      self.bestairtarget = undefined;
    } else {
      breakmessage = "Breaking off removed target: " + targetentnum;
    }

    if(!isDefined(self.bestgroundtarget) && !isDefined(self.bestairtarget)) {
      self clearlookatent();
    }
  }

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    self.owner iprintlnbold(breakmessage);
  }

  self notify("hoverJet_breakOffTarget " + targetentnum);
}

function hoverjet_getbestairtarget(targets) {
  self endon("death");
  self endon("leaving");
  besttarget = undefined;
  bestdistance = undefined;
  skipteamcheck = 0;

  foreach(targ in targets) {
    if(!isDefined(targ)) {
      continue;
    }

    var_4dbe11d3bda81e4a = getdvarint(@ "hash_de4ffc2e910521a1", 0);

    if(var_4dbe11d3bda81e4a) {
      skipteamcheck = 1;
    }

    if(!istrue(skipteamcheck)) {
      if(level.teambased && targ.team == self.team) {
        continue;
      }

      if(targ.owner == self.owner) {
        continue;
      }
    }

    curdist = distance2dsquared(targ.origin, self.origin);

    if(curdist >= 6250000) {
      continue;
    }

    if(!isDefined(bestdistance) || curdist < bestdistance) {
      besttarget = targ;
      bestdistance = curdist;
    }
  }

  return besttarget;
}

function function_9f6c5e46080e47dc() {
  var_c51de0af53e40876 = "airstrike_flyby_straight";

  var_dc24abeecce774ba = getdvarint(@ "hash_8ef299ce102da922", 3);

  switch (var_dc24abeecce774ba) {
    case 0:
    case 1:
      var_c51de0af53e40876 = "<dev string:xb8>";
      break;
    case 2:
      var_c51de0af53e40876 = "<dev string:xd0>";
      break;
    case 3:
      var_c51de0af53e40876 = "<dev string:xe8>";
      break;
  }

  return var_c51de0af53e40876;
}

function function_b5a9a3ea21b6ea62(data) {
  if(isDefined(self)) {
    hoverjet_handledeathdamage(data);
  }
}

function function_8b040f320bd1e206(data) {
  self endon("death");
  self notify("hoverJet_mini_emp_hit");
  self endon("hoverJet_mini_emp_hit");
  hoverjet_breakofftarget(undefined, 1);
  self.var_d7b89e030dda87bf = 1;

  if(!isDefined(self.var_e8d88b601e41fba5) && self.flaresreservecount > 0) {
    self.var_e8d88b601e41fba5 = gettime();

    if(issharedfuncdefined("flares", "reduceReserves")) {
      [[getsharedfunc("flares", "reduceReserves")]](self);
    }

    if(issharedfuncdefined("flares", "playFx")) {
      self thread[[getsharedfunc("flares", "playFx")]]("jet_flares");
    }

    newtarget = undefined;

    if(issharedfuncdefined("flares", "deploy")) {
      newtarget = self[[getsharedfunc("flares", "deploy")]]();
    }
  } else if(self.flaresreservecount > 0 && self.var_e8d88b601e41fba5 <= gettime() - 10000) {
    if(issharedfuncdefined("flares", "reduceReserves")) {
      [[getsharedfunc("flares", "reduceReserves")]](self);
    }

    if(issharedfuncdefined("flares", "playFx")) {
      self thread[[getsharedfunc("flares", "playFx")]]("jet_flares");
    }

    newtarget = undefined;

    if(issharedfuncdefined("flares", "deploy")) {
      newtarget = self[[getsharedfunc("flares", "deploy")]]();
    }
  }

  if(!isDefined(self.var_40717aa8f16967e3)) {
    self.var_40717aa8f16967e3 = gettime();

    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("emped_killstreak");
    }
  }

  if(self.var_40717aa8f16967e3 < gettime() - 4750) {
    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("emped_killstreak");
    }

    self.var_40717aa8f16967e3 = gettime();
  }

  wait 5;
  self.var_d7b89e030dda87bf = undefined;
}

function function_950a05f71804f5() {
  self endon("<dev string:x104>");

  while(true) {
    sphere(self.origin, 50, (1, 0, 0), 0, 1);
    wait 0.05;
  }
}

function function_9480f8b8d48d0f59(owner) {
  self endon("<dev string:x104>");
  self endon("<dev string:x10d>");

  while(true) {
    if(getdvarint(@ "hash_920f0586653a26d4") == 0) {
      waitframe();
      continue;
    }

    if(!isDefined(self.bestgroundtarget)) {
      bestgroundtarget = "<dev string:x118>";
    } else {
      bestgroundtarget = self.bestgroundtarget.name;
    }

    if(!isDefined(self.bestairtarget)) {
      bestairtarget = "<dev string:x118>";
    } else {
      bestairtarget = self.bestairtarget.model;
    }

    anglesforward = anglesToForward(owner.angles);
    scalar = (anglesforward[0] * 300, anglesforward[1] * 300, anglesforward[2]);
    print3d(level.players[0].origin + scalar, "<dev string:x123>" + bestairtarget, (1, 1, 0));
    print3d(level.players[0].origin + scalar - (0, 0, 20), "<dev string:x138>" + bestgroundtarget, (1, 1, 0));
    waitframe();
  }
}

function function_380d84b0fdfca800(owner, jet) {
  self endon("<dev string:x104>");
  jet endon("<dev string:x104>");
  jet endon("<dev string:x10d>");
  self.debugcolor = (1, 1, 1);

  while(true) {
    if(getdvarint(@ "hash_125a1951df8627f5", 0) == 0) {
      waitframe();
      continue;
    }

    ownereyepos = owner getEye();
    anglesforward = anglesToForward(owner getplayerangles());
    scalar = (anglesforward[0] * 300, anglesforward[1] * 300, anglesforward[2]);
    print3d(owner.origin + scalar, "<dev string:x150>" + distance(self.origin, ownereyepos), self.debugcolor);
    sphere(self.origin, 50, self.debugcolor, 0, 1);
    line(self.origin, ownereyepos + anglesforward * 300, self.debugcolor, 1, 0, 1);
    waitframe();
  }
}

function function_d6e5bb5b2c900f89(time) {
  self endon("<dev string:x104>");
  self endon("<dev string:x10d>");

  if(getdvarint(@ "hash_125a1951df8627f5", 0) == 0) {
    return;
  }

  self.debugcolor = (1, 0, 0);
  wait time;
  self.debugcolor = (1, 1, 1);
}

function function_3f69aefa7b90fb4a() {
  if(!isDefined(self) || !isDefined(self.owner)) {
    return;
  }

  self endon("<dev string:x104>");
  self endon("<dev string:x15e>");
  self.owner endon("<dev string:x16a>");
  level endon("<dev string:x178>");
  self.owner notifyonplayercommand("<dev string:x186>", "<dev string:x198>");
  self.owner notifyonplayercommand("<dev string:x186>", "<dev string:x1a6>");
  bombweaponname = "<dev string:x1b3>";
  bomblifetime = 10;
  sideoffset = 100;

  while(true) {
    airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

    if(!istrue(airstrikedebugon)) {
      waitframe();
      continue;
    }

    self.owner waittill("<dev string:x186>");
    function_2b7c965fb8b07829(self.origin - (0, 0, 10000), sideoffset);
    sideoffset *= -1;
  }
}

# /