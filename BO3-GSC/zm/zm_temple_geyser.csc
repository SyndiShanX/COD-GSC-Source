/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_geyser.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\util_shared;
#using_animtree("generic");
#namespace zm_temple_geyser;

function main() {
  clientfield::register("allplayers", "geyserfakestand", 21000, 1, "int", & geyser_player_setup_stand, 0, 0);
  clientfield::register("allplayers", "geyserfakeprone", 21000, 1, "int", & geyser_player_setup_prone, 0, 0);
}

function geyser_player_setup_prone(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isspectating(localclientnum, 0)) {
    return;
  }
  player = getlocalplayers()[localclientnum];
  if(player getentitynumber() == self getentitynumber()) {
    if(newval) {
      self playrumbleonentity(localclientnum, "slide_rumble");
    } else {
      self stoprumble(localclientnum, "slide_rumble");
    }
    return;
  }
  if(newval) {
    if(localclientnum == 0) {
      self thread player_disconnect_tracker();
    }
    fake_player = spawn(localclientnum, self.origin + (vectorscale((0, 0, -1), 800)), "script_model");
    fake_player.angles = self.angles;
    fake_player setModel(self.model);
    if(self.model == "c_ger_richtofen_body") {
      fake_player attach("c_ger_richtofen_head", "J_Spine4");
      fake_player attach("c_ger_richtofen_offcap", "J_Head");
    }
    fake_player.fake_weapon = spawn(localclientnum, self.origin, "script_model");
    if(self.weapon != "none" && self.weapon != "syrette") {
      fake_player.fake_weapon useweaponhidetags(self.weapon);
    } else {
      self thread geyser_weapon_monitor(fake_player.fake_weapon);
    }
    fake_player.fake_weapon linkto(fake_player, "tag_weapon_right");
    waitrealtime(0.016);
    fake_player linkto(self, "tag_origin");
    if(!isDefined(self.fake_player)) {
      self.fake_player = [];
    }
    self.fake_player[localclientnum] = fake_player;
    self thread wait_for_geyser_player_to_disconnect(localclientnum);
  } else {
    if(!isDefined(self.fake_player) && !isDefined(self.fake_player[localclientnum])) {
      return;
    }
    str_notify = "player_geyser" + localclientnum;
    self notify(str_notify);
    self notify("end_geyser");
    if(isDefined(self.fake_player[localclientnum].fake_weapon)) {
      self.fake_player[localclientnum].fake_weapon delete();
      self.fake_player[localclientnum].fake_weapon = undefined;
    }
    self.fake_player[localclientnum] delete();
    self.fake_player[localclientnum] = undefined;
  }
}

function geyser_player_setup_stand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isspectating(localclientnum, 0)) {
    return;
  }
  player = getlocalplayers()[localclientnum];
  if(player getentitynumber() == self getentitynumber()) {
    if(newval) {
      self playrumbleonentity(localclientnum, "slide_rumble");
    } else {
      self stoprumble(localclientnum, "slide_rumble");
    }
    return;
  }
  if(newval) {
    if(localclientnum == 0) {
      self thread player_disconnect_tracker();
    }
    fake_player = spawn(localclientnum, self.origin + (vectorscale((0, 0, -1), 800)), "script_model");
    fake_player.angles = self.angles;
    fake_player setModel(self.model);
    if(self.model == "c_ger_richtofen_body") {
      fake_player attach("c_ger_richtofen_head", "J_Spine4");
      fake_player attach("c_ger_richtofen_offcap", "J_Head");
    }
    fake_player.fake_weapon = spawn(localclientnum, self.origin, "script_model");
    if(self.weapon.name != "none" && self.weapon.name != "syrette") {
      fake_player.fake_weapon useweaponhidetags(self.weapon);
    } else {
      self thread geyser_weapon_monitor(fake_player.fake_weapon);
    }
    fake_player.fake_weapon linkto(fake_player, "tag_weapon_right");
    waitrealtime(0.016);
    fake_player.origin = self.origin;
    fake_player linkto(self, "tag_origin");
    if(!isDefined(self.fake_player)) {
      self.fake_player = [];
    }
    self.fake_player[localclientnum] = fake_player;
    self thread wait_for_geyser_player_to_disconnect(localclientnum);
  } else {
    if(!isDefined(self.fake_player) || !isDefined(self.fake_player[localclientnum])) {
      return;
    }
    str_notify = "player_geyser" + localclientnum;
    self notify(str_notify);
    self notify("end_geyser");
    if(isDefined(self.fake_player[localclientnum].fake_weapon)) {
      self.fake_player[localclientnum].fake_weapon delete();
      self.fake_player[localclientnum].fake_weapon = undefined;
    }
    self.fake_player[localclientnum] delete();
    self.fake_player[localclientnum] = undefined;
  }
}

function geyser_weapon_monitor(fake_weapon) {
  self endon("end_geyser");
  self endon("disconnect");
  while(self.weapon == "none") {
    wait(0.05);
  }
  if(self.weapon != "syrette") {
    fake_weapon useweaponhidetags(self.weapon);
  }
}

function player_disconnect_tracker() {
  self notify("stop_tracking");
  self endon("stop_tracking");
  ent_num = self getentitynumber();
  while(isDefined(self)) {
    wait(0.05);
  }
  level notify("player_disconnected", ent_num);
}

function geyser_model_remover(str_endon, player) {
  player endon(str_endon);
  level waittill("player_disconnected", client);
  if(isDefined(self.fake_weapon)) {
    self.fake_weapon delete();
  }
  self delete();
}

function wait_for_geyser_player_to_disconnect(localclientnum) {
  str_endon = "player_geyser" + localclientnum;
  self.fake_player[localclientnum] thread geyser_model_remover(str_endon, self);
}