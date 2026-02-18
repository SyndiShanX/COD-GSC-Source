/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_100835406ec3feaf.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_devgui;
#namespace zm_platinum_ww_quest;

function function_f8a8ff3f() {
  clientfield::register("scriptmover", "" + # "hash_1fc683b0af884f6b", 24000, 1, "int");
  clientfield::register("toplayer", "" + # "hash_6d58634b9c00e983", 24000, 1, "int");
  clientfield::register("scriptmover", "" + # "highlight_dial", 24000, 4, "int");
  level.var_ea51eeb9 = {};
  level.var_ea51eeb9 thread function_756f46cf();
  level.var_ea51eeb9 thread function_faf723a();

  level thread function_63a18814();
}

function function_756f46cf() {
  a_locs = [3, 3, 3];
  n_bits = getminbitcountfornum(39);
  a_data = [];
  assert(-1);
  assert(a_locs.size == 3);

  for(i = 0; i < 3; i++) {
    number = randomintrange(0, 40);
    location = randomint(a_locs[i]);

    if(!isDefined(a_data)) {
      a_data = [];
    } else if(!isarray(a_data)) {
      a_data = array(a_data);
    }

    a_data[a_data.size] = (location << n_bits) + number;

    if(!isDefined(self.numbers)) {
      self.numbers = [];
    } else if(!isarray(self.numbers)) {
      self.numbers = array(self.numbers);
    }

    self.numbers[self.numbers.size] = number;

    if(!isDefined(self.input)) {
      self.input = [];
    } else if(!isarray(self.input)) {
      self.input = array(self.input);
    }

    self.input[self.input.size] = 0;
  }

  var_75804f33 = (a_data[0], a_data[1], a_data[2]);
  var_4188f862 = util::spawn_model("tag_origin", var_75804f33);
  util::wait_network_frame();

  if(isDefined(var_4188f862)) {
    var_4188f862 clientfield::set("" + # "hash_1fc683b0af884f6b", 1);
  }
}

function function_19a410e2(var_a370eede) {
  var_4d05aafa = self.n_index + 1;

  if(var_a370eede) {
    var_4d05aafa |= 4;
  }

  self clientfield::set("" + # "highlight_dial", var_4d05aafa);
  self.var_2cc651d5 clientfield::set("" + # "highlight_dial", var_4d05aafa | 8);
}

function function_faf723a() {
  e_safe = getent("ww_safe", "targetname");
  self.safe = e_safe;

  for(i = 0; i < 3; i++) {
    var_9a00bf02 = "tag_dial_" + i;
    v_origin = e_safe gettagorigin(var_9a00bf02);
    v_angles = e_safe gettagangles(var_9a00bf02);
    e_lock = util::spawn_model(#"hash_4f1e10f734edcd48" + i, v_origin, v_angles);
    var_2cc651d5 = util::spawn_model(#"hash_32784def46e0e975" + i, v_origin, v_angles);
    e_lock linkto(e_safe, var_9a00bf02);
    var_2cc651d5 linkto(e_safe, var_9a00bf02);
    e_lock.n_index = i;
    e_lock.var_2cc651d5 = var_2cc651d5;

    if(!isDefined(self.locks)) {
      self.locks = [];
    } else if(!isarray(self.locks)) {
      self.locks = array(self.locks);
    }

    self.locks[self.locks.size] = e_lock;
    util::wait_network_frame();
    e_lock function_19a410e2(0);
  }
}

function function_4395371c() {
  var_8468438a = self getplayercamerapos();
  var_a364d7fa = anglesToForward(self getplayerangles());
  var_c575b928 = 0.9744;
  var_afa4131f = undefined;

  foreach(e_lock in level.var_ea51eeb9.locks) {
    var_d5d9a61a = e_lock.origin - var_8468438a;
    n_dist = length(var_d5d9a61a);

    if(n_dist <= 45) {
      n_fov = vectordot(var_d5d9a61a / n_dist, var_a364d7fa);

      if(n_fov > var_c575b928) {
        var_c575b928 = n_fov;
        var_afa4131f = e_lock;
      }
    }
  }

  return var_afa4131f;
}

function function_8b40c670(e_trigger) {
  level endon(#"end_game");
  self endon(#"disconnect", #"death");
  self.var_eddb113e = 1;
  var_ba127c46 = self.var_19f4406e;
  self.var_19f4406e = 0;
  self flag::set(#"hash_2d6980738132f263");
  self val::set(#"dial_lock", "disable_weapons", 1);
  self val::set(#"dial_lock", "allow_jump", 0);
  self val::set(#"dial_lock", "allow_stand", 0);
  self val::set(#"dial_lock", "allow_prone", 0);
  self val::set(#"dial_lock", "ignoreme", 1);

  while(self getstance() != "crouch") {
    waitframe(1);
  }

  if(isDefined(e_trigger)) {
    self playerlinkto(e_trigger, undefined, 0, 30, 30, 0, 16);
  }

  self.var_9e8e7b78 = undefined;

  while(isDefined(e_trigger) && self istouching(e_trigger) && !self laststand::player_is_in_laststand()) {
    if(level flag::get(#"hash_7b5643f5ecc16c8f") || level flag::get(#"boss_fight_started")) {
      break;
    }

    var_1806c69c = self gamepadusedlast();
    var_e109599a = self buttonbitstate("BUTTON_BIT_ANY_DOWN");

    if(var_e109599a) {
      break;
    }

    input = 0;
    e_lock = self function_4395371c();

    if(self.var_9e8e7b78 !== e_lock) {
      if(isDefined(self.var_9e8e7b78)) {
        self.var_9e8e7b78 function_19a410e2(0);
      }

      self.var_9e8e7b78 = e_lock;

      if(isDefined(e_lock)) {
        e_lock function_19a410e2(1);
      }
    }

    if(isDefined(self.var_9e8e7b78)) {
      var_844c4420 = self secondaryoffhandbuttonPressed();
      var_7b75f8c2 = var_1806c69c ? self fragButtonPressed() : self meleeButtonPressed();

      if(var_844c4420) {
        input++;
      }

      if(var_7b75f8c2) {
        input--;
      }

      if(input != 0) {
        n_index = self.var_9e8e7b78.n_index;
        level.var_ea51eeb9.input[n_index] = (level.var_ea51eeb9.input[n_index] + input + 40) % 40;
        playsoundatposition(#"hash_16474e80e8a1f9d", self.var_9e8e7b78.origin);

        iprintlnbold("<dev string:x38>" + n_index + "<dev string:x40>" + level.var_ea51eeb9.input[n_index] + "<dev string:x4f>" + level.var_ea51eeb9.numbers[n_index]);

        self.var_9e8e7b78 linktoupdateoffset((0, 0, 0), (level.var_ea51eeb9.input[n_index] * 9, 0, 0));
        wait 0.2;
        continue;
      }
    }

    waitframe(1);
  }

  self unlink();
  waitframe(1);
  self val::reset_all(#"dial_lock");

  if(var_ba127c46 != 0) {
    self.var_19f4406e = var_ba127c46;
    self flag::set(#"hash_2d6980738132f263");
  }

  self.var_eddb113e = undefined;
}

function function_7d0eaace() {
  var_8b27029a = 1;

  for(i = 0; i < 3; i++) {
    if(level.var_ea51eeb9.input[i] != level.var_ea51eeb9.numbers[i]) {
      var_8b27029a = 0;
      break;
    }
  }

  if(var_8b27029a) {
    level flag::set(#"hash_358a79602429d556");

    iprintlnbold("<dev string:x5e>");

    return;
  }

  level.var_ea51eeb9.locks[1] playSound(#"hash_437516da741e5140");

  iprintlnbold("<dev string:x70>");
}

function function_63a18814() {
  util::add_debug_command("<dev string:x81>");
  util::add_debug_command("<dev string:xf0>");
  zm_devgui::add_custom_devgui_callback(&cmd);
}

function cmd(cmd) {
  switch (cmd) {
    case # "hash_4121f85b9490b08c":
      function_9fa3d0d(0);
      break;
    case # "hash_4121f95b9490b23f":
      function_9fa3d0d(1);
      break;
    default:
      break;
  }
}

function function_9fa3d0d(index) {
  player = getplayers()[index];

  if(!isDefined(player)) {
    return;
  }

  if(!isDefined(player.blacklight)) {
    player.blacklight = 0;
  }

  player.blacklight = (player.blacklight + 1) % 2;

  if(player.blacklight) {
    player.var_19f4406e = 2;
    player flag::set(#"hash_2d6980738132f263");
    return;
  }

  player.var_19f4406e = 0;
  player flag::set(#"hash_2d6980738132f263");
}