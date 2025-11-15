/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\entityheadicons_shared.gsc
**************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\util_shared;

#namespace entityheadicons;

init_shared() {
  callback::on_start_gametype(&start_gametype);
}

start_gametype() {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(level.setentityheadicon)) {
    level.setentityheadicon = &setentityheadicon;
  }
}

setentityheadicon(team, owner, objective) {
  if(!level.teambased && !isDefined(owner)) {
    return;
  }

  if(!isDefined(self.entityheadiconteam)) {
    self.entityheadiconteam = #"none";
    self.entityheadobjectives = [];
  }

  if(level.teambased && !isDefined(owner)) {
    if(team == self.entityheadiconteam) {
      return;
    }

    self.entityheadiconteam = team;
  }

  destroyentityheadicons();
  self.entityheadobjectives = [];
  self notify(#"kill_entity_headicon_thread");

  if(isDefined(objective)) {
    if(isDefined(owner) && !level.teambased) {
      if(!isplayer(owner)) {
        assert(isDefined(owner.owner), "<dev string:x38>");
        owner = owner.owner;
      }

      if(isDefined(objective)) {
        if(team !== #"none") {
          owner updateentityheadteamobjective(self, team, objective);
        } else {
          owner updateentityheadclientobjective(self, objective);
        }
      }
    } else if(isDefined(owner) && team != #"none") {
      if(isDefined(objective)) {
        owner updateentityheadteamobjective(self, team, objective);
      }
    }
  }

  self thread destroyheadiconsondeath();
}

updateentityheadteamobjective(entity, team, objective) {
  headiconobjectiveid = gameobjects::get_next_obj_id();
  objective_add(headiconobjectiveid, "active", entity, objective);
  objective_setteam(headiconobjectiveid, team);
  function_3ae6fa3(headiconobjectiveid, team, 1);
  entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

updateentityheadclientobjective(entity, objective) {
  headiconobjectiveid = gameobjects::get_next_obj_id();
  objective_add(headiconobjectiveid, "active", entity, objective);
  objective_setinvisibletoall(headiconobjectiveid);
  objective_setvisibletoplayer(headiconobjectiveid, self);
  entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

destroyheadiconsondeath() {
  self notify(#"destroyheadiconsondeath_singleton");
  self endon(#"destroyheadiconsondeath_singleton");
  self waittill(#"death", #"hacked");
  destroyentityheadicons();
}

destroyentityheadicons() {
  if(isDefined(self.entityheadobjectives)) {
    for(i = 0; i < self.entityheadobjectives.size; i++) {
      if(isDefined(self.entityheadobjectives[i])) {
        gameobjects::release_obj_id(self.entityheadobjectives[i]);
        objective_delete(self.entityheadobjectives[i]);
      }
    }
  }

  if(isDefined(self)) {
    self.entityheadobjectives = [];
  }
}