/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_64ba9fcabd6381a1.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_e0966e1e;

function private autoexec __init__system__() {
  system::register(#"hash_6f7d2657f403b90d", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "hash_452045cf5cb8bc4c", 16000, 2, "int", &function_830c306e, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_7833487f87cacad1", 16000, 1, "int", &function_aa0ed712, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_1e3fecb02ce56163", 16000, 1, "int", &function_6a360cde, 0, 0);
}

function function_6a360cde(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.var_f70ef53c = util::playFXOnTag(fieldname, #"hash_76e6cbdd75a0ae46", self, "tag_animate");

    if(isDefined(self.var_83f12b7c)) {
      self stoploopsound(self.var_83f12b7c);
      self.var_83f12b7c = undefined;
    }

    self playSound(fieldname, #"hash_671944ab50b7a130");
    self.var_a9c2bfe4 = 1;
    return;
  }

  if(isDefined(self.var_f70ef53c)) {
    stopfx(fieldname, self.var_f70ef53c);
  }

  self.var_a9c2bfe4 = 0;
}

function function_830c306e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 0:
      if(isDefined(self.var_3504fb78)) {
        stopfx(fieldname, self.var_3504fb78);
      }

      if(isDefined(self.var_edd303cf)) {
        stopfx(fieldname, self.var_edd303cf);
      }

      if(isDefined(self.var_87fd74a7)) {
        stopfx(fieldname, self.var_87fd74a7);
      }

      if(isDefined(self.var_71937d24)) {
        self playSound(fieldname, #"hash_6010defaf1c41ae4");
        self stoploopsound(self.var_71937d24);
        self.var_71937d24 = undefined;
      }

      if(isDefined(self.var_b8bfe17e)) {
        self stoploopsound(self.var_b8bfe17e);
        self.var_b8bfe17e = undefined;
      }

      self notify(#"hash_52be29763bc2391e");
      break;
    case 1:
      if(isDefined(self.var_83f12b7c)) {
        self stoploopsound(self.var_83f12b7c);
        self.var_83f12b7c = undefined;
      }

      self.var_3504fb78 = util::playFXOnTag(fieldname, #"hash_2acd20deb7d56350", self, "tag_animate");
      self playSound(fieldname, #"hash_56e074f1a171421d");
      self.var_71937d24 = self playLoopSound(#"hash_760ed99900106de3");
      zombie = self getlinkedent();

      if(isDefined(zombie)) {
        forward = self.origin - zombie.origin;
        self.var_edd303cf = playFX(fieldname, #"hash_240c7f76d259b9a3", self.origin, forward);
        self thread function_d9150e58(fieldname);
        self thread function_d99e101d(fieldname, zombie);
      }

      break;
    case 2:
      if(isDefined(self.var_3504fb78)) {
        stopfx(fieldname, self.var_3504fb78);
      }

      if(isDefined(self.var_edd303cf)) {
        stopfx(fieldname, self.var_edd303cf);
      }

      if(isDefined(self.var_83f12b7c)) {
        self stoploopsound(self.var_83f12b7c);
        self.var_83f12b7c = undefined;
      }

      if(isDefined(self.var_71937d24)) {
        self playSound(fieldname, #"hash_6010defaf1c41ae4");
        self stoploopsound(self.var_71937d24);
        self.var_71937d24 = undefined;
      }

      self.var_87fd74a7 = util::playFXOnTag(fieldname, #"hash_3354e735e33805a7", self, "tag_animate");
      self playSound(fieldname, #"hash_534278acb9340669");
      self notify(#"hash_52be29763bc2391e");
      break;
    case 3:
      if(isDefined(self.var_3504fb78)) {
        stopfx(fieldname, self.var_3504fb78);
      }

      if(isDefined(self.var_edd303cf)) {
        stopfx(fieldname, self.var_edd303cf);
      }

      if(isDefined(self.var_87fd74a7)) {
        stopfx(fieldname, self.var_87fd74a7);
      }

      if(isDefined(self.var_71937d24)) {
        self playSound(fieldname, #"hash_6010defaf1c41ae4");
        self stoploopsound(self.var_71937d24);
        self.var_71937d24 = undefined;
      }

      if(isDefined(self.var_b8bfe17e)) {
        self stoploopsound(self.var_b8bfe17e);
        self.var_b8bfe17e = undefined;
      }

      self notify(#"hash_52be29763bc2391e");
      util::playFXOnTag(fieldname, #"hash_7e225ece0c91121", self, "tag_animate");
      break;
    default:
      break;
  }
}

function function_d9150e58(localclientnum) {
  level endon(#"end_game");
  self waittilltimeout(6, #"death");

  if(isDefined(self.var_edd303cf)) {
    stopfx(localclientnum, self.var_edd303cf);
  }
}

function function_d99e101d(localclientnum, var_86cccd7b) {
  level endon(#"end_game");
  self endon(#"death", #"hash_52be29763bc2391e");
  var_86cccd7b endon(#"death");
  var_c848a436 = array("j_elbow_le", "j_elbow_ri", "j_shoulder_le", "j_shoulder_ri", "j_spine4", "j_head");

  if(var_86cccd7b.archetype == # "zombie_dog") {
    var_c848a436 = array("j_spine2", "j_spine3", "j_spine4", "j_neck", "j_head");
  }

  while(true) {
    tag = array::random(var_c848a436);
    start_pos = var_86cccd7b gettagorigin(tag);

    if(!isDefined(start_pos)) {
      continue;
    }

    var_9ce372f7 = util::spawn_model(localclientnum, "tag_origin", start_pos);
    var_9ce372f7.var_29dd623b = util::playFXOnTag(localclientnum, #"hash_523a16f9296294f0", var_9ce372f7, "tag_origin");
    var_9ce372f7 thread function_6333cd88(self);
    var_9ce372f7 thread function_ca3614(self);
    wait 0.1;
  }
}

function function_6333cd88(var_bea4648f) {
  level endon(#"end_game");
  self endon(#"death");
  self moveto(var_bea4648f.origin, 0.1);
  wait 0.1;

  if(isDefined(self)) {
    self delete();
  }
}

function function_ca3614(parent) {
  level endon(#"end_game");
  self endon(#"death");
  parent waittill(#"death");

  if(isDefined(self)) {
    self delete();
  }
}

function function_aa0ed712(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.light_fx)) {
    killfx(fieldname, self.light_fx);
  }

  if(isDefined(self.var_83f12b7c)) {
    self stoploopsound(self.var_83f12b7c);
    self.var_83f12b7c = undefined;
  }

  if(bwastimejump == 1) {
    self.light_fx = util::playFXOnTag(fieldname, #"hash_194a9dcd4ca41ca9", self, "tag_animate");

    if(!is_true(self.var_a9c2bfe4)) {
      self.var_83f12b7c = self playLoopSound(#"hash_c977a3c790ccd55");
    }

    return;
  }

  self.light_fx = util::playFXOnTag(fieldname, #"hash_210ef7d0a601f6d9", self, "tag_animate");

  if(!is_true(self.var_a9c2bfe4)) {
    self.var_83f12b7c = self playLoopSound(#"hash_3af833d1182396f3");
  }
}