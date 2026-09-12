/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\airdrop.gsc
*************************************************/

function init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "init")]]();
  }

  level._effect["airdrop_crate_impact"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepkg_landing_dust.vfx");
  level._effect["airdrop_crate_capture"] = loadfx("vfx/iw8_mp/killstreak/vfx_carepackage_base_fx_fade.vfx");
  level.carepackagedropnodes = getEntArray("carepackage_drop_area", "targetname");
  initkillstreak();
  initheli();
  initcratedata();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "airdropMultipleInit")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "airdropMultipleInit")]]();
    return;
  }
}

function initkillstreak() {}

function initheli() {
  level.littlebirds = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerScoreInfo")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerScoreInfo")]]();
    return;
  }
}

function initcratedata() {
  var_0 = spawnStruct();
  var_0.configs = [];
  var_0.crates = [];
  var_0.usablecrates = [];
  level.cratedata = var_0;
  level.cratedata.ref_13F28 = pow(getdvarfloat("scr_crateUnresolvedCollisionToleranceSqr", 2), 2);
  level.mpplayerallowcrateuse = &scripts\common\utility::allow_crate_use;
  level.cratedata.mountmantlemodel = getEnt("care_package_col", "targetname");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerActionSet")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerActionSet")]]();
  }

  var_2 = "mp";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  switch (var_2) {
    case "cp_survival":
    case "cp_wave_sv":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "getGameModeSpecificCrateData")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "getGameModeSpecificCrateData")]]();
      }
    case "br":
      initbattleroyalecratedata();
      initbattleroyaleloadoutcratedata();
      teammateoutlineids();
      teamplunderexfil();
      teammatereviveweaponwaitputaway();
      teamplunderexfilshowviponly();
      teamplacement();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "brGetGameModeSpecificCrateData")) {
        var_3 = spawnStruct();
        var_3.model = relic_landlocked_do_explosion();
        var_3.ref_140A1 = 0.5;
        var_3.ref_1409F = 3;
        var_3.usefov = 180;
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "brGetGameModeSpecificCrateData")]](var_3);
      }
    case "arm":
      initarmcratedata();
      initkillstreakcratedata();
      initbattleroyalecratedata();
    case "grnd":
    case "infect":
      initdropzonekillstreakcratedata();
      break;
    default:
      initkillstreakcratedata();
      break;
  }

  initcratedropdata();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerPlayerFrameUpdateCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerPlayerFrameUpdateCallback")]](&ref_13C46);
  }

  thread watchallcrateusability();
}

function getleveldata(var_0) {
  var_1 = level.cratedata.configs[var_0];

  if(!isDefined(var_1)) {
    var_1 = getemptyleveldata();
    level.cratedata.configs[var_0] = var_1;
  }

  return var_1;
}

function getemptyleveldata() {
  var_0 = spawnStruct();
  var_0.friendlymodel = "military_carepackage_01_friendly";
  var_0.enemymodel = "military_carepackage_01_enemy";
  var_0.dummymodel = "military_carepackage_01_dummy";
  var_0.setplayerbeingrevivedextrainfo = 27.5;
  var_0.mountmantlemodel = getdefaultmountmantlemodel();
  var_0.objweapon = isundefinedweapon();
  var_0.timeout = 90;
  var_0.headiconoffset = 0;
  var_0.headicondrawrange = 10000;
  var_0.headiconnaturalrange = 400;
  var_0.minimapicon = "icon_minimap_carepackage";
  var_0.usetag = "tag_use";
  var_0.userange = 128;
  var_0.breakuserangesqr = 30625;
  var_0.usefov = 360;
  var_0.usepriority = 0;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 3;
  var_0.friendlyuseonly = 0;
  var_0.navobstaclebounds = (30, 10, 64);
  var_0.navobstacleupdatedistsqr = 64;
  var_0.dangerzoneheight = 1000;
  var_0.dangerzoneradius = 128;
  var_0.activatecallback = undefined;
  var_0.deactivatecallback = undefined;
  var_0.capturecallback = undefined;
  var_0.rerollcallback = undefined;
  var_0.destroycallback = undefined;
  var_0.destroyoncapture = 1;
  var_0.onecaptureperplayer = 0;
  var_0.destroyvisualscallback = getdefaultdestroyvisualscallback();
  var_0.destroyvisualsdeletiondelay = getdefaultdestroyvisualsdeletiondelay();
  var_0.capturevisualscallback = getdefaultcapturevisualscallback();
  var_0.capturevisualsdeletiondelay = getdefaultcapturevisualsdeletiondelay();
  var_0.capturestring = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  var_0.rerollstring = &"KILLSTREAKS_HINTS/UAV_REROLL";
  var_0.headicon = "hud_icon_head_killstreak_carepackage";
  var_0.supportsreroll = 0;
  var_0.supportsownercapture = 1;
  var_0.supportsothercapture = 1;
  return var_0;
}

function hasleveldata(var_0) {
  return isDefined(level.cratedata.configs[var_0]);
}

function createcrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = getleveldata(var_2);

  if(var_10.supportsownercapture) {}

  if(var_10.supportsreroll) {}

  var_11 = spawn("script_model", var_3);
  var_11.angles = var_4;

  if(!istrue(var_7) && var_2 != "battle_royale_c130_loot" || var_2 != "battle_royale_loadout") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
      if(var_11[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
        var_11 delete();
        return undefined;
      }
    }
  }

  var_11.owner = var_0;
  var_11.team = var_1;
  var_11.objweapon = var_10.objweapon;
  var_11.cratetype = var_2;
  var_11.useobject = undefined;
  var_11.navobstacle = undefined;
  var_11.headiconid = undefined;
  var_11.minimapid = undefined;
  var_11.dangerzoneid = undefined;
  var_11.navobstacleid = undefined;
  var_11.destination = var_5;
  var_11.headiconactive = 0;
  var_11.minimapiconactive = 0;
  var_11.hasnophysics = istrue(var_6);
  var_11.physicsactivated = 0;
  var_11.isdestroyed = 0;
  var_11.data = var_8;
  var_11.skipminimapicon = var_9;
  var_11.headicon = var_10.headicon;
  var_11.minimapicon = var_10.minimapicon;
  var_11.capturestring = var_10.capturestring;
  var_11.rerollstring = var_10.rerollstring;
  var_11.supportsreroll = var_10.supportsreroll;

  if(level.gametype == "infect") {
    var_11.validate_station = 1;
  }

  var_11 setModel(var_10.dummymodel);
  var_11 setnodeploy(1);
  var_11 setCanDamage(0);
  var_11 makeunusable();
  var_11 enableplayermarks("killstreak");

  if(level.teambased) {
    var_11 filteroutplayermarks(var_11.team);
  } else {
    var_11 filteroutplayermarks(var_11.owner);
  }

  var_12 = undefined;

  if(isDefined(var_10.friendlymodel)) {
    var_12 = spawn("script_model", var_3);
    var_12.angles = var_4;
    var_12.crate = var_11;
    var_12 setModel(var_10.friendlymodel);
    var_12 linkTo(var_11);
    var_11.childoutlineents = [var_12];
  } else {
    var_12 = var_11;
  }

  var_11.friendlymodel = var_12;
  var_13 = undefined;

  if(isDefined(var_10.enemymodel)) {
    if(level.teambased) {}

    var_13 = spawn("script_model", var_3);
    var_13.angles = var_4;
    var_13.cratedata = var_11;
    var_13 setModel(var_10.enemymodel);
    var_13 linkTo(var_11);
  }

  var_11.enemymodel = var_13;

  if(isDefined(var_11.enemymodel)) {
    thread watchvisibility();
  }

  var_14 = undefined;

  if(!var_11.hasnophysics) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() != "br") {
        var_14 = spawn("script_model", var_3 + (0, 0, 300));
        var_14 setscriptmoverkillcam("explosive");

        if(isDefined(self.scenenode)) {
          if(var_7) {
            thread looselinkTo(var_14, var_11);
          } else {
            var_14 linkTo(var_11);
          }
        }
      }
    }
  }

  if(isDefined(var_11.owner)) {
    var_11.owner.unset_relic_ammo_drain = 1;
  }

  var_11.killcament = var_14;
  var_15 = createmountmantlemodel(var_11);

  if(!var_15) {
    var_11.unresolved_collision_func = &crateunresolvedcollisioncallback;
  }

  addtolists(var_11);

  if(!scripts\engine\utility::is_equal(level.script, "mp_bm_tut")) {
    thread watchcratedestroyearly();
  }

  if(var_11.hasnophysics) {
    activatecratefirsttime(var_11);
  } else if(var_7) {
    infinite_chopper(var_11);
  }

  return var_11;
}

function activatecratefirsttime() {
  activatecrate(1);
}

function activatecrate(var_0) {
  self notify("activateCrate");
  self.unset_relic_amped = undefined;

  if(istrue(self.destroyonactivate)) {
    thread destroycrate();
    return;
  }

  _createnavobstacle();
  self notify("crate_dropped");

  if(istrue(self.waitforobjectiveactivate)) {
    self waittill("objective_activate");
  }

  if(istrue(var_0) && self.cratetype != "battle_royale_loadout" && !istrue(self.skipminimapicon)) {
    createminimapicon();
  }

  _createheadicon();
  makecrateusable();
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.activatecallback)) {
    self thread[[var_1.activatecallback]](var_0);
    return;
  }
}

function deactivatecrate(var_0) {
  if(istrue(var_0)) {
    destroyminimapicon();
  }

  _destroyheadicon();
  makecrateunusable();
  var_1 = getleveldata(self.cratetype);

  if(isDefined(var_1.deactivatecallback)) {
    self thread[[var_1.deactivatecallback]](var_0);
    return;
  }
}

function capturecrate(var_0) {
  var_1 = getleveldata(self.cratetype);

  if(isDefined(self.owner) && istrue(self.owner.unset_relic_ammo_drain)) {
    self.owner.unset_relic_ammo_drain = 0;
  }

  if(isDefined(var_1.capturecallback)) {
    self thread[[var_1.capturecallback]](var_0);
  }

  if(var_1.destroyoncapture) {
    var_2 = 0;

    if(isDefined(var_1.capturevisualscallback)) {
      self thread[[var_1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel)) {
        self thread[[var_1.capturevisualscallback]](self.enemymodel);
      }

      var_2 = var_1.capturevisualsdeletiondelay;
    }

    thread deletecrate(var_2);
    return;
  }
}

function destroycrate(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  if(!isDefined(var_0)) {
    if(isDefined(self.scenenode)) {
      if(isDefined(self.animdroptime)) {
        if(gettime() >= self.animdroptime) {
          self.destroyonactivate = 1;
          return;
        } else {
          var_0 = 1;
        }
      }
    } else if(istrue(self.physicsactivated)) {
      if(!istrue(self.ref_12332)) {
        self.destroyonactivate = 1;
        return;
      }
    }
  }

  self.destroyonactivate = undefined;
  var_1 = getleveldata(self.cratetype);

  if(isDefined(self.owner) && istrue(self.owner.unset_relic_ammo_drain)) {
    self.owner.unset_relic_ammo_drain = 0;
  }

  if(isDefined(var_1.destroycallback)) {
    self thread[[var_1.destroycallback]](var_0);
  }

  if(!istrue(var_0)) {
    var_2 = undefined;

    if(!istrue(self.physicsactivated) || !istrue(self.ref_12332)) {
      if(isDefined(var_1.destroyvisualscallback)) {
        self thread[[var_1.destroyvisualscallback]](self.friendlymodel);

        if(isDefined(self.enemymodel)) {
          self thread[[var_1.destroyvisualscallback]](self.enemymodel);
        }

        var_2 = var_1.destroyvisualsdeletiondelay;
      }
    } else if(isDefined(var_1.capturevisualscallback)) {
      self thread[[var_1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel)) {
        self thread[[var_1.capturevisualscallback]](self.enemymodel);
      }

      var_2 = var_1.capturevisualsdeletiondelay;
    }

    thread deletecrate(var_2);
    return;
  }

  thread lastactivateinstruct();
}

function deletecrate(var_0) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  self notify("death");
  self.isdestroyed = 1;
  level notify("lootcache_opened_kill_callout" + self.origin);
  var_1 = isDefined(self.friendlymodel) && self.friendlymodel != self;

  if(isDefined(self.scenenode)) {
    if(isDefined(self.scenenode.crates)) {
      self.scenenode.crates[self getentitynumber()] = undefined;
    }

    if(isDefined(self.scenenode.crate)) {
      self.scenenode.crate = undefined;
    }

    self.scenenode = undefined;
  }

  removefromlists(self getentitynumber());
  self disableplayermarks("killstreak");
  self setCanDamage(0);
  self setnonstick(1);

  if(var_1) {
    self hide();
  }

  makecrateunusable();

  if(isDefined(self.useobject)) {
    self.useobject delete();
  }

  destroydangerzone();
  _destroynavobstacle();
  destroymountmantlemodel();
  infilweaponraise();
  destroyminimapicon();
  _destroyheadicon();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(level.script == "mp_don4" && getdvarint("scr_br_x2_hype", 0)) {
    var_2 = spawnfx(level._effect["airdrop_hype_paper_exp"], self.origin);
    triggerfx(var_2);
    self setscriptablepartstate("model", "hide_both");
  }

  wait var_0;

  if(var_1) {
    self.friendlymodel delete();
  }

  if(isDefined(self.enemymodel)) {
    self.enemymodel delete();
  }

  self delete();
}

function lastactivateinstruct() {
  var_0 = level.framedurationseconds;

  if(isDefined(self getlinkedscriptableinstance()) && self getscriptablehaspart("visibility")) {
    self setscriptablepartstate("visibility", "hide", 1);
  }

  deletecrate(var_0);
}

function watchcratedestroyearly() {
  self endon("death");
  var_0 = getleveldata(self.cratetype);

  if(isDefined(var_0.timeout)) {}

  watchcratedestroyearlyinternal(var_0.timeout);

  if(istrue(self.nevertimeout)) {
    return;
  }

  thread destroycrate();
}

function watchcratedestroyearlyinternal(var_0) {
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");

  if(isDefined(var_0)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
    return;
  }

  level waittill("forever");
}

function lb_mg_dmg_factor_tail_rotor() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
      thread destroycrate();
      return;
    }

    return;
  }
}

function initcratedropdata() {
  var_0 = spawnStruct();
  var_0.helis = [];
  var_1 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var_1)) {
    var_0.heliheight = var_1.origin[2] - 750;

    if(issubstr(level.mapname, "aniyah")) {
      var_0.heliheight = var_1.origin[2] + 500;
    }
  } else {
    var_0.heliheight = 850;
  }

  var_0.heliheightoffset = 128;
  level.cratedropdata = var_0;
  initscriptedhelidropdata();
}

function initscriptedhelidropdata() {
  initscriptedhelidropanims();
}

#using_animtree("");

function initscriptedhelidropanims() {
  level.scr_animtree["care_package"] = #animtree;
  level.scr_anim["care_package"]["care_package_drop"] = $mp_carepackage_ckpg_flyin;
  level.scr_animname["care_package"]["care_package_drop"] = "mp_carepackage_ckpg_flyin";
  level.scr_animtree["care_package_chute"] = #animtree;
  level.scr_anim["care_package_chute"]["care_package_drop"] = % mp_carepackage_parachute_flyin;
  level.scr_animname["care_package_chute"]["care_package_drop"] = "mp_carepackage_parachute_flyin";
  initscriptedhelidropvehicleanims();
  teamplunderexfilvipuav();
}

function initscriptedhelidropvehicleanims() {
  level.scr_animtree["care_package_heli"] = #animtree;
  level.scr_anim["care_package_heli"]["care_package_drop"] = $mp_carepackage_lbravo_flyin;
}

function teamplunderexfilvipuav() {
  level.scr_anim["care_package"]["brc130_drop_high"] = % mp_carepackage_ckpg_flyin_10500;
  level.scr_animname["care_package"]["brc130_drop_high"] = "mp_carepackage_ckpg_flyin_10500";
  level.scr_anim["care_package"]["brc130_drop_med"] = $mp_carepackage_ckpg_flyin_7500;
  level.scr_animname["care_package"]["brc130_drop_med"] = "mp_carepackage_ckpg_flyin_7500";
  level.scr_anim["care_package"]["brc130_drop_low"] = % mp_carepackage_ckpg_flyin_3000;
  level.scr_animname["care_package"]["brc130_drop_low"] = "mp_carepackage_ckpg_flyin_3000";
  level.scr_anim["care_package_chute"]["brc130_drop_high"] = % mp_carepackage_parachute_flyin_10500;
  level.scr_animname["care_package_chute"]["brc130_drop_high"] = "mp_carepackage_parachute_flyin_10500";
  level.scr_anim["care_package_chute"]["brc130_drop_med"] = % mp_carepackage_parachute_flyin_7500;
  level.scr_animname["care_package_chute"]["brc130_drop_med"] = "mp_carepackage_parachute_flyin_7500";
  level.scr_anim["care_package_chute"]["brc130_drop_low"] = % mp_carepackage_parachute_flyin_3000;
  level.scr_animname["care_package_chute"]["brc130_drop_low"] = "mp_carepackage_parachute_flyin_3000";
}

function placecrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return createcrate(var_0, var_1, var_2, var_3, var_4, undefined, 1, 0, var_5, var_6);
}

function dropcrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_5)) {
    var_8 = getcratedropcaststart(var_3, 0);
    var_5 = getcratedropdestination(var_8, getcratedropcastend(var_8, 0));
  }

  return createcrate(var_0, var_1, var_2, var_3, var_4, var_5, undefined, 1, var_6, var_7);
}

function dropcratefrommanualheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_3 = getcratedropcaststart(var_3, 1);
  var_9 = var_3[2];

  if(!isDefined(var_7)) {
    var_7 = getcratedropdestination(var_3, getcratedropcastend(var_3, 1));

    if(!isDefined(var_7)) {
      return undefined;
    }
  }

  var_10 = spawnStruct();
  var_10.owner = var_0;
  var_10.team = var_1;
  var_10.hasowner = isDefined(var_0);
  var_4 *= (0, 1, 0);
  var_11 = var_3 + -1 * anglesToForward(var_4) * var_5;
  var_10.dropposition = var_3;
  var_10.exitposition = var_3 + anglesToForward(var_4) * var_6;
  var_12 = undefined;

  if(isDefined(var_8)) {
    var_12 = var_8.vehicleisreserved;
  }

  var_13 = createheli(var_0, var_1, var_11, var_4, var_12);
  var_13.dropstruct = var_10;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
      var_13 vehicle_setspeed(100, 60);
    } else {
      var_13 vehicle_setspeed(200, 100);
    }
  }

  var_13 setmaxpitchroll(15, 15);
  var_13 setscriptablepartstate("lights", "active", 1);
  var_10.heli = var_13;
  var_14 = createcrate(var_0, var_1, var_2, var_11, var_13.angles, var_7, undefined, 0, var_8);
  var_14.dropstruct = var_10;
  var_14 linkTo(var_13, "tag_origin", (16, 0, -156), (0, 0, 0));
  var_10.crate = var_14;
  thread watchdropcratefrommanualheli();
  return var_10;
}

function watchdropcratefrommanualheli() {
  self endon("death");
  watchdropcratefrommanualheliinternal();

  if(isDefined(self.crate)) {
    thread destroycrate();
  }

  if(isDefined(self.heli)) {
    thread destroyheli();
    return;
  }
}

function watchdropcratefrommanualheliinternal() {
  if(self.hasowner) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");
  self.heli setvehgoalpos(self.dropposition, 1);
  self.heli scripts\engine\utility::waittill_notify_or_timeout("death", 2);

  if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
    thread docratedropfrommanualheli();
    return;
  }

  self.heli setyawspeed(40, 20, 20, 0.3);

  if(distancesquared(self.heli.origin, self.dropposition) > 5184) {
    self.heli scripts\engine\utility::ref_143A5("death", "goal");

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      thread docratedropfrommanualheli();
      return;
    }

    self.heli scripts\engine\utility::waittill_notify_or_timeout("death", 0.25);

    if(isDefined(self.crate) && !istrue(self.crate.isdestroyed)) {
      thread docratedropfrommanualheli();
    }

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }

    self.heli scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }

    if(distancesquared(self.heli.origin, self.exitposition) > 5184) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
          self.heli vehicle_setspeed(100, 60);
        } else {
          self.heli vehicle_setspeed(150, 50);
        }
      }

      self.heli setvehgoalpos(self.exitposition, 1);
      self.heli scripts\engine\utility::ref_143A5("death", "goal");
      return;
    }

    return;
  }
}

function docratedropfrommanualheli() {
  var_0 = self.crate;
  self.crate.dropstruct = undefined;
  self.crate = undefined;
  infinite_chopper(var_0);
}

function createcrateforscripteddrop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = createcrate(var_0, var_1, var_2, var_8.origin, var_8.angles, var_3, var_4, var_5, var_6);

  if(!isDefined(var_11)) {
    return undefined;
  }

  var_11.scenenode = var_8;
  var_11.streakinfo = var_7;

  if(!isDefined(var_8.crates)) {
    var_8.crates = [];
  }

  var_8.crates[var_11 getentitynumber()] = var_11;
  var_11.friendlymodel setscriptablepartstate("visibility", "hide", 0);

  if(isDefined(var_11.enemymodel)) {
    var_11.enemymodel setscriptablepartstate("visibility", "hide", 0);
  }

  var_11.animname = var_9;
  var_11 scripts\common\anim::setanimtree();
  var_12 = level.scr_anim[var_9][var_10];
  var_13 = getanimlength(var_12) * 1000;
  var_11.animdroptime = gettime() + getnotetracktimes(var_12, "carepackage_drop")[0] * var_13;
  var_11.animstoptrailtime = gettime() + getnotetracktimes(var_12, "carepackage_trail_end")[0] * var_13;
  var_11.animendtime = gettime() + var_13;
  var_8.latestanimendtime = scripts\engine\utility::ter_op(var_11.animendtime > var_8.latestanimendtime, var_11.animendtime, var_8.latestanimendtime);
  return var_11;
}

function createchuteforscripteddrop(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0.chutes)) {
    var_0.chutes = [];
  }

  var_4 = spawn("script_model", var_0.origin);
  var_4.angles = var_0.origin;
  var_4.scenenode = var_0;
  var_4.crate = var_1;
  var_4.crateanimdroptime = var_1.animdroptime;
  var_0.chutes[var_4 getentitynumber()] = var_4;
  var_4 setModel("veh8_mil_lnd_carepackage_parachute");
  var_4 setscriptablepartstate("visibility", "hide", 0);
  var_4.animname = var_2;
  var_4 scripts\common\anim::setanimtree();
  var_5 = level.scr_anim[var_2][var_3];
  var_6 = getanimlength(var_5) * 1000;
  var_4.animendtime = gettime() + getanimlength(level.scr_anim[var_2][var_3]) * 1000;
  var_4.animunhidetime = gettime() + getnotetracktimes(var_5, "chute_unhide")[0] * var_6;
  var_4.animendtime = gettime() + var_6;
  var_0.latestanimendtime = scripts\engine\utility::ter_op(var_4.animendtime > var_0.latestanimendtime, var_4.animendtime, var_0.latestanimendtime);
  return var_4;
}

function destroychute() {
  if(isDefined(self.scenenode)) {
    self.scenenode.chutes[self getentitynumber()] = undefined;
  }

  self delete();
}

function dropcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      return undefined;
    }
  }

  var_8 = getcratedropcaststart(var_3, 1);
  var_9 = var_4 * (0, 1, 0);

  if(!isDefined(var_5)) {
    var_5 = getcratedropdestination(var_8, getcratedropcastend(var_8, 1));

    if(!isDefined(var_5)) {
      return undefined;
    }
  }

  var_10 = spawn("script_model", var_8);
  var_10.angles = var_9;
  var_10 setModel("tag_origin");
  var_10.owner = var_0;
  var_10.team = var_1;
  var_10.hasowner = isDefined(var_0);
  var_11 = undefined;

  if(isDefined(var_6)) {
    var_11 = var_6.vehicleisreserved;
  }

  var_12 = createheli(var_0, var_1, var_8, var_9, var_11, var_7);

  if(!isDefined(var_12)) {
    var_10 delete();
    return undefined;
  }

  var_12.scenenode = var_12;
  var_12 setscriptablepartstate("visibility", "hide", 0);
  var_12.animname = "care_package_heli";
  var_10.heli = var_12;
  var_10.heliendtime = gettime() + getanimlength(level.scr_anim["care_package_heli"]["care_package_drop"]) * 1000;
  var_10.latestanimendtime = var_10.heliendtime;
  var_13 = createcrateforscripteddrop(var_0, var_1, var_2, var_5, undefined, 0, var_6, var_7, var_10, "care_package", "care_package_drop");

  if(!isDefined(var_13)) {
    return undefined;
  }

  var_14 = createchuteforscripteddrop(var_10, var_13, "care_package_chute", "care_package_drop");

  if(!isDefined(var_14)) {
    return undefined;
  }

  var_14 setscriptablepartstate("visibility", "hide", 0);
  thread watchdropcratefromscriptedheli();
  return var_10;
}

function watchdropcratefromscriptedheli() {
  self endon("death");
  scripts\common\anim::anim_first_frame_solo(self.heli, "care_package_drop");

  foreach(var_1 in self.crates) {
    scripts\common\anim::anim_first_frame_solo(var_1, "care_package_drop");
  }

  foreach(var_4 in self.chutes) {
    scripts\common\anim::anim_first_frame_solo(var_4, "care_package_drop");
  }

  watchdropcratefromscriptedheliinternal();

  if(isDefined(self.heli)) {
    thread destroyheli();
  }

  foreach(var_1 in self.crates) {
    if(isDefined(var_1)) {
      thread destroycrate();
    }
  }

  foreach(var_4 in self.chutes) {
    if(isDefined(var_4)) {
      thread destroychute();
    }
  }

  self delete();
}

function watchdropcratefromscriptedheliinternal() {
  var_0 = undefined;

  while(gettime() <= self.latestanimendtime) {
    if(self.hasowner) {
      if(!isDefined(self.ownerdisconnected)) {
        if(isDefined(self.owner)) {
          if(!isDefined(self.ownerjoinedteam)) {
            if(self.team != self.owner.team) {
              self.ownerjoinedteam = 1;
            }
          }
        } else {
          self.ownerdisconnected = 1;
        }
      }
    }

    if(!isDefined(var_0)) {
      var_0 = 1;
    } else {
      jumpiffalse(var_0) LOC_0000015a;
      jumpiffalse(isDefined(self.heli)) LOC_000000ad;
      self.heli setscriptablepartstate("visibility", "show", 0);
      self.heli setscriptablepartstate("lights", "active", 1);
      thread scripts\common\anim::anim_single_solo(self.heli, "care_package_drop");

      foreach(var_2 in self.crates) {
        if(isDefined(var_2)) {
          var_2.friendlymodel setscriptablepartstate("visibility", "show", 0);

          if(isDefined(var_2.enemymodel)) {
            var_2.enemymodel setscriptablepartstate("visibility", "show", 0);
          }

          thread scripts\common\anim::anim_single_solo(var_2, "care_package_drop");
        }
      }

      foreach(var_5 in self.chutes) {
        if(isDefined(var_5)) {
          thread scripts\common\anim::anim_single_solo(var_5, "care_package_drop");
        }
      }

      var_0 = 0;
      goto LOC_00000353;
    }

    waitframe();
  }
}

function docratedropfromscripted(var_0) {
  var_0.scenenode = undefined;
  self.crates[var_0 getentitynumber()] = undefined;
  var_0.animname = undefined;
  var_0.animendtime = undefined;
  var_0.animdroptime = undefined;
  var_0.animstoptrailtime = undefined;
  var_0 notify("anim_finished");
  var_0 stopanimScripted();
  infinite_chopper(var_0);
}

function getcratedropcaststart(var_0, var_1) {
  var_2 = undefined;

  if(istrue(var_1)) {
    var_2 = var_0 * (1, 1, 0) + (0, 0, getscriptedhelidropheight());
  } else {
    var_2 = var_0 + (0, 0, 25);
  }

  return var_2;
}

function getcratedropcastend(var_0, var_1) {
  return var_0 + (0, 0, -1 * scripts\engine\utility::ter_op(istrue(var_1), 8000, 8000));
}

function getcratedropdestination(var_0, var_1) {
  var_2 = undefined;
  var_3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
  var_4 = getcratedropignorelist();
  var_5 = physics_raycast(var_0, var_1, var_3, var_4, 0, "physicsquery_closest", 1);

  if(isDefined(var_5) && var_5.size > 0) {
    var_2 = var_5[0]["position"];
  }

  return var_2;
}

function getcratedropignorelist() {
  if(isDefined(level.cratedata.helis) && isDefined(level.cratedata.ac130s)) {
    return scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedropdata.ac130s, level.cratedata.crates]);
  }

  return scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedata.crates]);
}

function createheli(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  var_7 = "veh8_mil_air_lbravo_mp";

  if(isDefined(var_0) && scripts\cp_mp\utility\player_utility::getplayersuperfaction(var_0)) {
    var_7 = "veh8_mil_air_lbravo_east_mp";
  }

  if(istrue(var_4)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }

  if(isDefined(var_0)) {
    var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var_0, var_2, var_3, "veh_airdrop_mp", var_7);
  } else {
    var_6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var_2, var_3, "veh_airdrop_mp", var_7);
  }

  if(!isDefined(var_6)) {
    return undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = "neutral";
  }

  if(var_1 != "neutral") {
    var_6 setvehicleteam(var_1);
  }

  var_6.owner = var_0;
  var_6.team = var_1;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;

  if(isDefined(level.heliconfigs)) {
    var_11 = level.heliconfigs["airdrop"];
    var_6.health = var_11.maxhealth;
    var_8 = var_11.callout;
    var_9 = var_11.vodestroyed;
    var_10 = var_11.scorepopup;
  } else {
    var_6.health = 999999;
  }

  var_6.helitype = "airdrop";

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]]("airdrop", "Killstreak_Air", var_0, 0, 0);
    }

    if(var_1 != "neutral") {
      var_6 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var_0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]]("veh_airdrop_mp", var_10, var_9, undefined, var_8);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]]("veh_airdrop_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]]("veh_airdrop_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]]("veh_airdrop_mp", &destroyhelicallback);
  }

  var_6 setCanDamage(0);
  thread watchhelidestroyearly();
  return var_6;
}

function watchhelidestroyearly() {
  self endon("death");
  watchhelidestroyearlyinternal();
  thread destroyheli();
}

function watchhelidestroyearlyinternal() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");
  level waittill("forever");
}

function destroyheli() {
  thread deleteheli(0);
}

function deleteheli(var_0) {
  self notify("death");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.heli = undefined;
    self.scenenode = undefined;
  }

  removehelidroppingcratefromlist(self getentitynumber());
  wait var_0;
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function destroyhelicallback(var_0) {
  destroyheli();
}

function getscriptedhelidropheightbase() {
  return level.cratedropdata.heliheight;
}

function getscriptedhelidropheight() {
  return getscriptedhelidropheightbase() + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

function addhelidroppingcratetolist(var_0) {
  var_1 = var_0 getentitynumber();
  level.cratedropdata.helis[var_1] = var_0;
}

function removehelidroppingcratefromlist(var_0) {
  level.cratedropdata.helis[var_0] = undefined;
}

function makecrateusable() {
  var_0 = getleveldata(self.cratetype);

  if(istrue(var_0.hasnointeraction)) {
    return;
  }

  level.cratedata.usablecrates[self getentitynumber()] = self;
  self.isusable = 1;

  if(var_0.supportsownercapture && var_0.supportsothercapture) {
    thread watchcrateuse(1);
    var_1 = self.useobject;

    if(!isDefined(var_1)) {
      var_1 = spawn("script_model", self gettagorigin(var_0.usetag));
      var_1 setModel("tag_origin");
      var_1 linkTo(self);
      var_1 makeunusable();
      self.useobject = var_1;
    }

    thread watchcrateuse(2, var_1);
    return;
  }

  if(var_0.supportsownercapture) {
    thread watchcrateuse(1);
    return;
  }

  thread watchcrateuse(2);
}

function watchcrateuse(var_0, var_1) {
  self endon("death");
  self endon("makeCrateUnusable");

  if(isDefined(var_1)) {
    var_1 endon("death");
  }

  if(var_0 == 1) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
    self.owner.unset_relic_ammo_drain = 1;
  }

  var_2 = getleveldata(self.cratetype);
  var_3 = gettriggerobject(var_1);
  var_3.usetype = var_0;
  var_3 setCursorHint("HINT_NOICON");
  var_3 sethintonobstruction("show");
  var_3 sethinttag(var_2.usetag);
  var_3 sethintdisplayrange(var_2.userange);
  var_3 sethintdisplayfov(var_2.usefov);
  var_3 setuserange(var_2.userange);
  var_3 setusefov(var_2.usefov);
  var_3 setusepriority(var_2.usepriority);
  var_3 setuseholdduration("duration_none");

  if(var_3.usetype == 1 && self.supportsreroll) {
    var_3 setHintString(self.rerollstring);
  } else {
    var_3 setHintString(self.capturestring);
  }

  var_3.userate = 1;
  var_3.curprogress = 0;

  if(isDefined(var_3.ref_140A0)) {
    var_3.usetime = var_3.ref_140A0;
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var_3.usetime = scripts\engine\utility::ter_op(var_0 == 1, var_2.ownerusetime, var_2.otherusetime);
  }

  var_3.inuse = 0;
  var_3.playerusing = undefined;

  for(;;) {
    var_3 waittill("trigger", var_4);

    if(level.gametype == "br") {
      if(self.cratetype == "battle_royale_juggernaut") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "teamJuggMaxReached")) {
          var_5 = var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "teamJuggMaxReached")]]();

          if(var_5) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_TEAM_MAX_REACHED");
            }

            continue;
          }
        }
      }

      if(istrue(var_4.isjuggernaut) && !vehicle_isfriendlytoplayer(var_4, self.cratetype)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
        }

        continue;
      }
    }

    if(canstartusingcrate(var_4, var_1)) {
      startusingcrate(var_4, var_1);
      var_4.unset_relic_ammo_drain = 1;
      var_3.playerusing = var_4;
      var_6 = watchcrateuseinternal(var_4, var_1);

      if(isDefined(var_4)) {
        stopusingcrate(var_4, var_1);
      }

      var_3.playerusing = undefined;

      if(istrue(var_6)) {
        if(isDefined(var_4)) {
          var_4.unset_relic_ammo_drain = 0;
        }

        if(var_2.onecaptureperplayer && self.cratetype != "battle_royale_loadout") {
          if(!isDefined(self.playerscaptured)) {
            self.playerscaptured = [];
          }

          self.playerscaptured[var_4 getentitynumber()] = var_4;
        }

        if(!isDefined(self.targetname) || self.targetname != "btm_flag_primary_inside") {
          thread capturecrate(var_4);
        }
      }
    }
  }
}

function watchcrateuseinternal(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(var_2.usetype != 1) {
    var_0 endon("disconnect");
    var_0 endon("joined_team");
    var_0 endon("joined_spectators");
  }

  var_2.id = "care_package";
  var_2.userate = scripts\engine\utility::ter_op(isDefined(var_0.objectivescaler), var_0.objectivescaler, 1);
  playusesound(var_0, var_1);

  while(isDefined(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive() && cankeepusingcrate(var_0, var_1) && var_0 useButtonPressed()) {
    var_2.curprogress += level.framedurationseconds * var_2.userate;

    if(var_2.curprogress >= var_2.usetime) {
      var_2.curprogress = 0;
      return true;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var_2, 1);
    }

    waitframe();
  }

  var_2.curprogress = 0;
  return false;
}

function makecrateunusable() {
  self notify("makeCrateUnusable");
  level.cratedata.usablecrates[self getentitynumber()] = undefined;
  self.isusable = 0;

  if(isDefined(self.playerusing)) {
    stopusingcrate(self.playerusing);
  }

  self.playerusing = undefined;
  self makeunusable();

  if(isDefined(self.useobject)) {
    if(isDefined(self.useobject.playerusing)) {
      stopusingcrate(self.useobject.playerusing, self.useobject);
    }

    self.useobject makeunusable();
    return;
  }
}

function startusingcrate(var_0, var_1) {
  var_2 = gettriggerobject(var_1);
  var_3 = getleveldata(self.cratetype);

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 0);
    }
  } else {
    var_4 = getdvarint("scr_airDrop_use_weapon", 1);

    if(var_4) {
      thread br_bunker_alt();
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var_2, 0);
    return;
  }
}

function br_bunker_alt() {
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\utility\weapon_utility::ref_12EB2();
  var_0 = getcompleteweaponname("ks_use_crate_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  thread br_checkforlaststandfinish(var_0);
  self switchtoweapon(var_0);
}

function br_checkforlaststandfinish(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("crate_use_end");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_0)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_0);
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);

  if(isDefined(self.lastdroppableweaponobj)) {
    var_1 = scripts\cp_mp\utility\weapon_utility::ref_12CC7(self.lastdroppableweaponobj);
    self switchtoweapon(var_1);
    thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_1);
    return;
  }
}

function stopusingcrate(var_0, var_1) {
  var_2 = gettriggerobject(var_1);
  var_3 = getleveldata(self.cratetype);

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 1);
    }
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var_2, 0);
  }

  stopusesound(var_0, var_1);
  var_0 notify("crate_use_end");
}

function canstartusingcrate(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "specialCase_canUseCrate")) {
    if(!var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "specialCase_canUseCrate")]]()) {
      return 0;
    }
  }

  if(!var_0 scripts\common\utility::is_crate_use_allowed()) {
    return 0;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(var_0 isonladder()) {
    return 0;
  }

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var_0 getentitynumber()])) {
    return 0;
  }

  if(istrue(self.issquadonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0)) {
      return 0;
    }

    if(var_0.squadindex != self.squadindex || var_0.team != self.team) {
      return 0;
    }
  }

  if(istrue(self.validate_station)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var_0)) {
      return 0;
    }

    if(var_0.team != self.team) {
      return 0;
    }
  }

  if(isbot(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "botIsKillstreakSupported")) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() != "grnd" && ![[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "botIsKillstreakSupported")]](self.cratetype)) {
          return 0;
        }
      }
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "isKillstreakBlockedForBots")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "isKillstreakBlockedForBots")]](self.cratetype)) {
        return 0;
      }
    }
  }

  if(!self.isusable) {
    return 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    return canstartusingcratetriggerobject(var_0, var_1);
  }

  if(level.gametype == "br" && var_0 isskydiving()) {
    return 0;
  }

  if(istrue(var_0.inlaststand)) {
    return 0;
  }

  return 1;
}

function canstartusingcratetriggerobject(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(isDefined(var_2.playerusing) && var_2.playerusing != var_0) {
    return false;
  }

  if(var_2.usetype == 1 && (!isDefined(self.owner) || var_0 != self.owner)) {
    return false;
  }

  if(var_2.usetype == 2 && isDefined(self.owner) && var_0 == self.owner) {
    return false;
  }

  if(level.teambased && isDefined(self.team) && self.team != "neutral") {
    var_3 = getleveldata(self.cratetype);

    if(var_3.friendlyuseonly && var_0.team != self.team) {
      return false;
    }
  }

  return true;
}

function cankeepusingcrate(var_0, var_1) {
  if(!scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var_0 meleeButtonPressed()) {
    return false;
  }

  if(var_0 isinexecutionvictim()) {
    return false;
  }

  if(istrue(var_0.inlaststand)) {
    return false;
  }

  var_2 = getleveldata(self.cratetype);

  if(isDefined(var_2.breakuserangesqr) && distancesquared(var_0.origin, gettriggerobject(var_1).origin) >= var_2.breakuserangesqr) {
    return false;
  }

  if(!self.isusable) {
    return false;
  }

  return true;
}

function ref_11A9C(var_0, var_1) {
  var_0 enableplayeruse(var_1);

  if(isDefined(var_0.useobject)) {
    var_0.useobject enableplayeruse(var_1);
  }

  if(!canstartusingcrate(var_0, var_1, var_0.useobject, 0)) {
    var_0 disableplayeruse(var_1);

    if(isDefined(var_0.useobject)) {
      var_0.useobject disableplayeruse(var_1);
      return;
    }

    return;
  }

  if(!canstartusingcratetriggerobject(var_0, var_1, undefined)) {
    var_0 disableplayeruse(var_1);
  }

  if(isDefined(var_0.useobject)) {
    if(!canstartusingcratetriggerobject(var_0, var_1, var_0.useobject)) {
      var_0.useobject disableplayeruse(var_1);
      return;
    }

    return;
  }
}

function ref_14485() {
  for(;;) {
    foreach(var_1 in level.cratedata.usablecrates) {
      if(!isDefined(var_1)) {
        thread scripts\engine\utility::error("airdrop crate was deleted incorrectly.");
        continue;
      }

      var_1 makeusable();
      var_1 istacmapactive();

      if(isDefined(var_1.useobject)) {
        var_1.useobject makeusable();
        var_1.useobject istacmapactive();
      }

      var_2 = level.players;

      if(level.teambased && isDefined(var_1.team) && var_1.team != "neutral") {
        var_3 = getleveldata(var_1.cratetype);

        if(var_3.friendlyuseonly) {
          var_2 = level.teamdata[var_1.team]["alivePlayers"];
        }
      }

      foreach(var_5 in var_2) {
        var_6 = distancesquared(var_1.origin, var_5.origin) < 57600;

        if(var_6) {
          ref_11A9C(var_1, var_5);
        }
      }
    }

    wait 0.1;
  }
}

function watchallcrateusability() {
  jumpiffalse(getdvarint("scr_airdrop_fast_usable_crates", 0)) LOC_00000014;
  thread ref_14485();
  return;
}

function playusesound(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(var_2.usetype == 1) {
    var_0 playLoopSound("mp_care_package_owner_cap");
    return;
  }

  var_0 playLoopSound("mp_care_package_non_owner_cap");
}

function stopusesound(var_0, var_1) {
  var_2 = gettriggerobject(var_1);

  if(var_2.usetype == 1) {
    var_0 stoploopsound("mp_care_package_owner_cap");
  } else {
    var_0 stoploopsound("mp_care_package_non_owner_cap");
  }

  if(var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var_0 playsoundonmovingent("mp_care_package_cap_tail");
    return;
  }
}

function gettriggerobject(var_0) {
  return scripts\engine\utility::ter_op(isDefined(var_0), var_0, self);
}

function infinite_chopper(var_0, var_1) {
  var_2 = getleveldata(self.cratetype);

  if(isDefined(var_2.ingame)) {
    self thread[[var_2.ingame]]();
  }

  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  self unlink();
  self physicslaunchserver(var_0, var_1);
  var_3 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var_3, (0, 0, -1));
  self.physicsactivated = 1;
  createdangerzone();
  thread ref_11CFE();
  thread ref_11D0B();
  thread ref_11D17();
}

function infilweaponraise() {
  if(!istrue(self.physicsactivated)) {
    return;
  }

  self.physicsactivated = undefined;
  self.ref_12332 = undefined;
  self physicsstopserver();
  headicon_z_offset();
  ref_11D0C();
  ref_11D18();
  generatecodestoshow();
}

function ref_11CFE() {
  self endon("death");
  self notify("monitorAverageVelocityAndUpdate");
  self endon("monitorAverageVelocityAndUpdate");
  var_0 = 0.1;
  thread ref_11CFD(var_0, 8);
  var_1 = 0;
  var_2 = 0;
  self.unset_relic_amped = 1;
  var_3 = undefined;
  var_4 = undefined;
  jumpiffalse(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated")) LOC_0000005c;
  var_4 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated");

  for(;;) {
    var_5 = registeronplayerjointeamnospectatorcallback();
    var_6 = registeronplayerdisconnect();

    if(isDefined(var_5) && isDefined(var_6)) {
      if(var_5 <= 5 && var_6 <= 1) {
        var_1++;
        var_2 = 0;

        if(var_1 == 6) {
          self.ref_12332 = 1;
          var_3 = self.origin;
          thread activatecrate(self.unset_relic_amped);

          if(isDefined(var_4) && [[var_4]]()) {
            ref_11D0C();

            if(isDefined(self.killcament)) {
              self.killcament delete();
            }
          }

          var_0 = 0.1;
          thread ref_11CFD(var_0, 3, 3);
          lb_mg_dmg_factor_tail_rotor();
        }
      } else {
        if(isDefined(var_3)) {
          if(distancesquared(self.origin, var_3) <= 2500) {
            wait var_0;
            continue;
          }
        }

        var_2++;
        var_1 = 0;

        if(var_2 == 1) {
          self.ref_12332 = undefined;
          thread deactivatecrate();
          var_0 = 0.1;
          thread ref_11CFD(var_0, 8);
        }
      }

      wait var_0;
      continue;
    }

    waitframe();
  }
}

function ref_11CFD(var_0, var_1, var_2) {
  headicon_z_offset();
  self endon("death");
  self endon("clear_average_velocities");
  self.x1ops2 = [];
  self.buildrespawnlist = [];
  self.ref_1428A = 0;
  self.ref_14285 = 0;
  self.ref_14287 = var_1;
  jumpiffalse(isDefined(var_2)) LOC_0000007a;
  var_2 = int(clamp(var_2, 0, var_1));
  jumpiffalse(var_2 > 0) LOC_0000007a;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    self.x1ops2[self.ref_1428A + var_3] = 0;
    self.buildrespawnlist[self.ref_1428A + var_3] = 0;
  }

  for(;;) {
    var_4 = self physics_getbodyid(0);
    var_5 = physics_getbodylinvel(var_4);
    var_6 = physics_getbodyangvel(var_4);
    self.x1ops2[self.ref_14285] = length(var_5);
    self.buildrespawnlist[self.ref_14285] = length(var_6);
    self.ref_14285++;
    var_7 = self.ref_14285 - self.ref_1428A;

    if(var_7 > var_1) {
      var_8 = scripts\engine\utility::mod(var_7, var_1);

      for(var_3 = 0; var_3 < var_8; var_3++) {
        self.x1ops2[self.ref_1428A + var_3] = undefined;
        self.buildrespawnlist[self.ref_1428A + var_3] = undefined;
      }

      self.ref_1428A += var_8;
    }

    self.checkrequiredteamstreamcount = undefined;
    self.checkreload = undefined;
    wait var_0;
  }
}

function registeronplayerjointeamnospectatorcallback() {
  if(isDefined(self.checkrequiredteamstreamcount)) {
    return self.checkrequiredteamstreamcount;
  }

  if(!isDefined(self.x1ops2)) {
    return undefined;
  }

  if(self.ref_14285 - self.ref_1428A < self.ref_14287) {
    return undefined;
  }

  forcestuckdamageclear();
  return self.checkrequiredteamstreamcount;
}

function registeronplayerdisconnect() {
  if(isDefined(self.checkreload)) {
    return self.checkreload;
  }

  if(!isDefined(self.buildrespawnlist)) {
    return undefined;
  }

  if(self.ref_14285 - self.ref_1428A < self.ref_14287) {
    return undefined;
  }

  forcestuckdamageclear();
  return self.checkreload;
}

function forcestuckdamageclear() {
  var_0 = 0;
  var_1 = 0;

  for(var_2 = self.ref_1428A; var_2 < self.ref_14285; var_2++) {
    var_0 += self.x1ops2[var_2];
    var_1 += self.buildrespawnlist[var_2];
  }

  self.checkrequiredteamstreamcount = var_0 / self.ref_14287;
  self.checkreload = var_1 / self.ref_14287;
}

function headicon_z_offset() {
  self notify("clear_average_velocities");
  self.x1ops2 = undefined;
  self.buildrespawnlist = undefined;
  self.ref_14287 = undefined;
  self.ref_1428A = undefined;
  self.ref_14285 = undefined;
  self.checkrequiredteamstreamcount = undefined;
  self.checkreload = undefined;
}

function ref_11D0B(var_0) {
  ref_11D0C();
  self endon("monitorImpactEnd");
  self.ref_11D0E = 1;
  self playLoopSound("mp_care_package_drop_lp");
  self physics_registerforcollisioncallback();
  ref_11D0D(var_0);

  if(isDefined(self)) {
    thread ref_11D0C();
    return;
  }
}

function ref_11D0D(var_0) {
  self endon("death");

  if(isDefined(var_0)) {
    wait var_0;
  }

  var_1 = 0;

  for(;;) {
    self waittill("collision", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

    if(isDefined(var_9)) {
      if(isDefined(var_9.classname) && var_9.classname == "scriptable_iw8_chicken_01") {
        thread br_badcircleareas(var_9);
      }

      getkioskyawoffsetoverride(var_9);
    }

    if(isDefined(var_9) && start_chants_on_movement(var_9)) {
      if(var_9 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks()) {
        var_9 thread scripts\cp_mp\killstreaks\helper_drone::helperdronedestroyed();
      }
    }

    if(gettime() - var_1 >= 200) {
      var_1 = gettime();
      var_10 = physics_getsurfacetypefromflags(var_5);
      var_11 = getsubstr(var_10["name"], 9);

      if(var_11 == "user_terrain1") {
        var_11 = "user_terrain_1";
      }

      if(var_11 == "user_terrain5") {
        var_11 = "user_terrain_5";
      }

      ref_1273B(var_6, var_7, var_8, var_11);
    }
  }
}

function getkioskyawoffsetoverride(var_0) {
  if(isDefined(var_0.script_noteworthy) && isstartstr(var_0.script_noteworthy, "train_") && !isDefined(self getlinkedparent())) {
    if(isDefined(self.ref_13CC8)) {
      if(self.ref_13CC8 == var_0) {
        return;
      } else {
        generatecodestoshow();
      }
    }

    self.ref_13CC8 = var_0;
    self.ref_13CC7 = 4;
    thread getknivesoutsetting(var_0);
    return;
  }
}

function getknivesoutsetting(var_0) {
  self endon("death");
  self endon("cancel_link_to_train");
  var_0 endon("death");
  var_1 = getleveldata(self.cratetype);
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
  var_3 = [self];

  foreach(var_5 in self getlinkedchildren(1)) {
    var_3 = var_5;
  }

  self.ref_13CCE = 0;
  self.ref_13CD0 = 0;

  while(self.ref_13CCE < 5) {
    var_7 = self.origin + anglestoup(self.angles) * var_1.setplayerbeingrevivedextrainfo;
    var_8 = var_7 + (0, 0, -200);
    var_9 = scripts\engine\trace::ray_trace(var_7, var_8, var_3, var_2);

    if(var_9.size > 0 && isDefined(var_9["entity"]) && var_9["entity"] == self.ref_13CC8) {
      var_10 = combineangles(invertangles(var_0.angles), var_0.origin - var_9["position"]);

      if(!isDefined(self.ref_13CCF)) {} else if(distancesquared(var_10, self.ref_13CCF) > 25) {
        self.ref_13CCE++;
        self.ref_13CD0 = 0;
      } else if(vectordot(var_10, self.ref_13CCF) < 0.997) {
        self.ref_13CCE++;
        self.ref_13CD0 = 0;
      } else {
        self.ref_13CD0++;

        if(self.ref_13CD0 >= 4) {
          self linkTo(var_0);
          activatecrate(self.unset_relic_amped);
          thread infilweaponraise();
          break;
        }
      }

      self.ref_13CCF = var_10;
    } else {
      break;
    }

    wait 0.05;
  }

  thread generatecodestoshow();
}

function generatecodestoshow() {
  self notify("cancel_link_to_train");
  self.ref_13CC8 = undefined;
  self.ref_13CCF = undefined;
  self.ref_13CCE = undefined;
  self.ref_13CD0 = undefined;
}

function br_badcircleareas(var_0) {
  self endon("death");
  var_1 = gettime();

  while(gettime() - var_1 < 3000) {
    var_0 dodamage(100, var_0.origin, self, self, "MOD_CRUSH");
    wait 0.5;
  }
}

function ref_11D0C() {
  if(!istrue(self.ref_11D0E)) {
    return;
  }

  self notify("monitorImpactEnd");
  self.ref_11D0E = undefined;
  self stoploopsound("mp_care_package_drop_lp");
  self physics_unregisterforcollisioncallback();
}

function start_chants_on_movement(var_0) {
  if(!istrue(self.ref_12332)) {
    if(isDefined(var_0.classname)) {
      if(var_0.classname == "worldSpawn") {
        return false;
      } else if(var_0.classname == "script_vehicle") {
        if(var_0 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks()) {
          var_1 = getleveldata(self.cratetype);
          var_2 = self.origin + anglestoup(self.angles) * var_1.setplayerbeingrevivedextrainfo;
          return (var_0.origin[2] <= var_2[2]);
        }
      }
    }
  }

  return false;
}

function ref_11D17() {
  ref_11D18();
  self endon("death");
  self endon("monitorPlayerImpactEnd");
  var_0 = self;

  if(isDefined(self.mountmantlemodel)) {
    var_0 = self.mountmantlemodel;
  }

  var_1 = undefined;
  jumpiffalse(isDefined(self.owner)) LOC_00000038;
  var_1 = self.owner;

  while(isDefined(var_0)) {
    var_0 waittill("player_pushed", var_2, var_3);

    if(isDefined(var_2) && (isPlayer(var_2) || isagent(var_2)) && var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_4 = var_3[2] <= -8;
      var_5 = 0;
      var_6 = undefined;

      if(var_2 tagexists("j_mainroot")) {
        var_6 = var_2 gettagorigin("j_mainroot");
        var_7 = getleveldata(self.cratetype);
        var_8 = self.origin + anglestoup(self.angles) * var_7.setplayerbeingrevivedextrainfo;
        var_5 = var_6[2] <= var_8[2];
      }

      if(var_4 && var_5) {
        var_9 = var_1;

        if(!isDefined(var_9)) {
          var_9 = var_2;
        }
      }
    }
  }
}

function ref_11D18() {
  self notify("monitorPlayerImpactEnd");
}

function ref_1273B(var_0, var_1, var_2, var_3) {
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var_0, var_1);

  if(var_2 < 150) {
    self playsurfacesound("mp_care_package_low_impact", var_3);
  } else if(var_2 < 300) {
    self playsurfacesound("mp_care_package_med_impact", var_3);
  } else {
    self playsurfacesound("mp_care_package_high_impact", var_3);
  }

  self stoploopsound("mp_care_package_drop_lp");
}

function createdangerzone() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    return;
  }

  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    return;
  }

  destroydangerzone();
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.owner) && isDefined(self.team)) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](self.destination, var_0.dangerzoneradius, var_0.dangerzoneheight, self.team, 30, self.owner, 1);
  } else if(isDefined(self.team)) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](self.destination, var_0.dangerzoneradius, var_0.dangerzoneheight, self.team, 30);
  } else {
    var_1 = spawnuniversaldangerzone(self.destination, var_0.dangerzoneradius, var_0.dangerzoneheight, 30);
  }

  self.dangerzoneid = var_1;
  return var_1;
}

function spawnuniversaldangerzone(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_0, var_1, var_2, undefined, var_3, level.players[randomint(level.players.size)], 1);
    self.dangerzoneid = var_4;
    return var_4;
  }
}

function destroydangerzone() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "isSpawnDangerZoneAlive") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "removeSpawnDangerZone")) {
    var_0 = self.dangerzoneid;

    if(isDefined(var_0) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "isSpawnDangerZoneAlive")]](var_0)) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "removeSpawnDangerZone")]](var_0);
    }

    self.dangerzoneid = undefined;
    return;
  }
}

function _createnavobstacle() {
  self notify("createNavObstacle");
  self endon("createNavObstacle");

  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
  }

  var_0 = getleveldata(self.cratetype);
  var_1 = createnavobstaclebybounds(self.origin, var_0.navobstaclebounds, self.angles);
  self.navobstacleid = var_1;
  GscBinSkip4(0x35, var_1, self.origin, var_0.navobstacleupdatedistsqr);
}

function _watchnavobstacle(var_0, var_1, var_2) {
  self endon("death");

  while(distancesquared(var_1, self.origin) < var_2) {
    wait 0.5;
  }

  thread _createnavobstacle();
}

function _destroynavobstacle() {
  self notify("createNavObstacle");

  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
  }

  self.navobstacleid = undefined;
}

function createmountmantlemodel() {
  var_0 = getleveldata(self.cratetype);

  if(isDefined(var_0.mountmantlemodel)) {
    if(isDefined(self.mountmantlemodel)) {
      self.mountmantlemodel delete();
    }

    var_1 = spawn("script_model", self.origin);
    var_1 dontinterpolate();
    var_1.angles = self.angles;
    var_1.owner = self.owner;
    var_1.unresolved_collision_func = &crateunresolvedcollisioncallback;
    var_1.killcament = self.killcament;
    var_1.mountmantlemodel = 1;
    var_1 clonebrushmodeltoscriptmodel(level.cratedata.mountmantlemodel);
    var_1 linkTo(self);
    self.mountmantlemodel = var_1;
    var_1.crate = self;
    return true;
  }

  return false;
}

function destroymountmantlemodel() {
  if(isDefined(self.mountmantlemodel)) {
    self.mountmantlemodel delete();
  }

  self.mountmantlemodel = undefined;
}

function crateunresolvedcollisioncallback(var_0, var_1) {
  if(level.cratedata.ref_13F28 > 0) {
    if(lengthsquared(var_1) <= level.cratedata.ref_13F28) {
      return;
    }
  }

  var_2 = self.objweapon;

  if(isDefined(self.init_airdrop_anims)) {
    var_2 = self.crate.objweapon;
  }

  var_0 dodamage(1000, var_0.origin, self.owner, self, "MOD_CRUSH", var_2);
  self endon("death");
  var_0 endon("death_or_disconnect");

  if(isPlayer(var_0) && var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "unresolvedCollisionNearestNode")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "unresolvedCollisionNearestNode")]](var_0, undefined, self);
      return;
    }

    return;
  }
}

function _createheadicon() {
  if(istrue(self.disallowheadiconid)) {
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.headicon)) {
    if(level.teambased && isDefined(self.team)) {
      if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var_1 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.team, self.headicon, var_0.headiconoffset, 1, var_0.headicondrawrange, var_0.headiconnaturalrange, undefined, 1);
      }

      if(isDefined(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isMLGMatch")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isMLGMatch")]]()) {
            removeclientfromheadiconmask(var_1, "spectator");
          }
        }
      }
    } else if(isDefined(self.owner)) {
      if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var_1 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.owner, self.headicon, var_0.headiconoffset, 1, var_0.headicondrawrange, var_0.headiconnaturalrange, undefined, 1);
      }

      if(isDefined(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isMLGMatch")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isMLGMatch")]]()) {
            removeclientfromheadiconmask(var_1, "spectator");
          }
        }
      }
    } else if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.teamnamelist, self.headicon, var_0.headiconoffset, 1, var_0.headicondrawrange, var_0.headiconnaturalrange);
    }
  }

  self.headiconid = var_1;
  self.headiconactive = 1;
  return var_1;
}

function _destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.headiconactive = 0;
}

function createminimapicon() {
  destroyminimapicon();
  var_0 = getleveldata(self.cratetype);
  var_1 = undefined;

  if(isDefined(self.minimapicon) && !istrue(self.visibilitymanuallycontrolled)) {
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
      var_2 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");
    }

    if(isDefined(var_2)) {
      if(level.teambased && isDefined(self.team)) {
        var_1 = self[[var_2]](self.minimapicon, self.team, 1, 1, 0);
      } else if(isDefined(self.owner)) {
        var_1 = self[[var_2]](self.minimapicon, undefined, 1, 1, 0);
      } else {
        var_1 = self[[var_2]](self.minimapicon, undefined, 0, 1, 0);
      }
    }
  }

  self.minimapid = var_1;
  self.minimapiconactive = 1;
  return var_1;
}

function destroyminimapicon() {
  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }
  }

  self.minimapid = undefined;
  self.minimapiconactive = 0;
}

function watchvisibility() {
  self endon("death");

  foreach(var_1 in level.players) {
    updatevisibilityforplayer(var_1);
  }

  waitframe();
  GscBinSkip4(0x35);
}

function watchvisibilityinternal() {
  for(;;) {
    level waittill("joined_team", var_0);
    updatevisibilityforplayer(var_0);
  }
}

function updatevisibilityforplayer(var_0) {
  self.friendlymodel hidefromplayer(var_0);
  self.enemymodel hidefromplayer(var_0);

  if(var_0.team == "spectator") {
    self.friendlymodel showtoplayer(var_0);
    return;
  }

  if(level.teambased && isDefined(self.team)) {
    if(var_0.team == self.team) {
      self.friendlymodel showtoplayer(var_0);
      return;
    }

    self.enemymodel showtoplayer(var_0);
    return;
  }

  if(!level.teambased && isDefined(self.owner)) {
    if(var_0 == self.owner) {
      self.friendlymodel showtoplayer(var_0);
      return;
    }

    self.enemymodel showtoplayer(var_0);
    return;
  }
}

function looselinkTo(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  self notify("looseLinkTo");
  self endon("looseLinkToEnd");

  while(istrue(self.physicsactivated)) {
    self.origin = var_0.origin + var_1;
    waitframe();
  }

  self linkTo(var_0);
}

function addtolists() {
  level.cratedata.crates[self getentitynumber()] = self;
}

function removefromlists(var_0) {
  if(!isDefined(level.cratedata)) {
    return;
  }

  level.cratedata.crates[var_0] = undefined;
}

function getrandomkeyfromweightsarray(var_0, var_1) {
  if(isDefined(var_1)) {
    if(!isarray(var_1)) {
      var_1 = [var_1];
    }
  }

  var_2 = [];
  var_3 = [];
  var_4 = 0;

  foreach(var_11, var_6 in var_0) {
    if(var_6 > 0) {
      var_7 = 0;

      if(isDefined(var_1)) {
        if(var_1.size > 0) {
          foreach(var_9 in var_1) {
            if(var_9 == var_11) {
              var_1[var_10] = undefined;
              var_7 = 1;
              break;
            }
          }
        } else {
          var_1 = undefined;
        }
      }

      if(!var_7) {
        var_4 += var_6;
        var_2 = var_11;
        var_3 = var_4;
      }
    }
  }

  var_12 = randomint(var_4);
  var_11 = undefined;

  for(var_13 = 0; var_13 < var_2.size; var_13++) {
    var_4 = var_3[var_13];

    if(var_12 < var_4) {
      var_11 = var_2[var_13];
      break;
    }
  }

  return var_11;
}

function getdefaultcapturevisualscallback() {
  return &defaultcapturevisualscallback;
}

#using_animtree("scriptables");

function getdefaultcapturevisualsdeletiondelay() {
  return getanimlength(%mp_military_carepackage_straps_falling);
}

#using_animtree("");

function defaultcapturevisualscallback(var_0) {
  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.isdummyarmcrate)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = getanimlength(%mp_military_carepackage_straps_falling);

  if(isDefined(var_1)) {
    var_1 = max(0, var_1 - 0.05);
  }

  var_0 setscriptablepartstate("anims", "capture", 0);
  var_0 setscriptablepartstate("capture", "start", 0);
  var_0 notsolid();

  if(isDefined(var_1)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  }

  playFX(scripts\engine\utility::getfx("airdrop_crate_capture"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
}

function getdefaultdestroyvisualsdeletiondelay() {
  return false;
}

function getdefaultdestroyvisualscallback() {
  return &defaultdestroyvisualscallback;
}

function defaultdestroyvisualscallback(var_0) {}

function getdefaultmountmantlemodel() {
  return level.cratedata.mountmantlemodel;
}

function getnumdroppedcrates() {
  if(!isDefined(level.cratedata)) {
    return 0;
  }

  return level.cratedata.crates.size;
}

function ref_13C46() {
  if(!isDefined(self.numactivejuggdrops)) {
    if(self ismantling()) {
      var_0 = self getmovingplatformparent();

      if(isDefined(var_0) && isDefined(var_0.crate)) {
        self.num_shot_taken_to_next_damage_state = var_0;
        self.num_times_stealth_broken_tv_station_interior = var_0.crate;
      }

      self.numactivejuggdrops = gettime() + 1000;
      return;
    }

    return;
  }

  if(gettime() >= self.numactivejuggdrops) {
    self.num_shot_taken_to_next_damage_state = undefined;
    self.num_times_stealth_broken_tv_station_interior = undefined;
    self.numactivejuggdrops = undefined;
    return;
  }

  foreach(var_2 in level.cratedata.crates) {
    if(isDefined(var_2) && istrue(var_2.physicsactivated) && !istrue(var_2.ref_12332)) {
      if(isDefined(self.num_shot_taken_to_next_damage_state)) {
        if(isDefined(var_2.mountmantlemodel)) {
          if(self.num_shot_taken_to_next_damage_state != var_2.mountmantlemodel) {
            if(self istouching(var_2.mountmantlemodel)) {
              self.num_shot_taken_to_next_damage_state = undefined;
              self.num_times_stealth_broken_tv_station_interior = undefined;
              self.numactivejuggdrops = undefined;

              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "_suicide")) {
                self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "_suicide")]]();
                return;
              }

              self suicide();
              return;
            }
          }
        }

        if(self.num_times_stealth_broken_tv_station_interior != var_2) {
          if(self istouching(var_2)) {
            self.num_shot_taken_to_next_damage_state = undefined;
            self.num_times_stealth_broken_tv_station_interior = undefined;
            self.numactivejuggdrops = undefined;

            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "_suicide")) {
              self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "_suicide")]]();
              return;
            }

            self suicide();
            return;
          }
        }

        continue;
      }

      if(self istouching(var_2) || isDefined(var_2.mountmantlemodel) && self istouching(var_2.mountmantlemodel)) {
        self.num_shot_taken_to_next_damage_state = undefined;
        self.num_times_stealth_broken_tv_station_interior = undefined;
        self.numactivejuggdrops = undefined;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "_suicide")) {
          self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "_suicide")]]();
          return;
        }

        self suicide();
        return;
      }
    }
  }
}

function overridecapturestring(var_0) {
  if(isDefined(self.capturestring) && self.capturestring == var_0) {
    return;
  }

  self.capturestring = var_0;
  var_1 = [self];

  if(isDefined(self.useobject)) {
    GscBinSkip0(0x2e, var_1.size, self.useobject);
  }

  foreach(var_3 in var_1) {
    if(!self.supportsreroll || var_3.usetype == 2) {
      var_3 setHintString(self.capturestring);
    }
  }
}

function overridererollstring(var_0) {
  if(isDefined(self.rerollstring) && self.rerollstring == var_0) {
    return;
  }

  self.rerollstring = var_0;
  var_1 = [self];

  if(isDefined(self.useobject)) {
    GscBinSkip0(0x2e, var_1.size, self.useobject);
  }

  foreach(var_3 in var_1) {
    if(self.supportsreroll && var_3.usetype == 1) {
      var_3 setHintString(self.rerollstring);
    }
  }
}

function overrideheadicon(var_0) {
  if(!isDefined(self.headicon) && !isDefined(var_0)) {
    return;
  }

  if(isDefined(self.headicon) && isDefined(var_0) && self.headicon == var_0) {
    return;
  }

  if(!isDefined(var_0)) {
    self.headicon = undefined;
    _destroyheadicon();
    return;
  }

  self.headicon = var_0;

  if(self.headiconactive) {
    if(isDefined(self.headiconid)) {
      setheadiconfriendlyimage(self.headiconid, var_0);
      return;
    }

    _createheadicon();
    return;
  }
}

function overrideminimapicon(var_0) {
  if(!isDefined(self.minimapicon) && !isDefined(var_0)) {
    return;
  }

  if(isDefined(self.minimapicon) && isDefined(var_0) && self.minimapicon == var_0) {
    return;
  }

  if(!isDefined(var_0)) {
    self.minimapicon = undefined;
    destroyminimapicon();
    return;
  }

  self.minimapicon = var_0;

  if(self.minimapiconactive) {
    if(isDefined(self.minimapid)) {
      scripts\mp\objidpoolmanager::update_objective_icon(self.minimapid, var_0);
      return;
    }

    createminimapicon();
    return;
  }
}

function overridesupportsreroll(var_0) {
  if(self.supportsreroll == var_0) {
    return;
  }

  self.supportsreroll = var_0;

  if(self.supportsreroll) {
    var_1 = [self];

    if(isDefined(self.useobject)) {
      GscBinSkip0(0x2e, var_1.size, self.useobject);
    }

    foreach(var_3 in var_1) {
      if(var_3.usetype == 1) {
        var_3 setHintString(self.rerollstring);
      }
    }

    return;
  }
}

function initkillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  var_0 = &killstreakcrateactivatecallback;
  var_1 = &killstreakcratecapturecallback;
  var_2 = getleveldata("killstreak");
  var_2.activatecallback = var_0;
  var_2.capturecallback = var_1;
  var_2 = getleveldata("killstreak_no_owner");
  var_2.activatecallback = var_0;
  var_2.capturecallback = var_1;
  var_2.supportsownercapture = 0;
  var_2.enemymodel = undefined;
  addkillstreakcratedata("radar_drone_overwatch", undefined, undefined, 120);
  addkillstreakcratedata("manual_turret", undefined, undefined, 120);
  addkillstreakcratedata("scrambler_drone_guard", undefined, undefined, 120);
  addkillstreakcratedata("uav", undefined, undefined, 120);
  addkillstreakcratedata("toma_strike", undefined, undefined, 170);
  addkillstreakcratedata("precision_airstrike", undefined, undefined, 170);
  addkillstreakcratedata("cruise_predator", undefined, undefined, 170);
  addkillstreakcratedata("sentry_gun", undefined, undefined, 50);
  addkillstreakcratedata("pac_sentry", undefined, undefined, 50);
  addkillstreakcratedata("bradley", undefined, undefined, 50);
  addkillstreakcratedata("chopper_gunner", undefined, undefined, 10);
  addkillstreakcratedata("directional_uav", undefined, undefined, 10);
  addkillstreakcratedata("gunship", undefined, undefined, 10);
  addkillstreakcratedata("chopper_support", undefined, undefined, 10);
  addkillstreakcratedata("hover_jet", undefined, undefined, 10);
  addkillstreakcratedata("white_phosphorus", undefined, undefined, 10);
  addkillstreakcratedata("juggernaut", undefined, undefined, 5);
  var_3 = 50;
  thread initkillstreakcratedatalate(var_3);
}

function initdropzonekillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  var_0 = &killstreakcrateactivatecallback;
  var_1 = &killstreakcratecapturecallback;
  var_2 = getleveldata("killstreak");
  var_2.activatecallback = var_0;
  var_2.capturecallback = var_1;
  var_2 = getleveldata("killstreak_no_owner");
  var_2.activatecallback = var_0;
  var_2.capturecallback = var_1;
  var_2.supportsownercapture = 0;
  var_2.enemymodel = undefined;
  var_3 = 0;
  addkillstreakcratedata("radar_drone_overwatch", undefined, undefined, 100);
  addkillstreakcratedata("manual_turret", undefined, undefined, 100);
  addkillstreakcratedata("uav", undefined, undefined, 100);
  addkillstreakcratedata("toma_strike", undefined, undefined, 65);
  addkillstreakcratedata("precision_airstrike", undefined, undefined, 65);
  addkillstreakcratedata("sentry_gun", undefined, undefined, 65);
  addkillstreakcratedata("cruise_predator", undefined, undefined, 65);
  addkillstreakcratedata("pac_sentry", undefined, undefined, 35);
  addkillstreakcratedata("juggernaut", undefined, undefined, 35);
  addkillstreakcratedata("white_phosphorus", undefined, undefined, 35);
  addkillstreakcratedata("chopper_gunner", undefined, undefined, 35);
  addkillstreakcratedata("directional_uav", undefined, undefined, 15);
  addkillstreakcratedata("gunship", undefined, undefined, 15);
  addkillstreakcratedata("chopper_support", undefined, undefined, 15);
  addkillstreakcratedata("hover_jet", undefined, undefined, 15);

  if(level.gametype != "infect") {
    addkillstreakcratedata("scrambler_drone_guard", undefined, undefined, 100);
    addkillstreakcratedata("bradley", undefined, undefined, 35);
    var_3 = 25;
    thread initkillstreakcratedatalate(var_3);
    return;
  }
}

function initkillstreakcratedatalate(var_0) {
  waittillframeend();
  var_1 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\light_tank::light_tank_supported(), var_0, 0);
  addkillstreakcratedata("bradley", undefined, undefined, var_1);
}

function addkillstreakcratedata(var_0, var_1, var_2, var_3) {
  level.cratedata.kscapturestrings[var_0] = var_1;
  level.cratedata.ksrerollstrings[var_0] = var_2;
  level.cratedata.ksweights[var_0] = var_3;
}

function getkillstreakcratedatabystreakname(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.streakname = var_0;
  var_2.supportsreroll = var_1;
  return var_2;
}

function overridekillstreakcrateweight(var_0, var_1) {
  level.cratedata.ksweights[var_0] = var_1;
}

function killstreakcrateactivatecallback(var_0) {
  var_1 = self.data;
  var_2 = level.cratedata.kscapturestrings[var_1.streakname];

  if(isDefined(var_2)) {
    overridecapturestring(var_2);
  }

  var_3 = level.cratedata.ksrerollstrings[var_1.streakname];

  if(isDefined(var_3)) {
    overridererollstring(var_3);
  }

  var_4 = var_1.supportsreroll;

  if(isDefined(var_4)) {
    overridesupportsreroll(var_4);
    return;
  }
}

function killstreakcratecapturecallback(var_0) {
  var_1 = self.data.streakname;
  var_2 = 0;

  switch (var_1) {
    case "bradley":
      if(!scripts\cp_mp\vehicles\light_tank::light_tank_supported()) {
        var_1 = "pac_sentry";
      }

      break;
    case "juggernaut":
      if(!istrue(var_0.isjuggernaut)) {
        var_2 = 1;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "applyImmediateJuggernaut")) {
          var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "applyImmediateJuggernaut")]](var_2);
        } else {
          var_0 scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(var_2);
        }
      }

      break;
  }

  if(!istrue(var_2)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "awardKillstreak")) {
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "awardKillstreak")]](var_1, self.owner, self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "showKillstreakSplash")) {
      var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "showKillstreakSplash")]](var_1, undefined, 1);
    }
  }

  if(isDefined(self.owner) && var_0 == self.owner) {
    return;
  }

  if(isDefined(self.team)) {
    if(var_0.team != self.team) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("hijacker");
      }

      if(isDefined(self.owner)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showSplash")) {
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showSplash")]]("hijacked_airdrop", undefined, var_0);
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function getrandomkillstreak(var_0) {
  var_1 = getrandomkeyfromweightsarray(level.cratedata.ksweights, var_0);
  return var_1;
}

function placekillstreakcrate(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2) || var_2 == "random") {
    var_2 = getrandomkillstreak();
  }

  var_5 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_6 = getkillstreakcratedatabystreakname(var_2, 0);
  var_7 = placecrate(var_0, var_1, var_5, var_3, var_4, var_6);

  if(!isDefined(var_7)) {
    return undefined;
  }

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var_0);
    }
  }

  return var_7;
}

function dropkillstreakcrate(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2) || var_2 == "random") {
    var_2 = getrandomkillstreak();
  }

  var_6 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_7 = getkillstreakcratedatabystreakname(var_2, 0);
  var_8 = dropcrate(var_0, var_1, var_6, var_3, var_4, var_5, var_7);

  if(!isDefined(var_8)) {
    return undefined;
  }

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var_0);
    }
  }

  return var_8;
}

function dropkillstreakcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(var_2) || var_2 == "random") {
    var_2 = getrandomkillstreak();
  }

  var_8 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_9 = getkillstreakcratedatabystreakname(var_2, 0);
  var_9.vehicleisreserved = var_6;
  var_10 = dropcratefromscriptedheli(var_0, var_1, var_8, var_3, var_4, var_5, var_9, var_7);

  if(!isDefined(var_10)) {
    return undefined;
  } else if(!isDefined(var_10.crates) || !isDefined(scripts\engine\utility::array_get_first_item(var_10.crates))) {
    return undefined;
  }

  if(isDefined(var_0)) {
    thread br_c130spawndone(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var_0);
    }
  }

  return var_10;
}

function br_c130spawndone(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(level.gametype == "grnd" || level.gametype == "infect") {
    return;
  }

  var_2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_2 = 1.5;
  }

  var_3 = var_0.streakname;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var_3, 1, var_2);
}

function dropkillstreakcratefrommanualheli(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_2) || var_2 == "random") {
    var_2 = getrandomkillstreak();
  }

  var_7 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
  var_8 = getkillstreakcratedatabystreakname(var_2, 0);
  var_8.vehicleisreserved = var_6;
  var_9 = dropcratefrommanualheli(var_0, var_1, var_7, var_3, var_4, 30000, 30000, var_5, var_8);

  if(!isDefined(var_9)) {
    return undefined;
  } else if(!isDefined(var_9.crate)) {
    return undefined;
  }

  if(isDefined(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var_0);
    }
  }

  return var_9.crate;
}

function tryairdroptriggered(var_0) {
  var_1 = var_0.streakname;
  var_2 = var_1;
  var_3 = undefined;

  if(!isDefined(var_2)) {
    var_2 = "airdrop";
  }

  var_4 = 4;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_4 = 10;
  }

  var_5 = 1;

  if((level.littlebirds.size >= var_4 || level.fauxvehiclecount >= var_4) && var_2 != "airdrop_mega") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_AIRDROPS");
    }

    return false;
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + var_5 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
      }

      return false;
    }
  }

  var_6 = getdvarint("scr_airDrop_sticky", 0);

  if(var_2 == "airdrop" && var_6) {
    var_0.deployweaponobj = getcompleteweaponname("deploy_airdrop_mp_sticky");
  }

  return true;
}

function airdropmarkerswitchended(var_0, var_1) {
  if(istrue(var_1)) {
    thread airdrop_watchplayerweapon(var_0);
    return;
  }
}

function airdrop_watchplayerweapon(var_0) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var_1 = scripts\engine\utility::ref_143AD("cancel_deploy", "weapon_switch_started");

  if(!isDefined(var_1)) {
    return;
  }

  var_0 notify("killstreak_finished_with_deploy_weapon");
}

function airdropvisualmarkerfired(var_0) {
  var_0.airdroptype = var_0.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "getTargetMarker")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "getTargetMarker")]](var_0);
  }

  if(!isDefined(var_1.location)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.airdroptype, self.origin);
  }

  airdropvisualmarkeractivate(var_1, var_0.airdroptype, var_0);
  return true;
}

function airdropvisualmarkeractivate(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::drop_to_ground(var_0.location, 50, -200, (0, 0, 1));
  var_3 += (0, 0, 1);
  var_4 = spawn("script_model", var_3);
  var_4 setModel("offhand_wm_grenade_smoke");
  var_4.angles = (0, 90, 90);
  var_5 = spawn("script_model", var_3);
  var_5 setModel("ks_crate_marker_mp");
  var_5 setscriptablepartstate("smoke", "on", 0);

  if(isDefined(var_0.visual)) {
    var_0.visual delete();
  }
}

function tryuseairdropmarker() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("airdrop", self);
  return tryuseairdropmarkerfromstruct(var_0);
}

function tryuseairdropmarkerfromstruct(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_0.deployweaponobj = getcompleteweaponname("deploy_airdrop_mp");
  var_1 = undefined;

  switch (var_0.streakname) {
    case "airdrop":
      var_1 = 1;
      break;
    default:
      var_1 = 0;
      break;
  }

  if(var_1) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      return false;
    }
  }

  if(!tryairdroptriggered(var_0)) {
    if(var_1) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0)) {
      if(var_1) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      return false;
    }
  }

  var_2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var_0, var_0.deployweaponobj, "grenade_fire", undefined, &airdropmarkerswitchended, &airdropmarkerfired, undefined, &airdropmarkertaken);

  if(!istrue(var_2)) {
    if(var_1) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      return false;
    }
  }

  return true;
}

function airdropmarkerfired(var_0, var_1, var_2) {
  var_0.airdroptype = var_0.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "incrementFauxVehicleCount")]]();
  }

  var_2.owner = self;
  thread airdropmarkeractivate(var_2, var_0.airdroptype, undefined);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.airdroptype, self.origin);
  }

  var_0.airdropmarkerfired = 1;
  var_0 notify("killstreak_finished_with_deploy_weapon");
  return "success";
}

function airdropmarkeractivate(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = self.owner.angles;
  self waittill("explode", var_4);
  var_5 = self.owner;

  if(!isDefined(var_5)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }

  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  var_7 = undefined;

  if(var_0 == "airdrop") {
    var_7 = dropkillstreakcratefromscriptedheli(var_5, var_5.team, undefined, var_4, var_3 + (0, 180, 0), var_4, 1, var_2);
  } else if(var_0 == "airdrop_multiple") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "airdropMultipleDropCrates")) {
      var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "airdropMultipleDropCrates")]](var_5, var_5.team, var_4, var_3 + (0, 180, 0), var_4, var_2);
    }
  }

  if(!isDefined(var_7)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
      var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](var_2.mpstreaksysteminfo, "other");
    }

    return;
  }

  var_5 scripts\cp_mp\utility\killstreak_utility::ref_12AA7(var_2);
}

function airdropmarkertaken(var_0) {
  if(istrue(var_0.airdropmarkerfired)) {
    if(isDefined(level.killstreakfinishusefunc)) {
      level thread[[level.killstreakfinishusefunc]](var_0);
    }
  }

  if(isDefined(var_0.airdroptype) && !istrue(var_0.airdropmarkerfired)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      return;
    }

    return;
  }
}

function initbattleroyalecratedata() {
  var_0 = getleveldata("battle_royale");
  var_0.capturestring = &"MP/BR_CRATE";
  var_0.enemymodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.activatecallback = &brcrateactivatecallback;
  var_0.capturecallback = &brcratecapturecallback;
}

function getbrcratedatabytype(var_0) {
  var_1 = spawnStruct();
  var_1.type = var_0;
  return var_1;
}

function brcrateactivatecallback(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function brcratecapturecallback(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "makeItemsFromCrate")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "makeItemsFromCrate")]](var_0);
    return;
  }
}

function dropbrcratefromscriptedheli(var_0) {
  var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", "attachment");
  var_2 = dropcratefromscriptedheli(undefined, undefined, "battle_royale", var_0, (0, randomfloat(360), 0), var_0, getbrcratedatabytype(var_1));

  if(!isDefined(var_2)) {
    return undefined;
  } else if(!isDefined(var_2.crates) || !isDefined(scripts\engine\utility::array_get_first_item(var_2.crates))) {
    return undefined;
  }

  return var_2.crate;
}

function dropbrcratefrommanualheli(var_0) {
  var_1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", "attachment");
  var_2 = dropcratefrommanualheli(undefined, undefined, "battle_royale", var_0, (0, randomfloat(360), 0), 30000, 30000, var_0, getbrcratedatabytype(var_1));

  if(!isDefined(var_2)) {
    return undefined;
  } else if(!isDefined(var_2.crate)) {
    return undefined;
  }

  return var_2.crate;
}

function teamplacement() {
  var_0 = getleveldata("battle_royale_kiosk_drop");
  var_0.dummymodel = relic_landlocked_do_explosion("kiosk_drop");
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 0;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.destroyoncapture = 0;
}

function missionbasetimer(var_0, var_1, var_2) {
  return dropcrate(undefined, var_0, "battle_royale_kiosk_drop", var_1, (0, randomfloat(360), 0), var_2);
}

function initbattleroyaleloadoutcratedata() {
  var_0 = getleveldata("battle_royale_loadout");
  var_0.capturestring = &"MP/BR_CRATE_LOADOUT";
  var_0.dummymodel = relic_landlocked_do_explosion();
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = &brloadoutcrateactivatecallback;
  var_0.capturecallback = &brloadoutcratecapturecallback;
  var_0.destroycallback = &dropradius;
  var_0.destroyoncapture = 0;
  var_0.onecaptureperplayer = 1;
}

function brloadoutcrateactivatecallback(var_0) {
  if(istrue(var_0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "brLoadoutCrateFirstActivation")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "brLoadoutCrateFirstActivation")]](self);
      return;
    }

    return;
  }
}

function brloadoutcratecapturecallback(var_0) {
  giveweaponsfromdropbag(var_0);
}

function dropspecialistbonus(var_0) {
  if(!isDefined(self.numuses)) {
    self.numuses = 0;
  }

  if(!isDefined(self.playersused)) {
    self.playersused = [];
  }

  if(!isDefined(self.playerscaptured)) {
    self.playerscaptured = [];
  }

  self.playerscaptured[var_0 getentitynumber()] = var_0;
  self.playersused[self.playersused.size] = var_0;
  self.numuses++;

  if(isDefined(self.playeroutlines)) {
    foreach(var_2 in self.playeroutlines) {
      if(isDefined(self.outlines) && isDefined(self.outlines[var_2]) && isDefined(self.outlines[var_2].playersvisibleto)) {
        if(self.outlines[var_2].playersvisibleto.size == 1 && self.outlines[var_2].playersvisibleto[0] == var_0) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable")) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](var_2, self);
          }

          self.playeroutlines = scripts\engine\utility::array_remove(self.playeroutlines, var_2);
          break;
        }
      }
    }
  }

  if(self.numuses >= level.teamdata[var_0.team]["teamCount"]) {
    if(isDefined(self.playeroutlines)) {
      foreach(var_5 in self.playeroutlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](var_5, self);
        }
      }
    }

    if(isDefined(self.choosenlocation) && isDefined(self.choosenlocation.inuse)) {
      self.choosenlocation.inuse = 0;
    }

    thread destroycrate();
    return;
  }
}

function dropradius(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "brOnLoadoutCrateDestroyed")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "brOnLoadoutCrateDestroyed")]](var_0);
    return;
  }
}

function giveweaponsfromdropbag(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "br_giveDropBagLoadout")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "br_giveDropBagLoadout")]](var_0);
    return;
  }
}

function dropbrloadoutcrate(var_0, var_1, var_2) {
  return dropcrate(undefined, var_0, "battle_royale_loadout", var_1, (0, randomfloat(360), 0), var_2);
}

function teammateoutlineids() {
  var_0 = getleveldata("battle_royale_c130_loot");

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "gold_war") {
    var_0.capturestring = &"MP/DMZ_LOOT_CRATE_CAPTURE";
  } else {
    var_0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  }

  var_0.dummymodel = relic_landlocked_do_explosion();
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = 600;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = &dialog_wait_think;
  var_0.capturecallback = &dialog_wait_think_civ;
  var_0.destroycallback = &dialogqueue;
  var_0.ingame = &dialogueindex;
  var_0.destroyoncapture = 1;
}

function dialog_wait_think(var_0) {}

function dialog_wait_think_civ(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_c130Airdrop", "c130Airdrop_onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse")]](var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_c130Airdrop", "dmzTut_crateUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_c130Airdrop", "dmzTut_crateUsed")]](var_0);
  }

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(isDefined(level.focus_fire_attacker_timeout)) {
    level.focus_fire_attacker_timeout = scripts\engine\utility::array_remove(level.focus_fire_attacker_timeout, self);
    return;
  }
}

function dialogqueue(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(isDefined(level.focus_fire_attacker_timeout)) {
    level.focus_fire_attacker_timeout = scripts\engine\utility::array_remove(level.focus_fire_attacker_timeout, self);
    return;
  }
}

function dialogueindex() {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

function minshotstostage3acc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = 250;
  var_8 = level.fnhidefoundintel;
  var_9 = 1000;
  var_10 = 10500;
  var_11 = 7500;
  var_12 = 3000;
  var_13 = var_1 + (0, 0, var_9);
  var_14 = "battle_royale_c130_loot";

  if(isDefined(var_3)) {
    var_14 = var_3;
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  var_15 = createcrate(undefined, undefined, var_14, var_0, (0, 0, 0), var_1, undefined, 0);

  if(isDefined(var_15)) {
    var_15.skipminimapicon = 1;

    if(!var_5 && var_13[2] < var_0[2]) {
      var_16 = undefined;
      var_17 = distance(var_0, var_13);

      if(var_17 >= var_10) {
        var_16 = "brc130_drop_high";
      } else if(var_17 >= var_11) {
        var_16 = "brc130_drop_med";
      } else if(var_17 >= var_12) {
        var_16 = "brc130_drop_low";
      }

      if(isDefined(var_16)) {
        var_18 = 1000;
        var_19 = spawn("script_model", var_13 + (0, 0, var_18));
        var_19.angles = var_2;
        var_19 setModel("tag_origin");
        var_15.animname = "care_package";
        var_15.dropanim = level.scr_anim[var_15.animname][var_16];
        var_15.animlength = getanimlength(var_15.dropanim);
        var_15 scripts\common\anim::setanimtree();
        var_20 = spawn("script_model", var_15.origin);
        var_20.angles = var_15.angles;
        var_20.animname = "care_package_chute";
        var_20.dropanim = level.scr_anim[var_20.animname][var_16];
        var_20.animlength = getanimlength(var_20.dropanim);
        var_20 setModel("veh8_mil_lnd_carepackage_parachute_br");
        var_20 scripts\common\anim::setanimtree();
        var_19 thread scripts\common\anim::anim_single_solo(var_15, var_16);
        var_19 thread scripts\common\anim::anim_single_solo(var_20, var_16);
        thread ref_14492();
        thread ref_14493(var_20);
      } else {
        infinite_chopper(var_15);
      }
    } else {
      infinite_chopper(var_15);
    }

    var_21 = "cashdrop_common";
    var_22 = getdvarint("scr_dmz_airdrop_ingame_obj", 1);

    if(var_22) {
      var_21 = "cashdrop_common_world";
    }

    if(isDefined(var_4)) {
      var_21 = var_4;
    }

    var_15 setscriptablepartstate("objective_map", var_21, 0);
    var_15 setscriptablepartstate("crate_audio", "parachuting", 0);
    var_15.ref_13428 = spawn("script_model", var_1);
    var_15.ref_13428 setModel("ks_airdrop_crate_br");

    if(!istrue(var_6)) {
      var_15.ref_13428 setscriptablepartstate("smoke_signal", "on", 0);
    }

    var_23 = getleveldata(var_14);

    if(isDefined(var_23.ref_127FD)) {
      var_15 thread[[var_23.ref_127FD]]();
    }
  }

  return var_15;
}

function ref_14492() {
  self endon("death");
  wait self.animlength;

  if(isDefined(self)) {
    self stopanimScripted();
    infinite_chopper();
    return;
  }
}

function ref_14493(var_0) {
  self endon("death");
  wait self.animlength;

  if(isDefined(self)) {
    self delete();
  }

  if(isDefined(var_0)) {
    var_0 delete();
    return;
  }
}

function teamplunderexfil() {
  var_0 = getleveldata("battle_royale_chopper_loot");
  var_0.capturestring = &"MP/DMZ_PLUNDER_CRATE_CAPTURE";
  var_0.dummymodel = relic_landlocked_do_explosion();
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = 600;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.activatecallback = &dummy_model;
  var_0.capturecallback = &dvarlocations;
  var_0.destroycallback = &dwell_aggro;
  var_0.destroyoncapture = 1;
}

function dummy_model(var_0) {}

function dvarlocations(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_lootchopper", "lootChopper_onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_lootchopper", "lootChopper_onCrateUse")]](var_0);
  }

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
    return;
  }
}

function dwell_aggro(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
    return;
  }
}

function missionbonustimer(var_0, var_1) {
  var_2 = dropcrate(undefined, undefined, "battle_royale_chopper_loot", var_0, (0, randomfloat(360), 0), var_1);

  if(isDefined(var_2)) {
    var_2.skipminimapicon = 1;
    var_3 = "cashdrop_common";
    var_4 = getdvarint("scr_dmz_airdrop_ingame_obj", 1);

    if(var_4) {
      var_3 = "cashdrop_common_world";
    }

    var_2 setscriptablepartstate("objective_map", var_3, 0);
    var_2.ref_13428 = spawn("script_model", var_1);
    var_2.ref_13428 setModel("ks_airdrop_crate_br");
    var_2.ref_13428 setscriptablepartstate("smoke_signal", "on", 0);
  }

  return var_2;
}

function missionid(var_0, var_1) {
  var_2 = dropcrate(undefined, undefined, "battle_royale_chopper_loot", var_0, (0, randomfloat(360), 0), var_1);

  if(isDefined(var_2)) {
    var_2.skipminimapicon = 1;
    var_2 setscriptablepartstate("objective_map", "pe_chopper_crate", 0);
    var_2.ref_13428 = spawn("script_model", var_1);
    var_2.ref_13428 setModel("ks_airdrop_crate_br");
    var_2.ref_13428 setscriptablepartstate("smoke_signal", "pe_chopper_on", 0);
  }

  return var_2;
}

function initplundercratedata() {
  var_0 = getleveldata("esc_cache");
  var_0.capturestring = &"MP/ESC_CACHE_USE_HINT";
  var_0.usetag = "tag_origin";
  var_0.userange = 200;
  var_0.usefov = 160;
  var_0.usepriority = 0;
  var_0.friendlymodel = "military_crate_large_stackable_01";
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -10000;
  var_0.headicon = undefined;
  var_0.minimapicon = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "captureLootCacheCallback")) {
    var_0.capturecallback = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "captureLootCacheCallback")]]();
  }

  var_0.destroyoncapture = 0;
  var_0.onecaptureperplayer = 1;
  var_0.capturevisualscallback = undefined;
  var_0.destroyvisualscallback = undefined;
  var_0.timeout = undefined;
}

function getplcratedata(var_0) {
  var_1 = spawnStruct();
  var_1.contents = var_0;
  return var_1;
}

function placeplcrate(var_0, var_1, var_2) {
  var_3 = placecrate(undefined, undefined, "esc_cache", var_1, var_2, getplcratedata(var_0));
  return var_3;
}

function initarmcratedata() {
  level.cratedata.armweights = [];
  level.cratedata.armcapturestrings = [];
  var_0 = getleveldata("arm_no_owner");
  var_0.activatecallback = &armcrateactivatecallback;
  var_0.capturecallback = &armcratecapturecallback;
  var_0.supportsownercapture = 0;
  var_0.enemymodel = undefined;
  var_0.headicondrawrange = 5000;
  var_0.timeout = 180;
  addarmcratedata("uav", undefined, 5, 10);
  addarmcratedata("manual_turret", undefined, 5, 5);
  addarmcratedata("cruise_predator", undefined, 4, 40);
  addarmcratedata("scrambler_drone_guard", undefined, 4, 20);
  addarmcratedata("precision_airstrike", undefined, 3, 60);
  addarmcratedata("toma_strike", undefined, 2, 40);
  addarmcratedata("chopper_gunner", undefined, 2, 30);
  addarmcratedata("pac_sentry", undefined, 2, 30);
  addarmcratedata("gunship", undefined, 2, 30);
  thread initarmcratedatalate();
}

function initarmcratedatalate() {
  waittillframeend();
  var_0 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\light_tank::light_tank_supported(), 50, 0);
  addarmcratedata("bradley", undefined, 4, var_0);
}

function addarmcratedata(var_0, var_1, var_2, var_3) {
  level.cratedata.armdefconlevels[var_0] = var_2;
  level.cratedata.armweights[var_0] = var_3;
  level.cratedata.armcapturestrings[var_0] = var_1;
}

function getarmcratedatabystreakname(var_0) {
  var_1 = spawnStruct();
  var_1.streakname = var_0;
  return var_1;
}

function armcrateactivatecallback(var_0) {
  var_1 = self.data;
  var_2 = level.cratedata.armcapturestrings[var_1.streakname];

  if(isDefined(var_2)) {
    overridecapturestring(var_2);
    return;
  }
}

function armcratecapturecallback(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "giveKillstreak")) {
    var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "giveKillstreak")]](self.data.streakname, 0, 0, self.owner);
    return;
  }
}

function getrandomarmkillstreak(var_0) {
  var_1 = getarmkillsteakstoexcludebyteamdefconlevel(var_0);
  var_2 = getrandomkeyfromweightsarray(level.cratedata.armweights, var_1);
  return var_2;
}

function getarmkillsteakstoexcludebyteamdefconlevel(var_0) {
  var_1 = level.defconlevel;
  var_2 = undefined;

  if(var_1 > 1) {
    var_2 = [];

    foreach(var_4 in level.cratedata.armdefconlevels) {
      if(var_1 > var_4) {
        var_2 = var_5;
      }
    }
  }

  return var_2;
}

function droparmcratefromscriptedheli(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1) || var_1 == "random") {
    var_1 = getrandomarmkillstreak(var_0);
  }

  var_5 = getarmcratedatabystreakname(var_1);
  var_6 = dropcratefromscriptedheli(undefined, var_0, "arm_no_owner", var_2, var_3, var_4, var_5);

  if(!isDefined(var_6)) {
    return undefined;
  } else if(!isDefined(var_6.crates) || !isDefined(scripts\engine\utility::array_get_first_item(var_6.crates))) {
    return undefined;
  }

  foreach(var_8 in var_6.crates) {
    return var_8;
  }

  var_8 = undefined;
}

function teammatereviveweaponwaitputaway() {
  var_0 = getleveldata("battle_royale_juggernaut");
  var_0.capturestring = &"KILLSTREAKS_HINTS/JUGG_CRATE_PICKUP";
  var_0.dummymodel = relic_landlocked_do_explosion("battle_royale_juggernaut");
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.capturecallback = &display_dont_have_weapon_message;
  var_0.destroycallback = &display_fx_names_after_plane_spawns;
  var_0.activatecallback = &display_cypher_updated;
  var_0.ingame = &display_headicon_to_players;
  var_0.ref_127FD = &display_hint_for_all;
  var_0.destroyoncapture = 1;
}

function display_cypher_updated(var_0) {
  scripts\cp_mp\killstreaks\juggernaut::oncrateactivated(var_0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_juggernaut", "onCrateActivate")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_juggernaut", "onCrateActivate")]](var_0);
    return;
  }
}

function display_dont_have_weapon_message(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_juggernaut", "onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_juggernaut", "onCrateUse")]](var_0);
  }

  scripts\cp_mp\killstreaks\juggernaut::oncratecaptured(var_0);
}

function display_fx_names_after_plane_spawns(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_juggernaut", "onCrateDestroy")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_juggernaut", "onCrateDestroy")]](var_0);
    return;
  }
}

function display_headicon_to_players(var_0, var_1) {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

function display_hint_for_all() {
  self setscriptablepartstate("model", "friendly", 0);
}

function modeallowmeleevehicledamage(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", self);
  return dropcrate(undefined, var_0, "battle_royale_juggernaut", var_1, (0, randomfloat(360), 0), var_2, var_3, 1);
}

function ref_13669(var_0, var_1) {
  var_2 = 4096;

  if(istrue(self.umbra)) {
    var_2 = 10000;
  }

  var_3 = modeallowmeleevehicledamage(self.team, var_0 + (0, 0, var_2), var_0 + (0, 0, 512));
  var_3 endon("death");
  move_payload_to_back_of_super(var_3);
  give_deployable_crate(var_3);
  var_4 = [];

  foreach(var_6 in level.teamdata[self.team]["alivePlayers"]) {}
}

function move_payload_to_back_of_super(var_0) {
  var_0 setotherent(self);
  var_0 setscriptablepartstate("objective_map", "jugg_world");
}

function give_deployable_crate(var_0) {
  var_0 setotherent(self);
  var_0 setscriptablepartstate("model", "friendly");
}

function vehicle_isfriendlytoplayer(var_0) {
  var_1 = 1;

  switch (var_0) {
    case "battle_royale_juggernaut":
      var_1 = 0;
      break;
    case "battle_royale_loadout":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(!istrue(var_2)) {
          var_1 = 0;
        }
      }

      break;
  }

  return var_1;
}

function teamplunderexfilshowviponly() {
  var_0 = getleveldata("battle_royale_tactical_device");
  var_0.capturestring = &"BR_REVEAL_2/R2_TACTICAL_DEVICE";
  var_0.dummymodel = "military_carepackage_01_br_device";
  var_0.friendlymodel = undefined;
  var_0.enemymodel = undefined;
  var_0.mountmantlemodel = undefined;
  var_0.supportsownercapture = 0;
  var_0.headicon = undefined;
  var_0.usepriority = -1;
  var_0.usefov = 180;
  var_0.timeout = undefined;
  var_0.friendlyuseonly = 1;
  var_0.ownerusetime = 0.5;
  var_0.otherusetime = 0.5;
  var_0.capturecallback = &endoperatorsfxondisconnect;
  var_0.activatecallback = &endofmatchdatasent;
  var_0.destroycallback = &endprematchskydiving;
  var_0.ingame = &endptui;
  var_0.destroyoncapture = 1;
}

function endoperatorsfxondisconnect(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_tactical_device", "onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_tactical_device", "onCrateUse")]](var_0);
    return;
  }
}

function modifydestructibledamage(var_0) {
  var_1 = 4096;
  var_2 = var_0 + (0, 0, var_1);
  var_3 = var_0 + (0, 0, 512);
  level.ref_12CE8.plundereventtime = spawnfx(level._effect["smoke_tactical_device"], level.ref_12CE8.level_carepackage_give_player_killstreak_incendiary_launcher - (0, 0, 60));
  triggerfx(level.ref_12CE8.plundereventtime);
  var_4 = dropcrate(undefined, undefined, "battle_royale_tactical_device", var_2, (0, randomfloat(360), 0), var_3);
  var_4.skipminimapicon = 1;
  endround_timescalefactor(var_4);
}

function endofmatchdatasent(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_tactical_device", "onCrateActivate")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_tactical_device", "onCrateActivate")]](var_0);
    return;
  }
}

function endprematchskydiving(var_0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_tactical_device", "onCrateDestroy")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_tactical_device", "onCrateDestroy")]](var_0);
    return;
  }
}

function endptui(var_0, var_1) {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

function endround_timescalefactor(var_0) {
  var_0 setscriptablepartstate("objective_map", "tactical_device_world");
  var_0 setscriptablepartstate("smoke_trail", "on");
  var_0 setscriptablepartstate("jugg_drop_beacon", "on");
}

function relic_landlocked_do_explosion(var_0) {
  var_1 = level.script == "mp_don4" && getdvarint("scr_br_x2_hype", 0);
  var_2 = "";

  if(var_1) {
    var_2 = "x2_military_carepackage_01_br";
  } else if(isDefined(var_0) && var_0 == "battle_royale_juggernaut" && istrue(level.ref_12184)) {
    var_2 = "military_carepackage_01_br_jugg";
  } else if(isDefined(var_0) && var_0 == "kiosk_drop") {
    var_2 = "lm_buy_station_crate_wood_01_ww2";
  } else {
    var_2 = "military_carepackage_02_br";
  }

  return var_2;
}