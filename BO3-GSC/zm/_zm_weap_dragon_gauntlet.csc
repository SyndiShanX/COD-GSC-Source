/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_dragon_gauntlet.csc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicles\_dragon_whelp;
#using scripts\zm\_callbacks;
#namespace zm_weap_dragon_gauntlet;

function autoexec __init__sytem__() {
  system::register("zm_weap_dragon_gauntlet", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_localplayer_spawned( & player_on_spawned);
}

function player_on_spawned(localclientnum) {
  self thread watch_weapon_changes(localclientnum);
}

function watch_weapon_changes(localclientnum) {
  self endon("disconnect");
  self endon("entityshutdown");
  self.dragon_gauntlet = getweapon("dragon_gauntlet_flamethrower");
  self.var_dd5c3be0 = getweapon("dragon_gauntlet");
  while(isDefined(self)) {
    self waittill("weapon_change", weapon);
    if(weapon === self.dragon_gauntlet) {
      self thread function_7645efdb(localclientnum);
      self thread function_6c7c9327(localclientnum);
      self notify("hash_7c243ce8");
    }
    if(weapon === self.var_dd5c3be0) {
      self thread function_99aba1a5(localclientnum);
      self thread function_a8ac2d1d(localclientnum);
      self thread function_3011ccf6(localclientnum);
    }
    if(weapon !== self.dragon_gauntlet && weapon !== self.var_dd5c3be0) {
      self function_99aba1a5(localclientnum);
      self function_7645efdb(localclientnum);
      self notify("hash_7c243ce8");
    }
  }
}

function function_6c7c9327(localclientnum) {
  self endon("disconnect");
  self util::waittill_any_timeout(0.5, "weapon_change_complete", "disconnect");
  if(getcurrentweapon(localclientnum) === getweapon("dragon_gauntlet_flamethrower")) {
    if(!isDefined(self.var_11d5152b)) {
      self.var_11d5152b = [];
    }
    self.var_11d5152b[self.var_11d5152b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_orange_glow1", "tag_fx_7");
    self.var_11d5152b[self.var_11d5152b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_orange_glow2", "tag_fx_6");
    self.var_11d5152b[self.var_11d5152b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_whelp_eye_glow_sm", "tag_eye_left_fx");
    self.var_11d5152b[self.var_11d5152b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_whelp_mouth_drips_sm", "tag_throat_fx");
  }
}

function function_a8ac2d1d(localclientnum) {
  self endon("disconnect");
  self util::waittill_any_timeout(0.5, "weapon_change_complete", "disconnect");
  if(getcurrentweapon(localclientnum) === getweapon("dragon_gauntlet")) {
    if(!isDefined(self.var_a7abd31)) {
      self.var_a7abd31 = [];
    }
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow1", "tag_fx_7");
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow2", "tag_fx_6");
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger2", "tag_fx_1");
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger", "tag_fx_2");
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger", "tag_fx_3");
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger", "tag_fx_4");
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube", "tag_gauntlet_tube_01");
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube", "tag_gauntlet_tube_02");
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube", "tag_gauntlet_tube_03");
    self.var_a7abd31[self.var_a7abd31.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube", "tag_gauntlet_tube_04");
  }
}

function function_99aba1a5(localclientnum) {
  if(isDefined(self.var_11d5152b) && self.var_11d5152b.size > 0) {
    foreach(fx in self.var_11d5152b) {
      stopfx(localclientnum, fx);
    }
  }
}

function function_7645efdb(localclientnum) {
  if(isDefined(self.var_a7abd31) && self.var_a7abd31.size > 0) {
    foreach(fx in self.var_a7abd31) {
      stopfx(localclientnum, fx);
    }
  }
}

function function_3011ccf6(localclientnum) {
  self endon("disconnect");
  self endon("death");
  self endon("bled_out");
  self endon("hash_7c243ce8");
  self notify("hash_8d98e9db");
  self endon("hash_8d98e9db");
  while(isDefined(self)) {
    self waittill("notetrack", note);
    if(note === "dragon_gauntlet_115_punch_fx_start") {
      if(!isDefined(self.var_4d73e75b)) {
        self.var_4d73e75b = [];
      }
      self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger3", "tag_fx_1");
      self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger3", "tag_fx_2");
      self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger3", "tag_fx_3");
      self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_glow_finger3", "tag_fx_4");
      self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube2", "tag_gauntlet_tube_01");
      self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube2", "tag_gauntlet_tube_02");
      self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube2", "tag_gauntlet_tube_03");
      self.var_4d73e75b[self.var_4d73e75b.size] = playviewmodelfx(localclientnum, "dlc3/stalingrad/fx_dragon_gauntlet_glove_blue_tube2", "tag_gauntlet_tube_04");
    }
    if(note === "dragon_gauntlet_115_punch_fx_stop") {
      if(isDefined(self.var_4d73e75b) && self.var_4d73e75b.size > 0) {
        foreach(fx in self.var_4d73e75b) {
          stopfx(localclientnum, fx);
        }
      }
    }
  }
}