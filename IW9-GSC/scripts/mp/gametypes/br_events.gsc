/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_events.gsc
***********************************************/

breventsinit() {
  _id_099015E34F2AD75F = getdvarint("scr_br_events", 0);

  if(!_id_099015E34F2AD75F) {
    return;
  }
  if(_id_099015E34F2AD75F & 1)
    thread brevent1();

  if(_id_099015E34F2AD75F & 2)
    thread brevent2();

  if(_id_099015E34F2AD75F & 4)
    thread brevent3();

  if(_id_099015E34F2AD75F & 8)
    thread brevent4();
}

breventflagset(eventflag) {
  current = self getclientomnvar("ui_br_events");
  self setclientomnvar("ui_br_events", current | eventflag);
}

breventflagclear(eventflag) {
  current = self getclientomnvar("ui_br_events");
  self setclientomnvar("ui_br_events", current &~eventflag);
}

brevent1(_id_4F105563CA74CF73) {
  if(_id_2CEDCC356F1B9FC8::isanytutorialorbotpracticematch()) {
    return;
  }
  _id_302E82DA1A1989AD = getdvarfloat("scr_br_event1_chance", 0.04);

  if(_id_302E82DA1A1989AD <= randomfloat(1.0)) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");
  mintime = getdvarfloat("dvar_34E8F9306608B247", 180);
  maxtime = getdvarfloat("dvar_350CE73066310569", 300);
  waittime = randomfloat(maxtime - mintime) + mintime;
  wait(waittime);

  if(scripts\mp\utility\game::getsubgametype() == "plunder" || !isDefined(level.br_circle) || !isDefined(level.br_circle.circleindex) || level.br_circle.circleindex < 0) {
    circleorigin = level.br_level.br_mapcenter;
    circleradius = level.br_level.br_mapsize[0] * getdvarfloat("dvar_18156AFB52A30992", 0.5);
  } else {
    circleorigin = level.br_level.br_circlecenters[level.br_circle.circleindex];
    circleradius = level.br_level.br_circleradii[level.br_circle.circleindex] * getdvarfloat("dvar_18156AFB52A30992", 1.0);
  }

  _id_E7F5785C930EDA04 = getdvarint("dvar_5DB9E9355474F47B", 18000);
  circleorigin = (circleorigin[0], circleorigin[1], _id_E7F5785C930EDA04);
  center = _id_2695A20D4011076D::getrandompointincircle(circleorigin, circleradius, 0.0, 1.0, 0, 0);
  angles = (0, randomfloat(360.0), 0);
  dir = anglesToForward(angles);
  _id_4DA9C15F5BFB52E0 = getdvarfloat("dvar_67211365C18C7382", 2.0);
  _id_5619B7BBC3745888 = level.br_level.br_mapsize[0] * _id_4DA9C15F5BFB52E0;
  start = center - dir * _id_5619B7BBC3745888;
  end = center + dir * _id_5619B7BBC3745888;
  _id_F519F16439798FC9 = spawn("script_model", start);
  _id_F519F16439798FC9 setModel("x1_u2_plane");
  _id_F519F16439798FC9.angles = angles;
  dist = distance(start, end);
  speed = getdvarint("dvar_424D58D410A4EF03", 8800);
  time = dist / speed;
  _id_A4B40C6DF88184D5 = getdvarfloat("dvar_9A7BDD2B7675B5C6", 2.0);
  right = anglestoright(angles);

  foreach(player in level.players) {
    if(!brevent1playervalid(player)) {
      continue;
    }
    _id_972D1889BBE8CC7C = distance2d(_id_F519F16439798FC9.origin, player.origin);
    waittime = _id_972D1889BBE8CC7C / speed;
    player thread brevent1playerthink(waittime, _id_A4B40C6DF88184D5, _id_4F105563CA74CF73);
  }

  _id_F519F16439798FC9 moveTo(end, time);
  wait(time);
  _id_F519F16439798FC9 delete();
  level notify("spyplane_done");
}

brevent1playervalid(player) {
  if(!isDefined(player))
    return 0;

  if(istrue(player.br_iseliminated) || !isalive(player) || istrue(player.gulag))
    return 0;

  return 1;
}

brevent1playerthink(waittime, _id_77E7DEBAB7FD1A02, _id_4F105563CA74CF73) {
  self endon("disconnect");
  wait(waittime);

  if(!isDefined(_id_4F105563CA74CF73))
    _id_4F105563CA74CF73 = "mp_amber";

  if(!brevent1playervalid(self)) {
    return;
  }
  breventflagset(1);
  self playlocalsound("br_event1_scramble_sfx");
  self setclientomnvar("ui_br_bink_overlay_state", 4);
  self setclientomnvar("ui_scrambler_strength", 5);
  self playcinematicforplayer(_id_4F105563CA74CF73, 1, 1);
  wait(_id_77E7DEBAB7FD1A02);
  breventflagclear(1);
  self stoplocalsound("br_event1_scramble_sfx");
  self setclientomnvar("ui_br_bink_overlay_state", 0);
  self setclientomnvar("ui_scrambler_strength", 0);
}

brevent2() {}

brevent3() {}

brevent4() {}