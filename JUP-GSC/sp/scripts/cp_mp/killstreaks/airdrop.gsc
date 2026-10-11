/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp_mp\killstreaks\airdrop.gsc
****************************************************/

#using scripts\common\ae_utility;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\damage_tuning;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\juggernaut_recon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#namespace airdrop;

function init() {
  if(issharedfuncdefined("airdrop", "init")) {
    [[getsharedfunc("airdrop", "init")]]();
  }

  level._effect["airdrop_crate_impact_ground"] = loadfx("vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_dust.vfx");
  level._effect["airdrop_crate_impact_water"] = loadfx("vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_water.vfx");
  level.carepackagedropnodes = getEntArray("carepackage_drop_area", "targetname");
  initkillstreak();
  initheli();
  initcratedata();
  function_93512c08385359e1();
  init_airdrop_vo();
  utility::function_7ae9075c73180af7(#"perk");

  if(issharedfuncdefined("airdrop", "airdropMultipleInit")) {
    [[getsharedfunc("airdrop", "airdropMultipleInit")]]();
  }

  if(issharedfuncdefined("airdrop", "airdropEscortInit")) {
    [[getsharedfunc("airdrop", "airdropEscortInit")]]();
  }
}

function initkillstreak() {
  setdevdvarifuninitialized(@ "hash_c247993ede3808ca", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_22186e8d4f1020da", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_23ed746952207d2b", 1200);
  setdevdvarifuninitialized(@ "hash_87413e0e6fc00a5f", 600);
  setdevdvarifuninitialized(@ "hash_b2e9bf0017ceeeae", 0);
  setdevdvarifuninitialized(@ "hash_7acaaf8f4063ab02", 0);
  setdevdvarifuninitialized(@ "hash_a62fccdf77b23d67", 0);
  setdevdvarifuninitialized(@ "hash_d15c22f57683add1", 1);
  setdevdvarifuninitialized(@ "hash_d1c5f84bb717c57", 0);
  setdevdvarifuninitialized(@ "hash_2f52ab5e0e1eac8b", 1);
}

function initheli() {
  level.littlebirds = [];

  if(issharedfuncdefined("airdrop", "registerScoreInfo")) {
    [[getsharedfunc("airdrop", "registerScoreInfo")]]();
  }
}

function initcratedata() {
  leveldata = spawnStruct();
  leveldata.configs = [];
  leveldata.crates = [];
  leveldata.usablecrates = [];
  level.cratedata = leveldata;
  level.cratedata.unresolvedcollisiontolerancesqr = pow(getdvarfloat(@ "hash_a0cbf9e8d23fb12c", 2), 2);

  var_8f3ab761a14ddcdb = getEntArray("<dev string:x1d>", "<dev string:x2e>");
  assertex(isDefined(var_8f3ab761a14ddcdb), "<dev string:x39>");
  assertex(isDefined(var_8f3ab761a14ddcdb) && var_8f3ab761a14ddcdb.size <= 1, "<dev string:x67>");

  level.cratedata.mountmantlemodel = getEnt("care_package_col", "targetname");

  if(issharedfuncdefined("airdrop", "registerActionSet")) {
    [[getsharedfunc("airdrop", "registerActionSet")]]();
  }

  gametype = "mp";

  if(issharedfuncdefined("game", "getGameType")) {
    gametype = [[getsharedfunc("game", "getGameType")]]();
  }

  switch (gametype) {
    case #"hash_1a53256c17b7d2ee":
    case #"hash_7fb7ea2cb6529446":
    case #"hash_b7ddfbe1d0e2457a":
    case #"hash_c4f97a56da3b7cde":
    case #"hash_c636c850b4f608fd":
    case #"hash_dcb9324af7bb9f35":
      if(issharedfuncdefined("airdrop", "getGameModeSpecificCrateData")) {
        [[getsharedfunc("airdrop", "getGameModeSpecificCrateData")]]();
      }
    case #"hash_bfabc434c59611fa":
    case #"hash_fa21c4f6bd5e3815":
      initbattleroyalecratedata();
      initbattleroyaleloadoutcratedata();
      initbattleroyalec130airdropcratedata();
      initbattleroyalelootchoppercratedata();
      initbattleroyalejuggernautcratedata();
      function_19dc247eaaf9da8f();
      function_ddd270c88107faf9();
      function_56e93fd2282a71ce();
      break;
    case #"hash_ca6516c10db2c95":
    case #"hash_7f9c384a34cc392f":
      initarmcratedata();
      initkillstreakcratedata();
      initbattleroyalecratedata();
      function_c5c61b985836f974();
    case #"hash_b9458959b10637f8":
    case #"hash_dd5b900f435d3f36":
      initdropzonekillstreakcratedata();
      function_c5c61b985836f974();
      break;
    case #"hash_c065cef60f38490a":
      function_a3299432ddb721e3();
      initkillstreakcratedata();
      function_c5c61b985836f974();
      break;
    default:
      initkillstreakcratedata();
      function_c5c61b985836f974();
      break;
  }

  if(issharedfuncdefined("airdrop", "getMapSpecificCrateData")) {
    [[getsharedfunc("airdrop", "getMapSpecificCrateData")]]();
  }

  initcratedropdata();

  if(issharedfuncdefined("game", "registerPlayerFrameUpdateCallback")) {
    [[getsharedfunc("game", "registerPlayerFrameUpdateCallback")]](&trackcratemantlingexploit);
  }

  thread watchallcrateusability();
}

function function_93512c08385359e1() {
  level.var_27f78817b59dfe32 = "airdrop_placement";
  val::group_register(level.var_27f78817b59dfe32, ["offhand_weapons", "melee", "execution_attack", "weapon_pickup", "cp_munitions_pickup"]);
}

function init_airdrop_vo() {
  game["dialog"]["airdrop_use"] = "killstreak_remote_operator" + "_request_response";
}

function getleveldata(cratetype) {
  assertex(isDefined(level.cratedata), "getLevelData() called before initCrateData().");
  leveldata = level.cratedata.configs[cratetype];

  if(!isDefined(leveldata)) {
    leveldata = getemptyleveldata();
    level.cratedata.configs[cratetype] = leveldata;
  }

  return leveldata;
}

function getemptyleveldata() {
  leveldata = spawnStruct();
  leveldata.basemodel = "military_carepackage_03_mp";
  leveldata.halfheight = 27.5;
  leveldata.mountmantlemodel = getdefaultmountmantlemodel();
  leveldata.objweapon = nullweapon();
  leveldata.timeout = 90;
  leveldata.headiconoffset = 0;
  leveldata.headicondrawrange = 10000;
  leveldata.headiconnaturalrange = 400;
  leveldata.minimapicon = "hud_icon_minimap_killstreak_carepackage";
  leveldata.usetag = "tag_use";

  if(iscp()) {
    leveldata.usetag = "j_military_loot_crate_ui_01_lid";
  }

  leveldata.userange = 128;
  leveldata.breakuserangesqr = 30625;
  leveldata.usefov = 360;
  leveldata.usepriority = 0;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 3;
  leveldata.friendlyuseonly = 0;
  leveldata.navobstaclebounds = (30, 10, 64);
  leveldata.navobstacleupdatedistsqr = 64;
  leveldata.dangerzoneheight = 1000;
  leveldata.dangerzoneradius = 128;
  leveldata.activatecallback = undefined;
  leveldata.deactivatecallback = undefined;
  leveldata.capturecallback = undefined;
  leveldata.rerollcallback = undefined;
  leveldata.destroycallback = undefined;
  leveldata.destroyoncapture = 1;
  leveldata.onecaptureperplayer = 0;
  leveldata.hasnointeraction = 0;
  leveldata.destroyvisualscallback = getdefaultdestroyvisualscallback();
  leveldata.destroyvisualsdeletiondelay = getdefaultdestroyvisualsdeletiondelay();
  leveldata.capturevisualscallback = getdefaultcapturevisualscallback();
  leveldata.capturevisualsdeletiondelay = getdefaultcapturevisualsdeletiondelay();
  leveldata.capturestring = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  leveldata.rerollstring = &"KILLSTREAKS_HINTS/UAV_REROLL";
  leveldata.headicon = "hud_icon_minimap_killstreak_carepackage";
  leveldata.supportsreroll = 0;
  leveldata.supportsownercapture = 1;
  leveldata.supportsothercapture = 1;
  return leveldata;
}

function hasleveldata(cratetype) {
  return isDefined(level.cratedata.configs[cratetype]);
}

function createcrate(owner, team, cratetype, position, angles, destination, hasnophysics, var_6244a1d5b282bb6c, data, skipminimapicon, markerposition) {
  assertex(hasleveldata(cratetype), "createCrate() called with an invalid crateType.");
  leveldata = getleveldata(cratetype);

  if(leveldata.supportsownercapture) {
    assertex(isDefined(owner), "createCrate() specifies ownerCapture but has no owner.");
  }

  if(leveldata.supportsreroll) {
    assertex(isDefined(owner), "createCrate() specifies supportsReroll but has no owner (only owners can reroll).");
  }

  crate = spawn("script_model", position);
  crate.angles = angles;

  if(!istrue(var_6244a1d5b282bb6c) && cratetype != "battle_royale_c130_loot" || cratetype != "battle_royale_loadout" && cratetype != "battle_royale_cash_crate") {
    if(issharedfuncdefined("entity", "touchingBadTrigger")) {
      if(crate[[getsharedfunc("entity", "touchingBadTrigger")]]()) {
        crate delete();
        return undefined;
      }
    }
  }

  crate.owner = owner;
  crate.team = team;
  crate.objweapon = leveldata.objweapon;
  crate.cratetype = cratetype;
  crate.useobject = undefined;
  crate.navobstacle = undefined;
  crate.headiconid = undefined;
  crate.minimapid = undefined;
  crate.dangerzoneid = undefined;
  crate.navobstacleid = undefined;
  crate.destination = destination;
  crate.markerposition = markerposition;
  crate.headiconactive = 0;
  crate.minimapiconactive = 0;
  crate.hasnophysics = istrue(hasnophysics);
  crate.physicsactivated = 0;
  crate.isdestroyed = 0;
  crate.data = data;
  crate.skipminimapicon = skipminimapicon;
  crate.inwater = 0;
  crate.isdropcrate = leveldata.isdropcrate;
  crate.headicon = leveldata.headicon;
  crate.minimapicon = leveldata.minimapicon;
  crate.capturestring = leveldata.capturestring;
  crate.rerollstring = leveldata.rerollstring;
  crate.supportsreroll = leveldata.supportsreroll;
  crate.isteamonlycrate = leveldata.isteamonlycrate;
  crate.var_c23ca3472233553d = leveldata.var_c23ca3472233553d;
  crate.basemodel = leveldata.basemodel;

  if(isDefined(data) && isDefined(data.var_4191ace1612a5376)) {
    crate.basemodel = data.var_4191ace1612a5376;
  }

  crate setModel(crate.basemodel);
  crate setnodeploy(1);
  crate setCanDamage(0);
  crate makeunusable();

  if(issharedfuncdefined("airdrop", "attachXRays")) {
    crate = [[getsharedfunc("airdrop", "attachXRays")]](crate);
  }

  crate enableplayermarks("killstreak");

  if(level.teambased) {
    crate filteroutplayermarks(crate.team);
  } else {
    crate filteroutplayermarks(crate.owner);
  }

  killcament = undefined;

  if(!crate.hasnophysics) {
    if(issharedfuncdefined("game", "isBRStyleGameType")) {
      if(![[getsharedfunc("game", "isBRStyleGameType")]]()) {
        killcament = spawn("script_model", position + (0, 0, 300));
        killcament setscriptmoverkillcam("explosive");
        killcament linkTo(crate);
      }
    }
  }

  if(isDefined(crate.owner)) {
    crate.owner.isffprotectedaction = 1;
  }

  crate.killcament = killcament;

  if(isDefined(crate.killcament)) {
    crate.killcament.linked = 1;
  }

  crate.unresolved_collision_notify_min = 1;
  var_79da6880ecea3790 = crate createmountmantlemodel();

  if(!var_79da6880ecea3790) {
    crate.unresolved_collision_func = &crateunresolvedcollisioncallback;
  }

  crate addtolists();

  if(!is_equal(level.script, "mp_bm_tut")) {
    crate thread watchcratedestroyearly();
  }

  if(istrue(crate.hasnophysics)) {
    crate activatecratefirsttime();
  } else if(istrue(var_6244a1d5b282bb6c)) {
    crate cratephysicson();
  }

  return crate;
}

function activatecratefirsttime() {
  activatecrate(1);
}

function activatecrate(isfirstactivation) {
  self notify("activateCrate");
  self.isfirstactivation = undefined;

  if(istrue(self.destroyonactivate)) {
    thread destroycrate();
    return;
  }

  _createnavobstacle();
  self notify("crate_dropped");

  if(istrue(self.waitforobjectiveactivate) && istrue(isfirstactivation)) {
    self waittill("objective_activate");
  }

  if(istrue(isfirstactivation) && self.cratetype != "battle_royale_loadout" && !istrue(self.skipminimapicon)) {
    createminimapicon();
  }

  _createheadicon();
  makecrateusable();
  leveldata = getleveldata(self.cratetype);

  if(isDefined(leveldata.activatecallback)) {
    self thread[[leveldata.activatecallback]](isfirstactivation);
  }
}

function deactivatecrate(ispermanent) {
  if(istrue(ispermanent)) {
    destroyminimapicon();
  }

  _destroyheadicon();
  makecrateunusable();
  leveldata = getleveldata(self.cratetype);

  if(isDefined(leveldata.deactivatecallback)) {
    self thread[[leveldata.deactivatecallback]](ispermanent);
  }
}

function capturecrate(player) {
  leveldata = getleveldata(self.cratetype);
  var_45c6df348e1551b3 = isDefined(self.owner);

  if(var_45c6df348e1551b3 && istrue(self.owner.isffprotectedaction)) {
    self.owner.isffprotectedaction = 0;
  }

  if(isDefined(leveldata.capturecallback)) {
    self thread[[leveldata.capturecallback]](player);
  }

  if(!istrue(self.boobytrapped) && istrue(player.var_9ee2c87e0747c021)) {
    var_ee3ccf749502a23 = level.sharedfuncs[#"perk"][#"hash_5e75be22dd250b68"];

    if(isDefined(var_ee3ccf749502a23)) {
      self thread[[var_ee3ccf749502a23]](player);
    }

    self.boobytrapped = 1;
    return;
  }

  if(istrue(self.boobytrapped)) {
    detonatefunc = level.sharedfuncs[#"perk"][#"hash_3b864e571f199211"];

    if(isDefined(detonatefunc)) {
      self thread[[detonatefunc]]();
    }

    thread deletecrate(isDefined(self.var_278a47ee942fd1b0) ? self.var_278a47ee942fd1b0 : 2.5);
    return;
  }

  if(leveldata.destroyoncapture) {
    deletiondelay = 0;

    if(isDefined(leveldata.capturevisualscallback)) {
      self thread[[leveldata.capturevisualscallback]](self);
      deletiondelay = leveldata.capturevisualsdeletiondelay;
    }

    thread deletecrate(deletiondelay);
  }
}

function destroycrate(immediate) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  if(!isDefined(immediate)) {
    if(isDefined(self.scenenode)) {
      if(isDefined(self.animdroptime)) {
        if(gettime() >= self.animdroptime) {
          self.destroyonactivate = 1;
          return;
        } else {
          immediate = 1;
        }
      }
    } else if(istrue(self.physicsactivated)) {
      if(!istrue(self.physicssettled)) {
        self.destroyonactivate = 1;
        return;
      }
    }
  }

  if(isDefined(self.numuses) && self.numuses > 0 && isDefined(self.owner) && isPlayer(self.owner)) {
    if(isDefined(self.streakinfo) && isDefined(self.streakinfo.airdroptype) &self.streakinfo.airdroptype == "loadout_drop") {
      self.owner scripts\cp_mp\challenges::function_d997435895422ecc("super_loadout_drop", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"end"), self.numuses);
    }
  }

  self.destroyonactivate = undefined;
  leveldata = getleveldata(self.cratetype);

  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.crates) && array_contains(level.br_pickups.crates, self)) {
    level.br_pickups.crates = array_remove(level.br_pickups.crates, self);
  }

  if(isDefined(self.owner) && istrue(self.owner.isffprotectedaction)) {
    self.owner.isffprotectedaction = 0;
  }

  if(isDefined(leveldata.destroycallback)) {
    self thread[[leveldata.destroycallback]](immediate);
  }

  if(!istrue(immediate)) {
    deletiondelay = undefined;

    if(!istrue(self.physicsactivated) || !istrue(self.physicssettled)) {
      if(isDefined(leveldata.destroyvisualscallback)) {
        self thread[[leveldata.destroyvisualscallback]](self);
        deletiondelay = leveldata.destroyvisualsdeletiondelay;
      }
    } else if(isDefined(leveldata.capturevisualscallback)) {
      self thread[[leveldata.capturevisualscallback]](self);
      deletiondelay = leveldata.capturevisualsdeletiondelay;
    }

    thread deletecrate(deletiondelay);
    return;
  }

  thread deletecrateimmediate();
}

function deletecrate(delay) {
  if(istrue(self.isdestroyed)) {
    return;
  }

  self notify("death");
  self.isdestroyed = 1;

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
  makecrateunusable();

  if(isDefined(self.useobject)) {
    self.useobject delete();
  }

  destroydangerzone();
  _destroynavobstacle();
  destroymountmantlemodel();
  cratephysicsoff();
  destroyminimapicon();
  function_3a065ce769b6ce3d();
  _destroyheadicon();
  self notsolid();

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  wait delay;
  self delete();
}

function deletecrateimmediate() {
  deletiondelay = level.framedurationseconds;

  if(isDefined(self getlinkedscriptableinstance()) && self getscriptablehaspart("visibility")) {
    self setscriptablepartstate(#"visibility", #"hide", 1);
  }

  deletecrate(deletiondelay);
}

function watchcratedestroyearly() {
  self endon("death");
  leveldata = getleveldata(self.cratetype);

  nolifetime = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(nolifetime) {
    leveldata.timeout = undefined;
  }

  if(isDefined(leveldata.timeout)) {
    assert(leveldata.timeout > 0, "watchCrateDestroyEarly called with a timeOut value of 0.");
  }

  watchcratedestroyearlyinternal(leveldata.timeout);

  if(istrue(self.nevertimeout)) {
    return;
  }

  thread destroycrate();
}

function watchcratedestroyearlyinternal(timeout) {
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");

  if(isDefined(timeout)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(timeout);

    while(isDefined(self.playersusing) && self.playersusing.size > 0) {
      validuser = 0;

      foreach(player in self.playersusing) {
        if(isDefined(player)) {
          validuser = 1;
          break;
        }
      }

      if(!istrue(validuser)) {
        break;
      }

      waitframe();
    }

    return;
  }

  level waittill("forever");
}

function destroycrateinbadtrigger() {
  if(issharedfuncdefined("entity", "touchingBadTrigger")) {
    if(self[[getsharedfunc("entity", "touchingBadTrigger")]]()) {
      thread destroycrate();
    }
  }

  if(isDefined(level.var_ca4e08767cbdae12)) {
    canplant = self[[level.var_ca4e08767cbdae12]](self.origin);

    if(!canplant) {
      if(issharedfuncdefined("player", "isReallyAlive")) {
        owneralive = isDefined(self.owner) && [[getsharedfunc("player", "isReallyAlive")]](self.owner);

        if(!owneralive) {
          thread destroycrate();
          return;
        }

        if(issharedfuncdefined("hud", "showErrorMessage")) {
          self.owner[[getsharedfunc("hud", "showErrorMessage")]]("EQUIPMENT/PLANT_FAILED");
        }

        if(isDefined(self.cratetype) && self.cratetype == "loadout_drop") {
          if(issharedfuncdefined("supers", "refundSuper")) {
            self.owner[[getsharedfunc("supers", "refundSuper")]]();
          }
        } else if(isDefined(self.streakinfo) && isDefined(self.streakinfo.mpstreaksysteminfo)) {
          if(issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
            self.owner[[getsharedfunc("killstreak", "awardKillstreakFromStruct")]](self.streakinfo.mpstreaksysteminfo, "other");
          }
        }
      }

      thread destroycrate();
    }
  }
}

function initcratedropdata() {
  leveldata = spawnStruct();
  leveldata.helis = [];
  var_d8d1344707480943 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(var_d8d1344707480943)) {
    leveldata.heliheight = var_d8d1344707480943.origin[2] - 750;
  } else {
    leveldata.heliheight = 2000;
  }

  leveldata.heliheightoffset = 128;
  level.cratedropdata = leveldata;
  initscriptedhelidropdata();

  if(isDefined(level.var_fc8ea831d44aeff6) && !getdvarint(@ "hash_d400e64d176da3a4", 0)) {
    foreach(excludestreak in level.var_fc8ea831d44aeff6) {
      overridekillstreakcrateweight(excludestreak, 0);
    }
  }
}

function initscriptedhelidropdata() {
  initscriptedhelidropanims();
}

#using_animtree("script_model");

function initscriptedhelidropanims() {
  level.scr_animtree["care_package"] = #animtree;
  level.scr_anim["care_package"]["care_package_drop"] = % mp_carepackage_ckpg_flyin;
  level.scr_anim["care_package"]["care_package_capture"] = % mp_military_carepackage_straps_falling;
  level.scr_animtree["care_package_chute"] = #animtree;
  level.scr_anim["care_package_chute"]["care_package_drop"] = % mp_carepackage_parachute_flyin;
  initscriptedhelidropvehicleanims();
  initbrc130airdropdropanims();
}

#using_animtree("mp_vehicles_always_loaded");

function initscriptedhelidropvehicleanims() {
  level.scr_animtree["care_package_heli"] = #animtree;
  level.scr_anim["care_package_heli"]["care_package_drop"] = % mp_carepackage_lbravo_flyin;
}

#using_animtree("script_model");

function initbrc130airdropdropanims() {
  level.scr_anim["care_package"]["brc130_drop_high"] = % mp_carepackage_ckpg_flyin_10500;
  level.scr_anim["care_package"]["brc130_drop_med"] = % mp_carepackage_ckpg_flyin_7500;
  level.scr_anim["care_package"]["brc130_drop_low"] = % mp_carepackage_ckpg_flyin_3000;
  level.scr_anim["care_package_chute"]["brc130_drop_high"] = % mp_carepackage_parachute_flyin_10500;
  level.scr_anim["care_package_chute"]["brc130_drop_med"] = % mp_carepackage_parachute_flyin_7500;
  level.scr_anim["care_package_chute"]["brc130_drop_low"] = % mp_carepackage_parachute_flyin_3000;
}

function placecrate(owner, team, cratetype, position, angles, data, skipminimapicon) {
  return createcrate(owner, team, cratetype, position, angles, undefined, 0, 1, data, skipminimapicon, position);
}

function dropcrate(owner, team, cratetype, position, angles, destination, data, skipminimapicon) {
  if(!isDefined(destination)) {
    caststart = getcratedropcaststart(position, 0);
    destination = getcratedropdestination(caststart, getcratedropcastend(caststart, 0));
  }

  return createcrate(owner, team, cratetype, position, angles, destination, undefined, 1, data, skipminimapicon, position);
}

function dropcratefrommanualheli(owner, team, cratetype, position, angles, enteroffset, exitoffset, destination, data) {
  position = getcratedropcaststart(position, 1);
  height = position[2];

  if(!isDefined(destination)) {
    destination = getcratedropdestination(position, getcratedropcastend(position, 1));

    if(!isDefined(destination)) {
      return undefined;
    }
  }

  dropstruct = spawnStruct();
  dropstruct.owner = owner;
  dropstruct.team = team;
  dropstruct.hasowner = isDefined(owner);
  angles *= (0, 1, 0);
  enterposition = position + -1 * anglesToForward(angles) * enteroffset;
  dropstruct.dropposition = position;
  dropstruct.exitposition = position + anglesToForward(angles) * exitoffset;
  vehicleisreserved = undefined;

  if(isDefined(data)) {
    vehicleisreserved = data.vehicleisreserved;
  }

  heli = createheli(owner, team, enterposition, angles, vehicleisreserved);
  heli.dropstruct = dropstruct;

  if(issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[getsharedfunc("game", "isBRStyleGameType")]]()) {
      heli vehicle_setspeed(100, 60);
    } else {
      heli vehicle_setspeed(200, 100);
    }
  }

  heli setmaxpitchroll(15, 15);
  heli setscriptablepartstate(#"lights", #"active", 1);
  dropstruct.heli = heli;
  crate = createcrate(owner, team, cratetype, enterposition, heli.angles, destination, undefined, 0, data, undefined, position);
  crate.dropstruct = dropstruct;
  crate linkTo(heli, "tag_origin", (16, 0, -156), (0, 0, 0));
  dropstruct.crate = crate;
  dropstruct thread watchdropcratefrommanualheli();
  return dropstruct;
}

function watchdropcratefrommanualheli() {
  self endon("death");
  watchdropcratefrommanualheliinternal();

  if(isDefined(self.crate)) {
    self.crate thread destroycrate();
  }

  if(isDefined(self.heli)) {
    self.heli thread destroyheli();
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
  self.heli waittill_notify_or_timeout("death", 2);

  if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
    thread docratedropfrommanualheli();
    return;
  }

  self.heli setyawspeed(40, 20, 20, 0.3);

  if(distancesquared(self.heli.origin, self.dropposition) > 5184) {
    self.heli waittill_any_2("death", "goal");

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      thread docratedropfrommanualheli();
      return;
    }

    self.heli waittill_notify_or_timeout("death", 0.25);

    if(isDefined(self.crate) && !istrue(self.crate.isdestroyed)) {
      thread docratedropfrommanualheli();
    }

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }

    self.heli waittill_notify_or_timeout("death", 0.5);

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }

    if(distancesquared(self.heli.origin, self.exitposition) > 5184) {
      if(issharedfuncdefined("game", "isBRStyleGameType")) {
        if([[getsharedfunc("game", "isBRStyleGameType")]]()) {
          self.heli vehicle_setspeed(100, 60);
        } else {
          self.heli vehicle_setspeed(150, 50);
        }
      }

      self.heli setvehgoalpos(self.exitposition, 1);
      self.heli waittill_any_2("death", "goal");
    }
  }
}

function docratedropfrommanualheli() {
  crate = self.crate;
  self.crate.dropstruct = undefined;
  self.crate = undefined;
  crate cratephysicson();
}

function createcrateforscripteddrop(owner, team, cratetype, destination, hasnophysics, var_6244a1d5b282bb6c, data, streakinfo, scenenode, animname, _anim, clearanimdroptime, markerposition) {
  if(isDefined(streakinfo) && isDefined(streakinfo.streakname) && isstruct(data)) {
    streakbundle = undefined;

    if(isDefined(level.streakglobals)) {
      streakbundle = level.streakglobals.streakbundles[streakinfo.streakname];
    }

    if(isDefined(streakbundle) && isDefined(streakbundle.var_46525b458090d681)) {
      data.var_4191ace1612a5376 = streakbundle.var_46525b458090d681;
    }
  }

  crate = createcrate(owner, team, cratetype, scenenode.origin, scenenode.angles, destination, hasnophysics, var_6244a1d5b282bb6c, data, undefined, markerposition);

  if(!isDefined(crate)) {
    return undefined;
  }

  crate.scenenode = scenenode;
  crate.streakinfo = streakinfo;

  if(!isDefined(scenenode.crates)) {
    scenenode.crates = [];
  }

  scenenode.crates[crate getentitynumber()] = crate;
  crate setscriptablepartstate(#"visibility", #"hide", 0);
  crate.animname = animname;
  crate scripts\common\anim::setanimtree();
  crateanim = level.scr_anim[animname][_anim];
  crateanimtime = getanimlength(crateanim) * 1000;
  crate.animdroptime = undefined;
  crate.animstoptrailtime = undefined;
  crate.animendtime = gettime() + crateanimtime;

  if(!istrue(clearanimdroptime)) {
    crate.animdroptime = gettime() + getnotetracktimes(crateanim, "carepackage_drop")[0] * crateanimtime;
    crate.animstoptrailtime = gettime() + getnotetracktimes(crateanim, "carepackage_trail_end")[0] * crateanimtime;
  }

  scenenode.latestanimendtime = ter_op(crate.animendtime > scenenode.latestanimendtime, crate.animendtime, scenenode.latestanimendtime);
  return crate;
}

function createchuteforscripteddrop(scenenode, crate, animname, _anim) {
  if(!isDefined(scenenode.chutes)) {
    scenenode.chutes = [];
  }

  chute = spawn("script_model", scenenode.origin);
  chute.angles = scenenode.origin;
  chute.scenenode = scenenode;
  chute.crate = crate;
  chute.crateanimdroptime = crate.animdroptime;
  scenenode.chutes[chute getentitynumber()] = chute;
  chute setModel("veh9_mil_lnd_parachute_carepackage_mp");
  chute setscriptablepartstate(#"visibility", #"hide", 0);
  chute.animname = animname;
  chute scripts\common\anim::setanimtree();
  chuteanim = level.scr_anim[animname][_anim];
  chuteanimtime = getanimlength(chuteanim) * 1000;
  chute.animendtime = gettime() + getanimlength(level.scr_anim[animname][_anim]) * 1000;
  chute.animunhidetime = gettime() + getnotetracktimes(chuteanim, "chute_unhide")[0] * chuteanimtime;
  chute.animendtime = gettime() + chuteanimtime;
  scenenode.latestanimendtime = ter_op(chute.animendtime > scenenode.latestanimendtime, chute.animendtime, scenenode.latestanimendtime);
  return chute;
}

function destroychute() {
  if(isDefined(self.scenenode)) {
    self.scenenode.chutes[self getentitynumber()] = undefined;
  }

  self delete();
}

function dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data, streakinfo) {
  if(issharedfuncdefined("killstreak", "currentActiveVehicleCount") && issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      return undefined;
    }
  }

  var_ebb5c644a3f5cfbc = getcratedropcaststart(position, 1);
  var_46d5f28d2724bf1f = angles * (0, 1, 0);
  destination = getcratedropdestination(var_ebb5c644a3f5cfbc, getcratedropcastend(var_ebb5c644a3f5cfbc, 1), destination);

  if(!isDefined(destination)) {
    return undefined;
  }

  var_ebb5c644a3f5cfbc = destination + (0, 0, 2000);
  scenenode = spawn("script_model", var_ebb5c644a3f5cfbc);
  scenenode.angles = var_46d5f28d2724bf1f;
  scenenode setModel("tag_origin");
  scenenode.owner = owner;
  scenenode.team = team;
  scenenode.hasowner = isDefined(owner);
  vehicleisreserved = undefined;

  if(isDefined(data)) {
    vehicleisreserved = data.vehicleisreserved;
  }

  heli = createheli(owner, team, var_ebb5c644a3f5cfbc, var_46d5f28d2724bf1f, vehicleisreserved, streakinfo);

  if(!isDefined(heli)) {
    scenenode delete();
    return undefined;
  }

  heli.scenenode = heli;
  heli setscriptablepartstate(#"visibility", #"hide", 0);
  heli.animname = "care_package_heli";
  scenenode.heli = heli;
  scenenode.heliendtime = gettime() + getanimlength(level.scr_anim["care_package_heli"]["care_package_drop"]) * 1000;
  scenenode.latestanimendtime = scenenode.heliendtime;
  crate = createcrateforscripteddrop(owner, team, cratetype, destination, undefined, 0, data, streakinfo, scenenode, "care_package", "care_package_drop", undefined, position);

  if(!isDefined(crate)) {
    return undefined;
  }

  chute = createchuteforscripteddrop(scenenode, crate, "care_package_chute", "care_package_drop");

  if(!isDefined(chute)) {
    return undefined;
  }

  chute setscriptablepartstate(#"visibility", #"hide", 0);
  scenenode thread watchdropcratefromscriptedheli();
  return scenenode;
}

function watchdropcratefromscriptedheli() {
  self endon("death");
  scripts\common\anim::anim_first_frame_solo(self.heli, "care_package_drop");

  foreach(crate in self.crates) {
    scripts\common\anim::anim_first_frame_solo(crate, "care_package_drop");
  }

  foreach(chute in self.chutes) {
    scripts\common\anim::anim_first_frame_solo(chute, "care_package_drop");
  }

  watchdropcratefromscriptedheliinternal();

  if(isDefined(self.heli)) {
    self.heli thread destroyheli();
  }

  foreach(crate in self.crates) {
    if(isDefined(crate)) {
      crate thread destroycrate();
    }
  }

  foreach(chute in self.chutes) {
    if(isDefined(chute)) {
      chute thread destroychute();
    }
  }

  self delete();
}

function watchdropcratefromscriptedheliinternal() {
  firstframe = undefined;

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

    if(!isDefined(firstframe)) {
      firstframe = 1;
    } else if(firstframe) {
      if(isDefined(self.heli)) {
        self.heli setscriptablepartstate(#"visibility", #"show", 0);

        if(self.heli getscriptablehaspart(#"lights")) {
          self.heli setscriptablepartstate(#"lights", #"active", 1);
        }

        thread scripts\common\anim::anim_single_solo(self.heli, "care_package_drop");
      }

      foreach(crate in self.crates) {
        if(isDefined(crate)) {
          crate setscriptablepartstate(#"visibility", #"show", 0);
          thread scripts\common\anim::anim_single_solo(crate, "care_package_drop");
        }
      }

      foreach(chute in self.chutes) {
        if(isDefined(chute)) {
          thread scripts\common\anim::anim_single_solo(chute, "care_package_drop");
          chute playsoundonmovingent("iw9_carepackage_parachute_drop");
        }
      }

      firstframe = 0;
    } else {
      disowned = istrue(self.ownerdisconnected) || istrue(self.ownerjoinedteam);

      if(isDefined(self.heli)) {
        if(disowned || gettime() > self.heliendtime) {
          self.heli destroyheli();
        }
      }

      foreach(crate in self.crates) {
        if(isDefined(crate)) {
          if(gettime() > crate.animendtime) {
            if(disowned) {
              crate thread destroycrate();
            }

            thread docratedropfromscripted(crate);
            continue;
          }

          if(gettime() > crate.animdroptime) {
            if(gettime() > crate.animstoptrailtime) {
              crate setscriptablepartstate(#"trail", #"neutral", 1);
            } else {
              crate setscriptablepartstate(#"trail", #"active", 1);
            }

            if(disowned) {
              crate thread destroycrate();
            }

            continue;
          }

          if(disowned) {
            crate thread destroycrate();
            continue;
          }

          if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
            thread docratedropfromscripted(crate);
          }
        }
      }

      foreach(chute in self.chutes) {
        if(isDefined(chute)) {
          if(gettime() > chute.animendtime) {
            chute thread destroychute();
            continue;
          }

          if(gettime() <= chute.crateanimdroptime && (!isDefined(chute.crate) || !isDefined(self.crates[chute.crate getentitynumber()]))) {
            chute thread destroychute();
            continue;
          }

          if(gettime() > chute.animunhidetime) {
            chute setscriptablepartstate(#"visibility", #"show", 0);
          }
        }
      }
    }

    waitframe();
  }
}

function docratedropfromscripted(crate) {
  crate.scenenode = undefined;
  self.crates[crate getentitynumber()] = undefined;
  crate.animname = undefined;
  crate.animendtime = undefined;
  crate.animdroptime = undefined;
  crate.animstoptrailtime = undefined;
  crate notify("anim_finished");
  crate stopanimScripted();
  crate cratephysicson();
}

function getcratedropcaststart(position, fromheli, droptype) {
  caststart = undefined;

  if(istrue(fromheli)) {
    caststart = position * (1, 1, 0) + (0, 0, getscriptedhelidropheight(droptype));
  } else {
    caststart = position + (0, 0, 25);
  }

  return caststart;
}

function getcratedropcastend(caststart, fromheli) {
  return caststart + (0, 0, -1 * ter_op(istrue(fromheli), 25000, 25000));
}

function getcratedropdestination(caststart, castend, destination) {
  ignorelist = getcratedropignorelist();
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0);
  droptrace = scripts\engine\trace::sphere_trace(caststart, castend, 100, ignorelist, contentoverride);

  if(droptrace["hittype"] != "hittype_none" && isDefined(droptrace["position"])) {
    if(isDefined(destination)) {
      destination = (destination[0], destination[1], droptrace["position"][2]);
    } else {
      destination = droptrace["position"];
    }
  }

  thread scripts\cp_mp\utility\debug_utility::drawsphere(destination, 20, 30, (0, 1, 0));
  thread scripts\cp_mp\utility\debug_utility::drawline(destination, caststart, 30, (0, 1, 0));
  thread scripts\cp_mp\utility\debug_utility::drawsphere(caststart, 20, 30, (0, 1, 0));

  return destination;
}

function getcratedropignorelist() {
  if(isDefined(level.cratedata.helis) && isDefined(level.cratedata.ac130s)) {
    return array_combine_multiple([level.cratedropdata.helis, level.cratedropdata.ac130s, level.cratedata.crates]);
  }

  return array_combine_multiple([level.cratedropdata.helis, level.cratedata.crates]);
}

function createheli(owner, team, position, angles, vehicleisreserved, streakinfo) {
  heli = undefined;
  var_50cea258b08e022b = #"heli";
  streakbundle = undefined;

  if(isDefined(streakinfo) && isDefined(streakinfo.streakname) && isDefined(level.streakglobals)) {
    streakbundle = level.streakglobals.streakbundles[streakinfo.streakname];
  }

  heliname = "veh_airdrop_mp_phys";
  helimodel = "veh9_mil_air_heli_medium_airdrop_mp";

  if(isDefined(streakbundle)) {
    if(isDefined(streakbundle.var_4380bc0aa8fb8e3f)) {
      var_50cea258b08e022b = streakbundle.var_4380bc0aa8fb8e3f;
    }

    if(isDefined(streakbundle.airdropvehicle)) {
      heliname = streakbundle.airdropvehicle;
    }

    if(isDefined(streakbundle.var_e26d3ad734784c1b)) {
      helimodel = streakbundle.var_e26d3ad734784c1b;
    }
  }

  if(istrue(vehicleisreserved)) {
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }

  if(var_50cea258b08e022b == #"nonheli") {
    spawndata = {
      #var_5bfcdcb0bf0678c6: 1, #targetname: "airdrop", #modelname: helimodel, #vehicletype: heliname, #angles: angles, #origin: position
    };
    faildata = spawnStruct();
    heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnVehicle(spawndata, faildata);
  } else {
    heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, position, angles, heliname, helimodel);
  }

  if(!isDefined(heli)) {
    return undefined;
  }

  if(!isDefined(team)) {
    team = "neutral";
  }

  if(team != "neutral") {
    heli setvehicleteam(team);
  }

  heli.owner = owner;
  heli.team = team;
  destroyedsplash = undefined;
  vodestroyed = undefined;
  scorepopup = undefined;

  if(isDefined(level.heliconfigs)) {
    config = level.heliconfigs["airdrop"];
    heli.health = config.maxhealth;
    heli.maxhealth = config.maxhealth;
    vocallout = config.callout;
    vodestroyed = config.vodestroyed;
    scorepopup = config.scorepopup;
  } else {
    heli.maxhealth = 999999;
    heli.health = heli.maxhealth;
  }

  heli.streakinfo = streakinfo;
  heli.helitype = "airdrop";
  heli setscriptablepartstate(#"engine", #"on", 0);
  level thread function_ee93617532d8a679(heli, owner, undefined, undefined, 1);

  if(isDefined(owner)) {
    if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      heli[[getsharedfunc("killstreak", "addToActiveKillstreakList")]]("airdrop", "Killstreak_Air", owner, 0, 0);
    }

    if(team != "neutral") {
      heli scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
    }
  }

  if(issharedfuncdefined("killstreak", "killstreakMakeVehicle")) {
    heli[[getsharedfunc("killstreak", "killstreakMakeVehicle")]](heliname, scorepopup, vodestroyed, destroyedsplash);
  }

  if(issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback")) {
    heli[[getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](heliname);
  }

  if(issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    heli[[getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](heliname);
  }

  if(issharedfuncdefined("killstreak", "killstreakSetDeathCallback")) {
    heli[[getsharedfunc("killstreak", "killstreakSetDeathCallback")]](heliname, &destroyhelicallback);
  }

  bundle = level.streakglobals.streakbundles["airdrop"];

  if(!isDefined(streakbundle) || !istrue(streakbundle.candamage)) {
    heli setCanDamage(0);
  } else if(issharedfuncdefined("damage", "monitorDamage")) {
    heli thread[[getsharedfunc("damage", "monitorDamage")]](heli.maxhealth, "hitequip", &function_5be12c382c72de75, &function_763c331f22e7499e, 1, 1);
  }

  heli thread watchhelidestroyearly();
  return heli;
}

function private function_5be12c382c72de75(data) {
  veh = data.victim;
  veh thread destroyheli();
  return data.damage;
}

function private function_5df678b586cdb293(veh) {
  if(!isDefined(veh)) {
    return;
  }

  veh thread destroyheli();
  level callback::callback("killstreak_finish_use", {
    #streakinfo: veh.streakinfo
  });
}

function private function_763c331f22e7499e(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  meansofdeath = data.meansofdeath;
  type = data.meansofdeath;
  modifieddamage = data.damage;

  if(istrue(level.var_be6a42242be00b66)) {
    bundle = level.streakglobals.streakbundles["airdrop"];
    modifieddamage = getmodifieddamageusingdamagetuning(attacker, objweapon, type, modifieddamage, self.maxhealth, bundle.var_e913079a5ffda56d);
  } else if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    modifieddamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](attacker, objweapon, meansofdeath, modifieddamage, self.maxhealth, 1, 1, 1);
  }

  data.damage = modifieddamage;
  damagetaken = data.victim.damagetaken + data.damage;
  healthpercent = 100 - 100 * damagetaken / data.victim.maxhealth;
  return data.damage;
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

function deleteheli(delay) {
  self notify("death");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.heli = undefined;
    self.scenenode = undefined;
  }

  removehelidroppingcratefromlist(self getentitynumber());
  wait delay;
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function destroyhelicallback(data) {
  destroyheli();
}

function getscriptedhelidropheightbase(droptype) {
  assertex(isDefined(level.cratedropdata), "getScriptedHeliDropHeightBase() called before initCrateDropData().");
  return level.cratedropdata.heliheight;
}

function getscriptedhelidropheight(droptype) {
  return getscriptedhelidropheightbase(droptype) + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

function addhelidroppingcratetolist(heli) {
  assertex(isDefined(level.cratedropdata), "getScriptedHeliDropHeight() called before initCrateDropData().");
  entnum = heli getentitynumber();
  level.cratedropdata.helis[entnum] = heli;
}

function removehelidroppingcratefromlist(entnum) {
  level.cratedropdata.helis[entnum] = undefined;
}

function makecrateusable() {
  leveldata = getleveldata(self.cratetype);

  if(istrue(leveldata.hasnointeraction)) {
    return;
  }

  level.cratedata.usablecrates[self getentitynumber()] = self;
  self.isusable = 1;
  assertex(leveldata.supportsownercapture || leveldata.supportsothercapture, "makeCrateUsable called on a crate that does not support owner capture OR other capture.");

  if(leveldata.supportsownercapture && leveldata.supportsothercapture) {
    thread watchcrateuse(1);
    useobject = self.useobject;

    if(!isDefined(useobject)) {
      if(isDefined(self.model)) {
        usetag = modelhastag(self.model, leveldata.usetag) ? leveldata.usetag : "tag_origin";
      } else {
        usetag = leveldata.usetag;
      }

      useobject = spawn("script_model", self gettagorigin(usetag));
      useobject setModel("tag_origin");
      useobject linkTo(self);
      useobject makeunusable();
      self.useobject = useobject;
    }

    thread watchcrateuse(2, useobject);
    return;
  }

  if(leveldata.supportsownercapture) {
    thread watchcrateuse(1);
    return;
  }

  thread watchcrateuse(2);
}

function watchcrateuse(usetype, useobject) {
  self endon("death");
  self endon("makeCrateUnusable");

  if(isDefined(useobject)) {
    useobject endon("death");
  }

  if(usetype == 1) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
    self.owner.isffprotectedaction = 1;
  }

  leveldata = getleveldata(self.cratetype);
  triggerobject = gettriggerobject(useobject);
  triggerobject.usetype = usetype;
  triggerobject.userate = 1;
  triggerobject.curprogress = 0;

  if(isDefined(triggerobject.usetimeoverride)) {
    triggerobject.usetime = triggerobject.usetimeoverride;
  } else {
    triggerobject.usetime = ter_op(usetype == 1, leveldata.ownerusetime, leveldata.otherusetime);
  }

  triggerobject.inuse = 0;
  triggerobject.playerusing = undefined;

  while(true) {
    triggerobject waittill("trigger", player);

    if(getdvarint(@ "hash_618b9c003b5b3883", 0) == 0) {
      if(isDefined(self.disabled_use_for) && istrue(self.disabled_use_for[player getentitynumber()])) {
        player scripts\engine\utility::callsharedfunc("airdrop", "airdrop_cannotUseLoadoutCrateHint");
        continue;
      }
    }

    if(istrue(player.isjuggernaut) && !player juggcanusecrate(self.cratetype)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        player[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");
      }

      continue;
    }

    if(istrue(player.hashostage)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        player[[getsharedfunc("hud", "showErrorMessage")]]("MP/CANNOT_USE_GENERIC");
      }

      continue;
    }

    if(canstartusingcrate(player, useobject)) {
      var_8d18e90deac7a522 = level.sharedfuncs[#"perk"][#"hash_3c36a82b640a16f6"];

      if(isDefined(var_8d18e90deac7a522)) {
        if(isDefined(self.owner) && isenemyteam(player.team, self.owner.team)) {
          player.var_9ee2c87e0747c021 = player[[var_8d18e90deac7a522]]();
        }
      }

      startusingcrate(player, useobject);
      player.isffprotectedaction = 1;
      triggerobject.playerusing = player;
      result = watchcrateuseinternal(player, useobject);

      if(isDefined(player)) {
        stopusingcrate(player, useobject);
      }

      triggerobject.playerusing = undefined;

      if(istrue(result)) {
        if(isDefined(player)) {
          player.isffprotectedaction = 0;
        }

        if(leveldata.onecaptureperplayer && self.cratetype != "battle_royale_loadout") {
          if(getdvarint(@ "hash_618b9c003b5b3883") == 0) {
            if(!isDefined(self.playerscaptured)) {
              self.playerscaptured = [];
            }

            self.playerscaptured[player getentitynumber()] = player;
          }
        }

        if(!isDefined(self.targetname) || self.targetname != "btm_flag_primary_inside") {
          thread capturecrate(player);
        }
      }
    }
  }
}

function watchcrateuseinternal(player, useobject) {
  triggerobject = gettriggerobject(useobject);

  if(triggerobject.usetype != 1) {
    player endon("disconnect");
    player endon("joined_team");
    player endon("joined_spectators");
  }

  triggerobject.id = function_7972a1043e6facab();
  triggerobject.userate = ter_op(isDefined(player.objectivescaler), player.objectivescaler, 1);

  var_544e47b30f4f8fc3 = getdvarint(@ "hash_7acaaf8f4063ab02", 0);

  if(isDefined(triggerobject.usetimeoverride)) {
    triggerobject.usetime = triggerobject.usetimeoverride;
  } else if(issharedfuncdefined("<dev string:xac>", "<dev string:xb1>")) {
    if([[getsharedfunc("<dev string:xac>", "<dev string:xb1>")]]() == "<dev string:xbd>") {} else {
      triggerobject.usetime = ter_op(var_544e47b30f4f8fc3, 3, 0.5);
    }
  }

  playusesound(player, useobject);

  while(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive() && cankeepusingcrate(player, useobject) && player useButtonPressed()) {
    triggerobject.curprogress += level.framedurationseconds * triggerobject.userate;

    if(triggerobject.curprogress >= triggerobject.usetime) {
      triggerobject.curprogress = 0;
      return true;
    }

    if(issharedfuncdefined("airdrop", "updateUIProgress")) {
      player[[getsharedfunc("airdrop", "updateUIProgress")]](triggerobject, 1);
    }

    waitframe();
  }

  triggerobject.curprogress = 0;
  return false;
}

function function_7972a1043e6facab() {
  if(utility::iscp()) {
    return "use";
  }

  return "care_package";
}

function makecrateunusable() {
  self notify("makeCrateUnusable");
  assertex(isDefined(level.cratedata), "makeCrateUnusable() called before initCrateData().");
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
  }
}

function startusingcrate(player, useobject) {
  if(!isDefined(self.playersusing)) {
    self.playersusing = [];
  }

  if(!array_contains(self.playersusing, player)) {
    self.playersusing = array_add(self.playersusing, player);
  }

  triggerobject = gettriggerobject(useobject);
  leveldata = getleveldata(self.cratetype);

  if(istrue(player.isjuggernaut)) {
    if(issharedfuncdefined("airdrop", "allowActionSet")) {
      player[[getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 0);
    }
  } else {
    var_5e8f3dee82c118cf = getdvarint(@ "hash_d15c22f57683add1", 1);

    if(var_5e8f3dee82c118cf) {
      player thread airdrop_givecrateuseweapon();
    }

    if(issharedfuncdefined("airdrop", "allowActionSet")) {
      player[[getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 0);
    }
  }

  if(issharedfuncdefined("airdrop", "updateUIProgress")) {
    player[[getsharedfunc("airdrop", "updateUIProgress")]](triggerobject, 0);
  }
}

function airdrop_givecrateuseweapon() {
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  crateweaponobj = makeweapon("ks_use_crate_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(crateweaponobj);
  thread airdrop_watchforcrateuseend(crateweaponobj);
  self switchtoweapon(crateweaponobj);
}

function airdrop_watchforcrateuseend(crateweaponobj) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("crate_use_end");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(crateweaponobj)) {
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(crateweaponobj);
    return;
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(crateweaponobj);

  if(isDefined(self.lastdroppableweaponobj)) {
    lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates(self.lastdroppableweaponobj);
    self switchtoweapon(lastweaponobj);
    thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(lastweaponobj);
  }
}

function stopusingcrate(player, useobject) {
  if(array_contains(self.playersusing, player)) {
    self.playersusing = array_remove(self.playersusing, player);
  }

  triggerobject = gettriggerobject(useobject);
  leveldata = getleveldata(self.cratetype);

  if(istrue(player.isjuggernaut)) {
    if(issharedfuncdefined("airdrop", "allowActionSet")) {
      player[[getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 1);
    }
  } else if(issharedfuncdefined("airdrop", "allowActionSet")) {
    player[[getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 1);
  }

  if(issharedfuncdefined("airdrop", "updateUIProgress")) {
    player[[getsharedfunc("airdrop", "updateUIProgress")]](triggerobject, 0);
  }

  stopusesound(player, useobject);
  player notify("crate_use_end");
}

function canstartusingcrate(player, useobject, var_c83f8b96968afe72) {
  if(issharedfuncdefined("airdrop", "specialCase_canUseCrate")) {
    if(!player[[getsharedfunc("airdrop", "specialCase_canUseCrate")]]()) {
      return 0;
    }
  }

  if(!player val::get("crate_use")) {
    return 0;
  }

  if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(player isonladder()) {
    return 0;
  }

  if(getdvarint(@ "hash_618b9c003b5b3883", 0) == 0) {
    if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[player getentitynumber()])) {
      return 0;
    }
  }

  if(istrue(self.issquadonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, player)) {
      return 0;
    }

    if(player.sessionsquadid != self.sessionsquadid || player.team != self.team) {
      return 0;
    }
  }

  if(istrue(self.isteamonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, player)) {
      return 0;
    }

    if(player.team != self.team) {
      return 0;
    }
  }

  if(!self.isusable) {
    return 0;
  }

  if(!isDefined(var_c83f8b96968afe72)) {
    var_c83f8b96968afe72 = 1;
  }

  if(var_c83f8b96968afe72) {
    return canstartusingcratetriggerobject(player, useobject);
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && player isskydiving()) {
    return 0;
  }

  if(istrue(player.inlaststand)) {
    return 0;
  }

  return 1;
}

function canstartusingcratetriggerobject(player, useobject) {
  triggerobject = gettriggerobject(useobject);

  if(isDefined(triggerobject.playerusing) && triggerobject.playerusing != player) {
    return false;
  }

  if(triggerobject.usetype == 1 && (!isDefined(self.owner) || player != self.owner)) {
    return false;
  }

  if(triggerobject.usetype == 2 && isDefined(self.owner) && player == self.owner) {
    return false;
  }

  if(level.teambased && isDefined(self.team) && self.team != "neutral") {
    leveldata = getleveldata(self.cratetype);

    if(leveldata.friendlyuseonly && player.team != self.team) {
      return false;
    }
  }

  return true;
}

function cankeepusingcrate(player, useobject) {
  if(!val::get("crate_use")) {
    return false;
  }

  if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
    return false;
  }

  if(player meleeButtonPressed()) {
    return false;
  }

  if(player isinexecutionvictim()) {
    return false;
  }

  if(istrue(player.inlaststand)) {
    return false;
  }

  leveldata = getleveldata(self.cratetype);

  if(isDefined(leveldata.breakuserangesqr) && distancesquared(player.origin, gettriggerobject(useobject).origin) >= leveldata.breakuserangesqr) {
    return false;
  }

  if(!self.isusable) {
    return false;
  }

  if(isDefined(self.cratetype) && self.cratetype == "loadout_drop") {
    if(!player isonground() && !player isswimming()) {
      return false;
    }
  }

  return true;
}

function makecrateusableforplayer(crate, player) {
  triggerobject = crate gettriggerobject();
  function_b21dea8dc3360508(triggerobject, crate);

  if(isDefined(crate.useobject)) {
    triggerobject = crate gettriggerobject(crate.useobject);
    function_b21dea8dc3360508(triggerobject, crate);
  }

  crate enableplayeruse(player);

  if(isDefined(crate.useobject)) {
    crate.useobject enableplayeruse(player);
  }

  if(!crate canstartusingcrate(player, crate.useobject, 0)) {
    crate disableplayeruse(player);

    if(isDefined(crate.useobject)) {
      crate.useobject disableplayeruse(player);
    }

    return;
  }

  if(!crate canstartusingcratetriggerobject(player, undefined)) {
    crate disableplayeruse(player);
  }

  if(isDefined(crate.useobject)) {
    if(!crate canstartusingcratetriggerobject(player, crate.useobject)) {
      crate.useobject disableplayeruse(player);
    }
  }
}

function function_b21dea8dc3360508(triggerobject, crate) {
  leveldata = getleveldata(crate.cratetype);

  if(!iscp()) {
    triggerobject setCursorHint("HINT_NOICON");
    triggerobject sethintonobstruction("show");
  } else {
    triggerobject setCursorHint("HINT_BUTTON");
    triggerobject sethintonobstruction("hide");
  }

  triggerobject sethinttag(leveldata.usetag);
  triggerobject sethintdisplayrange(leveldata.userange);
  triggerobject sethintdisplayfov(leveldata.usefov);
  triggerobject setuserange(leveldata.userange);
  triggerobject setusefov(leveldata.usefov);
  triggerobject setusepriority(leveldata.usepriority);
  triggerobject setuseholdduration("duration_none");

  if(triggerobject.usetype == 1 && crate.supportsreroll) {
    triggerobject setHintString(crate.rerollstring);
    return;
  }

  triggerobject setHintString(crate.capturestring);
}

function watchallcrateusability() {
  var_36afca263bbc6fbc = 0;

  if(getdvarint(@ "scr_airdrop_fast_usable_crates", 0)) {
    var_36afca263bbc6fbc = 1;
  }

  while(true) {
    foreach(crate in level.cratedata.usablecrates) {
      if(!isDefined(crate)) {
        continue;
      }

      crate makeusable();

      if(istrue(var_36afca263bbc6fbc)) {
        crate disableplayeruseforallplayers();
      }

      if(isDefined(crate.useobject)) {
        crate.useobject makeusable();

        if(istrue(var_36afca263bbc6fbc)) {
          crate.useobject disableplayeruseforallplayers();
        }
      }

      playerlist = level.players;

      if(istrue(var_36afca263bbc6fbc)) {
        if(level.teambased && isDefined(crate.team) && crate.team != "neutral") {
          leveldata = getleveldata(crate.cratetype);

          if(leveldata.friendlyuseonly) {
            playerlist = level.teamdata[crate.team]["alivePlayers"];
          }
        }
      }

      foreach(player in playerlist) {
        if(isDefined(crate.var_83cf634784b3a96b)) {
          if(!crate[[crate.var_83cf634784b3a96b]](player)) {
            continue;
          }
        }

        if(istrue(var_36afca263bbc6fbc)) {
          inrange = distancesquared(crate.origin, player.origin) < 57600;

          if(inrange) {
            makecrateusableforplayer(crate, player);
          }

          continue;
        }

        makecrateusableforplayer(crate, player);
      }
    }

    wait 0.1;
  }
}

function playusesound(player, useobject) {
  triggerobject = gettriggerobject(useobject);

  if(triggerobject.usetype == 1) {
    player playLoopSound("mp_care_package_owner_cap");
    return;
  }

  player playLoopSound("mp_care_package_non_owner_cap");
}

function stopusesound(player, useobject) {
  triggerobject = gettriggerobject(useobject);

  if(triggerobject.usetype == 1) {
    player stoploopsound("mp_care_package_owner_cap");
  } else {
    player stoploopsound("mp_care_package_non_owner_cap");
  }

  if(player scripts\cp_mp\utility\player_utility::_isalive()) {
    player playsoundonmovingent("mp_care_package_cap_tail");
  }
}

function gettriggerobject(useobject) {
  return isDefined(useobject) ? useobject : self;
}

function cratephysicson(contactpoint, force) {
  leveldata = getleveldata(self.cratetype);

  if(isDefined(leveldata.cratephysicsoncallback)) {
    self thread[[leveldata.cratephysicsoncallback]]();
  }

  if(!isDefined(contactpoint)) {
    contactpoint = (0, 0, 0);
  }

  if(!isDefined(force)) {
    force = (0, 0, 0);
  }

  self unlink();
  self physicslaunchserver(contactpoint, force);

  if(isDefined(self.killcament) && !istrue(self.killcament.linked)) {
    self.killcament linkTo(self, "tag_origin", (0, 0, 300), (0, 0, 0));
  }

  bodyid = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(bodyid, (0, 0, -0.75));
  self.physicsactivated = 1;
  createdangerzone();
  thread monitoraveragevelocityandupdate();
  thread monitorplayerimpact();

  if(isDefined(level.wztrain_info) && issharedfuncdefined("game", "handlemovingplatforms")) {
    data = spawnStruct();
    data.deathoverridecallback = &function_a4d56f106b5ad5f9;
    self thread[[getsharedfunc("game", "handlemovingplatforms")]](data);
  }

  thread monitorimpact();
}

function function_a4d56f106b5ad5f9(data) {
  engine = scripts\cp_mp\utility\train_utility::function_d6b0a591ac99bd();
  assert(isDefined(engine));

  if(!isDefined(engine)) {
    return;
  }

  if(is_equal(data.lasttouchedplatform, engine)) {
    if(!istrue(self.hitbytrain)) {
      force = engine.velocity * 150;
      contactpoint = engine.origin + rotatevector((375, 0, -100), engine.angles);
      self playSound("mp_care_package_high_impact");
      self physicslaunchserver(contactpoint, force);
      self.hitbytrain = 1;
    } else {
      scripts\cp_mp\killstreaks\airdrop::destroycrate();
      return;
    }
  }

  wait 1;
  data = spawnStruct();
  data.deathoverridecallback = &function_a4d56f106b5ad5f9;
  self thread[[getsharedfunc("game", "handlemovingplatforms")]](data);
}

function cratephysicsoff() {
  if(!istrue(self.physicsactivated)) {
    return;
  }

  self.physicsactivated = undefined;
  self.physicssettled = undefined;
  self physicsstopserver();
  clearaveragevelocities();
  monitorimpactend();
  monitorplayerimpactend();
  cancelchecklinktotrain();
}

function monitoraveragevelocityandupdate() {
  self endon("death");
  self notify("monitorAverageVelocityAndUpdate");
  self endon("monitorAverageVelocityAndUpdate");
  var_fea57fa0e78c63db = 0.1;
  thread monitoraveragevelocities(var_fea57fa0e78c63db, 8);
  settlecount = 0;
  var_4080d353839c6230 = 0;
  self.isfirstactivation = 1;
  var_1684a0b0fb3502c6 = undefined;
  var_42d273fe9538af56 = undefined;

  if(issharedfuncdefined("game", "lpcFeatureGated")) {
    var_42d273fe9538af56 = getsharedfunc("game", "lpcFeatureGated");
  }

  while(true) {
    avlinvel = getaveragelinearvelocity();
    avangvel = getaverageangularvelocity();

    if(isDefined(avlinvel) && isDefined(avangvel)) {
      if(avlinvel <= function_3c4492046080faa9() && avangvel <= function_f7e3f128296ac3b6()) {
        settlecount++;
        var_4080d353839c6230 = 0;

        if(settlecount == function_d4833b6c916db9c6()) {
          self.physicssettled = 1;
          var_1684a0b0fb3502c6 = self.origin;
          thread activatecrate(self.isfirstactivation);

          if(isDefined(var_42d273fe9538af56) && [[var_42d273fe9538af56]]()) {
            monitorimpactend();

            if(isDefined(self.killcament)) {
              self.killcament delete();
            }
          }

          var_fea57fa0e78c63db = 0.1;
          thread monitoraveragevelocities(var_fea57fa0e78c63db, 3, 3);
          destroycrateinbadtrigger();
        }
      } else {
        if(isDefined(var_1684a0b0fb3502c6)) {
          if(distancesquared(self.origin, var_1684a0b0fb3502c6) <= 2500) {
            wait var_fea57fa0e78c63db;
            continue;
          }
        }

        var_4080d353839c6230++;
        settlecount = 0;

        if(var_4080d353839c6230 == 1) {
          self.physicssettled = undefined;
          thread deactivatecrate();
          var_fea57fa0e78c63db = 0.1;
          thread monitoraveragevelocities(var_fea57fa0e78c63db, 8);
        }
      }

      wait var_fea57fa0e78c63db;
      continue;
    }

    waitframe();
  }
}

function monitoraveragevelocities(var_fea57fa0e78c63db, numdatapoints, var_2b14322307dd13aa) {
  clearaveragevelocities();
  self endon("death");
  self endon("clear_average_velocities");
  self.linvels = [];
  self.angvels = [];
  self.velstartid = 0;
  self.velendid = 0;
  self.velnumdatapoints = numdatapoints;

  if(isDefined(var_2b14322307dd13aa)) {
    var_2b14322307dd13aa = int(clamp(var_2b14322307dd13aa, 0, numdatapoints));

    if(var_2b14322307dd13aa > 0) {
      for(i = 0; i < var_2b14322307dd13aa; i++) {
        self.linvels[self.velstartid + i] = 0;
        self.angvels[self.velstartid + i] = 0;
      }
    }
  }

  while(true) {
    bodyid = self physics_getbodyid(0);
    linvel = physics_getbodylinvel(bodyid);
    angvel = physics_getbodyangvel(bodyid);
    self.linvels[self.velendid] = length(linvel);
    self.angvels[self.velendid] = length(angvel);
    self.velendid++;
    var_e8d39b65d6180c15 = self.velendid - self.velstartid;

    if(var_e8d39b65d6180c15 > numdatapoints) {
      shift = mod(var_e8d39b65d6180c15, numdatapoints);

      for(i = 0; i < shift; i++) {
        self.linvels[self.velstartid + i] = undefined;
        self.angvels[self.velstartid + i] = undefined;
      }

      self.velstartid += shift;
    }

    self.avlinvel = undefined;
    self.avangvel = undefined;
    wait var_fea57fa0e78c63db;
  }
}

function getaveragelinearvelocity() {
  if(isDefined(self.avlinvel)) {
    return self.avlinvel;
  }

  if(!isDefined(self.linvels)) {
    return undefined;
  }

  if(self.velendid - self.velstartid < self.velnumdatapoints) {
    return undefined;
  }

  calculateaveragevelocities();
  return self.avlinvel;
}

function getaverageangularvelocity() {
  if(isDefined(self.avangvel)) {
    return self.avangvel;
  }

  if(!isDefined(self.angvels)) {
    return undefined;
  }

  if(self.velendid - self.velstartid < self.velnumdatapoints) {
    return undefined;
  }

  calculateaveragevelocities();
  return self.avangvel;
}

function calculateaveragevelocities() {
  var_7a89fce67703419f = 0;
  var_3386dde146fd60b4 = 0;

  for(i = self.velstartid; i < self.velendid; i++) {
    var_7a89fce67703419f += self.linvels[i];
    var_3386dde146fd60b4 += self.angvels[i];
  }

  self.avlinvel = var_7a89fce67703419f / self.velnumdatapoints;
  self.avangvel = var_3386dde146fd60b4 / self.velnumdatapoints;
}

function clearaveragevelocities() {
  self notify("clear_average_velocities");
  self.linvels = undefined;
  self.angvels = undefined;
  self.velnumdatapoints = undefined;
  self.velstartid = undefined;
  self.velendid = undefined;
  self.avlinvel = undefined;
  self.avangvel = undefined;
}

function monitorimpact(delay) {
  monitorimpactend();
  self endon("monitorImpactEnd");
  self.monitoringimpact = 1;
  self playLoopSound("mp_care_package_drop_lp");
  self physics_registerforcollisioncallback();
  monitorimpactinternal(delay);

  if(isDefined(self)) {
    thread monitorimpactend();
  }
}

function monitorimpactinternal(delay) {
  self endon("death");

  if(isDefined(delay)) {
    wait delay;
  }

  var_260ef1536027d0e1 = 0;
  firstimpact = 0;

  while(true) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent);

    if(!istrue(firstimpact)) {
      if(isDefined(self.killcament)) {
        self.killcament unlink();
        self.killcament.linked = 0;
      }

      firstimpact = 1;
    }

    if(isDefined(ent)) {
      if(impactshoulddestroyent(ent)) {
        if(isDefined(ent.vehicletype)) {
          if(isDefined(ent.streakinfo)) {
            if(isDefined(ent.var_3098bbcd22d0e052) && isDefined(ent.var_3098bbcd22d0e052.cleanupfunc)) {
              ent thread[[ent.var_3098bbcd22d0e052.cleanupfunc]]();
            } else if(ent scripts\cp_mp\killstreaks\helper_drone::ishelperdrone()) {
              ent thread scripts\cp_mp\killstreaks\helper_drone::function_ba1c5496f8fc5f67();
            }
          } else if(getdvarint(@ "hash_35d73d70c6843ce8", 1)) {
            isbossvehicle = ent scripts\cp_mp\vehicles\vehicle::isbossvehicle();

            if(!isbossvehicle && !istrue(ent.exfilhelicopter)) {
              ent.dontspawnhusk = 1;
              ent scripts\cp_mp\vehicles\vehicle::vehicle_explode();
            }
          }
        } else if(ent.classname == "scriptable_iw8_chicken_01") {
          thread airdrop_crushchicken(ent);
        } else if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover") {
          ent[[ent.deletefunc]](0, 1, 1);
        } else if(isDefined(ent.turrettype) && ent.turrettype == "sentry_turret") {
          ent notify("kill_turret", 1, 1);
        }
      }

      checklinktotrain(ent);
    }

    if(gettime() - var_260ef1536027d0e1 >= 200) {
      var_260ef1536027d0e1 = gettime();
      surface = physics_getsurfacetypefromflags(flag1);
      surfacetype = getsubstr(surface["name"], 9);

      if(surfacetype == "glass_pane") {
        glassradiusdamage(self.origin - (0, 0, 10), 100, 1000, 1000);
        waitframe();
        cratephysicson();
      }

      if(surfacetype == "water" && !istrue(self.inwater)) {
        self.inwater = 1;
      }

      if(surfacetype == "user_terrain1") {
        surfacetype = "user_terrain_1";
      }

      if(surfacetype == "user_terrain5") {
        surfacetype = "user_terrain_5";
      }

      playimpactfx(position, normal, impulse, surfacetype);
    }
  }
}

function checklinktotrain(ent) {
  if(isDefined(ent) && isDefined(ent.script_noteworthy) && isstartstr(ent.script_noteworthy, "train_") && !isDefined(self getlinkedparent())) {
    if(isDefined(self.trainent)) {
      if(self.trainent == ent) {
        return;
      } else {
        cancelchecklinktotrain();
      }
    }

    self.trainent = ent;
    self.traincylestolink = 4;
    thread checklinktotraininternal(ent);
  }
}

function checklinktotraininternal(ent) {
  self endon("death");
  self endon("cancel_link_to_train");
  ent endon("death");
  leveldata = getleveldata(self.cratetype);
  contents = create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
  ignorelist = [self];

  foreach(linkedent in self getlinkedchildren(1)) {
    ignorelist[ignorelist.size] = linkedent;
  }

  self.traintracefails = 0;
  self.traintracesuccesses = 0;

  while(self.traintracefails < 20) {
    caststart = self.origin + anglestoup(self.angles) * leveldata.halfheight;
    castend = caststart + (0, 0, -200);
    traceresult = scripts\engine\trace::ray_trace(caststart, castend, ignorelist, contents);

    if(traceresult.size > 0 && isDefined(traceresult["entity"]) && scripts\cp_mp\utility\train_utility::is_train_ent(traceresult["entity"])) {
      traintracerelpos = combineangles(invertangles(ent.angles), ent.origin - traceresult["position"]);

      if(!isDefined(self.traintracerelpos)) {} else if(distancesquared(traintracerelpos, self.traintracerelpos) > 100) {
        self.traintracefails++;
        self.traintracesuccesses = 0;
      } else {
        self.traintracesuccesses++;

        if(self.traintracesuccesses >= 4) {
          self linkTo(ent);
          activatecrate(self.isfirstactivation);
          thread cratephysicsoff();
          break;
        }
      }

      self.traintracerelpos = traintracerelpos;
    } else {
      break;
    }

    wait 0.1;
  }

  thread cancelchecklinktotrain();
}

function cancelchecklinktotrain() {
  self notify("cancel_link_to_train");
  self.trainent = undefined;
  self.traintracerelpos = undefined;
  self.traintracefails = undefined;
  self.traintracesuccesses = undefined;
}

function airdrop_crushchicken(chicken) {
  self endon("death");
  crushtime = gettime();

  while(gettime() - crushtime < 3000) {
    chicken dodamage(100, chicken.origin, self, self, "MOD_CRUSH");
    wait 0.5;
  }
}

function monitorimpactend() {
  if(!istrue(self.monitoringimpact)) {
    return;
  }

  self notify("monitorImpactEnd");
  self.monitoringimpact = undefined;
  self stoploopsound("mp_care_package_drop_lp");
  self physics_unregisterforcollisioncallback();
}

function impactshoulddestroyent(entity) {
  if(!istrue(self.physicssettled)) {
    if(isDefined(entity.classname)) {
      if(entity.classname == "worldSpawn") {
        return false;
      } else if(entity.classname == "script_vehicle") {
        return true;
      } else if(entity.classname == "misc_turret") {
        return true;
      } else if(issubstr(entity.classname, "scriptable_")) {
        return true;
      } else if(entity.classname == "script_model") {
        return true;
      }
    }
  }

  return false;
}

function monitorplayerimpact() {
  monitorplayerimpactend();
  self endon("death");
  self endon("monitorPlayerImpactEnd");
  pushent = self;

  if(isDefined(self.mountmantlemodel)) {
    pushent = self.mountmantlemodel;
  }

  damageent = undefined;

  if(isDefined(self.owner)) {
    damageent = self.owner;
  }

  while(isDefined(pushent)) {
    pushent waittill("player_pushed", player, linearvelocity);

    if(isDefined(player) && (isPlayer(player) || isagent(player)) && player scripts\cp_mp\utility\player_utility::_isalive()) {
      isfalling = linearvelocity[2] <= -8;
      isaboveplayer = 0;
      playerposition = undefined;

      if(player tagexists("j_mainroot")) {
        playerposition = player gettagorigin("j_mainroot");
        leveldata = getleveldata(self.cratetype);
        midpoint = self.origin + anglestoup(self.angles) * leveldata.halfheight;
        isaboveplayer = playerposition[2] <= midpoint[2];
      }

      if(isfalling && isaboveplayer) {
        eattacker = damageent;

        if(!isDefined(eattacker)) {
          eattacker = player;
        }
      }
    }
  }
}

function monitorplayerimpactend() {
  self notify("monitorPlayerImpactEnd");
}

function playimpactfx(position, normal, impulse, surfacetype) {
  if(surfacetype != "glass_pane") {
    var_64eb7ced98f907bd = "airdrop_crate_impact_ground";

    if(surfacetype == "water") {
      var_64eb7ced98f907bd = "airdrop_crate_impact_water";
      self playsurfacesound("mp_care_package_impact_water_body", surfacetype);
    } else if(impulse < 175) {
      self playsurfacesound("mp_care_package_low_impact", surfacetype);
    } else if(impulse < 350) {
      self playsurfacesound("mp_care_package_med_impact", surfacetype);
    } else {
      self playsurfacesound("mp_care_package_high_impact", surfacetype);
    }

    playFX(getfx(var_64eb7ced98f907bd), position, normal);
  }

  self stoploopsound("mp_care_package_drop_lp");
}

function createdangerzone() {
  if(issharedfuncdefined("game", "lpcFeatureGated") && [[getsharedfunc("game", "lpcFeatureGated")]]()) {
    return;
  }

  if(!issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    return;
  }

  destroydangerzone();
  leveldata = getleveldata(self.cratetype);
  dangerzoneid = undefined;

  if(isDefined(self.markerposition)) {
    if(isDefined(self.owner) && isDefined(self.team)) {
      dangerzoneid = [[getsharedfunc("spawn", "addSpawnDangerZone")]](self.markerposition, leveldata.dangerzoneradius, leveldata.dangerzoneheight, self.team, 30, self.owner, 1);
    } else if(isDefined(self.team)) {
      dangerzoneid = [[getsharedfunc("spawn", "addSpawnDangerZone")]](self.markerposition, leveldata.dangerzoneradius, leveldata.dangerzoneheight, self.team, 30);
    } else {
      dangerzoneid = spawnuniversaldangerzone(self.markerposition, leveldata.dangerzoneradius, leveldata.dangerzoneheight, 30);
    }

    thread scripts\cp_mp\utility\debug_utility::drawsphere(self.markerposition, 128, 30, (1, 0, 0));
  }

  self.dangerzoneid = dangerzoneid;
  return dangerzoneid;
}

function spawnuniversaldangerzone(position, radius, height, timeout) {
  if(issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    dangerzoneid = [[getsharedfunc("spawn", "addSpawnDangerZone")]](position, radius, height, undefined, timeout, level.players[randomint(level.players.size)], 1);
    self.dangerzoneid = dangerzoneid;
    return dangerzoneid;
  }
}

function destroydangerzone() {
  if(issharedfuncdefined("spawn", "isSpawnDangerZoneAlive") && issharedfuncdefined("spawn", "removeSpawnDangerZone")) {
    dangerzoneid = self.dangerzoneid;

    if(isDefined(dangerzoneid) && [[getsharedfunc("spawn", "isSpawnDangerZoneAlive")]](dangerzoneid)) {
      [[getsharedfunc("spawn", "removeSpawnDangerZone")]](dangerzoneid);
    }

    self.dangerzoneid = undefined;
  }
}

function _createnavobstacle() {
  self notify("createNavObstacle");
  self endon("createNavObstacle");

  if(isDefined(self.navobstacleid)) {
    destroynavobstacle(self.navobstacleid);
  }

  leveldata = getleveldata(self.cratetype);
  navobstacleid = createnavobstaclebybounds(self.origin, leveldata.navobstaclebounds, self.angles);
  self.navobstacleid = navobstacleid;
  childthread _watchnavobstacle(navobstacleid, self.origin, leveldata.navobstacleupdatedistsqr);
  return navobstacleid;
}

function _watchnavobstacle(id, origin, updatedistsqr) {
  self endon("death");

  while(distancesquared(origin, self.origin) < updatedistsqr) {
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
  leveldata = getleveldata(self.cratetype);

  if(isDefined(leveldata.mountmantlemodel)) {
    if(isDefined(self.mountmantlemodel)) {
      self.mountmantlemodel delete();
    }

    mountmantlemodel = spawn("script_model", self.origin);
    mountmantlemodel dontinterpolate();
    mountmantlemodel.angles = self.angles;
    mountmantlemodel.owner = self.owner;
    mountmantlemodel.unresolved_collision_func = &crateunresolvedcollisioncallback;
    mountmantlemodel.killcament = self.killcament;
    mountmantlemodel.mountmantlemodel = 1;
    mountmantlemodel.unresolved_collision_notify_min = 1;
    mountmantlemodel clonebrushmodeltoscriptmodel(level.cratedata.mountmantlemodel);
    mountmantlemodel linkTo(self);
    self.mountmantlemodel = mountmantlemodel;
    mountmantlemodel.crate = self;
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

function crateunresolvedcollisioncallback(hitent, penetration) {
  assertex(isDefined(level.cratedata), "crateUnresolvedCollisionCallback() called before initCrateData().");

  if(level.cratedata.unresolvedcollisiontolerancesqr > 0) {
    if(lengthsquared(penetration) <= level.cratedata.unresolvedcollisiontolerancesqr) {
      return;
    }
  }

  objweapon = self.objweapon;

  if(isDefined(self.create)) {
    objweapon = self.crate.objweapon;
  }

  hitent dodamage(1000, hitent.origin, self.owner, self, "MOD_CRUSH", objweapon);
  self endon("death");
  hitent endon("death_or_disconnect");

  if(isPlayer(hitent) && hitent scripts\cp_mp\utility\player_utility::_isalive()) {
    if(issharedfuncdefined("airdrop", "unresolvedCollisionNearestNode")) {
      [[getsharedfunc("airdrop", "unresolvedCollisionNearestNode")]](hitent, undefined, self);
    }
  }
}

function _createheadicon() {
  if(istrue(self.disallowheadiconid)) {
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  leveldata = getleveldata(self.cratetype);
  headiconid = undefined;

  if(isDefined(self.headicon)) {
    headiconoffset = function_c857ac89588adf6f();

    if(level.teambased && isDefined(self.team)) {
      if(!scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
        headiconid = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.team, self.headicon, headiconoffset, 1, leveldata.headicondrawrange, leveldata.headiconnaturalrange, undefined, 1);
      }

      if(isDefined(headiconid)) {
        if(issharedfuncdefined("game", "isMLGMatch")) {
          if([[getsharedfunc("game", "isMLGMatch")]]()) {
            addteamtoheadiconmask(headiconid, "spectator");
          }
        }
      }
    } else if(isDefined(self.owner)) {
      if(!scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
        headiconid = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.owner, self.headicon, headiconoffset, 1, leveldata.headicondrawrange, leveldata.headiconnaturalrange, undefined, 1);
      }

      if(isDefined(headiconid)) {
        if(issharedfuncdefined("game", "isMLGMatch")) {
          if([[getsharedfunc("game", "isMLGMatch")]]()) {
            addteamtoheadiconmask(headiconid, "spectator");
          }
        }
      }
    } else if(!scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
      headiconid = scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.teamnamelist, self.headicon, headiconoffset, 1, leveldata.headicondrawrange, leveldata.headiconnaturalrange);
    }
  }

  self.headiconid = headiconid;
  self.headiconactive = 1;
  return headiconid;
}

function _destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.headiconactive = 0;
  waitframe();
}

function function_3a065ce769b6ce3d() {
  if(isDefined(self.scriptedobjid)) {
    objective_delete(self.scriptedobjid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.scriptedobjid);
    self.scriptedobjid = undefined;
    return;
  }

  if(self isscriptable() && self getscriptablehaspart("objective")) {
    self setscriptablepartstate("objective", "inactive");
    self.objectivevisible = undefined;
  }
}

function createminimapicon() {
  destroyminimapicon();
  leveldata = getleveldata(self.cratetype);
  minimapid = undefined;

  if(isDefined(self.minimapicon) && !istrue(self.visibilitymanuallycontrolled)) {
    createfunc = undefined;

    if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
      createfunc = scripts\engine\utility::getsharedfunc("game", "createObjective");
    }

    if(isDefined(createfunc)) {
      if(level.teambased && isDefined(self.team)) {
        minimapid = self[[createfunc]](self.minimapicon, undefined, 1, 1);
      } else if(isDefined(self.owner)) {
        minimapid = self[[createfunc]](self.minimapicon, undefined, 1, 1);
      } else {
        minimapid = self[[createfunc]](self.minimapicon, undefined, 0, 1);
      }
    }
  }

  scripts\mp\objidpoolmanager::function_79a1a16de6b22b2d(minimapid, 24);
  self.minimapid = minimapid;
  self.minimapiconactive = 1;
  return minimapid;
}

function destroyminimapicon() {
  if(isDefined(self.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }
  }

  self.minimapid = undefined;
  self.minimapiconactive = 0;
}

function looselinkTo(parent, offset, instancedata) {
  self endon("death");
  parent endon("death");
  self notify("looseLinkTo");
  self endon("looseLinkToEnd");

  while(istrue(self.physicsactivated)) {
    self.origin = parent.origin + offset;
    waitframe();
  }

  self linkTo(parent);
}

function addtolists() {
  assertex(isDefined(level.cratedata), "addToLists() called before initCrateData().");
  level.cratedata.crates[self getentitynumber()] = self;
}

function removefromlists(id) {
  if(!isDefined(level.cratedata)) {
    return;
  }

  level.cratedata.crates[id] = undefined;
}

function getrandomkeyfromweightsarray(arr, exclusionlist) {
  if(isDefined(exclusionlist)) {
    if(!isarray(exclusionlist)) {
      exclusionlist = [exclusionlist];
    }
  }

  arrkeys = [];
  var_6fb7daf6138d07d0 = [];
  maxval = 0;

  foreach(key, weight in arr) {
    if(weight > 0) {
      isexcluded = 0;

      if(isDefined(exclusionlist)) {
        if(exclusionlist.size > 0) {
          foreach(excludedkey in exclusionlist) {
            if(excludedkey == key) {
              exclusionlist[id] = undefined;
              isexcluded = 1;
              break;
            }
          }
        } else {
          exclusionlist = undefined;
        }
      }

      if(!isexcluded) {
        maxval += weight;
        arrkeys[arrkeys.size] = key;
        var_6fb7daf6138d07d0[var_6fb7daf6138d07d0.size] = maxval;
      }
    }
  }

  randint = randomint(maxval);
  key = undefined;

  for(i = 0; i < arrkeys.size; i++) {
    maxval = var_6fb7daf6138d07d0[i];

    if(randint < maxval) {
      key = arrkeys[i];
      break;
    }
  }

  return key;
}

function getdefaultcapturevisualscallback() {
  return &defaultcapturevisualscallback;
}

function getdefaultcapturevisualsdeletiondelay() {
  return getanimlength(%mp_military_carepackage_straps_falling) + 1;
}

function defaultcapturevisualscallback(model) {
  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.isdummyarmcrate)) {
    return;
  }

  if(!isDefined(model)) {
    return;
  }

  animtime = getanimlength(%mp_military_carepackage_straps_falling);

  if(isDefined(animtime)) {
    animtime = max(0, animtime);
  }

  model.animname = "care_package";
  model scripts\common\anim::setanimtree();
  model thread scripts\common\anim::anim_single_solo(model, "care_package_capture");
  model setscriptablepartstate(#"capture", #"start", 0);

  if(isDefined(animtime)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(animtime);
  }

  cratetype = model.cratetype;
  capturestate = #"fade";

  if(istrue(self.inwater)) {
    capturestate = #"fade_water";
  }

  model setscriptablepartstate(#"capture", capturestate, 0);
  model setscriptablepartstate(#"visibility", #"hide", 0);
}

function getdefaultdestroyvisualsdeletiondelay() {
  return false;
}

function getdefaultdestroyvisualscallback() {
  return &defaultdestroyvisualscallback;
}

function defaultdestroyvisualscallback(model) {}

function getdefaultmountmantlemodel() {
  return level.cratedata.mountmantlemodel;
}

function getnumdroppedcrates() {
  if(!isDefined(level.cratedata)) {
    return 0;
  }

  return level.cratedata.crates.size;
}

function trackcratemantlingexploit() {
  if(!isDefined(self.entmantlingendtime)) {
    if(self ismantling()) {
      entmantling = self getmovingplatformparent();

      if(isDefined(entmantling) && isDefined(entmantling.crate)) {
        self.entmantling = entmantling;
        self.entmantlingcrate = entmantling.crate;
      }

      self.entmantlingendtime = gettime() + 1000;
    }

    return;
  }

  if(gettime() >= self.entmantlingendtime) {
    self.entmantling = undefined;
    self.entmantlingcrate = undefined;
    self.entmantlingendtime = undefined;
    return;
  }

  foreach(crate in level.cratedata.crates) {
    if(isDefined(crate) && istrue(crate.physicsactivated) && !istrue(crate.physicssettled)) {
      if(isDefined(self.entmantling)) {
        if(isDefined(crate.mountmantlemodel)) {
          if(self.entmantling != crate.mountmantlemodel) {
            if(self istouching(crate.mountmantlemodel)) {
              self.entmantling = undefined;
              self.entmantlingcrate = undefined;
              self.entmantlingendtime = undefined;

              if(issharedfuncdefined("damage", "_suicide")) {
                self thread[[getsharedfunc("damage", "_suicide")]]();
                return;
              }

              self suicide();
              return;
            }
          }
        }

        if(self.entmantlingcrate != crate) {
          if(self istouching(crate)) {
            self.entmantling = undefined;
            self.entmantlingcrate = undefined;
            self.entmantlingendtime = undefined;

            if(issharedfuncdefined("damage", "_suicide")) {
              self thread[[getsharedfunc("damage", "_suicide")]]();
              return;
            }

            self suicide();
            return;
          }
        }

        continue;
      }

      if(self istouching(crate) || isDefined(crate.mountmantlemodel) && self istouching(crate.mountmantlemodel)) {
        self.entmantling = undefined;
        self.entmantlingcrate = undefined;
        self.entmantlingendtime = undefined;

        if(issharedfuncdefined("damage", "_suicide")) {
          self thread[[getsharedfunc("damage", "_suicide")]]();
          return;
        }

        self suicide();
        return;
      }
    }
  }
}

function overridecapturestring(stringoverride) {
  assertex(isDefined(stringoverride), "overrideCrateCaptureString() requires a stringOverride.");

  if(isDefined(self.capturestring) && self.capturestring == stringoverride) {
    return;
  }

  self.capturestring = stringoverride;
  triggerobjects = [self];

  if(isDefined(self.useobject)) {
    triggerobjects[triggerobjects.size] = self.useobject;
  }

  foreach(triggerobject in triggerobjects) {
    if(!self.supportsreroll || triggerobject.usetype == 2) {
      triggerobject setHintString(self.capturestring);
    }
  }
}

function overridererollstring(stringoverride) {
  assertex(isDefined(stringoverride), "overrideCrateRerollString() requires a stringOverride.");

  if(isDefined(self.rerollstring) && self.rerollstring == stringoverride) {
    return;
  }

  self.rerollstring = stringoverride;
  triggerobjects = [self];

  if(isDefined(self.useobject)) {
    triggerobjects[triggerobjects.size] = self.useobject;
  }

  foreach(triggerobject in triggerobjects) {
    if(self.supportsreroll && triggerobject.usetype == 1) {
      triggerobject setHintString(self.rerollstring);
    }
  }
}

function overrideheadicon(iconoverride) {
  if(!isDefined(self.headicon) && !isDefined(iconoverride)) {
    return;
  }

  if(isDefined(self.headicon) && isDefined(iconoverride) && self.headicon == iconoverride) {
    return;
  }

  if(!isDefined(iconoverride)) {
    self.headicon = undefined;
    _destroyheadicon();
    return;
  }

  self.headicon = iconoverride;

  if(self.headiconactive) {
    if(isDefined(self.headiconid)) {
      setheadiconimage(self.headiconid, iconoverride);
      return;
    }

    _createheadicon();
  }
}

function overrideminimapicon(iconoverride) {
  if(!isDefined(self.minimapicon) && !isDefined(iconoverride)) {
    return;
  }

  if(isDefined(self.minimapicon) && isDefined(iconoverride) && self.minimapicon == iconoverride) {
    return;
  }

  if(!isDefined(iconoverride)) {
    self.minimapicon = undefined;
    destroyminimapicon();
    return;
  }

  self.minimapicon = iconoverride;

  if(self.minimapiconactive) {
    if(isDefined(self.minimapid)) {
      scripts\mp\objidpoolmanager::update_objective_icon(self.minimapid, iconoverride);
      return;
    }

    createminimapicon();
  }
}

function overridesupportsreroll(booloverride) {
  assertex(isDefined(booloverride), "overrideSupportsReroll() requires a boolOverride.");

  if(self.supportsreroll == booloverride) {
    return;
  }

  self.supportsreroll = booloverride;

  if(self.supportsreroll) {
    triggerobjects = [self];

    if(isDefined(self.useobject)) {
      triggerobjects[triggerobjects.size] = self.useobject;
    }

    foreach(triggerobject in triggerobjects) {
      if(triggerobject.usetype == 1) {
        triggerobject setHintString(self.rerollstring);
      }
    }
  }
}

function initkillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  activatecallback = &killstreakcrateactivatecallback;
  capturecallback = &killstreakcratecapturecallback;
  leveldata = getleveldata("killstreak");
  leveldata.activatecallback = activatecallback;
  leveldata.capturecallback = capturecallback;

  if(scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e()) {
    leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
  }

  leveldata = getleveldata("killstreak_no_owner");
  leveldata.activatecallback = activatecallback;
  leveldata.capturecallback = capturecallback;
  leveldata.supportsownercapture = 0;
  bundle = level.streakglobals.streakbundles["airdrop"];

  if(!isDefined(bundle) || !istrue(bundle.var_819ed648a31d2d61)) {
    addkillstreakcratedata("assault_drone", undefined, undefined, 300);
    addkillstreakcratedata("uav", undefined, undefined, 300);
    addkillstreakcratedata("cluster_spike", undefined, undefined, 300);
    addkillstreakcratedata("scrambler_drone_guard", undefined, undefined, 300);
    addkillstreakcratedata("switchblade_drone", undefined, undefined, 300);
    addkillstreakcratedata("cruise_predator", undefined, undefined, 150);
    addkillstreakcratedata("toma_strike", undefined, undefined, 150);
    addkillstreakcratedata("precision_airstrike", undefined, undefined, 150);
    addkillstreakcratedata("sentry_gun", undefined, undefined, 150);
    addkillstreakcratedata("remote_turret", undefined, undefined, 150);
    addkillstreakcratedata("lrad", undefined, undefined, 150);
    addkillstreakcratedata("fuel_airstrike", undefined, undefined, 100);
    addkillstreakcratedata("hover_jet", undefined, undefined, 100);
    addkillstreakcratedata("airdrop_escort", undefined, undefined, 100);
    addkillstreakcratedata("pac_sentry", undefined, undefined, 100);
    addkillstreakcratedata("loitering_munition", undefined, undefined, 100);
    addkillstreakcratedata("juggernaut_recon", undefined, undefined, 100);
    addkillstreakcratedata("ims", undefined, undefined, 100);
    addkillstreakcratedata("auto_drone", undefined, undefined, 50);
    addkillstreakcratedata("chopper_gunner", undefined, undefined, 50);
    addkillstreakcratedata("directional_uav", undefined, undefined, 25);
    addkillstreakcratedata("gunship", undefined, undefined, 25);
    addkillstreakcratedata("juggernaut", undefined, undefined, 10);
    return;
  }

  foreach(crateentry in bundle.crateentries) {
    if(isDefined(crateentry.name) && isDefined(crateentry.weight)) {
      addkillstreakcratedata(crateentry.name, undefined, undefined, crateentry.weight);
    }
  }
}

function initdropzonekillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  activatecallback = &killstreakcrateactivatecallback;
  capturecallback = &killstreakcratecapturecallback;
  leveldata = getleveldata("killstreak");
  leveldata.activatecallback = activatecallback;
  leveldata.capturecallback = capturecallback;
  leveldata = getleveldata("killstreak_no_owner");
  leveldata.activatecallback = activatecallback;
  leveldata.capturecallback = capturecallback;
  leveldata.supportsownercapture = 0;
  addkillstreakcratedata("assault_drone", undefined, undefined, 300);
  addkillstreakcratedata("uav", undefined, undefined, 300);
  addkillstreakcratedata("cluster_spike", undefined, undefined, 300);
  addkillstreakcratedata("scrambler_drone_guard", undefined, undefined, 300);
  addkillstreakcratedata("switchblade_drone", undefined, undefined, 300);
  addkillstreakcratedata("cruise_predator", undefined, undefined, 150);
  addkillstreakcratedata("toma_strike", undefined, undefined, 150);
  addkillstreakcratedata("precision_airstrike", undefined, undefined, 150);
  addkillstreakcratedata("sentry_gun", undefined, undefined, 150);
  addkillstreakcratedata("remote_turret", undefined, undefined, 150);
  addkillstreakcratedata("lrad", undefined, undefined, 150);
  addkillstreakcratedata("fuel_airstrike", undefined, undefined, 100);
  addkillstreakcratedata("hover_jet", undefined, undefined, 100);
  addkillstreakcratedata("airdrop_escort", undefined, undefined, 100);
  addkillstreakcratedata("pac_sentry", undefined, undefined, 100);
  addkillstreakcratedata("loitering_munition", undefined, undefined, 100);
  addkillstreakcratedata("juggernaut_recon", undefined, undefined, 100);
  addkillstreakcratedata("ims", undefined, undefined, 100);
  addkillstreakcratedata("auto_drone", undefined, undefined, 50);
  addkillstreakcratedata("chopper_gunner", undefined, undefined, 50);
  addkillstreakcratedata("directional_uav", undefined, undefined, 25);
  addkillstreakcratedata("gunship", undefined, undefined, 25);
  addkillstreakcratedata("juggernaut", undefined, undefined, 10);

  if(level.gametype == "infect") {
    leveldata.isteamonlycrate = 1;
    return;
  }

  addkillstreakcratedata("scrambler_drone_guard", undefined, undefined, 300);
}

function addkillstreakcratedata(streakname, capturestring, rerollstring, weight) {
  if(!isDefined(level.streakglobals.streakbundles[streakname])) {
    return;
  }

  level.cratedata.kscapturestrings[streakname] = capturestring;
  level.cratedata.ksrerollstrings[streakname] = rerollstring;
  level.cratedata.ksweights[streakname] = weight;
}

function getkillstreakcratedatabystreakname(streakname, supportsreroll) {
  data = spawnStruct();
  data.streakname = streakname;
  data.supportsreroll = supportsreroll;
  return data;
}

function overridekillstreakcrateweight(streakname, weightoverride) {
  assertex(isDefined(level.cratedata), "overrideKillstreakCrateWeight() called before initCrateData().");
  assertex(isDefined(level.cratedata.ksweights), "overrideKillstreakCrateWeight() called before initKillstreakCrateData().");
  assertex(isDefined(level.cratedata.ksweights), "overrideKillstreakCrateWeight() called with an invalid streakName.");
  level.cratedata.ksweights[streakname] = weightoverride;
}

function killstreakcrateactivatecallback(isfirstactivation) {
  data = self.data;
  capturestring = level.cratedata.kscapturestrings[data.streakname];

  if(isDefined(capturestring)) {
    overridecapturestring(capturestring);
  }

  rerollstring = level.cratedata.ksrerollstrings[data.streakname];

  if(isDefined(rerollstring)) {
    overridererollstring(rerollstring);
  }

  supportsreroll = data.supportsreroll;

  if(isDefined(supportsreroll)) {
    overridesupportsreroll(supportsreroll);
  }
}

function killstreakcratecapturecallback(player) {
  streakname = self.data.streakname;
  useimmediate = 0;
  var_63bb25760a7f230d = 0;

  switch (streakname) {
    case #"hash_cd0a0403551fc411":
      var_63bb25760a7f230d = 1;
    case #"hash_4ad475e6e15635bd":
      if(!istrue(player.isjuggernaut)) {
        useimmediate = 1;

        if(issharedfuncdefined("airdrop", "applyImmediateJuggernaut")) {
          player[[getsharedfunc("airdrop", "applyImmediateJuggernaut")]](useimmediate, var_63bb25760a7f230d);
        } else if(istrue(var_63bb25760a7f230d)) {
          player scripts\killstreaks\juggernaut_recon::function_b960491329678b4(useimmediate);
        } else {
          player scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(useimmediate);
        }
      }

      break;
  }

  if(!istrue(useimmediate)) {
    if(issharedfuncdefined("airdrop", "awardKillstreak")) {
      player thread[[getsharedfunc("airdrop", "awardKillstreak")]](streakname, self.owner, self);
    }

    if(issharedfuncdefined("airdrop", "showKillstreakSplash")) {
      player[[getsharedfunc("airdrop", "showKillstreakSplash")]](streakname, undefined, 1);
    }
  }

  if(isDefined(self.owner) && player == self.owner) {
    return;
  }

  if(isDefined(self.team)) {
    if(player.team != self.team) {
      if(issharedfuncdefined("player", "doScoreEvent")) {
        player[[getsharedfunc("player", "doScoreEvent")]]("hijacker");
      }

      if(isDefined(self.owner)) {
        if(issharedfuncdefined("hud", "showSplash")) {
          self.owner[[getsharedfunc("hud", "showSplash")]]("hijacked_airdrop", undefined, player);
        }
      }
    }
  }
}

function getrandomkillstreak(var_52a8c1bddbf44d11) {
  assertex(isDefined(level.cratedata), "getRandomKillstreak() called before initCrateData().");
  assertex(isDefined(level.cratedata.ksweights), "getRandomKillstreak() called before initKillstreakCrateData().");
  streakname = getrandomkeyfromweightsarray(level.cratedata.ksweights, var_52a8c1bddbf44d11);
  return streakname;
}

function placekillstreakcrate(owner, team, streakname, position, angles) {
  if(!isDefined(streakname) || streakname == "random") {
    streakname = getrandomkillstreak();
  }

  cratetype = isDefined(owner) ? "killstreak" : "killstreak_no_owner";
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  crate = placecrate(owner, team, cratetype, position, angles, cratedropdata);

  if(!isDefined(crate)) {
    return undefined;
  }

  if(isDefined(owner)) {
    if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", owner);
    }
  }

  return crate;
}

function dropkillstreakcrate(owner, team, streakname, position, angles, destination) {
  if(!isDefined(streakname) || streakname == "random") {
    streakname = getrandomkillstreak();
  }

  cratetype = isDefined(owner) ? "killstreak" : "killstreak_no_owner";
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  crate = dropcrate(owner, team, cratetype, position, angles, destination, cratedropdata);

  if(!isDefined(crate)) {
    return undefined;
  }

  if(isDefined(owner)) {
    if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", owner);
    }
  }

  return crate;
}

function dropkillstreakcratefromscriptedheli(owner, team, streakname, position, angles, destination, vehicleisreserved, streakinfo) {
  if(!isDefined(streakname) || streakname == "random") {
    streakname = getrandomkillstreak();
  }

  cratetype = isDefined(owner) ? "killstreak" : "killstreak_no_owner";
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  cratedropdata.vehicleisreserved = vehicleisreserved;
  scenenode = dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, cratedropdata, streakinfo);

  if(!isDefined(scenenode)) {
    return undefined;
  } else if(!isDefined(scenenode.crates) || !isDefined(array_get_first_item(scenenode.crates))) {
    return undefined;
  }

  if(isDefined(owner)) {
    owner thread airdrop_playdeploydialog(streakinfo);

    if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", owner);
    }
  }

  return scenenode;
}

function airdrop_playdeploydialog(streakinfo) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(level.gametype == "grnd" || level.gametype == "infect") {
    return;
  }

  var_52a5be2e2f91d710 = undefined;

  if(issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
    [[getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    var_52a5be2e2f91d710 = 3;
  }

  operatordialog = streakinfo.streakname + "_use";
  thread playkillstreakoperatordialog(streakinfo.streakname, operatordialog, 1, var_52a5be2e2f91d710);
}

function dropkillstreakcratefrommanualheli(owner, team, streakname, position, angles, destination, vehicleisreserved) {
  if(!isDefined(streakname) || streakname == "random") {
    streakname = getrandomkillstreak();
  }

  cratetype = isDefined(owner) ? "killstreak" : "killstreak_no_owner";
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  cratedropdata.vehicleisreserved = vehicleisreserved;
  dropstruct = dropcratefrommanualheli(owner, team, cratetype, position, angles, 30000, 30000, destination, cratedropdata);

  if(!isDefined(dropstruct)) {
    return undefined;
  } else if(!isDefined(dropstruct.crate)) {
    return undefined;
  }

  if(isDefined(owner)) {
    if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", owner);
    }
  }

  return dropstruct.crate;
}

function tryairdroptriggered(streakinfo) {
  streakname = streakinfo.streakname;
  droptype = streakname;
  result = undefined;

  if(!isDefined(droptype)) {
    droptype = "airdrop";
  }

  var_f7d941fb76fd8044 = level.littlebirds.size;
  maxvehiclecount = 4;

  if(islargemap()) {
    maxvehiclecount = 10;
  }

  if(streakname == "airdrop_escort") {
    var_f7d941fb76fd8044 = level.cratedropdata.escortchoppers.size;
    maxvehiclecount = 1;
  }

  var_4440147083abaf0a = 1;

  if((var_f7d941fb76fd8044 >= maxvehiclecount || level.fauxvehiclecount >= maxvehiclecount) && droptype != "airdrop_mega") {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_AIRDROPS");
    }

    return false;
  } else if(issharedfuncdefined("killstreak", "currentActiveVehicleCount") && issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + var_4440147083abaf0a >= [[getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
      }

      return false;
    }
  }

  return true;
}

function airdropmarkerswitchended(streakinfo, switchresult) {
  if(istrue(switchresult)) {
    thread airdrop_watchplayerweapon(streakinfo);
  }
}

function airdrop_watchplayerweapon(streakinfo) {
  self endon("disconnect");

  if(!isbot(self)) {
    self notifyonplayercommand("cancel_deploy", "+actionslot 3");
    self notifyonplayercommand("cancel_deploy", "+actionslot 4");
    self notifyonplayercommand("cancel_deploy", "+actionslot 5");
    self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  }

  result = waittill_any_return_2("cancel_deploy", "weapon_switch_started");

  if(!isDefined(result)) {
    return;
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
}

function airdropvisualmarkerfired(streakinfo) {
  streakinfo.airdroptype = streakinfo.streakname;

  if(issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  marker = undefined;

  if(issharedfuncdefined("airdrop", "getTargetMarker")) {
    marker = self[[getsharedfunc("airdrop", "getTargetMarker")]](streakinfo);
  }

  if(!isDefined(marker.location)) {
    if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return false;
  }

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.airdroptype, self.origin);
  }

  airdropvisualmarkeractivate(marker, streakinfo.airdroptype, streakinfo);
  return true;
}

function airdropvisualmarkeractivate(marker, droptype, streakinfo) {
  fxposition = drop_to_ground(marker.location, 50, -200, (0, 0, 1));
  fxposition += (0, 0, 1);
  canister = spawn("script_model", fxposition);
  canister setModel("offhand_wm_grenade_smoke");
  canister.angles = (0, 90, 90);
  fxent = spawn("script_model", fxposition);
  fxent setModel("ks_crate_marker_mp");
  fxent setscriptablepartstate(#"smoke", #"on", 0);

  if(isDefined(marker.visual)) {
    marker.visual delete();
  }

  assertmsg("doFlyBy() no longer supported. See airdrop.gsc for new drop methods");
}

function tryuseairdropmarker() {
  streakinfo = createstreakinfo("airdrop", self);
  return tryuseairdropmarkerfromstruct(streakinfo);
}

function tryuseairdropmarkerfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  streakinfo.deployweaponobj = makeweapon("deploy_airdrop_mp");
  sticky = getdvarint(@ "hash_b2e9bf0017ceeeae", 0);

  if(sticky) {
    streakinfo.deployweaponobj = makeweapon("deploy_airdrop_sticky_mp");
  }

  var_2472cbe64ade0c46 = undefined;

  switch (streakinfo.streakname) {
    case #"hash_2289ec11d77bce8f":
    case #"hash_56979e0566996b2e":
    case #"hash_887ad77192b9c4fb":
      var_2472cbe64ade0c46 = 1;
      break;
    default:
      var_2472cbe64ade0c46 = 0;
      break;
  }

  if(var_2472cbe64ade0c46) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      return false;
    }
  }

  if(!tryairdroptriggered(streakinfo)) {
    if(var_2472cbe64ade0c46) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    return false;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      if(var_2472cbe64ade0c46) {
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      }

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        self[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      return false;
    }
  }

  if(isDefined(level.var_27f78817b59dfe32)) {
    streakinfo.var_fb58a31c756db4cc = level.var_27f78817b59dfe32;
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, streakinfo.deployweaponobj, "grenade_fire", undefined, &airdropmarkerswitchended, &airdropmarkerfired, undefined, &airdropmarkertaken);

  if(!istrue(deployresult)) {
    if(var_2472cbe64ade0c46) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    }

    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  return true;
}

function function_f66b707d0894b6de(streakinfo) {
  self endon("death_or_disconnect");
  self endon("giveAndFireOffhandReliableFailed");
  level endon("game_ended");
  deployweaponobj = streakinfo.deployweaponobj;

  while(true) {
    self waittill("grenade_thrown", grenade);

    if(isDefined(deployweaponobj.basename) && isDefined(grenade.weapon_name) && deployweaponobj.basename == grenade.weapon_name) {
      airdropmarkerfired(streakinfo, deployweaponobj, grenade, 1);
      break;
    }

    iprintln("<dev string:xc2>");

    break;
  }
}

function airdropmarkerfired(streakinfo, weaponobj, projectile, gestureactivation) {
  streakinfo.airdroptype = streakinfo.streakname;

  if(issharedfuncdefined("killstreak", "incrementFauxVehicleCount")) {
    [[getsharedfunc("killstreak", "incrementFauxVehicleCount")]]();
  }

  projectile.owner = self;
  assertex(isDefined(streakinfo.airdroptype), "airDropMarkerFired() was passed a streakInfo that didn't go through tryAirdropTriggered()");
  projectile thread airdropmarkeractivate(streakinfo.airdroptype, undefined, streakinfo, gestureactivation);

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.airdroptype, self.origin);
  }

  streakinfo.airdropmarkerfired = 1;

  if(!istrue(gestureactivation)) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
  }

  return "success";
}

function airdropmarkeractivate(droptype, lifeid, streakinfo, gestureactivation) {
  level endon("game_ended");
  ownerangles = self.owner.angles;
  self waittill("explode", position);

  if(istrue(gestureactivation)) {
    level callback::callback("killstreak_finish_use", {
      #streakinfo: streakinfo
    });
  }

  owner = self.owner;

  if(!isDefined(owner)) {
    if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }

  waitframe();
  flightangles = ownerangles + (0, 180, 0);
  targetpos = position;
  targetheightoffset = getscriptedhelidropheight(droptype);
  ownerforward = anglesToForward(owner.angles);
  ownerright = anglestoright(owner.angles);
  contents = scripts\engine\trace::create_default_contents(1);
  positionchecklist = [targetpos - ownerforward * 100, targetpos + ownerforward * 100, targetpos + ownerright * 100, targetpos - ownerright * 100, targetpos + (ownerforward + ownerright) * 100, targetpos + (ownerforward - ownerright) * 100, targetpos + (ownerright - ownerforward) * 100, targetpos + (-1 * ownerforward - ownerright) * 100];

  foreach(dirpos in positionchecklist) {
    var_7a7426e42e674e40 = vectorNormalize(dirpos - targetpos);
    var_c45bbeb56df09b5d = targetpos * (1, 1, 0) + (0, 0, targetheightoffset);
    var_32a961dac02545b0 = var_c45bbeb56df09b5d - var_7a7426e42e674e40 * 25000;
    var_19189fd85d8a2c19 = var_c45bbeb56df09b5d + var_7a7426e42e674e40 * 25000;
    traceresult = scripts\engine\trace::ray_trace_passed(var_32a961dac02545b0, var_19189fd85d8a2c19, undefined, contents);

    if(!istrue(traceresult)) {
      continue;
    }

    flightangles = vectortoangles(var_7a7426e42e674e40);

    level thread scripts\cp_mp\utility\debug_utility::drawline(var_32a961dac02545b0, var_19189fd85d8a2c19, 30, (1, 1, 0));

    break;
  }

  if(droptype == "<dev string:xee>") {
    crateoverride = getDvar(@ "hash_c247993ede3808ca");

    if(crateoverride != "<dev string:x1c>") {
      if(issharedfuncdefined("<dev string:xf6>", "<dev string:xfe>")) {
        [[getsharedfunc("<dev string:xf6>", "<dev string:xfe>")]]();
      }

      dropkillstreakcratefromscriptedheli(owner, owner.team, crateoverride, position, flightangles, position, 1, streakinfo);
      return;
    }
  }

  if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  dropresult = undefined;

  if(droptype == "airdrop") {
    dropresult = dropkillstreakcratefromscriptedheli(owner, owner.team, undefined, position, flightangles, position, 1, streakinfo);
  } else if(droptype == "airdrop_multiple") {
    if(issharedfuncdefined("airdrop", "airdropMultipleDropCrates")) {
      dropresult = [[getsharedfunc("airdrop", "airdropMultipleDropCrates")]](owner, owner.team, position, flightangles, position, 1, streakinfo);
    }
  } else if(droptype == "airdrop_escort") {} else if(droptype == "loadout_drop") {
    dropresult = function_63e71231fbc15aa9(owner, owner.team, droptype, position, flightangles, position, 1, streakinfo);
  }

  if(isDefined(owner)) {
    if(!isDefined(dropresult)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        owner[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
      }

      if(isDefined(streakinfo) && isDefined(streakinfo.mpstreaksysteminfo)) {
        if(issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
          owner[[getsharedfunc("killstreak", "awardKillstreakFromStruct")]](streakinfo.mpstreaksysteminfo, "other");
        }
      }

      return;
    }

    owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
  }
}

function function_206d83d7637be6a7(position, owner) {
  if(level.teambased) {
    var_13ba232eee7e6069 = spawnscriptable("airdrop_marker", position, (0, 0, 1));
    var_13ba232eee7e6069 setscriptablepartstate("smokeSignal", "active");
    var_13ba232eee7e6069 function_fca5bdbe24070d20("smokeSignal", owner.team);
    return;
  }

  payload = [#"teamselect", owner getentitynumber()];
  var_13ba232eee7e6069 = spawnscriptable("airdrop_marker", position, (0, 0, 1), payload);
  var_13ba232eee7e6069 setscriptablepartstate("smokeSignal", "activeFFA");
}

function airdropmarkertaken(streakinfo) {
  if(istrue(streakinfo.airdropmarkerfired)) {
    level callback::callback("killstreak_finish_use", {
      #streakinfo: streakinfo
    });
  }

  if(isDefined(streakinfo.airdroptype) && !istrue(streakinfo.airdropmarkerfired)) {
    if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }
  }
}

function initbattleroyalecratedata() {
  leveldata = getleveldata("battle_royale");
  leveldata.capturestring = &"MP/BR_CRATE";
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.usepriority = -1;
  leveldata.usefov = 180;
  leveldata.timeout = undefined;
  leveldata.activatecallback = &brcrateactivatecallback;
  leveldata.capturecallback = &brcratecapturecallback;
}

function getbrcratedatabytype(type) {
  data = spawnStruct();
  data.type = type;
  return data;
}

function brcrateactivatecallback(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }
  }
}

function brcratecapturecallback(player) {
  if(issharedfuncdefined("airdrop", "makeItemsFromCrate")) {
    self[[getsharedfunc("airdrop", "makeItemsFromCrate")]](player);
  }
}

function dropbrcratefromscriptedheli(position) {
  type = ter_op(cointoss(), "weapon", "attachment");
  scenenode = dropcratefromscriptedheli(undefined, undefined, "battle_royale", position, (0, randomfloat(360), 0), position, getbrcratedatabytype(type));

  if(!isDefined(scenenode)) {
    return undefined;
  } else if(!isDefined(scenenode.crates) || !isDefined(array_get_first_item(scenenode.crates))) {
    return undefined;
  }

  return scenenode.crate;
}

function dropbrcratefrommanualheli(position) {
  type = ter_op(cointoss(), "weapon", "attachment");
  dropstruct = dropcratefrommanualheli(undefined, undefined, "battle_royale", position, (0, randomfloat(360), 0), 30000, 30000, position, getbrcratedatabytype(type));

  if(!isDefined(dropstruct)) {
    return undefined;
  } else if(!isDefined(dropstruct.crate)) {
    return undefined;
  }

  return dropstruct.crate;
}

function initbattleroyaleloadoutcratedata() {
  leveldata = getleveldata("battle_royale_loadout");
  leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
  leveldata.basemodel = "military_carepackage_01_loadout_br";
  leveldata.mountmantlemodel = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.usepriority = -1;
  leveldata.usefov = 180;
  leveldata.timeout = undefined;
  leveldata.friendlyuseonly = 1;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.activatecallback = &brloadoutcrateactivatecallback;
  leveldata.capturecallback = &brloadoutcratecapturecallback;
  leveldata.destroycallback = &brloadoutcratedestroycallback;
  leveldata.destroyoncapture = 0;
  leveldata.onecaptureperplayer = 1;
  leveldata.isdropcrate = 1;
  leveldata.var_c23ca3472233553d = 1;
}

function brloadoutcrateactivatecallback(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }

    if(issharedfuncdefined("airdrop", "brLoadoutCrateFirstActivation")) {
      [[getsharedfunc("airdrop", "brLoadoutCrateFirstActivation")]](self);
    }
  }
}

function brloadoutcratecapturecallback(player) {
  giveweaponsfromdropbag(player);
  self notify("brLoadoutCapture", player);
}

function brloadoutcratepostcapture(player) {
  if(!isDefined(self.numuses)) {
    self.numuses = 0;
  }

  if(!isDefined(self.playersused)) {
    self.playersused = [];
  }

  if(!isDefined(self.playerscaptured)) {
    self.playerscaptured = [];
  }

  self.playerscaptured[player getentitynumber()] = player;
  self.playersused[self.playersused.size] = player;
  self.numuses++;

  if(isDefined(self.playeroutlines)) {
    foreach(outlineid in self.playeroutlines) {
      if(isDefined(self.outlines) && isDefined(self.outlines[outlineid]) && isDefined(self.outlines[outlineid].playersvisibleto)) {
        if(self.outlines[outlineid].playersvisibleto.size == 1 && self.outlines[outlineid].playersvisibleto[0] == player) {
          if(issharedfuncdefined("airdrop", "outlineDisable")) {
            [[getsharedfunc("airdrop", "outlineDisable")]](outlineid, self);
          }

          self.playeroutlines = array_remove(self.playeroutlines, outlineid);
          break;
        }
      }
    }
  }

  self notify("brLoadoutPostCapture", player);

  if(istrue(self.strongholdcrate) || istrue(self.var_4cd5b8f62d173211)) {
    return;
  }

  if(self.numuses >= level.teamdata[player.team]["teamCount"]) {
    if(isDefined(self.playeroutlines)) {
      foreach(outline in self.playeroutlines) {
        if(issharedfuncdefined("airdrop", "outlineDisable")) {
          [[getsharedfunc("airdrop", "outlineDisable")]](outline, self);
        }
      }
    }

    if(isDefined(self.choosenlocation) && isDefined(self.choosenlocation.inuse)) {
      self.choosenlocation.inuse = 0;
    }

    thread destroycrate();
  }
}

function brloadoutcratedestroycallback(immediate) {
  if(issharedfuncdefined("airdrop", "brOnLoadoutCrateDestroyed")) {
    [[getsharedfunc("airdrop", "brOnLoadoutCrateDestroyed")]](immediate);
  }
}

function giveweaponsfromdropbag(player) {
  if(issharedfuncdefined("airdrop", "br_giveDropBagLoadout")) {
    [[getsharedfunc("airdrop", "br_giveDropBagLoadout")]](player);
  }
}

function dropbrloadoutcrate(team, position, destination) {
  return dropcrate(undefined, team, "battle_royale_loadout", position, (0, randomfloat(360), 0), destination);
}

function function_c5c61b985836f974() {
  leveldata = getleveldata("loadout_drop");
  leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
  leveldata.basemodel = "military_carepackage_01_loadout_mp";
  leveldata.supportsownercapture = 1;
  leveldata.headicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
  leveldata.minimapicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
  leveldata.usepriority = -1;
  leveldata.usefov = 360;
  leveldata.timeout = 60;
  leveldata.friendlyuseonly = 1;
  leveldata.maxusage = 5;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.activatecallback = &loadoutcrateactivatecallback;
  leveldata.capturecallback = &loadoutcratecapturecallback;
  leveldata.destroyoncapture = 0;
  leveldata.onecaptureperplayer = 1;
  leveldata.isteamonlycrate = 1;
}

function loadoutcrateactivatecallback(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
      [[getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
    }
  }
}

function loadoutcratecapturecallback(player) {
  if(issharedfuncdefined("airdrop", "airdropSelectLoadout")) {
    player thread[[getsharedfunc("airdrop", "airdropSelectLoadout")]](self);
  }
}

function loadoutcratepostcapture(player) {
  if(!isDefined(self.numuses)) {
    self.numuses = 0;
  }

  self.numuses++;
  leveldata = getleveldata(self.cratetype);

  if(self.numuses >= leveldata.maxusage) {
    thread destroycrate();
  }
}

function function_63e71231fbc15aa9(owner, team, streakname, position, angles, destination, vehicleisreserved, streakinfo) {
  cratetype = streakname;
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  cratedropdata.vehicleisreserved = vehicleisreserved;
  scenenode = dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, cratedropdata, streakinfo);

  if(!isDefined(scenenode)) {
    return undefined;
  } else if(!isDefined(scenenode.crates) || !isDefined(array_get_first_item(scenenode.crates))) {
    return undefined;
  }

  if(isDefined(owner)) {
    owner thread airdrop_playdeploydialog(streakinfo);
  }

  return scenenode;
}

function initbattleroyalec130airdropcratedata() {
  leveldata = getleveldata("battle_royale_c130_loot");

  if(getDvar(@ "hash_7611a2790a0bf7fe", "") == "plunder") {
    leveldata.capturestring = &"MP/DMZ_LOOT_CRATE_CAPTURE";
  } else {
    leveldata.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  }

  leveldata.basemodel = "military_carepackage_03_br";
  leveldata.mountmantlemodel = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.usepriority = -1;
  leveldata.usefov = 180;
  leveldata.timeout = 600;
  leveldata.friendlyuseonly = 1;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.activatecallback = &brc130airdropcrateactivatecallback;
  leveldata.capturecallback = &brc130airdropcratecapturecallback;
  leveldata.destroycallback = &brc130airdropcratedestroycallback;
  leveldata.cratephysicsoncallback = &brc130airdropcratephysicsoncallback;
  leveldata.destroyoncapture = 1;
  leveldata.isdropcrate = 1;
  leveldata.var_c23ca3472233553d = 1;
}

function brc130airdropcrateactivatecallback(isfirstactivation) {}

function brc130airdropcratecapturecallback(player) {
  self setscriptablepartstate(#"objective_map", #"inactive", 0);

  if(issharedfuncdefined("br_c130Airdrop", "c130Airdrop_onCrateUse")) {
    self[[getsharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse")]](player);
  }

  if(issharedfuncdefined("br_c130Airdrop", "dmzTut_crateUsed")) {
    self[[getsharedfunc("br_c130Airdrop", "dmzTut_crateUsed")]](player);
  }

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate(#"smoke_signal", #"off", 0);
    self.smokesignal delete();
  }

  if(isDefined(level.c130successfulairdrops)) {
    level.c130successfulairdrops = array_remove(level.c130successfulairdrops, self);
  }
}

function brc130airdropcratedestroycallback(immediate) {
  self setscriptablepartstate(#"objective_map", #"inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate(#"smoke_signal", #"off", 0);
    self.smokesignal delete();
  }

  if(isDefined(level.c130successfulairdrops)) {
    level.c130successfulairdrops = array_remove(level.c130successfulairdrops, self);
  }
}

function brc130airdropcratephysicsoncallback() {
  self setscriptablepartstate(#"crate_audio", #"detach", 0);
}

function dropbrc130airdropcrate(dropposition, dropdestination, dropangles, var_958bbdfed6f2e9ef, var_fe41be11a71dc1b4, nodropanim, team, var_cf11cd8c8b813faf) {
  var_dd3f2e9ec30744d5 = 250;
  var_c8ec5569be94e5c8 = level.c130airdrop_heightoverride;
  releaseoffset = 1000;
  var_55917b74a3b88b89 = 10500;
  var_843ccd48992e3408 = 7500;
  var_e0570c6b08e54443 = 3000;
  releasedestination = dropdestination + (0, 0, releaseoffset);
  droplootid = "battle_royale_c130_loot";

  if(isDefined(var_958bbdfed6f2e9ef)) {
    droplootid = var_958bbdfed6f2e9ef;
  }

  if(!isDefined(nodropanim)) {
    nodropanim = 0;
  }

  crate = createcrate(undefined, team, droplootid, dropposition, (0, 0, 0), dropdestination, undefined, 0);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;

    if(!nodropanim && releasedestination[2] < dropposition[2]) {
      animid = undefined;
      var_ff42e8ba492b161a = distance(dropposition, releasedestination);

      if(var_ff42e8ba492b161a >= var_55917b74a3b88b89) {
        animid = "brc130_drop_high";
      } else if(var_ff42e8ba492b161a >= var_843ccd48992e3408) {
        animid = "brc130_drop_med";
      } else if(var_ff42e8ba492b161a >= var_e0570c6b08e54443) {
        animid = "brc130_drop_low";
      }

      if(isDefined(animid)) {
        animzoffset = 1000;
        scenenode = spawn("script_model", releasedestination + (0, 0, animzoffset));
        scenenode.angles = dropangles;
        scenenode setModel("tag_origin");
        crate.animname = "care_package";
        crate.dropanim = level.scr_anim[crate.animname][animid];
        crate.animlength = getanimlength(crate.dropanim);
        crate scripts\common\anim::setanimtree();
        chute = spawn("script_model", crate.origin);
        chute.angles = crate.angles;
        chute.animname = "care_package_chute";
        chute.dropanim = level.scr_anim[chute.animname][animid];
        chute.animlength = getanimlength(chute.dropanim);
        chute setModel("veh9_mil_lnd_parachute_carepackage_br");
        chute scripts\common\anim::setanimtree();
        scenenode thread scripts\common\anim::anim_single_solo(crate, animid);
        scenenode thread scripts\common\anim::anim_single_solo(chute, animid);
        crate thread watchbrc130aidropcrateanimend();
        chute thread watchbrc130airdropchuteanimend(scenenode);
      } else {
        crate cratephysicson();
      }
    } else {
      crate cratephysicson();
    }

    var_40920b1903f4682a = #"cashdrop_common";
    var_c16dc9d131bd10ba = getdvarint(@ "hash_ff7bb52f31b387e1", 1);

    if(var_c16dc9d131bd10ba) {
      var_40920b1903f4682a = #"cashdrop_common_world";
    }

    if(isDefined(var_fe41be11a71dc1b4)) {
      var_40920b1903f4682a = var_fe41be11a71dc1b4;
    }

    crate setscriptablepartstate(#"objective_map", var_40920b1903f4682a, 0);
    crate setscriptablepartstate(#"crate_audio", #"parachuting", 0);
    var_946146964fc4025f = "ks_airdrop_crate_br";

    if(isDefined(var_cf11cd8c8b813faf)) {
      var_946146964fc4025f = var_cf11cd8c8b813faf;
    }

    crate.smokesignal = spawn("script_model", dropdestination);
    crate.smokesignal setModel(var_946146964fc4025f);
    crate.smokesignal setscriptablepartstate(#"smoke_signal", #"on", 0);
  }

  return crate;
}

function watchbrc130aidropcrateanimend() {
  self endon("death");
  wait self.animlength;

  if(isDefined(self)) {
    level notify(self.cratetype + "drop_anim_completed");
    self stopanimScripted();
    cratephysicson();
  }
}

function watchbrc130airdropchuteanimend(scenenode) {
  self endon("death");
  wait self.animlength;

  if(isDefined(self)) {
    self delete();
  }

  if(isDefined(scenenode)) {
    scenenode delete();
  }
}

function initbattleroyalelootchoppercratedata() {
  leveldata = getleveldata("battle_royale_chopper_loot");

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
  } else {
    leveldata.capturestring = &"MP/DMZ_PLUNDER_CRATE_CAPTURE";
  }

  leveldata.basemodel = "military_carepackage_03_br";
  leveldata.mountmantlemodel = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.usepriority = -1;
  leveldata.usefov = 180;
  leveldata.timeout = 600;
  leveldata.friendlyuseonly = 1;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.var_c23ca3472233553d = 1;
  leveldata.activatecallback = &brlootchoppercrateactivatecallback;
  leveldata.capturecallback = &brlootchoppercratecapturecallback;
  leveldata.destroycallback = &brlootchoppercratedestroycallback;
  leveldata.destroyoncapture = 1;
  leveldata.isdropcrate = 1;
}

function brlootchoppercrateactivatecallback(isfirstactivation) {}

function brlootchoppercratecapturecallback(player) {
  self setscriptablepartstate(#"objective_map", #"inactive", 0);

  if(issharedfuncdefined("br_lootchopper", "lootChopper_onCrateUse")) {
    self[[getsharedfunc("br_lootchopper", "lootChopper_onCrateUse")]](player);
  }

  if(issharedfuncdefined("br_lootchopper", "championChopper_onCrateUse")) {
    self[[getsharedfunc("br_lootchopper", "championChopper_onCrateUse")]](player);
  }

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate(#"smoke_signal", #"off", 0);
    self.smokesignal delete();
  }
}

function brlootchoppercratedestroycallback(immediate) {
  self setscriptablepartstate(#"objective_map", #"inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate(#"smoke_signal", #"off", 0);
    self.smokesignal delete();
  }
}

function dropbrlootchoppercrate(position, destination) {
  crate = dropcrate(undefined, undefined, "battle_royale_chopper_loot", position, (0, randomfloat(360), 0), destination);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;
    var_40920b1903f4682a = #"cashdrop_common";
    var_c16dc9d131bd10ba = getdvarint(@ "hash_ff7bb52f31b387e1", 1);

    if(var_c16dc9d131bd10ba) {
      var_40920b1903f4682a = #"cashdrop_common_world";
    }

    crate setscriptablepartstate(#"objective_map", var_40920b1903f4682a, 0);
    crate.smokesignal = spawn("script_model", destination);
    crate.smokesignal setModel("ks_airdrop_crate_br");
    crate.smokesignal setscriptablepartstate(#"smoke_signal", #"on", 0);
  }

  return crate;
}

function dropbrlootchoppercrateforpublicevent(position, destination) {
  crate = dropcrate(undefined, undefined, "battle_royale_chopper_loot", position, (0, randomfloat(360), 0), destination);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;
    crate setscriptablepartstate(#"objective_map", #"pe_chopper_crate", 0);
    crate.smokesignal = spawn("script_model", destination);
    crate.smokesignal setModel("ks_airdrop_crate_br");
    crate.smokesignal setscriptablepartstate(#"smoke_signal", #"hash_681713bdddb46d8e", 0);
  }

  return crate;
}

function function_ddd270c88107faf9() {
  leveldata = getleveldata("battle_royale_elite_chopper");

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
  } else {
    leveldata.capturestring = &"MP/DMZ_PLUNDER_CRATE_CAPTURE";
  }

  leveldata.basemodel = "military_carepackage_03_br";
  leveldata.mountmantlemodel = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.usepriority = -1;
  leveldata.usefov = 180;
  leveldata.timeout = 600;
  leveldata.friendlyuseonly = 1;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.activatecallback = &function_bcae3fa5db092dd4;
  leveldata.capturecallback = &function_60b85568611b92f3;
  leveldata.destroycallback = &function_1ecb1fecb6f56ecf;
  leveldata.destroyoncapture = 1;
  leveldata.isdropcrate = 1;
}

function function_bcae3fa5db092dd4(isfirstactivation) {}

function function_60b85568611b92f3(player) {
  self setscriptablepartstate(#"objective_map", #"inactive", 0);

  if(issharedfuncdefined("br_elitechopper", "eliteChopper_onCrateUse")) {
    self[[getsharedfunc("br_elitechopper", "eliteChopper_onCrateUse")]](player);
  }

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate(#"smoke_signal", #"off", 0);
    self.smokesignal delete();
  }
}

function function_1ecb1fecb6f56ecf(immediate) {
  self setscriptablepartstate(#"objective_map", #"inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate(#"smoke_signal", #"off", 0);
    self.smokesignal delete();
  }
}

function function_4671cbee65d1615d(position, destination) {
  crate = dropcrate(undefined, undefined, "battle_royale_elite_chopper", position, (0, randomfloat(360), 0), destination);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;
    crate setscriptablepartstate(#"objective_map", #"pe_chopper_crate", 0);
    crate.smokesignal = spawn("script_model", destination);
    crate.smokesignal setModel("ks_airdrop_crate_br");
    crate.smokesignal setscriptablepartstate(#"smoke_signal", #"hash_681713bdddb46d8e", 0);
  }

  return crate;
}

function function_53a94fee5954af57() {
  leveldata = getleveldata("battle_royale_cash_crate");
  leveldata.capturestring = &"MP/DMZ_PLUNDER_CRATE_CAPTURE";
  leveldata.basemodel = "military_carepackage_03_br";
  leveldata.mountmantlemodel = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.usepriority = -1;
  leveldata.usefov = 180;
  leveldata.timeout = 600;
  leveldata.friendlyuseonly = 1;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.var_9ea9e33fa2a90171 = 1;
  leveldata.var_c23ca3472233553d = 1;
  leveldata.activatecallback = &function_bf892d4093c5f9d3;
  leveldata.capturecallback = &function_93bbdfaba40c778a;
  leveldata.destroycallback = &function_66ee09b2e374fb6e;
  leveldata.destroyoncapture = 1;
  leveldata.isdropcrate = 1;
}

function function_bf892d4093c5f9d3(isfirstactivation) {
  if(issharedfuncdefined("airdrop", "registerCrateForCleanup")) {
    [[getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
  }
}

function function_93bbdfaba40c778a(player) {
  self setscriptablepartstate("objective_map", "inactive", 0);
  self setscriptablepartstate("objective", "inactive", 0);

  if(issharedfuncdefined("br_cashcrate", "cashCrate_onCrateUse")) {
    self[[getsharedfunc("br_cashcrate", "cashCrate_onCrateUse")]](player);
  }

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }
}

function function_66ee09b2e374fb6e(immediate) {
  self setscriptablepartstate("objective_map", "inactive", 0);
  self setscriptablepartstate("objective", "inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }
}

function function_9feb10c0096cc4d6(position, destination) {
  crate = dropcrate(undefined, undefined, "battle_royale_cash_crate", position, (0, randomfloat(360), 0), destination);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;
    var_40920b1903f4682a = "cashdrop_common";
    var_c16dc9d131bd10ba = getdvarint(@ "hash_ff7bb52f31b387e1", 1);

    if(var_c16dc9d131bd10ba) {
      var_40920b1903f4682a = "cashdrop_common_world";
    }

    crate setscriptablepartstate("objective_map", var_40920b1903f4682a, 0);
    crate.smokesignal = spawn("script_model", destination);
    crate.smokesignal setModel("ks_airdrop_crate_br");
    crate.smokesignal setscriptablepartstate("smoke_signal", "on", 0);
  }

  return crate;
}

function initplundercratedata() {
  leveldata = getleveldata("esc_cache");
  leveldata.capturestring = &"MP/ESC_CACHE_USE_HINT";
  leveldata.usetag = "tag_origin";
  leveldata.userange = 200;
  leveldata.usefov = 160;
  leveldata.usepriority = 0;
  leveldata.basemodel = "military_crate_large_stackable_01";
  leveldata.mountmantlemodel = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.usepriority = -10000;
  leveldata.headicon = undefined;
  leveldata.minimapicon = undefined;

  if(issharedfuncdefined("airdrop", "captureLootCacheCallback")) {
    leveldata.capturecallback = getsharedfunc("airdrop", "captureLootCacheCallback");
  }

  leveldata.destroyoncapture = 0;
  leveldata.onecaptureperplayer = 1;
  leveldata.capturevisualscallback = undefined;
  leveldata.destroyvisualscallback = undefined;
  leveldata.timeout = undefined;
}

function getplcratedata(contents) {
  data = spawnStruct();
  data.contents = contents;
  return data;
}

function placeplcrate(contents, position, angles) {
  crate = placecrate(undefined, undefined, "esc_cache", position, angles, getplcratedata(contents));
  return crate;
}

function initarmcratedata() {
  level.cratedata.armweights = [];
  level.cratedata.armcapturestrings = [];
  leveldata = getleveldata("arm_no_owner");
  leveldata.activatecallback = &armcrateactivatecallback;
  leveldata.capturecallback = &armcratecapturecallback;
  leveldata.supportsownercapture = 0;
  leveldata.headicondrawrange = 5000;
  leveldata.timeout = 180;
  addarmcratedata("uav", undefined, 5, 10);
  addarmcratedata("manual_turret", undefined, 5, 5);
  addarmcratedata("cruise_predator", undefined, 4, 40);
  addarmcratedata("scrambler_drone_guard", undefined, 4, 20);
  addarmcratedata("precision_airstrike", undefined, 3, 60);
  addarmcratedata("toma_strike", undefined, 2, 40);
  addarmcratedata("chopper_gunner", undefined, 2, 30);
  addarmcratedata("pac_sentry", undefined, 2, 30);
  addarmcratedata("gunship", undefined, 2, 30);
}

function addarmcratedata(streakname, capturestring, defconlevel, weight) {
  level.cratedata.armdefconlevels[streakname] = defconlevel;
  level.cratedata.armweights[streakname] = weight;
  level.cratedata.armcapturestrings[streakname] = capturestring;
}

function getarmcratedatabystreakname(streakname) {
  data = spawnStruct();
  data.streakname = streakname;
  return data;
}

function armcrateactivatecallback(isfirstactivation) {
  data = self.data;
  capturestring = level.cratedata.armcapturestrings[data.streakname];

  if(isDefined(capturestring)) {
    overridecapturestring(capturestring);
  }
}

function armcratecapturecallback(player) {
  if(issharedfuncdefined("killstreak", "awardKillstreak")) {
    player thread[[getsharedfunc("killstreak", "awardKillstreak")]](self.data.streakname, "airdrop", undefined, undefined, self.owner);
  }
}

function getrandomarmkillstreak(team) {
  assertex(isDefined(level.cratedata), "getRandomArmKillstreak() called before initCrateData().");
  assertex(isDefined(level.cratedata.armweights), "getRandomArmKillstreak() called before initArmCrateData().");
  var_52a8c1bddbf44d11 = getarmkillsteakstoexcludebyteamdefconlevel(team);
  streakname = getrandomkeyfromweightsarray(level.cratedata.armweights, var_52a8c1bddbf44d11);
  return streakname;
}

function getarmkillsteakstoexcludebyteamdefconlevel(team) {
  assertex(isDefined(level.cratedata.armdefconlevels), "getArmKillsteaksToExcludeByTeamDefconLevel() called before initArmCrateData().");
  assertex(isDefined(level.defconlevel), "getArmKillsteaksToExcludeByDefconLevel() called before scriptsmpgametypesarm::onStartGameType().");
  defconlevel = level.defconlevel;
  var_59f9b4ec41bab131 = undefined;

  if(defconlevel > 1) {
    var_59f9b4ec41bab131 = [];

    foreach(var_fce39dabbbb5c9e0 in level.cratedata.armdefconlevels) {
      if(defconlevel > var_fce39dabbbb5c9e0) {
        var_59f9b4ec41bab131[var_59f9b4ec41bab131.size] = streakname;
      }
    }
  }

  return var_59f9b4ec41bab131;
}

function droparmcratefromscriptedheli(team, streakname, position, angles, destination) {
  if(!isDefined(streakname) || streakname == "random") {
    streakname = getrandomarmkillstreak(team);
  }

  cratedropdata = getarmcratedatabystreakname(streakname);
  scenenode = dropcratefromscriptedheli(undefined, team, "arm_no_owner", position, angles, destination, cratedropdata);

  if(!isDefined(scenenode)) {
    return undefined;
  } else if(!isDefined(scenenode.crates) || !isDefined(array_get_first_item(scenenode.crates))) {
    return undefined;
  }

  foreach(crate in scenenode.crates) {
    return crate;
  }
}

function function_a3299432ddb721e3() {
  level.cratedata.var_332809acea23b57 = [];
  level.cratedata.var_7480157ed64deda2 = [];
  leveldata = getleveldata("gwtdm_no_owner");
  leveldata.activatecallback = &function_d8a8e185cfa2de1b;
  leveldata.capturecallback = &armcratecapturecallback;
  leveldata.supportsownercapture = 0;
  leveldata.enemymodel = undefined;
  leveldata.headicondrawrange = 5000;
  leveldata.timeout = 180;
  function_c035e11237e84114("cruise_predator", 40);
  function_c035e11237e84114("precision_airstrike", 40);
  function_c035e11237e84114("toma_strike", 40);
  function_c035e11237e84114("fuel_airstrike", 40);
  function_c035e11237e84114("sentry_gun", 40);
  function_c035e11237e84114("pac_sentry", 30);
  function_c035e11237e84114("auto_drone", 20);
  function_c035e11237e84114("hover_jet", 20);
  function_c035e11237e84114("chopper_gunner", 20);
  function_c035e11237e84114("gunship", 10);
  function_c035e11237e84114("juggernaut", 10);
}

function function_c035e11237e84114(streakname, weight) {
  level.cratedata.var_332809acea23b57[streakname] = weight;
}

function function_d8a8e185cfa2de1b(isfirstactivation) {
  data = self.data;
  capturestring = level.cratedata.var_7480157ed64deda2[data.streakname];

  if(isDefined(capturestring)) {
    overridecapturestring(capturestring);
  }
}

function function_5d1369bfc4efd8b7(team) {
  assertex(isDefined(level.cratedata), "getRandomArmKillstreak() called before initCrateData().");
  assertex(isDefined(level.cratedata.var_332809acea23b57), "getRandomArmKillstreak() called before initArmCrateData().");
  streakname = getrandomkeyfromweightsarray(level.cratedata.var_332809acea23b57);
  return streakname;
}

function function_506b410ce5a55cb3(streakname) {
  data = spawnStruct();
  data.streakname = streakname;
  return data;
}

function function_99cc30ea8be5b2a6(team, streakname, position, angles, destination) {
  if(!isDefined(streakname) || streakname == "random") {
    streakname = function_5d1369bfc4efd8b7(team);
  }

  cratedropdata = function_506b410ce5a55cb3(streakname);
  scenenode = dropcratefromscriptedheli(undefined, team, "gwtdm_no_owner", position, angles, destination, cratedropdata);

  if(!isDefined(scenenode)) {
    return undefined;
  } else if(!isDefined(scenenode.crates) || !isDefined(array_get_first_item(scenenode.crates))) {
    return undefined;
  }

  foreach(crate in scenenode.crates) {
    return crate;
  }
}

function initbattleroyalejuggernautcratedata() {
  leveldata = getleveldata("battle_royale_juggernaut");

  if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
    leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
  } else {
    leveldata.capturestring = &"KILLSTREAKS_HINTS/JUGG_CRATE_PICKUP";
  }

  leveldata.basemodel = "military_carepackage_03_jugg_br";
  leveldata.mountmantlemodel = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.headicon = undefined;
  leveldata.usepriority = -1;
  leveldata.usefov = 180;
  leveldata.timeout = undefined;
  leveldata.friendlyuseonly = 1;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.capturecallback = &brjuggernautcratecapturecallback;
  leveldata.destroycallback = &brjuggernautcratedestroycallback;
  leveldata.activatecallback = &brjuggernautcrateactivatecallback;
  leveldata.cratephysicsoncallback = &brjuggernautcratephysicsoncallback;
  leveldata.destroyoncapture = 1;
  leveldata.isdropcrate = 1;
  leveldata.var_c23ca3472233553d = 1;
}

function brjuggernautcrateactivatecallback(isfirstactivation) {
  scripts\cp_mp\killstreaks\juggernaut::oncrateactivated(isfirstactivation);

  if(issharedfuncdefined("br_juggernaut", "onCrateActivate")) {
    self[[getsharedfunc("br_juggernaut", "onCrateActivate")]](isfirstactivation);
  }
}

function brjuggernautcratecapturecallback(player) {
  self setscriptablepartstate(#"objective_map", #"inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate(#"smoke_signal", #"off", 0);
    self.smokesignal delete();
  }

  if(issharedfuncdefined("br_juggernaut", "onCrateUse")) {
    self[[getsharedfunc("br_juggernaut", "onCrateUse")]](player);
  }

  scripts\cp_mp\killstreaks\juggernaut::oncratecaptured(player);
}

function brjuggernautcratedestroycallback(immediate) {
  self setscriptablepartstate(#"objective_map", #"inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }

  if(issharedfuncdefined("br_juggernaut", "onCrateDestroy")) {
    self[[getsharedfunc("br_juggernaut", "onCrateDestroy")]](immediate);
  }
}

function brjuggernautcratephysicsoncallback(position, destination) {
  self setscriptablepartstate(#"crate_audio", #"detach", 0);
}

function dropjuggernautcrate(team, position, destination) {
  streakinfo = createstreakinfo("juggernaut", self);
  return dropcrate(undefined, team, "battle_royale_juggernaut", position, (0, randomfloat(360), 0), destination, streakinfo, 1);
}

function spawnjuggernautcrateatposition(pos, isfromgrenade) {
  crate = scripts\cp_mp\killstreaks\airdrop::dropjuggernautcrate(self.team, pos + (0, 0, 4096), pos + (0, 0, 512));
  assert(isDefined(crate));
  crate endon("death");
  enablejuggernautcrateobjective(crate);
  choosejuggernautcratemodel(crate);
  voplayers = [];

  foreach(teammate in level.teamdata[self.team]["alivePlayers"]) {}
}

function enablejuggernautcrateobjective(crate) {
  crate setotherent(self);
  crate setscriptablepartstate(#"objective_map", #"jugg_world");
}

function choosejuggernautcratemodel(crate) {
  crate setotherent(self);
  crate setscriptablepartstate(#"model", #"choose");
}

function juggcanusecrate(cratetype) {
  canusecrate = 1;

  switch (cratetype) {
    case #"hash_b597e9a707180461":
    case #"hash_d8d9a61afc7a655b":
      canusecrate = 0;
      break;
    case #"hash_d87004954b36d6e1":
      if(issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        canuseweaponpickups = self[[getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(!istrue(canuseweaponpickups)) {
          canusecrate = 0;
        }
      }

      break;
  }

  return canusecrate;
}

function function_3c4492046080faa9() {
  return ter_op(istrue(self.inwater), 50, 5);
}

function function_f7e3f128296ac3b6() {
  return ter_op(istrue(self.inwater), 5, 1);
}

function function_d4833b6c916db9c6() {
  return ter_op(istrue(self.inwater), 3, 6);
}

function private function_c857ac89588adf6f() {
  leveldata = getleveldata(self.cratetype);
  return ter_op(istrue(self.inwater), 5, leveldata.headiconoffset);
}

function function_19dc247eaaf9da8f() {
  leveldata = getleveldata("elite_arrow_bombsite");
  leveldata.basemodel = "military_carepackage_01_cq";
  leveldata.var_9ae260c6bfb4c98d = 1;
  leveldata.minimapicon = undefined;
  leveldata.headicon = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.hasnointeraction = 1;
  leveldata.timeout = 0.1;
}

function function_56e93fd2282a71ce() {
  leveldata = getleveldata("legendary_supply_drop");
  leveldata.basemodel = "military_carepackage_03_br";
  leveldata.mountmantlemodel = undefined;
  leveldata.usepriority = -1;
  leveldata.minimapicon = undefined;
  leveldata.headicon = undefined;
  leveldata.supportsownercapture = 0;
  leveldata.timeout = 180;
  leveldata.ownerusetime = 0.5;
  leveldata.otherusetime = 0.5;
  leveldata.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  leveldata.capturecallback = &function_e7051a617b94015;
  leveldata.destroyoncapture = 1;
}

function function_e7051a617b94015(player) {
  if(issharedfuncdefined("br_legendary_supply_drop", "legendary_supply_onCrateUse")) {
    self[[getsharedfunc("br_legendary_supply_drop", "legendary_supply_onCrateUse")]](player);
  }
}