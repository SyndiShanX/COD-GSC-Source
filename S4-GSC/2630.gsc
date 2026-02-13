/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2630.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("guard_dog", ::_id_FE51);
}

_id_D795() {
  var_0 = scripts\engine\utility::ter_op(scripts\mp\utility\game::isholidayenabled(2), "actor_s4_mp_guard_dog_codmas", "actor_s4_mp_guard_dog");
  level._id_11EF[var_0] = level._id_11EF["player"];
  level._id_11EF[var_0]["spawn"] = _id_0A3E::_id_E119;
  level._id_11EF[var_0]["on_killed"] = _id_0A3E::_id_AA44;
  level._id_11EF[var_0]["on_damaged"] = _id_0016::_id_AA45;
  level._id_11EF[var_0]["on_damaged_finished"] = _id_0A3E::_id_AA50;
  level._id_11EF[var_0]["think"] = _id_0B00::main;
}

_id_F779(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_0, self);
  return _id_FE51(var_1);
}

_id_FE51(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(!_id_0A3E::_id_B3D5("guard_dog", var_0)) {
    return 0;
  }

  if(istrue(level.usedogbeingcalled)) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/TOO_MANY_DOGS");
    return 0;
  }

  level.usedogbeingcalled = 1;
  var_1 = _id_09EF::_id_6E33(1);

  if(!isDefined(var_1)) {
    level.usedogbeingcalled = 0;
    return 0;
  }

  var_2 = scripts\engine\utility::getstructarray("org_dog_spawn", "targetname");
  var_3 = _id_0015::_id_3B84(scripts\engine\utility::ter_op(scripts\mp\utility\game::isholidayenabled(2), "actor_s4_mp_guard_dog_codmas", "actor_s4_mp_guard_dog"), self.team);

  if(!isDefined(var_3)) {
    level.usedogbeingcalled = 0;
    return 0;
  }

  if(isDefined(var_2) && var_2.size > 0) {
    var_4 = _func_0204(var_2, self.origin);
    var_5 = var_4[0];
    var_6 = var_5.origin;
    var_7 = var_5.angles;
  } else {
    var_6 = var_1.origin;
    var_7 = vectortoangles(self.origin - var_1.origin);
  }

  var_3._id_4CEE = "guard_dog";

  if(!_id_0A3E::_id_B5F9(var_0)) {
    level.usedogbeingcalled = 0;
    return 0;
  }

  var_3 scripts\mp\utility\killstreak::_id_1155(var_0.streakname, "Killstreak_Ground", var_0.owner, 0, 0);
  _id_0A3E::_id_D1E1("guard_dog", 1);
  var_3 _id_09EF::_id_D136(self.team, self);
  var_3 thread[[var_3 _id_09EF::_id_1215("spawn")]](var_6, var_7, self, scripts\engine\utility::ter_op(scripts\mp\utility\game::isholidayenabled(2), "actor_s4_mp_guard_dog_codmas", "actor_s4_mp_guard_dog"));
  var_3.streakinfo = var_0;
  thread _id_9552(var_3, var_0);
  var_3 thread displaypatherrormessage();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_guard_dog", var_0.owner);
  }

  level.usedogbeingcalled = 0;
  return 1;
}

_id_9552(var_0, var_1) {
  level endon("game_ended");
  var_0 waittill("death");
  _id_0A3E::_id_D1E1("guard_dog", 0);
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_1);
}

displaypatherrormessage() {
  level endon("game_ended");
  self endon("death");
  self.streakinfo.owner endon("disconnect");
  var_0 = 0;
  var_1 = 10;
  var_2 = var_1 * 20;

  for(;;) {
    var_3 = scripts\engine\utility::_id_10897("displayPathErrorMessageOwner", "displayPathErrorMessageTarget");

    if(var_0 == 0) {
      if(isDefined(var_3)) {
        if(var_3 == "displayPathErrorMessageOwner") {
          self.streakinfo.owner scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/DOG_CANT_PATH_OWNER");
        } else {
          self.streakinfo.owner scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/DOG_CANT_PATH_TARGET");
        }
      }
    }

    while(var_0 < var_2) {
      waitframe();
      var_0++;
    }

    var_0 = 0;
  }
}