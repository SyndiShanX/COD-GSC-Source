/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_eff00f787d80cdf.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace awareness;

function private autoexec __init__system__() {
  system::register(#"awareness", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "sndAwarenessChange", 1, 2, "int", &function_d83b47c4, 0, 0);
}

function function_d83b47c4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  self endon(#"death");
  self notify(#"hash_4c0620b64b0af0e");
  self endon(#"hash_4c0620b64b0af0e");

  if(isDefined(self.var_35e2a4c0)) {
    self stoploopsound(self.var_35e2a4c0);
  }

  var_8faf8279 = function_3b0ca643(self);

  if(!isDefined(var_8faf8279)) {
    return;
  }

  if(wasdemojump) {
    switch (wasdemojump) {
      case 1:
        var_e5404960 = var_8faf8279.var_1510a94a;
        var_9c464736 = var_8faf8279.var_4ec57c29;
        break;
      case 2:
        var_e5404960 = var_8faf8279.var_e31a323c;
        var_9c464736 = var_8faf8279.var_f6b3e5dd;
        break;
      case 3:
        var_e5404960 = var_8faf8279.var_fd89f5fb;
        var_9c464736 = var_8faf8279.var_6e38d21c;
        break;
      default:
        var_e5404960 = var_8faf8279.var_1510a94a;
        var_9c464736 = var_8faf8279.var_4ec57c29;
        break;
    }

    self playSound(fieldname, var_e5404960, self.origin + var_8faf8279.v_offset);
    wait 0.75;
    self.var_35e2a4c0 = self playLoopSound(var_9c464736, 1.5, var_8faf8279.v_offset);
  }
}

function function_3b0ca643(e_ai) {
  e_ai endon(#"death");

  if(isDefined(e_ai.archetype)) {
    switch (e_ai.archetype) {
      case # "avogadro":
        var_1510a94a = # "hash_33e62839d84aaec7";
        var_e31a323c = # "hash_621285559daed3af";
        var_fd89f5fb = # "hash_123425d677b928fa";
        var_4ec57c29 = # "hash_729db72e5e196219";
        var_f6b3e5dd = # "hash_1d2437fd7fe38d19";
        var_6e38d21c = # "hash_39c41891747dabba";
        v_offset = (0, 0, 45);
        break;
      case # "zombie_dog":
        if(self.subarchetype === # "hash_2a5479b83161cb35") {
          var_1510a94a = # "hash_2991459f20df3789";
          var_e31a323c = # "hash_2daacd7b15881d1d";
          var_fd89f5fb = # "hash_16838de4eb2b7f00";
          var_4ec57c29 = # "hash_50a34ea4add0897";
          var_f6b3e5dd = # "hash_58176fa004d16f13";
          var_6e38d21c = # "hash_219cfeed2cbf8adc";
        } else {
          var_1510a94a = # "hash_30094147649a2ce8";
          var_e31a323c = # "hash_7e0d7ce34dcb51e8";
          var_fd89f5fb = # "hash_324d41aa84a6a925";
          var_4ec57c29 = # "hash_7650d07efcd13f86";
          var_f6b3e5dd = # "hash_6c87cdcb89dd8aa2";
          var_6e38d21c = # "hash_6e0e18e77c0f28c1";
        }

        v_offset = (20, 0, 30);
        break;
      default:
        return undefined;
    }

    return {
      #var_1510a94a: var_1510a94a, #var_e31a323c: var_e31a323c, #var_fd89f5fb: var_fd89f5fb, #var_4ec57c29: var_4ec57c29, #var_f6b3e5dd: var_f6b3e5dd, #var_6e38d21c: var_6e38d21c, #v_offset: v_offset
    };
  }

  return undefined;
}