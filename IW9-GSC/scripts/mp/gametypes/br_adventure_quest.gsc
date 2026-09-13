/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_adventure_quest.gsc
*******************************************************/

init() {
  setdvarifuninitialized("dvar_282D9B6DBB93E17D", 0);
  level.br_quests_enabled = getdvarint("dvar_282D9B6DBB93E17D", 0) != 0;

  if(!istrue(level.br_quests_enabled)) {
    return;
  }
  level.br_queststashlocations = scripts\engine\utility::getStructArray("quest_stash_location", "targetname");

  if(level.br_queststashlocations.size < 0)
    level.br_quests_enabled = 0;
}

removestashlocation(location) {
  level.br_queststashlocations = scripts\engine\utility::array_remove(level.br_queststashlocations, location);
}

takequestitem(pickupent) {
  if(!istrue(level.br_quests_enabled)) {
    self iprintlnbold("Item is disabled");
    return;
  }

  _id_D9A39BCC719E38E5 = determinestashlocation();
  spawnstash(_id_D9A39BCC719E38E5);
}

determinestashlocation() {
  if(!isDefined(level.br_queststashlocations))
    level.br_queststashlocations = scripts\engine\utility::getStructArray("quest_stash_location", "targetname");

  return scripts\engine\utility::random(level.br_queststashlocations);
}

spawnstash(position) {
  _id_D9A39BCC719E38E5 = spawn("script_model", position.origin);
  _id_D9A39BCC719E38E5 setModel("com_plasticcase_beige_big_iw6");
  _id_D9A39BCC719E38E5 makeusable();
  _id_D9A39BCC719E38E5 setCursorHint("HINT_NOICON");
  _id_D9A39BCC719E38E5 setuseholdduration("duration_medium");
  _id_D9A39BCC719E38E5 sethintrequiresholding(1);
  _id_D9A39BCC719E38E5 sethintdisplayfov(360);
  _id_D9A39BCC719E38E5 setusefov(360);
  _id_D9A39BCC719E38E5 setuserange(150);
  _id_D9A39BCC719E38E5 setHintString(&"MP/BR_USE_PLUNDER_CACHE");
  _id_D9A39BCC719E38E5 setasgametypeobjective();
  _id_D9A39BCC719E38E5 hide();
  _id_EF66E4DF53A86181 = (position.origin[0], position.origin[1], 1000);
  _id_EF66E4DF53A86181 = _id_EF66E4DF53A86181 + scripts\engine\math::random_vector_2d() * randomintrange(100, 900);
  _id_D9A39BCC719E38E5.search_location = spawn("script_model", _id_EF66E4DF53A86181);
  _id_D9A39BCC719E38E5 thread stashthink();
  addthinker(self, _id_D9A39BCC719E38E5);
  scripts\mp\utility\lower_message::setlowermessageomnvar("quest_pickup", undefined, 5);
  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  _id_D9A39BCC719E38E5.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "active", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_position(objectiveiconid, _id_D9A39BCC719E38E5.search_location.origin);
    scripts\mp\objidpoolmanager::update_objective_state(objectiveiconid, "active");
    scripts\mp\objidpoolmanager::update_objective_icon(objectiveiconid, "ui_mp_br_mapmenu_icon_atm");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objectiveiconid);
  }

  _id_D9A39BCC719E38E5 stashmakeusabletoteam(self.team);
  _id_09D5BC8E32EE3635 = "ammo_crate_use";
  self playlocalsound(_id_09D5BC8E32EE3635);
}

stashmakeusabletoteam(team) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player.team == team) {
      self enableplayeruse(player);
      scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, player);
      self showtoplayer(player);
      continue;
    }

    stashmakeunusabletoplayer(player);
  }
}

stashmakeunusabletoplayer(player) {
  self disableplayeruse(player);
  self hudoutlinedisableforclient(player);
  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, player);
}

stashthink() {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);
    thread usestash(player);
  }
}

globalsonarthink() {
  level endon("game_ended");
  level endon("end_sonar_think");
  _id_09D5BC8E32EE3635 = "breach_warning_beep_04";

  for(;;) {
    wait 0.1;

    foreach(_id_14EF0ACE56787531, value in level.br_sonartickrates) {
      level.br_sonartickrates[_id_14EF0ACE56787531]--;

      if(value <= 0) {
        player = level.br_playersusingsonar[_id_14EF0ACE56787531];
        search_location = player.sonar_tracked_location.search_location;
        dist = distance2d(player.origin, search_location.origin);

        if(dist < 1500) {
          if(!isDefined(player.first_entered_search_area)) {
            player scripts\mp\utility\lower_message::setlowermessageomnvar("quest_enter_search_area", undefined, 5);
            player.first_entered_search_area = 1;
          }

          player playlocalsound(_id_09D5BC8E32EE3635);
        }

        level.br_sonartickrates[_id_14EF0ACE56787531] = calculatesonartickrate(player);
      }
    }
  }
}

addthinker(player, location) {
  player.sonar_tracked_location = location;

  if(!isDefined(level.br_sonartickrates)) {
    level.br_sonartickrates = [];
    level.br_playersusingsonar = [];
    level.br_sonartickrates[player.guid] = calculatesonartickrate(player);
    level.br_playersusingsonar[player.guid] = player;
    level thread globalsonarthink();
  } else {
    level.br_playersusingsonar[player.guid] = player;
    level.br_sonartickrates[player.guid] = calculatesonartickrate(player);
  }
}

removethinker(player) {
  if(!isDefined(level.br_sonartickrates)) {
    return;
  }
  level.br_sonartickrates = scripts\engine\utility::array_remove_key(level.br_sonartickrates, player.guid);

  if(level.br_sonartickrates.size == 0) {
    level notify("end_sonar_think");
    level.br_sonartickrates = undefined;
    level.br_playersusingsonar = undefined;
  }
}

calculatesonartickrate(player) {
  location = player.sonar_tracked_location;
  rate = distance2d(player.origin, location.origin);
  rate = clamp(rate / 75, 2, 15);
  return int(rate);
}

usestash(player) {
  removethinker(player);
  self hide();
  self makeunusable();
  self.origin = self.origin + (0, 0, -500);
  player scripts\mp\utility\lower_message::setlowermessageomnvar("quest_stash_found", undefined, 5);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  self delete();
}