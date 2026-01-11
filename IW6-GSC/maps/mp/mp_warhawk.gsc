/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_warhawk.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_warhawk_precache::main();
  maps\createart\mp_warhawk_art::main();
  maps\mp\mp_warhawk_fx::main();
  maps\mp\mp_warhawk_events::precache();

  min_wait_time = 50.0;
  max_wait_time = 70.0;
  level thread maps\mp\mp_warhawk_events::random_destruction(min_wait_time, max_wait_time);
  level thread maps\mp\mp_warhawk_events::air_raid();

  level.mapCustomCrateFunc = ::warhawkCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::warhawkCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::warhawkCustomBotKillstreakFunc;

  maps\mp\_load::main();

  thread maps\mp\_fx::func_glass_handler();

  maps\mp\_compass::setupMiniMap("compass_map_mp_warhawk");

  SetDvar("r_lightGridEnableTweaks", 1);
  SetDvar("r_lightGridIntensity", 1.33);
  setdvar_cg_ng("r_diffuseColorScale", 1.2, 1.5);
  setdvar_cg_ng("r_specularcolorscale", 1.5, 9);
  setdvar("r_ssaorejectdepth", 1500);
  setdvar("r_ssaofadedepth", 1200);

  if(level.ps3) {
    setdvar("sm_sunShadowScale", "0.6");
  } else if(level.xenon) {
    setdvar("sm_sunShadowScale", "0.7");
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level thread maps\mp\mp_warhawk_events::plane_crash();
  level thread maps\mp\mp_warhawk_events::heli_anims();
  level thread maps\mp\mp_warhawk_events::chain_gate();
  level thread maps\mp\mp_warhawk_events::exploders_watch_late_players();
  level thread maps\mp\_breach::main();
  level._effect["default"] = loadfx("vfx/moments/mp_warhawk/vfx_mp_warhawk_breach_01");

  SetDvarIfUninitialized("allow_dynamic_events", "1");
  level thread watch_allow_dynamic_events();

  level thread initExtraCollision();
}

initExtraCollision() {
  model1 = spawn("script_model", (-449.855, 640.906, 203.344));
  model1 setModel("afr_corrugated_metal8x8");
  model1.angles = (0, 0, 0);

  model2 = spawn("script_model", (1457, 159.5, 143));
  model2 setModel("afr_corrugated_metal8x8");
  model2.angles = (0, 0, 0);
}

watch_allow_dynamic_events() {
  while(GetDvarInt("allow_dynamic_events")) {
    wait .05;
  }

  level notify("stop_dynamic_events");
}

WARHAWK_MORTARS_WEIGHT = 85;
warhawkCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"])) {
    game["player_holding_level_killstrek"] = false;
  }

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "warhawk_mortars", WARHAWK_MORTARS_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"KILLSTREAKS_HINTS_WARHAWK_MORTARS");
  level thread watch_for_warhawk_mortars_crate();
}

watch_for_warhawk_mortars_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "warhawk_mortars") {
      maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "warhawk_mortars", 0);
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "warhawk_mortars", WARHAWK_MORTARS_WEIGHT);
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

warhawkCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Warhawk Mortars\" \"set scr_devgivecarepackage warhawk_mortars; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Warhawk Mortars\" \"set scr_givekillstreak warhawk_mortars\"\n");

  level.killStreakFuncs["warhawk_mortars"] = ::tryUseWarhawkMortars;

  level.killstreakWeildWeapons["warhawk_mortar_mp"] = "warhawk_mortars";
}

warhawkCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Warhawk Mortars\" \"set scr_testclients_givekillstreak warhawk_mortars\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("warhawk_mortars", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseWarhawkMortars(lifeId, streakName) {
  if(level.air_raid_active) {
    self iPrintLnBold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    return false;
  }

  game["player_holding_level_killstrek"] = false;
  level notify("warhawk_mortar_killstreak", self);

  return true;
}