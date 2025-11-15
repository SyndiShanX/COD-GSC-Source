/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_remoteuav.gsc
*************************************************/

init() {
  level.remoteuav_fx["hit"] = loadfx("vfx\core\impacts\large_metal_painted_hit");
  level.remoteuav_fx["smoke"] = loadfx("vfx\core\smktrail\remote_heli_damage_smoke_runner");
  level.remoteuav_fx["explode"] = loadfx("vfx\core\expl\bouncing_betty_explosion");
  level.remoteuav_fx["missile_explode"] = loadfx("vfx\core\expl\stinger_explosion");
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
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("remote_uav", ::useremoteuav);
  level.remote_uav = [];
}

useremoteuav(param_00, param_01) {
  return tryuseremoteuav(param_00, "remote_uav");
}

exceededmaxremoteuavs(param_00) {
  if(level.gametype == "dm") {
    if(isDefined(level.remote_uav[param_00]) || isDefined(level.remote_uav[level.otherteam[param_00]])) {
      return 1;
    }

    return 0;
  }

  if(isDefined(level.remote_uav[param_00])) {
    return 1;
  }

  return 0;
}

tryuseremoteuav(param_00, param_01) {
  scripts\engine\utility::allow_usability(0);
  if(scripts\mp\utility::isusingremote() || self isusingturret() || isDefined(level.nukeincoming)) {
    scripts\engine\utility::allow_usability(1);
    return 0;
  }

  var_02 = 1;
  if(exceededmaxremoteuavs(self.team) || level.littlebirds.size >= 4) {
    self iprintlnbold( & "KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    scripts\engine\utility::allow_usability(1);
    return 0;
  } else if(scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount + var_02 >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold( & "KILLSTREAKS_TOO_MANY_VEHICLES");
    scripts\engine\utility::allow_usability(1);
    return 0;
  }

  self setplayerdata("reconDroneState", "staticAlpha", 0);
  self setplayerdata("reconDroneState", "incomingMissile", 0);
  scripts\mp\utility::incrementfauxvehiclecount();
  var_03 = setturretanim(param_00, param_01);
  if(var_03) {
    scripts\mp\matchdata::logkillstreakevent(param_01, self.origin);
    thread scripts\mp\utility::teamplayercardsplash("used_remote_uav", self);
  } else {
    scripts\mp\utility::decrementfauxvehiclecount();
  }

  self.iscarrying = 0;
  return var_03;
}

setturretanim(param_00, param_01) {
  var_02 = func_4994(param_01, self);
  scripts\mp\utility::_takeweapon("killstreak_uav_mp");
  scripts\mp\utility::_giveweapon("killstreak_remote_uav_mp");
  scripts\mp\utility::_switchtoweaponimmediate("killstreak_remote_uav_mp");
  func_F686(var_02);
  if(isalive(self) && isDefined(var_02)) {
    var_03 = var_02.origin;
    var_04 = self.angles;
    var_02.soundent delete();
    var_02 delete();
    var_05 = func_10DEA(param_00, param_01, var_03, var_04);
  } else {
    var_05 = 0;
    if(isalive(self)) {
      scripts\mp\utility::_takeweapon("killstreak_remote_uav_mp");
      scripts\mp\utility::_giveweapon("killstreak_uav_mp");
    }
  }

  return var_05;
}

func_4994(param_00, param_01) {
  var_02 = param_01.origin + anglesToForward(param_01.angles) * 4 + anglestoup(param_01.angles) * 50;
  var_03 = spawnturret("misc_turret", var_02, "sentry_minigun_mp");
  var_03.origin = var_02;
  var_03.angles = param_01.angles;
  var_03.sentrytype = "sentry_minigun";
  var_03.canbeplaced = 1;
  var_03 setturretmodechangewait(1);
  var_03 give_player_session_tokens("sentry_offline");
  var_03 makeunusable();
  var_03 getvalidattachments();
  var_03.triggerportableradarping = param_01;
  var_03 setsentryowner(var_03.triggerportableradarping);
  var_03.var_EB9C = 3;
  var_03.inheliproximity = 0;
  var_03 thread func_3AFE();
  var_03.rangetrigger = getent("remote_uav_range", "targetname");
  if(!isDefined(var_03.rangetrigger)) {
    var_04 = getent("airstrikeheight", "targetname");
    var_03.maxheight = var_04.origin[2];
    var_03.maxdistance = 3600;
  }

  var_03.soundent = spawn("script_origin", var_03.origin);
  var_03.soundent.angles = var_03.angles;
  var_03.soundent.origin = var_03.origin;
  var_03.soundent linkto(var_03);
  var_03.soundent playLoopSound("recondrone_idle_high");
  return var_03;
}

func_F686(param_00) {
  param_00 thread func_3AFF(self);
  self notifyonplayercommand("place_carryRemoteUAV", "+attack");
  self notifyonplayercommand("place_carryRemoteUAV", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 4");
  if(!level.console) {
    self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 5");
    self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 6");
    self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 7");
  }

  for(;;) {
    var_01 = local_waittill_any_return_6("place_carryRemoteUAV", "cancel_carryRemoteUAV", "weapon_switch_started", "force_cancel_placement", "death", "disconnect");
    self getrigindexfromarchetyperef();
    if(var_01 != "place_carryRemoteUAV") {
      carryremoteuav_delete(param_00);
      break;
    }

    if(!param_00.canbeplaced) {
      if(self.team != "spectator") {
        self forceusehinton( & "KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
      }

      continue;
    }

    if(exceededmaxremoteuavs(self.team) || scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility::maxvehiclesallowed()) {
      self iprintlnbold( & "KILLSTREAKS_TOO_MANY_VEHICLES");
      carryremoteuav_delete(param_00);
      break;
    }

    self.iscarrying = 0;
    param_00.carriedby = undefined;
    param_00 playSound("sentry_gun_plant");
    param_00 notify("placed");
    break;
  }
}

local_waittill_any_return_6(param_00, param_01, param_02, param_03, param_04, param_05) {
  if((!isDefined(param_00) || param_00 != "death") && !isDefined(param_01) || param_01 != "death" && !isDefined(param_02) || param_02 != "death" && !isDefined(param_03) || param_03 != "death" && !isDefined(param_04) || param_04 != "death") {
    self endon("death");
  }

  var_06 = spawnStruct();
  if(isDefined(param_00)) {
    thread scripts\engine\utility::waittill_string(param_00, var_06);
  }

  if(isDefined(param_01)) {
    thread scripts\engine\utility::waittill_string(param_01, var_06);
  }

  if(isDefined(param_02)) {
    thread scripts\engine\utility::waittill_string(param_02, var_06);
  }

  if(isDefined(param_03)) {
    thread scripts\engine\utility::waittill_string(param_03, var_06);
  }

  if(isDefined(param_04)) {
    thread scripts\engine\utility::waittill_string(param_04, var_06);
  }

  if(isDefined(param_05)) {
    thread scripts\engine\utility::waittill_string(param_05, var_06);
  }

  var_06 waittill("returned", var_07);
  var_06 notify("die");
  return var_07;
}

func_3AFF(param_00) {
  self setCanDamage(0);
  self setsentrycarrier(param_00);
  self setcontents(0);
  self.carriedby = param_00;
  param_00.iscarrying = 1;
  param_00 thread func_12E70(self);
  self notify("carried");
}

carryremoteuav_delete(param_00) {
  self.iscarrying = 0;
  if(isDefined(param_00)) {
    if(isDefined(param_00.soundent)) {
      param_00.soundent delete();
    }

    param_00 delete();
  }
}

isinremotenodeploy() {
  if(isDefined(level.remoteuav_nodeployzones) && level.remoteuav_nodeployzones.size) {
    foreach(var_01 in level.remoteuav_nodeployzones) {
      if(self istouching(var_01)) {
        return 1;
      }
    }
  }

  return 0;
}

func_12E70(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  param_00 endon("placed");
  param_00 endon("death");
  param_00.canbeplaced = 1;
  var_01 = -1;
  scripts\engine\utility::allow_usability(1);
  for(;;) {
    var_02 = 18;
    switch (self getstance()) {
      case "stand":
        var_02 = 40;
        break;

      case "crouch":
        var_02 = 25;
        break;

      case "prone":
        var_02 = 10;
        break;
    }

    var_03 = self canplayerplacetank(22, 22, 50, var_02, 0, 0);
    param_00.origin = var_03["origin"] + anglestoup(self.angles) * 27;
    param_00.angles = var_03["angles"];
    param_00.canbeplaced = self isonground() && var_03["result"] && param_00 remoteuav_in_range() && !param_00 isinremotenodeploy();
    if(param_00.canbeplaced != var_01) {
      if(param_00.canbeplaced) {
        if(self.team != "spectator") {
          self forceusehinton( & "KILLSTREAKS_REMOTE_UAV_PLACE");
        }

        if(self attackbuttonpressed()) {
          self notify("place_carryRemoteUAV");
        }
      } else if(self.team != "spectator") {
        self forceusehinton( & "KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
      }
    }

    var_01 = param_00.canbeplaced;
    wait(0.05);
  }
}

func_3AFE() {
  level endon("game_ended");
  self.triggerportableradarping endon("place_carryRemoteUAV");
  self.triggerportableradarping endon("cancel_carryRemoteUAV");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("death", "disconnect", "joined_team", "joined_spectators");
  if(isDefined(self)) {
    if(isDefined(self.soundent)) {
      self.soundent delete();
    }

    self delete();
  }
}

removeremoteweapon() {
  level endon("game_ended");
  self endon("disconnect");
  wait(0.7);
}

func_10DEA(param_00, param_01, param_02, param_03) {
  lockplayerforremoteuavlaunch();
  scripts\mp\utility::setusingremote(param_01);
  scripts\mp\utility::_giveweapon("uav_remote_mp");
  scripts\mp\utility::_switchtoweaponimmediate("uav_remote_mp");
  self visionsetnakedforplayer("black_bw", 0);
  var_04 = scripts\mp\killstreaks\_killstreaks::initridekillstreak("remote_uav");
  if(var_04 != "success") {
    if(var_04 != "disconnect") {
      self notify("remoteuav_unlock");
      scripts\mp\utility::_takeweapon("uav_remote_mp");
      scripts\mp\utility::clearusingremote();
    }

    return 0;
  }

  if(exceededmaxremoteuavs(self.team) || scripts\mp\utility::currentactivevehiclecount() >= scripts\mp\utility::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility::maxvehiclesallowed()) {
    self iprintlnbold( & "KILLSTREAKS_TOO_MANY_VEHICLES");
    self notify("remoteuav_unlock");
    scripts\mp\utility::_takeweapon("uav_remote_mp");
    scripts\mp\utility::clearusingremote();
    return 0;
  }

  self notify("remoteuav_unlock");
  var_05 = func_4A07(param_00, self, param_01, param_02, param_03);
  if(isDefined(var_05)) {
    thread remoteuav_ride(param_00, var_05, param_01);
    return 1;
  }

  self iprintlnbold( & "KILLSTREAKS_TOO_MANY_VEHICLES");
  scripts\mp\utility::_takeweapon("uav_remote_mp");
  scripts\mp\utility::clearusingremote();
  return 0;
}

lockplayerforremoteuavlaunch() {
  var_00 = spawn("script_origin", self.origin);
  var_00 hide();
  self playerlinkto(var_00);
  thread clearplayerlockfromremoteuavlaunch(var_00);
}

clearplayerlockfromremoteuavlaunch(param_00) {
  level endon("game_ended");
  var_01 = scripts\engine\utility::waittill_any_return("disconnect", "death", "remoteuav_unlock");
  if(var_01 != "disconnect") {
    self unlink();
  }

  param_00 delete();
}

func_4A07(param_00, param_01, param_02, param_03, param_04) {
  if(level.console) {
    var_05 = spawnhelicopter(param_01, param_03, param_04, "remote_uav_mp", "vehicle_remote_uav");
  } else {
    var_05 = spawnhelicopter(param_02, param_04, var_05, "remote_uav_mp_pc", "vehicle_remote_uav");
  }

  if(!isDefined(var_05)) {
    return undefined;
  }

  var_05 scripts\mp\killstreaks\_helicopter::addtolittlebirdlist();
  var_05 thread scripts\mp\killstreaks\_helicopter::func_E111();
  var_05 makevehiclesolidcapsule(18, -9, 18);
  var_05.lifeid = param_00;
  var_05.team = param_01.team;
  var_05.pers["team"] = param_01.team;
  var_05.triggerportableradarping = param_01;
  var_05 setotherent(param_01);
  var_05 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", param_01);
  var_05.maxhealth = 250;
  var_05.scrambler = spawn("script_model", param_03);
  var_05.scrambler linkto(var_05, "tag_origin", (0, 0, -160), (0, 0, 0));
  var_05.scrambler makescrambler(param_01);
  var_05.var_1037E = 0;
  var_05.inheliproximity = 0;
  var_05.helitype = "remote_uav";
  var_05.markedplayers = [];
  var_05 thread remoteuav_light_fx();
  var_05 thread remoteuav_explode_on_disconnect();
  var_05 thread remoteuav_explode_on_changeteams();
  var_05 thread remoteuav_explode_on_death();
  var_05 thread remoteuav_clear_marked_on_gameended();
  var_05 thread remoteuav_leave_on_timeout();
  var_05 thread func_DFAD();
  var_05 thread func_DFAE();
  var_05 thread remoteuav_handledamage();
  var_05.numflares = 2;
  var_05.hasincoming = 0;
  var_05.incomingmissiles = [];
  var_05 thread remoteuav_clearincomingwarning();
  var_05 thread remoteuav_handleincomingstinger();
  var_05 thread remoteuav_handleincomingsam();
  level.remote_uav[var_05.team] = var_05;
  return var_05;
}

remoteuav_ride(param_00, param_01, param_02) {
  param_01.playerlinked = 1;
  self.restoreangles = self.angles;
  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility::setthirdpersondof(0);
  }

  self cameralinkto(param_01, "tag_origin");
  self remotecontrolvehicle(param_01);
  thread remoteuav_playerexit(param_01);
  thread func_DFAA(param_01);
  thread remoteuav_fire(param_01);
  self.remote_uav_ridelifeid = param_00;
  self.remoteuav = param_01;
  thread remoteuav_delaylaunchdialog(param_01);
  self visionsetnakedforplayer("black_bw", 0);
  scripts\mp\utility::restorebasevisionset(1);
}

remoteuav_delaylaunchdialog(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  param_00 endon("death");
  param_00 endon("end_remote");
  param_00 endon("end_launch_dialog");
  wait(3);
  remoteuav_dialog("launch");
}

remoteuav_endride(param_00) {
  if(isDefined(param_00)) {
    param_00.playerlinked = 0;
    param_00 notify("end_remote");
    scripts\mp\utility::clearusingremote();
    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility::setthirdpersondof(1);
    }

    self cameraunlink(param_00);
    self remotecontrolvehicleoff(param_00);
    self thermalvisionoff();
    self setplayerangles(self.restoreangles);
    var_01 = scripts\engine\utility::getlastweapon();
    if(!self hasweapon(var_01)) {
      var_01 = scripts\mp\killstreaks\_utility::getfirstprimaryweapon();
    }

    scripts\mp\utility::_switchtoweapon(var_01);
    scripts\mp\utility::_takeweapon("uav_remote_mp");
    thread remoteuav_freezebuffer();
  }

  self.remoteuav = undefined;
}

remoteuav_freezebuffer() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  scripts\mp\utility::freezecontrolswrapper(1);
  wait(0.5);
  scripts\mp\utility::freezecontrolswrapper(0);
}

remoteuav_playerexit(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  param_00 endon("death");
  param_00 endon("end_remote");
  wait(2);
  for(;;) {
    var_01 = 0;
    while(self usebuttonpressed()) {
      var_01 = var_01 + 0.05;
      if(var_01 > 0.75) {
        param_00 thread remoteuav_leave();
        return;
      }

      wait(0.05);
    }

    wait(0.05);
  }
}

func_DFAA(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  param_00 endon("death");
  param_00 endon("end_remote");
  param_00.var_AA34 = 0;
  self.var_AEFB = undefined;
  self weaponlockfree();
  wait(1);
  for(;;) {
    var_01 = param_00 gettagorigin("tag_turret");
    var_02 = anglesToForward(self getplayerangles());
    var_03 = var_01 + var_02 * 1024;
    var_04 = bulletTrace(var_01, var_03, 1, param_00);
    if(isDefined(var_04["position"])) {
      var_05 = var_04["position"];
    } else {
      var_05 = var_03;
      var_04["endpos"] = var_03;
    }

    param_00.var_11A7B = var_04;
    var_06 = func_DFAB(param_00, level.players, var_05);
    var_07 = func_DFAB(param_00, level.turrets, var_05);
    var_08 = undefined;
    if(level.multiteambased) {
      var_09 = [];
      foreach(var_0B in level.teamnamelist) {
        if(var_0B != self.team) {
          foreach(var_0D in level.uavmodels[var_0B]) {
            var_09[var_09.size] = var_0D;
          }
        }
      }

      var_08 = func_DFAB(param_00, var_09, var_05);
    } else if(level.teambased) {
      var_08 = func_DFAB(param_00, level.uavmodels[level.otherteam[self.team]], var_05);
    } else {
      var_08 = func_DFAB(param_00, level.uavmodels, var_05);
    }

    var_10 = undefined;
    if(isDefined(var_06)) {
      var_10 = var_06;
    } else if(isDefined(var_07)) {
      var_10 = var_07;
    } else if(isDefined(var_08)) {
      var_10 = var_08;
    }

    if(isDefined(var_10)) {
      if(!isDefined(self.var_AEFB) || isDefined(self.var_AEFB) && self.var_AEFB != var_10) {
        self _meth_8402(var_10);
        self.var_AEFB = var_10;
        if(isDefined(var_06)) {
          param_00 notify("end_launch_dialog");
          remoteuav_dialog("track");
        }
      }
    } else {
      self weaponlockfree();
      self.var_AEFB = undefined;
    }

    wait(0.05);
  }
}

func_DFAB(param_00, param_01, param_02) {
  level endon("game_ended");
  var_03 = undefined;
  foreach(var_05 in param_01) {
    if(level.teambased && !isDefined(var_05.team) || var_05.team == self.team) {
      continue;
    }

    if(isplayer(var_05)) {
      if(!scripts\mp\utility::isreallyalive(var_05)) {
        continue;
      }

      if(var_05 == self) {
        continue;
      }

      var_06 = var_05.guid;
    } else {
      var_06 = var_05.var_64;
    }

    if(isDefined(var_05.sentrytype) || isDefined(var_05.var_12A9A)) {
      var_07 = (0, 0, 32);
      var_08 = "hud_fofbox_hostile_vehicle";
    } else if(isDefined(var_05.uavtype)) {
      var_07 = (0, 0, -52);
      var_08 = "hud_fofbox_hostile_vehicle";
    } else {
      var_07 = (0, 0, 26);
      var_08 = "veh_hud_target_unmarked";
    }

    if(isDefined(var_05.var_12AF4)) {
      if(!isDefined(param_00.markedplayers[var_06])) {
        param_00.markedplayers[var_06] = [];
        param_00.markedplayers[var_06]["player"] = var_05;
        param_00.markedplayers[var_06]["icon"] = var_05 scripts\mp\entityheadicons::setheadicon(self, "veh_hud_target_marked", var_07, 10, 10, 0, 0.05, 0, 0, 0, 0);
        param_00.markedplayers[var_06]["icon"].shader = "veh_hud_target_marked";
        if(!isDefined(var_05.sentrytype) || !isDefined(var_05.var_12A9A)) {
          param_00.markedplayers[var_06]["icon"] settargetent(var_05);
        }
      } else if(isDefined(param_00.markedplayers[var_06]) && isDefined(param_00.markedplayers[var_06]["icon"]) && isDefined(param_00.markedplayers[var_06]["icon"].shader) && param_00.markedplayers[var_06]["icon"].shader != "veh_hud_target_marked") {
        param_00.markedplayers[var_06]["icon"].shader = "veh_hud_target_marked";
        param_00.markedplayers[var_06]["icon"] setshader("veh_hud_target_marked", 10, 10);
        param_00.markedplayers[var_06]["icon"] setwaypoint(0, 0, 0, 0);
      }

      continue;
    }

    if(isplayer(var_05)) {
      var_09 = isDefined(var_05.spawntime) && gettime() - var_05.spawntime / 1000 <= 5;
      var_0A = var_05 scripts\mp\utility::_hasperk("specialty_blindeye");
      var_0B = 0;
      var_0C = 0;
    } else {
      var_09 = 0;
      var_0A = 0;
      var_0B = isDefined(var_07.carriedby);
      var_0C = isDefined(var_06.isleaving) && var_06.isleaving == 1;
    }

    if(!isDefined(param_00.markedplayers[var_06]) && !var_09 && !var_0A && !var_0B && !var_0C) {
      param_00.markedplayers[var_06] = [];
      param_00.markedplayers[var_06]["player"] = var_05;
      param_00.markedplayers[var_06]["icon"] = var_05 scripts\mp\entityheadicons::setheadicon(self, var_08, var_07, 10, 10, 0, 0.05, 0, 0, 0, 0);
      param_00.markedplayers[var_06]["icon"].shader = var_08;
      if(!isDefined(var_05.sentrytype) || !isDefined(var_05.var_12A9A)) {
        param_00.markedplayers[var_06]["icon"] settargetent(var_05);
      }
    }

    if(((!isDefined(var_03) || var_03 != var_05) && isDefined(param_00.var_11A7B["entity"]) && param_00.var_11A7B["entity"] == var_05 && !var_0B && !var_0C) || distance(var_05.origin, param_02) < 200 * param_00.var_11A7B["fraction"] && !var_09 && !var_0B && !var_0C || !var_0C && remoteuav_cantargetuav(param_00, var_05)) {
      var_0D = bulletTrace(param_00.origin, var_05.origin + (0, 0, 32), 1, param_00);
      if((isDefined(var_0D["entity"]) && var_0D["entity"] == var_05) || var_0D["fraction"] == 1) {
        self playlocalsound("recondrone_lockon");
        var_03 = var_05;
      }
    }
  }

  return var_03;
}

remoteuav_cantargetuav(param_00, param_01) {
  if(isDefined(param_01.uavtype)) {
    var_02 = anglesToForward(self getplayerangles());
    var_03 = vectornormalize(param_01.origin - param_00 gettagorigin("tag_turret"));
    var_04 = vectordot(var_02, var_03);
    if(var_04 > 0.985) {
      return 1;
    }
  }

  return 0;
}

remoteuav_fire(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  level endon("game_ended");
  param_00 endon("end_remote");
  wait(1);
  self notifyonplayercommand("remoteUAV_tag", "+attack");
  self notifyonplayercommand("remoteUAV_tag", "+attack_akimbo_accessible");
  for(;;) {
    self waittill("remoteUAV_tag");
    if(isDefined(self.var_AEFB)) {
      self playlocalsound("recondrone_tag");
      scripts\mp\damagefeedback::updatedamagefeedback("");
      thread remoteuav_markplayer(self.var_AEFB);
      thread remoteuav_rumble(param_00, 3);
      wait(0.25);
      continue;
    }

    wait(0.05);
  }
}

remoteuav_rumble(param_00, param_01) {
  self endon("disconnect");
  param_00 endon("death");
  level endon("game_ended");
  param_00 endon("end_remote");
  param_00 notify("end_rumble");
  param_00 endon("end_rumble");
  for(var_02 = 0; var_02 < param_01; var_02++) {
    self playrumbleonentity("damage_heavy");
    wait(0.05);
  }
}

remoteuav_markplayer(param_00) {
  level endon("game_ended");
  param_00.var_12AF4 = self;
  if(isplayer(param_00) && !param_00 scripts\mp\utility::isusingremote()) {
    param_00 playlocalsound("player_hit_while_ads_hurt");
    param_00 thread scripts\mp\flashgrenades::func_20CA(2, 1);
    param_00 thread scripts\mp\rank::scoreeventpopup("marked_by_remote_uav");
  } else if(isDefined(param_00.uavtype)) {
    param_00.var_2B0C = param_00.var_64;
  } else if(isDefined(param_00.triggerportableradarping) && isalive(param_00.triggerportableradarping)) {
    param_00.triggerportableradarping thread scripts\mp\rank::scoreeventpopup("turret_marked_by_remote_uav");
  }

  remoteuav_dialog("tag");
  if(level.gametype != "dm") {
    if(isplayer(param_00)) {
      thread scripts\mp\utility::giveunifiedpoints("kill");
    }
  }

  if(isplayer(param_00)) {
    param_00 setperk("specialty_radarblip", 1);
  } else {
    if(isDefined(param_00.uavtype)) {
      var_01 = "compassping_enemy_uav";
    } else {
      var_01 = "compassping_sentry_enemy";
    }

    if(level.teambased) {
      var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
      if(var_02 != -1) {
        scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02, param_00);
        scripts\mp\objidpoolmanager::minimap_objective_state(var_02, "active");
        scripts\mp\objidpoolmanager::minimap_objective_team(var_02, self.team);
        scripts\mp\objidpoolmanager::minimap_objective_icon(var_02, var_01);
      }

      param_00.var_DFAF = var_02;
    } else {
      var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
      if(var_02 != -1) {
        scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02, param_00);
        scripts\mp\objidpoolmanager::minimap_objective_state(var_02, "active");
        scripts\mp\objidpoolmanager::minimap_objective_team(var_02, level.otherteam[self.team]);
        scripts\mp\objidpoolmanager::minimap_objective_icon(var_02, var_01);
      }

      param_00.var_DFB0 = var_02;
      var_02 = scripts\mp\objidpoolmanager::requestminimapid(1);
      if(var_02 != -1) {
        scripts\mp\objidpoolmanager::minimap_objective_add(var_02, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::minimap_objective_onentity(var_02, param_00);
        scripts\mp\objidpoolmanager::minimap_objective_state(var_02, "active");
        scripts\mp\objidpoolmanager::minimap_objective_team(var_02, self.team);
        scripts\mp\objidpoolmanager::minimap_objective_icon(var_02, var_01);
      }

      param_00.var_DFB1 = var_02;
    }
  }

  param_00 thread func_DFAC(self.remoteuav);
}

remoteuav_processtaggedassist(param_00) {
  remoteuav_dialog("assist");
  if(level.gametype != "dm") {
    self.var_113FF = 1;
    if(isDefined(param_00)) {
      thread scripts\mp\gamescore::processassist(param_00);
      return;
    }

    thread scripts\mp\utility::giveunifiedpoints("assist");
  }
}

func_DFAC(param_00) {
  level endon("game_ended");
  var_01 = scripts\engine\utility::waittill_any_return("death", "disconnect", "carried", "leaving");
  if(var_01 == "leaving" || !isDefined(self.uavtype)) {
    self.var_12AF4 = undefined;
  }

  if(isDefined(param_00)) {
    if(isplayer(self)) {
      var_02 = self.guid;
    } else if(isDefined(self.var_64)) {
      var_02 = self.var_64;
    } else {
      var_02 = self.var_2B0C;
    }

    if(var_01 == "carried" || var_01 == "leaving") {
      param_00.markedplayers[var_02]["icon"] destroy();
      param_00.markedplayers[var_02]["icon"] = undefined;
    }

    if(isDefined(var_02) && isDefined(param_00.markedplayers[var_02])) {
      param_00.markedplayers[var_02] = undefined;
      param_00.markedplayers = scripts\engine\utility::array_removeundefined(param_00.markedplayers);
    }
  }

  if(isplayer(self)) {
    self unsetperk("specialty_radarblip", 1);
    return;
  }

  if(isDefined(self.var_DFAF)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.var_DFAF);
  }

  if(isDefined(self.var_DFB0)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.var_DFB0);
  }

  if(isDefined(self.var_DFB1)) {
    scripts\mp\objidpoolmanager::returnminimapid(self.var_DFB1);
  }
}

remoteuav_clearmarkedforowner() {
  foreach(var_01 in self.markedplayers) {
    if(isDefined(var_01["icon"])) {
      var_01["icon"] destroy();
      var_01["icon"] = undefined;
    }
  }

  self.markedplayers = undefined;
}

remoteuav_operationrumble(param_00) {
  self endon("disconnect");
  param_00 endon("death");
  level endon("game_ended");
  param_00 endon("end_remote");
  for(;;) {
    self playrumbleonentity("damage_light");
    wait(0.5);
  }
}

func_DFAD() {
  self endon("death");
  self.rangetrigger = getent("remote_uav_range", "targetname");
  if(!isDefined(self.rangetrigger)) {
    var_00 = getent("airstrikeheight", "targetname");
    self.maxheight = var_00.origin[2];
    self.maxdistance = 12800;
  }

  self.centerref = spawn("script_model", level.mapcenter);
  var_01 = self.origin;
  self.var_DCCE = 0;
  for(;;) {
    if(!remoteuav_in_range()) {
      var_02 = 0;
      while(!remoteuav_in_range()) {
        self.triggerportableradarping remoteuav_dialog("out_of_range");
        if(!self.var_DCCE) {
          self.var_DCCE = 1;
          thread remoteuav_rangecountdown();
        }

        if(isDefined(self.heliinproximity)) {
          var_03 = distance(self.origin, self.heliinproximity.origin);
          var_02 = 1 - var_03 - 150 / 150;
        } else {
          var_03 = distance(self.origin, var_01);
          var_02 = min(1, var_03 / 200);
        }

        self.triggerportableradarping setplayerdata("reconDroneState", "staticAlpha", var_02);
        wait(0.05);
      }

      self notify("in_range");
      self.var_DCCE = 0;
      thread remoteuav_staticfade(var_02);
    }

    var_01 = self.origin;
    wait(0.05);
  }
}

remoteuav_in_range() {
  if(isDefined(self.rangetrigger)) {
    if(!self istouching(self.rangetrigger) && !self.inheliproximity) {
      return 1;
    }
  } else if(distance2d(self.origin, level.mapcenter) < self.maxdistance && self.origin[2] < self.maxheight && !self.inheliproximity) {
    return 1;
  }

  return 0;
}

remoteuav_staticfade(param_00) {
  self endon("death");
  while(remoteuav_in_range()) {
    param_00 = param_00 - 0.05;
    if(param_00 < 0) {
      self.triggerportableradarping setplayerdata("reconDroneState", "staticAlpha", 0);
      break;
    }

    self.triggerportableradarping setplayerdata("reconDroneState", "staticAlpha", param_00);
    wait(0.05);
  }
}

remoteuav_rangecountdown() {
  self endon("death");
  self endon("in_range");
  if(isDefined(self.heliinproximity)) {
    var_00 = 3;
  } else {
    var_00 = 6;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self notify("death");
}

remoteuav_explode_on_disconnect() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  self notify("death");
}

remoteuav_explode_on_changeteams() {
  self endon("death");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators");
  self notify("death");
}

remoteuav_clear_marked_on_gameended() {
  self endon("death");
  level waittill("game_ended");
  remoteuav_clearmarkedforowner();
}

remoteuav_leave_on_timeout() {
  self endon("death");
  var_00 = 60;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  thread remoteuav_leave();
}

remoteuav_leave() {
  level endon("game_ended");
  self endon("death");
  self notify("leaving");
  self.triggerportableradarping remoteuav_endride(self);
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
  if(self.playerlinked == 1 && isDefined(self.triggerportableradarping)) {
    self.triggerportableradarping remoteuav_endride(self);
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
  scripts\mp\utility::decrementfauxvehiclecount();
  self delete();
}

remoteuav_light_fx() {
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_nose");
  wait(0.05);
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
}

remoteuav_dialog(param_00) {
  if(param_00 == "tag") {
    var_01 = 1000;
  } else {
    var_01 = 5000;
  }

  if(gettime() - level.remoteuav_lastdialogtime < var_01) {
    return;
  }

  level.remoteuav_lastdialogtime = gettime();
  var_02 = randomint(level.remoteuav_dialog[param_00].size);
  var_03 = level.remoteuav_dialog[param_00][var_02];
  var_04 = scripts\mp\teams::getteamvoiceprefix(self.team) + var_03;
  self playlocalsound(var_04);
}

remoteuav_handleincomingstinger() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");
  for(;;) {
    level waittill("stinger_fired", var_00, var_01, var_02);
    if(!isDefined(var_01) || !isDefined(var_02) || var_02 != self) {
      continue;
    }

    self.triggerportableradarping playlocalsound("javelin_clu_lock");
    self.triggerportableradarping setplayerdata("reconDroneState", "incomingMissile", 1);
    self.hasincoming = 1;
    self.incomingmissiles[self.incomingmissiles.size] = var_01;
    var_01.triggerportableradarping = var_00;
    var_01 thread watchstingerproximity(var_02);
  }
}

remoteuav_handleincomingsam() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");
  for(;;) {
    level waittill("sam_fired", var_00, var_01, var_02);
    if(!isDefined(var_02) || var_02 != self) {
      continue;
    }

    var_03 = 0;
    foreach(var_05 in var_01) {
      if(isDefined(var_05)) {
        self.incomingmissiles[self.incomingmissiles.size] = var_05;
        var_05.triggerportableradarping = var_00;
        var_03++;
      }
    }

    if(var_03) {
      self.triggerportableradarping playlocalsound("javelin_clu_lock");
      self.triggerportableradarping setplayerdata("reconDroneState", "incomingMissile", 1);
      self.hasincoming = 1;
      level thread watchsamproximity(var_02, var_01);
    }
  }
}

watchstingerproximity(param_00) {
  level endon("game_ended");
  self endon("death");
  self missile_settargetent(param_00);
  var_01 = vectornormalize(param_00.origin - self.origin);
  while(isDefined(param_00)) {
    var_02 = param_00 getpointinbounds(0, 0, 0);
    var_03 = distance(self.origin, var_02);
    if(param_00.numflares > 0 && var_03 < 4000) {
      var_04 = param_00 deployflares();
      self missile_settargetent(var_04);
      return;
    } else {
      var_04 = vectornormalize(var_01.origin - self.origin);
      if(vectordot(var_04, var_02) < 0) {
        self playSound("exp_stinger_armor_destroy");
        playFX(level.remoteuav_fx["missile_explode"], self.origin);
        if(isDefined(self.triggerportableradarping)) {
          radiusdamage(self.origin, 400, 1000, 1000, self.triggerportableradarping, "MOD_EXPLOSIVE", "stinger_mp");
        } else {
          radiusdamage(self.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");
        }

        self hide();
        wait(0.05);
        self delete();
        continue;
      }

      var_02 = var_04;
    }

    wait(0.05);
  }
}

watchsamproximity(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("death");
  foreach(var_03 in param_01) {
    if(isDefined(var_03)) {
      var_03 missile_settargetent(param_00);
      var_03.lastvectotarget = vectornormalize(param_00.origin - var_03.origin);
    }
  }

  while(param_01.size && isDefined(param_00)) {
    var_05 = param_00 getpointinbounds(0, 0, 0);
    foreach(var_0D, var_03 in param_01) {
      if(isDefined(var_03)) {
        if(isDefined(self.markfordetete)) {
          self delete();
          continue;
        }

        if(param_00.numflares > 0) {
          var_07 = distance(var_03.origin, var_05);
          if(var_07 < 4000) {
            var_08 = param_00 deployflares();
            foreach(var_0A in param_01) {
              if(isDefined(var_0A)) {
                var_0A missile_settargetent(var_08);
              }
            }

            return;
          }

          continue;
        }

        var_0C = vectornormalize(var_04.origin - var_0D.origin);
        if(vectordot(var_0C, var_0D.lastvectotarget) < 0) {
          var_0D playSound("exp_stinger_armor_destroy");
          playFX(level.remoteuav_fx["missile_explode"], var_0D.origin);
          if(isDefined(var_0D.triggerportableradarping)) {
            radiusdamage(var_0D.origin, 400, 1000, 1000, var_0D.triggerportableradarping, "MOD_EXPLOSIVE", "stinger_mp");
          } else {
            radiusdamage(var_0D.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");
          }

          var_0D hide();
          var_0D.markfordetete = 1;
        } else {
          var_0D.lastvectotarget = var_0C;
        }
      }
    }

    var_05 = scripts\engine\utility::array_removeundefined(var_05);
    wait(0.05);
  }
}

deployflares() {
  self.numflares--;
  self.triggerportableradarping thread remoteuav_rumble(self, 6);
  self playSound("WEAP_SHOTGUNATTACH_FIRE_NPC");
  thread playflarefx();
  var_00 = self.origin + (0, 0, -100);
  var_01 = spawn("script_origin", var_00);
  var_01.angles = self.angles;
  var_01 movegravity((0, 0, -1), 5);
  var_01 thread deleteaftertime(5);
  return var_01;
}

playflarefx() {
  for(var_00 = 0; var_00 < 5; var_00++) {
    if(!isDefined(self)) {
      return;
    }

    playFXOnTag(level._effect["vehicle_flares"], self, "TAG_FLARE");
    wait(0.15);
  }
}

deleteaftertime(param_00) {
  wait(param_00);
  self delete();
}

remoteuav_clearincomingwarning() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");
  for(;;) {
    var_00 = 0;
    for(var_01 = 0; var_01 < self.incomingmissiles.size; var_01++) {
      if(isDefined(self.incomingmissiles[var_01]) && missile_isincoming(self.incomingmissiles[var_01], self)) {
        var_00++;
      }
    }

    if(self.hasincoming && !var_00) {
      self.hasincoming = 0;
      self.triggerportableradarping setplayerdata("reconDroneState", "incomingMissile", 0);
    }

    self.incomingmissiles = scripts\engine\utility::array_removeundefined(self.incomingmissiles);
    wait(0.05);
  }
}

missile_isincoming(param_00, param_01) {
  var_02 = vectornormalize(param_01.origin - param_00.origin);
  var_03 = anglesToForward(param_00.angles);
  return vectordot(var_02, var_03) > 0;
}

func_DFAE() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");
  for(;;) {
    var_00 = 0;
    foreach(var_02 in level.helis) {
      if(distance(var_02.origin, self.origin) < 300) {
        var_00 = 1;
        self.heliinproximity = var_02;
      }
    }

    foreach(var_05 in level.littlebirds) {
      if(var_05 != self && !isDefined(var_05.helitype) || var_05.helitype != "remote_uav" && distance(var_05.origin, self.origin) < 300) {
        var_00 = 1;
        self.heliinproximity = var_05;
      }
    }

    if(!self.inheliproximity && var_00) {
      self.inheliproximity = 1;
    } else if(self.inheliproximity && !var_00) {
      self.inheliproximity = 0;
      self.heliinproximity = undefined;
    }

    wait(0.05);
  }
}

remoteuav_handledamage() {
  self endon("end_remote");
  scripts\mp\damage::monitordamage(self.maxhealth, "remote_uav", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\damage::handleempdamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handlemissiledamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  playfxontagforclients(level.remoteuav_fx["hit"], self, "tag_origin", self.triggerportableradarping);
  self playSound("recondrone_damaged");
  if(self.var_1037E == 0 && self.var_E1 >= self.maxhealth / 2) {
    self.var_1037E = 1;
    playFXOnTag(level.remoteuav_fx["smoke"], self, "tag_origin");
  }

  return var_05;
}

handledeathdamage(param_00, param_01, param_02, param_03) {
  scripts\mp\damage::onkillstreakkilled("remote_uav", param_00, param_01, param_02, param_03, "destroyed_remote_uav", undefined, "callout_destroyed_remote_uav");
}