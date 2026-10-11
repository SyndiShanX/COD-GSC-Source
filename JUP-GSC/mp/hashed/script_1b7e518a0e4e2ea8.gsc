/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1b7e518a0e4e2ea8.gsc
*************************************************/

#using script_118c3165d7948d8b;
#using script_3a13b8032b62a5e6;
#using script_3e34d236a84cfd96;
#using script_42f1b4ddcbbf98b4;
#using script_485622d93fa7e4cf;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\objidpoolmanager;
#namespace namespace_c241d488869e33d3;

function private autoexec __init__system__() {
  system::register(#"hash_e73405fc3d3344c7", undefined, &__init__, undefined);
}

function __init__() {
  if(!getdvarint(@ "hash_abc1d9ea495ec189", 0)) {
    return;
  }

  level.var_a0ccf6904a92fcb3 = &function_8f9bd6db624eb858;
  level._effect["rift_gate_contract_streak_toxic"] = loadfx("vfx/s4/zombie/vfx_loot_trail_green.vfx");
  level._effect["rift_gate_contract_streak_electric"] = loadfx("vfx/s4/zombie/vfx_loot_trail_white.vfx");
  level._effect["rift_gate_contract_streak_fire"] = loadfx("vfx/s4/zombie/vfx_loot_trail_orange.vfx");
  level._effect["rift_gate_aether_tear_toxic"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_loop_green.vfx");
  level._effect["rift_gate_aether_tear_electric"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_loop_yellow.vfx");
  level._effect["rift_gate_aether_tear_fire"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_loop_red.vfx");
  level._effect["rift_gate_contract_glow_toxic"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_activity_phone_poison.vfx");
  level._effect["rift_gate_contract_glow_electric"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_activity_phone_elec.vfx");
  level._effect["rift_gate_contract_glow_fire"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_activity_phone_fire.vfx");
  callback::add("exited_aether_tear", &function_b1d7997b8790aee1);
  callback::add("big_bounty_target_spawned", &function_19e866494b6bb2d8);
  callback::add("big_bounty_quest_contract_starting", &function_90a1c6f54083cb20);
}

function function_bc5b1b1bc133f0ca(player) {
  if(getdvarint(@ "hash_24df0a85fff6ee6b", 0)) {
    return 1;
  }

  return player namespace_510e82113265fae9::function_3bb8b73991355a1(12);
}

function function_8f9bd6db624eb858(player) {
  if(getdvarint(@ "hash_3bc6c006bffbf8b", 0) == 0 || istrue(player.var_d34c91079b4d1515) || !function_bc5b1b1bc133f0ca(player)) {
    return false;
  }

  return true;
}

function function_b1d7997b8790aee1(params) {
  if(!isPlayer(params.player)) {
    return;
  }

  if(istrue(params.instance.var_dace4bc37a982334)) {
    return;
  }

  player = params.player;
  v_loc = params.instance.exit_point;
  v_angles = params.instance.playerangles;
  var_ffad6ab8078b60b7 = params.player function_d97f78c6eb9fa3e2();

  if(var_ffad6ab8078b60b7.size) {
    params.instance.var_dace4bc37a982334 = 1;
    function_c2a41406b8cd7098(params, var_ffad6ab8078b60b7);
  }
}

function private function_c2a41406b8cd7098(params, var_ffad6ab8078b60b7) {
  player = params.player;
  v_start = params.instance.exit_point;
  v_angles = params.instance.playerangles;
  instance = params.instance;

  if(!isDefined(v_angles)) {
    v_angles = player.angles;
  }

  var_ae661a94e0b1221e = v_start + anglesToForward(v_angles) * randomintrange(4500, 5000) + (0, 0, 420);
  var_ae661994e0b11feb = v_start + rotatevector(anglesToForward(v_angles) * randomintrange(4500, 5000), (0, -10, 0)) + (0, 0, 420);
  var_ae661894e0b11db8 = v_start + rotatevector(anglesToForward(v_angles) * randomintrange(4500, 5000), (0, 10, 0)) + (0, 0, 420);
  var_91cc019ad690c815 = [var_ae661a94e0b1221e, var_ae661994e0b11feb, var_ae661894e0b11db8];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

  foreach(lootid in var_ffad6ab8078b60b7) {
    if(var_91cc019ad690c815.size == 0) {
      break;
    }

    str_type = function_45d2185ed093391e(lootid);

    if(isDefined(str_type)) {
      v_loc = var_91cc019ad690c815[0];
      var_91cc019ad690c815 = array_remove(var_91cc019ad690c815, v_loc);
      instance thread function_eab942a53deb62d(v_loc, str_type, a_squad, lootid);
    }
  }
}

function private function_eab942a53deb62d(v_loc, str_type, a_players, lootid) {
  level endon("game_ended");
  aethertear = utility::spawn_model("jup_zm_aethertear_s2_quest_" + str_type, v_loc);
  aethertear hide();

  foreach(player in a_players) {
    aethertear showtoplayer(player);
  }

  aethertear setscriptablepartstate("body_aethertear", "usable");
  aethertear setscriptablepartstate("entrance_vfx", "on");
  n_timer = 90;
  n_start_time = gettime();
  var_8356321c5f5eb4c3 = undefined;
  trigger = spawn("trigger_radius", v_loc, 0, 100, 100);

  while(isDefined(trigger)) {
    player = trigger wait_for_trigger_or_timeout(n_timer);

    if(isPlayer(player) && array_contains(a_players, player) && !player ent_flag("teleporting")) {
      var_ffad6ab8078b60b7 = player function_d97f78c6eb9fa3e2();

      if(!isDefined(var_8356321c5f5eb4c3) && array_contains(var_ffad6ab8078b60b7, lootid)) {
        spawnid = lootid;
        var_8356321c5f5eb4c3 = player;
        var_8356321c5f5eb4c3 thread function_82c5fb1ff2519f0d(self, v_loc, a_players, spawnid);
        aethertear setscriptablepartstate("entrance_vfx", "on");
        waitframe();
        continue;
      }

      if(isDefined(var_8356321c5f5eb4c3) && isalive(var_8356321c5f5eb4c3)) {
        var_8356321c5f5eb4c3 utility::ent_flag_waitopen("teleporting");
        player function_82c5fb1ff2519f0d(self, v_loc);
      }
    }
  }

  if(isDefined(trigger)) {
    trigger delete();
  }

  if(isDefined(aethertear)) {
    aethertear delete();
  }
}

function private wait_for_trigger_or_timeout(n_timeout) {
  self endon("death");
  self endon("trigger_timeout");
  thread delete_after_delay(n_timeout);
  self waittill("trigger", player);
  return player;
}

function private function_45d2185ed093391e(lootid) {
  itembundlename = scripts\cp_mp\loot\common_item::function_fc925a153c7fd55c(lootid);

  if(issubstr(itembundlename, "toxic")) {
    str_type = "toxic";
  } else if(issubstr(itembundlename, "electric")) {
    str_type = "electric";
  } else if(issubstr(itembundlename, "fire")) {
    str_type = "fire";
  }

  return str_type;
}

function private function_d97f78c6eb9fa3e2() {
  var_3fa0ceb5fb31d6b = [];
  var_421f1da1a7cf188f = "ob_jup_items_keys_rift_gate_season2";
  itemlistbundle = getscriptbundle("itemspawnlist:" + var_421f1da1a7cf188f);

  foreach(itementry in itemlistbundle.itementries) {
    itembundle = getscriptbundle("itemspawnentry:" + itementry.itemspawnentry);

    if(isDefined(itembundle) && !issubstr(itembundle.ref, "attuned")) {
      lootid = scripts\cp_mp\utility\loot::getlootidfromref(itembundle.ref);

      if(isDefined(lootid)) {
        var_3fa0ceb5fb31d6b = function_6d6af8144a5131f1(var_3fa0ceb5fb31d6b, lootid);
      }
    }
  }

  return function_5f3b67bb1be94acf(var_3fa0ceb5fb31d6b);
}

function function_5f3b67bb1be94acf(var_3fa0ceb5fb31d6b) {
  var_f6898e71aa21712a = [];
  backpacksize = scripts\cp_mp\loot\common_inventory::function_1b35b10884bd8d67();

  for(i = 0; i < backpacksize; i++) {
    currentlootid = scripts\cp_mp\loot\common_inventory::function_d870b2c45335bd88(i);

    if(array_contains(var_3fa0ceb5fb31d6b, currentlootid)) {
      var_f6898e71aa21712a = function_6d6af8144a5131f1(var_f6898e71aa21712a, currentlootid);
    }
  }

  return var_f6898e71aa21712a;
}

function private function_82c5fb1ff2519f0d(var_2afa3ed3b5a38ad6, v_portal, a_players, lootid) {
  self endon("death_or_disconnect");
  ent_flag_set("teleporting");
  self playsoundevent("snd_aethertear_teleport_plr");
  self freezecontrols(1);
  var_e55048a9812bc496 = spawn("script_model", self.origin);
  var_e55048a9812bc496 setModel("tag_origin");
  self playerlinkTo(var_e55048a9812bc496);

  if(isDefined(lootid)) {
    itembundlename = scripts\cp_mp\loot\common_item::function_fc925a153c7fd55c(lootid);
    function_d9ea41b8d6c2f159(v_portal, itembundlename);
    scripts\cp_mp\loot\common_inventory::function_181a584e4a68d5d6(lootid);

    while(true) {
      level waittill("gate_quest_contract_starter_spawned", params);

      if(isDefined(params.player) && params.player == self && isDefined(params.instance.var_b189a678c1c3489a)) {
        params.instance.var_295815e7263cda4d = self;
        var_2afa3ed3b5a38ad6.v_starter = params.instance.var_b189a678c1c3489a.origin;
        params.instance.quest_objid = namespace_871f41e67db0bf7a::function_40062e64625f8b19("jup_ob_s1_quest_contract_marker");
        update_objective_position(params.instance.quest_objid, var_2afa3ed3b5a38ad6.v_starter);
        function_9cad42ac02eff950(params.instance.quest_objid);

        foreach(player in a_players) {
          objective_playermask_addshowplayer(params.instance.quest_objid, player);
        }

        break;
      }
    }
  }

  thread namespace_5d8c3870222947b5::function_7669f67b44245f73();
  v_starter = var_2afa3ed3b5a38ad6.v_starter;
  wait 0.2;
  var_8afc7e276a01ea96 = 4000;
  var_3d03754756a9cd41 = 2500;
  v_target = v_starter + (0, 0, var_3d03754756a9cd41);
  v_teleport = v_target + vectorNormalize(v_portal - v_target) * var_8afc7e276a01ea96;
  v_angles = vectortoangles(v_starter - v_teleport);
  self unlink();
  var_e55048a9812bc496 delete();
  self setOrigin(v_teleport);
  self setplayerangles(v_angles);
  self freezecontrols(0);
  ent_flag_clear("teleporting");

  if(isDefined(lootid)) {
    wait 0.5;
    level thread function_af7a62a8522565bd(self.origin, params.instance.var_b189a678c1c3489a, a_players, itembundlename);
  }
}

function private function_d9ea41b8d6c2f159(v_portal, itembundlename) {
  if(issubstr(itembundlename, "toxic")) {
    str_difficulty = "difficulty_easy";
    str_ai = "zombie_mimic_hvt";
  } else if(issubstr(itembundlename, "electric")) {
    str_difficulty = "difficulty_normal";
    str_ai = "zombie_disciple_hvt";
  } else {
    str_difficulty = "difficulty_hard";
    str_ai = "zombie_mangler_hvt";
  }

  if(level.mapname == "<dev string:x1c>" || level.mapname == "<dev string:x37>") {
    str_difficulty = undefined;
  }

  var_f923d1b5e7f75c3b = namespace_27def95c6086c32a::function_f805f042fa2f4b2(1);
  var_f923d1b5e7f75c3b.var_b20fac6bac1d6fde = self;
  var_f923d1b5e7f75c3b.str_ai = str_ai;

  while(true) {
    b_spawned = namespace_af57321bdeb06a78::function_9485315c704e6f6d("REV_OB_BIGBOUNTY", v_portal, str_difficulty, var_f923d1b5e7f75c3b);

    if(b_spawned) {
      return;
    }

    str_difficulty = undefined;
    wait 0.1;
  }
}

function function_90a1c6f54083cb20(params) {
  level endon("game_ended");

  if(isDefined(params.instance)) {
    while(!isDefined(params.instance.var_b189a678c1c3489a)) {
      wait 0.1;
    }
  }

  level notify("gate_quest_contract_starter_spawned", params);
}

function private function_af7a62a8522565bd(v_teleport, starter, a_players, itembundlename) {
  level endon("game_ended");
  var_bf76aabb89e83a00 = 3;
  v_offset = (0, 0, -100);
  var_6d0b16236c57106e = spawn("script_model", v_teleport + v_offset);
  var_6d0b16236c57106e setModel("tag_origin");
  var_6d0b16236c57106e playsoundonmovingent("evt_rr_phone_spawn");

  if(issubstr(itembundlename, "toxic")) {
    str_type = "toxic";
  } else if(issubstr(itembundlename, "electric")) {
    str_type = "electric";
  } else {
    str_type = "fire";
  }

  foreach(player in a_players) {
    if(isalive(player)) {
      playfxontagforclients(level._effect["rift_gate_contract_streak_" + str_type], var_6d0b16236c57106e, "tag_origin", player);
    }
  }

  n_wait = var_6d0b16236c57106e gravity_launch(starter.origin, var_bf76aabb89e83a00);
  wait n_wait;
  var_6d0b16236c57106e.origin = starter.origin;

  foreach(player in a_players) {
    if(isDefined(player)) {
      stopfxontagforclients(level._effect["rift_gate_contract_streak_" + str_type], var_6d0b16236c57106e, "tag_origin", player);
      playfxontagforclients(level._effect["rift_gate_contract_glow_" + str_type], var_6d0b16236c57106e, "tag_origin", player);
      player thread function_ee03790495df57f(starter);
    }
  }

  starter waittill("quest_contract_starter_cleanup");

  if(isDefined(var_6d0b16236c57106e)) {
    var_6d0b16236c57106e delete();
  }

  foreach(player in a_players) {
    if(isDefined(player)) {
      player notify("quest_contract_starter_cleanup");
    }
  }

  thread scripts\cp_mp\overlord::playevent("quest_s2_rift_gate_unlock_contract_started", a_players, 3);
}

function private function_ee03790495df57f(starter) {
  self endon("death_or_disconnect");
  self endon("quest_contract_starter_cleanup");

  while(true) {
    self waittill("ob_activity_starter_used", s_result);

    if(s_result.var_b189a678c1c3489a == starter) {
      starter notify("quest_contract_starter_cleanup");
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(s_result.quest_objid);
      scripts\mp\objidpoolmanager::returnobjectiveid(s_result.quest_objid);
      return;
    }
  }
}

function private gravity_launch(target_pos, time) {
  start_pos = self.origin;
  gravity = getdvarint(@ "bg_gravity", 0) * -1;
  dist = distance(start_pos, target_pos);
  power = dist / time;
  delta = target_pos - start_pos;
  drop = 0.5 * gravity * time * time;
  velocity = (delta[0] / time, delta[1] / time, (delta[2] - drop) / time);
  self movegravity(velocity, time);
  return time;
}

function function_19e866494b6bb2d8(params) {
  instance = params.instance;

  if(!istrue(instance.var_98116d34e1469298)) {
    return;
  }

  switch (instance.ai_type) {
    case #"hash_57f1e1130e644c8e":
      instance.var_cda97c89ff1bb729 = scripts\cp_mp\loot\common_item::function_2c836ad05e5f634c("jup_rift_gate_key_season2_toxic_attuned");
      break;
    case #"hash_d5d252eb91d1700b":
      instance.var_cda97c89ff1bb729 = scripts\cp_mp\loot\common_item::function_2c836ad05e5f634c("jup_rift_gate_key_season2_fire_attuned");
      break;
    case #"hash_8b1acdb45ebb6052":
      instance.var_cda97c89ff1bb729 = scripts\cp_mp\loot\common_item::function_2c836ad05e5f634c("jup_rift_gate_key_season2_electric_attuned");
      break;
  }

  var_9e3cc96b3a2c2e2c = 350;
  s_encounter = "ai_encounter:enc_ob_rift_gate_bounty_adds_" + instance.ai_type;
  encounterid = scripts\cp_mp\agents\ai_spawn_director::spawn_request(s_encounter, instance.aispawnstruct.origin, var_9e3cc96b3a2c2e2c, 1, 1, 0);

  if(isDefined(instance.ai_zombie)) {
    instance.ai_zombie waittill("death");
  }

  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(encounterid);
  thread scripts\cp_mp\overlord::playevent("quest_s2_rift_gate_unlock_contract_success", [self], 3.5);
}