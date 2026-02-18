/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1c5cce12dd83e08.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_vo;
#namespace namespace_662ff671;

function event_handler[level_init] main(eventstruct) {
  clientfield::register("actor", "" + # "hash_74382f598f4de051", 1, 1, "counter", &function_9f72eb8b, 0, 0);
  clientfield::register("actor", "" + # "hash_b74182bd1e44a44", 1, 1, "int", &function_cdc867b2, 0, 0);
  clientfield::register("actor", "" + # "hash_435db79c304e12a5", 1, 1, "counter", &function_f15a1018, 0, 0);
  clientfield::register("actor", "" + # "hash_3049a409503be8a0", 1, 1, "int", &function_f471577a, 0, 0);
  clientfield::register("actor", "" + # "hash_4460e5ee368004ed", 1, 1, "int", &function_dea39d5a, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_60e4230d63925ac1", 1, 1, "int", &function_60886116, 0, 0);
  clientfield::register("scriptmover", "" + # "hash_6d05bbcab1912e5a", 1, 1, "int", &function_691412b4, 0, 0);
  clientfield::register("world", "" + # "console_stream", 1, 1, "int", &function_a2e43552, 0, 0);
}

function function_a2e43552(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    forcestreamxmodel(#"p9_sur_computer_console_hvt_01_screen_laser_in_act");
    forcestreamxmodel(#"p9_sur_computer_console_hvt_01_screen_laser_act");
    return;
  }

  stopforcestreamingxmodel(#"p9_sur_computer_console_hvt_01_screen_laser_in_act");
  stopforcestreamingxmodel(#"p9_sur_computer_console_hvt_01_screen_laser_act");
}

function function_dea39d5a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    self.var_3af8abd3 = util::playFXOnTag(fieldname, "sr/fx9_hvt_zombie_summon", self, "j_spine4");
    return;
  }

  if(isDefined(self.var_3af8abd3)) {
    stopfx(fieldname, self.var_3af8abd3);
    self.var_3af8abd3 = undefined;
  }
}

function function_f471577a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    self.var_27b51434 = util::playFXOnTag(fieldname, "sr/fx9_hvt_aether_beam_distant", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_27b51434)) {
    stopfx(fieldname, self.var_27b51434);
    self.var_27b51434 = undefined;
  }
}

function function_691412b4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    self.var_942f8233 = util::playFXOnTag(fieldname, "sr/fx9_hvt_aether_move_trail", self, "tag_origin");
    return;
  }

  if(isDefined(self.var_942f8233)) {
    stopfx(fieldname, self.var_942f8233);
  }
}

function function_60886116(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump == 1) {
    self.var_3e3964d7 = playFX(fieldname, "sr/fx9_hvt_aether_beam", self.origin, anglestoup(self.angles));

    if(!isDefined(self.var_7f6cb624)) {
      self playSound(fieldname, #"hash_62101ae824e3101a");
      self.var_7f6cb624 = self playLoopSound(#"hash_234e4f385aba4fae");
    }

    wait 2.5;
    self.var_ae8b25ed = playFX(fieldname, "sr/fx9_hvt_aether_portal_spawn", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    return;
  }

  self.var_1c6eb712 = playFX(fieldname, "sr/fx9_hvt_aether_portal_close", self.origin, anglesToForward(self.angles), anglestoup(self.angles));

  if(isDefined(self.var_3e3964d7)) {
    stopfx(fieldname, self.var_3e3964d7);
    self.var_3e3964d7 = undefined;
  }

  if(isDefined(self.var_ae8b25ed)) {
    stopfx(fieldname, self.var_ae8b25ed);
    self.var_ae8b25ed = undefined;
  }

  if(isDefined(self.var_7f6cb624)) {
    self playSound(fieldname, #"hash_7e2855c20a4abd8f");
    self stoploopsound(self.var_7f6cb624);
    self.var_7f6cb624 = undefined;
  }

  wait 2;

  if(isDefined(self.var_1c6eb712)) {
    stopfx(fieldname, self.var_1c6eb712);
    self.var_1c6eb712 = undefined;
  }
}

function function_f15a1018(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(bwastimejump);
  playFX(bwastimejump, "sr/fx9_hvt_aether_portal_exp", self.origin + (0, 0, 32), anglesToForward(self.angles), anglestoup(self.angles));
  self playSound(bwastimejump, #"hash_591b69e6e55b5eb1");
}

function function_9f72eb8b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(bwastimejump);
  earthquake(bwastimejump, 0.3, 2, self.origin, 2500);
  function_36e4ebd4(bwastimejump, #"hash_28f3f7b037cdb4bc");

  if(isDefined(self) && isDefined(bwastimejump)) {
    self playSound(bwastimejump, #"hash_6916591c817c7bf8");
    a_players = getplayers(bwastimejump, undefined, self.origin, 2500);
    array::thread_all(a_players, &postfx::playpostfxbundle, #"pstfx_underwater");
    level thread function_36083e9a(bwastimejump, a_players);
  }
}

function function_36083e9a(localclientnum, a_players) {
  wait 1;
  arrayremovevalue(a_players, undefined);
  array::thread_all(a_players, &postfx::exitpostfxbundle, #"pstfx_underwater");
}

function function_cdc867b2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(bwastimejump) {
    if(!isDefined(self.var_bb6d69f0)) {
      self.var_bb6d69f0 = playFX(fieldname, "sr/fx9_hvt_aether_portal_spawn", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    }

    return;
  }

  if(isDefined(self.var_bb6d69f0)) {
    stopfx(fieldname, self.var_bb6d69f0);
    self.var_bb6d69f0 = undefined;
  }

  var_4776f2b8 = playFX(fieldname, "sr/fx9_hvt_aether_portal_close", self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  level thread function_2f3f5638(fieldname, var_4776f2b8);
}

function function_2f3f5638(localclientnum, var_4776f2b8) {
  wait 2;

  if(isDefined(var_4776f2b8)) {
    stopfx(localclientnum, var_4776f2b8);
    var_4776f2b8 = undefined;
  }
}