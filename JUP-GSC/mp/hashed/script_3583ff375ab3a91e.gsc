/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3583ff375ab3a91e.gsc
*************************************************/

#using script_5bab271917698dc4;
#using script_5bc60484d17fa95c;
#using scripts\common\utility;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_twotwo_gulag;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\points;
#using scripts\mp\utility\script;
#namespace namespace_de6eb888abbe38e1;

function function_61b256ed26c0a7f7() {
  function_1e276f71cdb48adf();
}

function function_1e276f71cdb48adf() {
  game["dialog"]["gulag_jailer_intro"] = "ruls_jalr_guin";
}

function function_da46de174875958a(var_1c32cf705599120d, outlinecolor, var_3877fe450cf4fd9, var_65f75e5efd53fa1e) {
  player = self;

  if(!isDefined(player) || !isDefined(var_1c32cf705599120d)) {
    return;
  }

  if(isPlayer(var_1c32cf705599120d) && !istrue(var_1c32cf705599120d.gulag)) {
    return;
  }

  if(isPlayer(player) && !player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    return;
  }

  if(!isDefined(outlinecolor)) {
    outlinecolor = "outline_nodepth_orange";
  }

  var_1c32cf705599120d hudoutlineenableforclient(player, outlinecolor);
  player thread function_a2b7005fa6c293b5(var_1c32cf705599120d, var_3877fe450cf4fd9, var_65f75e5efd53fa1e);
}

function function_a2b7005fa6c293b5(var_ed3544a0afde8995, var_3877fe450cf4fd9, var_65f75e5efd53fa1e) {
  if(!isDefined(var_ed3544a0afde8995)) {
    return;
  }

  player = self;
  player endon("disconnect");
  level endon("game_ended");

  if(isDefined(var_3877fe450cf4fd9) && var_3877fe450cf4fd9 > 0) {
    var_ed3544a0afde8995 waittill_any_timeout_4(var_3877fe450cf4fd9, "disconnect", "gulag_end", "gulagLost", "hidePlayerOutlineToPlayer");
  } else {
    var_ed3544a0afde8995 waittill_any_4("disconnect", "gulag_end", "gulagLost", "hidePlayerOutlineToPlayer");
  }

  if(isDefined(var_ed3544a0afde8995)) {
    var_ed3544a0afde8995 hudoutlinedisableforclient(player);
  }

  wait 0.5;

  if(istrue(var_65f75e5efd53fa1e)) {
    player thread function_da46de174875958a(var_ed3544a0afde8995, "outline_nodepth_green");
  }
}

function function_80f9e9903919d770(var_3877fe450cf4fd9) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player endon("gulag_end");
  player endon("gulagLost");
  wait var_3877fe450cf4fd9;
  player notify("hidePlayerOutlineToPlayer");
}

function function_36c9dc5a1d1bb023(arena) {
  if(isDefined(arena.var_801cdcfadc4d465c)) {
    foreach(p in arena.var_801cdcfadc4d465c) {
      if(!isDefined(p)) {
        continue;
      }

      foreach(teammate in arena.var_801cdcfadc4d465c) {
        if(!isDefined(teammate)) {
          continue;
        }

        if(teammate == p) {
          continue;
        }

        if(istrue(level.var_43307855f189eb31.var_2928dfb3a48d00b3)) {
          p thread function_da46de174875958a(teammate, "outline_nodepth_green", undefined, 0);
        }

        entnum = teammate getentitynumber();
        var_5984a7ce217a3e1d = function_17f3636354648f38(entnum);
        p setclientomnvar("ui_br_twotwo_gulag_player_state", var_5984a7ce217a3e1d);
      }

      if(isDefined(arena.var_af5243fbba0720c2)) {
        foreach(enemyp in arena.var_af5243fbba0720c2) {
          p thread function_da46de174875958a(enemyp, "outline_nodepth_red", 10);
        }
      }
    }
  }

  if(isDefined(arena.var_af5243fbba0720c2)) {
    foreach(p in arena.var_af5243fbba0720c2) {
      if(!isDefined(p)) {
        continue;
      }

      foreach(teammate in arena.var_af5243fbba0720c2) {
        if(!isDefined(p)) {
          continue;
        }

        if(!isDefined(teammate)) {
          continue;
        }

        if(teammate == p) {
          continue;
        }

        if(istrue(level.var_43307855f189eb31.var_2928dfb3a48d00b3)) {
          p thread function_da46de174875958a(teammate, "outline_nodepth_green", undefined, 0);
        }

        entnum = teammate getentitynumber();
        var_5984a7ce217a3e1d = function_17f3636354648f38(entnum);
        p setclientomnvar("ui_br_twotwo_gulag_player_state", var_5984a7ce217a3e1d);
      }

      foreach(enemyp in arena.var_801cdcfadc4d465c) {
        p thread function_da46de174875958a(enemyp, "outline_nodepth_red", 10);
      }
    }
  }
}

function function_80658d002f64199(var_c772f50c7278f2d3) {
  var_3e309c0b51a20219 = self;

  if(level.var_43307855f189eb31.var_c497886247559b89) {
    var_3e309c0b51a20219 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_up", 0);
    var_c772f50c7278f2d3 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_up", 0);
    return;
  }

  var_3e309c0b51a20219 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_up_slowly", 0);
  var_c772f50c7278f2d3 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_up_slowly", 0);
}

function function_51b0f4b8cbce83ad(escapestruct) {
  level endon("game_ended");
  escapestruct.var_15fee21b382bfd2e setscriptablepartstate("second_chance_door_dom_gulag", "door_move_down", 0);
  escapestruct.var_9a86491b9a098194 setscriptablepartstate("second_chance_door_dom_gulag", "door_move_down", 0);
  wait level.var_43307855f189eb31.var_61b7b664d529876d;
  escapestruct.var_15fee21b382bfd2e setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still", 0);
  escapestruct.var_9a86491b9a098194 setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still_unusable", 0);
  escapestruct.dooropen = 0;
}

function function_6ce94cf4eee9eab7(escapestruct) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  objective_addclienttomask(escapestruct.objid, player);
  objective_showtoplayersinmask(escapestruct.objid);
}

function function_289f11b986b7a971(arena) {
  escapestruct = self;

  foreach(p in arena.arenaplayers) {
    if(!isDefined(p) || isDefined(p.var_c1057221e17f180b) && p.var_c1057221e17f180b == escapestruct) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(escapestruct.objid, p);
  }
}

function function_45c3dc4231157a10() {
  player = self;
  player endon("disconnect");
  level endon("game_ended");
  wait 11;

  if(!player scripts\mp\gametypes\br_public::isplayerinorgoingtogulag()) {
    player kill();
  }
}

function function_64b7b488766db3c6(headicon, var_ca5a607c4f7a315) {
  playershowto = self;
  level endon("game_ended");
  var_ca5a607c4f7a315 endon("watchHeadIconDelete");
  waittill_any_ents(playershowto, "death", playershowto, "disconnect", playershowto, "gulag_end", playershowto, "gulagLost");

  if(!isDefined(playershowto)) {
    return;
  }

  removeclientfromheadiconmask(headicon, playershowto);
}

function function_4cba46d26023c1db(headicon, playershowto) {
  var_ca5a607c4f7a315 = self;
  level endon("game_ended");
  waittill_any_ents(var_ca5a607c4f7a315, "death", var_ca5a607c4f7a315, "disconnect", var_ca5a607c4f7a315, "gulag_end", var_ca5a607c4f7a315, "gulagLost");
  var_ca5a607c4f7a315 notify("watchHeadIconDelete");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(headicon);
}

function function_6f05f895a3054ff0(arena) {
  foreach(escapestruct in arena.escapestructs) {
    objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(objid != -1) {
      doorcenter = (escapestruct.var_15fee21b382bfd2e.origin + escapestruct.var_9a86491b9a098194.origin) / 2;
      offset = (doorcenter - escapestruct.origin) * 0.9;
      scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", escapestruct.origin + (offset[0], offset[1], 60), "ui_mp_br_icon_gulag_exit_objective");
      scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
      scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
    } else {
      println("<dev string:x1c>");
    }

    escapestruct.objid = objid;
  }
}

function function_1167994a7ce49346() {
  player = self;
  player.var_d4516c0702838861 = 0;
  player.var_6fc7042ad8a7dd15 = 0;
}

function function_c84e254980c7c8ed() {
  player = self;

  if(istrue(level.usegulag) && isDefined(level.var_43307855f189eb31) && !istrue(level.var_43307855f189eb31.var_186b191e239abc1c) && isDefined(player) && isPlayer(player) && player scripts\mp\gametypes\br_public::isplayeringulag()) {
    return false;
  }

  return true;
}

function function_a65df5d97ee38203(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  if(!isDefined(arena.bestscore)) {
    arena.bestscore = 0;
  }

  var_728eb76c27b59bf0 = function_26945642f76b4740();
  [totalscore, var_a12d637dfb1ff12f, var_20e6d5414d4c7ade, var_b2f307125dff1489, var_d8fe1c1dd6ddb7c5, starscore] = function_2f009f7eaad038cc(var_728eb76c27b59bf0);
  player function_a8e64bd30c96ecfb(player.gulagkills, var_728eb76c27b59bf0, var_b2f307125dff1489);
  isbestscore = 0;

  if(totalscore > arena.bestscore) {
    isbestscore = 1;
    arena.bestscore = totalscore;
  }

  player function_dc8ce3434bd7703d(isbestscore, starscore, totalscore);
  player thread scripts\mp\utility\points::doscoreevent(#"br_ai_gulag_score", undefined, int(totalscore / 450) * 10);
}

function function_2f009f7eaad038cc(var_728eb76c27b59bf0) {
  player = self;
  finalscore = 0;
  var_d68490486b12f2f1 = 0;

  if(isDefined(level.var_43307855f189eb31.var_d8acf770bb690e88) && level.var_43307855f189eb31.var_d8acf770bb690e88 > 0) {
    var_d68490486b12f2f1 = level.var_43307855f189eb31.var_d8acf770bb690e88;
  }

  var_a12d637dfb1ff12f = 0;

  if(isDefined(level.var_43307855f189eb31.var_d5e82d0c08288a76) && level.var_43307855f189eb31.var_d5e82d0c08288a76 != "") {
    var_4d2dc00b3efb6af8 = strtok(level.var_43307855f189eb31.var_d5e82d0c08288a76, " ");
    i = 0;

    while(i < var_4d2dc00b3efb6af8.size) {
      if(int(var_4d2dc00b3efb6af8[i]) >= var_728eb76c27b59bf0) {
        if(isDefined(var_4d2dc00b3efb6af8[i - 1])) {
          var_a12d637dfb1ff12f = int(var_4d2dc00b3efb6af8[i - 1]);
        } else {
          var_a12d637dfb1ff12f = int(var_4d2dc00b3efb6af8[i + 1]);
        }

        break;
      }

      i += 2;
    }
  }

  var_20e6d5414d4c7ade = 0;

  if(isDefined(player.gulagkills) && isDefined(level.var_43307855f189eb31.var_f61587ba0e14efb3) && level.var_43307855f189eb31.var_f61587ba0e14efb3 != "") {
    var_e9c56b253dd633cb = strtok(level.var_43307855f189eb31.var_f61587ba0e14efb3, " ");
    i = 0;

    while(i < var_e9c56b253dd633cb.size) {
      if(int(var_e9c56b253dd633cb[i]) <= player.gulagkills) {
        if(isDefined(var_e9c56b253dd633cb[i + 1])) {
          var_20e6d5414d4c7ade = int(var_e9c56b253dd633cb[i + 1]);
        } else {
          var_20e6d5414d4c7ade = int(var_e9c56b253dd633cb[i - 1]);
        }

        break;
      }

      i += 2;
    }
  }

  var_34d1d564db76a821 = 0;
  var_88af353046e1f521 = 0;

  if(isDefined(player.var_322535086c0890fa) && player.var_322535086c0890fa > 0 && isDefined(level.var_43307855f189eb31.var_f38668696712bbec) && level.var_43307855f189eb31.var_f38668696712bbec != "") {
    var_af552ca0755793ee = strtok(level.var_43307855f189eb31.var_f38668696712bbec, " ");

    if(isDefined(player.var_d25277121d9d0a6c) && player.var_d25277121d9d0a6c > 0 && isDefined(player.var_322535086c0890fa) && player.var_322535086c0890fa > 0) {
      var_88af353046e1f521 = int(player.var_d25277121d9d0a6c / player.var_322535086c0890fa * 100);
    }

    i = 0;

    while(i < var_af552ca0755793ee.size) {
      if(int(var_af552ca0755793ee[i]) <= var_88af353046e1f521) {
        if(isDefined(var_af552ca0755793ee[i + 1])) {
          var_34d1d564db76a821 = int(var_af552ca0755793ee[i + 1]);
        } else {
          var_34d1d564db76a821 = int(var_af552ca0755793ee[i - 1]);
        }

        break;
      }

      i += 2;
    }
  }

  var_d8fe1c1dd6ddb7c5 = 0;

  if(isDefined(level.var_43307855f189eb31.var_a3c8a88ee8f693b1) && level.var_43307855f189eb31.var_a3c8a88ee8f693b1 != "") {
    var_690c6123b234ebc1 = strtok(level.var_43307855f189eb31.var_a3c8a88ee8f693b1, " ");

    if(!isDefined(player.var_3a7c9a3e9aa20358)) {
      var_d8fe1c1dd6ddb7c5 = int(var_690c6123b234ebc1[1]);
    } else {
      i = 0;

      while(i < var_690c6123b234ebc1.size) {
        if(int(var_690c6123b234ebc1[i]) >= player.var_3a7c9a3e9aa20358) {
          if(isDefined(var_690c6123b234ebc1[i - 1])) {
            var_d8fe1c1dd6ddb7c5 = int(var_690c6123b234ebc1[i - 1]);
          } else {
            var_d8fe1c1dd6ddb7c5 = int(var_690c6123b234ebc1[i + 1]);
          }

          break;
        }

        i += 2;
      }
    }
  }

  finalscore = var_d68490486b12f2f1 + var_a12d637dfb1ff12f + var_20e6d5414d4c7ade + var_34d1d564db76a821 + var_d8fe1c1dd6ddb7c5;
  starscore = 0;

  if(isDefined(level.var_43307855f189eb31.var_d1562ade1a147c53) && level.var_43307855f189eb31.var_d1562ade1a147c53 != "") {
    var_1dbbd8627f3848eb = strtok(level.var_43307855f189eb31.var_d1562ade1a147c53, " ");
    i = 0;

    while(i < var_1dbbd8627f3848eb.size) {
      if(int(var_1dbbd8627f3848eb[i]) > finalscore) {
        if(isDefined(var_1dbbd8627f3848eb[i - 1])) {
          starscore = int(var_1dbbd8627f3848eb[i - 1]);
        } else {
          starscore = int(var_1dbbd8627f3848eb[i + 1]);
        }

        break;
      }

      i += 2;
    }
  }

  player.var_938604a8b5dd849 = finalscore;
  player.var_e1ed3a7677ef1776 = starscore;
  return [finalscore, var_a12d637dfb1ff12f, var_20e6d5414d4c7ade, var_88af353046e1f521, var_d8fe1c1dd6ddb7c5, starscore];
}

function function_a8e64bd30c96ecfb(playerkills, playertime, var_b2f307125dff1489) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  if(!isDefined(playerkills) || playerkills < 0) {
    playerkills = 0;
  }

  playertime = int(playertime / 100);
  omnvarvalue = function_8e6f76b7c8c0eaf0(playerkills, playertime, var_b2f307125dff1489);
  player setclientomnvar("ui_br_ai_gulag_end_score", omnvarvalue);
}

function function_8e6f76b7c8c0eaf0(playerkills, playertime, var_b2f307125dff1489) {
  playerkillsmax = 32 - 1;
  var_e6ae9427c9926ae1 = 1024 - 1;
  var_1c43c0d900e63a9d = 1024 - 1;
  assert(playerkills >= 0 && playerkills <= playerkillsmax);
  assert(playertime >= 0 && playertime <= var_e6ae9427c9926ae1);
  assert(var_b2f307125dff1489 >= 0 && var_b2f307125dff1489 <= var_1c43c0d900e63a9d);
  packedval = int(playerkills) &playerkillsmax;
  packedval += (int(playertime) &var_e6ae9427c9926ae1) << 5;
  packedval += (int(var_b2f307125dff1489) &var_1c43c0d900e63a9d) << 15;
  return packedval;
}

function function_dc8ce3434bd7703d(isbestscore, var_c8e058e41ed64535, playerscore) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  omnvarvalue = function_97d23abeb51a7e62(isbestscore, var_c8e058e41ed64535, playerscore);
  player setclientomnvar("ui_br_ai_gulag_end_score_best", omnvarvalue);
}

function function_97d23abeb51a7e62(isbestscore, var_c8e058e41ed64535, playerscore) {
  var_9683861002fa7757 = 2 - 1;
  var_ba6af4f96dc4a9c9 = 8 - 1;
  playerscoremax = 268435456 - 1;
  assert(isbestscore >= 0 && isbestscore <= var_9683861002fa7757);
  assert(var_c8e058e41ed64535 >= 0 && var_c8e058e41ed64535 <= var_ba6af4f96dc4a9c9);
  assert(playerscore >= 0 && playerscore <= playerscoremax);
  packedval = int(isbestscore) &var_9683861002fa7757;
  packedval += (int(var_c8e058e41ed64535) &var_ba6af4f96dc4a9c9) << 1;
  packedval += (int(playerscore) &playerscoremax) << 4;
  return packedval;
}

function function_17f3636354648f38(var_8e0908c9ad75d350) {
  var_6891a0702de9917e = 256 - 1;
  assert(var_8e0908c9ad75d350 >= 0 && var_8e0908c9ad75d350 <= var_6891a0702de9917e);
  packedval = int(var_8e0908c9ad75d350) &var_6891a0702de9917e;
  return packedval;
}

function function_da0a5d9a9fc8abc2(arena) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", arena.center + (0, 0, -60), "hud_icon_objective_skeleton_key");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_hidefromall(objid);
    scripts\mp\objidpoolmanager::objective_set_play_intro(objid, 0);
  } else {
    println("<dev string:x49>");
  }

  arena.var_a9350ed31bec6aef = objid;
}

function function_9f7b9a86a5328f0b(arena, position) {
  if(!isDefined(arena.var_a9350ed31bec6aef)) {
    return;
  }

  objective_position(arena.var_a9350ed31bec6aef, position + (0, 0, 20));

  foreach(p in arena.arenaplayers) {
    if(!isDefined(p)) {
      continue;
    }

    objective_addclienttomask(arena.var_a9350ed31bec6aef, p);
    objective_showtoplayersinmask(arena.var_a9350ed31bec6aef);
  }
}

function function_ba5dbc7633c84a(arena) {
  if(!isDefined(arena.var_a9350ed31bec6aef)) {
    return;
  }

  foreach(p in arena.arenaplayers) {
    if(!isDefined(p)) {
      continue;
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(arena.var_a9350ed31bec6aef, p);
  }
}

function function_d8f18f1d691c0ef8(arena) {
  if(level.var_43307855f189eb31.var_82fedf664ad855eb <= 0) {
    return false;
  }

  if(level.var_43307855f189eb31.var_82fedf664ad855eb == 1) {
    return true;
  } else if(level.var_43307855f189eb31.var_82fedf664ad855eb == 2) {
    if(!istrue(arena.var_5f525e1e05714bb5)) {
      return true;
    }
  }

  return false;
}

function function_d095c23873d8efed(overridearenas, forceoverride) {
  arenas = ter_op(istrue(forceoverride), overridearenas, level.gulag.arenas);
  var_94afb7d602135955 = getdvarint(@ "hash_8bdee07fa09e810a", -1);

  if(var_94afb7d602135955 > -1) {
    return level.gulag.arenas[var_94afb7d602135955];
  }

  if(!istrue(level.gulag.multiarena)) {
    return scripts\mp\gametypes\br_gulag::function_bee59f29dedc0fd6(overridearenas);
  }

  var_f8e38f0423a1a9c5 = 1;

  foreach(arena in arenas) {
    if(arena.matches.size > 0) {
      var_f8e38f0423a1a9c5 = 0;
      break;
    }
  }

  if(var_f8e38f0423a1a9c5) {
    return scripts\mp\gametypes\br_gulag::function_ba2be3e8cd3fb169(overridearenas);
  }

  var_5dd209c141f918fa = undefined;
  var_318a1dbf1a07dcb0 = -1;
  var_8364436b57c5e611 = 0;

  foreach(arena in arenas) {
    if(!scripts\mp\gametypes\br_gulag::isarenaenabled(arena, self)) {
      continue;
    }

    foreach(match in arena.matches) {
      if(match.size < 2 && var_318a1dbf1a07dcb0 < 2) {
        foreach(player in match) {
          var_de841985a7f29953 = scripts\mp\gametypes\br_gulag::function_6a7526f387d26776(match);

          if(match.size < 2) {
            if(var_de841985a7f29953 < 1) {
              if(!var_8364436b57c5e611 || istrue(arena.fightover)) {
                var_318a1dbf1a07dcb0 = match.size;
                var_5dd209c141f918fa = arena;
                var_8364436b57c5e611 = istrue(arena.fightover);
              }
            }

            continue;
          }

          if(!var_8364436b57c5e611 || istrue(arena.fightover)) {
            var_318a1dbf1a07dcb0 = match.size;
            var_5dd209c141f918fa = arena;
            var_8364436b57c5e611 = istrue(arena.fightover);
          }
        }
      }
    }
  }

  if(var_318a1dbf1a07dcb0 != -1) {
    return var_5dd209c141f918fa;
  }

  arenas = ter_op(isDefined(overridearenas), overridearenas, level.gulag.arenas);
  var_ca6fb26113abaf27 = 99;
  var_5dd209c141f918fa = undefined;

  foreach(arena in arenas) {
    if(!scripts\mp\gametypes\br_gulag::isarenaenabled(arena, self)) {
      continue;
    }

    if(arena.matches.size < var_ca6fb26113abaf27) {
      match = arena.matches[arena.matches.size - 1];

      if(isDefined(match) && match.size > 0) {
        foreach(player in match) {
          var_de841985a7f29953 = scripts\mp\gametypes\br_gulag::function_6a7526f387d26776(match);

          if(var_de841985a7f29953 < 2) {
            var_ca6fb26113abaf27 = arena.matches.size;
            var_5dd209c141f918fa = arena;
          }
        }
      } else {
        var_ca6fb26113abaf27 = arena.matches.size;
        var_5dd209c141f918fa = arena;
      }
    }

    if(arena.matches.size == var_ca6fb26113abaf27) {
      if(istrue(arena.fightover) && !istrue(var_5dd209c141f918fa.fightover)) {
        var_5dd209c141f918fa = arena;
      }
    }
  }

  if(isDefined(var_5dd209c141f918fa)) {
    return var_5dd209c141f918fa;
  }

  scripts\mp\utility\script::demoforcesre("[GULAG] gulag_playerGetNextArena : could not find a proper gulag arena. Returning a random arena");
  return arenas[randomint(arenas.size)];
}

function function_b57f39d9e91ebf95(arena) {
  arenacenter = arena.center;
  lootcaches = getlootscriptablearray("br_loot_cache_gulag");

  foreach(cache in lootcaches) {
    if(distance(cache.origin, arenacenter) < 8000) {
      items = getscriptablelootcachecontents(cache);
      cache.contents = scripts\mp\gametypes\br_lootcache::function_ec87b214cd429e96(items, undefined);
      cache setscriptablepartstate("body", "closed_usable");
    }
  }
}

function function_2f4344abdc200e43(player) {
  if(isDefined(level.gulag) && isDefined(level.gulag.arenas)) {
    for(i = 0; i < level.gulag.arenas.size; i++) {
      var_f40e6deec30ee209 = level.gulag.arenas[i];

      foreach(arenaplayer in var_f40e6deec30ee209.arenaplayers) {
        if(!isDefined(arenaplayer)) {
          continue;
        }

        if(arenaplayer == player) {
          arena = level.gulag.arenas[i];
          return arena;
        }
      }
    }
  }

  return undefined;
}

function function_de20b194b1a37513(player) {
  for(i = 0; i < level.gulag.arenas.size; i++) {
    var_f40e6deec30ee209 = level.gulag.arenas[i];

    foreach(jailedplayers in var_f40e6deec30ee209.jailedplayers) {
      if(!isDefined(jailedplayers)) {
        continue;
      }

      if(jailedplayers == player) {
        arena = level.gulag.arenas[i];
        return arena;
      }
    }
  }

  return undefined;
}

function function_394c37628afd48ef(arena) {
  if(isDefined(arena.var_6d4e3b180776136f)) {
    foreach(var_fa4b87eba037f1bc in arena.var_6d4e3b180776136f) {
      if(!isDefined(var_fa4b87eba037f1bc)) {
        continue;
      }

      var_fa4b87eba037f1bc freescriptable();
    }

    arena.var_6d4e3b180776136f = [];
    function_ba5dbc7633c84a(arena);
  }
}

function function_15997d969114692d(arena) {
  foreach(escapestruct in arena.escapestructs) {
    escapestruct.var_15fee21b382bfd2e setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still", 0);
    escapestruct.var_15fee21b382bfd2e.origin = escapestruct.var_15fee21b382bfd2e.initiallocation;
    escapestruct.var_9a86491b9a098194 setscriptablepartstate("second_chance_door_dom_gulag", "door_standing_still", 0);
    escapestruct.var_9a86491b9a098194.origin = escapestruct.var_9a86491b9a098194.initiallocation;
  }
}

function function_1794ec0dece12d2f(arena) {
  foreach(loot in arena.lootpickedup) {
    if(!isDefined(loot)) {
      continue;
    }

    loot setscriptablepartstate(loot.type, "visible");
  }

  arena.lootpickedup = [];
}

function function_9efae38238e4df66(attacker, victim) {
  if(!namespace_eb17b46cdcb98eea::function_27c68dd3e26c23db("gulag2v2Teams")) {
    return false;
  }

  arena = function_2f4344abdc200e43(attacker);

  if(!isDefined(arena)) {
    return false;
  }

  if(isPlayer(victim) && isPlayer(attacker) && istrue(victim.gulag) && istrue(attacker.gulag)) {
    var_2407f73b07f0c500 = array_contains(arena.var_801cdcfadc4d465c, attacker);
    var_4b99b4cadbeea961 = array_contains(arena.var_801cdcfadc4d465c, victim);
    var_95101f232ed9ff74 = undefined;
    var_d08f19428aefdd07 = undefined;

    if(isDefined(arena.var_af5243fbba0720c2)) {
      var_95101f232ed9ff74 = array_contains(arena.var_af5243fbba0720c2, attacker);
      var_d08f19428aefdd07 = array_contains(arena.var_af5243fbba0720c2, victim);
    }

    if(var_2407f73b07f0c500 && var_4b99b4cadbeea961 || isDefined(var_95101f232ed9ff74) && isDefined(var_d08f19428aefdd07) && var_95101f232ed9ff74 && var_d08f19428aefdd07) {
      return true;
    }
  }

  return false;
}

function function_c210e62f0b64cfb1(attacker, victim) {
  if(!namespace_eb17b46cdcb98eea::function_27c68dd3e26c23db("gulag2v2Teams") || !isDefined(victim) || !isDefined(attacker)) {
    return false;
  }

  if(victim.team != attacker.team) {
    return false;
  }

  arena = function_2f4344abdc200e43(attacker);

  if(!isDefined(arena)) {
    return false;
  }

  if(isPlayer(victim) && isPlayer(attacker) && istrue(victim.gulag) && istrue(attacker.gulag)) {
    if(victim.team == attacker.team) {
      var_2407f73b07f0c500 = array_contains(arena.var_801cdcfadc4d465c, attacker);
      var_4b99b4cadbeea961 = array_contains(arena.var_801cdcfadc4d465c, victim);
      var_95101f232ed9ff74 = array_contains(arena.var_af5243fbba0720c2, attacker);
      var_d08f19428aefdd07 = array_contains(arena.var_af5243fbba0720c2, victim);

      if(var_2407f73b07f0c500 && var_d08f19428aefdd07 || var_4b99b4cadbeea961 && var_95101f232ed9ff74) {
        return true;
      }
    }
  }

  return false;
}

function function_63cef9bb6769f404(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player freezecontrols(1);
  player freezelookcontrols(1);
  wait 1;

  if(!isDefined(player)) {
    return;
  }

  wait 0.1;

  if(!isDefined(player)) {
    return;
  }

  var_b4637ecadc7205c6 = player.origin + (0, 0, 600);
  var_6c9e9a5ac1a039a9 = player.origin + (0, 0, 72);
  camera = spawn("script_model", var_b4637ecadc7205c6);
  camera setModel("tag_origin");
  camera.angles = (60, player.angles[1], 0);
  player.var_b6149f3189deb38 = camera;
  player cameralinkTo(camera, "tag_origin", 1, 1);
  wait 2.5;
  camera rotateTo((20, player.angles[1], 0), 1.7, 0.5, 0.5);
  wait 0.5;
  var_67654372c5d5b194 = undefined;

  if(namespace_eb17b46cdcb98eea::function_cfe304859f30e747("isGulagJailTimeoutVariation")) {
    var_67654372c5d5b194 = namespace_eb17b46cdcb98eea::function_3cceb052d780fef1("isGulagJailTimeoutVariation", arena);
  }

  if(istrue(var_67654372c5d5b194)) {
    player thread scripts\mp\hud_message::showsplash("br_twotwo_one_v_one_gulag_match_intro");
  } else {
    player thread scripts\mp\hud_message::showsplash("br_twotwo_gulag_match_intro");
  }

  wait 2.2;

  if(!isDefined(camera) || !isDefined(player)) {
    return;
  }

  camera moveTo(var_6c9e9a5ac1a039a9, 1.3, 0.5, 0.5);
  camera rotateTo(player.angles, 0.8, 0.3, 0.3);
  wait 1.5;

  if(!isDefined(camera) || !isDefined(player)) {
    return;
  }

  player cameraunlink();
  player freezecontrols(0);
  player freezelookcontrols(0);
  wait 0.5;

  if(!isDefined(camera) || !isDefined(player)) {
    return;
  }

  camera delete();
  player.var_b6149f3189deb38 = undefined;
}

function function_85b349978cd4de4f(arena) {
  player = self;
  level endon("game_ended");
  level endon("gulag_break");
  player endon("disconnect");
  player thread function_e14e13143d59c4b2(arena);
  player waittill_notify_or_timeout("gulag_player_ready_loadout", 2);

  if(!isDefined(player)) {
    return;
  }

  xcam = "wz_gulag_player_acknowledge_l_xcam";
  animationname = "wz_gulag_player_acknowledge_l";

  if(player.var_98482020d94dbd8 == 2) {
    xcam = "wz_gulag_player_acknowledge_r_xcam";
    animationname = "wz_gulag_player_acknowledge_r";
  }

  primaryweaponobj = player getcurrentweapon();

  if(isDefined(primaryweaponobj) && primaryweaponobj.classname == "pistol") {
    animationname += "_pistol";
  }

  player thread function_696f54da8fcb6bbe("gulag_jailer_intro", arena);

  if(level.var_43307855f189eb31.var_2f9ae625d3d6ef89) {
    player freezecontrols(1);
  }

  player dontinterpolate();
  wait 0.8;

  if(!isDefined(player)) {
    return;
  }

  if(isDefined(player.var_600419d0dbb63af7)) {
    player setOrigin(player.var_600419d0dbb63af7);
    player.var_600419d0dbb63af7 = undefined;
  }

  if(isDefined(player.var_35f055a703ec57d7)) {
    player setplayerangles(player.var_35f055a703ec57d7);
    player.var_35f055a703ec57d7 = undefined;
  }

  wait 0.2;

  if(!isDefined(player)) {
    return;
  }

  player namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
  player playxcam(xcam, 0, player.origin, player.angles);
  player playanimscriptsceneevent("scripted_scene", animationname);
  xcamlength = getxcamlength(xcam);
  wait xcamlength - 0.75;

  if(!isDefined(player)) {
    return;
  }

  player namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
  wait 0.7;

  if(!isDefined(player)) {
    return;
  }

  if(level.var_43307855f189eb31.var_2f9ae625d3d6ef89) {
    player freezecontrols(0);
  }

  if(level.var_43307855f189eb31.var_592faf90ea5616f5) {
    player scripts\cp_mp\utility\inventory_utility::function_f1e9d0c09f38006b(0);
    player thread scripts\cp_mp\utility\inventory_utility::function_9897d143c3feee05();
  }

  player namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
}

function function_608e28250c9d63a9(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  wait 1;

  if(!isDefined(player)) {
    return;
  }

  player thread function_e14e13143d59c4b2(arena);
  player waittill_notify_or_timeout("gulag_player_ready_loadout", 2);

  if(!isDefined(player)) {
    return;
  }

  if(isDefined(player.var_35f055a703ec57d7)) {
    player setplayerangles(player.var_35f055a703ec57d7);
    player.var_35f055a703ec57d7 = undefined;
  }

  if(isDefined(player.var_600419d0dbb63af7)) {
    player setOrigin(player.var_600419d0dbb63af7);
    player.var_600419d0dbb63af7 = undefined;
  }

  player thread function_696f54da8fcb6bbe("gulag_jailer_intro", arena);
  blackscreenup = player namespace_8bfdb6eb5a3df67a::playeriscinematiclayeron();

  if(blackscreenup) {
    player namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
  }
}

function function_e14e13143d59c4b2(arena) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");

  if(player.gulagloadoutindex == 1) {
    loadout = arena.var_1003fa05cffaadcb;
  } else {
    loadout = arena.var_28ddcfcec434cbf5;
  }

  if(level.var_43307855f189eb31.var_3b156be10b96edb9) {
    loadout = arena.var_1003fa05cffaadcb;
  }

  if(level.var_43307855f189eb31.forceloadoutindex >= 0) {
    loadout = scripts\mp\gametypes\br_twotwo_gulag::function_91b7c321b7e78443(level.var_43307855f189eb31.forceloadoutindex);
  }

  assert(isDefined(loadout));

  if(!isDefined(loadout)) {
    loadout = scripts\mp\gametypes\br_twotwo_gulag::function_91b7c321b7e78443(level.var_43307855f189eb31.forceloadoutindex[0]);
  }

  var_f055075301c996b0 = loadout["loadoutPrimary"];

  for(primaryweaponobj = player getcurrentweapon(); primaryweaponobj.basename != var_f055075301c996b0; primaryweaponobj = player getcurrentweapon()) {
    wait 0.1;

    if(!isDefined(player)) {
      return;
    }
  }

  player notify("gulag_player_ready_loadout");
}

function function_7ad9fcb1ac4f3db8() {
  return istrue(level.var_43307855f189eb31.var_2ad1f292809c28bb);
}

function function_1082d39cdba869d9() {
  if(namespace_eb17b46cdcb98eea::function_1980065ce4dc067b() && istrue(level.var_43307855f189eb31.var_78a9fe891a9f4771)) {
    return true;
  }

  return false;
}

function function_696f54da8fcb6bbe(dialog, arena) {
  if(!level.var_43307855f189eb31.var_82fedf664ad855eb) {
    return;
  }

  player = self;

  if(!isDefined(player) || !isDefined(game["dialog"][dialog])) {
    return;
  }

  soundname = tolower("dx_br_brgj_" + game["dialog"][dialog]);
  soundlocation = undefined;

  if(isDefined(arena.audio_struct) && istrue(level.var_43307855f189eb31.var_1a56fc9a83d19e68)) {
    soundlocation = arena.audio_struct.origin;
  } else {
    soundlocation = player.origin;
  }

  if(soundexists(soundname)) {
    if(isent(arena.var_5c21e504cdf8c47)) {
      player playsoundtoplayer(soundname, player, arena.var_5c21e504cdf8c47);
    } else {
      soundlength = lookupsoundlength(soundname, 1) / 1000;
      player queuedialogforplayer(soundname, dialog, soundlength, undefined, undefined, soundlocation, soundlength);
    }

    return;
  }

  scripts\mp\utility\script::demoforcesre("missing VO " + soundname);
}

function function_63776b389e7c92c1() {
  player = self;
  player.arenastarttime = gettime();
  player.gulagkills = 0;
  player.var_d919d1c70719e664 = 0;
  arena = function_2f4344abdc200e43(player);

  for(i = 0; i < level.gulag.arenas.size; i++) {
    if(arena == level.gulag.arenas[i]) {
      player.gulagarenaindex = i;
    }
  }
}

function function_dcead2b56fdbf3e(var_6b7cded46e0d4030) {
  player = self;

  if(!isDefined(player)) {
    return;
  }

  eventparams = [];
  eventparams[eventparams.size] = "waiting_duration";
  waitingduration = function_aa018b2f697301f3();
  eventparams[eventparams.size] = waitingduration;
  eventparams[eventparams.size] = "gulag_duration";
  gulagduration = function_26945642f76b4740();
  eventparams[eventparams.size] = gulagduration;
  eventparams[eventparams.size] = "gulag_ai_kills";
  var_5e3569a259244137 = function_b48cef39dba5574c();
  eventparams[eventparams.size] = var_5e3569a259244137;
  eventparams[eventparams.size] = "gulag_pickups";
  var_2134a6b39f9a41fd = function_86042b32222cf561();
  eventparams[eventparams.size] = var_2134a6b39f9a41fd;
  eventparams[eventparams.size] = "gulag_cargo_hold";
  var_f96046226b97e66d = function_a71d1becf0f787e();
  eventparams[eventparams.size] = var_f96046226b97e66d;
  eventparams[eventparams.size] = "gulag_cargo_cable";
  var_9c99efde39be3331 = function_3facab0d974296c1();
  eventparams[eventparams.size] = var_9c99efde39be3331;
  eventparams[eventparams.size] = "gulag_cargo_camera";
  var_648bafb49d3955c7 = function_2d65e8e1f1efa597();
  eventparams[eventparams.size] = var_648bafb49d3955c7;
  eventparams[eventparams.size] = "gulag_cargo_vent";
  var_ed714bd83b80fd97 = function_e80560f9093cbac7();
  eventparams[eventparams.size] = var_ed714bd83b80fd97;
  eventparams[eventparams.size] = "gulag_cargo_bag";
  var_78b1d64a94559ede = function_99b351b3a052dd2e();
  eventparams[eventparams.size] = var_78b1d64a94559ede;
  eventparams[eventparams.size] = "gulag_end";

  if(!isDefined(var_6b7cded46e0d4030)) {
    var_6b7cded46e0d4030 = "br_gulag_winner";
  }

  eventparams[eventparams.size] = var_6b7cded46e0d4030;
  eventparams[eventparams.size] = "gulag_people";
  var_888e16ca56e7e1e7 = function_45ff0cc82df08d72();
  eventparams[eventparams.size] = var_888e16ca56e7e1e7;
  eventparams[eventparams.size] = "gulag_ai_num";
  var_8d5b50153020668e = function_f613b9df824f0a2f();
  eventparams[eventparams.size] = var_8d5b50153020668e;
  eventparams[eventparams.size] = "gulag_ai_accuracy";
  var_b2f307125dff1489 = function_4eef2886f50daccc();
  eventparams[eventparams.size] = var_b2f307125dff1489;
  eventparams[eventparams.size] = "gulag_ai_damage_taken";
  playerdamagetaken = function_733138b15e0833ff();
  eventparams[eventparams.size] = playerdamagetaken;
  eventparams[eventparams.size] = "gulag_ai_score";
  playerscore = function_26931875c2ae198d(var_6b7cded46e0d4030);
  eventparams[eventparams.size] = playerscore;
  eventparams[eventparams.size] = "gulag_ai_stars";
  var_c8e058e41ed64535 = function_f9741a6951a9c32e(var_6b7cded46e0d4030);
  eventparams[eventparams.size] = var_c8e058e41ed64535;
  eventparams[eventparams.size] = "gulag_damage_to_ai";
  var_b8fd3452d5b20b5a = function_15ff7e5147d7f156();
  eventparams[eventparams.size] = var_b8fd3452d5b20b5a;
  eventparams[eventparams.size] = "gulag_pickup_key";
  var_120fc14a48b4d2f7 = function_37781cb3598a26e7();
  eventparams[eventparams.size] = var_120fc14a48b4d2f7;
  eventparams[eventparams.size] = "gulag_arena_index";
  var_afc8d0ab589db589 = function_73c92ed8b56292a5();
  eventparams[eventparams.size] = var_afc8d0ab589db589;
  dlog_recordevent("dlog_event_ai_gulag", eventparams);
}

function function_aa018b2f697301f3() {
  player = self;

  if(!isDefined(player.waitingduration)) {
    return -1;
  }

  duration = player.waitingduration;
  return duration;
}

function function_26945642f76b4740() {
  player = self;

  if(!isDefined(player.arenastarttime)) {
    return -1;
  }

  duration = gettime() - player.arenastarttime;
  return duration;
}

function function_b48cef39dba5574c() {
  player = self;

  if(!isDefined(player.gulagaikills)) {
    return -1;
  }

  return player.gulagaikills;
}

function function_86042b32222cf561() {
  player = self;

  if(!isDefined(player.var_d919d1c70719e664)) {
    return -1;
  }

  return player.var_d919d1c70719e664;
}

function function_a71d1becf0f787e() {
  player = self;

  if(!isDefined(player.var_44722265234d31b0)) {
    return 0;
  }

  return player.var_44722265234d31b0;
}

function function_3facab0d974296c1() {
  player = self;

  if(!isDefined(player.var_525c703cfddaf913)) {
    return 0;
  }

  return player.var_525c703cfddaf913;
}

function function_2d65e8e1f1efa597() {
  player = self;

  if(!isDefined(player.var_dbe1d28321e708dd)) {
    return 0;
  }

  return player.var_dbe1d28321e708dd;
}

function function_e80560f9093cbac7() {
  player = self;

  if(!isDefined(player.var_e60b359eb0c2f51d)) {
    return 0;
  }

  return player.var_e60b359eb0c2f51d;
}

function function_99b351b3a052dd2e() {
  player = self;

  if(!isDefined(player.var_2ac81a7104e85b68)) {
    return 0;
  }

  return player.var_2ac81a7104e85b68;
}

function function_37781cb3598a26e7() {
  player = self;

  if(!isDefined(player.var_c51be970ba557af5)) {
    return 0;
  }

  return player.var_c51be970ba557af5;
}

function function_73c92ed8b56292a5() {
  player = self;

  if(!isDefined(player.gulagarenaindex)) {
    return -1;
  }

  return player.gulagarenaindex;
}

function function_45ff0cc82df08d72() {
  player = self;
  arena = function_2f4344abdc200e43(player);

  if(!isDefined(arena) || !isDefined(arena.var_b6b01621833467d1)) {
    return -1;
  }

  return arena.var_b6b01621833467d1;
}

function function_f613b9df824f0a2f() {
  player = self;
  arena = function_2f4344abdc200e43(player);

  if(!isDefined(arena) || !isDefined(arena.var_28a470799d66ecd7)) {
    return -1;
  }

  return arena.var_28a470799d66ecd7;
}

function function_4eef2886f50daccc(var_6b7cded46e0d4030) {
  player = self;
  var_88af353046e1f521 = 0;

  if(isDefined(player.var_d25277121d9d0a6c) && player.var_d25277121d9d0a6c > 0 && isDefined(player.var_322535086c0890fa) && player.var_322535086c0890fa > 0) {
    var_88af353046e1f521 = int(player.var_d25277121d9d0a6c / player.var_322535086c0890fa * 100);
  }

  return var_88af353046e1f521;
}

function function_26931875c2ae198d(var_6b7cded46e0d4030) {
  player = self;

  if(var_6b7cded46e0d4030 == "lost") {
    return -1;
  }

  playerscore = 0;

  if(isDefined(player.var_938604a8b5dd849)) {
    playerscore = player.var_938604a8b5dd849;
  }

  return playerscore;
}

function function_f9741a6951a9c32e(var_6b7cded46e0d4030) {
  player = self;

  if(var_6b7cded46e0d4030 == "lost") {
    return -1;
  }

  var_c8e058e41ed64535 = 0;

  if(isDefined(player.var_e1ed3a7677ef1776)) {
    var_c8e058e41ed64535 = player.var_e1ed3a7677ef1776;
  }

  return var_c8e058e41ed64535;
}

function function_15ff7e5147d7f156() {
  player = self;

  if(!isDefined(player.var_a6e0850023a9d8f9)) {
    return 0;
  }

  return player.var_a6e0850023a9d8f9;
}

function function_733138b15e0833ff(var_6b7cded46e0d4030) {
  player = self;
  playerdamagetaken = 0;

  if(isDefined(player.var_3a7c9a3e9aa20358) && player.var_3a7c9a3e9aa20358 > 0) {
    playerdamagetaken = player.var_3a7c9a3e9aa20358;
  }

  return playerdamagetaken;
}

function function_3f18739ae34d9958() {
  player = self;
  player.arenastarttime = undefined;
  player.var_d919d1c70719e664 = undefined;
  player.twotwoteam = undefined;
  player.gulagkills = undefined;
  player.gulagaikills = undefined;
  player.var_a6e0850023a9d8f9 = undefined;
  player.var_c51be970ba557af5 = undefined;
  player.var_d25277121d9d0a6c = undefined;
  player.var_322535086c0890fa = undefined;
  player.gulagarenaindex = undefined;
  player.var_b6e41a06d7038b6c = undefined;
  player.var_c1e95b394ca1743d = undefined;
  player.var_15682f516ca4fc00 = undefined;
  player.var_936612c9eeedd33b = undefined;
  player.var_89bd3a34ac165f4f = undefined;
  player.var_44172449614f0738 = undefined;
  player.var_3a7c9a3e9aa20358 = undefined;
  player.var_938604a8b5dd849 = undefined;
  player.var_e1ed3a7677ef1776 = undefined;
  player.var_43b2a82936a5e974 = undefined;
  player.var_23b7423e3ad7f311 = undefined;
  player.var_c1057221e17f180b = undefined;
  player.waitingduration = undefined;
  player.var_44722265234d31b0 = undefined;
  player.var_525c703cfddaf913 = undefined;
  player.var_dbe1d28321e708dd = undefined;
  player.var_e60b359eb0c2f51d = undefined;
  player.var_2ac81a7104e85b68 = undefined;
  player.var_b5091efefe8e436b = "none";
}

function function_573dfd8cb86d79f(label, value, point, relativepoint, xoffset, yoffset, color, istimer) {
  player = self;
  fontscale = 1.5;
  fontelem = newclienthudelem(player);

  if(istrue(istimer)) {
    fontelem.elemtype = "timer";
  } else {
    fontelem.elemtype = "font";
  }

  fontelem.font = "default";
  fontelem.fontscale = fontscale;
  fontelem.basefontscale = fontscale;
  fontelem.x = 0;
  fontelem.y = 0;
  fontelem.width = 0;
  fontelem.height = int(level.fontheight * fontscale);
  fontelem.xoffset = 0;
  fontelem.yoffset = 0;
  fontelem.children = [];
  fontelem scripts\mp\hud_util::setparent(level.uiparent);
  fontelem.hidden = 0;
  fontelem.archived = 0;
  fontelem.alpha = 1;
  fontelem scripts\mp\hud_util::setpoint(point, relativepoint, xoffset, yoffset);

  if(isDefined(label)) {
    fontelem.label = label;
  }

  if(isDefined(value)) {
    fontelem setvalue(value);
  }

  if(isDefined(color)) {
    fontelem.color = color;
  }

  return fontelem;
}