/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\advanced_supply_drop.gsc
*********************************************************/

function advanced_supply_drop_marker_used(var0) {
  var1 = self;
  var1 endon("disconnect");
  var1 endon("grenade_OOB");
  var0 endon("explode_end");
  var0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  thread vfx_htown_hadirj_blink(var1);
  thread binoculars_onstatelospendingexit(var1);
  var0 waittill("explode", var2);
  var1 notify("advanced_supply_drop_finished");
  thread binoculars_onstatelospendingenter(var2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var2)) {
    if(isDefined(var0)) {
      var0 delete();
    }

    if(isDefined(var1.super)) {
      var1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  var3 = scripts\mp\gametypes\br_rewards::relic_punchbullets_fire_fists(0, 1, 0, 0, 0);
  var1 scripts\mp\gametypes\br_rewards::ref_1363a(var2, var3);

  if(isDefined(var1.super)) {
    var1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
    return;
  }
}

function vfx_htown_hadirj_blink(var0) {
  var1 = self;
  var1 endon("disconnect");
  var0 endon("explode");
  var0 endon("explode_end");
  wait 10;

  if(isDefined(var0)) {
    var0 delete();
  }

  var1 notify("grenade_OOB");
}

function binoculars_onstatelospendingupdate(var0) {
  var1 = self;
  var1 endon("disconnect");
  var1 endon("grenade_OOB");
  var0 endon("explode_end");
  var0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  thread vfx_htown_hadirj_blink(var1);
  thread binoculars_onstatelospendingexit(var1);
  jumpiffalse(isDefined(level.ref_13acd)) LOC_0000004e;
  thread ref_13aa0(level, var1);
  var0 waittill("explode", var2);
  var1 notify("advanced_supply_drop_finished");
  thread binoculars_onstatelospendingenter(var2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var2)) {
    if(isDefined(var0)) {
      var0 delete();
    }

    if(isDefined(var1.super)) {
      var1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  var3 = spawnStruct();
  var4 = scripts\engine\trace::create_default_contents(1);
  var5 = scripts\engine\trace::sphere_trace(var2 + (0, 0, 10000), var2 - (0, 0, 20000), 256, undefined, var4, 0);
  var6 = getdvarint("scr_truckwar_replace_fail_distance", 512);

  if(distancesquared(var2, var5["position"]) > var6 * var6) {
    if(isDefined(var0)) {
      var0 delete();
    }

    if(isDefined(var1.super)) {
      var1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  if(isDefined(level.ref_13ace) && isDefined(level.ref_13ace[var1.team])) {
    if(isDefined(var0)) {
      var0 delete();
    }

    if(isDefined(var1.super)) {
      var1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  var7 = (var2[0], var2[1], var5["position"][2]);
  var3.origin = var7 + (0, 0, 50000);
  var8 = scripts\mp\gametypes\br_gametype_truckwar::ref_14263(var3);

  if(isDefined(var8)) {
    if(getDvar("scr_br_gametype", "") == "truckwar") {
      scripts\mp\gametypes\br_gametype_truckwar::thrownoffhand(var8, var1.team, 1);
    }

    level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13de4(var8, var7, var8.angles, 1);
  }

  if(isDefined(var1.super)) {
    var1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
    return;
  }
}

function ref_13aa0(var0, var1) {
  var2 = var0.team;
  level.ref_13acd[var2] = 1;
  scripts\engine\utility::waittill_any_ents(var0, "disconnect", var1, "explode_end", var1, "explode", var1, "death");
  level.ref_13acd[var2] = undefined;
}

function binoculars_onstatelospendingexit(var0) {
  var1 = self;
  var1 endon("disconnect");
  var1 endon("advanced_supply_drop_finished");
  var0 waittill("death");
  waitframe();

  if(isDefined(var1.super)) {
    var1 scripts\mp\supers::superusefinished(1);
    return;
  }
}

function binoculars_onstatelospendingenter(var0) {
  var1 = spawn("script_origin", var0);
  var1 playLoopSound("smoke_carepackage_smoke_lp");
  wait 21;
  var1 playSound("smoke_canister_tail_dissipate");
  var1 stoploopsound("smoke_carepackage_smoke_lp");
  wait 5;
  var1 delete();
}

function binoculars_onstateinvalidupdate(var0) {
  var1 = self;
  var1 endon("disconnect");
  var1 endon("grenade_OOB");
  var0 endon("explode_end");
  var0 thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  thread vfx_htown_hadirj_blink(var1);
  thread binoculars_onstatelospendingexit(var1);
  var0 waittill("explode", var2);
  var1 notify("advanced_supply_drop_finished");
  thread binoculars_onstatelospendingenter(var2);

  if(scripts\mp\outofbounds::ispointinoutofbounds(var2)) {
    if(isDefined(var0)) {
      var0 delete();
    }

    if(isDefined(var1.super)) {
      var1 scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  var3 = 4096;
  var4 = scripts\engine\utility::getStruct("soa_tower_elevator_floor_3", "targetname");

  if(istrue(self.umbra) || isDefined(var4) && distance2d(var2, var4.origin) < 5000) {
    var3 = 10000;
  }

  var5 = var2 + (0, 0, var3);
  var6 = var2 + (0, 0, 512);
  var7 = scripts\cp_mp\killstreaks\airdrop::dropcrate(undefined, self.team, "heavy_weapon_crate", var5, (0, randomfloat(360), 0), var6);

  if(isDefined(var7)) {
    thread shutdowngulagforalivecount(var7);
  }

  if(isDefined(var1.super)) {
    var1 scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
    return;
  }
}

function shutdowngulagforalivecount(var0) {
  self setotherent(var0);
  self setscriptablepartstate("objective", "heavy_weapon");
}