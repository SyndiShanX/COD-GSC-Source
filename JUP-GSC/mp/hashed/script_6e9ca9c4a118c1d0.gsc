/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6e9ca9c4a118c1d0.gsc
*************************************************/

#using script_2fdc6c28b1f8f3f3;
#using script_4e6e58ab5d96c2b0;
#using script_6bffae1b97f70547;
#using script_6e9ca9c4a118c1d0;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\ob\points;
#namespace namespace_5730b7412a25c1b1;

function function_80766cad49b7127f() {
  initfx();
  initteamdata();
  function_ac531909f44e822e();

  initdebug();
}

function private initdebug() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  devgui::function_b23a59dfb4ca49a1("<dev string:x34>", "<dev string:x51>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x91>", "<dev string:xb6>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:xfe>", "<dev string:x11b>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x15a>", "<dev string:x17f>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x1c6>", "<dev string:x1e3>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x222>", "<dev string:x247>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x28e>", "<dev string:x2b2>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x2f8>", "<dev string:x30b>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x32b>", "<dev string:x33d>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x35c>", "<dev string:x373>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x390>", "<dev string:x3a4>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x3c1>", "<dev string:x3d3>", &common_item::function_f8162124bbb6ece3);
  devgui::function_b23a59dfb4ca49a1("<dev string:x408>", "<dev string:x419>", &common_item::function_f8162124bbb6ece3);
  scripts\common\devgui::function_fe953f000498048f();
}

function private initfx() {
  level._effect["glow_toxic"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_toxic_trail.vfx");
  level._effect["glow_electric"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_elec_trail.vfx");
  level._effect["glow_fire"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_fire_trail.vfx");
  level._effect["glow_ice"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_obelisk_cryo_trail.vfx");
}

function private function_b2081e55f0ba302d() {
  if(istrue(level.var_d07fa5ab1362ae07)) {
    return false;
  }

  var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(50203);
  var_51309cce530fd66a = var_afb7e0639adce453 >= 0;

  if(var_51309cce530fd66a) {
    function_ca3bbb1070436540(var_afb7e0639adce453, 0, 0);
    return true;
  }

  return false;
}

function private initteamdata() {
  callback::add("player_item_pickup", &on_item_pickup);
  callback::add("player_item_drop", &on_item_drop);

  foreach(team in level.teamnamelist) {
    level.teamdata[team]["Relic_Mirror_Puzzle_State"] = 0;
  }
}

function private resettimer(player) {
  level endon("mirrorComplete");
  var_6923400044bc563d = getdvarint(@ "hash_75488d15e92d078f", 120);
  timer = var_6923400044bc563d;

  while(timer >= 0) {
    timer -= 1;

    iprintlnbold(timer + "<dev string:x44f>");

    wait 1;
  }

  function_e95070831c80ae51(player, player.origin);
  function_ae098390ca841bfc(player);
}

function private function_ac531909f44e822e() {
  function_da51dfe0d3ba963a();
  var_a75eb3d256ae8165 = getStruct("grave_mirror", "targetname");

  if(isDefined(var_a75eb3d256ae8165)) {
    level.var_a913297a5f21573e = scripts\cp_mp\interaction::register_interact(level.tombstone.origin + (0, 0, 100), 500, &function_2a5c422870861dd9);
    level.var_a913297a5f21573e scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_3710286101f0ad65);
    triggerorigin = level.var_a913297a5f21573e.origin - (0, 0, 100);

    if(isDefined(level.var_a913297a5f21573e)) {
      level.var_a913297a5f21573e.var_26adba977a3c7fb1 = spawn("trigger_radius", triggerorigin, 0, 300, 5000);

      if(getdvarint(@ "hash_978e1d4eb4c5748e", 0)) {
        thread scripts\cp_mp\utility\debug_utility::drawcylinder(triggerorigin, 300, 5000, 999999, (0, 0, 1));
      }

      if(issharedfuncdefined("game", "makeEnterExitTrigger")) {
        [[getsharedfunc("game", "makeEnterExitTrigger")]](level.var_a913297a5f21573e.var_26adba977a3c7fb1, &function_ae56df9d51b68c4c, &function_78fca00ea9feac52);
      }

      level.var_a913297a5f21573e hide();
    }
  }
}

function function_ae56df9d51b68c4c(player, trigger) {
  if(isPlayer(player)) {
    var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(50203);
    var_51309cce530fd66a = var_afb7e0639adce453 >= 0;

    if(var_51309cce530fd66a) {
      level.var_a913297a5f21573e showtoplayer(player);
      return;
    }

    level.var_a913297a5f21573e hidefromplayer(player);
  }
}

function function_78fca00ea9feac52(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
}

function function_3710286101f0ad65(interact, player) {
  if(istrue(level.var_d07fa5ab1362ae07)) {
    return {
      #string: &"JUP_OB_S2/ATTUNEMENT_ACTIVE_MIRROR", #type: "HINT_BUTTON"};
  }

  return {
    #string: &"JUP_OB_S2/OFFER_UNATTUNED_RELIC", #type: "HINT_BUTTON"};
}

function function_2a5c422870861dd9(player) {
  if(istrue(level.var_d07fa5ab1362ae07)) {
    return;
  }

  level.var_edba22ff451189cf = player;
  squadmembers = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  var_a6aa6ac57e10810c = scripts\mp\utility\player::getplayersinradius(player.origin, 500);

  if(player function_b2081e55f0ba302d()) {
    level.var_a913297a5f21573e hidefromplayer(player);

    foreach(playernear in var_a6aa6ac57e10810c) {
      playernear earthquakeforplayer(0.5, 1, playernear.origin, 500);
    }

    foreach(squadmember in squadmembers) {
      level.var_a913297a5f21573e hidefromplayer(squadmember);
    }

    level.var_5de02aa75c0e072 = 0;
    function_14d9017001c6253c(player);
    function_ee531fb1c8aacd54();
    level.var_d07fa5ab1362ae07 = 1;
    level thread namespace_35d8eb846e248f4a::resettimer(player);
  }
}

function private function_da51dfe0d3ba963a() {
  var_a75eb3d256ae8165 = getStruct("grave_mirror", "targetname");

  if(isDefined(var_a75eb3d256ae8165)) {
    level.tombstone = spawnscriptable("jup_ob_relic_mirror_grave", var_a75eb3d256ae8165.origin, var_a75eb3d256ae8165.angles);
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

function private function_7d26705653b0f392() {
  numplayers = randomint(5);

  if(numplayers == 0 || numplayers == 4) {
    var_f1dedcca27836ad7 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base_armored_light", level.tombstone.origin + (100, 0, 100), (0, 0, 0), "team_two_hundred");
    var_f1dedcca27836ad7 function_3ab9164ef76940fd("obelisk_vfx", "fire");
    var_f1dedcca27836ad7.element = "fire";
    var_f1dedcca27836ad7.ignore_nuke = 1;
    var_f1dedcca27836ad7.fullhealth = var_f1dedcca27836ad7.health + 8500;
    var_f1dedcca27836ad7.maxhealth = var_f1dedcca27836ad7.fullhealth;
    var_f1dedcca27836ad7.health = var_f1dedcca27836ad7.fullhealth;
    var_f1dedcca27836ad7 thread function_6eca18484fcc4e39();
    var_f1dedcca27836ad7.var_970170ffd4b081ac = &function_ac5e6c507067e422;
    var_f1dedcca27836ad7 callback::add("on_zombie_ai_damaged", &function_ac5e6c507067e422);
    var_f1dedcca27836ad7.var_7e3144ab69fefa03 = 0;
    var_f1dedcca27836ad7.var_c3554a26521188a8 = &function_a8c9248308033e4e;
    var_f1dedcca27836ad7.var_b5117f0fdd28774a = &function_245283ba6b8fc;
    var_f1dedcca27836ad7.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
    var_f1dedcca27836ad7.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
    var_f1dedcca27836ad7.var_51618a5cd18d54b = &function_57128172ecf78387;
    level.mirrorzombies[level.mirrorzombies.size] = var_f1dedcca27836ad7;
    return;
  }

  if(numplayers == 1 || numplayers == 5) {
    var_f1dedcca27836ad7 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base_armored_light", level.tombstone.origin + (100, 0, 0), (0, 0, 0), "team_two_hundred");
    var_f1dedcca27836ad7 function_3ab9164ef76940fd("obelisk_vfx", "electric");
    var_f1dedcca27836ad7.element = "electric";
    var_f1dedcca27836ad7.fullhealth = var_f1dedcca27836ad7.health + 8500;
    var_f1dedcca27836ad7.maxhealth = var_f1dedcca27836ad7.fullhealth;
    var_f1dedcca27836ad7.health = var_f1dedcca27836ad7.fullhealth;
    var_f1dedcca27836ad7.ignore_nuke = 1;
    var_f1dedcca27836ad7 thread function_6eca18484fcc4e39();
    var_f1dedcca27836ad7.var_970170ffd4b081ac = &function_502f87fbb5e89c3b;
    var_f1dedcca27836ad7 callback::add("on_zombie_ai_damaged", &function_502f87fbb5e89c3b);
    var_f1dedcca27836ad7.var_7e3144ab69fefa03 = 0;
    var_f1dedcca27836ad7.var_c3554a26521188a8 = &function_a8c9248308033e4e;
    var_f1dedcca27836ad7.var_69fad82b1297b14 = &function_c2cec6c21b6ed690;
    var_f1dedcca27836ad7.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
    var_f1dedcca27836ad7.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
    var_f1dedcca27836ad7.var_51618a5cd18d54b = &function_57128172ecf78387;
    var_f1dedcca27836ad7 scripts\asm\shared\mp\utility::animscriptedagent("spawn_hop", "spawn_end", var_f1dedcca27836ad7.origin, var_f1dedcca27836ad7.angles);
    level.mirrorzombies[level.mirrorzombies.size] = var_f1dedcca27836ad7;
    return;
  }

  if(numplayers == 2 || numplayers == 6) {
    var_f1dedcca27836ad7 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base_armored_light", level.tombstone.origin + (100, 0, 0), (0, 0, 0), "team_two_hundred");
    var_f1dedcca27836ad7 function_3ab9164ef76940fd("obelisk_vfx", "ice");
    var_f1dedcca27836ad7.element = "ice";
    var_f1dedcca27836ad7.fullhealth = var_f1dedcca27836ad7.health + 8500;
    var_f1dedcca27836ad7.maxhealth = var_f1dedcca27836ad7.fullhealth;
    var_f1dedcca27836ad7.health = var_f1dedcca27836ad7.fullhealth;
    var_f1dedcca27836ad7.ignore_nuke = 1;
    var_f1dedcca27836ad7 thread function_6eca18484fcc4e39();
    var_f1dedcca27836ad7.var_970170ffd4b081ac = &function_25eca9d018e592fd;
    var_f1dedcca27836ad7 callback::add("on_zombie_ai_damaged", &function_25eca9d018e592fd);
    var_f1dedcca27836ad7.var_7e3144ab69fefa03 = 0;
    var_f1dedcca27836ad7.var_c3554a26521188a8 = &function_a8c9248308033e4e;
    var_f1dedcca27836ad7.var_b5117f0fdd28774a = &function_245283ba6b8fc;
    var_f1dedcca27836ad7.var_69fad82b1297b14 = &function_c2cec6c21b6ed690;
    var_f1dedcca27836ad7.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
    var_f1dedcca27836ad7.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
    var_f1dedcca27836ad7 scripts\asm\shared\mp\utility::animscriptedagent("spawn_hop", "spawn_end", var_f1dedcca27836ad7.origin, var_f1dedcca27836ad7.angles);
    level.mirrorzombies[level.mirrorzombies.size] = var_f1dedcca27836ad7;
    return;
  }

  if(numplayers == 3) {
    var_f1dedcca27836ad7 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base_armored_light", level.tombstone.origin + (100, 0, 0), (0, 0, 0), "team_two_hundred");
    var_f1dedcca27836ad7 function_3ab9164ef76940fd("obelisk_vfx", "toxic");
    var_f1dedcca27836ad7.element = "toxic";
    var_f1dedcca27836ad7.fullhealth = var_f1dedcca27836ad7.health + 8500;
    var_f1dedcca27836ad7.maxhealth = var_f1dedcca27836ad7.fullhealth;
    var_f1dedcca27836ad7.health = var_f1dedcca27836ad7.fullhealth;
    var_f1dedcca27836ad7.ignore_nuke = 1;
    var_f1dedcca27836ad7 thread function_6eca18484fcc4e39();
    var_f1dedcca27836ad7.var_970170ffd4b081ac = &function_1fbd59170154f399;
    var_f1dedcca27836ad7 callback::add("on_zombie_ai_damaged", &function_1fbd59170154f399);
    var_f1dedcca27836ad7 callback::add("on_turned", &function_e0c79901d85d2388);
    var_f1dedcca27836ad7.var_7e3144ab69fefa03 = 0;
    var_f1dedcca27836ad7.var_b5117f0fdd28774a = &function_245283ba6b8fc;
    var_f1dedcca27836ad7.var_69fad82b1297b14 = &function_c2cec6c21b6ed690;
    var_f1dedcca27836ad7.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
    var_f1dedcca27836ad7.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
    var_f1dedcca27836ad7.var_51618a5cd18d54b = &function_57128172ecf78387;
    var_f1dedcca27836ad7 scripts\asm\shared\mp\utility::animscriptedagent("spawn_hop", "spawn_end", var_f1dedcca27836ad7.origin, var_f1dedcca27836ad7.angles);
    level.mirrorzombies[level.mirrorzombies.size] = var_f1dedcca27836ad7;
  }
}

function private function_14d9017001c6253c(player) {
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  thread scripts\cp_mp\overlord::playevent("s2_rq_mirror_start", a_squad);
  level.var_8fb4179536e9502e = a_squad.size;

  if(getdvarint(@ "hash_d2379fd1e01fed43", 0) > 0) {
    level.var_8fb4179536e9502e = getdvarint(@ "hash_d2379fd1e01fed43", 0);
  }

  level.mirrorzombies = [];

  if(level.var_8fb4179536e9502e == 1) {
    function_7d26705653b0f392();
    return;
  }

  for(numplayers = 0; numplayers < level.var_8fb4179536e9502e; numplayers++) {
    if(numplayers == 0 || numplayers == 4) {
      var_f1dedcca27836ad7 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base_armored_light", level.tombstone.origin + (100, 0, 100), (0, 0, 0), "team_two_hundred");
      var_f1dedcca27836ad7 function_3ab9164ef76940fd("obelisk_vfx", "fire");
      var_f1dedcca27836ad7.element = "fire";
      var_f1dedcca27836ad7.ignore_nuke = 1;
      var_f1dedcca27836ad7.fullhealth = var_f1dedcca27836ad7.health + 8500;
      var_f1dedcca27836ad7.maxhealth = var_f1dedcca27836ad7.fullhealth;
      var_f1dedcca27836ad7.health = var_f1dedcca27836ad7.fullhealth;
      var_f1dedcca27836ad7 thread function_6eca18484fcc4e39();
      var_f1dedcca27836ad7.var_970170ffd4b081ac = &function_ac5e6c507067e422;
      var_f1dedcca27836ad7 callback::add("on_zombie_ai_damaged", &function_ac5e6c507067e422);
      var_f1dedcca27836ad7.var_7e3144ab69fefa03 = 0;
      var_f1dedcca27836ad7.var_c3554a26521188a8 = &function_a8c9248308033e4e;
      var_f1dedcca27836ad7.var_b5117f0fdd28774a = &function_245283ba6b8fc;
      var_f1dedcca27836ad7.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
      var_f1dedcca27836ad7.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
      var_f1dedcca27836ad7.var_51618a5cd18d54b = &function_57128172ecf78387;
      level.mirrorzombies[level.mirrorzombies.size] = var_f1dedcca27836ad7;
      continue;
    }

    if(numplayers == 1 || numplayers == 5) {
      var_f1dedcca27836ad7 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base_armored_light", level.tombstone.origin + (100, 0, 0), (0, 0, 0), "team_two_hundred");
      var_f1dedcca27836ad7 function_3ab9164ef76940fd("obelisk_vfx", "electric");
      var_f1dedcca27836ad7.element = "electric";
      var_f1dedcca27836ad7.fullhealth = var_f1dedcca27836ad7.health + 8500;
      var_f1dedcca27836ad7.maxhealth = var_f1dedcca27836ad7.fullhealth;
      var_f1dedcca27836ad7.health = var_f1dedcca27836ad7.fullhealth;
      var_f1dedcca27836ad7.ignore_nuke = 1;
      var_f1dedcca27836ad7 thread function_6eca18484fcc4e39();
      var_f1dedcca27836ad7.var_970170ffd4b081ac = &function_502f87fbb5e89c3b;
      var_f1dedcca27836ad7 callback::add("on_zombie_ai_damaged", &function_502f87fbb5e89c3b);
      var_f1dedcca27836ad7.var_7e3144ab69fefa03 = 0;
      var_f1dedcca27836ad7.var_c3554a26521188a8 = &function_a8c9248308033e4e;
      var_f1dedcca27836ad7.var_69fad82b1297b14 = &function_c2cec6c21b6ed690;
      var_f1dedcca27836ad7.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
      var_f1dedcca27836ad7.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
      var_f1dedcca27836ad7.var_51618a5cd18d54b = &function_57128172ecf78387;
      var_f1dedcca27836ad7 scripts\asm\shared\mp\utility::animscriptedagent("spawn_hop", "spawn_end", var_f1dedcca27836ad7.origin, var_f1dedcca27836ad7.angles);
      level.mirrorzombies[level.mirrorzombies.size] = var_f1dedcca27836ad7;
      continue;
    }

    if(numplayers == 2 || numplayers == 6) {
      var_f1dedcca27836ad7 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base_armored_light", level.tombstone.origin + (100, 0, 0), (0, 0, 0), "team_two_hundred");
      var_f1dedcca27836ad7 function_3ab9164ef76940fd("obelisk_vfx", "ice");
      var_f1dedcca27836ad7.element = "ice";
      var_f1dedcca27836ad7.fullhealth = var_f1dedcca27836ad7.health + 8500;
      var_f1dedcca27836ad7.maxhealth = var_f1dedcca27836ad7.fullhealth;
      var_f1dedcca27836ad7.health = var_f1dedcca27836ad7.fullhealth;
      var_f1dedcca27836ad7.ignore_nuke = 1;
      var_f1dedcca27836ad7 thread function_6eca18484fcc4e39();
      var_f1dedcca27836ad7.var_970170ffd4b081ac = &function_25eca9d018e592fd;
      var_f1dedcca27836ad7 callback::add("on_zombie_ai_damaged", &function_25eca9d018e592fd);
      var_f1dedcca27836ad7.var_7e3144ab69fefa03 = 0;
      var_f1dedcca27836ad7.var_c3554a26521188a8 = &function_a8c9248308033e4e;
      var_f1dedcca27836ad7.var_b5117f0fdd28774a = &function_245283ba6b8fc;
      var_f1dedcca27836ad7.var_69fad82b1297b14 = &function_c2cec6c21b6ed690;
      var_f1dedcca27836ad7.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
      var_f1dedcca27836ad7.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
      var_f1dedcca27836ad7 scripts\asm\shared\mp\utility::animscriptedagent("spawn_hop", "spawn_end", var_f1dedcca27836ad7.origin, var_f1dedcca27836ad7.angles);
      level.mirrorzombies[level.mirrorzombies.size] = var_f1dedcca27836ad7;
      continue;
    }

    if(numplayers == 3) {
      var_f1dedcca27836ad7 = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base_armored_light", level.tombstone.origin + (100, 0, 0), (0, 0, 0), "team_two_hundred");
      var_f1dedcca27836ad7 function_3ab9164ef76940fd("obelisk_vfx", "toxic");
      var_f1dedcca27836ad7.element = "toxic";
      var_f1dedcca27836ad7.fullhealth = var_f1dedcca27836ad7.health + 8500;
      var_f1dedcca27836ad7.maxhealth = var_f1dedcca27836ad7.fullhealth;
      var_f1dedcca27836ad7.health = var_f1dedcca27836ad7.fullhealth;
      var_f1dedcca27836ad7.ignore_nuke = 1;
      var_f1dedcca27836ad7 thread function_6eca18484fcc4e39();
      var_f1dedcca27836ad7.var_970170ffd4b081ac = &function_1fbd59170154f399;
      var_f1dedcca27836ad7 callback::add("on_zombie_ai_damaged", &function_1fbd59170154f399);
      var_f1dedcca27836ad7 callback::add("on_turned", &function_e0c79901d85d2388);
      var_f1dedcca27836ad7.var_7e3144ab69fefa03 = 0;
      var_f1dedcca27836ad7.var_b5117f0fdd28774a = &function_245283ba6b8fc;
      var_f1dedcca27836ad7.var_69fad82b1297b14 = &function_c2cec6c21b6ed690;
      var_f1dedcca27836ad7.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
      var_f1dedcca27836ad7.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
      var_f1dedcca27836ad7.var_51618a5cd18d54b = &function_57128172ecf78387;
      var_f1dedcca27836ad7 scripts\asm\shared\mp\utility::animscriptedagent("spawn_hop", "spawn_end", var_f1dedcca27836ad7.origin, var_f1dedcca27836ad7.angles);
      level.mirrorzombies[level.mirrorzombies.size] = var_f1dedcca27836ad7;
    }
  }
}

function private function_ac5e6c507067e422(dmgstruct) {
  weaponelementtype = scripts\ob\points::function_591305dc9c07499b(dmgstruct.sweapon, dmgstruct.eattacker, dmgstruct.smeansofdeath);

  if(isDefined(weaponelementtype)) {
    if(self.element == "fire" && dmgstruct.smeansofdeath != "MOD_ELEMENTAL_FIRE" && weaponelementtype != "fire") {
      dmgstruct.idamage = 0;
      self.health = self.fullhealth;
      self.maxhealth = self.fullhealth;
    }
  }

  return dmgstruct.idamage;
}

function private function_25eca9d018e592fd(dmgstruct) {
  weaponelementtype = scripts\ob\points::function_591305dc9c07499b(dmgstruct.sweapon, dmgstruct.eattacker, dmgstruct.smeansofdeath);

  if(isDefined(weaponelementtype)) {
    if(self.element == "ice" && dmgstruct.smeansofdeath != "MOD_ELEMENTAL_COLD" && weaponelementtype != "cold") {
      dmgstruct.idamage = 0;
      self.health = self.fullhealth;
    }
  }

  return dmgstruct.idamage;
}

function private function_502f87fbb5e89c3b(dmgstruct) {
  weaponelementtype = scripts\ob\points::function_591305dc9c07499b(dmgstruct.sweapon, dmgstruct.eattacker, dmgstruct.smeansofdeath);

  if(isDefined(weaponelementtype)) {
    if(self.element == "electric" && dmgstruct.smeansofdeath != "MOD_ELEMENTAL_ELEC" && weaponelementtype != "electrical") {
      dmgstruct.idamage = 0;
      self.health = self.fullhealth;
    }
  }

  return dmgstruct.idamage;
}

function private function_1fbd59170154f399(dmgstruct) {
  weaponelementtype = scripts\ob\points::function_591305dc9c07499b(dmgstruct.sweapon, dmgstruct.eattacker, dmgstruct.smeansofdeath);

  if(isDefined(weaponelementtype)) {
    if(self.element == "toxic" && (dmgstruct.smeansofdeath != "MOD_ELEMENTAL_TOXIC" || weaponelementtype != "toxic")) {
      dmgstruct.idamage = 0;
      self.health = self.fullhealth;
    }
  }

  return dmgstruct.idamage;
}

function private function_e0c79901d85d2388(dmgstruct) {
  waitframe();
  self.brainrot_kills = 0;
  namespace_73918c307cdbe1ff::brainrot_end();
}

function function_6eca18484fcc4e39() {
  level endon("disconnect");
  level endon("stopMirrorDeathWatcher");
  self waittill("death", killer);

  if(isDefined(killer) && isPlayer(killer)) {
    var_d6640120b13ffd60 = level.var_8fb4179536e9502e;
    level.var_5de02aa75c0e072 += 1;

    if(level.var_5de02aa75c0e072 / var_d6640120b13ffd60 == 1) {
      if(isDefined(level.var_edba22ff451189cf)) {
        a_squad = level.var_edba22ff451189cf scripts\cp_mp\utility\squad_utility::getsquadmembers();
        thread scripts\cp_mp\overlord::playevent("s2_rq_get_attuned_mirror_rvnv", a_squad);
        function_374995657787e0a2(level.var_edba22ff451189cf, self.origin);
      } else {
        a_squad = killer scripts\cp_mp\utility\squad_utility::getsquadmembers();
        thread scripts\cp_mp\overlord::playevent("s2_rq_get_attuned_mirror_rvnv", a_squad);
        function_374995657787e0a2(killer, self.origin);
      }

      function_3b8b06fe20379e8e();
      level.var_d07fa5ab1362ae07 = 0;
      level.var_5de02aa75c0e072 = 0;
      level notify("mirrorComplete");
      level.var_edba22ff451189cf = undefined;
    }
  }
}

function private function_ae098390ca841bfc(player) {
  function_3b8b06fe20379e8e();
  level.var_d07fa5ab1362ae07 = 0;
  level.teamdata[player.team]["Relic_Mirror_Puzzle_State"] = 0;
  level notify("stopMirrorDeathWatcher");

  foreach(zombie in level.mirrorzombies) {
    zombie kill();
  }

  level.var_edba22ff451189cf = undefined;
}

function private function_e95070831c80ae51(player, var_f877158dac9d9e99) {
  if(!isDefined(level.var_edba22ff451189cf)) {
    return;
  }

  if(!isDefined(player) || !isDefined(var_f877158dac9d9e99)) {
    return;
  }

  level.var_a18609d5a6c0939e = spawnscriptable("ob_jup_aethertear_s2_quest_gloves", level.var_edba22ff451189cf.origin, (0, 0, 0));
  level.var_a18609d5a6c0939e setscriptablepartstate("entrance_vfx", "on");
  itembundlename = "ob_jup_item_key_rift_gate_season2_mirror";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", level.var_edba22ff451189cf getentitynumber()];
  a_squad = level.var_edba22ff451189cf scripts\cp_mp\utility\squad_utility::getsquadmembers();
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(a_squad, "ob_contract_lose");
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_edba22ff451189cf.origin, undefined, 0, 1, payload);
  level.var_a18609d5a6c0939e setscriptablepartstate("entrance_vfx", "closing");

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }

    level.var_edba22ff451189cf = undefined;
  }
}

function private function_374995657787e0a2(player, var_f877158dac9d9e99) {
  if(!isDefined(player) || !isDefined(var_f877158dac9d9e99)) {
    return;
  }

  level.var_a18609d5a6c0939e = spawnscriptable("ob_jup_aethertear_s2_quest_gloves", var_f877158dac9d9e99, (0, 0, 0));
  level.var_a18609d5a6c0939e setscriptablepartstate("entrance_vfx", "on");
  itembundlename = "ob_jup_item_key_rift_gate_season2_mirror_attuned";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", level.var_edba22ff451189cf getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, var_f877158dac9d9e99, undefined, 0, 1, payload);
  level.var_a18609d5a6c0939e setscriptablepartstate("entrance_vfx", "closing");

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }

    thread scripts\cp_mp\overlord::playevent("s2_rq_get_attuned_mirror_rvnv", a_squad);
    level.var_edba22ff451189cf = undefined;
  }
}

function private on_item_pickup(params) {
  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_mirror_attuned") {
    if(!istrue(self.var_c8e1b4654071581f)) {
      thread scripts\cp_mp\overlord::playconversation("s2_rq_get_attuned_mirror_ent", [self]);
      self.var_c8e1b4654071581f = 1;
    }
  }

  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_mirror") {
    level.var_a913297a5f21573e showtoplayer(self);
  }
}

function private function_ee531fb1c8aacd54() {
  function_c183907e5f0b9d23();
  wait 0.5;
  function_61707196a47fd340();
  wait 0.5;
  function_21a7d56b7ecb4370();
  wait 0.5;
  function_ce56fb2e795cd388();
}

function private function_e24351a5fae3b2d8() {
  level.var_6ce6accfd71ba09 setscriptablepartstate("base", "hidden");
  level.var_898eee7892cc441f setscriptablepartstate("vfx", "inactive");

  foreach(player in level.players) {
    level.var_3856824a46e27384 hidefromplayer(player);
  }
}

function private function_fad6d89abaae3305() {
  level.var_43e4d85f1915460 setscriptablepartstate("base", "hidden");
  level.var_3072a4a87c9badbe setscriptablepartstate("vfx", "inactive");

  foreach(player in level.players) {
    level.var_c85b5636f572c6d5 hidefromplayer(player);
  }
}

function private function_59652e97d161907f() {
  level.var_c21c69b6f66e0986 setscriptablepartstate("base", "hidden");
  level.var_7d3732059b615008 setscriptablepartstate("vfx", "inactive");

  foreach(player in level.players) {
    level.var_6e32ce6747857b27 hidefromplayer(player);
  }
}

function private function_a5d7a758ef89288d() {
  level.var_ce316f9a04669f9c setscriptablepartstate("base", "hidden");
  level.var_7b4334f2fe126642 setscriptablepartstate("vfx", "inactive");

  foreach(player in level.players) {
    level.var_efa1466b68876819 hidefromplayer(player);
  }
}

function private function_3b8b06fe20379e8e() {
  function_e24351a5fae3b2d8();
  function_fad6d89abaae3305();
  function_59652e97d161907f();
  function_a5d7a758ef89288d();
}

function private function_c183907e5f0b9d23() {
  var_79621307dd8839f2 = getStruct("s2_mirror_fire", "targetname");

  if(!isDefined(level.var_6ce6accfd71ba09)) {
    var_6ce6accfd71ba09 = spawnscriptable("jup_ob_relic_mirror_elemental", var_79621307dd8839f2.origin, var_79621307dd8839f2.angles);
    var_6ce6accfd71ba09 setscriptablepartstate("base", "base");
    var_898eee7892cc441f = spawnscriptable("jup_ob_relic_mirror_fire_fx", var_79621307dd8839f2.origin, (0, 0, 0));
    var_898eee7892cc441f setscriptablepartstate("vfx", "active");
    level.var_6ce6accfd71ba09 = var_6ce6accfd71ba09;
    level.var_898eee7892cc441f = var_898eee7892cc441f;
  } else {
    level.var_6ce6accfd71ba09 setscriptablepartstate("base", "base");
    level.var_898eee7892cc441f setscriptablepartstate("vfx", "active");
  }

  var_3856824a46e27384 = scripts\cp_mp\interaction::register_interact(var_79621307dd8839f2.origin, 100, &function_3698ca59b6cea149);
  var_3856824a46e27384 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_8d12ae12911e4bbd);
  level.var_3856824a46e27384 = var_3856824a46e27384;
  level.var_3856824a46e27384 setuseholdduration(2);
}

function function_8d12ae12911e4bbd(interact, player) {
  return {
    #string: &"JUP_OB_S2/INTERACT_MIRROR_FIRE", #type: "HINT_BUTTON"};
}

function function_3698ca59b6cea149(player) {
  if(!isDefined(player.var_c8734f756d21f147)) {
    function_6861e62c77ac0239(player);
    level.var_3856824a46e27384 playsoundonmovingent("glass_pane_blowout");
    function_e24351a5fae3b2d8();
  }
}

function private function_21a7d56b7ecb4370() {
  var_125af19c369529f = getStruct("s2_mirror_ice", "targetname");

  if(!isDefined(level.var_43e4d85f1915460)) {
    var_43e4d85f1915460 = spawnscriptable("jup_ob_relic_mirror_elemental", var_125af19c369529f.origin, var_125af19c369529f.angles);
    var_43e4d85f1915460 setscriptablepartstate("base", "base");
    var_3072a4a87c9badbe = spawnscriptable("jup_ob_relic_mirror_ice_fx", var_125af19c369529f.origin, (0, 0, 0));
    var_3072a4a87c9badbe setscriptablepartstate("vfx", "active");
    level.var_43e4d85f1915460 = var_43e4d85f1915460;
    level.var_3072a4a87c9badbe = var_3072a4a87c9badbe;
  } else {
    level.var_43e4d85f1915460 setscriptablepartstate("base", "base");
    level.var_3072a4a87c9badbe setscriptablepartstate("vfx", "active");
  }

  var_c85b5636f572c6d5 = scripts\cp_mp\interaction::register_interact(var_125af19c369529f.origin, 100, &function_c86175c92df1ca46);
  var_c85b5636f572c6d5 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_154680f1e2915748);
  level.var_c85b5636f572c6d5 = var_c85b5636f572c6d5;
  level.var_c85b5636f572c6d5 setuseholdduration(2);
}

function function_154680f1e2915748(interact, player) {
  return {
    #string: &"JUP_OB_S2/INTERACT_MIRROR_ICE", #type: "HINT_BUTTON"};
}

function function_c86175c92df1ca46(player) {
  function_eb52146767910406(player);
  level.var_c85b5636f572c6d5 playsoundonmovingent("glass_pane_blowout");
  function_fad6d89abaae3305();
}

function private function_ce56fb2e795cd388() {
  var_c72118276c956983 = getStruct("s2_mirror_toxic", "targetname");

  if(!isDefined(level.var_ce316f9a04669f9c)) {
    var_ce316f9a04669f9c = spawnscriptable("jup_ob_relic_mirror_elemental", var_c72118276c956983.origin, var_c72118276c956983.angles);
    var_ce316f9a04669f9c setscriptablepartstate("base", "base");
    var_7b4334f2fe126642 = spawnscriptable("jup_ob_relic_mirror_toxic_fx", var_c72118276c956983.origin, (0, 0, 0));
    var_7b4334f2fe126642 setscriptablepartstate("vfx", "active");
    level.var_ce316f9a04669f9c = var_ce316f9a04669f9c;
    level.var_7b4334f2fe126642 = var_7b4334f2fe126642;
  } else {
    level.var_ce316f9a04669f9c setscriptablepartstate("base", "base");
    level.var_7b4334f2fe126642 setscriptablepartstate("vfx", "active");
  }

  var_efa1466b68876819 = scripts\cp_mp\interaction::register_interact(var_c72118276c956983.origin, 100, &function_6e0aecd9b78368fe);
  var_efa1466b68876819 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_f3830fa88cd247ac);
  level.var_efa1466b68876819 = var_efa1466b68876819;
  level.var_efa1466b68876819 setuseholdduration(2);
}

function function_f3830fa88cd247ac(interact, player) {
  return {
    #string: &"JUP_OB_S2/INTERACT_MIRROR_TOXIC", #type: "HINT_BUTTON"};
}

function function_6e0aecd9b78368fe(player) {
  function_1a406f57af6cb215(player);
  level.var_efa1466b68876819 playsoundonmovingent("glass_pane_blowout");
  function_a5d7a758ef89288d();
}

function private function_61707196a47fd340() {
  var_eda9caeee98a8fbd = getStruct("s2_mirror_electric", "targetname");

  if(!isDefined(level.var_c21c69b6f66e0986)) {
    var_c21c69b6f66e0986 = spawnscriptable("jup_ob_relic_mirror_elemental", var_eda9caeee98a8fbd.origin, var_eda9caeee98a8fbd.angles);
    var_c21c69b6f66e0986 setscriptablepartstate("base", "base");
    var_7d3732059b615008 = spawnscriptable("jup_ob_relic_mirror_electric_fx", var_eda9caeee98a8fbd.origin, (0, 0, 0));
    var_7d3732059b615008 setscriptablepartstate("vfx", "active");
    level.var_c21c69b6f66e0986 = var_c21c69b6f66e0986;
    level.var_7d3732059b615008 = var_7d3732059b615008;
  } else {
    level.var_c21c69b6f66e0986 setscriptablepartstate("base", "base");
    level.var_7d3732059b615008 setscriptablepartstate("vfx", "active");
  }

  var_6e32ce6747857b27 = scripts\cp_mp\interaction::register_interact(var_eda9caeee98a8fbd.origin, 100, &function_3dcc79a1e03c4ed6);
  var_6e32ce6747857b27 scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_f29e02f4668c82c6);
  level.var_6e32ce6747857b27 = var_6e32ce6747857b27;
  level.var_6e32ce6747857b27 setuseholdduration(2);
}

function function_f29e02f4668c82c6(interact, player) {
  return {
    #string: &"JUP_OB_S2/INTERACT_MIRROR_ELECTRIC", #type: "HINT_BUTTON"};
}

function function_3dcc79a1e03c4ed6(player) {
  function_cc1b40686803d79f(player);
  level.var_6e32ce6747857b27 playsoundonmovingent("glass_pane_blowout");
  function_59652e97d161907f();
}

function private function_864c36a119b9932(ammomod, player) {
  currentweapon = player getcurrentweapon();
  player namespace_dc2e59577d3a271f::add_ammo_mod_to_weapon(currentweapon, ammomod);
}

function private function_6861e62c77ac0239(player) {
  itembundlename = "ob_jup_item_ammomod_napalmburst";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_6ce6accfd71ba09.origin, undefined, 0, 1, payload);

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function private function_cc1b40686803d79f(player) {
  itembundlename = "ob_jup_item_ammomod_deadwire";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_c21c69b6f66e0986.origin, undefined, 0, 1, payload);

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function private function_eb52146767910406(player) {
  itembundlename = "ob_jup_item_ammomod_cryofreeze";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_43e4d85f1915460.origin, undefined, 0, 1, payload);

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function private function_1a406f57af6cb215(player) {
  itembundlename = "ob_jup_item_ammomod_brainrot";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_ce316f9a04669f9c.origin, undefined, 0, 1, payload);

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }
  }
}

function private on_item_drop(params) {
  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_mirror") {
    var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(50203);
    var_51309cce530fd66a = var_afb7e0639adce453 >= 0;

    if(!var_51309cce530fd66a) {
      level.var_a913297a5f21573e hidefromplayer(self);
    }
  }
}