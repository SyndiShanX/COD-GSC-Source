/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_burnplayer.gsc
*****************************************************/

initBurnPlayer() {
  level._effect["character_fire_death_torso"] = loadfx("env/fire/fx_fire_player_torso_mp");
  level._effect["character_fire_player_sm"] = loadfx("env/fire/fx_fire_player_sm_mp");
  level._effect["character_fire_death_sm"] = loadfx("env/fire/fx_fire_player_md_mp");
  level._effect["fx_fire_player_sm_smk_2sec"] = loadfx("env/fire/fx_fire_player_sm_smk_2sec");
}

directHitWithMolotov(attacker, inflictor, mod) {
  if(isDefined(self.burning)) {
    return;
  }
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
    if(isplayer(self)) {
      self setburn(3.0);
    }
  }
  self startTanning();
  if(isDefined(level._effect["character_fire_death_torso"])) {
    for(arrayIndex = 0; arrayIndex < tagArray.size; arrayIndex++) {
      playFXOnTag(level._effect["character_fire_death_sm"], self, tagArray[arrayIndex]);
    }
  }
  playFXOnTag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
  if(!isalive(self)) {
    return;
  }
  if(isplayer(self)) {
    self thread watchForWater(7);
    self thread watchForDeath();
  }
}

walkedThroughFlames() {
  if(isDefined(self.burning)) {
    return;
  }
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
  if(isplayer(self)) {
    self thread watchForWater(7);
    self thread watchForDeath();
  }
}

burnedWithFlameThrower() {
  if(isDefined(self.burning)) {
    return;
  }
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
    tagArray[2] = "J_Head";
    tagArray[3] = "j_knee_ri";
    tagArray[4] = "j_knee_le";
    if(isplayer(self)) {
      self setburn(3.0);
    }
  }
  self startTanning();
  if(isDefined(level._effect["character_fire_player_sm"])) {
    for(arrayIndex = 0; arrayIndex < tagArray.size; arrayIndex++) {
      playFXOnTag(level._effect["character_fire_player_sm"], self, tagArray[arrayIndex]);
    }
  }
  if(isplayer(self)) {
    self thread watchForWater(7);
    self thread watchForDeath();
  }
}

burnedToDeath() {
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
    if(isplayer(self)) {
      self setburn(3.0);
    }
  }
  self startTanning();
  if(isDefined(level._effect["character_fire_death_torso"])) {
    for(arrayIndex = 0; arrayIndex < tagArray.size; arrayIndex++) {
      playFXOnTag(level._effect["character_fire_death_sm"], self, tagArray[arrayIndex]);
    }
  }
  playFXOnTag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
}

watchForDeath() {
  self endon("disconnect");
  self notify("watching for death while on fire");
  self endon("watching for death while on fire");
  self waittill("death");
  if(isplayer(self)) {
    self StopBurning();
  }
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
      self notify("stop burn damage");
      self StopBurning();
      self.burning = undefined;
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
      self StopBurning();
      time = 0;
    }
    time -= looptime;
  }
}

doMolotovSlapDamage(attacker, inflictor, mod) {
  if(isai(self)) {
    doDogMolotovSlapDamage(attacker, inflictor, mod);
    return;
  }
  self endon("death");
  self endon("disconnect");
  attacker endon("disconnect");
  self endon("stop burn damage");
  while((isDefined(level.slappedWithMolotovDamage)) && (isDefined(self)) && self DepthOfPlayerInWater() < 1) {
    self DoDamage(level.slappedWithMolotovDamage, self.origin, attacker, attacker, 0, mod);
    wait(1);
  }
}

doDogMolotovSlapDamage(attacker, inflictor, mod) {
  attacker endon("disconnect");
  self endon("death");
  self endon("stop burn damage");
  while((isDefined(level.slappedWithMolotovDamage)) && (isDefined(self))) {
    self DoDamage(level.slappedWithMolotovDamage, self.origin, attacker, attacker, 0, mod);
    wait(1);
  }
}

burn_blocker() {
  self endon("disconnect");
  self endon("death");
  wait(3);
  self.burning = undefined;
}