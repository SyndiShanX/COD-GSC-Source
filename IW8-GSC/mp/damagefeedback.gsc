/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\damagefeedback.gsc
***********************************************/

init() {
  level.hitmarkerpriorities = [];
  level.hitmarkerpriorities["_encstr_A5AE098ADB583E0AF7A5AB"] = 40;
  level.hitmarkerpriorities["_encstr_A9950FF76456783587DB7983E3137DC8AF"] = 50;
  level.hitmarkerpriorities["_encstr_879414B9A3C2B991C2938C6EE02795C2322C27ADB7C9"] = 70;
  level.hitmarkerpriorities["_encstr_814B0EC3B18F08B59AB390C120D0B25E"] = 60;
  level.hitmarkerpriorities["_encstr_A2FB098A2035874AB0F358"] = 30;
  level.hitmarkerpriorities["_encstr_91D70CB88F43EBA71A7B4DB37B5D"] = 60;
  level.hitmarkerpriorities["_encstr_AF2311A0734B13E35D20FAE358F51EB3C1EF3B"] = 70;
  level.hitmarkerpriorities["_encstr_92B50AD0A5A3D0CA2C8C1E46"] = 70;
  level.hitmarkerpriorities["_encstr_B48B0F8CB830F8DA37499BBAAD66022960"] = 80;
}

updatedamagefeedback(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isPlayer(self) && !scripts\mp\utility\killstreak::isplayerkillstreak(self)) {
    return;
  }
  if(!isDefined(var_3))
    var_3 = "_encstr_A5AE098ADB583E0AF7A5AB";

  if(!isDefined(var_4))
    var_4 = 0;

  if((!isDefined(level.damagefeedbacknosound) || !level.damagefeedbacknosound) && !var_4) {
    if(!isDefined(self.hitmarkeraudioevents))
      self.hitmarkeraudioevents = 0;

    self.hitmarkeraudioevents++;
    self setclientomnvar("_encstr_B8261AF3E81F843F1B39E9F2C2C1AB818B906A8A7047BF0B1190E40B", self.hitmarkeraudioevents % 16);
  }

  switch (var_0) {
    case "_encstr_8BBA05185F8B99":
      break;
    case "_encstr_A6EC0EF149031025DB5AC8D1324FE8F8":
    case "_encstr_8CFE0FD86310AC2F89689A9350536FE4A8":
    case "_encstr_815B14691FFB8BE8A4957953FD99C03353ABD58BD7D2":
    case "_encstr_A24E13F383755A3A28D0AA3508207843C60D4F4F6F":
    case "_encstr_BE060EE44BE9336D43908F9B88182E1A":
    case "_encstr_B45E1308B3C03EA3D9985BA321231B37C02DBB8D31":
    case "_encstr_9A8218CA430491F6E587B5B80510C86B2742CF7F99AB1B9DF7B2":
    case "_encstr_A7CA0E78BC497703A3606DD843979453":
    case "_encstr_A3450F0B299309911663F8F8EA2C4B8D0B":
    case "_encstr_A5D20E0DD2E8C2C9D6F627D09516675E":
    case "_encstr_9A1B0E432D3A9AEA76B35939DC855DA3":
    case "_encstr_994F100430B86B13BFE7BB3B15509BB5D83B":
    case "_encstr_BEF30DDC48FB9D412091E803212033":
    case "_encstr_BA1A129877094830430AE74AC815EA8048581D93":
    case "_encstr_AA61090D96D13B43BDDCE8":
    case "_encstr_9BBE0D68BBC8F5CFC0D3C34AB8A83F":
    case "_encstr_97E1140D4B1DD02B1BADCA47D05685D9BC89C92B2C6D":
    case "_encstr_86720FB00B78C477D140A2BB08BD9FBBF8":
    case "_encstr_877C137A510C205EBD10AE68F7925401F28B2FE1EC":
    case "_encstr_B48B0F8CB830F8DA37499BBAAD66022960":
    case "_encstr_92B50AD0A5A3D0CA2C8C1E46":
    case "_encstr_AF2311A0734B13E35D20FAE358F51EB3C1EF3B":
    case "_encstr_91D70CB88F43EBA71A7B4DB37B5D":
    case "_encstr_8C1110C4F078ACF37829635F571BABE4A8D8":
    case "_encstr_8D760DB8F77343CF62BEB7E3D01013":
    case "_encstr_A2FB098A2035874AB0F358":
      updatehitmarker(var_3, var_1, var_2, var_5, var_0);
      break;
    default:
      updatehitmarker(var_3, var_1, var_2, var_5);
      break;
  }
}

updatehitmarker(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_5 = gethitmarkerpriority(var_0);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && var_5 <= self.lasthitmarkerpriority && !var_1) {
    return;
  }
  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = var_5;

  if(isDefined(var_4) && !istrue(var_1)) {
    self setclientomnvar("_encstr_923E15B9113560D4F7A999E112AB1E28CE63473BBB1DC0", var_4);
    self setclientomnvar("_encstr_84E21C0A61F9D78F70DF0E15B3A0161F16D831428940B3C9409714115D60", gettime());
  }

  self setclientomnvar("_encstr_92E710499EA5C07C82A72D2367BA361843F4", var_0);
  self setclientomnvar("_encstr_8CD4175A10C34E8FA1A8669D5D69539607E85172F89904D31A", gettime());

  if(var_1)
    self setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 1);
  else
    self setclientomnvar("_encstr_B62E15F14FBDF9279D174395F76140FF80DAB9A2830475", 0);

  if(var_2)
    self setclientomnvar("_encstr_A70B19D1794D18BC9FF13159BA73E6C066DB1F41E53678FE93EA8B", 1);
  else
    self setclientomnvar("_encstr_A70B19D1794D18BC9FF13159BA73E6C066DB1F41E53678FE93EA8B", 0);

  if(var_3)
    self setclientomnvar("_encstr_927C1ACB9BE1423760AEA76F81237A1A4E279F6B1F989BE478721FB2", 1);
  else
    self setclientomnvar("_encstr_927C1ACB9BE1423760AEA76F81237A1A4E279F6B1F989BE478721FB2", 0);
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
  if(var_0 == "_encstr_961904BF105A")
    var_0 = "_encstr_92590EFBF91ED25750D8D7DC30B88E8A";

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
    case "_encstr_8669131DD0E4F6DD2DE6EC5BCDB4CC95FA995AC995":
      if(!var_1)
        self playlocalsound("_encstr_B8151653D6C913796D7967FD87D8DF6FD2AFD28F9680955B");

      if(!level.hardcoremode)
        self setclientomnvar("_encstr_889E1623C2AD85B3ACEB332BB29126586CADF5BD1D342B93", var_0);

      break;
    case "_encstr_84AE0CDCBA07E02795B9CDB4BDE6":
      if(!level.hardcoremode)
        self setclientomnvar("_encstr_889E1623C2AD85B3ACEB332BB29126586CADF5BD1D342B93", var_0);

      break;
    case "_encstr_9BA40B70AB3F538103D5758DAA":
    case "_encstr_925809A3CD88325270F892":
    case "_encstr_97DB08C666DF7205C008":
      if(!level.hardcoremode)
        self setclientomnvar("_encstr_889E1623C2AD85B3ACEB332BB29126586CADF5BD1D342B93", var_0);

      break;
    case "_encstr_A92A14EB473F6A6E6B20DBCBD9A15D73B966B5203D69":
      if(!var_1)
        self playlocalsound("_encstr_85BA1AFAD019B1B371E624218E199BC9C370C3B24029795728DF2B28");

      if(!level.hardcoremode)
        self setclientomnvar("_encstr_889E1623C2AD85B3ACEB332BB29126586CADF5BD1D342B93", var_0);

      break;
    case "_encstr_93B40D630BF305D89F5F2058C78D60":
      if(!level.hardcoremode)
        self setclientomnvar("_encstr_889E1623C2AD85B3ACEB332BB29126586CADF5BD1D342B93", var_0);

      break;
    case "_encstr_A53F0A838B7D471490138184":
      if(!level.hardcoremode)
        self setclientomnvar("_encstr_889E1623C2AD85B3ACEB332BB29126586CADF5BD1D342B93", var_0);

      break;
  }
}