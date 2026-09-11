/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_compass.gsc
******************************************************/

function calloutmarkerping_init() {
  scripts\cp\vehicles\little_bird_mg_cp::fulton_actors_players();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_onplayerdisconnect);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconShouldCreate", &fulton_initrepository);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ping", "calloutMarkerPing_squadLeaderBeaconKillForPlayer", &fulton_init);
  level._effect["vfx_br_beacon_circle"] = loadfx("vfx/_requests/br_gameplay/vfx_br_beacon_circle");
}

function fulton_initrepository(var_0, var_1, var_2) {
  if(!getdvarint("scr_calloutmarkerping_squadleaderbeacon", 0)) {
    return;
  }

  if(var_0 scripts\mp\gametypes\br_public::updatedragonsbreath() && istrue(var_0.delay_give_tactical_grenade) && var_1 == scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_getpoolidnavigation() || getdvarint("scr_calloutmarkerping_squadleaderbeacon_forceactive", 0)) {
    fulton_hostageent(var_2);
    return;
  }
}

function fulton_hostageent(var_0) {
  var_1 = self;
  var_2 = scripts\engine\utility::getfx("vfx_br_beacon_circle");
  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var_1.team, 1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5.ref_1373e)) {
      var_5.ref_1373e delete();
    }

    var_5.ref_1373e = spawnfxforclient(var_2, var_0, var_5);
    triggerfx(var_5.ref_1373e);
    var_5.ref_1373e setfxkilldefondelete();
    var_5.ref_1373c = var_0;
    var_5.ref_1373d = 892.5;
    var_5.ref_1373f = 1;
  }
}

function fulton_initanims() {
  var_0 = self;

  if(!getdvarint("scr_calloutmarkerping_squadleaderbeacon", 0)) {
    return;
  }

  if(!istrue(var_0.ref_1373f)) {
    return;
  }

  if(scripts\engine\utility::updatescrapassistdata(var_0.origin, var_0.ref_1373c, var_0.ref_1373d)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      var_0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]]("br_beacon_bonus");
    }
  }

  var_0.ref_1373e delete();
  var_0.ref_1373c = undefined;
  var_0.ref_1373d = undefined;
  var_0.ref_1373f = undefined;
}

function fulton_init(var_0) {
  if(!getdvarint("scr_calloutmarkerping_squadleaderbeacon", 0)) {
    return;
  }

  if(isDefined(var_0.ref_1373e)) {
    var_0.ref_1373e delete();
    var_0.ref_1373c = undefined;
    var_0.ref_1373d = undefined;
    var_0.ref_1373f = undefined;
  }
}