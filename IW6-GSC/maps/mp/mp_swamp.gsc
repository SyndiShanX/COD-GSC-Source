/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_swamp.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

SWAMP_SLASHER_HEAL_AMOUNT = 2;
SWAMP_SLASHER_WEAPON = "iw6_axe_mp";

main() {
  maps\mp\mp_swamp_precache::main();
  maps\createart\mp_swamp_art::main();
  maps\mp\mp_swamp_fx::main();

  level._effect["swamp_slasher_victim"] = LoadFX("vfx/moments/mp_swamp/vfx_spirit_victim");
  level._effect["swamp_slasher_death"] = LoadFX("vfx/moments/mp_swamp/vfx_spirit_victim_killstreak");
  level._effect["vfx_flesh_hit_body_fatal_hatchet"] = loadfx("vfx/gameplay/impacts/flesh/vfx_flesh_hit_body_fatal_hatchet");

  maps\mp\_load::main();

  level.mapCustomCrateFunc = ::swampCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::swampCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::swampCustomBotKillstreakFunc;

  maps\mp\killstreaks\_juggernaut::initLevelCustomJuggernaut(::swampSlasherCreateFunc, ::setJuggSwampSlasherClass, ::setJuggSwampSlasher, "callout_killed_swamp_slasher");

  setdvar_cg_ng("r_specularColorScale", 2.5, 7);

  maps\mp\_compass::setupMiniMap("compass_map_mp_swamp");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  SetDvar("r_tessellationCutoffFalloffBase", 600);
  SetDvar("r_tessellationCutoffDistanceBase", 1600);
  SetDvar("r_tessellationCutoffFalloff", 600);
  SetDvar("r_tessellationCutoffDistance", 1600);
  SetDvar("r_reactiveMotionWindFrequencyScale", 0.1);
  SetDvar("r_reactiveMotionWindAmplitudeScale", 0.5);
  setdvar_cg_ng("sm_sunShadowScale", 0.25, 1);
  setdvar_cg_ng("fx_alphaThreshold", 5, 0);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  level thread maps\mp\_breach::main();
  vfxSetupFrogFx();
  thread vfxBatCaveWaitInit("triggerBatCave");

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");

  maps\mp\bots\_bots_ks::blockKillstreakForBots("vanguard");
}

swampSlasherCreateFunc(juggType) {
  AssertEx(juggType == "juggernaut_swamp_slasher");

  self.isJuggernautLevelCustom = true;

  self.juggMoveSpeedScaler = 1.05;
  self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], juggType, false);
  self givePerk("specialty_blindeye", false);
  self givePerk("specialty_coldblooded", false);
  self givePerk("specialty_noscopeoutline", false);
  self givePerk("specialty_detectexplosive", false);
  self givePerk("specialty_marathon", false);
  self givePerk("specialty_falldamage", false);

  self.moveSpeedScaler = 1.15;

  self swampSlasherBeginMusic();
  self thread onJuggSwampSlasherEnemyKilled();
  self thread onJuggSwampSlasherDeath();

  self thread teamPlayerCardSplash("used_juggernaut_swamp_slasher", self);
  self thread swampSlasherSounds();

  self.canUseKillstreakCallback = ::juggSwampSlasherCanUseKillstreak;
  self.killstreakErrorMsg = ::juggSwampSlasherKillsteakErrorMsg;

  return false;
}

juggSwampSlasherCanUseKillstreak(streakName) {
  if(streakName == "heli_sniper" || self isRideKillstreak(streakname))
    return false;

  return true;
}

juggSwampSlasherKillsteakErrorMsg() {
  self IPrintLnBold(&"MP_SWAMP_NO_KILLSTREAKS");
}

setJuggSwampSlasherClass(class) {
  loadout = [];
  loadout["loadoutPrimary"] = "iw6_axe";
  loadout["loadoutPrimaryBuff"] = "specialty_null";
  loadout["loadoutSecondaryBuff"] = "specialty_null";
  loadout["loadoutEquipment"] = "specialty_null";

  return loadout;
}

setJuggSwampSlasher() {
  if(isDefined(self.headModel)) {
    self Detach(self.headModel, "");
    self.headModel = undefined;
  }
  self setModel("mp_fullbody_mp_mmyers_a");
  self SetViewModel("viewhands_mp_mmyers");
  self SetClothType("nylon");
}

tryUseJuggernautSwampSlasher(lifeId, streakName) {
  maps\mp\killstreaks\_juggernaut::giveJuggernaut(streakName);
  game["player_holding_level_killstrek"] = false;
  return true;
}

SWAMP_SLASHER_WEIGHT = 85;
enable_level_killstreak() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "juggernaut_swamp_slasher", SWAMP_SLASHER_WEIGHT);
}

disable_level_killstreak() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "juggernaut_swamp_slasher", 0);
}

swampCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"]))
    game["player_holding_level_killstrek"] = false;

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "juggernaut_swamp_slasher", SWAMP_SLASHER_WEIGHT, maps\mp\killstreaks\_airdrop::juggernautCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_juggernaut_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_juggernaut_crate_model(), &
    "MP_SWAMP_JUGGERNAUT_SWAMP_SLASHER_PICKUP");
  level thread watch_for_swamp_slasher_crate();
}

watch_for_swamp_slasher_crate() {
  while(true) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "juggernaut_swamp_slasher") {
      disable_level_killstreak();
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        enable_level_killstreak();
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

swampCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Swamp Slasher\" \"set scr_devgivecarepackage juggernaut_swamp_slasher; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Swamp Slasher\" \"set scr_givekillstreak juggernaut_swamp_slasher\"\n");

  level.killStreakFuncs["juggernaut_swamp_slasher"] = ::tryUseJuggernautSwampSlasher;
}

swampCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Swamp Slasher\" \"set scr_testclients_givekillstreak juggernaut_swamp_slasher\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("juggernaut_swamp_slasher", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

swampSlasherSounds() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("jugg_removed");

  while(true) {
    wait(3.0);

    playPlayerAndNpcSounds(self, "axeman_breathing_player", "axeman_breathing_sound");
  }
}

onJuggSwampSlasherEnemyKilled() {
  self endon("death");

  while(true) {
    self waittill("killed_enemy", victim, sWeapon);

    if(sWeapon == SWAMP_SLASHER_WEAPON) {
      self.health = int(min(self.health + SWAMP_SLASHER_HEAL_AMOUNT, 100));

      self thread swampSlasherKillEffect(victim);
    }
  }
}

swampSlasherKillEffect(victim) {
  pos = victim.origin + (0, 0, 50);

  attackDir = self.origin - victim.origin;
  hitPos = victim GetTagOrigin("j_neck");

  playFX(level._effect["vfx_flesh_hit_body_fatal_hatchet"], hitPos, VectorNormalize(attackDir), AnglesToUp(victim GetTagAngles("j_neck")));
  victim playSound("scn_axe_kill_npc");

  wait(0.05);

  playFX(level._effect["swamp_slasher_victim"], pos);
}

onJuggSwampSlasherDeath() {
  level endon("game_ended");

  self thread swampSlasherMusicEndOfLevel();

  self waittill_any("death", "disconnect");

  if(isDefined(self)) {
    playFX(level._effect["swamp_slasher_death"], self.origin + (0, 0, 50));
    self playSound("scn_axe_kill_plr");
  }

  thread swampSlasherEndMusic();

  self.canUseKillstreakCallback = undefined;
  self.killstreakErrorMsg = undefined;
}

swampSlasherMusicEndOfLevel() {
  self endon("death");
  self endon("disconnect");

  level waittill("game_ended");

  thread swampSlasherEndMusic();
}

CONST_SWAMP_SLASHER_MUSIC_START = "mus_mp_swamp_killstreak_start";
CONST_SWAMP_SLASHER_MUSIC_END = "mus_mp_swamp_killstreak_end";
swampSlasherBeginMusic() {
  maps\mp\gametypes\_music_and_dialog::disableMusic();

  level.SlasherMusicEnt = spawn("script_origin", (0, 0, 0));

  level.SlasherMusicEnt playLoopSound(CONST_SWAMP_SLASHER_MUSIC_START);
}

swampSlasherEndMusic() {
  level.SlasherMusicEnt StopLoopSound();

  playSoundOnPlayers(CONST_SWAMP_SLASHER_MUSIC_END);

  thread maps\mp\gametypes\_music_and_dialog::enableMusic();

  waitframe();
  level.SlasherMusicEnt Delete();
  level.SlasherMusicEnt = undefined;
}

VFX_FROG_LEAP = "vfx_frog_jump_inwater_r";
VFX_FROG_TRIGGER_RADIUS = 400;
VFX_FROG_TRIGGER_HEIGHT = 128;
VFX_FROG_COOLDOWN = 30;
vfxCreateFrogTrigger(fxpos, angle, trigPos, trigRadius) {
  fxEnt = SpawnFx(getfx(VFX_FROG_LEAP), fxpos, anglesToForward(angle), AnglesToUp(angle));
  fxEnt.trigger = spawn("trigger_radius", trigPos, 0, trigRadius, VFX_FROG_TRIGGER_HEIGHT);
  fxEnt.radius = trigRadius;

  fxEnt thread vfxRunFrogTrigger();
}

vfxRunFrogTrigger() {
  level endon("game_ended");

  while(true) {
    self thread vfxDebugFrog(VFX_FROG_TRIGGER_HEIGHT, self.radius, (0, 1, 0));

    self.trigger waittill("trigger", player);

    self thread vfxDebugFrog(VFX_FROG_TRIGGER_HEIGHT, self.radius, (1, 0, 0));

    TriggerFX(self);

    wait(VFX_FROG_COOLDOWN);
  }
}

vfxSetupFrogFx() {
  SetDvarIfUninitialized("swamp_draw_frog_trigger", 0);

  vfxCreateFrogTrigger((543.607, -1866.1, 16.9588), (273, 270.011, 33.961), (543.607, -1866.1, 16.9588), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((-137.91, -1403.79, 17.1477), (273, 270, 163.983), (-137.91, -1403.79, 17.1477), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((-753.322, 385.262, 2.15145), (273, 270.009, 95.9661), (-753.322, 385.262, 2.15145), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((-928.21, 619.578, 1.96266), (273, 270.002, 116.968), (-928.21, 619.578, 1.96266), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((-1138.44, 365.926, 1.51848), (274, 269.744, -90.7688), (-1138.44, 365.926, 1.51848), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((-941.947, -27.4375, 7.81633), (273, 270.004, 43.9734), (-941.947, -27.4375, 7.81633), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((-1092.89, -419.291, 6.29806), (273, 270.003, 82.9732), (-1092.89, -419.291, 6.29806), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((-758.194, -1355.44, 61.8263), (273, 270, 176.977), (-758.194, -1355.44, 61.8263), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((-198.275, -1725.05, 19.3899), (273, 270, 100.969), (-198.275, -1725.05, 19.3899), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((721.78, -1614.7, 18.9652), (273.486, 235.078, 120.847), (721.78, -1614.7, 18.9652), VFX_FROG_TRIGGER_RADIUS);
  vfxCreateFrogTrigger((494.378, -1182.59, 2.01686), (273, 270.003, 0.0), (494.378, -1182.59, 2.01686), VFX_FROG_TRIGGER_RADIUS);
}

VFX_BAT_EXPLODER_ID = 55;
VFX_BAT_COOLDOWN = 60;

vfxBatCaveWaitInit(triggername) {
  level endon("game_ended");

  trigger = GetEnt(triggername, "targetname");
  if(isDefined(trigger)) {
    trigger childthread vfxBatCaveTrigger();

    while(true) {
      trigger waittill("trigger", player);

      trigger thread vfxBatCaveWatchPlayerState(player);
    }
  }
}

vfxBatCaveWatchPlayerState(player) {
  self endon("batCaveTrigger");

  player endon("death");
  player endon("disconnect");

  player notify("batCaveExit");
  player endon("batCaveExit");

  self childthread vfxBatCaveWatchPlayerWeapons(player);

  while(player IsTouching(self)) {
    waitframe();
  }

  player notify("batCaveExit");
}

vfxBatCaveWatchPlayerWeapons(player) {
  player endon("batCaveExit");

  player waittill("weapon_fired");

  self notify("batCaveTrigger");
}

vfxBatCaveTrigger() {
  SetDvarIfUninitialized("scr_dbg_batcave_cooldown", VFX_BAT_COOLDOWN);

  while(true) {
    self waittill("batCaveTrigger");

    exploder(VFX_BAT_EXPLODER_ID);

    waitTime = VFX_BAT_COOLDOWN;

    waitTime = GetDvarInt("scr_dbg_batcave_cooldown");

    wait(waitTime);
  }
}

vfxDebugFrog(height, radius, color) {
  self notify("update_debug_draw_trigger");
  self endon("update_debug_draw_trigger");

  while(true) {
    if(GetDvarInt("swamp_draw_frog_trigger") != 0) {
      Cylinder(self.trigger.origin, self.trigger.origin + (0, 0, height), radius, color, false);
      Sphere(self.origin, 10, color, true);
    }

    wait(0.05);
  }
}
# /