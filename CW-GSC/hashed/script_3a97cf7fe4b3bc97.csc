/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3a97cf7fe4b3bc97.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_780aaec4;

function private autoexec __init__system__() {
  system::register(#"sr_demented_echo", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_24d18e3942c82edb")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  clientfield::register("scriptmover", "sr_demented_echo_fx", 1, 2, "int", &sr_demented_echo_fx, 0, 0);
}

function sr_demented_echo_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.var_4b6f13c8)) {
    stopfx(fieldname, self.var_4b6f13c8);
  }

  if(bwastimejump == 1) {
    if(self.model === # "hash_2641cfb5c2cdcc85") {
      var_1e7f4865 = getscriptbundle("fxd9_zm_char_ndu_ghoul_dark");
      var_ee6bcd51 = # "hash_611d3f9c34b1cbd1";
    } else {
      var_1e7f4865 = getscriptbundle("fxd9_zm_char_ndu_ghoul");
    }

    if(isDefined(var_ee6bcd51)) {
      self playrenderoverridebundle(var_ee6bcd51);
    }

    if(isDefined(var_1e7f4865.effectcount) &!is_true(self.var_255d9872)) {
      for(index = 1; index <= var_1e7f4865.effectcount; index++) {
        str_fx = var_1e7f4865.("effect" + index + "_fx");
        str_tag = var_1e7f4865.("effect" + index + "_attachtag");

        if(isDefined(str_fx) && isDefined(str_tag)) {
          function_239993de(fieldname, str_fx, self, str_tag);
        }
      }

      self.var_255d9872 = 1;
    }

    return;
  }

  if(bwastimejump == 2) {
    if(self.model === # "hash_2641cfb5c2cdcc85") {
      function_239993de(fieldname, #"hash_2d19b2d474adee02", self, "tag_origin");
      self stoprenderoverridebundle(#"hash_611d3f9c34b1cbd1");
    } else {
      self.var_4b6f13c8 = function_239993de(fieldname, #"hash_7a8b6775d3a2329d", self, "j_spine4");
    }

    return;
  }

  if(bwastimejump == 3) {
    self.var_4b6f13c8 = function_239993de(fieldname, #"hash_2b2859b61c0b8a31", self, "j_spine4");
    return;
  }

  if(self.model === # "hash_2641cfb5c2cdcc85") {
    function_239993de(fieldname, #"hash_3a4d83f77eba6968", self, "tag_origin");
    self stoprenderoverridebundle(#"hash_611d3f9c34b1cbd1");
    return;
  }

  v_tag = self gettagorigin("j_spine4");

  if(!isDefined(v_tag)) {
    v_tag = self.origin + (0, 0, 48);
  }

  playFX(fieldname, #"hash_5bbf453f2140d55f", v_tag);
}