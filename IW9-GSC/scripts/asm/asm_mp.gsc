/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\asm_mp.gsc
***********************************************/

asm_init(_id_B5DA6777BFE1ACE8, _id_5E1AB61C2C7FE69B) {
  self.asmname = _id_B5DA6777BFE1ACE8;

  if(!isDefined(self.asm)) {
    self.asm = spawnStruct();
    self.asm.animoverrides = [];
  }

  if(isDefined(_id_5E1AB61C2C7FE69B)) {
    self setanimset(_id_5E1AB61C2C7FE69B);

    if(_id_5E1AB61C2C7FE69B == "elite_01")
      self _meth_7ADFCC654DD371DA("soldier");
    else
      self _meth_7ADFCC654DD371DA(self._id_AE3EA15396B65C1F);
  }

  self.fnasm_init = ::asm_init;
  self.fnasm_setorientmode = ::asm_settransitionorientmode_transition;
  self.fnasm_handlenotetrack = _id_4F57E90811AA8900::handlenotetrack;
  self.fnasm_playadditiveanimloopstate = ::asm_playadditiveanimloopstate_mp;
  self.fnasm_playfacialanim = ::asm_playfacialanim_mp;
  self.fnplaceweaponon = _id_3433EE6B63C7E243::placeweaponon;
  self.fndooropen = ::dooropen;
  self.fndoorclose = ::doorclose;
  self.fndoorneedstoclose = ::doorneedstoclose;
  self.fngetdoorcenter = ::getdoorcenter;
  self.fndooralreadyopen = ::dooralreadyopen;
  self _meth_0131F6FB305015D0(scripts\asm\shared\utility::_id_B6A072E9E59FB82E);
  hack_setup_a_struct();
  scripts\asm\asm::_id_C051A94F99BD65F1(self.asmname);
}

hack_setup_a_struct() {
  if(isDefined(self.a)) {
    return;
  }
  self.a = spawnStruct();
  self.currentpose = "stand";
  self.a.movement = "stop";
  self.a.lastenemytime = gettime();
  self._id_98ADD129A7ECB962 = self isbadguy();
  self.a.paintime = 0;
  self.a.lastshoottime = 0;
  self.reacttobulletchance = 0.8;
  self.misstime = 0;
  self.a.nodeath = 0;
  self.misstime = 0;
  self.misstimedebounce = 0;
  self.a.disablepain = 0;
  self._id_14070A5A0597BF51 = 0;
}

_id_A2B8F8B0891EE7FE() {
  level.fnanimatedprop_setup = ::animatedprop_setup;
  level.fnanimatedprop_startanim = ::animatedprop_setanim;
  level.fnanimatedprop_setanim = ::animatedprop_setanim;
}

animatedprop_setup(modelname, _id_06B5C8034010B9BA, origin, angles) {
  prop = spawn("script_model", origin);
  prop.angles = angles;
  prop setModel(level.scr_model[modelname]);
  self.animated_prop = prop;
}

animatedprop_setanim(_id_5CF354B67B7CE647, param) {
  _id_CCE0ECB52CC93601 = level.scr_anim[_id_5CF354B67B7CE647][param];
  self.animated_prop scriptmodelplayanimdeltamotion(_id_CCE0ECB52CC93601);
}

runpain() {
  if(isDefined(self.fnshouldplaypainanim)) {
    if(![[self.fnshouldplaypainanim]]())
      return;
  } else if(!shouldplaypainanim()) {
    return;
  }
  if(isDefined(self.damageweapon)) {
    basename = getweaponbasename(self.damageweapon);

    if(basename == "molotov_mp") {
      self._blackboard.isburning = 1;

      if(self.damageyaw > 0)
        self.burningdirection = "right";
      else
        self.burningdirection = "left";
    }
  }

  if(self asmhaspainstate(self.asmname))
    self asmevalpaintransition(self.asmname);
}

shouldplaypainanim() {
  _id_392782E59863C89F = 64;

  if(self.a.disablepain)
    return 0;

  if(isDefined(self.allowpain) && self.allowpain == 0)
    return 0;

  if(istrue(self._id_A1DB58C75F381A55))
    return 0;

  if(isDefined(self.pathgoalpos) && self pathdisttogoal(1) < _id_392782E59863C89F)
    return 0;

  if(isDefined(self.damageweapon)) {
    basename = getweaponbasename(self.damageweapon);
    _id_35F8A12BC12E9793 = issubstr(basename, "thermite") || isDefined(self.damageweapon.magazine) && issubstr(self.damageweapon.magazine, "boltfire");

    if(_id_35F8A12BC12E9793 && isDefined(self.a.lastpaintime) && gettime() - self.a.lastpaintime < 2000)
      return 0;
  }

  return 1;
}

asm_handlenotetracks(_id_A234A65C378F3289, _id_E684FC6E068EE951, animindex, _id_EB5B1F36E255152D) {
  scripts\asm\asm::asm_fireevent(self.asmname, _id_A234A65C378F3289);
}

asm_playanimstateindex(asmname, statename, animindex, _id_07B60BC0EAB3FD1E) {
  self endon(statename + "_finished");
  customfunc = scripts\asm\asm::asm_getnotehandler(asmname, statename);

  if(isDefined(_id_07B60BC0EAB3FD1E))
    scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack(statename, animindex, _id_07B60BC0EAB3FD1E, statename, "end", customfunc);
  else
    scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(statename, animindex, statename, "end", customfunc);
}

_id_4895EAFF78A2FC42(asmname, statename, animindex, _id_07B60BC0EAB3FD1E, notetrack) {
  self endon(statename + "_finished");
  customfunc = scripts\asm\asm::asm_getnotehandler(asmname, statename);

  if(isDefined(_id_07B60BC0EAB3FD1E))
    scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack(statename, animindex, _id_07B60BC0EAB3FD1E, statename, notetrack, customfunc);
  else
    scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(statename, animindex, statename, notetrack, customfunc);
}

asm_playanimstateuntilnotetrack(asmname, statename, notetrack) {
  self endon(statename + "_finished");
  animindex = asm_getanimindex(asmname, statename);
  customfunc = scripts\asm\asm::asm_getnotehandler(asmname, statename);
  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(statename, animindex, statename, notetrack, customfunc);
}

asm_shoulddeathtransition(asmname, currentstate) {}

asm_settransitionorientmode_transition(_id_6C1C5F905D32F13A) {
  switch (_id_6C1C5F905D32F13A) {
    case "face node":
      _id_8E1451B5845405B1 = 1024.0;

      if(scripts\engine\utility::actor_is3d()) {
        _id_5E1CF0A9046F6F99 = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < _id_8E1451B5845405B1)
          _id_5E1CF0A9046F6F99 = self _meth_0F134F30C17FAEAF(self.node);

        self orientmode("face angle 3d", _id_5E1CF0A9046F6F99);
      } else {
        yaw = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < _id_8E1451B5845405B1)
          yaw = scripts\asm\shared\utility::getnodeforwardyaw(self.node);

        self orientmode("face angle", yaw);
      }

      break;
    default:
      self orientmode(_id_6C1C5F905D32F13A);
      break;
  }
}

asm_settransitionorientmode_legacy(_id_6C1C5F905D32F13A) {
  switch (_id_6C1C5F905D32F13A) {
    case "face goal":
      pathgoal = self.pathgoalpos;

      if(isDefined(pathgoal)) {
        _id_3777ECE6A73EADA5 = pathgoal - self.origin;
        dir = vectorNormalize(_id_3777ECE6A73EADA5);
        _id_547F2DFAC34847B1 = vectortoangles(dir);
        self orientmode("face angle", _id_547F2DFAC34847B1[1]);
        break;
      }
    case "face current":
      self orientmode("face current");
      break;
    case "face motion":
    case "face enemy":
      self orientmode(_id_6C1C5F905D32F13A);
      break;
    case "face node":
      yaw = self.angles[1];
      _id_8E1451B5845405B1 = 1024.0;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < _id_8E1451B5845405B1)
        yaw = scripts\asm\shared\utility::getnodeforwardyaw(self.node);

      self orientmode("face angle", yaw);
      break;
    default:
      break;
  }
}

asm_getanimindex(asmname, statename, params) {
  return self asmgetanim(asmname, statename, params);
}

asm_playadditiveanimloopstate_mp(asmname, statename, params) {}

dooropen(door, t) {
  if(distance2dsquared(self.origin, door.origin) < 16) {}

  door scriptabledooropen("away", self.origin);

  if(door scriptabledoorisdouble()) {
    _id_2A1BD16B401BCC79 = getentitylessscriptablearray(undefined, undefined, door.origin, 64);

    foreach(otherdoor in _id_2A1BD16B401BCC79) {
      if(otherdoor scriptabledoorisdouble())
        otherdoor scriptabledooropen("away", self.origin);
    }
  }
}

doorclose(door) {
  door scriptabledoorclose();
}

doorneedstoclose(door) {
  if(istrue(door scriptableisdoor()) && door scriptabledoorisclosed())
    return 0;

  curstate = door getscriptablepartstate("door", 1);

  if(curstate == "closed" || curstate == "setup")
    return 0;

  _id_9DFA31B22E1F2822 = self.origin - door.origin;
  _id_ABA22F9F83213675 = vectortoyaw(_id_9DFA31B22E1F2822);
  _id_18DE4D7536809AC9 = door _meth_BACD2D0ACDF8559E();
  _id_077B9E4B599269EB = angleclamp180(_id_ABA22F9F83213675 - _id_18DE4D7536809AC9[1]);
  _id_1293DF07B9A5D4A0 = angleclamp180(door.angles[1] - _id_18DE4D7536809AC9[1]);
  return _id_077B9E4B599269EB * _id_1293DF07B9A5D4A0 > 0;
}

getdoorcenter(door) {
  return self._blackboard.doorpos;
}

dooralreadyopen(door) {
  return abs(door scriptabledoorangle()) > 60;
}

asm_animhasfacialoverridemp(_id_63DB3C9E26531938) {
  if(!animisleaf(_id_63DB3C9E26531938))
    return 0;

  return animhasnotetrack(_id_63DB3C9E26531938, "facial_override");
}

asm_playfacialanim_mp(asmname, statename, animname) {
  self setfacialindexfromasm(asmname, statename, animname);
}

asm_playfacialaniminternalmp(_id_63DB3C9E26531938, _id_3A06FF8DE29AE6DE) {
  if(!scripts\asm\shared\utility::isfacialstateallowed("asm")) {
    return;
  }
  if(isDefined(_id_63DB3C9E26531938) && asm_animhasfacialoverridemp(_id_63DB3C9E26531938)) {
    return;
  }
  headknob = scripts\asm\asm::asm_lookupanimfromaliasifexists("knobs", "head");

  if(!isDefined(headknob)) {
    return;
  }
  if(!isDefined(self.asm.facial_state))
    self.asm.facial_state = "";

  scripts\asm\shared\utility::setfacialstate("asm");

  if(isai(self))
    self setfacialindex(_id_3A06FF8DE29AE6DE);
}

asm_setanimScripted() {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  scripts\asm\asm::asm_clearfacialanim();
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "animscripted");
}