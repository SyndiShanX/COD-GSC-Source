/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\uav_tower.gsc
***********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\killstreaks\uav_bigmap;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\structspawnconfig;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_plunder;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\poi;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\trigger;
#namespace uav_tower;

function init(waitprematch) {
  if(!function_fcd65de73a5fd25() || isDefined(level.uavtowers)) {
    return;
  }

  if(getdvarint(@ "scr_ssc_use_uav_tower", 0) && getdvarint(@ "scr_ssc_enabled", 0)) {
    scripts\mp\flags::function_1240434f4201ac9d("ssc_initialized");
    scripts\cp_mp\structspawnconfig::function_4f7660cfd85cd517("uav_tower", &function_e6c1c35181a2870f);
    scripts\cp_mp\structspawnconfig::function_412f527ef0863f0e("uav_tower", &function_dc8fd3d5775fe8bd);
    scripts\cp_mp\structspawnconfig::function_eded5b87f8f7bdfd("uav_tower", &function_b0ce2500fdbd63b1);
  }

  if(istrue(waitprematch)) {
    level endon("game_ended");
    level waittill("prematch_done");
  }

  script_model_anims();
  level.towerusetime = getdvarfloat(@ "scr_uav_tower_use_time", 3.4);
  level.var_6acf91bbf5273e8f = getdvarint(@ "hash_bd581b3a13b81db8", 5000);
  level.var_39f69f7dfc40a323 = getdvarint(@ "hash_e466d59282ecb790", 3000);
  level.var_ab2c4542c95656cb = getdvarint(@ "hash_d6193a209d3948a4", 3);
  level.var_20ebe48820fd70a2 = getdvarint(@ "scr_uav_tower_uptime", 40);
  level.var_c5bbb7914cb760cf = getdvarint(@ "hash_25af310c5bc4bc7c", 3);
  level.var_eb56ea0bfdaa4011 = getdvarint(@ "hash_4704cc015db60ad2", 3);
  level.var_174fe9ecce8fb96b = randomintrange(level.var_c5bbb7914cb760cf, level.var_eb56ea0bfdaa4011 + 1);
  level.var_8703df33a53750c6 = getdvarint(@ "hash_f741c76d2b72d5c5", 1);
  level.var_81018c8d037da6c8 = getdvarint(@ "hash_d78433447211bc33", 1);
  level.towercooldown = getmatchrulesdata("commonOption", "uavTowerCooldown");
  level.var_815479da1dafbdb0 = getdvarint(@ "hash_45f42bcb4e5d758d", 1);
  level.var_66bf5bfca21a8d52 = getdvarint(@ "hash_c7c9d45312dd7ec", 1);
  level.var_d507e35282b50614 = getdvarint(@ "scr_uav_tower_cost", 200);
  level.var_db9587440497015c = getdvarint(@ "scr_uav_tower_sound", 1);
  level.var_9f740c9281d0c7f4 = getdvarint(@ "hash_5569456c0eff0d5b", 1);
  level.var_21da00da533a4de5 = getdvarint(@ "hash_2d4b53ed39fc8215", 1);
  level.var_6bacc8cb646fa5cd = getdvarint(@ "hash_21c230525b7cf2be", 1);
  level.var_684d782689230a50 = getdvarint(@ "hash_9d7a6b692b6e84ae", 0);
  level.var_7916385e2124e7a7 = getdvarint(@ "hash_ba964de8526de5bd", 138);
  level.var_4414dbbf9d80d75d = [];
  level.var_1245cb2a7bf020f7 = getdvarint(@ "hash_42ba93b094050d0", 0);
  level.var_38c78bab762bfff6 = [];
  level.activetowers = [];
  level.uavtowers = [];
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("dmz_uav_tower", &tower_used);

  if(!getdvarint(@ "scr_ssc_use_uav_tower", 0) || !getdvarint(@ "scr_ssc_enabled", 0)) {
    level thread function_d45b1fddb87cf6bc();
  }

  thread function_2a905da0882c958();

  if(utility::ismp()) {
    scripts\engine\utility::registersharedfunc("uav_tower", "tower_disable", &tower_disable);
  }

  level callback::add("ob_content_process_create_script", &function_c2c04f8e7be26a06);

  if(getdvarint(@ "hash_132aa99ae926c59c", 1)) {
    scripts\mp\gametypes\br_circle::registercirclecallbacks(14, &dangercircletick, &function_1a1709943670772a);
  }

  if(level.var_21da00da533a4de5) {
    var_b2c90dc03f470a24 = function_e6c1c35181a2870f("uav_tower");

    foreach(tower in var_b2c90dc03f470a24) {
      tower.poi = scripts\mp\poi::function_6cc445c02b5effac(tower.origin);
    }
  }

  scripts\mp\team_assimilation::registerteamassimilatecallback(&function_6bdc6f56944dc3aa);

  if(level.var_9f740c9281d0c7f4) {
    assert(isDefined(game["<dev string:x1c>"]));
    game["dialog"]["uav_tower_use_first_person"] = "uav1_grav_klls";
    game["dialog"]["uav_tower_use_friendly"] = "uav1_grav_kllc";
    game["dialog"]["uav_tower_use_enemy"] = "uav1_grav_klnc";
    game["dialog"]["uav_tower_time_expired"] = "uavt_grav_xprd";
    game["dialog"]["uav_tower_stolen"] = "uavt_grav_cptr";
  }

  level thread function_83565380b036f12d();
}

#using_animtree("script_model");

function script_model_anims() {
  level.scr_animtree["uav_tower"] = #animtree;
  level.scr_anim["uav_tower"]["use_uav_tower_enter"] = % dmz_uav_tower_enter;
  level.scr_eventanim["uav_tower"]["use_uav_tower_enter"] = % "use_uav_tower_enter";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_enter"] = "dmz_uav_tower_enter";
  level.scr_anim["uav_tower"]["use_uav_tower_idle"] = % dmz_uav_tower_idle;
  level.scr_eventanim["uav_tower"]["use_uav_tower_idle"] = % "use_uav_tower_idle";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_idle"] = "dmz_uav_tower_idle";
  level.scr_anim["uav_tower"]["use_uav_tower_exit"] = % dmz_uav_tower_exit;
  level.scr_eventanim["uav_tower"]["use_uav_tower_exit"] = % "use_uav_tower_exit";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_exit"] = "dmz_uav_tower_exit";
}

function create_player_rig(animname, spawnpos, spawnang, uav_tower) {
  self.animname = animname;

  if(!isDefined(spawnpos)) {
    spawnpos = (0, 0, 0);
  }

  if(!isDefined(spawnang)) {
    spawnang = (0, 0, 0);
  }

  self function_b88c89bb7cd1ab8e(spawnpos);
  player_rig = spawn("script_arms", self.origin, 0, 0, self);
  self.player_rig = player_rig;
  player_rig.origin = spawnpos;
  player_rig.angles = spawnang;
  player_rig.player = self;
  player_rig hide(1);
  player_rig.animname = animname;
  player_rig useanimtree(#animtree);
  player_rig.updatedversion = 1;
  self playerlinktoabsolute(player_rig, "tag_player", 1, 0, 0, 0, 0, 1);

  if(isDefined(uav_tower) && isDefined(uav_tower.linkedparent)) {
    player_rig linkTo(uav_tower.linkedparent);
  }

  self notify("rig_created");
  waittill_any_3("remove_rig", "player_free_spot", "disconnect");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(self)) {
    self unlink();
    self stopviewmodelanim();
    hackwaitframes = getdvarint(@ "hash_3cee7c513ae578f7", 0);

    while(hackwaitframes > 0) {
      waitframe();
      hackwaitframes -= 1;
    }

    thread scripts\cp_mp\utility\inventory_utility::function_9897d143c3feee05();
  }

  if(isDefined(player_rig) && player_rig islinked()) {
    player_rig unlink();
  }

  if(isDefined(player_rig)) {
    player_rig delete();
  }

  if(isDefined(uav_tower) && isDefined(uav_tower.linkedparent) && isDefined(self)) {
    parent = uav_tower.linkedparent;

    if(isDefined(parent.velocity)) {
      local_vel = coordtransformtranspose(parent.velocity, (0, 0, 0), parent.angles);
      local_vel = (local_vel[0], local_vel[1], 0);
      world_vel = coordtransform(local_vel, (0, 0, 0), parent.angles);
      horizontaloffset = getdvarfloat(@ "hash_70433558c51dfcfd", 5);
      var_5480d8da1dde6edf = anglesToForward(self.angles) * (horizontaloffset * -1, horizontaloffset * -1, 0);
      test_origin = self.origin + world_vel * function_676cfe2ab64ea758() / 1000 * 0.25 + var_5480d8da1dde6edf;
      point_start = test_origin + (0, 0, 50);
      point_end = test_origin - (0, 0, 50);
      traceresult = scripts\engine\trace::capsule_trace(point_start, point_end, 10, 72, undefined, self);
      var_e594f77b6a33eb8b = traceresult["position"];
      self setvelocity(world_vel * 0.5);
      verticaloffset = getdvarfloat(@ "hash_6b0f27e366b9165f", 2);
      offset = (0, 0, verticaloffset);
      self setOrigin(var_e594f77b6a33eb8b + offset);
    }

    self setstance("stand");
  }
}

function function_dc8fd3d5775fe8bd(structname, towerstruct) {
  if(!isDefined(level.var_d08063417d1d4dc7)) {
    level.var_d08063417d1d4dc7 = [];
  }

  level.var_d08063417d1d4dc7[level.var_d08063417d1d4dc7.size] = towerstruct;
  return towerstruct;
}

function function_b0ce2500fdbd63b1(structname) {
  level endon("game_ended");
  level waittill("prematch_done");
  waitframe();

  if(!isDefined(level.var_d08063417d1d4dc7) || level.var_d08063417d1d4dc7.size == 0) {
    return;
  }

  foreach(loc in level.var_d08063417d1d4dc7) {
    function_a517440c8faa2939(loc);
  }

  level.var_d08063417d1d4dc7 = undefined;
}

function function_a517440c8faa2939(towerstruct, var_73aa4684ecff09e9) {
  assert(isDefined(level.uavtowers));
  towersspawned = level.uavtowers.size;
  var_85bb401958c65b45 = function_858af52a8e277a68(towerstruct, towersspawned, var_73aa4684ecff09e9);
  return var_85bb401958c65b45;
}

function function_858af52a8e277a68(towerstruct, identifier, var_73aa4684ecff09e9) {
  if(!isDefined(towerstruct.angles)) {
    towerstruct.angles = (0, 0, 0);
  }

  scriptablename = "dmz_uav_tower";

  if(isDefined(var_73aa4684ecff09e9)) {
    scriptablename = var_73aa4684ecff09e9;
  }

  scriptable = spawnscriptable(scriptablename, towerstruct.origin, towerstruct.angles);
  scriptable setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");

  if(!istrue(level.var_1245cb2a7bf020f7)) {
    scriptable setscriptablepartstate("objective", "inactive");
  }

  towerstruct.uav_station = scriptable;
  scriptable.towerstruct = towerstruct;
  scriptable.identifier = identifier;
  scriptable.gasdisabled = 0;
  scriptable.var_e5a6fe7ed1143956 = -1;

  if(level.var_684d782689230a50) {
    towerstruct.uav_station scripts\cp_mp\emp_debuff::set_apply_emp_callback(&function_dc9f963b97f73b1a);
    towerstruct.uav_station.var_3545410459b16762 = &function_dc9f963b97f73b1a;
  }

  if(!isDefined(towerstruct.poi) && isDefined(towerstruct.fortress) && isDefined(towerstruct.fortress.poiname)) {
    towerstruct.poi = towerstruct.fortress.poiname;
  }

  level.uavtowers[level.uavtowers.size] = towerstruct;

  if(istrue(level.var_815479da1dafbdb0)) {
    scriptable.teamscooldown = [];
  }

  scriptable scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_aaf7a2b88614befa);

  if(issharedfuncdefined("<dev string:x26>", "<dev string:x31>")) {
    [[getsharedfunc("<dev string:x26>", "<dev string:x31>")]]("<dev string:x3d>", "<dev string:x4a>", undefined, "<dev string:x5b>", undefined, undefined, towerstruct.poi, towerstruct.origin);
  }

  return scriptable;
}

function private function_aaf7a2b88614befa(usable, player) {
  if(isDefined(player)) {
    playercost = player function_26fc3305456d700f(usable);

    if(!isDefined(playercost) || playercost <= 0) {
      return {
        #string: &"DMZ/ACTIVATE_UAV_TOWER", #type: "HINT_BUTTON"};
    } else {
      displaycost = playercost * getdvarint(@ "playlist_ui_cash_scalar", 10);
      return {
        #params: [displaycost], #string: &"DMZ/ACTIVATE_UAV_TOWER_COST", #type: "HINT_BUTTON"};
    }
  }

  return {
    #string: &"", #type: "HINT_NOICON"};
}

function private function_fe7e4144e9133c3a() {
  if(!isDefined(level.var_fe7e4144e9133c3a)) {
    level.var_fe7e4144e9133c3a = getdvarint(@ "hash_7131733d65e51232", 0);
  }

  return level.var_fe7e4144e9133c3a;
}

function function_e6c1c35181a2870f(structname) {
  var_b2c90dc03f470a24 = getStructArray(structname, "targetname");

  if(!isDefined(var_b2c90dc03f470a24) || var_b2c90dc03f470a24.size < 1) {
    var_b2c90dc03f470a24 = getStructArray("dmz_uav_tower", "targetname");
  }

  if(isDefined(level.var_3e175c0b6527751f)) {
    var_b2c90dc03f470a24 = [[level.var_3e175c0b6527751f]]();
  }

  return var_b2c90dc03f470a24;
}

function function_c2c04f8e7be26a06(sparams) {
  function_d45b1fddb87cf6bc();
}

function function_d45b1fddb87cf6bc() {
  level endon("game_ended");

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_b2c90dc03f470a24 = function_e6c1c35181a2870f("uav_tower");

  if(var_b2c90dc03f470a24.size == 0) {
    return;
  }

  var_57f36abbeac85747 = getdvarint(@ "hash_939ab4119a3db356", 0);
  var_fe7e4144e9133c3a = function_fe7e4144e9133c3a();
  towersspawned = 0;

  if(!var_57f36abbeac85747 && !var_fe7e4144e9133c3a) {
    var_1a7a45589889fd67 = [];
    var_34965515ac54e0b5 = [];
    var_371c833eba04930e = issharedfuncdefined("poi", "poi_isPOIActive", 0);

    for(towerindex = 0; towerindex < var_b2c90dc03f470a24.size; towerindex++) {
      uavtower = var_b2c90dc03f470a24[towerindex];

      if(!isDefined(uavtower.poi)) {
        continue;
      }

      if(!isDefined(var_1a7a45589889fd67[uavtower.poi])) {
        var_1a7a45589889fd67[uavtower.poi] = [];
        var_34965515ac54e0b5[var_34965515ac54e0b5.size] = uavtower.poi;
      }

      var_1a7a45589889fd67[uavtower.poi][var_1a7a45589889fd67[uavtower.poi].size] = uavtower;
    }

    var_34965515ac54e0b5 = array_randomize(var_34965515ac54e0b5);
    var_4b30d157cdb30549 = 0;

    foreach(var_7e5c3e3c0f4fb904 in var_34965515ac54e0b5) {
      if(var_4b30d157cdb30549 == level.var_174fe9ecce8fb96b) {
        break;
      }

      if(var_371c833eba04930e && ![[getsharedfunc("poi", "poi_isPOIActive")]](var_7e5c3e3c0f4fb904)) {
        continue;
      }

      var_4b30d157cdb30549++;
      var_dc97ba189a64519e = var_1a7a45589889fd67[var_7e5c3e3c0f4fb904];
      var_8703df33a53750c6 = getdvarint(hashcat(@ "hash_72de7f7dbae2d115", var_7e5c3e3c0f4fb904), level.var_8703df33a53750c6);
      var_81018c8d037da6c8 = getdvarint(hashcat(@ "hash_ea59c77e13b98a07", var_7e5c3e3c0f4fb904), level.var_81018c8d037da6c8);
      var_b677145bce94aeb6 = randomintrange(var_8703df33a53750c6, var_81018c8d037da6c8 + 1);

      if(var_b677145bce94aeb6 > var_dc97ba189a64519e.size) {
        var_b677145bce94aeb6 = var_dc97ba189a64519e.size;
      }

      var_dc97ba189a64519e = array_slice(array_randomize(var_dc97ba189a64519e), 0, var_b677145bce94aeb6);

      for(towerindex = 0; towerindex < var_dc97ba189a64519e.size; towerindex++) {
        towerstruct = var_dc97ba189a64519e[towerindex];
        function_858af52a8e277a68(towerstruct, towersspawned);
        towersspawned++;
      }
    }

    return;
  } else if(!var_fe7e4144e9133c3a) {
    var_636432a951d1b72f = randomintrange(level.var_8703df33a53750c6, level.var_81018c8d037da6c8 + 1);

    if(var_636432a951d1b72f < var_b2c90dc03f470a24.size) {
      var_b2c90dc03f470a24 = array_slice(array_randomize(var_b2c90dc03f470a24), 0, var_636432a951d1b72f);
    }
  }

  for(towerindex = 0; towerindex < var_b2c90dc03f470a24.size; towerindex++) {
    towerstruct = var_b2c90dc03f470a24[towerindex];
    function_858af52a8e277a68(towerstruct, towersspawned);
    towersspawned++;
  }
}

function _ping(scriptable, playerteam, var_b608af6e8d86fe42) {
  scriptable endon("death");
  scriptable endon("tower_disable");
  level endon("game_ended");

  if(issharedfuncdefined("player", "showMiniMap")) {
    players = level.players;

    if(issharedfuncdefined("game", "getTeamData")) {
      players = [[getsharedfunc("game", "getTeamData")]](playerteam, "players");
    }

    foreach(player in players) {
      player[[getsharedfunc("player", "showMiniMap")]]();
    }
  }

  radius = int(level.var_6acf91bbf5273e8f * ter_op(isDefined(level.var_c0fe6cb6face684e) && var_b608af6e8d86fe42, level.var_c0fe6cb6face684e, 1));

  if(istrue(level.var_1245cb2a7bf020f7)) {
    if(issharedfuncdefined("uav_tower", "onTowerPingStart")) {
      [[getsharedfunc("uav_tower", "onTowerPingStart")]](scriptable, radius, level.var_ab2c4542c95656cb);
    }
  }

  while(true) {
    triggerportableradarpingteam(scriptable.origin, playerteam, radius, level.var_39f69f7dfc40a323, scriptable.var_e5a6fe7ed1143956);
    scripts\cp_mp\killstreaks\uav_bigmap::function_e457560e955be5f5(playerteam, scriptable.origin, radius, (level.var_39f69f7dfc40a323 + 50) / 1000);
    wait level.var_ab2c4542c95656cb;
  }
}

function tower_disable(scriptable, disablereason) {
  player = scriptable.var_27e49251bb3376ea;

  if(issharedfuncdefined("player", "hideMiniMap") && isDefined(player)) {
    players = level.players;

    if(issharedfuncdefined("game", "getTeamData")) {
      players = [[getsharedfunc("game", "getTeamData")]](player.team, "players");
    }

    foreach(teamplayer in players) {
      teamplayer[[getsharedfunc("player", "hideMiniMap")]]();
    }
  }

  if(level.var_9f740c9281d0c7f4 && isDefined(player) && !istrue(disablereason == "different_team_activated")) {
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("uav_tower_time_expired", player.team, 1, 2);
  }

  scriptable function_1d71dc9529bef550(disablereason);
  scripts\cp_mp\overlord::function_9793a81bc3bc19e9("uav_tower_duration_ended", scriptable.activeteam);
  scriptable setscriptablepartstate("dmz_uav_tower_antenna", "active_end");

  if(!istrue(level.var_1245cb2a7bf020f7)) {
    scriptable setscriptablepartstate("objective", "inactive");
  }

  scriptable.var_27e49251bb3376ea = undefined;
  scriptable.activeteam = undefined;
  level.activetowers = array_remove(level.activetowers, scriptable);

  if(level.var_66bf5bfca21a8d52) {
    scriptable function_c3476653bc728729();
  }

  scriptable notify("tower_disable");
}

function function_9a71dd352fe6da4b(scriptable, var_b608af6e8d86fe42) {
  scriptable endon("death");
  scriptable endon("tower_disable");
  level endon("game_ended");
  wait level.var_20ebe48820fd70a2 * ter_op(isDefined(level.var_1408c77a4f773854) && istrue(var_b608af6e8d86fe42), level.var_1408c77a4f773854, 1);

  if(issharedfuncdefined("uav_tower", "tower_disable")) {
    [[getsharedfunc("uav_tower", "tower_disable")]](scriptable, "timeout");
  }
}

function function_550deeac761ab7b9(scriptable) {
  scriptable endon("death");
  level endon("game_ended");

  if(!istrue(level.var_815479da1dafbdb0)) {
    level.var_38c78bab762bfff6[scriptable.index] = 1;
    wait level.var_20ebe48820fd70a2 + level.towercooldown;
    level.var_38c78bab762bfff6[scriptable.index] = 0;
    return;
  }

  playerteam = self.team;
  scriptable.teamscooldown[playerteam] = 1;
  scriptable waittill_any_timeout_1(level.var_20ebe48820fd70a2, "tower_disable");
  wait level.towercooldown;
  scriptable.teamscooldown[playerteam] = 0;
}

function tower_used(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  if(!tower_canuse(player)) {
    return;
  }

  canuse = !isDefined(level.var_38c78bab762bfff6[instance.index]) || !level.var_38c78bab762bfff6[instance.index];
  oldteam = undefined;

  if(istrue(level.var_815479da1dafbdb0)) {
    canuse = !isDefined(instance.teamscooldown[player.team]) || !instance.teamscooldown[player.team];

    foreach(playerteam, value in instance.teamscooldown) {
      if(value == 1) {
        oldteam = playerteam;
        break;
      }
    }
  }

  var_4c63764d12ed5def = 1;
  cost = player function_26fc3305456d700f(instance);

  if(cost > 0) {
    var_4c63764d12ed5def = istrue(player.plundercount >= cost);

    if(canuse && !var_4c63764d12ed5def) {
      canuse = 0;
    }
  }

  if(canuse) {
    instance setscriptablepartstate("dmz_uav_tower", "unusable");
    instance.capturingteam = player.team;

    if(istrue(level.var_1245cb2a7bf020f7)) {
      if(scripts\engine\utility::issharedfuncdefined("uav_tower", "onCapturedChange")) {
        [[scripts\engine\utility::getsharedfunc("uav_tower", "onCapturedChange")]](instance, 1);
      }
    }

    state = instance getscriptablepartstate("dmz_uav_tower_laptop");

    if(state == "laptop_closed" && !istrue(instance.gasdisabled)) {
      instance setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
    }

    instance.successfuluse = 0;
    instance function_678ea4319b42dfed(player);
    instance setscriptablepartstate("dmz_uav_tower", "usable");

    if(!isDefined(player)) {
      return;
    }

    player notifyonplayercommandremove("interact_cancelled", "+weapnext");
    player setclientomnvar("ui_dmz_uav_tower_screen", 0);

    if(cost > 0) {
      var_4c63764d12ed5def = istrue(player.plundercount >= cost);

      if(var_4c63764d12ed5def && istrue(instance.successfuluse)) {
        players = level.players;
        instance thread function_a301051f63fbbff9(instance, part, state, player, var_a5b2c541413aa895, usestring, players, oldteam);
      } else if(var_4c63764d12ed5def && !istrue(instance.successfuluse)) {} else {
        if(soundexists("ui_select_purchase_deny") && level.var_db9587440497015c) {
          player playlocalsound("ui_select_purchase_deny");
        }

        if(isDefined(level.showerrormessagefunc)) {
          player[[level.showerrormessagefunc]]("DMZ/INSUFFICIENT_MONEY_UAV_TOWER");
        }
      }
    } else if(isDefined(instance.successfuluse) && instance.successfuluse) {
      players = level.players;
      instance thread function_a301051f63fbbff9(instance, part, state, player, var_a5b2c541413aa895, usestring, players, oldteam);
    }

    return;
  }

  if(!var_4c63764d12ed5def) {
    if(soundexists("ui_select_purchase_deny") && level.var_db9587440497015c) {
      player playlocalsound("ui_select_purchase_deny");
    }

    if(isDefined(level.showerrormessagefunc)) {
      player[[level.showerrormessagefunc]]("DMZ/INSUFFICIENT_MONEY_UAV_TOWER");
    }

    return;
  }

  if(soundexists("br_pickup_deny") && level.var_db9587440497015c) {
    player playlocalsound("br_pickup_deny");
  }

  if(isDefined(level.showerrormessagefunc)) {
    player[[level.showerrormessagefunc]]("DMZ/INACTIVE_UAV_TOWER");
  }
}

function function_678ea4319b42dfed(player) {
  if(istrue(self.var_45e35ef2a973ecb)) {
    self.successfuluse = 1;
    return;
  }

  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");
  player playlocalsound("uav_tower_foley");
  player playSound("uav_tower_foley_npc", player, player);
  thread watchplayerdeathordisconnect(player);
  typinganimstart(player);
  player setclientomnvar("ui_dmz_uav_tower_screen", 1);
  thread function_667fd79f2b5d6436(player);
  function_e71d6089ebd93181(player);
  function_b61464b3867d7ba3(player);
  player notify("interact_finished");
  player function_3c288bbdd4016fd4(1);

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(player)) {
    player notify("remove_rig");
  }
}

function private function_a39eabffc4fe3719() {
  return self.origin + rotatevector((-1.279, -55.632, 0), self.angles);
}

function private function_af548fb33b12cba1() {
  return combineangles(self.angles, (0, 90, 0));
}

function watchgunlessweapon() {
  self endon("watch_gunless_weapon");
  waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "interact_interrupt");

  if(isDefined(self)) {
    thread scripts\cp_mp\utility\inventory_utility::function_9897d143c3feee05();
  }
}

function typinganimstart(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player function_3c288bbdd4016fd4(0);
  player.linktoent = player spawn_tag_origin(player.origin, player getplayerangles(0));
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 0, 0, 1, 0);
  goalpos = function_a39eabffc4fe3719();
  var_bb4c5aaff39749f7 = (10, 0, 0);
  var_de179dc7a706ad8f = combineangles((0, 90, 0), var_bb4c5aaff39749f7);
  goalangles = combineangles(self.angles, var_de179dc7a706ad8f);
  movetotime = 0.5;

  if(isDefined(self.linkedparent)) {
    player.linktoent childthread function_1f6d35ecbf0ed006(self, (-1.279, -55.632, 0), var_de179dc7a706ad8f, movetotime);
  } else {
    player.linktoent moveTo(goalpos, movetotime, 0.1, 0.1);
    player.linktoent rotateTo(goalangles, movetotime, 0.1, 0.1);
  }

  player setstance("crouch");
  player thread watchgunlessweapon();
  var_cd9982adb17761a8 = gettime();
  player scripts\cp_mp\utility\inventory_utility::function_fc6a5b145563be33();
  var_698cc218e4ade75f = gettime();
  var_218f64cb035d54be = max(0, movetotime - (var_698cc218e4ade75f - var_cd9982adb17761a8) / 1000);
  wait var_218f64cb035d54be;
  player unlink();

  if(player.linktoent islinked()) {
    player.linktoent unlink();
  }

  player.linktoent delete();
  player.linktoent = undefined;
  player setOrigin(function_a39eabffc4fe3719());
  player setplayerangles(function_af548fb33b12cba1());
  animname = "use_uav_tower_enter";
  player notify("watch_gunless_weapon");
  player thread create_player_rig("uav_tower", function_a39eabffc4fe3719(), function_af548fb33b12cba1(), self);
  player.player_rig showonlytoplayer(player);

  if(!isDefined(self.animstruct)) {
    if(isDefined(self.linkedparent)) {
      animstruct = spawn_tag_origin();
    } else {
      animstruct = spawnStruct();
    }

    animstruct.origin = self.origin;
    animstruct.angles = combineangles(self.angles, combineangles((0, 180, 0), (0, 90, 0)));
    self.animstruct = animstruct;
  }

  if(isDefined(self.linkedparent)) {
    self.animstruct linkTo(self.linkedparent);
  }

  self.animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, animname);
}

function private function_1f6d35ecbf0ed006(uav_tower, goaloffset, goalangles, movetotime) {
  start_time_ms = gettime();
  end_time_ms = gettime() + movetotime * 1000;
  startoffset = rotatevectorinverted(self.origin - uav_tower.origin, uav_tower.angles);
  startangles = function_848155be2b7da2cb(uav_tower.angles, self.angles);
  var_2ae616b335d7e33d = uav_tower.origin;

  while(isDefined(self) && gettime() < end_time_ms) {
    var_7aeab0bcca4b2d64 = gettime() + function_676cfe2ab64ea758();
    t = (var_7aeab0bcca4b2d64 - start_time_ms) / movetotime * 1000;
    deltapos = uav_tower.origin - var_2ae616b335d7e33d;
    targetoffset = vectorlerp(startoffset, goaloffset, t);
    self.origin = uav_tower.origin + rotatevector(targetoffset, uav_tower.angles) + deltapos;
    worldangles = combineangles(uav_tower.angles, anglelerpquatfrac(startangles, goalangles, t));
    self.angles = worldangles;
    var_2ae616b335d7e33d = uav_tower.origin;
    waitframe();
  }
}

function function_667fd79f2b5d6436(player) {
  player endon("interact_interrupt");
  player endon("disconnect");
  waitframe();
  player notifyonplayercommand("interact_cancelled", "+weapnext");
  self.cancel = 0;
  msg = player waittill_any_timeout_no_endon_death_1(level.towerusetime, "interact_cancelled");
  self.cancel = 1;

  if(msg == "interact_cancelled") {
    player stoplocalsound("uav_tower_foley");
    wait 0.25;
    player setclientomnvar("ui_dmz_uav_tower_screen", 0);
    return;
  }

  self.successfuluse = 1;
  player notify("interact_begin_exit");
}

function watchplayerdeathordisconnect(player) {
  player endon("interact_cancelled");
  player endon("interact_finished");
  player scripts\engine\utility::waittill_any_3("death_or_disconnect", "enter_live_ragdoll", "last_stand_start");

  if(!isDefined(player)) {
    return;
  }

  player notify("interact_interrupt");
  player stopanimscriptsceneevent();
  player stoplocalsound("uav_tower_foley");

  if(isDefined(player.linktoent)) {
    player unlink();
    player.linktoent delete();
    player.linktoent = undefined;
  }

  player notify("remove_rig");
  player function_3c288bbdd4016fd4(1);
}

function function_e71d6089ebd93181(player, instance) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_begin_exit");
  player endon("interact_cancelled");

  while(isreallyalive(player)) {
    self.animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, "use_uav_tower_idle");
  }
}

function function_b61464b3867d7ba3(player) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  player endon("interact_interrupt");

  if(isreallyalive(player)) {
    self.animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, "use_uav_tower_exit");
  }

  if(isent(self.animstruct)) {
    self.animstruct delete();
    self.animstruct = undefined;
  }
}

function function_3c288bbdd4016fd4(isallowed) {
  if(!isallowed) {
    val::set("typing", "allow_jump", 0);
    val::set("typing", "gesture", 0);
    val::set("typing", "melee", 0);
    val::set("typing", "mantle", 0);
    val::set("typing", "offhand_weapons", 0);
    val::set("typing", "allow_movement", 0);
    val::set("typing", "sprint", 0);
    val::set("typing", "fire", 0);
    val::set("typing", "reload", 0);
    val::set("typing", "weapon_pickup", 0);
    val::set("typing", "weapon_switch", 0);
    val::set("typing", "offhand_weapons", 0);
    val::set("typing", "execution_victim", 0);
    val::set("typing", "supers", 0);
    val::set("typing", "usability", 0);
    val::set("typing", "third_person_toggle", 0);
    self setclientomnvar("ui_br_inventory_disabled", 1);
    self function_35501b42058d4de9();
    return;
  }

  val::reset_all("typing");
  self setclientomnvar("ui_br_inventory_disabled", 0);
  self function_bb04491d50d9e43e();
}

function function_a301051f63fbbff9(instance, part, state, player, var_a5b2c541413aa895, usestring, players, oldteam) {
  player endon("death_or_disconnect");
  player endon("enter_live_ragdoll");
  level notify("uav_tower_activated", instance);

  if(isDefined(instance.var_27e49251bb3376ea)) {
    if(issharedfuncdefined("uav_tower", "tower_disable")) {
      [[getsharedfunc("uav_tower", "tower_disable")]](instance, "different_team_activated");
    }
  }

  cost = player function_26fc3305456d700f(instance);

  if(cost > 0) {
    player function_1dd4b75d0a512fcc(cost, instance);
  }

  instance.uavused = 1;
  instance setscriptablepartstate("dmz_uav_tower_antenna", "active_start");
  instance setscriptablepartstate("objective", "active");
  player thread function_550deeac761ab7b9(instance);

  if(!istrue(level.var_1245cb2a7bf020f7)) {
    instance setscriptablepartstate("objective", "active");
    player thread function_550deeac761ab7b9(instance);
  }

  instance.var_27e49251bb3376ea = player;
  instance.activeteam = player.team;
  instance function_fca5bdbe24070d20("objective", instance.activeteam);
  level.activetowers = array_add(level.activetowers, instance);
  instance thread function_449f829c0284b870(instance);
  thread scripts\cp_mp\talking_gun::function_952d1a246a3ece86(player);

  if(issharedfuncdefined("pmc_missions", "onUAVTowerUsed")) {
    [[getsharedfunc("pmc_missions", "onUAVTowerUsed")]](player, instance.identifier);
  }

  var_b608af6e8d86fe42 = 0;

  if(player namespace_53fc9ddbb516e6e1::function_87072b42853a9c58("specialty_uav_buff")) {
    var_b608af6e8d86fe42 = 1;
  }

  if(level.var_66bf5bfca21a8d52) {
    instance function_86a96e658bbd0cba(player.team, var_b608af6e8d86fe42);

    if(isDefined(instance.towerstruct) && istrue(instance.towerstruct.var_62bd5c5aa7a876db)) {
      instance thread function_e1a473f05677516b();
    }
  }

  instance thread _ping(instance, player.team, var_b608af6e8d86fe42);
  instance thread function_9a71dd352fe6da4b(instance, var_b608af6e8d86fe42);
  instance function_1d71dc9529bef550(undefined);
  instance.lasttimeactivated = gettime();

  if(issharedfuncdefined("game", "getSquadmates")) {
    squadmates = [[getsharedfunc("game", "getSquadmates")]](player.team, player.sessionsquadid, 1);

    foreach(ent in squadmates) {
      if(!isDefined(ent.var_c26450f6e6e47b84)) {
        ent.var_c26450f6e6e47b84 = 0;
      }

      ent.var_c26450f6e6e47b84++;

      if(isDefined(level.scoreinfo_value[#"hash_541f0b57f321a27"])) {
        bscore = 1;

        if(istrue(getdvarint(@ "hash_17570581e6190ae0", 0)) && (level.var_d507e35282b50614 == 0 || istrue(instance.var_609d30214a3a142e))) {
          bscore = 0;
        }

        if(bscore) {
          ent namespace_53fc9ddbb516e6e1::function_e800498086e36c29(#"hash_541f0b57f321a27");
        }
      }
    }

    players = undefined;

    if(!isDefined(instance.towerstruct.poi) && isDefined(instance.towerstruct.var_fb927887f6e39e4e)) {
      instance.towerstruct.poi = scripts\mp\poi::function_55cf921efa4cbd09(instance.origin, 0, 0, 1);
    }

    if(isDefined(instance.towerstruct.poi)) {
      players = level.poi[instance.towerstruct.poi]["players"];
      players = array_remove_array(players, squadmates);

      if(level.var_6bacc8cb646fa5cd) {
        scripts\cp_mp\overlord::playevent("uav_tower_used_others", players);
      }
    }

    function_66a1278496e46edb(squadmates, player.team);
    scripts\cp_mp\overlord::playevent("uav_tower_used", squadmates);

    if(level.var_db9587440497015c && level.var_d507e35282b50614 && !istrue(instance.var_609d30214a3a142e)) {
      wait 1;
    }

    if(issharedfuncdefined("hud", "showBrDMZSplash")) {
      if(isDefined(instance.towerstruct.poi)) {
        if(issharedfuncdefined("hud", "showBrDMZSplash")) {
          if(isDefined(players)) {
            [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_uav_tower_activated_others", players, instance.towerstruct.poi);
          }

          [[getsharedfunc("hud", "showBrDMZSplash")]]("dmz_uav_tower_activated_team", squadmates, instance.towerstruct.poi);
        } else if(issharedfuncdefined("hud", "showDMZSplash")) {
          if(level.var_6bacc8cb646fa5cd && isDefined(players)) {
            [[getsharedfunc("hud", "showDMZSplash")]]("dmz_uav_tower_activated_others", players, instance.towerstruct.poi);
          }

          [[getsharedfunc("hud", "showDMZSplash")]]("dmz_uav_tower_activated_team", squadmates, instance.towerstruct.poi);
        }
      }
    }

    if(level.var_9f740c9281d0c7f4) {
      level thread scripts\mp\gametypes\br_public::brleaderdialogteamexcludeplayer("uav_tower_use_friendly", player.team, player, 1, undefined, 2);
      level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("uav_tower_use_first_person", player, 1, undefined, 2);
      team_players = scripts\mp\utility\teams::getteamdata(player.team, "players");
      var_42cf18bb4b294dce = scripts\mp\utility\player::getplayersinradius(instance.origin, level.var_6acf91bbf5273e8f * 1.1, undefined, team_players);

      foreach(player in var_42cf18bb4b294dce) {
        level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("uav_tower_use_enemy", player, 1, undefined, 2);
      }

      if(isDefined(oldteam)) {
        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("uav_tower_stolen", oldteam, 1, 2);
      }
    }
  }
}

function function_2a905da0882c958() {
  level endon("game_ended");

  while(true) {
    for(i = 0; i < level.uavtowers.size; i++) {
      if(isDefined(level.uavtowers[i]) && isDefined(level.uavtowers[i].uav_station)) {
        instance = level.uavtowers[i].uav_station;
        state = instance getscriptablepartstate("dmz_uav_tower_laptop");

        if(!istrue(instance.uavused) || state == "laptop_closed") {
          players = playersnear(instance.origin, 400);

          if(isDefined(players) && players.size > 0) {
            if(state == "laptop_closed" && !istrue(instance.gasdisabled)) {
              instance setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
            }
          } else if(state == "laptop_opened" && !istrue(instance.uavused)) {
            instance setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
          }
        }
      }

      wait 0.25;
    }

    wait 0.25;
  }
}

function function_fcd65de73a5fd25() {
  return getdvarint(@ "scr_enable_uav_towers", 1) == 1;
}

function tower_canuse(player) {
  if(isDefined(player) && istrue(player.var_859654e0445a36d9)) {
    if(isDefined(level.showerrormessagefunc) && isDefined(level.br_pickups.var_355cddb773cb000d)) {
      player[[level.showerrormessagefunc]](level.br_pickups.var_355cddb773cb000d);
    }

    return false;
  }

  if(player isthrowinggrenade() || player isswitchingweapon() || isDefined(player getheldoffhand()) && !isnullweapon(player getheldoffhand())) {
    if(isDefined(level.showerrormessagefunc) && isDefined(level.br_pickups.var_859f4bd204f1259)) {
      player[[level.showerrormessagefunc]](level.br_pickups.var_859f4bd204f1259);
    }

    return false;
  }

  return true;
}

function function_449f829c0284b870(instance) {
  level endon("game_ended");
  wait 1;
  instance setscriptablepartstate("activated_oneshot_audio", "on");
  instance setscriptablepartstate("activated_alarm_tell", "on");
}

function function_1dd4b75d0a512fcc(amount, data) {
  resultdata = scripts\mp\gametypes\br_plunder::playerplunderevent(amount, 4, undefined, data);

  if(isDefined(resultdata)) {
    if(soundexists("ui_select_purchase_confirm") && level.var_db9587440497015c && level.var_d507e35282b50614 && !istrue(data.var_609d30214a3a142e)) {
      self playlocalsound("ui_select_purchase_confirm");
    }

    perskey = "highestPurchaseCost";

    if(!isDefined(self.pers[perskey]) || self.pers[perskey] < amount) {
      self.pers[perskey] = amount;
    }
  }

  scripts\mp\gametypes\br_plunder::function_5a2284274d70f7d(4, amount);
  return resultdata;
}

function dangercircletick(dangercircleorigin, dangercircleradius, thresholdradius) {
  var_52d59c928eb97c81 = dangercircleradius + thresholdradius;

  if(isDefined(level.uavtowers)) {
    foreach(tower in level.uavtowers) {
      if(istrue(tower.uav_station.ignore_gas)) {
        continue;
      }

      incircle = 1;

      if(distance2dsquared(dangercircleorigin, tower.uav_station.origin) > var_52d59c928eb97c81 * var_52d59c928eb97c81) {
        incircle = 0;
      }

      if(!incircle && !tower.uav_station.gasdisabled) {
        tower_disable(tower.uav_station, "in_gas");
        tower.uav_station setscriptablepartstate("dmz_uav_tower", "unusable");
        tower.uav_station setscriptablepartstate("objective", "none");
        tower.uav_station setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
        tower.uav_station.gasdisabled = 1;
        level.var_4414dbbf9d80d75d[level.var_4414dbbf9d80d75d.size] = tower;
        continue;
      }

      if(incircle && tower.uav_station.gasdisabled) {
        tower.uav_station setscriptablepartstate("dmz_uav_tower", "usable");
        tower.uav_station setscriptablepartstate("objective", "inactive");
        tower.uav_station.gasdisabled = 0;
        level.var_4414dbbf9d80d75d = array_remove(level.var_4414dbbf9d80d75d, tower);
      }
    }
  }
}

function function_1a1709943670772a() {
  if(isDefined(level.uavtowers)) {
    foreach(tower in level.uavtowers) {
      if(istrue(tower.uav_station.ignore_gas)) {
        continue;
      }

      if(!scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(tower.uav_station.origin) && !tower.uav_station.gasdisabled) {
        tower_disable(tower.uav_station, "in_gas");
        tower.uav_station setscriptablepartstate("dmz_uav_tower", "unusable");
        tower.uav_station setscriptablepartstate("objective", "none");
        tower.uav_station setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
        tower.uav_station.gasdisabled = 1;
        level.var_4414dbbf9d80d75d[level.var_4414dbbf9d80d75d.size] = tower;
        continue;
      }

      if(scripts\mp\gametypes\br_circle_util::ispointinmulticircledanger(tower.uav_station.origin) && tower.uav_station.gasdisabled) {
        tower.uav_station setscriptablepartstate("dmz_uav_tower", "usable");
        tower.uav_station setscriptablepartstate("objective", "inactive");
        tower.uav_station.gasdisabled = 0;
        level.var_4414dbbf9d80d75d = array_remove(level.var_4414dbbf9d80d75d, tower);
      }
    }
  }
}

function function_907613649c1c683d(allowgas) {
  if(isDefined(level.uavtowers)) {
    foreach(tower in level.uavtowers) {
      if(tower.uav_station.gasdisabled) {
        tower.uav_station setscriptablepartstate("dmz_uav_tower", "usable");
        tower.uav_station setscriptablepartstate("objective", "inactive");

        if(istrue(allowgas)) {
          tower.uav_station.gasdisabled = 0;
        }

        level.var_4414dbbf9d80d75d = array_remove(level.var_4414dbbf9d80d75d, tower);
      }
    }
  }
}

function function_86a96e658bbd0cba(team, var_b608af6e8d86fe42) {
  radius = int(level.var_6acf91bbf5273e8f * ter_op(isDefined(level.var_c0fe6cb6face684e) && var_b608af6e8d86fe42, level.var_c0fe6cb6face684e, 1));
  function_6b6b6273f8180522("active_uav_tower_radius", self.origin, radius);
  function_6988310081de7b45();

  if(isDefined(team)) {
    foreach(player in scripts\mp\utility\teams::getteamdata(team, "players")) {
      function_d7d113d56ef0ef5b(player);
    }
  }
}

function function_e1a473f05677516b() {
  self endon("death");
  self endon("tower_disable");
  level endon("game_ended");

  while(true) {
    function_6e148c8da2e4db13(self.origin);
    waitframe();

    if(!function_acaa75ca8754452e()) {
      break;
    }
  }
}

function function_c3476653bc728729() {
  if(function_acaa75ca8754452e()) {
    function_af5604ce591768e1();
  }
}

function function_6bdc6f56944dc3aa(player, oldteam, newteam) {
  if(level.var_66bf5bfca21a8d52) {
    foreach(tower in level.activetowers) {
      if(isDefined(tower.activeteam)) {
        if(tower.activeteam == oldteam) {
          tower function_cfd53c8f6878014f(player);
        }

        if(tower.activeteam == newteam) {
          tower function_d7d113d56ef0ef5b(player);
        }
      }
    }
  }
}

function function_26fc3305456d700f(instance) {
  if(isDefined(level.var_d507e35282b50614) && level.var_d507e35282b50614 > 0 && !istrue(instance.var_609d30214a3a142e)) {
    return int(level.var_d507e35282b50614 * function_e1693023b9a46a8a());
  }

  return 0;
}

function function_e1693023b9a46a8a() {
  var_4e5b987a9eefeb1c = 1;
  var_c6df0612e7a6c4b2 = 1;

  if(isDefined(level.var_667c8146dba70095) && array_contains_key(level.var_667c8146dba70095, self.guid)) {
    foreach(source in level.var_667c8146dba70095[self.guid]) {
      if(istrue(source["additive"])) {
        var_4e5b987a9eefeb1c += source["modifier"];
        continue;
      }

      var_c6df0612e7a6c4b2 *= source["modifier"];
    }
  }

  return var_4e5b987a9eefeb1c * var_c6df0612e7a6c4b2;
}

function function_5ee813ae390b4ce5(source, modifier, additive, overwriteexisting) {
  if(!isDefined(level.var_667c8146dba70095)) {
    level.var_667c8146dba70095 = [];
  }

  if(!array_contains_key(level.var_667c8146dba70095, self.guid)) {
    level.var_667c8146dba70095[self.guid] = [];
  }

  assert(istrue(overwriteexisting) || !array_contains_key(level.var_667c8146dba70095[self.guid], source));
  level.var_667c8146dba70095[self.guid][source] = [];
  level.var_667c8146dba70095[self.guid][source]["additive"] = istrue(additive);
  level.var_667c8146dba70095[self.guid][source]["modifier"] = modifier;
}

function function_ade912f6ea99fe68(source) {
  if(isDefined(level.var_667c8146dba70095) && array_contains_key(level.var_667c8146dba70095, self.guid) && array_contains_key(level.var_667c8146dba70095[self.guid], source)) {
    level.var_667c8146dba70095[self.guid][source] = undefined;
  }
}

function function_9ecd5a6088d14c68() {
  if(isDefined(level.var_667c8146dba70095) && array_contains_key(level.var_667c8146dba70095, self.guid)) {
    level.var_667c8146dba70095[self.guid] = undefined;
  }
}

function function_1d71dc9529bef550(var_351a92897da4ba3a) {
  var_6bc7cdb2fec919e7 = self;
  eventparams = [];
  eventparams[eventparams.size] = "player_activated_xuid";
  playeractivated = var_6bc7cdb2fec919e7.var_27e49251bb3376ea;

  if(!isDefined(playeractivated)) {
    playerxuid = "";
  } else {
    playerxuid = playeractivated getxuid();
  }

  eventparams[eventparams.size] = playerxuid;
  eventparams[eventparams.size] = "team_activated";

  if(isDefined(playeractivated) && isDefined(playeractivated.team)) {
    teamname = playeractivated.team;
  } else {
    teamname = "neutral";
  }

  eventparams[eventparams.size] = teamname;
  eventparams[eventparams.size] = "cost_activated";

  if(teamname == "neutral") {
    cost = 0;
  } else {
    cost = playeractivated function_26fc3305456d700f(var_6bc7cdb2fec919e7);
  }

  eventparams[eventparams.size] = cost;
  eventparams[eventparams.size] = "tower_x";
  towerx = var_6bc7cdb2fec919e7.origin[0];
  eventparams[eventparams.size] = towerx;
  eventparams[eventparams.size] = "tower_y";
  towery = var_6bc7cdb2fec919e7.origin[1];
  eventparams[eventparams.size] = towery;
  eventparams[eventparams.size] = "tower_z";
  towerz = var_6bc7cdb2fec919e7.origin[2];
  eventparams[eventparams.size] = towerz;
  eventparams[eventparams.size] = "last_time_activated";
  lasttimeactivated = -1;

  if(isDefined(var_6bc7cdb2fec919e7.lasttimeactivated)) {
    lasttimeactivated = int((gettime() - var_6bc7cdb2fec919e7.lasttimeactivated) / 1000);
  }

  eventparams[eventparams.size] = lasttimeactivated;
  eventparams[eventparams.size] = "disable_reason";
  disablereason = "none";

  if(isDefined(var_351a92897da4ba3a)) {
    disablereason = var_351a92897da4ba3a;
  }

  eventparams[eventparams.size] = disablereason;

  if(!isDefined(playeractivated)) {
    playeractivated = scripts\mp\gamelogic::gethostplayer();
  }

  if(isDefined(playeractivated)) {
    playeractivated dlog_recordplayerevent("dlog_event_br_uav_tower", eventparams);
  }
}

function function_dc9f963b97f73b1a(data) {
  tower_disable(self, "EMP_" + data.reason);
  thread uavtowerdisablefortime(data);
}

function uavtowerdisablefortime(data) {
  self notify("UAVTowerDisableForTime");
  self endon("UAVTowerDisableForTime");
  self setscriptablepartstate("dmz_uav_tower", "unusable");

  if(!isDefined(self.temptrigger)) {
    self.temptrigger = spawn("trigger_radius", self.origin, 0, level.var_7916385e2124e7a7, 62);
    scripts\mp\utility\trigger::makeenterexittrigger(self.temptrigger, &function_2a4470bcf739b0e3, &playerexituavtowerdisabled);
    self.temptrigger.endtime = int(gettime() + function_a5b14435e3229bed(data.time));

    if(isDefined(self.towerstruct) && isDefined(self.towerstruct.traincar)) {
      self.temptrigger enablelinkTo();
      self.temptrigger linkTo(self.towerstruct.traincar);
    }
  } else if(isDefined(self.temptrigger.triggerenterents)) {
    self.temptrigger.endtime = int(gettime() + function_a5b14435e3229bed(data.time));

    foreach(player in self.temptrigger.triggerenterents) {
      player scripts\mp\utility\lower_message::setlowermessageomnvar("uav_offline", self.temptrigger.endtime);
    }
  }

  wait data.time;
  self setscriptablepartstate("dmz_uav_tower", "usable");
  self.temptrigger delete();
}

function function_2a4470bcf739b0e3(player, trigger) {
  self endon("playerExitUAVTowerDisabled");
  scripts\mp\utility\lower_message::setlowermessageomnvar("uav_offline", trigger.endtime);
  timeleft = function_c89ed1840c8d0f0f(trigger.endtime - gettime());

  while(isDefined(trigger) && timeleft > 0) {
    timeleft = function_c89ed1840c8d0f0f(trigger.endtime - gettime());
    wait timeleft;
  }

  waitframe();
  thread playerexituavtowerdisabled(player, trigger);
}

function playerexituavtowerdisabled(player, trigger) {
  scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
  self notify("playerExitUAVTowerDisabled");
}

function private function_66a1278496e46edb(squadmates, team) {
  var_45278f020a3bb7ad = 0;

  foreach(tower in level.activetowers) {
    if(isDefined(tower.activeteam) && tower.activeteam == team) {
      var_45278f020a3bb7ad++;
    }
  }

  foreach(player in squadmates) {
    scripts\cp_mp\challenges::function_8359cadd253f9604(player, "uav_tower", 1);

    if(var_45278f020a3bb7ad >= 3) {
      scripts\cp_mp\challenges::function_8359cadd253f9604(player, "three_uav_towers_active", 1);
    }
  }
}

function function_83565380b036f12d() {
  thread function_853901492bb15e03();
  waitframe();
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x73>");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x87>", @ "hash_1583aa42d0c9d90a");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:xa4>", @ "hash_1583aa42d0c9d90a");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:xc3>", @ "hash_c658346ed64f29db");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:xd2>", @ "hash_158fdc0be6244136");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:xf0>", @ "hash_ce4d8222d33e9051");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x100>", @ "hash_710ff2c3b923a971");
  scripts\common\devgui::function_fe953f000498048f();
}

function private function_853901492bb15e03() {
  level endon("<dev string:x117>");

  while(true) {
    if(getdvarint(@ "hash_1583aa42d0c9d90a", 0)) {
      setDvar(@ "hash_1583aa42d0c9d90a", 0);
      scripts\cp_mp\overlord::playevent("<dev string:x125>", level.players);

      if(issharedfuncdefined("<dev string:x137>", "<dev string:x13e>")) {
        [[getsharedfunc("<dev string:x137>", "<dev string:x13e>")]]("<dev string:x14f>", level.players, 0);
      }
    }

    if(getdvarint(@ "hash_4d4dcdd9dd9dd058", 0)) {
      setDvar(@ "hash_4d4dcdd9dd9dd058", 0);
      scripts\cp_mp\overlord::playevent("<dev string:x16f>", level.players);

      if(issharedfuncdefined("<dev string:x137>", "<dev string:x13e>")) {
        [[getsharedfunc("<dev string:x137>", "<dev string:x13e>")]]("<dev string:x188>", level.players, 0);
      }
    }

    if(getdvarint(@ "hash_c658346ed64f29db", 0)) {
      setDvar(@ "hash_c658346ed64f29db", 0);

      foreach(player in level.players) {
        if(!isDefined(player) || !isDefined(player.origin)) {
          continue;
        }

        forward = anglesToForward(player getplayerangles());
        pos = player.origin + forward * 300;
        pos = drop_to_ground(pos, 100);
        tower_struct = spawnStruct();
        tower_struct.origin = pos;
        tower_struct.angles = (0, 0, 0);
        function_858af52a8e277a68(tower_struct, level.uavtowers.size);
      }
    }

    if(getdvarint(@ "hash_158fdc0be6244136", 0)) {
      setDvar(@ "hash_158fdc0be6244136", 0);

      foreach(player in level.players) {
        if(!isDefined(player) || !isDefined(player.origin)) {
          continue;
        }

        closest_tower = sortbydistance(level.uavtowers, player.origin)[0];

        if(isDefined(closest_tower)) {
          closest_tower function_678ea4319b42dfed(player);
        }
      }
    }

    if(getdvarint(@ "hash_ce4d8222d33e9051", 0)) {
      setDvar(@ "hash_ce4d8222d33e9051", 0);

      foreach(player in level.players) {
        if(!isDefined(player) || !isDefined(player.origin)) {
          continue;
        }

        var_b608af6e8d86fe42 = 0;

        if(player namespace_53fc9ddbb516e6e1::function_87072b42853a9c58("<dev string:x1aa>")) {
          var_b608af6e8d86fe42 = 1;
        }

        radius = int(level.var_6acf91bbf5273e8f * ter_op(isDefined(level.var_c0fe6cb6face684e) && var_b608af6e8d86fe42, level.var_c0fe6cb6face684e, 1));
        triggerportableradarpingteam(player.origin, player.team, radius, level.var_39f69f7dfc40a323);
      }
    }

    if(getdvarint(@ "hash_710ff2c3b923a971", 0)) {
      setDvar(@ "hash_710ff2c3b923a971", 0);

      foreach(player in level.players) {
        if(!isDefined(player) || !isDefined(player.origin)) {
          continue;
        }

        player namespace_53fc9ddbb516e6e1::function_e800498086e36c29(#"hash_541f0b57f321a27");
      }
    }

    if(getdvarint(@ "hash_9705adb45ef93ac", 0)) {
      setDvar(@ "hash_9705adb45ef93ac", 0);
      function_907613649c1c683d(0);
    }

    waitframe();
  }
}

# /