/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1e30f5109f6bf48c.csc
***********************************************/

#using script_4e53735256f112ac;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_2ab93693;

function private autoexec __init__system__() {
  system::register(#"hash_662c938bd03bd1ad", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "hash_142ed640bf2e09b9", 1, 1, "int", &function_9ab6532, 0, 0);
  clientfield::register("actor", "" + # "hash_717ed5a81b281ebd", 1, 1, "counter", &function_49585088, 0, 0);
  clientfield::register("toplayer", "" + # "hash_717ed5a81b281ebd", 1, 1, "int", &function_1408657d, 0, 0);
  clientfield::register("actor", "" + # "hash_177f6b02e0b5436b", 1, 1, "int", &function_c284174e, 0, 0);
  clientfield::register("actor", "" + # "hash_40a7e84c380b9b1a", 1, 1, "int", &function_4d8be86, 0, 0);
}

function function_9ab6532(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!isDefined(self.var_2d4a2068)) {
      self.var_2d4a2068 = util::playFXOnTag(fieldname, #"hash_612c96cf772b0fff", self, "tag_origin");
    }

    return;
  }

  if(isDefined(self.var_2d4a2068)) {
    stopfx(fieldname, self.var_2d4a2068);
    self.var_2d4a2068 = undefined;
  }
}

function function_49585088(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(bwastimejump, #"hash_1c001d6fb3eddb07", self, "tag_origin");
}

function function_1408657d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(getdvarint(#"hash_3d552cee64c1f47f", 0)) {
    var_f7698b89 = # "hash_44c8508c1fd1ef7d";
  } else {
    var_f7698b89 = # "hash_44a0488c1fb08fd1";
  }

  if(bwastimejump) {
    if(self postfx::function_556665f2(var_f7698b89)) {
      self postfx::stoppostfxbundle(var_f7698b89);
    }

    self postfx::playpostfxbundle(var_f7698b89);
    return;
  }

  if(self postfx::function_556665f2(var_f7698b89)) {
    self postfx::exitpostfxbundle(var_f7698b89);
  }
}

function function_c284174e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    str_tag = "j_spinelower";

    if(!isDefined(self gettagorigin(str_tag))) {
      str_tag = "tag_origin";
    }

    self.var_72ef3ede = util::playFXOnTag(fieldname, #"hash_396881a795d7d4c8", self, str_tag);
    self thread function_3d9b3a(fieldname);
    return;
  }

  self notify(#"hash_75cc1f791bba6c66");

  if(isDefined(self.var_72ef3ede)) {
    stopfx(fieldname, self.var_72ef3ede);
    self.var_72ef3ede = undefined;
  }

  if(isarray(self.var_19741e6c)) {
    foreach(n_fx_id in self.var_19741e6c) {
      stopfx(fieldname, n_fx_id);
    }

    self.var_19741e6c = undefined;
  }
}

function private function_3d9b3a(localclientnum) {
  self endon(#"death", #"hash_75cc1f791bba6c66");
  wait 1;
  a_str_tags = [];
  a_str_tags[0] = "j_elbow_le";
  a_str_tags[1] = "j_elbow_ri";
  a_str_tags[2] = "j_knee_ri";
  a_str_tags[3] = "j_knee_le";
  a_str_tags = array::randomize(a_str_tags);
  self.var_19741e6c[0] = util::playFXOnTag(localclientnum, #"hash_b0b53c54df06f0d", self, a_str_tags[0]);
  wait 1;
  a_str_tags[0] = "j_wrist_ri";
  a_str_tags[1] = "j_wrist_le";

  if(!is_true(self.missinglegs)) {
    a_str_tags[2] = "j_ankle_ri";
    a_str_tags[3] = "j_ankle_le";
  }

  a_str_tags = array::randomize(a_str_tags);
  self.var_19741e6c[1] = util::playFXOnTag(localclientnum, #"hash_b0b53c54df06f0d", self, a_str_tags[0]);
  self.var_19741e6c[2] = util::playFXOnTag(localclientnum, #"hash_b0b53c54df06f0d", self, a_str_tags[1]);
}

function function_4d8be86(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    if(isDefined(self.var_53e69fc6)) {
      stopfx(fieldname, self.var_53e69fc6);
    }

    str_tag = "j_spineupper";

    if(!isDefined(self gettagorigin(str_tag))) {
      str_tag = "tag_origin";
    }

    self.var_53e69fc6 = util::playFXOnTag(fieldname, #"hash_396881a795d7d4c8", self, str_tag);
    return;
  }

  if(isDefined(self.var_53e69fc6)) {
    stopfx(fieldname, self.var_53e69fc6);
    self.var_53e69fc6 = undefined;
  }
}