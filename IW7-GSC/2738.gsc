/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2738.gsc
**************************************/

init() {
  level.var_77C0 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp\gesturetable.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }
    var_2 = tablelookupbyrow("mp\gesturetable.csv", var_0, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }
    level.var_77C0[var_1] = var_2;
    var_0++;
  }

  level.rockpaperscissors = ["ges_plyr_gesture043", "ges_plyr_gesture114", "ges_plyr_gesture115"];
}

getgesturedata(var_0) {
  if(isbot(self) && var_0 == "devilhorns_mp") {
    var_0 = "gesture009";
  }

  return level.var_77C0[var_0];
}

func_41B2() {
  self notify("clearGesture");

  if(isDefined(self.gestureweapon) && self.gestureweapon != "none") {
    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      scripts\mp\utility\game::_setactionslot(3, "");
    } else {
      scripts\mp\utility\game::_setactionslot(7, "");
    }

    scripts\mp\utility\game::_takeweapon(self.gestureweapon);
    self.gestureweapon = "none";
  }
}

givegesture(var_0) {
  switch (var_0) {
    case "ges_plyr_gesture043":
      thread gesture_rockpaperscissorsthink();
      var_0 = gesture_pickrockpaperscissors();
      break;
    case "ges_plyr_gesture050":
      if(scripts\mp\utility\game::func_9D48("archetype_scout")) {
        var_1 = getbodymodel();

        if(!isDefined(var_1) || var_1 != "mp_synaptic_ethan_body" || haschangedarchetype()) {
          var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050_synaptic", "ges_plyr_gesture052_synaptic");
        } else {
          var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050", "ges_plyr_gesture052");
        }
      } else {
        var_2 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050", "ges_plyr_gesture052");
      }

      thread gesture_coinflipthink(var_2);
      var_0 = var_2;
      break;
    case "ges_plyr_gesture020":
      if(scripts\mp\utility\game::func_9D48("archetype_scout")) {
        var_1 = getbodymodel();

        if(!isDefined(var_1) || var_1 != "mp_synaptic_ethan_body" || haschangedarchetype()) {
          var_0 = "ges_plyr_gesture020_synaptic";
        }
      }

      break;
    case "ges_plyr_gesture046":
      if(scripts\mp\utility\game::func_9D48("archetype_scout")) {
        var_1 = getbodymodel();

        if(!isDefined(var_1) || var_1 != "mp_synaptic_ethan_body" || haschangedarchetype()) {
          var_0 = "ges_plyr_gesture046_synaptic";
        }
      }

      break;
    case "ges_plyr_gesture048":
      if(scripts\mp\utility\game::func_9D48("archetype_scout")) {
        var_1 = getbodymodel();

        if(!isDefined(var_1) || var_1 != "mp_synaptic_ethan_body" || haschangedarchetype()) {
          var_0 = "ges_plyr_gesture048_synaptic";
        }
      }

      break;
  }

  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    scripts\mp\utility\game::_setactionslot(3, "taunt");
  } else {
    scripts\mp\utility\game::_setactionslot(7, "taunt");
  }

  if(!level.console) {
    thread monitorgamepadswitch();
  }

  scripts\mp\utility\game::_giveweapon(var_0);
  self func_8541(var_0);
  self.gestureweapon = var_0;
  thread func_77A4();
}

monitorgamepadswitch() {
  self endon("clearGesture");
  self endon("disconnect");
  var_0 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    if(isDefined(self.var_55C9) && self.var_55C9 > 0) {
      wait 0.05;
      continue;
    }

    var_1 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_1 != var_0) {
      if(var_0) {
        scripts\mp\utility\game::_setactionslot(3, "");
        scripts\mp\utility\game::_setactionslot(7, "taunt");
      } else {
        scripts\mp\utility\game::_setactionslot(3, "taunt");
        scripts\mp\utility\game::_setactionslot(7, "");
      }
    }

    var_0 = var_1;
    wait 0.05;
  }
}

func_77A4() {
  self endon("clearGesture");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("offhand_pullback", var_0);

    if(self.gestureweapon == var_0) {
      self notify("used_cosmetic_gesture");
    }
  }
}

gesture_pickrockpaperscissors() {
  return level.rockpaperscissors[randomintrange(0, level.rockpaperscissors.size)];
}

gesture_rockpaperscissorsthink() {
  self endon("clearGesture");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("gesture_rockPaperScissorsThink()");
  self endon("gesture_rockPaperScissorsThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");
    var_0 = undefined;

    if(scripts\mp\utility\game::gameflag("prematch_done") && getdvarint("scr_test_rps", 0) == 0) {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_TOO_LATE");
      var_0 = 0;
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_START");
      var_0 = 1;
    }

    self waittill("offhand_fired");

    if(var_0) {
      thread gesture_playrockpaperscissors();
    }

    self waittill("offhand_end");
    thread gesture_resetrockpaperscissorsgesture();
  }
}

gesture_resetrockpaperscissorsgesture() {
  func_41B2();
  givegesture("ges_plyr_gesture043");
}

gesture_playrockpaperscissors() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("rockPaperScissorsFinished");
  self notify("gesture_playRockPaperScissors()");
  self endon("gesture_playRockPaperScissors()");
  var_0 = gesture_getrockpaperscissorsplayers();

  if(isDefined(var_0)) {
    var_1 = gesture_determinerockpaperscissorswinner(self, self.gestureweapon, var_0, var_0.rockpaperscissorschoice);

    if(isDefined(var_1)) {
      var_1[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_WIN");
      var_1 thread[[level.givemidmatchawardfunc]]("rock_paper_scissors_win");
      var_2 = scripts\engine\utility::ter_op(var_1 == self, var_0, self);
      var_2[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_LOSE");
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_DRAW");
      var_0[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_DRAW");
    }

    var_0 notify("rockPaperScissorsFinished");
    var_0.rockpaperscissorschoice = undefined;
    return;
  }

  self.rockpaperscissorschoice = self.gestureweapon;
  wait 3;
  self.rockpaperscissorschoice = undefined;
}

gesture_getrockpaperscissorsplayers() {
  var_0 = anglesToForward(self getplayerangles());

  foreach(var_2 in level.players) {
    if(!isDefined(var_2) || var_2 == self) {
      continue;
    }
    if(!isDefined(var_2.rockpaperscissorschoice)) {
      continue;
    }
    var_3 = var_2.origin - self.origin;
    var_3 = vectornormalize(var_3);
    var_4 = vectordot(var_3, var_0);

    if(var_4 < 0.707107) {
      continue;
    }
    var_5 = anglesToForward(var_2 getplayerangles());
    var_6 = var_3 * -1;
    var_7 = vectordot(var_6, var_5);

    if(var_7 < 0.707107) {
      continue;
    }
    return var_2;
  }
}

gesture_determinerockpaperscissorswinner(var_0, var_1, var_2, var_3) {
  if(var_1 == var_3) {
    return undefined;
  }

  switch (var_1) {
    case "ges_plyr_gesture043":
      return scripts\engine\utility::ter_op(var_3 == "ges_plyr_gesture114", var_2, var_0);
    case "ges_plyr_gesture114":
      return scripts\engine\utility::ter_op(var_3 == "ges_plyr_gesture115", var_2, var_0);
    case "ges_plyr_gesture115":
      return scripts\engine\utility::ter_op(var_3 == "ges_plyr_gesture043", var_2, var_0);
  }
}

gesture_coinflipthink(var_0) {
  self endon("clearGesture");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("gesture_coinFlipThink()");
  self endon("gesture_coinFlipThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");

    for(;;) {
      if(!self isgestureplaying(var_0)) {
        break;
      }
      scripts\engine\utility::waitframe();
    }

    thread gesture_resetcoinflipgesture();
  }
}

gesture_resetcoinflipgesture() {
  func_41B2();
  givegesture("ges_plyr_gesture050");
}

getbodymodel() {
  if(!isPlayer(self) || isai(self)) {
    return undefined;
  }

  var_0 = undefined;

  if(level.rankedmatch) {
    var_0 = self getrankedplayerdata("rankedloadouts", "squadMembers", "body");
  } else {
    var_0 = self getrankedplayerdata("privateloadouts", "squadMembers", "body");
  }

  return tablelookupbyrow("mp\cac\bodies.csv", var_0, 1);
}

haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo)) {
      return 1;
    }

    if(self.changedarchetypeinfo != self.lastarchetypeinfo) {
      return 1;
    }
  }

  return 0;
}

gestureaudioduringcountdown() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!scripts\mp\utility\game::gameflag("prematch_done")) {
    self waittill("offhand_pullback", var_0);

    if(self.gestureweapon == var_0) {
      self playsoundtoteam("gib_fullbody", self.team, self);
    }
  }
}