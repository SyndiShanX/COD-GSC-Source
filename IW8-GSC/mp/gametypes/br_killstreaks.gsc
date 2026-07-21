/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_killstreaks.gsc
***********************************************/

init() {
  level._encstr_B2D9130A7F9587AF85EDD8C35332DBE0E84BB828C4 = getdvarint("_encstr_A2611C363AF357AA83AF0A5E2097BA109F4EFFE0CB755999432B3B2A618B", 1000);
  level._encstr_B290128AD81217EA7388DF33E3FAAB5794B5D8EB = getdvarint("_encstr_910F1BD753B2D116EBE99921E2675D7001A66741F11FB8F0F743D0A9CB", 1);
}

playercanpickupkillstreak() {
  return !isDefined(self.brkillstreak);
}

takekillstreakpickup(var_0) {
  var_1 = level.br_pickups.br_equipname[var_0.scriptablename];
  self.brkillstreak = var_1;
  playerkillstreakhud(var_1);
  playergivetriggerweapon();
  thread playerhandlekillstreak(var_1);
}

playerkillstreakhud(var_0) {
  self.brkillstreakhudlabel = scripts\mp\hud_util::createfontstring("_encstr_8B1608EC43B8D647A113", 0.75);
  self.brkillstreakhudlabel scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_92D20C1DD7833128BF86F4DD0833", 270, -70);
  self.brkillstreakhudlabel.label = &"_encstr_87A81A45A9F19E5BB83510691C144F4349CFCBD939D1128BC6AD0880";
  var_1 = game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"].tabledatabyref[var_0]["_encstr_BE6C080DBA2392367BE6"];
  self.brkillstreakhudicon = scripts\mp\hud_util::createicon(var_1, 30, 30);
  self.brkillstreakhudicon scripts\mp\hud_util::setpoint("_encstr_A5C407E57585313DB1", "_encstr_92D20C1DD7833128BF86F4DD0833", 270, -45);
}

playergivetriggerweapon() {
  self giveweapon("_encstr_88B611B95D0EAC27EB9159CC16AE8D47FA6BC1");
  self setweaponammoclip("_encstr_88B611B95D0EAC27EB9159CC16AE8D47FA6BC1", 1);
  self assignweaponoffhandspecial("_encstr_88B611B95D0EAC27EB9159CC16AE8D47FA6BC1");
}

playerhandlekillstreak(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_AA22154B3A4D309B228BFFA7C74A5F08EE59518022B5C0", var_1);
    var_2 = playertriggerkillstreak();

    if(var_2) {
      playerremovekillstreak();
      return;
    } else
      self setweaponammoclip("_encstr_88B611B95D0EAC27EB9159CC16AE8D47FA6BC1", 1);
  }
}

playertriggerkillstreak() {
  if(!isalive(self))
    return 0;

  var_0 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct(self.brkillstreak);
  var_1 = scripts\mp\killstreaks\killstreaks::triggerkillstreak(var_0);
  return istrue(var_1);
}

playerremovekillstreak() {
  self takeweapon("_encstr_88B611B95D0EAC27EB9159CC16AE8D47FA6BC1");
  self.brkillstreak = undefined;

  if(isDefined(self.brkillstreakhudlabel))
    self.brkillstreakhudlabel destroy();

  if(isDefined(self.brkillstreakhudicon))
    self.brkillstreakhudicon destroy();
}

isbulletpenetration(var_0, var_1, var_2, var_3) {
  var_4 = scripts\common\utility::playersincylinder(var_0, var_1, undefined, level._encstr_B2D9130A7F9587AF85EDD8C35332DBE0E84BB828C4);

  if(!isDefined(var_3))
    var_3 = 1;

  foreach(var_8 in var_4) {
    if(isDefined(var_8) && scripts\mp\utility\player::isreallyalive(var_8) && (var_8.team != self.team || level._encstr_B290128AD81217EA7388DF33E3FAAB5794B5D8EB && var_8 == self))
      isbrsquadleader(var_8, var_2, var_3);
  }
}

isbrsquadleader(var_0, var_1, var_2, var_3) {
  if(isDefined(level.isbotpracticematch) && isDefined(level.isbrgametypefuncdefined)) {
    if(isDefined(level.isbrgametypefuncdefined[var_1]) && isDefined(level.isbrgametypefuncdefined[var_1][var_0.guid]) && gettime() < level.isbrgametypefuncdefined[var_1][var_0.guid])
      var_2 = 0;
    else
      level.isbrgametypefuncdefined[var_1][var_0.guid] = gettime() + level.isbotpracticematch * 1000;
  }

  if(istrue(var_2) && scripts\mp\utility\killstreak::getkillstreakenemyusedialogue(var_1)) {
    var_4 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::disableannouncer(self);
    var_5 = var_4 + "_encstr_9116087DACCD56DAE57D" + var_1 + "_encstr_86FF098F7BCD431D2BC8F2";
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer(var_5, "_encstr_AFC610DA4059C3AAD865EDF14F59F3777559");
  }

  var_6 = spawnStruct();
  var_6._id_12466 = istrue(var_2);
  var_6._id_11ED2 = var_1;

  switch (var_1) {
    case "_encstr_A2E60C6BC099B7E1A0A93A398F48":
      var_1 = 1;
      break;
    case "_encstr_BDF5147B33CD0FDC1043F7CE17B8E4036E6BD3927895":
      var_1 = 2;
      break;
    case "_encstr_B8BA0DD16B8B8708F94BF9C7635FD8":
      var_1 = 3;
      break;
    case "_encstr_B8BB13512AF703C9374DC1C17F58015E5322AB19E2":
      var_1 = 4;
      break;
    case "_encstr_A7A811E456E61C16DDCDAF912DB958C4C62B19":
      var_1 = 5;
      break;
    case "_encstr_B69D106CCB80D1DBB8B80AD1430D8B145BA3":
      var_1 = 6;
      break;
    case "_encstr_B8FF0F509F66E8E77AAE405EC3F31BD0D5":
      var_1 = 7;
      break;
    case "_encstr_9B7310AFD59D7A46303148D96B5882726203":
      var_1 = 8;
      break;
    case "_encstr_81670D21FA73537009AB392DA96C80":
      var_1 = 9;
      break;
    default:
      var_1 = 0;
      break;
  }

  if(var_1 > 0) {
    var_0 setclientomnvar("_encstr_8CD3154B50A78EDBE63561965C4913192FB88372C8AD87", var_1);
    isbunkeraltenabled(var_0, var_3);
  }

  var_0 _encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::_id_12E05("_encstr_A73D132F4D2A1AE4E0136BF2C9503B4487F5879F1D", var_6);
}

isbunkeraltenabled(var_0, var_1) {
  var_2 = var_0 getxuid();

  if(!isDefined(var_1))
    var_1 = 4;

  level notify("_encstr_8631157238EDF7BF6BB0767F3DD06BB86750FBBA0861A1" + var_2);
  level thread _id_14499(var_0, var_2, "_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level thread _id_14499(var_0, var_2, undefined, var_1);
}

_id_14499(var_0, var_1, var_2, var_3) {
  level endon("_encstr_8631157238EDF7BF6BB0767F3DD06BB86750FBBA0861A1" + var_1);
  level endon("_encstr_AD6F183258E63B56E4BEB9B7A3D299BCF59996B9A59B34B28CBE" + var_1);
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_2))
    var_0 waittill(var_2);
  else if(isDefined(var_3))
    wait(var_3);

  if(isDefined(var_0))
    var_0 setclientomnvar("_encstr_8CD3154B50A78EDBE63561965C4913192FB88372C8AD87", 0);

  level notify("_encstr_AD6F183258E63B56E4BEB9B7A3D299BCF59996B9A59B34B28CBE" + var_1);
}