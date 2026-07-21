/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment\fulton.gsc
***********************************************/

init() {
  level.play_intro_getin_anim = getdvarint("_encstr_825928BD73B1A573597D1B340B8DC62B733B2BF533D2B18E5693EBDC1AB09CB2917D1623B3B0B9B1ACC8", 1) != 0;
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_95C61377BF300F48A80BF42AE5271DE308C87FC653", ::get_best_heli_struct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_ADD10E0718697F2BED83CC97131362F7", ::_id_11FFC);
}

v_end_pos(var_0) {
  if(!isPlayer(self) || isai(self))
    return 0;

  return self getplayerdata(level.loadoutsgroup, "_encstr_A7E80D18E8583FB2297F4F2DD523F0", "_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_ACC20AC198BB28400319CF53", var_0);
}

updateassassinationdataomnvar(var_0) {
  var_1 = tablelookupbyrow("_encstr_9692123AE47D1BA1588D1B5937D995E6C5D837EC", var_0, 7);
  var_2 = getsystemtime();

  if(var_1 != "_encstr_B40101" && var_2 <= int(var_1))
    return 0;

  return 1;
}

routers_needed(var_0) {
  if(!isDefined(level._id_139E0)) {
    var_1 = "_encstr_87AA1764D77013AE2631636BB88D8B0EF897DFE36BB81A67D8" + level.getallactivequestsforteam + "_encstr_96A70506895E33";
    var_2 = tablelookupgetnumrows(var_1);
    var_3 = [];

    for(var_4 = 1; var_4 < var_2; var_4++)
      var_3[var_4 - 1] = int(tablelookupbyrow(var_1, var_4, 1));

    level._id_139E0 = var_3;
  }

  for(var_5 = 1; var_5 < level._id_139E0.size; var_5++) {
    if(level._id_139E0[var_5] >= var_0) {
      break;
    }
  }

  if(var_5 > level._id_139E0.size)
    var_5 = level._id_139E0.size;

  return var_5;
}

get_best_heli_struct(var_0) {
  var_1 = 0;
  var_2 = tablelookuprownum("_encstr_9692123AE47D1BA1588D1B5937D995E6C5D837EC", 1, var_0);

  if(var_2 >= 0) {
    if(!level.play_intro_getin_anim)
      return 1;

    var_1 = 1;

    if(v_end_pos(var_2))
      return 0;

    if(!updateassassinationdataomnvar(var_2))
      return 0;

    var_3 = tablelookupbyrow("_encstr_9692123AE47D1BA1588D1B5937D995E6C5D837EC", var_2, 2);

    if(var_3 == "_encstr_8B8B096F834C5B2DCB39A4") {
      var_4 = tablelookupbyrow("_encstr_9692123AE47D1BA1588D1B5937D995E6C5D837EC", var_2, 5);

      if(var_4 != "_encstr_B40101") {
        var_5 = scripts\mp\rank::safedivide(var_4);
        var_6 = scripts\mp\weaponrank::rpg_attack_apc(var_5);
        var_7 = tablelookupbyrow("_encstr_9692123AE47D1BA1588D1B5937D995E6C5D837EC", var_2, 4);

        if(var_6 < int(var_7))
          return 0;
      }
    } else if(var_3 == "_encstr_8A140639CDCD2F4B") {
      var_8 = scripts\mp\teams::lookupcurrentoperator(self.team);
      var_9 = tablelookupbyrow("_encstr_9692123AE47D1BA1588D1B5937D995E6C5D837EC", var_2, 6);

      if(isDefined(var_8) && isDefined(var_9) && var_8 != "_encstr_B40101" && var_9 != "_encstr_B40101" && var_8 != var_9)
        return 0;
    }
  } else {
    var_2 = tablelookuprownum("_encstr_A7B51E1AC358039821078D911F78959F11DE72D249413BC7C007858B4D309ABB", 1, var_0);

    if(var_2 >= 0) {
      if(!level.play_intro_getin_anim)
        return 1;

      var_10 = tablelookupgetnumrows("_encstr_9692123AE47D1BA1588D1B5937D995E6C5D837EC");

      if(v_end_pos(var_10 + var_2))
        return 0;

      if(!updateassassinationdataomnvar(var_2))
        return 0;

      var_1 = 1;
      var_11 = tablelookupbyrow("_encstr_A7B51E1AC358039821078D911F78959F11DE72D249413BC7C007858B4D309ABB", var_2, 2);
      var_12 = _func_042B();

      if(var_12 < int(var_11))
        return 0;
    }
  }

  if(!var_1)
    return 0;

  return 1;
}

_id_11FFC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = scripts\mp\damage::playerkilled_initdeathdata(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

  if(scripts\mp\utility\damage::isheadshot(var_12.hitloc, var_12.meansofdeath, var_12.attacker)) {
    var_12.meansofdeath = "_encstr_87280E1FB705D168313D1FD197B1A799";
    var_5 = "_encstr_87280E1FB705D168313D1FD197B1A799";
  }

  if(var_1.classname != "_encstr_BD4E0B7B104D6AD4DB384717A0") {
    var_1 thread scripts\mp\events::cargo_truck_mg_initoccupancy(var_12.lifeid, self, var_6, var_5, var_0, var_12);
    var_13 = 0;
    var_14 = 0;

    if(isDefined(var_1.modifiers)) {
      var_13 = var_1.modifiers["_encstr_87A205AF10734B"];
      var_14 = var_1.modifiers["_encstr_95A40617A8CBC38F"];
    }

    var_2 thread scripts\cp\vehicles\vehicle_compass_cp::_id_11FFC(var_0, var_1, var_3, var_4, var_5, var_6, var_8, var_13, var_14);
  }
}