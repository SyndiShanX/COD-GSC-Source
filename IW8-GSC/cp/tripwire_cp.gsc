/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\tripwire_cp.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_BEDD11FE1EE33A449979E7F3F0B40AD24B3E83", ::tripwire_createhintobject);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_BD6F0C7A617803CA10813C02BB83", ::tripwire_cantriptrap);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_AF050B70D73D618712AF8D18FE", ::tripwire_damagefunc);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_9B61118C3B70B63B4115926BB9B4BF6EC08F0E", ::tripwire_disarmgiveweapon);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_8DC1092BD38BC10B7CC337", "_encstr_B4700D61A8309FE31B8AC07F77AB2B", ::_id_13DD2);
}

tripwire_createhintobject(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
  var_11 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_11.angles = (0, 0, 0);

  if(isDefined(var_5))
    var_11 setuseholdduration(var_5);
  else
    var_11 setuseholdduration("_encstr_BA7610B09BFEB998E2F778C98342BC771BDD");

  if(!isDefined(var_5) || var_5 == "_encstr_BA7610B09BFEB998E2F778C98342BC771BDD" || var_5 == "_encstr_83D40EE5AD13F109BC1A8001C2D5C5C9")
    var_11 sethintrequiresholding(1);

  if(isDefined(var_6))
    var_11 sethintonobstruction(var_6);
  else
    var_11 sethintonobstruction("_encstr_BECC055CF3811A");

  if(isDefined(var_7))
    var_11 sethintdisplayrange(var_7);
  else
    var_11 sethintdisplayrange(200);

  var_11 sethintdisplayfov(65);

  if(isDefined(var_9))
    var_11 setuserange(var_9);
  else
    var_11 setuserange(72);

  if(isDefined(var_10))
    var_11 setusefov(var_10);
  else
    var_11 setusefov(65);

  thread _id_13202();
  level thread scripts\cp\cp_weapon::bankingoverlimitwillendot(self);
  var_3 = &"_encstr_BD30110D05AF9AA225922D8ABC44A291556A51";
  var_11 setHintString(var_3);
  var_11 setCursorHint("_encstr_BA110C20C7C0F307EDF9111CB7A1");
  var_11 makeusable();
  return var_11;
}

_id_13202() {
  self enableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self))
    self disableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");
}

tripwire_cantriptrap(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0))
    return 0;

  if(isPlayer(var_0) && isexplosivedamagemod(var_2) && var_3 > 90)
    return 1;

  if(isPlayer(var_0) && validchallengetimer(var_2) && var_3 > 10)
    return 1;

  if(isPlayer(var_0) && unlockstop(var_0, var_1))
    return 1;

  return 0;
}

validchallengetimer(var_0) {
  if(scripts\engine\utility::isbulletdamage(var_0))
    return 1;

  if(var_0 == "_encstr_9B0D099AD3887D91252954")
    return 1;

  return 0;
}

unlockstop(var_0, var_1) {
  if(var_1.basename == "_encstr_81931411E5B039F5EB6F052B97F3C90B617F7BAE0D18")
    return 1;

  if(var_1.basename == "_encstr_AB64181DDD735E712232B8F8297D2F307768118731CF233FCDAB")
    return 1;

  if(var_1.basename == "_encstr_A90D1FCAAD38AF1927B7B92B7DB9DEE67D0E63C22FB239D7465A93561B3AEBD60E")
    return 1;

  return 0;
}

tripwire_damagefunc(var_0, var_1) {
  var_0 disableplayermarks("_encstr_BE8F0A272F9B2BE97268AE8B");

  if(isDefined(var_1) && isPlayer(var_1))
    radiusdamage(var_0.origin, 384, 256, 40, undefined, "_encstr_AB590C99ED78875F650F3951034D", "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");
  else
    radiusdamage(var_0.origin, 384, 256, 40, undefined, "_encstr_B45C0E2DFF41B17F437FB870E733FBFF", "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B");

  playrumbleonposition("_encstr_85D30FAF13F238C0494D4F4AC323DD0BE9", var_0.origin);
  earthquake(0.45, 0.7, var_0.origin, 800);

  if(isDefined(var_1) && isPlayer(var_1)) {
    if(distancesquared(var_1.origin, var_0.origin) < 250000)
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_1, "_encstr_973610CC1B0BCEDE27F59B2BB32C3A2DEC95", undefined, 1);
  }
}

tripwire_givegrenade(var_0, var_1) {
  var_2 = "_encstr_81580B52FF3F7F3D195A6A61A7";

  if(!isstring(var_0))
    var_2 = createheadicon(var_0);

  switch (var_2) {
    case "_encstr_8A78055C8D488C":
      var_3 = "_encstr_81580B52FF3F7F3D195A6A61A7";
      break;
    case "_encstr_9301076F8808DCFA41":
      var_3 = "_encstr_A76F0D83DB77B239AF372BB54756E1";
      break;
    case "_encstr_8B07036CD0":
      var_3 = "_encstr_8D7C09102FE7216D71A66D";
      break;
    default:
      var_3 = "_encstr_81580B52FF3F7F3D195A6A61A7";
      break;
  }

  var_4 = 0;

  if(isDefined(var_1.powers[var_3]))
    var_4 = var_1.powers[var_3].charges;

  var_5 = scripts\cp\cp_loadout::get_num_of_charges_for_power(var_1, "_encstr_BA7F0830B3A7859B60B0");

  if(var_4 >= var_5)
    var_4 = var_5 - 1;

  var_1 scripts\cp\cp_powers::givepower(var_3, "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, 0, 1, var_4 + 1);
}

tripwire_disarmgiveweapon(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isstring(var_0))
    var_3 = asmdevgetallstates(var_0);

  if(hasequipmentoftype(var_0, var_2) || should_start_cautious_approach_koth(var_2))
    tripwire_givegrenade(var_0, var_2);

  level thread play_disarm_operator_vo(var_2);
}

hasequipmentoftype(var_0, var_1) {
  var_2 = var_0;

  if(isstring(var_0))
    var_2 = asmdevgetallstates(var_0);

  var_3 = var_1.offhandinventory;

  foreach(var_5 in var_3) {
    if(getweaponbasename(var_5) == getweaponbasename(var_2))
      return 1;

    if(getweaponbasename(var_2) == "_encstr_8A78055C8D488C" && getweaponbasename(var_5) == "_encstr_8C4A10BA936F7F31D0159D6ECB304757814B")
      return 1;
  }

  return 0;
}

should_start_cautious_approach_koth(var_0) {
  var_1 = 0;
  var_2 = var_0.offhandinventory;

  foreach(var_4 in var_2) {
    var_5 = scripts\cp\utility::getequipmenttype(getweaponbasename(var_4));

    if(isDefined(var_5)) {
      if(var_5 == "_encstr_B116071BCAD186858D")
        var_1 = 1;
    }
  }

  if(!var_1)
    return 1;

  return 0;
}

issameoffhandtype(var_0, var_1) {
  var_2 = scripts\cp\utility::getequipmenttype(var_0);

  if(!isDefined(var_2))
    return 0;

  if(var_2 == scripts\cp\utility::getequipmenttype(var_1))
    return 1;

  return 0;
}

haslethalequipment(var_0) {
  var_1 = var_0.offhandinventory;

  foreach(var_3 in var_1) {
    var_4 = scripts\cp\utility::getequipmenttype(getweaponbasename(var_3));

    if(isDefined(var_4) && var_4 == "_encstr_B116071BCAD186858D")
      return 1;
  }

  return 0;
}

play_disarm_operator_vo(var_0) {
  if(!isDefined(level.vo_tripwire_next_callout_time) || gettime() > level.vo_tripwire_next_callout_time) {
    level.vo_tripwire_next_callout_time = gettime() + 30000;
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "_encstr_830A1182B0E8FF613D5517CF83C81B22483BFA", undefined, 0.8);
  }
}

_id_13DD2(var_0, var_1) {
  if(isPlayer(var_0) && (var_1 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421" || var_1 == "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B"))
    var_0 thread scripts\cp\cp_achievement::trapachievementboom(var_0);
}