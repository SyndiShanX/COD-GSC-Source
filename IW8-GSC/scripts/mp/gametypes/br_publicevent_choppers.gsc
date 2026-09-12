/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_choppers.gsc
************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.ref_140cf = &ref_140cf;
  var_0.weight = getdvarfloat("scr_br_pe_choppers_weight", 1);
  var_0.ref_14382 = &ref_14382;
  var_0.attackerswaittime = &attackerswaittime;
  var_0.postinitfunc = &postinitfunc;
  var_0.ref_11b78 = getdvarint("scr_br_pe_choppers_max_times", 1);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("choppers", "55 5 1015155 5");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("choppers");
  var_1 = scripts\engine\utility::ter_op(scripts\mp\gametypes\br_publicevents::ref_11e05(), 120, 0);
  var_2 = getdvarint("scr_br_pe_choppers_lifetime", var_1);
  var_0.sol_5_6_pool = var_2;
  scripts\mp\gametypes\br_publicevents::ref_12b35(1, var_0);
}

function postinitfunc() {
  game["dialog"]["public_events_choppers_start"] = "public_events_supply_choppers_start";
}

function ref_140cf() {
  var_0 = scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war";
  return !var_0;
}

function ref_14382() {
  level endon("game_ended");
  level endon("cancel_public_event");
  var_0 = forest_combat();
  wait var_0;
}

function attackerswaittime() {
  level endon("game_ended");
  var_0 = getdvarint("scr_br_pe_choppers_count", 5);
  forest_fire_setup(level, var_0);
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_choppers_start");
  scripts\mp\gametypes\br_public::brleaderdialog("public_events_choppers_start");
  setomnvar("ui_publicevent_minimap_pulse", 1);
  thread ref_13622(var_0);
  var_1 = 10;
  thread scripts\mp\gametypes\br_publicevents::resetminimappulse(var_1);
  ref_14404(var_1);
}

function forest_combat() {
  var_0 = getdvarfloat("scr_br_pe_choppers_starttime_min", 555);
  var_1 = getdvarfloat("scr_br_pe_choppers_starttime_max", 765);

  if(var_1 > var_0) {
    return randomfloatrange(var_0, var_1);
  }

  return var_0;
}

function ref_14404(var_0) {
  level endon("game_ended");
  jumpiffalse(isDefined(var_0)) LOC_00000011;
  wait var_0;

  for(;;) {
    var_1 = level.ref_119e7;

    if(!isDefined(var_1)) {
      break;
    }

    var_1 = scripts\engine\utility::array_removeundefined(var_1);

    if(var_1.size == 0) {
      break;
    }

    wait 1;
  }
}

function ref_13622(var_0) {
  level endon("game_ended");
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    var_1 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var_2 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  } else {
    level.binoculars_checkexpirationtimer = 35;
    level.ref_12946 = 1;
    level.fly_over_path = 0;
    level thread scripts\mp\gametypes\br_functional_poi::ref_1325b();
  }

  scripts\mp\gametypes\br_lootchopper::init();
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_lootchopper", "lootChopper_onCrateUse", &ref_1200f);

  if(!isDefined(level.ref_1229f)) {
    var_3 = scripts\mp\gametypes\br_lootchopper::ref_11a0c(var_1, var_2);
    scripts\mp\gametypes\br_lootchopper::ref_11a0d(var_3);
  }

  var_4 = getdvarint("scr_br_pe_choppers_mindist", 6000);

  if(level.mapname == "mp_br_mechanics") {
    var_4 = 1000;
  }

  var_5 = 0;

  while(var_5 < var_0) {
    var_6 = undefined;

    if(isDefined(level.ref_1229f)) {
      var_6 = level.ref_1229f[var_5];
    } else {
      var_7 = var_5 % 4 + 1;
      var_6 = scripts\mp\gametypes\br_lootchopper::ref_11a07(level.ref_119e6["quad_" + var_7], var_4);
    }

    var_8 = scripts\mp\gametypes\br_lootchopper::ref_11a18(var_6, "veh_chopper_support_pe_mp");

    if(isDefined(var_8)) {
      if(isDefined(level.ref_1229d)) {
        var_8.lootfunc = level.ref_1229d;
      } else {
        var_8.lootfunc = &dropcrate;
      }

      if(!getdvarint("scr_br_pe_choppers_attack", 0)) {
        var_8.frontturret.ref_13e86 = 1;
        var_8.frontturret makeunusable();
        var_8.rearturret.ref_13e86 = 1;
        var_8.rearturret makeunusable();
      }

      var_8.flaresreservecount = getdvarint("scr_br_pe_choppers_flares", 0);
      var_8.health = getdvarint("scr_br_pe_choppers_health", 5000);
      var_8.maxhealth = getdvarint("scr_br_pe_choppers_health", 5000);

      if(scripts\mp\gametypes\br_publicevents::unset_relic_healthpacks()) {
        var_8.lifetime = scripts\mp\gametypes\br_circle::inithelirepository();
      } else if(self.sol_5_6_pool) {
        var_8.lifetime = self.sol_5_6_pool;
      }

      if(getdvarint("scr_br_pe_choppers_attack", 0) != 0) {
        var_9 = "ui_mp_br_mapmenu_icon_boss_chopper";
      } else {
        var_9 = "ui_mp_br_mapmenu_icon_boss_chopper_event";
      }

      scripts\mp\objidpoolmanager::update_objective_icon(var_9.objectiveiconid, var_9);
    }

    wait 1;
    var_6++;
  }

  var_10 = getdvarfloat("scr_br_pe_chopppers_circle_damage_start_time", 10);
  level.delay_turn_on_headlights = gettime() + int(var_10 * 1000);
}

function dropcrate() {
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance(self);
  var_0 = scripts\mp\gametypes\br_lootchopper::ref_11a06(self.origin + (0, 0, 500));

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\killstreaks\airdrop::missionid(self.origin, var_0);
    var_2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject(var_1);
    var_2.ref_140a0 = 10;

    if(!isDefined(level.delay_turn_off_tum_display)) {
      level.delay_turn_off_tum_display = [];
    }

    level.delay_turn_off_tum_display[level.delay_turn_off_tum_display.size] = var_1;
    return;
  }
}

function ref_1200f(var_0) {
  self.itemsdropped = 0;

  if(!isDefined(level.delay_turn_off_red_lights_along_track)) {
    level.delay_turn_off_red_lights_along_track = 0;
  } else {
    level.delay_turn_off_red_lights_along_track = (level.delay_turn_off_red_lights_along_track + 1) % 10;
  }

  var_1 = verifybunkercode("pe_chopper_crate", level.delay_turn_off_red_lights_along_track);

  if(isDefined(var_1)) {
    var_1 = scripts\mp\gametypes\br_lootcache::ref_11a1a(var_1, var_0);
  }

  if(isDefined(var_1) && var_0 scripts\mp\utility\perk::_hasperk("specialty_br_extra_killstreak_chance")) {
    var_1 = scripts\mp\gametypes\br_lootcache::ref_11a1d(var_1, var_0);
  }

  if(isDefined(var_1)) {
    var_2 = scripts\mp\gametypes\br_lootcache::ref_11a02(var_1);
  }

  if(!isDefined(var_0.ref_11a01)) {
    var_0.ref_11a01 = 1;
  } else {
    var_0.ref_11a01++;
  }

  var_0 scripts\mp\utility\stats::setextrascore1(var_0.ref_11a01);
  var_0 thread scripts\mp\utility\points::giveunifiedpoints("br_loot_chopper_box_open");
}

function dangercircletick(var_0, var_1) {
  if(!isDefined(level.delay_turn_on_headlights) || gettime() < level.delay_turn_on_headlights) {
    return;
  }

  var_2 = getdvarfloat("scr_br_pe_choppers_circle_damage_tick", 500);
  var_3 = 240;
  var_4 = level.ref_119e7;

  if(isDefined(var_4)) {
    var_4 = scripts\engine\utility::array_removeundefined(var_4);

    foreach(var_6 in var_4) {
      var_7 = 0;
      var_8 = var_6.origin;
      var_9 = distance2d(var_0, var_8);

      if(var_9 + var_3 > var_1) {
        var_7 = 1;
      }

      if(var_7) {
        var_10 = var_6.health;
        var_11 = var_6.maxhealth;
        var_6 dodamage(var_2, var_8, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      }
    }
  }

  var_13 = getdvarfloat("scr_br_circle_object_cleanup_threshold", 2400);
  var_14 = level.delay_turn_off_tum_display;

  if(isDefined(var_14)) {
    var_14 = scripts\engine\utility::array_removeundefined(var_14);

    foreach(var_16 in var_14) {
      var_17 = distance2dsquared(var_16.origin, var_0);
      var_18 = max(0, var_1 + var_13);

      if(var_17 > var_18 * var_18) {
        var_16 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
      }
    }

    return;
  }
}

function forest_fire_setup(var_0) {
  level endon("game_ended");

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.safecircleent)) {
    return;
  }

  var_1 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_2 = scripts\mp\gametypes\br_circle::getsafecircleradius();
  var_3 = 0.3;
  var_4 = 0.8;
  var_5 = var_2 * var_3;
  var_6 = var_2 * var_4;
  var_7 = play_tape_machine_animation(var_1, var_5, var_6);
  var_8 = var_7[0];
  var_9 = var_7[1];
  var_7 = undefined;

  if(var_8 == var_9) {
    return;
  }

  if(var_8 != 0 || var_9 != 360) {
    var_8 += 20;
    var_9 -= 20;

    if(var_9 <= var_8) {
      return;
    }
  } else {
    var_10 = randomfloatrange(0, 360);
    var_8 += var_10;
    var_9 += var_10;
  }

  var_11 = (var_9 - var_8) / max(1, var_0 - 1);
  level.ref_1229f = [];

  for(var_12 = 0; var_12 < var_0; var_12++) {
    var_13 = var_8 + var_11 * var_12;
    var_14 = anglesToForward((0, var_13, 0));

    if(var_6 > var_5) {
      var_15 = randomfloatrange(var_5, var_6);
    } else {
      var_15 = var_6;
    }

    var_16 = var_1 + var_14 * var_15;

    if(isscriptabledefined()) {
      var_16 = getclosestpointonnavmesh(var_16);
    }

    var_17 = spawnStruct();
    var_17.origin = var_16;
    level.ref_1229f[var_12] = var_17;
  }
}

function play_tape_machine_animation(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = level.mapcenter - var_0;
  var_3 = (var_3[0], var_3[1], 0);
  var_3 = vectorNormalize(var_3);
  var_4 = vectortoyaw(var_3);
  var_5 = var_0 + var_3 * var_1;
  var_6 = var_0 + var_3 * var_2;
  var_7 = !scripts\mp\outofbounds::ispointinoutofbounds(var_5) && !scripts\mp\outofbounds::ispointinoutofbounds(var_6);

  if(!var_7) {
    return [0, 0];
  }

  var_8 = 45;
  var_9 = 45;
  var_10 = var_4;
  var_11 = var_4 + var_8;
  var_12 = var_4;
  var_13 = var_4 - var_9;
  var_14 = 0;
  var_15 = 180 / int(var_8);
  var_16 = 0;
  var_17 = 1;

  for(;;) {
    if(var_8 >= var_17) {
      var_18 = anglesToForward((0, var_11, 0));
      var_19 = var_0 + var_18 * var_1;
      var_20 = var_0 + var_18 * var_2;
      var_21 = !scripts\mp\outofbounds::ispointinoutofbounds(var_19) && !scripts\mp\outofbounds::ispointinoutofbounds(var_20);

      if(var_21) {
        var_10 = var_11;
        var_11 = var_10 + var_8;
      } else {
        var_16 = 1;
        var_8 *= 0.5;
        var_11 = var_10 + var_8;
      }
    }

    if(var_9 >= var_17) {
      var_22 = anglesToForward((0, var_13, 0));
      var_23 = var_0 + var_22 * var_1;
      var_24 = var_0 + var_22 * var_2;
      var_25 = !scripts\mp\outofbounds::ispointinoutofbounds(var_23) && !scripts\mp\outofbounds::ispointinoutofbounds(var_24);

      if(var_25) {
        var_12 = var_13;
        var_13 = var_12 - var_9;
      } else {
        var_16 = 1;
        var_9 *= 0.5;
        var_13 = var_12 - var_9;
      }
    }

    if(!var_16) {
      var_14++;

      if(var_14 >= var_15) {
        return [0, 360];
      }
    }

    if(var_8 < var_17 && var_9 < var_17) {
      return [var_12, var_10];
    }

    waitframe();
  }
}