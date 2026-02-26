/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_platinum_ww_quest.gsc
***********************************************/

#using script_100835406ec3feaf;
#using script_1ea5c1aec36ac889;
#using script_3411bb48d41bd3b;
#using script_448683444db21d61;
#using script_56731c09a921b64e;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm\archetype\archetype_zod_companion;
#using scripts\zm\zm_platinum_vo;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_intel;
#using scripts\zm_common\zm_sq;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace zm_platinum_ww_quest;

function init() {
  clientfield::register("toplayer", "" + # "hash_548794e256c5bad6", 24000, 1, "int");
  function_f8a8ff3f();
  level thread function_1b65b01d();
  level thread function_743996c0();
  callback::on_item_pickup(&function_b0952594);
}

function function_1b65b01d() {
  level zm_sq::register(#"ww_quest", #"step_1", #"hash_3cfd69dc67bdcf69", &function_c6de5d3d, &function_863fc0f1);
  level zm_sq::register(#"ww_quest", #"step_2", #"hash_3cfd66dc67bdca50", &function_1168e497, &function_4320379c);
  level flag::wait_till(#"start_zombie_round_logic");
  level thread zm_sq::start(#"ww_quest", 1);

  iprintlnbold("<dev string:x38>");
}

function function_c6de5d3d(b_skipped) {
  level endon(#"end_game");

  if(b_skipped) {
    return;
  }

  var_be8a80d6 = getent("black_light_locker", "targetname");
  var_be8a80d6 val::set("locker", "takedamage", 1);
  var_da02bd54 = struct::get(var_be8a80d6.target, "targetname");
  slots = [];
  slots[slots.size] = {
    #origin: var_da02bd54.origin, #on_navmesh: 1
  };
  var_be8a80d6.is_active = 1;
  var_be8a80d6.var_b79a8ac7 = {
    #var_f019ea1a: 200, #slots: slots
  };
  var_2ad81caf = spawn("trigger_damage", var_be8a80d6.origin, 0, 64, 80);

  var_a406cb50 = 32;
  box(var_be8a80d6.origin, (var_a406cb50 * -1, var_a406cb50 * -1, 0), (var_a406cb50, var_a406cb50, 80), 0, (1, 0, 0), 1, 0, 20000);

  level flag::wait_till(#"hash_720384d338d58cf4");

  if(isDefined(level.klaus)) {
    level.klaus zodcompanionutility::function_fc67b7ed(&function_ce3b7324);
  }

  var_2ad81caf thread function_7c943428(var_be8a80d6);
  level thread function_3eafd069(var_be8a80d6);
  var_be8a80d6 waittill(#"locker_opened");
  var_be8a80d6 function_619a5c20();
}

function function_863fc0f1(b_skipped, var_19e802fa) {
  if(b_skipped || var_19e802fa) {
    var_be8a80d6 = getent("black_light_locker", "targetname");
    level thread function_3eafd069(var_be8a80d6);
    var_be8a80d6 thread scene::play("p9_fxanim_platinum_lockers_metal_tall_bundle", var_be8a80d6);
    var_be8a80d6 notify(#"locker_opened");
    var_be8a80d6 function_619a5c20();
  }
}

function function_ce3b7324() {
  level endon(#"end_game", #"hash_2304a1d24bb8597f");
  self notify("31f8a60a0dc24d9d");
  self endon("31f8a60a0dc24d9d");
  var_be8a80d6 = getent("black_light_locker", "targetname");
  dis = distance(self.origin, var_be8a80d6.origin);

  if(dis <= 200) {
    if(isDefined(level.klaus)) {
      level.klaus thread namespace_33c196c8::function_dec85954("zber_kvo_cmdint", 1);
    }

    namespace_85745671::function_a31a41e8(self, var_be8a80d6);

    iprintlnbold("<dev string:x4a>");
  }
}

function function_7c943428(var_f345d85) {
  level endon(#"end_game");

  while(true) {
    waitresult = self waittill(#"damage");

    if(waitresult.attacker === level.klaus && isDefined(level.klaus.attackable)) {
      iprintlnbold("<dev string:x5f>");

      playFX(#"hash_4752fa601bfee5fb", waitresult.position, anglesToForward((0, 180, 0)), (0, 0, 1));
      var_f345d85.is_active = 0;
      var_f345d85.var_b79a8ac7 = undefined;
      namespace_85745671::function_2b925fa5(level.klaus);
      break;
    }
  }

  if(isDefined(level.klaus)) {
    level.klaus zodcompanionutility::function_30df05d5(&function_ce3b7324);
  }

  var_f345d85 thread scene::play("p9_fxanim_platinum_lockers_metal_tall_bundle", var_f345d85);
  var_f345d85 notify(#"locker_opened");
  self deletedelay();
}

function function_3eafd069(entity) {
  level endon(#"end_game");
  entity waittill(#"locker_opened");
  s_trigger_pos = struct::get(entity.target, "targetname");

  iprintlnbold("<dev string:x70>");

  var_e03eac13 = s_trigger_pos zm_unitrigger::create(&function_56b196db, 32, &function_bb30710d);
  zm_unitrigger::unitrigger_force_per_player_triggers(var_e03eac13, 1);
  var_e03eac13.origin += (0, 0, 35);
  var_e03eac13.vo_string = zm_platinum_vo::function_c5fed573([#"hash_253b4ad2f1c726c7", #"hash_253b4bd2f1c7287a", #"hash_253b4cd2f1c72a2d"], [#"hash_2569b41becd226e3", #"hash_2569b51becd22896", #"hash_2569b61becd22a49"], [#"hash_456525933756ae59", #"hash_456522933756a940", #"hash_456523933756aaf3"]);
}

function function_56b196db(e_player) {
  if(is_true(e_player.var_c6af46f9)) {
    return false;
  }

  if(isPlayer(e_player)) {
    self sethintstringforplayer(e_player, #"hash_22569dcd09aa7bf9");
    return true;
  }

  return false;
}

function function_bb30710d() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(isPlayer(player)) {
      player.var_c6af46f9 = 1;
      player.var_19f4406e = 2;
      player flag::set(#"hash_2d6980738132f263");
      player thread zm_equipment::show_hint_text(#"hash_77929503066a286b", 10);
      player playSound(#"hash_6d7a3786a05ee05d");
      player clientfield::set_to_player("" + # "hash_548794e256c5bad6", 1);

      if(isDefined(self.stub.vo_string)) {
        player thread zm_vo::function_7622cb70(self.stub.vo_string);
      }

      break;
    }
  }
}

function function_743996c0() {
  level.var_6a086277 = getent("ww_safe", "targetname");
  level.safe_trigger = struct::get(level.var_6a086277.target, "targetname");
  level.var_2a616939 = level.safe_trigger zm_unitrigger::create(&function_fb9b5ce9, 40, &function_46c3c6ea);
  zm_unitrigger::unitrigger_force_per_player_triggers(level.var_2a616939);
  level.var_6a086277 thread function_58b582cc();
  level flag::wait_till(#"hash_358a79602429d556");
  var_222825ae = struct::get("wonder_weapon_position", "targetname");
  point = function_4ba8fde(#"ww_mega_barrel_fullauto_copycat_t9_item_sr");
  wonder_weapon = getweapon(#"ww_mega_barrel_fullauto_copycat_t9");
  item_ww = item_drop::drop_item(0, wonder_weapon, 1, 0, point.id, var_222825ae.origin, var_222825ae.angles, 0);
  item_ww.var_dd21aec2 = 1 | 16;
  item_ww.var_2f21f7ff = 1;
  item_ww.itementry.var_fa988b4b = undefined;
  item_ww.amount = isDefined(wonder_weapon.clipsize) ? wonder_weapon.clipsize : 25;
  spawncollision(#"collision_clip_32x32x128", "collider", (-4058.5, 9117.75, 420), (0, 230, 0));
  level.var_6a086277 scene::play(#"hash_5a121f0591383986", "play", level.var_6a086277);
}

function function_58b582cc() {
  level endon(#"end_game");

  while(!level flag::get(#"hash_2476cb923dc327b4")) {
    players = function_a1ef346b();

    if(players.size === 0) {
      wait 1;
      continue;
    }

    foreach(player in players) {
      dis = distance2dsquared(self.origin, player.origin);

      if(isDefined(dis) && dis <= sqr(100)) {
        player.var_54ddcd0c = 1;
        continue;
      }

      player.var_54ddcd0c = undefined;
    }

    wait 1;
  }

  foreach(player in getplayers()) {
    player.var_54ddcd0c = undefined;
  }
}

function function_1168e497(b_skipped) {
  if(b_skipped) {
    return;
  }

  result = level waittill(#"ww_pickup");
  who = result.player;

  foreach(player in getplayers()) {
    player.var_19f4406e = 0;
    player flag::set(#"hash_2d6980738132f263");
    player thread zm_equipment::show_hint_text(#"hash_77929503066a286b", 10);
  }

  who waittill(#"weapon_change_complete");
  wait 1;

  if(isPlayer(who)) {
    vo_index = who namespace_1e7573ec::function_d0aeb094();

    switch (vo_index) {
      case 0:
        vo = array::random([#"hash_583c41a2b612380e", #"hash_1d625335946802e9", #"hash_6cbf2db34581d6b4"]);
        break;
      case 1:
        vo = array::random([#"hash_c9d1aa3915d39bd", #"hash_3cc99f0f22f1987e", #"hash_6e1931deb01a0a33"]);
        break;
      case 2:
        vo = array::random([#"hash_3a3edf25e70502e4", #"hash_712e1bc526501323", #"hash_65b3aabbb42b2dee"]);
        break;
    }

    who namespace_1e7573ec::function_1340d9d6(vo);
  }

  wait 1;
  vo_string = zm_platinum_vo::function_c5fed573([#"hash_12f57fa94e2ecb4b", #"hash_12f580a94e2eccfe", #"hash_12f581a94e2eceb1"], [#"hash_28afd49c1c66c2a7", #"hash_28afd59c1c66c45a", #"hash_28afd69c1c66c60d"], [#"hash_6598d5bdcc96685d", #"hash_6598d2bdcc966344", #"hash_6598d3bdcc9664f7"]);
  level zm_vo::function_7622cb70(vo_string);
  level flag::set(#"hash_2476cb923dc327b4");
}

function function_4320379c(b_skipped, var_19e802fa) {
  if(b_skipped || var_19e802fa) {
    foreach(player in getplayers()) {
      player.var_19f4406e = 0;
      player flag::set(#"hash_2d6980738132f263");
    }

    level flag::set(#"hash_2476cb923dc327b4");
    level flag::set(#"hash_358a79602429d556");
  }

  zm_unitrigger::unregister_unitrigger(level.var_2a616939);
}

function function_fb9b5ce9(e_player) {
  if(!level flag::get(#"hash_358a79602429d556") && isPlayer(e_player)) {
    if(level flag::get(#"hash_7b5643f5ecc16c8f") || level flag::get(#"boss_fight_started")) {
      return false;
    }

    if(level flag::get(#"hash_1a103020b4fa4e2f")) {
      self sethintstringforplayer(e_player, #"hash_7c199160b79a2efe");
      return true;
    }

    if(e_player util::is_player_looking_at(level.var_6a086277.origin, 0.7, 0)) {
      if(!isDefined(level.var_a0657c54)) {
        self sethintstringforplayer(e_player, #"hash_341be5b4253023ae");
        return true;
      } else if(level.var_a0657c54 == e_player) {
        self sethintstringforplayer(e_player, #"hash_870fef240ee1356");
        return true;
      }
    }
  }

  return false;
}

function private function_50cbcfee(e_user) {
  level.zones[#"zone_hotel_jack_room"].is_spawning_allowed = 0;
  level.var_a0657c54 = e_user;
  level.var_a0657c54 function_8b40c670(self);
  level function_7d0eaace();

  if(isDefined(level.var_a0657c54.var_9e8e7b78)) {
    level.var_a0657c54.var_9e8e7b78 function_19a410e2(0);
    level.var_a0657c54.var_9e8e7b78 = undefined;
  }

  level.var_a0657c54 = undefined;
  level.zones[#"zone_hotel_jack_room"].is_spawning_allowed = 1;
}

function function_46c3c6ea() {
  level endon(#"end_game");
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger");
    player = waitresult.activator;

    if(level flag::get(#"hash_1a103020b4fa4e2f")) {
      continue;
    }

    if(!isDefined(level.var_a0657c54)) {
      self thread function_50cbcfee(player);
    }

    wait 0.5;
  }
}

function function_5681cdd() {
  level endon(#"end_game");
  level flag::set(#"hash_1a103020b4fa4e2f");
  level waittill(#"end_of_round");
  level flag::clear(#"hash_1a103020b4fa4e2f");
}

function function_b0952594(params) {
  item = params.item;

  if(!is_true(item.var_2f21f7ff)) {
    return;
  }

  if(isPlayer(self)) {
    if(isDefined(item.itementry)) {
      switch (item.itementry.name) {
        case # "ww_mega_barrel_fullauto_copycat_t9_item_sr":

          iprintlnbold("<dev string:x7f>");

          array::thread_all(getplayers(), &zm_intel::collect_intel, #"zmintel_platinum_requiem_artifact_02");
          level notify(#"ww_pickup", {
            #player: self
          });
          callback::remove_callback(#"on_item_pickup", &function_b0952594);
          break;
      }
    }
  }
}