/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1de396bd08617dd4.gsc
*************************************************/

#using scripts\cp_mp\currency;
#using scripts\cp_mp\loot\common_item;
#namespace namespace_f9e8a327d793c098;

function function_b60c68caa2f279ab() {
  if(isDefined(level.var_27475bb0d1b06044)) {
    [[level.var_27475bb0d1b06044]]();
    return;
  }

  function_900f562c61c6a5d6("currency", &use_currency, &function_794ffcdb7828ea7a, &function_794ffcdb7828ea7a);
}

function function_794ffcdb7828ea7a(itembundle, item, auto_use, var_18fc734ec7194ede) {
  return true;
}

function use_currency(itembundle, item, auto_use) {
  currencytype = itembundle.subtype;
  var_3d7ffadeef043c6 = function_b8bfea9514c89a77(item.count);

  if(!isDefined(currencytype) || currencytype == "") {
    itembundlename = function_2cdc55ba39d97d70(item.type);
    assertmsg("<dev string:x1c>" + itembundlename + "<dev string:x55>");
    return false;
  }

  if(currencytype == "essence" && isDefined(self.zombie_point_scalar)) {
    var_3d7ffadeef043c6 *= self.zombie_point_scalar;
  }

  scripts\cp_mp\currency::function_3036cef61495210f(currencytype, var_3d7ffadeef043c6);
  return false;
}