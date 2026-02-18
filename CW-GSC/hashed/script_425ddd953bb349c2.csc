/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_425ddd953bb349c2.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_7ec6ae9f;

function private autoexec __init__system__() {
  system::register(#"hash_2ff0859bce056c66", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_4bf87ef3ad101bb4")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  clientfield::register("allplayers", "phase_rift_player_fx", 1, 2, "int", &phase_rift_player_fx, 0, 0);
  clientfield::register("toplayer", "" + # "hash_1b01e37683714902", 1, 1, "int", &function_1f107cad, 0, 0);
}

function phase_rift_player_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self) || !self hasdobj(fieldname)) {
    return;
  }

  if(bwastimejump == 1) {
    v_loc = self gettagorigin("j_spine4");
    v_ang = self gettagangles("j_spine4");

    if(isDefined(v_ang)) {
      v_forward = anglesToForward(v_ang);
    }

    if(isDefined(v_loc) && isDefined(v_forward)) {
      self.var_c9e8cfb3 = playFX(fieldname, #"hash_2563ac540861f176", v_loc, v_forward);
    }

    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.var_c9e8cfb3)) {
      stopfx(fieldname, self.var_c9e8cfb3);
    }

    self.var_c9e8cfb3 = util::playFXOnTag(fieldname, #"hash_486b7f0cb02282b4", self, "j_spine4");
    return;
  }

  if(isDefined(self.var_c9e8cfb3)) {
    stopfx(fieldname, self.var_c9e8cfb3);
  }
}

function private function_1f107cad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(!isDefined(self.var_b1f90780)) {
      self playSound(fieldname, #"hash_704c327b669dff9e");
      self.var_b1f90780 = self playLoopSound(#"hash_4cc35edd344bf722");
    }

    return;
  }

  if(isDefined(self.var_b1f90780)) {
    self stoploopsound(self.var_b1f90780);
    self.var_b1f90780 = undefined;
    self playSound(fieldname, #"hash_55d8e246e77e9026");
  }
}