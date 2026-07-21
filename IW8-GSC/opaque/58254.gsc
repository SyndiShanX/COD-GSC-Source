/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58254.gsc
***********************************************/

emp_init() {
  scripts\mp\utility\sound::besttime("_encstr_BE450E3276A6DF1DA1C1423A23D757D3");
}

morsenumber(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_0 thread scripts\mp\utility\script::notifyafterframeend("_encstr_AD75063D571AE108", "_encstr_91A50C1BA8D2A87053EA5E01420B");
  var_0 waittill("_encstr_860808CB78E2984063BA", var_1);
  var_2 = scripts\cp_mp\emp_debuff::get_emp_ents();
  var_3 = getcompleteweaponname("_encstr_A79A0E6D85DB6739B15BF89063F73071");

  foreach(var_5 in var_2) {
    var_6 = var_5.owner;

    if(isDefined(var_6)) {
      if(var_6 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var_6))
        continue;
    }

    var_7 = distancesquared(var_1, var_5.origin);

    if(var_7 > 262144) {
      continue;
    }
    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var_5, 1, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_0, var_1);
    thread calchelicoptertrailpoint(var_8);
  }

  var_10 = scripts\mp\utility\player::getplayersinradius(var_1, 512);

  foreach(var_12 in var_10) {
    if(!var_12 scripts\cp_mp\emp_debuff::can_emp_player()) {
      continue;
    }
    if(var_12 != self && !scripts\cp_mp\utility\player_utility::playersareenemies(self, var_12)) {
      continue;
    }
    var_8 = scripts\cp_mp\utility\damage_utility::packdamagedata(self, var_12, 1, var_3, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", var_0, var_1);
    thread calchelicoptertrailpoint(var_8);
  }
}

_encstr_82FF17E1D9A3A30708F3404E8B080CEF59D1EBFAA285573F60(var_0) {
  if(isDefined(var_0.classname) && var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    if(var_0 tagexists("_encstr_8864130B408791D7F0845946ADFE93E04F8082A210"))
      return ["_encstr_8864130B408791D7F0845946ADFE93E04F8082A210"];
    else if(var_0 tagexists("_encstr_A52E11F090643D2F4E607B72C307EFE3BBB8E8"))
      return ["_encstr_A52E11F090643D2F4E607B72C307EFE3BBB8E8"];
    else if(var_0 tagexists("_encstr_87E010C65699D1D7E09CED1CBECDD00B3347") && var_0 tagexists("_encstr_8FA6115517C283189FDA8338C2B768CB1A83C1"))
      return ["_encstr_87E010C65699D1D7E09CED1CBECDD00B3347", "_encstr_8FA6115517C283189FDA8338C2B768CB1A83C1"];
    else if(var_0 tagexists("_encstr_8F1E092CC9F71178C01941"))
      return ["_encstr_8F1E092CC9F71178C01941"];
    else if(var_0 tagexists("_encstr_A2B40B8E2C3B7DDB274B9D4B37"))
      return ["_encstr_A2B40B8E2C3B7DDB274B9D4B37"];
  }

  return [];
}

calchelicoptertrailpoint(var_0) {
  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);

  if(!isDefined(var_0.attacker)) {
    return;
  }
  if(!isDefined(var_0.victim)) {
    return;
  }
  var_1 = 6.0;

  if(isPlayer(var_0.victim)) {
    if(var_0.attacker == var_0.victim)
      var_1 = 2.0;

    if(var_0.victim scripts\mp\utility\perk::_hasperk("_encstr_9733153383D563C1D1CA237FE6259ACFE7E085E20FEE93") && var_0.attacker != var_0.victim) {
      var_1 = 3.6;
      var_0.attacker scripts\mp\damagefeedback::updatedamagefeedback("_encstr_8D760DB8F77343CF62BEB7E3D01013", undefined, undefined, undefined, 1);
    }

    var_0.victim playlocalsound("_encstr_A6212017E88BD7FA53A547FF950792A8D388879350812C12D7C80F79733BFB7959F0");
    var_0.victim setsoundsubmix("_encstr_93EF0E1F2846D56259101F96E52FBA8C", 0.1);
    playFXOnTag(scripts\engine\utility::getfx("_encstr_BABE10CAB51CFA0E5693DCBD37FAE6E8EA73"), var_0.victim, "_encstr_813B0D4427B190B37585FBC819FD28");
    thread scripts\mp\gamescore::trackdebuffassistfortime(var_0.attacker, var_0.victim, var_0.objweapon.basename, var_1, "_encstr_99C40CA749E1F16B80389FEB2BB9");
  } else if(isDefined(var_0.victim.classname) && var_0.victim.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
    var_1 = 10.0;
    var_0.victim thread scripts\engine\utility::play_loop_sound_on_entity("_encstr_8FF41FC22393790F37F45F45EBB99CAF52D0DE1D7AAE15A7E30B3ADD0F105F7122");
    var_2 = _encstr_82FF17E1D9A3A30708F3404E8B080CEF59D1EBFAA285573F60(var_0.victim);

    foreach(var_4 in var_2)
    playFXOnTag(scripts\engine\utility::getfx("_encstr_887011CAADC1AF3B2B344BD8B1B2EBCD3AD59B"), var_0.victim, var_4);
  }

  playerzombiesetupkeybindings(var_0, var_1);

  if(isDefined(var_0.victim)) {
    var_0.victim scripts\cp_mp\emp_debuff::remove_emp();

    if(isPlayer(var_0.victim)) {
      var_0.victim stoplocalsound("_encstr_A6212017E88BD7FA53A547FF950792A8D388879350812C12D7C80F79733BFB7959F0");
      var_0.victim playlocalsound("_encstr_928324AD71CBBF677B90DAF2382FDF9B63690F269BB1BBEF5FB0D269C8B352B779CD87DDA0F9");
      var_0.victim clearsoundsubmix("_encstr_93EF0E1F2846D56259101F96E52FBA8C", 1);
      stopFXOnTag(scripts\engine\utility::getfx("_encstr_BABE10CAB51CFA0E5693DCBD37FAE6E8EA73"), var_0.victim, "_encstr_813B0D4427B190B37585FBC819FD28");
    } else if(isDefined(var_0.victim.classname) && var_0.victim.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56") {
      var_0.victim scripts\engine\utility::stop_loop_sound_on_entity("_encstr_8FF41FC22393790F37F45F45EBB99CAF52D0DE1D7AAE15A7E30B3ADD0F105F7122");
      var_0.victim playsoundonmovingent("_encstr_A13E202BDAE0AF9D1623B395D17D9D56864B1BC62BEBC8B49B584CC6CAC8BEB2B946");
      var_2 = _encstr_82FF17E1D9A3A30708F3404E8B080CEF59D1EBFAA285573F60(var_0.victim);

      foreach(var_4 in var_2)
      stopFXOnTag(scripts\engine\utility::getfx("_encstr_887011CAADC1AF3B2B344BD8B1B2EBCD3AD59B"), var_0.victim, var_4);
    }
  }
}

playerzombiesetupkeybindings(var_0, var_1) {
  var_0.victim endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = var_0.victim scripts\engine\utility::waittill_notify_or_timeout_return("_encstr_99C40CA749E1F16B80389FEB2BB9", var_1);
}