/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\supers\super_emp_pulse.gsc
****************************************************/

#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\talking_gun;
#using scripts\cp_mp\utility\callback_group;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gamescore;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_util;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace super_emp_pulse;

function function_dca5550c46b2a111() {
  if(!isDefined(level.superglobals.staticsuperdata["super_emp_pulse"])) {
    return;
  }

  level.superglobals.staticsuperdata["super_emp_pulse"].var_f6604eebabcac6c2 = &function_f41bae22bcc2bde7;
  level.super_emp_pulse_throttle = throttle_initialize("super_emp_pulse_throttle", 1, 0.3);
}

function function_f41bae22bcc2bde7() {
  return true;
}

function function_f62e25cb503d7bab() {
  result = function_e192d40d87bd55a9();
  return result;
}

function emppulse_unset() {
  function_75baa17a54260f6f(0);
  scripts\mp\supers::function_7203e7aa96ff0ba9(0);
  self notify("empPulse_unset");
}

function function_e83e2d8dc74ffdbb() {
  scripts\mp\supers::function_7203e7aa96ff0ba9(30);
  function_75baa17a54260f6f(1);
  thread function_3f97c8a2961e9d18();
}

function function_3f97c8a2961e9d18() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("super_use_finished");
  self endon("empPulse_unset");

  while(true) {
    self waittill("super_use_charging");

    if(issuperready()) {
      continue;
    }

    if(issuperinuse()) {
      continue;
    }

    emppulse_unset();
    break;
  }
}

function function_c2ca731bdb780549() {
  function_75baa17a54260f6f(0);
  function_ddeb08081f6fabea();
}

function function_e192d40d87bd55a9() {
  objweapon = makeweapon("emp_pulse_device_mp");
  deploysuccess = giveandfireoffhandreliable(objweapon);

  if(istrue(deploysuccess)) {
    return function_4941256ee86725f8();
  }

  return refundsuper();
}

function function_4941256ee86725f8() {
  time = getdvarfloat(@ "hash_e347daec58694e5", 0.65);
  self setclientomnvar("ui_super_ddos_screen_on", 1);
  wait time;
  function_c2ca731bdb780549();
  thread function_58634008ff0b995();
  thread function_a2b3da8c5c455aa9();
  thread function_68474541e3f6e6c3();
  scripts\cp_mp\challenges::function_d997435895422ecc("super_emp_pulse", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
  scripts\cp_mp\talking_gun::function_55b08d6d71b41402(self, "equipment_deployed");
  return true;
}

function function_75baa17a54260f6f(isenabled) {
  if(isenabled) {
    self setclientomnvar("ui_emp_target_detector_on_give_widget", 1);
    thread function_a985f47623d10ac();
    return;
  }

  self notify("empPulse_disableOnGiveWidget");
  self setclientomnvar("ui_emp_target_detector_on_give_widget", 0);
}

function function_a985f47623d10ac() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("empPulse_disableOnGiveWidget");
  maxdist = sqrt(5000000);

  while(true) {
    numents = function_63973975ceee9dda(empdebuff_get_emp_ents(self.origin, maxdist), self.origin, self.angles).size;
    numents = int(clamp(numents, 0, 5));
    widgetval = numents + 1;
    self setclientomnvar("ui_emp_target_detector_on_give_widget", widgetval);
    function_f632348cbb773537(level.super_emp_pulse_throttle, self);
  }
}

function function_68474541e3f6e6c3() {
  level endon("game_ended");
  self endon("disconnect");
  wait 0.88;
  self setclientomnvar("ui_super_ddos_screen_on", 0);
}

function function_58634008ff0b995() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("DDoSPulse", "pulse", 0);
  waittill_any_2("death", "scramble_clear");
  self setscriptablepartstate("DDoSPulse", "off", 0);
}

function function_f83892872eaf9d79(objweapon) {
  self endon("disconnect");
  level endon("game_ended");
  level endon("round_end");
  var_170b85c668cf4b59 = self.angles;
  blastorigin = self.origin;
  step = 100;
  maxdist = 1000;
  waittime = 0.1;
  currentdist = step;
  empdist = sqrt(5000000);
  possibleplayers = getplayersinradius(self.origin, empdist);
  possibleents = empdebuff_get_emp_ents(self.origin, empdist);
  var_dbee2266e7253dcd = function_65eb2204db38221a(possibleplayers, blastorigin, var_170b85c668cf4b59);
  var_9b64bcbed677462b = function_63973975ceee9dda(possibleents, blastorigin, var_170b85c668cf4b59, 1);

  while(currentdist <= maxdist) {
    currentdistsq = currentdist * currentdist;
    playersleft = [];

    for(i = 0; i < var_dbee2266e7253dcd.size; i++) {
      victim = var_dbee2266e7253dcd[i]["player"];

      if(!function_641436d9bd65f63c(self, victim)) {
        continue;
      }

      if(istrue(var_dbee2266e7253dcd[i]["isPulsed"])) {
        continue;
      }

      horizdistsq = var_dbee2266e7253dcd[i]["horizDistSq"];
      vertdistsq = var_dbee2266e7253dcd[i]["vertDistSq"];

      if(horizdistsq * vertdistsq <= currentdist) {
        data = packdamagedata(self, victim, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);
        thread emppulse_apply_player(data, function_8abf731d992d2081(victim));
        var_dbee2266e7253dcd[i]["isPulsed"] = 1;
        continue;
      }

      playersleft[playersleft.size] = var_dbee2266e7253dcd[i];
    }

    var_dbee2266e7253dcd = playersleft;
    entsleft = [];

    for(j = 0; j < var_9b64bcbed677462b.size; j++) {
      ent = var_9b64bcbed677462b[j]["entity"];

      if(!function_641436d9bd65f63c(self, ent)) {
        continue;
      }

      if(istrue(var_9b64bcbed677462b[j]["isPulsed"])) {
        continue;
      }

      if(var_9b64bcbed677462b[j]["horizDistSq"] <= currentdistsq) {
        if(var_9b64bcbed677462b[j]["vertDistSq"] <= 4000000) {
          data = packdamagedata(self, ent, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);
          thread function_25310643899068a8(data, function_8abf731d992d2081(ent));
          var_9b64bcbed677462b[j]["isPulsed"] = 1;
        }

        continue;
      }

      entsleft[entsleft.size] = var_9b64bcbed677462b[j];
    }

    var_9b64bcbed677462b = entsleft;
    currentdist += step;
    wait waittime;
  }
}

function function_641436d9bd65f63c(attacker, victim) {
  if(!isDefined(victim)) {
    return false;
  }

  if(istrue(level.var_684d782689230a50) && isDefined(victim.towerstruct) && isDefined(victim.towerstruct.uav_station)) {
    if(!isDefined(victim.towerstruct.uav_station.activeteam)) {
      return true;
    } else {
      return !istrue(victim.towerstruct.uav_station.activeteam == attacker.team);
    }
  }

  if(isDefined(victim.type)) {
    if(istrue(level.var_3976c9c03dc06d9b)) {
      if(istrue(victim.var_47d27267be4655fb)) {
        return true;
      }
    }

    if(isDefined(level.deployablekiosks) && istrue(level.deployablekiosks.var_8bf814f9559f53)) {
      if(victim.type == "portable_buy_drone") {
        return !istrue(victim.team == attacker.team);
      }
    }

    if(isDefined(level.br_armory_kiosk) && istrue(level.br_armory_kiosk.var_aaa31c1e28a5663c)) {
      if(issubstr(victim.type, "br_plunder_box")) {
        return true;
      }
    }

    if(isDefined(level.br_armory_trader) && istrue(level.br_armory_trader.var_6bc61e1f4afa3ff3)) {
      if(issubstr(victim.type, "br_armory_trader")) {
        return true;
      }
    }
  }

  if(isDefined(level.holdprop) && istrue(level.holdprop.canemp) && isDefined(victim.stronghold)) {
    if(!isDefined(victim.stronghold.capturedteam)) {
      return true;
    } else {
      return !istrue(victim.stronghold.capturedteam == attacker.team);
    }
  }

  if(isagent(victim)) {
    return false;
  }

  if(isPlayer(victim)) {
    if(victim isplayerheadless()) {
      return false;
    }

    if(victim == attacker) {
      return false;
    }

    if(!isreallyalive(victim)) {
      return false;
    }

    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(attacker, victim)) && !istrue(getdvarint(@ "hash_58254c61de76bffe", 0))) {
      return false;
    }

    if(victim isusingremote()) {
      return false;
    }

    if(isDefined(victim.var_9d3e90085b3f0da3)) {
      return false;
    } else {
      return true;
    }
  } else {
    if(istrue(victim.isdestroyed)) {
      return false;
    }

    entowner = victim.owner;

    if(isDefined(entowner)) {
      if(entowner == attacker && !istrue(getdvarint(@ "hash_58254c61de76bffe", 0))) {
        return false;
      }

      if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(attacker, entowner)) && !istrue(getdvarint(@ "hash_58254c61de76bffe", 0))) {
        return false;
      }
    }

    team = victim.team;

    if(isDefined(team)) {
      if(team == attacker.team && !istrue(getdvarint(@ "hash_58254c61de76bffe", 0))) {
        return false;
      }
    }

    if(victim scripts\cp_mp\vehicles\vehicle::isvehicle() && !scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(victim, attacker)) {
      return false;
    }

    if(isDefined(victim.vehicle) && victim.vehicle scripts\cp_mp\vehicles\vehicle::isvehicle() && !scripts\cp_mp\vehicles\vehicle::vehicle_isenemytoplayer(victim.vehicle, attacker)) {
      return false;
    }

    return true;
  }

  return false;
}

function private function_150ef769c933224a(a, b) {
  if(a["horizDistSq"] < b["horizDistSq"]) {
    return 1;
  }

  return 0;
}

function function_65eb2204db38221a(sourcearray, reforigin, var_47b3acf386b6f5a) {
  filteredplayers = [];

  foreach(player in sourcearray) {
    if(!function_641436d9bd65f63c(self, player)) {
      continue;
    }

    sourceforward = anglesToForward(var_47b3acf386b6f5a);
    sourceup = anglestoup(var_47b3acf386b6f5a);
    var_426aca92d85b305c = flatten_vector(player.origin - reforigin);
    vertdist = vectordot(var_426aca92d85b305c, sourceup);
    horizdist = vectordot(var_426aca92d85b305c, sourceforward);

    if(abs(vertdist) > 2000) {
      continue;
    }

    if(abs(horizdist) > 1000) {
      continue;
    }

    var_df44da7768cc370f = anglesToForward(var_47b3acf386b6f5a);
    anglediff = math::anglebetweenvectorssigned(var_df44da7768cc370f, var_426aca92d85b305c, (0, 0, 1));

    if(abs(anglediff) > 110) {
      continue;
    }

    index = filteredplayers.size;
    filteredplayers[index]["player"] = player;
    filteredplayers[index]["vertDistSq"] = vertdist * vertdist;
    filteredplayers[index]["horizDistSq"] = horizdist * horizdist;
    filteredplayers[index]["isPulsed"] = 0;
  }

  filteredplayers = array_sort_with_func(filteredplayers, &function_150ef769c933224a);
  return filteredplayers;
}

function function_63973975ceee9dda(sourcearray, reforigin, var_47b3acf386b6f5a, sort) {
  filteredents = [];
  sourceforward = anglesToForward(var_47b3acf386b6f5a);
  sourceup = anglestoup(var_47b3acf386b6f5a);
  sourceside = anglestoright(var_47b3acf386b6f5a);

  foreach(ent in sourcearray) {
    if(!istrue(function_641436d9bd65f63c(self, ent))) {
      continue;
    }

    var_426aca92d85b305c = ent.origin - reforigin;
    vertdist = vectordot(var_426aca92d85b305c, sourceup);

    if(abs(vertdist) > 2000) {
      continue;
    }

    horizdistsq = pow(vectordot(var_426aca92d85b305c, sourceforward), 2) + pow(abs(vectordot(var_426aca92d85b305c, sourceside)), 2);

    if(abs(horizdistsq) > 1000000) {
      continue;
    }

    anglediff = math::anglebetweenvectorssigned(sourceforward, var_426aca92d85b305c, (0, 0, 1));

    if(abs(anglediff) > 110) {
      continue;
    }

    index = filteredents.size;
    filteredents[index]["entity"] = ent;
    filteredents[index]["horizDistSq"] = horizdistsq;
    filteredents[index]["vertDistSq"] = vertdist * vertdist;
    filteredents[index]["isPulsed"] = 0;
  }

  if(istrue(sort)) {
    filteredents = array_sort_with_func(filteredents, &function_150ef769c933224a);
  }

  return filteredents;
}

function function_a2b3da8c5c455aa9() {
  self endon("disconnect");
  objweapon = makeweapon("emp_pulse_mp");
  thread function_757161adb13d0e4c();
  self earthquakeforplayer(0.2, 1, self.origin, 2000);
  thread function_cf17a9452e2260df(objweapon);
  function_f83892872eaf9d79(objweapon);
  function_2f0d9315ab20c4bf();
}

function function_757161adb13d0e4c() {
  self endon("disconnect");
  level endon("game_ended");
  self setscriptablepartstate("DDoSBlast", "initial_blast", 0);
  waittill_any_timeout_2(1, "death", "scramble_clear");
  self setscriptablepartstate("DDoSBlast", "off", 0);
}

function function_cf17a9452e2260df(objweapon) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self notify("empPulse_scrambling");
  self endon("empPulse_scrambling");
  var_8ee201a397cd1843 = gettime() + 6000;
  waittime = 0.1;

  while(gettime() < var_8ee201a397cd1843) {
    players = getplayersinradius(self.origin, 500);

    foreach(player in players) {
      if(!function_641436d9bd65f63c(self, player)) {
        continue;
      }

      if(!isDefined(player.var_9d3e90085b3f0da3)) {
        data = packdamagedata(self, player, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin);
        player thread emppulse_apply_player(data, function_8abf731d992d2081(player));
      }
    }

    wait waittime;
  }

  self notify("scramble_clear");
}

function function_194f1400b244a82b(target) {
  if(!isDefined(self.var_3ff0b2483ea046e3)) {
    self.var_3ff0b2483ea046e3 = [];
  }

  entitynum = target getentitynumber();
  lifeindex = ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self.var_3ff0b2483ea046e3[entitynum]) || self.var_3ff0b2483ea046e3[entitynum] > lifeindex) {
    self.var_3ff0b2483ea046e3[entitynum] = lifeindex;

    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      self thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("emped_player");
    }

    if(isDefined(self.super)) {
      if(!isDefined(self.super.hitcount)) {
        self.super.hitcount = 1;
      }

      self.super.hitcount++;
    }
  }
}

function function_25310643899068a8(data, time) {
  var_d5c235d554645bbc = 0;

  if(getdvarint(@ "hash_10320e52e3e9ab5c", 0)) {
    var_d5c235d554645bbc = 1;
  }

  attacker = self;
  var_9cc7d33e2e2ebfef = function_59dd501e1d9eb7bf(self);
  victim = data.victim;
  data.time = time;

  if(!isDefined(attacker) || !isDefined(victim)) {
    return;
  }

  if(isDefined(victim.var_af81370570c04ca) && victim.var_af81370570c04ca > 0) {
    emptime = victim.var_af81370570c04ca;
  }

  if(isDefined(victim.type) && (victim.type == "dmz_uav_tower" || victim.type == "scriptable_br_plunder_box" || istrue(victim.var_47d27267be4655fb))) {} else if(isDefined(var_9cc7d33e2e2ebfef) && victim.classname != "trigger_radius") {
    thread function_6b8603ff55f4ed2c([victim], self, var_9cc7d33e2e2ebfef, time, "ddos_target_non_player", "perk_superior");
  }

  thread function_662905d3b9455612(data, time, var_d5c235d554645bbc);
}

function function_59dd501e1d9eb7bf(attacker) {
  var_91954ef8d7823ca4 = getdvarint(@ "hash_8863a21e430252d5", 0) == 1;

  if(!isagent(attacker)) {
    if(!level.teambased || var_91954ef8d7823ca4) {
      return [attacker];
    }

    if(scripts\cp_mp\utility\squad_utility::shouldmodesetsquads()) {
      return level.squaddata[attacker.team][attacker.sessionsquadid].players;
    }

    return getteamdata(attacker.team, "players");
  }
}

function emppulse_apply_player(data, overridetime) {
  data.victim notify("empPulse_apply_player");
  data.victim endon("empPulse_apply_player");
  apply_emp_struct(data, 0);
  self function_9b28bd480aaad85f(1);
  data.victim thread function_64d9a2632f1a99c7(data.attacker);
  data.attacker thread function_194f1400b244a82b(data.victim);
  scripts\mp\gamescore::trackdebuffassist(data.attacker, data.victim, data.objweapon.basename);
  data.victim function_954bd233e4e1a4ab(1);
  msg = function_1a710e4b1d09123b(data, overridetime);
  data.victim function_954bd233e4e1a4ab(0);

  if(isDefined(data.victim)) {
    data.victim remove_emp();

    if(isDefined(data.attacker) && isreallyalive(data.attacker)) {
      scripts\mp\gamescore::untrackdebuffassist(data.attacker, data.victim, data.objweapon.basename);
    }

    self function_9b28bd480aaad85f(0);
  }
}

function function_954bd233e4e1a4ab(var_befbe3bc1857da1b) {
  if(!scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
    return;
  }

  assertex(isDefined(var_befbe3bc1857da1b), "<dev string:x1c>");

  if(var_befbe3bc1857da1b) {
    self visionsetnightforplayer("iw9_mp_nvg_base_color_ddos");
    return;
  }

  self visionsetnightforplayer("iw9_mp_nvg_base_color");
}

function function_1a710e4b1d09123b(data, overridetime) {
  data.victim endon("death_or_disconnect");
  level endon("game_ended");
  time = 6;

  if(isDefined(overridetime)) {
    time = overridetime;
  }

  msg = waittill_notify_or_timeout_return("emp_cleared", time);
  return msg;
}

function function_8abf731d992d2081(victim) {
  defaulttime = getdvarfloat(@ "hash_44c4511516eafbbe", 6);

  if(victim scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    defaulttime = ter_op(getdvarint(@ "hash_10320e52e3e9ab5c", 0), defaulttime, getdvarfloat(@ "hash_820929aec8056e07", 3.5));
  }

  if(ismutationgamemodezombie()) {
    return defaulttime;
  }

  if(!getcurrentsuper().isinuse) {
    return defaulttime;
  }

  return clamp(getcurrentsuper().usepercent * defaulttime, 0, defaulttime);
}

function function_64d9a2632f1a99c7(jammerent) {
  self endon("disconnect");
  self endon("emp_scramble_off");

  if(isDefined(self.var_9d3e90085b3f0da3)) {
    function_ffa0f84dfa2faf4d();
  }

  self.var_9d3e90085b3f0da3 = jammerent;
  thread function_36bfca5111b03188(jammerent);
  function_7bdae2425bb328d2(jammerent);

  if(isDefined(self.var_9d3e90085b3f0da3)) {
    function_ffa0f84dfa2faf4d(jammerent);
  }
}

function function_7bdae2425bb328d2(jammerent) {
  level endon("game_ended");
  jammerent endon("disconnect");
  self endon("disconnect");
  jammerent childthread function_46e4db17237e26b9(self);
  childthread function_243384fbcfc9cc34();
  waittill_any_timeout_3(6, "empPulse_ownerDeath", "empPulse_victimDeath", "ddos_ended_early");
}

function function_ffa0f84dfa2faf4d(jammerent) {
  self.var_9d3e90085b3f0da3 = undefined;
  scripts\cp_mp\emp_debuff::function_f7c6d776d032122f();
}

function function_46e4db17237e26b9(victim) {
  self waittill("death");
  victim notify("empPulse_ownerDeath");
}

function function_243384fbcfc9cc34() {
  self waittill("death");
  self notify("empPulse_victimDeath");
}

function function_36bfca5111b03188(jammerent) {
  self endon("death_or_disconnect");
  self endon("emp_scramble_off");
  jammerent endon("death_or_disconnect");
  previousstrength = 0;
  scramblerstrength = 0;

  while(true) {
    scramblerstrength = function_74b2449af1d5f763(jammerent);
    var_4893b9a18cf47d6c = scramblerstrength != previousstrength;

    if(previousstrength == 0 || var_4893b9a18cf47d6c) {
      scripts\cp_mp\emp_debuff::stop_emp_scramble(previousstrength);
      scripts\cp_mp\emp_debuff::play_emp_scramble(scramblerstrength);
      previousstrength = scramblerstrength;
    }

    waitframe();
  }
}

function function_74b2449af1d5f763(jammerent) {
  scramblerradius = 500;
  var_f3b7cc3138382dfb = scramblerradius * scramblerradius;
  distancechecksq = distance2dsquared(jammerent.origin, self.origin);
  scramblerstrength = 0;

  if(distancechecksq > var_f3b7cc3138382dfb) {
    scramblerstrength = 0;
  } else if(distancechecksq >= var_f3b7cc3138382dfb * 0.8) {
    scramblerstrength = 1;
  } else if(distancechecksq >= var_f3b7cc3138382dfb * 0.6) {
    scramblerstrength = 2;
  } else if(distancechecksq >= var_f3b7cc3138382dfb * 0.4) {
    scramblerstrength = 3;
  } else if(distancechecksq >= var_f3b7cc3138382dfb * 0.2) {
    scramblerstrength = 4;
  } else {
    scramblerstrength = 5;
  }

  return scramblerstrength;
}

function function_2f0d9315ab20c4bf() {
  if(isDefined(self.super) && isDefined(self.super.hitcount)) {
    scripts\cp_mp\challenges::function_d997435895422ecc("super_emp_pulse", function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"end"), self.super.hitcount);
    self.super.hitcount = undefined;
  }

  self.var_3ff0b2483ea046e3 = undefined;
}