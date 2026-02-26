/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1793e0dffb81a6c8.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_pack_a_punch;
#using scripts\zm_common\zm_trial;
#using scripts\zm_common\zm_trial_util;
#using scripts\zm_common\zm_utility;
#namespace namespace_841de7df;

function private autoexec __init__system__() {
  system::register(#"hash_4ef9c479ac8da304", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  clientfield::register("zbarrier", "" + # "hash_100f180bf5d2a517", 14000, 1, "int", &function_b245db69, 0, 0);
  level._effect[#"hash_1d15a2dad558ac8c"] = "zombie/fx8_packapunch_zmb_red_gauntlet";
  level._effect[#"hash_1d15a5dad558b1a5"] = "zombie/fx8_packapunch_zmb_red_gauntlet";
  zm_trial::register_challenge(#"hash_28d1b9857e2ca681", &on_begin, &on_end);
}

function private on_begin(localclientnum, a_params) {}

function private on_end(localclientnum) {}

function is_active() {
  challenge = zm_trial::function_a36e8c38(#"hash_28d1b9857e2ca681");
  return isDefined(challenge);
}

function private function_b245db69(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(isDefined(self.var_18f8b30b)) {
      self.var_18f8b30b delete();
    }

    if(isDefined(self.var_3b071bba)) {
      deletefx(fieldname, self.var_3b071bba);
      self.var_3b071bba = undefined;
    }

    if(zm_utility::get_story() == 1) {
      self.var_18f8b30b = util::spawn_model(fieldname, "tag_origin", self.origin, self.angles);
      self.var_3b071bba = util::playFXOnTag(fieldname, level._effect[#"hash_1d15a2dad558ac8c"], self.var_18f8b30b, "tag_origin");
    } else {
      self.var_18f8b30b = util::spawn_model(fieldname, "tag_origin", self.origin, self.angles);
      self.var_3b071bba = util::playFXOnTag(fieldname, level._effect[#"hash_1d15a5dad558b1a5"], self.var_18f8b30b, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_3b071bba)) {
    deletefx(fieldname, self.var_3b071bba);
    self.var_3b071bba = undefined;
  }

  if(isDefined(self.var_18f8b30b)) {
    self.var_18f8b30b delete();
  }
}