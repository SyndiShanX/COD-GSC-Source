/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\airdrop.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "init")]]();

  level._effect["airdrop_crate_impact_ground"] = loadfx("vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_dust.vfx");
  level._effect["airdrop_crate_impact_water"] = loadfx("vfx/iw9/killstreaks/smk_signal/vfx_carepkg_landing_water.vfx");
  level.carepackagedropnodes = getEntArray("carepackage_drop_area", "targetname");
  initkillstreak();
  initheli();
  initcratedata();
  _id_93512C08385359E1();
  _id_27994695F48962E1();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "airdropMultipleInit"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "airdropMultipleInit")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "airdropEscortInit"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "airdropEscortInit")]]();
}

initkillstreak() {}

initheli() {
  level.littlebirds = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerScoreInfo"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerScoreInfo")]]();
}

initcratedata() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  _id_962A30A9BB8C0F09.configs = [];
  _id_962A30A9BB8C0F09.crates = [];
  _id_962A30A9BB8C0F09.usablecrates = [];
  level.cratedata = _id_962A30A9BB8C0F09;
  level.cratedata.unresolvedcollisiontolerancesqr = pow(getdvarfloat("dvar_A0CBF9E8D23FB12C", 2), 2);
  level.cratedata.mountmantlemodel = getEnt("care_package_col", "targetname");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerActionSet"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerActionSet")]]();

  gametype = "mp";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType"))
    gametype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

  switch (gametype) {
    case "cqc":
    case "cp_wave_sv":
    case "incursion":
    case "cp_survival":
    case "missions":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "getGameModeSpecificCrateData"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "getGameModeSpecificCrateData")]]();
    case "br":
      initbattleroyalecratedata();
      initbattleroyaleloadoutcratedata();
      initbattleroyalec130airdropcratedata();
      initbattleroyalelootchoppercratedata();
      initbattleroyalejuggernautcratedata();
      _id_19DC247EAAF9DA8F();
      _id_56E93FD2282A71CE();
    case "conflict":
    case "arm":
      initarmcratedata();
      initkillstreakcratedata();
      initbattleroyalecratedata();
      _id_C5C61B985836F974();
    case "grnd":
    case "infect":
      initdropzonekillstreakcratedata();
      _id_C5C61B985836F974();
      break;
    case "gwtdm":
      _id_A3299432DDB721E3();
      initkillstreakcratedata();
      _id_C5C61B985836F974();
      break;
    default:
      initkillstreakcratedata();
      _id_C5C61B985836F974();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "getMapSpecificCrateData"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "getMapSpecificCrateData")]]();

  initcratedropdata();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerPlayerFrameUpdateCallback"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerPlayerFrameUpdateCallback")]](::trackcratemantlingexploit);

  thread watchallcrateusability();
}

_id_93512C08385359E1() {
  level._id_27F78817B59DFE32 = "airdrop_placement";
  _id_3B64EB40368C1450::_id_2D6E7E0B80767910(level._id_27F78817B59DFE32, ["offhand_weapons", "melee", "execution_attack", "weapon_pickup"]);
}

_id_27994695F48962E1() {
  game["dialog"]["airdrop_use"] = "killstreak_remote_operator_request_response";
}

getleveldata(cratetype) {
  _id_962A30A9BB8C0F09 = level.cratedata.configs[cratetype];

  if(!isDefined(_id_962A30A9BB8C0F09)) {
    _id_962A30A9BB8C0F09 = getemptyleveldata();
    level.cratedata.configs[cratetype] = _id_962A30A9BB8C0F09;
  }

  return _id_962A30A9BB8C0F09;
}

getemptyleveldata() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_03_mp";
  _id_962A30A9BB8C0F09.halfheight = 27.5;
  _id_962A30A9BB8C0F09.mountmantlemodel = getdefaultmountmantlemodel();
  _id_962A30A9BB8C0F09.objweapon = nullweapon();
  _id_962A30A9BB8C0F09.timeout = 90;
  _id_962A30A9BB8C0F09.headiconoffset = 0;
  _id_962A30A9BB8C0F09.headicondrawrange = 10000;
  _id_962A30A9BB8C0F09.headiconnaturalrange = 400;
  _id_962A30A9BB8C0F09.minimapicon = "hud_icon_minimap_killstreak_carepackage";
  _id_962A30A9BB8C0F09.usetag = "tag_use";

  if(scripts\common\utility::iscp())
    _id_962A30A9BB8C0F09.usetag = "j_military_loot_crate_ui_01_lid";

  _id_962A30A9BB8C0F09.userange = 128;
  _id_962A30A9BB8C0F09.breakuserangesqr = 30625;
  _id_962A30A9BB8C0F09.usefov = 360;
  _id_962A30A9BB8C0F09.usepriority = 0;
  _id_962A30A9BB8C0F09.ownerusetime = 0.5;
  _id_962A30A9BB8C0F09.otherusetime = 3;
  _id_962A30A9BB8C0F09.friendlyuseonly = 0;
  _id_962A30A9BB8C0F09.navobstaclebounds = (30, 10, 64);
  _id_962A30A9BB8C0F09.navobstacleupdatedistsqr = 64;
  _id_962A30A9BB8C0F09.dangerzoneheight = 1000;
  _id_962A30A9BB8C0F09.dangerzoneradius = 128;
  _id_962A30A9BB8C0F09.activatecallback = undefined;
  _id_962A30A9BB8C0F09.deactivatecallback = undefined;
  _id_962A30A9BB8C0F09.capturecallback = undefined;
  _id_962A30A9BB8C0F09.rerollcallback = undefined;
  _id_962A30A9BB8C0F09.destroycallback = undefined;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09.onecaptureperplayer = 0;
  _id_962A30A9BB8C0F09.hasnointeraction = 0;
  _id_962A30A9BB8C0F09.destroyvisualscallback = getdefaultdestroyvisualscallback();
  _id_962A30A9BB8C0F09.destroyvisualsdeletiondelay = getdefaultdestroyvisualsdeletiondelay();
  _id_962A30A9BB8C0F09.capturevisualscallback = getdefaultcapturevisualscallback();
  _id_962A30A9BB8C0F09.capturevisualsdeletiondelay = getdefaultcapturevisualsdeletiondelay();
  _id_962A30A9BB8C0F09.capturestring = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  _id_962A30A9BB8C0F09.rerollstring = &"KILLSTREAKS_HINTS/UAV_REROLL";
  _id_962A30A9BB8C0F09.headicon = "hud_icon_minimap_killstreak_carepackage";
  _id_962A30A9BB8C0F09.supportsreroll = 0;
  _id_962A30A9BB8C0F09.supportsownercapture = 1;
  _id_962A30A9BB8C0F09.supportsothercapture = 1;
  return _id_962A30A9BB8C0F09;
}

hasleveldata(cratetype) {
  return isDefined(level.cratedata.configs[cratetype]);
}

createcrate(owner, team, cratetype, position, angles, destination, hasnophysics, _id_6244A1D5B282BB6C, data, skipminimapicon, _id_FE880EB7782C9EA0) {
  _id_962A30A9BB8C0F09 = getleveldata(cratetype);

  if(_id_962A30A9BB8C0F09.supportsownercapture) {}

  if(_id_962A30A9BB8C0F09.supportsreroll) {}

  crate = spawn("script_model", position);
  crate.angles = angles;

  if(!istrue(_id_6244A1D5B282BB6C) && cratetype != "battle_royale_c130_loot" || cratetype != "battle_royale_loadout" && cratetype != "battle_royale_cash_crate") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
      if(crate[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]()) {
        crate delete();
        return undefined;
      }
    }
  }

  if(!isDefined(crate))
    return undefined;

  crate.owner = owner;
  crate.team = team;
  crate.objweapon = _id_962A30A9BB8C0F09.objweapon;
  crate.cratetype = cratetype;
  crate.useobject = undefined;
  crate.navobstacle = undefined;
  crate.headiconid = undefined;
  crate.minimapid = undefined;
  crate.dangerzoneid = undefined;
  crate.navobstacleid = undefined;
  crate.destination = destination;
  crate._id_FE880EB7782C9EA0 = _id_FE880EB7782C9EA0;
  crate.headiconactive = 0;
  crate.minimapiconactive = 0;
  crate.hasnophysics = istrue(hasnophysics);
  crate.physicsactivated = 0;
  crate.isdestroyed = 0;
  crate.data = data;
  crate.skipminimapicon = skipminimapicon;
  crate._id_51AB77B2BA57C5DD = 0;
  crate._id_28EB33FFD1AA3E63 = _id_962A30A9BB8C0F09._id_28EB33FFD1AA3E63;
  crate.headicon = _id_962A30A9BB8C0F09.headicon;
  crate.minimapicon = _id_962A30A9BB8C0F09.minimapicon;
  crate.capturestring = _id_962A30A9BB8C0F09.capturestring;
  crate.rerollstring = _id_962A30A9BB8C0F09.rerollstring;
  crate.supportsreroll = _id_962A30A9BB8C0F09.supportsreroll;
  crate.isteamonlycrate = _id_962A30A9BB8C0F09.isteamonlycrate;
  crate._id_C23CA3472233553D = _id_962A30A9BB8C0F09._id_C23CA3472233553D;
  crate._id_229AB5AFB5B2CF09 = _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09;
  crate setModel(crate._id_229AB5AFB5B2CF09);
  crate setnodeploy(1);
  crate setCanDamage(0);
  crate makeunusable();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "attachXRays"))
    crate = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "attachXRays")]](crate);

  crate enableplayermarks("killstreak");

  if(level.teambased)
    crate filteroutplayermarks(crate.team);
  else
    crate filteroutplayermarks(crate.owner);

  killcament = undefined;

  if(!crate.hasnophysics) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
        killcament = spawn("script_model", position + (0, 0, 300));
        killcament setscriptmoverkillcam("explosive");
        killcament linkTo(crate);
      }
    }
  }

  if(isDefined(crate.owner))
    crate.owner.isffprotectedaction = 1;

  crate.killcament = killcament;

  if(isDefined(crate.killcament))
    crate.killcament.linked = 1;

  crate.unresolved_collision_notify_min = 1;
  _id_79DA6880ECEA3790 = crate createmountmantlemodel();

  if(!_id_79DA6880ECEA3790)
    crate.unresolved_collision_func = ::crateunresolvedcollisioncallback;

  crate addtolists();

  if(!scripts\engine\utility::is_equal(level.script, "mp_bm_tut"))
    crate thread watchcratedestroyearly();

  if(istrue(crate.hasnophysics))
    crate activatecratefirsttime();
  else if(istrue(_id_6244A1D5B282BB6C))
    crate cratephysicson();

  return crate;
}

activatecratefirsttime() {
  activatecrate(1);
}

activatecrate(isfirstactivation) {
  self notify("activateCrate");
  self.isfirstactivation = undefined;

  if(istrue(self.destroyonactivate)) {
    thread destroycrate();
    return;
  }

  _createnavobstacle();
  self notify("crate_dropped");

  if(istrue(self.waitforobjectiveactivate) && istrue(isfirstactivation))
    self waittill("objective_activate");

  if(istrue(isfirstactivation) && self.cratetype != "battle_royale_loadout" && !istrue(self.skipminimapicon))
    createminimapicon();

  _createheadicon();
  makecrateusable();
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(isDefined(_id_962A30A9BB8C0F09.activatecallback))
    self thread[[_id_962A30A9BB8C0F09.activatecallback]](isfirstactivation);
}

deactivatecrate(_id_4F1920BD33A0DBA9) {
  if(istrue(_id_4F1920BD33A0DBA9))
    destroyminimapicon();

  _destroyheadicon();
  makecrateunusable();
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(isDefined(_id_962A30A9BB8C0F09.deactivatecallback))
    self thread[[_id_962A30A9BB8C0F09.deactivatecallback]](_id_4F1920BD33A0DBA9);
}

capturecrate(player) {
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(isDefined(self.owner) && istrue(self.owner.isffprotectedaction))
    self.owner.isffprotectedaction = 0;

  if(isDefined(_id_962A30A9BB8C0F09.capturecallback))
    self thread[[_id_962A30A9BB8C0F09.capturecallback]](player);

  if(_id_962A30A9BB8C0F09.destroyoncapture) {
    _id_CBF7BE4F62A0DDB2 = 0;

    if(isDefined(_id_962A30A9BB8C0F09.capturevisualscallback)) {
      self thread[[_id_962A30A9BB8C0F09.capturevisualscallback]](self);
      _id_CBF7BE4F62A0DDB2 = _id_962A30A9BB8C0F09.capturevisualsdeletiondelay;
    }

    thread deletecrate(_id_CBF7BE4F62A0DDB2);
  }
}

destroycrate(immediate) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }
  if(!isDefined(immediate)) {
    if(isDefined(self.scenenode)) {
      if(isDefined(self.animdroptime)) {
        if(gettime() >= self.animdroptime) {
          self.destroyonactivate = 1;
          return;
        } else
          immediate = 1;
      }
    } else if(istrue(self.physicsactivated)) {
      if(!istrue(self.physicssettled)) {
        self.destroyonactivate = 1;
        return;
      }
    }
  }

  if(isDefined(self.numuses) && self.numuses > 0 && isDefined(self.owner) && isPlayer(self.owner)) {
    if(isDefined(self.streakinfo) && isDefined(self.streakinfo.airdroptype) &self.streakinfo.airdroptype == "loadout_drop")
      self.owner scripts\cp_mp\challenges::_id_D997435895422ECC("super_loadout_drop", 3, self.numuses);
  }

  self.destroyonactivate = undefined;
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(isDefined(level.br_pickups) && isDefined(level.br_pickups.crates) && scripts\engine\utility::array_contains(level.br_pickups.crates, self))
    level.br_pickups.crates = scripts\engine\utility::array_remove(level.br_pickups.crates, self);

  if(isDefined(self.owner) && istrue(self.owner.isffprotectedaction))
    self.owner.isffprotectedaction = 0;

  if(isDefined(_id_962A30A9BB8C0F09.destroycallback))
    self thread[[_id_962A30A9BB8C0F09.destroycallback]](immediate);

  if(!istrue(immediate)) {
    _id_CBF7BE4F62A0DDB2 = undefined;

    if(!istrue(self.physicsactivated) || !istrue(self.physicssettled)) {
      if(isDefined(_id_962A30A9BB8C0F09.destroyvisualscallback)) {
        self thread[[_id_962A30A9BB8C0F09.destroyvisualscallback]](self);
        _id_CBF7BE4F62A0DDB2 = _id_962A30A9BB8C0F09.destroyvisualsdeletiondelay;
      }
    } else if(isDefined(_id_962A30A9BB8C0F09.capturevisualscallback)) {
      self thread[[_id_962A30A9BB8C0F09.capturevisualscallback]](self);
      _id_CBF7BE4F62A0DDB2 = _id_962A30A9BB8C0F09.capturevisualsdeletiondelay;
    }

    thread deletecrate(_id_CBF7BE4F62A0DDB2);
  } else
    thread deletecrateimmediate();
}

deletecrate(delay) {
  if(istrue(self.isdestroyed)) {
    return;
  }
  self notify("death");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    if(isDefined(self.scenenode.crates))
      self.scenenode.crates[self getentitynumber()] = undefined;

    if(isDefined(self.scenenode.crate))
      self.scenenode.crate = undefined;

    self.scenenode = undefined;
  }

  removefromlists(self getentitynumber());
  self disableplayermarks("killstreak");
  self setCanDamage(0);
  self setnonstick(1);
  makecrateunusable();

  if(isDefined(self.useobject))
    self.useobject delete();

  destroydangerzone();
  _destroynavobstacle();
  destroymountmantlemodel();
  cratephysicsoff();
  destroyminimapicon();
  _id_3A065CE769B6CE3D();
  _destroyheadicon();
  self notsolid();

  if(isDefined(self.killcament))
    self.killcament delete();

  wait(delay);
  self delete();
}

deletecrateimmediate() {
  _id_CBF7BE4F62A0DDB2 = level.framedurationseconds;

  if(isDefined(self getlinkedscriptableinstance()) && self getscriptablehaspart("visibility"))
    self setscriptablepartstate("visibility", "hide", 1);

  deletecrate(_id_CBF7BE4F62A0DDB2);
}

watchcratedestroyearly() {
  self endon("death");
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(isDefined(_id_962A30A9BB8C0F09.timeout)) {}

  watchcratedestroyearlyinternal(_id_962A30A9BB8C0F09.timeout);

  if(istrue(self.nevertimeout)) {
    return;
  }
  thread destroycrate();
}

watchcratedestroyearlyinternal(timeout) {
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");

  if(isDefined(timeout)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(timeout);

    while(isDefined(self.playersusing) && self.playersusing.size > 0) {
      _id_52FD907EBD6A9A6A = 0;

      foreach(player in self.playersusing) {
        if(isDefined(player)) {
          _id_52FD907EBD6A9A6A = 1;
          break;
        }
      }

      if(!istrue(_id_52FD907EBD6A9A6A)) {
        break;
      }

      waitframe();
    }
  } else
    level waittill("forever");
}

destroycrateinbadtrigger() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("entity", "touchingBadTrigger")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("entity", "touchingBadTrigger")]]())
      thread destroycrate();
  }

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = self[[level._id_CA4E08767CBDAE12]](self.origin);

    if(!_id_425925A45729DEAE) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        _id_6BC61919B35C1A79 = isDefined(self.owner) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](self.owner);

        if(!_id_6BC61919B35C1A79) {
          thread destroycrate();
          return;
        }

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("EQUIPMENT/PLANT_FAILED");

        if(isDefined(self.cratetype) && self.cratetype == "loadout_drop") {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "refundSuper"))
            self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "refundSuper")]]();
        } else if(isDefined(self.streakinfo) && isDefined(self.streakinfo.mpstreaksysteminfo)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct"))
            self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](self.streakinfo.mpstreaksysteminfo, "other");
        }
      }

      thread destroycrate();
    }
  }
}

initcratedropdata() {
  _id_962A30A9BB8C0F09 = spawnStruct();
  _id_962A30A9BB8C0F09.helis = [];
  _id_D8D1344707480943 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(_id_D8D1344707480943))
    _id_962A30A9BB8C0F09.heliheight = _id_D8D1344707480943.origin[2] - 750;
  else
    _id_962A30A9BB8C0F09.heliheight = 2000;

  _id_962A30A9BB8C0F09.heliheightoffset = 128;
  level.cratedropdata = _id_962A30A9BB8C0F09;
  initscriptedhelidropdata();

  if(isDefined(level._id_55DAE6D1042D7E1E)) {
    foreach(_id_9590B22E3D9C08A3 in level._id_55DAE6D1042D7E1E)
    overridekillstreakcrateweight(_id_9590B22E3D9C08A3, 0);
  }
}

initscriptedhelidropdata() {
  initscriptedhelidropanims();
}

#using_animtree("script_model");

initscriptedhelidropanims() {
  level.scr_animtree["care_package"] = #animtree;
  level.scr_anim["care_package"]["care_package_drop"] = % mp_carepackage_ckpg_flyin;
  level.scr_animname["care_package"]["care_package_drop"] = "mp_carepackage_ckpg_flyin";
  level.scr_anim["care_package"]["care_package_capture"] = % mp_military_carepackage_straps_falling;
  level.scr_animname["care_package"]["care_package_capture"] = "mp_military_carepackage_straps_falling";
  level.scr_animtree["care_package_chute"] = #animtree;
  level.scr_anim["care_package_chute"]["care_package_drop"] = % mp_carepackage_parachute_flyin;
  level.scr_animname["care_package_chute"]["care_package_drop"] = "mp_carepackage_parachute_flyin";
  initscriptedhelidropvehicleanims();
  initbrc130airdropdropanims();
}

#using_animtree("mp_vehicles_always_loaded");

initscriptedhelidropvehicleanims() {
  level.scr_animtree["care_package_heli"] = #animtree;
  level.scr_anim["care_package_heli"]["care_package_drop"] = % mp_carepackage_lbravo_flyin;
}

#using_animtree("script_model");

initbrc130airdropdropanims() {
  level.scr_anim["care_package"]["brc130_drop_high"] = % mp_carepackage_ckpg_flyin_10500;
  level.scr_animname["care_package"]["brc130_drop_high"] = "mp_carepackage_ckpg_flyin_10500";
  level.scr_anim["care_package"]["brc130_drop_med"] = % mp_carepackage_ckpg_flyin_7500;
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

placecrate(owner, team, cratetype, position, angles, data, skipminimapicon) {
  return createcrate(owner, team, cratetype, position, angles, undefined, 1, 0, data, skipminimapicon, position);
}

dropcrate(owner, team, cratetype, position, angles, destination, data, skipminimapicon) {
  if(!isDefined(destination)) {
    caststart = getcratedropcaststart(position, 0);
    destination = getcratedropdestination(caststart, getcratedropcastend(caststart, 0));
  }

  return createcrate(owner, team, cratetype, position, angles, destination, undefined, 1, data, skipminimapicon, position);
}

dropcratefrommanualheli(owner, team, cratetype, position, angles, _id_9ABEB4585AF3BD0E, _id_7862C7C7ADE2B42E, destination, data) {
  position = getcratedropcaststart(position, 1);
  height = position[2];

  if(!isDefined(destination)) {
    destination = getcratedropdestination(position, getcratedropcastend(position, 1));

    if(!isDefined(destination))
      return undefined;
  }

  dropstruct = spawnStruct();
  dropstruct.owner = owner;
  dropstruct.team = team;
  dropstruct.hasowner = isDefined(owner);
  angles = angles * (0, 1, 0);
  _id_16CEDB94FAF4D596 = position + -1 * anglesToForward(angles) * _id_9ABEB4585AF3BD0E;
  dropstruct.dropposition = position;
  dropstruct.exitposition = position + anglesToForward(angles) * _id_7862C7C7ADE2B42E;
  vehicleisreserved = undefined;

  if(isDefined(data))
    vehicleisreserved = data.vehicleisreserved;

  heli = createheli(owner, team, _id_16CEDB94FAF4D596, angles, vehicleisreserved);
  heli.dropstruct = dropstruct;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]())
      heli vehicle_setspeed(100, 60);
    else
      heli vehicle_setspeed(200, 100);
  }

  heli setmaxpitchroll(15, 15);
  heli setscriptablepartstate("lights", "active", 1);
  dropstruct.heli = heli;
  crate = createcrate(owner, team, cratetype, _id_16CEDB94FAF4D596, heli.angles, destination, undefined, 0, data, undefined, position);
  crate.dropstruct = dropstruct;
  crate linkTo(heli, "tag_origin", (16, 0, -156), (0, 0, 0));
  dropstruct.crate = crate;
  dropstruct thread watchdropcratefrommanualheli();
  return dropstruct;
}

watchdropcratefrommanualheli() {
  self endon("death");
  watchdropcratefrommanualheliinternal();

  if(isDefined(self.crate))
    self.crate thread destroycrate();

  if(isDefined(self.heli))
    self.heli thread destroyheli();
}

watchdropcratefrommanualheliinternal() {
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
    self.heli scripts\engine\utility::waittill_any_2("death", "goal");

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      thread docratedropfrommanualheli();
      return;
    }

    self.heli scripts\engine\utility::waittill_notify_or_timeout("death", 0.25);

    if(isDefined(self.crate) && !istrue(self.crate.isdestroyed))
      thread docratedropfrommanualheli();

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }
    self.heli scripts\engine\utility::waittill_notify_or_timeout("death", 0.5);

    if(!isDefined(self.heli) || istrue(self.heli.isdestroyed)) {
      return;
    }
    if(distancesquared(self.heli.origin, self.exitposition) > 5184) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType")) {
        if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]())
          self.heli vehicle_setspeed(100, 60);
        else
          self.heli vehicle_setspeed(150, 50);
      }

      self.heli setvehgoalpos(self.exitposition, 1);
      self.heli scripts\engine\utility::waittill_any_2("death", "goal");
    }
  }
}

docratedropfrommanualheli() {
  crate = self.crate;
  self.crate.dropstruct = undefined;
  self.crate = undefined;
  crate cratephysicson();
}

createcrateforscripteddrop(owner, team, cratetype, destination, hasnophysics, _id_6244A1D5B282BB6C, data, streakinfo, scenenode, animname, _id_3F70F46831DB1173, _id_8D8A84ACC6EFADFF, _id_FE880EB7782C9EA0) {
  crate = createcrate(owner, team, cratetype, scenenode.origin, scenenode.angles, destination, hasnophysics, _id_6244A1D5B282BB6C, data, undefined, _id_FE880EB7782C9EA0);

  if(!isDefined(crate))
    return undefined;

  crate.scenenode = scenenode;
  crate.streakinfo = streakinfo;

  if(!isDefined(scenenode.crates))
    scenenode.crates = [];

  scenenode.crates[crate getentitynumber()] = crate;
  crate setscriptablepartstate("visibility", "hide", 0);
  crate.animname = animname;
  crate scripts\common\anim::setanimtree();
  _id_55A416C7A58BEA99 = level.scr_anim[animname][_id_3F70F46831DB1173];
  _id_0FEB55C68B4B9610 = getanimlength(_id_55A416C7A58BEA99) * 1000;
  crate.animdroptime = undefined;
  crate.animstoptrailtime = undefined;
  crate.animendtime = gettime() + _id_0FEB55C68B4B9610;

  if(!istrue(_id_8D8A84ACC6EFADFF)) {
    crate.animdroptime = gettime() + getnotetracktimes(_id_55A416C7A58BEA99, "carepackage_drop")[0] * _id_0FEB55C68B4B9610;
    crate.animstoptrailtime = gettime() + getnotetracktimes(_id_55A416C7A58BEA99, "carepackage_trail_end")[0] * _id_0FEB55C68B4B9610;
  }

  scenenode.latestanimendtime = scripts\engine\utility::ter_op(crate.animendtime > scenenode.latestanimendtime, crate.animendtime, scenenode.latestanimendtime);
  return crate;
}

createchuteforscripteddrop(scenenode, crate, animname, _id_3F70F46831DB1173) {
  if(!isDefined(scenenode.chutes))
    scenenode.chutes = [];

  chute = spawn("script_model", scenenode.origin);
  chute.angles = scenenode.origin;
  chute.scenenode = scenenode;
  chute.crate = crate;
  chute.crateanimdroptime = crate.animdroptime;
  scenenode.chutes[chute getentitynumber()] = chute;
  chute setModel("veh9_mil_lnd_parachute_carepackage_mp");
  chute setscriptablepartstate("visibility", "hide", 0);
  chute.animname = animname;
  chute scripts\common\anim::setanimtree();
  _id_4ADBA587D6BEFDD3 = level.scr_anim[animname][_id_3F70F46831DB1173];
  _id_D211250DB97A000A = getanimlength(_id_4ADBA587D6BEFDD3) * 1000;
  chute.animendtime = gettime() + getanimlength(level.scr_anim[animname][_id_3F70F46831DB1173]) * 1000;
  chute.animunhidetime = gettime() + getnotetracktimes(_id_4ADBA587D6BEFDD3, "chute_unhide")[0] * _id_D211250DB97A000A;
  chute.animendtime = gettime() + _id_D211250DB97A000A;
  scenenode.latestanimendtime = scripts\engine\utility::ter_op(chute.animendtime > scenenode.latestanimendtime, chute.animendtime, scenenode.latestanimendtime);
  return chute;
}

destroychute() {
  if(isDefined(self.scenenode))
    self.scenenode.chutes[self getentitynumber()] = undefined;

  self delete();
}

dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, data, streakinfo) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]())
      return undefined;
  }

  _id_EBB5C644A3F5CFBC = getcratedropcaststart(position, 1);
  _id_46D5F28D2724BF1F = angles * (0, 1, 0);
  destination = getcratedropdestination(_id_EBB5C644A3F5CFBC, getcratedropcastend(_id_EBB5C644A3F5CFBC, 1), destination);

  if(!isDefined(destination))
    return undefined;

  _id_EBB5C644A3F5CFBC = destination + (0, 0, 2000);
  scenenode = spawn("script_model", _id_EBB5C644A3F5CFBC);
  scenenode.angles = _id_46D5F28D2724BF1F;
  scenenode setModel("tag_origin");
  scenenode.owner = owner;
  scenenode.team = team;
  scenenode.hasowner = isDefined(owner);
  vehicleisreserved = undefined;

  if(isDefined(data))
    vehicleisreserved = data.vehicleisreserved;

  heli = createheli(owner, team, _id_EBB5C644A3F5CFBC, _id_46D5F28D2724BF1F, vehicleisreserved, streakinfo);

  if(!isDefined(heli)) {
    scenenode delete();
    return undefined;
  }

  heli.scenenode = heli;
  heli setscriptablepartstate("visibility", "hide", 0);
  heli.animname = "care_package_heli";
  scenenode.heli = heli;
  scenenode.heliendtime = gettime() + getanimlength(level.scr_anim["care_package_heli"]["care_package_drop"]) * 1000;
  scenenode.latestanimendtime = scenenode.heliendtime;
  crate = createcrateforscripteddrop(owner, team, cratetype, destination, undefined, 0, data, streakinfo, scenenode, "care_package", "care_package_drop", undefined, position);

  if(!isDefined(crate))
    return undefined;

  chute = createchuteforscripteddrop(scenenode, crate, "care_package_chute", "care_package_drop");

  if(!isDefined(chute))
    return undefined;

  chute setscriptablepartstate("visibility", "hide", 0);
  scenenode thread watchdropcratefromscriptedheli();
  return scenenode;
}

watchdropcratefromscriptedheli() {
  self endon("death");
  scripts\common\anim::anim_first_frame_solo(self.heli, "care_package_drop");

  foreach(crate in self.crates)
  scripts\common\anim::anim_first_frame_solo(crate, "care_package_drop");

  foreach(chute in self.chutes)
  scripts\common\anim::anim_first_frame_solo(chute, "care_package_drop");

  watchdropcratefromscriptedheliinternal();

  if(isDefined(self.heli))
    self.heli thread destroyheli();

  foreach(crate in self.crates) {
    if(isDefined(crate))
      crate thread destroycrate();
  }

  foreach(chute in self.chutes) {
    if(isDefined(chute))
      chute thread destroychute();
  }

  self delete();
}

watchdropcratefromscriptedheliinternal() {
  _id_DDD3DF8D5EA97F86 = undefined;

  while(gettime() <= self.latestanimendtime) {
    if(self.hasowner) {
      if(!isDefined(self.ownerdisconnected)) {
        if(isDefined(self.owner)) {
          if(!isDefined(self.ownerjoinedteam)) {
            if(self.team != self.owner.team)
              self.ownerjoinedteam = 1;
          }
        } else
          self.ownerdisconnected = 1;
      }
    }

    if(!isDefined(_id_DDD3DF8D5EA97F86))
      _id_DDD3DF8D5EA97F86 = 1;
    else if(_id_DDD3DF8D5EA97F86) {
      if(isDefined(self.heli)) {
        self.heli setscriptablepartstate("visibility", "show", 0);
        self.heli setscriptablepartstate("lights", "active", 1);
        thread scripts\common\anim::anim_single_solo(self.heli, "care_package_drop");
      }

      foreach(crate in self.crates) {
        if(isDefined(crate)) {
          crate setscriptablepartstate("visibility", "show", 0);
          thread scripts\common\anim::anim_single_solo(crate, "care_package_drop");
        }
      }

      foreach(chute in self.chutes) {
        if(isDefined(chute)) {
          thread scripts\common\anim::anim_single_solo(chute, "care_package_drop");
          chute playsoundonmovingent("iw9_carepackage_parachute_drop");
        }
      }

      _id_DDD3DF8D5EA97F86 = 0;
    } else {
      _id_3A8CAC6C1D60003C = istrue(self.ownerdisconnected) || istrue(self.ownerjoinedteam);

      if(isDefined(self.heli)) {
        if(_id_3A8CAC6C1D60003C || gettime() > self.heliendtime)
          self.heli destroyheli();
      }

      foreach(crate in self.crates) {
        if(isDefined(crate)) {
          if(gettime() > crate.animendtime) {
            if(_id_3A8CAC6C1D60003C)
              crate thread destroycrate();

            thread docratedropfromscripted(crate);
            continue;
          }

          if(gettime() > crate.animdroptime) {
            if(gettime() > crate.animstoptrailtime)
              crate setscriptablepartstate("trail", "neutral", 1);
            else
              crate setscriptablepartstate("trail", "active", 1);

            if(_id_3A8CAC6C1D60003C)
              crate thread destroycrate();

            continue;
          }

          if(_id_3A8CAC6C1D60003C) {
            crate thread destroycrate();
            continue;
          }

          if(!isDefined(self.heli) || istrue(self.heli.isdestroyed))
            thread docratedropfromscripted(crate);
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

          if(gettime() > chute.animunhidetime)
            chute setscriptablepartstate("visibility", "show", 0);
        }
      }
    }

    waitframe();
  }
}

docratedropfromscripted(crate) {
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

getcratedropcaststart(position, _id_5E43D97DFC3D0419, droptype) {
  caststart = undefined;

  if(istrue(_id_5E43D97DFC3D0419))
    caststart = position * (1, 1, 0) + (0, 0, getscriptedhelidropheight(droptype));
  else
    caststart = position + (0, 0, 25);

  return caststart;
}

getcratedropcastend(caststart, _id_5E43D97DFC3D0419) {
  return caststart + (0, 0, -1 * scripts\engine\utility::ter_op(istrue(_id_5E43D97DFC3D0419), 25000, 25000));
}

getcratedropdestination(caststart, castend, destination) {
  ignorelist = getcratedropignorelist();
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0);
  _id_C59C5C63BF590651 = scripts\engine\trace::sphere_trace(caststart, castend, 100, ignorelist, contentoverride);

  if(_id_C59C5C63BF590651["hittype"] != "hittype_none" && isDefined(_id_C59C5C63BF590651["position"])) {
    if(isDefined(destination))
      destination = (destination[0], destination[1], _id_C59C5C63BF590651["position"][2]);
    else
      destination = _id_C59C5C63BF590651["position"];
  }

  return destination;
}

getcratedropignorelist() {
  if(isDefined(level.cratedata.helis) && isDefined(level.cratedata.ac130s))
    return scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedropdata.ac130s, level.cratedata.crates]);
  else
    return scripts\engine\utility::array_combine_multiple([level.cratedropdata.helis, level.cratedata.crates]);
}

createheli(owner, team, position, angles, vehicleisreserved, streakinfo) {
  heli = undefined;
  _id_B514D5120067A18A = "veh_airdrop_mp_phys";
  _id_F98416D816CEEC66 = "veh9_mil_air_heli_medium_airdrop_mp";

  if(istrue(vehicleisreserved))
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  heli = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, position, angles, _id_B514D5120067A18A, _id_F98416D816CEEC66);

  if(!isDefined(heli))
    return undefined;

  if(!isDefined(team))
    team = "neutral";

  if(team != "neutral")
    heli setvehicleteam(team);

  heli.owner = owner;
  heli.team = team;
  destroyedsplash = undefined;
  vodestroyed = undefined;
  scorepopup = undefined;

  if(isDefined(level.heliconfigs)) {
    config = level.heliconfigs["airdrop"];
    heli.health = config.maxhealth;
    _id_5A127424B8DF87B6 = config.callout;
    vodestroyed = config.vodestroyed;
    scorepopup = config.scorepopup;
  } else
    heli.health = 999999;

  heli.helitype = "airdrop";
  heli setscriptablepartstate("engine", "on", 0);
  level thread scripts\cp_mp\utility\killstreak_utility::_id_EE93617532D8A679(heli, owner, undefined, undefined, 1);

  if(isDefined(owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList"))
      heli[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]]("airdrop", "Killstreak_Air", owner, 0, 0);

    if(team != "neutral")
      heli scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakMakeVehicle"))
    heli[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakMakeVehicle")]](_id_B514D5120067A18A, scorepopup, vodestroyed, destroyedsplash);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPreModDamageCallback"))
    heli[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPreModDamageCallback")]](_id_B514D5120067A18A);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback"))
    heli[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](_id_B514D5120067A18A);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "killstreakSetDeathCallback"))
    heli[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "killstreakSetDeathCallback")]](_id_B514D5120067A18A, ::destroyhelicallback);

  heli setCanDamage(0);
  heli thread watchhelidestroyearly();
  return heli;
}

watchhelidestroyearly() {
  self endon("death");
  watchhelidestroyearlyinternal();
  thread destroyheli();
}

watchhelidestroyearlyinternal() {
  self endon("death");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");
  level waittill("forever");
}

destroyheli() {
  thread deleteheli(0);
}

deleteheli(delay) {
  self notify("death");
  self.isdestroyed = 1;

  if(isDefined(self.scenenode)) {
    self.scenenode.heli = undefined;
    self.scenenode = undefined;
  }

  removehelidroppingcratefromlist(self getentitynumber());
  wait(delay);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

destroyhelicallback(data) {
  destroyheli();
}

getscriptedhelidropheightbase(droptype) {
  return level.cratedropdata.heliheight;
}

getscriptedhelidropheight(droptype) {
  return getscriptedhelidropheightbase(droptype) + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

addhelidroppingcratetolist(heli) {
  entnum = heli getentitynumber();
  level.cratedropdata.helis[entnum] = heli;
}

removehelidroppingcratefromlist(entnum) {
  level.cratedropdata.helis[entnum] = undefined;
}

makecrateusable() {
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(istrue(_id_962A30A9BB8C0F09.hasnointeraction)) {
    return;
  }
  level.cratedata.usablecrates[self getentitynumber()] = self;
  self.isusable = 1;

  if(_id_962A30A9BB8C0F09.supportsownercapture && _id_962A30A9BB8C0F09.supportsothercapture) {
    thread watchcrateuse(1);
    useobject = self.useobject;

    if(!isDefined(useobject)) {
      useobject = spawn("script_model", self gettagorigin(_id_962A30A9BB8C0F09.usetag));
      useobject setModel("tag_origin");
      useobject linkTo(self);
      useobject makeunusable();
      self.useobject = useobject;
    }

    thread watchcrateuse(2, useobject);
  } else if(_id_962A30A9BB8C0F09.supportsownercapture)
    thread watchcrateuse(1);
  else
    thread watchcrateuse(2);
}

watchcrateuse(usetype, useobject) {
  self endon("death");
  self endon("makeCrateUnusable");

  if(isDefined(useobject))
    useobject endon("death");

  if(usetype == 1) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
    self.owner.isffprotectedaction = 1;
  }

  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);
  _id_EF5D5141FDB51174 = gettriggerobject(useobject);
  _id_EF5D5141FDB51174.usetype = usetype;
  _id_EF5D5141FDB51174.userate = 1;
  _id_EF5D5141FDB51174.curprogress = 0;

  if(isDefined(_id_EF5D5141FDB51174.usetimeoverride))
    _id_EF5D5141FDB51174.usetime = _id_EF5D5141FDB51174.usetimeoverride;
  else
    _id_EF5D5141FDB51174.usetime = scripts\engine\utility::ter_op(usetype == 1, _id_962A30A9BB8C0F09.ownerusetime, _id_962A30A9BB8C0F09.otherusetime);

  _id_EF5D5141FDB51174.inuse = 0;
  _id_EF5D5141FDB51174.playerusing = undefined;

  for(;;) {
    _id_EF5D5141FDB51174 waittill("trigger", player);

    if(getdvarint("dvar_618B9C003B5B3883", 0) == 0) {
      if(isDefined(self.disabled_use_for) && istrue(self.disabled_use_for[player getentitynumber()])) {
        player scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("airdrop", "airdrop_cannotUseLoadoutCrateHint");
        continue;
      }
    }

    if(istrue(player.isjuggernaut) && !player juggcanusecrate(self.cratetype)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/JUGG_CANNOT_BE_USED");

      continue;
    }

    if(istrue(player._id_5B3C77E2EAFAB370) || isDefined(player._id_AC19F9B9C6C841B9) && player._id_AC19F9B9C6C841B9 == "chopper" || istrue(player._id_35DADE814E13D3CE)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/CANNOT_USE_GENERIC");

      continue;
    }

    if(canstartusingcrate(player, useobject)) {
      startusingcrate(player, useobject);
      player.isffprotectedaction = 1;
      _id_EF5D5141FDB51174.playerusing = player;
      result = watchcrateuseinternal(player, useobject);

      if(isDefined(player))
        stopusingcrate(player, useobject);

      _id_EF5D5141FDB51174.playerusing = undefined;

      if(istrue(result)) {
        if(isDefined(player))
          player.isffprotectedaction = 0;

        if(_id_962A30A9BB8C0F09.onecaptureperplayer && self.cratetype != "battle_royale_loadout") {
          if(getdvarint("dvar_618B9C003B5B3883") == 0) {
            if(!isDefined(self.playerscaptured))
              self.playerscaptured = [];

            self.playerscaptured[player getentitynumber()] = player;
          }
        }

        if(!isDefined(self.targetname) || self.targetname != "btm_flag_primary_inside")
          thread capturecrate(player);
      }
    }
  }
}

watchcrateuseinternal(player, useobject) {
  _id_EF5D5141FDB51174 = gettriggerobject(useobject);

  if(_id_EF5D5141FDB51174.usetype != 1) {
    player endon("disconnect");
    player endon("joined_team");
    player endon("joined_spectators");
  }

  _id_EF5D5141FDB51174.id = _id_7972A1043E6FACAB();
  _id_EF5D5141FDB51174.userate = scripts\engine\utility::ter_op(isDefined(player.objectivescaler), player.objectivescaler, 1);
  playusesound(player, useobject);

  while(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive() && cankeepusingcrate(player, useobject) && player useButtonPressed()) {
    _id_EF5D5141FDB51174.curprogress = _id_EF5D5141FDB51174.curprogress + level.framedurationseconds * _id_EF5D5141FDB51174.userate;

    if(_id_EF5D5141FDB51174.curprogress >= _id_EF5D5141FDB51174.usetime) {
      _id_EF5D5141FDB51174.curprogress = 0.0;
      return 1;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](_id_EF5D5141FDB51174, 1);

    waitframe();
  }

  _id_EF5D5141FDB51174.curprogress = 0.0;
  return 0;
}

_id_7972A1043E6FACAB() {
  if(scripts\common\utility::iscp())
    return "use";

  return "care_package";
}

makecrateunusable() {
  self notify("makeCrateUnusable");
  level.cratedata.usablecrates[self getentitynumber()] = undefined;
  self.isusable = 0;

  if(isDefined(self.playerusing))
    stopusingcrate(self.playerusing);

  self.playerusing = undefined;
  self makeunusable();

  if(isDefined(self.useobject)) {
    if(isDefined(self.useobject.playerusing))
      stopusingcrate(self.useobject.playerusing, self.useobject);

    self.useobject makeunusable();
  }
}

startusingcrate(player, useobject) {
  if(!isDefined(self.playersusing))
    self.playersusing = [];

  if(!scripts\engine\utility::array_contains(self.playersusing, player))
    self.playersusing = scripts\engine\utility::array_add(self.playersusing, player);

  _id_EF5D5141FDB51174 = gettriggerobject(useobject);
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(istrue(player.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 0);
  } else {
    _id_5E8F3DEE82C118CF = getdvarint("dvar_D15C22F57683ADD1", 1);

    if(_id_5E8F3DEE82C118CF)
      player thread airdrop_givecrateuseweapon();

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress"))
    player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](_id_EF5D5141FDB51174, 0);
}

airdrop_givecrateuseweapon() {
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\utility\weapon_utility::saveweaponstates();
  _id_FF937324B8D5708D = makeweapon("ks_use_crate_mp");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_FF937324B8D5708D);
  thread airdrop_watchforcrateuseend(_id_FF937324B8D5708D);
  self switchtoweapon(_id_FF937324B8D5708D);
}

airdrop_watchforcrateuseend(_id_FF937324B8D5708D) {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("crate_use_end");

  if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(_id_FF937324B8D5708D))
    scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(_id_FF937324B8D5708D);
  else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_FF937324B8D5708D);

    if(isDefined(self.lastdroppableweaponobj)) {
      lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates(self.lastdroppableweaponobj);
      self switchtoweapon(lastweaponobj);
      thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(lastweaponobj);
    }
  }
}

stopusingcrate(player, useobject) {
  if(scripts\engine\utility::array_contains(self.playersusing, player))
    self.playersusing = scripts\engine\utility::array_remove(self.playersusing, player);

  _id_EF5D5141FDB51174 = gettriggerobject(useobject);
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(istrue(player.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("juggCrateUse", 1);
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "allowActionSet"))
    player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "allowActionSet")]]("crateUse", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "updateUIProgress"))
    player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "updateUIProgress")]](_id_EF5D5141FDB51174, 0);

  stopusesound(player, useobject);
  player notify("crate_use_end");
}

canstartusingcrate(player, useobject, _id_C83F8B96968AFE72) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "specialCase_canUseCrate")) {
    if(!player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "specialCase_canUseCrate")]]())
      return 0;
  }

  if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("crate_use"))
    return 0;

  if(!player scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(player isonladder())
    return 0;

  if(getdvarint("dvar_618B9C003B5B3883", 0) == 0) {
    if(isDefined(self.playerscaptured) && isDefined(self.playerscaptured[player getentitynumber()]))
      return 0;
  }

  if(istrue(self.issquadonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, player))
      return 0;

    if(player._id_0FF97225579DE16A != self._id_0FF97225579DE16A || player.team != self.team)
      return 0;
  }

  if(istrue(self.isteamonlycrate)) {
    if(isDefined(self.playersused) && scripts\engine\utility::array_contains(self.playersused, player))
      return 0;

    if(player.team != self.team)
      return 0;
  }

  if(!self.isusable)
    return 0;

  if(!isDefined(_id_C83F8B96968AFE72))
    _id_C83F8B96968AFE72 = 1;

  if(_id_C83F8B96968AFE72)
    return canstartusingcratetriggerobject(player, useobject);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && player isskydiving())
    return 0;

  if(istrue(player.inlaststand))
    return 0;

  return 1;
}

canstartusingcratetriggerobject(player, useobject) {
  _id_EF5D5141FDB51174 = gettriggerobject(useobject);

  if(isDefined(_id_EF5D5141FDB51174.playerusing) && _id_EF5D5141FDB51174.playerusing != player)
    return 0;

  if(_id_EF5D5141FDB51174.usetype == 1 && (!isDefined(self.owner) || player != self.owner))
    return 0;

  if(_id_EF5D5141FDB51174.usetype == 2 && (isDefined(self.owner) && player == self.owner))
    return 0;

  if(level.teambased && isDefined(self.team) && self.team != "neutral") {
    _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

    if(_id_962A30A9BB8C0F09.friendlyuseonly && player.team != self.team)
      return 0;
  }

  return 1;
}

cankeepusingcrate(player, useobject) {
  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("crate_use"))
    return 0;

  if(!player scripts\cp_mp\utility\player_utility::_isalive())
    return 0;

  if(player meleeButtonPressed())
    return 0;

  if(player isinexecutionvictim())
    return 0;

  if(istrue(player.inlaststand))
    return 0;

  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(isDefined(_id_962A30A9BB8C0F09.breakuserangesqr) && distancesquared(player.origin, gettriggerobject(useobject).origin) >= _id_962A30A9BB8C0F09.breakuserangesqr)
    return 0;

  if(!self.isusable)
    return 0;

  if(isDefined(self.cratetype) && self.cratetype == "loadout_drop") {
    if(!player isonground() && !player _meth_E40102956C887F7C())
      return 0;
  }

  return 1;
}

makecrateusableforplayer(crate, player) {
  _id_EF5D5141FDB51174 = crate gettriggerobject();
  _id_B21DEA8DC3360508(_id_EF5D5141FDB51174, crate);

  if(isDefined(crate.useobject)) {
    _id_EF5D5141FDB51174 = crate gettriggerobject(crate.useobject);
    _id_B21DEA8DC3360508(_id_EF5D5141FDB51174, crate);
  }

  crate enableplayeruse(player);

  if(isDefined(crate.useobject))
    crate.useobject enableplayeruse(player);

  if(!crate canstartusingcrate(player, crate.useobject, 0)) {
    crate disableplayeruse(player);

    if(isDefined(crate.useobject))
      crate.useobject disableplayeruse(player);
  } else {
    if(!crate canstartusingcratetriggerobject(player, undefined))
      crate disableplayeruse(player);

    if(isDefined(crate.useobject)) {
      if(!crate canstartusingcratetriggerobject(player, crate.useobject))
        crate.useobject disableplayeruse(player);
    }
  }
}

_id_B21DEA8DC3360508(_id_EF5D5141FDB51174, crate) {
  _id_962A30A9BB8C0F09 = getleveldata(crate.cratetype);

  if(!scripts\common\utility::iscp()) {
    _id_EF5D5141FDB51174 setCursorHint("HINT_NOICON");
    _id_EF5D5141FDB51174 sethintonobstruction("show");
  } else {
    _id_EF5D5141FDB51174 setCursorHint("HINT_BUTTON");
    _id_EF5D5141FDB51174 sethintonobstruction("hide");
  }

  _id_EF5D5141FDB51174 sethinttag(_id_962A30A9BB8C0F09.usetag);
  _id_EF5D5141FDB51174 sethintdisplayrange(_id_962A30A9BB8C0F09.userange);
  _id_EF5D5141FDB51174 sethintdisplayfov(_id_962A30A9BB8C0F09.usefov);
  _id_EF5D5141FDB51174 setuserange(_id_962A30A9BB8C0F09.userange);
  _id_EF5D5141FDB51174 setusefov(_id_962A30A9BB8C0F09.usefov);
  _id_EF5D5141FDB51174 setusepriority(_id_962A30A9BB8C0F09.usepriority);
  _id_EF5D5141FDB51174 setuseholdduration("duration_none");

  if(_id_EF5D5141FDB51174.usetype == 1 && crate.supportsreroll)
    _id_EF5D5141FDB51174 setHintString(crate.rerollstring);
  else
    _id_EF5D5141FDB51174 setHintString(crate.capturestring);
}

watchallcrateusability() {
  _id_36AFCA263BBC6FBC = 0;

  if(getdvarint("dvar_08A7E8EB2A9A7101", 0))
    _id_36AFCA263BBC6FBC = 1;

  for(;;) {
    foreach(crate in level.cratedata.usablecrates) {
      if(!isDefined(crate)) {
        continue;
      }
      crate makeusable();

      if(istrue(_id_36AFCA263BBC6FBC))
        crate disableplayeruseforallplayers();

      if(isDefined(crate.useobject)) {
        crate.useobject makeusable();

        if(istrue(_id_36AFCA263BBC6FBC))
          crate.useobject disableplayeruseforallplayers();
      }

      playerlist = level.players;

      if(istrue(_id_36AFCA263BBC6FBC)) {
        if(level.teambased && isDefined(crate.team) && crate.team != "neutral") {
          _id_962A30A9BB8C0F09 = getleveldata(crate.cratetype);

          if(_id_962A30A9BB8C0F09.friendlyuseonly)
            playerlist = level.teamdata[crate.team]["alivePlayers"];
        }
      }

      foreach(player in playerlist) {
        if(istrue(_id_36AFCA263BBC6FBC)) {
          _id_4076D436F9878FDF = distancesquared(crate.origin, player.origin) < 57600.0;

          if(_id_4076D436F9878FDF)
            makecrateusableforplayer(crate, player);

          continue;
        }

        makecrateusableforplayer(crate, player);
      }
    }

    wait 0.1;
  }
}

playusesound(player, useobject) {
  _id_EF5D5141FDB51174 = gettriggerobject(useobject);

  if(_id_EF5D5141FDB51174.usetype == 1)
    player playLoopSound("mp_care_package_owner_cap");
  else
    player playLoopSound("mp_care_package_non_owner_cap");
}

stopusesound(player, useobject) {
  _id_EF5D5141FDB51174 = gettriggerobject(useobject);

  if(_id_EF5D5141FDB51174.usetype == 1)
    player stoploopsound("mp_care_package_owner_cap");
  else
    player stoploopsound("mp_care_package_non_owner_cap");

  if(player scripts\cp_mp\utility\player_utility::_isalive())
    player playsoundonmovingent("mp_care_package_cap_tail");
}

gettriggerobject(useobject) {
  return scripts\engine\utility::ter_op(isDefined(useobject), useobject, self);
}

cratephysicson(_id_4E1BD1F59F6A4FEF, _id_F8048727716242B0) {
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(isDefined(_id_962A30A9BB8C0F09.cratephysicsoncallback))
    self thread[[_id_962A30A9BB8C0F09.cratephysicsoncallback]]();

  if(!isDefined(_id_4E1BD1F59F6A4FEF))
    _id_4E1BD1F59F6A4FEF = (0, 0, 0);

  if(!isDefined(_id_F8048727716242B0))
    _id_F8048727716242B0 = (0, 0, 0);

  self unlink();
  self physicslaunchserver(_id_4E1BD1F59F6A4FEF, _id_F8048727716242B0);

  if(isDefined(self.killcament) && !istrue(self.killcament.linked))
    self.killcament linkTo(self, "tag_origin", (0, 0, 300), (0, 0, 0));

  _id_212A44A5393C3B34 = self physics_getbodyid(0);
  physics_setbodycenterofmassnormal(_id_212A44A5393C3B34, (0, 0, -0.75));
  self.physicsactivated = 1;
  createdangerzone();
  thread monitoraveragevelocityandupdate();
  thread monitorplayerimpact();

  if(isDefined(level.wztrain_info) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "handlemovingplatforms")) {
    data = spawnStruct();
    data.deathoverridecallback = ::_id_A4D56F106B5AD5F9;
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "handlemovingplatforms")]](data);
  }

  thread monitorimpact();
}

_id_A4D56F106B5AD5F9(data) {
  _id_834C12B34EA6616F = scripts\cp_mp\utility\train_utility::_id_00D6B0A591AC99BD();

  if(!isDefined(_id_834C12B34EA6616F)) {
    return;
  }
  if(scripts\engine\utility::is_equal(data.lasttouchedplatform, _id_834C12B34EA6616F)) {
    if(!istrue(self.hitbytrain)) {
      _id_F8048727716242B0 = _id_834C12B34EA6616F.velocity * 150;
      _id_4E1BD1F59F6A4FEF = _id_834C12B34EA6616F.origin + rotatevector((375, 0, -100), _id_834C12B34EA6616F.angles);
      self playSound("mp_care_package_high_impact");
      self physicslaunchserver(_id_4E1BD1F59F6A4FEF, _id_F8048727716242B0);
      self.hitbytrain = 1;
    } else {
      destroycrate();
      return;
    }
  }

  wait 1;
  data = spawnStruct();
  data.deathoverridecallback = ::_id_A4D56F106B5AD5F9;
  self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "handlemovingplatforms")]](data);
}

cratephysicsoff() {
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

monitoraveragevelocityandupdate() {
  self endon("death");
  self notify("monitorAverageVelocityAndUpdate");
  self endon("monitorAverageVelocityAndUpdate");
  _id_FEA57FA0E78C63DB = 0.1;
  thread monitoraveragevelocities(_id_FEA57FA0E78C63DB, 8);
  _id_0717E0CFD076F91D = 0;
  _id_4080D353839C6230 = 0;
  self.isfirstactivation = 1;
  _id_1684A0B0FB3502C6 = undefined;
  _id_42D273FE9538AF56 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated"))
    _id_42D273FE9538AF56 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated");

  for(;;) {
    avlinvel = getaveragelinearvelocity();
    avangvel = getaverageangularvelocity();

    if(isDefined(avlinvel) && isDefined(avangvel)) {
      if(avlinvel <= _id_3C4492046080FAA9() && avangvel <= _id_F7E3F128296AC3B6()) {
        _id_0717E0CFD076F91D++;
        _id_4080D353839C6230 = 0;

        if(_id_0717E0CFD076F91D == _id_D4833B6C916DB9C6()) {
          self.physicssettled = 1;
          _id_1684A0B0FB3502C6 = self.origin;
          thread activatecrate(self.isfirstactivation);

          if(isDefined(_id_42D273FE9538AF56) && [[_id_42D273FE9538AF56]]()) {
            monitorimpactend();

            if(isDefined(self.killcament))
              self.killcament delete();
          }

          _id_FEA57FA0E78C63DB = 0.1;
          thread monitoraveragevelocities(_id_FEA57FA0E78C63DB, 3, 3);
          destroycrateinbadtrigger();
        }
      } else {
        if(isDefined(_id_1684A0B0FB3502C6)) {
          if(distancesquared(self.origin, _id_1684A0B0FB3502C6) <= 2500) {
            wait(_id_FEA57FA0E78C63DB);
            continue;
          }
        }

        _id_4080D353839C6230++;
        _id_0717E0CFD076F91D = 0;

        if(_id_4080D353839C6230 == 1) {
          self.physicssettled = undefined;
          thread deactivatecrate();
          _id_FEA57FA0E78C63DB = 0.1;
          thread monitoraveragevelocities(_id_FEA57FA0E78C63DB, 8);
        }
      }

      wait(_id_FEA57FA0E78C63DB);
      continue;
    }

    waitframe();
  }
}

monitoraveragevelocities(_id_FEA57FA0E78C63DB, _id_6FB2F8A2DF503284, _id_2B14322307DD13AA) {
  clearaveragevelocities();
  self endon("death");
  self endon("clear_average_velocities");
  self.linvels = [];
  self.angvels = [];
  self.velstartid = 0;
  self.velendid = 0;
  self.velnumdatapoints = _id_6FB2F8A2DF503284;

  if(isDefined(_id_2B14322307DD13AA)) {
    _id_2B14322307DD13AA = int(clamp(_id_2B14322307DD13AA, 0, _id_6FB2F8A2DF503284));

    if(_id_2B14322307DD13AA > 0) {
      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2B14322307DD13AA; _id_AC0E594AC96AA3A8++) {
        self.linvels[self.velstartid + _id_AC0E594AC96AA3A8] = 0;
        self.angvels[self.velstartid + _id_AC0E594AC96AA3A8] = 0;
      }
    }
  }

  for(;;) {
    _id_212A44A5393C3B34 = self physics_getbodyid(0);
    _id_4DA28B63DE5AE3C7 = physics_getbodylinvel(_id_212A44A5393C3B34);
    _id_7CA7F0BB1A73C93A = physics_getbodyangvel(_id_212A44A5393C3B34);
    self.linvels[self.velendid] = length(_id_4DA28B63DE5AE3C7);
    self.angvels[self.velendid] = length(_id_7CA7F0BB1A73C93A);
    self.velendid++;
    _id_E8D39B65D6180C15 = self.velendid - self.velstartid;

    if(_id_E8D39B65D6180C15 > _id_6FB2F8A2DF503284) {
      _id_3B39CBEE3089469B = scripts\engine\utility::mod(_id_E8D39B65D6180C15, _id_6FB2F8A2DF503284);

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_3B39CBEE3089469B; _id_AC0E594AC96AA3A8++) {
        self.linvels[self.velstartid + _id_AC0E594AC96AA3A8] = undefined;
        self.angvels[self.velstartid + _id_AC0E594AC96AA3A8] = undefined;
      }

      self.velstartid = self.velstartid + _id_3B39CBEE3089469B;
    }

    self.avlinvel = undefined;
    self.avangvel = undefined;
    wait(_id_FEA57FA0E78C63DB);
  }
}

getaveragelinearvelocity() {
  if(isDefined(self.avlinvel))
    return self.avlinvel;

  if(!isDefined(self.linvels))
    return undefined;

  if(self.velendid - self.velstartid < self.velnumdatapoints)
    return undefined;

  calculateaveragevelocities();
  return self.avlinvel;
}

getaverageangularvelocity() {
  if(isDefined(self.avangvel))
    return self.avangvel;

  if(!isDefined(self.angvels))
    return undefined;

  if(self.velendid - self.velstartid < self.velnumdatapoints)
    return undefined;

  calculateaveragevelocities();
  return self.avangvel;
}

calculateaveragevelocities() {
  _id_7A89FCE67703419F = 0;
  _id_3386DDE146FD60B4 = 0;

  for(_id_AC0E594AC96AA3A8 = self.velstartid; _id_AC0E594AC96AA3A8 < self.velendid; _id_AC0E594AC96AA3A8++) {
    _id_7A89FCE67703419F = _id_7A89FCE67703419F + self.linvels[_id_AC0E594AC96AA3A8];
    _id_3386DDE146FD60B4 = _id_3386DDE146FD60B4 + self.angvels[_id_AC0E594AC96AA3A8];
  }

  self.avlinvel = _id_7A89FCE67703419F / self.velnumdatapoints;
  self.avangvel = _id_3386DDE146FD60B4 / self.velnumdatapoints;
}

clearaveragevelocities() {
  self notify("clear_average_velocities");
  self.linvels = undefined;
  self.angvels = undefined;
  self.velnumdatapoints = undefined;
  self.velstartid = undefined;
  self.velendid = undefined;
  self.avlinvel = undefined;
  self.avangvel = undefined;
}

monitorimpact(delay) {
  monitorimpactend();
  self endon("monitorImpactEnd");
  self.monitoringimpact = 1;
  self playLoopSound("mp_care_package_drop_lp");
  self physics_registerforcollisioncallback();
  monitorimpactinternal(delay);

  if(isDefined(self))
    thread monitorimpactend();
}

monitorimpactinternal(delay) {
  self endon("death");

  if(isDefined(delay))
    wait(delay);

  _id_260EF1536027D0E1 = 0;
  _id_20BE7F8F0DC3DB57 = 0;

  for(;;) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, _id_D71630B8BAF84FA8, ent);

    if(!istrue(_id_20BE7F8F0DC3DB57)) {
      if(isDefined(self.killcament)) {
        self.killcament unlink();
        self.killcament.linked = 0;
      }

      _id_20BE7F8F0DC3DB57 = 1;
    }

    if(isDefined(ent)) {
      if(impactshoulddestroyent(ent)) {
        if(isDefined(ent.vehicletype)) {
          if(isDefined(ent.streakinfo)) {
            if(isDefined(ent._id_3098BBCD22D0E052) && isDefined(ent._id_3098BBCD22D0E052.cleanupfunc))
              ent thread[[ent._id_3098BBCD22D0E052.cleanupfunc]]();
            else if(ent scripts\cp_mp\killstreaks\helper_drone::ishelperdrone())
              ent thread scripts\cp_mp\killstreaks\helper_drone::_id_BA1C5496F8FC5F67();
          } else if(getdvarint("dvar_35D73D70C6843CE8", 1)) {
            _id_62CCFB7EA15A4520 = ent scripts\cp_mp\vehicles\vehicle::_id_62CCFB7EA15A4520();

            if(!_id_62CCFB7EA15A4520 && !istrue(ent._id_A2BA7043631B3392)) {
              ent._id_A8F4BB03B366AA80 = 1;
              ent scripts\cp_mp\vehicles\vehicle::_id_AB08028468AB68F9();
            }
          }
        } else if(ent.classname == "scriptable_iw8_chicken_01")
          thread airdrop_crushchicken(ent);
        else if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover")
          ent[[ent.deletefunc]](0, 1, 1);
        else if(isDefined(ent.turrettype) && ent.turrettype == "sentry_turret")
          ent notify("kill_turret", 1, 1);
      }

      checklinktotrain(ent);
    }

    if(gettime() - _id_260EF1536027D0E1 >= 200) {
      _id_260EF1536027D0E1 = gettime();
      _id_895F3C282BC9FC68 = physics_getsurfacetypefromflags(flag1);
      surfacetype = getsubstr(_id_895F3C282BC9FC68["name"], 9);

      if(surfacetype == "glass_pane") {
        glassradiusdamage(self.origin - (0, 0, 10), 100, 1000, 1000);
        waitframe();
        cratephysicson();
      }

      if(surfacetype == "water" && !istrue(self._id_51AB77B2BA57C5DD))
        self._id_51AB77B2BA57C5DD = 1;

      if(surfacetype == "user_terrain1")
        surfacetype = "user_terrain_1";

      if(surfacetype == "user_terrain5")
        surfacetype = "user_terrain_5";

      playimpactfx(position, normal, _id_D71630B8BAF84FA8, surfacetype);
    }
  }
}

checklinktotrain(ent) {
  if(isDefined(ent) && isDefined(ent.script_noteworthy) && isstartstr(ent.script_noteworthy, "train_") && !isDefined(self getlinkedparent())) {
    if(isDefined(self.trainent)) {
      if(self.trainent == ent)
        return;
      else
        cancelchecklinktotrain();
    }

    self.trainent = ent;
    self.traincylestolink = 4;
    thread checklinktotraininternal(ent);
  }
}

checklinktotraininternal(ent) {
  self endon("death");
  self endon("cancel_link_to_train");
  ent endon("death");
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1, 1, 0, 0);
  ignorelist = [self];

  foreach(linkedent in self getlinkedchildren(1))
  ignorelist[ignorelist.size] = linkedent;

  self.traintracefails = 0;
  self.traintracesuccesses = 0;

  while(self.traintracefails < 20) {
    caststart = self.origin + anglestoup(self.angles) * _id_962A30A9BB8C0F09.halfheight;
    castend = caststart + (0, 0, -200);
    _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace(caststart, castend, ignorelist, contents);

    if(_id_1F0571D36D0DF95B.size > 0 && isDefined(_id_1F0571D36D0DF95B["entity"]) && scripts\cp_mp\utility\train_utility::is_train_ent(_id_1F0571D36D0DF95B["entity"])) {
      traintracerelpos = combineangles(invertangles(ent.angles), ent.origin - _id_1F0571D36D0DF95B["position"]);

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
    } else
      break;

    wait 0.1;
  }

  thread cancelchecklinktotrain();
}

cancelchecklinktotrain() {
  self notify("cancel_link_to_train");
  self.trainent = undefined;
  self.traintracerelpos = undefined;
  self.traintracefails = undefined;
  self.traintracesuccesses = undefined;
}

airdrop_crushchicken(_id_6C843FC38DD679D0) {
  self endon("death");
  _id_5AABD8CBB69FE289 = gettime();

  while(gettime() - _id_5AABD8CBB69FE289 < 3000) {
    _id_6C843FC38DD679D0 dodamage(100, _id_6C843FC38DD679D0.origin, self, self, "MOD_CRUSH");
    wait 0.5;
  }
}

monitorimpactend() {
  if(!istrue(self.monitoringimpact)) {
    return;
  }
  self notify("monitorImpactEnd");
  self.monitoringimpact = undefined;
  self stoploopsound("mp_care_package_drop_lp");
  self physics_unregisterforcollisioncallback();
}

impactshoulddestroyent(entity) {
  if(!istrue(self.physicssettled)) {
    if(isDefined(entity.classname)) {
      if(entity.classname == "worldSpawn")
        return 0;
      else if(entity.classname == "script_vehicle")
        return 1;
      else if(entity.classname == "misc_turret")
        return 1;
      else if(issubstr(entity.classname, "scriptable_"))
        return 1;
      else if(entity.classname == "script_model")
        return 1;
    }
  }

  return 0;
}

monitorplayerimpact() {
  monitorplayerimpactend();
  self endon("death");
  self endon("monitorPlayerImpactEnd");
  _id_1B7AE3FFB4D76416 = self;

  if(isDefined(self.mountmantlemodel))
    _id_1B7AE3FFB4D76416 = self.mountmantlemodel;

  damageent = undefined;

  if(isDefined(self.owner))
    damageent = self.owner;

  while(isDefined(_id_1B7AE3FFB4D76416)) {
    _id_1B7AE3FFB4D76416 waittill("player_pushed", player, _id_3D8E7F86C69A149F);

    if(isDefined(player) && (isPlayer(player) || isagent(player)) && player scripts\cp_mp\utility\player_utility::_isalive()) {
      _id_C421C5C1222E83F4 = _id_3D8E7F86C69A149F[2] <= -8;
      _id_2DA284613791696F = 0;
      _id_920886B23146CDBF = undefined;

      if(player tagexists("j_mainroot")) {
        _id_920886B23146CDBF = player gettagorigin("j_mainroot");
        _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);
        midpoint = self.origin + anglestoup(self.angles) * _id_962A30A9BB8C0F09.halfheight;
        _id_2DA284613791696F = _id_920886B23146CDBF[2] <= midpoint[2];
      }

      if(_id_C421C5C1222E83F4 && _id_2DA284613791696F) {
        eattacker = damageent;

        if(!isDefined(eattacker))
          eattacker = player;
      }
    }
  }
}

monitorplayerimpactend() {
  self notify("monitorPlayerImpactEnd");
}

playimpactfx(position, normal, _id_D71630B8BAF84FA8, surfacetype) {
  if(surfacetype != "glass_pane") {
    _id_64EB7CED98F907BD = "airdrop_crate_impact_ground";

    if(surfacetype == "water") {
      _id_64EB7CED98F907BD = "airdrop_crate_impact_water";
      self playsurfacesound("mp_care_package_impact_water_body", surfacetype);
    } else if(_id_D71630B8BAF84FA8 < 175)
      self playsurfacesound("mp_care_package_low_impact", surfacetype);
    else if(_id_D71630B8BAF84FA8 < 350)
      self playsurfacesound("mp_care_package_med_impact", surfacetype);
    else
      self playsurfacesound("mp_care_package_high_impact", surfacetype);

    playFX(scripts\engine\utility::getfx(_id_64EB7CED98F907BD), position, normal);
  }

  self stoploopsound("mp_care_package_drop_lp");
}

createdangerzone() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "lpcFeatureGated") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "lpcFeatureGated")]]()) {
    return;
  }
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    return;
  }
  destroydangerzone();
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);
  dangerzoneid = undefined;

  if(isDefined(self._id_FE880EB7782C9EA0)) {
    if(isDefined(self.owner) && isDefined(self.team))
      dangerzoneid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](self._id_FE880EB7782C9EA0, _id_962A30A9BB8C0F09.dangerzoneradius, _id_962A30A9BB8C0F09.dangerzoneheight, self.team, 30.0, self.owner, 1);
    else if(isDefined(self.team))
      dangerzoneid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](self._id_FE880EB7782C9EA0, _id_962A30A9BB8C0F09.dangerzoneradius, _id_962A30A9BB8C0F09.dangerzoneheight, self.team, 30.0);
    else
      dangerzoneid = spawnuniversaldangerzone(self._id_FE880EB7782C9EA0, _id_962A30A9BB8C0F09.dangerzoneradius, _id_962A30A9BB8C0F09.dangerzoneheight, 30.0);
  }

  self.dangerzoneid = dangerzoneid;
  return dangerzoneid;
}

spawnuniversaldangerzone(position, radius, height, timeout) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    dangerzoneid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](position, radius, height, undefined, timeout, level.players[randomint(level.players.size)], 1);
    self.dangerzoneid = dangerzoneid;
    return dangerzoneid;
  }
}

destroydangerzone() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "isSpawnDangerZoneAlive") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "removeSpawnDangerZone")) {
    dangerzoneid = self.dangerzoneid;

    if(isDefined(dangerzoneid) && [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "isSpawnDangerZoneAlive")]](dangerzoneid))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "removeSpawnDangerZone")]](dangerzoneid);

    self.dangerzoneid = undefined;
  }
}

_createnavobstacle() {
  self notify("createNavObstacle");
  self endon("createNavObstacle");

  if(isDefined(self.navobstacleid))
    destroynavobstacle(self.navobstacleid);

  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);
  navobstacleid = createnavobstaclebybounds(self.origin, _id_962A30A9BB8C0F09.navobstaclebounds, self.angles);
  self.navobstacleid = navobstacleid;
  childthread _watchnavobstacle(navobstacleid, self.origin, _id_962A30A9BB8C0F09.navobstacleupdatedistsqr);
  return navobstacleid;
}

_watchnavobstacle(id, origin, _id_ECFEAF96C94ABE6E) {
  self endon("death");

  while(distancesquared(origin, self.origin) < _id_ECFEAF96C94ABE6E)
    wait 0.5;

  thread _createnavobstacle();
}

_destroynavobstacle() {
  self notify("createNavObstacle");

  if(isDefined(self.navobstacleid))
    destroynavobstacle(self.navobstacleid);

  self.navobstacleid = undefined;
}

createmountmantlemodel() {
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(isDefined(_id_962A30A9BB8C0F09.mountmantlemodel)) {
    if(isDefined(self.mountmantlemodel))
      self.mountmantlemodel delete();

    mountmantlemodel = spawn("script_model", self.origin);
    mountmantlemodel dontinterpolate();
    mountmantlemodel.angles = self.angles;
    mountmantlemodel.owner = self.owner;
    mountmantlemodel.unresolved_collision_func = ::crateunresolvedcollisioncallback;
    mountmantlemodel.killcament = self.killcament;
    mountmantlemodel.mountmantlemodel = 1;
    mountmantlemodel.unresolved_collision_notify_min = 1;
    mountmantlemodel clonebrushmodeltoscriptmodel(level.cratedata.mountmantlemodel);
    mountmantlemodel linkTo(self);
    self.mountmantlemodel = mountmantlemodel;
    mountmantlemodel.crate = self;
    return 1;
  }

  return 0;
}

destroymountmantlemodel() {
  if(isDefined(self.mountmantlemodel))
    self.mountmantlemodel delete();

  self.mountmantlemodel = undefined;
}

crateunresolvedcollisioncallback(_id_1D9FB21B4F3023F3, _id_1EE51B0A59B58D1E) {
  if(level.cratedata.unresolvedcollisiontolerancesqr > 0) {
    if(lengthsquared(_id_1EE51B0A59B58D1E) <= level.cratedata.unresolvedcollisiontolerancesqr)
      return;
  }

  objweapon = self.objweapon;

  if(isDefined(self.create))
    objweapon = self.crate.objweapon;

  _id_1D9FB21B4F3023F3 dodamage(1000, _id_1D9FB21B4F3023F3.origin, self.owner, self, "MOD_CRUSH", objweapon);
  self endon("death");
  _id_1D9FB21B4F3023F3 endon("death_or_disconnect");

  if(isPlayer(_id_1D9FB21B4F3023F3) && _id_1D9FB21B4F3023F3 scripts\cp_mp\utility\player_utility::_isalive()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "unresolvedCollisionNearestNode"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "unresolvedCollisionNearestNode")]](_id_1D9FB21B4F3023F3, undefined, self);
  }
}

_createheadicon() {
  if(istrue(self.disallowheadiconid)) {
    return;
  }
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);
  headiconid = undefined;

  if(isDefined(self.headicon)) {
    headiconoffset = _id_C857AC89588ADF6F();

    if(level.teambased && isDefined(self.team)) {
      if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
        headiconid = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.team, self.headicon, headiconoffset, 1, _id_962A30A9BB8C0F09.headicondrawrange, _id_962A30A9BB8C0F09.headiconnaturalrange, undefined, 1);

      if(isDefined(headiconid)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isMLGMatch")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isMLGMatch")]]())
            addteamtoheadiconmask(headiconid, "spectator");
        }
      }
    } else if(isDefined(self.owner)) {
      if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
        headiconid = scripts\cp_mp\entityheadicons::setheadicon_singleimage(self.owner, self.headicon, headiconoffset, 1, _id_962A30A9BB8C0F09.headicondrawrange, _id_962A30A9BB8C0F09.headiconnaturalrange, undefined, 1);

      if(isDefined(headiconid)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isMLGMatch")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isMLGMatch")]]())
            addteamtoheadiconmask(headiconid, "spectator");
        }
      }
    } else if(!scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
      headiconid = scripts\cp_mp\entityheadicons::setheadicon_singleimage(level.teamnamelist, self.headicon, headiconoffset, 1, _id_962A30A9BB8C0F09.headicondrawrange, _id_962A30A9BB8C0F09.headiconnaturalrange);
  }

  self.headiconid = headiconid;
  self.headiconactive = 1;
  return headiconid;
}

_destroyheadicon() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.headiconactive = 0;
  waitframe();
}

_id_3A065CE769B6CE3D() {
  if(isDefined(self._id_7B5E5C2BBC8F9F79)) {
    objective_delete(self._id_7B5E5C2BBC8F9F79);
    scripts\mp\objidpoolmanager::returnobjectiveid(self._id_7B5E5C2BBC8F9F79);
    self._id_7B5E5C2BBC8F9F79 = undefined;
  } else if(self isscriptable() && self getscriptablehaspart("objective")) {
    self setscriptablepartstate("objective", "inactive");
    self._id_83746F6469687186 = undefined;
  }
}

createminimapicon() {
  destroyminimapicon();
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);
  minimapid = undefined;

  if(isDefined(self.minimapicon) && !istrue(self.visibilitymanuallycontrolled)) {
    _id_68E354FCEB08D97B = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective"))
      _id_68E354FCEB08D97B = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective");

    if(isDefined(_id_68E354FCEB08D97B)) {
      if(level.teambased && isDefined(self.team))
        minimapid = self[[_id_68E354FCEB08D97B]](self.minimapicon, undefined, 1, 1);
      else if(isDefined(self.owner))
        minimapid = self[[_id_68E354FCEB08D97B]](self.minimapicon, undefined, 1, 1);
      else
        minimapid = self[[_id_68E354FCEB08D97B]](self.minimapicon, undefined, 0, 1);
    }
  }

  scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(minimapid, 24);
  self.minimapid = minimapid;
  self.minimapiconactive = 1;
  return minimapid;
}

destroyminimapicon() {
  if(isDefined(self.minimapid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
  }

  self.minimapid = undefined;
  self.minimapiconactive = 0;
}

looselinkTo(parent, offset, instancedata) {
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

addtolists() {
  level.cratedata.crates[self getentitynumber()] = self;
}

removefromlists(id) {
  if(!isDefined(level.cratedata)) {
    return;
  }
  level.cratedata.crates[id] = undefined;
}

getrandomkeyfromweightsarray(_id_8B462903A1F84F9C, _id_CD71448FD6B9EB3F) {
  if(isDefined(_id_CD71448FD6B9EB3F)) {
    if(!isarray(_id_CD71448FD6B9EB3F))
      _id_CD71448FD6B9EB3F = [_id_CD71448FD6B9EB3F];
  }

  _id_4094287FF08E6D28 = [];
  _id_6FB7DAF6138D07D0 = [];
  _id_B8A569BEF8F3AC2C = 0;

  foreach(key, weight in _id_8B462903A1F84F9C) {
    if(weight > 0) {
      isexcluded = 0;

      if(isDefined(_id_CD71448FD6B9EB3F)) {
        if(_id_CD71448FD6B9EB3F.size > 0) {
          foreach(id, _id_8DD561DA22C5839A in _id_CD71448FD6B9EB3F) {
            if(_id_8DD561DA22C5839A == key) {
              _id_CD71448FD6B9EB3F[id] = undefined;
              isexcluded = 1;
              break;
            }
          }
        } else
          _id_CD71448FD6B9EB3F = undefined;
      }

      if(!isexcluded) {
        _id_B8A569BEF8F3AC2C = _id_B8A569BEF8F3AC2C + weight;
        _id_4094287FF08E6D28[_id_4094287FF08E6D28.size] = key;
        _id_6FB7DAF6138D07D0[_id_6FB7DAF6138D07D0.size] = _id_B8A569BEF8F3AC2C;
      }
    }
  }

  _id_F4CAE9D2914CC11B = randomint(_id_B8A569BEF8F3AC2C);
  key = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_4094287FF08E6D28.size; _id_AC0E594AC96AA3A8++) {
    _id_B8A569BEF8F3AC2C = _id_6FB7DAF6138D07D0[_id_AC0E594AC96AA3A8];

    if(_id_F4CAE9D2914CC11B < _id_B8A569BEF8F3AC2C) {
      key = _id_4094287FF08E6D28[_id_AC0E594AC96AA3A8];
      break;
    }
  }

  return key;
}

getdefaultcapturevisualscallback() {
  return::defaultcapturevisualscallback;
}

getdefaultcapturevisualsdeletiondelay() {
  return getanimlength(%mp_military_carepackage_straps_falling) + 1;
}

defaultcapturevisualscallback(model) {
  if(!isDefined(self)) {
    return;
  }
  if(istrue(self.isdummyarmcrate)) {
    return;
  }
  if(!isDefined(model)) {
    return;
  }
  _id_EB5B1F36E255152D = getanimlength(%mp_military_carepackage_straps_falling);

  if(isDefined(_id_EB5B1F36E255152D))
    _id_EB5B1F36E255152D = max(0, _id_EB5B1F36E255152D);

  model.animname = "care_package";
  model scripts\common\anim::setanimtree();
  model thread scripts\common\anim::anim_single_solo(model, "care_package_capture");
  model setscriptablepartstate("capture", "start", 0);

  if(isDefined(_id_EB5B1F36E255152D))
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_EB5B1F36E255152D);

  cratetype = model.cratetype;
  _id_CD0883C0DCDD304E = "fade";

  if(istrue(self._id_51AB77B2BA57C5DD))
    _id_CD0883C0DCDD304E = "fade_water";

  model setscriptablepartstate("capture", _id_CD0883C0DCDD304E, 0);
  model setscriptablepartstate("visibility", "hide", 0);
}

getdefaultdestroyvisualsdeletiondelay() {
  return 0;
}

getdefaultdestroyvisualscallback() {
  return::defaultdestroyvisualscallback;
}

defaultdestroyvisualscallback(model) {}

getdefaultmountmantlemodel() {
  return level.cratedata.mountmantlemodel;
}

getnumdroppedcrates() {
  if(!isDefined(level.cratedata))
    return 0;

  return level.cratedata.crates.size;
}

trackcratemantlingexploit() {
  if(!isDefined(self.entmantlingendtime)) {
    if(self ismantling()) {
      entmantling = self getmovingplatformparent();

      if(isDefined(entmantling) && isDefined(entmantling.crate)) {
        self.entmantling = entmantling;
        self.entmantlingcrate = entmantling.crate;
      }

      self.entmantlingendtime = gettime() + 1000;
    }
  } else if(gettime() >= self.entmantlingendtime) {
    self.entmantling = undefined;
    self.entmantlingcrate = undefined;
    self.entmantlingendtime = undefined;
  } else {
    foreach(crate in level.cratedata.crates) {
      if(isDefined(crate) && istrue(crate.physicsactivated) && !istrue(crate.physicssettled)) {
        if(isDefined(self.entmantling)) {
          if(isDefined(crate.mountmantlemodel)) {
            if(self.entmantling != crate.mountmantlemodel) {
              if(self istouching(crate.mountmantlemodel)) {
                self.entmantling = undefined;
                self.entmantlingcrate = undefined;
                self.entmantlingendtime = undefined;

                if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "_suicide"))
                  self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "_suicide")]]();
                else
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

              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "_suicide"))
                self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "_suicide")]]();
              else
                self suicide();

              return;
            }
          }
        } else if(self istouching(crate) || isDefined(crate.mountmantlemodel) && self istouching(crate.mountmantlemodel)) {
          self.entmantling = undefined;
          self.entmantlingcrate = undefined;
          self.entmantlingendtime = undefined;

          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "_suicide"))
            self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "_suicide")]]();
          else
            self suicide();

          return;
        }
      }
    }
  }
}

overridecapturestring(_id_4C918B514697B434) {
  if(isDefined(self.capturestring) && self.capturestring == _id_4C918B514697B434) {
    return;
  }
  self.capturestring = _id_4C918B514697B434;
  _id_1F4ABB20F5347265 = [self];

  if(isDefined(self.useobject))
    _id_1F4ABB20F5347265[_id_1F4ABB20F5347265.size] = self.useobject;

  foreach(_id_EF5D5141FDB51174 in _id_1F4ABB20F5347265) {
    if(!self.supportsreroll || _id_EF5D5141FDB51174.usetype == 2)
      _id_EF5D5141FDB51174 setHintString(self.capturestring);
  }
}

overridererollstring(_id_4C918B514697B434) {
  if(isDefined(self.rerollstring) && self.rerollstring == _id_4C918B514697B434) {
    return;
  }
  self.rerollstring = _id_4C918B514697B434;
  _id_1F4ABB20F5347265 = [self];

  if(isDefined(self.useobject))
    _id_1F4ABB20F5347265[_id_1F4ABB20F5347265.size] = self.useobject;

  foreach(_id_EF5D5141FDB51174 in _id_1F4ABB20F5347265) {
    if(self.supportsreroll && _id_EF5D5141FDB51174.usetype == 1)
      _id_EF5D5141FDB51174 setHintString(self.rerollstring);
  }
}

overrideheadicon(_id_A6B4DBDD89BBBB24) {
  if(!isDefined(self.headicon) && !isDefined(_id_A6B4DBDD89BBBB24)) {
    return;
  }
  if(isDefined(self.headicon) && isDefined(_id_A6B4DBDD89BBBB24) && self.headicon == _id_A6B4DBDD89BBBB24) {
    return;
  }
  if(!isDefined(_id_A6B4DBDD89BBBB24)) {
    self.headicon = undefined;
    _destroyheadicon();
  } else {
    self.headicon = _id_A6B4DBDD89BBBB24;

    if(self.headiconactive) {
      if(isDefined(self.headiconid))
        setheadiconimage(self.headiconid, _id_A6B4DBDD89BBBB24);
      else
        _createheadicon();
    }
  }
}

overrideminimapicon(_id_A6B4DBDD89BBBB24) {
  if(!isDefined(self.minimapicon) && !isDefined(_id_A6B4DBDD89BBBB24)) {
    return;
  }
  if(isDefined(self.minimapicon) && isDefined(_id_A6B4DBDD89BBBB24) && self.minimapicon == _id_A6B4DBDD89BBBB24) {
    return;
  }
  if(!isDefined(_id_A6B4DBDD89BBBB24)) {
    self.minimapicon = undefined;
    destroyminimapicon();
  } else {
    self.minimapicon = _id_A6B4DBDD89BBBB24;

    if(self.minimapiconactive) {
      if(isDefined(self.minimapid))
        scripts\mp\objidpoolmanager::update_objective_icon(self.minimapid, _id_A6B4DBDD89BBBB24);
      else
        createminimapicon();
    }
  }
}

overridesupportsreroll(_id_916435788623AC01) {
  if(self.supportsreroll == _id_916435788623AC01) {
    return;
  }
  self.supportsreroll = _id_916435788623AC01;

  if(self.supportsreroll) {
    _id_1F4ABB20F5347265 = [self];

    if(isDefined(self.useobject))
      _id_1F4ABB20F5347265[_id_1F4ABB20F5347265.size] = self.useobject;

    foreach(_id_EF5D5141FDB51174 in _id_1F4ABB20F5347265) {
      if(_id_EF5D5141FDB51174.usetype == 1)
        _id_EF5D5141FDB51174 setHintString(self.rerollstring);
    }
  }
}

initkillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  activatecallback = ::killstreakcrateactivatecallback;
  capturecallback = ::killstreakcratecapturecallback;
  _id_962A30A9BB8C0F09 = getleveldata("killstreak");
  _id_962A30A9BB8C0F09.activatecallback = activatecallback;
  _id_962A30A9BB8C0F09.capturecallback = capturecallback;

  if(scripts\cp_mp\utility\game_utility::_id_2D79A7A3B91C4C3E())
    _id_962A30A9BB8C0F09.capturestring = &"MP/BR_CRATE_LOADOUT";

  _id_962A30A9BB8C0F09 = getleveldata("killstreak_no_owner");
  _id_962A30A9BB8C0F09.activatecallback = activatecallback;
  _id_962A30A9BB8C0F09.capturecallback = capturecallback;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  addkillstreakcratedata("assault_drone", undefined, undefined, 300);
  addkillstreakcratedata("uav", undefined, undefined, 300);
  addkillstreakcratedata("cluster_spike", undefined, undefined, 300);
  addkillstreakcratedata("scrambler_drone_guard", undefined, undefined, 300);
  addkillstreakcratedata("cruise_predator", undefined, undefined, 150);
  addkillstreakcratedata("toma_strike", undefined, undefined, 150);
  addkillstreakcratedata("precision_airstrike", undefined, undefined, 150);
  addkillstreakcratedata("sentry_gun", undefined, undefined, 150);
  addkillstreakcratedata("fuel_airstrike", undefined, undefined, 100);
  addkillstreakcratedata("hover_jet", undefined, undefined, 100);
  addkillstreakcratedata("airdrop_escort", undefined, undefined, 100);
  addkillstreakcratedata("pac_sentry", undefined, undefined, 100);
  addkillstreakcratedata("auto_drone", undefined, undefined, 50);
  addkillstreakcratedata("chopper_gunner", undefined, undefined, 50);
  addkillstreakcratedata("directional_uav", undefined, undefined, 25);
  addkillstreakcratedata("gunship", undefined, undefined, 25);
  addkillstreakcratedata("juggernaut", undefined, undefined, 10);
}

initdropzonekillstreakcratedata() {
  level.cratedata.ksweights = [];
  level.cratedata.kscapturestrings = [];
  level.cratedata.ksrerollstrings = [];
  activatecallback = ::killstreakcrateactivatecallback;
  capturecallback = ::killstreakcratecapturecallback;
  _id_962A30A9BB8C0F09 = getleveldata("killstreak");
  _id_962A30A9BB8C0F09.activatecallback = activatecallback;
  _id_962A30A9BB8C0F09.capturecallback = capturecallback;
  _id_962A30A9BB8C0F09 = getleveldata("killstreak_no_owner");
  _id_962A30A9BB8C0F09.activatecallback = activatecallback;
  _id_962A30A9BB8C0F09.capturecallback = capturecallback;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  addkillstreakcratedata("assault_drone", undefined, undefined, 300);
  addkillstreakcratedata("uav", undefined, undefined, 300);
  addkillstreakcratedata("cluster_spike", undefined, undefined, 300);
  addkillstreakcratedata("cruise_predator", undefined, undefined, 150);
  addkillstreakcratedata("toma_strike", undefined, undefined, 150);
  addkillstreakcratedata("precision_airstrike", undefined, undefined, 150);
  addkillstreakcratedata("sentry_gun", undefined, undefined, 150);
  addkillstreakcratedata("fuel_airstrike", undefined, undefined, 100);
  addkillstreakcratedata("hover_jet", undefined, undefined, 100);
  addkillstreakcratedata("pac_sentry", undefined, undefined, 100);
  addkillstreakcratedata("auto_drone", undefined, undefined, 50);
  addkillstreakcratedata("chopper_gunner", undefined, undefined, 50);
  addkillstreakcratedata("directional_uav", undefined, undefined, 25);
  addkillstreakcratedata("gunship", undefined, undefined, 25);
  addkillstreakcratedata("juggernaut", undefined, undefined, 10);

  if(level.gametype == "infect")
    _id_962A30A9BB8C0F09.isteamonlycrate = 1;
  else
    addkillstreakcratedata("scrambler_drone_guard", undefined, undefined, 300);
}

addkillstreakcratedata(streakname, capturestring, rerollstring, weight) {
  level.cratedata.kscapturestrings[streakname] = capturestring;
  level.cratedata.ksrerollstrings[streakname] = rerollstring;
  level.cratedata.ksweights[streakname] = weight;
}

getkillstreakcratedatabystreakname(streakname, supportsreroll) {
  data = spawnStruct();
  data.streakname = streakname;
  data.supportsreroll = supportsreroll;
  return data;
}

overridekillstreakcrateweight(streakname, _id_3F9B0BA92698A35D) {
  level.cratedata.ksweights[streakname] = _id_3F9B0BA92698A35D;
}

killstreakcrateactivatecallback(isfirstactivation) {
  data = self.data;
  capturestring = level.cratedata.kscapturestrings[data.streakname];

  if(isDefined(capturestring))
    overridecapturestring(capturestring);

  rerollstring = level.cratedata.ksrerollstrings[data.streakname];

  if(isDefined(rerollstring))
    overridererollstring(rerollstring);

  supportsreroll = data.supportsreroll;

  if(isDefined(supportsreroll))
    overridesupportsreroll(supportsreroll);
}

killstreakcratecapturecallback(player) {
  streakname = self.data.streakname;
  _id_44632FF01DF0AADD = 0;

  switch (streakname) {
    case "juggernaut":
      if(!istrue(player.isjuggernaut)) {
        _id_44632FF01DF0AADD = 1;

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "applyImmediateJuggernaut"))
          player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "applyImmediateJuggernaut")]](_id_44632FF01DF0AADD);
        else
          player scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut(_id_44632FF01DF0AADD);
      }

      break;
  }

  if(!istrue(_id_44632FF01DF0AADD)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "awardKillstreak"))
      player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "awardKillstreak")]](streakname, self.owner, self);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "showKillstreakSplash"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "showKillstreakSplash")]](streakname, undefined, 1);
  }

  if(isDefined(self.owner) && player == self.owner) {} else if(isDefined(self.team)) {
    if(player.team != self.team) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("hijacker");

      if(isDefined(self.owner)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showSplash"))
          self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showSplash")]]("hijacked_airdrop", undefined, player);
      }
    } else {}
  }

  if(isDefined(level._id_571986D5B745A9D7))
    [[level._id_571986D5B745A9D7]](player);
}

getrandomkillstreak(_id_52A8C1BDDBF44D11) {
  streakname = getrandomkeyfromweightsarray(level.cratedata.ksweights, _id_52A8C1BDDBF44D11);
  return streakname;
}

placekillstreakcrate(owner, team, streakname, position, angles) {
  if(!isDefined(streakname) || streakname == "random")
    streakname = getrandomkillstreak();

  cratetype = scripts\engine\utility::ter_op(isDefined(owner), "killstreak", "killstreak_no_owner");
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  crate = placecrate(owner, team, cratetype, position, angles, cratedropdata);

  if(!isDefined(crate))
    return undefined;

  if(isDefined(owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", owner);
  }

  return crate;
}

dropkillstreakcrate(owner, team, streakname, position, angles, destination) {
  if(!isDefined(streakname) || streakname == "random")
    streakname = getrandomkillstreak();

  cratetype = scripts\engine\utility::ter_op(isDefined(owner), "killstreak", "killstreak_no_owner");
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  crate = dropcrate(owner, team, cratetype, position, angles, destination, cratedropdata);

  if(!isDefined(crate))
    return undefined;

  if(isDefined(owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", owner);
  }

  return crate;
}

dropkillstreakcratefromscriptedheli(owner, team, streakname, position, angles, destination, vehicleisreserved, streakinfo) {
  if(!isDefined(streakname) || streakname == "random")
    streakname = getrandomkillstreak();

  cratetype = scripts\engine\utility::ter_op(isDefined(owner), "killstreak", "killstreak_no_owner");
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  cratedropdata.vehicleisreserved = vehicleisreserved;
  scenenode = dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, cratedropdata, streakinfo);

  if(!isDefined(scenenode))
    return undefined;
  else if(!isDefined(scenenode.crates) || !isDefined(scripts\engine\utility::array_get_first_item(scenenode.crates)))
    return undefined;

  if(isDefined(owner)) {
    owner thread airdrop_playdeploydialog(streakinfo);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", owner);
  }

  return scenenode;
}

airdrop_playdeploydialog(streakinfo) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(level.gametype == "grnd" || level.gametype == "infect") {
    return;
  }
  _id_52A5BE2E2F91D710 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, streakinfo.streakname);
    _id_52A5BE2E2F91D710 = 2.3;
  }

  _id_3707AC9BA459FB6D = streakinfo.streakname + "_use";
  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(streakinfo.streakname, _id_3707AC9BA459FB6D, 1, _id_52A5BE2E2F91D710);
}

dropkillstreakcratefrommanualheli(owner, team, streakname, position, angles, destination, vehicleisreserved) {
  if(!isDefined(streakname) || streakname == "random")
    streakname = getrandomkillstreak();

  cratetype = scripts\engine\utility::ter_op(isDefined(owner), "killstreak", "killstreak_no_owner");
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  cratedropdata.vehicleisreserved = vehicleisreserved;
  dropstruct = dropcratefrommanualheli(owner, team, cratetype, position, angles, 30000, 30000, destination, cratedropdata);

  if(!isDefined(dropstruct))
    return undefined;
  else if(!isDefined(dropstruct.crate))
    return undefined;

  if(isDefined(owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
      level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop", owner);
  }

  return dropstruct.crate;
}

tryairdroptriggered(streakinfo) {
  streakname = streakinfo.streakname;
  droptype = streakname;
  result = undefined;

  if(!isDefined(droptype))
    droptype = "airdrop";

  _id_F7D941FB76FD8044 = level.littlebirds.size;
  maxvehiclecount = 4;

  if(scripts\cp_mp\utility\game_utility::islargemap())
    maxvehiclecount = 10;

  if(streakname == "airdrop_escort") {
    _id_F7D941FB76FD8044 = level.cratedropdata._id_04950BB412D4E1D5.size;
    maxvehiclecount = 1;
  }

  _id_4440147083ABAF0A = 1;

  if((_id_F7D941FB76FD8044 >= maxvehiclecount || level.fauxvehiclecount >= maxvehiclecount) && droptype != "airdrop_mega") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_AIRDROPS");

    return 0;
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + _id_4440147083ABAF0A >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");

      return 0;
    }
  }

  return 1;
}

airdropmarkerswitchended(streakinfo, _id_41BF9BF4918115AC) {
  if(istrue(_id_41BF9BF4918115AC))
    thread airdrop_watchplayerweapon(streakinfo);
}

airdrop_watchplayerweapon(streakinfo) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  result = scripts\engine\utility::waittill_any_return_2("cancel_deploy", "weapon_switch_started");

  if(!isDefined(result)) {
    return;
  }
  streakinfo notify("killstreak_finished_with_deploy_weapon");
}

airdropvisualmarkerfired(streakinfo) {
  streakinfo.airdroptype = streakinfo.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();

  marker = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "getTargetMarker"))
    marker = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "getTargetMarker")]](streakinfo);

  if(!isDefined(marker.location)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.airdroptype, self.origin);

  airdropvisualmarkeractivate(marker, streakinfo.airdroptype, streakinfo);
  return 1;
}

airdropvisualmarkeractivate(marker, droptype, streakinfo) {
  _id_F0F1E7230EDECB24 = scripts\engine\utility::drop_to_ground(marker.location, 50, -200, (0, 0, 1));
  _id_F0F1E7230EDECB24 = _id_F0F1E7230EDECB24 + (0, 0, 1);
  _id_4E0D9C78FA04CDD4 = spawn("script_model", _id_F0F1E7230EDECB24);
  _id_4E0D9C78FA04CDD4 setModel("offhand_wm_grenade_smoke");
  _id_4E0D9C78FA04CDD4.angles = (0, 90, 90);
  fxent = spawn("script_model", _id_F0F1E7230EDECB24);
  fxent setModel("ks_crate_marker_mp");
  fxent setscriptablepartstate("smoke", "on", 0);

  if(isDefined(marker.visual))
    marker.visual delete();
}

tryuseairdropmarker() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("airdrop", self);
  return tryuseairdropmarkerfromstruct(streakinfo);
}

tryuseairdropmarkerfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  streakinfo.deployweaponobj = makeweapon("deploy_airdrop_mp");
  _id_B340C162CE19AD5E = getdvarint("dvar_B2E9BF0017CEEEAE", 0);

  if(_id_B340C162CE19AD5E)
    streakinfo.deployweaponobj = makeweapon("deploy_airdrop_sticky_mp");

  _id_2472CBE64ADE0C46 = undefined;

  switch (streakinfo.streakname) {
    case "airdrop_multiple":
    case "airdrop":
    case "airdrop_escort":
      _id_2472CBE64ADE0C46 = 1;
      break;
    default:
      _id_2472CBE64ADE0C46 = 0;
  }

  if(_id_2472CBE64ADE0C46) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

      return 0;
    }
  }

  if(!tryairdroptriggered(streakinfo)) {
    if(_id_2472CBE64ADE0C46)
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

    return 0;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      if(_id_2472CBE64ADE0C46)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

      return 0;
    }
  }

  if(isDefined(level._id_27F78817B59DFE32))
    streakinfo._id_FB58A31C756DB4CC = level._id_27F78817B59DFE32;

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, streakinfo.deployweaponobj, "grenade_fire", undefined, ::airdropmarkerswitchended, ::airdropmarkerfired, undefined, ::airdropmarkertaken);

  if(!istrue(_id_9B1DEB5E9D32BBE3)) {
    if(_id_2472CBE64ADE0C46)
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  return 1;
}

_id_F66B707D0894B6DE(streakinfo) {
  self endon("death_or_disconnect");
  self endon("giveAndFireOffhandReliableFailed");
  level endon("game_ended");
  deployweaponobj = streakinfo.deployweaponobj;

  for(;;) {
    self waittill("grenade_thrown", grenade);

    if(isDefined(deployweaponobj.basename) && isDefined(grenade.weapon_name) && deployweaponobj.basename == grenade.weapon_name) {
      airdropmarkerfired(streakinfo, deployweaponobj, grenade, 1);
      break;
    } else
      break;
  }
}

airdropmarkerfired(streakinfo, weaponobj, projectile, _id_4B0C1A8C50D15340) {
  streakinfo.airdroptype = streakinfo.streakname;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "incrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "incrementFauxVehicleCount")]]();

  projectile.owner = self;
  projectile thread airdropmarkeractivate(streakinfo.airdroptype, undefined, streakinfo, _id_4B0C1A8C50D15340);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.airdroptype, self.origin);

  streakinfo.airdropmarkerfired = 1;

  if(!istrue(_id_4B0C1A8C50D15340))
    streakinfo notify("killstreak_finished_with_deploy_weapon");

  return "success";
}

airdropmarkeractivate(droptype, lifeid, streakinfo, _id_4B0C1A8C50D15340) {
  level endon("game_ended");
  _id_811F337EFD111E98 = self.owner.angles;
  self waittill("explode", position);

  if(istrue(_id_4B0C1A8C50D15340)) {
    if(isDefined(level.killstreakfinishusefunc))
      level thread[[level.killstreakfinishusefunc]](streakinfo);
  }

  owner = self.owner;

  if(!isDefined(owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }

  waitframe();
  _id_FDA870B32AB92C1F = _id_811F337EFD111E98 + (0, 180, 0);
  targetpos = position;
  _id_359711DD322783EC = getscriptedhelidropheight(droptype);
  _id_558047C7AC5A2D65 = anglesToForward(owner.angles);
  _id_3C5A1B26C6973C2A = anglestoright(owner.angles);
  contents = scripts\engine\trace::create_default_contents(1);
  _id_F74F18C717B149E2 = [targetpos - _id_558047C7AC5A2D65 * 100, targetpos + _id_558047C7AC5A2D65 * 100, targetpos + _id_3C5A1B26C6973C2A * 100, targetpos - _id_3C5A1B26C6973C2A * 100, targetpos + (_id_558047C7AC5A2D65 + _id_3C5A1B26C6973C2A) * 100, targetpos + (_id_558047C7AC5A2D65 - _id_3C5A1B26C6973C2A) * 100, targetpos + (_id_3C5A1B26C6973C2A - _id_558047C7AC5A2D65) * 100, targetpos + (-1 * _id_558047C7AC5A2D65 - _id_3C5A1B26C6973C2A) * 100];

  foreach(_id_F9567F37DB523F7A in _id_F74F18C717B149E2) {
    _id_7A7426E42E674E40 = vectorNormalize(_id_F9567F37DB523F7A - targetpos);
    _id_C45BBEB56DF09B5D = targetpos * (1, 1, 0) + (0, 0, _id_359711DD322783EC);
    _id_32A961DAC02545B0 = _id_C45BBEB56DF09B5D - _id_7A7426E42E674E40 * 25000;
    _id_19189FD85D8A2C19 = _id_C45BBEB56DF09B5D + _id_7A7426E42E674E40 * 25000;
    _id_1F0571D36D0DF95B = scripts\engine\trace::ray_trace_passed(_id_32A961DAC02545B0, _id_19189FD85D8A2C19, undefined, contents);

    if(!istrue(_id_1F0571D36D0DF95B)) {
      continue;
    }
    _id_FDA870B32AB92C1F = vectortoangles(_id_7A7426E42E674E40);
    break;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

  _id_806F4F8C9ECEF0A1 = undefined;

  if(droptype == "airdrop")
    _id_806F4F8C9ECEF0A1 = dropkillstreakcratefromscriptedheli(owner, owner.team, undefined, position, _id_FDA870B32AB92C1F, position, 1, streakinfo);
  else if(droptype == "airdrop_multiple") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "airdropMultipleDropCrates"))
      _id_806F4F8C9ECEF0A1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "airdropMultipleDropCrates")]](owner, owner.team, position, _id_FDA870B32AB92C1F, position, 1, streakinfo);
  } else if(droptype == "airdrop_escort") {} else if(droptype == "loadout_drop")
    _id_806F4F8C9ECEF0A1 = _id_63E71231FBC15AA9(owner, owner.team, droptype, position, _id_FDA870B32AB92C1F, position, 1, streakinfo);

  if(isDefined(owner)) {
    if(!isDefined(_id_806F4F8C9ECEF0A1)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");

      if(isDefined(streakinfo) && isDefined(streakinfo.mpstreaksysteminfo)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct"))
          owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](streakinfo.mpstreaksysteminfo, "other");
      }

      return;
    }

    owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
  }
}

airdropmarkertaken(streakinfo) {
  if(istrue(streakinfo.airdropmarkerfired)) {
    if(isDefined(level.killstreakfinishusefunc))
      level thread[[level.killstreakfinishusefunc]](streakinfo);
  }

  if(isDefined(streakinfo.airdroptype) && !istrue(streakinfo.airdropmarkerfired)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }
}

initbattleroyalecratedata() {
  _id_962A30A9BB8C0F09 = getleveldata("battle_royale");
  _id_962A30A9BB8C0F09.capturestring = &"MP/BR_CRATE";
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 180;
  _id_962A30A9BB8C0F09.timeout = undefined;
  _id_962A30A9BB8C0F09.activatecallback = ::brcrateactivatecallback;
  _id_962A30A9BB8C0F09.capturecallback = ::brcratecapturecallback;
}

getbrcratedatabytype(type) {
  data = spawnStruct();
  data.type = type;
  return data;
}

brcrateactivatecallback(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
  }
}

brcratecapturecallback(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "makeItemsFromCrate"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "makeItemsFromCrate")]](player);
}

dropbrcratefromscriptedheli(position) {
  type = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", "attachment");
  scenenode = dropcratefromscriptedheli(undefined, undefined, "battle_royale", position, (0, randomfloat(360), 0), position, getbrcratedatabytype(type));

  if(!isDefined(scenenode))
    return undefined;
  else if(!isDefined(scenenode.crates) || !isDefined(scripts\engine\utility::array_get_first_item(scenenode.crates)))
    return undefined;

  return scenenode.crate;
}

dropbrcratefrommanualheli(position) {
  type = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", "attachment");
  dropstruct = dropcratefrommanualheli(undefined, undefined, "battle_royale", position, (0, randomfloat(360), 0), 30000, 30000, position, getbrcratedatabytype(type));

  if(!isDefined(dropstruct))
    return undefined;
  else if(!isDefined(dropstruct.crate))
    return undefined;

  return dropstruct.crate;
}

initbattleroyaleloadoutcratedata() {
  _id_962A30A9BB8C0F09 = getleveldata("battle_royale_loadout");
  _id_962A30A9BB8C0F09.capturestring = &"MP/BR_CRATE_LOADOUT";
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_01_loadout_br";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 180;
  _id_962A30A9BB8C0F09.timeout = undefined;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09.ownerusetime = 0.5;
  _id_962A30A9BB8C0F09.otherusetime = 0.5;
  _id_962A30A9BB8C0F09.activatecallback = ::brloadoutcrateactivatecallback;
  _id_962A30A9BB8C0F09.capturecallback = ::brloadoutcratecapturecallback;
  _id_962A30A9BB8C0F09.destroycallback = ::brloadoutcratedestroycallback;
  _id_962A30A9BB8C0F09.destroyoncapture = 0;
  _id_962A30A9BB8C0F09.onecaptureperplayer = 1;
  _id_962A30A9BB8C0F09._id_28EB33FFD1AA3E63 = 1;
  _id_962A30A9BB8C0F09._id_C23CA3472233553D = 1;
}

brloadoutcrateactivatecallback(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "brLoadoutCrateFirstActivation"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "brLoadoutCrateFirstActivation")]](self);
  }
}

brloadoutcratecapturecallback(player) {
  giveweaponsfromdropbag(player);
  self notify("brLoadoutCapture", player);
}

brloadoutcratepostcapture(player) {
  if(!isDefined(self.numuses))
    self.numuses = 0;

  if(!isDefined(self.playersused))
    self.playersused = [];

  if(!isDefined(self.playerscaptured))
    self.playerscaptured = [];

  self.playerscaptured[player getentitynumber()] = player;
  self.playersused[self.playersused.size] = player;
  self.numuses++;

  if(isDefined(self.playeroutlines)) {
    foreach(outlineid in self.playeroutlines) {
      if(isDefined(self.outlines) && isDefined(self.outlines[outlineid]) && isDefined(self.outlines[outlineid].playersvisibleto)) {
        if(self.outlines[outlineid].playersvisibleto.size == 1 && self.outlines[outlineid].playersvisibleto[0] == player) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable"))
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](outlineid, self);

          self.playeroutlines = scripts\engine\utility::array_remove(self.playeroutlines, outlineid);
          break;
        }
      }
    }
  }

  self notify("brLoadoutPostCapture", player);

  if(istrue(self._id_93A4478D44F7941E) || istrue(self._id_4CD5B8F62D173211)) {
    return;
  }
  if(self.numuses >= level.teamdata[player.team]["teamCount"]) {
    if(isDefined(self.playeroutlines)) {
      foreach(outline in self.playeroutlines) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "outlineDisable"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "outlineDisable")]](outline, self);
      }
    }

    if(isDefined(self.choosenlocation) && isDefined(self.choosenlocation.inuse))
      self.choosenlocation.inuse = 0;

    thread destroycrate();
  }
}

brloadoutcratedestroycallback(immediate) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "brOnLoadoutCrateDestroyed"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "brOnLoadoutCrateDestroyed")]](immediate);
}

giveweaponsfromdropbag(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "br_giveDropBagLoadout"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "br_giveDropBagLoadout")]](player);
}

dropbrloadoutcrate(team, position, destination) {
  return dropcrate(undefined, team, "battle_royale_loadout", position, (0, randomfloat(360), 0), destination);
}

_id_C5C61B985836F974() {
  _id_962A30A9BB8C0F09 = getleveldata("loadout_drop");
  _id_962A30A9BB8C0F09.capturestring = &"MP/BR_CRATE_LOADOUT";
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_01_loadout_mp";
  _id_962A30A9BB8C0F09.supportsownercapture = 1;
  _id_962A30A9BB8C0F09.headicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
  _id_962A30A9BB8C0F09.minimapicon = "hud_icon_minimap_fieldupgrade_loadout_drop";
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 360;
  _id_962A30A9BB8C0F09.timeout = 60;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09._id_C75F6DFE8DF28B58 = 5;
  _id_962A30A9BB8C0F09.ownerusetime = 0.5;
  _id_962A30A9BB8C0F09.otherusetime = 0.5;
  _id_962A30A9BB8C0F09.activatecallback = ::_id_22501284AC235158;
  _id_962A30A9BB8C0F09.capturecallback = ::_id_A5D8804D96FE6A17;
  _id_962A30A9BB8C0F09.destroyoncapture = 0;
  _id_962A30A9BB8C0F09.onecaptureperplayer = 1;
  _id_962A30A9BB8C0F09.isteamonlycrate = 1;
}

_id_22501284AC235158(isfirstactivation) {
  if(istrue(isfirstactivation)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "registerCrateForCleanup"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "registerCrateForCleanup")]](self);
  }
}

_id_A5D8804D96FE6A17(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "airdropSelectLoadout"))
    player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "airdropSelectLoadout")]](self);
}

_id_D854BF5A8CD7DAF2(player) {
  if(!isDefined(self.numuses))
    self.numuses = 0;

  self.numuses++;
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);

  if(self.numuses >= _id_962A30A9BB8C0F09._id_C75F6DFE8DF28B58)
    thread destroycrate();
}

_id_63E71231FBC15AA9(owner, team, streakname, position, angles, destination, vehicleisreserved, streakinfo) {
  cratetype = streakname;
  cratedropdata = getkillstreakcratedatabystreakname(streakname, 0);
  cratedropdata.vehicleisreserved = vehicleisreserved;
  scenenode = dropcratefromscriptedheli(owner, team, cratetype, position, angles, destination, cratedropdata, streakinfo);

  if(!isDefined(scenenode))
    return undefined;
  else if(!isDefined(scenenode.crates) || !isDefined(scripts\engine\utility::array_get_first_item(scenenode.crates)))
    return undefined;

  if(isDefined(owner))
    owner thread airdrop_playdeploydialog(streakinfo);

  return scenenode;
}

initbattleroyalec130airdropcratedata() {
  _id_962A30A9BB8C0F09 = getleveldata("battle_royale_c130_loot");

  if(getDvar("dvar_7611A2790A0BF7FE", "") == "plunder")
    _id_962A30A9BB8C0F09.capturestring = &"MP/DMZ_LOOT_CRATE_CAPTURE";
  else
    _id_962A30A9BB8C0F09.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";

  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_03_br";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 180;
  _id_962A30A9BB8C0F09.timeout = 600;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09.ownerusetime = 0.5;
  _id_962A30A9BB8C0F09.otherusetime = 0.5;
  _id_962A30A9BB8C0F09.activatecallback = ::brc130airdropcrateactivatecallback;
  _id_962A30A9BB8C0F09.capturecallback = ::brc130airdropcratecapturecallback;
  _id_962A30A9BB8C0F09.destroycallback = ::brc130airdropcratedestroycallback;
  _id_962A30A9BB8C0F09.cratephysicsoncallback = ::brc130airdropcratephysicsoncallback;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09._id_28EB33FFD1AA3E63 = 1;
  _id_962A30A9BB8C0F09._id_C23CA3472233553D = 1;
}

brc130airdropcrateactivatecallback(isfirstactivation) {}

brc130airdropcratecapturecallback(player) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_c130Airdrop", "c130Airdrop_onCrateUse"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_c130Airdrop", "c130Airdrop_onCrateUse")]](player);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_c130Airdrop", "dmzTut_crateUsed"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_c130Airdrop", "dmzTut_crateUsed")]](player);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }

  if(isDefined(level.c130successfulairdrops))
    level.c130successfulairdrops = scripts\engine\utility::array_remove(level.c130successfulairdrops, self);
}

brc130airdropcratedestroycallback(immediate) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }

  if(isDefined(level.c130successfulairdrops))
    level.c130successfulairdrops = scripts\engine\utility::array_remove(level.c130successfulairdrops, self);
}

brc130airdropcratephysicsoncallback() {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

dropbrc130airdropcrate(dropposition, _id_7AFB56851B06F678, dropangles, _id_958BBDFED6F2E9EF, _id_FE41BE11A71DC1B4, nodropanim, team, _id_CF11CD8C8B813FAF) {
  _id_DD3F2E9EC30744D5 = 250;
  _id_C8EC5569BE94E5C8 = level.c130airdrop_heightoverride;
  _id_EDF964E253D1F375 = 1000;
  _id_55917B74A3B88B89 = 10500;
  _id_843CCD48992E3408 = 7500;
  _id_E0570C6B08E54443 = 3000;
  _id_195F5093227FE5B6 = _id_7AFB56851B06F678 + (0, 0, _id_EDF964E253D1F375);
  _id_16068A91A735DB9F = "battle_royale_c130_loot";

  if(isDefined(_id_958BBDFED6F2E9EF))
    _id_16068A91A735DB9F = _id_958BBDFED6F2E9EF;

  if(!isDefined(nodropanim))
    nodropanim = 0;

  crate = createcrate(undefined, team, _id_16068A91A735DB9F, dropposition, (0, 0, 0), _id_7AFB56851B06F678, undefined, 0);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;

    if(!nodropanim && _id_195F5093227FE5B6[2] < dropposition[2]) {
      _id_2C8936D08F85C5C1 = undefined;
      _id_FF42E8BA492B161A = distance(dropposition, _id_195F5093227FE5B6);

      if(_id_FF42E8BA492B161A >= _id_55917B74A3B88B89)
        _id_2C8936D08F85C5C1 = "brc130_drop_high";
      else if(_id_FF42E8BA492B161A >= _id_843CCD48992E3408)
        _id_2C8936D08F85C5C1 = "brc130_drop_med";
      else if(_id_FF42E8BA492B161A >= _id_E0570C6B08E54443)
        _id_2C8936D08F85C5C1 = "brc130_drop_low";

      if(isDefined(_id_2C8936D08F85C5C1)) {
        _id_7AC104D5971B61A5 = 1000;
        scenenode = spawn("script_model", _id_195F5093227FE5B6 + (0, 0, _id_7AC104D5971B61A5));
        scenenode.angles = dropangles;
        scenenode setModel("tag_origin");
        crate.animname = "care_package";
        crate.dropanim = level.scr_anim[crate.animname][_id_2C8936D08F85C5C1];
        crate.animlength = getanimlength(crate.dropanim);
        crate scripts\common\anim::setanimtree();
        chute = spawn("script_model", crate.origin);
        chute.angles = crate.angles;
        chute.animname = "care_package_chute";
        chute.dropanim = level.scr_anim[chute.animname][_id_2C8936D08F85C5C1];
        chute.animlength = getanimlength(chute.dropanim);
        chute setModel("veh9_mil_lnd_parachute_carepackage_br");
        chute scripts\common\anim::setanimtree();
        scenenode thread scripts\common\anim::anim_single_solo(crate, _id_2C8936D08F85C5C1);
        scenenode thread scripts\common\anim::anim_single_solo(chute, _id_2C8936D08F85C5C1);
        crate thread watchbrc130aidropcrateanimend();
        chute thread watchbrc130airdropchuteanimend(scenenode);
      } else
        crate cratephysicson();
    } else
      crate cratephysicson();

    _id_40920B1903F4682A = "cashdrop_common";
    _id_C16DC9D131BD10BA = getdvarint("dvar_FF7BB52F31B387E1", 1);

    if(_id_C16DC9D131BD10BA)
      _id_40920B1903F4682A = "cashdrop_common_world";

    if(isDefined(_id_FE41BE11A71DC1B4))
      _id_40920B1903F4682A = _id_FE41BE11A71DC1B4;

    crate setscriptablepartstate("objective_map", _id_40920B1903F4682A, 0);

    if(!nodropanim)
      crate setscriptablepartstate("crate_audio", "parachuting", 0);

    _id_946146964FC4025F = "ks_airdrop_crate_br";

    if(isDefined(_id_CF11CD8C8B813FAF))
      _id_946146964FC4025F = _id_CF11CD8C8B813FAF;

    crate.smokesignal = spawn("script_model", _id_7AFB56851B06F678);
    crate.smokesignal setModel(_id_946146964FC4025F);
    crate.smokesignal setscriptablepartstate("smoke_signal", "on", 0);
  }

  return crate;
}

watchbrc130aidropcrateanimend() {
  self endon("death");
  wait(self.animlength);

  if(isDefined(self)) {
    level notify(self.cratetype + "drop_anim_completed");
    self stopanimScripted();
    cratephysicson();
  }
}

watchbrc130airdropchuteanimend(scenenode) {
  self endon("death");
  wait(self.animlength);

  if(isDefined(self))
    self delete();

  if(isDefined(scenenode))
    scenenode delete();
}

initbattleroyalelootchoppercratedata() {
  _id_962A30A9BB8C0F09 = getleveldata("battle_royale_chopper_loot");

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    _id_962A30A9BB8C0F09.capturestring = &"MP/BR_CRATE_LOADOUT";
  else
    _id_962A30A9BB8C0F09.capturestring = &"MP/DMZ_PLUNDER_CRATE_CAPTURE";

  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_03_br";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 180;
  _id_962A30A9BB8C0F09.timeout = 600;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09.ownerusetime = 0.5;
  _id_962A30A9BB8C0F09.otherusetime = 0.5;
  _id_962A30A9BB8C0F09._id_C23CA3472233553D = 1;
  _id_962A30A9BB8C0F09.activatecallback = ::brlootchoppercrateactivatecallback;
  _id_962A30A9BB8C0F09.capturecallback = ::brlootchoppercratecapturecallback;
  _id_962A30A9BB8C0F09.destroycallback = ::brlootchoppercratedestroycallback;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09._id_28EB33FFD1AA3E63 = 1;
}

brlootchoppercrateactivatecallback(isfirstactivation) {}

brlootchoppercratecapturecallback(player) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_lootchopper", "lootChopper_onCrateUse"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_lootchopper", "lootChopper_onCrateUse")]](player);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_lootchopper", "championChopper_onCrateUse"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_lootchopper", "championChopper_onCrateUse")]](player);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }
}

brlootchoppercratedestroycallback(immediate) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }
}

dropbrlootchoppercrate(position, destination) {
  crate = dropcrate(undefined, undefined, "battle_royale_chopper_loot", position, (0, randomfloat(360), 0), destination);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;
    _id_40920B1903F4682A = "cashdrop_common";
    _id_C16DC9D131BD10BA = getdvarint("dvar_FF7BB52F31B387E1", 1);

    if(_id_C16DC9D131BD10BA)
      _id_40920B1903F4682A = "cashdrop_common_world";

    crate setscriptablepartstate("objective_map", _id_40920B1903F4682A, 0);
    crate.smokesignal = spawn("script_model", destination);
    crate.smokesignal setModel("ks_airdrop_crate_br");
    crate.smokesignal setscriptablepartstate("smoke_signal", "on", 0);
  }

  return crate;
}

dropbrlootchoppercrateforpublicevent(position, destination) {
  crate = dropcrate(undefined, undefined, "battle_royale_chopper_loot", position, (0, randomfloat(360), 0), destination);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;
    crate setscriptablepartstate("objective_map", "pe_chopper_crate", 0);
    crate.smokesignal = spawn("script_model", destination);
    crate.smokesignal setModel("ks_airdrop_crate_br");
    crate.smokesignal setscriptablepartstate("smoke_signal", "pe_chopper_on", 0);
  }

  return crate;
}

_id_53A94FEE5954AF57() {
  _id_962A30A9BB8C0F09 = getleveldata("battle_royale_cash_crate");
  _id_962A30A9BB8C0F09.capturestring = &"MP/DMZ_PLUNDER_CRATE_CAPTURE";
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_03_br";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 180;
  _id_962A30A9BB8C0F09.timeout = 600;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09.ownerusetime = 0.5;
  _id_962A30A9BB8C0F09.otherusetime = 0.5;
  _id_962A30A9BB8C0F09._id_9EA9E33FA2A90171 = 1;
  _id_962A30A9BB8C0F09._id_C23CA3472233553D = 1;
  _id_962A30A9BB8C0F09.activatecallback = ::_id_BF892D4093C5F9D3;
  _id_962A30A9BB8C0F09.capturecallback = ::_id_93BBDFABA40C778A;
  _id_962A30A9BB8C0F09.destroycallback = ::_id_66EE09B2E374FB6E;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09._id_28EB33FFD1AA3E63 = 1;
}

_id_BF892D4093C5F9D3(isfirstactivation) {}

_id_93BBDFABA40C778A(player) {
  self setscriptablepartstate("objective_map", "inactive", 0);
  self setscriptablepartstate("objective", "inactive", 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_cashcrate", "cashCrate_onCrateUse"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_cashcrate", "cashCrate_onCrateUse")]](player);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }
}

_id_66EE09B2E374FB6E(immediate) {
  self setscriptablepartstate("objective_map", "inactive", 0);
  self setscriptablepartstate("objective", "inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }
}

_id_9FEB10C0096CC4D6(position, destination) {
  crate = dropcrate(undefined, undefined, "battle_royale_cash_crate", position, (0, randomfloat(360), 0), destination);

  if(isDefined(crate)) {
    crate.skipminimapicon = 1;
    _id_40920B1903F4682A = "cashdrop_common";
    _id_C16DC9D131BD10BA = getdvarint("dvar_FF7BB52F31B387E1", 1);

    if(_id_C16DC9D131BD10BA)
      _id_40920B1903F4682A = "cashdrop_common_world";

    crate setscriptablepartstate("objective_map", _id_40920B1903F4682A, 0);
    crate.smokesignal = spawn("script_model", destination);
    crate.smokesignal setModel("ks_airdrop_crate_br");
    crate.smokesignal setscriptablepartstate("smoke_signal", "on", 0);
  }

  return crate;
}

initplundercratedata() {
  _id_962A30A9BB8C0F09 = getleveldata("esc_cache");
  _id_962A30A9BB8C0F09.capturestring = &"MP/ESC_CACHE_USE_HINT";
  _id_962A30A9BB8C0F09.usetag = "tag_origin";
  _id_962A30A9BB8C0F09.userange = 200;
  _id_962A30A9BB8C0F09.usefov = 160;
  _id_962A30A9BB8C0F09.usepriority = 0;
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_crate_large_stackable_01";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -10000;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.minimapicon = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "captureLootCacheCallback"))
    _id_962A30A9BB8C0F09.capturecallback = [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "captureLootCacheCallback")]]();

  _id_962A30A9BB8C0F09.destroyoncapture = 0;
  _id_962A30A9BB8C0F09.onecaptureperplayer = 1;
  _id_962A30A9BB8C0F09.capturevisualscallback = undefined;
  _id_962A30A9BB8C0F09.destroyvisualscallback = undefined;
  _id_962A30A9BB8C0F09.timeout = undefined;
}

getplcratedata(contents) {
  data = spawnStruct();
  data.contents = contents;
  return data;
}

placeplcrate(contents, position, angles) {
  crate = placecrate(undefined, undefined, "esc_cache", position, angles, getplcratedata(contents));
  return crate;
}

initarmcratedata() {
  level.cratedata.armweights = [];
  level.cratedata.armcapturestrings = [];
  _id_962A30A9BB8C0F09 = getleveldata("arm_no_owner");
  _id_962A30A9BB8C0F09.activatecallback = ::armcrateactivatecallback;
  _id_962A30A9BB8C0F09.capturecallback = ::armcratecapturecallback;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicondrawrange = 5000;
  _id_962A30A9BB8C0F09.timeout = 180;
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

addarmcratedata(streakname, capturestring, defconlevel, weight) {
  level.cratedata.armdefconlevels[streakname] = defconlevel;
  level.cratedata.armweights[streakname] = weight;
  level.cratedata.armcapturestrings[streakname] = capturestring;
}

getarmcratedatabystreakname(streakname) {
  data = spawnStruct();
  data.streakname = streakname;
  return data;
}

armcrateactivatecallback(isfirstactivation) {
  data = self.data;
  capturestring = level.cratedata.armcapturestrings[data.streakname];

  if(isDefined(capturestring))
    overridecapturestring(capturestring);
}

armcratecapturecallback(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreak"))
    player thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreak")]](self.data.streakname, "airdrop", undefined, undefined, self.owner);
}

getrandomarmkillstreak(team) {
  _id_52A8C1BDDBF44D11 = getarmkillsteakstoexcludebyteamdefconlevel(team);
  streakname = getrandomkeyfromweightsarray(level.cratedata.armweights, _id_52A8C1BDDBF44D11);
  return streakname;
}

getarmkillsteakstoexcludebyteamdefconlevel(team) {
  defconlevel = level.defconlevel;
  _id_59F9B4EC41BAB131 = undefined;

  if(defconlevel > 1) {
    _id_59F9B4EC41BAB131 = [];

    foreach(streakname, _id_FCE39DABBBB5C9E0 in level.cratedata.armdefconlevels) {
      if(defconlevel > _id_FCE39DABBBB5C9E0)
        _id_59F9B4EC41BAB131[_id_59F9B4EC41BAB131.size] = streakname;
    }
  }

  return _id_59F9B4EC41BAB131;
}

droparmcratefromscriptedheli(team, streakname, position, angles, destination) {
  if(!isDefined(streakname) || streakname == "random")
    streakname = getrandomarmkillstreak(team);

  cratedropdata = getarmcratedatabystreakname(streakname);
  scenenode = dropcratefromscriptedheli(undefined, team, "arm_no_owner", position, angles, destination, cratedropdata);

  if(!isDefined(scenenode))
    return undefined;
  else if(!isDefined(scenenode.crates) || !isDefined(scripts\engine\utility::array_get_first_item(scenenode.crates)))
    return undefined;

  foreach(crate in scenenode.crates)
  return crate;
}

_id_A3299432DDB721E3() {
  level.cratedata._id_0332809ACEA23B57 = [];
  level.cratedata._id_7480157ED64DEDA2 = [];
  _id_962A30A9BB8C0F09 = getleveldata("gwtdm_no_owner");
  _id_962A30A9BB8C0F09.activatecallback = ::_id_D8A8E185CFA2DE1B;
  _id_962A30A9BB8C0F09.capturecallback = ::armcratecapturecallback;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.enemymodel = undefined;
  _id_962A30A9BB8C0F09.headicondrawrange = 5000;
  _id_962A30A9BB8C0F09.timeout = 180;
  _id_C035E11237E84114("cruise_predator", 40);
  _id_C035E11237E84114("precision_airstrike", 40);
  _id_C035E11237E84114("toma_strike", 40);
  _id_C035E11237E84114("fuel_airstrike", 40);
  _id_C035E11237E84114("sentry_gun", 40);
  _id_C035E11237E84114("pac_sentry", 30);
  _id_C035E11237E84114("auto_drone", 20);
  _id_C035E11237E84114("hover_jet", 20);
  _id_C035E11237E84114("chopper_gunner", 20);
  _id_C035E11237E84114("gunship", 10);
  _id_C035E11237E84114("juggernaut", 10);
}

_id_C035E11237E84114(streakname, weight) {
  level.cratedata._id_0332809ACEA23B57[streakname] = weight;
}

_id_D8A8E185CFA2DE1B(isfirstactivation) {
  data = self.data;
  capturestring = level.cratedata._id_7480157ED64DEDA2[data.streakname];

  if(isDefined(capturestring))
    overridecapturestring(capturestring);
}

_id_5D1369BFC4EFD8B7(team) {
  streakname = getrandomkeyfromweightsarray(level.cratedata._id_0332809ACEA23B57);
  return streakname;
}

_id_506B410CE5A55CB3(streakname) {
  data = spawnStruct();
  data.streakname = streakname;
  return data;
}

_id_99CC30EA8BE5B2A6(team, streakname, position, angles, destination) {
  if(!isDefined(streakname) || streakname == "random")
    streakname = _id_5D1369BFC4EFD8B7(team);

  cratedropdata = _id_506B410CE5A55CB3(streakname);
  scenenode = dropcratefromscriptedheli(undefined, team, "gwtdm_no_owner", position, angles, destination, cratedropdata);

  if(!isDefined(scenenode))
    return undefined;
  else if(!isDefined(scenenode.crates) || !isDefined(scripts\engine\utility::array_get_first_item(scenenode.crates)))
    return undefined;

  foreach(crate in scenenode.crates)
  return crate;
}

initbattleroyalejuggernautcratedata() {
  _id_962A30A9BB8C0F09 = getleveldata("battle_royale_juggernaut");

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
    _id_962A30A9BB8C0F09.capturestring = &"MP/BR_CRATE_LOADOUT";
  else
    _id_962A30A9BB8C0F09.capturestring = &"KILLSTREAKS_HINTS/JUGG_CRATE_PICKUP";

  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_03_jugg_br";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.usefov = 180;
  _id_962A30A9BB8C0F09.timeout = undefined;
  _id_962A30A9BB8C0F09.friendlyuseonly = 1;
  _id_962A30A9BB8C0F09.ownerusetime = 0.5;
  _id_962A30A9BB8C0F09.otherusetime = 0.5;
  _id_962A30A9BB8C0F09.capturecallback = ::brjuggernautcratecapturecallback;
  _id_962A30A9BB8C0F09.destroycallback = ::brjuggernautcratedestroycallback;
  _id_962A30A9BB8C0F09.activatecallback = ::brjuggernautcrateactivatecallback;
  _id_962A30A9BB8C0F09.cratephysicsoncallback = ::brjuggernautcratephysicsoncallback;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
  _id_962A30A9BB8C0F09._id_28EB33FFD1AA3E63 = 1;
  _id_962A30A9BB8C0F09._id_C23CA3472233553D = 1;
}

brjuggernautcrateactivatecallback(isfirstactivation) {
  scripts\cp_mp\killstreaks\juggernaut::oncrateactivated(isfirstactivation);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_juggernaut", "onCrateActivate"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_juggernaut", "onCrateActivate")]](isfirstactivation);
}

brjuggernautcratecapturecallback(player) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_juggernaut", "onCrateUse"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_juggernaut", "onCrateUse")]](player);

  scripts\cp_mp\killstreaks\juggernaut::oncratecaptured(player);
}

brjuggernautcratedestroycallback(immediate) {
  self setscriptablepartstate("objective_map", "inactive", 0);

  if(isDefined(self.smokesignal)) {
    self.smokesignal setscriptablepartstate("smoke_signal", "off", 0);
    self.smokesignal delete();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_juggernaut", "onCrateDestroy"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_juggernaut", "onCrateDestroy")]](immediate);
}

brjuggernautcratephysicsoncallback(position, destination) {
  self setscriptablepartstate("crate_audio", "detach", 0);
}

dropjuggernautcrate(team, position, destination) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", self);
  return dropcrate(undefined, team, "battle_royale_juggernaut", position, (0, randomfloat(360), 0), destination, streakinfo, 1);
}

spawnjuggernautcrateatposition(pos, _id_E648E96614161011) {
  crate = dropjuggernautcrate(self.team, pos + (0, 0, 4096), pos + (0, 0, 512));
  crate endon("death");
  enablejuggernautcrateobjective(crate);
  choosejuggernautcratemodel(crate);
  _id_3BE0D54D30A3593C = [];

  foreach(_id_F0EA4030349A33D5 in level.teamdata[self.team]["alivePlayers"]) {}
}

enablejuggernautcrateobjective(crate) {
  crate setotherent(self);
  crate setscriptablepartstate("objective_map", "jugg_world");
}

choosejuggernautcratemodel(crate) {
  crate setotherent(self);
  crate setscriptablepartstate("model", "choose");
}

juggcanusecrate(cratetype) {
  _id_4418A5E6F9D1E943 = 1;

  switch (cratetype) {
    case "battle_royale_juggernaut":
    case "loadout_drop":
      _id_4418A5E6F9D1E943 = 0;
      break;
    case "battle_royale_loadout":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        _id_32593FDCD227DBD9 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(!istrue(_id_32593FDCD227DBD9))
          _id_4418A5E6F9D1E943 = 0;
      }

      break;
  }

  return _id_4418A5E6F9D1E943;
}

_id_3C4492046080FAA9() {
  return scripts\engine\utility::ter_op(istrue(self._id_51AB77B2BA57C5DD), 50.0, 5.0);
}

_id_F7E3F128296AC3B6() {
  return scripts\engine\utility::ter_op(istrue(self._id_51AB77B2BA57C5DD), 5.0, 1.0);
}

_id_D4833B6C916DB9C6() {
  return scripts\engine\utility::ter_op(istrue(self._id_51AB77B2BA57C5DD), 3, 6);
}

_id_C857AC89588ADF6F() {
  _id_962A30A9BB8C0F09 = getleveldata(self.cratetype);
  return scripts\engine\utility::ter_op(istrue(self._id_51AB77B2BA57C5DD), 5, _id_962A30A9BB8C0F09.headiconoffset);
}

_id_19DC247EAAF9DA8F() {
  _id_962A30A9BB8C0F09 = getleveldata("elite_arrow_bombsite");
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_01_cq";
  _id_962A30A9BB8C0F09._id_9AE260C6BFB4C98D = 1;
  _id_962A30A9BB8C0F09.minimapicon = undefined;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.hasnointeraction = 1;
  _id_962A30A9BB8C0F09.timeout = 0.1;
}

_id_56E93FD2282A71CE() {
  _id_962A30A9BB8C0F09 = getleveldata("legendary_supply_drop");
  _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_03_br";
  _id_962A30A9BB8C0F09.mountmantlemodel = undefined;
  _id_962A30A9BB8C0F09.usepriority = -1;
  _id_962A30A9BB8C0F09.minimapicon = undefined;
  _id_962A30A9BB8C0F09.headicon = undefined;
  _id_962A30A9BB8C0F09.supportsownercapture = 0;
  _id_962A30A9BB8C0F09.timeout = 180;
  _id_962A30A9BB8C0F09.ownerusetime = 0.5;
  _id_962A30A9BB8C0F09.otherusetime = 0.5;
  _id_962A30A9BB8C0F09.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
  _id_962A30A9BB8C0F09.capturecallback = ::_id_0E7051A617B94015;
  _id_962A30A9BB8C0F09.destroyoncapture = 1;
}

_id_0E7051A617B94015(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("br_legendary_supply_drop", "legendary_supply_onCrateUse"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("br_legendary_supply_drop", "legendary_supply_onCrateUse")]](player);
}