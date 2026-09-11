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

function useremoteuav(var0, var1) {
  return tryuseremoteuav(var0, "remote_uav");
}

function exceededmaxremoteuavs(var0) {
  if(scripts\mp\utility\game::getgametype() == "dm") {
    if(isDefined(level.remote_uav[var0]) || isDefined(level.remote_uav[scripts\mp\utility\game::getotherteam(var0)[0]])) {
      return 1;
    }

    return 0;
  }

  if(isDefined(level.remote_uav[var0])) {
    return 1;
  }

  return 0;
}

function tryuseremoteuav(var0, var1) {
  scripts\common\utility::allow_usability(0);

  if(scripts\mp\utility\player::isusingremote() || self isusingturret() || isDefined(level.nukeincoming)) {
    scripts\common\utility::allow_usability(1);
    return 0;
  }

  var2 = 1;

  if(exceededmaxremoteuavs(self.team) || level.littlebirds.size >= 4) {
    self iprintlnbold(&"KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    scripts\common\utility::allow_usability(1);
    return 0;
  } else if(scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount + var2 >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
    self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
    scripts\common\utility::allow_usability(1);
    return 0;
  }

  self setplayerdata("reconDroneState", "staticAlpha", 0);
  self setplayerdata("reconDroneState", "incomingMissile", 0);
  scripts\mp\utility\killstreak::incrementfauxvehiclecount();
  var3 = givecarryremoteuav(var0, var1);

  if(var3) {
    scripts\common\utility::ref_13e0a(level.ref_11b2a, var1, self.origin);
    thread scripts\mp\hud_util::teamplayercardsplash("used_remote_uav", self);
  } else {
    scripts\mp\utility\killstreak::decrementfauxvehiclecount();
  }

  self.iscarrying = 0;
  return var3;
}

function givecarryremoteuav(var0, var1) {
  var2 = createcarryremoteuav(var1, self);
  scripts\cp_mp\utility\inventory_utility::_takeweapon("killstreak_uav_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon("killstreak_remote_uav_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("killstreak_remote_uav_mp");
  setcarryingremoteuav(var2);

  if(isalive(self) && isDefined(var2)) {
    var3 = var2.origin;
    var4 = self.angles;
    var2.soundent delete();
    var2 delete();
    var5 = startremoteuav(var0, var1, var3, var4);
  } else {
    var5 = 0;

    if(isalive(self)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("killstreak_remote_uav_mp");
      scripts\cp_mp\utility\inventory_utility::_giveweapon("killstreak_uav_mp");
    }
  }

  return var5;
}

function createcarryremoteuav(var0, var1) {
  var2 = var1.origin + anglesToForward(var1.angles) * 4 + anglestoup(var1.angles) * 50;
  var3 = spawnturret("misc_turret", var2, "sentry_minigun_mp");
  var3.origin = var2;
  var3.angles = var1.angles;
  var3.sentrytype = "sentry_minigun";
  var3.canbeplaced = 1;
  var3 setturretmodechangewait(1);
  var3 setmode("sentry_offline");
  var3 makeunusable();
  var3 maketurretinoperable();
  var3.owner = var1;
  var3 setsentryowner(var3.owner);
  var3.scale = 3;
  var3.inheliproximity = 0;
  thread carryremoteuav_handleexistence();
  var3.rangetrigger = getEnt("remote_uav_range", "targetname");

  if(!isDefined(var3.rangetrigger)) {
    var4 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
    var3.maxheight = var4.origin[2];
    var3.maxdistance = 3600;
  }

  var3.soundent = spawn("script_origin", var3.origin);
  var3.soundent.angles = var3.angles;
  var3.soundent.origin = var3.origin;
  var3.soundent linkTo(var3);
  var3.soundent playLoopSound("recondrone_idle_high");
  return var3;
}

function setcarryingremoteuav(var0) {
  thread carryremoteuav_setcarried(var0);
  self notifyonplayercommand("place_carryRemoteUAV", "+attack");
  self notifyonplayercommand("place_carryRemoteUAV", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 4");
  jumpiftrue(self isconsoleplayer()) LOC_0000006c;
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 5");
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 6");
  self notifyonplayercommand("cancel_carryRemoteUAV", "+actionslot 7");

  for(;;) {
    var1 = ref_11969("place_carryRemoteUAV", "cancel_carryRemoteUAV", "weapon_switch_started", "force_cancel_placement", "death_or_disconnect");
    self forceusehintoff();

    if(var1 != "place_carryRemoteUAV") {
      carryremoteuav_delete(var0);
      break;
    }

    if(!var0.canbeplaced) {
      if(self.team != "spectator") {
        self forceusehinton(&"KILLSTREAKS_REMOTE_UAV_CANNOT_PLACE");
      }

      continue;
    }

    if(exceededmaxremoteuavs(self.team) || scripts\mp\utility\killstreak::currentactivevehiclecount() >= scripts\mp\utility\killstreak::maxvehiclesallowed() || level.fauxvehiclecount >= scripts\mp\utility\killstreak::maxvehiclesallowed()) {
      self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
      carryremoteuav_delete(var0);
      break;
    }

    self.iscarrying = 0;
    var0.carriedby = undefined;
    var0 playSound("sentry_gun_plant");
    var0 notify("placed");
    break;
  }
}

function ref_11969(var0, var1, var2, var3, var4, var5) {
  if((!isDefined(var0) || var0 != "death") && (!isDefined(var1) || var1 != "death") && (!isDefined(var2) || var2 != "death") && (!isDefined(var3) || var3 != "death") && (!isDefined(var4) || var4 != "death")) {
    self endon("death");
  }

  var6 = spawnStruct();

  if(isDefined(var0)) {
    thread scripts\engine\utility::waittill_string(var0, var6);
  }

  if(isDefined(var1)) {
    thread scripts\engine\utility::waittill_string(var1, var6);
  }

  if(isDefined(var2)) {
    thread scripts\engine\utility::waittill_string(var2, var6);
  }

  if(isDefined(var3)) {
    thread scripts\engine\utility::waittill_string(var3, var6);
  }

  if(isDefined(var4)) {
    thread scripts\engine\utility::waittill_string(var4, var6);
  }

  jumpiffalse(isDefined(var5)) LOC_000000b4;
  thread scripts\engine\utility::waittill_string(var5, var6);
  var6 waittill("returned", var7);
  var6 notify("die");
  return var7;
}

function carryremoteuav_setcarried(var0) {
  self setCanDamage(0);
  self setsentrycarrier(var0);
  self notsolid();
  self.carriedby = var0;
  var0.iscarrying = 1;
  thread updatecarryremoteuavplacement(var0);
  self notify("carried");
}

function carryremoteuav_delete(var0) {
  self.iscarrying = 0;

  if(isDefined(var0)) {
    if(isDefined(var0.soundent)) {
      var0.soundent delete();
    }

    var0 delete();
    return;
  }
}

function isinremotenodeploy() {
  if(isDefined(level.remoteuav_nodeployzones) && level.remoteuav_nodeployzones.size) {
    foreach(var1 in level.remoteuav_nodeployzones) {
      if(self istouching(var1)) {
        return true;
      }
    }
  }

  return false;
}

function updatecarryremoteuavplacement(var0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var0 endon("placed");
  var0 endon("death");
  var0.canbeplaced = 1;
  var1 = -1;
  scripts\common\utility::allow_usability(1);

  for(;;) {
    var2 = 18;

    switch (self getstance()) {
      case "stand":
        var2 = 40;
        break;
      case "crouch":
        var2 = 25;
        break;
      case "prone":
        var2 = 10;
        break;
    }

    var3 = self canplayerplacetank(22, 22, 50, var2, 0, 0);
    var0.origin = var3["origin"] + anglestoup(self.angles) * 27;
    var0.angles = var3["angles"];
    var0.canbeplaced = self isonground() && var3["result"] && remoteuav_in_range(var0) && !isinremotenodeploy(var0);

    if(var0.canbeplaced != var1) {
      if(var0.canbeplaced) {
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

    var1 = var0.canbeplaced;
    waitframe();
  }
}

function carryremoteuav_handleexistence() {
  level endon("game_ended");
  self.owner endon("place_carryRemoteUAV");
  self.owner endon("cancel_carryRemoteUAV");
  self.owner scripts\engine\utility::ref_143a6("death_or_disconnect", "joined_team", "joined_spectators");

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

function startremoteuav(var0, var1, var2, var3) {
  lockplayerforremoteuavlaunch();
  scripts\mp\utility\player::setusingremote(var1);
  scripts\cp_mp\utility\inventory_utility::_giveweapon("uav_remote_mp");
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("uav_remote_mp");
  self visionsetnakedforplayer("black_bw", 0);
  var4 = scripts\mp\killstreaks\killstreaks::initridekillstreak("remote_uav");

  if(var4 != "success") {
    if(var4 != "disconnect") {
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
  var5 = createremoteuav(var0, self, var1, var2, var3);

  if(isDefined(var5)) {
    thread remoteuav_ride(var0, var5, var1);
    return 1;
  }

  self iprintlnbold(&"KILLSTREAKS/TOO_MANY_VEHICLES");
  scripts\cp_mp\utility\inventory_utility::_takeweapon("uav_remote_mp");
  scripts\mp\utility\player::clearusingremote();
  return 0;
}

function lockplayerforremoteuavlaunch() {
  var0 = spawn("script_origin", self.origin);
  var0 hide();
  self playerlinkTo(var0);
  thread clearplayerlockfromremoteuavlaunch(var0);
}

function clearplayerlockfromremoteuavlaunch(var0) {
  level endon("game_ended");
  var1 = scripts\engine\utility::ref_143ad("death_or_disconnect", "remoteuav_unlock");

  if(var1 != "disconnect") {
    self unlink();
  }

  var0 delete();
}

function createremoteuav(var0, var1, var2, var3, var4) {
  if(var1 isconsoleplayer()) {
    var5 = spawnhelicopter(var1, var3, var4, "remote_uav_mp", "vehicle_remote_uav");
  } else {
    var5 = spawnhelicopter(var2, var4, var5, "remote_uav_mp_pc", "vehicle_remote_uav");
  }

  if(!isDefined(var5)) {
    return undefined;
  }

  var5 makevehiclesolidcapsule(18, -9, 18);
  var5.lifeid = var1;
  var5.team = var2.team;
  var5.pers["team"] = var2.team;
  var5.owner = var2;
  var5 setotherent(var2);
  var5 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var2);
  var5.maxhealth = 250;
  var5.scrambler = spawn("script_model", var4);
  var5.scrambler linkTo(var5, "tag_origin", (0, 0, -160), (0, 0, 0));
  var5.scrambler makescrambler(var2);
  var5.smoking = 0;
  var5.inheliproximity = 0;
  var5.helitype = "remote_uav";
  var5.markedplayers = [];
  thread remoteuav_light_fx();
  thread remoteuav_explode_on_disconnect();
  thread remoteuav_explode_on_changeteams();
  thread remoteuav_explode_on_death();
  thread remoteuav_clear_marked_on_gameended();
  thread remoteuav_leave_on_timeout();
  thread remoteuav_watch_distance();
  thread remoteuav_watchheliproximity();
  thread remoteuav_handledamage();
  var5.numflares = 2;
  var5.hasincoming = 0;
  var5.incomingmissiles = [];
  thread remoteuav_clearincomingwarning();
  thread remoteuav_handleincomingstinger();
  thread remoteuav_handleincomingsam();
  level.remote_uav[var5.team] = var5;
  return var5;
}

function remoteuav_ride(var0, var1, var2) {
  var1.playerlinked = 1;
  self.restoreangles = self.angles;

  if(getdvarint("NOSLRNTRKL")) {
    scripts\mp\utility\player::setthirdpersondof(0);
  }

  self cameralinkTo(var1, "tag_origin");
  self remotecontrolvehicle(var1);
  thread remoteuav_playerexit(var1);
  thread remoteuav_track(var1);
  thread remoteuav_fire(var1);
  self.remote_uav_ridelifeid = var0;
  self.remoteuav = var1;
  thread remoteuav_delaylaunchdialog(var1);
  self visionsetnakedforplayer("black_bw", 0);
  scripts\mp\utility\player::restorebasevisionset(1);
}

function remoteuav_delaylaunchdialog(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var0 endon("death");
  var0 endon("end_remote");
  var0 endon("end_launch_dialog");
  wait 3;
  remoteuav_dialog("launch");
}

function remoteuav_endride(var0) {
  if(isDefined(var0)) {
    var0.playerlinked = 0;
    var0 notify("end_remote");
    scripts\mp\utility\player::clearusingremote();

    if(getdvarint("NOSLRNTRKL")) {
      scripts\mp\utility\player::setthirdpersondof(1);
    }

    self cameraunlink(var0);
    self remotecontrolvehicleoff(var0);
    self thermalvisionoff();
    self setplayerangles(self.restoreangles);
    var1 = scripts\mp\utility\inventory::getlastweapon();

    if(!self hasweapon(var1)) {
      var1 = scripts\mp\utility\inventory::getfirstprimaryweapon();
    }

    scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var1);
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

function remoteuav_playerexit(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var0 endon("death");
  var0 endon("end_remote");
  wait 2;
  var1 = level.framedurationseconds;

  for(;;) {
    var2 = 0;

    while(self useButtonPressed()) {
      var2 += var1;

      if(var2 > 0.75) {
        thread remoteuav_leave();
        return;
      }

      wait var1;
    }

    waitframe();
  }
}

function remoteuav_track(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var0 endon("death");
  var0 endon("end_remote");
  var0.lasttrackingdialogtime = 0;
  self.lockedtarget = undefined;
  self weaponlockfree();
  wait 1;

  for(;;) {
    var1 = var0 gettagorigin("tag_turret");
    var2 = anglesToForward(self getplayerangles());
    var3 = var1 + var2 * 1024;
    var4 = scripts\engine\trace::_bullet_trace(var1, var3, 1, var0);

    if(isDefined(var4["position"])) {
      var5 = var4["position"];
    } else {
      var5 = var3;
      var4 = var3;
    }

    var0.trace = var4;
    var6 = remoteuav_trackentities(var0, level.players, var5);
    var7 = remoteuav_trackentities(var0, level.turrets, var5);
    var8 = undefined;

    if(level.teambased) {
      var9 = undefined;
      var10 = [];
      var11 = scripts\mp\utility\teams::getenemyteams(self.team);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
        var9 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();
      }

      jumpiffalse(istrue(var9) && getdvarint("scr_uav_for_squad_only", 1)) LOC_000001b3;

      foreach(var13 in level.teamnamelist) {
        foreach(var15 in level.squaddata[var13]) {
          var16 = var13 + var20;

          foreach(var18 in level.uavmodels[var16]) {
            var10 = var18;
          }
        }
      }

      goto LOC_0000020e;
    } else {
      var27 = remoteuav_trackentities(var1, level.uavmodels, var6);
    }

    var9 = undefined;

    if(isDefined(var7)) {
      var9 = var7;
    } else if(isDefined(var8)) {
      var9 = var8;
    } else if(isDefined(var27)) {
      var9 = var27;
    }

    if(isDefined(var9)) {
      if(!isDefined(self.lockedtarget) || isDefined(self.lockedtarget) && self.lockedtarget != var9) {
        self weaponlockfinalize(var9);
        self.lockedtarget = var9;

        if(isDefined(var7)) {
          var1 notify("end_launch_dialog");
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

function remoteuav_trackentities(var0, var1, var2) {
  level endon("game_ended");
  var3 = undefined;

  foreach(var14, var5 in var1) {
    if(level.teambased && (!isDefined(var5.team) || var5.team == self.team)) {
      continue;
    }

    if(isPlayer(var5)) {
      if(!scripts\mp\utility\player::isreallyalive(var5)) {
        continue;
      }

      if(var5 == self) {
        continue;
      }

      var6 = var5.guid;
    } else {
      var6 = var5.birthtime;
    }

    if(isDefined(var5.sentrytype) || isDefined(var5.turrettype)) {
      var7 = 32;
      var8 = "hud_fofbox_hostile_vehicle";
    } else if(isDefined(var5.uavtype)) {
      var7 = -52;
      var8 = "hud_fofbox_hostile_vehicle";
    } else {
      var7 = 26;
      var8 = "veh_hud_target_unmarked";
    }

    if(isDefined(var5.uavremotemarkedby)) {
      if(!isDefined(var0.markedplayers[var6])) {
        var0.markedplayers[var6] = [];
        var0.markedplayers[var6]["player"] = var5;
        var0.markedplayers[var6]["icon"] = var5 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, "veh_hud_target_marked", var7);
        var0.markedplayers[var6]["icon"].shader = "veh_hud_target_marked";

        if(!isDefined(var5.sentrytype) || !isDefined(var5.turrettype)) {
          var0.markedplayers[var6]["icon"] settargetEnt(var5);
        }
      } else if(isDefined(var0.markedplayers[var6]) && isDefined(var0.markedplayers[var6]["icon"]) && isDefined(var0.markedplayers[var6]["icon"].shader) && var0.markedplayers[var6]["icon"].shader != "veh_hud_target_marked") {
        var0.markedplayers[var6]["icon"].shader = "veh_hud_target_marked";
        var0.markedplayers[var6]["icon"] setshader("veh_hud_target_marked", 10, 10);
        var0.markedplayers[var6]["icon"] setwaypoint(0, 0, 0, 0);
      }

      continue;
    }

    if(isPlayer(var5)) {
      var9 = isDefined(var5.spawntime) && (gettime() - var5.spawntime) / 1000 <= 5;
      var10 = var5 scripts\mp\utility\perk::_hasperk("specialty_blindeye");
      var11 = 0;
      var12 = 0;
    } else {
      var9 = 0;
      var10 = 0;
      var11 = isDefined(var14.carriedby);
      var12 = isDefined(var14.isleaving) && var14.isleaving == 1;
    }

    if(!isDefined(var4.markedplayers[var9]) && !var9 && !var10 && !var11 && !var12) {
      var4.markedplayers[var9] = [];
      var4.markedplayers[var9]["player"] = var14;
      var4.markedplayers[var9]["icon"] = var14 scripts\cp_mp\entityheadicons::setheadicon_singleimage(self, var11, var10);
      var4.markedplayers[var9]["icon"].shader = var11;

      if(!isDefined(var14.sentrytype) || !isDefined(var14.turrettype)) {
        var4.markedplayers[var9]["icon"] settargetEnt(var14);
      }
    }

    if((!isDefined(var7) || var7 != var14) && isDefined(var4.trace["entity"]) && var4.trace["entity"] == var14 && !var11 && !var12 || distance(var14.origin, var6) < 200 * var4.trace["fraction"] && !var9 && !var11 && !var12 || !var12 && remoteuav_cantargetuav(var4, var14)) {
      var13 = scripts\engine\trace::_bullet_trace(var4.origin, var14.origin + (0, 0, 32), 1, var4);

      if(isDefined(var13["entity"]) && var13["entity"] == var14 || var13["fraction"] == 1) {
        self playlocalsound("recondrone_lockon");
        var7 = var14;
      }
    }
  }

  var8 = undefined;
  var12 = undefined;
  return var7;
}

function remoteuav_cantargetuav(var0, var1) {
  if(isDefined(var1.uavtype)) {
    var2 = anglesToForward(self getplayerangles());
    var3 = vectorNormalize(var1.origin - var0 gettagorigin("tag_turret"));
    var4 = vectordot(var2, var3);

    if(var4 > 0.985) {
      return true;
    }
  }

  return false;
}

function remoteuav_fire(var0) {
  self endon("disconnect");
  var0 endon("death");
  level endon("game_ended");
  var0 endon("end_remote");
  wait 1;
  self notifyonplayercommand("remoteUAV_tag", "+attack");
  self notifyonplayercommand("remoteUAV_tag", "+attack_akimbo_accessible");

  for(;;) {
    self waittill("remoteUAV_tag");

    if(isDefined(self.lockedtarget)) {
      self playlocalsound("recondrone_tag");
      scripts\mp\damagefeedback::updatedamagefeedback("");
      thread remoteuav_markplayer(self.lockedtarget);
      thread remoteuav_rumble(var0, 3);
      wait 0.25;
      continue;
    }

    waitframe();
  }
}

function remoteuav_rumble(var0, var1) {
  self endon("disconnect");
  var0 endon("death");
  level endon("game_ended");
  var0 endon("end_remote");
  var0 notify("end_rumble");
  var0 endon("end_rumble");

  for(var2 = 0; var2 < var1; var2++) {
    self playRumbleOnEntity("damage_heavy");
    wait 0.05;
  }
}

function remoteuav_markplayer(var0) {
  level endon("game_ended");
  var0.uavremotemarkedby = self;

  if(isPlayer(var0) && !var0 scripts\mp\utility\player::isusingremote()) {} else if(isDefined(var0.uavtype)) {
    var0.birth_time = var0.birthtime;
  } else if(isDefined(var0.owner) && isalive(var0.owner)) {
    var0.owner thread scripts\mp\rank::scoreeventpopup("turret_marked_by_remote_uav");
  }

  remoteuav_dialog("tag");

  if(scripts\mp\utility\game::getgametype() != "dm") {
    if(isPlayer(var0)) {
      thread scripts\mp\utility\points::giveunifiedpoints("kill");
    }
  }

  if(isPlayer(var0)) {
    var0 setperk("specialty_radarblip", 1);
  } else {
    if(isDefined(var0.uavtype)) {
      var1 = "compassping_enemy_uav";
    } else {
      var1 = "compassping_sentry_enemy";
    }

    if(level.teambased) {
      var2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(var2 != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(var2, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(var2, var1);
        scripts\mp\objidpoolmanager::update_objective_state(var2, "active");
        scripts\mp\objidpoolmanager::objective_teammask_single(var2, self.team);
        scripts\mp\objidpoolmanager::update_objective_icon(var2, var1);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var2, 1);
      }

      var1.remoteuavmarkedobjid01 = var2;
    } else {
      var2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(var2 != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(var2, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(var2, var1);
        scripts\mp\objidpoolmanager::update_objective_state(var2, "active");
        scripts\mp\objidpoolmanager::objective_teammask_single(var2, scripts\mp\utility\game::getotherteam(self.team)[0]);
        scripts\mp\objidpoolmanager::update_objective_icon(var2, var2);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var2, 1);
      }

      var1.remoteuavmarkedobjid02 = var2;
      var2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

      if(var2 != -1) {
        scripts\mp\objidpoolmanager::objective_add_objective(var2, "invisible", (0, 0, 0));
        scripts\mp\objidpoolmanager::update_objective_onentity(var2, var1);
        scripts\mp\objidpoolmanager::update_objective_state(var2, "active");
        scripts\mp\objidpoolmanager::objective_teammask_single(var2, self.team);
        scripts\mp\objidpoolmanager::update_objective_icon(var2, var2);
        scripts\mp\objidpoolmanager::update_objective_setbackground(var2, 1);
      }

      var1.remoteuavmarkedobjid03 = var2;
    }
  }

  thread remoteuav_unmarkremovedplayer(var1);
}

function remoteuav_processtaggedassist(var0) {
  remoteuav_dialog("assist");

  if(scripts\mp\utility\game::getgametype() != "dm") {
    self.taggedassist = 1;

    if(isDefined(var0)) {
      thread scripts\mp\gamescore::processassist(var0);
      return;
    }

    thread scripts\mp\utility\points::giveunifiedpoints("assist");
    return;
  }
}

function remoteuav_unmarkremovedplayer(var0) {
  level endon("game_ended");
  var1 = scripts\engine\utility::ref_143ae("death_or_disconnect", "carried", "leaving");

  if(var1 == "leaving" || !isDefined(self.uavtype)) {
    self.uavremotemarkedby = undefined;
  }

  if(isDefined(var0)) {
    if(isPlayer(self)) {
      var2 = self.guid;
    } else if(isDefined(self.birthtime)) {
      var2 = self.birthtime;
    } else {
      var2 = self.birth_time;
    }

    if(var2 == "carried" || var2 == "leaving") {
      if(isDefined(var2.markedplayers[var2]["icon"])) {
        var2.markedplayers[var2]["icon"] destroy();
        var2.markedplayers[var2]["icon"] = undefined;
      }
    }

    if(isDefined(var2) && isDefined(var2.markedplayers[var2])) {
      var2.markedplayers[var2] = undefined;
      var2.markedplayers = scripts\engine\utility::array_removeundefined(var2.markedplayers);
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
  foreach(var1 in self.markedplayers) {
    if(isDefined(var1["icon"])) {
      var1["icon"] destroy();
      var1["icon"] = undefined;
    }
  }

  self.markedplayers = undefined;
}

function remoteuav_operationrumble(var0) {
  self endon("disconnect");
  var0 endon("death");
  level endon("game_ended");
  var0 endon("end_remote");

  for(;;) {
    self playRumbleOnEntity("damage_light");
    wait 0.5;
  }
}

function remoteuav_watch_distance() {
  self endon("death");
  self.rangetrigger = getEnt("remote_uav_range", "targetname");

  if(!isDefined(self.rangetrigger)) {
    var0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
    self.maxheight = var0.origin[2];
    self.maxdistance = 12800;
  }

  self.centerref = spawn("script_model", level.mapcenter);
  var1 = self.origin;
  self.rangecountdownactive = 0;

  for(;;) {
    if(!remoteuav_in_range()) {
      var2 = 0;

      while(!remoteuav_in_range()) {
        remoteuav_dialog(self.owner, "out_of_range");

        if(!self.rangecountdownactive) {
          self.rangecountdownactive = 1;
          thread remoteuav_rangecountdown();
        }

        if(isDefined(self.heliinproximity)) {
          var3 = distance(self.origin, self.heliinproximity.origin);
          var2 = 1 - (var3 - 150) / 150;
        } else {
          var3 = distance(self.origin, var1);
          var2 = min(1, var3 / 200);
        }

        self.owner setplayerdata("reconDroneState", "staticAlpha", var2);
        wait 0.05;
      }

      self notify("in_range");
      self.rangecountdownactive = 0;
      thread remoteuav_staticfade(var2);
    }

    var1 = self.origin;
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

function remoteuav_staticfade(var0) {
  self endon("death");

  while(remoteuav_in_range()) {
    var0 -= 0.05;

    if(var0 < 0) {
      self.owner setplayerdata("reconDroneState", "staticAlpha", 0);
      break;
    }

    self.owner setplayerdata("reconDroneState", "staticAlpha", var0);
    wait 0.05;
  }
}

function remoteuav_rangecountdown() {
  self endon("death");
  self endon("in_range");

  if(isDefined(self.heliinproximity)) {
    var0 = 3;
  } else {
    var0 = 6;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
  self notify("death");
}

function remoteuav_explode_on_disconnect() {
  self endon("death");
  self.owner waittill("disconnect");
  self notify("death");
}

function remoteuav_explode_on_changeteams() {
  self endon("death");
  self.owner scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
  self notify("death");
}

function remoteuav_clear_marked_on_gameended() {
  self endon("death");
  level waittill("game_ended");
  remoteuav_clearmarkedforowner();
}

function remoteuav_leave_on_timeout() {
  self endon("death");
  var0 = 60;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var0);
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

function remoteuav_dialog(var0) {
  if(var0 == "tag") {
    var1 = 1000;
  } else {
    var1 = 5000;
  }

  if(gettime() - level.remoteuav_lastdialogtime < var1) {
    return;
  }

  level.remoteuav_lastdialogtime = gettime();
  var2 = randomint(level.remoteuav_dialog[var1].size);
  var3 = level.remoteuav_dialog[var1][var2];
  var4 = scripts\mp\utility\teams::getteamvoiceinfix(self.team) + "tl" + var3;
  self playlocalsound(var4);
}

function remoteuav_handleincomingstinger() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    level waittill("stinger_fired", var0, var1, var2);

    if(!isDefined(var1) || !isDefined(var2) || var2 != self) {
      continue;
    }

    self.owner playlocalsound("javelin_clu_lock");
    self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
    self.hasincoming = 1;
    self.incomingmissiles[self.incomingmissiles.size] = var1;
    var1.owner = var0;
    thread watchstingerproximity(var1);
  }
}

function remoteuav_handleincomingsam() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    level waittill("sam_fired", var0, var1, var2);

    if(!isDefined(var2) || var2 != self) {
      continue;
    }

    var3 = 0;

    foreach(var5 in var1) {
      if(isDefined(var5)) {
        self.incomingmissiles[self.incomingmissiles.size] = var5;
        var5.owner = var0;
        var3++;
      }
    }

    if(var3) {
      self.owner playlocalsound("javelin_clu_lock");
      self.owner setplayerdata("reconDroneState", "incomingMissile", 1);
      self.hasincoming = 1;
      thread watchsamproximity(level, var2);
    }
  }
}

function watchstingerproximity(var0) {
  level endon("game_ended");
  self endon("death");
  self missile_settargetEnt(var0);
  var1 = vectorNormalize(var0.origin - self.origin);

  while(isDefined(var0)) {
    var2 = var0 getpointinbounds(0, 0, 0);
    var3 = distance(self.origin, var2);

    if(var0.numflares > 0 && var3 < 4000) {
      var4 = deployflares(var0);
      self missile_settargetEnt(var4);
      return;
    } else {
      var4 = vectorNormalize(var1.origin - self.origin);

      if(vectordot(var4, var2) < 0) {
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
        var2 = var4;
      }
    }

    wait 0.05;
  }
}

function watchsamproximity(var0, var1) {
  level endon("game_ended");
  var0 endon("death");

  foreach(var3 in var1) {
    if(isDefined(var3)) {
      var3 missile_settargetEnt(var0);
      var3.lastvectotarget = vectorNormalize(var0.origin - var3.origin);
    }
  }

  while(var1.size && isDefined(var0)) {
    var5 = var0 getpointinbounds(0, 0, 0);

    foreach(var13, var3 in var1) {
      if(isDefined(var3)) {
        if(isDefined(self.markfordetete)) {
          self delete();
          continue;
        }

        if(var0.numflares > 0) {
          var7 = distance(var3.origin, var5);

          if(var7 < 4000) {
            var8 = deployflares(var0);

            foreach(var10 in var1) {
              if(isDefined(var10)) {
                var10 missile_settargetEnt(var8);
              }
            }

            return;
          }

          continue;
        }

        var12 = vectorNormalize(var4.origin - var13.origin);

        if(vectordot(var12, var13.lastvectotarget) < 0) {
          var13 playSound("exp_stinger_armor_destroy");
          playFX(level.remoteuav_fx["missile_explode"], var13.origin);

          if(isDefined(var13.owner)) {
            radiusdamage(var13.origin, 400, 1000, 1000, var13.owner, "MOD_EXPLOSIVE", "stinger_mp");
          } else {
            radiusdamage(var13.origin, 400, 1000, 1000, undefined, "MOD_EXPLOSIVE", "stinger_mp");
          }

          var13 hide();
          var13.markfordetete = 1;
        } else {
          var13.lastvectotarget = var12;
        }
      }
    }

    var9 = undefined;
    var10 = undefined;
    var5 = scripts\engine\utility::array_removeundefined(var5);
    wait 0.05;
  }
}

function deployflares() {
  self.numflares--;
  thread remoteuav_rumble(self.owner, self);
  self playSound("WEAP_SHOTGUNATTACH_FIRE_NPC");
  thread playflarefx();
  var0 = self.origin + (0, 0, -100);
  var1 = spawn("script_origin", var0);
  var1.angles = self.angles;
  var1 movegravity((0, 0, -1), 5);
  thread deleteaftertime(var1);
  return var1;
}

function playflarefx() {
  for(var0 = 0; var0 < 5; var0++) {
    if(!isDefined(self)) {
      return;
    }

    playFXOnTag(level._effect["vehicle_flares"], self, "TAG_FLARE");
    wait 0.15;
  }
}

function deleteaftertime(var0) {
  wait var0;
  self delete();
}

function remoteuav_clearincomingwarning() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    var0 = 0;

    for(var1 = 0; var1 < self.incomingmissiles.size; var1++) {
      if(isDefined(self.incomingmissiles[var1]) && missile_isincoming(self.incomingmissiles[var1], self)) {
        var0++;
      }
    }

    if(self.hasincoming && !var0) {
      self.hasincoming = 0;
      self.owner setplayerdata("reconDroneState", "incomingMissile", 0);
    }

    self.incomingmissiles = scripts\engine\utility::array_removeundefined(self.incomingmissiles);
    wait 0.05;
  }
}

function missile_isincoming(var0, var1) {
  var2 = vectorNormalize(var1.origin - var0.origin);
  var3 = anglesToForward(var0.angles);
  return vectordot(var2, var3) > 0;
}

function remoteuav_watchheliproximity() {
  level endon("game_ended");
  self endon("death");
  self endon("end_remote");

  for(;;) {
    var0 = 0;

    foreach(var2 in level.helis) {
      if(distance(var2.origin, self.origin) < 300) {
        var0 = 1;
        self.heliinproximity = var2;
      }
    }

    foreach(var5 in level.littlebirds) {
      if(var5 != self && (!isDefined(var5.helitype) || var5.helitype != "remote_uav") && distance(var5.origin, self.origin) < 300) {
        var0 = 1;
        self.heliinproximity = var5;
      }
    }

    if(!self.inheliproximity && var0) {
      self.inheliproximity = 1;
    } else if(self.inheliproximity && !var0) {
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

function modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var6 = scripts\mp\damage::handleempdamage(var2, var3, var6);
  var6 = scripts\mp\damage::handlemissiledamage(var2, var3, var6);
  var6 = scripts\mp\damage::handleapdamage(var2, var3, var6);
  playfxontagforclients(level.remoteuav_fx["hit"], self, "tag_origin", self.owner);
  self playSound("recondrone_damaged");

  if(self.smoking == 0 && self.damagetaken >= self.maxhealth / 2) {
    self.smoking = 1;
    playFXOnTag(level.remoteuav_fx["smoke"], self, "tag_origin");
  }

  return var6;
}

function handledeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  scripts\mp\damage::onkillstreakkilled("remote_uav", var1, var2, var3, var4, "destroyed_remote_uav", undefined, "callout_destroyed_remote_uav");
}