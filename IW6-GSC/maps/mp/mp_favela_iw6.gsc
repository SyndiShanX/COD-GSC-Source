/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_favela_iw6.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_favela_iw6_precache::main();
  maps\createart\mp_favela_iw6_art::main();
  maps\mp\mp_favela_iw6_fx::main();

  maps\mp\_load::main();

  level.nukeDeathVisionFunc = ::nukeDeathVision;

  maps\mp\_compass::setupMiniMap("compass_map_mp_favela_iw6");

  setdvar_cg_ng("r_specularColorScale", 2.5, 10);
  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar_cg_ng("sm_sunShadowScale", 0.55, 1);
  setdvar_cg_ng("sm_sunsamplesizenear", 0.20, 0.25);
  setDvar_cg_ng("r_reactiveMotionWindFrequencyScale", 0, 0.1);
  setDvar_cg_ng("r_reactiveMotionWindAmplitudeScale", 0, 0.5);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");
  thread tvs();
  thread nuke_custom_visionset();

  level.mapCustomCrateFunc = ::favelaCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::favelaCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::favelaCustomBotKillstreakFunc;

  thread maps\mp\killstreaks\_ac130::init();

  debugRegisterDvarCallback("scr_dbg_tv", ::debugTVs);
}

FAVELA_KILLSTREAK_WEIGHT = 80;

favelaCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"])) {
    game["player_holding_level_killstrek"] = false;
  }

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "ac130", FAVELA_KILLSTREAK_WEIGHT, maps\mp\killstreaks\_airdrop::killstreakCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"MP_FAVELA_IW6_AC130_PICKUP");
  maps\mp\killstreaks\_airdrop::generateMaxWeightedCrateValue();
  level thread watch_for_favela_crate();
}

favelaCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Favela Killstreak\" \"set scr_devgivecarepackage ac130; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Favela Killstreak\" \"set scr_givekillstreak ac130\"\n");

  level.killStreakFuncs["ac130"] = ::tryUseFavelaKillstreak;

  level.ac130player = level.players[0];
}

favelaCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Favela Killstreak\" \"set scr_testclients_givekillstreak ac130\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("ac130", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

watch_for_favela_crate() {
  while(1) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "ac130") {
      maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "ac130", 0);
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "ac130", FAVELA_KILLSTREAK_WEIGHT);
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

tryUseFavelaKillstreak(lifeId, streakName) {
  return maps\mp\killstreaks\_ac130::tryUseAC130(lifeId, streakName);
}

tvs() {
  foreach(name in ["fav_bar_tv", "fav_bar_tv_large"]) {
    thread tvs_set(name);
  }
}

tvs_set(targetname) {
  /# SetDevDvarIfUninitialized( "tv_debug", 0 );
  num_tv_fx = 4;
  for(i = 1; i <= num_tv_fx; i++) {
    if(!isDefined(level._effect[targetname][i])) {
      error("level._effect[" + targetname + "][" + i + "] not defined.");
    }
    if(!isDefined(level.tv_info.effectLength[targetname][i])) {
      error("level.tv_info.effectLength[" + targetname + "][" + i + "] not defined.");
      level.tv_info.effectLength[targetname][i] = 1;
    }
  }
  if(!isDefined(level.tv_info.destroymodel[targetname])) {
    error("level.tv_info.destroymodel[" + targetname + "] not defined.");
    destroymodel = undefined;
  } else {
    destroymodel = level.tv_info.destroymodel[targetname];
  }

  tvs = getEntArray(targetname, "targetname");
  foreach(tv in tvs) {
    tv setCanDamage(true);
    tv.isHealthy = true;
    tv.destroymodel = destroymodel;

    if(isDefined(tv.script_noteworthy)) {
      tv thread playTVAudio(tv.script_noteworthy);
    }

    tv thread tv_death();
  }
  level.tv_fx_num = num_tv_fx;
  while(true) {
    prev_fx = level.tv_fx_num;
    level.tv_fx_num = RandomIntRange(1, num_tv_fx);
    if(level.tv_fx_num >= prev_fx) {
      level.tv_fx_num += 1;
    }
    fx = level._effect[targetname][level.tv_fx_num];
    foreach(tv in tvs) {
      if(tv.isHealthy) {
        playFXOnTag(fx, tv, "tag_fx");
        tv.currentFX = fx;
      }
    }
    wait level.tv_info.effectLength[targetname][level.tv_fx_num];

    /#tvs_remaining = false;
    foreach(tv in tvs) {
      if(tv.isHealthy == true) tvs_remaining = true;
    }
    if(GetDvarInt("tv_debug")) {
      if(!tvs_remaining) {
        wait 1;
        thread tvs();
        return;
      }
    }

  }
}

playTVAudio(tvSize) {
  isLarge = IsSubStr(tvSize, "large");

  delay = 15;

  wait(delay);

  if(isLarge) {
    self playLoopSound("mp_favela_vo_tv_big");
  } else {
    self playLoopSound("mp_favela_vo_tv");
  }
}

tv_death() {
  self endon("death");
  self.health = 10000;
  self waittill("damage");

  KillFXOnTag(self.currentFX, self, "tag_fx");
  self StopLoopSound();

  self setModel(self.destroymodel);
  playFXOnTag(level._effect["tv_explode"], self, "tag_fx");
  playSoundAtPos(self.origin, "tv_shot_burst");

  self.isHealthy = false;
  self setCanDamage(false);
}

setupFireHydrants() {
  hydrants = getEntArray("water", "targetname");

  foreach(trigger in hydrants) {
    trigger thread hydrantWaitForDeath();
  }
}

hydrantWaitForDeath() {
  level endon("game_ended");

  hydrant = GetEnt(self.target, "targetname");

  hydrant.trigger = self;

  self Hide();

  while(true) {
    hydrant waittill("state_changed", initialRootStateIndex, finalRootStateIndex, finalStateName, attacker, meansOfDeath, weapon);

    if(finalRootStateIndex == 2) {
      break;
    }
  }

  self Show();

  hydrant thread watersheet_trig_setup(self);
  hydrant thread hydrantTimer();
}

watersheet_trig_setup(trig) {
  level endon("game_ended");
  self endon("hydrant_end");

  while(true) {
    trig waittill("trigger", player);

    if(IsPlayer(player) && !IsAI(player) && !(isDefined(player.inWater) && player.inWater)) {
      player thread playerTrackWaterSheet(trig);
    }
  }
}

playerTrackWaterSheet(waterTrig) {
  self endon("disconnect");

  self.inWater = true;

  self SetWaterSheeting(1);

  while(isReallyAlive(self) && isDefined(waterTrig) && self IsTouching(waterTrig) && !level.gameEnded) {
    wait(0.5);
  }

  self SetWaterSheeting(0);

  self.inWater = false;
}

hydrantTimer() {
  self waittill("death");

  self notify("hydrant_end");

  self.trigger Delete();
}

nuke_custom_visionset() {
  level waittill("nuke_death");

  wait 1.3;

  level notify("nuke_death");
  thread nuke_custom_visionset();
}

nukeDeathVision() {
  level.nukeVisionSet = "aftermath_mp_favela";
  setExpFog(512, 2048, 0.578828, 0.802656, 1, 0.5, 0.75, 5, 0.382813, 0.350569, 0.293091, .5, (1, -0.109979, 0.267867), 0, 80, 1, 0.179688, 26, 180);
  VisionSetNaked(level.nukeVisionSet, 5);
  VisionSetPain(level.nukeVisionSet);
}

debugWatchDvars() {
  level endon("game_ended");

  level.dbgDvarNotify = [];
  level.dbgDvarCallback = [];

  while(true) {
    foreach(dvar, event in level.dbgDvarNotify) {
      if(GetDvarInt(dvar) > 0) {
        level notify(event);
        SetDvar(dvar, 0);
      }
    }

    foreach(dvar, callback in level.dbgDvarCallback) {
      value = GetDvar(dvar);
      if(value != "") {
        [
          [callback]
        ](value);
        SetDvar(dvar, "");
      }
    }

    wait(0.1);
  }
}

debugRegisterDvarNotify(dvar, eventName) {
  if(!isDefined(level.dbgDvarUpdate)) {
    level.dbgDvarUpdate = true;

    level thread debugWatchDvars();
  }

  SetDvarIfUninitialized(dvar, 0);
  level.dbgDvarNotify[dvar] = eventName;
}

debugRegisterDvarCallback(dvar, callback) {
  if(!isDefined(level.dbgDvarUpdate)) {
    level.dbgDvarUpdate = true;

    level thread debugWatchDvars();
  }

  SetDvarIfUninitialized(dvar, "");
  level.dbgDvarCallback[dvar] = callback;
}

debugTVs(index) {
  names = ["fav_bar_tv", "fav_bar_tv_large"];

  thread tvs_set(names[Int(index)]);
}
# /