/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_20fe86d43b7f18f1.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\util_shared;
#namespace namespace_14ee8104;

function function_54d0d2d1(localclientnum) {
  if(isDefined(self.var_553a42c)) {
    return;
  }

  if(!isDefined(self) || !isentity(self)) {
    return;
  }

  self.var_553a42c = [];
  zombie = self function_b439ef43(localclientnum, #"c_t9_zmb_hulking_summoner_zombie1", "tag_zom1_LE", "ai_t9_zm_hulkingsum_attached_zombie_01");
  array::add(self.var_553a42c, zombie);
  zombie = self function_b439ef43(localclientnum, #"c_t9_zmb_hulking_summoner_zombie2", "tag_zom2_LE", "ai_t9_zm_hulkingsum_attached_zombie_02");
  array::add(self.var_553a42c, zombie);
  zombie = self function_b439ef43(localclientnum, #"hash_56156f3147132aa4", "tag_zom3_LE", "ai_t9_zm_hulkingsum_attached_zombie_03");
  array::add(self.var_553a42c, zombie);
  zombie = self function_b439ef43(localclientnum, #"c_t9_zmb_hulking_summoner_zombie1", "tag_zom1_RI", "ai_t9_zm_hulkingsum_attached_zombie_04");
  array::add(self.var_553a42c, zombie);
  zombie = self function_b439ef43(localclientnum, #"c_t9_zmb_hulking_summoner_zombie2", "tag_zom2_RI", "ai_t9_zm_hulkingsum_attached_zombie_05");
  array::add(self.var_553a42c, zombie);
  zombie = self function_b439ef43(localclientnum, #"hash_56156f3147132aa4", "tag_zom3_RI", "ai_t9_zm_hulkingsum_attached_zombie_06");
  array::add(self.var_553a42c, zombie);
  zombie = self function_b439ef43(localclientnum, #"hash_56156e31471328f1", "tag_zom4_RI", "ai_t9_zm_hulkingsum_attached_zombie_07");
  array::add(self.var_553a42c, zombie);
  self thread function_65300f49();
}

function private function_b439ef43(localclientnum, model, tag, animname) {
  tag_origin = self gettagorigin(tag);
  tag_angles = self gettagangles(tag);
  zombie = util::spawn_model(localclientnum, model, tag_origin, tag_angles);
  zombie linkto(self, tag);
  zombie useanimtree("zm_ai_hulk");
  zombie setanim(animname, 1, 0, 1);
  return zombie;
}

function private function_65300f49() {
  level endon(#"end_game");
  self waittill(#"death");
  var_553a42c = self.var_553a42c;

  foreach(zombie in var_553a42c) {
    if(isDefined(zombie)) {
      zombie delete();
    }
  }

  if(isDefined(self)) {
    self.var_553a42c = undefined;
  }
}