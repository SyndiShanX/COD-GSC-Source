main() {
  // use map vision from start & don't wait for players
  replacefunc(maps\mp\gametypes\_gamelogic::matchstarttimerwaitforplayers, ::matchstarttimerwaitforplayers_stub);

  // use new freeze when game ends
  replacefunc(maps\mp\gametypes\_gamelogic::freezeplayerforroundend, ::freezeplayerforroundend_stub);

  // MW2 objective text rendering
  replacefunc(maps\mp\gametypes\_gamelogic::prematchperiod, ::prematchperiod_stub);
}

matchstarttimerwaitforplayers_stub() {
  setomnvar("ui_match_countdown_title", 6);
  setomnvar("ui_match_countdown_toggle", 0);

  //setomnvar("ui_cg_world_blur", 1);

  visionsetnaked("", 0);
  visionsetpostapply("", 0); // no mpIntro, sets to map vision

  //waitforplayers(level.prematchperiod); // TODO: do we need? hmmm

  if(maps\mp\_utility::getmapname() != "trainer" &&
    level.prematchperiodend > 0 &&
    !isdefined(level.hostmigrationtimer))
    maps\mp\gametypes\_gamelogic::matchstarttimer(level.prematchperiodend);
  else
    setomnvar("ui_match_countdown_title", 0);

  // after match start timer, unblock changes to speed scale
  foreach(player in level.players) {
    player thread toggle_custom_freeze(false);
  }
}

freezeplayerforroundend_stub(delay) {
  self endon("disconnect");
  self thread maps\mp\_utility::clearlowermessages();

  self closepopupmenu();
  self closeingamemenu();

  wait(0.5);

  //self thread maps\mp\_utility::freezecontrolswrapper(1);
  self thread toggle_custom_freeze(true);
}

init() {
  level thread connected();
}

connected() {
  level endon("game_ended");
  for (;;) {
    level waittill("connected", player);
    player thread spawned();
  }
}

spawned() {
  self endon("disconnect");
  level endon("game_ended");
  self waittill("spawned_player");

  visionsetpostapply("", 0);
  self force_play_weap_anim(19, 19); // first raise

  // handle freezing the player and limit what they can do
  if(!isdefined(level.prematch_done_time) || (gettime() < level.prematch_done_time)) {
    self thread toggle_custom_freeze(true);
  }
}

monitor_class_changes_for_stock() {
  self endon("disconnect");
  self endon("stop_monitoring_class_stock");
  level endon("prematch_over");
  level endon("shutdowngame_called");

  for (;;) {
    self common_scripts\utility::waittill_any("applyLoadout", "weapon_change");

    self setmovespeedscale(0.0);

    self disableoffhandweapons();
  }
}

toggle_custom_freeze(should_freeze) {
  // stop bots from knifing in prematch on bad spawns
  if(isBot(self)) {
    self freezeControls(should_freeze);
    return;
  }



  // unfreeze
  self freezecontrols(false);

  if(should_freeze == true) {
    self disableoffhandweapons();
  } else {
    self enableoffhandweapons();
  }

  self allowfire(!should_freeze);
  self allowlean(true);
  self allowads(!should_freeze);
  self allowmelee(!should_freeze);
  self allowcrouch(true); // allow no matter what
  self allowsprint(!should_freeze);
  self allowprone(true); // ^
  self allowjump(!should_freeze);

  if(should_freeze) {
    self thread monitor_class_changes_for_stock();
  } else if(!should_freeze && (isdefined(self.freeze_save_data) && self.freeze_save_data.size > 0)) {
    self notify("stop_monitoring_class_stock");
  }

  // nothing but 0 will work if blocked
  new_scale = (should_freeze ? 0.0 : 1.0);
  self setmovespeedscale(new_scale);
}

objective_text_intro(objective_text) {
  self.objective_text_elem = maps\mp\gametypes\_hud_util::createfontstring("objective", 1.6);
  self.objective_text_elem maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, 0);
  self.objective_text_elem.hidewheninmenu = 1;
  self.objective_text_elem.glowcolor = (1.0, 0.714, 0.184);
  self.objective_text_elem.glowalpha = 0.2;
  self.objective_text_elem setpulsefx(60, 3500, 700);
  self.objective_text_elem.foreground = 1;
  self.objective_text_elem settext(objective_text);
  self.objective_text_elem.alpha = 1;
  self.objective_text_elem maps\mp\gametypes\_hud_message::setcustompoint("center", 0, -110);
  wait 5;
  self.objective_text_elem destroy();
}

prematchperiod_stub() {
  level endon("game_ended");
  level.connectingplayers = getdvarint("party_partyPlayerCountNum");

  if(level.prematchperiod > 0) {
    level.waitingforplayers = 1;
    maps\mp\gametypes\_gamelogic::matchstarttimerwaitforplayers();
    level.waitingforplayers = 0;
  } else
    maps\mp\gametypes\_gamelogic::matchstarttimerskip();

  for (index = 0; index < level.players.size; index++) {
    level.players[index] maps\mp\_utility::freezecontrolswrapper(0);
    level.players[index] enableweapons();
    level.players[index] enableammogeneration();

    if(!level.players[index].hasspawned) {
      continue;
    }
    if(!isbot(level.players[index])) {
      obj_text = maps\mp\_utility::getobjectivehinttext(level.players[index].pers["team"]);
      level.players[index] thread objective_text_intro(obj_text);
    }
  }

  if(game["state"] != "playing")
    return;
}