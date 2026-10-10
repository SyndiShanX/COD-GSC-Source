/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\shared\death.gsc
***********************************************/

#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\death;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace death;

function function_7f42b3806988f8db(asmname, statename, params) {
  stop_sounds();
  self stoplookat();

  if(isDefined(self.fnasm_clearfingerposes)) {
    self[[self.fnasm_clearfingerposes]]();
  }

  if(isDefined(self.fnachievements)) {
    self thread[[self.fnachievements]]();
  }

  self.disabledeathorient = !(isDefined(self.a) && istrue(self.a.nodeath)) || istrue(self.noragdoll);

  if(isDefined(self.a) && istrue(self.a.nodeath)) {
    deathcleanup();
    return;
  }

  bexplosivedamage = utility::wasdamagedbyexplosive();

  if(!isDefined(self.skipdeathanim)) {
    self aiclearanim(asm_getroot(), 0.3);
  }

  if(isDefined(self.asm.deathfunc)) {
    self[[self.asm.deathfunc]]();

    if(!isDefined(self.deathfunction)) {
      deathcleanup();
      return;
    }
  }

  if(isDefined(self.deathfunction)) {
    result = self[[self.deathfunction]]();

    if(!isDefined(result)) {
      result = 1;
    }

    if(result) {
      deathcleanup();
      return;
    }
  }

  if(isDefined(self.ragdoll_immediate) || self.forceragdollimmediate) {
    if(isagent(self)) {
      return;
    }

    if(isDefined(self.doantigravgrenaderagdoll) && self.doantigravgrenaderagdoll) {
      self animmode("noclip");
    } else if(istrue(self.nogravityragdoll)) {
      self animmode("nogravity");
    } else {
      self animmode("gravity");
    }

    doimmediateragdolldeath();

    if(!isDefined(self)) {
      return;
    }
  }

  self endon("entitydeleted");
  deathanimdata = undefined;
  deathanim = undefined;
  deathxanim = undefined;
  assertex(isDefined(self.deathalias) && isDefined(self.deathstate) || !isDefined(self.deathalias) && !isDefined(self.deathstate), "<dev string:x1c>");
  var_4d3cebad4e3e8617 = isDefined(self.deathalias) && isDefined(self.deathstate);

  if(!isDefined(self.skipdeathanim) || istrue(self.var_aa0214e1292a7b3)) {
    deathanimdata = function_ea379d7359bd10ae(asmname, statename, params);
    assert(isDefined(deathanimdata) && deathanimdata.size == 2);
    deathanim = deathanimdata[0];
    deathxanim = deathanimdata[1];
    self.deathanimduration = int(getanimlength(deathxanim) * 1000);
    directional_orient = isDefined(params) && params == "directional_orient";

    if(istrue(self.disabledeathdirectionalorient)) {
      directional_orient = 0;
    }

    if(isnumber(deathanim)) {
      if(var_4d3cebad4e3e8617) {
        self aisetanim(self.deathstate, deathanim);
      } else {
        self aisetanim(statename, deathanim);
      }
    } else {
      assertex(utility::issp(), "<dev string:x64>");
      bodyknob = asm_getinnerrootknob();
      self clearanim(bodyknob, 0.05);
      self setflaggedanimknoballrestart(statename, deathanim, bodyknob, 1, 0.05);
    }

    if(var_4d3cebad4e3e8617) {
      asm_playfacialanim(asmname, self.deathstate, deathxanim);
    } else {
      asm_playfacialanim(asmname, statename, deathxanim);
    }
  }

  if(isDefined(self.deathanimmode)) {
    self animmode(self.deathanimmode);
  }

  if(isDefined(self.skipdeathanim)) {
    assertex(self.skipdeathanim, "<dev string:x8f>");

    if(!isDefined(self.noragdoll)) {
      if(isDefined(self.fnpreragdoll)) {
        self[[self.fnpreragdoll]]();
      }

      if(!isDefined(self)) {
        return;
      }

      self startragdoll();
    }

    if(!isagent(self)) {
      wait 0.05;

      if(!isDefined(self)) {
        return;
      }

      self animmode("gravity");
    }
  } else if(isDefined(self.ragdolltime)) {
    thread waitforragdoll(self.ragdolltime);
  } else if(getdvarint(@ "hash_8c30a87f78a7d97e") == 1) {
    thread startragdollwithoutwait();
  } else {
    if(!isDefined(deathanimdata)) {
      deathanimdata = function_ea379d7359bd10ae(asmname, statename, params);
    }

    assert(isDefined(deathanimdata) && deathanimdata.size == 2);
    deathanim = deathanimdata[0];
    deathxanim = deathanimdata[1];
    ragdollnotetracks = getnotetracktimes(deathxanim, "start_ragdoll");
    var_73afa09bae81352a = !var_4d3cebad4e3e8617 && !isDefined(self.deathanim) && (ragdollnotetracks.size == 0 || ragdollnotetracks[0] > 0.5);

    if(var_73afa09bae81352a) {
      if(self.damagemod == "MOD_MELEE") {
        ragdollscaler = 0.7;
      } else {
        ragdollscaler = 0.35;
      }

      thread waitforragdoll(getanimlength(deathxanim) * ragdollscaler);
    }
  }

  self endon("terminate_death_thread");

  if(!isagent(self)) {
    if(isDefined(self.skipdeathanim) && !istrue(self.var_aa0214e1292a7b3)) {
      wait 0.05;
    } else {
      notestatename = statename;

      if(var_4d3cebad4e3e8617) {
        notestatename = self.deathstate;
      }

      asm_donotetracks(asmname, notestatename, &deathnotetracks);
    }
  }

  if(!isDefined(self)) {
    return;
  }

  self notify("endPlayDeathAnim");

  if(!isagent(self)) {
    if(isDefined(self.ragdoll_immediate) || self.forceragdollimmediate) {
      wait 0.5;

      if(!isDefined(self)) {
        return;
      }

      self aisetanimrate(asm_getroot(), 0);
    }
  }

  deathcleanup();
}

function deathnotetracks(note) {
  scripts\anim\notetracks::notetrack_prefix_handler(note);
}

function function_ea379d7359bd10ae(asmname, statename, params) {
  assertex(isDefined(self.deathalias) && isDefined(self.deathstate) || !isDefined(self.deathalias) && !isDefined(self.deathstate), "<dev string:x1c>");
  var_4d3cebad4e3e8617 = isDefined(self.deathalias) && isDefined(self.deathstate);

  if(isDefined(self.deathanim)) {
    deathanim = self.deathanim;
    deathxanim = asm_getxanim(statename, deathanim);
  } else if(var_4d3cebad4e3e8617) {
    deathanim = asm_lookupanimfromalias(self.deathstate, self.deathalias);
    deathxanim = asm_getxanim(self.deathstate, deathanim);
  } else {
    deathanim = asm_getanim(asmname, statename, params);
    deathxanim = asm_getxanim(statename, deathanim);
  }

  return [deathanim, deathxanim];
}

function stop_sounds() {
  self stopsoundchannel("voice_bchatter_1_3d");
  self stopsoundchannel("voice_air_3d");
  disabledefaultfacialanims(0);
  self stoploopsound();
}

function deathcleanup() {
  if(istrue(self.skipdeathcleanup)) {
    return;
  }

  scripts\asm\asm_bb::bb_clearmeleetarget();
  self notify("terminate_ai_threads");

  if(isagent(self)) {
    return;
  }

  numattempts = 3;

  while(isDefined(self) && self.script != "death" && numattempts > 0) {
    numattempts--;
    wait 0.05;
  }

  self notify("killanimscript");
}

function doimmediateragdolldeath() {
  if(isDefined(self.weapon)) {
    scripts\anim\shared::dropallaiweapons();
  }

  self.skipdeathanim = 1;

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.vehicle_idling)) {
    return;
  }

  initialimpulse = 10;
  damagetype = utility::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && self.attacker == level.player && damagetype == "melee") {
    initialimpulse = 5;
  }

  damagetaken = self.damagetaken;

  if(damagetype == "bullet" || isDefined(self.damagemod) && self.damagemod == "MOD_FIRE") {
    damagetaken = min(damagetaken, 300);
  } else {
    damagetaken = min(damagetaken, 5000);
  }

  damagescale = initialimpulse * damagetaken;

  if(isDefined(self.var_1447d8fee27482b0)) {
    vector = self.var_1447d8fee27482b0;
  } else {
    directionup = min(0.3, self.damagedir[2]);
    vector = (self.damagedir[0], self.damagedir[1], directionup);
  }

  if(isDefined(self.var_9deba7456a84f2cb)) {
    vector *= self.var_9deba7456a84f2cb;
  } else {
    vector *= damagescale;
  }

  if(self.forceragdollimmediate) {
    vector += self.prevanimdelta * 20 * 10;
  }

  damagelocation = self.damagelocation;

  if(damagelocation == "none") {
    damagelocation = "torso_upper";
  }

  self startragdollfromimpact(damagelocation, vector);
  waitframe();
}

function waitforragdoll(time) {
  wait time;

  if(!isDefined(self)) {
    return;
  }

  if(isagent(self)) {
    return;
  }

  if(isDefined(self) && isDefined(self.weapon)) {
    scripts\anim\shared::dropallaiweapons();
  }

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(isDefined(self) && !istrue(self.noragdoll)) {
    self startragdoll();
  }
}

function startragdollwithoutwait() {
  if(isagent(self)) {
    return;
  }

  if(isDefined(self) && isDefined(self.weapon)) {
    scripts\anim\shared::dropallaiweapons();
  }

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(isDefined(self) && !isDefined(self.noragdoll)) {
    self startragdoll();
  }
}