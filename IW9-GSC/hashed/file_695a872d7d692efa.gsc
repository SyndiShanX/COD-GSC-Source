/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_695a872d7d692efa.gsc
***********************************************/

_id_8D0BCD24E525CA55() {
  level._id_4B646B4BF1C0CD01 = spawnStruct();
  level._id_4B646B4BF1C0CD01.waypoints = [];
  _id_BCEADB844CBE69CA();
}

_id_BCEADB844CBE69CA() {
  scripts\engine\utility::add_fx("ftue_objectives_waypoint_fx", "vfx/mgl/ftue/vfx_feedback_ftue.vfx");
  scripts\engine\utility::add_fx("ftue_objectives_waypoint_large_fx", "vfx/mgl/ftue/vfx_feedback_large_ftue.vfx");
}

_id_E5524FB8509827BF(_id_49ECE3D0608350F7, _id_6810723EE9DFE43A, icon, zoffset, owner, _id_96ACB993AEFD266F) {
  _id_8D126083C75ADBE6 = _id_784459B6FA2274CC(owner, _id_49ECE3D0608350F7);
  _id_8D126083C75ADBE6._id_96ACB993AEFD266F = istrue(_id_96ACB993AEFD266F);
  _id_4CB22D8DDA2E06A9 = _id_15379E7D5A0B111A(_id_6810723EE9DFE43A, icon, zoffset, undefined, owner, _id_8D126083C75ADBE6);
  objective_position(_id_4CB22D8DDA2E06A9, _id_49ECE3D0608350F7);
  return _id_4CB22D8DDA2E06A9;
}

_id_070E0DE6281199E7(_id_4A7A3357A053496D, _id_6810723EE9DFE43A, icon, zoffset, owner, _id_96ACB993AEFD266F) {
  _id_8D126083C75ADBE6 = _id_784459B6FA2274CC(owner, _id_4A7A3357A053496D.origin);
  _id_8D126083C75ADBE6._id_96ACB993AEFD266F = istrue(_id_96ACB993AEFD266F);
  team = undefined;

  if(isPlayer(_id_4A7A3357A053496D))
    team = _id_4A7A3357A053496D.team;

  _id_4CB22D8DDA2E06A9 = _id_15379E7D5A0B111A(_id_6810723EE9DFE43A, icon, zoffset, team, owner, _id_8D126083C75ADBE6);
  objective_onentity(_id_4CB22D8DDA2E06A9, _id_4A7A3357A053496D);
  _id_4A7A3357A053496D._id_4CB22D8DDA2E06A9 = _id_4CB22D8DDA2E06A9;
  return _id_4CB22D8DDA2E06A9;
}

_id_15379E7D5A0B111A(_id_6810723EE9DFE43A, icon, zoffset, team, owner, _id_8D126083C75ADBE6) {
  _id_4CB22D8DDA2E06A9 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  objective_setpings(_id_4CB22D8DDA2E06A9, 0);
  objective_state(_id_4CB22D8DDA2E06A9, "current");
  objective_icon(_id_4CB22D8DDA2E06A9, icon);
  objective_setminimapiconsize(_id_4CB22D8DDA2E06A9, "icon_regular");
  objective_setbackground(_id_4CB22D8DDA2E06A9, 1);
  objective_setshowdistance(_id_4CB22D8DDA2E06A9, !isDefined(team));
  objective_setfadedisabled(_id_4CB22D8DDA2E06A9, 1);

  if(isDefined(_id_6810723EE9DFE43A))
    objective_setlabel(_id_4CB22D8DDA2E06A9, _id_6810723EE9DFE43A);

  objective_setzoffset(_id_4CB22D8DDA2E06A9, zoffset);
  _func_DCFEEA6332BCA22F(_id_4CB22D8DDA2E06A9, "mobileftueobjective");

  if(isDefined(team))
    objective_setownerteam(_id_4CB22D8DDA2E06A9, team);

  if(isDefined(owner)) {
    objective_removeallfrommask(_id_4CB22D8DDA2E06A9);
    objective_addclienttomask(_id_4CB22D8DDA2E06A9, owner);
    objective_showtoplayersinmask(_id_4CB22D8DDA2E06A9);
  } else
    objective_addalltomask(_id_4CB22D8DDA2E06A9);

  if(istrue(_id_8D126083C75ADBE6._id_96ACB993AEFD266F))
    thread _id_F36E91AA37D197C3(_id_4CB22D8DDA2E06A9, _id_8D126083C75ADBE6);

  return _id_4CB22D8DDA2E06A9;
}

_id_F36E91AA37D197C3(_id_4CB22D8DDA2E06A9, _id_8D126083C75ADBE6) {
  if(!isDefined(_id_8D126083C75ADBE6.fx))
    _id_8D126083C75ADBE6.fx = "ftue_objectives_waypoint_fx";

  _func_ F5A15218AA0776A(level._effect[_id_8D126083C75ADBE6.fx], _id_8D126083C75ADBE6.position, 2000);
  waitframe();

  if(isDefined(_id_8D126083C75ADBE6.delay))
    wait(_id_8D126083C75ADBE6.delay);

  waypoint = spawnfxforclient(scripts\engine\utility::getfx(_id_8D126083C75ADBE6.fx), _id_8D126083C75ADBE6.position, _id_8D126083C75ADBE6.owner);
  triggerfx(waypoint);
  level._id_4B646B4BF1C0CD01.waypoints[_id_4CB22D8DDA2E06A9] = waypoint;
}

_id_784459B6FA2274CC(owner, position, fx, delay) {
  _id_8D126083C75ADBE6 = spawnStruct();
  _id_8D126083C75ADBE6.owner = owner;
  _id_8D126083C75ADBE6.position = position;
  _id_8D126083C75ADBE6.fx = fx;
  _id_8D126083C75ADBE6.delay = delay;
  return _id_8D126083C75ADBE6;
}

_id_CE25EC56EF58C5CC(_id_4CB22D8DDA2E06A9, player, _id_09B9DC1CD01AAF86) {
  waypoint = level._id_4B646B4BF1C0CD01.waypoints[_id_4CB22D8DDA2E06A9];

  if(!isDefined(waypoint) || !isDefined(_id_09B9DC1CD01AAF86)) {
    return;
  }
  while(isDefined(waypoint)) {
    if(distance2d(player.origin, waypoint.origin) < _id_09B9DC1CD01AAF86)
      waypoint hide();
    else
      waypoint show();

    waitframe();
  }
}

_id_B30874D13004D4C5(_id_4A7A3357A053496D) {
  _id_4D03B9EF456D0972(_id_4A7A3357A053496D._id_4CB22D8DDA2E06A9);
}

_id_4D03B9EF456D0972(_id_4CB22D8DDA2E06A9) {
  scripts\mp\objidpoolmanager::returnobjectiveid(_id_4CB22D8DDA2E06A9);
  _id_B93E49439785C073(_id_4CB22D8DDA2E06A9);
}

_id_B93E49439785C073(_id_4CB22D8DDA2E06A9) {
  if(!isDefined(level._id_4B646B4BF1C0CD01.waypoints[_id_4CB22D8DDA2E06A9])) {
    return;
  }
  objective_setpings(_id_4CB22D8DDA2E06A9, 1);
  level._id_4B646B4BF1C0CD01.waypoints[_id_4CB22D8DDA2E06A9] delete();
}