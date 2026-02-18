/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_fishing.gsc
***********************************************/

#using script_340a2e805e35f7a2;
#using script_3a704cbcf4081bfb;
#using script_408211ac7ff6ef56;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\zm_common\aats\zm_aat;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace zm_fishing;

function private autoexec __init__system__() {
  system::register(#"zm_fishing", &preinit, &postinit, undefined, undefined);
}

function preinit() {
  content_manager::register_script("fishing", &function_29307fae);
}

function postinit() {
  mapdestinations = struct::get_array(#"content_destination", "variantname");

  if(!zm_utility::is_survival() && isDefined(mapdestinations) && mapdestinations.size > 0) {
    level thread function_a225198d(mapdestinations[0]);
  }

  callback::add_callback(#"hash_3065435e3005a796", &function_ff1fe53a);
  callback::on_item_pickup(&on_item_pickup);
}

function function_a225198d(destination) {
  level flag::wait_till("start_zombie_round_logic");
  waittillframeend();
  function_43eaec20(destination);
}

function function_43eaec20(destination) {
  foreach(location in destination.locations) {
    var_2a4db591 = location.instances[# "fishing"];

    if(isDefined(var_2a4db591)) {
      content_manager::spawn_instance(var_2a4db591);
    }
  }
}

function function_29307fae(struct) {
  assert(isstruct(struct), "<dev string:x38>");
  spawn_points = struct.contentgroups[# "fishing_spawn"];

  foreach(point in spawn_points) {
    spawn_struct = point;
    var_16129dba = content_manager::spawn_script_model(spawn_struct, #"p8_wz_ep_fishing_pole", 0);
    var_16129dba clientfield::set("set_compass_icon", 1);
    var_1dfa9e6 = content_manager::spawn_script_model(spawn_struct, undefined);
    var_1dfa9e6 playLoopSound(#"hash_30a2fa81c37f5aff");
    assert(isDefined(spawn_struct.contentgroups[# "hash_a8d2c2c21149a79"]), "<dev string:x56>");
    var_c4b6fa2d = spawn_struct.contentgroups[# "hash_a8d2c2c21149a79"];
    var_cf8192ca = content_manager::spawn_script_model(var_c4b6fa2d[0], #"p9_zm_out_fishing_01_bobber", 0);
    assert(isDefined(spawn_struct.contentgroups[# "hash_61b2fec1f617bb75"]), "<dev string:x87>");
    var_df283c09 = spawn_struct.contentgroups[# "hash_61b2fec1f617bb75"];
    var_9fadc93c = var_df283c09[0];
    forward = anglesToForward(var_16129dba.angles);
    forward = vectornormalize(forward);
    forward = (forward[0] * 8, forward[1] * 8, forward[2] * 8);
    forward = (forward[0], forward[1], forward[2] + 16);
    trigger = content_manager::spawn_interact(spawn_struct, &function_e126c567, #"hash_6ca9ecf6df3b77ed", 0, isDefined(spawn_struct.radius) ? spawn_struct.radius : 94, isDefined(spawn_struct.height) ? spawn_struct.height : 94, undefined, forward);
    trigger.var_16129dba = var_16129dba;
    trigger.var_cf8192ca = var_cf8192ca;
    trigger.var_9fadc93c = var_9fadc93c;
    trigger.var_1dfa9e6 = var_1dfa9e6;
    var_cf8192ca.var_ccd7223 = var_cf8192ca.origin;
    var_cf8192ca hide();
    playsoundatposition(#"hash_20c4f0485930af2a", struct.origin);
    var_16129dba function_619a5c20();
  }
}

function function_1cbcfab5(player) {
  if(!isalive(player)) {
    return false;
  }

  if(player laststand::player_is_in_laststand()) {
    return false;
  }

  if(is_true(player.is_reviving_any)) {
    return false;
  }

  if(is_true(player.var_b895a3ff)) {
    return false;
  }

  if(player function_104d7b4d()) {
    return false;
  }

  if(player isplayerunderwater()) {
    return false;
  }

  if(!player isonground()) {
    return false;
  }

  if(player getstance() == "prone") {
    self sethintstring(#"hash_10249865c7d6aeb8");
    return false;
  }

  if(player isswitchingweapons()) {
    return false;
  }

  currentweapon = player getcurrentweapon();

  if(isDefined(currentweapon) && currentweapon != level.weaponnone) {
    if(currentweapon.isdualwield) {
      self sethintstring(#"hash_7837638f250e6186");
      return false;
    }

    if(killstreaks::is_killstreak_weapon(currentweapon)) {
      self sethintstring(#"hash_189973fb11ef10ea");
      return false;
    }
  } else {
    return false;
  }

  return true;
}

function function_2bf9274() {
  self notify("6903aa98af509547");
  self endon("6903aa98af509547");
  self endon(#"death");
  wait 1;
  self sethintstring(#"hash_6ca9ecf6df3b77ed");
}

function function_e126c567(eventstruct) {
  if(!isDefined(self.isfishing)) {
    self.isfishing = 0;
  } else if(self.isfishing) {
    return;
  }

  if(game.state != # "playing") {
    return;
  }

  player = eventstruct.activator;

  if(isDefined(self.var_cf8192ca) && isDefined(self.var_16129dba) && isDefined(self) && isDefined(self.var_9fadc93c) && isPlayer(player)) {
    var_a8ad3bed = self function_1cbcfab5(player);

    if(!var_a8ad3bed) {
      self thread function_2bf9274();
      self playsoundtoplayer(#"uin_default_action_denied", player);
      return;
    }

    player val::set(#"fishing", "freezecontrols_allowlook", 1);
    self sethintstring("");
    self.isfishing = 1;
    var_16129dba = self.var_16129dba;
    var_cf8192ca = self.var_cf8192ca;
    var_9fadc93c = self.var_9fadc93c;
    var_cf8192ca show();
    var_16129dba hide();
    var_cdef1b0e = var_cf8192ca.origin;
    var_da4747b7 = var_9fadc93c.origin;
    var_9f816ad8 = var_cdef1b0e - var_16129dba.origin;
    var_82bf9f7b = vectortoangles(var_9f816ad8);
    player setplayerangles(var_82bf9f7b);
    var_cf8192ca.origin = var_9fadc93c.origin;
    player zm_aat::function_bf51f3cc();

    if(player util::is_female()) {
      player playboast("boast_gone_fishing_fem");
    } else {
      player playboast("boast_gone_fishing");
    }

    var_cf8192ca.dropping_item = 0;
    var_cf8192ca thread function_b828bd39(player, var_cdef1b0e);
    player thread function_16e4e507(var_16129dba, var_cf8192ca, self, var_da4747b7);
  }
}

function fake_physicslaunch(start_pos, target_pos, power) {
  dist = distance(start_pos, target_pos);
  time = dist / power;
  delta = target_pos - start_pos;
  up = (0, 0, dist);
  velocity = delta + up;
  self movegravity(velocity, time);
  return time;
}

function function_86edc85c(target_pos, maxwait = 2) {
  self endon(#"death");
  var_1dd010d6 = gettime();

  while(true) {
    if(self.origin[2] < target_pos[2] || float(gettime() - var_1dd010d6) / 1000 > maxwait) {
      break;
    }

    waitframe(1);
  }
}

function function_b828bd39(player, var_cdef1b0e) {
  if(!isPlayer(player)) {
    return;
  }

  self endon(#"death", #"fishing_done");
  player endon(#"death", #"disconnect");
  wait 2.1;
  var_95981760 = self fake_physicslaunch(self.origin, var_cdef1b0e, 120);
  self function_86edc85c(var_cdef1b0e, var_95981760);
  self thread fishing_buoy_splash(var_cdef1b0e);
  self moveto(var_cdef1b0e, 2);
  self waittill(#"movedone");
  self.origin = var_cdef1b0e;
  self.var_3fa8a746 = 0;

  while(player function_15049d95() && !self.dropping_item) {
    time = randomintrange(5, 7);
    wait time;
    self.var_3fa8a746 = 1;
    player function_bc82f900("fishing_rumble");
    playsoundatposition(#"hash_5784befa5a563866", player.origin);
    self thread fishing_buoy_splash();
    new_pos = self.origin + (0, 0, -5);
    self moveto(new_pos, 0.5);
    self waittill(#"movedone");
    new_pos = self.origin + (0, 0, 5);
    self moveto(new_pos, 0.5);
    self waittill(#"movedone");
    self.var_3fa8a746 = 0;
    waitframe(1);
  }
}

function fishing_buoy_splash(pos_override) {
  if(isDefined(pos_override)) {
    var_3cd73ec2 = (pos_override[0], pos_override[1], pos_override[2] + 4);
  } else {
    var_3cd73ec2 = (self.origin[0], self.origin[1], self.origin[2] + 4);
  }

  playFX(#"hash_3ad34e873c6a533", var_3cd73ec2);
}

function function_16e4e507(var_558f00ed, var_886a6495, trigger, var_da4747b7) {
  self endoncallback(&function_73532e4f, #"death", #"disconnect", #"entering_last_stand");
  self.var_558f00ed = var_558f00ed;
  self.var_886a6495 = var_886a6495;
  self.var_995e72b4 = trigger;

  if(isDefined(trigger.var_1dfa9e6)) {
    var_1dfa9e6 = trigger.var_1dfa9e6;
  }

  time = gettime();
  var_b4faf38e = 0;
  self zm_equipment::show_hint_text(#"hash_6035867d520cafed");

  while(self function_15049d95()) {
    if(is_true(self.var_16735873) || self isplayerunderwater() || self stancebuttonPressed() || self jumpbuttonPressed()) {
      var_bca1290f = 1;

      if(isDefined(var_886a6495)) {
        var_886a6495 hide();
      }

      self stopallboasts(1);
      break;
    }

    if(self attackButtonPressed()) {
      if(isDefined(var_886a6495)) {
        var_b4faf38e = gettime();
        time_diff = var_b4faf38e - time;

        if(is_true(var_886a6495.var_3fa8a746) && float(time_diff) / 1000 > 1) {
          if(var_886a6495.dropping_item === 0) {
            var_886a6495.dropping_item = 1;
            var_886a6495 function_e8c63c15(self, var_da4747b7, trigger.numuses);
            var_886a6495 hide();
            self stopallboasts();
            break;
          }
        } else {
          var_886a6495 hide();
          self stopallboasts();
          break;
        }
      }

      waitframe(1);
    }

    if(isDefined(trigger)) {
      if(distance2d(trigger.origin, self.origin) > 94) {
        self stopallboasts();
        break;
      }
    }

    waitframe(1);
  }

  self thread function_a543f4d1();
  self val::reset(#"fishing", "freezecontrols_allowlook");

  if(isDefined(trigger)) {
    if(!isDefined(trigger.numuses)) {
      trigger.numuses = 0;
    }

    var_3f9d3194 = getdvarint(#"hash_2501edebf4b8b5d9", 0);

    if(!is_true(var_bca1290f) && !var_3f9d3194) {
      trigger.numuses++;
    }

    if(trigger.numuses >= 3) {
      if(isDefined(var_558f00ed) && isDefined(trigger) && isDefined(var_886a6495)) {
        var_886a6495 notify(#"fishing_done");
        trigger deletedelay();
        var_558f00ed clientfield::set("set_compass_icon", 0);
      }

      wait 2;

      if(isDefined(var_558f00ed) && isDefined(var_886a6495)) {
        var_558f00ed hide();
        playFX(#"hash_6afe37492bc21f7f", var_558f00ed.origin);
        var_558f00ed deletedelay();
        var_886a6495 deletedelay();
      }

      if(isDefined(var_1dfa9e6)) {
        var_1dfa9e6 deletedelay();
      }

      return;
    }

    if(isDefined(var_886a6495) && isDefined(var_558f00ed)) {
      wait 1.7;

      if(isDefined(var_886a6495) && isDefined(trigger) && isDefined(var_558f00ed)) {
        trigger.isfishing = 0;
        var_886a6495.isfishing = 0;
        var_886a6495 notify(#"fishing_done");
        var_886a6495.origin = var_886a6495.var_ccd7223;
        var_886a6495 hide();
        var_558f00ed show();
        trigger sethintstring(#"hash_6ca9ecf6df3b77ed");
      }
    }
  }
}

function function_a543f4d1() {
  self endon(#"death");
  wait 1.7;
  self zm_aat::function_ec7953fa();
}

function function_73532e4f(str_notify) {
  self stopallboasts(1);
  self val::reset(#"fishing", "freezecontrols_allowlook");

  if(isDefined(self.var_558f00ed)) {
    self.var_558f00ed show();
  }

  if(isDefined(self.var_886a6495)) {
    self.var_886a6495 notify(#"fishing_done");
    self.var_886a6495.origin = self.var_886a6495.var_ccd7223;
    self.var_886a6495 hide();
    self.var_886a6495.isfishing = 0;
  }

  if(isDefined(self.var_995e72b4)) {
    self.var_995e72b4.isfishing = 0;
    self.var_995e72b4 sethintstring(#"hash_6ca9ecf6df3b77ed");
  }
}

function function_e8c63c15(player, var_da4747b7, index = 0) {
  if(isPlayer(player)) {
    player zm_stats::increment_challenge_stat(#"hash_3a35f1174ff0dfe1");
    var_3cd73ec2 = (self.origin[0], self.origin[1], self.origin[2] + 4);
    playFX(#"hash_3fc2ee8740a6f52", var_3cd73ec2);
    dropstruct = {
      #origin: self.origin, #angles: self.angles
    };

    switch (index) {
      case 1:
        var_da4747b7 = (var_da4747b7[0], var_da4747b7[1] + 64, var_da4747b7[2]);
        break;
      case 2:
        var_da4747b7 = (var_da4747b7[0], var_da4747b7[1] - 64, var_da4747b7[2]);
        break;
    }

    var_8e313b1c = getdvarint(#"hash_1317b91cdefa1238", 0);

    if(!var_8e313b1c) {
      dropitems = dropstruct namespace_65181344::function_fd87c780(#"zm_fishing_parent_list", 1, 0);
    }

    if(!isDefined(dropitems) || dropitems.size === 0 || var_8e313b1c) {
      model = util::spawn_model(#"hash_6290596be2341e21", dropstruct.origin, dropstruct.angles);
      playFXOnTag(#"hash_20b3d352fb23155c", model, "tag_origin");
      model thread function_c5c1b1fe(self.origin, var_da4747b7, player, 1);
      return;
    }

    foreach(dropitem in dropitems) {
      dropitem.var_864ea466 = 1;
      dropitem.var_a5626281 = 1;
      dropitem thread function_c5c1b1fe(self.origin, var_da4747b7, player);
    }
  }
}

function private on_item_pickup(params) {
  if(isPlayer(self)) {
    e_player = self;
  } else {
    e_player = params.player;
  }

  if(isPlayer(e_player) && is_true(params.item.var_a5626281)) {
    e_player zm_stats::function_7ec42fbf(#"hash_3c5a993c0208d6a6");
  }
}

function function_c5c1b1fe(start_pos, end_pos, player, var_ecf3bd81 = 0) {
  self endon(#"death");
  player = (player[0], player[1], player[2] + 4);
  var_22fb8377 = self fake_physicslaunch(end_pos, player, 200);
  wait 1;
  timepassed = gettime();

  while(self.origin[2] > player[2] && float(gettime() - timepassed) / 1000 < var_22fb8377) {
    waitframe(1);
  }

  time = self namespace_b637a3ed::drop_item(0, player, (0, 0, 0), 2);
  wait time;

  if(var_ecf3bd81) {
    self thread function_eaa298d9();
    return;
  }

  self.var_864ea466 = undefined;
}

function function_eaa298d9() {
  self endon(#"death");
  wait 1;
  pointinfo = function_9cc082d2(self.origin, 32);

  if(isDefined(pointinfo) && isDefined(pointinfo[# "point"])) {
    navmeshposition = pointinfo[# "point"];
    var_9905e63e = spawnStruct();
    var_9905e63e.origin = navmeshposition;
    boot = mimic_prop_spawn::spawn_prop(var_9905e63e, undefined, #"hash_6290596be2341e21", 1);
    prop_array = [];

    if(!isDefined(prop_array)) {
      prop_array = [];
    } else if(!isarray(prop_array)) {
      prop_array = array(prop_array);
    }

    prop_array[prop_array.size] = boot;
    mimic_prop_spawn::function_55657fb4(undefined, boot, prop_array);
  }

  self deletedelay();
}

function function_ff1fe53a(params) {
  if(!isPlayer(params.player) || !params.player function_15049d95()) {
    return;
  }

  params.player stopallboasts();
}