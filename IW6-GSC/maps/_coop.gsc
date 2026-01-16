/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_coop.gsc
*****************************************************/

main() {
  common_scripts\utility::flag_init("coop_game");

  if(!maps\_utility::is_coop()) {
    return;
  }
  common_scripts\utility::flag_set("coop_game");
  common_scripts\utility::flag_init("coop_show_constant_icon");
  setdvarifuninitialized("coop_show_constant_icon", 1);

  if(getdvarint("coop_show_constant_icon") == 1)
    common_scripts\utility::flag_set("coop_show_constant_icon");

  precacheshader("hint_health");
  precacheshader("coop_player_location");
  precacheshader("coop_player_location_fire");
  level.coop_icon_blinktime = 7;
  level.coop_icon_blinkcrement = 0.375;
  level.coop_revive_nag_hud_refreshtime = 20;

  foreach(var_1 in level.players) {
    var_1.colorblind = var_1 getlocalplayerprofiledata("colorBlind");
    var_1 thread initialize_colors(var_1.colorblind);
    var_1 thread friendly_hud_init();
  }
}

initialize_colors(var_0) {
  if(var_0) {
    var_1 = (0.35, 1, 1);
    var_2 = (1, 0.65, 0.2);
    var_3 = (1, 1, 1);
    self.coop_icon_color_normal = var_1;
    self.coop_icon_color_downed = var_2;
    self.coop_icon_color_shoot = var_1;
    self.coop_icon_color_damage = var_3;
    self.coop_icon_color_dying = var_2;
    self.coop_icon_color_blink = var_3;
  } else {
    var_4 = (0.635, 0.929, 0.604);
    var_5 = (1, 1, 0.2);
    var_2 = (1, 0.65, 0.2);
    var_6 = (1, 0.2, 0.2);
    var_3 = (1, 1, 1);
    self.coop_icon_color_normal = var_4;
    self.coop_icon_color_downed = var_5;
    self.coop_icon_color_shoot = var_4;
    self.coop_icon_color_damage = var_2;
    self.coop_icon_color_dying = var_6;
    self.coop_icon_color_blink = var_3;
  }
}

rebuild_friendly_icon(var_0, var_1, var_2) {
  if(isDefined(self.nofriendlyhudicon)) {
    return;
  }
  if(!isDefined(self.friendlyicon) || self.friendlyicon.material != var_1)
    create_fresh_friendly_icon(var_1);

  self.friendlyicon.color = var_0;

  if(isDefined(var_2) && var_2)
    self.friendlyicon setwaypointedgestyle_rotatingicon();
}

create_fresh_friendly_icon(var_0) {
  if(isDefined(self.friendlyicon))
    self.friendlyicon destroy();

  self.friendlyicon = newclienthudelem(self);
  self.friendlyicon setshader(var_0, 1, 1);
  self.friendlyicon setwaypoint(1, 1, 0);
  self.friendlyicon setwaypointiconoffscreenonly();
  self.friendlyicon settargetent(maps\_utility::get_other_player(self));
  self.friendlyicon.material = var_0;
  self.friendlyicon.hidewheninmenu = 1;

  if(common_scripts\utility::flag("coop_show_constant_icon"))
    self.friendlyicon.alpha = 1.0;
  else
    self.friendlyicon.alpha = 0.0;
}

friendly_hud_icon_blink_on_fire() {
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    var_0 = maps\_utility::get_other_player(self);
    var_0 thread friendly_hud_icon_flash(var_0.coop_icon_color_shoot, "coop_player_location_fire", 1);
  }
}

friendly_hud_icon_blink_on_damage() {
  self endon("death");

  for(;;) {
    self waittill("damage");
    var_0 = maps\_utility::get_other_player(self);
    var_0 thread friendly_hud_icon_flash(var_0.coop_icon_color_damage, "coop_player_location", 1);
  }
}

friendly_hud_icon_flash(var_0, var_1, var_2) {
  if(isDefined(self.nofriendlyhudicon)) {
    return;
  }
  self endon("death");
  self notify("flash_color_thread");
  self endon("flash_color_thread");
  var_3 = maps\_utility::get_other_player(self);

  if(maps\_utility::is_player_down(var_3)) {
    return;
  }
  rebuild_friendly_icon(var_0, var_1, var_2);
  wait 0.5;
  var_1 = friendlyhudicon_currentmaterial();
  var_4 = friendlyhudicon_rotating();
  rebuild_friendly_icon(self.coop_icon_color_normal, var_1, var_4);
}

friendly_hud_init() {
  level endon("special_op_terminated");
  friendlyhudicon_normal();
  thread friendly_hud_icon_blink_on_fire();
  thread friendly_hud_icon_blink_on_damage();
  thread monitor_color_blind_toggle();
  thread friendly_hud_destroy_on_mission_end();

  if(isDefined(self.nofriendlyhudicon)) {
    return;
  }
  self.friendlyicon.alpha = 0.0;

  for(;;) {
    common_scripts\utility::flag_wait("coop_show_constant_icon");
    self.friendlyicon.alpha = 1.0;
    common_scripts\utility::flag_waitopen("coop_show_constant_icon");
    self.friendlyicon.alpha = 0.0;
  }
}

friendly_hud_destroy_on_mission_end() {
  level waittill("special_op_terminated");

  foreach(var_1 in level.players)
  var_1 player_friendly_hud_destroy();
}

player_friendly_hud_destroy() {
  if(isDefined(self.friendlyicon))
    self.friendlyicon destroy();
}

friendlyhudicon_hideall() {
  common_scripts\utility::flag_clear("coop_show_constant_icon");
}

friendlyhudicon_showall() {
  common_scripts\utility::flag_set("coop_show_constant_icon");
}

friendlyhudicon_disable() {
  self.nofriendlyhudicon = 1;
  player_friendly_hud_destroy();
}

friendlyhudicon_enable() {
  self.nofriendlyhudicon = undefined;

  if(!isDefined(self.friendlyicon))
    friendlyhudicon_normal();
}

friendlyhudicon_normal() {
  if(!common_scripts\utility::flag("coop_game")) {
    return;
  }
  self.coop_icon_state = "ICON_STATE_NORMAL";
  var_0 = friendlyhudicon_currentmaterial();
  var_1 = friendlyhudicon_rotating();
  rebuild_friendly_icon(self.coop_icon_color_normal, var_0, var_1);
}

friendlyhudicon_downed() {
  if(!common_scripts\utility::flag("coop_game")) {
    return;
  }
  self.coop_icon_state = "ICON_STATE_DOWNED";
  var_0 = friendlyhudicon_currentmaterial();
  var_1 = friendlyhudicon_rotating();
  rebuild_friendly_icon(self.coop_icon_color_downed, var_0, var_1);
}

friendlyhudicon_update(var_0) {
  if(!common_scripts\utility::flag("coop_game")) {
    return;
  }
  var_1 = friendlyhudicon_currentmaterial();
  var_2 = friendlyhudicon_rotating();
  rebuild_friendly_icon(var_0, var_1, var_2);
}

friendlyhudicon_currentmaterial() {
  var_0 = "coop_player_location";

  switch (self.coop_icon_state) {
    case "ICON_STATE_NORMAL":
      var_0 = "coop_player_location";
      break;
    case "ICON_STATE_DOWNED":
      var_0 = "hint_health";
      break;
    default:
      break;
  }

  return var_0;
}

friendlyhudicon_rotating() {
  var_0 = 0;

  switch (self.coop_icon_state) {
    case "ICON_STATE_NORMAL":
      var_0 = 1;
      break;
    case "ICON_STATE_DOWNED":
      var_0 = 0;
      break;
    default:
      break;
  }

  return var_0;
}

monitor_color_blind_toggle() {
  for(;;) {
    if(self getlocalplayerprofiledata("colorBlind") != self.colorblind) {
      self.colorblind = self getlocalplayerprofiledata("colorBlind");
      initialize_colors(self.colorblind);

      switch (self.coop_icon_state) {
        case "ICON_STATE_NORMAL":
          friendlyhudicon_normal();
          break;
        case "ICON_STATE_DOWNED":
          friendlyhudicon_downed();
          break;
      }
    }

    wait 0.05;
  }
}