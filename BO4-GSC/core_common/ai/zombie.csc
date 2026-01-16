/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie.csc
***********************************************/

#include scripts\core_common\ai\systems\fx_character;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;

#namespace zombie;

autoexec main() {
  level._effect[#"zombie_special_day_effect"] = #"hash_7a37324c1988abb5";
  ai::add_archetype_spawn_function(#"zombie", &zombieclientutils::zombie_override_burn_fx);
  ai::add_archetype_spawn_function(#"zombie", &zombieclientutils::zombiespawnsetup);
  clientfield::register("actor", "zombie", 1, 1, "int", &zombieclientutils::zombiehandler, 0, 0);
  clientfield::register("actor", "zombie_special_day", 1, 1, "counter", &zombieclientutils::zombiespecialdayeffectshandler, 0, 0);
}

#namespace zombieclientutils;

zombiehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;

  if(isDefined(entity.archetype) && entity.archetype != #"zombie") {
    return;
  }

  if(!isDefined(entity.initializedgibcallbacks) || !entity.initializedgibcallbacks) {
    entity.initializedgibcallbacks = 1;
    gibclientutils::addgibcallback(localclientnum, entity, 8, &_gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 16, &_gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 32, &_gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 128, &_gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 256, &_gibcallback);
  }
}

private _gibcallback(localclientnum, entity, gibflag) {
  switch (gibflag) {
    case 8:
      playSound(0, #"zmb_zombie_head_gib", self.origin + (0, 0, 60));
      break;
    case 16:
    case 32:
    case 128:
    case 256:
      playSound(0, #"zmb_death_gibs", self.origin + (0, 0, 30));
      break;
  }
}

zombiespecialdayeffectshandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;

  if(isDefined(entity.archetype) && entity.archetype != #"zombie") {
    return;
  }

  origin = entity gettagorigin("j_spine4");
  fx = playFX(localclientnum, level._effect[#"zombie_special_day_effect"], origin);
  setfxignorepause(localclientnum, fx, 1);
}

zombie_override_burn_fx(localclientnum) {
  if(sessionmodeiszombiesgame()) {
    if(!isDefined(self._effect)) {
      self._effect = [];
    }

    level._effect[#"fire_zombie_j_elbow_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level._effect[#"fire_zombie_j_elbow_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
    level._effect[#"fire_zombie_j_shoulder_le_loop"] = #"fire/fx_fire_ai_human_arm_left_loop";
    level._effect[#"fire_zombie_j_shoulder_ri_loop"] = #"fire/fx_fire_ai_human_arm_right_loop";
    level._effect[#"fire_zombie_j_spine4_loop"] = #"fire/fx_fire_ai_human_torso_loop";
    level._effect[#"fire_zombie_j_hip_le_loop"] = #"fire/fx_fire_ai_human_hip_left_loop";
    level._effect[#"fire_zombie_j_hip_ri_loop"] = #"fire/fx_fire_ai_human_hip_right_loop";
    level._effect[#"fire_zombie_j_knee_le_loop"] = #"fire/fx_fire_ai_human_leg_left_loop";
    level._effect[#"fire_zombie_j_knee_ri_loop"] = #"fire/fx_fire_ai_human_leg_right_loop";
    level._effect[#"fire_zombie_j_head_loop"] = #"fire/fx_fire_ai_human_head_loop";
  }
}

zombiespawnsetup(localclientnum) {
  fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}