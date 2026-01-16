/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_player_cam.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace namespace_5f11fb0b;

function autoexec main() {
  clientfield::register("toplayer", "player_cam_blur", 1, 1, "int", & player_cam_blur, 0, 1);
  clientfield::register("toplayer", "player_cam_bubbles", 1, 1, "int", & player_cam_bubbles, 0, 1);
  clientfield::register("toplayer", "player_cam_fire", 1, 1, "int", & player_cam_fire, 0, 1);
}

function player_cam_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1 && !getinkillcam(localclientnum)) {
    blurandtint_fx(localclientnum, 1, 0.5);
    self thread function_db5afebe(localclientnum);
  } else {
    blurandtint_fx(localclientnum, 0);
    self notify("hash_64e72e9d");
  }
}

function function_db5afebe(localclientnum) {
  self endon("disconnect");
  self endon("hash_64e72e9d");
  blur_level = 0.5;
  while (blur_level <= 1) {
    blur_level = blur_level + 0.04;
    blurandtint_fx(localclientnum, 1, blur_level);
    wait(0.05);
  }
}

function player_cam_bubbles(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1 && !getinkillcam(localclientnum)) {
    if(isdefined(self.n_fx_id)) {
      deletefx(localclientnum, self.n_fx_id, 1);
    }
    self.n_fx_id = playfxoncamera(localclientnum, "player/fx_plyr_swim_bubbles_body", (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self playrumbleonentity(localclientnum, "damage_heavy");
  } else if(isdefined(self.n_fx_id)) {
    deletefx(localclientnum, self.n_fx_id, 1);
  }
}

function player_cam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1 && !getinkillcam(localclientnum)) {
    burn_on_postfx();
  } else {
    function_7a5c3cf3();
  }
}

function burn_on_postfx() {
  self endon("disconnect");
  self endon("hash_bdb63a72");
  self thread postfx::playpostfxbundle("pstfx_burn_loop");
}

function function_7a5c3cf3() {
  self notify("hash_bdb63a72");
  self postfx::stoppostfxbundle();
}