/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_burnplayer.gsc
**************************************/

#include common_scripts\utility;
#include maps\mp\_utility;

initBurnPlayer() {
  level._effect["character_fire_death_torso"] = loadfx("env/fire/fx_fire_player_torso_mp");
  level._effect["character_fire_player_sm"] = loadfx("env/fire/fx_fire_player_sm_mp");
  level._effect["character_fire_death_sm"] = loadfx("env/fire/fx_fire_player_md_mp");
  level._effect["fx_fire_player_sm_smk_2sec"] = loadfx("env/fire/fx_fire_player_sm_smk_2sec");
  level.flameDamage = 15;
  level.flameBurnTime = 1.5;
}
hitWithIncendiary(attacker, inflictor, mod) {
  if(isDefined(self.burning))
    return;
  self startTanning();
  self thread waitThenStopTanning(level.flameBurnTime);
  self endon("disconnect");
  attacker endon("disconnect");
  waittillframeend;
  self.burning = true;
  self thread burn_blocker();
  tagArray = [];
  if(isai(self)) {
    tagArray[tagArray.size] = "J_Wrist_RI";
    tagArray[tagArray.size] = "J_Wrist_LE";
    tagArray[tagArray.size] = "J_Elbow_LE";
    tagArray[tagArray.size] = "J_Elbow_RI";
    tagArray[tagArray.size] = "J_Knee_RI";
    tagArray[tagArray.size] = "J_Knee_LE";
    tagArray[tagArray.size] = "J_Ankle_RI";
    tagArray[tagArray.size] = "J_Ankle_LE";
  } else {
    tagArray[tagArray.size] = "J_Wrist_RI";
    tagArray[tagArray.size] = "J_Wrist_LE";
    tagArray[tagArray.size] = "J_Elbow_LE";
    tagArray[tagArray.size] = "J_Elbow_RI";
    tagArray[tagArray.size] = "J_Knee_RI";
    tagArray[tagArray.size] = "J_Knee_LE";
    tagArray[tagArray.size] = "J_Ankle_RI";
    tagArray[tagArray.size] = "J_Ankle_LE";
    if(isplayer(self) && self.health > 0)
      self setburn(3.0);
  }
  if(isDefined(level._effect["character_fire_death_torso"])) {
    for(arrayIndex = 0; arrayIndex < tagArray.size; arrayIndex++) {
      playFXOnTag(level._effect["character_fire_death_sm"], self, tagArray[arrayIndex]);
    }
  }
  if(isai(self))
    playFXOnTag(level._effect["character_fire_death_torso"], self, "J_Spine1");
  else
    playFXOnTag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
  if(!isalive(self))
    return;
  if(isplayer(self)) {
    self thread watchForWater(7);
    self thread watchForDeath();
  }
}
hitWithNapalmStrike(attacker, inflictor, mod) {
  if(isDefined(self.burning) || self hasperk("specialty_fireproof"))
    return;
  self startTanning();
  self thread waitThenStopTanning(level.flameBurnTime);
  self endon("disconnect");
  attacker endon("disconnect");
  self endon("death");
  if(isDefined(self.burning))
    return;
  self thread burn_blocker();
  waittillframeend;
  self.burning = true;
  self thread burn_blocker();
  tagArray = [];
  if(isai(self)) {
    tagArray[tagArray.size] = "J_Wrist_RI";
    tagArray[tagArray.size] = "J_Wrist_LE";
    tagArray[tagArray.size] = "J_Elbow_LE";
    tagArray[tagArray.size] = "J_Elbow_RI";
    tagArray[tagArray.size] = "J_Knee_RI";
    tagArray[tagArray.size] = "J_Knee_LE";
    tagArray[tagArray.size] = "J_Ankle_RI";
    tagArray[tagArray.size] = "J_Ankle_LE";
  } else {
    tagArray[tagArray.size] = "J_Wrist_RI";
    tagArray[tagArray.size] = "J_Wrist_LE";
    tagArray[tagArray.size] = "J_Elbow_LE";
    tagArray[tagArray.size] = "J_Elbow_RI";
    tagArray[tagArray.size] = "J_Knee_RI";
    tagArray[tagArray.size] = "J_Knee_LE";
    tagArray[tagArray.size] = "J_Ankle_RI";
    tagArray[tagArray.size] = "J_Ankle_LE";
    if(isplayer(self))
      self setburn(3.0);
  }
  if(isDefined(level._effect["character_fire_death_sm"])) {
    for(arrayIndex = 0; arrayIndex < tagArray.size; arrayIndex++) {
      playFXOnTag(level._effect["character_fire_death_sm"], self, tagArray[arrayIndex]);
    }
  }
  if(isDefined(level._effect["character_fire_death_torso"])) {
    playFXOnTag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
  }
  if(!isalive(self))
    return;
  self thread doNapalmStrikeDamage(attacker, inflictor, mod);
  if(isplayer(self)) {
    self thread watchForWater(7);
    self thread watchForDeath();
  }
}
walkedThroughFlames(attacker, inflictor, weapon) {
  if(isDefined(self.burning) || self hasperk("specialty_fireproof"))
    return;
  self startTanning();
  self thread waitThenStopTanning(level.flameBurnTime);
  self endon("disconnect");
  waittillframeend;
  self.burning = true;
  self thread burn_blocker();
  tagArray = [];
  if(isai(self)) {
    tagArray[tagArray.size] = "J_Wrist_RI";
    tagArray[tagArray.size] = "J_Wrist_LE";
    tagArray[tagArray.size] = "J_Elbow_LE";
    tagArray[tagArray.size] = "J_Elbow_RI";
    tagArray[tagArray.size] = "J_Knee_RI";
    tagArray[tagArray.size] = "J_Knee_LE";
    tagArray[tagArray.size] = "J_Ankle_RI";
    tagArray[tagArray.size] = "J_Ankle_LE";
  } else {
    tagArray[tagArray.size] = "J_Knee_RI";
    tagArray[tagArray.size] = "J_Knee_LE";
    tagArray[tagArray.size] = "J_Ankle_RI";
    tagArray[tagArray.size] = "J_Ankle_LE";
  }
  if(isDefined(level._effect["character_fire_player_sm"])) {
    for(arrayIndex = 0; arrayIndex < tagArray.size; arrayIndex++) {
      playFXOnTag(level._effect["character_fire_player_sm"], self, tagArray[arrayIndex]);
    }
  }
  if(!IsAlive(self))
    return;
  self thread doFlameDamage(attacker, inflictor, weapon, 1.0);
  if(isplayer(self)) {
    self thread watchForWater(7);
    self thread watchForDeath();
  }
}
burnedWithFlameThrower(attacker, inflictor, weapon) {
  if(isDefined(self.burning))
    return;
  self startTanning();
  self thread waitThenStopTanning(level.flameBurnTime);
  self endon("disconnect");
  waittillframeend;
  self.burning = true;
  self thread burn_blocker();
  tagArray = [];
  if(isai(self)) {
    tagArray[0] = "J_Spine1";
    tagArray[1] = "J_Elbow_LE";
    tagArray[2] = "J_Elbow_RI";
    tagArray[3] = "J_Head";
    tagArray[4] = "j_knee_ri";
    tagArray[5] = "j_knee_le";
  } else {
    tagArray[0] = "J_Elbow_RI";
    tagArray[1] = "j_knee_ri";
    tagArray[2] = "j_knee_le";
    if(isplayer(self) && self.health > 0)
      self setburn(3.0);
  }
  if(isplayer(self) && IsAlive(self)) {
    self thread watchForWater(7);
    self thread watchForDeath();
  }
  if(isDefined(level._effect["character_fire_player_sm"])) {
    for(arrayIndex = 0; arrayIndex < tagArray.size; arrayIndex++) {
      playFXOnTag(level._effect["character_fire_player_sm"], self, tagArray[arrayIndex]);
    }
  }
}
burnedWithDragonsBreath(attacker, inflictor, weapon) {
  if(isDefined(self.burning))
    return;
  self startTanning();
  self thread waitThenStopTanning(level.flameBurnTime);
  self endon("disconnect");
  waittillframeend;
  self.burning = true;
  self thread burn_blocker();
  tagArray = [];
  if(isai(self)) {
    tagArray[0] = "J_Spine1";
    tagArray[1] = "J_Elbow_LE";
    tagArray[2] = "J_Elbow_RI";
    tagArray[3] = "J_Head";
    tagArray[4] = "j_knee_ri";
    tagArray[5] = "j_knee_le";
  } else {
    tagArray[0] = "j_spinelower";
    tagArray[1] = "J_Elbow_RI";
    tagArray[2] = "j_knee_ri";
    tagArray[3] = "j_knee_le";
    if(isplayer(self) && self.health > 0)
      self setburn(3.0);
  }
  if(isplayer(self) && IsAlive(self)) {
    self thread watchForWater(7);
    self thread watchForDeath();
    return;
  }
  if(isDefined(level._effect["character_fire_player_sm"])) {
    for(arrayIndex = 0; arrayIndex < tagArray.size; arrayIndex++) {
      playFXOnTag(level._effect["character_fire_player_sm"], self, tagArray[arrayIndex]);
    }
  }
}
burnedToDeath() {
  self.burning = true;
  self thread burn_blocker();
  self startTanning();
  self thread doBurningSound();
  self thread waitThenStopTanning(level.flameBurnTime);
}
watchForDeath() {
  self endon("disconnect");
  self notify("watching for death while on fire");
  self endon("watching for death while on fire");
  self waittill("death");
  if(isplayer(self))
    self _StopBurning();
  self.burning = undefined;
}
watchForWater(time) {
  self endon("disconnect");
  self notify("watching for water");
  self endon("watching for water");
  wait(.1);
  looptime = .1;
  while(time > 0) {
    wait(looptime);
    if(self DepthOfPlayerInWater() > 0) {
      finish_burn();
      time = 0;
    }
    time -= looptime;
  }
}
finish_burn() {
  self notify("stop burn damage");
  tagArray = [];
  tagArray[0] = "j_spinelower";
  tagArray[1] = "J_Elbow_RI";
  tagArray[2] = "J_Head";
  tagArray[3] = "j_knee_ri";
  tagArray[4] = "j_knee_le";
  if(isDefined(level._effect["fx_fire_player_sm_smk_2sec"])) {
    for(arrayIndex = 0; arrayIndex < tagArray.size; arrayIndex++) {
      playFXOnTag(level._effect["fx_fire_player_sm_smk_2sec"], self, tagArray[arrayIndex]);
    }
  }
  self.burning = undefined;
  self _StopBurning();
  self.inGroundNapalm = false;
}
doNapalmStrikeDamage(attacker, inflictor, mod) {
  if(isai(self)) {
    doDogNapalmStrikeDamage(attacker, inflictor, mod);
    return;
  }
  self endon("death");
  self endon("disconnect");
  attacker endon("disconnect");
  self endon("stop burn damage");
  while((isDefined(level.napalmStrikeDamage)) && (isDefined(self)) && self DepthOfPlayerInWater() < 1) {
    self DoDamage(level.napalmStrikeDamage, self.origin, attacker, attacker, 0, mod, 0, "napalm_mp");
    wait(1);
  }
}
doNapalmGroundDamage(attacker, inflictor, mod) {
  if(self hasperk("specialty_fireproof"))
    return;
  if(level.teambased) {
    if(attacker != self && attacker.team == self.team)
      return;
  }
  if(isai(self)) {
    doDogNapalmGroundDamage(attacker, inflictor, mod);
    return;
  }
  if(isDefined(self.burning))
    return;
  self thread burn_blocker();
  self endon("death");
  self endon("disconnect");
  attacker endon("disconnect");
  self endon("stop burn damage");
  if(isDefined(level.groundBurnTime)) {
    if(GetDvar(#"scr_groundBurnTime") == "") {
      waittime = level.groundBurnTime;
    } else {
      waittime = GetDvarFloat(#"scr_groundBurnTime");
    }
  } else
    waittime = 100;
  self walkedThroughFlames(attacker, inflictor, "napalm_mp");
  self.inGroundNapalm = true;
  if(isDefined(level.napalmGroundDamage)) {
    if(GetDvar(#"scr_napalmGroundDamage") == "") {
      napalmGroundDamage = level.napalmGroundDamage;
    } else {
      napalmGroundDamage = GetDvarFloat(#"scr_napalmGroundDamage");
    }
    while(isDefined(self) && isDefined(inflictor) && ((self DepthOfPlayerInWater()) < 1) && waittime > 0) {
      self DoDamage(level.napalmGroundDamage, self.origin, attacker, inflictor, 0, mod, 0, "napalm_mp");
      if(isplayer(self))
        self setburn(1.1);
      wait(1);
      waittime = waittime - 1;
    }
  }
  self.inGroundNapalm = false;
}
doDogNapalmStrikeDamage(attacker, inflictor, mod) {
  attacker endon("disconnect");
  self endon("death");
  self endon("stop burn damage");
  while((isDefined(level.napalmStrikeDamage)) && (isDefined(self))) {
    self DoDamage(level.napalmStrikeDamage, self.origin, attacker, attacker, 0, mod);
    wait(1);
  }
}
doDogNapalmGroundDamage(attacker, inflictor, mod) {
  attacker endon("disconnect");
  self endon("death");
  self endon("stop burn damage");
  while((isDefined(level.napalmGroundDamage)) && (isDefined(self))) {
    self DoDamage(level.napalmGroundDamage, self.origin, attacker, attacker, 0, mod, 0, "napalm_mp");
    wait(1);
  }
}
burn_blocker() {
  self endon("disconnect");
  self endon("death");
  wait(3);
  self.burning = undefined;
}
doFlameDamage(attacker, inflictor, weapon, time) {
  if(IsAI(self)) {
    doDogFlameDamage(attacker, inflictor, weapon, time);
    return;
  }
  if(isDefined(attacker))
    attacker endon("disconnect");
  self endon("death");
  self endon("disconnect");
  self endon("stop burn damage");
  self thread doBurningSound();
  self notify("snd_burn_scream");
  wait_time = 1.0;
  while(isDefined(level.flameDamage) && isDefined(self) && (self DepthOfPlayerInWater() < 1) && time > 0) {
    if(isDefined(attacker) && isDefined(inflictor) && isDefined(weapon)) {
      if(maps\mp\gametypes\_globallogic_player::doDamageFeedback(weapon, attacker))
        attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback(false);
      self DoDamage(level.flameDamage, self.origin, attacker, inflictor, 0, "MOD_BURNED", 0, weapon);
    } else {
      self DoDamage(level.flameDamage, self.origin);
    }
    wait(wait_time);
    time -= wait_time;
  }
  self thread finish_burn();
}
doDogFlameDamage(attacker, inflictor, weapon, time) {
  if(!isDefined(attacker) || !isDefined(inflictor) || !isDefined(weapon))
    return;
  attacker endon("disconnect");
  self endon("death");
  self endon("stop burn damage");
  self thread doBurningSound();
  wait_time = 1.0;
  while(isDefined(level.flameDamage) && isDefined(self) && time > 0) {
    self DoDamage(level.flameDamage, self.origin, attacker, inflictor, 0, "MOD_BURNED", 0, weapon);
    wait(wait_time);
    time -= wait_time;
  }
}
waitThenStopTanning(time) {
  self endon("disconnect");
  self endon("death");
  wait(time);
  self _stopBurning();
}
doBurningSound() {
  self endon("disconnect");
  self endon("death");
  fire_sound_ent = spawn("script_origin", self.origin);
  fire_sound_ent linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  fire_sound_ent playLoopSound("mpl_player_burn_loop");
  self thread fireSoundDeath(fire_sound_ent);
  self waittill("StopBurnSound");
  if(isDefined(fire_sound_ent))
    fire_sound_ent StopLoopSound(0.5);
  wait .5;
  if(isDefined(fire_sound_ent))
    fire_sound_ent delete();
  println("sound stop burning");
}
_stopBurning() {
  self endon("disconnect");
  self notify("StopBurnSound");
  if(isDefined(self))
    self StopBurning();
}
fireSoundDeath(ent) {
  ent endon("death");
  self waittill_any("death", "disconnect");
  ent delete();
  println("sound delete burning");
}