/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_spectating.gsc
***************************************************/

#include maps\mp\_utility;

init() {
  level.spectateOverride["allies"] = spawnStruct();
  level.spectateOverride["axis"] = spawnStruct();

  level thread onPlayerConnect();
}

onPlayerConnect() {
  for(;;) {
    level waittill("connected", player);

    player thread onJoinedTeam();
    player thread onJoinedSpectators();
    player thread onSpectatingClient();
  }
}

onJoinedTeam() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");
    self setSpectatePermissions();
  }
}

onJoinedSpectators() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_spectators");
    self setSpectatePermissions();
    if(!inVirtualLobby() && (self IsMLGSpectator() || (isDefined(self.pers["mlgSpectator"]) && self.pers["mlgSpectator"]))) {
      self SetMLGSpectator(1);
      if(game["roundsPlayed"] > 0) {
        self SetClientOmnvar("ui_use_mlg_hud", true);
      }
    }
  }
}

updateMLGIcons() {
  self endon("disconnect");

  if(self IsMLGSpectator()) {
    for(;;) {
      level waittill("player_spawned", player);

      loadout = player.spectatorViewLoadout;
      if(isDefined(loadout)) {
        if(isDefined(loadout.primary)) {
          self PrecacheKillcamIconForWeapon(loadout.primary);
        }

        if(isDefined(loadout.secondary)) {
          self PrecacheKillcamIconForWeapon(loadout.secondary);
        }
      }
    }
  }
}

onSpectatingClient() {
  self endon("disconnect");

  self thread updateMLGIcons();

  for(;;) {
    self waittill("spectating_cycle");

    spectatedPlayer = self GetSpectatingPlayer();
    if(isDefined(spectatedPlayer)) {
      self SetCardDisplaySlot(spectatedPlayer, 6);
      if(self IsMLGSpectator()) {
        self updateSpectatedLoadout(spectatedPlayer);
      }
    }
  }
}

updateSpectateSettings() {
  level endon("game_ended");

  for(index = 0; index < level.players.size; index++) {
    level.players[index] setSpectatePermissions();
  }
}

setSpectatePermissions() {
  team = self.sessionteam;

  if(level.gameEnded && gettime() - level.gameEndTime >= 2000) {
    if(level.multiTeamBased) {
      for(i = 0; i < level.teamNameList.size; i++) {
        self allowSpectateTeam(level.teamNameList[i], false);
      }
    } else {
      self allowSpectateTeam("allies", false);
      self allowSpectateTeam("axis", false);
    }
    self allowSpectateTeam("freelook", false);
    self allowSpectateTeam("none", true);
    return;
  }

  spectateType = maps\mp\gametypes\_tweakables::getTweakableValue("game", "spectatetype");
  spectatePOV = maps\mp\gametypes\_tweakables::getTweakableValue("game", "lockspectatepov");

  if(self IsMLGSpectator() && !inVirtualLobby()) {
    spectateType = 2;
  }

  switch (spectateType) {
    case 0:
      if(level.multiTeamBased) {
        for(i = 0; i < level.teamNameList.size; i++) {
          self allowSpectateTeam(level.teamNameList[i], false);
        }
      } else {
        self allowSpectateTeam("allies", false);
        self allowSpectateTeam("axis", false);
      }
      self allowSpectateTeam("freelook", false);
      self allowSpectateTeam("none", false);
      break;

    case 1:
      if(!level.teamBased) {
        self allowSpectateTeam("allies", true);
        self allowSpectateTeam("axis", true);
        self allowSpectateTeam("none", true);
        self allowSpectateTeam("freelook", false);
      } else if(isDefined(team) && (team == "allies" || team == "axis") && !level.multiTeamBased) {
        self allowSpectateTeam(team, true);
        self allowSpectateTeam(getOtherTeam(team), false);
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
      } else if(isDefined(team) && IsSubStr(team, "team_") && level.multiTeamBased) {
        for(i = 0; i < level.teamNameList.size; i++) {
          if(team == level.teamNameList[i]) {
            self allowSpectateTeam(level.teamNameList[i], true);
          } else {
            self allowSpectateTeam(level.teamNameList[i], false);
          }
        }
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
      } else {
        if(level.multiTeamBased) {
          for(i = 0; i < level.teamNameList.size; i++) {
            self allowSpectateTeam(level.teamNameList[i], false);
          }
        } else {
          self allowSpectateTeam("allies", false);
          self allowSpectateTeam("axis", false);
        }
        self allowSpectateTeam("freelook", false);
        self allowSpectateTeam("none", false);
      }
      break;
    case 2:
      if(level.multiTeamBased) {
        for(i = 0; i < level.teamNameList.size; i++) {
          self allowSpectateTeam(level.teamNameList[i], true);
        }
      } else {
        self allowSpectateTeam("allies", true);
        self allowSpectateTeam("axis", true);
      }
      self allowSpectateTeam("freelook", true);
      self allowSpectateTeam("none", true);
      break;
  }

  xuid = self getXUID();

  switch (spectatePOV) {
    case 0:
      self forceSpectatePOV(xuid, "freelook");
      break;
    case 1:
      self allowSpectateTeam("none", false);
      self allowSpectateTeam("freelook", false);
      self forceSpectatePOV(xuid, "first_person");
      break;
    case 2:
      self allowSpectateTeam("none", false);
      self allowSpectateTeam("freelook", false);
      self forceSpectatePOV(xuid, "third_person");
      break;
  }

  if(isDefined(team) && (team == "axis" || team == "allies")) {
    if(isDefined(level.spectateOverride[team].allowFreeSpectate)) {
      self allowSpectateTeam("freelook", true);
    }

    if(isDefined(level.spectateOverride[team].allowEnemySpectate)) {
      self allowSpectateTeam(getOtherTeam(team), true);
    }
  }
}

updateSpectatedLoadoutWeapon(baseOmnvar, weapon, attachments) {
  if(isDefined(weapon)) {
    weapon = maps\mp\_utility::strip_suffix(weapon, "_mp");
    weapon = TableLookupRowNum("mp/statsTable.csv", 4, weapon);
  }
  if(!isDefined(weapon)) weapon = 0;
  self SetClientOmnvar(baseOmnvar + "weapon", weapon);

  for(i = 0; i < attachments.size; i++) {
    attachment = undefined;
    if(isDefined(attachments[i])) {
      attachment = attachmentMap_toBase(attachments[i]);
      attachment = TableLookupRowNum("mp/attachmentTable.csv", 3, attachment);
    }
    if(!isDefined(attachment)) attachment = 0;
    self SetClientOmnvar(baseOmnvar + "attachment_" + i, attachment);
  }

}

updateSpectatedLoadout(spectatedPlayer) {
  loadout = spectatedPlayer.spectatorViewLoadout;

  updateSpectatedLoadoutWeapon("ui_mlg_loadout_primary_", loadout.primary, [loadout.primaryAttachment, loadout.primaryAttachment2, loadout.primaryAttachment3]);
  updateSpectatedLoadoutWeapon("ui_mlg_loadout_secondary_", loadout.secondary, [loadout.secondaryAttachment, loadout.secondaryAttachment2]);

  offhand = loadout.offhand;
  if(isDefined(offhand)) {
    offhand = TableLookupRowNum("mp/perkTable.csv", 1, offhand);
  }
  if(!isDefined(offhand)) offhand = 0;
  self SetClientOmnvar("ui_mlg_loadout_equipment_0", offhand);

  equipment = loadout.equipment;
  if(isDefined(equipment)) {
    equipment = TableLookupRowNum("mp/perkTable.csv", 1, equipment);
  }
  if(!isDefined(equipment)) equipment = 0;
  self SetClientOmnvar("ui_mlg_loadout_equipment_1", equipment);

  if(loadout.equipmentExtra) {
    self SetClientOmnvar("ui_mlg_loadout_equipment_2", equipment);
  } else {
    self SetClientOmnvar("ui_mlg_loadout_equipment_2", -1);
  }

  killstreaks = [loadout.killstreak1, loadout.killstreak2, loadout.killstreak3, loadout.killstreak4];
  for(i = 0; i < 4; i++) {
    streak = killstreaks[i];
    if(isDefined(streak)) {
      streak = TableLookupRowNum("mp/killstreakTable.csv", 1, streak);
    }
    if(!isDefined(streak)) attachment = 0;
    self SetClientOmnvar("ui_mlg_loadout_streak_" + i, streak);
  }

  for(i = 0; i < 6; i++) {
    perk = loadout.perks[i];
    if(isDefined(perk)) {
      perk = TableLookupRowNum("mp/perkTable.csv", 1, perk);
    }
    if(!isDefined(perk)) perk = 0;
    self SetClientOmnvar("ui_mlg_loadout_perk_" + i, perk);
  }

}