/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_61aaa2ffe334dbde.gsc
*****************************************************/

#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace namespace_9c6af7bc2adacbee;

function private player_death_watcher() {
  player = self;
  player waittill("\x1e\xfd\xd1\xa2\a");

  foreach(value in self.var_7ccdd3805efaedb4.active_list) {
    hud_management::function_d8d634ceece460(value, "\xd8VZW\xd3\xad");
    self.var_7ccdd3805efaedb4.active_list[key] = undefined;
  }
}

function function_d802e1ce8bdd5552() {
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(isDefined(self.var_7ccdd3805efaedb4)) {
    return;
  }

  self.var_7ccdd3805efaedb4 = spawnStruct();
  self.var_7ccdd3805efaedb4.var_31853f4ea7b2be42 = [];
  self.var_7ccdd3805efaedb4.available_count = 7;
  self.var_7ccdd3805efaedb4.active_list = [];
  self.var_7ccdd3805efaedb4.state_list = [];
  level.var_91cd2f2a70229498 = hud_management::function_a1a13273e72bfe46("9\xcd\x99\r\x0f6i\x18\x0f\xa9\x1d\xc7M\xf8\x82`\x96\xbe\xc9\x83B\x13@\x03P\xb1");

  if(!isDefined(level.var_91cd2f2a70229498)) {
    return;
  }

  widget_struct = spawnStruct();
  widget_struct.ent = self;
  widget_struct.anchor_type = "\xf58\xe3\x81{T\xa8\xe5,\x84\xf1P\x96\xa1l\x94f\xda\xc1\r\xd5\x9c\xcc\xbde\x80\x9e\xb7\x83\xe1\f\x93.\f!\x0f9\xd1\x8e\xddu\xfc\xf6\xd1";
  widget_struct.remove_on_death = 0;

  for(i = 0; i < 7; i++) {
    widget_id = "\x8d1\xe7)M<\x11\xfd3S<\a\xad\xf3\xa6\x8d\xce\xcc\xf2b" + "w" + i;
    hud_management::function_35924dfcb78711f4(widget_id, level.var_91cd2f2a70229498, widget_struct);
    hud_management::function_d8d634ceece460(widget_id, "\xd8VZW\xd3\xad");
    self.var_7ccdd3805efaedb4.var_31853f4ea7b2be42 = utility::array_add_safe(self.var_7ccdd3805efaedb4.var_31853f4ea7b2be42, widget_id);
  }

  level utility::flag_set("xL?\xfcd|\x14i|\xe4,E\xa4y<q\xbc\xbc\xf8\x14\xe5");
  thread player_death_watcher();
}

function function_3c22b02277d856c8(ent) {
  assert(isPlayer(self));

  if(!isent(ent)) {
    return false;
  }

  level utility::flag_wait("xL?\xfcd|\x14i|\xe4,E\xa4y<q\xbc\xbc\xf8\x14\xe5");
  ent_num = ent getentitynumber();

  if(utility::array_contains_key(self.var_7ccdd3805efaedb4.active_list, ent_num)) {
    return false;
  }

  if(self.var_7ccdd3805efaedb4.available_count > 0) {
    widget_id = self.var_7ccdd3805efaedb4.var_31853f4ea7b2be42[0];
    self.var_7ccdd3805efaedb4.var_31853f4ea7b2be42 = utility::array_remove_index(self.var_7ccdd3805efaedb4.var_31853f4ea7b2be42, 0);
    self.var_7ccdd3805efaedb4.available_count -= 1;
    self.var_7ccdd3805efaedb4.active_list[ent_num] = widget_id;
    self.var_7ccdd3805efaedb4.state_list[ent_num] = "\xd8VZW\xd3\xad";
    hud_management::function_7b7d992c0de840f(widget_id, ent, "\xf58\xe3\x81{T\xa8\xe5,\x84\xf1P\x96\xa1l\x94f\xda\xc1\r\xd5\x9c\xcc\xbde\x80\x9e\xb7\x83\xe1\f\x93.\f!\x0f9\xd1\x8e\xddu\xfc\xf6\xd1");
    return true;
  }

  return false;
}

function function_3f42c8f248f0224(ent_num) {
  assert(isPlayer(self));
  widget_id = self.var_7ccdd3805efaedb4.active_list[ent_num];
  hud_management::function_7b7d992c0de840f(widget_id, self, "\xf58\xe3\x81{T\xa8\xe5,\x84\xf1P\x96\xa1l\x94f\xda\xc1\r\xd5\x9c\xcc\xbde\x80\x9e\xb7\x83\xe1\f\x93.\f!\x0f9\xd1\x8e\xddu\xfc\xf6\xd1");
  hud_management::function_d8d634ceece460(widget_id, "\xd8VZW\xd3\xad");
  self.var_7ccdd3805efaedb4.var_31853f4ea7b2be42 = utility::array_add_safe(self.var_7ccdd3805efaedb4.var_31853f4ea7b2be42, widget_id);
  self.var_7ccdd3805efaedb4.available_count += 1;
  self.var_7ccdd3805efaedb4.active_list[ent_num] = undefined;
  self.var_7ccdd3805efaedb4.state_list[ent_num] = undefined;
  self notify("~\x19vt<\x88\xe7NO2j\x99\x0e\x16dP\x02\r\xea&\xf6\xb6\xe1J\xc1" + ent_num);
}

function function_ca98fa678e58d265(ent, state) {
  assert(isPlayer(self));

  if(!isent(ent)) {
    return;
  }

  ent_num = ent getentitynumber();
  widget_id = self.var_7ccdd3805efaedb4.active_list[ent_num];

  if(isDefined(widget_id)) {
    hud_management::function_d8d634ceece460(widget_id, state);
    self.var_7ccdd3805efaedb4.state_list[ent_num] = state;
  }
}

function function_6ee8c20e1f070ac1(ent, state) {
  assert(isPlayer(self));

  if(!isent(ent)) {
    return;
  }

  ent_num = ent getentitynumber();
  return self.var_7ccdd3805efaedb4.state_list[ent_num] ?? "";
}

function function_94bed235dabe3f88(ent) {
  if(isDefined(ent) && isDefined(ent.var_aa1196ec47eb6ee9)) {
    function_57e21adead9922be(ent, ent.var_aa1196ec47eb6ee9);
  }
}

function function_57e21adead9922be(ent, data) {
  assert(isPlayer(self));

  if(!isent(ent)) {
    return;
  }

  ent_num = ent getentitynumber();
  widget_id = self.var_7ccdd3805efaedb4.active_list[ent_num];

  if(isDefined(widget_id)) {
    hud_management::function_41ff479ac45608d6(widget_id, data);
  }
}

function function_aaf323f136885fe7(ent_num) {
  assert(isPlayer(self));
  widget_id = self.var_7ccdd3805efaedb4.active_list[ent_num];

  if(isDefined(widget_id)) {
    return true;
  }

  return false;
}