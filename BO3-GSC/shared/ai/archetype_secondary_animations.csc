/********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_secondary_animations.csc
********************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using_animtree("generic");
#namespace archetype_secondary_animations;

function autoexec main() {
  if(sessionmodeiszombiesgame() && getdvarint("splitscreen_playerCount") > 2) {
    return;
  }
  ai::add_archetype_spawn_function("human", & secondaryanimationsinit);
  ai::add_archetype_spawn_function("zombie", & secondaryanimationsinit);
  ai::add_ai_spawn_function( & on_entity_spawn);
}

function private secondaryanimationsinit(localclientnum) {
  if(!isDefined(level.__facialanimationslist)) {
    buildandvalidatefacialanimationlist(localclientnum);
  }
  self callback::on_shutdown( & on_entity_shutdown);
  self thread secondaryfacialanimationthink(localclientnum);
}

function private on_entity_spawn(localclientnum) {
  if(self hasdobj(localclientnum)) {
    self clearanim( % generic::faces, 0);
  }
  self._currentfacestate = "inactive";
}

function private on_entity_shutdown(localclientnum) {
  if(isDefined(self)) {
    self notify("stopfacialthread");
    if(isDefined(self.facialdeathanimstarted) && self.facialdeathanimstarted) {
      return;
    }
    self applydeathanim(localclientnum);
    self.facialdeathanimstarted = 1;
  }
}

function buildandvalidatefacialanimationlist(localclientnum) {
  assert(!isDefined(level.__facialanimationslist));
  level.__facialanimationslist = [];
  level.__facialanimationslist["human"] = [];
  level.__facialanimationslist["human"]["combat"] = array("ai_face_male_generic_idle_1", "ai_face_male_generic_idle_2", "ai_face_male_generic_idle_3");
  level.__facialanimationslist["human"]["combat_aim"] = array("ai_face_male_aim_idle_1", "ai_face_male_aim_idle_2", "ai_face_male_aim_idle_3");
  level.__facialanimationslist["human"]["combat_shoot"] = array("ai_face_male_aim_fire_1", "ai_face_male_aim_fire_2", "ai_face_male_aim_fire_3");
  level.__facialanimationslist["human"]["death"] = array("ai_face_male_death_1", "ai_face_male_death_2", "ai_face_male_death_3");
  level.__facialanimationslist["human"]["melee"] = array("ai_face_male_melee_1");
  level.__facialanimationslist["human"]["pain"] = array("ai_face_male_pain_1");
  level.__facialanimationslist["human"]["animscripted"] = array("ai_face_male_generic_idle_1");
  level.__facialanimationslist["zombie"] = [];
  level.__facialanimationslist["zombie"]["combat"] = array("ai_face_zombie_generic_idle_1");
  level.__facialanimationslist["zombie"]["combat_aim"] = array("ai_face_zombie_generic_idle_1");
  level.__facialanimationslist["zombie"]["combat_shoot"] = array("ai_face_zombie_generic_idle_1");
  level.__facialanimationslist["zombie"]["death"] = array("ai_face_zombie_generic_death_1");
  level.__facialanimationslist["zombie"]["melee"] = array("ai_face_zombie_generic_attack_1");
  level.__facialanimationslist["zombie"]["pain"] = array("ai_face_zombie_generic_pain_1");
  level.__facialanimationslist["zombie"]["animscripted"] = array("ai_face_zombie_generic_idle_1");
  deathanims = [];
  foreach(animation in level.__facialanimationslist["human"]["death"]) {
    array::add(deathanims, animation);
  }
  foreach(animation in level.__facialanimationslist["zombie"]["death"]) {
    array::add(deathanims, animation);
  }
  foreach(deathanim in deathanims) {
    assert(!isanimlooping(localclientnum, deathanim), ("" + deathanim) + "");
  }
}

function private getfacialanimoverride(localclientnum) {
  if(sessionmodeiscampaigngame()) {
    primarydeltaanim = self getprimarydeltaanim();
    if(isDefined(primarydeltaanim)) {
      primarydeltaanimlength = getanimlength(primarydeltaanim);
      notetracks = getnotetracksindelta(primarydeltaanim, 0, 1);
      foreach(notetrack in notetracks) {
        if(notetrack[1] == "facial_anim") {
          facialanim = notetrack[2];
          facialanimlength = getanimlength(facialanim);
          return facialanim;
        }
      }
    }
  }
  return undefined;
}

function private secondaryfacialanimationthink(localclientnum) {
  assert(isDefined(self.archetype) && (self.archetype == "" || self.archetype == ""));
  self endon("entityshutdown");
  self endon("stopfacialthread");
  self._currentfacestate = "inactive";
  while(true) {
    if(self.archetype == "human" && self clientfield::get("facial_dial")) {
      self._currentfacestate = "inactive";
      self clearcurrentfacialanim(localclientnum);
      wait(0.5);
      continue;
    }
    animoverride = self getfacialanimoverride(localclientnum);
    asmstatus = self asmgetstatus(localclientnum);
    forcenewanim = 0;
    switch (asmstatus) {
      case "asm_status_terminated": {
        return;
      }
      case "asm_status_inactive": {
        if(isDefined(animoverride)) {
          scriptedanim = self getprimarydeltaanim();
          if(isDefined(scriptedanim) && (!isDefined(self._scriptedanim) || self._scriptedanim != scriptedanim)) {
            self._scriptedanim = scriptedanim;
            forcenewanim = 1;
          }
          if(isDefined(animoverride) && animoverride !== self._currentfaceanim) {
            forcenewanim = 1;
          }
        } else {
          if(self._currentfacestate !== "death") {
            self._currentfacestate = "inactive";
            self clearcurrentfacialanim(localclientnum);
          }
          wait(0.5);
          continue;
        }
      }
    }
    closestplayer = arraygetclosest(self.origin, level.localplayers, getdvarint("ai_clientFacialCullDist", 2000));
    if(!isDefined(closestplayer)) {
      wait(0.5);
      continue;
    }
    if(!self hasdobj(localclientnum) || !self hasanimtree()) {
      wait(0.5);
      continue;
    }
    currfacestate = self._currentfacestate;
    currentasmstate = self asmgetcurrentstate(localclientnum);
    if(isDefined(currentasmstate)) {
      currentasmstate = tolower(currentasmstate);
    }
    if(self asmisterminating(localclientnum)) {
      nextfacestate = "death";
    } else {
      if(asmstatus == "asm_status_inactive") {
        nextfacestate = "animscripted";
      } else {
        if(isDefined(currentasmstate) && issubstr(currentasmstate, "pain")) {
          nextfacestate = "pain";
        } else {
          if(isDefined(currentasmstate) && issubstr(currentasmstate, "melee")) {
            nextfacestate = "melee";
          } else {
            if(self asmisshootlayeractive(localclientnum)) {
              nextfacestate = "combat_shoot";
            } else {
              if(self asmisaimlayeractive(localclientnum)) {
                nextfacestate = "combat_aim";
              } else {
                nextfacestate = "combat";
              }
            }
          }
        }
      }
    }
    if(currfacestate == "inactive" || currfacestate != nextfacestate || forcenewanim) {
      assert(isDefined(level.__facialanimationslist[self.archetype][nextfacestate]));
      clearoncompletion = 0;
      animtoplay = array::random(level.__facialanimationslist[self.archetype][nextfacestate]);
      if(isDefined(animoverride)) {
        animtoplay = animoverride;
        assert(nextfacestate != "" || !isanimlooping(localclientnum, animtoplay), ("" + animtoplay) + "");
      }
      applynewfaceanim(localclientnum, animtoplay, clearoncompletion);
      self._currentfacestate = nextfacestate;
    }
    if(self._currentfacestate == "death") {
      break;
    }
    wait(0.25);
  }
}

function private applynewfaceanim(localclientnum, animation, clearoncompletion = 0) {
  clearcurrentfacialanim(localclientnum);
  if(isDefined(animation)) {
    self._currentfaceanim = animation;
    if(self hasdobj(localclientnum) && self hasanimtree()) {
      self setflaggedanimknob("ai_secondary_facial_anim", animation, 1, 0.1, 1);
      if(clearoncompletion) {
        wait(getanimlength(animation));
        clearcurrentfacialanim(localclientnum);
      }
    }
  }
}

function private applydeathanim(localclientnum) {
  if(isDefined(self._currentfacestate) && self._currentfacestate == "death") {
    return;
  }
  if(getmigrationstatus(localclientnum)) {
    return;
  }
  if(isDefined(self) && isDefined(level.__facialanimationslist) && isDefined(level.__facialanimationslist[self.archetype]) && isDefined(level.__facialanimationslist[self.archetype]["death"])) {
    animtoplay = array::random(level.__facialanimationslist[self.archetype]["death"]);
    animoverride = self getfacialanimoverride(localclientnum);
    if(isDefined(animoverride)) {
      animtoplay = animoverride;
    }
    self._currentfacestate = "death";
    applynewfaceanim(localclientnum, animtoplay);
  }
}

function private clearcurrentfacialanim(localclientnum) {
  if(isDefined(self._currentfaceanim) && self hasdobj(localclientnum) && self hasanimtree()) {
    self clearanim(self._currentfaceanim, 0.2);
  }
  self._currentfaceanim = undefined;
}