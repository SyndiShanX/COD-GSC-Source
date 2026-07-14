/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\destructible_vehicle.gsc
*************************************************************/

#namespace destructible_vehicle;

function destructible_vehicle_init() {
  thread destructible_vehicle_main();
}

function destructible_vehicle_main() {
  waitframe();
  scriptables = getEntArray("X\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95", #code_classname);

  foreach(scriptable in scriptables) {
    if(issubstr(scriptable.model, "\xea\xdd\xb6\xcc") || issubstr(scriptable.model, "\xcc\xcdn@\x13") || issubstr(scriptable.model, "\xa2\xed\x1f\x9e\xbe")) {
      scriptable thread destructible_vehicle_thread();
    }
  }
}

function destructible_vehicle_thread() {
  self.destructible_type = "\xb3VC-\xc6c\xb2";

  while(true) {
    self waittill("\xe6\x8d'Kp\xa3X\x98\xd8\xac\xc9\xedtK3-\x8da:i\xde\xdc", note, param);

    switch (note) {
      case #"hash_e5776eac05aaee34":
      case #"hash_f292a20224944002":
        thread burningcar_indicator();
        break;
      case #"hash_3b9cb3e6d5ebb052":
      case #"hash_65f8b242ffc4f6e8":
      case #"hash_ac44ea5d34937252":
        self notify("\xf0Q~F\xfc\xae\x7f\xca\xb9");

        if(isDefined(self.burningcarindicator)) {
          self.burningcarindicator delete();
        }

        self.onfire = undefined;
        return;
    }
  }
}

function burningcar_indicator() {
  if(isDefined(self.burningcarindicator)) {
    return;
  }

  self endon("\xf0Q~F\xfc\xae\x7f\xca\xb9");
  self.onfire = 1;
  wait 0.2;
  self.burningcarindicator = magicgrenade("|~\xd6\x1c\xd0T8\x15P\xf6\xe5", self.origin + (0, 0, 10), self.origin, 9999, 0);
  self.burningcarindicator.targetname = "\x7f\x9dRc\x83\xca\xc9\xea$8!d1\x1d\xe0\xf57\xd4\x14";
  self.burningcarindicator makeunusable();
}