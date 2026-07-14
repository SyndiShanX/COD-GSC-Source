/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_27a2ba901cbde562.gsc
*****************************************************/

#using scripts\common\callbacks;
#using scripts\engine\utility;
#namespace cer_achievements;

function autoexec preinit() {
  if(function_af912cb4229d032d()) {
    return;
  }

  if(!isbrgamemode()) {
    callback::add(#"hash_6c71d319dc089c27", &function_be1c93bb6ff1350c);
  }
}

function private function_be1c93bb6ff1350c(params) {
  event = params.event;

  switch (event) {
    case #"hash_44cee0689be43248":
      onelimination(params);
      break;
    case #"hash_1f36538689dd6873":
      onkill(params);
      break;
    case #"on_ai_killed":
      onagentaikilled(params);
      break;
    case #"hash_1715046d02dc7713":
      onkillstreakdestroyed(params);
      break;
    case #"hash_945ff68488ae3b43":
      onkillstreakmultikill(params);
      break;
    case #"hash_b27ed98fe637ac9b":
      ongameendmp(params);
      break;
    case #"hash_cda961d5172beeff":
      onbestplay(params);
      break;
    case #"hash_29b9f03ef472ef0":
      function_acc83973ac132308(params);
      break;
    case #"zm_mq_quest_complete":
      function_53d486949f889206(params);
      break;
    case #"hash_4e0c5e5e46ea8fef":
      function_e65b7a4d7dface3a(params);
      break;
    case #"zm_sq_quest_complete":
      function_bd9618f07a948154(params);
      break;
    case #"hash_338b25337d7e0281":
      function_e67eaf75a14ed844(params);
      break;
    case #"hash_bfeb6496736df3a2":
      function_4446c1e9ebc8a8d5(params);
      break;
    default:
      break;
  }
}

function private ongameendmp(params) {
  winner = params.winner;

  if(!isDefined(winner)) {
    return;
  }

  if(!level.teambased) {
    if(isarray(winner)) {
      foreach(win in winner) {
        if(isPlayer(win)) {
          progress = win function_882575c86bf8f94e("\xbe\x18\xed\xd5_!\xf2eu\xc5\by", "p\xdb#-\xbamd\xb4\xe6K\xdc\x1a", 1);
          win function_85b3320b2263095d("hC\x8a-\x18o\x17\f\xe4\xfb\x95\x1a\xa7~\x1b\xb8\x0f\x891", progress);
        }
      }
    } else if(isPlayer(winner)) {
      progress = winner function_882575c86bf8f94e("\xbe\x18\xed\xd5_!\xf2eu\xc5\by", "p\xdb#-\xbamd\xb4\xe6K\xdc\x1a", 1);
      winner function_85b3320b2263095d("hC\x8a-\x18o\x17\f\xe4\xfb\x95\x1a\xa7~\x1b\xb8\x0f\x891", progress);
    }

    return;
  }

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(isDefined(player.pers["\x03\x94=b"]) && player.pers["\x03\x94=b"] == winner) {
      progress = player function_882575c86bf8f94e("\xbe\x18\xed\xd5_!\xf2eu\xc5\by", "p\xdb#-\xbamd\xb4\xe6K\xdc\x1a", 1);
      player function_85b3320b2263095d("hC\x8a-\x18o\x17\f\xe4\xfb\x95\x1a\xa7~\x1b\xb8\x0f\x891", progress);
    }
  }
}

function private onkillstreakmultikill(params) {
  player = params.player;
  streakname = params.streakname;

  if(!(isDefined(player) && isDefined(streakname))) {
    return;
  }

  if(!isxhash(streakname)) {
    streakname = getxhash(streakname);
  }

  switch (streakname) {
    case #"rcxd":
      player function_85b3320b2263095d("y\xfe,B\\Oy\xda\xa4\f\x8a\x91\xdb\xb7\r", 1);
      break;
    default:
      break;
  }
}

function private onkill(params) {
  player = params.attacker;
  victim = params.victim;
  iskillstreak = params.iskillstreak;

  if(!iskillstreak) {
    if(istrue(player.spykitactive) && distancesquared(player.origin, victim.origin) <= 38750) {
      player function_85b3320b2263095d("\xea/\xbd\xf7\xa4\xa5\b\x0e\xc7\x9dUU6\xe7\x01", 1);
    }
  }

  onelimination(params);
}

function private onelimination(params) {
  player = params.attacker;
  progress = player function_882575c86bf8f94e("\xbe\x18\xed\xd5_!\xf2eu\xc5\by", "_\xa3<\x83\x87\x03Y\xbb\xba", 1);
  player function_85b3320b2263095d("F\xf0\a\\E\x14\xfc\x14\x12\x8a\xc0GS|wF", progress);

  if(isDefined(player.perks) && (isDefined(player.perks["\xf5\xdc\x97@~\xc5J\xddWy\xedb%\xde?\a"]) || isDefined(player.perks["\f\x7fO\x1f(\xf1\xf1\xd2\x8e\xee\xf138e\xe4Cd\x9f\xff"]) || isDefined(player.perks["3\x84\xa9\x91\x86}\x90\ti\xea\xd4\x83\x83\xdb\xb72c\xa7\x98"]))) {
    progress = player function_882575c86bf8f94e("\xbe\x18\xed\xd5_!\xf2eu\xc5\by", "M\xa2|\x8a\xdf\xf2\xca\x85@Q\x9a", 1);
    player function_85b3320b2263095d("\xa0\xe0\xf7kO\xca\xc0-]\x82\x02n\xbd\xb2\x85\xf0\xa0\xf5", progress);
  }
}

function private onbestplay(params) {
  potginfo = params.potginfo;

  if(isPlayer(potginfo.primaryentity)) {
    player = potginfo.primaryentity;
    progress = player function_882575c86bf8f94e("\xbe\x18\xed\xd5_!\xf2eu\xc5\by", "w_\xf4\xf4BG)\x9f\x9e", 1);
    player function_85b3320b2263095d("sp\xf0#$\x9b\x89\xdb\xf9\a\xa2U@H\xc7y", progress);
  }
}

function private function_e67eaf75a14ed844(params) {
  player = params.player;
  player function_85b3320b2263095d("\xf3\xfco\x9c\xda\xb8N?^H\xb8\x99x\x94q\xb0\xf3\xf9\x17\xd9", 1);
}

function private onkillstreakdestroyed(params) {
  player = params.player;
  bundle = level.streakglobals.streakbundles[params.streakname];
  weapon = params.weapon;
  islauncher = isDefined(weapon) && weaponclass(weapon.basename) == "\x03\xb0\xa1\xa9\x04\xac\x88\x82\x88\x18\xb6\xed\xe1\x82";

  if(istrue(bundle.isaerial) && islauncher) {
    progress = player function_882575c86bf8f94e("\xbe\x18\xed\xd5_!\xf2eu\xc5\by", "\xa6g\xbe\xc5#3\xc9~)\x10\x85\xf6I\x92", 1);
    player function_85b3320b2263095d("0m(\xd2\x8e\xfcQ\xe4h\x97\x15d\x8f\x03\xec\xaa\xc1\xa3\xc1ob", progress);
  }
}

function private onagentaikilled(sparams) {
  if(!isPlayer(sparams.eattacker)) {
    return;
  }

  if(!isagent(self)) {
    return;
  }

  player = sparams.eattacker;

  if(level.gamemodebundle.aegamemode == "\xb4\x9a") {
    if(istrue(player.var_10147ee96a4201b2)) {
      progress = player function_882575c86bf8f94e("\xbe\x18\xed\xd5_!\xf2eu\xc5\by", "\xcd\xca\x86\x10Rw\xbf{u\x9fM \x15\x92\xe0\xa5\xcd\xc0\x90\a\x1a", 1);
      player function_85b3320b2263095d("\xa6P8}YK\xe0\x11\xe9\x03\xaej\x7f\x9b\x0f\xedv\f\x10'", progress);
    }

    if(isarray(self.var_f39ed78904c15ea0)) {
      foreach(assistplayer in self.var_f39ed78904c15ea0) {
        if(!isPlayer(assistplayer)) {
          continue;
        }

        if(self.aicategory == "\xdc\x878\x9bq") {
          progress = player function_882575c86bf8f94e("\xbe\x18\xed\xd5_!\xf2eu\xc5\by", "yM\xa6\xe5\xe4\xc9ApQ\xd4\x1c\xe6\xff\xaa[", 1);
          assistplayer function_85b3320b2263095d("\x17\xfd\x14N\x8c\xe4v\x7f\x06K\xbe\x06\x03C\x18\x82p\xeb{", progress);
        }
      }
    }

    if(player utility::ent_flag("gQ\xc4Ec+\f\xbd\xea\x98\xaf\xef\x05\xbc\x0ful\v\x16\xc4")) {
      player function_85b3320b2263095d("\xed\xf5\xf6\xc5e\x1b\xe2&\x1e\xf3v\xee\xafHo\x9d\x17\xd0\x19p\xa9\x80\xf8", 1);
    }
  }
}

function private function_acc83973ac132308(sparams) {
  if(!isPlayer(self)) {
    return;
  }

  if(sparams.str_ranking == "\x87") {
    function_66cc41b850d5b65c("rI 8\x12v\xa7\x0e\x1e\x96\x0ff\xe5\x8c~", 1);
  }
}

function private function_53d486949f889206(sparams) {
  foreach(player in level.players) {
    if(!isPlayer(player)) {
      continue;
    }

    if(sparams.questname == #"zm_t10_garnet_mq") {
      player function_66cc41b850d5b65c("\xf7\xe3\x96=+\x92wg[\xdf\x15H\xbe\xbf\xb3]d\xa5\x06\x0e\xd8\x947iE", 1);
      continue;
    }

    if(sparams.questname == #"hash_35d9cda6e2eb2d59") {
      player function_66cc41b850d5b65c("o\x89K\xa12\x84\x04c\xfc\xc3\xffGJ\xc3\xca\f\xe9P6\xdf|\xb6\x03\\<", 1);
    }
  }
}

function private function_e65b7a4d7dface3a(sparams) {
  if(!isPlayer(self)) {
    return;
  }

  if(sparams.ee_name == #"hash_3357a1eda4d7becf") {
    function_66cc41b850d5b65c("\xe8\x890\xbe\xf4m\xd7luc\x96\xe6\xc2Ny\xf5\xc8V\x1bK\xceC\xa3", 1);
  }
}

function private function_bd9618f07a948154(sparams) {
  foreach(player in level.players) {
    if(!isPlayer(player)) {
      continue;
    }

    if(sparams.questname == #"hash_fc31260f02e71eb8") {
      player function_66cc41b850d5b65c("\xe32\x89{FN\xca\x93]\a\x8f'\xeb\b\x1dv\xa2\xf5\x15\x9a\xe0\x8b", 1);
    }
  }
}

function private function_66cc41b850d5b65c(achievementname, count) {
  self function_85b3320b2263095d(achievementname, count);
  println("<dev string:x24>" + achievementname + "<dev string:x34>");
}

function private function_4446c1e9ebc8a8d5(sparams) {
  player = level.player;
  progress = player function_f844a76caeb28ac7("x\xd2:\x13\xa1*3\xb4\x1a\xf1\xc0a\x1a\x19&F\xe8\xb5\tt^\x9b\xd0\xbc\xeb\x99\x12\x15\xe6\xc6\xdc\x13", 1);
  player function_85b3320b2263095d("Tg\nFP<\xd4\xbc\x14u\x82x\xcc1\xd5h", progress);
}

function function_882575c86bf8f94e(datastructname, name, count) {
  currentprogress = 0;

  if(utility::issharedfuncdefined(#"player", #"getplayerdata")) {
    currentprogress = utility::callsharedfunc(#"player", #"getplayerdata", level.progressiongroup, datastructname, name);
    currentprogress += count;
    utility::callsharedfunc(#"player", #"setplayerdata", level.progressiongroup, datastructname, name, currentprogress);
  }

  return currentprogress;
}

function function_f844a76caeb28ac7(name, count) {
  currentprogress = 0;

  if(utility::issharedfuncdefined(#"game", #"getplayerprogression")) {
    currentprogress = utility::callsharedfunc(#"game", #"getplayerprogression", name);
    currentprogress += count;
    utility::callsharedfunc(#"game", #"setplayerprogression", name, currentprogress);
  }

  return currentprogress;
}