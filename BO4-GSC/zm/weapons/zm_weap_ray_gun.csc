/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_ray_gun.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_weap_ray_gun;

autoexec __init__system__() {
  system::register(#"ray_gun", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"hash_64dc4c79d9035fca"] = #"hash_73bf7604340dd645";
  level._effect[#"hash_41c6282937fa564d"] = #"zombie/fx_powerup_on_green_zmb";
  level._effect[#"hash_537eedf1dffba786"] = #"zombie/fx_powerup_grab_green_zmb";
  clientfield::register("actor", "raygun_disintegrate", 20000, 1, "counter", &function_2602ff58, 0, 0);
}

function_2602ff58(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self playrenderoverridebundle(#"hash_1d387211bf187bab");
  util::playFXOnTag(localclientnum, level._effect[#"hash_41c6282937fa564d"], self, "j_spinelower");
  wait 0.55;
  util::playFXOnTag(localclientnum, level._effect[#"hash_41c6282937fa564d"], self, "j_spinelower");
  util::playFXOnTag(localclientnum, level._effect[#"hash_537eedf1dffba786"], self, "j_spinelower");
  util::playFXOnTag(localclientnum, level._effect[#"hash_41c6282937fa564d"], self, "j_head");
  util::playFXOnTag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_head");
  util::playFXOnTag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_shoulder_le");
  util::playFXOnTag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_elbow_le");
  util::playFXOnTag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_hip_ri");
  util::playFXOnTag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_knee_le");
}