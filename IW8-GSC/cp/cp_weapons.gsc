/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_weapons.gsc
***********************************************/

cp_weapons_init() {
  level.getactiveequipmentarray = ::getactiveequipmentarray;
}

getactiveequipmentarray() {
  return scripts\engine\utility::array_remove_duplicates(level.mines);
}

special_weapon_logic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = var_5.basename;

  if(!isDefined(var_12)) {
    return;
  }
  if(self.health - var_2 < 1) {
    if(isDefined(level.lethaldamage_func))
      [[level.lethaldamage_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }
}

kill_me_after_timeout(var_0, var_1) {
  if(isDefined(var_1))
    self endon(var_1);

  wait(var_0);
  self suicide();
}

should_take_players_current_weapon(var_0) {
  var_1 = 3;

  if(var_0 scripts\cp\utility::has_zombie_perk("_encstr_B6921259DD2AE8AF1FB2F1981A3BC591053FA5FB"))
    var_1 = 4;

  var_2 = var_0 getweaponslist("_encstr_BA7F0830B3A7859B60B0");
  return var_2.size >= var_1;
}

showonscreenbloodeffects() {
  self notify("_encstr_A32C18D3EBC61AA788203102B958A5E2902703CBB7E0026F60C8");
  self endon("_encstr_A32C18D3EBC61AA788203102B958A5E2902703CBB7E0026F60C8");
  self setscriptablepartstate("_encstr_AD9910BDCD7D371B9395599BEBC463ED7B46", "_encstr_AB0703DBB9");
  scripts\engine\utility::_id_143BA(2, "_encstr_AD75063D571AE108", "_encstr_8CBE0BD1BED30936AB03C0B02B");
  self setscriptablepartstate("_encstr_AD9910BDCD7D371B9395599BEBC463ED7B46", "_encstr_A7A408B9CA5D1D4E2C63");
}

weapon_watch_hint() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.axe_hint_display = 0;
  self.nx1_hint_display = 0;
  self.forgefreeze_hint_display = 0;
  var_0 = self getcurrentprimaryweapon();
  var_1 = var_0 getbaseweapon();
  var_2 = self getcurrentweapon();
  var_3 = undefined;

  for(;;) {
    if(isDefined(var_1) && var_1.basename == "_encstr_8B060B2DDDE6BE0B0F95FAD3D6" && self.axe_hint_display < 3) {
      scripts\cp\utility::setlowermessage("_encstr_91660DDAB976D7583CACBE1A96731D", &"_encstr_A791130DA0FAB4F4A984942A970A2C8A7D24259345", 4);
      self.axe_hint_display = self.axe_hint_display + 1;
    } else if(isDefined(var_1) && var_1.basename == "_encstr_B6271396DDCDD766DB27D9AC3393B256F4CA7D9EAD" && self.forgefreeze_hint_display < 5) {
      scripts\cp\utility::setlowermessage("_encstr_91660DDAB976D7583CACBE1A96731D", &"_encstr_B1421BA1B969752CFF92737DC7EB14ADC77001D15437CD25DFF06BC054", 4);
      self.forgefreeze_hint_display = self.forgefreeze_hint_display + 1;
    }

    updatecamoscripts(var_2, var_3);
    var_3 = var_2;
    self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
    wait 0.5;
    var_0 = self getcurrentprimaryweapon();
    var_1 = var_0 getbaseweapon();
    var_2 = self getcurrentweapon();
  }
}

updatecamoscripts(var_0, var_1) {
  if(isDefined(var_0))
    var_2 = getweaponcamoname(var_0);
  else
    var_2 = undefined;

  if(isDefined(var_1))
    var_3 = getweaponcamoname(var_1);
  else
    var_3 = undefined;

  if(!isDefined(var_2))
    var_2 = "_encstr_8BBA05185F8B99";

  if(!isDefined(var_3))
    var_3 = "_encstr_8BBA05185F8B99";

  clearcamoscripts(var_1, var_3);
  runcamoscripts(var_0, var_2);
}

runcamoscripts(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "_encstr_AC9E08EE87E3CA7263C2":
      self setscriptablepartstate("_encstr_82C8091F53397AD7125B3A", "_encstr_88F20627959BCAE8");
      break;
    case "_encstr_919E088D2CADBDC862C8":
      self setscriptablepartstate("_encstr_BDC809DE36BAB78E529EC2", "_encstr_88F20627959BCAE8");
      break;
    case "_encstr_BE9E0846AE222FABD832":
      self setscriptablepartstate("_encstr_A7C80919BE7B70B71D9AE1", "_encstr_85AD0950914BBF136ACB7F");
      break;
    case "_encstr_929E083F415222C2C333":
      self setscriptablepartstate("_encstr_ABC809362C5B7BF564609A", "_encstr_85AD0950914BBF136ACB7F");
      break;
    case "_encstr_AB9207FEE9DD779322":
      thread blood_camo_84();
      break;
    case "_encstr_849E08E810BB97DA9A36":
      thread blood_camo_222();
      break;
  }
}

clearcamoscripts(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  switch (var_1) {
    case "_encstr_BE9E0846AE222FABD832":
      self setscriptablepartstate("_encstr_A7C80919BE7B70B71D9AE1", "_encstr_A7A408B9CA5D1D4E2C63");
      break;
    case "_encstr_929E083F415222C2C333":
      self setscriptablepartstate("_encstr_ABC809362C5B7BF564609A", "_encstr_A7A408B9CA5D1D4E2C63");
      break;
    case "_encstr_AB9207FEE9DD779322":
      self notify("_encstr_A6600E9229882D6B50691AC2F088D233");
      break;
    case "_encstr_849E08E810BB97DA9A36":
      self notify("_encstr_8E370FD57CD570357FCAD94012A7D6523A");
      break;
  }
}

blood_camo_84() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_A6600E9229882D6B50691AC2F088D233");

  if(!isDefined(self.bloodcamokillcount))
    self.bloodcamokillcount = 0;

  var_0 = 1;

  for(;;) {
    self waittill("_encstr_B41F0E73E030C23263AF6CE4F1098A8C");
    self.bloodcamokillcount = self.bloodcamokillcount + 1;

    if(self.bloodcamokillcount / 5 == var_0) {
      var_1 = int(self.bloodcamokillcount / 5);

      if(var_1 > 14) {
        break;
      }

      self setscriptablepartstate("_encstr_B49D087E961A172EF86A", var_1 + "_encstr_9ABE07CEFC41481903");
      var_0++;
    }
  }
}

blood_camo_222() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8E370FD57CD570357FCAD94012A7D6523A");
  self.katanacamokillcount = 0;
  self setscriptablepartstate("_encstr_AAC809D816B6DEF5918C8C", "_encstr_8F1A0BC61D2813497F309AC350");
  var_0 = 1;

  for(;;) {
    self waittill("_encstr_B41F0E73E030C23263AF6CE4F1098A8C");
    self.katanacamokillcount = self.katanacamokillcount + 1;

    if(self.katanacamokillcount / 5 == var_0) {
      var_1 = int(self.katanacamokillcount / 5);

      if(var_1 > 10) {
        break;
      }

      self setscriptablepartstate("_encstr_AAC809D816B6DEF5918C8C", var_1 + "_encstr_9ABE07CEFC41481903");
      var_0++;
    }
  }
}

axe_damage_cone() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self waittill("_encstr_8CEF0E1BA08F29795F02111959032328", var_0, var_1, var_2);
    var_3 = var_0.basename;
    var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);
    var_5 = get_melee_weapon_fov(var_3, var_4);
    var_6 = get_melee_weapon_hit_distance(var_3, var_4);
    var_7 = get_melee_weapon_max_enemies(var_3, var_4);
    var_8 = checkenemiesinfov(var_5, var_6, var_7);

    foreach(var_10 in var_8) {
      if(var_10 == var_1) {
        continue;
      }
      var_10 thread axe_damage(var_10, self, var_2, var_10.origin, self.origin, var_0, 0.5);
    }
  }
}

setaxeidlescriptablestate(var_0) {
  var_0 setscriptablepartstate("_encstr_8E7F0BF3D3622752601CC1D807", "_encstr_A7A408B9CA5D1D4E2C63");
  wait 0.5;
  var_0 setscriptablepartstate("_encstr_8E7F0BF3D3622752601CC1D807", "_encstr_8A510830E7B6E8F1CE16");
}

setaxescriptablestate(var_0) {
  var_0 notify("_encstr_B1A3109B2B8E163C95981BDE7B2332C9A538");
  var_0 endon("_encstr_B1A3109B2B8E163C95981BDE7B2332C9A538");
  var_0 setscriptablepartstate("_encstr_961904BF105A", "_encstr_A7A408B9CA5D1D4E2C63");
  wait 0.5;
  var_0 setscriptablepartstate("_encstr_961904BF105A", "_encstr_83610995E3A2E07840BDA0");
  wait 5;
  var_0 setscriptablepartstate("_encstr_961904BF105A", "_encstr_A7A408B9CA5D1D4E2C63");
}

get_melee_weapon_fov(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1))
    return 45;

  switch (var_1) {
    case 2:
      return 52;
    case 3:
      return 60;
    default:
      return 45;
  }
}

get_melee_weapon_hit_distance(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1))
    return 125;

  switch (var_1) {
    case 2:
      return 150;
    case 3:
      return 175;
    default:
      return 125;
  }
}

get_melee_weapon_max_enemies(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1))
    return 1;

  switch (var_1) {
    case 2:
      return 8;
    case 3:
      return 24;
    default:
      return 4;
  }
}

get_melee_weapon_melee_damage(var_0, var_1) {
  if(!isDefined(var_0) && !isDefined(var_1))
    return 1100;

  switch (var_1) {
    case 2:
      return 1500;
    case 3:
      return 2000;
    default:
      return 1100;
  }
}

checkenemiesinfov(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 6;

  var_3 = cos(var_0);
  var_4 = [];
  var_5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("_encstr_8E8405EA382B2A");
  var_6 = scripts\engine\utility::get_array_of_closest(self.origin, var_5, undefined, 24, var_1, 1);

  foreach(var_8 in var_6) {
    var_9 = anglesToForward(self.angles);
    var_10 = vectorNormalize(var_9) * -25;
    var_11 = 0;
    var_12 = var_8.origin;
    var_13 = scripts\engine\utility::within_fov(self getEye() + var_10, self.angles, var_12 + (0, 0, 30), var_3);

    if(var_13) {
      if(isDefined(var_1)) {
        var_14 = distance2d(self.origin, var_12);

        if(var_14 < var_1)
          var_11 = 1;
      } else
        var_11 = 1;
    }

    if(var_11 && var_4.size < var_2)
      var_4[var_4.size] = var_8;
  }

  return var_4;
}

axe_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_0.allowpain = 1;
  var_0 dodamage(var_2, var_3, var_1, var_1, "_encstr_8DED0A21C79B660BC7588981", var_5);
  wait(var_6);

  if(istrue(var_0.allowpain))
    var_0.allowpain = 0;
}

_switchtoweapon(var_0) {
  self switchtoweapon(var_0);
}

_switchtoweaponimmediate(var_0) {
  self switchtoweaponimmediate(var_0);
}

_takeweapon(var_0) {
  var_1 = 0;

  if(issameweapon(var_0))
    var_1 = self gethighpriorityweapon() == var_0;
  else
    var_1 = createheadicon(self gethighpriorityweapon()) == var_0;

  if(var_1)
    self clearhighpriorityweapon(var_0);

  self takeweapon(var_0);
}

takeweaponwhensafe(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(!iscurrentweapon(var_0)) {
      break;
    }

    waitframe();
  }

  _takeweapon(var_0);
}

getcurrentreliableweaponswitchweapon() {
  validatehighpriorityflag();
  var_0 = self gethighpriorityweapon();

  if(nullweapon(var_0))
    return undefined;

  return var_0;
}

isanyreliableweaponswitchinprogress() {
  return isDefined(getcurrentreliableweaponswitchweapon());
}

isreliablyswitchingtoweapon(var_0) {
  var_1 = getcurrentreliableweaponswitchweapon();
  return isDefined(var_1) && var_1 == var_0 && !iscurrentweapon(var_0);
}

canswitchtoweaponreliably(var_0) {
  if(!self hasweapon(var_0))
    return 0;

  if(!scripts\common\utility::is_weapon_allowed())
    return 0;

  if(!scripts\common\utility::is_weapon_switch_allowed())
    return 0;

  var_1 = getcurrentreliableweaponswitchweapon();

  if(isDefined(var_1)) {
    var_2 = getweaponbasename(var_0);
    var_3 = 0;

    if(var_2 == "_encstr_9A2011B5CDAF272BADB7D1ACF56B0BC1BEB1C1" || var_2 == "_encstr_812C128152B9F8E4EA670F3B8722B8704AE1E85B" || var_2 == "_encstr_B108190EAE4BCAC6C9A07F2F3981B732355017471CAB630D96F86B" || var_2 == "_encstr_92D5124BEF5B69354B4250B8DAEBE728256FFBF1" || var_2 == "_encstr_A17810A09B234F7B6B65343E7993A0871D53")
      var_3 = 1;
    else if(weaponinventorytype(var_1) == "_encstr_BA7F0830B3A7859B60B0")
      var_3 = 1;

    if(!var_3)
      return 0;
  }

  if(iscurrentweapon(var_0))
    return 0;

  return 1;
}

abortreliableweaponswitch(var_0) {
  if(self gethighpriorityweapon() == var_0)
    self clearhighpriorityweapon(var_0);

  _takeweapon(var_0);
  return;
}

switchtoweaponreliable(var_0, var_1) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");

  if(!canswitchtoweaponreliably(var_0))
    return 0;

  if(isanyreliableweaponswitchinprogress())
    self clearhighpriorityweapon(getcurrentreliableweaponswitchweapon());

  self sethighpriorityweapon(var_0);

  if(istrue(var_1))
    _switchtoweaponimmediate(var_0);

  for(;;) {
    if(iscurrentweapon(var_0)) {
      validatehighpriorityflag();
      return 1;
    }

    if(!self ishighpriorityweapon(var_0) || !self hasweapon(var_0))
      return 0;

    if(!scripts\common\utility::is_weapon_allowed() || !scripts\common\utility::is_weapon_switch_allowed()) {
      self clearhighpriorityweapon(var_0);
      return 0;
    }

    waitframe();
  }
}

validatehighpriorityflag() {
  var_0 = self getcurrentweapon();

  if(self ishighpriorityweapon(var_0))
    self clearhighpriorityweapon(var_0);
}

getridofweapon(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!self hasweapon(var_0)) {
    return;
  }
  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return;
  }

  while(isanyreliableweaponswitchinprogress())
    waitframe();

  if(!iscurrentweapon(var_0)) {
    _takeweapon(var_0);
    return;
  }

  if(isbot(self))
    var_1 = 1;

  var_2 = switchtoweaponreliable(self.lastdroppableweaponobj, var_1);
  _takeweapon(var_0);
  self notify("_encstr_A5DB1426DB5B26D70B36B17BDDD7EDCC3343B0B9C837");

  if(!var_2)
    forcevalidweapon();
}

forcevalidweapon(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  while(nullweapon(self getcurrentweapon())) {
    if(self isswitchingweapon() || isanyreliableweaponswitchinprogress()) {
      waitframe();
      continue;
    }

    var_1 = var_0;

    if(!isDefined(var_1) || !self hasweapon(var_1)) {
      if(!isDefined(self.lastdroppableweaponobj) || self.lastdroppableweaponobj.basename == "_encstr_8BBA05185F8B99") {
        break;
      }

      var_1 = self.lastdroppableweaponobj;
    }

    var_2 = getcurrentprimaryweaponsminusalt();

    if(isDefined(var_1) && getweaponbasename(var_1) == "_encstr_82060BC06F232071438BBFC321" && self getweaponammoclip(var_1) == 0 && var_2.size == 1)
      var_1.basename = "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C";

    switchtoweaponreliable(var_1);
    waitframe();
  }
}

iscurrentweapon(var_0) {
  if(isstring(var_0))
    var_0 = asmdevgetallstates(var_0);

  return isnullweapon(self getcurrentweapon(), var_0, 1);
}

debugweaponchangeprint(var_0) {}

getcurrentprimaryweaponsminusalt() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(!var_3.isalternate)
      var_0[var_0.size] = var_3;
  }

  return var_0;
}

switchtolastweapon() {
  if(!isai(self)) {
    var_0 = scripts\cp\utility::getlastweapon();

    if(!self hasweapon(var_0))
      var_0 = scripts\cp\utility::getfirstprimaryweapon();

    _switchtoweapon(var_0);
  } else
    _switchtoweapon("_encstr_8BBA05185F8B99");
}

watchformanualweaponend(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_85D31DAEA242BB50514D3967832BF11BAE0557E8D3D709E887FA8EA398AD48" + var_0);

  if(self hasweapon(var_0)) {
    getridofweapon(var_0);
    self takeweapon(var_0);
  }
}

startfadetransition(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = scripts\engine\utility::_id_143B9(var_0, "_encstr_B44F170EF9A0B39AF17F73277328D3ED81030712932B76325D");

  if(!isDefined(var_1) || var_1 == "_encstr_B44F170EF9A0B39AF17F73277328D3ED81030712932B76325D") {
    return;
  }
  self playlocalsound("_encstr_931C204560D17FF0D85AD63B0A588FA41F35D27773DF2243F0F84AA1DFC075E757E0");
  self visionsetfadetoblackforplayer("_encstr_BA07031663", 0.5);
  var_1 = scripts\engine\utility::_id_143B9(0.5, "_encstr_AD75063D571AE108");

  if(!isDefined(var_1) || var_1 == "_encstr_AD75063D571AE108")
    self stoplocalsound("_encstr_931C204560D17FF0D85AD63B0A588FA41F35D27773DF2243F0F84AA1DFC075E757E0");

  self visionsetfadetoblackforplayer("_encstr_B40101", 0.05);
}

unfreezeonroundend() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8A7B0EDA8FB90C908071386FC16FD8C7");
  level waittill("_encstr_8CBD0DDE3DB33D51871F70886BD3A8");
  scripts\cp\utility::_freezecontrols(0);
}

checkgesturethread() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_99920C3D92FAE9EE6F73A0C06FAC");
  waitframe();

  if(isDefined(self.gestureweapon) && self isgestureplaying(self.gestureweapon))
    self stopgestureviewmodel(self.gestureweapon, 0.05, 1);
}

enableburnfx(var_0, var_1) {
  if(!isDefined(self.burnfxenabled))
    self.burnfxenabled = 0;

  if(self.burnfxenabled == 0) {
    if(!istrue(var_0))
      thread enableburnsfx();

    thread startburnfx(var_1);
  }

  self.burnfxenabled++;
}

enableburnsfx() {
  if(!isDefined(self.burnsfxenabled))
    self.burnsfxenabled = 0;

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
    self.burnsfx linkTo(self);
    self.burnsfx scripts\cp_mp\ent_manager::registerspawncount(1);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    self.burnsfx playLoopSound("_encstr_A1E01D0F7F11DB672AA081E8B05023B904345A9FF1814628F0F77F50B54ECB");
    self.burnsfxenabled = 1;
  }
}

enableburnfxfortime(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_96410C3F94AFF8D6E3B39318A8A3");
  thread enableburnfx();
  wait(var_0);
  thread disableburnfx();
}

disableburnfx(var_0) {
  if(self.burnfxenabled == 1) {
    thread stopburnfx();

    if(!istrue(var_0))
      thread disable_burnsfx();
  }

  self.burnfxenabled--;
}

disable_burnsfx() {
  if(!isDefined(self.burnsfxenabled))
    self.burnsfxenabled = 0;

  wait 0.5;

  if(self.burnsfxenabled == 1) {
    self playSound("_encstr_BA7A21F4175AA9AE2D875050F377C3BF92BCEE7561F24DD105B7C130DF821807CAE56D");

    if(isDefined(self.burnsfx)) {
      self.burnsfx scripts\cp_mp\ent_manager::deregisterspawn();
      wait 0.15;

      if(isDefined(self.burnsfx)) {
        self.burnsfx stoploopsound("_encstr_A1E01D0F7F11DB672AA081E8B05023B904345A9FF1814628F0F77F50B54ECB");
        self.burnsfx delete();
      }
    }

    self.burnsfxenabled = 0;
  }
}

supressburnfx(var_0) {
  if(!isDefined(self.burnfxsuppressed))
    self.burnfxsupressed = 0;

  if(var_0)
    self.burnfxsuppressed++;
  else
    self.burnfxsuppressed--;
}

clearburnfx() {
  thread stopburnfx();
  self.burnfxenabled = undefined;
  self.burnfxsuppressed = undefined;
  self.burnfxplaying = undefined;
}

startburnfx(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_88490BB91DDEE009AEC99B8CC2");
  var_1 = "_encstr_930B07BB1B6B3854FF";

  if(isDefined(var_0))
    var_1 = var_0;

  for(;;) {
    var_2 = isDefined(self.burnfxsuppressed) && self.burnfxsuppressed > 0;
    var_3 = istrue(self.burnfxplaying);

    if(var_2 && var_3) {
      self setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_A7A408B9CA5D1D4E2C63");
      self.burnfxplaying = undefined;
    } else if(!var_2 && !var_3) {
      self setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", var_1);
      self.burnfxplaying = 1;
    }

    waitframe();
  }
}

stopburnfx() {
  self notify("_encstr_88490BB91DDEE009AEC99B8CC2");

  if(istrue(self.burnfxplaying)) {
    self setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_A7A408B9CA5D1D4E2C63");
    self.burnfxplaying = undefined;
  }
}

burnfxcorpstablefunc(var_0) {
  var_0 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", "_encstr_86390885FB5A76780D42", 0);
}

islauncherdirectimpactdamage(var_0, var_1, var_2) {
  if(var_0.type != "_encstr_96390B3F9BB7FCA569EBAB6AD5")
    return 0;

  if(istrue(var_2) && var_0.isalternate && isDefined(var_0.underbarrel))
    return 0;

  return var_1 == "_encstr_A1ED0BA9FF84562B60BA073E83" || var_1 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F" || var_1 == "_encstr_911B0C7DA090E9A7F799FD50DD48";
}

isthrowingknife(var_0) {
  var_1 = undefined;

  if(issameweapon(var_0)) {
    if(nullweapon(var_0))
      return 0;

    var_1 = var_0.basename;
  } else {
    if(var_0 == "_encstr_8BBA05185F8B99")
      return 0;

    var_1 = var_0;
  }

  return issubstr(var_1, "_encstr_92590EFBF91ED25750D8D7DC30B88E8A");
}

minigun_track_target_think() {
  var_0 = self getcurrentweapon();

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0.basename == "_encstr_8BBA05185F8B99") {
    return;
  }
  if(!self hasweapon(var_0)) {
    return;
  }
  var_0 = var_0 getnoaltweapon();
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  if(!scripts\cp\utility::isriotshield(var_0.basename)) {
    if(!self anyammoforweaponmodes(var_0)) {
      return;
    }
    var_1 = self getweaponammoclip(var_0, "_encstr_8253060E2B5FE330");
    var_2 = self getweaponammoclip(var_0, "_encstr_A5AD056A019C63");

    if(!var_1 && !var_2) {
      return;
    }
    var_3 = self getweaponammostock(var_0);
    var_4 = weaponmaxammo(var_0);

    if(var_3 > var_4)
      var_3 = var_4;

    var_5 = self dropitem(var_0);

    if(!isDefined(var_5)) {
      return;
    }
    if(istrue(level.clearstockondrop))
      var_3 = 0;

    var_5 itemweaponsetammo(var_1, var_3, var_2);
  } else {
    var_5 = self dropitem(var_0);

    if(!isDefined(var_5)) {
      return;
    }
    var_5 itemweaponsetammo(1, 1, 0);
  }

  var_5.owner = self;
  var_5.targetname = "_encstr_AD580F5F2388E9EB57322E3069A1074090";
  var_5.objweapon = var_0;
  var_5 sethintdisplayrange(96);
  var_5 setuserange(96);
  var_5 thread scripts\cp\cp_weapon::watchweaponpickup();
  var_5 thread lap();
  return var_5;
}

lap() {
  self endon("_encstr_AD75063D571AE108");
  wait 60;

  if(!isDefined(self)) {
    return;
  }
  self delete();
}

_id_13A3A(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = var_0 getweaponslistprimaries();

  foreach(var_6 in var_4) {
    if(nullweapon(var_6)) {
      continue;
    }
    if(scripts\cp\utility::isriotshield(var_6)) {
      var_1 = var_6;

      if(isnullweapon(var_1, var_0 getcurrentprimaryweapon()))
        var_2 = 1;

      continue;
    }

    if(!isDefined(var_3)) {
      var_7 = var_6 getnoaltweapon();

      if(var_7.inventorytype != "_encstr_BA7F0830B3A7859B60B0") {
        continue;
      }
      var_3 = var_6;
    }
  }

  if(isDefined(var_1)) {
    var_0 _takeweapon(var_1);
    var_0._id_12D53 = var_1;
    var_0._id_12D4F = var_2;
    var_0 scripts\cp\cp_weapon::riotshieldonweaponchange(var_3);
    var_0 notify("_encstr_92D81C7A4079EB96CBE5757F1D0F9DD9B76013CB0F643D115DF1ED436BF4");
    var_0 endon("_encstr_92D81C7A4079EB96CBE5757F1D0F9DD9B76013CB0F643D115DF1ED436BF4");
    var_0 childthread forcevalidweapon(var_3);
  }
}