/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_42fadda36015f142.gsc
*************************************************/

#using script_1feb0785278dafea;
#using script_3e31016b9c11a616;
#using script_9880b9dc28bc25e;
#using scripts\asm\asm;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\utility\player;
#namespace namespace_90dd012499e066d0;

function private autoexec function_290a60d1c3ea30ae() {
  level._effect["aethertear_zombie_splatter"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_blood_splatter");
  level._effect["aethertear_teleport_vfx"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_send_show");
  level._effect["aethertear_group_tele_disabled"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_loop_red");
  callback::add("ob_content_process_create_script", &function_c7ad39bbc70b6ba7);
  level.var_86f0e49ba2870e8 = [];
  setdvarifuninitialized(@ "hash_a4cd01277ab4f21c", 240);

  setdevdvarifuninitialized(@ "hash_69ef0e9b8d4ae1a1", 0);
  level thread function_1579c58eecb01b60();
}

function function_c7ad39bbc70b6ba7(params) {
  var_3896caed4076578e = getStructArray("aether_tear_tower", "script_noteworthy");

  foreach(tear in var_3896caed4076578e) {
    tear thread function_3d8ab62e7bb38919();
  }

  level.var_86f0e49ba2870e8 = var_3896caed4076578e;
}

function function_3d8ab62e7bb38919() {
  self endon("tower_tear_destroyed");
  self.despawntimer = 60;
  self.var_8f857ae285a07a32 = 0;
  self.var_e57f8945ec6d8a0c = [];
  self.tearused = 0;
  self.group_tear = 0;
  var_7ed98770f9a9ba95 = "ob_jup_aethertear_s5";

  if(function_c3e067fa87e1e9d1()) {
    self.group_tear = 1;
    var_7ed98770f9a9ba95 = "ob_jup_group_aethertear";
    self.var_db24c681e6d4e208 = getStructArray(self.target, "targetname");
    function_f57948e98f6e127f(self.var_db24c681e6d4e208);
  } else {
    if(!isDefined(self.target)) {
      point_height = getdvarfloat(@ "hash_50f18343f33b6153", 7000);
      self.var_e57f8945ec6d8a0c[0] = spawnStruct();
      self.var_e57f8945ec6d8a0c[0].origin = (self.origin[0], self.origin[1], self.origin[2] + point_height);
      self.var_e57f8945ec6d8a0c[0].angles = self.angles;
    } else {
      self.var_e57f8945ec6d8a0c = getStructArray(self.target, "targetname");
    }

    function_f57948e98f6e127f(self.var_e57f8945ec6d8a0c);
  }

  self.aethertear = spawnscriptable(var_7ed98770f9a9ba95, self.origin);
  self.aethertear.instance = self;

  if(isDefined(self.script_flag) && !flag(self.script_flag)) {
    self.aethertear.disabled = 1;
  } else {
    self.aethertear.disabled = 0;
  }

  if(istrue(self.aethertear.disabled)) {
    self.aethertear setscriptablepartstate("body_aethertear", "unusable");

    if(self.group_tear) {
      self.aethertear setscriptablepartstate("entrance_vfx_close", "off");
    } else {
      self.aethertear setscriptablepartstate("entrance_vfx_green", "off");
    }
  } else {
    self.aethertear setscriptablepartstate("body_aethertear", "usable");
    self.aethertear setscriptablepartstate("entrance_vfx", "on_rift_run");
  }

  if(istrue(self.group_tear)) {
    self.exit_vfx = spawnscriptable("ob_jup_aethertear_vfx", self.var_db24c681e6d4e208[0].origin);
  } else {
    avg_pos = agent_utils::getaverageorigin(self.var_e57f8945ec6d8a0c);
    self.exit_vfx = spawnscriptable("ob_jup_aethertear_vfx", avg_pos);
  }

  trigger_struct = spawnStruct();
  trigger_struct.origin = self.aethertear.origin - (0, 0, 15);
  trigger_struct.radius = isDefined(self.radius) ? int(self.radius) : 17;
  trigger_struct.height = isDefined(self.height) ? int(self.height) : 25;
  self.trigger = spawn("noent_volume_trigger_radius", trigger_struct.origin, 0, trigger_struct.radius, trigger_struct.height);

  if(istrue(self.group_tear)) {
    self.hinttrigger = spawn("noent_volume_trigger_radius", trigger_struct.origin + (0, 0, -400), 0, 800, 800);
  }

  thread function_b147c6e7b40b5c0c();
}

function function_b147c6e7b40b5c0c() {
  self endon("tower_tear_destroyed");
  self endon("despawning_tear");

  if(istrue(self.aethertear.disabled) && isDefined(self.script_flag)) {
    flag_wait(self.script_flag);
    part_name = istrue(self.group_tear) ? "entrance_vfx" : "entrance_vfx_green";
    self.aethertear setscriptablepartstate(part_name, "on_rift_run");
    self.aethertear setscriptablepartstate("body_aethertear", "usable");
  }

  if(istrue(self.group_tear)) {
    thread function_f1b9eb3a4fbb3e76();
    thread function_c0a40d7eb246c379();
  }

  while(true) {
    self.trigger waittill("trigger", ent);

    if(!isDefined(ent)) {
      continue;
    }

    if(!isPlayer(ent) && !isagent(ent)) {
      continue;
    }

    if(ent ent_flag("teleporting")) {
      continue;
    }

    if(istrue(self.group_tear)) {
      if(!isPlayer(ent)) {
        continue;
      }

      if(!istrue(self.var_a85a201f389c272c)) {
        continue;
      }

      if(isDefined(self.script_flag_set)) {
        flag_set(self.script_flag_set);
      }

      var_458b50e445194527 = function_18d8da04fcbae777();

      for(i = 0; i < var_458b50e445194527.size; i++) {
        var_458b50e445194527[i] function_20b01242856aa97c();
        level function_c4ab3b08781de0ed(var_458b50e445194527[i], undefined, self.var_db24c681e6d4e208[i], 1, undefined, undefined, 1);

        if(scripts\mp\utility\player::isinlaststand(var_458b50e445194527[i])) {
          var_458b50e445194527[i] thread namespace_f585f5e438cbdbc8::revive_player();
        }
      }

      continue;
    }

    if(isPlayer(ent)) {
      level function_c4ab3b08781de0ed(ent, self);
      continue;
    }

    if(isagent(ent) && ent function_332bd3a25e5c62e4()) {
      level thread function_a4a851b681286ada(ent, self);
    }
  }
}

function function_332bd3a25e5c62e4() {
  return isDefined(self.subclass) && (self.subclass == "zombie_base" || self.subclass == "zombie_base_armored_light" || self.subclass == "zombie_base_armored_heavy");
}

function function_778ff9a25743d1c1(structspawn) {
  self endon("tower_tear_destroyed");
  self endon("despawning_tear");
  self.hinttrigger = spawn("trigger_radius", structspawn.origin + (0, 0, -400), 0, 800, 800);

  if(istrue(self.aethertear.disabled) && isDefined(self.script_flag)) {
    flag_wait(self.script_flag);
    self.aethertear setscriptablepartstate("entrance_vfx", "on_rift_run");
    self.aethertear setscriptablepartstate("body_aethertear", "usable");
  }

  thread function_f1b9eb3a4fbb3e76();
  thread function_c0a40d7eb246c379();

  while(true) {
    self.trigger waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }

    if(ent ent_flag("teleporting")) {
      continue;
    }

    if(!istrue(self.var_a85a201f389c272c)) {
      continue;
    }

    if(isDefined(self.script_flag_set)) {
      flag_set(self.script_flag_set);
    }

    var_458b50e445194527 = function_18d8da04fcbae777();

    for(i = 0; i < var_458b50e445194527.size; i++) {
      level function_c4ab3b08781de0ed(var_458b50e445194527[i], undefined, self.var_db24c681e6d4e208[i], 1);

      if(scripts\mp\utility\player::isinlaststand(var_458b50e445194527[i])) {
        var_458b50e445194527[i] thread namespace_f585f5e438cbdbc8::revive_player();
      }
    }
  }
}

function function_c0a40d7eb246c379() {
  self endon("tower_tear_destroyed");
  self endon("despawning_tear");

  while(true) {
    self.var_a85a201f389c272c = 0;
    self.aethertear setscriptablepartstate("not_enough_players_vfx", "on");
    self.aethertear setscriptablepartstate("body_aethertear", "unusable");
    self.aethertear setscriptablepartstate("entrance_vfx", "closing");

    if(istrue(self.var_6563792235ab5016)) {
      wait 2;
    } else {
      self.var_6563792235ab5016 = 1;
      wait 0.5;
    }

    function_6ed1524727da6c3b();
    self.var_a85a201f389c272c = 1;
    self.aethertear setscriptablepartstate("not_enough_players_vfx", "off");
    self.aethertear setscriptablepartstate("entrance_vfx", "on_rift_run");
    self.aethertear setscriptablepartstate("body_aethertear", "usable");
    wait 10;
    function_ff917ac9cc1f824f();
  }
}

function function_6ed1524727da6c3b() {
  gt_timeout = getdvarint(@ "hash_a4cd01277ab4f21c", 240);

  while(true) {
    self.hinttrigger waittill("trigger", ent);

    if(!isPlayer(ent)) {
      continue;
    }

    if(time_has_passed(self.var_1f534e0659b0afd5, gt_timeout)) {
      return;
    }

    if(function_f7b7590040f773b() >= function_aadb5217bb5d3e0f()) {
      return;
    }
  }
}

function function_ff917ac9cc1f824f() {
  gt_timeout = getdvarint(@ "hash_a4cd01277ab4f21c", 240);

  while(true) {
    wait 1;
    nearby_players = function_f7b7590040f773b();

    if(time_has_passed(self.var_1f534e0659b0afd5, gt_timeout) && nearby_players > 0) {
      continue;
    }

    if(nearby_players < function_aadb5217bb5d3e0f()) {
      return;
    }
  }
}

function function_aadb5217bb5d3e0f() {
  num_players = 0;

  foreach(player in level.players) {
    if(scripts\mp\utility\player::isinlaststand(player)) {
      continue;
    }

    if(player.sessionstate == "playing_but_spectating") {
      continue;
    }

    if(player.sessionstate == "spectator") {
      continue;
    }

    if(player.sessionstate == "intermission") {
      continue;
    }

    num_players++;
  }

  return num_players;
}

function function_18d8da04fcbae777() {
  valid_players = [];

  foreach(player in level.players) {
    if(player.sessionstate == "playing_but_spectating") {
      continue;
    }

    if(player.sessionstate == "spectator") {
      continue;
    }

    if(player.sessionstate == "intermission") {
      continue;
    }

    valid_players = array_add(valid_players, player);
  }

  return valid_players;
}

function function_f7b7590040f773b() {
  var_2bbabdb25365d863 = 0;

  foreach(player in level.players) {
    if(player istouching(self.hinttrigger)) {
      var_2bbabdb25365d863++;
    }
  }

  return var_2bbabdb25365d863;
}

function function_f1b9eb3a4fbb3e76() {
  self endon("tower_tear_destroyed");
  self endon("despawning_tear");

  while(true) {
    self.hinttrigger waittill("trigger", ent);

    if(!isDefined(self.var_1f534e0659b0afd5)) {
      self.var_1f534e0659b0afd5 = gettime();
    }

    if(isPlayer(ent) && !ent ent_flag("teleporting") && !ent ent_flag("group_teleport_hint_shown")) {
      thread function_362a32745f74e7c4(ent);
    }
  }
}

function function_362a32745f74e7c4(player) {
  player endon("death_or_disconnect");
  player ent_flag_set("group_teleport_hint_shown");

  while(true) {
    wait 1;

    if(!player istouching(self.hinttrigger)) {
      break;
    }

    if(istrue(self.var_a85a201f389c272c)) {
      break;
    }

    player sethudtutorialmessage(&"JUP_OB_S5/QUEST_0_RIFT_S5_06_ASSEMBLE_SQUAD", 1);
  }

  player clearhudtutorialmessage();
  player ent_flag_clear("group_teleport_hint_shown");
}

function function_c4ab3b08781de0ed(player, tear_struct, var_e8183b24ad5d5ad6, var_876a08357da7cbe2, pit_teleport, force_freefall, var_e452cfbdc9df0595) {
  if(!isDefined(pit_teleport)) {
    pit_teleport = 0;
  }

  if(isDefined(tear_struct)) {
    tear_struct endon("tower_tear_destroyed");
  }

  player endon("death_or_disconnect");

  if(player scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return;
  }

  if(istrue(player.inlaststand) && !istrue(var_876a08357da7cbe2)) {
    return;
  }

  if(isDefined(tear_struct)) {
    tear_struct.var_8f857ae285a07a32++;
  }

  player val::set("aether_tear", "damage", 0);
  player ent_flag_set("teleporting");

  if(istrue(pit_teleport)) {
    if(soundexists("evt_entity_arena_respawn_teleport_plr")) {
      player playlocalsound("evt_entity_arena_respawn_teleport_plr");
    }
  } else if(soundexists("evt_ob_story_tear_teleport_plr")) {
    player playlocalsound("evt_ob_story_tear_teleport_plr");
  }

  if(isDefined(tear_struct) && isDefined(tear_struct.script_flag_set)) {
    flag_set(tear_struct.script_flag_set);
  }

  player freezecontrols(1);
  playFX(getfx("aethertear_teleport_vfx"), player.origin);
  player thread function_c39cc8ea8a52f609(1.25);

  if(!isDefined(var_e8183b24ad5d5ad6) && isDefined(tear_struct) && !istrue(tear_struct.group_tear)) {
    if(tear_struct.var_e57f8945ec6d8a0c.size == 1 || level.players.size == 1) {
      var_e8183b24ad5d5ad6 = tear_struct.var_e57f8945ec6d8a0c[0];
    } else {
      possible_dests = array_randomize(tear_struct.var_e57f8945ec6d8a0c);

      foreach(dest in possible_dests) {
        if(istrue(dest.in_use)) {
          continue;
        }

        clear = player scripts\engine\trace::player_trace_passed(dest.origin, dest.origin + (0, 0, 32), undefined, [player]);

        if(!istrue(clear)) {
          continue;
        }

        if(isDefined(dest.var_6fc5014d4400a943) && gettime() - dest.var_6fc5014d4400a943 <= 2000) {
          continue;
        }

        var_e8183b24ad5d5ad6 = dest;
      }

      if(!isDefined(var_e8183b24ad5d5ad6)) {
        var_e8183b24ad5d5ad6 = random(tear_struct.var_e57f8945ec6d8a0c);
      }
    }
  }

  level thread function_8f8fb8e62e444e81(player, tear_struct, var_e8183b24ad5d5ad6, pit_teleport, force_freefall, var_e452cfbdc9df0595);
  wait 0.2;
}

function function_8f8fb8e62e444e81(player, tear_struct, dest_str, pit_teleport, force_freefall, var_e452cfbdc9df0595) {
  if(!isDefined(dest_str) && isDefined(tear_struct) && isDefined(tear_struct.var_e57f8945ec6d8a0c)) {
    dest_str = random(tear_struct.var_e57f8945ec6d8a0c);
  }

  if(!isDefined(dest_str)) {
    assertmsg("<dev string:x1c>");
    player freezecontrols(0);
    player val::set("aether_tear", "damage", 1);
    player ent_flag_clear("teleporting");

    if(isDefined(tear_struct)) {
      tear_struct.var_8f857ae285a07a32--;
    }

    return;
  }

  dest_str.in_use = 1;
  wait 1;

  if(istrue(var_e452cfbdc9df0595)) {
    player function_4bc0893178a6f312();
  }

  if(isDefined(tear_struct)) {
    if(isDefined(tear_struct.aethertear)) {
      tear_struct.aethertear setscriptablepartstate("teleport_audio", "play");
    }

    if(isDefined(tear_struct.exit_vfx)) {
      tear_struct.exit_vfx setscriptablepartstate("exit_vfx", "on");
    }
  }

  player setOrigin(dest_str.origin);

  if(isDefined(dest_str.angles)) {
    player setplayerangles(dest_str.angles);
  }

  player freezecontrols(0);
  player val::set("aether_tear", "damage", 1);

  if(istrue(dest_str.force_freefall) || istrue(force_freefall)) {
    player skydive_beginfreefall();
  }

  wait 0.2;
  player ent_flag_clear("teleporting");

  if(isDefined(tear_struct)) {
    tear_struct.var_8f857ae285a07a32--;
  }

  dest_str.in_use = 0;
  dest_str.var_6fc5014d4400a943 = gettime();
}

function private function_c39cc8ea8a52f609(wait_time, fade_in_time) {
  self notify("play_nuke_screen_flash");
  self endon("death_or_disconnect");
  self endon("play_nuke_screen_flash");
  wait_time = default_to(wait_time, 1);
  fade_in_time = default_to(fade_in_time, 0.6);

  if(!isDefined(self.var_ad173ac833a970d4)) {
    self.var_ad173ac833a970d4 = newclienthudelem(self);
    self.var_ad173ac833a970d4.x = 0;
    self.var_ad173ac833a970d4.y = 0;
    self.var_ad173ac833a970d4 setshader("white", 640, 480);
    self.var_ad173ac833a970d4.alignx = "left";
    self.var_ad173ac833a970d4.aligny = "top";
    self.var_ad173ac833a970d4.sort = 1;
    self.var_ad173ac833a970d4.horzalign = "fullscreen";
    self.var_ad173ac833a970d4.vertalign = "fullscreen";
    self.var_ad173ac833a970d4.alpha = 0;
    self.var_ad173ac833a970d4.foreground = 1;
    self.var_ad173ac833a970d4.archived = 0;
    self.var_ad173ac833a970d4.scramblerdisabled = 1;
  }

  var_52bee65a8171b558 = fade_in_time;
  n_target_alpha = 1;
  self.var_ad173ac833a970d4 fadeovertime(var_52bee65a8171b558);
  self.var_ad173ac833a970d4.alpha = n_target_alpha;
  wait wait_time;
  var_52bee65a8171b558 = 0.5;
  self.var_ad173ac833a970d4 fadeovertime(var_52bee65a8171b558);
  self.var_ad173ac833a970d4.alpha = 0;
  wait var_52bee65a8171b558;

  if(isDefined(self.var_ad173ac833a970d4)) {
    self.var_ad173ac833a970d4 destroy();
  }
}

function function_a4a851b681286ada(zombie, tear_struct) {
  tear_struct endon("tower_tear_destroyed");
  zombie endon("death");
  zombie ent_flag_set("teleporting");

  if(isalive(zombie)) {
    zombie thread namespace_5381a59d140f4df8::function_c0d3ba0eab1acba0(zombie);
    waitframe();
    playFX(getfx("aethertear_teleport_vfx"), zombie.origin);
  }

  wait 1;

  if(isalive(zombie)) {
    zombie val::set("aether_tear", "show_healthbar", 0);
    zombie scripts\asm\asm::function_8d1655ae223d862a(0.3);
    zombie thread scripts\asm\shared\mp\utility::animscripted_single("falling");
  }

  zombie animmode("gravity_off_nav");
  waitframe();
  dest = random(tear_struct.var_e57f8945ec6d8a0c);

  if(isalive(zombie)) {
    if(zombie getscriptablehaspart("teleport_audio")) {
      zombie setscriptablepartstate("teleport_audio", "in");
    }

    if(isDefined(tear_struct.aethertear)) {
      tear_struct.aethertear setscriptablepartstate("teleport_audio", "play_zombie");
    }

    zombie hide();
    zombie animmode("gravity_off_nav");
    zombie forceteleport(dest.origin);
    zombie thread function_267216239fcea57b(dest.origin);
  }

  wait 0.4;

  if(isalive(zombie)) {
    zombie show();
    zombie thread scripts\asm\shared\mp\utility::animscripted_single("falling");
    random_dir = function_6174330574a2a273();
    offset_origin = zombie.origin + random_dir * 900;
    zombie thread function_493643ebc0b429f(offset_origin);
    zombie thread zombie_death_watcher();
  }

  wait 0.2;
  zombie ent_flag_clear("teleporting");
}

function function_267216239fcea57b(exit_point) {
  self endon("death");
  time = gettime();

  while(true) {
    if(gettime() - time >= 250) {
      return;
    }

    self forceteleport(exit_point);
    self animmode("gravity_off_nav");
    waitframe();
  }
}

function function_493643ebc0b429f(backward_origin) {
  level endon("game_ended");
  self endon("death");
  ent_flag_set("aethertear_horizontal_falling");
  counter = 0;

  while(true) {
    if(counter >= 25) {
      waitframe();
      ent_flag_clear("aethertear_horizontal_falling");
      return;
    }

    backward_origin = (backward_origin[0], backward_origin[1], self.origin[2] - 150);
    current_origin = vectorlerp(self.origin, backward_origin, counter / 25);
    self forceteleport(current_origin);
    counter++;
    waitframe();
  }
}

function zombie_death_watcher() {
  level endon("game_ended");
  self endon("death");
  self.prev_origin = self.origin;

  while(true) {
    waitframe();
    self animmode("gravity_off_nav");
    curr_z = self.origin[2];
    prev_z = self.prev_origin[2];
    self.var_7e281b3e4bf725a1 = abs(curr_z - prev_z);

    if(isDefined(self.var_8d46a4815fd63b64) && self.var_7e281b3e4bf725a1 < self.var_8d46a4815fd63b64) {
      self.forceannihilate = 1;
      playFX(getfx("aethertear_zombie_splatter"), self.origin);
      self kill();
      return;
    }

    if(!ent_flag("aethertear_horizontal_falling")) {
      self.var_8d46a4815fd63b64 = self.var_7e281b3e4bf725a1;
    }

    self.prev_origin = self.origin;
  }
}

function function_2095c03ace9ac3d() {
  self endon("tower_tear_destroyed");
  timer = 0;

  while(true) {
    timer++;

    if(timer >= self.despawntimer) {
      self.aethertear setscriptablepartstate("entrance_vfx", "closing");
      wait 1.5;

      if(isDefined(self.aethertear)) {
        self.aethertear freescriptable();
      }

      self notify("despawning_tear");
      self waittill("essence_despawned");
    }

    wait 1;
  }
}

function function_c3e067fa87e1e9d1() {
  return is_equal(self.script_label, "group_teleport");
}

function function_c0aedcea897566fe() {
  if(isDefined(self.exit_vfx)) {
    self.exit_vfx freescriptable();
  }

  if(isDefined(self.trigger)) {
    self.trigger delete();
  }

  self notify("tower_tear_destroyed");
}

function function_a420b9a5eebf5dea(new_dest) {
  while(self.var_8f857ae285a07a32 > 0) {
    waitframe();
  }

  if(isDefined(self.exit_vfx)) {
    self.exit_vfx freescriptable();
  }

  if(!isarray(new_dest)) {
    self.var_e57f8945ec6d8a0c = [new_dest];
  } else {
    self.var_e57f8945ec6d8a0c = new_dest;
  }

  function_f57948e98f6e127f(self.var_e57f8945ec6d8a0c);
  waitframe();
  avg_pos = agent_utils::getaverageorigin(self.var_e57f8945ec6d8a0c);
  self.exit_vfx = spawnscriptable("ob_jup_aethertear_vfx", avg_pos);
}

function function_f57948e98f6e127f(tear_exits) {
  if(!isDefined(tear_exits)) {
    return;
  }

  foreach(dest in tear_exits) {
    if(isDefined(dest.force_freefall)) {
      continue;
    }

    groundpos = getgroundposition(dest.origin, 1, 1000);

    if(!isDefined(groundpos) || isDefined(groundpos) && dest.origin[2] - groundpos[2] >= 800) {
      dest.force_freefall = 1;
      continue;
    }

    dest.force_freefall = 0;
  }
}

function function_20b01242856aa97c() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_3c41e488c621880d = getaiarrayinradius(self.origin, 1000);

  foreach(zombie in var_3c41e488c621880d) {
    if(isDefined(zombie.var_b0c83727eacd1810)) {
      zombie.var_b0c83727eacd1810 = gettime() + 15000;
    }
  }
}

function function_4bc0893178a6f312() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  var_3c41e488c621880d = getaiarrayinradius(self.origin, 1000);

  foreach(zombie in var_3c41e488c621880d) {
    if(isalive(zombie) && zombie.team != level.players[0].team && !istrue(zombie.marked_for_death)) {
      zombie.marked_for_death = 1;
      zombie.nuked = 1;
      zombie.full_gib = 1;
      zombie.var_745cd904c1ec804c = 1;
      zombie.nocorpse = 1;
      zombie.no_powerups = 1;
      zombie.var_7e4b076a06c6df27 = 1;
      zombie.var_f543095c3ca1b743 = 1;
      zombie.diequietly = 1;
      zombie kill();
    }
  }
}

function function_1579c58eecb01b60() {
  while(true) {
    if(getdvarint(@ "hash_610bd36b7d12a073")) {
      foreach(tear in level.var_86f0e49ba2870e8) {
        if(!isDefined(tear.trigger)) {
          continue;
        }

        if(!istrue(tear.aethertear.disabled)) {
          continue;
        }

        if(istrue(tear.aethertear.disabled) && isDefined(tear.script_flag) && !flag(tear.script_flag)) {
          flag_set(tear.script_flag);
        }
      }

      setDvar(@ "hash_610bd36b7d12a073", 0);
    }

    if(getdvarint(@ "hash_69ef0e9b8d4ae1a1") == 1) {
      foreach(tear in level.var_86f0e49ba2870e8) {
        if(!isDefined(tear.trigger)) {
          continue;
        }

        color = istrue(tear.aethertear.disabled) ? (1, 0, 0) : (0, 1, 0);
        drawtrigger(tear.trigger, color);
      }
    }

    waitframe();
  }
}

# /