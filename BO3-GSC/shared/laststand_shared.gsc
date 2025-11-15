/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\laststand_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\util_shared;
#namespace laststand;

function player_is_in_laststand() {
  if(!(isDefined(self.no_revive_trigger) && self.no_revive_trigger)) {
    return isDefined(self.revivetrigger);
  }
  return isDefined(self.laststand) && self.laststand;
}

function player_num_in_laststand() {
  num = 0;
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(players[i] player_is_in_laststand()) {
      num++;
    }
  }
  return num;
}

function player_all_players_in_laststand() {
  return player_num_in_laststand() == getplayers().size;
}

function player_any_player_in_laststand() {
  return player_num_in_laststand() > 0;
}

function laststand_allowed(sweapon, smeansofdeath, shitloc) {
  if(level.laststandpistol == "none") {
    return false;
  }
  return true;
}

function cleanup_suicide_hud() {
  if(isDefined(self.suicideprompt)) {
    self.suicideprompt destroy();
  }
  self.suicideprompt = undefined;
}

function clean_up_suicide_hud_on_end_game() {
  self endon("disconnect");
  self endon("stop_revive_trigger");
  self endon("player_revived");
  self endon("bled_out");
  level util::waittill_any("game_ended", "stop_suicide_trigger");
  self cleanup_suicide_hud();
  if(isDefined(self.suicidetexthud)) {
    self.suicidetexthud destroy();
  }
  if(isDefined(self.suicideprogressbar)) {
    self.suicideprogressbar hud::destroyelem();
  }
}

function clean_up_suicide_hud_on_bled_out() {
  self endon("disconnect");
  self endon("stop_revive_trigger");
  self util::waittill_any("bled_out", "player_revived", "fake_death");
  self cleanup_suicide_hud();
  if(isDefined(self.suicideprogressbar)) {
    self.suicideprogressbar hud::destroyelem();
  }
  if(isDefined(self.suicidetexthud)) {
    self.suicidetexthud destroy();
  }
}

function is_facing(facee, requireddot = 0.9) {
  orientation = self getplayerangles();
  forwardvec = anglesToForward(orientation);
  forwardvec2d = (forwardvec[0], forwardvec[1], 0);
  unitforwardvec2d = vectornormalize(forwardvec2d);
  tofaceevec = facee.origin - self.origin;
  tofaceevec2d = (tofaceevec[0], tofaceevec[1], 0);
  unittofaceevec2d = vectornormalize(tofaceevec2d);
  dotproduct = vectordot(unitforwardvec2d, unittofaceevec2d);
  return dotproduct > requireddot;
}

function revive_hud_create() {
  self.revive_hud = newclienthudelem(self);
  self.revive_hud.alignx = "center";
  self.revive_hud.aligny = "middle";
  self.revive_hud.horzalign = "center";
  self.revive_hud.vertalign = "bottom";
  self.revive_hud.foreground = 1;
  self.revive_hud.font = "default";
  self.revive_hud.fontscale = 1.5;
  self.revive_hud.alpha = 0;
  self.revive_hud.color = (1, 1, 1);
  self.revive_hud.hidewheninmenu = 1;
  self.revive_hud settext("");
  self.revive_hud.y = -148;
}

function revive_hud_show() {
  assert(isDefined(self));
  assert(isDefined(self.revive_hud));
  self.revive_hud.alpha = 1;
}

function revive_hud_show_n_fade(time) {
  revive_hud_show();
  self.revive_hud fadeovertime(time);
  self.revive_hud.alpha = 0;
}

function drawcylinder(pos, rad, height) {
  currad = rad;
  curheight = height;
  for(r = 0; r < 20; r++) {
    theta = (r / 20) * 360;
    theta2 = ((r + 1) / 20) * 360;
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0));
    line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight));
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight));
  }
}

function get_lives_remaining() {
  assert(level.laststandgetupallowed, "");
  if(level.laststandgetupallowed && isDefined(self.laststand_info) && isDefined(self.laststand_info.type_getup_lives)) {
    return max(0, self.laststand_info.type_getup_lives);
  }
  return 0;
}

function update_lives_remaining(increment) {
  assert(level.laststandgetupallowed, "");
  assert(isDefined(increment), "");
  increment = (isDefined(increment) ? increment : 0);
  self.laststand_info.type_getup_lives = max(0, (increment ? self.laststand_info.type_getup_lives + 1 : self.laststand_info.type_getup_lives - 1));
  self notify("laststand_lives_updated");
}

function player_getup_setup() {
  println("");
  self.laststand_info = spawnStruct();
  self.laststand_info.type_getup_lives = 0;
}

function laststand_getup_damage_watcher() {
  self endon("player_revived");
  self endon("disconnect");
  while(true) {
    self waittill("damage");
    self.laststand_info.getup_bar_value = self.laststand_info.getup_bar_value - 0.1;
    if(self.laststand_info.getup_bar_value < 0) {
      self.laststand_info.getup_bar_value = 0;
    }
  }
}

function laststand_getup_hud() {
  self endon("player_revived");
  self endon("disconnect");
  hudelem = newclienthudelem(self);
  hudelem.alignx = "left";
  hudelem.aligny = "middle";
  hudelem.horzalign = "left";
  hudelem.vertalign = "middle";
  hudelem.x = 5;
  hudelem.y = 170;
  hudelem.font = "big";
  hudelem.fontscale = 1.5;
  hudelem.foreground = 1;
  hudelem.hidewheninmenu = 1;
  hudelem.hidewhendead = 1;
  hudelem.sort = 2;
  hudelem.label = & "SO_WAR_LASTSTAND_GETUP_BAR";
  self thread laststand_getup_hud_destroy(hudelem);
  while(true) {
    hudelem setvalue(self.laststand_info.getup_bar_value);
    wait(0.05);
  }
}

function laststand_getup_hud_destroy(hudelem) {
  self util::waittill_either("player_revived", "disconnect");
  hudelem destroy();
}

function cleanup_laststand_on_disconnect() {
  self endon("player_revived");
  self endon("player_suicide");
  self endon("bled_out");
  trig = self.revivetrigger;
  self waittill("disconnect");
  if(isDefined(trig)) {
    trig delete();
  }
}