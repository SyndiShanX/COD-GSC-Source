/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_triad.csc
***********************************************/

#include scripts\core_common\beam_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\zm\ai\zm_ai_stoker;
#include scripts\zm_common\load;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;

#namespace mansion_triad;

init_clientfields() {
  level._effect[#"hash_2321fa1d61c16113"] = #"hash_3b34b1e477be8113";
  level._effect[#"hash_231b0e1d61bb6461"] = #"hash_3b2dc5e477b88461";
  level._effect[#"kp_projectile"] = #"hash_59977c4c851916e0";
  level._effect[#"hash_27063b90fbaa52"] = #"hash_1a06427eff8dfe13";
  level._effect[#"hash_2e3e645052f77846"] = #"hash_78712d347cdd5147";
  level._effect[#"hash_3953ee06542d1089"] = #"hash_795ee7d89d6f10d2";
  level._effect[#"hash_48b3ee505e47cbfc"] = #"hash_69f0c87c19162d91";
  clientfield::register("allplayers", "" + #"shield_fire", 8000, 1, "int", &function_da63d789, 0, 0);
  clientfield::register("scriptmover", "" + #"triad_beam", 8000, getminbitcountfornum(3), "int", &triad_beam, 0, 0);
  clientfield::register("scriptmover", "" + #"wisp_fx", 8000, 2, "int", &function_41640257, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_2108935a0c33f89a", 8000, getminbitcountfornum(3), "int", &function_b24b4025, 0, 0);
  zm_sq_modules::function_d8383812(#"soul_capture_kp1", 8000, #"kp_1", 400, level._effect[#"kp_projectile"], level._effect[#"hash_27063b90fbaa52"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"soul_capture_kp2", 8000, #"kp_2", 400, level._effect[#"kp_projectile"], level._effect[#"hash_27063b90fbaa52"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"soul_capture_kp3", 8000, #"kp_3", 400, level._effect[#"kp_projectile"], level._effect[#"hash_27063b90fbaa52"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"soul_capture_kp1_halfway", 8000, #"kp_1_halfway", 400, level._effect[#"kp_projectile"], level._effect[#"hash_27063b90fbaa52"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"soul_capture_kp2_halfway", 8000, #"kp_2_halfway", 400, level._effect[#"kp_projectile"], level._effect[#"hash_27063b90fbaa52"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"soul_capture_kp3_halfway", 8000, #"kp_3_halfway", 400, level._effect[#"kp_projectile"], level._effect[#"hash_27063b90fbaa52"], undefined, undefined, 1);
  zm_sq_modules::function_d8383812(#"soul_capture_forest", 8000, #"kp_forest", 400, level._effect[#"kp_projectile"], level._effect[#"hash_27063b90fbaa52"], undefined, undefined, 1);
}

function_da63d789(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(!isDefined(self.fx_blue_fire)) {
      if(zm_utility::function_f8796df3(localclientnum) && self util::function_50ed1561(localclientnum)) {
        self.fx_blue_fire = playviewmodelfx(localclientnum, level._effect[#"hash_2321fa1d61c16113"], "tag_weapon_left");

        if(!isDefined(self.var_eb8d44ea)) {
          self.var_eb8d44ea = self playLoopSound(#"hash_c4d6c7df050f11");
        }
      } else if(!function_65b9eb0f(localclientnum)) {
        self.fx_blue_fire = util::playFXOnTag(localclientnum, level._effect[#"hash_231b0e1d61bb6461"], self, "tag_weapon_left");

        if(!isDefined(self.var_eb8d44ea)) {
          self.var_eb8d44ea = self playLoopSound(#"hash_2a183bc7ade935b0");
        }
      } else {
        self endon(#"hash_4df59fed1b90332a");
        var_77e629d2 = undefined;
        var_6ab87412 = undefined;
        fx_blue_fire = undefined;

        while(isDefined(self) && function_65b9eb0f(localclientnum)) {
          if(zm_utility::function_f8796df3(localclientnum) && !isthirdperson(localclientnum)) {
            if(!(isDefined(var_77e629d2) && var_77e629d2)) {
              if(isDefined(fx_blue_fire)) {
                killfx(localclientnum, fx_blue_fire);
              }

              fx_blue_fire = playviewmodelfx(localclientnum, level._effect[#"hash_2321fa1d61c16113"], "tag_weapon_left");
              var_77e629d2 = 1;
              var_6ab87412 = 0;
              self thread function_da5e1d54(localclientnum, fx_blue_fire);
            }
          } else if(!(isDefined(var_6ab87412) && var_6ab87412)) {
            if(isDefined(fx_blue_fire)) {
              killfx(localclientnum, fx_blue_fire);
            }

            fx_blue_fire = util::playFXOnTag(localclientnum, level._effect[#"hash_231b0e1d61bb6461"], self, "tag_weapon_left");
            var_6ab87412 = 1;
            var_77e629d2 = 0;
            self thread function_da5e1d54(localclientnum, fx_blue_fire);
          }

          wait 0.1;
        }

        if(isDefined(fx_blue_fire)) {
          killfx(localclientnum, fx_blue_fire);
        }
      }
    }

    return;
  }

  if(isDefined(self.fx_blue_fire)) {
    deletefx(localclientnum, self.fx_blue_fire);
    self.fx_blue_fire = undefined;
  }

  if(isDefined(self.var_eb8d44ea)) {
    self stoploopsound(self.var_eb8d44ea);
    self.var_eb8d44ea = undefined;
    self playSound(localclientnum, #"hash_4c0f6dc77900b94a");
  }

  self notify(#"hash_4df59fed1b90332a");
}

function_da5e1d54(localclientnum, fx_blue_fire) {
  self notify("100e93786f2c9d8d");
  self endon("100e93786f2c9d8d");
  self waittill(#"hash_4df59fed1b90332a", #"death");

  if(isDefined(fx_blue_fire) && isDefined(function_5c10bd79(localclientnum))) {
    killfx(localclientnum, fx_blue_fire);
  }
}

triad_beam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    if(!isDefined(self.e_target)) {
      switch (newval) {
        case 1:
          s_loc = struct::get("kp1_line_target");
          break;
        case 2:
          s_loc = struct::get("kp2_line_target");
          break;
        case 3:
          s_loc = struct::get("kp3_line_target");
          break;
      }

      if(isDefined(s_loc)) {
        self.e_target = util::spawn_model(localclientnum, "tag_origin", s_loc.origin, s_loc.angles);
        level beam::launch(self, "tag_origin", self.e_target, "tag_origin", "beam8_zm_spectral_trap", 1);
      }
    }

    return;
  }

  if(isDefined(self.e_target)) {
    level beam::kill(self, "tag_origin", self.e_target, "tag_origin", "beam8_zm_spectral_trap");
    self.e_target delete();
  }
}

function_41640257(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  if(newval == 1) {
    if(isDefined(self.fx_wisp)) {
      killfx(localclientnum, self.fx_wisp);
    }

    self.fx_wisp = util::playFXOnTag(localclientnum, level._effect[#"hash_2e3e645052f77846"], self, "tag_origin");

    if(!isDefined(self.var_5fdd4f20)) {
      self playSound(localclientnum, #"hash_954c283694c074");
      self.var_5fdd4f20 = self playLoopSound(#"hash_3ce3b3c381327cd4");
    }

    return;
  }

  if(newval == 2) {
    if(isDefined(self.fx_wisp)) {
      stopfx(localclientnum, self.fx_wisp);
    }

    self.fx_wisp = util::playFXOnTag(localclientnum, level._effect[#"hash_2e3e645052f77846"], self, "chest_jnt");
    return;
  }

  if(isDefined(self.fx_wisp)) {
    stopfx(localclientnum, self.fx_wisp);
    self.fx_wisp = undefined;
  }

  if(isDefined(self.var_5fdd4f20)) {
    self stoploopsound(self.var_5fdd4f20);
    self playSound(localclientnum, #"hash_7579ac34b357732d");
    self.var_5fdd4f20 = undefined;
  }
}

function_b24b4025(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval > 0) {
    if(!isDefined(self.var_2cf005a1)) {
      switch (newval) {
        case 1:
          self.var_2cf005a1 = #"hash_6358e0c353947bef";
          break;
        case 2:
          self.var_2cf005a1 = #"hash_2cc925174fca95fa";
          break;
        case 3:
          self.var_2cf005a1 = #"hash_18d5b37bd34e52c3";
          break;
      }

      if(isDefined(self.var_2cf005a1)) {
        self playrenderoverridebundle(self.var_2cf005a1);
      }
    }

    if(!isDefined(self.var_f9a31f04)) {
      self.var_f9a31f04 = self playLoopSound(#"hash_1227666e11ddb279");
    }

    return;
  }

  if(isDefined(self.var_2cf005a1)) {
    self stoprenderoverridebundle(self.var_2cf005a1);
    self.var_2cf005a1 = undefined;
  }

  if(isDefined(self.var_f9a31f04)) {
    self stoploopsound(self.var_f9a31f04);
    self.var_f9a31f04 = undefined;
  }
}