/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bounty_system.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\team_assimilation;
#using scripts\mp\utility\teams;
#namespace bounty_system;

function init() {
  if(!function_217e5c3b8a4ca539()) {
    return;
  }

  level.bountycircleradius = getdvarint(@ "hash_7074068242015a8a", 2000);
  level.var_d4e0758bcddaa616 = getdvarint(@ "hash_42c837f8d33c4cd5", 10);
  level.var_c18a1304b5bac209 = getdvarint(@ "hash_b3270a4d9d7c32d1", 0);

  if(scripts\mp\team_assimilation::function_6934349b7823d888()) {
    scripts\mp\team_assimilation::registerteamassimilatecallback(&function_3cd64058b039543d);
  }

  level thread function_85816e9363c64afc();
}

function function_217e5c3b8a4ca539() {
  if(!isDefined(level.var_7481c0699a7c035c)) {
    level.bountyenabled = getdvarint(@ "hash_702af82bfbfd306a", 1);
  }

  return level.bountyenabled;
}

function function_4647cbf23f54d6f6(player, overridesettings) {
  player.hasbounty = 1;
  bountysettings = function_563873982a6bc459(player, overridesettings);
  currentbounty = function_55731d4969878ef(player);

  if(isDefined(currentbounty)) {
    if(currentbounty.priority >= bountysettings.priority) {
      player.var_e2c78227fb084c4[player.var_e2c78227fb084c4.size] = bountysettings;
      player.var_e2c78227fb084c4 = array_removeundefined(player.var_e2c78227fb084c4);

      if(player.var_e2c78227fb084c4.size > 1) {
        player.var_e2c78227fb084c4 = array_sort_with_func(player.var_e2c78227fb084c4, &function_cc061dfab17dd15b);
      }

      level thread function_38fbd8f15ede0c59(bountysettings);
      level thread function_d718b6ff11577e22(bountysettings);
      level thread[[bountysettings.var_7073a47db2f80848]](bountysettings);
      return bountysettings;
    } else {
      currentbounty notify("hide_bounty");
      currentbounty notify("moniter_bounty_prox");
    }
  }

  if(bountysettings.var_d66266e27481ace9 == 2 || bountysettings.var_40ca706da5962314 == 2) {
    bountysettings.headicon = addheadicon(player, bountysettings);
  }

  if(bountysettings.var_d66266e27481ace9 == 1 || bountysettings.var_40ca706da5962314 == 1) {
    bountysettings.circleobjective = function_48da443b1b3fc62f(player, bountysettings);
  }

  if(!isDefined(bountysettings.circleobjective) && !isDefined(bountysettings.headicon)) {
    return;
  }

  if(!isDefined(player.var_e2c78227fb084c4)) {
    player.var_e2c78227fb084c4 = [];
  }

  player.var_e2c78227fb084c4[player.var_e2c78227fb084c4.size] = bountysettings;
  player.var_e2c78227fb084c4 = array_removeundefined(player.var_e2c78227fb084c4);

  if(player.var_e2c78227fb084c4.size > 1) {
    player.var_e2c78227fb084c4 = array_sort_with_func(player.var_e2c78227fb084c4, &function_cc061dfab17dd15b);
  }

  level thread function_38fbd8f15ede0c59(bountysettings);
  level thread function_d718b6ff11577e22(bountysettings);
  level thread[[bountysettings.var_7073a47db2f80848]](bountysettings);
  level thread[[bountysettings.monitorproximity]](bountysettings);
  return bountysettings;
}

function function_a10c4276271c4ad7(bountysettings, success, context) {
  bountysettings.success = istrue(success);
  bountysettings.context = context;
  [[bountysettings.var_88c5361db8dbceac]](bountysettings);

  if(isDefined(bountysettings.player)) {
    if(bountysettings.player.var_5d4efada59c61b13.size > 0) {
      foreach(player in bountysettings.player.var_5d4efada59c61b13) {
        bountysettings.player function_39fc3f494dfd7847(bountysettings, player);
      }
    }

    var_b57efde15223f363 = undefined;

    foreach(index, bounty in bountysettings.player.var_e2c78227fb084c4) {
      var_b57efde15223f363 = index;
      break;
    }

    bountysettings.player.var_e2c78227fb084c4[var_b57efde15223f363] = undefined;
    bountysettings.player.var_e2c78227fb084c4 = array_removeundefined(bountysettings.player.var_e2c78227fb084c4);
    bountysettings.player.hasbounty = bountysettings.player.var_e2c78227fb084c4.size > 0;
    function_c5bd28487bd61e1f(bountysettings.player);
  }

  bountysettings notify("bounty_end");
}

function function_55731d4969878ef(player) {
  if(!function_bc09557189d65e55(player)) {
    return undefined;
  }

  if(!isDefined(player.var_e2c78227fb084c4)) {
    return undefined;
  }

  activebounty = array_get_first_item(player.var_e2c78227fb084c4);
  return activebounty;
}

function function_bc09557189d65e55(player) {
  return istrue(player.hasbounty);
}

function function_d34ea2b5e8f5d93(team) {
  if(!function_57736963a928db85(team)) {
    return [];
  }

  var_6f1f92bf14b2443 = [];
  players = getteamdata(team, "players");

  foreach(player in players) {
    if(function_bc09557189d65e55(player)) {
      var_6f1f92bf14b2443[var_6f1f92bf14b2443.size] = function_55731d4969878ef(player);
    }
  }

  return var_6f1f92bf14b2443;
}

function function_57736963a928db85(team) {
  if(!isDefined(team)) {
    return false;
  }

  players = getteamdata(team, "players");

  foreach(player in players) {
    if(istrue(player.hasbounty)) {
      return true;
    }
  }

  return false;
}

function private function_c5bd28487bd61e1f(player) {
  if(!isDefined(player.var_e2c78227fb084c4)) {
    return;
  }

  if(player.var_e2c78227fb084c4.size <= 0) {
    return;
  }

  player.var_e2c78227fb084c4 = array_removeundefined(player.var_e2c78227fb084c4);
  player.var_e2c78227fb084c4 = array_sort_with_func(player.var_e2c78227fb084c4, &function_cc061dfab17dd15b);
  bountysettings = array_get_first_item(player.var_e2c78227fb084c4);

  if(bountysettings.var_d66266e27481ace9 == 2 || bountysettings.var_40ca706da5962314 == 2) {
    bountysettings.headicon = addheadicon(player, bountysettings);
  }

  if(bountysettings.var_d66266e27481ace9 == 1 || bountysettings.var_40ca706da5962314 == 1) {
    bountysettings.circleobjective = function_48da443b1b3fc62f(player, bountysettings);
  }

  level thread function_38fbd8f15ede0c59(bountysettings);
}

function private function_cc061dfab17dd15b(left, right) {
  return left.priority >= right.priority;
}

function private addheadicon(player, bountysettings) {
  showtoteams = function_3ad2024fafe07c36(player, bountysettings, 2);
  delayedupdates = bountysettings.headiconupdatetime > 0;

  if(delayedupdates) {
    bountysettings.overrideorigin = player.origin;
  }

  headicon = player scripts\cp_mp\entityheadicons::setheadicon_multiimage(showtoteams, bountysettings.headiconfriendly, bountysettings.headiconfriendly, bountysettings.headiconenemy, undefined, 1, bountysettings.var_c5409ca7522182b3, bountysettings.naturaldist, undefined, 1, bountysettings.var_b3ea37733a1577e5, bountysettings.overrideorigin, bountysettings.showonminimap);
  setheadiconteam(headicon, player.team);
  function_ce9d0299637c2c24(headicon, 1);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(headicon, player);

  if(delayedupdates) {
    level thread function_82c32d2cb649e5e3(bountysettings, showtoteams, headicon);
  }

  return headicon;
}

function private function_82c32d2cb649e5e3(bountysettings, showtoteams, headicon) {
  level endon("game_ended");
  bountysettings endon("bounty_end");
  player = bountysettings.player;
  updatetime = bountysettings.headiconupdatetime;

  while(true) {
    wait updatetime;
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(headicon);
    neworigin = player.origin;
    headicon = player scripts\cp_mp\entityheadicons::setheadicon_multiimage(showtoteams, bountysettings.headiconfriendly, bountysettings.headiconfriendly, bountysettings.headiconenemy, undefined, 1, bountysettings.var_c5409ca7522182b3, bountysettings.naturaldist, undefined, 1, bountysettings.var_b3ea37733a1577e5, neworigin, bountysettings.showonminimap);
    setheadiconteam(headicon, player.team);
    function_ce9d0299637c2c24(headicon, 1);
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(headicon, player);
  }
}

function private function_48da443b1b3fc62f(player, bountysettings) {
  circleobjective = function_ecb8c86061989935(player.origin, bountysettings);
  circleobjective.player = player;
  circleobjective scripts\cp_mp\utility\game_utility::function_6b6b6273f8180522(bountysettings.var_e6f187bcb4b1648e, function_1e42c880ad18489e(circleobjective.player.origin, bountysettings.circleradius), bountysettings.circleradius, player);
  circleobjective scripts\cp_mp\utility\game_utility::function_4eaf685bc40a3b9();

  foreach(otherplayer in level.players) {
    if(otherplayer == player) {
      continue;
    }

    if(otherplayer.team == player.team && bountysettings.var_d66266e27481ace9 == 1) {
      circleobjective scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f(otherplayer);
      continue;
    }

    if(otherplayer.team != player.team && bountysettings.var_40ca706da5962314 == 1) {
      circleobjective scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f(otherplayer);
    }
  }

  circleobjective scripts\cp_mp\utility\game_utility::function_d7d113d56ef0ef5b(player);
  circleobjective notify("stop_tracking");
  level thread function_dfe0992113030bd0(circleobjective, bountysettings);
  return circleobjective;
}

function private function_563873982a6bc459(player, overridesettings) {
  if(!isDefined(overridesettings)) {
    overridesettings = spawnStruct();
  }

  bountysettings = spawnStruct();
  bountysettings.player = player;
  bountysettings.priority = default_to(overridesettings.priority, 0);
  bountysettings.var_d66266e27481ace9 = default_to(overridesettings.var_d66266e27481ace9, 2);
  bountysettings.var_40ca706da5962314 = default_to(overridesettings.var_40ca706da5962314, 1);
  bountysettings.inworld = default_to(overridesettings.inworld, 0);
  bountysettings.var_e6f187bcb4b1648e = default_to(overridesettings.var_e6f187bcb4b1648e, "Hostage_Dmz");
  bountysettings.var_d77771d6bfb89518 = default_to(overridesettings.var_d77771d6bfb89518, "icon_skull_large");
  bountysettings.circleradius = default_to(overridesettings.circleradius, level.bountycircleradius);
  bountysettings.circleupdatetime = default_to(overridesettings.circleupdatetime, level.var_d4e0758bcddaa616);
  bountysettings.var_c5409ca7522182b3 = default_to(overridesettings.var_c5409ca7522182b3, 0);
  bountysettings.naturaldist = default_to(overridesettings.naturaldist, 500);
  bountysettings.var_b3ea37733a1577e5 = default_to(overridesettings.var_b3ea37733a1577e5, 0);
  bountysettings.overrideorigin = overridesettings.overrideorigin;
  bountysettings.showonminimap = default_to(overridesettings.showonminimap, 1);
  bountysettings.headiconenemy = default_to(overridesettings.headiconenemy, "hud_icon_new_marked");
  bountysettings.headiconfriendly = default_to(overridesettings.headiconfriendly, "hud_icon_new_marked");
  bountysettings.headiconupdatetime = default_to(overridesettings.headiconupdatetime, level.var_c18a1304b5bac209);
  bountysettings.monitorproximity = default_to(overridesettings.monitorproximity, &function_9a0cb7b36cf2f5a3);
  bountysettings.var_9fccd0c71039eff7 = default_to(overridesettings.var_9fccd0c71039eff7, &function_d13d0f1fa5d13556);
  bountysettings.var_981fda4f385c05d5 = default_to(overridesettings.var_981fda4f385c05d5, &function_acd85be28950f9f8);
  bountysettings.var_88c5361db8dbceac = default_to(overridesettings.var_88c5361db8dbceac, &function_612c88cb58973b43);
  bountysettings.var_7073a47db2f80848 = default_to(overridesettings.var_7073a47db2f80848, &function_6588e43fdfbdd2ad);
  bountysettings.bountytimeout = default_to(overridesettings.bountytimeout, 0);
  return bountysettings;
}

function private function_ecb8c86061989935(origin, bountysettings) {
  circleobjective = spawnStruct();
  circleobjective.curorigin = origin;
  circleobjective.offset3d = (0, 0, 100);
  circleobjective scripts\mp\gameobjects::requestid(1, bountysettings.inworld, undefined, 1, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(circleobjective.objidnum, bountysettings.var_d77771d6bfb89518);
  scripts\mp\objidpoolmanager::update_objective_setbackground(circleobjective.objidnum, 1);
  scripts\mp\objidpoolmanager::update_objective_setzoffset(circleobjective.objidnum, 100);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(circleobjective.objidnum, bountysettings.player.team);
  scripts\mp\objidpoolmanager::function_9cad42ac02eff950(circleobjective.objidnum);
  var_72b01890612ddd21 = function_3ad2024fafe07c36(bountysettings.player, bountysettings, 1);

  foreach(team in var_72b01890612ddd21) {
    scripts\mp\objidpoolmanager::objective_teammask_addtomask(circleobjective.objidnum, team);
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(circleobjective.objidnum, bountysettings.player);
  return circleobjective;
}

function private function_1e42c880ad18489e(origin, radius) {
  point = function_d553466cf817a4da();
  point = (point[0] * radius, point[1] * radius, 0);
  return point + origin;
}

function private function_3aa3f81e3a787e9f(circleobjective, player, bountysettings) {
  origin = function_1e42c880ad18489e(player.origin, bountysettings.circleradius);
  origin += (0, 0, player.origin[2] + 750);
  scripts\mp\objidpoolmanager::update_objective_position(circleobjective.objidnum, origin);
  circleobjective scripts\cp_mp\utility\game_utility::function_6e148c8da2e4db13(origin);
}

function private function_dfe0992113030bd0(circleobjective, bountysettings) {
  circleobjective endon("stop_tracking");
  circleobjective.player endon("death_or_disconnect");
  circleobjective.player endon("enter_live_ragdoll");
  bountysettings endon("bounty_end");
  level endon("game_ended");

  while(true) {
    if(isDefined(circleobjective.player) && isDefined(circleobjective.player.origin)) {
      function_3aa3f81e3a787e9f(circleobjective, circleobjective.player, bountysettings);
    }

    if(bountysettings.circleupdatetime <= 0) {
      waitframe();
      continue;
    }

    wait bountysettings.circleupdatetime;
  }
}

function private function_3ad2024fafe07c36(player, bountysettings, bountytype) {
  isfriendlybounty = bountysettings.var_d66266e27481ace9 == bountytype;
  isenemybounty = bountysettings.var_40ca706da5962314 == bountytype;
  returnteams = [];

  foreach(team in level.teamnamelist) {
    if(isfriendlybounty && team == player.team) {
      returnteams[returnteams.size] = team;
    }

    if(isenemybounty && team != player.team) {
      returnteams[returnteams.size] = team;
    }
  }

  return returnteams;
}

function private function_9a0cb7b36cf2f5a3(bountysettings) {
  level endon("game_ended");
  bountysettings endon("bounty_end");
  bountysettings endon("moniter_bounty_prox");
  proximityowner = bountysettings.player;
  proximityradius = bountysettings.circleradius;
  proximityowner.var_5d4efada59c61b13 = [];

  while(true) {
    proximityorigin = proximityowner.origin;

    if(function_a794fcf9545f2062()) {
      var_38f56723a5f07a13 = function_b1eef70090b5b7b5(proximityorigin, proximityradius, function_869ccb4e3451b8c6(["etype_player"]));
    } else {
      partition = function_21a6a1c613b50a28(level.players, proximityradius);
      var_38f56723a5f07a13 = partition function_df633f460888a47(proximityorigin);
    }

    if(var_38f56723a5f07a13.size > 0) {
      if(proximityowner.var_5d4efada59c61b13.size > 0) {
        foreach(player in proximityowner.var_5d4efada59c61b13) {
          if(!isDefined(player)) {
            continue;
          }

          if(!array_contains(var_38f56723a5f07a13, player)) {
            proximityowner function_39fc3f494dfd7847(bountysettings, player);
          }
        }
      }

      foreach(player in var_38f56723a5f07a13) {
        if(!isDefined(player)) {
          continue;
        }

        if(player == proximityowner) {
          continue;
        }

        proximityowner function_9f2d2403c5359faf(bountysettings, player);
      }
    } else if(proximityowner.var_5d4efada59c61b13.size > 0) {
      foreach(player in proximityowner.var_5d4efada59c61b13) {
        proximityowner function_39fc3f494dfd7847(bountysettings, player);
      }
    }

    wait 0.05;
  }
}

function private function_9f2d2403c5359faf(bountysettings, playerentering) {
  if(array_contains(self.var_5d4efada59c61b13, playerentering)) {
    return;
  }

  self[[bountysettings.var_9fccd0c71039eff7]](bountysettings, playerentering);
  self.var_5d4efada59c61b13[self.var_5d4efada59c61b13.size] = playerentering;
}

function private function_d13d0f1fa5d13556(bountysettings, playerentering) {
  iprintlnbold("<dev string:x1c>" + self.name + "<dev string:x38>" + playerentering.name);
}

function private function_39fc3f494dfd7847(bountysettings, playerexiting) {
  self[[bountysettings.var_981fda4f385c05d5]](bountysettings, playerexiting);
  self.var_5d4efada59c61b13 = array_remove(self.var_5d4efada59c61b13, playerexiting);
}

function private function_acd85be28950f9f8(bountysettings, playerexiting) {
  iprintlnbold("<dev string:x3f>" + self.name + "<dev string:x38>" + playerexiting.name);
}

function private function_612c88cb58973b43(bountysettings) {
  bountysettings.context = default_to(bountysettings.context, 0);

  if(istrue(bountysettings.success)) {
    iprintlnbold("<dev string:x5a>" + bountysettings.context);
    return;
  }

  iprintlnbold("<dev string:x77>" + bountysettings.context);
}

function private function_6588e43fdfbdd2ad(bountysettings) {
  level endon("game_ended");
  bountysettings endon("bounty_end");
  bountysettings.player waittill_any_5("death_or_disconnect", "enter_live_ragdoll", "successful_exfil", "map_to_map_warp");
  success = 0;

  if(!bountysettings.player scripts\cp_mp\utility\player_utility::_isalive()) {
    if(isDefined(bountysettings.player.lastkilledby) && isDefined(bountysettings.player.lastkilledby.team)) {
      bountysettings.killingteam = bountysettings.player.lastkilledby.team;
      bountysettings.killingplayer = bountysettings.player.lastkilledby;
      success = 1;
    }
  }

  context = ter_op(success, 2, 3);
  function_a10c4276271c4ad7(bountysettings, success, context);
}

function private function_d718b6ff11577e22(bountysettings) {
  level endon("game_ended");
  bountysettings endon("bounty_end");

  if(bountysettings.bountytimeout <= 0) {
    return;
  }

  wait bountysettings.bountytimeout;
  function_a10c4276271c4ad7(bountysettings, 0, 1);
}

function private function_38fbd8f15ede0c59(bountysettings) {
  level endon("game_ended");
  bountysettings waittill_any_2("bounty_end", "hide_bounty");

  if(isDefined(bountysettings.headicon)) {
    bountysettings.player scripts\cp_mp\entityheadicons::setheadicon_deleteicon(bountysettings.headicon);
  }

  if(isDefined(bountysettings.circleobjective)) {
    bountysettings.circleobjective notify("stop_tracking");
    bountysettings.circleobjective scripts\mp\gameobjects::releaseid();
    bountysettings.circleobjective scripts\cp_mp\utility\game_utility::function_af5604ce591768e1();
  }
}

function private function_3cd64058b039543d(player, oldteam, newteam) {
  var_f24642b09a1fc3df = function_d34ea2b5e8f5d93(newteam);
  var_aee6c716b9d9abe4 = function_d34ea2b5e8f5d93(oldteam);

  if(var_f24642b09a1fc3df.size == 0 && var_aee6c716b9d9abe4.size == 0) {
    return;
  }

  foreach(bounty in var_f24642b09a1fc3df) {
    if(bounty.player == player) {
      continue;
    }

    headicon = bounty.headicon;

    if(isDefined(headicon)) {
      if(bounty.var_d66266e27481ace9 == 2) {
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(headicon, player);
      } else if(bounty.var_40ca706da5962314 == 2) {
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(headicon, player);
      }
    }

    circle = bounty.circleobjective;

    if(isDefined(circle)) {
      if(bounty.var_d66266e27481ace9 == 1) {
        circle scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f(player);
        continue;
      }

      if(bounty.var_40ca706da5962314 == 1) {
        circle scripts\cp_mp\utility\game_utility::function_d7d113d56ef0ef5b(player);
      }
    }
  }

  foreach(bounty in var_aee6c716b9d9abe4) {
    if(bounty.player == player) {
      continue;
    }

    headicon = bounty.headicon;

    if(isDefined(headicon)) {
      if(bounty.var_40ca706da5962314 == 2) {
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(headicon, player);
      } else if(bounty.var_d66266e27481ace9 == 2) {
        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(headicon, player);
      }
    }

    circle = bounty.circleobjective;

    if(isDefined(circle)) {
      if(bounty.var_40ca706da5962314 == 1) {
        circle scripts\cp_mp\utility\game_utility::function_cfd53c8f6878014f(player);
        continue;
      }

      if(bounty.var_d66266e27481ace9 == 1) {
        circle scripts\cp_mp\utility\game_utility::function_d7d113d56ef0ef5b(player);
      }
    }
  }
}

function private function_85816e9363c64afc() {
  level endon("<dev string:x93>");
  level waittill("<dev string:xa1>");

  while(true) {
    command = getDvar(@ "hash_a42341ed9ee97770", "<dev string:xb9>");
    host = scripts\mp\gamelogic::gethostplayer();

    if(!isDefined(host)) {
      waitframe();
      continue;
    }

    friendlyplayer = undefined;
    enemyplayer = undefined;

    foreach(player in level.players) {
      if(player.team == host.team && player != host && !isDefined(friendlyplayer)) {
        friendlyplayer = player;
        continue;
      }

      if(player.team != host.team && !isDefined(enemyplayer)) {
        enemyplayer = player;
      }
    }

    switch (command) {
      case #"hash_e4c599d868b9bce9":
        overridesettings = spawnStruct();
        overridesettings.priority = 999;
        function_4647cbf23f54d6f6(enemyplayer, overridesettings);
        break;
      case #"hash_523c10141e531855":
        overridesettings = spawnStruct();
        overridesettings.priority = 999;
        overridesettings.bountytimeout = 10;
        function_4647cbf23f54d6f6(enemyplayer, overridesettings);
        break;
      case #"hash_7b505a051b5cf29c":
        currentbounty = function_55731d4969878ef(enemyplayer);

        if(isDefined(currentbounty)) {
          function_a10c4276271c4ad7(currentbounty, 0, 0);
        }

        break;
      default:
        break;
    }

    setDvar(@ "hash_a42341ed9ee97770", "<dev string:xb9>");
    waitframe();
  }
}

# /