/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\robj.gsc
***********************************************/

#using script_7c32d91c895c063e;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\uav_tower;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\dev;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\koth;
#using scripts\mp\gametypes\obj_bombzone;
#using scripts\mp\gametypes\obj_zonecapture;
#using scripts\mp\gametypes\robj;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnfactor;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\points;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\spawn_event_aggregator;
#using scripts\mp\utility\stats;
#namespace robj;

function main() {
  if(getDvar(@ "g_mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  function_8974f2acabebbc99();
  precachestring(&"JUP_MP/SECURE_INTERACT");
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 600);
    registerscorelimitdvar(getgametype(), 100);
    registerroundlimitdvar(getgametype(), 1);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
    function_704789086c9ad943(getgametype(), 1);
  }

  updategametypedvars();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_c80e5eaa70aba7d7);
  setdvarifuninitialized(@ "hash_50de136606fc41da", 0);
  level.objectivebased = 1;
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.getspawnpoint = &getspawnpoint;
  level.onplayerconnect = &onplayerconnect;
  level.onplayerkilled = &onplayerkilled;
  level.resetuiomnvargamemode = &scripts\mp\gametypes\obj_bombzone::resetuiomnvargamemode;
  level.getkothzonedeadzonedist = &scripts\mp\gametypes\koth::getkothzonedeadzonedist;
  level.var_a4f0b18944c00689 = &function_75043e7e3c552318;
  level.var_da752fc97f989d07 = &function_72c78e10b4cdbdae;
  level.disablebuddyspawn = 1;
  level.gamemodemaydropweapon = &isplayeroutsideofanybombsite;
  level.ontimelimit = &ontimelimit;
  level.var_2550904ae7eb2a1c = dvarfloatvalue("securecapturebottimemod", 1.35, 1.35, 1.35);
  level.var_ee1c5b2643a1c2f9 = &namespace_cb9ef225b7a59984::function_2ea2aacc5d66ae03;
  game["dialog"]["gametype"] = "dx_mp_secu_game_tf141_name";
  game["dialog"]["robj_objective_intermission"] = "dx_mp_secu_game_tf141_sint";
  game["dialog"]["robj_enemy_took_objective"] = "dx_mp_secu_game_tf141_slos";
  game["dialog"]["robj_enemy_took_objective_helicopter"] = "dx_mp_secu_game_tf141_slsh";
  game["dialog"]["robj_enemy_took_objective_panels"] = "dx_mp_secu_game_tf141_slsp";
  game["dialog"]["robj_friendly_took_objective"] = "dx_mp_secu_game_tf141_swon";
  game["dialog"]["robj_friendly_took_objective_helicopter"] = "dx_mp_secu_game_tf141_swnh";
  game["dialog"]["robj_friendly_took_objective_panels"] = "dx_mp_secu_game_tf141_swnp";
  game["dialog"]["robj_objective_available"] = "dx_mp_secu_game_tf141_snew";
  game["dialog"]["robj_player_close_to_outdoor_objective"] = "dx_mp_secu_game_tf141_spra";
  game["dialog"]["robj_player_close_to_indoor_objective"] = "dx_mp_secu_game_tf141_sppc";
  game["dialog"]["robj_player_close_to_helicopter_objective"] = "dx_mp_secu_game_tf141_sphl";
  game["dialog"]["robj_player_close_to_panels_objective"] = "dx_mp_secu_game_tf141_sppn";
  game["dialog"]["boost"] = "dx_mp_secu_game_tf141_bost";
  game["dialog"]["offense_obj"] = "dx_mp_secu_game_tf141_bost";
  game["dialog"]["defense_obj"] = "dx_mp_secu_game_tf141_bost";

  level thread function_c6311773113bd9d9();
}

function onplayerconnect(player) {
  if(isDefined(player.pers["captures"])) {
    player setextrascore0(player.pers["captures"]);
    return;
  }

  player scripts\mp\persistence::statsetchild("round", "captures", 0);
  player incpersstat("captures", 0);
  player setextrascore0(0);
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  if(!isPlayer(attacker) || is_equal(attacker.pers["team"], self.pers["team"])) {
    return;
  }

  if(isDefined(objweapon) && scripts\cp_mp\weapon::iskillstreakweapon(objweapon.basename)) {
    return;
  }

  victim = self;
  var_9ff9376383f4bc58 = 0;
  attackerteam = attacker.pers["team"];
  var_229449cfd54fdc5b = attacker isonobjective();
  var_9d0123af024e86ac = victim isonobjective();
  ownerteam = level.current_objectives[0].ownerteam;

  if(attackerteam != ownerteam) {
    if(level.bombtimer > 0 && var_229449cfd54fdc5b) {
      attacker thread function_e3e3e81453fd788b(#"capture_kill");
      attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(11, 1);
    } else if(var_9d0123af024e86ac) {
      attacker thread scripts\mp\rank::scoreeventpopup(#"assault");
      attacker thread scripts\mp\utility\points::doscoreevent(#"mode_x_assault");
      attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(11, 1);
      thread utility::trycall(level.matchdata_logvictimkillevent, killid, "defending");
    }

    return;
  }

  if(var_229449cfd54fdc5b) {
    attacker thread scripts\mp\rank::scoreeventpopup(#"defend");
    attacker thread scripts\mp\utility\points::doscoreevent(#"hash_2d96ced878338cd2");
    attacker incpersstat("defends", 1);
    attacker scripts\mp\codcasterclientmatchdata::function_48544e365f4f5648(11, 1);
    attacker scripts\mp\persistence::statsetchild("round", "defends", attacker.pers["defends"]);
    attacker setextrascore1(attacker.pers["defends"]);
  }
}

function isonobjective() {
  foreach(objective in level.current_objectives) {
    if(distance2d(self.origin, objective.curorigin) < 200 && abs(self.origin[2] - objective.curorigin[2]) < 100) {
      return true;
    }
  }

  return false;
}

function function_8974f2acabebbc99() {
  registersharedfunc("robj", "removeExistingCaptureBot", &removeexistingcapturebot);
  registersharedfunc("robj", "setUpNewCaptureBot", &setupnewcapturebot);
  registersharedfunc("robj", "identifyObjTypForCaptureBot", &identifyobjtypforcapturebot);
}

function ontimelimit() {
  if(istrue(level.var_e659579aba69a420)) {
    return;
  }

  winner = scripts\mp\gamescore::gethighestscoringteam();

  if(is_equal(winner, "tie")) {
    foreach(player in level.players) {
      player thread scripts\mp\hud_message::showsplash("robj_overtime_start");
    }

    level.var_e659579aba69a420 = 1;
    winner = function_9e1ae8ace1cb41e2();
    thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["score_limit_reached"]);
    return;
  }

  thread scripts\mp\gamelogic::endgame(winner, game["end_reason"]["time_limit_reached"]);
}

function function_9e1ae8ace1cb41e2() {
  level waittill("update_team_score", team);
  return team;
}

function function_c6311773113bd9d9() {
  level endon("<dev string:x1c>");
  level thread function_36108d670d10409a();
  level thread function_428317dcdbacd650();

  while(true) {
    function_9846df05d91ac5da();
    waitframe();
  }
}

function function_428317dcdbacd650() {
  while(true) {
    value = getdvarint(@ "hash_9cb2fff505145d23", 0);

    if(value && isDefined(level.objectives) && isDefined(level.player)) {
      objective = function_d23c7c1add9fb181(level.player.origin);
      deadzonedist = [[level.getkothzonedeadzonedist]]();
      maxdist = [[level.var_a4f0b18944c00689]]();
      fallbackdist = [[level.var_da752fc97f989d07]]();
      cylinder(objective.trigger.originalpos, objective.trigger.originalpos + (0, 0, 1), deadzonedist, (1, 0, 0), 0, 25);
      cylinder(objective.trigger.originalpos, objective.trigger.originalpos + (0, 0, 1), maxdist, (1, 0, 0), 0, 25);
      cylinder(objective.trigger.originalpos, objective.trigger.originalpos + (0, 0, 1), fallbackdist, (1, 0, 1), 0, 25);

      foreach(spawner in array_randomize(objective.spawnpoints)) {
        line(objective.curorigin, spawner.origin, (0, 0, 1), 1, 0, 1);
        scripts\mp\dev::drawspawnpoint(spawner, spawner.classname, (1, 1, 1));
      }

      foreach(spawner in array_randomize(objective.fallbackspawnpoints)) {
        line(objective.curorigin, spawner.origin, (1, 1, 1), 1, 0, 1);
        scripts\mp\dev::drawspawnpoint(spawner, spawner.classname, (1, 1, 1));
      }
    }

    waitframe();
  }
}

function function_36108d670d10409a() {
  while(true) {
    value = getdvarint(@ "hash_45d4ff515c25258b", 0);

    if(value && isDefined(level.objectives)) {
      level.var_c9f9d8abf3ccd83f = [];

      foreach(objective in level.objectives) {
        if(!isDefined(level.var_c9f9d8abf3ccd83f[objective.trigger.script_noteworthy])) {
          level.var_c9f9d8abf3ccd83f[objective.trigger.script_noteworthy] = [];
        }

        level.var_c9f9d8abf3ccd83f[objective.trigger.script_noteworthy] = array_add(level.var_c9f9d8abf3ccd83f[objective.trigger.script_noteworthy], objective);
      }

      foreach(array in level.var_c9f9d8abf3ccd83f) {
        color = (1, 1, 1);

        if(array.size > 1) {
          color = (1, 0, 0);

          for(i = 0; i < array.size; i++) {
            if(isDefined(array[i + 1])) {
              line(array[i].curorigin, array[i + 1].curorigin, (1, 0, 0), 1, 0, 1);
            }
          }
        }

        foreach(objective in array) {
          print3d(objective.curorigin + (0, 0, 64), objective.trigger.script_noteworthy, color, 1, 1, 1, 1);
        }
      }
    }

    waitframe();
  }
}

function function_9846df05d91ac5da() {
  value = getdvarint(@ "hash_e0fb8d4f2cc4a40c", 0);

  if(value && isDefined(level.objectives)) {
    setDvar(@ "hash_e0fb8d4f2cc4a40c", 0);
    setDvar(@ "bot_disableattack", 1);

    if(level.players.size <= 1) {
      setDvar(@ "hash_2d5236cbe9894aff", 1);
      level waittill("<dev string:x2a>", player);
      player waittill("<dev string:x37>");
      wait 1;
      player setOrigin(level.players[0].origin + 64 * vectorNormalize(vectortoangles(level.players[0].angles)));
      wait 1;
    } else {
      player = level.players[1];
    }

    level.current_objectives[0].trigger notify("<dev string:x42>", player);
  }
}

function function_c80e5eaa70aba7d7() {
  player = self;
  player thread function_169f34c107ca9253();
}

function function_169f34c107ca9253() {
  player = self;
  player endon("disconnect");
  namespace_cb9ef225b7a59984::function_2e61a0f1c846a9c2(player);
  namespace_cb9ef225b7a59984::function_353ca278babb871e(player);

  if(istrue(player.var_169f34c107ca9253)) {
    return;
  }

  player.var_169f34c107ca9253 = 1;

  while(!isDefined(level.var_80bce1fe9a035033)) {
    waitframe();
  }

  level.var_80bce1fe9a035033 function_cfd53c8f6878014f(player);
  level.var_80bce1fe9a035033 thread questcircle_run_vo_hint_when_close(player);
  namespace_cb9ef225b7a59984::function_e99ea42a85a85757(player);
  level.var_80bce1fe9a035033 thread namespace_cb9ef225b7a59984::detectplayerinsidequestcircle(player);
  namespace_cb9ef225b7a59984::function_2d908d3021b52c73(player);

  while(true) {
    level waittill("new_robj_location");
    level.var_80bce1fe9a035033 function_cfd53c8f6878014f(player);
    level.var_80bce1fe9a035033 thread questcircle_run_vo_hint_when_close(player);
    namespace_cb9ef225b7a59984::function_e99ea42a85a85757(player);
    level.var_80bce1fe9a035033 thread namespace_cb9ef225b7a59984::detectplayerinsidequestcircle(player);
    namespace_cb9ef225b7a59984::function_6b56d2c2eae0b9af(player);
    namespace_cb9ef225b7a59984::function_2d908d3021b52c73(player);
  }
}

function questcircle_run_vo_hint_when_close(player) {
  player notify("questCircle_run_VO_hint_when_close");
  player endon("questCircle_run_VO_hint_when_close");
  player endon("disconnect");

  if(!function_31d8fdff7106eaba(player)) {
    wait 3;

    while(!function_31d8fdff7106eaba(player)) {
      waitframe();
    }
  }

  foreach(objective in level.current_objectives) {
    dialogline = function_1faae1bb72f526fb(objective.scriptable, "near");

    if(dialogline != "") {
      scripts\mp\utility\dialog::leaderdialogonplayers(dialogline, [player]);
      return;
    }
  }
}

function function_1faae1bb72f526fb(scriptable, event) {
  scriptable_name = scriptable function_bea6c5f32629f766();
  returnstr = "";

  switch (scriptable_name) {
    case #"hash_7461b582f15d5954":
      if(event == "near") {
        returnstr = "robj_player_close_to_indoor_objective";
      }

      if(event == "taken") {
        returnstr = "robj_friendly_took_objective";
      }

      if(event == "lost") {
        returnstr = "robj_enemy_took_objective";
      }

      break;
    case #"hash_7942b6b104bfd8d4":
      if(event == "near") {
        returnstr = "robj_player_close_to_panels_objective";
      }

      if(event == "taken") {
        returnstr = "robj_friendly_took_objective_panels";
      }

      if(event == "lost") {
        returnstr = "robj_enemy_took_objective_panels";
      }

      break;
    case #"hash_23316c7b6e9eee0a":
      if(event == "near") {
        returnstr = "robj_player_close_to_helicopter_objective";
      }

      if(event == "taken") {
        returnstr = "robj_friendly_took_objective_helicopter";
      }

      if(event == "lost") {
        returnstr = "robj_enemy_took_objective_helicopter";
      }

      break;
    case #"hash_a75e34b940af0387":
      if(event == "near") {
        returnstr = "robj_player_close_to_outdoor_objective";
      }

      if(event == "taken") {
        returnstr = "robj_friendly_took_objective";
      }

      if(event == "lost") {
        returnstr = "robj_enemy_took_objective";
      }

      break;
    default:
      break;
  }

  return returnstr;
}

function function_31d8fdff7106eaba(player) {
  points = [];

  if(!isDefined(level.current_objectives)) {
    return false;
  }

  foreach(objective in level.current_objectives) {
    points[points.size] = objective.curorigin;
  }

  origin = averagepoint(points);
  return distance2d(origin, player.origin) < 700;
}

function function_149c978226839fe2(objective) {
  return objective.scriptable.model != "jup_military_secure_mode_station_01";
}

function function_52edd4d6e6b699f2() {
  while(!isDefined(level.objectives)) {
    waitframe();
  }

  if(isDefined(level.current_objectives)) {
    foreach(objective in level.current_objectives) {
      foreach(dangerid in objective.dangerzoneids) {
        scripts\mp\spawnlogic::removespawndangerzone(dangerid);
      }
    }
  }

  level.var_80bce1fe9a035033 = spawnStruct();

  if(!isDefined(level.usedobjectives)) {
    level.usedobjectives = [];
  }

  if(level.objectives.size == level.usedobjectives.size) {
    return;
  }

  if(isDefined(level.current_objectives)) {
    foreach(objective in level.current_objectives) {
      function_a9a2bef3ba198a85(objective.scriptable);
    }
  }

  objective = undefined;
  possibleobjectives = function_8ab4263516ea015f(level.current_objectives, !istrue(level.var_4ece7d1697e1214));

  if(possibleobjectives.size == 0) {
    objective = random(array_remove_array(level.objectives, level.usedobjectives));
  } else {
    objective = random(array_remove_array(possibleobjectives, level.usedobjectives));
  }

  if(!isDefined(objective)) {
    objective = random(level.objectives);
  }

  if(objective.scriptable.model == "uk_electrical_box_medium_01_animated") {
    var_6a9cceb782afc949 = 1;
  } else {
    var_6a9cceb782afc949 = 0;
  }

  if(getdvarint(@ "hash_8707cc16234391", 0) && isDefined(level.player)) {
    objective = function_d23c7c1add9fb181(level.player.origin);
  }

  level.var_4ece7d1697e1214 = 1;
  level.usedobjectives = array_add(level.usedobjectives, objective);

  if(level.usedobjectives.size > 3) {
    level.usedobjectives = [level.usedobjectives[1], level.usedobjectives[2], level.usedobjectives[3]];
  }

  if(getDvar(@ "hash_ab8c774ce0027d59", "<dev string:x4d>") != "<dev string:x4d>") {
    level.usedobjectives = [objective];
  }

  level.bombtimer = dvarintvalue("bombtimer", 10, 1, 300);
  namespace_cb9ef225b7a59984::function_e92d8183093a8f29();

  if(level.usedobjectives.size > 1) {
    foreach(entry in level.teamnamelist) {
      delaythread(3, &scripts\mp\utility\dialog::leaderdialog, "robj_objective_intermission", entry);
    }

    wait level.var_db19c0508f775166;
  }

  off_x = pow(-1, randomint(2)) * 512 * randomintrange(15, 35) / 100;
  off_y = pow(-1, randomint(2)) * 512 * randomintrange(15, 35) / 100;
  origin = (objective.curorigin[0] + off_x, objective.curorigin[1] + off_y, objective.curorigin[2]);
  level thread function_2d1f2d138f937e6a("Assassination_Br", origin, 512);
  level.current_objectives = [objective];

  if(var_6a9cceb782afc949) {
    closestobjective = function_d23c7c1add9fb181(level.current_objectives[0].curorigin, level.current_objectives);
    level.current_objectives[1] = closestobjective;
  }

  if(!isDefined(level.var_2725983b6b1f32a1)) {
    namespace_cb9ef225b7a59984::function_c0ee40f76dcd495c(origin, "obscured");
    namespace_cb9ef225b7a59984::function_c0ee40f76dcd495c(origin, "on_point");
  } else {
    namespace_cb9ef225b7a59984::function_ef9c5d31f2fbc04f(origin);
  }

  if(var_6a9cceb782afc949 && !isDefined(level.var_2725983b6b1f32a1["on_point_2"])) {
    namespace_cb9ef225b7a59984::function_c0ee40f76dcd495c(origin, "on_point_2");
  }

  namespace_cb9ef225b7a59984::function_8223aee4da506330(level.players);

  foreach(entry in level.teamnamelist) {
    scripts\mp\utility\dialog::leaderdialog("robj_objective_available", entry);
  }

  namespace_cb9ef225b7a59984::function_6a2c1dff398cfc38("on_point");

  if(var_6a9cceb782afc949) {
    namespace_cb9ef225b7a59984::function_6a2c1dff398cfc38("on_point_2", level.current_objectives[1]);
  }

  level notify("new_robj_location");

  if(scripts\mp\flags::gameflag("prematch_done")) {
    objective function_9897b5b4ecf74ef3("new_location");
  }

  namespace_cb9ef225b7a59984::function_e59213769db9f8b5("obscured");
  namespace_cb9ef225b7a59984::function_e59213769db9f8b5("on_point");
  namespace_cb9ef225b7a59984::function_9a750347647b35c4("obscured", 0);
  namespace_cb9ef225b7a59984::function_9a750347647b35c4("on_point", 0);
  namespace_cb9ef225b7a59984::function_4b90183cabcea8c3("obscured", 1, 0);
  namespace_cb9ef225b7a59984::function_4b90183cabcea8c3("on_point", 0, 0);

  if(var_6a9cceb782afc949) {
    namespace_cb9ef225b7a59984::function_e59213769db9f8b5("on_point_2");
    namespace_cb9ef225b7a59984::function_9a750347647b35c4("on_point_2", 0);
    namespace_cb9ef225b7a59984::function_4b90183cabcea8c3("on_point_2", 0, 0);
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  namespace_cb9ef225b7a59984::function_defe4cadf275a0bf("obscured", level.var_b88463627a96b8b0);
  namespace_cb9ef225b7a59984::function_defe4cadf275a0bf("on_point", level.var_b88463627a96b8b0);

  if(var_6a9cceb782afc949) {
    namespace_cb9ef225b7a59984::function_defe4cadf275a0bf("on_point_2", level.var_b88463627a96b8b0);
  }

  wait level.var_b88463627a96b8b0;

  if(scripts\mp\flags::gameflag("prematch_done")) {
    objective function_9897b5b4ecf74ef3("objective_opened");
  }

  namespace_cb9ef225b7a59984::function_ecfc813d02e731c5("obscured");
  namespace_cb9ef225b7a59984::function_ecfc813d02e731c5("on_point");
  namespace_cb9ef225b7a59984::function_9a750347647b35c4("obscured", 1);
  namespace_cb9ef225b7a59984::function_9a750347647b35c4("on_point", 1);
  namespace_cb9ef225b7a59984::function_defe4cadf275a0bf("obscured", 0);
  namespace_cb9ef225b7a59984::function_defe4cadf275a0bf("on_point", 0);

  if(var_6a9cceb782afc949) {
    namespace_cb9ef225b7a59984::function_ecfc813d02e731c5("on_point_2");
    namespace_cb9ef225b7a59984::function_9a750347647b35c4("on_point_2", 1);
    namespace_cb9ef225b7a59984::function_defe4cadf275a0bf("on_point_2", 0);
  }

  foreach(objective in level.current_objectives) {
    objective scripts\mp\gameobjects::setownerteam("neutral");
  }

  foreach(objective in level.current_objectives) {
    dangerzoneids = [];
    dangerzoneids[dangerzoneids.size] = scripts\mp\spawnlogic::addspawndangerzone(objective.curorigin, [[level.getkothzonedeadzonedist]](), 4096, "allies", undefined, undefined, undefined, undefined, undefined, 1);
    dangerzoneids[dangerzoneids.size] = scripts\mp\spawnlogic::addspawndangerzone(objective.curorigin, [[level.getkothzonedeadzonedist]](), 4096, "axis", undefined, undefined, undefined, undefined, undefined, 1);
    objective.dangerzoneids = dangerzoneids;
  }

  foreach(objective in level.current_objectives) {
    updateobjectivelights("idle", objective.trigger.script_noteworthy);
    objective function_9897b5b4ecf74ef3("neutral_tick");
    objective scripts\mp\gameobjects::allowuse("any");
    function_59e0c0a902e8778c(objective.scriptable);
    objective thread run_player_interact_logic();
  }
}

function robj_do_helicopter_sequence(bombzone, scriptable) {
  level notify("robj_do_helicopter_sequence");
  level endon("robj_do_helicopter_sequence");
  struct = bombzone.var_cea6fac6a8f24927;
  startstruct = getStruct(struct.target, "targetname");
  midstruct = getStruct(startstruct.target, "targetname");
  endstruct = getStruct(midstruct.target, "targetname");
  bombzone thread function_6268e5fd6df4c426(struct);
  bombzone waittill("hack_progress_complete");
  vehicle = spawnVehicle("veh9_mil_air_heli_blima_mp", "robj_heli", "veh9_mil_air_heli_blima_physics_mp", startstruct.origin, (0, 0, 0));
  vehicle function_247ad6a91f6a4ffe(1);
  vehicle vehicleshowonminimap(0);
  vehicle.var_918c5a31037e00ee = spawnStruct();
  vehicle.var_918c5a31037e00ee.speed = 85;
  var_a973a6e2149533c5 = midstruct.target;
  midstruct.target = undefined;
  crates = getEntArray("robj_pickup_crate", "targetname");
  crate = getclosest(midstruct.origin, crates);
  vehicle scripts\common\vehicle_paths::vehicle_paths_helicopter(midstruct);
  crate moveTo(vehicle.origin + (0, 0, -256), 5, 0, 0.1);
  crate vibrate((0, -100, 0), 3.1, 1.6, 20);
  wait 5;
  scriptable setscriptablepartstate("smoke", "off");
  crate thread followhelicopter(vehicle);
  var_a3f9af1b0fc76526 = endstruct.target;
  endstruct.target = undefined;
  vehicle scripts\common\vehicle_paths::vehicle_paths_helicopter(endstruct);
  midstruct.target = var_a973a6e2149533c5;
  endstruct.target = var_a3f9af1b0fc76526;
  vehicle delete();
  crate delete();
}

function followhelicopter(vehicle) {
  vehicle endon("death");
  vehicle endon("entitydeleted");
  crate = self;

  while(true) {
    crate moveTo(vehicle.origin + (0, 0, -256), 0.7);
    wait 0.3;
  }
}

function function_74d188f8cd1044f8() {
  foreach(heli_light in getentitylessscriptablearray("scriptable_secure_lighting_helicopter_light_on_01", "classname")) {
    heli_light setscriptablepartstate("light_part", "off", 0);
  }
}

function function_6268e5fd6df4c426(struct) {
  self endon("hack_progress_complete");
  structs = getStructArray("heli_flare_circle_start", "targetname");

  if(structs.size == 0) {
    return;
  }

  heli_flare_circle_start = getclosest(struct.origin, structs);
  var_ecc05c023267c301 = getentitylessscriptablearray(heli_flare_circle_start.target, "targetname")[0];
  var_ecc05c023267c301 setscriptablepartstate("light_part", "on", 0);
  scriptable = var_ecc05c023267c301;
  scriptable_array = getentitylessscriptablearray("scriptable_secure_lighting_helicopter_light_on_01", "classname");
  scriptable_array = array_remove(scriptable_array, scriptable);
  waittime = (level.bombtimer - 5) / scriptable_array.size / 2;

  while(true) {
    scriptable setscriptablepartstate("light_part", "on", 0);
    thread function_12f94ddad72e1143(scriptable);
    wait waittime;
    scriptable_array = array_remove(scriptable_array, scriptable);
    scriptable = getclosest(scriptable.origin, scriptable_array, 64);

    if(!isDefined(scriptable)) {
      break;
    }

    if(scriptable_array.size == 0) {
      break;
    }
  }
}

function function_12f94ddad72e1143(scriptable) {
  self waittill("hack_progress_complete");
  scriptable setscriptablepartstate("light_part", "off", 0);
}

function private function_2a9783de5ed53f56(pos, prevstruct, speed, angleoverride) {
  struct = spawnStruct();
  struct.speed = speed;
  struct.origin = pos;
  struct.angles = ter_op(isDefined(angleoverride), angleoverride, prevstruct.angles);
  struct.radius = 500;
  struct.target = prevstruct;
  struct.script_anglevehicle = "1";
  return struct;
}

function function_d23c7c1add9fb181(origin, exclude) {
  array = [];
  objarray = level.objectives;
  script_noteworthy = exclude[0].trigger.script_noteworthy;

  if(isDefined(exclude)) {
    objarray = array_remove_array(level.objectives, exclude);
  }

  foreach(element in objarray) {
    array[array.size] = element;
  }

  level.var_e628a8912ad74c62 = origin;
  objectives = array_sort_with_func(array, &function_ce8bbfe1d4422f48);

  foreach(obj in objectives) {
    if(!is_equal(obj.trigger.script_noteworthy, script_noteworthy)) {
      continue;
    }

    return obj;
  }

  return objectives[0];
}

function function_ce8bbfe1d4422f48(obj1, obj2) {
  return distance(obj1.curorigin, level.var_e628a8912ad74c62) < distance(obj2.curorigin, level.var_e628a8912ad74c62);
}

function run_player_interact_logic() {
  self notify("run_player_interact_logic");
  self endon("run_player_interact_logic");
  trigger = self.trigger;

  while(true) {
    trigger waittill("trigger", player);

    if(getdvarint(@ "hash_50de136606fc41da", 0) && isDefined(self.var_56bb845d40871824)) {
      var_618e461abd5994f4 = 0;

      foreach(team in self.var_56bb845d40871824) {
        if(team != player.team) {
          var_618e461abd5994f4 = 1;
        }
      }

      if(var_618e461abd5994f4 == 1) {
        player iprintlnbold(&"MP/BOMBSITE_IN_USE_CAPTURE_BOT");
      } else {
        onbeginuse(player);
      }

      continue;
    }

    onbeginuse(player);
  }
}

function function_8ab4263516ea015f(currentobjective, var_b2be2b0ad85ea48) {
  array = [];

  if(getDvar(@ "hash_ab8c774ce0027d59", "<dev string:x4d>") != "<dev string:x4d>") {
    forcedobjective = getDvar(@ "hash_ab8c774ce0027d59", "<dev string:x4d>");

    if(forcedobjective == "<dev string:x51>") {
      model = "<dev string:x5a>";
    }

    if(forcedobjective == "<dev string:x77>") {
      model = "<dev string:x83>";
    }

    if(forcedobjective == "<dev string:xaa>") {
      model = "<dev string:xb8>";
    }

    if(forcedobjective == "<dev string:xd2>") {
      model = "<dev string:xdb>";
    }

    foreach(struct in array_randomize(level.objectives)) {
      if(isDefined(struct.scriptable) && !is_equal(struct.scriptable.model, model)) {
        continue;
      }

      array[array.size] = struct;
    }

    return array;
  }

  foreach(struct in array_randomize(level.objectives)) {
    if(istrue(var_b2be2b0ad85ea48) && !function_af110ad9ae3128a1(struct)) {
      continue;
    }

    if(isDefined(currentobjective) && distance2d(currentobjective.curorigin, struct.curorigin) < 1000) {
      continue;
    }

    if(isDefined(currentobjective) && distance2d(currentobjective.curorigin, struct.curorigin) > 3500) {
      continue;
    }

    array[array.size] = struct;
  }

  return array;
}

function function_af110ad9ae3128a1(struct) {
  return is_equal(struct.trigger.script_label, "robj_start");
}

function function_2d1f2d138f937e6a(type, origin, size) {
  if(level.var_1831c32d8bdf53df > 0) {
    level.var_80bce1fe9a035033 function_6b6b6273f8180522("SecureZone_Mp", origin, size * 3);
    wait level.var_1831c32d8bdf53df / 2;
    level.var_80bce1fe9a035033 function_4584ad1c0e2c58ec(size * 2);
    wait level.var_1831c32d8bdf53df / 2;
    level.var_80bce1fe9a035033 function_4584ad1c0e2c58ec(size);
    return;
  }

  level.var_80bce1fe9a035033 function_6b6b6273f8180522("SecureZone_Mp", origin, size);
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
}

function onstartgametype() {
  level.usestartspawns = 1;
  setclientnamemode("auto_change");
  thread waittoprocess();
  setupobjectiveicons();
  initobjectives();
  initspawns();
  level thread function_52edd4d6e6b699f2();
  scripts\cp_mp\uav_tower::init();
  script_model_anims();
  thread function_74d188f8cd1044f8();
}

#using_animtree("script_model");

function script_model_anims() {
  level.scr_animtree["uav_tower"] = #animtree;
  level.scr_anim["uav_tower"]["use_uav_tower_enter"] = % jup_uav_tower_enter;
  level.scr_eventanim["uav_tower"]["use_uav_tower_enter"] = % "use_jup_uav_tower_enter";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_enter"] = "jup_uav_tower_enter";
  level.scr_anim["uav_tower"]["use_uav_tower_idle"] = % jup_uav_tower_idle;
  level.scr_eventanim["uav_tower"]["use_uav_tower_idle"] = % "use_jup_uav_tower_idle";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_idle"] = "jup_uav_tower_idle";
  level.scr_anim["uav_tower"]["use_uav_tower_exit"] = % jup_uav_tower_exit;
  level.scr_eventanim["uav_tower"]["use_uav_tower_exit"] = % "use_jup_uav_tower_exit";
  level.scr_viewmodelanim["uav_tower"]["use_uav_tower_exit"] = "jup_uav_tower_exit";
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_anim["player_rig"]["interact"] = % wm_eq_fusebox_plr;
  level.scr_eventanim["player_rig"]["interact"] = % "wm_eq_fusebox_plr";
  level.scr_anim["player_rig"]["interact_on"] = % wm_eq_fusebox_turn_on_plr;
  level.scr_eventanim["player_rig"]["interact_on"] = % "wm_eq_fusebox_turn_on_plr";
  level.scr_animtree["fusebox_prop"] = #animtree;
  level.scr_anim["fusebox_prop"]["interact"] = % wm_eq_fusebox_prop;
  level.scr_anim["fusebox_prop"]["interact_on"] = % wm_eq_fusebox_turn_on_prop;
}

function initobjectives() {
  triggers = getEntArray("robj_interactzone", "targetname");
  level.objectives = [];

  foreach(trigger in triggers) {
    bombzone = setupobjective(trigger);

    if(isDefined(bombzone)) {
      level.objectives[bombzone.objectivekey] = bombzone;
    }
  }

  updateobjectivelights("off");
  function_74d188f8cd1044f8();
}

function function_a9a2bef3ba198a85(scriptable) {
  scriptable setscriptablepartstate("dmz_uav_tower_laptop", "laptop_closed");
  scriptable setscriptablepartstate("dmz_uav_tower_antenna", "inactive");

  if(scriptable getscriptablehaspart("robj_screen_state")) {
    scriptable setscriptablepartstate("robj_screen_state", "off");
  }
}

function function_59e0c0a902e8778c(scriptable) {
  scriptable setscriptablepartstate("dmz_uav_tower_laptop", "laptop_opened");
  scriptable setscriptablepartstate("dmz_uav_tower_antenna", "active");
  scriptable setscriptablepartstate("dmz_uav_tower_antenna", "active");

  if(scriptable getscriptablehaspart("robj_screen_state")) {
    scriptable setscriptablepartstate("robj_screen_state", "on");
  }
}

function updateobjectivelights(state, script_noteworthy) {
  var_def296f20c665c2a = getentitylessscriptablearray("robj_light", "targetname");

  foreach(scriptable in var_def296f20c665c2a) {
    scriptable notify("update_objective_lights");

    if(isDefined(script_noteworthy) && !is_equal(scriptable.script_noteworthy, script_noteworthy)) {
      continue;
    }

    if(is_equal(state, "idle")) {
      scriptable thread function_33c8d0807c72cb68(state);
      continue;
    }

    scriptable setscriptablepartstate("chevron_0", state);
  }
}

function function_33c8d0807c72cb68(state) {
  scriptable = self;
  scriptable endon("update_objective_lights");

  while(true) {
    scriptable setscriptablepartstate("chevron_0", state);
    wait 0.5;
    scriptable setscriptablepartstate("chevron_0", "off");
    wait 0.5;
  }
}

function setupobjective(trigger, skipobjid, var_5ddbc1faed2c56e6) {
  if(isDefined(trigger.originalpos)) {
    trigger.origin = trigger.originalpos;
  } else {
    trigger.originalpos = trigger.origin;
  }

  visuals = getEntArray(trigger.target, "targetname");
  prefix = "secure_loc";
  objectivekey = getsubstr(trigger.script_noteworthy, prefix.size, trigger.script_noteworthy.size);

  if(isDefined(level.objectives) && isDefined(level.objectives[objectivekey])) {
    objectivekey += "_2";
  }

  bombzone = spawnStruct();
  bombzone.trigger = trigger;
  bombzone.objectivekey = objectivekey;
  bombzone.curorigin = bombzone.trigger.origin;
  bombzone.offset3d = (0, 0, 0);
  bombzone.trigger setuseprioritymax();
  bombzone.trigger setuseholdduration("duration_none");
  bombzone.triggertype = "use";
  bombzone scripts\mp\gameobjects::allowuse("none");
  bombzone scripts\mp\gameobjects::requestid(0, 0, undefined, 0);
  bombzone scripts\mp\gameobjects::setobjectivestatusicons("icon_waypoint_ot_a");
  bombzone scripts\mp\gameobjects::setownerteam("neutral");
  bombzone.claimteam = "none";
  bombzone.claimplayer = undefined;
  bombzone.lastclaimteam = "none";
  bombzone.lastclaimtime = 0;
  model = getEnt(bombzone.trigger.target, "targetname");
  trigger = getEnt(model.target, "targetname");
  bombzone.var_cea6fac6a8f24927 = getStruct(trigger.target, "targetname");
  scriptable_name = model function_bea6c5f32629f766();
  scriptable = spawnscriptable(scriptable_name, model.origin, model.angles);
  function_a9a2bef3ba198a85(scriptable);
  scriptable setscriptablepartstate("dmz_uav_tower", "unusable");
  model delete();
  bombzone.scriptable = scriptable;
  bombzone.noweapondropallowedtrigger = spawn("trigger_radius", bombzone.curorigin, 0, 140, 100);
  bombzone.audioent = spawn("script_origin", bombzone.scriptable function_c3393659916e4f86());

  if(scriptable_name == "mp_secure_electrical_panel_objective_01") {
    bombzone.trigger setHintString(&"JUP_MP/SECURE_USE");
  } else {
    bombzone.trigger setHintString(&"JUP_MP/SECURE_INTERACT");
  }

  return bombzone;
}

function function_bea6c5f32629f766() {
  switch (self.model) {
    case #"hash_7594c201ef96b3d7":
      return "mp_secure_indoor_objective_01";
    case #"hash_9bb12794207226a":
      return "mp_secure_electrical_panel_objective_01";
    case #"hash_826f132aead12d08":
      return "mp_secure_helicopter_objective_01";
    case #"hash_ee20fbc82e64328f":
      return "mp_secure_outdoor_objective_01";
    default:
      break;
  }
}

function getreservedobjid(objectivekey) {
  if(objectivekey == "_a") {
    reservedid = 0;
  } else if(objectivekey == "_b") {
    reservedid = 1;
  } else {
    reservedid = 2;
  }

  return reservedid;
}

function initspawns() {
  if(function_bff229a11ecd1e34()) {
    scripts\mp\spawnlogic::setactivespawnlogic(#"default");
  } else if(getdvarint(@ "t10", 0) > 0) {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Default");
  } else {
    scripts\mp\spawnlogic::setactivespawnlogic("Default", "Crit_Frontline");
  }

  level.spawnmins = (2.14748e+09, 2.14748e+09, 2.14748e+09);
  level.spawnmaxs = (-2147483647, -2147483647, -2147483647);
  scripts\mp\spawnlogic::addstartspawnpoints("mp_robj_spawn_allies_start");
  scripts\mp\spawnlogic::addstartspawnpoints("mp_robj_spawn_axis_start");
  scripts\mp\spawnlogic::addspawnpoints(game["attackers"], "mp_robj_spawn_allies_start");
  scripts\mp\spawnlogic::addspawnpoints(game["defenders"], "mp_robj_spawn_axis_start");
  attackers = scripts\mp\spawnlogic::getspawnpointarray("mp_robj_spawn_allies_start");
  defenders = scripts\mp\spawnlogic::getspawnpointarray("mp_robj_spawn_axis_start");
  scripts\mp\spawnlogic::registerspawnset("start_attackers", attackers);
  scripts\mp\spawnlogic::registerspawnset("start_defenders", defenders);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_robj_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_robj_spawn", 1);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_robj_spawn_secondary", 1, 1);
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_robj_spawn_secondary", 1, 1);

  if(!isDefined(level.spawnpoints) || istrue(level.adjustshipmentspawns)) {
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
    scripts\mp\spawnlogic::addspawnpoints("allies", "mp_tdm_spawn_secondary", 1, 1);
    scripts\mp\spawnlogic::addspawnpoints("axis", "mp_tdm_spawn_secondary", 1, 1);
    tdmspawns = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn");
    var_3d83bc62b320d11a = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_secondary");
    scripts\mp\spawnlogic::registerspawnset("normal", tdmspawns);
    scripts\mp\spawnlogic::registerspawnset("fallback", var_3d83bc62b320d11a);
  }

  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);

  if(istrue(level.adjustshipmentspawns)) {
    return;
  }

  foreach(zone in level.objectives) {
    zone.furthestspawndistsq = 0;
    zone.spawnpoints = [];
    zone.fallbackspawnpoints = [];
  }

  foreach(spawnpoint in level.spawnpoints) {
    isstartspawn = spawnpoint.classname == "mp_robj_spawn_allies_start" || spawnpoint.classname == "mp_robj_spawn_axis_start";
    var_ba992cb19cb03b0c = 0;
    var_e07d09f62cc34ac2 = spawnpoint.classname == "mp_robj_spawn";
    var_f87fc0e5455ed600 = spawnpoint.classname == "mp_robj_spawn_secondary";
    zoneindicies = [];
    var_7ba87fdf5e9815e0 = [];

    if(var_f87fc0e5455ed600 || var_e07d09f62cc34ac2) {
      if(isDefined(spawnpoint.script_noteworthy) && spawnpoint.script_noteworthy != "") {
        zoneindicies = strtok(spawnpoint.script_noteworthy, " ");

        foreach(zoneindex in zoneindicies) {
          zone = level.objectives["_" + zoneindex];

          if(isDefined(zone)) {
            var_7ba87fdf5e9815e0[var_7ba87fdf5e9815e0.size] = zone;
            var_ba992cb19cb03b0c = 1;

            if(var_f87fc0e5455ed600) {
              zone.fallbackspawnpoints[zone.fallbackspawnpoints.size] = spawnpoint;
              continue;
            }

            zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
          }
        }
      } else {
        var_7ba87fdf5e9815e0 = level.objectives;
      }
    }

    obj_zonecapture::function_492958e372181db0(spawnpoint, var_7ba87fdf5e9815e0);

    if(!var_ba992cb19cb03b0c) {
      foreach(zone in level.objectives) {
        if(var_e07d09f62cc34ac2 && function_8e6da67bd91a7b85(zone, spawnpoint)) {
          zone.spawnpoints[zone.spawnpoints.size] = spawnpoint;
          continue;
        }

        if(function_8e6da67bd91a7b85(zone, spawnpoint, 2500)) {
          zone.fallbackspawnpoints[zone.fallbackspawnpoints.size] = spawnpoint;
        }
      }
    }
  }

  foreach(objid, zone in level.objectives) {
    zone.spawnset = "robj" + objid;
    scripts\mp\spawnlogic::registerspawnset(zone.spawnset, zone.spawnpoints);
    zone.fallbackspawnset = "robj_fallback" + objid;
    scripts\mp\spawnlogic::registerspawnset(zone.fallbackspawnset, zone.fallbackspawnpoints);
  }
}

function function_8e6da67bd91a7b85(zone, spawnpoint, overridedistance) {
  distcheck = 2000;

  if(isDefined(overridedistance)) {
    distcheck = overridedistance;
  }

  if(distance(zone.curorigin, spawnpoint.origin) > distcheck) {
    return false;
  }

  mindist = [[level.getkothzonedeadzonedist]]();

  if(distance(zone.curorigin, spawnpoint.origin) < mindist) {
    return false;
  }

  return true;
}

function getspawnpoint() {
  spawnteam = self.pers["team"];
  zone = random(level.current_objectives);
  var_2fa17baefe0fa286 = scripts\mp\gametypes\koth::getkothzonedeadzonedist();
  var_ba0a9fd614a3f6ee = scripts\mp\spawnfactor::function_75c03ed937b75b22(zone.trigger getentitynumber(), zone.furthestspawndistsq, var_2fa17baefe0fa286 * var_2fa17baefe0fa286, 12250000);

  if(istrue(level.adjustshipmentspawns)) {
    spawnpoint = function_c7a7b61fcc8647dc(zone, var_ba0a9fd614a3f6ee, spawnteam);
  } else {
    spawnpoint = function_22cb880502395ae(zone, var_ba0a9fd614a3f6ee, spawnteam);
  }

  if(getdvarint(@ "hash_d4420d4cfbeab8b9", 0) == 1 && isDefined(level.current_objectives)) {
    foreach(objective in level.objectives) {
      line(spawnpoint.origin, objective.curorigin, (0, 1, 0), 1, 0, 200);
      print3d(spawnpoint.origin, int(distance(spawnpoint.origin, objective.curorigin)), (1, 0, 0), 1, 10, 200, 1);
    }
  }

  return spawnpoint;
}

function function_22cb880502395ae(zone, var_ba0a9fd614a3f6ee, spawnteam) {
  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers", undefined, var_ba0a9fd614a3f6ee);
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders", undefined, var_ba0a9fd614a3f6ee);
    }
  } else {
    if(!isDefined(level.switchedtohardpointspawnlogic)) {
      level.switchedtohardpointspawnlogic = 1;

      if(function_bff229a11ecd1e34()) {
        scripts\mp\spawnlogic::setactivespawnlogic(#"objective");
      } else {
        scripts\mp\spawnlogic::setactivespawnlogic("Secure", "Crit_Default");
      }
    }

    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, zone.spawnset, zone.fallbackspawnset, 2, var_ba0a9fd614a3f6ee);
  }

  return spawnpoint;
}

function function_c7a7b61fcc8647dc(zone, var_ba0a9fd614a3f6ee, spawnteam) {
  if(scripts\mp\spawnlogic::shoulduseteamstartspawn()) {
    if(spawnteam == game["attackers"]) {
      scripts\mp\spawnlogic::activatespawnset("start_attackers", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_attackers");
    } else {
      scripts\mp\spawnlogic::activatespawnset("start_defenders", 1);
      spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "start_defenders");
    }
  } else {
    scripts\mp\spawnlogic::activatespawnset("normal", 1);
    spawnpoint = scripts\mp\spawnlogic::getspawnpoint(self, spawnteam, undefined, "fallback");
  }

  return spawnpoint;
}

function waittoprocess() {
  level endon("game_end");

  for(;;) {
    if(level.ingraceperiod == 0) {
      break;
    }

    waitframe();
  }

  level.usestartspawns = 0;
}

function updategametypedvars() {
  updatecommongametypedvars();
  level.planttime = dvarfloatvalue("planttime", 3, 0, 20);
  level.defusetime = dvarfloatvalue("defusetime", 3, 0, 20);
  level.bombtimer = dvarintvalue("bombtimer", 10, 1, 300);
  level.ddtimetoadd = dvarfloatvalue("extraTime", 120, 0, 500);
  level.overtime = dvarfloatvalue("overtimeLimit", 1, 0, 180);
  level.resetprogress = dvarintvalue("resetProgress", 1, 0, 1);
  level.var_1831c32d8bdf53df = dvarintvalue("obscureTime", 0, 0, 10);
  level.bombtimermin = dvarintvalue("bombtimermin", 10, 0, 10);
  level.var_db19c0508f775166 = dvarintvalue("bombintermission", 8, 0, 10);
  level.var_b88463627a96b8b0 = dvarintvalue("bomblocktime", 15, 0, 15);
  setovertimelimitdvar(level.overtime);
  level.silentplant = dvarintvalue("silentPlant", 0, 0, 1);
}

function nextobjective() {
  level scripts\mp\gamelogic::resumetimer();
  level.var_80bce1fe9a035033 function_af5604ce591768e1();
  function_52edd4d6e6b699f2();
}

function debugloc() {
  while(true) {
    if(isDefined(self.curorigin)) {
      box(self.curorigin, 0, (1, 1, 1), 0, 1);
    }

    waitframe();
  }
}

function onbeginuse(player) {
  self notify("successful_use_occurred");
  function_9897b5b4ecf74ef3("interaction", player.pers["team"]);

  if(isDefined(self.var_21aaad3fb9690b37) && self.var_21aaad3fb9690b37) {
    self notify("captureBot_hackCanceled_playerHack");
  }

  updateobjectivelights(player.pers["team"], self.trigger.script_noteworthy);

  if(isDefined(self.var_cea6fac6a8f24927)) {
    player thread function_3dd5a18eafa343cc(self);
  }

  if(function_ec2935d47ad1f5ce()) {
    self.var_ec7886a87e5a6866 = 1;
    namespace_cb9ef225b7a59984::function_f83e9201f5f2aa6a();
  }

  if(!is_equal(self.ownerteam, "neutral") && !is_equal(player.pers["team"], self.ownerteam)) {
    self.var_ec7886a87e5a6866 = 1;
    namespace_cb9ef225b7a59984::function_f83e9201f5f2aa6a();
  }
}

function function_283fdcc6a567a598(player, struct, var_a051ed1b3dc4708c) {
  level endon("game_ended");
  fusebox = self;
  self.scenenode = struct spawn_script_origin();
  self.scenenode.angles += (0, -90, 0);
  actorplayer = anim_scene_create_actor(player, "player_rig", 1);
  blendintime = 0.8;

  if(!ent_flag("switch_on")) {
    if(!istrue(var_a051ed1b3dc4708c)) {
      fusebox thread function_22b3d802b1a8bec5(blendintime, "lever", "flip_switch_up");
    }

    result = self.scenenode anim_scene([actorplayer], "interact_on");

    if(result) {
      ent_flag_set("switch_on");
    }

    return;
  }

  if(!istrue(var_a051ed1b3dc4708c)) {
    fusebox thread function_22b3d802b1a8bec5(blendintime, "lever", "flip_switch_down");
  }

  result = self.scenenode anim_scene([actorplayer], "interact");

  if(result) {
    ent_flag_clear("switch_on");
  }
}

function function_22b3d802b1a8bec5(time, part, state) {
  wait time;
  self setscriptablepartstate(part, state);
}

function onenduse(team, player, result, forcecall, var_930163bad6941f10) {
  if(isDefined(var_930163bad6941f10)) {
    var_8a11b26acefd3594 = var_930163bad6941f10;
  } else {
    var_8a11b26acefd3594 = 0;
  }

  bombzone = self;

  if(function_a04947052b0aba76(bombzone) && !istrue(forcecall)) {
    return;
  }

  if(!var_8a11b26acefd3594) {
    player function_ed5fa482a1aa09c8();
  }

  if(result) {
    bombzone.ownerteam = team;
    bombzone.trigger setteamfortrigger(team);
    bombzone scripts\mp\gameobjects::updatetrigger();
    bombzone scripts\mp\gameobjects::allowuse("enemy");
    level.bombtimer -= 5;

    if(level.bombtimer < level.bombtimermin) {
      level.bombtimer = level.bombtimermin;
    }

    if(function_ec2935d47ad1f5ce()) {
      bombzone scripts\mp\gameobjects::allowuse("<dev string:x103>");
    }

    var_acff3f3a57ba37b7 = int(level.bombtimer * 1000 + gettime() - 1000);
    namespace_cb9ef225b7a59984::startcapture(team, var_acff3f3a57ba37b7, self.var_ec7886a87e5a6866);
    bombzone function_9897b5b4ecf74ef3("timer", team);
    bombzone thread run_progress_event(team);
  } else {
    updateobjectivelights("idle", bombzone.trigger.script_noteworthy);
    bombzone function_9897b5b4ecf74ef3("neutral_tick");
    namespace_cb9ef225b7a59984::function_e92d8183093a8f29();
  }

  if(var_8a11b26acefd3594) {
    self.hackingbot = undefined;
    self.var_21aaad3fb9690b37 = 0;
  }
}

function function_ec2935d47ad1f5ce() {
  return getdvarint(@ "hash_948c1d810a649388", 0);
}

function run_progress_event(team) {
  self notify("run_progress_event");
  self endon("run_progress_event");
  scripts\mp\gameobjects::setusetime(level.defusetime);

  if(function_ec2935d47ad1f5ce()) {
    self.var_6f3bb383be5956a9 = 1;
  }

  level scripts\mp\gamelogic::pausetimer();

  for(i = 0; i < level.bombtimer; i++) {
    if(istrue(self.var_ec7886a87e5a6866)) {
      function_820ffa8e77528791(team);
      continue;
    }

    updateobjectivelights("off", self.trigger.script_noteworthy);
    wait 0.5;

    if(istrue(self.var_ec7886a87e5a6866)) {
      continue;
    }

    updateobjectivelights(team, self.trigger.script_noteworthy);
    wait 0.5;

    if(istrue(self.var_ec7886a87e5a6866)) {}
  }

  if(istrue(self.var_ec7886a87e5a6866)) {
    function_820ffa8e77528791(team);
  }

  foreach(player in level.players) {
    player notify("interact_cancelled");
  }

  self notify("hack_progress_complete");
  touchlist = [];
  credit_player = undefined;

  foreach(player in level.teamdata[team]["players"]) {
    if(player isonobjective()) {
      touchlist[touchlist.size] = player;
    }

    if(istrue(player.initiatedhack)) {
      credit_player = player;
    }
  }

  level thread give_capture_credit(touchlist, level.bombtimer, team, level.lastcaptureteam, credit_player, level.current_objectives[0]);
  scripts\mp\gameobjects::allowuse("none");
  scripts\mp\gameobjects::setusetime(level.planttime);
  self.ownerteam = "neutral";
  updateobjectivelights("off", self.trigger.script_noteworthy);
  namespace_cb9ef225b7a59984::function_e92d8183093a8f29();
  namespace_cb9ef225b7a59984::function_7aa88aa68f7d7b1a();

  foreach(entry in level.teamnamelist) {
    if(is_equal(entry, team)) {
      dialogline = function_1faae1bb72f526fb(self.scriptable, "taken");
      scripts\mp\utility\dialog::leaderdialog(dialogline, entry);
      continue;
    }

    dialogline = function_1faae1bb72f526fb(self.scriptable, "lost");
    scripts\mp\utility\dialog::leaderdialog(dialogline, entry);
  }

  level thread scripts\mp\hud_message::notifyteam("jup_robj_secured", "jup_robj_secured_enemy", team);
  function_9897b5b4ecf74ef3("timer_complete", team);
  scripts\mp\gamescore::giveteamscoreforobjective(team, 10, 1, undefined, 1);
  scripts\mp\gametypes\robj::function_a04638eb5da83e60();

  foreach(player in level.players) {
    player.initiatedhack = undefined;
  }

  level.lastcaptureteam = team;
  nextobjective();
}

function give_capture_credit(touchlist, capturetime, capture_team, lastcaptureteam, credit_player, gameobject) {
  level endon("game_ended");

  foreach(player in touchlist) {
    player thread scripts\mp\rank::scoreeventpopup(#"capture");
    player thread scripts\mp\utility\points::doscoreevent(#"hash_194ad9a7fdb13341");
    player incpersstat("captures", 1);
    player scripts\mp\persistence::statsetchild("round", "captures", player.pers["captures"]);
    player setextrascore0(player.pers["captures"]);
  }
}

function function_820ffa8e77528791(team) {
  updateobjectivelights(getotherteam(team)[0], self.trigger.script_noteworthy);

  while(istrue(self.var_ec7886a87e5a6866)) {
    waitframe();
  }
}

function function_3dd5a18eafa343cc(bombzone) {
  movetime = 1;
  player = self;
  bombzone.scriptable.successfuluse = undefined;
  bombzone scripts\mp\gameobjects::allowuse("none");

  if(bombzone.scriptable.model == "uk_electrical_box_medium_01_animated") {
    bombzone.scriptable function_283fdcc6a567a598(player, bombzone.var_cea6fac6a8f24927);
    bombzone.scriptable.successfuluse = 1;
  } else if(bombzone.scriptable.model == "ammo_box_plastic_lg_01") {
    player.var_8e61d4338428b3bd = 1;
    player giveandfireoffhand("flare_mp");
    player function_935068d9c3667c49();
    scriptable = spawn("script_model", bombzone.var_cea6fac6a8f24927.origin + (0, 0, 1));
    scriptable.angles = (-90, 0, 90);
    scriptable setModel("dz_flare_scriptable_secure");
    scriptable setscriptablepartstate("smoke", "idle", 0);
    level thread robj_do_helicopter_sequence(bombzone, scriptable);
    bombzone.scriptable.successfuluse = 1;
  } else {
    bombzone.scriptable function_bd8563c34b78c85b(player);
  }

  claimteam = player.pers["team"];

  if(getdvarint(@ "hash_7279b9c2bb5f6487", 0)) {
    claimteam = getotherteam(claimteam)[0];
  }

  bombzone endon("hack_progress_complete");
  updateobjectivelights(claimteam, bombzone.trigger.script_noteworthy);
  var_bbe52ce53740d5bd = function_750464d23674c53c();

  if(var_bbe52ce53740d5bd) {
    player.initiatedhack = 1;
    bombzone onenduse(claimteam, player, 1, 1);
  } else if(isDefined(bombzone.ownerteam)) {
    bombzone scripts\mp\gameobjects::allowuse("enemy");

    if(function_ec2935d47ad1f5ce()) {
      bombzone scripts\mp\gameobjects::allowuse("<dev string:x103>");
    }
  } else {
    bombzone scripts\mp\gameobjects::allowuse("any");
  }

  if(istrue(bombzone.var_ec7886a87e5a6866)) {
    namespace_cb9ef225b7a59984::function_4477eaad8e734453();
    bombzone.var_ec7886a87e5a6866 = undefined;
  }

  if(!isDefined(bombzone.ownerteam) || bombzone.ownerteam == "neutral") {
    updateobjectivelights("idle", bombzone.trigger.script_noteworthy);

    if(!getobjectivestatus(bombzone)) {
      bombzone function_9897b5b4ecf74ef3("neutral_tick");
    }
  }
}

function function_935068d9c3667c49() {
  player = self;
  player endon("death_or_disconnect");

  while(istrue(player.var_8e61d4338428b3bd)) {
    waitframe();
  }
}

function getobjectivestatus(objective) {
  return istrue(objective.scriptable.successfuluse);
}

function function_750464d23674c53c() {
  foreach(objective in level.current_objectives) {
    if(!getobjectivestatus(objective)) {
      return false;
    }
  }

  return true;
}

function function_bd8563c34b78c85b(player) {
  player endon("death_or_disconnect");
  player endon("interact_interrupt");
  thread scripts\cp_mp\uav_tower::watchplayerdeathordisconnect(player);

  if(!isDefined(level.var_e3ddcc4b9b3d02d6)) {
    level.var_e3ddcc4b9b3d02d6 = level.towerusetime - getanimlength(%jup_uav_tower_enter);
  }

  typinganimstart(player);
  namespace_cb9ef225b7a59984::starthacking(player);
  player thread function_b66f9aef33ae7f2d(level.var_e3ddcc4b9b3d02d6);
  thread function_667fd79f2b5d6436(player);
  player setclientomnvar("ui_dmz_uav_tower_screen", 1);
  scripts\cp_mp\uav_tower::function_e71d6089ebd93181(player);
  namespace_cb9ef225b7a59984::stophacking(player);

  if(getdvarint(@ "hash_4a05c776b04c1c9b", 1)) {
    scripts\cp_mp\uav_tower::function_b61464b3867d7ba3(player);
  } else {
    player stopviewmodelanim();
    player val::set("typing", "allow_movement", 0);
  }

  player notify("interact_finished");
  waitframe();
  player scripts\cp_mp\uav_tower::function_3c288bbdd4016fd4(1);

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(player)) {
    player notify("remove_rig");
  }
}

function function_b66f9aef33ae7f2d(durationseconds) {
  player = self;
  player endon("death_or_disconnect");
  player endon("interact_interrupt");
  player endon("interact_finished");
  durationprogress = 0;

  while(durationprogress < durationseconds) {
    durationprogress += level.framedurationseconds;
    namespace_cb9ef225b7a59984::function_efd118cc84912439(player, clamp(durationprogress / durationseconds, 0.01, 1));
    waitframe();
  }
}

function function_667fd79f2b5d6436(player, capturetime) {
  player endon("interact_interrupt");
  waitframe();

  if(!isbot(player)) {
    player notifyonplayercommand("interact_cancelled", "+weapnext");
  }

  self.cancel = 0;
  msg = player waittill_any_timeout_1(level.var_e3ddcc4b9b3d02d6, "interact_cancelled");
  self.cancel = 1;

  if(!isbot(player)) {
    player notifyonplayercommandremove("interact_cancelled", "+weapnext");
  }

  if(msg == "interact_cancelled") {
    wait 0.25;
    player setclientomnvar("ui_dmz_uav_tower_screen", 0);
    return;
  }

  self.successfuluse = 1;
  level thread scripts\mp\hud_message::notifyteam("jup_robj_securing", "jup_robj_securing_enemy", player.pers["team"], [player]);
  player thread scripts\mp\hud_message::showsplash("jup_robj_securing", scripts\mp\rank::getscoreinfovalue(#"plant"));
  player notify("interact_begin_exit");
}

function typinganimstart(player) {
  player endon("death_or_disconnect");
  player notify("typingAnimStart");
  player endon("typingAnimStart");

  if(isDefined(player.linktoent)) {
    player.linktoent delete();
  }

  player scripts\cp_mp\uav_tower::function_3c288bbdd4016fd4(0);
  player.linktoent = player spawn_tag_origin(player.origin, player getplayerangles(0));
  player playerlinktodelta(player.linktoent, "tag_origin", 1, 0, 0, 30, 30, 1, 1);

  if(self.model == "jup_military_secure_mode_station_01") {
    anglesrotated = self.angles;
  } else {
    anglesrotated = self.angles + (0, -90, 0);
  }

  goalpos = self.origin + rotatevector((55.632, -1.279, 0), anglesrotated);
  forward = (0, 0, 0) - anglesToForward(anglesrotated);
  up = (0, 0, 1);
  right = vectorcross(forward, up);
  goalangles = axistoangles(forward, right, up);
  movetotime = 0.5;
  player.linktoent moveTo(goalpos, movetotime, 0.1, 0.1);
  player.linktoent rotateTo(goalangles, movetotime, 0.1, 0.1);
  player setstance("crouch");
  var_cd9982adb17761a8 = gettime();
  player scripts\cp_mp\utility\inventory_utility::givegunlessweapon();
  var_698cc218e4ade75f = gettime();
  var_218f64cb035d54be = max(0, movetotime - (var_698cc218e4ade75f - var_cd9982adb17761a8) / 1000);
  wait var_218f64cb035d54be;
  player unlink();
  player.linktoent delete();
  player.linktoent = undefined;
  player setOrigin(goalpos);
  player setplayerangles(goalangles);
  animname = "use_uav_tower_enter";
  player thread scripts\cp_mp\uav_tower::create_player_rig("uav_tower", player.origin, player.angles);
  player.player_rig showonlytoplayer(player);

  if(!isDefined(self.animstruct)) {
    animstruct = spawnStruct();
    animstruct.origin = self.origin;
    animstruct.angles = anglesrotated;
    self.animstruct = animstruct;
  }

  self.animstruct scripts\mp\anim::anim_player_solo(player, player.player_rig, animname);
}

function function_a04947052b0aba76(bombzone) {
  return isDefined(bombzone.scriptable);
}

function function_75043e7e3c552318() {
  return 2000;
}

function function_72c78e10b4cdbdae() {
  return 2500;
}

function function_ed5fa482a1aa09c8() {
  player = self;
  player notify("stopThirdPersonAnim");
  player stopanimscriptsceneevent();

  if(isDefined(player.var_565acfa83925639f)) {
    player.var_565acfa83925639f delete();
  }
}

function onuseplantobject(player) {}

function oncantuse(player) {
  player iprintlnbold(&"MP/BOMBSITE_IN_USE");
}

function onreset() {}

function setupobjectiveicons() {
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_target_neutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::setwaypointiconinfo("waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0);
}

function setupnewcapturebot(capturebot) {
  if(!isDefined(self.var_90e6c2c6f0b8bca9)) {
    self.var_90e6c2c6f0b8bca9 = [];
    self.var_3d9bcb6fd43a0b71 = 1;
    self.var_90e6c2c6f0b8bca9[self.var_90e6c2c6f0b8bca9.size] = capturebot;
    thread scripts\mp\gametypes\robj::function_e6fb1b719f5866f4();
    return;
  }

  self.var_90e6c2c6f0b8bca9[self.var_90e6c2c6f0b8bca9.size] = capturebot;
}

function function_e6fb1b719f5866f4() {
  level endon("game_end");
  level endon("new_robj_location");
  self.var_21aaad3fb9690b37 = 0;
  self.var_56bb845d40871824 = [];

  while(isDefined(self.var_90e6c2c6f0b8bca9) && self.var_90e6c2c6f0b8bca9.size >= 1) {
    foreach(bot in self.var_90e6c2c6f0b8bca9) {
      if(self.var_56bb845d40871824.size == 0) {
        self.var_56bb845d40871824[self.var_56bb845d40871824.size] = bot.owner.team;
        continue;
      }

      foreach(team in self.var_56bb845d40871824) {
        if(bot.owner.team != team) {
          self.var_56bb845d40871824[self.var_56bb845d40871824.size] = bot.owner.team;
        }
      }
    }

    if(self.var_56bb845d40871824.size == 1) {
      if(!self.var_21aaad3fb9690b37) {
        if(self.interactteam == "any" || self.interactteam == "enemy" && self.ownerteam != self.var_90e6c2c6f0b8bca9[0].owner.team) {
          thread function_5b561a0406f5e84d(self.var_90e6c2c6f0b8bca9[0]);
        }
      }
    }

    waitframe();
  }
}

function function_5b561a0406f5e84d(capturebot) {
  self notify("successful_use_occurred");
  self.hackingbot = capturebot;
  self.var_21aaad3fb9690b37 = 1;
  updateobjectivelights(capturebot.owner.team, self.trigger.script_noteworthy);
  function_9897b5b4ecf74ef3("interaction", capturebot.owner.team);

  if(!is_equal(self.ownerteam, "neutral") && !is_equal(capturebot.owner.team, self.ownerteam)) {
    self.var_ec7886a87e5a6866 = 1;
    namespace_cb9ef225b7a59984::function_f83e9201f5f2aa6a();
  }

  capturebot.owner setclientomnvar("ui_dmz_uav_tower_screen", 1);
  self.cancel = 0;
  msg = waittill_any_timeout_2(level.var_2550904ae7eb2a1c * level.towerusetime, "captureBot_hackCanceled", "captureBot_hackCanceled_playerHack");
  self.cancel = 1;

  if(msg == "captureBot_hackCanceled" || msg == "captureBot_hackCanceled_playerHack") {
    self.hackingbot = undefined;
    self.var_21aaad3fb9690b37 = 0;
  } else {
    level thread scripts\mp\hud_message::notifyteam("jup_robj_securing", "jup_robj_securing_enemy", capturebot.owner.pers["team"], [capturebot.owner]);
    capturebot.owner thread scripts\mp\hud_message::showsplash("jup_robj_securing", scripts\mp\rank::getscoreinfovalue(#"plant"));

    if(isDefined(self.var_21aaad3fb9690b37) && self.var_21aaad3fb9690b37) {
      onenduse(capturebot.owner.team, capturebot.owner, 1, 1, 1);
    }
  }

  if(istrue(self.var_ec7886a87e5a6866) && msg != "captureBot_hackCanceled_playerHack") {
    namespace_cb9ef225b7a59984::function_4477eaad8e734453();
    self.var_ec7886a87e5a6866 = undefined;
  }

  if(!isDefined(self.ownerteam) || self.ownerteam == "neutral") {
    if(msg != "captureBot_hackCanceled_playerHack") {
      updateobjectivelights("idle", self.trigger.script_noteworthy);
      function_9897b5b4ecf74ef3("neutral_tick");
    }
  }
}

function removeexistingcapturebot(capturebot) {
  if(isDefined(self.var_90e6c2c6f0b8bca9) && self.var_90e6c2c6f0b8bca9.size > 0) {
    if(self.var_90e6c2c6f0b8bca9.size == 1) {
      if(isDefined(self.var_3d9bcb6fd43a0b71)) {
        self.var_3d9bcb6fd43a0b71 = undefined;
      }

      self.var_90e6c2c6f0b8bca9 = undefined;
      self.var_56bb845d40871824 = undefined;
    } else {
      self.var_90e6c2c6f0b8bca9 = array_remove(self.var_90e6c2c6f0b8bca9, capturebot);
    }
  }

  if(isDefined(self.hackingbot) && self.hackingbot == capturebot) {
    self notify("captureBot_hackCanceled");
  }
}

function function_a04638eb5da83e60() {
  if(isDefined(self.var_90e6c2c6f0b8bca9) && self.var_90e6c2c6f0b8bca9.size > 0) {
    if(isDefined(self.var_3d9bcb6fd43a0b71)) {
      self.var_3d9bcb6fd43a0b71 = undefined;
    }

    self.var_90e6c2c6f0b8bca9 = undefined;
    self.var_56bb845d40871824 = undefined;
  }

  if(isDefined(self.hackingbot)) {
    self notify("captureBot_hackCanceled");
  }
}

function identifyobjtypforcapturebot(objective) {
  switch (objective.scriptable.model) {
    case #"hash_2829cec0816430af":
      return "tower";
    case #"hash_7594c201ef96b3d7":
      return "computer";
    case #"hash_9bb12794207226a":
      return "panel";
    case #"hash_826f132aead12d08":
      return "helicopter";
    default:
      return "no_obj";
  }
}

function function_3bfb09893720ad8b(team) {
  return ter_op(team == "allies", "axis", "allies");
}

function function_c3393659916e4f86() {
  return self.origin + rotatevector((0, 0, 80), self.angles);
}

function function_303cdf76d8d58324() {
  return self.origin + rotatevector((0, 0, 250), self.angles);
}

function function_ef6d70570f9a1124() {
  thread function_a7bc23440006ca37();

  while(self.var_c935cafaec1457bb) {
    playsoundatpos(self.scriptable function_303cdf76d8d58324(), "mp_jup_secure_tower_active_spin");
    waittill_any_timeout_1(1, "hack_progress_complete");
    waitframe();
  }
}

function function_9897b5b4ecf74ef3(type, team) {
  switch (self.scriptable.type) {
    case #"hash_a75e34b940af0387":
      thread function_6bc9adca4cc3c138(type, team);
      break;
    case #"hash_23316c7b6e9eee0a":
      thread function_4353012f233eec7c(type, team);
      break;
    case #"hash_7461b582f15d5954":
      thread function_235af39abd42037d(type, team);
      break;
    case #"hash_7942b6b104bfd8d4":
      thread function_bc5112a335cb0a76(type, team);
      break;
    default:

      break;
  }
}

function function_6bc9adca4cc3c138(type, team) {
  switch (type) {
    case #"hash_4c03b3adf599e4e0":
      soundorigin = self.scriptable function_c3393659916e4f86();
      playsoundatpos(soundorigin, "mp_jup_secure_laptop_new_location_opened");
      playsoundatpos(soundorigin, "mp_jup_secure_tower_opened");
      function_ef6d70570f9a1124();
      break;
    case #"hash_7b8cca9508ef3b84":
      function_94f9e76230eb3b4d();
      break;
    case #"hash_d9876aa54e2a4d2b":
      function_fb13c62b0312196a(team);
      break;
    case #"hash_7d97db7c4e68ac02":
      function_a28df8967ffc5d66(team);
      break;
    case #"hash_e57a60f1b31b1064":
      function_69128861a4095049(team);
      break;
    case #"hash_16e74e07094501b9":
      soundorigin = self.scriptable function_c3393659916e4f86();
      playsoundatpos(soundorigin, "mp_jup_secure_laptop_new_location_set");
      break;
  }
}

function function_235af39abd42037d(type, team) {
  switch (type) {
    case #"hash_4c03b3adf599e4e0":
      soundorigin = self.scriptable function_c3393659916e4f86();
      playsoundatpos(soundorigin, "mp_jup_secure_laptop_new_location_opened");
      playsoundatpos(soundorigin, "mp_jup_secure_terminal_opened");
      break;
    case #"hash_7b8cca9508ef3b84":
      function_94f9e76230eb3b4d();
      break;
    case #"hash_d9876aa54e2a4d2b":
      function_fb13c62b0312196a(team);
      break;
    case #"hash_7d97db7c4e68ac02":
      function_a28df8967ffc5d66(team);
      break;
    case #"hash_e57a60f1b31b1064":
      function_69128861a4095049(team);
      break;
    case #"hash_16e74e07094501b9":
      soundorigin = self.scriptable function_c3393659916e4f86();
      playsoundatpos(soundorigin, "mp_jup_secure_laptop_new_location_set");
      break;
  }
}

function function_4353012f233eec7c(type, team) {
  switch (type) {
    case #"hash_4c03b3adf599e4e0":
      soundorigin = self.scriptable function_c3393659916e4f86();
      playsoundatpos(soundorigin, "mp_jup_secure_laptop_new_location_opened");
      break;
    case #"hash_7b8cca9508ef3b84":
      break;
    case #"hash_d9876aa54e2a4d2b":
      function_fb13c62b0312196a(team);
      break;
    case #"hash_7d97db7c4e68ac02":
      break;
    case #"hash_e57a60f1b31b1064":
      function_69128861a4095049(team);
      break;
    case #"hash_16e74e07094501b9":
      soundorigin = self.scriptable function_c3393659916e4f86();
      playsoundatpos(soundorigin, "mp_jup_secure_laptop_new_location_set");
      break;
  }
}

function function_bc5112a335cb0a76(type, team) {
  switch (type) {
    case #"hash_4c03b3adf599e4e0":
      soundorigin = self.scriptable function_c3393659916e4f86();
      playsoundatpos(soundorigin, "mp_jup_secure_laptop_new_location_opened");
      break;
    case #"hash_7b8cca9508ef3b84":
      function_94f9e76230eb3b4d();
      break;
    case #"hash_d9876aa54e2a4d2b":
      function_fb13c62b0312196a(team);
      break;
    case #"hash_7d97db7c4e68ac02":
      function_a28df8967ffc5d66(team);
      break;
    case #"hash_e57a60f1b31b1064":
      function_69128861a4095049(team);
      break;
    case #"hash_16e74e07094501b9":
      soundorigin = self.scriptable function_c3393659916e4f86();
      playsoundatpos(soundorigin, "mp_jup_secure_laptop_new_location_set");
      break;
  }
}

function function_a7bc23440006ca37() {
  self.var_c935cafaec1457bb = 1;
  self waittill("hack_progress_complete");
  self.var_c935cafaec1457bb = 0;
}

function function_94f9e76230eb3b4d() {
  self notify("start_neutral_tick");
  self endon("start_neutral_tick");
  self endon("successful_use_occurred");

  while(true) {
    playsoundatpos(self.scriptable function_c3393659916e4f86(), "mp_jup_secure_neutral_ping");
    wait 1;
  }
}

function function_fb13c62b0312196a(team) {
  scripts\mp\utility\sound::playsoundonplayers("mp_jup_secure_ally_hack_screen", team);
  scripts\mp\utility\sound::playsoundonplayers("mp_jup_secure_enemy_hack_screen", function_3bfb09893720ad8b(team));
}

function function_a28df8967ffc5d66(team) {
  thread function_552d1571bb578587(team);
  scripts\mp\utility\sound::playsoundonplayers("mp_jup_secure_ally_hack_timer_start", team);
  scripts\mp\utility\sound::playsoundonplayers("mp_jup_secure_enemy_hack_timer_start", function_3bfb09893720ad8b(team));
}

function function_552d1571bb578587(team) {
  self endon("hack_progress_complete");
  self endon("successful_use_occurred");

  while(true) {
    wait 1;
    self.audioent playsoundtoteam("mp_jup_secure_ally_hack_timer_beep", team, undefined, self.audioent);
    self.audioent playsoundtoteam("mp_jup_secure_enemy_hack_timer_beep", function_3bfb09893720ad8b(team), undefined, self.audioent);
  }
}

function function_69128861a4095049(team) {
  scripts\mp\utility\sound::playsoundonplayers("mp_jup_secure_ally_hack_timer_complete", team);
  scripts\mp\utility\sound::playsoundonplayers("mp_jup_secure_enemy_hack_timer_complete", function_3bfb09893720ad8b(team));
}