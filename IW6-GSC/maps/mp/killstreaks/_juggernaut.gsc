/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_juggernaut.gsc
***********************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

DECAP_SCALAR_X = 6000;
DECAP_SCALAR_Y = 10000;
DECAP_SCALAR_Z = 4000;

init() {
  level.juggSettings = [];

  level.juggSettings["juggernaut"] = spawnStruct();
  level.juggSettings["juggernaut"].splashUsedName = "used_juggernaut";

  level.juggSettings["juggernaut_recon"] = spawnStruct();
  level.juggSettings["juggernaut_recon"].splashUsedName = "used_juggernaut_recon";

  level.juggSettings["juggernaut_maniac"] = spawnStruct();
  level.juggSettings["juggernaut_maniac"].splashUsedName = "used_juggernaut_maniac";

  level thread watchJuggHostMigrationFinishedInit();
}

giveJuggernaut(juggType) {
  self endon("death");
  self endon("disconnect");

  wait(0.05);

  if(isDefined(self.lightArmorHP)) {
    self maps\mp\perks\_perkfunctions::unsetLightArmor();
  }

  self maps\mp\gametypes\_weapons::disablePlantedEquipmentUse();

  if(self _hasPerk("specialty_explosivebullets")) {
    self _unsetPerk("specialty_explosivebullets");
  }

  self.health = self.maxHealth;

  defaultSetup = true;

  switch (juggType) {
    case "juggernaut":
      self.isJuggernaut = true;
      self.juggMoveSpeedScaler = .80;
      self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], juggType, false);
      self.moveSpeedScaler = .80;
      self givePerk("specialty_scavenger", false);
      self givePerk("specialty_quickdraw", false);
      self givePerk("specialty_detectexplosive", false);
      self givePerk("specialty_sharp_focus", false);
      self givePerk("specialty_radarjuggernaut", false);
      break;
    case "juggernaut_recon":
      self.isJuggernautRecon = true;
      self.juggMoveSpeedScaler = .80;
      self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], juggType, false);
      self.moveSpeedScaler = .80;
      self givePerk("specialty_scavenger", false);
      self givePerk("specialty_coldblooded", false);
      self givePerk("specialty_noscopeoutline", false);
      self givePerk("specialty_detectexplosive", false);
      self givePerk("specialty_sharp_focus", false);
      self givePerk("specialty_radarjuggernaut", false);

      if(!IsAgent(self)) {
        self makePortableRadar(self);

        self maps\mp\gametypes\_missions::processChallenge("ch_airdrop_juggernaut_recon");
      }

      break;
    case "juggernaut_maniac":
      self.isJuggernautManiac = true;
      self.juggMoveSpeedScaler = 1.15;
      self maps\mp\gametypes\_class::giveLoadout(self.pers["team"], juggType, false);

      self givePerk("specialty_blindeye", false);
      self givePerk("specialty_coldblooded", false);
      self givePerk("specialty_noscopeoutline", false);
      self givePerk("specialty_detectexplosive", false);
      self givePerk("specialty_marathon", false);
      self givePerk("specialty_falldamage", false);

      self.moveSpeedScaler = 1.15;
      break;
    default:

      AssertEx(isDefined(level.mapCustomJuggFunc), "Juggernaut type " + juggType + " needs to have a level.mapCustomJuggFunc defined!");
      defaultSetup = self[[level.mapCustomJuggFunc]](juggType);
      break;
  }

  if(self perkCheck("specialty_hardline")) {
    self givePerk("specialty_hardline", false);
  }

  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
  self disableWeaponPickup();

  if(!IsAgent(self)) {
    if(defaultSetup) {
      self SetClientOmnvar("ui_juggernaut", 1);
      self thread teamPlayerCardSplash(level.juggSettings[juggType].splashUsedName, self);
      self thread juggernautSounds();
      self thread watchDisableJuggernaut();
      self thread watchEnableJuggernaut();
    }
  }

  if(self.streakType == "specialist") {
    self thread maps\mp\killstreaks\_killstreaks::clearKillstreaks();
  } else {
    self thread maps\mp\killstreaks\_killstreaks::updateKillstreaks(true);
  }

  self thread juggRemover();

  if(isDefined(self.carryFlag)) {
    wait(0.05);
    self attach(self.carryFlag, "J_spine4", true);
  }

  level notify("juggernaut_equipped", self);

  self maps\mp\_matchdata::logKillstreakEvent(juggType, self.origin);
}

perkCheck(perkToCheck) {
  loadoutPerks = self.pers["loadoutPerks"];

  foreach(perk in loadoutPerks) {
    if(perk == perkToCheck) {
      return true;
    }
  }

  return false;
}

juggernautSounds() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("jugg_removed");

  while(true) {
    wait(3.0);
    playPlayerAndNpcSounds(self, "juggernaut_breathing_player", "juggernaut_breathing_sound");
  }
}

watchJuggHostMigrationFinishedInit() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");

    foreach(player in level.players) {
      if(isAI(player)) {
        continue;
      } else if(player isJuggernaut() && !(isDefined(player.isJuggernautLevelCustom) && player.isJuggernautLevelCustom)) {
        player SetClientOmnvar("ui_juggernaut", 1);
      } else {
        player SetClientOmnvar("ui_juggernaut", 0);
      }
    }
  }
}

juggRemover() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("jugg_removed");

  self thread juggRemoveOnGameEnded();
  self waittill_any("death", "joined_team", "joined_spectators", "lost_juggernaut");

  self enableWeaponPickup();
  self.isJuggernaut = false;
  self.isJuggernautDef = false;
  self.isJuggernautGL = false;
  self.isJuggernautRecon = false;
  self.isJuggernautManiac = false;
  self.isJuggernautLevelCustom = false;
  if(IsPlayer(self)) {
    self SetClientOmnvar("ui_juggernaut", 0);
  }

  self unsetPerk("specialty_radarjuggernaut", true);

  self notify("jugg_removed");
}

juggRemoveOnGameEnded() {
  self endon("disconnect");
  self endon("jugg_removed");

  level waittill("game_ended");

  if(IsPlayer(self)) {
    self SetClientOmnvar("ui_juggernaut", 0);
  }
}

setJugg() {
  if(isDefined(self.headModel)) {
    self Detach(self.headModel, "");
    self.headModel = undefined;
  }
  self setModel("mp_fullbody_juggernaut_heavy_black");
  self SetViewModel("viewhands_juggernaut_ally");
  self SetClothType("vestheavy");
}

setJuggManiac() {
  if(isDefined(self.headModel)) {
    self Detach(self.headModel, "");
    self.headModel = undefined;
  }
  self setModel("mp_body_juggernaut_light_black");
  self SetViewModel("viewhands_juggernaut_ally");
  self Attach("head_juggernaut_light_black", "", true);
  self.headModel = "head_juggernaut_light_black";
  self SetClothType("nylon");
}

disableJuggernaut() {
  if(self isJuggernaut()) {
    self.juggernaut_disabled = true;
    self SetClientOmnvar("ui_juggernaut", 0);
  }
}

enableJuggernaut() {
  if(self isJuggernaut()) {
    self.juggernaut_disabled = undefined;
    self SetClientOmnvar("ui_juggernaut", 1);
  }
}

watchDisableJuggernaut() {
  self endon("death");
  self endon("disconnect");
  self endon("jugg_removed");
  level endon("game_ended");

  while(true) {
    if(!isDefined(self.juggernaut_disabled) && self isUsingRemote()) {
      self waittill("black_out_done");
      disableJuggernaut();
    }
    wait(0.05);
  }
}

watchEnableJuggernaut() {
  self endon("death");
  self endon("disconnect");
  self endon("jugg_removed");
  level endon("game_ended");

  while(true) {
    if(isDefined(self.juggernaut_disabled) && !self isUsingRemote()) {
      enableJuggernaut();
    }
    wait(0.05);
  }
}

initLevelCustomJuggernaut(createFunc, loadoutFunc, modelFunc, useSplashStr) {
  level.mapCustomJuggFunc = createFunc;
  level.mapCustomJuggSetClass = loadoutFunc;
  level.mapCustomJuggKilledSplash = useSplashStr;

  game["allies_model"]["JUGGERNAUT_CUSTOM"] = modelFunc;
  game["axis_model"]["JUGGERNAUT_CUSTOM"] = modelFunc;
}