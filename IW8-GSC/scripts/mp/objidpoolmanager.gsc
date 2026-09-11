/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\objidpoolmanager.gsc
***********************************************/

function init() {
  var0 = spawnStruct();
  var0.active = [];
  var0.reclaimed = [];
  var0.reserved = [];
  var0.index = 0;
  var0.limit = spawncustomweaponscriptable();
  level.objectiveidpool = var0;
}

function requestreservedid(var0) {
  var1 = spawnStruct();
  var1.objid = var0;
  level.objectiveidpool.active[var0] = var1;
  level.objectiveidpool.index++;
  level.objectiveidpool.reserved[level.objectiveidpool.reserved.size] = var0;
  return var0;
}

function requestobjectiveid(var0) {
  var1 = getnextobjectiveid(var0);

  if(var1 == -1) {
    return -1;
  }

  var2 = spawnStruct();
  var2.priority = var0;
  var2.requesttime = gettime();
  var2.objid = var1;
  level.objectiveidpool.active[var1] = var2;
  return var1;
}

function removebestobjectiveid(var0) {
  var1 = [];

  foreach(var3 in level.objectiveidpool.active) {
    if(var3.priority <= var0) {
      var1 = var3;
    }
  }

  scripts\engine\utility::array_sort_with_func(var1, &comparepriorityandtime);
  return returnobjectiveid(var1[0].objid);
}

function comparepriorityandtime(var0, var1) {
  if(var0.priority == var1.priority) {
    return (var0.requesttime < var1.requesttime);
  }

  return var0.priority < var1.priority;
}

function getnextobjectiveid(var0) {
  if(!level.objectiveidpool.reclaimed.size) {
    if(level.objectiveidpool.index == level.objectiveidpool.limit) {
      return -1;
    } else {
      var1 = level.objectiveidpool.index;
      level.objectiveidpool.index++;
    }
  } else {
    var1 = level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size - 1];
    level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size - 1] = undefined;
  }

  return var1;
}

function returnobjectiveid(var0) {
  if(!isDefined(var0) || var0 == -1) {
    return false;
  }

  for(var1 = 0; var1 < level.objectiveidpool.reclaimed.size; var1++) {
    if(var0 == level.objectiveidpool.reclaimed[var1]) {
      return false;
    }
  }

  level.objectiveidpool.active[var0] = undefined;
  level notify("Objective_Delete", var0);
  objective_delete(var0);
  level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size] = var0;
  return true;
}

function returnreservedobjectiveid(var0, var1) {
  if(!isDefined(var0) || var0 == -1) {
    return false;
  }

  if(istrue(var1)) {
    level.objectiveidpool.active[var0] = undefined;
  }

  level notify("Objective_Delete", var0);
  objective_delete(var0);
  return true;
}

function objective_add(var0, var1, var2, var3, var4) {
  level notify("Objective_Delete", var0);
  objective_delete(var0);

  if(isDefined(var1)) {
    objective_state(var0, var1);
  }

  if(isDefined(var2)) {
    objective_position(var0, var2);
  }

  if(isDefined(var3)) {
    objective_icon(var0, var3);
  }

  if(isDefined(var4)) {
    objective_setminimapiconsize(var0, var4);
    return;
  }
}

function objective_add_objective(var0, var1, var2, var3, var4) {
  if(var0 == -1) {
    return;
  }

  objective_add(var0, var1, var2, var3, var4);
}

function update_objective_ownerteam(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setownerteam(var0, var1);
}

function ref_13fa2(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setownerclient(var0, var1);
}

function update_objective_sethot(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_sethot(var0, var1);
}

function update_objective_setlabel(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setlabel(var0, var1);
}

function update_objective_setfriendlylabel(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setfriendlylabel(var0, var1);
}

function update_objective_setenemylabel(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setenemylabel(var0, var1);
}

function update_objective_setneutrallabel(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setneutrallabel(var0, var1);
}

function update_objective_state(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_state(var0, var1);
}

function update_objective_position(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_position(var0, var1);
}

function update_objective_icon(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_icon(var0, var1);
}

function ref_13fa0(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_reset_mlgicon(var0, var1);
}

function ref_13fa1(var0) {
  if(var0 == -1) {
    return;
  }

  resetglass(var0);
}

function update_objective_setbackground(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setbackground(var0, var1);
}

function ref_13fa3(var0, var1) {
  if(var0 == -1) {
    return;
  }

  weaponisrestricted(var0, var1);
}

function update_objective_onentity(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_onentity(var0, var1);
}

function update_objective_onentitywithrotation(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_onentity(var0, var1);
  objective_setrotateonminimap(var0, 1);
}

function update_objective_setzoffset(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setzoffset(var0, var1);
}

function objective_playermask_single(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeallfrommask(var0);
  objective_addclienttomask(var0, var1);
  objective_showtoplayersinmask(var0);
}

function objective_teammask_single(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeallfrommask(var0);
  objective_addteamtomask(var0, var1);
  objective_showtoplayersinmask(var0);
}

function ref_11f82(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeallfrommask(var0);

  foreach(var3 in var1) {
    objective_addclienttomask(var0, var3);
  }

  objective_showtoplayersinmask(var0);
}

function objective_playermask_hidefromall(var0) {
  if(var0 == -1) {
    return;
  }

  objective_addalltomask(var0);
  objective_hidefromplayersinmask(var0);
}

function objective_playermask_hidefrom(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeclientfrommask(var0, var1);
  objective_showtoplayersinmask(var0);
}

function objective_playermask_addshowplayer(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_showtoplayersinmask(var0);
  objective_addclienttomask(var0, var1);
}

function objective_playermask_showtoall(var0) {
  if(var0 == -1) {
    return;
  }

  objective_addalltomask(var0);
  objective_showtoplayersinmask(var0);
}

function objective_mask_showtoplayerteam(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeallfrommask(var0);

  if(level.teambased) {
    objective_addteamtomask(var0, var1.team);
  } else {
    objective_addclienttomask(var0, var1);
  }

  objective_showtoplayersinmask(var0);
}

function objective_mask_showtoenemyteam(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeallfrommask(var0);

  if(level.teambased) {
    objective_addteamtomask(var0, var1.team);
  } else {
    objective_addclienttomask(var0, var1);
  }

  objective_hidefromplayersinmask(var0);
}

function objective_teammask_addtomask(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_addteamtomask(var0, var1);
  objective_showtoplayersinmask(var0);
}

function objective_teammask_removefrommask(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_removeteamfrommask(var0, var1);
  objective_showtoplayersinmask(var0);
}

function objective_pin_global(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setpinned(var0, var1);
}

function objective_pin_team(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_pinforteam(var0, var1);
}

function objective_unpin_team(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_unpinforteam(var0, var1);
}

function objective_pin_player(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_pinforclient(var0, var1);
}

function objective_unpin_player(var0, var1, var2) {
  if(var0 == -1) {
    return;
  }

  objective_unpinforclient(var0, var1);
}

function objective_show_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  if(var1) {
    level notify("Objective_SetShowProgress", var0);
  }

  objective_setshowprogress(var0, var1);
}

function objective_show_team_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_showprogressforteam(var0, var1);
}

function objective_hide_team_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_hideprogressforteam(var0, var1);
}

function objective_show_player_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_showprogressforclient(var0, var1);
}

function objective_hide_player_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_hideprogressforclient(var0, var1);
}

function objective_set_progress(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setprogress(var0, var1);
}

function objective_set_progress_team(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setprogressteam(var0, var1);
}

function objective_set_progress_client(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setprogressclient(var0, var1);
}

function objective_set_play_intro(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setplayintro(var0, var1);
}

function objective_set_play_outro(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setplayoutro(var0, var1);
}

function objective_set_pulsate(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setpulsate(var0, var1);
}

function ref_11f7d(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setshowformlgspectator(var0, var1);
}

function ref_11f84(var0, var1) {
  if(var0 == -1) {
    return;
  }

  getdediserverguid(var0, var1);
}

function objective_show_on_compass(var0, var1) {
  if(var0 == -1) {
    return;
  }

  objective_setshowoncompass(var0, var1);
}

function createobjective(var0, var1, var2, var3, var4) {
  var5 = requestobjectiveid(10);

  if(var5 == -1) {
    return -1;
  }

  objective_add_objective(var5, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(var3)) {
    update_objective_position(var5, self.origin);
  } else if(istrue(var3) && istrue(var4)) {
    update_objective_onentitywithrotation(var5, self);
  } else {
    update_objective_onentity(var5, self);
  }

  update_objective_state(var5, "active");
  update_objective_icon(var5, var0);
  update_objective_setbackground(var5, 1);

  if(level.teambased) {
    if(isDefined(var1)) {
      update_objective_ownerteam(var5, var1);
    } else {
      objective_playermask_showtoall(var5);
    }
  } else if(isDefined(self.owner)) {
    ref_13fa2(var5, self.owner);
  }

  if(isDefined(level.objvisall)) {
    [[level.objvisall]](var5);
  }

  return var5;
}

function createobjective_engineer(var0, var1, var2) {
  var3 = requestobjectiveid(10);

  if(var3 == -1) {
    return -1;
  }

  objective_add_objective(var3, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(var1)) {
    update_objective_position(var3, self.origin);
  } else if(istrue(var1) && istrue(var2)) {
    update_objective_onentitywithrotation(var3, self);
  } else {
    update_objective_onentity(var3, self);
  }

  update_objective_state(var3, "active");
  update_objective_icon(var3, var0);
  update_objective_setbackground(var3, 1);
  update_objective_ownerteam(var3, self.team);
  objective_playermask_hidefromall(var3);
  return var3;
}