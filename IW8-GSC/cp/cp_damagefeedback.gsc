/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_damagefeedback.gsc
***********************************************/

init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["_encstr_A5AE098ADB583E0AF7A5AB"] = 40;
  level.hitmarkerpriorities["_encstr_A9950FF76456783587DB7983E3137DC8AF"] = 50;
  level.hitmarkerpriorities["_encstr_A2FB098A2035874AB0F358"] = 30;
}

gethitmarkerpriority(var_0) {
  if(!isDefined(level.hitmarkerpriorities[var_0]))
    return 0;

  return level.hitmarkerpriorities[var_0];
}

hudicontype(var_0) {
  var_1 = 0;

  if(isDefined(level.damagefeedbacknosound) && level.damagefeedbacknosound)
    var_1 = 1;

  if(!isPlayer(self)) {
    return;
  }
  switch (var_0) {
    case "_encstr_93370DD84E7B9B9BC4B77731F61B1D":
    case "_encstr_A60E08C1271BEF21A882":
    case "_encstr_AF460A7B2649F34FE367455D":
    case "_encstr_92590EFBF91ED25750D8D7DC30B88E8A":
      if(!var_1)
        self playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");

      if(!level.hardcoremode)
        self setclientomnvar("_encstr_889E1623C2AD85B3ACEB332BB29126586CADF5BD1D342B93", var_0);

      break;
    case "_encstr_B14A099517387D382D9B9D":
      if(!level.hardcoremode)
        self setclientomnvar("_encstr_889E1623C2AD85B3ACEB332BB29126586CADF5BD1D342B93", var_0);

      break;
    case "_encstr_84AE0CDCBA07E02795B9CDB4BDE6":
      var_0 = "_encstr_84AE0CDCBA07E02795B9CDB4BDE6";

      if(!level.hardcoremode)
        self setclientomnvar("_encstr_889E1623C2AD85B3ACEB332BB29126586CADF5BD1D342B93", var_0);

      break;
  }
}

process_damage_feedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = isDefined(var_1) && isDefined(var_1.classname) && isDefined(var_1.classname) && !isDefined(var_1.gunner) && (var_1.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56" || var_1.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E" || var_1.classname == "_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
  var_12 = undefined;

  if(var_11 && isDefined(var_1.gunner))
    var_12 = var_1.gunner;
  else if(isDefined(var_1) && isDefined(var_1.owner))
    var_12 = var_1.owner;
  else
    var_12 = var_1;

  var_13 = scripts\engine\utility::isbulletdamage(var_4);
  var_14 = scripts\engine\utility::ter_op(var_13 && scripts\cp\cp_weapon::isprimaryweapon(var_5), "_encstr_A9950FF76456783587DB7983E3137DC8AF", "_encstr_A5AE098ADB583E0AF7A5AB");
  var_15 = 0;

  if(isDefined(var_1) && isDefined(var_1.class) && var_1.class == "_encstr_8CFF09D56D88EC030D69EB") {
    if(isDefined(var_4) && scripts\engine\utility::isbulletdamage(var_4))
      var_15 = 1;
  }

  if(isDefined(var_12) && var_12 != var_10 && var_2 > 0 && (!isDefined(var_8) || var_8 != "_encstr_A32D07CFD14BAA94D0")) {
    var_16 = !var_10 scripts\cp_mp\utility\player_utility::_isalive() || isagent(var_10) && var_2 >= var_10.health;

    if(istrue(var_10.isjuggernaut))
      var_14 = "_encstr_9A1B0E432D3A9AEA76B35939DC855DA3";
    else if(var_3 &level.idflags_stun)
      var_14 = "_encstr_9B1905D3B92BF0";
    else if(scripts\cp\cp_damage::istacticaldamage(var_5, var_4) && var_10 scripts\cp\utility::_hasperk("_encstr_8BC01A138148BECFDFF83B13662E73F3C877AA8D1F40C2E3F79042DA"))
      var_14 = "_encstr_8D760DB8F77343CF62BEB7E3D01013";
    else if(isexplosivedamagemod(var_4) && var_10 scripts\cp\utility::_hasperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19") && !scripts\cp\cp_damage::damage_should_ignore_blast_shield(var_1, var_10, var_5, var_4, var_0, var_8))
      var_14 = "_encstr_A3450F0B299309911663F8F8EA2C4B8D0B";
    else if(!var_15 && scripts\cp\cp_modular_spawning::is_armored())
      var_14 = "_encstr_A5D20E0DD2E8C2C9D6F627D09516675E";
    else if(var_10 scripts\cp\utility::_hasperk("_encstr_95AA16DC1C95C62D0BC6E8E5EB832DB9A37BB13259164743") && isDefined(var_10.inlaststand) && var_10.inlaststand == 1 && !var_10.hasshownlaststandicon) {
      var_10.hasshownlaststandicon = 1;
      var_14 = "_encstr_BEF30DDC48FB9D412091E803212033";
    }

    if(isDefined(var_10.playerforcespawn) && var_10.playerforcespawn.size > 1)
      var_14 = "_encstr_97B50E2F204EDAFA69036611FE338296";

    var_17 = "_encstr_A5AE098ADB583E0AF7A5AB";
    var_18 = weaponclass(var_5);
    var_19 = var_18 == "_encstr_A1100738A33A638123";
    var_20 = !var_19 && scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);
    var_21 = 1;
    var_22 = var_4 == "_encstr_8DED0A21C79B660BC7588981";
    var_23 = "_encstr_B40101" + gettime();

    if(!var_22 && var_19 && isDefined(var_12.pelletdmg) && isDefined(var_12.pelletdmg[var_23]) && isDefined(var_12.pelletdmg[var_23][var_10.guid]) && var_12.pelletdmg[var_23][var_10.guid] > 1) {
      if(var_16)
        var_22 = 1;
      else
        var_21 = 0;
    }

    var_24 = undefined;

    if(var_10.health <= var_2)
      var_24 = 1;

    var_20 = scripts\cp\utility::isheadshot(var_5, var_8, var_4, var_1);

    if(var_21) {
      if(isDefined(var_1)) {
        if(isDefined(var_1.owner))
          var_1.owner thread updatedamagefeedback(var_14, var_24, var_2, var_20, 0, var_1, var_0, var_1, 0);
        else
          var_1 thread updatedamagefeedback(var_14, var_24, var_2, var_20, 0, var_1, var_0, var_1, 0);
      }
    }
  }
}

updatedamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(level.friendly_damage_check) && [[level.friendly_damage_check]](var_5, var_6, var_7)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(var_0))
    var_0 = "_encstr_A5AE098ADB583E0AF7A5AB";

  if(!isDefined(var_8))
    var_8 = 0;

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !var_8) {
    if(!isDefined(self.hitmarkeraudioevents))
      self.hitmarkeraudioevents = 0;

    self.hitmarkeraudioevents++;
    self setclientomnvar("_encstr_B8261AF3E81F843F1B39E9F2C2C1AB818B906A8A7047BF0B1190E40B", self.hitmarkeraudioevents % 16);
  }

  switch (var_0) {
    case "_encstr_8BBA05185F8B99":
      break;
    case "_encstr_8B5E0C1A5A3A1B4ED2A3D28D58D8":
      var_0 = "_encstr_A5AE098ADB583E0AF7A5AB";
      var_3 = 1;
      break;
    case "_encstr_9BBE0D68BBC8F5CFC0D3C34AB8A83F":
    case "_encstr_97E1140D4B1DD02B1BADCA47D05685D9BC89C92B2C6D":
    case "_encstr_86720FB00B78C477D140A2BB08BD9FBBF8":
    case "_encstr_815B14691FFB8BE8A4957953FD99C03353ABD58BD7D2":
    case "_encstr_8CFE0FD86310AC2F89689A9350536FE4A8":
    case "_encstr_877C137A510C205EBD10AE68F7925401F28B2FE1EC":
    case "_encstr_A24E13F383755A3A28D0AA3508207843C60D4F4F6F":
    case "_encstr_A7CA0E78BC497703A3606DD843979453":
    case "_encstr_8C1110C4F078ACF37829635F571BABE4A8D8":
    case "_encstr_A6EC0EF149031025DB5AC8D1324FE8F8":
    case "_encstr_994F100430B86B13BFE7BB3B15509BB5D83B":
    case "_encstr_BEF30DDC48FB9D412091E803212033":
    case "_encstr_A5D20E0DD2E8C2C9D6F627D09516675E":
    case "_encstr_A3450F0B299309911663F8F8EA2C4B8D0B":
    case "_encstr_8D760DB8F77343CF62BEB7E3D01013":
    case "_encstr_9A1B0E432D3A9AEA76B35939DC855DA3":
    case "_encstr_A2FB098A2035874AB0F358":
      if(!istrue(var_1)) {
        self setclientomnvar("_encstr_923E15B9113560D4F7A999E112AB1E28CE63473BBB1DC0", var_0);
        self setclientomnvar("_encstr_84E21C0A61F9D78F70DF0E15B3A0161F16D831428940B3C9409714115D60", gettime());
      }

      break;
    default:
      break;
  }

  updatehitmarker(var_0, var_3, var_2, var_4, var_1, 0);
}

updatehitmarker(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 == "_encstr_B40101")
    var_0 = "_encstr_A5AE098ADB583E0AF7A5AB";

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_4))
    var_4 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isPlayer(self)) {
    if(isDefined(self.owner) && isPlayer(self.owner))
      return;
  }

  var_6 = gethitmarkerpriority(var_0);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && var_6 <= self.lasthitmarkerpriority && !var_4) {
    return;
  }
  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = var_6;
  self setclientomnvar("_encstr_92E710499EA5C07C82A72D2367BA361843F4", var_0);
  self setclientomnvar("_encstr_8CD4175A10C34E8FA1A8669D5D69539607E85172F89904D31A", gettime());

  if(var_4)
    self setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 1);
  else
    self setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 0);

  if(var_1)
    self setclientomnvar("_encstr_A70B19D1794D18BC9FF13159BA73E6C066DB1F41E53678FE93EA8B", 1);
  else
    self setclientomnvar("_encstr_A70B19D1794D18BC9FF13159BA73E6C066DB1F41E53678FE93EA8B", 0);

  if(var_5)
    self setclientomnvar("_encstr_927C1ACB9BE1423760AEA76F81237A1A4E279F6B1F989BE478721FB2", 1);
  else
    self setclientomnvar("_encstr_927C1ACB9BE1423760AEA76F81237A1A4E279F6B1F989BE478721FB2", 0);

  if(isDefined(var_2))
    self setclientomnvar("_encstr_AB9311F5E851613F47F087E54E97D0B850CDED", int(var_2));
}