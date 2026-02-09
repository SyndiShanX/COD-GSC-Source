/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_conflict.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

CONFLICT_KILLSTREAK_WEIGHT = 80;

main() {
  maps\mp\mp_conflict_precache::main();
  maps\createart\mp_conflict_art::main();
  maps\mp\mp_conflict_fx::main();

  level.harrier_smoke = loadfx("fx/fire/jet_afterburner_harrier_damaged");
  level.harrier_deathfx = loadfx("fx/explosions/aerial_explosion_harrier");
  level.harrier_afterburnerfx = loadfx("fx/fire/jet_afterburner_harrier");

  level.mapCustomCrateFunc = ::conflictCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::conflictCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::conflictCustomBotKillstreakFunc;

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_conflict");

  setdvar_cg_ng("r_specularColorScale", 2.5, 9);
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  thread maps\mp\killstreaks\_airstrike::init();

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");
}

conflictCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"]))
    game["player_holding_level_killstrek"] = false;

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "harrier_airstrike", CONFLICT_KILLSTREAK_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"MP_CONFLICT_KILLSTREAKS_HARRIER_PICKUP");
  maps\mp\killstreaks\_airdrop::generateMaxWeightedCrateValue();
  level thread watch_for_conflict_crate();
}

conflictCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Conflict Killstreak\" \"set scr_devgivecarepackage harrier_airstrike; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Conflict Killstreak\" \"set scr_givekillstreak harrier_airstrike\"\n");
  level.killStreakFuncs["harrier_airstrike"] = ::tryUseConflictKillstreak;
}

tryUseConflictKillstreak(lifeId, streakName) {
  return maps\mp\killstreaks\_airstrike::tryUseAirstrike(lifeId, streakName);
}

watch_for_conflict_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "harrier_airstrike") {
      maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "harrier_airstrike", 0);
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "harrier_airstrike", CONFLICT_KILLSTREAK_WEIGHT);
      } else {
        game["player_holding_level_killstrek"] = true;
        break;
      }
    }
  }
}

wait_for_capture(dropCrate) {
  result = watch_for_air_drop_death(dropCrate);
  return !isDefined(result);
}

watch_for_air_drop_death(dropCrate) {
  dropCrate endon("captured");

  dropCrate waittill("death");
  waittillframeend;

  return true;
}

conflictCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Conflict Killstreak\" \"set scr_testclients_givekillstreak harrier_airstrike\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("harrier_airstrike", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}