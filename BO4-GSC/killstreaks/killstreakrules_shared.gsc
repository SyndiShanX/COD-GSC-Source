/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\killstreakrules_shared.gsc
**************************************************/

#include scripts\core_common\popups_shared;
#include scripts\core_common\values_shared;
#include scripts\killstreaks\emp_shared;

#namespace killstreakrules;

init_shared() {
  val::register(#"killstreaksdisabled", 1, "$self", &function_4a433a3f, "$value");

  if(!isDefined(level.var_ef447a73)) {
    level.var_ef447a73 = {};
    level.killstreakrules = [];
    level.killstreaktype = [];
    level.killstreaks_triggered = [];
    level.matchrecorderkillstreakkills = [];

    if(!isDefined(level.globalkillstreakscalled)) {
      level.globalkillstreakscalled = 0;
    }
  }
}

function_4a433a3f(value) {
  self function_fe89725a(value);
}

createrule(rule, maxallowable, maxallowableperteam) {
  level.killstreakrules[rule] = spawnStruct();
  level.killstreakrules[rule].cur = 0;
  level.killstreakrules[rule].curteam = [];
  level.killstreakrules[rule].max = maxallowable;
  level.killstreakrules[rule].maxperteam = maxallowableperteam;
}

addkillstreaktorule(killstreak, rule, counttowards, checkagainst, inventoryvariant) {
  if(!isDefined(level.killstreaktype[killstreak])) {
    level.killstreaktype[killstreak] = [];
  }

  keys = getarraykeys(level.killstreaktype[killstreak]);
  assert(isDefined(level.killstreakrules[rule]));

  if(!isDefined(level.killstreaktype[killstreak][rule])) {
    level.killstreaktype[killstreak][rule] = spawnStruct();
  }

  level.killstreaktype[killstreak][rule].counts = counttowards;
  level.killstreaktype[killstreak][rule].checks = checkagainst;

  if(!(isDefined(inventoryvariant) && inventoryvariant)) {
    addkillstreaktorule("inventory_" + killstreak, rule, counttowards, checkagainst, 1);
  }
}

killstreakstart(hardpointtype, team, hacked, displayteammessage) {
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
      self displaykillstreakstartteammessagetoall(hardpointtype);
    }
  }

  keys = getarraykeys(level.killstreaktype[hardpointtype]);

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
    #hardpoint_type: hardpointtype, 
    #team: team, 
    #attacker: self
  });
  killstreak_id = level.globalkillstreakscalled;
  level.globalkillstreakscalled++;
  killstreak_data = [];
  killstreak_data[#"caller"] = self getxuid();
  killstreak_data[#"spawnid"] = getplayerspawnid(self);
  killstreak_data[#"starttime"] = gettime();
  killstreak_data[#"type"] = hardpointtype;
  killstreak_data[#"endtime"] = 0;
  level.matchrecorderkillstreakkills[killstreak_id] = 0;
  level.killstreaks_triggered[killstreak_id] = killstreak_data;

  killstreak_debug_text("<dev string:x53>" + hardpointtype + "<dev string:x6a>" + team + "<dev string:x78>" + killstreak_id);

    return killstreak_id;
}

displaykillstreakstartteammessagetoall(hardpointtype) {
  if(isDefined(level.killstreaks[hardpointtype]) && isDefined(level.killstreaks[hardpointtype].var_43279ec9)) {
    level thread popups::displaykillstreakteammessagetoall(hardpointtype, self);
  }
}

recordkillstreakenddirect(eventindex, recordstreakindex, totalkills) {
  player = self;
  player recordkillstreakendevent(eventindex, recordstreakindex, totalkills);
  player.killstreakevents[recordstreakindex] = undefined;
}

recordkillstreakend(recordstreakindex, totalkills) {
  player = self;

  if(!isplayer(player)) {
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

killstreakstop(hardpointtype, team, id) {
  assert(isDefined(team), "<dev string:x38>");
  assert(isDefined(hardpointtype));

  idstr = "<dev string:x80>";

  if(isDefined(id)) {
    idstr = id;
  }

  killstreak_debug_text("<dev string:x8c>" + hardpointtype + "<dev string:x6a>" + team + "<dev string:x78>" + idstr);

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

    killstreak_debug_text("<dev string:xa3>" + hardpointtype);

      if(sessionmodeismultiplayergame()) {
        function_92d1707f(#"hash_710b205b26e46446", {
          #starttime: 0, 
          #endtime: gettime(), 
          #name: hardpointtype, 
          #team: team
        });
      }

    return;
  }

  level.killstreaks_triggered[id][#"endtime"] = gettime();
  totalkillswiththiskillstreak = level.matchrecorderkillstreakkills[id];

  if(sessionmodeismultiplayergame()) {
    mpkillstreakuses = {
      #starttime: level.killstreaks_triggered[id][#"starttime"], 
      #endtime: level.killstreaks_triggered[id][#"endtime"], 
      #spawnid: level.killstreaks_triggered[id][#"spawnid"], 
      #name: hardpointtype, 
      #team: team
    };
    function_92d1707f(#"hash_710b205b26e46446", mpkillstreakuses);
  }

  level.killstreaks_triggered[id] = undefined;
  level.matchrecorderkillstreakkills[id] = undefined;

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
}

iskillstreakallowed(hardpointtype, team, var_1d8339ae) {
  if(level.var_7aa0d894 === 1) {
    return 0;
  }

  assert(isDefined(team), "<dev string:x38>");
  assert(isDefined(hardpointtype));
  isallowed = 1;
  keys = getarraykeys(level.killstreaktype[hardpointtype]);

  foreach(key in keys) {
    if(!level.killstreaktype[hardpointtype][key].checks) {
      continue;
    }

    if(level.killstreakrules[key].max != 0) {
      if(level.killstreakrules[key].cur >= level.killstreakrules[key].max) {

        killstreak_debug_text("<dev string:xd2>" + key + "<dev string:xde>");

          isallowed = 0;
        break;
      }
    }

    if(level.teambased && level.killstreakrules[key].maxperteam != 0) {
      if(!isDefined(level.killstreakrules[key].curteam[team])) {
        level.killstreakrules[key].curteam[team] = 0;
      }

      if(level.killstreakrules[key].curteam[team] >= level.killstreakrules[key].maxperteam) {
        isallowed = 0;

        killstreak_debug_text("<dev string:xd2>" + key + "<dev string:xe9>");

          break;
      }
    }
  }

  if(isDefined(self.laststand) && self.laststand) {

    killstreak_debug_text("<dev string:xf1>");

      isallowed = 0;
  }

  isemped = 0;

  if(self isempjammed()) {

    killstreak_debug_text("<dev string:x100>");

      isallowed = 0;
    isemped = 1;

    if(self emp::enemyempactive()) {
      if(isDefined(level.empendtime)) {
        secondsleft = int(float(level.empendtime - gettime()) / 1000);

        if(secondsleft > 0) {
          self iprintlnbold(#"hash_2ce2d6e10e74ed97", secondsleft);
          return 0;
        }
      }
    }
  }

  if(isDefined(level.var_7b151daa) && [[level.var_7b151daa]](self)) {

    killstreak_debug_text("<dev string:x10d>");

      isallowed = 0;
  }

  if(!(isDefined(var_1d8339ae) && var_1d8339ae)) {
    if(isallowed == 0) {
      if(isDefined(level.var_956bde25)) {
        self[[level.var_956bde25]](hardpointtype, team, isemped);
      }
    }
  }

  return isallowed;
}

killstreak_debug_text(text) {
  level.killstreak_rule_debug = getdvarint(#"scr_killstreak_rule_debug", 0);

  if(isDefined(level.killstreak_rule_debug)) {
    if(level.killstreak_rule_debug == 1) {
      iprintln("<dev string:x11c>" + text + "<dev string:x124>");
      return;
    }

    if(level.killstreak_rule_debug == 2) {
      iprintlnbold("<dev string:x11c>" + text);
    }
  }
}

