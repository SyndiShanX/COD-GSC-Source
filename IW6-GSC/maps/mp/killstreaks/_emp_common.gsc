/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_emp_common.gsc
***********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

kEMP_VISION_SET = "coup_sunblind";
kEMP_BLIND_ON_DURATION = 0.05;
kEMP_BLIND_OFF_DURATION = 0.5;

shouldPlayerBeAffectedByEMP() {
  return !(self _hasPerk("specialty_empimmune")) && (self isEMPed());
}

applyGlobalEMPEffects() {
  VisionSetNaked("coup_sunblind", kEMP_BLIND_ON_DURATION);
  wait(kEMP_BLIND_ON_DURATION);

  VisionSetNaked(kEMP_VISION_SET, 0);
  VisionSetNaked("", kEMP_BLIND_OFF_DURATION);
}

applyPerPlayerEMPEffects_OnDetonate() {
  self playLocalSound("emp_activate");
}

applyPerPlayerEMPEffects() {
  self setEMPJammed(true);

  if(self _hasPerk("specialty_localjammer")) {
    self ClearScrambler();
  }

  self thread startEmpJamSequence();
}

removePerPlayerEMPEffects() {
  self setEMPJammed(false);

  if(self _hasPerk("specialty_localjammer")) {
    self MakeScrambler();
  }

  self thread stopEmpJamSequence();
}

kArtifactReps = 3;
kArtifactWaitTimeMin = 0.375;
kArtifactWaitTimeMax = 0.5;
kNoSignalWaitTimeMin = 0.25;
kNoSignalWaitTimeMax = 1.25;
startEmpJamSequence() {
  level endon("game_ended");
  self endon("emp_stop_effect");
  self endon("disconnect");

  self.bIsPlayingJamEffects = true;

  self thread doEmpArtifactLoop();

  wait(1.0);

  self SetClientOmnvar("ui_hud_static", 2);

  wait(0.5);

  self notify("emp_stop_artifact");
  self SetClientOmnvar("ui_hud_emp_artifact", 0);

  while(true) {
    self SetClientOmnvar("ui_hud_static", 3);

    waitTime = RandomFloatRange(kNoSignalWaitTimeMin, kNoSignalWaitTimeMax);
    wait(waitTime);

    self SetClientOmnvar("ui_hud_static", 2);

    wait(0.5);
  }
}

stopEmpJamSequence() {
  level endon("game_ended");
  self notify("emp_stop_effect");
  self endon("disconnect");

  if(isDefined(self.bIsPlayingJamEffects)) {
    self.bIsPlayingJamEffects = undefined;

    self SetClientOmnvar("ui_hud_static", 0);

    for(i = 0; i < kArtifactReps; i++) {
      self SetClientOmnvar("ui_hud_emp_artifact", 1);

      wait(0.5);
    }

    self SetClientOmnvar("ui_hud_emp_artifact", 0);

    self.player_static_value = 0;
  }
}

stopEmpJamSequenceImmediate() {
  self notify("emp_stop_effect");

  if(isDefined(self.bIsPlayingJamEffects) ||
    isDefined(self.player_static_value)
  ) {
    self.bIsPlayingJamEffects = undefined;
    self.player_static_value = 0;

    self SetClientOmnvar("ui_hud_static", 0);
    self SetClientOmnvar("ui_hud_emp_artifact", 0);
  }
}

doEmpArtifactLoop() {
  self notify("emp_stop_artifact");
  level endon("game_ended");
  self endon("emp_stop_effect");
  self endon("emp_stop_artifact");
  self endon("disconnect");
  self endon("joined_spectators");

  while(true) {
    self SetClientOmnvar("ui_hud_emp_artifact", 1);
    waitTime = RandomFloatRange(kArtifactWaitTimeMin, kArtifactWaitTimeMax);
    wait(waitTime);
  }
}

doEmpStaticLoop(strengthVal) {
  self notify("emp_stop_static");

  level endon("game_ended");
  self endon("emp_stop_effect");
  self endon("emp_stop_static");
  self endon("disconnect");
  self endon("joined_spectators");

  kStaticWaitTimeMin = 1.0;
  kStaticWaitTimeMax = 2.0;
  if(strengthVal == 2) {
    kStaticWaitTimeMin = 0.5;
    kStaticWaitTimeMax = 0.75;
  }

  while(true) {
    self SetClientOmnvar("ui_hud_static", 2);
    waitTime = RandomFloatRange(kStaticWaitTimeMin, kStaticWaitTimeMax);
    wait(waitTime);
  }
}

staticFieldInit() {
  self.player_static_value = 0;
}

staticFieldSetStrength(strengthVal) {
  if(self.player_static_value != strengthVal &&
    IsAlive(self) &&
    !(self isEMPed())
  ) {
    self.player_static_value = strengthVal;

    switch (strengthVal) {
      case 0:
        stopEmpJamSequence();
        break;
      case 1:
        self.bIsPlayingJamEffects = true;
        self notify("emp_stop_static");
        self thread doEmpArtifactLoop();
        self thread doEmpStaticLoop(1);
        break;
      case 2:
        self.bIsPlayingJamEffects = true;
        self notify("emp_stop_static");
        self notify("emp_stop_artifact");
        self thread doEmpStaticLoop(2);
        break;
    }
  }
}
staticFieldGetStrength() {
  return self.player_static_value;
}