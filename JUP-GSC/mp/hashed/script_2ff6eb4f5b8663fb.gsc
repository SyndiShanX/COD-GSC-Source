/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2ff6eb4f5b8663fb.gsc
*************************************************/

#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_24f248b33b79e48d;
#using script_3ab210ea917601e7;
#using script_41387eecc35b88bf;
#using script_638d701d263ee1ed;
#using script_7956d56c4922bd1;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#namespace namespace_94e3188e9c550ef8;

function function_b1466004f2cd38fe() {}

function function_5b4245d8e50d6cc3(dialogue, players, radiotype, var_49a8c885c448979f, clearcurrent, maxlines) {
  if(!isDefined(self.var_339fe154f7fde1c7)) {
    self.var_339fe154f7fde1c7 = 0;
  }

  if(!isDefined(maxlines) && isDefined(level.var_e45d4b8e1cc3925c)) {
    maxlines = level.var_e45d4b8e1cc3925c;
  }

  assert(!isDefined(maxlines) || maxlines >= 1, "<dev string:x1c>");
  radiotype = default_to(radiotype, "distance");
  players = default_to(players, level.players);

  if(!isarray(players)) {
    array = [];
    array[0] = players;
    players = array;
  }

  var_49a8c885c448979f = default_to(var_49a8c885c448979f, 512);
  var_51f779a37e50954f = var_49a8c885c448979f * var_49a8c885c448979f;

  foreach(player in players) {
    if(istrue(clearcurrent) && isDefined(player.dialoguehud) || isDefined(maxlines) && isDefined(player.dialoguehud) && player.dialoguehud.size >= maxlines) {
      ob_dialogue_print_clear(players, 1, maxlines - 1);
    }
  }

  if(isPlayer(self)) {
    color = "^3";
  } else if(isDefined(self.team)) {
    switch (self.team) {
      case #"hash_7c2d091e6337bf54":
        color = "^1";
        break;
      case #"hash_5f54b9bf7583687f":
        color = "^5";
        break;
      case #"hash_24b14065e10b1f8d":
        color = "^4";
        break;
      default:
        color = "^2";
        break;
    }
  } else {
    color = "^2";
  }

  print_str = "";

  if(isDefined(self.name)) {
    print_str += self.name;
  } else if(isPlayer(self)) {
    print_str += "Player";
  } else if(isDefined(self.team)) {
    if(isDefined(level.var_76fed2ad3db8bb83) && isDefined(level.var_76fed2ad3db8bb83[self.team])) {
      print_str += level.var_76fed2ad3db8bb83[self.team];
    } else {
      switch (self.team) {
        case #"hash_7c2d091e6337bf54":
          print_str += "Enemy";
          break;
        case #"hash_24b14065e10b1f8d":
          print_str += "Team3";
          break;
        case #"hash_5f54b9bf7583687f":
          print_str += "Friendly";
          break;
        default:
          print_str += "Civ";
          break;
      }
    }
  }

  foreach(player in players) {
    if(radiotype == "always") {
      print_str += " (radio)";
    } else if(isDefined(self.origin)) {
      playerdistsq = distancesquared(self.origin, player.origin);

      if(playerdistsq > var_51f779a37e50954f) {
        if(radiotype == "never") {
          continue;
        } else {
          print_str += " (radio)";
        }
      }
    }

    if(print_str != "") {
      print_str = color + print_str + ": ^7";
    }

    print_str += dialogue;
    thread function_e232a099eb1f3824(print_str, player);
  }
}

function function_e232a099eb1f3824(string, player) {
  if(isDefined(self.var_339fe154f7fde1c7)) {
    self.var_339fe154f7fde1c7++;
  }

  var_b54520c420443a7c = int(4.9);
  lineheight = int(10);
  var_7794fdd4649e6d7f = int(2);

  if(isDefined(level.var_eecd069bb8d057c5)) {
    endy = level.var_eecd069bb8d057c5;
  } else {
    endy = 420;
  }

  width = int(clamp(string.size * var_b54520c420443a7c, 350, 630));
  string_array = wrap_text(string, int(630 / var_b54520c420443a7c));
  height = lineheight * string_array.size + var_7794fdd4649e6d7f * 2;
  text_array = [];

  foreach(i, string in string_array) {
    text = newclienthudelem(player);
    text.alpha = 0;

    text setdevtext(string);

    text.fontscale = 1;
    text.row = i;
    text_array[text_array.size] = text;
  }

  bg = newclienthudelem(player);
  bg.alpha = 0;
  bg setshader("black", width, height);

  if(isDefined(player.dialoguehud)) {
    foreach(dialogueline in player.dialoguehud) {
      foreach(hud in dialogueline) {
        hud moveovertime(0.3);
        hud.y -= height + 5;
      }
    }
  } else {
    player.dialoguehud = [];
  }

  array = array_add(text_array, bg);
  array[0] endon("ob_dialogue_print_clear");
  player.dialoguehud[player.dialoguehud.size] = array;

  foreach(hud in array) {
    hud.alignx = "center";
    hud.aligny = "top";
    hud.x = 320;
    hud.y = height * -1;
    hud.sort = 5;

    if(isDefined(hud.row)) {
      hud.y += hud.row * lineheight + var_7794fdd4649e6d7f;
    }
  }

  endy -= height;

  foreach(hud in array) {
    hud fadeovertime(0.3);

    if(isDefined(hud.row)) {
      hud.alpha = 1;
    } else {
      hud.alpha = 0.5;
    }

    hud moveovertime(0.3);

    if(isDefined(hud.row)) {
      hud.y = endy + hud.row * lineheight + var_7794fdd4649e6d7f;
      continue;
    }

    hud.y = endy;
  }

  wait 8.3;

  foreach(hud in array) {
    hud fadeovertime(2);
    hud.alpha = 0;
  }

  wait 2;

  if(isDefined(self.var_339fe154f7fde1c7)) {
    self.var_339fe154f7fde1c7--;

    if(self.var_339fe154f7fde1c7 < 0) {
      self.var_339fe154f7fde1c7 = 0;
    }
  }

  foreach(i, dialogueline in player.dialoguehud) {
    if(dialogueline[0] == array[0]) {
      player.dialoguehud = array_remove_index(player.dialoguehud, i, 0);
      break;
    }
  }

  if(!player.dialoguehud.size) {
    player.dialoguehud = undefined;
  }

  foreach(hud in array) {
    hud destroy();
  }
}

function ob_dialogue_print_clear(players, immediate, maxlines) {
  players = default_to(players, level.players);

  if(!isarray(players)) {
    array = [];
    array[0] = players;
    players = array;
  }

  foreach(player in players) {
    if(!isDefined(player.dialoguehud)) {
      return;
    }

    thread function_52f5db5262924a8e(player, immediate, maxlines);
  }
}

function function_52f5db5262924a8e(player, immediate, maxlines) {
  if(!isDefined(maxlines)) {
    maxlines = 0;
  }

  linestoclear = [];
  currentlines = player.dialoguehud.size;

  for(i = 0; i < currentlines && currentlines - linestoclear.size > maxlines; i++) {
    player.dialoguehud[i][0] notify("ob_dialogue_print_clear");
    linestoclear[linestoclear.size] = player.dialoguehud[i];
    player.dialoguehud = array_remove_index(player.dialoguehud, i, 1);
  }

  player.dialoguehud = array_combine(player.dialoguehud);

  if(!istrue(immediate)) {
    foreach(dialogueline in linestoclear) {
      foreach(hud in dialogueline) {
        if(hud.alpha > 0) {
          hud fadeovertime(2);
          hud.alpha = 0;
        }
      }
    }

    wait 2;
  }

  if(isDefined(player.dialoguehud) && !player.dialoguehud.size) {
    player.dialoguehud = undefined;
  }

  foreach(dialogueline in linestoclear) {
    foreach(hud in dialogueline) {
      if(isDefined(hud)) {
        hud destroy();
      }
    }
  }
}

function function_fa26a1bcd7a2798() {}

function function_5a6644a3e62d5303(str_message, position, endons) {
  self endon("activity_ended");

  if(isDefined(endons)) {
    foreach(str in endons) {
      self endon(str);
    }
  }

  for(removed_players = []; isDefined(position); removed_players = array_combine(players, removed_players)) {
    wait 1;

    if(isvector(position)) {
      org = position;
    } else {
      org = position.origin;
    }

    players = function_bef306b5e7aefafc(org);

    if(players.size > 0 && removed_players.size > 0) {
      players = array_remove_array(players, removed_players);
    }

    if(players.size > 0) {
      function_1281c7fff9456e18(str_message, players);
    }
  }
}

function function_d23f4a621dca2786(str_message, position) {
  self endon("activity_ended");
  wait 1;
  players = function_bef306b5e7aefafc(position);

  if(players.size > 0) {
    function_1281c7fff9456e18(str_message, players);
  }
}

function function_bef306b5e7aefafc(position) {
  self endon("activity_ended");
  players = [];
  activity_region = namespace_4df2ab39b0e96ec7::get_region(position);

  foreach(player in level.players) {
    if(isDefined(player) && isalive(player)) {
      player_region = namespace_4df2ab39b0e96ec7::get_region(player.origin);

      if(isDefined(player_region) && player_region == activity_region && !istrue(function_d446389b3af72567(player))) {
        players = array_add(players, player);
      }
    }
  }

  return players;
}

function function_77a5f408a4193b40(str_message, position, range, endons) {
  self endon("activity_ended");

  if(isDefined(endons)) {
    foreach(str in endons) {
      self endon(str);
    }
  }

  range = default_to(range, 3072);

  for(removed_players = []; isDefined(position); removed_players = array_combine(players, removed_players)) {
    wait 1;

    if(!isDefined(position)) {
      break;
    }

    if(isvector(position)) {
      org = position;
    } else {
      org = position.origin;
    }

    players = function_a0f48eb3578c88bd(org, range);

    if(players.size > 0 && removed_players.size > 0) {
      players = array_remove_array(players, removed_players);
    }

    if(players.size > 0) {
      function_1281c7fff9456e18(str_message, players);
    }
  }
}

function function_9af7ccdced20e387(str_message, position, range) {
  self endon("activity_ended");
  range = default_to(range, 3072);

  if(isvector(position)) {
    org = position;
  } else {
    org = position.origin;
  }

  wait 1;
  players = function_a0f48eb3578c88bd(org, range);

  if(players.size > 0) {
    function_1281c7fff9456e18(str_message, players);
  }
}

function function_a0f48eb3578c88bd(position, range) {
  self endon("activity_ended");
  players = scripts\mp\utility\player::getplayersinradius(position, range);

  if(players.size > 0) {
    foreach(player in players) {
      if(istrue(function_4ab1cdfd84bbd3f2(self, player))) {
        continue;
      }

      if(istrue(function_d446389b3af72567(player))) {
        players = array_remove(players, player);
      }
    }
  }

  return players;
}