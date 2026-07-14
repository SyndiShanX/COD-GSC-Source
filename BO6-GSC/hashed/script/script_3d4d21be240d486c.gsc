/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_3d4d21be240d486c.gsc
*****************************************************/

#using script_26f456dbdf9aa216;
#using scripts\anim\dialogue;
#namespace clear_lkp_one_member;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_f4ef887f81fa60d9":
      return &function_389783bac1e5cfce;
    case #"hash_47b3d8e9cd6ccd4a":
      return &function_323d874e6bdc218b;
    case #"hash_871307852fe531bf":
      return &function_f2b49cf03a71061e;
    case #"hash_4bc3c13aae411fc":
      return &function_77665c010b74bf65;
    case #"hash_bf509799ad09e3fb":
      return &function_b4c8cc8d02ad0b95;
    case #"hash_cfc7861edb6bdc95":
      return &function_dabb6663ba0a5177;
    case #"hash_bb5cf3d8738e8519":
      return &playdialog;
    case #"hash_80804c8d4d60b774":
      return &namespace_f9e15975f25db152::function_f5f982ce9e32c830;
  }

  assertmsg("<dev string:x24>" + funcid);
}

function function_b4c8cc8d02ad0b95(interactionid) {
  self.battlechatterallowed = 0;
  self.var_21435b7177552b48 = 1;
}

function function_dabb6663ba0a5177(interactionid) {
  self.battlechatterallowed = 1;
  self.balwayscoverexposed = 1;
  self.var_21435b7177552b48 = 0;
  self.lastenemysightpos = undefined;
}

function function_389783bac1e5cfce(statename) {
  thread function_79d562486b0c13e3(statename, randomfloat(2));
}

function function_323d874e6bdc218b(statename) {
  self.balwayscoverexposed = 0;
}

function function_f2b49cf03a71061e(statename) {
  assert(isDefined(self.stealth));
  self.var_39f0918bb658b9f7 = 1;
}

function function_77665c010b74bf65(statename) {
  assert(isDefined(self.stealth));
  self.var_39f0918bb658b9f7 = 0;
}

function function_79d562486b0c13e3(statename, t) {
  self endon("death");
  self endon("lkp_user_removed");
  self endon(statename + "_bseq_finished");
  wait t;
  self.balwayscoverexposed = 1;
}

function playdialog(statename, params) {
  assert(params.size == 1);
  dialog = params[0];

  if(dialog == "he_was_just_here_dialog") {
    dialogue::say("dx_cbc_usm1_target_lost_generic");
    return;
  }

  if(dialog == "checkin_it_out_dialog") {
    dialogue::say("dx_cbc_usm1_checking_last_known_reply");
    return;
  }

  if(dialog == "he_is_gone_dialog") {
    dialogue::say("dx_cbc_usm1_enemy_gone_inform");
  }
}