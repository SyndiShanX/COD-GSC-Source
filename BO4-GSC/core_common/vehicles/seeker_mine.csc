/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\vehicles\seeker_mine.csc
************************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;

#namespace seeker_mine;

autoexec main() {
  clientfield::register("vehicle", "seeker_mine_fx", 1, 1, "int", &fxhandler, 0, 0);
  clientfield::register("vehicle", "seeker_mine_light_fx", 1, 1, "int", &lightfxhandler, 0, 0);
  ai::add_archetype_spawn_function("seeker_mine", &spawned);
}

spawned(localclientnum) {
  localplayer = function_5c10bd79(localclientnum);

  if(self.team === localplayer.team) {
    setsoundcontext("team", "ally");
  } else {
    setsoundcontext("team", "enemy");
  }

  self thread update_light(localclientnum);
}

private update_light(localclientnum) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  while(true) {
    self.light_fx = util::playFXOnTag(localclientnum, #"hash_69272c24309abc33", self, "tag_fx_front");

    if(isDefined(self.attacking) && self.attacking) {
      wait 0.25;
    } else {
      wait 1;
    }

    stopfx(localclientnum, self.light_fx);
  }
}

private fxhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self thread play_seeker_mine_fx(localclientnum);
    return;
  }

  self function_5aa8d239(localclientnum, self.fxloop);
}

play_seeker_mine_fx(localclientnum) {
  self endon(#"death");
  playSound(0, #"hash_153d2d19a99f3a29", self.origin);
  sound = self playLoopSound(#"hash_40039ac740a9f96e");
  self.fxloop = util::playFXOnTag(localclientnum, #"hash_180b04db9cd1ee12", self, "tag_body_animate");
  level thread function_cece47d2(localclientnum, self, self.fxloop);
}

function_cece47d2(localclientnum, entity, fx) {
  entity waittill(#"death");
  level function_5aa8d239(localclientnum, fx);
}

function_5aa8d239(localclientnum, fx) {
  if(isDefined(fx)) {
    stopfx(localclientnum, fx);
  }
}

private lightfxhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self.attacking = 1;
    return;
  }

  self.attacking = 0;
}