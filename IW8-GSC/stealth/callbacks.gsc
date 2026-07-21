/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: stealth\callbacks.gsc
***********************************************/

init_callbacks() {
  level.global_callbacks = [];

  foreach(var_1 in ["_encstr_A21A17F52CAEA37BE6C267B2FA6EE8ACC28D8E0DD80D95B1B6", "_encstr_8CC21BFA3858E89CED63D7599B19BDE6AF6EC1BD47D1AC46D7CC8D0B3B", "_encstr_97D41917937AFFBFD5F88BE187D30F9E8C5301B97959DC39B34953", "_encstr_84A41566D4F4F025692F6B690B317BF884AFEED97B5650"])
  level.global_callbacks[var_1] = ::global_empty_callback;

  scripts\engine\utility::flag_init("_encstr_AA14106E4795B063A31AFADC38F6A31D95C8");
  scripts\engine\utility::flag_init("_encstr_A7291037E8CAB08D470DF5CACD8598C6AC46");
  scripts\engine\utility::flag_init("_encstr_9A8D14CDD1CA161B3A0D7D6BBAE6B4D8FAE016EA6E56");
}

global_empty_callback(var_0, var_1, var_2, var_3, var_4) {}

stealth_get_func(var_0) {
  if(isDefined(self.stealth) && isDefined(self.stealth.funcs) && isDefined(self.stealth.funcs[var_0]))
    return self.stealth.funcs[var_0];

  if(isDefined(level.stealth) && isDefined(level.stealth.funcs))
    return level.stealth.funcs[var_0];

  return undefined;
}

stealth_call(var_0, var_1, var_2, var_3) {
  var_4 = stealth_get_func(var_0);

  if(isDefined(var_4)) {
    if(isDefined(var_3))
      return self[[var_4]](var_1, var_2, var_3);
    else if(isDefined(var_2))
      return self[[var_4]](var_1, var_2);
    else if(isDefined(var_1))
      return self[[var_4]](var_1);
    else
      return self[[var_4]]();
  }

  return undefined;
}

stealth_call_thread(var_0, var_1, var_2, var_3) {
  var_4 = stealth_get_func(var_0);

  if(isDefined(var_4)) {
    if(isDefined(var_3))
      return self thread[[var_4]](var_1, var_2, var_3);
    else if(isDefined(var_2))
      return self thread[[var_4]](var_1, var_2);
    else if(isDefined(var_1))
      return self thread[[var_4]](var_1);
    else
      return self thread[[var_4]]();
  }

  return undefined;
}