/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_570cdb4e38f0225b.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_1a4b23a39cb3d1af;
#using script_570cdb4e38f0225b;
#using script_7edf952f8921aa6b;
#using scripts\aitypes\zombie_abom\zombie_abom_metabones;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace zombie_abom_heads;

function function_581a1a8dcccb6a3e() {
  callback::get_template(self.animsetname) callback::add("on_zombie_ai_damaged", &function_1a05f0d3fdebfb7a);
  callback::get_template(self.animsetname) callback::add("killed_body_cloned", &function_8642ecf50483ffa7);
}

function function_2094af5938acc348() {
  self.var_621cfca900e38646 = undefined;
  self.var_9b713c22a6b82e98 = [];
  self.var_9b713c22a6b82e98[0] = 0;
  self.var_9b713c22a6b82e98[1] = 0;
  self.var_9b713c22a6b82e98[2] = 0;
  thread function_869acf8992d59398();
  thread function_3038ad74f2630316();

  function_45e1e95fc9efceff();
}

function private function_869acf8992d59398() {
  self endon("death");

  while(true) {
    if(function_4fd20ee56e38d9c7()) {
      waitframe();
      continue;
    }

    wait 5;

    if(isDefined(self.var_621cfca900e38646)) {
      self.var_e27e50009010da3e = self.var_621cfca900e38646;
      self.var_621cfca900e38646 = undefined;
      var_ad96739640faa9ff = 0.5;

      if(function_2789dbcb483fa601(self).size <= 1) {
        round_number = function_2201d3f3d7ab07a7();
        additional_cooldown = clamp(math::remap(round_number, 20, 50, 0, 5), 0, 5);
        var_ad96739640faa9ff += additional_cooldown;
      }

      wait var_ad96739640faa9ff;
    }

    available_heads = function_68d5f1122bc3fa26(self);

    if(isDefined(self.var_e27e50009010da3e) && available_heads.size > 1) {
      available_heads = array_remove(available_heads, self.var_e27e50009010da3e);
    }

    var_a580c2b646c8a16a = random(available_heads);
    self.var_621cfca900e38646 = var_a580c2b646c8a16a;
  }
}

function private function_3038ad74f2630316() {
  self endon("death");
  waitframe();
  var_1f5f16268c04ab13 = 0;
  var_9e08733b69bd0c65 = undefined;

  while(true) {
    if(function_fea7ee078814bf2d()) {
      open_all = function_4fd20ee56e38d9c7();
      close_all = function_8a85ce3ef81d9275();

      if(open_all || close_all) {
        var_1f5f16268c04ab13 = 0;
        var_9e08733b69bd0c65 = undefined;
      } else if(!var_1f5f16268c04ab13) {
        if(!isDefined(var_9e08733b69bd0c65)) {
          var_9e08733b69bd0c65 = gettime();
        }

        var_34b3ff78ac54c85b = gettime() - var_9e08733b69bd0c65;

        if(var_34b3ff78ac54c85b >= 1000) {
          var_1f5f16268c04ab13 = 1;
          var_9e08733b69bd0c65 = undefined;
        } else {
          heads_print("<dev string:x1c>" + 1000 - var_34b3ff78ac54c85b);
        }
      }

      state_name = undefined;

      if(isDefined(self.asmname)) {
        state_name = self asmgetcurrentstate(self.asmname);
      }

      if(!var_1f5f16268c04ab13) {
        close_all = 1;
      }

      for(head_index = 0; head_index <= 2; head_index++) {
        if(function_b2fae60b8f9f98b2(self, head_index)) {
          if(open_all) {
            function_4cf62c20536220fc(self, head_index, 2);
          } else if(close_all) {
            function_4cf62c20536220fc(self, head_index, 1);
          } else if(is_equal(head_index, self.var_621cfca900e38646)) {
            function_4cf62c20536220fc(self, head_index, 2);
          } else {
            function_4cf62c20536220fc(self, head_index, 1);
          }

          continue;
        }

        function_4cf62c20536220fc(self, head_index, 0);
      }
    } else {
      function_1f7e551933baf853();
      var_1f5f16268c04ab13 = 1;
      var_9e08733b69bd0c65 = undefined;
    }

    waitframe();
  }
}

function private function_fea7ee078814bf2d() {
  if(istrue(self.in_melee)) {
    return false;
  }

  if(istrue(self getaiblackboarddynamic("in_bull_charge"))) {
    heads_print("<dev string:x44>");

    return false;
  }

  if(default_to(self getaiblackboarddynamic("recent_bull_charge_stun"), 0) > gettime() && !istrue(self getaiblackboarddynamic("in_roar_loop"))) {
    heads_print("<dev string:x60>");

    return false;
  }

  if(istrue(self getaiblackboarddynamic("in_react"))) {
    heads_print("<dev string:x7b>");

    return false;
  }

  return true;
}

function private function_4fd20ee56e38d9c7() {
  if(istrue(self getaiblackboarddynamic("in_roar_loop")) || istrue(self getaiblackboarddynamic("in_beam_attack"))) {
    heads_print("<dev string:x91>");

    return true;
  }

  return false;
}

function private function_8a85ce3ef81d9275() {
  if(function_f042d86bacba063b()) {
    heads_print("<dev string:xbb>");

    return true;
  }

  if(isDefined(self.asmname)) {
    state_name = self asmgetcurrentstate(self.asmname);

    if(isDefined(state_name) && state_name == "move_exit") {
      heads_print("<dev string:xdc>");

      return true;
    }
  }

  return false;
}

function function_2945ff43fceb0fc8(entity, head_index) {
  return entity.var_9b713c22a6b82e98[head_index];
}

function private function_4cf62c20536220fc(entity, head_index, state) {
  if(entity.var_9b713c22a6b82e98[head_index] == state) {
    return;
  }

  entity.var_9b713c22a6b82e98[head_index] = state;
  var_85301775392a5e3 = undefined;

  if(head_index == 0) {
    var_85301775392a5e3 = "head_state_le";
  } else if(head_index == 1) {
    var_85301775392a5e3 = "head_state_mid";
  } else if(head_index == 2) {
    var_85301775392a5e3 = "head_state_ri";
  }

  assert(isDefined(var_85301775392a5e3));
  entity function_4f8f8b6755b2298e(var_85301775392a5e3, state);

  heads_print("<dev string:xfc>" + var_85301775392a5e3 + "<dev string:x103>" + state, self.origin + (0, 0, 100 + 20 * head_index));

  function_da059a185d59d999(entity, head_index, state == 2);
  scriptable_state = "weakpoint_" + ter_op(state == 2 && !istrue(self getaiblackboarddynamic("in_beam_attack")), "on", "off");
  utility::function_3ab9164ef76940fd(entity.var_183bb43a8d0e0829[head_index] + "_weakpoint", scriptable_state);
}

function private function_1f7e551933baf853() {
  function_4cf62c20536220fc(self, 0, 0);
  function_4cf62c20536220fc(self, 1, 0);
  function_4cf62c20536220fc(self, 2, 0);
}

function private function_8642ecf50483ffa7(params) {
  if(isDefined(self.var_d37b75616f7c2ee)) {
    if(istrue(self.var_d37b75616f7c2ee.biscritical) && isDefined(self.var_d37b75616f7c2ee.metabonename)) {
      params.body utility::function_3ab9164ef76940fd(self.var_d37b75616f7c2ee.metabonename, "destroyed");

      if(isPlayer(self.var_d37b75616f7c2ee.eattacker)) {
        lastheaddestroyed = 1;

        for(head_index = 0; head_index <= 2; head_index++) {
          metabone = level.var_28e4ea2998e3439b[head_index];

          if(metabone != self.var_d37b75616f7c2ee.metabonename && function_b2fae60b8f9f98b2(self, head_index)) {
            lastheaddestroyed = 0;
            break;
          }
        }

        if(lastheaddestroyed) {
          self.var_d37b75616f7c2ee.eattacker doscoreeventsharedfunc(#"abom_guillotined");
        }
      }
    }
  }
}

function private function_1a05f0d3fdebfb7a(params) {
  metabone_hit = params.metabonename;

  if(!isDefined(metabone_hit)) {
    return;
  }

  head_index = scripts\aitypes\zombie_abom\zombie_abom_metabones::function_e5db29e6fd6f6a88(metabone_hit);

  if(!isDefined(head_index)) {
    return;
  }

  head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(self, head_index);

  if(head_state != 2) {
    return;
  }

  if(head_index == 0) {
    utility::function_3ab9164ef76940fd("head_le_weakpoint_impact", "weakpoint_impact");
    return;
  }

  if(head_index == 1) {
    utility::function_3ab9164ef76940fd("head_mid_weakpoint_impact", "weakpoint_impact");
    return;
  }

  if(head_index == 2) {
    utility::function_3ab9164ef76940fd("head_ri_weakpoint_impact", "weakpoint_impact");
  }
}

function function_45e1e95fc9efceff() {
  function_6e7290c8ee4f558b("<dev string:x10d>");
  function_a9a864379a098ad6("<dev string:x12d>", "<dev string:x142>", &function_a1760a8a5d279fd7);
  function_fe953f000498048f();
}

function private function_a1760a8a5d279fd7() {
  function_2fb888667001fc39("<dev string:x15c>", @ "hash_c6978e619bf9de3b");
}

function private function_377a27a97fc95faa() {
  return getdvarint(@ "hash_c6978e619bf9de3b", 0) > 0;
}

function private heads_print(text, pos) {
  if(function_377a27a97fc95faa()) {
    pos = default_to(pos, self.origin + (0, 0, 70));
    print3d(pos, "<dev string:x176>" + text, (1, 0, 0));
  }
}

# /