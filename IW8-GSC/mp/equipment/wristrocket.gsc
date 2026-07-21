/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\wristrocket.gsc
***********************************************/

wristrocketinit() {
  level._effect["_encstr_81F114BF4D6CFB7B9A159ED3D3611137B8A3607BE005"] = loadfx("_encstr_85AE34ABF9F01FBA9C4FA66FED4DE39DF0A3A37278E0089677E7FF9F1540DBC6408E9BBA2878B4694E8FA7AF1395713DE8F34503A1F8");
  level._effect["_encstr_963815BC9B03BA2D4B88BF1AD573D6353AD247107BBF18"] = loadfx("_encstr_AC5835E3B071B5DF9BF4473F6EE1876BE3804BCB9203DA0E9330073D06C0D3772149E35318D713978B281B3B9573AFBBA9D84BDB1843CA");
}

wristrocket_set() {
  thread wristrocket_watcheffects();
}

wristrocket_unset() {
  self notify("_encstr_858D12C79AEF97F38180117B87DBA9034576039B");
}

wristrocketused(var_0) {
  if(var_0.tickpercent == 1) {
    return;
  }
  var_1 = wristrocket_createrocket(var_0);
  var_1.grenade = var_0;
  var_0 = scripts\mp\utility\weapon::_launchgrenade("_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0", self.origin, (0, 0, 0), 100, 1, var_0);
  var_0 forcehidegrenadehudwarning(1);
  var_0 linkTo(var_1);
  var_0 thread wristrocket_cleanuponparentdeath(var_1);
  var_0 thread wristrocket_cleanuponownerdisconnect(self);
  var_1 setscriptablepartstate("_encstr_9769076901B7A8AF74", "_encstr_930B07BB1B6B3854FF", 0);
  var_1 thread wristrocket_watchfuse(2);
  var_1 thread wristrocket_watchstuck();
}

wristrocket_watchfuse(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_87D116DDC9D29B474AEDD8B52BE8F5EEB03A3643C8EACDAC");
  self endon("_encstr_87D116DDC9D29B474AEDD8B52BE8F5EEB03A3643C8EACDAC");
  wait(var_0);
  thread wristrocket_explode();
}

wristrocket_watchstuck() {
  self endon("_encstr_AD75063D571AE108");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_0);

  if(isPlayer(var_0))
    self.owner scripts\mp\weapons::grenadestuckto(self, var_0);

  self stoploopsound();
  self setscriptablepartstate("_encstr_99AD06D3A533174C", "_encstr_930B07BB1B6B3854FF", 0);
  self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_930B07BB1B6B3854FF", 0);
  self.grenade forcehidegrenadehudwarning(0);
  thread wristrocket_watchfuse(1.35);
}

wristrocket_explode() {
  self setscriptablepartstate("_encstr_99AD06D3A533174C", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_83380768EF1919AF8A", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_930B07BB1B6B3854FF", 0);
  thread wristrocket_delete();
}

wristrocket_delete() {
  self notify("_encstr_AD75063D571AE108");
  self.exploding = 1;
  wait 0.1;
  self delete();
}

wristrocket_createrocket(var_0) {
  var_1 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7"), var_0.origin, var_0.origin + anglesToForward(self getgunangles()), self);
  var_1.owner = self;
  var_1.team = self.team;
  var_1.weapon_name = "_encstr_A9DA131AB0E9F962F81B8FBF90D63873BF5AA9D5A7";
  var_1.power = "_encstr_AB5E12C33A17755069CF557BD38B18C8FFD2F9CB";
  var_1 setotherent(self);
  var_1 setentityowner(self);
  var_1 thread wristrocket_cleanuponownerdisconnect(self);
  return var_1;
}

wristrocket_watcheffects() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8F5319BB27D2E6E825DB6CAD2B1DEBDDC21D6C0DA233CCB2B1E8CD");
  self endon("_encstr_8F5319BB27D2E6E825DB6CAD2B1DEBDDC21D6C0DA233CCB2B1E8CD");
  var_0 = 0;

  for(;;) {
    var_1 = spawnStruct();

    if(var_0)
      childthread wristrocket_watcheffectsraceheldoffhandbreak(var_1);
    else
      childthread wristrocket_watcheffectsracegrenadepullback(var_1);

    childthread wristrocket_watcheffectsracegrenadefired(var_1);
    childthread wristrocket_watcheffectsracesuperstarted(var_1);
    childthread wristrocket_watcheffectsracedeath(var_1);
    childthread wristrocket_watcheffectsraceunset(var_1);
    var_0 = 0;
    self waittill("_encstr_979E22E373704B7306F7AFB7DB3D0987E85B1EAC0DA0E63AE6A9E75B3B6E92FB2841D233");
    waittillframeend;
    var_2 = istrue(var_1.grenadepullback);
    var_3 = istrue(var_1.grenadefire);
    var_4 = istrue(var_1.superstarted);
    var_5 = istrue(var_1.death);
    var_6 = istrue(var_1.unset);
    var_7 = istrue(var_1.heldoffhandbreak);

    if(var_5) {
      self notify("_encstr_914720D79B0A3703E6509AB7534B2FF763F5FBD181A91D8382F58B1690F74B05266A");
      thread wristrocket_endeffects();
      return;
    } else if(var_6) {
      self notify("_encstr_914720D79B0A3703E6509AB7534B2FF763F5FBD181A91D8382F58B1690F74B05266A");
      thread wristrocket_endeffects();
      return;
    } else if(var_4)
      thread wristrocket_endeffects();
    else if(var_7)
      thread wristrocket_endeffects();
    else if(var_3)
      thread wristrocket_endeffects();
    else if(var_2) {
      thread wristrocket_begineffects();
      var_0 = 1;
    }

    self notify("_encstr_914720D79B0A3703E6509AB7534B2FF763F5FBD181A91D8382F58B1690F74B05266A");
  }
}

wristrocket_watcheffectsracegrenadepullback(var_0) {
  self endon("_encstr_914720D79B0A3703E6509AB7534B2FF763F5FBD181A91D8382F58B1690F74B05266A");

  for(;;) {
    self waittill("_encstr_B89B11B393CACDC2C859AF8357638D13B08DD6", var_1);

    if(var_1.basename == "_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0") {
      break;
    }
  }

  var_0.grenadepullback = 1;
  self notify("_encstr_979E22E373704B7306F7AFB7DB3D0987E85B1EAC0DA0E63AE6A9E75B3B6E92FB2841D233");
}

wristrocket_watcheffectsracegrenadefired(var_0) {
  self endon("_encstr_914720D79B0A3703E6509AB7534B2FF763F5FBD181A91D8382F58B1690F74B05266A");

  for(;;) {
    self waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_1, var_2);

    if(var_2.basename == "_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0") {
      break;
    }
  }

  var_0.grenadefire = 1;
  self notify("_encstr_979E22E373704B7306F7AFB7DB3D0987E85B1EAC0DA0E63AE6A9E75B3B6E92FB2841D233");
}

wristrocket_watcheffectsracesuperstarted(var_0) {
  self endon("_encstr_914720D79B0A3703E6509AB7534B2FF763F5FBD181A91D8382F58B1690F74B05266A");
  self waittill("_encstr_97E30E6EAB1CCA93D76EE816E4479591");
  var_0.superstarted = 1;
  self notify("_encstr_979E22E373704B7306F7AFB7DB3D0987E85B1EAC0DA0E63AE6A9E75B3B6E92FB2841D233");
}

wristrocket_watcheffectsracedeath(var_0) {
  self endon("_encstr_914720D79B0A3703E6509AB7534B2FF763F5FBD181A91D8382F58B1690F74B05266A");
  self waittill("_encstr_AD75063D571AE108");
  var_0.death = 1;
  self notify("_encstr_979E22E373704B7306F7AFB7DB3D0987E85B1EAC0DA0E63AE6A9E75B3B6E92FB2841D233");
}

wristrocket_watcheffectsraceunset(var_0) {
  self endon("_encstr_914720D79B0A3703E6509AB7534B2FF763F5FBD181A91D8382F58B1690F74B05266A");
  self waittill("_encstr_858D12C79AEF97F38180117B87DBA9034576039B");
  var_0.unset = 1;
  self notify("_encstr_979E22E373704B7306F7AFB7DB3D0987E85B1EAC0DA0E63AE6A9E75B3B6E92FB2841D233");
}

wristrocket_watcheffectsraceheldoffhandbreak(var_0) {
  self endon("_encstr_914720D79B0A3703E6509AB7534B2FF763F5FBD181A91D8382F58B1690F74B05266A");
  waitframe();
  var_1 = getcompleteweaponname("_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0");

  while(self getheldoffhand() == var_1)
    waitframe();

  var_0.heldoffhandbreak = 1;
  self notify("_encstr_979E22E373704B7306F7AFB7DB3D0987E85B1EAC0DA0E63AE6A9E75B3B6E92FB2841D233");
}

wristrocket_begineffects() {
  self notify("_encstr_84FA19483B998301C105667A9FFB0FE9FD1730184F2EF9EB3AEB66");
  self endon("_encstr_84FA19483B998301C105667A9FFB0FE9FD1730184F2EF9EB3AEB66");
  self endon("_encstr_AF11173CFA2FE379026AB8F0E2A377795B945D3C46A729B1B2");
  self setscriptablepartstate("_encstr_96F711D7EDB333746918363C71709F4A967903", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  wait 0.15;
  self setscriptablepartstate("_encstr_96F711D7EDB333746918363C71709F4A967903", "_encstr_930B07BB1B6B3854FF", 0);
}

wristrocket_endeffects() {
  self notify("_encstr_AF11173CFA2FE379026AB8F0E2A377795B945D3C46A729B1B2");
  self setscriptablepartstate("_encstr_96F711D7EDB333746918363C71709F4A967903", "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

wristrocketcooksuicideexplodecheck(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 != var_2) {
    return;
  }
  if(var_3 != "_encstr_AB590C99ED78875F650F3951034D") {
    return;
  }
  if(!isDefined(var_0) || var_0 != var_1) {
    return;
  }
  if(!isDefined(var_4) || var_4.basename != "_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0") {
    return;
  }
  var_5 = var_2 gettagorigin("_encstr_A98C10F0117A694307579828C090CC85ED33");
  radiusdamage(var_5, 175, 200, 70, var_1, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_AB0F0E1CB7E0FA27BD6CB5AC8EFAADE0");
  scripts\mp\shellshock::grenade_earthquakeatposition(var_5, 0.6);
  playFX(scripts\engine\utility::getfx("_encstr_81F114BF4D6CFB7B9A159ED3D3611137B8A3607BE005"), var_5);
}

wristrocket_cleanuponparentdeath(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self notify("_encstr_9B93156C8D560B73D5079EB9418593ACCD3A88AC0B470D");
  self endon("_encstr_9B93156C8D560B73D5079EB9418593ACCD3A88AC0B470D");

  if(isDefined(var_0))
    var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_1))
    wait(var_1);

  self delete();
}

wristrocket_cleanuponownerdisconnect(var_0) {
  self endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(self))
    self delete();
}