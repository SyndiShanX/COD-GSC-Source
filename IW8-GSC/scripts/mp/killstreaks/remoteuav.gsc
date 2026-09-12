/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\remoteuav.gsc
************************************************/

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
  level.remote_uav = [];
}

function useremoteuav(var_0, var_1) {
  return tryuseremoteuav(var_0, "remote_uav");
}

function exceededmaxremoteuavs(var_0) {
  if(scripts\mp\utility\game::getgametype() == "dm") {
    if(isDefined(level.remote_uav[var_0]) || isDefined(level.remote_uav[scripts\mp\utility\game::getotherteam(var_0)[0]])) {
      return 1;
    }

    return 0;
  }

  if(isDefined(level.remote_uav[var_0])) {
    return 1;
  }

  return 0;
}

function tryuseremoteuav(var_0, var_1) {
  scripts\common\utility::allow_usability(0);

  if(scripts\mp\utility\player::isusingremote() || self isusingturret() || isDefined(level.nukeincoming)) {
    scripts\common\utility::allow_usability(1);
    return 0;
  }

  var_2 = 1;

  if(exceededmaxremoteuavs(self.team) || level.littlebirds.size >= 4) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    scripts\common\utility::allow_usability(1);
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var_2 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    scripts\common\utility::allow_usability(1);
    return 0;
  }

  self setplayerdata("reconDroneState", "staticAlpha", 0);
  self setplayerdata("reconDroneState", "incomingMissile", 0);
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var_3 = givecarryremoteuav(var_0, var_1);

  if(var_3) {
    scripts\common\utility::ref_13E0A(level.ref_11B2A, var_1, self.origin);
    thread scripts\mp\hud_util::teamplayercardsplash("used_remote_uav", self);
  } else {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  }

  self.iscarrying = 0;
  return var_3;
}

function givecarryremoteuav(var_0, var_1) {
  var_2 = createcarryremoteuav(var_1, self);
  scripts\cp_mp\utility\inventory_utility::_takeweapon("killstreak_uav_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon("killstreak_remote_uav_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("killstreak_remote_uav_mp");
  setcarryingremoteuav(var_2);

  if(isalive(self) && isDefined(var_2)) {
    var_3 = var_2.origin;
    var_4 = self.angles;
    var_2.soundent delete();
    var_2 delete();
    var_5 = startremoteuav(var_0, var_1, var_3, var_4);
  } else {
    var_5 = 0;

    if(isalive(self)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("killstreak_remote_uav_mp");
      scripts\cp_mp\utility\inventory_utility::_giveweapon("killstreak_uav_mp");
    }
  }

  return var_5;
}

function createcarryremoteuav(var_0, var_1) {
  var_2 = var_1.origin + anglesToForward(var_1.angles) * 4 + anglestoup(var_1.angles) * 50;
  var_3 = spawnturret("misc_turret", var_2, "sentry_minigun_mp");
  var_3.origin = var_2;
  var_3.angles = var_1.angles;
  var_3.sentrytype = "sentry_minigun";
  var_3.canbeplaced = 1;
  var_3 setturretmodechangewait(1);
  var_3 setmode("sentry_offline");
  var_3 makeunusable();
  var_3 maketurretinoperable();
  var_3.owner = var_1;
  var_3 setsentryowner(var_3.owner);
  var_3.scale = 3;
  var_3.inheliproximity = 0;
  thread carryremoteuav_handleexistence();
  var_3.rangetrigger = getEnt("remote_uav_range", "targetname");

  if(!isDefined(var_3.rangetrigger)) {
    var_4 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
    var_3.maxheight = var_4.origin[2];
    var_3.maxdistance = 3600;
  }

  var_3.soundent = spawn("script_origin", var_3.origin);
  var_3.soundent.angles = var_3.angles;
  var_3.soundent.origin = var_3.origin;
  var_3.soundent linkTo(var_3);
  var_3.soundent playLoopSound("recondrone_idle_high");
  return var_3;
}

function setcarryingremoteuav(var_0) {
  thread carryremoteuav_setcarried(var_0);
  self notifyonplayercommand("place_carryRemoteUAV", "+attack");
  self notifyonplayercommand("place_carryRemoteUAV", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 4");
  jumpiftrue(self isconsoleplayer()) LOC_0000006c;
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 5");
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 6");
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 7");

  for(;;) {
    var_1 = ref_11969("place_carryRemoteUAV", "cancel_carryRemoteUAV", "weapon_switch_started", "force_cancel_placement", "death_or_disconnect");
    self forceusehintoff();

    if(var_1 != "place_carryRemoteUAV") {
      carryremoteuav_delete(var_0);
      break;
    }

    if(!var_0.canbeplaced) {
      if(self.team != "spectator") {
        self forceusehinton(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
      }

      continue;
    }

    if(exceededmaxremoteuavs(self.team) || scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
      self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
      carryremoteuav_delete(var_0);
      break;
    }

    self.iscarrying = 0;
    var_0.carriedby = undefined;
    var_0 playSound("sentry_gun_plant");
    var_0 notify("placed");
    break;
  }
}

function ref_11969(var_0, var_1, var_2, var_3, var_4, var_5) {
  if((!isDefined(var_0) || var_0 != "death") && (!isDefined(var_1) || var_1 != "death") && (!isDefined(var_2) || var_2 != "death") && (!isDefined(var_3) || var_3 != "death") && (!isDefined(var_4) || var_4 != "death")) {
    self endon("death");
  }

  var_6 = spawnStruct();

  if(isDefined(var_0)) {
    thread scripts\engine\utility::waittill_string(var_0, var_6);
  }

  if(isDefined(var_1)) {
    thread scripts\engine\utility::waittill_string(var_1, var_6);
  }

  if(isDefined(var_2)) {
    thread scripts\engine\utility::waittill_string(var_2, var_6);
  }

  if(isDefined(var_3)) {
    thread scripts\engine\utility::waittill_string(var_3, var_6);
  }

  if(isDefined(var_4)) {
    thread scripts\engine\utility::waittill_string(var_4, var_6);
  }

  jumpiffalse(isDefined(var_5)) LOC_000000b4;
  thread scripts\engine\utility::waittill_string(var_5, var_6);
  var_6 waittill("returned", var_7);
  var_6 notify("die");
  return var_7;
}

function carryremoteuav_setcarried(var_0) {
  self setCanDamage(0);
  self setsentrycarrier(var_0);
  self notsolid();
  self.carriedby = var_0;
  var_0.iscarrying = 1;
  thread updatecarryremoteuavplacement(var_0);
  self notify("carried");
}

function carryremoteuav_delete(var_0) {
  self.iscarrying = 0;

  if(isDefined(var_0)) {
    if(isDefined(var_0.soundent)) {
      var_0.soundent delete();
    }

    var_0 delete();
    return;
  }
}

function isinremotenodeploy() {
  if(isDefined(level.remoteuav_nodeployzones) && level.remoteuav_nodeployzones.size) {
    foreach(var_1 in level.remoteuav_nodeployzones) {
      if(self istouching(var_1)) {
        return true;
      }
    }
  }

  return false;
}

function updatecarryremoteuavplacement(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 endon("placed");
  var_0 endon("death");
  var_0.canbeplaced = 1;
  var_1 = -1;
  scripts\common\utility::allow_usability(1);

  for(;;) {
    var_2 = 18;

    switch (self getstance()) {
      case "stand":
        var_2 = 40;
        break;
      case "crouch":
        var_2 = 25;
        break;
      case "prone":
        var_2 = 10;
        break;
    }

    var_3 = self canplayerplacetank(22, 22, 50, var_2, 0, 0);
    var_0.origin = var_3["origin"] + anglestoup(self.angles) * 27;
    var_0.angles = var_3["angles"];
    var_0.canbeplaced = self isonground() && var_3["result"] && remoteuav_in_range(var_0) && !isinremotenodeploy(var_0);

    if(var_0.canbeplaced != var_1) {
      if(var_0.canbeplaced) {
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

    var_1 = var_0.canbeplaced;
    waitframe();
  }
}

function carryremoteuav_handleexistence() {
  level endon("game_ended");
  self.owner endon("place_carryRemoteUAV");
  self.owner endon("cancel_carryRemoteUAV");
  self.owner scripts\engine\utility::ref_143A6("death_or_disconnect", "joined_team", "joined_spectators");

  if(isDefined(self)) {
    if(isDefined(self.soundent)) {
      self.soundent delete();
    }

    self delete();
    return;
  }
}

function removeremoteweapon() {
  level endon("game_ended");
  self endon("disconnect");
  wait 0.7;
}

function startremoteuav(var_0, var_1, var_2, var_3) {
  lockplayerforremoteuavlaunch();
  scripts\mp\utility\player::setusingremote(var_1);
  scripts\cp_mp\utility\inventory_utility::_giveweapon("uav_remote_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("uav_remote_mp");
  self visionsetnakedforplayer("black_bw", 0);
  var_4 = scripts\mp\killstreaks\killstreaks::initridekillstreak("remote_uav");

  if(var_4 != "success") {
    if(var_4 != "disconnect") {
      self notify("remoteuav_unlock");
      scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
      scripts\mp\utility\player::clearusingremote();
    }

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
  var_5 = createremoteuav(var_0, self, var_1, var_2, var_3);

  if(isDefined(var_5)) {
    thread remoteuav_ride(var_0, var_5, var_1);
    return 1;
  }

  self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
  scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
  scripts\mp\utility\player::clearusingremote();
  return 0;
}

function lockplayerforremoteuavlaunch() {
  var_0 = spawn("script_origin", self.origin);
  var_0 hide();
  self playerlinkTo(var_0);
  thread clearplayerlockfromremoteuavlaunch(var_0);
}

function clearplayerlockfromremoteuavlaunch(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::ref_143AD("death_or_disconnect", "remoteuav_unlock");

  if(var_1 != "disconnect") {
    self unlink();
  }

  var_0 delete();
}

function createremoteuav(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 isconsoleplayer()) {
    var_5 = spawnhelicopter(var_1, var_3, var_4, "remote_uav_mp", "vehicle_remote_uav");
  } else {
    var_5 = spawnhelicopter(var_2, var_4, var_5, "remote_uav_mp_pc", "vehicle_remote_uav");
  }

  if(!isDefined(var_5)) {
    return undefined;
  }

  var_5 makevehiclesolidcapsule(18, -9, 18);
  var_5.lifeid = var_1;
  var_5.team = var_2.team;
  var_5.pers["team"] = var_2.team;
  var_5.owner = var_2;
  var_5 setotherent(var_2);
  var_5 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_2);
  var_5.maxhealth = 250;
  var_5.scrambler = spawn("script_model", var_4);
  var_5.scrambler linkTo(var_5, "tag_origin", (0, 0, -160), (0, 0, 0));
  var_5.scrambler makescrambler(var_2);
  var_5.smoking = 0;
  var_5.inheliproximity = 0;
  var_5.helitype = "remote_uav";
  var_5.markedplayers = [];
  thread remoteuav_light_fx();
  thread remoteuav_explode_on_disconnect();
  thread remoteuav_explode_on_changeteams();
  thread remoteuav_explode_on_death();
  thread remoteuav_clear_marked_on_gameended();
  thread remoteuav_leave_on_timeout();
  thread remoteuav_watch_distance();
  thread remoteuav_watchheliproximity();
  thread remoteuav_handledamage();
  var_5.numflares = 2;
  var_5.hasincoming = 0;
  var_5.incomingmissiles = [];
  thread remoteuav_clearincomingwarning();
  thread remoteuav_handleincomingstinger();
  thread remoteuav_handleincomingsam();
  level.remote_uav[var_5.team] = var_5;
  return var_5;
}

function remoteuav_ride(var_0, var_1, var_2) {
  var_1.playerlinked = 1;
  self.restoreangles = self.angles;

  if(getdvarint("camera_thirdPerson")) {
    scripts\mp\utility\player::setthirdpersondof(0);
  }

  self cameralinkTo(var_1, "tag_origin");
  self remotecontrolvehicle(var_1);
  thread remoteuav_playerexit(var_1);
  thread remoteuav_track(var_1);
  thread remoteuav_fire(var_1);
  self.remote_uav_ridelifeid = var_0;
  self.remoteuav = var_1;
  thread remoteuav_delaylaunchdialog(var_1);
  self visionsetnakedforplayer("black_bw", 0);
  scripts\mp\utility\player::restorebasevisionset(1);
}

function remoteuav_delaylaunchdialog(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_0 endon("end_launch_dialog");
  wait 3;
  remoteuav_dialog("launch");
}

function remoteuav_endride(var_0) {
  if(isDefined(var_0)) {
    var_0.playerlinked = 0;
    var_0 notify("end_remote");
    scripts\mp\utility\player::clearusingremote();

    if(getdvarint("camera_thirdPerson")) {
      scripts\mp\utility\player::setthirdpersondof(1);
    }

    self cameraunlink(var_0);
    self remotecontrolvehicleoff(var_0);
    self thermalvisionoff();
    self setplayerangles(self.restoreangles);
    var_1 = scripts\mp\utility\inventory::getlastweapon();

    if(!self hasweapon(var_1)) {
      var_1 = scripts\mp\utility\inventory::getfirstprimaryweapon();
    }

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_1);
    scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
    thread remoteuav_freezebuffer();
  }

  self.remoteuav = undefined;
}

function remoteuav_freezebuffer() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_freezecontrols(1);
  wait 0.5;
  scripts\mp\utility\player::_freezecontrols(0);
}

function remoteuav_playerexit(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  wait 2;
  var_1 = level.framedurationseconds;

  for(;;) {
    var_2 = 0;

    while(self useButtonPressed()) {
      var_2 += var_1;

      if(var_2 > 0.75) {
        thread remoteuav_leave();
        return;
      }

      wait var_1;
    }

    waitframe();
  }
}

function remoteuav_track(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 endon("death");
  var_0 endon("end_remote");
  var_0.lasttrackingdialogtime = 0;
  self.lockedtarget = undefined;
  self weaponlockfree();
  wait 1;

  for(;;) {
    var_1 = var_0 gettagorigin("tag_turret");
    var_2 = anglesToForward(self getplayerangles());
    var_3 = var_1 + var_2 * 1024;
    var_4 = scripts\engine\trace::_bullet_trace(var_1, var_3, 1, var_0);

    if(isDefined(var_4["position"])) {
      var_5 = var_4["position"];
    } else {
      var_5 = var_3;
      var_4 = var_3;
    }

    var_0.trace = var_4;
    var_6 = remoteuav_trackentities(var_0, level.players, var_5);
    var_7 = remoteuav_trackentities(var_0, level.turrets, var_5);
    var_8 = undefined;

    if(level.teambased) {
      var_9 = undefined;
      var_10 = [];
      var_11 = scripts\mp\utility\teams::getenemyteams(self.team);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
        var_9 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
      }

      jumpiffalse(istrue(var_9) && getdvarint("scr_uav_for_squad_only", 1)) LOC_000001b3;

      foreach(var_13 in level.teamnamelist) {
        foreach(var_15 in level.squaddata[var_13]) {
          var_16 = var_13 + var_20;

          foreach(var_18 in level.uavmodels[var_16]) {
            var_10 = var_18;
          }
        }
      }

      goto LOC_0000020e;
    } else {
      var_27 = remoteuav_trackentities(var_1, level.uavmodels, var_6);
    }

    var_9 = undefined;

    if(isDefined(var_7)) {
      var_9 = var_7;
    } else if(isDefined(var_8)) {
      var_9 = var_8;
    } else if(isDefined(var_27)) {
      var_9 = var_27;
    }

    if(isDefined(var_9)) {
      if(!isDefined(self.lockedtarget) || isDefined(self.lockedtarget) && self.lockedtarget != var_9) {
        self weaponlockfinalize(var_9);
        self.lockedtarget = var_9;

        if(isDefined(var_7)) {
          var_1 notify("end_launch_dialog");
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

function remoteuav_trackentities(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = undefined;

  foreach(var_14, var_5 in var_1) {
    if(level.teambased && (!isDefined(var_5.team) || var_5.team == self.team)) {
      continue;
    }

    if(isPlayer(var_5)) {
      if(!scripts\mp\utility\player::isreallyalive(var_5)) {
        continue;
      }

      if(var_5 == self) {
        continue;
      }

      var_6 = var_5.guid;
    } else {
      var_6 = var_5.birthtime;
    }

    if(isDefined(var_5.sentrytype) || isDefined(var_5.turrettype)) {
      var_7 = 32;
      var_8 = "hud_fofbox_hostile_vehicle";
    } else if(isDefined(var_5.uavtype)) {
      var_7 = -52;
      var_8 = "hud_fofbox_hostile_vehicle";
    } else {
      var_7 = 26;
      var_8 = "veh_hud_target_unmarked";
    }

    if(isDefined(var_5.uavremotemarkedby)) {
      if(!isDefined(var_0.markedplayers[var_6])) {
        var_0.markedplayers[var_6] = [];
        var_0.markedplayers[var_6]["player"] = var_5;
        var_0.markedplayers[var_6]["icon"] = var_5 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "veh_hud_target_marked", var_7);
        var_0.markedplayers[var_6]["icon"].shader = "veh_hud_target_marked";

        if(!isDefined(var_5.sentrytype) || !isDefined(var_5.turrettype)) {
          var_0.markedplayers[var_6]["icon"] settargetEnt(var_5);
        }
      } else if(isDefined(var_0.markedplayers[var_6]) && isDefined(var_0.markedplayers[var_6]["icon"]) && isDefined(var_0.markedplayers[var_6]["icon"].shader) && var_0.markedplayers[var_6]["icon"].shader != "veh_hud_target_marked") {
        var_0.markedplayers[var_6]["icon"].shader = "veh_hud_target_marked";
        var_0.markedplayers[var_6]["icon"] setshader("veh_hud_target_marked", 10, 10);
        var_0.markedplayers[var_6]["icon"] setwaypoint(0, 0, 0, 0);
      }

      continue;
    }

    if(isPlayer(var_5)) {
      var_9 = isDefined(var_5.spawntime) && (gettime() - var_5.spawntime) / 1000 <= 5;
      var_10 = var_5 scripts\mp\utility\perk::_hasperk("specialty_blindeye");
      var_11 = 0;
      var_12 = 0;
    } else {
      var_9 = 0;
      var_10 = 0;
      var_11 = isDefined(var_14.carriedby);
      var_12 = isDefined(var_14.isleaving) && var_14.isleaving == 1;
    }

    if(!isDefined(var_4.markedplayers[var_9]) && !var_9 && !var_10 && !var_11 && !var_12) {
      var_4.markedplayers[var_9] = [];
      var_4.markedplayers[var_9]["player"] = var_14;
      var_4.markedplayers[var_9]["icon"] = var_14 scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, var_11, var_10);
      var_4.markedplayers[var_9]["icon"].shader = var_11;

      if(!isDefined(var_14.sentrytype) || !isDefined(var_14.turrettype)) {
        var_4.markedplayers[var_9]["icon"] settargetEnt(var_14);
      }
    }

    if((!isDefined(var_7) || var_7 != var_14) && isDefined(var_4.trace["entity"]) && var_4.trace["entity"] == var_14 && !var_11 && !var_12 || distance(var_14.origin, var_6) < 200 * var_4.trace["fraction"] && !var_9 && !var_11 && !var_12 || !var_12 && remoteuav_cantargetuav(var_4, var_14)) {
      var_13 = scripts\engine\trace::_bullet_trace(var_4.origin, var_14.origin + (0, 0, 32), 1, var_4);

      if(isDefined(var_13["entity"]) && var_13["entity"] == var_14 || var_13["fraction"] == 1) {
        self playlocalsound("recondrone_lockon");
        var_7 = var_14;
      }
    }
  }

  var_8 = undefined;
  var_12 = undefined;
  return var_7;
}

function remoteuav_cantargetuav(var_0, var_1) {
  if(isDefined(var_1.uavtype)) {
    var_2 = anglesToForward(self getplayerangles());
    var_3 = vectorNormalize(var_1.origin - var_0 gettagorigin("tag_turret"));
    var_4 = vectordot(var_2, var_3);

    if(var_4 > 0.985) {
      return true;
    }
  }

  return false;
}

function remoteuav_fire(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("end_remote");
  wait 1;
  self notifyonplayercommand("remoteUAV_tag", "+attack");
  self notifyonplayercommand("remoteUAV_tag", "+attack_akimbo_accessible");

  for(;;) {
    self waittill("remoteUAV_tag");

    if(isDefined(self.lockedtarget)) {
      self playlocalsound("recondrone_tag");
      scripts\mp\damagefeedback::updatedamagefeedback("");
      thread remoteuav_markplayer(self.lockedtarget);
      thread remoteuav_rumble(var_0, 3);
      wait 0.25;
      continue;
    }

    waitframe();
  }
}

function remoteuav_rumble(var_0, var_1) {
  self endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("end_remote");
  var_0 notify("end_rumble");
  var_0 endon("end_rumble");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self playRumbleOnEntity("damage_heavy");
    wait 0.05;
  }
}

function remoteuav_markplayer(var_0) {
  level endon("game_ended");
  var_0.uavremotemarkedby = self;

  if(isPlayer(var_0) && !var_0 scripts\mp\utility\player::isusingremote()) {} else if(isDefined(var_0.uavtype)) {
    var_0.birth_time = var_0.birthtime;
  } else if(isDefined(var_0.owner) && isalive(var_0.owner)) {
    var_0.owner thread scripts\mp\rank::scoreeventpopup("turret_marked_by_remote_uav");
  }

  remoteuav_dialog("tag");

  if(scripts\mp\utility\game::getgametype() != "dm") {
    if(isPlayer(var_0)) {
      thread scripts\mp\utility\points::giveunifiedpoints("kill");
    }
  }

  if(isPlayer(var_0)) {
    var_0 setperk("specialty_radarblip", 1);
  } else {
    if(isDefined(var_0.uavtype)) {
      var_1 = "compassping_enemy_uav";
    } else {
      var_1 = "compassping_sentry_enemy";
    }

    if(level.teambased) {
      var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(var_2 != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(var_2, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_1);
        scripts\mp\objidpoolmanager::update_objective_state(var_2, "active");
        scripts\mp\objidpoolmanager::objective_teammask_single(var_2, self.team);
        scripts\mp\objidpoolmanager::update_objective_icon(var_2, var_1);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 1);
      }

      var_1.remoteuavmarkedobjid01 = var_2;
    } else {
      var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(var_2 != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(var_2, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_1);
        scripts\mp\objidpoolmanager::update_objective_state(var_2, "active");
        scripts\mp\objidpoolmanager::objective_teammask_single(var_2, scripts\mp\utility\game::getotherteam(self.team)[0]);
        scripts\mp\objidpoolmanager::update_objective_icon(var_2, var_2);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 1);
      }

      var_1.remoteuavmarkedobjid02 = var_2;
      var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(var_2 != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(var_2, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(var_2, var_1);
        scripts\mp\objidpoolmanager::update_objective_state(var_2, "active");
        scripts\mp\objidpoolmanager::objective_teammask_single(var_2, self.team);
        scripts\mp\objidpoolmanager::update_objective_icon(var_2, var_2);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var_2, 1);
      }

      var_1.remoteuavmarkedobjid03 = var_2;
    }
  }

  thread remoteuav_unmarkremovedplayer(var_1);
}

function remoteuav_processtaggedassist(var_0) {
  remoteuav_dialog("assist");

  if(scripts\mp\utility\game::getgametype() != "dm") {
    self.taggedassist = 1;

    if(isDefined(var_0)) {
      thread scripts\mp\gamescore::processassist(var_0);
      return;
    }

    thread scripts\mp\utility\points::giveunifiedpoints("assist");
    return;
  }
}

function remoteuav_unmarkremovedplayer(var_0) {
  level endon("game_ended");
  var_1 = scripts\engine\utility::ref_143AE("death_or_disconnect", "carried", "leaving");

  if(var_1 == "leaving" || !isDefined(self.uavtype)) {
    self.uavremotemarkedby = undefined;
  }

  if(isDefined(var_0)) {
    if(isPlayer(self)) {
      var_2 = self.guid;
    } else if(isDefined(self.birthtime)) {
      var_2 = self.birthtime;
    } else {
      var_2 = self.birth_time;
    }

    if(var_2 == "carried" || var_2 == "leaving") {
      if(isDefined(var_2.markedplayers[var_2]["icon"])) {
        var_2.markedplayers[var_2]["icon"] destroy();
        var_2.markedplayers[var_2]["icon"] = undefined;
      }
    }

    if(isDefined(var_2) && isDefined(var_2.markedplayers[var_2])) {
      var_2.markedplayers[var_2] = undefined;
      var_2.markedplayers = scripts\engine\utility::array_removeundefined(var_2.markedplayers);
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
    return;
  }
}

function remoteuav_clearmarkedforowner() {
  foreach(var_1 in self.markedplayers) {
    if(isDefined(var_1["icon"])) {
      var_1["icon"] destroy();
      var_1["icon"] = undefined;
    }
  }

  self.markedplayers = undefined;
}

function remoteuav_operationrumble(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  var_0 endon("end_remote");

  for(;;) {
    self playRumbleOnEntity("damage_light");
    wait 0.5;
  }
}

function remoteuav_watch_distance() {
  self endon("death");
  self.rangetrigger = getEnt("remote_uav_range", "targetname");

  if(!isDefined(self.rangetrigger)) {
    var_0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
    self.maxheight = var_0.origin[2];
    self.maxdistance = 12800;
  }

  self.centerref = spawn("script_model", level.mapcenter);
  var_1 = self.origin;
  self.rangecountdownactive = 0;

  for(;;) {
    if(!remoteuav_in_range()) {
      var_2 = 0;

      while(!remoteuav_in_range()) {
        remoteuav_dialog(self.owner, "out_of_range");

        if(!self.rangecountdownactive) {
          self.rangecountdownactive = 1;
          thread remoteuav_rangecountdown();
        }

        if(isDefined(self.heliinproximity)) {
          var_3 = distance(self.origin, self.heliinproximity.origin);
          var_2 = 1 - (var_3 - 150) / 150;
        } else {
          var_3 = distance(self.origin, var_1);
          var_2 = min(1, var_3 / 200);
        }

        self.owner setplayerdata("reconDroneState", "staticAlpha", var_2);
        wait 0.05;
      }

      self notify("in_range");
      self.rangecountdownactive = 0;
      thread remoteuav_staticfade(var_2);
    }

    var_1 = self.origin;
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

function remoteuav_staticfade(var_0) {
  self endon("death");

  while(remoteuav_in_range()) {
    var_0 -= 0.05;

    if(var_0 < 0) {
      self.owner setplayerdata("reconDroneState", "staticAlpha", 0);
      break;
    }

    self.owner setplayerdata("reconDroneState", "staticAlpha", var_0);
    wait 0.05;
  }
}

function remoteuav_rangecountdown() {
  self endon("death");
  self endon("in_range");

  if(isDefined(self.heliinproximity)) {
    var_0 = 3;
  } else {
    var_0 = 6;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self notify("death");
}

function remoteuav_explode_on_disconnect() {
  self endon("death");
  self.owner waittill("disconnect");
  self notify("death");
}

function remoteuav_explode_on_changeteams() {
  self endon("death");
  self.owner scripts\engine\utility::ref_143A5("joined_team", "joined_spectators");
  self notify("death");
}

function remoteuav_clear_marked_on_gameended() {
  self endon("death");
  level waittill("game_ended");
  remoteuav_clearmarkedforowner();
}

function remoteuav_leave_on_timeout() {
  self endon("death");
  var_0 = 60;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  thread remoteuav_leave();
}

function remoteuav_leave() {
  level endon("game_ended");
  self endon("death");
  self notify("leaving");
  remoteuav_endride(self.owner, self);
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
    remoteuav_endride(self.owner, self);
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
  scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  self delete();
}

function remoteuav_light_fx() {
  playFXOnTag(level.chopper_fx["light"]["belly"], self, "tag_light_nose");
  wait 0.05;
  playFXOnTag(level.chopper_fx["light"]["tail"], self, "tag_light_tail1");
}

function remoteuav_dialog(var_0) {
  if(var_0 == "tag") {
    var_1 = 1000;
  } else {
    var_1 = 5000;
  }

  if(gettime() - level.remoteuav_lastdialogtime < var_1) {
    return;
  }

  level.remoteuav_lastdialogtime = gettime();
  var_2 = randomint(level.remoteuav_dialog[var_1].size);
  var_3 = level.remoteuav_dialog[var_1][var_2];
  var_4 = scripts\mp\utility\teams::getteamvoiceinfix(self.team) + "tl" + var_3;
  self playlocalsound(var_4);
}

function remoteuav_handleincomingstinger() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    level waittill("stinger_fired", var_0, var_1, var_2);

    if(!isDefined(var_1) || !isDefined(var_2) || var_2 != self) {
      continue;
    }

    self.owner playlocalsound("javelin_clu_lock");
    self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
    self.hasincoming = 1;
    self.incomingmissiles[self.incomingmissiles.size] = var_1;
    var_1.owner = var_0;
    thread watchstingerproximity(var_1);
  }
}

function remoteuav_handleincomingsam() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    level waittill("sam_fired", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }

    var_3 = 0;

    foreach(var_5 in var_1) {
      if(isDefined(var_5)) {
        self.incomingmissiles[self.incomingmissiles.size] = var_5;
        var_5.owner = var_0;
        var_3++;
      }
    }

    if(var_3) {
      self.owner playlocalsound("javelin_clu_lock");
      self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
      self.hasincoming = 1;
      thread watchsamproximity(level, var_2);
    }
  }
}

function watchstingerproximity(var_0) {
  level endon("game_ended");
  self endon("death");
  self missile_settargetEnt(var_0);
  var_1 = vectorNormalize(var_0.origin - self.origin);

  while(isDefined(var_0)) {
    var_2 = var_0 getpointinbounds(0, 0, 0);
    var_3 = distance(self.origin, var_2);

    if(var_0.numflares > 0 && var_3 < 4000) {
      var_4 = deployflares(var_0);
      self missile_settargetEnt(var_4);
      return;
    } else {
      var_4 = vectorNormalize(var_1.origin - self.origin);

      if(vectordot(var_4, var_2) < 0) {
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
        var_2 = var_4;
      }
    }

    wait 0.05;
  }
}

function watchsamproximity(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");

  foreach(var_3 in var_1) {
    if(isDefined(var_3)) {
      var_3 missile_settargetEnt(var_0);
      var_3.lastvectotarget = vectorNormalize(var_0.origin - var_3.origin);
    }
  }

  while(var_1.size && isDefined(var_0)) {
    var_5 = var_0 getpointinbounds(0, 0, 0);

    foreach(var_13, var_3 in var_1) {
      if(isDefined(var_3)) {
        if(isDefined(self.markfordetete)) {
          self delete();
          continue;
        }

        if(var_0.numflares > 0) {
          var_7 = distance(var_3.origin, var_5);

          if(var_7 < 4000) {
            var_8 = deployflares(var_0);

            foreach(var_10 in var_1) {
              if(isDefined(var_10)) {
                var_10 missile_settargetEnt(var_8);
              }
            }

            return;
          }

          continue;
        }

        var_12 = vectorNormalize(var_4.origin - var_13.origin);

        if(vectordot(var_12, var_13.lastvectotarget) < 0) {
          var_13 playSound("exp_stinger_armor_destroy");
          playFX(level.remoteuav_fx["missile_explode"], var_13.origin);

          if(isDefined(var_13.owner)) {
            radiusdamage(var_13.origin, 400, 1000, 1000, var_13.owner, "MOD_EXPLOSIVE", "stinger_mp");
          } else {
            radiusdamage(var_13.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");
          }

          var_13 hide();
          var_13.markfordetete = 1;
        } else {
          var_13.lastvectotarget = var_12;
        }
      }
    }

    var_9 = undefined;
    var_10 = undefined;
    var_5 = scripts\engine\utility::array_removeundefined(var_5);
    wait 0.05;
  }
}

function deployflares() {
  self.numflares--;
  thread remoteuav_rumble(self.owner, self);
  self playSound("WEAP_SHOTGUNATTACH_FIRE_NPC");
  thread playflarefx();
  var_0 = self.origin + (0, 0, -100);
  var_1 = spawn("script_origin", var_0);
  var_1.angles = self.angles;
  var_1 movegravity((0, 0, -1), 5);
  thread deleteaftertime(var_1);
  return var_1;
}

function playflarefx() {
  for(var_0 = 0; var_0 < 5; var_0++) {
    if(!isDefined(self)) {
      return;
    }

    playFXOnTag(level._effect["vehicle_flares"], self, "TAG_FLARE");
    wait 0.15;
  }
}

function deleteaftertime(var_0) {
  wait var_0;
  self delete();
}

function remoteuav_clearincomingwarning() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    var_0 = 0;

    for(var_1 = 0; var_1 < self.incomingmissiles.size; var_1++) {
      if(isDefined(self.incomingmissiles[var_1]) && missile_isincoming(self.incomingmissiles[var_1], self)) {
        var_0++;
      }
    }

    if(self.hasincoming && !var_0) {
      self.hasincoming = 0;
      self.owner setplayerdata("reconDroneState", "incomingMissile", 0);
    }

    self.incomingmissiles = scripts\engine\utility::array_removeundefined(self.incomingmissiles);
    wait 0.05;
  }
}

function missile_isincoming(var_0, var_1) {
  var_2 = vectorNormalize(var_1.origin - var_0.origin);
  var_3 = anglesToForward(var_0.angles);
  return vectordot(var_2, var_3) > 0;
}

function remoteuav_watchheliproximity() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.helis) {
      if(distance(var_2.origin, self.origin) < 300) {
        var_0 = 1;
        self.heliinproximity = var_2;
      }
    }

    foreach(var_5 in level.littlebirds) {
      if(var_5 != self && (!isDefined(var_5.helitype) || var_5.helitype != "remote_uav") && distance(var_5.origin, self.origin) < 300) {
        var_0 = 1;
        self.heliinproximity = var_5;
      }
    }

    if(!self.inheliproximity && var_0) {
      self.inheliproximity = 1;
    } else if(self.inheliproximity && !var_0) {
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

function modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_6 = scripts\mp\damage::handleempdamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handlemissiledamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handleapdamage(var_2, var_3, var_6);
  playfxontagforclients(level.remoteuav_fx["hit"], self, "tag_origin", self.owner);
  self playSound("recondrone_damaged");

  if(self.smoking == 0 && self.damagetaken >= self.maxhealth / 2) {
    self.smoking = 1;
    playFXOnTag(level.remoteuav_fx["smoke"], self, "tag_origin");
  }

  return var_6;
}

function handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  scripts\mp\damage::onkillstreakkilled("remote_uav", var_1, var_2, var_3, var_4, "destroyed_remote_uav", undefined, "callout_destroyed_remote_uav");
}