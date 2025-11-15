/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_utility.gsc
*****************************************/

#include animscripts\anims;
#include animscripts\shared;
#include animscripts\utility;
#include common_scripts\utility;
#include animscripts\debug;
#include animscripts\cover_corner;
#include maps\_dds;
#include animscripts\weaponlist;
#include animscripts\combat;
#using_animtree("generic_human");

blindfire() {
  if(!animarrayanyexist("blind_fire")) {
    self animscripts\debug::debugpopstate(undefined, "no blind fire anim");

    return false;
  }

  blindfiremodes = [];
  blindfiremodes[blindfiremodes.size] = "blind_fire";

  if((self.a.script == "cover_left" || self.a.script == "cover_right" || self.a.script == "cover_pillar") && !aihasonlypistol()) {
    if(self.a.pose == "crouch" || self.a.pose == "stand" && self.a.script == "cover_pillar") {
      modes = self.covernode getvalidcoverpeekouts();

      if(isinarray(modes, "over") && animarrayanyexist("blind_over"))
        blindfiremodes[blindfiremodes.size] = "blind_over";
    }

    if(self.a.pose == "stand")
      animscripts\cover_corner::setstepoutanimspecial("blindfire");
  }

  blindfiremode = blindfiremodes[randomintrange(0, blindfiremodes.size)];

  if(self.a.script == "cover_stand" || self.a.script == "cover_crouch") {
    pitch = getshootpospitch(self.covernode.origin + getnodeoffset(self.covernode));

    if(pitch > 10) {
      self animscripts\debug::debugpopstate(undefined, "can't blind fire at a target below");

      return false;
    }
  }

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  self.a.cornermode = "blindfire";
  self.a.prevattack = self.a.cornermode;
  blindfireanim = animarraypickrandom(blindfiremode);
  self setflaggedanimknoballrestart(blindfiremode, blindfireanim, % body, 1, 0.2, 1);
  self animscripts\shared::updatelaserstatus(1, 1);

  if(canuseblindaiming(blindfiremode) && !aihasonlypistol()) {
    self thread startblindaiming(blindfireanim, blindfiremode);
    self thread stopblindaiming(blindfireanim, blindfiremode);
  } else
    stopblindaiming();

  self maps\_dds::dds_notify("react_cover", self.team == "allies");
  self animscripts\shared::donotetracks(blindfiremode);
  self.keepclaimednodeifvalid = 0;
  self animscripts\shared::updatelaserstatus(0);
  waittillframeend;
  return true;
}

canuseblindaiming(blindfiremode) {
  if(getdvarint(#"_id_5BDF0C62") == 1)
    return false;

  if(self.a.script == "cover_pillar" && blindfiremode == "blind_over")
    return false;

  blindfireaimexist = animarrayanyexist(blindfiremode + "_add_aim_up");

  if(blindfireaimexist && shootposoutsidelegalyawrange())
    return true;

  return false;
}

startblindaiming(aimanim, type) {
  self animscripts\shared::setaiminganims( % blind_aim_2, % blind_aim_4, % blind_aim_6, % blind_aim_8);
  self animscripts\shared::setanimaimweight(1, 0);

  if(animhasnotetrack(aimanim, "start_aim"))
    self waittillmatch(type, "start_aim");

  playadditiveaiminganims(type + "_add", 0.2);
  self animscripts\shared::trackloopstart();
}

getanimaimlimit(aimanim, defaultlimit) {
  if(!isDefined(defaultlimit))
    defaultlimit = 20;

  aimlimit = defaultlimit;
  notetracks = getnotetracksindelta(aimanim, 0, 1);

  foreach(note in notetracks) {
    assert(isDefined(note[1]));

    if(issubstr(note[1], "aim_limit")) {
      tokens = strtok(note[1], " ");

      if(isDefined(tokens) && tokens.size > 1) {
        aimlimit = tokens[1];
        break;
      }
    }
  }

  return int(aimlimit);
}

stopblindaiming(fireanim, animname) {
  self endon("death");
  self endon("killanimscript");

  if(isDefined(fireanim) && isDefined(animname)) {
    if(animhasnotetrack(fireanim, "stop_aim"))
      self waittillmatch(animname, "stop_aim");
    else
      self waittillmatch(animname, "end");
  }

  self animscripts\shared::stoptracking();
  self animscripts\shared::setanimaimweight(0, 0);
  self clearanim( % blind_aim_2, 0.2);
  self clearanim( % blind_aim_4, 0.2);
  self clearanim( % blind_aim_6, 0.2);
  self clearanim( % blind_aim_8, 0.2);
}

canblindfire() {
  if(self.a.atconcealmentnode)
    return false;

  if(self.weaponclass == "mg")
    return false;

  if(isDefined(self.disable_blindfire) && self.disable_blindfire == 1)
    return false;

  if(isDefined(self.node) && isDefined(self.node.script_dontblindfire))
    return false;

  if(!animscripts\weaponlist::usingautomaticweapon() && !usingpistol())
    return false;

  return true;
}

canrambo() {
  ramboanimsexist = animarrayanyexist("rambo");

  if(shouldforcebehavior("rambo"))
    return ramboanimsexist;

  if(self.team == "allies")
    return 0;

  if(isDefined(self.covernode.script_norambo) && self.covernode.script_norambo || isDefined(level.norambo))
    return 0;

  if(!animscripts\weaponlist::usingautomaticweapon())
    return 0;

  if(ramboanimsexist)
    return 1;

  return 0;
}

debugrambooutposition(rambooutpos) {
  if(getdvar(#"_id_7927E91F") != "1") {
    return;
  }
  self endon("death");

  for(i = 0; i < 600; i++)
    recordline(self.origin, rambooutpos, (1, 1, 1), "Animscript", self);
}

canswitchsides() {
  if(!self.a.atpillarnode)
    return false;

  if(self usingpistol())
    return false;

  return true;
}

turntomatchnodedirection(nodeangleoffset) {
  if(isDefined(self.node)) {
    node = self.node;
    absrelyaw = abs(angleclamp180(self.angles[1] - (node.angles[1] + nodeangleoffset)));

    if(self.a.pose == "stand" && node gethighestnodestance() != "stand") {
      if(absrelyaw > 45 && absrelyaw < 90)
        self orientmode("face angle", self.angles[1]);
      else
        self orientmode("face current");

      standtocrouchanim = animarray("stand_2_crouch", "combat");
      notetime = getnotetracktimes(standtocrouchanim, "anim_pose = \"crouch\"")[0];
      notetime = min(1, notetime * 1.1);
      time = notetime * getanimlength(standtocrouchanim) / 1.5;
      self setflaggedanimknoballrestart("crouchanim", standtocrouchanim, % body, 1, 0.2, 1.5);
      self donotetracksfortime(time, "crouchanim");
      self clearanim( % body, 0.2);
    }

    self orientmode("face angle", self.angles[1]);
    relyaw = angleclamp180(self.angles[1] - (node.angles[1] + nodeangleoffset));

    if(abs(relyaw) > 45) {
      self.turnthreshold = 45;
      self.turntomatchnode = 1;
      animscripts\combat::turntofacerelativeyaw(relyaw);
      self.turntomatchnode = 0;
    }
  }
}

getrandomcovermode(modes) {
  if(modes.size == 0)
    return undefined;

  if(modes.size == 1)
    return modes[0];

  if(isDefined(self.a.prevattack) && randomint(100) > 20) {
    foreach(i, mode in modes) {
      if(mode == self.a.prevattack) {
        if(i < modes.size - 1)
          modes[i] = modes[modes.size - 1];

        modes[modes.size - 1] = undefined;
        break;
      }
    }
  }

  return modes[randomint(modes.size)];
}

playadditiveaiminganims(prefix, transtime, defaultaimlimit) {
  aimupanim = animarray(prefix + "_aim_up");
  aimdownanim = animarray(prefix + "_aim_down");
  aimleftanim = animarray(prefix + "_aim_left");
  aimrightanim = animarray(prefix + "_aim_right");
  self.rightaimlimit = getanimaimlimit(aimrightanim, defaultaimlimit);
  self.leftaimlimit = getanimaimlimit(aimleftanim, defaultaimlimit) * -1;
  self.upaimlimit = getanimaimlimit(aimupanim, defaultaimlimit);
  self.downaimlimit = getanimaimlimit(aimdownanim, defaultaimlimit) * -1;
  self setanimknoblimited(aimupanim, 1, transtime);
  self setanimknoblimited(aimdownanim, 1, transtime);
  self setanimknoblimited(aimleftanim, 1, transtime);
  self setanimknoblimited(aimrightanim, 1, transtime);
}

getshootpospitch(frompos) {
  shootpos = getenemyeyepos();
  return angleclamp180(vectortoangles(shootpos - frompos)[0]);
}

resetanimspecial(delay) {
  self endon("killanimscript");

  if(isDefined(delay) && delay > 0)
    wait(delay);

  self.a.special = "none";
}

canthrowgrenade() {
  if(self.script_forcegrenade)
    return true;

  if(self.weapon == "mg42" || self.grenadeammo <= 0)
    return false;

  if(weaponisgasweapon(self.weapon))
    return false;

  return true;
}