/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\equipment\throwing_knife.gsc
***********************************************/

throwing_knife_init() {
  level.throwingknifemaxpickups = getdvarfloat("_encstr_8FC417BB0F581903E393129BD8C897C450E32635E708DB2395", 12);
  level.throwingknifepickuptimeout = getdvarfloat("_encstr_B26A1962E6939FFB1332FFDF9BE04FC2800851DF1BF8181508CDB3", 20);
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_88C5055208731B")]]();
}

throwing_knife_ongive(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_BA6F07F2708FA42359"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_BA6F07F2708FA42359")]](var_0, var_1);
}

throwing_knife_ontake(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_ABCE07DBE61516B6AC"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_ABCE07DBE61516B6AC")]](var_0, var_1);
}

throwing_knife_used(var_0) {
  var_0 makeunusable();

  if(!isDefined(var_0.equipmentref)) {
    if(var_0.weapon_name == "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83")
      var_0.equipmentref = "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC";
    else if(var_0.weapon_name == "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170")
      var_0.equipmentref = "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B";
    else
      var_0.equipmentref = "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381";
  }

  var_1 = undefined;
  var_2 = undefined;
  var_3 = self.name;
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42", var_1, var_2, var_4, var_5, var_6, var_7);
  var_0.surfacetype = var_4;
  level notify("_encstr_8840203B1B679D69DB35F8ED10B3F0578FF2903992BB1D209B5FE0DEF40F9909F38A", var_0, "_encstr_8AF511A30D4EDEDDB4CDB35BE6A5CC2BFA5B83", var_3);
  var_8 = isDefined(var_2) && var_2 == "_encstr_886E14D4EBC9B4B7A3B9435A95368C7DB79999DC2B1D";
  var_9 = isDefined(var_2) && var_2 == "_encstr_8AD30BA3E631B1687D87E39838";
  var_10 = isDefined(var_1) && (isPlayer(var_1) || isagent(var_1));
  var_11 = var_0.weapon_name == "_encstr_960F162D78EBD03757808747D2441CF1E1F7D3A550F9BB83";
  var_12 = var_0.weapon_name == "_encstr_BE851AF4BC20B024C3484117800164B0774058673AC34BF9AFF96170";
  var_13 = var_0.weapon_name == "_encstr_8AF817C568CBE8E754F22078CA6C8DE1270C4E33F41B560BFA";

  if(var_11 || var_12 || var_13) {
    var_0 setscriptablepartstate("_encstr_92ED0B135F227368B503F08934", "_encstr_930B07BB1B6B3854FF", 0);

    if(isDefined(level._id_132A4) && [[level._id_132A4.make_control_station_interaction]](var_0))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_A3E90D4B10F00AB1E8C337D8E49DA8")]](var_0);

    if(var_10 && !var_8) {
      var_0 setscriptablepartstate("_encstr_95450D90D24EEBB1EB61990F21C7DB", "_encstr_878807108A42A309BB", 0);

      if(!isalive(var_1) && var_11) {
        var_14 = relic_healthpacks_killfunc(var_2);

        if(isDefined(var_14)) {
          var_15 = var_1 getcorpseentity();
          var_15 setscriptablepartstate("_encstr_A9B10826EAC9374BCDB3", var_14, 0);
        }
      }
    } else
      var_0 setscriptablepartstate("_encstr_8BA30E27CA20272A0806F9D8832F7FA1", "_encstr_878807108A42A309BB", 0);
  } else
    var_0 setscriptablepartstate("_encstr_BDA80D36947A670CEFF778C8C73780", "_encstr_930B07BB1B6B3854FF", 0);

  var_0 throwing_knife_makepickup();
}

relic_healthpacks_killfunc(var_0) {
  switch (var_0) {
    case "_encstr_9ABB0968F1402B19E2AFA9":
      return "_encstr_81CC0586952C91";
    case "_encstr_AADA07DBF19A4A81D7":
      return "_encstr_81CC0586952C91";
    case "_encstr_BDAB07BA596A43E9EB":
      return "_encstr_81CC0586952C91";
    case "_encstr_813B0D4027B390B37585BBC819FD28":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_83890D9CA8EF0B79D830939788913A":
      return "_encstr_877D06BB570AB0D0";
    case "_encstr_A9B30EA6BECD347BAE3623569CBEC95A":
      return "_encstr_938405854EB592";
    case "_encstr_8BB30ED4AFDC43DEEAB191ACE47DB156":
      return "_encstr_9584051BAA8DB1";
    case "_encstr_A78B0B4D7DAC6398F6DDEB27A5":
      return "_encstr_938405854EB592";
    case "_encstr_8D8B0B309FA99B7EFA735F68F1":
      return "_encstr_9584051BAA8DB1";
    case "_encstr_83190BED4757A3B3B20C5E83E0":
      return "_encstr_938405854EB592";
    case "_encstr_A1190BD4FABB9396DC47EB8DAC":
      return "_encstr_9584051BAA8DB1";
    case "_encstr_AFDD09A6FA864B1CBEC996":
      return "_encstr_99AD05CC2D71D3";
    case "_encstr_AFDD09A6FA864B1CBEB156":
      return "_encstr_ADAD05B9058739";
    case "_encstr_BD500A3C087F4AD519410B6F":
      return "_encstr_99AD05CC2D71D3";
    case "_encstr_AC500A7A366A5BBFC04F9465":
      return "_encstr_ADAD05B9058739";
    case "_encstr_83D50BE2875F1037FDBA096892":
      return "_encstr_99AD05CC2D71D3";
    case "_encstr_A1D50BD4BE2CDC6D36B2EBC695":
      return "_encstr_ADAD05B9058739";
    default:
      return undefined;
  }
}

throwing_knife_makepickup() {
  self makeunusable();
  var_0 = spawn("_encstr_956B0F193B6244C0659AE65B464C78857B", self.origin, 0, 64, 64);
  var_0.targetname = "_encstr_8BB40EE803A7CB21EAAFAF12050245D1";
  var_0 enablelinkTo();
  var_0 linkTo(self);
  self.knife_trigger = var_0;

  if(!isDefined(level.throwingknives))
    level.throwingknives = [];

  var_1 = [self];

  foreach(var_3 in level.throwingknives) {
    if(var_1.size >= level.throwingknifemaxpickups) {
      if(isDefined(var_3))
        var_3 throwing_knife_deletepickup();

      continue;
    }

    if(isDefined(var_3))
      var_1[var_1.size] = var_3;
  }

  level.throwingknives = var_1;
  thread throwing_knife_watchpickup();
  thread throwing_knife_watchpickuptimeout();
}

throwing_knife_watchpickup() {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    self.knife_trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!var_0 hasweapon(self.weapon_object)) {
      continue;
    }
    if(var_0 throwing_knife_trytopickup(self.equipmentref))
      thread throwing_knife_deletepickup();
  }
}

throwing_knife_watchpickuptimeout() {
  self endon("_encstr_AD75063D571AE108");
  wait(level.throwingknifepickuptimeout);

  if(isDefined(self.equipmentref) && self.equipmentref == "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC")
    self playSound("_encstr_811D1983AF6F0347374038695179D76B9632AE1D738B1887FDDDB3");

  thread throwing_knife_deletepickup();
}

throwing_knife_deletepickup() {
  if(isDefined(self.knife_trigger))
    self.knife_trigger delete();

  self delete();
}

throwing_knife_trytopickup(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_99C10CE3C6F341670758978F803B")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8DB70F93D8EE6703A83597A7D7784CBB9D", "_encstr_99C10CE3C6F341670758978F803B")]](var_0);
    return var_1;
  }

  return 1;
}