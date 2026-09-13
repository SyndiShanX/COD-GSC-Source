/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\objidpoolmanager.gsc
***********************************************/

init() {
  objectiveidpool = spawnStruct();
  objectiveidpool.active = [];
  objectiveidpool.reclaimed = [];
  objectiveidpool.reserved = [];
  objectiveidpool.index = 0;
  objectiveidpool.limit = getmaxobjectivecount();
  level.objectiveidpool = objectiveidpool;
}

requestreservedid(objid) {
  if(!isDefined(objid) || objid == -1) {
    objid = getnextobjectiveid(100);

    if(objid == -1)
      return -1;
  } else
    level.objectiveidpool.index++;

  _id_F90358454413407F = spawnStruct();
  _id_F90358454413407F.priority = 100;
  _id_F90358454413407F.requesttime = gettime();
  _id_F90358454413407F.objid = objid;
  level.objectiveidpool.active[objid] = _id_F90358454413407F;
  level.objectiveidpool.reserved[level.objectiveidpool.reserved.size] = objid;
  return objid;
}

requestobjectiveid(priority) {
  objid = getnextobjectiveid(priority);

  if(!isDefined(objid) || objid == -1)
    return -1;

  _id_F90358454413407F = spawnStruct();
  _id_F90358454413407F.priority = priority;
  _id_F90358454413407F.requesttime = gettime();
  _id_F90358454413407F.objid = objid;
  level.objectiveidpool.active[objid] = _id_F90358454413407F;
  return objid;
}

removebestobjectiveid(_id_C9AB80F262282DC9) {
  _id_124225617CFE6887 = [];

  foreach(objid in level.objectiveidpool.active) {
    if(scripts\engine\utility::array_contains(level.objectiveidpool.reserved, objid)) {
      continue;
    }
    if(objid.priority <= _id_C9AB80F262282DC9)
      _id_124225617CFE6887[_id_124225617CFE6887.size] = objid;
  }

  scripts\engine\utility::array_sort_with_func(_id_124225617CFE6887, ::comparepriorityandtime);
  return returnobjectiveid(_id_124225617CFE6887[0].objid);
}

comparepriorityandtime(a, b) {
  if(a.priority == b.priority)
    return a.requesttime < b.requesttime;
  else
    return a.priority < b.priority;
}

getnextobjectiveid(priority) {
  if(level.objectiveidpool.reclaimed.size == 0) {
    if(level.objectiveidpool.index >= level.objectiveidpool.limit)
      return -1;
    else {
      nextid = level.objectiveidpool.index;
      level.objectiveidpool.index++;

      if(level.objectiveidpool.index >= level.objectiveidpool.limit)
        level.objectiveidpool.index = level.objectiveidpool.limit - 1;
    }
  } else {
    nextid = level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size - 1];
    level.objectiveidpool.reclaimed = scripts\engine\utility::array_remove_index(level.objectiveidpool.reclaimed, level.objectiveidpool.reclaimed.size - 1);
  }

  return nextid;
}

returnobjectiveid(objid) {
  if(!isDefined(objid) || objid == -1)
    return 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.objectiveidpool.reclaimed.size; _id_AC0E594AC96AA3A8++) {
    if(objid == level.objectiveidpool.reclaimed[_id_AC0E594AC96AA3A8])
      return 0;
  }

  level.objectiveidpool.active = scripts\engine\utility::array_remove_key(level.objectiveidpool.active, objid);
  level notify("Objective_Delete", objid);
  objective_delete(objid);
  level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size] = objid;
  return 1;
}

returnreservedobjectiveid(objid, _id_301EC764DD09B364) {
  if(!isDefined(objid) || objid == -1)
    return 0;

  if(istrue(_id_301EC764DD09B364))
    level.objectiveidpool.active[objid] = undefined;

  level notify("Objective_Delete", objid);
  objective_delete(objid);
  return 1;
}

objective_add(_id_780627589B4BB0B5, state, position, iconname, iconsize) {
  level notify("Objective_Delete", _id_780627589B4BB0B5);
  objective_delete(_id_780627589B4BB0B5);

  if(isDefined(state))
    objective_state(_id_780627589B4BB0B5, state);

  if(isDefined(position))
    objective_position(_id_780627589B4BB0B5, position);

  if(isDefined(iconname))
    objective_icon(_id_780627589B4BB0B5, iconname);

  if(isDefined(iconsize))
    objective_setminimapiconsize(_id_780627589B4BB0B5, iconsize);
}

objective_add_objective(objid, state, position, _id_2EAF3F31852684FD, iconsize) {
  if(objid == -1) {
    return;
  }
  objective_add(objid, state, position, _id_2EAF3F31852684FD, iconsize);
}

update_objective_ownerteam(objid, ownerteam) {
  if(objid == -1) {
    return;
  }
  objective_setownerteam(objid, ownerteam);
}

update_objective_ownerclient(objid, owner) {
  if(objid == -1) {
    return;
  }
  objective_setownerclient(objid, owner);
}

update_objective_sethot(objid, ownerteam) {
  if(objid == -1) {
    return;
  }
  objective_sethot(objid, ownerteam);
}

update_objective_setfriendlylabel(objid, stringref) {
  if(objid == -1) {
    return;
  }
  objective_setfriendlylabel(objid, stringref);
}

update_objective_setenemylabel(objid, stringref) {
  if(objid == -1) {
    return;
  }
  objective_setenemylabel(objid, stringref);
}

update_objective_setneutrallabel(objid, stringref) {
  if(objid == -1) {
    return;
  }
  objective_setneutrallabel(objid, stringref);
}

update_objective_state(objid, state) {
  if(objid == -1) {
    return;
  }
  objective_state(objid, state);
}

update_objective_position(objid, position) {
  if(objid == -1) {
    return;
  }
  objective_position(objid, position);
}

update_objective_icon(objid, _id_2EAF3F31852684FD) {
  if(objid == -1) {
    return;
  }
  objective_icon(objid, _id_2EAF3F31852684FD);
}

_id_2946E9EB07ACB3F1(objid, description) {
  if(objid == -1) {
    return;
  }
  objective_setdescription(objid, description);
}

_id_C3C6BFF089DFDD34(objid, iconsize) {
  if(objid == -1) {
    return;
  }
  if(isDefined(iconsize))
    objective_setminimapiconsize(objid, iconsize);
}

_id_79A1A16DE6B22B2D(objid, _id_2EAF3F31852684FD) {
  if(objid == -1) {
    return;
  }
  _func_18B16CD8DEF5E879(objid, _id_2EAF3F31852684FD);
}

_id_56FC9B5845892619(objid) {
  if(objid == -1) {
    return;
  }
  _func_CDAB88BA2CE79251(objid);
}

update_objective_setbackground(objid, type) {
  if(objid == -1) {
    return;
  }
  objective_setbackground(objid, type);
}

update_objective_onentity(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_onentity(objid, ent);
}

update_objective_onentitywithrotation(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_onentity(objid, ent);
  objective_setrotateonminimap(objid, 1);
}

update_objective_setzoffset(objid, offset) {
  if(objid == -1) {
    return;
  }
  objective_setzoffset(objid, offset);
}

_id_9CAD42AC02EFF950(objid) {
  if(objid == -1) {
    return;
  }
  objective_removeallfrommask(objid);
}

_id_A28E8535E00D34F3(objid) {
  if(objid == -1) {
    return;
  }
  objective_addalltomask(objid);
}

_id_6AE37618BB04EA60(objid) {
  if(objid == -1) {
    return;
  }
  objective_showtoplayersinmask(objid);
}

_id_17DB39BD195CC5B1(objid) {
  if(objid == -1) {
    return;
  }
  objective_hidefromplayersinmask(objid);
}

objective_playermask_single(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_removeallfrommask(objid);
  objective_addclienttomask(objid, ent);
  objective_showtoplayersinmask(objid);
}

objective_teammask_single(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_removeallfrommask(objid);
  objective_addteamtomask(objid, team);
  objective_showtoplayersinmask(objid);
}

objective_playermask_hidefromall(objid) {
  if(objid == -1) {
    return;
  }
  objective_addalltomask(objid);
  objective_hidefromplayersinmask(objid);
}

objective_playermask_hidefrom(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_removeclientfrommask(objid, ent);
  objective_showtoplayersinmask(objid);
}

objective_playermask_addshowplayer(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_addclienttomask(objid, ent);
  objective_showtoplayersinmask(objid);
}

objective_playermask_showtoall(objid) {
  if(objid == -1) {
    return;
  }
  objective_addalltomask(objid);
  objective_showtoplayersinmask(objid);
}

objective_mask_showtoplayerteam(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_removeallfrommask(objid);
  objective_addteamtomask(objid, ent.team);
  objective_showtoplayersinmask(objid);
}

_id_39F2DC4E92DB5FB9(objid, ent) {
  if(objid == -1) {
    return;
  }
  if(!isDefined(ent.owner)) {
    return;
  }
  objective_removeallfrommask(objid);
  objective_addclienttomask(objid, ent.owner);
  objective_showtoplayersinmask(objid);
}

objective_mask_showtoenemyteam(objid, ent) {
  if(objid == -1) {
    return;
  }
  objective_removeallfrommask(objid);

  if(level.teambased)
    objective_addteamtomask(objid, ent.team);
  else
    objective_addclienttomask(objid, ent);

  objective_hidefromplayersinmask(objid);
}

objective_teammask_addtomask(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_addteamtomask(objid, team);
  objective_showtoplayersinmask(objid);
}

objective_teammask_removefrommask(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_removeteamfrommask(objid, team);
  objective_showtoplayersinmask(objid);
}

objective_pin_global(objid, _id_B1FCB60302CFC360) {
  if(objid == -1) {
    return;
  }
  objective_setpinned(objid, _id_B1FCB60302CFC360);
}

objective_pin_team(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_pinforteam(objid, team);
}

objective_unpin_team(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_unpinforteam(objid, team);
}

objective_pin_player(objid, player) {
  if(objid == -1) {
    return;
  }
  objective_pinforclient(objid, player);
}

objective_unpin_player(objid, player, showoncompass) {
  if(objid == -1) {
    return;
  }
  objective_unpinforclient(objid, player);
}

objective_show_progress(objid, show, _id_800EE8521AA9CF8B, _id_44852CD9CC3E5ABA) {
  if(!istrue(_id_44852CD9CC3E5ABA)) {
    if(getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm")
      show = 0;
  }

  if(objid == -1) {
    return;
  }
  if(show && !istrue(_id_800EE8521AA9CF8B))
    level notify("Objective_SetShowProgress", objid);

  objective_setshowprogress(objid, show);
}

_id_7299A742781A5030(state, player) {
  _func_D1B64C3D055CEEB0(state, player);
}

_id_8F7A55BDA12EBB21(text, player) {
  _func_8B71EB96E1636EDC(text, player);
}

objective_show_team_progress(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_showprogressforteam(objid, team);
}

objective_hide_team_progress(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_hideprogressforteam(objid, team);
}

objective_show_player_progress(objid, player) {
  if(objid == -1) {
    return;
  }
  objective_showprogressforclient(objid, player);
}

objective_hide_player_progress(objid, player) {
  if(objid == -1) {
    return;
  }
  objective_hideprogressforclient(objid, player);
}

objective_set_show_progress(objid, _id_5F0AF647D1F3BA6B) {
  if(!isDefined(objid) || objid == -1) {
    return;
  }
  objective_setshowprogress(objid, _id_5F0AF647D1F3BA6B);
}

objective_set_progress(objid, progress) {
  if(objid == -1) {
    return;
  }
  objective_setprogress(objid, progress);
}

objective_set_progress_team(objid, team) {
  if(objid == -1) {
    return;
  }
  objective_setprogressteam(objid, team);
}

_id_9B1A086F348520B0(objid, team) {
  if(objid == -1) {
    return;
  }
  _func_97B31127037043B6(objid, team);
}

objective_set_progress_client(objid, player) {
  if(objid == -1) {
    return;
  }
  objective_setprogressclient(objid, player);
}

objective_set_play_intro(objid, show) {
  if(objid == -1) {
    return;
  }
  objective_setplayintro(objid, show);
}

objective_set_play_outro(objid, show) {
  if(objid == -1) {
    return;
  }
  objective_setplayoutro(objid, show);
}

objective_set_pulsate(objid, pulse) {
  if(objid == -1) {
    return;
  }
  objective_setpulsate(objid, pulse);
}

objective_hide_for_mlg_spectator(objid, show) {
  if(objid == -1) {
    return;
  }
  objective_sethideformlgspectator(objid, show);
}

objective_show_for_mlg_spectator(objid, show) {
  if(objid == -1) {
    return;
  }
  objective_setshowformlgspectator(objid, show);
}

_id_D7E3C4A08682C1B9(objid, show) {
  if(objid == -1) {
    return;
  }
  _func_865F9C5D005F9A08(objid, show);
}

_id_EE37484CA9BDC744(objid, show) {
  if(objid == -1) {
    return;
  }
  _func_9427CB5974C925D9(self.objidnum, show);
}

_id_BF66C6833E867284(objid, type) {
  if(objid == -1) {
    return;
  }
  _func_A13E72E0427ECAD2(objid, type);
}

createobjective(shadername, team, _id_7A8AF4BFBA6333A4, _id_2231E5A0F940CAAE, _id_DBE22CD5D2A797AF, iconsize) {
  curobjid = requestobjectiveid(10);

  if(curobjid == -1)
    return -1;

  objective_add_objective(curobjid, "invisible", (0, 0, 0));

  if((!isent(self) || !isDefined(self getlinkedparent())) && !istrue(_id_2231E5A0F940CAAE))
    update_objective_position(curobjid, self.origin);
  else if(istrue(_id_2231E5A0F940CAAE) && istrue(_id_DBE22CD5D2A797AF))
    update_objective_onentitywithrotation(curobjid, self);
  else
    update_objective_onentity(curobjid, self);

  update_objective_state(curobjid, "active");
  update_objective_icon(curobjid, shadername);
  update_objective_setbackground(curobjid, 1);
  _id_C3C6BFF089DFDD34(curobjid, iconsize);

  if(level.teambased) {
    if(isDefined(team))
      update_objective_ownerteam(curobjid, team);
  } else if(isDefined(self.owner))
    update_objective_ownerclient(curobjid, self.owner);

  if(istrue(_id_7A8AF4BFBA6333A4)) {
    if(level.teambased)
      objective_mask_showtoplayerteam(curobjid, self);
    else
      _id_39F2DC4E92DB5FB9(curobjid, self);
  } else
    objective_playermask_showtoall(curobjid);

  if(istrue(level.objvisall))
    objective_playermask_showtoall(curobjid);

  return curobjid;
}

createobjective_engineer(shadername, _id_2231E5A0F940CAAE, _id_DBE22CD5D2A797AF, iconsize) {
  curobjid = requestobjectiveid(10);

  if(curobjid == -1)
    return -1;

  objective_add_objective(curobjid, "invisible", (0, 0, 0));

  if(!isDefined(self getlinkedparent()) && !istrue(_id_2231E5A0F940CAAE))
    update_objective_position(curobjid, self.origin);
  else if(istrue(_id_2231E5A0F940CAAE) && istrue(_id_DBE22CD5D2A797AF))
    update_objective_onentitywithrotation(curobjid, self);
  else
    update_objective_onentity(curobjid, self);

  update_objective_state(curobjid, "active");
  update_objective_icon(curobjid, shadername);
  update_objective_setbackground(curobjid, 1);
  _id_C3C6BFF089DFDD34(curobjid, iconsize);
  update_objective_ownerteam(curobjid, self.team);
  objective_playermask_hidefromall(curobjid);
  return curobjid;
}

_id_160F522B63C32D76(_id_09341B600731439C, text, _id_5C9DDCF56D36F133) {
  if(getdvarint("dvar_141DE4492226006E", 1) == 1) {
    if(isDefined(_id_5C9DDCF56D36F133)) {}

    _id_7299A742781A5030(_id_09341B600731439C, self);

    if(isDefined(text))
      _id_8F7A55BDA12EBB21(text, self);
  } else
    self setclientomnvar("ui_objective_pinned_text_param", _id_5C9DDCF56D36F133);
}

_id_CE702E5925E31FC9(objid, player, priority, state, text) {
  if(objid == -1) {
    return;
  }
  if(!isDefined(player._id_9D9B6C132375D54C))
    player._id_9D9B6C132375D54C = 0;

  if(player._id_9D9B6C132375D54C < priority) {
    player._id_9D9B6C132375D54C = priority;
    objective_show_player_progress(objid, player);
    _id_8F7A55BDA12EBB21(text, player);
    _id_7299A742781A5030(state, player);
    return 1;
  } else
    return 0;
}

_id_26259BD38697B5AD(objid, player) {
  if(objid == -1 || !isDefined(player)) {
    return;
  }
  player._id_9D9B6C132375D54C = 0;
  objective_hide_player_progress(objid, player);
  _id_7299A742781A5030(0, player);
}

_id_098BA077848896A3(objid, _id_BD7E56573C70F3DB) {
  if(objid == -1) {
    return;
  }
  objective_setshowdistance(objid, _id_BD7E56573C70F3DB);
}

_id_F21E9B2E78DE984B(objid, _id_A7C6C5D6C3D369AA, _id_0467F4D9B8D9063B) {
  if(objid == -1) {
    return;
  }
  _func_C047D7FFE7A83501(objid, _id_A7C6C5D6C3D369AA, _id_0467F4D9B8D9063B);
}

_id_41F90376AB869B9F(objid, _id_7449E9A013A1A596) {
  if(objid == -1) {
    return;
  }
  objective_sethideelevation(objid, _id_7449E9A013A1A596);
}