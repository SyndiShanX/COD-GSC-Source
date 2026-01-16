/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_smokegrenade.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_airsupport;

init() {
  level.willyPeteDamageRadius = 300;
  level.willyPeteDamageHeight = 128;
  level.sound_smoke_start = "wpn_smoke_hiss_start";
  level.sound_smoke_loop = "wpn_smoke_hiss_lp";
  level.sound_smoke_stop = "wpn_smoke_hiss_end";
  level.smokeSoundDuration = 8;
  level.fx_smokegrenade_single = "smoke_center_mp";
  PreCacheItem(level.fx_smokegrenade_single);
}
watchSmokeGrenadeDetonation(owner) {
  self waittill("explode", position, surface);
  if(!isDefined(level.water_duds) || level.water_duds == true) {
    if(isDefined(surface) && surface == "water") {
      return;
    }
  }
  oneFoot = (0, 0, 12);
  startPos = position + oneFoot;
  SpawnTimedFX(level.fx_smokegrenade_single, position);
  thread playSmokeSound(position, level.smokeSoundDuration, level.sound_smoke_start, level.sound_smoke_stop, level.sound_smoke_loop);
  owner maps\mp\gametypes\_globallogic_score::setWeaponStat("willy_pete_mp", 1, "used");
  damageEffectArea(owner, startPos, level.willyPeteDamageRadius, level.willyPeteDamageHeight, undefined);
}
damageEffectArea(owner, position, radius, height, killCamEnt) {
  effectArea = spawn("trigger_radius", position, 0, radius, height);
  owner thread maps\mp\_dogs::flash_dogs(effectArea);
  effectArea delete();
}

