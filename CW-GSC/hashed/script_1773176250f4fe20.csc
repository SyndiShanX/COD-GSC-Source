/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1773176250f4fe20.csc
***********************************************/

#using script_4e53735256f112ac;
#using script_d67878983e3d7c;
#using scripts\core_common\beam_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_bf2d4e77;

function private autoexec __init__system__() {
  system::register(#"hash_6be63b3e08b5ceb9", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("actor", "" + # "hash_6a9eb737488c81c7", 11000, 1, "counter", &function_77972a15, 0, 0);
  clientfield::register("actor", "" + # "hash_13a6ddf6358f814", 11000, 1, "int", &function_7431f6cc, 0, 0);
  level.var_1765ad79 = 0;
}

function function_77972a15(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(bwastimejump);

  if(!isDefined(self.model) || self.model == # "") {
    return;
  }

  if(self haspart(bwastimejump, "j_spine4")) {
    str_tag = "j_spine4";
  } else {
    str_tag = "tag_origin";
  }

  util::playFXOnTag(bwastimejump, #"hash_75b91d12ce404b81", self, str_tag);
  playSound(bwastimejump, #"hash_5ab58aab70a35c94", self.origin + (0, 0, 35));
}

function function_7431f6cc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);

  if(!isDefined(self.model) || self.model == # "") {
    return;
  }

  if(self haspart(fieldname, "j_spine4")) {
    str_tag = "j_spine4";
  } else {
    str_tag = "tag_origin";
  }

  if(bwastimejump) {
    if(!isDefined(self.var_47d4e598)) {
      str_fx = # "hash_1f8f75941d481d68";

      if(isDefined(self.archetype)) {
        switch (self.archetype) {
          case # "mechz":
          case # "hash_7c0d83ac1e845ac2":
            str_fx = # "hash_1f5c7f941d1cd4cd";
            break;
          case # "raz":
          case # "mimic":
          case # "zombie_dog":
            str_fx = # "hash_1f5f62941d1ed95d";
            break;
          case # "zombie":
          case # "avogadro":
            str_fx = # "hash_1f8f75941d481d68";
            break;
          default:
            str_fx = # "hash_1f8f75941d481d68";
            break;
        }
      }

      self.var_47d4e598 = util::playFXOnTag(fieldname, str_fx, self, str_tag);
    }

    if(!isDefined(self.var_9dc86d3e)) {
      self playSound(fieldname, #"hash_45c4b084d38f5afe");
      self.var_9dc86d3e = self playLoopSound(#"hash_5b2010d2b4f171ba", undefined, (0, 0, 35));
    }

    return;
  }

  if(isDefined(self.var_47d4e598)) {
    stopfx(fieldname, self.var_47d4e598);
    self.var_47d4e598 = undefined;
  }

  if(isDefined(self.var_9dc86d3e)) {
    self stoploopsound(self.var_9dc86d3e);
    self.var_9dc86d3e = undefined;
  }

  var_37cec89a = # "hash_1f8f75941d481d68";

  if(isDefined(self.archetype)) {
    switch (self.archetype) {
      case # "mechz":
      case # "hash_7c0d83ac1e845ac2":
        var_37cec89a = # "hash_d17ba387ed58333";
        break;
      case # "raz":
      case # "mimic":
      case # "zombie_dog":
        var_37cec89a = # "hash_704b1e9eda987ea3";
        break;
      case # "soa":
      case # "zombie":
      case # "avogadro":
        var_37cec89a = # "hash_787176da22ad853a";
        break;
      default:
        var_37cec89a = # "hash_787176da22ad853a";
        break;
    }
  }

  util::playFXOnTag(fieldname, var_37cec89a, self, str_tag);
}