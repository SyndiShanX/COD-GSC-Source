/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\objidpoolmanager.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace objidpoolmanager;

function init() {
  objectiveidpool = spawnStruct();
  objectiveidpool.active = [];
  objectiveidpool.reclaimed = [];
  objectiveidpool.reserved = [];
  objectiveidpool.index = 0;
  objectiveidpool.limit = getmaxobjectivecount();
  level.objectiveidpool = objectiveidpool;
  level.var_9977f6e10514d7ce = [];
  utility::flag_set("objidpoolmanager_initialized");
}

function requestreservedid(objid) {
  if(objective_isunlimited()) {
    if(!isDefined(objid) || objid == -1) {
      objid = level.var_9977f6e10514d7ce.size;
    }

    return function_be6060bf8a6e12c2(objid);
  }

  if(!isDefined(objid) || objid == -1) {
    objid = getnextobjectiveid(100);

    if(objid == -1) {
      return -1;
    }
  } else if(!isDefined(level.objectiveidpool.active[objid])) {
    level.objectiveidpool.index++;
  }

  entry = spawnStruct();
  entry.priority = 100;
  entry.requesttime = gettime();
  entry.objid = objid;
  level.objectiveidpool.active[objid] = entry;
  level.objectiveidpool.reserved[level.objectiveidpool.reserved.size] = objid;
  return objid;
}

function requestobjectiveid(priority) {
  objid = getnextobjectiveid(priority);

  if(!isDefined(objid) || objid == -1) {
    return -1;
  }

  entry = spawnStruct();
  entry.priority = priority;
  entry.requesttime = gettime();
  entry.objid = objid;
  level.objectiveidpool.active[objid] = entry;
  return objid;
}

function function_92a696fa5918eca5(objid) {
  if(!objective_isunlimited()) {
    return objid;
  }

  assert(isDefined(level.var_9977f6e10514d7ce[objid]));
  return level.var_9977f6e10514d7ce[objid].objid;
}

function function_b29f91f1fb14e113(var_5c3b190b45db5f37) {
  if(objective_isunlimited()) {
    for(i = level.var_9977f6e10514d7ce.size; i < var_5c3b190b45db5f37 + 1; i++) {
      entry = function_7e41a40db70e23b9();
      level.var_9977f6e10514d7ce[i] = entry;
    }
  }
}

function removebestobjectiveid(prioritymax) {
  query = [];

  foreach(objid in level.objectiveidpool.active) {
    if(array_contains(level.objectiveidpool.reserved, objid)) {
      continue;
    }

    if(objid.priority <= prioritymax) {
      query[query.size] = objid;
    }
  }

  array_sort_with_func(query, &comparepriorityandtime);
  return returnobjectiveid(query[0].objid);
}

function comparepriorityandtime(a, b) {
  if(a.priority == b.priority) {
    return (a.requesttime < b.requesttime);
  }

  return a.priority < b.priority;
}

function getnextobjectiveid(priority) {
  if(objective_isunlimited()) {
    return objective_create();
  }

  if(getdvarint(@ "hash_b7c28d3b4e160d39", 0) > 0) {
    if(level.objectiveidpool.index < level.objectiveidpool.limit) {
      nextid = level.objectiveidpool.index;
      level.objectiveidpool.index++;
    } else {
      println("<dev string:x1c>");

      if(level.objectiveidpool.reclaimed.size == 0) {
        assertmsg("<dev string:x3c>");
        return -1;
      } else {
        nextid = level.objectiveidpool.reclaimed[0];
        level.objectiveidpool.reclaimed = array_remove_index(level.objectiveidpool.reclaimed, 0);
      }
    }

    return nextid;
  }

  if(level.objectiveidpool.reclaimed.size == 0) {
    if(level.objectiveidpool.index >= level.objectiveidpool.limit) {
      assertmsg("<dev string:x3c>");
      return -1;
    } else {
      nextid = level.objectiveidpool.index;
      level.objectiveidpool.index++;
    }
  } else {
    nextid = level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size - 1];
    level.objectiveidpool.reclaimed = array_remove_index(level.objectiveidpool.reclaimed, level.objectiveidpool.reclaimed.size - 1);
  }

  return nextid;
}

function returnobjectiveid(objid) {
  if(!isDefined(objid) || objid == -1) {
    return false;
  }

  if(array_contains(level.objectiveidpool.reclaimed, objid)) {
    assertmsg("<dev string:x5b>");
    return false;
  }

  level.objectiveidpool.active = array_remove_key(level.objectiveidpool.active, objid);
  level notify("Objective_Delete", objid);
  objective_delete(objid);
  level.objectiveidpool.reclaimed[level.objectiveidpool.reclaimed.size] = objid;
  return true;
}

function returnreservedobjectiveid(objid, var_301ec764dd09b364) {
  if(!isDefined(objid) || objid == -1) {
    return false;
  }

  if(istrue(var_301ec764dd09b364)) {
    level.objectiveidpool.active[objid] = undefined;
  }

  level notify("Objective_Delete", objid);

  if(objective_isunlimited()) {
    if(isDefined(level.var_9977f6e10514d7ce[objid])) {
      objective_reset(level.var_9977f6e10514d7ce[objid].objid);
    } else {
      objective_reset(objid);
    }
  } else {
    objective_delete(objid);
  }

  return true;
}

function private function_7e41a40db70e23b9() {
  ecsid = objective_create();
  entry = spawnStruct();
  entry.priority = 100;
  entry.requesttime = 0;
  entry.objid = ecsid;
  return entry;
}

function private function_be6060bf8a6e12c2(objid) {
  function_b29f91f1fb14e113(objid);
  assert(isDefined(level.var_9977f6e10514d7ce[objid]));
  entry = level.var_9977f6e10514d7ce[objid];
  entry.requesttime = gettime();
  level.objectiveidpool.active[objid] = entry;
  level.objectiveidpool.reserved[level.objectiveidpool.reserved.size] = objid;
  return entry.objid;
}

function objective_add(objectivenumber, state, position, iconname, iconsize) {
  if(!objective_isunlimited()) {
    level notify("Objective_Delete", objectivenumber);
    objective_delete(objectivenumber);
  }

  if(isDefined(state)) {
    objective_state(objectivenumber, state);
  }

  if(isDefined(position)) {
    objective_position(objectivenumber, position);
  }

  if(isDefined(iconname)) {
    objective_icon(objectivenumber, iconname);
  }

  if(isDefined(iconsize)) {
    objective_setminimapiconsize(objectivenumber, iconsize);
  }
}

function objective_add_objective(objid, state, position, iconshader, iconsize) {
  if(objid == -1) {
    return;
  }

  objective_add(objid, state, position, iconshader, iconsize);
}

function update_objective_ownerteam(objid, ownerteam) {
  if(objid == -1) {
    return;
  }

  objective_setownerteam(objid, ownerteam);
}

function update_objective_ownerclient(objid, owner) {
  if(objid == -1) {
    return;
  }

  objective_setownerclient(objid, owner);
}

function update_objective_sethot(objid, ownerteam) {
  if(objid == -1) {
    return;
  }

  objective_sethot(objid, ownerteam);
}

function update_objective_setfriendlylabel(objid, stringref) {
  if(objid == -1) {
    return;
  }

  objective_setfriendlylabel(objid, stringref);
}

function update_objective_setenemylabel(objid, stringref) {
  if(objid == -1) {
    return;
  }

  objective_setenemylabel(objid, stringref);
}

function update_objective_setneutrallabel(objid, stringref) {
  if(objid == -1) {
    return;
  }

  objective_setneutrallabel(objid, stringref);
}

function update_objective_state(objid, state) {
  if(objid == -1) {
    return;
  }

  objective_state(objid, state);
}

function update_objective_position(objid, position) {
  if(objid == -1) {
    return;
  }

  objective_position(objid, position);
}

function update_objective_icon(objid, iconshader) {
  if(objid == -1) {
    return;
  }

  objective_icon(objid, iconshader);
}

function function_2946e9eb07acb3f1(objid, description) {
  if(objid == -1) {
    return;
  }

  objective_setdescription(objid, description);
}

function function_c3c6bff089dfdd34(objid, iconsize) {
  if(objid == -1) {
    return;
  }

  if(isDefined(iconsize)) {
    objective_setminimapiconsize(objid, iconsize);
  }
}

function function_79a1a16de6b22b2d(objid, iconshader) {
  if(objid == -1) {
    return;
  }

  objective_objectiveid(objid, iconshader);
}

function function_56fc9b5845892619(objid) {
  if(objid == -1) {
    return;
  }

  function_cdab88ba2ce79251(objid);
}

function update_objective_setbackground(objid, type) {
  if(objid == -1) {
    return;
  }

  objective_setbackground(objid, type);
}

function update_objective_onentity(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_onentity(objid, ent);
}

function update_objective_onentitywithrotation(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_onentity(objid, ent);
  objective_setrotateonminimap(objid, 1);
}

function function_fa3c420e27b5d08b(objid, var_cff8e6dc09cfee61) {
  if(objid == -1) {
    return;
  }

  function_f32fc70fb7087551(objid, var_cff8e6dc09cfee61);
}

function update_objective_setzoffset(objid, offset) {
  if(objid == -1) {
    return;
  }

  objective_setzoffset(objid, offset);
}

function function_9cad42ac02eff950(objid) {
  if(objid == -1) {
    return;
  }

  objective_removeallfrommask(objid);
}

function function_a28e8535e00d34f3(objid) {
  if(objid == -1) {
    return;
  }

  objective_addalltomask(objid);
}

function function_6ae37618bb04ea60(objid) {
  if(objid == -1) {
    return;
  }

  objective_showtoplayersinmask(objid);
}

function function_17db39bd195cc5b1(objid) {
  if(objid == -1) {
    return;
  }

  objective_hidefromplayersinmask(objid);
}

function objective_playermask_single(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_removeallfrommask(objid);
  objective_addclienttomask(objid, ent);
  objective_showtoplayersinmask(objid);
}

function objective_teammask_single(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_removeallfrommask(objid);
  objective_addteamtomask(objid, team);
  objective_showtoplayersinmask(objid);
}

function function_f5862ad1ad967602(objid) {
  if(objid == -1) {
    return;
  }

  function_6d82c157ec9637b4(objid);
  objective_showtoplayersinmask(objid);
}

function objective_playermask_hidefromall(objid) {
  if(objid == -1) {
    return;
  }

  objective_addalltomask(objid);
  objective_hidefromplayersinmask(objid);
}

function objective_playermask_hidefrom(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_removeclientfrommask(objid, ent);
  objective_showtoplayersinmask(objid);
}

function objective_playermask_addshowplayer(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_addclienttomask(objid, ent);
  objective_showtoplayersinmask(objid);
}

function function_df6a3e032fa07d22(objid) {
  if(objid == -1) {
    return;
  }

  function_ce9f9b0fac60739c(objid);
  objective_showtoplayersinmask(objid);
}

function objective_playermask_showtoall(objid) {
  if(objid == -1) {
    return;
  }

  objective_addalltomask(objid);
  objective_showtoplayersinmask(objid);
}

function objective_mask_showtoplayerteam(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_removeallfrommask(objid);
  objective_addteamtomask(objid, ent.team);
  objective_showtoplayersinmask(objid);
}

function function_39f2dc4e92db5fb9(objid, ent) {
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

function objective_mask_showtoenemyteam(objid, ent) {
  if(objid == -1) {
    return;
  }

  objective_removeallfrommask(objid);

  if(level.teambased) {
    objective_addteamtomask(objid, ent.team);
  } else {
    objective_addclienttomask(objid, ent);
  }

  objective_hidefromplayersinmask(objid);
}

function objective_teammask_addtomask(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_addteamtomask(objid, team);
  objective_showtoplayersinmask(objid);
}

function objective_teammask_removefrommask(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_removeteamfrommask(objid, team);
  objective_showtoplayersinmask(objid);
}

function objective_pin_global(objid, pin) {
  if(objid == -1) {
    return;
  }

  objective_setpinned(objid, pin);
}

function objective_pin_team(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_pinforteam(objid, team);
}

function objective_unpin_team(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_unpinforteam(objid, team);
}

function private function_781844c0c05b5ac7() {
  if(issharedfuncdefined("super_capture_bot", "captureBot_isGrenadeEntity")) {
    return callsharedfunc("super_capture_bot", "captureBot_isGrenadeEntity");
  }

  return 0;
}

function objective_pin_player(objid, player) {
  if(objid == -1 || player function_781844c0c05b5ac7()) {
    return;
  }

  objective_pinforclient(objid, player);
}

function objective_unpin_player(objid, player, showoncompass) {
  if(objid == -1 || player function_781844c0c05b5ac7()) {
    return;
  }

  objective_unpinforclient(objid, player);
}

function objective_show_progress(objid, show, unfill) {
  if(objid == -1) {
    return;
  }

  if(show && !istrue(unfill)) {
    level notify("Objective_SetShowProgress", objid);
  }

  objective_setshowprogress(objid, show);
}

function function_7299a742781a5030(state, player) {
  if(player function_781844c0c05b5ac7()) {
    return;
  }

  objective_setshowpinnedprogressbar(state, player);
}

function function_8f7a55bda12ebb21(text, player) {
  if(player function_781844c0c05b5ac7()) {
    return;
  }

  objective_setpinnedprogressbartext(text, player);
}

function objective_show_team_progress(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_showprogressforteam(objid, team);
}

function objective_hide_team_progress(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_hideprogressforteam(objid, team);
}

function objective_show_player_progress(objid, player) {
  if(objid == -1 || player function_781844c0c05b5ac7()) {
    return;
  }

  objective_showprogressforclient(objid, player);
}

function objective_hide_player_progress(objid, player) {
  if(objid == -1 || player function_781844c0c05b5ac7()) {
    return;
  }

  objective_hideprogressforclient(objid, player);
}

function objective_set_show_progress(objid, showprogress) {
  if(!isDefined(objid) || objid == -1) {
    return;
  }

  objective_setshowprogress(objid, showprogress);
}

function objective_set_progress(objid, progress) {
  if(objid == -1) {
    return;
  }

  objective_setprogress(objid, progress);
}

function objective_set_progress_team(objid, team) {
  if(objid == -1) {
    return;
  }

  objective_setprogressteam(objid, team);
}

function function_9b1a086f348520b0(objid, team) {
  if(objid == -1) {
    return;
  }

  function_97b31127037043b6(objid, team);
}

function objective_set_progress_client(objid, player) {
  if(objid == -1 || player function_781844c0c05b5ac7()) {
    return;
  }

  objective_setprogressclient(objid, player);
}

function objective_set_play_intro(objid, show) {
  if(objid == -1) {
    return;
  }

  objective_setplayintro(objid, show);
}

function objective_set_play_outro(objid, show) {
  if(objid == -1) {
    return;
  }

  objective_setplayoutro(objid, show);
}

function objective_set_pulsate(objid, pulse) {
  if(objid == -1) {
    return;
  }

  objective_setpulsate(objid, pulse);
}

function objective_hide_for_mlg_spectator(objid, show) {
  if(objid == -1) {
    return;
  }

  objective_sethideformlgspectator(objid, show);
}

function objective_show_for_mlg_spectator(objid, show) {
  if(objid == -1) {
    return;
  }

  objective_setshowformlgspectator(objid, show);
}

function function_d7e3c4a08682c1b9(objid, show) {
  if(objid == -1) {
    return;
  }

  function_865f9c5d005f9a08(objid, show);
}

function function_ee37484ca9bdc744(objid, show) {
  if(objid == -1) {
    return;
  }

  function_9427cb5974c925d9(objid, show);
}

function function_994c8917a78b024(objid, show) {
  if(objid == -1) {
    return;
  }

  function_2b46ef80dca002f9(objid, show);
}

function function_1513b8ac9570e6c7(objid, var_99d6809da5559c23) {
  if(objid == -1) {
    return;
  }

  function_9929f54e3253dbb4(objid, var_99d6809da5559c23);
}

function function_559a49e0dab1f8fc(objid, var_99d6809da5559c23) {
  if(objid == -1) {
    return;
  }

  function_6468f83ab1b52315(objid, var_99d6809da5559c23);
}

function function_bf66c6833e867284(objid, type) {
  if(objid == -1) {
    return;
  }

  function_a13e72e0427ecad2(objid, type);
}

function function_a73941bc42a6e8d3(objid, var_40c8c22e3af690c1) {
  if(objid == -1) {
    return;
  }

  function_8ff22d292de16d27(objid, var_40c8c22e3af690c1);
}

function function_e6b9c68b99e455ba(objid, var_d3810e59fa78746e, var_a4ce6d25578e2f1f, var_9184ccd844da4630) {
  if(objid == -1) {
    return;
  }

  function_34da8a6f11186850(objid, var_d3810e59fa78746e);
  function_dca08025695eac8d(objid, var_a4ce6d25578e2f1f);
  function_4b1c68b732904e7a(objid, var_9184ccd844da4630);
}

function createobjective(shadername, team, friendlyonly, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize) {
  curobjid = function_c1a18d4076f420a5(shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize);

  if(level.teambased) {
    if(isDefined(team)) {
      update_objective_ownerteam(curobjid, team);
    }
  } else if(isDefined(self.owner)) {
    update_objective_ownerclient(curobjid, self.owner);
  }

  if(istrue(friendlyonly)) {
    if(level.teambased) {
      objective_mask_showtoplayerteam(curobjid, self);
    } else {
      function_39f2dc4e92db5fb9(curobjid, self);
    }
  } else {
    objective_playermask_showtoall(curobjid);
  }

  if(istrue(level.objvisall)) {
    objective_playermask_showtoall(curobjid);
  }

  return curobjid;
}

function function_c1a18d4076f420a5(shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize) {
  curobjid = function_4625d98c8f5bdc94(shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize);
  objective_playermask_hidefromall(curobjid);
  return curobjid;
}

function createobjective_engineer(shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize) {
  curobjid = undefined;
  createfunc = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjectiveHidden")) {
    createfunc = scripts\engine\utility::getsharedfunc("game", "createObjectiveHidden");
  }

  if(isDefined(createfunc) && isDefined(level.var_5b12006b920a1b6c)) {
    curobjid = [[createfunc]](level.var_5b12006b920a1b6c, 1, 1, "icon_regular");
    update_objective_ownerteam(curobjid, self.team);
    return;
  }

  return curobjid;
}

function function_4625d98c8f5bdc94(shadername, var_2231e5a0f940caae, var_dbe22cd5d2a797af, iconsize) {
  curobjid = requestobjectiveid(10);

  if(curobjid == -1) {
    return -1;
  }

  objective_add_objective(curobjid, "invisible", (0, 0, 0));

  if((!isent(self) || !isDefined(self getlinkedparent())) && !istrue(var_2231e5a0f940caae)) {
    update_objective_position(curobjid, self.origin);
  } else if(istrue(var_2231e5a0f940caae) && istrue(var_dbe22cd5d2a797af)) {
    update_objective_onentitywithrotation(curobjid, self);
  } else {
    update_objective_onentity(curobjid, self);
  }

  update_objective_state(curobjid, "active");
  update_objective_icon(curobjid, shadername);
  update_objective_setbackground(curobjid, 1);
  function_c3c6bff089dfdd34(curobjid, iconsize);
  return curobjid;
}

function function_160f522b63c32d76(progressbarstate, text, omnvarvalue) {
  if(function_781844c0c05b5ac7()) {
    return;
  }

  if(getdvarint(@ "hash_141de4492226006e", 1) == 1) {
    if(isDefined(omnvarvalue)) {}

    function_7299a742781a5030(progressbarstate, self);

    if(isDefined(text)) {
      function_8f7a55bda12ebb21(text, self);
    } else {
      function_8f7a55bda12ebb21("", self);
    }

    return;
  }

  self setclientomnvar("ui_objective_pinned_text_param", omnvarvalue);
}

function function_ce702e5925e31fc9(objid, player, priority, state, text) {
  if(objid == -1 || player function_781844c0c05b5ac7()) {
    return;
  }

  if(!isDefined(player.objectivepriority)) {
    player.objectivepriority = 0;
  }

  if(player.objectivepriority < priority) {
    player.objectivepriority = priority;
    scripts\mp\objidpoolmanager::objective_show_player_progress(objid, player);
    scripts\mp\objidpoolmanager::function_8f7a55bda12ebb21(text, player);
    scripts\mp\objidpoolmanager::function_7299a742781a5030(state, player);
    return 1;
  }

  return 0;
}

function function_26259bd38697b5ad(objid, player) {
  if(objid == -1 || !isDefined(player) || player function_781844c0c05b5ac7()) {
    return;
  }

  player.objectivepriority = 0;
  scripts\mp\objidpoolmanager::objective_hide_player_progress(objid, player);
  scripts\mp\objidpoolmanager::function_7299a742781a5030(0, player);
}

function function_482e36e6af02143c(player) {
  player.objectivepriority = 0;
}

function function_98ba077848896a3(objid, shouldshow) {
  if(objid == -1) {
    return;
  }

  objective_setshowdistance(objid, shouldshow);
}

function function_f21e9b2e78de984b(objid, var_a7c6c5d6c3d369aa, var_467f4d9b8d9063b) {
  if(objid == -1) {
    return;
  }

  function_c047d7ffe7a83501(objid, var_a7c6c5d6c3d369aa, var_467f4d9b8d9063b);
}

function function_41f90376ab869b9f(objid, shouldhide) {
  if(objid == -1) {
    return;
  }

  objective_sethideelevation(objid, shouldhide);
}

function function_846c2acd91309cd8(objid, r, g, b, active) {
  if(objid == -1) {
    return;
  }

  objective_settint(objid, r, g, b, active);
}