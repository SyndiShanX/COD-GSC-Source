/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\zombie.csc
*************************************************/

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#namespace zombie;

function autoexec precache() {}

function autoexec main() {
  level._effect["zombie_special_day_effect"] = "zombie/fx_val_chest_burst";
  ai::add_archetype_spawn_function("zombie", & zombieclientutils::zombie_override_burn_fx);
  clientfield::register("actor", "zombie", 1, 1, "int", & zombieclientutils::zombiehandler, 0, 0);
  clientfield::register("actor", "zombie_special_day", 6001, 1, "counter", & zombieclientutils::zombiespecialdayeffectshandler, 0, 0);
}

#namespace zombieclientutils;

function zombiehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(isdefined(entity.archetype) && entity.archetype != "zombie") {
    return;
  }
  if(!isdefined(entity.initializedgibcallbacks) || !entity.initializedgibcallbacks) {
    entity.initializedgibcallbacks = 1;
    gibclientutils::addgibcallback(localclientnum, entity, 8, & _gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 16, & _gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 32, & _gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 128, & _gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 256, & _gibcallback);
  }
}

function private _gibcallback(localclientnum, entity, gibflag) {
  switch (gibflag) {
    case 8: {
      playsound(0, "zmb_zombie_head_gib", self.origin + vectorscale((0, 0, 1), 60));
      break;
    }
    case 16:
    case 32:
    case 128:
    case 256: {
      playsound(0, "zmb_death_gibs", self.origin + vectorscale((0, 0, 1), 30));
      break;
    }
  }
}

function zombiespecialdayeffectshandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(isdefined(entity.archetype) && entity.archetype != "zombie") {
    return;
  }
  origin = entity gettagorigin("j_spine4");
  fx = playfx(localclientnum, level._effect["zombie_special_day_effect"], origin);
  setfxignorepause(localclientnum, fx, 1);
}

function zombie_override_burn_fx(localclientnum) {
  if(sessionmodeiszombiesgame()) {
    if(!isdefined(self._effect)) {
      self._effect = [];
    }
    level._effect["fire_zombie_j_elbow_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop_optim";
    level._effect["fire_zombie_j_elbow_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop_optim";
    level._effect["fire_zombie_j_shoulder_le_loop"] = "fire/fx_fire_ai_human_arm_left_loop_optim";
    level._effect["fire_zombie_j_shoulder_ri_loop"] = "fire/fx_fire_ai_human_arm_right_loop_optim";
    level._effect["fire_zombie_j_spine4_loop"] = "fire/fx_fire_ai_human_torso_loop_optim";
    level._effect["fire_zombie_j_hip_le_loop"] = "fire/fx_fire_ai_human_hip_left_loop_optim";
    level._effect["fire_zombie_j_hip_ri_loop"] = "fire/fx_fire_ai_human_hip_right_loop_optim";
    level._effect["fire_zombie_j_knee_le_loop"] = "fire/fx_fire_ai_human_leg_left_loop_optim";
    level._effect["fire_zombie_j_knee_ri_loop"] = "fire/fx_fire_ai_human_leg_right_loop_optim";
    level._effect["fire_zombie_j_head_loop"] = "fire/fx_fire_ai_human_head_loop_optim";
  }
}