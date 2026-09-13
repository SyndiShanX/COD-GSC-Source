/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\remoteuav.gsc
************************************************/

init() {
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
  level.remote_uav = [];
}

useremoteuav(lifeid, streakname) {
  return tryuseremoteuav(lifeid, "remote_uav");
}

exceededmaxremoteuavs(team) {
  if(scripts\mp\utility\game::getgametype() == "dm") {
    if(isDefined(level.remote_uav[team]) || isDefined(level.remote_uav[scripts\mp\utility\game::getotherteam(team)[0]]))
      return 1;
    else
      return 0;
  } else if(isDefined(level.remote_uav[team]))
    return 1;
  else
    return 0;
}

tryuseremoteuav(lifeid, streakname) {
  _id_3B64EB40368C1450::set("remote_uav", "usability", 0);

  if(scripts\mp\utility\player::isusingremote() || self isusingturret() || isDefined(level.nukeinfo._id_9DCCABA98B643CAD)) {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("remote_uav");
    return 0;
  }

  _id_4440147083ABAF0A = 1;

  if(exceededmaxremoteuavs(self.team) || level.littlebirds.size >= 4) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("remote_uav");
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + _id_4440147083ABAF0A >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("remote_uav");
    return 0;
  }

  self setplayerdata("reconDroneState", "staticAlpha", 0);
  self setplayerdata("reconDroneState", "incomingMissile", 0);
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  result = givecarryremoteuav(lifeid, streakname);

  if(result) {
    scripts\common\utility::trycall(level.matchdata_logkillstreakevent, streakname, self.origin);
    thread scripts\mp\hud_util::teamplayercardsplash("used_remote_uav", self);
  } else
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();

  self.iscarrying = 0;
  return result;
}

givecarryremoteuav(lifeid, streakname) {
  _id_1CCD129C7750015E = createcarryremoteuav(streakname, self);
  scripts\cp_mp\utility\inventory_utility::_takeweapon("killstreak_uav_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon("killstreak_remote_uav_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("killstreak_remote_uav_mp");
  setcarryingremoteuav(_id_1CCD129C7750015E);

  if(isalive(self) && isDefined(_id_1CCD129C7750015E)) {
    origin = _id_1CCD129C7750015E.origin;
    angles = self.angles;
    _id_1CCD129C7750015E.soundent delete();
    _id_1CCD129C7750015E delete();
    result = startremoteuav(lifeid, streakname, origin, angles);
  } else {
    result = 0;

    if(isalive(self)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("killstreak_remote_uav_mp");
      scripts\cp_mp\utility\inventory_utility::_giveweapon("killstreak_uav_mp");
    }
  }

  return result;
}

createcarryremoteuav(streakname, owner) {
  pos = owner.origin + anglesToForward(owner.angles) * 4 + anglestoup(owner.angles) * 50;
  _id_1CCD129C7750015E = spawnturret("misc_turret", pos, "sentry_minigun_mp");
  _id_1CCD129C7750015E.origin = pos;
  _id_1CCD129C7750015E.angles = owner.angles;
  _id_1CCD129C7750015E.sentrytype = "sentry_minigun";
  _id_1CCD129C7750015E.canbeplaced = 1;
  _id_1CCD129C7750015E setturretmodechangewait(1);
  _id_1CCD129C7750015E setmode("sentry_offline");
  _id_1CCD129C7750015E makeunusable();
  _id_1CCD129C7750015E maketurretinoperable();
  _id_1CCD129C7750015E.owner = owner;
  _id_1CCD129C7750015E setsentryowner(_id_1CCD129C7750015E.owner);
  _id_1CCD129C7750015E.scale = 3;
  _id_1CCD129C7750015E.inheliproximity = 0;
  _id_1CCD129C7750015E thread carryremoteuav_handleexistence();
  _id_1CCD129C7750015E.rangetrigger = getEnt("remote_uav_range", "targetname");

  if(!isDefined(_id_1CCD129C7750015E.rangetrigger)) {
    _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    _id_1CCD129C7750015E.maxheight = _id_5FA1E1697A302583.origin[2];
    _id_1CCD129C7750015E.maxdistance = 3600;
  }

  _id_1CCD129C7750015E.soundent = spawn("script_origin", _id_1CCD129C7750015E.origin);
  _id_1CCD129C7750015E.soundent.angles = _id_1CCD129C7750015E.angles;
  _id_1CCD129C7750015E.soundent.origin = _id_1CCD129C7750015E.origin;
  _id_1CCD129C7750015E.soundent linkTo(_id_1CCD129C7750015E);
  _id_1CCD129C7750015E.soundent playLoopSound("recondrone_idle_high");
  return _id_1CCD129C7750015E;
}

setcarryingremoteuav(_id_1CCD129C7750015E) {
  _id_1CCD129C7750015E thread carryremoteuav_setcarried(self);
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
      carryremoteuav_delete(_id_1CCD129C7750015E);
      break;
    }

    if(!_id_1CCD129C7750015E.canbeplaced) {
      if(self.team != "spectator")
        self forceusehinton(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");

      continue;
    }

    if(exceededmaxremoteuavs(self.team) || scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
      self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
      carryremoteuav_delete(_id_1CCD129C7750015E);
      break;
    }

    self.iscarrying = 0;
    _id_1CCD129C7750015E.carriedby = undefined;
    _id_1CCD129C7750015E playSound("sentry_gun_plant");
    _id_1CCD129C7750015E notify("placed");
    break;
  }
}

local_waittill_any_return_6(_id_0E7865AE7BE35347, _id_0E7866AE7BE3557A, _id_0E7867AE7BE357AD, _id_0E7860AE7BE34848, _id_0E7861AE7BE34A7B, _id_0E7862AE7BE34CAE) {
  if((!isDefined(_id_0E7865AE7BE35347) || _id_0E7865AE7BE35347 != "death") && (!isDefined(_id_0E7866AE7BE3557A) || _id_0E7866AE7BE3557A != "death") && (!isDefined(_id_0E7867AE7BE357AD) || _id_0E7867AE7BE357AD != "death") && (!isDefined(_id_0E7860AE7BE34848) || _id_0E7860AE7BE34848 != "death") && (!isDefined(_id_0E7861AE7BE34A7B) || _id_0E7861AE7BE34A7B != "death"))
    self endon("death");

  ent = spawnStruct();

  if(isDefined(_id_0E7865AE7BE35347))
    thread scripts\engine\utility::waittill_string(_id_0E7865AE7BE35347, ent);

  if(isDefined(_id_0E7866AE7BE3557A))
    thread scripts\engine\utility::waittill_string(_id_0E7866AE7BE3557A, ent);

  if(isDefined(_id_0E7867AE7BE357AD))
    thread scripts\engine\utility::waittill_string(_id_0E7867AE7BE357AD, ent);

  if(isDefined(_id_0E7860AE7BE34848))
    thread scripts\engine\utility::waittill_string(_id_0E7860AE7BE34848, ent);

  if(isDefined(_id_0E7861AE7BE34A7B))
    thread scripts\engine\utility::waittill_string(_id_0E7861AE7BE34A7B, ent);

  if(isDefined(_id_0E7862AE7BE34CAE))
    thread scripts\engine\utility::waittill_string(_id_0E7862AE7BE34CAE, ent);

  ent waittill("returned", msg);
  ent notify("die");
  return msg;
}

carryremoteuav_setcarried(carrier) {
  self setCanDamage(0);
  self setsentrycarrier(carrier);
  self notsolid();
  self.carriedby = carrier;
  carrier.iscarrying = 1;
  carrier thread updatecarryremoteuavplacement(self);
  self notify("carried");
}

carryremoteuav_delete(_id_1CCD129C7750015E) {
  self.iscarrying = 0;

  if(isDefined(_id_1CCD129C7750015E)) {
    if(isDefined(_id_1CCD129C7750015E.soundent))
      _id_1CCD129C7750015E.soundent delete();

    _id_1CCD129C7750015E delete();
  }
}

isinremotenodeploy() {
  if(isDefined(level.remoteuav_nodeployzones) && level.remoteuav_nodeployzones.size) {
    foreach(zone in level.remoteuav_nodeployzones) {
      if(self istouching(zone))
        return 1;
    }
  }

  return 0;
}

updatecarryremoteuavplacement(_id_1CCD129C7750015E) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_1CCD129C7750015E endon("placed");
  _id_1CCD129C7750015E endon("death");
  _id_1CCD129C7750015E.canbeplaced = 1;
  _id_B89A549815EE28D3 = -1;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("remote_uav");

  for(;;) {
    heightoffset = 18;

    switch (self getstance()) {
      case "stand":
        heightoffset = 40;
        break;
      case "crouch":
        heightoffset = 25;
        break;
      case "prone":
        heightoffset = 10;
        break;
    }

    placement = self canplayerplacetank(22, 22, 50, heightoffset, 0, 0);
    _id_1CCD129C7750015E.origin = placement["origin"] + anglestoup(self.angles) * 27;
    _id_1CCD129C7750015E.angles = placement["angles"];
    _id_1CCD129C7750015E.canbeplaced = self isonground() && placement["result"] && _id_1CCD129C7750015E remoteuav_in_range() && !_id_1CCD129C7750015E isinremotenodeploy();

    if(_id_1CCD129C7750015E.canbeplaced != _id_B89A549815EE28D3) {
      if(_id_1CCD129C7750015E.canbeplaced) {
        if(self.team != "spectator")
          self forceusehinton(&"KILLSTREAKS_REMOTE_UAV_PLACE");

        if(self attackButtonPressed())
          self notify("place_carryRemoteUAV");
      } else if(self.team != "spectator")
        self forceusehinton(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
    }

    _id_B89A549815EE28D3 = _id_1CCD129C7750015E.canbeplaced;
    waitframe();
  }
}

carryremoteuav_handleexistence() {
  level endon("game_ended");
  self.owner endon("place_carryRemoteUAV");
  self.owner endon("cancel_carryRemoteUAV");
  self.owner scripts\engine\utility::waittill_any_3("death_or_disconnect", "joined_team", "joined_spectators");

  if(isDefined(self)) {
    if(isDefined(self.soundent))
      self.soundent delete();

    self delete();
  }
}

removeremoteweapon() {
  level endon("game_ended");
  self endon("disconnect");
  wait 0.7;
}

startremoteuav(lifeid, streakname, origin, angles) {
  lockplayerforremoteuavlaunch();
  scripts\mp\utility\player::setusingremote(streakname);
  scripts\cp_mp\utility\inventory_utility::_giveweapon("uav_remote_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("uav_remote_mp");
  self visionsetnakedforplayer("black_bw", 0.0);
  result = scripts\mp\killstreaks\killstreaks::initridekillstreak("remote_uav");

  if(result != "success") {
    if(result != "disconnect") {
      self notify("remoteuav_unlock");
      scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
      scripts\mp\utility\player::clearusingremote();
    }

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("ride_killstreak");
    return 0;
  }

  if(exceededmaxremoteuavs(self.team) || scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    self notify("remoteuav_unlock");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
    scripts\mp\utility\player::clearusingremote();
    return 0;
  }

  self notify("remoteuav_unlock");
  remoteuav = createremoteuav(lifeid, self, streakname, origin, angles);

  if(isDefined(remoteuav)) {
    thread remoteuav_ride(lifeid, remoteuav, streakname);
    return 1;
  } else {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
    scripts\mp\utility\player::clearusingremote();
    return 0;
  }
}

lockplayerforremoteuavlaunch() {
  _id_59C2F84B264976FE = spawn("script_origin", self.origin);
  _id_59C2F84B264976FE hide();
  self playerlinkTo(_id_59C2F84B264976FE);
  thread clearplayerlockfromremoteuavlaunch(_id_59C2F84B264976FE);
}

clearplayerlockfromremoteuavlaunch(_id_59C2F84B264976FE) {
  level endon("game_ended");
  msg = scripts\engine\utility::waittill_any_return_2("death_or_disconnect", "remoteuav_unlock");

  if(msg != "disconnect")
    self unlink();

  _id_59C2F84B264976FE delete();
}

createremoteuav(lifeid, owner, streakname, origin, angles) {
  if(owner isconsoleplayer())
    remoteuav = spawnhelicopter(owner, origin, angles, "remote_uav_mp", "vehicle_remote_uav");
  else
    remoteuav = spawnhelicopter(owner, origin, angles, "remote_uav_mp_pc", "vehicle_remote_uav");

  if(!isDefined(remoteuav))
    return undefined;

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

remoteuav_ride(lifeid, remoteuav, streakname) {
  remoteuav.playerlinked = 1;
  self.restoreangles = self.angles;

  if(getdvarint("camera_thirdPerson"))
    scripts\mp\utility\player::setthirdpersondof(0);

  self cameralinkTo(remoteuav, "tag_origin");
  self remotecontrolvehicle(remoteuav);
  thread remoteuav_playerexit(remoteuav);
  thread remoteuav_track(remoteuav);
  thread remoteuav_fire(remoteuav);
  self.remote_uav_ridelifeid = lifeid;
  self.remoteuav = remoteuav;
  thread remoteuav_delaylaunchdialog(remoteuav);
  self visionsetnakedforplayer("black_bw", 0.0);
  scripts\mp\utility\player::restorebasevisionset(1);
}

remoteuav_delaylaunchdialog(remoteuav) {
  level endon("game_ended");
  self endon("disconnect");
  remoteuav endon("death");
  remoteuav endon("end_remote");
  remoteuav endon("end_launch_dialog");
  wait 3;
  remoteuav_dialog("launch");
}

remoteuav_endride(remoteuav) {
  if(isDefined(remoteuav)) {
    remoteuav.playerlinked = 0;
    remoteuav notify("end_remote");
    scripts\mp\utility\player::clearusingremote();

    if(getdvarint("camera_thirdPerson"))
      scripts\mp\utility\player::setthirdpersondof(1);

    self cameraunlink(remoteuav);
    self remotecontrolvehicleoff(remoteuav);
    self thermalvisionoff();
    self setplayerangles(self.restoreangles);
    _id_5B919F578AECE4EA = scripts\mp\utility\inventory::getlastweapon();

    if(!self hasweapon(_id_5B919F578AECE4EA))
      _id_5B919F578AECE4EA = scripts\mp\utility\inventory::getfirstprimaryweapon();

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(_id_5B919F578AECE4EA);
    scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
    thread remoteuav_freezebuffer();
  }

  self.remoteuav = undefined;
}

remoteuav_freezebuffer() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_freezecontrols(1, undefined, "remoteuav");
  wait 0.5;
  scripts\mp\utility\player::_freezecontrols(0, undefined, "remoteuav");
}

remoteuav_playerexit(remoteuav) {
  level endon("game_ended");
  self endon("disconnect");
  remoteuav endon("death");
  remoteuav endon("end_remote");
  wait 2;
  _id_038FC7BD1495C4B2 = level.framedurationseconds;

  for(;;) {
    _id_23B90B34FECC58CD = 0;

    while(self useButtonPressed()) {
      _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;

      if(_id_23B90B34FECC58CD > 0.75) {
        remoteuav thread remoteuav_leave();
        return;
      }

      wait(_id_038FC7BD1495C4B2);
    }

    waitframe();
  }
}

remoteuav_track(remoteuav) {
  level endon("game_ended");
  self endon("disconnect");
  remoteuav endon("death");
  remoteuav endon("end_remote");
  remoteuav.lasttrackingdialogtime = 0;
  self.lockedtarget = undefined;
  self weaponlockfree();
  wait 1;

  for(;;) {
    pos = remoteuav gettagorigin("tag_turret");
    forward = anglesToForward(self getplayerangles());
    endpos = pos + forward * 1024;
    trace = scripts\engine\trace::_bullet_trace(pos, endpos, 1, remoteuav);

    if(isDefined(trace["position"]))
      targetpos = trace["position"];
    else {
      targetpos = endpos;
      trace["endpos"] = endpos;
    }

    remoteuav.trace = trace;
    _id_17B181CF69C8AA3E = remoteuav_trackentities(remoteuav, level.players, targetpos);
    _id_EFF2C9504A645DC9 = remoteuav_trackentities(remoteuav, level.turrets, targetpos);
    _id_8D22872E304EE881 = undefined;

    if(level.teambased) {
      _id_DCB5FD0CC07E40A2 = [];
      _id_B0C33D224B825287 = scripts\mp\utility\teams::getenemyteams(self.team);

      foreach(_id_F90358454413407F in level.teamnamelist) {
        foreach(model in level.uavmodels[_id_F90358454413407F])
        _id_DCB5FD0CC07E40A2[_id_DCB5FD0CC07E40A2.size] = model;
      }

      _id_8D22872E304EE881 = remoteuav_trackentities(remoteuav, _id_DCB5FD0CC07E40A2, targetpos);
    } else
      _id_8D22872E304EE881 = remoteuav_trackentities(remoteuav, level.uavmodels, targetpos);

    lockedtarget = undefined;

    if(isDefined(_id_17B181CF69C8AA3E))
      lockedtarget = _id_17B181CF69C8AA3E;
    else if(isDefined(_id_EFF2C9504A645DC9))
      lockedtarget = _id_EFF2C9504A645DC9;
    else if(isDefined(_id_8D22872E304EE881))
      lockedtarget = _id_8D22872E304EE881;

    if(isDefined(lockedtarget)) {
      if(!isDefined(self.lockedtarget) || isDefined(self.lockedtarget) && self.lockedtarget != lockedtarget) {
        self weaponlockfinalize(lockedtarget);
        self.lockedtarget = lockedtarget;

        if(isDefined(_id_17B181CF69C8AA3E)) {
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

remoteuav_trackentities(remoteuav, entities, targetpos) {
  level endon("game_ended");
  lockedtarget = undefined;

  foreach(entity in entities) {
    if(level.teambased && (!isDefined(entity.team) || entity.team == self.team)) {
      continue;
    }
    if(isPlayer(entity)) {
      if(!scripts\mp\utility\player::isreallyalive(entity)) {
        continue;
      }
      if(entity == self) {
        continue;
      }
      id = entity.guid;
    } else
      id = entity.birthtime;

    if(isDefined(entity.sentrytype) || isDefined(entity.turrettype)) {
      offset = 32;
      _id_EE22627FDCFE58BF = "hud_fofbox_hostile_vehicle";
    } else if(isDefined(entity.uavtype)) {
      offset = -52;
      _id_EE22627FDCFE58BF = "hud_fofbox_hostile_vehicle";
    } else {
      offset = 26;
      _id_EE22627FDCFE58BF = "veh_hud_target_unmarked";
    }

    if(isDefined(entity.uavremotemarkedby)) {
      if(!isDefined(remoteuav.markedplayers[id])) {
        remoteuav.markedplayers[id] = [];
        remoteuav.markedplayers[id]["player"] = entity;
        remoteuav.markedplayers[id]["icon"] = entity thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "veh_hud_target_marked", offset);
        remoteuav.markedplayers[id]["icon"].shader = "veh_hud_target_marked";

        if(!isDefined(entity.sentrytype) || !isDefined(entity.turrettype))
          remoteuav.markedplayers[id]["icon"] settargetEnt(entity);
      } else if(isDefined(remoteuav.markedplayers[id]) && isDefined(remoteuav.markedplayers[id]["icon"]) && isDefined(remoteuav.markedplayers[id]["icon"].shader) && remoteuav.markedplayers[id]["icon"].shader != "veh_hud_target_marked") {
        remoteuav.markedplayers[id]["icon"].shader = "veh_hud_target_marked";
        remoteuav.markedplayers[id]["icon"] setshader("veh_hud_target_marked", 10, 10);
        remoteuav.markedplayers[id]["icon"] setwaypoint(0, 0, 0, 0);
      }

      continue;
    }

    if(isPlayer(entity)) {
      _id_1F6FA3102BC4A682 = isDefined(entity.spawntime) && (gettime() - entity.spawntime) / 1000 <= 5;
      _id_63C3DAB9425623F3 = entity scripts\mp\utility\perk::_hasperk("specialty_blindeye");
      carried = 0;
      leaving = 0;
    } else {
      _id_1F6FA3102BC4A682 = 0;
      _id_63C3DAB9425623F3 = 0;
      carried = isDefined(entity.carriedby);
      leaving = isDefined(entity.isleaving) && entity.isleaving == 1;
    }

    if(!isDefined(remoteuav.markedplayers[id]) && !_id_1F6FA3102BC4A682 && !_id_63C3DAB9425623F3 && !carried && !leaving) {
      remoteuav.markedplayers[id] = [];
      remoteuav.markedplayers[id]["player"] = entity;
      remoteuav.markedplayers[id]["icon"] = entity scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, _id_EE22627FDCFE58BF, offset);
      remoteuav.markedplayers[id]["icon"].shader = _id_EE22627FDCFE58BF;

      if(!isDefined(entity.sentrytype) || !isDefined(entity.turrettype))
        remoteuav.markedplayers[id]["icon"] settargetEnt(entity);
    }

    if((!isDefined(lockedtarget) || lockedtarget != entity) && (isDefined(remoteuav.trace["entity"]) && remoteuav.trace["entity"] == entity && !carried && !leaving) || distance(entity.origin, targetpos) < 200 * remoteuav.trace["fraction"] && !_id_1F6FA3102BC4A682 && !carried && !leaving || !leaving && remoteuav_cantargetuav(remoteuav, entity)) {
      trace = scripts\engine\trace::_bullet_trace(remoteuav.origin, entity.origin + (0, 0, 32), 1, remoteuav);

      if(isDefined(trace["entity"]) && trace["entity"] == entity || trace["fraction"] == 1) {
        self playlocalsound("recondrone_lockon");
        lockedtarget = entity;
      }
    }
  }

  return lockedtarget;
}

remoteuav_cantargetuav(remoteuav, uav) {
  if(isDefined(uav.uavtype)) {
    forward = anglesToForward(self getplayerangles());
    _id_A9DA5F2C559F3484 = vectorNormalize(uav.origin - remoteuav gettagorigin("tag_turret"));
    dot = vectordot(forward, _id_A9DA5F2C559F3484);

    if(dot > 0.985)
      return 1;
  }

  return 0;
}

remoteuav_fire(remoteuav) {
  self endon("disconnect");
  remoteuav endon("death");
  level endon("game_ended");
  remoteuav endon("end_remote");
  wait 1;
  self notifyonplayercommand("remoteUAV_tag", "+attack");
  self notifyonplayercommand("remoteUAV_tag", "+attack_akimbo_accessible");

  for(;;) {
    self waittill("remoteUAV_tag");

    if(isDefined(self.lockedtarget)) {
      self playlocalsound("recondrone_tag");
      _id_5762AC2F22202BA2::updatedamagefeedback("");
      thread remoteuav_markplayer(self.lockedtarget);
      thread remoteuav_rumble(remoteuav, 3);
      wait 0.25;
      continue;
    }

    waitframe();
  }
}

remoteuav_rumble(remoteuav, amount) {
  self endon("disconnect");
  remoteuav endon("death");
  level endon("game_ended");
  remoteuav endon("end_remote");
  remoteuav notify("end_rumble");
  remoteuav endon("end_rumble");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < amount; _id_AC0E594AC96AA3A8++) {
    self playRumbleOnEntity("damage_heavy");
    wait 0.05;
  }
}

remoteuav_markplayer(targetplayer) {
  level endon("game_ended");
  targetplayer.uavremotemarkedby = self;

  if(isPlayer(targetplayer) && !targetplayer scripts\mp\utility\player::isusingremote()) {} else if(isDefined(targetplayer.uavtype))
    targetplayer.birth_time = targetplayer.birthtime;
  else if(isDefined(targetplayer.owner) && isalive(targetplayer.owner))
    targetplayer.owner thread scripts\mp\rank::scoreeventpopup("stat_508E80998122A1A4");

  remoteuav_dialog("tag");

  if(scripts\mp\utility\game::getgametype() != "dm") {
    if(isPlayer(targetplayer))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_EF9582D72160F199");
  }

  if(isPlayer(targetplayer))
    targetplayer setperk("specialty_radarblip", 1);
  else {
    if(isDefined(targetplayer.uavtype))
      shadername = "compassping_enemy_uav";
    else
      shadername = "compassping_sentry_enemy";

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
        scripts\mp\objidpoolmanager::objective_teammask_single(curobjid, scripts\mp\utility\game::getotherteam(self.team)[0]);
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

remoteuav_processtaggedassist(victim) {
  remoteuav_dialog("assist");

  if(scripts\mp\utility\game::getgametype() != "dm") {
    self.taggedassist = 1;

    if(isDefined(victim))
      thread scripts\mp\gamescore::processassist(victim);
    else
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_8FCF8BBD78A0502E");
  }
}

remoteuav_unmarkremovedplayer(remoteuav) {
  level endon("game_ended");
  msg = scripts\engine\utility::waittill_any_return_3("death_or_disconnect", "carried", "leaving");

  if(msg == "leaving" || !isDefined(self.uavtype))
    self.uavremotemarkedby = undefined;

  if(isDefined(remoteuav)) {
    if(isPlayer(self))
      id = self.guid;
    else if(isDefined(self.birthtime))
      id = self.birthtime;
    else
      id = self.birth_time;

    if(msg == "carried" || msg == "leaving") {
      if(isDefined(remoteuav.markedplayers[id]["icon"])) {
        remoteuav.markedplayers[id]["icon"] destroy();
        remoteuav.markedplayers[id]["icon"] = undefined;
      }
    }

    if(isDefined(id) && isDefined(remoteuav.markedplayers[id])) {
      remoteuav.markedplayers[id] = undefined;
      remoteuav.markedplayers = scripts\engine\utility::array_removeundefined(remoteuav.markedplayers);
    }
  }

  if(isPlayer(self))
    self unsetperk("specialty_radarblip", 1);
  else {
    if(isDefined(self.remoteuavmarkedobjid01))
      scripts\mp\objidpoolmanager::returnobjectiveid(self.remoteuavmarkedobjid01);

    if(isDefined(self.remoteuavmarkedobjid02))
      scripts\mp\objidpoolmanager::returnobjectiveid(self.remoteuavmarkedobjid02);

    if(isDefined(self.remoteuavmarkedobjid03))
      scripts\mp\objidpoolmanager::returnobjectiveid(self.remoteuavmarkedobjid03);
  }
}

remoteuav_clearmarkedforowner() {
  foreach(_id_82DC593EF677C4F0 in self.markedplayers) {
    if(isDefined(_id_82DC593EF677C4F0["icon"])) {
      _id_82DC593EF677C4F0["icon"] destroy();
      _id_82DC593EF677C4F0["icon"] = undefined;
    }
  }

  self.markedplayers = undefined;
}

remoteuav_operationrumble(remoteuav) {
  self endon("disconnect");
  remoteuav endon("death");
  level endon("game_ended");
  remoteuav endon("end_remote");

  for(;;) {
    self playRumbleOnEntity("damage_light");
    wait 0.5;
  }
}

remoteuav_watch_distance() {
  self endon("death");
  self.rangetrigger = getEnt("remote_uav_range", "targetname");

  if(!isDefined(self.rangetrigger)) {
    _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
    self.maxheight = _id_5FA1E1697A302583.origin[2];
    self.maxdistance = 12800;
  }

  self.centerref = spawn("script_model", level.mapcenter);
  _id_E78E78431D2274FF = self.origin;
  self.rangecountdownactive = 0;

  for(;;) {
    if(!remoteuav_in_range()) {
      _id_FAF072C5A82D8DE9 = 0;

      while(!remoteuav_in_range()) {
        self.owner remoteuav_dialog("out_of_range");

        if(!self.rangecountdownactive) {
          self.rangecountdownactive = 1;
          thread remoteuav_rangecountdown();
        }

        if(isDefined(self.heliinproximity)) {
          dist = distance(self.origin, self.heliinproximity.origin);
          _id_FAF072C5A82D8DE9 = 1 - (dist - 150) / 150;
        } else {
          dist = distance(self.origin, _id_E78E78431D2274FF);
          _id_FAF072C5A82D8DE9 = min(1, dist / 200);
        }

        self.owner setplayerdata("reconDroneState", "staticAlpha", _id_FAF072C5A82D8DE9);
        wait 0.05;
      }

      self notify("in_range");
      self.rangecountdownactive = 0;
      thread remoteuav_staticfade(_id_FAF072C5A82D8DE9);
    }

    _id_E78E78431D2274FF = self.origin;
    waitframe();
  }
}

remoteuav_in_range() {
  if(isDefined(self.rangetrigger)) {
    if(!self istouching(self.rangetrigger) && !self.inheliproximity)
      return 1;
  } else if(distance2d(self.origin, level.mapcenter) < self.maxdistance && self.origin[2] < self.maxheight && !self.inheliproximity)
    return 1;

  return 0;
}

remoteuav_staticfade(_id_FAF072C5A82D8DE9) {
  self endon("death");

  while(remoteuav_in_range()) {
    _id_FAF072C5A82D8DE9 = _id_FAF072C5A82D8DE9 - 0.05;

    if(_id_FAF072C5A82D8DE9 < 0) {
      self.owner setplayerdata("reconDroneState", "staticAlpha", 0);
      break;
    }

    self.owner setplayerdata("reconDroneState", "staticAlpha", _id_FAF072C5A82D8DE9);
    wait 0.05;
  }
}

remoteuav_rangecountdown() {
  self endon("death");
  self endon("in_range");

  if(isDefined(self.heliinproximity))
    _id_792ED6BAA73AE134 = 3;
  else
    _id_792ED6BAA73AE134 = 6;

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(_id_792ED6BAA73AE134);
  self notify("death");
}

remoteuav_explode_on_disconnect() {
  self endon("death");
  self.owner waittill("disconnect");
  self notify("death");
}

remoteuav_explode_on_changeteams() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  self notify("death");
}

remoteuav_clear_marked_on_gameended() {
  self endon("death");
  level waittill("game_ended");
  remoteuav_clearmarkedforowner();
}

remoteuav_leave_on_timeout() {
  self endon("death");
  flytime = 60.0;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(flytime);
  thread remoteuav_leave();
}

remoteuav_leave() {
  level endon("game_ended");
  self endon("death");
  self notify("leaving");
  self.owner remoteuav_endride(self);
  self notify("death");
}

remoteuav_explode_on_death() {
  level endon("game_ended");
  self waittill("death");
  self playSound("recondrone_destroyed");
  playFX(level.remoteuav_fx["explode"], self.origin);
  remoteuav_cleanup();
}

remoteuav_cleanup() {
  if(self.playerlinked == 1 && isDefined(self.owner))
    self.owner remoteuav_endride(self);

  if(isDefined(self.scrambler))
    self.scrambler delete();

  if(isDefined(self.centerref))
    self.centerref delete();

  remoteuav_clearmarkedforowner();
  stopFXOnTag(level.remoteuav_fx["smoke"], self, "tag_origin");
  level.remote_uav[self.team] = undefined;
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}

remoteuav_light_fx() {
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_nose");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
}

remoteuav_dialog(_id_9E3CBCDA4B9BDCBC) {
  if(_id_9E3CBCDA4B9BDCBC == "tag")
    waittime = 1000;
  else
    waittime = 5000;

  if(gettime() - level.remoteuav_lastdialogtime < waittime) {
    return;
  }
  level.remoteuav_lastdialogtime = gettime();
  _id_610520BE555433B2 = randomint(level.remoteuav_dialog[_id_9E3CBCDA4B9BDCBC].size);
  soundalias = level.remoteuav_dialog[_id_9E3CBCDA4B9BDCBC][_id_610520BE555433B2];
  _id_AEECA9F734EA50C1 = scripts\mp\utility\teams::getteamvoiceinfix(self.team) + "tl" + soundalias;
  self playlocalsound(_id_AEECA9F734EA50C1);
}

remoteuav_handleincomingstinger() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    level waittill("stinger_fired", player, missile, _id_D1636A91C31CF68F);

    if(!isDefined(missile) || !isDefined(_id_D1636A91C31CF68F) || _id_D1636A91C31CF68F != self) {
      continue;
    }
    self.owner playlocalsound("javelin_clu_lock");
    self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
    self.hasincoming = 1;
    self.incomingmissiles[self.incomingmissiles.size] = missile;
    missile.owner = player;
    missile thread watchstingerproximity(_id_D1636A91C31CF68F);
  }
}

remoteuav_handleincomingsam() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    level waittill("sam_fired", player, _id_A512AA80EA6BF396, _id_D1636A91C31CF68F);

    if(!isDefined(_id_D1636A91C31CF68F) || _id_D1636A91C31CF68F != self) {
      continue;
    }
    _id_5106E97C176BC70C = 0;

    foreach(missile in _id_A512AA80EA6BF396) {
      if(isDefined(missile)) {
        self.incomingmissiles[self.incomingmissiles.size] = missile;
        missile.owner = player;
        _id_5106E97C176BC70C++;
      }
    }

    if(_id_5106E97C176BC70C) {
      self.owner playlocalsound("javelin_clu_lock");
      self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
      self.hasincoming = 1;
      level thread watchsamproximity(_id_D1636A91C31CF68F, _id_A512AA80EA6BF396);
    }
  }
}

watchstingerproximity(_id_6D87867F43E1D612) {
  level endon("game_ended");
  self endon("death");
  self missile_settargetEnt(_id_6D87867F43E1D612);
  lastvectotarget = vectorNormalize(_id_6D87867F43E1D612.origin - self.origin);

  while(isDefined(_id_6D87867F43E1D612)) {
    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);
    _id_6B40B4C28ABE0A05 = distance(self.origin, center);

    if(_id_6D87867F43E1D612.numflares > 0 && _id_6B40B4C28ABE0A05 < 4000) {
      newtarget = _id_6D87867F43E1D612 deployflares();
      self missile_settargetEnt(newtarget);
      return;
    } else {
      _id_E778A95BD6B64FB1 = vectorNormalize(_id_6D87867F43E1D612.origin - self.origin);

      if(vectordot(_id_E778A95BD6B64FB1, lastvectotarget) < 0) {
        self playSound("exp_stinger_armor_destroy");
        playFX(level.remoteuav_fx["missile_explode"], self.origin);

        if(isDefined(self.owner))
          radiusdamage(self.origin, 400, 1000, 1000, self.owner, "MOD_EXPLOSIVE", "stinger_mp");
        else
          radiusdamage(self.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");

        self hide();
        wait 0.05;
        self delete();
      } else
        lastvectotarget = _id_E778A95BD6B64FB1;
    }

    wait 0.05;
  }
}

watchsamproximity(_id_6D87867F43E1D612, _id_A512AA80EA6BF396) {
  level endon("game_ended");
  _id_6D87867F43E1D612 endon("death");

  foreach(missile in _id_A512AA80EA6BF396) {
    if(isDefined(missile)) {
      missile missile_settargetEnt(_id_6D87867F43E1D612);
      missile.lastvectotarget = vectorNormalize(_id_6D87867F43E1D612.origin - missile.origin);
    }
  }

  while(_id_A512AA80EA6BF396.size && isDefined(_id_6D87867F43E1D612)) {
    center = _id_6D87867F43E1D612 getpointinbounds(0, 0, 0);

    foreach(missile in _id_A512AA80EA6BF396) {
      if(isDefined(missile)) {
        if(isDefined(self.markfordetete)) {
          self delete();
          continue;
        }

        if(_id_6D87867F43E1D612.numflares > 0) {
          _id_1AC96A06E64C75CD = distance(missile.origin, center);

          if(_id_1AC96A06E64C75CD < 4000) {
            newtarget = _id_6D87867F43E1D612 deployflares();

            foreach(_id_07EA79FEB6D88B3E in _id_A512AA80EA6BF396) {
              if(isDefined(_id_07EA79FEB6D88B3E))
                _id_07EA79FEB6D88B3E missile_settargetEnt(newtarget);
            }

            return;
          }

          continue;
        }

        _id_E778A95BD6B64FB1 = vectorNormalize(_id_6D87867F43E1D612.origin - missile.origin);

        if(vectordot(_id_E778A95BD6B64FB1, missile.lastvectotarget) < 0) {
          missile playSound("exp_stinger_armor_destroy");
          playFX(level.remoteuav_fx["missile_explode"], missile.origin);

          if(isDefined(missile.owner))
            radiusdamage(missile.origin, 400, 1000, 1000, missile.owner, "MOD_EXPLOSIVE", "stinger_mp");
          else
            radiusdamage(missile.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");

          missile hide();
          missile.markfordetete = 1;
        } else
          missile.lastvectotarget = _id_E778A95BD6B64FB1;
      }
    }

    _id_A512AA80EA6BF396 = scripts\engine\utility::array_removeundefined(_id_A512AA80EA6BF396);
    wait 0.05;
  }
}

deployflares() {
  self.numflares--;
  self.owner thread remoteuav_rumble(self, 6);
  self playSound("WEAP_SHOTGUNATTACH_FIRE_NPC");
  thread playflarefx();
  spawnpos = self.origin + (0, 0, -100);
  _id_74A00834CC9C2CB8 = spawn("script_origin", spawnpos);
  _id_74A00834CC9C2CB8.angles = self.angles;
  _id_74A00834CC9C2CB8 movegravity((0, 0, -1), 5.0);
  _id_74A00834CC9C2CB8 thread deleteaftertime(5.0);
  return _id_74A00834CC9C2CB8;
}

playflarefx() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 5; _id_AC0E594AC96AA3A8++) {
    if(!isDefined(self)) {
      return;
    }
    playFXOnTag(level._effect["vehicle_flares"], self, "TAG_FLARE");
    wait 0.15;
  }
}

deleteaftertime(delay) {
  wait(delay);
  self delete();
}

remoteuav_clearincomingwarning() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    _id_EDBF8AE8DB33AD77 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.incomingmissiles.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(self.incomingmissiles[_id_AC0E594AC96AA3A8]) && missile_isincoming(self.incomingmissiles[_id_AC0E594AC96AA3A8], self))
        _id_EDBF8AE8DB33AD77++;
    }

    if(self.hasincoming && !_id_EDBF8AE8DB33AD77) {
      self.hasincoming = 0;
      self.owner setplayerdata("reconDroneState", "incomingMissile", 0);
    }

    self.incomingmissiles = scripts\engine\utility::array_removeundefined(self.incomingmissiles);
    wait 0.05;
  }
}

missile_isincoming(missile, remoteuav) {
  _id_E28BC57D4B27E3FE = vectorNormalize(remoteuav.origin - missile.origin);
  _id_D2FAD66C97B5F8BA = anglesToForward(missile.angles);
  return vectordot(_id_E28BC57D4B27E3FE, _id_D2FAD66C97B5F8BA) > 0;
}

remoteuav_watchheliproximity() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    inheliproximity = 0;

    foreach(heli in level.helis) {
      if(distance(heli.origin, self.origin) < 300) {
        inheliproximity = 1;
        self.heliinproximity = heli;
      }
    }

    foreach(_id_2D5132FBC622EF42 in level.littlebirds) {
      if(_id_2D5132FBC622EF42 != self && (!isDefined(_id_2D5132FBC622EF42.helitype) || _id_2D5132FBC622EF42.helitype != "remote_uav") && distance(_id_2D5132FBC622EF42.origin, self.origin) < 300) {
        inheliproximity = 1;
        self.heliinproximity = _id_2D5132FBC622EF42;
      }
    }

    if(!self.inheliproximity && inheliproximity)
      self.inheliproximity = 1;
    else if(self.inheliproximity && !inheliproximity) {
      self.inheliproximity = 0;
      self.heliinproximity = undefined;
    }

    waitframe();
  }
}

remoteuav_handledamage() {
  self endon("end_remote");
  scripts\mp\damage::monitordamage(self.maxhealth, "remote_uav", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  _id_702BFC08FABD86CB = scripts\mp\damage::handleempdamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handlemissiledamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handleapdamage(objweapon, type, _id_702BFC08FABD86CB, attacker);
  playfxontagforclients(level.remoteuav_fx["hit"], self, "tag_origin", self.owner);
  self playSound("recondrone_damaged");

  if(self.smoking == 0 && self.damagetaken >= self.maxhealth / 2) {
    self.smoking = 1;
    playFXOnTag(level.remoteuav_fx["smoke"], self, "tag_origin");
  }

  return _id_702BFC08FABD86CB;
}

handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  scripts\mp\damage::onkillstreakkilled("remote_uav", attacker, objweapon, type, damage, "destroyed_remote_uav", undefined, "callout_destroyed_remote_uav");
}