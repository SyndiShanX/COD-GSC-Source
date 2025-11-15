/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2738.gsc
***************************************/

init() {
  level.func_77C0 = [];
  var_00 = 0;

  for(;;) {
    var_01 = tablelookupbyrow("mp\gesturetable.csv", var_00, 0);

    if(!isDefined(var_01) || var_01 == "") {
      break;
    }
    var_02 = tablelookupbyrow("mp\gesturetable.csv", var_00, 1);

    if(!isDefined(var_02) || var_02 == "") {
      break;
    }
    level.func_77C0[var_01] = var_02;
    var_0++;
  }

  level.rockpaperscissors = ["ges_plyr_gesture043", "ges_plyr_gesture114", "ges_plyr_gesture115"];
}

getgesturedata(var_00) {
  if(isbot(self) && var_00 == "devilhorns_mp")
    var_00 = "gesture009";

  return level.func_77C0[var_00];
}

func_41B2() {
  self notify("clearGesture");

  if(isDefined(self.gestureweapon) && self.gestureweapon != "none") {
    if(scripts\engine\utility::is_player_gamepad_enabled())
      scripts\mp\utility\game::_setactionslot(3, "");
    else
      scripts\mp\utility\game::_setactionslot(7, "");

    scripts\mp\utility\game::_takeweapon(self.gestureweapon);
    self.gestureweapon = "none";
  }
}

givegesture(var_00) {
  switch (var_00) {
    case "ges_plyr_gesture043":
      thread gesture_rockpaperscissorsthink();
      var_00 = gesture_pickrockpaperscissors();
      break;
    case "ges_plyr_gesture050":
      if(scripts\mp\utility\game::func_9D48("archetype_scout")) {
        var_01 = getbodymodel();

        if(!isDefined(var_01) || var_01 != "mp_synaptic_ethan_body" || haschangedarchetype())
          var_02 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050_synaptic", "ges_plyr_gesture052_synaptic");
        else
          var_02 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050", "ges_plyr_gesture052");
      } else
        var_02 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "ges_plyr_gesture050", "ges_plyr_gesture052");

      thread gesture_coinflipthink(var_02);
      var_00 = var_02;
      break;
    case "ges_plyr_gesture020":
      if(scripts\mp\utility\game::func_9D48("archetype_scout")) {
        var_01 = getbodymodel();

        if(!isDefined(var_01) || var_01 != "mp_synaptic_ethan_body" || haschangedarchetype())
          var_00 = "ges_plyr_gesture020_synaptic";
      }

      break;
    case "ges_plyr_gesture046":
      if(scripts\mp\utility\game::func_9D48("archetype_scout")) {
        var_01 = getbodymodel();

        if(!isDefined(var_01) || var_01 != "mp_synaptic_ethan_body" || haschangedarchetype())
          var_00 = "ges_plyr_gesture046_synaptic";
      }

      break;
    case "ges_plyr_gesture048":
      if(scripts\mp\utility\game::func_9D48("archetype_scout")) {
        var_01 = getbodymodel();

        if(!isDefined(var_01) || var_01 != "mp_synaptic_ethan_body" || haschangedarchetype())
          var_00 = "ges_plyr_gesture048_synaptic";
      }

      break;
  }

  if(scripts\engine\utility::is_player_gamepad_enabled())
    scripts\mp\utility\game::_setactionslot(3, "taunt");
  else
    scripts\mp\utility\game::_setactionslot(7, "taunt");

  if(!level.console)
    thread monitorgamepadswitch();

  scripts\mp\utility\game::_giveweapon(var_00);
  self _meth_8541(var_00);
  self.gestureweapon = var_00;
  thread func_77A4();
}

monitorgamepadswitch() {
  self endon("clearGesture");
  self endon("disconnect");
  var_00 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    if(isDefined(self.func_55C9) && self.func_55C9 > 0) {
      wait 0.05;
      continue;
    }

    var_01 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_01 != var_00) {
      if(var_00) {
        scripts\mp\utility\game::_setactionslot(3, "");
        scripts\mp\utility\game::_setactionslot(7, "taunt");
      } else {
        scripts\mp\utility\game::_setactionslot(3, "taunt");
        scripts\mp\utility\game::_setactionslot(7, "");
      }
    }

    var_00 = var_01;
    wait 0.05;
  }
}

func_77A4() {
  self endon("clearGesture");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("offhand_pullback", var_00);

    if(self.gestureweapon == var_00)
      self notify("used_cosmetic_gesture");
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
    var_00 = undefined;

    if(scripts\mp\utility\game::gameflag("prematch_done") && getdvarint("scr_test_rps", 0) == 0) {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_TOO_LATE");
      var_00 = 0;
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_START");
      var_00 = 1;
    }

    self waittill("offhand_fired");

    if(var_00)
      thread gesture_playrockpaperscissors();

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
  var_00 = gesture_getrockpaperscissorsplayers();

  if(isDefined(var_00)) {
    var_01 = gesture_determinerockpaperscissorswinner(self, self.gestureweapon, var_00, var_0.rockpaperscissorschoice);

    if(isDefined(var_01)) {
      var_01[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_WIN");
      var_01 thread[[level.givemidmatchawardfunc]]("rock_paper_scissors_win");
      var_02 = scripts\engine\utility::ter_op(var_01 == self, var_00, self);
      var_02[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_LOSE");
    } else {
      self[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_DRAW");
      var_00[[level.showerrormessagefunc]]("MP_INGAME_ONLY_RPS_DRAW");
    }

    var_00 notify("rockPaperScissorsFinished");
    var_0.rockpaperscissorschoice = undefined;
    return;
  }

  self.rockpaperscissorschoice = self.gestureweapon;
  wait 3;
  self.rockpaperscissorschoice = undefined;
}

gesture_getrockpaperscissorsplayers() {
  var_00 = anglesToForward(self getplayerangles());

  foreach(var_02 in level.players) {
    if(!isDefined(var_02) || var_02 == self) {
      continue;
    }
    if(!isDefined(var_2.rockpaperscissorschoice)) {
      continue;
    }
    var_03 = var_2.origin - self.origin;
    var_03 = vectornormalize(var_03);
    var_04 = vectordot(var_03, var_00);

    if(var_04 < 0.707107) {
      continue;
    }
    var_05 = anglesToForward(var_02 getplayerangles());
    var_06 = var_03 * -1;
    var_07 = vectordot(var_06, var_05);

    if(var_07 < 0.707107) {
      continue;
    }
    return var_02;
  }
}

gesture_determinerockpaperscissorswinner(var_00, var_01, var_02, var_03) {
  if(var_01 == var_03)
    return undefined;

  switch (var_01) {
    case "ges_plyr_gesture043":
      return scripts\engine\utility::ter_op(var_03 == "ges_plyr_gesture114", var_02, var_00);
    case "ges_plyr_gesture114":
      return scripts\engine\utility::ter_op(var_03 == "ges_plyr_gesture115", var_02, var_00);
    case "ges_plyr_gesture115":
      return scripts\engine\utility::ter_op(var_03 == "ges_plyr_gesture043", var_02, var_00);
  }
}

gesture_coinflipthink(var_00) {
  self endon("clearGesture");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("gesture_coinFlipThink()");
  self endon("gesture_coinFlipThink()");

  for(;;) {
    self waittill("used_cosmetic_gesture");

    for(;;) {
      if(!self isgestureplaying(var_00)) {
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
  if(!isplayer(self) || isai(self))
    return undefined;

  var_00 = undefined;

  if(level.rankedmatch)
    var_00 = self getrankedplayerdata("rankedloadouts", "squadMembers", "body");
  else
    var_00 = self getrankedplayerdata("privateloadouts", "squadMembers", "body");

  return tablelookupbyrow("mp\cac\bodies.csv", var_00, 1);
}

haschangedarchetype() {
  if(isDefined(self.changedarchetypeinfo)) {
    if(!isDefined(self.lastarchetypeinfo))
      return 1;

    if(self.changedarchetypeinfo != self.lastarchetypeinfo)
      return 1;
  }

  return 0;
}

gestureaudioduringcountdown() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!scripts\mp\utility\game::gameflag("prematch_done")) {
    self waittill("offhand_pullback", var_00);

    if(self.gestureweapon == var_00)
      self playsoundtoteam("gib_fullbody", self.team, self);
  }
}