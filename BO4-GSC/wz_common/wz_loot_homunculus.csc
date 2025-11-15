/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_loot_homunculus.csc
***********************************************/

#namespace wz_loot_homunculus;

event_handler[event_9673dc9a] function_3981d015(eventstruct) {
  dynent = eventstruct.ent;

  if(isDefined(dynent)) {
    if(dynent.targetname === "spring_event_homunculus" || dynent.targetname === "zombie_apoc_homunculus") {
      localclientnum = eventstruct.localclientnum;

      if(isDefined(localclientnum)) {
        if(eventstruct.state === 1) {
          level thread function_5aaf5515(localclientnum, dynent);
          return;
        }

        if(eventstruct.state === 3) {
          if(dynent.targetname == "spring_event_homunculus") {
            playFX(localclientnum, "player/fx8_plyr_emote_homunc_green_end", dynent.origin + (0, 0, 40), anglesToForward(dynent.angles));
          } else if(dynent.targetname == "zombie_apoc_homunculus") {
            playFX(localclientnum, "player/fx8_plyr_emote_homunc_end", dynent.origin + (0, 0, 40), anglesToForward(dynent.angles));
          }

          if(isDefined(dynent.var_46e47933)) {
            stopsound(dynent.var_46e47933);
          }
        }
      }
    }
  }
}

function_5aaf5515(localclientnum, dynent) {
  dynent notify(#"hash_178cf342d49af85f");
  dynent endon(#"hash_178cf342d49af85f");

  while(isDefined(dynent)&function_8a8a409b(dynent) && function_ffdbe8c2(dynent) !== 2) {
    dynent.var_46e47933 = playSound(localclientnum, "mus_homunculus_dance", dynent.origin);
    wait 7.5;
  }
}