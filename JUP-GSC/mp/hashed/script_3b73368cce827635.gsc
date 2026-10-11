/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3b73368cce827635.gsc
*************************************************/

#using script_3b73368cce827635;
#using script_4e6e58ab5d96c2b0;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace namespace_f766c5cbe075ba8c;

function private resettimer(player) {
  level endon("glovesComplete");
  var_6923400044bc563d = getdvarint(@ "hash_75488d15e92d078f", 120);
  timer = var_6923400044bc563d;

  while(timer >= 0) {
    timer -= 1;

    iprintlnbold(timer + "<dev string:x1c>");

    wait 1;
  }

  namespace_ff283c2f8526a8f::function_6c9ea7e2f4dd2d52(level.var_66c37e5364591fe4);
  player namespace_ff283c2f8526a8f::function_fda2598d8235bba9();
}

function function_804e8e5fc2260520() {
  loadvfx();
  initteamdata();
  function_ac531909f44e822e();
}

function private loadvfx() {
  level._effect["vfx_boxing_gloves"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_aether_fists.vfx");
}

function private initteamdata() {
  callback::add("player_item_pickup", &on_item_pickup);
  callback::add("player_item_drop", &on_item_drop);
  level.var_a95add7f127007c1 = 0;
}

function private function_743ab81ab6621936() {
  if(istrue(level.var_19e7f3165682f28e)) {
    return false;
  }

  var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(50207);
  var_51309cce530fd66a = var_afb7e0639adce453 >= 0;

  if(var_51309cce530fd66a) {
    function_ca3bbb1070436540(var_afb7e0639adce453, 0, 0);
    return true;
  }

  return false;
}

function function_ae56df9d51b68c4c(player, trigger) {
  if(isPlayer(player)) {
    var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(50207);
    var_51309cce530fd66a = var_afb7e0639adce453 >= 0;

    if(var_51309cce530fd66a) {
      level.var_f2fb4ee1d1ce6d41 showtoplayer(player);
      return;
    }

    level.var_f2fb4ee1d1ce6d41 hidefromplayer(player);
  }
}

function function_78fca00ea9feac52(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
}

function private function_ac531909f44e822e() {
  level.var_5bd1e142a4e31fef = getStruct("gloves_zombie_spawn", "targetname");

  if(isDefined(level.var_5bd1e142a4e31fef)) {
    level.var_f2fb4ee1d1ce6d41 = scripts\cp_mp\interaction::register_interact(level.var_5bd1e142a4e31fef.origin + (100, 0, 100), 200, &function_2a5c422870861dd9);
    level.var_f2fb4ee1d1ce6d41 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_3710286101f0ad65);
  }

  triggerorigin = level.var_5bd1e142a4e31fef.origin - (0, 0, 50);

  if(isDefined(level.var_f2fb4ee1d1ce6d41)) {
    level.var_f2fb4ee1d1ce6d41.var_26adba977a3c7fb1 = spawn("trigger_radius", triggerorigin, 0, 100, 100);

    if(getdvarint(@ "hash_978e1d4eb4c5748e", 0)) {
      thread scripts\cp_mp\utility\debug_utility::drawcylinder(triggerorigin, 150, 150, 999999, (1, 0, 0));
    }

    if(issharedfuncdefined("game", "makeEnterExitTrigger")) {
      [[getsharedfunc("game", "makeEnterExitTrigger")]](level.var_f2fb4ee1d1ce6d41.var_26adba977a3c7fb1, &function_ae56df9d51b68c4c, &function_78fca00ea9feac52);
    }

    level.var_f2fb4ee1d1ce6d41 hide();
  }
}

function function_3710286101f0ad65(interact, player) {
  if(istrue(level.var_19e7f3165682f28e)) {
    return {
      #string: &"JUP_OB_S2/ATTUNEMENT_ACTIVE_GLOVES", #type: "HINT_BUTTON"};
  }

  return {
    #string: &"JUP_OB_S2/OFFER_UNATTUNED_RELIC", #type: "HINT_BUTTON"};
}

function function_2a5c422870861dd9(player) {
  if(istrue(level.var_19e7f3165682f28e)) {
    return;
  }

  if(player function_743ab81ab6621936()) {
    player function_e02246121fec4742();
    level.var_f2fb4ee1d1ce6d41 hidefromplayer(player);

    if(level.var_66c37e5364591fe4 == undefined) {
      level.var_66c37e5364591fe4 = player;
    }

    squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers(undefined, 1);
    var_a6aa6ac57e10810c = scripts\mp\utility\player::getplayersinradius(player.origin, 500);

    foreach(playernear in var_a6aa6ac57e10810c) {
      playernear earthquakeforplayer(0.5, 1, player.origin, 500);
    }

    foreach(squadmember in squadmembers) {
      level.var_f2fb4ee1d1ce6d41 hidefromplayer(squadmember);
    }

    level.var_19e7f3165682f28e = 1;
    level thread resettimer(player);
  }
}

function private function_e02246121fec4742() {
  if(!isDefined(level.var_95459c1857553ef8)) {
    level.var_95459c1857553ef8 = [];
  }

  var_b8c072397b4dbad9 = getStruct("punching_bag_handler_00", "targetname");

  if(isDefined(var_b8c072397b4dbad9)) {
    var_a6c992d4adbfc7c2 = var_b8c072397b4dbad9.origin;

    if(isDefined(var_a6c992d4adbfc7c2) && !isDefined(level.var_95459c1857553ef8[0])) {
      level.var_95459c1857553ef8[0] = spawnscriptable("jup_ob_punching_bag_handler", var_a6c992d4adbfc7c2, (0, 0, 0));
      level.var_95459c1857553ef8[0].var_d96e5de6797733b8 = 0;
    }
  }

  var_1a212490b616c34b = getStruct("punching_bag_handler_01", "targetname");

  if(isDefined(var_1a212490b616c34b)) {
    var_dee013668520046c = var_1a212490b616c34b.origin;

    if(isDefined(var_dee013668520046c) && !isDefined(level.var_95459c1857553ef8[1])) {
      level.var_95459c1857553ef8[1] = spawnscriptable("jup_ob_punching_bag_handler", var_dee013668520046c, (0, 0, 0));
      level.var_95459c1857553ef8[1].var_d96e5de6797733b8 = 1;
    }
  }

  var_ecc8d5994078794d = getStruct("punching_bag_handler_02", "targetname");

  if(isDefined(var_ecc8d5994078794d) && !isDefined(level.var_95459c1857553ef8[2])) {
    var_36716e2b2a205d7e = var_ecc8d5994078794d.origin;

    if(isDefined(var_36716e2b2a205d7e)) {
      level.var_95459c1857553ef8[2] = spawnscriptable("jup_ob_punching_bag_handler", var_36716e2b2a205d7e, (0, 0, 0));
      level.var_95459c1857553ef8[2].var_d96e5de6797733b8 = 2;
    }
  }

  function_fda2598d8235bba9();
  scripts\engine\scriptable::scriptable_adddamagedcallback(&function_bce9936c9ca7e10b);
  var_3426ab2ac89dbb15 = getStruct("gloves_zombie_spawn", "targetname");

  if(isDefined(var_3426ab2ac89dbb15)) {
    level.var_553ed442961a97b6 = var_3426ab2ac89dbb15.origin;

    if(isDefined(level.var_553ed442961a97b6)) {
      level.var_e87943c3efff094a = spawnscriptable("ob_jup_aethertear_s2_quest_gloves", level.var_553ed442961a97b6, (0, 0, 0));
      level.var_e87943c3efff094a setscriptablepartstate("body_aethertear", "unusable");
    }
  }
}

function function_bce9936c9ca7e10b(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!is_equal(instance.type, "jup_ob_punching_bag_handler") || istrue(instance.destroyed)) {
    return;
  }

  if(isDefined(instance.var_d96e5de6797733b8)) {
    if(smeansofdeath == "MOD_MELEE" && instance.var_d96e5de6797733b8 == 0) {
      instance setscriptablepartstate("vfx", "active");
      eattacker function_202df4e6c45106e1();
    }

    if(smeansofdeath == "MOD_MELEE" && instance.var_d96e5de6797733b8 == 1) {
      instance setscriptablepartstate("vfx", "active");
      eattacker function_4cfe0f16977dc5af();
    }

    if(smeansofdeath == "MOD_MELEE" && instance.var_d96e5de6797733b8 == 2) {
      instance setscriptablepartstate("vfx", "active");
      eattacker function_fdcba52cb65c824e();
    }
  }
}

function private function_fda2598d8235bba9() {
  level.var_a95add7f127007c1 = 0;

  foreach(var_6b6b5d8876e922ad in level.var_95459c1857553ef8) {
    if(isDefined(var_6b6b5d8876e922ad)) {
      var_6b6b5d8876e922ad setscriptablepartstate("base", "healthy");
      var_6b6b5d8876e922ad setscriptablepartstate("vfx", "off");
      var_6b6b5d8876e922ad.health = 50;
    }
  }

  level notify("stopGlovesDeathWatcher");

  if(isDefined(level.var_c4a253533d7776c8) && isalive(level.var_c4a253533d7776c8)) {
    level.var_c4a253533d7776c8 kill();
  }

  level.var_19e7f3165682f28e = 0;
  level.var_c4a253533d7776c8 = undefined;
  level.var_66c37e5364591fe4 = undefined;
}

function private function_3b920e2797fcfd61() {
  level.var_a95add7f127007c1 = 0;

  foreach(var_6b6b5d8876e922ad in level.var_95459c1857553ef8) {
    var_6b6b5d8876e922ad setscriptablepartstate("base", "healthy");
    var_6b6b5d8876e922ad setscriptablepartstate("vfx", "off");

    if(isent(var_6b6b5d8876e922ad)) {
      var_6b6b5d8876e922ad delete();
      continue;
    }

    var_6b6b5d8876e922ad freescriptable();
  }
}

function private function_202df4e6c45106e1() {
  if(level.var_a95add7f127007c1 < 1) {
    level.var_a95add7f127007c1 = 1;
    return;
  }

  if(level.var_a95add7f127007c1 != 1) {
    function_fda2598d8235bba9();
  }
}

function private function_4cfe0f16977dc5af() {
  if(level.var_a95add7f127007c1 < 2 && level.var_a95add7f127007c1 > 0) {
    level.var_a95add7f127007c1 = 2;
    return;
  }

  if(level.var_a95add7f127007c1 != 2) {
    function_fda2598d8235bba9();
  }
}

function private function_fdcba52cb65c824e() {
  if(level.var_a95add7f127007c1 < 3 && level.var_a95add7f127007c1 > 1) {
    level.var_a95add7f127007c1 = 3;
    level thread function_4aefb40f3b5c684c(self);
    return;
  }

  if(level.var_a95add7f127007c1 != 3) {
    function_fda2598d8235bba9();
  }
}

function function_901fea53b27b2bac(dmgstruct) {
  var_3e1bc369aaabbc78 = distance2dsquared(level.var_c4a253533d7776c8.origin, level.var_553ed442961a97b6) < 22500;

  if(dmgstruct.smeansofdeath != "MOD_MELEE" || self.var_3e1bc369aaabbc78 == 0) {
    dmgstruct.idamage = 0;
  }

  if(ent_flag("energy_mine_kill") || ent_flag("frost_blast_active") || ent_flag("tesla_storm_stunned")) {
    dmgstruct.idamage = 0;
    ent_flag_clear("energy_mine_kill");
    ent_flag_clear("frost_blast_active");
    ent_flag_clear("tesla_storm_stunned");
  }

  return dmgstruct.idamage;
}

function private function_7dd418fc8b41cdab() {
  level endon("stopGlovesDeathWatcher");
  level endon("disconnect");

  while(isDefined(level.var_c4a253533d7776c8)) {
    level.var_c4a253533d7776c8.var_3e1bc369aaabbc78 = distance2dsquared(level.var_c4a253533d7776c8.origin, level.var_553ed442961a97b6) < 22500;

    if(level.var_c4a253533d7776c8.var_3e1bc369aaabbc78 && !istrue(level.var_c4a253533d7776c8.var_c7387f74f029624b) && isalive(level.var_c4a253533d7776c8)) {
      level.var_c4a253533d7776c8 function_3ab9164ef76940fd("obelisk_vfx", "gloves");
      level.var_c4a253533d7776c8.var_c7387f74f029624b = 1;
    } else if(!level.var_c4a253533d7776c8.var_3e1bc369aaabbc78 && istrue(level.var_c4a253533d7776c8.var_c7387f74f029624b)) {
      level.var_c4a253533d7776c8 function_3ab9164ef76940fd("obelisk_vfx", "off");
      level.var_c4a253533d7776c8.var_c7387f74f029624b = 0;
    }

    wait 0.2;
  }
}

function private function_4aefb40f3b5c684c(player) {
  level.var_e87943c3efff094a setscriptablepartstate("entrance_vfx", "on");
  squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  level.var_c4a253533d7776c8 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base", level.var_553ed442961a97b6, (0, 0, 0), "team_two_hundred");
  level.var_c4a253533d7776c8 thread function_6eca18484fcc4e39();
  level.var_c4a253533d7776c8 thread function_7dd418fc8b41cdab();
  level.var_c4a253533d7776c8.name = "ringZombie";
  level.var_c4a253533d7776c8.fullhealth = level.var_c4a253533d7776c8.health + 250 * squad.size;
  level.var_c4a253533d7776c8.maxhealth = level.var_c4a253533d7776c8.fullhealth;
  level.var_c4a253533d7776c8.ignore_nuke = 1;
  level.var_c4a253533d7776c8.var_970170ffd4b081ac = &function_901fea53b27b2bac;
  level.var_c4a253533d7776c8 callback::add("on_zombie_ai_damaged", &function_901fea53b27b2bac);
  level.var_c4a253533d7776c8.var_7e3144ab69fefa03 = 0;
  level.var_c4a253533d7776c8.var_c3554a26521188a8 = &function_a8c9248308033e4e;
  level.var_c4a253533d7776c8.var_b5117f0fdd28774a = &function_245283ba6b8fc;
  level.var_c4a253533d7776c8.var_69fad82b1297b14 = &function_c2cec6c21b6ed690;
  level.var_c4a253533d7776c8.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
  level.var_c4a253533d7776c8.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
  level.var_c4a253533d7776c8.var_51618a5cd18d54b = &function_57128172ecf78387;
  level.var_c4a253533d7776c8.health = level.var_c4a253533d7776c8.fullhealth;
  waitframe();
  level.var_c4a253533d7776c8 scripts\asm\shared\mp\utility::animscriptedagent("spawn_hop", "spawn_end", level.var_c4a253533d7776c8.origin, level.var_c4a253533d7776c8.angles);
  waitframe();
  level.var_e87943c3efff094a setscriptablepartstate("entrance_vfx", "closing");
  wait 0.25;
  level.var_e87943c3efff094a setscriptablepartstate("entrance_vfx", "off");
  waitframe();
  playFXOnTag(utility::getfx("vfx_boxing_gloves"), level.var_c4a253533d7776c8, "j_wrist_ri");
  playFXOnTag(utility::getfx("vfx_boxing_gloves"), level.var_c4a253533d7776c8, "j_wrist_le");
  var_11425e3325774718 = scripts\mp\utility\player::getplayersinradius(level.var_c4a253533d7776c8.origin, 500);
  level.var_c4a253533d7776c8 thread namespace_ff283c2f8526a8f::function_35e8a48dc2442eb2(var_11425e3325774718);
  thread scripts\cp_mp\overlord::playevent("s2_rq_gloves_zombie_spawn", var_11425e3325774718);
}

function function_35e8a48dc2442eb2(a_players) {
  self endon("death");
  level endon("game_ended");

  while(a_players.size) {
    if(isDefined(self.target)) {
      self function_9322f3cb1cd4111a();
    } else {
      a_players = array_removedead(a_players);
      a_players = array_removeundefined(a_players);
      e_target = utility::getclosest(self.origin, a_players, 5000);
    }

    if(isDefined(e_target)) {
      self function_65cdab0fc78aba8f(e_target.origin, 512);
      wait 10;
      e_target = undefined;
      continue;
    }

    wait 1;
  }
}

function private function_6eca18484fcc4e39() {
  level endon("game_ended");
  level endon("stopGlovesDeathWatcher");
  self waittill("death", killer);
  a_squad = killer scripts\cp_mp\utility\squad_utility::getsquadmembers();

  foreach(squadmember in a_squad) {
    squadmember.var_63948f173832a6ee = 1;
  }

  thread scripts\cp_mp\overlord::playevent("s2_rq_gloves_zombie_death", a_squad);
  level.var_e87943c3efff094a setscriptablepartstate("entrance_vfx", "on");
  wait 1;

  if(isDefined(level.var_66c37e5364591fe4)) {
    function_8375ccd1b5310841(level.var_66c37e5364591fe4);
  } else {
    function_8375ccd1b5310841(killer);
  }

  level.var_e87943c3efff094a setscriptablepartstate("entrance_vfx", "closing");
  wait 0.25;
  level.var_e87943c3efff094a setscriptablepartstate("entrance_vfx", "off");
  level.var_19e7f3165682f28e = 0;
  level.var_6e0ff213c6237a49 = undefined;
  level notify("glovesComplete");
}

function private function_6c9ea7e2f4dd2d52(player) {
  if(!isDefined(level.var_66c37e5364591fe4)) {
    return;
  }

  level.var_518e9a601e7c7ccf = spawnscriptable("ob_jup_aethertear_s2_quest_gloves", level.var_66c37e5364591fe4.origin, (0, 0, 0));
  level.var_518e9a601e7c7ccf setscriptablepartstate("entrance_vfx", "on");
  itembundlename = "ob_jup_item_key_rift_gate_season2_gloves";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", level.var_66c37e5364591fe4 getentitynumber()];
  a_squad = level.var_66c37e5364591fe4 scripts\cp_mp\utility\squad_utility::getsquadmembers();
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(a_squad, "ob_contract_lose");
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_66c37e5364591fe4.origin, undefined, 0, 1, payload);
  item.player = level.var_66c37e5364591fe4;
  level.var_518e9a601e7c7ccf setscriptablepartstate("entrance_vfx", "closing");

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;
    params.player = player;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }

    level.var_66c37e5364591fe4 function_3b920e2797fcfd61();
    level.var_66c37e5364591fe4 = undefined;
  }
}

function private function_8375ccd1b5310841(player) {
  level.var_518e9a601e7c7ccf = spawnscriptable("ob_jup_aethertear_s2_quest_gloves", player.origin, (0, 0, 0));
  level.var_518e9a601e7c7ccf setscriptablepartstate("entrance_vfx", "on");
  itembundlename = "ob_jup_item_key_rift_gate_season2_gloves_attuned";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = level.var_66c37e5364591fe4 scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_553ed442961a97b6, undefined, 0, 1, payload);
  item.player = level.var_66c37e5364591fe4;
  level.var_518e9a601e7c7ccf setscriptablepartstate("entrance_vfx", "closing");

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;
    params.player = player;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }

    thread scripts\cp_mp\overlord::playevent("s2_rq_get_attuned_gloves_rvnv", a_squad);
    level.var_66c37e5364591fe4 function_3b920e2797fcfd61();
    level.var_66c37e5364591fe4 = undefined;
  }
}

function private on_item_pickup(params) {
  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_gloves_attuned") {
    if(!istrue(self.var_7f044f32e5eb64e)) {
      wait 0.5;
      thread scripts\cp_mp\overlord::playevent("s2_rq_get_attuned_gloves_ent", [self]);
      self.var_7f044f32e5eb64e = 1;
    }
  }

  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_gloves") {
    level.var_f2fb4ee1d1ce6d41 showtoplayer(self);
  }
}

function private on_item_drop(params) {
  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_gloves") {
    var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(50207);
    var_51309cce530fd66a = var_afb7e0639adce453 >= 0;

    if(!var_51309cce530fd66a) {
      level.var_f2fb4ee1d1ce6d41 hidefromplayer(self);
    }
  }
}

function function_a8c9248308033e4e() {
  return false;
}

function function_57128172ecf78387() {
  return false;
}

function function_c2cec6c21b6ed690() {
  return false;
}

function function_245283ba6b8fc() {
  return false;
}

function function_55dafced1c7f2392() {
  return false;
}

function function_2a7521c0cd2cc849() {
  return false;
}