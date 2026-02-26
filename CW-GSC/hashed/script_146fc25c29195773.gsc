/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_146fc25c29195773.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\util_shared;
#namespace namespace_6fdcb0;

function function_912776e6(var_f03e723e) {
  assert(ishash(var_f03e723e));
  var_1e80d435 = getscriptbundle(var_f03e723e);
  var_272aa18c = var_1e80d435.var_ca65c53;
  level.var_9cc7e850 = 0;

  if(!isDefined(level.combination)) {
    level.combination = [];
  }

  if(!isDefined(level.var_91d22c7d)) {
    level.var_91d22c7d = [];
  }

  assert(var_272aa18c.size > 0);

  if(namespace_61e6d095::exists(#"hash_3b32288cc17c7c50")) {
    namespace_61e6d095::remove(#"hash_3b32288cc17c7c50");
  }

  namespace_61e6d095::create(#"hash_3b32288cc17c7c50", #"hash_719a4d9188d68f7");
  namespace_61e6d095::function_9ade1d9b(#"hash_3b32288cc17c7c50", "ActiveIndex", -1);
  function_2c85ed08(0);

  for(i = 0; i < var_272aa18c.size; i++) {
    item = var_272aa18c[i];

    if(!isDefined(level.combination)) {
      level.combination = [];
    } else if(!isarray(level.combination)) {
      level.combination = array(level.combination);
    }

    level.combination[level.combination.size] = isDefined(item.var_509412f0) ? item.var_509412f0 : 0;

    if(!isDefined(level.var_91d22c7d)) {
      level.var_91d22c7d = [];
    } else if(!isarray(level.var_91d22c7d)) {
      level.var_91d22c7d = array(level.var_91d22c7d);
    }

    level.var_91d22c7d[level.var_91d22c7d.size] = isDefined(item.initial_value) ? item.initial_value : 0;
    namespace_61e6d095::function_9ade1d9b(#"hash_3b32288cc17c7c50", "Combo" + i, isDefined(item.initial_value) ? item.initial_value : 0);
  }

  function_2c85ed08();
  namespace_61e6d095::function_9ade1d9b(#"hash_3b32288cc17c7c50", "ActiveIndex", 0);
  namespace_61e6d095::function_73c9a490(#"hash_3b32288cc17c7c50", 1);
  thread function_7825ee37();
}

function private function_7825ee37(var_31d7501a) {
  player = getplayers()[0];
  player endon(#"death");
  snd::play("fly_combo_lock_safehouse_enter", player);

  if(!isDefined(var_31d7501a)) {
    var_31d7501a = 10;
  }

  selected = 0;
  var_ab89de9b = 0;
  left_right = 0;
  up_down = 0;
  var_2ce7727b = 0;
  var_b4ce0d8c = 0;
  var_16aebd94 = 250;
  player childthread namespace_61e6d095::block_kbm_pause_menu([#"exit", #"combination_correct"]);

  while(true) {
    if(player namespace_61e6d095::function_70217795()) {
      function_838e9ba9();
      player notify(#"exit");
      snd::play("fly_combo_lock_safehouse_exits", player);
      return;
    }

    time = gettime();

    if(time - var_2ce7727b > 250) {
      left_right = 0;
    }

    if(time - var_b4ce0d8c > 250) {
      up_down = 0;
    }

    var_cf705cb2 = {
      #x: 0, #y: 0
    };

    if(player gamepadusedlast()) {
      left_stick = player namespace_61e6d095::function_9c365c3b();
      right_stick = player namespace_61e6d095::function_6cbc939b();

      if(left_stick.length > right_stick.length) {
        var_cf705cb2.x = util::function_b5338ccb(left_stick.x, 0.2);
        var_cf705cb2.y = util::function_b5338ccb(left_stick.y, 0.2);
      } else {
        var_cf705cb2.x = util::function_b5338ccb(right_stick.x, 0.2);
        var_cf705cb2.y = util::function_b5338ccb(right_stick.y, 0.2);
      }
    }

    if(up_down >= 0 && (player namespace_61e6d095::function_9975a94d() || player backbuttonPressed() || var_cf705cb2.y < 0)) {
      up_down = -1;
      var_b4ce0d8c = time;
    } else if(up_down <= 0 && (player namespace_61e6d095::function_aef1e8c3() || player forwardbuttonPressed() || var_cf705cb2.y > 0)) {
      up_down = 1;
      var_b4ce0d8c = time;
    } else if(left_right >= 0 && (player namespace_61e6d095::function_c2d8a326() || player moveleftbuttonPressed() || var_cf705cb2.x < 0)) {
      left_right = -1;
      var_2ce7727b = time;
    } else if(left_right <= 0 && (player namespace_61e6d095::function_3d680c10() || player moverightbuttonPressed() || var_cf705cb2.x > 0)) {
      left_right = 1;
      var_2ce7727b = time;
    }

    if(var_b4ce0d8c == time) {
      snd::play("evt_kgb_combo_lock_click", player);
      var_ab89de9b = (level.var_91d22c7d[level.var_9cc7e850] + up_down) % var_31d7501a;

      if(var_ab89de9b < 0) {
        var_ab89de9b += var_31d7501a;
      }

      level.var_91d22c7d[level.var_9cc7e850] = var_ab89de9b;
      namespace_61e6d095::function_9ade1d9b(#"hash_3b32288cc17c7c50", "Combo" + level.var_9cc7e850, var_ab89de9b);

      if(function_ab53f639()) {
        return;
      }
    } else if(var_2ce7727b == time && selected + left_right >= 0 && selected + left_right < level.combination.size) {
      snd::play("evt_kgb_combo_lock_slide", player);
      selected += left_right;

      if(selected < 0) {
        selected = 0;
      } else if(selected > level.combination.size - 1) {
        selected = level.combination.size - 1;
      }

      level.var_9cc7e850 = selected;
      namespace_61e6d095::function_9ade1d9b(#"hash_3b32288cc17c7c50", "ActiveIndex", selected);
    }

    waitframe(1);
  }
}

function private function_ab53f639() {
  for(i = 0; i < level.var_91d22c7d.size; i++) {
    if(level.var_91d22c7d[i] != level.combination[i]) {
      return false;
    }
  }

  function_2c85ed08(3);
  player = getplayers()[0];
  snd::play("evt_lockpick_wrench_tighten", player);
  snd::play("evt_kgb_combo_lock_success_whoosh");
  wait 1;
  player notify(#"combination_correct");
  snd::play("evt_kgb_combo_lock_success", player);
  return true;
}

function function_2c85ed08(state = 1) {
  namespace_61e6d095::function_9ade1d9b(#"hash_3b32288cc17c7c50", "State", state);
}

function function_838e9ba9() {
  if(namespace_61e6d095::exists(#"hash_3b32288cc17c7c50")) {
    namespace_61e6d095::function_73c9a490(#"hash_3b32288cc17c7c50", 0);
    namespace_61e6d095::remove(#"hash_3b32288cc17c7c50");
  }

  level.combination = undefined;
  level.var_91d22c7d = undefined;
}