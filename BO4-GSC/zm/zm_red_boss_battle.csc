/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_boss_battle.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_aoe;

#namespace red_boss_battle;

init() {
  clientfield::register("missile", "" + #"hash_64910f94ebb8d66a", 16000, 2, "int", &function_6e3ecc82, 0, 0);
  clientfield::register("scriptmover", "" + #"pegasus_emerge", 16000, 1, "counter", &pegasus_emerge, 0, 0);
  clientfield::register("scriptmover", "" + #"pegasus_storm", 16000, 1, "int", &function_272aa016, 0, 0);
  clientfield::register("allplayers", "" + #"hash_73e309ffb25bf63d", 16000, 1, "int", &function_a27b945a, 0, 0);
  clientfield::register("toplayer", "" + #"hash_3bb8b5cda11eecc6", 16000, 1, "counter", &function_b9329291, 0, 0);
  clientfield::register("scriptmover", "" + #"lightning_impact_fx", 16000, 1, "int", &function_ed1d0231, 0, 0);
  clientfield::register("scriptmover", "" + #"lightning_arc_fx", 16000, 1, "int", &function_37d1ee2e, 0, 0);
  clientfield::register("scriptmover", "" + #"viper_bite_bitten_fx", 16000, 1, "int", &function_5091797, 0, 0);
  clientfield::register("scriptmover", "" + #"viper_bite_projectile_impact", 16000, 1, "counter", &function_e2680ff3, 0, 0);
  level._effect[#"hash_52f038f656770d3f"] = #"hash_433034414b39f1ef";
  level._effect[#"chaos_bolt_2"] = #"hash_433035414b39f3a2";
  level._effect[#"hash_52f03af6567710a5"] = #"hash_7a9a94bbcf902878";
  level._effect[#"pegasus_emerge"] = #"hash_9c7935d1106ec1d";
  level._effect[#"storm_radius"] = #"hash_4dd46a244305d465";
  level.s_boss_battle = spawnStruct();
}

function_6e3ecc82(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  switch (newval) {
    case 0:
      if(isDefined(self.fx)) {
        stopfx(localclientnum, self.fx);
      }

      break;
    case 1:
    case 2:
    case 3:
      self util::waittill_dobj(localclientnum);
      self.fx = util::playFXOnTag(localclientnum, level._effect[#"chaos_bolt_" + newval], self, "tag_origin");
      break;
  }
}

pegasus_emerge(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::playFXOnTag(localclientnum, level._effect[#"pegasus_emerge"], self, "tag_origin");
}

function_272aa016(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("1eb9df21273269b8");
  self endon("1eb9df21273269b8");

  if(newval) {
    self.fx_id = util::playFXOnTag(localclientnum, level._effect[#"storm_radius"], self, "tag_origin");

    if(!isDefined(self.sfx_id)) {
      self.sfx_id = self playLoopSound(#"hash_5760b615b9b749d2");
    }

    return;
  }

  if(isDefined(self.fx_id)) {
    stopfx(localclientnum, self.fx_id);
  }

  if(isDefined(self.sfx_id)) {
    self stoploopsound(self.sfx_id);
    self.sfx_id = undefined;
  }
}

function_a27b945a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.s_boss_battle.var_4475b443)) {
    return 0;
  }

  str_tag = "tag_origin";
  level beam::launch(level.s_boss_battle.var_4475b443, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike", 1);
  self playSound(localclientnum, #"hash_61c057ffadb7a5af");
  wait 1.5;
  level beam::kill(level.s_boss_battle.var_4475b443, str_tag, self, "j_spine4", "beam8_zm_red_peg_lightning_strike");
}

function_b9329291(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  function_36e4ebd4(localclientnum, "damage_light");
}

function_ed1d0231(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  str_fx_tag = isDefined(self gettagorigin("j_mainroot")) ? "j_mainroot" : "tag_driver";

  if(isDefined(self.var_89d8285)) {
    deletefx(localclientnum, self.var_89d8285, 1);
    self.var_89d8285 = undefined;
  }

  if(newval == 1) {
    self.var_89d8285 = util::playFXOnTag(localclientnum, level._effect[#"lightning_impact"], self, str_fx_tag);
    self playSound(localclientnum, #"hash_63d588d1f28ecdc1");
  }
}

function_37d1ee2e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread function_e9aa9e80(localclientnum);
    self thread function_954b9602(localclientnum);
    return;
  }

  self notify(#"hash_5531647ca0352039");
}

private function_e9aa9e80(localclientnum) {
  self endon(#"death", #"hash_5531647ca0352039");

  while(!isDefined(level.var_76234ae5[localclientnum])) {
    waitframe(1);
  }

  e_ball = level.var_76234ae5[localclientnum];
  e_ball endon(#"death");
  util::server_wait(localclientnum, randomfloatrange(0.05, 0.1));

  if(!isDefined(e_ball)) {
    return;
  }

  self.e_fx = util::spawn_model(localclientnum, #"tag_origin", e_ball.origin);
  self.fx_arc = util::playFXOnTag(localclientnum, level._effect[#"lightning_arc"], self.e_fx, "tag_origin");

  while(true) {
    str_fx_tag = isDefined(self gettagorigin("j_mainroot")) ? "j_mainroot" : "tag_driver";
    var_a05eed18 = self gettagorigin(str_fx_tag);

    if(isDefined(var_a05eed18)) {
      self.e_fx moveto(var_a05eed18, 0.1);
    } else {
      self.e_fx moveto(self.origin, 0.1);
    }

    util::server_wait(localclientnum, 0.1);

    if(!isDefined(e_ball)) {
      return;
    }

    self.e_fx moveto(e_ball.origin, 0.1);
    util::server_wait(localclientnum, 0.1);
  }
}

private function_954b9602(localclientnum) {
  self waittill(#"death", #"hash_5531647ca0352039");

  if(isDefined(self.fx_arc)) {
    stopfx(localclientnum, self.fx_arc);
    self.fx_arc = undefined;
  }

  if(isDefined(self.e_fx)) {
    self.e_fx delete();
    self.e_fx = undefined;
  }
}

function_5091797(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  str_fx_tag = isDefined(self gettagorigin("j_mainroot")) ? "j_mainroot" : "tag_driver";

  if(newval == 1) {
    self.var_cc9c5baa = util::playFXOnTag(localclientnum, level._effect[#"hash_206a58239ffb5e0f"], self, str_fx_tag);

    if(!isDefined(self.var_6450813b)) {
      self playSound(localclientnum, #"hash_76feff9b8f93c3d9");
      self.var_6450813b = self playLoopSound(#"hash_117558f0dda6471f");
    }

    return;
  }

  if(isDefined(self.var_cc9c5baa)) {
    stopfx(localclientnum, self.var_cc9c5baa);
  }

  if(isDefined(self.var_6450813b)) {
    self playSound(localclientnum, #"hash_ae4b548c1d4a748");
    self stoploopsound(self.var_6450813b);
    self.var_6450813b = undefined;
  }

  util::playFXOnTag(localclientnum, level._effect[#"hash_b784dd4d224f7e"], self, str_fx_tag);
}

function_e2680ff3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  str_fx_tag = isDefined(self gettagorigin("j_mainroot")) ? "j_mainroot" : "tag_driver";
  util::playFXOnTag(localclientnum, level._effect[#"viper_bite_projectile_impact"], self, str_fx_tag);
  self playSound(0, #"hash_3098cba1f74bb5d1");
}