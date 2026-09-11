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
  var0 = "";
  var1 = undefined;

  for(;;) {
    if(getdvarint("scr_crate_drops_with_timer", 0) != 0) {
      level scripts\engine\utility::ref_143ba(level.crate_drop_time, "start_periodic_drops", "drop_requested");
    } else {
      level waittill("drop_requested", var0, var1);
    }

    if(getdvarint("scr_pause_crate_drops", 0) == 0) {
      var2 = getrandompointincpmap(var0);

      if(!isDefined(var2)) {
        continue;
      }

      if(isDefined(var2.script_linkname)) {
        if(isDefined(level.crates_active_at_location[var2.script_linkname])) {
          continue;
        }
      } else if(isDefined(var2.script_noteworthy)) {
        if(isDefined(level.crates_active_at_location[var2.script_noteworthy])) {
          continue;
        }
      }

      thread dropcarepackage(level, var2);
    }
  }
}

function ref_12c40(var0, var1) {
  level notify("drop_requested", var0, var1);
}

function getrandompointincpmap(var0) {
  if(var0 != "") {
    return scripts\engine\utility::getStructArray(var0, "script_noteworthy")[0];
  }

  var1 = scripts\cp\respawn\cp_ac130_respawn::getaverageorigin(level.players);
  var2 = scripts\engine\utility::getStructArray("crate_spawn", "targetname");
  var3 = scripts\engine\utility::get_array_of_closest(var1, var2, undefined, 1, 6669);

  if(var3.size > 0) {
    return var3[0];
  }

  var3 = var2[0];
  return var3;
}

function dropcarepackage(var0, var1, var2) {
  level endon("game_ended");
  var3 = scripts\engine\utility::drop_to_ground(var0.origin, 50, -200, (0, 0, 1));
  var3 += (0, 0, 1);

  if(!istrue(level.announcer_vo_playing) && !istrue(level.validatealivecount)) {
    thread scripts\cp\cp_dialogue::play_vo_to_all("dx_mpa_rutl_airdrop_friendly_use", 6);
  }

  var4 = mlgiconemptyflag(var3, var2);

  if(isDefined(var1)) {
    var4.ref_129f9 = var1;
  }

  thread oncratedrop(var4, var3);

  if(isDefined(var0.script_linkname)) {
    level.crates_active_at_location[var0.script_linkname] = var4;
  } else if(isDefined(var0.script_noteworthy)) {
    level.crates_active_at_location[var0.script_noteworthy] = var4;
  }

  return var4;
}

function mlgiconemptyflag(var0, var1) {
  var2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "weapon", scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "attachment", "munition"));
  var3 = "operation_crates";

  if(getDvar("scr_override_crates", "") != "") {
    var3 = getDvar("scr_override_crates", "");
  }

  if(isDefined(var1)) {
    var3 = var1;
  }

  var4 = mlghitlocrequiresclamp(undefined, "allies", var3, var0, (0, randomfloat(360), 0), var0, scripts\cp\killstreaks\airdrop_cp::getcpcratedatabytype(var3));

  if(!isDefined(var4)) {
    return undefined;
  } else if(!isDefined(var4.crate)) {
    return undefined;
  }

  return var4.crate;
}

function oncratedrop(var0, var1) {
  self endon("death");
  var2 = spawn("script_model", var1.origin);
  var2 setModel("offhand_wm_grenade_smoke");
  var2.angles = (0, 90, 90);
  var3 = spawn("script_model", var1.origin);
  var3 setModel("ks_crate_marker_mp");
  var3 setscriptablepartstate("smoke", "on", 0);
  thread watchforcratecapture(var2);
  thread watchforcratecapture(var3);
  scripts\cp\cp_hostmigration::waitlongdurationwithhostmigrationpause(90);

  if(isDefined(var1.script_noteworthy)) {
    if(isDefined(level.crates_active_at_location[var1.script_noteworthy])) {
      level.crates_active_at_location[var1.script_noteworthy] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
    }
  }

  if(isDefined(var1.script_linkname)) {
    if(isDefined(level.crates_active_at_location[var1.script_linkname])) {
      level.crates_active_at_location[var1.script_linkname] thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
      return;
    }

    return;
  }
}

function watchforcratecapture(var0) {
  self endon("death");
  var0 waittill("death");
  self delete();
}

function relic_healthpacks_wait_for_pickup(var0, var1) {
  var2 = undefined;

  if(istrue(var1)) {
    var2 = var0 * (1, 1, 0) + (0, 0, relic_landlocked_clear_message_on_player_return());
  } else {
    var2 = var0 + (0, 0, 25);
  }

  return var2;
}

function relic_landlocked_clear_message_on_player_return() {
  return 3000 + level.cratedropdata.helis.size * level.cratedropdata.heliheightoffset;
}

function mlghitlocrequiresclamp(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "currentActiveVehicleCount") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      return undefined;
    }
  }

  var8 = relic_healthpacks_wait_for_pickup(var3, 1);
  var9 = var4 * (0, 1, 0);

  if(!isDefined(var5)) {
    var5 = scripts\cp_mp\killstreaks\airdrop::getcratedropdestination(var8, scripts\cp_mp\killstreaks\airdrop::getcratedropcastend(var8, 1));

    if(!isDefined(var5)) {
      return undefined;
    }
  }

  var10 = spawn("script_model", var8);
  var10.angles = var9;
  var10 setModel("tag_origin");
  var10.owner = var0;
  var10.team = var1;
  var10.hasowner = isDefined(var0);
  var11 = undefined;

  if(isDefined(var6)) {
    var11 = var6.vehicleisreserved;
  }

  var12 = scripts\cp_mp\killstreaks\airdrop::createheli(var0, var1, var8, var9, var11, var7);

  if(!isDefined(var12)) {
    var10 delete();
    return undefined;
  }

  setup_pilot(var12);
  var12.scenenode = var12;
  var12 setscriptablepartstate("visibility", "hide", 0);
  var12.animname = "care_package_heli";
  thread watch_for_death();
  var10.heli = var12;
  var10.heliendtime = gettime() + getanimlength(level.scr_anim["care_package_heli"]["care_package_drop"]) * 1000;
  var10.latestanimendtime = var10.heliendtime;
  var13 = scripts\cp_mp\killstreaks\airdrop::createcrateforscripteddrop(var0, var1, var2, var5, undefined, 0, var6, var7, var10, "care_package", "care_package_drop");

  if(!isDefined(var13)) {
    return undefined;
  }

  var14 = scripts\cp_mp\killstreaks\airdrop::createchuteforscripteddrop(var10, var13, "care_package_chute", "care_package_drop");

  if(!isDefined(var14)) {
    return undefined;
  }

  var14 setscriptablepartstate("visibility", "hide", 0);
  var10 thread scripts\cp_mp\killstreaks\airdrop::watchdropcratefromscriptedheli();
  var10.crate = var13;
  return var10;
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
  var0 = "tag_pilot";

  if(!self tagexists(var0) && self tagexists("tag_pilot1")) {
    var0 = "tag_pilot1";
  }

  if(!self tagexists(var0)) {
    return;
  }

  var1 = (0, 0, -20);
  var2 = (0, 0, 0);
  var3 = spawn("script_model", self gettagorigin(var0));
  var3 setModel("aq_pilot_fullbody_1");
  var3 linkTo(self, var0, var1, var2);
  var3 scriptmodelplayanim("vh_blima_rappel_pilot");
  self.pilot = var3;
}