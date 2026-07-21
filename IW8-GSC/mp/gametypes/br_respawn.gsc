/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_respawn.gsc
***********************************************/

init() {
  setdvarifuninitialized("_encstr_92D20F7FFB0A69BE437133D95BA3E7F0A5", 0);
  level.br_respawn_enabled = getdvarint("_encstr_92D20F7FFB0A69BE437133D95BA3E7F0A5", 0) != 0;

  if(!istrue(level.br_respawn_enabled)) {
    removeambulances();
    return;
  }

  level._effect["_encstr_AAF710F6ADB8DD622F451F1F3F41FA0710CB"] = loadfx("_encstr_B19A39604BA8281BB3B02099FFFB5B0857A7F8C8AF5CB9E5DB4E059E5786B5F1587F786063E2F3DD6239FF286DDAE759972B203BABACCB2D5B9FF3");
  level.br_respawnambulances = [];
  thread setuphud();
}

removeambulances() {
  var_0 = scripts\engine\utility::getStructArray("_encstr_9BE7137AC8E7CAC7237F214F18CED713C3507222B0", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = getEnt(var_0[var_1].target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_2))
      var_2 delete();
  }
}

spawnambulance(var_0) {
  if(!istrue(level.br_respawn_enabled))
    return undefined;

  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);

  if(isDefined(var_0.angles))
    var_1.angles = var_0.angles;
  else
    var_1.angles = (0, 0, 0);

  var_1 setModel("_encstr_9A7D25CECA430EF5C6A5B3D763DC32AF832C1B3358BE85D6C4571B16B9D8CA7D5DB59C162DB9AC");
  var_1.struct = var_0;
  var_1 ambulancesetup(var_0);
  var_1 thread ambulancethink();
  level.br_respawnambulances[level.br_respawnambulances.size] = var_1;
  return var_1;
}

ambulancesetup(var_0) {
  thread ambulancelights();
  var_1 = scripts\engine\utility::getStruct(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(!isDefined(self.defibrillator)) {
    var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1.origin);

    if(isDefined(var_1.angles))
      var_2.angles = var_1.angles;

    var_2 setModel("_encstr_A2C71E6B59C82DC60BB1F519B2664B319CA5C6D8583AF69C7DDD0BD836FA0613");
    var_2 makeusable();
    var_2 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
    var_2 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
    var_2 sethintdisplayfov(120);
    var_2 setusefov(120);
    var_2 setuserange(80);
    var_2 setHintString(&"_encstr_AB4B13873150FA997FEE9F02F76B814EE6B92F1761");
    var_2 hudoutlineenable("_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8");
    var_2 setusepriority(-1);
    var_2 setasgametypeobjective();
    self.defibrillator = var_2;
  }

  var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  self.objectiveiconid = var_3;

  if(var_3 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_3, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(var_3, self);
    scripts\mp\objidpoolmanager::update_objective_state(var_3, "_encstr_930B07BB1B6B3854FF");
    scripts\mp\objidpoolmanager::update_objective_icon(var_3, "_encstr_829611A3DB903198E80F95A193EB785BB7A748");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_3, 1);
  }
}

ambulancelights() {
  wait 1;
  var_0 = anglesToForward(self.angles);
  self.fx = spawnfx(scripts\engine\utility::getfx("_encstr_AAF710F6ADB8DD622F451F1F3F41FA0710CB"), self.origin + (0, 0, 75), var_0, (0, 0, 1));
  triggerfx(self.fx);
}

ambulancethink() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.defibrillator waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
    ambulancedefibrillator(var_0);
  }
}

setuphud() {
  level.br_deadcountdownhud = [];
}

initplayer() {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }
  hideallambulancesforplayer(self);
  disableallambulancesforplayer(self);
}

hideallambulancesforteam(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = getrespawnableplayers(var_0);

    if(var_2.size > 0)
      return;
  }

  foreach(var_4 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    if(isDefined(var_4))
      hideallambulancesforplayer(var_4);
  }
}

hideallambulancesforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_respawnambulances.size; var_1++) {
    var_2 = level.br_respawnambulances[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled))
      var_2 ambulancehidefromplayer(var_0);
  }
}

ambulancehidefromplayer(var_0) {
  if(isDefined(self.defibrillator))
    self.defibrillator hudoutlinedisableforclient(var_0);

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, var_0);
}

disableallambulancesforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_respawnambulances.size; var_1++) {
    var_2 = level.br_respawnambulances[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled))
      var_2 ambulancemakeunusabletoplayer(var_0);
  }
}

ambulancemakeunusabletoplayer(var_0) {
  if(isDefined(self.defibrillator))
    self.defibrillator disableplayeruse(var_0);
}

showallambulancesforteam(var_0) {
  foreach(var_2 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    if(isDefined(var_2))
      showallambulancesforplayer(var_2);
  }
}

showallambulancesforplayer(var_0) {
  for(var_1 = 0; var_1 < level.br_respawnambulances.size; var_1++) {
    var_2 = level.br_respawnambulances[var_1];

    if(isDefined(var_2) && !istrue(var_2.disabled))
      var_2 ambulanceshowtoplayer(var_0);
  }
}

ambulanceshowtoplayer(var_0) {
  self.defibrillator hudoutlineenableforclient(var_0, "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8");
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, var_0);
}

ambulanceenabletoteam(var_0) {
  foreach(var_2 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    if(isDefined(var_2))
      ambulancemakeusabletoplayer(var_2);
  }
}

ambulancedisabletoteam(var_0) {
  foreach(var_2 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
    if(isDefined(var_2))
      ambulancemakeunusabletoplayer(var_2);
  }
}

ambulancemakeusabletoplayer(var_0) {
  self.defibrillator enableplayeruse(var_0);
}

ambulancedisable() {
  self notify("_encstr_921D09D9D9C0090D7275B4");
  self.disabled = 1;
  self.defibrillator makeunusable();
  self.defibrillator hudoutlinedisable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);

  if(isDefined(self.fx))
    self.fx delete();
}

ambulancemakeunsabletoall() {
  self.defibrillator setHintString(&"_encstr_83F0174D377F247AC6A12F0FC97D3788C72684F69E4748BEED");
  self.defibrillator setuseholdduration("_encstr_97C20EB5FD43A179CC6AD05152651579");
}

ambulancemakeusable() {
  self.defibrillator setHintString(&"_encstr_AB4B13873150FA997FEE9F02F76B814EE6B92F1761");
  self.defibrillator setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_0 = getallrespawnableplayers();

  foreach(var_2 in var_0)
  var_2.respawnent useentsetupcloseambulance(var_2.team);
}

anyambulancesavailable() {
  for(var_0 = 0; var_0 < level.br_respawnambulances.size; var_0++) {
    var_1 = level.br_respawnambulances[var_0];

    if(isDefined(var_1) && !istrue(var_1.disabled))
      return 1;
  }

  return 0;
}

dangercircletick(var_0, var_1) {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }
  for(var_2 = 0; var_2 < level.br_respawnambulances.size; var_2++) {
    var_3 = level.br_respawnambulances[var_2];

    if(isDefined(var_3) && !istrue(var_3.disabled) && distance2dsquared(var_0, var_3.origin) > var_1 * var_1) {
      var_3 ambulancedisable();
      disablerespawnscenarios(var_3);
    }
  }
}

disablerespawnscenarios(var_0) {
  var_1 = !anyambulancesavailable();

  if(!var_1 && !isDefined(var_0)) {
    return;
  }
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3.respawnent) && var_1) {
      var_3.respawnent notify("_encstr_ABF010BB581B086A6FB05E4D294972A543F0", 0);
      continue;
    }

    if(isDefined(var_0) && isDefined(var_3.usedambulance) && var_3.usedambulance == var_0) {
      var_3 notify("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");
      var_3 notify("_encstr_92A21CDB221BF5C05EAC730FCCC7A033F34B70C0FAAF2D7872870977FE2F");
    }
  }
}

playershoulddofauxdeath() {
  return istrue(level.br_respawn_enabled) && anyambulancesavailable() && (istrue(self.brwasinlaststand) || isDefined(self.respawnent));
}

playersetinlaststand() {
  self.brwasinlaststand = 1;
  _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("_encstr_A5510A30AA778D28B3C97D51");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_id_1319E(1);
}

playerdied(var_0, var_1) {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }
  if(isDefined(var_0))
    var_0 playertrytakedefibrillator(var_1);

  if(!anyambulancesavailable()) {
    if(istrue(self.fauxdead))
      thread scripts\mp\playerlogic::spawnspectator(self.origin, self.angles);

    return;
  }

  self.brwasinlaststand = undefined;
  var_2 = self.team;

  if(level.teamdata[var_2]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size == 0) {
    foreach(var_5 in level.teamdata[var_2]["_encstr_9775086022BE1B413B8B"]) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(isDefined(var_5.respawnent))
        var_5.respawnent notify("_encstr_ABF010BB581B086A6FB05E4D294972A543F0", 0);
    }

    return;
  }

  if(isDefined(self.body))
    self.body delete();
  else
    self.nocorpse = 1;

  self playerhide();
  self.health = 1;
  thread playerkeeploadingstreamedassets();
  var_7 = createpickupuseent(self.origin, var_2);
  var_7.timerhud = createplayerdeadcountdownhud(var_2, 180);
  updatecountdownhudlist(var_7.timerhud);
  var_7.drophud = createdropplayerhud(var_2);
  var_7 thread useentrespawntimeout(180, self, var_2);
  var_7 thread useentrespawncomplete(self, var_2);
  var_7 thread useentpickupbody(self, var_2);
  var_7 useentsetupcloseambulance(var_2);
  self.respawnent = var_7;
  playerfakespectate(1);
}

updatecountdownhudlist(var_0) {
  var_1 = -50;
  var_2 = -100;
  var_3 = -15;

  if(isDefined(var_0))
    level.br_deadcountdownhud[level.br_deadcountdownhud.size] = var_0;

  for(var_4 = 1; var_4 < level.br_deadcountdownhud.size; var_4++) {
    var_5 = level.br_deadcountdownhud[var_4];

    for(var_6 = var_4 - 1; var_6 >= 0 && getsoonerhud(var_5, level.br_deadcountdownhud[var_6]) == var_5; var_6--)
      level.br_deadcountdownhud[var_6 + 1] = level.br_deadcountdownhud[var_6];

    level.br_deadcountdownhud[var_6 + 1] = var_5;
  }

  for(var_4 = 0; var_4 < level.br_deadcountdownhud.size; var_4++) {
    var_5 = level.br_deadcountdownhud[var_4];

    if(isDefined(var_5))
      var_5 scripts\mp\hud_util::setpoint("_encstr_88C70D24A7A2A27A5308A44A74218A", "_encstr_88C70D24A7A2A27A5308A44A74218A", var_1, var_2 + var_3 * var_4);
  }
}

getsoonerhud(var_0, var_1) {
  if(!isDefined(var_1))
    return var_0;

  if(!isDefined(var_0))
    return var_1;

  if(var_0.starttime <= var_1.starttime)
    return var_0;
  else
    return var_1;
}

playerfakespectate(var_0) {
  var_1 = !var_0;
  self allowmelee(var_1);
  self allowads(var_1);
  self allowfire(var_1);
  self allowcrouch(var_1);
  self allowprone(var_1);
  self allowreload(var_1);
  self setCanDamage(var_1);

  if(var_1) {
    self enableusability();
    self enableoffhandweapons();
    self unlink();
    self setcamerathirdperson(0);
    self notify("_encstr_B868110FA8FF73989140336B63CD329341B955");
    self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", -1);
  } else {
    self disableusability();
    self disableoffhandweapons();
    thread playerfakespectatecontrols();
    self setcamerathirdperson(1);
  }
}

playerfakespectatecontrols() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B868110FA8FF73989140336B63CD329341B955");
  var_0 = undefined;

  for(;;) {
    var_1 = self fragButtonPressed();
    var_2 = self secondaryoffhandbuttonPressed();

    if(var_1 || var_2 || !isDefined(var_0) || !isalive(var_0) || isDefined(var_0.respawnent) || istrue(var_0.fauxdead)) {
      var_3 = getplayertospectate(self.team, var_0, var_1 || !isDefined(var_0));

      if(!isDefined(var_0) || var_0 != var_3) {
        var_0 = var_3;
        self playerlinktodelta(var_0, "_encstr_A130084D2FDAD8AA8F62");
        self setclientomnvar("_encstr_873F149B19B9F053DF2BBE2343AF9E804E7C3379ADDF", var_0 getentitynumber());
        self playerhide();
      }

      if(var_1) {
        while(self fragButtonPressed())
          waitframe();
      } else if(var_2) {
        while(self secondaryoffhandbuttonPressed())
          waitframe();
      }
    }

    waitframe();
  }
}

getplayertospectate(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_1)) {
    for(var_4 = 0; var_4 < level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size; var_4++) {
      var_5 = level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"][var_4];

      if(var_5 == var_1) {
        var_3 = var_4;
        break;
      }
    }
  }

  if(var_2)
    var_3 = (var_3 + 1) % level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size;
  else {
    var_3--;

    if(var_3 < 0)
      var_3 = level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"].size - 1;
  }

  return level.teamdata[var_0]["_encstr_AD1C0D291D61B8BD11ABE3DBA71BFE"][var_3];
}

playerkeeploadingstreamedassets() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_BA350853C128FB939DB9");
  self endon("_encstr_BA350853C128FB939DB9");

  for(;;) {
    var_0 = scripts\mp\class::preloadandqueueclass(self.class, 1);
    var_1 = scripts\mp\playerlogic::getplayerassets(var_0);

    while(!scripts\mp\playerlogic::allplayershaveassetsloaded(var_1))
      wait 0.1;

    while(scripts\mp\playerlogic::allplayershaveassetsloaded(var_1))
      wait 1.0;
  }
}

playertrytakedefibrillator(var_0) {
  if(isalive(self) && isDefined(var_0) && isDefined(var_0.basename) && var_0.basename == "_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2" && self hasweapon("_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2")) {
    self takeweapon("_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2");
    var_1 = self getweaponslistprimaries();

    if(var_1.size > 0 && !scripts\mp\utility\weapon::update_health_bar_to_player(var_1[0]))
      self switchtoweapon(var_1[0]);
    else if(var_1.size > 1 && !scripts\mp\utility\weapon::update_health_bar_to_player(var_1[1]))
      self switchtoweapon(var_1[1]);
    else if(self hasweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C"))
      self switchtoweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    else {
      self giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
      self switchtoweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    }

    self notify("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");
    self notify("_encstr_92A21CDB221BF5C05EAC730FCCC7A033F34B70C0FAAF2D7872870977FE2F");
  }
}

useentrespawntimeout(var_0, var_1, var_2) {
  self endon("_encstr_ABF010BB581B086A6FB05E4D294972A543F0");
  var_1 scripts\engine\utility::_id_143BF(var_0, "_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_995408F398012F656821");
  waittillframeend;

  foreach(var_4 in level.teamdata[var_2]["_encstr_9775086022BE1B413B8B"]) {
    if(isDefined(var_4) && isDefined(var_4.usedambulance) && isDefined(self.ambulance) && var_4.usedambulance == self.ambulance)
      var_4 notify("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");
  }

  if(isDefined(var_1)) {
    var_1 playerfakespectate(0);
    var_1 thread scripts\mp\playerlogic::spawnspectator(var_1.respawnent.origin, var_1.respawnent.angles);
  }

  cleanupbodydrop(self, var_2);
}

useentrespawncomplete(var_0, var_1) {
  self endon("_encstr_995408F398012F656821");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self waittill("_encstr_ABF010BB581B086A6FB05E4D294972A543F0", var_2);

  if(istrue(var_2)) {
    if(isDefined(var_0.body))
      var_0.body delete();

    var_0 playerrespawn(self.origin, self.angles);
  } else if(isDefined(var_0)) {
    var_0 playerfakespectate(0);
    var_0 thread scripts\mp\playerlogic::spawnspectator(var_0.respawnent.origin, var_0.respawnent.angles);
  }

  waittillframeend;
  cleanupbodydrop(self, var_1);
}

playerrespawn(var_0, var_1) {
  playerfakespectate(0);
  self.forcespawnorigin = var_0;
  self.forcespawnangles = var_1;
  self.isrespawn = 1;
  self.alreadyaddedtoalivecount = 1;
  scripts\mp\playerlogic::spawnplayer(0, 0);
}

useentpickupbody(var_0, var_1) {
  self endon("_encstr_ABF010BB581B086A6FB05E4D294972A543F0");
  self endon("_encstr_995408F398012F656821");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isDefined(var_0.body))
      var_0.body delete();

    if(var_2.team != var_1) {
      continue;
    }
    useenthide(var_1);
    var_2 playerpickupbody(self, var_1);
    useentshow(var_1);
  }
}

useenthide(var_0) {
  self makeunusable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
}

useentshow(var_0) {
  self makeusable();
  scripts\mp\objidpoolmanager::objective_teammask_single(self.objectiveiconid, var_0);
  objective_setplayintro(self.objectiveiconid, 0);
}

playerpickupbody(var_0, var_1) {
  self endon("_encstr_97120C8C397B1CC1598C90F691BC");
  var_2 = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 1.5);
  var_2 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, 120);
  var_2.label = &"_encstr_8E9F133514CB2492FA942A6A14827527BE84F48856";
  self.holdingbodyhud = var_2;

  if(isDefined(var_0.ambulance)) {
    var_0.ambulance ambulancedisabletoteam(var_1);
    var_0.ambulance = undefined;
  }

  var_0 scriptmodelplayanim("_encstr_86C91C87817EB123B8DE34FD73B0698A5D5F0F47692A791018232B46E9C0");
  var_0 linkTo(self, "_encstr_B4DF0E4DFAC663163BD21B1B59AFB12B", (0, 0, 0), (0, 0, 0));
  var_0 thread useentdropbodyonplayerdone(self, var_2, var_1);
  var_0 thread useentdropbodywhencomplete(self, var_2, var_1);
  var_0 thread useentmonitorambulances(var_1);
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  playersetcarryteammates(1);
  showallambulancesforteam(var_1);

  foreach(var_4 in level.teamdata[var_1]["_encstr_9775086022BE1B413B8B"]) {
    if(isDefined(var_4)) {
      var_4 notify("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");
      var_4 thread scripts\mp\hud_message::showsplash("_encstr_9B061189937D9C2BB9E058DDDC7DE6470B9CD1");
    }
  }

  while(!self stancebuttonPressed() || !self isonground())
    waitframe();

  dropbody(var_0, self, var_2, var_1);
}

playersetcarryteammates(var_0) {
  self.carrying = var_0;
  var_1 = level.teamdata[self.team]["_encstr_9775086022BE1B413B8B"];

  foreach(var_3 in var_1) {
    if(isDefined(var_3.respawnent)) {
      if(!var_0) {
        var_3.respawnent enableplayeruse(self);
        continue;
      }

      var_3.respawnent disableplayeruse(self);
    }
  }
}

useentdropbodyonplayerdone(var_0, var_1, var_2) {
  self endon("_encstr_97120C8C397B1CC1598C90F691BC");
  var_0 scripts\engine\utility::_id_143A6("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_AD75063D571AE108", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  dropbody(self, var_0, var_1, var_2);
}

useentdropbodywhencomplete(var_0, var_1, var_2) {
  self endon("_encstr_97120C8C397B1CC1598C90F691BC");
  scripts\engine\utility::_id_143A5("_encstr_995408F398012F656821", "_encstr_ABF010BB581B086A6FB05E4D294972A543F0");
  dropbody(self, var_0, var_1, var_2);
}

dropbody(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_1 allowads(1);
    var_1 allowcrouch(1);
    var_1 allowprone(1);
    var_1 allowjump(1);
    var_1 playersetcarryteammates(0);
  }

  if(isDefined(var_2))
    var_2 destroy();

  if(var_0 islinked())
    var_0 unlink();

  var_4 = undefined;

  if(isDefined(var_1)) {
    var_0.angles = var_1.angles;
    var_4 = var_1.origin;
    var_0.origin = var_4 + (0, 0, 40);
  } else {
    var_4 = var_0.origin;
    var_0.origin = var_4 + (0, 0, 40);
  }

  var_0.drophud.alpha = 0.0;
  var_0 useentsetupcloseambulance(var_3);
  var_0 scriptmodelplayanim("_encstr_BABF29E6919CFA6C07FA1ABDB9A3C2CECAFA8C4EDBC1B799CCFA3B27EDBA7332BE4B9136ACEB0E9636B71D");
  var_0 scriptmodelpauseanim(1);
  var_0.origin = var_4 + (0, 0, 1);
  var_0 notify("_encstr_97120C8C397B1CC1598C90F691BC");
}

useentsetupcloseambulance(var_0) {
  var_1 = getcloseambulance(self.origin);

  if(isDefined(var_1)) {
    self.ambulance = var_1;
    var_1 ambulanceenabletoteam(var_0);
  }
}

createpickupuseent(var_0, var_1) {
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 + (0, 0, 1));
  var_2 setModel("_encstr_83E11DCCEA8DB126EDC82FF5BAE6D6C6AF164EFA9B6CC996E03AD6DE3B954E");
  var_2 scriptmodelplayanim("_encstr_BABF29E6919CFA6C07FA1ABDB9A3C2CECAFA8C4EDBC1B799CCFA3B27EDBA7332BE4B9136ACEB0E9636B71D");
  var_2 scriptmodelpauseanim(1);
  var_2 makeusable();
  var_2 setCursorHint("_encstr_829A0C23D4C1F35E818FDB4134BD");
  var_2 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");
  var_2 setuserange(120);
  var_2 setHintString(&"_encstr_978D14F8A977B66BF63F594B5A5FAB0971A1A031B925");
  var_2 setusepriority(0);
  var_2 hudoutlineenable("_encstr_847E18A5C56942E140B80307C8389F2A07D5AF1A2DF9C922C958");

  foreach(var_4 in level.players) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4.team == var_1) {
      var_2 hudoutlineenableforclient(var_4, "_encstr_847E18A5C56942E140B80307C8389F2A07D5AF1A2DF9C922C958");

      if(!istrue(var_4.carrying))
        var_2 enableplayeruse(var_4);

      continue;
    }

    var_2 disableplayeruse(var_4);
    var_2 hudoutlinedisableforclient(var_4);
  }

  var_6 = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  var_2.objectiveiconid = var_6;

  if(var_6 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_6, "_encstr_A2BE0AB4DC3BB46E5A981BAC", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(var_6, var_2);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_6, 40);
    scripts\mp\objidpoolmanager::update_objective_state(var_6, "_encstr_AF5A081BBAC993AC73A3");
    scripts\mp\objidpoolmanager::update_objective_icon(var_6, "_encstr_A17D1C68FA3217D82365A8BB7B9FE0875C026810C38C17506BB74AA35CFB");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_6, 1);
    scripts\mp\objidpoolmanager::objective_teammask_single(var_6, var_1);
  }

  return var_2;
}

createplayerdeadcountdownhud(var_0, var_1) {
  var_2 = scripts\mp\hud_util::createservertimer("_encstr_9A2B0A12F03587575B7BBEA5", 1.4, var_0);
  var_2.label = &"_encstr_8A771E49FA1E6DAFBF93F95183F9473D6197D5C743C08F7547A7A961BBDF9FC5";
  var_2 settimer(var_1);
  var_2.starttime = gettime();
  thread countdownhudpulse(var_2);
  return var_2;
}

countdownhudpulse(var_0) {
  var_1 = 0.5;
  var_2 = 2;
  var_3 = var_0.fontscale;
  var_0 changefontscaleovertime(var_1);
  var_0.fontscale = var_2;
  wait(var_1);

  if(isDefined(var_0)) {
    var_0 changefontscaleovertime(var_1);
    var_0.fontscale = var_3;
  }
}

cleanupbodydrop(var_0, var_1) {
  if(isDefined(var_0.timerhud))
    var_0.timerhud destroy();

  updatecountdownhudlist();

  if(isDefined(var_0.drophud))
    var_0.drophud destroy();

  if(isDefined(var_0.ambulance)) {
    var_0.ambulance ambulancedisabletoteam(var_1);
    var_0.ambulance = undefined;
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  var_0 delete();
  hideallambulancesforteam(var_1, 1);
}

useentmonitorambulances(var_0) {
  self endon("_encstr_97120C8C397B1CC1598C90F691BC");
  var_1 = 0;

  for(;;) {
    var_2 = 0;

    for(var_3 = 0; var_3 < level.br_respawnambulances.size; var_3++) {
      var_4 = level.br_respawnambulances[var_3];

      if(!isDefined(var_4) || istrue(var_4.disabled)) {
        continue;
      }
      var_5 = var_4.origin;

      foreach(var_7 in level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"]) {
        if(!isDefined(var_7)) {
          continue;
        }
        var_8 = distancesquared(var_5, var_7.origin);

        if(var_8 < 65536) {
          var_2 = 1;
          break;
        }
      }

      if(var_2) {
        break;
      }
    }

    if(!var_1 && var_2)
      self.drophud.alpha = 1.0;
    else if(var_1 && !var_2)
      self.drophud.alpha = 0.0;

    var_1 = var_2;
    wait 0.1;
  }
}

createdropplayerhud(var_0) {
  var_1 = 1.3;
  var_2 = newteamhudelem(var_0);
  var_2.elemtype = "_encstr_9779056EEA2583";
  var_2.font = "_encstr_8B1608EC43B8D647A113";
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 scripts\mp\hud_util::setparent(level.uiparent);
  var_2.hidden = 0;
  var_2.alpha = 0;
  var_2 scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_A5C407E57585313DB1", 0, 100);
  var_2.label = &"_encstr_BE47181D67A843D2FFA96019A19BDB3B1EC58A879F4E9BADE199";
  return var_2;
}

getrespawnableplayers(var_0) {
  var_1 = level.teamdata[var_0]["_encstr_9775086022BE1B413B8B"];
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.respawnent))
      var_2[var_2.size] = var_4;
  }

  return var_2;
}

getallrespawnableplayers() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isDefined(var_2.respawnent))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

getcloseambulance(var_0) {
  for(var_1 = 0; var_1 < level.br_respawnambulances.size; var_1++) {
    var_2 = level.br_respawnambulances[var_1];

    if(!isDefined(var_2) || istrue(var_2.disabled)) {
      continue;
    }
    var_3 = distancesquared(var_2.origin, var_0);

    if(var_3 < 65536)
      return var_2;
  }
}

ambulancedefibrillator(var_0) {
  if(var_0 hasweapon("_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2")) {
    var_0 switchtoweapon("_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2");
    return;
  }

  thread ambulancedosiren();
  var_0.usedambulance = self;
  self.defibrillator hide();
  var_1 = var_0 playergivedefibrillator(self);

  if(isDefined(var_0)) {
    var_0 notify("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");
    var_0.usedambulance = undefined;
  }

  self.defibrillator show();

  if(isDefined(var_1)) {
    var_1.respawnent notify("_encstr_ABF010BB581B086A6FB05E4D294972A543F0", 1);
    ambulancedelayreuse();
  }
}

ambulancedelayreuse() {
  self endon("_encstr_921D09D9D9C0090D7275B4");
  ambulancemakeunsabletoall();
  wait 30;
  ambulancemakeusable();
}

ambulancedosiren() {
  self notify("_encstr_9A2211B0B53157632C378DAC447B9AA5E4B2B9");
  self endon("_encstr_9A2211B0B53157632C378DAC447B9AA5E4B2B9");
  self playLoopSound("_encstr_A7F7139BB4E495CDEB2C5B265D1B85E6B156FAD81C");
  wait 30;
  self stoploopsound();
}

playergivedefibrillator(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self endon("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");
  var_1 = getrespawnableplayers(self.team);

  if(var_1.size == 0)
    self iprintlnbold("_encstr_A93A1298CF16401A0A048A43AD3FE0885F1DDFB2");
  else {
    self.lastweaponrespawn = self getcurrentprimaryweapon();
    var_2 = getcompleteweaponname("_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2");
    self giveweapon(var_2);
    self switchtoweapon(var_2);
    thread playermonitorweaponchange(var_2);
    thread playertakeawaydefibrillator(var_2);
    thread playermonitordistancefromambulance(var_0);
  }
}

playerdodefibrillator(var_0) {
  for(;;) {
    self waittill("_encstr_83470C2D85B1F9E7FEDDF40887A4", var_1);
    var_2 = 0;

    if(var_1.basename != "_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2") {
      if(!self hasweapon("_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2"))
        return;
    } else {
      var_3 = self getEye();
      var_4 = anglesToForward(self getplayerangles());
      var_5 = getrespawnableplayers(self.team);
      var_6 = 0;

      for(var_7 = 0; var_7 < var_5.size; var_7++) {
        var_8 = var_5[var_7];

        if(!isDefined(var_8) || !isDefined(var_8.respawnent)) {
          continue;
        }
        var_6 = 1;
        var_9 = var_8.respawnent.origin + (0, 0, 40);
        var_10 = vectorNormalize(var_9 - var_3);
        var_11 = vectordot(var_10, var_4);

        if(var_11 < 0.5) {
          continue;
        }
        var_12 = distancesquared(self.origin, var_9);

        if(var_12 > 10000) {
          continue;
        }
        return var_8;
      }

      if(!var_6 && istrue(var_0)) {
        self iprintlnbold("_encstr_843D17F317D783A5B018F5FE13B8FB7E55BFD28BFB249A8EC8");
        return;
      }
    }
  }
}

playermonitorweaponchange(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self endon("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");

  for(;;) {
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", var_1);

    if(!isnullweapon(var_0, var_1)) {
      self notify("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");
      return;
    }
  }
}

playertakeawaydefibrillator(var_0) {
  scripts\engine\utility::_id_143A6("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B", "_encstr_BA051391CA335A89395AD8360B47B727F546F67359");

  if(isDefined(self) && self hasweapon(var_0)) {
    self takeweapon(var_0);
    self switchtoweapon(self.lastweaponrespawn);
  }
}

playermonitordistancefromambulance(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  self endon("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");

  for(;;) {
    var_1 = distancesquared(var_0.origin, self.origin);

    if(var_1 > 65536) {
      self notify("_encstr_BA051391CA335A89395AD8360B47B727F546F67359");
      return;
    }

    wait 0.1;
  }
}

giveweaponpickup(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!istrue(level.br_respawn_enabled)) {
    return;
  }
  if(var_0 != "_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2") {
    return;
  }
  var_1 = playerdoportabledefibrillator();

  if(isDefined(var_1)) {
    if(isDefined(var_1.body))
      var_1.body delete();

    var_1.respawnent notify("_encstr_ABF010BB581B086A6FB05E4D294972A543F0", 1);
  }

  var_2 = getcompleteweaponname("_encstr_8EFF1569EFC2D19BBDD98A026383F355508117FA27C0A2");
  playertrytakedefibrillator(var_2);
}

playerdoportabledefibrillator() {
  self endon("_encstr_92A21CDB221BF5C05EAC730FCCC7A033F34B70C0FAAF2D7872870977FE2F");
  return playerdodefibrillator();
}