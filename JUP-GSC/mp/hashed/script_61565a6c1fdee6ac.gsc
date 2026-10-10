/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_61565a6c1fdee6ac.gsc
*************************************************/

#using scripts\mp\gametypes\br_pickups;
#namespace namespace_27e634277336b001;

function function_e1b062a375b4a629() {
  return self.plundercount;
}

function function_91b0046262bd8519() {
  return getdvarint(@ "scr_br_plunder_start_amount", 0);
}

function function_e22745f1660c79de(var_e318e240dd21247, position, cashamount) {
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo(position);

  if(!isDefined(cashamount) && isDefined(level.br_pickups.counts[var_e318e240dd21247])) {
    cashamount = level.br_pickups.counts[var_e318e240dd21247];
  }

  item = scripts\mp\gametypes\br_pickups::spawnpickup(var_e318e240dd21247, dropinfo, cashamount);

  if(!isDefined(item)) {
    return;
  }

  return item;
}

function function_72c1ec67d589d251(callback, cashitem) {
  self endon("death_or_disconnect");

  if(isDefined(cashitem)) {
    level waittill("pickedupweapon_kill_callout_" + cashitem.type + cashitem.origin);
  } else {
    self waittill("self_pickedupitem_" + "plunder");
  }

  self[[callback]]();
}

function function_ad5378568b077260(cashitem) {
  if(!isDefined(cashitem)) {
    return false;
  }

  itemtype = cashitem.type;
  itemstate = cashitem getscriptablepartstate(itemtype);
  return itemstate != "hidden";
}

function function_a380cf8dd38a32ee(params) {
  assert(isDefined(params));
  assert(isDefined(params.amount));
  return function_8635d35b49720a75(params.amount);
}

function function_8635d35b49720a75(amount) {
  return self.plundercount * 10 >= amount;
}