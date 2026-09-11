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

function fulton_initrepository(var0, var1, var2) {
  if(!getdvarint("scr_calloutmarkerping_squadleaderbeacon", 0)) {
    return;
  }

  if(var0 scripts\mp\gametypes\br_public::updatedragonsbreath() && istrue(var0.delay_give_tactical_grenade) && var1 == scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_getpoolidnavigation() || getdvarint("scr_calloutmarkerping_squadleaderbeacon_forceactive", 0)) {
    fulton_hostageent(var2);
    return;
  }
}

function fulton_hostageent(var0) {
  var1 = self;
  var2 = scripts\engine\utility::getfx("vfx_br_beacon_circle");
  var3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getFriendlyPlayers")]](var1.team, 1);

  foreach(var5 in var3) {
    if(isDefined(var5.ref_1373e)) {
      var5.ref_1373e delete();
    }

    var5.ref_1373e = spawnfxforclient(var2, var0, var5);
    triggerfx(var5.ref_1373e);
    var5.ref_1373e setfxkilldefondelete();
    var5.ref_1373c = var0;
    var5.ref_1373d = 892.5;
    var5.ref_1373f = 1;
  }
}

function fulton_initanims() {
  var0 = self;

  if(!getdvarint("scr_calloutmarkerping_squadleaderbeacon", 0)) {
    return;
  }

  if(!istrue(var0.ref_1373f)) {
    return;
  }

  if(scripts\engine\utility::updatescrapassistdata(var0.origin, var0.ref_1373c, var0.ref_1373d)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("rank", "scoreEventPopup")) {
      var0 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "scoreEventPopup")]]("br_beacon_bonus");
    }
  }

  var0.ref_1373e delete();
  var0.ref_1373c = undefined;
  var0.ref_1373d = undefined;
  var0.ref_1373f = undefined;
}

function fulton_init(var0) {
  if(!getdvarint("scr_calloutmarkerping_squadleaderbeacon", 0)) {
    return;
  }

  if(isDefined(var0.ref_1373e)) {
    var0.ref_1373e delete();
    var0.ref_1373c = undefined;
    var0.ref_1373d = undefined;
    var0.ref_1373f = undefined;
  }
}