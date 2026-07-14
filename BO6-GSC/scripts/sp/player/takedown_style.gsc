/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\takedown_style.gsc
************************************************/

#using script_53f4e6352b0b2425;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\engine\utility;
#using scripts\sp\loot;
#namespace takedown;

function private autoexec __init__system__() {
  system::register(#"takedown_style", #"takedown", &function_968cd923f9dd3a57, &function_e505d3dc375e5920);
}

function function_4f6119092d831f64(styleoverride, var_7ec49713b63dd8f0, additionalstylenames) {
  assert(isPlayer(self));
  player = self;
  assert(isDefined(player.takedown));
  settings = player function_76a958b272c96f07();
  styleindex = settings[0];
  stylerank = settings[1];

  if(isDefined(styleoverride)) {
    foreach(style in level.takedowns.styles) {
      if(style.name == styleoverride) {
        styleindex = index;
        stylerank = 1;
      }
    }
  }

  player function_f8a86d6d1b4d10ae(styleindex, stylerank, var_7ec49713b63dd8f0);

  if(isDefined(additionalstylenames)) {
    if(!isarray(additionalstylenames) && isstring(additionalstylenames)) {
      additionalstylenames = [additionalstylenames];
    }

    level.takedowns.additionalstylenames = additionalstylenames;

    foreach(additionalstylename in additionalstylenames) {
      additionalstyle = getscriptbundle("y\xc8\x0e\x9aO/\x9ca\x11\xe4=C^&" + additionalstylename);

      if(isDefined(additionalstyle.takedown_list)) {
        foreach(takedownref in additionalstyle.takedown_list) {
          refhash = getxhashasset("s'\xf9\xd0J\x1e\x14u\xe3" + takedownref.bundle);

          if(isDefined(refhash)) {
            function_3e1614e2e7c65f95(level.takedowns.takedowns[refhash]);
          }
        }
      }
    }
  }
}

function private function_968cd923f9dd3a57() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  assert(isDefined(level.takedowns));

  if(!isDefined(level.takedowns.style)) {
    level.takedowns.styles = [];
    function_5cbaf67cffe2959a();
    level.player thread function_4f6119092d831f64();
  }

  thread init_debug();
}

function private function_e505d3dc375e5920() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  level callback::add(")\x9cH\x8aD\xfb\xad\xe0\xe2^\xda\xc0", &function_e5573880247eeaf3);

  if(isDefined(level.loot)) {
    level.loot.var_2d59a69eef0ef553 = &loot_melee_style;
    level.loot.var_e21c95af51c7bd6e = &function_10c6bd67edf898a3;
  }
}

function private loot_melee_style(name) {
  itement = self;
  assert(isarray(level.loot.types));
  item = level.loot.types[name];

  if(isDefined(item)) {
    if(isDefined(item.takedownstyle)) {
      foreach(style in level.takedowns.styles) {
        if(style.name == item.takedownstyle) {
          level.player thread loot_melee_style_present(style.var_ffa607b618ddb730, style.pickupgesture);
          break;
        }
      }

      level.player thread function_c03183a447d50546(item.takedownstyle, self.origin, self.angles);
    }
  }
}

function private function_10c6bd67edf898a3(name) {
  itement = self;
  assert(isarray(level.loot.types));
  item = level.loot.types[name];

  if(!(isDefined(item.takedownstyle) && isDefined(level.takedowns.styles))) {
    return true;
  }

  curstyleindex = level.player.takedownstyleactive ?? 0;

  foreach(style in level.takedowns.styles) {
    if(style.name == item.takedownstyle) {
      return (styleindex == curstyleindex);
    }
  }

  return false;
}

function private loot_melee_style_present(model, gesture) {
  assert(isPlayer(self));
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  curweapon = player getcurrentweapon();

  if(!isDefined(curweapon) || curweapon.basename == "\r+x5" || weapon::isakimbo(curweapon) || weaponisboltaction(curweapon)) {
    return;
  }

  player val::set_array("|\x0f\xc1TP\xac\x04\x81T\xca\xc8_c{1Y\x80\xcbTE /\tf", ["\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", "\xc1!\x88V\t\"DW\xfa\xac|\x1d\\", "\xc9\xca\x1boX\x8c", "`\x16\xae\xa2\xe4t\x187\xe7", "\xe1P+\x1a \xe4\xd7-\xeel]", "\xf7~{\xb1\x14", "K\x80\xde\x10\xf9l\xa7u\xe0\xb3\x18\xd5\xe8\xd2\x83e\xfa(\xdd\xe9\xfe\xc3\xf4", "{\xe0U\x19:$\x9d\\RI\x9e\xb5\xea\x7fs\x81^t\x84\xba\x1ff.:", "\xaf\xd7\xe5h\xeb+", "mV\x8d+e", "\xdfv\xca\x10\xffSH\xd00S#\x9d\x12;7\x17C'\xbb", "\xde\xfe\xb2", "\x9ct\n\x94\t\x10", "\xbb\xca,8\xdbn\xf5\x9b\xdd-\x8ec\xd0\xd7c\xb1\x96\a", "/Z\xf4]&\x16\xc1\x9b7\x9d\x1a\xdb\xd9\x10\x81\x84", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a", "\xe7\x1aM\x85+z\x1b\x89\x0fU9", "6\xb5g\x16\xa9\xc9\xab\xc7/\x12", "\xe4\xf1G"], 0);
  player function_5badeeedb906c17c(model, gesture);
  player val::reset_all("|\x0f\xc1TP\xac\x04\x81T\xca\xc8_c{1Y\x80\xcbTE /\tf");
}

function private function_5badeeedb906c17c(model, gesture) {
  player = self;
  loopstart = player getgesturestarttime(gesture, "\xd0\xce\x88\x9e");
  gesturelength = player getgestureanimlength(gesture);
  player forceplaygestureviewmodel(gesture, undefined, 0.2);
  player utility::waittill_notify_or_timeout("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2", loopstart);
  weapon_model = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", level.player.origin);
  weapon_model setModel(model);
  weapon_model notsolid();
  weapon_model linktoplayerview(level.player, "s\xbc|\xb0\xec\xbe\xe6\x7f\xff\x84\xb0\x82R\xae\x8e]xC", (0, 0, 0), (0, 0, 0), 1, "\r+x5");
  weapon_model dontinterpolate();
  player utility::waittill_notify_or_timeout("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2", gesturelength - loopstart - 0.75);
  weapon_model delete();
}

function private function_c03183a447d50546(stylename, lootorigin, lootangles) {
  assert(isPlayer(self));
  player = self;
  prevstyleindex = player.takedownstyleactive ?? 0;
  prevlootname = undefined;

  foreach(styleindex, style in level.takedowns.styles) {
    if(prevstyleindex == styleindex) {
      foreach(item in level.loot.types) {
        if(item.takedownstyle === style.name) {
          prevlootname = name;
          break;
        }
      }

      break;
    }
  }

  foreach(styleindex, style in level.takedowns.styles) {
    if(style.name == stylename) {
      if(styleindex == prevstyleindex) {
        return;
      }

      player.takedownstyleactive = styleindex;
      player thread function_4f6119092d831f64(style.name, undefined, level.takedowns.additionalstylenames);

      if(isDefined(prevlootname)) {
        playerviewangles = player getplayerangles();
        lootorigin = (5, 5, 0);
        lootorigin = rotatevector(lootorigin, playerviewangles) + player getEye() + (0, 0, -20);
        groundposition = getgroundposition(lootorigin, 1, 100);
        groundz = max(groundposition[2] + 5, lootorigin[2]);
        lootorigin = (lootorigin[0], lootorigin[1], groundz);
        lootangles = combineangles(playerviewangles, (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-10, 0)));
        loot::spawnlootitem(prevlootname, lootorigin, lootangles, 1, 1, 0, 1);
      }

      return;
    }
  }

  iprintlnbold("<dev string:x24>" + stylename);
}

function function_8a4e4c7b88eefbd2(stylename) {
  result = [];
  takedown_style = getscriptbundle("y\xc8\x0e\x9aO/\x9ca\x11\xe4=C^&" + stylename);

  if(isDefined(takedown_style.takedown_list)) {
    foreach(takedownref in takedown_style.takedown_list) {
      refhash = getxhashasset("s'\xf9\xd0J\x1e\x14u\xe3" + takedownref.bundle);

      foreach(takedown in level.takedowns.takedowns) {
        if(takedown.name == refhash) {
          result[result.size] = takedown;
        }
      }
    }
  }

  return result;
}

function private function_5cbaf67cffe2959a() {
  assert(isDefined(level.takedowns.styles));
  gamemodebundle = getgamemodescriptbundle();

  if(isDefined(gamemodebundle.takedownstylelist)) {
    takedownstylelist = getscriptbundle("RFUz\x99\xbf_\xc1\x06\xc8\x8c\x05\x8d\b\x9d\x1e\xda\x01" + gamemodebundle.takedownstylelist);

    foreach(stylestruct in takedownstylelist.styles) {
      style = getscriptbundle("y\xc8\x0e\x9aO/\x9ca\x11\xe4=C^&" + stylestruct.style);

      if(!isDefined(style)) {
        continue;
      }

      stylestored = spawnStruct();
      stylestored.name = stylestruct.style;
      stylestored.asset = getxhashasset("y\xc8\x0e\x9aO/\x9ca\x11\xe4=C^&" + stylestruct.style);
      stylestored.perks = [];
      stylestored.powerups = [];
      stylestored.takedowns = [];
      stylestored.var_ffa607b618ddb730 = style.var_ffa607b618ddb730;
      stylestored.pickupgesture = style.pickupgesture;
      stylestored.transientsoundbank = style.transientsoundbank;

      if(isDefined(style.ranks)) {
        rankindex = 1;

        foreach(rank in style.ranks) {
          stylestored.perks[rankindex] = strtok(rank.perks ?? "", "\xc8x");
          stylestored.powerups[rankindex] = strtok(rank.powerups ?? "", "\xc8x");
          rankindex++;
        }
      }

      stylestored.takedowns = function_8a4e4c7b88eefbd2(stylestruct.style);
      level.takedowns.styles[level.takedowns.styles.size] = stylestored;
    }
  }
}

function private function_76a958b272c96f07() {
  assert(isPlayer(self));
  player = self;
  styleindex = 0;
  stylerank = 1;

  if(isDefined(level.takedowns.styles) && level.takedowns.styles.size > 0) {
    takedownstyleactive = player.takedownstyleactive ?? 0;
    styleindex = int(clamp(takedownstyleactive, 0, level.takedowns.styles.size - 1));
    stylerank = 1;
  }

  return [styleindex, stylerank];
}

function private function_3e1614e2e7c65f95(takedown) {
  player = self;

  if(!isDefined(takedown)) {
    return;
  }

  assert(isPlayer(player));
  assert(isDefined(player.takedown));
  assert(isarray(player.takedown.takedownspossible));
  player.takedown.takedownspossible[player.takedown.takedownspossible.size] = takedown;

  if(isarray(takedown.victimteams)) {
    foreach(team in takedown.victimteams) {
      if(!arraycontains(player.takedown.teamspossible, team)) {
        player.takedown.teamspossible[player.takedown.teamspossible.size] = team;
      }
    }
  }
}

function private function_f8a86d6d1b4d10ae(styleindexes, styleranks, var_7ec49713b63dd8f0) {
  assert(isPlayer(self));
  player = self;

  if(!(isDefined(styleindexes) && isDefined(styleranks))) {
    assertmsg("<dev string:x4f>");
  }

  if(!isarray(styleindexes)) {
    styleindexes = [styleindexes];
  }

  if(!isarray(styleranks)) {
    styleranks = [styleranks];
  }

  if(isDefined(var_7ec49713b63dd8f0) && !isarray(var_7ec49713b63dd8f0)) {
    var_7ec49713b63dd8f0 = [var_7ec49713b63dd8f0];
  }

  if(isDefined(player.takedown.perks)) {
    foreach(perkname in player.takedown.perks) {
      player unsetperk(perkname, 1);
    }
  }

  if(isDefined(level.takedowns.var_b2763d1621bb78b)) {
    foreach(bank in level.takedowns.var_b2763d1621bb78b) {
      thread snd::transient_unload(bank);
    }

    level.takedowns.var_b2763d1621bb78b = undefined;
  }

  player.takedown.takedownspossible = [];
  player.takedown.teamspossible = [];
  player.takedown.perks = [];
  player.takedown.powerups = [];
  player.takedown.styleindexes = styleindexes;
  player.takedown.styleranks = styleranks;

  for(i = 0; i < styleindexes.size; i++) {
    styleindex = int(styleindexes[i]);
    stylerank = int(styleranks[i]);

    if(styleindex < 0) {
      continue;
    }

    if(styleindex >= level.takedowns.styles.size) {
      continue;
    }

    style = level.takedowns.styles[styleindex];

    if(isDefined(style.transientsoundbank)) {
      thread snd::transient_load(style.transientsoundbank);

      if(!isDefined(level.takedowns.var_b2763d1621bb78b)) {
        level.takedowns.var_b2763d1621bb78b = [];
      }

      level.takedowns.var_b2763d1621bb78b[level.takedowns.var_b2763d1621bb78b.size] = style.transientsoundbank;
    }

    foreach(takedown in style.takedowns) {
      player function_3e1614e2e7c65f95(takedown);
    }

    if(isDefined(style.perks[stylerank])) {
      player.takedown.perks = utility::array_combine(player.takedown.perks, style.perks[stylerank]);
    }

    if(isDefined(style.powerups[stylerank])) {
      player.takedown.powerups = utility::array_combine(player.takedown.powerups, style.powerups[stylerank]);
    }
  }

  if(isDefined(var_7ec49713b63dd8f0)) {
    foreach(takedownname in var_7ec49713b63dd8f0) {
      if(isstring(takedownname)) {
        takedownname = getxhashasset("s'\xf9\xd0J\x1e\x14u\xe3" + takedownname);
      }

      player function_3e1614e2e7c65f95(level.takedowns.takedowns[takedownname]);
    }
  }

  foreach(perkname in player.takedown.perks) {
    player setperk(perkname, 1);
  }
}

function private function_e5573880247eeaf3(params) {
  if(!isPlayer(params.player)) {
    return;
  }

  player = params.player;

  foreach(powerupname in player.takedown.powerups) {
    player powerups::powerup_activate(powerupname);
  }
}

function private init_debug() {
  setdvarifuninitialized(@ "hash_3c2daa248b141496", "<dev string:x9a>");
  setdvarifuninitialized(@ "hash_838f5eb6193dba31", "<dev string:x9a>");
  wait 1;

  for(i = 0; i < level.takedowns.styles.size; i++) {
    style = level.takedowns.styles[i];
    adddebugcommand("<dev string:x9e>" + style.name + "<dev string:xbb>" + i + 1 + "<dev string:xc0>" + style.name + "<dev string:xe4>");
  }

  adddebugcommand("<dev string:xea>" + i + 1 + "<dev string:x10e>");
  adddebugcommand("<dev string:x134>" + i + 2 + "<dev string:x158>");
  level.player thread function_728c58b1c65fb168();
}

function private function_728c58b1c65fb168() {
  assert(isPlayer(self));
  player = self;
  player notify("<dev string:x17e>");
  player endon("<dev string:x17e>");

  while(true) {
    wait 1;
    debugstyle = getDvar(@ "hash_3c2daa248b141496", "<dev string:x9a>");
    debugstylerank = getDvar(@ "hash_838f5eb6193dba31", "<dev string:x9a>");

    if(debugstyle != (player.takedown.debugstyle ?? "<dev string:x9a>")) {
      debugstylehash = getxhashasset("<dev string:x19c>" + debugstyle);

      for(i = 0; i < level.takedowns.styles.size; i++) {
        if(level.takedowns.styles[i].asset == debugstylehash) {
          player.takedown.debugstyle = debugstyle;
          player function_f8a86d6d1b4d10ae(i, max(1, int(debugstylerank)));
          break;
        }
      }
    }
  }
}

# /