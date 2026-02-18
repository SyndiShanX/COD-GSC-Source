/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6d9a320bbc1fee93.csc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\util_shared;
#namespace namespace_2e61cc4b;

function init() {
  function_cae618b4("spawner_zombietron_elephant");
  ai::add_archetype_spawn_function(#"elephant", &function_4c731a08);
  clientfield::register("actor", "towers_boss_melee_effect", 1, 1, "counter", &function_4d07056d, 0, 0);
  clientfield::register("actor", "tower_boss_death_fx", 1, 1, "counter", &function_58e13aab, 0, 0);
  clientfield::register("scriptmover", "entrails_model_cf", 1, 1, "int", &function_e3038292, 0, 0);
  clientfield::register("scriptmover", "towers_boss_head_proj_fx_cf", 1, 1, "int", &function_5f5f6a25, 0, 0);
  clientfield::register("scriptmover", "towers_boss_head_proj_explosion_fx_cf", 1, 1, "int", &function_1308296f, 0, 0);
  clientfield::register("actor", "towers_boss_eye_fx_cf", 1, 2, "int", &function_624041b1, 0, 0);
  clientfield::register("actor", "boss_death_rob", 1, 2, "int", &function_e1fb79d0, 0, 0);
  footsteps::registeraitypefootstepcb(#"elephant", &function_fe0bb012);
}

function private function_4c731a08(localclientnum) {
  self playrenderoverridebundle("rob_zm_eyes_red");
}

function function_624041b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self.eyefx = util::playFXOnTag(fieldname, "maps/zm_towers/fx8_boss_eye_glow", self, "tag_eye");
    return;
  }

  if(bwastimejump == 2) {
    self.eyefx = util::playFXOnTag(fieldname, "maps/zm_towers/fx8_boss_eye_glow_alt", self, "tag_eye");
    return;
  }

  if(isDefined(self.eyefx)) {
    stopfx(fieldname, self.eyefx);
  }
}

function function_e1fb79d0(var_99c2529a, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self stoprenderoverridebundle("rob_zm_eyes_red");
    self playrenderoverridebundle(#"hash_782edffb9e72130");
    return;
  }

  self stoprenderoverridebundle(#"hash_782edffb9e72130");
}

function function_e3038292(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!util::is_mature() || util::is_gib_restricted_build()) {
      self hide();
    }
  }
}

function function_5f5f6a25(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.fx = util::playFXOnTag(fieldname, "maps/zm_towers/fx8_boss_attack_eye_trail", self, "tag_origin");
    return;
  }

  if(isDefined(self.fx)) {
    stopfx(fieldname, self.fx);
  }
}

function function_1308296f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.fx = util::playFXOnTag(fieldname, "maps/zm_towers/fx8_boss_attack_eye_trail_split", self, "tag_origin");
    return;
  }

  if(isDefined(self.fx)) {
    stopfx(fieldname, self.fx);
  }
}

function function_4d07056d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(bwastimejump);

  if(!isDefined(e_player)) {
    return;
  }

  var_e08888ec = self gettagorigin("j_nose4");

  if(!isDefined(var_e08888ec)) {
    return;
  }

  n_dist = distancesquared(var_e08888ec, e_player.origin);
  var_b12c8a00 = sqr(1400);
  n_scale = (var_b12c8a00 - n_dist) / var_b12c8a00;

  if(n_scale > 0.01) {
    earthquake(bwastimejump, n_scale, 1, self.origin, n_dist);

    if(n_scale <= 0.25 && n_scale > 0.2) {
      function_36e4ebd4(bwastimejump, "tank_fire");
    } else {
      function_36e4ebd4(bwastimejump, "damage_heavy");
    }

    physicsexplosionsphere(bwastimejump, self.origin, 400, 100, 20);
  }
}

function function_58e13aab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(bwastimejump);
  earthquake(bwastimejump, 0.6, 1, self.origin, 4000);
  function_36e4ebd4(bwastimejump, "tank_fire");
  physicsexplosionsphere(bwastimejump, self.origin, 2000, 100, 4);
}

function function_fe0bb012(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(surface);
  n_dist = distancesquared(notetrack, e_player.origin);
  var_b12c8a00 = sqr(1200);

  if(n_dist < var_b12c8a00) {
    earthquake(surface, 0.1, 0.5, self.origin, n_dist);
    function_36e4ebd4(surface, "damage_light");

    if(isDefined(bone)) {
      origin = self gettagorigin(bone);

      if(isDefined(origin)) {
        physicsexplosionsphere(surface, origin, 200, 20, 20);
      }
    }
  }
}