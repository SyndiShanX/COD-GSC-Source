/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\crate_drops\cp_crate_drops.gsc
*****************************************************/

function main() {
  if(!scripts\engine\utility::flag_exist("cp_crate_drops_cs_completed")) {
    scripts\engine\utility::flag_init("cp_crate_drops_cs_completed");
  }

  scripts\engine\utility::flag_wait("cp_crate_drops_cs_completed");
  thread start_crate_drops();
}

function start_crate_drops() {
  level.crate_drop_time = 15;
  level.crates_active_at_location = [];
  var_0 = "";
  var_1 = undefined;

  for(;;) {
    if(getdvarint("scr_crate_drops_with_timer", 0) != 0) {
      level scripts\engine\utility::ref_143BA(level.crate_drop_time, "start_periodic_drops", "drop_requested");
    } else {
      level waittill("drop_requested", var_0, var_1);
    }

    if(getdvarint("scr_pause_crate_drops", 0) == 0) {
      var_2 = getrandompointincpmap(var_0);

      if(!isDefined(var_2)) {
        continue;
      }

      if(isDefined(var_2.script_linkname)) {
        if(isDefined(level.crates_active_at_location[var_2.script_linkname])) {
          continue;
        }
      } else if(isDefined(var_2.script_noteworthy)) {
        if(isDefined(level.crates_active_at_location[var_2.script_noteworthy])) {
          continue;
        }
      }

      thread dropcarepackage(level, var_2);
    }
  }
}

function ref_12C40(var_0, var_1) {
  level notify("drop_requested", var_0, var_1);
}

function getrandompointincpmap(var_0) {
  if(var_0 != "") {
    return scripts\engine\utility::getStructArray(var_0, "script_noteworthy")[0];
  }

  var_1 = scripts\cp\respawn\cp_ac130_respawn::getaverageorigin(level.players);
  var_2 = scripts\engine\utility::getStructArray("crate_spawn", "targetname");
  var_3 = scripts\engine\utility::get_array_of_closest(var_1, var_2, undefined, 1, 6669);

  if(var_3.size > 0) {
    return var_3[0];
  }

  var_3 = var_2[0];
  return var_3;
}

function dropcarepackage(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = scripts\engine\utility::drop_to_ground(var_0.origin, 50, -200, (0, 0, 1));
  var_3 += (0, 0, 1);

  if(!istrue(level.announcer_vo_playing) && !istrue(level.validatealivecount)) {
    thread scripts\cp\cp_dialogue::play_vo_to_all("dx_mpa_rutl_airdrop_friendly_use", 6);
  }

  var_4 = mlgiconemptyflag(var_3, var_2);

  if(isDefined(var_1)) {
    var_4.ref_129F9 = var_1;
  }

  thread oncratedrop(var_4, var_3);

  if(isDefined(var_0.script_linkname)) {
    level.crates_active_at_location[var_0.script_linkname] = var_4;
  } else if(isDefined(var_0.script_noteworthy)) {
    level.crates_active_at_location[var_0.script_noteworthy] = var_4;
  }

  return var_4;
}

function mlgiconemptyflag(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "attachment", "munition"));
  var_3 = "operation_crates";

  if(getDvar("scr_override_crates", "") != "") {
    var_3 = getDvar("scr_override_crates", "");
  }

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_4 = mlghitlocrequiresclamp(undefined, "allies", var_3, var_0, (0, randomfloat(360), 0), var_0, scripts\cp\killstreaks\airdrop_cp::getcpcratedatabytype(var_3));

  if(!isDefined(var_4)) {
    return undefined;
  } else if(!isDefined(var_4.crate)) {
    return undefined;
  }

  return var_4.crate;
}

function oncratedrop(var_0, var_1) {
  self endon("death");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("offhand_wm_grenade_smoke");
  var_2.angles = (0, 90, 90);
  var_3 = spawn("script_model", var_1.origin);
  var_3 setModel("ks_crate_marker_mp");
  var_3 setscriptablepartstate("smoke", "on", 0);
  thread watchforcratecapture(var_2);
  thread watchforcratecapture(var_3);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(90);

  if(isDefined(var_1.script_noteworthy)) {
    if(isDefined(level.crates_active_at_location[var_1.script_noteworthy])) {
      level.crates_active_at_location[var_1.script_noteworthy] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
  }

  if(isDefined(var_1.script_linkname)) {
    if(isDefined(level.crates_active_at_location[var_1.script_linkname])) {
      level.crates_active_at_location[var_1.script_linkname] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
      return;
    }

    return;
  }
}

function watchforcratecapture(var_0) {
  self endon("death");
  var_0 waittill("death");
  self delete();
}

function relic_healthpacks_wait_for_pickup(var_0, var_1) {
  var_2 = undefined;

  if(istrue(var_1)) {
    var_2 = var_0 * (1, 1, 0) + (0, 0, relic_landlocked_clear_message_on_player_return());
  } else {
    var_2 = var_0 + (0, 0, 25);
  }

  return var_2;
}

function relic_landlocked_clear_message_on_player_return() {
  return 3000 + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

function mlghitlocrequiresclamp(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      return undefined;
    }
  }

  var_8 = relic_healthpacks_wait_for_pickup(var_3, 1);
  var_9 = var_4 * (0, 1, 0);

  if(!isDefined(var_5)) {
    var_5 = scripts\cp_mp\killstreaks\airdrop::getcratedropdestination(var_8, scripts\cp_mp\killstreaks\airdrop::getcratedropcastend(var_8, 1));

    if(!isDefined(var_5)) {
      return undefined;
    }
  }

  var_10 = spawn("script_model", var_8);
  var_10.angles = var_9;
  var_10 setModel("tag_origin");
  var_10.owner = var_0;
  var_10.team = var_1;
  var_10.hasowner = isDefined(var_0);
  var_11 = undefined;

  if(isDefined(var_6)) {
    var_11 = var_6.vehicleisreserved;
  }

  var_12 = scripts\cp_mp\killstreaks\airdrop::createheli(var_0, var_1, var_8, var_9, var_11, var_7);

  if(!isDefined(var_12)) {
    var_10 delete();
    return undefined;
  }

  setup_pilot(var_12);
  var_12.scenenode = var_12;
  var_12 setscriptablepartstate("visibility", "hide", 0);
  var_12.animname = "care_package_heli";
  thread watch_for_death();
  var_10.heli = var_12;
  var_10.heliendtime = gettime() + getanimlength(level.scr_anim["care_package_heli"]["care_package_drop"]) * 1000;
  var_10.latestanimendtime = var_10.heliendtime;
  var_13 = scripts\cp_mp\killstreaks\airdrop::createcrateforscripteddrop(var_0, var_1, var_2, var_5, undefined, 0, var_6, var_7, var_10, "care_package", "care_package_drop");

  if(!isDefined(var_13)) {
    return undefined;
  }

  var_14 = scripts\cp_mp\killstreaks\airdrop::createchuteforscripteddrop(var_10, var_13, "care_package_chute", "care_package_drop");

  if(!isDefined(var_14)) {
    return undefined;
  }

  var_14 setscriptablepartstate("visibility", "hide", 0);
  var_10 thread scripts\cp_mp\killstreaks\airdrop::watchdropcratefromscriptedheli();
  var_10.crate = var_13;
  return var_10;
}

function watch_for_death() {
  self waittill("death");

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  if(isDefined(self.copilot)) {
    self.copilot delete();
    return;
  }
}

function setup_pilot() {
  var_0 = "tag_pilot";

  if(!self tagexists(var_0) && self tagexists("tag_pilot1")) {
    var_0 = "tag_pilot1";
  }

  if(!self tagexists(var_0)) {
    return;
  }

  var_1 = (0, 0, -20);
  var_2 = (0, 0, 0);
  var_3 = spawn("script_model", self gettagorigin(var_0));
  var_3 setModel("aq_pilot_fullbody_1");
  var_3 linkTo(self, var_0, var_1, var_2);
  var_3 scriptmodelplayanim("vh_blima_rappel_pilot");
  self.pilot = var_3;
}