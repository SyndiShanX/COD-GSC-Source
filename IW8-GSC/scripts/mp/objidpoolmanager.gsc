/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\objidpoolmanager.gsc
***********************************************/

function init() {
  var_0 = spawnStruct();
  var_0.active = [];
  var_0.reclaimed = [];
  var_0.reserved = [];
  var_0.index = 0;
  var_0.limit = spawncustomweaponscriptable();
  level.objectiveidpool = var_0;
}

function requestreservedid(var_0) {
  var_1 = spawnStruct();
  var_1.objid = var_0;
  level.objectiveidpool.active[var_0] = var_1;
  level.objectiveidpool.index++;
  level.objectiveidpool.reserved[level.objectiveidpool.reserved.size] = var_0;
  return var_0;
}

function requestobjectiveid(var_0) {
  var_1 = getnextobjectiveid(var_0);

  if(var_1 == -1) {
    return -1;
  }

  var_2 = spawnStruct();
  var_2.priority = var_0;
  var_2.requesttime = gettime();
  var_2.objid = var_1;
  level.objectiveidpool.active[var_1] = var_2;
  return var_1;
}

function removebestobjectiveid(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectiveidpool.active) {
    if(var_3.priority <= var_0) {
      var_1 = var_3;
    }
  }

  scripts\engine\utility::array_sort_with_func(var_1, &comparepriorityandtime);
  return returnobjectiveid(var_1[0].objid);
}

function comparepriorityandtime(var_0, var_1) {
  if(var_0.priority == var_1.priority) {
    return (var_0.requesttime < var_1.requesttime);
  }

  return var_0.priority < var_1.priority;
}

function getnextobjectiveid(var_0) {
  if(!level.objectiveidpool.reclaimed.size) {
    if(level.objectiveidpool.index == level.objectiveidpool.limit) {
      return -1;
    } else {
      var_1 = level.objectiveidpool.index;
      level.objectiveidpool.index++;
    }
  } else {
    var_1 = level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size - 1];
    level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size - 1] = undefined;
  }

  return var_1;
}

function returnobjectiveid(var_0) {
  if(!isDefined(var_0) || var_0 == -1) {
    return false;
  }

  for(var_1 = 0; var_1 < level.objectiveidpool.reclaimed.size; var_1++) {
    if(var_0 == level.objectiveidpool.reclaimed[var_1]) {
      return false;
    }
  }

  level.objectiveidpool.active[var_0] = undefined;
  level notify("Objective_Delete", var_0);
  objective_delete(var_0);
  level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size] = var_0;
  return true;
}

function returnreservedobjectiveid(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == -1) {
    return false;
  }

  if(istrue(var_1)) {
    level.objectiveidpool.active[var_0] = undefined;
  }

  level notify("Objective_Delete", var_0);
  objective_delete(var_0);
  return true;
}

function objective_add(var_0, var_1, var_2, var_3, var_4) {
  level notify("Objective_Delete", var_0);
  objective_delete(var_0);

  if(isDefined(var_1)) {
    objective_state(var_0, var_1);
  }

  if(isDefined(var_2)) {
    objective_position(var_0, var_2);
  }

  if(isDefined(var_3)) {
    objective_icon(var_0, var_3);
  }

  if(isDefined(var_4)) {
    objective_setminimapiconsize(var_0, var_4);
    return;
  }
}

function objective_add_objective(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == -1) {
    return;
  }

  objective_add(var_0, var_1, var_2, var_3, var_4);
}

function update_objective_ownerteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setownerteam(var_0, var_1);
}

function ref_13FA2(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setownerclient(var_0, var_1);
}

function update_objective_sethot(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_sethot(var_0, var_1);
}

function update_objective_setlabel(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setlabel(var_0, var_1);
}

function update_objective_setfriendlylabel(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setfriendlylabel(var_0, var_1);
}

function update_objective_setenemylabel(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setenemylabel(var_0, var_1);
}

function update_objective_setneutrallabel(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setneutrallabel(var_0, var_1);
}

function update_objective_state(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_state(var_0, var_1);
}

function update_objective_position(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_position(var_0, var_1);
}

function update_objective_icon(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_icon(var_0, var_1);
}

function ref_13FA0(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_reset_mlgicon(var_0, var_1);
}

function ref_13FA1(var_0) {
  if(var_0 == -1) {
    return;
  }

  resetglass(var_0);
}

function update_objective_setbackground(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setbackground(var_0, var_1);
}

function ref_13FA3(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  weaponisrestricted(var_0, var_1);
}

function update_objective_onentity(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_onentity(var_0, var_1);
}

function update_objective_onentitywithrotation(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_onentity(var_0, var_1);
  objective_setrotateonminimap(var_0, 1);
}

function update_objective_setzoffset(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setzoffset(var_0, var_1);
}

function objective_playermask_single(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeallfrommask(var_0);
  objective_addclienttomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

function objective_teammask_single(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeallfrommask(var_0);
  objective_addteamtomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

function ref_11F82(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeallfrommask(var_0);

  foreach(var_3 in var_1) {
    objective_addclienttomask(var_0, var_3);
  }

  objective_showtoplayersinmask(var_0);
}

function objective_playermask_hidefromall(var_0) {
  if(var_0 == -1) {
    return;
  }

  objective_addalltomask(var_0);
  objective_hidefromplayersinmask(var_0);
}

function objective_playermask_hidefrom(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeclientfrommask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

function objective_playermask_addshowplayer(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_showtoplayersinmask(var_0);
  objective_addclienttomask(var_0, var_1);
}

function objective_playermask_showtoall(var_0) {
  if(var_0 == -1) {
    return;
  }

  objective_addalltomask(var_0);
  objective_showtoplayersinmask(var_0);
}

function objective_mask_showtoplayerteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeallfrommask(var_0);

  if(level.teambased) {
    objective_addteamtomask(var_0, var_1.team);
  } else {
    objective_addclienttomask(var_0, var_1);
  }

  objective_showtoplayersinmask(var_0);
}

function objective_mask_showtoenemyteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeallfrommask(var_0);

  if(level.teambased) {
    objective_addteamtomask(var_0, var_1.team);
  } else {
    objective_addclienttomask(var_0, var_1);
  }

  objective_hidefromplayersinmask(var_0);
}

function objective_teammask_addtomask(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_addteamtomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

function objective_teammask_removefrommask(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_removeteamfrommask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

function objective_pin_global(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setpinned(var_0, var_1);
}

function objective_pin_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_pinforteam(var_0, var_1);
}

function objective_unpin_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_unpinforteam(var_0, var_1);
}

function objective_pin_player(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_pinforclient(var_0, var_1);
}

function objective_unpin_player(var_0, var_1, var_2) {
  if(var_0 == -1) {
    return;
  }

  objective_unpinforclient(var_0, var_1);
}

function objective_show_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  if(var_1) {
    level notify("Objective_SetShowProgress", var_0);
  }

  objective_setshowprogress(var_0, var_1);
}

function objective_show_team_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_showprogressforteam(var_0, var_1);
}

function objective_hide_team_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_hideprogressforteam(var_0, var_1);
}

function objective_show_player_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_showprogressforclient(var_0, var_1);
}

function objective_hide_player_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_hideprogressforclient(var_0, var_1);
}

function objective_set_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setprogress(var_0, var_1);
}

function objective_set_progress_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setprogressteam(var_0, var_1);
}

function objective_set_progress_client(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setprogressclient(var_0, var_1);
}

function objective_set_play_intro(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setplayintro(var_0, var_1);
}

function objective_set_play_outro(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setplayoutro(var_0, var_1);
}

function objective_set_pulsate(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setpulsate(var_0, var_1);
}

function ref_11F7D(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setshowformlgspectator(var_0, var_1);
}

function ref_11F84(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  getdediserverguid(var_0, var_1);
}

function objective_show_on_compass(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }

  objective_setshowoncompass(var_0, var_1);
}

function createobjective(var_0, var_1, var_2, var_3, var_4) {
  var_5 = requestobjectiveid(10);

  if(var_5 == -1) {
    return -1;
  }

  objective_add_objective(var_5, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(var_3)) {
    update_objective_position(var_5, self.origin);
  } else if(istrue(var_3) && istrue(var_4)) {
    update_objective_onentitywithrotation(var_5, self);
  } else {
    update_objective_onentity(var_5, self);
  }

  update_objective_state(var_5, "active");
  update_objective_icon(var_5, var_0);
  update_objective_setbackground(var_5, 1);

  if(level.teambased) {
    if(isDefined(var_1)) {
      update_objective_ownerteam(var_5, var_1);
    } else {
      objective_playermask_showtoall(var_5);
    }
  } else if(isDefined(self.owner)) {
    ref_13FA2(var_5, self.owner);
  }

  if(isDefined(level.objvisall)) {
    [[level.objvisall]](var_5);
  }

  return var_5;
}

function createobjective_engineer(var_0, var_1, var_2) {
  var_3 = requestobjectiveid(10);

  if(var_3 == -1) {
    return -1;
  }

  objective_add_objective(var_3, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(var_1)) {
    update_objective_position(var_3, self.origin);
  } else if(istrue(var_1) && istrue(var_2)) {
    update_objective_onentitywithrotation(var_3, self);
  } else {
    update_objective_onentity(var_3, self);
  }

  update_objective_state(var_3, "active");
  update_objective_icon(var_3, var_0);
  update_objective_setbackground(var_3, 1);
  update_objective_ownerteam(var_3, self.team);
  objective_playermask_hidefromall(var_3);
  return var_3;
}