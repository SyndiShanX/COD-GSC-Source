/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_mq_blood.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace zm_orange_mq_blood;

preload() {
  level._effect[#"hash_69e92a9c52f7fc5f"] = #"hash_6f5dab3bf1409cdb";
  level._effect[#"hash_69e92b9c52f7fe12"] = #"hash_4f1f3e18228ac0a0";
  level._effect[#"hash_69e92c9c52f7ffc5"] = #"hash_73e8d2cf76175901";
  level._effect[#"hash_748a2e401bbe345c"] = #"hash_7f7ec340b96e5096";
  level._effect[#"hash_2717a5ed66a93a2d"] = #"hash_483b6baf03385a7d";
  clientfield::register("scriptmover", "" + #"hash_10906b9ce905bda8", 24000, 3, "int", &function_80d2bf71, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_5dd642a0bd6e6cb9", 24000, 2, "int", &function_aae8819, 0, 0);
  level._effect[#"hash_2aea4060746fe17a"] = #"hash_45c853fb6ff73c34";
  level._effect[#"hash_2aea3f60746fdfc7"] = #"hash_3b65f2e4019b78eb";
  level._effect[#"hash_2aea3e60746fde14"] = #"hash_8c5d404ef012ce";
  clientfield::register("scriptmover", "" + #"hash_1b72c208f2964e24", 24000, 3, "int", &function_3a0ab08b, 0, 0);
}

function_80d2bf71(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self util::waittill_dobj(localclientnum);
    self.stage_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_69e92a9c52f7fc5f"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    if(isDefined(self.stage_fx)) {
      stopfx(localclientnum, self.stage_fx);
    }

    self.stage_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_69e92b9c52f7fe12"], self, "tag_origin");
    return;
  }

  if(newval == 3) {
    if(isDefined(self.stage_fx)) {
      stopfx(localclientnum, self.stage_fx);
    }

    self.stage_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_69e92c9c52f7ffc5"], self, "tag_origin");
    return;
  }

  if(isDefined(self.stage_fx)) {
    stopfx(localclientnum, self.stage_fx);
  }
}

function_aae8819(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.fx)) {
    stopfx(localclientnum, self.fx);
  }

  if(newval == 1) {
    self.fx = util::playFXOnTag(localclientnum, level._effect[#"hash_748a2e401bbe345c"], self, "tag_origin");

    if(!isDefined(self.sfx)) {
      self playSound(0, #"hash_7867b5508ce25848");
      self.sfx = self playLoopSound(#"hash_2c5ad3d4cdc507c");
    }

    return;
  }

  if(newval == 2) {
    self.fx = util::playFXOnTag(localclientnum, level._effect[#"hash_2717a5ed66a93a2d"], self, "tag_origin");

    if(!isDefined(self.sfx)) {
      self playSound(0, #"hash_7867b5508ce25848");
      self.sfx = self playLoopSound(#"hash_2c5ad3d4cdc507c");
    }

    return;
  }

  if(isDefined(self.sfx)) {
    self playSound(0, #"hash_6e263590089ef88e");
    self stoploopsound(self.sfx);
    self.sfx = undefined;
  }
}

function_3a0ab08b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  str_tag = "tag_origin";

  if(self.model === #"hash_32baa51d012e13b9") {
    str_tag = "tag_item_5";
  }

  if(isDefined(self.var_3177d514)) {
    self stoploopsound(self.var_3177d514);
    self.var_3177d514 = undefined;
  }

  if(newval == 1) {
    self util::waittill_dobj(localclientnum);
    self.stage_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_2aea4060746fe17a"], self, str_tag);
    self.var_3177d514 = self playLoopSound(#"hash_218e114cfa2b9a4");
    return;
  }

  if(newval == 2) {
    if(isDefined(self.stage_fx)) {
      stopfx(localclientnum, self.stage_fx);
    }

    self.stage_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_2aea3f60746fdfc7"], self, str_tag);
    self.var_3177d514 = self playLoopSound(#"hash_218e414cfa2bebd");
    return;
  }

  if(newval == 3) {
    if(isDefined(self.stage_fx)) {
      stopfx(localclientnum, self.stage_fx);
    }

    self.stage_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_2aea3e60746fde14"], self, str_tag);
    self.var_3177d514 = self playLoopSound(#"hash_218e314cfa2bd0a");
    return;
  }

  if(isDefined(self.stage_fx)) {
    stopfx(localclientnum, self.stage_fx);
  }
}