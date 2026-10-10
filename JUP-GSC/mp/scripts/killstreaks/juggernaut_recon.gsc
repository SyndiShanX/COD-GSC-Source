/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\killstreaks\juggernaut_recon.gsc
*******************************************************/

#using script_13865ca76df87ea;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace juggernaut_recon;

function autoexec main() {
  function_df7ab5b0f898e8bc(function_1823ff50bb28148d("juggernaut_recon"), &init);
}

function init() {
  if(issharedfuncdefined("killstreak", "registerKillstreak")) {
    [[getsharedfunc("killstreak", "registerKillstreak")]]("juggernaut_recon", &function_2e34ff8caa82d72d);
  }

  if(issharedfuncdefined("juggernaut_recon", "init")) {
    [[getsharedfunc("juggernaut_recon", "init")]]();
  }

  if(issharedfuncdefined("juggernaut_recon", "registerActionSet")) {
    [[getsharedfunc("juggernaut_recon", "registerActionSet")]]();
  }

  level.var_e084c71df9ac20f1 = spawnStruct();
  thread function_f49ef51573779a58();
}

function function_f49ef51573779a58() {
  wait 0.1;
  function_8b0517e29ba99749();
  function_11f8f0876fc973de();
}

function function_8b0517e29ba99749() {
  globals = level.var_e084c71df9ac20f1;
  bundle = level.streakglobals.streakbundles["juggernaut_recon"];
  config = scripts\cp_mp\killstreaks\juggernaut::function_23f0145756ed19cb(bundle);

  if(isDefined(config)) {
    if(isDefined(level.var_3bdb45e93efd90b7)) {
      config[[level.var_3bdb45e93efd90b7]]();
    }

    globals.config = config;
  }
}

function function_9611765a6973a30a(dvar, config, isprimary) {
  overridestring = getDvar(dvar, "<dev string:x1c>");

  if(overridestring.size == 0) {
    return;
  }

  substrings = strtok(overridestring, "<dev string:x20>");
  weaponname = substrings[0];

  if(isprimary) {
    config.classstruct.loadoutprimary = weaponname;
  } else {
    config.classstruct.loadoutsecondary = weaponname;
  }

  weaponblueprint = undefined;

  if(substrings.size > 1) {
    weaponblueprint = substrings[1];
  }

  function_51b8a3cf6102ba3(weaponname, weaponblueprint, config, isprimary);
}

function function_138468dd32aae3fe() {
  leveldata = undefined;

  if(issharedfuncdefined("juggernaut_recon", "levelData")) {
    leveldata = [[getsharedfunc("juggernaut_recon", "levelData")]]("juggernaut_recon");
  }

  if(isDefined(leveldata)) {
    leveldata.capturecallback = &function_c13dca1515447b28;
    leveldata.destroycallback = &function_bbd5edacfcb74661;
    leveldata.activatecallback = &function_546bfb8d4d00c31;
    leveldata.minimapicon = "jup_ui_map_icon_jugg_recon_drop";
    leveldata.headicon = "jup_ui_map_icon_jugg_recon_drop";

    if(scripts\cp_mp\utility\game_utility::function_2d79a7a3b91c4c3e()) {
      leveldata.capturestring = &"MP/BR_CRATE_LOADOUT";
    } else {
      leveldata.capturestring = &"KILLSTREAKS_HINTS/JUGG_RECON_CRATE_PICKUP";
    }

    if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      leveldata.basemodel = self.var_3c9615208f1c09b8.cratemodel;
    }
  }
}

function function_11f8f0876fc973de() {
  game["dialog"]["juggernaut_recon" + "_use"] = "killstreak_remote_operator" + "_request_response";
}

function function_b960491329678b4(activateimmediate, var_ca56839b2e00edce) {
  streakinfo = createstreakinfo("juggernaut_recon", self);
  streakinfo.var_ca56839b2e00edce = var_ca56839b2e00edce;
  function_2e34ff8caa82d72d(streakinfo, activateimmediate);
}

function function_2e34ff8caa82d72d(streakinfo, activateimmediate) {
  if(scripts\engine\utility::issharedfuncdefined("juggernaut_recon", "canTriggerJuggernaut")) {
    if(!self[[scripts\engine\utility::getsharedfunc("juggernaut_recon", "canTriggerJuggernaut")]](streakinfo)) {
      return false;
    }
  }

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  bundle = level.streakglobals.streakbundles["juggernaut_recon"];
  self.var_3c9615208f1c09b8 = function_d5974b5f58f14716(bundle, level.var_e084c71df9ac20f1.config, streakinfo.mpstreaksysteminfo.blueprintindex);
  function_138468dd32aae3fe();
  instantdeploy = 0;

  instantdeploy = getdvarint(@ "hash_8324943f346018cf", 0);

  if(instantdeploy || istrue(activateimmediate)) {
    thread function_8bac95417054dcbf(streakinfo);
  } else {
    scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle();
    deployweaponobj = self.var_3c9615208f1c09b8.deployweapon;

    if(isDefined(level.var_27f78817b59dfe32)) {
      streakinfo.var_fb58a31c756db4cc = level.var_27f78817b59dfe32;
    }

    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponfireddeploy(streakinfo, deployweaponobj, "grenade_fire", undefined, undefined, &markerthrown);

    if(!istrue(deployresult)) {
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
      return false;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  return true;
}

function markerthrown(streakinfo, weaponobj, projectile) {
  if(issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  projectile.owner = self;

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, self.origin);
  }

  projectile thread function_20037b6d61f6913a(streakinfo);
  streakinfo notify("killstreak_finished_with_deploy_weapon");
  return "success";
}

function function_20037b6d61f6913a(streakinfo) {
  level endon("game_ended");
  ownerangles = self.owner.angles;
  owner = self.owner;
  streakinfo.airdroptype = streakinfo.streakname;
  self waittill("explode", position);

  if(!isDefined(owner)) {
    if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return;
  }

  if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  if(issharedfuncdefined("juggernaut_recon", "dropCrateFromScriptedHeli") && !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    streakinfo.vehicleisreserved = 1;
    data = streakinfo;
    scenenode = [[getsharedfunc("juggernaut_recon", "dropCrateFromScriptedHeli")]](owner, owner.team, "juggernaut_recon", position, ownerangles, position, data, streakinfo);
    owner thread scripts\cp_mp\killstreaks\airdrop::airdrop_playdeploydialog(streakinfo);

    if(!isDefined(scenenode)) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        owner[[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
      }

      if(issharedfuncdefined("killstreak", "awardKillstreakFromStruct")) {
        owner[[getsharedfunc("killstreak", "awardKillstreakFromStruct")]](streakinfo.mpstreaksysteminfo, "other");
      }
    }

    return;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    isfromgrenade = 1;
    owner thread scripts\cp_mp\killstreaks\airdrop::spawnjuggernautcrateatposition(position, isfromgrenade);
  }
}

function function_546bfb8d4d00c31(firstactivation) {
  if(istrue(firstactivation)) {
    self setscriptablepartstate("smoke_cover", "active", 0);
  }
}

function function_c13dca1515447b28(player) {
  streakinfo = self.data;

  if(istrue(player.isjuggernaut)) {
    if(issharedfuncdefined("airdrop", "awardKillstreak")) {
      self.streakinfo = streakinfo;
      player[[getsharedfunc("airdrop", "awardKillstreak")]](streakinfo.streakname, player, self);
    }

    if(issharedfuncdefined("airdrop", "showKillstreakSplash")) {
      player[[getsharedfunc("airdrop", "showKillstreakSplash")]](streakinfo.streakname, undefined, 1);
    }

    return;
  }

  player function_8bac95417054dcbf(streakinfo);
}

function function_bbd5edacfcb74661(immediate) {
  streakinfo = self.data;
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });
}

function function_8bac95417054dcbf(streakinfo) {
  result = 0;

  if(issharedfuncdefined("juggernaut_recon", "makeJuggernaut")) {
    var_fc8f7897b5023b48 = !isDefined(level.var_e084c71df9ac20f1.config);

    var_fc8f7897b5023b48 = var_fc8f7897b5023b48 || getdvarint(@ "hash_e84595a290967e65", 0) == 1;

    if(var_fc8f7897b5023b48) {
      function_8b0517e29ba99749();
    }

    var_6d42c4418479180d = var_fc8f7897b5023b48 || !isDefined(self.var_3c9615208f1c09b8);

    if(var_6d42c4418479180d) {
      bundle = level.streakglobals.streakbundles["juggernaut_recon"];
      self.var_3c9615208f1c09b8 = function_d5974b5f58f14716(bundle, level.var_e084c71df9ac20f1.config, streakinfo.mpstreaksysteminfo.blueprintindex);
    }

    if(isDefined(self.var_3c9615208f1c09b8)) {
      result = self[[getsharedfunc("juggernaut_recon", "makeJuggernaut")]](self.var_3c9615208f1c09b8, streakinfo);
    }
  }

  if(!result) {
    return 0;
  }

  self.isjuggernautrecon = 1;

  if(self isnightvisionon()) {
    self nightvisionviewoff(1);
    self notify("night_vision_off");
  }

  if(issharedfuncdefined("juggernaut_recon", "playOperatorUseLine")) {
    level thread[[getsharedfunc("juggernaut_recon", "playOperatorUseLine")]](self);
  }

  isjuggermoshgamemode = utility::function_f3bb4f4911a1beb2("game", "isJuggerMoshGameMode");

  if(issharedfuncdefined("hud", "teamPlayerCardSplash") && !isjuggermoshgamemode) {
    level thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_juggernaut_recon", self);
  }

  if(!isjuggermoshgamemode) {
    function_68e45178659d4dfd();
  }

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self function_555e2d32e2756625("gasmask_female");
  } else {
    self function_555e2d32e2756625("gasmask_male");
  }

  if(!istrue(streakinfo.var_ca56839b2e00edce)) {
    self setsoundsubmix("mp_juggernaut", 0.5);
  }

  if(!isDefined(self.var_3c9615208f1c09b8) || !istrue(self.var_3c9615208f1c09b8.var_e60a16c2ac55422)) {
    thread function_e3caef85dfedc944();
  }

  thread function_ad3e24a2d0896537(streakinfo);
  thread function_a8ed613077c9e07(streakinfo);
  thread function_ca2a1fd81a921292(streakinfo);
}

function function_e3caef85dfedc944() {
  self endon("death");
  self endon("destroyed");
  self endon("juggernaut_end");
  level endon("game_ended");
  wait 0.5;
  bundle = level.streakglobals.streakbundles["juggernaut_recon"];

  if(isDefined(self.var_3c9615208f1c09b8) && isDefined(self.var_3c9615208f1c09b8.var_3d390afc57b388ef)) {
    var_2ff0b7294cde30f8 = int(self.var_3c9615208f1c09b8.var_3d390afc57b388ef.sweeptime * 1000);
    radarradius = int(self.var_3c9615208f1c09b8.var_3d390afc57b388ef.radius);
    var_8a99420855206d2c = self.var_3c9615208f1c09b8.var_3d390afc57b388ef.interval;
  } else {
    var_2ff0b7294cde30f8 = int(bundle.var_5ac52738ec92f8e * 1000);
    radarradius = int(bundle.var_e57c83329f2687af);

    if(islargemap()) {
      radarradius = int(bundle.var_93d485915fce13b4);
    }

    var_8a99420855206d2c = bundle.var_8d17f7f2d3c1ebb7;
  }

  if(issharedfuncdefined("player", "doScoreEvent")) {
    childthread function_44d4db462cec2873(bundle, radarradius, bundle.var_5ac52738ec92f8e);
  }

  while(true) {
    if(function_7d7531f974260d91()) {
      self notify("juggernaut_recon_ping_start");

      if(level.teambased) {
        triggerportableradarpingteam(self.origin, self.team, radarradius, var_2ff0b7294cde30f8);
      } else {
        triggerportableradarping(self.origin, self, radarradius, var_2ff0b7294cde30f8);
      }
    }

    wait var_8a99420855206d2c;
    self notify("juggernaut_recon_ping_end");
  }
}

function function_7d7531f974260d91() {
  if(istrue(self.var_85dc59c6a906819f)) {
    return false;
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    return false;
  }

  return true;
}

function function_44d4db462cec2873(bundle, radarradius, var_2ff0b7294cde30f8) {
  while(true) {
    self waittill("juggernaut_recon_ping_start");
    pingcenter = self.origin;
    checkinterval = var_2ff0b7294cde30f8 / bundle.var_9bf9f003feb68ed8;
    characterschecked = [];

    for(i = 1; i <= bundle.var_9bf9f003feb68ed8; i++) {
      wait checkinterval;
      var_ad00034aa6fc55c9 = i / bundle.var_9bf9f003feb68ed8 * radarradius;

      if(issharedfuncdefined("game", "getEnemyTeams")) {
        enemyteams = [[getsharedfunc("game", "getEnemyTeams")]](self.team);
        var_782a999b1a24e0d8 = function_143526130b12b2b6(pingcenter, var_ad00034aa6fc55c9, enemyteams);
      } else {
        var_782a999b1a24e0d8 = function_143526130b12b2b6(pingcenter, var_ad00034aa6fc55c9);
      }

      foreach(newcharacter in var_782a999b1a24e0d8) {
        if(!array_contains(characterschecked, newcharacter)) {
          characterschecked = array_add(characterschecked, newcharacter);

          if(newcharacter function_88879d917e6d2d8b()) {
            continue;
          }

          newcharacter childthread function_b3ac6739913f71ab(self);
        }
      }
    }

    self waittill("juggernaut_recon_ping_end");
  }
}

function function_b3ac6739913f71ab(juggernautplayer) {
  juggernautplayer endon("juggernaut_recon_ping_end");
  self waittill("death", attacker);

  if(isDefined(attacker) && isPlayer(attacker) && attacker != juggernautplayer) {
    isfriendly = 0;

    if(issharedfuncdefined("player", "isFriendly")) {
      isfriendly = [[getsharedfunc("player", "isFriendly")]](juggernautplayer.team, attacker);
    }

    if(isfriendly) {
      juggernautplayer thread[[getsharedfunc("player", "doScoreEvent")]](#"hash_70ccc75b709ede6f");
    }
  }
}

function function_ad3e24a2d0896537(streakinfo) {
  self endon("disconnect");
  self endon("juggernaut_end");
  level waittill("game_ended");

  if(isDefined(self) && isDefined(streakinfo)) {
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
  }
}

function function_a8ed613077c9e07(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");
  juggcontext = self.juggcontext;
  self waittill("juggernaut_end");

  if(isDefined(self.operatorcustomization)) {
    if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
      self function_555e2d32e2756625("female");
    } else {
      self function_555e2d32e2756625("");
    }
  }

  self clearsoundsubmix("mp_juggernaut", 0.5);
  function_d6e3424025c35356(streakinfo, juggcontext);
}

function function_d6e3424025c35356(streakinfo, juggcontext) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    level callback::callback("killstreak_finish_use", {
      #streakinfo: streakinfo
    });
    streakinfo.expiredbydeath = 1;
    scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(streakinfo);
  }

  function_2bb8ec2d315b7cb1(juggcontext);
}

function function_ca2a1fd81a921292(streakinfo) {
  self endon("juggernaut_end");
  level endon("game_ended");
  juggcontext = self.juggcontext;
  self waittill("disconnect");
  function_2bb8ec2d315b7cb1(juggcontext);
}

function function_68e45178659d4dfd(var_cbcc20cc563590c7) {
  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(!isDefined(var_cbcc20cc563590c7)) {
      var_cbcc20cc563590c7 = "playerObjective";
    }

    self setscriptablepartstate(var_cbcc20cc563590c7, "juggernaut", 0);
    return;
  }

  requestfunc = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "requestObjectiveID")) {
    requestfunc = scripts\engine\utility::getsharedfunc("game", "requestObjectiveID");
  }

  if(isDefined(requestfunc)) {
    objid = [[requestfunc]](99);
    self.juggcontext.juggobjid = objid;
    utility::function_f3bb4f4911a1beb2(#"objective", #"objective_add_objective", objid, "active", self.origin, "jup_hud_icon_minimap_killstreak_juggernaut_recon", "icon_medium");
    utility::function_f3bb4f4911a1beb2(#"objective", #"objective_set_play_intro", objid, 0);
    utility::function_f3bb4f4911a1beb2(#"objective", #"objective_set_play_outro", objid, 0);

    foreach(player in level.players) {
      if(!isDefined(player) || isbot(player) || player == self) {
        continue;
      }

      utility::function_f3bb4f4911a1beb2(#"objective", #"showtoplayer", objid, player);
    }

    utility::function_f3bb4f4911a1beb2(#"objective", #"update_objective_onentity", objid, self);
    utility::function_f3bb4f4911a1beb2(#"objective", #"update_objective_setbackground", objid, 1);

    if(level.teambased) {
      utility::function_f3bb4f4911a1beb2(#"objective", #"update_objective_ownerteam", objid, self.team);
      return;
    }

    utility::function_f3bb4f4911a1beb2(#"objective", #"update_objective_ownerclient", objid, self);
  }
}

function function_2bb8ec2d315b7cb1(juggcontext, var_cbcc20cc563590c7) {
  if(isDefined(self) && scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    if(!isDefined(var_cbcc20cc563590c7)) {
      var_cbcc20cc563590c7 = "playerObjective";
    }

    self setscriptablepartstate(var_cbcc20cc563590c7, "off", 0);
    return;
  }

  if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
    [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](juggcontext.juggobjid);
  }
}