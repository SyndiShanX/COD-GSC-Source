/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_choppers.gsc
************************************************************/

function init() {
  var0 = spawnStruct();
  var0.ref_140cf = &ref_140cf;
  var0.weight = getdvarfloat("scr_br_pe_choppers_weight", 1);
  var0.ref_14382 = &ref_14382;
  var0.attackerswaittime = &attackerswaittime;
  var0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var0.ref_11b78 = getdvarint("scr_br_pe_choppers_max_times", 1);
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("choppers", "55 5 1015155 5");
    var0.£¼#w]
  j‹ ƒ½ Ï‚ UÀíÌI¸ Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("choppers");
  var1 = scripts\engine\utility::ter_op(scripts\mp\gametypes\br_publicevents::ref_11e05(), 120, 0);
  var2 = getdvarint("scr_br_pe_choppers_lifetime", var1);
  var0.sol_5_6_pool = var2;
  scripts\mp\gametypes\br_publicevents::ref_12b35(1, var0);
}

function postinitfunc() {
  game["dialog"]["public_events_choppers_start"] = "public_events_supply_choppers_start";
}

function ref_140cf() {
  var0 = scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war";
  return !var0;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var0 = forest_combat();
  wait var0;
}

function attackerswaittime() {
  level endon("game_ended");
  var0 = getdvarint("scr_br_pe_choppers_count", 5);
  forest_fire_setup(level, var0);
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_choppers_start");
  scripts\mp\gametypes\br_public::brleaderdialog("public_events_choppers_start");
  setomnvar("ui_publicevent_minimap_pulse", 1);
  thread ref_13622(var0);
  var1 = 10;
  thread scripts\mp\gametypes\br_publicevents::resetminimappulse(var1);
  ref_14404(var1);
}

function forest_combat() {
  var0 = getdvarfloat("scr_br_pe_choppers_starttime_min", 555);
  var1 = getdvarfloat("scr_br_pe_choppers_starttime_max", 765);

  if(var1 > var0) {
    return randomfloatrange(var0, var1);
  }

  return var0;
}

function ref_14404(var0) {
  level endon("game_ended");
  jumpiffalse(isDefined(var0)) LOC_00000011;
  wait var0;

  for(;;) {
    var1 = level.ref_119e7;

    if(!isDefined(var1)) {
      break;
    }

    var1 = scripts\engine\utility::array_removeundefined(var1);

    if(var1.size == 0) {
      break;
    }

    wait 1;
  }
}

function ref_13622(var0) {
  level endon("game_ended");
  var1 = undefined;
  var2 = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    var1 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var2 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  } else {
    level.binoculars_checkexpirationtimer = 35;
    level.ref_12946 = 1;
    level.fly_over_path = 0;
    level thread scripts\mp\gametypes\br_functional_poi::ref_1325b();
  }

  scripts\mp\gametypes\br_lootchopper::init();
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_lootchopper", "lootChopper_onCrateUse", &ref_1200f);

  if(!isDefined(level.ref_1229f)) {
    var3 = scripts\mp\gametypes\br_lootchopper::ref_11a0c(var1, var2);
    scripts\mp\gametypes\br_lootchopper::ref_11a0d(var3);
  }

  var4 = getdvarint("scr_br_pe_choppers_mindist", 6000);

  if(level.mapname == "mp_br_mechanics") {
    var4 = 1000;
  }

  var5 = 0;

  while(var5 < var0) {
    var6 = undefined;

    if(isDefined(level.ref_1229f)) {
      var6 = level.ref_1229f[var5];
    } else {
      var7 = var5 % 4 + 1;
      var6 = scripts\mp\gametypes\br_lootchopper::ref_11a07(level.ref_119e6["quad_" + var7], var4);
    }

    var8 = scripts\mp\gametypes\br_lootchopper::ref_11a18(var6, "veh_chopper_support_pe_mp");

    if(isDefined(var8)) {
      if(isDefined(level.ref_1229d)) {
        var8.lootfunc = level.ref_1229d;
      } else {
        var8.lootfunc = &dropcrate;
      }

      if(!getdvarint("scr_br_pe_choppers_attack", 0)) {
        var8.frontturret.ref_13e86 = 1;
        var8.frontturret makeunusable();
        var8.rearturret.ref_13e86 = 1;
        var8.rearturret makeunusable();
      }

      var8.flaresreservecount = getdvarint("scr_br_pe_choppers_flares", 0);
      var8.health = getdvarint("scr_br_pe_choppers_health", 5000);
      var8.maxhealth = getdvarint("scr_br_pe_choppers_health", 5000);

      if(scripts\mp\gametypes\br_publicevents::unset_relic_healthpacks()) {
        var8.lifetime = scripts\mp\gametypes\br_circle::inithelirepository();
      } else if(self.sol_5_6_pool) {
        var8.lifetime = self.sol_5_6_pool;
      }

      if(getdvarint("scr_br_pe_choppers_attack", 0) != 0) {
        var9 = "ui_mp_br_mapmenu_icon_boss_chopper";
      } else {
        var9 = "ui_mp_br_mapmenu_icon_boss_chopper_event";
      }

      scripts\mp\objidpoolmanager::update_objective_icon(var9.objectiveiconid, var9);
    }

    wait 1;
    var6++;
  }

  var10 = getdvarfloat("scr_br_pe_chopppers_circle_damage_start_time", 10);
  level.delay_turn_on_headlights = gettime() + int(var10 * 1000);
}

function dropcrate() {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance(self);
  var0 = scripts\mp\gametypes\br_lootchopper::ref_11a06(self.origin + (0, 0, 500));

  if(isDefined(var0)) {
    var1 = scripts\cp_mp\killstreaks\airdrop::missionid(self.origin, var0);
    var2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var1);
    var2.ref_140a0 = 10;

    if(!isDefined(level.delay_turn_off_tum_display)) {
      level.delay_turn_off_tum_display = [];
    }

    level.delay_turn_off_tum_display[level.delay_turn_off_tum_display.size] = var1;
    return;
  }
}

function ref_1200f(var0) {
  self.itemsdropped = 0;

  if(!isDefined(level.delay_turn_off_red_lights_along_track)) {
    level.delay_turn_off_red_lights_along_track = 0;
  } else {
    level.delay_turn_off_red_lights_along_track = (level.delay_turn_off_red_lights_along_track + 1) % 10;
  }

  var1 = verifybunkercode("pe_chopper_crate", level.delay_turn_off_red_lights_along_track);

  if(isDefined(var1)) {
    var1 = scripts\mp\gametypes\br_lootcache::ref_11a1a(var1, var0);
  }

  if(isDefined(var1) && var0 scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance")) {
    var1 = scripts\mp\gametypes\br_lootcache::ref_11a1d(var1, var0);
  }

  if(isDefined(var1)) {
    var2 = scripts\mp\gametypes\br_lootcache::ref_11a02(var1);
  }

  if(!isDefined(var0.ref_11a01)) {
    var0.ref_11a01 = 1;
  } else {
    var0.ref_11a01++;
  }

  var0 scripts\mp\utility\stats::setextrascore1(var0.ref_11a01);
  var0 thread scripts\mp\utility\points::giveunifiedpoints("br_loot_chopper_box_open");
}

function dangercircletick(var0, var1) {
  if(!isDefined(level.delay_turn_on_headlights) || gettime() < level.delay_turn_on_headlights) {
    return;
  }

  var2 = getdvarfloat("scr_br_pe_choppers_circle_damage_tick", 500);
  var3 = 240;
  var4 = level.ref_119e7;

  if(isDefined(var4)) {
    var4 = scripts\engine\utility::array_removeundefined(var4);

    foreach(var6 in var4) {
      var7 = 0;
      var8 = var6.origin;
      var9 = distance2d(var0, var8);

      if(var9 + var3 > var1) {
        var7 = 1;
      }

      if(var7) {
        var10 = var6.health;
        var11 = var6.maxhealth;
        var6 dodamage(var2, var8, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }

  var13 = getdvarfloat("scr_br_circle_object_cleanup_threshold", 2400);
  var14 = level.delay_turn_off_tum_display;

  if(isDefined(var14)) {
    var14 = scripts\engine\utility::array_removeundefined(var14);

    foreach(var16 in var14) {
      var17 = distance2dsquared(var16.origin, var0);
      var18 = max(0, var1 + var13);

      if(var17 > var18 * var18) {
        var16 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
      }
    }

    return;
  }
}

function forest_fire_setup(var0) {
  level endon("game_ended");

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent)) {
    return;
  }

  var1 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var2 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var3 = 0.3;
  var4 = 0.8;
  var5 = var2 * var3;
  var6 = var2 * var4;
  var7 = play_tape_machine_animation(var1, var5, var6);
  var8 = var7[0];
  var9 = var7[1];
  var7 = undefined;

  if(var8 == var9) {
    return;
  }

  if(var8 != 0 || var9 != 360) {
    var8 += 20;
    var9 -= 20;

    if(var9 <= var8) {
      return;
    }
  } else {
    var10 = randomfloatrange(0, 360);
    var8 += var10;
    var9 += var10;
  }

  var11 = (var9 - var8) / max(1, var0 - 1);
  level.ref_1229f = [];

  for(var12 = 0; var12 < var0; var12++) {
    var13 = var8 + var11 * var12;
    var14 = anglesToForward((0, var13, 0));

    if(var6 > var5) {
      var15 = randomfloatrange(var5, var6);
    } else {
      var15 = var6;
    }

    var16 = var1 + var14 * var15;

    if(isscriptabledefined()) {
      var16 = getclosestpointonnavmesh(var16);
    }

    var17 = spawnStruct();
    var17.origin = var16;
    level.ref_1229f[var12] = var17;
  }
}

function play_tape_machine_animation(var0, var1, var2) {
  level endon("game_ended");
  var3 = level.mapcenter - var0;
  var3 = (var3[0], var3[1], 0);
  var3 = vectorNormalize(var3);
  var4 = vectortoyaw(var3);
  var5 = var0 + var3 * var1;
  var6 = var0 + var3 * var2;
  var7 = !scripts\mp\outofbounds::ispointinoutofbounds(var5) && !scripts\mp\outofbounds::ispointinoutofbounds(var6);

  if(!var7) {
    return [0, 0];
  }

  var8 = 45;
  var9 = 45;
  var10 = var4;
  var11 = var4 + var8;
  var12 = var4;
  var13 = var4 - var9;
  var14 = 0;
  var15 = 180 / int(var8);
  var16 = 0;
  var17 = 1;

  for(;;) {
    if(var8 >= var17) {
      var18 = anglesToForward((0, var11, 0));
      var19 = var0 + var18 * var1;
      var20 = var0 + var18 * var2;
      var21 = !scripts\mp\outofbounds::ispointinoutofbounds(var19) && !scripts\mp\outofbounds::ispointinoutofbounds(var20);

      if(var21) {
        var10 = var11;
        var11 = var10 + var8;
      } else {
        var16 = 1;
        var8 *= 0.5;
        var11 = var10 + var8;
      }
    }

    if(var9 >= var17) {
      var22 = anglesToForward((0, var13, 0));
      var23 = var0 + var22 * var1;
      var24 = var0 + var22 * var2;
      var25 = !scripts\mp\outofbounds::ispointinoutofbounds(var23) && !scripts\mp\outofbounds::ispointinoutofbounds(var24);

      if(var25) {
        var12 = var13;
        var13 = var12 - var9;
      } else {
        var16 = 1;
        var9 *= 0.5;
        var13 = var12 - var9;
      }
    }

    if(!var16) {
      var14++;

      if(var14 >= var15) {
        return [0, 360];
      }
    }

    if(var8 < var17 && var9 < var17) {
      return [var12, var10];
    }

    waitframe();
  }
}