/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\entityheadicons_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace entityheadicons;

function init_shared() {
  callback::on_start_gametype( & start_gametype);
}

function start_gametype() {
  if(isDefined(level.initedentityheadicons)) {
    return;
  }
  level.initedentityheadicons = 1;
  assert(isDefined(game[""]), "");
  assert(isDefined(game[""]), "");
  if(!level.teambased) {
    return;
  }
  if(!isDefined(level.setentityheadicon)) {
    level.setentityheadicon = & setentityheadicon;
  }
  level.entitieswithheadicons = [];
}

function setentityheadicon(team, owner, offset, objective, constant_size) {
  if(!level.teambased && !isDefined(owner)) {
    return;
  }
  if(!isDefined(constant_size)) {
    constant_size = 0;
  }
  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = "none";
    self.entityheadicons = [];
    self.entityheadobjectives = [];
  }
  if(level.teambased && !isDefined(owner)) {
    if(team == self.entityheadiconteam) {
      return;
    }
    self.entityheadiconteam = team;
  }
  if(isDefined(offset)) {
    self.entityheadiconoffset = offset;
  } else {
    self.entityheadiconoffset = (0, 0, 0);
  }
  if(isDefined(self.entityheadicons)) {
    for(i = 0; i < self.entityheadicons.size; i++) {
      if(isDefined(self.entityheadicons[i])) {
        self.entityheadicons[i] destroy();
      }
    }
  }
  if(isDefined(self.entityheadobjectives)) {
    for(i = 0; i < self.entityheadobjectives.size; i++) {
      if(isDefined(self.entityheadobjectives[i])) {
        objective_delete(self.entityheadobjectives[i]);
        self.entityheadobjectives[i] = undefined;
      }
    }
  }
  self.entityheadicons = [];
  self.entityheadobjectives = [];
  self notify("kill_entity_headicon_thread");
  if(!isDefined(objective)) {
    objective = game["entity_headicon_" + team];
  }
  if(isDefined(objective)) {
    if(isDefined(owner) && !level.teambased) {
      if(!isplayer(owner)) {
        assert(isDefined(owner.owner), "");
        owner = owner.owner;
      }
      if(isstring(objective)) {
        owner updateentityheadclienticon(self, objective, constant_size);
      } else {
        owner updateentityheadclientobjective(self, objective, constant_size);
      }
    } else if(isDefined(owner) && team != "none") {
      if(isstring(objective)) {
        owner updateentityheadteamicon(self, team, objective, constant_size);
      } else {
        owner updateentityheadteamobjective(self, team, objective, constant_size);
      }
    }
  }
  self thread destroyheadiconsondeath();
}

function updateentityheadteamicon(entity, team, icon, constant_size) {
  friendly_blue_color = array(0.584, 0.839, 0.867);
  headicon = newteamhudelem(team);
  headicon.archived = 1;
  headicon.x = entity.entityheadiconoffset[0];
  headicon.y = entity.entityheadiconoffset[1];
  headicon.z = entity.entityheadiconoffset[2];
  headicon.alpha = 0.8;
  headicon.color = (friendly_blue_color[0], friendly_blue_color[1], friendly_blue_color[2]);
  headicon setshader(icon, 6, 6);
  headicon setwaypoint(constant_size);
  headicon settargetent(entity);
  entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

function updateentityheadclienticon(entity, icon, constant_size) {
  headicon = newclienthudelem(self);
  headicon.archived = 1;
  headicon.x = entity.entityheadiconoffset[0];
  headicon.y = entity.entityheadiconoffset[1];
  headicon.z = entity.entityheadiconoffset[2];
  headicon.alpha = 0.8;
  headicon setshader(icon, 6, 6);
  headicon setwaypoint(constant_size);
  headicon settargetent(entity);
  entity.entityheadicons[entity.entityheadicons.size] = headicon;
}

function updateentityheadteamobjective(entity, team, objective, constant_size) {
  headiconobjectiveid = gameobjects::get_next_obj_id();
  objective_add(headiconobjectiveid, "active", entity, objective);
  objective_team(headiconobjectiveid, team);
  objective_setcolor(headiconobjectiveid, & "FriendlyBlue");
  entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

function updateentityheadclientobjective(entity, objective, constant_size) {
  headiconobjectiveid = gameobjects::get_next_obj_id();
  objective_add(headiconobjectiveid, "active", entity, objective);
  objective_setinvisibletoall(headiconobjectiveid);
  objective_setvisibletoplayer(headiconobjectiveid, self);
  objective_setcolor(headiconobjectiveid, & "FriendlyBlue");
  entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

function destroyheadiconsondeath() {
  self notify("destroyheadiconsondeath_singleton");
  self endon("destroyheadiconsondeath_singleton");
  self util::waittill_any("death", "hacked");
  for(i = 0; i < self.entityheadicons.size; i++) {
    if(isDefined(self.entityheadicons[i])) {
      self.entityheadicons[i] destroy();
    }
  }
  for(i = 0; i < self.entityheadobjectives.size; i++) {
    if(isDefined(self.entityheadobjectives[i])) {
      gameobjects::release_obj_id(self.entityheadobjectives[i]);
      objective_delete(self.entityheadobjectives[i]);
    }
  }
}

function destroyentityheadicons() {
  if(isDefined(self.entityheadicons)) {
    for(i = 0; i < self.entityheadicons.size; i++) {
      if(isDefined(self.entityheadicons[i])) {
        self.entityheadicons[i] destroy();
      }
    }
  }
  if(isDefined(self.entityheadobjectives)) {
    for(i = 0; i < self.entityheadobjectives.size; i++) {
      if(isDefined(self.entityheadobjectives[i])) {
        gameobjects::release_obj_id(self.entityheadobjectives[i]);
        objective_delete(self.entityheadobjectives[i]);
      }
    }
  }
  self.entityheadobjectives = [];
}

function updateentityheadiconpos(headicon) {
  headicon.x = self.origin[0] + self.entityheadiconoffset[0];
  headicon.y = self.origin[1] + self.entityheadiconoffset[1];
  headicon.z = self.origin[2] + self.entityheadiconoffset[2];
}

function setentityheadiconshiddenwhilecontrolling() {
  if(isDefined(self.entityheadicons)) {
    foreach(icon in self.entityheadicons) {
      icon.hidewhileremotecontrolling = 1;
    }
  }
}