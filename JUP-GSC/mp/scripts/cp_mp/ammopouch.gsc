/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\ammopouch.gsc
***********************************************/

#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\throttle;
#using scripts\engine\utility;
#namespace ammopouch;

function init_ammopouch() {
  if(isDefined(level.var_51a717822d1c33ec)) {
    return;
  }

  ammopouchbundle = getscriptbundle("ammopouch:ob_ammopouch");

  if(!isDefined(ammopouchbundle)) {
    ammopouchbundle = spawnStruct();
  }

  if(!isDefined(ammopouchbundle.var_3b760769fcea9a1b)) {
    ammopouchbundle.var_3b760769fcea9a1b = 0;
  }

  if(!isDefined(ammopouchbundle.var_5b58d174043df880)) {
    ammopouchbundle.var_5b58d174043df880 = 0;
  }

  if(!isDefined(ammopouchbundle.var_35145aba819a27cf)) {
    ammopouchbundle.var_35145aba819a27cf = 0;
  }

  if(!isDefined(ammopouchbundle.var_9524b7441fcd67dd)) {
    ammopouchbundle.var_9524b7441fcd67dd = 0;
  }

  if(!isDefined(ammopouchbundle.despawntime)) {
    ammopouchbundle.despawntime = 0;
  }

  if(!isDefined(ammopouchbundle.var_7810776678df93b)) {
    ammopouchbundle.var_7810776678df93b = 0;
  }

  if(!isDefined(ammopouchbundle.var_8b2952cde702ebf0)) {
    ammopouchbundle.var_8b2952cde702ebf0 = 0;
  }

  level callback::add("on_zombie_ai_killed", &on_zombie_ai_killed);
  level callback::add("on_ai_killed", &function_1ebeccaabab5d730);
  level.var_51a717822d1c33ec = spawnStruct();
  level.var_51a717822d1c33ec.ammopouchitem = getDvar(@ "hash_11e478dc0bc578b6", ammopouchbundle.ammopouchitem);
  level.var_51a717822d1c33ec.var_3b760769fcea9a1b = getdvarint(@ "hash_41e78dd1cf3aa3cd", ammopouchbundle.var_3b760769fcea9a1b);
  level.var_51a717822d1c33ec.var_5b58d174043df880 = getdvarint(@ "hash_bf61fbbb18eabf5a", ammopouchbundle.var_5b58d174043df880);
  level.var_51a717822d1c33ec.var_35145aba819a27cf = getdvarint(@ "hash_41273749d9cc6c49", ammopouchbundle.var_35145aba819a27cf);
  level.var_51a717822d1c33ec.var_9524b7441fcd67dd = getdvarint(@ "hash_d7292eb724f87753", ammopouchbundle.var_9524b7441fcd67dd);
  level.var_51a717822d1c33ec.despawntime = getdvarint(@ "hash_f8b082a91c737253", ammopouchbundle.despawntime);
  level.var_51a717822d1c33ec.var_7810776678df93b = getdvarint(@ "hash_157b1363637d685d", ammopouchbundle.var_7810776678df93b);
  level.var_51a717822d1c33ec.var_8b2952cde702ebf0 = getdvarint(@ "hash_5c74d9319b59a7f3", ammopouchbundle.var_8b2952cde702ebf0);
  level.var_51a717822d1c33ec.var_355ac76ecfc273ca = getdvarint(@ "hash_c4724b5c84bb6964", ammopouchbundle.var_355ac76ecfc273ca);
  level.var_51a717822d1c33ec.var_d670718214e1bf33 = getdvarint(@ "hash_3f620950bc6216d9", ammopouchbundle.var_d670718214e1bf33);
  level.var_51a717822d1c33ec.lootid = function_6d15e119c2779a93(getscriptbundle("itemspawnentry:ob_jup_item_ammo"));
  level.var_1a5ebdebba7cebb7 = throttle_initialize("ammopouch_drop", 1, level.framedurationseconds);
  utility::registersharedfunc("ammo_item", "can_refill_ammo", &can_refill_ammo);
  utility::registersharedfunc("ammo_item", "refill_ammo", &refill_ammo);
}

function function_3af8e1abc2693305() {
  function_900f562c61c6a5d6("ammo", &refill_ammo, &can_refill_ammo, &can_refill_ammo);
}

function on_zombie_ai_killed(sparams) {
  if(isPlayer(sparams.eattacker) && !istrue(self.var_7e4b076a06c6df27)) {
    function_da6722b81ec7cdc4(sparams.smeansofdeath, sparams.eattacker);
  }
}

function function_1ebeccaabab5d730(sparams) {
  if(isPlayer(sparams.eattacker)) {
    if(self.unittype == "soldier") {
      function_da6722b81ec7cdc4(sparams.smeansofdeath, sparams.eattacker);
    }
  }
}

function function_da6722b81ec7cdc4(smeansofdeath, eattacker) {
  if(istrue(self.var_7e4b076a06c6df27) || istrue(self.var_a9cfabe3e558f7fa) || !getdvarint(@ "hash_ab61a3c338b17bdf", 1)) {
    return;
  }

  if(!isDefined(level.var_51a717822d1c33ec.ammopouchitem)) {
    return;
  }

  unittype = self.unittype;
  origin = self.origin;
  angles = self.angles;
  drop_event = spawnStruct();
  function_f632348cbb773537(level.var_1a5ebdebba7cebb7, drop_event);
  percentchancedrop = 0;

  if(isDefined(smeansofdeath) && smeansofdeath == "MOD_EXECUTION") {
    if(unittype == "soldier") {
      percentchancedrop = level.var_51a717822d1c33ec.var_d670718214e1bf33;
    } else {
      percentchancedrop = level.var_51a717822d1c33ec.var_9524b7441fcd67dd;
    }
  } else if(unittype == "soldier") {
    percentchancedrop = level.var_51a717822d1c33ec.var_355ac76ecfc273ca;
  } else {
    percentchancedrop = level.var_51a717822d1c33ec.var_3b760769fcea9a1b;

    if(isfunction(level.var_8241e0d86017df29)) {
      regiondifficulty = [[level.var_8241e0d86017df29]](origin);

      if(regiondifficulty == "difficulty_normal") {
        percentchancedrop = level.var_51a717822d1c33ec.var_5b58d174043df880;
      } else if(regiondifficulty == "difficulty_hard" || regiondifficulty == "difficulty_darkaether") {
        percentchancedrop = level.var_51a717822d1c33ec.var_35145aba819a27cf;
      }
    }
  }

  if(getdvarint(@ "hash_c07d7234e05a5d98", 0)) {
    percentchancedrop = 100;
  }

  if(percent_chance(percentchancedrop)) {
    itembundle = getscriptbundle("itemspawnentry:" + level.var_51a717822d1c33ec.ammopouchitem);
    item = function_c465d27f3f6066b4(itembundle, origin, angles);
    params = {
      #itemname: level.var_51a717822d1c33ec.ammopouchitem, #itembundle: itembundle, #item: item, #eattacker: eattacker
    };
    callback::callback("on_ammo_pouch_drop", params);
  }
}

function can_refill_ammo(item_def, item, auto_pickup, var_d3c1dfe8dea4ec26) {
  if(!isPlayer(self)) {
    return false;
  }

  var_12a372e8caa042bb = self getweaponslist("primary");

  foreach(var_1fec144a6ac99a70 in var_12a372e8caa042bb) {
    if(istrue(var_1fec144a6ac99a70.ismelee)) {
      continue;
    }

    if(istrue(iskillstreakweapon(var_1fec144a6ac99a70))) {
      continue;
    }

    if(self getweaponammostock(var_1fec144a6ac99a70) < weaponmaxammo(var_1fec144a6ac99a70)) {
      return true;
    }

    if(var_1fec144a6ac99a70.basename == "jup_jp23_me_spear_mp") {
      if(self getweaponammoclip(var_1fec144a6ac99a70) < weaponmaxammo(var_1fec144a6ac99a70)) {
        return true;
      }
    }
  }

  return false;
}

function refill_ammo(item_def, item) {
  if(!isPlayer(self)) {
    return true;
  }

  var_12a372e8caa042bb = self getweaponslist("primary");

  foreach(var_1fec144a6ac99a70 in var_12a372e8caa042bb) {
    if(istrue(var_1fec144a6ac99a70.ismelee)) {
      continue;
    }

    if(istrue(iskillstreakweapon(var_1fec144a6ac99a70))) {
      continue;
    }

    maxstockammo = weaponmaxammo(var_1fec144a6ac99a70);
    currentstockammo = self getweaponammostock(var_1fec144a6ac99a70);
    normalpercent = level.var_51a717822d1c33ec.var_7810776678df93b / 100;
    wonderpercent = level.var_51a717822d1c33ec.var_8b2952cde702ebf0 / 100;
    var_4b69c8548dff97d6 = scripts\cp_mp\weapon::iswonderweapon(var_1fec144a6ac99a70);
    var_9c197a81c3a2c5c0 = 0;

    if(var_4b69c8548dff97d6) {
      var_9c197a81c3a2c5c0 = maxstockammo * wonderpercent;
    } else {
      var_9c197a81c3a2c5c0 = maxstockammo * normalpercent;
    }

    var_9c197a81c3a2c5c0 = max(var_9c197a81c3a2c5c0, 1);

    if(var_1fec144a6ac99a70.basename == "jup_jp23_me_spear_mp") {
      var_9c197a81c3a2c5c0 = 3;
    }

    totalammo = currentstockammo + var_9c197a81c3a2c5c0;
    totalammo = clamp(totalammo, 0, maxstockammo);
    totalammo = int(totalammo);
    self setweaponammostock(var_1fec144a6ac99a70, totalammo);
  }

  return false;
}