/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\advanced_supply_drop.gsc
*********************************************************/

function advanced_supply_drop_marker_used(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("grenade_OOB");
  var_0 endon("explode_end");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  thread vfx_htown_hadirj_blink(var_1);
  thread binoculars_onstatelospendingexit(var_1);
  var_0 waittill("explode", var_2);
  var_1 notify("advanced_supply_drop_finished");
  thread binoculars_onstatelospendingenter(var_2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var_2)) {
    if(isDefined(var_0)) {
      var_0 delete();
    }

    if(isDefined(var_1.super)) {
      var_1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  var_3 = scripts\mp\gametypes\br_rewards::relic_punchbullets_fire_fists(0, 1, 0, 0, 0);
  var_1 scripts\mp\gametypes\br_rewards::ref_1363A(var_2, var_3);

  if(isDefined(var_1.super)) {
    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
    return;
  }
}

function vfx_htown_hadirj_blink(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_0 endon("explode");
  var_0 endon("explode_end");
  wait 10;

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_1 notify("grenade_OOB");
}

function binoculars_onstatelospendingupdate(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("grenade_OOB");
  var_0 endon("explode_end");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  thread vfx_htown_hadirj_blink(var_1);
  thread binoculars_onstatelospendingexit(var_1);
  jumpiffalse(isDefined(level.ref_13ACD)) LOC_0000004e;
  thread ref_13AA0(level, var_1);
  var_0 waittill("explode", var_2);
  var_1 notify("advanced_supply_drop_finished");
  thread binoculars_onstatelospendingenter(var_2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var_2)) {
    if(isDefined(var_0)) {
      var_0 delete();
    }

    if(isDefined(var_1.super)) {
      var_1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  var_3 = spawnStruct();
  var_4 = scripts\engine\trace::create_default_contents(1);
  var_5 = scripts\engine\trace::sphere_trace(var_2 + (0, 0, 10000), var_2 - (0, 0, 20000), 256, undefined, var_4, 0);
  var_6 = getdvarint("scr_truckwar_replace_fail_distance", 512);

  if(distancesquared(var_2, var_5["position"]) > var_6 * var_6) {
    if(isDefined(var_0)) {
      var_0 delete();
    }

    if(isDefined(var_1.super)) {
      var_1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  if(isDefined(level.ref_13ACE) && isDefined(level.ref_13ACE[var_1.team])) {
    if(isDefined(var_0)) {
      var_0 delete();
    }

    if(isDefined(var_1.super)) {
      var_1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  var_7 = (var_2[0], var_2[1], var_5["position"][2]);
  var_3.origin = var_7 + (0, 0, 50000);
  var_8 = scripts\mp\gametypes\br_gametype_truckwar::ref_14263(var_3);

  if(isDefined(var_8)) {
    if(getDvar("scr_br_gametype", "") == "truckwar") {
      scripts\mp\gametypes\br_gametype_truckwar::thrownoffhand(var_8, var_1.team, 1);
    }

    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13DE4(var_8, var_7, var_8.angles, 1);
  }

  if(isDefined(var_1.super)) {
    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
    return;
  }
}

function ref_13AA0(var_0, var_1) {
  var_2 = var_0.team;
  level.ref_13ACD[var_2] = 1;
  scripts\engine\utility::waittill_any_ents(var_0, "disconnect", var_1, "explode_end", var_1, "explode", var_1, "death");
  level.ref_13ACD[var_2] = undefined;
}

function binoculars_onstatelospendingexit(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("advanced_supply_drop_finished");
  var_0 waittill("death");
  waitframe();

  if(isDefined(var_1.super)) {
    var_1 scripts\mp\supers::superusefinished(1);
    return;
  }
}

function binoculars_onstatelospendingenter(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playLoopSound("smoke_carepackage_smoke_lp");
  wait 21;
  var_1 playSound("smoke_canister_tail_dissipate");
  var_1 stoploopsound("smoke_carepackage_smoke_lp");
  wait 5;
  var_1 delete();
}

function binoculars_onstateinvalidupdate(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("grenade_OOB");
  var_0 endon("explode_end");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  thread vfx_htown_hadirj_blink(var_1);
  thread binoculars_onstatelospendingexit(var_1);
  var_0 waittill("explode", var_2);
  var_1 notify("advanced_supply_drop_finished");
  thread binoculars_onstatelospendingenter(var_2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var_2)) {
    if(isDefined(var_0)) {
      var_0 delete();
    }

    if(isDefined(var_1.super)) {
      var_1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  var_3 = 4096;
  var_4 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_3", "targetname");

  if(istrue(self.umbra) || isDefined(var_4) && distance2d(var_2, var_4.origin) < 5000) {
    var_3 = 10000;
  }

  var_5 = var_2 + (0, 0, var_3);
  var_6 = var_2 + (0, 0, 512);
  var_7 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, self.team, "heavy_weapon_crate", var_5, (0, randomfloat(360), 0), var_6);

  if(isDefined(var_7)) {
    thread shutdowngulagforalivecount(var_7);
  }

  if(isDefined(var_1.super)) {
    var_1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
    return;
  }
}

function shutdowngulagforalivecount(var_0) {
  self setotherent(var_0);
  self setscriptablepartstate("objective", "heavy_weapon");
}