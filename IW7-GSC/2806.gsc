/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2806.gsc
***************************************/

init() {}

func_F87E() {
  thread func_13A73();
}

func_12D44() {
  self notify("teleportUnset");

  if(self.loadoutarchetype == "archetype_assassin") {
    self setscriptablepartstate("teleporttrail", "neutral", 0);
  }

  self motionblurhqdisable();
  scripts\mp\utility\game::removedamagemodifier("teleport", 0);
}

func_10DFA(var_00, var_01) {
  self playanimscriptevent("power_active", "teleport");
  self setscriptablepartstate("teleporttrail", "active", 0);
  self motionblurhqenable();
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_ftl", undefined, 0.75);
  thread func_4524(0.5);
}

func_6391() {
  self playSound("ftl_teleport_npc_in");
  self playanimscriptevent("power_exit", "teleport");
  self setscriptablepartstate("teleporttrail", "neutral", 0);
  self motionblurhqdisable();
}

func_13A73() {
  self endon("disconnect");
  self endon("teleportUnset");
  self notify("watchForTeleport");
  self endon("watchForTeleport");

  for(;;) {
    var_00 = spawnStruct();
    childthread func_13A77(var_00);
    childthread func_13A75(var_00);
    childthread func_13A74(var_00);
    childthread func_13A76(var_00);
    self waittill("teleportBeginRace");
    waittillframeend;

    if(isDefined(var_0.func_6ACF)) {
      if(isplayer(self)) {
        scripts\mp\hud_message::showerrormessage("MP_TELEPORT_FAILED");
      }

      scripts\mp\supers::refundsuper();
    } else if(isDefined(var_0.func_10DE6) && isDefined(var_0.func_4E59))
      scripts\mp\supers::refundsuper();
    else if(isDefined(var_0.func_637B)) {
      self notify("teleport_success");
      func_6391();
    } else if(isDefined(var_0.func_10DE6)) {
      self notify("teleport_success");
      func_10DFA(var_0.startpos, var_0.func_6378);
    }

    self notify("teleportEndRace");
  }
}

func_13A77(var_00) {
  self endon("teleportEndRace");
  self waittill("teleportStart", var_01, var_02);
  var_0.func_10DE6 = 1;
  var_0.startpos = var_01;
  var_0.func_6378 = var_02;
  self notify("teleportBeginRace");
}

func_13A75(var_00) {
  self endon("teleportEndRace");
  self waittill("teleportEnd");
  var_0.func_637B = 1;
  self notify("teleportBeginRace");
}

func_13A74(var_00) {
  self endon("teleportEndRace");
  self waittill("death");
  var_0.func_4E59 = 1;
  self notify("teleportBeginRace");
}

func_13A76(var_00) {
  self endon("teleportEndRace");
  self waittill("teleportFailed");
  var_0.func_6ACF = 1;
  self notify("teleportBeginRace");
}

func_4524(var_00) {
  self endon("death");
  self endon("disconnect");
  scripts\mp\utility\game::giveperk("specialty_no_target");
  wait(var_00);
  scripts\mp\utility\game::removeperk("specialty_no_target");
}