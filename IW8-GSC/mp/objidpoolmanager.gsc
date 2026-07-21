/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\objidpoolmanager.gsc
***********************************************/

init() {
  var_0 = spawnStruct();
  var_0.active = [];
  var_0.reclaimed = [];
  var_0.reserved = [];
  var_0.index = 0;
  var_0.limit = spawncustomweaponscriptable();
  level.objectiveidpool = var_0;
}

requestreservedid(var_0) {
  var_1 = spawnStruct();
  var_1.objid = var_0;
  level.objectiveidpool.active[var_0] = var_1;
  level.objectiveidpool.index++;
  level.objectiveidpool.reserved[level.objectiveidpool.reserved.size] = var_0;
  return var_0;
}

requestobjectiveid(var_0) {
  var_1 = getnextobjectiveid(var_0);

  if(var_1 == -1)
    return -1;

  var_2 = spawnStruct();
  var_2.priority = var_0;
  var_2.requesttime = gettime();
  var_2.objid = var_1;
  level.objectiveidpool.active[var_1] = var_2;
  return var_1;
}

removebestobjectiveid(var_0) {
  var_1 = [];

  foreach(var_3 in level.objectiveidpool.active) {
    if(var_3.priority <= var_0)
      var_1[var_1.size] = var_3;
  }

  scripts\engine\utility::array_sort_with_func(var_1, ::comparepriorityandtime);
  return returnobjectiveid(var_1[0].objid);
}

comparepriorityandtime(var_0, var_1) {
  if(var_0.priority == var_1.priority)
    return var_0.requesttime < var_1.requesttime;
  else
    return var_0.priority < var_1.priority;
}

getnextobjectiveid(var_0) {
  if(!level.objectiveidpool.reclaimed.size) {
    if(level.objectiveidpool.index == level.objectiveidpool.limit)
      return -1;
    else {
      var_1 = level.objectiveidpool.index;
      level.objectiveidpool.index++;
    }
  } else {
    var_1 = level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size - 1];
    level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size - 1] = undefined;
  }

  return var_1;
}

returnobjectiveid(var_0) {
  if(!isDefined(var_0) || var_0 == -1)
    return 0;

  for(var_1 = 0; var_1 < level.objectiveidpool.reclaimed.size; var_1++) {
    if(var_0 == level.objectiveidpool.reclaimed[var_1])
      return 0;
  }

  level.objectiveidpool.active[var_0] = undefined;
  level notify("_encstr_84A7116416FAB826DB07457BC7807DB88DEBA9", var_0);
  objective_delete(var_0);
  level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size] = var_0;
  return 1;
}

returnreservedobjectiveid(var_0, var_1) {
  if(!isDefined(var_0) || var_0 == -1)
    return 0;

  if(istrue(var_1))
    level.objectiveidpool.active[var_0] = undefined;

  level notify("_encstr_84A7116416FAB826DB07457BC7807DB88DEBA9", var_0);
  objective_delete(var_0);
  return 1;
}

objective_add(var_0, var_1, var_2, var_3, var_4) {
  level notify("_encstr_84A7116416FAB826DB07457BC7807DB88DEBA9", var_0);
  objective_delete(var_0);

  if(isDefined(var_1))
    objective_state(var_0, var_1);

  if(isDefined(var_2))
    objective_position(var_0, var_2);

  if(isDefined(var_3))
    objective_icon(var_0, var_3);

  if(isDefined(var_4))
    objective_setminimapiconsize(var_0, var_4);
}

objective_add_objective(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == -1) {
    return;
  }
  objective_add(var_0, var_1, var_2, var_3, var_4);
}

update_objective_ownerteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setownerteam(var_0, var_1);
}

_id_13FA2(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setownerclient(var_0, var_1);
}

update_objective_sethot(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_sethot(var_0, var_1);
}

_encstr_BA771A3891F5B998223770208D42BB03981B3D161EEF1BBDE93DA28B(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setlabel(var_0, var_1);
}

update_objective_setfriendlylabel(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setfriendlylabel(var_0, var_1);
}

update_objective_setenemylabel(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setenemylabel(var_0, var_1);
}

update_objective_setneutrallabel(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setneutrallabel(var_0, var_1);
}

update_objective_state(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_state(var_0, var_1);
}

update_objective_position(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_position(var_0, var_1);
}

update_objective_icon(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_icon(var_0, var_1);
}

_id_13FA0(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_reset_mlgicon(var_0, var_1);
}

_id_13FA1(var_0) {
  if(var_0 == -1) {
    return;
  }
  resetglass(var_0);
}

update_objective_setbackground(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setbackground(var_0, var_1);
}

_id_13FA3(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  weaponisrestricted(var_0, var_1);
}

update_objective_onentity(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_onentity(var_0, var_1);
}

update_objective_onentitywithrotation(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_onentity(var_0, var_1);
  objective_setrotateonminimap(var_0, 1);
}

update_objective_setzoffset(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setzoffset(var_0, var_1);
}

objective_playermask_single(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeallfrommask(var_0);
  objective_addclienttomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

objective_teammask_single(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeallfrommask(var_0);
  objective_addteamtomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

_id_11F82(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeallfrommask(var_0);

  foreach(var_3 in var_1)
  objective_addclienttomask(var_0, var_3);

  objective_showtoplayersinmask(var_0);
}

objective_playermask_hidefromall(var_0) {
  if(var_0 == -1) {
    return;
  }
  objective_addalltomask(var_0);
  objective_hidefromplayersinmask(var_0);
}

objective_playermask_hidefrom(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeclientfrommask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

objective_playermask_addshowplayer(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_showtoplayersinmask(var_0);
  objective_addclienttomask(var_0, var_1);
}

objective_playermask_showtoall(var_0) {
  if(var_0 == -1) {
    return;
  }
  objective_addalltomask(var_0);
  objective_showtoplayersinmask(var_0);
}

objective_mask_showtoplayerteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeallfrommask(var_0);

  if(level.teambased)
    objective_addteamtomask(var_0, var_1.team);
  else
    objective_addclienttomask(var_0, var_1);

  objective_showtoplayersinmask(var_0);
}

objective_mask_showtoenemyteam(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeallfrommask(var_0);

  if(level.teambased)
    objective_addteamtomask(var_0, var_1.team);
  else
    objective_addclienttomask(var_0, var_1);

  objective_hidefromplayersinmask(var_0);
}

objective_teammask_addtomask(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_addteamtomask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

objective_teammask_removefrommask(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_removeteamfrommask(var_0, var_1);
  objective_showtoplayersinmask(var_0);
}

objective_pin_global(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setpinned(var_0, var_1);
}

objective_pin_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_pinforteam(var_0, var_1);
}

objective_unpin_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_unpinforteam(var_0, var_1);
}

objective_pin_player(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_pinforclient(var_0, var_1);
}

objective_unpin_player(var_0, var_1, var_2) {
  if(var_0 == -1) {
    return;
  }
  objective_unpinforclient(var_0, var_1);
}

objective_show_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  if(var_1)
    level notify("_encstr_96D71AFD50D25FA1CD01A5982FAAB08BE703384C635A50A426F3186E", var_0);

  objective_setshowprogress(var_0, var_1);
}

objective_show_team_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_showprogressforteam(var_0, var_1);
}

objective_hide_team_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_hideprogressforteam(var_0, var_1);
}

objective_show_player_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_showprogressforclient(var_0, var_1);
}

objective_hide_player_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_hideprogressforclient(var_0, var_1);
}

objective_set_progress(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setprogress(var_0, var_1);
}

objective_set_progress_team(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setprogressteam(var_0, var_1);
}

objective_set_progress_client(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setprogressclient(var_0, var_1);
}

objective_set_play_intro(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setplayintro(var_0, var_1);
}

objective_set_play_outro(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setplayoutro(var_0, var_1);
}

objective_set_pulsate(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setpulsate(var_0, var_1);
}

_id_11F7D(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setshowformlgspectator(var_0, var_1);
}

_id_11F84(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  getdediserverguid(var_0, var_1);
}

_encstr_81C01ADE134D951BD1B43BACBEB90DBDDD7DB79BF5D8DBB51C58DCE6(var_0, var_1) {
  if(var_0 == -1) {
    return;
  }
  objective_setshowoncompass(var_0, var_1);
}

createobjective(var_0, var_1, var_2, var_3, var_4) {
  var_5 = requestobjectiveid(10);

  if(var_5 == -1)
    return -1;

  objective_add_objective(var_5, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(var_3))
    update_objective_position(var_5, self.origin);
  else if(istrue(var_3) && istrue(var_4))
    update_objective_onentitywithrotation(var_5, self);
  else
    update_objective_onentity(var_5, self);

  update_objective_state(var_5, "_encstr_930B07BB1B6B3854FF");
  update_objective_icon(var_5, var_0);
  update_objective_setbackground(var_5, 1);

  if(level.teambased) {
    if(isDefined(var_1))
      update_objective_ownerteam(var_5, var_1);
    else
      objective_playermask_showtoall(var_5);
  } else if(isDefined(self.owner))
    _id_13FA2(var_5, self.owner);

  if(isDefined(level.objvisall))
    [[level.objvisall]](var_5);

  return var_5;
}

createobjective_engineer(var_0, var_1, var_2) {
  var_3 = requestobjectiveid(10);

  if(var_3 == -1)
    return -1;

  objective_add_objective(var_3, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(var_1))
    update_objective_position(var_3, self.origin);
  else if(istrue(var_1) && istrue(var_2))
    update_objective_onentitywithrotation(var_3, self);
  else
    update_objective_onentity(var_3, self);

  update_objective_state(var_3, "_encstr_930B07BB1B6B3854FF");
  update_objective_icon(var_3, var_0);
  update_objective_setbackground(var_3, 1);
  update_objective_ownerteam(var_3, self.team);
  objective_playermask_hidefromall(var_3);
  return var_3;
}