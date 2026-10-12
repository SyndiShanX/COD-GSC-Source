/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\remoteuav.gsc
************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\damage;
#using scripts\mp\gamescore;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace remoteuav;

function init() {
  level.remoteuav_fx["explode"] = loadfx("vfx/core/expl/bouncing_betty_explosion");
  level.remoteuav_fx["missile_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_explosion");
  level.remoteuav_dialog["launch"][0] = "ac130_plt_yeahcleared";
  level.remoteuav_dialog["launch"][1] = "ac130_plt_rollinin";
  level.remoteuav_dialog["launch"][2] = "ac130_plt_scanrange";
  level.remoteuav_dialog["out_of_range"][0] = "ac130_plt_cleanup";
  level.remoteuav_dialog["out_of_range"][1] = "ac130_plt_targetreset";
  level.remoteuav_dialog["track"][0] = "ac130_fco_moreenemy";
  level.remoteuav_dialog["track"][1] = "ac130_fco_getthatguy";
  level.remoteuav_dialog["track"][2] = "ac130_fco_guymovin";
  level.remoteuav_dialog["track"][3] = "ac130_fco_getperson";
  level.remoteuav_dialog["track"][4] = "ac130_fco_guyrunnin";
  level.remoteuav_dialog["track"][5] = "ac130_fco_gotarunner";
  level.remoteuav_dialog["track"][6] = "ac130_fco_backonthose";
  level.remoteuav_dialog["track"][7] = "ac130_fco_gonnagethim";
  level.remoteuav_dialog["track"][8] = "ac130_fco_personnelthere";
  level.remoteuav_dialog["track"][9] = "ac130_fco_rightthere";
  level.remoteuav_dialog["track"][10] = "ac130_fco_tracking";
  level.remoteuav_dialog["tag"][0] = "ac130_fco_nice";
  level.remoteuav_dialog["tag"][1] = "ac130_fco_yougothim";
  level.remoteuav_dialog["tag"][2] = "ac130_fco_yougothim2";
  level.remoteuav_dialog["tag"][3] = "ac130_fco_okyougothim";
  level.remoteuav_dialog["assist"][0] = "ac130_fco_goodkill";
  level.remoteuav_dialog["assist"][1] = "ac130_fco_thatsahit";
  level.remoteuav_dialog["assist"][2] = "ac130_fco_directhit";
  level.remoteuav_dialog["assist"][3] = "ac130_fco_rightontarget";
  level.remoteuav_lastdialogtime = 0;
  level.remoteuav_nodeployzones = getEntArray("no_vehicles", "targetname");
  assertmsg("<dev string:x1c>");
  level.remote_uav = [];

  setdevdvarifuninitialized(@ "hash_da7c6c2551fb9f41", 60);
}

function useremoteuav(lifeid, streakname) {
  return tryuseremoteuav(lifeid, "remote_uav");
}

function exceededmaxremoteuavs(team) {
  if(getgametype() == "dm") {
    if(isDefined(level.remote_uav[team]) || isDefined(level.remote_uav[getotherteam(team)[0]])) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  if(isDefined(level.remote_uav[team])) {
    return 1;
  }

  return 0;
}

function tryuseremoteuav(lifeid, streakname) {
  val::set("remote_uav", "usability", 0);

  if(isusingremote() || self isusingturret() || isDefined(level.nukeinfo.incoming)) {
    val::reset_all("remote_uav");
    return 0;
  }

  var_4440147083abaf0a = 1;

  if(exceededmaxremoteuavs(self.team) || level.littlebirds.size >= 4) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    val::reset_all("remote_uav");
    return 0;
  } else if(currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount + var_4440147083abaf0a >= maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    val::reset_all("remote_uav");
    return 0;
  }

  self setplayerdata("reconDroneState", "staticAlpha", 0);
  self setplayerdata("reconDroneState", "incomingMissile", 0);
  incrementfauxvehiclecount();
  result = givecarryremoteuav(lifeid, streakname);

  if(result) {
    utility::trycall(level.matchdata_logkillstreakevent, streakname, self.origin);
    thread teamplayercardsplash("used_remote_uav", self);
  } else {
    decrementfauxvehiclecount();
  }

  self.iscarrying = 0;
  return result;
}

function givecarryremoteuav(lifeid, streakname) {
  carryremoteuav = createcarryremoteuav(streakname, self);
  _takeweapon("killstreak_uav_mp");
  _giveweapon("killstreak_remote_uav_mp");
  _switchtoweaponimmediate("killstreak_remote_uav_mp");
  setcarryingremoteuav(carryremoteuav);

  if(isalive(self) && isDefined(carryremoteuav)) {
    origin = carryremoteuav.origin;
    angles = self.angles;
    carryremoteuav.soundent delete();
    carryremoteuav delete();
    result = startremoteuav(lifeid, streakname, origin, angles);
  } else {
    result = 0;

    if(isalive(self)) {
      _takeweapon("killstreak_remote_uav_mp");
      _giveweapon("killstreak_uav_mp");
    }
  }

  return result;
}

function createcarryremoteuav(streakname, owner) {
  pos = owner.origin + anglesToForward(owner.angles) * 4 + anglestoup(owner.angles) * 50;
  carryremoteuav = spawnturret("misc_turret", pos, "sentry_minigun_mp");
  carryremoteuav.origin = pos;
  carryremoteuav.angles = owner.angles;
  carryremoteuav.sentrytype = "sentry_minigun";
  carryremoteuav.canbeplaced = 1;
  carryremoteuav setturretmodechangewait(1);
  carryremoteuav setmode("sentry_offline");
  carryremoteuav makeunusable();
  carryremoteuav maketurretinoperable();
  carryremoteuav.owner = owner;
  carryremoteuav setsentryowner(carryremoteuav.owner);
  carryremoteuav.scale = 3;
  carryremoteuav.inheliproximity = 0;
  carryremoteuav thread carryremoteuav_handleexistence();
  carryremoteuav.rangetrigger = getEnt("remote_uav_range", "targetname");

  if(!isDefined(carryremoteuav.rangetrigger)) {
    heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    carryremoteuav.maxheight = heightent.origin[2];
    carryremoteuav.maxdistance = 3600;
  }

  carryremoteuav.soundent = spawn("script_origin", carryremoteuav.origin);
  carryremoteuav.soundent.angles = carryremoteuav.angles;
  carryremoteuav.soundent.origin = carryremoteuav.origin;
  carryremoteuav.soundent linkTo(carryremoteuav);
  carryremoteuav.soundent playLoopSound("recondrone_idle_high");
  return carryremoteuav;
}

function setcarryingremoteuav(carryremoteuav) {
  carryremoteuav thread carryremoteuav_setcarried(self);
  self notifyonplayercommand("place_carryRemoteUAV", "+attack");
  self notifyonplayercommand("place_carryRemoteUAV", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 4");

  if(!self isconsoleplayer()) {
    self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 5");
    self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 6");
    self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 7");
  }

  for(;;) {
    result = local_waittill_any_return_6("place_carryRemoteUAV", "cancel_carryRemoteUAV", "weapon_switch_started", "force_cancel_placement", "death_or_disconnect");
    self forceusehintoff();

    if(result != "place_carryRemoteUAV") {
      carryremoteuav_delete(carryremoteuav);
      break;
    }

    if(!carryremoteuav.canbeplaced) {
      if(self.team != "spectator") {
        self forceusehinton(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
      }

      continue;
    }

    if(exceededmaxremoteuavs(self.team) || currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount >= maxvehiclesallowed()) {
      self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
      carryremoteuav_delete(carryremoteuav);
      break;
    }

    self.iscarrying = 0;
    carryremoteuav.carriedby = undefined;
    carryremoteuav playSound("sentry_gun_plant");
    carryremoteuav notify("placed");
    break;
  }
}

function local_waittill_any_return_6(string1, string2, string3, string4, string5, string6) {
  if((!isDefined(string1) || string1 != "death") && (!isDefined(string2) || string2 != "death") && (!isDefined(string3) || string3 != "death") && (!isDefined(string4) || string4 != "death") && (!isDefined(string5) || string5 != "death")) {
    self endon("death");
  }

  ent = spawnStruct();

  if(isDefined(string1)) {
    thread waittill_string(string1, ent);
  }

  if(isDefined(string2)) {
    thread waittill_string(string2, ent);
  }

  if(isDefined(string3)) {
    thread waittill_string(string3, ent);
  }

  if(isDefined(string4)) {
    thread waittill_string(string4, ent);
  }

  if(isDefined(string5)) {
    thread waittill_string(string5, ent);
  }

  if(isDefined(string6)) {
    thread waittill_string(string6, ent);
  }

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

function carryremoteuav_setcarried(carrier) {
  self setCanDamage(0);
  self setsentrycarrier(carrier);
  self notsolid();
  self.carriedby = carrier;
  carrier.iscarrying = 1;
  carrier thread updatecarryremoteuavplacement(self);
  self notify("carried");
}

function carryremoteuav_delete(carryremoteuav) {
  self.iscarrying = 0;

  if(isDefined(carryremoteuav)) {
    if(isDefined(carryremoteuav.soundent)) {
      carryremoteuav.soundent delete();
    }

    carryremoteuav delete();
  }
}

function isinremotenodeploy() {
  if(isDefined(level.remoteuav_nodeployzones) && level.remoteuav_nodeployzones.size) {
    foreach(zone in level.remoteuav_nodeployzones) {
      if(self istouching(zone)) {
        return true;
      }
    }
  }

  return false;
}

function updatecarryremoteuavplacement(carryremoteuav) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  carryremoteuav endon("placed");
  carryremoteuav endon("death");
  carryremoteuav.canbeplaced = 1;
  var_b89a549815ee28d3 = -1;
  val::reset_all("remote_uav");

  for(;;) {
    heightoffset = 18;

    switch (self getstance()) {
      case #"hash_c6775c88e38f7803":
        heightoffset = 40;
        break;
      case #"hash_3fed0cbd303639eb":
        heightoffset = 25;
        break;
      case #"hash_d91940431ed7c605":
        heightoffset = 10;
        break;
    }

    placement = self canplayerplacetank(22, 22, 50, heightoffset, 0, 0);
    carryremoteuav.origin = placement["origin"] + anglestoup(self.angles) * (18 - -9);
    carryremoteuav.angles = placement["angles"];
    carryremoteuav.canbeplaced = self isonground() && placement["result"] && carryremoteuav remoteuav_in_range() && !carryremoteuav isinremotenodeploy();

    if(carryremoteuav.canbeplaced != var_b89a549815ee28d3) {
      if(carryremoteuav.canbeplaced) {
        if(self.team != "spectator") {
          self forceusehinton(&"KILLSTREAKS_REMOTE_UAV_PLACE");
        }

        if(self attackButtonPressed()) {
          self notify("place_carryRemoteUAV");
        }
      } else if(self.team != "spectator") {
        self forceusehinton(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
      }
    }

    var_b89a549815ee28d3 = carryremoteuav.canbeplaced;
    waitframe();
  }
}

function carryremoteuav_handleexistence() {
  level endon("game_ended");
  self.owner endon("place_carryRemoteUAV");
  self.owner endon("cancel_carryRemoteUAV");
  self.owner waittill_any_3("death_or_disconnect", "joined_team", "joined_spectators");

  if(isDefined(self)) {
    if(isDefined(self.soundent)) {
      self.soundent delete();
    }

    self delete();
  }
}

function removeremoteweapon() {
  level endon("game_ended");
  self endon("disconnect");
  wait 0.7;
}

function startremoteuav(lifeid, streakname, origin, angles) {
  lockplayerforremoteuavlaunch();
  setusingremote(streakname);
  _giveweapon("uav_remote_mp");
  _switchtoweaponimmediate("uav_remote_mp");
  self visionsetnakedforplayer("black_bw", 0);
  result = scripts\mp\killstreaks\killstreaks::initridekillstreak("remote_uav");

  if(result != "success") {
    if(result != "disconnect") {
      self notify("remoteuav_unlock");
      _takeweapon("uav_remote_mp");
      clearusingremote();
    }

    val::reset_all("ride_killstreak");
    return 0;
  }

  if(exceededmaxremoteuavs(self.team) || currentactivevehiclecount() >= maxvehiclesallowed() || level.fauxvehiclecount >= maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    self notify("remoteuav_unlock");
    _takeweapon("uav_remote_mp");
    clearusingremote();
    return 0;
  }

  self notify("remoteuav_unlock");
  remoteuav = createremoteuav(lifeid, self, streakname, origin, angles);

  if(isDefined(remoteuav)) {
    thread remoteuav_ride(lifeid, remoteuav, streakname);
    return 1;
  }

  self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
  _takeweapon("uav_remote_mp");
  clearusingremote();
  return 0;
}

function lockplayerforremoteuavlaunch() {
  lockspot = spawn("script_origin", self.origin);
  lockspot hide();
  self playerlinkTo(lockspot);
  thread clearplayerlockfromremoteuavlaunch(lockspot);
}

function clearplayerlockfromremoteuavlaunch(lockspot) {
  level endon("game_ended");
  msg = waittill_any_return_2("death_or_disconnect", "remoteuav_unlock");

  if(msg != "disconnect") {
    self unlink();
  }

  lockspot delete();
}

function createremoteuav(lifeid, owner, streakname, origin, angles) {
  if(owner isconsoleplayer()) {
    remoteuav = spawnhelicopter(owner, origin, angles, "remote_uav_mp", "vehicle_remote_uav");
  } else {
    remoteuav = spawnhelicopter(owner, origin, angles, "remote_uav_mp_pc", "vehicle_remote_uav");
  }

  if(!isDefined(remoteuav)) {
    return undefined;
  }

  assertmsg("<dev string:x7b>");
  remoteuav makevehiclesolidcapsule(18, -9, 18);
  remoteuav.lifeid = lifeid;
  remoteuav.team = owner.team;
  remoteuav.pers["team"] = owner.team;
  remoteuav.owner = owner;
  remoteuav setotherent(owner);
  remoteuav scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
  remoteuav.maxhealth = 250;
  remoteuav.scrambler = spawn("script_model", origin);
  remoteuav.scrambler linkTo(remoteuav, "tag_origin", (0, 0, -160), (0, 0, 0));
  remoteuav.scrambler makescrambler(owner);
  remoteuav.smoking = 0;
  remoteuav.inheliproximity = 0;
  remoteuav.helitype = "remote_uav";
  remoteuav.markedplayers = [];
  remoteuav thread remoteuav_light_fx();
  remoteuav thread remoteuav_explode_on_disconnect();
  remoteuav thread remoteuav_explode_on_changeteams();
  remoteuav thread remoteuav_explode_on_death();
  remoteuav thread remoteuav_clear_marked_on_gameended();
  remoteuav thread remoteuav_leave_on_timeout();
  remoteuav thread remoteuav_watch_distance();
  remoteuav thread remoteuav_watchheliproximity();
  remoteuav thread remoteuav_handledamage();
  remoteuav.numflares = 2;
  remoteuav.hasincoming = 0;
  remoteuav.incomingmissiles = [];
  remoteuav thread remoteuav_clearincomingwarning();
  remoteuav thread remoteuav_handleincomingstinger();
  remoteuav thread remoteuav_handleincomingsam();
  level.remote_uav[remoteuav.team] = remoteuav;
  return remoteuav;
}

function remoteuav_ride(lifeid, remoteuav, streakname) {
  remoteuav.playerlinked = 1;
  self.restoreangles = self.angles;

  if(getdvarint(@ "camera_thirdperson")) {
    setthirdpersondof(0);
  }

  self cameralinkTo(remoteuav, "tag_origin");
  self remotecontrolvehicle(remoteuav);
  thread remoteuav_playerexit(remoteuav);
  thread remoteuav_track(remoteuav);
  thread remoteuav_fire(remoteuav);
  self.remote_uav_ridelifeid = lifeid;
  self.remoteuav = remoteuav;
  thread remoteuav_delaylaunchdialog(remoteuav);
  self visionsetnakedforplayer("black_bw", 0);
  restorebasevisionset(1);
}

function remoteuav_delaylaunchdialog(remoteuav) {
  level endon("game_ended");
  self endon("disconnect");
  remoteuav endon("death");
  remoteuav endon("end_remote");
  remoteuav endon("end_launch_dialog");
  wait 3;
  remoteuav_dialog("launch");
}

function remoteuav_endride(remoteuav) {
  if(isDefined(remoteuav)) {
    remoteuav.playerlinked = 0;
    remoteuav notify("end_remote");
    clearusingremote();

    if(getdvarint(@ "camera_thirdperson")) {
      setthirdpersondof(1);
    }

    self cameraunlink(remoteuav);
    self remotecontrolvehicleoff(remoteuav);
    self thermalvisionoff();
    self setplayerangles(self.restoreangles);
    objlastweapon = getlastweapon();

    if(!self hasweapon(objlastweapon)) {
      objlastweapon = getfirstprimaryweapon();
    }

    _switchtoweapon(objlastweapon);
    _takeweapon("uav_remote_mp");
    thread remoteuav_freezebuffer();
  }

  self.remoteuav = undefined;
}

function remoteuav_freezebuffer() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _freezecontrols(1, undefined, "remoteuav");
  wait 0.5;
  _freezecontrols(0, undefined, "remoteuav");
}

function remoteuav_playerexit(remoteuav) {
  level endon("game_ended");
  self endon("disconnect");
  remoteuav endon("death");
  remoteuav endon("end_remote");
  wait 2;
  updaterate = level.framedurationseconds;

  while(true) {
    timeused = 0;

    while(self useButtonPressed()) {
      timeused += updaterate;

      if(timeused > 0.75) {
        remoteuav thread remoteuav_leave();
        return;
      }

      wait updaterate;
    }

    waitframe();
  }
}

function remoteuav_track(remoteuav) {
  level endon("game_ended");
  self endon("disconnect");
  remoteuav endon("death");
  remoteuav endon("end_remote");
  remoteuav.lasttrackingdialogtime = 0;
  self.lockedtarget = undefined;
  self weaponlockfree();
  wait 1;

  while(true) {
    pos = remoteuav gettagorigin("tag_turret");
    forward = anglesToForward(self getplayerangles());
    endpos = pos + forward * 1024;
    trace = scripts\engine\trace::_bullet_trace(pos, endpos, 1, remoteuav);

    if(isDefined(trace["position"])) {
      targetpos = trace["position"];
    } else {
      targetpos = endpos;
      trace["endpos"] = endpos;
    }

    remoteuav.trace = trace;
    lockedplayer = remoteuav_trackentities(remoteuav, level.players, targetpos);
    lockedturret = remoteuav_trackentities(remoteuav, level.turrets, targetpos);
    lockeduav = undefined;

    if(level.teambased) {
      entitylist = [];
      enemyteams = getenemyteams(self.team);

      foreach(entry in level.teamnamelist) {
        foreach(model in level.uavmodels[entry]) {
          entitylist[entitylist.size] = model;
        }
      }

      lockeduav = remoteuav_trackentities(remoteuav, entitylist, targetpos);
    } else {
      lockeduav = remoteuav_trackentities(remoteuav, level.uavmodels, targetpos);
    }

    lockedtarget = undefined;

    if(isDefined(lockedplayer)) {
      lockedtarget = lockedplayer;
    } else if(isDefined(lockedturret)) {
      lockedtarget = lockedturret;
    } else if(isDefined(lockeduav)) {
      lockedtarget = lockeduav;
    }

    if(isDefined(lockedtarget)) {
      if(!isDefined(self.lockedtarget) || isDefined(self.lockedtarget) && self.lockedtarget != lockedtarget) {
        self weaponlockfinalize(lockedtarget);
        self.lockedtarget = lockedtarget;

        if(isDefined(lockedplayer)) {
          remoteuav notify("end_launch_dialog");
          remoteuav_dialog("track");
        }
      }
    } else {
      self weaponlockfree();
      self.lockedtarget = undefined;
    }

    wait 0.05;
  }
}

function remoteuav_trackentities(remoteuav, entities, targetpos) {
  level endon("game_ended");
  lockedtarget = undefined;

  foreach(entity in entities) {
    if(level.teambased && (!isDefined(entity.team) || entity.team == self.team)) {
      continue;
    }

    if(isPlayer(entity)) {
      if(!isreallyalive(entity)) {
        continue;
      }

      if(entity == self) {
        continue;
      }

      id = entity.guid;
    } else {
      id = entity.birthtime;
    }

    if(isDefined(entity.sentrytype) || isDefined(entity.turrettype)) {
      offset = 32;
      var_ee22627fdcfe58bf = "hud_fofbox_hostile_vehicle";
    } else if(isDefined(entity.uavtype)) {
      offset = -52;
      var_ee22627fdcfe58bf = "hud_fofbox_hostile_vehicle";
    } else {
      offset = 26;
      var_ee22627fdcfe58bf = "veh_hud_target_unmarked";
    }

    if(isDefined(entity.uavremotemarkedby)) {
      if(!isDefined(remoteuav.markedplayers[id])) {
        remoteuav.markedplayers[id] = [];
        remoteuav.markedplayers[id]["player"] = entity;
        remoteuav.markedplayers[id]["icon"] = entity thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "veh_hud_target_marked", offset);
        remoteuav.markedplayers[id]["icon"].shader = "veh_hud_target_marked";

        if(!isDefined(entity.sentrytype) || !isDefined(entity.turrettype)) {
          remoteuav.markedplayers[id]["icon"] settargetEnt(entity);
        }
      } else if(isDefined(remoteuav.markedplayers[id]) && isDefined(remoteuav.markedplayers[id]["icon"]) && isDefined(remoteuav.markedplayers[id]["icon"].shader) && remoteuav.markedplayers[id]["icon"].shader != "veh_hud_target_marked") {
        remoteuav.markedplayers[id]["icon"].shader = "veh_hud_target_marked";
        remoteuav.markedplayers[id]["icon"] setshader("veh_hud_target_marked", 10, 10);
        remoteuav.markedplayers[id]["icon"] setwaypoint(0, 0, 0, 0);
      }

      continue;
    }

    if(isPlayer(entity)) {
      spawnprotected = isDefined(entity.spawntime) && (gettime() - entity.spawntime) / 1000 <= 5;
      var_63c3dab9425623f3 = entity _hasperk("specialty_blindeye");
      carried = 0;
      leaving = 0;
    } else {
      spawnprotected = 0;
      var_63c3dab9425623f3 = 0;
      carried = isDefined(entity.carriedby);
      leaving = isDefined(entity.isleaving) && entity.isleaving == 1;
    }

    if(!isDefined(remoteuav.markedplayers[id]) && !spawnprotected && !var_63c3dab9425623f3 && !carried && !leaving) {
      remoteuav.markedplayers[id] = [];
      remoteuav.markedplayers[id]["player"] = entity;
      remoteuav.markedplayers[id]["icon"] = entity scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, var_ee22627fdcfe58bf, offset);
      remoteuav.markedplayers[id]["icon"].shader = var_ee22627fdcfe58bf;

      if(!isDefined(entity.sentrytype) || !isDefined(entity.turrettype)) {
        remoteuav.markedplayers[id]["icon"] settargetEnt(entity);
      }
    }

    if((!isDefined(lockedtarget) || lockedtarget != entity) && isDefined(remoteuav.trace["entity"]) && remoteuav.trace["entity"] == entity && !carried && !leaving || distance(entity.origin, targetpos) < 200 * remoteuav.trace["fraction"] && !spawnprotected && !carried && !leaving || !leaving && remoteuav_cantargetuav(remoteuav, entity)) {
      trace = scripts\engine\trace::_bullet_trace(remoteuav.origin, entity.origin + (0, 0, 32), 1, remoteuav);

      if(isDefined(trace["entity"]) && trace["entity"] == entity || trace["fraction"] == 1) {
        self playlocalsound("recondrone_lockon");
        lockedtarget = entity;
      }
    }
  }

  return lockedtarget;
}

function remoteuav_cantargetuav(remoteuav, uav) {
  if(isDefined(uav.uavtype)) {
    forward = anglesToForward(self getplayerangles());
    touav = vectorNormalize(uav.origin - remoteuav gettagorigin("tag_turret"));
    dot = vectordot(forward, touav);

    if(dot > 0.985) {
      return true;
    }
  }

  return false;
}

function remoteuav_fire(remoteuav) {
  self endon("disconnect");
  remoteuav endon("death");
  level endon("game_ended");
  remoteuav endon("end_remote");
  wait 1;
  self notifyonplayercommand("remoteUAV_tag", "+attack");
  self notifyonplayercommand("remoteUAV_tag", "+attack_akimbo_accessible");

  while(true) {
    self waittill("remoteUAV_tag");

    if(isDefined(self.lockedtarget)) {
      self playlocalsound("recondrone_tag");
      updatedamagefeedback("");
      thread remoteuav_markplayer(self.lockedtarget);
      thread remoteuav_rumble(remoteuav, 3);
      wait 0.25;
      continue;
    }

    waitframe();
  }
}

function remoteuav_rumble(remoteuav, amount) {
  self endon("disconnect");
  remoteuav endon("death");
  level endon("game_ended");
  remoteuav endon("end_remote");
  remoteuav notify("end_rumble");
  remoteuav endon("end_rumble");

  for(i = 0; i < amount; i++) {
    self playRumbleOnEntity("damage_heavy");
    wait 0.05;
  }
}

function remoteuav_markplayer(targetplayer) {
  level endon("game_ended");
  targetplayer.uavremotemarkedby = self;

  if(isPlayer(targetplayer) && !targetplayer isusingremote()) {} else if(isDefined(targetplayer.uavtype)) {
    targetplayer.birth_time = targetplayer.birthtime;
  } else if(isDefined(targetplayer.owner) && isalive(targetplayer.owner)) {
    targetplayer.owner thread scripts\mp\rank::scoreeventpopup(#"hash_508e80998122a1a4");
  }

  remoteuav_dialog("tag");

  if(getgametype() != "dm") {
    if(isPlayer(targetplayer)) {
      thread doscoreevent(#"kill");
    }
  }

  if(isPlayer(targetplayer)) {
    targetplayer setperk("specialty_radarblip", 1);
  } else {
    if(isDefined(targetplayer.uavtype)) {
      shadername = "compassping_enemy_uav";
    } else {
      shadername = "compassping_sentry_enemy";
    }

    if(level.teambased) {
      curobjid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(curobjid != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(curobjid, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(curobjid, targetplayer);
        scripts\mp\objidpoolmanager::update_objective_state(curobjid, "active");
        scripts\mp\objidpoolmanager::objective_teammask_single(curobjid, self.team);
        scripts\mp\objidpoolmanager::update_objective_icon(curobjid, shadername);
        scripts\mp\objidpoolmanager::update_objective_setbackground(curobjid, 1);
      }

      targetplayer.remoteuavmarkedobjid01 = curobjid;
    } else {
      curobjid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(curobjid != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(curobjid, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(curobjid, targetplayer);
        scripts\mp\objidpoolmanager::update_objective_state(curobjid, "active");
        scripts\mp\objidpoolmanager::objective_teammask_single(curobjid, getotherteam(self.team)[0]);
        scripts\mp\objidpoolmanager::update_objective_icon(curobjid, shadername);
        scripts\mp\objidpoolmanager::update_objective_setbackground(curobjid, 1);
      }

      targetplayer.remoteuavmarkedobjid02 = curobjid;
      curobjid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(curobjid != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(curobjid, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(curobjid, targetplayer);
        scripts\mp\objidpoolmanager::update_objective_state(curobjid, "active");
        scripts\mp\objidpoolmanager::objective_teammask_single(curobjid, self.team);
        scripts\mp\objidpoolmanager::update_objective_icon(curobjid, shadername);
        scripts\mp\objidpoolmanager::update_objective_setbackground(curobjid, 1);
      }

      targetplayer.remoteuavmarkedobjid03 = curobjid;
    }
  }

  targetplayer thread remoteuav_unmarkremovedplayer(self.remoteuav);
}

function remoteuav_processtaggedassist(victim) {
  remoteuav_dialog("assist");

  if(getgametype() != "dm") {
    self.taggedassist = 1;

    if(isDefined(victim)) {
      thread scripts\mp\gamescore::processassist(victim);
      return;
    }

    thread doscoreevent(#"assist");
  }
}

function remoteuav_unmarkremovedplayer(remoteuav) {
  level endon("game_ended");
  msg = waittill_any_return_3("death_or_disconnect", "carried", "leaving");

  if(msg == "leaving" || !isDefined(self.uavtype)) {
    self.uavremotemarkedby = undefined;
  }

  if(isDefined(remoteuav)) {
    if(isPlayer(self)) {
      id = self.guid;
    } else if(isDefined(self.birthtime)) {
      id = self.birthtime;
    } else {
      id = self.birth_time;
    }

    if(msg == "carried" || msg == "leaving") {
      if(isDefined(remoteuav.markedplayers[id]["icon"])) {
        remoteuav.markedplayers[id]["icon"] destroy();
        remoteuav.markedplayers[id]["icon"] = undefined;
      }
    }

    if(isDefined(id) && isDefined(remoteuav.markedplayers[id])) {
      remoteuav.markedplayers[id] = undefined;
      remoteuav.markedplayers = array_removeundefined(remoteuav.markedplayers);
    }
  }

  if(isPlayer(self)) {
    self unsetperk("specialty_radarblip", 1);
    return;
  }

  if(isDefined(self.remoteuavmarkedobjid01)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.remoteuavmarkedobjid01);
  }

  if(isDefined(self.remoteuavmarkedobjid02)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.remoteuavmarkedobjid02);
  }

  if(isDefined(self.remoteuavmarkedobjid03)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.remoteuavmarkedobjid03);
  }
}

function remoteuav_clearmarkedforowner() {
  foreach(markedplayer in self.markedplayers) {
    if(isDefined(markedplayer["icon"])) {
      markedplayer["icon"] destroy();
      markedplayer["icon"] = undefined;
    }
  }

  self.markedplayers = undefined;
}

function remoteuav_operationrumble(remoteuav) {
  self endon("disconnect");
  remoteuav endon("death");
  level endon("game_ended");
  remoteuav endon("end_remote");

  while(true) {
    self playRumbleOnEntity("damage_light");
    wait 0.5;
  }
}

function remoteuav_watch_distance() {
  self endon("death");
  self.rangetrigger = getEnt("remote_uav_range", "targetname");

  if(!isDefined(self.rangetrigger)) {
    heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    self.maxheight = heightent.origin[2];
    self.maxdistance = 12800;
  }

  self.centerref = spawn("script_model", level.mapcenter);
  inrangepos = self.origin;
  self.rangecountdownactive = 0;

  while(true) {
    if(!remoteuav_in_range()) {
      staticalpha = 0;

      while(!remoteuav_in_range()) {
        self.owner remoteuav_dialog("out_of_range");

        if(!self.rangecountdownactive) {
          self.rangecountdownactive = 1;
          thread remoteuav_rangecountdown();
        }

        if(isDefined(self.heliinproximity)) {
          dist = distance(self.origin, self.heliinproximity.origin);
          staticalpha = 1 - (dist - 150) / 150;
        } else {
          dist = distance(self.origin, inrangepos);
          staticalpha = min(1, dist / 200);
        }

        self.owner setplayerdata("reconDroneState", "staticAlpha", staticalpha);
        wait 0.05;
      }

      self notify("in_range");
      self.rangecountdownactive = 0;
      thread remoteuav_staticfade(staticalpha);
    }

    inrangepos = self.origin;
    waitframe();
  }
}

function remoteuav_in_range() {
  if(isDefined(self.rangetrigger)) {
    if(!self istouching(self.rangetrigger) && !self.inheliproximity) {
      return true;
    }
  } else if(distance2d(self.origin, level.mapcenter) < self.maxdistance && self.origin[2] < self.maxheight && !self.inheliproximity) {
    return true;
  }

  return false;
}

function remoteuav_staticfade(staticalpha) {
  self endon("death");

  while(remoteuav_in_range()) {
    staticalpha -= 0.05;

    if(staticalpha < 0) {
      self.owner setplayerdata("reconDroneState", "staticAlpha", 0);
      break;
    }

    self.owner setplayerdata("reconDroneState", "staticAlpha", staticalpha);
    wait 0.05;
  }
}

function remoteuav_rangecountdown() {
  self endon("death");
  self endon("in_range");

  if(isDefined(self.heliinproximity)) {
    countdown = 3;
  } else {
    countdown = 6;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(countdown);
  self notify("death");
}

function remoteuav_explode_on_disconnect() {
  self endon("death");
  self.owner waittill("disconnect");
  self notify("death");
}

function remoteuav_explode_on_changeteams() {
  self endon("death");
  self.owner waittill_any_2("joined_team", "joined_spectators");
  self notify("death");
}

function remoteuav_clear_marked_on_gameended() {
  self endon("death");
  level waittill("game_ended");
  remoteuav_clearmarkedforowner();
}

function remoteuav_leave_on_timeout() {
  self endon("death");
  flytime = 60;

  flytime = getdvarint(@ "hash_da7c6c2551fb9f41", flytime);

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(flytime);
  thread remoteuav_leave();
}

function remoteuav_leave() {
  level endon("game_ended");
  self endon("death");
  self notify("leaving");
  self.owner remoteuav_endride(self);
  self notify("death");
}

function remoteuav_explode_on_death() {
  level endon("game_ended");
  self waittill("death");
  self playSound("recondrone_destroyed");
  playFX(level.remoteuav_fx["explode"], self.origin);
  remoteuav_cleanup();
}

function remoteuav_cleanup() {
  if(self.playerlinked == 1 && isDefined(self.owner)) {
    self.owner remoteuav_endride(self);
  }

  if(isDefined(self.scrambler)) {
    self.scrambler delete();
  }

  if(isDefined(self.centerref)) {
    self.centerref delete();
  }

  remoteuav_clearmarkedforowner();
  stopFXOnTag(level.remoteuav_fx["smoke"], self, "tag_origin");
  level.remote_uav[self.team] = undefined;
  decrementfauxvehiclecount();
  self delete();
}

function remoteuav_light_fx() {
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_nose");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
}

function remoteuav_dialog(dialoggroup) {
  if(dialoggroup == "tag") {
    waittime = 1000;
  } else {
    waittime = 5000;
  }

  if(gettime() - level.remoteuav_lastdialogtime < waittime) {
    return;
  }

  level.remoteuav_lastdialogtime = gettime();
  randomindex = randomint(level.remoteuav_dialog[dialoggroup].size);
  soundalias = level.remoteuav_dialog[dialoggroup][randomindex];
  fullsoundalias = getteamvoiceinfix(self.team) + "tl" + soundalias;
  self playlocalsound(fullsoundalias);
}

function remoteuav_handleincomingstinger() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  while(true) {
    level waittill("stinger_fired", player, missile, locktarget);

    if(!isDefined(missile) || !isDefined(locktarget) || locktarget != self) {
      continue;
    }

    self.owner playlocalsound("javelin_clu_lock");
    self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
    self.hasincoming = 1;
    self.incomingmissiles[self.incomingmissiles.size] = missile;
    missile.owner = player;
    missile thread watchstingerproximity(locktarget);
  }
}

function remoteuav_handleincomingsam() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  while(true) {
    level waittill("sam_fired", player, missilegroup, locktarget);

    if(!isDefined(locktarget) || locktarget != self) {
      continue;
    }

    var_5106e97c176bc70c = 0;

    foreach(missile in missilegroup) {
      if(isDefined(missile)) {
        self.incomingmissiles[self.incomingmissiles.size] = missile;
        missile.owner = player;
        var_5106e97c176bc70c++;
      }
    }

    if(var_5106e97c176bc70c) {
      self.owner playlocalsound("javelin_clu_lock");
      self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
      self.hasincoming = 1;
      level thread watchsamproximity(locktarget, missilegroup);
    }
  }
}

function watchstingerproximity(missiletarget) {
  level endon("game_ended");
  self endon("death");
  self missile_settargetEnt(missiletarget);
  lastvectotarget = vectorNormalize(missiletarget.origin - self.origin);

  while(isDefined(missiletarget)) {
    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(missiletarget.numflares > 0 && curdist < 4000) {
      newtarget = missiletarget deployflares();
      self missile_settargetEnt(newtarget);
      return;
    } else {
      curvectotarget = vectorNormalize(missiletarget.origin - self.origin);

      if(vectordot(curvectotarget, lastvectotarget) < 0) {
        self playSound("exp_stinger_armor_destroy");
        playFX(level.remoteuav_fx["missile_explode"], self.origin);

        if(isDefined(self.owner)) {
          radiusdamage(self.origin, 400, 1000, 1000, self.owner, "MOD_EXPLOSIVE", "stinger_mp");
        } else {
          radiusdamage(self.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");
        }

        self hide();
        wait 0.05;
        self delete();
      } else {
        lastvectotarget = curvectotarget;
      }
    }

    wait 0.05;
  }
}

function watchsamproximity(missiletarget, missilegroup) {
  level endon("game_ended");
  missiletarget endon("death");

  foreach(missile in missilegroup) {
    if(isDefined(missile)) {
      missile missile_settargetEnt(missiletarget);
      missile.lastvectotarget = vectorNormalize(missiletarget.origin - missile.origin);
    }
  }

  while(missilegroup.size && isDefined(missiletarget)) {
    center = missiletarget getpointinbounds(0, 0, 0);

    foreach(missile in missilegroup) {
      if(isDefined(missile)) {
        if(isDefined(self.markfordetete)) {
          self delete();
          continue;
        }

        if(missiletarget.numflares > 0) {
          disttotarget = distance(missile.origin, center);

          if(disttotarget < 4000) {
            newtarget = missiletarget deployflares();

            foreach(var_7ea79feb6d88b3e in missilegroup) {
              if(isDefined(var_7ea79feb6d88b3e)) {
                var_7ea79feb6d88b3e missile_settargetEnt(newtarget);
              }
            }

            return;
          }

          continue;
        }

        curvectotarget = vectorNormalize(missiletarget.origin - missile.origin);

        if(vectordot(curvectotarget, missile.lastvectotarget) < 0) {
          missile playSound("exp_stinger_armor_destroy");
          playFX(level.remoteuav_fx["missile_explode"], missile.origin);

          if(isDefined(missile.owner)) {
            radiusdamage(missile.origin, 400, 1000, 1000, missile.owner, "MOD_EXPLOSIVE", "stinger_mp");
          } else {
            radiusdamage(missile.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");
          }

          missile hide();
          missile.markfordetete = 1;
          continue;
        }

        missile.lastvectotarget = curvectotarget;
      }
    }

    missilegroup = array_removeundefined(missilegroup);
    wait 0.05;
  }
}

function deployflares() {
  self.numflares--;
  self.owner thread remoteuav_rumble(self, 6);
  self playSound("WEAP_SHOTGUNATTACH_FIRE_NPC");
  thread playflarefx();
  spawnpos = self.origin + (0, 0, -100);
  flareobject = spawn("script_origin", spawnpos);
  flareobject.angles = self.angles;
  flareobject movegravity((0, 0, -1), 5);
  flareobject thread deleteaftertime(5);
  return flareobject;
}

function playflarefx() {
  for(i = 0; i < 5; i++) {
    if(!isDefined(self)) {
      return;
    }

    playFXOnTag(level._effect["vehicle_flares"], self, "TAG_FLARE");
    wait 0.15;
  }
}

function deleteaftertime(delay) {
  wait delay;
  self delete();
}

function remoteuav_clearincomingwarning() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  while(true) {
    numincoming = 0;

    for(i = 0; i < self.incomingmissiles.size; i++) {
      if(isDefined(self.incomingmissiles[i]) && missile_isincoming(self.incomingmissiles[i], self)) {
        numincoming++;
      }
    }

    if(self.hasincoming && !numincoming) {
      self.hasincoming = 0;
      self.owner setplayerdata("reconDroneState", "incomingMissile", 0);
    }

    self.incomingmissiles = array_removeundefined(self.incomingmissiles);
    wait 0.05;
  }
}

function missile_isincoming(missile, remoteuav) {
  vectoremote = vectorNormalize(remoteuav.origin - missile.origin);
  var_d2fad66c97b5f8ba = anglesToForward(missile.angles);
  return vectordot(vectoremote, var_d2fad66c97b5f8ba) > 0;
}

function remoteuav_watchheliproximity() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  while(true) {
    inheliproximity = 0;

    foreach(heli in level.helis) {
      if(distance(heli.origin, self.origin) < 300) {
        inheliproximity = 1;
        self.heliinproximity = heli;
      }
    }

    foreach(littlebird in level.littlebirds) {
      if(littlebird != self && (!isDefined(littlebird.helitype) || littlebird.helitype != "remote_uav") && distance(littlebird.origin, self.origin) < 300) {
        inheliproximity = 1;
        self.heliinproximity = littlebird;
      }
    }

    if(!self.inheliproximity && inheliproximity) {
      self.inheliproximity = 1;
    } else if(self.inheliproximity && !inheliproximity) {
      self.inheliproximity = 0;
      self.heliinproximity = undefined;
    }

    waitframe();
  }
}

function remoteuav_handledamage() {
  self endon("end_remote");
  scripts\mp\damage::monitordamage(self.maxhealth, "remote_uav", &handledeathdamage, &modifydamage, 1);
}

function modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;
  modifieddamage = scripts\mp\damage::handleempdamage(objweapon, type, modifieddamage);
  modifieddamage = scripts\mp\damage::handlemissiledamage(objweapon, type, modifieddamage);
  modifieddamage = scripts\mp\damage::handleapdamage(objweapon, type, modifieddamage, attacker);
  playfxontagforclients(level.remoteuav_fx["hit"], self, "tag_origin", self.owner);
  self playSound("recondrone_damaged");

  if(self.smoking == 0 && self.damagetaken >= self.maxhealth / 2) {
    self.smoking = 1;
    playFXOnTag(level.remoteuav_fx["smoke"], self, "tag_origin");
  }

  return modifieddamage;
}

function handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  scripts\mp\damage::onkillstreakkilled("remote_uav", attacker, objweapon, type, damage, "destroyed_remote_uav", undefined, "callout_destroyed_remote_uav");
}