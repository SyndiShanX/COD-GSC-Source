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
  var0 = spawnStruct();
  var0.configs = [];
  var0.crates = [];
  var0.usablecrates = [];
  level.cratedata = var0;
  level.cratedata.ref_13f28 = pow(getdvarfloat("scr_crateUnresolvedCollisionToleranceSqr", 2), 2);
  level.mpplayerallowcrateuse = &scripts\common\utility::allow_crate_use;
  level.cratedata.mountmantlemodel = getEnt("care_package_col", "targetname");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerActionSet")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerActionSet")]]();
  }

  var2 = "mp";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();
  }

  switch (var2) {
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
        var3 = spawnStruct();
        var3.model = relic_landlocked_do_explosion();
        var3.ref_140a1 = 0.5;
        var3.ref_1409f = 3;
        var3.usefov = 180;
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "brGetGameModeSpecificCrateData")]](var3);
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
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerPlayerFrameUpdateCallback")]](&ref_13c46);
  }

  thread watchallcrateusability();
}

function getleveldata(var0) {
  var1 = level.cratedata.configs[var0];

  if(!isDefined(var1)) {
    var1 = getemptyleveldata();
    level.cratedata.configs[var0] = var1;
  }

  return var1;
}

function getemptyleveldata() {
  var0 = spawnStruct();
  var0.friendlymodel = "military_carepackage_01_friendly";
  var0.enemymodel = "military_carepackage_01_enemy";
  var0.dummymodel = "military_carepackage_01_dummy";
  var0.setplayerbeingrevivedextrainfo = 27.5;
  var0.mountmantlemodel = getdefaultmountmantlemodel();
  var0.objweapon = isundefinedweapon();
  var0.timeout = 90;
  var0.headiconoffset = 0;
  var0.headicondrawrange = 10000;
  var0.headiconnaturalrange = 400;
  var0.minimapicon = "icon_minimap_carepackage";
  var0.usetag = "tag_use";
  var0.userange = 128;
  var0.breakuserangesqr = 30625;
  var0.usefov = 360;
  var0.usepriority = 0;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 3;
  var0.friendlyuseonly = 0;
  var0.navobstaclebounds = (30, 10, 64);
  var0.navobstacleupdatedistsqr = 64;
  var0.dangerzoneheight = 1000;
  var0.dangerzoneradius = 128;
  var0.activatecallback = undefined;
  var0.deactivatecallback = undefined;
  var0.capturecallback = undefined;
  var0.rerollcallback = undefined;
  var0.destroycallback = undefined;
  var0.destroyoncapture = 1;
  var0.onecaptureperplayer = 0;
  var0.destroyvisualscallback = getdefaultdestroyvisualscallback();
  var0.destroyvisualsdeletiondelay = getdefaultdestroyvisualsdeletiondelay();
  var0.capturevisualscallback = getdefaultcapturevisualscallback();
  var0.capturevisualsdeletiondelay = getdefaultcapturevisualsdeletiondelay();
  var0.capturestring = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  var0.rerollstring = &"KILLSTREAKS_HINTS/UAV_REROLL";
  var0.headicon = "hud_icon_head_killstreak_carepackage";
  var0.supportsreroll = 0;
  var0.supportsownercapture = 1;
  var0.supportsothercapture = 1;
  return var0;
}

function hasleveldata(var0) {
  return isDefined(level.cratedata.configs[var0]);
}

function createcrate(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = getleveldata(var2);

  if(var10.supportsownercapture) {}

  if(var10.supportsreroll) {}

  var11 = spawn("script_model", var3);
  var11.angles = var4;

  if(!istrue(var7) && var2 != "battle_royale_c130_loot" || var2 != "battle_royale_loadout") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
      if(var11[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
        var11 delete();
        return undefined;
      }
    }
  }

  var11.owner = var0;
  var11.team = var1;
  var11.objweapon = var10.objweapon;
  var11.cratetype = var2;
  var11.useobject = undefined;
  var11.navobstacle = undefined;
  var11.headiconid = undefined;
  var11.minimapid = undefined;
  var11.dangerzoneid = undefined;
  var11.navobstacleid = undefined;
  var11.destination = var5;
  var11.headiconactive = 0;
  var11.minimapiconactive = 0;
  var11.hasnophysics = istrue(var6);
  var11.physicsactivated = 0;
  var11.isdestroyed = 0;
  var11.data = var8;
  var11.skipminimapicon = var9;
  var11.headicon = var10.headicon;
  var11.minimapicon = var10.minimapicon;
  var11.capturestring = var10.capturestring;
  var11.rerollstring = var10.rerollstring;
  var11.supportsreroll = var10.supportsreroll;

  if(level.gametype == "infect") {
    var11.validate_station = 1;
  }

  var11 setModel(var10.dummymodel);
  var11 setnodeploy(1);
  var11 setCanDamage(0);
  var11 makeunusable();
  var11 enableplayermarks("killstreak");

  if(level.teambased) {
    var11 filteroutplayermarks(var11.team);
  } else {
    var11 filteroutplayermarks(var11.owner);
  }

  var12 = undefined;

  if(isDefined(var10.friendlymodel)) {
    var12 = spawn("script_model", var3);
    var12.angles = var4;
    var12.crate = var11;
    var12 setModel(var10.friendlymodel);
    var12 linkTo(var11);
    var11.childoutlineents = [var12];
  } else {
    var12 = var11;
  }

  var11.friendlymodel = var12;
  var13 = undefined;

  if(isDefined(var10.enemymodel)) {
    if(level.teambased) {}

    var13 = spawn("script_model", var3);
    var13.angles = var4;
    var13.cratedata = var11;
    var13 setModel(var10.enemymodel);
    var13 linkTo(var11);
  }

  var11.enemymodel = var13;

  if(isDefined(var11.enemymodel)) {
    thread watchvisibility();
  }

  var14 = undefined;

  if(!var11.hasnophysics) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() != "br") {
        var14 = spawn("script_model", var3 + (0, 0, 300));
        var14 setscriptmoverkillcam("explosive");

        if(isDefined(self.scenenode)) {
          if(var7) {
            thread looselinkTo(var14, var11);
          } else {
            var14 linkTo(var11);
          }
        }
      }
    }
  }

  if(isDefined(var11.owner)) {
    var11.owner.unset_relic_ammo_drain = 1;
  }

  var11.killcament = var14;
  var15 = createmountmantlemodel(var11);

  if(!var15) {
    var11.unresolved_collision_func = &crateunresolvedcollisioncallback;
  }

  addtolists(var11);

  if(!scripts\engine\utility::is_equal(level.script, "mp_bm_tut")) {
    thread watchcratedestroyearly();
  }

  if(var11.hasnophysics) {
    activatecratefirsttime(var11);
  } else if(var7) {
    infinite_chopper(var11);
  }

  return var11;
}

function activatecratefirsttime() {
  activatecrate(1);
}

function activatecrate(var0) {
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

  if(istrue(var0) && self.cratetype != "battle_royale_loadout" && !istrue(self.skipminimapicon)) {
    createminimapicon();
  }

  _createheadicon();
  makecrateusable();
  var1 = getleveldata(self.cratetype);

  if(isDefined(var1.activatecallback)) {
    self thread[[var1.activatecallback]](var0);
    return;
  }
}

function deactivatecrate(var0) {
  if(istrue(var0)) {
    destroyminimapicon();
  }

  _destroyheadicon();
  makecrateunusable();
  var1 = getleveldata(self.cratetype);

  if(isDefined(var1.deactivatecallback)) {
    self thread[[var1.deactivatecallback]](var0);
    return;
  }
}

function capturecrate(var0) {
  var1 = getleveldata(self.cratetype);

  if(isDefined(self.owner) && istrue(self.owner.unset_relic_ammo_drain)) {
    self.owner.unset_relic_ammo_drain = 0;
  }

  if(isDefined(var1.capturecallback)) {
    self thread[[var1.capturecallback]](var0);
  }

  if(var1.destroyoncapture) {
    var2 = 0;

    if(isDefined(var1.capturevisualscallback)) {
      self thread[[var1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel)) {
        self thread[[var1.capturevisualscallback]](self.enemymodel);
      }

      var2 = var1.capturevisualsdeletiondelay;
    }

    thread deletecrate(var2);
    return;
  }
}

function destroycrate(var0) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  if(!isDefined(var0)) {
    if(isDefined(self.scenenode)) {
      if(isDefined(self.animdroptime)) {
        if(gettime() >= self.animdroptime) {
          self.destroyonactivate = 1;
          return;
        } else {
          var0 = 1;
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
  var1 = getleveldata(self.cratetype);

  if(isDefined(self.owner) && istrue(self.owner.unset_relic_ammo_drain)) {
    self.owner.unset_relic_ammo_drain = 0;
  }

  if(isDefined(var1.destroycallback)) {
    self thread[[var1.destroycallback]](var0);
  }

  if(!istrue(var0)) {
    var2 = undefined;

    if(!istrue(self.physicsactivated) || !istrue(self.ref_12332)) {
      if(isDefined(var1.destroyvisualscallback)) {
        self thread[[var1.destroyvisualscallback]](self.friendlymodel);

        if(isDefined(self.enemymodel)) {
          self thread[[var1.destroyvisualscallback]](self.enemymodel);
        }

        var2 = var1.destroyvisualsdeletiondelay;
      }
    } else if(isDefined(var1.capturevisualscallback)) {
      self thread[[var1.capturevisualscallback]](self.friendlymodel);

      if(isDefined(self.enemymodel)) {
        self thread[[var1.capturevisualscallback]](self.enemymodel);
      }

      var2 = var1.capturevisualsdeletiondelay;
    }

    thread deletecrate(var2);
    return;
  }

  thread lastactivateinstruct();
}

function deletecrate(var0) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  self notify("death");
  self.isdestroyed = 1;
  level notify("lootcache_opened_kill_callout" + self.origin);
  var1 = isDefined(self.friendlymodel) && self.friendlymodel != self;

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

  if(var1) {
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
    var2 = spawnfx(level._effect["airdrop_hype_paper_exp"], self.origin);
    triggerfx(var2);
    self setscriptablepartstate("model", "hide_both");
  }

  wait var0;

  if(var1) {
    self.friendlymodel delete();
  }

  if(isDefined(self.enemymodel)) {
    self.enemymodel delete();
  }

  self delete();
}

function lastactivateinstruct() {
  var0 = level.framedurationseconds;

  if(isDefined(self getlinkedscriptableinstance()) && self getscriptablehaspart("visibility")) {
    self setscriptablepartstate("visibility", "hide", 1);
  }

  deletecrate(var0);
}

function watchcratedestroyearly() {
  self endon("death");
  var0 = getleveldata(self.cratetype);

  if(isDefined(var0.timeout)) {}

  watchcratedestroyearlyinternal(var0.timeout);

  if(istrue(self.nevertimeout)) {
    return;
  }

  thread destroycrate();
}

function watchcratedestroyearlyinternal(var0) {
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");

  if(isDefined(var0)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
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
  var0 = spawnStruct();
  var0.helis = [];
  var1 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var1)) {
    var0.heliheight = var1.origin[2] - 750;

    if(issubstr(level.mapname, "aniyah")) {
      var0.heliheight = var1.origin[2] + 500;
    }
  } else {
    var0.heliheight = 850;
  }

  var0.heliheightoffset = 128;
  level.cratedropdata = var0;
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

function placecrate(var0, var1, var2, var3, var4, var5, var6) {
  return createcrate(var0, var1, var2, var3, var4, undefined, 1, 0, var5, var6);
}

function dropcrate(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var5)) {
    var8 = getcratedropcaststart(var3, 0);
    var5 = getcratedropdestination(var8, getcratedropcastend(var8, 0));
  }

  return createcrate(var0, var1, var2, var3, var4, var5, undefined, 1, var6, var7);
}

function dropcratefrommanualheli(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var3 = getcratedropcaststart(var3, 1);
  var9 = var3[2];

  if(!isDefined(var7)) {
    var7 = getcratedropdestination(var3, getcratedropcastend(var3, 1));

    if(!isDefined(var7)) {
      return undefined;
    }
  }

  var10 = spawnStruct();
  var10.owner = var0;
  var10.team = var1;
  var10.hasowner = isDefined(var0);
  var4 *= (0, 1, 0);
  var11 = var3 + -1 * anglesToForward(var4) * var5;
  var10.dropposition = var3;
  var10.exitposition = var3 + anglesToForward(var4) * var6;
  var12 = undefined;

  if(isDefined(var8)) {
    var12 = var8.vehicleisreserved;
  }

  var13 = createheli(var0, var1, var11, var4, var12);
  var13.dropstruct = var10;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "br") {
      var13 vehicle_setspeed(100, 60);
    } else {
      var13 vehicle_setspeed(200, 100);
    }
  }

  var13 setmaxpitchroll(15, 15);
  var13 setscriptablepartstate("lights", "active", 1);
  var10.heli = var13;
  var14 = createcrate(var0, var1, var2, var11, var13.angles, var7, undefined, 0, var8);
  var14.dropstruct = var10;
  var14 linkTo(var13, "tag_origin", (16, 0, -156), (0, 0, 0));
  var10.crate = var14;
  thread watchdropcratefrommanualheli();
  return var10;
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
    self.heli scripts\engine\utility::ref_143a5("death", "goal");

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
      self.heli scripts\engine\utility::ref_143a5("death", "goal");
      return;
    }

    return;
  }
}

function docratedropfrommanualheli() {
  var0 = self.crate;
  self.crate.dropstruct = undefined;
  self.crate = undefined;
  infinite_chopper(var0);
}

function createcrateforscripteddrop(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  var11 = createcrate(var0, var1, var2, var8.origin, var8.angles, var3, var4, var5, var6);

  if(!isDefined(var11)) {
    return undefined;
  }

  var11.scenenode = var8;
  var11.streakinfo = var7;

  if(!isDefined(var8.crates)) {
    var8.crates = [];
  }

  var8.crates[var11 getentitynumber()] = var11;
  var11.friendlymodel setscriptablepartstate("visibility", "hide", 0);

  if(isDefined(var11.enemymodel)) {
    var11.enemymodel setscriptablepartstate("visibility", "hide", 0);
  }

  var11.animname = var9;
  var11 scripts\common\anim::setanimtree();
  var12 = level.scr_anim[var9][var10];
  var13 = getanimlength(var12) * 1000;
  var11.animdroptime = gettime() + getnotetracktimes(var12, "carepackage_drop")[0] * var13;
  var11.animstoptrailtime = gettime() + getnotetracktimes(var12, "carepackage_trail_end")[0] * var13;
  var11.animendtime = gettime() + var13;
  var8.latestanimendtime = scripts\engine\utility::ter_op(var11.animendtime > var8.latestanimendtime, var11.animendtime, var8.latestanimendtime);
  return var11;
}

function createchuteforscripteddrop(var0, var1, var2, var3) {
  if(!isDefined(var0.chutes)) {
    var0.chutes = [];
  }

  var4 = spawn("script_model", var0.origin);
  var4.angles = var0.origin;
  var4.scenenode = var0;
  var4.crate = var1;
  var4.crateanimdroptime = var1.animdroptime;
  var0.chutes[var4 getentitynumber()] = var4;
  var4 setModel("veh8_mil_lnd_carepackage_parachute");
  var4 setscriptablepartstate("visibility", "hide", 0);
  var4.animname = var2;
  var4 scripts\common\anim::setanimtree();
  var5 = level.scr_anim[var2][var3];
  var6 = getanimlength(var5) * 1000;
  var4.animendtime = gettime() + getanimlength(level.scr_anim[var2][var3]) * 1000;
  var4.animunhidetime = gettime() + getnotetracktimes(var5, "chute_unhide")[0] * var6;
  var4.animendtime = gettime() + var6;
  var0.latestanimendtime = scripts\engine\utility::ter_op(var4.animendtime > var0.latestanimendtime, var4.animendtime, var0.latestanimendtime);
  return var4;
}

function destroychute() {
  if(isDefined(self.scenenode)) {
    self.scenenode.chutes[self getentitynumber()] = undefined;
  }

  self delete();
}

function dropcratefromscriptedheli(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      return undefined;
    }
  }

  var8 = getcratedropcaststart(var3, 1);
  var9 = var4 * (0, 1, 0);

  if(!isDefined(var5)) {
    var5 = getcratedropdestination(var8, getcratedropcastend(var8, 1));

    if(!isDefined(var5)) {
      return undefined;
    }
  }

  var10 = spawn("script_model", var8);
  var10.angles = var9;
  var10 setModel("tag_origin");
  var10.owner = var0;
  var10.team = var1;
  var10.hasowner = isDefined(var0);
  var11 = undefined;

  if(isDefined(var6)) {
    var11 = var6.vehicleisreserved;
  }

  var12 = createheli(var0, var1, var8, var9, var11, var7);

  if(!isDefined(var12)) {
    var10 delete();
    return undefined;
  }

  var12.scenenode = var12;
  var12 setscriptablepartstate("visibility", "hide", 0);
  var12.animname = "care_package_heli";
  var10.heli = var12;
  var10.heliendtime = gettime() + getanimlength(level.scr_anim["care_package_heli"]["care_package_drop"]) * 1000;
  var10.latestanimendtime = var10.heliendtime;
  var13 = createcrateforscripteddrop(var0, var1, var2, var5, undefined, 0, var6, var7, var10, "care_package", "care_package_drop");

  if(!isDefined(var13)) {
    return undefined;
  }

  var14 = createchuteforscripteddrop(var10, var13, "care_package_chute", "care_package_drop");

  if(!isDefined(var14)) {
    return undefined;
  }

  var14 setscriptablepartstate("visibility", "hide", 0);
  thread watchdropcratefromscriptedheli();
  return var10;
}

function watchdropcratefromscriptedheli() {
  self endon("death");
  scripts\common\anim::anim_first_frame_solo(self.heli, "care_package_drop");

  foreach(var1 in self.crates) {
    scripts\common\anim::anim_first_frame_solo(var1, "care_package_drop");
  }

  foreach(var4 in self.chutes) {
    scripts\common\anim::anim_first_frame_solo(var4, "care_package_drop");
  }

  watchdropcratefromscriptedheliinternal();

  if(isDefined(self.heli)) {
    thread destroyheli();
  }

  foreach(var1 in self.crates) {
    if(isDefined(var1)) {
      thread destroycrate();
    }
  }

  foreach(var4 in self.chutes) {
    if(isDefined(var4)) {
      thread destroychute();
    }
  }

  self delete();
}

function watchdropcratefromscriptedheliinternal() {
  var0 = undefined;

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

    if(!isDefined(var0)) {
      var0 = 1;
    } else {
      jumpiffalse(var0) LOC_0000015a;
      jumpiffalse(isDefined(self.heli)) LOC_000000ad;
      self.heli setscriptablepartstate("visibility", "show", 0);
      self.heli setscriptablepartstate("lights", "active", 1);
      thread scripts\common\anim::anim_single_solo(self.heli, "care_package_drop");

      foreach(var2 in self.crates) {
        if(isDefined(var2)) {
          var2.friendlymodel setscriptablepartstate("visibility", "show", 0);

          if(isDefined(var2.enemymodel)) {
            var2.enemymodel setscriptablepartstate("visibility", "show", 0);
          }

          thread scripts\common\anim::anim_single_solo(var2, "care_package_drop");
        }
      }

      foreach(var5 in self.chutes) {
        if(isDefined(var5)) {
          thread scripts\common\anim::anim_single_solo(var5, "care_package_drop");
        }
      }

      var0 = 0;
      goto LOC_00000353;
    }

    waitframe();
  }
}

function docratedropfromscripted(var0) {
  var0.scenenode = undefined;
  self.crates[var0 getentitynumber()] = undefined;
  var0.animname = undefined;
  var0.animendtime = undefined;
  var0.animdroptime = undefined;
  var0.animstoptrailtime = undefined;
  var0 notify("anim_finished");
  var0 stopanimScripted();
  infinite_chopper(var0);
}

function getcratedropcaststart(var0, var1) {
  var2 = undefined;

  if(istrue(var1)) {
    var2 = var0 * (1, 1, 0) + (0, 0, getscriptedhelidropheight());
  } else {
    var2 = var0 + (0, 0, 25);
  }

  return var2;
}

function getcratedropcastend(var0, var1) {
  return var0 + (0, 0, -1 * scripts\engine\utility::ter_op(istrue(var1), 8000, 8000));
}

function getcratedropdestination(var0, var1) {
  var2 = undefined;
  var3 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item"]);
  var4 = getcratedropignorelist();
  var5 = physics_raycast(var0, var1, var3, var4, 0, "physicsquery_closest", 1);

  if(isDefined(var5) && var5.size > 0) {
    var2 = var5[0]["position"];
  }

  return var2;
}

function getcratedropignorelist() {
  if(isDefined(level.cratedata.helis) && isDefined(level.cratedata.ac130s)) {
    return scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedropdata.ac130s, level.cratedata.crates]);
  }

  return scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedata.crates]);
}

function createheli(var0, var1, var2, var3, var4, var5) {
  var6 = undefined;
  var7 = "veh8_mil_air_lbravo_mp";

  if(isDefined(var0) && scripts\cp_mp\utility\player_utility::getplayersuperfaction(var0)) {
    var7 = "veh8_mil_air_lbravo_east_mp";
  }

  if(istrue(var4)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }

  if(isDefined(var0)) {
    var6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(var0, var2, var3, "veh_airdrop_mp", var7);
  } else {
    var6 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(level.players[randomint(level.players.size)], var2, var3, "veh_airdrop_mp", var7);
  }

  if(!isDefined(var6)) {
    return undefined;
  }

  if(!isDefined(var1)) {
    var1 = "neutral";
  }

  if(var1 != "neutral") {
    var6 setvehicleteam(var1);
  }

  var6.owner = var0;
  var6.team = var1;
  var8 = undefined;
  var9 = undefined;
  var10 = undefined;

  if(isDefined(level.heliconfigs)) {
    var11 = level.heliconfigs["airdrop"];
    var6.health = var11.maxhealth;
    var8 = var11.callout;
    var9 = var11.vodestroyed;
    var10 = var11.scorepopup;
  } else {
    var6.health = 999999;
  }

  var6.helitype = "airdrop";

  if(isDefined(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      var6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]]("airdrop", "Killstreak_Air", var0, 0, 0);
    }

    if(var1 != "neutral") {
      var6 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", var0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    var6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]]("veh_airdrop_mp", var10, var9, undefined, var8);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    var6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]]("veh_airdrop_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    var6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]]("veh_airdrop_mp");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    var6[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]]("veh_airdrop_mp", &destroyhelicallback);
  }

  var6 setCanDamage(0);
  thread watchhelidestroyearly();
  return var6;
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

function deleteheli(var0) {
  self notify("death");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.heli = undefined;
    self.scenenode = undefined;
  }

  removehelidroppingcratefromlist(self getentitynumber());
  wait var0;
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function destroyhelicallback(var0) {
  destroyheli();
}

function getscriptedhelidropheightbase() {
  return level.cratedropdata.heliheight;
}

function getscriptedhelidropheight() {
  return getscriptedhelidropheightbase() + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

function addhelidroppingcratetolist(var0) {
  var1 = var0 getentitynumber();
  level.cratedropdata.helis[var1] = var0;
}

function removehelidroppingcratefromlist(var0) {
  level.cratedropdata.helis[var0] = undefined;
}

function makecrateusable() {
  var0 = getleveldata(self.cratetype);

  if(istrue(var0.hasnointeraction)) {
    return;
  }

  level.cratedata.usablecrates[self getentitynumber()] = self;
  self.isusable = 1;

  if(var0.supportsownercapture && var0.supportsothercapture) {
    thread watchcrateuse(1);
    var1 = self.useobject;

    if(!isDefined(var1)) {
      var1 = spawn("script_model", self gettagorigin(var0.usetag));
      var1 setModel("tag_origin");
      var1 linkTo(self);
      var1 makeunusable();
      self.useobject = var1;
    }

    thread watchcrateuse(2, var1);
    return;
  }

  if(var0.supportsownercapture) {
    thread watchcrateuse(1);
    return;
  }

  thread watchcrateuse(2);
}

function watchcrateuse(var0, var1) {
  self endon("death");
  self endon("makeCrateUnusable");

  if(isDefined(var1)) {
    var1 endon("death");
  }

  if(var0 == 1) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
    self.owner.unset_relic_ammo_drain = 1;
  }

  var2 = getleveldata(self.cratetype);
  var3 = gettriggerobject(var1);
  var3.usetype = var0;
  var3 setCursorHint("HINT_NOICON");
  var3 sethintonobstruction("show");
  var3 sethinttag(var2.usetag);
  var3 sethintdisplayrange(var2.userange);
  var3 sethintdisplayfov(var2.usefov);
  var3 setuserange(var2.userange);
  var3 setusefov(var2.usefov);
  var3 setusepriority(var2.usepriority);
  var3 setuseholdduration("duration_none");

  if(var3.usetype == 1 && self.supportsreroll) {
    var3 setHintString(self.rerollstring);
  } else {
    var3 setHintString(self.capturestring);
  }

  var3.userate = 1;
  var3.curprogress = 0;

  if(isDefined(var3.ref_140a0)) {
    var3.usetime = var3.ref_140a0;
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    var3.usetime = scripts\engine\utility::ter_op(var0 == 1, var2.ownerusetime, var2.otherusetime);
  }

  var3.inuse = 0;
  var3.playerusing = undefined;

  for(;;) {
    var3 waittill("trigger", var4);

    if(level.gametype == "br") {
      if(self.cratetype == "battle_royale_juggernaut") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "teamJuggMaxReached")) {
          var5 = var4[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "teamJuggMaxReached")]]();

          if(var5) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
              var4[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_TEAM_MAX_REACHED");
            }

            continue;
          }
        }
      }

      if(istrue(var4.isjuggernaut) && !vehicle_isfriendlytoplayer(var4, self.cratetype)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          var4[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
        }

        continue;
      }
    }

    if(canstartusingcrate(var4, var1)) {
      startusingcrate(var4, var1);
      var4.unset_relic_ammo_drain = 1;
      var3.playerusing = var4;
      var6 = watchcrateuseinternal(var4, var1);

      if(isDefined(var4)) {
        stopusingcrate(var4, var1);
      }

      var3.playerusing = undefined;

      if(istrue(var6)) {
        if(isDefined(var4)) {
          var4.unset_relic_ammo_drain = 0;
        }

        if(var2.onecaptureperplayer && self.cratetype != "battle_royale_loadout") {
          if(!isDefined(self.playerscaptured)) {
            self.playerscaptured = [];
          }

          self.playerscaptured[var4 getentitynumber()] = var4;
        }

        if(!isDefined(self.targetname) || self.targetname != "btm_flag_primary_inside") {
          thread capturecrate(var4);
        }
      }
    }
  }
}

function watchcrateuseinternal(var0, var1) {
  var2 = gettriggerobject(var1);

  if(var2.usetype != 1) {
    var0 endon("disconnect");
    var0 endon("joined_team");
    var0 endon("joined_spectators");
  }

  var2.id = "care_package";
  var2.userate = scripts\engine\utility::ter_op(isDefined(var0.objectivescaler), var0.objectivescaler, 1);
  playusesound(var0, var1);

  while(isDefined(var0) && var0 scripts\cp_mp\utility\player_utility::_isalive() && cankeepusingcrate(var0, var1) && var0 useButtonPressed()) {
    var2.curprogress += level.framedurationseconds * var2.userate;

    if(var2.curprogress >= var2.usetime) {
      var2.curprogress = 0;
      return true;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var2, 1);
    }

    waitframe();
  }

  var2.curprogress = 0;
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

function startusingcrate(var0, var1) {
  var2 = gettriggerobject(var1);
  var3 = getleveldata(self.cratetype);

  if(istrue(var0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 0);
    }
  } else {
    var4 = getdvarint("scr_airDrop_use_weapon", 1);

    if(var4) {
      thread br_bunker_alt();
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 0);
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
    var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var2, 0);
    return;
  }
}

function br_bunker_alt() {
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\utility\weapon_utility::ref_12eb2();
  var0 = getcompleteweaponname("ks_use_crate_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0);
  thread br_checkforlaststandfinish(var0);
  self switchtoweapon(var0);
}

function br_checkforlaststandfinish(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("crate_use_end");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var0)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var0);
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);

  if(isDefined(self.lastdroppableweaponobj)) {
    var1 = scripts\cp_mp\utility\weapon_utility::ref_12cc7(self.lastdroppableweaponobj);
    self switchtoweapon(var1);
    thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var1);
    return;
  }
}

function stopusingcrate(var0, var1) {
  var2 = gettriggerobject(var1);
  var3 = getleveldata(self.cratetype);

  if(istrue(var0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 1);
    }
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet")) {
    var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 1);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress")) {
    var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](var2, 0);
  }

  stopusesound(var0, var1);
  var0 notify("crate_use_end");
}

function canstartusingcrate(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "specialCase_canUseCrate")) {
    if(!var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "specialCase_canUseCrate")]]()) {
      return 0;
    }
  }

  if(!var0 scripts\common\utility::is_crate_use_allowed()) {
    return 0;
  }

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(var0 isonladder()) {
    return 0;
  }

  if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[var0 getentitynumber()])) {
    return 0;
  }

  if(istrue(self.issquadonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var0)) {
      return 0;
    }

    if(var0.squadindex != self.squadindex || var0.team != self.team) {
      return 0;
    }
  }

  if(istrue(self.validate_station)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, var0)) {
      return 0;
    }

    if(var0.team != self.team) {
      return 0;
    }
  }

  if(isbot(var0)) {
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

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var2) {
    return canstartusingcratetriggerobject(var0, var1);
  }

  if(level.gametype == "br" && var0 isskydiving()) {
    return 0;
  }

  if(istrue(var0.inlaststand)) {
    return 0;
  }

  return 1;
}

function canstartusingcratetriggerobject(var0, var1) {
  var2 = gettriggerobject(var1);

  if(isDefined(var2.playerusing) && var2.playerusing != var0) {
    return false;
  }

  if(var2.usetype == 1 && (!isDefined(self.owner) || var0 != self.owner)) {
    return false;
  }

  if(var2.usetype == 2 && isDefined(self.owner) && var0 == self.owner) {
    return false;
  }

  if(level.teambased && isDefined(self.team) && self.team != "neutral") {
    var3 = getleveldata(self.cratetype);

    if(var3.friendlyuseonly && var0.team != self.team) {
      return false;
    }
  }

  return true;
}

function cankeepusingcrate(var0, var1) {
  if(!scripts\common\utility::is_crate_use_allowed()) {
    return false;
  }

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(var0 meleeButtonPressed()) {
    return false;
  }

  if(var0 isinexecutionvictim()) {
    return false;
  }

  if(istrue(var0.inlaststand)) {
    return false;
  }

  var2 = getleveldata(self.cratetype);

  if(isDefined(var2.breakuserangesqr) && distancesquared(var0.origin, gettriggerobject(var1).origin) >= var2.breakuserangesqr) {
    return false;
  }

  if(!self.isusable) {
    return false;
  }

  return true;
}

function ref_11a9c(var0, var1) {
  var0 enableplayeruse(var1);

  if(isDefined(var0.useobject)) {
    var0.useobject enableplayeruse(var1);
  }

  if(!canstartusingcrate(var0, var1, var0.useobject, 0)) {
    var0 disableplayeruse(var1);

    if(isDefined(var0.useobject)) {
      var0.useobject disableplayeruse(var1);
      return;
    }

    return;
  }

  if(!canstartusingcratetriggerobject(var0, var1, undefined)) {
    var0 disableplayeruse(var1);
  }

  if(isDefined(var0.useobject)) {
    if(!canstartusingcratetriggerobject(var0, var1, var0.useobject)) {
      var0.useobject disableplayeruse(var1);
      return;
    }

    return;
  }
}

function ref_14485() {
  for(;;) {
    foreach(var1 in level.cratedata.usablecrates) {
      if(!isDefined(var1)) {
        thread scripts\engine\utility::error("airdrop crate was deleted incorrectly.");
        continue;
      }

      var1 makeusable();
      var1 istacmapactive();

      if(isDefined(var1.useobject)) {
        var1.useobject makeusable();
        var1.useobject istacmapactive();
      }

      var2 = level.players;

      if(level.teambased && isDefined(var1.team) && var1.team != "neutral") {
        var3 = getleveldata(var1.cratetype);

        if(var3.friendlyuseonly) {
          var2 = level.teamdata[var1.team]["alivePlayers"];
        }
      }

      foreach(var5 in var2) {
        var6 = distancesquared(var1.origin, var5.origin) < 57600;

        if(var6) {
          ref_11a9c(var1, var5);
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

function playusesound(var0, var1) {
  var2 = gettriggerobject(var1);

  if(var2.usetype == 1) {
    var0 playLoopSound("mp_care_package_owner_cap");
    return;
  }

  var0 playLoopSound("mp_care_package_non_owner_cap");
}

function stopusesound(var0, var1) {
  var2 = gettriggerobject(var1);

  if(var2.usetype == 1) {
    var0 stoploopsound("mp_care_package_owner_cap");
  } else {
    var0 stoploopsound("mp_care_package_non_owner_cap");
  }

  if(var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    var0 playsoundonmovingent("mp_care_package_cap_tail");
    return;
  }
}

function gettriggerobject(var0) {
  return scripts\engine\utility::ter_op(isDefined(var0), var0, self);
}

function infinite_chopper(var0, var1) {
  var2 = getleveldata(self.cratetype);

  if(isDefined(var2.ingame)) {
    self thread[[var2.ingame]]();
  }

  if(!isDefined(var0)) {
    var0 = (0, 0, 0);
  }

  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  self unlink();
  self physicslaunchserver(var0, var1);
  var3 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(var3, (0, 0, -1));
  self.physicsactivated = 1;
  createdangerzone();
  thread ref_11cfe();
  thread ref_11d0b();
  thread ref_11d17();
}

function infilweaponraise() {
  if(!istrue(self.physicsactivated)) {
    return;
  }

  self.physicsactivated = undefined;
  self.ref_12332 = undefined;
  self physicsstopserver();
  headicon_z_offset();
  ref_11d0c();
  ref_11d18();
  generatecodestoshow();
}

function ref_11cfe() {
  self endon("death");
  self notify("monitorAverageVelocityAndUpdate");
  self endon("monitorAverageVelocityAndUpdate");
  var0 = 0.1;
  thread ref_11cfd(var0, 8);
  var1 = 0;
  var2 = 0;
  self.unset_relic_amped = 1;
  var3 = undefined;
  var4 = undefined;
  jumpiffalse(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated")) LOC_0000005c;
  var4 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated");

  for(;;) {
    var5 = registeronplayerjointeamnospectatorcallback();
    var6 = registeronplayerdisconnect();

    if(isDefined(var5) && isDefined(var6)) {
      if(var5 <= 5 && var6 <= 1) {
        var1++;
        var2 = 0;

        if(var1 == 6) {
          self.ref_12332 = 1;
          var3 = self.origin;
          thread activatecrate(self.unset_relic_amped);

          if(isDefined(var4) && [[var4]]()) {
            ref_11d0c();

            if(isDefined(self.killcament)) {
              self.killcament delete();
            }
          }

          var0 = 0.1;
          thread ref_11cfd(var0, 3, 3);
          lb_mg_dmg_factor_tail_rotor();
        }
      } else {
        if(isDefined(var3)) {
          if(distancesquared(self.origin, var3) <= 2500) {
            wait var0;
            continue;
          }
        }

        var2++;
        var1 = 0;

        if(var2 == 1) {
          self.ref_12332 = undefined;
          thread deactivatecrate();
          var0 = 0.1;
          thread ref_11cfd(var0, 8);
        }
      }

      wait var0;
      continue;
    }

    waitframe();
  }
}

function ref_11cfd(var0, var1, var2) {
  headicon_z_offset();
  self endon("death");
  self endon("clear_average_velocities");
  self.x1ops2 = [];
  self.buildrespawnlist = [];
  self.ref_1428a = 0;
  self.ref_14285 = 0;
  self.ref_14287 = var1;
  jumpiffalse(isDefined(var2)) LOC_0000007a;
  var2 = int(clamp(var2, 0, var1));
  jumpiffalse(var2 > 0) LOC_0000007a;

  for(var3 = 0; var3 < var2; var3++) {
    self.x1ops2[self.ref_1428a + var3] = 0;
    self.buildrespawnlist[self.ref_1428a + var3] = 0;
  }

  for(;;) {
    var4 = self physics_getbodyid(0);
    var5 = physics_getbodylinvel(var4);
    var6 = physics_getbodyangvel(var4);
    self.x1ops2[self.ref_14285] = length(var5);
    self.buildrespawnlist[self.ref_14285] = length(var6);
    self.ref_14285++;
    var7 = self.ref_14285 - self.ref_1428a;

    if(var7 > var1) {
      var8 = scripts\engine\utility::mod(var7, var1);

      for(var3 = 0; var3 < var8; var3++) {
        self.x1ops2[self.ref_1428a + var3] = undefined;
        self.buildrespawnlist[self.ref_1428a + var3] = undefined;
      }

      self.ref_1428a += var8;
    }

    self.checkrequiredteamstreamcount = undefined;
    self.checkreload = undefined;
    wait var0;
  }
}

function registeronplayerjointeamnospectatorcallback() {
  if(isDefined(self.checkrequiredteamstreamcount)) {
    return self.checkrequiredteamstreamcount;
  }

  if(!isDefined(self.x1ops2)) {
    return undefined;
  }

  if(self.ref_14285 - self.ref_1428a < self.ref_14287) {
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

  if(self.ref_14285 - self.ref_1428a < self.ref_14287) {
    return undefined;
  }

  forcestuckdamageclear();
  return self.checkreload;
}

function forcestuckdamageclear() {
  var0 = 0;
  var1 = 0;

  for(var2 = self.ref_1428a; var2 < self.ref_14285; var2++) {
    var0 += self.x1ops2[var2];
    var1 += self.buildrespawnlist[var2];
  }

  self.checkrequiredteamstreamcount = var0 / self.ref_14287;
  self.checkreload = var1 / self.ref_14287;
}

function headicon_z_offset() {
  self notify("clear_average_velocities");
  self.x1ops2 = undefined;
  self.buildrespawnlist = undefined;
  self.ref_14287 = undefined;
  self.ref_1428a = undefined;
  self.ref_14285 = undefined;
  self.checkrequiredteamstreamcount = undefined;
  self.checkreload = undefined;
}

function ref_11d0b(var0) {
  ref_11d0c();
  self endon("monitorImpactEnd");
  self.ref_11d0e = 1;
  self playLoopSound("mp_care_package_drop_lp");
  self physics_registerforcollisioncallback();
  ref_11d0d(var0);

  if(isDefined(self)) {
    thread ref_11d0c();
    return;
  }
}

function ref_11d0d(var0) {
  self endon("death");

  if(isDefined(var0)) {
    wait var0;
  }

  var1 = 0;

  for(;;) {
    self waittill("collision", var2, var3, var4, var5, var6, var7, var8, var9);

    if(isDefined(var9)) {
      if(isDefined(var9.classname) && var9.classname == "scriptable_iw8_chicken_01") {
        thread br_badcircleareas(var9);
      }

      getkioskyawoffsetoverride(var9);
    }

    if(isDefined(var9) && start_chants_on_movement(var9)) {
      if(var9 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks()) {
        var9 thread scripts\cp_mp\killstreaks\helper_drone::helperdronedestroyed();
      }
    }

    if(gettime() - var1 >= 200) {
      var1 = gettime();
      var10 = physics_getsurfacetypefromflags(var5);
      var11 = getsubstr(var10["name"], 9);

      if(var11 == "user_terrain1") {
        var11 = "user_terrain_1";
      }

      if(var11 == "user_terrain5") {
        var11 = "user_terrain_5";
      }

      ref_1273b(var6, var7, var8, var11);
    }
  }
}

function getkioskyawoffsetoverride(var0) {
  if(isDefined(var0.script_noteworthy) && isstartstr(var0.script_noteworthy, "train_") && !isDefined(self getlinkedparent())) {
    if(isDefined(self.ref_13cc8)) {
      if(self.ref_13cc8 == var0) {
        return;
      } else {
        generatecodestoshow();
      }
    }

    self.ref_13cc8 = var0;
    self.ref_13cc7 = 4;
    thread getknivesoutsetting(var0);
    return;
  }
}

function getknivesoutsetting(var0) {
  self endon("death");
  self endon("cancel_link_to_train");
  var0 endon("death");
  var1 = getleveldata(self.cratetype);
  var2 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
  var3 = [self];

  foreach(var5 in self getlinkedchildren(1)) {
    var3 = var5;
  }

  self.ref_13cce = 0;
  self.ref_13cd0 = 0;

  while(self.ref_13cce < 5) {
    var7 = self.origin + anglestoup(self.angles) * var1.setplayerbeingrevivedextrainfo;
    var8 = var7 + (0, 0, -200);
    var9 = scripts\engine\trace::ray_trace(var7, var8, var3, var2);

    if(var9.size > 0 && isDefined(var9["entity"]) && var9["entity"] == self.ref_13cc8) {
      var10 = combineangles(invertangles(var0.angles), var0.origin - var9["position"]);

      if(!isDefined(self.ref_13ccf)) {} else if(distancesquared(var10, self.ref_13ccf) > 25) {
        self.ref_13cce++;
        self.ref_13cd0 = 0;
      } else if(vectordot(var10, self.ref_13ccf) < 0.997) {
        self.ref_13cce++;
        self.ref_13cd0 = 0;
      } else {
        self.ref_13cd0++;

        if(self.ref_13cd0 >= 4) {
          self linkTo(var0);
          activatecrate(self.unset_relic_amped);
          thread infilweaponraise();
          break;
        }
      }

      self.ref_13ccf = var10;
    } else {
      break;
    }

    wait 0.05;
  }

  thread generatecodestoshow();
}

function generatecodestoshow() {
  self notify("cancel_link_to_train");
  self.ref_13cc8 = undefined;
  self.ref_13ccf = undefined;
  self.ref_13cce = undefined;
  self.ref_13cd0 = undefined;
}

function br_badcircleareas(var0) {
  self endon("death");
  var1 = gettime();

  while(gettime() - var1 < 3000) {
    var0 dodamage(100, var0.origin, self, self, "MOD_CRUSH");
    wait 0.5;
  }
}

function ref_11d0c() {
  if(!istrue(self.ref_11d0e)) {
    return;
  }

  self notify("monitorImpactEnd");
  self.ref_11d0e = undefined;
  self stoploopsound("mp_care_package_drop_lp");
  self physics_unregisterforcollisioncallback();
}

function start_chants_on_movement(var0) {
  if(!istrue(self.ref_12332)) {
    if(isDefined(var0.classname)) {
      if(var0.classname == "worldSpawn") {
        return false;
      } else if(var0.classname == "script_vehicle") {
        if(var0 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks()) {
          var1 = getleveldata(self.cratetype);
          var2 = self.origin + anglestoup(self.angles) * var1.setplayerbeingrevivedextrainfo;
          return (var0.origin[2] <= var2[2]);
        }
      }
    }
  }

  return false;
}

function ref_11d17() {
  ref_11d18();
  self endon("death");
  self endon("monitorPlayerImpactEnd");
  var0 = self;

  if(isDefined(self.mountmantlemodel)) {
    var0 = self.mountmantlemodel;
  }

  var1 = undefined;
  jumpiffalse(isDefined(self.owner)) LOC_00000038;
  var1 = self.owner;

  while(isDefined(var0)) {
    var0 waittill("player_pushed", var2, var3);

    if(isDefined(var2) && (isPlayer(var2) || isagent(var2)) && var2 scripts\cp_mp\utility\player_utility::_isalive()) {
      var4 = var3[2] <= -8;
      var5 = 0;
      var6 = undefined;

      if(var2 tagexists("j_mainroot")) {
        var6 = var2 gettagorigin("j_mainroot");
        var7 = getleveldata(self.cratetype);
        var8 = self.origin + anglestoup(self.angles) * var7.setplayerbeingrevivedextrainfo;
        var5 = var6[2] <= var8[2];
      }

      if(var4 && var5) {
        var9 = var1;

        if(!isDefined(var9)) {
          var9 = var2;
        }
      }
    }
  }
}

function ref_11d18() {
  self notify("monitorPlayerImpactEnd");
}

function ref_1273b(var0, var1, var2, var3) {
  playFX(scripts\engine\utility::getfx("airdrop_crate_impact"), var0, var1);

  if(var2 < 150) {
    self playsurfacesound("mp_care_package_low_impact", var3);
  } else if(var2 < 300) {
    self playsurfacesound("mp_care_package_med_impact", var3);
  } else {
    self playsurfacesound("mp_care_package_high_impact", var3);
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
  var0 = getleveldata(self.cratetype);
  var1 = undefined;

  if(isDefined(self.owner) && isDefined(self.team)) {
    var1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](self.destination, var0.dangerzoneradius, var0.dangerzoneheight, self.team, 30, self.owner, 1);
  } else if(isDefined(self.team)) {
    var1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](self.destination, var0.dangerzoneradius, var0.dangerzoneheight, self.team, 30);
  } else {
    var1 = spawnuniversaldangerzone(self.destination, var0.dangerzoneradius, var0.dangerzoneheight, 30);
  }

  self.dangerzoneid = var1;
  return var1;
}

function spawnuniversaldangerzone(var0, var1, var2, var3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    var4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var0, var1, var2, undefined, var3, level.players[randomint(level.players.size)], 1);
    self.dangerzoneid = var4;
    return var4;
  }
}

function destroydangerzone() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "isSpawnDangerZoneAlive") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "removeSpawnDangerZone")) {
    var0 = self.dangerzoneid;

    if(isDefined(var0) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "isSpawnDangerZoneAlive")]](var0)) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "removeSpawnDangerZone")]](var0);
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

  var0 = getleveldata(self.cratetype);
  var1 = createnavobstaclebybounds(self.origin, var0.navobstaclebounds, self.angles);
  self.navobstacleid = var1;
  GscBinSkip4(0x35, var1, self.origin, var0.navobstacleupdatedistsqr);
}

function _watchnavobstacle(var0, var1, var2) {
  self endon("death");

  while(distancesquared(var1, self.origin) < var2) {
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
  var0 = getleveldata(self.cratetype);

  if(isDefined(var0.mountmantlemodel)) {
    if(isDefined(self.mountmantlemodel)) {
      self.mountmantlemodel delete();
    }

    var1 = spawn("script_model", self.origin);
    var1 dontinterpolate();
    var1.angles = self.angles;
    var1.owner = self.owner;
    var1.unresolved_collision_func = &crateunresolvedcollisioncallback;
    var1.killcament = self.killcament;
    var1.mountmantlemodel = 1;
    var1 clonebrushmodeltoscriptmodel(level.cratedata.mountmantlemodel);
    var1 linkTo(self);
    self.mountmantlemodel = var1;
    var1.crate = self;
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

function crateunresolvedcollisioncallback(var0, var1) {
  if(level.cratedata.ref_13f28 > 0) {
    if(lengthsquared(var1) <= level.cratedata.ref_13f28) {
      return;
    }
  }

  var2 = self.objweapon;

  if(isDefined(self.init_airdrop_anims)) {
    var2 = self.crate.objweapon;
  }

  var0 dodamage(1000, var0.origin, self.owner, self, "MOD_CRUSH", var2);
  self endon("death");
  var0 endon("death_or_disconnect");

  if(isPlayer(var0) && var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "unresolvedCollisionNearestNode")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "unresolvedCollisionNearestNode")]](var0, undefined, self);
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
  var0 = getleveldata(self.cratetype);
  var1 = undefined;

  if(isDefined(self.headicon)) {
    if(level.teambased && isDefined(self.team)) {
      if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var1 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.team, self.headicon, var0.headiconoffset, 1, var0.headicondrawrange, var0.headiconnaturalrange, undefined, 1);
      }

      if(isDefined(var1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isMLGMatch")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isMLGMatch")]]()) {
            removeclientfromheadiconmask(var1, "spectator");
          }
        }
      }
    } else if(isDefined(self.owner)) {
      if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var1 = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.owner, self.headicon, var0.headiconoffset, 1, var0.headicondrawrange, var0.headiconnaturalrange, undefined, 1);
      }

      if(isDefined(var1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isMLGMatch")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isMLGMatch")]]()) {
            removeclientfromheadiconmask(var1, "spectator");
          }
        }
      }
    } else if(!scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.teamnamelist, self.headicon, var0.headiconoffset, 1, var0.headicondrawrange, var0.headiconnaturalrange);
    }
  }

  self.headiconid = var1;
  self.headiconactive = 1;
  return var1;
}

function _destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.headiconactive = 0;
}

function createminimapicon() {
  destroyminimapicon();
  var0 = getleveldata(self.cratetype);
  var1 = undefined;

  if(isDefined(self.minimapicon) && !istrue(self.visibilitymanuallycontrolled)) {
    var2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
      var2 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");
    }

    if(isDefined(var2)) {
      if(level.teambased && isDefined(self.team)) {
        var1 = self[[var2]](self.minimapicon, self.team, 1, 1, 0);
      } else if(isDefined(self.owner)) {
        var1 = self[[var2]](self.minimapicon, undefined, 1, 1, 0);
      } else {
        var1 = self[[var2]](self.minimapicon, undefined, 0, 1, 0);
      }
    }
  }

  self.minimapid = var1;
  self.minimapiconactive = 1;
  return var1;
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

  foreach(var1 in level.players) {
    updatevisibilityforplayer(var1);
  }

  waitframe();
  GscBinSkip4(0x35);
}

function watchvisibilityinternal() {
  for(;;) {
    level waittill("joined_team", var0);
    updatevisibilityforplayer(var0);
  }
}

function updatevisibilityforplayer(var0) {
  self.friendlymodel hidefromplayer(var0);
  self.enemymodel hidefromplayer(var0);

  if(var0.team == "spectator") {
    self.friendlymodel showtoplayer(var0);
    return;
  }

  if(level.teambased && isDefined(self.team)) {
    if(var0.team == self.team) {
      self.friendlymodel showtoplayer(var0);
      return;
    }

    self.enemymodel showtoplayer(var0);
    return;
  }

  if(!level.teambased && isDefined(self.owner)) {
    if(var0 == self.owner) {
      self.friendlymodel showtoplayer(var0);
      return;
    }

    self.enemymodel showtoplayer(var0);
    return;
  }
}

function looselinkTo(var0, var1, var2) {
  self endon("death");
  var0 endon("death");
  self notify("looseLinkTo");
  self endon("looseLinkToEnd");

  while(istrue(self.physicsactivated)) {
    self.origin = var0.origin + var1;
    waitframe();
  }

  self linkTo(var0);
}

function addtolists() {
  level.cratedata.crates[self getentitynumber()] = self;
}

function removefromlists(var0) {
  if(!isDefined(level.cratedata)) {
    return;
  }

  level.cratedata.crates[var0] = undefined;
}

function getrandomkeyfromweightsarray(var0, var1) {
  if(isDefined(var1)) {
    if(!isarray(var1)) {
      var1 = [var1];
    }
  }

  var2 = [];
  var3 = [];
  var4 = 0;

  foreach(var11, var6 in var0) {
    if(var6 > 0) {
      var7 = 0;

      if(isDefined(var1)) {
        if(var1.size > 0) {
          foreach(var9 in var1) {
            if(var9 == var11) {
              var1[var10] = undefined;
              var7 = 1;
              break;
            }
          }
        } else {
          var1 = undefined;
        }
      }

      if(!var7) {
        var4 += var6;
        var2 = var11;
        var3 = var4;
      }
    }
  }

  var12 = randomint(var4);
  var11 = undefined;

  for(var13 = 0; var13 < var2.size; var13++) {
    var4 = var3[var13];

    if(var12 < var4) {
      var11 = var2[var13];
      break;
    }
  }

  return var11;
}

function getdefaultcapturevisualscallback() {
  return &defaultcapturevisualscallback;
}

#using_animtree("scriptables");

function getdefaultcapturevisualsdeletiondelay() {
  return getanimlength(%mp_military_carepackage_straps_falling);
}

#using_animtree("");

function defaultcapturevisualscallback(var0) {
  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.isdummyarmcrate)) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  var1 = getanimlength(%mp_military_carepackage_straps_falling);

  if(isDefined(var1)) {
    var1 = max(0, var1 - 0.05);
  }

  var0 setscriptablepartstate("anims", "capture", 0);
  var0 setscriptablepartstate("capture", "start", 0);
  var0 notsolid();

  if(isDefined(var1)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var1);
  }

  playFX(scripts\engine\utility::getfx("airdrop_crate_capture"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
}

function getdefaultdestroyvisualsdeletiondelay() {
  return false;
}

function getdefaultdestroyvisualscallback() {
  return &defaultdestroyvisualscallback;
}

function defaultdestroyvisualscallback(var0) {}

function getdefaultmountmantlemodel() {
  return level.cratedata.mountmantlemodel;
}

function getnumdroppedcrates() {
  if(!isDefined(level.cratedata)) {
    return 0;
  }

  return level.cratedata.crates.size;
}

function ref_13c46() {
  if(!isDefined(self.numactivejuggdrops)) {
    if(self ismantling()) {
      var0 = self getmovingplatformparent();

      if(isDefined(var0) && isDefined(var0.crate)) {
        self.num_shot_taken_to_next_damage_state = var0;
        self.num_times_stealth_broken_tv_station_interior = var0.crate;
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

  foreach(var2 in level.cratedata.crates) {
    if(isDefined(var2) && istrue(var2.physicsactivated) && !istrue(var2.ref_12332)) {
      if(isDefined(self.num_shot_taken_to_next_damage_state)) {
        if(isDefined(var2.mountmantlemodel)) {
          if(self.num_shot_taken_to_next_damage_state != var2.mountmantlemodel) {
            if(self istouching(var2.mountmantlemodel)) {
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

        if(self.num_times_stealth_broken_tv_station_interior != var2) {
          if(self istouching(var2)) {
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

      if(self istouching(var2) || isDefined(var2.mountmantlemodel) && self istouching(var2.mountmantlemodel)) {
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

function overridecapturestring(var0) {
  if(isDefined(self.capturestring) && self.capturestring == var0) {
    return;
  }

  self.capturestring = var0;
  var1 = [self];

  if(isDefined(self.useobject)) {
    GscBinSkip0(0x2e, var1.size, self.useobject);
  }

  foreach(var3 in var1) {
    if(!self.supportsreroll || var3.usetype == 2) {
      var3 setHintString(self.capturestring);
    }
  }
}

function overridererollstring(var0) {
  if(isDefined(self.rerollstring) && self.rerollstring == var0) {
    return;
  }

  self.rerollstring = var0;
  var1 = [self];

  if(isDefined(self.useobject)) {
    GscBinSkip0(0x2e, var1.size, self.useobject);
  }

  foreach(var3 in var1) {
    if(self.supportsreroll && var3.usetype == 1) {
      var3 setHintString(self.rerollstring);
    }
  }
}

function overrideheadicon(var0) {
  if(!isDefined(self.headicon) && !isDefined(var0)) {
    return;
  }

  if(isDefined(self.headicon) && isDefined(var0) && self.headicon == var0) {
    return;
  }

  if(!isDefined(var0)) {
    self.headicon = undefined;
    _destroyheadicon();
    return;
  }

  self.headicon = var0;

  if(self.headiconactive) {
    if(isDefined(self.headiconid)) {
      setheadiconfriendlyimage(self.headiconid, var0);
      return;
    }

    _createheadicon();
    return;
  }
}

function overrideminimapicon(var0) {
  if(!isDefined(self.minimapicon) && !isDefined(var0)) {
    return;
  }

  if(isDefined(self.minimapicon) && isDefined(var0) && self.minimapicon == var0) {
    return;
  }

  if(!isDefined(var0)) {
    self.minimapicon = undefined;
    destroyminimapicon();
    return;
  }

  self.minimapicon = var0;

  if(self.minimapiconactive) {
    if(isDefined(self.minimapid)) {
      scripts\mp\objidpoolmanager::update_objective_icon(self.minimapid, var0);
      return;
    }

    createminimapicon();
    return;
  }
}

function overridesupportsreroll(var0) {
  if(self.supportsreroll == var0) {
    return;
  }

  self.supportsreroll = var0;

  if(self.supportsreroll) {
    var1 = [self];

    if(isDefined(self.useobject)) {
      GscBinSkip0(0x2e, var1.size, self.useobject);
    }

    foreach(var3 in var1) {
      if(var3.usetype == 1) {
        var3 setHintString(self.rerollstring);
      }
    }

    return;
  }
}

function initkillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  var0 = &killstreakcrateactivatecallback;
  var1 = &killstreakcratecapturecallback;
  var2 = getleveldata("killstreak");
  var2.activatecallback = var0;
  var2.capturecallback = var1;
  var2 = getleveldata("killstreak_no_owner");
  var2.activatecallback = var0;
  var2.capturecallback = var1;
  var2.supportsownercapture = 0;
  var2.enemymodel = undefined;
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
  var3 = 50;
  thread initkillstreakcratedatalate(var3);
}

function initdropzonekillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  var0 = &killstreakcrateactivatecallback;
  var1 = &killstreakcratecapturecallback;
  var2 = getleveldata("killstreak");
  var2.activatecallback = var0;
  var2.capturecallback = var1;
  var2 = getleveldata("killstreak_no_owner");
  var2.activatecallback = var0;
  var2.capturecallback = var1;
  var2.supportsownercapture = 0;
  var2.enemymodel = undefined;
  var3 = 0;
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
    var3 = 25;
    thread initkillstreakcratedatalate(var3);
    return;
  }
}

function initkillstreakcratedatalate(var0) {
  waittillframeend();
  var1 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\light_tank::light_tank_supported(), var0, 0);
  addkillstreakcratedata("bradley", undefined, undefined, var1);
}

function addkillstreakcratedata(var0, var1, var2, var3) {
  level.cratedata.kscapturestrings[var0] = var1;
  level.cratedata.ksrerollstrings[var0] = var2;
  level.cratedata.ksweights[var0] = var3;
}

function getkillstreakcratedatabystreakname(var0, var1) {
  var2 = spawnStruct();
  var2.streakname = var0;
  var2.supportsreroll = var1;
  return var2;
}

function overridekillstreakcrateweight(var0, var1) {
  level.cratedata.ksweights[var0] = var1;
}

function killstreakcrateactivatecallback(var0) {
  var1 = self.data;
  var2 = level.cratedata.kscapturestrings[var1.streakname];

  if(isDefined(var2)) {
    overridecapturestring(var2);
  }

  var3 = level.cratedata.ksrerollstrings[var1.streakname];

  if(isDefined(var3)) {
    overridererollstring(var3);
  }

  var4 = var1.supportsreroll;

  if(isDefined(var4)) {
    overridesupportsreroll(var4);
    return;
  }
}

function killstreakcratecapturecallback(var0) {
  var1 = self.data.streakname;
  var2 = 0;

  switch (var1) {
    case "bradley":
      if(!scripts\cp_mp\vehicles\light_tank::light_tank_supported()) {
        var1 = "pac_sentry";
      }

      break;
    case "juggernaut":
      if(!istrue(var0.isjuggernaut)) {
        var2 = 1;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "applyImmediateJuggernaut")) {
          var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "applyImmediateJuggernaut")]](var2);
        } else {
          var0 scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(var2);
        }
      }

      break;
  }

  if(!istrue(var2)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "awardKillstreak")) {
      var0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "awardKillstreak")]](var1, self.owner, self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "showKillstreakSplash")) {
      var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "showKillstreakSplash")]](var1, undefined, 1);
    }
  }

  if(isDefined(self.owner) && var0 == self.owner) {
    return;
  }

  if(isDefined(self.team)) {
    if(var0.team != self.team) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
        var0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("hijacker");
      }

      if(isDefined(self.owner)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showSplash")) {
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showSplash")]]("hijacked_airdrop", undefined, var0);
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function getrandomkillstreak(var0) {
  var1 = getrandomkeyfromweightsarray(level.cratedata.ksweights, var0);
  return var1;
}

function placekillstreakcrate(var0, var1, var2, var3, var4) {
  if(!isDefined(var2) || var2 == "random") {
    var2 = getrandomkillstreak();
  }

  var5 = scripts\engine\utility::ter_op(isDefined(var0), "killstreak", "killstreak_no_owner");
  var6 = getkillstreakcratedatabystreakname(var2, 0);
  var7 = placecrate(var0, var1, var5, var3, var4, var6);

  if(!isDefined(var7)) {
    return undefined;
  }

  if(isDefined(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var0);
    }
  }

  return var7;
}

function dropkillstreakcrate(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var2) || var2 == "random") {
    var2 = getrandomkillstreak();
  }

  var6 = scripts\engine\utility::ter_op(isDefined(var0), "killstreak", "killstreak_no_owner");
  var7 = getkillstreakcratedatabystreakname(var2, 0);
  var8 = dropcrate(var0, var1, var6, var3, var4, var5, var7);

  if(!isDefined(var8)) {
    return undefined;
  }

  if(isDefined(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var0);
    }
  }

  return var8;
}

function dropkillstreakcratefromscriptedheli(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isDefined(var2) || var2 == "random") {
    var2 = getrandomkillstreak();
  }

  var8 = scripts\engine\utility::ter_op(isDefined(var0), "killstreak", "killstreak_no_owner");
  var9 = getkillstreakcratedatabystreakname(var2, 0);
  var9.vehicleisreserved = var6;
  var10 = dropcratefromscriptedheli(var0, var1, var8, var3, var4, var5, var9, var7);

  if(!isDefined(var10)) {
    return undefined;
  } else if(!isDefined(var10.crates) || !isDefined(scripts\engine\utility::array_get_first_item(var10.crates))) {
    return undefined;
  }

  if(isDefined(var0)) {
    thread br_c130spawndone(var0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var0);
    }
  }

  return var10;
}

function br_c130spawndone(var0, var1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(level.gametype == "grnd" || level.gametype == "infect") {
    return;
  }

  var2 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.75);
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var0.streakname);
    var2 = 1.5;
  }

  var3 = var0.streakname;

  if(isDefined(var1)) {
    var3 = var1;
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var3, 1, var2);
}

function dropkillstreakcratefrommanualheli(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var2) || var2 == "random") {
    var2 = getrandomkillstreak();
  }

  var7 = scripts\engine\utility::ter_op(isDefined(var0), "killstreak", "killstreak_no_owner");
  var8 = getkillstreakcratedatabystreakname(var2, 0);
  var8.vehicleisreserved = var6;
  var9 = dropcratefrommanualheli(var0, var1, var7, var3, var4, 30000, 30000, var5, var8);

  if(!isDefined(var9)) {
    return undefined;
  } else if(!isDefined(var9.crate)) {
    return undefined;
  }

  if(isDefined(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", var0);
    }
  }

  return var9.crate;
}

function tryairdroptriggered(var0) {
  var1 = var0.streakname;
  var2 = var1;
  var3 = undefined;

  if(!isDefined(var2)) {
    var2 = "airdrop";
  }

  var4 = 4;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var4 = 10;
  }

  var5 = 1;

  if((level.littlebirds.size >= var4 || level.fauxvehiclecount >= var4) && var2 != "airdrop_mega") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_AIRDROPS");
    }

    return false;
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + var5 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
      }

      return false;
    }
  }

  var6 = getdvarint("scr_airDrop_sticky", 0);

  if(var2 == "airdrop" && var6) {
    var0.deployweaponobj = getcompleteweaponname("deploy_airdrop_mp_sticky");
  }

  return true;
}

function airdropmarkerswitchended(var0, var1) {
  if(istrue(var1)) {
    thread airdrop_watchplayerweapon(var0);
    return;
  }
}

function airdrop_watchplayerweapon(var0) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var1 = scripts\engine\utility::ref_143ad("cancel_deploy", "weapon_switch_started");

  if(!isDefined(var1)) {
    return;
  }

  var0 notify("killstreak_finished_with_deploy_weapon");
}

function airdropvisualmarkerfired(var0) {
  var0.airdroptype = var0.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  var1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "getTargetMarker")) {
    var1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "getTargetMarker")]](var0);
  }

  if(!isDefined(var1.location)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return false;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var0.airdroptype, self.origin);
  }

  airdropvisualmarkeractivate(var1, var0.airdroptype, var0);
  return true;
}

function airdropvisualmarkeractivate(var0, var1, var2) {
  var3 = scripts\engine\utility::drop_to_ground(var0.location, 50, -200, (0, 0, 1));
  var3 += (0, 0, 1);
  var4 = spawn("script_model", var3);
  var4 setModel("offhand_wm_grenade_smoke");
  var4.angles = (0, 90, 90);
  var5 = spawn("script_model", var3);
  var5 setModel("ks_crate_marker_mp");
  var5 setscriptablepartstate("smoke", "on", 0);

  if(isDefined(var0.visual)) {
    var0.visual delete();
  }
}

function tryuseairdropmarker() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("airdrop", self);
  return tryuseairdropmarkerfromstruct(var0);
}

function tryuseairdropmarkerfromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");
  var0.deployweaponobj = getcompleteweaponname("deploy_airdrop_mp");
  var1 = undefined;

  switch (var0.streakname) {
    case "airdrop":
      var1 = 1;
      break;
    default:
      var1 = 0;
      break;
  }

  if(var1) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      return false;
    }
  }

  if(!tryairdroptriggered(var0)) {
    if(var1) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      if(var1) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      return false;
    }
  }

  var2 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(var0, var0.deployweaponobj, "grenade_fire", undefined, &airdropmarkerswitchended, &airdropmarkerfired, undefined, &airdropmarkertaken);

  if(!istrue(var2)) {
    if(var1) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return false;
    }
  }

  return true;
}

function airdropmarkerfired(var0, var1, var2) {
  var0.airdroptype = var0.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "incrementFauxVehicleCount")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "incrementFauxVehicleCount")]]();
  }

  var2.owner = self;
  thread airdropmarkeractivate(var2, var0.airdroptype, undefined);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var0.airdroptype, self.origin);
  }

  var0.airdropmarkerfired = 1;
  var0 notify("killstreak_finished_with_deploy_weapon");
  return "success";
}

function airdropmarkeractivate(var0, var1, var2) {
  level endon("game_ended");
  var3 = self.owner.angles;
  self waittill("explode", var4);
  var5 = self.owner;

  if(!isDefined(var5)) {
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

  var7 = undefined;

  if(var0 == "airdrop") {
    var7 = dropkillstreakcratefromscriptedheli(var5, var5.team, undefined, var4, var3 + (0, 180, 0), var4, 1, var2);
  } else if(var0 == "airdrop_multiple") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "airdropMultipleDropCrates")) {
      var7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "airdropMultipleDropCrates")]](var5, var5.team, var4, var3 + (0, 180, 0), var4, var2);
    }
  }

  if(!isDefined(var7)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      var5[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
      var5[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](var2.mpstreaksysteminfo, "other");
    }

    return;
  }

  var5 scripts\cp_mp\utility\killstreak_utility::ref_12aa7(var2);
}

function airdropmarkertaken(var0) {
  if(istrue(var0.airdropmarkerfired)) {
    if(isDefined(level.killstreakfinishusefunc)) {
      level thread[[level.killstreakfinishusefunc]](var0);
    }
  }

  if(isDefined(var0.airdroptype) && !istrue(var0.airdropmarkerfired)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
      return;
    }

    return;
  }
}

function initbattleroyalecratedata() {
  var0 = getleveldata("battle_royale");
  var0.capturestring = &"MP/BR_CRATE";
  var0.enemymodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = undefined;
  var0.activatecallback = &brcrateactivatecallback;
  var0.capturecallback = &brcratecapturecallback;
}

function getbrcratedatabytype(var0) {
  var1 = spawnStruct();
  var1.type = var0;
  return var1;
}

function brcrateactivatecallback(var0) {
  if(istrue(var0)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
      return;
    }

    return;
  }
}

function brcratecapturecallback(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "makeItemsFromCrate")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "makeItemsFromCrate")]](var0);
    return;
  }
}

function dropbrcratefromscriptedheli(var0) {
  var1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", "attachment");
  var2 = dropcratefromscriptedheli(undefined, undefined, "battle_royale", var0, (0, randomfloat(360), 0), var0, getbrcratedatabytype(var1));

  if(!isDefined(var2)) {
    return undefined;
  } else if(!isDefined(var2.crates) || !isDefined(scripts\engine\utility::array_get_first_item(var2.crates))) {
    return undefined;
  }

  return var2.crate;
}

function dropbrcratefrommanualheli(var0) {
  var1 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", "attachment");
  var2 = dropcratefrommanualheli(undefined, undefined, "battle_royale", var0, (0, randomfloat(360), 0), 30000, 30000, var0, getbrcratedatabytype(var1));

  if(!isDefined(var2)) {
    return undefined;
  } else if(!isDefined(var2.crate)) {
    return undefined;
  }

  return var2.crate;
}

function teamplacement() {
  var0 = getleveldata("battle_royale_kiosk_drop");
  var0.dummymodel = relic_landlocked_do_explosion("kiosk_drop");
  var0.friendlymodel = undefined;
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = undefined;
  var0.friendlyuseonly = 0;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 0.5;
  var0.destroyoncapture = 0;
}

function missionbasetimer(var0, var1, var2) {
  return dropcrate(undefined, var0, "battle_royale_kiosk_drop", var1, (0, randomfloat(360), 0), var2);
}

function initbattleroyaleloadoutcratedata() {
  var0 = getleveldata("battle_royale_loadout");
  var0.capturestring = &"MP/BR_CRATE_LOADOUT";
  var0.dummymodel = relic_landlocked_do_explosion();
  var0.friendlymodel = undefined;
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = undefined;
  var0.friendlyuseonly = 1;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 0.5;
  var0.activatecallback = &brloadoutcrateactivatecallback;
  var0.capturecallback = &brloadoutcratecapturecallback;
  var0.destroycallback = &dropradius;
  var0.destroyoncapture = 0;
  var0.onecaptureperplayer = 1;
}

function brloadoutcrateactivatecallback(var0) {
  if(istrue(var0)) {
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

function brloadoutcratecapturecallback(var0) {
  giveweaponsfromdropbag(var0);
}

function dropspecialistbonus(var0) {
  if(!isDefined(self.numuses)) {
    self.numuses = 0;
  }

  if(!isDefined(self.playersused)) {
    self.playersused = [];
  }

  if(!isDefined(self.playerscaptured)) {
    self.playerscaptured = [];
  }

  self.playerscaptured[var0 getentitynumber()] = var0;
  self.playersused[self.playersused.size] = var0;
  self.numuses++;

  if(isDefined(self.playeroutlines)) {
    foreach(var2 in self.playeroutlines) {
      if(isDefined(self.outlines) && isDefined(self.outlines[var2]) && isDefined(self.outlines[var2].playersvisibleto)) {
        if(self.outlines[var2].playersvisibleto.size == 1 && self.outlines[var2].playersvisibleto[0] == var0) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable")) {
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](var2, self);
          }

          self.playeroutlines = scripts\engine\utility::array_remove(self.playeroutlines, var2);
          break;
        }
      }
    }
  }

  if(self.numuses >= level.teamdata[var0.team]["teamCount"]) {
    if(isDefined(self.playeroutlines)) {
      foreach(var5 in self.playeroutlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable")) {
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](var5, self);
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

function dropradius(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "brOnLoadoutCrateDestroyed")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "brOnLoadoutCrateDestroyed")]](var0);
    return;
  }
}

function giveweaponsfromdropbag(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "br_giveDropBagLoadout")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "br_giveDropBagLoadout")]](var0);
    return;
  }
}

function dropbrloadoutcrate(var0, var1, var2) {
  return dropcrate(undefined, var0, "battle_royale_loadout", var1, (0, randomfloat(360), 0), var2);
}

function teammateoutlineids() {
  var0 = getleveldata("battle_royale_c130_loot");

  if(getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "gold_war") {
    var0.capturestring = &"MP/DMZ_LOOT_CRATE_CAPTURE";
  } else {
    var0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  }

  var0.dummymodel = relic_landlocked_do_explosion();
  var0.friendlymodel = undefined;
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = 600;
  var0.friendlyuseonly = 1;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 0.5;
  var0.activatecallback = &dialog_wait_think;
  var0.capturecallback = &dialog_wait_think_civ;
  var0.destroycallback = &dialogqueue;
  var0.ingame = &dialogueindex;
  var0.destroyoncapture = 1;
}

function dialog_wait_think(var0) {}

function dialog_wait_think_civ(var0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_c130Airdrop", "c130Airdrop_onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse")]](var0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_c130Airdrop", "dmzTut_crateUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_c130Airdrop", "dmzTut_crateUsed")]](var0);
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

function dialogqueue(var0) {
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

function minshotstostage3acc(var0, var1, var2, var3, var4, var5, var6) {
  var7 = 250;
  var8 = level.fnhidefoundintel;
  var9 = 1000;
  var10 = 10500;
  var11 = 7500;
  var12 = 3000;
  var13 = var1 + (0, 0, var9);
  var14 = "battle_royale_c130_loot";

  if(isDefined(var3)) {
    var14 = var3;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  var15 = createcrate(undefined, undefined, var14, var0, (0, 0, 0), var1, undefined, 0);

  if(isDefined(var15)) {
    var15.skipminimapicon = 1;

    if(!var5 && var13[2] < var0[2]) {
      var16 = undefined;
      var17 = distance(var0, var13);

      if(var17 >= var10) {
        var16 = "brc130_drop_high";
      } else if(var17 >= var11) {
        var16 = "brc130_drop_med";
      } else if(var17 >= var12) {
        var16 = "brc130_drop_low";
      }

      if(isDefined(var16)) {
        var18 = 1000;
        var19 = spawn("script_model", var13 + (0, 0, var18));
        var19.angles = var2;
        var19 setModel("tag_origin");
        var15.animname = "care_package";
        var15.dropanim = level.scr_anim[var15.animname][var16];
        var15.animlength = getanimlength(var15.dropanim);
        var15 scripts\common\anim::setanimtree();
        var20 = spawn("script_model", var15.origin);
        var20.angles = var15.angles;
        var20.animname = "care_package_chute";
        var20.dropanim = level.scr_anim[var20.animname][var16];
        var20.animlength = getanimlength(var20.dropanim);
        var20 setModel("veh8_mil_lnd_carepackage_parachute_br");
        var20 scripts\common\anim::setanimtree();
        var19 thread scripts\common\anim::anim_single_solo(var15, var16);
        var19 thread scripts\common\anim::anim_single_solo(var20, var16);
        thread ref_14492();
        thread ref_14493(var20);
      } else {
        infinite_chopper(var15);
      }
    } else {
      infinite_chopper(var15);
    }

    var21 = "cashdrop_common";
    var22 = getdvarint("scr_dmz_airdrop_ingame_obj", 1);

    if(var22) {
      var21 = "cashdrop_common_world";
    }

    if(isDefined(var4)) {
      var21 = var4;
    }

    var15 setscriptablepartstate("objective_map", var21, 0);
    var15 setscriptablepartstate("crate_audio", "parachuting", 0);
    var15.ref_13428 = spawn("script_model", var1);
    var15.ref_13428 setModel("ks_airdrop_crate_br");

    if(!istrue(var6)) {
      var15.ref_13428 setscriptablepartstate("smoke_signal", "on", 0);
    }

    var23 = getleveldata(var14);

    if(isDefined(var23.ref_127fd)) {
      var15 thread[[var23.ref_127fd]]();
    }
  }

  return var15;
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

function ref_14493(var0) {
  self endon("death");
  wait self.animlength;

  if(isDefined(self)) {
    self delete();
  }

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function teamplunderexfil() {
  var0 = getleveldata("battle_royale_chopper_loot");
  var0.capturestring = &"MP/DMZ_PLUNDER_CRATE_CAPTURE";
  var0.dummymodel = relic_landlocked_do_explosion();
  var0.friendlymodel = undefined;
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = 600;
  var0.friendlyuseonly = 1;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 0.5;
  var0.activatecallback = &dummy_model;
  var0.capturecallback = &dvarlocations;
  var0.destroycallback = &dwell_aggro;
  var0.destroyoncapture = 1;
}

function dummy_model(var0) {}

function dvarlocations(var0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_lootchopper", "lootChopper_onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_lootchopper", "lootChopper_onCrateUse")]](var0);
  }

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
    return;
  }
}

function dwell_aggro(var0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
    return;
  }
}

function missionbonustimer(var0, var1) {
  var2 = dropcrate(undefined, undefined, "battle_royale_chopper_loot", var0, (0, randomfloat(360), 0), var1);

  if(isDefined(var2)) {
    var2.skipminimapicon = 1;
    var3 = "cashdrop_common";
    var4 = getdvarint("scr_dmz_airdrop_ingame_obj", 1);

    if(var4) {
      var3 = "cashdrop_common_world";
    }

    var2 setscriptablepartstate("objective_map", var3, 0);
    var2.ref_13428 = spawn("script_model", var1);
    var2.ref_13428 setModel("ks_airdrop_crate_br");
    var2.ref_13428 setscriptablepartstate("smoke_signal", "on", 0);
  }

  return var2;
}

function missionid(var0, var1) {
  var2 = dropcrate(undefined, undefined, "battle_royale_chopper_loot", var0, (0, randomfloat(360), 0), var1);

  if(isDefined(var2)) {
    var2.skipminimapicon = 1;
    var2 setscriptablepartstate("objective_map", "pe_chopper_crate", 0);
    var2.ref_13428 = spawn("script_model", var1);
    var2.ref_13428 setModel("ks_airdrop_crate_br");
    var2.ref_13428 setscriptablepartstate("smoke_signal", "pe_chopper_on", 0);
  }

  return var2;
}

function initplundercratedata() {
  var0 = getleveldata("esc_cache");
  var0.capturestring = &"MP/ESC_CACHE_USE_HINT";
  var0.usetag = "tag_origin";
  var0.userange = 200;
  var0.usefov = 160;
  var0.usepriority = 0;
  var0.friendlymodel = "military_crate_large_stackable_01";
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -10000;
  var0.headicon = undefined;
  var0.minimapicon = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "captureLootCacheCallback")) {
    var0.capturecallback = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "captureLootCacheCallback")]]();
  }

  var0.destroyoncapture = 0;
  var0.onecaptureperplayer = 1;
  var0.capturevisualscallback = undefined;
  var0.destroyvisualscallback = undefined;
  var0.timeout = undefined;
}

function getplcratedata(var0) {
  var1 = spawnStruct();
  var1.contents = var0;
  return var1;
}

function placeplcrate(var0, var1, var2) {
  var3 = placecrate(undefined, undefined, "esc_cache", var1, var2, getplcratedata(var0));
  return var3;
}

function initarmcratedata() {
  level.cratedata.armweights = [];
  level.cratedata.armcapturestrings = [];
  var0 = getleveldata("arm_no_owner");
  var0.activatecallback = &armcrateactivatecallback;
  var0.capturecallback = &armcratecapturecallback;
  var0.supportsownercapture = 0;
  var0.enemymodel = undefined;
  var0.headicondrawrange = 5000;
  var0.timeout = 180;
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
  var0 = scripts\engine\utility::ter_op(scripts\cp_mp\vehicles\light_tank::light_tank_supported(), 50, 0);
  addarmcratedata("bradley", undefined, 4, var0);
}

function addarmcratedata(var0, var1, var2, var3) {
  level.cratedata.armdefconlevels[var0] = var2;
  level.cratedata.armweights[var0] = var3;
  level.cratedata.armcapturestrings[var0] = var1;
}

function getarmcratedatabystreakname(var0) {
  var1 = spawnStruct();
  var1.streakname = var0;
  return var1;
}

function armcrateactivatecallback(var0) {
  var1 = self.data;
  var2 = level.cratedata.armcapturestrings[var1.streakname];

  if(isDefined(var2)) {
    overridecapturestring(var2);
    return;
  }
}

function armcratecapturecallback(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "giveKillstreak")) {
    var0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "giveKillstreak")]](self.data.streakname, 0, 0, self.owner);
    return;
  }
}

function getrandomarmkillstreak(var0) {
  var1 = getarmkillsteakstoexcludebyteamdefconlevel(var0);
  var2 = getrandomkeyfromweightsarray(level.cratedata.armweights, var1);
  return var2;
}

function getarmkillsteakstoexcludebyteamdefconlevel(var0) {
  var1 = level.defconlevel;
  var2 = undefined;

  if(var1 > 1) {
    var2 = [];

    foreach(var4 in level.cratedata.armdefconlevels) {
      if(var1 > var4) {
        var2 = var5;
      }
    }
  }

  return var2;
}

function droparmcratefromscriptedheli(var0, var1, var2, var3, var4) {
  if(!isDefined(var1) || var1 == "random") {
    var1 = getrandomarmkillstreak(var0);
  }

  var5 = getarmcratedatabystreakname(var1);
  var6 = dropcratefromscriptedheli(undefined, var0, "arm_no_owner", var2, var3, var4, var5);

  if(!isDefined(var6)) {
    return undefined;
  } else if(!isDefined(var6.crates) || !isDefined(scripts\engine\utility::array_get_first_item(var6.crates))) {
    return undefined;
  }

  foreach(var8 in var6.crates) {
    return var8;
  }

  var8 = undefined;
}

function teammatereviveweaponwaitputaway() {
  var0 = getleveldata("battle_royale_juggernaut");
  var0.capturestring = &"KILLSTREAKS_HINTS/JUGG_CRATE_PICKUP";
  var0.dummymodel = relic_landlocked_do_explosion("battle_royale_juggernaut");
  var0.friendlymodel = undefined;
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = undefined;
  var0.friendlyuseonly = 1;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 0.5;
  var0.capturecallback = &display_dont_have_weapon_message;
  var0.destroycallback = &display_fx_names_after_plane_spawns;
  var0.activatecallback = &display_cypher_updated;
  var0.ingame = &display_headicon_to_players;
  var0.ref_127fd = &display_hint_for_all;
  var0.destroyoncapture = 1;
}

function display_cypher_updated(var0) {
  scripts\cp_mp\killstreaks\juggernaut::oncrateactivated(var0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_juggernaut", "onCrateActivate")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_juggernaut", "onCrateActivate")]](var0);
    return;
  }
}

function display_dont_have_weapon_message(var0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_juggernaut", "onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_juggernaut", "onCrateUse")]](var0);
  }

  scripts\cp_mp\killstreaks\juggernaut::oncratecaptured(var0);
}

function display_fx_names_after_plane_spawns(var0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_juggernaut", "onCrateDestroy")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_juggernaut", "onCrateDestroy")]](var0);
    return;
  }
}

function display_headicon_to_players(var0, var1) {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

function display_hint_for_all() {
  self setscriptablepartstate("model", "friendly", 0);
}

function modeallowmeleevehicledamage(var0, var1, var2) {
  var3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", self);
  return dropcrate(undefined, var0, "battle_royale_juggernaut", var1, (0, randomfloat(360), 0), var2, var3, 1);
}

function ref_13669(var0, var1) {
  var2 = 4096;

  if(istrue(self.umbra)) {
    var2 = 10000;
  }

  var3 = modeallowmeleevehicledamage(self.team, var0 + (0, 0, var2), var0 + (0, 0, 512));
  var3 endon("death");
  move_payload_to_back_of_super(var3);
  give_deployable_crate(var3);
  var4 = [];

  foreach(var6 in level.teamdata[self.team]["alivePlayers"]) {}
}

function move_payload_to_back_of_super(var0) {
  var0 setotherent(self);
  var0 setscriptablepartstate("objective_map", "jugg_world");
}

function give_deployable_crate(var0) {
  var0 setotherent(self);
  var0 setscriptablepartstate("model", "friendly");
}

function vehicle_isfriendlytoplayer(var0) {
  var1 = 1;

  switch (var0) {
    case "battle_royale_juggernaut":
      var1 = 0;
      break;
    case "battle_royale_loadout":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        var2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(!istrue(var2)) {
          var1 = 0;
        }
      }

      break;
  }

  return var1;
}

function teamplunderexfilshowviponly() {
  var0 = getleveldata("battle_royale_tactical_device");
  var0.capturestring = &"BR_REVEAL_2/R2_TACTICAL_DEVICE";
  var0.dummymodel = "military_carepackage_01_br_device";
  var0.friendlymodel = undefined;
  var0.enemymodel = undefined;
  var0.mountmantlemodel = undefined;
  var0.supportsownercapture = 0;
  var0.headicon = undefined;
  var0.usepriority = -1;
  var0.usefov = 180;
  var0.timeout = undefined;
  var0.friendlyuseonly = 1;
  var0.ownerusetime = 0.5;
  var0.otherusetime = 0.5;
  var0.capturecallback = &endoperatorsfxondisconnect;
  var0.activatecallback = &endofmatchdatasent;
  var0.destroycallback = &endprematchskydiving;
  var0.ingame = &endptui;
  var0.destroyoncapture = 1;
}

function endoperatorsfxondisconnect(var0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_tactical_device", "onCrateUse")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_tactical_device", "onCrateUse")]](var0);
    return;
  }
}

function modifydestructibledamage(var0) {
  var1 = 4096;
  var2 = var0 + (0, 0, var1);
  var3 = var0 + (0, 0, 512);
  level.ref_12ce8.plundereventtime = spawnfx(level._effect["smoke_tactical_device"], level.ref_12ce8.level_carepackage_give_player_killstreak_incendiary_launcher - (0, 0, 60));
  triggerfx(level.ref_12ce8.plundereventtime);
  var4 = dropcrate(undefined, undefined, "battle_royale_tactical_device", var2, (0, randomfloat(360), 0), var3);
  var4.skipminimapicon = 1;
  endround_timescalefactor(var4);
}

function endofmatchdatasent(var0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_tactical_device", "onCrateActivate")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_tactical_device", "onCrateActivate")]](var0);
    return;
  }
}

function endprematchskydiving(var0) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.ref_13428)) {
    self.ref_13428 setscriptablepartstate("smoke_signal", "off", 0);
    self.ref_13428 delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_tactical_device", "onCrateDestroy")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_tactical_device", "onCrateDestroy")]](var0);
    return;
  }
}

function endptui(var0, var1) {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

function endround_timescalefactor(var0) {
  var0 setscriptablepartstate("objective_map", "tactical_device_world");
  var0 setscriptablepartstate("smoke_trail", "on");
  var0 setscriptablepartstate("jugg_drop_beacon", "on");
}

function relic_landlocked_do_explosion(var0) {
  var1 = level.script == "mp_don4" && getdvarint("scr_br_x2_hype", 0);
  var2 = "";

  if(var1) {
    var2 = "x2_military_carepackage_01_br";
  } else if(isDefined(var0) && var0 == "battle_royale_juggernaut" && istrue(level.ref_12184)) {
    var2 = "military_carepackage_01_br_jugg";
  } else if(isDefined(var0) && var0 == "kiosk_drop") {
    var2 = "lm_buy_station_crate_wood_01_ww2";
  } else {
    var2 = "military_carepackage_02_br";
  }

  return var2;
}