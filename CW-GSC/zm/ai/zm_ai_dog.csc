/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_dog.csc
***********************************************/

#using script_581877678e31274c;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zombie_dog_toxic_cloud;
#namespace zm_ai_dog;

function private autoexec __init__system__() {
  system::register(#"zm_ai_dog", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "ZombieDogVocals", 1, 2, "int", &zombiedogvocals, 0, 0);
  ai::add_archetype_spawn_function(#"zombie_dog", &function_3b0e8b8b);
}

function function_3b0e8b8b(localclientnum) {
  util::waittill_dobj(localclientnum);
}

function zombiedogvocals(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  self endon(#"death");

  if(isDefined(self.var_64e89a2f)) {
    self stoploopsound(self.var_64e89a2f);
  }

  if(wasdemojump) {
    switch (wasdemojump) {
      case 1:
        var_e5404960 = undefined;
        var_9c464736 = # "hash_50a34ea4add0897";
        break;
      case 2:
        var_e5404960 = # "hash_16838de4eb2b7f00";
        var_9c464736 = # "hash_219cfeed2cbf8adc";
        break;
    }

    if(isDefined(var_e5404960)) {
      self playSound(fieldname, var_e5404960, self.origin + (20, 0, 30));
    }

    self.var_35e2a4c0 = self playLoopSound(var_9c464736, 1.5, (20, 0, 30));
  }
}