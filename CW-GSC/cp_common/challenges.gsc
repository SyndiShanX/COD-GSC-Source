/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\challenges.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\achievements;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\util;

#namespace challenges;

function private autoexec __init__system__() {
  system::register(#"challenges", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
  callback::on_start_gametype(&start_gametype);
  level.challenges_callback_vehicledamaged = &vehicledamaged;
  level.challenges_callback_vehiclekilled = &vehiclekilled;
}

function start_gametype() {
  if(!isDefined(level.challengescallbacks)) {
    level.challengescallbacks = [];
  }

  waittillframeend();

  if(canprocesschallenges()) {
    registerchallengescallback("actorKilled", &challengeactorkills);
    registerchallengescallback("actorDamaged", &function_f5b31539);
    registerchallengescallback("VehicleKilled", &function_8e9b2d44);
    registerchallengescallback("VehicleDamaged", &function_b7b0cce0);
  }

  callback::on_connect(&on_player_connect);
  callback::on_connect(&function_706ec529);
}

function function_8e9b2d44(data, time) {
  challengeactorkills(data, time);
}

function function_b7b0cce0(data, time) {
  function_f5b31539(data, time);
}

function function_f5b31539(data, time) {}

function challengeactorkills(data, time) {
  player = getPlayers()[0];

  if(is_true(time.var_2a0adc57)) {
    player thread function_fc664fc6(#"hash_36bacb4a6c637824", 2);
  }
}

function function_fc664fc6(challengestat, var_2c59fe94, var_21bccb49 = 1, var_cab0fdf5 = 1) {
  self notify("1989758cddd563a9");
  self endon("1989758cddd563a9");
  assert(isPlayer(self));
  self endon(#"death");

  if(!isDefined(self.var_75b0a52c)) {
    self.var_75b0a52c = [];
  }

  if(!isDefined(self.var_75b0a52c[challengestat])) {
    self.var_75b0a52c[challengestat] = 0;
  }

  self.var_75b0a52c[challengestat] += var_21bccb49;

  for(i = 0; i < var_2c59fe94; i++) {
    waitframe(2);
  }

  if((isDefined(self.var_75b0a52c[challengestat]) ? self.var_75b0a52c[challengestat] : 0) >= var_2c59fe94) {
    self stats::function_dad108fa(challengestat, var_cab0fdf5);
  }

  self.var_75b0a52c[challengestat] = undefined;

  if(self.var_75b0a52c.size == 0) {
    self.var_75b0a52c = undefined;
  }
}

function actorkilled(einflictor, attacker, idamage, smeansofdeath, weapon = level.weaponnone, shitloc) {
  attacker endon(#"disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.smeansofdeath = smeansofdeath;
  data.weapon = weapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.victimweapon = data.victim.currentweapon;

  if(einflictor === attacker.body_shield_grenade) {
    data.var_2a0adc57 = 1;
  }

  waitandprocessactorkilledcallback(data);
  data.attacker notify(#"actorkilledchallengesprocessed");
}

function waitandprocessactorkilledcallback(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon(#"disconnect");
  }

  waitframe(1);
  util::waittillslowprocessallowed();
  level thread dochallengecallback("actorKilled", data);
}

function actordamaged(einflictor, attacker, idamage, weapon = level.weaponnone, shitloc) {
  attacker endon(#"disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.weapon = weapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.victimweapon = data.victim.currentweapon;
  function_5e9d4ad3(data);
  data.attacker notify(#"actordamagedchallengesprocessed");
}

function function_5e9d4ad3(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon(#"disconnect");
  }

  waitframe(1);
  util::waittillslowprocessallowed();
  level thread dochallengecallback("actorDamaged", data);
}

function vehiclekilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc) {
  if(isDefined(level.var_e855c811)) {
    return;
  }

  if(!isDefined(weapon)) {
    weapon = level.weaponnone;
  }

  attacker endon(#"disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.smeansofdeath = smeansofdeath;
  data.weapon = weapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.victimweapon = data.victim.currentweapon;
  function_94d6aade(data);
  data.attacker notify(#"vehiclekilledchallengesprocessed");
}

function function_94d6aade(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon(#"disconnect");
  }

  waitframe(1);
  util::waittillslowprocessallowed();
  level thread dochallengecallback("VehicleKilled", data);
}

function vehicledamaged(einflictor, attacker, idamage, weapon = level.weaponnone, shitloc) {
  attacker endon(#"disconnect");
  data = spawnStruct();
  data.victim = self;
  data.einflictor = einflictor;
  data.attacker = attacker;
  data.idamage = idamage;
  data.weapon = weapon;
  data.shitloc = shitloc;
  data.time = gettime();
  data.victimweapon = data.victim.currentweapon;
  waitandprocessvehicledamagedcallback(data);
  data.attacker notify(#"vehicledamagedchallengesprocessed");
}

function waitandprocessvehicledamagedcallback(data) {
  if(isDefined(data.attacker)) {
    data.attacker endon(#"disconnect");
  }

  waitframe(1);
  level thread dochallengecallback("VehicleDamaged", data);
}

function callback_decoration_awarded() {
  self thread function_8332bc5e("career_decorations");
}

function function_8332bc5e(statname, n_amount = 1) {
  self endon(#"disconnect");

  if(!isPlayer(self)) {
    return;
  }

  self stats::function_dad108fa(statname, n_amount);
}

function function_706ec529() {
  self.challenge_callback_cp = &function_81d1dce8;

  self thread function_ba92458e();
  self thread function_160aeb02();
}

function private function_160aeb02() {
  util::init_dvar("<dev string:x38>", -1, &function_5fc09844);
  var_c83485 = 36;

  for(challengeindex = 1; challengeindex <= var_c83485; challengeindex++) {
    var_6cbd4315 = tablelookup(#"gamedata/stats/cp/statsmilestones1.csv", 0, challengeindex, 4);

    if(isDefined(var_6cbd4315)) {
      var_6cbd4315 = hashtostring(var_6cbd4315);
      adddebugcommand("<dev string:x55>" + var_6cbd4315 + "<dev string:x7e>" + challengeindex - 1 + "<dev string:x83>" + challengeindex + "<dev string:xa8>");
    }
  }
}

function private function_5fc09844(param) {
  challengeindex = int(param.value);

  if(challengeindex >= 0) {
    setDvar(#"hash_2295f8bff1842026", -1);
    level thread function_9635f1e6(challengeindex);
  }
}

function function_f752d6a9(challenge_index) {
  return tablelookup(#"gamedata/stats/cp/statsmilestones1.csv", 0, challenge_index, 5);
}

function function_81d1dce8(rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex) {
  if(itemindex != 7) {
    return;
  }

  function_9635f1e6(challengeindex);
}

function private function_9635f1e6(challengeindex) {
  if(!isDefined(level.var_464843f)) {
    level.var_464843f = [];
  } else if(!isarray(level.var_464843f)) {
    level.var_464843f = array(level.var_464843f);
  }

  if(!isinarray(level.var_464843f, challengeindex)) {
    level.var_464843f[level.var_464843f.size] = challengeindex;
  }

  level thread function_65b0a754();
}

function private function_65b0a754() {
  assert(isDefined(level.var_464843f));

  if(level flag::get(#"hash_4c113937297760d8")) {
    return;
  }

  level flag::set(#"hash_4c113937297760d8");

  while(level.var_464843f.size > 0) {
    challengeindex = level.var_464843f[0];
    arrayremoveindex(level.var_464843f, 0);
    waitframe(1);
    var_21e736f9 = tablelookup(#"gamedata/stats/cp/statsmilestones1.csv", 0, challengeindex, 5);
    challengexp = int(tablelookup(#"gamedata/stats/cp/statsmilestones1.csv", 0, challengeindex, 6));
    challengedesc = tablelookup(#"gamedata/stats/cp/statsmilestones1.csv", 0, challengeindex, 12);

    if(scripted_widgets::exists(#"hash_166066a38ca1f36d")) {
      scripted_widgets::remove(#"hash_166066a38ca1f36d");
    }

    scripted_widgets::create(#"hash_166066a38ca1f36d", #"hash_367f58e18cde1c9e");
    scripted_widgets::function_d3c3e5c3(#"hash_166066a38ca1f36d", [#"dialog_tree", #"interactive_map", #"computer"]);
    scripted_widgets::function_9ade1d9b(#"hash_166066a38ca1f36d", "text", hash(var_21e736f9));
    scripted_widgets::function_9ade1d9b(#"hash_166066a38ca1f36d", "desc", hash(challengedesc));
    scripted_widgets::function_9ade1d9b(#"hash_166066a38ca1f36d", "count", challengexp);
    player = getPlayers()[0];
    player playSound(#"hash_9422601830d30a9");
    wait 6;
    scripted_widgets::remove(#"hash_166066a38ca1f36d");
  }

  level flag::clear(#"hash_4c113937297760d8");
}

function function_7b4387e1(rewardxp, maxval, row, tablenumber, challengetype, itemindex, challengeindex) {
  self function_18b65152();

  if(challengeindex == 565) {
    self givedecoration("cp_medal_all_accolades");
  }

  tier = int(tablelookup(#"gamedata/stats/cp/statsmilestones1.csv", 0, challengeindex, 1));

  switch (challengetype) {
    case 0:
      challengename = function_f752d6a9(challengeindex);

      switch (challengename) {
        case #"hash_20faf480b8f9146a":
          break;
        case #"cp_challenges_all_complete":
          self givedecoration("cp_medal_all_calling_cards");
          break;
      }

      break;
    case 1:
      if(itemindex != 0) {
        self stats::set_stat(#"itemstats", itemindex, #"challengecompleted", tier, 1);
        self achievements::checkweaponchallengecomplete(tier);
      }

      break;
    case 4:
      var_9327960d = tablelookup(#"gamedata/stats/cp/statsmilestones1.csv", 0, challengeindex, 13);
      self stats::set_stat(#"attachments", var_9327960d, #"challengecompleted", tier, 1);
      break;
  }

  if(getdvarint(#"debugchallenges", 0) != 0) {
    var_c4e9517b = tablenumber + 1;
    tablename = #"gamedata/stats/cp/statsmilestones" + var_c4e9517b + "<dev string:xae>";
    challengenamehash = tablelookupcolumnforrow(tablename, row, 5);

    if(challengenamehash === #"challenge/empty_string") {
      return;
    }

    challengestring = makelocalizedstring(challengenamehash);
    challengetier = int(tablelookupcolumnforrow(tablename, row, 1));
    matchrecordlogchallengecomplete(self, var_c4e9517b, challengetier, itemindex, challengenamehash);
    challengetiernext = int(tablelookupcolumnforrow(tablename, row + 1, 1));
    tiertext = challengetier + 1;
    var_33b913f5 = "<dev string:xb6>";

    if(challengetype == 0) {
      var_33b913f5 = "<dev string:xc1>";
    } else if(challengetype == 1) {
      iteminfo = getunlockableiteminfofromindex(itemindex, 1);

      if(isDefined(iteminfo)) {
        var_33b913f5 = makelocalizedstring(iteminfo.displayname);
      }
    }

    if(issubstr(challengestring, "<dev string:xcb>")) {
      if(challengetype == 3) {
        challengestring = strreplace(challengestring, "<dev string:xcb>", "<dev string:xd2>" + function_60394171(#"challenge", 3, itemindex));
      }
    }

    if(issubstr(challengestring, "<dev string:xd7>")) {
      challengestring = strreplace(challengestring, "<dev string:xd7>", "<dev string:xd2>" + tiertext);
    }

    msg = var_33b913f5 + "<dev string:xde>" + challengestring + "<dev string:xe5>" + maxval;

    if(getdvarint(#"debugchallenges", 0) == 1) {
      iprintlnbold(msg);
    } else if(getdvarint(#"debugchallenges", 0) == 2) {
      self iprintlnbold(msg);
    } else if(getdvarint(#"debugchallenges", 0) == 3) {
      iprintln(msg);
    }

    println(msg);
  }
}

function function_18b65152() {
  if(sessionmodeisonlinegame()) {
    return;
  }

  var_80b995df = self stats::get_stat(#"playerstatslist", #"cp_challenges", #"statvalue");

  if(var_80b995df > 0) {
    var_e1617d73 = tablelookuprowcount(#"gamedata/stats/cp/statsmilestones1.csv");
    challenge_data = [];

    for(i = 0; i < var_e1617d73 - 1; i++) {
      challenge_data = tablelookuprow(#"gamedata/stats/cp/statsmilestones1.csv", i);
      var_2a9d0df5 = challenge_data[3];

      if(var_2a9d0df5 == "global") {
        challenge_stat_name = challenge_data[4];

        if(isDefined(challenge_stat_name) && challenge_stat_name != "") {
          var_85321896 = self stats::get_stat(#"playerstatslist", challenge_stat_name, #"statvalue");

          if(challenge_data[10] != "") {
            var_a15c6663 = int(challenge_data[2]);

            if(var_85321896 >= var_a15c6663) {
              var_f220a4fb = "";
              var_f220a4fb = challenge_data[16];

              switch (var_f220a4fb) {
                case #"missions":
                  self stats::function_dad108fa(#"conf_gamemode_mastery", 1);
                  break;
                case #"tott":
                  self stats::function_dad108fa(#"hq_gamemode_mastery", 1);
                  break;
                case #"career":
                  self stats::function_dad108fa(#"career_mastery", 1);
                  break;
              }
            }
          }
        }
      }
    }

    self stats::set_stat(#"playerstatslist", #"cp_challenges", #"statvalue", 0);
  }
}

function function_6d4abfcd(n_time) {
  self endon(#"disconnect");
  wait n_time;
  self thread util::screen_message_delete_client();
}

function function_ba92458e() {
  while(true) {
    if(getdvarint(#"scr_complete_all_challenges", 0) == 1) {
      self function_1b7d307e();
      setDvar(#"scr_complete_all_challenges", 0);
    }

    wait 0.1;
  }
}

function function_1b7d307e() {
  challenge_array = [];
  array::add(challenge_array, "<dev string:xf9>");
  array::add(challenge_array, "<dev string:x10d>");
  array::add(challenge_array, "<dev string:x121>");
  array::add(challenge_array, "<dev string:x135>");
  array::add(challenge_array, "<dev string:x149>");
  array::add(challenge_array, "<dev string:x15d>");
  array::add(challenge_array, "<dev string:x171>");
  array::add(challenge_array, "<dev string:x185>");
  array::add(challenge_array, "<dev string:x199>");
  array::add(challenge_array, "<dev string:x1ad>");
  array::add(challenge_array, "<dev string:x1c1>");
  array::add(challenge_array, "<dev string:x1d5>");
  array::add(challenge_array, "<dev string:x1ee>");
  array::add(challenge_array, "<dev string:x202>");
  array::add(challenge_array, "<dev string:x213>");
  array::add(challenge_array, "<dev string:x22a>");
  array::add(challenge_array, "<dev string:x244>");
  array::add(challenge_array, "<dev string:x25d>");
  array::add(challenge_array, "<dev string:x277>");
  array::add(challenge_array, "<dev string:x28e>");

  foreach(challenge in challenge_array) {
    self stats::function_dad108fa(challenge, 1000);
    iprintln("<dev string:x2aa>" + challenge);
    wait 1;
  }
}