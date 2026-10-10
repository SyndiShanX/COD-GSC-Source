/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_debug.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\endgame;
#using scripts\cp\intel\cp_intel;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace cp_debug;

function debuginit_demo() {
  level thread function_de4d04211ef12e03(@ "hash_c021e81d04f69f38", &function_38888abb0075b57b);
}

function function_eef8fed381e4deec(dvar, input_func) {
  level notify("watchFor_" + function_f28fd66285fa2c9(dvar));
  level endon("watchFor_" + function_f28fd66285fa2c9(dvar));
  setdvarifuninitialized(dvar, "");

  while(true) {
    var_4f9df27618277b1e = getDvar(dvar, "");

    if(var_4f9df27618277b1e != "") {
      level thread[[input_func]]();
      setDvar(dvar, "");
    }

    wait 0.1;
  }
}

function debuginit() {
  level.debug = spawnStruct();
  level.devgui_setup_func = &onplayerspawneddevguisetup;
  level thread debug_activation(@ "scr_debug", &function_1559d3b069709441);
  level thread debug_activation(@ "debug_nuke", &debug_nuke);
  level thread debug_activation(@ "hash_6b7185384ad3261e", &function_667f9f652c4c79c1);
  setdevdvarifuninitialized(@ "hash_bcb02788b223877", 0);
  setdevdvarifuninitialized(@ "hash_25d628943cd6ea20", 0);
  setdevdvarifuninitialized(@ "hash_8fcf658de0756ca3", "<dev string:x1c>");
  level thread devgiveperks();
  level thread function_aa8545c4caff39ef();
  level thread function_de48ebe7dd8ff882();
  string = "<dev string:x1d>";
  cmd = "<dev string:x50>" + string + "<dev string:x9a>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x9e>";
  addentrytodevgui(cmd);
  cmd = "<dev string:xf4>";
  addentrytodevgui(cmd);
  create_func_ref("<dev string:x15d>", &draw_spawner);
  flag_init("<dev string:x16a>");
  setdvarifuninitialized(@ "debug_colornodes", 0);
}

function function_aa8545c4caff39ef() {
  if(flag_exist("<dev string:x17d>")) {
    flag_wait("<dev string:x17d>");
  }

  foreach(player in level.players) {
    player thread function_d8acbb08ac0dc074(player);
  }

  level thread function_d028c8aea81e0fb0();
}

function function_d028c8aea81e0fb0() {
  while(true) {
    level waittill("<dev string:x18b>", player);

    if(!isDefined(level.players) || level.players.size <= 0) {
      if(isDefined(level.devgui_setup_func)) {
        player thread[[level.devgui_setup_func]](player);
      }

      continue;
    }

    foreach(guy in level.players) {
      if(isDefined(level.devgui_setup_func)) {
        guy thread[[level.devgui_setup_func]](guy);
      }
    }
  }
}

function function_d8acbb08ac0dc074(player) {
  player waittill("<dev string:x195>", player);
  wait 1;

  if(isDefined(level.devgui_setup_func)) {
    foreach(guy in level.players) {
      guy thread[[level.devgui_setup_func]](guy);
    }
  }
}

function debug_line(start, end, duration, color) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  for(i = 0; i < duration * 20; i++) {
    line(start, end, color);
    wait 0.05;
  }
}

function function_de48ebe7dd8ff882() {
  level waittill("<dev string:x1a0>");
  debuginit();

  if(isDefined(level.devgui_setup_func)) {
    foreach(guy in level.players) {
      guy thread[[level.devgui_setup_func]](guy);
    }
  }
}

function debug_nuke(result) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  enemies = scripts\cp\cp_agent_utils::getactiveenemyagents("<dev string:x1b3>");
  amount = 0;

  foreach(guy in enemies) {
    if(!istrue(guy.var_976f32ce5275baaa)) {
      guy suicide();
    }
  }

  level.players[0] scripts\cp\persistence::give_player_currency(amount);
}

function function_667f9f652c4c79c1(dvar_ref) {
  if(!isDefined(level.backpack_disabled)) {
    level.backpack_disabled = getdvarint(@ "hash_390753f43ca68388");
  }

  level.backpack_disabled = !level.backpack_disabled;
  setDvar(@ "hash_390753f43ca68388", level.backpack_disabled);

  for(i = 0; i < level.players.size; i++) {
    level.players[i] disable_backpack_inventory(level.backpack_disabled);
  }
}

function function_1559d3b069709441(itemref) {
  items = strtok(itemref, "<dev string:x1ba>");
  playertoks = strtok(itemref, "<dev string:x1bc>");
  params = strtok(itemref, "<dev string:x1be>");
  player = undefined;

  if(playertoks.size > 1) {
    playerint = int(playertoks[1]);
    player = level.players[playerint];
  } else {
    player = level.players[0];
  }

  switch (items[0]) {
    case #"hash_56f491faf4e12b9b":
      switch (params[1]) {
        case #"hash_fdf9186a60376083":
          foreach(other_player in level.players) {
            other_player val::set("<dev string:x1e4>", "<dev string:x1ea>", 0);
          }

          break;
      }

      break;
    case #"hash_c62ca67d7a04c8df":
      if(!isDefined(level.var_3e7e946ee7aef4e8)) {
        level.var_3e7e946ee7aef4e8 = 0;
      }

      scripts\cp\cp_checkpoint::checkpoint_set("<dev string:x208>" + level.var_3e7e946ee7aef4e8);
      level.var_3e7e946ee7aef4e8++;
      break;
    case #"hash_110e470a124ac013":
      level.var_92d27fad7a27f6dc = "<dev string:x21e>";

      switch (params[0]) {
        case #"hash_291dbe7c5eeea467":
          if(isDefined(params[1])) {
            if(params[1] == "<dev string:x24c>") {
              scripts\cp\cp_analytics::function_ae955ccdef747b0("<dev string:x21e>");
            } else {
              scripts\cp\cp_analytics::function_b6283ac45a607764("<dev string:x21e>");
            }
          } else {
            scripts\cp\cp_analytics::function_ae955ccdef747b0("<dev string:x21e>");
          }

          break;
        case #"hash_4f9bf2fc788e0c11":
          scripts\cp\cp_analytics::logevent_downed(player, player);
          break;
        case #"hash_934869b13eb9f22c":
          scripts\cp\cp_analytics::logevent_kill(player, player, player getcurrentprimaryweapon());
          break;
        case #"hash_45f4c37b5cfd4509":
          foreach(other_player in level.players) {
            other_player scripts\cp\endgame::function_8cf553a1a6826b6c();
          }

          break;
        case #"hash_42dc492f139031c7":
          struct = spawnStruct();
          struct.origin = (0, 0, 0);
          player scripts\cp\intel\cp_intel::function_db99538b03b9907c(struct);
          break;
        case #"hash_ba1c088f2b6b6f3b":
          scripts\cp\cp_analytics::logevent_munitionused(player, "<dev string:x21e>");
          break;
        case #"hash_8a6d429f00ef827f":
          scripts\cp\cp_analytics::logevent_spawnviaautorevive(player);
          break;
        case #"hash_f5d19c979a58b0d4":
          scripts\cp\cp_analytics::logevent_spawnviaplayer(player, player);
          break;
        case #"hash_78bc1fc64ffaf39":
          scripts\cp\cp_analytics::logevent_spawnviateamrevive(player);
          break;
        case #"hash_680959e07d0ec9cd":
          super_ref = player scripts\cp\super::getcurrentsuperref();
          scripts\cp\cp_analytics::logevent_superused(player, super_ref);
          break;
        case #"hash_45091225a0c5cfba":
          scripts\cp\cp_analytics::logevent_xpearned(player, 1, player getcurrentprimaryweapon().basename, 1, "<dev string:x3ac>");
          break;
        case #"hash_a2bdd7b4e9af9e6b":
          scripts\cp\cp_analytics::function_bfe1744ef18f30f9();
          break;
        default:
          break;
      }

      level.var_92d27fad7a27f6dc = undefined;
      break;
    case #"hash_204cad669d00e34d":
      for(i = 0; i < level.players.size; i++) {
        level.players[i] scripts\cp\weapon::function_b65ad646eb126204(params[1]);
      }

      break;
    case #"hash_67723d365fb3b5f1":
      println("<dev string:x3fd>");

      for(i = 0; i < level.players.size; i++) {
        if(i > 0) {
          println("<dev string:x458>");
        }

        type = "<dev string:x4d7>";

        if(istestclient(level.players[i])) {
          type = "<dev string:x4e0>";
        }

        println(level.players[i].name + "<dev string:x4ed>" + type + "<dev string:x4f1>");
        currentweapon = level.players[i] getcurrentweapon();
        println("<dev string:x4fa>" + getcompleteweaponname(currentweapon));
        weapons_list = level.players[i] getweaponslistall();

        for(j = 0; j < weapons_list.size; j++) {
          weapon = weapons_list[j];

          if(weapon == currentweapon) {
            continue;
          }

          println("<dev string:x514>" + getcompleteweaponname(weapon));
        }
      }

      println("<dev string:x52e>");
      break;
    case #"hash_460144c6fac9c768":
      scripts\cp\endgame::function_74d2ca228d4852d6();
      break;
    case #"hash_635b1b6c3db28337":
      if(items[1] == "<dev string:x59a>") {
        if(getdvarint(@ "hash_77288abc44d56335", 0) != 0) {
          setDvar(@ "hash_77288abc44d56335", 0);
        } else {
          setDvar(@ "hash_77288abc44d56335", 1);
        }

        break;
      } else if(items[1] == "<dev string:x5a2>") {
        if(getdvarint(@ "hash_f31b754bc4ad44c6", 0) != 0) {
          setDvar(@ "hash_f31b754bc4ad44c6", 0);
        } else {
          setDvar(@ "hash_f31b754bc4ad44c6", 1);
        }

        break;
      } else if(items[1] == "<dev string:x5aa>") {
        if(getdvarint(@ "dontmove", 0) != 0) {
          setDvar(@ "dontmove", 0);
        } else {
          setDvar(@ "dontmove", 1);
        }

        break;
      }

      break;
    default:
      break;
  }
}

function onplayerspawneddevguisetup(player) {
  playername = player.name;
  playernum = undefined;

  if(!isDefined(level.players) || level.players.size <= 0) {
    playernum = 0;
  } else {
    foreach(guy in level.players) {
      if(guy == player) {
        playernum = int(index);
        break;
      }
    }
  }

  if(isDefined(playernum)) {
    player thread setupdevguientries(player, playername, playernum);
  }
}

function setupdevguientries(player, name, num) {
  player thread function_b38a5be1f066c94b(player, name, num);
  player thread function_f2c7f65e88d51c6f(player, name, num);
  player thread function_3cd94be00685c3b(player, name, num);
  player thread function_104d4cbe8bab9fe3(player, name, num);
  player thread function_711d30eca76e8787(player, name, num);
}

function function_104d4cbe8bab9fe3(player, playername, ip1) {
  cmd = "<dev string:x5af>" + playername + "<dev string:x5c9>" + ip1 + "<dev string:x9a>";
  adddebugcommand(cmd);
}

function function_711d30eca76e8787(player, playername, ip1) {
  var_94aedd2c2b88c863 = ["<dev string:x5f9>", "<dev string:x5fe>", "<dev string:x603>", "<dev string:x60f>", "<dev string:x616>"];
  cmd = "<dev string:x61b>" + playername + "<dev string:x640>" + ip1 + "<dev string:x66a>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x61b>" + playername + "<dev string:x670>" + ip1 + "<dev string:x69a>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x61b>" + playername + "<dev string:x6a0>" + ip1 + "<dev string:x6d1>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x61b>" + playername + "<dev string:x6d7>" + ip1 + "<dev string:x703>";
  addentrytodevgui(cmd);
}

function function_b38a5be1f066c94b(player, playername, ip1) {
  flag_wait("<dev string:x709>");
  player thread function_305243d817bfd3e2();
  wait 1;
  var_1b7b9126aecf575c = level.weaponmapdata;
  var_1b7b9126aecf575c = scripts\cp\weapon::eliminatenullweapons(var_1b7b9126aecf575c);
  counter = 0;

  foreach(var_f9c849ee9004aedc in var_1b7b9126aecf575c) {
    cmd = "<dev string:x722>" + var_f9c849ee9004aedc.assetname + "<dev string:x759>" + weaponbasename + "<dev string:x9a>";
    addentrytodevgui(cmd);
    counter++;
  }
}

function function_305243d817bfd3e2() {
  while(true) {
    var_dc8309190668e7b1 = getDvar(@ "hash_a5aae21b5186cfba", "<dev string:x1c>");

    if(var_dc8309190668e7b1 != "<dev string:x1c>") {
      loadoutprimary = var_dc8309190668e7b1;
      loadoutprimaryobject = scripts\cp_mp\weapon::buildweapon(loadoutprimary);
      loadoutprimaryfullname = getcompleteweaponname(loadoutprimaryobject);
      var_986cbcea81712875 = getvalidtakeweapon();
      self takeweapon(var_986cbcea81712875);
      clipcount = weaponclipsize(loadoutprimaryobject);
      ammocount = weaponmaxammo(loadoutprimaryobject);
      self giveweapon(loadoutprimaryobject);
      self setweaponammoclip(loadoutprimaryobject, clipcount);
      scripts\cp\pickups::function_4906c10c3ffdd4ca(loadoutprimaryobject, ammocount);
      self switchtoweaponimmediate(loadoutprimaryobject);
      setDvar(@ "hash_a5aae21b5186cfba", "<dev string:x1c>");
    }

    wait 0.1;
  }
}

function function_f2c7f65e88d51c6f(player, playername, ip1) {
  flag_wait("<dev string:x709>");
  wait 1;
  array = ["<dev string:x776>", "<dev string:x77c>", "<dev string:x781>", "<dev string:x78b>", "<dev string:x790>", "<dev string:x798>", "<dev string:x7a4>", "<dev string:x7b1>", "<dev string:x7ba>", "<dev string:x7c1>"];

  foreach(element in array) {
    cmd = "<dev string:x7c7>" + element + "<dev string:x804>" + element + "<dev string:x827>" + "<dev string:x1bc>" + ip1 + "<dev string:x9a>";
    addentrytodevgui(cmd);
  }
}

function function_3cd94be00685c3b(player, playername, ip1) {
  flag_wait("<dev string:x709>");
  player thread function_8e00410980ce6efb();
  wait 1;
  array = ["<dev string:x82a>", "<dev string:x836>", "<dev string:x848>", "<dev string:x860>", "<dev string:x86d>", "<dev string:x87b>", "<dev string:x88a>", "<dev string:x89b>", "<dev string:x8af>", "<dev string:x8bb>", "<dev string:x8c6>"];

  foreach(element in array) {
    cmd = "<dev string:x8de>" + element + "<dev string:x923>" + index + "<dev string:x1bc>" + ip1 + "<dev string:x9a>";
    addentrytodevgui(cmd);
  }
}

function function_8e00410980ce6efb() {
  weapons = [];

  while(true) {
    var_b3fa9cff9eb43159 = int(getDvar(@ "hash_88751acbcaa56240", -1));

    if(var_b3fa9cff9eb43159 != -1) {
      struct = spawnStruct();

      switch (var_b3fa9cff9eb43159) {
        case 0:
          struct.loadoutprimary = "<dev string:x943>";
          struct.loadoutprimaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:x956>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 1:
          struct.loadoutprimary = "<dev string:x964>";
          struct.loadoutprimaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:x972>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 2:
          struct.loadoutprimary = "<dev string:x982>";
          struct.loadoutprimaryattachments = ["<dev string:x991>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:x996>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 3:
          struct.loadoutprimary = "<dev string:x9a4>";
          struct.loadoutprimaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:x972>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 4:
          struct.loadoutprimary = "<dev string:x9b3>";
          struct.loadoutprimaryattachments = ["<dev string:x9c2>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:x956>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 5:
          struct.loadoutprimary = "<dev string:x9c5>";
          struct.loadoutprimaryattachments = ["<dev string:x9d3>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:x996>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 6:
          struct.loadoutprimary = "<dev string:x9d9>";
          struct.loadoutprimaryattachments = ["<dev string:x9d3>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:x956>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 7:
          struct.loadoutprimary = "<dev string:x9b3>";
          struct.loadoutprimaryattachments = ["<dev string:x9e7>", "<dev string:x9f7>", "<dev string:x9fe>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:xa06>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 8:
          struct.loadoutprimary = "<dev string:xa14>";
          struct.loadoutprimaryattachments = ["<dev string:x9c2>", "<dev string:x991>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:x956>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 9:
          struct.loadoutprimary = "<dev string:xa21>";
          struct.loadoutprimaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:xa2f>";
          struct.loadoutsecondaryattachments = ["<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        case 10:
          struct.loadoutprimary = "<dev string:xa21>";
          struct.loadoutprimaryattachments = ["<dev string:xa3e>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutprimarycamo = "<dev string:x951>";
          struct.loadoutprimaryreticle = "<dev string:x951>";
          struct.loadoutprimaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.loadoutprimarypaintjobid = 0;
          struct.loadoutprimarycosmeticattachment = "<dev string:x951>";
          struct.loadoutsecondary = "<dev string:x956>";
          struct.loadoutsecondaryattachments = ["<dev string:xa3e>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>", "<dev string:x951>"];
          struct.loadoutsecondarycamo = "<dev string:x951>";
          struct.loadoutsecondaryreticle = "<dev string:x951>";
          struct.loadoutsecondaryvariantid = -1;
          self.entnumber = self getentitynumber();
          struct.var_33e425a1f6c8b34d = 0;
          struct.loadoutsecondarycosmeticattachment = "<dev string:x951>";
          break;
        default:
          self iprintln("<dev string:xa47>");
          break;
      }

      struct.loadoutprimaryobject = scripts\cp_mp\weapon::buildweapon(struct.loadoutprimary, struct.loadoutprimaryattachments, struct.loadoutprimarycamo, struct.loadoutprimaryreticle, struct.loadoutprimaryvariantid, self getentitynumber(), self.clientid, struct.loadoutprimarypaintjobid, struct.loadoutprimarycosmeticattachment);
      struct.loadoutprimaryfullname = getcompleteweaponname(struct.loadoutprimaryobject);

      if(struct.loadoutsecondary == "<dev string:x951>") {
        struct.loadoutsecondaryfullname = "<dev string:x951>";
        struct.loadoutsecondaryobject = undefined;
      } else {
        struct.loadoutsecondaryobject = scripts\cp_mp\weapon::buildweapon(struct.loadoutsecondary, struct.loadoutsecondaryattachments, struct.loadoutsecondarycamo, struct.loadoutsecondaryreticle, struct.loadoutsecondaryvariantid, self getentitynumber(), self.clientid, struct.var_33e425a1f6c8b34d, struct.loadoutsecondarycosmeticattachment);
        struct.loadoutsecondaryfullname = getcompleteweaponname(struct.loadoutsecondaryobject);
      }

      self takeallweapons();
      clipcount = weaponclipsize(struct.loadoutprimaryobject);
      ammocount = weaponmaxammo(struct.loadoutprimaryobject);
      self giveweapon(struct.loadoutprimaryobject);
      self setweaponammoclip(struct.loadoutprimaryobject, clipcount);
      self setweaponammostock(struct.loadoutprimaryobject, ammocount);
      clipcount = weaponclipsize(struct.loadoutsecondaryobject);
      ammocount = weaponmaxammo(struct.loadoutsecondaryobject);
      self giveweapon(struct.loadoutsecondaryobject);
      self setweaponammoclip(struct.loadoutsecondaryobject, clipcount);
      self setweaponammostock(struct.loadoutsecondaryobject, ammocount);
      self switchtoweaponimmediate(struct.loadoutprimaryobject);
      setDvar(@ "hash_88751acbcaa56240", -1);
    }

    wait 0.1;
  }
}

function updateminimapsetting() {
  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1);

  if(!isDefined(level.minimapheight)) {
    setdevdvar(@ "scr_minimap_height", "<dev string:xa8b>");
    level.minimapheight = 0;
  }

  minimapheight = getdvarfloat(@ "scr_minimap_height");

  if(minimapheight != level.minimapheight) {
    if(isDefined(level.minimaporigin)) {
      level.minimapplayer unlink();
      level.minimaporigin delete();
      level notify("<dev string:xa8d>");
    }

    if(minimapheight > 0) {
      level.minimapheight = minimapheight;
      players = getEntArray("<dev string:xaa1>", "<dev string:xaa8>");

      if(players.size > 0) {
        player = players[0];
        corners = getEntArray("<dev string:xab2>", "<dev string:xac1>");

        if(corners.size == 2) {
          viewpos = corners[0].origin + corners[1].origin;
          viewpos = (viewpos[0] * 0.5, viewpos[1] * 0.5, viewpos[2] * 0.5);
          maxcorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
          mincorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);

          if(corners[1].origin[0] > corners[0].origin[0]) {
            maxcorner = (corners[1].origin[0], maxcorner[1], maxcorner[2]);
          } else {
            mincorner = (corners[1].origin[0], mincorner[1], mincorner[2]);
          }

          if(corners[1].origin[1] > corners[0].origin[1]) {
            maxcorner = (maxcorner[0], corners[1].origin[1], maxcorner[2]);
          } else {
            mincorner = (mincorner[0], corners[1].origin[1], mincorner[2]);
          }

          viewpostocorner = maxcorner - viewpos;
          viewpos = (viewpos[0], viewpos[1], viewpos[2] + minimapheight);
          origin = spawn("<dev string:xacc>", player.origin);
          northvector = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
          eastvector = (northvector[1], 0 - northvector[0], 0);
          disttotop = vectordot(northvector, viewpostocorner);

          if(disttotop < 0) {
            disttotop = 0 - disttotop;
          }

          disttoside = vectordot(eastvector, viewpostocorner);

          if(disttoside < 0) {
            disttoside = 0 - disttoside;
          }

          if(requiredmapaspectratio > 0) {
            mapaspectratio = disttoside / disttotop;

            if(mapaspectratio < requiredmapaspectratio) {
              incr = requiredmapaspectratio / mapaspectratio;
              disttoside *= incr;
              addvec = vecscale(eastvector, vectordot(eastvector, maxcorner - viewpos) * (incr - 1));
              mincorner -= addvec;
              maxcorner += addvec;
            } else {
              incr = mapaspectratio / requiredmapaspectratio;
              disttotop *= incr;
              addvec = vecscale(northvector, vectordot(northvector, maxcorner - viewpos) * (incr - 1));
              mincorner -= addvec;
              maxcorner += addvec;
            }
          }

          if(player isconsoleplayer()) {
            aspectratioguess = 1.77778;
            angleside = 2 * atan(disttoside * 0.8 / minimapheight);
            angletop = 2 * atan(disttotop * aspectratioguess * 0.8 / minimapheight);
          } else {
            aspectratioguess = 1.33333;
            angleside = 2 * atan(disttoside / minimapheight);
            angletop = 2 * atan(disttotop * aspectratioguess / minimapheight);
          }

          if(angleside > angletop) {
            angle = angleside;
          } else {
            angle = angletop;
          }

          znear = minimapheight - 1000;

          if(znear < 16) {
            znear = 16;
          }

          if(znear > 10000) {
            znear = 10000;
          }

          player playerlinkTo(origin);
          origin.origin = viewpos + (0, 0, -62);
          origin.angles = (90, getnorthyaw(), 0);
          player takeallweapons();
          player _giveweapon("<dev string:xada>");
          devsetminimapdvarsettings(znear, angle);
          level.minimapplayer = player;
          level.minimaporigin = origin;
          thread drawminimapbounds(viewpos, mincorner, maxcorner);
          wait 0.05;
          player setplayerangles(origin.angles);
        } else {
          println("<dev string:xaeb>");
        }

        return;
      }

      setdevdvar(@ "scr_minimap_height", "<dev string:xa8b>");
    }
  }
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

function drawminimapbounds(viewpos, mincorner, maxcorner) {
  level notify("<dev string:xa8d>");
  level endon("<dev string:xa8d>");
  viewheight = viewpos[2] - maxcorner[2];
  north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  diaglen = length(mincorner - maxcorner);
  mincorneroffset = mincorner - viewpos;
  mincorneroffset = vectorNormalize((mincorneroffset[0], mincorneroffset[1], 0));
  mincorner += vecscale(mincorneroffset, diaglen * 1 / 800);
  maxcorneroffset = maxcorner - viewpos;
  maxcorneroffset = vectorNormalize((maxcorneroffset[0], maxcorneroffset[1], 0));
  maxcorner += vecscale(maxcorneroffset, diaglen * 1 / 800);
  diagonal = maxcorner - mincorner;
  side = vecscale(north, vectordot(diagonal, north));
  sidenorth = vecscale(north, abs(vectordot(diagonal, north)));
  corner0 = mincorner;
  corner1 = mincorner + side;
  corner2 = maxcorner;
  corner3 = maxcorner - side;
  toppos = vecscale(mincorner + maxcorner, 0.5) + vecscale(sidenorth, 0.51);
  textscale = diaglen * 0.003;

  while(true) {
    line(corner0, corner1, (0, 1, 0));
    line(corner1, corner2, (0, 1, 0));
    line(corner2, corner3, (0, 1, 0));
    line(corner3, corner0, (0, 1, 0));
    print3d(toppos, "<dev string:xb34>", (1, 1, 1), 1, textscale);
    wait 0.05;
  }
}

function draw_spawner(pos, angles, color, alpha, depthtest) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  up = anglestoup(angles);
  fwd = anglesToForward(angles);
  start = pos + up * 72 * 0.5;
  end = start + fwd * 32;
  draw_small_arrow(start, end, color, alpha, depthtest);
  draw_box(pos, color, angles, [32, 72], alpha, depthtest);
}

function draw_small_arrow(start, end, color, alpha, depthtest) {
  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  angle = vectortoangles(end - start);
  dist = length(end - start);
  forward = anglesToForward(angle);
  forwardfar = forward * dist;
  arrow_size = 5;
  forwardclose = forward * (dist - arrow_size);
  right = anglestoright(angle);
  leftdraw = right * arrow_size * -1;
  rightdraw = right * arrow_size;
  line(start, end, color, alpha, depthtest, 100);
  line(start, start + forwardfar, color, alpha, depthtest, 100);
  line(start + forwardfar, start + forwardclose + rightdraw, color, alpha, depthtest, 100);
  line(start + forwardfar, start + forwardclose + leftdraw, color, alpha, depthtest, 100);
}

function draw_box(pos, color, angles, size, alpha, depthtest) {
  if(!isDefined(size)) {
    width = 32;
    height = 32;
  } else if(!isarray(size)) {
    width = size;
    height = size;
  } else {
    width = size[0];
    height = size[1];
  }

  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);
  start = pos + forward * width * 0.5;
  start += right * width * 0.5;
  points = [];
  points[points.size] = start;
  points[points.size] = points[points.size - 1] + forward * width * -1;
  points[points.size] = points[points.size - 1] + right * width * -1;
  points[points.size] = points[points.size - 1] + forward * width;
  offset = height * up;

  for(i = 0; i < points.size; i++) {
    line(points[i], points[i] + offset, color, alpha, depthtest, 100);

    if(i == points.size - 1) {
      line(points[i], points[0], color, alpha, depthtest, 100);
      line(points[i] + offset, points[0] + offset, color, alpha, depthtest, 100);
      continue;
    }

    line(points[i], points[i + 1], color, alpha, depthtest, 100);
    line(points[i] + offset, points[i + 1] + offset, color, alpha, depthtest, 100);
  }
}

function function_91979fbf5dbf3bea() {
  return getdvarint(@ "hash_bd0ea023a7a593c9", 0) == 1;
}

function function_13e3c70659983189() {
  playerarray = [];

  if(isDefined(level.var_3b3b12cc96932083) && isDefined(level.var_3b3b12cc96932083.ent)) {
    playerarray = array_add(playerarray, level.var_3b3b12cc96932083.ent);
  } else {
    playerarray = level.players;
  }

  return playerarray;
}

function devgiveperks() {
  while(true) {
    if(getDvar(@ "hash_8fcf658de0756ca3") != "<dev string:x1c>") {
      break;
    }

    wait 1;
  }

  perk = getDvar(@ "hash_8fcf658de0756ca3");
  playerarray = function_13e3c70659983189();

  foreach(player in playerarray) {
    player thread giveperk(perk);
  }

  setdevdvar(@ "hash_8fcf658de0756ca3", "<dev string:x1c>");
  thread devgiveperks();
}

function function_38888abb0075b57b(itemref) {
  items = strtok(itemref, "_");
  playertoks = strtok(itemref, "-");
  player = undefined;

  if(playertoks.size > 1) {
    playerint = int(playertoks[1]);
    player = level.players[playerint];
  }
}

function function_c8ce49adbbdfe59b() {
  teams = ["axis", "allies", "team3", "neutral", "dying", "lightweight", "total"];
  y = 70;

  foreach(team in teams) {
    count = 0;
    color = (0, 0, 0);

    if(team == "lightweight") {
      count = getaicount("all", "all", "lightweight");
      color = function_a08c7d9bf42ca575(count, 10, 15);
    } else {
      ai_array = getaiarray();

      if(getdvarint(@ "hash_8beca11d7b55550e")) {
        line_colors["allies"] = (0, 1, 0);
        line_colors["axis"] = (1, 0, 0);
        line_colors["default"] = (0, 1, 1);

        foreach(guy in ai_array) {
          line_color = default_to(line_colors[guy.team], line_colors["<dev string:xb41>"]);
          line(guy.origin, level.player.origin, line_color, 1, 0, 1);
        }
      }

      if(team == "total") {
        count = ai_array.size;
        color = function_a08c7d9bf42ca575(count, 10, 25);
      } else if(team == "dying") {
        alive = scripts\engine\utility::array_removedead_or_dying(ai_array);
        count = ai_array.size - alive.size;
        color = function_a08c7d9bf42ca575(count, 5, 10);
      }
    }

    printtoscreen2d(1000, y, count + "<dev string:xb49>" + team, color, 1.2);

    y += 15;
  }
}

function function_a08c7d9bf42ca575(count, green_count, yellow_count) {
  if(count <= green_count) {
    color = (0, 1, 0);
  } else if(count <= yellow_count) {
    color = (1, 1, 0);
  } else {
    color = (1, 0, 0);
  }

  return color;
}

function function_695edac42cd3e5() {
  var_d23fa40b14295f49 = [];

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }

    if(isDefined(player.reviveent)) {
      var_d23fa40b14295f49[var_d23fa40b14295f49.size] = player.reviveent;
    }

    if(isDefined(player.dogtag)) {
      var_d23fa40b14295f49[var_d23fa40b14295f49.size] = player.dogtag;
    }
  }

  var_24f7cc3775d28df6 = getdvarint(@ "hash_a23e8f787d85f762");

  if(var_24f7cc3775d28df6 <= 0) {
    announcement("Enabling: Toggle Last Stand Tap Use");
    setdvarifuninitialized(@ "hash_a23e8f787d85f762", 1);
    wait 1;
  }

  if(var_d23fa40b14295f49.size > 0) {
    thread function_6eafd30d4e01bd76(1, var_d23fa40b14295f49, 1);
  }
}

function function_6eafd30d4e01bd76(var_21e04f94760cc4a5, var_64bb45003e008dc3, var_af6c2d5e0b9350bb) {
  nearby_ents = undefined;
  dist = 80;

  if(istrue(var_af6c2d5e0b9350bb)) {
    dist = 1000;
  }

  if(isDefined(var_64bb45003e008dc3)) {
    nearby_ents = [];

    foreach(ent in var_64bb45003e008dc3) {
      if(distance(ent.origin, self.origin) < dist) {
        nearby_ents[nearby_ents.size] = ent;
      }
    }
  } else {
    nearby_ents = getentarrayinradius(undefined, undefined, self.origin, 80);
    var_98968ce377323415 = getscriptablearrayinradius(undefined, undefined, self.origin, 80);

    foreach(scriptable_model in var_98968ce377323415) {
      success = function_ddea666bce2423ac(scriptable_model);

      if(success) {
        nearby_ents[nearby_ents.size] = scriptable_model;
      }
    }
  }

  nearby_ents = array_remove(nearby_ents, self);

  if(nearby_ents.size == 0) {
    announcement("No nearby ents to use for Player" + self getentitynumber() + 1);
    return;
  }

  if(istrue(var_af6c2d5e0b9350bb)) {
    closestent = getclosest(self.origin, nearby_ents);
    nearby_ents = [closestent];
    self setplayerangles(vectortoangles(closestent.origin - self.origin));
    name = "";

    if(isDefined(closestent.targetname)) {
      name = ":" + closestent.targetname;
    }

    announcement("P" + self getentitynumber() + 1 + " used e" + closestent getentitynumber() + "" + name);
  } else {
    announcement("Num ents for P" + self getentitynumber() + 1 + ":" + nearby_ents.size);
  }

  duration = 0.05;

  if(isDefined(var_21e04f94760cc4a5)) {
    duration = var_21e04f94760cc4a5;
  }

  i = 0;

  while(i < duration) {
    foreach(nearby_ent in nearby_ents) {
      if(nearby_ent == self) {
        continue;
      }

      if(!isent(nearby_ent)) {
        continue;
      }

      nearby_ent useby(self);
      nearby_ent notify("trigger", self);
    }

    wait 0.05;
    i += 0.05;
  }
}

function function_ddea666bce2423ac(scriptable_model) {
  if(scriptable_model getscriptableisusableonanypart()) {
    foreach(part_name, var_f74189b8adff2e79 in level.scriptable_used_by_part_funcs) {
      if(scriptable_model getscriptablehaspart(part_name)) {
        foreach(var_18d79fb049ced099 in var_f74189b8adff2e79) {
          var_c4a7436e4fbe926a = scriptable_model getlinkedscriptableinstance();
          thread[[var_18d79fb049ced099]](var_c4a7436e4fbe926a, part_name, "usable", self, 1, undefined);
        }

        if(var_f74189b8adff2e79.size > 0) {
          return true;
        }
      }
    }
  }

  return false;
}