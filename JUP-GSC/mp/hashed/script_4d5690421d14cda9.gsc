/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4d5690421d14cda9.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_disciple\zombie_disciple;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_c5b413a1b2176fe3;

function function_fcbab070c240a397(params) {
  settings = function_cb7771bf461049eb(params);

  if(isDefined(settings)) {
    add_fx("disciple_lifedrain_beam_fx", settings.var_c164f56da4c8b950);
    add_fx("disciple_weakpoint_hand_impact_fx", settings.var_735914b3360cf610);
    add_fx("disciple_weakpoint_hand_fx", settings.var_7e21c2fc64b1a2da);
    add_fx("disciple_lifedrain_screen_fx", settings.var_495b2246709c1ebd);
    add_fx("disciple_lifedrain_kill_fx", settings.var_64673f9cba520069);
  }
}

function function_e763a1820edbfd28() {
  callback::get_template(self.animsetname) callback::add("on_zombie_ai_damaged", &function_4748556b6552da35);

  function_4aa1128bb0cf132();
}

function function_949f643edcd1aade() {
  self.var_1c5af6d8a6251895 = 0;
  self.var_e2b17292054656a1 = 0;
  self.var_c83e43db0823ce5b = 0;
  self.var_f4d4e9f86be4cff7 = self.zombieaisettings.var_e58a65b7a8f5973c.var_1de95697972bd8c7;
  self.var_65ed14e9b65ad777 = self.zombieaisettings.var_e58a65b7a8f5973c.var_23c1773c98bbea52;
  self.var_2fad7b72c8bdb9c0 = squared(self.zombieaisettings.var_e58a65b7a8f5973c.var_b97a4f96e35d62fc);
  self.var_19ae2683f843e4f7 = self.zombieaisettings.var_e58a65b7a8f5973c.var_b97a4f96e35d62fc;
  self.var_ae02110646a1f2a1 = self.zombieaisettings.var_e58a65b7a8f5973c.var_e881202df9147e0f;
  self.var_755361ac507c5e35 = self.zombieaisettings.var_e58a65b7a8f5973c.var_c11f84610a177815;
  self.var_20f084f8b6aa3446 = self.zombieaisettings.var_e58a65b7a8f5973c.var_6dafdc9373f06676 * 1000;
  self.var_c38b4e0e90ea1e91 = self.zombieaisettings.var_e58a65b7a8f5973c.var_6a5b8f242f11c38 * 1000;
  self.var_4a574e473630f0eb = self.zombieaisettings.var_e58a65b7a8f5973c.var_dda4d45d11713be;
  self.var_f3d93eb65ff33b13 = undefined;
  self.var_250a3847f129a62a = self.zombieaisettings.var_e58a65b7a8f5973c.var_efbd87396988298c;
  self.var_dc1fcd69caaa30a4 = self.zombieaisettings.var_e58a65b7a8f5973c.var_ba2601967ec76fdc * 1000;
  self.var_ef4b3691a1f11505 = self.zombieaisettings.var_e58a65b7a8f5973c.var_6f2acd144e3c3fca;
  thread function_1f54174f18b9d00b();
}

function private function_4748556b6552da35(params) {
  if(isDefined(self.var_a39609c30eeab15b)) {
    self.var_a39609c30eeab15b += params.idamage;
  }

  if(function_c91fafcbd1b5bd9e(params) || istrue(self.var_c124ffbc8c1883e7)) {
    self.var_1c5af6d8a6251895 += params.idamage;
    playFXOnTag(getfx("disciple_weakpoint_hand_impact_fx"), self, "tag_fx_hand_ri_palm");
    var_cb88d43b301fd7ec = 0;

    if(istrue(self.var_c124ffbc8c1883e7)) {
      var_798e48bd5092f22a = gettime() - self.var_c83e43db0823ce5b;

      if(var_798e48bd5092f22a <= self.var_dc1fcd69caaa30a4) {
        var_cb88d43b301fd7ec = 1;
      }
    }

    if(!istrue(self.var_8eea1c7b28ac77b5) && self.var_1c5af6d8a6251895 > self.var_f4d4e9f86be4cff7 * self.maxhealth && !var_cb88d43b301fd7ec) {
      self.var_c83e43db0823ce5b = gettime();
      self function_3e89eb3d8e3f1811("life_drain_cooldown", self.var_20f084f8b6aa3446 + gettime());
      self function_3e89eb3d8e3f1811("in_life_drain_pain", 1);
    }
  }
}

function private function_f1d567f9cfaf8638(params) {
  if(istrue(self.var_bc3dcc1a5359b3e5) && isDefined(params.body) && params.body tagexists("j_spine4")) {
    playFXOnTag(getfx("disciple_lifedrain_kill_fx"), params.body, "j_spine4");
  }
}

function private function_1f54174f18b9d00b() {
  self endon("death");

  while(true) {
    self waittill("life_drain_loop_start");
    ent_flag_set("playing_life_drain_anim");
    thread function_403d98066db9adbd();
    self waittill("life_drain_loop_end");
    ent_flag_clear("playing_life_drain_anim");
    self function_3e89eb3d8e3f1811("in_life_drain", 0);
  }
}

function private function_403d98066db9adbd() {
  level endon("game_ended");
  target_ent = self.enemy;

  if(isDefined(self.var_f3d93eb65ff33b13)) {
    target_ent = self.var_f3d93eb65ff33b13;
  }

  var_9820f6d5356de29 = istrue(self.var_c124ffbc8c1883e7) && isDefined(target_ent.team) && target_ent.team == self.team;

  if(!isDefined(target_ent) || istrue(target_ent.var_bc3dcc1a5359b3e5) || var_9820f6d5356de29) {
    self function_3e89eb3d8e3f1811("in_life_drain", 0);
    return;
  }

  target_ent.var_bc3dcc1a5359b3e5 = 1;
  self.var_a39609c30eeab15b = 0;
  self.var_1c5af6d8a6251895 = 0;
  scripts\common\metabone::function_7380ccd6f2c49392("hand", 1);
  playFXOnTag(getfx("disciple_weakpoint_hand_fx"), self, "tag_fx_hand_ri_palm");
  self setscriptablepartstate("drain_audio", "on");
  n_damage = 0;

  if(isPlayer(target_ent)) {
    playfxontagforclients(getfx("disciple_lifedrain_screen_fx"), target_ent, "j_head", target_ent);
    n_damage = self.var_65ed14e9b65ad777;
  } else if(isDefined(target_ent.maxhealth)) {
    target_ent callback::add("killed_body_cloned", &function_f1d567f9cfaf8638);

    if(is_equal(target_ent.type, "human") && isDefined(target_ent.subclass) && (issubstr(target_ent.subclass, "ob_specop") || issubstr(target_ent.subclass, "ob_tactician") || issubstr(target_ent.subclass, "ob_shielded") || issubstr(target_ent.subclass, "ob_warlord") || issubstr(target_ent.subclass, "ob_schematic_soldier_buddy"))) {
      n_damage = int(min(self.maxhealth * 0.025, target_ent.maxhealth * 0.025));
    } else if(isDefined(target_ent.aicategory) && (target_ent.aicategory == "special" || target_ent.aicategory == "elite")) {
      n_damage = int(min(max(self.maxhealth * 0.05, target_ent.maxhealth * 0.05), self.maxhealth));
    } else {
      n_damage = int(min(max(self.maxhealth * 0.2, target_ent.maxhealth * 0.2), self.maxhealth));
    }

    if(istrue(self.var_c124ffbc8c1883e7)) {
      n_damage *= self.var_250a3847f129a62a;
    }
  }

  var_6198758dd896c717 = utility::spawn_model("tag_origin", self gettagorigin("tag_fx_hand_ri_palm"));
  var_6198758dd896c717 linkTo(self, "tag_fx_hand_ri_palm");
  var_23ea96e3ee262480 = playfxontagsbetweenclients(getfx("disciple_lifedrain_beam_fx"), var_6198758dd896c717, "tag_origin", target_ent, "j_spine4");

  if(isDefined(var_23ea96e3ee262480)) {
    var_23ea96e3ee262480 forcenetfieldhighlod_sharedfunc(1);
  }

  n_frames = 0;
  min_duration = gettime() + 3000;
  max_duration = gettime() + 9000;

  while(isalive(self) && isalive(target_ent) && !istrue(target_ent.inlaststand)) {
    if(!istrue(self.var_4a574e473630f0eb) && (!isDefined(self.enemy) || self.enemy != target_ent)) {
      break;
    }

    dist_sq = distancesquared(target_ent.origin, self.origin);

    if(dist_sq > self.var_2fad7b72c8bdb9c0 && gettime() > min_duration) {
      break;
    }

    if(dist_sq > self.var_2fad7b72c8bdb9c0 * 3) {
      break;
    }

    if((!istrue(self.var_4a574e473630f0eb) || istrue(self.var_c124ffbc8c1883e7)) && target_ent.team == self.team) {
      break;
    }

    if(!istrue(self getaiblackboarddynamic("in_life_drain"))) {
      break;
    }

    if(!ray_trace_passed(self getcentroid(), target_ent getcentroid(), undefined, create_default_contents(1))) {
      break;
    }

    if(istrue(self.var_c124ffbc8c1883e7) && gettime() > max_duration) {
      break;
    }

    n_frames++;

    if(n_frames == 10) {
      var_7278dfba2b654bff = 1 - self.health / self.maxhealth;
      health_gained = self.var_ae02110646a1f2a1 * self.maxhealth * (1 + var_7278dfba2b654bff * self.zombieaisettings.var_e58a65b7a8f5973c.var_c11f84610a177815);
      health_gained += self.var_a39609c30eeab15b * self.zombieaisettings.var_e58a65b7a8f5973c.var_5f17af25ee7aca56;
      self.var_a39609c30eeab15b = 0;
      var_be9e2150d4979f71 = function_1499a812ecd5f3b6(self);
      health_gained = int(min(health_gained, max(var_be9e2150d4979f71 * self.maxhealth - self.health, 0)));
      self.health += health_gained;
      self.var_e2b17292054656a1 += health_gained;

      if(isagent(target_ent) && n_damage >= target_ent.health) {
        target_ent.do_immediate_ragdoll = 1;
      }

      target_ent dodamage(n_damage, target_ent.origin, self, self, "MOD_FIRE", undefined, "torso_upper");
      n_frames = 0;
    }

    wait 0.05;
  }

  var_6198758dd896c717 delete();
  var_23ea96e3ee262480 delete();

  if(isalive(self) && isDefined(self.var_a39609c30eeab15b)) {
    self.var_1c5af6d8a6251895 = 0;
    self.var_a39609c30eeab15b = undefined;
    self function_3e89eb3d8e3f1811("in_life_drain", 0);

    if(!istrue(self getaiblackboarddynamic("in_life_drain_pain"))) {
      self function_3e89eb3d8e3f1811("life_drain_cooldown", self.var_c38b4e0e90ea1e91 + gettime());
    }

    stopFXOnTag(getfx("disciple_weakpoint_hand_fx"), self, "tag_fx_hand_ri_palm");
    self setscriptablepartstate("drain_audio", "stop");
    scripts\common\metabone::function_7380ccd6f2c49392("hand", 0);
  }

  if(isDefined(target_ent)) {
    target_ent.var_bc3dcc1a5359b3e5 = undefined;

    if(isPlayer(target_ent)) {
      stopFXOnTag(getfx("disciple_lifedrain_screen_fx"), target_ent, "j_head");
      return;
    }

    target_ent callback::remove("killed_body_cloned", &function_f1d567f9cfaf8638);
  }
}

function function_860d329e4f5111ae(entity) {
  return istrue(entity getaiblackboarddynamic("in_life_drain"));
}

function function_c91fafcbd1b5bd9e(params) {
  return isDefined(params.metabonename) && params.metabonename == "hand";
}

function private function_4aa1128bb0cf132() {
  function_6e7290c8ee4f558b("<dev string:x1c>");
  function_a9a864379a098ad6("<dev string:x39>", "<dev string:x4d>", &function_2e23970d7f46208a);
  function_a9a864379a098ad6("<dev string:x61>", "<dev string:x75>", &function_dc591bebf0dce66d);
  function_fe953f000498048f();
}

function private function_2e23970d7f46208a() {
  disciple = function_6d1fbda4b8524ef2(level.players[0].origin, undefined, "<dev string:x89>");

  if(isDefined(disciple)) {
    disciple function_3e89eb3d8e3f1811("<dev string:x9c>", 1);
  }
}

function private function_dc591bebf0dce66d() {
  function_2fb888667001fc39("<dev string:xad>", @ "hash_5ea28fb57e748699");
}

function private function_ea2d00bafd61346e(text, pos) {
  if(getdvarint(@ "hash_5ea28fb57e748699", 0)) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:xca>" + text, (1, 0, 0));
  }
}

# /