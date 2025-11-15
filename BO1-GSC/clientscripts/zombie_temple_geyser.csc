/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombie_temple_geyser.csc
**************************************************/

#include clientscripts\_utility;
#include clientscripts\_music;
#include clientscripts\_zombiemode_weapons;

main() {
  init_player_geyser_anims();
  register_clientflag_callback("player", level._CF_PLAYER_GEYSER_FAKE_PLAYER_SETUP_PRONE, ::geyser_player_setup_prone);
  register_clientflag_callback("player", level._CF_PLAYER_GEYSER_FAKE_PLAYER_SETUP_STAND, ::geyser_player_setup_stand);
}

#using_animtree("zombie_coast");
init_player_geyser_anims() {
  level.geyser_anims = [];
  level.geyser_anims["player_geyser_stand_crouch"] = % pb_rifle_stand_flinger_flail;
  level.geyser_anims["player_geyser_prone"] = % pb_rifle_prone_flinger_flail;
  level.geyser_animtree = #animtree;
}

#using_animtree("zombie_coast");
geyser_player_setup_prone(localClientNum, set, newEnt) {
  if(self isspectating()) {
    return;
  }
  player = getLocalPlayers()[localClientNum];
  if(player getEntityNumber() == self getEntityNumber()) {
    if(set) {
      self playRumbleOnEntity(localClientNum, "slide_rumble");
    } else {
      self stopRumble(localClientNum, "slide_rumble");
    }
    return;
  }
  if(set) {
    if(localClientNum == 0) {
      self thread player_disconnect_tracker();
    }
    fake_player = spawn(localClientNum, self.origin + (0, 0, -800), "script_model");
    fake_player.angles = self.angles;
    fake_player setModel(self.model);
    if(self.model == "c_ger_richtofen_body") {
      fake_player Attach("c_ger_richtofen_head", "J_Spine4");
      fake_player Attach("c_ger_richtofen_offcap", "J_Head");
    }
    fake_player.fake_weapon = spawn(localClientNum, self.origin, "script_model");
    if(self.weapon != "none" && self.weapon != "syrette_sp") {
      fake_player.fake_weapon setModel(getweaponmodel(self.weapon));
      fake_player.fake_weapon useweaponhidetags(self.weapon);
    } else {
      self thread geyser_weapon_monitor(fake_player.fake_weapon);
    }
    fake_player.fake_weapon LinkTo(fake_player, "tag_weapon_right");
    realWait(0.016);
    fake_player linkto(self, "tag_origin");
    fake_player UseAnimTree(level.geyser_animtree);
    fake_player SetAnim(level.geyser_anims["player_geyser_prone"], 1.0, 0.0, 1.0);
    if(!isDefined(self.fake_player)) {
      self.fake_player = [];
    }
    self.fake_player[localClientNum] = fake_player;
    self thread wait_for_geyser_player_to_disconnect(localClientNum);
  } else {
    if(!isDefined(self.fake_player) && !isDefined(self.fake_player[localClientNum])) {
      return;
    }
    str_notify = "player_geyser" + localClientNum;
    self notify(str_notify);
    self notify("end_geyser");
    if(isDefined(self.fake_player[localClientNum].fake_weapon)) {
      self.fake_player[localClientNum].fake_weapon Delete();
      self.fake_player[localClientNum].fake_weapon = undefined;
    }
    self.fake_player[localClientNum] delete();
    self.fake_player[localClientNum] = undefined;
  }
}

#using_animtree("zombie_coast");
geyser_player_setup_stand(localClientNum, set, newEnt) {
  if(self isspectating()) {
    return;
  }
  player = getLocalPlayers()[localClientNum];
  if(player getEntityNumber() == self getEntityNumber()) {
    if(set) {
      self playRumbleOnEntity(localClientNum, "slide_rumble");
    } else {
      self stopRumble(localClientNum, "slide_rumble");
    }
    return;
  }
  if(set) {
    if(localClientNum == 0) {
      self thread player_disconnect_tracker();
    }
    fake_player = spawn(localClientNum, self.origin + (0, 0, -800), "script_model");
    fake_player.angles = self.angles;
    fake_player setModel(self.model);
    if(self.model == "c_ger_richtofen_body") {
      fake_player Attach("c_ger_richtofen_head", "J_Spine4");
      fake_player Attach("c_ger_richtofen_offcap", "J_Head");
    }
    fake_player.fake_weapon = spawn(localClientNum, self.origin, "script_model");
    if(self.weapon != "none" && self.weapon != "syrette_sp") {
      fake_player.fake_weapon setModel(getweaponmodel(self.weapon));
      fake_player.fake_weapon useweaponhidetags(self.weapon);
    } else {
      self thread geyser_weapon_monitor(fake_player.fake_weapon);
    }
    fake_player.fake_weapon LinkTo(fake_player, "tag_weapon_right");
    realWait(0.016);
    fake_player linkto(self, "tag_origin");
    fake_player UseAnimTree(level.geyser_animtree);
    fake_player SetAnim(level.geyser_anims["player_geyser_stand_crouch"], 1.0, 0.0, 1.0);
    if(!isDefined(self.fake_player)) {
      self.fake_player = [];
    }
    self.fake_player[localClientNum] = fake_player;
    self thread wait_for_geyser_player_to_disconnect(localClientNum);
  } else {
    if(!isDefined(self.fake_player) && !isDefined(self.fake_player[localClientNum])) {
      return;
    }
    str_notify = "player_geyser" + localClientNum;
    self notify(str_notify);
    self notify("end_geyser");
    if(isDefined(self.fake_player[localClientNum].fake_weapon)) {
      self.fake_player[localClientNum].fake_weapon Delete();
      self.fake_player[localClientNum].fake_weapon = undefined;
    }
    self.fake_player[localClientNum] delete();
    self.fake_player[localClientNum] = undefined;
  }
}

geyser_weapon_monitor(fake_weapon) {
  self endon("end_geyser");
  self endon("disconnect");
  while(self.weapon == "none") {
    wait(.05);
  }
  if(self.weapon != "syrette_sp") {
    fake_weapon setModel(getweaponmodel(self.weapon));
    fake_weapon useweaponhidetags(self.weapon);
  }
}

player_disconnect_tracker() {
  self notify("stop_tracking");
  self endon("stop_tracking");
  ent_num = self getEntityNumber();
  while(isDefined(self)) {
    wait(0.05);
  }
  level notify("player_disconnected", ent_num);
}

geyser_model_remover(str_endon, player) {
  player endon(str_endon);
  level waittill("player_disconnected", client);
  if(isDefined(self.fake_weapon)) {
    self.fake_weapon Delete();
  }
  self Delete();
}

wait_for_geyser_player_to_disconnect(localClientNum) {
  str_endon = "player_geyser" + localClientNum;
  self.fake_player[localClientNum] thread geyser_model_remover(str_endon, self);
}