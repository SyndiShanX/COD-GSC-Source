/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\killstreaks\recon_drone.gsc
********************************************************/

#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\killstreaks\gunship;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\outofrange;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\render_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace recon_drone;

function init() {
  function_bc37093624170142();
  function_23f0d567614a93f0();
  function_202017c74349f68c();
  function_9283d83a13859206();
  function_1bc16ffbb7c1131e();

  setdevdvarifuninitialized(@ "hash_b23e7bb60bbe76a6", 0);
  setdevdvarifuninitialized(@ "hash_7d1382405485d79f", 0);
  setdevdvarifuninitialized(@ "hash_60a091e2e6da3352", 0);
  setdevdvarifuninitialized(@ "hash_b432ce13c8a2cac9", 0);
  setdevdvarifuninitialized(@ "hash_2013691227d032f7", 0);
  level thread function_e08e7ed0591c3438();
}

function function_bc37093624170142() {
  level.helperdronesettings["radar_drone_recon"] = spawnStruct();
  level.helperdronesettings["radar_drone_recon"].repeatuse = getdvarint(@ "hash_b82bd719c6e7913", 0);
  level.helperdronesettings["radar_drone_recon"].timeout = 45;
  level.helperdronesettings["radar_drone_recon"].maxhealth = 45;
  level.helperdronesettings["radar_drone_recon"].hitstokill = 1;
  level.helperdronesettings["radar_drone_recon"].speed = 140;
  level.helperdronesettings["radar_drone_recon"].accel = 20;
  level.helperdronesettings["radar_drone_recon"].halfsize = 27;
  level.helperdronesettings["radar_drone_recon"].spawndist = 30;
  level.helperdronesettings["radar_drone_recon"].streakname = "radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].vehicleinfo = "veh_radar_drone_recon_mp";
  level.helperdronesettings["radar_drone_recon"].modelbase = "veh9_mil_air_drone_recon_large_mp";
  level.helperdronesettings["radar_drone_recon"].teamsplash = "used_" + "radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].destroyedsplash = "callout_destroyed_" + "radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].scorepopup = "destroyed_" + "radar_drone_recon";
  level.helperdronesettings["radar_drone_recon"].primarymode = "MANUAL";
  level.helperdronesettings["radar_drone_recon"].primarymodestring = &"KILLSTREAKS_HINTS/RCD_MANUAL";
  level.helperdronesettings["radar_drone_recon"].primarymodefunc = &function_9dfca5c7ac12fc2;
  level.helperdronesettings["radar_drone_recon"].premoddamagefunc = undefined;
  level.helperdronesettings["radar_drone_recon"].postmoddamagefunc = &scripts\cp_mp\killstreaks\helper_drone::function_caf721cb23374e2b;
  level.helperdronesettings["radar_drone_recon"].var_1c606430b81b28ff = &function_ab931b44a2efddf7;
  level.helperdronesettings["radar_drone_recon"].exitfunc = &recondrone_exit;
  level.helperdronesettings["radar_drone_recon"].leavefunc = &recondrone_leave;
  level.helperdronesettings["radar_drone_recon"].explodefunc = &recondrone_explode;
  level.helperdronesettings["radar_drone_recon"].var_9c6efc85b74204cc = &function_8321764da9dead70;
  level.helperdronesettings["radar_drone_recon"].deathfunc = &scripts\cp_mp\killstreaks\helper_drone::function_ba1c5496f8fc5f67;
  level.helperdronesettings["radar_drone_recon"].playfxcallback = &scripts\cp_mp\killstreaks\helper_drone::function_56966b077270a18e;
  level.helperdronesettings["radar_drone_recon"].var_c25a8137257a96d = &function_b576092fd50996bf;
  level.helperdronesettings["radar_drone_recon"].var_191284e2e2837328 = &function_cbd53bead95f8409;
  level.helperdronesettings["radar_drone_recon"].var_6a390682c21bc49e = 1;
  level.helperdronesettings["radar_drone_recon"].var_1947a47c2174d02c = 1;
  level.helperdronesettings["radar_drone_recon"].var_cb2c3fe0819193eb = 3062500;
  level.helperdronesettings["radar_drone_recon"].var_d5ea718abfc8ff5b = 6250000;
  level.helperdronesettings["radar_drone_recon"].colorvision = "recon_drone_color_mp";
  level.helperdronesettings["radar_drone_recon"].var_2215fa459d8250c0 = "recon_drone_color_dark_mp";
  level.helperdronesettings["radar_drone_recon"].var_52c3b4bc88132aee = 1;
  level.helperdronesettings["radar_drone_recon"].voontimeout = 1;
}

function function_23f0d567614a93f0() {
  val::group_register("reconDrone_switch", ["allow_movement", "allow_jump", "supers", "killstreaks", "vehicle_use", "offhand_weapons"]);
  val::group_register("reconDrone_deploy", ["usability", "melee", "offhand_weapons", "weapon_switch", "vehicle_use"]);
  val::group_register("reconDrone_use", ["fire", "shellshock", "melee", "vehicle_use", "nvg"]);

  if(issharedfuncdefined("equipment", "areNVGTogglableForPlayer") && ![[getsharedfunc("equipment", "areNVGTogglableForPlayer")]]()) {
    val::group_register("reconDrone_use", ["fire", "shellshock", "melee", "vehicle_use"]);
    return;
  }

  val::group_register("reconDrone_use", ["fire", "shellshock", "melee", "vehicle_use", "nvg"]);
}

function function_202017c74349f68c() {
  game["dialog"]["radar_drone_recon" + "_teamleader_friendly_inbound"] = "fieldupgrade_team_leader" + "_ally_callout";
  game["dialog"]["radar_drone_recon" + "_teamleader_enemy_inbound"] = "fieldupgrade_team_leader" + "_enemy_callout";
  game["dialog"]["radar_drone_recon" + "_timeout"] = "fieldupgrade_team_leader" + "_timeout";
  game["dialog"]["radar_drone_recon" + "_destroyed"] = "fieldupgrade_team_leader" + "_crash";
}

function function_9283d83a13859206() {}

function function_1bc16ffbb7c1131e() {
  function_c0b0a582ff9e4d57("recon_drone_color_mp");
  function_c0b0a582ff9e4d57("recon_drone_color_dark_mp");
}

function function_57fd8a7006975cd6() {
  streakinfo = createstreakinfo("radar_drone_recon", self);
  return function_ab931b44a2efddf7(streakinfo);
}

function function_ab931b44a2efddf7(streakinfo) {
  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    return false;
  }

  helperdronetype = streakinfo.streakname;
  startpos = scripts\cp_mp\killstreaks\helper_drone::function_34280b807c23a453(helperdronetype);

  if(!isDefined(startpos)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
    }

    return false;
  }

  deployweaponobj = makeweapon("ks_remote_drone_mp");
  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(streakinfo, deployweaponobj, 1, &scripts\cp_mp\killstreaks\helper_drone::weapongivenhelperdrone);

  if(!istrue(deployresult)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  var_fc4aa9db408d9420 = 0.6;
  var_e5c7ffb094dc9eec = 2;
  result = waittill_any_timeout_2(var_fc4aa9db408d9420, "death", "weapon_switch_started");

  if(!isDefined(result) || result != "timeout") {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  result = waittill_any_timeout_1(var_e5c7ffb094dc9eec - var_fc4aa9db408d9420, "death");

  if(!isDefined(result) || result != "timeout") {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  startpos = scripts\cp_mp\killstreaks\helper_drone::function_34280b807c23a453(helperdronetype);
  startangles = self.angles;
  recondrone = recondrone_create(startpos, startangles, helperdronetype, streakinfo);

  if(!isDefined(recondrone)) {
    return false;
  }

  thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_giveplayerfauxremote(streakinfo);

  if(issharedfuncdefined("killstreak", "killstreakUse")) {
    self[[getsharedfunc("killstreak", "killstreakUse")]]("recon_drone");
  }

  if(issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[getsharedfunc("game", "isBRStyleGameType")]]()) {
      recondrone vehicleshowonminimap(0);
      scripts\cp_mp\utility\killstreak_utility::playkillstreakusedialog(helperdronetype);
      recondrone scripts\cp_mp\killstreaks\helper_drone::helperdrone_notifyenemyplayersinrange(helperdronetype);
    }
  }

  scripts\cp_mp\killstreaks\helper_drone::function_c3786c4fba09c2f2(streakinfo);

  if(iscp()) {
    thread scripts\cp_mp\killstreaks\helper_drone::starthelperdrone(recondrone, 1);
  } else {
    thread scripts\cp_mp\killstreaks\helper_drone::starthelperdrone(recondrone);
  }

  return true;
}

function recondrone_create(startpos, startang, helperdronetype, streakinfo) {
  recondrone = scripts\cp_mp\killstreaks\helper_drone::createhelperdrone(startpos, startang, helperdronetype, streakinfo, 0, 1);

  if(!isDefined(recondrone)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
    }

    scripts\cp_mp\killstreaks\helper_drone::helperdronecreationfailedfx(helperdronetype, startpos);
    streakinfo notify("killstreak_finished_with_deploy_weapon");

    if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    scripts\cp_mp\killstreaks\helper_drone::function_c3786c4fba09c2f2(streakinfo);
    return undefined;
  }

  return recondrone;
}

function function_b576092fd50996bf(streakname) {
  hitstokill = level.helperdronesettings[streakname].hitstokill;

  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, hitstokill);
  }
}

function function_cbd53bead95f8409(streakname) {
  hitstokill = level.helperdronesettings[streakname].hitstokill;
  weaponname = "emp_grenade_mp";
  weaponhitsperattack = hitstokill;
  var_8b4500d6a881b7b2 = hitstokill;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, var_8b4500d6a881b7b2, streakname);
  }
}

function function_9dfca5c7ac12fc2(config) {
  self.repeatuse = config.repeatuse;

  if(!isDefined(self.enemiesmarked)) {
    self.enemiesmarked = [];
  }

  if(!isDefined(self.usedcount)) {
    self.usedcount = 0;
  }

  thread function_622c97b11177264a(config);
}

function function_622c97b11177264a(config) {
  if(isDefined(level.var_b67b5f9dfe488c2f)) {
    thread[[level.var_b67b5f9dfe488c2f]](self.streakinfo);
  }

  self.owner notify("droneStart");
  self.owner thread watchthermalinputchange(1);
  self.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self.owner, undefined, self.owner, 0, 0, 0);
  self.playersfx = spawn("script_origin", self.origin);
  self.playersfx showonlytoplayer(self.owner);
  self.playersfx linkTo(self);
  self.playersfx playLoopSound("recon_drone_overlay");
  self.owner setsoundsubmix("mp_recon_drone", 1);
  self.ispiloted = 1;

  if(issharedfuncdefined("supers", "setSuperIsActive")) {
    self.owner thread[[getsharedfunc("supers", "setSuperIsActive")]](1);
  }

  self.owner val::group_set("reconDrone_use", 0);
  self.owner _freezecontrols(0, 1, "reconDrone");
  self.owner _freezelookcontrols(0, 1);
  var_306044dc14a537a2 = 0;

  var_aded1f99ce13821a = getdvarint(@ "hash_b23e7bb60bbe76a6", 0);

  if(var_aded1f99ce13821a) {
    var_306044dc14a537a2 = 1;
  }

  self.owner.restoreangles = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkTo(self, "tag_origin");
  self.owner remotecontrolvehicle(self);
  self.owner scripts\cp_mp\utility\render_utility::function_4f2c4138dacca16a(1, 0, 0.015, 0.15);
  self.owner setclientomnvar("ui_killstreak_health", self.currenthealth / self.maxhealth);

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    scripts\cp_mp\killstreaks\helper_drone::function_ffbc19e1aef5943c(1);
  }

  self.owner painvisionoff();
  self.owner killstreak_savenvgstate();
  self setscriptablepartstate("ddos", "neutral", 0);

  if(issharedfuncdefined("emp", "setEMP_Started_Callback")) {
    self[[getsharedfunc("emp", "setEMP_Started_Callback")]](&function_31b413d9b6abe7f8);
  }

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    self[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_41f3461c40e5a87c);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    self[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_6a90d81d42854ecd);
  }

  scripts\cp_mp\emp_debuff::set_start_emp_callback(&function_31b413d9b6abe7f8);
  scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_41f3461c40e5a87c);
  scripts\cp_mp\emp_debuff::set_clear_emp_callback(&function_6a90d81d42854ecd);
  scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_85f0fd88983d1893);
  scripts\cp_mp\utility\killstreak_utility::movingplatform_playerlink(self.owner);

  if(!istrue(var_306044dc14a537a2)) {
    if(false) {
      scripts\cp_mp\outofrange::setupoutofrangewatcher(self, undefined, self.owner, undefined, 2250000, 9000000);
    }

    self.owner scripts\cp_mp\killstreaks\helper_drone::function_89af506d89aad6ed(1, self);
    self.owner setclientomnvar("ui_rcd_outer_ring", 0);
    thread function_dfc402ef72eff688(config);
    thread function_7730b66241ef6e46(config);
    thread function_86e1c4f92c53ccfb(config);

    if(issharedfuncdefined("helper_drone", "mark_players")) {
      self thread[[getsharedfunc("helper_drone", "mark_players")]](config);
    } else {
      thread function_85b4e9e74b613d68(config);
    }

    thread function_435b4dc89b40e60a(config);
    thread function_148a87125a1ece3e();
  }

  if(istrue(self.oob)) {
    function_a91ebb0263d086f3();
  }

  return true;
}

function function_439e22ca27f68ce3() {
  if(!isDefined(self.recondronesuper)) {
    return false;
  } else {
    drone = self.recondronesuper;

    if(!istrue(drone.repeatuse)) {
      return false;
    }

    if(!isnullweapon(self getheldoffhand())) {
      return false;
    }

    if(!self isonground()) {
      if(scripts\cp_mp\utility\player_utility::isswimmingunderwater()) {
        return false;
      }

      if(!scripts\cp_mp\utility\player_utility::function_d474b372046544b0()) {
        return false;
      }
    }

    if(scripts\cp_mp\utility\player_utility::isinvehicle(1)) {
      return false;
    }

    superinfo = self.super;

    if(!isDefined(superinfo)) {
      return false;
    }

    if(isDefined(superinfo) && istrue(superinfo.usepercent < 0.05)) {
      return false;
    }

    drone.var_eee5ddaafc619fa3 = 1;
    drone notify("regain_control");
    _freezelookcontrols(1);
    config = level.helperdronesettings[drone.helperdronetype];
    result = recondrone_givedeployweapon("ks_remote_device_mp", drone);
    thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_giveplayerfauxremote(drone.streakinfo);

    if(!istrue(result)) {
      _freezelookcontrols(0, 1);
      val::group_reset("reconDrone_switch");
      thread recondrone_takedeployweapon(1, "ks_remote_device_mp");

      if(istrue(scripts\common\utility::isusingremote())) {
        thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_takeplayerfauxremote(drone.streakinfo);
      }

      return false;
    }

    drone function_a91ebb0263d086f3();
    drone function_622c97b11177264a(config);
    scripts\cp_mp\killstreaks\helper_drone::function_6a275656141ac8d6(drone);

    if(istrue(drone.isthermalenabled)) {
      setthermalvision(1, 12, 1000);
    }
  }

  return true;
}

function function_148a87125a1ece3e() {
  droneowner = self.owner;
  droneowner endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("switch_modes");
  smokegrenadefeature = getdvarint(@ "hash_b432ce13c8a2cac9", 0);

  if(smokegrenadefeature) {
    droneowner notifyonplayercommand("recon_smoke_launch", "+attack");
    droneowner setclientomnvar("ui_killstreak_weapon_1_ammo", 3);
    smokecount = 3;

    while(smokecount > 0) {
      droneowner waittill("recon_smoke_launch");

      if(!self.ispiloted) {
        continue;
      }

      launchorigin = self.origin + anglesToForward(self.angles) * 50;
      launchgoal = scripts\cp_mp\killstreaks\gunship::function_cdf6e1bdfe5b42b5(droneowner);
      launchvelocity = launchgoal - launchorigin;

      thread scripts\cp_mp\utility\debug_utility::drawsphere(launchgoal, 20, 10, (1, 1, 1));

      magicgrenademanual("smoke_grenade_stick_mp", launchorigin, launchvelocity, 2);
      smokecount--;
      droneowner setclientomnvar("ui_killstreak_weapon_1_ammo", smokecount);
    }
  }
}

function function_85b4e9e74b613d68(config) {
  droneowner = self.owner;
  droneowner endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("switch_modes");
  var_820e590cb5620371 = 0;
  self.markingtarget = undefined;

  while(true) {
    if(isDefined(self.targetmarkergroup)) {
      self.targethascoldblooded = 0;
      self.targetisnotinmarkingrange = 0;
      self.anyoneisinmarkingrange = 0;
      targets = self.targetsinouterradius;

      foreach(player in targets) {
        if(var_820e590cb5620371 >= 3) {
          var_820e590cb5620371 = 0;
          waitframe();
        }

        if(scripts\cp_mp\emp_debuff::is_empd()) {
          continue;
        }

        if(isPlayer(player) && issharedfuncdefined("player", "isReallyAlive")) {
          if(![[getsharedfunc("player", "isReallyAlive")]](player)) {
            continue;
          }
        }

        if(isagent(player)) {
          if(!isalive(player)) {
            continue;
          }

          if(isDefined(player.agent_type) && issubstr(player.agent_type, "civilian")) {
            scripts\cp_mp\killstreaks\helper_drone::function_28368a23c20ff3e6(self.targetmarkergroup, player, 3);
            continue;
          }
        }

        if(!isDefined(player)) {
          continue;
        }

        if(function_119a97bfb70a99d6(player)) {
          continue;
        }

        if(function_5e38c3c0ae63e8af(player)) {
          continue;
        }

        var_820e590cb5620371++;
        scripts\cp_mp\killstreaks\helper_drone::function_28368a23c20ff3e6(self.targetmarkergroup, player, 1);
        isvisible = scripts\cp_mp\killstreaks\helper_drone::function_f9c33df98457a9a2(player);
        isinreticle = droneowner function_cccbd62549b4440b(player, 70, 50);
        isinrange = function_26d9d0c6ca7a5a8c(player);
        hascoldblooded = 0;

        if(issharedfuncdefined("perk", "hasPerk")) {
          if(isPlayer(player) && player[[getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
            hascoldblooded = 1;
          }
        }

        if(istrue(player.var_68608ef2e0b39c)) {
          hascoldblooded = 1;
        }

        if(isinreticle && hascoldblooded) {
          self.targethascoldblooded = 1;
        }

        if(isinreticle && !isinrange) {
          self.targetisnotinmarkingrange = 1;
        }

        if(isinrange) {
          self.anyoneisinmarkingrange = 1;
        }

        if(hascoldblooded) {
          scripts\cp_mp\killstreaks\helper_drone::function_28368a23c20ff3e6(self.targetmarkergroup, player, 3);
          continue;
        }

        if((!isinrange || !isvisible) && self.ispiloted) {
          scripts\cp_mp\killstreaks\helper_drone::function_28368a23c20ff3e6(self.targetmarkergroup, player, 0);

          if(self.repeatuse) {
            player thread function_772ede0cce4020ec(self);
          }

          continue;
        }

        if(!isinreticle) {
          continue;
        }

        if(istrue(self.markingtarget)) {
          continue;
        }

        thread function_2fd033ded40b93a9(player, "enemy");
      }
    }

    var_820e590cb5620371 = 0;
    waitframe();
  }
}

function function_dfc402ef72eff688(config) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");
  reticlestate = 0;

  while(true) {
    if(istrue(self.markingtarget) && reticlestate == 0) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 1);
      reticlestate = 1;
    } else if(!istrue(self.markingtarget) && reticlestate == 1) {
      self.owner setclientomnvar("ui_rcd_outer_ring", 0);
      reticlestate = 0;
    }

    waitframe();
  }
}

function function_7730b66241ef6e46(config) {
  self endon("death");
  self endon("leaving");
  self endon("switch_modes");
  self.owner endon("disconnect");

  while(true) {
    if(istrue(self.targethascoldblooded)) {
      self.owner setclientomnvar("ui_rcd_notification", 3);
    } else if(istrue(self.targetisnotinmarkingrange)) {
      self.owner setclientomnvar("ui_rcd_notification", 1);
    } else if(!istrue(self.anyoneisinmarkingrange)) {
      self.owner setclientomnvar("ui_rcd_notification", 2);
    } else {
      self.owner setclientomnvar("ui_rcd_notification", 0);
    }

    waitframe();
  }
}

function function_86e1c4f92c53ccfb(config) {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("switch_modes");
  self.owner endon("disconnect");
  self.targetsinouterradius = [];

  while(true) {
    if(!isDefined(self) || !isDefined(self.owner)) {
      return;
    }

    targetarray = function_7d0db4b7f46e7dc0();

    if(isDefined(level.additionalrecondronetargets)) {
      var_ed5deadf98f2b1bd = [];

      foreach(target in level.additionalrecondronetargets) {
        if(isDefined(target.datakey)) {
          if(issharedfuncdefined("game", "gameFlag")) {
            if([[getsharedfunc("game", "gameFlag")]]("prematch_done")) {
              if(issharedfuncdefined("player", "isPlayerOnIntelChallenge")) {
                if([[getsharedfunc("player", "isPlayerOnIntelChallenge")]](self.owner, target.datakey)) {
                  var_ed5deadf98f2b1bd[var_ed5deadf98f2b1bd.size] = target;
                }
              }
            }
          }

          continue;
        }

        var_ed5deadf98f2b1bd[var_ed5deadf98f2b1bd.size] = target;
      }

      var_d3a3374bbd2c0ec7 = array_combine(targetarray, var_ed5deadf98f2b1bd);
    } else {
      var_d3a3374bbd2c0ec7 = targetarray;
    }

    if(issharedfuncdefined("helper_drone", "get_outer_reticle_targets")) {
      var_d3a3374bbd2c0ec7 = self[[getsharedfunc("helper_drone", "get_outer_reticle_targets")]](config);
    }

    foreach(ent in var_d3a3374bbd2c0ec7) {
      if(!function_2f23cbe83e1e57df(ent)) {
        continue;
      }

      thread function_7b0782113e604198(ent);
    }

    waitframe();
  }
}

function function_7b0782113e604198(target) {
  droneowner = self.owner;
  droneowner endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("switch_modes");

  if(!isDefined(self.targetmarkergroup)) {
    return;
  }

  self.targetsinouterradius[self.targetsinouterradius.size] = target;
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(target, self.targetmarkergroup, 0);

  while(isDefined(target)) {
    if(isPlayer(target) && issharedfuncdefined("player", "isReallyAlive")) {
      if(![[getsharedfunc("player", "isReallyAlive")]](target)) {
        break;
      }
    }

    if(isagent(target) && !isalive(target)) {
      break;
    }

    config = level.helperdronesettings[self.helperdronetype];

    if(istrue(config.var_1947a47c2174d02c) && !self.owner function_cccbd62549b4440b(target, 70, 300)) {
      break;
    }

    if(!function_c26586725702ec8c(target)) {
      break;
    }

    if(!scripts\cp_mp\targetmarkergroups::function_7c253e3d43e44097(target, self.targetmarkergroup)) {
      break;
    }

    waitframe();
  }

  if(isDefined(target)) {
    if(scripts\cp_mp\targetmarkergroups::targetmarkergroupexists(self.targetmarkergroup) && scripts\cp_mp\targetmarkergroups::function_7c253e3d43e44097(target, self.targetmarkergroup) && !function_5e38c3c0ae63e8af(target)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(target, self.targetmarkergroup);
    }

    if(array_contains(self.targetsinouterradius, target)) {
      self.targetsinouterradius = array_remove(self.targetsinouterradius, target);
    }

    return;
  }

  self.targetsinouterradius = array_removeundefined(self.targetsinouterradius);
}

function function_435b4dc89b40e60a(config) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("regain_control");
  self.owner endon("disconnect");
  self waittill("switch_modes");
  groundtracestart = self.origin;
  groundtraceend = self.origin - (0, 0, 10000);
  contentoverride = create_world_contents();
  groundtrace = ray_trace(groundtracestart, groundtraceend, self, contentoverride);
  markingorigin = groundtraceend;

  if(isDefined(groundtrace["hittype"]) && groundtrace["hittype"] != "hittype_none") {
    markingorigin = groundtrace["position"];
  }

  markingradius = 1750;
  markingheight = self.origin[2] - markingorigin[2];

  while(true) {
    var_213fdd3689d4b33e = [self.owner];

    if(level.teambased) {
      var_213fdd3689d4b33e = array_combine(var_213fdd3689d4b33e, level.teamdata[self.team]["players"]);
    }

    potentialtargets = utility::playersincylinder(markingorigin, markingradius, var_213fdd3689d4b33e, markingheight);

    if(issharedfuncdefined("helper_drone", "get_outer_reticle_targets")) {
      potentialtargets = self[[getsharedfunc("helper_drone", "get_outer_reticle_targets")]](config);
    }

    waitforcooldown = 0;

    foreach(target in potentialtargets) {
      if(function_80226370b4c80b06(target)) {
        function_2fd033ded40b93a9(target, "enemy", 1);
        waitforcooldown = 1;
        break;
      }
    }

    if(istrue(waitforcooldown)) {
      wait 3;
      continue;
    }

    wait 0.5;
  }
}

function function_772ede0cce4020ec(drone) {
  drone.owner endon("disconnect");
  level endon("game_ended");
  drone endon("death");
  drone endon("explode");
  drone endon("switch_modes");
  self notify("monitorUnmarking");
  self endon("monitorUnmarking");

  if(!isDefined(drone.targetmarkergroup)) {
    return;
  }

  while(drone.ispiloted) {
    waitframe();
  }

  while(true) {
    if(isPlayer(self) && issharedfuncdefined("player", "isReallyAlive")) {
      if(![[getsharedfunc("player", "isReallyAlive")]](self)) {
        break;
      }
    }

    if(!drone scripts\cp_mp\killstreaks\helper_drone::function_f9c33df98457a9a2(self, 1) || !drone function_26d9d0c6ca7a5a8c(self)) {
      break;
    }

    waitframe();
  }

  scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(self, drone.targetmarkergroup);
}

function function_2fd033ded40b93a9(target, targettype, automarker) {
  droneowner = self.owner;
  droneowner endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self endon("switch_modes");
  markdata = spawnStruct();
  markdata.target = target;
  markdata.targetnum = target getentitynumber();
  markdata.markingent = self;
  markdata.owner = droneowner;
  markdata.ownerteam = droneowner.team;
  markdata.outlineid = undefined;
  markdata.headicon = undefined;
  markdata.beingmarked = undefined;
  markdata.reconmarked = undefined;
  markdata.notifytoendmark = "unmarked_" + markdata.targetnum;

  if(!isDefined(markdata.targetnum)) {
    return;
  }

  if(!isDefined(self.targetmarkergroup) && !istrue(automarker)) {
    return;
  }

  markdata.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("marking_target");
  var_2095b8a1afaaf65e = function_dc5a1ea5eef68f83();
  self.owner playlocalsound("recon_drone_marking_owner");
  self setscriptablepartstate("target_glint", "on");

  if(istrue(automarker)) {
    self setlookatent(target);
  }

  while(var_2095b8a1afaaf65e > 0) {
    if(!isDefined(target)) {
      return;
    }

    isstillvalidtarget = scripts\cp_mp\utility\player_utility::isreallyalive(target) && (istrue(automarker) && scripts\cp_mp\killstreaks\helper_drone::function_f9c33df98457a9a2(target, 1) && function_26d9d0c6ca7a5a8c(target) || droneowner function_cccbd62549b4440b(target, 70, 50));

    if(!isstillvalidtarget) {
      markdata.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner stoplocalsound("recon_drone_marking_owner");
      self setscriptablepartstate("target_glint", "off");
      self clearlookatent();
      return;
    }

    var_2095b8a1afaaf65e -= 0.05;
    wait 0.05;
  }

  if(isDefined(target.recondronemarkedcb)) {
    [[target.recondronemarkedcb]](droneowner, target);
  }

  self clearlookatent();
  self setscriptablepartstate("target_glint", "off");
  thread function_46e2d014d3dbf29b();
  markdata.reconmarked = 1;
  self.markingtarget = undefined;
  function_1be8cc141c0b49cf(markdata, undefined);
  self.owner playlocalsound("recon_drone_marked_owner");
  self.owner stoplocalsound("recon_drone_marking_owner");
  function_c3fafa01f5d05d23(1, markdata.targetnum, markdata.ownerteam, 1);

  if(!istrue(automarker)) {
    scripts\cp_mp\killstreaks\helper_drone::function_28368a23c20ff3e6(self.targetmarkergroup, target, 2);
  }

  function_4f43ed745364f234(target, targettype);

  if(issharedfuncdefined("pers", "incPersStat")) {
    self.owner[[getsharedfunc("pers", "incPersStat")]]("reconDroneMarks", 1);
  }

  if(issharedfuncdefined("supers", "combatRecordSuperMisc")) {
    self.owner[[getsharedfunc("supers", "combatRecordSuperMisc")]]("super_recon_drone");
  }

  self.usedcount++;
  timeout = 5;

  if(issharedfuncdefined("helper_drone", "customMarkDuration")) {
    timeout = [[getsharedfunc("helper_drone", "customMarkDuration")]]();
  }

  if(issharedfuncdefined("perk", "hasPerk")) {
    if(self.owner[[getsharedfunc("perk", "hasPerk")]]("specialty_improved_target_mark")) {
      timeout += 2;
    }
  }

  thread function_4ae03252b19b76b9(markdata, timeout);
}

function function_4f43ed745364f234(target, targettype) {
  if(issharedfuncdefined("player", "doScoreEvent")) {
    self.owner thread[[getsharedfunc("player", "doScoreEvent")]](hashcat(function_1823ff50bb28148d(self.helperdronetype), "_", targettype, "_marked"));
  }

  if(issharedfuncdefined("player", "playerHasMoved")) {
    self.owner thread[[getsharedfunc("player", "playerHasMoved")]]();
  }
}

function function_4ae03252b19b76b9(markdata, timeout) {
  level endon("game_ended");
  target = markdata.target;
  target endon(markdata.notifytoendmark);
  function_c437a23c3ca84a5c(markdata, timeout);
  function_8bf0338c7a157c29(markdata);
}

function function_c437a23c3ca84a5c(markdata, timeout) {
  droneowner = self.owner;
  droneowner endon("disconnect");
  target = markdata.target;
  target endon("death");
  starttime = gettime();

  while(gettime() <= starttime + timeout * 1000) {
    if(isDefined(self) && isDefined(self.owner) && istrue(self.ispiloted) && self.owner function_cccbd62549b4440b(target, 70, 50) && function_26d9d0c6ca7a5a8c(target) && scripts\cp_mp\killstreaks\helper_drone::function_f9c33df98457a9a2(target)) {
      starttime = gettime();
    }

    wait 0.05;
  }
}

function function_1083bf4d55c69e99(markingdrone, target) {
  return array_contains(markingdrone.targetsinouterradius, target);
}

function function_26d9d0c6ca7a5a8c(target) {
  config = level.helperdronesettings[self.helperdronetype];
  var_df1a93029c5dd1e1 = islargemap();
  var_e3b6fa876adec2ab = ter_op(var_df1a93029c5dd1e1, config.var_d5ea718abfc8ff5b, config.var_cb2c3fe0819193eb);
  var_e3b6fa876adec2ab = ter_op(target isswimmingunderwater(), 250000, var_e3b6fa876adec2ab);

  if(isDefined(target.markdistanceoverride)) {
    var_e3b6fa876adec2ab = target.markdistanceoverride;
  }

  targetpos = target.origin;

  if(isPlayer(target)) {
    targetpos = (0, 0, 0);

    if(issharedfuncdefined("player", "isReallyAlive")) {
      targetpos = target[[getsharedfunc("player", "getStanceCenter")]]();
    }
  }

  return distancesquared(self.origin, targetpos) < var_e3b6fa876adec2ab;
}

function function_c26586725702ec8c(target) {
  detectrange = 25000000;

  if(istrue(target isswimmingunderwater())) {
    detectrange = 562500;
  }

  return distancesquared(self.origin, target.origin) < detectrange;
}

function function_a4c00a4b64fcb2fa(target) {
  detectrange = 3062500;

  if(target isswimmingunderwater()) {
    detectrange = 250000;
  }

  return distancesquared(self.origin, target.origin) < detectrange;
}

function function_119a97bfb70a99d6(target) {
  if(!isDefined(self.enemiesmarked)) {
    return false;
  }

  markdata = self.enemiesmarked[target getentitynumber()];

  if(!isDefined(markdata)) {
    return false;
  }

  return isDefined(markdata.beingmarked);
}

function function_5e38c3c0ae63e8af(target) {
  if(!isDefined(self.enemiesmarked)) {
    return false;
  }

  markdata = self.enemiesmarked[target getentitynumber()];

  if(!isDefined(markdata)) {
    return false;
  }

  return istrue(markdata.reconmarked);
}

function function_dc5a1ea5eef68f83() {
  return ter_op(istrue(self.ispiloted), 0.75, 1);
}

function function_50dfdf2d06587791(target, markpos, drone, timeout) {
  markdata = spawnStruct();
  markdata.target = target;
  markdata.targetnum = target getentitynumber();
  markdata.outlineid = undefined;
  markdata.headicon = undefined;
  var_6e2944c35c23a948 = spawn("script_model", markpos);
  var_6e2944c35c23a948 setModel("tag_origin");
  showto = undefined;

  if(level.teambased) {
    showto = [];

    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      if(player.team != self.team) {
        continue;
      }

      showto[showto.size] = player;
    }
  } else {
    showto = self.owner;
  }

  if(!isDefined(showto)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(isarray(showto) && showto.size == 0) {
    assertmsg("<dev string:x5b>");
    return;
  }

  if(true) {
    markicon = "hud_icon_new_marked";

    if(scripts\cp_mp\entityheadicons::function_6ede573723f08c0f()) {
      markicon = "hud_icon_head_marked";
    }

    markdata.headicon = var_6e2944c35c23a948 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(showto, markicon, 15, 1, 5000, 500, undefined, 1, 1);
  }

  thread function_720d2d338e9a63ca(markdata, var_6e2944c35c23a948, timeout);
}

function function_720d2d338e9a63ca(markdata, var_d99ed5531d1fdc1f, timeout) {
  level endon("game_ended");
  waittill_any_timeout_2(timeout, "death", "explode");

  if(isDefined(markdata.icon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(markdata.icon);

    if(isDefined(var_d99ed5531d1fdc1f)) {
      var_d99ed5531d1fdc1f delete();
    }
  }

  if(isDefined(markdata.target)) {
    markdata.target.locationmarked = undefined;
  }

  self.enemiesmarked[markdata.targetnum] = undefined;
}

function function_1be8cc141c0b49cf(markdata, timeout) {
  target = markdata.target;
  self.enemiesmarked[markdata.targetnum] = markdata;
  markicon = "hud_icon_new_marked";

  if(scripts\cp_mp\entityheadicons::function_6ede573723f08c0f()) {
    markicon = "hud_icon_head_marked";
  }

  var_f9cd7fda74e92e2a = 8;

  if(isPlayer(target)) {
    if(false) {
      if(level.teambased) {
        if(issharedfuncdefined("outline", "outlineEnableForTeam")) {
          markdata.outlineid = [[getsharedfunc("outline", "outlineEnableForTeam")]](target, "orange", self.owner.team, 0, 1, 0, "killstreak");
        }
      } else if(issharedfuncdefined("outline", "outlineEnableForPlayer")) {
        markdata.outlineid = [[getsharedfunc("outline", "outlineEnableForPlayer")]](target, "orange", self.owner, 0, 1, 0, "killstreak");
      }

      if(issharedfuncdefined("outline", "hudOutlineViewmodelEnable")) {
        target[[getsharedfunc("outline", "hudOutlineViewmodelEnable")]](5, 0, 1);
      }
    }

    target thread function_d16011cedf620dc6();
    target function_fa08d1d78cf5cb01();
    target playlocalsound("recon_drone_spotted_plr");
  } else if(false) {
    markstruct = function_c938e22803fb2efc(markicon, var_f9cd7fda74e92e2a, target);
    markicon = markstruct.weaponicon;
    var_f9cd7fda74e92e2a = markstruct.weaponoffset;
  }

  if(issharedfuncdefined("pmc_missions", "onReconDroneMarkEnt")) {
    target[[getsharedfunc("pmc_missions", "onReconDroneMarkEnt")]](self.owner, target);
  }

  self.owner scripts\cp_mp\challenges::function_d997435895422ecc("super_recon_drone", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"hit"));
  self.owner notify("marked_target");

  if(true) {
    markdata.headicon = target scripts\cp_mp\entityheadicons::setheadicon_singleimage([], markicon, var_f9cd7fda74e92e2a, 1, 4000, 500, undefined, 1, 1);
    function_200b632d8b4ab566(markdata);
  }

  if(issharedfuncdefined("helper_drone", "watchMarkingEntStatus")) {
    self thread[[getsharedfunc("helper_drone", "watchMarkingEntStatus")]](markdata);
  }
}

function function_d16011cedf620dc6() {
  self endon("disconnect");

  if(istrue(isusingremote())) {
    return;
  }

  visionset = "recon_drone_flash";

  if(istrue(self.pers["useNVG"])) {
    visionset = "recon_drone_flash_nvg";
  }

  self visionsetfadetoblackforplayer(visionset, 0.05);
  wait 0.08;
  self visionsetfadetoblackforplayer("", 1.2);
}

function function_fa08d1d78cf5cb01() {
  if(!isDefined(self.markedomnvar)) {
    self.markedomnvar = 1;
    self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
    thread function_dfa102c1a8648b75();
    return;
  }

  if(self.markedomnvar == 1) {
    self.markedomnvar = 2;
  } else {
    self.markedomnvar = 1;
  }

  self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
}

function function_dfa102c1a8648b75() {
  self endon("disconnect");
  self notify("markedUIUpdate");
  self endon("markedUIUpdate");

  if(issharedfuncdefined("helper_drone", "get_mark_ui_duration")) {
    wait self[[getsharedfunc("helper_drone", "get_mark_ui_duration")]]();
  } else {
    wait 3;
  }

  thread function_a867654273504370();
}

function function_a867654273504370() {
  self notify("markedUIUpdate");
  self.markedomnvar = undefined;
  self setclientomnvar("ui_rcd_target_notify", 0);
}

function function_c938e22803fb2efc(defaulticon, defaultoffset, target) {
  weaponicon = defaulticon;
  weaponoffset = defaultoffset;
  weaponstruct = spawnStruct();

  if(isDefined(target.weapon_name)) {
    weaponref = undefined;

    if(issubstr(target.weapon_name, "claymore")) {
      weaponref = "equip_claymore";
    } else if(issubstr(target.weapon_name, "c4")) {
      weaponref = "equip_c4";
    } else if(issubstr(target.weapon_name, "atMine")) {
      weaponref = "equip_at_mine";
    } else if(issubstr(target.weapon_name, "trophy")) {
      weaponref = "equip_trophy";
    }

    if(isDefined(weaponref)) {
      equipinfo = undefined;

      if(issharedfuncdefined("equipment", "getEquipmentTableInfo")) {
        equipinfo = [[getsharedfunc("equipment", "getEquipmentTableInfo")]](weaponref);
      }

      weaponicon = equipinfo.image;
    }
  } else if(isDefined(target.streakinfo)) {
    streakref = target.streakinfo.streakname;
    streakbundle = level.streakglobals.streakbundles[streakref];
    weaponicon = ter_op(isDefined(streakbundle) && isDefined(streakbundle.overheadicon), streakbundle.overheadicon, "");
    weaponoffset = 75;
  }

  weaponstruct.weaponicon = weaponicon;
  weaponstruct.weaponoffset = weaponoffset;
  return weaponstruct;
}

function function_200b632d8b4ab566(markdata) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }

    function_f1d272b5fc3a575c(markdata, player);
  }
}

function function_f1d272b5fc3a575c(markdata, player) {
  isfriendly = 0;

  if(scripts\engine\utility::issharedfuncdefined("player", "isFriendly")) {
    isfriendly = [[scripts\engine\utility::getsharedfunc("player", "isFriendly")]](markdata.ownerteam, player);
  }

  if(!level.teambased) {
    if(markdata.owner == player) {
      isfriendly = 1;
    }
  }

  isowner = isDefined(markdata.markingent) && isDefined(markdata.markingent.owner) && player == markdata.markingent.owner;
  ispiloted = isDefined(markdata.markingent) && istrue(markdata.markingent.ispiloted);
  ispilot = isowner && ispiloted;

  if(isDefined(markdata.headicon)) {
    if(isfriendly && !ispilot) {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(markdata.headicon, player);
      return;
    }

    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(markdata.headicon, player);
  }
}

function function_8bf0338c7a157c29(markdata) {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(markdata.headicon);

  if(isDefined(markdata.target)) {
    markdata.reconmarked = undefined;
    markdata.beingmarked = undefined;
    function_c3fafa01f5d05d23(1, markdata.targetnum, markdata.ownerteam, 0);

    if(isDefined(self)) {
      self.enemiesmarked[markdata.targetnum] = undefined;
    }

    if(isPlayer(markdata.target) && false) {
      if(issharedfuncdefined("outline", "outlineDisable")) {
        [[getsharedfunc("outline", "outlineDisable")]](markdata.outlineid, markdata.target);
      }

      if(issharedfuncdefined("outline", "hudOutlineViewmodelDisable")) {
        markdata.target[[getsharedfunc("outline", "hudOutlineViewmodelDisable")]]();
      }
    }

    if(isDefined(self) && isDefined(self.targetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(markdata.target, self.targetmarkergroup);
    }

    markdata.target notify(markdata.notifytoendmark);
    return;
  }

  if(isDefined(self)) {
    self.enemiesmarked[markdata.targetnum] = undefined;
  }
}

function recondrone_exit() {
  if(istrue(self.repeatuse)) {
    self.owner stopwatchingthermalinputchange();
    self.owner setclientomnvar("ui_block_fu_not_ready_error", 1);
    self notify("switch_modes");

    if(isDefined(self.targetmarkergroup)) {
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetmarkergroup);
      self.targetmarkergroup = undefined;
    }

    if(scripts\cp_mp\emp_debuff::is_empd()) {
      scripts\cp_mp\killstreaks\helper_drone::function_ffbc19e1aef5943c(0);
    }

    function_86ff095469a70cd2();
    function_8321764da9dead70(self.owner);

    if(isDefined(self.owner.super) && isDefined(self.owner.super.staticdata) && isDefined(self.owner.super.staticdata.id)) {
      self.owner setclientomnvar("ui_field_upgrade_use", self.owner.super.staticdata.id);
    }

    thread function_fcd08c370fe30d2c(self.origin);

    if(iscp() && isDefined(self.oob) && self.oob == 1) {
      thread recondrone_leave();
    }

    return;
  }

  thread recondrone_leave();
}

function function_fcd08c370fe30d2c(var_b01459d2cac1c01f) {
  level endon("game_ended");
  self endon("death");
  self endon("explode");
  self.owner endon("droneStart");
  wait 0.05;
  recondronesettings = level.helperdronesettings[self.helperdronetype];
  var_924ab4970806f758 = recondronesettings.speed;
  var_9de2a251a918a33b = recondronesettings.accel;
  autospeed = recondronesettings.speed * 0.5;
  var_acb0183e038bb06 = recondronesettings.accel * 2;
  autodecel = var_acb0183e038bb06 * 0.5;
  self vehicle_setspeed(autospeed, var_acb0183e038bb06, autodecel);
  self sethoverparams(1, 5, 5);
  self setvehgoalpos(var_b01459d2cac1c01f, 1);
  self waittill("goal");
  var_46104ff95396dbce = 200;
  var_a5de0629edcd96a2 = var_46104ff95396dbce * var_46104ff95396dbce;

  while(true) {
    if(distancesquared(self.origin, var_b01459d2cac1c01f) >= var_a5de0629edcd96a2) {
      self setvehgoalpos(var_b01459d2cac1c01f, 1);
      self waittill("goal");
    }

    waitframe();
  }
}

function recondrone_leave(timeout) {
  thread scripts\cp_mp\killstreaks\helper_drone::function_6edfda4764129e3(0, 1, timeout);
}

function recondrone_explode(config, wasdestroyed, wasexited, wastimedout, wasdetonated, thirdperson) {
  if(issharedfuncdefined("game", "clearOOB")) {
    [[getsharedfunc("game", "clearOOB")]](self, 1);
  }

  scripts\cp_mp\emp_debuff::clear_emp(1);

  if(isDefined(self.ispiloted) && istrue(self.ispiloted)) {
    function_8321764da9dead70(self.owner);
  }

  if(isDefined(self.owner) && isDefined(self.owner.super)) {
    self.owner setclientomnvar("ui_block_fu_not_ready_error", 0);
    self.owner setclientomnvar("ui_field_upgrade_use", 0);
  }

  scripts\cp_mp\killstreaks\helper_drone::function_24085a0230958938();
}

function function_8321764da9dead70(player) {
  if(!isDefined(player)) {
    return;
  }

  if(isDefined(level.var_f56a88761038798b)) {
    thread[[level.var_f56a88761038798b]](self.streakinfo);
  }

  dronetype = self.helperdronetype;
  config = level.helperdronesettings[dronetype];
  self.ispiloted = 0;

  if(issharedfuncdefined("supers", "setSuperIsActive")) {
    self.owner thread[[getsharedfunc("supers", "setSuperIsActive")]](0);
  }

  if(isDefined(self.playersfx)) {
    self.playersfx delete();
  }

  if(isDefined(self.enemiesmarked)) {
    foreach(markdata in self.enemiesmarked) {
      function_f1d272b5fc3a575c(markdata, player);
    }
  }

  tabletweapon = "ks_remote_drone_mp";

  if(istrue(self.var_eee5ddaafc619fa3)) {
    tabletweapon = "ks_remote_device_mp";
  }

  player thread recondrone_takedeployweapon(1, tabletweapon);
  player scripts\cp_mp\killstreaks\helper_drone::helperdrone_takeplayerfauxremote(self.streakinfo);
  player painvisionon();
  player killstreak_setmainvision("");

  if(istrue(self.isthermalenabled)) {
    player setthermalvision(0);
  }

  player thread scripts\cp_mp\killstreaks\helper_drone::function_f23d90f7483d67e4();
  player cameraunlink();

  if(!istrue(self.var_d31453e33d3e34ca)) {
    player remotecontrolvehicleoff();
  }

  if(iscp()) {
    level callback::callback("killstreak_finish_use", {
      #streakinfo: self.streakinfo
    });
  }

  player _freezecontrols(0, 1, "reconDrone");
  player _freezelookcontrols(0, 1);
  player val::group_reset("reconDrone_switch");
  player val::group_reset("reconDrone_deploy");
  player val::group_reset("reconDrone_use");
  player scripts\cp_mp\utility\render_utility::function_e2eae50826e12247();
  scripts\cp_mp\utility\killstreak_utility::movingplatform_playerunlink(player);

  if(isreallyalive(player) && isDefined(player.restoreangles)) {
    player setplayerangles((player.restoreangles[0], player.restoreangles[1], 0));
  }

  player.restoreangles = undefined;
  player killstreak_restorenvgstate();
}

function recondrone_beginsuper() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  streakinfo = spawnStruct();
  streakinfo.streakname = "radar_drone_recon";
  streakinfo.weaponname = "ks_remote_drone_mp";
  streakinfo.issuper = 1;
  streakinfo.superid = level.superglobals.staticsuperdata["super_recon_drone"].id;
  streakinfo.superref = level.superglobals.staticsuperdata["super_recon_drone"].ref;
  childthread scripts\cp_mp\killstreaks\helper_drone::function_34280b807c23a453(streakinfo.streakname);

  if(!isDefined(self.recondronesafespawn)) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
    }

    return false;
  }

  if(!scripts\cp_mp\killstreaks\helper_drone::tryusehelperdroneearlyout(streakinfo, 1)) {
    self.recondronereserved = 1;
    thread recondrone_watchcleanupreserved(streakinfo, 0);

    if(scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      self.reconvehiclereserved = 1;
      thread recondrone_watchcleanupreserved(streakinfo, 1);

      if(recondrone_givedeployweapon("ks_remote_drone_mp")) {
        thread recondrone_watchsuper(streakinfo);
        scripts\cp_mp\challenges::function_d997435895422ecc("super_recon_drone", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
        return true;
      } else {
        val::group_reset("reconDrone_switch");
        thread recondrone_takedeployweapon(1, "ks_remote_drone_mp");
        thread recondrone_cleanupreserved(streakinfo, 1);
      }
    } else {
      thread recondrone_cleanupreserved(streakinfo, 0);
    }
  }

  return false;
}

function recondrone_endsuper(fromdeath) {
  self notify("reconDroneEnded");
  self.recondronesafespawn = undefined;

  if(isDefined(self.recondronerefund)) {
    self.recondronerefund = undefined;

    if(issharedfuncdefined("supers", "giveSuperPoints") && issharedfuncdefined("supers", "getSuperPointsNeeded")) {
      self[[getsharedfunc("supers", "giveSuperPoints")]]([[getsharedfunc("supers", "getSuperPointsNeeded")]]());
    }
  }

  if(isDefined(self.recondronereserved)) {
    self.recondronereserved = undefined;
    streakinfo = spawnStruct();
    streakinfo.streakname = "radar_drone_recon";
    recondrone_cleanupreserved(streakinfo);
  }

  if(isDefined(self.reconvehiclereserved)) {
    self.reconvehiclereserved = undefined;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }
}

function recondrone_watchsuper(streakinfo) {
  self endon("disconnect");
  result = recondrone_watchsuperinternal(streakinfo);

  if(!istrue(result)) {
    val::group_reset("reconDrone_switch");
    val::group_reset("reconDrone_deploy");
    thread recondrone_takedeployweapon(1, "ks_remote_drone_mp");

    if(issharedfuncdefined("supers", "superUseFinished")) {
      self thread[[getsharedfunc("supers", "superUseFinished")]](1);
    }

    return;
  }

  if(!istrue(level.helperdronesettings["radar_drone_recon"].repeatuse) && issharedfuncdefined("supers", "superUseFinished")) {
    self thread[[getsharedfunc("supers", "superUseFinished")]](0);
  }
}

function recondrone_watchsuperinternal(streakinfo) {
  self endon("death");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  thread recondrone_watchsuperendfromswitch();

  if(issharedfuncdefined("reconDrone", "onSuperStarted")) {
    self[[getsharedfunc("reconDrone", "onSuperStarted")]]();
  }

  val::group_set("reconDrone_deploy", 0);
  _freezecontrols(1, undefined, "reconDrone");
  wait 1.85;
  childthread scripts\cp_mp\killstreaks\helper_drone::function_34280b807c23a453(streakinfo.streakname);
  wait 0.15;

  if(level.gameended) {
    self.recondronesafespawn = undefined;
  }

  isinlaststand = 0;

  if(issharedfuncdefined("player", "isInLastStand")) {
    isinlaststand = [[getsharedfunc("player", "isInLastStand")]](self);
  }

  if(isDefined(self.recondronesafespawn) && !isinlaststand) {
    self.reconvehiclereserved = undefined;
    thread recondrone_watchcleanupreserved(streakinfo, 0);
    recondrone = recondrone_create(self.recondronesafespawn, self.angles, streakinfo.streakname, streakinfo);
    self.recondronesafespawn = undefined;

    if(isDefined(recondrone)) {
      thread scripts\cp_mp\killstreaks\helper_drone::helperdrone_giveplayerfauxremote(streakinfo);
      recondrone recondrone_addtolists(recondrone, self);
      scripts\cp_mp\killstreaks\helper_drone::function_c3786c4fba09c2f2(streakinfo);
      thread scripts\cp_mp\killstreaks\helper_drone::starthelperdrone(recondrone);

      if(issharedfuncdefined("sound", "trySayLocalSound")) {
        level thread[[getsharedfunc("sound", "trySayLocalSound")]](self, #"bc_killstreak_action_recon");
      }

      isbr = issharedfuncdefined("game", "isBRStyleGameType") && [[getsharedfunc("game", "isBRStyleGameType")]]();

      if(isbr) {
        recondrone vehicleshowonminimap(0);
      }

      scripts\cp_mp\utility\killstreak_utility::playkillstreakusedialog(streakinfo.streakname);
      recondrone scripts\cp_mp\killstreaks\helper_drone::helperdrone_notifyenemyplayersinrange(streakinfo.streakname);
      self notify("successful_recon_deployment");
      return true;
    } else {
      scripts\cp_mp\killstreaks\helper_drone::helperdronecreationfailedfx(streakinfo.streakname);
      _freezecontrols(0, 1, "reconDrone");
    }
  } else {
    scripts\cp_mp\killstreaks\helper_drone::helperdronecreationfailedfx(streakinfo.streakname);
    _freezecontrols(0, 1, "reconDrone");
  }

  if(issharedfuncdefined("hud", "showErrorMessage")) {
    self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
  }

  self notify("failed_recon_deployment");
  return false;
}

function recondrone_watchsuperendfromswitch() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  self endon("reconDrone_watchSuperEndFromSwitch");
  objweapon = makeweapon("ks_remote_drone_mp");

  while(true) {
    if(self getcurrentweapon() != objweapon) {
      break;
    }

    waitframe();
  }
}

function recondrone_unsetsuper(fromdeath) {
  self notify("reconDroneUnset");

  if(true) {
    recondrone = self.recondronesuper;

    if(isDefined(recondrone)) {
      if(!istrue(recondrone.isdestroyed)) {
        recondrone scripts\cp_mp\killstreaks\helper_drone::function_ba1c5496f8fc5f67();
      }
    }
  }

  thread recondrone_endsuper(fromdeath);
}

function recondrone_givedeployweapon(deployweaponname, existingdrone) {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponTaken");
  self endon("redeploy_drone_use");
  self notify("reconDroneWeaponGiven");
  self endon("reconDroneWeaponGiven");
  objweapon = makeweapon(deployweaponname);

  if(!self hasweapon(objweapon) && objweapon.basename != "none") {
    _giveweapon(objweapon);
  }

  val::group_set("reconDrone_switch", 0);
  thread function_7c3dc10c6270b3c8("melee_swipe_start", objweapon);
  thread function_7c3dc10c6270b3c8("weapon_change", objweapon);
  thread function_7c3dc10c6270b3c8("player_isHaywire", objweapon);

  if(isDefined(existingdrone)) {
    thread function_31cc8545b41badca(existingdrone, objweapon);
  }

  result = domonitoredweaponswitch(objweapon);
  return result;
}

function function_7c3dc10c6270b3c8(actionnotify, deployweapon) {
  self endon("death_or_disconnect");
  self endon("recon_drone_cancel");
  self endon("droneStart");
  level endon("game_ended");
  self waittill(actionnotify);

  if(isswitchingtoweaponwithmonitoring(deployweapon)) {
    abortmonitoredweaponswitch(deployweapon);
  }

  self notify("recon_drone_cancel");
}

function function_31cc8545b41badca(drone, deployweapon) {
  self endon("death_or_disconnect");
  self endon("recon_drone_cancel");
  self endon("droneStart");
  level endon("game_ended");
  drone waittill_any_2("death", "explode");

  if(isswitchingtoweaponwithmonitoring(deployweapon)) {
    abortmonitoredweaponswitch(deployweapon);
  }

  _freezelookcontrols(0, 1);
  val::group_reset("reconDrone_switch");
  self notify("recon_drone_cancel");
}

function recondrone_takedeployweapon(forceremove, deployweaponname) {
  self endon("death_or_disconnect");
  self endon("reconDroneWeaponGiven");
  self notify("reconDroneWeaponTaken");
  self endon("reconDroneWeaponTaken");

  if(!isDefined(deployweaponname)) {
    return 0;
  }

  objweapon = makeweapon(deployweaponname);

  if(istrue(forceremove)) {
    if(isswitchingtoweaponwithmonitoring(objweapon)) {
      abortmonitoredweaponswitch(objweapon);
      return;
    }
  }

  if(istrue(forceremove)) {
    getridofweapon(objweapon);
  }

  scripts\common\values::group_reset("reconDrone_switch");
}

function recondrone_watchcleanupreserved(streakinfo, vehiclereserved) {
  self notify("reconDrone_cleanupReserved");
  self endon("reconDrone_cleanupReserved");
  self waittill("disconnect");
  thread recondrone_cleanupreserved(streakinfo, vehiclereserved);
}

function recondrone_cleanupreserved(streakinfo, vehiclereserved) {
  self notify("reconDrone_cleanupReserved");

  if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]](1);
  }

  scripts\cp_mp\killstreaks\helper_drone::function_c3786c4fba09c2f2(streakinfo);

  if(istrue(vehiclereserved)) {
    if(istrue(self.reconvehiclereserved)) {
      self.reconvehiclereserved = undefined;
    }

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }
}

function recondrone_addtolists(drone, owner) {
  owner.recondronesuper = drone;
  owner.pausesuperpointsovertime = 1;
  id = drone getentitynumber();

  if(!isDefined(level.recondronesupers)) {
    level.recondronesupers = [];
  }

  level.recondronesupers[id] = drone;
  thread recondrone_removefromlistsondeath(drone, owner, id);
}

function recondrone_removefromlists(drone, owner, id) {
  if(isDefined(drone)) {
    drone notify("reconDrone_removeFromLists");
    id = drone getentitynumber();
  }

  if(isDefined(owner)) {
    owner.recondronesuper = undefined;
    owner.pausesuperpointsovertime = 0;
  }

  if(isDefined(level.recondronesupers)) {
    level.recondronesupers[id] = undefined;
  }
}

function recondrone_removefromlistsondeath(drone, owner, id) {
  drone endon("reconDrone_removeFromLists");
  drone waittill("death");
  thread recondrone_removefromlists(drone, owner, id);
}

function function_39cba2c62062f32e() {
  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(drone in level.supportdrones) {
      if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, drone.owner))) {
        if(isDefined(drone.enemiesmarked) && isDefined(drone.enemiesmarked[self getentitynumber()])) {
          return true;
        }
      }
    }
  }

  return false;
}

function function_cccbd62549b4440b(scantarget, scanfov, var_5e43b44751d01b1a) {
  inreticle = 0;
  defaultorigin = scantarget.origin;

  if(isDefined(scantarget.recondronetraceoffset)) {
    defaultorigin += scantarget.recondronetraceoffset;
  }

  var_20c094516733ffb1 = [defaultorigin];

  if(isPlayer(scantarget)) {
    headpos = scantarget scripts\cp_mp\utility\player_utility::getstancetop();
    centerpos = scantarget scripts\cp_mp\utility\player_utility::getstancecenter();
    var_20c094516733ffb1 = [headpos, centerpos, defaultorigin];
  } else if(isagent(scantarget)) {
    var_20c094516733ffb1 = [defaultorigin + (0, 0, 1)];
  }

  foreach(point in var_20c094516733ffb1) {
    if(self worldpointinreticle_circle(point, scanfov, var_5e43b44751d01b1a)) {
      inreticle = 1;
      break;
    }
  }

  return inreticle;
}

function function_2f23cbe83e1e57df(potentialtarget) {
  config = level.helperdronesettings[self.helperdronetype];

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    return false;
  }

  if(isPlayer(potentialtarget)) {
    if(issharedfuncdefined("player", "isReallyAlive")) {
      if(![[getsharedfunc("player", "isReallyAlive")]](potentialtarget)) {
        return false;
      }
    }

    if(!istrue(config.var_6a390682c21bc49e)) {
      if(issharedfuncdefined("perk", "hasPerk")) {
        if(potentialtarget[[getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          return false;
        }
      }
    }
  }

  if(isagent(potentialtarget)) {
    if(!isalive(potentialtarget)) {
      return false;
    }
  }

  if(level.teambased) {
    if(isDefined(potentialtarget.team) && potentialtarget.team == self.team) {
      return false;
    }
  } else {
    if(isPlayer(potentialtarget) && potentialtarget == self.owner) {
      return false;
    }

    if(isDefined(potentialtarget.owner) && potentialtarget.owner == self.owner) {
      return false;
    }
  }

  if(!function_c26586725702ec8c(potentialtarget)) {
    return false;
  }

  if(function_5e38c3c0ae63e8af(potentialtarget)) {
    return false;
  }

  if(function_1083bf4d55c69e99(self, potentialtarget)) {
    return false;
  }

  config = level.helperdronesettings[self.helperdronetype];

  if(istrue(config.var_1947a47c2174d02c) && !self.owner function_cccbd62549b4440b(potentialtarget, 70, 300)) {
    return false;
  }

  return true;
}

function function_80226370b4c80b06(potentialtarget) {
  config = level.helperdronesettings[self.helperdronetype];

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    return false;
  }

  if(isPlayer(potentialtarget)) {
    if(issharedfuncdefined("player", "isReallyAlive")) {
      if(![[getsharedfunc("player", "isReallyAlive")]](potentialtarget)) {
        return false;
      }
    }

    if(issharedfuncdefined("perk", "hasPerk")) {
      if(potentialtarget[[getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
        return false;
      }
    }
  }

  if(isagent(potentialtarget)) {
    if(!isalive(potentialtarget)) {
      return false;
    }

    if(isDefined(potentialtarget.agent_type) && issubstr(potentialtarget.agent_type, "civilian")) {
      return false;
    }
  }

  if(!scripts\cp_mp\killstreaks\helper_drone::function_f9c33df98457a9a2(potentialtarget, 1)) {
    return false;
  }

  if(function_5e38c3c0ae63e8af(potentialtarget)) {
    return false;
  }

  return true;
}

function function_46e2d014d3dbf29b() {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("flash_glint", "on");
  wait 0.3;
  self setscriptablepartstate("flash_glint", "off");
}

function function_85f0fd88983d1893(data) {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");

  if(!isDefined(self.owner)) {
    return;
  }

  if(isDefined(data.attacker) && isDefined(data.inflictor) && self.currenthealth > 0) {
    self dodamage(self.maxhealth, self.origin, data.attacker, data.inflictor);
  }
}

function function_31b413d9b6abe7f8(data) {
  self setscriptablepartstate("ddos", "disabled", 0);

  if(!isDefined(self.owner)) {
    return;
  }

  if(istrue(self.ispiloted)) {
    self.owner _freezecontrols(1);
    thread scripts\cp_mp\emp_debuff::play_scramble_for_player_until_cleared(self.owner, 5);
    scripts\cp_mp\killstreaks\helper_drone::function_ffbc19e1aef5943c(1);
  }
}

function function_41f3461c40e5a87c(data) {
  if(!isDefined(self.owner)) {
    return;
  }

  if(isDefined(data.attacker)) {
    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("disabled_recon_drone", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    }
  }
}

function function_6a90d81d42854ecd(isdeath) {
  self setscriptablepartstate("ddos", "neutral", 0);

  if(!isDefined(self.owner)) {
    return;
  }

  if(istrue(self.ispiloted)) {
    self.owner _freezecontrols(0);
    scripts\cp_mp\killstreaks\helper_drone::function_ffbc19e1aef5943c(0);
  }
}

function function_7d0db4b7f46e7dc0() {
  targetarray = [];
  contentoverride = create_world_contents();
  cameraorigin = self.owner getvieworigin();
  detectionorigin = cameraorigin + anglesToForward(self.owner getplayerangles()) * 5000;
  ignoreents = [self];
  viewtrace = scripts\engine\trace::ray_trace(cameraorigin, detectionorigin, ignoreents, contentoverride);

  if(viewtrace["hittype"] != "hittype_none") {
    detectionorigin = viewtrace["position"];
  }

  if(getdvarint(@ "hash_39582696895063e7", 0)) {
    level thread scripts\cp_mp\utility\debug_utility::drawline(cameraorigin, detectionorigin, 0.05, (1, 1, 1));
    level thread scripts\cp_mp\utility\debug_utility::drawsphere(detectionorigin, 50, 0.05, (1, 1, 1));
  }

  targetarray = utility::function_2d7fd59d039fa69b(detectionorigin, 2500);
  return targetarray;
}

function function_157c2bcd50ca6207() {
  recondrone = self.recondronesuper;
  return isDefined(recondrone) && !istrue(recondrone.isdestroyed);
}

function function_e08e7ed0591c3438() {
  setdevdvar(@ "hash_60a091e2e6da3352", 0);

  while(true) {
    if(getdvarint(@ "hash_60a091e2e6da3352") != 0) {
      setdevdvar(@ "hash_60a091e2e6da3352", 0);

      if(level.players.size < 1) {
        iprintlnbold("<dev string:xa8>");
        continue;
      }

      firstplayer = level.players[0];
      firstplayer thread function_d16011cedf620dc6();
      firstplayer function_fa08d1d78cf5cb01();
      firstplayer playlocalsound("<dev string:xe6>");
    }

    waitframe();
  }
}

# /