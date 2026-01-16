/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_vo.gsc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\ct_utils;

#namespace ct_vo;

autoexec __init__system__() {
  system::register(#"ct_vo", &__init__, undefined, undefined);
}

__init__() {}

get_player() {
  a_e_allies = util::get_players(#"allies");
  return a_e_allies[0];
}

function_41e59aeb(a_str_vo, var_3a78a180 = 1, var_35f78012 = 0) {
  level endon(#"combattraining_logic_finished");

  while(true) {
    if(!function_5d127774()) {
      break;
    }

    waitframe(1);
  }

  function_831e0584(a_str_vo, var_3a78a180, var_35f78012);
}

function_831e0584(a_str_vo, var_3a78a180 = 1, var_35f78012 = 0) {
  level endon(#"combattraining_logic_finished");

  if(!(isDefined(level.var_77e9434e) && level.var_77e9434e)) {
    self thread function_3820390e(a_str_vo, var_3a78a180, var_35f78012);
    waitframe(1);
    function_3ca1b77d(1);
  }
}

function_3820390e(a_str_vo, var_3a78a180 = 1, var_35f78012 = 0) {
  level endon(#"combattraining_logic_finished");
  level notify(#"hash_269c201d6122a737");
  waitframe(1);
  level endoncallback(&function_a13e292b, #"hash_269c201d6122a737");
  e_player = get_player();
  e_player endoncallback(&function_a13e292b, #"death");
  n_time = gettime() / 1000;

  if(level.var_a188abf === n_time) {
    return;
  }

  level.var_a188abf = gettime() / 1000;

  if(!isDefined(a_str_vo)) {
    return;
  }

  if(isDefined(level.var_3f407ec2) && level.var_3f407ec2) {
    return;
  }

  if(!var_35f78012) {
    while(isDefined(level.var_de17b8a3) && level.var_de17b8a3) {
      waitframe(1);
    }
  }

  if(isDefined(e_player.var_8701e993)) {
    e_player stopsound(e_player.var_8701e993);
  }

  var_56402506 = gettime() / 1000;

  for(n_time = 0; isDefined(e_player.var_ec53b83b) && e_player.var_ec53b83b && n_time < 0.5; n_time = gettime() / 1000 - var_56402506) {
    waitframe(1);
  }

  if(isDefined(e_player.var_ec53b83b) && e_player.var_ec53b83b) {
    e_player.var_ec53b83b = 0;
  }

  e_player.var_a10aaced = a_str_vo.size;
  e_player.var_9e2e6113 = 0;

  foreach(str_vo in a_str_vo) {
    e_player.var_8701e993 = str_vo;
    e_player function_62b6f78a(e_player.var_8701e993, 1);
    e_player.var_a10aaced--;
  }

  function_a13e292b(#"hash_73687ae50a00b952");
}

function_47ece28d(_hash) {
  level thread function_a13e292b(_hash);
}

function_a13e292b(_hash) {
  e_player = get_player();

  if(isDefined(e_player) && !(isDefined(e_player.var_ec53b83b) && e_player.var_ec53b83b)) {
    e_player.var_ec53b83b = 1;

    if(isDefined(e_player.var_8701e993)) {
      e_player stopsound(e_player.var_8701e993);
    }

    waitframe(1);
    e_player.var_681d4714 = e_player.var_8701e993;
    e_player.var_8701e993 = undefined;
    e_player.var_9e2e6113 = 0;
    e_player.var_a10aaced = 0;
    e_player.var_ec53b83b = 0;
  }
}

play_vo(str_vo, var_3a78a180 = 1) {
  self thread function_62b6f78a(str_vo, var_3a78a180);
  waitframe(1);
  function_3ca1b77d();
}

function_62b6f78a(str_vo, var_3a78a180 = 1) {
  level endon(#"combattraining_logic_finished");
  level notify(#"hash_13084191e4b3baf1");
  waitframe(1);
  level endoncallback(&function_d7a1a570, #"hash_13084191e4b3baf1");
  e_player = get_player();
  e_player endoncallback(&function_d7a1a570, #"death");
  e_player.var_9e2e6113++;
  e_player.var_8701e993 = str_vo;
  e_player.var_b9d55f30 = str_vo + "_done";
  e_player.var_27405e0f = soundgetplaybacktime(str_vo) / 1000;
  e_player playSound(e_player.var_8701e993);

  if(var_3a78a180) {
    e_player function_56ed19d9();
    return;
  }

  e_player thread function_56ed19d9();
}

function_56ed19d9() {
  self endoncallback(&function_d7a1a570, #"death");

  if(self.var_27405e0f > 0) {
    wait self.var_27405e0f;
  } else {

    iprintlnbold("<dev string:x38>" + self.var_8701e993);

  }

  self notify(self.var_b9d55f30);
  self.var_9e2e6113--;
  self.var_8701e993 = undefined;
}

function_c72e58c1(_hash) {
  level thread function_d7a1a570(_hash);
}

function_d7a1a570(_hash) {
  e_player = get_player();

  if(isDefined(e_player)) {
    e_player.var_fac6c61 = 1;

    if(isDefined(e_player.var_8701e993)) {
      e_player stopsound(e_player.var_8701e993);
      e_player.var_681d4714 = e_player.var_8701e993;
    }

    e_player.var_8701e993 = undefined;
    e_player.var_9e2e6113 = 0;
    e_player.var_27405e0f = 0;
    e_player.var_fac6c61 = 0;
  }
}

disable_vo(b_disable, n_delay) {
  if(isDefined(n_delay)) {
    wait n_delay;
  }

  level.var_3f407ec2 = b_disable;
}

function_3ca1b77d(var_d9da07d1 = 1) {
  level endon(#"combattraining_logic_finished");
  e_player = getplayers()[0];

  if(isalive(e_player)) {
    e_player endon(#"death");
  } else {
    return;
  }

  wait 0.1;
  n_start_time = gettime() / 1000;

  while(true) {
    if(isDefined(var_d9da07d1) && var_d9da07d1) {
      if((!isDefined(e_player.var_a10aaced) || e_player.var_a10aaced == 0) && (!isDefined(e_player.var_9e2e6113) || e_player.var_9e2e6113 <= 0)) {
        e_player.var_9e2e6113 = 0;
        waitframe(1);
        break;
      }
    } else if(!isDefined(e_player.var_8701e993) && (!isDefined(e_player.var_9e2e6113) || e_player.var_9e2e6113 <= 0)) {
      e_player.var_9e2e6113 = 0;
      waitframe(1);
      break;
    }

    n_time = gettime() / 1000;
    dt = n_time - n_start_time;

    if(dt > 15 && e_player.var_a10aaced == 0) {
      e_player.var_9e2e6113 = 0;
      break;
    }

    waitframe(1);
  }

  waitframe(1);
}

function_5d127774() {
  e_player = getplayers()[0];

  if(isalive(e_player) && isDefined(e_player.var_9e2e6113) && e_player.var_9e2e6113 > 0) {
    return true;
  }

  return false;
}

function_261ed63c(str_vo, var_520123e0 = 45, n_wait = 30, var_74e4153b) {
  if(isDefined(var_74e4153b)) {
    level endoncallback(&function_869da1cf, #"combattraining_logic_finished", #"hash_60e26e14a51c5211", var_74e4153b);
  } else {
    level endoncallback(&function_869da1cf, #"combattraining_logic_finished", #"hash_60e26e14a51c5211");
  }

  e_player = get_player();
  e_player thread function_dad9897f(str_vo, var_520123e0, n_wait);
}

function_dad9897f(str_vo, var_520123e0 = 45, n_wait = 30) {
  level endoncallback(&function_869da1cf, #"combattraining_logic_finished", #"hash_60e26e14a51c5211");
  b_first = 1;

  do {
    if(b_first) {
      wait var_520123e0;
      b_first = 0;
    } else {
      wait n_wait;
    }

    self function_3ca1b77d();
    self.var_ca6e5bf1 = str_vo;
    self play_vo(str_vo, 1);
    self.var_ca6e5bf1 = undefined;
  }
  while(true);
}

function_869da1cf(_hash) {
  e_player = get_player();

  if(isDefined(e_player.var_ca6e5bf1)) {
    e_player stopsound(e_player.var_ca6e5bf1);

    if(e_player.var_8701e993 === e_player.var_ca6e5bf1) {
      e_player.var_8701e993 = undefined;
    }

    e_player.var_ca6e5bf1 = undefined;
    e_player.var_9e2e6113 = 0;
  }
}

vo_on_damage(str_vo, var_f4b1cabb = 1, n_rest = 10, var_515667fb = #"axis", str_mod, str_weapon) {
  level endon(#"combattraining_logic_finished", #"hash_658f0911fdecfaf8");
  self endon(#"death", #"hash_658f0911fdecfaf8");
  e_player = get_player();
  e_player endon(#"death");

  do {
    s_notify = self waittill(#"damage");
    var_17ec8061 = !isDefined(s_notify.attacker) || s_notify.attacker.team == var_515667fb;
    var_d8d43f9a = !isDefined(str_mod) || s_notify.mod === str_mod;
    var_95ea2eec = !isDefined(str_weapon) || getweapon(str_weapon) === s_notify.weapon;

    if(var_17ec8061 && var_d8d43f9a && var_95ea2eec) {
      e_player function_3ca1b77d();
      e_player function_831e0584(array(str_vo));
    }

    wait n_rest;
  }
  while(var_f4b1cabb);
}

function_28126982(a_str_vo) {
  level endon(#"combattraining_logic_finished", #"hash_658f0911fdecfaf8");
  self endon(#"hash_658f0911fdecfaf8");
  e_player = get_player();
  self waittill(#"death");
  e_player function_3ca1b77d();
  waitframe(1);
  e_player function_831e0584(a_str_vo);
}

function_625a37f9(vo, _notify, b_once = 1, var_cd53c705 = 1, var_dfbbbce6 = 10, var_352fef28 = 0, var_37338add = 1, var_8e9dbdf9 = 1) {
  level endoncallback(&function_dae6df54, #"combattraining_logic_finished", #"hash_4c2e751dd9e2bb57");
  e_player = get_player();

  if(isDefined(var_8e9dbdf9) && var_8e9dbdf9) {
    e_player endoncallback(&function_dae6df54, #"death", #"hash_4c2e751dd9e2bb57");
  }

  var_e8ee1cd1 = 0;

  if(isDefined(var_352fef28) && var_352fef28) {
    b_once = 0;
  }

  do {
    level waittill(_notify);

    if(isDefined(var_cd53c705) && var_cd53c705) {
      e_player function_3ca1b77d(1);
    }

    if(var_352fef28) {
      str_vo = vo[var_e8ee1cd1];
      e_player function_831e0584(array(str_vo));
      var_e8ee1cd1++;

      if(var_e8ee1cd1 >= vo.size) {
        var_e8ee1cd1 = 0;

        if(var_37338add) {
          return;
        }
      }
    } else if(isarray(vo)) {
      e_player function_3820390e(vo, 1);
    } else {
      e_player function_3820390e(array(vo), 1);
    }

    wait var_dfbbbce6;
  }
  while(!(isDefined(b_once) && b_once));
}

function_dae6df54(_hash) {
  level notify(#"hash_13084191e4b3baf1");
}

function_8d5bc717(str_trig, vo) {
  level endoncallback(&function_fe927bbd, #"combattraining_logic_finished", #"hash_2d2294060e47449f");
  e_player = get_player();
  e_player endoncallback(&function_fe927bbd, #"death", #"hash_2d2294060e47449f");
  trigger::wait_till(str_trig);

  if(isstring(vo)) {
    vo = array(vo);
  }

  self function_831e0584(vo);
}

function_fe927bbd(_hash) {
  level notify(#"hash_269c201d6122a737");
}

stop_nag(var_f031f5a) {
  level waittill(var_f031f5a);
  level.var_de17b8a3 = 0;
}

function_14b08e49(a_str_vo, var_f031f5a) {
  level endon(#"combattraining_logic_finished");

  if(isDefined(var_f031f5a)) {
    level endon(var_f031f5a);
    level thread function_b3c04dfd(var_f031f5a);
  }

  if(isDefined(20)) {
    wait 20;
  }

  level.var_3e17f129 = 1;

  while(true) {
    if(isDefined(level.var_29c997df) && level.var_29c997df) {
      function_731eb7ed();
    }

    while(function_5d127774()) {
      waitframe(1);
    }

    var_cbcad363 = 1;
    n_time = gettime() / 1000;

    if(isDefined(level.var_6ee32682)) {
      dt = n_time - level.var_6ee32682;

      if(dt < 8) {
        var_cbcad363 = 0;
      }
    }

    if(var_cbcad363) {
      level.var_de17b8a3 = 1;

      if(isDefined(var_f031f5a)) {
        level thread stop_nag(var_f031f5a);
        var_f031f5a = undefined;
      }

      function_831e0584(a_str_vo, 1, 1);
      level.var_de17b8a3 = 0;
      level.var_6ee32682 = gettime() / 1000;
    }

    wait 20;
  }

  level.var_3e17f129 = undefined;
}

function_b3c04dfd(str_endon) {
  level waittill(str_endon);
  level.var_3e17f129 = undefined;
}

function_731eb7ed() {
  level.var_6ee32682 = gettime() / 1000;
}

function_5172b052(str_vo, str_endon_notify) {
  level endon(#"combattraining_logic_finished", str_endon_notify);

  while(true) {
    e_player = getplayers()[0];

    if(!isalive(e_player)) {
      while(function_5d127774()) {
        waitframe(1);
      }

      function_831e0584(array(str_vo), 1);

      while(true) {
        e_player = getplayers()[0];

        if(isalive(e_player)) {
          break;
        }

        waitframe(1);
      }
    }

    waitframe(1);
  }
}

function_accb34a7(v_target_pos, var_9a9916cf, a_str_vo, str_endon, var_b181ba65) {
  level endon(#"combattraining_logic_finished", str_endon);

  while(true) {
    e_player = getplayers()[0];
    v_eye = e_player util::get_eye();
    n_dist = distance(v_eye, v_target_pos);

    if(n_dist < var_9a9916cf) {
      if(e_player ct_utils::can_see(v_target_pos, 1)) {
        if(isDefined(var_b181ba65)) {
          e_player = getplayers()[0];
          e_player thread ct_utils::function_61c3d59c(var_b181ba65, undefined);
        }

        function_41e59aeb(a_str_vo);
        break;
      }
    }

    waitframe(1);
  }
}

function_5df1a850(e_entity, a_str_vo) {
  if(!isDefined(level.var_77e9434e)) {
    level.var_77e9434e = 0;
  }

  level.var_77e9434e++;
  e_entity function_b0c62cf3(a_str_vo);
  level.var_77e9434e--;
}

function_b0c62cf3(a_str_vo) {
  self endon(#"death");

  foreach(str_vo in a_str_vo) {
    self playsoundwithnotify(str_vo, "sound_done");
    self waittill(#"sound_done");
  }
}

function_b86d3b7d() {
  wait 0.1;

  while(level.var_77e9434e > 0) {
    waitframe(1);
  }
}

function_dfd7add4() {
  sessionmode = currentsessionmode();
  setdvar(#"hash_31b5762ac1fb40cf", "<dev string:x77>");

  if(sessionmode != 4) {
    adddebugcommand("<dev string:x7a>");
  }

  while(true) {
    wait 0.25;
    cmd = getdvarstring(#"hash_31b5762ac1fb40cf", "<dev string:x77>");

    if(cmd == "<dev string:x77>") {
      continue;
    }

    e_player = level.players[0];

    switch (cmd) {
      case #"stub":
        break;
    }

    setdvar(#"hash_31b5762ac1fb40cf", "<dev string:x77>");
  }
}

