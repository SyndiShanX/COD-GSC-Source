/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\Player.gsc
***********************************************/

disable_player_weapon_info() {
  setDvar("dvar_C815D5683EEA5B67", 1);
  self setclientomnvar("ui_hide_weapon_info", 1);
}

allow_player_weapon_info(_id_43E5D2EE3D281D80) {
  setDvar("dvar_C815D5683EEA5B67", 0);

  if(isDefined(_id_43E5D2EE3D281D80) && _id_43E5D2EE3D281D80)
    thread show_hud_listener_logic();
}

hud_think() {
  if(getdvarint("dvar_6A05CF71EF55EE41", 0) != 0) {
    return;
  }
  thread button_notifies();
  thread hud_visibility_timer();
  thread show_hud_listener();
}

show_hud_listener() {
  self endon("disconnect");
  self notify("show_hud_listener");
  self endon("show_hud_listener");
  self notifyonplayercommand("reload_pressed", "+usereload");
  self notifyonplayercommand("reload_pressed", "+reload");
  self notifyonplayercommand("use_pressed", "+activate");
  self notifyonplayercommand("use_pressed", "+usereload");
  self notifyonplayercommand("frag_pressed", "+frag");
  self notifyonplayercommand("smoke_pressed", "+smoke");
  self notifyonplayercommand("melee_pressed", "+melee");
  self notifyonplayercommand("melee_pressed", "+melee_zoom");
  self notifyonplayercommand("melee_pressed", "+melee_sprint");
  self notifyonplayercommand("actionslot_weapon_pressed", "+actionslot 1");
  _id_997A68D0145B4469 = ["weapon_fired", "aim", "reload_pressed", "weapon_change", "weapon_swap", "hide_hud_omnvar_changed", "frag_pressed", "smoke_pressed", "offhand_ammo", "offhand_fired", "item_ammo", "item_loot", "show_hud_button_pressed", "show_hud_near_objective", "damage", "night_vision_on", "night_vision_off"];

  for(;;) {
    waittill_hud_event_notify(_id_997A68D0145B4469);
    show_hud_listener_logic();
  }
}

waittill_hud_event_notify(_id_997A68D0145B4469) {
  foreach(_id_A234A65C378F3289 in _id_997A68D0145B4469)
  self endon(_id_A234A65C378F3289);

  self waittill("forever");
}

show_hud_listener_logic() {
  _id_816D67F94D716F7A = self getdemeanorviewmodel();
  primary = self getcurrentprimaryweapon();

  if(_id_816D67F94D716F7A != "safe" && !getdvarint("dvar_C815D5683EEA5B67"))
    self setclientomnvar("ui_hide_weapon_info", 0);

  self notify("cancel_hide_hud");
  wait 1.0;
  thread hud_visibility_timer();
}

hud_visibility_timer() {
  self endon("disconnect");
  self endon("cancel_hide_hud");
  self notify("hud_visibility_timer");
  self endon("hud_visibility_timer");
  wait 20.0;
  self setclientomnvar("ui_hide_weapon_info", 1);
  thread hud_omnvar_change_listener();
}

hud_omnvar_change_listener() {
  self endon("disconnect");
  self notify("hud_omnvar_change_listener");
  self endon("hud_omnvar_change_listener");
  _id_4E2AA722ACD7E66E = self getclientomnvar("ui_hide_hud");
  _id_564E8340EECE203E = self getclientomnvar("ui_hide_weapon_info");

  while(self getclientomnvar("ui_hide_hud") == _id_4E2AA722ACD7E66E && self getclientomnvar("ui_hide_weapon_info") == _id_564E8340EECE203E)
    waitframe();

  self notify("hide_hud_omnvar_changed");
}

button_notifies() {
  self endon("disconnect");
  self notify("button_notifies");
  self endon("button_notifies");
  self notifyonplayercommand("show_hud_button_pressed", "+actionslot 1");
  self notifyonplayercommand("show_hud_button_pressed", "+actionslot 2");
  self notifyonplayercommand("show_hud_button_pressed", "+actionslot 3");
  self notifyonplayercommand("show_hud_button_pressed", "+actionslot 4");
  self notifyonplayercommand("show_hud_button_pressed", "night_vision_on");
  self notifyonplayercommand("show_hud_button_pressed", "night_vision_off");
  self notifyonplayercommand("show_hud_button_pressed", "+weapnext");

  for(;;) {
    if(self adsButtonPressed())
      self notify("aim");

    if(self meleeButtonPressed())
      self notify("melee");

    waitframe();
  }
}

hide_hud_on_death() {
  self waittill("death");
  self setclientomnvar("ui_hide_weapon_info", 1);
}