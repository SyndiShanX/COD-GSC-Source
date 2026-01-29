/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\270.gsc
**************************************/

main() {
  level._id_1C2B = 0;
  common_scripts\utility::flag_init("game_saving");
  common_scripts\utility::flag_init("can_save");
  common_scripts\utility::flag_set("can_save");
  common_scripts\utility::flag_init("disable_autosaves");

  if(!isDefined(level._id_1C2C)) {
    level._id_1C2C = [];

  }
  level._id_1C2D = ::_id_1C2D;
}

_id_1C2E() {
  return &"AUTOSAVE_AUTOSAVE";
}

_id_1C2F(var_0) {
  if(var_0 == 0) {
    var_1 = &"AUTOSAVE_GAME";
  } else {
    var_1 = &"AUTOSAVE_NOGAME";

  }
  return var_1;
}

_id_1C30() {
  level waittill("finished final intro screen fadein");

  if(level._id_16C9) {
    return;
  }
  if(maps\_arcademode::_id_09C5()) {
    return;
  }
  if(common_scripts\utility::flag("game_saving")) {
    return;
  }
  common_scripts\utility::flag_set("game_saving");
  var_0 = "levelshots / autosave / autosave_" + level.script + "start";
  savegame("levelstart", &"AUTOSAVE_LEVELSTART", var_0, 1);
  setdvar("ui_grenade_death", "0");
  common_scripts\utility::flag_clear("game_saving");
}

_id_1C31(var_0) {
  var_0 waittill("trigger");
  maps\_utility::_id_1C32();
}

_id_1C33(var_0) {
  var_0 waittill("trigger");
  maps\_utility::_id_1C34();
}

_id_1C35(var_0) {
  if(!isDefined(var_0._id_1C36)) {
    var_0._id_1C36 = 0;

  }
  _id_1C37(var_0);
}

_id_1C37(var_0) {
  var_1 = _id_1C2F(var_0._id_1C36);

  if(!isDefined(var_1)) {
    return;
  }
  var_0 waittill("trigger");
  var_2 = var_0._id_1C36;
  var_3 = "levelshots / autosave / autosave_" + level.script + var_2;
  _id_1C45(var_2, var_1, var_3);
  thread maps\_quotes::_id_18A8();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_1C38(var_0) {
  if(maps\_utility::_id_1C39()) {
    return;
  }
  var_0 waittill("trigger");

  if(isDefined(level._id_1C3A)) {
    if(![[level._id_1C3A]]()) {
      return;
    }
  }

  var_1 = var_0._id_1C3B;
  maps\_utility::_id_1425(var_1);
  var_0 delete();
}

_id_1C3C(var_0) {
  var_0 waittill("trigger");
}

_id_1C3D(var_0, var_1) {
  if(isDefined(var_1)) {
    return;
  }
  return;
}

_id_1C3E(var_0) {
  level endon("trying_new_autosave");
  level endon("autosave_complete");
  wait(var_0);
  common_scripts\utility::flag_clear("game_saving");
  level notify("autosave_timeout");
}

_id_1C3F() {
  var_0 = "levelshots / autosave / autosave_" + level.script + "start";
  savegame("levelstart", &"AUTOSAVE_LEVELSTART", var_0, 1);
  _id_1C59(0);
}

_id_1C40() {
  var_0 = "levelshots / autosave / autosave_" + level.script + "start";

  if(getdvarint("g_reloading") == 0) {
    savegame("levelstart", &"AUTOSAVE_LEVELSTART", var_0, 1);
    _id_1C59(0);
  }
}

_id_1C41(var_0) {
  if(isDefined(level._id_16C9) && level._id_16C9) {
    return;
  }
  if(common_scripts\utility::flag("game_saving")) {
    return 0;

  }
  if(maps\_arcademode::_id_09C5()) {
    return 0;

  }
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    var_2 = level.players[var_1];

    if(!isalive(var_2)) {
      return 0;
    }
  }

  var_3 = "save_now";
  var_4 = _id_1C2E();

  if(isDefined(var_0)) {
    var_5 = savegamenocommit(var_3, var_4, "$default", 1);
  } else {
    var_5 = savegamenocommit(var_3, var_4);

  }
  wait 0.05;

  if(issaverecentlyloaded()) {
    level._id_1C2B = gettime();
    return 0;
  }

  if(var_5 < 0) {
    return 0;

  }
  if(!_id_1C44()) {
    return 0;

  }
  common_scripts\utility::flag_set("game_saving");
  wait 2;
  common_scripts\utility::flag_clear("game_saving");

  if(!commitwouldbevalid(var_5)) {
    return 0;

  }
  if(_id_1C44()) {
    if(!isDefined(var_0)) {
      thread maps\_arcademode::_id_09D3();

    }
    _id_1C59(var_5);
    commitsave(var_5);
    setdvar("ui_grenade_death", "0");
  }

  return 1;
}

_id_1C42(var_0) {
  var_0 waittill("trigger");
  maps\_utility::_id_1C43();
}

_id_1C44() {
  if(!issavesuccessful()) {
    return 0;

  }
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(!var_1 _id_1C55()) {
      return 0;
    }
  }

  if(!common_scripts\utility::flag("can_save")) {
    return 0;

  }
  return 1;
}

_id_1C45(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(common_scripts\utility::flag("disable_autosaves")) {
    return 0;

  }
  level endon("nextmission");
  level.player endon("death");

  if(maps\_utility::_id_12C1()) {
    level._id_1337 endon("death");

  }
  level notify("trying_new_autosave");

  if(common_scripts\utility::flag("game_saving")) {
    return 0;

  }
  if(isDefined(level._id_195A)) {
    return 0;

  }
  var_6 = 1.25;
  var_7 = 1.25;

  if(isDefined(var_3) && var_3 < var_6 + var_7) {}

  if(!isDefined(var_5)) {
    var_5 = 0;

  }
  if(!isDefined(var_2)) {
    var_2 = "$default";

  }
  if(!isDefined(var_4)) {
    var_4 = 0;

  }
  common_scripts\utility::flag_set("game_saving");
  var_8 = _id_1C2E();
  var_9 = gettime();

  for(;;) {
    if(_id_1C49(undefined, var_4)) {
      var_10 = savegamenocommit(var_0, var_8, var_2, var_5);

      if(var_10 < 0) {
        break;
      }

      wait 0.05;

      if(issaverecentlyloaded()) {
        level._id_1C2B = gettime();
        break;
      }

      wait(var_6);

      if(_id_1C47()) {
        continue;
      }
      if(!_id_1C49(undefined, var_4)) {
        continue;
      }
      wait(var_7);

      if(!_id_1C48()) {
        continue;
      }
      if(isDefined(var_3)) {
        if(gettime() > var_9 + var_3 * 1000) {
          break;
        }
      }

      if(!common_scripts\utility::flag("can_save")) {
        break;
      }

      if(!commitwouldbevalid(var_10)) {
        common_scripts\utility::flag_clear("game_saving");
        return 0;
      }

      thread maps\_arcademode::_id_09D3();
      _id_1C59(var_10);
      commitsave(var_10);
      level._id_1C46 = gettime();
      setdvar("ui_grenade_death", "0");
      break;
    }

    wait 0.25;
  }

  common_scripts\utility::flag_clear("game_saving");
  return 1;
}

_id_1C47() {
  foreach(var_1 in level._id_1C2C) {
    if(![[var_1["func"]]]()) {
      _id_1C3D("autosave failed: " + var_1["msg"]);
      return 1;
    }
  }

  return 0;
}

_id_1C48() {
  return _id_1C49(0, 0);
}

_id_1C49(var_0, var_1) {
  if(isDefined(level._id_1C4A)) {
    return [[level._id_1C4A]]();

  }
  if(isDefined(level._id_1C4B) && ![[level._id_1C4B]]()) {
    return 0;

  }
  if(level._id_16C9) {
    return 0;

  }
  if(maps\_arcademode::_id_09C5()) {
    return 0;

  }
  if(!isDefined(var_0)) {
    var_0 = level._id_1C4C;

  }
  if(!isDefined(var_1)) {
    var_1 = 0;

  }
  if(var_1) {
    if(![[level._id_1C4D["_autosave_stealthcheck"]]]()) {
      return 0;
    }
  }

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(!var_3 _id_1C55()) {
      return 0;

    }
    if(var_0 && !var_3 _id_1C54()) {
      return 0;
    }
  }

  if(level._id_1C4E) {
    if(!_id_1C56(var_0)) {
      return 0;
    }
  }

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(!var_3 _id_1C51(var_0)) {
      return 0;
    }
  }

  if(isDefined(level._id_1C4F) && !level._id_1C4F) {
    return 0;

  }
  if(isDefined(level._id_1C50) && !level._id_1C50) {
    return 0;

  }
  if(!issavesuccessful()) {
    _id_1C3D("autosave failed: save call was unsuccessful");
    return 0;
  }

  return 1;
}

_id_1C51(var_0) {
  if(isDefined(level._id_1C52) && level._id_1C52 == self) {
    return 1;

  }
  if(self ismeleeing() && var_0) {
    _id_1C3D("autosave failed:player is meleeing");
    return 0;
  }

  if(self isthrowinggrenade() && var_0) {
    _id_1C3D("autosave failed:player is throwing a grenade");
    return 0;
  }

  if(self isfiring() && var_0) {
    _id_1C3D("autosave failed:player is firing");
    return 0;
  }

  if(isDefined(self._id_1C53) && self._id_1C53) {
    _id_1C3D("autosave failed:player is in shellshock");
    return 0;
  }

  if(common_scripts\utility::isflashed()) {
    _id_1C3D("autosave failed:player is flashbanged");
    return 0;
  }

  return 1;
}

_id_1C54() {
  if(isDefined(level._id_1C52) && level._id_1C52 == self) {
    return 1;

  }
  var_0 = self getweaponslistprimaries();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = self getfractionmaxammo(var_0[var_1]);

    if(var_2 > 0.1) {
      return 1;
    }
  }

  _id_1C3D("autosave failed: ammo too low");
  return 0;
}

_id_1C55() {
  if(isDefined(level._id_1C52) && level._id_1C52 == self) {
    return 1;

  }
  if(maps\_utility::_id_133C("laststand_downed") && maps\_utility::_id_1008("laststand_downed")) {
    return 0;

  }
  var_0 = self.health / self.maxhealth;

  if(var_0 < 0.5) {
    return 0;

  }
  if(common_scripts\utility::flag("_radiation_poisoning")) {
    return 0;

  }
  if(maps\_utility::_id_1008("player_has_red_flashing_overlay")) {
    return 0;

  }
  return 1;
}

_id_1C56(var_0) {
  if(isDefined(level._id_1C52) && level._id_1C52 == self) {
    return 1;

  }
  var_1 = getaispeciesarray("bad_guys", "all");

  foreach(var_3 in var_1) {
    if(!isDefined(var_3.enemy)) {
      continue;
    }
    if(!isplayer(var_3.enemy)) {
      continue;
    }
    if(var_3.type == "dog") {
      foreach(var_5 in level.players) {
        if(distance(var_3.origin, var_5.origin) < 384) {
          return 0;
        }
      }

      continue;
    }

    if(isDefined(var_3._id_100C) && isDefined(var_3._id_100C.target) && isplayer(var_3._id_100C.target)) {
      return 0;

    }
    var_7 = [[level._id_1C2D]](var_3);

    if(var_7 == "return_even_if_low_accuracy") {
      return 0;

    }
    if(var_3.finalaccuracy < 0.021 && var_3.finalaccuracy > -1) {
      continue;
    }
    if(var_7 == "return") {
      return 0;

    }
    if(var_7 == "none") {
      continue;
    }
    if(var_3.a._id_0AA7 > gettime() - 500) {
      if(var_0 || var_3 animscripts\utility::_id_0CE3(0) && var_3 canshootenemy(0)) {
        return 0;
      }
    }

    if(isDefined(var_3.a._id_0F78) && var_3 animscripts\utility::_id_0CE3(0) && var_3 canshootenemy(0)) {
      return 0;
    }
  }

  if(maps\_utility::_id_1C57()) {
    return 0;

  }
  var_9 = getEntArray("destructible", "classname");

  foreach(var_11 in var_9) {
    if(!isDefined(var_11.healthdrain)) {
      continue;
    }
    foreach(var_5 in level.players) {
      if(distance(var_11.origin, var_5.origin) < 400) {
        return 0;
      }
    }
  }

  return 1;
}

_id_1C58() {
  if(self.finalaccuracy >= 0.021) {
    return 1;

  }
  foreach(var_1 in level.players) {
    if(distance(self.origin, var_1.origin) < 500) {
      return 1;
    }
  }

  return 0;
}

_id_1C2D(var_0) {
  foreach(var_2 in level.players) {
    var_3 = distance(var_0.origin, var_2.origin);

    if(var_3 < 200) {
      return "return_even_if_low_accuracy";
    } else if(var_3 < 360) {
      return "return";
    } else if(var_3 < 1000) {
      return "threat_exists";
    }
  }

  return "none";
}

_id_1C59(var_0) {
  if(!maps\_utility::_id_1451()) {
    return;
  }
  var_1 = maps\_utility_code::_id_1454();
  var_2 = var_1;

  if(isDefined(level._id_1C5A)) {
    var_2 = var_1 - level._id_1C5A;

  }
  level._id_1C5A = var_1;
  reconevent("script_checkpoint: id %d, leveltime %d, deltatime %d", var_0, var_1, var_2);
}