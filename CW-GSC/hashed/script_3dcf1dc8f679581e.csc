/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3dcf1dc8f679581e.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace zm_platinum_pap_quest;

function init() {
  clientfield::register("scriptmover", "" + # "pap_machine_fx", 1, getminbitcountfornum(3), "int", &pap_machine_fx, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_44cce9f2e2fd1c96", 1, getminbitcountfornum(2), "int", &function_cc365474, 0, 0);
  clientfield::register("world", "" + # "pap_portal_fx", 1, 1, "int", &pap_portal_fx, 0, 0);
  clientfield::register("world", "" + # "pap_quest_beam_start", 1, getminbitcountfornum(10), "int", &pap_quest_beam_start, 0, 0);
  clientfield::register("world", "" + # "hash_3fb8ca8c017ba7ac", 1, getminbitcountfornum(10), "int", &function_c6f8ff7b, 0, 0);
}

function pap_machine_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    self.var_aa4114ee = function_239993de(fieldname, #"hash_328cb5a90073aa39", self, "tag_origin");
    self.var_4b0f392d = self playLoopSound(#"hash_144c0f8c91a1dbbe");
    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.var_4b0f392d)) {
      self stoploopsound(self.var_4b0f392d);
      self.var_4b0f392d = undefined;
    }

    self playSound(fieldname, #"hash_3a989a32ea5a4c2f");
    self.var_3dec4e8f = self playLoopSound(#"hash_54edcd34dafdb14c");
    playFX(fieldname, #"hash_3cce6d727537b2d6", self gettagorigin("tag_origin") + (0, 0, 28), anglesToForward(self.angles), anglestoup(self.angles));
    wait 1;
    self.var_f7aa5696 = playFX(fieldname, #"hash_29bb1f45e23e48ac", self gettagorigin("tag_origin") + (0, 0, 28), anglesToForward(self.angles), anglestoup(self.angles));
    return;
  }

  if(bwastimejump == 3) {
    if(isDefined(self.var_aa4114ee)) {
      stopfx(fieldname, self.var_aa4114ee);
    }

    if(isDefined(self.var_f7aa5696)) {
      stopfx(fieldname, self.var_f7aa5696);
    }

    if(isDefined(self.var_4b0f392d)) {
      self stoploopsound(self.var_4b0f392d);
      self.var_4b0f392d = undefined;
    }

    if(isDefined(self.var_3dec4e8f)) {
      self stoploopsound(self.var_3dec4e8f);
      self.var_3dec4e8f = undefined;
    }

    function_239993de(fieldname, #"hash_41319f596f0bea07", self, "tag_origin");
    self playSound(fieldname, #"hash_10f5dcd17a0099d6");
  }
}

function function_cc365474(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    if(!isDefined(self.var_4e35f286)) {
      self.var_4e35f286 = util::playFXOnTag(fieldname, #"hash_c863459090fe55f", self, "j_spine4");
    }

    if(!isDefined(self.var_a863bc25)) {
      self.var_a863bc25 = self playLoopSound(#"hash_612580e60d0a183f");
    }

    return;
  }

  if(isDefined(self.var_4e35f286)) {
    deletefx(fieldname, self.var_4e35f286);
    self.var_4e35f286 = undefined;
  }

  if(isDefined(self.var_a863bc25)) {
    self stoploopsound(self.var_a863bc25);
  }

  if(isDefined(self.var_d1c055ab)) {
    self playSound(fieldname, #"hash_10989803ee973a6e");
    self stoploopsound(self.var_d1c055ab);
  }

  if(bwastimejump == 2) {
    self.var_4e35f286 = util::playFXOnTag(fieldname, #"hash_1ece705913b0c51f", self, "j_spine4");

    if(!isDefined(self.var_d1c055ab)) {
      self playSound(fieldname, #"hash_77657e597a6c430c");
      self.var_d1c055ab = self playLoopSound(#"hash_15002353c0e436f5");
    }
  }
}

function pap_portal_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  s_portal = struct::get("s_pap_portal_fx");

  if(bwastimejump) {
    if(!isDefined(s_portal.var_8eb4e749)) {
      s_portal.var_8eb4e749 = playFX(fieldname, #"hash_7e0e122e235d355e", s_portal.origin, anglesToForward(s_portal.angles), anglestoup(s_portal.angles));
    }

    playSound(fieldname, #"hash_3a58ade572eb339e", s_portal.origin);
    soundloopemitter(#"hash_1b27cd2897a39322", s_portal.origin);
    return;
  }

  if(isDefined(s_portal.var_8eb4e749)) {
    stopfx(fieldname, s_portal.var_8eb4e749);
    s_portal.var_8eb4e749 = undefined;
  }

  playSound(fieldname, #"hash_147060f9d5a3cb8b", s_portal.origin);
  soundstoploopemitter(#"hash_1b27cd2897a39322", s_portal.origin);
}

function pap_quest_beam_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_s_start = struct::get_array("pap_quest_beam_start");
  a_s_start = array::sort_by_script_int(a_s_start, 1);
  var_c2f24bc = struct::get_array("pap_quest_beam_end");
  var_c2f24bc = array::sort_by_script_int(var_c2f24bc, 1);
  n_index = bwastimejump - 1;
  s_start = a_s_start[n_index];
  s_end = var_c2f24bc[n_index];

  if(isDefined(s_start) && isDefined(s_end) && !(isDefined(s_start.mdl_start) && isDefined(s_end.var_b5d35012))) {
    v_start_origin = s_start.origin;
    var_e64db026 = s_end.origin;
    v_start_angles = vectortoangles(v_start_origin - var_e64db026);
    v_end_angles = vectortoangles(var_e64db026 - v_start_origin);
    s_start.mdl_start = util::spawn_model(fieldname, #"tag_origin", v_start_origin, v_start_angles);
    s_end.var_b5d35012 = util::spawn_model(fieldname, #"tag_origin", var_e64db026, v_end_angles);
    level beam::launch(s_start.mdl_start, "tag_origin", s_end.var_b5d35012, "tag_origin", "beam9_zm_platinum_pap_beam", 1);
  }
}

function function_c6f8ff7b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  a_s_start = struct::get_array("pap_quest_beam_start");
  a_s_start = array::sort_by_script_int(a_s_start, 1);
  var_c2f24bc = struct::get_array("pap_quest_beam_end");
  var_c2f24bc = array::sort_by_script_int(var_c2f24bc, 1);
  n_index = bwastimejump - 1;
  s_start = a_s_start[n_index];
  s_end = var_c2f24bc[n_index];

  if(isDefined(s_start.mdl_start) && isDefined(s_end) && isDefined(s_start) && isDefined(s_end.var_b5d35012)) {
    level beam::kill(s_start.mdl_start, "tag_origin", s_end.var_b5d35012, "tag_origin", "beam9_zm_platinum_pap_beam");
    s_start.mdl_start delete();
    s_end.var_b5d35012 delete();
  }
}