/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5c69ef91bd5f2dbf.csc
***********************************************/

#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\beam_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_361e505d;

function private autoexec __init__system__() {
  system::register(#"hash_7776caebba9c5d5a", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!isarchetypeloaded(#"abom")) {
    return;
  }

  ai::add_archetype_spawn_function(#"abom", &function_72989645);
  clientfield::register("scriptmover", "abomLaunchBeamCF", 17000, 1, "int", &function_a53f1f75, 0, 0);
  clientfield::register("scriptmover", "abomRegisterBeamTargetCF", 17000, 1, "int", &function_ac1157a, 0, 0);
  clientfield::register("actor", "abomBeamDissolveCF", 17000, 1, "int", &function_7d380ea9, 0, 0);
  clientfield::register("actor", "abomHeadDestroyCF", 17000, 2, "int", &function_90746702, 0, 0);
  clientfield::register("actor", "abomHeadWeakpointLeCF", 17000, 1, "int", &function_757801a6, 0, 0);
  clientfield::register("actor", "abomHeadWeakpointMidCF", 17000, 1, "int", &function_9b9a5f77, 0, 0);
  clientfield::register("actor", "abomHeadWeakpointRiCF", 17000, 1, "int", &function_94de7e4, 0, 0);
  clientfield::register("actor", "abomRoarCF", 17000, 1, "int", &function_3a01e8d7, 0, 0);
  clientfield::register("actor", "abomMovingCF", 17000, 1, "int", &function_d96bc835, 0, 0);
  clientfield::register("actor", "abomDissolveCF", 17000, 2, "int", &function_9dd3c047, 0, 0);
  clientfield::register("toplayer", "abomBullChargeHitPlayerCF", 17000, 1, "int", &function_92095d05, 0, 0);
  clientfield::register("allplayers", "abomBiteHitPlayerCF", 17000, 1, "counter", &function_5d8c2808, 0, 0);
  callback::add_callback(#"on_localclient_connect", &function_b8d317ee);
  function_a81ae2c5("j_elbow_le", #"hash_317d0ad977ed5617", #"hash_50a2f7600ff8a310");
  function_a81ae2c5("j_elbow_ri", #"hash_4558fcb92b7a6f88", #"hash_12f733da635077e5");
  function_a81ae2c5("tag_fx_head_center_throat", #"hash_7f805e6013fe49cc", #"hash_10764a341e1ffecb");
  function_a81ae2c5("tag_fx_head_le_throat", #"hash_7f805e6013fe49cc", #"hash_10764a341e1ffecb");
  function_a81ae2c5("tag_fx_head_ri_throat", #"hash_7f805e6013fe49cc", #"hash_10764a341e1ffecb");
  function_a81ae2c5("j_shoulder_le", #"hash_326c5fc869f7ea72", #"hash_463d5903725c98db");
  function_a81ae2c5("j_shoulder_ri", #"hash_29bb3f674fd243bf", #"hash_e4941ccd3da08a4");
  function_a81ae2c5("j_tail_01", #"hash_20f232c431541ed4", #"hash_808bdceec6ba1fb");
  function_a81ae2c5("j_tail_03", #"hash_1db5415f8e8fee59", #"hash_66728c88e8a6183e");
  function_a81ae2c5("j_tail_05", #"hash_47b960686fdbbbc3", #"hash_7b072dc5c921b356");
  function_a81ae2c5("j_tentacle_back_le_01", #"hash_1899c5bdcbb01d19", #"hash_60d2bb892bffc718");
  function_a81ae2c5("j_tentacle_back_ri_01", #"hash_194a551e3a46258c", #"hash_75343983e8b876e5");
  function_a81ae2c5("j_tentacle_front_le_01", #"hash_1899c5bdcbb01d19", #"hash_60d2bb892bffc718");
  function_a81ae2c5("j_tentacle_front_ri_01", #"hash_194a551e3a46258c", #"hash_75343983e8b876e5");
  function_a81ae2c5("j_tentacle_mid1_le_01", #"hash_1899c5bdcbb01d19", #"hash_60d2bb892bffc718");
  function_a81ae2c5("j_tentacle_mid1_ri_01", #"hash_194a551e3a46258c", #"hash_75343983e8b876e5");
  function_a81ae2c5("j_tentacle_mid2_le_01", #"hash_1899c5bdcbb01d19", #"hash_60d2bb892bffc718");
  function_a81ae2c5("j_tentacle_mid2_ri_01", #"hash_194a551e3a46258c", #"hash_75343983e8b876e5");
  function_a81ae2c5("j_spine4", #"hash_3f63c9b302161e31", #"hash_56f4376b6b7ee4ec");
  function_a81ae2c5("j_spinelower", #"hash_122de04fcd4f1a9e", #"hash_7c40eac289b5365b");
}

function private function_a81ae2c5(tag, spawn_fx, death_fx) {
  if(!isDefined(level.var_cfc8a231)) {
    level.var_cfc8a231 = [];
  }

  fx = {
    #tag: tag, #spawn_fx: spawn_fx, #death_fx: death_fx
  };

  if(!isDefined(level.var_cfc8a231)) {
    level.var_cfc8a231 = [];
  } else if(!isarray(level.var_cfc8a231)) {
    level.var_cfc8a231 = array(level.var_cfc8a231);
  }

  level.var_cfc8a231[level.var_cfc8a231.size] = fx;
}

function private function_17ae1df1(entity, head_index) {
  return !is_true(entity.var_97748a3c[head_index]);
}

function function_a53f1f75(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  e_player = function_5c10bd79(fieldname);

  if(!isDefined(e_player.var_2788ca7e)) {
    e_player.var_2788ca7e = [];
  }

  if(bwastimejump === 1) {
    ai = undefined;

    if(isDefined(self.ai_owner)) {
      ai = self.ai_owner;
    }

    var_6676e4e3 = function_17ae1df1(ai, 0) ? 0 : function_17ae1df1(ai, 1) ? 1 : 2;

    if(isDefined(ai)) {
      for(head_index = 0; head_index < 3; head_index++) {
        if(!is_true(ai.var_97748a3c[head_index])) {
          var_db79f73d = head_index === var_6676e4e3;
          beam = var_db79f73d ? "beam9_zm_abom_electrical_target_fx" : "beam9_zm_abom_electrical";
          self.var_dd5aa0f5[head_index] = beam::launch(ai, ai.var_bdde582a[head_index], self, "tag_origin", beam);
        }
      }

      if(!isinarray(e_player.var_2788ca7e, ai)) {
        e_player.var_2788ca7e[e_player.var_2788ca7e.size] = ai;
      }

      e_player thread abom_beam_rumble(fieldname);
    }

    return;
  }

  for(head_index = 0; head_index < 3; head_index++) {
    if(isDefined(self.var_dd5aa0f5[head_index]) && self.var_dd5aa0f5[head_index] > 0) {
      beam::function_47deed80(fieldname, self.var_dd5aa0f5[head_index], self);
      self.var_dd5aa0f5[head_index] = -1;
    }
  }

  function_1eaaceab(e_player.var_2788ca7e);
  ai = undefined;

  if(isDefined(self.ai_owner)) {
    ai = self.ai_owner;
  }

  if(isDefined(ai) && isinarray(e_player.var_2788ca7e, ai)) {
    arrayremovevalue(e_player.var_2788ca7e, ai);
  }
}

function function_ac1157a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump === 1) {
    linked_ent = self getlinkedent();

    if(isDefined(linked_ent) && linked_ent isai()) {
      self.ai_owner = linked_ent;
      linked_ent.var_de6c5ff9 = self;
    }
  }
}

function function_72989645(localclientnum) {
  self callback::add_entity_callback(#"death", &function_5f1702e3);
  self.weakpoint_fx = [];
  self.var_3cb6f7b8 = [0, 0, 0];
  self.var_97748a3c = [0, 0, 0];
  self.var_c60ed8ce = [-1, -1, -1];
  self.var_bdde582a = ["tag_fx_head_le_throat", "tag_fx_head_center_throat", "tag_fx_head_ri_throat"];
  self.var_dd5aa0f5 = [-1, -1, -1];
  self.var_a2a062e1 = &function_369b5617;
  level._footstepcbfuncs[self.archetype] = &function_9f15588;
  self playSound(0, #"hash_3dcd119a8a1fbd51");
}

function function_9f15588(localclientnum, pos, surface, notetrack, bone) {
  a_players = getlocalplayers();

  for(i = 0; i < a_players.size; i++) {
    if(abs(self.origin[2] - a_players[i].origin[2]) < 128) {
      var_ed2e93e5 = a_players[i] getlocalclientnumber();

      if(isDefined(var_ed2e93e5)) {
        earthquake(var_ed2e93e5, 0.22, 0.1, self.origin, 1000);
        playrumbleonposition(var_ed2e93e5, "zm_abom_footsteps", self.origin);
      }
    }
  }
}

function function_5f1702e3(params) {
  for(i = 0; i < 3; i++) {
    if(isDefined(self.weakpoint_fx[i])) {
      stopfx(params.localclientnum, self.weakpoint_fx[i]);
    }
  }
}

function function_369b5617(entity, tag_index) {
  return is_true(entity.var_3cb6f7b8[tag_index]);
}

function private function_b8d317ee(localclientnum) {
  wait 3;
  actor_array = getentarraybytype(localclientnum, 15);

  foreach(actor in actor_array) {
    if(isDefined(actor) && actor.archetype === # "abom") {
      actor thread function_3c79fe29(localclientnum, actor);
      actor flag::set(#"hash_1bf32d70c3d977f6");
    }
  }

  wait 3;
  actor_array = getentarraybytype(localclientnum, 15);

  foreach(actor in actor_array) {
    if(isDefined(actor) && actor.archetype === # "abom" && actor flag::get(#"hash_1bf32d70c3d977f6")) {
      actor thread function_3c79fe29(localclientnum, actor);
    }
  }
}

function private function_3c79fe29(localclientnum, entity) {
  entity endon(#"death");
  entity function_9dd3c047(localclientnum, undefined, 1);
  wait 1;
  entity function_9dd3c047(localclientnum, undefined, 0);
}

function function_9dd3c047(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.var_c60ed8ce)) {
    self.var_c60ed8ce = [];
  }

  if(bwastimejump == 1) {
    if(isDefined(self.var_678bc6e2)) {
      self stoprenderoverridebundle(self.var_678bc6e2);
    }

    self.var_678bc6e2 = # "hash_6ca42734951d5ff2";
    self playrenderoverridebundle(#"hash_6ca42734951d5ff2");
    self fxclientutils::stopfxbundle(fieldname, self, self.fxdef);

    for(head_index = 0; head_index < 3; head_index++) {
      if(isDefined(self.var_c60ed8ce[head_index]) && self.var_c60ed8ce[head_index] >= 0) {
        stopfx(fieldname, self.var_c60ed8ce[head_index]);
        self.var_c60ed8ce[head_index] = -1;
      }
    }

    self thread function_27767c7e(fieldname, #"hash_2f938e7f87c1971");
    function_187b10a5(fieldname, 1);
    return;
  }

  if(bwastimejump == 2) {
    if(isDefined(self.var_678bc6e2)) {
      self stoprenderoverridebundle(self.var_678bc6e2);
    }

    self playrenderoverridebundle(#"hash_7da0355cbf3ae01f");
    self stoprenderoverridebundle(#"hash_7da0355cbf3ae01f");
    self thread function_27767c7e(fieldname, #"hash_14a734dce3c8f778");
    function_187b10a5(fieldname, 0);
    self thread function_bfde165(fieldname, self);
    return;
  }

  self fxclientutils::playfxbundle(fieldname, self, self.fxdef);

  for(head_index = 0; head_index < 3; head_index++) {
    if(is_true(self.var_97748a3c[head_index]) && (!isDefined(self.var_c60ed8ce[head_index]) || self.var_c60ed8ce[head_index] < 0)) {
      self.var_c60ed8ce[head_index] = util::playFXOnTag(fieldname, #"hash_385c7bfa3c9896a1", self, self.var_bdde582a[head_index]);
    }
  }

  function_c9eb529a(fieldname);
}

function private function_bfde165(localclientnum, entity) {
  for(var_a72838ba = 0; var_a72838ba < 20; var_a72838ba++) {
    if(isDefined(entity) && entity isragdoll()) {
      function_c9eb529a(localclientnum);
      util::playFXOnTag(localclientnum, #"hash_2b73237bc2e29da0", entity, "j_spine4");
      break;
    }

    waitframe(1);
  }

  if(isDefined(entity) && entity isragdoll()) {
    entity hide();
  }
}

function private function_187b10a5(localclientnum, var_c7821f8) {
  assert(isDefined(level.var_cfc8a231), "<dev string:x38>");

  if(!isDefined(level.var_f9fd59d1)) {
    level.var_f9fd59d1 = [];
  }

  foreach(fx_struct in level.var_cfc8a231) {
    if(fx_struct.tag === "j_head") {
      if(is_true(self.var_97748a3c[1])) {
        return;
      }
    }

    if(fx_struct.tag === "j_head_le") {
      if(is_true(self.var_97748a3c[0])) {
        return;
      }
    }

    if(fx_struct.tag === "j_head_ri") {
      if(is_true(self.var_97748a3c[2])) {
        return;
      }
    }

    fx = is_true(var_c7821f8) ? fx_struct.spawn_fx : fx_struct.death_fx;
    level.var_f9fd59d1[level.var_f9fd59d1.size] = util::playFXOnTag(localclientnum, fx, self, fx_struct.tag);
  }
}

function private function_c9eb529a(localclientnum) {
  if(isDefined(level.var_f9fd59d1)) {
    foreach(handle in level.var_f9fd59d1) {
      stopfx(localclientnum, handle);
    }
  }

  level.var_f9fd59d1 = [];
}

function function_27767c7e(localclientnum, str_alias) {
  self endon(#"death");
  wait 0.1;
  self playSound(localclientnum, str_alias);
}

function private heads_remaining(entity) {
  return (self.var_97748a3c[0] ? 0 : 1) + (self.var_97748a3c[1] ? 0 : 1) + (self.var_97748a3c[2] ? 0 : 1);
}

function function_90746702(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(isDefined(self.weakpoint_fx[bwastimejump - 1])) {
      stopfx(fieldname, self.weakpoint_fx[bwastimejump - 1]);
      self.weakpoint_fx[bwastimejump - 1] = undefined;
    }

    if(isDefined(self.var_dd5aa0f5[bwastimejump - 1]) && self.var_dd5aa0f5[bwastimejump - 1] > 0) {
      beam::function_47deed80(fieldname, self.var_dd5aa0f5[bwastimejump - 1]);
    }

    self.var_dd5aa0f5[bwastimejump - 1] = -1;

    if(isDefined(self.var_bdde582a[bwastimejump - 1])) {
      util::playFXOnTag(fieldname, #"hash_223877a5316fae8c", self, self.var_bdde582a[bwastimejump - 1]);

      if(heads_remaining(self) > 1 && isalive(self)) {
        self.var_c60ed8ce[bwastimejump - 1] = util::playFXOnTag(fieldname, #"hash_385c7bfa3c9896a1", self, self.var_bdde582a[bwastimejump - 1]);
        util::playFXOnTag(fieldname, #"hash_1fe737f1be448a00", self, self.var_bdde582a[bwastimejump - 1]);
      }

      self.var_97748a3c[bwastimejump - 1] = 1;
    }
  }
}

function function_7d380ea9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_da783696)) {
    self function_f6e99a8d(self.var_da783696);
    self.var_da783696 = undefined;
  }

  if(isDefined(self.var_12b59dee)) {
    self function_f6e99a8d(self.var_12b59dee, "j_head");
    self.var_12b59dee = undefined;
  }

  var_a04a4858 = [# "hash_726534103985846c"];

  if(bwastimejump && bwastimejump < var_a04a4858.size + 1) {
    self.var_da783696 = var_a04a4858[bwastimejump - 1];
    self playrenderoverridebundle(self.var_da783696);
  }
}

function function_92095d05(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self playrumbleonentity(fieldname, "damage_heavy");

    if(self postfx::function_556665f2("pstfx_slowed")) {
      self postfx::stoppostfxbundle("pstfx_slowed");
    }

    self postfx::playpostfxbundle("pstfx_slowed");
    self postfx::function_c8b5f318("pstfx_slowed", "Blur", 0.02);
    return;
  }

  self postfx::exitpostfxbundle("pstfx_slowed");
}

function function_5d8c2808(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self util::playFXOnTag(fieldname, #"hash_6f5da01a9887d160", self, "j_spine4");
  }
}

function function_757801a6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);
  function_8cddfdf6(fieldname, bwasdemojump, 0, "tag_fx_head_le_throat", #"hash_6e6c4d24ebf7f73c", #"hash_62a1a153307fb3ff");
}

function function_9b9a5f77(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);
  function_8cddfdf6(fieldname, bwasdemojump, 1, "tag_fx_head_center_throat", #"hash_73986354896a78ef", #"hash_2c639591caf1074c");
}

function function_94de7e4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self endon(#"death");
  self util::waittill_dobj(fieldname);
  function_8cddfdf6(fieldname, bwasdemojump, 2, "tag_fx_head_ri_throat", #"hash_28ba8b5ddd8c7a8a", #"hash_5fb010b599c470a5");
}

function private function_8cddfdf6(localclientnum, enable, head, tag, anim, var_b8377082) {
  if(enable) {
    if(isDefined(self.weakpoint_fx[head])) {
      stopfx(localclientnum, self.weakpoint_fx[head]);
      self.weakpoint_fx[head] = undefined;
    }

    if(self.aitype === # "hash_469e4baceeaf38f5") {
      self.weakpoint_fx[head] = util::playFXOnTag(localclientnum, #"zm_ai/fx9_abom_gulp_crystal_ambient", self, tag);
    } else {
      self.weakpoint_fx[head] = util::playFXOnTag(localclientnum, #"hash_5b5c7c5ca0112aef", self, tag);
    }

    self.var_3cb6f7b8[head] = 1;
    function_799e56b5(self, head);

    if(!flag::get(#"hash_2cde7566171da1e9")) {
      self setanim(anim, 1, 0.2, 1);

      if(!isDefined(self.var_294b91b9)) {
        self.var_294b91b9 = [];
      }

      self.var_294b91b9[head] = anim;
    }

    return;
  }

  if(isDefined(self.weakpoint_fx[head])) {
    stopfx(localclientnum, self.weakpoint_fx[head]);
    self.weakpoint_fx[head] = undefined;
  }

  self.var_3cb6f7b8[head] = 0;
  function_799e56b5(self, head);
  self setanim(var_b8377082, 1, 0.2, 1);

  if(!isDefined(self.var_294b91b9)) {
    self.var_294b91b9 = [];
  }

  self.var_294b91b9[head] = var_b8377082;
}

function private function_799e56b5(entity, head_index) {
  if(isDefined(entity.var_294b91b9[head_index])) {
    entity clearanim(entity.var_294b91b9[head_index], 0.2);
    entity.var_294b91b9[head_index] = undefined;
  }
}

function function_3a01e8d7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  e_player = function_5c10bd79(fieldname);

  if(!isDefined(e_player.var_10eeb170)) {
    e_player.var_10eeb170 = [];
  }

  if(bwasdemojump) {
    self flag::set(#"hash_2cde7566171da1e9");

    if(!isinarray(e_player.var_10eeb170, self)) {
      e_player.var_10eeb170[e_player.var_10eeb170.size] = self;
    }

    e_player thread abom_roar_rumble(fieldname);
    return;
  }

  self flag::clear(#"hash_2cde7566171da1e9");
  function_1eaaceab(e_player.var_10eeb170);

  if(isinarray(e_player.var_10eeb170, self)) {
    arrayremovevalue(e_player.var_10eeb170, self);
  }
}

function function_d96bc835(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self flag::set(#"hash_42f4206825b6195");
    function_757801a6(fieldname, undefined, is_true(self.var_3cb6f7b8[0]));
    function_9b9a5f77(fieldname, undefined, is_true(self.var_3cb6f7b8[1]));
    function_94de7e4(fieldname, undefined, is_true(self.var_3cb6f7b8[2]));
    return;
  }

  self flag::clear(#"hash_42f4206825b6195");
  function_799e56b5(self, 0);
  function_799e56b5(self, 1);
  function_799e56b5(self, 2);
}

function private abom_roar_rumble(localclientnum) {
  self endon(#"death");
  var_17b7891d = "7048eac650a2b727" + "abom_roar_rumble";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  if(!isDefined(self.var_c8ebaa27)) {
    self.var_c8ebaa27 = 0;
  }

  while(isDefined(self.var_10eeb170) && self.var_10eeb170.size > 0) {
    var_fd3fba8a = 0;

    foreach(abom in self.var_10eeb170) {
      var_4709b9b7 = 0;

      if(isDefined(abom)) {
        var_17cd5daa = abom gettagorigin("j_head");

        if(!isvec(self.origin) || !isvec(var_17cd5daa)) {
          continue;
        }

        var_4f0b409d = distancesquared(self.origin, var_17cd5daa);

        if(var_4f0b409d < sqr(200)) {
          if(vectordot(anglesToForward(abom.angles), self.origin - abom.origin) > 0) {
            var_4709b9b7 = 3;
          } else {
            var_4709b9b7 = 2;
          }
        } else if(var_4f0b409d < sqr(500)) {
          var_4709b9b7 = 2;
        } else if(var_4f0b409d < sqr(1000)) {
          var_4709b9b7 = 1;
        }
      }

      if(var_4709b9b7 > var_fd3fba8a) {
        var_fd3fba8a = var_4709b9b7;
      }
    }

    if(self.var_c8ebaa27 !== var_fd3fba8a) {
      if(self.var_c8ebaa27 > 0) {
        self stoprumble(localclientnum, function_b13b14f5(self.var_c8ebaa27));
      }

      if(var_fd3fba8a > 0) {
        self playrumblelooponentity(localclientnum, function_b13b14f5(var_fd3fba8a));
      }

      self.var_c8ebaa27 = var_fd3fba8a;
    }

    wait 0.1;
  }

  if(self.var_c8ebaa27 > 0) {
    self stoprumble(localclientnum, function_b13b14f5(self.var_c8ebaa27));
  }

  self.var_c8ebaa27 = 0;
}

function private abom_beam_rumble(localclientnum) {
  self endon(#"death");
  var_17b7891d = "33b0eac464f6a3eb" + "abom_beam_rumble";
  self notify(var_17b7891d);
  self endon(var_17b7891d);

  if(!isDefined(self.var_93515e9c)) {
    self.var_93515e9c = 0;
  }

  while(isDefined(self.var_2788ca7e) && self.var_2788ca7e.size > 0) {
    var_fd3fba8a = 0;

    foreach(abom in self.var_2788ca7e) {
      var_4eb77d26 = 0;

      if(isDefined(abom)) {
        var_17cd5daa = abom gettagorigin("j_head");
        var_4f0b409d = distancesquared(self.origin, var_17cd5daa);

        if(var_4f0b409d < sqr(1000)) {
          var_4eb77d26 = 1;
        }
      }

      if(var_4eb77d26 > var_fd3fba8a) {
        var_fd3fba8a = var_4eb77d26;
      }
    }

    if(self.var_93515e9c !== var_fd3fba8a) {
      if(self.var_93515e9c > 0) {
        self stoprumble(localclientnum, "zm_abom_beam_screenshake");
      }

      if(var_fd3fba8a > 0) {
        self playrumblelooponentity(localclientnum, "zm_abom_beam_screenshake");
      }

      self.var_93515e9c = var_fd3fba8a;
    }

    wait 0.1;
  }

  if(self.var_93515e9c > 0) {
    self stoprumble(localclientnum, "zm_abom_beam_screenshake");
  }

  self.var_93515e9c = 0;
}

function private function_b13b14f5(tier) {
  switch (tier) {
    case 1:
      return # "hash_3b3bffcad5f6bde1";
    case 2:
      return # "hash_31397fe5e7837982";
    case 3:
      return # "hash_6256853949b1bfba";
  }

  return undefined;
}