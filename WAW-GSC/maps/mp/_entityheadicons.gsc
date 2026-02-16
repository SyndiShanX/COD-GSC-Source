/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\_entityheadicons.gsc
****************************************/

init() {
  if(isDefined(level.initedEntityHeadIcons)) {
    return;
  }
  level.initedEntityHeadIcons = true;

  switch (game["allies"]) {
    case "marines":
      game["entity_headicon_allies"] = "headicon_american";
      break;
    case "russian":
      game["entity_headicon_allies"] = "headicon_russian";
      break;
    default:
      game["entity_headicon_allies"] = "headicon_american";
      break;
  }
  switch (game["axis"]) {
    case "german":
      game["entity_headicon_axis"] = "headicon_german";
      break;
    case "japanese":
      game["entity_headicon_axis"] = "headicon_japanese";
      break;
    default:
      game["entity_headicon_axis"] = "headicon_japanese";
      break;
  }
  precacheShader(game["entity_headicon_allies"]);
  precacheShader(game["entity_headicon_axis"]);

  if(!level.teamBased) {
    return;
  }

  entityHeadIconHandler =
    maps\mp\gametypes\_perplayer::init("entityheadiconhandler", ::showAllEntityHeadIcons, ::hideAllEntityHeadIcons);
  maps\mp\gametypes\_perplayer::enable(entityHeadIconHandler);
  level.entitiesWithHeadIcons = [];
  level.playersViewingHeadIcons = [];
}

setEntityHeadIcon(team, offset) {
  if(!level.teamBased) {
    return;
  }

  if(!isDefined(self.entityHeadIconTeam)) {
    self.entityHeadIconTeam = "none";
    self.entityHeadIcons = [];
  }
  if(team == self.entityHeadIconTeam) {
    return;
  }

  self.entityHeadIconTeam = team;

  if(isDefined(offset)) {
    self.entityHeadIconOffset = offset;
  } else {
    self.entityHeadIconOffset = (0, 0, 0);
  }

  for(i = 0; i < self.entityHeadIcons.size; i++) {
    if(isDefined(self.entityHeadIcons[i])) {
      self.entityHeadIcons[i] destroy();
    }
    self.entityHeadIcons = [];
  }

  self notify("kill_entity_headicon_thread");

  if(team != "none") {
    for(i = 0; i < level.playersViewingHeadIcons.size; i++) {
      level.playersViewingHeadIcons[i] updateEntityHeadIcon(self);
    }
  }

  newarray = [];
  for(i = 0; i < level.entitiesWithHeadIcons.size; i++) {
    if(level.entitiesWithHeadIcons[i] != self) {
      newarray[newarray.size] = level.entitiesWithHeadIcons[i];
    }
  }
  if(team != "none") {
    newarray[newarray.size] = self;
  }
  level.entitiesWithHeadIcons = newarray;

  self thread keepEntityHeadIconsPositioned();
}

showAllEntityHeadIcons() {
  if(!isDefined(self.entityHeadIcons)) {
    self.entityHeadIcons = [];
  }

  for(i = 0; i < level.entitiesWithHeadIcons.size; i++) {
    if(isDefined(level.entitiesWithHeadIcons[i])) {
      self updateEntityHeadIcon(level.entitiesWithHeadIcons[i]);
    }
  }

  newarray = [];
  for(i = 0; i < level.playersViewingHeadIcons.size; i++) {
    if(level.playersViewingHeadIcons[i] != self) {
      newarray[newarray.size] = level.playersViewingHeadIcons[i];
    }
  }
  newarray[newarray.size] = self;
  level.playersViewingHeadIcons = newarray;
}
hideAllEntityHeadIcons(disconnected) {
  if(!disconnected) {
    for(i = 0; i < self.entityHeadIcons.size; i++) {
      if(isDefined(self.entityHeadIcons[i])) {
        self.entityHeadIcons[i] destroy();
      }
    }
    self.entityHeadIcons = [];
  }

  newarray = [];
  for(i = 0; i < level.playersViewingHeadIcons.size; i++) {
    if(level.playersViewingHeadIcons[i] != self) {
      newarray[newarray.size] = level.playersViewingHeadIcons[i];
    }
  }
  level.playersViewingHeadIcons = newarray;
}

updateEntityHeadIcon(entity) {
  if(entity.entityHeadIconTeam != "all" && (!isDefined(self.pers["team"]) || self.pers["team"] != entity.entityHeadIconTeam)) {
    return;
  }

  headicon = newClientHudElem(self);
  headicon.archived = true;
  headicon.x = entity.origin[0] + entity.entityHeadIconOffset[0];
  headicon.y = entity.origin[1] + entity.entityHeadIconOffset[1];
  headicon.z = entity.origin[2] + entity.entityHeadIconOffset[2];
  headicon.alpha = .8;
  headicon setShader(game["entity_headicon_" + self.pers["team"]], 6, 6);
  headicon setwaypoint(false);

  self.entityHeadIcons[self.entityHeadIcons.size] = headicon;
  entity.entityHeadIcons[entity.entityHeadIcons.size] = headicon;
}

keepEntityHeadIconsPositioned() {
  self endon("kill_entity_headicon_thread");
  self endon("death");

  self thread destroyHeadIconsOnDeath();

  pos = self.origin;
  while(1) {
    if(pos != self.origin) {
      for(i = 0; i < self.entityHeadIcons.size; i++) {
        if(isDefined(self.entityHeadIcons[i])) {
          self updateEntityHeadIconPos(self.entityHeadIcons[i]);
        }
      }
      pos = self.origin;
    }
    wait .05;
  }
}

destroyHeadIconsOnDeath() {
  self waittill("death");

  for(i = 0; i < self.entityHeadIcons.size; i++) {
    if(isDefined(self.entityHeadIcons[i])) {
      self.entityHeadIcons[i] destroy();
    }
  }

}

updateEntityHeadIconPos(headicon) {
  headicon.x = self.origin[0] + self.entityHeadIconOffset[0];
  headicon.y = self.origin[1] + self.entityHeadIconOffset[1];
  headicon.z = self.origin[2] + self.entityHeadIconOffset[2];
}