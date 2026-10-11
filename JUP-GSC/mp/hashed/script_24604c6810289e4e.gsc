/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_24604c6810289e4e.gsc
*************************************************/

#using script_24604c6810289e4e;
#using script_4e6e58ab5d96c2b0;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
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
#namespace namespace_2d6394bd58a4a70f;

function function_4349bb88ec05e2bc() {
  initteamdata();
  function_ac531909f44e822e();
}

function private resettimer(player) {
  level endon("targetComplete");
  var_6923400044bc563d = getdvarint(@ "hash_75488d15e92d078f", 120);
  timer = var_6923400044bc563d;

  while(timer >= 0) {
    timer -= 1;

    iprintlnbold(timer + "<dev string:x1c>");

    wait 1;
  }

  namespace_e9a1ff7fe155c080::function_2f2a2371dd591643(level.var_d4b1a97a578504fe);
  player function_26cb86e6977b1dd6();
}

function private initteamdata() {
  callback::add("player_item_pickup", &on_item_pickup);
  callback::add("player_item_drop", &on_item_drop);
  level.var_1cd260b76c7e2819 = getdvarint(@ "hash_f143a85f843888a1", 8);
  level.var_adff83a13b355d74 = [];

  for(numtargets = 0; numtargets < level.var_1cd260b76c7e2819; numtargets++) {
    level.var_adff83a13b355d74[level.var_adff83a13b355d74.size] = 0;
  }
}

function private function_c43d309bae165772() {
  destroytargets();
  level.var_84bb9844c815fe9e = [];
  scripts\engine\scriptable::scriptable_adddamagedcallback(&function_bce9936c9ca7e10b);

  for(numtargets = 0; numtargets < level.var_1cd260b76c7e2819; numtargets++) {
    var_7332c55e9e9b021e = getStruct("target_0" + numtargets, "targetname");

    if(isDefined(var_7332c55e9e9b021e)) {
      var_707baad8572de955 = var_7332c55e9e9b021e.origin;
      var_431b65a4a0ff0962 = var_7332c55e9e9b021e.angles;
      var_8087d94f4cbc74db = spawnscriptable("ob_jup_aethertear_s2_quest_gloves", var_707baad8572de955, var_431b65a4a0ff0962);
      var_8087d94f4cbc74db setscriptablepartstate("body_aethertear", "unusable");
      var_8087d94f4cbc74db setscriptablepartstate("entrance_vfx", "closing");
      wait 1.5;

      if(level.var_84bb9844c815fe9e[numtargets] == undefined) {
        level.var_84bb9844c815fe9e[numtargets] = spawnscriptable("jup_ob_relic_targets", var_707baad8572de955, var_431b65a4a0ff0962);
        level.var_84bb9844c815fe9e[numtargets].targetid = numtargets;
        level.var_84bb9844c815fe9e[numtargets] setscriptablepartstate("vfx", "unshot");
      }
    }
  }
}

function private function_eebde962fa39f72f() {
  if(istrue(level.var_339cbb5b3ddcd140)) {
    return false;
  }

  var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(50205);
  var_51309cce530fd66a = var_afb7e0639adce453 >= 0;

  if(var_51309cce530fd66a) {
    function_ca3bbb1070436540(var_afb7e0639adce453, 0, 0);
    return true;
  }

  return false;
}

function private function_ac531909f44e822e() {
  var_92de6edf8f216904 = getStruct("targets_relic_offering", "targetname");

  if(isDefined(var_92de6edf8f216904)) {
    level.var_94890eb1fce436af = scripts\cp_mp\interaction::register_interact(var_92de6edf8f216904.origin, 200, &function_2a5c422870861dd9);
    level.var_94890eb1fce436af scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_3710286101f0ad65);
  }

  triggerorigin = level.var_94890eb1fce436af.origin;

  if(isDefined(level.var_94890eb1fce436af)) {
    level.var_94890eb1fce436af.var_26adba977a3c7fb1 = spawn("trigger_radius", triggerorigin, 0, 100, 5000);

    if(getdvarint(@ "hash_978e1d4eb4c5748e", 0)) {
      thread scripts\cp_mp\utility\debug_utility::drawcylinder(triggerorigin, 100, 5000, 999999, (0, 1, 0));
    }

    if(issharedfuncdefined("game", "makeEnterExitTrigger")) {
      [[getsharedfunc("game", "makeEnterExitTrigger")]](level.var_94890eb1fce436af.var_26adba977a3c7fb1, &function_ae56df9d51b68c4c, &function_78fca00ea9feac52);
    }

    level.var_94890eb1fce436af hide();
  }
}

function function_ae56df9d51b68c4c(player, trigger) {
  if(isPlayer(player)) {
    var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(50205);
    var_51309cce530fd66a = var_afb7e0639adce453 >= 0;

    if(var_51309cce530fd66a) {
      level.var_94890eb1fce436af showtoplayer(player);
      return;
    }

    level.var_94890eb1fce436af hidefromplayer(player);
  }
}

function function_78fca00ea9feac52(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }
}

function function_3710286101f0ad65(interact, player) {
  if(istrue(level.var_339cbb5b3ddcd140)) {
    return {
      #string: &"JUP_OB_S2/ATTUNEMENT_ACTIVE_TARGET", #type: "HINT_BUTTON"};
  }

  return {
    #string: &"JUP_OB_S2/OFFER_UNATTUNED_RELIC", #type: "HINT_BUTTON"};
}

function function_2a5c422870861dd9(player) {
  if(istrue(level.var_339cbb5b3ddcd140)) {
    return;
  }

  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(player function_eebde962fa39f72f()) {
    level.var_d4b1a97a578504fe = player;
    thread scripts\cp_mp\overlord::playevent("s2_rq_target_start", a_squad);
    var_adff83a13b355d74 = [];

    for(numtargets = 0; numtargets < level.var_1cd260b76c7e2819; numtargets++) {
      var_adff83a13b355d74[var_adff83a13b355d74.size] = 0;
    }

    level.var_adff83a13b355d74 = var_adff83a13b355d74;
    earthquake(0.2, 0.5, level.var_5bd1e142a4e31fef.origin, 3000);
    level thread function_c43d309bae165772();

    if(isDefined(player.team)) {
      level.var_1cd260b76c7e2819 = getdvarint(@ "hash_f143a85f843888a1", 8);
      var_adff83a13b355d74 = [];

      for(numtargets = 0; numtargets < level.var_1cd260b76c7e2819; numtargets++) {
        var_adff83a13b355d74[var_adff83a13b355d74.size] = 0;
      }

      level.teamdata[player.team]["Relic_Targets_Puzzle_State"] = var_adff83a13b355d74;
    }

    level.var_94890eb1fce436af hidefromplayer(player);
    squadmembers = player getsquadmembers(undefined, 1);
    var_a6aa6ac57e10810c = scripts\mp\utility\player::getplayersinradius(player.origin, 500);

    foreach(playernear in var_a6aa6ac57e10810c) {
      playernear earthquakeforplayer(0.5, 1, player.origin, 500);
    }

    foreach(squadmember in squadmembers) {
      level.var_94890eb1fce436af hidefromplayer(squadmember);
    }

    level.var_339cbb5b3ddcd140 = 1;
    level thread namespace_e9a1ff7fe155c080::resettimer(player);
  }
}

function function_bce9936c9ca7e10b(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(!isPlayer(eattacker)) {
    return;
  }

  if(!is_equal(instance.type, "jup_ob_relic_targets") || istrue(instance.destroyed)) {
    return;
  }

  if(isDefined(instance.targetid)) {
    level.var_84bb9844c815fe9e[instance.targetid] setscriptablepartstate("vfx", "shot");
    eattacker function_206285f148100a35(instance.targetid, instance.origin);
  }
}

function private function_26cb86e6977b1dd6() {
  level.var_1cd260b76c7e2819 = getdvarint(@ "hash_f143a85f843888a1", 8);
  var_adff83a13b355d74 = [];

  for(numtargets = 0; numtargets < level.var_1cd260b76c7e2819; numtargets++) {
    var_adff83a13b355d74[var_adff83a13b355d74.size] = 0;
  }

  level.var_adff83a13b355d74 = var_adff83a13b355d74;
  destroytargets();
  level notify("stopTargetsDeathWatcher");

  if(isDefined(level.var_1ed07ecae329d02f) && isalive(level.var_1ed07ecae329d02f)) {
    level.var_1ed07ecae329d02f kill();
    level.var_1ed07ecae329d02f = undefined;
  }

  level.var_339cbb5b3ddcd140 = 0;
  level.var_d4b1a97a578504fe = undefined;
}

function private destroytargets() {
  if(isDefined(level.var_84bb9844c815fe9e)) {
    foreach(target in level.var_84bb9844c815fe9e) {
      if(isDefined(target)) {
        target setscriptablepartstate("base", "invisible");
        target setscriptablepartstate("vfx", "invisible");
        target.health = 10;

        if(isent(target)) {
          target delete();
          continue;
        }

        target freescriptable();
      }
    }
  }
}

function private function_206285f148100a35(targetid, var_d8486273fd2c797f) {
  a_squad = scripts\cp_mp\utility\squad_utility::getsquadmembers();

  if(level.var_adff83a13b355d74[targetid] == 0) {
    level.var_adff83a13b355d74[targetid] = 1;
  }

  targetcount = 0;

  foreach(target in level.var_adff83a13b355d74) {
    if(target == 1) {
      targetcount += 1;
    }
  }

  var_88029ddda02d9a53 = 8 - targetcount;

  if(var_88029ddda02d9a53 == 4) {
    thread scripts\cp_mp\overlord::playevent("s2_rq_target_half", a_squad);
  }

  targetcount = 0;

  foreach(target in level.var_adff83a13b355d74) {
    if(target == 1) {
      targetcount += 1;
    }
  }

  var_88029ddda02d9a53 = 8 - targetcount;
  iprintlnbold("<dev string:x32>" + var_88029ddda02d9a53);

  foreach(target in level.var_adff83a13b355d74) {
    if(target == 0) {
      return;
    }
  }

  if(!isDefined(level.var_1ed07ecae329d02f)) {
    function_bce801d6cae789ef(var_d8486273fd2c797f);
  }
}

function function_380c7c8ba4974365(dmgstruct) {
  if(self.name == "targetZombie" && dmgstruct.shitloc != "head") {
    dmgstruct.idamage = 0;
    return dmgstruct.idamage;
  }

  if(dmgstruct.smeansofdeath == "MOD_MELEE") {
    dmgstruct.idamage = 0;
    return dmgstruct.idamage;
  }

  if(ent_flag("energy_mine_kill") || ent_flag("frost_blast_active") || ent_flag("tesla_storm_stunned")) {
    dmgstruct.idamage = 0;
    ent_flag_clear("energy_mine_kill");
    ent_flag_clear("frost_blast_active");
    ent_flag("tesla_storm_stunned");
    return dmgstruct.idamage;
  }

  return dmgstruct.idamage;
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

function private function_bce801d6cae789ef(var_d8486273fd2c797f) {
  level.var_5c9bf13e99504765 = spawnscriptable("ob_jup_aethertear_s2_quest_gloves", var_d8486273fd2c797f, (0, 0, 0));
  level.var_5c9bf13e99504765 setscriptablepartstate("body_aethertear", "unusable");
  level.var_5c9bf13e99504765 setscriptablepartstate("entrance_vfx", "closing");
  level.var_1ed07ecae329d02f = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_base", var_d8486273fd2c797f, (0, 0, 0), "team_two_hundred");
  level.var_1ed07ecae329d02f callback::add("on_zombie_ai_damaged", &function_380c7c8ba4974365);
  level.var_1ed07ecae329d02f.fullhealth = level.var_1ed07ecae329d02f.health + 12000;
  level.var_1ed07ecae329d02f.maxhealth = level.var_1ed07ecae329d02f.fullhealth;
  level.var_1ed07ecae329d02f scripts\common\ai::magic_bullet_shield();
  level.var_1ed07ecae329d02f function_3ab9164ef76940fd("obelisk_vfx", "targets");
  level.var_1ed07ecae329d02f.name = "targetZombie";
  level.var_1ed07ecae329d02f.health = level.var_1ed07ecae329d02f.fullhealth;
  level.var_1ed07ecae329d02f.var_5367d30ecc23d767 = 1;
  level.var_1ed07ecae329d02f.ignore_nuke = 1;
  level.var_1ed07ecae329d02f thread function_6eca18484fcc4e39();
  level.var_1ed07ecae329d02f.var_7e3144ab69fefa03 = 0;
  level.var_1ed07ecae329d02f.var_c3554a26521188a8 = &function_a8c9248308033e4e;
  level.var_1ed07ecae329d02f.var_b5117f0fdd28774a = &function_245283ba6b8fc;
  level.var_1ed07ecae329d02f.var_69fad82b1297b14 = &function_c2cec6c21b6ed690;
  level.var_1ed07ecae329d02f.var_8a5ad30eca36b2f9 = &function_2a7521c0cd2cc849;
  level.var_1ed07ecae329d02f.var_1b74dbfbf5e984dc = &function_55dafced1c7f2392;
  level.var_1ed07ecae329d02f.var_51618a5cd18d54b = &function_57128172ecf78387;
  level.var_1ed07ecae329d02f.fullhealth = level.var_1ed07ecae329d02f.health;
  waitframe();
  level.var_1ed07ecae329d02f scripts\asm\shared\mp\utility::animscriptedagent("spawn_hop", "spawn_end", level.var_1ed07ecae329d02f.origin, level.var_1ed07ecae329d02f.angles);
  waitframe();
  var_10a5bcf5418ea283 = scripts\mp\utility\player::getplayersinradius(level.var_1ed07ecae329d02f.origin, 500);
  thread scripts\cp_mp\overlord::playevent("s2_rq_targets_zombie_spawn", var_10a5bcf5418ea283);
  wait 1;
  level.var_1ed07ecae329d02f scripts\common\ai::stop_magic_bullet_shield();
}

function private function_6eca18484fcc4e39() {
  level endon("disconnect");
  level endon("stopTargetsDeathWatcher");
  self waittill("death", killer);

  if(isDefined(level.var_d4b1a97a578504fe)) {
    a_squad = level.var_d4b1a97a578504fe scripts\cp_mp\utility\squad_utility::getsquadmembers();
    thread scripts\cp_mp\overlord::playevent("s2_rq_targets_zombie_death", a_squad);
    function_7ac8ae8bc8ac8afc(level.var_d4b1a97a578504fe);
  } else {
    a_squad = level.var_d4b1a97a578504fe scripts\cp_mp\utility\squad_utility::getsquadmembers();
    thread scripts\cp_mp\overlord::playevent("s2_rq_targets_zombie_death", a_squad);
    function_7ac8ae8bc8ac8afc(killer);
  }

  destroytargets();
  level.var_339cbb5b3ddcd140 = 0;
  level.var_1ed07ecae329d02f = undefined;
  level notify("targetComplete");
}

function private function_2f2a2371dd591643(player) {
  if(!isDefined(level.var_d4b1a97a578504fe)) {
    return;
  }

  level.var_96e676ee2273148c = spawnscriptable("ob_jup_aethertear_s2_quest_gloves", level.var_d4b1a97a578504fe.origin, (0, 0, 0));
  level.var_96e676ee2273148c setscriptablepartstate("entrance_vfx", "on");
  itembundlename = "ob_jup_item_key_rift_gate_season2_targets";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", level.var_d4b1a97a578504fe getentitynumber()];
  a_squad = level.var_d4b1a97a578504fe scripts\cp_mp\utility\squad_utility::getsquadmembers();
  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(a_squad, "ob_contract_lose");
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, level.var_d4b1a97a578504fe.origin, undefined, 0, 1, payload);
  level.var_96e676ee2273148c setscriptablepartstate("entrance_vfx", "closing");

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }

    wait 0.5;
    level.var_d4b1a97a578504fe = undefined;
  }
}

function private function_7ac8ae8bc8ac8afc(player) {
  level.var_5c9bf13e99504765 = spawnscriptable("ob_jup_aethertear_s2_quest_gloves", player.origin, (0, 0, 0));
  level.var_5c9bf13e99504765 setscriptablepartstate("entrance_vfx", "on");
  itembundlename = "ob_jup_item_key_rift_gate_season2_targets_attuned";
  itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
  payload = [#"teamselect", player getentitynumber()];
  a_squad = player scripts\cp_mp\utility\squad_utility::getsquadmembers();
  item = scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, player.origin, undefined, 0, 1, payload);
  level.var_5c9bf13e99504765 setscriptablepartstate("entrance_vfx", "closing");

  if(isDefined(item)) {
    params = spawnStruct();
    params.item = item;
    params.itembundlename = itembundlename;
    params.payload = payload;

    if(isDefined(level.var_8b939fbe0ef2d56b)) {
      player[[level.var_8b939fbe0ef2d56b]](params);
    }

    wait 0.5;
    thread scripts\cp_mp\overlord::playevent("s2_rq_get_attuned_targets_rvnv", a_squad);
    level.var_d4b1a97a578504fe = undefined;
  }
}

function private on_item_pickup(params) {
  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_targets_attuned") {
    if(!istrue(self.var_a7534b835943cd10)) {
      thread scripts\cp_mp\overlord::playevent("s2_rq_get_attuned_targets_ent", [self]);
      self.var_a7534b835943cd10 = 1;
    }
  }

  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_targets") {
    level.var_94890eb1fce436af showtoplayer(self);
  }
}

function private on_item_drop(params) {
  if(isDefined(params.itembundlename) && params.itembundlename == "ob_jup_item_key_rift_gate_season2_targets") {
    var_afb7e0639adce453 = scripts\cp_mp\loot\common_inventory::function_4776284a348ebb6a(50205);
    var_51309cce530fd66a = var_afb7e0639adce453 >= 0;

    if(!var_51309cce530fd66a) {
      level.var_94890eb1fce436af hidefromplayer(self);
    }
  }
}