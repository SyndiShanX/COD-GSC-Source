/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\batcave.gsc
***********************************************/

#include common_scripts\utility;

VFX_BAT_COOLDOWN = 60;

vfxBatCaveWaitInit(triggername, exploderID, audioAnim, pos, emptyRoomCooldown) {
  if(!isDefined(emptyRoomCooldown))
    emptyRoomCooldown = 0;

  level endon("game_ended");

  trigger = GetEnt(triggername, "targetname");
  if(isDefined(trigger)) {
    trigger childthread vfxBatCaveTrigger(exploderID, audioAnim, pos);
    trigger childthread vfxBatCaveWatchForEmpty(emptyRoomCoolDown);

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
    self.lastTouchedTime = GetTime();
  }

  player notify("batCaveExit");
}

vfxBatCaveWatchPlayerWeapons(player) {
  player waittill("weapon_fired");
  self notify("batCaveTrigger");
}

vfxBatCaveWatchForEmpty(emptyRoomCoolDown) {
  self.lastTouchedTime = GetTime();
  self.batCaveReset = true;
  while(true) {
    waitframe();
    if(self.lastTouchedTime + emptyRoomCoolDown <= GetTime()) {
      self.batCaveReset = true;
    }
  }
}

vfxBatCaveTrigger(exploderID, audioAnim, pos) {
  SetDvarIfUninitialized("scr_dbg_batcave_cooldown", VFX_BAT_COOLDOWN);

  while(true) {
    self waittill("batCaveTrigger");

    if(self.batCaveReset) {
      vfxBatsFly(exploderID, audioAnim, pos);
      self.batCaveReset = false;

      waitTime = VFX_BAT_COOLDOWN;

      waitTime = GetDvarInt("scr_dbg_batcave_cooldown");

      wait(waitTime);
    }
  }
}

vfxBatsFly(exploderID, audioAnim, pos) {
  exploder(exploderID);

  if(isDefined(audioAnim) && isDefined(pos)) {
    soundrig = spawn("script_model", pos);
    soundrig setModel("vulture_circle_rig");
    soundrig ScriptModelPlayAnim(audioAnim);
    dummy = spawn("script_model", soundrig GetTagOrigin("tag_attach"));
    dummy LinkTo(soundrig, "tag_attach");
    wait(0.1);
    dummy PlaySoundOnMovingEnt("scn_mp_swamp_bat_cave_big");
  }
}