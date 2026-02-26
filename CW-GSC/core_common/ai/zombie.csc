/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\throttle_shared;
#using scripts\core_common\util_shared;
#namespace zombie;

function autoexec main() {
  ai::add_archetype_spawn_function(#"zombie", &zombieclientutils::zombie_override_burn_fx);
  ai::add_archetype_spawn_function(#"zombie", &zombieclientutils::zombiespawnsetup);
  clientfield::register("actor", "zombie", 1, 1, "int", &zombieclientutils::zombiehandler, 0, 0);
  clientfield::register("actor", "pustule_pulse_cf", 1, 2, "int", &zombieclientutils::function_a17af3df, 0, 0);
  clientfield::register("actor", "stunned_head_fx", 1, 1, "int", &zombieclientutils::function_d2f27d26, 0, 0);
}

#namespace zombieclientutils;

function zombiehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;

  if(isDefined(entity.archetype) && entity.archetype != # "zombie") {
    return;
  }

  if(!isDefined(entity.initializedgibcallbacks) || !entity.initializedgibcallbacks) {
    entity.initializedgibcallbacks = 1;
    gibclientutils::addgibcallback(wasdemojump, entity, 8, &_gibcallback);
    gibclientutils::addgibcallback(wasdemojump, entity, 16, &_gibcallback);
    gibclientutils::addgibcallback(wasdemojump, entity, 32, &_gibcallback);
    gibclientutils::addgibcallback(wasdemojump, entity, 128, &_gibcallback);
    gibclientutils::addgibcallback(wasdemojump, entity, 256, &_gibcallback);
  }
}

function private _gibcallback(localclientnum, entity, gibflag) {
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

function zombie_override_burn_fx(localclientnum) {
  if(sessionmodeiszombiesgame()) {
    if(!isDefined(self._effect)) {
      self._effect = [];
    }

    level._effect[#"fire_zombie_j_elbow_le_loop"] = # "fire/fx_fire_ai_human_arm_left_loop";
    level._effect[#"fire_zombie_j_elbow_ri_loop"] = # "fire/fx_fire_ai_human_arm_right_loop";
    level._effect[#"fire_zombie_j_shoulder_le_loop"] = # "fire/fx_fire_ai_human_arm_left_loop";
    level._effect[#"fire_zombie_j_shoulder_ri_loop"] = # "fire/fx_fire_ai_human_arm_right_loop";
    level._effect[#"fire_zombie_j_spine4_loop"] = # "fire/fx_fire_ai_human_torso_loop";
    level._effect[#"fire_zombie_j_hip_le_loop"] = # "fire/fx_fire_ai_human_hip_left_loop";
    level._effect[#"fire_zombie_j_hip_ri_loop"] = # "fire/fx_fire_ai_human_hip_right_loop";
    level._effect[#"fire_zombie_j_knee_le_loop"] = # "fire/fx_fire_ai_human_leg_left_loop";
    level._effect[#"fire_zombie_j_knee_ri_loop"] = # "fire/fx_fire_ai_human_leg_right_loop";
    level._effect[#"fire_zombie_j_head_loop"] = # "fire/fx_fire_ai_human_head_loop";
  }
}

function function_a846c43c(ai) {
  if(!isDefined(ai)) {
    return;
  }

  function_9a725f16(ai.torsodmg1);
  function_9a725f16(ai.torsodmg2);
  function_9a725f16(ai.torsodmg3);
  function_9a725f16(ai.torsodmg4);
  function_9a725f16(ai.torsodmg5);
  function_9a725f16(ai.legdmg1);
  function_9a725f16(ai.legdmg2);
  function_9a725f16(ai.legdmg3);
  function_9a725f16(ai.legdmg4);
}

function function_55aaf3b(ai) {
  if(!isDefined(ai)) {
    return;
  }

  function_2e973803(ai.torsodmg1);
  function_2e973803(ai.torsodmg2);
  function_2e973803(ai.torsodmg3);
  function_2e973803(ai.torsodmg4);
  function_2e973803(ai.torsodmg5);
  function_2e973803(ai.legdmg1);
  function_2e973803(ai.legdmg2);
  function_2e973803(ai.legdmg3);
  function_2e973803(ai.legdmg4);
}

function function_9a725f16(model) {
  if(isDefined(model)) {
    if(!isDefined(level.var_dfb95520)) {
      level.var_dfb95520 = [];
    }

    if(!isDefined(level.var_dfb95520[model])) {
      level.var_dfb95520[model] = 0;
    }

    if(level.var_dfb95520[model] < 1) {
      forcestreamxmodel(model, 1);
      forcestreamxmodel(model, 2);
    }

    level.var_dfb95520[model]++;
  }
}

function function_2e973803(model) {
  if(!isDefined(level.var_dfb95520)) {
    level.var_dfb95520 = [];
  }

  if(isDefined(model) && isDefined(level.var_dfb95520[model])) {
    if(level.var_dfb95520[model] > 0) {
      level.var_dfb95520[model]--;

      if(level.var_dfb95520[model] < 1) {
        stopforcestreamingxmodel(model);
      }
    }
  }
}

function function_fd2b858e(localclientnum) {
  if(!isDefined(level.var_49883c7)) {
    level.var_49883c7 = new class_c6c0e94();
    [[level.var_49883c7]] - > initialize(#"hash_6c088d467fef5b7f", 2, 0.1);
  }

  self endon(#"death");
  self.var_e22ea2fc = 0;
  self callback::on_shutdown(&function_a0a0fbea);

  while(true) {
    waitframe(1);
    [[level.var_49883c7]] - > waitinqueue(self);
    localclient = function_5c10bd79(localclientnum);

    if(isDefined(localclient) && gibclientutils::isundamaged(localclientnum, self) && distancesquared(localclient.origin, self.origin) < sqr(700) && vectordot(anglesToForward(localclient.angles), self.origin - localclient.origin) > 0) {
      if(!self.var_e22ea2fc) {
        self.var_e22ea2fc = 1;
        function_a846c43c(self);
      }

      continue;
    }

    if(self.var_e22ea2fc) {
      self.var_e22ea2fc = 0;
      function_55aaf3b(self);

      if(!gibclientutils::isundamaged(localclientnum, self)) {
        break;
      }
    }
  }
}

function function_a0a0fbea(localclientnum) {
  if(is_true(self.var_e22ea2fc)) {
    self.var_e22ea2fc = 0;
    function_55aaf3b(self);
  }
}

function zombiespawnsetup(localclientnum) {
  fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

function function_a17af3df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump === 1) {
    var_1690db4a = [#"c_t9_zmb_ndu_zombie_shirtless2", #"hash_16837b6c9b7a1881", #"hash_50fdc172aee097e6", #"hash_ef041655f01ad34", #"hash_502c60e0a94ba04b"];
    self stoprenderoverridebundle(#"hash_61ce0b7cea532e77");

    if(self.model === # "c_t9_zmb_zombie_light_body2") {
      self playrenderoverridebundle(#"hash_882e5d8c59f40a3");
      self callback::on_shutdown(&function_c88acbea);
    } else if(isDefined(self.model) && isinarray(var_1690db4a, self.model)) {
      self playrenderoverridebundle(#"hash_5597c38c16f1dbe9");
      self callback::on_shutdown(&function_c88acbea);
    }

    return;
  }

  if(bwastimejump === 2) {
    function_c88acbea(fieldname);
    self playrenderoverridebundle(#"hash_61ce0b7cea532e77");
    return;
  }

  function_c88acbea(fieldname);
  self stoprenderoverridebundle(#"hash_61ce0b7cea532e77");
}

function function_c88acbea(localclientnum) {
  if(!clienthassnapshot(localclientnum)) {
    return;
  }

  if(self.model === # "c_t9_zmb_zombie_light_body2") {
    self stoprenderoverridebundle(#"hash_882e5d8c59f40a3");
    return;
  }

  if(self.model === # "c_t9_zmb_ndu_zombie_shirtless2" || self.model === # "hash_16837b6c9b7a1881") {
    self stoprenderoverridebundle(#"hash_5597c38c16f1dbe9");
  }
}

function function_d2f27d26(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump && self haspart(fieldname, "j_head")) {
    self.stunned_head_fx = function_239993de(fieldname, #"hash_24c6a9d87972dbc5", self, "j_head");
    return;
  }

  if(isDefined(self.stunned_head_fx)) {
    stopfx(fieldname, self.stunned_head_fx);
    self.stunned_head_fx = undefined;
  }
}