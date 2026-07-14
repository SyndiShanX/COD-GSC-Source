/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\death.gsc
*****************************************/

#using script_16ea1b94f0f381b3;
#using scripts\anim\face;
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\death;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\pain;
#using scripts\asm\soldier\patrol;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace death;

function deathlmgcleanup() {
  if(!isDefined(self._blackboard.leftweaponent)) {
    return;
  }

  weaponent = self._blackboard.leftweaponent;
  weaponent delete();
  self._blackboard.leftweaponent = undefined;
  shared::forceuseweapon(self.primaryweapon, "\xe6\xaa6=\x93`Y");
}

function playdeathanim(asmname, statename, params) {
  stop_sounds();
  self stoplookat();

  if(isDefined(self.fnlaseroff)) {
    self[[self.fnlaseroff]]();
  }

  if(isDefined(self.fnasm_clearfingerposes)) {
    self[[self.fnasm_clearfingerposes]]();
  }

  if(isDefined(self.fnachievements)) {
    self thread[[self.fnachievements]]();
  }

  removeselffrom_squadlastseenenemypos(self.origin);

  if(isDefined(self.scriptedarrivalent)) {
    self.scriptedarrivalent delete();
  }

  function_b0f552e92806cf9e(function_ccfc34d7aa5f0b5a() - 1);
  function_793dfef0b5de69de(function_98a146c319cddc9a() - 1);
  deathlmgcleanup();
  self.disabledeathorient = !(istrue(self.a.nodeath) || istrue(self.noragdoll));

  if(istrue(self.a.nodeath)) {
    deathcleanup();
    return;
  }

  bexplosivedamage = utility::wasdamagedbyexplosive();

  if(shouldhelmetpopondeath(bexplosivedamage)) {
    helmetpop();
  }

  if(shouldheadpop(bexplosivedamage)) {
    headpop();
  }

  if(!isDefined(self.skipdeathanim)) {
    self aiclearanim(asm::asm_getroot(), 0.3);
  }

  playdeathsound(bexplosivedamage);

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
      if(istrue(self.bhasriotshieldattached)) {
        detachriotshield();
      }

      shared::dropallaiweapons();
      return;
    }

    if(isDefined(self.doantigravgrenaderagdoll) && self.doantigravgrenaderagdoll) {
      self animmode("b\xf21\xbc\xeb{");
    } else if(istrue(self.nogravityragdoll)) {
      self animmode("\r\x9e^\xe3\x88\xf7,\x1f\x15");
    } else {
      self animmode("\x1b\x9e\x86\xecr\x97\xa2");
    }

    doimmediateragdolldeath();

    if(!isDefined(self)) {
      return;
    }
  }

  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(shouldgib() && !self isragdoll()) {
    if(istrue(self.bhasriotshieldattached)) {
      detachriotshield();
    }

    shared::dropallaiweapons();
    dogib();

    if(isagent(self)) {
      self.nocorpse = 1;
    } else {
      self hide();

      if(!isagent(self)) {
        wait 0.1;
      }
    }

    if(isDefined(self)) {
      deathcleanup();

      if(!isagent(self)) {
        self delete();
      }
    }

    return;
  }

  if(isDefined(self.deathbysuffocation) && !isDefined(self.deathanim)) {
    ai::set_deathanim(getsuffocationdeathanim());
  }

  deathanimdata = undefined;
  deathanim = undefined;
  deathxanim = undefined;
  assert(isDefined(self.deathalias) && isDefined(self.deathstate) || !isDefined(self.deathalias) && !isDefined(self.deathstate), "<dev string:x24>");
  var_53a7fca981a201ae = isDefined(self.deathalias) && isDefined(self.deathstate);

  if(!isDefined(self.skipdeathanim) || istrue(self.diedintransition)) {
    deathanimdata = getdeathanimdata(asmname, statename, params);
    assert(isDefined(deathanimdata) && deathanimdata.size == 2);
    deathanim = deathanimdata[0];
    deathxanim = deathanimdata[1];

    if(!animhasnotetrack(deathxanim, "\xf7\xe8>`\xf4\x93q") && !animhasnotetrack(deathxanim, "3\xa5\x93V\xf5spNa\xe5")) {
      shared::dropallaiweapons();
    }

    if(animhasnotetrack(deathxanim, "\xf7\xe8>`\xf4\x93q")) {
      self._blackboard.awaitingdropgunnotetrack = 1;
    }

    if(istrue(self.bhasriotshieldattached)) {
      detachriotshield();
    }

    if(isDefined(self.asmflashlight) && self.asmflashlight) {
      patrol::detachflashlight();
    }

    handleburningtodeath(deathxanim);
    self.deathanimduration = int(getanimlength(deathxanim) * 1000);
    directional_orient = isDefined(params) && params == "O\xfem\xb1\xbd\x8a\x90%\x13\xf4\xcbLEuL\xcfcr";

    if(istrue(self.disabledeathdirectionalorient)) {
      directional_orient = 0;
    }

    orientmeleevictim(directional_orient);

    if(isnumber(deathanim)) {
      if(var_53a7fca981a201ae) {
        self aisetanim(self.deathstate, deathanim);
      } else {
        self aisetanim(statename, deathanim);
      }
    } else {
      assert(utility::issp(), "<dev string:x6c>");
      bodyknob = asm::asm_getinnerrootknob();
      self clearanim(bodyknob, 0.05);
      self setflaggedanimknoballrestart(statename, deathanim, bodyknob, 1, 0.05);
    }

    if(var_53a7fca981a201ae) {
      asm::asm_playfacialanim(asmname, self.deathstate, deathxanim);
    } else {
      asm::asm_playfacialanim(asmname, statename, deathxanim);
    }
  }

  if(isDefined(self.deathanimmode)) {
    self animmode(self.deathanimmode);
  }

  if(isDefined(self.skipdeathanim)) {
    assert(self.skipdeathanim, "<dev string:x97>");

    if(!isDefined(self.noragdoll)) {
      if(isDefined(self.fnpreragdoll)) {
        self[[self.fnpreragdoll]]();
      }

      if(!isDefined(self)) {
        return;
      }

      if(istrue(self.bhasriotshieldattached)) {
        detachriotshield();
      }

      shared::dropallaiweapons();

      if(istrue(self.nogravityragdoll)) {
        self animmode("\r\x9e^\xe3\x88\xf7,\x1f\x15");
      }

      self startragdoll();
    }

    if(!isagent(self)) {
      wait 0.05;

      if(!isDefined(self)) {
        return;
      }

      self animmode("\x1b\x9e\x86\xecr\x97\xa2");
    }
  } else if(isDefined(self.ragdolltime)) {
    thread waitforragdoll(self.ragdolltime);
  } else if(getdvarint(@ "hash_8c30a87f78a7d97e") == 1) {
    thread startragdollwithoutwait();
  } else {
    if(!isDefined(deathanimdata)) {
      deathanimdata = getdeathanimdata(asmname, statename, params);
    }

    assert(isDefined(deathanimdata) && deathanimdata.size == 2);
    deathanim = deathanimdata[0];
    deathxanim = deathanimdata[1];
    ragdollnotetracks = getnotetracktimes(deathxanim, "\x9c\xad\xad6p\xa2\xb3\xe3&\xafu\x93j");
    var_329778575c68f013 = !var_53a7fca981a201ae && !isDefined(self.deathanim) && (ragdollnotetracks.size == 0 || ragdollnotetracks[0] > 0.5);

    if(var_329778575c68f013) {
      if(self.damagemod == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
        ragdollscaler = 0.7;
      } else {
        ragdollscaler = 0.35;
      }

      thread waitforragdoll(getanimlength(deathxanim) * ragdollscaler);
    }
  }

  if(getDvar(@ "hash_27494f1d75fc0809") == "<dev string:xcf>") {
    if(animhasnotetrack(deathxanim, "<dev string:xd5>")) {
      return;
    }

    if(animhasnotetrack(deathxanim, "<dev string:xe7>")) {
      return;
    }

    println("<dev string:xf9>", deathxanim, "<dev string:x10d>");
    iprintlnbold("<dev string:x134>");
  }

  if(!isagent(self) && !isDefined(self.skipdeathanim)) {
    thread playdeathfx();
  }

  self endon("7\tH\xab\xd5LWm\xcf\xa0\xf2qu|\x84 (\x04$D\xd4\x12");

  if(!isagent(self)) {
    if(isDefined(self.skipdeathanim) && !istrue(self.diedintransition)) {
      wait 0.05;
    } else {
      notestatename = statename;

      if(var_53a7fca981a201ae) {
        notestatename = self.deathstate;
      }

      asm::asm_donotetracks(asmname, notestatename, &deathnotetrackhandler);
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.bhasriotshieldattached)) {
    detachriotshield();
  }

  shared::dropallaiweapons();
  self notify("\xf5\x9fkOR\x1dtKB7`\x99m\x0e9\xfc");

  if(!isagent(self)) {
    if(isDefined(self.ragdoll_immediate) || self.forceragdollimmediate) {
      wait 0.5;

      if(!isDefined(self)) {
        return;
      }

      self aisetanimrate(asm::asm_getroot(), 0);
    }
  }

  deathcleanup();
}

function deathnotetrackhandler(note) {
  if(self.burningtodeath) {
    switch (note) {
      case #"hash_9af1375f4b1b97b8":
        handleburndeathmodelswap();
        return;
      case #"hash_251b15537436bbcd":
        thread handleburndeathvfx();
        return;
    }
  }

  notetracks::notetrack_prefix_handler(note);
}

function handleburningtodeath(deathxanim) {
  if(isscriptedagent(self) && !isnullweapon(self.damageweapon) && self.unittype != "\xab\xbf\xbe\xe2\xcdvJ\x14/c" && utility::shouldburnfromdamage(self.damageweapon)) {
    self.burningtodeath = 1;
    thread handleburndeathvfx();
    return;
  }

  if(isscriptedagent(self) && self.unittype == "\xab\xbf\xbe\xe2\xcdvJ\x14/c") {
    return;
  }

  if(!self.burningtodeath) {
    return;
  }

  if(isscriptedagent(self)) {
    weaponname = "<dev string:x18c>";

    if(!isnullweapon(self.damageweapon)) {
      weaponname = self.damageweapon.basename;
    }

    assertmsg("<dev string:x199>" + weaponname);

    return;
  }

  if(self.unittype != "\xde\x9d\xa5" && (!isDefined(deathxanim) || !animhasnotetrack(deathxanim, "\xd6\xb7F\xac\xb1\xfa\xe6\xdda\xc1"))) {
    if(!isDefined(level.burnedmodeloverride)) {
      if(isDefined(self.headmodel)) {
        self detach(self.headmodel);
        self.headmodel = undefined;
      }

      if(isDefined(self.hatmodel)) {
        self detach(self.hatmodel);
        self.hatmodel = undefined;
      }

      gamemodebundle = getgamemodescriptbundle();

      if(isDefined(gamemodebundle)) {
        assert(isDefined(gamemodebundle.var_7e5b00e4c0690a66), "<dev string:x1fd>");
        self setModel(gamemodebundle.var_7e5b00e4c0690a66);
      }
    }

    if(!isDefined(deathxanim) || !animhasnotetrack(deathxanim, "\x053\xc2\xf5\xdd\xd7\xdb \xef\x1a\x1a@S\x0e\x0f\xc0\xde\x94A}")) {
      thread handleburndeathvfx();
    }
  }
}

function handleburndeathmodelswap() {
  if(isDefined(level.burnedmodeloverride)) {
    return;
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
    self.headmodel = undefined;
  }

  if(isDefined(self.hatmodel)) {
    self detach(self.hatmodel);
    self.hatmodel = undefined;
  }

  gamemodebundle = getgamemodescriptbundle();

  if(isDefined(gamemodebundle)) {
    assert(isDefined(gamemodebundle.var_7e5b00e4c0690a66), "<dev string:x1fd>");
    self setModel(gamemodebundle.var_7e5b00e4c0690a66);
  }
}

function handleburndeathvfx() {
  self endon("|M\xc0TF\t\xffq\xd5\xbe\x80\xeb\xe7");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  useontag = 1;

  if(self isscriptable()) {
    currentstate = self getscriptablepartstate("\xadt$xK8e\xd6\x0f5\x80\x1cHB\xf0\r<\x88\xc3h\xc8(e\x9f", 1);

    if(isDefined(currentstate)) {
      self setscriptablepartstate("\xadt$xK8e\xd6\x0f5\x80\x1cHB\xf0\r<\x88\xc3h\xc8(e\x9f", "\xe3\x93}=nD");
      useontag = 0;
    }
  }

  if(useontag) {
    burnvfxtagpackets = getburnvfxtagpackets();

    foreach(burnvfxpacket in burnvfxtagpackets) {
      if(!isDefined(self)) {
        return;
      }

      playFXOnTag(level.g_effect[burnvfxpacket.burnvfx], self, burnvfxpacket.tag);
      wait 0.05;
    }
  }
}

function getburnvfxtagpackets() {
  burnvfxpacket = [];
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("\xb0\xe1)\x0e\xbe\xf5\x9c\xed\xb4", "xn\xb66\x11\xf6\xdb/\xef#\xbb\x8d8\xa4Ix\x8d");
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("\xc1F\"to\x9c\xd8\x9c\x1c", "xn\xb66\x11\xf6\xdb/\xef#\xbb\x8d8\xa4Ix\x8d");
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("\x988\aD\x81\xa2]@S\x1ey\x14}", "\xbb(-(oj\xe6H\x7f\xa0\xdcl\x17*\xe2HM");
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("\x95\xa1x\x99\xfe\xa0k$\xf5\xaf\xe0\xe0\x85", "\xbb(-(oj\xe6H\x7f\xa0\xdcl\x17*\xe2HM");
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("$\x9b\xd1\xd1(A\x8c@f\x80\xf6\xfd", "\xbb(-(oj\xe6H\x7f\xa0\xdcl\x17*\xe2HM");
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("\x13'$\xc4\xf8l\x16\xdf", "M1\a\x10\xca\x95\x91\x9c\x15R\x9a@\x907\xd4\xc5\xbd");
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("\xcd\xb0\x81\xed\xf3/\r\xa5,H", "xn\xb66\x11\xf6\xdb/\xef#\xbb\x8d8\xa4Ix\x8d");
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("\x8e*\xf05\xc0\x01R\xbeu\x06", "xn\xb66\x11\xf6\xdb/\xef#\xbb\x8d8\xa4Ix\x8d");
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("\x96\xbd\x11i\xfb|\xe1G\x8f\xafQnO", "\xbb(-(oj\xe6H\x7f\xa0\xdcl\x17*\xe2HM");
  burnvfxpacket[burnvfxpacket.size] = createburnvfxpacket("\xealQ\x95\xc1qO\xba\x9a\xae\xd3\xd5G", "\xbb(-(oj\xe6H\x7f\xa0\xdcl\x17*\xe2HM");
  return burnvfxpacket;
}

function createburnvfxpacket(tag, burnvfx, smoldervfx) {
  packet = spawnStruct();
  packet.tag = tag;
  packet.burnvfx = burnvfx;
  return packet;
}

function detachriotshield(inexecution) {
  assert(istrue(self.bhasriotshieldattached));

  if(shoulddropriotshield()) {
    dropriotshield();
  }

  if(utility::issp()) {
    self detach(self.riotshieldmodel, self.riotshieldmodeltag);
  }

  self.bhasriotshieldattached = undefined;
}

function shoulddropriotshield() {
  if(istrue(self.shoulddropriotshield)) {
    return true;
  }

  return false;
}

function dropriotshield() {
  shieldorigin = self gettagorigin(self.riotshieldmodeltag);
  shieldangles = self gettagangles(self.riotshieldmodeltag);
  shield = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", shieldorigin);
  shield.angles = shieldangles;
  shield setModel(self.riotshieldmodel);
  shield physicslaunchserver(shieldorigin, anglesToForward(self.angles) * 5);
  shield thread deleteriotshield(10);
}

function dropriotshieldweapon() {
  shieldorigin = self gettagorigin(self.riotshieldmodeltag);
  shieldangles = self gettagangles(self.riotshieldmodeltag);
  strweap = "M\xb0\xf6t\xbd\xa2XA`\xa1\xdap\xa4c\x88)\v\xc4\xbb\x92";
  shield = spawn("r\x15U\xae\x95\xae\xc3" + strweap, shieldorigin);
  shield.angles = shieldangles;
}

function deleteriotshield(time) {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait time;
  self delete();
}

function c8deathsound(c8, notetrack) {
  prefix = getsubstr(notetrack, 0, 3);

  if(prefix == "\xca!\xcf") {
    alias = getsubstr(notetrack, 3);
    c8[[anim.callbacks["\xef\xd8A\xd8\xcf\x9f\xd5\bPoA\xcfs\xa9\xe7\xb3\xed\x92j\x84\xa5"]]](alias);
    return;
  }

  if(prefix != "w\xa7\x04") {
    return;
  }

  alias = getsubstr(notetrack, 3);

  if(!isDefined(c8.deathsoundent)) {
    c8.deathsoundent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", c8.origin);
    c8.deathsoundent.targetname = "gH\xc6v\xdd\xc6\x02\x88:/\xe9\x97";
    c8.deathsoundent linkTo(c8, "");
  }

  ent = c8.deathsoundent;
  ent notify("\x0f\x18\x9e[C\xc3]\x16\xc5\xcb\xd3\xa6\x9a\x9d\xb0\x86\x9a");
  ent endon("\x0f\x18\x9e[C\xc3]\x16\xc5\xcb\xd3\xa6\x9a\x9d\xb0\x86\x9a");
  ent playSound(alias);
  time = lookupsoundlength(alias);
  wait time * 0.001 + 0.1;
  ent delete();
}

function playexplosivedeathanim(asmname, statename, params) {
  if((utility::isdamageweapon(makeweapon("Zws\xfams-\x99\xb2\xd7\xd58;\xc9\v\x19\xb2\x98")) || utility::wasdamagedbyoffhandshield() || utility::isdamageweapon(makeweapon("\xd2\xee\xcd\xfa\xdc{\xdci\x8d"))) && isDefined(self.attacker)) {
    var_675290f1688b4cce = vectortoyaw(self.attacker.origin - self.origin);

    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", var_675290f1688b4cce);
    } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
      self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", var_675290f1688b4cce + 90);
    } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
      self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", var_675290f1688b4cce - 180);
    } else {
      self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", var_675290f1688b4cce - 90);
    }
  }

  playdeathanim(asmname, statename, params);
}

function playbalconydeathanim(asmname, statename, params) {
  function_e2e63f7c6bc05d44(gettime() + randomintrange(5000, 8000));
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self._blackboard.balconydeathnode.angles[1]);
  playdeathanim(asmname, statename, params);
}

function playdeathanim_melee_ragdolldelayed(asmname, statename, params) {
  var_e96f46dd0721a2b5 = isagent(self);

  if(!var_e96f46dd0721a2b5) {
    if(isDefined(self.meleestatename)) {
      time = params;

      if(!isDefined(time)) {
        time = 10;
      }

      asm::asm_donotetrackswithtimeout(asmname, self.meleestatename, time);
    }
  }

  shared::dropallaiweapons();

  if(istrue(self.bhasriotshieldattached)) {
    detachriotshield();
  }

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(!isDefined(self)) {
    return;
  }

  if(!var_e96f46dd0721a2b5) {
    self startragdoll();
    wait 0.1;
  }

  deathcleanup();
}

function chooseshockdeathanim(asmname, statename, tostatename, params) {
  return asm::asm_lookupanimfromalias(statename, "\x17\xad\v]\x18\x1b\f\x86");
}

function shouldplayshockdeath(asmname, statename, tostatename, params) {
  return utility::isshocked() || isDefined(self.shockdeath);
}

function shouldplayexplosivedeath(asmname, statename, tostatename, params) {
  if(self.unittype == "\xab\xbf\xbe\xe2\xcdvJ\x14/c") {
    return false;
  }

  if(istrue(self.forceexplosivedeath)) {
    self.forceexplosivedeath = 0;
    return true;
  }

  if(utility::wasdamagedbyexplosive()) {
    return true;
  }

  return false;
}

function function_ad7db8002f3f80a5(asmname, statename, tostatename, params) {
  if(istrue(self.var_f1fa4f95972e8e11)) {
    self.var_f1fa4f95972e8e11 = 0;
    return true;
  }

  if(isDefined(self.damagemod) && self.damagemod == "M\x81\xaf\xee\xc9\xcfD\xef\x91J") {
    if(isDefined(self.attacker) && istrue(self.attacker.istrainvehicle)) {
      return true;
    }
  }

  return false;
}

function function_b3e485dd6b472294(asmname, statename, params) {
  deathalias = "\r\xae\x11x\xec";

  if(self.currentpose == "\x8b\x90\xb5\xc4W") {
    deathalias += "Y\x044^.{";
  } else if(self.currentpose == "1x\xc5\xb4\xabx") {
    deathalias += "\xebl9\xde]l\xd0";
  }

  deathalias += pain::getpaindirectiontoactor();
  return asm::asm_lookupanimfromalias(statename, deathalias);
}

function function_ffba0e44b9fa4137(asmname, statename, params) {
  self.nodrop = 1;
  self.nocorpse = 1;
  self.noragdoll = 1;
  self.deathanimmode = "b\xf21\xbc\xeb{";
  playdeathanim(asmname, statename, params);
}

function shouldplayplayermeleedeath(asmname, statename, tostatename, params) {
  if(isDefined(self.damagemod) && isalive(self.attacker)) {
    if(!isPlayer(self.attacker)) {
      return false;
    }

    if(utility::getdamagetype(self.damagemod) != "mV\x8d+e") {
      return false;
    }

    return true;
  }

  return false;
}

function shouldplaybalconydeath(asmname, statename, tostatename, params) {
  if(self.currentpose == "GX\xa9]\x82") {
    return false;
  }

  if(!self.burningtodeath && utility::wasdamagedbyexplosive()) {
    return false;
  }

  if(gettime() < function_b59926c328eaa418() && !istrue(self.forcebalconydeath)) {
    return false;
  }

  node = undefined;

  if(isDefined(self.forcebalconydeathnode)) {
    node = self.forcebalconydeathnode;
  } else if(isDefined(self.covernode)) {
    node = self.covernode;
  } else if(isDefined(self._blackboard.lastusednode)) {
    node = self._blackboard.lastusednode;
  }

  if(!(isDefined(node) && isDefined(node.script_balcony))) {
    return false;
  }

  if(abs(angleclamp180(node.angles[1] - self.angles[1])) > 30) {
    return false;
  }

  if(isDefined(self.script_chance)) {
    if(randomfloat(1) > self.script_chance) {
      return false;
    }
  }

  if(self nearnode(node)) {
    self._blackboard.balconydeathnode = node;
    return true;
  }

  return false;
}

function shouldplaybalconyraildeath(asmname, statename, tostatename, params) {
  return self._blackboard.balconydeathnode.script_balcony == 1;
}

function choosebalconydeathanim(asmname, statename, tostatename, params) {
  return asm::asm_lookupanimfromalias(statename, self.currentpose);
}

function shouldplaystrongdamagedeath(asmname, statename, tostatename, params) {
  objweapon = self.damageweapon;

  if(!isDefined(objweapon) || isnullweapon(objweapon)) {
    return false;
  }

  if(utility::doinglongdeath()) {
    return false;
  }

  if(self.currentpose == "GX\xa9]\x82" || isDefined(self.a.onback)) {
    return false;
  }

  if(self.damagemod == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
    return false;
  }

  if(abs(self.damageyaw) < 45) {
    return false;
  }

  if(self.damagetaken > 500) {
    return true;
  }

  if(self.a.movement == "\x14+`" && !isattackerwithindist(self.attacker, 275)) {
    if(randomint(100) < 65) {
      return false;
    }
  }

  if(utility_common::issniperrifle(objweapon) && self.maxhealth < self.damagetaken) {
    return true;
  }

  if(utility_common::isshotgun(objweapon) && isattackerwithindist(self.attacker, 512)) {
    return true;
  }

  if(objweapon.basename == "\x01\xe6<RX\xabc\x16\xb9\x85^\xae\b\x9e" && utility::isweaponepic(objweapon)) {
    return true;
  }

  return false;
}

function c6_scriptablecleanup() {
  if(!isDefined(self)) {
    return;
  }

  self.bt.disabledismemberbehaviors = 1;

  if(isDefined(self.asm.bpreragdolled)) {
    return;
  }

  self.asm.bpreragdolled = 1;
  self.scriptablecleanup = 1;

  if(!isDefined(self._blackboard.scriptableparts)) {
    return;
  }

  foreach(part in self._blackboard.scriptableparts) {
    state = part.state;

    if(state == "+0a<s,") {
      continue;
    }

    if(issubstr(state, "2\xfb\x17\x9e\x1c")) {
      state = "\xe8X\x93J\xdf\x16\xe8\xc2";
    }

    self setscriptablepartstate(partname, state + "9Q\xde\xe58\xef\xa1");
  }

  self setscriptablepartstate("\xc4a*\xfd\x8a}L\xea\x9a\x0e\xb1G#\x0e\xb0\xb48", "+0a<s,");
}

function c8_scriptablecleanup() {
  self.bt.disabledismemberbehaviors = 1;

  if(isDefined(self.asm.bpreragdolled)) {
    return;
  }

  self.asm.bpreragdolled = 1;
  self.scriptablecleanup = 1;

  if(!isDefined(self._blackboard.scriptableparts)) {
    return;
  }

  foreach(partname, part in self._blackboard.scriptableparts) {
    if(issubstr(partname, "[PE\xcf3\xa0")) {
      self setscriptablepartstate(partname, "r\x90\x90\xed\x98\xf8");
    }
  }

  self setscriptablepartstate("\xc4a*\xfd\x8a}L\xea\x9a\x0e\xb1G#\x0e\xb0\xb48", "+0a<s,");
}

function choosemovingdeathanim(asmname, statename, params) {
  curspeed = length(self.velocity);
  archetype = self getbasearchetype();
  speedstring = getnearestspeedthresholdname(archetype, curspeed);
  movingdeathanims = [];
  return asm::asm_lookupanimfromalias(statename, speedstring);
}

function choosecrouchingdeathanim(asmname, statename, params) {
  if(utility::damagelocationisany("\x83\xe2\x11D", "\xcd\xca\xd8k")) {
    return asm::asm_lookupanimfromalias(statename, "\x83\xe2\x11D");
  }

  if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7", "]\x7fU\x15\xb1\xfa\xc9\x143g7", "DZKnO\xecT\\\xd23\x15\xf4\xfa6", "Wr\xcf\xaaD\xdb\xc0\xb8\xff5~\x187\xa5m", "\xcd\xca\xd8k")) {
    return asm::asm_lookupanimfromalias(statename, "p\x82\x8b\x888");
  }

  return asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
}

function choosecoverdeathanim(asmname, statename, params) {
  assert(isDefined(params), "<dev string:x239>" + statename);

  switch (params) {
    case #"hash_f1676baca0ae608b":
      return asm::asm_lookupanimfromalias(statename, "\x8b\x90\xb5\xc4W");
    case #"hash_a315be2e1164ff6b":
      return asm::asm_lookupanimfromalias(statename, "\xff\xd5d'hTb");
    case #"hash_9d76c99eddd14433":
      if(utility::damagelocationisany("\x83\xe2\x11D", "\xcd\xca\xd8k") && (self.damageyaw > 135 || self.damageyaw <= -45)) {
        return asm::asm_lookupanimfromalias(statename, "6L\xffni\b\x93\xe6\xaf\x01v");
      }

      if(self.damageyaw > -45 && self.damageyaw <= 45) {
        return asm::asm_lookupanimfromalias(statename, "\xd8Ir\xa9\xeao6\x06\xc7\x9d+");
      }

      return asm::asm_lookupanimfromalias(statename, "\xdf\xc3\xef\xedS\a\a=\x7f\f.\x1d+\xb4");
    case #"hash_175771022bc5e75d":
      if(self.currentpose == "\x8b\x90\xb5\xc4W") {
        return asm::asm_lookupanimfromalias(statename, "\xd9~\xd7\xad\xc04GW\x95\xf9\xf5");
      } else {
        if(utility::damagelocationisany("\x83\xe2\x11D", "\xcd\xca\xd8k")) {
          return asm::asm_lookupanimfromalias(statename, "#\xcc\xf7\xfcB\x12\xc35vq\x90(\xe5I\xf0\xa2\xf6");
        }

        return asm::asm_lookupanimfromalias(statename, "\xacZdCyU\xf4X\xad\x95i\x9f\x82\xa6\xda\xcc\xe0{\xacD");
      }
    case #"hash_4ddb655e251e06c8":
      if(self.currentpose == "\x8b\x90\xb5\xc4W") {
        return asm::asm_lookupanimfromalias(statename, "\xfa63zn\x15\xe8w\xf7\xfb");
      } else {
        return asm::asm_lookupanimfromalias(statename, "1\x84)\xdb\xcbTW_\xed\xb8b");
      }
    case #"hash_307cdefbc9ff53fa":
      return asm::asm_lookupanimfromalias(statename, "f\xc8");
  }

  assertmsg("<dev string:x265>");
}

function choosestandingdeathanim(asmname, statename, params) {
  if(utility_common::isusingsidearm()) {
    return choosestandingpistoldeathanim(asmname, statename, params);
  }

  if(isDefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker)) {
    return choosestandingmeleedeathanim(asmname, statename, params);
  }

  deathanims = [];

  if(utility::damagelocationisany("]\x7fU\x15\xb1\xfa\xc9\x143g7", "M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "!d\xbe\x12\x1f\x85\xdc\xf1:\xc5\xab\x9b\t5", "-\x10\xe9y\x90\x97\xd7\xd2\xc2F\x8d\xd8\x81\x99i", "-\x10\xe9y\x90\x97\xd7\xd2\xc2F\x8d\xd8\x81\x99i")) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "\xc6\xf6\xee\xac\x93\xbeL\xdbd\xcb");
  } else if(utility::damagelocationisany("\x83\xe2\x11D", "\xebe\xe3\x82S\x14")) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "\x83\xe2\x11D");
  } else if(utility::damagelocationisany("\xcd\xca\xd8k")) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "\xcd\xca\xd8k");
  } else if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7", "DZKnO\xecT\\\xd23\x15\xf4\xfa6")) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "J\x8c\x80\xc4\x0e\x96\xe7~~9jU\x05");
  }

  if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7")) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7");
  }

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    if(utility::damagelocationisany("\xcd\xca\xd8k", "\x83\xe2\x11D", "\xebe\xe3\x82S\x14")) {
      deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "\xf0\x9a\x9c$el\xcb");
    }

    if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7")) {
      deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "\xf0\x9a\x9c$el\xcb");
    }
  } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "\x8a+\xf04");
  }

  var_b299cac001754a05 = deathanims.size > 0;

  if(!var_b299cac001754a05 || randomint(100) < 15) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
  }

  if(randomint(100) < 10 && firingdeathallowed()) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "FY\x99X\xd5\xc6t_\xcc\x96\xe4i\xdc;");
  }

  assert(deathanims.size > 0);
  return deathanims[randomint(deathanims.size)];
}

function chooseexplosivedeathanim(asmname, statename, params) {
  ismolotov = 0;
  objweapon = self.damageweapon;

  if(!isnullweapon(objweapon) && self.unittype != "\xab\xbf\xbe\xe2\xcdvJ\x14/c" && utility::shouldburnfromdamage(objweapon)) {
    if(asm::asm_hasalias(statename, "B\x82\xb7\xb0\x0e/!75")) {
      ismolotov = 1;
    }
  }

  deathalias = undefined;

  if(ismolotov && self.currentpose == "GX\xa9]\x82") {
    deathalias = "\xad\xbd6\xde\x1d\xed\xd9\xf5\xe09o\xb9e";
  } else {
    deathalias = "g%\x0f\x95\xc3\xea\b\xae\xfd";

    if(ismolotov) {
      deathalias = "\xb6\xbdc\xf6Gov";
    }

    if(self.currentpose == "1x\xc5\xb4\xabx") {
      deathalias += "\xebl9\xde]l\xd0";
    } else if(self.currentpose == "GX\xa9]\x82") {
      deathalias += "\x9e\xf8\xb5\xb0xg";
    }

    deathalias += pain::getpaindirectiontoactor();
  }

  deathanim = asm::asm_lookupanimfromalias(statename, deathalias);

  if(ismolotov) {
    deathanim = preventrecentanimindex(self, statename, deathalias, deathanim);
  }

  deathxanim = asm::asm_getxanim(statename, deathanim);

  if(getDvar(@ "hash_f53ba58df3983a20", "\xb8\"") == "\xb8\"") {
    t = 1;
    ragdollnotetracks = getnotetracktimes(deathxanim, "\x9c\xad\xad6p\xa2\xb3\xe3&\xafu\x93j");

    if(ragdollnotetracks.size > 0) {
      t = ragdollnotetracks[0];
    }

    localdeltavector = getmovedelta(deathxanim, 0, t);
    endpoint = self localtoworldcoords(localdeltavector);
    can_move = 0;

    if(utility::actor_is3d()) {
      can_move = navtrace3d(self.origin, endpoint, 0);
    } else {
      can_move = self maymovefrompointtopoint(self.origin, endpoint, 0, 1);
    }

    if(!can_move) {
      if(ismolotov) {
        deathanim = asm::asm_lookupanimfromalias(statename, "P\x15l\xa6g\xf0\x18TQ|J\a\xef\xaa\xb9");
      } else {
        deathanim = asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
      }
    }
  }

  self.deathanimmode = "\r\x9e^\xe3\x88\xf7,\x1f\x15";
  return deathanim;
}

function choosestandingpistoldeathanim(asmname, statename, params) {
  if(abs(self.damageyaw) < 50) {
    return asm::asm_lookupanimfromalias(statename, "WyK\x0e\xa9q18");
  }

  deathanims = [];

  if(abs(self.damageyaw) < 110) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "WyK\x0e\xa9q18");
  }

  if(utility::damagelocationisany("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7", "]\x7fU\x15\xb1\xfa\xc9\x143g7", "M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "!d\xbe\x12\x1f\x85\xdc\xf1:\xc5\xab\x9b\t5", "\x11\xfa\xe7\x05\x0f\xfe\x84wW\xbbh\xc9\x82\xc6;", "-\x10\xe9y\x90\x97\xd7\xd2\xc2F\x8d\xd8\x81\x99i")) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "pisG\xbd\x8d\xaf\xe8\xed\xc9\xb9\xed_]\xc1\x0ee9");
  }

  if(!utility::damagelocationisany("\x83\xe2\x11D", "\xcd\xca\xd8k", "\xebe\xe3\x82S\x14", "\xcbcp\x97\x9e\xb3\x04\xd0\x9d", "#c'\x88\xfb\xd1W\xa7\xbd\xbb", "\xfa\xa3I)\xad\xea\xf0+n", "\xd1y|{;\xd4r4\fp", ">A\x84") && randomint(2) == 0) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, "\xdf\x04\xd2\xc2\x06\x80\x1a9\xef\xcfH\xbf\xbab%#\xfc");
  }

  if(deathanims.size == 0 || utility::damagelocationisany("]\x7fU\x15\xb1\xfa\xc9\x143g7", "\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7", "\xcd\xca\xd8k", "\x83\xe2\x11D", "\xebe\xe3\x82S\x14", "Wr\xcf\xaaD\xdb\xc0\xb8\xff5~\x187\xa5m", "DZKnO\xecT\\\xd23\x15\xf4\xfa6")) {
    deathanims[deathanims.size] = asm::asm_lookupanimfromalias(statename, ">\xe5KTXv$\xf2\x14\n}u(W");
  }

  assert(deathanims.size > 0);
  return deathanims[randomint(deathanims.size)];
}

function choosestandingmeleedeathanim(asmname, statename, params) {
  return asm::asm_lookupanimfromalias(statename, "\x91\xca\xcc\v\xab\xd8:");
}

function firingdeathallowed() {
  return false;
}

function playdeathfx() {
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");

  if(self.stairsstate != "\r+x5") {
    return;
  }

  wait 2;

  if(isDefined(self.noragdoll) && self.damagemod != "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
    play_blood_pool();
  }
}

function play_blood_pool(note, flagname) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.skipbloodpool)) {
    assert(self.skipbloodpool, "<dev string:x299>");
    return;
  }

  tagpos = self gettagorigin("\xb8y\xa4\x8fk\x05b\x02(U\xe7\xf3");
  tagangles = self gettagangles("\xb8y\xa4\x8fk\x05b\x02(U\xe7\xf3");
  forward = anglesToForward(tagangles);
  up = anglestoup(tagangles);
  right = anglestoright(tagangles);
  tagpos = tagpos + forward * -8.5 + up * 5 + right * 0;
  trace = trace::_bullet_trace(tagpos + (0, 0, 30), tagpos - (0, 0, 100), 0, undefined);

  if(trace["+0a<s,"][2] > 0.9) {
    playFX(level._effect["\xf0Q\xbcFz\x8a~i\x89D\xa0e\xc7O\xd0\x93\nf\xd0\xb7W\x9eiB "], tagpos);
  }
}

function shouldhelmetpoponpain(bexplosivedamage) {
  if(!istrue(self.shouldhelmetpop)) {
    return false;
  }

  if(isDefined(self.lastattacker.team) && isDefined(self.lastattacker) && isDefined(self.team) && self.lastattacker.team == self.team) {
    return false;
  }

  if(isDefined(self.helmetsubpart) && !bexplosivedamage) {
    return false;
  }

  if(isDefined(self.onlyhelmetpopondeath) && self.onlyhelmetpopondeath) {
    return false;
  }

  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield) {
    return false;
  }

  if(isDefined(self.damagelocation) && self.damagelocation == "\xebe\xe3\x82S\x14") {
    return true;
  }

  if(bexplosivedamage && randomint(2) == 0) {
    return true;
  }

  return false;
}

function shouldhelmetpopondeath(bexplosivedamage) {
  if(!istrue(self.shouldhelmetpop)) {
    return false;
  }

  if(self.unittype != "\xb9\xdb6d-\xb2\xc9" && self.unittype != "\xab\xbf\xbe\xe2\xcdvJ\x14/c") {
    return false;
  }

  if(self.damagemod == "\x13\x1e\xe31{\xb4\xf1\x85\x18" && randomint(3) < 2) {
    return false;
  }

  if(isDefined(self.damagelocation) && (self.damagelocation == "\xebe\xe3\x82S\x14" || self.damagelocation == "\x83\xe2\x11D")) {
    return true;
  }

  if(bexplosivedamage && randomint(3) == 0) {
    return true;
  }

  return false;
}

function helmetpop() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.hatmodel)) {
    return;
  }

  if(isDefined(self.dontbreakhelmet) && self.dontbreakhelmet) {
    return;
  }

  pos = self gettagorigin("\xa6\xeb\x1ae\x85#");

  if(isDefined(self.helmetshatterfx)) {
    forward = anglesToForward(self gettagangles("\xa6\xeb\x1ae\x85#"));
    playFX(self.helmetshatterfx, pos, forward);
  }

  playsoundatpos(pos, "\x839\xa9\xfa\x98\xae\x8d\x1b\xac\x1d\xafs\xd6\xc2\x1b\xc6\xf5\xcc\xb1e\xe6\x1a\xfa\re\x1bm\x95t\xf5\xdc\x0e\xc6");

  if(isDefined(self.helmetsubpart)) {
    self.helmetsubpart = undefined;
    damage = self getdamageparthealth("\xebe\xe3\x82S\x14", "\xebe\xe3\x82S\x14");

    if(damage > 0) {
      self damagedamagepart(damage, "\xebe\xe3\x82S\x14", "\xebe\xe3\x82S\x14");
    }
  }

  partname = getpartname(self.hatmodel, 0);
  model = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self.origin + (0, 0, 64));
  model setModel(self.hatmodel);
  model.origin = self gettagorigin(partname);
  model.angles = self gettagangles(partname);
  waitframe();

  if(isDefined(self.damagedir) && self.damagedir != (0, 0, 0)) {
    model thread helmetlaunch(self.damagedir);
  } else {
    model thread helmetlaunch((randomfloatrange(-0.25, 0.25), randomfloatrange(-0.25, 0.25), randomfloatrange(-1, 1)));
  }

  self detach(self.hatmodel, "");
  self.hatmodel = undefined;
  self hidepartandchildren_allinstances("\xf8\xe6^\xd1\x93\a.\xe3");

  if(isalive(self) && shouldplaysuffocatedeath()) {
    playFXOnTag(level.g_effect["e\x1c\x93\xa6\xa4\xf7\x84U\xf5-\xa7\xbcj/\\]U$\xaf\x94\xa0\xb7"], self, "\xa6\xeb\x1ae\x85#");

    if(self.asmname != "\xe4~\xf7\xd9Z+\xdd\xdf\x86.G-\xfb\xa4z\xa9_\xa5" && self.asmname != "\x17\xc4\x16zz%\xbe\xf1\xedeu\xb9") {
      self.deathbysuffocation = 1;
    }

    self kill();
  }
}

function helmetlaunch(damagedir) {
  launchforce = damagedir;
  launchforce *= randomfloatrange(2000, 4000);
  forcex = launchforce[0];
  forcey = launchforce[1];
  forcez = randomfloatrange(1500, 3000);
  contactpoint = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(contactpoint, (forcex, forcey, forcez));
  wait 60;

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(distancesquared(self.origin, level.player.origin) > 262144) {
      break;
    }

    wait 30;
  }

  self delete();
}

function getsuffocationdeathanim() {
  animation = undefined;

  if(randomint(11) >= 1) {
    return animation;
  }

  return animation;
}

function shouldplaysuffocatedeath() {
  return false;
}

function shouldheadpop(bexplosivedamage) {
  if(self.unittype != "\xb9\xdb6d-\xb2\xc9" && self.unittype != "\xab\xbf\xbe\xe2\xcdvJ\x14/c") {
    return false;
  }

  if(isDefined(self.forceheadpop)) {
    return true;
  }

  if(self.damagemod == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
    return false;
  }

  if(self.damagemod == "\b\x89z\xc1\xf1\xd4I\xf3") {
    return false;
  }

  objweapon = self.damageweapon;

  if(isnullweapon(objweapon)) {
    return false;
  }

  if(self.damagemod == "\xd4zD\xebP%\xe9IEC\x15R\x13*" && objweapon.classname == "w0\x8c@\x88d" && istrue(level.disableheadpopbyturret)) {
    return false;
  }

  return false;
}

function headpop() {
  if(!isDefined(self.headmodel)) {
    return;
  }

  playFXOnTag(level.g_effect["\x99\xdbrS\xcd\xf2\x8c\x85\xbd\xe8\x18j)\xa0"], self, "\xa6\xeb\x1ae\x85#");
  playFXOnTag(level.g_effect["\xc0v\xf7\xf5\x01&\xf3\x1c\xb1|aV}\x83\xf1\x99\x93z"], self, "\x13'$\xc4\xf8l\x16\xdf");
  self detach(self.headmodel, "");
  self.headmodel = undefined;
}

function cross2d(a, b) {
  return a[0] * b[1] - b[0] * a[1];
}

function meleegetattackercardinaldirection(vector2dtargetforward, var_ecba696bd40f1de3) {
  dot = vectordot(var_ecba696bd40f1de3, vector2dtargetforward);
  var_327b33423cd68729 = cos(60);

  if(squared(dot) < squared(var_327b33423cd68729)) {
    if(cross2d(vector2dtargetforward, var_ecba696bd40f1de3) > 0) {
      return 1;
    } else {
      return 3;
    }

    return;
  }

  if(dot < 0) {
    return 0;
  }

  return 2;
}

function orientmeleevictim(directional_orient) {
  knifeweapon = makeweapon("Zws\xfams-\x99\xb2\xd7\xd58;\xc9\v\x19\xb2\x98");
  sonicweapon = makeweapon("\xd2\xee\xcd\xfa\xdc{\xdci\x8d");

  if(utility::isdamageweapon(knifeweapon) || utility::isdamageweapon(sonicweapon)) {
    return;
  }

  if(directional_orient || self.damagemod == "\x13\x1e\xe31{\xb4\xf1\x85\x18" && isDefined(self.attacker) && !utility::wasdamagedbyoffhandshield() && !utility::isdamageweapon(sonicweapon)) {
    if(utility::actor_is3d()) {
      var_66bce344e48d873d = self.attacker.origin - self.origin;
      var_d62afa13bb5f47aa = generateaxisanglesfromforwardvector(var_66bce344e48d873d, self.angles);
      self orientmode("\x01\x9a \xdcwK\xd4\xd9\xc6\x1ci\xf7r", var_d62afa13bb5f47aa);
      return;
    }

    var_985e328b79ac1ae9 = self.damagedir;
    victimforward3d = anglesToForward(self.angles);
    var_91dfacb3a81e8f64 = vectorNormalize((var_985e328b79ac1ae9[0], var_985e328b79ac1ae9[1], 0));
    victimforward2d = vectorNormalize((victimforward3d[0], victimforward3d[1], 0));
    cardinaldirection = meleegetattackercardinaldirection(victimforward2d, var_91dfacb3a81e8f64);
    rotateyawamount = cardinaldirection * 90;
    var_f58e42f3df101198 = (-1 * var_91dfacb3a81e8f64[0], -1 * var_91dfacb3a81e8f64[1], 0);
    resultvector = rotatevector(var_f58e42f3df101198, (0, rotateyawamount, 0));
    targetyaw = vectortoyaw(resultvector);
    forward = anglesToForward((0, targetyaw, 0));
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", targetyaw);
  }
}

function function_435766927b2dafb5() {
  if(!isDefined(self.attacker.lastkillalertsoundtime) || gettime() > self.attacker.lastkillalertsoundtime + 700) {
    return false;
  }

  return true;
}

function function_236003f21a80ce97() {
  isbullet = isDefined(self.damageweapon) && weapontype(self.damageweapon) == "\xd7\xdb\xaaU\x82\xb0";

  if(isPlayer(self.attacker) && isbullet && !function_435766927b2dafb5()) {
    if(utility::damagelocationisany("\x83\xe2\x11D", "\xebe\xe3\x82S\x14")) {
      namespace_bc7cdace2d7445a5::playsoundtoplayersharedfunc("\xc6\xa8z\xa6\x9bP\xc4\x12\xee\xe7\b\x90\x85\x03r*\xc3y\x9d\x01Xb", level.player);
    } else {
      namespace_bc7cdace2d7445a5::playsoundtoplayersharedfunc("\xd6\x1c\xfa\xb5-\xd8\x1b\xeb,\xc6+\xc9\x8e", level.player);
    }

    self.attacker.lastkillalertsoundtime = gettime();
  }
}

function playdeathsound(bexplosivedamage) {
  if(utility::issp()) {
    function_236003f21a80ce97();
  }

  if(istrue(self.var_5061aef10be4384a)) {
    return;
  }

  if(isDefined(self.diequietly) && self.diequietly) {
    if(isDefined(self.attacker) && isPlayer(self.attacker) || isDefined(self.lastattacker) && isPlayer(self.lastattacker)) {
      dialoguetype = "\x17\xa1\v|\x82P\x1b'O+\xed";
    } else {
      return;
    }
  }

  if(shouldskipdeathsound()) {
    return;
  }

  if(isDefined(self.diequietly) && self.diequietly) {
    dialoguetype = "\x17\xa1\v|\x82P\x1b'O+\xed";
  } else {
    dialoguetype = "\x1e\xfd\xd1\xa2\a";
  }

  dmgammo = undefined;
  rootname = undefined;

  if(isDefined(self.damagemod) && self.damagemod == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
    if(isDefined(self.diequietly) && self.diequietly) {
      dialoguetype = "\x17\xa1\v|\x82P\x1b'O+\xed";
    } else {
      dialoguetype = "\x1e\xfd\xd1\xa2\a";
    }
  } else {
    if(isDefined(self.damageweapon) && !isnullweapon(self.damageweapon)) {
      dmgammo = getweaponammopoolname(self.damageweapon);
      rootname = getweaponrootstring(self.damageweapon);
    }

    if(bexplosivedamage) {
      if(isDefined(rootname) && rootname == "\xb6\xbdc\xf6Gov") {
        dialoguetype = "\xc5\xa7\xee\x04Sj:\xd0v\xff";
      } else {
        dialoguetype = "\x95\xf0\x0e\xd8\xb7\x8c\xb2a\xe84";
      }
    } else {
      if(isDefined(self._blackboard.balconydeathnode)) {
        dialoguetype = "]\x9dZ\xa2Rh\f\fb";
      }

      if(isDefined(dmgammo) && dmgammo == % "incendiary") {
        dialoguetype = "\xe7]\\:]\xdb\x1a\x85\xd8R";
      }
    }
  }

  face::saygenericdialogue(dialoguetype);
}

function shouldskipdeathsound() {
  if(!getdvarint(@ "hash_f133094f3b5288b6", 0) && utility::damagelocationisany("\x83\xe2\x11D", "\xebe\xe3\x82S\x14")) {
    if(isDefined(self.damageweapon) && !isnullweapon(self.damageweapon)) {
      if(self.damageweapon.classname == "\n\x1f+\x8dob") {
        return false;
      }

      if(getweaponrootstring(self.damageweapon) == "\xb6\xbdc\xf6Gov") {
        return false;
      }
    }

    return true;
  }

  return false;
}

function removeselffrom_squadlastseenenemypos(org) {
  for(i = 0; i < anim.squadindex.size; i++) {
    anim.squadindex[i] clearsightposnear(org);
  }
}

function clearsightposnear(org) {
  if(!isDefined(self.sightpos)) {
    return;
  }

  if(distance(org, self.sightpos) < 80) {
    self.sightpos = undefined;
    self.sighttime = gettime();
  }
}

function function_f4aeb5c86534e6f9(asmname, statename, params, dist) {
  if(isplayerwithindist(asmname, statename, params, dist)) {
    return true;
  }

  if(isactor(self) && self actorgetgroundslope() < 0.96) {
    return true;
  }

  return false;
}

function isplayerwithindist(asmname, statename, params, dist) {
  player = utility::getclosest(self.origin, level.players, dist);
  return isDefined(player);
}

function isattackerwithindist(attacker, maxdist) {
  if(!isDefined(attacker)) {
    return false;
  }

  if(distance(self.origin, attacker.origin) > maxdist) {
    return false;
  }

  return true;
}

function function_60f6bd75bea970d(asmname, statename, tostatename, params) {
  speed = self aigettargetspeed();

  if(speed >= 160) {
    return true;
  }

  return false;
}

function isspecialdeath(asmname, statename, tostatename, params) {
  if(utility::isshocked()) {
    return true;
  }

  return false;
}

function choosespecialdeath(asmname, statename, params) {
  if(utility::isshocked()) {
    return asm::asm_lookupanimfromalias(statename, "\x99\xea?\xc09iB\n\x13b\xda");
  }

  return asm::asm_lookupanimfromalias("{_\xa6,\x11\xbf\x9fa\x06\xef\xa2\x18\x0f", "\x91\xca\xcc\v\xab\xd8:");
}

function shouldgib() {
  if(!isdismembermentenabled()) {
    return false;
  }

  if(isDefined(self.nogib)) {
    return false;
  }

  if(self.unittype != "\xb9\xdb6d-\xb2\xc9" && self.unittype != "\xab\xbf\xbe\xe2\xcdvJ\x14/c" && self.unittype != "75\xffQ\x95\xfe`\x9a") {
    return false;
  }

  if(isDefined(self.damagemod) && self.damagemod == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
    return false;
  }

  if(isDefined(self.damagemod) && isexplosivedamagemod(self.damagemod)) {
    if(isDefined(self.lastattacker) && (self.lastattacker.asmname == "\xce\xe4\x15\xda\x967&F\xc34\xff5N" || self.lastattacker.asmname == "B83T\x18\xd5\xee\x1e@\xa1\x0e\r\xf03 \xe2")) {
      return true;
    }

    if(isDefined(self.damageweapon) && self.damageweapon.basename == "\x9e\xec:\xc7gk\xa6\xc2d_\xc1^") {
      return true;
    }
  }

  return false;
}

function dogibdefault(victim) {
  origin = victim gettagorigin("\x13'$\xc4\xf8l\x16\xdf");

  if(isDefined(victim.damagedir) && victim.damagedir != (0, 0, 0)) {
    playFX(level.g_effect["\xa1]ka\x9b\xebg\x96\x13_f]\x1b6b\xbd\xc8\xe5"], origin, victim.damagedir);
  } else {
    playFX(level.g_effect["\xa1]ka\x9b\xebg\x96\x13_f]\x1b6b\xbd\xc8\xe5"], origin, (1, 0, 0));
  }

  if(isagent(victim)) {
    victim playSound("\xfaH\xf1\xe6E\x16\xd1\xf74\xc1\x9c3");
    return;
  }

  ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", origin);
  ent.targetname = "\xe7B\xd5I\xef\x96\xf1\xceB\x9a\x17\xc7";
  ent playSound("\xfaH\xf1\xe6E\x16\xd1\xf74\xc1\x9c3", "\xdc\xf6\xba\xdcFF\xdb\xe6e");
  ent waittill("\xdc\xf6\xba\xdcFF\xdb\xe6e");
  wait 0.1;
  ent delete();
}

function dogib() {
  if(isDefined(self.gib_override_func)) {
    level thread[[self.gib_override_func]](self);
    return;
  }

  level thread dogibdefault(self);
}

function shouldplayshieldbashdeath(asmname, statename, tostatename, params) {
  objweapon = self.damageweapon;

  if(isDefined(objweapon)) {
    if(objweapon.type == "~mX\xce\xda2") {
      return true;
    }

    weaponname = objweapon.basename;

    if(weaponname == "\x1c\x95\x1a>p,\xe9\xcc\x9f\x12\xf8\x8d1:\x17\x98\\" || weaponname == "\xab\x0f\xbb\x89\xde\xb2\xe2q9\xfa?\x81+\x05u\xcb" || weaponname == "\x96\xbe\xb7d\xd9\xe6x\xbfo\x92\x9f\x80\x1fc\xe0Y<\xdb") {
      return true;
    }
  }

  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.unittype) && self.lastattacker.unittype == "YB" && isDefined(self.damagemod) && self.damagemod == "\x13\x1e\xe31{\xb4\xf1\x85\x18") {
    return true;
  }

  return false;
}

function doshieldbashdeath(asmname, statename, tostatename, params) {
  stop_sounds();
  shared::dropallaiweapons();
  impactdir = vectorNormalize(self.origin - level.player.origin + (0, 0, 30));
  objweapon = self.damageweapon;
  weaponname = objweapon.basename;

  if(weaponname == "\xab\x0f\xbb\x89\xde\xb2\xe2q9\xfa?\x81+\x05u\xcb" || weaponname == "\x96\xbe\xb7d\xd9\xe6x\xbfo\x92\x9f\x80\x1fc\xe0Y<\xdb") {
    impactdir = vectorNormalize(self.origin - level.player.origin + (0, 0, 30) + anglestoright(level.player.angles) * 50);
  }

  self setanimrate(asm::asm_getroot(), 0);

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(!isDefined(self)) {
    return;
  }

  self startragdollfromimpact("\x1e\x9c\x9f\xceLO\xc5\xe4\xf1\x9a\xb7", impactdir * 2400);

  if(isDefined(self.unittype) && self.unittype == "\xdf~") {
    self playSound("\x17a\xc2\xd5\xdd\xa3\xf6\xe5\xb0\xac\x82\xc9\xbb\xa6\xe3\x1c\xae");
  }

  level.player playrumblelooponentity("\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
  earthquake(0.5, 1, level.player.origin, 100);
  level.player utility::delaycall(0.25, &stoprumble, "\x8c\xc2[a\xec+_\xa1\xacX\xec\xe5");
  wait 1;
  deathcleanup();
}

function getpainbodypartdeath() {
  if(utility::damagelocationisany("\x83\xe2\x11D", "\xebe\xe3\x82S\x14", "\xcd\xca\xd8k")) {
    part = "\x83\xe2\x11D";
    return part;
  }

  if(utility::damagelocationisany("Wr\xcf\xaaD\xdb\xc0\xb8\xff5~\x187\xa5m", "\x15\x018#\xac\xddK8v\xdf$\x8f\xd7\xaf\xe9", "\xd1y|{;\xd4r4\fp")) {
    part = "\x9e\x8bjjn\x9d\x8e";
    return part;
  }

  if(utility::damagelocationisany("DZKnO\xecT\\\xd23\x15\xf4\xfa6", "\x80\x037^\vH5.\xed\t\xc4^\xcd\x0e", "\xfa\xa3I)\xad\xea\xf0+n")) {
    part = "\x9e\x8bjjn\x9d\x8e";
    return part;
  }

  if(utility::damagelocationisany("M\xde\x83\xb6\xcbT\xdb}bX~J\xa5[", "!d\xbe\x12\x1f\x85\xdc\xf1:\xc5\xab\x9b\t5", "\xcbcp\x97\x9e\xb3\x04\xd0\x9d")) {
    part = "<\b\xcf\xa2\xb5\rB$\xce%7";
    return part;
  }

  if(utility::damagelocationisany("\x11\xfa\xe7\x05\x0f\xfe\x84wW\xbbh\xc9\x82\xc6;", "-\x10\xe9y\x90\x97\xd7\xd2\xc2F\x8d\xd8\x81\x99i", "#c'\x88\xfb\xd1W\xa7\xbd\xbb")) {
    part = "\xf2\xb7\xc9yG5\x0e\x8f\xc0\bU";
    return part;
  }

  part = "\x9e\x8bjjn\x9d\x8e";
  return part;
}

function getpainbodypartcrouchdeath() {
  if(utility::damagelocationisany("\x83\xe2\x11D", "\xebe\xe3\x82S\x14", "\xcd\xca\xd8k")) {
    part = "\x83\xe2\x11D";
    return part;
  }

  part = "\x9e\x8bjjn\x9d\x8e";
  return part;
}

function choosedirectionaldeathanim(asmname, statename, params) {
  size = pain::getpainweaponsize();

  if(isDefined(self.var_fa6a6a1dbd4e91b0) && isDefined(self.var_74356351f3bd18fb) && isDefined(self.currentpose) && self.var_74356351f3bd18fb == "\xb8R\x8b}N\x19\xd6\xe0\xff" && self.var_fa6a6a1dbd4e91b0 == "\x97\xf4\xf1" && self.currentpose == "GX\xa9]\x82") {
    part = "\xb8R\x8b}N\x19\xd6\xe0\xff";
    size = "\x97\xf4\xf1";
  } else {
    part = getpainbodypartdeath();
    size = pain::getpainweaponsize();
  }

  victimforward3d = anglesToForward(self.angles);
  var_91dfacb3a81e8f64 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  victimforward2d = vectorNormalize((victimforward3d[0], victimforward3d[1], 0));
  cardinaldirection = meleegetattackercardinaldirection(victimforward2d, var_91dfacb3a81e8f64);
  deathdir = undefined;

  if(cardinaldirection == 2) {
    deathdir = "9G";
  } else if(cardinaldirection == 3) {
    deathdir = "\xa7~";
  } else if(cardinaldirection == 1) {
    deathdir = "}h";
  } else {
    deathdir = "\xbed";
  }

  if(shouldfireintoairdeath(statename, part)) {
    aliasdeath = "aD=\xf9\xcb|Yi={C\x97g";
  } else {
    aliasdeath = part + size + deathdir;
  }

  return asm::asm_lookupanimfromalias(statename, aliasdeath);
}

function choosedirectionalcrouchdeathanim(asmname, statename, params) {
  part = getpainbodypartcrouchdeath();
  size = pain::getpainweaponsize();
  victimforward3d = anglesToForward(self.angles);
  var_91dfacb3a81e8f64 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  victimforward2d = vectorNormalize((victimforward3d[0], victimforward3d[1], 0));
  cardinaldirection = meleegetattackercardinaldirection(victimforward2d, var_91dfacb3a81e8f64);
  deathdir = undefined;

  if(cardinaldirection == 2) {
    deathdir = "9G";
  } else if(cardinaldirection == 3) {
    deathdir = "\xa7~";
  } else if(cardinaldirection == 1) {
    deathdir = "}h";
  } else {
    deathdir = "\xbed";
  }

  if(shouldfireintoairdeath(statename, part)) {
    aliasdeath = "aD=\xf9\xcb|Yi={C\x97g";
  } else {
    aliasdeath = part + size + deathdir;
  }

  return asm::asm_lookupanimfromalias(statename, aliasdeath);
}

function shouldfireintoairdeath(statename, part) {
  weapclass = weaponclass(self.weapon);
  diequietly = istrue(self.diequietly) || weapclass == "\x03\xb0\xa1\xa9\x04\xac\x88\x82\x88\x18\xb6\xed\xe1\x82" || weapclass == "\n\x1f+\x8dob" || weapclass == "\x8e\xfcc\xbe\xdf\xa6";

  if(!asm::asm_hasalias(statename, "aD=\xf9\xcb|Yi={C\x97g")) {
    return false;
  }

  if(!self._blackboard.bfire) {
    return false;
  }

  if(diequietly) {
    return false;
  }

  if(part == "\xb8R\x8b}N\x19\xd6\xe0\xff") {
    return false;
  }

  if(part == "\x83\xe2\x11D") {
    chance = 0.3;
  } else {
    chance = 0.15;
  }

  return randomfloat(1) < chance;
}

function choosedirectionallargepaindeathanim(asmname, statename, params) {
  part = "\xb8R\x8b}N\x19\xd6\xe0\xff";
  size = "\x97\xf4\xf1";
  victimforward3d = anglesToForward(self.angles);
  var_91dfacb3a81e8f64 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  victimforward2d = vectorNormalize((victimforward3d[0], victimforward3d[1], 0));
  cardinaldirection = meleegetattackercardinaldirection(victimforward2d, var_91dfacb3a81e8f64);
  deathdir = undefined;

  if(cardinaldirection == 2) {
    deathdir = "9G";
  } else if(cardinaldirection == 3) {
    deathdir = "\xa7~";
  } else if(cardinaldirection == 1) {
    deathdir = "}h";
  } else {
    deathdir = "\xbed";
  }

  aliasdeath = part + size + deathdir;
  return asm::asm_lookupanimfromalias(statename, aliasdeath);
}