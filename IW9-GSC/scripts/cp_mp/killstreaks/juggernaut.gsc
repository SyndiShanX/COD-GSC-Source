/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\juggernaut.gsc
****************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "init"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "init")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "registerActionSet"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "registerActionSet")]]();

  level.juggksglobals = spawnStruct();
  initconfig();
  initmarker();
  init_jugg_vo();
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_on", 1);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_damage_low", 2);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_damage_med", 3);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_damage_high", 4);
  scripts\cp_mp\utility\killstreak_utility::registervisibilityomnvarforkillstreak("juggernaut", "mask_damage_critical", 5);
}

initconfig() {
  _id_584994FAB4A8712B = level.juggksglobals;
  config = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "initConfig"))
    config = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "initConfig")]]();

  _id_584994FAB4A8712B.config = config;
  config.infiniteammo = 1;
  config.infiniteammoupdaterate = 4.0;

  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73()) {
    config.maxhealth = getdvarint("dvar_95386E0FEDD3F69A", 2000);
    config.startinghealth = config.maxhealth;
  } else {
    config.maxhealth = 3000;
    config.startinghealth = 3000;
  }

  config.suit = "iw9_ks_juggernaut_mp";
  config.clothtype = "vestheavy";
  config._id_400EF51562606E7A = "milhvygr";
  config.execution = "execution_mp_juggernaut_01";
  config._id_CCEF760095A8D026 = config.maxhealth * 0.9;
  config._id_033A458EBB314026 = config.maxhealth * 0.5;
  config._id_6517BCADB9E33B21 = config.maxhealth * 0.5;
  config._id_98C8EB9D039DFAA2 = config.maxhealth * 0.1;
  config._id_6493D470BCAF2469 = config.maxhealth * 0.1;
  config._id_FE7B1A75B71D65B5 = config.maxhealth * 0.1;
  config._id_CCDC04703862490A = config.maxhealth * 0.1;
  config._id_196A36E4DE8891F5 = config.maxhealth * 0.1;
  config._id_B74A139EF1F10A8A = config.maxhealth * 0.1;

  if(scripts\common\utility::iscp()) {
    config.classstruct.loadoutprimary = "iw9_lm_dblmg2_cp";
    config.classstruct.loadoutsecondary = "none";
  } else {
    config.classstruct.loadoutprimary = "iw9_minigunksjugg_mp";
    config.classstruct.loadoutsecondary = "iw9_pi_golf18_mp";
  }

  if(isDefined(level.addjuggsettings))
    config[[level.addjuggsettings]]();
}

initmarker() {
  _id_962A30A9BB8C0F09 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "levelData"))
    _id_962A30A9BB8C0F09 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "levelData")]]("juggernaut");

  _id_962A30A9BB8C0F09.capturecallback = ::oncratecaptured;
  _id_962A30A9BB8C0F09.destroycallback = ::oncratedestroyed;
  _id_962A30A9BB8C0F09.activatecallback = ::oncrateactivated;
  _id_962A30A9BB8C0F09.minimapicon = "ui_map_icon_jugg_drop";
  _id_962A30A9BB8C0F09.headicon = "ui_map_icon_jugg_drop";

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    _id_962A30A9BB8C0F09.capturestring = &"MP/BR_CRATE_LOADOUT";
  else
    _id_962A30A9BB8C0F09.capturestring = &"KILLSTREAKS_HINTS/JUGG_CRATE_PICKUP";

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_962A30A9BB8C0F09._id_229AB5AFB5B2CF09 = "military_carepackage_03_jugg_mp";
}

init_jugg_vo() {
  game["dialog"]["juggernaut_use"] = "killstreak_remote_operator_request_response";
}

tryusejuggernaut(_id_76553DC7AAAD2909, _id_CA56839B2E00EDCE) {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", self);
  streakinfo._id_CA56839B2E00EDCE = _id_CA56839B2E00EDCE;
  tryusejuggernautfromstruct(streakinfo, _id_76553DC7AAAD2909);
}

tryusejuggernautfromstruct(streakinfo, _id_76553DC7AAAD2909) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canTriggerJuggernaut")) {
    if(!self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canTriggerJuggernaut")]](streakinfo))
      return 0;
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_97E8248DA4371635 = getdvarint("dvar_3F1BD355BF340ABB");

  if(_id_97E8248DA4371635 || istrue(_id_76553DC7AAAD2909))
    thread activatejugg(streakinfo);
  else {
    scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
    deployweaponobj = makeweapon("deploy_juggernaut_mp");

    if(isDefined(level._id_27F78817B59DFE32))
      streakinfo._id_FB58A31C756DB4CC = level._id_27F78817B59DFE32;

    _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, deployweaponobj, "grenade_fire", undefined, undefined, ::markerthrown);

    if(!istrue(_id_9B1DEB5E9D32BBE3)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  return 1;
}

markerthrown(streakinfo, weaponobj, projectile) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "incrementFauxVehicleCount"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();

  projectile.owner = self;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, self.origin);

  projectile thread watchmarkeractivate(streakinfo);
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  return "success";
}

watchmarkeractivate(streakinfo) {
  level endon("game_ended");
  _id_811F337EFD111E98 = self.owner.angles;
  owner = self.owner;
  streakinfo.airdroptype = streakinfo.streakname;
  self waittill("explode", position);

  if(!isDefined(owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();

    owner thread scripts\cp_mp\killstreaks\airdrop::airdrop_playdeploydialog(streakinfo);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "dropCrateFromScriptedHeli") && !scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      streakinfo.vehicleisreserved = 1;
      data = streakinfo;
      scenenode = [[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "dropCrateFromScriptedHeli")]](owner, owner.team, "juggernaut", position, _id_811F337EFD111E98, position, data, streakinfo);

      if(!isDefined(scenenode)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
          owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
          owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](streakinfo.mpstreaksysteminfo, "other");
          return;
        }

        return;
      }

      return;
    }

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
      _id_E648E96614161011 = 1;
      owner thread scripts\cp_mp\killstreaks\airdrop::spawnjuggernautcrateatposition(position, _id_E648E96614161011);
    }
  }
}

oncrateactivated(_id_510B9BDE18D66CDD) {
  if(istrue(_id_510B9BDE18D66CDD))
    self setscriptablepartstate("smoke_cover", "active", 0);
}

oncratecaptured(player) {
  if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73() && !isDefined(self.data))
    self.data = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("juggernaut", player);

  streakinfo = self.data;

  if(istrue(player.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "awardKillstreak")) {
      self.streakinfo = streakinfo;
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "awardKillstreak")]](streakinfo.streakname, player, self);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop", "showKillstreakSplash"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "showKillstreakSplash")]](streakinfo.streakname, undefined, 1);
  } else
    player activatejugg(streakinfo);
}

oncratedestroyed(immediate) {
  streakinfo = self.data;

  if(isDefined(level.killstreakfinishusefunc))
    level[[level.killstreakfinishusefunc]](streakinfo);
}

activatejugg(streakinfo) {
  _id_584994FAB4A8712B = level.juggksglobals;
  result = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "makeJuggernaut"))
    result = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "makeJuggernaut")]](_id_584994FAB4A8712B.config, streakinfo);

  if(!result)
    return 0;

  _id_0CBB0697DE4C5728::_id_606FA08E3AAC10D9();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "playOperatorUseLine"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "playOperatorUseLine")]](self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_juggernaut", self);

  createjuggobjective();

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
    self _meth_555E2D32E2756625("gasmask_female");
  else
    self _meth_555E2D32E2756625("gasmask_male");

  if(!istrue(streakinfo._id_CA56839B2E00EDCE)) {
    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      self setsoundsubmix("mp_juggernaut", 0.5, 0.3);
    else
      self setsoundsubmix("mp_juggernaut", 0.5);
  }

  thread watchforjuggernautgameend(streakinfo);
  thread watchforjuggernautend(streakinfo);
  thread watchforjuggernautdisconnect(streakinfo);

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !scripts\common\utility::iscp())
    thread dropminigunondeath();
}

dropminigunondeath() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("death");
  _id_1EF2006E3F6F0F89 = "iw9_lm_dblmg_mp";

  if(scripts\common\utility::iscp())
    _id_1EF2006E3F6F0F89 = "iw9_lm_dblmg2_cp";

  minigunweapon = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845(_id_1EF2006E3F6F0F89);
  self giveweapon(minigunweapon);
  _id_65B055C9A44990A9 = self dropitem(minigunweapon);

  if(!isDefined(_id_65B055C9A44990A9)) {
    self takeallweapons();
    return;
  }

  _id_65B055C9A44990A9.objweapon = minigunweapon;
  _id_65B055C9A44990A9.targetname = "dropped_weapon";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "watchPickup"))
    _id_65B055C9A44990A9 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "watchPickup")]](self);

  waitframe();
  self takeallweapons();
}

watchforjuggernautgameend(streakinfo) {
  self endon("disconnect");
  self endon("juggernaut_end");
  level waittill("game_ended");

  if(isDefined(self) && isDefined(streakinfo))
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
}

watchforjuggernautend(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  juggcontext = self.juggcontext;
  self waittill("juggernaut_end");

  if(isDefined(self.operatorcustomization)) {
    if(isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "355")
      self _meth_555E2D32E2756625("gasmask_female");
    else if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female")
      self _meth_555E2D32E2756625("female");
    else if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref) && self.operatorcustomization.skinref + "" == "319")
      self setentitysoundcontext("gender", "bongmask_male");
    else
      self _meth_555E2D32E2756625("");
  }

  self clearsoundsubmix("mp_juggernaut", 0.5);
  onjuggernautend(streakinfo, juggcontext);
}

onjuggernautend(streakinfo, juggcontext) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(isDefined(level.killstreakfinishusefunc))
      level[[level.killstreakfinishusefunc]](streakinfo);

    streakinfo.expiredbydeath = 1;
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
  }

  _id_0CBB0697DE4C5728::_id_CB5051BFAB85D56A();
  cleanupjuggobjective(juggcontext);
}

watchforjuggernautdisconnect(streakinfo) {
  self endon("juggernaut_end");
  level endon("game_ended");
  juggcontext = self.juggcontext;
  self waittill("disconnect");
  cleanupjuggobjective(juggcontext);
}

createjuggobjective(_id_CBCC20CC563590C7) {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(!isDefined(_id_CBCC20CC563590C7))
      _id_CBCC20CC563590C7 = "playerObjective";

    if(scripts\cp_mp\utility\game_utility::_id_FA7BFCC1D68B7B73())
      self setscriptablepartstate(_id_CBCC20CC563590C7, "juggernaut_mgl", 0);
    else
      self setscriptablepartstate(_id_CBCC20CC563590C7, "juggernaut", 0);
  } else {
    _id_477F81D188723410 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID"))
      _id_477F81D188723410 = scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID");

    if(isDefined(_id_477F81D188723410)) {
      objid = [[_id_477F81D188723410]](99);
      self.juggcontext.juggobjid = objid;
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "active", self.origin, "hud_icon_minimap_killstreak_juggernaut");
      scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(objid, 0);

      foreach(player in level.players) {
        if(!isDefined(player) || isbot(player) || player == self) {
          continue;
        }
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(objid, player);
      }

      scripts\mp\objidpoolmanager::update_objective_onentity(objid, self);
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);

      if(level.teambased)
        scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, self.team);
      else
        scripts\mp\objidpoolmanager::update_objective_ownerclient(objid, self);
    }
  }
}

cleanupjuggobjective(juggcontext, _id_CBCC20CC563590C7) {
  if(isDefined(self) && scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(!isDefined(_id_CBCC20CC563590C7))
      _id_CBCC20CC563590C7 = "playerObjective";

    self setscriptablepartstate(_id_CBCC20CC563590C7, "off", 0);
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](juggcontext.juggobjid);
}

watchjuggernautweaponenduse(_id_A2D4837D22E88282, _id_6E8ABB5CB9BFD417) {
  thread removejuggernautweapononaction("switched_from_minigun", _id_6E8ABB5CB9BFD417);
  thread removejuggernautweapononaction("minigun_ammo_depleted", _id_6E8ABB5CB9BFD417);
  thread removejuggernautweapononaction("death");
  thread removejuggernautweapononaction("scr_change_swim_state");
  thread watchjuggernautweaponswitch(_id_A2D4837D22E88282);
  thread _id_DE04C507F957B420(_id_A2D4837D22E88282);
  thread watchjuggernautweaponammo(_id_A2D4837D22E88282);
}

watchjuggernautweaponswitch(_id_A2D4837D22E88282) {
  self endon("death");
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");
  self notifyonplayercommand("manual_switch_from_minigun", "+weapnext");
  self notifyonplayercommand("manual_switch_from_minigun", "+weapprev");

  for(;;) {
    self waittill("manual_switch_from_minigun");

    if(self getcurrentweapon() != _id_A2D4837D22E88282) {
      continue;
    }
    _id_545CF9FDBAE045A5 = _id_2669878CF5A1B6BC::getgrenadeinpullback();

    if(_id_545CF9FDBAE045A5.basename != "none") {
      continue;
    }
    self notify("switched_from_minigun");
    break;
  }
}

_id_DE04C507F957B420(_id_A2D4837D22E88282) {
  self endon("death");
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");

  for(;;) {
    self waittill("weapon_pickup", _id_66B3DB972AC1531E, _id_88B2F9E2206AE20A);

    if(self getcurrentweapon() != _id_A2D4837D22E88282) {
      continue;
    }
    if(!isDefined(_id_88B2F9E2206AE20A)) {
      continue;
    }
    self notify("switched_from_minigun");
    break;
  }
}

watchjuggernautweaponammo(_id_A2D4837D22E88282) {
  self endon("death");
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");

  for(;;) {
    _id_7E7C62618A84B0C6 = self getweaponammoclip(_id_A2D4837D22E88282);

    if(_id_7E7C62618A84B0C6 <= 0) {
      self notify("minigun_ammo_depleted");
      break;
    }

    waitframe();
  }
}

removejuggernautweapononaction(action, _id_6E8ABB5CB9BFD417) {
  self endon("disconnect");
  self endon("juggernaut_start");
  self endon("dropped_minigun");
  level endon("game_ended");
  self waittill(action);
  dropjuggernautweapon(action, _id_6E8ABB5CB9BFD417);
}

dropjuggernautweapon(action, _id_6E8ABB5CB9BFD417) {
  self.pickedupcoreminigun = undefined;
  self.minigunprevweaponobject = undefined;
  self.playerstreakspeedscale = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "updateMoveSpeedScale"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "updateMoveSpeedScale")]]();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "allowActionSet"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "allowActionSet")]]("fakeJugg", 1);

  if(!istrue(level.disablemount)) {
    _id_3B64EB40368C1450::set("fakeJugg", "mount_top", 1);
    _id_3B64EB40368C1450::set("fakeJugg", "mount_side", 1);
  }

  _id_1EF2006E3F6F0F89 = "iw9_lm_dblmg_mp";

  if(scripts\common\utility::iscp())
    _id_1EF2006E3F6F0F89 = "iw9_lm_dblmg2_cp";

  minigunweapon = scripts\cp_mp\utility\weapon_utility::_id_EEAA22F0CD1FF845(_id_1EF2006E3F6F0F89);

  if(action == "switched_from_minigun" || action == "used_ammo_box" || action == "death") {
    if(self hasweapon(minigunweapon)) {
      _id_65B055C9A44990A9 = self dropitem(minigunweapon);
      _id_65B055C9A44990A9.objweapon = minigunweapon;
      _id_65B055C9A44990A9.targetname = "dropped_weapon";

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "watchPickup"))
        _id_65B055C9A44990A9 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "watchPickup")]](self);
    }
  } else if(action == "minigun_ammo_depleted") {
    if(self hasweapon(minigunweapon))
      thread delaytakeminigun(0.5, minigunweapon);
  } else if(action == "scr_change_swim_state") {
    if(self hasweapon(minigunweapon)) {
      _id_7474313B0EF773B4 = self getweaponammoclip(minigunweapon);
      self takeweapon(minigunweapon);
      thread _id_B63097FD668A69E1(action, minigunweapon, _id_7474313B0EF773B4);
    }
  }

  if(isDefined(_id_6E8ABB5CB9BFD417)) {
    self.lastdroppableweaponobj = _id_6E8ABB5CB9BFD417;
    self switchtoweapon(_id_6E8ABB5CB9BFD417);
  }

  self notify("dropped_minigun");
}

delaytakeminigun(_id_74B5B12BB6514385, minigunweapon) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_74B5B12BB6514385);
  self takeweapon(minigunweapon);
}

_id_B63097FD668A69E1(action, minigunweapon, _id_7474313B0EF773B4) {
  self endon("death_or_disconnect");
  self waittill(action);

  for(;;) {
    _id_545CF9FDBAE045A5 = _id_2669878CF5A1B6BC::getgrenadeinpullback();

    if(!self _meth_E40102956C887F7C() && !(isDefined(self.carryobject) && isDefined(self.carryobject.carryobjectasset) && self.carryobject.carryobjectasset == "hostage_rescue")) {
      self giveweapon(minigunweapon);
      self switchtoweaponimmediate(minigunweapon);
      self setweaponammoclip(minigunweapon, _id_7474313B0EF773B4);
      _id_17372FFC28DC7D78 = self.lastdroppableweaponobj;

      if(!isDefined(_id_17372FFC28DC7D78)) {
        _id_9111B9A018285894 = scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();
        _id_17372FFC28DC7D78 = _id_9111B9A018285894[0];
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "juggernautWeaponPickedUp"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "juggernautWeaponPickedUp")]](minigunweapon, _id_17372FFC28DC7D78);

      break;
    }

    waitframe();
  }
}