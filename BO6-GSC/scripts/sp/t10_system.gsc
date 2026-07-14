/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\t10_system.gsc
**************************************/

#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\game\sp\hints;
#using scripts\sp\analytics;
#using scripts\sp\endmission;
#using scripts\sp\player\perk_manager;
#using scripts\sp\save;
#namespace t10_system;

function private autoexec __init__system__() {
  system::register(#"t10_system", undefined, &pre_main, &post_main);
}

function private pre_main() {}

function private post_main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  setsaveddvar(@ "hash_f961da046fe873ba", 0.5);

  if(isplatformps4() || isplatformxb3()) {
    setsaveddvar(@ "hash_8ab67268537e6632", 4);
    setsaveddvar(@ "hash_895e81503174cc5f", 1);
    setsaveddvar(@ "ai_corpsecount", 10);
    setsaveddvar(@ "hash_f4ac2f7705158af9", 0);
  }

  setDvar(@ "hash_7598045ee90e851d", 0);
  level.player function_138c83b3a0af9d77();
  level.player thread function_6ea70ac01b10a1d5();
  level.player thread function_6a1a17a95774ce40();
  level.friendlyfire["\x17PW\x82\x88\xcb\xc9\x11\x8cq\x90Pw\xb5t\xc1 "] = -400;
  level.friendlyfire["I\x12\xb3%\x16\xe5I\xa4\xaa\x8f%\xd6r\x19\xfd\xa4\xad"] = 500;
  level.var_c6fbb42f0b71b7d1 = "qn\x86\xf8\xa8\xc9\x89\xdfK~BZo\x82Lk\x95\x06\xe1\x8eeh\xe1\xdd$";
  utility::function_a82ea6c863a80d8c(400, 400, 45);
  callback::add(#"hash_884a4bf94d95eb67", &function_aa2d5c6d891f6183);
  callback::add(#"hash_75eeb7e76060544f", &function_7e821056a8dfa3d6);

  thread function_d014182830707273();
}

function private function_138c83b3a0af9d77() {
  assert(isPlayer(self));

  if(isloadingsavegame()) {
    return;
  }

  player = self;
  levelindex = endmission::getlevelindex();

  if(isDefined(levelindex)) {
    currentstats = player function_5e24997fe469d2d2(0);
    currentstats = function_2f132773cd22bce4(currentstats, "\x96\x99\x05\x0en\x80\xc0", 1);
    writestats = currentstats;
    missiondata = save::function_37f09add1d5aaa86(#"persistent");
    completed = endmission::function_cb4c673529c8614f();

    if(isDefined(missiondata) && !istrue(completed)) {
      if(isDefined(missiondata.startstats) && world.mostrecentmission === levelindex) {
        writestats = missiondata.startstats;
        writestats = function_2f132773cd22bce4(writestats, "\x17\xad\v\xde8");
      } else {
        missiondata.startstats = currentstats;
      }
    }

    player function_5e24997fe469d2d2(1, writestats);
    world.mostrecentmission = levelindex;
  }
}

function private function_2f132773cd22bce4(stats, suffix, updateprofile) {
  money = stats["\xa5\x0f\xd0rL\x81\xff\x9e]\xefP\xae\xca\xe0"] ?? 0;
  pendingmoney = stats["\xd0j\x86A\xfdP\xe6WAz\xae\xa5y'v_\x94\xbe\xe1\xfc\xe5"] ?? 0;

  if(money < 0) {
    analytics::analytics_event_upload("\xdfrrMT0\x90\xe5\xc0\x03@\x01\xb3\x9a\xf3\xee\x9d\x89\x06" + suffix, money);
    money = 5000;
  }

  if(pendingmoney < 0) {
    analytics::analytics_event_upload("/\r\x1e\"\xcfm0\xf8}ot\xe9\xca\xd8(>\x81\xb4T\xb1`?\xa9\xf1\xf6\x11" + suffix, pendingmoney);
    pendingmoney = 5000;
  }

  statmoney = int(clamp(money, 0, 30000));
  var_7091aca02786200b = int(clamp(pendingmoney, 0, 30000));

  if(statmoney != money) {
    analytics::analytics_event_upload("o\x05w\xce\x9d\xcb\xb2 Z\xeb\xe7\x14V\x7f{h\x15\xb8v\x1a\x9a8\xb2\xf2" + suffix, money);
  }

  if(var_7091aca02786200b != pendingmoney) {
    analytics::analytics_event_upload("\xc6\xea\xc9\x93\xca\xdcc\x97\xebf-\xe1\xf5\xe0\xb2n\x19in\xce\xd4\xdbn+y\xeb\xe6\xe8\xc2\xe8\xfa" + suffix, pendingmoney);
  }

  stats["\xa5\x0f\xd0rL\x81\xff\x9e]\xefP\xae\xca\xe0"] = statmoney;
  stats["\xd0j\x86A\xfdP\xe6WAz\xae\xa5y'v_\x94\xbe\xe1\xfc\xe5"] = var_7091aca02786200b;

  if(istrue(updateprofile)) {
    level.player setplayerprogression("-\xb8\xd7\x99\x19\xcd\xa6\x14", "\xa2\xe9 \xb2\x97", stats["\xa5\x0f\xd0rL\x81\xff\x9e]\xefP\xae\xca\xe0"] ?? 0);
    level.player setplayerprogression("|\x96\x89\xb0\f\x15\vCY\x0f/\xee\xb0\xf3\x15", "\xa2\xe9 \xb2\x97", stats["\xd0j\x86A\xfdP\xe6WAz\xae\xa5y'v_\x94\xbe\xe1\xfc\xe5"] ?? 0);
  }

  return stats;
}

function private function_6ea70ac01b10a1d5() {
  self notify("E\xa4\v\xa6{{\xd5\x88\xffK\xce ENPQ");
  self endon("E\xa4\v\xa6{{\xd5\x88\xffK\xce ENPQ");
  assert(isPlayer(self));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  acquiredbefore = self getplayerprogression("\xec\xc1\xf9\xdf\x1eg\xe4>k>\xb3\xf7\\\n7\x9f", "\xa2\xe9 \xb2\x97");
  foundtakedown = self getplayerprogression("y\x01\xf6T*\xa4\xafRKr\x06\xe5(\x8e!|\x9b\x1a");

  if(acquiredbefore && foundtakedown) {
    return;
  }

  while(true) {
    self waittill("L\xf3NF\x8a{\xcf\xa3^", name, item);

    switch (level.loot.types[name].type) {
      case #"hash_76f2aca395298035":
        resource = level.loot.types[name].ammoname;

        if(!isDefined(resource)) {
          continue;
        }

        acquiredbefore = self getplayerprogression("\xec\xc1\xf9\xdf\x1eg\xe4>k>\xb3\xf7\\\n7\x9f", resource);

        if(acquiredbefore == 0) {
          self setplayerprogression("\xec\xc1\xf9\xdf\x1eg\xe4>k>\xb3\xf7\\\n7\x9f", resource, 1);
          utility::delaythread(3, &hints::function_5a014227dcf6b296, "\xeb\xc0S\xaa\x1b\xd2K\xe0QK)", &"hash_2cbe2d452ee0879e", 5);

          if(acquiredbefore && foundtakedown) {
            return;
          }
        }

        break;
      case #"hash_ebd4134d62d3b15c":
        foundtakedown = self getplayerprogression("y\x01\xf6T*\xa4\xafRKr\x06\xe5(\x8e!|\x9b\x1a");

        if(foundtakedown == 0) {
          self setplayerprogression("y\x01\xf6T*\xa4\xafRKr\x06\xe5(\x8e!|\x9b\x1a", 1);
          utility::delaythread(3, &hints::function_5a014227dcf6b296, "7\x05\xcb{\aC\x84LO", &"hash_5bb2661dfa00cfd3", 5);

          if(acquiredbefore && foundtakedown) {
            return;
          }
        }

        break;
      default:
        continue;
    }
  }
}

function private function_6a1a17a95774ce40() {
  self notify(".~O\xcb[\xd3S@\xf1\xa4.\x10,\x1bOw");
  self endon(".~O\xcb[\xd3S@\xf1\xa4.\x10,\x1bOw");
  assert(isPlayer(self));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    self waittill("\x1d\x95S\xfd\xf0\xa8", newweapon, oldweapon);

    if(!isweapon(newweapon)) {
      continue;
    }

    if(istrue(newweapon.reloaddisabled) && !istrue(world.var_eb4a37e4697cc8ff[newweapon.basename])) {
      world.var_eb4a37e4697cc8ff[newweapon.basename] = 1;
      utility::delaythread(2, &hints::function_5a014227dcf6b296, "5_\x03N\x9a\"\xb5\xf5\xd5\xa6\x02B\x8f\x88\xfcU\xc4\x0f\xf5\x1f", &"hash_7c7a0f61187eb8db", 5);
    }
  }
}

function function_d0e0fdaa4eb58061() {
  level.player setplayerprogression("<dev string:x24>", "<dev string:x38>", 0);
  level.player setplayerprogression("<dev string:x24>", "<dev string:x41>", 0);
  level.player setplayerprogression("<dev string:x24>", "<dev string:x4a>", 0);
  level.player setplayerprogression("<dev string:x56>", 0);
  level.player thread function_6ea70ac01b10a1d5();
}

function private function_d014182830707273() {
  while(true) {
    if(getdvarint(@ "hash_ddef8331337d5977", 0)) {
      level.player function_5e24997fe469d2d2(1, []);
      level.player perk_manager::function_4f77d4159192c245();
      level.player thread perk_manager::player_init();
    }

    waitframe();
  }
}

function private function_b8d83cbebf774a4d() {
  result = [];
  result[result.size] = ["-\xb8\xd7\x99\x19\xcd\xa6\x14", "\xbeH\xb4\x14\x01"];
  result[result.size] = ["-\xb8\xd7\x99\x19\xcd\xa6\x14", "\xa2\xe9 \xb2\x97"];
  result[result.size] = ["-\xb8\xd7\x99\x19\xcd\xa6\x14", "wy\x9b\xf6\x95\xc3\x1eo"];
  result[result.size] = ["|\x96\x89\xb0\f\x15\vCY\x0f/\xee\xb0\xf3\x15", "\xbeH\xb4\x14\x01"];
  result[result.size] = ["|\x96\x89\xb0\f\x15\vCY\x0f/\xee\xb0\xf3\x15", "\xa2\xe9 \xb2\x97"];
  result[result.size] = ["|\x96\x89\xb0\f\x15\vCY\x0f/\xee\xb0\xf3\x15", "wy\x9b\xf6\x95\xc3\x1eo"];
  result[result.size] = ["\xec\xc1\xf9\xdf\x1eg\xe4>k>\xb3\xf7\\\n7\x9f", "\xbeH\xb4\x14\x01"];
  result[result.size] = ["\xec\xc1\xf9\xdf\x1eg\xe4>k>\xb3\xf7\\\n7\x9f", "\xa2\xe9 \xb2\x97"];
  result[result.size] = ["\xec\xc1\xf9\xdf\x1eg\xe4>k>\xb3\xf7\\\n7\x9f", "wy\x9b\xf6\x95\xc3\x1eo"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\xf4\x8cV\xbb\x13\x1d\x12\x10\xde<\xb5\x10"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\x18 \xf9\v\x05`\x965\xb3\xcbsX\x8d\xd4\xe5\xd1"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "!\xbd,\xb2\x1c\x93\xf9~}\xf6\x96\x94"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\xe2\x14\xc2\x92\x01\xdbo\xe9s6,\xd4\xfb\x02\xc3"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\xfd(\xff\xf4\x19\x15Wn_Pt_\xc2\xca\xc6au"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "t\xdd\x1f\x03\x95\xfd\x91\xba[xA\x95S\x99\r\xd4v\x9b\x98"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\x9f\x12\xc2f\xffV\xc5\x7f\xdb\xc0\xf3\xc2\xf5o\xa7\xa41"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "+\x81^qv\x17Z\b\x8dJ\\`"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\x7f3\xae\xd0\xf5\xc1\xa0j\x86\x85}\xb6\v\xde\t"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "&\x10\x8a\xc9l\xa0-h\x87\xa8>]\xf9\xb1\x94"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "g9\x8e\x17U\x8eS\xb6\x91\xee^\x97"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "|\x8e \xba\xa6}\b\x9bg`\xf8\xe6"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "R\x18\xe0\xed\xbc\xee<P\xf3\x9d\x93\x1f\xce\xf4"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "Ao\xd1Q\xd5\xbdP\x0f\x9d"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "i\xab\x97\xb1\x1fa\x05\x81\xc2a\x0e[\xe3"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\xfc\xc7\x7fM\x92\x03nn\xc9#\x10\x93}\x0e"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\xbeE\x9a\x8f\xd3M\xf8\x0e\xff\xe3\xe2j"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\aJKox\t\xd5\xfa\xde6\xe4\x8c)\x16P"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "F\xb4|q\x1d\xc0I4 f\xf2M\xb5$b"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "u\x81\v\x9b?^pCX\xd4}\xe6"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\xceQ\x1a\x06\x8e\xa4\xf8\xa9\\z\x8b\x02\\T"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "V\\W\x96\x0e\xad\xac\xe6\x1d\n\xc89V\xdc\xc2\x8dK\x9b\x95"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\xdb\xb1\x1fji\xb0+\xfb\ntsCec"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "Nj*\x1d\xb1\x91\x98h'[\x80\xe8I"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "*\x98s\x03&s\xbe\x1b\xd0'a\xe00rW\xb6\xf6\xcaH:A"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "bX\xabt?\xf4\x93+R7\x14K4\xce5\x9bM"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\x0f}\x91\x8d\xbd\xc3\xc1c\xe1:\xd5uE2\xc4J."];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "C=\xcfRsX4\x97v\xd1l\"y"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\x8c\xa3\xce\xc6A\xfb\xc5\xa2^g\x19\x83\xd6\xf7\x82\b\x88"];
  result[result.size] = ["\x1d\x14\x17\xfdQ\xbb@\xf0\\'", "\x06\xd9z|\xad\x04Q}\xb4\x96H\xce,\xd3\x17-:j\xc2HX\xc5"];
  result[result.size] = ["\xc5\xa4n\xfaO\xbf\x17\x96", 64];
  result[result.size] = ["\xcb\x03a\x9d\xe4E\xed\x9fC\xe1", 32];
  result[result.size] = ["j#%\xda?\xc3\x824Z\xf5\x1a", "\xcc2c\xea\xc1k\f,\xc0\xc81\xc3\x1d"];
  result[result.size] = ["j#%\xda?\xc3\x824Z\xf5\x1a", "\xdb\xc1\xbf\xc7\x1d\xda5\b\x8e\xa0`\x8d\xfe"];
  result[result.size] = ["j#%\xda?\xc3\x824Z\xf5\x1a", "px\xd2z\xe4\x1b\xc7\xc5\xd9\x94\x0f"];
  result[result.size] = ["j#%\xda?\xc3\x824Z\xf5\x1a", "\xdct\v\x8e\xd2\xb7\xcd)Y7{\xba9\xb1V"];
  result[result.size] = "\xef`.\xdfRvy\xd7O-\xbd\x16\xfcN\xe7\x9c,\xe1\x9e\xac";
  return result;
}

function function_5e24997fe469d2d2(writing, stats) {
  assert(isPlayer(self));
  player = self;

  if(!isDefined(stats)) {
    stats = [];
  }

  entries = function_b8d83cbebf774a4d();

  foreach(entry in entries) {
    if(!istrue(writing)) {
      if(isstring(entry)) {
        stats[entry] = player getplayerprogression(entry);
      } else if(isint(entry[1])) {
        for(i = 0; i < entry[1]; i++) {
          stats[entry[0] + "w" + i] = player getplayerprogression(entry[0], i);
        }
      } else {
        stats[entry[0] + "w" + entry[1]] = player getplayerprogression(entry[0], entry[1]);
      }

      continue;
    }

    if(isstring(entry)) {
      player setplayerprogression(entry, stats[entry] ?? 0);
      continue;
    }

    if(isint(entry[1])) {
      for(i = 0; i < entry[1]; i++) {
        player setplayerprogression(entry[0], i, stats[entry[0] + "w" + i] ?? 0);
      }

      continue;
    }

    player setplayerprogression(entry[0], entry[1], stats[entry[0] + "w" + entry[1]] ?? 0);
  }

  foreach(value in stats) {
    if(value == 0) {
      stats[key] = undefined;
    }
  }

  return stats;
}

function private function_aa2d5c6d891f6183(params) {
  wait 0.75;

  if(!self isonladder()) {
    return;
  }

  var_ec00eef61a7c48c3 = getgroundposition(self.origin, 4);
  beginnodes = getnodesinradius(var_ec00eef61a7c48c3, 32, 0, 36, "\x90\xcav-7");
  self.var_72a5587b00acf13f = [];

  foreach(beginnode in beginnodes) {
    if(beginnode.animscript == "4\x83\xc03O\xc0\\\x0f\x98") {
      self.var_72a5587b00acf13f[self.var_72a5587b00acf13f.size] = beginnode;
      function_8090ec4af7d2477e(beginnode, 0);
    }
  }
}

function private function_7e821056a8dfa3d6(params) {
  if(isDefined(self.var_72a5587b00acf13f)) {
    foreach(beginnode in self.var_72a5587b00acf13f) {
      function_8090ec4af7d2477e(beginnode, 1);
    }
  }

  self.var_72a5587b00acf13f = undefined;
}