/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\killstreakrules_shared.gsc
**************************************************/

#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#namespace killstreakrules;

function init_shared() {
  val::register(#"killstreaksdisabled", 1, "$self", &function_4a433a3f, "$value");

  if(!isDefined(level.var_ef447a73)) {
    level.var_ef447a73 = {};
    level.killstreakrules = [];
    level.killstreaktype = [];
    level.var_dcc3befb = [];
    level.killstreaks_triggered = [];
    level.matchrecorderkillstreakkills = [];

    if(!isDefined(level.globalkillstreakscalled)) {
      level.globalkillstreakscalled = 0;
    }
  }
}

function function_4a433a3f(value) {
  self function_fe89725a(value);
}

function createrule(rule, maxallowable, maxallowableperteam, var_11c5ecfd, var_5b7d134, var_cc6f8ade) {
  level.killstreakrules[rule] = spawnStruct();
  level.killstreakrules[rule].cur = 0;
  level.killstreakrules[rule].curteam = [];
  level.killstreakrules[rule].max = maxallowable;
  level.killstreakrules[rule].maxperteam = maxallowableperteam;
  level.killstreakrules[rule].var_11c5ecfd = var_11c5ecfd;

  if(isDefined(var_11c5ecfd) && var_11c5ecfd != 0) {
    level.killstreakrules[rule].var_62a7c0b4 = var_5b7d134;
    level.killstreakrules[rule].var_ee52fece = var_cc6f8ade;
    level.killstreakrules[rule].var_8c2bb724 = [];
  }
}

function addkillstreaktorule(killstreak, rule, counttowards, checkagainst, inventoryvariant) {
  if(!isDefined(level.killstreaktype[killstreak])) {
    level.killstreaktype[killstreak] = [];
  }

  assert(isDefined(level.killstreakrules[rule]));

  if(!isDefined(level.killstreaktype[killstreak][rule])) {
    level.killstreaktype[killstreak][rule] = spawnStruct();
  }

  level.killstreaktype[killstreak][rule].counts = counttowards;
  level.killstreaktype[killstreak][rule].checks = checkagainst;

  if(!is_true(inventoryvariant)) {
    addkillstreaktorule("inventory_" + killstreak, rule, counttowards, checkagainst, 1);
  }
}

function killstreakstart(hardpointtype, team, hacked, displayteammessage) {
  assert(isDefined(team), "<dev string:x38>");

  if(self iskillstreakallowed(hardpointtype, team) == 0) {
    return -1;
  }

  assert(isDefined(hardpointtype));

  if(!isDefined(hacked)) {
    hacked = 0;
  }

  if(!isDefined(displayteammessage)) {
    displayteammessage = 1;
  }

  if(displayteammessage == 1) {
    if(!hacked) {
      level thread popups::displaykillstreakteammessagetoall(hardpointtype, self);
    }
  }

  keys = getarraykeys(level.killstreaktype[hardpointtype]);
  killstreak_id = level.globalkillstreakscalled;

  foreach(key in keys) {
    if(!level.killstreaktype[hardpointtype][key].counts) {
      continue;
    }

    assert(isDefined(level.killstreakrules[key]));
    level.killstreakrules[key].cur++;

    if(level.teambased) {
      if(!isDefined(level.killstreakrules[key].curteam[team])) {
        level.killstreakrules[key].curteam[team] = 0;
      }

      level.killstreakrules[key].curteam[team]++;
    }
  }

  level notify(#"killstreak_started", {
    #killstreaktype: hardpointtype, #team: team, #attacker: self
  });

  if(isDefined(level.var_4d062db3)) {
    self[[level.var_4d062db3]]({
      #hardpointtype: hardpointtype
    });
  }

  level.globalkillstreakscalled++;
  var_5c07b36e = [];
  var_5c07b36e[#"caller"] = self getxuid();
  var_5c07b36e[#"spawnid"] = getplayerspawnid(self);
  var_5c07b36e[#"starttime"] = gettime();
  var_5c07b36e[#"type"] = hardpointtype;
  var_5c07b36e[#"endtime"] = 0;
  level.matchrecorderkillstreakkills[killstreak_id] = 0;
  level.scorestreak_kills[killstreak_id] = 0;
  level.killstreaks_triggered[killstreak_id] = var_5c07b36e;

  if(!sessionmodeiscampaigngame()) {
    if(!sessionmodeiszombiesgame()) {
      stats::function_8fb23f94(killstreaks::function_73b4659(hardpointtype), #"uses", 1);
    }

    killstreaks::function_eb52ba7(hardpointtype, team, killstreak_id);
  }

  killstreak_debug_text("<dev string:x54>" + hardpointtype + "<dev string:x6c>" + team + "<dev string:x7b>" + killstreak_id);

  return killstreak_id;
}

function function_2e6ff61a(hardpointtype, killstreak_id, var_8c2bb724) {
  keys = getarraykeys(level.killstreaktype[hardpointtype]);

  foreach(key in keys) {
    if(!level.killstreaktype[hardpointtype][key].counts) {
      continue;
    }

    assert(isDefined(level.killstreakrules[key]));

    if(!isDefined(level.killstreakrules[key].var_11c5ecfd)) {
      continue;
    }

    if(level.killstreakrules[key].var_11c5ecfd == 0) {
      continue;
    }

    level.killstreakrules[key].var_8c2bb724[killstreak_id] = var_8c2bb724;
  }
}

function function_7f69aa48(hardpointtype) {
  keys = getarraykeys(level.killstreaktype[hardpointtype]);

  foreach(key in keys) {
    if(!level.killstreaktype[hardpointtype][key].counts) {
      continue;
    }

    assert(isDefined(level.killstreakrules[key]));

    if(!isDefined(level.killstreakrules[key].var_11c5ecfd) || level.killstreakrules[key].var_11c5ecfd == 0) {
      continue;
    }

    return level.killstreakrules[key].var_11c5ecfd;
  }

  return undefined;
}

function function_feb4595f(hardpointtype, validationfunction) {
  level.var_dcc3befb[hardpointtype] = validationfunction;
  level.var_dcc3befb["inventory_" + hardpointtype] = validationfunction;
}

function recordkillstreakenddirect(eventindex, recordstreakindex, totalkills) {
  player = self;
  player recordkillstreakendevent(eventindex, recordstreakindex, totalkills);
  player.killstreakevents[recordstreakindex] = undefined;
}

function recordkillstreakend(recordstreakindex, totalkills) {
  player = self;

  if(!isPlayer(player)) {
    return;
  }

  if(!isDefined(totalkills)) {
    totalkills = 0;
  }

  if(!isDefined(player.killstreakevents)) {
    player.killstreakevents = associativearray();
  }

  eventindex = player.killstreakevents[recordstreakindex];

  if(isDefined(eventindex)) {
    player recordkillstreakenddirect(eventindex, recordstreakindex, totalkills);
    return;
  }

  player.killstreakevents[recordstreakindex] = totalkills;
}

function killstreakstop(hardpointtype, team, id, var_2921b547 = 1) {
  assert(isDefined(team), "<dev string:x38>");
  assert(isDefined(hardpointtype));

  idstr = "<dev string:x84>";

  if(isDefined(id)) {
    idstr = id;
  }

  killstreak_debug_text("<dev string:x91>" + hardpointtype + "<dev string:x6c>" + team + "<dev string:x7b>" + idstr);

  keys = getarraykeys(level.killstreaktype[hardpointtype]);

  foreach(key in keys) {
    if(!level.killstreaktype[hardpointtype][key].counts) {
      continue;
    }

    assert(isDefined(level.killstreakrules[key]));

    if(isDefined(level.killstreakrules[key].cur)) {
      level.killstreakrules[key].cur--;
    }

    assert(level.killstreakrules[key].cur >= 0);

    if(isDefined(level.killstreakrules[key].var_8c2bb724[id])) {
      level.killstreakrules[key].var_8c2bb724[id] = undefined;
    }

    if(level.teambased) {
      assert(isDefined(team));
      assert(isDefined(level.killstreakrules[key].curteam[team]));

      if(isDefined(team) && isDefined(level.killstreakrules[key].curteam[team])) {
        level.killstreakrules[key].curteam[team]--;
      }

      assert(level.killstreakrules[key].curteam[team] >= 0);
    }
  }

  if(!isDefined(id) || id == -1) {
    killstreak_debug_text("<dev string:xa9>" + hardpointtype);

    if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame() || sessionmodeiszombiesgame()) {
      var_8756d70f = killstreaks::function_cb0594d5();
      function_92d1707f(var_8756d70f, {
        #starttime: 0, #endtime: gettime(), #name: hardpointtype, #team: team
      });
    }

    return;
  }

  level.killstreaks_triggered[id][#"endtime"] = gettime();
  totalkillswiththiskillstreak = level.matchrecorderkillstreakkills[id];

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame() || sessionmodeiszombiesgame()) {
    mpkillstreakuses = {
      #starttime: level.killstreaks_triggered[id][#"starttime"], #endtime: level.killstreaks_triggered[id][#"endtime"], #spawnid: level.killstreaks_triggered[id][#"spawnid"], #name: hardpointtype, #team: team
    };
    var_8756d70f = killstreaks::function_cb0594d5();
    function_92d1707f(var_8756d70f, mpkillstreakuses);
    player = self;

    if(isDefined(player.owner)) {
      player = player.owner;
    }

    player killstreaks::function_fda235cf(hardpointtype, id);
  }

  level.killstreaks_triggered[id] = undefined;
  level.matchrecorderkillstreakkills[id] = undefined;
  level.scorestreak_kills[id] = undefined;

  if(isDefined(level.killstreaks[hardpointtype].menuname)) {
    recordstreakindex = level.killstreakindices[level.killstreaks[hardpointtype].menuname];

    if(isDefined(self) && isDefined(recordstreakindex) && (!isDefined(self.activatingkillstreak) || !self.activatingkillstreak)) {
      entity = self;

      if(isDefined(entity.owner)) {
        entity = entity.owner;
      }

      entity recordkillstreakend(recordstreakindex, totalkillswiththiskillstreak);
    }
  }

  if(var_2921b547 && !killstreaks::function_6bde02cc(hardpointtype)) {
    self function_d9f8f32b(hardpointtype);
  }
}

function function_d9f8f32b(killstreaktype) {
  owner = undefined;

  if(isPlayer(self)) {
    owner = self;
  } else if(isDefined(self.owner)) {
    self.owner.var_9e10e827 = self.var_9e10e827;
    owner = self.owner;
  }

  if(!isDefined(owner)) {
    return;
  }

  var_f66fab06 = owner function_3859ee41(killstreaktype);

  if(level.var_5b544215 === 1 || level.var_5b544215 === 2) {
    if(!isDefined(var_f66fab06)) {
      cooldownendtime = owner.var_8b9b1bba[killstreaktype];

      if(isDefined(cooldownendtime) && cooldownendtime > gettime()) {
        var_f66fab06 = float(cooldownendtime - gettime()) / 1000;
      }
    }

    if(isDefined(var_f66fab06)) {
      owner thread function_9f635a5(var_f66fab06, killstreaktype);
    }
  }
}

function function_9f635a5(cooldowntime = 0, killstreaktype) {
  if(level.var_5b544215 !== 1 && level.var_5b544215 !== 2) {
    return;
  }

  level endon(#"game_ended");
  self endon(#"disconnect");

  if(!isDefined(killstreaktype)) {
    return;
  }

  killstreakslot = self killstreaks::function_a2c375bb(killstreaktype);

  if(!isDefined(killstreakslot) || killstreakslot === 3) {
    return;
  }

  if(util::function_7f7a77ab()) {
    currenttime = float(gettime()) / 1000;

    while(cooldowntime > 0) {
      if(is_true(level.var_e80a117f)) {
        cooldownendtime = int((currenttime + cooldowntime) * 1000);
        self.var_8b9b1bba[killstreaktype] = cooldownendtime;
        self killstreaks::function_b3185041(killstreakslot, cooldownendtime);
      } else {
        cooldowntime -= float(gettime()) / 1000 - currenttime;
      }

      currenttime = float(gettime()) / 1000;
      waitframe(1);
    }
  } else {
    wait cooldowntime;
  }

  if(!isDefined(self)) {
    return;
  }

  if(level.var_5b544215 === 1) {
    if(self function_40451ab0(killstreaktype)) {
      self killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, undefined, killstreaktype, 0, 0);
      self.pers[#"hash_b05d8e95066f3ce"][killstreaktype] = 1;
    } else if(self.pers[#"hash_b05d8e95066f3ce"][killstreaktype] === 1) {
      self.pers[#"hash_b05d8e95066f3ce"][killstreaktype] = 0;
    }

    return;
  }

  if(level.var_5b544215 === 2) {
    weapon = killstreaks::get_killstreak_weapon(killstreaktype);

    if((isDefined(self.pers[#"killstreak_quantity"][weapon]) ? self.pers[#"killstreak_quantity"][weapon] : 0) >= level.scorestreaksmaxstacking) {
      self killstreaks::add_to_notification_queue(level.killstreaks[killstreaktype].menuname, undefined, killstreaktype, 0, 0);
    }
  }
}

function function_40451ab0(killstreaktype) {
  if(isDefined(killstreaktype)) {
    momentum = self.pers[#"momentum"];
    streakcost = self function_dceb5542(level.killstreaks[killstreaktype].itemindex);

    if(isDefined(momentum) && isDefined(streakcost) && momentum >= streakcost) {
      return true;
    }
  }

  return false;
}

function private function_3859ee41(killstreaktype) {
  if(getdvarint(#"hash_1a2e3d781ea7271f", 0)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  if(self.var_9e10e827 === 1) {
    self.var_9e10e827 = undefined;
    return;
  }

  killstreakslot = self killstreaks::function_a2c375bb(killstreaktype);

  if(!isDefined(killstreakslot)) {
    return;
  }

  if(killstreakslot == 3) {
    return;
  }

  killstreakweapon = killstreaks::get_killstreak_weapon(killstreaktype);

  if(level.var_5b544215 === 1) {
    var_f66fab06 = level.var_b29e45cf[killstreakweapon.statname];
  }

  if(level.var_5b544215 === 2) {
    var_f66fab06 = level.var_b3c95dd8[killstreakweapon.statname];
  }

  if(!isDefined(var_f66fab06)) {
    return;
  }

  cooldownendtime = gettime() + int(var_f66fab06 * 1000);
  self.var_8b9b1bba[killstreaktype] = cooldownendtime;
  self killstreaks::function_a831f92c(killstreakslot, var_f66fab06, 1);
  self killstreaks::function_b3185041(killstreakslot, cooldownendtime);
  return var_f66fab06;
}

function iskillstreakallowed(hardpointtype, team, var_1d8339ae, var_91419d5) {
  if(level.var_7aa0d894 === 1) {
    return 0;
  }

  if(self.var_7aa0d894 === 1) {
    return 0;
  }

  if(game.state == # "postgame") {
    return 0;
  }

  assert(isDefined(team), "<dev string:x38>");
  assert(isDefined(hardpointtype));

  if(!is_true(var_91419d5)) {
    if(isDefined(level.var_dcc3befb[hardpointtype])) {
      if(!self[[level.var_dcc3befb[hardpointtype]]]()) {
        return 0;
      }
    }
  }

  isallowed = 1;

  if(!isDefined(level.killstreaktype[hardpointtype])) {
    var_22eba84a = getweapon(hardpointtype);

    if(var_22eba84a.iscarriedkillstreak) {
      return 1;
    }

    if(hardpointtype == # "supplydrop_marker" || hardpointtype == # "inventory_supplydrop_marker") {
      return 1;
    }

    return 0;
  }

  keys = getarraykeys(level.killstreaktype[hardpointtype]);

  foreach(key in keys) {
    if(!isallowed) {
      break;
    }

    if(!level.killstreaktype[hardpointtype][key].checks) {
      continue;
    }

    rule = level.killstreakrules[key];

    if(rule.max != 0) {
      if(rule.cur >= rule.max) {
        killstreak_debug_text("<dev string:xd9>" + key + "<dev string:xe6>");

        isallowed = 0;
        break;
      }
    }

    if(isDefined(rule.var_11c5ecfd) && rule.var_11c5ecfd != 0) {
      playerorigin = self.origin;
      radiussq = sqr(rule.var_11c5ecfd);
      var_9a9cdff6 = 0;
      var_6eeac690 = 0;

      foreach(var_69e8e774 in rule.var_8c2bb724) {
        if(distance2dsquared(playerorigin, var_69e8e774.origin) > radiussq) {
          continue;
        }

        var_9a9cdff6++;

        if(var_9a9cdff6 >= rule.var_62a7c0b4) {
          killstreak_debug_text("<dev string:xf2>" + key + "<dev string:x101>");

          isallowed = 0;
          break;
        }

        if(level.teambased && rule.var_ee52fece != 0) {
          if(self.team == var_69e8e774.team) {
            var_6eeac690++;

            if(var_6eeac690 >= rule.var_ee52fece) {
              isallowed = 0;

              killstreak_debug_text("<dev string:xd9>" + key + "<dev string:x111>");

              break;
            }
          }
        }
      }
    }

    if(level.teambased && rule.maxperteam != 0) {
      if(!isDefined(rule.curteam[team])) {
        rule.curteam[team] = 0;
      }

      if(rule.curteam[team] >= rule.maxperteam) {
        isallowed = 0;

        killstreak_debug_text("<dev string:xd9>" + key + "<dev string:x11e>");

        break;
      }
    }
  }

  if(isDefined(self.laststand) && self.laststand) {
    killstreak_debug_text("<dev string:x127>");

    isallowed = 0;
  }

  if(!is_true(var_1d8339ae)) {
    if(isallowed == 0) {
      if(isDefined(level.var_956bde25)) {
        self[[level.var_956bde25]](hardpointtype, team, 0);
      }
    }
  }

  return isallowed;
}

function killstreak_debug_text(text) {
  level.killstreak_rule_debug = getdvarint(#"scr_killstreak_rule_debug", 0);

  if(isDefined(level.killstreak_rule_debug)) {
    if(level.killstreak_rule_debug == 1) {
      iprintln("<dev string:x137>" + text + "<dev string:x140>");
      return;
    }

    if(level.killstreak_rule_debug == 2) {
      iprintlnbold("<dev string:x137>" + text);
    }
  }
}