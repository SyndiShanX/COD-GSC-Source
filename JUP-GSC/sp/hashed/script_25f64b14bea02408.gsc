/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_25f64b14bea02408.gsc
*************************************************/

#using script_26f456dbdf9aa216;
#using scripts\anim\dialogue;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace clear_lkp;

function getfunction(funcid) {
  switch (funcid) {
    case #"hash_f4ef887f81fa60d9":
      return &function_ea2a4a330d127793;
    case #"hash_47b3d8e9cd6ccd4a":
      return &function_336db229eb81d51e;
    case #"hash_871307852fe531bf":
      return &function_280aee8c8ab42ef7;
    case #"hash_4bc3c13aae411fc":
      return &function_1f0637e40c2a0dda;
    case #"hash_bf509799ad09e3fb":
      return &onadduser;
    case #"hash_cfc7861edb6bdc95":
      return &ondeleteuser;
    case #"hash_bb5cf3d8738e8519":
      return &playdialog;
    case #"hash_80804c8d4d60b774":
      return &namespace_a3bb9840357a7ef2::function_5ad32ab5f21ddf93;
  }

  assertmsg("Missing function pointer for " + funcid);
}

function onadduser(interactionid) {
  self.battlechatterallowed = 0;
  self.var_a4709d00b598b7bf = 1;
}

function ondeleteuser(interactionid) {
  self.battlechatterallowed = 1;
  self.balwayscoverexposed = 1;
  self.var_a4709d00b598b7bf = 0;
  self.lastenemysightpos = undefined;
}

function function_ea2a4a330d127793(statename) {
  thread function_414b3c5423728952(statename, randomfloat(2));
}

function function_336db229eb81d51e(statename) {
  self.balwayscoverexposed = 0;
}

function function_280aee8c8ab42ef7(statename) {
  assert(isDefined(self.stealth));
  self.var_11f37c3fc868dadc = 1;
}

function function_1f0637e40c2a0dda(statename) {
  assert(isDefined(self.stealth));
  self.var_11f37c3fc868dadc = 0;
}

function function_414b3c5423728952(statename, t) {
  self endon("death");
  self endon("lkp_user_removed");
  self endon(statename + "_bseq_finished");
  wait t;
  self.balwayscoverexposed = 1;
}

function playdialog(statename, params) {
  assert(params.size == 1);
  dialog = params[0];

  if(dialog == "hold_fire_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_hold_fire_order");
    return;
  }

  if(dialog == "where_is_he_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_target_location_ask");
    return;
  }

  if(dialog == "he_was_just_here_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_target_lost_generic");
    return;
  }

  if(dialog == "3_1_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_3_1_generic");
    return;
  }

  if(dialog == "move_in_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_check_last_known_order");
    return;
  }

  if(dialog == "everyone_else_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_everyone_else_generic");
    return;
  }

  if(dialog == "hold_position_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_hold_position_order");
    return;
  }

  if(dialog == "checkin_it_out_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_checking_last_known_reply");
    return;
  }

  if(dialog == "area_is_clear_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_area_clear_inform");
    return;
  }

  if(dialog == "he_is_gone_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_enemy_gone_inform");
    return;
  }

  if(dialog == "he_is_close_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_target_near_inform");
    return;
  }

  if(dialog == "split_up_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_start_search_order");
    return;
  }

  if(dialog == "cover_me_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_order_ally_coverme");
    return;
  }

  if(dialog == "covering_fire_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_inform_self_covering_ally");
    return;
  }

  if(dialog == "harris_is_moving_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_inform_self_covering_ally_harris");
    return;
  }

  if(dialog == "i_will_cover_you_dialog") {
    scripts\anim\dialogue::say("dx_cbc_usm1_inform_self_covering_you");
  }
}