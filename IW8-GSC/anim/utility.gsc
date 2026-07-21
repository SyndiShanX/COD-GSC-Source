/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\utility.gsc
***********************************************/

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");
#using_animtree("_encstr_B40101");

initanimtree(var_0) {
  self clearanim(%_encstr_AD9B0589ED9197, 0.3);
  self setanim(%_encstr_AD9B0589ED9197, 1, 0);

  if(var_0 != "_encstr_B60D055B0E3128" && var_0 != "_encstr_AD75063D571AE108")
    self.a.special = "_encstr_8BBA05185F8B99";

  self.a.aimweight = 1.0;
  self.a.aimweight_start = 1.0;
  self.a.aimweight_end = 1.0;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  updateisincombattimer();
}

#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");
#using_animtree("_encstr_B40101");

updateanimpose() {
  if(isDefined(self.desired_anim_pose) && self.desired_anim_pose != self.currentpose) {
    if(self.currentpose == "_encstr_922406F1A6FD5E05")
      exitpronewrapper(0.5);

    if(self.desired_anim_pose == "_encstr_922406F1A6FD5E05") {
      self setproneanimnodes(-45, 45, %_encstr_BDCD1038C9DEDCACD7C62BB3DCFA327BBB37, %_encstr_AD650FC58333F2CBC5387F0BBB83EC8DE7, %_encstr_AC890E134038B68A5FD1B72F46B74350);
      enterpronewrapper(0.5);
      self setanimknoball(lookupanim("_encstr_B6DE0E8195BC80A3D9B31F1BCDA72818", "_encstr_91450FDF83BB13D27CB0EBDF410F8BD379"), %_encstr_AD9B0589ED9197, 1, 0.1, 1);
    }
  }

  self.desired_anim_pose = undefined;
}

initialize(var_0) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  self waittill("_encstr_BA6310D0251823176DA82AD340878D939116");
}

printdisplaceinfo() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_B83D0E8FA24B3F90B1071FF83B803BD4");
  self endon("_encstr_B83D0E8FA24B3F90B1071FF83B803BD4");

  for(;;)
    wait 0.05;
}

isincombat(var_0) {
  if((!isDefined(var_0) || var_0) && self.alertlevelint > 1)
    return 1;

  if(isDefined(self.enemy))
    return 1;

  return self.a.combatendtime > gettime();
}

updateisincombattimer() {
  if(isDefined(self.enemy))
    self.a.combatendtime = gettime() + anim.combatmemorytimeconst + randomint(anim.combatmemorytimerand);
}

notifyaftertime(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

drawstring(var_0) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  self endon("_encstr_BA0E0E0D5BD5332AABE8283C8A98A378");

  for(;;)
    wait 0.05;
}

drawstringtime(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5++)
    wait 0.05;
}

showlastenemysightpos(var_0) {
  self notify("_encstr_938E111F2860E00A806F771BD93D621D6B72C2");
  self endon("_encstr_938E111F2860E00A806F771BD93D621D6B72C2");
  self endon("_encstr_AD75063D571AE108");

  if(!isDefined(self.enemy)) {
    return;
  }
  if(self.enemy.team == "_encstr_9A8507BA4040188D08")
    var_1 = (0.4, 0.7, 1);
  else
    var_1 = (1, 0.7, 0.4);

  for(;;) {
    wait 0.05;

    if(!isDefined(self.lastenemysightpos))
      continue;
  }
}

hasenemysightpos() {
  if(isDefined(self.node))
    return _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::canseeenemyfromexposed() || _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::cansuppressenemyfromexposed();
  else
    return _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::canseeenemy() || _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::cansuppressenemy();
}

getenemysightpos() {
  return self.goodshootpos;
}

debugtimeout() {
  wait 5;
  self notify("_encstr_995408F398012F656821");
}

debugposinternal(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_B20D0C47082F02360120429514D7" + var_0);
  self endon("_encstr_B20D0C47082F02360120429514D7" + var_0);
  var_3 = spawnStruct();
  var_3 thread debugtimeout();
  var_3 endon("_encstr_995408F398012F656821");

  if(self.enemy.team == "_encstr_9A8507BA4040188D08")
    var_4 = (0.4, 0.7, 1);
  else
    var_4 = (1, 0.7, 0.4);

  for(;;)
    wait 0.05;
}

debugpos(var_0, var_1) {
  thread debugposinternal(var_0, var_1, 2.15);
}

debugpossize(var_0, var_1, var_2) {
  thread debugposinternal(var_0, var_1, var_2);
}

debugburstprint(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_3 = undefined;

  if(var_0 == self.bulletsinclip)
    var_3 = "_encstr_BEBF0B41751C724E8A57555957";
  else if(var_2 < 0.25)
    var_3 = "_encstr_B89B0CB96BC28DD84098BA9337A3";
  else if(var_2 < 0.5)
    var_3 = "_encstr_8CDC0A1F6395A6C230DB529B";
  else
    var_3 = "_encstr_A2DC0B8DDEB9B38089579CDC3A";

  thread debugpossize(self.origin + (0, 0, 42), var_3, 1.5);
  thread debugpos(self.origin + (0, 0, 60), "_encstr_8DAE0C35BA070E4E956E6EB473B3");
}

printshootproc() {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_9B4F0C43D9482ABA8648BAA2D377" + self.export);
  self endon("_encstr_9B4F0C43D9482ABA8648BAA2D377" + self.export);
  var_0 = 0.25;
  var_1 = var_0 * 20;

  for(var_2 = 0; var_2 < var_1; var_2 = var_2 + 1)
    wait 0.05;
}

printshoot() {}

showdebugproc(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5 = var_5 + 1)
    wait 0.05;
}

showdebugline(var_0, var_1, var_2, var_3) {
  thread showdebugproc(var_0, var_1 + (0, 0, -5), var_2, var_3);
}

shootenemywrapper_normal(var_0) {
  self.a.lastshoottime = gettime();
  scripts\common\gameskill::set_accuracy_based_on_situation();
  self notify("_encstr_938C091AC8B8AFFB036D37");

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos))
    self shoot(1, self._blackboard.shootparams_pos, 1, 0, 1);
  else {
    if(isagent(self))
      var_0 = 1;

    self shoot(1, undefined, var_0);
  }
}

shootenemywrapper_shootnotify(var_0) {
  level notify("_encstr_BDAF0E16DCF52B73955B2FFAE60DED47", self);
  shootenemywrapper_normal(var_0);
}

shootposwrapper(var_0, var_1) {
  self.a.lastshoottime = gettime();

  if(!isDefined(var_1))
    var_1 = 1;

  self notify("_encstr_938C091AC8B8AFFB036D37");

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isasniper())
    self shoot(1, var_0, 1, 1, 1);
  else {
    var_2 = 0;

    if(isDefined(self.enemy) && istrue(self.enemy.underlowcover))
      var_2 = 1;

    var_3 = bulletspread(self getmuzzlepos(), var_0, 4);
    self shoot(1, var_3, var_1, var_2);
  }
}

throwgun() {
  var_0 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_0 setModel("_encstr_91EF058E2BD683");
  var_0.origin = self gettagorigin("_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D") + (50, 50, 0);
  var_0.angles = self gettagangles("_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");
  var_1 = anglestoright(var_0.angles);
  var_1 = var_1 * 15;
  var_2 = anglesToForward(var_0.angles);
  var_2 = var_2 * 15;
  var_0 movegravity((0, 50, 150), 100);
  var_3 = "_encstr_B2010820C5337B67C8CF" + createheadicon(self.weapon);
  var_4 = spawn(var_3, var_0.origin);
  var_4.angles = self gettagangles("_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D");
  var_4 linkTo(var_0);
  var_5 = var_0.origin;

  while(isDefined(var_4) && isDefined(var_4.origin)) {
    var_6 = var_5;
    var_7 = var_0.origin;
    var_8 = vectortoangles(var_7 - var_6);
    var_2 = anglesToForward(var_8);
    var_2 = var_2 * 4;
    var_9 = scripts\engine\trace::_bullet_trace(var_7, var_7 + var_2, 1, var_4);

    if(isalive(var_9["_encstr_850E077B0BF30318B9"]) && var_9["_encstr_850E077B0BF30318B9"] == self) {
      wait 0.05;
      continue;
    }

    if(var_9["_encstr_A53009A25003666B9818C6"] < 1.0) {
      break;
    }

    var_5 = var_0.origin;
    wait 0.05;
  }

  if(isDefined(var_4) && isDefined(var_4.origin))
    var_4 unlink();

  var_0 delete();
}

personalcoldbreath() {
  var_0 = "_encstr_A130085D3FD8D8A80F60";
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AF951517843568F7238A9BA332031FC09EEDB5A53D9E90");
  self endon("_encstr_AF951517843568F7238A9BA332031FC09EEDB5A53D9E90");

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    if(isDefined(self.a.movement) && self.a.movement == "_encstr_B419059BD17BE0") {
      if(isDefined(self.isindoor) && self.isindoor == 1) {
        continue;
      }
      playFXOnTag(level._effect["_encstr_835A0CF98D633AF7E203C74F239B"], self, var_0);
      wait(2.5 + randomfloat(3));
      continue;
    }

    wait 0.5;
  }
}

ispartiallysuppressedwrapper() {
  if(self.suppressionmeter <= self.suppressionthreshold * 0.25)
    return 0;

  return self issuppressed();
}

showlines(var_0, var_1, var_2) {
  for(;;) {
    wait 0.05;
    wait 0.05;
  }
}

anim_array(var_0, var_1) {
  var_2 = var_0.size;
  var_3 = randomint(var_2);

  if(var_2 == 1)
    return var_0[0];

  var_4 = 0;
  var_5 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++)
    var_5 = var_5 + var_1[var_6];

  var_7 = randomfloat(var_5);
  var_8 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_8 = var_8 + var_1[var_6];

    if(var_7 >= var_8) {
      continue;
    }
    var_3 = var_6;
    break;
  }

  return var_0[var_3];
}

canthrowgrenade() {
  if(!self.grenadeammo)
    return 0;

  if(self.script_forcegrenade)
    return 1;

  return isPlayer(self.enemy);
}

usingboltactionweapon() {
  return weaponisboltaction(self.weapon);
}

random_weight(var_0) {
  var_1 = randomint(var_0.size);

  if(var_0.size > 1) {
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++)
      var_2 = var_2 + var_0[var_3];

    var_4 = randomfloat(var_2);
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 = var_2 + var_0[var_3];

      if(var_4 < var_2) {
        var_1 = var_3;
        break;
      }
    }
  }

  return var_1;
}

setfootstepeffect(var_0, var_1, var_2) {
  if(!isDefined(anim.optionalstepeffects))
    anim.optionalstepeffects = [];

  anim.optionalstepeffects[var_1] = 1;
  level._effect["_encstr_91AD062683CA797E" + var_1][var_0] = var_2;
}

setfootstepeffectsmall(var_0, var_1, var_2) {
  if(!isDefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall = [];

  anim.optionalstepeffectssmall[var_1] = 1;
  level._effect["_encstr_AC520CEB536D2331702B996CD1E9" + var_1][var_0] = var_2;
}

setfootprinteffect(var_0, var_1, var_2) {
  if(!isDefined(anim.optionalfootprinteffects))
    anim.optionalfootprinteffects = [];

  if(!isDefined(anim.flirfootprinteffects))
    anim.flirfootprinteffects = 0;

  anim.optionalfootprinteffects[var_1] = 1;
  level._effect["_encstr_B2E30B33F67BE80E4ED2B9E87D" + var_1][var_0] = var_2;
}

unsetfootstepeffect(var_0) {
  if(isDefined(anim.optionalstepeffects))
    anim.optionalstepeffects[var_0] = undefined;

  level._effect["_encstr_91AD062683CA797E" + var_0] = undefined;
}

unsetfootstepeffectsmall(var_0) {
  if(isDefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall[var_0] = undefined;

  level._effect["_encstr_AC520CEB536D2331702B996CD1E9" + var_0] = undefined;
}

unsetfootprinteffect(var_0) {
  if(isDefined(anim.optionalfootprinteffects))
    anim.optionalfootprinteffects[var_0] = undefined;

  level._effect["_encstr_B2E30B33F67BE80E4ED2B9E87D" + var_0] = undefined;
}

setnotetrackeffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2))
    var_2 = "_encstr_AF1904A7F929";

  if(!isDefined(level._notetrackfx))
    level._notetrackfx = [];

  level._notetrackfx[var_0][var_2] = spawnStruct();
  level._notetrackfx[var_0][var_2].tag = var_1;
  level._notetrackfx[var_0][var_2].fx = var_3;
  setnotetracksound(var_0, var_2, var_4, var_5);
}

setnotetracksound(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = "_encstr_AF1904A7F929";

  if(!isDefined(level._notetrackfx))
    level._notetrackfx = [];

  if(isDefined(level._notetrackfx[var_0][var_1]))
    var_4 = level._notetrackfx[var_0][var_1];
  else {
    var_4 = spawnStruct();
    level._notetrackfx[var_0][var_1] = var_4;
  }

  if(isDefined(var_2))
    var_4.sound_prefix = var_2;

  if(isDefined(var_3))
    var_4.sound_suffix = var_3;
}

enterpronewrapper(var_0) {
  thread enterpronewrapperproc(var_0);
}

enterpronewrapperproc(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AD981285CDA5D6FA83C9DB9BACBE1B0D0BE6D9B2");
  self endon("_encstr_AD981285CDA5D6FA83C9DB9BACBE1B0D0BE6D9B2");
  self enterprone(var_0, isDefined(self.a.onback));
  self waittill("_encstr_85140F22139204D9DDF8E3DF36CDE82275");

  if(self.currentpose != "_encstr_922406F1A6FD5E05" && !isDefined(self.a.onback))
    self.currentpose = "_encstr_922406F1A6FD5E05";
}

stoponback() {
  exitpronewrapper(1.0);
  self.a.onback = undefined;
}

exitpronewrapper(var_0) {
  thread exitpronewrapperproc(var_0);
}

exitpronewrapperproc(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_AD981285CDA5D6FA83C9DB9BACBE1B0D0BE6D9B2");
  self endon("_encstr_AD981285CDA5D6FA83C9DB9BACBE1B0D0BE6D9B2");
  self exitprone(var_0);
  self waittill("_encstr_85140F22139204D9DDF8E3DF36CDE82275");

  if(self.currentpose == "_encstr_922406F1A6FD5E05")
    self.currentpose = "_encstr_B13D076BED70539F23";
}

animarray(var_0) {
  return self.a.array[var_0];
}

animarrayanyexist(var_0) {
  return isDefined(self.a.array[var_0]) && self.a.array[var_0].size > 0;
}

animarraypickrandom(var_0) {
  var_1 = randomint(self.a.array[var_0].size);
  return self.a.array[var_0][var_1];
}

array(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = [];

  if(isDefined(var_0))
    var_14[0] = var_0;
  else
    return var_14;

  if(isDefined(var_1))
    var_14[1] = var_1;
  else
    return var_14;

  if(isDefined(var_2))
    var_14[2] = var_2;
  else
    return var_14;

  if(isDefined(var_3))
    var_14[3] = var_3;
  else
    return var_14;

  if(isDefined(var_4))
    var_14[4] = var_4;
  else
    return var_14;

  if(isDefined(var_5))
    var_14[5] = var_5;
  else
    return var_14;

  if(isDefined(var_6))
    var_14[6] = var_6;
  else
    return var_14;

  if(isDefined(var_7))
    var_14[7] = var_7;
  else
    return var_14;

  if(isDefined(var_8))
    var_14[8] = var_8;
  else
    return var_14;

  if(isDefined(var_9))
    var_14[9] = var_9;
  else
    return var_14;

  if(isDefined(var_10))
    var_14[10] = var_10;
  else
    return var_14;

  if(isDefined(var_11))
    var_14[11] = var_11;
  else
    return var_14;

  if(isDefined(var_12))
    var_14[12] = var_12;
  else
    return var_14;

  if(isDefined(var_13))
    var_14[13] = var_13;

  return var_14;
}

getaiprimaryweapon() {
  return self.primaryweapon;
}

getaisecondaryweapon() {
  return self.secondaryweapon;
}

getaisidearmweapon() {
  return self.sidearm;
}

getaicurrentweapon() {
  return self.weapon;
}

getaicurrentweaponslot() {
  if(self.weapon == self.primaryweapon)
    return "_encstr_BA7F0830B3A7859B60B0";
  else if(self.weapon == self.secondaryweapon)
    return "_encstr_AC8F0AE74163F85AAA380AD8";
  else if(self.weapon == self.sidearm)
    return "_encstr_AF53086E4B46ACC2E4B5";
  else {}
}

aihasweapon(var_0) {
  var_1 = createheadicon(var_0);

  if(isDefined(self.weaponinfo[var_1]))
    return 1;

  return 0;
}

getanimendpos(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  return self localtoworldcoords(var_1);
}

ragdolldeath(var_0) {
  self endon("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  var_1 = self.origin;
  var_2 = (0, 0, 0);

  for(;;) {
    wait 0.05;
    var_3 = distance(self.origin, var_1);
    var_1 = self.origin;

    if(self.health == 1) {
      self.a.nodeath = 1;
      self startragdoll();
      self clearanim(var_0, 0.1);
      wait 0.05;
      physicsexplosionsphere(var_1, 600, 0, var_3 * 0.1);
      self notify("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
      return;
    }
  }
}

shouldcqb() {
  return iscqbwalking() && !isDefined(self.grenade);
}

iscqbwalking() {
  return isDefined(self.demeanoroverride) && self.demeanoroverride == "_encstr_931904C66102";
}

iscqbwalkingorfacingenemy() {
  return !self.facemotion || iscqbwalking();
}

randomizeidleset() {
  self.a.idleset = randomint(2);
}

getrandomintfromseed(var_0, var_1) {
  var_2 = var_0 % anim.randominttablesize;
  return anim.randominttable[var_2] % var_1;
}

getcurrentweaponslotname() {
  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsecondary())
    return "_encstr_AC8F0AE74163F85AAA380AD8";

  if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::isusingsidearm())
    return "_encstr_AF53086E4B46ACC2E4B5";

  return "_encstr_BA7F0830B3A7859B60B0";
}

lookupanim(var_0, var_1) {
  if(isDefined(self.animarchetype)) {
    if(isDefined(anim.archetypes[self.animarchetype][var_0]) && isDefined(anim.archetypes[self.animarchetype][var_0][var_1]))
      return anim.archetypes[self.animarchetype][var_0][var_1];
  }

  return anim.archetypes["_encstr_958C08CDDBD8325A959C"][var_0][var_1];
}

lookupanimarray(var_0) {
  if(isDefined(self.animarchetype)) {
    if(isDefined(anim.archetypes[self.animarchetype][var_0])) {
      var_1 = anim.archetypes["_encstr_958C08CDDBD8325A959C"][var_0];

      foreach(var_4, var_3 in anim.archetypes[self.animarchetype][var_0])
      var_1[var_4] = var_3;

      return var_1;
    }
  }

  return anim.archetypes["_encstr_958C08CDDBD8325A959C"][var_0];
}

isenergyweapon(var_0) {
  return weaponusesenergybullets(var_0);
}