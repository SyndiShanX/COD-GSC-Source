/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\sp_killstreaks\_entityheadicons.gsc
****************************************************/

#include common_scripts\utility;

init() {
  if(isDefined(level.initedentityheadicons)) {
    return;
  }
  if(level.createfx_enabled) {
    return;
  }
  level.initedentityheadicons = 1;
  assert(isDefined(game["entity_headicon_allies"]), "Allied head icons are not defined.Check the team set for the level.");
  assert(isDefined(game["entity_headicon_axis"]), "Axis head icons are not defined.Check the team set for the level.");
  precacheshader(game["entity_headicon_allies"]);
  precacheshader(game["entity_headicon_axis"]);

  if(!level.teambased) {
    return;
  }
  level.entitieswithheadicons = [];
}

setentityheadicon(team, owner, offset, icon, constant_size, off) {
  if(!level.teambased && !isDefined(owner)) {
    return;
  }
  if(!isDefined(constant_size))
    constant_size = 0;

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicons = [];
  }

  if(level.teambased && !isDefined(owner)) {
    if(team == self.entityheadiconteam) {
      return;
    }
    self.entityheadiconteam = team;
  }

  if(isDefined(offset))
    self.entityheadiconoffset = offset;
  else
    self.entityheadiconoffset = (0, 0, 0);

  for(i = 0; i < self.entityheadicons.size; i++) {
    if(isDefined(self.entityheadicons[i]))
      self.entityheadicons[i] destroy();
  }

  self.entityheadicons = [];
  self notify("kill_entity_headicon_thread");

  if(!isDefined(icon))
    icon = game["entity_headicon_" + team];

  if(isDefined(owner) && !level.teambased) {
    if(!isplayer(owner)) {
      assert(isDefined(owner.owner), "entity has to have an owner if it's not a player");
      owner = owner.owner;
    }

    owner updateentityheadclienticon(self, icon, constant_size, off);
  } else if(isDefined(owner) && team != "none")
    owner updateentityheadteamicon(self, team, icon, constant_size, off);

  self thread destroyheadiconsondeath();
}

updateentityheadteamicon(entity, team, icon, constant_size, off) {
  headicon = newteamhudelem(team);
  headicon.archived = 1;
  headicon.x = entity.entityheadiconoffset[0];
  headicon.y = entity.entityheadiconoffset[1];
  headicon.z = entity.entityheadiconoffset[2];
  headicon.alpha = 0.8;
  headicon setshader(icon, 6, 6);

  if(isDefined(off))
    headicon setwaypoint(constant_size, "", 0, off);
  else
    headicon setwaypoint(constant_size);

  headicon settargetent(entity);
  entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

updateentityheadclienticon(entity, icon, constant_size, off) {
  headicon = newclienthudelem(self);

  if(!isDefined(headicon)) {
    return;
  }
  headicon.archived = 1;
  headicon.x = entity.entityheadiconoffset[0];
  headicon.y = entity.entityheadiconoffset[1];
  headicon.z = entity.entityheadiconoffset[2];
  headicon.alpha = 0.8;
  headicon setshader(icon, 6, 6);

  if(isDefined(off))
    headicon setwaypoint(constant_size, "", 0, off);
  else
    headicon setwaypoint(constant_size);

  headicon settargetent(entity);
  entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

destroyheadiconsondeath() {
  self waittill_any("death", "hacked");

  for(i = 0; i < self.entityheadicons.size; i++) {
    if(isDefined(self.entityheadicons[i]))
      self.entityheadicons[i] destroy();
  }
}

destroyentityheadicons() {
  if(isDefined(self.entityheadicons)) {
    for(i = 0; i < self.entityheadicons.size; i++) {
      if(isDefined(self.entityheadicons[i]))
        self.entityheadicons[i] destroy();
    }
  }
}

updateentityheadiconpos(headicon) {
  headicon.x = self.origin[0] + self.entityheadiconoffset[0];
  headicon.y = self.origin[1] + self.entityheadiconoffset[1];
  headicon.z = self.origin[2] + self.entityheadiconoffset[2];
}