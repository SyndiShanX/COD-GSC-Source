/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1ea5c1aec36ac889.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm\archetype\archetype_zod_companion;
#using scripts\zm\perk\zm_perk_tombstone;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace namespace_33c196c8;

function private autoexec __init__system__() {
  system::register(#"hash_1555c697c02263a7", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_b617b3fe = getweapon(#"hash_7993749c94189bd9");
  clientfield::register("scriptmover", "" + # "hash_547dd74a97b1fdba", 24000, 2, "int");
  weaponobjects::function_e6400478(#"hash_7993749c94189bd9", &function_c3a836cd, 1);
  zm_perk_tombstone::function_7c589e7("tactical", #"hash_7ada82abc5dad90e");
  callback::on_item_pickup(&function_18140c5c);
  callback::on_bleedout(&function_7128234b);
  callback::on_disconnect(&function_7128234b);

  level thread function_63a18814();
}

function function_18140c5c(params) {
  item = params.item;

  if(!isDefined(item) || item.itementry.name !== # "hash_7ada82abc5dad90e") {
    return;
  }

  self function_28a8ddad();
  self.var_310a3632.var_c40de8a0 = 1;

  if(!is_true(self.var_dae38283)) {
    level thread flag::set_for_time(11, #"hash_4b065039d7f1a611");
    self thread zm_equipment::show_hint_text(#"hash_1f6b7e5529a8cccf", 10);
  }
}

function function_bad0c914(item) {
  if(item.itementry.itemtype === # "tactical") {
    tactical = self.inventory.items[13];

    if(tactical.itementry.name === # "hash_7ada82abc5dad90e") {
      return false;
    }
  }

  return true;
}

function function_b926dcfd(item) {
  var_2dad155c = self function_bad0c914(item);

  if(!var_2dad155c) {
    if(isDefined(item.count) && item.count > 0) {
      self.var_ac4c40a8 = item;
    }
  }

  return var_2dad155c;
}

function function_c3a836cd(watcher) {
  watcher.altdetonate = 1;
  watcher.var_e7ebbd38 = &function_eb6180c9;
}

function function_dec85954(str_vo, var_ac39950d = 0) {
  time = gettime();

  if(!var_ac39950d && isDefined(self.var_dd756dc) && time < self.var_dd756dc) {
    return;
  }

  var_59c3e157 = str_vo == "zber_mq4_cmdstp";
  self clientfield::set("" + # "hash_703543ca871a0f75", 2);
  e_leader = self.leader;

  if(isDefined(e_leader) && !var_59c3e157) {
    e_leader zm_vo::function_7622cb70(str_vo, 0, 0);
  } else if(var_59c3e157) {
    self zm_vo::function_d6f8bbd9("vox_" + str_vo + "_klau", 0, undefined, 0);
  }

  if(isDefined(self)) {
    self clientfield::set("" + # "hash_703543ca871a0f75", 1);
    self.var_dd756dc = time + 10000;
  }
}

function function_eb6180c9(watcher) {
  if(isDefined(level.var_b617b3fe) && self hasweapon(level.var_b617b3fe)) {
    if(!isDefined(level.klaus.defend_location)) {
      return;
    }

    if(isDefined(level.klaus)) {
      level.klaus zodcompanionutility::function_34179e9a();
      level.klaus thread function_dec85954("zber_kvo_cmdflw");
    }

    self notify(#"hash_65d1a61342635458");
    self gestures::function_56e00fbf(#"hash_7e249c3769936b51", undefined, 1);
  }
}

function private function_d6f65535(str_notify) {
  if(isDefined(self.var_310a3632.mdl_target)) {
    self.var_310a3632.mdl_target notify(#"hash_7adeef9b9b822b42");
    self.var_310a3632.mdl_target clientfield::set("" + # "hash_547dd74a97b1fdba", 0);
  }
}

function private function_67c8b5c3() {
  level endoncallback(&function_d6f65535, #"hash_279a97271de2b7e1");
  self endoncallback(&function_d6f65535, #"disconnect", #"hash_7b63ce1ec3e195b4", #"hash_65d1a61342635458");
  waitresult = self waittill(#"offhand_end", #"hash_7f812cfd98c00a7b");

  if(waitresult._notify === # "hash_7f812cfd98c00a7b" && isDefined(level.klaus) && !level.klaus flag::get(#"hash_3218e127380e4a29")) {
    level.klaus waittill(#"death", #"hash_3218e127380e4a29", #"hash_6edebe8930290c3b");
  }

  self function_d6f65535();
}

function private function_28a8ddad() {
  if(!isDefined(self.var_310a3632)) {
    self.var_310a3632 = {};
  }

  if(!isDefined(self.var_310a3632.mdl_target)) {
    self.var_310a3632.mdl_target = util::spawn_model("tag_origin", self.origin);
  }
}

function private function_7128234b() {
  e_target = self.var_310a3632.mdl_target;

  if(isDefined(e_target)) {
    self function_d6f65535();
    util::wait_network_frame();

    if(isDefined(e_target)) {
      e_target deletedelay();
    }
  }
}

function private function_b864b947(var_72c2d810) {
  return isDefined(var_72c2d810) && zm_utility::check_point_in_playable_area(var_72c2d810);
}

function private function_9132ad8e() {
  v_start = self getplayercamerapos();
  v_forward = anglesToForward(self getplayerangles());
  v_end = v_start + v_forward * 1200;
  a_trace = bulletTrace(v_start, v_end, 0, self.var_310a3632.mdl_target, 1, 0);

  if(a_trace[#"fraction"] == 1) {
    a_trace = bulletTrace(v_end, v_end - (0, 0, 40), 0, self.var_310a3632.mdl_target, 1, 0);
  }

  v_hit = a_trace[#"position"] + (0, 0, 8);

  if(a_trace[#"fraction"] < 1) {
    var_5c65b47a = self getpathfindingradius();
    var_20fe4148 = getclosestpointonnavmesh(v_hit, 32, var_5c65b47a);
  }

  self.var_310a3632.var_689f4026 = v_hit;
  self.var_310a3632.var_6164d302 = var_20fe4148;
}

function private function_b66d4fac() {
  self notify("28e12eeb6d841b74");
  self endon("28e12eeb6d841b74");
  self endon(#"death", #"disconnect", #"offhand_end", #"hash_7f812cfd98c00a7b", #"hash_65d1a61342635458");
  self.var_310a3632.mdl_target endon(#"death");

  while(true) {
    self function_9132ad8e();
    self.var_310a3632.mdl_target moveto(self.var_310a3632.var_689f4026, float(function_60d95f53()) / 1000);
    b_valid = function_b864b947(self.var_310a3632.var_6164d302);
    self.var_310a3632.mdl_target clientfield::set("" + # "hash_547dd74a97b1fdba", is_true(b_valid) ? 1 : 2);
    wait 0.1;

    debugstar(self.var_310a3632.mdl_target.origin);

    if(isDefined(self.var_310a3632.var_6164d302)) {
      debugstar(self.var_310a3632.var_6164d302, 10, (1, 1, 0));
    }
  }
}

function event_handler[grenade_pullback] function_8d10e176(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  weapon = eventstruct.weapon;

  if(weapon.name == # "hash_7993749c94189bd9") {
    self function_28a8ddad();
    self notify(#"hash_7b63ce1ec3e195b4");
    self function_9132ad8e();
    self.var_310a3632.mdl_target dontinterpolate();
    self.var_310a3632.mdl_target.origin = self.var_310a3632.var_689f4026;
    self thread function_67c8b5c3();
    self thread function_b66d4fac();
  }
}

function event_handler[grenade_fire] function_6ed5772c(eventstruct) {
  if(!isPlayer(self)) {
    return;
  }

  weapon = eventstruct.weapon;

  if(weapon.name == # "hash_7993749c94189bd9") {
    assert(isDefined(self.var_310a3632.var_689f4026));
    var_72c2d810 = self.var_310a3632.var_6164d302;

    if(isDefined(level.klaus) && level flag::get(#"hash_279a97271de2b7e1")) {
      if(function_b864b947(var_72c2d810)) {
        b_valid = level.klaus zodcompanionutility::function_fc7a4f48(var_72c2d810, 1);
      }

      if(is_true(b_valid)) {
        var_52e2c28d = 0;

        if(isDefined(level.var_3537dbe0)) {
          var_52e2c28d = [[level.var_3537dbe0]](var_72c2d810);
        }

        if(!is_true(var_52e2c28d)) {
          level.klaus thread function_dec85954("zber_kvo_cmdloc");
        }
      } else {
        level.klaus thread function_dec85954("zber_kvo_invloc");
      }
    }

    if(is_true(b_valid)) {
      self.var_310a3632.mdl_target util::delay(0.1, array("death", #"hash_7adeef9b9b822b42"), &clientfield::set, "" + # "hash_547dd74a97b1fdba", 3);
      self notify(#"hash_7f812cfd98c00a7b");

      if(is_true(self.var_310a3632.var_c40de8a0)) {
        level thread flag::set_for_time(4.33333, #"hash_4b065039d7f1a611");
        self thread zm_equipment::show_hint_text(#"hash_2a5df406bca21527", 3.33333);
        self.var_310a3632.var_c40de8a0 = 0;
      }

      debugstar(var_72c2d810, 60, (0, 1, 0));
    } else {
      self notify(#"hash_65d1a61342635458");

      debugstar(self.var_310a3632.var_689f4026, 60, (1, 0, 0));
    }

    self.var_310a3632.var_689f4026 = undefined;
    self.var_310a3632.var_6164d302 = undefined;
  }
}

function function_72d0f075(str_notify) {
  if(isDefined(self.var_ac4c40a8)) {
    slot = self item_inventory::function_e66dcff5(self.var_ac4c40a8);
    self item_world::function_de2018e3(self.var_ac4c40a8, self, slot);
    self.var_ac4c40a8 = undefined;
  }
}

function function_e7136ed2(e_player) {
  if(!isPlayer(e_player)) {
    return;
  }

  self notify("633fc05006b4b4e2");
  self endon("633fc05006b4b4e2");
  e_player endon(#"death", #"disconnect");
  e_player endoncallback(&function_72d0f075, #"hash_270df214e38d07c");
  e_player notify(#"hash_480c9c9aa7da8306");
  point = function_4ba8fde(#"hash_7ada82abc5dad90e");
  slot = e_player item_inventory::function_e66dcff5(point);
  item = e_player.inventory.items[slot];

  if(item.itementry.weapon.name === # "hash_7993749c94189bd9") {
    return;
  }

  if(item.itementry.weapon === e_player getcurrentoffhand()) {
    e_player val::set_for_time(0.2, #"hash_7f812cfd98c00a7b", "disable_offhand_weapons", 1);
  }

  if(item.networkid != 32767 && e_player item_inventory::function_c48cd17f(item.networkid) != 32767) {
    while(!e_player item_inventory::remove_inventory_item(item.networkid)) {
      waitframe(1);
    }

    if(isDefined(item.count) && item.count > 0) {
      e_player.var_ac4c40a8 = item;
    }

    waitframe(1);
  }

  e_player val::reset_all(#"hash_7f812cfd98c00a7b");
  profilestart();
  e_player item_world::function_de2018e3(point, e_player, slot);
  e_player function_28a8ddad();
  profilestop();
}

function function_2d3ad651(e_player) {
  if(!isPlayer(e_player)) {
    return;
  }

  self notify("3ce2e75fc4d0d9ea");
  self endon("3ce2e75fc4d0d9ea");
  e_player endon(#"death", #"disconnect", #"hash_480c9c9aa7da8306");
  level thread flag::set_for_time(11, #"hash_4b065039d7f1a611");
  e_player thread zm_equipment::show_hint_text(#"hash_710a20a786d1e08c", 10);
  e_player notify(#"hash_270df214e38d07c");
  point = function_4ba8fde(#"hash_7ada82abc5dad90e");
  slot = e_player item_inventory::function_e66dcff5(point);
  item = e_player.inventory.items[slot];

  if(item.itementry.weapon.name === # "hash_7993749c94189bd9") {
    if(item.itementry.weapon === e_player getcurrentoffhand()) {
      e_player val::set_for_time(0.2, #"hash_e1a1061308a8a71", "disable_offhand_weapons", 1);
    }

    while(!e_player item_inventory::remove_inventory_item(item.networkid)) {
      waitframe(1);
    }

    waitframe(1);
    e_player val::reset_all(#"hash_e1a1061308a8a71");
  } else {
    return;
  }

  profilestart();
  e_player thread function_7128234b();
  e_player function_72d0f075();
  profilestop();
}

function function_63a18814() {
  util::add_debug_command("<dev string:x38>");
  util::add_debug_command("<dev string:x9d>");
  zm_devgui::add_custom_devgui_callback(&cmd);
}

function cmd(cmd) {
  switch (cmd) {
    case # "hash_4b0f351e219eb41b":
      function_605ea132();
      break;
    case # "hash_53a8b6448d2d9f11":
      function_f4e829d6();
      break;
    default:
      break;
  }
}

function function_605ea132() {
  player = getplayers()[0];
  level thread function_e7136ed2(player);
}

function function_f4e829d6() {
  player = getplayers()[0];
  level thread function_2d3ad651(player);
}