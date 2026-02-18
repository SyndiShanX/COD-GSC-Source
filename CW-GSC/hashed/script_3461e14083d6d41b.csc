/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_3461e14083d6d41b.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace zm_platinum_ww_quest;

function function_f8a8ff3f() {
  clientfield::register("scriptmover", "" + # "hash_1fc683b0af884f6b", 24000, 1, "int", &function_78d34bcb, 0, 0);
  clientfield::register("toplayer", "" + # "hash_6d58634b9c00e983", 24000, 1, "int", &function_84decde0, 0, 0);
  clientfield::register("scriptmover", "" + # "highlight_dial", 24000, 4, "int", &highlight_dial, 0, 0);
}

function function_58ac9d9c(s_loc, n_idx) {
  return s_loc.script_int === n_idx;
}

function function_78d34bcb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  a_locs = [3, 3, 3];
  n_bits = getminbitcountfornum(39);
  var_d68544d = (1 << n_bits) - 1;
  assert(-1);

  for(i = 0; i < 3; i++) {
    data = int(self.origin[i]);
    number = data &var_d68544d;
    assert(number >= 0 && number < 40);
    location = data >> n_bits;
    assert(location >= 0 && location < a_locs[i]);
    var_a0933ff7 = struct::get_array("hidden_number_loc" + i, "targetname");
    a_decals = array::filter(var_a0933ff7, 0, &function_58ac9d9c, location);
    n_tens = int(number / 10);
    n_ones = number % 10;

    if(getdvarint(#"hash_283a6bb15ccb0cab", 0)) {
      a_decals = var_a0933ff7;
    }

    foreach(decal in a_decals) {
      if(decal.script_noteworthy === "tens") {
        digit = n_tens;
      } else if(decal.script_noteworthy === "ones") {
        digit = n_ones;
      } else {
        continue;
      }

      mdl_digit = util::spawn_model(bwasdemojump, #"p9_zm_platinum_hidden_numbers", decal.origin, decal.angles);
      mdl_digit.rob = # "hash_5ee04cd58e027952" + digit;

      if(!isDefined(level.var_455f7b8c)) {
        level.var_455f7b8c = [];
      } else if(!isarray(level.var_455f7b8c)) {
        level.var_455f7b8c = array(level.var_455f7b8c);
      }

      level.var_455f7b8c[level.var_455f7b8c.size] = mdl_digit;
    }
  }
}

function function_84decde0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  player = function_5c10bd79(fieldname);

  if(bwasdemojump) {
    player flag::set(#"blacklight_on");
    player thread watch_player_death();

    if(!isDefined(level.var_455f7b8c)) {
      level.var_455f7b8c = [];
    }

    array::thread_all(level.var_455f7b8c, &function_1d9bbc33, fieldname, player);

    if(isDefined(level.var_1a3fe1eb) && level.var_1a3fe1eb.size != 0) {
      array::thread_all(level.var_1a3fe1eb, &function_1d9bbc33, fieldname, player);
    }

    return;
  }

  player flag::clear(#"blacklight_on");
  array::thread_all(level.var_455f7b8c, &function_d04b4b2c);

  if(isDefined(level.var_1a3fe1eb) && level.var_1a3fe1eb.size != 0) {
    array::thread_all(level.var_1a3fe1eb, &function_d04b4b2c);
  }
}

function watch_player_death() {
  self endon(#"blacklight_on");
  self waittill(#"death");
  array::thread_all(level.var_455f7b8c, &function_d04b4b2c);
}

function function_d04b4b2c() {
  if(isDefined(self.rob) && self function_d2503806(self.rob)) {
    self.threshold = 0;
    self function_78233d29(self.rob, "", #"brightness", 0);
    self function_78233d29(self.rob, "", #"threshold", 0);
    self function_f6e99a8d(self.rob);
  }
}

function function_1d9bbc33(localclientnum, player) {
  self endon(#"death");
  player endon(#"death");
  self.threshold = 0;

  while(player flag::get(#"blacklight_on")) {
    b_lit = 0;
    light_pos = function_8cb7ea7(localclientnum, "tag_flashlight");
    dist = distance2dsquared(self.origin, light_pos);

    if(dist <= 160000) {
      var_327ac8 = anglesToForward(function_1957ce2a(localclientnum, "tag_flashlight"));
      var_7ec97bb = vectornormalize(self.origin - light_pos);
      dot = vectordot(var_7ec97bb, var_327ac8);
      lerp = (dist - 10000) / 150000;

      if(lerp < 0) {
        lerp = 0;
      }

      fov = 0.9205 + 0.0757 * lerp;

      if(dot > fov) {
        self.threshold = 1 - (1 - dot) / (1 - fov);
        falloff = 10000 / dist;

        if(falloff > 1) {
          falloff = 1;
        }

        self.threshold *= falloff;

        if(self.threshold < 0) {
          self.threshold = 0;
        } else if(self.threshold > 1) {
          self.threshold = 1;
        }

        b_lit = 1;
      }
    }

    if(b_lit) {
      if(!self function_d2503806(self.rob)) {
        self playrenderoverridebundle(self.rob);
      }

      self function_78233d29(self.rob, "", #"brightness", self.threshold);
      self function_78233d29(self.rob, "", #"threshold", self.threshold);
    } else {
      if(self.threshold > 0) {
        self util::lerp_generic(localclientnum, 100, &function_9e7290f5, self.threshold, 0, self.rob);
        wait 0.1;
        self.threshold = 0;
      }

      self function_d04b4b2c();
    }

    print3d(self.origin + (0, 0, 12), "<dev string:x38>" + self.threshold + "<dev string:x49>" + sqrt(dist), (1, 1, 1), 1, 0.25, 1);

    waitframe(1);
  }
}

function function_9e7290f5(currenttime, elapsedtime, localclientnum, fadeduration, from, to, rob) {
  self endon(#"death");
  percent = localclientnum / fadeduration;
  amount = to * percent + from * (1 - percent);

  if(self function_d2503806(self.rob)) {
    self function_78233d29(rob, "", #"brightness", amount);
    self function_78233d29(rob, "", #"threshold", amount);
  }
}

function highlight_dial(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_f83f1319 = bwasdemojump & 4 - 1;

  if(var_f83f1319 > 0) {
    n_index = var_f83f1319 - 1;

    if(bwasdemojump & 4) {
      var_65586a0d = # "hash_7a4f7a6697227204" + n_index + "_off";

      if(bwasdemojump & 8) {
        var_31ba839c = # "hash_23d5a23b600283e9" + n_index + "_on";
      } else {
        var_31ba839c = # "hash_7a4f7a6697227204" + n_index + "_on";
      }
    } else {
      if(bwasdemojump & 8) {
        var_65586a0d = # "hash_23d5a23b600283e9" + n_index + "_on";
      } else {
        var_65586a0d = # "hash_7a4f7a6697227204" + n_index + "_on";
      }

      var_31ba839c = # "hash_7a4f7a6697227204" + n_index + "_off";
    }

    if(self function_d2503806(var_65586a0d)) {
      self function_f6e99a8d(var_65586a0d);
    }

    self playrenderoverridebundle(var_31ba839c);
  }
}