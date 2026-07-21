/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\asm_mp.gsc
***********************************************/

asm_init(var_0, var_1) {
  self.asm = spawnStruct();
  self.asm.animoverrides = [];
  self.asm.frantic = 0;
  self.asmname = var_0;
  self.asm.archetype = var_1;
  self setanimset(var_1);
  self.fnasm_init = ::asm_init;

  if(self islegacyagent())
    self.fnasm_setorientmode = ::asm_settransitionorientmode_legacy;
  else
    self.fnasm_setorientmode = ::asm_settransitionorientmode_transition;

  self.fnasm_handlenotetrack = _encstr_A22E1FE61B4E96838E9B792C73B4B6E5DC7BE8B2479CC28D6DE6EBD61CC5CEDCC6::handlenotetrack;
  self.fnasm_playadditiveanimloopstate = ::asm_playadditiveanimloopstate_mp;
  self.fnasm_playfacialanim = ::carepackage_drop_from_heli;
  self.fndooropen = ::dooropen;
  self.fndoorclose = ::doorclose;
  self.fndoorneedstoclose = ::doorneedstoclose;
  self.fngetdoorcenter = ::getdoorcenter;
  self.fndooralreadyopen = ::dooralreadyopen;
  level.playercanplaynotcriticalgesture = ::bunker_waitforuse;
  level.playercanseedangercircleworld = ::bunker_spawning;
  level.playercanbuyrespawn = ::bunker_spawning;
  hack_setup_a_struct();
  var_2 = var_0;

  if(isDefined(self.asmasset))
    var_2 = self.asmasset;

  asmregistergenerichandler(var_2, scripts\asm\asm::asm_generichandler);
  self asminstantiate(var_2);
}

hack_setup_a_struct() {
  if(isDefined(self.a)) {
    return;
  }
  self.a = spawnStruct();
  self.currentpose = "_encstr_A5AD069B231F0BAF";
  self.a.movement = "_encstr_B419059BD17BE0";
  self.a.special = "_encstr_8BBA05185F8B99";
  self.a.gunhand = "_encstr_8BBA05185F8B99";
  self.a.needstorechamber = 0;
  self.a.combatendtime = gettime();
  self.a.lastenemytime = gettime();
  self.a.suppressingenemy = 0;
  self.a.disablelongdeath = !self isbadguy();
  self.a.paintime = 0;
  self.a.lastshoottime = 0;
  self.a.nextgrenadetrytime = 0;
  self.a.reacttobulletchance = 0.8;
  self.a.misstime = 0;
  self.a.nodeath = 0;
  self.a.misstime = 0;
  self.a.misstimedebounce = 0;
  self.a.disablepain = 0;
  self.a.laseron = 0;
}

bunker_waitforuse(var_0, var_1, var_2, var_3) {
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_4.angles = var_3;
  var_4 setModel(level.scr_model[var_0]);
  self.animated_prop = var_4;
}

bunker_spawning(var_0, var_1) {
  var_2 = level.scr_anim[var_0][var_1];
  self.animated_prop scriptmodelplayanimdeltamotion(var_2);
}

_id_12E1D() {
  if(isDefined(self.fnshouldplaypainanim)) {
    if(![[self.fnshouldplaypainanim]]())
      return;
  } else if(!shouldplaypainanim()) {
    return;
  }
  if(isDefined(self.damageweapon)) {
    var_0 = getweaponbasename(self.damageweapon);

    if(var_0 == "_encstr_BA730BF8AFF178988293F158B9") {
      self._blackboard.isburning = 1;

      if(self.damageyaw > 0)
        self.burningdirection = "_encstr_8253060E2B5FE330";
      else
        self.burningdirection = "_encstr_A5AD056A019C63";
    }
  }

  if(self asmhaspainstate(self.asmname))
    self asmevalpaintransition(self.asmname);
}

traversehandler() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");

  for(;;) {
    self waittill("_encstr_9AC60F8143AFEE3F8348A9AE5A27975B88", var_0, var_1);

    if(!self asmhasstate(self.asmname, var_0))
      var_0 = "_encstr_ADCD121CF8685D2BD5F3094F374373B7ED48935D";

    self asmsetstate(self.asmname, var_0);
  }
}

shouldplaypainanim() {
  var_0 = 64;

  if(self.a.disablepain)
    return 0;

  if(isDefined(self.allowpain) && self.allowpain == 0)
    return 0;

  if(isDefined(self.pathgoalpos) && self pathdisttogoal(1) < var_0)
    return 0;

  if(isDefined(self.damageweapon)) {
    var_1 = getweaponbasename(self.damageweapon);
    var_2 = issubstr(var_1, "_encstr_8D7609A4F337C2C9C2BDB7") || isDefined(self.damageweapon.magazine) && issubstr(self.damageweapon.magazine, "_encstr_B47E094630B8ACB27B2D57");

    if(var_2 && isDefined(self.a.lastpaintime) && gettime() - self.a.lastpaintime < 2000)
      return 0;
  }

  return 1;
}

asm_handlenotetracks(var_0, var_1, var_2, var_3) {
  scripts\asm\asm::asm_fireevent(self.asmname, var_0);
}

asm_playanimstateindex(var_0, var_1, var_2, var_3) {
  care_pkg(var_0, var_1, var_2, var_3, "_encstr_961804BD954A");
}

care_pkg(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  var_5 = scripts\asm\asm::asm_getnotehandler(var_0, var_1);

  if(isDefined(var_3))
    scripts\mp\agents\scriptedagents::playanimnatrateuntilnotetrack(var_1, var_2, var_3, var_1, var_4, var_5);
  else
    scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(var_1, var_2, var_1, var_4, var_5);
}

asm_playanimstateuntilnotetrack(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  var_3 = asm_getanimindex(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getnotehandler(var_0, var_1);
  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack(var_1, var_3, var_1, var_2, var_4);
}

asm_shoulddeathtransition(var_0, var_1) {}

asm_settransitionorientmode_transition(var_0) {
  switch (var_0) {
    case "_encstr_AB490A2BB8D9DDBE1D70D78F":
      var_1 = 1024.0;

      if(scripts\engine\utility::actor_is3d()) {
        var_2 = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1)
          var_2 = scripts\asm\shared\utility::getnodeforwardangles(self.node);

        self orientmode("_encstr_91440EF5D7AA1B467F70DAB9531A9ED1", var_2);
      } else {
        var_3 = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1)
          var_3 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);

        self orientmode("_encstr_A34A0B518A172592D6E64FA115", var_3);
      }

      break;
    default:
      self orientmode(var_0);
      break;
  }
}

asm_settransitionorientmode_legacy(var_0) {
  switch (var_0) {
    case "_encstr_810D0AFA905FCF126130E114":
      var_1 = self.pathgoalpos;

      if(isDefined(var_1)) {
        var_2 = var_1 - self.origin;
        var_3 = vectorNormalize(var_2);
        var_4 = vectortoangles(var_3);
        self orientmode("_encstr_A34A0B518A172592D6E64FA115", var_4[1]);
        break;
      }
    case "_encstr_91730D640BC68899BFF532BB38850B":
      self orientmode("_encstr_91730D640BC68899BFF532BB38850B");
      break;
    case "_encstr_84280CCC58B159106BB7D14B7B37":
    case "_encstr_B43B0B33C2B1AC0895B92BAD5E":
      self orientmode(var_0);
      break;
    case "_encstr_AB490A2BB8D9DDBE1D70D78F":
      var_5 = self.angles[1];
      var_6 = 1024.0;

      if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_6)
        var_5 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);

      self orientmode("_encstr_A34A0B518A172592D6E64FA115", var_5);
      break;
    default:
      break;
  }
}

asm_getanimindex(var_0, var_1, var_2) {
  return self asmgetanim(var_0, var_1, var_2);
}

asm_playadditiveanimloopstate_mp(var_0, var_1, var_2) {}

dooropen(var_0, var_1) {
  if(distance2dsquared(self.origin, var_0.origin) < 16) {}

  var_0 constraintoscriptgoalRadius("_encstr_A2840585EE16CB", self.origin);

  if(var_0 scriptabledoorisdouble()) {
    var_2 = getentitylessscriptablearrayinradius(undefined, undefined, var_0.origin, 64);

    foreach(var_4 in var_2) {
      if(var_4 scriptabledoorisdouble())
        var_4 constraintoscriptgoalRadius("_encstr_A2840585EE16CB", self.origin);
    }
  }
}

doorclose(var_0) {
  var_0 vehicle_getinputvalue();
}

doorneedstoclose(var_0) {
  var_1 = var_0 getscriptablepartstate("_encstr_B16705D9AFE22E", 1);

  if(var_1 == "_encstr_A350079E35DACF8944" || var_1 == "_encstr_9730063321C475D8")
    return 0;

  var_2 = self.origin - var_0.origin;
  var_3 = vectortoyaw(var_2);
  var_4 = angleclamp180(var_3 - var_0.heli_intro[1]);
  var_5 = angleclamp180(var_0.angles[1] - var_0.heli_intro[1]);
  return var_4 * var_5 > 0;
}

getdoorcenter(var_0) {
  return self._blackboard.doorpos;
}

dooralreadyopen(var_0) {
  return abs(var_0 scriptabledoorangle()) > 60;
}

care_packages_unusable_think(var_0) {
  if(!animisleaf(var_0))
    return 0;

  return animhasnotetrack(var_0, "_encstr_B20710E6CF11DF2EA991923B78ADA297A9A5");
}

carepackage_drop_from_heli(var_0, var_1, var_2) {
  self playencryptedcinematicforplayer(var_0, var_1, var_2);
}

carepackage_drops(var_0, var_1) {
  if(!scripts\asm\shared\utility::isfacialstateallowed("_encstr_8219049FF2FA")) {
    return;
  }
  if(isDefined(var_0) && care_packages_unusable_think(var_0)) {
    return;
  }
  var_2 = scripts\asm\asm::asm_lookupanimfromaliasifexists("_encstr_999306BA95FACD6B", "_encstr_81CC0586952C91");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(self.asm.facial_state))
    self.asm.facial_state = "_encstr_B40101";

  scripts\asm\shared\utility::setfacialstate("_encstr_8219049FF2FA");

  if(isai(self))
    self setfacialindex(var_1);
}

carepackage_get_dropped_entities() {
  self animmode("_encstr_B69807B9DE36C69683");
  self orientmode("_encstr_A34A0B518A172592D6E64FA115", self.angles[1]);
  scripts\asm\asm::asm_clearfacialanim();
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, "_encstr_84610D49100897C2DF809A03583BFF");
}