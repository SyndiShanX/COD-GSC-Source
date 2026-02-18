/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_31a4e84bd38b34e2.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_5443b356;

function autoexec main() {
  clientfield::register("toplayer", "player_cam_blur", 1, 1, "int", &player_cam_blur, 0, 1);
  clientfield::register("toplayer", "player_cam_bubbles", 1, 1, "int", &player_cam_bubbles, 0, 1);
  clientfield::register("toplayer", "player_cam_fire", 1, 1, "int", &player_cam_fire, 0, 0);
}

function player_cam_blur(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1 && !function_1cbf351b(fieldname)) {
    self thread function_3c4a545b(fieldname);
    return;
  }

  self notify(#"hash_31875ebd426b00c1");
}

function function_3c4a545b(localclientnum) {
  self endon(#"disconnect");
  self endon(#"hash_31875ebd426b00c1");
  var_f052fbf4 = 0.5;

  while(var_f052fbf4 <= 1) {
    var_f052fbf4 += 0.04;
    waitframe(1);
  }
}

function player_cam_bubbles(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1 && !function_1cbf351b(fieldname)) {
    if(isDefined(self.n_fx_id)) {
      deletefx(fieldname, self.n_fx_id, 1);
    }

    self.n_fx_id = playfxoncamera(fieldname, "player/fx_plyr_swim_bubbles_body", (0, 0, 0), (1, 0, 0), (0, 0, 1));
    self playrumbleonentity(fieldname, "damage_heavy");
    return;
  }

  if(isDefined(self.n_fx_id)) {
    deletefx(fieldname, self.n_fx_id, 1);
  }
}

function player_cam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1 && !function_1cbf351b(fieldname)) {
    burn_on_postfx();
    return;
  }

  function_97a0dd0a();
}

function burn_on_postfx() {
  self endon(#"disconnect");
  self endon(#"hash_8098b25d66c781c");
  self thread postfx::playpostfxbundle(#"pstfx_burn_loop");
}

function function_97a0dd0a() {
  self notify(#"hash_8098b25d66c781c");
  self postfx::stoppostfxbundle("pstfx_burn_loop");
}