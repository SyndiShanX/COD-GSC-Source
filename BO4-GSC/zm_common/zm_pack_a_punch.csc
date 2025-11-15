/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_pack_a_punch.csc
***********************************************/

#include scripts\core_common\activecamo_shared;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\array_shared;
#include scripts\core_common\audio_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_pack_a_punch;

autoexec __init__system__() {
  system::register(#"zm_pack_a_punch", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"hash_2ab769386115d75c"] = #"hash_669f8d1e3151a677";
  clientfield::register("zbarrier", "pap_working_fx", 1, 1, "int", &pap_working_fx_handler, 0, 0);
  clientfield::register("zbarrier", "pap_idle_fx", 1, 1, "int", &function_2a80c24d, 0, 0);
  clientfield::register("world", "pap_force_stream", 1, 1, "int", &pap_force_stream, 0, 0);
  callback::on_localplayer_spawned(&on_localplayer_spawned);
  callback::add_callback(#"hash_6900f4ea0ff32c3e", &function_5c574877);
}

function_5c574877(params) {
  if(isDefined(params.piece) && isDefined(params.piece.weapon)) {
    params.piece activecamo::function_cbfd8fd6(params.localclientnum);
  }
}

on_localplayer_spawned(localclientnum) {
  n_story = zm_utility::get_story();

  if(isDefined(level.var_59d3631c)) {
    forcestreamxmodel(level.var_59d3631c, 1, 0);
    return;
  }

  if(n_story == 1) {
    forcestreamxmodel(#"p7_zm_vending_packapunch_on", 1, 0);
    return;
  }

  if(n_story == 2) {
    forcestreamxmodel(#"hash_4efdd19dfd268f23", 1, 0);
  }
}

pap_force_stream(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  n_story = zm_utility::get_story();

  if(newval) {
    if(isDefined(level.var_59d3631c)) {
      forcestreamxmodel(level.var_59d3631c);
    } else if(n_story == 1) {
      forcestreamxmodel(#"p7_zm_vending_packapunch_on");
    } else if(n_story == 2) {
      forcestreamxmodel(#"hash_4efdd19dfd268f23");
    }

    return;
  }

  if(isDefined(level.var_59d3631c)) {
    stopforcestreamingxmodel(level.var_59d3631c);
    return;
  }

  if(n_story == 1) {
    stopforcestreamingxmodel(#"p7_zm_vending_packapunch_on");
    return;
  }

  if(n_story == 2) {
    stopforcestreamingxmodel(#"hash_4efdd19dfd268f23");
  }
}

function_2a80c24d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    function_f74ad2c1(localclientnum, 4, "fx_tag_mid_jnt");
    return;
  }

  if(isDefined(self.n_pap_idle_fx)) {
    stopfx(localclientnum, self.n_pap_idle_fx);
    self.n_pap_idle_fx = undefined;
  }

  wait 1;

  if(isDefined(self.var_4d7e8438)) {
    self.var_4d7e8438 delete();
  }
}

private function_f74ad2c1(localclientnum, n_piece_index, str_tag) {
  mdl_piece = self zbarriergetpiece(n_piece_index);

  if(isDefined(self.var_4d7e8438)) {
    self.var_4d7e8438 delete();
  }

  if(isDefined(self.n_pap_idle_fx)) {
    deletefx(localclientnum, self.n_pap_idle_fx);
    self.var_8513edc0 = undefined;
  }

  self.var_4d7e8438 = util::spawn_model(localclientnum, "tag_origin", mdl_piece gettagorigin(str_tag), mdl_piece gettagangles(str_tag));
  self.var_4d7e8438 linkto(mdl_piece, str_tag);
  self.n_pap_idle_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_2ab769386115d75c"], self.var_4d7e8438, "tag_origin");
}

pap_working_fx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    pap_play_fx(localclientnum, 0, "base_jnt");
    return;
  }

  if(isDefined(self.n_pap_fx)) {
    stopfx(localclientnum, self.n_pap_fx);
    self.n_pap_fx = undefined;
  }

  wait 1;

  if(isDefined(self.mdl_fx)) {
    self.mdl_fx delete();
  }
}

private pap_play_fx(localclientnum, n_piece_index, str_tag) {
  mdl_piece = self zbarriergetpiece(n_piece_index);

  if(isDefined(self.mdl_fx)) {
    self.mdl_fx delete();
  }

  if(isDefined(self.n_pap_fx)) {
    deletefx(localclientnum, self.n_pap_fx);
    self.n_pap_fx = undefined;
  }

  self.mdl_fx = util::spawn_model(localclientnum, "tag_origin", mdl_piece gettagorigin(str_tag), mdl_piece gettagangles(str_tag));
  self.mdl_fx linkto(mdl_piece, str_tag);
  self.n_pap_fx = util::playFXOnTag(localclientnum, level._effect[#"pap_working_fx"], self.mdl_fx, "tag_origin");
}