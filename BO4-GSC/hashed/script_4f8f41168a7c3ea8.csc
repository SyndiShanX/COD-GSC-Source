/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_4f8f41168a7c3ea8.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace namespace_fc5c8455;

autoexec __init__system__() {
  system::register(#"hash_32658a301920c858", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "" + #"magma_fireplace_fx", 1, getminbitcountfornum(4), "int", &magma_fireplace_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"magma_fireplace_skull_fx", 1, 1, "int", &magma_fireplace_skull_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"magma_door_barrier_fx", 1, 1, "int", &magma_door_barrier_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"magma_glow_fx", 1, 1, "int", &magma_glow_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"magma_urn_fire_fx", 1, 2, "int", &magma_urn_fire_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"bg_spawn_fx", 1, 1, "int", &function_4707df22, 0, 0);
  clientfield::register("toplayer", "" + #"magma_gat_glow_override", 1, 1, "int", &magma_gat_glow_override, 0, 0);
  clientfield::register("toplayer", "" + #"magma_gat_glow_recharge", 1, 1, "counter", &magma_gat_glow_recharge, 0, 0);
  clientfield::register("toplayer", "" + #"magma_gat_glow_shot_fired", 1, 1, "counter", &magma_gat_glow_shot_fired, 0, 0);
  clientfield::register("scriptmover", "" + #"magma_essence_explode_fx", 1, 1, "int", &magma_essence_explode_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"magma_gat_essence_fx", 1, 1, "int", &magma_gat_essence_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"magma_gat_disappear_fx", 1, 1, "counter", &magma_gat_disappear_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"magma_urn_triggered_fx", 1, 1, "counter", &magma_urn_triggered_fx, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_7692067c56d8b6cc", 1, 2, "int", &function_84e77740, 0, 0);
  level._effect[#"magma_fireplace"] = #"hash_50cd5a75aebe8def";
  level._effect[#"hash_22aea05cb07dd55e"] = #"hash_51005475aee9dd56";
  level._effect[#"hash_70407be743f59f31"] = #"hash_2fcb634860aadcc5";
  level._effect[#"hash_708f71e744396284"] = #"hash_303469486103d000";
  level._effect[#"magma_skull"] = #"hash_6b993f3f5e31e2b5";
  level._effect[#"hash_1553e20e5242f527"] = #"hash_ce21486cbb74ba2";
  level._effect[#"hash_d9adad5b2ead852"] = #"hash_1a2b69544013ee25";
  level._effect[#"magma_glow"] = #"hash_69324137a8ab8427";
  level._effect[#"bg_quest_spawn"] = #"hash_1636a510bead42c2";
  level._effect[#"bg_quest_despawn"] = #"hash_4a9c1f83345c624b";
  level._effect[#"hash_40c10e05964e71b5"] = #"hash_4c5e26f94f35e7fb";
  level._effect[#"magma_urn"] = #"hash_2529982fe72e4e4";
  level._effect[#"hash_577c7197e639a24b"] = #"hash_6ce5c811700c8c4";
  level._effect[#"hash_71cebe03a25b3339"] = #"hash_6f5790d353dd5caf";
  level._effect[#"hash_28455b81d5e86c62"] = #"hash_4d293d8817fcdc0c";
  level._effect[#"hash_54790ee0d9025900"] = #"hash_6fdfb9444067e8f4";
  level._effect[#"hash_5d3b4b76ea5885f6"] = #"hash_4835bd332e8a78c7";
  level._effect[#"hash_3932ab509a43ca38"] = #"hash_7c63ac8e5b0a88e6";
  level._effect[#"acid_gat_lock_fx"] = #"hash_170bbc9437bc68c9";
}

magma_fireplace_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_634618de)) {
    stopfx(localclientnum, self.var_634618de);
    self.var_634618de = undefined;
  }

  switch (newval) {
    case 1:
      self.var_634618de = util::playFXOnTag(localclientnum, level._effect[#"magma_fireplace"], self, "tag_origin");
      break;
    case 2:
      self.var_634618de = util::playFXOnTag(localclientnum, level._effect[#"hash_22aea05cb07dd55e"], self, "tag_origin");
      break;
    case 3:
      self.var_634618de = util::playFXOnTag(localclientnum, level._effect[#"hash_708f71e744396284"], self, "tag_origin");
      break;
    case 4:
      self.var_634618de = util::playFXOnTag(localclientnum, level._effect[#"hash_70407be743f59f31"], self, "tag_origin");
      break;
  }
}

magma_fireplace_skull_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self.var_d96d2274)) {
      stopfx(localclientnum, self.var_d96d2274);
      self.var_d96d2274 = undefined;
    }

    self.var_d96d2274 = util::playFXOnTag(localclientnum, level._effect[#"magma_skull"], self, "afterlife_01");
    return;
  }

  if(isDefined(self.var_d96d2274)) {
    stopfx(localclientnum, self.var_d96d2274);
    self.var_d96d2274 = undefined;
  }
}

magma_gat_essence_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self.var_55792791)) {
      stopfx(localclientnum, self.var_55792791);
      self.var_55792791 = undefined;
    }

    self.var_55792791 = util::playFXOnTag(localclientnum, level._effect[#"hash_54790ee0d9025900"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_55792791)) {
    killfx(localclientnum, self.var_55792791);
    self.var_55792791 = undefined;
  }
}

magma_door_barrier_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self.var_57692f88)) {
      stopfx(localclientnum, self.var_57692f88);
      self.var_57692f88 = undefined;
    }

    self.var_57692f88 = util::playFXOnTag(localclientnum, level._effect[#"hash_1553e20e5242f527"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_57692f88)) {
    stopfx(localclientnum, self.var_57692f88);
    self.var_57692f88 = undefined;
  }
}

magma_glow_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    if(isDefined(self.var_4e35f286)) {
      stopfx(localclientnum, self.var_4e35f286);
      self.var_4e35f286 = undefined;
    }

    self.var_4e35f286 = util::playFXOnTag(localclientnum, level._effect[#"magma_glow"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_4e35f286)) {
    stopfx(localclientnum, self.var_4e35f286);
    self.var_4e35f286 = undefined;
  }
}

magma_essence_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    util::playFXOnTag(localclientnum, level._effect[#"hash_40c10e05964e71b5"], self, "tag_origin");
  }
}

magma_gat_disappear_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_d9adad5b2ead852"], self, "tag_origin");
}

magma_gat_glow_override(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self playrenderoverridebundle(#"hash_4fb0136f51fcf7", "tag_weapon");
    self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", 0.7);
    self thread function_f9a794dc(localclientnum);
    self thread function_eba88fd(localclientnum);
    return;
  }

  self notify(#"hash_4086299956cef09d");

  if(isDefined(self.var_c183198c)) {
    self stoploopsound(self.var_c183198c);
    self.var_c183198c = undefined;
  }

  self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", 0);
  self stoprenderoverridebundle(#"hash_4fb0136f51fcf7", "tag_weapon");
}

magma_gat_glow_recharge(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!isDefined(self.var_23c215c)) {
    self.var_23c215c = 25;
  }

  if(self.var_23c215c + 25 > 25) {
    self.var_23c215c = 25;
  } else {
    self.var_23c215c += 25;
  }

  if(isDefined(self.var_fa938ed8)) {
    self.var_fa938ed8 = 0;
  }

  self thread function_d193f583(localclientnum);
  self playrumbleonentity(localclientnum, #"hash_41507a7755099d85");
  self stoprumble(localclientnum, #"hash_3c64ae4793e47b3a");
}

private function_d193f583(localclientnum) {
  self notify(#"hash_67dbde4a0231b582");
  self endon(#"death", #"hash_4086299956cef09d", #"hash_67dbde4a0231b582");

  if(isDefined(self.var_c183198c)) {
    self stoploopsound(self.var_c183198c);
    self.var_c183198c = undefined;
  }

  if(!isDefined(self.var_8e748ffa)) {
    self.var_8e748ffa = self playLoopSound(#"hash_6d1e9399310efe71");
  }

  wait 2;

  if(isDefined(self.var_8e748ffa)) {
    self stoploopsound(self.var_8e748ffa);
    self.var_8e748ffa = undefined;
  }

  self.var_c183198c = self playLoopSound(#"hash_1bc434008189933f");
}

private function_f9a794dc(localclientnum) {
  self endon(#"death", #"hash_4086299956cef09d");
  level endon(#"end_game");
  self.var_23c215c = 25;
  self.var_c183198c = self playLoopSound(#"hash_1bc434008189933f");
  self.var_fa938ed8 = 0;
  self.var_d9ebae63 = gettime();

  while(isDefined(self) && self.var_23c215c > 0) {
    n_current_time = gettime();
    var_4eb46607 = (n_current_time - self.var_d9ebae63) / 1000;
    self.var_d9ebae63 = n_current_time;

    if(self.var_fa938ed8) {
      self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", 0.016);
      self playrumbleonentity(localclientnum, #"hash_3c64ae4793e47b3a");
      self stoprumble(localclientnum, #"hash_41507a7755099d85");
    } else {
      var_7616c359 = math::linear_map(self.var_23c215c, 0, 25, 0.15, 0.7);
      self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", var_7616c359);
    }

    if(self.var_23c215c <= 5) {
      self.var_23c215c -= 0.5;

      if(self.var_fa938ed8) {
        self.var_fa938ed8 = 0;
      } else {
        self.var_fa938ed8 = 1;
      }

      wait 0.5;
      continue;
    }

    self.var_23c215c -= var_4eb46607;
    waitframe(1);
  }

  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  if(isDefined(self.var_c183198c)) {
    self stoploopsound(self.var_c183198c);
    self.var_c183198c = undefined;
  }

  self function_78233d29(#"hash_4fb0136f51fcf7", "tag_weapon", "Brightness", 0);
}

function_eba88fd(localclientnum) {
  self endon(#"death", #"disconnect", #"hash_4086299956cef09d");

  if(!self util::function_50ed1561(localclientnum)) {
    return;
  }

  while(isDefined(self.var_23c215c) && self.var_23c215c > 0) {
    if(isDefined(self.var_83748d31)) {
      stopfx(localclientnum, self.var_83748d31);
    }

    if(self zm_utility::function_f8796df3(localclientnum)) {
      if(viewmodelhastag(localclientnum, "tag_flash")) {
        self.var_83748d31 = playviewmodelfx(localclientnum, level._effect[#"hash_5d3b4b76ea5885f6"], "tag_flash");
      }
    }

    if(self.var_23c215c > 20) {
      wait 0.1;
      continue;
    }

    if(self.var_23c215c > 15) {
      wait 0.2;
      continue;
    }

    if(self.var_23c215c > 10) {
      wait 0.4;
      continue;
    }

    if(self.var_23c215c > 5) {
      wait 1;
      continue;
    }

    wait 2;
  }
}

magma_gat_glow_shot_fired(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_23c215c)) {
    self.var_23c215c -= 6;

    if(self.var_23c215c < 0) {
      self.var_23c215c = 0;
    }
  }
}

magma_forging_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 2) {
    if(isDefined(self.var_634618de)) {
      stopfx(localclientnum, self.var_634618de);
      self.var_634618de = undefined;
    }

    self.var_634618de = util::playFXOnTag(localclientnum, level._effect[#"hash_22aea05cb07dd55e"], self, "tag_origin");
    return;
  }

  if(newval == 1) {
    if(isDefined(self.var_634618de)) {
      stopfx(localclientnum, self.var_634618de);
      self.var_634618de = undefined;
    }

    self.var_634618de = util::playFXOnTag(localclientnum, level._effect[#"magma_fireplace"], self, "tag_origin");
    return;
  }

  if(isDefined(self.var_634618de)) {
    stopfx(localclientnum, self.var_634618de);
    self.var_634618de = undefined;
  }
}

magma_urn_fire_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_d8243293)) {
    stopfx(localclientnum, self.var_d8243293);
    self.var_d8243293 = undefined;
  }

  if(isDefined(self.var_5abbf89a)) {
    stopfx(localclientnum, self.var_5abbf89a);
    self.var_5abbf89a = undefined;
  }

  if(newval == 1) {
    self.var_d8243293 = util::playFXOnTag(localclientnum, level._effect[#"magma_urn"], self, "tag_origin");
    self.var_5abbf89a = util::playFXOnTag(localclientnum, level._effect[#"hash_71cebe03a25b3339"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    self.var_d8243293 = util::playFXOnTag(localclientnum, level._effect[#"hash_577c7197e639a24b"], self, "tag_origin");
    self.var_5abbf89a = util::playFXOnTag(localclientnum, level._effect[#"hash_28455b81d5e86c62"], self, "tag_origin");
  }
}

function_4707df22(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_85dab00b)) {
    stopfx(localclientnum, self.var_85dab00b);
    self.var_85dab00b = undefined;
    playFX(localclientnum, level._effect[#"bg_quest_despawn"], self.origin);
    playSound(localclientnum, #"hash_c9e5d07bd26090d", self.origin);
  }

  if(newval == 1) {
    self.var_85dab00b = util::playFXOnTag(localclientnum, level._effect[#"bg_quest_spawn"], self, "tag_origin");
    playSound(localclientnum, #"hash_4cd38326868832c7", self.origin);
  }
}

function_84e77740(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self playrenderoverridebundle(#"hash_68ee9247aaae4517");
    self function_78233d29(#"hash_68ee9247aaae4517", "", "Brightness", 1);
    self function_78233d29(#"hash_68ee9247aaae4517", "", "Alpha", 1);
    self function_78233d29(#"hash_68ee9247aaae4517", "", "Tint", 1);
  }

  if(newval == 2) {
    self thread function_bbfe3432(localclientnum);
    return;
  }

  self notify(#"hash_4236253d10aeec5e");
}

function_bbfe3432(localclientnum) {
  self endon(#"hash_4236253d10aeec5e");
  var_be5f61d5 = 0.5;

  while(var_be5f61d5 >= 5e-07 && isDefined(self)) {
    self function_78233d29(#"hash_68ee9247aaae4517", "", "Alpha", var_be5f61d5);
    self function_78233d29(#"hash_68ee9247aaae4517", "", "Brightness", var_be5f61d5);
    var_be5f61d5 /= 2.5;
    wait 0.3;
  }
}

magma_urn_triggered_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"hash_3932ab509a43ca38"], self, "tag_origin");
  playSound(localclientnum, #"hash_4cd38326868832c7", self.origin);
}

acid_gat_lock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::playFXOnTag(localclientnum, level._effect[#"acid_gat_lock_fx"], self, "tag_origin");
}