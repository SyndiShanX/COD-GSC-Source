/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_14b99732aeac3ca6.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace namespace_958b287a;

function init() {
  init_clientfields();
}

function init_clientfields() {
  clientfield::register("scriptmover", "" + # "hash_7171d4768b724a65", 24000, 1, "int", &function_64e04297, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_5fca7cdab0e93f71", 24000, 1, "int", &function_c2924276, 0, 0);
  clientfield::register("world", "" + # "hash_866e71344110f38", 24000, getminbitcountfornum(2), "int", &function_f3b46741, 0, 0);
  clientfield::register("actor", "" + # "hash_54e2a4e02a26cc62", 24000, 1, "counter", &function_95190421, 0, 0);
  clientfield::register("toplayer", "" + # "hash_721d42a28d7461ea", 24000, 1, "int", &function_eebdf718, 0, 0);
  clientfield::register("world", "" + # "hash_27f831b48c21166f", 24000, 1, "int", &function_ee0c0073, 0, 0);
  clientfield::register("world", "" + # "hash_28f70ef210665b53", 24000, 1, "int", &function_411aa7f8, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_e4552abd8fb5506", 24000, 1, "int", &function_1fff7e03, 0, 0);
}

function function_64e04297(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_1f3cb09a = util::playFXOnTag(fieldname, #"hash_6c8d478322adcc6a", self, "j_mainroot");
    playSound(fieldname, #"hash_765e6e49f551f97c", self.origin);
    self.var_eb074a88 = self playLoopSound("zmb_bunnyquest_stp2_bunny_lp");
    return;
  }

  if(isDefined(self.var_1f3cb09a)) {
    stopfx(fieldname, self.var_1f3cb09a);
    self stoploopsound(self.var_eb074a88, 0.5);
    self.var_1f3cb09a = undefined;
    self.var_eb074a88 = undefined;
  }

  self.explode_fx = util::playFXOnTag(fieldname, #"hash_5cde32c15506b440", self, "j_mainroot");
  playSound(fieldname, #"hash_7534e74a4fd1c56d", self.origin);
}

function function_f3b46741(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    function_5ea2c6e3("zmb_sr_dropallaudioby4", 1, 1);
    return;
  }

  if(bwastimejump == 2) {
    soundloopemitter(#"hash_5c8e172b662df768", (3239, 10251, -770));
    return;
  }

  function_ed62c9c2("zmb_sr_dropallaudioby4", 1);
  soundstoploopemitter(#"hash_5c8e172b662df768", (3239, 10251, -770));
}

function function_c2924276(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    v_pos = self.origin;
    playFX(fieldname, #"hash_5cde32c15506b440", v_pos);
    playSound(fieldname, #"hash_2f340670f6ec30cb", v_pos + (0, 0, 25));
  }
}

function function_95190421(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFX(bwastimejump, #"zombie/fx9_onslaught_spawn_sm", self.origin);
  playSound(bwastimejump, #"hash_58611db3b1d6494e", self.origin + (0, 0, 35));
}

function function_eebdf718(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self setenemyglobalscrambler(1);
    return;
  }

  self setenemyglobalscrambler(0);
}

function function_ee0c0073(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_fcec724a = struct::get("bny_clb_strobe_fx");

  if(bwastimejump) {
    if(!isDefined(var_fcec724a.var_f01d5034)) {
      var_fcec724a.var_f01d5034 = playFX(fieldname, #"hash_ae69a5490ab1a42", var_fcec724a.origin, anglesToForward(var_fcec724a.angles), anglestoup(var_fcec724a.angles));
    }

    return;
  }

  if(isDefined(var_fcec724a.var_f01d5034)) {
    stopfx(fieldname, var_fcec724a.var_f01d5034);
    var_fcec724a.var_f01d5034 = undefined;
  }
}

function function_411aa7f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_s_blockers = struct::get_array("bny_blocker");

  if(bwastimejump) {
    foreach(s_blocker in a_s_blockers) {
      if(!isDefined(s_blocker.mdl_fx)) {
        s_blocker.mdl_fx = playFX(fieldname, #"hash_1209e5f15b93f9af", s_blocker.origin, anglesToForward(s_blocker.angles), anglestoup(s_blocker.angles));
      }
    }

    return;
  }

  foreach(s_blocker in a_s_blockers) {
    if(isDefined(s_blocker.mdl_fx)) {
      stopfx(fieldname, s_blocker.mdl_fx);
      s_blocker.mdl_fx = undefined;
    }
  }
}

function function_1fff7e03(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.light_fx = util::playFXOnTag(fieldname, #"hash_d46ff1e1b37c2fb", self, "tag_origin");
  }
}